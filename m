Return-Path: <netdev+bounces-60409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E0981F19C
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 20:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B5E1F2205B
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 19:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705A347761;
	Wed, 27 Dec 2023 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eWTpoQm4"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DF47762
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktecspzbTpnYZziRL7z4O867b9JDhnxfo+L6H6b1b1pveXiDQLhIFzvP+TiLDszY3UXHztDcaUb7DWuA/ZvUqoPe7d2ZkqfsD0hdCEzu2PP/q37yg6iS27sjBoMiuv/SjIe78KFxUoUE0J+wbxq2lX0MhP9tpGYAxuZJRECNv6Rxg/YZgRN8Fg4uBi0TouRMPhtQbNl29Vet0El/lAw4rzqlLVM++8jvBnlXNUF5kPPrKNwb6QtISk9tFFCY0e+bset8/g1qdc/WKwJP2eiCA2U4XFdeStvUi97CIAkFVuHSEKSYWBtb95EW2PqJmDCKUF7OaJ3TmFChat0qkuTVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7G/Zm5rc5/GKXhhWgP/xbVxRGcvVDBxO36y4RsSuKAU=;
 b=jct6ZAVN5awgtWsHOtFl38IurJmbs5uhhMJI17WKTj4Sq7giq4siWAEBOhu0vrXhXvx8gPuwjvWAlY1XwP3N+cbGDR7Z+KFCt8AcFRQHU4GOIW5btmjmKHhNeU1HTiwMvmZysujA/nmxCTDExiOgkNqzVFcxG7FOazD79ldDIoWa8Gvk7s0w0Bu8oRxcl8leQN/1nOFuY3HKvadtbsmtmQVXRFDIM9I/M2vTtKF901i+1jZ7hdMcOJPHbaQGYeE3sp7D9pDh6ZnGk+Zh8iHHP/S6Ssm1dhSIuYJ1NBDShGRsIulD7kfMQUP0ueos098EJH2aV8Y3936e+nojvuoBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G/Zm5rc5/GKXhhWgP/xbVxRGcvVDBxO36y4RsSuKAU=;
 b=eWTpoQm44XnWLMSNCjy2atJCd9FpC+AeIb/jsVoFdGNYQl1+289xOTj0YM2JvugRbefumkOin7nlOuYzOJTB+R45FwtBoFtIcJwy/WU5tnKyicmf3px5prEtOv8A9zARNpWvJb/LOmEM6G8EFuOhXBjtBYzmOZh9yIodvWsMb14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8571.eurprd04.prod.outlook.com (2603:10a6:20b:436::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 19:28:01 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 19:28:01 +0000
Date: Wed, 27 Dec 2023 21:27:58 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [RFC PATCH net-next 04/10] selftests: forwarding: Simplify
 forwarding.config import logic
Message-ID: <20231227192758.iq3s4mirkf2dm5mj@skbuf>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-5-bpoirier@nvidia.com>
 <20231222135836.992841-5-bpoirier@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222135836.992841-5-bpoirier@nvidia.com>
 <20231222135836.992841-5-bpoirier@nvidia.com>
X-ClientProxiedBy: VI1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::47) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c7e5dc-3ee4-4eef-f564-08dc0711f07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P1yxzyK4sLK7wR+U/yZSwT5KkXvAXFSnPSvnMytcc9rPfWcvL2aJ8l/B51MCrqEXdWyBikqsaLLpgRdWpsWEVtfkah2VC9eDV5KcDyUdaGv620aB9ryz2wkiXxEDKFEAUQ5Wj7zFTp8KbC04WXwdkpLglGCZd3roKWRStNPxZH/vn2+mFS2eLxNXhbxrOhUrsQ0MirFPVCV1VQifCZJLB8AtAXNjfXQsRc8fiXWP1LKK3OuZE+kAGUKQnEiozK3YS9Iqjgea2Dc7qeSrpK2LNdBnptbrt5IWjRBGWnq4DyWYFyZHH8GKq2jfDOiUO4FHEuXxMuwCknl/q5i+3xQd5um1fUKQQeo+4hGX+yLtOlmqxCzeu2KMzfExzOCpTjHRtEML4Vla1WzfdLuXZzegLSqrhiY4iQa3rZi+/EBNT4AGVAQwME1rc/gRghunngZMqZj97Vp35UhUfvhyUGIxNXP78dDIlBLxeNoxFPHuDADYNSzf/a7tuk4nAlFZbHx11WBr7pkGBPndY5MKmjUFxbSLncrdjI7TgiQakVJhEqsJmixCM4ecJn7qshg3p3bcJYwEXVdHVpLx19ahbP6tHI+XJN0U6mqIYL+dU7Y7z0s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(346002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(478600001)(38100700002)(26005)(1076003)(41300700001)(6486002)(86362001)(33716001)(66556008)(316002)(54906003)(66476007)(66946007)(6512007)(6916009)(6666004)(9686003)(8676002)(44832011)(4326008)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BLYM3wJ0/f39N08Z81qXCk/fd6OIt9uSUOSbwaF0UyV9/VwvS7WPtFpVjX+d?=
 =?us-ascii?Q?P6pSSowtlQ8Jfn/2AwINsD0CF1QSupLgJQ4UbQhMTPa6HOw0hwNFtit1Fu2j?=
 =?us-ascii?Q?gYBbRZEHTMhMBPGANAAQ9vr5sc+8p0A+yKDn4ji2hsXtYKrG9nmv5v8bqoVB?=
 =?us-ascii?Q?2SXBhNdBRpN2KjqVAYrtosNuTzrtB6GrNBoNWFt0uRVUImKIqPomesLWQIdj?=
 =?us-ascii?Q?XSGn54k9+45UGHMpK7rUJ2WM2GS4zCuTQ/FtuWHk6RP+kB4qQ5Fj5GqNJzG8?=
 =?us-ascii?Q?A1V8ffkijnAxPEWCGfxKbVrCUYxSPgeRy+U1UmVGFWvQoyIxFrUM6/yTaPx4?=
 =?us-ascii?Q?VyFHR3AEgwD4wwmWa8mdMvu19e6JTbyOqnc/nbxxLO1uKoc1oCb8GPUrpp8r?=
 =?us-ascii?Q?KSnieZbv4TQkZwVlHHCwoaS70ci0n7+rQmji3S50n164ka23B4JDTTVZsFRL?=
 =?us-ascii?Q?U5I5bJn9Ffahs+jfDU2jXqSN2WvXGE8zTOasm+Yjzvodwr7EhwpMo7rd/4Zv?=
 =?us-ascii?Q?1wnxK42JfJBlCITw/z4RxfrSgAPEokwuHd4eZ3gSoPuYpL5CEYwOrMpiFstO?=
 =?us-ascii?Q?ZF5LXs7xEcs+3crpXEBZ93MrRmHzzt3wBEpgWEgzXTY43BeJfrD+lS6xk6B9?=
 =?us-ascii?Q?K0gd9aaGZemSQs2yY5ljLNHgoErIJxmJXRbBlKJQ3SaYBJfzFjOGAe1wSqnx?=
 =?us-ascii?Q?12ecZciJNgtnoVzify39GFJLa3+h8f19xx7JHhNVs0+D3aIqWLK7w7jf1kIK?=
 =?us-ascii?Q?PhXEiI6eI+B7OoGQZtYra2GXZMq4XYzZuhJFvWDsns1AI6GXC4iUmLtsQkeq?=
 =?us-ascii?Q?EP7GFbtnlJDoJzy0IsevuyDMdXIVaMwae10kD4gToXk1DSak81f98sIUHdjv?=
 =?us-ascii?Q?3HV/5GOLTxvwyIor6H18LplO4eboZwndcI9KH5mrE7jFGQqXzxZbCTK0+PxA?=
 =?us-ascii?Q?F19aSih9tJZ8J1g9eQIDmnSoAk8maHEPuIL60dd3K2E6/tEwpHNM1dHcgvyt?=
 =?us-ascii?Q?RfisS3Z9j3itznBf0ZUI3V1yn8fYWGg1UJxECzRyBeG7WlS86t9Jw1ym7lca?=
 =?us-ascii?Q?CFKqxj2k2+oVZ6I2vaA5iz8y7qQkTHvdDzbMYBdmVWFGQe0N5Irx6LKvSf4E?=
 =?us-ascii?Q?iUI4V5eiNKYcBN50S9HyWQN+/Zt/iluFR4at79zsQMnBCEWp210Ro3P/uWFO?=
 =?us-ascii?Q?3qcZ/AJ9vFmwrxcmUtbq9e/phDHO9exysiKKP6371rrU+JopbJr+P4pg8uqH?=
 =?us-ascii?Q?tNpPFeFl1zcmjTIau9eUClqqUglenImiJnKVRgBlW3xoz82rad/AClqH0LA4?=
 =?us-ascii?Q?CGnV4bRAzcOS6ft/kEwAVAOEatGpxzVPdf93TDyyg5j/J1EBNW13Q2yRkCXG?=
 =?us-ascii?Q?525y0hmrrN/9Y69M1ejEegLhP54z89E4G6cIuTdG7hj5AEfBc7QMaZu/9DaD?=
 =?us-ascii?Q?lSaC5Pt0+peiDBuUwVuO5pr88FKcgAPJAUvCxwmw6PDH82sYEaoEnuqQuLVJ?=
 =?us-ascii?Q?7GxWA7M7JeKlOZ3ZrgeKCpgtF9sBI6t6iyl1mWQsT5egdo+H9SfS0Ey6v8nF?=
 =?us-ascii?Q?eMekIdKP/4alYJ0aoqg8nND8BrH5VN3ToYlwE+elfLOZO82LtBeMtzKX6ihW?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c7e5dc-3ee4-4eef-f564-08dc0711f07c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 19:28:01.1567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejWLH7YCcZB8nBSJ4o+JxQEn0AM/+PUI6PcxSNMLM/4tVxSWTVm7QwgABsd3EO4xa/XUtwPhdMO+cnTqo3Y4tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8571

On Fri, Dec 22, 2023 at 08:58:30AM -0500, Benjamin Poirier wrote:
> The first condition removed by this patch reimplements functionality that
> is part of `dirname`:
> $ dirname ""
> .
> 
> Use the libdir variable introduced in the previous patch to import
> forwarding.config without duplicating functionality.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index f9e32152f23d..481d9b655a40 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -29,16 +29,12 @@ STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
>  TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
>  TROUTE6=${TROUTE6:=traceroute6}
>  
> -relative_path="${BASH_SOURCE%/*}"
> -if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
> -	relative_path="."
> -fi
> -
> -if [[ -f $relative_path/forwarding.config ]]; then
> -	source "$relative_path/forwarding.config"
> -fi
> -
>  libdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
> +
> +if [ -f "$libdir"/forwarding.config ]; then
> +       source "$libdir"/forwarding.config

Nitpick: this used to be indented with tabs, not spaces. Also, any
reason why only "$libdir" is quoted and not the full path, as before?
Otherwise:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

> +fi
> +
>  source "$libdir"/../lib.sh
>  
>  ##############################################################################
> -- 
> 2.43.0
>

