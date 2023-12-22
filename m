Return-Path: <netdev+bounces-59974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D881CF78
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 22:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DBFDB23D79
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 21:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1892E844;
	Fri, 22 Dec 2023 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="xX5CWfdS"
X-Original-To: netdev@vger.kernel.org
Received: from mx28lb.world4you.com (mx28lb.world4you.com [81.19.149.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A182C1A6
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jqe31zS8wVGzlLRYsTgGcBK2e/13ArsV4DbPfcoOQcA=; b=xX5CWfdSmHWPLumLPhgwbTsGRt
	CQjuDACZHKjVMlW03PttLOSxu4IHrkk931pqdQouFfOw+ODSTMmWsZAnB1uhWbdL9m9OEHoipDPH/
	AjJUk+CpdRkyDcbFB/7b5Drf9fR2KVxsAFP5Ldx3/SXBYb9am6yZ3IJ9h5d3CICbi3tU=;
Received: from [88.117.59.246] (helo=hornet.engleder.at)
	by mx28lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rGmcv-00068a-2f;
	Fri, 22 Dec 2023 22:00:13 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: ahmed.zaki@intel.com,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next] Revert "net: ethtool: add support for symmetric-xor RSS hash"
Date: Fri, 22 Dec 2023 22:00:00 +0100
Message-Id: <20231222210000.51989-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

This reverts commit 13e59344fb9d3c9d3acd138ae320b5b67b658694.

The tsnep driver and at least also the macb driver implement the ethtool
operation set_rxnfc but not the get_rxfh operation. With this commit
set_rxnfc returns -EOPNOTSUPP if get_rxfh is not implemented. This renders
set_rxnfc unuseable for drivers without get_rxfh.

Make set_rxfnc working again for drivers without get_rxfh by reverting
that commit.

Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 Documentation/netlink/specs/ethtool.yaml     |  4 ---
 Documentation/networking/ethtool-netlink.rst |  6 +---
 Documentation/networking/scaling.rst         | 15 ----------
 include/linux/ethtool.h                      |  6 ----
 include/uapi/linux/ethtool.h                 | 13 +--------
 include/uapi/linux/ethtool_netlink.h         |  1 -
 net/ethtool/ioctl.c                          | 30 +++-----------------
 net/ethtool/rss.c                            |  5 ----
 8 files changed, 6 insertions(+), 74 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 197208f419dc..5c7a65b009b4 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -908,9 +908,6 @@ attribute-sets:
       -
         name: hkey
         type: binary
-      -
-        name: input_xfrm
-        type: u32
   -
     name: plca
     attributes:
@@ -1601,7 +1598,6 @@ operations:
             - hfunc
             - indir
             - hkey
-            - input_xfrm
       dump: *rss-get-op
     -
       name: plca-get-cfg
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d583d9abf2f8..6a49624a9cbf 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1774,16 +1774,12 @@ Kernel response contents:
   ``ETHTOOL_A_RSS_HFUNC``              u32     RSS hash func
   ``ETHTOOL_A_RSS_INDIR``              binary  Indir table bytes
   ``ETHTOOL_A_RSS_HKEY``               binary  Hash key bytes
-  ``ETHTOOL_A_RSS_INPUT_XFRM``         u32     RSS input data transformation
 =====================================  ======  ==========================
 
 ETHTOOL_A_RSS_HFUNC attribute is bitmap indicating the hash function
 being used. Current supported options are toeplitz, xor or crc32.
-ETHTOOL_A_RSS_INDIR attribute returns RSS indirection table where each byte
+ETHTOOL_A_RSS_INDIR attribute returns RSS indrection table where each byte
 indicates queue number.
-ETHTOOL_A_RSS_INPUT_XFRM attribute is a bitmap indicating the type of
-transformation applied to the input protocol fields before given to the RSS
-hfunc. Current supported option is symmetric-xor.
 
 PLCA_GET_CFG
 ============
diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 4eb50bcb9d42..03ae19a689fc 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -44,21 +44,6 @@ by masking out the low order seven bits of the computed hash for the
 packet (usually a Toeplitz hash), taking this number as a key into the
 indirection table and reading the corresponding value.
 
-Some NICs support symmetric RSS hashing where, if the IP (source address,
-destination address) and TCP/UDP (source port, destination port) tuples
-are swapped, the computed hash is the same. This is beneficial in some
-applications that monitor TCP/IP flows (IDS, firewalls, ...etc) and need
-both directions of the flow to land on the same Rx queue (and CPU). The
-"Symmetric-XOR" is a type of RSS algorithms that achieves this hash
-symmetry by XORing the input source and destination fields of the IP
-and/or L4 protocols. This, however, results in reduced input entropy and
-could potentially be exploited. Specifically, the algorithm XORs the input
-as follows::
-
-    # (SRC_IP ^ DST_IP, SRC_IP ^ DST_IP, SRC_PORT ^ DST_PORT, SRC_PORT ^ DST_PORT)
-
-The result is then fed to the underlying RSS algorithm.
-
 Some advanced NICs allow steering packets to queues based on
 programmable filters. For example, webserver bound TCP port 80 packets
 can be directed to their own receive queue. Such “n-tuple” filters can
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index cfcd952a1d4f..66fe254c3e51 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -615,8 +615,6 @@ struct ethtool_mm_stats {
  *	to allocate a new RSS context; on return this field will
  *	contain the ID of the newly allocated context.
  * @rss_delete: Set to non-ZERO to remove the @rss_context context.
- * @input_xfrm: Defines how the input data is transformed. Valid values are one
- *	of %RXH_XFRM_*.
  */
 struct ethtool_rxfh_param {
 	u8	hfunc;
@@ -626,7 +624,6 @@ struct ethtool_rxfh_param {
 	u8	*key;
 	u32	rss_context;
 	u8	rss_delete;
-	u8	input_xfrm;
 };
 
 /**
@@ -635,8 +632,6 @@ struct ethtool_rxfh_param {
  *	parameter.
  * @cap_rss_ctx_supported: indicates if the driver supports RSS
  *	contexts.
- * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
- *	RSS.
  * @supported_coalesce_params: supported types of interrupt coalescing.
  * @supported_ring_params: supported ring params.
  * @get_drvinfo: Report driver/device information. Modern drivers no
@@ -816,7 +811,6 @@ struct ethtool_rxfh_param {
 struct ethtool_ops {
 	u32     cap_link_lanes_supported:1;
 	u32     cap_rss_ctx_supported:1;
-	u32	cap_rss_sym_xor_supported:1;
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 0787d561ace0..f7fba0dc87e5 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1266,8 +1266,6 @@ struct ethtool_rxfh_indir {
  *	hardware hash key.
  * @hfunc: Defines the current RSS hash function used by HW (or to be set to).
  *	Valid values are one of the %ETH_RSS_HASH_*.
- * @input_xfrm: Defines how the input data is transformed. Valid values are one
- *	of %RXH_XFRM_*.
  * @rsvd8: Reserved for future use; see the note on reserved space.
  * @rsvd32: Reserved for future use; see the note on reserved space.
  * @rss_config: RX ring/queue index for each hash value i.e., indirection table
@@ -1287,8 +1285,7 @@ struct ethtool_rxfh {
 	__u32   indir_size;
 	__u32   key_size;
 	__u8	hfunc;
-	__u8	input_xfrm;
-	__u8	rsvd8[2];
+	__u8	rsvd8[3];
 	__u32	rsvd32;
 	__u32   rss_config[];
 };
@@ -1995,14 +1992,6 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 
 #define WOL_MODE_COUNT		8
 
-/* RSS hash function data
- * XOR the corresponding source and destination fields of each specified
- * protocol. Both copies of the XOR'ed fields are fed into the RSS and RXHASH
- * calculation. Note that this XORing reduces the input set entropy and could
- * be exploited to reduce the RSS queue spread.
- */
-#define	RXH_XFRM_SYM_XOR	(1 << 0)
-
 /* L2-L4 network traffic flow types */
 #define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
 #define	UDP_V4_FLOW	0x02	/* hash or spec (udp_ip4_spec) */
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 3f89074aa06c..73e2c10dc2cc 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -908,7 +908,6 @@ enum {
 	ETHTOOL_A_RSS_HFUNC,		/* u32 */
 	ETHTOOL_A_RSS_INDIR,		/* binary */
 	ETHTOOL_A_RSS_HKEY,		/* binary */
-	ETHTOOL_A_RSS_INPUT_XFRM,	/* u32 */
 
 	__ETHTOOL_A_RSS_CNT,
 	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1),
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 86d47425038b..86e5fc64b711 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -972,35 +972,18 @@ static int ethtool_rxnfc_copy_to_user(void __user *useraddr,
 static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
-	const struct ethtool_ops *ops = dev->ethtool_ops;
-	struct ethtool_rxfh_param rxfh = {};
 	struct ethtool_rxnfc info;
 	size_t info_size = sizeof(info);
 	int rc;
 
-	if (!ops->set_rxnfc || !ops->get_rxfh)
+	if (!dev->ethtool_ops->set_rxnfc)
 		return -EOPNOTSUPP;
 
 	rc = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
 	if (rc)
 		return rc;
 
-	rc = ops->get_rxfh(dev, &rxfh);
-	if (rc)
-		return rc;
-
-	/* Sanity check: if symmetric-xor is set, then:
-	 * 1 - no other fields besides IP src/dst and/or L4 src/dst
-	 * 2 - If src is set, dst must also be set
-	 */
-	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
-	    ((info.data & ~(RXH_IP_SRC | RXH_IP_DST |
-			    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
-	     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
-	     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
-		return -EINVAL;
-
-	rc = ops->set_rxnfc(dev, &info);
+	rc = dev->ethtool_ops->set_rxnfc(dev, &info);
 	if (rc)
 		return rc;
 
@@ -1215,7 +1198,7 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	user_key_size = rxfh.key_size;
 
 	/* Check that reserved fields are 0 for now */
-	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
+	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd8[2] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
 	if (rxfh.rss_context && !ops->cap_rss_ctx_supported)
@@ -1288,15 +1271,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		return -EFAULT;
 
 	/* Check that reserved fields are 0 for now */
-	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
+	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd8[2] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
 	if (rxfh.rss_context && !ops->cap_rss_ctx_supported)
 		return -EOPNOTSUPP;
-	/* Check input data transformation capabilities */
-	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
-	    !ops->cap_rss_sym_xor_supported)
-		return -EOPNOTSUPP;
 
 	/* If either indir, hash key or function is valid, proceed further.
 	 * Must request at least one change: indir size, hash key or function.
@@ -1362,7 +1341,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 
 	rxfh_dev.hfunc = rxfh.hfunc;
 	rxfh_dev.rss_context = rxfh.rss_context;
-	rxfh_dev.input_xfrm = rxfh.input_xfrm;
 
 	ret = ops->set_rxfh(dev, &rxfh_dev, extack);
 	if (ret)
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 71679137eff2..efc9f4409e40 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -13,7 +13,6 @@ struct rss_reply_data {
 	u32				indir_size;
 	u32				hkey_size;
 	u32				hfunc;
-	u32				input_xfrm;
 	u32				*indir_table;
 	u8				*hkey;
 };
@@ -98,7 +97,6 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 		goto out_ops;
 
 	data->hfunc = rxfh.hfunc;
-	data->input_xfrm = rxfh.input_xfrm;
 out_ops:
 	ethnl_ops_complete(dev);
 	return ret;
@@ -112,7 +110,6 @@ rss_reply_size(const struct ethnl_req_info *req_base,
 	int len;
 
 	len = nla_total_size(sizeof(u32)) +	/* _RSS_HFUNC */
-	      nla_total_size(sizeof(u32)) +	/* _RSS_INPUT_XFRM */
 	      nla_total_size(sizeof(u32) * data->indir_size) + /* _RSS_INDIR */
 	      nla_total_size(data->hkey_size);	/* _RSS_HKEY */
 
@@ -127,8 +124,6 @@ rss_fill_reply(struct sk_buff *skb, const struct ethnl_req_info *req_base,
 
 	if ((data->hfunc &&
 	     nla_put_u32(skb, ETHTOOL_A_RSS_HFUNC, data->hfunc)) ||
-	    (data->input_xfrm &&
-	     nla_put_u32(skb, ETHTOOL_A_RSS_INPUT_XFRM, data->input_xfrm)) ||
 	    (data->indir_size &&
 	     nla_put(skb, ETHTOOL_A_RSS_INDIR,
 		     sizeof(u32) * data->indir_size, data->indir_table)) ||
-- 
2.39.2


