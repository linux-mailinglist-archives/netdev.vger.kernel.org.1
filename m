Return-Path: <netdev+bounces-209364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EA1B0F656
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD41716DBD7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0A32FA62C;
	Wed, 23 Jul 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZVAcdzUz"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3335B2F8C24;
	Wed, 23 Jul 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282169; cv=none; b=B1pQs/xiGpJRrOrWEQ2NunaWyMT4e8eAzsoUC0K6eCC+SGja1KTpnSp6yZ8ean/WtHkjrC740CZkUnvwjRtEmEIa7l3uVNKGWVvn7Ep7erR9KRsHcsSVMydJCHoo6ros2R/85oH+w22x+5z4MNO5QDTyWbwLAwD3j5boi9oiUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282169; c=relaxed/simple;
	bh=bVEPW8trOPxREgpEULJ+V2nr0MfDXTvoz1xVhduQmv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qDU4GCtb4FlAAZu7KIDn4FTB0UV7wkVTQWVbeNn3t5vO9BC+vw/zER1L/MsE4fMrRncxrFNwL5r7nFL/JeIClrpNUbOBaLfIu1ie4N49fqUpMrujXU3JTYGt8hCKe88so77zLTpdmeyDWIG6dZivKQIEpeEsPM4bCtwRnqt0AEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZVAcdzUz; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cS
	wtl9rPdjwJyihwf67rWxSNsxvXiR2nFdG7CrLvMi4=; b=ZVAcdzUzn1xis4xrEL
	WAy/AgxHwmvKVi2Mbrt8e5my/o6WR/I7V136lwvoN6FZyD/eSsodHSxUuBUIR7VW
	qahZYD/bmTqsEBhwHfGvOMs5ZBhwD9WUtTxzvW+SDoQSRgbT8FnzotsOtdQgU7KY
	2hsfHntRNI1bkz05uZwu+6tjk=
Received: from H00576042-PD8FB.china.huawei.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3uXom9oBoW0PHBg--.55850S2;
	Wed, 23 Jul 2025 22:48:08 +0800 (CST)
From: huyizhen2024@163.com
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andy@greyhouse.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [Discuss] KASAN: null-ptr-deference in qdisc_tree_reduce_backlog
Date: Wed, 23 Jul 2025 22:48:27 +0800
Message-ID: <20250723144828.664-1-huyizhen2024@163.com>
X-Mailer: git-send-email 2.45.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:PSgvCgD3uXom9oBoW0PHBg--.55850S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryUZry3uw18Jr4kAw43KFg_yoWrWw17pr
	y5Xr9rCr40yr17Ary3Zw15J348Kr43Aa18Xr48Jr1rAF17Gr1Yqr17JrWjkrnagr13J3W7
	tr1Dtw40qryUGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um1v-UUUUU=
X-CM-SenderInfo: pkx1x6hkhqjiisu6il2tof0z/1tbiowGTp2iA6RDv8gAAsa

Hello.=0D
=0D
KASAN found a null ptr deference in qdisc_tree_reduce_backlog.=0D
If cops->find cannot find a qdisc, it returns NULL.=0D
And if cops->qlen_notify doesn't valid arg, it will deference the NULL ptr,=
 resulting in a kernel crash.=0D
Should we add a check for the argument in cops->qlen_notify?=0D
=0D
Looking forward to your reply, thank you!=0D
=0D
net\sched\sch_hfsc.c:1237 hfsc_qlen_notify-null-ptr-deref=0D
=0D
other info that might help debug this:=0D
=0D
crash> bt=0D
PID: 2297     TASK: ffff8881666aa540  CPU: 0    COMMAND: "syz-executor.1"=0D
#0 [ffffc9001597f3b0] machine_kexec at ffffffff81206168=0D
#1 [ffffc9001597f420] __crash_kexec at ffffffff81492da1=0D
#2 [ffffc9001597f4e8] panic at ffffffff8131dde6=0D
#3 [ffffc9001597f570] oops_end at ffffffff8119e82b=0D
#4 [ffffc9001597f598] page_fault_oops at ffffffff8122786c=0D
#5 [ffffc9001597f630] kernelmode_fixup_or_oops at ffffffff81228125=0D
#6 [ffffc9001597f658] __bad_area_nosemaphore at ffffffff8122841f=0D
#7 [ffffc9001597f6a0] exc_page_fault at ffffffff8683eb70=0D
#8 [ffffc9001597f730] asm_exc_page_fault at ffffffff86a00c12=0D
    [exception RIP: hfsc_qlen_notify+17]=0D
    RIP: ffffffff85e29141  RSP: ffffc9001597f7e0  RFLAGS: 00010216=0D
    RAX: 0000000000001d66  RBX: 0000000000000000  RCX: 0000000000040000=0D
    RDX: ffffc90006512000  RSI: ffff8881666aa540  RDI: 0000000000000002=0D
    RBP: 00000000000affe0   R8: 0000000000000001   R9: 0000000000000000=0D
    R10: 0000000000000000  R11: 0000000000000000  R12: ffffffff87691f60=0D
    R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000000=0D
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018=0D
#9 [ffffc9001597f7f8] qdisc_tree_reduce_backlog at ffffffff85dece27=0D
#10 [ffffc9001597f830] codel_change at ffffffff85e4fe44=0D
#11 [ffffc9001597f8a0] codel_init at ffffffff85e50223=0D
#12 [ffffc9001597f8c0] qdisc_create at ffffffff85deb1d8=0D
#13 [ffffc9001597f930] tc_modify_qdisc at ffffffff85deb9c9=0D
#14 [ffffc9001597fa38] rtnetlink_rcv_msg at ffffffff85d43739=0D
#15 [ffffc9001597fac8] netlink_rcv_skb at ffffffff85e913f5=0D
#16 [ffffc9001597fbb8] netlink_unicast at ffffffff85e907f1=0D
#17 [ffffc9001597fc00] netlink_sendmsg at ffffffff85e91973=0D
#18 [ffffc9001597fc80] __sock_sendmsg at ffffffff85cc765e=0D
#19 [ffffc9001597fca0] ____sys_sendmsg at ffffffff85cc7de2=0D
#20 [ffffc9001597fd18] ___sys_sendmsg at ffffffff85ccbc0c=0D
#21 [ffffc9001597fe70] __sys_sendmsg at ffffffff85ccbd47=0D
#22 [ffffc9001597ff28] do_syscall_64 at ffffffff8683612c=0D
#23 [ffffc9001597ff50] entry_SYSCALL_64_after_hwframe at ffffffff86a00130=0D
    RIP: 00007fc942692bdd  RSP: 00007fc9433bebf8  RFLAGS: 00000246=0D
    RAX: ffffffffffffffda  RBX: 00007fc9427dbf80  RCX: 00007fc942692bdd=0D
    RDX: 0000000000004000  RSI: 0000000020000280  RDI: 0000000000000003=0D
    RBP: 00007fc9426f0499   R8: 0000000000000000   R9: 0000000000000000=0D
    R10: 0000000000000000  R11: 0000000000000246  R12: 0000000000000000=0D
    R13: 00007ffcb898b86f  R14: 00007ffcb898ba10  R15: 00007fc9433bed80=0D
ORIG_RAX: 000000000000002e  CS: 0033  SS: 002b=0D
=0D
crash> dis -l hfsc_qlen_notify 10=0D
/data/nq/kernel/net/sched/sch_hfsc.c: 1231=0D
0xffffffff85e29130 <hfsc_qlen_notify>:  nopl   0x0(%rax,%rax,1) [FTRACE NOP=
]=0D
/data/nq/kernel/net/sched/sch_hfsc.c: 1232=0D
0xffffffff85e29135 <hfsc_qlen_notify+5>:        push   %r12=0D
0xffffffff85e29137 <hfsc_qlen_notify+7>:        push   %rbp=0D
0xffffffff85e29138 <hfsc_qlen_notify+8>:        push   %rbx=0D
/data/nq/kernel/net/sched/sch_hfsc.c: 1231=0D
0xffffffff85e29139 <hfsc_qlen_notify+9>:        mov    %rsi,%rbx=0D
/data/nq/kernel/net/sched/sch_hfsc.c: 1232=0D
0xffffffff85e2913c <hfsc_qlen_notify+12>:       call   0xffffffff814f06a0 <=
__sanitizer_cov_trace_pc>=0D
/data/nq/kernel/net/sched/sch_hfsc.c: 1237=0D
0xffffffff85e29141 <hfsc_qlen_notify+17>:       mov    0x2ec(%rbx),%ebp=0D
0xffffffff85e29147 <hfsc_qlen_notify+23>:       xor    %edi,%edi=0D
0xffffffff85e29149 <hfsc_qlen_notify+25>:       mov    %ebp,%esi=0D
0xffffffff85e2914b <hfsc_qlen_notify+27>:       call   0xffffffff814f08b0 <=
__sanitizer_cov_trace_const_cmp4>=


