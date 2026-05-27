Return-Path: <netdev+bounces-292181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKD1KAKrFmofoQcAu9opvQ
	(envelope-from <netdev+bounces-292181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:27:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB805E1140
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDF2C30640BF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C743E00A6;
	Wed, 27 May 2026 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nJivxGDR"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07C3DDDB8
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870365; cv=none; b=m4+tgaTDbuP39jfJ2TywALqFVKCguMpSGMnQHk1jPudQcG47jLTe2i0ipmKXC49LOhYUU+CmgM9A8o5d96JU1xhQegUj40A7osarDCIBJ4m2BJYYa+HXvowybH8dgDHtwxK71m9ZsBXoIchw75Mfhm/wn8qA8Uwhhv+fQ+knf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870365; c=relaxed/simple;
	bh=7BpKPspgoo5nW+mSqH5uYZJNBecq065JZMJ4642Iuvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgEG6f+y/rCLbhxjmWA/G2mooPnKEjNOiNi2pqnoZc/fhmBQx992HVklcodMPvy8mSp4zWKADMF/IsK/+bYDTjT1b5Z0wICI81TQc+3luvBZLdBtJcsYgF8TcWFIolVrzSXsrtWRb1+FIyzci1TUKAoAXhXB2bgCTdjqfmx76qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nJivxGDR; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779870361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzRKXyVvWFIBlmQWw546l6ZchldmgJ+7MD/dVHG44m0=;
	b=nJivxGDRervO6vfj1N6KqFk5GfFLaSj9Ee24agSDgps/ZKEpZbIupE0rXeoFikWyaf6hOS
	2VYjA3AlLtAF1NsLM/S1MFHVKgfS2fgvXBR55CZZqB2Jpf9+faYMUBMB8yTrzRRskQ0cTr
	Q18MdyJOG4rUrj8mc0ylU+enqJOWY88=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH RESEND 6/6] crypto: algif_skcipher - use sock_kzalloc in accept_parent_nokey
Date: Wed, 27 May 2026 10:25:16 +0200
Message-ID: <20260527082509.1133816-13-thorsten.blum@linux.dev>
In-Reply-To: <20260527082509.1133816-8-thorsten.blum@linux.dev>
References: <20260527082509.1133816-8-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=thorsten.blum@linux.dev; h=from:subject; bh=7BpKPspgoo5nW+mSqH5uYZJNBecq065JZMJ4642Iuvg=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFliq/I2sSy+JDO75pwJR1Lt/k9b/u1aXyZd1jvLifvUA W0x/aMaHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRdRMYGb7P+dCeP0PoqHWv 47l1myzNileHSJ1pmhtmzdpos79oig0jw5mSHTrVVm17s/fPjD90soO/UefsjwbHI6WFQnnrd/U LMwAA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292181-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 5BB805E1140
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace sock_kmalloc() followed by memset(0) with sock_kzalloc() to
simplify skcipher_accept_parent_nokey().

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/algif_skcipher.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index ba0a17fd95ac..f29a304e1268 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -383,18 +383,15 @@ static int skcipher_accept_parent_nokey(void *private, struct sock *sk)
 	struct crypto_skcipher *tfm = private;
 	unsigned int len = sizeof(*ctx);
 
-	ctx = sock_kmalloc(sk, len, GFP_KERNEL);
+	ctx = sock_kzalloc(sk, len, GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
-	memset(ctx, 0, len);
 
-	ctx->iv = sock_kmalloc(sk, crypto_skcipher_ivsize(tfm),
-			       GFP_KERNEL);
+	ctx->iv = sock_kzalloc(sk, crypto_skcipher_ivsize(tfm), GFP_KERNEL);
 	if (!ctx->iv) {
 		sock_kfree_s(sk, ctx, len);
 		return -ENOMEM;
 	}
-	memset(ctx->iv, 0, crypto_skcipher_ivsize(tfm));
 
 	INIT_LIST_HEAD(&ctx->tsgl_list);
 	ctx->len = len;

