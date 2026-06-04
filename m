Return-Path: <netdev+bounces-295239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U3XCCwx5IWpHHAEAu9opvQ
	(envelope-from <netdev+bounces-295239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:09:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7AB640320
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:09:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Mh75WeY2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295239-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295239-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D6EC3085BB8
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B1C47D94B;
	Thu,  4 Jun 2026 13:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCB3812E4
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 13:00:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578025; cv=none; b=RC2apQ+lxGGdpyvmQMkYuhaOeeS9Cu+eZ0dW4QRbtoFgmpebMmTKdGXfh5Yvv61+ZAHmv9bonMvA0dMOTGC5lVicTreo0aZgsnyYhX7U35sLp6UHcwo5zS9q1UknWdZPf/hHmHa919wkDsnc0Y/PQRk8bMM3F6D2mk9Wp2i69ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578025; c=relaxed/simple;
	bh=OO0dDFivSA0E09fU38wSdLpLNdAtE4rak7aLypv+Lek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOKyRo8Bo1fuLYK4Fit/99t70tz/96FEfw7wRvGDl/YX26dxr/477DjnqEXyxdNoC2opetLdy33Fhvt5Ctc2aEvnxrme7NBGoDzIMvI4QpPxsbFM5yKOnqs5CGTRXWj2vjbecQ5WksS5DT5ry/bW6PwVa6BPwRi7mJheewPNlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh75WeY2; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b613a17bso6779865e9.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780578022; x=1781182822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENy60lKyhsJzKa6AmDMssM3ZUNPvmzlyov5yWYu2x6o=;
        b=Mh75WeY2Slgj1Wwcyjq+mhQl4slzt9amH50iquseu+5wrS+UYszynbIjGYwZByrYWD
         0dfo0NM9aOvTuYjKonsnjeeaAbl8qlAdvI2j2OTcslI3yzSFLOZZsTPPu3exl6Z0fIO8
         zFHnyKmayyUXAR+ocNnLt/7nX3LHDAUcwDFCY8RxlyjHM/AbZnocn4X0uol7xXUKVafa
         MkyVgN5H4MINbQNa39JIuCsLzIRh5FECp6jx9vzotyEYDZdZNVjEOaOP4f3GET4O23kd
         WEv/mO7ev5seW2MjefpDCGWKjoG4oEfAZLUZpsygJFto1J33Ct9b2OYns73/sk8bhz17
         KkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780578022; x=1781182822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENy60lKyhsJzKa6AmDMssM3ZUNPvmzlyov5yWYu2x6o=;
        b=kbEFxEHzC/Ny0TV6IsaCyY1d/zmmdjVRktYpeIbDTxJO36/pWLv6oWQnWJwohXorwO
         5YpqEysMLTdik2vFq9toqFnBff3jhthWDQe5N6VnmprkT8HyH6IJ610jwkac55ppxr84
         KVSONk5W1Ul8vmyddZou/z+gSpfIX3lPXFmYb+7P7ijT+FPm60KN+tM/Oa5bvDX92X4b
         svFAVnuZWvyhV02RL16DIhMDkRfY/Yvgs19qkKix81IiW6d0bFm795+CwIdiEt+dyv7i
         O4xcfJH62ha1GGUmwoT2gPGtHdctoaDGUzFcsX4Q0SwiMFM55jKxzUM0mvjPeoDM97Qa
         LvkQ==
X-Gm-Message-State: AOJu0Ywl2ziOtK8A3LxO4iXH06YDDbVQGC7hBU2H2gvxayFH5X+kcnzS
	Zq5cHdD9tagQNudy4wLAAA3NWnvAWQmaVhnNFOAqWkXsCdYgVdwsYQhju+M9UETo
X-Gm-Gg: Acq92OFw66dId9KLwjdc0E7aAuFJqkAcq0BBJqZp/7ERdv+frkdbgEgJx+ktgFQgMSE
	YqYUleKQCmB3r3VhT4aoUyjjPYEhKAH4dUPSspz0eAHIDP4gawqu/6sYbnSrrgid0g8MAJ0+Kud
	AVF6o1ZjLYGWrw2fnHEBH8Gm+J4fASraRQ4PjuegrzE+s4HjtUSvgldDpSnHOp9SW0yBURMYNiQ
	K3+UzfKfa6UiXryau1SCnIpbw7zadVYP1Fci65oMiXa0IEOCiKJGxQJ96pVNDs6PkNRxUjyT+5z
	QCxCkgO9QPATx2ISATC7dM7DDBFPHCi+tuLfvoeLFyganLr8pzsYS1LwOMvSCkBM8PzMg5nnX5m
	J4J4KtqQquogegP3WtXe1FTHjhCP9zQbNEwy9tu095BD4Aw59Wc82QWE6xXSE05P0KNjoytlCes
	jRizVj33ItmSXRX+/b9qEzUoozjBXpQ7FvN9TTG0D2nKi9sMXeGGZwNAeFJ+1swQUnjA7bnxg=
X-Received: by 2002:a05:600c:4fc6:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490b5e950admr126318905e9.10.1780578021970;
        Thu, 04 Jun 2026 06:00:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc40716bsm69277845e9.12.2026.06.04.06.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:00:21 -0700 (PDT)
Date: Thu, 4 Jun 2026 14:00:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mike Fara <admin@windowsforum.com>
Cc: netdev@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, John
 Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Mike
 Fara <mjfara@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC net] tls: TLS_SW sendfile() stalls at large MSS
Message-ID: <20260604140018.69c9d9d0@pumpkin>
In-Reply-To: <20260603171922.4A1512AA9D4@windowsforum.com>
References: <20260603171922.4A1512AA9D4@windowsforum.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295239-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:admin@windowsforum.com,m:netdev@vger.kernel.org,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:dhowells@redhat.com,m:edumazet@google.com,m:pabeni@redhat.com,m:mjfara@gmail.com,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,queasysnail.net,redhat.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,windowsforum.com:email,vger.kernel.org:from_smtp,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB7AB640320

On Wed, 03 Jun 2026 17:19:22 +0000 (UTC)
Mike Fara <admin@windowsforum.com> wrote:

> Hi,
> 
> Software-kTLS (TLS_SW) TX over sendfile()/splice() drops to the TCP
> persist-timer cadence (tens of KB/s, with individual sendfile() calls blocking
> for tens of seconds) when the path MSS is large -- e.g. loopback (MSS 65483) or
> jumbo frames. At a typical 1448-byte MSS it does not occur. Plain TCP
> sendfile() on the same path is unaffected, and kTLS write() (no splice) is
> unaffected, so it is specific to TLS_SW + the splice/sendfile path.
> 
> It triggers only on large-MSS paths with software kTLS (no NIC TLS offload), so
> it is a niche path -- but it is a clean, reproducible multi-order-of-magnitude
> cliff, so it seems worth a look. Reproduces on current mainline. CCing David
> Howells as the author of the 2023 sendpage->MSG_SPLICE_PAGES splice_to_socket()
> rework referenced below, and Eric/Paolo as this is as much a TCP-corking
> interaction as a TLS one.
> 
> Environment
> -----------
> - net/tls TLS_SW (no NIC offload; ethtool tls-hw-tx-offload: off [fixed]).
> - AES-GCM; gcm(aes) resolves to generic-gcm-vaes-avx512.
> 
> Reproducer (no OpenSSL/handshake; TLS_TX programmed with a fixed key, the
> receiver discards ciphertext, like tools/testing/selftests/net/tls.c):
> 
>     cc -O2 -Wall -o ktls_sendfile_stall ktls_sendfile_stall.c
>     ./ktls_sendfile_stall          # default loopback MSS (65483)
>     ./ktls_sendfile_stall 1448     # clamp sender MSS via TCP_MAXSEG
> 
> Observed (loopback, single box):
> 
>     MSS=default    sent=     4.0 MiB in  52.08s  =>  0.0001 GiB/s   (stalled)
>     MSS=1448       sent=  2048.0 MiB in   1.65s  =>  1.2106 GiB/s
> 
> i.e. ~four orders of magnitude; at the default MSS a single sendfile() blocks
> for tens of seconds. For contrast, on the same loopback path:
> 
>     plain TCP sendfile() (no TLS ULP):           7.87  GiB/s
>     kTLS write() (TLS_SW, no splice, 2 GiB):      1.99  GiB/s
> 
> Analysis
> --------
> During the stall the sending thread is parked here:
> 
>     [<0>] sk_stream_wait_memory+0x256/0x380
>     [<0>] tls_sw_sendmsg+0x1f1/0xc40       /* tls_sw_sendmsg_locked, inlined */
>     [<0>] inet_sendmsg+0x7f/0x90
>     [<0>] sock_sendmsg+0x183/0x1a0
>     [<0>] splice_to_socket+0x3e0/0x5b0
>     [<0>] splice_direct_to_actor+0xf7/0x2c0
>     [<0>] do_splice_direct+0x71/0xd0
>     [<0>] do_sendfile+0x390/0x440
> 
> and ss(8) shows exactly one completed TLS record held, behind a persist timer,
> with the peer window wide open:
> 
>     ESTAB ... timer:(persist,028ms,0) ... notsent:16406 snd_wnd:1114112
>             ... mss:65483 ... tcp-ulp-tls version: 1.3 ... txconf: sw
> 
> notsent:16406 is one TLS1.3 record (TLS_MAX_PAYLOAD_SIZE 16384 + 22). It is a
> *completed* record, yet TCP is corking it.
> 
> The chain appears to be:
> 
>   1. For sendfile, splice_direct_to_actor() sets SPLICE_F_MORE on every
>      iteration and clears it only on the final chunk that fulfils the request,
>      so splice_to_socket() passes MSG_MORE on every send but the last. (This is
>      the intended coalescing behaviour from the 2023 MSG_SPLICE_PAGES rework;
>      naming it as the origin is a hypothesis, not a confirmed bisect.)
>   2. tls_sw_sendmsg_locked() forwards msg->msg_flags (incl. MSG_MORE) into
>      bpf_exec_tx_verdict()/tls_push_record() even for a *full* record, so the
>      completed record reaches tcp_sendmsg_locked() (via tls_push_sg(), which
>      builds msghdr.msg_flags = MSG_SPLICE_PAGES | flags) with MSG_MORE set.
>   3. With a large MSS the 16 KB record is far below MSS, so TCP corks it
>      waiting to fill a segment.

Shouldn't it be using the MSS set by TCP_MAXSEG?
I guess there are also interactions with SO_SNDBUF.
If the MSS is larger than the SO_SNDBUF value don't you need to send the packet
even if it is 'corked' for any reason?
IIRC all the 'cork' options are just a hint for TCP and can be ignored. 

>   4. tls_sw then can't build the next record -- it blocks in
>      sk_stream_wait_memory() for memory the corked record is holding.

Shouldn't it be using SO_SNDBUF limit there?
I'd have thought the memory wouldn't be freed until the ack is received.
I don't see why you shouldn't have lots of short messages in flight.

-- David

>   5. tcp_write_xmit() leaves the corked record unsent with packets_out == 0, so
>      tcp_check_probe_timer() arms the persist (probe-0) timer even though the
>      window is open; each expiry pushes ~one record -> the observed rate. At a
>      1448-byte MSS each 16 KB record already exceeds MSS and is sent, so the
>      cork never engages.
> 
> Candidate fix (illustrative sketch -- NOT a submittable patch, no S-o-b; the
> right shape is your call given the coalescing intent). A full TLS record is a
> natural transmit boundary, so arguably MSG_MORE should not be honoured for it,
> only for a trailing partial record. In tls_sw_sendmsg_locked():
> 
>     if (full_record || eor) {
> +           unsigned int send_flags = msg->msg_flags;
> +
> +           if (full_record)
> +                   send_flags &= ~MSG_MORE;
>             ret = bpf_exec_tx_verdict(msg_pl, sk, full_record,
> -                                     record_type, &copied, msg->msg_flags);
> +                                     record_type, &copied, send_flags);
> 
> Caveats I'm aware of: (a) there are two bpf_exec_tx_verdict() call sites in the
> function passing msg->msg_flags -- the splice path reaches the one at `copied:`
> label (via `goto copied`), so this one-site change covers the repro, but a
> complete fix would clear MSG_MORE at both; (b) this stops coalescing each
> record's trailing partial into the next TSO segment, partly undoing the 2023
> optimisation, so a narrower fix that only flushes when about to block in
> sk_stream_wait_memory() may be preferable. Happy to spin whichever you prefer
> and run it through the tls selftests.
> 
> Thanks,
> Mike Fara
> 
> --- ktls_sendfile_stall.c ---
> // ktls_sendfile_stall.c
> //
> // Minimal, dependency-free reproducer for a software-kTLS (TLS_SW) TX stall:
> // sendfile()/splice() over a kTLS socket collapses to the TCP persist-timer
> // cadence when the path MSS is large (loopback's 65483, or jumbo frames),
> // because splice sets MSG_MORE on every chunk but the last and tls_sw forwards
> // it to TCP even for *completed* records, so TCP corks the sub-MSS record while
> // tls_sw blocks in sk_stream_wait_memory().
> //
> // No handshake / no OpenSSL: TLS_TX is programmed with a fixed key (the receiver
> // discards ciphertext; we only measure the TX path), exactly like the in-tree
> // tls selftest. Clamping the sender MSS to a realistic value makes the stall
> // vanish, isolating the large-MSS amplifier.
> //
> //   cc -O2 -Wall -o ktls_sendfile_stall ktls_sendfile_stall.c
> //   ./ktls_sendfile_stall          # default loopback MSS (65483) -> stalls
> //   ./ktls_sendfile_stall 1448     # clamp sender MSS via TCP_MAXSEG -> normal
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <errno.h>
> #include <signal.h>
> #include <time.h>
> #include <sys/socket.h>
> #include <sys/sendfile.h>
> #include <sys/wait.h>
> #include <netinet/in.h>
> #include <netinet/tcp.h>
> #include <arpa/inet.h>
> #include <linux/tls.h>
> 
> #ifndef SOL_TLS
> #define SOL_TLS 282
> #endif
> #ifndef TCP_ULP
> #define TCP_ULP 31
> #endif
> 
> #define PORT     18999
> #define FILESZ   (4 * 1024 * 1024)            /* 4 MiB backing file, looped     */
> #define TOTAL    (2ULL * 1024 * 1024 * 1024)  /* try to send 2 GiB              */
> #define STALL_S  20.0                         /* give up after this many seconds */
> 
> static void die(const char *what) { perror(what); exit(1); }
> 
> static double now(void)
> {
> 	struct timespec t;
> 	clock_gettime(CLOCK_MONOTONIC, &t);
> 	return t.tv_sec + t.tv_nsec / 1e9;
> }
> 
> static void set_ktls_tx(int fd)
> {
> 	struct tls12_crypto_info_aes_gcm_128 ci;
> 
> 	if (setsockopt(fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls")))
> 		die("setsockopt(TCP_ULP, tls)");
> 	memset(&ci, 0, sizeof(ci));
> 	ci.info.version     = TLS_1_3_VERSION;          /* matches the 16406 ss line */
> 	ci.info.cipher_type = TLS_CIPHER_AES_GCM_128;
> 	memset(ci.iv,      1, sizeof(ci.iv));
> 	memset(ci.key,     2, sizeof(ci.key));
> 	memset(ci.salt,    3, sizeof(ci.salt));
> 	memset(ci.rec_seq, 0, sizeof(ci.rec_seq));
> 	if (setsockopt(fd, SOL_TLS, TLS_TX, &ci, sizeof(ci)))
> 		die("setsockopt(SOL_TLS, TLS_TX)");
> }
> 
> int main(int argc, char **argv)
> {
> 	int mss = (argc > 1) ? atoi(argv[1]) : 0;   /* 0 == leave default; >0 clamps */
> 	char path[] = "/tmp/ktls_repro_dataXXXXXX";
> 	struct sockaddr_in a;
> 	char *buf;
> 	int ffd, lfd, s, one = 1;
> 	pid_t pid;
> 	double t0, el;
> 	unsigned long long sent = 0;
> 	off_t off = 0;
> 
> 	/* A dead/RST'd receiver must surface as EPIPE from sendfile(), not a
> 	 * silent SIGPIPE kill that would make the reproducer look broken. */
> 	signal(SIGPIPE, SIG_IGN);
> 
> 	/* backing file */
> 	ffd = mkstemp(path);
> 	if (ffd < 0)
> 		die("mkstemp");
> 	buf = malloc(FILESZ);
> 	if (!buf)
> 		die("malloc");
> 	memset(buf, 'x', FILESZ);
> 	if (write(ffd, buf, FILESZ) != FILESZ)
> 		die("write");
> 	free(buf);
> 
> 	memset(&a, 0, sizeof(a));
> 	a.sin_family      = AF_INET;
> 	a.sin_port        = htons(PORT);
> 	a.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> 
> 	lfd = socket(AF_INET, SOCK_STREAM, 0);
> 	if (lfd < 0)
> 		die("socket");
> 	setsockopt(lfd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
> 	if (mss > 0)   /* announce a small MSS in the SYN-ACK; inherited by accept() */
> 		setsockopt(lfd, IPPROTO_TCP, TCP_MAXSEG, &mss, sizeof(mss));
> 	if (bind(lfd, (void *)&a, sizeof(a)))
> 		die("bind");
> 	if (listen(lfd, 1))
> 		die("listen");
> 
> 	pid = fork();
> 	if (pid < 0)
> 		die("fork");
> 	if (pid == 0) {                 /* receiver: connect, drain ciphertext, discard */
> 		int c = socket(AF_INET, SOCK_STREAM, 0);
> 		char *r = malloc(1 << 20);
> 		ssize_t n;
> 
> 		if (c < 0 || !r)
> 			_exit(1);
> 		while (connect(c, (void *)&a, sizeof(a)))
> 			usleep(1000);
> 		while ((n = read(c, r, 1 << 20)) > 0)
> 			;
> 		_exit(0);
> 	}
> 
> 	s = accept(lfd, 0, 0);
> 	if (s < 0)
> 		die("accept");
> 	set_ktls_tx(s);
> 
> 	t0 = now();
> 	while (sent < TOTAL) {
> 		ssize_t n;
> 		size_t want;
> 
> 		if (off >= FILESZ)
> 			off = 0;
> 		want = (size_t)(FILESZ - off);
> 		if (want > TOTAL - sent)
> 			want = TOTAL - sent;
> 		n = sendfile(s, ffd, &off, want);
> 		if (n < 0) {
> 			if (errno == EINTR)
> 				continue;
> 			perror("sendfile");
> 			break;
> 		}
> 		if (n == 0)
> 			break;
> 		sent += n;
> 		if (now() - t0 > STALL_S) {
> 			printf("[gave up after %.0fs]\n", STALL_S);
> 			break;
> 		}
> 	}
> 	el = now() - t0;
> 	printf("MSS=%-9s  sent=%8.1f MiB in %6.2fs  =>  %.4f GiB/s\n",
> 	       mss ? argv[1] : "default", sent / 1048576.0, el,
> 	       sent / el / (1024.0 * 1024 * 1024));
> 
> 	close(s);
> 	kill(pid, SIGKILL);
> 	waitpid(pid, NULL, 0);
> 	unlink(path);
> 	return 0;
> }
> 


