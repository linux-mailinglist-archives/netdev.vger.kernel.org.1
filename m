Return-Path: <netdev+bounces-158918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8049A13C88
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FD4188C356
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB522B59C;
	Thu, 16 Jan 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aog15/yh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283724A7C9
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038570; cv=fail; b=GXx0OZBsZFW7oK3kNVMc+MO5PSSkLzPAf0sUHn7h3pmdVLrkU4WdTtlzWD09dyNXljbbDaVyHoE6NpR2nMi5kQ3gdVsGjlbbfY/xDPH0xWoBmU10lceTkllTQf+drLBM68wF9zs0k2JGAQTSO2mQPdhuW1MqmJTzUSy1+9Ar8W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038570; c=relaxed/simple;
	bh=PUYdo4PjRL0gRGvlVdyzuY666Vm0BQ6qf5D+2j5PJpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X+/QBuyu6K0AQw5mGi4I0ZBEJT46mGhbyWMa159r8vVju8jyhlf+V6oOB2ZyIgSfAOtPxzvhFkjcPp5D/F5tzK0t5I+DmEj07usbdaRxdeE0uQAVQztiakyrE4Ty3wYbMoia5xBt2ysx1KY5+ADhOsu9N4zI1v/3JKp2QFg2C7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aog15/yh; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SB7U1XdWXMLnpEaRSbISONb7ov8UL17Pes1EYMHMg0yxa0gMnLynzDeqUWA/rLv/ulAYAwISFOFrnqIXAIDs3wsogU84N1IlLartGdcZ2/971/83jTxSGKMygLmW51bSopW/+675VQTm15lwM905U/yTvpIZstSaCjdJi6lJT2CyOEnPt2R6Gq9EP15QU6B/f4aVJS9AKVpPTYq+EdtFtuF81iWo/X4Ya8NPMZiyw/ErLmPBIiYd8prZBuM9+I/srShIE1asRVGOWl9cz5rFyYzQSbhmPpPVkzURlj8SWevo3JT8jO1J/q74+bjxVbQ/gHEWLBhu25ngELFMvDW/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX4vFM7BN6PnSzuLswa398Stys3qcz/o4dh+UyTIOWw=;
 b=tLtejQq1db1gQE6qcn6UsVBzsW2W5DhRaz6apW7HnheWahT75KiMdiposVo2DVTg5pfNA5+wKVDaVADChZHwghHYd1tOEZRFjxf7J2EnlqMej8bH9cYCTfojRcZjv4r7Q/OlwMWxpELY2sCYBnMgfYHGg1T6iSr0QpEAV0OoDSYVsZv4/aDZWtjCRA3On0qrj2uCi1aj77fE4jAtp/uSGVXF9NjBW6XOq4rONFyiohUi4DkHhnMrfDp/8c+ZOJ0KR0DFKiOhgt5tlbld5o5XZV+KWCxb+iXHWr0HvfFeQB4xf+7I1K6j81pmg8WdUy8k1jUXn46OX+JSCaeHgfr2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX4vFM7BN6PnSzuLswa398Stys3qcz/o4dh+UyTIOWw=;
 b=aog15/yhaCBPI7fWIK+D7yeMKyUNrBJR9Qjqd66C+4gXmilRQkwfACq0CJsOeGgWV5Jjj83SWXUbwutgVAfF5e9uiX54khZxtKYwT0W6dqXoWnoUVloNM9D7OHBGcnCfjmFE+Hlfgtliw83hzN4EKGaobDncqs4tkbir9Kfw0YQ7TuM+m12aq1JFfMIK7EfBPCIZnukVHBihVPGLMnsgUP7axa+mlibpRTbq4Ey2yfPvdI0Y3cq9ncU3r7AbqRfF9ghlcMx54iQ/dBxVJL1PfqVW63V6SMZnaVPYRb04EAYfykcVqprC0fojFidnL/ncIQHp8/gDQqpB/PncyVFnHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 14:42:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 14:42:45 +0000
Date: Thu, 16 Jan 2025 16:42:34 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next v2] gtp: Prepare ip4_route_output_gtp() to
 .flowi4_tos conversion.
Message-ID: <Z4ka2viAY1h9zxIi@shredder>
References: <06bdb310a075355ff059cd32da2efc29a63981c9.1737034675.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06bdb310a075355ff059cd32da2efc29a63981c9.1737034675.git.gnault@redhat.com>
X-ClientProxiedBy: FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e64965a-91c2-45a5-2dae-08dd363c09fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2qQdNJI7zmlRP2Ne3K0+I4UmaxeYrm1KuSIL8CNOcf2ZuxrcrCM+Lfp1vD+B?=
 =?us-ascii?Q?GhQ/e1K5KAIrT502Rp2XJ5axqvKO1D7iNu8WsF0dFZnwvoDKuCpuzDNP1ozP?=
 =?us-ascii?Q?tEY0Lr+3LXhIxplF0BrgcPxVc8lILoYfgDfq5i50kT4OmhsNAz8Q1OX7BsFv?=
 =?us-ascii?Q?HmKt1ElB0UrI7CxLWIwcUwktt3bReT905nIGoKMpoyFWQO0BP9EyVjH8htmR?=
 =?us-ascii?Q?zHeiVIaTOQUIrS+YEEPbEFOqaSlvqGEtmT0+jMhz+KKdZ2oXpx9Ie+ToXsVP?=
 =?us-ascii?Q?A/lju/bWNTY07ycUi8usDDlh/v6Pah65wAcI7UUIUiFRPLQDFPl6LhPb76Gl?=
 =?us-ascii?Q?frsKCLEgMuU4ksTa/juYErq8wWWM2cI/4wTTo+xwguPS3XNqjcr+8xLcX74H?=
 =?us-ascii?Q?XGTeBwKOZxOLxMXxlptKPvH2qG8v1ZA5B8FcuZrZNws69WsHZOoEtqePdCs3?=
 =?us-ascii?Q?pIXoUA/V58c+Gg81+Ij41sfPZL72gebOhCL9fpk5UbTJJjCloFY3sauAv/qt?=
 =?us-ascii?Q?9eB+oJhwZwlvg3KUqjF7bSh8KaH/ZstEZ1/I1htoI5ygKaKzfPOEZc88Yp/M?=
 =?us-ascii?Q?GWCERhO6CRsn7cB2sriXF1QmIVQBK7rQ+c5qNNnxR6RgMgLSqc8FsrONcDVI?=
 =?us-ascii?Q?v9DCw8AJdYYL6Ffpf/LKkBFMLYTmAI5MNZDtv5eYHcYEcQgTp0VW1M+YlGUe?=
 =?us-ascii?Q?AAO2eDmYSTEhUnjf450M88/i2Ybku9tLDgXX31e7tBxavep3rOu+LkLSVvYa?=
 =?us-ascii?Q?70IchCKykUapAOhkRywS+dspJgwWNILMts6BGl6VItapujVYG4Nk5wzYFws8?=
 =?us-ascii?Q?2RdW1LChs6Kp6L1961kSpcM9uYVk+ODQa8uJnLloq5H+Rqb7MYfDvRKgWlti?=
 =?us-ascii?Q?SgXDJgmkG3GE63gLMpJeZXh6IX8HbZa4KqZdfCd6Wyr6x3PpUBtUInWIZxhv?=
 =?us-ascii?Q?N3vOyz5OeuIEl4ZhNVcluR8EZfQKDHx0eG/Wb5vxMtXGUvMOVYZWgMBf39ha?=
 =?us-ascii?Q?jljv+LLEnv9vXpKz9t9AmUtvG45fYobpLIBi3sX1L8RF1wAOIdyXfywSS0hn?=
 =?us-ascii?Q?15JbuBUo8iUae6Oc3w/3vdJkT0UPdJVBCZEOxQsCRNyPO9Egw/9N1fjbtnON?=
 =?us-ascii?Q?STkQ/xgzWypt/NXWPoBaeBEag7Q3jfhVGeuYD2ce9Rs3HRIytUFw2wexAL8b?=
 =?us-ascii?Q?D/0Q/aSyCGg41JxtvCKLVP4YfQAEhkvcLWI5ahqFzbOC/91VapknsmVGgPqp?=
 =?us-ascii?Q?wV1eHYT8imt+blYWGk5dY7DZ6NJuS48FndjBC1deLepZGbN2OqRABc+6vUNI?=
 =?us-ascii?Q?m5SmEVwyHMNHUvrmYDrIQQbbBtaq6JDzgi5mh7mP5KMKCAmfkxrrnx7p1D1d?=
 =?us-ascii?Q?1Nj/iCIkf5AcSYh8iXsfjtdvgRdw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1MX0vY/KdeYds5yVDAnlb5WsDrCjkN676YoB9CVMfkWuqQksj1l/kVmQSf91?=
 =?us-ascii?Q?nAGl8+lXWKh4Ndb2QIoNuRJaBx1dFr0pCkpYyY4qef4BfnWYhE7nl80B8txN?=
 =?us-ascii?Q?s7p6MYmrnQeJP3SdYh83v/kFEc4Ad8AEABZTdXXvYlCwmUC0xkBKt4h53DV+?=
 =?us-ascii?Q?qV4hP7fH10GvI4cglv2FniL/FnyQPFfviL/9gwLwVxNGu4ZgFFQEScloakM3?=
 =?us-ascii?Q?QhjdOd4zhQhHI6OLCBS+MfZZnQ73ni4OA/tCOs1x6UGN6IXO7FDGtdR8pQZp?=
 =?us-ascii?Q?9YqBJIbDVykhkswIr+r5/vlP3dnjdoW+5EWdZ2qyjtvd2wNDhPRmi+5S64L3?=
 =?us-ascii?Q?n0M3hscwOkIoSv+YmizK3Iw/BAcTwciHp1XrYtgOsIidmC0NLsfEGVYR0eOf?=
 =?us-ascii?Q?idxJk+sNMMURvUfwP9uVSbNGnY/vAQw5iZndku6tSw9nF4/cMBzu4YDLdWNy?=
 =?us-ascii?Q?sFrraOi9sOehiCDkhhrin4rJ0quajZ2iORelX9s8f3ry7MkhOVTC20ib5/Sg?=
 =?us-ascii?Q?vQIa7bp3nDnSLT4H+ZSkPpWG0SAKTxakWGM3FpGFJfqGyYMwc/LW5DgNU7mb?=
 =?us-ascii?Q?727lsSwItqKTAc5PCczgqZeJ214vXFhP/aY714irTWNl/M0ch1/76gme/SBA?=
 =?us-ascii?Q?boPyMIAjoaU8IpI6YfLY7VYIC+1/AWrfVF3yA9Gagj2xeIlB+kidJKio4py3?=
 =?us-ascii?Q?95JEyy4+5F43o+Oaz44t2ejJNMY++ICgM9kBBp0SXnfQR9NHmZ41VAVEs6AQ?=
 =?us-ascii?Q?tFQvJgk/9Dp4DvekFXqDo7KYjVLdAKR41yKRf9RzOMGXTqPwYSZJI7NxL1z3?=
 =?us-ascii?Q?vtl/gK2iiR3cbN6yO8abJeksAOtEOPbwkputuQ5s49arTO0xCY79My+G7uTI?=
 =?us-ascii?Q?NxnhQPsJUljD6kySuK0R89XbD5V0DjQ7TjcwWlZN0JcmmnL7t7b/+cd2rbfb?=
 =?us-ascii?Q?ul3tSXStZLdo/MZOeUsSpqMBaJS9PRAeWfy/P/fk5Zu3q35Y8/k+KhpjjtgB?=
 =?us-ascii?Q?+aXXhEY0kC30ZAPvhO38/JswRcgDX/D5+E8ii5G9Zs8kcLoSmV+Awrqn02YX?=
 =?us-ascii?Q?eqNgVCkDIKT93G0D8UBYWR+8C/9DxhCZ6pQtKHaxCodh8YwotJSolQhAZKrz?=
 =?us-ascii?Q?PKJjBv5+Jd1ODZSTImWRqrdsd0LTyHesJhU7YOVOI4FYBvNbAuBH+j1C/ZOM?=
 =?us-ascii?Q?Phwdcv1A5as5rxUalXXq9Y0J/muEnCsobOK+PJBzeGpBHLQz9V6wxgS5iZEC?=
 =?us-ascii?Q?VIGqsvDkFDxNH1asrbJrpBWWY6nX9szUHK3lX54OYt3IaFNMOqjuhIrGJBtA?=
 =?us-ascii?Q?GaHPs4+HIPwGXZp7rze1srGE7D6yAzk8Y0s9z34X1g1DSRuyx15NU1daiiCB?=
 =?us-ascii?Q?+zK1yWrDBJLUgOWm4aPBk0OOiF2hZPmZFuF91Uc+IDM1IqccvxKPuCXJY19R?=
 =?us-ascii?Q?VdGBiMWUbVPHuhBaAPFXpqUAM0eIQEf0W6EYTdbwDrMJQfq0/kXYUKXj0ZnV?=
 =?us-ascii?Q?RqAPP2+ip7Wp2bSSaDQdD7gqEWbvwqtylnB/V2+TJP0fc0+DjTVuLN/IJhWi?=
 =?us-ascii?Q?KXKjEaxoRbtw6vhRTxiauczcWVmWuHi/td/kVxmM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e64965a-91c2-45a5-2dae-08dd363c09fd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:42:45.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pe0d+ESbitaDG3ZF/6oOxjHDnAILNJHWuzCqsbWfpf69US9tzpzt+ZmES17gFSTeAW54P7o2cSP2RjxCg3WAcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943

On Thu, Jan 16, 2025 at 02:39:38PM +0100, Guillaume Nault wrote:
> Use inet_sk_dscp() to get the socket DSCP value as dscp_t, instead of
> ip_sock_rt_tos() which returns a __u8. This will ease the conversion
> of fl4->flowi4_tos to dscp_t, which now just becomes a matter of
> dropping the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

