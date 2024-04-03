Return-Path: <netdev+bounces-84535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE418897331
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AB62911DB
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FA0149C6D;
	Wed,  3 Apr 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="YByRV/P6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2132.outbound.protection.outlook.com [40.107.94.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A3149C7B
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156299; cv=fail; b=S46/+ggiDJOTBBeSSavjIuQz31WTK9HjjvCjm8pkUMj6tCuUOj2S8wO2/Z4L5JyAf5ISrHgZ1PQ1dxgxGPsPhF9ov/UGDT6aj2wJPw6Z3Km2S4pcWLjFlVYeGdD8SK+QlJcPI6S+XuH0AfD6CZcSy9sXMlmHitpUk+VwKWiy0Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156299; c=relaxed/simple;
	bh=0sisdVPwVlZ6pmGT58WwME/ANLhBoAXaXybagbQ2m7g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F4ZlKXCdzR1ksnQXMJHEWPu7Qp5RuOuvmgWUVryDFZJCXSu3by90jIWekENNWxnOm7ccFohABn7dtEAA+r58HQC0QMgk1esTlBZxtcCAVgjpU2dn/BgzQulIUkq6IEdVkauyGQ80FgPELkE3m9xNNBxIEPw07RkrmT6N1xHJ1oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=YByRV/P6; arc=fail smtp.client-ip=40.107.94.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/6SUb2WfrVrWq9R7uUZx+1gYeneKdtX+vqsReouvZt0MA6mHNOTaAqBXyuO2WrJh3JCdi8A2kdEpayWvNBIiMX7iX8fUAtXH42tdnKL/0wuonB5AxoYv4Ak++BpJRe1zbgb3YBLVNgZw3HEx8fnfhDAARonHhjZm62svI2ciqBvomuPsnfy9OuoXOI51uOWRTXAslFBhrjs/QJM2xcnGbNU1ss6emPJh6WLYSP+qGMBicWtaMGQP+jrcbVVFQ39+rAxNDIrYzoBm0kS3N4tAGx2LMOqU86TLBPXjB3WuwiVxVRRwu6dqT0M3vCL82AsY4qtyaSHkwT2cZadi7oX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tND220CQS1AqNR1vuOde0PoDlla+O3jX5Krf6yC/i78=;
 b=nXAJhyIFLMjggPOFMO9FMtu0+N9rt7avGPwgfDg5orl8w10lDU5Oj3umiMaWu6J0iyAtNCFhKg28SymddJCEQHGKGgk0170WzutrRVp50tpHoARmwrvV1JBk3MPTaEAHGEgDpdIjx61Hc3hx9IT4vcC/GiGDd7gt9uR2guvT2/qzfGETta6q5VvWkpHleheHVik6Y2FnkestEi6SUJ6WhdrC7qHZl6rE9sc0mkAO39Q0xReABMAEY8XGhzp+jLJi6CsWj0d0q/BhnhgAGOqsab3HYaNK8/FH8x5uYY0pagcTcpR/4JFtCr8k/qxyStb3+EncCXNLmkl/8hVlWFCyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tND220CQS1AqNR1vuOde0PoDlla+O3jX5Krf6yC/i78=;
 b=YByRV/P6ejxBTES2N9ShivPoQAqip1zs8dizme2l4tBdUeTz6o6HVblvs65w9Xe2/fGVmgV5A+KpJuIGvdJyblZqQc35WMgkJJjHCSQsoXZFvIcTFVrNzUyPAh/P05WwDpGb2PO9+Az0dgkoUctKn5sKDkQ9eLGaN9ZPv0f7cE0=
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by DM6PR13MB4413.namprd13.prod.outlook.com (2603:10b6:5:1bf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 14:58:13 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::cd14:b8e:969c:928f%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 14:58:13 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v3 0/4] nfp: series of minor driver improvements
Date: Wed,  3 Apr 2024 16:56:56 +0200
Message-Id: <20240403145700.26881-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|DM6PR13MB4413:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YjJnyXfNFvqi/CfrXcnLFdUVkE4eGhhlDy9gf7/rwVeEMgcVz9GjchALtKAC91ypiJTIze5R6un/Qmn3kp7ZZQyoDBZOYPbkW67saa95Up5vooATEkY8TNIIHTa6n4Mw9Kn6a3Crs/YSVKSkwbX/mZqF3ywN4RxsdcP9XWPAS7m6N5YLM+q6/rENF9iKBFnCXk6nVocS8nFQdxVVIH/ATDLtaYL8oga7Ahbedv895JicVfc9GRC5rJYezVk7KjEtIiz1YpEin38lpOPvI//6FLmNevBoQaxOyUJ2XGafi2oSpcApemajrXX2mT/sEcFj1Mhkroe/1hwuCJZ2+eDKI7dAHPNuw6WZRly8N+AkaBne5NDU6OW+pWk9s3DBM2z1xEk+oS6nACFb2KrCWTaacYP0wIInuvWqsJ51gzSGM3j26jPjaj0gnMwnw3MEjEgIDxaM9fNKkbmjYHFCpImTsTDow6KHUIEywF7ppeHbP/hO3bWSm9yIOzKC8bSuoZjtpw4aFzvdvGgjJfps1iRPvet0y3AtstzYw+FuM7sEmRmVSu+DecEztPnrFWGe+Fo2yjtPA8PAJw+Hbo3Ei2IVCUsfYf4RhYMAjz4EEy0vWvo9a5d+fDFyam+tOK2O4MTpF87aY4iQZBakDWjOYdzu9/v1isYT8S467X0bJBHzZRiHychzXwKOR+7zYgZ1Ndd/HO8/o6ETiD4X2HktsEIw5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XUxEi05x7MVZ18cr16OVoaoDDOsQbkg4B1+HNDY2w3tVqtfdINqinsC0zWd5?=
 =?us-ascii?Q?F2Cs6iBxGXGdSilt5gC0U/JNi0K4w8o+QBOndjkuGfub1HPDyoJN19dYLqMK?=
 =?us-ascii?Q?gJ1rs3Dk6SUa8q8js7tFtOcuOFXi6gnt8ixYW61dCuWV7VBs4bDVyHHP0Uq+?=
 =?us-ascii?Q?q5TOPdlroeDqHbu5ZWBJ+56IzgvlEU+6kSjB087zLMNEEoWn0FhtjGW2QDJB?=
 =?us-ascii?Q?bEGyWpsT8KS1QQ6xB1BfMK7tbpjTIp9NCM9BnOCJb9VKOpfkCUO65Zt/iYNC?=
 =?us-ascii?Q?+2gGofvNkdHmJGdl5w4a4da6BIaEvIGpeWH3l+vLn10uIsPuFGIHFUGO/H9l?=
 =?us-ascii?Q?WQKT8dSDnsjkwZAnWRaInvDOhL6wCjkpEjBult88hb2jmdQD/sWrGmCmxHlF?=
 =?us-ascii?Q?vxYh/hp9/VxcsUy9oDx9kT7wTR0MT7FNbUfcieNREcxIVwlL8iIxIKVcBqZb?=
 =?us-ascii?Q?Ut9rPcSfGyWaTaPNoM+NZzB/FU84nH04FSTpxWpU/wCrdLCO41XAzv/wzkgq?=
 =?us-ascii?Q?I2kXyIeOgaVDd2bHT04aY5r4D99SYNklPUozT11ytVi3ebxhtCxO/WNgFCq8?=
 =?us-ascii?Q?bgWJ/rtUvMYIglnc1rLql41HdIy4WuIRAnKmJenLsxdmSIOmB4G7S5kdYKj1?=
 =?us-ascii?Q?1AI0A8pGv/fJbmsRh8eEvJU+5ogsUCz11VDWgTcdfK6CydgztxtMCxSIIpEV?=
 =?us-ascii?Q?aHtkyBSkiQkObdwyajA8pmbQ56Cg7AyAYQa+5L/dmWHdhzBGVaPw+zoqJgTw?=
 =?us-ascii?Q?8m2Q5JXaRlBQKntoMb7sap5gELQeXo1f/VgNX2PrygNwzVkmXMCx77bWIz5s?=
 =?us-ascii?Q?mSf+u6qD5HYOcrC8icR4P71aFh67Z7LMeuHfaTKUhSR+BbtcgrXn6UtkkDRJ?=
 =?us-ascii?Q?nZ/ADhkLHLGj4tOq55+QgY/aAbZzDRq/UgmG0RW7VI4HnBCHMPqhDmt6eOBb?=
 =?us-ascii?Q?q4SpgkACj2/lHtw5+XInGjtxoXjpknPLROGodRoAM0Iuyz5PgxKicWaTPzdD?=
 =?us-ascii?Q?vHzdIpwSB+7dwsjiyD5AkxQq83ATwZC0564Qh/5IbpJBjL/KKX0Y9Vknyw05?=
 =?us-ascii?Q?5/YGLfI9JMlpaKJZ1JclceEMCpc2LzxAuiB8cenv/CKgvaWj5mBascy8EgMg?=
 =?us-ascii?Q?8h7UIGN34kMYKSuZahrzTkZQDRGogSAjzP+JEU8vZ1RP3k5rNzOgJb47R3WF?=
 =?us-ascii?Q?iPmEZ7oNDSDwxYr74Jge/OmcFS0aLfjNb/io2On40dHc3EYLCYWDPiPcZMaH?=
 =?us-ascii?Q?u5N5PjpbhSaAGbsDBod+5s0mHpLn3bfFhmlyRfB7QvpRN5D6HPxeeHjAyNc3?=
 =?us-ascii?Q?9pKmslqB4yQ4iBta5RRaRFqKhDVoeoCLZHvD5Ib/6gEh5iQX3yoydLx8j11j?=
 =?us-ascii?Q?CfEDgZNe7LDSnwGqDSc37aLq/v057Sr9uB29kpn9yyYSN2acQ6aFmpopNpaa?=
 =?us-ascii?Q?7Wl3omkyFhCtV44jPLXD5moT+n0k1D+9VxlJE7ZPSQIe3MT2GYmIIdWW2q2I?=
 =?us-ascii?Q?aSPpElAgD0ga6DLWVg58bjnTkb3qVncPd72Eb3nk5Krn7YH77hBkFC/7RPXA?=
 =?us-ascii?Q?+FH4n2MMBZ2sFsp56dai7SwEnRCAJQF0ueKvZOPFT3pqgvoylJjY7twl16Sp?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5431c395-b55f-4821-c063-08dc53ee7c16
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 14:58:12.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NevWzdsfeUrBLluGPjX8/vgsmRVzBSBMTH9xmnUAr7zsZjgF2GYYT580VhKDnccSVKuW0t7DzZ8CBTP+fbGMsHOIvHd/NPVMprvKmEPL8DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4413

This short series bundles two unrelated but small updates to the nfp
driver.

Patch1: Add new define for devlink string "board.part_number"
Patch2: Make use of this field in the nfp driver
Patch3: Add new 'dim' profiles
Patch4: Make use of these new profiles in the nfp driver

Changes since V2:
- After some discussion on the previous series it was agreed that only
  the "board.part_number" field makes sense in the common code. The
  "board.model" field which was moved to devlink common code in V1 is
  now kept in the driver. The field is specific to the nfp driver,
  exposing the codename of the board.
- In summary, add "board.part_number" to devlink, and populate it
  in the the nfp driver.

Changes since V1:
- Move nfp local defines to devlink common code as it is quite generic.
- Add new 'dim' profile instead of using driver local overrides, as this
  allows use of the 'dim' helpers.
- This expanded 2 patches to 4, as the common code changes are split
  into seperate patches.

Fei Qin (4):
  devlink: add a new info version tag
  nfp: update devlink device info output
  dim: introduce a specific dim profile for better latency
  nfp: use new dim profiles for better latency

 .../networking/devlink/devlink-info.rst        |  5 +++++
 Documentation/networking/devlink/nfp.rst       |  5 ++++-
 .../net/ethernet/netronome/nfp/nfp_devlink.c   |  1 +
 .../ethernet/netronome/nfp/nfp_net_common.c    |  4 ++--
 include/linux/dim.h                            |  2 ++
 include/net/devlink.h                          |  4 +++-
 lib/dim/net_dim.c                              | 18 ++++++++++++++++++
 7 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.34.1


