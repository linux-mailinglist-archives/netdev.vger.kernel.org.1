Return-Path: <netdev+bounces-48461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB07EE6B5
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 19:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958C21C20921
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CB948CE4;
	Thu, 16 Nov 2023 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lFQudKU2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09762D49
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 10:29:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0tn4OZqMAyuMJHVDzkOFRI5bS90DlASa1ZLPv1s2C0zFcpkTa2eOYa5QwgfgRK3jrnnYabVLFlBCoxCgFnt6h0uF4my+AZq7sNf1a9UON1/FwUvBmXjIZzyjm1Bp7/WmkHZqcPY3USBjg9up/SS7Xy65Iru/k+m97bRkevfiCO9GGVC1/SFf9ZF/XMTIIap/W9sV71mWZphqFb2hKWdAM4f3LIhryw1MfTyMiRxrBnf2MS4JTfQ0NaNbU+gswqoWwoodWx53LzujBI0xFXrxJsP5X3OhpOmJTAZGA2VKkustSqnM9waCjbcbQZ2U5ZeiYSbVvb2+UG3Sy4l8wzjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYCTzOpq3PCRcT6/0iN2pOWt8HagIDEcygN62WqT+tI=;
 b=LVhWWDeVkDYwm6lxS/W7/0xgPmJP5cGxpyOaE86XC8iZypFnb1HUnP/9kz6bscOhiWDGK7B/havXM4FvzPnQEjwQtQCJZ7DN8YFAmHcFmF9ufbdXqnz4JYL5qHZTvV11ERLmp+wp/DTPSUwhyHgAImLFHsee+ZT0FWuQvTqM6W+ORZkAl/UZZD6UjqzV0oVT3vqtZSirm47B7rayPQN5B2k5gAVxtbJe0n1gJRadUkebyXYqLuGZa4V5XcVFpAEA8inBVod9Yj03ygVruhL9NnphHTseYIb71j5Veg7Z4L7UwhnZH7j23QKR/+JtlPHxtrsZTlp2iJiY3mtw3bpApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYCTzOpq3PCRcT6/0iN2pOWt8HagIDEcygN62WqT+tI=;
 b=lFQudKU2slEkbZZ1O3fBgKetzdNldGslO/pmzOzwuZQq+WYwHSmNwr3D7F4Wkzf1sRYw2UZx8H2jP9ydk/U81K0C8A5p1M6hTCkuL8otcc4qUqHBHbAIv7gSbRBUDwQhohStbXCUzQiKEeWFBs/SQrT/3f3fkN54hKH0i3Y3MkAfLQT9d0TgaSK/ZXAeHLgggiy1nMdlRp5dG5IRty2iapM/p7Q1YR6C4iRMKKqcXx6TZFq2W3WechqZ5dzyYxns15Qqtaj+j/6+D0WcG3urz2md1bK2FpM4rcrYkfP6P+JtrAmjNtpP16jHNufKBBxYkL/5++9E6oMTpmupaMDY3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 18:29:13 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 18:29:12 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeed@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH RFC net-next v1 1/3] macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads
Date: Thu, 16 Nov 2023 10:28:58 -0800
Message-Id: <20231116182900.46052-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231116182900.46052-1-rrameshbabu@nvidia.com>
References: <20231116182900.46052-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 07bf0f2a-d9c0-4030-0093-08dbe6d1ee7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	slLj+fFf2yN3zJNVGRApZ37zSAiSD9q0d8T5q28NyaIA1fN+B+U4aj21Nc5R1bPKDgcAju9AVIASuAoQveojBhSRLW8yX31vL3+YjrvQObohjfc05C+wGQaR8miFITVGrLLN/TDm7QkBQjl/b9PXljknC0iPZEFQYZtInumzX3T0CNSwOz6zfmBJY6fAjpncNLLmG6bIPxF4abF8e1eYdyXFEuzLOUB9ReCBT0Wf34nJOcRdQ+h4eAm+l/ipsFUo3mhu8ZbVPA/ejwHTY43Y8YNX1TDOsh5vj4UBPbu16YJH+t1pIjy2OL9rxxrahYlWHKH/EEO1z3BzAjJkpaoyMfhumCyu+adeQImQW2OmqtXT7ogcw5uX9VUQMgZYkyYKHqmzpEc/efaUj1KhmhB6g+Mv0baUFqDFwhIbO8oVGPJb9EjaNMY1VQ8fS5xvPQVpD/vd5AZ0pPqI78+ZlBbino0RKfshP5J7PwP4MhLheONmt2qYUwuuogSgr1hnx7tufd/JwEGWwMaSkDqXZnf8pT7nYWGehzd4YnYo9HA95fECwfyNgfoS024XVZuTNuPX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66946007)(41300700001)(66476007)(316002)(6916009)(66556008)(54906003)(8676002)(86362001)(5660300002)(2906002)(15650500001)(4326008)(8936002)(83380400001)(38100700002)(6666004)(6486002)(478600001)(36756003)(1076003)(2616005)(26005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KoHT47KKsQ+skKdTTW0mA9rnvcsExKdp6HkFbdmz+fH1gTUqCCDoQXVTy2mC?=
 =?us-ascii?Q?BCLcN/nmTYPUb1hXkk9hrPNW+FkfoPl8vc19xLNb81LQ1XT3xYIIOd1HPXe/?=
 =?us-ascii?Q?qHdfyVPO8gZZJioUCW9cRLkTNLjGdzdq7+Gb65VlWKXxMXjs1Xq5ZKihLhiY?=
 =?us-ascii?Q?k4Yp6M2HHVWz5ssBkYxueC7ONh1/vJcoPw48PsYgFTA0xRCgpTWz71EQ664N?=
 =?us-ascii?Q?bwmYztrmqTEKgCQ6nFheY46oVmmiu28CmU/nhi8n5yAbmFGLSsdID8XcCvgr?=
 =?us-ascii?Q?y9bP9lMSwqlZgmVrsvIegSDqNEo60fN6yxKuQf5JgSobf4sW5uYJ27QaF0ku?=
 =?us-ascii?Q?871Jg3+vXRfO7hvB/Ww5tC4R+scO/yDFSQJ11B7+/ZcqKhlU3rm9I2jEEuGX?=
 =?us-ascii?Q?hai4GKezSGbRl4AzwalFMtRrzH2lCA2aAO/T+O66uoZ1xJJdtin8tNNa0d3N?=
 =?us-ascii?Q?YQL3KeYpH92GTfkPV26n5SihuWwW/YtLCZ+FOv30IA0BU+Ek5lUaPIrJLM7B?=
 =?us-ascii?Q?2hXO+yUeKaR+tx0WCtrwKad+KNOnaerfWPdzMtc7X5FgWkao12qyNRZWg9XF?=
 =?us-ascii?Q?v4chhgP7O07gY973d3XOGeigyH82Bhu+DL6uclZQO/fojKJGUID5nMKwC/mK?=
 =?us-ascii?Q?mmFrMMj0NaspWF2j7NTDsN0BxrNI9fADTSDoNaqXyntkhp0sXYv8AJrrS0dR?=
 =?us-ascii?Q?75alq0376MXa1/ZISjZ3+QxhON+9XY4et3VsbG9vaeB9tqI+y3iBcdVDR/SA?=
 =?us-ascii?Q?qdawsEXY6/8Vn3/+qPnYaP1jyxgsWciOcHWe5RPmX64mjMiukkTyyWuy5Drl?=
 =?us-ascii?Q?FUrdxv32hbjE/LCuxTRCD7g9DC9CnAo5o4Q0S7LFJIr3nW/AMaXSbsKu6e0M?=
 =?us-ascii?Q?AkEbHMbut1VSi8uuwMKHJFkVlssFq7eKfdRA54JdsUrVy76FZ/dImgTogHtC?=
 =?us-ascii?Q?IR2YC44b8Gpa1SkDLyRSz6EDOrj4n33iBySMTcZY6ZjZV7xMzQ/nT6+dg6jL?=
 =?us-ascii?Q?M8AOQ8QAMXu5qyLhirfZy8JNKbo92sWygNXy7HfTX25TtCQuX+I/JP1RnDtk?=
 =?us-ascii?Q?rOslFgDZvJziG52XrTb5YKDanscLKsih8pQvmiCwZeJ8RVurpZpUfILCG9M8?=
 =?us-ascii?Q?4Ytttsn3YiiKb2exRtg+6zpIgGvFsBAJbRsu5mVR2DPs+kNOwH81y5WWivfl?=
 =?us-ascii?Q?paZBy2MeabGm00XPY4cGp//yWKCDCnf6oRQJF4FidGqFpiDeTmSKYK5JhHuF?=
 =?us-ascii?Q?7/0WPkRjS6g4+FFpo7UmF3vQJVsUnjNGFM3wRJ3sXaL+6mvQMpygnjUpsCuc?=
 =?us-ascii?Q?B+MBhCX5DOqmbw+ORCjw/a1HJ+lAkTly1wC99r4CmX8qM+987x+6Qw5jG5tW?=
 =?us-ascii?Q?rBpBCDFlojLcEbBM0YjKFXImnDjzIXLuQDw+YCYnyoQMgw/iSZDTP2Ssk1Aj?=
 =?us-ascii?Q?YtkgNjyT/fSA1w/VH7tL+hPL09KjXShB/0ND7miXaYkhnxJSZ2q4oruTLYNd?=
 =?us-ascii?Q?BpfzPjj2ncmU2xNhyoA2fcRmFDUvxiaAVxO8JOvxhWjKPz0XnuCbwZey+Mcl?=
 =?us-ascii?Q?U5mDIvwILUSHEsTdBfLeYJpFktxKWHZd+S1T3Ri3O03J/w9iWRedbO7o1n+j?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bf0f2a-d9c0-4030-0093-08dbe6d1ee7f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 18:29:12.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gd3O5JCOlp1MSWz/o3C1JDkwWKXGemzr6szvxgIvezDpP6l/2bvKi6z/hQ+mEwUBoLe0lyMRhKgVcyNAMPu+kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

Cannot know whether a Rx skb missing md_dst is intended for MACsec or not
without knowing whether the device is able to update this field during an
offload. Assume that an offload to a MACsec device cannot support updating
md_dst by default. Capable devices can advertise that they do indicate that
an skb is related to a MACsec offloaded packet using the md_dst.

Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 drivers/net/macsec.c | 3 +++
 include/net/macsec.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 9663050a852d..8c0b12490e89 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -93,6 +93,7 @@ struct pcpu_secy_stats {
  * @secys: linked list of SecY's on the underlying device
  * @gro_cells: pointer to the Generic Receive Offload cell
  * @offload: status of offloading on the MACsec device
+ * @offload_md_dst: whether MACsec device offload supports sk_buff md_dst
  */
 struct macsec_dev {
 	struct macsec_secy secy;
@@ -102,6 +103,7 @@ struct macsec_dev {
 	struct list_head secys;
 	struct gro_cells gro_cells;
 	enum macsec_offload offload;
+	bool offload_md_dst;
 };
 
 /**
@@ -3525,6 +3527,7 @@ static int macsec_dev_open(struct net_device *dev)
 		}
 
 		ctx.secy = &macsec->secy;
+		ctx.offload_md_dst = &macsec->offload_md_dst;
 		err = macsec_offload(ops->mdo_dev_open, &ctx);
 		if (err)
 			goto clear_allmulti;
diff --git a/include/net/macsec.h b/include/net/macsec.h
index ebf9bc54036a..09ca118d2df6 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -255,6 +255,7 @@ struct macsec_context {
 	};
 	enum macsec_offload offload;
 
+	bool *offload_md_dst;
 	struct macsec_secy *secy;
 	struct macsec_rx_sc *rx_sc;
 	struct {
-- 
2.40.1


