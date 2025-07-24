Return-Path: <netdev+bounces-209805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FEBB10EF2
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD901D0172C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3232EB5B3;
	Thu, 24 Jul 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="aCQgTH5/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A882EACE9;
	Thu, 24 Jul 2025 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371777; cv=fail; b=mdxntJVgJeZNBxfRlmJZPHI/PfZDu7c5RVwASKKwi1mp5FCPF/IP47cNpRXzhMHE4qfGBBZbUVcg/kQMPl5evqSOlhC6AdBw06WL3XEZ7ovSwP5hFhASTp6pqLI2BsYTLSh9XlaQXXjoDV3OF/IK8KzrIL/bA8n8i13XAAFd7qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371777; c=relaxed/simple;
	bh=qcedvu/B3qyjDgcNkdatc4ioPWjL3lmTe4wsIA6Xb7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X5mSLCyPNomDoL91ZSRtV8/E2NwfW+sg0qSiwat+OhGFlwIbwle73JjLETNyucSarmI6lGbJPucA63XXrRFZApa7wA43S4a+3yfwO6aO342gBAd9PmC2cMBcQxvhBPDIcXGT8VCHa2/Se0C/rk6/hMHNOzevXEohHeHaUwMPKGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=aCQgTH5/; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNyGjXoV312GqYoDVLU7PnQzkFKhhJUphrrfaRp6G6NynsLj/g35AjJp5fFocWfXxLBUL2tVeNMOOOW+oMg0lyhYzbOfMgmfjftskJUtWtWnv96yeNGJYTUdu2sQr+CctdWB8YmJy1DSCXRq+YT2uT9wiliDsGdV8XWpa8M6yg9YsUhEqAbgBLfAnfqHlKVYueoJiDJ0dBZ5Lf6x2WfW1xHtdbcI6aF9xhEPmpfLKgl5dzmfNgBQm7D7LH6x3pF4lFzFeDw/S+gFRQfwmx5tGopEGBf4M74vzZE/809tW3oydSekGpVe2XrljHF7+rX+3fxEzWREmu64k8jJpnj8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1IwsZmC02vP103Rx14Bkto4xFLl4zhnYtFMTOg5JJk=;
 b=fws0w0Js/wXWRO3aJA/orVR0+9Yk7Jynf/nPhJ62HDlpbvlq4DNLfoIpfjxlwArwNpX54dx3W+LXHcQe50ByfZWc9y0WPVrArGfFBQj30Y+51Oi4Gt0Aoq4g8O+qH06zwoMyarnSDBKYkyRD51iLIWhKEAUQbypLAp8uifWkcBI/V+cPSeH2MDcPU1NFtRu+DcQDQUaZAetUjfrkFfyjefmnGMZd18tqf27ETmEdWVTCQxyYwY51C+TdTKw1T1uBNo92tP7DxeKiLVC40p26B0yh6k9HctMfDDKDp4Kan4E6pTypNCTBQ/6XMOa/B6wKPmfLBrbSyXLwBujI+RAhnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1IwsZmC02vP103Rx14Bkto4xFLl4zhnYtFMTOg5JJk=;
 b=aCQgTH5/vw47uT7kKvu2OyQhGtGRyWqACeJPvynhthzd1LIha9oTTufRrJ12821Ii6QCP4feQylILtxIAyC+ByZvzF3VCFlePs58uELnfdZppAjmCfUZnIX/HCov6y1HbJfTPT7z2e2dnVKobYOyfNZNrs7CtMMzcNnW97WJtF6nCg5ud4Gh3ibi0Pp42SEi3Mq/59qS0P1/z0ydCz11AatNkcyae/TYxId3285a36uXMxsAPcaUeItu3pFqBC/ih1j3LHK63wvm/IUiQ77b+6DUiBO1zkrQ4KKVT+H7O15MGYK7tKwAus+2nrH7KnXDJZMBmpqEzvPjO5FbQas89Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SJ2PR03MB7167.namprd03.prod.outlook.com (2603:10b6:a03:4f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 15:42:52 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 15:42:52 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dinguyen@kernel.org,
	maxime.chevallier@bootlin.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mun Yew Tham <mun.yew.tham@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v2 4/4] net: stmmac: dwmac-socfpga: Add xgmac support for Agilex5
Date: Thu, 24 Jul 2025 08:40:51 -0700
Message-ID: <20250724154052.205706-5-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250724154052.205706-1-matthew.gerlach@altera.com>
References: <20250724154052.205706-1-matthew.gerlach@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SJ2PR03MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1d0881-53f4-450a-277a-08ddcac8bfde
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bBaHekVcMusnnieQEABLa4mhtSOteHq0NyRd32tyJ6etwH0CPtkibTEPMk/s?=
 =?us-ascii?Q?IVQyAU3iJco8g5UJuyNG/ZaZaxyKnZpYyUsQGSm91D9ylBWamBasF47rytTB?=
 =?us-ascii?Q?NuK+qjaRi2if4AFrtE8n7TduWkPsbhg0DgA58YntIJ4xoUe1kz8dtaIBsSqu?=
 =?us-ascii?Q?P7xz5654yjL2mIgwUPO5UptF1XbfTuYjHVCF0iwxnGVxd9+Ht2/fX8oAM3R6?=
 =?us-ascii?Q?MCcJAsaArwbcqfqxJ+vuXooClT2TLFeQZYSIvGPP/0+8RvnjWj+WN+hqs5H8?=
 =?us-ascii?Q?N2F9nB1J0oFISUMAecq8ygvh0LZkke/7U88IYNJ+3ZAECp3gBaTfCPeuFdCR?=
 =?us-ascii?Q?vpFZ0mXy4rZiflDcjCcORRvevys3iombTvsLdy5GneQj9O1/HL4dXo6RITzv?=
 =?us-ascii?Q?XTesk7PpmwZNijGUJz0nNsPB/NmBFTP+HUv0kcmvQUSP+EMRQvpSmrpxyRkh?=
 =?us-ascii?Q?1H9mXGWOHKtr4dE1f2uOwa6zQlszmtZGcb3X1t0Bp6zROT+QQQpxn+30C/ZR?=
 =?us-ascii?Q?y11HFqqd3e1foyLr1jDAAR1PcxvUC5wYgLBP9ZM1okrrklKXv6w3Gv+CPrkM?=
 =?us-ascii?Q?/tJIP0zGbrXSeA1BNH7cfiPRKUFznU/6e/XO3z1h9O6Ch1mMzZfdkqvExcqr?=
 =?us-ascii?Q?UuW56gSmVrSJcgG6vvcxNl2xVzDXQ21zTedgWeixY9uOHynDfW9em5/YrN9G?=
 =?us-ascii?Q?mVptlVxkD4KpxYpSwzY8kgVN1D2P14huclW5lKlC/7YvpDuhh9PwDvP8g3Xs?=
 =?us-ascii?Q?0kqnmrBdLfgrOujYCaSrd0Q8sbRHgG5xNPO0ySq5t8jxHZE7vqJv1HUf9pJC?=
 =?us-ascii?Q?WhIvgQS3XNOcdm4g1zzDpj9KVZ9pv0noynvL2lmiJJQswxqm8qFVt4W4Vr05?=
 =?us-ascii?Q?yVcMbo0gWX+7iAR7lq7iZ/rtYVuvGXCKMP0CQ52pSE6OBM3GJibuLfMZqQg+?=
 =?us-ascii?Q?TVIqwAjev09JYB/t7tNR1tdPsQNEkIobS72cSPkuzJXvyhDH6FRj/j+elYCv?=
 =?us-ascii?Q?B4afb+X9dmEGXs5Uvo21KH/5gv0dJdmRCehdmDUQw7h/x4eDkzA2MVVoX3BE?=
 =?us-ascii?Q?wkIcIQkhLt4rdvIjr2A187+Si1FjOJ9ghzWYYuJhDl3qoCZR1ebWMFD7vtC2?=
 =?us-ascii?Q?9oKTqB7kECfjORqBMwlrB7SaiD6FopC46eUFjqOfyMQf+2A/DVTPj9wcuHyE?=
 =?us-ascii?Q?hca3WwQyAXvHSg73s8ODcU7HEGD7ZSO1EMyghzU/tiUK6pykC904wzKhTbLE?=
 =?us-ascii?Q?walnWQKNLrFHVFCOlUm6b9z3xM8/NgvUlnJeo5REBHR/IVxLdbNvwKLwzk/3?=
 =?us-ascii?Q?/h8qRyq/PFtXHPf1lzfNJKeHfouDIIUo1k39w64OQhD+yKTTXV+B/7me3WHC?=
 =?us-ascii?Q?FS3cp18SZmryG7zPUCM3CbpL0/Ff93sT8mZbMP71hBxIYnIEvGP9x2jL6NZi?=
 =?us-ascii?Q?P4Yphj7+qzR7+j0Ttg1jjjP+7m5OfL5gFoZIhlo0xBWkXFFebQFuxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OFM1KKOrYfCX1z7KqXXO21uA85suOwNdj1TdW2yGg2MGTBYUr+GoTvvlozyb?=
 =?us-ascii?Q?ZUL6aJ4FRbeupLEcoSZBanWvMzT2ebXcd4sUgX8IERY6fo6iTMLhpo6kUoJP?=
 =?us-ascii?Q?2bL0nY2TnoVTOgcfNmtJNhgE8FQCu1rB5OtmMIN0sPtx75IxdUwEWhE8K/dV?=
 =?us-ascii?Q?2iDAtUXnw3D7wpd5erwfiLn5rdAd91DwTQDAXocurQTzlv1vXhdu2qJsEW+7?=
 =?us-ascii?Q?pjufGr4XAASnSL3uCfpMSqNQ5tc5S3ehS/OXwrHqleYZXhqwTsOqbWG78ZN7?=
 =?us-ascii?Q?+BIYgAfDVizCNfGpveY+JCMW+Rz/qfRar49bjddAupv9nTUV2B5TiGRY7X7S?=
 =?us-ascii?Q?dO4JcB70bPmDXBycVQ6AkWGx6KcAccUQSG8CPKTT6GYK1utlTsBfUOE4dbwU?=
 =?us-ascii?Q?SqrPK09yG2zKAsH0vLCS8uFez6YQkej13/ei5llTcZgnsZ6szMJSCB2D03Wm?=
 =?us-ascii?Q?3M+R7s0sHKbAupwHTaqqJXaRDlmtKhl408aeNGGuUCC/TRU0oQ/zjRpY1kdN?=
 =?us-ascii?Q?w6+34Tfz13PBeyUny+xjFZLOFwRf+G5iTSABKGKNMVbgFl5Tybqw3JD0wy71?=
 =?us-ascii?Q?+UtLg6j9P348hphuOw9bLfc2XMVLYHFao4+y6FzLmnx+vD0TIH1N9l//0QkV?=
 =?us-ascii?Q?CoaF9kMOUjNQwcQbYtUnclEhH1Aq4B9Ou/2Kxv85l2yD5DhQ/Wf5Br1nkh+O?=
 =?us-ascii?Q?Czl9SWi77bniJMnQnPixXcNb1EFvGBGnXAivWUkY0jvGrRZr47KDjbSTgV2v?=
 =?us-ascii?Q?GE0l+fD5SxZOoJQeZNaWdg81eWITtq35XAuI4MXjNRK6iBVuVIZZauUaGOqd?=
 =?us-ascii?Q?QCNjeKlE0fDXYIVV471vqX9Ezl2RoDrV8inzx3CbeB+Ub8GaovwnbfXSUabC?=
 =?us-ascii?Q?ygWOaX5/33mjzWZ3NN2AObxlH+lY/aTPhKsPMGjwkipjLtfMNxZm4ZfD5eZL?=
 =?us-ascii?Q?eiK7VKwKosqdj5DFdztT6TjzBL3Eqjs0HaEbfccHUbtX1uvPwFnNQrCv4B2J?=
 =?us-ascii?Q?o50AMrkRvXxwktj0Sm/TFNtFrwlTynycIogKhQ3ntVHj2PGMITvETsjZetDN?=
 =?us-ascii?Q?1ul5R5Wm9fzd+VkAchS9Gfk0rBHmYHfHqL28CTBahl1Q5zBhx+iLyPhWGAd6?=
 =?us-ascii?Q?Vgx87txHGR3BLBIQgr53rj08s2Nhsav2V0U6k4jKdmWH7PLFaa+/0v7ZYrgu?=
 =?us-ascii?Q?pH2QhgBl4/ni6XD5wXuI3h0jV9wFPyO2B8RBnLAAHOXsyh0I3Ann5pK0h+bj?=
 =?us-ascii?Q?KZTuw8ylBBDYSL0WTEsdFCQeN8SdbnyqY0YKyrKjaZuwUB+wQHTi5WTPN7Kp?=
 =?us-ascii?Q?VvRVpRyQj6Nn01fTcOnw30zEo03vPMQiZtMIZCi+m7cslUJWWIdkCE7SyI92?=
 =?us-ascii?Q?nzue+1LnUabfeKiQPL1lM2Nhl8uaNwSQuuDUjl+1Ytw6V74eYnTy7ud6W//Q?=
 =?us-ascii?Q?rGQUGPd/1otRssPlaGA27VdvVG4LVNZwjTeXh7nNEKc6OxNmQq9XR3GdZy+k?=
 =?us-ascii?Q?6F30z19mFpsWHa9oacqil7pt1V+if2zxZ9tSqqivYagxzDPChhVbs+ujGK0E?=
 =?us-ascii?Q?lwCUFkKdGS3seTsMg6Jm1a7IerU9hFMozwhg2sf2qlOOra14FZQIsOqQN3KY?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1d0881-53f4-450a-277a-08ddcac8bfde
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 15:42:51.9810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/bm7XtFVLoXWcn3IjPMHlepsMnFR7DbacLfLso6z5/xl4k8yLW/0Fqysvg2489+e4wfvgiHhYxaPyIliH3AL2Qq3AMBsywyQo7EnQ2EmGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7167

From: Mun Yew Tham <mun.yew.tham@altera.com>

Add support for Agilex5 compatible value.

Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 72b50f6d72f4..01dd0cf0923c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -515,6 +515,7 @@ static const struct socfpga_dwmac_ops socfpga_gen10_ops = {
 static const struct of_device_id socfpga_dwmac_match[] = {
 	{ .compatible = "altr,socfpga-stmmac", .data = &socfpga_gen5_ops },
 	{ .compatible = "altr,socfpga-stmmac-a10-s10", .data = &socfpga_gen10_ops },
+	{ .compatible = "altr,socfpga-stmmac-agilex5", .data = &socfpga_gen10_ops },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);
-- 
2.35.3


