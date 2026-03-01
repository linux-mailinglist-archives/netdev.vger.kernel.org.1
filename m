Return-Path: <netdev+bounces-262394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PujLwA0pGnPaQUAu9opvQ
	(envelope-from <netdev+bounces-262394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 13:41:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EB71CFA6E
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 13:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0DB430120E8
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E2731715A;
	Sun,  1 Mar 2026 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i8yK4nOM"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021B175A83;
	Sun,  1 Mar 2026 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772368869; cv=fail; b=ISfkncp+sfiYaKRE6Q4abPzpJPcjayYOONKJgN0TbEHVlSHA1dXbi3/40N7J/CAfulSOegdjH10STWTPMLoes7ZphLc31VhV2YiO3c0iAXutzJgvrygAZX7bW/R8kC9fwe3CKLquaHCR3uYrzETp8xCGcmlosOcS7rUY5Rp5z9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772368869; c=relaxed/simple;
	bh=vzeQuRolMjEg3YjiOVHg29uD/FTPn+C8lK7gEtyKmkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CPTdVvzDcPDuntNbZaeAHKRESmHhdQ25AXx1WAwlWNXwSLlHyQKn4MyqfAJw8AWGIrY0i+o5U0wtNiOP2BEHlO4s7V6rrsru5NpiMmBsG2CWfJ2ZrOmUyqyavOP4dBcpEZ9r4le7mqnldQb3hX81kLJZSEcizigVLbyXfvjGwoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i8yK4nOM; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtXFkJCtjNHvsAYf3yG101uJQcDHJmKNOsgAYtDQxIDZSelM70Od9OwJmkrzpf74JD3WhsFKIy5mhyeWqJMupIXotehPPDzdeJ8xCf6o8hg+hlRRMR2CLG82C1x4qJBW7sGgBpyeMJVJ9+jO25ScXluql4gg9u3wr6BFVzMcBRpt5P7ku8LN8WKL/LPLi59zGZwKwKWCM+4UfPQKMspZ6zB2b/s4k7d4sHCymIRPK3yVgU36k78QARRaDE9CwYnMOwRbZhsOBxaCeB0eivYMOfZHkyY0pChpUCYXTLi1eXjxsS3Xn5VdBlW0yOEOdbCSMGBFwLsHu6xsET4Y69+dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT1oco0lUNN9DH/tSjfI2vGj/FB1AMEJ6iT0zBvQ4AE=;
 b=FHRBsSeXcR6G7Bc1ibu0bTMIzL1d6gnDprRrv+WSIlgQu9BFO7UQ2l1jyNGEONkNRDNx26gSfqJ6AwNySO910uUwP/23x4rtoDw0FOexBHxhqdzw4eS9q5zhgWmy7B5FA22eZVLFiN6NpOczbIY9dQ0OEJs+WvJ9ABkffgLQTcLT2YoBDCPyg2XsS1cDi9k+nq/eqrzeIHJZaiRm1Rmfd3hgANKaolEApWhPxBCFaUqz9xjoYfY6lWcV2dkqKbmB031rK4x+tTJCpXCoB/NgSjJ0Kj5CYkOYKl2QSeKMaHjn9gmr/9YRkmEsEjNqvDy2lK7NjoojRzhqsc16OCRWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT1oco0lUNN9DH/tSjfI2vGj/FB1AMEJ6iT0zBvQ4AE=;
 b=i8yK4nOMORjfgkUBebXAsnZue8dcQJPgKI/Ew/rdkovzc+YYAEynYcZAGQBox3u7lRVlZzVmyJ3rUfKkBGb9EFUL9p9yaGZYCPreP90sGdnskR5TzHDVQLvPopPbxgURWzk4ppac3JiwzQ+VkG9N/4SLc/UBx3Qe0T+j/CWMID/9veCSf4a8X/xi4TnLd+CZ1OYG+3AWBZ1cwXZvjFn8oboIlWGQbvqQdzqk2o5Vw6NdSxX0IS7c3BE4vmOMF/YJiJVnMsfVvTewdzgGcscEU3Dn6devkla01/z8WFk5U6ZCnqRaGmAuejVs0xPDBceRKE5kBfAdzLgcGPXbZYhaPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3SPRMB0009.namprd12.prod.outlook.com (2603:10b6:806:31a::8)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.15; Sun, 1 Mar 2026 12:41:02 +0000
Received: from SA3SPRMB0009.namprd12.prod.outlook.com
 ([fe80::ff04:ba7f:5bdc:4f89]) by SA3SPRMB0009.namprd12.prod.outlook.com
 ([fe80::ff04:ba7f:5bdc:4f89%6]) with mapi id 15.20.9632.017; Sun, 1 Mar 2026
 12:41:01 +0000
Date: Sun, 1 Mar 2026 14:40:52 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Nir Dotan <nird@mellanox.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: forwarding: fix IPv6 address leak in
 cleanup
Message-ID: <20260301124052.GA713428@shredder>
References: <20260301014706.454243-1-aleksey.oladko@virtuozzo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301014706.454243-1-aleksey.oladko@virtuozzo.com>
X-ClientProxiedBy: TL0P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::17) To SA3SPRMB0009.namprd12.prod.outlook.com
 (2603:10b6:806:31a::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3SPRMB0009:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 16318a5f-1301-4252-f61f-08de778fcbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	6cbsX1mSVzNJ35gJhNufDuYhVCF9vccvQZxxmkRH0zC0njZYqazdF5IVmDzMmiRs5yZpaBNcxh+XqV8ESe2+AUd8SCdDXzpE+lRuSg0F4Avtvl0ybpI7yGfz4uXcoiHcFJdrE/YOMs/ypOcPUR2C6ztJChm0TqYtqdv0MB5i1xmZO/+BKr8Me2c3wuaSRVhUCKbFFqygmhBhJFXZaX3q7Yf/NZD/JNtWuH/c5tgXOzebLplGFcdCjj/XNmCgw0eFyt2h5VdvQ09bpAe/bi6/CvMcLlTWryAqGLC7yzvP0T/OJwHkxFMoyoywQSF4dfkqZzR6RX+UDAuz+d0mFaiYo0wWp6MtlNvNrnpv5/n9j+xwyjouu/UGklPle/p/2o/9LltuoFZXeRHugNjuW7FXoOsfZ7V0UPiLomklL432ZPcI974+nsCui0axSr3cwysaa3DdCdInmFx0TP4L33vzF1UzkGxgB5fBdz7u+75yj31oV/iWTFJNwmsgrBoQFJnLeYdMBffEhRG6hxwIFG2nv4bMxBi9NXoZOdMbNKHjJI+6klIm86DzRZPIB3+c6/n1GO+bhJHTMlhkQrFNMjUiZqD6RZAHwIyVZymtUuXUjkA8gQYWLCGxuqvy/eqqHFi3raCcUssQVwQPgsEWvJaVgAqfZlxFJ76uEyiQItQaZzmYSWdaIogdFxxCEIhfJzXL+rEnD/Tfl7Q5+I4CG1rGEAot9DU3ryEkUOiLz7Y6LHA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3SPRMB0009.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHMTLL1DCWua74IVd2DRVA2jBGzI12hYn0711I7WwBtEzbFj70uSgvKySDbX?=
 =?us-ascii?Q?P+MBvabb/Cz+jjvk8LUjud54uo26sTKQwxfmJ3QceKdL31riWTWqb462sdR3?=
 =?us-ascii?Q?kqbDSDeuZikUhOec/rDo8+9Y4qIhsBpYC7XaS+TUKU+8ADBUNDzHyJSy/ApO?=
 =?us-ascii?Q?04wRt/KPf2zPOL3xVgRXBgrr+QSwD7q50sUBh8ezGdX09qZnSy5SMeOZIhu4?=
 =?us-ascii?Q?zPHO0Mx84DVCr+h6vFNlNBMPEMzPi/rw5yg/aqLBjaPPugO5V3oqjeRz+2yy?=
 =?us-ascii?Q?yPDbCDoazMTSEHx1IKVG38ZG72h4mvxeEwfeYDCPXtlRVfTnHBGxO+rtBK/H?=
 =?us-ascii?Q?dZaSicvOfTS6PxeaOvOgR60CQEHYPmHmPpP4D1MB70UEvH/EgsUgkpBjeWeK?=
 =?us-ascii?Q?uUDvz1U7DFAcQNv/feaFi6qJbIADoV27e1q+vifo3rmST0SCAcqLYXX2J33Y?=
 =?us-ascii?Q?2I3LxpK2xdZhLS9mh2FrZwWG3SDdTOlJR1KXXr8tc1oCTuFBGbnXSebPoEhm?=
 =?us-ascii?Q?GpTEdAG2UUwVdaO7RHS9YK2tAHwHe1+7LpdssAgGigVIOs3Qu/gpYQCanTie?=
 =?us-ascii?Q?HcAmnsRIXwZDPMATs7A80u9KRV01K5xmtoAO12haAnJh1vH52oXGDR7DFERv?=
 =?us-ascii?Q?COIM1oFn51K+94bujPAfXBsicrn4qumwa+l22C3K2dYimxX6ITXc1Czr7Mxd?=
 =?us-ascii?Q?oSXTZ5Lc4/QJPjrPe0eA34o4mVYMcnRxyznVvrbUJuxXJ3InYludlCqAPEIF?=
 =?us-ascii?Q?7cKWpXg0fmNPuciCz7cZwiFLIIgFJIFqsn2JpClytxI9cBQLaKkUR5guRXtv?=
 =?us-ascii?Q?bSmZ9dRD1eG6F676Suop9+NJioyZuwXp2NLaNTwbflfbR/aQ7dv9PDyLr25N?=
 =?us-ascii?Q?2YDnjlsSC4ibiO1TOxSoiw9Mny8yo/T7QRPk1rEQolhkC5WOoYoNZf4utT30?=
 =?us-ascii?Q?cVj/h5NZP3412INlQszZ90Y3EMH5UTD0aL3cLTMZ0SUPZIOQ+G87+kp0Sxrz?=
 =?us-ascii?Q?tz/55DnabvsXNWRvswwNQpTawbbTWm6muoUpYd+Gtu/jlGQ0zMNhMwKj2AZb?=
 =?us-ascii?Q?oli4ecGHM9yyi1weGg6DtnL0Q8cqGFdI32/SdJwA6ovJ0Ud739QjbmIg++rL?=
 =?us-ascii?Q?7BDTW9GMBrcEyuNLckhEcsHOGBQanSagduEQRpNyf45xrmeNTab1avRZUBMM?=
 =?us-ascii?Q?MPNnkKlQL7CWUlU80hB2BLDJDf3mK8wvA7aP20K8wsOuTPTa6kmjXk3+mw2e?=
 =?us-ascii?Q?vfBaaowcyte9CjBnB4b+JBQDNMqNvv5dQl22YPmNz6JTN2kx6EXq5lkYr/gv?=
 =?us-ascii?Q?M3LWx5s9KOkhEmFoKdX4a++4nmwZ6hSWXA1KLg4O5yydBXRJ27vPElmxLwVm?=
 =?us-ascii?Q?DUE4s51uMqBn7tuHGoGa2g4tphgCnfwyQqKGBWFRd1Aakr7G2OLeOfiL8ymF?=
 =?us-ascii?Q?7maNnM9OYAT+dN7t+q9NiDb4C0AQn5BYQPI0hUZzmanAywG0ndPGM6T+KZ/N?=
 =?us-ascii?Q?+EfRQ+dyax4VGlBZ+CfciGOP3ILCZuTH75rlAcSQWlJ476fdB6gUhkRo9OT3?=
 =?us-ascii?Q?P5AFO7Q5Gx3QRnt8O3UyBv9lsjSGHd/C4CYJfEN/8No92mufnfJSaPacgnHI?=
 =?us-ascii?Q?UgiStodGL3fQfPjwNapyW+viOuqbCZHRxGpnppAU2kVLNEsiLlpi8LyhdUm/?=
 =?us-ascii?Q?SmjKdkjgE3D94yi92V4nQ7PDQvogRioC6o3AgJRGOQeAXm+eYWLGF6M7hJMD?=
 =?us-ascii?Q?nn0hn8sBSw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16318a5f-1301-4252-f61f-08de778fcbd0
X-MS-Exchange-CrossTenant-AuthSource: SA3SPRMB0009.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 12:41:01.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPtYvjarOzO3AcAdynM+86Qa3pp4p2tgl/Jo6Q9Alxv6e2XpO3gYZ8jR4n3C+DHrv9dcI5DUCM2X68J+IMjSKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262394-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:email,min_max_mtu.sh:url,gre_multipath.sh:url,lib.sh:url,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,run_kselftest.sh:url]
X-Rspamd-Queue-Id: 57EB71CFA6E
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 01:47:06AM +0000, Aleksei Oladko wrote:
> Several forwarding tests (e.g., gre_multipath.sh) initialize both IPv4
> and IPv6 addresses using simple_if_init, but only clean up IPv4
> in simple_if_fini. This leaves stale IPv6 addresses on the interfaces,
> which causes subsequent tests to fail when they encounter unexpected
> address configuration.
> 
> The issue can be reproduced by running tests in sequence:
>   # run_kselftest.sh -t net/forwarding:ipip_hier_gre.sh
>   # run_kselftest.sh -t net/forwarding:min_max_mtu.sh
>   TAP version 13
>   1..1
>   # timeout set to 0
>   # selftests: net/forwarding: min_max_mtu.sh
>   # TEST: ping                                                          [ OK ]
>   # TEST: ping6                                                         [ OK ]
>   # TEST: Test maximum MTU configuration                                [ OK ]
>   # TEST: Test traffic, packet size is maximum MTU                      [FAIL]
>   #       Ping6, packet size: 65487 succeeded, but should have failed
>   # TEST: Test minimum MTU configuration                                [ OK ]
>   # TEST: Test traffic, packet size is minimum MTU                      [ OK ]
>   not ok 1 selftests: net/forwarding: min_max_mtu.sh # exit=1
> 
> Fix this by adding the missing IPv6 argument to simple_if_fini in
> all affected tests.
> 
> Fixes: fed926d4f64c ("selftests: forwarding: Add IP tunneling lib")
> Fixes: 902280cacc03 ("selftests: forwarding: Add resilient multipath tunneling nexthop test")
> Fixes: 54818c4c4b93 ("selftests: forwarding: Test multipath tunneling")
> Fixes: e035146d6560 ("selftests: forwarding: Add multipath tunneling nexthop test")
> 

Please remove the blank line

> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
> ---
>  tools/testing/selftests/net/forwarding/gre_multipath.sh        | 2 +-
>  tools/testing/selftests/net/forwarding/gre_multipath_nh.sh     | 2 +-
>  tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh | 2 +-
>  tools/testing/selftests/net/forwarding/ipip_lib.sh             | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/gre_multipath.sh b/tools/testing/selftests/net/forwarding/gre_multipath.sh
> index 57531c1d884d..397422cd5aea 100755
> --- a/tools/testing/selftests/net/forwarding/gre_multipath.sh
> +++ b/tools/testing/selftests/net/forwarding/gre_multipath.sh
> @@ -72,7 +72,7 @@ h1_create()
>  h1_destroy()
>  {
>  	ip route del vrf v$h1 192.0.2.16/28 via 192.0.2.2
> -	simple_if_fini $h1 192.0.2.1/28
> +	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64

The test only runs IPv4 traffic in the overlay, so I believe the IPv6
address can be removed from h1 (h2 doesn't have one as well):

diff --git a/tools/testing/selftests/net/forwarding/gre_multipath.sh b/tools/testing/selftests/net/forwarding/gre_multipath.sh
index 57531c1d884d..ce4ae74843d9 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath.sh
@@ -65,7 +65,7 @@ source lib.sh
 
 h1_create()
 {
-	simple_if_init $h1 192.0.2.1/28 2001:db8:1::1/64
+	simple_if_init $h1 192.0.2.1/28
 	ip route add vrf v$h1 192.0.2.16/28 via 192.0.2.2
 }

>  }
>  
>  sw1_create()
> diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
> index 7d5b2b9cc133..c667b81da37f 100755
> --- a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
> +++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
> @@ -80,7 +80,7 @@ h1_destroy()
>  {
>  	ip route del vrf v$h1 2001:db8:2::/64 via 2001:db8:1::2
>  	ip route del vrf v$h1 192.0.2.16/28 via 192.0.2.2
> -	simple_if_fini $h1 192.0.2.1/28
> +	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64
>  }
>  
>  sw1_create()
> diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
> index 370f9925302d..d04bad58a96a 100755
> --- a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
> +++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
> @@ -80,7 +80,7 @@ h1_destroy()
>  {
>  	ip route del vrf v$h1 2001:db8:2::/64 via 2001:db8:1::2
>  	ip route del vrf v$h1 192.0.2.16/28 via 192.0.2.2
> -	simple_if_fini $h1 192.0.2.1/28
> +	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64
>  }
>  
>  sw1_create()
> diff --git a/tools/testing/selftests/net/forwarding/ipip_lib.sh b/tools/testing/selftests/net/forwarding/ipip_lib.sh
> index 01e62c4ac94d..a5c23a28d50e 100644
> --- a/tools/testing/selftests/net/forwarding/ipip_lib.sh
> +++ b/tools/testing/selftests/net/forwarding/ipip_lib.sh
> @@ -151,7 +151,7 @@ h1_create()
>  h1_destroy()
>  {
>  	ip route del vrf v$h1 192.0.2.16/28 via 192.0.2.2
> -	simple_if_fini $h1 192.0.2.1/28
> +	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64

Let's remove the IPv6 address in this case as well. Looks like it was
added by mistake:

diff --git a/tools/testing/selftests/net/forwarding/ipip_lib.sh b/tools/testing/selftests/net/forwarding/ipip_lib.sh
index 01e62c4ac94d..b255646b737a 100644
--- a/tools/testing/selftests/net/forwarding/ipip_lib.sh
+++ b/tools/testing/selftests/net/forwarding/ipip_lib.sh
@@ -144,7 +144,7 @@
 
 h1_create()
 {
-	simple_if_init $h1 192.0.2.1/28 2001:db8:1::1/64
+	simple_if_init $h1 192.0.2.1/28
 	ip route add vrf v$h1 192.0.2.16/28 via 192.0.2.2
 }

>  }
>  
>  h2_create()
> -- 
> 2.43.0
> 

