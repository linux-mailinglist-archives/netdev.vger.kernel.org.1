Return-Path: <netdev+bounces-226604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D14BA2D7B
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E6C1C02037
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5A28724C;
	Fri, 26 Sep 2025 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g8RsWeaJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF9287512
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872490; cv=none; b=lcwuOfPA7SChw24GD5WSwz0m52khVjBiN9SXxW9OZD/neJql0r8O4AuBKB8f0dnpMEEkIN1mq9dKd1Zx5HRyDZl++yCNnsh+TX0Oxdg5uEzdninAHSBZH1hwcYWSc/mnk6oOihPWgQH/if49sr1MWxTmOtPNW6RHzUmhKgQ43Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872490; c=relaxed/simple;
	bh=XKnmpEFbAIkenV7ye0e02CyHbk+8pgm7HNkp+OCTXvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rC58ZaOWZOTF0+CHnuvbW7YLcT/92XwP1H2CCZWs4bx13LX4Yxv45kMm+5jyzhxz3ehCQCwuK0s2CgxIrC//7NTcUUsEfjliTHhVSOrg1Fzg2FJXiJ64dZp9S7aKnLKNJYvQtmz72+efDFAlN3+4iNLY+qbt9baIRq7HT3wNpGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g8RsWeaJ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758872485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nwLDs1VdJ7tuosh4qKhCK24Eiz7nHBYQa6JTSvGhv5c=;
	b=g8RsWeaJvQIwscNvX9ICsKKV2MxB79uikXdHbZzVLt3auUspsmrBTw0/l3JdMmqhR+Uj50
	1WwrrhGlHaDE3FfbbREMSRY/AAael4j9ZsbgQO1rhMr6Nt4fivlEPEz3N0AqRB1rVQ0476
	oQDL5mgCkN6t/w4AxNPQ5Q/M0yCcbVY=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH net-next v7 0/3] net: Avoid ehash lookup races
Date: Fri, 26 Sep 2025 15:40:30 +0800
Message-Id: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
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
  v7:
    * Patch1
	* Fix the checkpatch complaints.
	* Introduces hlist_nulls_pprev_rcu() to replace
	  (*((struct hlist_nulls_node __rcu __force **)(node)->pprev)).
	* Use next->pprev instead of new->next->pprev.
    * Patch2
	* Remove else if in inet_ehash_insert(), use if instead.
    * Patch3
	* Fix legacy comment style issues in
	  inet_twsk_hashdance_schedule().

  v6: https://lore.kernel.org/all/20250925021628.886203-1-xuanqiang.luo@linux.dev/
    * Patch 1
        * Send and CC to the RCU maintainers.
    * Patch 3
        * Remove the unused function inet_twsk_add_node_rcu() and variable
          ehead fix build warnings.

  v5: https://lore.kernel.org/all/20250924015034.587056-1-xuanqiang.luo@linux.dev/
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

 include/linux/rculist_nulls.h | 59 +++++++++++++++++++++++++++++++++++
 include/net/sock.h            | 14 +++++++++
 net/ipv4/inet_hashtables.c    |  8 +++--
 net/ipv4/inet_timewait_sock.c | 35 +++++++--------------
 4 files changed, 91 insertions(+), 25 deletions(-)

-- 
2.25.1


