Return-Path: <netdev+bounces-297674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /0i6M8lhKWomWAMAu9opvQ
	(envelope-from <netdev+bounces-297674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:08:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6463E669977
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:08:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=XaV52jL3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297674-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297674-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6563730799D7
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A32922259F;
	Wed, 10 Jun 2026 13:00:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19024176FB1
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:00:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096452; cv=none; b=BNrg9gpmc+EouX4etGKkssWHcc8ppBPg8hBFq2Tlpdv/P2Bs0nSWIVkvGQpRXZrBs3S8+yF66bZoOqC3cH45qDW6ZCzgT1BT8jD1G6u2SqtuUDNW5B2D6HMbEPzsmXeJWQpSTZqMJQF70wsd0amVd85anc9j7eCen6GRL+JsLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096452; c=relaxed/simple;
	bh=epcyt5Wh1odVH3k/9F+LSiRC9CHJsqkFCDU6Pk58NqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4vISDsCWzN5fTxmhvi4i1AINqMT1U974IZykoeW4hejiqUMKpniM1ttLLAVPa96WYR5FS/WKRkzvBT0FxKz2WHm0Ak2zfXFBUMz2TYpLLZaEUYhMX0n/tucxOtszuMqTRLLr3DcfEcyKG52aNiI42FE2pQqRczDSzVByy5CK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=XaV52jL3; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45eeea039ebso3603930f8f.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781096449; x=1781701249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+G46dKJififF+uN+6x6XZ6FUhL5eRIvRdEqEqHKs0cw=;
        b=XaV52jL3lCR5jNZfr2GbWCU0+KHc5anVVNWVt/koB/t6BFObU4PAu2YMafDQ9QyvFy
         cZq9x7A8WEhmDwv+fR1MUH6BwYDN1Kn8Jl2VJTk1JLFGuBW37WAjJA13Am1BVPnPoaLy
         iNrEwFg7QUtvhJiEMB9pf7lYo0rtKeOgIci03OouvJHwVrXRV3lIoQNomVS/yzPhTlb6
         dkSXBQxB4daki2TwwjiePTMp2ETfR6vvIeMu8pje2d1+BDYV/skj5I7cVfSgmFMcjt7n
         D36EoWc1Yg0q+RCSmEQWmLF8d3ilOSnJ6zojwPV6vt7efl/bzgKf9hRycPmVdRvmv0fA
         S4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096449; x=1781701249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G46dKJififF+uN+6x6XZ6FUhL5eRIvRdEqEqHKs0cw=;
        b=rK3Y+gZnCx3zzoo33n0kgjqMUcKgtLk2hEFkkGm5txf0CMbYKubwC9wOuiSee9su9B
         kZ+Y1MMDdsFQklQ6tpKzI0gWZD1TFs6CxL0I+xqrluGm43Z28ZNzWoXJVaLZ+e0ZQIx4
         d5zeo0+TmIM7iH6D+6l7w7lJCDqwOnsl7zOvzbUQ/N1n+yYI6nn08SQTuvftUaiCnKSO
         K0ntGhSoKNZUBcXm7+hRHEaYBg16BL0M/yFyZJsHsUrAA/uCzkhBCF5E/dYAtSyEH8P2
         1R3Qmbn8+XOPzFn275dEiGvAAkW3NqTrngfBP8slaGAXrudGv5aXaPCrIMeD6BbM8MQu
         l5kw==
X-Forwarded-Encrypted: i=1; AFNElJ9lOxOKE2fXk1EnWsQyBOrRbYo28ZFSX9gXEklrYR4BQgiRJ6A3VrGx7/F7vz9j0GW+ea+Wcqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrIfRgU3V+QM6hWTssS6v386U74rg8uXWpCGYs2NuT/hi18KJ
	zREeMNySux46EJkO1UoBU1oIBMnPo/1ZdTdVj8SEjC3wsAoqIBdALhON/y2OCSm62ibH
X-Gm-Gg: Acq92OHnZYH4LhLGgYUZuRHjTTBKy/Er24C+QjRLCm0v1C15TfD0SGCl9bcOHIXZd0R
	/auVs26CATZQQjn++XH9zlmg9TVBCgUfbU1gCvxBB0dGZPqshJtMz40OTrHgoPUILlXBNVb8Wme
	qOrX9HK4SjghZj7ePO7MUoBGaQ8WpdzoyapbgMVCUIHv8F6DL9hyod4W2NpeLcwaI1LR4FK6LKK
	cUzcDlYRsr7aywte80NiHimBabPfdED3fIWgWAZGyxoLRD8Pwz8Det4r+QhlrqpAbYSMQgBUlw0
	dx2QRo4HY05uJ9iq5e9DtsMcECSEMGe1S3Cs4GyYqUXUlssNBC2wS2xvGzsurlVkVg0bsppmBNu
	rkmY9B3AeZ7irXvlgpSVhLfB6pncN3jYt54dcCJZJ1zx8CB1j6WaSufrMYGoS/Bf7jVbKWMiIg0
	5FGE5Ue8O8VOt5tVe6EJuUhW+JjYcQb/6PMdrRhtFjtoJ3IxdFKmS42k/pbjgfZUc3zf2T/4L5d
	JIl4vehY87Hs1sraDm0PL0lH3jkC8y63n+qvlv9m3Mem8bnTYue1Z/6ijhAv255iPQ=
X-Received: by 2002:adf:e011:0:10b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-4603063a15cmr27177266f8f.37.1781096448976;
        Wed, 10 Jun 2026 06:00:48 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.222.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2eadefsm74123638f8f.11.2026.06.10.06.00.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 06:00:48 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jon Maloy <jmaloy@redhat.com>
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done
Date: Wed, 10 Jun 2026 15:00:46 +0200
Message-ID: <20260610130046.59867-1-doruk@0sec.ai>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-297674-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[0sec.ai];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:url,0sec.ai:from_mime,0sec.ai:dkim,0sec.ai:email,0sec.ai:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6463E669977

The async decrypt completion path mirrors the encrypt one but is missing
the net reference that guards against the tipc_crypto being freed during
netns teardown.

When crypto_aead_decrypt() is offloaded to cryptd (the SIMD aead wrapper
queues the request when crypto_simd_usable() is false), the cryptd worker
runs tipc_aead_decrypt_done() asynchronously. If the bearer's netns is
torn down in the meantime, tipc_exit_net() -> tipc_crypto_stop() frees the
tipc_crypto, and the completion then reads it: tipc_aead_decrypt_done()
dereferences aead->crypto->stats and aead->crypto->net, and
tipc_crypto_rcv_complete() dereferences aead->crypto->aead[] and the node
table, reading freed memory:

  BUG: KASAN: slab-use-after-free in tipc_crypto_rcv_complete
  Read of size 8 at addr ffff888104c8c808 by task kworker/3:2/70
  Workqueue: cryptd cryptd_queue_worker
  Call Trace:
   tipc_crypto_rcv_complete+0x1dd6/0x2240
   tipc_aead_decrypt_done+0x1c3/0x300
   cryptd_aead_crypt+0x3ae/0x660
   cryptd_queue_worker+0x12b/0x200
   process_one_work+0x66c/0x10c0
   worker_thread+0x55d/0xc80
   kthread+0x269/0x340
  Allocated by task 1550:
   tipc_crypto_start+0x7e/0x890
   tipc_init_net+0x30d/0x480
   ...
  Freed by task 116:
   tipc_crypto_stop+0x1a4/0x2a0
   tipc_exit_net+0x11c/0x1c0
   cleanup_net+0x510/0xaf0

This is the same class of bug that commit e279024617134 ("net/tipc: fix
slab-use-after-free Read in tipc_aead_encrypt_done") fixed for the
encrypt side. The encrypt path takes maybe_get_net(aead->crypto->net)
before crypto_aead_encrypt() and drops it with put_net() on the
synchronous return paths and in tipc_aead_encrypt_done(); the -EINPROGRESS
/-EBUSY return keeps the reference for the async callback to release. The
decrypt path was left without the equivalent guard.

Mirror the encrypt-side fix on the decrypt path: take a net reference
before crypto_aead_decrypt() (failing with -ENODEV and the matching
bearer put if it cannot be acquired), keep it across the -EINPROGRESS/
-EBUSY async return, and drop it with put_net() on the synchronous
success/error return and at the end of tipc_aead_decrypt_done().

Reproduced under KASAN on v6.12.92: a UDP bearer with a cluster key is
flooded with encrypted frames from an unknown peer (driving the cluster-
key decrypt path) while the bearer's netns is repeatedly torn down. The
SIMD aead must be forced onto its cryptd async child for the completion
to outlive tipc_crypto_stop(), and the cryptd worker was delayed to land
the narrow race deterministically; with the patch applied the same
workload runs cleanly. Found by 0sec automated security-research tooling
while auditing the siblings of commit e279024617134.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/tipc/crypto.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 6d3b6b89b1d1..84a6489da036 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -941,12 +941,20 @@ static int tipc_aead_decrypt(struct net *net, struct tipc_aead *aead,
 		goto exit;
 	}
 
+	/* Get net to avoid freed tipc_crypto when delete namespace */
+	if (!maybe_get_net(aead->crypto->net)) {
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
+	put_net(aead->crypto->net);
 
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


