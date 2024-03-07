Return-Path: <netdev+bounces-78267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C0874980
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42EF0284CEC
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1940263108;
	Thu,  7 Mar 2024 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="KgTfJrvl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2121.outbound.protection.outlook.com [40.107.243.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501D71CF8B
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799798; cv=fail; b=Fj0GLIej4z6MB/O5GeUtEz740uBRlvd4MmW55m5Yt0e3nr4bpuHB4f0pBau/AT+wl+26x+I52KkcJWmL+Uv92tY6oWxi0V6t26m6aCGrL1Dpf3Pg3DAlNtKHlztdfECwSS1xnewSJ2wGdnp7/3fHZhDZ15iAOEejHYmaNkzgfxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799798; c=relaxed/simple;
	bh=SAWeJGDJujNDPqilP9/adn4AzkPetiSz4EjfwQQg4Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZUK0pa+zFfS4BX4xsea9KTjTAsru0ceA9mSAHzKr+PtlUcWUvhOZk68DdaeUntsMoOdK1nlq/U75Gei5YziQ8oxLQyPdviZrdVlsg292Ft7rEzkI6SVNkJMQw9P2SxNQuiehD3Kfy9XIjviY7fwPL4L++yCJbSy5SRnPM8yda50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=KgTfJrvl; arc=fail smtp.client-ip=40.107.243.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM6YHIR+NNGOtEnuisYF8vxZVLHeKUItbOZOX1tTCaxR/1N1Qmt0J7NoZeXPqNTcihSV/nJ6kI00DKzDuRWdZo91fXhtPWBhg+6lkQIlygDfCDdHxA6WuRP0FB0lX4LVHhpEgf31HRlWJ0K0+FxVsJbeWMCADC+99ujI30ej5MF/wmGxq7DLa9XNYD75x3vpl9sGeNAmohCosqwwUU04HYNcndc+HGFhmDYwNSaYhN+d3h5Ki7pAFU4k/+X3DC6oBXJr9oEsXtn1YwCu+hyG2tJrLwbvug2yvLtF8UCIgyPMNwQoCg5OO40KiQ9xXEuXz0yAAx2jPNvJMbxnBvZpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFVQXcWXBACp/+cfv+5Bud0WPpE16DP1V5MVgElKN9Y=;
 b=RDgRZ5VLIhCHb8CJRfywhPeJbLhjffP5bspSb0K6m/5jmTt6ylXxpXGYKdcRG57dETZnCJnPiAELrcvB80qIS5KyzT/oSE14S80gsX7HNWk6H4kaLALUMhMDI8R3UuHyHp97TnTykKw9paqR4+SreDYS+WhepiMIHQ4siSJ1cN0CJDZq0n+/grOt8oQOiP6USCxaTCVb6i1/nSNvKDSe392I4HeRp3o5NYygeDdQq19uPOL7Vk6Mt++QWp28qdh2TW1/qh4Mt5onoRb59UkUmxg2i+3TfEBoiPBdWjvh6U7Gg63JM8zInkODxRFbr43aqQSuhtI2a1TfNVaAV3RlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFVQXcWXBACp/+cfv+5Bud0WPpE16DP1V5MVgElKN9Y=;
 b=KgTfJrvleXxddFSQTO5i/24QnpZMDqOlIOZ+Pucr36qaqpDtHOhQ9CDOWJCyj/p3VMlgdXlU70HSuXuCsSmn1cbERlJkl8Cfogr1VLj6uY2oBN17NGPl5BJ8uNWi4PkdsWpMqdcNiib/5RPJu/wzaUOJoJorO3wguD64fdYOVd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CH3PR13MB6411.namprd13.prod.outlook.com (2603:10b6:610:198::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 08:23:14 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb%7]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 08:23:14 +0000
Date: Thu, 7 Mar 2024 10:22:37 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Fei Qin <fei.qin@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 2/4] nfp: update devlink device info output
Message-ID: <Zel5TXNRAD8tbnqe@LouisNoVo>
References: <20240228075140.12085-1-louis.peens@corigine.com>
 <20240228075140.12085-3-louis.peens@corigine.com>
 <20240228203458.4a7234f5@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228203458.4a7234f5@kernel.org>
X-ClientProxiedBy: JNAP275CA0050.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::10)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CH3PR13MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: c71af105-9688-41e0-0237-08dc3e7fd541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wN3O1ZMHZmPaOW5Mwn5TdsJE+aMmUst1rcRnLC9+uJ7wv4OatO1/1UPnhGE0nqAjqPnUALsmEhFG9jnDAoqpjHw71wtIa/Yb1LDbPaJeAK/6RCkzvfayfE5g4ALSVtv6n0UZgCb2Ry9DgZuVbL9ep10kPe5IybfalUEBr/p0zaIodvIViby0AVVzOJ5cY1msjeZld4tUPToYGCenaegqHX/q3hklvVjY+8MB+YfQKs6UVuRbcU04XcBC+ECcFmjK+hq//K5mSQXS3c50Ua3bUpyoveXj23sGd6vMIS6CFZ7qiFfZ/afNfwJ+i5N7mt37+x5PnNQ/OVDHUXScg90GYYFGH5O8K+L0kSS/bf/6yBkIPT320rfYBrKWKM9l3ZViaCYfr7XvrPwPMgCVrM7YvPFTq5RgH4Dt52+ph5x8KqunqiAb5WktNSsrxi6OfgtfUCuO3QzGCdvDeycmmfrMTlDyTOykgVHC5aImOoTJDHMHhi/gWT7crFO2kNE4/WlbtlNjZFGTC8wa/uH+tYhAfmu48oivXpEl9C4DS69Bgh/CVqeAnxEoQ53/DYu1MO+OakDkjcipMuljCvPPfEy8dqEelO3jwCOCgw42EO+0NZl4SMh+jXIzQwKDU67R+y2l22TC7F7tuzvpxmUcMQ9pjuUxgJghqZA7+YT1hRewwDo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?az5ImfGjjT7knqhbQlj0z+gK1zHrGfmTZEDBhfGEQKNADyvkulZkqR5ivx3L?=
 =?us-ascii?Q?fBDfZ/r/qUKXhdLBgOGkb54Sqje/c7ffzG7v9MRbQ+gUeq5Bwtu1GLy0DFfs?=
 =?us-ascii?Q?7j9SecldJF/Ath1bf8kyKDaeai0EHtLDTOBVPcqnEEUGq9lkOxPTm/p6iq9b?=
 =?us-ascii?Q?VT+4m/hWav+28IYTYb8XeOM2d0on3A9l01AyYztbz3Gk06d8+oczQ3qABfZD?=
 =?us-ascii?Q?4USj52Q2USW+9VbloZt4ZjOU3X2rQmFLw3s4eyJPuw/ODgIKMA9rHpacHJM2?=
 =?us-ascii?Q?5kS79VgwDo9AdVmqVvxEPIlVDYlwOnCgNP6y2j9VDcZe82cV+h947jdll3JT?=
 =?us-ascii?Q?kW1QHiwCSnSsA0Mch5Ll+dD4TJipInsIuQftNkSEDwfFpnKK0Sz0H5rOeMcE?=
 =?us-ascii?Q?Ytp17mAPqLUx+7mSd0HJIVFCpYbKdmjkiTo5ajT+cXB8tniZFEtcn83fwkev?=
 =?us-ascii?Q?H1QsqilHCM9yluRYoZqn05NAebPNkRNugTIARDcqAmFzEJo2Kl6YZrH/ZIoT?=
 =?us-ascii?Q?ihhYjj1XhYRn8V7eA46QqBjcm9PzR5spKRwlBSYKGJLLcjU1BYvvjPzAKuuO?=
 =?us-ascii?Q?5nWn0J5SiUl6xuy9Yq08G6dEQpzqhpsbCbWLDNamYYS7zM2w6LaNqUYJenrj?=
 =?us-ascii?Q?CwnxE0sk2cL78DcAWYabmeIUEglYyk6tV9d7WgSJkDIZGdJnq+m3nIv8FaE5?=
 =?us-ascii?Q?DzLuJ4HqufnwWodfEYzof1yoKE2lV1Lku+C9q/lhjYNiWlAwsfqkuBwOl6pF?=
 =?us-ascii?Q?9mdj3c0UL/6De6oRoN1W9Ci4CO0D2d6WAxz65z8NgQ88o1gC2DPJJe9yrqKx?=
 =?us-ascii?Q?Um0CoxZiiucpBB0868AIx0t+mVR4SgE7/WJIf2/7Ed3JYKV6aGspZlASs0yQ?=
 =?us-ascii?Q?7i59FkF+ZxLtFGXPSI/fGdfD0B2g0MD2BYRHmAh16WNgmfNuWHOgbd0EHWWP?=
 =?us-ascii?Q?7UhXHirQBl1RcVmnAM8KUyOKqmYMta/q7E9LLxuV1sbOnZ8SLkf+Aq3xwsS6?=
 =?us-ascii?Q?CMlipPzjl1J10sQETGtmQdFm60hTBAZey6gfY9AMtwZgaOjkJhBWrGn6Uyko?=
 =?us-ascii?Q?1604DzssxmD+kD6ivCir8S3ECaB69ERXOwyTnBTaMa2d9EWOMt9CdZKj502S?=
 =?us-ascii?Q?6A5aKpKT3Zg+noHn+WjrukBAO8wwrUUgc7rTST3BiVCHXpoGWohS6p285Hyg?=
 =?us-ascii?Q?S//mmsp3Z2m5IsmfPMg44SIdn6XAdTXjObdo9zSVrDSDxO2JIgWRiJWB2i4P?=
 =?us-ascii?Q?e62xB9GwR/v3tSW+AYz3y0SPF2u//S4Nu2PaqbLbLH6lTce6hBqKBFMaYV1e?=
 =?us-ascii?Q?876A3gGriZiDIO6o5Nwxyxc03iA/qJD8F7mUlWkt/YTF5gwNmMaSLPLcXzxd?=
 =?us-ascii?Q?Hy1tEOgTwRz/HwX1ZOFLHmSE7k25ewZy9xMhn7oWt/NmiWqH72oAsKAEGIhL?=
 =?us-ascii?Q?qzFJky4kbvzbXyBeTu+sfyN5at9WgGQgFBP4R5tdVzFKblNrw0hyOiPILHjk?=
 =?us-ascii?Q?/464aVfbHiJgfEqEo8MJ1faUqMi49DsUIqDXG7WlOXEsrviFHDaEoY+E4Bqz?=
 =?us-ascii?Q?OyNDSU9GQmb/ZCwdLKPPobJC3zGZWYHrLxGYbyAH5ksK7OcPKlqGgx9tyEvI?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71af105-9688-41e0-0237-08dc3e7fd541
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 08:23:14.0445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sf9ZwEwEJZWy2LRb3f3zyIKVoZiM9cMszPCGb6tsUOahRUfyq3aekER3qaMlnljf5Vei03Ye9eaXNQxj5JF6f5GKqfAynCWHYB3o1Mt4z6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6411

On Wed, Feb 28, 2024 at 08:34:58PM -0800, Jakub Kicinski wrote:
> On Wed, 28 Feb 2024 09:51:38 +0200 Louis Peens wrote:
> > +   * - ``part_number``
> > +     - fixed
> > +     - Part number of the entire product
> 
> Belongs in the previous patch..
> 
> >     * - ``fw.bundle_id``
> >       - stored, running
> >       - Firmware bundle id
> > diff --git a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
> > index 635d33c0d6d3..5b41338d55c4 100644
> > --- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
> > +++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
> > @@ -159,7 +159,8 @@ static const struct nfp_devlink_versions_simple {
> >  	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,	"assembly.partno", },
> >  	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,	"assembly.revision", },
> >  	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE, "assembly.vendor", },
> > -	{ "board.model", /* code name */		"assembly.model", },
> > +	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL,	"assembly.model", },
> 
> Ah, it is the code name. I don't understand why you're trying to make
> this generic. I never seen other vendors report code names for boards.
> 
Mostly expanded on this in my previous reply of patch 1, but yes, I
agree. Should have pushed back on review of V1 where moving it to
VERSION_GENERIC was suggested. The one alternative is to still make it
generic, but give it a better name to make it clear that it is a
codename. Still, I don't know if that is generally helpful, happy to
keep it driver only.

