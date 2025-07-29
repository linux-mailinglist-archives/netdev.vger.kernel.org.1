Return-Path: <netdev+bounces-210776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54992B14C1D
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 12:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8DA5451A1
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7408F28724A;
	Tue, 29 Jul 2025 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Roh4b8re"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0CA289370
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784681; cv=none; b=YQEbABECQCdwd0axr2qdD+jT8zPBW+yrKKcEsBYPEN414APZj3x6r/ahABSSVOo6Vbbpdj3zPwS6E+gWzZixHpZEbUg426oHzQdSyRc/h2Mu4Kf2RdBkFwsyAglk7pilvbHdKdijqKM/bhxZ5kuYF3E+EXne4Crdum4DgSuPcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784681; c=relaxed/simple;
	bh=swwPFYQFxFvgm/3J+iEVe/9loYBZ/PpJnFgxCOaGTnU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b4JsuqB4aBh9aSngLvoJ0hRiqU7jH27dKXBiJLb01iUIga4ML9hwRYJfJ4IQdwKt1Nvknz4Ea5h+GtTR+Cosc+efl+wGikZObc4whGJsA9X3cmcTL4aE5wIIfysqjdp4IoxBeFURP149zYcjobmQfkG+sZbJN0Y4Ywo6fCZzMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Roh4b8re; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T6hZ0U013100;
	Tue, 29 Jul 2025 03:24:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=uIrm/xFuigPfzAzk+q
	JnEL9YiYoBV9CCueR0IXNakRI=; b=Roh4b8req9IuHz/ym2i2RrRWB71kGSw+tu
	0GbiO++GMRrOFdC3L0LPfETsASlNS4uCfiHdCcXt3TuEpy6SNCq12i5z1WR7XQgc
	aUTBZFEO1RanXig5Y5Ukq5tSp7aszwX1WRIQQv7Qoe/CyVkXHt1csEAkKcrRUSa/
	tWrda6BadO76N2DDS2dugWrcRQCLDYto+nIJh+a0Cznht9dgXZ702uo5hWxWB7MD
	gwCBLNLqxUcRWecLEMHAN/VIonsPWJYx8Tk8XgH+HWE9US7/SOhmyUqCplgRUD/M
	E1Iz25bzMiaW9ZqF/db93IUz7WuVFtj4SvqBM3SuihdXT2SloX1g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 486s8w117h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 29 Jul 2025 03:24:22 -0700 (PDT)
Received: from devvm31871.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 29 Jul 2025 10:24:19 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
        <intel-wired-lan@lists.osuosl.org>,
        Donald
 Hunter <donald.hunter@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        <netdev@vger.kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [RFC PATCH] ethtool: add FEC bins histogramm report
Date: Tue, 29 Jul 2025 03:23:54 -0700
Message-ID: <20250729102354.771859-1-vadfed@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4MSBTYWx0ZWRfX4Ry9DBXy7Tqw 4tU0C4K/qNHhiOBOL7qI8/WUeBFsQWwA04gTPpE9lO1YWpzZP4djzValUCx0XHSWOpjK1bFCtCZ jGF8AcSJ+byzAW25/DPDpx2hQakiymlIuNh5Bc8FRm17Ofzlv0Xf8aJs+vWjW7KVhk/qG/koqVH
 1LVeoqxXpIey0dOeHZL4U8HoKYY7t0N3vKXfqeWZlIqG+4VWZe26btG+/sAKnQ/17Gm4kTgQk0Z NHFyBLn2UyuDZDZQ0MMougu8y2KtVX8W81jSl3WknkQ4vb8iH49/6kiU3ltSY3OIiGhEL6f0X4c D++uZAg6uHGg1cub8bNYqayYc1wPAM3DmA6gzIzkskX3lcmtG2E1cdkHe7CdIJ/lcBMY4idmuoI
 gaYM7jVhonFI7mv1+5vFg2Z4rQUpxukMz6j5OZevpOHF2yXeFj/iCo2GnKyfQqdMQcG3mmQi
X-Authority-Analysis: v=2.4 cv=RqLFLDmK c=1 sm=1 tr=0 ts=6888a156 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=knScvirIuHnn4LIlH3kA:9
X-Proofpoint-GUID: SEAi9sERHFBe6lrGcEA6kqF4NHCy0WKQ
X-Proofpoint-ORIG-GUID: SEAi9sERHFBe6lrGcEA6kqF4NHCy0WKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01

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

$ ./tools/net/ynl/pyynl/cli.py --spec \
 Documentation/netlink/specs/ethtool.yaml --do fec-get \
 --json '{"header":{"dev-index": 10, "flags": 4}}'

{'auto': 0,
 'header': {'dev-index': 10, 'dev-name': 'eni10np1'},
 'modes': {'bits': {}, 'nomask': True, 'size': 121},
 'stats': {'corr-bits': [],
           'corrected': [123],
           'hist': [{'fec-hist-bin-high': 0,
                     'fec-hist-bin-low': 0,
                     'fec-hist-bin-val': 345},
                    {'fec-hist-bin-high': 3,
                     'fec-hist-bin-low': 1,
                     'fec-hist-bin-val': 12},
                    {'fec-hist-bin-high': 7,
                     'fec-hist-bin-low': 4,
                     'fec-hist-bin-val': 2}],
           'uncorr': [4]}}
----
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
 include/linux/ethtool.h                       | 15 +++++-
 .../uapi/linux/ethtool_netlink_generated.h    |  4 ++
 net/ethtool/fec.c                             | 53 ++++++++++++++++++-
 14 files changed, 128 insertions(+), 12 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 1063d5d32fea2..3781ced722fee 100644
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
+        type: s32
+      -
+        name: fec-hist-bin-high
+        type: s32
+      -
+        name: fec-hist-bin-val
+        type: u64
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
index de5bd76a400ca..9421a5e31af21 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -492,6 +492,17 @@ struct ethtool_pause_stats {
 };
 
 #define ETHTOOL_MAX_LANES	8
+#define ETHTOOL_FEC_HIST_MAX	18
+/**
+ * struct ethtool_fec_hist_range - byte range for FEC bins histogram statistics
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
@@ -524,6 +535,7 @@ struct ethtool_fec_stats {
 		u64 total;
 		u64 lanes[ETHTOOL_MAX_LANES];
 	} corrected_blocks, uncorrectable_blocks, corrected_bits;
+	u64 hist[ETHTOOL_FEC_HIST_MAX];
 };
 
 /**
@@ -1212,7 +1224,8 @@ struct ethtool_ops {
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
index e7d3f2c352a34..b20a1e40dc45e 100644
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
+		len += nla_total_size_64bit(sizeof(u64) * ETHTOOL_FEC_HIST_MAX);
+		/* add FEC bins information */
+		len += (nla_total_size(0) +  /* _A_FEC_HIST */
+			nla_total_size(4) +  /* _A_FEC_HIST_BIN_LOW */
+			nla_total_size(4)) * /* _A_FEC_HIST_BIN_HI */
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
+		if (nla_put_u32(skb, ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_LOW,
+				ranges[i].low) ||
+		    nla_put_u32(skb, ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_HIGH,
+				ranges[i].high) ||
+		    nla_put_u64_64bit(skb, ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_VAL,
+				      hist[i], ETHTOOL_A_FEC_STAT_PAD))
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


