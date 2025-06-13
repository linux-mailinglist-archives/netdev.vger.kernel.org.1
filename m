Return-Path: <netdev+bounces-197582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D05BAD93EE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B1E1752CD
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607A20E6E3;
	Fri, 13 Jun 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZhD74S8q"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF1C1DF751
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836892; cv=fail; b=XP8lZBCKk8C0Z5khElPSTyuqNhjgon5Ong2+8wKZeew21kNBHn2KVlNST26MkSffpDwV/udgynPXdlk7lO1oL4HHZya4R70MsMezCnnrAmqsKMVi1mCylJpdWqA6c0EDb2m5tDhGEIH1/kXukumQemGbiFZ4UtrAzEOrrqTfS/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836892; c=relaxed/simple;
	bh=7Kz4V1417URbZFke7so385tz6TcdvNptTs0ofc5mUUE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jaJRLAC5Mqr8CIsdlFQjS59gUp1tyXPlVo0t2QPuMAmuxhDKZ2b9Diyd3JivdD8MnTYAAVUlZCyHwvDQJes3U+vGpaEfCCfdOMI/prOB1GMt2fAelPnaM7MoMLSkL+FO0TbN2B4hNOfMW4KbfkCeVrc+KaYBHpAOWPPqIRM3nyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZhD74S8q; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZ0ussYyM+/EplSMuJU+5rhYJLa2k+8b0PUY2gZ93t99Qs/VBaB5lj8QdoWGl0xWYUdmhmZ3BJLkpunFxOXkWcG9md0bNPQ72er68HJwR2GpRrgTlShGFpJdHvSrlo0fQn+G+Y5afKNopKn+hgzrcuaqBXS4AnsM0W4/TDBfwtXpJd6/gc/Gwnayrzn6bN7UdJBuq0QdMGXwWGH2ZtoflPKu8ToSJ3PrAN+/n/LQwhIN0nkPLfqNfWqv28Ja1PLeLtryzLFj7RlXl5CWKccJ4PNkP/xMC48vMPdaj66I3kbGLWPZrb473MFdrYTOP+bDrDcJmpa50RC3JMmbPYsyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9wCBB9fEMepbqyg3y73eo6Lso6XY0B9R/pCz7DkRHA=;
 b=fKKuYjaSRjkH1SEwayvTb2NoA0MycTrhXyMOwZqZ2T/bx134q1CzocwGVogGr/xXI+F5EFleGn5TrUbGUBB0JjUq6F6cfvRFvjnRu//R0kFb6M4/c+UM7NzUKPD6H/9G5R2l3tx7mGpI/nCNCeW5lnjG0d27mA2i3V2AsW4GvdtsMMmwtlQgrQljlGV4fpgohBC1MNqbNJ8IVyt6dB938TTPDJSr9ZO3vszKyy9LQ+CaLtJ/JbYP2VZebNr+O36lwVDx0sx5PWpMu3PyCowUZViMwT3dXLybjFpnr484AfcykpfJFsMJnCKbYm5uSu7rsBuLG+GFdoYc7KgpfoWEYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9wCBB9fEMepbqyg3y73eo6Lso6XY0B9R/pCz7DkRHA=;
 b=ZhD74S8qeDZMC4FzHBBSxYIsuQEH8iGQ4kCn7a3ZW6PoH6AuAgKMv7JT8hkLYXiYU7vhu+ZtOrAJUe2uAt2LQUmrRv31dDsSHbRwl7xKP9AXD1DrIszEZGDkny7dt0EJDN6DGH39pRG0oR4hhXKpl6OPPCITn3CYR7tGYTOFSsJNve+N0kBhs5Pg95nO93vi7AaqXplhrM8YgolmW7xlF6fs7NZxv50EoIOov54a6YVmPo9ZIp14n42G2f9+qt7hANNgAyM9ImeHqeSf+fa9Le0ll+zzKP+dX7hbgpcCtITlkt5EYnOHtiMW4K48PCy5J0RbN8Q+DoMgtZqK3k7Xrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10694.eurprd04.prod.outlook.com (2603:10a6:10:582::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 17:48:07 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 17:48:06 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeongjun Park <aha310510@gmail.com>,
	Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH net 0/2] ptp_vclock fixes
Date: Fri, 13 Jun 2025 20:47:47 +0300
Message-ID: <20250613174749.406826-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::10) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10694:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc11173-e51b-462d-49ba-08ddaaa27410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o0O271ZcJ0JZM2GunvCxbKHmr4Eq9CduD5567JVUz5L9LelKoXtnxPmDFyLx?=
 =?us-ascii?Q?uj07k4FNhVw2HCohGOMj6dO6Oucm4gJmw4YvNw4FqSfEW28Ojm2cSAYFu7++?=
 =?us-ascii?Q?+49LFG792jjVUfPk0aNPan4ytR4/hyVHBxq/baWGSg7XanZwIzO6x3yy1qwg?=
 =?us-ascii?Q?xtqQoKB0HTmiZCHZZzDjFI8MHPCi8x6gZpAVsFxJVSeeMJgk6x/dDUII/mvG?=
 =?us-ascii?Q?gxBcnfXs/K5Hz0ECK2gy6bHCW2hZsx61PWf7NVqkbWJhwYSXvKtDupiyFySd?=
 =?us-ascii?Q?CQGs6t0pELj9UKsTjCW3Kmqbh1JwT3rKdqwRHunyfpc0vB+H1YZs3DgzxoJf?=
 =?us-ascii?Q?wh2jmpK/5BHkw/P+dWcXy/y/e/GMMHV7eIBUt05L8tws2+k4z9rBH3MTFShg?=
 =?us-ascii?Q?0paMJ3vd9KQnomJFFOtB9iNOdRx4xynGGUOLsw2DwGRD1Y3Jdg/lZ2dw/R7C?=
 =?us-ascii?Q?DFmG/mRHmru9R/5Ld8jPTC63aGvLU84aGa6iLYkWIBLmxZd/gn9Z3vOD6WQE?=
 =?us-ascii?Q?iwrc+XuYn/cfL3g3xrDw+wGh54Ayp8soD0WD5/gehe858YLWDAFnQDs6CSDa?=
 =?us-ascii?Q?8n9a094yujWM1iKLLpWiLP54w8rQhpTOfNVbsiQ9RQs45jiwZ7YVKuNF/KOD?=
 =?us-ascii?Q?RV5VU+UV1pC90h4bcRlKOue5hc3GpvmlAnMNayHuf9ciGXgqbs/yOyXHaQv2?=
 =?us-ascii?Q?wZyLx0JVEm/7abxPUh0iKuOfdppqXTqJtxjI4TzC23B0hfwrdg8nM02sZxRd?=
 =?us-ascii?Q?1Wx/Me3/P1Ayom35dP3Tm5II4lRggFuOt26sat5PUctQYy+yQK7II2F5jdaZ?=
 =?us-ascii?Q?diTHmPopXvhD4gdf090+tBv9SGI/OiEBsXSjWpngCXeN7Cquo34KBzSB36C5?=
 =?us-ascii?Q?1nsqBltpnv7itLoQT23j28bSDiu36YAPmFLFGdnkL/lpqB7nl+EMtcqwazo1?=
 =?us-ascii?Q?sjOCnWQUywA+RzLVBfBaeu4OLqAYmTvaR22a4TSRTPx9WG6VLWaNYMXcKBx7?=
 =?us-ascii?Q?rtIBD6MSRzAggkjuob0LUvyFOu22vm17VjoTWOk0I4Kp2SSZiCKFwSOQwBeG?=
 =?us-ascii?Q?wopnqJQUqe8eJYb4N/wpyGUfv1yMHjXnDcGjgT16IDJagFzznOHYBvEE+yKc?=
 =?us-ascii?Q?UAYU5FhQ73A1NCotLtG2MyizQI7AOWJhLlgckziVrpYhUE3uMpQQG0fZK5rN?=
 =?us-ascii?Q?g67vkN3gGQ0Ezl2fmaezqJRZbEOQ0XcojT947MLXxgB7DsSZfOVtlZZVOjqZ?=
 =?us-ascii?Q?g0bIxqNp2zi1ifjxTmmQUDhV6K9W1uDdThhKH61vKPN3gaLuBBzzO9wkghuX?=
 =?us-ascii?Q?bIKhfui/NzxboILK99iXYgFJavGXtNzn0nYIXfd3T4UgoiDhFXa1MFkb8OhG?=
 =?us-ascii?Q?5Jz2UgrgHxH/jai0fZ906a9slWIQedceNb5FONsM2E9OOE4MdiJC7PxiZF+0?=
 =?us-ascii?Q?piJ2rL/YqeBNX10CsXDcJUyJPrgkdwM6t4sczPkdWKsb6TDitQURPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?92xNTSaUm385T+91VQPLauZhK4RHyDKEZnPQPn4RDayOnp00Xg/ABPqMBoGZ?=
 =?us-ascii?Q?OLlV+gvAOujwogUms7HZ7cuW7GRQL3XeiCD7B0wFvf3dNdI/R69yZINjNzhm?=
 =?us-ascii?Q?zahJuOAU6WgMqPwZ2Sc/hNUxWWQZ4/ckFecS2c1JwgFe0Jl/dXHHc7T8r9fN?=
 =?us-ascii?Q?xPQ7f7Q+fv3S27PTgDTeelEqTnZnPyDm3O5ihwfNCDs+R53o9sdhOmhctftl?=
 =?us-ascii?Q?WIqebxkKfNN65n2ynH3JYKyl4ViGVt04c6RaLeKge6Jov2HS+jKkDEaZ4MQS?=
 =?us-ascii?Q?864bNbZU68LyEA6o4f95jSVnko75O4lpFfufQ7KZ+rT9COntB/7glYKs2njy?=
 =?us-ascii?Q?v2ud9yrN/AxCU8BSxyEMTKOG5UO5x6C6jcEpSpZBYGPW0GtzeK4qTqJVWaub?=
 =?us-ascii?Q?eExxWHnzIGp+Rt6ySN2ejUb675WqeHnv9NYMa9dC9mys+FxGdnLeCuR3gWzs?=
 =?us-ascii?Q?GWOMSdgM4B7XIXbsvVtlnVLMlYFBTGgtz4ouTERL365c/7K4ehJjQPYKuE+h?=
 =?us-ascii?Q?w7Ee2rHG4U5tosvkszwlIrEwcdk/fpbKdj7nMab+CTZ+ZussgVDzrk7LXZXE?=
 =?us-ascii?Q?TGDXrPAtgSVWdkmVpYna2yzTQgpvMFbX1R5NaSZofH6Y8GUD5SnVwvYlWjED?=
 =?us-ascii?Q?mOCpILwj30U0RNrNVnWRBpBcnLepZH9nGbOXuaNiVEhRJWxomxahbDXjTjfv?=
 =?us-ascii?Q?TwggOtQQ+HIhQLuPCmwKpoeMGnElNF/ylOTPThHL3jAbFjVq37IUTXDZdmGu?=
 =?us-ascii?Q?RAltssSK8tBVm/jy5ItDz+MAox6yyILCejiE4EIvvxKWsL/y2WOmcG7HOLPV?=
 =?us-ascii?Q?obbmi8oR/DZ5vM+nXlf2zulWXCM5yBmxZ0A11jXmtTtwLIdO8/GrdlbrGqvu?=
 =?us-ascii?Q?7LHkAIXbv8eHJheOGQO7sdFxwKCLdI3HbNTfR+MbUoPTa7fsuHC3Pt41h8Cv?=
 =?us-ascii?Q?ofAlTfHKgyvcA8h77F/whhf2JMpZn3rx9DBSTpgv2DQuTFi4OR+1pTmioEeh?=
 =?us-ascii?Q?jzdeNcHoOGcz1OTpM11CfCNovZ9SKh5iz28+0kl5RRo7Z/XO/0STUCuOd4iW?=
 =?us-ascii?Q?6N6+n+H8FUcm0LVAUtu3jioVqqWlaA3Ph3Sqn09LtWlyuffq2VfdUgZoeDb/?=
 =?us-ascii?Q?GTcGPLknz1jAD4cKrGfqih73TqgU8v3mnPVb4wnrAEKVf6jtkfIh0A2tYphb?=
 =?us-ascii?Q?HBmG4wiOSONiveYewQ3FfO2a1JWx+kDSBaUMp16ql8aN4402sWxfumQg7N7q?=
 =?us-ascii?Q?pK60QxD3iBIdOGN7/huMUMV3yjLexoS3oNuWqPI0R+n6CvHj1w6/rIhv87VZ?=
 =?us-ascii?Q?bkE9SvYMDKGXnsLwjjB3JGycCGUVzkq8QpjNy17flU38SvliJnU0DT6F2feA?=
 =?us-ascii?Q?P428sbxycPMBEQn1eaOwI19CPgq3mHzyS9OMyOIichqIoa2lKWwd6za5Y1PV?=
 =?us-ascii?Q?yP/WRwO/H/kMmxyAwK4EQwLs2pdiPCI0bNpHU9uIFvN7Cf1an11WRoErorfx?=
 =?us-ascii?Q?bXayGy5beZUkfGKsN0PxE8MA8dD2rK3voYddyO26+Up74T3XS6tDH0O9u/8j?=
 =?us-ascii?Q?QL4ROTPITowWQeF/xsDlT6LimYVSOc3ZLabSbHwcdCpZ0F0wEH3iO1zuAnas?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc11173-e51b-462d-49ba-08ddaaa27410
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 17:48:06.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvFFR3IaQteJYzd2+yjCYZwtpi0AcUbV4M0LospfM+VsaF9ntcFG2cBKN6d8PyhleihQoVnVOn//Y2BFVkU9AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10694

Hello,

While I was intending to test something else related to PTP in net-next
I noticed any time I would run ptp4l on an interface, the kernel would
print "ptp: physical clock is free running" and ptp4l would exit with an
error code.

I then found Jeongjun Park's patch and subsequent explanation provided
to Jakub's question, specifically related to the code which introduced
the breakage I am seeing.
https://lore.kernel.org/netdev/CAO9qdTEjQ5414un7Yw604paECF=6etVKSDSnYmZzZ6Pg3LurXw@mail.gmail.com/

I had to look at the original issue that prompted Jeongjun Park's patch,
and provide an alternative fix for it. Patch 1/2 in this set contains a
logical revert plus the alternative fix, squashed into one.

Patch 2/2 fixes another issue which was confusing during debugging/
characterization, namely: "ok, the kernel clearly thinks that any
physical clock is free-running after this change (despite there being no
vclocks), but why would ptp4l fail to create the clock altogether? Why
not just fail to adjust it?"

By reverting (locally) Jeongjun Park's commit, I could reproduce
the reported lockdep splat using the commands from patch 1/2's commit
message, and this goes away with the reworked implementation.

Vladimir Oltean (2):
  ptp: fix breakage after ptp_vclock_in_use() rework
  ptp: allow reading of currently dialed frequency to succeed on
    free-running clocks

 drivers/ptp/ptp_clock.c   |  3 ++-
 drivers/ptp/ptp_private.h | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.43.0


