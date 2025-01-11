Return-Path: <netdev+bounces-157418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0767DA0A435
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0018188A703
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B81F1AC435;
	Sat, 11 Jan 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV3Dl0r5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C2374F1;
	Sat, 11 Jan 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606763; cv=none; b=TME1//mGFktu3eRd99tUmdrx6ouJiRCefBk3alL+KJL+Odgd8A6hjNvWEhUJjghfqjdZ440aSjKyLhBAMS3Pf/0lkTsIIDzgkDGgeRr1YMXbnWI528qLh5z6DsWNYBkq4p7yJNo6X+5/lfzyNg1CZmcT0uwDD+9bC8ViFRi/Nyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606763; c=relaxed/simple;
	bh=GEkMd3IX/iLsmpyMVtzNyFoUzUfzrXcadVlz6lxGPP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qgqFzYBorQkb0AEgp943Lc/wxmHFW1Wv5rueOpjgnXd+nL/vxo8aNo836OkY9RLk/KZFONnqJ6xTO8+6sNYlnz3N1P8dSKw1cf6yaRh/UxpZ82y4vl6vDnv+QUtMb0AJ8WbqPkvMCc4ozqjnFvKX6XAwyjW+BCx4ViqssXj676E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV3Dl0r5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163b0c09afso52280295ad.0;
        Sat, 11 Jan 2025 06:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736606761; x=1737211561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFXY9XY1AEcuyjv44YjFbPZyhkpeSCZQhMS57baEkmQ=;
        b=OV3Dl0r5biXv0IpHU+nxMg5uff6d2WUArKSSiwBu/E3OVi2BtKEl6274SbWNlyY58x
         WD1/GdE4qMosz64MtVdmAaYNX2xaEtpEVXqOdRqWqhBYyknjpOF/7PNgF/HH9p66htZX
         oCuCQJpgoGVK/pOECMleWd8D/NJIsltumFS1GOZKasIZJtTMCN90Lj5JVrUkimfaalxO
         dI0+dJpCwu91Id5JHX9eObUJW+nmaBSAPYhYIj03g3GbgwKwYrqZoLxbk7zrzmaYCsnG
         MTs1U/MAuN6yqfUHuDgUpxTBZ+0tHL6zLUc6g3gcmSA5alVTpY6o81U17zHMVFFDSyXf
         7/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606761; x=1737211561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFXY9XY1AEcuyjv44YjFbPZyhkpeSCZQhMS57baEkmQ=;
        b=S7zPdZD5X+kv2yLoTlF2/81LQJ0tIMPM8HyntE8SnMlrodIJyJ58Wuw7M9U69vshNY
         eLBif8qNqHczmdx8iuQBm8uL3FiNhHCPMD3YdsluW5sHORe5RW+PNUgz1nhc91j8Q5Tv
         Tv1E7A5zISQ5Pi5vNVCUIlhq3eZ8RdxQoTkKnEIleeaCWPVL2aTllfDdH7PbTpGsN7+A
         JZwm4LNqOmFGdBlan7zxSRMAFNBe+DAyKJQ7LZq7OIlADiYCCZ0tl/xWESg/CzhdmKFF
         wN/UYdONblhSCOmkruptnXQ31FidCiPYstD7FuWLH/9TKnxwXHXFjAQwRNxH8TKN47qt
         6cpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNyuORFJDm/CebBL9MrX8z0Vrqn6yJdGsWYzCf1GEhxucdg3RIj5HlVnjlqp1pOaA+N8FY5c/CqqY=@vger.kernel.org, AJvYcCXnP/M89SWzXHTQNT9G7LxDVop+vNEmNbdPrUpieKthG0yROTk+UK3YyYS+99iO8E05RT90ygq0@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6IVFY8VQNjoM8zjG4jnrwNHEwFoz/B7ti9f9dD+4CiPCBw2t
	VcTnKMeIiOyzBC+WKxSNLOVqMYuI2xJCQEpPeHDQS3Wslc3nC+4L
X-Gm-Gg: ASbGncvc4hL+U6L6j/DTNISjuxHHwJ+Oi0VhMOo1zFePSOwEzOs5MkGjultTVAI4N2k
	wdZpYPbEZDRhc8NKTUqT7SI4R7JQeaSSCTYcAo4CxmFBIWh08IhJMHbLQj6YjdFly4QSEGWN6Lg
	OXiX7ZSyChZUUkI6M1+B9KGnvuIeHU5xXjt38mQAXcde6QdLjdiSVrP6XMHeQleNNYeEYMLc9BZ
	Na8wjfUi7FDn1drMixakW0906cnzSxE/ypvg1sEo9eHFg==
X-Google-Smtp-Source: AGHT+IFw72PZ3G3GrVGGlhbn9YZzIQlrGxweNIubsPH5euApAy1ZY5Ojvd8rWCdT5EoROiVLlP0jNA==
X-Received: by 2002:a05:6a20:3d85:b0:1e0:d848:9e83 with SMTP id adf61e73a8af0-1e88d12b3cdmr24197382637.25.1736606760688;
        Sat, 11 Jan 2025 06:46:00 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40594a06sm3097466b3a.80.2025.01.11.06.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:46:00 -0800 (PST)
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
Subject: [PATCH net-next v8 02/10] net: ethtool: add support for configuring hds-thresh
Date: Sat, 11 Jan 2025 14:45:05 +0000
Message-Id: <20250111144513.1289403-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111144513.1289403-1-ap420073@gmail.com>
References: <20250111144513.1289403-1-ap420073@gmail.com>
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
index 4e451084d58a..45d8f107b42e 100644
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
@@ -1134,6 +1141,7 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
  * @rss_ctx:		XArray of custom RSS contexts
  * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
  *			within RTNL.
+ * @hds_thresh:		HDS Threshold value.
  * @hds_config:		HDS value from userspace.
  * @wol_enabled:	Wake-on-LAN is enabled
  * @module_fw_flash_in_progress: Module firmware flashing is in progress.
@@ -1141,6 +1149,7 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
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


