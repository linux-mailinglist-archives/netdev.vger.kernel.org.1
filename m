Return-Path: <netdev+bounces-290679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDkrNNLqD2omRgYAu9opvQ
	(envelope-from <netdev+bounces-290679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:34:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 539B95AF2F6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E28B303C4D1
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F533A169D;
	Fri, 22 May 2026 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJsF2ZtY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1499389DE3;
	Fri, 22 May 2026 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427869; cv=none; b=pLFoCFTgtVp1t9n+Oha0VYkV0UgY8utoPNdLorcOzBP2/Fz0dCemq7b2VEJvwdt0NCTyEbQqeP36GR/cPOsVNgpADPf8bRi3v/SnCS7GMWxpNOKQ7dnOD7enVQz+Ur32yJSUtefccUXECJa6es4KPE/n/hnNJqXJunfLRTjqca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427869; c=relaxed/simple;
	bh=olYUFSu6SpRXYOxnbxyXzaK1+ZLTFwClbiEhOovDBwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOqWLsY/C5C2LfSZH3A0tmuCwgeky2/S66cZ1Zz25WILoek8UyG85QnpdbuRP9cdSmkzSXtp4Qo9EtI6mKrk5IdJA4dB3Hlr8vAH9WMDVda72oDHPmnw8O+gL0BTwvQU0yoSpl3yZwrO/cTCQlozMVGUemLNN9+A3SMXENf2enc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJsF2ZtY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859B51F00A3E;
	Fri, 22 May 2026 05:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779427866;
	bh=5cG91g8TflO4oqr+MQMSWsnVgz6/nNgqVLxInjxjlf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJsF2ZtYdzNtzuQZg3Ic5EeSNAHTEHe7KoTfhnj6b+BGH71tXhhxbFymJ1GMvt0Zv
	 Ia9qEFNZKpU8IVXsVwyh6aknACjMil9DGwC7t940CWiIVJdEqU+4V320DEu2Js58cW
	 qpa1iDsn0NknrlDliTaQ0im+DxbAgjDjF9sGYD+461OuZ2BtqjMUlRI3FVJe0Aw9mP
	 EsAWC4m6bIFbU1XpMLyBzBc2nMW+SIMtIPljwYJ9F2kB3P/V1EC7wFl/WMjrOP6n6b
	 vPf6e5c6F/uwNf+oBpnt83bT/9jsjEo8qjrn527J4PfdXFaSRvcrvzarIO2mC6ITXB
	 TJ/s/9N32lw3w==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net-next 4/6] crypto: api - Remove per-tfm refcount
Date: Fri, 22 May 2026 00:30:26 -0500
Message-ID: <20260522053028.91165-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522053028.91165-1-ebiggers@kernel.org>
References: <20260522053028.91165-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,zx2c4.com,gondor.apana.org.au,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290679-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 539B95AF2F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit ae131f4970f0 ("crypto: api - Add crypto_tfm_get").

The refcount in struct crypto_tfm was added solely to support
crypto_clone_tfm().  Before then it was a simple non-refcounted object.

Since crypto_clone_tfm() has been removed, remove the refcount as well.

Note that this eliminates an expensive atomic operation from every tfm
freeing operation.  So this revert doesn't just remove unused code, but
it also fixes a performance regression.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/api.c           | 4 ----
 crypto/internal.h      | 6 ------
 include/linux/crypto.h | 1 -
 3 files changed, 11 deletions(-)

diff --git a/crypto/api.c b/crypto/api.c
index d019d1979857..be9ee104ffc2 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -416,11 +416,10 @@ struct crypto_tfm *__crypto_alloc_tfmgfp(struct crypto_alg *alg, u32 type,
 	tfm = kzalloc(tfm_size, gfp);
 	if (tfm == NULL)
 		goto out_err;
 
 	tfm->__crt_alg = alg;
-	refcount_set(&tfm->refcnt, 1);
 
 	if (!tfm->exit && alg->cra_init && (err = alg->cra_init(tfm)))
 		goto cra_init_failed;
 
 	goto out;
@@ -517,11 +516,10 @@ static void *crypto_alloc_tfmmem(struct crypto_alg *alg,
 		return ERR_PTR(-ENOMEM);
 
 	tfm = (struct crypto_tfm *)(mem + tfmsize);
 	tfm->__crt_alg = alg;
 	tfm->node = node;
-	refcount_set(&tfm->refcnt, 1);
 
 	return mem;
 }
 
 void *crypto_create_tfm_node(struct crypto_alg *alg,
@@ -647,12 +645,10 @@ void crypto_destroy_tfm(void *mem, struct crypto_tfm *tfm)
 	struct crypto_alg *alg;
 
 	if (IS_ERR_OR_NULL(mem))
 		return;
 
-	if (!refcount_dec_and_test(&tfm->refcnt))
-		return;
 	alg = tfm->__crt_alg;
 
 	if (!tfm->exit && alg->cra_exit)
 		alg->cra_exit(tfm);
 	crypto_exit_ops(tfm);
diff --git a/crypto/internal.h b/crypto/internal.h
index 96f84abfac91..b6e437f463d4 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -8,11 +8,10 @@
 #ifndef _CRYPTO_INTERNAL_H
 #define _CRYPTO_INTERNAL_H
 
 #include <crypto/algapi.h>
 #include <linux/completion.h>
-#include <linux/err.h>
 #include <linux/jump_label.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/numa.h>
@@ -207,12 +206,7 @@ static inline void crypto_yield(u32 flags)
 static inline int crypto_is_test_larval(struct crypto_larval *larval)
 {
 	return larval->alg.cra_driver_name[0];
 }
 
-static inline struct crypto_tfm *crypto_tfm_get(struct crypto_tfm *tfm)
-{
-	return refcount_inc_not_zero(&tfm->refcnt) ? tfm : ERR_PTR(-EOVERFLOW);
-}
-
 #endif	/* _CRYPTO_INTERNAL_H */
 
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index a2137e19be7d..b7c97f1c47c9 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -407,11 +407,10 @@ int crypto_has_alg(const char *name, u32 type, u32 mask);
  * and core processing logic.  Managed via crypto_alloc_*() and
  * crypto_free_*(), as well as the various helpers below.
  */
 
 struct crypto_tfm {
-	refcount_t refcnt;
 
 	u32 crt_flags;
 
 	int node;
 
-- 
2.54.0


