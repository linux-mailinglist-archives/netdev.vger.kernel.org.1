Return-Path: <netdev+bounces-294055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMJIKI+DHmqhkQkAu9opvQ
	(envelope-from <netdev+bounces-294055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:17:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05382629741
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03960300B9D6
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 07:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C393A8753;
	Tue,  2 Jun 2026 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O+LtoKau"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E773A8746
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384459; cv=none; b=f4nfwXBGS61GqmtzIGwWwXFCD03uiKkka/NVyxeBiqzWzYV6IX2s9YX2cnkIt57IIdWh7C7VOakmGJrqjfPtHehuG/IKPQJTHzh1S6MU/Xda089Z5zV1T++GrjEudMFybsbkXv/3+d+V7C2QNinNz9bW08baZQpWHRmeqarFQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384459; c=relaxed/simple;
	bh=ggB3SFUBedF/nHlI+XXyHFfTtUtAXXLVMDwiQrW5lDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuR/TRdmK9sm2pUHYm4IJDP5KyYxWuteLsPVlxwfYZ6HnY3ONKBcsPNQSA7BZusZybtSZmwXRbKUkrAWZGPktTOger7btbvVWDiwt3h5JgGGe363GJnc52gdxJ8EtkzoUdkxjlzoL7bLrhVBKvypXA+J+YbA2q0Ja2YKC0o+aUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O+LtoKau; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780384452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x+yylFIMPR/8vrOHBFj2Pr0z/6HumSH0G5CRMfJ5N6s=;
	b=O+LtoKaurViSIY1QIl6wpYBx93vKk+sJHfgaPUGlIFpcnvCHvjRQyzI2DWuzqPHKK3EqdF
	kMFceXT9ig7ANx/7ovYlu4Fe163Zggooqpfj69+ntgw24nPmxA1FmFkjqQZDk/K13VxB2p
	In1E6t8Thyln3NPyIqLAKM0pyBFEUAw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Tim Bird <tim.bird@sony.com>,
	Amir Goldstein <amir73il@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net/dns_resolver: use kasprintf + kmemdup_nul to simplify dns_query
Date: Tue,  2 Jun 2026 09:13:41 +0200
Message-ID: <20260602071343.962830-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=thorsten.blum@linux.dev; h=from:subject; bh=ggB3SFUBedF/nHlI+XXyHFfTtUtAXXLVMDwiQrW5lDk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlyTcvzAidcucxoVfn4Gmfdp0tcO8JTHN/us7upbf8+r L6xwUO0o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACay6CPDX8HFIauW3Tb12FMS Lqk6tYVx88r5ZwqXm03f9UXyX972Z0cYGW7FBFyQmP//U/Gd9oCNL3bwzRbdO0ftlGc7n+XJXPe K/8wA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294055-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linux.dev,sony.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05382629741
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use kasprintf() for descriptions with a query type and kmemdup_nul()
otherwise to simplify dns_query().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Reverse xmas tree (Jakub)
- v1: https://lore.kernel.org/lkml/20260528222030.1655010-2-thorsten.blum@linux.dev/
---
 net/dns_resolver/dns_query.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index c250d82cad96..14bee83cbe22 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -64,44 +64,27 @@ int dns_query(struct net *net,
 	      const char *options, char **_result, time64_t *_expiry,
 	      bool invalidate)
 {
-	struct key *rkey;
 	struct user_key_payload *upayload;
-	size_t typelen, desclen;
-	char *desc, *cp;
+	struct key *rkey;
 	int ret, len;
+	char *desc;
 
 	kenter("%s,%*.*s,%zu,%s",
 	       type, (int)namelen, (int)namelen, name, namelen, options);
 
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

