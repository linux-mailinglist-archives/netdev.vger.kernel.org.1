Return-Path: <netdev+bounces-223456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD26B593DD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D8D3B06DF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320A1305959;
	Tue, 16 Sep 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S2pQI+xo"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D42F83D8
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018673; cv=none; b=QZ6koaSOF+CGAFZrKabPpjzGrv9Qju6MUbJ6KKMRZQNGU1mf+MHaIPZ/fSxFJ529Xo9gQDNXq3cCKAFqYZWWMQbDvEEwYsJcyn9HW4CTKKsvWvZrOskxiEAPXM7HyvtWyXQp7Yy4AB4IYCrR9vB5i/uaN+AMKK87sgEfSl34uBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018673; c=relaxed/simple;
	bh=NJinrFCzcZ68I+aBpzVovN88TypFb/3QQmi8NohuNO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l31+VDGX1xrQJXDD6Fj+FIWv4FEhKmQTUEktYK/tSq3BG3w1ky51uzYeNi9w+WrzIUgsvaS1Hf8K9ljrnGxZhrxhz1VWF1kgw4l7e3Bt4zx+xiCY2EFYLINfjnaek0pULRDWz1zYtRNYUSb64IddVrVzO8b4ZVDLIicAiwqs3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S2pQI+xo; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758018668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=stIFJdGmQvw+Rab15vYBysG3v/OeR56vWXNVACGEFwI=;
	b=S2pQI+xooKIWPoPnTrMI912WC5/nqpRU9iEAVCFsGj4SxHdrzax8N33+0FBnKsQaf0khuP
	r8gdI30foGUqv+lJcz1tFYYvw2fUnNCKujeBaF5zgjIgOsbr92HBIDA8BPHd4eDO61d9op
	L9xOfJo0qZGlGNUxY6rBIj4BVD0pHwA=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v3 0/3] net: Avoid ehash lookup races
Date: Tue, 16 Sep 2025 18:30:51 +0800
Message-Id: <20250916103054.719584-1-xuanqiang.luo@linux.dev>
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
  v3:
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

 include/linux/rculist_nulls.h | 61 +++++++++++++++++++++++++++++++++++
 include/net/sock.h            | 23 +++++++++++++
 net/ipv4/inet_hashtables.c    |  4 ++-
 net/ipv4/inet_timewait_sock.c | 15 ++++-----
 4 files changed, 93 insertions(+), 10 deletions(-)

-- 
2.25.1


