Return-Path: <netdev+bounces-171428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CDFA4CFD1
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11143A118B
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F345223;
	Tue,  4 Mar 2025 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TZaeMSeR"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2050.outbound.protection.outlook.com [40.107.103.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C228691;
	Tue,  4 Mar 2025 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047437; cv=fail; b=F6Uhmfk2/Xa0tvfe8Ebaw7IjipNcVRrqGGpVeN/5C6Ie+kfseUtMqwkry8lYxE+YGQUuLTB8jMehrK8/XkNjCIfzBysCzttM4V8qd01npW6CxK6pMlWlWR19u+A/9B/9iryA+/nNXp9rFzgbF0eH+5k+J53eZOAtMbnkN16NtmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047437; c=relaxed/simple;
	bh=SFcoL35sGNfSLMV4N/R04LEdgaCsdZHf6w2Sod9Fvw0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cggd61HxAH8+AS8dbVsL8W/unQE9zrsdvwCan9wV7Oxs6cI3jJzqx49htLH2KwnCjGzHCmLHr/EmiOHwVIqSwDww/BJdC5Yd8FKue2j7mO2lAQQDRPInZjs+uX+4N9L/s6qFStg3nrT3/RX8MkSIfv9j7WG2BGbXKkb20uOQah8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TZaeMSeR; arc=fail smtp.client-ip=40.107.103.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UO/1OLzVwNRQDwAChhzWyGTZLl5v5jwXRaV/lbfmTCK1KBjyyBNsuV35QU4l0ciAg+bISCRPOvM8IvS9p0RZUMacDd5fWhNh3+MMfHmoFXKtJPLuTi7PzrdMD9Zp0w9YTXGBJUSIwYceL1uCX0N9eFketD6V5YB76RYHxLiH/L2JK/1KAyhTKmjVsunjhJPY64i0zEVRfAck+RW6TXIg8CFo5vjxBLGOrbpHrWCY8FjzYCKM55TCnUUeJVXxwc1VJTgattLaB2KS6XmczP+7Ttx7XPOkcYOspFxx0zv6lWKCo/wCbZh/Qdz3NS5aXyvsK9H4qjhydcG4j/CiOY4bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psYf9ZXtjqjYkV4/COolEzQvWtJqHrvcpWT+px42Cew=;
 b=QuCStVflOG5GFwAqnREmRSyZoWdkkDSr3AzdrFBFG6yCS+jaxjGcgVKGJQthRDiYJb5LFy6+jaYAP/HGouJUjnOzooYzH25yByDWSY0ldYeATekzdNglVCSVN8s+c6QiGwvgQW4v9pwJfNmCZQwpJDoxvC9EqnCH4VFf3QWs1zI3/LWFAxPs96zaEnPVaD8FODrU2Icsg0tApkHsWvdsdUBt/u4a1y1jHRgLuP7LqMCse4mb6nIKgAOVa1yYy5fGzIi3EscUBdIoQJbCcCfAU7N90rXLEAZsHQrv29X9jHmFjxUI4j927jrycZbt054lnpeXDJRFvjFmak02yR71XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psYf9ZXtjqjYkV4/COolEzQvWtJqHrvcpWT+px42Cew=;
 b=TZaeMSeRwa+xZkOnDrAWY+y5zwp/BE10NDrs6unchRTiO7lJJSazIFQsBKY3GrVC/x7u+8RvjBA2qDkcMPQwO4bpu4jGpRPGVX1H9fhnvQoN4YnGiekfBu7Rzxsdw7IIUFj0JSitbbNNB1YV+dF9jH/p7V6CbXocuXySQUVmJWfiGqM5+A7BZ2PhLTZ2fV+TPpb1JW5jzLYqJqgTozvTGsFw5OHyVhjj6sXKQrejBMuaetmIFt/rfwlCTFhkx/v1BYmgK78hWHwo0SVRrCQrvDxSdE6QO5H+j/VZq+eh+7IuE5pwZW+JKcsaUFGci9IXMhTDo8b7W6G4qoN7RMtw1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Tue, 4 Mar
 2025 00:17:10 +0000
Received: from AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a]) by AS8PR04MB8216.eurprd04.prod.outlook.com
 ([fe80::f1:514e:3f1e:4e4a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 00:17:10 +0000
From: Andrei Botila <andrei.botila@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>
Subject: [PATCH net 0/2] net: phy: nxp-c45-tja11xx: add errata for TJA112XA/B
Date: Tue,  4 Mar 2025 02:16:26 +0200
Message-ID: <20250304001629.4094176-1-andrei.botila@oss.nxp.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0075.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::16) To AS8PR04MB8216.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8216:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ca18a4-7ef0-4f51-68ed-08dd5ab1e7dd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YdMR5UFoZs36o3qN8CNU4W9ZgGg1oDogpcCMsYIwCIHv+ZjygH49qKj1xKY+?=
 =?us-ascii?Q?ivKG9bE9cnELtYx4a+VzW5lGrmeEgAxM0+MbFhIMwWpB5qi3DASxZDAYBmb3?=
 =?us-ascii?Q?FLTLiD+xPtDu+Wh3dIAc4splwFgX5OffSCceF9EIMzgSmtLCk5bGcAwryCVW?=
 =?us-ascii?Q?Ze+Fh/6+g7XnQZaURwSgh/wOm6uwDiIl2/thSOxa7bccnNDPAWD3GgRgvU0I?=
 =?us-ascii?Q?uBWM4sG3WrhlVmKLqt5sk5SR1VzEHdIZcRp5V3sr/voEn8Mb2TCfWMm/+wRZ?=
 =?us-ascii?Q?b1KoZZ0vxjJz8P3ogg9suRXD5lSXHc7X5XNeHkyZ8USyq+zrUW4iF18SA7Fa?=
 =?us-ascii?Q?EJHPNKX0OcW7zcvVfCdFdwboYr1k8pNu/1r3VWOIudkgc9wEdvcc66pDs/gg?=
 =?us-ascii?Q?Ww1Db/qyE2z6nafBoAFDKL5lmb7+sdzMJ2FoA9YoiIw2tKLW9s7r/LVqjOuO?=
 =?us-ascii?Q?qe5K2ma3/XwxpGUFeUOQC0mHcrF9o55cTtg968NIt9cxi1mN0HTvURyTLEzG?=
 =?us-ascii?Q?xLCm5BOeSQUPI9Vmlh29LoeIOnTTxrTMfseZlpVi2kEzFqpmCjRQYFc5nPII?=
 =?us-ascii?Q?DYV3ycuqw1ZHIHjCp+vHXGO+6jcshPhoM5Ub/v7yMWlb09JlrThRacZ92W6O?=
 =?us-ascii?Q?HFIClZsC8xA3uDOayLeEo3OI885ZwdIOXVPspdvkOqdj5zI0KGldD800bIbH?=
 =?us-ascii?Q?7PQHfiOgDFhDNSaIsfSjpnJZvHMUdWVaa2CzLhHpouIdCv2LL7WBLrNbQaYp?=
 =?us-ascii?Q?d+2ZHBI2pvAU7BQXIg1Bj18tW2/hgzWNzfDcZ67an+n7nqkjLEV06bF0nlDo?=
 =?us-ascii?Q?SriIV5mkpEOacGYXCMeLn8fg/ufEGtisu7IQXMtPXnU/nskRIT3QH9sHvxPt?=
 =?us-ascii?Q?8aBvdHuGybofDK7w2w8CMaon7GmiXa3TG4Ji39alwnKMKdZDOtmBtaa5M1oZ?=
 =?us-ascii?Q?noA4nzEZ+Ox6scrBpI228dSEU1WrOHJXkyQMKVsbBBs+X4c6b+OODiH6slxe?=
 =?us-ascii?Q?a2eo6MrKxMv9sfwJukdFy/jRbi0kX84m0rM4PBL44q3rThCxqLOSUfMmQLYl?=
 =?us-ascii?Q?EJOSeOtfy4FvJSI+tPoZCxslo1gQyHB8JRpzKFDPh+eaqla9oQp8ENQSB/XU?=
 =?us-ascii?Q?RDhBaOFY4K192+KEP89HyBV5DQuj6cmvoi2rLaWoBBTAfz2XaEkXNHalcncE?=
 =?us-ascii?Q?iBzPopIs4k4jEqB4py3h8HlBeSpx76M0hlngNtvmz+3lInx1zPRRq6zZioXQ?=
 =?us-ascii?Q?PcpWc+5gRnsRkFF6jrGFY6slAVjynoIioRXtRzJyi3pL6H2tThTBrEje6LeB?=
 =?us-ascii?Q?iI0fjqeZfoQwPRKvGNG8rgYVpuWcHg68gyiqhWySiglEQ7do4zjss9UMq1i9?=
 =?us-ascii?Q?6If9lJ7dA/eiZCf5zgC3y0V5Duf8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BS70vTMAEiZemv4l53tlOeZH+/V5/AH0M124iG7Ps/uCyN02w/SRLqqnF3CZ?=
 =?us-ascii?Q?H1ZBPDU8rR+BfKPwCNZuW4GxKHiPnPnJiFPsrd9EkhkAJJFJKpKhSkp9zJ7C?=
 =?us-ascii?Q?UeyWPU32GHpnoaioJ/2s7eZyz6trCqPQEcJodWvfgMXtFkCMcG0jABNESL4P?=
 =?us-ascii?Q?j/YuTcadLZEnTgOcIDiHsYtcul8A32G81qNeayxA1go8tTUg9GcT+nKnv+s1?=
 =?us-ascii?Q?aJop+yfigss4lovFBWqZsxzSRRtTQQBb8ZvrVImPxMBDqQdsUAi7fQ6frKCD?=
 =?us-ascii?Q?5nPQm8MyiuWDO86IhSguMZl9Iy673APrFT73LzuubJu5onko6BTyY2VY3HSB?=
 =?us-ascii?Q?AkwO0gnFodoowk9i7aJMdnxkOR7Qo6KrY5jAGQ5R39ZZDwy9SMWaiJ9MQLYH?=
 =?us-ascii?Q?QaHhWcW4g3xVDLoiL+V7jeNEIXsMDQtIMH9EmqcW8vCa759b3aCV61u0HImu?=
 =?us-ascii?Q?yOh3Qt2XsWWBvNx1IxtUP1Q+DdbFKJ2xNJq2qod2+9oYU/HtCTv9wHIzMipG?=
 =?us-ascii?Q?5dnvKwYQ4taoy5M2Aum5i+p/bXAI3B9D5ETLC2l78gfoLsIJlb6srnJ8QnVC?=
 =?us-ascii?Q?4Ed5oJ5Eeg6tlyLIE0mzNYJEwvd6xt37lwu6TEI3mhLqL8kkY2o/A0RPf11q?=
 =?us-ascii?Q?eVnj5Sp5aoBDzQtUTmaaKJrQTTCuSUnTQaZGwCV93F95mLfaD5zXGAQfGmaP?=
 =?us-ascii?Q?Xc3ZPNkMGwO18YevfFZ5uzqojR7dAGvHvpGgiRBYXeYa3rcfP20GgxDxBFYW?=
 =?us-ascii?Q?ck8Pe2nJB1hPXJQAM0sRz/2TDKniYQOY9eoAR6brRZAy8/S3IIk551wCz5Hj?=
 =?us-ascii?Q?2F2BsezuMFHdez6IY51q83XA7yO3qHQsi8TcJqeSqLQ7YhAMKHPX5LCJQfi+?=
 =?us-ascii?Q?9q/fqfe65kK668LStA2Cy6ecT6eVtHzi4u8KYunUt8nxwqmr8693fs40C/qI?=
 =?us-ascii?Q?cYVNrSot1cY9LKtCvFjST2+FsntHPDNp5nEgsOXnRD4ag6TY6IFc212FYpeJ?=
 =?us-ascii?Q?orB4FNkvscCjSGpUOtQirc0fKywpQ6bdGuEsfNp0J/Goxq7lxFHrg6QHaLNp?=
 =?us-ascii?Q?xfw6sskvfqs6wVOiJXFGHU4tQFJvVgAIERR+0YT+YovB+6yxEKzRhxypfp8x?=
 =?us-ascii?Q?iMIZ7YTXFTfFWCJat2JUHOnGtuePvmEgz7o11nGZSlAbzmxeC4AypmQ2dUiw?=
 =?us-ascii?Q?edgUX4/Nh0LR3ua+SeO+UB4o0UlPhOjv21Xdn/5/dCcSPPohDCJwnou8P+BE?=
 =?us-ascii?Q?mTtmd+txlXnBUEf8kklNBKnacxhMLKgBx2Qt7CwRBWBqemI46AGixkDpWgOa?=
 =?us-ascii?Q?9viRve8WHqWeniD+YQpn7TkFNa+bzK8ctPXOWGLBLrUUKyYf3FHL4fLfIx13?=
 =?us-ascii?Q?Xrxfk/pwzRB1Ok4h1JIOV3SruIKB/od8NQjSrtbRLJJIEptRtE0zWcH9vYPL?=
 =?us-ascii?Q?TMS0yKKBDZN8fd4f/FUnFaeM2aner+cYz3YmsLdEMekVbN2I7b25C8/2J5xo?=
 =?us-ascii?Q?xCCyK2HeLH5YDi2JBv4Fu8RV5CHFiWIS+0t97lZIg5igwtTgbDZ6qbe5eYxu?=
 =?us-ascii?Q?mSu+uVpmmynniKCWt1K8t5GAUrXurwLK6UWAOQN2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ca18a4-7ef0-4f51-68ed-08dd5ab1e7dd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 00:17:10.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4dmfXei0mlJDv0BAGuRn0jHelsAvk3al1suMaMvdFIADicaKU6sSQfulUKt6sBR5UYQ8PaOYAWLb7G7tNnIBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763

This patch series implements two errata for TJA1120 and TJA1121.

The first errata applicable to both RGMII and SGMII version
of TJA1120 and TJA1121 deals with achieving full silicon performance.
The workaround in this case is putting the PHY in managed mode and
applying a series of PHY writes before the link gest established.

The second errata applicable only to SGMII version of TJA1120 and
TJA1121 deals with achieving a stable operation of SGMII after a
startup event.
The workaround puts the SGMII PCS into power down mode and back up
after restart or wakeup from sleep.

Andrei Botila (2):
  net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
  net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata

 drivers/net/phy/nxp-c45-tja11xx.c | 68 +++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

-- 
2.48.1


