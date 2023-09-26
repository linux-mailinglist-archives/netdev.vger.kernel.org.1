Return-Path: <netdev+bounces-36334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65AB7AF2F1
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 20:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4A1D7281684
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 18:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E22047353;
	Tue, 26 Sep 2023 18:28:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614245F74
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 18:28:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03092CC1
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 11:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnU6QbG6f4FFd4YqA44nHkpsaBITK1PpOWxbFCGFywJitwKWDJVy4SLz29m1eBnrb7GJlgYxbOshm9U45DKKRxa17iaU9PL/9DJlfBdL46D6HxsE5gy2ikOmI74BhRGs1Z9IptQfYL/2NQG/XVuIYQ3cXQ9zjo8Ux5V/wrc08lcBvD4UhqsfzpqKYKn5AUrS6JCASBpSZb0IryBuUXwqpjULyCkZ3otD6g48rgPX6h9U/32f02SqMMWiy27pbMv5boERMWE7wfqayedErb8QfnLEElKgfmWlBcTFtgtNEAdzmNTQVtvlaO3bfpY+OJnFZ6l4ioUibpJlxs+VmdJbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/hGyGP2/L2G0EVeIsI+5xTok0JrNz+wx9KBwNt59nk=;
 b=Lgr0yjsCb5WTlT1KZqGnkctViZPSjQ3J/qFownpRm8PWWqEB4vzjlVmwT1aJDzgCF4xI3NfJ5wxlwcxIKONXmCugfs3YbqYop47CaQRCYJxYk+iWyZHN0A1WIWlyPWD1Z/vhRcbb7v7vZr4JGoL8A5e0BUG7TDJTX+ssqR2nj765BKd1VIfmK+lHs2ut1vSb9Uy/Icx/nzA3pPEfdXZxTYW7Hc9UxOGMJ33iAFZXIFrDDae9MW5pcHtzhnx6Sc9Ti/y8+fQMJ+w1DzGcFjQtmZ2ncWlBoqHCRxeoOOQLGDdZh2/Trwrug+2RM5CH4jFKBfBxLyRJ9nENTlZ3uDAjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/hGyGP2/L2G0EVeIsI+5xTok0JrNz+wx9KBwNt59nk=;
 b=LEHmjlsW4LD0bJ3JogIo1x9jLYsNyrB6hWV1+ij56SODmIwS5x4p14C9PYaAzdxzIpX53909+qkxFFLxieu25NrvXHaIeC96T3NKcf9Cn4k5xXQjZ881RJL+nrmvu39WoamEybuUZAj1LJ+lKIB5yMvzZE6Vu642b/sK5mXCKBZdGpxVIAqxv/sPeWj2LFVVQOXj5pLM5R/mz6t7NksbrrGqM1a1DQdhYl2oZ7CDZpwH0aj1oV1ps6VxxWN8axDEEKU85vE3fFP724T3jTd1kz1DyugIJB/33sDE50i0jkaR2vVf5nGJHE/TaM1uiLz19gaICgUSN5b2KHdge2gJJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Tue, 26 Sep
 2023 18:28:26 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::c470:9f69:8412:7414]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::c470:9f69:8412:7414%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 18:28:25 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] ipv4: Set offload_failed flag in fibmatch results
Date: Tue, 26 Sep 2023 14:27:30 -0400
Message-Id: <20230926182730.231208-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::36) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e954547-54af-4779-55b8-08dbbebe5f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	owDYOA9FsJvpFqHvqzrhmx72ZXwRJWIoADRH/W8w02s3GaJg+oT3UbLKK2HgM45N8nyoP6TaS2yEVgsFRWTxGT96nWSiwAuajpDNMsHl66c4Dg62UVgmynu/i6XintfZtl0CzHhoGHl1IvU+X8AvJumKJovoybbWz4B5fC0WFM2/9JmCNG/n5t8kaeEIczS8h1s58BeCwko+Nsla40FuDT9R9rmlAUTuqKK1q/Lfaa8jm3sPPRccCwR0A+7MEtMGHtksAYEAdcJWG4SkDReAWrvlo/3ECoIXWgYm+WJiJNeiGLL5NPbAaMFsLtQE/emoeIaIfyI1Lmv0vHned/Vl9Lp1qS0rHWaNZiVuNisSfEoOWFBHDV2QsSMf9T3JHejrhcgRWjeXM8VMU+rZYjd+vXNYibwgk/rDvXZKbb8OiIgWjJpV664Rsno1ge8HJ2+mK6YB09l5fNQ4e7OQSXMBpzz+QapOM1rDnfwkZ5oSzeq2JcBADtDbFV9YPIMw90jsfDfoUMZODrqJftzZw9wUuu2AguXJrbt2MMxC20meneNd6Yhel8SMj8c3bE4lxtte
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799009)(5660300002)(2616005)(8936002)(4326008)(8676002)(26005)(1076003)(107886003)(38100700002)(86362001)(36756003)(2906002)(6666004)(6512007)(6506007)(6486002)(41300700001)(66946007)(66556008)(6916009)(54906003)(66476007)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vpUq0STL0N1jKEk7m5/pip1PG/CZognEKhDcZcSEJnNIvGKp1JRY9ZNRCmLE?=
 =?us-ascii?Q?KP2xHyS8PC4gy2hm6MJvfuWC45bu9VEHTPxbYXMWa1Z/KLv7IELkVIZGISHI?=
 =?us-ascii?Q?iMbz3Q37qisVlwpPRFb/+ANFDQlr91a343Fw2S7z77hQ+u8xK1EMECZiGEKM?=
 =?us-ascii?Q?CtsovDYTMU3K5qMY/rCxS/RoML2Wdpr5xHvrYG/2iuipHkljeW1369wXN/SB?=
 =?us-ascii?Q?L5XXuFci2h+sZB06NJt+xQmASrtZBJjIdqavj2k6kWTXkU/SSzaI98OsmRlJ?=
 =?us-ascii?Q?D3h8vuaDzDn781udGxfTdMRqm3KSJm3dnKII7UntsCs/QWQf7Qorh9TR9Aj0?=
 =?us-ascii?Q?L1hYG4agEbrQdCzmMd4w8pHmB44KFxKjuKs+WsvU3Q29fo31tHIVZ9q6JHNC?=
 =?us-ascii?Q?6zANZmj5ytzK5TWx77a/LQDHLV6JeuaAFF4Wnb0StHxXx3IWYZWIhhRThoSy?=
 =?us-ascii?Q?DwxTBqU48Kj/9oB2hsynVgRKTvvPk9YyvJdpAQ1lg2NtBcn7ip34AXS7ia1V?=
 =?us-ascii?Q?tf8olLmtxj0cYIyrhZzEIxUvna88irhZGOP97iIKpsBlSt+SZTaQN54xoeIv?=
 =?us-ascii?Q?/U6mrqlR4Ky/tHQz78s+3eGD+xLsrm0tJw0XLFjeSfzDjpoXVHHnQOwTthEQ?=
 =?us-ascii?Q?l+PyQ74usmWKiSSHJif7IAUGG5xHYUXmmGyRVwNJRXgL+z59D9xmOHscLMsI?=
 =?us-ascii?Q?7kAwKX9JdT4w+tKjOhR7NIop2oGD0v+47oKFwDrlgFOPHODWCl8qe+MRJT61?=
 =?us-ascii?Q?VvSxlFAkqHAjxyk2ZgAKVMa291RGwnaw85bDGgYbld6A0GS73UQ4Z0BIwKw4?=
 =?us-ascii?Q?kpRVRj+a+84tFi7WcE8KYZvI6CzG/bo3rT3SSWIJ9pNXSoW8H4rqng1JyHF1?=
 =?us-ascii?Q?X9V5LESf7X6xCHLZrNtaUdP9YsO5jqdjhLHMi8NVlViEh5GuI7C7CMCc2Drr?=
 =?us-ascii?Q?1l2BJE20THt6ReUzWuu4G3IaarMlz0TqKHKv0ulO8IJT/qoXEZMvahVkbdRL?=
 =?us-ascii?Q?Af/8Ll0C7JKHb5U6XdWl5H78Q76KY6dLLUFK51LqSHDxtGxpPyxnF+kLbEyh?=
 =?us-ascii?Q?SePGLfRxqOjKPliCYRjhwuxvrL0kp+MAB5BYJviPKOaPB6DLGE7oEg1j8uPp?=
 =?us-ascii?Q?GUVCAa8vosO1qT9e/cF6Cu8QXXcrNvHIF/LxRpvTUtiOPbSi0gFXLSkm1Fik?=
 =?us-ascii?Q?QzoKxZU5vpPBqnJTn0hfLy5eImlhu9NRJG/q74JN/RgnFhhnMwMVC6Yj8auC?=
 =?us-ascii?Q?zA/KTBS0Caukj0xvz+wgeZBNeE8GDZkx1R8uhuEX4Tm7iovagEsuwFbqx2rn?=
 =?us-ascii?Q?93yHymVHSL+//YNBG2HXYpzbc1OUEi0eoz1xsU3ZR6PTJxEjkLVRpeq0icLV?=
 =?us-ascii?Q?PigUD4yIg+YX0wJrjg4lzlgnqeEancr6Lr9ckJDMmuN1AfMakE0j0UVrclRG?=
 =?us-ascii?Q?odpV7HLJBkLmSRldjGfaowl+eTwasd6pX3rVz1daCsbXZtGiRhBCPjFtv5ML?=
 =?us-ascii?Q?248vlMMfC9Npt2nAbRNOIZRnDttPtpYHfcN9xINmUFNwrE+o/qn1+ujY69QG?=
 =?us-ascii?Q?u8LxPao8irFpK1IMjxqviHiFu4ZFZwIbJOmCeh/q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e954547-54af-4779-55b8-08dbbebe5f5d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 18:28:25.7495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TS0SO4i0/etlc9s2965MamiVC/F7lp9HSrCCARWqjedD296maNd6L68sgrmpHAY9EnaPnJkfZu09hd7LSJ3R2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Due to a small omission, the offload_failed flag is missing from ipv4
fibmatch results. Make sure it is set correctly.

The issue can be witnessed using the following commands:
echo "1 1" > /sys/bus/netdevsim/new_device
ip link add dummy1 up type dummy
ip route add 192.0.2.0/24 dev dummy1
echo 1 > /sys/kernel/debug/netdevsim/netdevsim1/fib/fail_route_offload
ip route add 198.51.100.0/24 dev dummy1
ip route
	# 192.168.15.0/24 has rt_trap
	# 198.51.100.0/24 has rt_offload_failed
ip route get 192.168.15.1 fibmatch
	# Result has rt_trap
ip route get 198.51.100.1 fibmatch
	# Result differs from the route shown by `ip route`, it is missing
	# rt_offload_failed
ip link del dev dummy1
echo 1 > /sys/bus/netdevsim/del_device

Fixes: 36c5100e859d ("IPv4: Add "offload failed" indication to routes")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/route.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index a57062283219..b214b5a2e045 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3417,6 +3417,8 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 				    fa->fa_type == fri.type) {
 					fri.offload = READ_ONCE(fa->offload);
 					fri.trap = READ_ONCE(fa->trap);
+					fri.offload_failed =
+						READ_ONCE(fa->offload_failed);
 					break;
 				}
 			}
-- 
2.40.1


