Return-Path: <netdev+bounces-300062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TM8YLgtUMmqiygUAu9opvQ
	(envelope-from <netdev+bounces-300062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:00:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34247697541
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:00:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=Z7cfZc0p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300062-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300062-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F6630182BC
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12513C4546;
	Wed, 17 Jun 2026 07:58:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD33C9EE4
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 07:58:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683106; cv=none; b=IyU9TEP8YGNu4bFfUpTRf++T2VNF3VkTMJcJnul7GiVLNfwcqT32TTh/U8Lj968MU7tximBx4/rypnkPvBGHP5Ga3YeO6Jn6gfTdrTHnoiqkVbxkYSlp8bCDa56e4WhLtJffKd2lJCrQM9+nvyRgm3oSlzK+sWrbM2aMs5LuQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683106; c=relaxed/simple;
	bh=MTSLF1i0SVm8X/ceHYU7vQaIB21106ApW03KPotEA3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbJtqiYiIzxG0k1/BugvjYDfJhaPjgU3SgQTVYtF1hZqIatUbZx/eaOmV6atOqNs5Xyq4hMLJR8YIfHuUNl1KAmAIZOz1YQwtG84gQaaMiw1DMsE4Wy82adebNyz8YJ92foeVLWIpFRMwe86zzQ+W+JnluI8tpb+IEEZ0K14tUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Z7cfZc0p; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so5211545e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781683101; x=1782287901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hFkTCzH0bW/6eaucGKv1hofGcpDdZG/dUw+kXhlNjkA=;
        b=Z7cfZc0p7HcuUKcqjg38xCst1q2S2KB4isXkNp9AsFDhtkc38gCp6q62Obq3M+NKFj
         54lH1rgdR1SlrfYMqXFcuJuBoLRKPnRjFmX+gxp9LvlqaNR2BC5RisA0T1wdNaUTHOM2
         tAXSJKR4QFxehLJjtDYnSz1x3TxvsOPDH7Y9Pf68SK5fTa+cbqTI5TxVhzFeCrZOp07U
         owHp5HOEFnVVy/8gI0+iX2PzJzk3vvn/dkH5x7H75S22bQPLsiyPrSOVpodT1azc/3VL
         5u1jOciqut5CVzo13hrGUql2ypf/ImbjoEjm3yMAUxi3rFvXncmtjwCn35cYTuT+52hi
         rdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683101; x=1782287901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFkTCzH0bW/6eaucGKv1hofGcpDdZG/dUw+kXhlNjkA=;
        b=YVNxw9EgvpU4m0iQkqndcyfjw9RXRNWRERwdllB2WhoPEHuEgJ1Z/I+syCAmsFIyMt
         1EOmfeFBpiVyhcfh7dmX1GdkwkVjNODNAWqVS6ZrcGMDQmXxEsZEwCKVG1yfy4UtVoft
         JsCN8S4N2RgPnbzZBagfCYt3j6nwFPuua5Ajpt9whljbepD4BO6e+BeS2TLieL6ckw4g
         y8rQeocmFxwDLcJkBSdvknKWZEYYJfrzSBSza/PXjUHca42/NtIGDrjOCzbDwT0j5TtF
         6PqdWAi9T9NV+nYlpvOFHaQT4MZ5aor/V93YAV323hOk3o7HiCG4JXjOpDoTf4HOPfwy
         fRlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OHqUJ9hju8kCkh2rxTzlvnNF1bj+TLsAaPU34QVWDYdF2C/l+IsMLaQqiRfwaDZxP09EoY98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLCnMy/r73ke/Ndr0ZqrmNw/qLYmn9SZmnRyACz1FUF6/w3a/
	nk+uIeVP92JLVESVYCibwxu7j+UGSSlTCAgMT/7Ab4ih2F3TIL/pjgvwHCF5TiW2Jyqi
X-Gm-Gg: Acq92OEwQzJcF8EzWm9ru1Lha0MwP27ngVVrtoVxasGc5gTKJy+6Tckj1zD0xj1j4o1
	Smno9ILFWfLaFg3xnm6dscQIkYIb0lFE9A9SqklSgoQn3GOVM0f545MNUVxhV5gFsu09o15hyoh
	vEqC/CUSOHAZRmu9EyTb6imU2gpV9QZUYwHPXCozGBKTjHgQx0WrVJL+2SxcTa8RWbtAS+1hySZ
	Lz/h86uzu0Gt2haR212cImCTxaEezxFY5VolELuYZsLJH65AxNrEv/erPEHG5uNLT9lw5BHyAIM
	ClwweyjSV4g/b3AqD7orrm6aA7/Eojo6z29s2GMl96IJau17orSDPC8dfpTK4f1EB6nvd79P7Ag
	g2sWRuB7kLiJGN3e1UKcJlNG/wgvOHH5AB6hrb9NC3/+MzVrgfrvsjNE005wZGERD6qxozDJvH8
	/HOV2/BBNzoMznyIeXshnnZATiisWZJMGcCfJXbmoLuSKxXclFoi5kbstxVq+CXPLzsSzcbgBDA
	HQWvWu0bCFR+txBBRVlpMAvYZpencVbjq4=
X-Received: by 2002:a05:600c:4f83:b0:490:ad1e:1846 with SMTP id 5b1f17b1804b1-492340e763emr23901315e9.9.1781683100362;
        Wed, 17 Jun 2026 00:58:20 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa5120esm150707715e9.8.2026.06.17.00.58.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jun 2026 00:58:19 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: jmaloy@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aleksander.lobakin@intel.com,
	tung.quang.nguyen@est.tech,
	tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net v4] tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done
Date: Wed, 17 Jun 2026 09:58:18 +0200
Message-ID: <20260617075818.37431-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300062-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:aleksander.lobakin@intel.com,m:tung.quang.nguyen@est.tech,m:tipc-discussion@lists.sourceforge.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:doruk@0sec.ai,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,0sec.ai:url,0sec.ai:from_mime,0sec.ai:dkim,0sec.ai:email,0sec.ai:mid,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34247697541

tipc_aead_decrypt() goes straight from tipc_bearer_hold(b) to
crypto_aead_decrypt(req) without taking a reference on the netns, unlike
the encrypt path. When crypto_aead_decrypt() is offloaded asynchronously
(e.g. the SIMD aead wrapper queuing to cryptd), the cryptd worker runs
tipc_aead_decrypt_done() later. If the bearer's netns is torn down in the
meantime, cleanup_net() -> tipc_exit_net() -> tipc_crypto_stop() frees the
per-netns tipc_crypto, and the completion then reads it:
tipc_aead_decrypt_done() dereferences aead->crypto->stats and
aead->crypto->net, and tipc_crypto_rcv_complete() dereferences
aead->crypto->aead[] and the node table -- reading freed memory.

Decoded KASAN splat (v7.1-rc7, CONFIG_KASAN_INLINE + TIPC + TIPC_CRYPTO):

  BUG: KASAN: slab-use-after-free in tipc_aead_decrypt_done (net/tipc/crypto.c:999)
  Read of size 8 at addr ffff8881056258a8 by task kworker/u16:2/51
  Workqueue: events_unbound
  Call Trace:
   tipc_aead_decrypt_done (net/tipc/crypto.c:999)
   process_one_work (kernel/workqueue.c:3314)
   worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

  Allocated by task 169:
   __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
   tipc_crypto_start (net/tipc/crypto.c:1502)
   tipc_init_net (net/tipc/core.c:72)
   ops_init (net/core/net_namespace.c:137)
   setup_net (net/core/net_namespace.c:446)
   copy_net_ns (net/core/net_namespace.c:579)
   create_new_namespaces (kernel/nsproxy.c:132)
   __x64_sys_unshare (kernel/fork.c:3316)
   do_syscall_64 (arch/x86/entry/syscall_64.c:63)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

  Freed by task 8:
   kfree (mm/slub.c:6566)
   tipc_exit_net (net/tipc/core.c:119)
   cleanup_net (net/core/net_namespace.c:704)
   process_one_work (kernel/workqueue.c:3314)
   kthread (kernel/kthread.c:436)

This is the same class of bug that commit e279024617134 ("net/tipc: fix
slab-use-after-free Read in tipc_aead_encrypt_done") fixed for the encrypt
side. The encrypt path takes maybe_get_net(aead->crypto->net) before
crypto_aead_encrypt() and drops it with put_net() on the synchronous
return paths and in tipc_aead_encrypt_done(); the -EINPROGRESS/-EBUSY
return keeps the reference for the async callback to release. The decrypt
path was left without the equivalent guard.

Mirror the encrypt-side fix on the decrypt path: take a net reference
before crypto_aead_decrypt() (failing with -ENODEV and the matching
bearer put if it cannot be acquired), keep it across the
-EINPROGRESS/-EBUSY async return, and drop it with put_net() on the
synchronous success/error return and at the end of
tipc_aead_decrypt_done().

Reproduced under KASAN on v7.1-rc7: a UDP bearer with a cluster key is
flooded with crafted encrypted frames from an unknown peer (driving the
cluster-key decrypt path) while the bearer's netns is repeatedly torn
down. The completion must run asynchronously to outlive
tipc_crypto_stop(); on x86 the stock aesni gcm(aes) now decrypts
synchronously, so the async path was exercised via cryptd offload. The
unguarded aead->crypto dereference in tipc_aead_decrypt_done() is the
unpatched upstream path; tipc_aead_decrypt() still lacks
maybe_get_net(aead->crypto->net), so the completion can outlive the free
on any config where crypto_aead_decrypt() goes async.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v4:
 - Use the net parameter for maybe_get_net()/put_net() instead of
   dereferencing aead->crypto->net, which is the per-netns structure at
   risk during teardown (per the automated review forwarded by Simon
   Horman). net == aead->crypto->net here; no functional change.
v3:
 - Rewrite the changelog with the decoded stack trace and frame the
   reproduction on the current tree (v7.1-rc7); drop the v6.12.92
   references (Tung Quang Nguyen).
v2:
 - Add Cc: stable@vger.kernel.org and Alexander Lobakin's Reviewed-by.
   No functional change.
 net/tipc/crypto.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 6d3b6b89b1d1..16f1ed1f6b1b 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -941,12 +941,20 @@ static int tipc_aead_decrypt(struct net *net, struct tipc_aead *aead,
 		goto exit;
 	}
 
+	/* Get net to avoid freed tipc_crypto when delete namespace */
+	if (!maybe_get_net(net)) {
+		tipc_bearer_put(b);
+		rc = -ENODEV;
+		goto exit;
+	}
+
 	/* Now, do decrypt */
 	rc = crypto_aead_decrypt(req);
 	if (rc == -EINPROGRESS || rc == -EBUSY)
 		return rc;
 
 	tipc_bearer_put(b);
+	put_net(net);
 
 exit:
 	kfree(ctx);
@@ -984,6 +992,7 @@ static void tipc_aead_decrypt_done(void *data, int err)
 	}
 
 	tipc_bearer_put(b);
+	put_net(net);
 }
 
 static inline int tipc_ehdr_size(struct tipc_ehdr *ehdr)
-- 
2.43.0


