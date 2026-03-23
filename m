Return-Path: <netdev+bounces-270425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +zr4OB78wGmiPQQAu9opvQ
	(envelope-from <netdev+bounces-270425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:38:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D992EE585
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CC99302256C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6863803FA;
	Mon, 23 Mar 2026 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="d7a28+Bu"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07CD37FF58
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254981; cv=none; b=IbFr7g0w5GdmZ4ROl9JA32pjH9gu7FHJRmsI24GvoNUuYKbxWQytVAhfpFz7bEYujhHWxc1X5h8tGv19ePHtcMUCorvCU50pcfazrpN9JCtzaS2wFHqAxhL698uvEIXcvhiqI2CzCIDpxh48IjfnT2mHaeIHoowtYwHj08tGu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254981; c=relaxed/simple;
	bh=+lX5eMXPxdhNIi0lsS/3czJJnebZNOUMbe7EvKe8fVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puP+UlkKH8HA6O5xM7bxag2fNnAqIqG89rnNp15LsUNO/WNMHboC0kBKWvEwwnPa73Bpvsv2CP9GxXGrQZkxWzoZFnlF7j4qMNmOI3jZLyJCfjhwUWaQ3ghv0LfLzoelaAck7Rqyc1GHprSUVFwO02ynhk645sY1LN1Qr0Zjlrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=d7a28+Bu; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8CF2A207D8;
	Mon, 23 Mar 2026 09:36:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ho-5YY1zBBFg; Mon, 23 Mar 2026 09:36:18 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 02072205DD;
	Mon, 23 Mar 2026 09:36:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 02072205DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254978;
	bh=SKPxM7QKHJjpRvm1SKzuDPn7KKu1tenFhaqsWJcXvAY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=d7a28+BuTNSPgdc3gz4GAo3vsWQFxLL8duaqKHJ3MhbuXk/w/EfIYqHmvouBeo53k
	 ov26qv/iU45jYOS8bRrfSzX8mwm4qjNapYdm5+2uK15njvSiUO7kMgVY28DBiG4NmK
	 Z/nv/Pnv8d1lDGD5h6ueZpIO8GziS6N3RLcJ4PeJFU78sDMibzqMH2cEggnP3bSLfK
	 l+q4yuHZ2lv8wIOYKf9GkgAl3tifxWsbALUUSA/JS+SwlqzmrwqUojbgrB6ukI9Tge
	 oqHULdfwZInlOyaUauqGvi/lkcpg/8v87V7UoG4XjaXltTNxq3NC0MwsvFQijrnNcc
	 vZRCefw7Rv5NQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:36:16 +0100
Received: (nullmailer pid 2741839 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 14/20] xfrm: policy: silence sparse warning in xfrm_policy_unregister_afinfo
Date: Mon, 23 Mar 2026 09:33:55 +0100
Message-ID: <20260323083440.2741292-15-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323083440.2741292-1-steffen.klassert@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270425-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:email,secunet.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 95D992EE585
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sabrina Dubroca <sd@queasysnail.net>

xfrm_policy_afinfo is __rcu, use rcu_access_pointer to silence:

net/xfrm/xfrm_policy.c:4152:43: error: incompatible types in comparison expression (different address spaces):
net/xfrm/xfrm_policy.c:4152:43:    struct xfrm_policy_afinfo const [noderef] __rcu *
net/xfrm/xfrm_policy.c:4152:43:    struct xfrm_policy_afinfo const *

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 49de5a6f4b85..66ac93e65264 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4156,7 +4156,7 @@ void xfrm_policy_unregister_afinfo(const struct xfrm_policy_afinfo *afinfo)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(xfrm_policy_afinfo); i++) {
-		if (xfrm_policy_afinfo[i] != afinfo)
+		if (rcu_access_pointer(xfrm_policy_afinfo[i]) != afinfo)
 			continue;
 		RCU_INIT_POINTER(xfrm_policy_afinfo[i], NULL);
 		break;
-- 
2.43.0


