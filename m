Return-Path: <netdev+bounces-290678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB92Nq/qD2omRgYAu9opvQ
	(envelope-from <netdev+bounces-290678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:33:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA745AF2D9
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 180F03034B27
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A6E39EF05;
	Fri, 22 May 2026 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csgCnv12"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6039EF1E;
	Fri, 22 May 2026 05:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427868; cv=none; b=uvE/vgbJ1g6c4hc4y2dqV3+ZyxleXr6IzSHD7uC+uKx5lJ5a7SJUINNuHbzMQ5Inl/Pmkk7Kb1ZYLus/3vTLI+KAdJyUWPMMnn6v9BQBvrU1ERsgUKGRbX4V3a0RkMea4f6BigRcGJX4Pryqda549pcUL8tDuwhNkILSvtExYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427868; c=relaxed/simple;
	bh=3AAEZjaRK507ex3BYJ5Fuxt8FZkNq3ASxA/sK1xrsH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2MQfQ6QJlwk+at9sT1nB3rWSjJWuIvM3+Xta1b3FGUHFhedsegnPEln47Wm7tNGw1WxlspeAHs0LRvK8IWr1jemcbB5M7CpcWigbPVsmZZqjfBYGdpJ9UnCDflL0ffIfxXKhp0r41K4FAW31gRB+NHtr/l71Gk6Bji8RrED5tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csgCnv12; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C2C1F000E9;
	Fri, 22 May 2026 05:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779427865;
	bh=uWvNpb1256Gs/nAAgMw5xRh+0CIJM6zXjVMv2A02v+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=csgCnv121CG8Dji8w4I9UoXVsx1v/07a2KRvFBBooMerr4c1DUdIRkgYLgtqLnNGx
	 DzfLXdYMRhYSlqne8i+E1phzz8JZjGoIYmpaOEdQ7/wr+85UcfUB2E6A4/Tptqb0da
	 ze201qHRP3PptWFaZNNBpRW8aQ9Wzufpu5R6tVcRQmz6zcg0217jZj2TjAtT7msu47
	 VoCYErd0AeKa8K2WkQ9fIQ/kONRV1mdgM2dlLk9YNO3sMm+MKm9J0rbPRvy25m5iAR
	 93CZjHmM0vr+L5nP3e54ajnJEZ3tyql8VNG0FE5tWrZO7579smO50zjLqGWcb14HVx
	 FePHenEY9Bmeg==
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
Subject: [PATCH net-next 3/6] crypto: api - Remove crypto_clone_tfm()
Date: Fri, 22 May 2026 00:30:25 -0500
Message-ID: <20260522053028.91165-4-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,zx2c4.com,gondor.apana.org.au,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290678-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3CA745AF2D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since all callers of crypto_clone_tfm() have been removed, remove it.

Note that no tests need to be removed, as this function had no tests.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/api.c      | 26 --------------------------
 crypto/internal.h |  2 --
 2 files changed, 28 deletions(-)

diff --git a/crypto/api.c b/crypto/api.c
index 74e17d5049c9..d019d1979857 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -558,36 +558,10 @@ void *crypto_create_tfm_node(struct crypto_alg *alg,
 out:
 	return mem;
 }
 EXPORT_SYMBOL_GPL(crypto_create_tfm_node);
 
-void *crypto_clone_tfm(const struct crypto_type *frontend,
-		       struct crypto_tfm *otfm)
-{
-	struct crypto_alg *alg = otfm->__crt_alg;
-	struct crypto_tfm *tfm;
-	char *mem;
-
-	mem = ERR_PTR(-ESTALE);
-	if (unlikely(!crypto_mod_get(alg)))
-		goto out;
-
-	mem = crypto_alloc_tfmmem(alg, frontend, otfm->node, GFP_ATOMIC);
-	if (IS_ERR(mem)) {
-		crypto_mod_put(alg);
-		goto out;
-	}
-
-	tfm = (struct crypto_tfm *)(mem + frontend->tfmsize);
-	tfm->crt_flags = otfm->crt_flags;
-	tfm->fb = tfm;
-
-out:
-	return mem;
-}
-EXPORT_SYMBOL_GPL(crypto_clone_tfm);
-
 struct crypto_alg *crypto_find_alg(const char *alg_name,
 				   const struct crypto_type *frontend,
 				   u32 type, u32 mask)
 {
 	if (frontend) {
diff --git a/crypto/internal.h b/crypto/internal.h
index 8fbe0226d48e..96f84abfac91 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -124,12 +124,10 @@ struct crypto_tfm *__crypto_alloc_tfmgfp(struct crypto_alg *alg, u32 type,
 					 u32 mask, gfp_t gfp);
 struct crypto_tfm *__crypto_alloc_tfm(struct crypto_alg *alg, u32 type,
 				      u32 mask);
 void *crypto_create_tfm_node(struct crypto_alg *alg,
 			const struct crypto_type *frontend, int node);
-void *crypto_clone_tfm(const struct crypto_type *frontend,
-		       struct crypto_tfm *otfm);
 
 static inline void *crypto_create_tfm(struct crypto_alg *alg,
 			const struct crypto_type *frontend)
 {
 	return crypto_create_tfm_node(alg, frontend, NUMA_NO_NODE);
-- 
2.54.0


