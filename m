Return-Path: <netdev+bounces-191875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD1ABD818
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACE53A2892
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4607485;
	Tue, 20 May 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHetLwRe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21ECA4E
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747743553; cv=none; b=I5aoj8Gpom8LtVF++KTyMz8Kv0uef5XYcPamIQxc4ZSj67QszflDLtyNKIzBaQx3VKvctI//8UbjkWz7jCX6VawmCE5y1Vl448V2b6QvYFHsLTXR4BLS6kB90fgDGs9uOeCEp6fuQ89V0ZJv11yytXpzR3kmL3RXoBvBZkXN1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747743553; c=relaxed/simple;
	bh=xQdFHYcT6YHcOlxQWeJLBODY0hxMI2ler1MjuGUfOMA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=shgvbdrFulgskyksQTM30czdG8qd/5zb9urPKGpPZDD8nKh8XAz3nwkIqyRAFfGkdHzmCagQrTaiOtEaGoIqUPE0lNdBN8Woxz5xJysPkyQuZ/y3VFWvTSw5I2E4QKlKAbloVMNHRzay2jqyS612A8GuktBWHoCBajSJKBqTSic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aHetLwRe; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c5c82c6d72so1006338085a.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747743550; x=1748348350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KAv37NjFOdgIpZ3wY574Gc2z9clcB4JdgPMTPaovO/c=;
        b=aHetLwReSultho88qR1guXgDI/inERVE+pfZ0wzwGzsD80AvAyJZrPriKPHIP+OsGt
         vKQQAYjkoUXBtNXxehg7cGEI/uNd3ZNNfcNbXk8fOCIl5PwnscVzYed9LannlG0mI5EX
         yrzyogvdTBvR6C8tp1vrulS4K7LoCJB2ZWM/tM8lno8t6VJVkY4yXQntRVMziehPieLO
         CRpxUr+yD2beEc7r3puP5HPGqzkeP7z0MBUhg0pPJI5ldrE3uVQR6ysyMhu6+6pwoU6+
         RiMTgskoIhaKFqFYe/HLtTgs5/iBdJpCGEqnPkudgcBj9u/0jJCdhH7EBjR8y9dW5xnQ
         rTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747743550; x=1748348350;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KAv37NjFOdgIpZ3wY574Gc2z9clcB4JdgPMTPaovO/c=;
        b=dw1/PF47MmEvfLhHpO2+SQU94339jORmJPoG3Llll60FOFK2rrPaqFBPytijJrPv8t
         UInK/esEpB003D/VZP3gjDFpIMTpr3UeAbI7LWsG4Ooj0CI3lvA2+/sRSFaQnmetgT6H
         MbdCxNkh5F2wEd/s+/jqVD4bvPZ+BtCnMbasoZv4ItCllJitlzPDm45WEL92x2Y5TOeZ
         3/RVbH7cQKQqfRE8UfvHRDbSwsra6S1bTpBCgHw8B4DAq4mDQdY40RKCU3xEs1AMRO9y
         kLq3oUDV4oo+VZSPevV5Kt2ZMGqP8wFlYJc0sn5rFdqBOVqtYMgnc70VhxGcfeaOpUwG
         pfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRm0krJapsIs9Zqd3xqWxrSKndPhV2MDleMJE6YeMr5FPsS+xQOp3yTydnK9mmhRngaTFJAh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ5zZtasdjEOzHhdnQ7mlO12J3xPRC4Xqi50DYRpSTp9WJBSiU
	jAaWFXrqipG9lkgxscmHp5mywre4zb3kIZORFlr0xRM+Sf/ccdlxkmD9KIS+Ip2TNGd1TkweZKH
	2ytPPmo7iLzfAuA==
X-Google-Smtp-Source: AGHT+IGf6NTwMSAaUKczsFpPNl8LZwUKatFn14dFwbbnzvkpr69I4tZ0ffdFTzmSL0wox/sWAVyPMTaImCHLzQ==
X-Received: from qkoy19.prod.google.com ([2002:a05:620a:25d3:b0:7ce:bf54:3c87])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:d8d:b0:7c5:60c7:339 with SMTP id af79cd13be357-7cd46718a88mr2653141485a.9.1747743550199;
 Tue, 20 May 2025 05:19:10 -0700 (PDT)
Date: Tue, 20 May 2025 12:19:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250520121908.1805732-1-edumazet@google.com>
Subject: [PATCH net-next] net: add debug checks in ____napi_schedule() and napi_poll()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While tracking an IDPF bug, I found that idpf_vport_splitq_napi_poll()
was not following NAPI rules.

It can indeed return @budget after napi_complete() has been called.

Add two debug conditions in networking core to hopefully catch
this kind of bugs sooner.

IDPF bug will be fixed in a separate patch.

[   72.441242] repoll requested for device eth1 idpf_vport_splitq_napi_poll [idpf] but napi is not scheduled.
[   72.446291] list_del corruption. next->prev should be ff31783d93b14040, but was ff31783d93b10080. (next=ff31783d93b10080)
[   72.446659] kernel BUG at lib/list_debug.c:67!
[   72.446816] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
[   72.447031] CPU: 156 UID: 0 PID: 16258 Comm: ip Tainted: G        W           6.15.0-dbg-DEV #1944 NONE
[   72.447340] Tainted: [W]=WARN
[   72.447702] RIP: 0010:__list_del_entry_valid_or_report (lib/list_debug.c:65)
[   72.450630] Call Trace:
[   72.450720]  <IRQ>
[   72.450797] net_rx_action (include/linux/list.h:215 include/linux/list.h:287 net/core/dev.c:7385 net/core/dev.c:7516)
[   72.450928] ? lock_release (kernel/locking/lockdep.c:?)
[   72.451059] ? clockevents_program_event (kernel/time/clockevents.c:?)
[   72.451222] handle_softirqs (kernel/softirq.c:579)
[   72.451356] ? do_softirq (kernel/softirq.c:480)
[   72.451480] ? idpf_vc_xn_exec (drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:462) idpf
[   72.451635] do_softirq (kernel/softirq.c:480)
[   72.451750]  </IRQ>
[   72.451828]  <TASK>
[   72.451905] __local_bh_enable_ip (kernel/softirq.c:?)
[   72.452051] idpf_vc_xn_exec (drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:462) idpf
[   72.452210] idpf_send_delete_queues_msg (drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:2083) idpf
[   72.452390] idpf_vport_stop (drivers/net/ethernet/intel/idpf/idpf_lib.c:837 drivers/net/ethernet/intel/idpf/idpf_lib.c:868) idpf
[   72.452541] ? idpf_vport_stop (include/linux/bottom_half.h:? include/linux/netdevice.h:4762 drivers/net/ethernet/intel/idpf/idpf_lib.c:855) idpf
[   72.452695] idpf_initiate_soft_reset (drivers/net/ethernet/intel/idpf/idpf_lib.c:?) idpf
[   72.452867] idpf_change_mtu (drivers/net/ethernet/intel/idpf/idpf_lib.c:2189) idpf
[   72.453015] netif_set_mtu_ext (net/core/dev.c:9437)
[   72.453157] ? packet_notifier (include/linux/rcupdate.h:331 include/linux/rcupdate.h:841 net/packet/af_packet.c:4240)
[   72.453292] netif_set_mtu (net/core/dev.c:9515)
[   72.453416] dev_set_mtu (net/core/dev_api.c:?)
[   72.453534] bond_change_mtu (drivers/net/bonding/bond_main.c:4833)
[   72.453666] netif_set_mtu_ext (net/core/dev.c:9437)
[   72.453803] do_setlink (net/core/rtnetlink.c:3116)
[   72.453925] ? rtnl_newlink (net/core/rtnetlink.c:3901)
[   72.454055] ? rtnl_newlink (net/core/rtnetlink.c:3901)
[   72.454185] ? rtnl_newlink (net/core/rtnetlink.c:3901)
[   72.454314] ? trace_contention_end (include/trace/events/lock.h:122)
[   72.454467] ? __mutex_lock (arch/x86/include/asm/preempt.h:85 kernel/locking/mutex.c:611 kernel/locking/mutex.c:746)
[   72.454597] ? cap_capable (include/trace/events/capability.h:26)
[   72.454721] ? security_capable (security/security.c:?)
[   72.454857] rtnl_newlink (net/core/rtnetlink.c:?)
[   72.454982] ? lock_is_held_type (kernel/locking/lockdep.c:5599 kernel/locking/lockdep.c:5938)
[   72.455121] ? __lock_acquire (kernel/locking/lockdep.c:?)
[   72.455256] ? __change_page_attr_set_clr (arch/x86/mm/pat/set_memory.c:685)
[   72.455438] ? __lock_acquire (kernel/locking/lockdep.c:?)
[   72.455582] ? rtnetlink_rcv_msg (include/linux/rcupdate.h:331 include/linux/rcupdate.h:841 net/core/rtnetlink.c:6885)
[   72.455721] ? lock_acquire (kernel/locking/lockdep.c:5866)
[   72.455848] ? rtnetlink_rcv_msg (include/linux/rcupdate.h:331 include/linux/rcupdate.h:841 net/core/rtnetlink.c:6885)
[   72.455987] ? lock_release (kernel/locking/lockdep.c:?)
[   72.456117] ? rcu_read_unlock (include/linux/rcupdate.h:341 include/linux/rcupdate.h:871)
[   72.456249] ? __pfx_rtnl_newlink (net/core/rtnetlink.c:3956)
[   72.456388] rtnetlink_rcv_msg (net/core/rtnetlink.c:6955)
[   72.456526] ? rtnetlink_rcv_msg (include/linux/rcupdate.h:331 include/linux/rcupdate.h:841 net/core/rtnetlink.c:6885)
[   72.456671] ? lock_acquire (kernel/locking/lockdep.c:5866)
[   72.456802] ? net_generic (include/linux/rcupdate.h:331 include/linux/rcupdate.h:841 include/net/netns/generic.h:45)
[   72.456929] ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:6858)
[   72.457082] netlink_rcv_skb (net/netlink/af_netlink.c:2534)
[   72.457212] netlink_unicast (net/netlink/af_netlink.c:1313)
[   72.457344] netlink_sendmsg (net/netlink/af_netlink.c:1883)
[   72.457476] __sock_sendmsg (net/socket.c:712)
[   72.457602] ____sys_sendmsg (net/socket.c:?)
[   72.457735] ? _copy_from_user (arch/x86/include/asm/uaccess_64.h:126 arch/x86/include/asm/uaccess_64.h:134 arch/x86/include/asm/uaccess_64.h:141 include/linux/uaccess.h:178 lib/usercopy.c:18)
[   72.457875] ___sys_sendmsg (net/socket.c:2620)
[   72.458042] ? __call_rcu_common (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 arch/x86/include/asm/irqflags.h:159 kernel/rcu/tree.c:3107)
[   72.458185] ? mntput_no_expire (include/linux/rcupdate.h:331 include/linux/rcupdate.h:841 fs/namespace.c:1457)
[   72.458324] ? lock_acquire (kernel/locking/lockdep.c:5866)
[   72.458451] ? mntput_no_expire (include/linux/rcupdate.h:331 include/linux/rcupdate.h:841 fs/namespace.c:1457)
[   72.458588] ? lock_release (kernel/locking/lockdep.c:?)
[   72.458718] ? mntput_no_expire (include/linux/rcupdate.h:331 include/linux/rcupdate.h:841 fs/namespace.c:1457)
[   72.458856] __x64_sys_sendmsg (net/socket.c:2652)
[   72.458997] ? do_syscall_64 (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 include/linux/entry-common.h:198 arch/x86/entry/syscall_64.c:90)
[   72.459136] do_syscall_64 (arch/x86/entry/syscall_64.c:?)
[   72.459259] ? exc_page_fault (arch/x86/mm/fault.c:1542)
[   72.459387] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   72.459555] RIP: 0033:0x7fd15f17cbd0

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index fccf2167b2352f0cba80651c8245c9d5260ac205..e2d6ce96a8897066e03a6c8754c861983bbe4ceb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4815,6 +4815,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 	}
 
 use_local_napi:
+	DEBUG_NET_WARN_ON_ONCE(!list_empty(&napi->poll_list));
 	list_add_tail(&napi->poll_list, &sd->poll_list);
 	WRITE_ONCE(napi->list_owner, smp_processor_id());
 	/* If not called from net_rx_action()
@@ -7476,9 +7477,14 @@ static int napi_poll(struct napi_struct *n, struct list_head *repoll)
 
 	work = __napi_poll(n, &do_repoll);
 
-	if (do_repoll)
+	if (do_repoll) {
+#if defined(CONFIG_DEBUG_NET)
+		if (unlikely(!napi_is_scheduled(n)))
+			pr_crit("repoll requested for device %s %ps but napi is not scheduled.\n",
+				n->dev->name, n->poll);
+#endif
 		list_add_tail(&n->poll_list, repoll);
-
+	}
 	netpoll_poll_unlock(have);
 
 	return work;
-- 
2.49.0.1101.gccaa498523-goog


