Return-Path: <netdev+bounces-186077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A18A9CFD8
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F057B9380
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B95620F077;
	Fri, 25 Apr 2025 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MIO+YQU/"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51720E704;
	Fri, 25 Apr 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745602979; cv=none; b=onpbJwrFzaDPBTVRw4NG8WX8GcEKNK7PTOwL57UiN64JXVPV2w6O3ysUNL8hkjb9dBSN2aIOLvMfjr8EJdtsQ5iEDx+R0FGIPlArz6JcXOehNeNeJRFCX3JSzdwsGUVF3zJ2QmUNbRPZuFHPok5NR9e+T+3TGSk8DhqMbuuloCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745602979; c=relaxed/simple;
	bh=KWzr3B/M4fL8TPJUQg++BxP69jciMEs/SiCBs8Hjz4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rZZq/nEkQz4XGP4w5+C8miLelyodTCv0RlCNwC/thQfXbMujLDxdDmtVkSg2jEEE1kdg/pOw8tdaUtP9nxmPW+wurtH3fybVSVeP8x2nsIjrqfk4UuUbtVTWCslzFwGznG96taFnQycVjdJ0hxPtuL+va/Qdf479fwKsSvsEiGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MIO+YQU/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F057443B51;
	Fri, 25 Apr 2025 17:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745602973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1zkczcD3tLJeD16SvwFF2FmSh3gt7glSKaRe1Fj6Tpk=;
	b=MIO+YQU/4mTE9wVoAlP1sL0iKzqRf6gs+6TzIdkWPGfrZr8btK5a7nqDLH+JUETohxhkBy
	f07kE8Yts9myNbXzp6PKWDfKg6lCAVuPXUu50HIWIoE2cgloS0Hnwt9ZS4oc9laUZe+yLR
	OkYqc4nhAV+RJYQVPT/+mSJza8MZeMiDvrfMrZljvzkr4cvW2PS5NGfEmH1y8trrivBPzh
	4Bhcih4+1KiOS5LyDKWlRJktZFvXjhaq++D7FWUKZBLfBq/DsUv7uEsHNuVxgrguC1awjE
	3daduaHMAVbicN0uGkhP+LLvecfdTPX/o9DYh8PqZWUc2as9OmPe5PLT9Z7awg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 25 Apr 2025 19:42:43 +0200
Subject: [PATCH net-next] net: Add support for providing the PTP hardware
 source in tsinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250425-feature_ptp_source-v1-1-c2dfe7b2b8b4@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAJLJC2gC/x3MwQqEIBRG4VeJu07IciDnVYYIsd+6G5OrRRC9e
 zLLb3HOTRnCyPRtbhKcnHmPFbptyG8urlC8VFPf9Z/O6FEFuHII5lTSnPdDPNQSjLOjt0YPlmq
 YBIGv//RHEUVFXIWm53kBqfeztW4AAAA=
X-Change-ID: 20250418-feature_ptp_source-df4a98c94139
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kernelxing@tencent.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthekredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelueejlefgleekvefffedviedvhefggedvvdehjeehvdfhvdeiudduuedtiefhteenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemkeehkeejmeejuddttdemfeelfegumegsgeeileemtgeksggtmegrjegvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmeefleefugemsgegieelmegtkegstgemrgejvgelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhorhihrdhmrghin
 hgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlgihinhhgsehtvghntggvnhhtrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Multi-PTP source support within a network topology has been merged,
but the hardware timestamp source is not yet exposed to users.
Currently, users only see the PTP index, which does not indicate
whether the timestamp comes from a PHY or a MAC.

Add support for reporting the hwtstamp source using a
hwtstamp-source field, alongside hwtstamp-phyindex, to describe
the origin of the hardware timestamp.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Not sure moving the hwtstamp_source enum to uapi/linux/net_tstamp.h and
adding this header to ynl/Makefile.deps is the best choice. Maybe it is
better to move the enum directly to ethtool.h header.
---
 Documentation/netlink/specs/ethtool.yaml       | 16 ++++++++++++++++
 include/linux/ethtool.h                        |  4 ++++
 include/linux/net_tstamp.h                     |  6 ------
 include/uapi/linux/ethtool_netlink_generated.h |  2 ++
 include/uapi/linux/net_tstamp.h                | 13 +++++++++++++
 net/ethtool/common.c                           | 22 +++++++++++++++++-----
 net/ethtool/tsinfo.c                           | 20 ++++++++++++++++++++
 tools/net/ynl/Makefile.deps                    |  3 ++-
 8 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index c650cd3dcb80bc93c5039dc8ba2c5c18793ff987..4bb44c93e80a83b9520ea297c08a94616f7266aa 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -98,6 +98,13 @@ definitions:
     name: tcp-data-split
     type: enum
     entries: [ unknown, disabled, enabled ]
+  -
+    name: ts-hwtstamp-source
+    enum-name: hwtstamp-source
+    header: linux/net_tstamp.h
+    type: enum
+    name-prefix: hwtstamp-source
+    entries: [ unspec, netdev, phylib ]
 
 attribute-sets:
   -
@@ -896,6 +903,13 @@ attribute-sets:
         name: hwtstamp-provider
         type: nest
         nested-attributes: ts-hwtstamp-provider
+      -
+        name: hwtstamp-source
+        type: u32
+        enum: ts-hwtstamp-source
+      -
+        name: hwtstamp-phyindex
+        type: u32
   -
     name: cable-result
     attr-cnt-name: __ethtool-a-cable-result-cnt
@@ -1981,6 +1995,8 @@ operations:
             - phc-index
             - stats
             - hwtstamp-provider
+            - hwtstamp-source
+            - hwtstamp-phyindex
       dump: *tsinfo-get-op
     -
       name: cable-test-act
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 117718c2481439d09f60cd596012dfa0feef3ca8..f18fc8269f7066eadd6fa823e0d43b4ae50b8c46 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -830,6 +830,8 @@ struct ethtool_rxfh_param {
  * @so_timestamping: bit mask of the sum of the supported SO_TIMESTAMPING flags
  * @phc_index: device index of the associated PHC, or -1 if there is none
  * @phc_qualifier: qualifier of the associated PHC
+ * @phc_source: source device of the associated PHC
+ * @phc_phyindex: index of PHY device source of the associated PHC
  * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration values
  * @rx_filters: bit mask of the supported hwtstamp_rx_filters enumeration values
  */
@@ -838,6 +840,8 @@ struct kernel_ethtool_ts_info {
 	u32 so_timestamping;
 	int phc_index;
 	enum hwtstamp_provider_qualifier phc_qualifier;
+	enum hwtstamp_source phc_source;
+	int phc_phyindex;
 	enum hwtstamp_tx_types tx_types;
 	enum hwtstamp_rx_filters rx_filters;
 };
diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index ff0758e88ea1008efe533cde003b12719bf4fcd3..1414aed0b6adeae15b56e7a99a7d9eeb43ba0b6c 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -13,12 +13,6 @@
 					 SOF_TIMESTAMPING_TX_HARDWARE | \
 					 SOF_TIMESTAMPING_RAW_HARDWARE)
 
-enum hwtstamp_source {
-	HWTSTAMP_SOURCE_UNSPEC,
-	HWTSTAMP_SOURCE_NETDEV,
-	HWTSTAMP_SOURCE_PHYLIB,
-};
-
 /**
  * struct hwtstamp_provider_desc - hwtstamp provider description
  *
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 30c8dad6214e9a882f1707e4835e9efc73c3f92e..7cbcf44d0a3284490006961d3513c58ccda98038 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -401,6 +401,8 @@ enum {
 	ETHTOOL_A_TSINFO_PHC_INDEX,
 	ETHTOOL_A_TSINFO_STATS,
 	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER,
+	ETHTOOL_A_TSINFO_HWTSTAMP_SOURCE,
+	ETHTOOL_A_TSINFO_HWTSTAMP_PHYINDEX,
 
 	__ETHTOOL_A_TSINFO_CNT,
 	ETHTOOL_A_TSINFO_MAX = (__ETHTOOL_A_TSINFO_CNT - 1)
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index a93e6ea37fb3a69f331b1c90851d4e68cb659a83..bf5fb9f7acf5c03aaa121e0cda3c0b1d83e49f71 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -13,6 +13,19 @@
 #include <linux/types.h>
 #include <linux/socket.h>   /* for SO_TIMESTAMPING */
 
+/**
+ * enum hwtstamp_source - Source of the hardware timestamp
+ * @HWTSTAMP_SOURCE_UNSPEC: Source not specified or unknown
+ * @HWTSTAMP_SOURCE_NETDEV: Hardware timestamp comes from the net device
+ * @HWTSTAMP_SOURCE_PHYLIB: Hardware timestamp comes from one of the PHY
+ *			    devices of the network topology
+ */
+enum hwtstamp_source {
+	HWTSTAMP_SOURCE_UNSPEC,
+	HWTSTAMP_SOURCE_NETDEV,
+	HWTSTAMP_SOURCE_PHYLIB,
+};
+
 /*
  * Possible type of hwtstamp provider. Mainly "precise" the default one
  * is for IEEE 1588 quality and "approx" is for NICs DMA point.
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 49bea6b45bd5c1951ff1a52a9f30791040044d10..43e62885b46b5c0abc484d2661f7cdf8a3e23169 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -920,12 +920,20 @@ int ethtool_get_ts_info_by_phc(struct net_device *dev,
 		struct phy_device *phy;
 
 		phy = ethtool_phy_get_ts_info_by_phc(dev, info, hwprov_desc);
-		if (IS_ERR(phy))
+		if (IS_ERR(phy)) {
 			err = PTR_ERR(phy);
-		else
-			err = 0;
+			goto out;
+		}
+
+		info->phc_source = HWTSTAMP_SOURCE_PHYLIB;
+		info->phc_phyindex = phy->phyindex;
+		err = 0;
+		goto out;
+	} else {
+		info->phc_source = HWTSTAMP_SOURCE_NETDEV;
 	}
 
+out:
 	info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
 				 SOF_TIMESTAMPING_SOFTWARE;
 
@@ -947,10 +955,14 @@ int __ethtool_get_ts_info(struct net_device *dev,
 
 		ethtool_init_tsinfo(info);
 		if (phy_is_default_hwtstamp(phydev) &&
-		    phy_has_tsinfo(phydev))
+		    phy_has_tsinfo(phydev)) {
 			err = phy_ts_info(phydev, info);
-		else if (ops->get_ts_info)
+			info->phc_source = HWTSTAMP_SOURCE_PHYLIB;
+			info->phc_phyindex = phydev->phyindex;
+		} else if (ops->get_ts_info) {
 			err = ops->get_ts_info(dev, info);
+			info->phc_source = HWTSTAMP_SOURCE_NETDEV;
+		}
 
 		info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
 					 SOF_TIMESTAMPING_SOFTWARE;
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 8130b406ef107f7311cba15c5aafba3ba82bb5a3..62e82f43dba998abd840ea15505084e3127b4520 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -160,6 +160,12 @@ static int tsinfo_reply_size(const struct ethnl_req_info *req_base,
 		/* _TSINFO_HWTSTAMP_PROVIDER */
 		len += nla_total_size(0) + 2 * nla_total_size(sizeof(u32));
 	}
+	if (ts_info->phc_source) {
+		len += nla_total_size(sizeof(u32));	/* _TSINFO_HWTSTAMP_SOURCE */
+		if (ts_info->phc_phyindex)
+			/* _TSINFO_HWTSTAMP_PHYINDEX */
+			len += nla_total_size(sizeof(u32));
+	}
 	if (req_base->flags & ETHTOOL_FLAG_STATS)
 		len += nla_total_size(0) + /* _TSINFO_STATS */
 		       nla_total_size_64bit(sizeof(u64)) * ETHTOOL_TS_STAT_CNT;
@@ -259,6 +265,16 @@ static int tsinfo_fill_reply(struct sk_buff *skb,
 
 		nla_nest_end(skb, nest);
 	}
+	if (ts_info->phc_source) {
+		if (nla_put_u32(skb, ETHTOOL_A_TSINFO_HWTSTAMP_SOURCE,
+				ts_info->phc_source))
+			return -EMSGSIZE;
+
+		if (ts_info->phc_phyindex &&
+		    nla_put_u32(skb, ETHTOOL_A_TSINFO_HWTSTAMP_PHYINDEX,
+				ts_info->phc_phyindex))
+			return -EMSGSIZE;
+	}
 	if (req_base->flags & ETHTOOL_FLAG_STATS &&
 	    tsinfo_put_stats(skb, &data->stats))
 		return -EMSGSIZE;
@@ -346,6 +362,9 @@ static int ethnl_tsinfo_dump_one_phydev(struct sk_buff *skb,
 	if (ret < 0)
 		goto err;
 
+	reply_data->ts_info.phc_source = HWTSTAMP_SOURCE_PHYLIB;
+	reply_data->ts_info.phc_phyindex = phydev->phyindex;
+
 	ret = ethnl_tsinfo_end_dump(skb, dev, req_info, reply_data, ehdr);
 	if (ret < 0)
 		goto err;
@@ -389,6 +408,7 @@ static int ethnl_tsinfo_dump_one_netdev(struct sk_buff *skb,
 		if (ret < 0)
 			goto err;
 
+		reply_data->ts_info.phc_source = HWTSTAMP_SOURCE_NETDEV;
 		ret = ethnl_tsinfo_end_dump(skb, dev, req_info, reply_data,
 					    ehdr);
 		if (ret < 0)
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 8b7bf673b686f17db06a3798d23d2350f7cf76c1..6c03b477f672eab80e2c71452c982b9561cb7c4a 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -18,7 +18,8 @@ CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
 CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
 CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_H,ethtool.h) \
 	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h) \
-	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_GENERATED_H,ethtool_netlink_generated.h)
+	$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_GENERATED_H,ethtool_netlink_generated.h) \
+	$(call get_hdr_inc,_NET_TIMESTAMPING_H,net_tstamp.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
 CFLAGS_lockd_netlink:=$(call get_hdr_inc,_LINUX_LOCKD_NETLINK_H,lockd_netlink.h)
 CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)

---
base-commit: 3a726f8feac35d9b9ee11cf9737d62fe2410d539
change-id: 20250418-feature_ptp_source-df4a98c94139

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


