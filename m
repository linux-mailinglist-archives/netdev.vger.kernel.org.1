Return-Path: <netdev+bounces-137951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E99AB3D1
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C0AB22526
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577801B5EB0;
	Tue, 22 Oct 2024 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbY2HkdS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513E11A4F2B;
	Tue, 22 Oct 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614285; cv=none; b=bHLVKHPLv29G7dBnhkDH1JBGi0W72rfz+Yehkdwd+54DgFN3j8GkVwFALqfUSAP3f2YUZPBXyZPZZX2W89BBR8MRjCFq7wwdO+VEk8mw7mFRko0vach75/jWw+nkUoYIa36vXFxDq60LROT1lk5LArcoMZWhQ/jrVtIfk+FkmmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614285; c=relaxed/simple;
	bh=YAkWNxLfVx3DPN2lOyBn8ML3qfSxLypx22iOrW0ydbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HkZF5nmRiX6X225bJl+Ub30juHY7AQpenE3HwZcteJtVn3dskVAy6xgqiNgWIz/Ke+UAYkYvflNFF9SgYRQK3bT03OtBBqYpbcLVidjjbX0u3qFXDpXEmiAcTF8vqnO7Fy9FfSLDBeS2syUjlBjT/TRhy3Zg5Uq4RW/lvafX4RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbY2HkdS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c805a0753so50642625ad.0;
        Tue, 22 Oct 2024 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729614283; x=1730219083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYlVqdo4GUp2p48MbqkwL3zlzRrPB+OcWMkizOryOV8=;
        b=FbY2HkdS/6/ZJdzp1eNEqMCVsJn2HKPMSWLoatHasG070JmYDEtDxdTGWz5wdlRoBX
         x/Cuj+z3lHj/4XcmNcx+ltb18HvfqRTu1S3fsqowPzdXe47Ygru7OiOzbyR5V/er5kSf
         EdNqcEswBjlVgiU9QLahYaQCs2EUSIxJU+tWa90EvyywUB8+zbtgQ7DlrOB8tsWSoPC7
         P0iccL1IlWcbH9co0RYNbb2xFGB0glHlJz9vj8x58OfCkcAhMrO7ZES2SGFNnIz0Z4ib
         tETC1DShDylelc8aqWHp/0BkH0RKP/x36zww2b1Nb2tZY+UH2WQ9oJTpi/lhDi9EIMyQ
         4ATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614283; x=1730219083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYlVqdo4GUp2p48MbqkwL3zlzRrPB+OcWMkizOryOV8=;
        b=oRBwKn9DNk6rEBrftwIEDcXVisGkuob4m0ZRAShOPGKMyytk19h3/ySwGnVHFTry1+
         deLU4fSn+ipUDrJQRzu3j3Gf5gcz8bPlefIltiuEZnaWfbnIup5hx0r8tVAOZGkz8Fos
         dN76eYGL2S3gUVlCfj+Jf41IIK87PWR7F34c6s/AVUwwxHCOfkY9fcDMUkauOE7VRd6p
         XBHpy6dLboQWg2GEVl042KI7QP1MBb/KStJ4ZQHrtX9Uet+dq+JbEPRS0kRlf3nYJ9JE
         YpPmk7CUECkmOYb3Ccb6TNlensOsS7XnXKLlBojesdQMZDbOu8djPKFZ35t453nIlBlP
         JUsA==
X-Forwarded-Encrypted: i=1; AJvYcCXDEA53STBK0nkhOGU31XbqYIlM7FUbM8IPV42wVIDkZz5o72s31sIfeGeYR80cr9UYu0wGUKdf@vger.kernel.org, AJvYcCXKhCcZj9zjX4za2HIiPzZGlRl5oRL+iXMjDALpghfx75O7sV1bXMY/328c8yXncyj0pe5mUSQsyWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTdUUDeCk70P80X37njywO2L+c+R9NibecZKBANnXG5WjHvlHk
	+RlEQT6bCeO47ABdbOclxoR4NKoAU6qLMzTkdUxlztw4CLiCWsXI
X-Google-Smtp-Source: AGHT+IFgA38cNs/SIjPZSTF+cHJzYs3S/NwilgQECeiS9dBMMQSyU8FvhA6y5IOEosgq0RLvVMZJag==
X-Received: by 2002:a17:903:98e:b0:20c:f648:e3a3 with SMTP id d9443c01a7336-20e5a94ca09mr185315185ad.60.1729614282455;
        Tue, 22 Oct 2024 09:24:42 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee6602sm44755205ad.1.2024.10.22.09.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:24:41 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/8] net: ethtool: add support for configuring header-data-split-thresh
Date: Tue, 22 Oct 2024 16:23:54 +0000
Message-Id: <20241022162359.2713094-4-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022162359.2713094-1-ap420073@gmail.com>
References: <20241022162359.2713094-1-ap420073@gmail.com>
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
index 6a050d755b9c..3e1f54324cbc 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -215,6 +215,12 @@ attribute-sets:
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
@@ -1393,6 +1399,8 @@ operations:
             - rx-push
             - tx-push-buf-len
             - tx-push-buf-len-max
+            - header-data-split-thresh
+            - header-data-split-thresh-max
       dump: *ring-get-op
     -
       name: rings-set
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 295563e91082..513eb1517f53 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -875,24 +875,35 @@ Request contents:
 
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
@@ -927,18 +938,22 @@ Sets ring sizes like ``ETHTOOL_SRINGPARAM`` ioctl request.
 
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
@@ -954,6 +969,10 @@ A bigger CQE can have more receive buffer pointers, and in turn the NIC can
 transfer a bigger frame from wire. Based on the NIC hardware, the overall
 completion queue size can be adjusted in the driver if CQE size is modified.
 
+``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH`` specifies the threshold value of
+header / data split feature. If a received packet size is larger than this
+threshold value, header and data will be split.
+
 CHANNELS_GET
 ============
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 12f6dc567598..021fd21f3914 100644
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
index 8feaca12655e..e155b767a08d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4010,6 +4010,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
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
index c682173a7642..890cd2bd0864 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9431,6 +9431,19 @@ u8 dev_xdp_prog_count(struct net_device *dev)
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
index b7865a14fdf8..e1fd82a91014 100644
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


