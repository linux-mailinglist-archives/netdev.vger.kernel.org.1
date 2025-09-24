Return-Path: <netdev+bounces-225764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D5B98084
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 03:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FBA3B7A55
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 01:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0191FDE09;
	Wed, 24 Sep 2025 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y50dKvtr"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B715A85A
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758678711; cv=none; b=rN91Cr6o/u2v+KKbTMQ736yXshdkRr7wRUruARgpDogJn4P8kget/FHZ/+ocEK8qeKbRz4aw4caBoSXnDIwrO1GGE1nzxHn9kK+tTXQhsm93QtsijdeIgedGANY0MQ313BkHcTEae/WhVUqFfI4e2mLxaudYZ5U6grJgLvp3zIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758678711; c=relaxed/simple;
	bh=FjHojtCN7AQpVEq1nEVB1/vM37l3NbHzRFLhWMwR1+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qx9F7tOTEco70pcvJDwEKQm3OM+L3TDjkBr5k7BDyzGy/1txoRp+HakkvosmmCQO8fMEaAmc96HlOP2jnk11x5wso9d3B/u3OGjsI3fP8uj205cp9du3ougWoiC8wkHkv7Z9Ej5wFVoyB9DPf3lca300+eCuf6PbxGqQsdDAZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y50dKvtr; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758678707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HAZf/KZIY9K9jX7FFN9rFzc0hT+otMp2Fzu4morMicQ=;
	b=Y50dKvtr7xtX8uuY1SU5Dq2S4dE94svfnKNXMPoML69HYteja+gdrtsaFnpgn2wjOqdKBa
	CUC5piOQIBuquoWaOZceFlga6uibWAOZEGyq2HnPaLqLCgWvUWJGu2aRydpdywosm2BnUj
	DPUwxzA9H2SfNbt6rYcVPKkfe5SLXig=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v5 0/3] net: Avoid ehash lookup races
Date: Wed, 24 Sep 2025 09:50:31 +0800
Message-Id: <20250924015034.587056-1-xuanqiang.luo@linux.dev>
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
  v5:
    * Patch 1
	* Rename __hlist_nulls_replace_rcu() to hlist_nulls_replace_rcu()
	  and update the description of hlist_nulls_replace_init_rcu().
    * Patch 2
	* Remove __sk_nulls_replace_node_init_rcu() and inline it into
	  sk_nulls_replace_node_init_rcu().
	* Use DEBUG_NET_WARN_ON_ONCE() instead of WARN_ON().
    * Patch 3
	* Move smp_wmb() after setting the refcount.

  v4: https://lore.kernel.org/all/20250920105945.538042-1-xuanqiang.luo@linux.dev/
    * Patch 1
	* Use WRITE_ONCE() for ->next in __hlist_nulls_replace_rcu(), and
	  add why in the commit message.
	* Remove the node hash check in hlist_nulls_replace_init_rcu() to
	  avoid redundancy. Also remove the return value, as it serves no
	  purpose in this patch series.
    * Patch 3
	* Remove the check of hlist_nulls_replace_init_rcu() return value
	  in inet_twsk_hashdance_schedule() as it is unnecessary.
          Thanks to Kuni for clarifying this.

  v3: https://lore.kernel.org/all/20250916103054.719584-1-xuanqiang.luo@linux.dev/
    * Add more background information on this type of issue to the letter
      cover.

  v2: https://lore.kernel.org/all/20250916064614.605075-1-xuanqiang.luo@linux.dev/
    * Patch 1
	* Use WRITE_ONCE() to initialize old->pprev.
    * Patch 2&3
	* Optimize sk hashed check. Thanks Kuni for pointing it out!

  v1: https://lore.kernel.org/all/20250915070308.111816-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (3):
  rculist: Add hlist_nulls_replace_rcu() and
    hlist_nulls_replace_init_rcu()
  inet: Avoid ehash lookup race in inet_ehash_insert()
  inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()

 include/linux/rculist_nulls.h | 52 +++++++++++++++++++++++++++++++++++
 include/net/sock.h            | 14 ++++++++++
 net/ipv4/inet_hashtables.c    |  4 ++-
 net/ipv4/inet_timewait_sock.c | 24 +++++++---------
 4 files changed, 79 insertions(+), 15 deletions(-)

-- 
2.25.1


