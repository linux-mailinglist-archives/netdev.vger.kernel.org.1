Return-Path: <netdev+bounces-17293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23973751191
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35122819F1
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2703C24182;
	Wed, 12 Jul 2023 19:58:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FCA24177
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:58:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2112.outbound.protection.outlook.com [40.107.93.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33B21FE3
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 12:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjcNRccFulhniuDWWkiJqxXXgKtXK/JQrpS11KWC1dQnVS3DmdX+5xa/WvpxkmLlwGQYzPb3tFWZ+QNfhQzWA7K1nxOkSbJ6sluomsaoZe3itHHA26YkChjXcomzCrp7EnSnvCgybg3FtOiL7ScrnKDzdqVUzU4tN8omTBV2jANeiTQzegGZw2ZVFlj7Mmxb/Eg6b0XVZOdUX6tOfCaqwaGuMCgjQjb6C/rNxw2WjVfwdikHv7qSaTAHP4hNSJuxChO/w8W/Gig47NjDu46dK24A/Q9nsHrPWaGU/ffykT7RxocyfzSC/lhD1TaGBV2NGXDZoHSp4f8ywZKfYYEp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+krYklu0K8NpXlB9zGFgUJ5wNS3EBevPnzN05asIy4=;
 b=G1QkKcpsvgoXUbpMdcyexL76dj+RK0mQyx3UkheV4lDaBIX5gFHxl3OVbB+ScIgHnWw6rYclVTrolTFF36nP862udsTAgn0FzE1gNhmqZcCQoFVGXlgMA/8Vk/6y2ydi7Al2GHpoyjR2AJKNiz90XuWB55qno4V6/kD2e9dz4doK9EndxXyoPshUk5//5NLR/LCA9CnZKp+a3k4LFW1aj8CPRUuzAnN75rum0q+RAPqDt/Rmsmwkaga41kVHE+LYTYPFYTDG0F85ZmBuxQes0MCKj9JJudYZo3au9ShAcgknpEREa1sE8MGWXRrQ6ZKr3EIhd3N0reQqVddfilcLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+krYklu0K8NpXlB9zGFgUJ5wNS3EBevPnzN05asIy4=;
 b=Vr4QeEelDDoLecqWxWgiM1ZdR66TgtybJlPa6EMuuEVUVsCKm/6Wj3FfiGgHDYBXox4jedpkc6z8p9IfkaPU+8VJlCXSCz0RrdFvYBPzER/wroao0Wl/w5IwrJ4TEZ5SFsEQ8A6+7vwXMhMEDFV/wEMcN53NWdXiMw8VX5V7kdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB4127.namprd13.prod.outlook.com (2603:10b6:806:94::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 19:58:11 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 19:58:11 +0000
Date: Wed, 12 Jul 2023 20:58:05 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
	petrm@nvidia.com, lukasz.czapnik@intel.com
Subject: Re: [PATCH iproute2] f_flower: Treat port 0 as valid
Message-ID: <ZK8FzXDVPPp4JNMq@corigine.com>
References: <20230711065903.3671956-1-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711065903.3671956-1-idosch@nvidia.com>
X-ClientProxiedBy: LO2P265CA0469.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::25) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb3fcf7-b132-4074-15e4-08db83125236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OKVy7PASGgNOrhWC7FX8TrwpUHouILForWDqZTnlOD91QNaDdRTkycBYhDiIYSCPVzlvKix9rz4XRLIiUcw4QY+xc3u5VNsVDs7lpmEqKBINPzG1c4kNEATkXMbajO0tjoI54edE1NWuyYKNaXNmrtm0gTuSsyxhFf5ojY+VOZp1BqZLEPF1tWBYewC87zo10IKrFaXAaMVHuqV9Ucy18KvxvhtbqcEbWOShpJ6tO+b6OJN0E9Kv8DijLLay87QgsSCEoO2MwmBc9J5TPAAcC7QQmSONdXFVJiP3bVyMQ9GjSLht0YxUfYOguh5qguD8qsOCejZtUMNHgp5d5deKv6wP3CXFYUIHTPIePYi3HCb51WLDihc2IBqTThZXQluX3go9HtdLWFuVcVeCc7k0kPmpqC5mYjwD820l7zi8CgoGMPXcUNM5JjK6yBq2rrP01WML6rxPQOFmDoKpV4XDW/onw6JCm8dLZePCuKGn+u4588gtBTAf/mgg0fszM9oZMMd1I3mEEWr0CFHk52fyg6I8a6eSmSvPl2Vvm2lwIEII+5KYbZu8/GJPDCMMrKrCEbnd8kp+5DUhRTpLenr4UtHXd++1459YjAsaQnWeM24=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(39840400004)(346002)(396003)(451199021)(41300700001)(8676002)(8936002)(5660300002)(6916009)(44832011)(4326008)(66556008)(66476007)(66946007)(2906002)(316002)(478600001)(6666004)(6486002)(6512007)(6506007)(26005)(186003)(36756003)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eAdLpPZ/FcxPZ7XtK6RzT5gRFvIEnAafipXzj4F4jZIs/xLGzD1XvE0PUNgl?=
 =?us-ascii?Q?ii8P/ayCxmax13b6u/ryMVSX4TKny8l9WwuVmDMDC+sc+GUo47JoT7RP+KJF?=
 =?us-ascii?Q?flAFkok+foWejOSaemjZBexAONFwfcJ0rr/Ibymaab9GXnrggP6FiXDgnYzu?=
 =?us-ascii?Q?LXnN9rs0O2dAF1COjPWj0Ndl8bmSibYn3z41dO0MViCmgXdhdp4ThNwlWIqp?=
 =?us-ascii?Q?sPHqGh6vLKcT3FLquphAFMXzxmt6ierUjh3OWZZl+5ZeeZBc3/yjiz+vhi70?=
 =?us-ascii?Q?uIrOdoEQ25Qz0bcaX+dH9qt+eSn5FcqZQdokZqigSFBJyWhgdkJ2Inq4moO/?=
 =?us-ascii?Q?qJi40DHNaR27tk2VC5Z8GCHM6bRRxca4SOE9ERad9dlQnTri6MQ3v5tsEGVn?=
 =?us-ascii?Q?k+m9HVl2AcmoUEP6xLizWSQBpWKKRvjUDZMDR3wftsi21/VcQ0V9i0wsn4fg?=
 =?us-ascii?Q?zQW4ZgX0dClBg2jcdWoiUxQ+McsDUEcNlyIWL3WudvK6Wic6wufz964+omqv?=
 =?us-ascii?Q?lZCvuXR3jZELaGOadxXfAiDYjjUCdyI7Dyao8+eLbqBlGyGE46T0ACLmt3EB?=
 =?us-ascii?Q?t8XEIfd1lWOQVELu/oBq7dxhf9nkjJsa/cqBWkJNwvgNL1vf9Oij9Cpt9obL?=
 =?us-ascii?Q?1S4GGCiqaPjgJMF04eby/AV+Is2TOjl1GnRC9jcYC1cuvUkluhsahME/F2d0?=
 =?us-ascii?Q?qAb+64aMhVU+LsckGEtBVFDKEes8zJIClPb3IH8LUwhT/P/m3Z2Vtw1OYdjZ?=
 =?us-ascii?Q?/WIGfhCDrAB7HefC86kDhKYmYYd+HNJ3Qtr7zqFk0YsJaP9IRN40R22gp6Ou?=
 =?us-ascii?Q?XWm8OFiZMGBsy575489b0DAo9+lapFiKOP6dAvCZiHclBuUZNlZ6y9bKoJPB?=
 =?us-ascii?Q?ojEAhqyxmXB0J0u36YNlzYdzy1EI3Q5L+k7Us8yN8cSV0SU4F9ZnrLf54yBd?=
 =?us-ascii?Q?LJ6XzLSmjn1g3Zuys82jq+KJykQNLIt+bwvOPrZAYcsWhFZI2tLVN6TQYM24?=
 =?us-ascii?Q?7TvCa8XIwnYRaiPpnIf/ansbSMS1TkxWcj2PYEeivS99TAvBIWf2reZnHzwE?=
 =?us-ascii?Q?6EI+N1cLvzzYCOaZD01nLr3DYXGBhIi8JGE6MTi4bI5EdQfobg4jhvQ8f5/Z?=
 =?us-ascii?Q?CK3hoXJ3m5U9h7rXN5fKC4PuQPzvuhBDjwAc7Cn7iAj9M7OQiQFXnqIgwFEn?=
 =?us-ascii?Q?q1U+hfF094y/q7Kx6ir+hq5i54GlehX/PSFYIp/TNz4TzOSKEBTqqsZ+feMt?=
 =?us-ascii?Q?XBQLvaX9/tUDM4nFxBZEJ1evf/gXBoNX29PKF+Y3IunDqo5SVSo4XjsOR2LA?=
 =?us-ascii?Q?tkQOrdhaizSKkVWdJQxoqRMZIHFDXCsDYrKlwp+r2aQUJMmaf2ApiRavOU1E?=
 =?us-ascii?Q?VbIMiUSA7FpHYIZzXRGEByqk9PVZUdC6ngTtNeb3b3hG1qEY5ZwsofjlhiOi?=
 =?us-ascii?Q?2BgP6B6EDCR1n2ZZqhyoysqYQb/I0B6Ry8l5yjklkoXc7n87P80fBcvkabJU?=
 =?us-ascii?Q?/dQH8IV8hfxB+cBIv5TM5csGvExfIG6FmAHHxLwcaMkhp2IizHmI7Hb2m5W9?=
 =?us-ascii?Q?RQ3pC44zKG+4wSCs3GAesOiIVc7uEB8d4Hvj6j4CTQJHlIAwri7KPXRlFzFH?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb3fcf7-b132-4074-15e4-08db83125236
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 19:58:11.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWCjkK/Oc51sBwyFW9H+Eotv9jb3CaOUyMiScigxJeiqHQ8/zSKrQfJtZ4hwmU6fxWvknsciKMoeMJkRnMQYq3zmAvvneFZQ2n9Y9PcMCzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4127
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 09:59:03AM +0300, Ido Schimmel wrote:
> It is not currently possible to add a filter matching on port 0 despite
> it being a valid port number. This is caused by cited commit which
> treats a value of 0 as an indication that the port was not specified.
> 
> Instead of inferring that a port range was specified by checking that both
> the minimum and the maximum ports are non-zero, simply add a boolean
> argument to parse_range() and set it after parsing a port range.
> 
> Before:
> 
>  # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp src_port 0 action pass
>  Illegal "src_port"
> 
>  # tc filter add dev swp1 ingress pref 2 proto ip flower ip_proto udp dst_port 0 action pass
>  Illegal "dst_port"
> 
>  # tc filter add dev swp1 ingress pref 3 proto ip flower ip_proto udp src_port 0-100 action pass
>  Illegal "src_port"
> 
>  # tc filter add dev swp1 ingress pref 4 proto ip flower ip_proto udp dst_port 0-100 action pass
>  Illegal "dst_port"
> 
> After:
> 
>  # tc filter add dev swp1 ingress pref 1 proto ip flower ip_proto udp src_port 0 action pass
> 
>  # tc filter add dev swp1 ingress pref 2 proto ip flower ip_proto udp dst_port 0 action pass
> 
>  # tc filter add dev swp1 ingress pref 3 proto ip flower ip_proto udp src_port 0-100 action pass
> 
>  # tc filter add dev swp1 ingress pref 4 proto ip flower ip_proto udp dst_port 0-100 action pass
> 
>  # tc filter show dev swp1 ingress | grep _port
>    src_port 0
>    dst_port 0
>    src_port 0-100
>    dst_port 0-100
> 
> Fixes: 767b6fd620dd ("tc: flower: fix port value truncation")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


