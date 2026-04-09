Return-Path: <netdev+bounces-276870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMo/AotX12kFMggAu9opvQ
	(envelope-from <netdev+bounces-276870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:38:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E843C71F5
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D81E6300B50F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB5D37C0F8;
	Thu,  9 Apr 2026 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZOJUrxfH"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2E34C815
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720318; cv=none; b=lS1mapfmEus/z/V1sB/bN7gsQY5cNjAwK0bhPy8VAptF9XAMTjoKXxjumb8dP9QPmiALQI4GfupQMHJKy06Y7TfgMxGj4hnk8iYTjojNuzTUjGv8KrXuCsxqmKtHcm59QFjBGIQswg+7GjCHcDDDlUX3UNw86qcv+jk9Ffi8xkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720318; c=relaxed/simple;
	bh=jUVCD18qBj55kiQf5LCb0CfnXhvlUgd5d4yqTC7/xCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvdRhCZk2p/GhdOi56VgEg1DBRaUka8muQVNAhVb35lZzaEuFquSlL0UJ0/tLQcjz+8Gxbl4TeMkGaLqVclW6Qp6sHf8BLIn5nuNtOOCPPlya45syTkQwqPadCSv/bJcw0r0HYP8PXouClgpN+uLStkAesNONSXdfxES6oOANcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZOJUrxfH; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775720315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AiTN0Mif+OlOP/8EPg85nSXf7Y5Nv8jHlAvMHMDCs20=;
	b=ZOJUrxfHxIiSMG4KLG5gzEWNzkptjlTg0dGlAbWcYpARzsszbaCh6rjBSg2l/hpxn74yun
	gcigbuZOgomb074+8LBZV6iYejbJjvrq9A1ZKjnHKcMjpND++QW/XOuyta5B/nJB/zjEwB
	HUJWB8BVcNjOggS16UcsgqU02Kj8uVU=
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
Subject: [PATCH RESEND net-next 2/2] KEYS: annotate struct user_key_payload with __counted_by
Date: Thu,  9 Apr 2026 09:37:13 +0200
Message-ID: <20260409073711.57020-6-thorsten.blum@linux.dev>
In-Reply-To: <20260409073711.57020-4-thorsten.blum@linux.dev>
References: <20260409073711.57020-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=thorsten.blum@linux.dev; h=from:subject; bh=jUVCD18qBj55kiQf5LCb0CfnXhvlUgd5d4yqTC7/xCg=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnXw9WXpfasVXvPK1hQdNRTsS/H/d9hIaVFq3ZMXxEoc eSmUtHNjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZhISw0jw436jQL9uVbnEyP2 NLP3affN2rMyLKG1To9TTvuA9W9hSYb/Ecfy1XQne6aeS/D/uVBHtKVurui6qkOBlkWsuxSctzR zAgA=
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
	TAGGED_FROM(0.00)[bounces-276870-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 09E843C71F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the __counted_by() compiler attribute to the flexible array member
'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Resending this because patch 2/2 didn't go to netdev@ (Jakub)
Cc: netdev@vger.kernel.org
---
 include/keys/user-type.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index 386c31432789..2305991f4fcd 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -27,7 +27,8 @@
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
 	unsigned short	datalen;	/* length of this data */
-	char		data[] __aligned(__alignof__(u64)); /* actual data */
+	char		data[]		/* actual data */
+			__aligned(__alignof__(u64)) __counted_by(datalen);
 };
 
 extern struct key_type key_type_user;

