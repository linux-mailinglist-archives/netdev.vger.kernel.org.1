Return-Path: <netdev+bounces-189125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A32FAB07F6
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 04:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB273BEF4D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 02:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3E32746C;
	Fri,  9 May 2025 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvvJlpxq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0418C06;
	Fri,  9 May 2025 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746758207; cv=none; b=QjBn85c9WXZEjt0SmmMAFTSZLiB/no0JhwmeeXjvvfsVfb/+H441DTL0YI+aNt3Won41v/QC11Yv7s0Qixkj7DhKRw8DWPzpFMBqJvutQlEdOCC/ZesfjTdJsAWKlg+adXBKh3CxXRmGGxcqFREtgNjK/turHWXRPHDLi1gumrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746758207; c=relaxed/simple;
	bh=l75Y3NtrdG3Cw2HisiT+bPBN/Nlscp0Wzg7HDftEB94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHNewJQsrP86uJ6fJ0BlqAEHq2+M3Rn1BzoYsOycKYiebKEMpDzd0mnWi2ccNbODWZ1UmG5ovd6fgNq4M99KR2f35WNGrV0dYPvoyIeXMleSrwZxaEyIFcTFdLDQMjwFCRv4IbOGaENyJRszZaoRu977EAuMGgYpdbyQq0cmpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvvJlpxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAA9C4CEE7;
	Fri,  9 May 2025 02:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746758206;
	bh=l75Y3NtrdG3Cw2HisiT+bPBN/Nlscp0Wzg7HDftEB94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KvvJlpxqxbts1eUquwwOvHovfZc3oaMSQ9K2xr3e/fxOxQbDCH5C1BxIhPBPW9udP
	 33lHThrlLl7SzB5gDog/tQvYUfo+Cmsb4ynwH9+yPKpSR7fGnfkOO8N6aAyiA74tAN
	 TgaJftcBuxlSWlmx8Z3IvoDq1SNzYUHza84lrpOT6eRAo6fZzLtAdsPsf0cV5Zo+ss
	 OFJjabL9OJ7I9hk8q4Dh7jjaT2EEpvUSaOOEUp1ZJNdHbAydm5bdWZB+AZr9YMCB/V
	 wId1ZdsiTGPWIlvCJqa63fqjM3DPrDNk2rkuG4gTlmJ/u8tKNTtdw6n17BKoa1hvbk
	 WBefqNHmVmlRg==
Date: Thu, 8 May 2025 19:36:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Xing <kernelxing@tencent.com>, Richard Cochran
 <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2] net: Add support for providing the PTP
 hardware source in tsinfo
Message-ID: <20250508193645.78e1e4d9@kernel.org>
In-Reply-To: <20250506-feature_ptp_source-v2-1-dec1c3181a7e@bootlin.com>
References: <20250506-feature_ptp_source-v2-1-dec1c3181a7e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 May 2025 14:18:45 +0200 Kory Maincent wrote:
> +  -
> +    name: ts-hwtstamp-source
> +    enum-name: hwtstamp-source
> +    header: linux/ethtool.h
> +    type: enum
> +    name-prefix: hwtstamp-source
> +    entries: [ netdev, phylib ]

You're missing value: 1, you should let YNL generate this to avoid
the discrepancies.

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 20c6b2bf5def..3e2f470fb213 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -99,12 +99,21 @@ uapi-header: linux/ethtool_netlink_generated.h
     type: enum
     entries: [ unknown, disabled, enabled ]
   -
-    name: ts-hwtstamp-source
-    enum-name: hwtstamp-source
-    header: linux/ethtool.h
+    name: hwtstamp-source
+    name-prefix: hwtstamp-source-
     type: enum
-    name-prefix: hwtstamp-source
-    entries: [ netdev, phylib ]
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
@@ -906,7 +915,7 @@ uapi-header: linux/ethtool_netlink_generated.h
       -
         name: hwtstamp-source
         type: u32
-        enum: ts-hwtstamp-source
+        enum: hwtstamp-source
       -
         name: hwtstamp-phyindex
         type: u32
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 1d886682b4b5..84833cca29fe 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1730,18 +1730,6 @@ struct ethtool_ts_info {
 	__u32	rx_reserved[3];
 };
 
-/**
- * enum hwtstamp_source - Source of the hardware timestamp
- * @HWTSTAMP_SOURCE_NETDEV: Hardware timestamp comes from a MAC or a device
- *			    which has MAC and PHY integrated
- * @HWTSTAMP_SOURCE_PHYLIB: Hardware timestamp comes from one PHY device
- *			    of the network topology
- */
-enum hwtstamp_source {
-	HWTSTAMP_SOURCE_NETDEV = 1,
-	HWTSTAMP_SOURCE_PHYLIB,
-};
-
 /*
  * %ETHTOOL_SFEATURES changes features present in features[].valid to the
  * values of corresponding bits in features[].requested. Bits in .requested
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 7cbcf44d0a32..6181211bb3f5 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -37,6 +37,18 @@ enum ethtool_tcp_data_split {
 	ETHTOOL_TCP_DATA_SPLIT_ENABLED,
 };
 
+/**
+ * enum ethtool_hwtstamp_source
+ * @HWTSTAMP_SOURCE_NETDEV: Hardware timestamp comes from a MAC or a device
+ *   which has MAC and PHY integrated
+ * @HWTSTAMP_SOURCE_PHYLIB: Hardware timestamp comes from one PHY device of the
+ *   network topology
+ */
+enum ethtool_hwtstamp_source {
+	HWTSTAMP_SOURCE_NETDEV = 1,
+	HWTSTAMP_SOURCE_PHYLIB,
+};
+
 enum {
 	ETHTOOL_A_HEADER_UNSPEC,
 	ETHTOOL_A_HEADER_DEV_INDEX,

