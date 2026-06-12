Return-Path: <netdev+bounces-298425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +jr2GLRdK2qE8AMAu9opvQ
	(envelope-from <netdev+bounces-298425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:15:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2075F676125
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:15:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kzqkRmgY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298425-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298425-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FA7C302EE8A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F6D314D34;
	Fri, 12 Jun 2026 01:15:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002C305664
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:15:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226924; cv=none; b=ELNKQUvMuRofHvjOQgFX5rkt03V0GK3UgUVqiKT2ZulUMoxnZK/J7XSSqhdXdrxxFaiXdX6FPyp42E9cHKf9d73n4JOkXIGSIB2ZmYMwadWZprtfFPL1mt95UqC+PYjs5GfIAcgU3jsGr10F6+EjqlpY/JFoXUOTW6QyLd2wvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226924; c=relaxed/simple;
	bh=oaBfO3K+ZJ8s5V8OQ2o6xH7AxFaOCGtC9XINJ5gRcLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmyQaKTaFXwrQxcUZPhtq5ZMJr1k7Oz+AFVfgyrf4plgUJU1torcqSvoBN9/nOnHbMA/uaz7HYm39QGpCfKZQDty2IiLUYoxJrarqbcokQLbwVl1AKSN4+MfCGRcB1b5tcmy4hJcy6d7AUX6Ctin2iwtnQn/M5psxoTYNu0YOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzqkRmgY; arc=none smtp.client-ip=74.125.82.175
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304d7f31215so515916eec.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226922; x=1781831722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt90eA0uj1dpnA038RPJBctS/XyV3l3vqMVH4k+Tb2I=;
        b=kzqkRmgY7k1dui6LsfSF7sxxqwLqC3GT1wxAEIpAwWPR6b2zgrFRVSTlQ8KseVThks
         1zpf4sp+5yLKuhGtMzkOw8Bvwd5VbmBb64DyGchjmCrw85HK9a0q+KIdjYQobZC21mkH
         PFDKfaKjaiChb7y+eLRMm+IzDUNgCn2oqey/thlkAc1qC0JvUe3INmZ7clWqJmaqpghk
         aSUfuY4lQHFtCU3hnrMo8DRJuPyv/wb6BfEAQym/dvzQrvXIrh/P9BeGEl6F+vPg6zEA
         OgA3GjbAEdThPmcQ1ChN6dHekwPlHhws0asCqBHPdyXWz3diPo0EoKkYj2t6WdeX1TGU
         wGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226922; x=1781831722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qt90eA0uj1dpnA038RPJBctS/XyV3l3vqMVH4k+Tb2I=;
        b=Gdt+GhjLF5kjXSXptO2xvdEbF8EO+ZrHZ+rZAD9poFq1NzsMKZTIY9Zt3vZ4LX0d1f
         IJ5Cv1/SGj46I9AKLdMMVVCpDDUco2fGaR9Bs/yYNFhQoP1IRtSOqRV4iMpmd0Gz93oh
         0npOUwo2rFF+gTFh/eM6/0/JIN5YbcmXb1wB10UYQlYHR/fsak9ftE5/croixb+M+9Ro
         gEOeivQCnpNyeOlkSkLtEw6y3vMITd3obmvim80xm5cyjN6C6UCIutzwhSXeQYuoj+U5
         6tVtt28we5FyjWpGkMDBRoCBwpolit38u2M4IUQAGtlw3FqnqGcamDnblKjdQ2bEYKaD
         VFPw==
X-Gm-Message-State: AOJu0Yy+mUZpFzDZO78EVaj0ypnnAA3XMjxY2arx2FT2FHTZoQzPVD2w
	fi0tVFNF3t6xsd1qnlyiNd7d8e4YPUA/TsbpDUYJ3mpRS/SAXIbFDkM4qbQh5A==
X-Gm-Gg: Acq92OEodzP06C/Fx9dhLYwtmRFOXFZZxf1BPRbITnO/IWqRhOXHH94Wcr7Uwn/Gb4Z
	osPZFTnTdfBrBABR8lDnMdWH2jBoRG6DEjLx+WaiK+L5mCmZzJnIg2FGaKABtWpJ2PTFVgs7aIA
	xJA7L0D/6rjhhQXpHAZ6daXfbpMk62EV5KrAVPYVEamppsQr/fdZoRHj2QEKwQVsjC5ZgWZWeV/
	+n4FC9pYlv6jJhrFsjRsji4HYko0acWw/FbLP/3jsgqts5F/dNDjkp8rU3wXMHLsu0L4auLyDWQ
	S5zXMgOGDguTdboxUBbnNsTQUHgeEWUWKBF3xHDxaZGGdJ6v6KVk4fP3rTcOZwwUchw7f0TOeVU
	18wwr7436FD+LwobxH/X2yjXYGsA1MpCkAq6LO/R/LucS1X+iMbsd4T2i4mKZzdLwfqitxa7hx/
	xp4vcu9woH5RdEW0W9xVWZ2b7pXpgaU421lqNLPvAhpdzXw3OJ2Vs27kxdCqCjBhEe6w==
X-Received: by 2002:a05:7022:6888:b0:138:3e8:cee1 with SMTP id a92af1059eb24-1384bbb6c0fmr308421c88.23.1781226921767;
        Thu, 11 Jun 2026 18:15:21 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm596257c88.13.2026.06.11.18.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:15:21 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	hemanthmalla@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH bpf-next 2/5] tcp_bpf: busy-poll the splice ring before parking the receiver
Date: Thu, 11 Jun 2026 18:14:49 -0700
Message-ID: <20260612011452.134466-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev,bytedance.com,multikernel.io];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298425-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:hemanthmalla@gmail.com,m:zijianzhang@bytedance.com,m:xiyou.wangcong@gmail.com,m:cwang@multikernel.io,m:johnfastabend@gmail.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2075F676125

When a paired-splice receiver finds the ring empty it parks on the
socket waitqueue. For latency-bound synchronous-RPC workloads that is
a wakeup per request-response cycle, which dominates the per-cycle
cost.

Add an optional bounded busy-poll of the ring before parking, reusing
the socket's SO_BUSY_POLL budget (sk_ll_usec) via sk_can_busy_loop()
and sk_busy_loop_timeout(). The default budget of 0 leaves
sk_can_busy_loop() false, so this is a no-op unless the application
(or net.core.busy_read) opted in.

Unlike sk_busy_loop() / napi_busy_loop(), splice_busy_loop() spins on
the in-kernel ring directly rather than polling a NAPI instance, so it
is effective on loopback - which delivers via the per-CPU backlog and
exposes no pollable napi_id. Keeping the receiver hot lets a
synchronous sender's small writes accumulate in the ring without a
wakeup per message; this is what turns the latency-bound TCP_RR case
into a large win once enabled.

A BPF program enables the budget by setting SO_BUSY_POLL via
bpf_setsockopt() (see the following patch). netperf, pinned CPUs,
3x10s, 50 us budget, baseline TCP vs splice + busy-poll:

  TCP_RR (loopback)    1 B    111.9k -> 1113.8k tps  (9.96x)
                       64 B   111.7k -> 1073.3k tps  (9.61x)
                       1 KB   106.1k ->  713.0k tps  (6.72x)
                       16 KB   40.3k ->  123.7k tps  (3.07x)
                       64 KB   17.8k ->   40.5k tps  (2.28x)

  TCP_RR (container)   1 B    105.6k -> 1103.7k tps  (10.45x)
                       64 B   105.5k -> 1103.9k tps  (10.46x)
                       1 KB   100.4k ->  704.9k tps  (7.02x)
                       16 KB   45.1k ->  114.8k tps  (2.54x)
                       64 KB   18.2k ->   38.8k tps  (2.13x)

Busy polling contributes ~4.2x of the 1 B loopback win (splice without
it is 267.0k tps; see the splice patch). Baseline TCP is unchanged by
busy_read on both loopback and default (non-XDP) veth: both deliver via
the per-CPU backlog, which has no pollable napi_id, so SO_BUSY_POLL is a
no-op for them (the container baseline TCP_RR measures the same at
busy_read 0 and 50). The gain therefore comes from the splice ring spin,
not from busy_read itself.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 net/ipv4/tcp_bpf.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 549f37077244..9c4421a74225 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -13,6 +13,7 @@
 #include <linux/util_macros.h>
 #include <linux/percpu-refcount.h>
 
+#include <net/busy_poll.h>
 #include <net/inet_common.h>
 #include <net/inet_sock.h>
 #include <net/tls.h>
@@ -1255,6 +1256,33 @@ static long splice_recv_wait(struct sock *sk, struct sk_psock_splice *s,
 					splice_recv_ready(sk, s), timeo);
 }
 
+/* Bounded busy-poll on the ring before parking the receiver. Reuses the
+ * socket's SO_BUSY_POLL budget (sk_ll_usec) via sk_can_busy_loop() and
+ * sk_busy_loop_timeout(); the default budget of 0 makes sk_can_busy_loop()
+ * false so this is a no-op unless the application (or net.core.busy_read)
+ * opted in.
+ *
+ * Unlike sk_busy_loop() / napi_busy_loop(), this spins on the in-kernel
+ * ring directly rather than polling a NAPI instance, so it is effective on
+ * loopback - which delivers via the per-CPU backlog and exposes no
+ * pollable napi_id. Keeping the receiver hot lets a synchronous sender's
+ * small writes accumulate in the ring without a wakeup per message.
+ */
+static void splice_busy_loop(struct sock *sk, struct sk_psock_splice *s)
+{
+	unsigned long start;
+
+	if (!sk_can_busy_loop(sk))
+		return;
+
+	start = busy_loop_current_time();
+	do {
+		cpu_relax();
+		if (splice_recv_ready(sk, s) || signal_pending(current))
+			return;
+	} while (!sk_busy_loop_timeout(sk, start));
+}
+
 /* prot->sock_is_readable for paired-splice sockets. tcp_stream_is_readable()
  * (via tcp_poll() / select() / epoll) consults this to mark POLLIN when
  * sk_receive_queue is empty - we must also report data sitting in the
@@ -1349,6 +1377,16 @@ static int tcp_bpf_splice_recvmsg(struct sock *sk,
 			return 0;
 		}
 
+		/* Spin on the ring for the SO_BUSY_POLL budget before
+		 * sleeping. If the spin observes data, re-read from the
+		 * loop head; otherwise (budget expired or a terminal
+		 * condition) proceed to park - splice_recv_wait() returns
+		 * immediately for terminal conditions.
+		 */
+		splice_busy_loop(sk, s);
+		if (splice_ring_has_data(s))
+			continue;
+
 		timeo = splice_recv_wait(sk, s, timeo);
 	}
 }
-- 
2.43.0


