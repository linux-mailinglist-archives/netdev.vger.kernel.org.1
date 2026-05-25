Return-Path: <netdev+bounces-291277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAs4HH4dFGoGJwcAu9opvQ
	(envelope-from <netdev+bounces-291277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:59:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FFA5C8E1D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C35CF3011111
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8DC3E51C2;
	Mon, 25 May 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XXwJ1XV3"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B7328B62
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702903; cv=none; b=qh5GEtoLeULuCfB3P01cx+XPUmh1iM9+slPAcMezMyeMade/RBgd4PET2F7yjJN+XCxhaTy9turowo6H5zCftSgsWEwzTBDydv+gkLpqCuXACfGkKTWOXS0tveJ2iYpQ+gwIa6qaufQt68gU52nk0F5co+MPSqtpZ5bUMzqfizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702903; c=relaxed/simple;
	bh=dTwcgAi/dh/BQNuwqTIkwFUKF5W0dpplH2rKlAiqqww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KX0LAPUkkHh31bDhNYhPzjIfRUHfxBUiszzvC3558LY2b+ONPZbi/97HZNP8Qi1YpukCsMu8buYgd972D1PNW1NXr+xCw8gOmNMDHgbKYiH3cFI7EPWHiaI/SHPPiex3DWLklZBPbkF3CURIBJ64Tdr9LfZ5wSpoGVkJ/YMzgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XXwJ1XV3; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779702898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mn8BCON48RNsbs65DnAKHB4VMspvtxbh062pndM79gk=;
	b=XXwJ1XV32ZhK/EOMIcDViuaMHI1wqrPWWp8B91z8rWLGg155SrJs8cCiMGb2CgiA2GwDzk
	/EI0eylKMOR11e82cD3CUykH0trWg9/uewNccyA/6wDZPvBkPo0Io+1EXgrqb9UGkmvHhm
	EtY7REpjpGhQmfRt+QP4A+uCqW8sbVc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Tim Bird <tim.bird@sony.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/dns_resolver: consolidate namelen checks in dns_query
Date: Mon, 25 May 2026 11:54:01 +0200
Message-ID: <20260525095400.821912-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003; i=thorsten.blum@linux.dev; h=from:subject; bh=dTwcgAi/dh/BQNuwqTIkwFUKF5W0dpplH2rKlAiqqww=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkiMhZu1ktbggtbyvz7DpoqnFQ/3TTv3+5rG9xeWa54f vJGmOSujlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZgI831GhomfX52Yf+tyzISF 1+6nHNSYnTChTapp4uq8T40TZAtOJioyMtyqKlKLDLg68f9WHaO1K/yzxVd9PSmr0biDZ8qdXYH C8xgA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291277-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,sony.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C8FFA5C8E1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Consolidate the namelen checks and return -EINVAL early if needed. Drop
the namelen == 0 check since it is covered by namelen < 3.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/dns_resolver/dns_query.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index e1c09d7b8200..c250d82cad96 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -73,7 +73,7 @@ int dns_query(struct net *net,
 	kenter("%s,%*.*s,%zu,%s",
 	       type, (int)namelen, (int)namelen, name, namelen, options);
 
-	if (!name || namelen == 0)
+	if (!name || namelen < 3 || namelen > 255)
 		return -EINVAL;
 
 	/* construct the query key description as "[<type>:]<name>" */
@@ -86,8 +86,6 @@ int dns_query(struct net *net,
 		desclen += typelen + 1;
 	}
 
-	if (namelen < 3 || namelen > 255)
-		return -EINVAL;
 	desclen += namelen + 1;
 
 	desc = kmalloc(desclen, GFP_KERNEL);

