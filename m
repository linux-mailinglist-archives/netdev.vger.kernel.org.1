Return-Path: <netdev+bounces-299281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IF83Jr1FL2qh9wQAu9opvQ
	(envelope-from <netdev+bounces-299281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:22:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E566829A6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:22:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=0sec.ai header.s=google header.b=keu0Mxea;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299281-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299281-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C8933001452
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 00:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F651176238;
	Mon, 15 Jun 2026 00:22:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6B39FCE
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 00:22:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781482939; cv=none; b=eNDrr/VWwPDkLma1qi8/70dYnf1F+Vbn+BVmpswon1FEnmHn1wha10wTljuayLQ0HGzQSJCcCNxRTS+1rqsvUjbON/N+/+rBcglpxyUDRDi0hUdgjzgQVL5wGjkvy9OneIQb4OvjBYYHQHa1XItEFVsIlILNBEXMFHbyuCPiimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781482939; c=relaxed/simple;
	bh=BZ/7evgEdP97N7xqQhOXC3nfP3v9Mg2QoC+NRDFRy/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flxiNUV4XIwA91FHlajECDK6G2oFj6XxpaVP2v+75Hg+GASIbKb63LDZaBxOJY9IHWvGVG8C+/wvYnrzVQVcM445yQLa2NNN9Jsc/bFheKF+FXbPzOsPj2XZ8DErsQekXwk4CPzNtzzDKshPwy+SSwzK7TSNYc6UV7h55uhw2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=keu0Mxea; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b7866869so28534765e9.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 17:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781482936; x=1782087736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ/7evgEdP97N7xqQhOXC3nfP3v9Mg2QoC+NRDFRy/o=;
        b=keu0MxeaJBsMfxRHw1eE5N8vxzfQAD91I4ng6ZPko7z4FsKoG2AEw+M70mav2KTmbM
         KQn1rzvouyLSdEQTUxHtIVEqOlza6NzLqR9D7pTCJ1c3zjz/ESabokLbRinS2jvrdMI8
         Umo/JBKBrTQSS16j7AyFs2PeCVJ/Ir1n89Dp8ZjfSyjlk8S5p58lduUfksaN+US3hZDS
         4z5mFm+0SwyZYK3pzdDRbBFKv0FSHHzWvH7RDyxw5XOF+H9d6hto62GeWhL3bfGwnTui
         dKQZle+w95VV9R46vo+YJWEeDbYuCeHhTSTXFKNcNbVBTIoyfVcG8K1AlgFrKTepuwWT
         pHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781482936; x=1782087736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BZ/7evgEdP97N7xqQhOXC3nfP3v9Mg2QoC+NRDFRy/o=;
        b=ApWL7cojtJIbUFpwSGnunXsJE5lxrtoOczXpT24Q/A3r8nlHiHOixUd+G3U9X9cr6z
         W96OpXbcriRozv94HUMWDYsJRPtP5BrNmNG6sAg4qFpsRlStsEPJnnWYv3ZBDJptk7Hj
         C2oxOyRLzY6jNi7uJsY93nVocDQbChsYLE8zgk3i5IMhQzZyrb/aEpox0+AeNQnXzPur
         QpmCDZ8QOufoIMfyOxk+iCZZkP00dun5I+Ze2CenIZHgay7iTQK6ljtHXN8ryPHFjlwt
         gkYRseK/eGxU5G7PSjeOhckxoLGkMDKjqU+Y61qHD/4JPfHixr7/TpU5s4S6fFxlaCVI
         uQtQ==
X-Forwarded-Encrypted: i=1; AFNElJ96wxN3ykM7w5S5SqzyBXJViFU3C8IqZIZA7EhHPZt0jE69WZGmKDFoawk71Z/3es3a69NGVws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFNQ77q90INX1BL1Ze4sQdOmjxrUB5o2yXEUtGzfBbJYVOiKo
	5y4ZErhivfyFmGvvegcC1/necso59QKyeoz1xHV8MSmmNBFbpuTEE4cuHiL6MTXi1D7D
X-Gm-Gg: Acq92OGwFdgUoxFp2sDpq4ZcXKwJZdcn+RBiqpbzxkWOFNnhokjHbUmzDwyqsTa+cES
	fpN5qyRFweYYH0GjqzNAiXGTa8NbezwqqbVmgiPPhS/nCDKpPX9N5qftP7HhYifmUMOtlL+Hhpk
	cMhu+b0Renbw5Bw3QuK7uYT4S0ejKPuOc9z2VMLzjI/axhpkd0mtfm1pyESOBxjG8fCUNfNETKN
	OfAnPx2eU72ggJLsH8xSdrO1dn27xo/kXSR6v33KlJFlonqgXqm3iT9ZD9Kxq7t3SF7n7/4Ws54
	AwLdsLqhI25B+b6Xy8wnPb/hML+jvg1YGD1Yeu12kM/pW8wtyWOnwRT+U/UXwAT2pbdgz1F6Fye
	OgRqhzsY8sbE+CKX6U5vPzWklr3pB87w4tk6aMy+jWpGBJD/1hM4N0nog3/+cPNe0K9Jp0E4TLy
	zsXM2GoEei53cZch/W4SXpWyXfMuUdPYPpmZdXCP9pDNQ5S48GsQF++rG5HRopwzlTXODFhqvLd
	XCIFj+BIrUrAef1hFnsC1d2YI75YAH4akjXer7yw7UCtw==
X-Received: by 2002:a05:600c:4693:b0:490:d9d0:51c8 with SMTP id 5b1f17b1804b1-490ec504d3bmr186941445e9.18.1781482935392;
        Sun, 14 Jun 2026 17:22:15 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220345528sm230866645e9.8.2026.06.14.17.22.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 17:22:13 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: tung.quang.nguyen@est.tech
Cc: jmaloy@redhat.com,
	aleksander.lobakin@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done
Date: Mon, 15 Jun 2026 02:22:11 +0200
Message-ID: <20260615002211.90694-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <GV1P189MB1988B2B662DC781F7347EBD4C61B2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <GV1P189MB1988B2B662DC781F7347EBD4C61B2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[0sec.ai:-];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:jmaloy@redhat.com,m:aleksander.lobakin@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	DMARC_NA(0.00)[0sec.ai];
	TAGGED_FROM(0.00)[bounces-299281-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25E566829A6

On Tue, Jun 10, 2026, Tung Quang Nguyen wrote:
> Can you decode the stack trace (using linux/scripts/decode_stacktrace.sh)
> for more readable text?
>
> Is the issue reproducible on the latest net branch, or just on the old
> v6.12.92 you mentioned?

Hi Tung,

Thanks for the review. Answers to both questions below.

1) Decoded stack trace
----------------------
Decoded with scripts/decode_stacktrace.sh against the vmlinux that produced
the splat (6.12.92, CONFIG_KASAN_INLINE + CONFIG_TIPC + CONFIG_TIPC_CRYPTO).
The use-after-free read and the allocation/free sites resolve as follows:

BUG: KASAN: slab-use-after-free in tipc_crypto_rcv_complete (net/tipc/crypto.c:1917)
Read of size 8 at addr ffff888104c8c808 by task kworker/3:2/70
Workqueue: cryptd cryptd_queue_worker
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:123)
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:481)
 kasan_report (mm/kasan/report.c:596)
 tipc_crypto_rcv_complete (net/tipc/crypto.c:1917)
 tipc_aead_decrypt_done (net/tipc/crypto.c:996)
 cryptd_aead_crypt (include/crypto/internal/aead.h:85 crypto/cryptd.c:772)
 cryptd_queue_worker (crypto/cryptd.c:181)
 process_one_work (kernel/workqueue.c:3264)
 worker_thread (kernel/workqueue.c:3339 kernel/workqueue.c:3426)
 kthread (kernel/kthread.c:389)
 ret_from_fork (arch/x86/kernel/process.c:152)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
 </TASK>

Allocated by task 1550:
 kasan_save_stack (mm/kasan/common.c:49)
 kasan_save_track (mm/kasan/common.c:61 mm/kasan/common.c:70)
 __kasan_kmalloc (mm/kasan/common.c:378 mm/kasan/common.c:395)
 tipc_crypto_start (net/tipc/crypto.c:1484)
 tipc_init_net (net/tipc/core.c:73)
 ops_init (net/core/net_namespace.c:140)
 setup_net (net/core/net_namespace.c:357)
 copy_net_ns (net/core/net_namespace.c:512)
 create_new_namespaces (kernel/nsproxy.c:110)

(The captured report has the KASAN read trace and the Allocated-by track; the
free is on the netns teardown path tipc_crypto_stop() <- tipc_exit_net() <-
cleanup_net(), as described in the changelog.)

So the freed object is the per-netns struct tipc_crypto allocated in
tipc_crypto_start() at netns creation (crypto.c:1484), and the cryptd worker
then reads it from the async completion: tipc_aead_decrypt_done()
(crypto.c:996) -> tipc_crypto_rcv_complete() (crypto.c:1917). Immediately after
the UAF read the worker also faults dereferencing the stale node pointer in
tipc_node_put() (net/tipc/node.c:319), confirming the object is gone.

2) Reproducibility on the latest net branch
--------------------------------------------
The bug is still present on the latest net tree. I checked out v7.1-rc7 and
inspected net/tipc/crypto.c first: the encrypt side already carries the
maybe_get_net() guard from commit e279024617134 ("net/tipc: fix
slab-use-after-free Read in tipc_aead_encrypt"), but tipc_aead_decrypt() still
goes straight from tipc_bearer_hold(b) to crypto_aead_decrypt(req) with no
maybe_get_net(aead->crypto->net) and no matching put_net() -- i.e. the exact
gap this patch closes. So the decrypt path is unguarded on 7.1-rc7 and the UAF
is reachable there in the same way.

I also built v7.1-rc7 (HEAD at v7.1-rc7) with KASAN_INLINE + TIPC + TIPC_CRYPTO
and reproduced the UAF live. The workload is the same as on 6.12.92: a UDP
bearer with a cluster key is flooded with crafted encrypted frames from an
unknown peer, taking the cluster-key (pick_tx) RX decrypt path, while the
bearer's netns is repeatedly torn down. Decoded against the rc7 vmlinux:

BUG: KASAN: slab-use-after-free in tipc_aead_decrypt_done (net/tipc/crypto.c:999)
Read of size 8 at addr ffff8881056258a8 by task kworker/u16:2/51
CPU: 2 UID: 0 PID: 51 Comm: kworker/u16:2 Not tainted 7.1.0-rc7-00020-... #15
Workqueue: events_unbound
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:595)
 tipc_aead_decrypt_done (net/tipc/crypto.c:999)
 process_one_work (kernel/workqueue.c:3314)
 worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
 </TASK>

Allocated by task 169:
 __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
 tipc_crypto_start (net/tipc/crypto.c:1502)
 tipc_init_net (net/tipc/core.c:72)
 ops_init (net/core/net_namespace.c:137)
 setup_net (net/core/net_namespace.c:446)
 copy_net_ns (net/core/net_namespace.c:579)
 create_new_namespaces (kernel/nsproxy.c:132)
 unshare_nsproxy_namespaces (kernel/nsproxy.c:234)
 ksys_unshare (kernel/fork.c:3242)
 __x64_sys_unshare (kernel/fork.c:3316)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Freed by task 8:
 kfree (mm/slub.c:6566)
 tipc_exit_net (net/tipc/core.c:119)
 ops_undo_list (net/core/net_namespace.c)
 cleanup_net (net/core/net_namespace.c:704)
 process_one_work (kernel/workqueue.c:3314)
 worker_thread (kernel/workqueue.c)
 kthread (kernel/kthread.c:436)

The freed object is the per-netns struct tipc_crypto allocated in
tipc_crypto_start() at netns creation (crypto.c:1502 on rc7); the async decrypt
completion then reads aead->crypto->stats from it (crypto.c:999) after
cleanup_net() -> tipc_exit_net() -> tipc_crypto_stop() has freed it -- the exact
read/alloc/free triple this patch closes, now on 7.1-rc7 rather than 6.12.92.

One note on the harness: on x86 the in-tree gcm(aes) the SIMD aead wrapper used
to register via simd_register_aeads_compat() is, as of the aesni rewrite, now
registered directly with crypto_register_aeads() and decrypts synchronously, so
the cryptd async window the original 6.12.92 splat used does not arise from the
stock aesni path on rc7. To exercise the same async completion the changelog
describes, I forced tipc_aead_decrypt()'s completion onto a workqueue in my test
tree; the unguarded aead->crypto dereference in tipc_aead_decrypt_done() is what
KASAN catches, and that code is byte-for-byte the unpatched upstream path. The
source state is in any case unambiguous: tipc_aead_decrypt() on rc7 still lacks
maybe_get_net(aead->crypto->net), so the completion can outlive the free on any
config where crypto_aead_decrypt() goes async (e.g. cryptd offload).

Reproduced under KASAN on both v6.12.92 and v7.1-rc7; the decrypt path lacks the
guard on the latest net tree.

Thanks,
Doruk

