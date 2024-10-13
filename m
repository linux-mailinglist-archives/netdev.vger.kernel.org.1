Return-Path: <netdev+bounces-134925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF499B938
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 13:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A8B1F215AA
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F4D13CA8A;
	Sun, 13 Oct 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ReRkbRUu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965FC13A3F4;
	Sun, 13 Oct 2024 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728819668; cv=fail; b=m3bhi8uWSDx8Ct+1tCInZtum3B6KlkkT04mSQoqzMn5iS28PHTn6CRRcQYUFmjuHOSH55c6wkLpNTXjvUH/YZvzaGIDHucuAyh0JA9bMCacJFElcogbXpOTpvrUR3AtoyBm+107LAT1NQOatVTe1jI2DQ3vrVHEIfPIgxVO1agU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728819668; c=relaxed/simple;
	bh=jjgEyrjBT5C1KTmBoUfOhNx9gLPIUR9tx76WviRNX2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ft1CRjkk+rIM0t+rn78KAyjluRf8LsPoiJbJLhOr+XuaUFk6rok1ZnrVDbf+k5u089yEg4MYUc+VntTdRwFA2JNFdmhH2Y7nxsAs5sXJXUbrm68REA1zRb9eLe4mS0XcHgZXhyGLJxJUR0pKT/PiRbYBC8NKKQfkZffHH0iRFos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ReRkbRUu; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qif0lobahGunXblald4kI3n6HKD/b/Q4+VIpw+iioOm6B1Tai7O+5ypCWKrrOiikhWhEbSLdVftKBjJmDngOGXHyw69WLTFcRNxKEL+Q/L1N8ni6U6DqS9BMJE11JXaVBg1j5Wt1BVQMVHE9JoLEHIrUDz0WgWJrfNcDvMtqoW7x2Ofcx8o98DJ/DQg2CKBt9FNe2IFjLcVuEK1uyWyZUzkGGJzvjjIcbAXcXgNtQCWLQu/B4jQf2WjvH3LG9RN7eG4MxYOjpwSFAI2WItxFcG65jCmOniMoKdjpTa4FsER+P/kAKp/nmDf9n17qWMI/72ir4SeBsYnGmyJQW6kXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8hrsVzzF8UrEnuJL9Ha1aB7Tt/VUwbfKqiiZHxVujA=;
 b=WQ2QL+LKENa6PCUC/8MguXOWbD1AdCGlZw4GwiY8k5oAM3UVrQU5yh9vRxF/SEtNaFvF18zjG0VWOqt5x3JNp/NdxGNRu8O2K0fj8yrDk0scqFBx4GdR0cZTtZ47bMK3kdmjlGysLkmA5DYOnNNCwTgmdSm32i7lUbk8QbJRM5FerDyn5iHjjKhbE4D2Uu7ViR9DAKtwvBLFCltWC6g9V2nX3mDAlmEEA2VgWaNRTNtv+OHp11kPQmO/1CVYUK0n3amutjFeNzZ1zsnMoE2JYamll4mib+h2JblIrM4jMPeFvKkYdbZwjFE3r+ZB/Is/8QQMNOLbnsfbWnnKJMy0fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8hrsVzzF8UrEnuJL9Ha1aB7Tt/VUwbfKqiiZHxVujA=;
 b=ReRkbRUuoAa451KENatzZtvi5EryOz+J4NGfWyCJqdTT5blau+kO6y1PT2Z1b9ZFrFROF0jAqni9knRGq/uQ5OSqxou/hTOS1khEu9fG/cVxlpEL0ad+ixlRGx53T278rTHhYg6mvkG7FnpHiVD4kWX2ECUel6QU0TNxZSLZzzK+vGPp4oimZ3ATGt5jdOIbuCawFpO2WX+OhJf2Vix+LittzCbLLCyHZb736Gio5V7sooZP/fWAaMHUSeRKMrCW1q3B0X4lNAUYvltiHkYW9rhFvyqnU0q4aamLpniMyGmXofsFAw8X6sc+kCy/P78vPN3q3NFTI7WIuKriGic2tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Sun, 13 Oct
 2024 11:41:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 11:41:00 +0000
Date: Sun, 13 Oct 2024 14:40:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 06/12] net: vxlan: make vxlan_snoop() return
 drop reasons
Message-ID: <Zwuxwavki0lL01Ox@shredder.mtl.com>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-7-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009022830.83949-7-dongml2@chinatelecom.cn>
X-ClientProxiedBy: LO2P265CA0402.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::30) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 487413ef-e597-44b3-4ede-08dceb7be8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ydCtFOawHLYR5LlYdwXN64R9ODD+A/ve+Xm6wXxV15fv0c/vMjCFlkYVYIWs?=
 =?us-ascii?Q?x1XXI7wOu1oaCpk1fwarca0y6WKzZ78ANY471eNRKBNZ2jb8XT9LONvPEQUe?=
 =?us-ascii?Q?iqS1+eKin6UWcbEVgTJwUBjG/PWZiXMn3FF0rVlsomBXgNXQozHQvm43ertl?=
 =?us-ascii?Q?4cV1Jlfkui2cN0QYvO5WyfTBXQXGif/+qhIfTfktXfjPdCCQOKG3b478D/pT?=
 =?us-ascii?Q?tcLG+ckBjHq/P2Lu09hq6+UVdsSuY5m7Sb+/5snCyKiOZHbwQCkl8kYegDn4?=
 =?us-ascii?Q?CIi7GFDpFPct64OqDZtan2a9ZTFXOH4V7qGckalE8tpRIdfJmIHUpcQO6J86?=
 =?us-ascii?Q?FK0MWeXFLGSVGl74SG148uAL/hZMW238lglezU8nyxnl1YCpZeS+YnFsW6Of?=
 =?us-ascii?Q?wbBPk/jj3rbsyyZmowcAEoubH7snGfFF80RKVcGA476muZWOjkFd5BeBHXKB?=
 =?us-ascii?Q?1j8i0nP9TBm8L7b9URWXAvP0vtNxFBV+CoNZ9yYruLVJBR7C4UDEtUyrEvru?=
 =?us-ascii?Q?Ub2lqqtSZV2VHNPLOcoyJJIwvXP9bCUiw6SsCIYAw6w66ONSrATbcbdrov3e?=
 =?us-ascii?Q?LoB5gTN4G8LKUoDw8U3Z5gpHMSbb4JWleASLzDjuyLimYA70LvXG6cd1bqf7?=
 =?us-ascii?Q?3IIE8FDzi7XjgeZQqHuG2ePIF37AqK6nFsCiEGZyCPX81uS78yhtqNQ2sJgr?=
 =?us-ascii?Q?gMefaAMNCP6XjgDdEdxvPdojvSQeAG0GNTogR+PxjkMU4EVjVE4rVoWUU0sh?=
 =?us-ascii?Q?QJEulngjnzBt+8oogGmHMx8NjEFQQnwsYDHWb6q3v3rC9o5SwYXJuKXo1vrp?=
 =?us-ascii?Q?xs/oSgJ0EZ2/YwKf2qJAw+BidLBhpLnkAUUcgBzo+ypNXV2exdvovux/48cx?=
 =?us-ascii?Q?GS301Ozf3omtQO6bHAus8zNydAXCG+MsA2T6+EJeg2WYesBYY9e/iIYl0f9R?=
 =?us-ascii?Q?nb2cS/PmJpriDYwfLyguNAWrCrhJmv9/n2B4Mbf21gbmezyXf5U7+chO0sp8?=
 =?us-ascii?Q?21R6p6a7ozEltTvmACtNbv6iK5wxKmicw/6IooIIHXD6q56gSYoGHtWaziqr?=
 =?us-ascii?Q?uI11fVh6Fqfoaykt3j3YlX5X9Y+wbyGwiW+Do4OKvoXsMfKWkIejvmldGcqC?=
 =?us-ascii?Q?msHbz6QCg0mmlrKvYpbJ0sMoMvhepPuVO7bud5CMZGLlEEfhNn9ly079llx7?=
 =?us-ascii?Q?ixB/nqcKT8sJBwe9hFVbBkafA+TlrFlg5WzyXQho3Wk1OBoh6Gy4mRIay+5S?=
 =?us-ascii?Q?BMZXAMoK73iT5MNR2MX+htm0088nXoZIypgWk6/FKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQL2zxVHXW2plhH0caQHIQMFVo57T6i3xc/Jx+q01UpfDaDidoCMzdIKRh+N?=
 =?us-ascii?Q?eKoWW6FPOUE/tya5vylY7Niu940jWdj6vlKFjsiFJVqoUGPM+jgrIXLfunAh?=
 =?us-ascii?Q?VIg0spUy6iYETFK0NMeMJBDf2O3ftIrxMCMi+0Laqwtd5AlgTux7hfaViWCJ?=
 =?us-ascii?Q?9WdqP70zyvfzbASV6x4G0z4H0UL5DeeK2kgMX/mdmlmPGy+rPyNaV1jkOMCb?=
 =?us-ascii?Q?coaX+Duf3RQhFrQCi5IDCWb18hDR9HF02fgpOopB9gUMGOxhpLndnp4gNYym?=
 =?us-ascii?Q?uce9rzh2T5Wf7Aq4keWWWojtDpUWKpnvrilTzt9OzaBMvKqmOukOwiJAL4Ce?=
 =?us-ascii?Q?UGT+/bXaDghWtIth7Bw/GTAG7ONnDxgxqWJosK+xmSMxyqJHL+MnuuN79ZVr?=
 =?us-ascii?Q?8XRl0Eft4vawltn6ZQe8YG8hV7YOOLSgH2RKWUwlzRIGGCbstIMz/w5FfMGA?=
 =?us-ascii?Q?shoMBwvsHLlciimHeNWp6eg/LEGhDsoxz5pegYLcGYVHTbEZ2ccoEiw9tMtJ?=
 =?us-ascii?Q?5+ok8EmkB8P2VeqUbIietgTlUqUdsKomnwIbzdDfpjtA2h38v2A91xtVVJit?=
 =?us-ascii?Q?eyVeu4JtELpni1sHjDwZafCtozusOb425OSf9f3NNp8dLfb/5SLniQuJH80Y?=
 =?us-ascii?Q?9rzHGZ1STFuu4tUooWjKpQNCV2e6fbGmZRUUeqzIFVLmp5Jx5INZCJn/94ry?=
 =?us-ascii?Q?bjrytZB4T2Dgpi5qXS1l7XCnJ5wXJG2++yQFpf6VwLtg4KXnx7x35yssVGKy?=
 =?us-ascii?Q?9xZQBDY+yWXYpzLnnt5Z7WGQDdqxc3/qOctVQn3e5LvoM0CspC2hDC+n8IHd?=
 =?us-ascii?Q?fY6x/ierYGHJt91saEgBFQYWRne9gF9gDgRBd7pB3S3GTN9nhiS2MCzFBcQS?=
 =?us-ascii?Q?//stPd1pxwDbEi9qQN35d09JHDyDS6s/K31H86Ju3P8+iHlz4w4KbGMvrML1?=
 =?us-ascii?Q?iMSRtprsAXo/PvYG9wz+8SkEhE+AgGRby6dFCL88ChyOxjwKG1mD3nqsDZ9C?=
 =?us-ascii?Q?0VAE1J4hGkugmanna/2dmuwEPpC8mHcXe4jIDK4W++5E334WuaIfOxWXdYad?=
 =?us-ascii?Q?xWYi0wMVV6wg7Ec3tPPJMy7ckx/saUkY7+8/5qSXFzdIUyOO0UtKprqUVoYt?=
 =?us-ascii?Q?aWyGM6SDEQBMDdeozpRR7rjjUyWeJmsP1+5dB1KX0h08hfy5pN+e8hVHEHnx?=
 =?us-ascii?Q?lF6O4AxBiW3GGGZFoA/z3srTzRknzJza8chtT1Wq1pVIqxD9LFVx9d6YMc1W?=
 =?us-ascii?Q?zSFsIHS1TbIeD48lKp+PK3DTM1Z50CHU3ENiCTGAXn2q83R6X2aRwpFvGEoR?=
 =?us-ascii?Q?avWrkYc0mJI+NVTv58QGXuviQfeZuZh6YofYpKDMiGxeQ8RvjNnOSoYd+OmK?=
 =?us-ascii?Q?MXiOzHgvLYQ5Bf2eXx9U0jBiekrPDQbMA5skk+JWygaAYgetyOuCsXH5baMN?=
 =?us-ascii?Q?ReMdTGHWzsvGuEdCLggXA0nMwd8Ob0gfTZXedL5epzrnY0NvckTjLc8bvVEj?=
 =?us-ascii?Q?Ec9U8MFh8A7s11RRKMh8b8bHnQSe/2KQGDYU3ikpAyRX23w/k9AyiVPDF2Nf?=
 =?us-ascii?Q?l1xUMRRmB7gPnevlsbQZBSF9JyzfR4Yhwe5wP8ib?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487413ef-e597-44b3-4ede-08dceb7be8cb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 11:40:59.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14BCGa2Btb3RVnFlRlDce2f5RXE+Imo3arYrIhFhf3lI3n+6UnLxpfOvXTunGXSa+qwqL+IWKbqbPkWEf+lYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199

On Wed, Oct 09, 2024 at 10:28:24AM +0800, Menglong Dong wrote:
> Change the return type of vxlan_snoop() from bool to enum
> skb_drop_reason. In this commit, two drop reasons are introduced:
> 
>   SKB_DROP_REASON_MAC_INVALID_SOURCE
>   SKB_DROP_REASON_VXLAN_ENTRY_EXISTS
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

IMO the second reason is quite obscure and unlikely to be very useful,
but time will tell. The closest thing in the bridge driver is 802.1X /
MAB support (see "locked" and "mab" bridge link attributes in "man
bridge"), but I don't think it's close enough to allow us making this
reason more generic.

[...]

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 34b44755f663..1a81a3957327 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1437,9 +1437,10 @@ static int vxlan_fdb_get(struct sk_buff *skb,
>   * and Tunnel endpoint.
>   * Return true if packet is bogus and should be dropped.

The last line is no longer correct so please remove it in a follow up
patch (unless you need another version).

>   */
> -static bool vxlan_snoop(struct net_device *dev,
> -			union vxlan_addr *src_ip, const u8 *src_mac,
> -			u32 src_ifindex, __be32 vni)
> +static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
> +					union vxlan_addr *src_ip,
> +					const u8 *src_mac, u32 src_ifindex,
> +					__be32 vni)
>  {
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
>  	struct vxlan_fdb *f;

