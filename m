Return-Path: <netdev+bounces-89377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B68AA27B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC51F2101D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0263217AD78;
	Thu, 18 Apr 2024 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q6lBo8Ex"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23D1EA74
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713467068; cv=fail; b=XF1syLKNezLBK6FjNNvpZkxdWGpmQqw51HX/q/Tqb94aHH88iQIokQ1aVUxHXF/0UF0Jppp6skZ5h36AyulVHcQo4r2VasH2idUiLVAltmGbKtspfvHxdRYgpeF7v6DAJ/9d/rD0vDyKsBQqngOuP8x2y0qMPsvF+wwp0WPCJkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713467068; c=relaxed/simple;
	bh=tQj1BbWC1ssLyRqaWlReIf7wwyNe0ZxZdqVGSvxn8u0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=WkK5Yg9rkPNU34AsSUgyT4ajRzbWthMyWRvkymH8C4+tIoBTBH7iEmevl+L/Su6BuZgTOG+aLqQqYxJ8lc72ZRhafrsK8ES8Hj1baAu6lq1s7g5yoZtA5pLWm8hfr/Bu7y5GADYuuVamo6QY4yrXovPmO+2aEv7RVzrN7GESf94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q6lBo8Ex; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImFM79DM90Di0yzb2SSHURMHJJ5j+AG0bBaVVa/j0zwOJK0H0Trgereh+F/+JmNbXwL12bM9snL4YhQBHmtELC1BT+xCOFRnL5XDvdg30a3GZmITAGkBz0zq2WgRm9iW6O4/yhxsLk4+KqMiHDweIRAT4rLM8jrrJwCZxWfv70wBPD8oirl9NPmgNrJ9R4FL+zbl/GlRuTXl4k1gK7qpiI+YGimo7F65N5a74fwLOooONT58R9ZuCKmrXwDtPs6wqyk/immOEyHQnkW3SWiTrxg63HSErgrQB/JG17wPph3qNBOIxdUUFiPje/ROZ9qPC+GyqePYvBkhqEIZ3tBXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Vs/wYZPc+QNXKMo7hSTN17fygPb92qwS9KLE9j02Gc=;
 b=QayP8zDzINORAsLgdlKhEUrotXktdVEqW8+HogbiC1GoY5+I+PDslU2DT9tyU+t03AdCZXu5CCKc+YThHb9104fRSkvireceF/dTSzVaFD/ENQEe56ilfX/EF7r+rVHeYfp4kGsnPlmrabBkfir6CQVCdGExCODTpc3xj9V3tJgU8MgNYDd4Igo6ULCqD2DfyVqS6GHD2HbgMy8c1pDGDtq1JwNs2YgtDH0nJjFsLdwRi/iN1KxYb/YDbCFBi0F/nyS99Y8iCcLr2UfbMYz5msbtiT7ZqbwG9Cca+0carchCPAe8V/WxEJFa0LSWnvgLsTP48u9jf/7EZ4PgAR+s0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Vs/wYZPc+QNXKMo7hSTN17fygPb92qwS9KLE9j02Gc=;
 b=q6lBo8Ex4P2KEZo+QqGwerYqvCYP3ZjkEH/i8z8zLIX8PP+3dr78R8JZycgAWMlnhEetmbDp81bTB4f1kmaySdQHZTqvPwAsbHmLee0j5tE6JgiSStx9eoOFM9+u/jAv2FY9NPZCsZBKY3JATn4Xdj/CFBfltlCdj3OvlSB9DsEK2A3/UO0bIMwlhMsjjJmXHqMFaPVihISb+31kEfkdylBz14G5BPcltOoZHdRE3/6KJVxf2E4TyXfHHf50injetnXJ/6AAryUGHTk3PLo2+4cmONZFSzK8sKuDMpBmgvONeDJwv5Uvsi1kQfnQCo6d9fxTU3OpedqSovw5cJDMlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 19:04:22 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 19:04:21 +0000
References: <20240418052500.50678-1-mateusz.polchlopek@intel.com>
 <20240418052500.50678-3-mateusz.polchlopek@intel.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 horms@kernel.org, anthony.l.nguyen@intel.com, Simei Su
 <simei.su@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 02/12] ice: support Rx
 timestamp on flex descriptor
Date: Thu, 18 Apr 2024 11:57:04 -0700
In-reply-to: <20240418052500.50678-3-mateusz.polchlopek@intel.com>
Message-ID: <87a5lqfq6i.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: ba74342d-c6a7-48e5-5c8f-08dc5fda5b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R9SwYPRjjOszwKSVPCugdeZ6Fgwua5eaE9SFENyHW7oHphONYJpaHZ+fNrbB0FMWJofvOFlgmZxVc/0ekkyb6plGt5aREpDBJ4OChIBJR7b9cRNZ3mZSa6ee7wHIHWjJ3m0K5dm2tgmqTvHLjTC/O85QrpKCWSQg7nRFStLVO8ol3bLkq8YuEUFRnF5T8INTTOwrC209c44+KjZPYvpeDRaXwMVb6635PCXG+6ryj7VwwF4l5/XikBRtRFRtFIQOnh7O5MbzrpvU/Vw4vY+Us3rvyRQ//z7H4fG8RoRghvqf5ReSr+OVtb5Vs1wx8so0fRT2tqu8oSrwUELc2Phg9MstT7e3serwmkL5Emy4V7d5Ow73TvM9zyoKwz8gTEsk0HuDidwKkoucbA1Hx6BlGunlrw4ccwG+Ft4/shod6yoFLHSNswHjyt2yiZAI+ayVqLh264rf3o1eqwkhwhvAq7Gqq/6viJVpVmomiPtmhxmYgooWFnPCIVEdRznFGDC/ECeuvzPJtbeFgcNiF9If096SyuqDh0VgwphTa2+WsrAgGZxsK7sO33ekK91JpuszTHWYqd7ued/gQYxv9Y7WOraPcMLlO+u4/mil7jLcxZcJPcRMw/cnc5nzOF8qFpJc9V27A+lHV1FdfEl2L9C5/7E5hF1P5e8VvXKdC87iPB8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vfzXK/6Ih2edbZ8qTwzcgEDkGCmsrS5r0gscn6mZj6cynQMyuuwBVf28iYlF?=
 =?us-ascii?Q?nAbuiNXFIpoUIBGTHIxRbvOXJXId6x11GbepIZ7kkI/eawxFHsqZx6uGlHEo?=
 =?us-ascii?Q?3f7MctuCE8YB/ZYZJK8+1WY1JBKPk/38A2PUu/J14t91yQMugY5tVhN8sodI?=
 =?us-ascii?Q?QAATL3qm4lYyVLtmhr3GDeDMwlI296bbx3uX70NoRWRQlhC7WIBoDamRc2Jl?=
 =?us-ascii?Q?81Dfg5WuuzNf3moLxlw5YD1ZW4ir0giHAnUOSEjNWD8PnQFqRGqdtnEzKQwB?=
 =?us-ascii?Q?vI3YHMbsvisAX+97v2SvSGgSfCOr3e70cFLNrjEyzKoV/vrTR9ZRzM0nvIx3?=
 =?us-ascii?Q?CSHSL5/yDt176FTSQUNoDDg6crbY8l2OHyQ4TRs57AkZUPPzt9oLWxNigC44?=
 =?us-ascii?Q?u5ckvPpbPt1vLS2jhKFIfCWgZPDpH+1jSM+nxAKQgvEFJ5Izuo1Juryzt/uX?=
 =?us-ascii?Q?iVmIGey1wajbKxmSmJKWGIsKjBmbf+uJEUlOSv0u3Aca2QpoqE5PDP71pMSc?=
 =?us-ascii?Q?/OrI46RlPXeCBI/bQCx0wSEhRSmtp4mBvbAFf6XjFJEMN8Gpqxl499SiZSZ1?=
 =?us-ascii?Q?QYrX/3LUx6BHRIDWNro9pqDhxFsVlEa8MFwvDJUdtCgSTQwyQFfxVYpOKYc5?=
 =?us-ascii?Q?MExIHmzmP5EP9OvVjo6gn7jf6yDCl5dF7fOyfnlg1CWhVMboTqELTQmhZFsx?=
 =?us-ascii?Q?Wh+n1M97FCycSL+IJOgqAZes0RV2R5NOkgyOwkSeK6il9R8dsNVccBNOQup5?=
 =?us-ascii?Q?e2+SCGGySe6yvFzvhtJEtnrVOE/YtMQn056rc+fU+OGQUvlRuXbMK5w+3Nyi?=
 =?us-ascii?Q?Bd3YHtfbVHQgIMME1EQRCds9nC5OZbYFRqZaEDfqnGJhZif9Km6rktRzWve0?=
 =?us-ascii?Q?U50yxEFQxv/BBBHEQ0EKJlmHVDpUMRgKOUjRJaxVqRHfuoblQ9f7fYDwcJyM?=
 =?us-ascii?Q?XKaasyaEbV4vTEiBxhxwBxDXzScm2Zifzx20n5OvgVLL/nHoC+axqex3T5Ng?=
 =?us-ascii?Q?wd0hp4RjX57Zxr38aHZGHNg/xuDzxILxKutGG1QokueIDB7H7utFyoYphiMX?=
 =?us-ascii?Q?c4Mv6xP/EYz87aMX6I5sILFlbizXDhP6+7974sh4dIcMRdbkyxR+Ex3Gw6yN?=
 =?us-ascii?Q?XR8Gacdg6e9LCjNsM/1k5dJ6AlneK2RzLDiGtdP0rMqf7ivUUbOpTjw2ISrb?=
 =?us-ascii?Q?4G//4Y4GV7BS8Bs+Byk5DcuPlMn/qzg358kBT1pPXDMYnM65mxIxjVfOmYcu?=
 =?us-ascii?Q?z97zkGabhpBEH2iyP149BIvfV57DlPkInO/SjsuikdUnfz+UKZGBzym7C9SU?=
 =?us-ascii?Q?KjvF8WkdyIAsAWnizn5vzk8WHZ3d98Ne3KjbfcxMonFsLwXamZF4ooTMyZpr?=
 =?us-ascii?Q?gKgi5sCTts+lT5h8cLOA8sErTVKmALV/hcAHdB4fWvTwQ2bE3fVcAypTgy+w?=
 =?us-ascii?Q?tQymt6ZPBkidl7/YS5K30ncqqHx4gjl4vh0GX6TN6SRbXHLigqXNkXkB5Bgp?=
 =?us-ascii?Q?0vJwYq6lSa9Ir9mV79VZ1Vhd7hsog9WErm2E3YQNUx/UY6Co6O6kMXoRYL9g?=
 =?us-ascii?Q?9/2TzPCb9kkYODVFqRiW5brmc8bXxRuarxncrtzVME7+IGEiySF0wc3wJj4x?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba74342d-c6a7-48e5-5c8f-08dc5fda5b2a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 19:04:21.7847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaAJ4MA5ct9gdO++KFllAGDA8XNY96Mkkqz1autnYX27HxB0yx9sBKHBVYzoiJ16JH6PXh58jdvL8uUMdtYXrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527

On Thu, 18 Apr, 2024 01:24:50 -0400 Mateusz Polchlopek <mateusz.polchlopek@intel.com> wrote:
> From: Simei Su <simei.su@intel.com>
>
> To support Rx timestamp offload, VIRTCHNL_OP_1588_PTP_CAPS is sent by
> the VF to request PTP capability and responded by the PF what capability
> is enabled for that VF.
>
> Hardware captures timestamps which contain only 32 bits of nominal
> nanoseconds, as opposed to the 64bit timestamps that the stack expects.
> To convert 32b to 64b, we need a current PHC time.
> VIRTCHNL_OP_1588_PTP_GET_TIME is sent by the VF and responded by the
> PF with the current PHC time.
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Simei Su <simei.su@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
<snip>
> @@ -1779,9 +1782,17 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
>  				rxdid = ICE_RXDID_LEGACY_1;
>  			}
>  
> -			ice_write_qrxflxp_cntxt(&vsi->back->hw,
> -						vsi->rxq_map[q_idx],
> -						rxdid, 0x03, false);
> +			if (vf->driver_caps &
> +			    VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC &&
> +			    vf->driver_caps & VIRTCHNL_VF_CAP_PTP &&
> +			    qpi->rxq.flags & VIRTCHNL_PTP_RX_TSTAMP)

Just a general suggestion, any reason we cannot use test_bit, set_bit,
clear_bit, etc for these flags?

> +				ice_write_qrxflxp_cntxt(&vsi->back->hw,
> +							vsi->rxq_map[q_idx],
> +							rxdid, 0x03, true);
> +			else
> +				ice_write_qrxflxp_cntxt(&vsi->back->hw,
> +							vsi->rxq_map[q_idx],
> +							rxdid, 0x03, false);
>  		}
>  	}
>  
<snip>

--
Thanks,

Rahul Rameshbabu

