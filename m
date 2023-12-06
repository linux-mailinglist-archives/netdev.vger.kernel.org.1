Return-Path: <netdev+bounces-54664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2258B807C66
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 00:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7C91F21A29
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2404D2E408;
	Wed,  6 Dec 2023 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cxr6+3pa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048A2A9;
	Wed,  6 Dec 2023 15:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701905847; x=1733441847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AzkDd6wnsuvzcAZzQAjf9CrhWtFrSY3UhJyph3FWwyo=;
  b=Cxr6+3paRh1SwacelJdQF4o2tQngsJ263IuhV6ej3DK/NL2oMAobtE6k
   0MqrN4IK/vRLTDeDvjqVsxj6ScCBWh8D8fTlurZWJNiPBE4aRYAcWFaXf
   em9KGg5SY3sOx2ZDaQrXZY+39+LBn7fr7q/2kjXwzVCrc6xk4jy0MFFCd
   dt5b5ruxwnTgiAK4/dAJBB8HfnH1bbgn5O/6gV1vg3GcVw+gkGM8eRLxD
   4DjPMFOhfgyJ2hVkCM3rz201exSZgchdbaX74UgFaJTcWpc8S2gNDswPm
   RCUaE0pI9iTEz6DpOM+MFrF9E0pJYuHZTNicd/VX6jPd1Wes9hKrqTneA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="379163869"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="379163869"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 15:37:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="771486515"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="771486515"
Received: from traguzov-mobl4.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.62.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 15:37:19 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	andrew@lunn.ch,
	horms@kernel.org,
	mkubecek@suse.cz,
	willemdebruijn.kernel@gmail.com,
	gal@nvidia.com,
	alexander.duyck@gmail.com,
	ecree.xilinx@gmail.com,
	linux-doc@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net-next v8 3/8] net: ethtool: add support for symmetric-xor RSS hash
Date: Wed,  6 Dec 2023 16:36:37 -0700
Message-Id: <20231206233642.447794-4-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206233642.447794-1-ahmed.zaki@intel.com>
References: <20231206233642.447794-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Symmetric RSS hash functions are beneficial in applications that monitor
both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
Getting all traffic of the same flow on the same RX queue results in
higher CPU cache efficiency.

A NIC that supports "symmetric-xor" can achieve this RSS hash symmetry
by XORing the source and destination fields and pass the values to the
RSS hash algorithm.

The user may request RSS hash symmetry for a specific algorithm, via:

    # ethtool -X eth0 hfunc <hash_alg> symmetric-xor

or turn symmetry off (asymmetric) by:

    # ethtool -X eth0 hfunc <hash_alg>

The specific fields for each flow type should then be specified as usual
via:
    # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 Documentation/netlink/specs/ethtool.yaml     |  4 +++
 Documentation/networking/ethtool-netlink.rst |  6 +++-
 Documentation/networking/scaling.rst         | 15 ++++++++++
 include/linux/ethtool.h                      |  6 ++++
 include/uapi/linux/ethtool.h                 | 13 ++++++++-
 include/uapi/linux/ethtool_netlink.h         |  1 +
 net/ethtool/ioctl.c                          | 30 +++++++++++++++++---
 net/ethtool/rss.c                            |  5 ++++
 8 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 5c7a65b009b4..197208f419dc 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -908,6 +908,9 @@ attribute-sets:
       -
         name: hkey
         type: binary
+      -
+        name: input_xfrm
+        type: u32
   -
     name: plca
     attributes:
@@ -1598,6 +1601,7 @@ operations:
             - hfunc
             - indir
             - hkey
+            - input_xfrm
       dump: *rss-get-op
     -
       name: plca-get-cfg
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 6a49624a9cbf..d583d9abf2f8 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1774,12 +1774,16 @@ Kernel response contents:
   ``ETHTOOL_A_RSS_HFUNC``              u32     RSS hash func
   ``ETHTOOL_A_RSS_INDIR``              binary  Indir table bytes
   ``ETHTOOL_A_RSS_HKEY``               binary  Hash key bytes
+  ``ETHTOOL_A_RSS_INPUT_XFRM``         u32     RSS input data transformation
 =====================================  ======  ==========================
 
 ETHTOOL_A_RSS_HFUNC attribute is bitmap indicating the hash function
 being used. Current supported options are toeplitz, xor or crc32.
-ETHTOOL_A_RSS_INDIR attribute returns RSS indrection table where each byte
+ETHTOOL_A_RSS_INDIR attribute returns RSS indirection table where each byte
 indicates queue number.
+ETHTOOL_A_RSS_INPUT_XFRM attribute is a bitmap indicating the type of
+transformation applied to the input protocol fields before given to the RSS
+hfunc. Current supported option is symmetric-xor.
 
 PLCA_GET_CFG
 ============
diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 03ae19a689fc..4eb50bcb9d42 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -44,6 +44,21 @@ by masking out the low order seven bits of the computed hash for the
 packet (usually a Toeplitz hash), taking this number as a key into the
 indirection table and reading the corresponding value.
 
+Some NICs support symmetric RSS hashing where, if the IP (source address,
+destination address) and TCP/UDP (source port, destination port) tuples
+are swapped, the computed hash is the same. This is beneficial in some
+applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and need
+both directions of the flow to land on the same Rx queue (and CPU). The
+"Symmetric-XOR" is a type of RSS algorithms that achieves this hash
+symmetry by XORing the input source and destination fields of the IP
+and/or L4 protocols. This, however, results in reduced input entropy and
+could potentially be exploited. Specifically, the algorithm XORs the input
+as follows::
+
+    # (SRC_IP ^ DST_IP, SRC_IP ^ DST_IP, SRC_PORT ^ DST_PORT, SRC_PORT ^ DST_PORT)
+
+The result is then fed to the underlying RSS algorithm.
+
 Some advanced NICs allow steering packets to queues based on
 programmable filters. For example, webserver bound TCP port 80 packets
 can be directed to their own receive queue. Such “n-tuple” filters can
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 16176903bf09..ca8438934ecc 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -613,6 +613,8 @@ struct ethtool_mm_stats {
  *	to allocate a new RSS context; on return this field will
  *	contain the ID of the newly allocated context.
  * @rss_delete: Set to non-ZERO to remove the @rss_context context.
+ * @input_xfrm: Defines how the input data is transformed. Valid values are one
+ *	of %RXH_XFRM_*.
  */
 struct ethtool_rxfh_param {
 	__u8	hfunc;
@@ -622,6 +624,7 @@ struct ethtool_rxfh_param {
 	__u8	*key;
 	__u32	rss_context;
 	__u8	rss_delete;
+	__u8	input_xfrm;
 };
 
 /**
@@ -630,6 +633,8 @@ struct ethtool_rxfh_param {
  *	parameter.
  * @cap_rss_ctx_supported: indicates if the driver supports RSS
  *	contexts.
+ * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
+ *	RSS.
  * @supported_coalesce_params: supported types of interrupt coalescing.
  * @supported_ring_params: supported ring params.
  * @get_drvinfo: Report driver/device information. Modern drivers no
@@ -809,6 +814,7 @@ struct ethtool_rxfh_param {
 struct ethtool_ops {
 	u32     cap_link_lanes_supported:1;
 	u32     cap_rss_ctx_supported:1;
+	u32	cap_rss_sym_xor_supported:1;
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..0787d561ace0 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1266,6 +1266,8 @@ struct ethtool_rxfh_indir {
  *	hardware hash key.
  * @hfunc: Defines the current RSS hash function used by HW (or to be set to).
  *	Valid values are one of the %ETH_RSS_HASH_*.
+ * @input_xfrm: Defines how the input data is transformed. Valid values are one
+ *	of %RXH_XFRM_*.
  * @rsvd8: Reserved for future use; see the note on reserved space.
  * @rsvd32: Reserved for future use; see the note on reserved space.
  * @rss_config: RX ring/queue index for each hash value i.e., indirection table
@@ -1285,7 +1287,8 @@ struct ethtool_rxfh {
 	__u32   indir_size;
 	__u32   key_size;
 	__u8	hfunc;
-	__u8	rsvd8[3];
+	__u8	input_xfrm;
+	__u8	rsvd8[2];
 	__u32	rsvd32;
 	__u32   rss_config[];
 };
@@ -1992,6 +1995,14 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 
 #define WOL_MODE_COUNT		8
 
+/* RSS hash function data
+ * XOR the corresponding source and destination fields of each specified
+ * protocol. Both copies of the XOR'ed fields are fed into the RSS and RXHASH
+ * calculation. Note that this XORing reduces the input set entropy and could
+ * be exploited to reduce the RSS queue spread.
+ */
+#define	RXH_XFRM_SYM_XOR	(1 << 0)
+
 /* L2-L4 network traffic flow types */
 #define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
 #define	UDP_V4_FLOW	0x02	/* hash or spec (udp_ip4_spec) */
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 73e2c10dc2cc..3f89074aa06c 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -908,6 +908,7 @@ enum {
 	ETHTOOL_A_RSS_HFUNC,		/* u32 */
 	ETHTOOL_A_RSS_INDIR,		/* binary */
 	ETHTOOL_A_RSS_HKEY,		/* binary */
+	ETHTOOL_A_RSS_INPUT_XFRM,	/* u32 */
 
 	__ETHTOOL_A_RSS_CNT,
 	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1),
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index e0506a4d5115..02c1be04f303 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -972,18 +972,35 @@ static int ethtool_rxnfc_copy_to_user(void __user *useraddr,
 static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxfh_param rxfh;
 	struct ethtool_rxnfc info;
 	size_t info_size = sizeof(info);
 	int rc;
 
-	if (!dev->ethtool_ops->set_rxnfc)
+	if (!ops->set_rxnfc || !ops->get_rxfh)
 		return -EOPNOTSUPP;
 
 	rc = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (rc)
 		return rc;
 
-	rc = dev->ethtool_ops->set_rxnfc(dev, &info);
+	rc = ops->get_rxfh(dev, &rxfh);
+	if (rc)
+		return rc;
+
+	/* Sanity check: if symmetric-xor is set, then:
+	 * 1 - no other fields besides IP src/dst and/or L4 src/dst
+	 * 2 - If src is set, dst must also be set
+	 */
+	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
+	    ((info.data & ~(RXH_IP_SRC | RXH_IP_DST |
+			    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
+	     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
+	     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
+		return -EINVAL;
+
+	rc = ops->set_rxnfc(dev, &info);
 	if (rc)
 		return rc;
 
@@ -1196,7 +1213,7 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	user_key_size = rxfh.key_size;
 
 	/* Check that reserved fields are 0 for now */
-	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd8[2] || rxfh.rsvd32)
+	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
 	if (rxfh.rss_context && !ops->cap_rss_ctx_supported)
@@ -1279,11 +1296,15 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		return -EFAULT;
 
 	/* Check that reserved fields are 0 for now */
-	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd8[2] || rxfh.rsvd32)
+	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
 	if (rxfh.rss_context && !ops->cap_rss_ctx_supported)
 		return -EOPNOTSUPP;
+	/* Check input data transformation capabilities */
+	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
+	    !ops->cap_rss_sym_xor_supported)
+		return -EOPNOTSUPP;
 
 	/* If either indir, hash key or function is valid, proceed further.
 	 * Must request at least one change: indir size, hash key or function.
@@ -1351,6 +1372,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	rxfh_dev.indir_size = rxfh.indir_size;
 	rxfh_dev.key_size = rxfh.key_size;
 	rxfh_dev.rss_context = rxfh.rss_context;
+	rxfh_dev.input_xfrm = rxfh.input_xfrm;
 
 	ret = ops->set_rxfh(dev, &rxfh_dev, extack);
 	if (ret)
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index ea3fe0d3fe1c..5841543671da 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -13,6 +13,7 @@ struct rss_reply_data {
 	u32				indir_size;
 	u32				hkey_size;
 	u32				hfunc;
+	u32				input_xfrm;
 	u32				*indir_table;
 	u8				*hkey;
 };
@@ -105,6 +106,7 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 		goto out_ops;
 
 	data->hfunc = rxfh.hfunc;
+	data->input_xfrm = rxfh.input_xfrm;
 out_ops:
 	ethnl_ops_complete(dev);
 	return ret;
@@ -118,6 +120,7 @@ rss_reply_size(const struct ethnl_req_info *req_base,
 	int len;
 
 	len = nla_total_size(sizeof(u32)) +	/* _RSS_HFUNC */
+	      nla_total_size(sizeof(u32)) +	/* _RSS_INPUT_XFRM */
 	      nla_total_size(sizeof(u32) * data->indir_size) + /* _RSS_INDIR */
 	      nla_total_size(data->hkey_size);	/* _RSS_HKEY */
 
@@ -132,6 +135,8 @@ rss_fill_reply(struct sk_buff *skb, const struct ethnl_req_info *req_base,
 
 	if ((data->hfunc &&
 	     nla_put_u32(skb, ETHTOOL_A_RSS_HFUNC, data->hfunc)) ||
+	    (data->input_xfrm &&
+	     nla_put_u32(skb, ETHTOOL_A_RSS_INPUT_XFRM, data->input_xfrm)) ||
 	    (data->indir_size &&
 	     nla_put(skb, ETHTOOL_A_RSS_INDIR,
 		     sizeof(u32) * data->indir_size, data->indir_table)) ||
-- 
2.34.1


