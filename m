Return-Path: <netdev+bounces-54476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08343807373
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82FB281E8C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A2E3FE38;
	Wed,  6 Dec 2023 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="OHLi74/s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2119.outbound.protection.outlook.com [40.107.244.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE42112
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 07:12:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2Zd7+jb/wOOlowhwBMW4KCuKoX+iE+QuwGahZzsWBu5fJJNupREHWr+HWLCq5llAqvAyYRBpWL/wiIQrNn7wT9JtUu+AVBe+DK/ZQMRk84Uy+qEgJk2y7svXflHPzvPDYwz1oz6Xo5trjcr++EH68iZCYRW8LqLZuODoN+ZUtjVXLCKdHyXSlFQgCyGL8hhOcCHmp0yL+jcbWjW8+kXTvzuLPFD73qS8oZbO8PzivpdIjn3u2xf0+ZdRk/exbIvmPHU65I8ZZcRTjYJCnukN1NA3lHaVOkhOk8w8V1xPL/tnsW1ynYBCylRF6Cm9OjlW60de1XJCfnQhsPJ/C3mig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20dxaEgOIN+DvVzwTjKnC9EmUy6RYdz02QUEWA04MHU=;
 b=VX7fgfguSVZ6zBnnNL8Ou34REruqIBupG4LwhhC+cXgD/2PqNfjCNzYA5mKgzuK+7THp8ab0yIPLDBHPeDHGY4V6MjIxku/nJbQoNwVUIrhQsGlMVq9T7bjHfJr3HoPN735rCEwbFBQulMm13ZqFW1U+tzL23EQyFAl7UOAx/cB/ZTmkjVB9USkJ1XirhfQY5Oyfr4DQgM8iLg0bV/aTsyWuukMukm7GpSUyi5xblSuo0kLHk+KhSatUr5DAB1fatAKJjaG/SB31fipOU73h+ZqSau/WrtqbregTtpfKi3SOVcilnLvnOK59cFb2yMUnk9Sdq9/W/eA0XJZgDLUWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20dxaEgOIN+DvVzwTjKnC9EmUy6RYdz02QUEWA04MHU=;
 b=OHLi74/sU3GPfj4ZPUNqnXribYxZkoaKrVRC1TSXlKWwmX7v/qqAP+F5B9a2jDRhEkC8a144H8T22tAaofBKWgs5kxhKnxp/GW8v5RV9kVnJsgpwQpOMBcnt5uSRtqLbpT0/HPkqY8GGLl4vzEOCUToiYZzgvYsjK6i2VgdUQfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by LV8PR13MB6421.namprd13.prod.outlook.com (2603:10b6:408:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 15:12:36 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 15:12:36 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ryno Swart <ryno.swart@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 2/2] nfp: devlink: add extended ack report messages
Date: Wed,  6 Dec 2023 17:12:09 +0200
Message-Id: <20231206151209.20296-3-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206151209.20296-1-louis.peens@corigine.com>
References: <20231206151209.20296-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN3P275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::10)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|LV8PR13MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: bb470232-74b8-45aa-76b9-08dbf66dc758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jj4nyWzCK1i8Vfi4HLPbVMOr5RyF2Gy/z3v0RIy65lbAFyYR2QJtsyOrv3C+KO4D88ZUbcUaqpEEwbFMhMD67ylsGLTc5DKLH479fA23EtpKnz5ScWA+55PCNE9uHXuI4WRTXMtOP3tsvtWsoDQnuTgTIemwgbQ/gOGW3XiayNVhiW3nWTkzq2tKlHybH55ghemBRhiHUMrLhoyuU/cPMTKQXSm4UOvnQWDAy6uxYTphkZswG8BcZpvPvskpog++jNU5xqJ31Vhvxo2UAgqO/zkrb8wfFtnOddRG5RMenC/RUtu9Sqdc8/P6m73fEYWn0Yq1X6LKJVsDL+eZz1bLk/iGcju7kD7ONrdShcIIMJYScfgFZwBDkngDHCT5ZutMpY1npfjxDytCviwGyAsbimV+OBA8ya1VRinq094B634svc3TNg9hUQ3sCObpRaLiXXRMHDoibRuTNptTP6/qJLTFKyQehQgSrA/+quZqH5WuDKRgkPs/IHjlS1vkCFiRAfn1JGf2gfQdu+dc9rd9iMjbh64e9NntdBp/cXyzLLtCXbwPEFL4bvBP3TprV6sSXWKLihLWC2k5t91wXimp8mCnlkL6mNj18cLJbzyuhqXlif51bpWfco666YbqE9opP9Q8ePxw6+h8om4U8Tcy7k5lsh/rTHleRqpOYMEuNqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38350700005)(4326008)(6512007)(52116002)(478600001)(8676002)(8936002)(26005)(107886003)(2616005)(1076003)(6506007)(6666004)(66476007)(110136005)(66946007)(66556008)(316002)(83380400001)(15650500001)(36756003)(6486002)(38100700002)(5660300002)(2906002)(86362001)(41300700001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ltE+89COLs/C1LokzIMKSm3mD+fa3zl26KP+/Tu4qt+aztqnTUR2gjni6aP?=
 =?us-ascii?Q?yKN3s3GPZp7MFY0+5AZUmYvl3O8dSurvTilDgaPNiZln/Fcq4FmBizW2V7uP?=
 =?us-ascii?Q?rs0TBW2GaAg0g2hlA01OsVcXxmEJ5PqkKJEfVdXHwtH0KcoMyhbfgbheiznP?=
 =?us-ascii?Q?MQGKvDxvo/aTb/MHWfhhQYh/JhnE0Ymqyho4UIY0plJos2q+OgoPl3sRVw1x?=
 =?us-ascii?Q?aucIUanXTljv49dI7Ao2BzY13KHIw5rIxm41bhO5941FJOwHKD1FyXIcFNkH?=
 =?us-ascii?Q?S8nb59Jr+cKpRTxcFL1r14NZcKPtIr7QXBzQgaKFOj5Dod5v+0KUudxRQnIB?=
 =?us-ascii?Q?xlQiDa7suRrK768zc+hL7eiXBbgHvlMcy3WRHysIn5VA+O3G/R7Al95D+C8O?=
 =?us-ascii?Q?h52JA/iJqoKa05PkBNjSu/aiBYegR5UNmBAwS/mzgKMknbCrr5SHA7c9a5eC?=
 =?us-ascii?Q?45m+cuEGSy4Z3oxmVBUebhc+cnjJtr5K1HJGYKIc7gJ67uAj/9KMk1GAbPJC?=
 =?us-ascii?Q?AuEqbyljLhnHDa2q+F2ElOCGSPh37tm2RSo/tWG6fZoPuiVoAiYV4RI0StsL?=
 =?us-ascii?Q?CtGaTvgpWFUKsVCwF7iwKdmiVQ/Vg6QjWgJB3JqMyjn0hRicbZegeC12/mL6?=
 =?us-ascii?Q?QfGyLNlub6vSPTDElWIZMo2cDCGZk8UHt2WAl3qjdjHLrFjEQ5+VEQ+W2goo?=
 =?us-ascii?Q?umeF1hpzFjm1JhoopI4fAxzPKDyK8KryYcKOrqPGooppT8XDKNrIt2khQ3MW?=
 =?us-ascii?Q?ve30x70k06OyMeomsJIAac7xuwgZXc0yUrTJTTrLHiP+aHw+1xeLtFWO2rlw?=
 =?us-ascii?Q?0ArwV1lCL2z4VDJhy7rkE9AWA82wfcTiZGxWnXbIDsJI2q09LWMicqYKsVL1?=
 =?us-ascii?Q?LigCwhZw+DSJHcOTYa4Ejn0ztJYiRI450J1QC4mJVE1R5Bvrm+kdxrdxbNwj?=
 =?us-ascii?Q?49o04Ms2i1JYe8j6lQersTP1o9d5jxbhmj6JkqO+t3Y6kP+A08M3NhdXBDt0?=
 =?us-ascii?Q?BfCRLGO9Mu0zl5tSm7CqrnpkiSNoHl9nLmlVZtj3nhKRafWFKzvkBpyJEqyf?=
 =?us-ascii?Q?z+74zJpptJLZkAuQiSdLPrrmHEajPUqjnOzdZUTVze8HgLY50Cy2u5F5RgmQ?=
 =?us-ascii?Q?oTIWqUrnVEGqN4L/b/ZetcQ2RW8PjMT1jrkOCnfgqB9YFsIE+RFHYylCs+ZN?=
 =?us-ascii?Q?2I35ANanvzB2kyPJvJuYCU/2nhhF5LO6sn1IleFlapPpyv4YJMeEIc87AbV9?=
 =?us-ascii?Q?D3GM+HKnXBr8TlL/o3CVf7fUjEuZIFJonO55Ez9lbG6PIV4ylz2NWmqM5/ds?=
 =?us-ascii?Q?Kh2Ij39PuEBhCI7S8pVf2V2Zyp+YYpLm8jZmOWZWeNZ3ymujfTVTE8Gi4zwX?=
 =?us-ascii?Q?pBrdG4RNtz55m+eHF2TqkadLJTPsIUgnoeZdbeU67bcfGhIom0wnA8EKDQ5O?=
 =?us-ascii?Q?WWNTTn8Q1V2lYzloJE9jFvOc9/XVWavCNACtAzxY53faFuGyO3IH9om0Ehsa?=
 =?us-ascii?Q?/5tVd6AMQoiIH/kj9u9QCNviLnU0hyBLK5+Et9udfoP0fpZaIawh2cjEFiI9?=
 =?us-ascii?Q?vbakQwf/GpQCIH2E2lpHaSHVuEgXG1M68y8vK9eeJcHeLu9AnEjQbuILMcR/?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb470232-74b8-45aa-76b9-08dbf66dc758
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:12:36.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdVqoNMdtt7OQay+oHo0X9Lxpku1LPV3LbA525HFX0r4ZzYjos0elDrdR/p67vTk1Et1ZOZJLZaRueg12xnnkXThQVTlDdzC4oSX07fzjfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6421

From: Ryno Swart <ryno.swart@corigine.com>

Add descriptive error messages to common devlink failures to
be more user friendly.

Signed-off-by: Ryno Swart <ryno.swart@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_devlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
index 8c6954c58a88..635d33c0d6d3 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
@@ -75,8 +75,10 @@ nfp_devlink_port_split(struct devlink *devlink, struct devlink_port *port,
 	if (ret)
 		return ret;
 
-	if (eth_port.port_lanes % count)
+	if (eth_port.port_lanes % count) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid count");
 		return -EINVAL;
+	}
 
 	/* Special case the 100G CXP -> 2x40G split */
 	lanes = eth_port.port_lanes / count;
@@ -101,8 +103,10 @@ nfp_devlink_port_unsplit(struct devlink *devlink, struct devlink_port *port,
 	if (ret)
 		return ret;
 
-	if (!eth_port.is_split)
+	if (!eth_port.is_split) {
+		NL_SET_ERR_MSG_MOD(extack, "port is not split");
 		return -EINVAL;
+	}
 
 	/* Special case the 100G CXP -> 2x40G unsplit */
 	lanes = eth_port.port_lanes;
-- 
2.34.1


