Return-Path: <netdev+bounces-292177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YON1BaCqFmofoQcAu9opvQ
	(envelope-from <netdev+bounces-292177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:26:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC2A5E10D3
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 533C0301DEEE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD513DE428;
	Wed, 27 May 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CopY1Ofa"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621993CFF53
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870362; cv=none; b=th8lBeK8WKwMNGcAHuivD4s7W4u3QEHagDilrlyKHh5JL16qCMFBTRdb1po/XLRwqn5EmlK5ZFVS+aw+OsHC3jcoHWRbd6qn9DzREixDa7eRutWgg+1Ec3nXDf0f8l/YN9J6DtYipiXeyISyrUkZSuQ7nlknr8UCjG/G2t6Es4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870362; c=relaxed/simple;
	bh=dorb39L1hm609iNx5qGNHtSqrBXFtt+eSbo1jj5NOnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gez4GKXAybIlbYDWTWq40+LcySB5OFvN8W6200XNVqhUQ7XTepGGrDFDBCIpbhvEMpxtLGByuWvVpf1wBXMUOphYXUX+tX7WPjEDvsx/zJXWgkIFFM7W19vuav4DjCG0eW00ZIu/CeJD34Pq3GUBztCXk2lbjB6fXn3eK8U/VHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CopY1Ofa; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779870357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTCgQE0RalUvAfxSt+nEuguijFHud6dRjiDoCjUKHlE=;
	b=CopY1OfarvXOxMgbBLftwcznVz6AOEGFK27SS/Q6mJX1d9zJKFKSg9vdjX7fxGfkEXSubk
	EhmFQcyzwd/L+kdPDLBhleqS0fLl17PWReQcvNIVOC6LhLMIBiN/JPtC16FXxvuNfUfU7r
	41SgjUZUzjfuirOKqonRoyqhjAKJP3M=
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
Subject: [PATCH RESEND 2/6] crypto: af_alg - use sock_kzalloc in af_alg_alloc_areq
Date: Wed, 27 May 2026 10:25:12 +0200
Message-ID: <20260527082509.1133816-9-thorsten.blum@linux.dev>
In-Reply-To: <20260527082509.1133816-8-thorsten.blum@linux.dev>
References: <20260527082509.1133816-8-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; i=thorsten.blum@linux.dev; h=from:subject; bh=dorb39L1hm609iNx5qGNHtSqrBXFtt+eSbo1jj5NOnY=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFliq3LnmR/dlNHBFu5Y9PFKp8Dn+Noze/O7s9grpketa //W47O+o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACaiOIeR4YZIQb6wyWVL/4Jf k3ytvRseKHfdP1y0UDqP8WJf9kambQz/XVX22t9m3Cb3U3dyS8+HwNgdi0ouGM1Rz/s4uyNlE6M aCwA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292177-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: BEC2A5E10D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace sock_kmalloc() followed by memset(0) with sock_kzalloc() to
simplify af_alg_alloc_areq().

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/af_alg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 48c53f488e0f..9438a874c1f1 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1158,12 +1158,10 @@ struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
 	if (ctx->inflight)
 		return ERR_PTR(-EBUSY);
 
-	areq = sock_kmalloc(sk, areqlen, GFP_KERNEL);
+	areq = sock_kzalloc(sk, areqlen, GFP_KERNEL);
 	if (unlikely(!areq))
 		return ERR_PTR(-ENOMEM);
 
-	memset(areq, 0, areqlen);
-
 	ctx->inflight = true;
 
 	areq->areqlen = areqlen;

