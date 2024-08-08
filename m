Return-Path: <netdev+bounces-116719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1094B78B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530E31C234CF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41983189513;
	Thu,  8 Aug 2024 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="llz8z0VD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E8188000
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101240; cv=fail; b=NH9RzE6Dt58p+Zjs12yK4/Ke77POUXkDJkNOs2UfN59Fu4i4k3Fx/IMqzCefu/HIQ+0vfkt6rvEayFdCDmIx9ulIwkcfurollohnSqOJOsgdJ9SwpmtY0MOuiDBkRIWY8tzL6G6iz6ZNmaqTn1HNr5AC9oHZqWT6Dc2+QljQW6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101240; c=relaxed/simple;
	bh=qhMRHrc1cBwo+7N3rZeITVZxsx462fWWzuUFtzWaqsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MithKWUZLmWzQeye0oPCzMBrOPypWNq60lToXIYgrc1MEnfjGqT9nODXXiR/NuifvJ8L/pBsXcq8r3UzxJw76tJxC5jQiRoTzm7unrPTvUQhIwkAX2RrQ/Z5cgCEotNoZHZviJ872pLy3jXvrZZ3BStP2ShOtHcF9KeofpSl0GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=llz8z0VD; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJNlEltat3mPbAZ1eQDDi9zNQLgJognp8xeCDt8vXTooba2OdBTLeREI7a9X5bUWRaJ+dYGp98jk+XMZtgw7YuhMV/YFPpdfS3DuD3Cs/DQztpBdiwG+PhMmEBZGhGbBhNwiEf+sG8p7y4Qfxr4FmZR17nevhPHW9GkBPJyfe3nintCxe959rUBiUyGNNNq6Pc8wl4hDLddJOKOWHUTOXa+JPr6LHRYUYK4vemuixT6BgNGtzTJ9gu+6Ww+O6swcLOxNJYekeTlUzBKNgA/BpKJbPTRhrU8hGfygazNRv5alRYhtgeyzTOmairYHSiMTmuNYgpx01y7Fn29VzRfHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YqtgDfTYBkWJlD96UMXyCd7c8uMAqimfEeQPFcNOMo=;
 b=C9ncP1hkfpm64QhSp1gTaNqj6kA6a+Rxw2757gR0S+uZT6Yvxky4G2z+t3z/ujogqsVUqe93WO3eYPytVkvpNG6rLujg9RvC7Rfse/hSkBVp5fFsVUHlGpoB+lFUhj44KN0SZzVsUV2Bn2EWeB+OSW1XASbQmATwTuuXeGLO2KtHj6YqWDLlI0VxiCRQD39mIFQHg4zZXgVkvDX1BkbBOsb/t9WyXLDtlj/Z1YcOqz+Tv/NR/vsyBef0/ZPprls9o02ggKWlrO+YJxUDmZF/MwN6e0CRR1Ovuj0Zdipf4F3TlU3gJD74cMrbglW4/g3+I8yi9GOOeN3tWUYfLG+ulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YqtgDfTYBkWJlD96UMXyCd7c8uMAqimfEeQPFcNOMo=;
 b=llz8z0VDnQaoymhKCo12TfSbrSPO/NSG7DxlCKYm4P5LBJZ9VOxTJOR6fRzJW9wPkOoQL/P4vYx+xDjm38qmsPXOWFH2S9r6QRvpEPK+KKbMZjzK8CKdRx2d+Oe6nLCrqNMCFFezoXdTgrFK3qEQsWLOgc8uz0Bcws6vXgaXcQiOIinl8nnCrnVKG2jZWE7YPQtDvTe8OLyiiZ+8+kxvdaRxDJuHb1VfA+/QLgx448JrALe1ViwXw31XmA2Oc3aDEX/CVnQ+JIz/goKeFX/shzYSapkAngwFhRM2ZjloOd4wYM2ZssiFC5mrWl+gEQNzE/2pleTfj5ZouZeNfs3UOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 8 Aug
 2024 07:13:55 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7849.013; Thu, 8 Aug 2024
 07:13:54 +0000
Date: Thu, 8 Aug 2024 10:13:43 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Donald Sharp <sharpd@nvidia.com>, Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next v2 1/6] net: nexthop: Add flag to assert that
 NHGRP reserved fields are zero
Message-ID: <ZrRwJ0NEhM_5TKiE@shredder.mtl.com>
References: <cover.1723036486.git.petrm@nvidia.com>
 <21037748d4f9d8ff486151f4c09083bcf12d5df8.1723036486.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21037748d4f9d8ff486151f4c09083bcf12d5df8.1723036486.git.petrm@nvidia.com>
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef2e4da-0a3a-42f8-053d-08dcb779a9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZgJ6wUe6GIUQTz4ahohnkxObdYbAFXV7Ugz0ZqYyo1kumk9Xjl6l2CeeUyIR?=
 =?us-ascii?Q?YH8B6avUCrfoQ7C3jZlMdkNq2r/ZARUqOiWcSruMjTuTtyH6N0yKzsEuKz5u?=
 =?us-ascii?Q?T6LmkC6UzkWAK8hgVoRmGrj77uTRNLpwD0OV7g4gfdZlEwWee8i7b/jEwn9N?=
 =?us-ascii?Q?nfm34Uj5aS+dspsOrU4XLE8TDLbFmYf9a8msLvFSjTldMFWpEd7XHlasy0js?=
 =?us-ascii?Q?7HJoQShX+nVLk26AaZ+Sj+nlppaLFLIJS0t4MA71qz1eGuD2gGfcs4X2N+CY?=
 =?us-ascii?Q?mHKI1TDlvspxitjnsajviPlxcVUXLfx2Ca7tM5BMlWrP7QF9dUW01PRQX91p?=
 =?us-ascii?Q?7ucgkuXuzS8EQFI7EQnmu5p/bgL0q6e03brb4rTZKPoNVGc04t8Lf6I79Y55?=
 =?us-ascii?Q?HWxfwyY8LfudOGTBdoJ6y9J6zfpxLRJZyQlgamJmygMzrVo2VaTQrfxstNnI?=
 =?us-ascii?Q?687Fm/7k2nuSh6aPAlcjvnT8gdw1nK5oTGTfrPiRiEFV6aD9uYntYKPQi/UM?=
 =?us-ascii?Q?kpbCXODmcJAwn8q5v41AkerO6uQeqzawyyZkXEry/rHnkejl+k1iMt85I8NU?=
 =?us-ascii?Q?cGd+05v8Yku6w/o3M5oz66TwIf4+wobdz5nvWlfu38yviHeDzj25vpW3q/6I?=
 =?us-ascii?Q?jHfiXSr05sFbeOnqcLUWi8z5szFtBt7V2indSPGVYuYU/b+B4Rv2wl59QSbi?=
 =?us-ascii?Q?H3EVsGcTk9YHvA2JnZVfg7yDsuGdp1EE4+iWaOjRYmtliNW2Z0I4pRmP6zzL?=
 =?us-ascii?Q?ikkotu6X0OkbhV/kyGqx0wtaVAqSKqLSbDjGVU4Y0EvOyy8j5Rs95q6OMjUg?=
 =?us-ascii?Q?CiAI+NgBDQZkS0HrLY+SOszvMJqeMdlDGBSBp8+245EQfQ1keqxy+ProNPmg?=
 =?us-ascii?Q?nIq3Hv+TvUsic8e9skH2AmklQ8Rq3nRvnHxZLBc5kW0wPNjA3WjUWyoYaFHc?=
 =?us-ascii?Q?2fROAoGmzgx/m2HA/iHn5tMUXDC71dpDVuKoqOx8fB2eH8MsyDiULy4S14NR?=
 =?us-ascii?Q?jLgqk76ltblWkGtleo5wM/fkpUl5p9q0ogcwDMNJVWW1fRtEzdOlXCDT2KV8?=
 =?us-ascii?Q?kPE6m8+Hp6Za/RuKK5kSkMmFgWR+Wa/KaI3nZETtvZh5bh0kCvwuWPaX9BPR?=
 =?us-ascii?Q?B5bS4hq/hCqZ7dCNRsYARUXv2MORRlVmoiRJNPXBqtwlnSfK4aJi9trUn7ta?=
 =?us-ascii?Q?u6lkj73GiG9FymiXHXad1b+iV+tEHC8Gh4wS1S0rsZl7A/VOnlX0TBhA5bTp?=
 =?us-ascii?Q?dkzJECVU5mOp/+PGmhxBf/GSBOmCuQZmiJ9TUuIp5XAUXoMmB9lxqGezFRQ5?=
 =?us-ascii?Q?VlHC98m8E3T3eG9PxL0/LszREbEx3JzPQ1R2p8lrkO1I8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pToZKZgpg4vMcjjDkhOLzPnSMgGeCgGDUOGNQPKBsFrFfPij0DjT2lbBGkqW?=
 =?us-ascii?Q?t+OlmPd/K+bYG/0zzdtvLqnGpBm7433fI/hThsNJTIYCdaHfHfcYxX8m5tLv?=
 =?us-ascii?Q?Ch1+qNql1rJqGkV6TLBJfpjsKPdd9DTy0oDeSqEkfBAn/4yD32K4tU9K+l91?=
 =?us-ascii?Q?cTLC/kyr3rGESLjT8Z2p7a0NugfJ/Nq5OcPP3bpPrNybBY+Dn7lPzpSFEUJ8?=
 =?us-ascii?Q?537pD/O/YRpRa+AcUEb1jxd15c3zroz0LUJAYF76uYMBdePpt9jWj39ti3Id?=
 =?us-ascii?Q?N/69+pB4Y+pAkNxEQ3RAxbCy4mgCC16bVAeTToFFRlsm3QcL8A5sdgoZuT4H?=
 =?us-ascii?Q?+8rJ2tj7oLPoNcAgNKSR40gIksWunqnAL8DNQ0VZuksKrDEIoEUTpXjHSvzC?=
 =?us-ascii?Q?CMENTwVSX6mGXooH+BNgFCCKUoe3aJITse9GEIKBdQImI0XCGSsaQmzMP3qT?=
 =?us-ascii?Q?KdtgofiXZdRgintryxU2oJXfwm0Sj6BuhKAyptHjyYsskkWRWH45ug7WZXqU?=
 =?us-ascii?Q?/PNj+2kkGAFP/2oSe2mevplseBvmb6CKGCNSV+oIHXUjqzZgBjPL1JjPP/NP?=
 =?us-ascii?Q?yAI23mDTRbHLMW5wOASOMnkJ5VgzOvvg29aoTU0CuHf1n7F0ZEAVexg1EfOY?=
 =?us-ascii?Q?fGgaES60peIbzL+xLErMuyOEufVmezoSLugz5NzbuwWgItphEtWdZ4kSMkVJ?=
 =?us-ascii?Q?5vBoQuMx17vFjaT6LQJPBFhYiFt0HlXcuu/6dPU20mSP00cHs2kjiA/UmaGx?=
 =?us-ascii?Q?5z/346m1Xnkp15OIy+ybfdTN8kYDgV92TEIoGxdLY1AcKydZMPcOsx+DuNub?=
 =?us-ascii?Q?Ab9cj7mz8Wc3ZxT0GwYuSuabuv/AaruonXM+9VJE+EwQrQtJPhuqON7HVD/Q?=
 =?us-ascii?Q?gyuIYTuv0wH+k29I4jdMZtzS3njjzSF6fgJ6spyKQoyZVnXkORreC5/E5VW7?=
 =?us-ascii?Q?lo6i55ttx7jGFw94WF7tGWZIDcTOB61Rc+9zxBoore1yxISqDi1yIDCOdh/e?=
 =?us-ascii?Q?yIn29K+AnQybBDdkgXW6ZNA7i6km38+d4e+Hj0/EEn4wgTeU/YUF9n0e4dSz?=
 =?us-ascii?Q?uft/2mr/Zu2YjLHspKCrwtgL4MLRPEJXOFduk8/NloVdSFmoAkeP/pMa1Pn0?=
 =?us-ascii?Q?nT/Bn6KbQVJjVclXA01tP9tBEHfoO4FsKh+zP3Qre3o97O2TvZc2Xdk85q5f?=
 =?us-ascii?Q?ConKTeeDW3ZPGiIYaN1rS8Y9fk9FC0TnSpYhbePV0DrFfvQGqg4V55SxjtIt?=
 =?us-ascii?Q?B9iF/3cMcxMalJmFOrjKz45NnuUjXIO9qwI5Dnba6DsQyzCVS26weApw37fW?=
 =?us-ascii?Q?ZjQDZwoPmD5Dn2uJdCCwgX27QWgrvles7pJ9GVYKafxZOmkf4wWlxIGTD24y?=
 =?us-ascii?Q?34LrdWI2icZaYoR/HfzTFHiTOHine4QTLnlfAwgcFQs7U0VRqNYr2FUPcSvF?=
 =?us-ascii?Q?y+YowsACgs+sr/o+4QxaSUP2ndwnPnugf5HxsRPha+kRTXtYcsiWF883R0yO?=
 =?us-ascii?Q?RJ46p/UtCjOq+OvX3+WV3YPBVtsNPrHupfWMbM+qfzaRLhA+4bahw3P4RPtr?=
 =?us-ascii?Q?FzoZ4yCzMoZGV3yFELvihkj8NtC/uBnXOEvmiFk+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef2e4da-0a3a-42f8-053d-08dcb779a9b7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 07:13:54.7647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryA+3KPcKK4Q9VMQ54eWShMBXKtN5z7dS9Ce0erGd/f3kQUDP6y1nyybXdH9G6F31OOdwkT/PZz+Dfi9gwsqEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683

On Wed, Aug 07, 2024 at 04:13:46PM +0200, Petr Machata wrote:
> There are many unpatched kernel versions out there that do not initialize
> the reserved fields of struct nexthop_grp. The issue with that is that if
> those fields were to be used for some end (i.e. stop being reserved), old
> kernels would still keep sending random data through the field, and a new
> userspace could not rely on the value.
> 
> In this patch, use the existing NHA_OP_FLAGS, which is currently inbound
> only, to carry flags back to the userspace. Add a flag to indicate that the
> reserved fields in struct nexthop_grp are zeroed before dumping. This is
> reliant on the actual fix from commit 6d745cd0e972 ("net: nexthop:
> Initialize all fields in dumped nexthops").
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[...]

> diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
> index dd8787f9cf39..f4f060a87cc2 100644
> --- a/include/uapi/linux/nexthop.h
> +++ b/include/uapi/linux/nexthop.h
> @@ -33,6 +33,9 @@ enum {
>  #define NHA_OP_FLAG_DUMP_STATS		BIT(0)
>  #define NHA_OP_FLAG_DUMP_HW_STATS	BIT(1)
>  
> +/* Response OP_FLAGS. */
> +#define NHA_OP_FLAG_RESP_GRP_RESVD_0	BIT(31)	/* Dump clears resvd fields. */

(also cleared in notifications)

