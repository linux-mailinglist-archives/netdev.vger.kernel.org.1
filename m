Return-Path: <netdev+bounces-276371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM/rADYb1mkxBAgAu9opvQ
	(envelope-from <netdev+bounces-276371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:09:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 553943B99D9
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29184300E5C7
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26237AA98;
	Wed,  8 Apr 2026 09:00:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2117.outbound.protection.partner.outlook.cn [139.219.146.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2837B400;
	Wed,  8 Apr 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638854; cv=fail; b=iGj4iumFiVWt5WJjnY1OwfvXN/UUIa83fbiaOFaB4E6Yla8Sx+zxViSlm/qjhG/4ILMz4X5L3zL7Ixx4JPrm94QKHq0DLadBEYyj6TRN9KAa6TZ3Iwrcrj0yEiNWlvXbTy7rYZ0G5Ehg3CIwqzmB/Q6SkleOr2c8f3Kf1Ieo8nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638854; c=relaxed/simple;
	bh=uL0T2Q6IGrVUwD+j15L1Yb5Pue5BgSgN+CQOpv10TKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LKp3BsbytxXQABnMVOl6g26izFmcGPF8eJUkWqPRe2BbKn2LxRq/w1XXZWrslcpvob2KvyvBKkiyXh6LbWTTqwZKK6UYXI2qdpU/WGbpDLOhuUKoToHgNmKhPcKqY1ela+xNA2hNMIO3vDzt3KQhmneV9ToUjXove/XMKE7Pb9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCMJWjxRC/KYSG9mmvdNfJWz/pBqv9KxLM5QqN/zQvvgVruY9otDEG8AGoa0cA/GwqMPgHFe+53652kKc5VkQtScRTMmCFxq5pcgS913rjcuvREoxAiecX1oGGLvFM1w5LrZePtNuYdCHRi2LCgcVFHCBQGDIkvm+unAntUOp+xwjzknrIRU8ZTi1JjXpXtbOwdoDf1pcWD1/5HNlzP3vxhUNtxbInSGk/cJYcRPIExK5PxDCy0QVBBF2Fgv0Zlte+ngplgYU8jJHaSXJeAKyQTQzcQgl6QRZZTPoOHDO5+8CN9uaNkqOQowKR5z3orAJ0kMo+6OtpeebMoYcoDVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXvusO1RjJoBXHgdf+Pq/nfY9A3xuK6ZFIb+vRfBuTw=;
 b=UThDs4I2/C4bdD3qZ0qHO/32y7FNJPpXM2f7ZoYCTv+FC1tsL1kRJg6muTPc2XOC9bIvfE4P8W49mUZkEq9je37XSTWCedukIsF6ydZWhWFOf0crOykTnKBzilcYO+Z5x6MeEF6gaK6jx5cd3daSKkSFgwpu+QPqq4pBHdpOirmfL5yo7QAEjdkSbiTl/4zCfnBa+Dhy+EFMetrEnwi0T3u0gFr0gNfOErroqXIUQ3k3nYT6grZG8U552gOI/m5Ls9YHZqGsto+0RfRbOAS5kWT42g8SUxdoaCe9qQ7b7uNu2sYBxlkhToS3FZU/UB7wRsxJQPE2O/8Lsqsd/bofag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0719.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 8 Apr
 2026 08:44:32 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%6])
 with mapi id 15.20.9723.018; Wed, 8 Apr 2026 08:44:32 +0000
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 v1 5/5] net: stmmac: starfive: Add STMMAC_FLAG_SPH_DISABLE flag
Date: Wed,  8 Apr 2026 16:44:16 +0800
Message-Id: <20260408084416.29753-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260408084416.29753-1-minda.chen@starfivetech.com>
References: <20260408084416.29753-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::24) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0719:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2ea31c-33c3-4f68-e4d7-08de954b0ddc
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 iDnsiQWVfklbgTJz8deSsr3DAwRdoF36Lyw04gwGc2eJELVPV7/7Kv8PtghwVczJhrjwZxWEUGz2qq5VG4NTkSIE60gIe7niSDl17d5GqncQHWYKvnlubcjnlseuz+0H+2g7Uq1ILffMnJH3eZ2HYQ4C+1F3uDB5HiDetC4yAOdFV85vURMmq0uw0PvxVwGvFiAn6YGdM01Lvg61ojc+OlO+hPQidkQw/hLfDUngtgF2c/jowexPyoeCoqO8LdUNpNczxc7K8g1MQ3p0BmQE1DO15y9J/WiN221ElH2pG7w87Jw53CENJx7ikbhZ5BgtpRUtU8r+uYb5VvwI8vZTDm0aPhJDYilET4JeXUc0aRpAZwDaGqJsA3tpF4VVuKRuFw7TuFHbIVIcTh2xFJBZaggpj0SjrNYfsk+MW31ItAmbR8Z1g1rdWt21+l1yAEU47FZcDXHVpD/k+8KwjQPfnMSJo8Yi1T66uqMpcIDzMzTpTR+w5zrpm2vZ1qKpxEXZvSGSJa6X+aTgOdj8sD7kCa778P7dqmdDrnIBPOM45LnjRdwkmpQf98dxd+pcMBJe+8BTJJ459Go7UEaJCAd0iQm067cAZJtmqNpvI7hXzfo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?+xDbuokYrxo1AhG7gE1XMTXPR9XKqx1ODsZ+AH1AS6HyGODkA1Zsoo84pIAx?=
 =?us-ascii?Q?5h5G3UNQ6Ys+SX4Bh2wvVQ6ZIugYoGZ7YqPya0E4osCPo37ZMzMeN+R1mBI4?=
 =?us-ascii?Q?b3ZsWWP4MrsgJ7kQBYUptsDA3U2HzVQfgsEehTwWI0F5TzmYOCNvP53C7opB?=
 =?us-ascii?Q?YwR/hBvcoROvXn1JvuYxCmylM61XYuwSh1Sf5BAi07qwSc8l1Hk6ky/AmE2K?=
 =?us-ascii?Q?xU3r8EDLnwBIiVb80Cajua40lsBR1TSCIPjCQnipD1vOWoCZlFhjbeuWO5NT?=
 =?us-ascii?Q?sA6tjtuianbCp2g6E5O/xwn//qQTCjG746RzJNDgmun6+i/A+r45+6dEX2dM?=
 =?us-ascii?Q?AFo/2s1bSrIE1BpM9lv7Dx62ul2usTDqsqaWklw7C4w4zO5BoFi4jQs0UVNT?=
 =?us-ascii?Q?03FkzCiLVZGOrV41TTLoZHCRa5j2bJNiRgwGsspOfbJDysus9lITU5Sy5kst?=
 =?us-ascii?Q?/IiYx1esWL3CRzddzxXoxob9pDgJt0PffrGKH8LwS/H8W48rvyHNsNlYBQBa?=
 =?us-ascii?Q?7Z2nZBiw2dQr17/gDuyduZhZ/qdPbJR4cTMBdBowUb5mm4l2wybW7ochpCtB?=
 =?us-ascii?Q?ObjMfCEJFdrXudw23Ehz1tzbvkq3VxLpSLhxvle4J+07L990RMZAXh4Nbmez?=
 =?us-ascii?Q?vEVBXbZV5MFXGPtTZYpnPFu3623DyMC/s6+Eh5wV7r4mDr5aIv0Ch9dV8k+R?=
 =?us-ascii?Q?kQOUXHfZyDgTNJnUZktEdWgda51Xb1H8IF1qQCIjSL55S5VSsyswE9mtMt5x?=
 =?us-ascii?Q?lBjhAvtp0GetRfOlcYHyyaxzG448hCl9Cuqm+QGY6rpw0pztx2NY+iN49xA/?=
 =?us-ascii?Q?KfFooZxnqV/LmfaW0hrSKaQEmohraOX0BUctXtm0Sumt8cPliVR08lvOEg8F?=
 =?us-ascii?Q?hl2L7bQtk/WxHPclz8cwpnClKA8HbCyvvrEM+v1I461gQjHTs/V5rYQu76Ai?=
 =?us-ascii?Q?AWC/g3x7U2hNyA4GdQ4DoLWF5mrFJfbr8wXNjtcgfVJ2heDo9d+98A4MihQl?=
 =?us-ascii?Q?lTWEfuxVDfW0GBmWLb1OQ0BOQxcLEs/MX/G2lmResQcH91OYmQs+2Sd1H9VD?=
 =?us-ascii?Q?FrnXA2jFsreJembRtSCRtc3lKI8e92Fdhl01JHWpjrSCtZrh0BXVE6S3BFUb?=
 =?us-ascii?Q?YSj09eSAo5m54fKohsAd6vjS2+wMvfGQqqBjaIiynMG0Vcx2PIb/n1RWEv7A?=
 =?us-ascii?Q?OxKMBO9Dq+/2lSOVE2LQXBhK1wFA4q4RByajxvs0VHhUZOkEUtBGxdjb4qvv?=
 =?us-ascii?Q?9c0nypdsMBYJBMmul6759ICjNhiP2wLjCWruB3CpPVnAlq14xNodtdxeKxiO?=
 =?us-ascii?Q?EIcHdILSjkhX2ekQSRxrrPFFMiwAAbHSWudSNyv3TutK78aiHAe4MIvSfyhE?=
 =?us-ascii?Q?jZSTkwSbSqkBzMhO1K5uTnm8kEfnRNFzKIIWDvzXCVJcYDRvTEa0jsgSsIOx?=
 =?us-ascii?Q?xgfVTGragVIgoHFsaLehRxIjykHlN4+Mna8HzD96Wu9hAZv3Jh6IOG4Q8DUy?=
 =?us-ascii?Q?AghBaN3yGCa97RSR07doNrr/cOvCQUFfRIoVss9nPLydpjQUb4VUHQb/Zm9f?=
 =?us-ascii?Q?sPMMbBUPzndvo05M5XwU9FMI3e4IZbDv+hN7gpqQZcteS12kH+BfWj8iqfP7?=
 =?us-ascii?Q?mWYMoV2hgbrq5fNmcZzKdYH37rfumc0Sys8jQKsj4xWwg8N/G+KjQb108MYo?=
 =?us-ascii?Q?b4885+BxtigaIROc9X2SDnWaOr5EtoWXtCQQjJFe0z13Qr77mEfs2plJlGdE?=
 =?us-ascii?Q?xGTDNx0imQD2ls6NwRhv+Wrl00hR4gw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2ea31c-33c3-4f68-e4d7-08de954b0ddc
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:44:32.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jq0evoQL/iI6WTiXPOs9yqvowV9cJxo+OYv7kuTHHYy3FURv6haFSUfu7FG10oB9aNz/k+DJM2V8NJvmVqAApld4y9Uheipmpcn4GDFEZSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0719
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,linaro.org,vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276371-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.704];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 553943B99D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add default disable split header flag in all the starfive
soc.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index df7b2fc9989d..f6e5a2c4dc27 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -143,7 +143,7 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 	}
 
 	dwmac->dev = &pdev->dev;
-	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
+	plat_dat->flags |= (STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP | STMMAC_FLAG_SPH_DISABLE);
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->dma_cfg->dche = true;
 
-- 
2.17.1


