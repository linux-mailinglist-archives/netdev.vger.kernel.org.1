Return-Path: <netdev+bounces-292865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJJcCiXAGGoumwgAu9opvQ
	(envelope-from <netdev+bounces-292865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:22:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 854725FAE70
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 579763017253
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102B33439A;
	Thu, 28 May 2026 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LjJb+dUv"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4631A35E549
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006858; cv=none; b=Upjq67FARfkeAhaiMVum9Y9b8LjPBLizQVXYmWwXHEjgVr49c7+j6+RnEVFB9kDENOS0o0MpVQ5aZuexpC3xc40sGZbrnSljwFkJCvhsXLbdV4NN3GxYxBL/av2FHCFer+aA7GXxgfHxW7xyqkbNQ0abIZ2A9NeXAGpllqKrzGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006858; c=relaxed/simple;
	bh=cVfpuWgsq2ZfaJ8+deeWRwLkA7RF4c0bRWku1w2ub2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcTbJl2ZVH7+Eh0ZNwPxoJOaaDJaX2N4RcKuacjEOE+AnIFMr/tCEgWNKD5/weG8KLbmOEJuMal4pbZwD3+5e+7+PRkZnr/Ez5FqOb2wEZhO/LXgtngtWZWcjGONkhYndSgqC2MZz/+hHma3cVjho4PEoE21B9NRN6vVhzlotUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LjJb+dUv; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780006854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wGVSmiz/gY2xjcrcLB1LkoCl2huToOXZUu1qh5UF84I=;
	b=LjJb+dUvQlGf1fSaE0nglcNXq18yuF1x7kEB0b53IJB6VlRZzJPBG43Rd/bTmrz9YNerS3
	eEJLuZeKPIwpy/ZI5I6Ijb2SBYnZQA2Fu1lzfqi1hqOS/UIaJ8zlNiPDBJo3SVs38YQm6W
	GJ+INLe2GPcC5N567Cxh6yjrm6LZ0vU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tim Bird <tim.bird@sony.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/dns_resolver: use kasprintf + kmemdup_nul to simplify dns_query
Date: Fri, 29 May 2026 00:20:29 +0200
Message-ID: <20260528222030.1655010-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=thorsten.blum@linux.dev; h=from:subject; bh=cVfpuWgsq2ZfaJ8+deeWRwLkA7RF4c0bRWku1w2ub2w=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkS+9cVJS8rbQpMeyVsVWzgWDfv3Ael2IqbGQ8VU1WKb yQsn8rZUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABM5mszwv0BDQD6sOUNhl6oC d7vm/2D5YANNbw6/1U9POYbd4Psizsgwk5nl2p77AfN1HV6Lfs/Yt/jz1UKulZobV17eteyDUK8 bPwA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292865-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,sony.com,linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 854725FAE70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use kasprintf() for descriptions with a query type and kmemdup_nul()
otherwise to simplify dns_query().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/dns_resolver/dns_query.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index c250d82cad96..40c9acdb26cd 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -66,8 +66,7 @@ int dns_query(struct net *net,
 {
 	struct key *rkey;
 	struct user_key_payload *upayload;
-	size_t typelen, desclen;
-	char *desc, *cp;
+	char *desc;
 	int ret, len;
 
 	kenter("%s,%*.*s,%zu,%s",
@@ -75,33 +74,17 @@ int dns_query(struct net *net,
 
 	if (!name || namelen < 3 || namelen > 255)
 		return -EINVAL;
+	if (type && *type == '\0')
+		return -EINVAL;
 
 	/* construct the query key description as "[<type>:]<name>" */
-	typelen = 0;
-	desclen = 0;
-	if (type) {
-		typelen = strlen(type);
-		if (typelen < 1)
-			return -EINVAL;
-		desclen += typelen + 1;
-	}
-
-	desclen += namelen + 1;
-
-	desc = kmalloc(desclen, GFP_KERNEL);
+	if (type)
+		desc = kasprintf(GFP_KERNEL, "%s:%.*s", type, (int)namelen, name);
+	else
+		desc = kmemdup_nul(name, namelen, GFP_KERNEL);
 	if (!desc)
 		return -ENOMEM;
 
-	cp = desc;
-	if (type) {
-		memcpy(cp, type, typelen);
-		cp += typelen;
-		*cp++ = ':';
-	}
-	memcpy(cp, name, namelen);
-	cp += namelen;
-	*cp = '\0';
-
 	if (!options)
 		options = "";
 	kdebug("call request_key(,%s,%s)", desc, options);

