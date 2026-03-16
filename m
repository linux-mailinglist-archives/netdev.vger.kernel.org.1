Return-Path: <netdev+bounces-268289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA++Bqd4uGn5dgEAu9opvQ
	(envelope-from <netdev+bounces-268289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:39:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D242A1139
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73391302A195
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDDD36404D;
	Mon, 16 Mar 2026 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fTdTWkVO"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF435F612
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697187; cv=none; b=QY9Sl8cAelgXkggYSpHdrpCCUCXYBiyyOHpUc88PYhBt/LnKdarDxqsyWEWqcX7K+ZRu9Cv287xtv+VRrHMCobjMAB3GpfBK+Z4dcd5oMYb0/CZyJRSTOeQ8iuOsW4oC4WTLoKik3gAIsuax3fjxVlGwMl61hyT+B03m7if+e3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697187; c=relaxed/simple;
	bh=y3ZOzIY4/QEDnjGKIWgAVDt4UY6Uk0rSVlWAUMgnY/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6ROXNPl6mdOJZs1XFWi1TgA9B7Dp8tdLvzAaf9BL/+1uhXUNRfn6tfHKSYnjaZ4xMHi4+r0rUbBNhni8B6HKAZRYC6Dq1zl/4IX2d+ak7KjVI3xjRBk4Xjo1PTDvtYkbBhEay+ZTXdoGmfC1eKV/nItikZt2bFK4FDoxlJnSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fTdTWkVO; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773697172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g5IGTONtY0VHhTPLe2jQ75NVMwEU+nkYgpelgwNPAVQ=;
	b=fTdTWkVO3ob+8tbcwAhrvnXrSfCq73/g/ndUEHqEh48nzAj6R4DnMmp7ABHpvVde4YjOnX
	/cAO45/s3cvkqsn2Ysr1yu9Uy2Sc7OnJFllqN2AoTNv8eK5749RJdkLkrHOfebAXeHGXMA
	OGpyqBpBEOAoXEBpJXHPMYw56fgH9DU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Tim Bird <tim.bird@sony.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/dns_resolver: clean up and simplify dns_query()
Date: Mon, 16 Mar 2026 22:38:45 +0100
Message-ID: <20260316213846.1049655-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917; i=thorsten.blum@linux.dev; h=from:subject; bh=y3ZOzIY4/QEDnjGKIWgAVDt4UY6Uk0rSVlWAUMgnY/Y=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk7KtIrJtrF1CbNeHPugoJnw/IwLq4mWyGh0zN8l34Rq syfu2dbRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEwklpOR4emPB4fvzl4QOud4 TAq7mErYmT0bra0Pdc5e/uDu0wi9iFOMDBN9l3PoXaheJ336YGpurae8w7pne3ZkFoW3JjtNneA 2iQEA
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
	TAGGED_FROM(0.00)[bounces-268289-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,sony.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 82D242A1139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fold the name length checks into a single early check, and use
kmemdup_nul() for name-only descriptions and snprintf() for
"<type>:<name>" descriptions to simplify dns_query().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Compile-tested only.
---
 net/dns_resolver/dns_query.c | 40 ++++++++++++++----------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index 53da62984447..3bdea41a2367 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -78,43 +78,33 @@ int dns_query(struct net *net,
 {
 	struct key *rkey;
 	struct user_key_payload *upayload;
-	size_t typelen, desclen;
-	char *desc, *cp;
+	char *desc;
 	int ret, len;
 
 	kenter("%s,%*.*s,%zu,%s",
 	       type, (int)namelen, (int)namelen, name, namelen, options);
 
-	if (!name || namelen == 0)
+	if (!name || namelen < 3 || namelen > 255)
 		return -EINVAL;
 
 	/* construct the query key description as "[<type>:]<name>" */
-	typelen = 0;
-	desclen = 0;
-	if (type) {
-		typelen = strlen(type);
-		if (typelen < 1)
+	if (!type) {
+		desc = kmemdup_nul(name, namelen, GFP_KERNEL);
+		if (!desc)
+			return -ENOMEM;
+	} else {
+		size_t desclen = strlen(type);
+
+		if (desclen == 0)
 			return -EINVAL;
-		desclen += typelen + 1;
-	}
-
-	if (namelen < 3 || namelen > 255)
-		return -EINVAL;
-	desclen += namelen + 1;
 
-	desc = kmalloc(desclen, GFP_KERNEL);
-	if (!desc)
-		return -ENOMEM;
+		desclen += 1 + namelen + 1;
+		desc = kmalloc(desclen, GFP_KERNEL);
+		if (!desc)
+			return -ENOMEM;
 
-	cp = desc;
-	if (type) {
-		memcpy(cp, type, typelen);
-		cp += typelen;
-		*cp++ = ':';
+		snprintf(desc, desclen, "%s:%.*s", type, (int)namelen, name);
 	}
-	memcpy(cp, name, namelen);
-	cp += namelen;
-	*cp = '\0';
 
 	if (!options)
 		options = "";

