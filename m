Return-Path: <netdev+bounces-271690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCCyD4whxGmZwgQAu9opvQ
	(envelope-from <netdev+bounces-271690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:55:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 451A232A27D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14BF2300721D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C815D40B6F5;
	Wed, 25 Mar 2026 17:54:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401223FBEB0;
	Wed, 25 Mar 2026 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461260; cv=none; b=JjWdzcvu1d9JOl3lix+GPnPka4OY+CiHWVuSEK/jCF7a6HIVFbHDULfBsLj9rjESAVGZR+KnjwYpKJcofhIwftcWks/vYKdpzhpaQLq+Z+DGSHR+XGNvvqunlWtwBVnaEJdBG2/rnKZLTkDSb4eL5uqY/DSQtRgY1jJBI2cqgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461260; c=relaxed/simple;
	bh=KrDKZcgPrX2Y19TgNz/cvhKQGbS678Z7lmO0EqHYFNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQXlAfcomhWhDA3fh0Iw7YpoYSKqwMsYBxVJHBnP5lIDEc9df78fiAkJ4HMDhZlbmvQHeO6X9RKAlb+6vHhzE5MBV5Lkh4D1u0h/O9tOzcFAc6/5PpYMVD7h94hl7WgEIat7a3cKbU2scp8cf7AomD/EEMG/SbpYDtr2v5ReHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w5SQo-000000002ZO-2jlo;
	Wed, 25 Mar 2026 17:54:14 +0000
Date: Wed, 25 Mar 2026 17:54:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Yang <mmyangfl@gmail.com>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v7 1/4] net: dsa: move dsa_bridge_ports() helper to
 dsa.h
Message-ID: <de15444c2b5a3e0529f51a435a74e17bfa79738e.1774459500.git.daniel@makrotopia.org>
References: <cover.1774459500.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774459500.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-271690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,makrotopia.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 451A232A27D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The yt921x driver contains a helper to create a bitmap of ports
which are members of a bridge.

Move the helper as static inline function into dsa.h, so other driver
can make use of it as well.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v7: new patch

 drivers/net/dsa/yt921x.c | 13 -------------
 include/net/dsa.h        | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 904613f4694a..5b66109ecc23 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -2154,19 +2154,6 @@ yt921x_bridge_join(struct yt921x_priv *priv, int port, u16 ports_mask)
 	return 0;
 }
 
-static u32
-dsa_bridge_ports(struct dsa_switch *ds, const struct net_device *bdev)
-{
-	struct dsa_port *dp;
-	u32 mask = 0;
-
-	dsa_switch_for_each_user_port(dp, ds)
-		if (dsa_port_offloads_bridge_dev(dp, bdev))
-			mask |= BIT(dp->index);
-
-	return mask;
-}
-
 static int
 yt921x_bridge_flags(struct yt921x_priv *priv, int port,
 		    struct switchdev_brport_flags flags)
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6c17446f3dcc..e93b4feaca96 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -831,6 +831,19 @@ dsa_tree_offloads_bridge_dev(struct dsa_switch_tree *dst,
 	return false;
 }
 
+static inline u32
+dsa_bridge_ports(struct dsa_switch *ds, const struct net_device *bdev)
+{
+	struct dsa_port *dp;
+	u32 mask = 0;
+
+	dsa_switch_for_each_user_port(dp, ds)
+		if (dsa_port_offloads_bridge_dev(dp, bdev))
+			mask |= BIT(dp->index);
+
+	return mask;
+}
+
 static inline bool dsa_port_tree_same(const struct dsa_port *a,
 				      const struct dsa_port *b)
 {
-- 
2.53.0

