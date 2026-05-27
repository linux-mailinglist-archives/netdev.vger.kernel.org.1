Return-Path: <netdev+bounces-292180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIKdI7WqFmofoQcAu9opvQ
	(envelope-from <netdev+bounces-292180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:26:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 492915E10FA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF6DD301DCD4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E453DFC68;
	Wed, 27 May 2026 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wplAlSjv"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D63DD874
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870365; cv=none; b=ABpnX0a+rHrRR4fvNhlKZnjO8F8Xj3oBi9HvNdF/zlbm47U+3EO5t7PtRWGI96ejOxUndJGd/l2r94ltvAYPY5xjGpy5KCT2MBamUW4griJRZX58j+fE0omUov9wR2tx27Hu+xU/ZQS+/cZBZhndToYK/GFfujYnZGitOuO/LZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870365; c=relaxed/simple;
	bh=ZvfXWR5k1r7TzSLddYu+UEUvINjvO91+Xxhh/ScI/tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8VcvYuopHNmvUUmFYYwCkCTdLynK1bGVtgAHtZXCXwudmaDLLqi18OIp9z8AJ2SLPPFE/MknVemY2q7OM3mexZ8GgZuSxq3YTPeQpFk5m+uOSWu3y5LkSdR4cirKZBoiGI2x26HGCNsfXGKgv3UkiOp7XLHaePAXWSTARCV6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wplAlSjv; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779870360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pq9EXOiDNg6EPoIk3Z3sQS7nI7pVh35u0o+CMtBzT28=;
	b=wplAlSjvoBCLkP0RWZoNS+ac0heamApqdVbtYDvPPLSnH/n+b/4/aVJMlvc9WN3KLqdUYU
	5PBpn7gyokF8IiWrTtN28TNW+xwtBmBHTpBR+qlxaJgGZVu4keiGTXLbGRi2l8lifT9ZCE
	//svJoO1HBigrvjZflq4sVtM2epsp1U=
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
Subject: [PATCH RESEND 5/6] crypto: algif_rng - use sock_kzalloc in rng_accept_parent
Date: Wed, 27 May 2026 10:25:15 +0200
Message-ID: <20260527082509.1133816-12-thorsten.blum@linux.dev>
In-Reply-To: <20260527082509.1133816-8-thorsten.blum@linux.dev>
References: <20260527082509.1133816-8-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=779; i=thorsten.blum@linux.dev; h=from:subject; bh=ZvfXWR5k1r7TzSLddYu+UEUvINjvO91+Xxhh/ScI/tw=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFliq/KYZgpsNo6Y55vMvrNqx2oV1ZnC8euZfXpVAzyiZ VXPu+V1lLIwiHExyIopsjyY9WOGb2lN5SaTiJ0wc1iZQIYwcHEKwETCTjL8symYd9jgevYJL+77 UYsOO+4QvTEp+3yPwbVFOyQUVar9HRj+Fy++vMdKtM2swHv70sMK6/xiZm83yD/S9P1Q09wQeTZ 1RgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292180-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 492915E10FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace sock_kmalloc() followed by memset(0) with sock_kzalloc() to
simplify rng_accept_parent().

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/algif_rng.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index a9fb492e929a..f609463f9e14 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -244,11 +244,10 @@ static int rng_accept_parent(void *private, struct sock *sk)
 	struct alg_sock *ask = alg_sk(sk);
 	unsigned int len = sizeof(*ctx);
 
-	ctx = sock_kmalloc(sk, len, GFP_KERNEL);
+	ctx = sock_kzalloc(sk, len, GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
-	memset(ctx, 0, len);
 	ctx->len = len;
 
 	/*

