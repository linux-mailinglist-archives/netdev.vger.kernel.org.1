Return-Path: <netdev+bounces-54474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E217807370
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704731C20F27
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5E43FB39;
	Wed,  6 Dec 2023 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="D0iORjhB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2119.outbound.protection.outlook.com [40.107.244.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F0CD44
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 07:12:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPQt3Lx1wNmFuB85PwdY0xo4LePKXuQgpbf/Y2vIUR3dSBH56ZauvtYRBYLn0bzwaMWdkbyyQcIm4GCAECKiL9pkCdpYsdYTk0ma4C6w4+AuxQjHy0fDr3fV7JW1t+HCv2lVOmhwRsner5f35M+7CgnyMkyzZVL2+dEGs404vGmIbPjmILUTqy+MCXPtrSO/Xsld9sGHoqvG5Xm9foFlilZBNbxe8/nZvfjL/xF+6E/rvl/B2X2/2bRxWFQH5FNFQJh4l74fpJ5kby2hLzySo3uE16fetFIcGu25nZVM08UFluprcT3WLF63TqIlIGDR38BGPviWJ6RVVuzdVrEiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0XPPaLDp0qUjI+BOSV+HlzMNQvXrAzCSDB8FnSdBpQ=;
 b=RiqSixkOGP3rWSsP7aZ3xbSGFfi3LTrzDDiQmZKY9WMU5dhiSXx5wzTx3k2x/WmsoNG+wKw3rvRYoTo+tlGpop+FbtO9HWzFeH5Bfzxsucc32JIRcd/CCziXXWCzCpZhvKv9w2qCoglpEbzafNYpn4Oxu63h2AXCkLu8Qnm5QukoodvlCXsS7GGEaNkC2KNkDpqcyqUI7t4gucG7rEbIij+UpzPyat9g4B3pirthMT35yzXC7+IkUGGdjkX4QHdUPncFSqCgjwlEk3eYMfsVrM95eN9TrA9d9OVECSCqVcESOxGDxv/xGANly6+tN0UuMAeeiGOVIQIXCCiEfLxXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0XPPaLDp0qUjI+BOSV+HlzMNQvXrAzCSDB8FnSdBpQ=;
 b=D0iORjhBxz9W98AwT8JUneH+Mcl+b9BIksgeC6pnmpOCwRJ2Pk+5pP5A9yJQUWhtfxBe+RNFfFr4mPrbTi93s6asQnSBHxbzovst8eJiZmAwtLI11PButxs1EvZ3dI7+Tjm93S062u90iOt+882kj5lV9PgXQPwzceXPh/82lsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by LV8PR13MB6421.namprd13.prod.outlook.com (2603:10b6:408:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 15:12:31 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 15:12:31 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ryno Swart <ryno.swart@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 0/2] nfp: add ext_ack messages to supported callbacks
Date: Wed,  6 Dec 2023 17:12:07 +0200
Message-Id: <20231206151209.20296-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 519a496c-ca68-4d48-580b-08dbf66dc42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AhfaZsXqBWDso0jNvenXDcbcnPQ7xl8ZgAYj5T2NhIlgq4OENvudb/14gu3sYFkf4sCTUMoOdFpJuQPnI7SbBgUzaZ3xwF768FcQ1VlaYLe8eAN/WFIxadR0Lm2Hf+a/IQRR7ztQDUhjvNUfUEzn7Syv96NekUmiqewwnqjIrV3gb6uVk1/IojXbe2Kw2wqgFgqGYA+iYN5lxEU0wVIajYVn5G+DysWIC2uRgYsThM2Nfxgyv+KB7vLkDWPqSrpZz+onDh0aAM+83d0Dwq2XxbtZCX77gXK68muPQb14dMcq+EKlBCJyD0bh/LO7bePYCKMFHrA1Kj5tqMFQtX8wa39ZoWw4MS13lcO+Q43arkS/X8XxCqwsq6W2Z9NgiO8o8TfTmhE5yxk84Vqe1yM3IKgT44E+edOTS8qTnTna4nI2ddoYGO40h9kXu4TLqKC62nL6hQBH8zNPpAX3LiRbFrta0dWLW3gvxWcEF8qdAQo7uDQOF78mysbqE7Xtq1LUjMsrMu4sAeZOEQ+i6aeRdwolXUZi2KDYtQqAUP3Eni1bVKbl9PB1kzkpuVLv+1JBTlxSAUV2xltEvsVCYT/P4yuaOXc5YnUJsHTjyz1JtdqUU0X05ZwE0D0mmz1t2832ffVRECs50q/Xl63QuflhSCCzQ42qEY4pONmXUu42Zss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38350700005)(4326008)(6512007)(52116002)(478600001)(8676002)(8936002)(26005)(107886003)(2616005)(1076003)(6506007)(6666004)(66476007)(110136005)(66946007)(66556008)(316002)(83380400001)(15650500001)(4744005)(36756003)(6486002)(38100700002)(5660300002)(2906002)(86362001)(41300700001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3NBR9RG/KdgG1z/URXe87nDvXTgU6v9+U9R46+GkedgYXijZye4DMSGYSxjp?=
 =?us-ascii?Q?HefaEcBW/BQXKAXTAZ/EE2MfzBaOx0d9SwYU8OP9m1g7cl9gt8oJgMNPL1WD?=
 =?us-ascii?Q?xahJ8WHNkDPgmzMtPm3E0uhi+X2TXYoQ2NQsP1n9U0YT/7Xss/OzG8yDqdKL?=
 =?us-ascii?Q?zELVibp1dVeieFbU8VlmcztVspFxUFFuH0JSLeSHnY82qh+LtQTbiYpOrQIH?=
 =?us-ascii?Q?3mZFzc1cyfvCaECK6uKa2EL6r9KWxUxt083Th54a4Ll6IZyNXzqM/Wc5JdfO?=
 =?us-ascii?Q?dAo9+EY79i+9cgDqdyKFCGY3CH1942+W66LJyEgkbHhd0cYYUAjmPY9qbjJz?=
 =?us-ascii?Q?SW/kLvEAMoYrn1ZvbtG45IA6eLTP8wf8mh546Wxpv/0FCd2V7UPVM6KOWkyH?=
 =?us-ascii?Q?LHLKL0yGKxbVGRHx6mT/lRA+xMBwI16mWLvIIJOz2iGlqag2icwylgpA2iMj?=
 =?us-ascii?Q?ZpE8M8Q28uyHIAFuf/wpfwnVNgi8Y1DhNJXN6YtK29A1gB1GYHxHLCD6SRsj?=
 =?us-ascii?Q?13wCkYAcWzE6QBqbih3cYx0aH8j7RBYUWCvQji4oNvtH3jJkkButaaTcPUWW?=
 =?us-ascii?Q?xqUqjkB2BRU42ZibYcVxsB3skdip+/jXo56aQTIpbjhmAyt270T4x+X3JpXd?=
 =?us-ascii?Q?ONV7dkLpPjX/oZA8hdkcNPQcOZqnG58RjES3ZzkkcVnMDwLf/2QHXRoHiJ8E?=
 =?us-ascii?Q?Av+46WzKs55eRsoZeI02PqbhXB+7nacI15H8Yj2BSloA+EucvcuzZcelSr60?=
 =?us-ascii?Q?xvZvo15BPbUUj5c3vnrQJO5HS5i2ckgLOGH7J6lcFMO3YFWGqUdesl0EWuzf?=
 =?us-ascii?Q?ReADEgvjhEIIAa5ptdVOA7sx6KSkhnmp3Nrfa9RdkwuzhS/BSv28wZPI6doR?=
 =?us-ascii?Q?wEVvr+lxQvej1w+cvH2a86ZbHhYZ3pbceeBUdY2IFca3fk8QGDlz+oDqbcTl?=
 =?us-ascii?Q?/jsN/xb59psEEk4ES0pNdaiiKsxKOSccQMfr51GAeZkq1flDv2Y8a48WYIjI?=
 =?us-ascii?Q?9rpjEv0fHxbPR9sR53OxY8wDf0rncJO0ZP7Sx3LIlgb4zAq/G3IqKO76ERks?=
 =?us-ascii?Q?MD5Mdh5RhwetMRJ7AJu3FVi35EkopATF20xDs63meMzanjN0/liIfSgJzNTF?=
 =?us-ascii?Q?RcdHHOPeP2dHYZgoOHzToNkjdFpzQ9aINh5t1tMULch007eYJEGDdqXCY+xe?=
 =?us-ascii?Q?IEEd2T+nK0tyLfFPM8pukMm9qNTbNAOacmtaw+b10zRUT4V9NqZy0IZOUw8n?=
 =?us-ascii?Q?IbJDK9ZOqk7opnMyFMndbQa97EHBpZH0lyteiFrzfxQd2W1qYND8ERSBSAJ/?=
 =?us-ascii?Q?ftFkCMmt4u+uAtH9DT86ZoX0nh+9gtqdwDtQd1ydHmZ5nZ9lXzYhY1M4Hc6A?=
 =?us-ascii?Q?YlxAUrRdRU4blmpuJ5bcx6Lr0Tgo8+fm0yEsCq3ElCC6nC+9vTap8ETblxbP?=
 =?us-ascii?Q?ZeXyxn4qRAi/kbP7RGSVfpz9uq8srpG18RMIW/DvTwaO2DVhytQob4r2GkLF?=
 =?us-ascii?Q?51EAHJuKbsU27sa66bqD/AzRc5vM0XqLtGXEnakSXGq2tTn76bWaYvcc1P5+?=
 =?us-ascii?Q?Y5hpq76WWsK7JzPV1krXJtdx+/4RTU22jhpJcCKN3+yDiD6kVQxl/0PUGZv7?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519a496c-ca68-4d48-580b-08dbf66dc42b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:12:30.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fj1Z7UbEoJDlzIWZgsTMcQh1Pux9ZUVZChNW96jTQd48NchxXlI1znpfU1XVdSt0/uCD2vXAwO9vgHWQz+C2Bi+JOaokDZqVd9XydmYzmhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6421

This is a mostly cosmetic series to add error messages to devlink and
ethtool callbacks which supports them but did not have them added in the
nfp driver yet.

Ryno Swart (2):
  nfp: ethtool: add extended ack report messages
  nfp: devlink: add extended ack report messages

 .../net/ethernet/netronome/nfp/nfp_devlink.c  |  8 ++-
 drivers/net/ethernet/netronome/nfp/nfp_net.h  |  4 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  6 ++-
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  | 53 ++++++++++++++-----
 4 files changed, 51 insertions(+), 20 deletions(-)

-- 
2.34.1


