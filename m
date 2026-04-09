Return-Path: <netdev+bounces-277167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHyTBhkv2GmwZQgAu9opvQ
	(envelope-from <netdev+bounces-277167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:58:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC783D066F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 00:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01C5B3004DB2
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 22:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0239A801;
	Thu,  9 Apr 2026 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qMZOHPM/"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73E39A7F4
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775775507; cv=none; b=FKDZb/lf0w5SupuondnXpH+/I9AA0NAcbyQMFIwszLdEBmoelbvA7x0XZb2qYrLd3yeLgVIDMLbKub+lsnpkFyd/GWiLBfB4uiZtNpZRxE1McfOv1riLiXmnklA7gU423xwvMnVD4eaUrBimMI4kTtYgR4waVujWcxyTCnDP5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775775507; c=relaxed/simple;
	bh=qrSPnQzw/gdM7fHPn1fcyeOsexQXKfPqSvfyGGPJJrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQwBu6/yoecmPH3uL4A0MV5mB1og+YfuVlB8jMK8siIItiyHgE4x1Xmajd8VXYK650Tp9VYlpvGZMH2UzVXjINVDlw9SrsqQCEu8ZmNSdIjXfZU3WWyg2g4TWyRMWelhNabJyQO+oxrqAzXhINmkT4s07NMWgw6Gu87r6WHWni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qMZOHPM/; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775775505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QmwkRKwrZzFhOxslhCRneQBH4U9C3GkVTQuu656kzs=;
	b=qMZOHPM/7ty4cnPkjzbbz6CmjOCC2XKzHAX7lpC2B2e9cQEhIkSFwPJIaVCahV5frckWaE
	3bMU5YFA/qqoP8621JrmvneahZFZ8TonJ9FI+JLq7h7GOvjl4vapOiQH1cdd6GVxTaqSpm
	jBoUiCYNArKPs8atoOEPv298StbT0Bg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v2 2/2] KEYS: annotate struct user_key_payload with __counted_by
Date: Fri, 10 Apr 2026 00:57:05 +0200
Message-ID: <20260409225703.158552-7-thorsten.blum@linux.dev>
In-Reply-To: <20260409225703.158552-4-thorsten.blum@linux.dev>
References: <20260409225703.158552-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=thorsten.blum@linux.dev; h=from:subject; bh=qrSPnQzw/gdM7fHPn1fcyeOsexQXKfPqSvfyGGPJJrE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk39I4s/9y/RLjCglO/XbLz4FJB70sJXLbNrz/3Pp5vG VOr1f+so5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACYSdpORoevz5+vKMqJbmiUK 4x23T/X6yCFg9OB320QXD3EZ/T1G/Ax/OL8e2hE1/1fwh8y73UsmC8/tu/tqpVRxpndHxaLLCy0 W8gAA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277167-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EC783D066F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the __counted_by() compiler attribute to the flexible array member
'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use __aligned(8) as suggested by David
- v1: https://lore.kernel.org/lkml/20260409073711.57020-6-thorsten.blum@linux.dev/

Cc: netdev@vger.kernel.org
---
 include/keys/user-type.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index 386c31432789..c29ed9f5d300 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -27,7 +27,8 @@
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
 	unsigned short	datalen;	/* length of this data */
-	char		data[] __aligned(__alignof__(u64)); /* actual data */
+	char		data[]		/* actual data */
+			__aligned(8) __counted_by(datalen);
 };
 
 extern struct key_type key_type_user;

