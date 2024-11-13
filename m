Return-Path: <netdev+bounces-144503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423CF9C7A73
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E892B31769
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE22022F2;
	Wed, 13 Nov 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXe1MO/m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9520262A;
	Wed, 13 Nov 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519197; cv=none; b=jNScZK4msVCgd/Xc9DQ/HSdMdQRujspSjwIlequ9tfmlvmhiEdbz8NoWBxP+NpRNS/ri8jY+0IgZCQ9TVXhPB5RjSUJhLfFPYT3y0ySVwTDroIxYCfF1jGQ3A3be2qiUBz9sO7hGmATAASSAGwYcH1BjoImTJ7ZxNoqlxZgssu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519197; c=relaxed/simple;
	bh=gZPGA5bLddVbJVyN1uiiSXHOu0Xj+fQoxdSA7iO5WLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGAb9/WafTcgcpgGeRIzQQtFJA7sdXcun9Y1OOIR8gXTlbFFCFbCPQIyMpOO1GZfJldiJPPDgp9TLdCHoavjcOtv2jHXngQSC34UCTzjl30KUEIpWW1sej5MvFQ3EXyIfMwA4lzfOprV3uO0ZeJbEQYIFn5UTDpL0FJtvQlw3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXe1MO/m; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cdb889222so72052815ad.3;
        Wed, 13 Nov 2024 09:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519195; x=1732123995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvkC4WOe7NS3cmVKReVfn/+fqg/DlSXzBIx3GFroG/w=;
        b=NXe1MO/mSFa5xCN0HmGK7H/NkM2VX/EDOATiRyvIobiLfLCaX1INZ/bE5cWtUEXF6h
         uh/5q8zvevUv3fOIj5YTKfoTzf7ZTHzVzDrqdIr/hR0QTEowVngR3gLesj4/qsvhcWyO
         svTNvCKDlsfcgGQ/OzP0nxRz5e5M3dPoAjDS3jUYypJFcHlNbfn6rzdFs6DxrHMtjPZ+
         he3GqETYeuH8Aw7PZOwem7FBnnybys7XPDSfO5VBkW3vMoTEexzqwc8PZWAY3MQ8vzOe
         LH831JMZkJDcWuFLaCgZVSo8i73DmAiiRtedxhQwsdirYh4+O1/gfBNx6CT+aLydOjo/
         VjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519195; x=1732123995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvkC4WOe7NS3cmVKReVfn/+fqg/DlSXzBIx3GFroG/w=;
        b=o3C1gD/0U2Q7UD/RJ5+J+1M6tik5mTDKIDBANjo1MEY/7Z2XUCCNw3/XnfwDzMBRM/
         SqO0tsUu3uJ8dIufJtLiDBJdyyzwkqO5JRr9OndMi/h8fPaV8SxHH/tMv2IrlsFDiOE8
         fO4uf3Qp423hqy434y1OwzcW1x9emtpkMgE0BbyJIFIZ0GPVEgEATu9mQNDOvUYtLxgA
         GuYrRWq9moaEznIgsKMZwa81/5eK7NQgLsPYrCMs3gTX61Y3MnM3mUO930fFqFdwra3j
         6otXKJx4Cqv65GMGEFBkHJbS/3cBAdjrWhKPV2bGjMrZI9rPZj/b9D+TxQo59h8jijf0
         bLmA==
X-Forwarded-Encrypted: i=1; AJvYcCUTVSg1eG8fOMpINVbtJzVWexLwykh1y5K91jEyFfMMIp4Y/+6w9VcyCMXF5PZGync7LX0yTAF1EY8=@vger.kernel.org, AJvYcCUvXpH86ejfUTO14l0z0PcFYxwghHZ6D+5flcVblewI4gW3Lx/S0Aboi9d64Fj3fNZI+kvkFQcF@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8ztWvI4ZoICzZ1BK7n0yoAQnpFbE/Qr0p/imiM0wsX6wMQak
	fszRANtr2w38twLslAeNA78+49tcxORZjZh/AOvuMOfr57S+GArA
X-Google-Smtp-Source: AGHT+IGAHNjFbNG2z1ZOkMjbrsnSdJKSDeeav2zSEsw1DEMCoPvWZ6DazVMAHkM/dAegoKIbRPMePw==
X-Received: by 2002:a17:903:228b:b0:20b:9379:f1f7 with SMTP id d9443c01a7336-211b5d29e0emr41563115ad.40.1731519194586;
        Wed, 13 Nov 2024 09:33:14 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7df5sm113140765ad.19.2024.11.13.09.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:33:12 -0800 (PST)
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
Subject: [PATCH net-next v5 4/7] net: ethtool: add support for configuring header-data-split-thresh
Date: Wed, 13 Nov 2024 17:32:18 +0000
Message-Id: <20241113173222.372128-5-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113173222.372128-1-ap420073@gmail.com>
References: <20241113173222.372128-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header-data-split-thresh option configures the threshold value of
the header-data-split.
If a received packet size is larger than this threshold value, a packet
will be split into header and payload.
The header indicates TCP and UDP header, but it depends on driver spec.
The bnxt_en driver supports HDS(Header-Data-Split) configuration at
FW level, affecting TCP and UDP too.
So, If header-data-split-thresh is set, it affects UDP and TCP packets.

Example:
   # ethtool -G <interface name> header-data-split-thresh <value>

   # ethtool -G enp14s0f0np0 tcp-data-split on header-data-split-thresh 256
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   Header data split thresh:  256
   Current hardware settings:
   ...
   TCP data split:         on
   Header data split thresh:  256

The default/min/max values are not defined in the ethtool so the drivers
should define themself.
The 0 value means that all TCP/UDP packets' header and payload
will be split.

In general cases, HDS can increase the overhead of host memory and PCIe
bus because it copies data twice.
So users should consider the overhead of HDS.
If the HDS threshold is 0 and then the copybreak is 256 and the packet's
payload is 8 bytes.
So, two pages are used, one for headers and one for payloads.
By the copybreak, only the headers page is copied and then it can be
reused immediately and then a payloads page is still used.
If the HDS threshold is larger than 8, both headers and payloads are
copied and then a page can be recycled immediately.
So, too low HDS threshold has larger disadvantages than advantages
aspect of performance in general cases.
Users should consider the overhead of this feature.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

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

 Documentation/netlink/specs/ethtool.yaml     |  8 ++
 Documentation/networking/ethtool-netlink.rst | 79 ++++++++++++--------
 include/linux/ethtool.h                      |  6 ++
 include/linux/netdevice.h                    |  1 +
 include/uapi/linux/ethtool_netlink.h         |  2 +
 net/core/dev.c                               | 13 ++++
 net/ethtool/netlink.h                        |  2 +-
 net/ethtool/rings.c                          | 37 ++++++++-
 8 files changed, 115 insertions(+), 33 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 93369f0eb816..edc07cc290da 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -220,6 +220,12 @@ attribute-sets:
       -
         name: tx-push-buf-len-max
         type: u32
+      -
+        name: header-data-split-thresh
+        type: u32
+      -
+        name: header-data-split-thresh-max
+        type: u32
 
   -
     name: mm-stat
@@ -1398,6 +1404,8 @@ operations:
             - rx-push
             - tx-push-buf-len
             - tx-push-buf-len-max
+            - header-data-split-thresh
+            - header-data-split-thresh-max
       dump: *ring-get-op
     -
       name: rings-set
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index b25926071ece..1fdfeca6f38e 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -878,24 +878,35 @@ Request contents:
 
 Kernel response contents:
 
-  =======================================   ======  ===========================
-  ``ETHTOOL_A_RINGS_HEADER``                nested  reply header
-  ``ETHTOOL_A_RINGS_RX_MAX``                u32     max size of RX ring
-  ``ETHTOOL_A_RINGS_RX_MINI_MAX``           u32     max size of RX mini ring
-  ``ETHTOOL_A_RINGS_RX_JUMBO_MAX``          u32     max size of RX jumbo ring
-  ``ETHTOOL_A_RINGS_TX_MAX``                u32     max size of TX ring
-  ``ETHTOOL_A_RINGS_RX``                    u32     size of RX ring
-  ``ETHTOOL_A_RINGS_RX_MINI``               u32     size of RX mini ring
-  ``ETHTOOL_A_RINGS_RX_JUMBO``              u32     size of RX jumbo ring
-  ``ETHTOOL_A_RINGS_TX``                    u32     size of TX ring
-  ``ETHTOOL_A_RINGS_RX_BUF_LEN``            u32     size of buffers on the ring
-  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``        u8      TCP header / data split
-  ``ETHTOOL_A_RINGS_CQE_SIZE``              u32     Size of TX/RX CQE
-  ``ETHTOOL_A_RINGS_TX_PUSH``               u8      flag of TX Push mode
-  ``ETHTOOL_A_RINGS_RX_PUSH``               u8      flag of RX Push mode
-  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``       u32     size of TX push buffer
-  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX``   u32     max size of TX push buffer
-  =======================================   ======  ===========================
+  ================================================  ======  ====================
+  ``ETHTOOL_A_RINGS_HEADER``                        nested  reply header
+  ``ETHTOOL_A_RINGS_RX_MAX``                        u32     max size of RX ring
+  ``ETHTOOL_A_RINGS_RX_MINI_MAX``                   u32     max size of RX mini
+                                                            ring
+  ``ETHTOOL_A_RINGS_RX_JUMBO_MAX``                  u32     max size of RX jumbo
+                                                            ring
+  ``ETHTOOL_A_RINGS_TX_MAX``                        u32     max size of TX ring
+  ``ETHTOOL_A_RINGS_RX``                            u32     size of RX ring
+  ``ETHTOOL_A_RINGS_RX_MINI``                       u32     size of RX mini ring
+  ``ETHTOOL_A_RINGS_RX_JUMBO``                      u32     size of RX jumbo
+                                                            ring
+  ``ETHTOOL_A_RINGS_TX``                            u32     size of TX ring
+  ``ETHTOOL_A_RINGS_RX_BUF_LEN``                    u32     size of buffers on
+                                                            the ring
+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``                u8      TCP header / data
+                                                            split
+  ``ETHTOOL_A_RINGS_CQE_SIZE``                      u32     Size of TX/RX CQE
+  ``ETHTOOL_A_RINGS_TX_PUSH``                       u8      flag of TX Push mode
+  ``ETHTOOL_A_RINGS_RX_PUSH``                       u8      flag of RX Push mode
+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``               u32     size of TX push
+                                                            buffer
+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX``           u32     max size of TX push
+                                                            buffer
+  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH``      u32     threshold of
+                                                            header / data split
+  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX``  u32     max threshold of
+                                                            header / data split
+  ================================================  ======  ====================
 
 ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT`` indicates whether the device is usable with
 page-flipping TCP zero-copy receive (``getsockopt(TCP_ZEROCOPY_RECEIVE)``).
@@ -930,18 +941,22 @@ Sets ring sizes like ``ETHTOOL_SRINGPARAM`` ioctl request.
 
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
+  ============================================  ======  =======================
+  ``ETHTOOL_A_RINGS_HEADER``                    nested  reply header
+  ``ETHTOOL_A_RINGS_RX``                        u32     size of RX ring
+  ``ETHTOOL_A_RINGS_RX_MINI``                   u32     size of RX mini ring
+  ``ETHTOOL_A_RINGS_RX_JUMBO``                  u32     size of RX jumbo ring
+  ``ETHTOOL_A_RINGS_TX``                        u32     size of TX ring
+  ``ETHTOOL_A_RINGS_RX_BUF_LEN``                u32     size of buffers on the
+                                                        ring
+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``            u8      TCP header / data split
+  ``ETHTOOL_A_RINGS_CQE_SIZE``                  u32     Size of TX/RX CQE
+  ``ETHTOOL_A_RINGS_TX_PUSH``                   u8      flag of TX Push mode
+  ``ETHTOOL_A_RINGS_RX_PUSH``                   u8      flag of RX Push mode
+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``           u32     size of TX push buffer
+  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH``  u32     threshold of
+                                                        header / data split
+  ============================================  ======  =======================
 
 Kernel checks that requested ring sizes do not exceed limits reported by
 driver. Driver may impose additional constraints and may not support all
@@ -957,6 +972,10 @@ A bigger CQE can have more receive buffer pointers, and in turn the NIC can
 transfer a bigger frame from wire. Based on the NIC hardware, the overall
 completion queue size can be adjusted in the driver if CQE size is modified.
 
+``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH`` specifies the threshold value of
+header / data split feature. If a received packet size is larger than this
+threshold value, header and data will be split.
+
 CHANNELS_GET
 ============
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index ecd52b99a63a..b4b6955d7ab9 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -79,6 +79,8 @@ enum {
  * @cqe_size: Size of TX/RX completion queue event
  * @tx_push_buf_len: Size of TX push buffer
  * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
+ * @hds_thresh: Threshold value of header-data-split-thresh
+ * @hds_thresh_max: Maximum allowed threshold of header-data-split-thresh
  */
 struct kernel_ethtool_ringparam {
 	u32	rx_buf_len;
@@ -89,6 +91,8 @@ struct kernel_ethtool_ringparam {
 	u32	cqe_size;
 	u32	tx_push_buf_len;
 	u32	tx_push_buf_max_len;
+	u32	hds_thresh;
+	u32	hds_thresh_max;
 };
 
 /**
@@ -99,6 +103,7 @@ struct kernel_ethtool_ringparam {
  * @ETHTOOL_RING_USE_RX_PUSH: capture for setting rx_push
  * @ETHTOOL_RING_USE_TX_PUSH_BUF_LEN: capture for setting tx_push_buf_len
  * @ETHTOOL_RING_USE_TCP_DATA_SPLIT: capture for setting tcp_data_split
+ * @ETHTOOL_RING_USE_HDS_THRS: capture for setting header-data-split-thresh
  */
 enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_RX_BUF_LEN		= BIT(0),
@@ -107,6 +112,7 @@ enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_RX_PUSH		= BIT(3),
 	ETHTOOL_RING_USE_TX_PUSH_BUF_LEN	= BIT(4),
 	ETHTOOL_RING_USE_TCP_DATA_SPLIT		= BIT(5),
+	ETHTOOL_RING_USE_HDS_THRS		= BIT(6),
 };
 
 #define __ETH_RSS_HASH_BIT(bit)	((u32)1 << (bit))
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0aae346d919e..0c29068577c4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4028,6 +4028,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
+u8 dev_xdp_sb_prog_count(struct net_device *dev);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 283305f6b063..7087c5c51017 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -364,6 +364,8 @@ enum {
 	ETHTOOL_A_RINGS_RX_PUSH,			/* u8 */
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,		/* u32 */
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,		/* u32 */
+	ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH,	/* u32 */
+	ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX,	/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_RINGS_CNT,
diff --git a/net/core/dev.c b/net/core/dev.c
index 13d00fc10f55..0321d7cbce0f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9474,6 +9474,19 @@ u8 dev_xdp_prog_count(struct net_device *dev)
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
index 203b08eb6c6f..9f51a252ebe0 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -455,7 +455,7 @@ extern const struct nla_policy ethnl_features_set_policy[ETHTOOL_A_FEATURES_WANT
 extern const struct nla_policy ethnl_privflags_get_policy[ETHTOOL_A_PRIVFLAGS_HEADER + 1];
 extern const struct nla_policy ethnl_privflags_set_policy[ETHTOOL_A_PRIVFLAGS_FLAGS + 1];
 extern const struct nla_policy ethnl_rings_get_policy[ETHTOOL_A_RINGS_HEADER + 1];
-extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX + 1];
+extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX + 1];
 extern const struct nla_policy ethnl_channels_get_policy[ETHTOOL_A_CHANNELS_HEADER + 1];
 extern const struct nla_policy ethnl_channels_set_policy[ETHTOOL_A_CHANNELS_COMBINED_COUNT + 1];
 extern const struct nla_policy ethnl_coalesce_get_policy[ETHTOOL_A_COALESCE_HEADER + 1];
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index c12ebb61394d..ca836aad3fa9 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -61,7 +61,11 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u8))  +	/* _RINGS_TX_PUSH */
 	       nla_total_size(sizeof(u8))) +	/* _RINGS_RX_PUSH */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN */
-	       nla_total_size(sizeof(u32));	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
+	       nla_total_size(sizeof(u32)) +
+	       /* _RINGS_HEADER_DATA_SPLIT_THRESH */
+	       nla_total_size(sizeof(u32));
+	       /* _RINGS_HEADER_DATA_SPLIT_THRESH_MAX*/
 }
 
 static int rings_fill_reply(struct sk_buff *skb,
@@ -108,7 +112,12 @@ static int rings_fill_reply(struct sk_buff *skb,
 	     (nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
 			  kr->tx_push_buf_max_len) ||
 	      nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
-			  kr->tx_push_buf_len))))
+			  kr->tx_push_buf_len))) ||
+	    ((supported_ring_params & ETHTOOL_RING_USE_HDS_THRS) &&
+	     (nla_put_u32(skb, ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH,
+			  kr->hds_thresh) ||
+	      nla_put_u32(skb, ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX,
+			  kr->hds_thresh_max))))
 		return -EMSGSIZE;
 
 	return 0;
@@ -130,6 +139,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_TX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_RX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]	= { .type = NLA_U32 },
+	[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH]	= { .type = NLA_U32 },
 };
 
 static int
@@ -155,6 +165,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
 		return -EOPNOTSUPP;
 	}
 
+	if (tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH] &&
+	    !(ops->supported_ring_params & ETHTOOL_RING_USE_HDS_THRS)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH],
+				    "setting header-data-split-thresh is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
 	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
@@ -222,9 +240,24 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 			tb[ETHTOOL_A_RINGS_RX_PUSH], &mod);
 	ethnl_update_u32(&kernel_ringparam.tx_push_buf_len,
 			 tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
+	ethnl_update_u32(&kernel_ringparam.hds_thresh,
+			 tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH], &mod);
 	if (!mod)
 		return 0;
 
+	if (kernel_ringparam.tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    dev_xdp_sb_prog_count(dev)) {
+		NL_SET_ERR_MSG(info->extack,
+			       "tcp-data-split can not be enabled with single buffer XDP");
+		return -EINVAL;
+	}
+
+	if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max) {
+		NL_SET_BAD_ATTR(info->extack,
+				tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX]);
+		return -ERANGE;
+	}
+
 	/* ensure new ring parameters are within limits */
 	if (ringparam.rx_pending > ringparam.rx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_RX];
-- 
2.34.1


