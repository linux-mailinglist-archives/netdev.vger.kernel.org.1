Return-Path: <netdev+bounces-277995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIbMFBKu3GnfVAkAu9opvQ
	(envelope-from <netdev+bounces-277995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:49:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB04C3E954D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDC933019BA7
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7F73ACF14;
	Mon, 13 Apr 2026 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e/MnEHHH"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B50386440;
	Mon, 13 Apr 2026 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070089; cv=fail; b=C0mfLmjl/rvb81ilsukBJCMCnGsz8nOA9OFxlWKUaqduRHyY61zL27MES3uMKDVa0j9pZC8yAlEEJzFMRDk6G14i8RD7JIub2kQujaxIDtaqh51kCUPYpooAQRbdVsQ84IZIKUT5r/73rJG06y+52E0EZU/ZHcYkGLOVJCJWfoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070089; c=relaxed/simple;
	bh=2MtuL7iNbII40/R1p0M6GJ9lTNiBWZ5It4dtScWpfqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IrI3gNVp6DB6afgz3Z4hBgJuMO/oXB4l7dtDrrER6hT7InprlEf/Wj5Z5Us++SKvXTBgX/y8hbUAGq90Lm31wb5dKhhr1exyGmhsFGL1HIy0D2gJYpYxqIeOZb52dJWpYL3F0QvIrz+ViSYd/eCjisJuCnO6/rc9dKQ728ZKn9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e/MnEHHH; arc=fail smtp.client-ip=40.107.208.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYCrjd0Exc9NT4LJLfUZehgHNUXxq1CkaISelOy8FgPIEbzImA9vpwtGOG+jvyWi7jrcxRDsv5xv1PxpRARKEoxVKeWMFT7SgikIRWlXBllzDLd9fD0/xAL6c2BSboTpG0epaqS5bMdo5Br5KLlAAwqxXfbSpU+c9oMqfTLoKchYWIq0dXQoddsjKwteMSmmLN9UXuGX5K8REPZVZDRkuhFwqS4ubrO7ktwoML267ggvzhfhCesWRVYML3T5iil+j3NPw14kT6YEPdtFdxm6OHQnuHPctwPA0DwcJwBBbyNHsud/qcWWp1NEdKqC5s1oKvK+NxXFaDS9DvtJnbsztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whR4cMeZW9c2fIpHIfjxjJQixPJQl7W/sqUOCjZ7Xc0=;
 b=nbGiTyUfpUxyBL2lDTKN2YnX1SJWetBk7vQGsinfPyWdB3vpCfUMW457d6ejmPQvB3z9/yo+0dyIIMtJskXwwQULdsQMmmLFkZraOdSoZyK1v+q45aqM0MYhfRfcfQfVE2a43tSTs6MAror5bvS4+TRiTgvydy/A2PdVkwWJ3psfsy8EcpwFW1Kw4MWIPl2NHypdTSPkOXfKHMlZQhMak6M+Xhqg46PsoQYZ68Bf1RVmJGx7ZTxRYSlSOyzf/ow8P71YNsW8lvBIHuleSJLWCw3dHXlNQ4rrZoNMbETUMLKbn1XIJ3SKyvHySNQ5w0Q6h0bqSABWfT4BpdBrvulH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whR4cMeZW9c2fIpHIfjxjJQixPJQl7W/sqUOCjZ7Xc0=;
 b=e/MnEHHHsH60LefK7CAgQBjUAN38Av+D/8sDnLhT57y+X6GKFWrlz0wLSH4yaSX3/rEpSJF8ZQFN2IfRd0z9mKodsHag6KTnTarQLmJ0e7UZzEypxOD3MzhTNz6Tr3igqmr9SinNcnw3y0T+RdBgaSE9D1PItKOvoL8SLdP9MnrtlCG3qjfqv1wld6sOewZJQBjNpCRRqHLfUfvg4hTSt8H7vG187lZqeLC9F4jJmAAeaP6CA8SdTOOUOKHGyfY0fBucrH9GziwBqwrBx3DesuZssmrFzcqXjLfi9hgAq6IU1C2HxdZbTT2w/sJACWzqJBbFtsoNAbrfP1xwKgxG8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS4PR12MB9772.namprd12.prod.outlook.com (2603:10b6:8:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:48:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:48:03 +0000
Date: Mon, 13 Apr 2026 11:47:52 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/5] selftests: net: bridge: add MRC and QQIC
 field encoding tests
Message-ID: <20260413084752.GD209364@shredder>
References: <20260412111047.1326-1-royujjal@gmail.com>
 <20260412111047.1326-6-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412111047.1326-6-royujjal@gmail.com>
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS4PR12MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6e47ec-c296-4f91-67d2-08de99395fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KXYUWiDI8bOa8oFjc87A1mlAr7RLvbQJhnmN2xnMZvEyoA1tGT1ZWamAGC5V5rr5WKeVpbJ/s80jKZm1vYxY3KRvlkb4AqiHO/SCirXWBCGTsngEXxrDZEkWYQYYiXMuddHDj3JENix2TTwxCH3Vh2KSHkH54yHY3qZWt1BqeeOdleWnvGyJ0NuZu47s9crz49ykDCL9dJf6SjgoQWpRTb7xgv75TY9UhkDPucUbM7O/frWbj2B9bR6AhYsSq0gq8BQ2WGYl/zt3DYSYmtJnQOUBg6+oAAbGavyNt38TJ+ax92fPQU22zWvbLNRVQHTs+rwkqjfWpRT9/EpLv29IQYdKldmdTAtj9nPvK+11UKwJTh6OsoXabj7U+72lFEzeTrVPbNSZuojnENQ37cUeoaveJR4znrMsCgrTLa+cpZPiKF+BcTv72OnC1vjga7yW41sreu2NCnFdml3XSXbIsWAQ5ZKNlzrRk/ge44dgvaYCTIQT/YuMK502VeXLowtsFIZMBXfbrxTyEHD6PwdJPlQTsoVkx9gUJb+G0PcoT3ARIpM1OoR/HloPVjSzbd1M6UyAGKu7ZAvhqHE5SkkBRCTxYlxAqnVlFxmbnbqDvI7ImKzSFagolG/RIWYUfQ75+FQDfkdWAhr5AZGn3Izr4XKuqXZZqU3l0mKaj6dYbypmSypV6QBQmFManEv05HeyBh6DS9ry+G6PWNacwpMzxKBCAPFCwWpnsXh9pxRycnA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RtVhB8rZxhkfm2ofihcaOERu2GM8dg7vThmUdo+1TwzFUF/F1O+uujxfE+vp?=
 =?us-ascii?Q?ZnyZQJFkYJ3D/eveZfKBUBj4hhvAANchI3/eet7VL4q6XCZ/hEjif7HrrHhZ?=
 =?us-ascii?Q?p35qdiiFlbqSm9AxahaFGLE8YpSxb2ABNqjElGp8O+4ZPnZWC+lDhJJMtgB6?=
 =?us-ascii?Q?8KAgrX5Ln5nyrOACvES46os5WQkrd153jre8Lo13xaHQefFLr62y8V4ITOh4?=
 =?us-ascii?Q?7+Tb2MwXcu459HDeF4z+YHRmqm5PNeHBsi6GmMcStcOmBVmNM9+PIjIqyXed?=
 =?us-ascii?Q?CG2wEiSxsu04gBmSamFlchrMtAPd4SQdV2uiV9pXTlwONk3QvjHUT2k30a36?=
 =?us-ascii?Q?5vxAxnQPjX4dP0iVOL4BKZ4Oao8IaQq8T8Ej2gCviAS1FOwfgcWSGJJQVCQa?=
 =?us-ascii?Q?MXaa/vLHBRUXRRmksFZg8/TWafZObzgtbpBPw55NOeHaYlk4OsXPRJrGNwkm?=
 =?us-ascii?Q?wQvbGWab52/kvQUJRuu4WqLA1g1h2WMoYJqV/OrtpLgvtSeoQUwNrUpIEG/T?=
 =?us-ascii?Q?cwmqPMyRaw06u+W2wvEfKU/XsCZAn5ZFKGpTBMAJvL7EIh+fENLwFoE4aPbB?=
 =?us-ascii?Q?Uid0Bjd8qPuP2sUyzajAAxhoQBiG/OToAb5lo9y3dfeSnsV3KiCAaxwCoBYg?=
 =?us-ascii?Q?NfkOmzRCNaoFT8zWL1u3Ox6PkS+nvODsvmh576knBldrT9RMQLpxLCHOV/tX?=
 =?us-ascii?Q?uOLcr8tI/WnHn9xkmAaDrXh75ayjoX7LpdiU1jjySanMGs4V7W5lZ6Z4/Aap?=
 =?us-ascii?Q?C9Jq1y3s4d6OjuZNkAbnBxgM2kl5LJa+If4/ScopuHKGnln8Knggp+aZw30l?=
 =?us-ascii?Q?IKRGBpdKP+wElfmT0f/MUPUp5GzucX+3yGG2ZlhEHKqcTplKi4AlB45G/jPv?=
 =?us-ascii?Q?UvkwWcsh23I6+18vIDoTYbYR2yd80AHUdt+x3NpTFasFPNbgiIZzfZSIk1HH?=
 =?us-ascii?Q?NZBEXX7vZKwLysHPexvvyrfilWrMEBs6b64D+XHrjoPJUvPtx2nn452zPazy?=
 =?us-ascii?Q?E0nhkQVhDiH/k788Jj6imJnMUMODOoRExvzwo8+wRWD6eWBZlvCzEQhNvXCd?=
 =?us-ascii?Q?xuAHjQ/aMiUh63ZpZgWhpWHagaHPeqiZMn5fBEwriw391wT1C20ikYGgFso7?=
 =?us-ascii?Q?j3t3SbTrnj0f6i/cPHAJXCa+3NKlfCCRtvqaecvLoVjGCOMbHspXCG2ymO7Q?=
 =?us-ascii?Q?FeT8tlpqIoXcOtXvjYsFm6vCrW0uJHDfmH8JJ3jjdB4IoHC6IW9CwTvwbYl7?=
 =?us-ascii?Q?xychlBIEC78OXL26fOSyb04bVQK3MSS4Bf/+MghVGaK+HiZDh24HOdniVCxL?=
 =?us-ascii?Q?76koBJA75mEWGDUobopTpEO/4DRUCaiA2HxF1uw4PHf8/xVZQUa3bD3d02dK?=
 =?us-ascii?Q?MB3HAyqM6MkpV7aVcoNARPd52O9jt93wWtpnxwQSwN5Zf4BSHsbz+0kbw3dc?=
 =?us-ascii?Q?h96HnEseHWxE3oGWpjYGktegBzzz2Z9QOepFax1Lq0wLkK/dsjhFY+i/7HdN?=
 =?us-ascii?Q?FeCnqT+4GQ+2ZaKCHdvY0KpytyHkCKl1XtlG2pkkhNhByINiyRV6q/4GDvHb?=
 =?us-ascii?Q?+jjNZ5JHby0RsZcPss4vwnD9VOdFtixBkBxQaCWDoF0p98oEQkm+PKk87jfx?=
 =?us-ascii?Q?JVpg9jpbGn26JYEJ15Vj9CNmm3yx8vhFo0cBsXC9PAL9XkqULW3sHkSORKCQ?=
 =?us-ascii?Q?wLCV4bP5krkzAQ4Z+ZQMGeLlkBEJh3ds3EuOjUjHYHm6mhYe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6e47ec-c296-4f91-67d2-08de99395fb9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:48:03.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7jpLmxAv2ox9nDjYn0ys+soS1x8aCVq/P47oDlYXymNit35Ek6Rpj13L7BqsMxxSiYIAXVp4vR/rh4flOEQuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277995-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bridge_vlan_mcast.sh:url]
X-Rspamd-Queue-Id: AB04C3E954D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

See some comments below, but note that net-next is closed:

https://lore.kernel.org/netdev/20260412142250.131bf997@kernel.org/

So you can either wait with v5 until it is open again or post it as RFC
so that we can at least review (but not merge) it while net-next is
closed.

On Sun, Apr 12, 2026 at 11:10:47AM +0000, Ujjal Roy wrote:
> Enhance vlmc_query_intvl_test and vlmc_query_response_intvl_test in
> bridge_vlan_mcast.sh to validate IGMPv3/MLDv2 protocol compliance for
> MRC and QQIC field encoding across both linear and exponential ranges.
> 
> TEST: Vlan multicast snooping enable                                [ OK ]
> TEST: Vlan mcast_query_interval global option default value         [ OK ]
> INFO: Vlan 10 mcast_query_interval (QQIC) test cases:
> TEST: Number of tagged IGMPv2 general query                         [ OK ]
> TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
> TEST: MLDv2 QQIC linear value 60                                    [ OK ]
> TEST: IGMPv3 QQIC non linear value 160                              [ OK ]
> TEST: MLDv2 QQIC non linear value 160                               [ OK ]
> TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
> INFO: Vlan 10 mcast_query_response_interval (MRC) test cases:
> TEST: IGMPv3 MRC linear value 60                                    [ OK ]
> TEST: IGMPv3 MRC non linear value 160                               [ OK ]
> TEST: MLDv2 MRC linear value 30000                                  [ OK ]
> TEST: MLDv2 MRC non linear value 60000                              [ OK ]
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>  .../net/forwarding/bridge_vlan_mcast.sh       | 150 +++++++++++++++++-
>  1 file changed, 142 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
> index e8031f68200a..9f9f33d58286 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
> @@ -162,14 +162,27 @@ vlmc_query_cnt_setup()
>  {
>  	local type=$1
>  	local dev=$2
> +	local match=$3
>  
>  	if [[ $type == "igmp" ]]; then
> -		tc filter add dev $dev egress pref 10 prot 802.1Q \
> +		# This matches: IP Protocol 2 (IGMP)
> +		tc filter add dev "$dev" egress pref 10 prot 802.1Q \
>  			flower vlan_id 10 vlan_ethtype ipv4 dst_ip 224.0.0.1 ip_proto 2 \
> +			action continue
> +		# AND Type 0x11 (Query) at offset 24 after IP
> +		# IP (20 byte IP + 4 bytes Option)

Let's make it clearer: 20 bytes IPv4 header + 4 bytes Router Alert option

> +		match=(match u8 0x11 0xff at 24 $match)
> +		tc filter add dev "$dev" egress pref 20 prot 802.1Q u32 "${match[@]}" \
>  			action pass
>  	else
> -		tc filter add dev $dev egress pref 10 prot 802.1Q \
> +		# This matches: ICMPv6
> +		tc filter add dev "$dev" egress pref 10 prot 802.1Q \
>  			flower vlan_id 10 vlan_ethtype ipv6 dst_ip ff02::1 ip_proto icmpv6 \
> +			action continue
> +		# AND Type 0x82 (Query) at offset 48 after IPv6
> +		# IPv6 (40 bytes IPv6 + 2 bytes next HDR + 4 bytes Option + 2 byte pad)

Same: 40 bytes IPv6 header + 8 bytes Hop-by-hop option

> +		match=(match u8 0x82 0xff at 48 $match)
> +		tc filter add dev "$dev" egress pref 20 prot 802.1Q u32 "${match[@]}" \
>  			action pass
>  	fi

Sashiko has a relevant comment:

"
Does this configuration evaluate all packets against the pref 20 filter,
regardless of the pref 10 result?

In tc, if a packet does not match a filter, classification automatically falls
through to the next priority filter.  By using "action continue" on pref 10,
matching packets are also instructed to continue evaluation at the next filter.

Because both matching and non-matching packets proceed to pref 20, pref 10
seems to act as a no-op gate.  Could this cause the u32 rules in pref 20 to
inadvertently match unrelated background traffic on the interface?

To implement a logical AND across different classifiers, should pref 10 use
"action goto chain 1" with pref 20 placed inside chain 1?
"

>  
> @@ -181,7 +194,53 @@ vlmc_query_cnt_cleanup()
>  	local dev=$1
>  
>  	ip link set dev br0 type bridge mcast_stats_enabled 0
> -	tc filter del dev $dev egress pref 10
> +	tc filter del dev "$dev" egress pref 20
> +	tc filter del dev "$dev" egress pref 10
> +}
> +
> +vlmc_query_get_intvl_match()
> +{
> +	local type=$1
> +	local version=$2
> +	local test=$3
> +	local interval=$4
> +
> +	if [ "$test" = "qqic" ]; then
> +		# QQIC is 8-bit floating point encoding for IGMPv3 and MLDv2
> +		if [ "${type}v${version}" = "igmpv3" ]; then
> +			# IP 20 bytes + 4 bytes Option + IGMPv3[9]
> +			if [[ $interval -lt 128 ]]; then
> +				echo "match u8 0x3c 0xff at 33"

Please pass the expected value as an argument instead of hard coding
"0x3c" here. Same in other places in the function.

> +			else
> +				echo "match u8 0x84 0xff at 33"
> +			fi
> +		elif [ "${type}v${version}" = "mldv2" ]; then
> +			# IPv6 40 + 2 next HDR + 4 Option + 2 pad + MLDv2[25]
> +			if [[ $interval -lt 128 ]]; then
> +				echo "match u8 0x3c 0xff at 73"
> +			else
> +				echo "match u8 0x84 0xff at 73"
> +			fi
> +		fi
> +	elif [ "$test" = "mrc" ]; then
> +		if [ "${type}v${version}" = "igmpv3" ]; then
> +			# MRC is 8-bit floating point encoding for IGMPv3
> +			# IP 20 bytes + 4 bytes Option + IGMPv3[1]
> +			if [[ $interval -lt 128 ]]; then
> +				echo "match u8 0x3c 0xff at 25"
> +			else
> +				echo "match u8 0x84 0xff at 25"
> +			fi
> +		elif [ "${type}v${version}" = "mldv2" ]; then
> +			# MRC is 16-bit floating point encoding for MLDv2
> +			# IPv6 40 + 2 next HDR + 4 Option + 2 pad + MLDv2[4]
> +			if [[ $interval -lt 32768 ]]; then
> +				echo "match u16 0x7530 0xffff at 52"
> +			else
> +				echo "match u16 0x8d4c 0xffff at 52"
> +			fi
> +		fi
> +	fi
>  }
>  
>  vlmc_check_query()
> @@ -191,9 +250,13 @@ vlmc_check_query()
>  	local dev=$3
>  	local expect=$4
>  	local time=$5
> +	local test=$6
> +	local interval=$7
> +	local intvl_match=""
>  	local ret=0
>  
> -	vlmc_query_cnt_setup $type $dev
> +	intvl_match="$(vlmc_query_get_intvl_match "$type" "$version" "$test" "$interval")"
> +	vlmc_query_cnt_setup "$type" "$dev" "$intvl_match"
>  
>  	local pre_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier 1
> @@ -201,7 +264,7 @@ vlmc_check_query()
>  	if [[ $ret -eq 0 ]]; then
>  		sleep $time
>  
> -		local tcstats=$(tc_rule_stats_get $dev 10 egress)
> +		local tcstats=$(tc_rule_stats_get "$dev" 20 egress)
>  		local post_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
>  
>  		if [[ $tcstats != $expect || \
> @@ -441,6 +504,7 @@ vlmc_query_intvl_test()
>  	check_err $? "Wrong default mcast_query_interval global vlan option value"
>  	log_test "Vlan mcast_query_interval global option default value"
>  
> +	log_info "Vlan 10 mcast_query_interval (QQIC) test cases:"

Let's remove this as it makes the output confusing:

INFO: Vlan 10 mcast_query_response_interval (MRC) test cases:
TEST: IGMPv3 MRC linear value 60                                    [ OK ]
[...]
TEST: Flood unknown vlan multicast packets to router port only      [ OK ]
TEST: Disable multicast vlan snooping when vlan filtering is disabled   [ OK ]

>  	RET=0
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 0
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 200
> @@ -448,8 +512,42 @@ vlmc_query_intvl_test()
>  	# 1 is sent immediately, then 2 more in the next 5 seconds
>  	vlmc_check_query igmp 2 $swp1 3 5
>  	check_err $? "Wrong number of tagged IGMPv2 general queries sent"
> -	log_test "Vlan 10 mcast_query_interval option changed to 200"
> +	log_test "Number of tagged IGMPv2 general query"
>  
> +	RET=0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 3
> +	check_err $? "Could not set mcast_igmp_version in vlan 10"
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 2
> +	check_err $? "Could not set mcast_mld_version in vlan 10"
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 6000
> +	check_err $? "Could not set mcast_query_interval in vlan 10"
> +	# 1 is sent immediately, IGMPv3 QQIC should match with linear value 60s
> +	vlmc_check_query igmp 3 $swp1 1 1 qqic 60
> +	check_err $? "Wrong QQIC in generated IGMPv3 general queries"
> +	log_test "IGMPv3 QQIC linear value 60"
> +
> +	RET=0
> +	# 1 is sent immediately, MLDv2 QQIC should match with linear value 60s
> +	vlmc_check_query mld 2 $swp1 1 1 qqic 60
> +	check_err $? "Wrong QQIC in generated MLDv2 general queries"
> +	log_test "MLDv2 QQIC linear value 60"
> +
> +	RET=0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 16000
> +	check_err $? "Could not set mcast_query_interval in vlan 10"
> +	# 1 is sent immediately, IGMPv3 QQIC should match with non linear value 160s
> +	vlmc_check_query igmp 3 $swp1 1 1 qqic 160
> +	check_err $? "Wrong QQIC in generated IGMPv3 general queries"
> +	log_test "IGMPv3 QQIC non linear value 160"
> +
> +	RET=0
> +	# 1 is sent immediately, MLDv2 QQIC should match with non linear value 160s
> +	vlmc_check_query mld 2 $swp1 1 1 qqic 160
> +	check_err $? "Wrong QQIC in generated MLDv2 general queries"
> +	log_test "MLDv2 QQIC non linear value 160"
> +
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 2
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 12500
>  }
> @@ -468,11 +566,47 @@ vlmc_query_response_intvl_test()
>  	check_err $? "Wrong default mcast_query_response_interval global vlan option value"
>  	log_test "Vlan mcast_query_response_interval global option default value"
>  
> +	log_info "Vlan 10 mcast_query_response_interval (MRC) test cases:"

Same

> +	RET=0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 3
> +	check_err $? "Could not set mcast_igmp_version in vlan 10"
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 600
> +	check_err $? "Could not set mcast_query_response_interval in vlan 10"
> +	# 1 is sent immediately, IGMPv3 MRC should match with linear value 60 units of 1/10s
> +	vlmc_check_query igmp 3 $swp1 1 1 mrc 60
> +	check_err $? "Wrong MRC in generated IGMPv3 general queries"
> +	log_test "IGMPv3 MRC linear value 60"
> +
> +	RET=0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 1600
> +	check_err $? "Could not set mcast_query_response_interval in vlan 10"
> +	# 1 is sent immediately, IGMPv3 MRC should match with non linear value 160 unit of 1/10s
> +	vlmc_check_query igmp 3 $swp1 1 1 mrc 160
> +	check_err $? "Wrong MRC in generated IGMPv3 general queries"
> +	log_test "IGMPv3 MRC non linear value 160"
> +
> +	RET=0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 2
> +	check_err $? "Could not set mcast_mld_version in vlan 10"
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 3000
> +	check_err $? "Could not set mcast_query_response_interval in vlan 10"
> +	# 1 is sent immediately, MLDv2 MRC should match with linear value 30000(ms)
> +	vlmc_check_query mld 2 $swp1 1 1 mrc 30000
> +	check_err $? "Wrong MRC in generated MLDv2 general queries"
> +	log_test "MLDv2 MRC linear value 30000"
> +
>  	RET=0
> -	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 200
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 6000
>  	check_err $? "Could not set mcast_query_response_interval in vlan 10"
> -	log_test "Vlan 10 mcast_query_response_interval option changed to 200"
> +	# 1 is sent immediately, MLDv2 MRC should match with non linear value 60000(ms)
> +	vlmc_check_query mld 2 $swp1 1 1 mrc 60000
> +	check_err $? "Wrong MRC in generated MLDv2 general queries"
> +	log_test "MLDv2 MRC non linear value 60000"
>  
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 2
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 1000
>  }
>  
> -- 
> 2.43.0
> 

