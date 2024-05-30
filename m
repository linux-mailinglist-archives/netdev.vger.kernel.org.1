Return-Path: <netdev+bounces-99469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659C8D4FE5
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4099E1C2089F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D7A23741;
	Thu, 30 May 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JiNllkkw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD928DD0
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086839; cv=fail; b=MEb0eUTfYY+6lCEkFOEbdZy75idMgJ+7m/uPfFugj8EVIbFD0Qsd0U9XG9nzgsOcYChQPznhXpa7V6uAtOUYD8rdJYqBtoSMHIcVreMlLvaoK5HnKDyDRXjBB3dAZ7wKqB5sRj3j9orksyacQ2oEIokUn06nXOrAuRwP1MRr73I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086839; c=relaxed/simple;
	bh=bmErH1C1UQDc2teZAu1mzkMi25FV87cz8h7XZCE/Bpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mDLnnnAZpMIpYNwYal0axaPvfi7+a+xOzKVBcpQS0sNz7M01IPYd7IZjRO8kP/fRMQ6D+9lqsOZY/zJtvbneyZN5zzj6SyXLUzqg7na9OB4+PiCFYeEsFAjlXex7fS4p2sgH37HLBQAhywdaasm/raSnMWS8pzcBFVA0zQSC1zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JiNllkkw; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaX4UBE/GWBn06wBVL40iMmQ+v9V/TjuJf2ajJsZhpQJnrtajFZewNCDNt4SEt1pNxCd5K3n9bM/5Sp8lrMkuypXfRTOn5CQRv4LTybAK/LnoXyMQYJTP+0ZkPt7/KANscEt3XLtM3Ra8q+HECCpDCZ5p6ix4VOURLtI31i6z0I6CNjv0DHtk7QYly2uGTfsPTkt7x8BSR4/f2nYlP8ztaRibMCkQMmg2Sk4uvc6DLDs45K+irOlyiHtNTsfizAadkRHdXgbveEQAN+XYCnMXDGTXvHo6JmUtVBa9cgiI25R9J/D3icdzaIE+A0uqadK9Dx9R5vYKMQIZKlAWzB8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk9lLLxRksfRySwNqQq468tk7reXsm9ntop6o2cDKQg=;
 b=n737eZDrZQnF7b2SxroIrGaBBPCZ1L/IixYCtW9+p99+dHfKzeRbRUu9lBjKCobiLnr/QEiBHB42MDv6HWGnSt2SqgrfIZnUt+m2igsnwHUwmLx9TIo8h5x+IgDK0B64xxivZmJGi3vIz3KbkyIxmxMF3BijCEOmPvVPb0WnX+nlIswInNTfekrUeU2a16K+KR5YOm2hexvAD+aB0yhTJzklnc/A/49sRA8PjoT6InjHHEivQ7sqoeWLQsCRd3cgBRH2Bt/EJXrcg680zIMnxmi5zLa34gr3SazctgxDuZzHeFEi1ojpIlB5IFayIP/Z5E5sXIOaFQ+hYs5Swx8snw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk9lLLxRksfRySwNqQq468tk7reXsm9ntop6o2cDKQg=;
 b=JiNllkkwDa28STupYW2aQDiaVLcb+ND7SiiLZ62OuKRPdqWGxyqoHaCq/V+rk9cUCelMT8TR8gsoUdkkRKMIasNolcXwPaPb+Tw7qJYCO6osLOmqJaN5DjuoqBVJrbr5BN4VSCRYwrjR4hCkgmU5dKmfejyIxDwvF0n59CIOoss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Thu, 30 May 2024 16:33:52 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 16:33:52 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next 3/8] net: dsa: ocelot: delete open coded status = "disabled" parsing
Date: Thu, 30 May 2024 19:33:28 +0300
Message-Id: <20240530163333.2458884-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::20) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e782ce2-f22a-48ee-42c3-08dc80c64ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VTefmXH9GXZ961qUZxKHNc6ZYAonNv6iSDsKvRRsbuW0TnfDsLJEarGtP9oj?=
 =?us-ascii?Q?yGlxgcF7VICHdqiGM26CzR0/bfCSm2oK/0hLGBNoIbPD868th7JkbYvNfPJw?=
 =?us-ascii?Q?O/yTGr13hLcB3VJfc6v+Z5sN5cQc/Rsvo/P/VZa9g3LIHceLimlQDRQEreKo?=
 =?us-ascii?Q?R60nrcCP58qRFqxhVzhhonu/8C6NjzvZITbKlyq42RvYBgaFxO6VzFuefSAQ?=
 =?us-ascii?Q?Tu33S9oz7FJ4JLDanVyXXOG/avPumLUOLJTIHGUFfloM5y/MFxbMwbbZMzl3?=
 =?us-ascii?Q?rqcsrbWEtdY/2Xz5CETrq6L0aDgVs6W4YFMNmPUMlG/ELJcDy16/6FaAODJa?=
 =?us-ascii?Q?CclIgIN9pWCa3C1ECpLnWz/YiJBSPm0i7daaduGYu+rCqDigLvmTaxKLHEWC?=
 =?us-ascii?Q?ydnluTafaE2a8DI1kbgNPaR3IHq6eHl6NIaJWpV2pboEPtIYJiiJIEQUa3xc?=
 =?us-ascii?Q?3nZlT3gS0vZGrVAk067esCP9Ps+sX1/Icjmfi6PV3T1Ds/ehgHk7a09eJFVw?=
 =?us-ascii?Q?kUQu4yg5A8j7wlqgz/OqwudIQZrjKyL2Jz9SftNxJcB6aO7BYSa/BN285EIy?=
 =?us-ascii?Q?XGeFmP3xNtRoRjSyu8zEwiVgaWuHVBbZ0v3Fp3X9ecX0Xx0NbgqME564XJku?=
 =?us-ascii?Q?2NDDB8DHoU9C+Gv+tJWQ+rFR88AAixGwx2geUa7hwfhkuHe0n2X19rBXqatc?=
 =?us-ascii?Q?RjvoXEHSTxby50/PFIbhyRAmdz2IsNWQPFK3QUCiPMKO6uEYzwp3LceqJNss?=
 =?us-ascii?Q?8pQMWOR9H0vPTe1Q0u1G8bRuL6r6fxi6CTWnLedXA8rUstLuj0DUvH0mYni/?=
 =?us-ascii?Q?cgKnrNWdKA+ghIIEZMfE9tTYHh2LXoARaOgT2COuFxgzlcAakofeNWzb9pPF?=
 =?us-ascii?Q?FBZQz+R5KC7lPPEDCjD/0QM1J1eTv+IgDfNMveEO+m4/TRCbDIo0PjqQR60B?=
 =?us-ascii?Q?oShWXVeZ262lz+DQW/bzf5NDjy0uQ+hGAZkIwLLxc6Mj/WkW4Z+VoUNmmSP2?=
 =?us-ascii?Q?yBW6L8o5mzu+JFV7vE9I1TtcGI2cw6lfd4EO70VF+UXUnX6ZdYgUkQ2jJ3Ru?=
 =?us-ascii?Q?3EKAM7Bx2HI9IaP2j2r/i/jjqW564JdOV7R3CvFB9Az5qLO4+0k9D8q/A3va?=
 =?us-ascii?Q?jcK6noNgQeFBw5ldwUZ0FjrjmekVdS/aUDJNhaV5gk4ctZfzMHjHdOtAzAV0?=
 =?us-ascii?Q?IpiMQkGUy61Q6Q74Y7nJsSDL4LPf3UtImyeM8A4EMJ3ZjWmkwOZAAyD7n6CX?=
 =?us-ascii?Q?PnTIB4mxSmfk74eEwSdPzmHI97EnUZCWNomWDGm4Jjk3DLwxNbNv/3OKpM6A?=
 =?us-ascii?Q?LzA+iExHumGGyAUHcq/giNsijJohcP1JrcEE8pqAKyU0tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GF71mLQPkasNDsEihDUo9u3mE9P8SzKZS55d7sehCUmPDxSI8NhbO1LYQfYD?=
 =?us-ascii?Q?MhdKoy22coiA6MtQUWaOijy6Xcez/SNuE+fPYitSpZi9VtXNRtsDfLpif7Qg?=
 =?us-ascii?Q?rDP2+gx4pyv3RFs9mFBIQGZfA2V9heathOCmGGRz1XkBtzeAc8dEbENmvm8e?=
 =?us-ascii?Q?7dkmnR6l3x3p6S4Y/RjzZAuatmlGdb19+AOnER75uOsGDNm/1/RSDfZcCQ2V?=
 =?us-ascii?Q?NvvNeaEE/L4aIoX3bYAqWfmvnYjTrueSu86hyvV9o0wVk9YVt8J8vRKXbkWw?=
 =?us-ascii?Q?qs0i50jv4CLl/k/xlrhOSbQrCg3AuZmhcU5OIRuBcc6ZNQm5SqGpWGasD8in?=
 =?us-ascii?Q?l4sMEbAuRS7gdATdWwb2oUQIGRe61BGQPX/DbyIhZLXWpTGOAvOwlTQuCRiX?=
 =?us-ascii?Q?nlMMl/GwLtEK4MtjbqCUKwzeDPiMx89DWprDJDC1+XNaO68b3OeG0EDmVYLa?=
 =?us-ascii?Q?ogj+cMks2oXnHBHcJjeEK43V43FcoxcKu6wEGcwSC88Cwl9XDlgUztqF15Zt?=
 =?us-ascii?Q?CpSGVCFaxVjK72Y/4khUZ9A7j3DULXRFbm6ee3Fv3bicWq7Yoaveu0DNb9i9?=
 =?us-ascii?Q?S4pOzdQQVDoLiWA1C9iLt7NeBryzbT3PCpRUAeGTSPNtlCYROHETLVd3lwXm?=
 =?us-ascii?Q?zg4rl+KBp3Qobgh/x5cZIuCYGiLDdrY9A8ly/pntdjxeIvJVO87NgJdaBAgv?=
 =?us-ascii?Q?S+IrgWB7IvYwx/U4JoZKpUtkCYAMdRj+mhqEmUPbHmo/DTpX/7GZrFzu+yEf?=
 =?us-ascii?Q?yeqlXtXm36NREnfzE+i8xFdwCqsDQcJeY3QZaHEcRCZdMjy4bsrk9yA45f3b?=
 =?us-ascii?Q?6E7A978yZxXcEV5pFFoVu5SyeAhgIS3hb9WC6787uBBmeneQg/3EoF6Sp7ds?=
 =?us-ascii?Q?GJku868TBNdJil6b5hHQ9r0wLkfW2U8dQpyMz++uvcoDOsuuJnfBvPAJRcLG?=
 =?us-ascii?Q?HYx8XJZQ7UlRYwnrjdZ9Co2bbsSB221+lGoa/p50YB7TWYQ+nGC/owUCDKI8?=
 =?us-ascii?Q?gYpdV0+v+7WHIg35fE9ae6daq8NRCImWacWVBvN00PWokNVdF4scCQTdd9IN?=
 =?us-ascii?Q?Z2AjO2LHLF8VJm76FEkd2ciR4RKXNXSm4/zVvdasEE1hrhLkoFotlalS2nXS?=
 =?us-ascii?Q?k0De1haa1mMezObnqAc/rhcG3H2Nl9nPjXzpN51uNr/rNtzrsia1Key2LV+q?=
 =?us-ascii?Q?Rfxks8KXh7FHYIjqL6i/hWyAdwq/pGhH3mg4uL6VG/3prLHZydq5xKzU+Dx2?=
 =?us-ascii?Q?hTIEKuv3bJp9sya8Pd19Tv9D58zDfmihXUnXD91SJsd6PjmaXDU+L/yNA+Ta?=
 =?us-ascii?Q?OXdthOMPY9jam+HoFvFMnqTCg4njs4LssZcCyvbx7Oq5idUG8oQVIQatDEky?=
 =?us-ascii?Q?ywjTJcnLxYnuCLvqkAOaJDRdQKvf8l7iE7/U4MMFB7mwTJ71Z452yQeB9Qxb?=
 =?us-ascii?Q?BUmKdh5dBu1/q2B8oeRq9rVG0SN63bkibP6q1FARe74AanIeFRea21ToGL59?=
 =?us-ascii?Q?JQRDLuEy9vHN2lAWQ0l0kp0InDM7Tu63pZeYzu1DyRof8Jf6qjSiplxCsfda?=
 =?us-ascii?Q?6TcjYzu3mr3BURLQS6Mgwg3N0+3WQ+kJjxb8HIbJ0zqAJ6FV2mm0nr16E7Jl?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e782ce2-f22a-48ee-42c3-08dc80c64ab5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:33:52.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FdFWCUMBJ5G7uHOrx4+Jba8ycqvEvE3iEKqrfJ/REooAxYGNE+ZR8pYvRn8oClorhHw1zd3EvnwltnEde4mDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

Since commit 6fffbc7ae137 ("PCI: Honor firmware's device disabled
status"), PCI device drivers with OF bindings no longer need this check.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index d4799a908abc..eabb55da0982 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -2668,11 +2668,6 @@ static int felix_pci_probe(struct pci_dev *pdev,
 	struct felix *felix;
 	int err;
 
-	if (pdev->dev.of_node && !of_device_is_available(pdev->dev.of_node)) {
-		dev_info(&pdev->dev, "device is disabled, skipping\n");
-		return -ENODEV;
-	}
-
 	err = pci_enable_device(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "device enable failed\n");
-- 
2.34.1


