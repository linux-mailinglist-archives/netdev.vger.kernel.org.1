Return-Path: <netdev+bounces-137860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3109AA22F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10006B218D5
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185EC19CC0A;
	Tue, 22 Oct 2024 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B9zhQxca"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749DF19538D
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600538; cv=fail; b=pWVXKr+H4MEK2+8J6tkr8KipYoOSLxn8z6OI7+gnIKHdSOXVR2zVzYpJ2igTrwkw9GHJNKmRRQHDWdDse7AWu/S6pg+W4t9Fsu/Vaqi6NddvKhIy/X8JzcUQYvjrBCWx1+7UP3CcLL1CaFwxD4p7C2dNpBiKAxjjx0cpmNQiVwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600538; c=relaxed/simple;
	bh=4kAm7B57rljpgv3vhD9XijAU2kfsdFlixPI3X6qMvYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iH2MnltVVwbMdO1W3bf40vjTHOqTVIpT0L0b5j7zZVWNjBhBGHgrdUZfTi8eWNn2jlN3qSB4FWCF+mHYvRwTwoaUgO24gFifpCkZfnydgiM17bwQex4A9DtKNITxt7k4ZVxLDz4rwmf6Zz/Eu2gfS7LdH5PGvoo2tjE5TXEh5u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B9zhQxca; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hP9t3QgDRvw8R5DzAapo/9vxQ1yOnECpZPE1cByFgaRRH98ZVnwyJNTiRAIm0i9FZYWff4rNUS7lMWEK8Q4RCgeTbJUqUYhiAhHP4PNlFSQ19sfeQkI347/aA88zP7p3yT3Q84o2MhzoXd2n4u3nD2wrby3aw6rMX+mQXNhVgx7D72BLUxVDid85gTjsWj/0DI45OP2HqJFFTJqOnNs7NfXERmpzI+7ckxSRzl2smT/lJH4s2PHUr3clYxPUK2WWGvfIG897XmF10WfKQE/RjA3vszIAboYJnktwhGQiJDqw7/Wn3oQVRA7KLgW4SEilcNI0TCIkx7NrDvQfL1Z+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYeVrxZh16ndG7mBL2A/Ofzq3h7vOXmD9hafKA49kDo=;
 b=wNk+0rNffUKupD9WGtieVt6mTIFLBv5Lfe3qA7u+JmWbHOKnhvWBA3sQU3carak9cmBjkQCu0Fo1jH+CNpyKhRpXmlmixpYp6RTApDJc6C4g40ZoCeB56SYY6HSab6iHfPJQkbycK/vhBLvVWb8/RROh1eHCteL4GYiJCjiwPLLtvFuXEJMYC9DjtvgLrfi5KEhx/GRoFoAxJhbTAj24cJRhb587882WHICX+Qr09HfRTjTYRm/bQ7Ztw5Hf1bixt7AePfvbUjKNDh0Gq+8gvoubtiUSUrW5qMc8ntj//fg+nbeazD6DVns3GifuzZ33JpwXthCFZ1IolzWzjM4RtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYeVrxZh16ndG7mBL2A/Ofzq3h7vOXmD9hafKA49kDo=;
 b=B9zhQxcayUUWpIueG1GqpgCnSV+8kR7O0bzLZv22wurk4im55TSLLZ4x/esozW6cRwHBeKCQuJNRsOH90Sd6ymH5qNKfLmVsZ5nfmCRDnHOLeLUN3z/ZR1WnGT9uprpU15Bhu68UMatSPH6ADUVix5CGeJjfkEN6Sp0NDQ7oy0EDQhs2HRFXjbRaANskui9fARa3OgXCO12PKmAq51OK56JtuuqbccfWY2u9aRMNscN4rRrz56rU9A6l11PGo7l1EPLgRLYbMWFdf1uKl8l0Z6VnzQn11zTYvUM1xZshNSyBMEk1Tu44QpVMwFZf4txj6YqFX8Q3fqBuWH3ZtjhXNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 12:35:32 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 12:35:32 +0000
Date: Tue, 22 Oct 2024 15:35:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next 1/4] ipv4: Prepare fib_compute_spec_dst() to
 future .flowi4_tos conversion.
Message-ID: <ZxecCBlEvmcMxODJ@shredder.mtl.com>
References: <cover.1729530028.git.gnault@redhat.com>
 <a0eba69cce94f747e4c7516184a85ffd0abbe3f0.1729530028.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0eba69cce94f747e4c7516184a85ffd0abbe3f0.1729530028.git.gnault@redhat.com>
X-ClientProxiedBy: FR4P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a27e9d-fa8f-479c-529c-08dcf29604ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5f+5NrYXQFFWYw8dBNckDwArFcTIW2TgLVpT/CmAOQrB15wJERa6QgPSq+/v?=
 =?us-ascii?Q?d9kZArlOJSFt1SnOUTQkCuseerEkv0PqpUsWCh4ZAIqtxmHb2UdceFyYllMk?=
 =?us-ascii?Q?6aLfDp3eXNrzBJiSQQHwHNuEk7ipMCYa9MmO/ZaXvskmzTpP/o1QGprRgZvR?=
 =?us-ascii?Q?iu2an+h5jaGuowTLP180nMmQjT2ZKx8ek9EjAaxElr7qxiuQBMJ70H3+zSYG?=
 =?us-ascii?Q?oBmygIbMklO6vyTI41axyMaXbbu/SM/AO09dYuIW9VlTY/H6d9451sI4w29C?=
 =?us-ascii?Q?3DA979FG4qCVzb6RbUdUKeUn714NTkdJuW+qJCmXU5Mdqb+mXDsOwz9GceK+?=
 =?us-ascii?Q?+ZWo/jtSPHBuEPXsl7l4Krrrt1/M2wt16hJAwV2Pg0Ruk6tVRq0OXe1yr7TR?=
 =?us-ascii?Q?1VPiHm8IGmE+enzOBUlYngq1mpsdkq7khExY0VgksPfqT0CJV3hstvw+c6HG?=
 =?us-ascii?Q?MMuRZ4pxxjV4mU8Fovsg21lpZ0QhNVSmMV/g5vIfwnTP/lhMfWARdNHxrm8O?=
 =?us-ascii?Q?3CdxkqTOj9hR+On4ShKK9nOxJ+UzFCYB1JwwzjALGsk7qnupafVeISn9CQLS?=
 =?us-ascii?Q?sP+DyvmenerhHN50drGrzUdwIpV9mc+CMOL3msuLR8PiXURExgFIHi+dLhMn?=
 =?us-ascii?Q?nvGCUmgcswiWmSf1Cg0VFSQ6+t/uTCNqAYAgJbKpFu+Ozg6e1a4eZ5nn931B?=
 =?us-ascii?Q?iBM/5gS4iMI1JUWTSQigPRB06bh5pqC9F+zZ+vquJ+t8Xyk5WngWyHWRGWXz?=
 =?us-ascii?Q?0mm45IT8e3TSrkg/BLqdpl0UrJlN+s+G2CM+FcI3xmvX9qM2eJYAxhvC3n6Z?=
 =?us-ascii?Q?8U45LZWYvXz5Pu7N08yucVCJQFzCijisPBnauUU0rpSBBITgpoeVVXEta/f4?=
 =?us-ascii?Q?NJnWg+b+ZqxLPF48zcX6DaL+mE2SxUJ+rbHWwIeBO0YkVTMC0/++vwuLEt2v?=
 =?us-ascii?Q?BgEGEXEx4tAiCLwENODiR7lv/lTtDWW1TVJYBUln0eN9UteJoeJsUmB0C+s4?=
 =?us-ascii?Q?RDD4SF9PkLnEti/hlWN6IxDsn6Cnw8zvfxJgdOWSBWg2bjKRPPNgOxQqq3Mz?=
 =?us-ascii?Q?+ettrI5EcIQ3FThiVflDjXgwPBzGrT1qVIOU8qDkVKlN+jy5bz/7EuxFzy31?=
 =?us-ascii?Q?vpcRJIsbG1Qg5Tc4/SqMT4LOoz1STTVwl6NnCmGWl+p45jnBQ3SsKlpnekqJ?=
 =?us-ascii?Q?8skY4IM+Qc1NfAwoR2RP5PIcPFo2fyuMknBW+ts+zddhblb5LwWRAp82e/xq?=
 =?us-ascii?Q?V7tlMvQlcQGOz8p6WRWnTJXnPZyAPlmLpZ1YzIMcafhS79yAU7swfat0xj2q?=
 =?us-ascii?Q?B1ryqGbegr9Y54yXLRXh6LGb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+TZe7eEm6U5cfD07kU1SimKk2zwF40FmfW5E8S4KwQa0XPrH+L+IQEvzBDuJ?=
 =?us-ascii?Q?S7ShqyL5MgKcq/vK5Soacfd4xztbl7DG9Iuutv7d7eyyNRe/CB95mrbzI3VN?=
 =?us-ascii?Q?UzTt6PBpHG5LfraEb7qEOfk6Elwwv39CyIVoAc8UwappMFkMGICUdRt5HPiw?=
 =?us-ascii?Q?BMa1Rd3W6t6Idn/nAfQrd15kPI5TeE52yxpjye4uhdX7sQ6il9aWS7cZdv49?=
 =?us-ascii?Q?QYrW3Ub9w/YJftD+c+hGGuWpXHvEdbZfcvYHO+b8SbKBlJTp/twryeBvmqQh?=
 =?us-ascii?Q?iM7qrvlw92rUZJD5Nbj3L5Q/REHRgaBUV4eA288WLKmfBWNnaZT1rBEKPS1d?=
 =?us-ascii?Q?B34rXKDme4+D8TmpP3/nRmT9Di0vd++LfXawlhLO6mvpOX5yUwp4b5b886SG?=
 =?us-ascii?Q?3bbv3y8LEFBYl4PdmQ/hlj3pxyNnNhmtPnIoVTgYjxDkfVTx5iGOwUaDDzU5?=
 =?us-ascii?Q?Wxz/BefUgKwAFEIQ/M+gERSDZK5o0ntfoplc1McdE8D8BNULiJ4doY6LH4Py?=
 =?us-ascii?Q?D3sx5jUHXE/6i079DA3FwG0O1IH7mw3DKIiFYVAVN8QzX1ZtMZtulxBZHCQC?=
 =?us-ascii?Q?79SIUYe8VZnXKxpjg3ASLPeqF9tMhkQ1YWIVzjlU6BQHMvVJ/VQ++ZObbrrU?=
 =?us-ascii?Q?ZjvDwPoHY+lQ1bLK89cp6ChUyDFGEfWLPavU4zjnm6NReRYsRmxTprFFyO0D?=
 =?us-ascii?Q?fPcuWN7G16Gp/s0ahKeoFI0gQ83bKIbcDbenKuVjIx0Qop4XAEOR/fnjLTIZ?=
 =?us-ascii?Q?BjbFdl05q/0ykf1GxiIHy3TMWq1XZKIr1sSGJztZFFd1J3hJUaklnK+K9RP7?=
 =?us-ascii?Q?PfsOCCuSnzCKPWx0OMsAP+UojKy3A5Kyp+PV6Uac7Nd3B/uIaRLIPbtfpwfR?=
 =?us-ascii?Q?UiEDsEm3B7/X7GU9AiPkJGzZ4/inlTU02pbowimNWFAQy5pZjtCKVuBfWy97?=
 =?us-ascii?Q?Ro/dRQkhy6PjGt7rJZJCrVPj+dmX4lp5jaYZ+BBW+a66+Sr+gpS78/TDgM9O?=
 =?us-ascii?Q?W5OVcM0NDZa65auMIWTmS98BZTAOUAge6h3y+mbFN9om0NcV6lSuFHV63QtQ?=
 =?us-ascii?Q?MVwODBgs7MXBHILyaQvOZyBAwLoAhKGTZqqj+Qd9ueIdkczzrVvzuwPLdNzy?=
 =?us-ascii?Q?BdVNmfCT71QP/o10hPzKk1Z5mlLeW5Wb98Rj629gfmbWsdpa6/FguJTAlpV/?=
 =?us-ascii?Q?JnncIZ99T7BvbTWEjEY02tPKLD3/8CbTaxkZRqL+mXQ7lD/zfJtjnoWMbq04?=
 =?us-ascii?Q?tYNqDxxGCJlK5LkpaYOCUJkzfZ61mE/OsJ1KBXnjZqzv/IjH1FbicLPKxu37?=
 =?us-ascii?Q?SPqXz0IJr7sz56ObDNxgqpVC78yhPojC5AxERyZIZukS+Fw5RJOuqNbktdGr?=
 =?us-ascii?Q?MRzas4Yqa+Gz/QTRWf3SXFqR30e6m1RgmQ94DMkpOaBK3CPeYHjifJDs8rwN?=
 =?us-ascii?Q?HZ2l2mhMrrIUKjbnA15n41v8CWkrirgsb0k7hegMjjRRwgXV1voV6q5bGZsT?=
 =?us-ascii?Q?69dOFq1+w22Knr6Ia0p2W+3JvlNDBFp8PgDsQQNmt9Aq/CVSDa66DJZibtUD?=
 =?us-ascii?Q?TSjS1MEQV/l91i56Ncs3fowsDxEIBhg2NbWwDyvq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a27e9d-fa8f-479c-529c-08dcf29604ec
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 12:35:32.2738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upLwAetdb8CRTfI/O4GT4u7ZgBRbHYsPb/JQWp1vJoUuYLfU/Lz2Zo+S9Z1ZgKtp8S2Xn3Jd1VXni5mlk4aypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065

On Tue, Oct 22, 2024 at 11:48:00AM +0200, Guillaume Nault wrote:
> Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
> dscp_t value to __u8 with inet_dscp_to_dsfield().
> 
> Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
> the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

