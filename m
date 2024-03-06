Return-Path: <netdev+bounces-77969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65C873A90
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A02821FD
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B67134CFA;
	Wed,  6 Mar 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ANX39lCg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803A41350D8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738534; cv=fail; b=diZFNyHjmW9M8aVAOsiX1jLIirom5XZUE3IbwkaU23pxI1ByGV3v4YJnBlck8MIpWS79Pzosw0cOkQsz+se2SW/474Zg6hOb5Lh1Dxewiyk7mwkqCrLy/VEbRh9vKO3dd7byk91NT9rl90z67eZgFCK9ZIaLgaqX+ePT5LAisP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738534; c=relaxed/simple;
	bh=NZaCpoPUGtkP3lBRxDv909AuH4Lp106TxqTrpcCZNSQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=SRsmiizrVFzA+RDaRjxH+UuIH1vESReQ37ktlatEdEH+1HxKl6Eu2Mo9nsOu9nDVjCmXZc07UVto8d0Brr2H09M30cZ6AtcO2JCMRSSWAaFEjTMauCqh+0k+qNoWY7gaaGxum101X152ZWYo8EVvSVv+s/hwwTSSDQyrz4uUkIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ANX39lCg; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbAUaW+QWPkugAbEwxROR3nvB/qioEq+72jkQHXFk+ASr7AWFhAJSdxAC+kO5VclmDFAl57qAT4JHonudZCYlfUg87bNBhU6dP8bjptk0+5I4va7dXLuZKklcKhvrzo3NqwxC/ED4H3bHaL8Oyp69bbs0VDXCSX3WddrRyJ0bxcRl7Mnf117tRevyP0cWJCVeWwgVtOoRtBWHccgheB6HRvPV5qZh1VkKguDDN4LhWW3Nv0nYC1qxdsmb4E1+wQE1x6SI/792rG7W+3JLMcl8zBRiAGx9T1/c6oGcFOynnlo+9QH7piLM/trtrHkYRXpHMqb9uvVppB+Beg7y1SoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/toeReFHANHm+hjicx17GsJEiI7FcOqsQgZSrBBBJM=;
 b=Vw4yRbTINK+eQy3SzbFsxyNs3pK1wgzTTk9HfSvscLEZIWR9Z7xx92vP4tEipxH0UAAWwIm6qtvf9Za6bhWTou1Mk/INKkHIe7AnTI0TPe9RN3cpWRq3YHxKbPC8dC+1bZrBFjEExzeLA1YCWgZNdHhvD7CU3JgdV7yhIx5HOTg7RM20Chyxp980aqGddNPbbx1EdAjo9bmw/YRsyyzIxt0VSQjfQo4h2IxDSeVAjbSv2t8qYe9/1+jAVyKDo7asjKdbo7pqKVppdJMUn/82RQS2BCJMhndvrn6eNBjqkG25d57z3kOdR75dmKLlJHF37qVQ5KBBO/3tzxErfPB3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/toeReFHANHm+hjicx17GsJEiI7FcOqsQgZSrBBBJM=;
 b=ANX39lCg1lyXHrTLSJr18yh3dT8ZrgYLRsfBMtjifWQYsb1AQjaVvDrv5QbPevzKY+nzVeXHIMrvEssRDAAr30bJujGDfWW5fiLk4szVJ7FGvJj0D1x12eFPwOGdBzOb/5EBS8pNYTybWjwbyIyTvp3DuVYYJ9eQo8MjF8oGVJ+hqN67crLTwHZREvIwStzbseAFjUAM4bFwieW3iWBYeypqrhPVDAuw9I1KnzmS7u9uyWca6+mvTeUQGrlk4VwiqqqgiA2aZHK1sHFbUuMj1wW6oIv/hNuHfM67GPvvP5sSGBbg1JQh+Go1iFLqymqlO41VDrXPmqIITLmK61ytaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 15:22:08 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 15:22:08 +0000
References: <20240306151240.1464884-1-jiri@resnulli.us>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 vadim.fedorenko@linux.dev, milena.olech@intel.com
Subject: Re: [patch net] dpll: fix dpll_xa_ref_*_del() for multiple
 registrations
Date: Wed, 06 Mar 2024 07:18:35 -0800
In-reply-to: <20240306151240.1464884-1-jiri@resnulli.us>
Message-ID: <87il1zs7vl.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:a03:80::20) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 5433fd33-f8cf-4707-2861-08dc3df1300c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XDFWCVgn4Ulg8oEdnbTs/dbgQEyXZkdsM1ouW+L8xbcE4iT4bXCXDWUB2sHTeXRi5yQCdOZ4o1ZU4YQR4JcO4UfkORFDfNZG194lhcL7LrSAvhvdOXL4fWsVjmnqpvww+9b2ml/tWqRmHU7TsXG1btg8KwS8QVuT5s/2NpJSW2Gtq/PUMeJPflsgJZ39eDLyPkif8Mc2M5QoflKPZUteuiEqVXmlvbMBIwwquME8SokY9vUFWbhvHYha7cNeHkAf+/Y7ONfr4XVpdjWn29cYo5bWPxg3l7rP+6bUwFjgGkKFTbspp8sx+PkUV1sNBR9Jghjo56SzmLdc+gdu027/CBMfdnPn7dJa7C8cJLNFysjHBnO50q6i1h2xlhphgs4n2oHtuRRXhGKnIcliN+XOPPBj2TxqNqAyBIHmjRR/5xIlUpKFY70B6Oi3FIo2wZbCcjT86Tyog0H8uz/F0oblJuaKgZaQABdBAjhNw/sToypNprWz1nHjKbZ+xurKOZngn7AGa6b41hXIDA0ZYNbRGjojxeP60Srzi+lZyjR8iXPKrfO8r8QUUwJCg1NMwVJdlQ5u99VKPiFxRlCpDOrh0DOD+KS5uDmM1hzogUtX7H22rU/bGpKweuLxl19kwcPPeAKsg8JnF9Q4iElxRMwchXpRVt/kdngFLudslw8WFqw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ShS9OzRelmi0+OhyTb/F/p5bKUu05HbPp9jWVJ0L4YZZf4bww2JMrYkxVk85?=
 =?us-ascii?Q?x+CluglN/P5kt+1Z3GP3dqH5qCgyoeWDpUfi8n12cegUB8b+zjjbJzBu/04m?=
 =?us-ascii?Q?Ve4c8GwnDGbwG6GqO77UIKBwZx9GQUFlyntvMSZYyyG8XGQrd+WrOMV2p3iq?=
 =?us-ascii?Q?jutbIFI64x4y584cplydrjFhvpuF0ctGg79kcggxfsJX3pbyQAXzxvy951QP?=
 =?us-ascii?Q?dpI1thou2m9X5vQNiE2C8NuDxPeW5NGOIppANpohsXrN9ivsaSNZXJagWdRk?=
 =?us-ascii?Q?D+i9na6L2JHJYaKfCfNdmp3acP/F3ag+JSJIoRUm72eLDaS9q89S8P7PreDe?=
 =?us-ascii?Q?IaexNK9LH9T91a2Ht1qszppYBCXR4tpV2kzaSP9fTsibZP+vc6g3KkC5Dvyb?=
 =?us-ascii?Q?HLlxKsNZfDHmudT9x1ez7qNmbAxFX83JQndl+XSzdDtMapNmE23K4H3lzNrB?=
 =?us-ascii?Q?OQvYh67kIQhWPv2vZidbyFcAKt+2Kh8iqYT9Ny+rsfHYoUMjkMalJL7C3kU9?=
 =?us-ascii?Q?vqRTyfRoO1hqlzDyfZM2wsHVlNYRFs6N4U9Rz8EHrZpUT1kloAKfmW+IcA5q?=
 =?us-ascii?Q?VKIoevFXIxtOIxj8gKGrSyavALyFjMKscnh0kV3XnSfSsBk8+dHGOLgW1fvF?=
 =?us-ascii?Q?ZP9v4YO9ddx/TYs+Vza1bjtKynBWCRA9bRlFzZLHqHGxKP1BPc6Xvljt1g7i?=
 =?us-ascii?Q?jkci2QGlybEEVlin1UAEwLlg3aslaApBRlbGHTf7rwEyPWdnQV53MCXzfhdi?=
 =?us-ascii?Q?l8tMA/8CJ5RmFruIZix8zGY3rjdaY7eFZJdPEViVKno+x1f5Z2DPcU1poO/r?=
 =?us-ascii?Q?j4ujYkXGrhIshD6y8+vrireIjRUd/rEpk9MVoqmmoIUnK5ZoLpYSlAOT9y8B?=
 =?us-ascii?Q?jEhBPpqMfMC+MD6hAUdwRSO1MsbG0H9asXpYSRh8DZgL9sJX6ow5Joyi0xVB?=
 =?us-ascii?Q?6koqawKbIbf4n6X5C64MHuFZ+rWAdZyfN4fds51ecICE4pBZ/wRMCFLQx2rs?=
 =?us-ascii?Q?7fy0LJJrP0QmKsIqCW+6wNd2MPDU5qDdeezZsNC6s6kE15Q6ZvKfBCIJLGMc?=
 =?us-ascii?Q?5MNEYlL+Klpk99hqAsjQNiaFj74GH42Ffbc3kX873bjYcTVuHA9Ca9uVgbbT?=
 =?us-ascii?Q?e5wXEarfjvN/9+pT0EHgi2S9nDHqQYuat560bf6KUov0h8UGCuMYYBn4F0Mn?=
 =?us-ascii?Q?f/kyWVVFjH+wyLGeyN1JJ1aeO47UlLwJTu05g4IINEB2oNFaIDchwHZ2vvli?=
 =?us-ascii?Q?uo6arQkLTSyQnPQp60ySWZfRtmcyZYzYjwgNrWjyOQVh39/nl+TgorjaNK57?=
 =?us-ascii?Q?U8pAjkEbD/v0LqyNHJBTZvamtz/SbbYKRXPZoMDfK8ZiE0cfC1MdOHnnKHkD?=
 =?us-ascii?Q?wdAESg/Ii8lQqEoX2oepo5gRNKByPcTERycKr2TzCh7lrk4wWfE9ayN/PIYo?=
 =?us-ascii?Q?T4uLJZySlJ/arhEH4wc6Da7Y4LCPnqc1G7Dqqiodsfp4V/twmu8lIwcf37/F?=
 =?us-ascii?Q?QtGgoNZrR9GZ4+qqAtlBoCt5geO8Lr5iZGz48BVIM3Tm9PxVAuiwSanvR6a9?=
 =?us-ascii?Q?l7zA2Z69ByvFY1fjV+ldPmbaWyrcY+En41z3w6rrNpg+P9PBfQ/6NYN2Fx28?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5433fd33-f8cf-4707-2861-08dc3df1300c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 15:22:08.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbE1xha5MvzaP9FDWLnhWBh6MkB711WIVarUXkUGWvSpnp0yKarQfiBCZT31NVp7dr7M07gTVaFy598I3mmmIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360

On Wed, 06 Mar, 2024 16:12:40 +0100 Jiri Pirko <jiri@resnulli.us> wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>
> Currently, if there are multiple registrations of the same pin on the
> same dpll device, following warnings are observed:
> WARNING: CPU: 5 PID: 2212 at drivers/dpll/dpll_core.c:143 dpll_xa_ref_pin_del.isra.0+0x21e/0x230
> WARNING: CPU: 5 PID: 2212 at drivers/dpll/dpll_core.c:223 __dpll_pin_unregister+0x2b3/0x2c0
>
> The problem is, that in both dpll_xa_ref_dpll_del() and
> dpll_xa_ref_pin_del() registration is only removed from list in case the
> reference count drops to zero. That is wrong, the registration has to
> be removed always.

What about the case where you have two functions/netdevs that refer to
the same DPLL device/pin and you only remove a single function? You have
another function/netdev left that now refers to the unregistered DPLL
device/pin.

>
> To fix this, remove the registration from the list and free
> it unconditionally, instead of doing it only when the ref reference
> counter reaches zero.
>
> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/dpll/dpll_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 7f686d179fc9..c751a87c7a8e 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -129,9 +129,9 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
>  		reg = dpll_pin_registration_find(ref, ops, priv);
>  		if (WARN_ON(!reg))
>  			return -EINVAL;
> +		list_del(&reg->list);
> +		kfree(reg);
>  		if (refcount_dec_and_test(&ref->refcount)) {
> -			list_del(&reg->list);
> -			kfree(reg);
>  			xa_erase(xa_pins, i);
>  			WARN_ON(!list_empty(&ref->registration_list));
>  			kfree(ref);
> @@ -209,9 +209,9 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
>  		reg = dpll_pin_registration_find(ref, ops, priv);
>  		if (WARN_ON(!reg))
>  			return;
> +		list_del(&reg->list);
> +		kfree(reg);
>  		if (refcount_dec_and_test(&ref->refcount)) {
> -			list_del(&reg->list);
> -			kfree(reg);
>  			xa_erase(xa_dplls, i);
>  			WARN_ON(!list_empty(&ref->registration_list));
>  			kfree(ref);

