Return-Path: <netdev+bounces-211289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF35FB1794D
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 01:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13E516E4D5
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 23:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7196A264A86;
	Thu, 31 Jul 2025 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="exFxiTck"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774BB153598
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003459; cv=none; b=DpWxz4Nq8lIlZhSfP/43tGUmGfMEAx0kI7oNgQwS8lnwiPqv4M9jopi/2hfTMpy6KZiLtm06YW9wiNTBmh2XZuVZ3PWYC7XWJnlut35+AZd+Zy6sghncxYFwZzw2Y25+6totuq8WC9dwfk38LsZw5Yrinha4Rr94f1eb/ZjTl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003459; c=relaxed/simple;
	bh=L8TNhY6WZvac5myRqRj6b7KHBI7OVjvgEsz/iUFpGRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tt1vfIzUnUSlA4/FMvLEo35uFX9pwbD2PSXbkEPSWtqK9XcYoIyEJIs4ux6lQcoE7MwhtVEJ6Qzd7kvEVYDKXZtBfJ92fbHZWm1MEvTYkcs5lZ9j2RipC7Ke5GTSdp6zjdyv91h9wMiHQpb36ztFxym1sN7YXL5hMczZv4/alqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=exFxiTck; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VLms38022008;
	Thu, 31 Jul 2025 16:10:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=28MZMVZOj1gLAHrp8O
	9P39qnMPUEHht1sZCfv5+Kw0s=; b=exFxiTckcsIgC2BwjIyLSehc0AnISUY0eU
	SL3NdKogVsxfRFUj7U7Bh0COGhTuUPhp4KpNSlqeA2k0ZQXOa6j510pZvIvmizsM
	UKIcIiBMnWWyjSQPPLGCc3n20k30toQqxI+NzsTFYKYkKhIX+SR8yC58djBSX6at
	CFaQpxqF+k25lDifSmKE9dCMKVEmj8hZTcAbaLjdLHk4SRcFkfYiIrqxlvx95+8p
	opI41aj5N6xAl27f7r8joaJ4uztw18roy+jop318d68z5PXRjQkhMwSlzLWwUM+J
	iHoE87WCN39VKGlJGM0GYrk5ZRVYLpc8kx9ZH6ZRwp45UFagFwoA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 488fcp943g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 31 Jul 2025 16:10:39 -0700 (PDT)
Received: from devvm31871.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 31 Jul 2025 23:10:36 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
        <intel-wired-lan@lists.osuosl.org>,
        Donald
 Hunter <donald.hunter@gmail.com>,
        Carolina Jubran <cjubran@nvidia.com>,
        Jakub
 Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        <netdev@vger.kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [RFC PATCH v2] ethtool: add FEC bins histogramm report
Date: Thu, 31 Jul 2025 16:10:19 -0700
Message-ID: <20250731231019.1809172-1-vadfed@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MvRS63ae c=1 sm=1 tr=0 ts=688bf7ef cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=knScvirIuHnn4LIlH3kA:9
X-Proofpoint-GUID: -xF1ZrNJhDUDksnVv3m_j7vME3SVNhNy
X-Proofpoint-ORIG-GUID: -xF1ZrNJhDUDksnVv3m_j7vME3SVNhNy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDE3MCBTYWx0ZWRfXx+f7id3vLW5z XcrFk+6hDTVQpJXzW2hYBPDD259RxLN5ydEMMkiYzQKbxU3MgO8fudH3MCnnNU0ZQrLd+kIL7sN MOyI2cyW9FweHqP1AV93klNGBBsGPUe1Jlepd54KnB0iBB2xTryDJw/xb7Fjp6G7MAXIxJuGG0e
 Fwqcu+H1MMjS6LB/yGMmWNN9327jvQReoRTV/XEUun4SVy2TAoCMqTdAqdEvP+tN1tV0PSdSSRV cf1KoJcI7mBYumaMZ0MqT/+5eMz8qFzGdsEJe1UNRBkb5dCEDpIkNecjWCYfzqKwOmxzFSxxNcc CDV6TDToL9d1WEZGtLF2TPu+wHOsKAdMFcTQFpWe3B9U/FspwqLQXiCyDylgcsCSFsS8YNqhFFv
 q2+pKkbd86CwqL9l3WhF1KOUXPECI6EeLWKUCWapPCSpRVIOeXHoC29H4Zvo5DyddKm7L3Ud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01

IEEE 802.3ck-2022 defines counters for FEC bins and 802.3df-2024
clarifies it a bit further. Implement reporting interface through as
addition to FEC stats available in ethtool.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---

With this RFC I would like to get early feedback from the community
about implementing FEC histogram statistics while we are waiting for
some vendors to actually implement it in their drivers. I implemented
the simplest solution in netdevsim driver to show how API looks like.
The example query is the same as usual FEC statistics while the answer
is a bit more verbose:

[vmuser@archvm9 linux]$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/ethtool.yaml --do fec-get --json '{"header":{"dev-index": 10, "flags": 4}}'
{'auto': 0,
 'header': {'dev-index': 10, 'dev-name': 'eni10np1'},
 'modes': {'bits': {}, 'nomask': True, 'size': 121},
 'stats': {'corr-bits': [],
           'corrected': [123],
           'hist': [{'bin-high': 0,
                     'bin-low': 0,
                     'bin-val': 345,
                     'bin-val-per-lane': [125, 120, 100, 100]},
                    {'bin-high': 3, 'bin-low': 1, 'bin-val': 12},
                    {'bin-high': 7, 'bin-low': 4, 'bin-val': 2}],
           'uncorr': [4]}}

RFC v2:
- adjust yaml spec to avoid nesting histogram attributes and use
  flexible types
- add support for per-lane histogram together with total values
- remove sentinel (-1, -1) and use (0, 0) as common array break.
  bin (0, 0) is still possible but only as a first element of
  ranges array
---
 Documentation/netlink/specs/ethtool.yaml      | 24 +++++++++
 Documentation/networking/ethtool-netlink.rst  |  5 ++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  3 +-
 .../ethernet/fungible/funeth/funeth_ethtool.c |  3 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  3 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  3 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |  3 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  3 +-
 drivers/net/ethernet/sfc/ethtool.c            |  3 +-
 drivers/net/ethernet/sfc/siena/ethtool.c      |  3 +-
 drivers/net/netdevsim/ethtool.c               | 15 +++++-
 include/linux/ethtool.h                       | 16 +++++-
 .../uapi/linux/ethtool_netlink_generated.h    |  4 ++
 net/ethtool/fec.c                             | 53 ++++++++++++++++++-
 14 files changed, 129 insertions(+), 12 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 1063d5d32fea2..69779b51f1dfd 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1239,6 +1239,30 @@ attribute-sets:
         name: corr-bits
         type: binary
         sub-type: u64
+      -
+        name: hist
+        type: nest
+        multi-attr: True
+        nested-attributes: fec-hist
+      -
+        name: fec-hist-bin-low
+        type: uint
+      -
+        name: fec-hist-bin-high
+        type: uint
+      -
+        name: fec-hist-bin-val
+        type: uint
+  -
+    name: fec-hist
+    subset-of: fec-stat
+    attributes:
+      -
+        name: fec-hist-bin-low
+      -
+        name: fec-hist-bin-high
+      -
+        name: fec-hist-bin-val
   -
     name: fec
     attr-cnt-name: __ethtool-a-fec-cnt
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index ab20c644af248..b270886c5f5d5 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1541,6 +1541,11 @@ Drivers fill in the statistics in the following structure:
 .. kernel-doc:: include/linux/ethtool.h
     :identifiers: ethtool_fec_stats
 
+Statistics may have FEC bins histogram attribute ``ETHTOOL_A_FEC_STAT_HIST``
+as defined in IEEE 802.3ck-2022 and 802.3df-2024. Nested attributes will have
+the range of FEC errors in the bin (inclusive) and the amount of error events
+in the bin.
+
 FEC_SET
 =======
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 1b37612b1c01f..ff8c0977a1f4a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3185,7 +3185,8 @@ static int bnxt_get_fecparam(struct net_device *dev,
 }
 
 static void bnxt_get_fec_stats(struct net_device *dev,
-			       struct ethtool_fec_stats *fec_stats)
+			       struct ethtool_fec_stats *fec_stats,
+			       const struct ethtool_fec_hist_range **ranges)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	u64 *rx;
diff --git a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
index ba83dbf4ed222..42027ce2b013d 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
@@ -930,7 +930,8 @@ static void fun_get_rmon_stats(struct net_device *netdev,
 }
 
 static void fun_get_fec_stats(struct net_device *netdev,
-			      struct ethtool_fec_stats *stats)
+			      struct ethtool_fec_stats *stats,
+			      const struct ethtool_fec_hist_range **ranges)
 {
 	const struct funeth_priv *fp = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index d5454e126c856..c5af42706c179 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1659,7 +1659,8 @@ static void hns3_set_msglevel(struct net_device *netdev, u32 msg_level)
 }
 
 static void hns3_get_fec_stats(struct net_device *netdev,
-			       struct ethtool_fec_stats *fec_stats)
+			       struct ethtool_fec_stats *fec_stats,
+			       const struct ethtool_fec_hist_range **ranges)
 {
 	struct hnae3_handle *handle = hns3_get_handle(netdev);
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 55e0f2c6af9e5..321704c53a0c2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4623,7 +4623,8 @@ static int ice_get_port_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
  *
  */
 static void ice_get_fec_stats(struct net_device *netdev,
-			      struct ethtool_fec_stats *fec_stats)
+			      struct ethtool_fec_stats *fec_stats,
+			      const struct ethtool_fec_hist_range **ranges)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_port_topology port_topology;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 998c734ff8399..7c6643aa24bfa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -1283,7 +1283,8 @@ static int otx2_set_link_ksettings(struct net_device *netdev,
 }
 
 static void otx2_get_fec_stats(struct net_device *netdev,
-			       struct ethtool_fec_stats *fec_stats)
+			       struct ethtool_fec_stats *fec_stats,
+			       const struct ethtool_fec_hist_range **ranges)
 {
 	struct otx2_nic *pfvf = netdev_priv(netdev);
 	struct cgx_fw_data *rsp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index d507366d773e1..9ad43b40d4ca5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1927,7 +1927,8 @@ static int mlx5e_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 }
 
 static void mlx5e_get_fec_stats(struct net_device *netdev,
-				struct ethtool_fec_stats *fec_stats)
+				struct ethtool_fec_stats *fec_stats,
+				const struct ethtool_fec_hist_range **ranges)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 23c6a7df78d03..20de19d6a4d70 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -217,7 +217,8 @@ static int efx_ethtool_set_wol(struct net_device *net_dev,
 }
 
 static void efx_ethtool_get_fec_stats(struct net_device *net_dev,
-				      struct ethtool_fec_stats *fec_stats)
+				      struct ethtool_fec_stats *fec_stats,
+				      const struct ethtool_fec_hist_range **ranges)
 {
 	struct efx_nic *efx = efx_netdev_priv(net_dev);
 
diff --git a/drivers/net/ethernet/sfc/siena/ethtool.c b/drivers/net/ethernet/sfc/siena/ethtool.c
index 994909789bfea..b98271c546738 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool.c
@@ -217,7 +217,8 @@ static int efx_ethtool_set_wol(struct net_device *net_dev,
 }
 
 static void efx_ethtool_get_fec_stats(struct net_device *net_dev,
-				      struct ethtool_fec_stats *fec_stats)
+				      struct ethtool_fec_stats *fec_stats,
+				      const struct ethtool_fec_hist_range **ranges)
 {
 	struct efx_nic *efx = netdev_priv(net_dev);
 
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index f631d90c428ac..7257de9ea2f44 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -164,12 +164,25 @@ nsim_set_fecparam(struct net_device *dev, struct ethtool_fecparam *fecparam)
 	ns->ethtool.fec.active_fec = 1 << (fls(fec) - 1);
 	return 0;
 }
+static const struct ethtool_fec_hist_range netdevsim_fec_ranges[] = {
+	{  0,  0},
+	{  1,  3},
+	{  4,  7},
+	{ -1, -1}
+};
 
 static void
-nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats)
+nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats,
+		   const struct ethtool_fec_hist_range **ranges)
 {
+	*ranges = netdevsim_fec_ranges;
+
 	fec_stats->corrected_blocks.total = 123;
 	fec_stats->uncorrectable_blocks.total = 4;
+
+	fec_stats->hist[0] = 345;
+	fec_stats->hist[1] = 12;
+	fec_stats->hist[2] = 2;
 }
 
 static int nsim_get_ts_info(struct net_device *dev,
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index de5bd76a400ca..99ba50dd2cc22 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -492,6 +492,18 @@ struct ethtool_pause_stats {
 };
 
 #define ETHTOOL_MAX_LANES	8
+#define ETHTOOL_FEC_HIST_MAX	18
+/**
+ * struct ethtool_fec_hist_range - error bits range for FEC bins histogram
+ * statistics
+ * sentinel value of { -1, -1 } is used as marker for end of bins array
+ * @low: low bound of the bin (inclusive)
+ * @high: high bound of the bin (inclusive)
+ */
+struct ethtool_fec_hist_range {
+	s16 low;
+	s16 high;
+};
 
 /**
  * struct ethtool_fec_stats - statistics for IEEE 802.3 FEC
@@ -524,6 +536,7 @@ struct ethtool_fec_stats {
 		u64 total;
 		u64 lanes[ETHTOOL_MAX_LANES];
 	} corrected_blocks, uncorrectable_blocks, corrected_bits;
+	u64 hist[ETHTOOL_FEC_HIST_MAX];
 };
 
 /**
@@ -1212,7 +1225,8 @@ struct ethtool_ops {
 	int	(*set_link_ksettings)(struct net_device *,
 				      const struct ethtool_link_ksettings *);
 	void	(*get_fec_stats)(struct net_device *dev,
-				 struct ethtool_fec_stats *fec_stats);
+				 struct ethtool_fec_stats *fec_stats,
+				 const struct ethtool_fec_hist_range **ranges);
 	int	(*get_fecparam)(struct net_device *,
 				      struct ethtool_fecparam *);
 	int	(*set_fecparam)(struct net_device *,
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index e3b8813465d73..f9babbd2e76f9 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -567,6 +567,10 @@ enum {
 	ETHTOOL_A_FEC_STAT_CORRECTED,
 	ETHTOOL_A_FEC_STAT_UNCORR,
 	ETHTOOL_A_FEC_STAT_CORR_BITS,
+	ETHTOOL_A_FEC_STAT_HIST,
+	ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_LOW,
+	ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_HIGH,
+	ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_VAL,
 
 	__ETHTOOL_A_FEC_STAT_CNT,
 	ETHTOOL_A_FEC_STAT_MAX = (__ETHTOOL_A_FEC_STAT_CNT - 1)
diff --git a/net/ethtool/fec.c b/net/ethtool/fec.c
index e7d3f2c352a34..cb930eba780c2 100644
--- a/net/ethtool/fec.c
+++ b/net/ethtool/fec.c
@@ -17,6 +17,8 @@ struct fec_reply_data {
 		u64 stats[1 + ETHTOOL_MAX_LANES];
 		u8 cnt;
 	} corr, uncorr, corr_bits;
+	u64 hist[ETHTOOL_FEC_HIST_MAX];
+	const struct ethtool_fec_hist_range *fec_ranges;
 };
 
 #define FEC_REPDATA(__reply_base) \
@@ -113,11 +115,13 @@ static int fec_prepare_data(const struct ethnl_req_info *req_base,
 		struct ethtool_fec_stats stats;
 
 		ethtool_stats_init((u64 *)&stats, sizeof(stats) / 8);
-		dev->ethtool_ops->get_fec_stats(dev, &stats);
+		dev->ethtool_ops->get_fec_stats(dev, &stats, &data->fec_ranges);
 
 		fec_stats_recalc(&data->corr, &stats.corrected_blocks);
 		fec_stats_recalc(&data->uncorr, &stats.uncorrectable_blocks);
 		fec_stats_recalc(&data->corr_bits, &stats.corrected_bits);
+		if (data->fec_ranges)
+			memcpy(data->hist, stats.hist, sizeof(stats.hist));
 	}
 
 	WARN_ON_ONCE(fec.reserved);
@@ -157,13 +161,55 @@ static int fec_reply_size(const struct ethnl_req_info *req_base,
 	len += nla_total_size(sizeof(u8)) +	/* _FEC_AUTO */
 	       nla_total_size(sizeof(u32));	/* _FEC_ACTIVE */
 
-	if (req_base->flags & ETHTOOL_FLAG_STATS)
+	if (req_base->flags & ETHTOOL_FLAG_STATS) {
 		len += 3 * nla_total_size_64bit(sizeof(u64) *
 						(1 + ETHTOOL_MAX_LANES));
+		/* add FEC bins information */
+		len += (nla_total_size(0) +  /* _A_FEC_HIST */
+			nla_total_size(4) +  /* _A_FEC_HIST_BIN_LOW */
+			nla_total_size(4) +  /* _A_FEC_HIST_BIN_HI */
+			nla_total_size(8)) * /* _A_FEC_HIST_BIN_VAL */
+			ETHTOOL_FEC_HIST_MAX;
+	}
 
 	return len;
 }
 
+static int fec_put_hist(struct sk_buff *skb, const u64 *hist,
+			const struct ethtool_fec_hist_range *ranges)
+{
+	struct nlattr *nest;
+	int i;
+
+	if (!ranges)
+		return 0;
+
+	for (i = 0; i < ETHTOOL_FEC_HIST_MAX; i++) {
+		if (ranges[i].low == -1 && ranges[i].high == -1)
+			break;
+
+		nest = nla_nest_start(skb, ETHTOOL_A_FEC_STAT_HIST);
+		if (!nest)
+			return -EMSGSIZE;
+
+		if (nla_put_uint(skb, ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_LOW,
+				 ranges[i].low) ||
+		    nla_put_uint(skb, ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_HIGH,
+				 ranges[i].high) ||
+		    nla_put_uint(skb, ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_VAL,
+			         hist[i]))
+			goto err_cancel_hist;
+
+		nla_nest_end(skb, nest);
+	}
+
+	return 0;
+
+err_cancel_hist:
+	nla_nest_cancel(skb, nest);
+	return -EMSGSIZE;
+}
+
 static int fec_put_stats(struct sk_buff *skb, const struct fec_reply_data *data)
 {
 	struct nlattr *nest;
@@ -183,6 +229,9 @@ static int fec_put_stats(struct sk_buff *skb, const struct fec_reply_data *data)
 			  data->corr_bits.stats, ETHTOOL_A_FEC_STAT_PAD))
 		goto err_cancel;
 
+	if (fec_put_hist(skb, data->hist, data->fec_ranges))
+		goto err_cancel;
+
 	nla_nest_end(skb, nest);
 	return 0;
 
-- 
2.47.3


