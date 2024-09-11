Return-Path: <netdev+bounces-127435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAEB97562A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633781C260E4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0179A1AAE36;
	Wed, 11 Sep 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbJtDzXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F98F6C;
	Wed, 11 Sep 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066593; cv=none; b=pPmK5ncwWN4P9sgxjHGoWshMiZzGEvesmQzCh0Rrtg7cs79oc7epfORmGRR+PAKiehEQrFYhJHO5ZYmFQtlpl+8BDxyyELNYZdbX2Hr7T2QlGAZdXNye9CAGHO165OZky990fzRvxi+b/1/HMGJik3Fr9VRHaxpjsiYjBV4uBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066593; c=relaxed/simple;
	bh=TsepaRUVqTPBrJWTJWlRwtVkvLU0gbrBfd/kfMa/mpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnubcofGvHYqscDUWNmAjy6Kq3frk7HSeVeySJ+hjXb8phd69mlfKZOMWQromFMLBcdX/oqfkAIWcfH8IfEWImI4Vx73wMa0oTklEKbs1pom72xRoFnBOPDPEn+NQq2JxujH4GlrTZYa96qzUNgO6zf5Zp+3cEsJ4E06QouoQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbJtDzXs; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so4739706a12.3;
        Wed, 11 Sep 2024 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066591; x=1726671391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMvaqDQqcX/C936NjjZ0QVz9XsU/EnO54agZvR8BeDU=;
        b=LbJtDzXsTKkVE0q2c1rX6+jeZV5b04ru3If9q1De9orHrjHR5pfZXFIRuyeEm/505f
         AQT8bEWIjkaCgZWOtnwHitZ0kLUIOKgea6sJc53dCk79XVVcZ0MKRfZi3BdR0gEF6Eou
         wSn5Ua91Vh7upecn0d2sVtnwxB2wohrNDVghEqtkjZpkUT7/g1h9LTmWAi81O9qwcwsP
         jlRdc/7H1AMCDf/ohVmZlaGenHXcx8vXaICw65JWbvbJgISGC/e6W91SOCwm1O9PTTJv
         9I2AzQFXXOJLzQpTToqPVtwTSRlzfXFF4JTPGPijfsPXkMxUJ6ifkMHHqgAsydOIjFKX
         noww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066591; x=1726671391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMvaqDQqcX/C936NjjZ0QVz9XsU/EnO54agZvR8BeDU=;
        b=EmFPbEbh+nPHCoS/OTQsJMjGovM9SWimTcnIYfBZ4bOOw+BJgKuO/oa1cYxj3Ox0KO
         60dSep789Q7OHraVenoPXoVBTZWsyv0Lur1UXC1m4AL9Sd55J1bcY1wp9BjuKIkEYzy7
         b+uUK1kpmbB+PHDHzKkMrJCwbv4IvpwLUVc89SKOX7o5d8/Zy4GybD3yUrYy5I0+z3n4
         tU7yLDW8X/huCICQNlV8Esvhchce3Ua4rV4kS3naAGpSTG0RFjgSnNhlUIXBWun+jkpw
         SDTkAueLGqqCGxRvoH5sWJoovPDYwtRaFQxiyzwLNKhSGFBt75uSCpwaiuVLrohoc5UI
         efFA==
X-Forwarded-Encrypted: i=1; AJvYcCUcQmzLmsOcqs28vFdpHOWHJCdHfPnubr/TZlNAWKpcKAeaKCoCa5EgoZbwN7W5g91Qv9X8z57VdRk=@vger.kernel.org, AJvYcCUq4UHCeH/fKkX9Pa7wZkOajE+oKbSdWzZL+qlXP+HPLsCnQ4xvk8jrl28GZl8JFx7ZfmBExnL8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5zLLrB/Oh1P+TJciGkVmOxW6RnBgnPtz1CmDI1Hu/0DuFoUpa
	gwuVKwXAM8y0dEuZjIdI5YrP715cY33ZUtj4yhes3KrrLgt9W7Gn
X-Google-Smtp-Source: AGHT+IHju3npbPq1XRnA0GrL4E+R1Yn7NIh4rUPPw621oYKRA467TTDsmjP+QecK67UHhle5Q0alag==
X-Received: by 2002:a17:902:db0f:b0:207:14e9:eb22 with SMTP id d9443c01a7336-2074c4c5622mr56584555ad.6.1726066591350;
        Wed, 11 Sep 2024 07:56:31 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af278aasm664995ad.28.2024.09.11.07.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:56:30 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	kory.maincent@bootlin.com,
	ahmed.zaki@intel.com,
	paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	aleksander.lobakin@intel.com,
	ap420073@gmail.com
Subject: [PATCH net-next v2 3/4] ethtool: Add support for configuring tcp-data-split-thresh
Date: Wed, 11 Sep 2024 14:55:54 +0000
Message-Id: <20240911145555.318605-4-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911145555.318605-1-ap420073@gmail.com>
References: <20240911145555.318605-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tcp-data-split-thresh option configures the threshold value of
the tcp-data-split.
If a received packet size is larger than this threshold value, a packet
will be split into header and payload.
The header indicates TCP header, but it depends on driver spec.
The bnxt_en driver supports HDS(Header-Data-Split) configuration at
FW level, affecting TCP and UDP too.
So, like the tcp-data-split option, If tcp-data-split-thresh is set,
it affects UDP and TCP packets.

The tcp-data-split-thresh has a dependency, that is tcp-data-split
option. This threshold value can be get/set only when tcp-data-split
option is enabled.

Example:
   # ethtool -G <interface name> tcp-data-split-thresh <value>

   # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 256
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   Current hardware settings:
   ...
   TCP data split:         on
   TCP data split thresh:  256

The tcp-data-split is not enabled, the tcp-data-split-thresh will
not be used and can't be configured.

   # ethtool -G enp14s0f0np0 tcp-data-split off
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   Current hardware settings:
   ...
   TCP data split:         off
   TCP data split thresh:  n/a

The default/min/max values are not defined in the ethtool so the drivers
should define themself.
The 0 value means that all TCP and UDP packets' header and payload
will be split.
Users should consider the overhead due to this feature.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Patch added.

 Documentation/networking/ethtool-netlink.rst | 31 +++++++++++--------
 include/linux/ethtool.h                      |  2 ++
 include/uapi/linux/ethtool_netlink.h         |  1 +
 net/ethtool/netlink.h                        |  2 +-
 net/ethtool/rings.c                          | 32 +++++++++++++++++---
 5 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index ba90457b8b2d..bb74e108c8c1 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -892,6 +892,7 @@ Kernel response contents:
   ``ETHTOOL_A_RINGS_RX_PUSH``               u8      flag of RX Push mode
   ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``       u32     size of TX push buffer
   ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX``   u32     max size of TX push buffer
+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH`` u32     threshold of TDS
   =======================================   ======  ===========================
 
 ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT`` indicates whether the device is usable with
@@ -927,18 +928,20 @@ Sets ring sizes like ``ETHTOOL_SRINGPARAM`` ioctl request.
 
 Request contents:
 
-  ====================================  ======  ===========================
-  ``ETHTOOL_A_RINGS_HEADER``            nested  reply header
-  ``ETHTOOL_A_RINGS_RX``                u32     size of RX ring
-  ``ETHTOOL_A_RINGS_RX_MINI``           u32     size of RX mini ring
-  ``ETHTOOL_A_RINGS_RX_JUMBO``          u32     size of RX jumbo ring
-  ``ETHTOOL_A_RINGS_TX``                u32     size of TX ring
-  ``ETHTOOL_A_RINGS_RX_BUF_LEN``        u32     size of buffers on the ring
-  ``ETHTOOL_A_RINGS_CQE_SIZE``          u32     Size of TX/RX CQE
-  ``ETHTOOL_A_RINGS_TX_PUSH``           u8      flag of TX Push mode
-  ``ETHTOOL_A_RINGS_RX_PUSH``           u8      flag of RX Push mode
-  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``   u32     size of TX push buffer
-  ====================================  ======  ===========================
+  =======================================   ======  ===========================
+  ``ETHTOOL_A_RINGS_HEADER``                nested  reply header
+  ``ETHTOOL_A_RINGS_RX``                    u32     size of RX ring
+  ``ETHTOOL_A_RINGS_RX_MINI``               u32     size of RX mini ring
+  ``ETHTOOL_A_RINGS_RX_JUMBO``              u32     size of RX jumbo ring
+  ``ETHTOOL_A_RINGS_TX``                    u32     size of TX ring
+  ``ETHTOOL_A_RINGS_RX_BUF_LEN``            u32     size of buffers on the ring
+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``        u8      TCP header / data split
+  ``ETHTOOL_A_RINGS_CQE_SIZE``              u32     Size of TX/RX CQE
+  ``ETHTOOL_A_RINGS_TX_PUSH``               u8      flag of TX Push mode
+  ``ETHTOOL_A_RINGS_RX_PUSH``               u8      flag of RX Push mode
+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``       u32     size of TX push buffer
+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH`` u32     threshold of TDS
+  =======================================   ======  ===========================
 
 Kernel checks that requested ring sizes do not exceed limits reported by
 driver. Driver may impose additional constraints and may not support all
@@ -954,6 +957,10 @@ A bigger CQE can have more receive buffer pointers, and in turn the NIC can
 transfer a bigger frame from wire. Based on the NIC hardware, the overall
 completion queue size can be adjusted in the driver if CQE size is modified.
 
+``ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH`` specifies the threshold value of
+tcp data split feature. If tcp-data-split is enabled and a received packet
+size is larger than this threshold value, header and data will be split.
+
 CHANNELS_GET
 ============
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 12f6dc567598..5f3d0a231e53 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -78,6 +78,7 @@ enum {
  * @cqe_size: Size of TX/RX completion queue event
  * @tx_push_buf_len: Size of TX push buffer
  * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
+ * @tcp_data_split_thresh: Threshold value of tcp-data-split
  */
 struct kernel_ethtool_ringparam {
 	u32	rx_buf_len;
@@ -87,6 +88,7 @@ struct kernel_ethtool_ringparam {
 	u32	cqe_size;
 	u32	tx_push_buf_len;
 	u32	tx_push_buf_max_len;
+	u32	tcp_data_split_thresh;
 };
 
 /**
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 283305f6b063..2be2d1840e7f 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -364,6 +364,7 @@ enum {
 	ETHTOOL_A_RINGS_RX_PUSH,			/* u8 */
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,		/* u32 */
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,		/* u32 */
+	ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_RINGS_CNT,
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 203b08eb6c6f..d8dad0d10c8d 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -455,7 +455,7 @@ extern const struct nla_policy ethnl_features_set_policy[ETHTOOL_A_FEATURES_WANT
 extern const struct nla_policy ethnl_privflags_get_policy[ETHTOOL_A_PRIVFLAGS_HEADER + 1];
 extern const struct nla_policy ethnl_privflags_set_policy[ETHTOOL_A_PRIVFLAGS_FLAGS + 1];
 extern const struct nla_policy ethnl_rings_get_policy[ETHTOOL_A_RINGS_HEADER + 1];
-extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX + 1];
+extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH + 1];
 extern const struct nla_policy ethnl_channels_get_policy[ETHTOOL_A_CHANNELS_HEADER + 1];
 extern const struct nla_policy ethnl_channels_set_policy[ETHTOOL_A_CHANNELS_COMBINED_COUNT + 1];
 extern const struct nla_policy ethnl_coalesce_get_policy[ETHTOOL_A_COALESCE_HEADER + 1];
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index b7865a14fdf8..0b68ea316815 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -61,7 +61,8 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u8))  +	/* _RINGS_TX_PUSH */
 	       nla_total_size(sizeof(u8))) +	/* _RINGS_RX_PUSH */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN */
-	       nla_total_size(sizeof(u32));	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
+	       nla_total_size(sizeof(u32));	/* _RINGS_TCP_DATA_SPLIT_THRESH */
 }
 
 static int rings_fill_reply(struct sk_buff *skb,
@@ -108,7 +109,10 @@ static int rings_fill_reply(struct sk_buff *skb,
 	     (nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
 			  kr->tx_push_buf_max_len) ||
 	      nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
-			  kr->tx_push_buf_len))))
+			  kr->tx_push_buf_len))) ||
+	    (kr->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	     (nla_put_u32(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH,
+			 kr->tcp_data_split_thresh))))
 		return -EMSGSIZE;
 
 	return 0;
@@ -130,6 +134,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_TX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_RX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]	= { .type = NLA_U32 },
+	[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH]	= { .type = NLA_U32 },
 };
 
 static int
@@ -155,6 +160,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
 		return -EOPNOTSUPP;
 	}
 
+	if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] &&
+	    !(ops->supported_ring_params & ETHTOOL_RING_USE_TCP_DATA_SPLIT)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
+				    "setting TDS threshold is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
 	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
@@ -196,9 +209,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct kernel_ethtool_ringparam kernel_ringparam = {};
 	struct ethtool_ringparam ringparam = {};
 	struct net_device *dev = req_info->dev;
+	bool mod = false, thresh_mod = false;
 	struct nlattr **tb = info->attrs;
 	const struct nlattr *err_attr;
-	bool mod = false;
 	int ret;
 
 	dev->ethtool_ops->get_ringparam(dev, &ringparam,
@@ -222,9 +235,20 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 			tb[ETHTOOL_A_RINGS_RX_PUSH], &mod);
 	ethnl_update_u32(&kernel_ringparam.tx_push_buf_len,
 			 tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
-	if (!mod)
+	ethnl_update_u32(&kernel_ringparam.tcp_data_split_thresh,
+			 tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
+			 &thresh_mod);
+	if (!mod && !thresh_mod)
 		return 0;
 
+	if (kernel_ringparam.tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
+	    thresh_mod) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
+				    "tcp-data-split-thresh can not be updated while tcp-data-split is disabled");
+		return -EINVAL;
+	}
+
 	/* ensure new ring parameters are within limits */
 	if (ringparam.rx_pending > ringparam.rx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_RX];
-- 
2.34.1


