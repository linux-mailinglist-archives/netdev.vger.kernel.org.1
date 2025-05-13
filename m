Return-Path: <netdev+bounces-190123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C764AB53FF
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1BB178FF9
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977FD28D8E5;
	Tue, 13 May 2025 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a7zNWt2u"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084B628D8D6;
	Tue, 13 May 2025 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136439; cv=none; b=dPi5IY1vXHjyhi+au1dIW3X+9jDWvsy88iekOYGj8CODR2ju8BAt828kkUMOdydAYOH2MwC4igkWQg4Xr+KgjFAt6paWb91vpKdQJG4TbakOv+rS7XChwpX1KVmllas4cBmSXMgvGMkHh7WAQ1b9YYVIVdNcNT5DM1vXqkyCP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136439; c=relaxed/simple;
	bh=V7a/PzOmjn0F1bRnmlp8qgxSqkLNuoCpToPbb82W0ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LFjGcoZTXev712UzOfLPxhXiGpudCpmUs26sWu/o9CjtiAss1b/ApUGufLrevz/8cFWYjEyzv9za2qONpDrmlXiLHUahxcdkmXvTc6Ek176YJie7P36jNIV6pBK6hlncyZ/U/2tKrektycOyIzWfO7+UQPP2HQuDYOVNeLEuaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a7zNWt2u; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA43943AD4;
	Tue, 13 May 2025 11:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747136435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TGGvlGblmCJVXjBO0yQXRi3U7VXpElH4T00qOtEqcZA=;
	b=a7zNWt2uthvfWjUVDEdqvNXm9Q5p66cBuO7GN+aAnxhLV/Ch05TYsfAOnukYP6UNjxjroT
	uFKdL+4pQaCY0VnQGKOqkQH1cOn1taYarBOIzrCz6/VpD+brB8zyFnAb0SvWZHhtC5I8lD
	SFaxwwXZL369mimet+KhoO4y2Sr2FPEwKVilHkPHcyjiF47NlS+c6gOCXf3OYitL5ZjU8s
	AELqTa/WNcoEb68CTipwYArli7t/dgGBJ9on4WijAC/NZY9LMccbBOI13NfsixjxZDWMmx
	e4XG71ZgAi54oOWWSDeT06CC+mdhMv32mbs/UI+omyHOimS3NLG2MTomcQlYMA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 13 May 2025 13:40:22 +0200
Subject: [PATCH net-next v3] net: Add support for providing the PTP
 hardware source in tsinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250513-feature_ptp_source-v3-1-84888cc50b32@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAKUvI2gC/23N3QrCIBwF8FcJrzOmc23rqveIGH78bULpUCeLs
 XdP7CKCXR4O53dWFMAbCOhyWJGHZIJxNof6eEBy5PYB2KicEa1oUzHSYQ08zh6GKU5DcLOXgJV
 mvO9kz0jdozycPGizFPSGLERsYYnonpvRhOj8u7wlUvovTJs9OBFMsKRKQyuo6AS7Cufi09iTd
 K8CJvpDmuq8i9CMKJBE1qQjvIV/ZNu2DyR495MFAQAA
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthekredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefgfeegveefvefgfeegueeluefgheegfeejkedtudduvdfhteekvdfgfeeluefgueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudgrmeeiudemjehfkegtmehfjeekrgemfhelvghfmeekkegttdemieefsghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdurgemiedumeejfhektgemfhejkegrmehflegvfhemkeektgdtmeeifegsfhdphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrv
 gguhhgrthdrtghomhdprhgtphhtthhopehrihgthhgrrhgutghotghhrhgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepkhgvrhhnvghlgihinhhgsehtvghntggvnhhtrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

Multi-PTP source support within a network topology has been merged,
but the hardware timestamp source is not yet exposed to users.
Currently, users only see the PTP index, which does not indicate
whether the timestamp comes from a PHY or a MAC.

Add support for reporting the hwtstamp source using a
hwtstamp-source field, alongside hwtstamp-phyindex, to describe
the origin of the hardware timestamp.

Remove HWTSTAMP_SOURCE_UNSPEC enum value as it is not used at all.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Change in v3:
- Move hwtstamp_source enum from uapi/linux/ethtool.h to ethtool.yaml specs.
- Add few include of ethtool_netlink_generated.h header.
- Link to v2: https://lore.kernel.org/r/20250506-feature_ptp_source-v2-1-dec1c3181a7e@bootlin.com

Change in v2:
- Move hwtstamp_source enum from uapi/linux/net_tstamp.h to
  uapi/linux/ethtool.h
- Remove HWTSTAMP_SOURCE_UNSPEC enum value.
- Made a few change in net/ethtool/common.c to report the source only
  if get_ts_info does not return an error and if there is a hardware
  timestamp with a phc index.
- Link to v1: https://lore.kernel.org/r/20250425-feature_ptp_source-v1-1-c2dfe7b2b8b4@bootlin.com
---
 Documentation/netlink/specs/ethtool.yaml       | 26 +++++++++++++++++++++++
 include/linux/ethtool.h                        |  5 +++++
 include/linux/net_tstamp.h                     |  7 +------
 include/uapi/linux/ethtool_netlink_generated.h | 14 +++++++++++++
 net/ethtool/common.c                           | 29 +++++++++++++++++++++-----
 net/ethtool/tsinfo.c                           | 23 ++++++++++++++++++++
 6 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index c650cd3dcb80bc93c5039dc8ba2c5c18793ff987..881e483f32e18f77c009f278bd2d2029c30af352 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -98,6 +98,23 @@ definitions:
     name: tcp-data-split
     type: enum
     entries: [ unknown, disabled, enabled ]
+  -
+    name: hwtstamp-source
+    enum-name: hwtstamp-source
+    name-prefix: hwtstamp-source-
+    type: enum
+    entries:
+      -
+        name: netdev
+        doc: |
+          Hardware timestamp comes from a MAC or a device
+          which has MAC and PHY integrated
+        value: 1
+      -
+        name: phylib
+        doc: |
+          Hardware timestamp comes from one PHY device
+          of the network topology
 
 attribute-sets:
   -
@@ -896,6 +913,13 @@ attribute-sets:
         name: hwtstamp-provider
         type: nest
         nested-attributes: ts-hwtstamp-provider
+      -
+        name: hwtstamp-source
+        type: u32
+        enum: hwtstamp-source
+      -
+        name: hwtstamp-phyindex
+        type: u32
   -
     name: cable-result
     attr-cnt-name: __ethtool-a-cable-result-cnt
@@ -1981,6 +2005,8 @@ operations:
             - phc-index
             - stats
             - hwtstamp-provider
+            - hwtstamp-source
+            - hwtstamp-phyindex
       dump: *tsinfo-get-op
     -
       name: cable-test-act
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 117718c2481439d09f60cd596012dfa0feef3ca8..5e0dd333ad1fb39a74dc4317d6886b4224ea661c 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -19,6 +19,7 @@
 #include <linux/netlink.h>
 #include <linux/timer_types.h>
 #include <uapi/linux/ethtool.h>
+#include <uapi/linux/ethtool_netlink_generated.h>
 #include <uapi/linux/net_tstamp.h>
 
 #define ETHTOOL_MM_MAX_VERIFY_TIME_MS		128
@@ -830,6 +831,8 @@ struct ethtool_rxfh_param {
  * @so_timestamping: bit mask of the sum of the supported SO_TIMESTAMPING flags
  * @phc_index: device index of the associated PHC, or -1 if there is none
  * @phc_qualifier: qualifier of the associated PHC
+ * @phc_source: source device of the associated PHC
+ * @phc_phyindex: index of PHY device source of the associated PHC
  * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration values
  * @rx_filters: bit mask of the supported hwtstamp_rx_filters enumeration values
  */
@@ -838,6 +841,8 @@ struct kernel_ethtool_ts_info {
 	u32 so_timestamping;
 	int phc_index;
 	enum hwtstamp_provider_qualifier phc_qualifier;
+	enum hwtstamp_source phc_source;
+	int phc_phyindex;
 	enum hwtstamp_tx_types tx_types;
 	enum hwtstamp_rx_filters rx_filters;
 };
diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
index ff0758e88ea1008efe533cde003b12719bf4fcd3..f4936d9c2b3c281270c90a395ea5b9d088b221a3 100644
--- a/include/linux/net_tstamp.h
+++ b/include/linux/net_tstamp.h
@@ -4,6 +4,7 @@
 #define _LINUX_NET_TIMESTAMPING_H_
 
 #include <uapi/linux/net_tstamp.h>
+#include <uapi/linux/ethtool_netlink_generated.h>
 
 #define SOF_TIMESTAMPING_SOFTWARE_MASK	(SOF_TIMESTAMPING_RX_SOFTWARE | \
 					 SOF_TIMESTAMPING_TX_SOFTWARE | \
@@ -13,12 +14,6 @@
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
index 30c8dad6214e9a882f1707e4835e9efc73c3f92e..95f2cffc042f22a893ba2efd19aa69136c538e55 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -37,6 +37,18 @@ enum ethtool_tcp_data_split {
 	ETHTOOL_TCP_DATA_SPLIT_ENABLED,
 };
 
+/**
+ * enum hwtstamp_source
+ * @HWTSTAMP_SOURCE_NETDEV: Hardware timestamp comes from a MAC or a device
+ *   which has MAC and PHY integrated
+ * @HWTSTAMP_SOURCE_PHYLIB: Hardware timestamp comes from one PHY device of the
+ *   network topology
+ */
+enum hwtstamp_source {
+	HWTSTAMP_SOURCE_NETDEV = 1,
+	HWTSTAMP_SOURCE_PHYLIB,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,
@@ -401,6 +413,8 @@ enum {
 	ETHTOOL_A_TSINFO_PHC_INDEX,
 	ETHTOOL_A_TSINFO_STATS,
 	ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER,
+	ETHTOOL_A_TSINFO_HWTSTAMP_SOURCE,
+	ETHTOOL_A_TSINFO_HWTSTAMP_PHYINDEX,
 
 	__ETHTOOL_A_TSINFO_CNT,
 	ETHTOOL_A_TSINFO_MAX = (__ETHTOOL_A_TSINFO_CNT - 1)
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 49bea6b45bd5c1951ff1a52a9f30791040044d10..eb253e0fd61b5d84c0d5d6c24e19e665b6182f2f 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -921,9 +921,18 @@ int ethtool_get_ts_info_by_phc(struct net_device *dev,
 
 		phy = ethtool_phy_get_ts_info_by_phc(dev, info, hwprov_desc);
 		if (IS_ERR(phy))
-			err = PTR_ERR(phy);
-		else
-			err = 0;
+			return PTR_ERR(phy);
+
+		/* Report the phc source only if we have a real
+		 * phc source with an index.
+		 */
+		if (info->phc_index >= 0) {
+			info->phc_source = HWTSTAMP_SOURCE_PHYLIB;
+			info->phc_phyindex = phy->phyindex;
+		}
+		err = 0;
+	} else if (!err && info->phc_index >= 0) {
+		info->phc_source = HWTSTAMP_SOURCE_NETDEV;
 	}
 
 	info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
@@ -947,10 +956,20 @@ int __ethtool_get_ts_info(struct net_device *dev,
 
 		ethtool_init_tsinfo(info);
 		if (phy_is_default_hwtstamp(phydev) &&
-		    phy_has_tsinfo(phydev))
+		    phy_has_tsinfo(phydev)) {
 			err = phy_ts_info(phydev, info);
-		else if (ops->get_ts_info)
+			/* Report the phc source only if we have a real
+			 * phc source with an index.
+			 */
+			if (!err && info->phc_index >= 0) {
+				info->phc_source = HWTSTAMP_SOURCE_PHYLIB;
+				info->phc_phyindex = phydev->phyindex;
+			}
+		} else if (ops->get_ts_info) {
 			err = ops->get_ts_info(dev, info);
+			if (!err && info->phc_index >= 0)
+				info->phc_source = HWTSTAMP_SOURCE_NETDEV;
+		}
 
 		info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
 					 SOF_TIMESTAMPING_SOFTWARE;
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 8130b406ef107f7311cba15c5aafba3ba82bb5a3..8c654caa6805a5727f479d5438d7a4a2786b8d52 100644
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
@@ -346,6 +362,11 @@ static int ethnl_tsinfo_dump_one_phydev(struct sk_buff *skb,
 	if (ret < 0)
 		goto err;
 
+	if (reply_data->ts_info.phc_index >= 0) {
+		reply_data->ts_info.phc_source = HWTSTAMP_SOURCE_PHYLIB;
+		reply_data->ts_info.phc_phyindex = phydev->phyindex;
+	}
+
 	ret = ethnl_tsinfo_end_dump(skb, dev, req_info, reply_data, ehdr);
 	if (ret < 0)
 		goto err;
@@ -389,6 +410,8 @@ static int ethnl_tsinfo_dump_one_netdev(struct sk_buff *skb,
 		if (ret < 0)
 			goto err;
 
+		if (reply_data->ts_info.phc_index >= 0)
+			reply_data->ts_info.phc_source = HWTSTAMP_SOURCE_NETDEV;
 		ret = ethnl_tsinfo_end_dump(skb, dev, req_info, reply_data,
 					    ehdr);
 		if (ret < 0)

---
base-commit: 9f607dc39b6658ba8ea647bd99725e68c66071b7
change-id: 20250418-feature_ptp_source-df4a98c94139

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


