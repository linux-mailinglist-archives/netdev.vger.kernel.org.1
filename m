Return-Path: <netdev+bounces-169039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE2EA4233D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BE83AB2AD
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92D19ADA6;
	Mon, 24 Feb 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o5Q4PGYr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7021D3C2
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407320; cv=fail; b=a8RFuEP/3AXEyNaKqrmP9BuRF5aBK3TiN+BHbYZG/ubwpwTjebkxtfosszQbxKS7P32ibohGDqmHJ8DnC7+/YTlZ5u0x6uty+n+UYYsFYXokVZcnscv+yNjnBdfp2J/7HaSyciVI1nz+HVR3Q1qn/AJJwk0Cyy6PK3OpqhCRtrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407320; c=relaxed/simple;
	bh=6fIVFanTiZBCeOYb4cMM8zb7BwNazElRX+G5ZuzE98c=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oGY9gllb9HC3J23U+MoWWVuFkQz5RgTa+Rv12heUimYM2OoeaJAASye0HdbzkUctCj0unF+AOutdwI75+AzgWA7fOB3w+Kb4/piuom+bsQ73xEgj1UeMy7FiGNPcU6vuJ7fObx8XDUk5lTPVBZIEWjWXnR0wb51OBgh4RfEJg4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o5Q4PGYr; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFrCuOJ9Ve3TisYzsBUf+NH7XTNaau8BspGKPmxCGWeLTpNkDUv2+wdoZsRZDp3cBXRReySCd1hA2g7BUy4hWV/R+nBi+GUIfk6XzPZznfDF43LwdH+dYBf09B7Nj818l8dx2iObalxA8LAdIeZinF1T55D/M7u/w19dISJBvLegTAxHohaswQzoOCtVq4VCk86cNsbIPrCaxvZ1+UmrLWIMWNpl9bjQ44y94PX0ArLVxy9VE2Ky48xSY/yGVOUqyGBlPBXhcvp5y/bn4dOc0wABCfsFCnEKEBZVjMXUPgzhL4tNuECC16bYtSibWjl3DXyjDlirAnTxYexVC32qFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2YjuRG7YgX976eX5pCQjLn0Z5qLsKTiMo+cOU0TcLc=;
 b=quiMeYq0bU6ERapLDaq58LHq3BYV9+U7oLnYBMl/UdBxhxFjW3X+yEAeH3IdGPUpiLnU3IJQ768IltyQqHc7MD/nWY8bEmFE+YP4p5yyY1M77W5NsJNuBCr8xOW2EfrIxszgfFa8JHFS7AXWSoE5fYLCo/SoruR9nZXQBcQE3FsP5LKZvBRTt/BeOq4ufckpqcf/jDsD+rI1n08G+sU/1+kKLCt9sgBb8TOG0Wax/PcPxHf5xyERJ1PI2cNum3Fim546J/N1f3+4UaDRVfjcxgYyTBumQ/OmLfULagN2DFVkruZCcX4akZWWC7CaBZPeUNXmOxHZMNr0JiHu8wZS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2YjuRG7YgX976eX5pCQjLn0Z5qLsKTiMo+cOU0TcLc=;
 b=o5Q4PGYrY4DwBmaYqzeCfWW6gJQaDZfekrTlu8sp0aFMA4RHyXXlNkLQ+F0wZLKM7oBvs1V/UakTxCBl+MYsl3YOD+dJkJAKVjJE+EmiiNl9lTSh+lxqLrmoz1ZOvniNqFlq31gfp6a3g6H8IKcHjC5hiP9cAOjc8PyFHn/RWlPgP8zxZOKJaMbaMAVLcCNpYipOVyY6DOu+HZzx5kr/8t9pG31Cb1OsVQ7JQWbIN+4c/SzXemqDozlFsT3VRCAjg4jDkh9UIHMv2AS5xodEVLzLRXY1ZGOnYJCQCFWY8mMvRozAXLGIt0wONzHzQfA87P4cyBvrwV3HDhyjjiS6jg==
Received: from SJ0PR05CA0130.namprd05.prod.outlook.com (2603:10b6:a03:33d::15)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 14:28:29 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::f8) by SJ0PR05CA0130.outlook.office365.com
 (2603:10b6:a03:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 14:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 14:28:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 06:28:05 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 06:28:02 -0800
References: <20250224065241.236141-1-idosch@nvidia.com>
 <20250224065241.236141-5-idosch@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<dsahern@gmail.com>, <gnault@redhat.com>, <petrm@nvidia.com>
Subject: Re: [PATCH iproute2-next 4/5] iprule: Add port mask support
Date: Mon, 24 Feb 2025 15:03:25 +0100
In-Reply-To: <20250224065241.236141-5-idosch@nvidia.com>
Message-ID: <87o6yrju35.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c5f36b-fce7-4da8-8de5-08dd54df821c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/FqV3JsYEYtw4vghk0bLy5vaKqQ77QQEErSP2HC4RSLST0AY5Ia+Yo40s6t?=
 =?us-ascii?Q?WxRnMSOkWYS6xSFhuJytHM+vUXU/IP1ba+oU56iB/DV/VjLk1KEEgLP6sfJ3?=
 =?us-ascii?Q?PsbDahNN954MF7taFm8HW8LH/aTIIPP1DJZFgnrpyofoBfVBph2DZQorJ3gN?=
 =?us-ascii?Q?q26IuUOryTqXaVH0A3PoM3EwzSpeck7MhpMOxRQ0HTTug4kvjMtvGnYTQj1Y?=
 =?us-ascii?Q?Ypaa6DrwxCIA0vNbXBtMPCQlhUf2zVOUNm6b+5JaWHuMwCVUoRWlfO2r2/tQ?=
 =?us-ascii?Q?4EUVqEr6MkUwmkljvGHDT9wHntM9nxjBA9aF2eiB9IZ+IeBY51ubkbAuGzxq?=
 =?us-ascii?Q?wOYqccb/8sTXGz+F6asRHKfc4r0y8rEy7k0cUdOGE/JeM9DkYgnife2bd4iA?=
 =?us-ascii?Q?Ra5y/RR3zfVLHRK9S6mWFdFIV5EFtuF+Gc9AapTbPuwcfhxSh2u3NMgUujyS?=
 =?us-ascii?Q?rh41u2RHQNDpufXTGPIdbxlvLdYhVU9h567mEoPjcT08K0IQJHxACL2zcZ6w?=
 =?us-ascii?Q?/dlqJ0MRK5g4J4BVC/h7PVn3VGpJ9cS/rHnpoMlDZj1cRNORpLkkUTL5yqYn?=
 =?us-ascii?Q?W+XY8k1r1cK5fKm/If7WjJnd4K2VQE4jdg0eurCx1LBbz84LxEMxzIkLBz9g?=
 =?us-ascii?Q?vLuE3JHU3woLa27h8wpeSBP+pyRiaiEWp18w54a9G/Bgd32IRb2rYvAFC4+r?=
 =?us-ascii?Q?SQoZYNdwfxpcs4I7Ueg4YyT58fZev4jNU38lFXLdrVrXFLES408wH4dmB0v5?=
 =?us-ascii?Q?NfL108GCwfjLrkm+oGQFWXXY4nhaeTZNky2Gg9NUh4v3ck6N1PJTsdEg6SYS?=
 =?us-ascii?Q?ewgV2hKKD5Mo6USUR2yK2n6Au3eMN8NfykKTrNp2oS/aI4DJsgo9OVSPwVNR?=
 =?us-ascii?Q?0kQiBFo/4oYJS+lf8oTXJ782znMpSjWSjN9ou4HxMhVAwMqDz1O8VJF0w9mv?=
 =?us-ascii?Q?VWQyo5a7GOTUG3hdgnZQJ4e69uKerVN2JcrC0WApOb+o0pzP64E2CQPqg+/1?=
 =?us-ascii?Q?P5xGh/jSqmSLMcNrEqpAdv9Lx2Wg8cts51iYxhpyjubjxeUC8/nNVrenvk7F?=
 =?us-ascii?Q?fGZlXsYXFajwqUpwGkxfvbc6nlqayBVExBIE/7qhrISw18iWLZvBpbFp102f?=
 =?us-ascii?Q?LUybZcvgMQDoEtWF8Ts+p3uWGGu5Hta1ZxyjZyd2TM3cSys3jD1LWY/R+r1R?=
 =?us-ascii?Q?jqttlXmXIj/sm8boatPd0hbIblWH3h9CKp8xe15nLx7B+aLijpOqtgtMZiki?=
 =?us-ascii?Q?wHDfdzLLoSZrH7OEQwFgHhoeNHJfq/+ig4aU9OXapISx/t/hRei6FEtQEsJK?=
 =?us-ascii?Q?5XJmO2nleg8pmatk+uaneRzw12/RyxjX45SC0XujhYi2YLLYbo0yFoCUktD3?=
 =?us-ascii?Q?zo1irEH8MQgRXXpOUND8kWkggj1RQe1SWoZR/JTUwrE0cFbzobsgbqF1NWSH?=
 =?us-ascii?Q?n017VuG0phs/rYW10I0d1N30PbyMqYTveBQniznHlUB8xZDTd3m9Cybk9vB+?=
 =?us-ascii?Q?ePlp6rYHhdwFkVk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:28:29.2890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c5f36b-fce7-4da8-8de5-08dd54df821c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600


Ido Schimmel <idosch@nvidia.com> writes:

> Add port mask support, allowing users to specify a source or destination
> port with an optional mask. Example:
>
>  # ip rule add sport 80 table 100
>  # ip rule add sport 90/0xffff table 200
>  # ip rule add dport 1000-2000 table 300
>  # ip rule add sport 0x123/0xfff table 400
>  # ip rule add dport 0x4/0xff table 500
>  # ip rule add dport 0x8/0xf table 600
>  # ip rule del dport 0x8/0xf table 600
>
> In non-JSON output, the mask is not printed in case of exact match:
>
>  $ ip rule show
>  0:      from all lookup local
>  32761:  from all dport 0x4/0xff lookup 500
>  32762:  from all sport 0x123/0xfff lookup 400
>  32763:  from all dport 1000-2000 lookup 300
>  32764:  from all sport 90 lookup 200
>  32765:  from all sport 80 lookup 100
>  32766:  from all lookup main
>  32767:  from all lookup default
>
> Dump can be filtered by port value and mask:
>
>  $ ip rule show sport 80
>  32765:  from all sport 80 lookup 100
>  $ ip rule show sport 90
>  32764:  from all sport 90 lookup 200
>  $ ip rule show sport 0x123/0x0fff
>  32762:  from all sport 0x123/0xfff lookup 400
>  $ ip rule show dport 4/0xff
>  32761:  from all dport 0x4/0xff lookup 500
>
> In JSON output, the port mask is printed as an hexadecimal string to be
> consistent with other masks. The port value is printed as an integer in
> order not to break existing scripts:
>
>  $ ip -j -p rule show sport 0x123/0xfff table 400
>  [ {
>          "priority": 32762,
>          "src": "all",
>          "sport": 291,
>          "sport_mask": "0xfff",
>          "table": "400"
>      } ]
>
> The mask attribute is only sent to the kernel in case of inexact match
> so that iproute2 will continue working with kernels that do not support
> the attribute.
>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Two minor suggestions and a couple notes to self below. Looks OK overall.

> ---
>  ip/iprule.c           | 103 +++++++++++++++++++++++++++++++++++++-----
>  man/man8/ip-rule.8.in |  14 +++---
>  2 files changed, 100 insertions(+), 17 deletions(-)
>
> diff --git a/ip/iprule.c b/ip/iprule.c
> index 64d389bebb76..fbe69a3b6293 100644
> --- a/ip/iprule.c
> +++ b/ip/iprule.c
> @@ -23,6 +23,8 @@
>  #include "ip_common.h"
>  #include "json_print.h"
>  
> +#define PORT_MAX_MASK 0xFFFF
> +
>  enum list_action {
>  	IPRULE_LIST,
>  	IPRULE_FLUSH,
> @@ -44,8 +46,8 @@ static void usage(void)
>  		"            [ iif STRING ] [ oif STRING ] [ pref NUMBER ] [ l3mdev ]\n"
>  		"            [ uidrange NUMBER-NUMBER ]\n"
>  		"            [ ipproto PROTOCOL ]\n"
> -		"            [ sport [ NUMBER | NUMBER-NUMBER ]\n"
> -		"            [ dport [ NUMBER | NUMBER-NUMBER ] ]\n"
> +		"            [ sport [ NUMBER[/MASK] | NUMBER-NUMBER ]\n"
> +		"            [ dport [ NUMBER[/MASK] | NUMBER-NUMBER ] ]\n"
>  		"            [ dscp DSCP ] [ flowlabel FLOWLABEL[/MASK] ]\n"
>  		"ACTION := [ table TABLE_ID ]\n"
>  		"          [ protocol PROTO ]\n"
> @@ -80,6 +82,7 @@ static struct
>  	int protocolmask;
>  	struct fib_rule_port_range sport;
>  	struct fib_rule_port_range dport;
> +	__u16 sport_mask, dport_mask;
>  	__u8 ipproto;
>  } filter;
>  
> @@ -186,8 +189,9 @@ static bool filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
>  			return false;
>  	}
>  
> -	if (filter.sport.start) {
> +	if (filter.sport_mask) {

OK, sport_mask now implies sport.start because of the changes in
iprule_port_parse().

>  		const struct fib_rule_port_range *r;
> +		__u16 sport_mask = PORT_MAX_MASK;
>  
>  		if (!tb[FRA_SPORT_RANGE])
>  			return false;
> @@ -196,10 +200,16 @@ static bool filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
>  		if (r->start != filter.sport.start ||
>  		    r->end != filter.sport.end)
>  			return false;
> +
> +		if (tb[FRA_SPORT_MASK])
> +			sport_mask = rta_getattr_u16(tb[FRA_SPORT_MASK]);
> +		if (filter.sport_mask != sport_mask)
> +			return false;
>  	}
>  
> -	if (filter.dport.start) {
> +	if (filter.dport_mask) {
>  		const struct fib_rule_port_range *r;
> +		__u16 dport_mask = PORT_MAX_MASK;
>  
>  		if (!tb[FRA_DPORT_RANGE])
>  			return false;
> @@ -208,6 +218,11 @@ static bool filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
>  		if (r->start != filter.dport.start ||
>  		    r->end != filter.dport.end)
>  			return false;
> +
> +		if (tb[FRA_DPORT_MASK])
> +			dport_mask = rta_getattr_u16(tb[FRA_DPORT_MASK]);
> +		if (filter.dport_mask != dport_mask)
> +			return false;
>  	}
>  
>  	if (filter.tun_id) {
> @@ -390,7 +405,26 @@ int print_rule(struct nlmsghdr *n, void *arg)
>  		struct fib_rule_port_range *r = RTA_DATA(tb[FRA_SPORT_RANGE]);
>  
>  		if (r->start == r->end) {
> -			print_uint(PRINT_ANY, "sport", " sport %u", r->start);
> +			if (tb[FRA_SPORT_MASK]) {
> +				__u16 mask;
> +
> +				mask = rta_getattr_u16(tb[FRA_SPORT_MASK]);
> +				print_uint(PRINT_JSON, "sport", NULL, r->start);
> +				print_0xhex(PRINT_JSON, "sport_mask", NULL,
> +					    mask);
> +				if (mask == PORT_MAX_MASK) {
> +					print_uint(PRINT_FP, NULL, " sport %u",
> +						   r->start);
> +				} else {
> +					print_0xhex(PRINT_FP, NULL,
> +						    " sport %#x", r->start);

Looks good, for JSON we always emit as uint, for FP we emit uint in
backward-compatible scenarios.

> +					print_0xhex(PRINT_FP, NULL, "/%#x",
> +						    mask);
> +				}
> +			} else {
> +				print_uint(PRINT_ANY, "sport", " sport %u",
> +					   r->start);

Hm, yeah, and on an old kernel we don't even get the mask in JSON.
Makes sense.

> +			}
>  		} else {
>  			print_uint(PRINT_ANY, "sport_start", " sport %u",
>  				   r->start);
> @@ -402,7 +436,26 @@ int print_rule(struct nlmsghdr *n, void *arg)
>  		struct fib_rule_port_range *r = RTA_DATA(tb[FRA_DPORT_RANGE]);
>  
>  		if (r->start == r->end) {
> -			print_uint(PRINT_ANY, "dport", " dport %u", r->start);
> +			if (tb[FRA_DPORT_MASK]) {
> +				__u16 mask;
> +
> +				mask = rta_getattr_u16(tb[FRA_DPORT_MASK]);
> +				print_uint(PRINT_JSON, "dport", NULL, r->start);
> +				print_0xhex(PRINT_JSON, "dport_mask", NULL,
> +					    mask);
> +				if (mask == 0xFFFF) {
> +					print_uint(PRINT_FP, NULL, " dport %u",
> +						   r->start);
> +				} else {
> +					print_0xhex(PRINT_FP, NULL,
> +						    " dport %#x", r->start);
> +					print_0xhex(PRINT_FP, NULL, "/%#x",
> +						    mask);
> +				}
> +			} else {
> +				print_uint(PRINT_ANY, "dport", " dport %u",
> +					   r->start);
> +			}
>  		} else {
>  			print_uint(PRINT_ANY, "dport_start", " dport %u",
>  				   r->start);
> @@ -600,10 +653,13 @@ static int flush_rule(struct nlmsghdr *n, void *arg)
>  	return 0;
>  }
>  
> -static void iprule_port_parse(char *arg, struct fib_rule_port_range *r)
> +static void iprule_port_parse(char *arg, struct fib_rule_port_range *r,
> +			      __u16 *mask)
>  {
>  	char *sep;
>  
> +	*mask = PORT_MAX_MASK;
> +
>  	sep = strchr(arg, '-');
>  	if (sep) {
>  		*sep = '\0';
> @@ -617,6 +673,21 @@ static void iprule_port_parse(char *arg, struct fib_rule_port_range *r)
>  		return;
>  	}
>  
> +	sep = strchr(arg, '/');
> +	if (sep) {
> +		*sep = '\0';
> +
> +		if (get_u16(&r->start, arg, 0))
> +			invarg("invalid port", arg);
> +
> +		r->end = r->start;
> +
> +		if (get_u16(mask, sep + 1, 0))
> +			invarg("invalid mask", sep + 1);
> +
> +		return;
> +	}
> +
>  	if (get_u16(&r->start, arg, 0))
>  		invarg("invalid port", arg);
>  

I think this duplicates the port number parsing unnecessarily. How
about:

+	sep = strchr(arg, '/');
+	if (sep) {
+		*sep = '\0';
+		if (get_u16(mask, sep + 1, 0))
+			invarg("invalid mask", sep + 1);
+	}
+
 	if (get_u16(&r->start, arg, 0))
 		invarg("invalid port", arg);

> @@ -770,10 +841,12 @@ static int iprule_list_flush_or_save(int argc, char **argv, int action)
>  			filter.ipproto = ipproto;
>  		} else if (strcmp(*argv, "sport") == 0) {
>  			NEXT_ARG();
> -			iprule_port_parse(*argv, &filter.sport);
> +			iprule_port_parse(*argv, &filter.sport,
> +					  &filter.sport_mask);
>  		} else if (strcmp(*argv, "dport") == 0) {
>  			NEXT_ARG();
> -			iprule_port_parse(*argv, &filter.dport);
> +			iprule_port_parse(*argv, &filter.dport,
> +					  &filter.dport_mask);
>  		} else if (strcmp(*argv, "dscp") == 0) {
>  			__u32 dscp;
>  
> @@ -1043,18 +1116,26 @@ static int iprule_modify(int cmd, int argc, char **argv)
>  			addattr8(&req.n, sizeof(req), FRA_IP_PROTO, ipproto);
>  		} else if (strcmp(*argv, "sport") == 0) {
>  			struct fib_rule_port_range r;
> +			__u16 sport_mask;
>  
>  			NEXT_ARG();
> -			iprule_port_parse(*argv, &r);
> +			iprule_port_parse(*argv, &r, &sport_mask);
>  			addattr_l(&req.n, sizeof(req), FRA_SPORT_RANGE, &r,
>  				  sizeof(r));
> +			if (sport_mask != PORT_MAX_MASK)
> +				addattr16(&req.n, sizeof(req), FRA_SPORT_MASK,
> +					  sport_mask);
>  		} else if (strcmp(*argv, "dport") == 0) {
>  			struct fib_rule_port_range r;
> +			__u16 dport_mask;
>  
>  			NEXT_ARG();
> -			iprule_port_parse(*argv, &r);
> +			iprule_port_parse(*argv, &r, &dport_mask);
>  			addattr_l(&req.n, sizeof(req), FRA_DPORT_RANGE, &r,
>  				  sizeof(r));
> +			if (dport_mask != PORT_MAX_MASK)
> +				addattr16(&req.n, sizeof(req), FRA_DPORT_MASK,
> +					  dport_mask);
>  		} else if (strcmp(*argv, "dscp") == 0) {
>  			__u32 dscp;
>  
> diff --git a/man/man8/ip-rule.8.in b/man/man8/ip-rule.8.in
> index 6fc741d4f470..4945ccd55076 100644
> --- a/man/man8/ip-rule.8.in
> +++ b/man/man8/ip-rule.8.in
> @@ -52,10 +52,10 @@ ip-rule \- routing policy database management
>  .B ipproto
>  .IR PROTOCOL " ] [ "
>  .BR sport " [ "
> -.IR NUMBER " | "
> +.IR NUMBER\fR[\fB/\fIMASK "] | "
>  .IR NUMBER "-" NUMBER " ] ] [ "
>  .BR dport " [ "
> -.IR NUMBER " | "
> +.IR NUMBER\fR[\fB/\fIMASK "] | "
>  .IR NUMBER "-" NUMBER " ] ] [ "
>  .B  tun_id
>  .IR TUN_ID " ] [ "
> @@ -270,12 +270,14 @@ value to match.
>  select the ip protocol value to match.
>  
>  .TP
> -.BI sport " NUMBER | NUMBER-NUMBER"
> -select the source port value to match. supports port range.
> +.BI sport " NUMBER\fR[\fB/\fIMASK\fR] | NUMBER-NUMBER"
> +select the source port value to match with an optional mask. supports port
> +range.

s/supports/Supports/. And below.

>  
>  .TP
> -.BI dport " NUMBER | NUMBER-NUMBER"
> -select the destination port value to match. supports port range.
> +.BI dport " NUMBER\fR[\fB/\fIMASK\fR] | NUMBER-NUMBER"
> +select the destination port value to match with an optional mask. supports port
> +range.
>  
>  .TP
>  .BI priority " PREFERENCE"


