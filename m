Return-Path: <netdev+bounces-213606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA69CB25DA4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9E35A04CB
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D88F4A;
	Thu, 14 Aug 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gtEHrVwz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262A1A9F8F
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156947; cv=fail; b=cdiDOpzcJBPNIc8Tield0N7ekKMO67TkFs3kQwSMtfzfLADWmCCi1EbB15tSQW8FdIi5uxqpofhtAU/oM+TN5vtZZvLZ6rnsFrT2LI2Rt2Iuk4bA+k5z4rtDycI5GtOnb4wR/W1lEG/Hu3sEoPBB+hTjcbt4N1pKX+wcerdQ3QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156947; c=relaxed/simple;
	bh=2GO+jZPXdCPSERY4xY9AfVgA+vbvQRT9lirHYAthSLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WuaXPYu2WS0RqS6ThZ06a+/EF4/D7YJrmDUCF0nlh81wy2Fq8oSMLGFBcNFvs0tMAPPjeRyviQccPy4OmqoV2FdVEDitWNQZMbkqHf1bcvROqcNIQtqH0lKDF3QeTuFbKTZUadsjBF6KPQeOtZvQj01G1v/qL0EcuTYNR4xohm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gtEHrVwz; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKLufMSR8Du07obxPnLV9oksb+1FXfyQkVWy3CtrlrNEw2nsQEvMOC6+PoEFlR4jULSD7+lRQyXEcXPeFZYrWaSM8T+q7/H4vuM6PiVqX2tnoJRfR1ivyvA/IJsuTDyLy4EIM2ss+i26jzKxJDxQlG3mjo9DBiWFs6IG9InSerHfgSRMiet5eHl1rtGzuLHPJ/6z2fjNE88+D4SCLJY8sMs3MPWE+E9sJ3HDN2v0aVIbX5VDr6PKaAQVpeHqaQwQADKKt8YLccvLbeDcDQk7lec8h7W5ZFBKXNiW67aqhAad/d8apxO3i9s6pwiSvWqwvNE8lDnASkPYRtQX8USq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiB7leiT41zLE0l5XXVcFSM9ht+8QaD6ZLZCbfltt7Y=;
 b=t2+pRqqS8xUq5IQ6N+eTgp/lFIZvTS47oUSNw1SlmYIzidixn2pDhan8Npcdo8fXPaAYGQTWCBi893R+CSoaMa7m92WrWyTJnILqLn1wEDJrGKb2juR9xFuq6+ylKctLmFi8aPKC9aI+vsBXekdLqbqSnWryFt5aS30SBGQnLJVEvjpweJ7LoVyx2l9M1xlqsNPWYbviK2VZAhUx3lPui/V53QXCq2VUPDKEm98rv/SfuVWcbo0xRCg2pZtyyR7YHIBgbC22Evkm7oE+Hh/TQSJGOcbO5cwyi34FDau6anUWRImFvd9tXRdvFu0szpZjKMPduldOlXoLknSvQRo3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiB7leiT41zLE0l5XXVcFSM9ht+8QaD6ZLZCbfltt7Y=;
 b=gtEHrVwzZbH3MC1InnG/+wGU8YCxVtmb9KlcTcmFkuVLKqfHuI9ZhEXW9PaY23fc2VlqyyPAILMTVuILvF6aDs8YMz4ji1qOTf7oWYd5aO1xDVOD9/Jy2hIAjFnz9xfaz60ucUuVgPR+jNSL7ZLyiGVSzHtq537r9T9E0RxN6xjG5SKTQFc89g8bMsAEnfhe6itgWeGqugWuzUD5slZeQmfsSs+Avvz0ldJ+GrZtsqQtv0iPlTgALcVlUrsbR0ZeEXDQMkTUDY2l3WQvhlPzqHXNdOYYbwoys1X4sFfePZYHKpj4KaoQHBe2Uck+nBBdnGTq68+tt1qa4lUzeLwIEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 07:35:40 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 07:35:40 +0000
Date: Thu, 14 Aug 2025 10:35:27 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net 2/2] selftest: forwarding: router: Add a test case
 for IPv4 link-local source IP
Message-ID: <aJ2RvybsdTpRZ27k@shredder>
References: <cover.1755085477.git.petrm@nvidia.com>
 <78e652584c82d5faaa27984a9afef2d6066a7227.1755085477.git.petrm@nvidia.com>
 <20250813134037.3c8f5a98@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813134037.3c8f5a98@kernel.org>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfcdd32-1ecf-494a-4019-08dddb052b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xAtM7fqAHjdC4ri4lKiR/YFwXFV9FM5/3OGbOXwrz/PPN9xcI7O9o1wHr/IL?=
 =?us-ascii?Q?a8sdwwLUWgkyJZHgDfy1aRut2zcgoKVEhM7Xn8qRxBI3KrXMjPh0G25/QRI3?=
 =?us-ascii?Q?NlVjB5JAl/dPwTPuaeWR1bfrazdENsBoYuc/utiLyAGkN7UrBwYwxHKN/sS1?=
 =?us-ascii?Q?JymBoEiy6uEpNdfIGS/9iwPw9TayKabQNDr4IU49fO1PMwSZWRBYGanYb23n?=
 =?us-ascii?Q?8q/YQy9swdcDzQfPIgqWjY/e2kC7c63ezHe4h7hQEc1CTpSlWlw98mb/x7XB?=
 =?us-ascii?Q?8ytAaKyODS5ze23bKt1liysGkE/ti/PBi+PxlYFdr2feaDWFEqx8yV5ndaqY?=
 =?us-ascii?Q?AdFUaL1bctg7VGEj+mmhEpMKR2rpNOYtmEjtndu6xt0n97pUxAXXDXqNrjkS?=
 =?us-ascii?Q?98PcK+QYHFBqXh99mPQktN7d8bxkXb62XAxymJ3dXZX5EEmyfXLSyvKqTA+X?=
 =?us-ascii?Q?nbhHrh5y/Jv8JJy52C2s2EWShTuPA8xDoWZH3XjrUZm8KL4iCJoXrQo+dmYN?=
 =?us-ascii?Q?WjMyYjitCFDZOv+vnMiaBQ/W9j3cKmr4idLswNdZ143CZJqcuph9GEnqF/vn?=
 =?us-ascii?Q?LtnIaaoNEe+/f7vcJ4iGfhREANXS8S+xtpykW6XeOGMFOzOzpbLBwtyuYkSd?=
 =?us-ascii?Q?smUZbndYZBpkpJ/Vjw9AXCtNcvzzN8275bvWFTdqq+ijjY3b2qkhD4ft7kKJ?=
 =?us-ascii?Q?6MMZ0MCU+13x9dK8dicuKK+nihRzM32ody0ov2l/Mi6hff7AXrwifvl28Tox?=
 =?us-ascii?Q?5pD60u3SdMcyMqLGb9UNyc5SYO2XCTa6JLAX3d60CKllYG9PSw/V2Gs+2+YB?=
 =?us-ascii?Q?6AJOiAJNQDTuKWhvQxZ7AZcygvIsXrtHSIOievFO18MN9DeFEN49G/GeMa1j?=
 =?us-ascii?Q?yEyPP7dxy872MsbIJVSTWqKe3+yUSFjRT13fuJgVY4zq9w4UfM/4720HHN+H?=
 =?us-ascii?Q?yo/Wc9rrmBoB5h2rq0otBJSIqOV/vhVS5IyMkiugFt3BTmCuc6atSA9g9JiQ?=
 =?us-ascii?Q?i/SKPjAjF+hUrYmdTmaNuIkyHU03I8FNq2WZAHJhfF+M/NaLqgPKphKoIRis?=
 =?us-ascii?Q?UNOnOi4FYtuQJzrlj6/sKLWDJS0vn7YPDTmWB1SA3gZoWOwXo0FFFFYX3H/s?=
 =?us-ascii?Q?k/c4wLunQ0wEkTa6z3P/w+mktQhKlyDyXid9cRUwCeXJllNNSArZPlus+WMO?=
 =?us-ascii?Q?QHrgc+aPASax5g5NyewWQeaVlk0WihdAnzftt8QIkIHsvPZqQLTrVBz1lMjc?=
 =?us-ascii?Q?U5qx5iaWo3IdqdevJ98ElhmWH0elpg++sU3QezMSdlKQSOkDhePhzPojcGjE?=
 =?us-ascii?Q?RdxP2/4mBuh01QJO4tQiz2ppx8qDaahYgbiCq0J3grcJBPFI0/m8MxB781Ys?=
 =?us-ascii?Q?SJU7mtkRfIujiNMTQ46Jbih0mdujsvd6fYLoMcJmS2nm8XtlWIUA2XFM8i7L?=
 =?us-ascii?Q?2V5iAeNSQMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BaJJZ7kk+jUjva4x94FUzzt19owGooAAg6RKF2/bo8kGpDrAEbvqsoIory3R?=
 =?us-ascii?Q?L1y41RRBtqLJgpGPs+a7OArRbLhmod+2aasTw+VaELFqNDQZPp8X795YCnJJ?=
 =?us-ascii?Q?hHvbSnzYXp45/HoOLhpsMbDHIfDKqhf4yLXfuRHxotDUlW/+p2+pt+3JTs4n?=
 =?us-ascii?Q?mfsq6SibJu0kxjVzSGiNFTCn7jz2y4HBzkbxJHGuHX/VSxlA2VQf8KW4rU7v?=
 =?us-ascii?Q?K1F0L5CrxZcHWzjToq0hBwEMhdlwf76/yOO2Exu3Y+fUrbiadXkjzA7gnzsn?=
 =?us-ascii?Q?Ayag3Mmk68GzKmMcxufmH49T5Y0AvR4ERSyhvXT6lw2RloobO/lmlm3cOCG5?=
 =?us-ascii?Q?SMyNCWVhcEP80eqQDrH3BW8ZllhQBLA/U6f1WFHSQxUtXEQmIaDkNT3xbuyH?=
 =?us-ascii?Q?2n+YWcURzeBehm3ee8uYNuRURH7aMv9k+ELiizPDnk7XhQAdq3x09aCAUCvG?=
 =?us-ascii?Q?/Q8dI8iUH6Gjuwee8Tq37O/6uZ98bKkaFIFb/Xssldcgx8O6E8LYCO6dHT5P?=
 =?us-ascii?Q?lQ4SdOFrNXWRlaIlE5FajDEUMRqQj83qIJCn4cmytXI44N+hOQKpsamxX3eM?=
 =?us-ascii?Q?klTidMAJKMSBn+N57oCzVArIe3jMkdyp37DQeTRPyn2Rwu09pPjsCLCDuxmj?=
 =?us-ascii?Q?gntC/eGB4k/ODMSLjK8JSkZYmdo783Af8jWNZ/fZ+fFzPBE3jp19tJ5RFrve?=
 =?us-ascii?Q?bXqQfSGaY8dk148o2YHuHUTfaGdVYe3J68p7fOnUv+KG5V89H2oIK37lnhOc?=
 =?us-ascii?Q?wKLCIiDyEMvCPejWuup43tCc8MP7bN6Xqirbj81YMmxfVDzthGqzZkc5FWPR?=
 =?us-ascii?Q?wKJFvSUzqq9E0EOGgOQErewHjtGyRhxl108Af5bVPhNhkNsIhftvbXjXmvAB?=
 =?us-ascii?Q?tZsQlaDhbNBkBcY/bzTdbl9k6mQ/cm0jljIehsJOIsmXrqXrks4uxGzEitLP?=
 =?us-ascii?Q?GCu6eaa7/1xY5IeUUf/KpVxB9MCU7qV3+aXVq8fkDCCQTB1msZXp4Jt+ebUC?=
 =?us-ascii?Q?mHJcw3w3CClJ6yqfNjj27GQF8lEnHe8ytsSV0e6ans1LKHltJvSmv2Y81gs/?=
 =?us-ascii?Q?XKpmYm2Lrw0wKLSCf+flTUEsEK2siGilz0VucT/e3NKvgyHOtQbmJCn3VnYb?=
 =?us-ascii?Q?LuNBMM4czxC4Dyq2tQf9D9bc71FsnOuxa+o6xH2tj+akxtGqnvEj/Xmki7hX?=
 =?us-ascii?Q?xe17hO4GjqeVY6hoLgS63wuTu2+oAdLYu2a8wbL7Ntg8RnJQ6lAT6Cbi3LqG?=
 =?us-ascii?Q?Ydq5J2fhwYtTz7yOpvvsENZEH3Hp01ini25r1vzmqNryyf0sbQVsGo81mj1F?=
 =?us-ascii?Q?FVG4As9v+IHgmpuIXVOs0t0ns9rYuTDbQcoFFupOUQxb7d0xzNXiAshVF5Lp?=
 =?us-ascii?Q?QBxmZW/101P5ixLs4irfh8WWZgCmULE76gxInwDcYLsoILKF6UKRa1oMxaV0?=
 =?us-ascii?Q?jJEc63UNypIOUbjdv3r9kJZC6oMEE3NvbQgTZJilOMrG8rzibpg23WaQ2SL8?=
 =?us-ascii?Q?J7WxcxblBnab2FwTMa15droZ+n+iaa3P7ORqS01q78Tsame6iEEck++5+6CI?=
 =?us-ascii?Q?cCI+NSjhchbyHioSlJt8cZnWoHeKkopo0DjOd99R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfcdd32-1ecf-494a-4019-08dddb052b55
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 07:35:40.7595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTdHEE0iIUDKABLBpNbTbRtdqH4YYxTykIMxIYVCdJfiZLsMh/TjleeSn3nqN1YpgB3iarQOUkoQtLWAqnCzyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414

On Wed, Aug 13, 2025 at 01:40:37PM -0700, Jakub Kicinski wrote:
> On Wed, 13 Aug 2025 13:47:09 +0200 Petr Machata wrote:
> > From: Ido Schimmel <idosch@nvidia.com>
> > 
> > Add a test case which checks that packets with an IPv4 link-local source
> > IP are forwarded and not dropped.
> 
> The new test case doesn't pass for us:
> 
> # 22.73 [+2.13] TEST: IPv4 source IP is link-local                                  [FAIL]
> # 22.74 [+0.01] Packets were dropped
> not ok 1 selftests: net/forwarding: router.sh # exit=1
> 
> https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/251622/97-router-sh/stdout
> 
> LMK if this is an infra problem, I'll hide the series for now:
> pw-bot: cr

Seems that we need to disable rp_filter to prevent packets from getting
dropped on ingress. Can you test the following diff or should we just
post a v2?

diff --git a/tools/testing/selftests/net/forwarding/router.sh b/tools/testing/selftests/net/forwarding/router.sh
index 50d362ced430..b409680bec1d 100755
--- a/tools/testing/selftests/net/forwarding/router.sh
+++ b/tools/testing/selftests/net/forwarding/router.sh
@@ -337,6 +337,10 @@ ipv4_sip_link_local()
 
 	RET=0
 
+	# Disable rpfilter to prevent packets to be dropped because of it.
+	sysctl_set net.ipv4.conf.all.rp_filter 0
+	sysctl_set net.ipv4.conf."$rp1".rp_filter 0
+
 	tc filter add dev "$rp2" egress protocol ip pref 1 handle 101 \
 		flower src_ip "$sip" action pass
 
@@ -349,6 +353,8 @@ ipv4_sip_link_local()
 	log_test "IPv4 source IP is link-local"
 
 	tc filter del dev "$rp2" egress protocol ip pref 1 handle 101 flower
+	sysctl_restore net.ipv4.conf."$rp1".rp_filter
+	sysctl_restore net.ipv4.conf.all.rp_filter
 }
 
 trap cleanup EXIT

