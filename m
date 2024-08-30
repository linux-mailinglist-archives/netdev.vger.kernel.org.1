Return-Path: <netdev+bounces-123637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3C8965F1A
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5597C28EF75
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550EF17C205;
	Fri, 30 Aug 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ux0gnBbK"
X-Original-To: netdev@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440DF175D4F
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013580; cv=none; b=Sb8qhPKu2uYg3SFV4qS0PfgR5WUMZaZ+I3/f8npB8aOCCbhiMuNJ1fbeCpzFl/ubDtV6drMbbCyF1+p27wYehTFORuDxZzYlWGz0f8KG+QDavSMMKgRAC+T0zQeSpTNuAczxKZVOXbB5clGbjEg0takge/4H0D9Cqsr+c0l3d1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013580; c=relaxed/simple;
	bh=roV/mv/aUxwa/EDRQ0zJ9Euih3UQRBx13tut7ovFqeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJgmbPoknDHL8quHeh5Mw2m3K8lx3T6vzqWezZ2zVD/8pZGzewqrc+46LvSQ3A1gBVpn/LizmbdkvzVJArCCNF+c8Bz6Gw/VshAnwNiYcLsWv0dLC+/LCP+bwwe2KLrCCaoHF2xnQj2gO3vPNYrpwEL78UZobR9/h78KqzBRVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ux0gnBbK; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id AF293699C8
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 13:19:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:3483:0:640:1715:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 722CF608FE;
	Fri, 30 Aug 2024 13:18:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rIUvxkaXxCg0-QhJR5T2D;
	Fri, 30 Aug 2024 13:18:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725013136; bh=MnbpDdh85Wp2nRfqvzXdeXn+Ksd+K+6uCd7zhga5i+Y=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ux0gnBbKl1fgtQiCgB6ZHMOqLFJL/OhzufHWaW/hbX3F/Jrn3Vq3/iOffu7HlR6Sf
	 n0Ju35TEy3+DXKDtJj8qCJbZWa9mtQienBDytyZXbAdrpJCSaUpLAJucZZjkBe20Uh
	 xr+3SmIU5/FDj2nmHyBhCvL6AXgTYfNJubwtk0Ro=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v3 3/3] net: sched: use RCU read-side critical section in taprio_dump()
Date: Fri, 30 Aug 2024 13:16:33 +0300
Message-ID: <20240830101754.1574848-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830101754.1574848-1-dmantipov@yandex.ru>
References: <20240830101754.1574848-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix possible use-after-free in 'taprio_dump()' by adding RCU
read-side critical section there. Never seen on x86 but reproduced
on a KASAN-enabled arm64 system (note that original issue was found at
https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa on arm64):

[ 1601.079132][T15862] BUG: KASAN: slab-use-after-free in taprio_dump+0xa0c/0xbb0
[ 1601.082101][T15862] Read of size 4 at addr ffff0000d4bb88f8 by task repro/15862
[ 1601.085149][T15862]
[ 1601.093445][T15862] CPU: 0 UID: 0 PID: 15862 Comm: repro Not tainted 6.11.0-rc1-00293-gdefaf1a2113a-dirty #2
[ 1601.100771][T15862] Hardware name: QEMU QEMU Virtual Machine, BIOS edk2-20240524-5.fc40 05/24/2024
[ 1601.106651][T15862] Call trace:
[ 1601.107395][T15862]  dump_backtrace+0x20c/0x220
[ 1601.108397][T15862]  show_stack+0x2c/0x40
[ 1601.109220][T15862]  dump_stack_lvl+0xf8/0x174
[ 1601.110041][T15862]  print_report+0x170/0x4d8
[ 1601.110848][T15862]  kasan_report+0xb8/0x1d4
[ 1601.111991][T15862]  __asan_report_load4_noabort+0x20/0x2c
[ 1601.112880][T15862]  taprio_dump+0xa0c/0xbb0
[ 1601.113725][T15862]  tc_fill_qdisc+0x540/0x1020
[ 1601.114586][T15862]  qdisc_notify.isra.0+0x330/0x3a0
[ 1601.115506][T15862]  tc_modify_qdisc+0x7b8/0x1838
[ 1601.116378][T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
[ 1601.117320][T15862]  netlink_rcv_skb+0x1f8/0x3d4
[ 1601.118164][T15862]  rtnetlink_rcv+0x28/0x40
[ 1601.119037][T15862]  netlink_unicast+0x51c/0x790
[ 1601.119874][T15862]  netlink_sendmsg+0x79c/0xc20
[ 1601.120706][T15862]  __sock_sendmsg+0xe0/0x1a0
[ 1601.121802][T15862]  ____sys_sendmsg+0x6c0/0x840
[ 1601.122722][T15862]  ___sys_sendmsg+0x1ac/0x1f0
[ 1601.123653][T15862]  __sys_sendmsg+0x110/0x1d0
[ 1601.124459][T15862]  __arm64_sys_sendmsg+0x74/0xb0
[ 1601.125316][T15862]  invoke_syscall+0x88/0x2e0
[ 1601.126155][T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
[ 1601.127051][T15862]  do_el0_svc+0x44/0x60
[ 1601.127837][T15862]  el0_svc+0x50/0x184
[ 1601.128639][T15862]  el0t_64_sync_handler+0x120/0x12c
[ 1601.129505][T15862]  el0t_64_sync+0x190/0x194
[ 1601.130591][T15862]
[ 1601.131361][T15862] Allocated by task 15857:
[ 1601.132224][T15862]  kasan_save_stack+0x3c/0x70
[ 1601.133193][T15862]  kasan_save_track+0x20/0x3c
[ 1601.134102][T15862]  kasan_save_alloc_info+0x40/0x60
[ 1601.134955][T15862]  __kasan_kmalloc+0xd4/0xe0
[ 1601.135965][T15862]  __kmalloc_cache_noprof+0x194/0x334
[ 1601.136874][T15862]  taprio_change+0x45c/0x2fe0
[ 1601.137859][T15862]  tc_modify_qdisc+0x6a8/0x1838
[ 1601.138838][T15862]  rtnetlink_rcv_msg+0x3c8/0xc20
[ 1601.139799][T15862]  netlink_rcv_skb+0x1f8/0x3d4
[ 1601.140664][T15862]  rtnetlink_rcv+0x28/0x40
[ 1601.141725][T15862]  netlink_unicast+0x51c/0x790
[ 1601.142662][T15862]  netlink_sendmsg+0x79c/0xc20
[ 1601.143523][T15862]  __sock_sendmsg+0xe0/0x1a0
[ 1601.144445][T15862]  ____sys_sendmsg+0x6c0/0x840
[ 1601.145467][T15862]  ___sys_sendmsg+0x1ac/0x1f0
[ 1601.146410][T15862]  __sys_sendmsg+0x110/0x1d0
[ 1601.147293][T15862]  __arm64_sys_sendmsg+0x74/0xb0
[ 1601.148116][T15862]  invoke_syscall+0x88/0x2e0
[ 1601.148912][T15862]  el0_svc_common.constprop.0+0xe4/0x2a0
[ 1601.149754][T15862]  do_el0_svc+0x44/0x60
[ 1601.150532][T15862]  el0_svc+0x50/0x184
[ 1601.151438][T15862]  el0t_64_sync_handler+0x120/0x12c
[ 1601.152311][T15862]  el0t_64_sync+0x190/0x194
[ 1601.153208][T15862]
[ 1601.153751][T15862] Freed by task 6192:
[ 1601.154491][T15862]  kasan_save_stack+0x3c/0x70
[ 1601.155491][T15862]  kasan_save_track+0x20/0x3c
[ 1601.156521][T15862]  kasan_save_free_info+0x4c/0x80
[ 1601.157357][T15862]  poison_slab_object+0x110/0x160
[ 1601.158300][T15862]  __kasan_slab_free+0x3c/0x74
[ 1601.159265][T15862]  kfree+0x134/0x3c0
[ 1601.160068][T15862]  taprio_free_sched_cb+0x18c/0x220
[ 1601.161046][T15862]  rcu_core+0x920/0x1b7c
[ 1601.161906][T15862]  rcu_core_si+0x10/0x1c
[ 1601.162693][T15862]  handle_softirqs+0x2e8/0xd64
[ 1601.163518][T15862]  __do_softirq+0x14/0x20

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: tweak commit message as suggested by Vinicius
v2: added to the series
---
 net/sched/sch_taprio.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 9f4e004cdb8b..f31feca381c4 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2374,9 +2374,6 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct tc_mqprio_qopt opt = { 0 };
 	struct nlattr *nest, *sched_nest;
 
-	oper = rtnl_dereference(q->oper_sched);
-	admin = rtnl_dereference(q->admin_sched);
-
 	mqprio_qopt_reconstruct(dev, &opt);
 
 	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
@@ -2397,29 +2394,37 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	    nla_put_u32(skb, TCA_TAPRIO_ATTR_TXTIME_DELAY, q->txtime_delay))
 		goto options_error;
 
+	rcu_read_lock();
+
+	oper = rtnl_dereference(q->oper_sched);
+	admin = rtnl_dereference(q->admin_sched);
+
 	if (oper && taprio_dump_tc_entries(skb, q, oper))
-		goto options_error;
+		goto unlock;
 
 	if (oper && dump_schedule(skb, oper))
-		goto options_error;
+		goto unlock;
 
-	if (!admin)
-		goto done;
+	if (admin) {
+		sched_nest =
+			nla_nest_start_noflag(skb, TCA_TAPRIO_ATTR_ADMIN_SCHED);
+		if (!sched_nest)
+			goto unlock;
 
-	sched_nest = nla_nest_start_noflag(skb, TCA_TAPRIO_ATTR_ADMIN_SCHED);
-	if (!sched_nest)
-		goto options_error;
+		if (dump_schedule(skb, admin)) {
+			nla_nest_cancel(skb, sched_nest);
+			goto unlock;
+		}
 
-	if (dump_schedule(skb, admin))
-		goto admin_error;
+		nla_nest_end(skb, sched_nest);
+	}
 
-	nla_nest_end(skb, sched_nest);
+	rcu_read_unlock();
 
-done:
 	return nla_nest_end(skb, nest);
 
-admin_error:
-	nla_nest_cancel(skb, sched_nest);
+unlock:
+	rcu_read_unlock();
 
 options_error:
 	nla_nest_cancel(skb, nest);
-- 
2.46.0


