Return-Path: <netdev+bounces-158141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83988A1094A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B4116793F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A373146D6E;
	Tue, 14 Jan 2025 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSXOfVqQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4813A879;
	Tue, 14 Jan 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864981; cv=none; b=oo6/AD7MDpqOTTa1Am0HJqamvd6Tr+tslrKA0Exw+f5b517xGiRnOZ0pjpXgEjs54IRrUby9XqazqgvVKGhrFV1UkZHTWHGsWMg41p7PRGWqNydkgTyJlxY6GU3pzy6LVwVZ1a5NRW7i/FVY6OiJ+1ErwCljOoAJIOB9oR/GLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864981; c=relaxed/simple;
	bh=dYl+hh2R0e8lZ9vzBMq4ASINllEEjoOmqf+PWfqnqaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjSam77kdQayfxYo7MjtXbjMGA6Cz7sO8Os4rtBvm6VJuAgIVwUFKB6uS8BJ3hxxHGFdjxJn5XhvHLHd2Zj8mT6ZruubGxj/MpgVZSjD3Y7Jnu38Nc2fm4DFgeb6ezYAkzsKXcM7uGVsXVGJBCLmO9xs2mWb+K5TR/tiLbgOLIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSXOfVqQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161eb94cceso68232295ad.2;
        Tue, 14 Jan 2025 06:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736864979; x=1737469779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iARQ4MUce9zewtBA/S239IXTVNpFradI2wMq2uwOl6w=;
        b=CSXOfVqQTOHYEU9/SNyZxFMNijpDS87Y6E2jfQJqvWLX09kk6HrbMQxGvFv6L9DrBb
         2uQ5gjxpBoUasEfOKhSirKsZrk+fOdkwciYbYyK2FsO/6LBK6RlrF7NTg1vAkgBan5/1
         pn6AySRXRSohyPpdOOtrMNzHvll7Un0m7bWSNnZ2uGkYpUuVtjFMvPrQOLl/tu8AZKFr
         yyCcJHzgaAwqRGGoCko0cm75PY6tS8wAxXfkanYcV5g3ljWQ3SNK1ZVtTTaBA7yqdMzc
         EDkmqsUgIqIg+xJZ4cIQZTKIRcKAbMMYRCKWH0muvTqHwzpmfYm5BxmEVddVc71tw0OD
         qgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736864979; x=1737469779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iARQ4MUce9zewtBA/S239IXTVNpFradI2wMq2uwOl6w=;
        b=xSPaXRN0e5R7klvnjHNW/q9KauHPxiGlphKzEef9Ke4ge33rnG/6AERww47QG2oxRh
         RelMwSCAYTdA1FjCcLRpgube/MEbUrsRCB8/ifwoMHRtprYIaPsVI22eF/hIAC4rdzis
         h1SaPDBMGysszYae4gWLWdHQ/DnG2Utres7S6TyaF01Bc/yS9UvHCLMfgkiRoRZSmsuG
         Ud1w3Zf5evskKLkt/3PV22vNZ647TC0tOVGi3OapBBFXV98DlscBpTvbsiipCqZuce7A
         iJQUGc+MHam3gHh9OzXjwXSPmXqFrPFSW+epMt7qaUcelpDE1GFMgeg8HQRUGQgr5LF8
         LA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrQuWpbevX1QcIPbJyfCq1rsHlJsKFkmmX3wCuhLr7hg08rzxib0bp/5/mQ+8+MtSdFsADL4KQ@vger.kernel.org, AJvYcCW+DJ3Yqfh72nsGURnYoUs8LROHKFvza70fmPRhnWPKwDfXHnKiCIun3lZO9Puk/tZ+JP39Sq6sm84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDA8dVGpYRIUf2wUpnbh/pY5onMye6ZqvmIm2F/HX59dxiVoc
	rUdwvZTogqkAlDcYG/Nhdu2p2e+x9UfawOG2I1WjTvFJlenOS9Xp
X-Gm-Gg: ASbGncvxRpJvzTqemIV5SR9M2Rp+8cW+xHFjxdLTg9ENToj/3lHluFhIeFgFrFwi1HR
	vxp2yO0bFy7vNFln3+VOKCdO8mACYAjH74lliqsmUqOaF4X4Gbbh1gPAGC2vGH3K7y58ct7bILF
	qdc4ulz0K0p3uH/UET1Z2zjx9I9q7vzg68qkQojvooEcGdKogymIcvVV1SUSIuvOF97vpwhwYRK
	AgyGXTAaOY3sP61MGeQYFNwtdybdhQZMZbEe7Y55zkBtg==
X-Google-Smtp-Source: AGHT+IGmVq5RS5aDcy8g0wCSk6g36G8do016xnpeCPruQZfATlSwO/iNY35/aHdXeIcq1T2Ncd0ykQ==
X-Received: by 2002:a05:6a20:8412:b0:1e6:509c:1664 with SMTP id adf61e73a8af0-1e88d0edad9mr39561346637.39.1736864978996;
        Tue, 14 Jan 2025 06:29:38 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dfesm7474582b3a.156.2025.01.14.06.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:29:38 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
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
	linux-doc@vger.kernel.org
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
Subject: [PATCH net-next v9 02/10] net: ethtool: add support for configuring hds-thresh
Date: Tue, 14 Jan 2025 14:28:44 +0000
Message-Id: <20250114142852.3364986-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114142852.3364986-1-ap420073@gmail.com>
References: <20250114142852.3364986-1-ap420073@gmail.com>
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

v9:
 - No changes.

v8:
 - Make the handling of hds_thresh similar to hds_config.
 - Update comments of hds_thresh and hds_thresh_max.

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

 Documentation/netlink/specs/ethtool.yaml      |  8 ++++++
 Documentation/networking/ethtool-netlink.rst  | 10 +++++++
 include/linux/ethtool.h                       |  9 ++++++
 .../uapi/linux/ethtool_netlink_generated.h    |  2 ++
 net/ethtool/netlink.h                         |  2 +-
 net/ethtool/rings.c                           | 28 +++++++++++++++++--
 6 files changed, 55 insertions(+), 4 deletions(-)

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
index da846f1d998e..f70c0249860c 100644
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
index d79bd201c1c8..e4136b0df892 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -78,6 +78,9 @@ enum {
  * @cqe_size: Size of TX/RX completion queue event
  * @tx_push_buf_len: Size of TX push buffer
  * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
+ * @hds_thresh: Packet size threshold for header data split (HDS)
+ * @hds_thresh_max: Maximum supported setting for @hds_threshold
+ *
  */
 struct kernel_ethtool_ringparam {
 	u32	rx_buf_len;
@@ -87,6 +90,8 @@ struct kernel_ethtool_ringparam {
 	u32	cqe_size;
 	u32	tx_push_buf_len;
 	u32	tx_push_buf_max_len;
+	u32	hds_thresh;
+	u32	hds_thresh_max;
 };
 
 /**
@@ -97,6 +102,7 @@ struct kernel_ethtool_ringparam {
  * @ETHTOOL_RING_USE_RX_PUSH: capture for setting rx_push
  * @ETHTOOL_RING_USE_TX_PUSH_BUF_LEN: capture for setting tx_push_buf_len
  * @ETHTOOL_RING_USE_TCP_DATA_SPLIT: capture for setting tcp_data_split
+ * @ETHTOOL_RING_USE_HDS_THRS: capture for setting header-data-split-thresh
  */
 enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_RX_BUF_LEN		= BIT(0),
@@ -105,6 +111,7 @@ enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_RX_PUSH		= BIT(3),
 	ETHTOOL_RING_USE_TX_PUSH_BUF_LEN	= BIT(4),
 	ETHTOOL_RING_USE_TCP_DATA_SPLIT		= BIT(5),
+	ETHTOOL_RING_USE_HDS_THRS		= BIT(6),
 };
 
 #define __ETH_RSS_HASH_BIT(bit)	((u32)1 << (bit))
@@ -1157,6 +1164,7 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
  * @rss_ctx:		XArray of custom RSS contexts
  * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
  *			within RTNL.
+ * @hds_thresh:		HDS Threshold value.
  * @hds_config:		HDS value from userspace.
  * @wol_enabled:	Wake-on-LAN is enabled
  * @module_fw_flash_in_progress: Module firmware flashing is in progress.
@@ -1164,6 +1172,7 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
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
index 1ce0a3de1430..ff69ca0715de 100644
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
index b2a2586b241f..a381913a19f0 100644
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
@@ -261,8 +281,10 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	ret = dev->ethtool_ops->set_ringparam(dev, &ringparam,
 					      &kernel_ringparam, info->extack);
-	if (!ret)
+	if (!ret) {
 		dev->ethtool->hds_config = kernel_ringparam.tcp_data_split;
+		dev->ethtool->hds_thresh = kernel_ringparam.hds_thresh;
+	}
 
 	return ret < 0 ? ret : 1;
 }
-- 
2.34.1


