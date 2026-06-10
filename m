Return-Path: <netdev+bounces-297830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2nFHIivDKWq2cwMAu9opvQ
	(envelope-from <netdev+bounces-297830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:03:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B3366CAE2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:03:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=0sec.ai header.s=google header.b=xVO+XLQa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297830-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297830-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FAF03043EE3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C59738E5E9;
	Wed, 10 Jun 2026 20:03:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37238BF9A
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 20:03:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121830; cv=none; b=FYMXwSzowlwQkLmvtJ/Hl3lIDE5kz7yogTATlAvJJUPw5Oy6Pat1FWTwd4N/39i5UWJinLsqQ0/nunpRKKMvTU9zzv+CCI/C6wFB9y8aa8uHp4jWVJPZlEU2xoecbcmwxq0409gedCOqVmp4oOn3yUBcjlb2Bevw1lSJz2yJw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121830; c=relaxed/simple;
	bh=3ZElmahT+PnwQEQ9dTHLRsZo9ZlnYm739b1Vi/iM/UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQoHIpm2UHqdlyhs0e4b7ySLVyHBQ/vxb/+7xOvKt3fCQcV8nxQpYhz4WEhYrCnq30bPC9WWfh06YiAuh531JokcXN58e5M4b15gBGLclVP+r+/2ePSoSbRaIs4WguYSb/DJfjyJ2fMrTxMTlzbu2bnivGk1aZwRmzSZomVARQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=xVO+XLQa; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so49465275e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781121816; x=1781726616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgzi4vGlaNMbhkiNlf7vOeCQMYkJ2z31XuHhYzUTkxY=;
        b=xVO+XLQaQmpBH7m8PLKN4b5MZyIUQ31Hxn7pT0yw0iUwyIZUUAzqfIFGXTUmM0tYZU
         0fWrwJszh4TG6WSvHDadbC5fIio+7AxNIWJebKSTyIfL/f3BkQm5ifnmA3PFTmEV+4U9
         quH9h2K1zm8XkzaorxketYnwZurxy4X9yF7u18dSC8WU0o4Fa2mup9A6gSpDmW/uV6mR
         cYrkAN1uLB0E254PIM1hNnCow8oxY8DFvivV4JX+3oj6XnWmcvwXN1g1HbEfHc9HRI1A
         VqIAOmQfiC/kL+Ac6p7Ou+nAQFtWp/+hluIAruEondvv43fafFlcVgJdAHhMG2kvRqub
         pJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781121816; x=1781726616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgzi4vGlaNMbhkiNlf7vOeCQMYkJ2z31XuHhYzUTkxY=;
        b=Afg8lmCz0kzCrOgxqDIiDVfYJqLWn/2TtnbJMn7fxFo3CQ70zbJ9SbC03jnJt8Ew6O
         nShgUQ15VuUubu/Bwqp0DOvvHiiQTPEJ90uDr0dpMTC8Wn6aEvWudKtC7D6XsIWbDq6T
         bZIKiO3IoW5alsKw+HF0BMHvNbGNDzWEBgg94cL71mvAMgjGs0vKo/d4O6G5F4elhxgO
         rbXdjZIPBYiIlRVUCcoYKqTWnZm8KOmtJ4XMmPw8JKuABtM//q4cnZ/i98p1/3+RonZk
         qFqRT//oEThTXf/raiu9rQAALEj+wQaud0l8inw9OyvNtKgq0slAz0PF/wFRJkv14YBn
         kaIA==
X-Forwarded-Encrypted: i=1; AFNElJ+nW2VjGOa50I20WCT90dATIUTp2bzrcaAUWvB5nj03EoV96S0P6+B1ib41/zjBiyX4hbPbGK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoHD03g6TCb+XGI9M3Z1aqqIVPYKxuhybcuRrMqAgT7PHy+Dd
	K+03KTo/ZNJNaPbR12IZSOOLz/AxnZRga/0AzGorNcio7UIZkE1hdGkVHxEVtrJ3YB65UKamYHM
	9HedfvbzWNk4=
X-Gm-Gg: Acq92OFqX774uNKu2xd757mVx13A7uMu+Y/P0Su+eDWhj8dBOpv9mN1Z5ya6pQX1fFP
	C137190uvGYU1mX6xa2wuwIGjXxzt7cgc508lgfqcDPLNgj8Hg6ZiRYNd/6v/NUzAD6tfwB51VY
	Dq9yQ9JLWaotJL5OghyS6LNj+hRKcPX003Cxxk1WLgAe63KRCOXUg4ie6W0PJ3wwQDnMto5gfRH
	FrbRk6wX1mZ0nsWsuK2TraI5ex8pDVsfYAUSRYQRj/qwyigHLMg2vR47rgbMoedQhZZzoGC7Kg0
	pLOmfRe4nRzuoVJc0FjsvGzaPeioknZlMoRbFY8/vkrY23/t7exuTLzmjNihlSt/0DKf3NWro2J
	gZQYAZKaiIm/IbqjyxUFeV1lW7XA3KkB7oARa4XKMqMzrA1Iol85LRSyni8ZvknIAZqBqE97yST
	SPkBA6okpUeeu7KZzmXHnaGEBocU9twTxHJxCGx0XlXMbrvnZaZ5ImgEpz1qraY85OWQzlbmalG
	Hh+IZpPDK05yHrkAeaBuYGO0vwVPp1TPpr176WPzMuB8DtE2CHWw5kR
X-Received: by 2002:a05:600c:4e09:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-490c259a003mr461443265e9.6.1781121816053;
        Wed, 10 Jun 2026 13:03:36 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.222.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e246f28asm10606275e9.0.2026.06.10.13.03.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 13:03:35 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jon Maloy <jmaloy@redhat.com>
Cc: aleksander.lobakin@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done
Date: Wed, 10 Jun 2026 22:03:32 +0200
Message-ID: <20260610200332.33960-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[0sec.ai];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297830-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:aleksander.lobakin@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:-];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,0sec.ai:mid,0sec.ai:email,0sec.ai:url,0sec.ai:from_mime,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3B3366CAE2

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
to outlive tipc_crypto_stop(); with the patch applied the same workload
runs cleanly. Found by 0sec automated security-research tooling while
auditing the siblings of commit e279024617134.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
v2:
 - Add Cc: stable@vger.kernel.org and Alexander Lobakin's Reviewed-by
   (per his review of v1). No functional change.

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


