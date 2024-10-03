Return-Path: <netdev+bounces-131675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2F98F391
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6386B2827B7
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1451A4F25;
	Thu,  3 Oct 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRIRDp74"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31130145B1F;
	Thu,  3 Oct 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971622; cv=none; b=Clhst4cV4N7hKmnGBFDsl46BH1jJRzgRx9weVoP9ygHAMBc8zlCgN6R1uZtCrdtZ4KzpJXt7A1eGOBBfi813BTdELUbKozYpFPR+z8Wjg7hWKjmwqKCS4QNkxPudCBq36EknQu5oNSf6uL20uusF19AQG1mUgoUvPsIt7wC6HnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971622; c=relaxed/simple;
	bh=TYrrp4+fXsd603T661sXMxk71f8OLHQCKwGfYnBVUgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYap1KrETYqEkrzH30yWYSBsFuv0mdUOgpN3e8JNpM61vq3UE2jkIu2bO4U6M/hpbSNIGBOWvzVZ5Ew8QesA9IqNDzIbQsocRlELeZ9dLuOmJN0iSOzUeX0MEVa7rCAFOQYz9yLJtBKZ5ufEGM8086egc6Z+w2PohB2i4zwCwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRIRDp74; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b0b5cdb57so16168635ad.1;
        Thu, 03 Oct 2024 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971618; x=1728576418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq3GJkLw5Uy4hCUSonWNYYQStI5yWMbLaCyxN/9ygUc=;
        b=RRIRDp743ccD3+iuDzos4UMrAbtGLdAhS7NtmTmpvtRG2yqxyJgzuf/VO2oeIQtGWM
         oHrL//4OOu1oTUSeLU62EncmhIFXIN6snyh1BEyYPy9F562JCXjnbUJAi8MG4Uxm2p/z
         sFrrzypJIrweuun7UwTJCwck+V0eRvpEZpCY+5ZlzuL8DJXvBgs3yOIapCx4H0InQJi1
         ZTlrVYQuDxgL7NrOX1e//gUBvdHBn1WluIP9H61Im515Yi55EB+8JAYtJCQ9uYLVzNX7
         97vNgHLlmL0jUCJbqL1AlQ+QPKlrkLgui0CjolZiSqy/8meXbjw2J1RXoQ3uEA5+VoIT
         Eheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971618; x=1728576418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fq3GJkLw5Uy4hCUSonWNYYQStI5yWMbLaCyxN/9ygUc=;
        b=LTv2QHpwniPQjWPcuZWhBBqeQHhwI7ThHDFgzGzE58MjeapbKVn8zYmVVhzp6iVY4R
         Qb2Z1Bs9D7qArZ8KM4bT3ghHTmYaU90JJODzEMtEQ1EY3oIKmL619suCEwY8QF8sn4Io
         PgO+QkviO2fYmC79/6qANISjBezbH9UYA4U0KMr9rNgqejFb1hUOFPVodRRY4xOwIXfZ
         Ol6AahvENNSE4cHzcHVXxQAn1YjSQVbgbQc/lv//GKQGVECrOVzJ5cT5E7SfHJLSPsx1
         vOHHMJrR7v7AMk+fDBzq1/eZ3s24/qUx2OIdO6fEVBbTj52gmsAaQ2uM+AjZym/ON/f1
         kYPg==
X-Forwarded-Encrypted: i=1; AJvYcCV1d23ETZO0XEvitj6zdhAAoEHslECQWdBLxzytkp6cUjeMRkwcoMHc3NYHWIvZwK2yZKzYficOf10=@vger.kernel.org, AJvYcCWodnlW6AEoo7AGbpiKTIF2WTRgeNSFNO8jKI1+sV012d/Zut2GgYZeAaSeBZYW+M2MQQHvleLo@vger.kernel.org
X-Gm-Message-State: AOJu0YxsCv4VAeExEyC9m1o0hOI63qUiHZGkXcT0/jYrmsYwYeEANwGp
	bxjwJC9YjqYjqhGylO9yAvAfxXdPDxdmr5IEbO44KA05Y/rm7EHw
X-Google-Smtp-Source: AGHT+IFlMetfCalg1cSjT6oOoUcIoJEoH7BNTou9ObkVeJ4wj8mnMTaANI6c+K4Sf3PADLe700fMaQ==
X-Received: by 2002:a17:902:da81:b0:20b:a8ad:9b0c with SMTP id d9443c01a7336-20be18c544amr60852385ad.3.1727971618108;
        Thu, 03 Oct 2024 09:06:58 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef7071f1sm10425435ad.292.2024.10.03.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:06:57 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com
Cc: kory.maincent@bootlin.com,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	asml.silence@gmail.com,
	kaiyuanz@google.com,
	willemb@google.com,
	aleksander.lobakin@intel.com,
	dw@davidwei.uk,
	sridhar.samudrala@intel.com,
	bcreeley@amd.com,
	ap420073@gmail.com
Subject: [PATCH net-next v3 3/7] net: ethtool: add support for configuring tcp-data-split-thresh
Date: Thu,  3 Oct 2024 16:06:16 +0000
Message-Id: <20241003160620.1521626-4-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003160620.1521626-1-ap420073@gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
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
   TCP data split thresh:  256
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
   TCP data split thresh:  256
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

v3:
 - Fix documentation and ynl
 - Update error messages
 - Validate configuration of tcp-data-split and tcp-data-split-thresh

v2:
 - Patch added.

 Documentation/netlink/specs/ethtool.yaml     |  8 +++
 Documentation/networking/ethtool-netlink.rst | 75 ++++++++++++--------
 include/linux/ethtool.h                      |  4 ++
 include/uapi/linux/ethtool_netlink.h         |  2 +
 net/ethtool/netlink.h                        |  2 +-
 net/ethtool/rings.c                          | 46 ++++++++++--
 6 files changed, 102 insertions(+), 35 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 6a050d755b9c..96298fe5ed43 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -215,6 +215,12 @@ attribute-sets:
       -
         name: tx-push-buf-len-max
         type: u32
+      -
+        name: tcp-data-split-thresh
+        type: u32
+      -
+        name: tcp-data-split-thresh-max
+        type: u32
 
   -
     name: mm-stat
@@ -1393,6 +1399,8 @@ operations:
             - rx-push
             - tx-push-buf-len
             - tx-push-buf-len-max
+            - tcp-data-split-thresh
+            - tcp-data-split-thresh-max
       dump: *ring-get-op
     -
       name: rings-set
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 295563e91082..f0cd918dbe7e 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -875,24 +875,32 @@ Request contents:
 
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
+  =============================================  ======  =======================
+  ``ETHTOOL_A_RINGS_HEADER``                     nested  reply header
+  ``ETHTOOL_A_RINGS_RX_MAX``                     u32     max size of RX ring
+  ``ETHTOOL_A_RINGS_RX_MINI_MAX``                u32     max size of RX mini
+                                                         ring
+  ``ETHTOOL_A_RINGS_RX_JUMBO_MAX``               u32     max size of RX jumbo
+                                                         ring
+  ``ETHTOOL_A_RINGS_TX_MAX``                     u32     max size of TX ring
+  ``ETHTOOL_A_RINGS_RX``                         u32     size of RX ring
+  ``ETHTOOL_A_RINGS_RX_MINI``                    u32     size of RX mini ring
+  ``ETHTOOL_A_RINGS_RX_JUMBO``                   u32     size of RX jumbo ring
+  ``ETHTOOL_A_RINGS_TX``                         u32     size of TX ring
+  ``ETHTOOL_A_RINGS_RX_BUF_LEN``                 u32     size of buffers on the
+                                                         ring
+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``             u8      TCP header / data split
+  ``ETHTOOL_A_RINGS_CQE_SIZE``                   u32     Size of TX/RX CQE
+  ``ETHTOOL_A_RINGS_TX_PUSH``                    u8      flag of TX Push mode
+  ``ETHTOOL_A_RINGS_RX_PUSH``                    u8      flag of RX Push mode
+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``            u32     size of TX push buffer
+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX``        u32     max size of TX push
+                                                         buffer
+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH``      u32     threshold of
+                                                         TCP header / data split
+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH_MAX``  u32     max threshold of
+                                                         TCP header / data split
+  =============================================  ======  =======================
 
 ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT`` indicates whether the device is usable with
 page-flipping TCP zero-copy receive (``getsockopt(TCP_ZEROCOPY_RECEIVE)``).
@@ -927,18 +935,21 @@ Sets ring sizes like ``ETHTOOL_SRINGPARAM`` ioctl request.
 
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
+  =========================================  ======  =======================
+  ``ETHTOOL_A_RINGS_HEADER``                 nested  reply header
+  ``ETHTOOL_A_RINGS_RX``                     u32     size of RX ring
+  ``ETHTOOL_A_RINGS_RX_MINI``                u32     size of RX mini ring
+  ``ETHTOOL_A_RINGS_RX_JUMBO``               u32     size of RX jumbo ring
+  ``ETHTOOL_A_RINGS_TX``                     u32     size of TX ring
+  ``ETHTOOL_A_RINGS_RX_BUF_LEN``             u32     size of buffers on the ring
+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``         u8      TCP header / data split
+  ``ETHTOOL_A_RINGS_CQE_SIZE``               u32     Size of TX/RX CQE
+  ``ETHTOOL_A_RINGS_TX_PUSH``                u8      flag of TX Push mode
+  ``ETHTOOL_A_RINGS_RX_PUSH``                u8      flag of RX Push mode
+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``        u32     size of TX push buffer
+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH``  u32     threshold of
+                                                     TCP header / data split
+  =========================================  ======  =======================
 
 Kernel checks that requested ring sizes do not exceed limits reported by
 driver. Driver may impose additional constraints and may not support all
@@ -954,6 +965,10 @@ A bigger CQE can have more receive buffer pointers, and in turn the NIC can
 transfer a bigger frame from wire. Based on the NIC hardware, the overall
 completion queue size can be adjusted in the driver if CQE size is modified.
 
+``ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH`` specifies the threshold value of
+tcp data split feature. If tcp-data-split is enabled and a received packet
+size is larger than this threshold value, header and data will be split.
+
 CHANNELS_GET
 ============
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 12f6dc567598..891f55b0f6aa 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -78,6 +78,8 @@ enum {
  * @cqe_size: Size of TX/RX completion queue event
  * @tx_push_buf_len: Size of TX push buffer
  * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
+ * @tcp_data_split_thresh: Threshold value of tcp-data-split
+ * @tcp_data_split_thresh_max: Maximum allowed threshold of tcp-data-split-threshold
  */
 struct kernel_ethtool_ringparam {
 	u32	rx_buf_len;
@@ -87,6 +89,8 @@ struct kernel_ethtool_ringparam {
 	u32	cqe_size;
 	u32	tx_push_buf_len;
 	u32	tx_push_buf_max_len;
+	u32	tcp_data_split_thresh;
+	u32	tcp_data_split_thresh_max;
 };
 
 /**
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 283305f6b063..20fe6065b7ba 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -364,6 +364,8 @@ enum {
 	ETHTOOL_A_RINGS_RX_PUSH,			/* u8 */
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,		/* u32 */
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,		/* u32 */
+	ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH,		/* u32 */
+	ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH_MAX,	/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_RINGS_CNT,
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 203b08eb6c6f..8bea47a26605 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -455,7 +455,7 @@ extern const struct nla_policy ethnl_features_set_policy[ETHTOOL_A_FEATURES_WANT
 extern const struct nla_policy ethnl_privflags_get_policy[ETHTOOL_A_PRIVFLAGS_HEADER + 1];
 extern const struct nla_policy ethnl_privflags_set_policy[ETHTOOL_A_PRIVFLAGS_FLAGS + 1];
 extern const struct nla_policy ethnl_rings_get_policy[ETHTOOL_A_RINGS_HEADER + 1];
-extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX + 1];
+extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH_MAX + 1];
 extern const struct nla_policy ethnl_channels_get_policy[ETHTOOL_A_CHANNELS_HEADER + 1];
 extern const struct nla_policy ethnl_channels_set_policy[ETHTOOL_A_CHANNELS_COMBINED_COUNT + 1];
 extern const struct nla_policy ethnl_coalesce_get_policy[ETHTOOL_A_COALESCE_HEADER + 1];
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index b7865a14fdf8..c7824515857f 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -61,7 +61,9 @@ static int rings_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u8))  +	/* _RINGS_TX_PUSH */
 	       nla_total_size(sizeof(u8))) +	/* _RINGS_RX_PUSH */
 	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN */
-	       nla_total_size(sizeof(u32));	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_TX_PUSH_BUF_LEN_MAX */
+	       nla_total_size(sizeof(u32)) +	/* _RINGS_TCP_DATA_SPLIT_THRESH */
+	       nla_total_size(sizeof(u32));	/* _RINGS_TCP_DATA_SPLIT_THRESH_MAX */
 }
 
 static int rings_fill_reply(struct sk_buff *skb,
@@ -108,7 +110,13 @@ static int rings_fill_reply(struct sk_buff *skb,
 	     (nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
 			  kr->tx_push_buf_max_len) ||
 	      nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
-			  kr->tx_push_buf_len))))
+			  kr->tx_push_buf_len))) ||
+	    (kr->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	     (nla_put_u32(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH,
+			 kr->tcp_data_split_thresh))) ||
+	    (kr->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	     (nla_put_u32(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH_MAX,
+			 kr->tcp_data_split_thresh_max))))
 		return -EMSGSIZE;
 
 	return 0;
@@ -130,6 +138,7 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_TX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_RX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]	= { .type = NLA_U32 },
+	[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH]	= { .type = NLA_U32 },
 };
 
 static int
@@ -155,6 +164,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
 		return -EOPNOTSUPP;
 	}
 
+	if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH] &&
+	    !(ops->supported_ring_params & ETHTOOL_RING_USE_TCP_DATA_SPLIT)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH],
+				    "setting tcp-data-split-thresh is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
 	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
@@ -196,9 +213,9 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct kernel_ethtool_ringparam kernel_ringparam = {};
 	struct ethtool_ringparam ringparam = {};
 	struct net_device *dev = req_info->dev;
+	bool mod = false, thresh_mod = false;
 	struct nlattr **tb = info->attrs;
 	const struct nlattr *err_attr;
-	bool mod = false;
 	int ret;
 
 	dev->ethtool_ops->get_ringparam(dev, &ringparam,
@@ -222,9 +239,30 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
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
+	if (kernel_ringparam.tcp_data_split_thresh >
+	    kernel_ringparam.tcp_data_split_thresh_max) {
+		NL_SET_ERR_MSG_ATTR_FMT(info->extack,
+					tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH_MAX],
+					"Requested tcp-data-split-thresh exceeds the maximum of %u",
+					kernel_ringparam.tcp_data_split_thresh_max);
+
+		return -EINVAL;
+	}
+
 	/* ensure new ring parameters are within limits */
 	if (ringparam.rx_pending > ringparam.rx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_RX];
-- 
2.34.1


