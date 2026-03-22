Return-Path: <netdev+bounces-270280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEynBPA1v2kBzAMAu9opvQ
	(envelope-from <netdev+bounces-270280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:21:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8E2E7BC8
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CBA830134B0
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 00:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF7F1A9F82;
	Sun, 22 Mar 2026 00:19:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D5B17BCA;
	Sun, 22 Mar 2026 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774138754; cv=none; b=dQCbR1Ra6j1aiv1kyLqbXCtUalG9nx7o8CY6dTYNy5MmxGgf7kKbqEJjbuUPqWDYiHQ65b84CQD/yG3XOxftlz9QnZG7xl6RFRcAyTYVNK7Lq59hrP+s/RPIRjwiMIoNBh1PSqgDIEcE60wujAjWPoI8nXKnKAIk4pDJMlRk4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774138754; c=relaxed/simple;
	bh=aB1XbynjqyOuURjInF/0+KoUdscONSKLPA/jyaKavQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qytx3lXco/90Ar1DfmPDzz3ZPXOdzSAQuQEjiJbRtjED9QSvCQP2k1q0LpTUuik1NZNuj1QpPM7n0zyFM1QIQ+8NeB/5mmiXzYyOUTT33vgmlrl6eSoeQaI+SQHNO/JI7qwNQEsQrOe7puAy2T1KuTL7qlh3wi7Wz19zlCyVxMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w46X7-000000001Ms-1I8a;
	Sun, 22 Mar 2026 00:19:09 +0000
Date: Sun, 22 Mar 2026 00:19:06 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v6 2/4] net: dsa: add bridge member iteration macro
 and port mask helper
Message-ID: <ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel@makrotopia.org>
References: <cover.1774136876.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774136876.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	TAGGED_FROM(0.00)[bounces-270280-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[19];
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
X-Rspamd-Queue-Id: 64C8E2E7BC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Drivers that offload bridges need to iterate over the ports that are
members of a given bridge, for example to rebuild per-port forwarding
bitmaps when membership changes. Currently each driver must open-code
this by combining dsa_switch_for_each_user_port() with a
dsa_port_offloads_bridge() check, or cache bridge membership within
the driver.

Add dsa_bridge_for_each_member() to express this pattern directly, and
a dsa_bridge_ports() helper that returns a bitmask of member ports,
matching the existing dsa_user_ports() and dsa_cpu_ports() helpers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v6: new patch

 include/net/dsa.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 1c6f6c3b88e86..4f43d518f3de3 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -838,6 +838,22 @@ static inline bool dsa_port_tree_same(const struct dsa_port *a,
 	return a->ds->dst == b->ds->dst;
 }
 
+#define dsa_bridge_for_each_member(_dp, _ds, _bridge) \
+	dsa_switch_for_each_user_port((_dp), (_ds)) \
+		if (dsa_port_offloads_bridge((_dp), (_bridge)))
+
+static inline u32 dsa_bridge_ports(struct dsa_switch *ds,
+				   const struct dsa_bridge *bridge)
+{
+	struct dsa_port *dp;
+	u32 mask = 0;
+
+	dsa_bridge_for_each_member(dp, ds, bridge)
+		mask |= BIT(dp->index);
+
+	return mask;
+}
+
 typedef int dsa_fdb_dump_cb_t(const unsigned char *addr, u16 vid,
 			      bool is_static, void *data);
 struct dsa_switch_ops {
-- 
2.53.0

