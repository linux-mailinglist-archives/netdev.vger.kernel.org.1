Return-Path: <netdev+bounces-279230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHcnGmfC4WmLxwAAu9opvQ
	(envelope-from <netdev+bounces-279230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 07:17:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A00A41708F
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 07:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E3F430275BB
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 05:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6BE282F23;
	Fri, 17 Apr 2026 05:17:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEED61C84AB;
	Fri, 17 Apr 2026 05:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403040; cv=fail; b=S5wCLC/W4kso/9O/8B06pgh6Nmq+R6aKDu9JChhWtdNQgQ74lp6bEZpz7g3SihFhYte2zAYWTiip8ycM+E4v1jMmijH+1SgSdFD1ec6aMvQmSM8uScjtGFOYxPguFS4mAy/t5Tqt/AzmsjnsJAZpuhn2GlsNJjKcztHv/Etshpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403040; c=relaxed/simple;
	bh=B4fdwKgxN6MfTsRR69BeQKN2Gc9WGr033J1bWbugXg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HAyKQtrCBgRQhobafV4vh0H3FP/3SSjyL6/DukaOiO+9pPH0tL+OlMFSAAjOHkUH5ZBvNjWwdlXdHQREdtEP95vqmgzRHdKd3wD4ZnRNmAlOtSL+nrgiE/YCpidOKgowkNVzifm5iqNPuoQm6DYgKuWxiwgpbFCbfD59excwzLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiV63H6RaVVJbd8upp1RbYfGS1kp+naxldhhZjNRZeQ5nbUfdmiSL3LiuhuTVKGLD0un6wwNp6HyovxprcjK/4pGI6SvRC9tkGaooUwLyBPD3659scpXbLzwuCZB+cn6Civ+rsMvliP4tfG4bSYADE+AiAfJjrwV5LPPAup2bz0X/efaYUB4UKFyh1vSoEXX063ZDw7klRE/nZ/shze5G795ZQDQAsUHda4z4rqvb/lH0IWH94jPoAJ9K+W3MsWuNSomYxo6ze1ClKCDIGxwNMdXuFz9NA5IuOWEQE9JPXpMloNpFbz6uekUF8oT1FujKHlr6TwSAjBy0lknYfDo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtoMmKFE2y8g6Zs6HD8pvwL5h2PvrVlYzSzteURIgxs=;
 b=Ax0MC0A9jfur0swEe7+ytiOAkNSyhwQWp6Ue/6VJYLfm3Qc/Pc3Y8T5cQ5g1kAXLz+nUjRcDAbwfdYxnCJw+0Wp47hAtUSoEyrcEsAImxwExpZGdx1IdQFFYh/56QEMJ3uIiAfMirHm8rjfonBm70wU0ZstZG/89p6ZpNGSaLVulU9NyeMGtB78Ea8sXzIoKd6FGnmnTX2q6uphrwns5MXRRXWHlys9+mLaSL9sqM/DOtVrp36hzPUeu9lDcYlu5wHY3epRexnlfpYr2x7aMFgW4MCttbLryoEA2yDNevxk7AnZHur3hPzEZVUBpiC0gw5hODdxaMDWxOYlSBTXeiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0517.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 02:45:37 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Fri, 17 Apr 2026 02:45:37 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v2 5/5] net: stmmac: starfive: Add STMMAC_FLAG_SPH_DISABLE flag
Date: Fri, 17 Apr 2026 10:45:23 +0800
Message-Id: <20260417024523.107786-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260417024523.107786-1-minda.chen@starfivetech.com>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0036.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::20) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0517:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee31287-ea0d-4c9f-768b-08de9c2b67fa
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 6jNxFlTrJXGkVs1Yb6k1xl6Fm+gRS9h8nMKOgOduk1ZCa0zdhPH36hZLgMAJg0bKwAKvhLnm7u8bhRF6V5g1ZkwkSFHWQNmC2uW3UNg2CF2JWhZzD0Bb6xiaoPWM7WcN2ycX09LcNSyIW11lKiv7CSuISMzNjhcfMBJUd8PQFQ89cZXCPvi9oLlk6V5vlQNAKmRCP6ip/wQmp5+7ourn7wefXB6weNUax1T7SChy/ed70e3lxz0pt6rva2P+aPeMzk8/C8pIEAK+2A5aHWQC0ygWalRhKeRv0JbQFE1KDVFp4lktL1bsZvjo+fYineBAGAxrdoJse1R3+MbqJIlgNYdRk8AwiBLL99/mT1I1KsCeI4NOx2xx2imlFbrQ+0FYT0Nc0gaEexOSZM32wlaoYc5HBrIFzdp0t3EWigT5VwhLpjXU/CyLCJrhLnG+QMa6baqu/p1OjOjnFc3wgmXGH2SsYjyCfqBOuKeMEN+EVTWa21vn+QhQrPwCKT1GEwCdK5NpcT4YAUNbJ+hOM/oSHSSNlnx4D7ewJYZJacEU2nvCoabbkH+HXEkINeSY1iIK2xF/alo5ZJWNivMXJeMQ64+deBe18YtXIQki4VMDmWU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Ik86VFYIZfUixK50YaVr1BYf4zAy2hg4gMhV2n+/bjVz6cz8apwgpRe/mJzh?=
 =?us-ascii?Q?dQ3HMBkpqOu2ynLc1OVKjj1z/CfmnyFrAGS/LLo/ixtydgo2qLV3QFBj95PO?=
 =?us-ascii?Q?ByAWaXRfM81QeoeQKT2HmEMQK16RKhLDGwo9Htqh5s0yZx3W7IHVX01cuMd5?=
 =?us-ascii?Q?Tf97eCS8QqTPnOIBAFDhvmSHkiOFar17sxKLyLa8sLMAtRYdQnB4of1M8WiM?=
 =?us-ascii?Q?Wx+MOAqpaDffjxLjkm9b3sRh0HvcfgUux4rJD9+R+T8yQFWiYPTyv4bbZXfA?=
 =?us-ascii?Q?+QuSXrb+G+AHS9P7/kCUtx/B+K9Bz1XcL239PDtEX/9vWAjno/Sua+VDnU7z?=
 =?us-ascii?Q?72H49NShbqTS/0jlApqUKGozjc6Cqtf96hRF24+XCWFpdkiBzHtY73j6LLPj?=
 =?us-ascii?Q?htcjk2AZqqY2mWndqkS84lqByqjUPO9UEbABflhkNJKgwmSQFhLxVphzbRpi?=
 =?us-ascii?Q?B2TlWM9dOzi72N7bXrfSSqcrk8jtzmOSYUX4nehYzllAs08CvnCkdWGGokTq?=
 =?us-ascii?Q?lX7G45SGemETNAnmp5vu5NEWygdhbVpigiLSjHp6Ci05VYJ+laokQLtdB3aN?=
 =?us-ascii?Q?8MANry74bJgrLMj3hzO7dQbPIBABF8PnxTAfEOPck8zkx9wyCxSQhRz81kMG?=
 =?us-ascii?Q?MU5H1sSGcb/yAkMvmFPvM16b0sintn0wcL/y2zvG0kLaeM6VfblXBCZvHm2R?=
 =?us-ascii?Q?dtbr3UUmlyMMoqnM5yvhGTfQ8cz6qS/VbnBsJ+UvWY4jTYBlNRdmxAWwDDm0?=
 =?us-ascii?Q?vFscSvploJ5C7kLzh/WzdU1yC03DRxrm5zlCLELYvMdL/bRonMjyFTv/pPGw?=
 =?us-ascii?Q?TXVF/Zh7oyXhPIXS/F2kk74+IdUINa1kBy3vsRikn4rO+KmhmPHB3VzSMpEr?=
 =?us-ascii?Q?iaVj/I5y7mTsFUwc5Ntoe6lAdFLc3vV/qeBFxwDZIQT2KarOuq0WuGmHVUiw?=
 =?us-ascii?Q?4QWF1EI7ggiLKNQsK6S0L9aLJDE7cjxV1SIWa7805DeNOOGGRInMspzteqIO?=
 =?us-ascii?Q?yu88uCAPeSHkkpjb0sEEpNRhUgzQ+7o1zMcFFEotAXztHsnNl0it8mQ4Kcxl?=
 =?us-ascii?Q?87KDbAB7u0U3Cg7WqoI/rHHx/CFwprgkYSz6M7qPjQ4FywBvzHzZMNB8yGYH?=
 =?us-ascii?Q?+iv/E5gNfe3IJV7RX2RvlZsEiKGZgxZv5g/V/MONnwW/clyOvdK0DbZH3dwH?=
 =?us-ascii?Q?DNFw3NpDdCXovzmRVDUDjdStdxWOJxx5FYSDHZOOcmzc8B62FZ/fa9kviRfi?=
 =?us-ascii?Q?JNpGUEVRjTDUW7XAekZQ4RwJSwEpR1L+rDPaSm7zNlBiIonaaRSvv3s06R/N?=
 =?us-ascii?Q?G6xFSfSwDtpmB1E4DbSiZKvuiGO5b8ymOkiAeNcTBS8OzJjOcu7/WDeqmhuo?=
 =?us-ascii?Q?WpNgMqj9/IU+DRZ3mXrxh2dHfj4HsyDkssxwkhpLB9OBAU+5GG0xzXnoMQ+3?=
 =?us-ascii?Q?FwtqU3aXz6vWC2tHFY5dVdHIrJuBaFLv1um0pRtSz0mMFypL4P8wtZkCBuGn?=
 =?us-ascii?Q?5sTF95S52LQHy3BYPi1kEeQDO8X3kyKlvMiYKltTR8TAlCQpsfhTQJXoY1Rv?=
 =?us-ascii?Q?D5rIfWtcOfHY0PuEXgzLeRITYqH/L3T3ilAp9MMymc4mdb5XW6698GY/A5gZ?=
 =?us-ascii?Q?ewceOXfWaW3AGW++r/+vLv7xpzCHPbibkch4RTI3jClDXQSDZTNV2mXt59ik?=
 =?us-ascii?Q?Rvke0VHvyCJYNPmvqS9XYA85a9tEJk2/45RKfEwlMASgS+Ew1KFZXaQjtzQc?=
 =?us-ascii?Q?/PEEqBJvtnoPEEF3mnYJKySjYJCrQFE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee31287-ea0d-4c9f-768b-08de9c2b67fa
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 02:45:37.6643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSy9fi/2RFfDJ4pvijZ2/Na1IACHwdOZ8c1JFsTEwvRgbX7XPjE4RlFpCSAQ9TsmP308wDc/L8b8rJqkvEMdoCBJNcRryY/cQHbm13JDgfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0517
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279230-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.539];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,starfivetech.com:email]
X-Rspamd-Queue-Id: 3A00A41708F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add default disable split header flag in all the starfive
soc.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 91698c763dac..9146b498658d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -145,7 +145,7 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 	}
 
 	dwmac->dev = &pdev->dev;
-	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
+	plat_dat->flags |= (STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP | STMMAC_FLAG_SPH_DISABLE);
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->dma_cfg->dche = true;
 
-- 
2.17.1


