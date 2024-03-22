Return-Path: <netdev+bounces-81204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7008868A0
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B85B20ED3
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 08:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B7182CF;
	Fri, 22 Mar 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="TNu8Cz/+"
X-Original-To: netdev@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2032.outbound.protection.outlook.com [40.92.102.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49C1CA8F
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097807; cv=fail; b=ICTJ4xj3K9/QRC/+8IFyLu59RA+XiE8QmYonZQFG2d/8sHrTLTC57UxYnxWqXQJKAs7YDtiKiHt5hN2mhyfT6OqjZ91gBMJq8Jnc+9qqJE+DQJ9BUHPX3m4CZMgXcmmUv64NRY45sLM+T2I2QNG+yKjT1366Ci6D8V5Yf1HWHcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097807; c=relaxed/simple;
	bh=D6L7YE5R/Se1dZ1ZxJeco76hGUnXPNdoNgwxvLY7sLE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Mh5nuxHo9ELzO/AeupiIffwid/4A9grA97Szuh3lOQ4ICTC+cVLFvLiqNhoWYIfW+O7/caeaycuwSP1F0Vydm7G59f99w1xe+6enca9B1Gnu4dnnNieouPKE1GY7yC/t6Iur5mmqpz3ueu+YvWibmDCabM1rxgND6xd7AjYBv6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=TNu8Cz/+; arc=fail smtp.client-ip=40.92.102.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ceg/A/ybkSSQ7blpW4tCb+tpPUje4Xj9ec/v+nvozi1/cMNwuCZY4Skb6QSGkAu7pdd1Y3sISuO0VzJjGVx5OwcnYFiy/87pLtYWzibfcjTKEJ/qbH+WzPFFtOA4JzkgTI9Y54gjKjJuiNWuWCoOpg6yUzL2evoT/SIGHXExGoILQ/QlXf7pWplLYDI+kgC+VAOLVwgN88rH003v2BUxsKaiJ7s0MLrfmRW7R+++SQhmQM4eWSIf2VEcJTexWNziL2X6CF6kbouf9psayXBDc40eReeh9QHfWOYIPkFUdTEKgKdPFfPZgFb8DEguiHjVAd5zHR/V6Gr2/JOwO9WZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hQBG4K06so6sWkAREOiSgr8f4b1BzlNXuBRWpPb66c=;
 b=Y5Fh2DpOR5XCFytDaKJcsTCaZIPguFiy6AwxTqVeUgDutFx4eAg9++OnHWW5MvkR+GcE8QJKRQtPcm7TH/Bmkmi8uYGCIKyVyB+mf6XwPlfhRUqPSfJH55yrPPsNmyYuZ+yNM5MoLpEeP4q1Uw5Bc459L5tyFNGO5xvefWQLFg4jJmdocyORz9DrrkuyTKji9SnsIIWzrOH+owlgon26xJGVxPFo+dK76X+IA8weSS5jxFSuNKovoA2Gcedk9Thz1SFIEwBuCqguMfE7EuDrs7Elb0UnpYSBBtAK1040/DdMVE4e1zEbSpCrQIogsq9Ci8sMATry3kaLvGqMGL1YUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hQBG4K06so6sWkAREOiSgr8f4b1BzlNXuBRWpPb66c=;
 b=TNu8Cz/+9gHomD9ugOAOuCpH7+W0tjbxCaILTUxx9liWqVkcKUGLv9M053LJdOxOlnDVCPgLiep0qoSMf4S0fCxW2edazOMetIi6bhjBsMsHGrRpFbHCciH3S4SlvpGthwZllhaUsIw6n2PbCrIaqzNkMU/eNpOS9AFAzpbeYj+AC+73YKK2PV3tJzHcK3NqQEgzPpSpz5457SLx5t3XMCMbOvOglfYpMPS9eAk/XKPR/cu1KgToj9BxBiaPY8vN5Mm3ErUXVNzOXNGkJnm+aQBwsumgTZN9mNF0U+zT6wNcshigHeNi+MLWj5VBlU3yNAeB/ZfNijKDE/025Pe/+w==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 PN0P287MB1496.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:17d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.24; Fri, 22 Mar 2024 08:56:41 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::be9c:e08:2db4:9a60%3]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 08:56:41 +0000
From: Date Huang <tjjh89017@hotmail.com>
To: roopa@nvidia.com
Cc: razor@blackwall.org,
	netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	tjjh89017@hotmail.com
Subject: [PATCH] bridge: vlan: fix compressvlans manpage and usage
Date: Fri, 22 Mar 2024 16:56:29 +0800
Message-ID:
 <MAZP287MB0503CBCF2FB4C165F0460D70E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nfsjPZMRPjI7KDI+bZ7BSb7OB/pqwymnBlhOal85Fc2eP95+U8edFmgjVNCaZyxO]
X-ClientProxiedBy: TYCP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::16) To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID:
 <20240322085629.14438-1-tjjh89017@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|PN0P287MB1496:EE_
X-MS-Office365-Filtering-Correlation-Id: 234dc357-7b7d-4369-5a92-08dc4a4dfda8
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrNLYEJ5HghreUmTctoVX046DQ8BRCvO9zVZOx83lwvGHAgaih3sj2bcGhu57i+IVlCu64CV+m9+MMnUrFtw6m4DnI1P97y+kSJmPFFcS32mK4uTg2CjvhVSnQ34GUttiM79MHGUGyNHyUTt3EaYH9kyJVu9aoxNGcDMeY7P34lhyWyEs3WKNeOC6OULE+ZsITJoqEfVSWU67Sdc1rTQuPwSD/Azl0hpV4O5eQv76+rBNNrMc4LMLFJK26wv0QQQQHOpm5+HVQpvyoUTWXAieF7zGka5bcCvZ8ZTS0rgcKpufkCMB6Kqhg+YvHfpb2SdbiMzJ8uNn6fubcRJCQckVizvXYx6OJPkx33L68yjLXWux3EAQ1hyUcU7Z2iOa4mXqSeyXMzNCKBH55TSv0L1niv9w3+LVobmW3Wn+bGntQjoIoyhJt44HLGUo2oeMtdljFQO8MkUlwFBM1cK3PSqV+GEbbShpnmj18RpCND1oVslrNIQxSR9Ej0kD2iESSR6yYgEXwicHJmR+Hfkjvs1GQavw9LgWwmZ90n+ULF6bpEiegZaJ4IdwrQhEPZHC8XMv+Lz3PmLOBOmgJ3AsbysNCAcw4cSt7Aquwf7RP3/LCDZ5TkIO788jgDBXXQm0gnJFekPuQnLD+1gRuGAAnNsDxS//BMx7RAP9oLPZhh2gp7dB6enwCYWZnNlLGa0RoUDL+Vx8JaVuw+usbCYiinezCwD16mR0/GFS3V4xPSRp5S5AMpULBnTPK+I2yB98EkKQw4=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2yrero0PncIVh/6YPqtvqDEss/Ju9eu4phlP9Veqy0ie9rHQsbxAyOvnLg02RjwuRho+HGV5K8JwoTndwtCGvgSfpl6wEFgsAOVhEygu0v+mcVqkLy2gtSvagbe8T0/ekb2t1FfDWJZCotv4Fw+HedqWjEE++Zf4OIN9J+zEAHu1LG4ydUMFctKvlWmfjuJY4Z+MVUVdr6WF/u08IonS6GyWncPaKU4m0fuMdeUbVwYK8piMacUfFxWmh2FeAxRrFl33JEv9vrXe6qXXqG5+4bmRf8kxMQWI3w/Kc+AXt9kBRJLqPkQ2rrRCq4Bi+G5xSASaJK0EitEESirHykuRMsLOewIv2ZXjSFwrgyruyTwqx4IMED36L76wQmeEaMNmRMo0COXQiAaz0dDAI9II9l3Hd1Jmrynb9YgimLsk2/HYge5Zg2SvwqTz+s50Jqz2WSyMuOpSa3Gy8VFCX4+BLsU+mNDywhOCfZ/OIffTZ6oeG6TCqvOkz6Cf/r4nbZTGTE92MeliUbdpVpojmNIcHIoMOMWBzKJhNwjCztbymVUOOIoBI63bvZSnUl3si373S6+mWhrp5UHNJs+yroYni2BiRGI8WrSm2zUbxYLQsequowJeSZu04hKwqBLwgmkO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fms98NDMFGLT74u5bvQJe8XGVBXeILeY2TukbcLbfd27OhnjbIec+TAhTwES?=
 =?us-ascii?Q?UKPq/ndmBNL8LP26cppk6QjdGotqxd+TfQNcFRWnv2ffMxD8hcNy8m1p7RxR?=
 =?us-ascii?Q?JkRBgl3ZgPCRGZ8h8XwGtSXxvA++eu1HtVYhe4PbmuJ7uPV8/L002E3a8vsG?=
 =?us-ascii?Q?vvUoIFuqgSHOJsHVRJkdpSoUBiSvxiEDz0ZxjDka0DPkyssPTBDCE8TjXNXv?=
 =?us-ascii?Q?A2asut83BLASX7FmE8BREWXTFlzvqKelWb7/Nf4LETP4z1y4JRJiePoG2ZX6?=
 =?us-ascii?Q?TEOs0ofkqVlPMKye8hA+nM/Euh2gpHmrBD6uL/VVX0CmPsm80NzGv0yXJ1uz?=
 =?us-ascii?Q?u/FBbs8a3mZ3gFR5KpNbTR9eqnUfyFGco5uCCzp9yCQpd+msce5+8jC8nEig?=
 =?us-ascii?Q?+Vhny4QBSne64Lt5sQiUO3nvstO4x+qiX/0hzyd32fg46zTY0JqOvZehitRA?=
 =?us-ascii?Q?bbtMz8e66wGL9jdHEx408Xis+Q65MzbKoPKudaZk4i1fG7LINQz7Wb790JJn?=
 =?us-ascii?Q?llpaLLPiblkUal3Hph/mwqKQ9ii0FRrKvO/OUWraWPF5AcyW9I0ozhjdvJnl?=
 =?us-ascii?Q?6ItflZQr9X1TglL29vxBopIIOiHMlvSHVgHHoNnFa4dMsL6XVnsuF7D09MDP?=
 =?us-ascii?Q?YmLTUxPjeDrAzAWN/GODNNGu3BFsNXoE3V33LM2t49Lf56DC04xdlaMq6Drn?=
 =?us-ascii?Q?5t8L79SloDz9ubt7eLtG5sT51fKX+o/NDBpbcASsqMSPWspIS1gChnm7TJxj?=
 =?us-ascii?Q?XEgPom3D4mIPbIi7sh1EF1yy45xo4lDBKKp5LVLMwSvFWeVbtXVV1S3TMUa+?=
 =?us-ascii?Q?obwxPBw1v0V3HZVoCDEmURqgQjS1vmdimbbZ7bnEkyhuNVyh9L9C5YPTpX+D?=
 =?us-ascii?Q?9uGrc/2c7H6z+28DrOeJ63ndEFXHye0HNSbpTrf9dekB38SPN+7KHLFO19Uh?=
 =?us-ascii?Q?N/p3CrgZXnXmDqK/d1XS/49Ny3kh+5NOzwCIThOYHJSMca+/+MyUdsvlAgyd?=
 =?us-ascii?Q?l191EoVKyApdsDTrYcfyUod70c2m9Zx5Gd9klXXl9puyL5Me+WCuhe1przUe?=
 =?us-ascii?Q?KgkBQY6T/eJgqRR36Nd/DmC/K6mJc9jIGDHWC4ZeZO5s8UnulVmlgwVkzvr8?=
 =?us-ascii?Q?kfZYPp46GUFaKnwX72Ez5UFsWPNPPVt2q/gm+3tPMH+tnODWNHL6nYsSY+pB?=
 =?us-ascii?Q?OpPOk4diDhre0QGGYVWnX30/KiNmYOecRBstxQ1YXQGbdB2OcggPjklgvc/z?=
 =?us-ascii?Q?f53Ky6SxVh3C0sUEbPwjpAoRmPwhYp+NYxjjRnqNdnrciR/ny3niqc2cuEuc?=
 =?us-ascii?Q?qNE=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 234dc357-7b7d-4369-5a92-08dc4a4dfda8
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 08:56:41.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1496

Add the missing 'compressvlans' to man page.
Fix the incorrect short opt for compressvlans and color
in usage.

Signed-off-by: Date Huang <tjjh89017@hotmail.com>
---
 bridge/bridge.c   | 2 +-
 man/man8/bridge.8 | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index f4805092..345f5b5f 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -39,7 +39,7 @@ static void usage(void)
 "where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
 "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
 "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
-"                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
+"                    -compressvlans -c[olor] -p[retty] -j[son] }\n");
 	exit(-1);
 }
 
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index eeea4073..9a023227 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
 \fB\-s\fR[\fItatistics\fR] |
 \fB\-n\fR[\fIetns\fR] name |
 \fB\-b\fR[\fIatch\fR] filename |
+\fB\-compressvlans |
 \fB\-c\fR[\fIolor\fR] |
 \fB\-p\fR[\fIretty\fR] |
 \fB\-j\fR[\fIson\fR] |
@@ -345,6 +346,10 @@ Don't terminate bridge command on errors in batch mode.
 If there were any errors during execution of the commands, the application
 return code will be non zero.
 
+.TP
+.BR \-compressvlans
+Show compressed vlan list
+
 .TP
 .BR \-c [ color ][ = { always | auto | never }
 Configure color output. If parameter is omitted or
-- 
2.34.1


