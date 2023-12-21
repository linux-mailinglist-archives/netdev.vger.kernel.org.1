Return-Path: <netdev+bounces-59689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E35381BC7B
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98201F218BB
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB88C55E77;
	Thu, 21 Dec 2023 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cA5H5S01"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2044.outbound.protection.outlook.com [40.107.15.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A281DA43
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzhwcY25uchpt9nyIm5FVEc5fqlT+cPPuXPaiK2d9MpxhKa210hjrpQdaWkQAkFjw3sqhK/FBhHaI86M/rrWhZGSl2G5ppY3qr9HYNJtehzmfUQrLCUrpXlN0JlNks/x8ABWcsufbOqUKE8WkJnhGQv2CHhxXCZLTtK8HkxM2v4QtT41iMQBp6re0o+V0pMBZlUnZUte/74qgN849ooBD9IivR63gO0Iavz5Un7AFAIOAhpCc8+rOgoa9v4alhfJhe+hiG3BZHLtoda6RoA9o1NTzCyBs8JGLkpu2mXjBVxhrtzJRgthxJXJP2PSvrVlmkWcV/uuCxKLprD16nsSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGGgtajMC+nkmIWNsYEmp97Dh3JecXX44pqabG7ophM=;
 b=MpPJNVMLP6ZR1x8tFWW3qIpz/ikQIsbvqZDgUgc1euuNSos69PpP+hlI6byN1m8bAU6t9PXU1rkWTry0xzRffWj/6+OgxAMwFUnq0qkuezDQTLp1zcGYzsHBwfgKfEwdRkK252QzKm27sH/UW93e9TcrV/bi9D4ypLNjejb48zyMQcU3KA7eb6W1zMQduFC5ZYqAA2Il+In6iZdcVrF0ZIGOD2L/WwvWe5TaHg0f0vk12qXakhlgPWjqj4iZNesJ11cOhEFyaw5kTM/NaqO+6ESyiiXB6mxSJyct7wJBmQrvTFktQ3JJ95m4qP8e3AuATTMeOvkqGM/UGe4ZwKIPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGGgtajMC+nkmIWNsYEmp97Dh3JecXX44pqabG7ophM=;
 b=cA5H5S01hpjjxEjBwl2MYDeiD/3xiAIz9al1UQPM1m8DnT3gWIHFuUVgpUiAPT/YNyocve0h2m+4Mb5rwu9BCIgFSVYElyTka7z0GiMqU/76Ix/Mj74fvrMcX4CS43Wx9NzH5ynIgb2pNeCNXBuEOogRrC70UXYPVrg+Kn8ottE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com (2603:10a6:10:103::19)
 by PAXPR04MB8428.eurprd04.prod.outlook.com (2603:10a6:102:1ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 16:58:25 +0000
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::4dc0:8e9a:cf2b:137]) by DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::4dc0:8e9a:cf2b:137%5]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 16:58:24 +0000
Date: Thu, 21 Dec 2023 18:58:20 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Benjamin Poirier <benjamin.poirier@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: Patrice Duroux <patrice.duroux@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	mlxsw@nvidia.com, Jay Vosburgh <j.vosburgh@gmail.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Message-ID: <20231221165820.kmycryea2wse7tol@skbuf>
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1>
 <87fs07mi0w.fsf@nvidia.com>
 <ZXi_veDs_NMDsFrD@d3>
 <ZXlIew7PbTglpUmV@Laptop-X1>
 <ZXok5cRZDKdjX1nj@d3>
 <ZXqpieBoynMk0U-Z@Laptop-X1>
 <ZXt6_4WCxYoxgWqL@d3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXt6_4WCxYoxgWqL@d3>
X-ClientProxiedBy: AS4P192CA0006.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::7) To DB8PR04MB6459.eurprd04.prod.outlook.com
 (2603:10a6:10:103::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6459:EE_|PAXPR04MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2c6393-d607-4db7-aac7-08dc02460b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nwk4+tVOpgV1ywrjcWXuU7rhvqrkTE7RYC4r92oSW2b1VW2Wwn1RFa4maBF3xEYGDB3x+Dck26yQJ+4nPB9yBWJaXYe/R1sgrEE0xI1uc4N0C8PSCCXtLKz4Tmqp3fkXNSX37hRkI78MDyaxizxmqSfujgFdVfzCwQbS4B10akOSL4wiPns+kqdCUBduquVRMetmkKHgLtX2f+81yabQjrsknV8qmqiaQD9jdRHLMsf9p38tixe6tAEsLmgPoVuTWZQx9gvQaM9rYrfhr7nqtF0Rdija3FVipjwxec0KLjN460RJMN71B1v5wY3+hB654N+iLm4vxjfaZSxS8mm65EGVZzkl36I+jOJQT8SGxTCmezSJMS4FC4oDQEVStZ+4OP65hZm3P+IyzCgkI0Tfno7mpitonLTZukyxThXxK3ze4sGEaoq0UR1gGnGXgToK6/SpaJe//ooojYeDETaFB8UVGk017KdIyhbX88+iG3O0dHgwW0YvnbiiuwSvelkyv0Ol5plybPT2zhryYzSh4tiEXX7xwQjzqKKHgvtIm7pSyz8pdfzo0Tlgums8nkyO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(316002)(478600001)(1076003)(26005)(66946007)(110136005)(54906003)(44832011)(66556008)(66476007)(8676002)(8936002)(6486002)(7416002)(2906002)(86362001)(5660300002)(4744005)(6512007)(6506007)(9686003)(6666004)(4326008)(41300700001)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LHRjVd8svo4h4T+WbmrBJk8K277Wh64E4Thrj3SSHMC7lOas/rxAhHDAs81N?=
 =?us-ascii?Q?2r+KIGO+t+bKpaoumTrwMGQ99TGsCz6B3JLU2xo5tXOmQtKBKYdBXX5la91C?=
 =?us-ascii?Q?gEIAY4smXky7HxVrRkvpnJ7ikXR/EqMIOOa0rauxvE3toST0a+M2ZnbE6UY3?=
 =?us-ascii?Q?OATFVnmIgjh4pubuNaiKJPwPYD2HSXvTAxtHWuSsx0G9g7ihG0cjOD3vRaev?=
 =?us-ascii?Q?b3+GXitww1YhSlEGNs2VFzA+w5OabPQVh2EhAgNQ+tqOyk04qSU+0xRPVTcU?=
 =?us-ascii?Q?TyzEaS7EvvWa0hzeR/0PNH19L6NXdwHSJT7W1c2RmRwxWKQ/gex+ZPnbGOmp?=
 =?us-ascii?Q?J9JS6w028u+x0xV4vGLtrBW7uZDvlDoqRry9EKmFM8roc1h3/6W0cyr/OP6z?=
 =?us-ascii?Q?omBbppiKxsSM5kTZhWVzjvduwduObsILKasUzyJcs2IFAjDlg/hFo6WtQR6E?=
 =?us-ascii?Q?FXKx/9ysLi/TZe4dxqVOjnqOUOvHsMHOLYbzfNln2gjjcTdCjYcc3i4dU9wU?=
 =?us-ascii?Q?sIXwYTCqJQdEmR6Rws+ZsQp8cv5ZW/FnPXLKmxu1ikjRw59h7DHKoGvTqEz3?=
 =?us-ascii?Q?BbWurtmKk00fmT+S0Zbn57WUPr7Bc5TtZHFQyoualE3Hw+1Y/O0znkVjKG1f?=
 =?us-ascii?Q?Aw3ZS/936rLB5gOwIlyUAtbgIGxAWy9Li9oqqIZr5DnNGkEIET9JEn4zAc1r?=
 =?us-ascii?Q?l0XXiNqL3wvFk7cS1YmZEC2bnaSKm1C9rhh2cmU+eaSea+JJkJq4c2+jdjwD?=
 =?us-ascii?Q?+AZT+6MRh7qU5HEwCtTUVTzYCfC7gysKIFaeTNEfHcCMdslPDZKcCxTLiPPt?=
 =?us-ascii?Q?AVzmym7ct/U9Ge3uFBGVpe8DwwRfqOlLGkmHvB5IWSP4atPhruRvo0FcmFdz?=
 =?us-ascii?Q?+uarZBNxClYwYKr8Panfx5Hw3MBl0hu7q855+VfHdlwCUkP/rNoNGSySE+F8?=
 =?us-ascii?Q?dFj+CQSezR2wG8KZwkZT029YDWkYUDRbWiFlrd7tGnE4llCawbVBu3fKf9dz?=
 =?us-ascii?Q?0VnLWJFKSAXwTZjBRyU/w674JjGT0o/YtdNe9u5bI3pMAQ/xpGYl0Y8czj3I?=
 =?us-ascii?Q?bE+Bg3BdQqIkB0D47xQ7Gq4kfYP0Yavz+8Ed7ktHFA1rh+sYyvCu1zMCXPBc?=
 =?us-ascii?Q?fXbO6IVkzbjNNHYMbIFDtLz6N2VSbvwbgp1TL4QxBWcJWuKimmyufZ/tOcju?=
 =?us-ascii?Q?ii3cm9Vkhq9aSKrFENAJJbIvyK1T2zip8VueVg5hofLFZBk3+vNvPjXv6Feh?=
 =?us-ascii?Q?l/AkPyoWMsScQ7ndrMhEGnP1olq+1Z7NIiUnfULoZwLQZgomQWdbn8Gl094O?=
 =?us-ascii?Q?D3OVh5Ki8kKWIM15SyiHpnX88uwoUUwi3wgI83VgMh3maoWDTgW0Wqydm9H0?=
 =?us-ascii?Q?1LlVHmXrsFFaSsnmz4fZZa8NqBs9/S0FkkYC+48X7FUM07aN4l1NuNW8QtWU?=
 =?us-ascii?Q?XUt9AfPbrk9zWgpIfAfYRTz3NMvjVM4Cfq99NDNNZyi7r/DNxL39j3TG0csi?=
 =?us-ascii?Q?No053gkHSicyyuT59I7iyUAIeq2U87AldqKL172ojpbqICZDBM7rr0Fv6mzX?=
 =?us-ascii?Q?FM/s4hB2JGvhRBWMTia3XnJSkaSt6U0p417Mi8CYFSvEVF84yHJN1wkRxBho?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2c6393-d607-4db7-aac7-08dc02460b99
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:58:24.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UrkkQrbighXfrP363BahQb/x0kbTQkMgdYVPpbiigG0nnB2SXWz9XkT/N6ZaFA9iaV5DkvY0Skx4X7NlN9Srg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8428

On Thu, Dec 14, 2023 at 05:00:31PM -0500, Benjamin Poirier wrote:
> Patrice, Vladimir, Martin, how do you run the dsa tests?

Not how they're supposed to, apparently.

I used to rsync the "selftests" folder to the device under test, go
to the drivers/net/dsa directory, and ./ the test from there. That is
absolutely sufficient without all the "make kselftest" / run_kselftest.sh
overhead which I don't need, but apparently that broken now too.

I don't have a strong objection against eliminating the symlinks.
They were just a handy way of filtering those tests from net/forwarding/
which were relevant to DSA, and just ignore the test.

What might turn out to be problematic is DSA's forwarding.config, where
we actually rely on the STABLE_MAC_ADDRS option for some tests to pass.
I'm not actually sure what is the "recommended" way of deploying a
custom forwarding.config file anyway.

