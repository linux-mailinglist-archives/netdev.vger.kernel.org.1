Return-Path: <netdev+bounces-271691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Df4JH0hxGmZwgQAu9opvQ
	(envelope-from <netdev+bounces-271691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:55:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE32D32A255
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEFDF3030EAA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6AD3FBEB0;
	Wed, 25 Mar 2026 17:54:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAAF3EB7E3;
	Wed, 25 Mar 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461290; cv=none; b=Z4Ouso68pYBReGFComEa5TJwksxh09gl+4rJnyryCGSyjJ1k8gO19Tq86YtCm02AzSpTXptcTd9vibCI9di6WWIAqsLXHZDwTgGM0tWxkUhaJIa200pIlTMgO6zWzlbDMGvWtSdqeCpu33O+0z+WCm1NySq0Rt5fuQE58vA1nOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461290; c=relaxed/simple;
	bh=mMKmSEVB4KJWsFl2mjqcbipnQ1wms5iprOUdb4T6vz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3/AqhU0VhimmbVf61wb1F0Bitj8u1XN7CkVs4nKdBITTl7pxfXnuzDCwtQShA5sitI+t+03eX6heHsFrHcJnZTrU6NMu1l1mw1Kr4vSVAirkAy0LTLGvBUCjYqcSQHOZOaHWAH5wk4lssZtfxFRBjOQJHVmsd1HhkRWYRMTQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w5SRI-000000002aa-21xv;
	Wed, 25 Mar 2026 17:54:44 +0000
Date: Wed, 25 Mar 2026 17:54:41 +0000
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
Subject: [PATCH net-next v7 2/4] net: dsa: add bridge member iteration macro
Message-ID: <aad4641444dc07284447fb0019143461896bea86.1774459500.git.daniel@makrotopia.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-271691-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:email,makrotopia.org:mid]
X-Rspamd-Queue-Id: CE32D32A255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Drivers that offload bridges need to iterate over the ports that are
members of a given bridge, for example to rebuild per-port forwarding
bitmaps when membership changes. Currently drivers typically open-code
this by combining dsa_switch_for_each_user_port() with a
dsa_port_offloads_bridge_dev() check, or cache bridge membership
within the driver.

Add dsa_switch_for_each_bridge_member() macro to express this pattern
directly, and use it for the existing dsa_bridge_ports() inline
helper.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v7: reuse existing helper
v6: new patch

 include/net/dsa.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index e93b4feaca96..8b6d34e8a6f0 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -831,15 +831,18 @@ dsa_tree_offloads_bridge_dev(struct dsa_switch_tree *dst,
 	return false;
 }
 
+#define dsa_switch_for_each_bridge_member(_dp, _ds, _bdev) \
+	dsa_switch_for_each_user_port(_dp, _ds) \
+		if (dsa_port_offloads_bridge_dev(_dp, _bdev))
+
 static inline u32
 dsa_bridge_ports(struct dsa_switch *ds, const struct net_device *bdev)
 {
 	struct dsa_port *dp;
 	u32 mask = 0;
 
-	dsa_switch_for_each_user_port(dp, ds)
-		if (dsa_port_offloads_bridge_dev(dp, bdev))
-			mask |= BIT(dp->index);
+	dsa_switch_for_each_bridge_member(dp, ds, bdev)
+		mask |= BIT(dp->index);
 
 	return mask;
 }
-- 
2.53.0

