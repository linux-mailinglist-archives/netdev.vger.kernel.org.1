Return-Path: <netdev+bounces-153004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F3E9F6907
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9560616FB29
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E7F1C2304;
	Wed, 18 Dec 2024 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avE+g08m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE01C173D;
	Wed, 18 Dec 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533245; cv=none; b=YR0cLiEo+IKIUURAaSds3Lj2G6d9gVnYLW0u9hoxKMWQKOWgy5k+T1sZjDt82sj4oW62pnk+tX8UZ7UTFavLjhRcXuIV95osYeIv2YRZniHaHRG6yqoHxBRSRcjjDJ3Sal1M4GsR3ae39iLIOIGm0vfe6KYOXQFVzIY4DukQUZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533245; c=relaxed/simple;
	bh=FS+lNas+EOrbjFcBEwXpZM6GCer2gzrU8ZOQ+WFyrgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFBMO3hLQlmPIxrZjg9UK4IhWyaZOKQR0eeUbr/OXdWooV1XL4qdO8eRB/gRYgvs1K2uVhmJAf7mQX/0OpG/F9Q39A5F8RdquMlUsMs93k3vRA4m3ZnyQqvWpXvow3h6AiEGUDt1zN86fwY/ba9qWHJHf1mJqul/z25Pe159EAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avE+g08m; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725ee27e905so8347861b3a.2;
        Wed, 18 Dec 2024 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734533243; x=1735138043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzy83pZIpP8yx5hu8TIVetY5D1C6cozSgWXt8NlzUu4=;
        b=avE+g08miSfi0xltSQINKwrxhtRbIjSjpQQT/b/bBhAvRMooq8S8VaG15wqB03sqMq
         WAWclyAEa2Rz3P7l4+MV7TIgAFFYVujVxZnth3Lgk5/labaV/oHtqRuajiyw256GSqyb
         MbjBYxLoxZGisXMW+DkNnfeCOK7grBUV7kVdyHjC9dQuDRjjRdSIR1fz0ZW41MLOAknC
         W2vUXHrJJeHx2+cwz3/FyzX27si+U0kmbe3jqEtWD7JxVW+rfoV1f5uVksm4b/6XbAah
         d+aW3hBCvGAqvjql1NtKORN55q2fbeaLW4t4Ea9/8eRsiLPqxHV2ETfQ8CFNGYWfM0c3
         TEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734533243; x=1735138043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzy83pZIpP8yx5hu8TIVetY5D1C6cozSgWXt8NlzUu4=;
        b=swSQTBmfIdV0cp3NeYt+tRNX9jDNADx9hxmIVSDfVbpN1aeB7dlzh37WTywzEiMXjB
         e1PEz09NPFJ6P4EjAUCTHEg3OZyNL8evt4rqyXQgQ8dYOLBZc5Z9Hoq0oV4HOkTVbkLT
         bnIO4DEPA7KsLh3ZyxSZnU0Ne/JSnjomOstvPyULQo3YHVGGTLntynK64bcgwPxf2wxv
         8g7dyqDvnBCO/OlWPMxjhNjEKylzwaP8Z8CVvzaIH0UPs52+9P+Q/0cQRytiJSz3Md3s
         9jjduo6cXkCHvuD6+1VuyvfD7CPZqLUkap0aUnKvf4WDE72kLfvV+z4Yz9NZ3WLffDyx
         jIYA==
X-Forwarded-Encrypted: i=1; AJvYcCVEL7MfPR0VVJqY+FbIT4IlSKLHiZs8Z2rcnkXEFefEWej7Kc9yJfxofYErZWQaNl6aJ88ivf07v0A=@vger.kernel.org, AJvYcCXNVBP5DOjJ8gUqIQqvIiii34ERyxma4qetNYMA5JFqrwX/EaOqXOqjN4P5duiLGgROwEjtYwXn@vger.kernel.org
X-Gm-Message-State: AOJu0YzsUAzWqa7j/lNWrYXYm1tli4lMQI9yeunTJn0vTAC8vxHM1cID
	Cb54PP8UNfvGcoyhsJt7FbSoex/xlWmWZ/cXfxARsQiTLf9pL2T+7MRsy0Ds
X-Gm-Gg: ASbGncsUDNmL+ULLmGuql1THbrjSq8CZfWnni7e57ekVGAwB6hfaJqQCXb4cggIu2rE
	sO7hHedb/gnexaxyRVVlRjjcwSw3LCEdmvHGSNwDZqwZlH6zWy0LcEJRL5r4W1PQ4/tAxSeYXhH
	9Tq1e5aLfURRmvEVG22iXXGvGa2kvK5o5/r1j18dmC+nb5rztL4pAEZjtveH3QIFU1uVZp67Gos
	8eN9MZiFw8EEYcHovZ5RGdKh8iI1nX1MTkswSJp5QryEw==
X-Google-Smtp-Source: AGHT+IFilaLYKslxYyvg2+W9Nrrb3x3dcN5KKyr4AvoP0nlYnxLCEHm5XCZo354MMqXBqSG0mPPMfw==
X-Received: by 2002:a05:6a20:a109:b0:1d9:c753:6bad with SMTP id adf61e73a8af0-1e5b47fc77emr5933834637.10.1734533242777;
        Wed, 18 Dec 2024 06:47:22 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5183sm8912687b3a.29.2024.12.18.06.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:47:22 -0800 (PST)
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
Subject: [PATCH net-next v6 4/9] net: ethtool: add support for configuring hds-thresh
Date: Wed, 18 Dec 2024 14:45:25 +0000
Message-Id: <20241218144530.2963326-5-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218144530.2963326-1-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
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

 Documentation/netlink/specs/ethtool.yaml      |  8 ++++
 Documentation/networking/ethtool-netlink.rst  | 10 +++++
 include/linux/ethtool.h                       |  6 +++
 include/linux/netdevice.h                     |  1 +
 .../uapi/linux/ethtool_netlink_generated.h    |  2 +
 net/core/dev.c                                | 13 ++++++
 net/ethtool/netlink.h                         |  2 +-
 net/ethtool/rings.c                           | 40 +++++++++++++++++--
 8 files changed, 78 insertions(+), 4 deletions(-)

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
index 4e451084d58a..4f407ce9eed1 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -78,6 +78,8 @@ enum {
  * @cqe_size: Size of TX/RX completion queue event
  * @tx_push_buf_len: Size of TX push buffer
  * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
+ * @hds_thresh: Threshold value of header-data-split-thresh
+ * @hds_thresh_max: Maximum allowed threshold of header-data-split-thresh
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
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2593019ad5b1..b18f249826c5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4083,6 +4083,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
+u8 dev_xdp_sb_prog_count(struct net_device *dev);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
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
diff --git a/net/core/dev.c b/net/core/dev.c
index c7f3dea3e0eb..6a68db95de76 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9480,6 +9480,19 @@ u8 dev_xdp_prog_count(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
 
+u8 dev_xdp_sb_prog_count(struct net_device *dev)
+{
+	u8 count = 0;
+	int i;
+
+	for (i = 0; i < __MAX_XDP_MODE; i++)
+		if (dev->xdp_state[i].prog &&
+		    !dev->xdp_state[i].prog->aux->xdp_has_frags)
+			count++;
+	return count;
+}
+EXPORT_SYMBOL_GPL(dev_xdp_sb_prog_count);
+
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	if (!dev->netdev_ops->ndo_bpf)
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
index 2e8239a76234..c0cb9b2c6616 100644
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
@@ -196,14 +212,16 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct kernel_ethtool_ringparam kernel_ringparam = {};
 	struct ethtool_ringparam ringparam = {};
 	struct net_device *dev = req_info->dev;
+	u8 old_hds_config, hds_config_mod;
 	struct nlattr **tb = info->attrs;
 	const struct nlattr *err_attr;
 	bool mod = false;
 	int ret;
 
+	old_hds_config = dev->ethtool->hds_config;
 	dev->ethtool_ops->get_ringparam(dev, &ringparam,
 					&kernel_ringparam, info->extack);
-	kernel_ringparam.tcp_data_split = dev->ethtool->hds_config;
+	kernel_ringparam.tcp_data_split = old_hds_config;
 
 	ethnl_update_u32(&ringparam.rx_pending, tb[ETHTOOL_A_RINGS_RX], &mod);
 	ethnl_update_u32(&ringparam.rx_mini_pending,
@@ -223,9 +241,25 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 			tb[ETHTOOL_A_RINGS_RX_PUSH], &mod);
 	ethnl_update_u32(&kernel_ringparam.tx_push_buf_len,
 			 tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
+	ethnl_update_u32(&kernel_ringparam.hds_thresh,
+			 tb[ETHTOOL_A_RINGS_HDS_THRESH], &mod);
 	if (!mod)
 		return 0;
 
+	hds_config_mod = old_hds_config != kernel_ringparam.tcp_data_split;
+	if (kernel_ringparam.tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    hds_config_mod && dev_xdp_sb_prog_count(dev)) {
+		NL_SET_ERR_MSG(info->extack,
+			       "tcp-data-split can not be enabled with single buffer XDP");
+		return -EINVAL;
+	}
+
+	if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max) {
+		NL_SET_BAD_ATTR(info->extack,
+				tb[ETHTOOL_A_RINGS_HDS_THRESH_MAX]);
+		return -ERANGE;
+	}
+
 	/* ensure new ring parameters are within limits */
 	if (ringparam.rx_pending > ringparam.rx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_RX];
-- 
2.34.1


