Return-Path: <netdev+bounces-224975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBDCB8C65E
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 13:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D1558249E
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C942F99BD;
	Sat, 20 Sep 2025 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jCSKAEiH"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5827B32D
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758366034; cv=none; b=m5vexcRL7UBZI5T7JD/hYVbE8pCJndkxkuZst6vPv2aTUaw1X2obZkuynadAa+GWWuNNAvLsdNSlRU3OBg1us6H1qZdHTejZZJErUmeIl/wXgdql3/IEQsHspitK3SldWBGiKFBECNUQdcl5jkUt8QR4CANjQoWOjxSER/0t9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758366034; c=relaxed/simple;
	bh=vn6wekc8HhimoTkV/vtrFFh5WIx0NUu9cEH60S8g/dA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oa6V5PvV2MHBHaAIDkcALuEKdcQXFKWgLi4JfYQpnyT+NxAJ+SZAo+kgrQ7pEwcQze09cL3mfBMRXfA9b+kV9ykE76qquWbOGr0ry7KtWud84bMtp5HGtznVE+n012E4ty8AiXuEnOaMAhDOxbtDUhp9CsxwTsJaKzcEN8g5pHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jCSKAEiH; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758366029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oxROuWqTwkIzJBqY7kPSp42VlM2zvhoq2moWsxXKoLg=;
	b=jCSKAEiHcjx8cwfoRgg5FOZ979J9HDeAafPlusTGElxRSAiV1pr5Z2Ex+vUn/4Xcrsml6L
	hZ4bvlEL/f+tRk85J6hlPGGkYcg/QIPmAPSRcQ00A90nLOO5zYMLjcWOEmoy5kWWQBUaC4
	j9/dK2DMgV6XLZXTGWL/0u6vecGfMk8=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v4 0/3] net: Avoid ehash lookup races
Date: Sat, 20 Sep 2025 18:59:42 +0800
Message-Id: <20250920105945.538042-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

After replacing R/W locks with RCU in commit 3ab5aee7fe84 ("net: Convert
TCP & DCCP hash tables to use RCU / hlist_nulls"), a race window emerged
during the switch from reqsk/sk to sk/tw.

Now that both timewait sock (tw) and full sock (sk) reside on the same
ehash chain, it is appropriate to introduce hlist_nulls replace
operations, to eliminate the race conditions caused by this window.

Before this series of patches, I previously sent another version of the
patch, attempting to avoid the issue using a lock mechanism. However, it
seems there are some problems with that approach now, so I've switched to
the "replace" method in the current patches to resolve the issue.
For details, refer to:
https://lore.kernel.org/netdev/20250903024406.2418362-1-xuanqiang.luo@linux.dev/

Before I encountered this type of issue recently, I found there had been
several historical discussions about it. Therefore, I'm adding this
background information for those interested to reference:
1. https://lore.kernel.org/lkml/20230118015941.1313-1-kerneljasonxing@gmail.com/
2. https://lore.kernel.org/netdev/20230606064306.9192-1-duanmuquan@baidu.com/

---

Changes:
  v4:
    * Patch 1
        * Use WRITE_ONCE() for ->next in __hlist_nulls_replace_rcu(), and add
          why in the commit message.
        * Remove the node hash check in hlist_nulls_replace_init_rcu() to avoid
          redundancy. Also remove the return value, as it serves no purpose in
          this patch series.
    * Patch 3
        * Remove the check of hlist_nulls_replace_init_rcu() return value in
          inet_twsk_hashdance_schedule() as it is unnecessary.
          Thanks to Kuni for clarifying this.

  v3: https://lore.kernel.org/all/20250916103054.719584-1-xuanqiang.luo@linux.dev/
    * Add more background information on this type of issue to the letter cover.

  v2: https://lore.kernel.org/all/20250916064614.605075-1-xuanqiang.luo@linux.dev/
    * Patch 1
        * Use WRITE_ONCE() to initialize old->pprev.
    * Patch 2&3
        * Optimize sk hashed check. Thanks Kuni for pointing it out!

  v1: https://lore.kernel.org/all/20250915070308.111816-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (3):
  rculist: Add __hlist_nulls_replace_rcu() and
    hlist_nulls_replace_init_rcu()
  inet: Avoid ehash lookup race in inet_ehash_insert()
  inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()

 include/linux/rculist_nulls.h | 52 +++++++++++++++++++++++++++++++++++
 include/net/sock.h            | 23 ++++++++++++++++
 net/ipv4/inet_hashtables.c    |  4 ++-
 net/ipv4/inet_timewait_sock.c | 13 +++------
 4 files changed, 82 insertions(+), 10 deletions(-)

-- 
2.25.1


