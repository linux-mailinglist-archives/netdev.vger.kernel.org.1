Return-Path: <netdev+bounces-292182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK5/NECrFmofoQcAu9opvQ
	(envelope-from <netdev+bounces-292182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:28:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CBB5E118B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9B143019948
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3024D3E123A;
	Wed, 27 May 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N6pzCxFT"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA243DDDC0
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870369; cv=none; b=t/PvXiYL4VCmiMoO6ZiFHcxRPmwf249I/Uq06oxC7i4eVXIRNv6Rs3+pKSBSSfAJQXBlpr18RGLqrtARJTuwenAoiBTcPtTxH2WuIYOVO7pWU2duZVXrPD2MIGQj5xdi7cNvdgv79/8sX0RWZLmbFoSzmacnJ/4d6E0BOv9XYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870369; c=relaxed/simple;
	bh=ESrw4SGAqzCL4bn6LlJpxgD5khphsnGMCRBdtqzdIYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpFr/YN//x9SMRSOd6mmij8yIMB8xVqYVc2ebD1kwdqG84htna1WdM9R167gjf9uWGLxA8Y76TuDkGHeHb4sfYlpnciMYnIstqXAfXzb6XggTo1JWFb9GwShRl/HZu5CUyN0HeRp/9B7on2SaHOKGMXlo18/mhTpIBdIRwxmW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N6pzCxFT; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779870355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iCvyh7BN3nBELcLlZRzlv7xyQaQ0PKVlw652adkjVZU=;
	b=N6pzCxFTyHbBFDGx/bl29YCsA7L2iyfc3290ijGeMNn2fskRQ7B/JrtzS+Shp/Dq6S4bAA
	WyfmW6swmTWfQBufj0AWh368bc9BFzbUW7ShMr3IRpt9G00iD8Tuo63HrACAjuk+rQqG9e
	2f5lMtpSDteGwCtzmsrPL5WHzkun+bs=
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
Subject: [PATCH RESEND 1/6] sock: add sock_kzalloc helper
Date: Wed, 27 May 2026 10:25:11 +0200
Message-ID: <20260527082509.1133816-8-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=thorsten.blum@linux.dev; h=from:subject; bh=ESrw4SGAqzCL4bn6LlJpxgD5khphsnGMCRBdtqzdIYE=; b=kA0DAAoWXqtxINjMdS4ByyZiAGoWqmWiDQJ7ajXt/CE1w+vjBDoeib64KWy/9l2bx39IwV0ZB Ih1BAAWCgAdFiEE4Jr4mE11fHmyNFi5XqtxINjMdS4FAmoWqmUACgkQXqtxINjMdS7X2AD+I/8P Xb/FMUAmBl/FcJcQKiff+umsd3tYwhqHj2cvSIAA/0mnr1iv85mGCjYLhpneTC3diRBeAVEYDc9 X6c8ufRsP
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292182-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D8CBB5E118B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add sock_kzalloc() helper - the sock equivalent to kzalloc().

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Patch 1/6 needs an Acked-by: from netdev maintainers for the series to
go through Herbert's crypto tree:
https://lore.kernel.org/lkml/ahVkZOxZtFes6Huf@gondor.apana.org.au/
---
 include/net/sock.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 76bfd3e56d63..b521bd34ac9f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1913,6 +1913,11 @@ void sock_kfree_s(struct sock *sk, void *mem, int size);
 void sock_kzfree_s(struct sock *sk, void *mem, int size);
 void sk_send_sigurg(struct sock *sk);
 
+static inline void *sock_kzalloc(struct sock *sk, int size, gfp_t priority)
+{
+	return sock_kmalloc(sk, size, priority | __GFP_ZERO);
+}
+
 static inline void sock_replace_proto(struct sock *sk, struct proto *proto)
 {
 	if (sk->sk_socket)

