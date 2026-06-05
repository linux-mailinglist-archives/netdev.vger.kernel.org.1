Return-Path: <netdev+bounces-295640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rtb/BsxpImpqWwEAu9opvQ
	(envelope-from <netdev+bounces-295640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:16:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C06645712
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:16:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295640-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295640-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D4473012EB1
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 06:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9F3BB137;
	Fri,  5 Jun 2026 06:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47A3B3C06;
	Fri,  5 Jun 2026 06:02:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639354; cv=fail; b=i09WdWv4vQXLRP2jtajb/h3ygWK+bW4UUuxZASwcxSukpUN9e1bi8EYUHlUasBerpzmGjZAx/PezMhcUCOMw/xPRVzDHVRrs/FyasDeMgtusHJ2YkrOrCB9qh7nIG+tiZAO/T//EelXkUJW/XvyqsPFP1VPnWPOoKJ5nLCDxdVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639354; c=relaxed/simple;
	bh=9eG7s5ujpFswxszQQMSVDot7a8uujteVaagp7Y0sIRA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oVSy/AoPaj3SLUc7nnykYepZsg5lcXboCq+eV40Ya5Ys+tdX6+qQF/l610pCEtxubh/stsW9V1cC5xHrqUKwLCX1yS5087qrAuw+8AxNwluaOzdyw7e3VZ1mwiJfy+GZpFz0RITpR62RzhXRPqiJl2SeFyGscBTWcKw9Y9zveqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJPVGByovogdJct48w69yGjPOF67pB+1iw4Fq8jppcvyfWMZCziRLMtDRsRsFRfZZ1lw2pEG1/p/mTu6B5KOv6fjPGW556WqaqAu3eMQbs2PZsk1T0CTD1SXOUVCiArTRor0Lo+YzBpZ2GT1ZAXTLP70LG7IsOZCezA47vjZU9pn0s9xXtfwGddN2+zwugViQIbq8Es4SAocnWqqNeYX2WYoSpSWU8OYtovUZIev5utd3PcV5KQqVgsIxQqbmMBdm1U7CIaW83vg+p3E71UX8bQ2JG82n0srDziT08165ngsdX6GNDq1sL+B4H9IvWt/eDNbpaD2UryYXnqJbhxdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4cvAfxbo11PJa5jErosVZTLDgu1NKJiiVbkvrMVB3U=;
 b=TzIL5qSj+qcBwiBG9wbzIap8TUufVCfeppTOJSj+oyawFKBMWg2ufG/I+VftkoTSLaHZZxGjzfyFBXdczMogyZryrrizLob19n7hM+0JFYVz89ECAVFmjzco9t/Lu0PgStt0KTxSkX0Rif5B4/HSWy4rEBD0zDK8ObiA26hJgG9XUjYZqe/fmjuvoFjSmuenY4iPlRoI4lGkdIYooA04fTk/49ROdJOBF+jgNAdQMDWVl2M3IPNDooVlIrhy8C2cHLS9k23pOTydbBLnA4EX4UGutaVBAI7V6AJELtwSzQqQffyPE2wG4IRuicoGLMZG9Hd+ccsCAhujikoTVdL6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0542.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 06:02:19 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Fri, 5 Jun 2026 06:02:19 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v6 0/3] Add motorcomm 8531s set ds func and 8522 driver
Date: Fri,  5 Jun 2026 14:02:09 +0800
Message-Id: <20260605060212.41895-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0542:EE_
X-MS-Office365-Filtering-Correlation-Id: 0921c5f1-cfc7-46fc-9bdf-08dec2c800aa
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	snEZ/xxKgdzTzkrjYgl+hzzcWUoH/a27b71m2cmEn/rU9oOlep/I5xWAPizmWNICmoQuIWd0xNa9JzMuoLrErL+8ZxvAX81DyVCjVs/N1vGmpij0yc+9ljRve0z4cq9qef8XCDmFewRHGC+M0E8tuke5sv+gsxaxA9CFjwdRIM9W34oq/T+YyXOnyYDwIyT4CgBcYQIRXAT03HTRxb3NJWKdD6ayi9nrCNsgtvCkAFeQFsydxFisSPzd9Qlf2saCXp7Up72x6j9SEMvPqY9qylbedGTEFJhFNXRjjVdFFFH+drP17P0TuDntuL+aCdxae7GjFKmFHKonLphChj0whDcwAOxCgVx4Bz6TNQXocfT9HfKjwVBvaTy5RR9vTCSUfcaT4c3JD7hXJ9aEgQU9tN1gAoGH6GaFfk5qnjkv4TWYiaAwv9ROV3BDQ/QUGiWZ1txB3qJubmxMxi6nnht3lgHKGSzoOUNdyGhLrCdlBzCqWl0hc/AlH/Tndhcb8ZgOkQJEmpqSgP9e4PIHFRqrvfaPfUFzEWmWducw1OE883oaP2A8i83HwhoV5rzL/iSG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4edLUiCXA9TwlmN59wksg+a/IPg1fRu1Wn2gTppEAEwXqaQBwUEbQRByQnMd?=
 =?us-ascii?Q?t1Aa5RruWFAJTh2QLbElQ85hBVvUsSKDxdV4X7ecrHV4FsSDt7nF5p84Ta+S?=
 =?us-ascii?Q?UfXOhWkPp0YIq12GNsaqY3kwNMcHj6wPoKZQD7myZgx7rhEbbwLKYUlNYuUA?=
 =?us-ascii?Q?CBhNxeAWutX3qGlY3maN6e4W5p16e+wiccx+2uVIXzUK1IHhy8gtbW7/r2yj?=
 =?us-ascii?Q?bpHwBhvwc2dDrSrIkApCejWMJ+MTReiFaG5eCKak84VfjSXTBhTAyTYGxCQf?=
 =?us-ascii?Q?jN5RhOOjIYO3t3lo+qZhHn7TucbaFLyqO10rMxtDxSI0HO3KirGxZR6r2HYV?=
 =?us-ascii?Q?Ehq6oeUaDwMAvrDBpqD5o6Ae/0VdkqM+lZeooePZLdeYAvLBvc+Z9xAQx405?=
 =?us-ascii?Q?HoXERKFDwzBe7SaRrMiSWVcn3UoRXB0aFR7QiSMztocxAv4UuJAiMPlRmonZ?=
 =?us-ascii?Q?nocD1s4wj05xFOE+d3XeqwjoNMI5u9PrgbXvllZpJSV2ZbxMq9G8kH0kMvdE?=
 =?us-ascii?Q?2T96BHl4QogTJbyHGDKFQDzhTKM13b8/ypntEnXmnEFPyfC8LXyGlzzfBaQj?=
 =?us-ascii?Q?otRor8/ZY0CURpSI3bbansg7fmlmh/XZpB4ATDpvHF9s74FMB2nP535r1PQ1?=
 =?us-ascii?Q?vCuQ/LTMRnLxK2SQQcTi32EsqsucQk2YBUzmKhG+u6QSIsAWI1aS8XMbzvIf?=
 =?us-ascii?Q?VNgPJhrECrZAT3v03OaijLwC4aFb2RJYfx7/RaX2e0EXNHi2Ut6zBMp9ozsf?=
 =?us-ascii?Q?mg17dOc4DADpuFikTk1FMC1DrwwPnwoBYHtAe/eHsSm826Vz3VOLNMmF8QUg?=
 =?us-ascii?Q?WjJU4BC41mRwJtJKFmbnrQlagnRVfwAfcfwhCpsmL8pN3JTx5bEoUw1NQmQZ?=
 =?us-ascii?Q?VDtkWbQiFG5c+xCdcvwKz8zUjO2qPJdYaBa21kvD5CNUYqD9FfPeIFq7OiCt?=
 =?us-ascii?Q?4XblpkWu7dJP8IvPYhA1CJbDj8IlH2q2w8Ejtrvc+tUo4oXQHUgxglhG/+Zt?=
 =?us-ascii?Q?vte9TeFYSBwDuCFXyisuts/g/igE0Zj98zUS7/vGgc+RgzTr3yqhIq/mmTGE?=
 =?us-ascii?Q?TLdBSNF+JBEonS3ZaEcsq/jytneYaQt1RSh5mT2wntE6alXAI/pcGzROBUkQ?=
 =?us-ascii?Q?oyp5SMyaxpAZkH3NYio69DgBCITz5d1+TetAA3mKJoWgIn53jccJl45v3/aF?=
 =?us-ascii?Q?V3SY4JGslaqRL5rpAs5JZNHP7sz0gmIXYn72VQsUcmU8ACDsIKR8mzdAH2iJ?=
 =?us-ascii?Q?IyGNqWwJLMVMNlJvpTR+p9kqu4nQVlacSiBXgH36spyhOhr5BQmqkuKECXsz?=
 =?us-ascii?Q?PZAFAAQbnaK5NNqMFEqHoFH0dtGOWq8+dDQMWKmE5cVTohReVFscr+E8f5ba?=
 =?us-ascii?Q?YVQfz8QzHcLpCVlAQiwf3Bm1dIhMyplFNMWR5Ra/5A9AjvLN0ZpBWAYz8BSe?=
 =?us-ascii?Q?ydMM5IDAewkwGOKEMWyPsxEokldQd9EdukqjgmDBUlaysC65LPPO+4YBIlb+?=
 =?us-ascii?Q?VeGTM7tsjY5DMWCQ7geDr0+AW9y+l4WaNfaUhxaHALWzz/puRdm1fK+ang+P?=
 =?us-ascii?Q?w+ivdanLRLRF0Q2bcEKtyAw4OjIAkd0i54ADLZC5LNjUkcQUSAnKgLc9Sc+N?=
 =?us-ascii?Q?b6CwKEf6NgGjqMuPU2a4/eTl5N8GFq1eyUzS80WClipBETh4dBwOkJnE7KH5?=
 =?us-ascii?Q?xy7uHFIiKthby3kxaTpD2ujyk5CZr9dzXlbJtj+vyTQe2JjLmEnOlDKa8ior?=
 =?us-ascii?Q?bJ55AI3h9+AfdxGYe2gaC6ptfwxXScA=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0921c5f1-cfc7-46fc-9bdf-08dec2c800aa
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 06:02:19.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMkzWP0Lxvrc7iSDRaJKsr238j+rkng894t7R3L85RegcL3mbtLwAcVCkG8z6+U+RqpEejWAu+PF4C5gik5voU6VQ0qpmunwDyPAcaqAXms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0542
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295640-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Sae@motor-comm.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:minda.chen@starfivetech.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:from_mime,starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19C06645712

This patch is for Starfive JHB100 EVB board. JHB100  contain
1 RGMII/RMII and 1 RMII synopsys GMAC cores. In the EVB board, RGMII
interface connect with YT8531s Ethernet PHY. RMII interface connect
with YT8522 ethernet PHY. So patch 1-2 is for RGMII interface
patch 3 is RMII is for RMII interface.

JHB100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
Managent Controller). Similar with Aspeed 27x0.

The JHB100 minimal system upstream is in progress:
https://patchwork.kernel.org/project/linux-riscv/cover/20260508053632.818548-1-changhuang.liang@starfivetech.com/

The patch base net-next (base commit list below)

previous commit
v1: https://patchwork.kernel.org/project/netdevbpf/cover/20260415092654.64907-1-minda.chen@starfivetech.com/
v2:https://patchwork.kernel.org/project/netdevbpf/cover/20260422083255.29692-1-minda.chen@starfivetech.com/
v3:
https://patchwork.kernel.org/project/netdevbpf/cover/20260508094522.3952-1-minda.chen@starfivetech.com/
v4:https://patchwork.kernel.org/project/netdevbpf/cover/20260520101310.128969-1-minda.chen@starfivetech.com/

The change list:
v6:
1. patch3 correct AUTOSLEEP bit,  (from sashiko test)
2. patch2 add review tag.
v5:
1. patch1 and patch3 add review tag
2. patch2 using phydev_id_compare()
v4:
1. Add review tag
2. patch 2 check interface first and Add the reason of checking
PHY ID in commit message.
v3:
1. change some commit message.
v2:
1. patch1 move mdio lock out from  yt8531_set_ds().
2. patch2 changed to phy_interface_is_rgmii().


Minda Chen (3):
  net: phy: motorcomm: move mdio lock out from yt8531_set_ds()
  net: motorcomm: phy: set drive strength in YT8531s RGMII
  net: phy: motorcomm: Add YT8522 100M RMII PHY support

 drivers/net/phy/motorcomm.c | 77 ++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 10 deletions(-)


base-commit: bfa3d89cc15c09f7d1581c834a5ed725189ec19f
-- 
2.17.1


