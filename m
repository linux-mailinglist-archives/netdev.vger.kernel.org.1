Return-Path: <netdev+bounces-155019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD208A00B09
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4ED93A4284
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656191FA8C0;
	Fri,  3 Jan 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7UGeKcs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435611CCB4B;
	Fri,  3 Jan 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916641; cv=none; b=qG1397/X+oupWBXWUkY/kZqLCdwxIfXuL33Ldyi4SGh+KfZasHqKVPELTiutkQQumqEPPBMhQGwrq1vPcY5El01rasp6cxN70KydtiGdH36ojDUEZ3m+NRE538vCw0fcMcvuL9a/yfY2qf1hMPPh03z0CQKsQ4fGOi9HSbiOFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916641; c=relaxed/simple;
	bh=pD1ulSZCWHUXH2UcLaSHF9kAONDuYEHjcJ/vQNXwcLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMA1O8vRbOdWAg1MazKbMnRM3cAXuxB+HF/fUywWcUqv287XqzPWdKjtoFxAoYmSVCjCeYHZhVT4vduE3o1jmRhOPjNSXIKRIvBOTNnbkHNUwzPzRCRC6+QiAMJZYC7kJwgvfyQdvoIBP/M8cRU89LnYoCquAmwdhJmDPGRCV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7UGeKcs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21636268e43so88679505ad.2;
        Fri, 03 Jan 2025 07:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735916638; x=1736521438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzfA2V84zuxacl6AnAvtutrNr3hbcEFs/i1nlzzkSfo=;
        b=c7UGeKcs/m6MhZZf+EEDM4zNjX7hEb+admbqIdIgUxWvQE5En/CS/ykbHLpXHh6+OZ
         VtzTn22Z+D+v36Rz/ITaZDcOMY98BWR1x2l1FrrWtvbFNOQVZ/FhPuGzyNOOXcrnSsOD
         2/Dtrwe223hAMZr+G/ofOsZH01Z/o65qatWAFd1WpvltCPvnH7My9veaR//D1mPAYPKM
         H9XwqZNJOvlVw15BFHtp+HuCSysHasI7adizJvjQLl3n9oo54aZ72CnKLOYYTXNbfqwW
         Qhq1MpFEUHuraG5p31vKpXP0f/rwqOGuBJxdl9GosafcGb5S5aHoMxp/2uplPdJYrUnx
         HHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916638; x=1736521438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzfA2V84zuxacl6AnAvtutrNr3hbcEFs/i1nlzzkSfo=;
        b=ar9C1J9T0Hj2p0gyUb9G7d+yBvpHn8kCa9XK3VeikC2xQ8V7Zz2J6XU7OqK86BlEYe
         YWZTMI//Jw1ON0XsFKx5geTDz3sDpavlkpV6Zyc1LWNOQAmN4G0LOCTtsaIg5l76jrPM
         EYSWFcBHp42LScF+l7bw7d0DX/SgINVJJD+1tJJQRpO/cihrompMjlgCPTg2Usjd1R3w
         B/zBQmrYYGzF+8N+28/aM5NCSkz6Yk2gFldnorQYHobiyGP5K1uDWuV0r+BADI4XzKXf
         VEp/mWptqshxRN4qC0SZ9a0pE5h3QyCj3pSKLylvKBWBBBwQ0Bn1y0E1wmKjOYwJ0fYG
         JAPg==
X-Forwarded-Encrypted: i=1; AJvYcCWEKS/GohA+WWpwtBlr1+caB5wjbvCTJF09R25BXmf4PSSIS7j8cJ0FTW260Z2oZQwCulx6G/WX@vger.kernel.org, AJvYcCXtDpbBStPxMtp29sMfKU8VMHthEJDEWyRZeJIkKKDsQt3Y5xvjGgI9O0x/A3oZst8jgCf3U9nZBnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJLDEaGmhde9WC/YjsXiO4Khyey7kVMOjgmYYYDF9mg3JgIDPI
	ojxxtqXfum+I5jD8RWVu0+gXSJl/Pk9KRqaHI1maQo8PL5EVYfEk
X-Gm-Gg: ASbGncsJ9HqZ6FkC3ch7+4PNPstW4S/vmK9Mbf8j8cioUXLQxgjioYAdl6ajpsgL26X
	+tfOzJHaq3LxwjyLNQ16BQHmlDxLmL1VHar7MwG1QKqLn2/q3WmY5Dt/tbEFwlyNisNPOHOF9Vg
	Oo8/HtC5EWhMmisMhZsrorOAlb8P89XNv5+4EolH4XDxpOnOwSIBtXINlcC9PqEAZh3yyJXlPkD
	j7MghnXvIrLmMoC80ACr90lTSlqzJXB799IdcKPZ0Baew==
X-Google-Smtp-Source: AGHT+IHLKtMfojgIUEDdLWtjVYURPCJKK+xU8AP9DpnUFwZPG4htVN5TnXGBvGBpYojfHKF4Q5WOoA==
X-Received: by 2002:a17:903:2cc:b0:216:4e9f:4ed4 with SMTP id d9443c01a7336-219e6f11809mr738439585ad.36.1735916637268;
        Fri, 03 Jan 2025 07:03:57 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629d0sm247047255ad.41.2025.01.03.07.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:03:56 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v7 02/10] net: ethtool: add support for configuring hds-thresh
Date: Fri,  3 Jan 2025 15:03:17 +0000
Message-Id: <20250103150325.926031-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103150325.926031-1-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hds-thresh option configures the threshold value of
the header-data-split.
If a received packet size is larger than this threshold value, a packet
will be split into header and payload.
The header indicates TCP and UDP header, but it depends on driver spec.
The bnxt_en driver supports HDS(Header-Data-Split) configuration at
FW level, affecting TCP and UDP too.
So, If hds-thresh is set, it affects UDP and TCP packets.

Example:
   # ethtool -G <interface name> hds-thresh <value>

   # ethtool -G enp14s0f0np0 tcp-data-split on hds-thresh 256
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   HDS thresh:  1023
   Current hardware settings:
   ...
   TCP data split:         on
   HDS thresh:  256

The default/min/max values are not defined in the ethtool so the drivers
should define themself.
The 0 value means that all TCP/UDP packets' header and payload
will be split.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v7:
 - Do not export dev_xdp_sb_prog_count().
 - Remove dev_xdp_sb_prog_count().
 - Use NL_SET_ERR_MSG_ATTR() instead of NL_SET_ERR_MSG().
 - Change location of hds-thresh size check logic.

v6:
 - Update ethtool_netlink_generated.h
 - Use "HDS" instead of "HEADER_DATA_SPLIT"
 - Add Test tag from Andy.

v5:
 - No changes.

v4:
 - Fix 80 charactor wrap.
 - Rename from tcp-data-split-thresh to header-data-split-thresh
 - Add description about overhead of HDS.
 - Add ETHTOOL_RING_USE_HDS_THRS flag.
 - Add dev_xdp_sb_prog_count() helper.
 - Add Test tag from Stanislav.

v3:
 - Fix documentation and ynl
 - Update error messages
 - Validate configuration of tcp-data-split and tcp-data-split-thresh

v2:
 - Patch added.

 Documentation/netlink/specs/ethtool.yaml      |  8 +++++++
 Documentation/networking/ethtool-netlink.rst  | 10 ++++++++
 include/linux/ethtool.h                       |  8 +++++++
 .../uapi/linux/ethtool_netlink_generated.h    |  2 ++
 net/ethtool/netlink.h                         |  2 +-
 net/ethtool/rings.c                           | 24 +++++++++++++++++--
 6 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 60f85fbf4156..66be04013048 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -332,6 +332,12 @@ attribute-sets:
       -
         name: tx-push-buf-len-max
         type: u32
+      -
+        name: hds-thresh
+        type: u32
+      -
+        name: hds-thresh-max
+        type: u32
 
   -
     name: mm-stat
@@ -1777,6 +1783,8 @@ operations:
             - rx-push
             - tx-push-buf-len
             - tx-push-buf-len-max
+            - hds-thresh
+            - hds-thresh-max
       dump: *ring-get-op
     -
       name: rings-set
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index a7ba6368a4d5..ef1d1750f960 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -899,6 +899,10 @@ Kernel response contents:
   ``ETHTOOL_A_RINGS_RX_PUSH``               u8      flag of RX Push mode
   ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``       u32     size of TX push buffer
   ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX``   u32     max size of TX push buffer
+  ``ETHTOOL_A_RINGS_HDS_THRESH``            u32     threshold of
+                                                    header / data split
+  ``ETHTOOL_A_RINGS_HDS_THRESH_MAX``        u32     max threshold of
+                                                    header / data split
   =======================================   ======  ===========================
 
 ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT`` indicates whether the device is usable with
@@ -941,10 +945,12 @@ Request contents:
   ``ETHTOOL_A_RINGS_RX_JUMBO``          u32     size of RX jumbo ring
   ``ETHTOOL_A_RINGS_TX``                u32     size of TX ring
   ``ETHTOOL_A_RINGS_RX_BUF_LEN``        u32     size of buffers on the ring
+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``    u8      TCP header / data split
   ``ETHTOOL_A_RINGS_CQE_SIZE``          u32     Size of TX/RX CQE
   ``ETHTOOL_A_RINGS_TX_PUSH``           u8      flag of TX Push mode
   ``ETHTOOL_A_RINGS_RX_PUSH``           u8      flag of RX Push mode
   ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``   u32     size of TX push buffer
+  ``ETHTOOL_A_RINGS_HDS_THRESH``        u32     threshold of header / data split
   ====================================  ======  ===========================
 
 Kernel checks that requested ring sizes do not exceed limits reported by
@@ -961,6 +967,10 @@ A bigger CQE can have more receive buffer pointers, and in turn the NIC can
 transfer a bigger frame from wire. Based on the NIC hardware, the overall
 completion queue size can be adjusted in the driver if CQE size is modified.
 
+``ETHTOOL_A_RINGS_HDS_THRESH`` specifies the threshold value of
+header / data split feature. If a received packet size is larger than this
+threshold value, header and data will be split.
+
 CHANNELS_GET
 ============
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 4e451084d58a..8bab30e91022 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -78,6 +78,8 @@ enum {
  * @cqe_size: Size of TX/RX completion queue event
  * @tx_push_buf_len: Size of TX push buffer
  * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
+ * @hds_thresh: Threshold value of header-data-split-thresh
+ * @hds_thresh_max: Maximum supprted threshold of header-data-split-thresh
  */
 struct kernel_ethtool_ringparam {
 	u32	rx_buf_len;
@@ -87,6 +89,8 @@ struct kernel_ethtool_ringparam {
 	u32	cqe_size;
 	u32	tx_push_buf_len;
 	u32	tx_push_buf_max_len;
+	u32	hds_thresh;
+	u32	hds_thresh_max;
 };
 
 /**
@@ -97,6 +101,7 @@ struct kernel_ethtool_ringparam {
  * @ETHTOOL_RING_USE_RX_PUSH: capture for setting rx_push
  * @ETHTOOL_RING_USE_TX_PUSH_BUF_LEN: capture for setting tx_push_buf_len
  * @ETHTOOL_RING_USE_TCP_DATA_SPLIT: capture for setting tcp_data_split
+ * @ETHTOOL_RING_USE_HDS_THRS: capture for setting header-data-split-thresh
  */
 enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_RX_BUF_LEN		= BIT(0),
@@ -105,6 +110,7 @@ enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_RX_PUSH		= BIT(3),
 	ETHTOOL_RING_USE_TX_PUSH_BUF_LEN	= BIT(4),
 	ETHTOOL_RING_USE_TCP_DATA_SPLIT		= BIT(5),
+	ETHTOOL_RING_USE_HDS_THRS		= BIT(6),
 };
 
 #define __ETH_RSS_HASH_BIT(bit)	((u32)1 << (bit))
@@ -1134,6 +1140,7 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
  * @rss_ctx:		XArray of custom RSS contexts
  * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
  *			within RTNL.
+ * @hds_thresh:		HDS Threshold value.
  * @hds_config:		HDS value from userspace.
  * @wol_enabled:	Wake-on-LAN is enabled
  * @module_fw_flash_in_progress: Module firmware flashing is in progress.
@@ -1141,6 +1148,7 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
 struct ethtool_netdev_state {
 	struct xarray		rss_ctx;
 	struct mutex		rss_lock;
+	u32			hds_thresh;
 	u8			hds_config;
 	unsigned		wol_enabled:1;
 	unsigned		module_fw_flash_in_progress:1;
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 43993a2d68e5..2e17ff348f89 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -155,6 +155,8 @@ enum {
 	ETHTOOL_A_RINGS_RX_PUSH,
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
+	ETHTOOL_A_RINGS_HDS_THRESH,
+	ETHTOOL_A_RINGS_HDS_THRESH_MAX,
 
 	__ETHTOOL_A_RINGS_CNT,
 	ETHTOOL_A_RINGS_MAX = (__ETHTOOL_A_RINGS_CNT - 1)
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 0a09298fff92..c523b763efa3 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -456,7 +456,7 @@ extern const struct nla_policy ethnl_features_set_policy[ETHTOOL_A_FEATURES_WANT
 extern const struct nla_policy ethnl_privflags_get_policy[ETHTOOL_A_PRIVFLAGS_HEADER + 1];
 extern const struct nla_policy ethnl_privflags_set_policy[ETHTOOL_A_PRIVFLAGS_FLAGS + 1];
 extern const struct nla_policy ethnl_rings_get_policy[ETHTOOL_A_RINGS_HEADER + 1];
-extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX + 1];
+extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_HDS_THRESH_MAX + 1];
 extern const struct nla_policy ethnl_channels_get_policy[ETHTOOL_A_CHANNELS_HEADER + 1];
 extern const struct nla_policy ethnl_channels_set_policy[ETHTOOL_A_CHANNELS_COMBINED_COUNT + 1];
 extern const struct nla_policy ethnl_coalesce_get_policy[ETHTOOL_A_COALESCE_HEADER + 1];
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index b2a2586b241f..9236de041271 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -61,7 +61,9 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u8))  +	/* _RINGS_TX_PUSH */
 	       nla_total_size(sizeof(u8))) +	/* _RINGS_RX_PUSH */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN */
-	       nla_total_size(sizeof(u32));	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_HDS_THRESH */
+	       nla_total_size(sizeof(u32));	/* _RINGS_HDS_THRESH_MAX*/
 }
 
 static int rings_fill_reply(struct sk_buff *skb,
@@ -108,7 +110,12 @@ static int rings_fill_reply(struct sk_buff *skb,
 	     (nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
 			  kr->tx_push_buf_max_len) ||
 	      nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
-			  kr->tx_push_buf_len))))
+			  kr->tx_push_buf_len))) ||
+	    ((supported_ring_params & ETHTOOL_RING_USE_HDS_THRS) &&
+	     (nla_put_u32(skb, ETHTOOL_A_RINGS_HDS_THRESH,
+			  kr->hds_thresh) ||
+	      nla_put_u32(skb, ETHTOOL_A_RINGS_HDS_THRESH_MAX,
+			  kr->hds_thresh_max))))
 		return -EMSGSIZE;
 
 	return 0;
@@ -130,6 +137,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_TX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_RX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]	= { .type = NLA_U32 },
+	[ETHTOOL_A_RINGS_HDS_THRESH]		= { .type = NLA_U32 },
 };
 
 static int
@@ -155,6 +163,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
 		return -EOPNOTSUPP;
 	}
 
+	if (tb[ETHTOOL_A_RINGS_HDS_THRESH] &&
+	    !(ops->supported_ring_params & ETHTOOL_RING_USE_HDS_THRS)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_HDS_THRESH],
+				    "setting hds-thresh is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
 	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
@@ -223,6 +239,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 			tb[ETHTOOL_A_RINGS_RX_PUSH], &mod);
 	ethnl_update_u32(&kernel_ringparam.tx_push_buf_len,
 			 tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
+	ethnl_update_u32(&kernel_ringparam.hds_thresh,
+			 tb[ETHTOOL_A_RINGS_HDS_THRESH], &mod);
 	if (!mod)
 		return 0;
 
@@ -243,6 +261,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		err_attr = tb[ETHTOOL_A_RINGS_RX_JUMBO];
 	else if (ringparam.tx_pending > ringparam.tx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_TX];
+	else if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max)
+		err_attr = tb[ETHTOOL_A_RINGS_HDS_THRESH];
 	else
 		err_attr = NULL;
 	if (err_attr) {
-- 
2.34.1


