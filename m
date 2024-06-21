Return-Path: <netdev+bounces-105769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9AF912B6B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3EA28148A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561A715FA6A;
	Fri, 21 Jun 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJlq0Q3T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B3156227;
	Fri, 21 Jun 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987654; cv=none; b=BT+OLzs9Ojk5fTaC3TWLi8gCIVsSSVnMbOQXryrAzJDQ3vW7NLm+ublQN56ZmhW+Zp7ZZuORanLqqy/SicsxcCkdU+gK1u2MD6PLydUTLvIggmEUCHyUPfahwnUzXvndta8r13q9f8TBrYw6zttvbl9Am495psoB49nkSjzciZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987654; c=relaxed/simple;
	bh=SzpHfji6jieEcUwIJxBlYV6UQEyva0Ke/KALpE5BdSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gRAou1ymoWPmx/MnL2r1Cmz+4LdsqdUSxBgqnY63Cm6fjvGN7nkPdFLNEJ/5GO7wt1X3gA83Areb5I3LPKBGQATsvsdObVzBAdzZtRoqRLNhJZ264Dqcg13z6LNnTjeLX4CR5fpWjdxFOpBetNnNQUzgx6jNLHZTiNHvTm3h0So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJlq0Q3T; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7065a2f4573so460051b3a.2;
        Fri, 21 Jun 2024 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718987652; x=1719592452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj1xp1u+kQa0camB8UfdblfjMRYqud2QNR4VwIx50Oo=;
        b=jJlq0Q3T9wfTwha7BG0wkwSbFOn3qt13CEShfSr1BfY2q188b3itUjPCdFvoPvVdFW
         rVqZlIif0Pa9ct3oTsPVOtpS9EkBfccLqNVJSvq1lU9/0VhYgj8vU+p1nNMdy0lvc7Jj
         Piw2oHC+izW4+GQctLqWQDUxuddyKBOrIaCL0ntYmG+75TWxQNPxTSrc7QSp7Zg1050X
         kZOoG1JfPGaQmzadexO767JSpE/xBThSVEJxio4FBMtdnDNk88Iv9O43e/uvxBGKGOgm
         T53fNbzAmbHvCNnUw9eTxEQu3vMkQh0v1+xUkew3yEtjEql8qyUyEOdWyvvsLKO/LSxj
         ipLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718987652; x=1719592452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pj1xp1u+kQa0camB8UfdblfjMRYqud2QNR4VwIx50Oo=;
        b=wYsZpCKD5AwESpylV6OEL9qCdLDb6KB6yoFGP2OvH5wdR29vBbwBmkRGOOYEzd4c/Y
         DHZqAd2GFGJTM3vQ5mKjfUuK7XL7zHf31QOzd1ujtWM0QK2NDbgKW6/c7YcdMGQbWwXO
         lOSngna9AHFgANmgaNIcDx0MhOymxa/7Cvvn2x3GPK931eAViB/DtO8ZxSmVaL4nkCS9
         RkOVjnyC3/NlCJImbtyEtLIAT0UtoCxkCPrtP8g1sNajCj9NSgkP/K3aLTVcHZka3P3C
         3enUTQ9Ums1a5hUyMOpVjaN3Fwp9zPpK0AFHumvTLv5P6iV5aWzTth8r9PMHaoNShUBH
         xIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0HN8hKpIIW9LbE04WlmKv5PpmsVnuPicJBJuifhSmMz8kZnEsIFz9D/7hIXXyuoGdlE/2gzE3C7dYpN7VctcL8RGM24B36mc5W3zm69ogv2As79kSpOzcED6ghZwjHm60oZi9FyJvA+ERfrn6A5D7
X-Gm-Message-State: AOJu0YxVDnA+dLk+h37oPmA3B9wZElkNl9kT0xdhD+oK2/2viFqfbf5T
	ZAMt3XjDcDPZfCUDFqf+CD8kaMph5xFR81xaLSTmYGZYJ2XUfft4WkP8Mg==
X-Google-Smtp-Source: AGHT+IGDPz6QXD1xbUHPZ6tYUQXqEH+AmvFhC78fud6CJiOyWZdEm//Qqma5t8UIZ+6MDsaiz9N4Pw==
X-Received: by 2002:a05:6a00:138c:b0:702:3e36:b7c4 with SMTP id d2e1a72fcca58-70629c15e97mr10553453b3a.5.1718987651744;
        Fri, 21 Jun 2024 09:34:11 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065119d734sm1606526b3a.59.2024.06.21.09.34.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Jun 2024 09:34:10 -0700 (PDT)
From: yskelg@gmail.com
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Takashi Iwai <tiwai@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Taehee Yoo <ap420073@gmail.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ppbuk5246@gmail.com,
	Yunseong Kim <yskelg@gmail.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH net v2] net/sched: Fixes: 51270d573a8d NULL ptr deref in perf_trace_qdisc_reset()
Date: Sat, 22 Jun 2024 01:25:54 +0900
Message-ID: <20240621162552.5078-4-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

In the TRACE_EVENT(qdisc_reset) NULL dereference occurred from

 qdisc->dev_queue->dev <NULL> ->name

This situation simulated from bunch of veths and Bluetooth dis/reconnection.

During qdisc initialization, qdisc was being set to noop_queue.
In veth_init_queue, the initial tx_num was reduced back to one,
causing the qdisc reset to be called with noop, which led to the kernel panic.

I've attached the GitHub gist link that C converted syz-execprogram
source code and 3 log of reproduced vmcore-dmesg.

 https://gist.github.com/yskelg/cc64562873ce249cdd0d5a358b77d740

Yeoreum and I use two fuzzing tool simultaneously.

One process with syz-executor : https://github.com/google/syzkaller

 $ ./syz-execprog -executor=./syz-executor -repeat=1 -sandbox=setuid \
    -enable=none -collide=false log1

The other process with perf fuzzer:
 https://github.com/deater/perf_event_tests/tree/master/fuzzer

 $ perf_event_tests/fuzzer/perf_fuzzer

I think this will happen on the kernel version.

 Linux kernel version ≥ v6.7.10, ≥ v6.8 ≥ v6.9 and 6.10

This occurred from 51270d573a8d. I think this patch is absolutely 
necessary. Previously, It was showing not intended string value of name.

I've reproduced 3 time from my fedora 40 Debug Kernel with any other module 
or patched.

 version: 6.10.0-0.rc2.20240608gitdc772f8237f9.29.fc41.aarch64+debug

[ 5287.164555] veth0_vlan: left promiscuous mode
[ 5287.164929] veth1_macvtap: left promiscuous mode
[ 5287.164950] veth0_macvtap: left promiscuous mode
[ 5287.164983] veth1_vlan: left promiscuous mode
[ 5287.165008] veth0_vlan: left promiscuous mode
[ 5287.165450] veth1_macvtap: left promiscuous mode
[ 5287.165472] veth0_macvtap: left promiscuous mode
[ 5287.165502] veth1_vlan: left promiscuous mode
…
[ 5297.598240] bridge0: port 2(bridge_slave_1) entered blocking state
[ 5297.598262] bridge0: port 2(bridge_slave_1) entered forwarding state
[ 5297.598296] bridge0: port 1(bridge_slave_0) entered blocking state
[ 5297.598313] bridge0: port 1(bridge_slave_0) entered forwarding state
[ 5297.616090] 8021q: adding VLAN 0 to HW filter on device bond0
[ 5297.620405] bridge0: port 1(bridge_slave_0) entered disabled state
[ 5297.620730] bridge0: port 2(bridge_slave_1) entered disabled state
[ 5297.627247] 8021q: adding VLAN 0 to HW filter on device team0
[ 5297.629636] bridge0: port 1(bridge_slave_0) entered blocking state
…
[ 5298.002798] bridge_slave_0: left promiscuous mode
[ 5298.002869] bridge0: port 1(bridge_slave_0) entered disabled state
[ 5298.309444] bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
[ 5298.315206] bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
[ 5298.320207] bond0 (unregistering): Released all slaves
[ 5298.354296] hsr_slave_0: left promiscuous mode
[ 5298.360750] hsr_slave_1: left promiscuous mode
[ 5298.374889] veth1_macvtap: left promiscuous mode
[ 5298.374931] veth0_macvtap: left promiscuous mode
[ 5298.374988] veth1_vlan: left promiscuous mode
[ 5298.375024] veth0_vlan: left promiscuous mode
[ 5299.109741] team0 (unregistering): Port device team_slave_1 removed
[ 5299.185870] team0 (unregistering): Port device team_slave_0 removed
…
[ 5300.155443] Bluetooth: hci3: unexpected cc 0x0c03 length: 249 > 1
[ 5300.155724] Bluetooth: hci3: unexpected cc 0x1003 length: 249 > 9
[ 5300.155988] Bluetooth: hci3: unexpected cc 0x1001 length: 249 > 9
….
[ 5301.075531] team0: Port device team_slave_1 added
[ 5301.085515] bridge0: port 1(bridge_slave_0) entered blocking state
[ 5301.085531] bridge0: port 1(bridge_slave_0) entered disabled state
[ 5301.085588] bridge_slave_0: entered allmulticast mode
[ 5301.085800] bridge_slave_0: entered promiscuous mode
[ 5301.095617] bridge0: port 1(bridge_slave_0) entered blocking state
[ 5301.095633] bridge0: port 1(bridge_slave_0) entered disabled state
…
[ 5301.149734] bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
[ 5301.173234] bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
[ 5301.180517] bond0: (slave bond_slave_1): Enslaving as an active interface with an up link
[ 5301.193481] hsr_slave_0: entered promiscuous mode
[ 5301.204425] hsr_slave_1: entered promiscuous mode
[ 5301.210172] debugfs: Directory 'hsr0' with parent 'hsr' already present!
[ 5301.210185] Cannot create hsr debugfs directory
[ 5301.224061] bond0: (slave bond_slave_1): Enslaving as an active interface with an up link
[ 5301.246901] bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
[ 5301.255934] team0: Port device team_slave_0 added
[ 5301.256480] team0: Port device team_slave_1 added
[ 5301.256948] team0: Port device team_slave_0 added
…
[ 5301.435928] hsr_slave_0: entered promiscuous mode
[ 5301.446029] hsr_slave_1: entered promiscuous mode
[ 5301.455872] debugfs: Directory 'hsr0' with parent 'hsr' already present!
[ 5301.455884] Cannot create hsr debugfs directory
[ 5301.502664] hsr_slave_0: entered promiscuous mode
[ 5301.513675] hsr_slave_1: entered promiscuous mode
[ 5301.526155] debugfs: Directory 'hsr0' with parent 'hsr' already present!
[ 5301.526164] Cannot create hsr debugfs directory
[ 5301.563662] hsr_slave_0: entered promiscuous mode
[ 5301.576129] hsr_slave_1: entered promiscuous mode
[ 5301.580259] debugfs: Directory 'hsr0' with parent 'hsr' already present!
[ 5301.580270] Cannot create hsr debugfs directory
[ 5301.590269] 8021q: adding VLAN 0 to HW filter on device bond0

[ 5301.595872] KASAN: null-ptr-deref in range [0x0000000000000130-0x0000000000000137]
[ 5301.595877] Mem abort info:
[ 5301.595881]   ESR = 0x0000000096000006
[ 5301.595885]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 5301.595889]   SET = 0, FnV = 0
[ 5301.595893]   EA = 0, S1PTW = 0
[ 5301.595896]   FSC = 0x06: level 2 translation fault
[ 5301.595900] Data abort info:
[ 5301.595903]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[ 5301.595907]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 5301.595911]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 5301.595915] [dfff800000000026] address between user and kernel address ranges
[ 5301.595971] Internal error: Oops: 0000000096000006 [#1] SMP
…
[ 5301.596076] CPU: 2 PID: 102769 Comm:
syz-executor.3 Kdump: loaded Tainted:
 G        W         -------  ---  6.10.0-0.rc2.20240608gitdc772f8237f9.29.fc41.aarch64+debug #1
[ 5301.596080] Hardware name: VMware, Inc. VMware20,1/VBSA,
 BIOS VMW201.00V.21805430.BA64.2305221830 05/22/2023
[ 5301.596082] pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[ 5301.596085] pc : strnlen+0x40/0x88
[ 5301.596114] lr : trace_event_get_offsets_qdisc_reset+0x6c/0x2b0
[ 5301.596124] sp : ffff8000beef6b40
[ 5301.596126] x29: ffff8000beef6b40 x28: dfff800000000000 x27: 0000000000000001
[ 5301.596131] x26: 6de1800082c62bd0 x25: 1ffff000110aa9e0 x24: ffff800088554f00
[ 5301.596136] x23: ffff800088554ec0 x22: 0000000000000130 x21: 0000000000000140
[ 5301.596140] x20: dfff800000000000 x19: ffff8000beef6c60 x18: ffff7000115106d8
[ 5301.596143] x17: ffff800121bad000 x16: ffff800080020000 x15: 0000000000000006
[ 5301.596147] x14: 0000000000000002 x13: ffff0001f3ed8d14 x12: ffff700017ddeda5
[ 5301.596151] x11: 1ffff00017ddeda4 x10: ffff700017ddeda4 x9 : ffff800082cc5eec
[ 5301.596155] x8 : 0000000000000004 x7 : 00000000f1f1f1f1 x6 : 00000000f2f2f200
[ 5301.596158] x5 : 00000000f3f3f3f3 x4 : ffff700017dded80 x3 : 00000000f204f1f1
[ 5301.596162] x2 : 0000000000000026 x1 : 0000000000000000 x0 : 0000000000000130
[ 5301.596166] Call trace:
[ 5301.596175]  strnlen+0x40/0x88
[ 5301.596179]  trace_event_get_offsets_qdisc_reset+0x6c/0x2b0
[ 5301.596182]  perf_trace_qdisc_reset+0xb0/0x538
[ 5301.596184]  __traceiter_qdisc_reset+0x68/0xc0
[ 5301.596188]  qdisc_reset+0x43c/0x5e8
[ 5301.596190]  netif_set_real_num_tx_queues+0x288/0x770
[ 5301.596194]  veth_init_queues+0xfc/0x130 [veth]
[ 5301.596198]  veth_newlink+0x45c/0x850 [veth]
[ 5301.596202]  rtnl_newlink_create+0x2c8/0x798
[ 5301.596205]  __rtnl_newlink+0x92c/0xb60
[ 5301.596208]  rtnl_newlink+0xd8/0x130
[ 5301.596211]  rtnetlink_rcv_msg+0x2e0/0x890
[ 5301.596214]  netlink_rcv_skb+0x1c4/0x380
[ 5301.596225]  rtnetlink_rcv+0x20/0x38
[ 5301.596227]  netlink_unicast+0x3c8/0x640
[ 5301.596231]  netlink_sendmsg+0x658/0xa60
[ 5301.596234]  __sock_sendmsg+0xd0/0x180
[ 5301.596243]  __sys_sendto+0x1c0/0x280
[ 5301.596246]  __arm64_sys_sendto+0xc8/0x150
[ 5301.596249]  invoke_syscall+0xdc/0x268
[ 5301.596256]  el0_svc_common.constprop.0+0x16c/0x240
[ 5301.596259]  do_el0_svc+0x48/0x68
[ 5301.596261]  el0_svc+0x50/0x188
[ 5301.596265]  el0t_64_sync_handler+0x120/0x130
[ 5301.596268]  el0t_64_sync+0x194/0x198
[ 5301.596272] Code: eb15001f 54000120 d343fc02 12000801 (38f46842) 
[ 5301.596285] SMP: stopping secondary CPUs
[ 5301.597053] Starting crashdump kernel...
[ 5301.597057] Bye!

Yeoreum and I don't know if the patch we wrote will fix the underlying cause,
but we think that priority is to prevent kernel panic happening.
So, we're sending this patch.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/trace/events/qdisc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index f1b5e816e7e5..170b51fbe47a 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -81,7 +81,7 @@ TRACE_EVENT(qdisc_reset,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
-		__string(	dev,		qdisc_dev(q)->name	)
+		__string(dev, qdisc_dev(q) ? qdisc_dev(q)->name : "noop_queue")
 		__string(	kind,		q->ops->id		)
 		__field(	u32,		parent			)
 		__field(	u32,		handle			)
-- 
2.45.2


