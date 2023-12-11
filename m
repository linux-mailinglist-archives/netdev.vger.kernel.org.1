Return-Path: <netdev+bounces-55918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C17C80CD95
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D528E281D52
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A49748CD8;
	Mon, 11 Dec 2023 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4OU8TbS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B803C33
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjDeJ17lIV8ej2D9hSlu8EoBEDSkuhdiyAIs7R7I9GbBqwAQwqHGy3r4iZFDqjZIz01NRbIk/29SQKNOiHeD6u7jRx+TUgDiwBEnQqd+FQDwAdf/W88yTvUSQzKJiHFWoZ8iGu+ArRdTvxp2ufm+EEHfEraYBON08SqkdJDeTQ7EOo2s9BIM3YkybxKzSiWdwIlbpyhOHV5rfxC9BXHWVzGYFXsFqPUxilAVZU08ZrCtIsG0Nclo9lYyq1yOZINDFiigcsSwII68lBcc2CbSBohyAk1ZHaLTOOZO/nEsMIBdudH0Ay4S3tyAb6dXD1G2rer+XRUHk7LrbykbeBSjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj2hadTYtWINkR+AsDGSoZ0RNbRtYHHCKLO6YrOkUfI=;
 b=Qu0a3iias9nF1OZqXn2Nin7kGVxrCi1Hg4yKiUABbOtrNwvKRJW6SPGKwJXPx4LnFYcNoyJpsvriNewGkaojTWMcDpBJ9qB/VqM4VvIpjh7WfoHwHe9aCyVHeCNhOaVQRVMQRzvHr+8axmn1zfowlhcT3mc1B8Oy2Qf8rczoUS7OKw26l1AP3EpWtdg9tBKHmvLkF3pB3dE5JGrdKx/nxlMotzXDA916nMuYVcCiCoZUPHuvn8TPfEgbgOeItZ21JbaWwPSo0ZlU8gEErSYukS0mecORFhZO3T0owyYba+D1qh994zlQvnqnCcZ6a8UKhLIKjIJMHN/sqtfPlsVySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bj2hadTYtWINkR+AsDGSoZ0RNbRtYHHCKLO6YrOkUfI=;
 b=f4OU8TbStef03i4qOsR2U8QoeEgk9ok9U9yUKuNpGVZV+Gv2aoOq/qCTJKGcezwx1xlPYEpOOedMuqqhOLTB1tsTH/Vm/eHnzcrf6P/X+I7foBFbJf7y6DYs8UmzMRZmmOgF41BmL/vu+dukAWoC5PRU6MOEhka+po4gNKqXnek3Et+WumRliG/PUUoE8kHUhQ53Z0n/pSTUJBVrRc6sGqRY3Ef1nRhQNkY4B/6pmu4pd+Hs2c7horh68nM1BOEBumg/MXeUBDt6pyO0zNhTUB3mc1I01S++PxXc1vHDA+Mho/xiE0I8h3YnhIPEHTe7kNHYTWPApyDzmtI4uBuNOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:07:54 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:07:54 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 03/20] bridge: vni: Fix duplicate group and remote error messages
Date: Mon, 11 Dec 2023 09:07:15 -0500
Message-ID: <20231211140732.11475-4-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::21) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d0f304-e90b-47f8-6346-08dbfa5291f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qs+msj9au6r4RWwymMicH728qeySKj4Ln0CUadMVbF6HTQA9ZS732B6Fcw80bMn4H7pv2nYm+nD++ZghxtsGWBxzX8ngISwF1LaN0AMW/1WQ+7Wks3qB2R8WrqkG29J+TrCWWLn1+5WR5+yBuAy/gK7i7spPf78pi+RC1MOJZCeUNONz+QHq8SmSMPBgy2a3L97ZlxBfXhFuly0MhfVyRwPpqayHQO/kv78njlz5MoW8dmGOox61lTQJYIu3lsgu3eVel91eBCxCgFwCRpdDHG+6gH+EoCoa3jOIZqAFAqOIeTX56mjMoF6RtOjcX+qjoeqcKXOkBoYZ3dbDHSE8ogVQCPNHeJx0r/59eH0h5bHHTT7s5H8oJXgfzhAapv4O8cQoMHcsq7GlH7QSakklBXWN7wOiHepCMTsHcG71hwaNmzjyYhkL7l05+vSVYcBmj6kvBAQmogX70TdyJ6yk/8aOFSij5rf7N7dGsK2HqtxBb+lKZ3Igk04CKuMJtl+1Pahcghpn/uwNSL3KpC2hdnjpHtYVWoctJSTZ6MkuGtTbPSYdpTAodyF/ZfQgyPFv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(15650500001)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQznP7Omv8Em2yNo+O/2WYa7u5qYUK6kl9Uz/EVpR01TnKdeiu+Gz4rwnNLD?=
 =?us-ascii?Q?/+1f+dPTeZoVN0McZq4MrJL81W1b+kHtoVd04k7rGgq1lUD1sfOsBun57Mql?=
 =?us-ascii?Q?EBuEp8wDwdrh+YZB+h88MPbZZYIpxo8vPaEwCtxBi1uxBn5ic56v2zVlCPNn?=
 =?us-ascii?Q?YDoBKr5w1cBQqE+9DI+z5cJkGRlD8D/g4KIzROrAlrrMGBIev1enINYS1cZT?=
 =?us-ascii?Q?4fgGWd0l1ftefsqiyuXRVKf2JTDPy/0nIkOIW224i4bLCcIQLd3cFRkWQ83Z?=
 =?us-ascii?Q?Nk4CBRB/R8oj8yHvJlF98gmi+hiD5NAKn/OU/Tik6hAEsK1ag9LY3xa+6Ven?=
 =?us-ascii?Q?DJ+F2ZAAzdN/axMp3ALVru3muQ+I3PbWJ4LukQB65KeTpycxGc+tqiIPE1BP?=
 =?us-ascii?Q?iqpn3Lai8PGgadZ7/DkdXSX//dQF4/w75SKPFvrSycAfLpTCMjaeegDjh47F?=
 =?us-ascii?Q?XGW8ze7JLyMf0YaX9TBow2lAj7cnAkeoBhyEPwOEPrlazVcSckKkwBOXies4?=
 =?us-ascii?Q?RFp8ONl1W3tq2C9bi3Cdm6/tb0KKiNxrMCHMNHDgKtrJG71yd9RzgSkfZ6vB?=
 =?us-ascii?Q?0SFG5CpQuRLAtUwXeBAlQL7znc07xriOeBQ12piiBrrwUwyVMW8FVb93AJ8f?=
 =?us-ascii?Q?JZhrq+3Ymm4RJP06MF2VOD6nT28UqXU59Y0r9QvOEHH1W/u8DylOwhQzaMdU?=
 =?us-ascii?Q?Kk22VC9JoTM0f5QSbt2v+gGNmDr95xKrAlJjM4VuMJQSxghAxOB2WZf2s4CE?=
 =?us-ascii?Q?CqVGUT9CK/1U4+WSnxgtm7rkoo3gRyBLmvwZZFtfAeqm+R+M9RRdZI/RPaVV?=
 =?us-ascii?Q?nuPKe4v/7VxtP/HwKAlG5UfdnltQD9yUB1VS0AtD2NXA1ioW0XI/sy/iP/cX?=
 =?us-ascii?Q?dnLn/Kiu4ga4SgW0sxH0lScNDBV7aBVedlNzo1UBKt88Refvg7b46bIC6DnB?=
 =?us-ascii?Q?c6HC6tE8cOSUig4Ys1elvXDPiX2ptVrULegb3sR4rVuo568MwpxUhMtfb48Y?=
 =?us-ascii?Q?djjT8lE49cmDiXLKDIj2Q6oV+EHfo+IRnMuEqLZfQo8xDEtPk7RMT4ehsLy/?=
 =?us-ascii?Q?f/QvSdcIy5IOQUCDa/F+D+em9Z7NZ7FfS/EsliZ9oNP+xq+v4ICrfnt68el2?=
 =?us-ascii?Q?CdYKGkEoxnkhIqsNpx/mVghRpTbZ6fgxcTyGUNYv3rE64pZ6I2f6Q9kJN57/?=
 =?us-ascii?Q?bsU93QNCfJD1zuDRK2aRca1IJoaFi+6qyhLAgk0DdOLLduvRnCJM+T19myCC?=
 =?us-ascii?Q?hhyuBgljZvxiOxK/shd5KVh9oZyBpNKHpgsBgFuiq5K7IK9U3k5FiYU5oiZF?=
 =?us-ascii?Q?ud2J498l9h0jR/5q2txEw/0uuHBGPsC48dU0ooRHzLyeZy13C55eEhob25XT?=
 =?us-ascii?Q?8vrtpbTQ3cnIYLTQIdZbapu1DQocZqvWqgmoA94xNJ3M677hKX6iz50to/zu?=
 =?us-ascii?Q?VHJV97/OPF4/pfS48h2dECGS/qwr3S+6XyDMPe/5r8U9lw6tm+tKGiMyCxQC?=
 =?us-ascii?Q?dFzcsrNAq3cf3oK/TUI8quqNZM+0pW+dKDVPh+rCx+edRDzodWMCWp3XTFfH?=
 =?us-ascii?Q?FYgI1EzxiMN2H5x6N6VjYfMsLqIBWtIStQkv6dL4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d0f304-e90b-47f8-6346-08dbfa5291f6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:07:54.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/w1rCI+GqvhsR/gAm5hVvfIoX8jHFLaVvAumf3z/kQ/uZodPh117qsKcKeTHq77eT3xxfFs1Qdca2QEeMkv6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

Consider the following command with a duplicated "remote" argument:
$ bridge vni add vni 150 remote 10.0.0.1 remote 10.0.0.2 dev vxlan2
Error: argument "remote" is wrong: duplicate group

The error message is misleading because there is no "group" argument. Both
of the "group" and "remote" options specify a destination address and are
mutually exclusive so change the variable name and error messages
accordingly.

The result is:
$ ./bridge/bridge vni add vni 150 remote 10.0.0.1 remote 10.0.0.2 dev vxlan2
Error: duplicate "destination": "10.0.0.2" is the second value.

Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index 33e50d18..56def2f7 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -92,7 +92,7 @@ static int vni_modify(int cmd, int argc, char **argv)
 		.n.nlmsg_type = cmd,
 		.tmsg.family = PF_BRIDGE,
 	};
-	bool group_present = false;
+	bool daddr_present = false;
 	inet_prefix daddr;
 	char *vni = NULL;
 	char *d = NULL;
@@ -107,19 +107,19 @@ static int vni_modify(int cmd, int argc, char **argv)
 				invarg("duplicate vni", *argv);
 			vni = *argv;
 		} else if (strcmp(*argv, "group") == 0) {
-			if (group_present)
-				invarg("duplicate group", *argv);
 			NEXT_ARG();
+			if (daddr_present)
+				duparg("destination", *argv);
 			get_addr(&daddr, *argv, AF_UNSPEC);
 			if (!is_addrtype_inet_multi(&daddr))
 				invarg("invalid group address", *argv);
-			group_present = true;
+			daddr_present = true;
 		} else if (strcmp(*argv, "remote") == 0) {
-			if (group_present)
-				invarg("duplicate group", *argv);
 			NEXT_ARG();
+			if (daddr_present)
+				duparg("destination", *argv);
 			get_addr(&daddr, *argv, AF_UNSPEC);
-			group_present = true;
+			daddr_present = true;
 		} else {
 			if (strcmp(*argv, "help") == 0)
 				usage();
@@ -133,7 +133,7 @@ static int vni_modify(int cmd, int argc, char **argv)
 	}
 
 	parse_vni_filter(vni, &req.n, sizeof(req),
-			 (group_present ? &daddr : NULL));
+			 (daddr_present ? &daddr : NULL));
 
 	req.tmsg.ifindex = ll_name_to_index(d);
 	if (req.tmsg.ifindex == 0) {
-- 
2.43.0


