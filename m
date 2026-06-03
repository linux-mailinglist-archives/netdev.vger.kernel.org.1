Return-Path: <netdev+bounces-294854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rl+WNh5lIGpx2gAAu9opvQ
	(envelope-from <netdev+bounces-294854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:32:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC5563A2AF
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:32:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windowsforum.com header.s=google header.b="h0IVk/F8";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294854-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294854-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windowsforum.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E98CE300697C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D963F1ADF;
	Wed,  3 Jun 2026 17:19:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0E3CF058
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 17:19:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507165; cv=none; b=IvuRGHTmacZxRIRriQLWPHxKsapvF7rnoUQvFWmppSOvRQ6C1ubXzzmEj9n9OHfn6mozprBiKqLvIDmKs5mTKVNc8tgmMHtxJhOu1xfHkaFnfXPwQB8It/RKLRXraPg1nOCqk+Q+KEnpM35N2GkCV83HHZu0c9KTnhdZax1u4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507165; c=relaxed/simple;
	bh=VLF+LayEOr5KmUxIX1WlSz9l48Q6IKeLoJ2BtvtwMcM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=GnE4d+TM+QNaRLZJOWJ9TtCBWz32ahbAZjsJh24OvB4gr9V43s+MtCdFKt+3YaVidXgBWDj+FSFowC5dmPEps+EhTvnV+XMMe62nsfqjce1LZIej+IpvnJ4R+Jg25XC2TRS+logooz58uJnhe8+uIodIFv5ECMYVo4esmgNX1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windowsforum.com; spf=pass smtp.mailfrom=windowsforum.com; dkim=pass (1024-bit key) header.d=windowsforum.com header.i=@windowsforum.com header.b=h0IVk/F8; arc=none smtp.client-ip=209.85.160.227
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-516e1525aa3so131219431cf.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=windowsforum.com; s=google; t=1780507163; x=1781111963; darn=vger.kernel.org;
        h=date:message-id:content-transfer-encoding:mime-version:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=saWlKyQ87/MeQoISTJO/trx1/KxPgh+ADwnjVEvOBN4=;
        b=h0IVk/F8qtvVUZzosnzlgCOiGA97I5qE3lgqZNjIVgYJIuMmG2qt6tilUldoulzOFe
         wd6YJRur2qqWFc+pHOnFNUUSKmmq9CpOu+mXnxhH7eEY+UllNU+hQzyuXkbrtjU2DARi
         vy7JnrdNuXDSRCRyoZaTF6rrFguFesxEZyHxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780507163; x=1781111963;
        h=date:message-id:content-transfer-encoding:mime-version:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saWlKyQ87/MeQoISTJO/trx1/KxPgh+ADwnjVEvOBN4=;
        b=PvmQgOp2bttO69azmYHm7bNT8+yuY2ieB/5I79qbkVhidqzo/mffDkBLNymVQsenpR
         rUeMy24ZGNl/jmHn05NA4EpA8qnraIomLTnU82y5LYDKj2P3PiG5UJTwXwkHK56rQSOz
         4llxP9h5WO8FltSOswuFjB3dJ1XQO5EElpO6pGLkwYdzJ4Fmwt3BJ4hQjkLxdyWfrZRx
         0wyxreoaScwChwv4APx8JBXcX6U7p4ZkvJOMgI5WY0pgR+bl+NesjdgMaBWBrUy7ZQ1u
         LXu9czQpMLtH8BLfzd8C2sSIJx5R0/SX5kVfv2uEHn9DuYRwbDoLhjATIk2rtKzRUnxc
         hzdQ==
X-Gm-Message-State: AOJu0Yxkmr/dMDmxnyEE5Tzr1YbiZVZ14AEppN9Xm0XXkHuJw/dB8fOH
	FVIMUxLqAItj1Z/fd8MtMXmCHKRVLs8eQZktbLEyGj6N1nwfuOLBDbq8cMP7BKcJ+9wNqSF6ibU
	UGEAWDJNDxDkx8Nn/KuFVQjCN6r/fNEHpnw94
X-Gm-Gg: Acq92OEALQvxh9e2vw+BLJlUxDBjRlpGEd7afVxFD1a0+hpRJgeG2jxeKjQACztkC+r
	16R4tjr8JTZS/xiWUbpR4j41Ozr74cUquTzcG6A/2OVuql0EDVkln4UaVteIu767URIotjG53nC
	g/qMADottJhLa0gIwnx9RMxyVNYI7H6mKVXkIJxDO0IJmlK/q1N50MVOXx0tB+rTE2RgQOHVN1F
	BLIKDSRtG1kuQ4aBRgM/X4aKCDA6XNE9CyeW+UUY3ez9tTlD479L8bUGN4d7itHtqnnDV5/rF8I
	XJvM6xKBXgb5Wj8JrIFqDqUzsjmG2do6p3JvMIgW2xQPrrsJlwnA8C3afexyyLLKknDGsne5jXO
	KF2vtUiX9y5wm2jqx9tIUv8+JevCaUkZb9J35H/kiMnJ3qX4boPsKTLy19aW4NMMZpGrJAdN2oo
	A4cI6QJwM=
X-Received: by 2002:ac8:5cc5:0:b0:50d:7c4b:5c5b with SMTP id d75a77b69052e-5177862168emr66205711cf.5.1780507162673;
        Wed, 03 Jun 2026 10:19:22 -0700 (PDT)
Received: from windowsforum.com (116.9.196.104.bc.googleusercontent.com. [104.196.9.116])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51775d1107esm1270061cf.20.2026.06.03.10.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:19:22 -0700 (PDT)
X-Relaying-Domain: windowsforum.com
Received: by windowsforum.com (Postfix, from userid 0)
	id 4A1512AA9D4; Wed, 03 Jun 2026 17:19:22 +0000 (UTC)
From: Mike Fara <admin@windowsforum.com>
To: netdev@vger.kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>,
    John Fastabend <john.fastabend@gmail.com>,
    Jakub Kicinski <kuba@kernel.org>,
    Sabrina Dubroca <sd@queasysnail.net>,
    David Howells <dhowells@redhat.com>,
    Eric Dumazet <edumazet@google.com>,
    Paolo Abeni <pabeni@redhat.com>,
    Mike Fara <mjfara@gmail.com>,
    linux-kernel@vger.kernel.org
Subject: [RFC net] tls: TLS_SW sendfile() stalls at large MSS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20260603171922.4A1512AA9D4@windowsforum.com>
Date: Wed, 03 Jun 2026 17:19:22 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[windowsforum.com,reject];
	R_DKIM_ALLOW(-0.20)[windowsforum.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,redhat.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294854-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[admin@windowsforum.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:dhowells@redhat.com,m:edumazet@google.com,m:pabeni@redhat.com,m:mjfara@gmail.com,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windowsforum.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admin@windowsforum.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windowsforum.com:mid,windowsforum.com:from_mime,windowsforum.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DC5563A2AF

Hi,

Software-kTLS (TLS_SW) TX over sendfile()/splice() drops to the TCP
persist-timer cadence (tens of KB/s, with individual sendfile() calls blocking
for tens of seconds) when the path MSS is large -- e.g. loopback (MSS 65483) or
jumbo frames. At a typical 1448-byte MSS it does not occur. Plain TCP
sendfile() on the same path is unaffected, and kTLS write() (no splice) is
unaffected, so it is specific to TLS_SW + the splice/sendfile path.

It triggers only on large-MSS paths with software kTLS (no NIC TLS offload), so
it is a niche path -- but it is a clean, reproducible multi-order-of-magnitude
cliff, so it seems worth a look. Reproduces on current mainline. CCing David
Howells as the author of the 2023 sendpage->MSG_SPLICE_PAGES splice_to_socket()
rework referenced below, and Eric/Paolo as this is as much a TCP-corking
interaction as a TLS one.

Environment
-----------
- net/tls TLS_SW (no NIC offload; ethtool tls-hw-tx-offload: off [fixed]).
- AES-GCM; gcm(aes) resolves to generic-gcm-vaes-avx512.

Reproducer (no OpenSSL/handshake; TLS_TX programmed with a fixed key, the
receiver discards ciphertext, like tools/testing/selftests/net/tls.c):

    cc -O2 -Wall -o ktls_sendfile_stall ktls_sendfile_stall.c
    ./ktls_sendfile_stall          # default loopback MSS (65483)
    ./ktls_sendfile_stall 1448     # clamp sender MSS via TCP_MAXSEG

Observed (loopback, single box):

    MSS=default    sent=     4.0 MiB in  52.08s  =>  0.0001 GiB/s   (stalled)
    MSS=1448       sent=  2048.0 MiB in   1.65s  =>  1.2106 GiB/s

i.e. ~four orders of magnitude; at the default MSS a single sendfile() blocks
for tens of seconds. For contrast, on the same loopback path:

    plain TCP sendfile() (no TLS ULP):           7.87  GiB/s
    kTLS write() (TLS_SW, no splice, 2 GiB):      1.99  GiB/s

Analysis
--------
During the stall the sending thread is parked here:

    [<0>] sk_stream_wait_memory+0x256/0x380
    [<0>] tls_sw_sendmsg+0x1f1/0xc40       /* tls_sw_sendmsg_locked, inlined */
    [<0>] inet_sendmsg+0x7f/0x90
    [<0>] sock_sendmsg+0x183/0x1a0
    [<0>] splice_to_socket+0x3e0/0x5b0
    [<0>] splice_direct_to_actor+0xf7/0x2c0
    [<0>] do_splice_direct+0x71/0xd0
    [<0>] do_sendfile+0x390/0x440

and ss(8) shows exactly one completed TLS record held, behind a persist timer,
with the peer window wide open:

    ESTAB ... timer:(persist,028ms,0) ... notsent:16406 snd_wnd:1114112
            ... mss:65483 ... tcp-ulp-tls version: 1.3 ... txconf: sw

notsent:16406 is one TLS1.3 record (TLS_MAX_PAYLOAD_SIZE 16384 + 22). It is a
*completed* record, yet TCP is corking it.

The chain appears to be:

  1. For sendfile, splice_direct_to_actor() sets SPLICE_F_MORE on every
     iteration and clears it only on the final chunk that fulfils the request,
     so splice_to_socket() passes MSG_MORE on every send but the last. (This is
     the intended coalescing behaviour from the 2023 MSG_SPLICE_PAGES rework;
     naming it as the origin is a hypothesis, not a confirmed bisect.)
  2. tls_sw_sendmsg_locked() forwards msg->msg_flags (incl. MSG_MORE) into
     bpf_exec_tx_verdict()/tls_push_record() even for a *full* record, so the
     completed record reaches tcp_sendmsg_locked() (via tls_push_sg(), which
     builds msghdr.msg_flags = MSG_SPLICE_PAGES | flags) with MSG_MORE set.
  3. With a large MSS the 16 KB record is far below MSS, so TCP corks it
     waiting to fill a segment.
  4. tls_sw then can't build the next record -- it blocks in
     sk_stream_wait_memory() for memory the corked record is holding.
  5. tcp_write_xmit() leaves the corked record unsent with packets_out == 0, so
     tcp_check_probe_timer() arms the persist (probe-0) timer even though the
     window is open; each expiry pushes ~one record -> the observed rate. At a
     1448-byte MSS each 16 KB record already exceeds MSS and is sent, so the
     cork never engages.

Candidate fix (illustrative sketch -- NOT a submittable patch, no S-o-b; the
right shape is your call given the coalescing intent). A full TLS record is a
natural transmit boundary, so arguably MSG_MORE should not be honoured for it,
only for a trailing partial record. In tls_sw_sendmsg_locked():

    if (full_record || eor) {
+           unsigned int send_flags = msg->msg_flags;
+
+           if (full_record)
+                   send_flags &= ~MSG_MORE;
            ret = bpf_exec_tx_verdict(msg_pl, sk, full_record,
-                                     record_type, &copied, msg->msg_flags);
+                                     record_type, &copied, send_flags);

Caveats I'm aware of: (a) there are two bpf_exec_tx_verdict() call sites in the
function passing msg->msg_flags -- the splice path reaches the one at `copied:`
label (via `goto copied`), so this one-site change covers the repro, but a
complete fix would clear MSG_MORE at both; (b) this stops coalescing each
record's trailing partial into the next TSO segment, partly undoing the 2023
optimisation, so a narrower fix that only flushes when about to block in
sk_stream_wait_memory() may be preferable. Happy to spin whichever you prefer
and run it through the tls selftests.

Thanks,
Mike Fara

--- ktls_sendfile_stall.c ---
// ktls_sendfile_stall.c
//
// Minimal, dependency-free reproducer for a software-kTLS (TLS_SW) TX stall:
// sendfile()/splice() over a kTLS socket collapses to the TCP persist-timer
// cadence when the path MSS is large (loopback's 65483, or jumbo frames),
// because splice sets MSG_MORE on every chunk but the last and tls_sw forwards
// it to TCP even for *completed* records, so TCP corks the sub-MSS record while
// tls_sw blocks in sk_stream_wait_memory().
//
// No handshake / no OpenSSL: TLS_TX is programmed with a fixed key (the receiver
// discards ciphertext; we only measure the TX path), exactly like the in-tree
// tls selftest. Clamping the sender MSS to a realistic value makes the stall
// vanish, isolating the large-MSS amplifier.
//
//   cc -O2 -Wall -o ktls_sendfile_stall ktls_sendfile_stall.c
//   ./ktls_sendfile_stall          # default loopback MSS (65483) -> stalls
//   ./ktls_sendfile_stall 1448     # clamp sender MSS via TCP_MAXSEG -> normal
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <time.h>
#include <sys/socket.h>
#include <sys/sendfile.h>
#include <sys/wait.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include <linux/tls.h>

#ifndef SOL_TLS
#define SOL_TLS 282
#endif
#ifndef TCP_ULP
#define TCP_ULP 31
#endif

#define PORT     18999
#define FILESZ   (4 * 1024 * 1024)            /* 4 MiB backing file, looped     */
#define TOTAL    (2ULL * 1024 * 1024 * 1024)  /* try to send 2 GiB              */
#define STALL_S  20.0                         /* give up after this many seconds */

static void die(const char *what) { perror(what); exit(1); }

static double now(void)
{
	struct timespec t;
	clock_gettime(CLOCK_MONOTONIC, &t);
	return t.tv_sec + t.tv_nsec / 1e9;
}

static void set_ktls_tx(int fd)
{
	struct tls12_crypto_info_aes_gcm_128 ci;

	if (setsockopt(fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls")))
		die("setsockopt(TCP_ULP, tls)");
	memset(&ci, 0, sizeof(ci));
	ci.info.version     = TLS_1_3_VERSION;          /* matches the 16406 ss line */
	ci.info.cipher_type = TLS_CIPHER_AES_GCM_128;
	memset(ci.iv,      1, sizeof(ci.iv));
	memset(ci.key,     2, sizeof(ci.key));
	memset(ci.salt,    3, sizeof(ci.salt));
	memset(ci.rec_seq, 0, sizeof(ci.rec_seq));
	if (setsockopt(fd, SOL_TLS, TLS_TX, &ci, sizeof(ci)))
		die("setsockopt(SOL_TLS, TLS_TX)");
}

int main(int argc, char **argv)
{
	int mss = (argc > 1) ? atoi(argv[1]) : 0;   /* 0 == leave default; >0 clamps */
	char path[] = "/tmp/ktls_repro_dataXXXXXX";
	struct sockaddr_in a;
	char *buf;
	int ffd, lfd, s, one = 1;
	pid_t pid;
	double t0, el;
	unsigned long long sent = 0;
	off_t off = 0;

	/* A dead/RST'd receiver must surface as EPIPE from sendfile(), not a
	 * silent SIGPIPE kill that would make the reproducer look broken. */
	signal(SIGPIPE, SIG_IGN);

	/* backing file */
	ffd = mkstemp(path);
	if (ffd < 0)
		die("mkstemp");
	buf = malloc(FILESZ);
	if (!buf)
		die("malloc");
	memset(buf, 'x', FILESZ);
	if (write(ffd, buf, FILESZ) != FILESZ)
		die("write");
	free(buf);

	memset(&a, 0, sizeof(a));
	a.sin_family      = AF_INET;
	a.sin_port        = htons(PORT);
	a.sin_addr.s_addr = htonl(INADDR_LOOPBACK);

	lfd = socket(AF_INET, SOCK_STREAM, 0);
	if (lfd < 0)
		die("socket");
	setsockopt(lfd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
	if (mss > 0)   /* announce a small MSS in the SYN-ACK; inherited by accept() */
		setsockopt(lfd, IPPROTO_TCP, TCP_MAXSEG, &mss, sizeof(mss));
	if (bind(lfd, (void *)&a, sizeof(a)))
		die("bind");
	if (listen(lfd, 1))
		die("listen");

	pid = fork();
	if (pid < 0)
		die("fork");
	if (pid == 0) {                 /* receiver: connect, drain ciphertext, discard */
		int c = socket(AF_INET, SOCK_STREAM, 0);
		char *r = malloc(1 << 20);
		ssize_t n;

		if (c < 0 || !r)
			_exit(1);
		while (connect(c, (void *)&a, sizeof(a)))
			usleep(1000);
		while ((n = read(c, r, 1 << 20)) > 0)
			;
		_exit(0);
	}

	s = accept(lfd, 0, 0);
	if (s < 0)
		die("accept");
	set_ktls_tx(s);

	t0 = now();
	while (sent < TOTAL) {
		ssize_t n;
		size_t want;

		if (off >= FILESZ)
			off = 0;
		want = (size_t)(FILESZ - off);
		if (want > TOTAL - sent)
			want = TOTAL - sent;
		n = sendfile(s, ffd, &off, want);
		if (n < 0) {
			if (errno == EINTR)
				continue;
			perror("sendfile");
			break;
		}
		if (n == 0)
			break;
		sent += n;
		if (now() - t0 > STALL_S) {
			printf("[gave up after %.0fs]\n", STALL_S);
			break;
		}
	}
	el = now() - t0;
	printf("MSS=%-9s  sent=%8.1f MiB in %6.2fs  =>  %.4f GiB/s\n",
	       mss ? argv[1] : "default", sent / 1048576.0, el,
	       sent / el / (1024.0 * 1024 * 1024));

	close(s);
	kill(pid, SIGKILL);
	waitpid(pid, NULL, 0);
	unlink(path);
	return 0;
}

