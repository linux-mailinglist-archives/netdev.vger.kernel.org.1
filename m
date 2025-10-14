Return-Path: <netdev+bounces-229016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36626BD712C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 04:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB47F4E51D0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66803043A4;
	Tue, 14 Oct 2025 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uuV5mTLg"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4B82E975E
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408894; cv=none; b=trDP40IbJRrtKDv/NuklM89t/dQIEiezze6VAMx9TEiSR97dRiZdGMPsPg0hy66UEJO+GDBIJTHC6UZE4lU60GPHkI+WbiNJQ4NW1qeA6Muh+0Z/dk783b6y9S5T0iTtO90fZp+i21xSYJz5ffk9siwRQWRTaYtXYbhGHrrKZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408894; c=relaxed/simple;
	bh=2zyNpH4YdDpkVjscMaTL5ag/tH5fGfysTE30KOOmmdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iNIHjSLSNevbscCCJd3IpO6HyWtFgiq6tSD5ndVMxsoL6ZBEPwbGjwNbKsDSgGS4RGNrLVvYnSTO+/OTNJll9ymgmT0OVGY6u9vsFk0izFc7T7wFS7tNkjHahWDzqoPb4aLRHQhF9CLnc4/mv9kIVEOonZscSWvz30AHB/pZn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uuV5mTLg; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760408890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nwLDs1VdJ7tuosh4qKhCK24Eiz7nHBYQa6JTSvGhv5c=;
	b=uuV5mTLgpo3Yv4UlgG9wBYpF7SZgqoRdIQ/24GQEnUUAlpDpXFQAYaRsIrxzHcTBdNQKaF
	pay/q6eGeoorJU52Lioiqmp/6ch7Y2kQQTK7aOj8/zA2Vyh1dtILPkcwQ3bHUYoQzPURng
	AEw72kHukRwFQ80P+BqqVxMkbSFv1oQ=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com,
	pabeni@redhat.com,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jiayuan.chen@linux.dev,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [RESEND PATCH net-next v7 0/3] net: Avoid ehash lookup races
Date: Tue, 14 Oct 2025 10:27:00 +0800
Message-Id: <20251014022703.1387794-1-xuanqiang.luo@linux.dev>
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


