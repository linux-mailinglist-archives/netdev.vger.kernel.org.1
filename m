Return-Path: <netdev+bounces-115282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB44945BAF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEAFCB21689
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA7A14D2A3;
	Fri,  2 Aug 2024 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="QphyqDUX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2128.outbound.protection.outlook.com [40.107.244.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F214B940
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592809; cv=fail; b=rMe1pTkD0X0kJzGC/SXdF3Kgq7pov9PXV9WEcqq2Utp9NFt3Wxuw3HTyRKV3SLcTPNfFkulpfVNKMjyKm69oGzKebFHcc99KnPRkZa4C+RFVUUWG5n3g56WJbbJ1OMX5VTrV0pDoDvEVPccM+ordaa6Rtutkl/BvUjhKovsWFAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592809; c=relaxed/simple;
	bh=NMyOiAIVeYZeNobGeNFRXVQH6GRDjXHsQSZltC/AuuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKuUjavq+R8EWEoYS1OueUaGaQMjs4IeS5ypk3Vx57fSS/jxeb7pXgiwS5NkIokdZi9Q8nuNs9C07yAuoqytf1JGR46CCoaRnnsaYDGyiJTX0V5XKkuCkUWdfEi3GiWpwmkSLfbw7NcUuRtAIObEnrcmOAj7ToiHWPDpoivvZPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=QphyqDUX; arc=fail smtp.client-ip=40.107.244.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9JvhCwQEb46oQlHaKatmEIyTxt3c07/mJpSDPmQ8SJp/pjrBWtcfq3vROzGRepwRa0tbxcwaxkkRMaL022OTxcXWY1ox1oJHSisVPO3epVexUexUttSehaiAw7prwSaOOzdHdFmabJ3fIR1FPIK2295xGuQxwkUVUbS1YqBw3b76QDFrQq67XuuLcbo9coqggUO+SgBKmtStFytI42x0aRhr6jilXFnGPWVdMEb/G7PMDeKQVUKpcj8LhOZp/lrwNOy8lnAWAABHwfeDli6k+wLSW1s4dsshRkKVvRpyFJTMWzIX2YfovUVnWjTfkaybRiyjO6T/JOeB2E2hRedWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/q1J9Kc/kxCc5G2KKaqfaCf3hVz4E+HrxTkdplDkmpk=;
 b=siLe2nkIS9B1V2itF/AcfRw+jm+KghrJN0RWMdVlzbk9u4uqKcSWqmGhOxIHgNNoEhrldQxrYNWYF/xReH76cpNRbKeRrbo/AbxOdtBP6zHYiGvBvEsykTP9pQPlZ9d81o8GeKXKnE8ewgHG9Cv8v5O3ArOcJqW88Q1KsbeeorV8FF+dsC7OhReOg4ZV/t2EQLMV9+En54d11rpMSlFr8a21PlkMD/p/yo8DFMSOYvxfpvTp6xCWUWjdf1jlzWpfrEkA5qH2Fektp40qGNy/u7URpH/4Sf2+Vumq04skp8ycuCVWPbszkC4pCi9uxKK8jMcZFwftYiwESJodV4ocjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q1J9Kc/kxCc5G2KKaqfaCf3hVz4E+HrxTkdplDkmpk=;
 b=QphyqDUXU+kPcrioofz6AW423wTvJG5MEEOGmXlUAb6uNggYrm2xoXYPzd3ZTkrUHYqUQgiUaK42bvPx4W/Ci11WJLFh3cUEZl3Qg4lK9x+6TySojyodUfuhXTKtfphEMV55WyEUfKBzhkHnTV4gFq/sQEz5hAgW9Xoc1xLH9b8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DS1PR13MB7169.namprd13.prod.outlook.com (2603:10b6:8:215::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 10:00:05 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%5]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 10:00:05 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com,
	Kyle Xu <zhenbing.xu@corigine.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	oss-drivers@corigine.com
Subject: [RFC net-next 2/3] nfp: initialize NFP VF device according to enable_vnet configuration
Date: Fri,  2 Aug 2024 11:59:30 +0200
Message-Id: <20240802095931.24376-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802095931.24376-1-louis.peens@corigine.com>
References: <20240802095931.24376-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DS1PR13MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ee8201-0a34-4705-b1ed-08dcb2d9e208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YpRkDqKxPCfgQWhLuZiFlY92ai77ytVguzGXwZCWbLF2A/yk8Sx3f5d+UmY5?=
 =?us-ascii?Q?JnVAi0ZqyXfhlomlcLWgYn8u35J7Ulf0vyYRM1dSbD6WIc/YnSwURAzx9cR7?=
 =?us-ascii?Q?C8VVM7baPrIE1JVla8FvvlNJTl2zF5SrDCjfWUO9ngfYUzb+TEkGG2V2Fxm+?=
 =?us-ascii?Q?ABgOkz3mP08ixN0HIrNBLe7TzfLAj4ja8xguryPqcHiQ5g9WXmzzvTQxVKSm?=
 =?us-ascii?Q?n1EDHy0LgOx3Vn8bOURStYlvq6+cGOHBEZu0Y6H9xu8sdkFHDkvl30jmUZ7C?=
 =?us-ascii?Q?qajFREdFq66GSqpUn5z+ND1RpPxyigppZcysgsVfGJ8/mvroc5GY7nqasWlz?=
 =?us-ascii?Q?lSAlzZ+Yay47QCV6xHj3ioTkap3HKD5hLwh3HSskJ5FzpFGhdE+suc7xZQoL?=
 =?us-ascii?Q?MAwABhlSYimdmpv+MTsnOYfsPRY5oTyib4KuT1FK4eCVUydbYiX8lvcFVBzN?=
 =?us-ascii?Q?ZSnc45VzpGjeTtPGqmLLljdXcyd/MYWLgzqAWuSJfUhCxFDJmsIMpmjh/peT?=
 =?us-ascii?Q?rc8EGGURblPzBYnIObbUhkYW3zGsoj7lAiFqmnqtGJt2vkHMvsNfz2IGlrne?=
 =?us-ascii?Q?o5pnPB7VSZt+TFRGUBCNo2IrSVmaDjPZPlW02JxFJHWi2j16z7ukCWFmgFQG?=
 =?us-ascii?Q?xVvOzAYv67ZNhViPz9pnGhjiImsSA2bzZg+fdvjBO7Jfvcp4QqeLnNZEwopk?=
 =?us-ascii?Q?FmmGMJCSVakEEJVo82PBLyD31pr9v4ceyowiYXkzLT1CgDn+aZwDOuUc2l+o?=
 =?us-ascii?Q?8ycURcPUPVSYcuuxzzRzye/E28qDb7SBg1aVASVRrGeCfA2MekZSVa7VQyjK?=
 =?us-ascii?Q?8zSzdhsO6wl9UC2tHWdEdb6FbU4TA4nEpBECumhM0rL1sAaowXVxQJzS/IgH?=
 =?us-ascii?Q?GUitQMexcrjaN7vpenDISsJuipf57/OWDh5rtjzWYI1peo5Ll3YEDK1kzH+C?=
 =?us-ascii?Q?2TgBNxlfcWM5mdgpWtKe52CxoXLIYGh3ShTpWw5s5/e8peFZFgzbdidy4e3W?=
 =?us-ascii?Q?i/jWMTsjqKPb6kGwrigq4Pml54FWaBPEVEm288LyBk+Ky9gLvV0YcuFj4uUN?=
 =?us-ascii?Q?CfdKoUWUlWWeC+6IzF7w9NQ811hU3SMMpvXFYPnYmV8IIOsZt3v7M1SjCQAg?=
 =?us-ascii?Q?hk0v+XIYw9o8Kzfcm78IsbNOxH7iobUbgnSxsPPhbS4rgC05N0ACTiBe3aj5?=
 =?us-ascii?Q?cbrIuPV9zHrwbAuV8xT6niZB0HsMWg7Byelgme6FjgbyPxhjXC78z+f9+boV?=
 =?us-ascii?Q?N/e5bsGg9dwdnCK1UBtWLAU0c2OI4e/OoOjppvxkp058bnp8pHZ0pxqSxTES?=
 =?us-ascii?Q?KkfGcneJxVjmlM2DYLQaWYjAtIgN9qikas5IrqTxTvtVBQ4/Un8j1ZuZYfvw?=
 =?us-ascii?Q?qhtJRbwT72NjyrxWJO5L12hNleZXoiAnhAPczM6nqjlxm2rjAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h1eMfQDtb3Y+B/CrpSP2n8CaFxROTc7qqdz0eR+VMO2GFFC5ZL7rPFcbMhYM?=
 =?us-ascii?Q?G61nA9eQlaGupZJcL51Ketr6WLpVDpY0k2gjFvy8vkHkBqudMy3bX0kkQN6P?=
 =?us-ascii?Q?/xuuKWiriab39NQVmaXmyAfom4/zffBgbxfnJL0siPlKBIuV3QM8gPFPLVTN?=
 =?us-ascii?Q?cSgE0FgXdGm2RRQWWjBOlBPxkk4VF5Ah95MwxK1nCsLasYcSNRn4QCSIFBFK?=
 =?us-ascii?Q?D5PK3EJXP2anTaF4WEsAV9wQ9c2+eO7o2bNAn1IcGqG7J9v2d0Kpz0a4Rv6d?=
 =?us-ascii?Q?j5IAZIJel11BrsBqiA71gB4jHE1H41ObUERkafPziPuP7P7A0j3StTeBdnzd?=
 =?us-ascii?Q?Q6n58TXQkYnvt/ZhIWom4W/EzjIZhOpUO87Z2CXmdsSY3AlWOLlz7keMZ+bn?=
 =?us-ascii?Q?2S0zSHHfLZaUBzMkArn+/P8ZepFoX0yvK9JBesOSXylRYzC+qcPzIA9gwSr1?=
 =?us-ascii?Q?B2IJcxCQWJUnvctpXnzIc9EvefwI2d7DbmSrf+28Cyh2pT4x6J8qaIE6+SWs?=
 =?us-ascii?Q?WF8TGAXCX2YDLFM2SRvbVzptNg/hi+jS9gVNwoxl1Br7qOgH1f1gfS/bYI59?=
 =?us-ascii?Q?7aIsdQcRauheZHxbzdqF+1UlBMr3BDsUIStxwYAP+pwg3VN2dsVs9sPZorfp?=
 =?us-ascii?Q?hLrY8kocr+Xv+WR/lJNx1CeXDEOnduLg23UtpgDDg43zOSCmdkSOiGLMu+dr?=
 =?us-ascii?Q?3f7z2w/tFpNHok/c3oBekmBTqknZX/LhPiJ5Q2dpgc+9eyuVKDq50L2DKmYN?=
 =?us-ascii?Q?fNybVmVfpX+t/ifPYMp2Zk2wuyq+7/1X+R+ivMxoPJORz7wfqDiT5Ie+hlop?=
 =?us-ascii?Q?9xGf5L2oZpIonqjQWrGYu/neldCL4buvhl7Krl7Md41NtPbBZyo6Thk23xnZ?=
 =?us-ascii?Q?IFPyTXDQgpgTMiOUQsTkKoLhwHqRfRziYMQgZO4RvcQKD62HAcob0CTSsKZu?=
 =?us-ascii?Q?2/JGkNNNPyh6vI3lk82d7X4tg9kPllbdbYuKoeibtKcvf+5YN2oghT60LoAD?=
 =?us-ascii?Q?s02Vxn5Uq1W39/N6wunn5ONFJeubSFVCNYjr9cqvJPB68kaWSvSGagyRSZ/r?=
 =?us-ascii?Q?O12O6MLURFj/1YGsSdv0aEFsB+n8xlGZFZjtNTjRVcHph1qly6+380HBadde?=
 =?us-ascii?Q?wioRdSH2yhfvWBOkgmeINjjR2LlUxhogFojWF+a3oCZsLulZQeaUibY3NvAX?=
 =?us-ascii?Q?lXKQVoBExdq1/U6J10/Jiou3GGDuo3fsZzfYOwi1lnv32G3AjB8rn1oiL/Uy?=
 =?us-ascii?Q?C/vy+MxUDbZctq4cmpOcTEq9LglgONUwEBJCAnb8Lq5on7YAPVuThwr+e01W?=
 =?us-ascii?Q?KblmgpES+B4w1PN76LDlGdRGMadAQLPT9SvJx2G3pHSyZ6QbPS5gsnIq707W?=
 =?us-ascii?Q?c5fFAzRsBUK8Zc0+wM0HGsVzC93PI0uun1uVF9jkS3pu77q85Ft3wnuSSaBz?=
 =?us-ascii?Q?0v21ypMF3e/l+YR5gHV9M69SYNITt2mpCu615IhsxZKLwvzF3pf0cZ1IJOWO?=
 =?us-ascii?Q?tjFLJMQCVoPONY7BcKAWAtRENNVRxc5UlaoY8VSa2ZDBDgTXWp0+82hmWEnj?=
 =?us-ascii?Q?yXrXHMD6x3QL+DUqMuNIvjTc01vqc3HLWd9pl3FBdKcO7Cgbp2BCm/rkDa1p?=
 =?us-ascii?Q?0g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ee8201-0a34-4705-b1ed-08dcb2d9e208
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 10:00:05.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yJuXvIJ90MuBCb9CUXBubhcgi/uWveYlFP7jw/YQKBepjxBelZpTyLDUyUfMPJFxR72zyWf1f3X5opabIbNBX79K2eW3TNR5h4O8gL7d6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR13MB7169

From: Kyle Xu <zhenbing.xu@corigine.com>

Users can determine how to instantiate the NFP VF devices through
configure the devlink parameter 'enable_vnet' with the PF device
before enable the SRIOV.

If 'enable_vnet' is enabled, the VF devices are configured to working
as vDPA VFs. Here we still need the PCI resources allocation but can
not just complete the vDPA device registration in NFP driver, since
it should be registered as vDPA driver according to the kernel vDPA
framework. Therefore, we need to complete the driver registration
with the help of the auxiliary bus, the vDPA VF will be initialized
as auxiliary device and registered to the auxiliary bus. Otherwise
the VF device will be initialized as PCI VF device as usual.

Signed-off-by: Kyle Xu <zhenbing.xu@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/Kconfig        |   1 +
 drivers/net/ethernet/netronome/nfp/nfp_net.h  |  16 ++
 .../ethernet/netronome/nfp/nfp_net_common.c   |   3 +
 .../ethernet/netronome/nfp/nfp_netvf_main.c   | 264 ++++++++++++++----
 4 files changed, 224 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/netronome/Kconfig b/drivers/net/ethernet/netronome/Kconfig
index d03d6e96f730..022303eab1a3 100644
--- a/drivers/net/ethernet/netronome/Kconfig
+++ b/drivers/net/ethernet/netronome/Kconfig
@@ -24,6 +24,7 @@ config NFP
 	select NET_DEVLINK
 	select CRC32
 	select DIMLIB
+	select AUXILIARY_BUS
 	help
 	  This driver supports the Netronome(R) NFP4000/NFP6000 based
 	  cards working as a advanced Ethernet NIC.  It works with both
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net.h b/drivers/net/ethernet/netronome/nfp/nfp_net.h
index 46764aeccb37..538dc194add8 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net.h
@@ -13,6 +13,7 @@
 #define _NFP_NET_H_
 
 #include <linux/atomic.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
@@ -98,6 +99,9 @@
 #define NFP_NET_RX_BUF_NON_DATA	(NFP_NET_RX_BUF_HEADROOM +		\
 				 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
+/* VF auxiliary device driver match name */
+#define NFP_NET_VF_ADEV_DRV_MATCH_NAME "nfp_vf_vdpa"
+
 /* Forward declarations */
 struct nfp_cpp;
 struct nfp_dev_info;
@@ -136,6 +140,18 @@ struct nfp_nfdk_tx_buf;
 		__d->dma_addr_lo = cpu_to_le32(lower_32_bits(__addr));	\
 	} while (0)
 
+/**
+ * struct nfp_net_vf_aux_dev - NFP VF auxiliary device structure
+ * @aux_dev: Auxiliary device structure of this device
+ * @pdev: Backpointer to PCI device
+ * @dev_info: NFP ASIC params
+ */
+struct nfp_net_vf_aux_dev {
+	struct auxiliary_device aux_dev;
+	struct pci_dev *pdev;
+	const struct nfp_dev_info *dev_info;
+};
+
 /**
  * struct nfp_net_tx_ring - TX ring structure
  * @r_vec:      Back pointer to ring vector structure
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 182ba0a8b095..469b4c794f88 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -74,6 +74,7 @@ u32 nfp_qcp_queue_offset(const struct nfp_dev_info *dev_info, u16 queue)
 	queue &= dev_info->qc_idx_mask;
 	return dev_info->qc_addr_offset + NFP_QCP_QUEUE_ADDR_SZ * queue;
 }
+EXPORT_SYMBOL_GPL(nfp_qcp_queue_offset);
 
 /* Firmware reconfig
  *
@@ -390,6 +391,7 @@ nfp_net_irqs_alloc(struct pci_dev *pdev, struct msix_entry *irq_entries,
 
 	return got_irqs;
 }
+EXPORT_SYMBOL_GPL(nfp_net_irqs_alloc);
 
 /**
  * nfp_net_irqs_assign() - Assign interrupts allocated externally to netdev
@@ -432,6 +434,7 @@ void nfp_net_irqs_disable(struct pci_dev *pdev)
 {
 	pci_disable_msix(pdev);
 }
+EXPORT_SYMBOL_GPL(nfp_net_irqs_disable);
 
 /**
  * nfp_net_irq_rxtx() - Interrupt service routine for RX/TX rings.
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
index e19bb0150cb5..71d3abf7e191 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
@@ -35,8 +35,25 @@ struct nfp_net_vf {
 	struct dentry *ddir;
 };
 
+/**
+ * struct nfp_net_vf_dev - NFP VF device structure
+ * @v_dev: Pointer of PCI VF device
+ * @a_dev: Pointer of VF auxiliary device
+ * @enable_vnet: VDPA networking device flag
+ */
+struct nfp_net_vf_dev {
+	union {
+		struct nfp_net_vf *v_dev;
+		struct nfp_net_vf_aux_dev *a_dev;
+	};
+	bool enable_vnet;
+};
+
 static const char nfp_net_driver_name[] = "nfp_netvf";
 
+/* NFP vf auxiliary device ID allocator definition */
+static DEFINE_IDA(nfp_vf_adev_ida);
+
 static const struct pci_device_id nfp_netvf_pci_device_ids[] = {
 	{ PCI_VENDOR_ID_NETRONOME, PCI_DEVICE_ID_NFP3800_VF,
 	  PCI_VENDOR_ID_NETRONOME, PCI_ANY_ID,
@@ -74,10 +91,20 @@ static void nfp_netvf_get_mac_addr(struct nfp_net *nn)
 	ether_addr_copy(nn->dp.netdev->perm_addr, mac_addr);
 }
 
-static int nfp_netvf_pci_probe(struct pci_dev *pdev,
-			       const struct pci_device_id *pci_id)
+static bool nfp_net_get_enable_vnet(void __iomem *ctrl_bar)
+{
+	u32 enable_vnet;
+
+	enable_vnet = readl(ctrl_bar + NFP_NET_CFG_CTRL_WORD1);
+	return !!(enable_vnet & NFP_NET_CFG_CTRL_ENABLE_VNET);
+}
+
+static int nfp_netvf_pci_probe_vf_dev(struct pci_dev *pdev,
+				      const struct pci_device_id *pci_id,
+				      u8 __iomem *ctrl_bar,
+				      struct nfp_net_vf_dev *vf_dev,
+				      const struct nfp_dev_info *dev_info)
 {
-	const struct nfp_dev_info *dev_info;
 	struct nfp_net_fw_version fw_ver;
 	int max_tx_rings, max_rx_rings;
 	u32 tx_bar_off, rx_bar_off;
@@ -85,49 +112,17 @@ static int nfp_netvf_pci_probe(struct pci_dev *pdev,
 	int tx_bar_no, rx_bar_no;
 	struct nfp_net_vf *vf;
 	unsigned int num_irqs;
-	u8 __iomem *ctrl_bar;
 	struct nfp_net *nn;
 	u32 startq;
 	int stride;
 	int err;
 
-	dev_info = &nfp_dev_info[pci_id->driver_data];
-
 	vf = kzalloc(sizeof(*vf), GFP_KERNEL);
 	if (!vf)
 		return -ENOMEM;
-	pci_set_drvdata(pdev, vf);
-
-	err = pci_enable_device_mem(pdev);
-	if (err)
-		goto err_free_vf;
-
-	err = pci_request_regions(pdev, nfp_net_driver_name);
-	if (err) {
-		dev_err(&pdev->dev, "Unable to allocate device memory.\n");
-		goto err_pci_disable;
-	}
-
-	pci_set_master(pdev);
-
-	err = dma_set_mask_and_coherent(&pdev->dev, dev_info->dma_mask);
-	if (err)
-		goto err_pci_regions;
 
-	/* Map the Control BAR.
-	 *
-	 * Irrespective of the advertised BAR size we only map the
-	 * first NFP_NET_CFG_BAR_SZ of the BAR.  This keeps the code
-	 * the identical for PF and VF drivers.
-	 */
-	ctrl_bar = ioremap(pci_resource_start(pdev, NFP_NET_CTRL_BAR),
-				   NFP_NET_CFG_BAR_SZ);
-	if (!ctrl_bar) {
-		dev_err(&pdev->dev,
-			"Failed to map resource %d\n", NFP_NET_CTRL_BAR);
-		err = -EIO;
-		goto err_pci_regions;
-	}
+	vf_dev->v_dev = vf;
+	vf->q_bar = NULL;
 
 	nfp_net_get_fw_version(&fw_ver, ctrl_bar);
 	if (fw_ver.extend & NFP_NET_CFG_VERSION_RESERVED_MASK ||
@@ -136,7 +131,7 @@ static int nfp_netvf_pci_probe(struct pci_dev *pdev,
 			fw_ver.extend, fw_ver.class,
 			fw_ver.major, fw_ver.minor);
 		err = -EINVAL;
-		goto err_ctrl_unmap;
+		goto err_vf_free;
 	}
 
 	/* Determine stride */
@@ -157,7 +152,7 @@ static int nfp_netvf_pci_probe(struct pci_dev *pdev,
 				fw_ver.extend, fw_ver.class,
 				fw_ver.major, fw_ver.minor);
 			err = -EINVAL;
-			goto err_ctrl_unmap;
+			goto err_vf_free;
 		}
 	}
 
@@ -192,7 +187,7 @@ static int nfp_netvf_pci_probe(struct pci_dev *pdev,
 			   max_tx_rings, max_rx_rings);
 	if (IS_ERR(nn)) {
 		err = PTR_ERR(nn);
-		goto err_ctrl_unmap;
+		goto err_vf_free;
 	}
 	vf->nn = nn;
 
@@ -245,7 +240,8 @@ static int nfp_netvf_pci_probe(struct pci_dev *pdev,
 		if (!nn->rx_bar) {
 			nn_err(nn, "Failed to map resource %d\n", rx_bar_no);
 			err = -EIO;
-			goto err_unmap_tx;
+			iounmap(nn->tx_bar);
+			goto err_netdev_free;
 		}
 	}
 
@@ -258,7 +254,7 @@ static int nfp_netvf_pci_probe(struct pci_dev *pdev,
 	if (!num_irqs) {
 		nn_warn(nn, "Unable to allocate MSI-X Vectors. Exiting\n");
 		err = -EIO;
-		goto err_unmap_rx;
+		goto err_unmap_txrx;
 	}
 	nfp_net_irqs_assign(nn, vf->irq_entries, num_irqs);
 
@@ -274,34 +270,25 @@ static int nfp_netvf_pci_probe(struct pci_dev *pdev,
 
 err_irqs_disable:
 	nfp_net_irqs_disable(pdev);
-err_unmap_rx:
-	if (!vf->q_bar)
-		iounmap(nn->rx_bar);
-err_unmap_tx:
-	if (!vf->q_bar)
+err_unmap_txrx:
+	if (!vf->q_bar) {
 		iounmap(nn->tx_bar);
-	else
+		iounmap(nn->rx_bar);
+	} else {
 		iounmap(vf->q_bar);
+	}
 err_netdev_free:
 	nfp_net_free(nn);
-err_ctrl_unmap:
-	iounmap(ctrl_bar);
-err_pci_regions:
-	pci_release_regions(pdev);
-err_pci_disable:
-	pci_disable_device(pdev);
-err_free_vf:
-	pci_set_drvdata(pdev, NULL);
+err_vf_free:
 	kfree(vf);
+	vf_dev->v_dev = NULL;
 	return err;
 }
 
-static void nfp_netvf_pci_remove(struct pci_dev *pdev)
+static void nfp_netvf_pci_remove_vf_dev(struct nfp_net_vf *vf, struct pci_dev *pdev)
 {
-	struct nfp_net_vf *vf;
 	struct nfp_net *nn;
 
-	vf = pci_get_drvdata(pdev);
 	if (!vf)
 		return;
 
@@ -326,12 +313,169 @@ static void nfp_netvf_pci_remove(struct pci_dev *pdev)
 	iounmap(nn->dp.ctrl_bar);
 
 	nfp_net_free(nn);
+	kfree(vf);
+}
+
+static int nfp_vf_adev_idx_alloc(void)
+{
+	return ida_alloc(&nfp_vf_adev_ida, GFP_KERNEL);
+}
+
+static void nfp_vf_adev_idx_free(int idx)
+{
+	ida_free(&nfp_vf_adev_ida, idx);
+}
+
+static void nfp_vf_adev_release(struct device *dev)
+{
+	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
+
+	nfp_vf_adev_idx_free(auxdev->id);
+}
+
+static int nfp_netvf_pci_probe_vf_aux_dev(struct pci_dev *pdev,
+					  struct nfp_net_vf_dev *vf_dev,
+					  const struct nfp_dev_info *dev_info)
+{
+	int id, err;
+
+	id = nfp_vf_adev_idx_alloc();
+	if (id < 0)
+		return id;
+
+	vf_dev->a_dev = kzalloc(sizeof(*vf_dev->a_dev), GFP_KERNEL);
+	if (!vf_dev->a_dev) {
+		err = -ENOMEM;
+		goto dev_alloc_err;
+	}
+
+	vf_dev->a_dev->aux_dev.id = id;
+	vf_dev->a_dev->aux_dev.name = NFP_NET_VF_ADEV_DRV_MATCH_NAME;
+	vf_dev->a_dev->aux_dev.dev.parent = &pdev->dev;
+	vf_dev->a_dev->aux_dev.dev.release = nfp_vf_adev_release;
+	vf_dev->a_dev->pdev = pdev;
+	vf_dev->a_dev->dev_info = dev_info;
+
+	err = auxiliary_device_init(&vf_dev->a_dev->aux_dev);
+	if (err)
+		goto adev_init_err;
+
+	err = auxiliary_device_add(&vf_dev->a_dev->aux_dev);
+	if (err)
+		goto adev_add_err;
+
+	return 0;
+
+adev_add_err:
+	auxiliary_device_uninit(&vf_dev->a_dev->aux_dev);
+adev_init_err:
+	kfree(vf_dev->a_dev);
+	vf_dev->a_dev = NULL;
+dev_alloc_err:
+	nfp_vf_adev_idx_free(id);
+	return err;
+}
+
+static void nfp_netvf_pci_remove_vf_aux_dev(struct nfp_net_vf_aux_dev *a_dev, struct pci_dev *pdev)
+{
+	if (!a_dev)
+		return;
+
+	auxiliary_device_delete(&a_dev->aux_dev);
+	auxiliary_device_uninit(&a_dev->aux_dev);
+
+	kfree(a_dev);
+}
+
+static int nfp_netvf_pci_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *pci_id)
+{
+	const struct nfp_dev_info *dev_info;
+	struct nfp_net_vf_dev *vf_dev;
+	u8 __iomem *ctrl_bar;
+	int err;
+
+	dev_info = &nfp_dev_info[pci_id->driver_data];
+
+	vf_dev = kzalloc(sizeof(*vf_dev), GFP_KERNEL);
+	if (!vf_dev)
+		return -ENOMEM;
+	pci_set_drvdata(pdev, vf_dev);
+
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		goto err_free_vf;
+
+	err = pci_request_regions(pdev, nfp_net_driver_name);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to allocate device memory.\n");
+		goto err_pci_disable;
+	}
+
+	pci_set_master(pdev);
+
+	err = dma_set_mask_and_coherent(&pdev->dev, dev_info->dma_mask);
+	if (err)
+		goto err_pci_regions;
+
+	/* Map the Control BAR.
+	 *
+	 * Irrespective of the advertised BAR size we only map the
+	 * first NFP_NET_CFG_BAR_SZ of the BAR.  This keeps the code
+	 * the identical for PF and VF drivers.
+	 */
+	ctrl_bar = ioremap(pci_resource_start(pdev, NFP_NET_CTRL_BAR), NFP_NET_CFG_BAR_SZ);
+	if (!ctrl_bar) {
+		dev_err(&pdev->dev, "Failed to map resource %d\n", NFP_NET_CTRL_BAR);
+		err = -EIO;
+		goto err_pci_regions;
+	}
+
+	/* Read the enable_vnet config, determine how to initialize the VF driver.
+	 * ENABLE:  VF instantiated as vDPA networking auxiliary device.
+	 * DISABLE: VF instantiated as NFP VF, initialize NFP PCI VF device.
+	 */
+	vf_dev->enable_vnet = nfp_net_get_enable_vnet(ctrl_bar);
+	if (!vf_dev->enable_vnet)
+		err = nfp_netvf_pci_probe_vf_dev(pdev, pci_id, ctrl_bar, vf_dev, dev_info);
+	else
+		err = nfp_netvf_pci_probe_vf_aux_dev(pdev, vf_dev, dev_info);
+
+	if (err)
+		goto err_ctrl_unmap;
+
+	return 0;
+
+err_ctrl_unmap:
+	iounmap(ctrl_bar);
+err_pci_regions:
+	pci_release_regions(pdev);
+err_pci_disable:
+	pci_disable_device(pdev);
+err_free_vf:
+	pci_set_drvdata(pdev, NULL);
+	kfree(vf_dev);
+	return err;
+}
+
+static void nfp_netvf_pci_remove(struct pci_dev *pdev)
+{
+	struct nfp_net_vf_dev *vf_dev;
+
+	vf_dev = pci_get_drvdata(pdev);
+	if (!vf_dev)
+		return;
+
+	if (vf_dev->enable_vnet)
+		nfp_netvf_pci_remove_vf_aux_dev(vf_dev->a_dev, pdev);
+	else
+		nfp_netvf_pci_remove_vf_dev(vf_dev->v_dev, pdev);
 
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 
 	pci_set_drvdata(pdev, NULL);
-	kfree(vf);
+	kfree(vf_dev);
 }
 
 struct pci_driver nfp_netvf_pci_driver = {
-- 
2.34.1


