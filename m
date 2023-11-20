Return-Path: <netdev+bounces-49395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89C27F1E54
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11AB1C20D85
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F46E3032E;
	Mon, 20 Nov 2023 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHpRdyQU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BB5E7;
	Mon, 20 Nov 2023 12:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700513800; x=1732049800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TzlimL8q8AdyNMObZD/w0OFaDagyeyOJlMpWQu9U78o=;
  b=MHpRdyQUqVwqO6f5pKjWQgaLSxEaAHC22ko9YTR3XYYWX2aF7FoCUIA6
   qh/UDqpN6s1KGtbSV6m2pH6Jb5Fw9o/cphTC4gCM/GqrYkybQYHtSdCuk
   dlGchxwY/bvvNyIrPaHrMZIgCczioqAGMRL3kHz3RfFFUIX51J122Jm5E
   IMkQJbd6VXVB7tCuZ/+kZjw5tDiVYVYyihmdnzvFUdtAFS6A99rtHTVQw
   +qsRlPZ+xwU4U9qgZ0mW9t2yfnEgNGAN05KerG73sc88pOdq/t+nCeaqv
   /AdEQA43hDFEmRl5mthZZhwGBQtAgWMAIJTbdmYFXCGh8rdOHa0ldjpLA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="391484246"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="391484246"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="857106154"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="857106154"
Received: from cchircul-mobl2.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.249.46.122])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:56:34 -0800
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
	linux-doc@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH net-next v6 2/7] net: ethtool: add support for symmetric-xor RSS hash
Date: Mon, 20 Nov 2023 13:56:09 -0700
Message-Id: <20231120205614.46350-3-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120205614.46350-1-ahmed.zaki@intel.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
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
 Documentation/networking/scaling.rst | 15 +++++++++++++++
 include/uapi/linux/ethtool.h         | 12 +++++++++++-
 include/uapi/linux/ethtool_netlink.h |  1 +
 net/ethtool/ioctl.c                  |  4 ++--
 net/ethtool/rss.c                    |  5 +++++
 5 files changed, 34 insertions(+), 3 deletions(-)

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
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..5d629b7b2d55 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1266,6 +1266,8 @@ struct ethtool_rxfh_indir {
  *	hardware hash key.
  * @hfunc: Defines the current RSS hash function used by HW (or to be set to).
  *	Valid values are one of the %ETH_RSS_HASH_*.
+ * @data: Extension for the RSS hash function. Valid values are one of the
+ *	%RXH_HFUNC_*.
  * @rsvd8: Reserved for future use; see the note on reserved space.
  * @rsvd32: Reserved for future use; see the note on reserved space.
  * @rss_config: RX ring/queue index for each hash value i.e., indirection table
@@ -1285,7 +1287,8 @@ struct ethtool_rxfh {
 	__u32   indir_size;
 	__u32   key_size;
 	__u8	hfunc;
-	__u8	rsvd8[3];
+	__u8	data;
+	__u8	rsvd8[2];
 	__u32	rsvd32;
 	__u32   rss_config[];
 };
@@ -1992,6 +1995,13 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 
 #define WOL_MODE_COUNT		8
 
+/* RSS hash function data
+ * XOR the corresponding source and destination fields of each specified
+ * protocol. Both copies of the XOR'ed fields are fed into the RSS and RXHASH
+ * calculation.
+ */
+#define	RXH_HFUNC_SYM_XOR	(1 << 0)
+
 /* L2-L4 network traffic flow types */
 #define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
 #define	UDP_V4_FLOW	0x02	/* hash or spec (udp_ip4_spec) */
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 73e2c10dc2cc..638fa7f0682f 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -908,6 +908,7 @@ enum {
 	ETHTOOL_A_RSS_HFUNC,		/* u32 */
 	ETHTOOL_A_RSS_INDIR,		/* binary */
 	ETHTOOL_A_RSS_HKEY,		/* binary */
+	ETHTOOL_A_RSS_HFUNC_DATA,	/* u32 */
 
 	__ETHTOOL_A_RSS_CNT,
 	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1),
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index f4e6067d200f..98726d1bef77 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1195,7 +1195,7 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	user_key_size = rxfh.key_size;
 
 	/* Check that reserved fields are 0 for now */
-	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd8[2] || rxfh.rsvd32)
+	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
 	if (rxfh.rss_context && !ops->get_rxfh_context)
@@ -1268,7 +1268,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		return -EFAULT;
 
 	/* Check that reserved fields are 0 for now */
-	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd8[2] || rxfh.rsvd32)
+	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
 	if (rxfh.rss_context && !ops->set_rxfh_context)
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 2d11f881810d..99ee061e6582 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -13,6 +13,7 @@ struct rss_reply_data {
 	u32				indir_size;
 	u32				hkey_size;
 	u32				hfunc;
+	u32				hfunc_data;
 	u32				*indir_table;
 	u8				*hkey;
 };
@@ -97,6 +98,7 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 		goto out_ops;
 
 	data->hfunc = rxfh.hfunc;
+	data->hfunc_data = rxfh.data;
 out_ops:
 	ethnl_ops_complete(dev);
 	return ret;
@@ -110,6 +112,7 @@ rss_reply_size(const struct ethnl_req_info *req_base,
 	int len;
 
 	len = nla_total_size(sizeof(u32)) +	/* _RSS_HFUNC */
+	      nla_total_size(sizeof(u32)) +	/* _RSS_HFUNC_DATA */
 	      nla_total_size(sizeof(u32) * data->indir_size) + /* _RSS_INDIR */
 	      nla_total_size(data->hkey_size);	/* _RSS_HKEY */
 
@@ -124,6 +127,8 @@ rss_fill_reply(struct sk_buff *skb, const struct ethnl_req_info *req_base,
 
 	if ((data->hfunc &&
 	     nla_put_u32(skb, ETHTOOL_A_RSS_HFUNC, data->hfunc)) ||
+	    (data->hfunc_data &&
+	     nla_put_u32(skb, ETHTOOL_A_RSS_HFUNC_DATA, data->hfunc_data)) ||
 	    (data->indir_size &&
 	     nla_put(skb, ETHTOOL_A_RSS_INDIR,
 		     sizeof(u32) * data->indir_size, data->indir_table)) ||
-- 
2.34.1


