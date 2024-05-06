Return-Path: <netdev+bounces-93637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 039478BC922
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614651F2254A
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A9627456;
	Mon,  6 May 2024 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W7iDynlz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B588BF3
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982921; cv=fail; b=VYTdtNTRc8P2TKq/qQffEsuR65Y/Ch8g6wJvUdmhOyKVT/LRAK+TnPdBL+R/UvMBzx5Q2H9sDUunxQgkc7QHbDq/hqENv1IMdkPDDLos1yOlRFBeIztQJGn1qgMQTEBACVNgJCzdcdaqlsrvVTc3rEKSMO064VVz8oKv/spZIs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982921; c=relaxed/simple;
	bh=tuZVjXynjAM+OVdHmX0Ml3MWJCJQOAJPhkJHZc0+wYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klGwNxxDxRxd5RODL0ILYEtAw+/fv+tOZnu6WWJjugngB3lqmdyoYuBsf0U8vR5YSaNCTTUn7jfSFWp9kE+AswVomZ0W69BpTHrhhCogY996ImvJQ4hxAd/Ygbr5bCnHLREgl4EOIN+xOU3AQYpui2icw8Y5zlns6jxQ+G8rvHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W7iDynlz; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T09QmOWnZIJ48a9S1PGWkD1nGB+t6JyPCyAlvi6NlN12zRowt5Zv+COqb5EJQlCKfBp1cuuilNZ20xJ1wZGmEDOMW1/I8Y/rNIhPsV+3zUwpOEsdoc4F5H4cKb9auH9Xl8GVIEj/ENEHFH8lwykHYYs2z426CuYoo2aQderuOp/4HdTgf0pEIEDMdcUPULwL912vMDIftgIdv3pGN2MPhcc2tPXWYklS1llbA7KV1DeIY5qAUX9YxZSHxvlZ4/G2XmVD5V+vUs2vSdM1Uiygt3t1PsWVi8xTjL/DHT6XyFtNaIPred4CPyDF+FsattqRuPSvzEdmmUTwYDo2Cn9k4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9Zf/lQJX4uTHW01ZYmtWhWQuieKnY2Cgg1dpcLbVho=;
 b=hrUlW53zjmXHrzQ3USgyqxUEU1Sts03SaA9zjcm5seqycBQ0OKPSM34ZhSmSmQQy/G21LsKvGEYtlulYrnwOIj0G4/umYknKGaWXYrDLmxCZEp0xbDAfZOg45RivHASHwweNYBUTRRJxD6NPgWRQNv2o3gLIG5Oj+bhvrwMit+pg0SU67Iwe8M5LZ57HlL8AhLTIm/y86pKLZF5+r0DkLHMQEYsWpw/KCBH6UvRA5pP9hSuzTguaQ+V7aFuQXZDDX846FQ0em1daQmxIFWrv6cJPPLhHRfjnyE9lbF0J0cGO7XmqOZEVm4S0t7Qc/2E3ui8DgzB6jrlKnmhFZIHXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9Zf/lQJX4uTHW01ZYmtWhWQuieKnY2Cgg1dpcLbVho=;
 b=W7iDynlzxYBzcJ5CUshH2GikS03k35a/t6wv6ssA9lRLYu5cRyyzPoJvvkm3Is/nMG4BVWgQmUsFJaRBlqWSsnhRAwY9dLk2rYloDUyeaqEylAbLSpTF+HQWwbViBs6SnKrur1IBNb6aOZpI4PZbu+pCUfU7prDHx6ZWYO8YlIadpVZUySVxmG/OF+GM4OhqWIV51XrqCZpct96FOPO9aABT6zmSlaR6sLEU7EQYiyVRuHq8sbPhS9FUS0droSGfCo53FtJo7cyoZoHfGhRjPXwzNJbfwVgGxSRj8CJbzTioIDKmymu1JlJRcPOrX+oDQqRfXzi2PBRpKvGdcGugTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH8PR12MB7183.namprd12.prod.outlook.com (2603:10b6:510:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Mon, 6 May
 2024 08:08:36 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:08:36 +0000
Date: Mon, 6 May 2024 11:08:31 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, razor@blackwall.org
Subject: Re: [PATCH net] selftests: test_bridge_neigh_suppress.sh: Try to
 stabilize test
Message-ID: <ZjiP_3XiXJ0CoChQ@shredder>
References: <20240505145412.1235257-1-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505145412.1235257-1-idosch@nvidia.com>
X-ClientProxiedBy: LO2P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::36) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH8PR12MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e99e77-f3fe-48ff-eba7-08dc6da3ba87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eCDIac+4nxN10G/zFOW9y1xtYyDrK8QBA48uNU+4hLOoUnixIGzSfVloXyt/?=
 =?us-ascii?Q?Yu/AxLx+4tE3rA8nAGBiNELYgbsqDc89x8G8Gs/Xo9oOX+0EQyJKkjZqjXDI?=
 =?us-ascii?Q?F8e6FzlZlXFqWkV1m7rSrJ9++oKBaRb8rM58pSod7hyCb1DQriH+Z8h/chtN?=
 =?us-ascii?Q?HMO8O50VOcONadlwQs3q2EmqyR3KHH3r9sDaGHzYitg7rTWjREAPZWNFa6N5?=
 =?us-ascii?Q?sXSFVPbxPBJl7i58EnXiEth0M2kBS6WqErcPgsXlOIOINAwutaMYcgbURcaF?=
 =?us-ascii?Q?bAQXurla3sA3HE7ftN5BnJ8QR62VYVElVoaCONLbXNUOKy+uDHgQq2MiUEan?=
 =?us-ascii?Q?yM7z8EwyD2vf2zOpcvwuwZuy8jEeq5wBK6W6mzuYrTIIhY4bAf/qkD2PJ5Cd?=
 =?us-ascii?Q?7rFQ6UQuA/jaohh0UAD+1cotkPH27hczn2bhrsoYHf9xT8Jd3IbFA+xMYsb7?=
 =?us-ascii?Q?Vp9Xbs48UJdSztwe+L5frtD7S+IH6v/FtpSq0oSXU35KBU0sBPYl5R3DcfKQ?=
 =?us-ascii?Q?89UwrR840Nz7IhxsTtu2gYiV3Z4jCstWU5/d5CiXJn0J87HmqzvwRXNOHvvJ?=
 =?us-ascii?Q?zIdCkuFTi3Rj5x8np1juxdfHt4gqjGlMErDPHTdFRdhef5t97k9Ajov9opPt?=
 =?us-ascii?Q?Vd7Ebykv0AE03qt2uTJPppesTtdalron+29kNxYza5zRYtXrDeDne8HyQLYz?=
 =?us-ascii?Q?zUbl0P7LjjMdKYoN7Kzh4e51GrAI3kiBv3n+jiDX9D4hAAGtaLl/yVEff724?=
 =?us-ascii?Q?mwKOHoXp3OkRQt8G7nePED4j7Hl7tszDumsx9mFY0GcylCr22+2wXId2NsLV?=
 =?us-ascii?Q?WXFtZwywtYa2Rr1Z+GLg8r52Jam6zC4bbYS0Q/YnN0diySpdPtCQBFjx3k+v?=
 =?us-ascii?Q?zdJr300gwMGWxTJH3ld3FoNFGpAUsLF/CflQhVWrZOdw+SSDl9dSlvPZ4txx?=
 =?us-ascii?Q?zYHyQTRFxBKQGqYb/TChDwEpPew2FbOcMR9oRafctgq/pIQT5UphhnaQM1/C?=
 =?us-ascii?Q?4HjqIGz7uEHJcNutqh6Cq73cRnxjhdlpRIfjMEI/ipK28rto71wnkuuhRGQV?=
 =?us-ascii?Q?TaRFDhIczfT/cPKkDrGhXKhl/U2/SoXZIvoHEuglGnrUy7oyF1BA0kAY4bYk?=
 =?us-ascii?Q?y828hrgc3zuBHh4lUxmdLyLGQuonVhMp/XSLdQkxCHUSV0ODeprYoHpZ/yRt?=
 =?us-ascii?Q?Vvs6gJZoxJTJ+Au6rkty5syvDnWXhmp8uyAyjxGTWj+Tl8GmYaAVyPHnaX6l?=
 =?us-ascii?Q?CYAZPlNf2hjPGYSbWBrIJE2qebNi1lIKEs0uzRPVZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MDUOQ/rTlX8n/uZF8fKPZw0nxVLErK0GbNlJph74Ci/zou16r0tg1Z9COuRe?=
 =?us-ascii?Q?C79hTKYnJax7LHLZICJ2dSd2XBONJip++aQS5JDYEnCgH3UaYuf+oo7Qke1s?=
 =?us-ascii?Q?iH5hIdpVi7bwh8uXKdDzDiZC7ndhdHWInpHfg+ENEqjt4e5oEUbfPoL+kMcT?=
 =?us-ascii?Q?lTZ/wM3Zb5CBbGb3xRJgPE7SCrf7kECuyxLezIf1+w9H8ZJKrdnQupAV6Jdf?=
 =?us-ascii?Q?iSMn+KDgiMHjh1B7Gx0932bVyBVqRowHs7R+qGJY4PwjVLRDfdTxNXTkpYD/?=
 =?us-ascii?Q?gD5nGnm9xEw4xuuiJlYrXkCldv2FAOi5212ZJC5+hJl5iypv08tmgrzkfTnM?=
 =?us-ascii?Q?iIsvLOxpjFj9yRRg0rEgbnKh3ioV6KIEs6bsegdC7VP+Nmee9nJDLfTUdoTs?=
 =?us-ascii?Q?HHXOYHZ2ye2blOsuFMbe2ozo4lYDub2d8bu+uMwNseTTzcais4P9zycv1IRE?=
 =?us-ascii?Q?zu8nB4ZSJiorPC3KpRROZ4eiPrpxwGx4T5QimG1YK+WpOjzwDqFxoJByOEUb?=
 =?us-ascii?Q?e+M5TAa4DbaHbjvTLISELSCCPoupSN52InG2Xlxh00LrzKcCqxp9NKAphWPJ?=
 =?us-ascii?Q?RapnQuzcaqVqUWGXllmEeClTGxprrJTK5VB4uDuc0x5r1uSoMMKpxEJcF13O?=
 =?us-ascii?Q?NtodK1PXSJ4H/Dx7ju47soOL1jREzjKLUKh15PQDM2QpH+LaVKuuq7VzNHIn?=
 =?us-ascii?Q?xeZc44+zFIPXshhtSYNqBdo1h7nkHP7KbszehSnc+FpIwc27qSrTHfDJUy2n?=
 =?us-ascii?Q?E5+jEn4WvF8nE1JyQKWToVg2JrpB9B4+OKNwQcEbFbmulk2w1Yh+C8uuwu1Q?=
 =?us-ascii?Q?d+HNAyzgYCuFF12WBZh3mjmplD7plC7f4FobV61YJTSlP+v6SFKerChVtetU?=
 =?us-ascii?Q?9cU4rrfFam8y1PxDJpj1zEseXFy/u9nIeU8JGURjTRebCRlSAIRzix7J/Jgo?=
 =?us-ascii?Q?+eIwSf633ho4VnfQaMRmR+DKZtXYH/mMyJiYW0Y56KtYbbdWNn7sh4NjflD4?=
 =?us-ascii?Q?rk9mMv2yLIUCAJuscLeiq8kwSOlmAF34T9nBTc3lxZYwV4RoaHoND3JNXkFi?=
 =?us-ascii?Q?8E1S7UNm2RoLnHrONPdgubtpoVJwtJHB6nZYDELZ95rbLRybmbB0VDSY2Kpj?=
 =?us-ascii?Q?N4iUbmC17STPkWkD8g9TnLdDJyEMlv3/W4PEh3ZP37MhcE2XTZDxCytGsD2V?=
 =?us-ascii?Q?1sj/K1494WIrnvncZvfNj9WZDELu3VtjU6RL2o9uw/dvkjglFlgJuV7SXKqG?=
 =?us-ascii?Q?/Hyj+TngUSVf2a38Cl7wRTtclmxNvoLHppl0GJR1CZG11r3rFmU6giWAghXu?=
 =?us-ascii?Q?FrCziE0JxPQr10ONetUoccqoqOu16g3PSS4fHBbGhGs9LWtIgpYuepGhNmyb?=
 =?us-ascii?Q?yujHAQXM6Xd2GQ5tn1D7fg/OgSJbcrV6AndUxsiZLn9jXCuY4jjdzwgZ+TF8?=
 =?us-ascii?Q?0gGPN3fJy0OB5yAXP2H/LtsMRkVCL10HQ6f+mkfPVfJaNLq0UFSy+FPCfVUD?=
 =?us-ascii?Q?E8IgZ9vuF718dTsRiUzJQzezJOCZDmc8upGEHKJ+HTUq1rfr9n9kAcTFr/pS?=
 =?us-ascii?Q?Y4wdDo5kKQfjsZJ4GFM5HDjHxb2WgONPwRG5DErU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e99e77-f3fe-48ff-eba7-08dc6da3ba87
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 08:08:35.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+S0R2WyHkJ9Ge5/7Tu7CxliP37qFZWFzJgTNuA8Y5X2k8vaCoHL3ZeWYPo24LmNMwKbU/yHfNGPVWVJ06GkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7183

On Sun, May 05, 2024 at 05:54:12PM +0300, Ido Schimmel wrote:
> The arping and ndisc6 test cases sometimes pass on non-debug kernels
> [1], but fail on debug kernels [2] even when it is the same branch that
> is being tested in the netdev CI.
> 
> These are the only test cases that are unstable and the only ones that
> use a timeout. Therefore, my only theory is that the timeout is too
> short although it is currently set to 5 seconds.
> 
> Try to stabilize these test cases by using a timeout of 20 seconds.
> 
> [1]
>  # Per-port ARP suppression - VLAN 10
>  # ----------------------------------
>  # TEST: arping                                                        [ OK ]
>  # TEST: ARP suppression                                               [ OK ]
>  # TEST: "neigh_suppress" is on                                        [ OK ]
>  # TEST: arping                                                        [ OK ]
>  # TEST: ARP suppression                                               [ OK ]
> 
> [2]
>  # Per-port ARP suppression - VLAN 10
>  # ----------------------------------
>  # TEST: arping                                                        [FAIL]
>  # TEST: ARP suppression                                               [ OK ]
>  # TEST: "neigh_suppress" is on                                        [ OK ]
>  # TEST: arping                                                        [FAIL]
>  # TEST: ARP suppression                                               [ OK ]
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240426074015.251854d4@kernel.org/
> Fixes: 7648ac72dcd7 ("selftests: net: Add bridge neighbor suppression test")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> I'm unable to reproduce these failures locally. Tried with both regular
> and debug configs. Let's wait for the CI results and see if this patch
> helps.
> ---

Checked the results. Looks like it didn't help. Don't have other ideas
at the moment.

pw-bot: changes-requested

