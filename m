Return-Path: <netdev+bounces-46268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8CF7E2FA6
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 23:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE05B20A45
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB62EAFB;
	Mon,  6 Nov 2023 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CDm45iu9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668B32EB07
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 22:15:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A039E1BC
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 14:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVaDIT2z3ovVoBG0rt6/R6GFI58PJkm5zzu5f/fZYnA9uRj2dMdXLYlaVJgaPxxIWclKKwL+rpm3K+1kz2Zxlsvf1UNkzK51AJjPDWprVXndGLW990QFATQudFvyD2nbYlZP4IfYQEY88XGAr6Jceffr5bwA1NdYtJyqzy9Swo7vGou/++OlBSPzLAslRfhqlGxU6NXPQGT3tWQasMriI2QoaJTrTnPDyCxkFWPIXFMl06x80RIqR/pyM1mXtrMacCDD6QYSdL3g5cPcGS/HbuigaMYhKkNamDe/NH2h/wNWsF6yRDAkh9eo39zTCJISqxsGpr2KoRF0+aDDAoN6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+Q8xuBWZKjANnBFF9gAMMtC1XQ1GTnK2vHjkOa8jKI=;
 b=D/Y55IIrZjLPDW/3hpr7WH8EfMAi9WDnyEZ1qwY+nuP4mP1ii9LtujbUS+BGOkxu83Nj/4odCnndFG4xk76bOXNrcNWbv25nOA8yCqlGw7GPo9qPavFJ+eqYpKj+aZDTgxElRS7ru699cWHEXw2noRc0osI/OsZWt6YL+mcfj4IzvRTIpNYcHkmp2Yzws725RVk/Xg+Zh65bCvCOLzQU8XVaeJuprruBhQsL3byf6DWBC7UhWhvHD47SYP2eK6FiG6E4i9k0JGdtgQ4KgJ9HFnTqoOYVOJnFdH4RAKGwLcj+2J+JsXVfy1Al7Yh4uhwUiUtaO6cSzOyfcnO9bAJDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+Q8xuBWZKjANnBFF9gAMMtC1XQ1GTnK2vHjkOa8jKI=;
 b=CDm45iu9pmQQS5eQIendzzUliHwwSIA0z23TBTKxbsl3msre9/qbXGnIBZn9mUTb6Yuah0eWJ98+xlLNt5fWiDYdT0yA6MPUTy/XPFbuoO3xJcBMSrGyYzL8wdTxY57Kx3llJmdRG6GElmT5pfIpGVhL8zezBbUGm1twk012j0uyFajx9Gxg8zCXcxkXPmq3T1AMRPmUL7Exe0/7wtumyUAkjcqmyR5flboC+llqe8lz0Jmvu+XlINqX3VBb4l5iLss9W1vPz2ChuH3FUufxYbyw877D85qNJOyPASKFcJ0dKoM78fu1aziUhJYolp7USUY+dJc52VA5LQKT3WYgKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 22:15:18 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 22:15:18 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Eric Dumazet <edumazet@google.com>,  "David S.
 Miller" <davem@davemloft.net>,  Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net] macsec: Abort MACSec Rx offload datapath when skb
 is not marked with MACSec metadata
References: <20231101200217.121789-1-rrameshbabu@nvidia.com>
	<ZULRxX9eIbFiVi7v@hog>
Date: Mon, 06 Nov 2023 14:15:11 -0800
In-Reply-To: <ZULRxX9eIbFiVi7v@hog> (Sabrina Dubroca's message of "Wed, 1 Nov
	2023 23:31:33 +0100")
Message-ID: <87r0l25y1c.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: defb954a-4d1a-4185-3256-08dbdf15dc1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ze6kEKqZv7CcgI5XYA51Vd6ijLZGoALDgWZZMzPiZwsUxeomKQ1glA810zI31Omd8ZxStkZFZMC4h7DKRpSPzIFLpiL06A4pM0YFCqWbtT/dYIsjK+sgi2/+n13CiPP2IqDXFOlLVpF6Y/G1kmZ1ldGfzOMzsj7/0NBos40cJdQwdsgbC4m2w4QsQSlUB5mTQTMSh0yzWkVEw8mteStPobxPcjB+kOBB/MvZG/GJqxi4kNN4uT73rVnZIIR/qQFURWUM8cV2mHqV7/pWdLmM7W91kwqWXjFq5+XKkkLmHB3vv5SHh/42Ftmdmq3kUlViQTvQT8uwe9DNT++XgO5ko6cK8kxtcdUluVraQQBwg6RbdjLNImDqmBMozWJLxa9Rnf/l89L0QzjJ/iy92qrZKoIlwtrRNTvM/pnTZzPT/y49iJI2KzE02KlnsH8SYFMaqi6STuNFDqxHDSqNFCpDA/njD6NzcB7Rp6/6TLE1ZTGcA7ZAKHdHzPjAfAASMQgsiz66q130IjLm5/JgxD9xTC4nS3YIr/s7yRYjCd6HT1khElbK1ElXrpdA6JK5v0ms
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(478600001)(2616005)(6512007)(6666004)(6486002)(6506007)(36756003)(38100700002)(83380400001)(86362001)(66946007)(41300700001)(66556008)(316002)(66476007)(2906002)(26005)(5660300002)(54906003)(8676002)(4326008)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xPtUJl6nCP21e4BBNEnRqXwh6i8twLje3Me3TOYCGBjRlakLUNPSAV2qu5YJ?=
 =?us-ascii?Q?6rfDaao5USFYZFwsx8lbmmjHoDAykpkn1h+gCA4Hbnu0EO7P5j39BckxVNbD?=
 =?us-ascii?Q?peoN4dJIrrJy3j8EQTguj1rdYn6zZn6gHWDJwlfIEhnSxEEUmjtArln8MSRH?=
 =?us-ascii?Q?sQmvqz/1YCEs8TGLwmNpM5pRnmajrtjwalMaQDjOCGEfKEMEciWQJWgl/uZ7?=
 =?us-ascii?Q?IFZy4SR0r///E/WddTXGye+qyLOtPqTxb+sjk0AZ/Ux2/OWxCpzN4LsGZQGO?=
 =?us-ascii?Q?70ujhQRACmr3NXqZ8ef2fHU08bpQX/XF466YfJNQpRaqx/kOhSH2vT7SWFIA?=
 =?us-ascii?Q?5Za+Bl8AcGfb4hh9isfp/JI10MhYt4iwlz7XkSYZl+zMhBWkngOzlyP3nPlG?=
 =?us-ascii?Q?fXbJRYF2IBSrXsCICGXaQhygp4aQpQW5qpe5P8qMJoZOnsPHsTUbIVWip8Qb?=
 =?us-ascii?Q?5w0e9f1Mjt8kA76URLZhBi7DTKbOIcPt+u9G8bu9LGCVcLa/iYqSx7I1ey1b?=
 =?us-ascii?Q?r0RSmyCGpWnR/AQ/fawdaLptAlCc4lJIHP5glZi7IUZYRl1xBi+Fk9K1RsYu?=
 =?us-ascii?Q?H1mS9wILuTEBn2q2JejRtSYe0vxgOB6DOOgSa/MdV9mMpu2W8PfXya/deDFa?=
 =?us-ascii?Q?h8fEKwR9YwIyvlfIUPEiJ8NEvllIkPOY1m2zAy2W4S1ug23vtQ1OTLSL0cqT?=
 =?us-ascii?Q?pu4CjpQrLPfE2wEidcvqs8W/y5ghBFWkkgeCzqpo9zsLG1jEzT41o8mGRWaj?=
 =?us-ascii?Q?U0GbxhDzQvxzkQhkSjgBxUhT0+06vO+dt3bYDKroTsmFLbIxTW0c1E0t9Rbl?=
 =?us-ascii?Q?8mA3n0jbCeELVJTJFiTdYlmugqh/4FWT9LLfTAkgnScAup48ZeHK7Z5N/ISu?=
 =?us-ascii?Q?PGROAoZuxnm3WaqyRE1xqtim6y09hMwbDVW+jFFh/6V6pHHJ2MH52taxdfXd?=
 =?us-ascii?Q?LgCoY+KG01WPiXR4mXQg2pFp1Chv4kVhG7hIKolhHChUFe3yIWk4HusdsGKI?=
 =?us-ascii?Q?vSq6Clc0I6NXg0g0iSNxQfxdpGqtf9uVGrBZIhprQjXac4/EWcKO8JRVRvf3?=
 =?us-ascii?Q?UBMHSTmahzdDY4I7IVy95r+NoV7UlRXbYKdLGPKmAqSI5RL2Tbie2TOAWOkO?=
 =?us-ascii?Q?Gcr5WQ0ZnysNMQwiYmM6PuKoH4idJwEerKNHUz5Fr4i25zDLSVaaLtN2dORq?=
 =?us-ascii?Q?BnX7MRqUrJEwfq/VxVEvx+9nBQc6L7rAAGwE/v9Je54KZEB9WpP3f3gKex7D?=
 =?us-ascii?Q?c3AcV5E1GZOnxhXnrxYKbCZBuLrt90UuSSWFx0EgnhDl/R35VP5WXZBkJiyO?=
 =?us-ascii?Q?E2qwhIpzkXwijnLVzK7vX8C4019UvsFTJVrwuJfO4rISwv7gNz2HnNwlwvxv?=
 =?us-ascii?Q?SfgGAvunbC7I+iB8kz6qvc33Y5gcbK/5yQVPH1H69bqiocPLQBelrcvxVU4l?=
 =?us-ascii?Q?ptxxorvdqxSzSzAK0VGLYAradeeFKU+Ksz3gE+GV3BXMgJK3/BlIInDpxgF+?=
 =?us-ascii?Q?5FosZQViGFDu9jVcIeaGBn6mc3grPFS13Rc1CVBneWB9anUaxgNw6tjoE8qH?=
 =?us-ascii?Q?27zJll5W8Dpzl/Swu/JTiIvpEDqqGzPMz9rpDakogeuS1OGEmSxHLGu81GqW?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defb954a-4d1a-4185-3256-08dbdf15dc1c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 22:15:18.4718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uUc6Jf2WNR0tVj6Qn5PDx5wGIJGN4I2S9XiUALwYbi3DdKlC70XbdDiXdlWAnwG48G3LWY/4h6BQFtkWOxDyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463

On Wed, 01 Nov, 2023 23:31:33 +0100 Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2023-11-01, 13:02:17 -0700, Rahul Rameshbabu wrote:
>> When MACSec is configured on an outer netdev, traffic received directly
>> through the underlying netdev should not be processed by the MACSec Rx
>> datapath. When using MACSec offload on an outer netdev, traffic with no
>> metadata indicator in the skb is mistakenly considered as MACSec traffic
>> and incorrectly handled in the handle_not_macsec function. Treat skbs with
>> no metadata type as non-MACSec packets rather than assuming they are MACSec
>> packets.
>
> What about the other drivers? mlx5 is the only driver that sets md_dst
> on its macsec skbs, so their offloaded packets just get dropped now?

After taking a deeper look throughout the tree, I realize there are
macsec offloading drivers that do not set md_dst. In this event, we fail
to correctly handle the skb and deliver to the port as you mentioned
previously. Sorry about this miss on my end.

However, I believe that all macsec offload supporting devices run into
the following problem today (including mlx5 devices).

When I configure macsec offload on a device and then vlan on top of the
macsec interface, I become unable to send traffic through the underlying
device.

(can replace mlx5_1 with any ifname of a device that supports macsec offload)

Side 1

  ip link del macsec0
  ip address flush mlx5_1
  ip address add 1.1.1.1/24 dev mlx5_1
  ip link set dev mlx5_1 up
  ip link add link mlx5_1 macsec0 type macsec sci 1 encrypt on
  ip link set dev macsec0 address 00:11:22:33:44:66
  ip macsec offload macsec0 mac
  ip macsec add macsec0 tx sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
  ip macsec add macsec0 rx sci 2 on
  ip macsec add macsec0 rx sci 2 sa 0 pn 1 on key 00 ead3664f508eb06c40ac7104cdae4ce5
  ip address flush macsec0
  ip address add 2.2.2.1/24 dev macsec0
  ip link set dev macsec0 up
  ip link add link macsec0 name macsec_vlan type vlan id 1
  ip link set dev macsec_vlan address 00:11:22:33:44:88
  ip address flush macsec_vlan
  ip address add 3.3.3.1/24 dev macsec_vlan
  ip link set dev macsec_vlan up

Side 2

  ip link del macsec0
  ip address flush mlx5_1
  ip address add 1.1.1.2/24 dev mlx5_1
  ip link set dev mlx5_1 up
  ip link add link mlx5_1 macsec0 type macsec sci 2 encrypt on
  ip link set dev macsec0 address 00:11:22:33:44:77
  ip macsec offload macsec0 mac
  ip macsec add macsec0 tx sa 0 pn 1 on key 00 ead3664f508eb06c40ac7104cdae4ce5
  ip macsec add macsec0 rx sci 1 on
  ip macsec add macsec0 rx sci 1 sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
  ip address flush macsec0
  ip address add 2.2.2.2/24 dev macsec0
  ip link set dev macsec0 up
  ip link add link macsec0 name macsec_vlan type vlan id 1
  ip link set dev macsec_vlan address 00:11:22:33:44:99
  ip address flush macsec_vlan
  ip address add 3.3.3.2/24 dev macsec_vlan
  ip link set dev macsec_vlan up

Side 1

  ping -I mlx5_1 1.1.1.2
  PING 1.1.1.2 (1.1.1.2) from 1.1.1.1 mlx5_1: 56(84) bytes of data.
  From 1.1.1.1 icmp_seq=1 Destination Host Unreachable
  ping: sendmsg: No route to host
  From 1.1.1.1 icmp_seq=2 Destination Host Unreachable
  From 1.1.1.1 icmp_seq=3 Destination Host Unreachable

I am thinking the solution is a combination of annotating which macsec
devices support md_dst and this patch. However, I am not sure this fix
would be helpful for devices that support macsec offload without
utilizing md_dst information (would still be problematic).

Would be glad to hear any suggestions you may have before sending out a
v2.

Sorry for the late reply. Was away from a trip and wanted to validate
some things before posting back.

--
Thanks,

Rahul Rameshbabu

