Return-Path: <netdev+bounces-202874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A9AAEF825
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9177C18874C2
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EA61F2B88;
	Tue,  1 Jul 2025 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HmaiVWML"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F7199E9D;
	Tue,  1 Jul 2025 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372347; cv=fail; b=DQGn4AndhpgeE06pkWKgZifnWV0SFVLw+1rsGxazTEoCFCtJQe8gKDVqaO7B2zm+yOt2IJEXNVOo5cPL13nogjxm8fo1m5b9Ee9RKGdf5ug2/sCiPQkkPiAsuPFaz3TWp/TtpWwi1+JKHlv4KLuJlSApkVWUnf4aOacNmRB/1dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372347; c=relaxed/simple;
	bh=JYPfPhcpTwB8cdibqSVR8QNHMWQQZMF8XUtViMxg0Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vDGeLDNeZKOx47HfH1BePb5XFERdtpwEKtpMQ9sUbeVWpCqmyBwh4rZscF9CcQ+vfh0cCJgVblnup7Dkg3hC3FLRHNlVvxyOxsCyaSt8xKy4eLBMpp4YMOJrqFpu6EegC76nQf2pbA5sX2UEbRbgo/XyLTpsLRnn5GGV/hz1+ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HmaiVWML; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBWgT7sdz0KkdPj/TqThjxKow1/Jn05sfFjGPSyWtGnNZ//NvCXRu1PrPgdc7YvVMz8SeBYY/9AdW8Fc6fTabxd4g1rV/Wq8xIRPgaP/2IxbapN1S/mHqvh1AQWuR+fH1jYxQ04PPd443iCk905tvQAPWtSPUnzF0z5iSe6PILflmJtc7GOzdiZ6xK3r9UKfskHdIOf5oyqujO652egNyNLnr99rUbkj1y6s4wtLcqEYzrVAcnmQNiBP1hXHtupjEYuv49UKZEz9X2SGretUDt5Pb2s3Qz93es+Ija26Wb6oRGrco60CZh5295K3NMI4qnqazKQqYTmEoA6XGpv3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SGinEJgwMKmchUXQ7olrzlaJ5JdkKW9t/5LPAK4dTs=;
 b=WJWuWoEn8Q7xdrIea2UsEQpMo/mVZf2tgdGPQ8JbjrXXKT5eqXUuJjnSN3I718VJB3VZjdLorKolOd57DDyTn+MHSdXTfLFnpySa81Lf8hlCNb9AXPTdjwjzVkJpMtmTNgt1Nw9pfntxM50WC08rZXHU6XRAstaNTUmOeSfq3QnaJPnDe0hcqgyqnqf5Wv6+IfZE9hm1OS6Kn4QxvVHUeIqw8mC4gmb0Mf/KOeJId1LXJSLiBnMrODl9cJQ1bQnfowu8z2TbV/HgoKJA74CQHqQW+stHAPQaoNG8WtIOfbyqmXCp5UAMsceiL9ZVXTIMw2t2+Y091K2XkcfXQOgj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SGinEJgwMKmchUXQ7olrzlaJ5JdkKW9t/5LPAK4dTs=;
 b=HmaiVWMLN4FBJYDvWM5/Jj3ph5PRAnT6UT83A7xnIFRI0TJm7OuXKQm8/jiPxX+sNhmsuzB80Q/zcq0zekr2vFRQW0cAYZE5C4Vzm9tDHrwDNpFHN+KBcqzUcIYjjZ+WVOVywXaW50Pv2RlzE34eQOJY3AivRbkHowgbjRIgIbfPCocALNzT5G4umj+BcsLzK9okwOPrwsX/C7Xh0GOOzCk1y6IxkhIni7W31BA8EGZ/4rx02e/iPU3hr5D6A99VAgWi8Xz5E3bO87JwJJX1e7KQWN9FrumB1pC3YbFIBYM3DvWOriAgVvxDSeE0IC+klzCvik3+0Zg/5AhLs9QBCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 12:19:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 12:19:02 +0000
Date: Tue, 1 Jul 2025 15:18:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ido Schimmel <idosch@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] lib: test_objagg: Set error message in
 check_expect_hints_stats()
Message-ID: <aGPSFlt0ZXN3bJ45@shredder>
References: <8548f423-2e3b-4bb7-b816-5041de2762aa@sabinyo.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8548f423-2e3b-4bb7-b816-5041de2762aa@sabinyo.mountain>
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d36bcc-44c2-4804-cc3c-08ddb899772f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PrYIG/yPNG5azxGIrTMlVKNmz49AhnVDHsondkkVsdgPdnTjYhsLlGYTcz9p?=
 =?us-ascii?Q?gXqty65bO7sylTIeDWL0SVWSNnOqAgbkNiZX4KpBDXj5h1DPZ6w11sWxkH2D?=
 =?us-ascii?Q?xTwPXqBWZVd55ozLelSW2VSMdAowiwdkwFD1ysEBzsKOPZKPEGXf74vtYu5C?=
 =?us-ascii?Q?jQLsULiSy7rwVviedWaQ9aJxAg0RCPC6AAlQk7BfnV/tHJoDw0YYfWx/gcbK?=
 =?us-ascii?Q?QSUBg6OEGktQNMoKktDSRhUiVCYGekGAjTDQQTUDJSy3uO8ZdSxZwbCLAVwM?=
 =?us-ascii?Q?UB7TCHkueqzHlwQtGakIcVwxABx0CwjK3axMKkInrlXn66oA05MGaoMOmP+6?=
 =?us-ascii?Q?5DTiRC3v0AtKkT3Dws2f2AnPLa1s/eodj86PK/Ykjrw71UNxLul8y3Biwqsf?=
 =?us-ascii?Q?BSEASvqCBrcw24Sqsl9T4pHo697ESCJ3flUjmT2iRGbPePeR7R/+Tu8qGJrL?=
 =?us-ascii?Q?ExjTTAoS0ENr/BOOEelPbRNkwL8HCsJ0fWikH2LbLdPfre74B5GalC10UkY8?=
 =?us-ascii?Q?giiFN0TZXvg33GZ4EG8ccPFAkp4zK66pxuk89Ks8dcPLhg7/3xWIXS6Y68Nd?=
 =?us-ascii?Q?Yq+DGTkkrRpFm8ItR2pwMnk8l6qOo1LQDPgPR3MkTMgPvF7r5Ey1Pi+lUcDZ?=
 =?us-ascii?Q?WPeY+rR3dJaQ+m9GXREj9LG4E51RD7tkF9mrPzYXQuCg2uMdoRtq+Ul/N/BC?=
 =?us-ascii?Q?JRia7mea+54qge8gKyeSfffTSDoWxk/Dc8MOSjtT0RhVbp2dBajd1U+jX7dJ?=
 =?us-ascii?Q?2dsUI7ka7wOfyMy7ti/Yc3eL6pNfQtNW2IMZI5sykS9uST4FZp02vi+N1ubh?=
 =?us-ascii?Q?dnQrXr39J/cdO8/UmGeDwtotB5IAli3ktZl+4tTbhJGOhqDZ2aDoUKERCnGV?=
 =?us-ascii?Q?P+rr0y9GODhpTbXU/Sox9EIsFnoKhMjqrj/MApH3Ou+1Hs0u7ViOgOcK5k7o?=
 =?us-ascii?Q?rzStT7PYc8O1Zr+VDTZ9E2Xsu7a9dgP1E9FYLnkt3l0L96OnzKVrzlr2hlrL?=
 =?us-ascii?Q?F8d09nCruAYWZzXFavrBm+C1Hzbgig+Wm3j5GzQfKxas+TrP2aZzfyq/20uI?=
 =?us-ascii?Q?3JJRLtGJtE8JfHvMamCTvN4/oTBLB5IYbW3NRs7UZoYxM1r4KunePsOhYk9a?=
 =?us-ascii?Q?XrFsYYWOS61hEYUx0Fiyr5NtvOOu3EITaBOq4AoXjKwGBiqvfrYAmz2+k5bJ?=
 =?us-ascii?Q?WvDgT2zQwo+JO4La6mzZ1cn9151BVmY+RCjbPduw2o6BAP0peBc1EPSw+sxk?=
 =?us-ascii?Q?uqKnk+8VOYaNEOb+MgfiIZytZC/C65U3mJ2QUyN4i3w9UMDswxcQHuKw9KhH?=
 =?us-ascii?Q?FSDzKiMygEl35DdGARPp3wcSQ5kaHpSS+bOXE5i6OLlz85Q8VRDpQEx309Gs?=
 =?us-ascii?Q?Ss0cami6DGFRROwB/rJl3PRieCRROZcmsFA2ksVpw7HhmnRz7epwvR7TA7h5?=
 =?us-ascii?Q?zVDQjHOKajM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lAZtyM9mIgPqkR2KfCTMFzUKSXI/xXBbGG1wQUndAEZTYR4/TJYISoo1o1fr?=
 =?us-ascii?Q?ZHTMkXU/L3mJjLxKg7XP+C8+wwEEeFKd3Y6zvTcos+5G7pGD4/U+0m/IVeX/?=
 =?us-ascii?Q?YGc572gGDJwjRZ4AEQhNAsadzDGXK6V1dx9t7pA0+hAiw7GUD6eOHvmgAmw5?=
 =?us-ascii?Q?pBmdpl4WizU6U+N414EaVBpPWEeJViGsVdK+8WkbejJrriV49hSnFuwfnATt?=
 =?us-ascii?Q?cmyP5ENT8DrXllivkhx3CtgoxaTUqG763e89lLPW3uaJbLq2ccl2mHi53cjI?=
 =?us-ascii?Q?hXPNeiZhhYX08iWPpY1vaykZAhaZ99E9IkLsxUvnul3P3b0QmvLhM0qzMutc?=
 =?us-ascii?Q?A9FjinwtKRwlzWjbMARf86QG8Nt7AQCwCnDkuwt/PrSE9Gy/sSrHdMBB2f/u?=
 =?us-ascii?Q?I/qDK7Q914t31mqEWCS1fLy6gw8hxUKFTBqMew+JAYZePH35IS6sGEw7Qs9L?=
 =?us-ascii?Q?nKN/9SESQTKL6M4TOosEc0cgzXOy6brnJOl7sR2qDuRd05tb0RqH7xUkGNQW?=
 =?us-ascii?Q?DDd/3cNidS/7y150QXZfXN1HwVlwbK/HEoH0yXKsqEsP9HgYgnoPU4M8k0gY?=
 =?us-ascii?Q?/h1UTMFgnVUre5vBwYqe0UF8PAKJ0pkFvyY/N5JLCIxWiYz2TH2T3EPqjNL5?=
 =?us-ascii?Q?AXkQqBoV4ChrviXEPIxTlKRKAxsSHx45cJrQKTZa1VxXcVzhfx7/DbBWW9cf?=
 =?us-ascii?Q?pxPMRf6XVJDiXOa3/wzj4bz2qGyIucj98RaLAf8heFL4GQustw984qcT6vtR?=
 =?us-ascii?Q?xRD0v2qwncFRQbuuadvCTcXcSEYgWwA6fx/1nDP3tJ1J11nWgqGi562HxqHW?=
 =?us-ascii?Q?ftjXWKaNAzNOwvZ3eoyRvtDidkCUHy6fpJ10Inra1/Ii0k3HIXudXGH2+b+f?=
 =?us-ascii?Q?W3PYauudTEi/CYrKEA9mu+Td9v6/fc6pSy7Q/QM6Sc+J8dEXWMdUOtFPTEUi?=
 =?us-ascii?Q?pKLrwYJygBbvk3Yh5K/yOZM0OJ8O1dzM/089XB1G0xwwh9B1IU50TAbBFHL+?=
 =?us-ascii?Q?PkWS7Dp9tTuiyJfp46zfaO7s8UdmbEhSmVmKLL5y2vOli6oCvptTwSF0g8NV?=
 =?us-ascii?Q?RgbM4+AW1dhPMhVzrWNVt03InCFDgPWK7JChhk0lqlr1Ydce6JGA6nwB7R+9?=
 =?us-ascii?Q?6eTSR001cy4HIkqUsxgEFzIL7eUa4CXxPnWHMhYbZqNr+SwEmFmew6v13H98?=
 =?us-ascii?Q?yK3h3ulyQDisrzMKw3+bBed1WjdttwjiB2my+mZHeCstpKGBy/62MPb/0lp6?=
 =?us-ascii?Q?VZXDswWb+tJA86oJX+Q4JTViuyx0DFnf/guBJz1c4rHRrSXGqLfbIXDdA9bM?=
 =?us-ascii?Q?m744gCkD2IxhYoJ4er3TMd52kqcrdbc6ffBIl2+bgnRF2KhxxDddXmAgNCyP?=
 =?us-ascii?Q?Z7kVUfutqTwA9EBpE7JC2ND5ZRKes/j20RRqHvq13PX6+ejbDmeotQ5GQXjF?=
 =?us-ascii?Q?maBpLh+GQc+Tq3fiMWW+BEH/o94o6H9iKu6eju3nURrbGYWvfABr8lcPcGzU?=
 =?us-ascii?Q?xaTAe8gWckxyra5gBBabF3Jvhiw9RFx4BdG5Gjw5+TONcpUcO1FpCgP02U1e?=
 =?us-ascii?Q?25hDlXnjRFbLR90fT2yMMT2S8ub0Pg4Jk0lY8iGZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d36bcc-44c2-4804-cc3c-08ddb899772f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 12:19:02.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pliKD9mRQGhPxFtLjwdUzEFphEsE8i5/DBY77bRGq5aKveiANnpKwLGx7uV8dOsFZoadTlU//wowRnSVXPXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496

On Mon, Jun 30, 2025 at 02:36:40PM -0500, Dan Carpenter wrote:
> Smatch complains that the error message isn't set in the caller:
> 
>     lib/test_objagg.c:923 test_hints_case2()
>     error: uninitialized symbol 'errmsg'.
> 
> This static checker warning only showed up after a recent refactoring
> but the bug dates back to when the code was originally added.  This
> likely doesn't affect anything in real life.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202506281403.DsuyHFTZ-lkp@intel.com/
> Fixes: 0a020d416d0a ("lib: introduce initial implementation of object aggregation manager")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

