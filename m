Return-Path: <netdev+bounces-185176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA20A98CF6
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3C13A4719
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F827CB33;
	Wed, 23 Apr 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O5yEMI8P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3D27933C
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418326; cv=fail; b=e6aCS+T/xuSZjieePsmoNK2FDlV6kf4uT8s1kCIR987iBsHdJC2x/r/brCWF2a45LAEwC9E62spe1aLhfoCvQGROOtSHwxGl+EbsK5dW/48WjWWI+iPXXc+iqz7PLIMLUSxvsDASx9TGv/SJOiht4/cHWDc8tFCu/tZJKpPP36k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418326; c=relaxed/simple;
	bh=PG9tFLQB+VH/HWgyDDEnXyWFE24lVG8cscN3Qjw+aRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uUXx3asAsIWEfkCV1Y4+vcKJyMPSG7gJC9yESkrrChfIGmHV2mxaJ6qO6qlzlqBZjSHjPmdFB1KR7ZmqGh7be9Ul16G/XpBTSRMZYjn4nZYlUXigSBpZVDs9CTzoQzpBfTqrkh2PIL8NhQX/jzsawO8C9Y4XR6EvPML+zQhEAQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O5yEMI8P; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+LdPyjYsG1hC8afUD7ar/pI0OOnZu/8QtlV10fs2XH4DYx5OoZUWNGELl8qCS7QTHw/wwFIHQbwN//kjDdm7sADXOsNSwuT7n7baEx05NSiLxpFzuorf3s7zglZbeBVe5qLFYVi1fWZ+89jFCed+pgfORZNL6WvfrY7B9z0KrCIt0Bw465zjej2R/h1gOIPd++AqPnsfeH+tFKuAVFb1iPDV7XIlXHzBT8pdTHGLTKnxnDC+aUrUb/7X8aPAin2OIgW2Hh4SQwIjmhw0zDhxegYayyQh2O1DVsFMvg+4ypP1aMzxXHhZCP8xW2ULH9+nSOdma6ceUSblqcDr22ZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiHWgzD2S6WKWBCD+xjLSSTvT7BCIlCd22CHNdOYODc=;
 b=ebTmooBXWYW1vYdBORSi/jKnHyICZQwuXrxeKoXm7qyO8uyMNXXoNCbunzPY65o1WhAmFcj75mFvHDNnXEANFDhL0wCsfoJjHbFYC5dJs4mS1MS8E6xDQmH5+/DiLluYRYfq0Ajg0kc3G0XgTY4CjjhGZGXnoMplyqgBwF9KaQrE1+NFqkt5aPR/+F33i98BsCiJ3RymBW8op5/h/HV9Z9YuFx+/1ZVusixi4Mp0OwYnByITz/mpXyjiZDSp4xI1z5jR28CltDGINtTqxE1VIGq09A9X7f10ME2EwHPQx6e1iuRYYDiIUerwW3KGGtLv2VGYeebB2fFiyJKDL9dMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiHWgzD2S6WKWBCD+xjLSSTvT7BCIlCd22CHNdOYODc=;
 b=O5yEMI8PJG+BL/r36y6nVRqcluLo2YSBmW/U2vUP350CWb+/7p/y4LBlzxC4rnPCFwvxGN3r5ZnJxqVxV6cD57dThOC8rVO2PL8USeEmASLN5clm7/RpMKX+t8k0uDzBi00DFwfhRJgEFU++nMaR/CdAhh/CqaZBb4X5I8dWRQjb4lOnM/2K8sz3vT0bitpjH0ULebs9OZSQ4RUc680Smhd4hhEfVMgK3GJQJbirachCC2hrPTiU7wyQCNkiVETifbWZHsSe0FPOAJA+fIvNn/AoMZ58x6QcbDGr/iX+eozuD4+ZBsZf2wsjVzmVjD3QVo+0vUDXG2O/xSCb+45C4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 14:25:21 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 14:25:21 +0000
Date: Wed, 23 Apr 2025 14:24:56 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com, 
	sdf@fomichev.me, almasrymina@google.com, dw@davidwei.uk, asml.silence@gmail.com, 
	ap420073@gmail.com, jdamato@fastly.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Message-ID: <yjqlfsbjbaz4l72fmw6arm6expsq3qxxkxlwzkywrcr3o4rhdq@bfuqhyjlp3mo>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-20-kuba@kernel.org>
 <a5uokb5qgp5atz2cakap2idwhepu5uxkmhj43guf5t3abhyu4n@7xaxugulyng2>
 <20250423064653.6db44e9a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423064653.6db44e9a@kernel.org>
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: adb116af-6884-4b76-104b-08dd8272ade3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i4eyrtyXDGjyYyGF4DfCBkj/FfyZ2gq3eV/Tep5W4+wytrUGTSFJBWzN7MY9?=
 =?us-ascii?Q?jQlRCCmT7onWcA1grp/arYWr/jP/WcHyEqHTKYu0ZJxWjxsPNzefavCVepyb?=
 =?us-ascii?Q?5tXNs8mK8hqU8TEgjoMXGPmdC5ybAb/o8v4dQ7Ky1M4O1Xbjv5yf+seQiTt0?=
 =?us-ascii?Q?pMbBTf6SGe8B112VVirA/6FcoBgA63b/Tj/Ywhuc9b2eR5j0CV3GsA54cUJc?=
 =?us-ascii?Q?q0CYx0GqW1+EeItD5hk+hyYRnaftjMOcyi7czgAQ0HL3iGs72xWxLHOPJKgk?=
 =?us-ascii?Q?ETPaIC/mw7QvV52gdTxMj/YgnqxzYQJ9SwsEzR3kbesAfZbX4Gs2yCIQeNpC?=
 =?us-ascii?Q?CJCVQqJDa2WKeuoUAFCuSygVdTnvBXZ+lPQ27SyRPKTwzg/Hjp5Et3jpk6F4?=
 =?us-ascii?Q?PRn5IxOGeSp1S2nVAKo7bS4iCzr5ot8QXj/Gj1EHQSgKTge0TKwaiiGjeTSj?=
 =?us-ascii?Q?+naTqEw9ADYz+4k4PSnCkKzNR0qulHGsBf6nEfmn9N3zokj6ZosrSBZeW6Dj?=
 =?us-ascii?Q?9aTwPjQqYAzz+2v8Ndv0Xypc0+H3/inLuPQbPhPDNhI0dNMVz8X6RkSaINGd?=
 =?us-ascii?Q?ockBf/Yh1VUYN/G4H6Rslp2Pn8ehs1a4uuKZ4Y4u2XXULJZCesifwIQElFma?=
 =?us-ascii?Q?1qW5bRL45r1CC/pa4yemx/0G9bIpOA151Hm9luZ1EMAS9/MDKQ1JBemzCMDr?=
 =?us-ascii?Q?o2Wegujl/31MrvxmWnJ+7vX7qlO7PjJfpzwMCMhLLntJtl0RjyJPADjQXp8P?=
 =?us-ascii?Q?Ib300RZsPRUVmrIawOtZMU+Yz7Awcery7+Zw5CR4klEbxl/B3tSAvkXt2fPi?=
 =?us-ascii?Q?4v1zRADCU/ziFsAql+H+wvqv9ym175Z/GTI9xt2LJwVkuLlwfKSHcttGThQb?=
 =?us-ascii?Q?cjj1FpQ4r8NuA55K8aNb53U2zC8yiP4gjFfRbg9GUImfp50zvIDmNmzawPAK?=
 =?us-ascii?Q?+CE6VFIBpu+SQLe7c4S94XJVzpOMuRNZHe+Rp3X8/YGK/YgDba1tt89VinPT?=
 =?us-ascii?Q?a/AM8QnIkryd4EgxpTsZPo1RxutPVk9HaTdKL6CmaZdk0KLa0ax3VZSqf/zS?=
 =?us-ascii?Q?vQ8SSVLo9Emkou4FFaRdhDSVJ6fdPWw+ALuc3GXs1f1BQ5LDplfTnmkUIyJ8?=
 =?us-ascii?Q?6zYCivSfeuy3olIR3ug1/9+2//A1PKhW+UJuu3iq6pYT9cMkKoroi/PYNfvU?=
 =?us-ascii?Q?Wa5tsE/zfNWOVSevSlaG40EhQ7X3mMyElDY7A+EkgHAMIVwv1XPqMbiPRbu8?=
 =?us-ascii?Q?IDgM5zAZqY5nq0tMhb2hySuG5SV3HpQK/9P1oUxbnjVyHCBPnCUZDAxhOWli?=
 =?us-ascii?Q?txeDvh2gVwPfxmaRNWImQ17nw/t/nDXqr/m6XP+c2iKbORNpRQshcmkU8KhI?=
 =?us-ascii?Q?vyECUfbzb34YhFwrozt7E41wQ1rYBcMije3HZtd3NR5YAcAy8Wrbt/DkGlvI?=
 =?us-ascii?Q?c//Y4WWKhk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1rnLqXXYwprqV3/ilxdbt9gmSp5+VMF94hCeJkYiBpFhRY58+w0taG7VjyfR?=
 =?us-ascii?Q?wljZMh9aWJQSLaStlImYVqbpirL3SAigEIaA9104TzVr1umLUw/SFMcQrpPk?=
 =?us-ascii?Q?boSKcJlNUlkO5gzgH7uMJcitB1kUtpdkRxH5vbaLRmBA+mnpzc1yw7Ti0ThR?=
 =?us-ascii?Q?yXz9Euaxehnwt3g/tBTBOlM/4i2OjfOFy7H1uIOi9Tnh0UTkbDXim0yJ8Fu4?=
 =?us-ascii?Q?T85rAHiId8Aom3wz1AwxpgmqMRtK5uo9uh4ohdHwnPRWMqPSRigM1jEe91rH?=
 =?us-ascii?Q?Zz1jOiLwLMZUkcwTXmwYc9ZXN2Mg4o5DiP+HOrddYSWR2O3fpKlDiP9JUbdn?=
 =?us-ascii?Q?miCrpFp2RSL08hAQ2v+4wlM7cHBoYKUTlWqjiSFbOj7kvavTKuNvp1orC9DF?=
 =?us-ascii?Q?Jfuxcqhn3xMDXd+7xP6leb24t5NrphmRSqkJNdDp3zcS0mXmQn+Afy2qS6Sm?=
 =?us-ascii?Q?RwXtDJ81a+JBd2pOZuys1wi0nxtzaNK8BU56ozoay5tQtETImdaReRBTzlNx?=
 =?us-ascii?Q?/tjg9vBzJ5zWpceNkQcOfb3iYueZb1kkRogpDxENg05BFsMx4+SZ3wU1obye?=
 =?us-ascii?Q?Sqdk8IgL59JalXG24m0k+0S5jRvvR3FkmeQJFBTVd67/CbkFUDLfVgEEdTl4?=
 =?us-ascii?Q?tgV6jlFZyfTPpS++eCSWm752qNu1deUu45tVkxX2NYpXFqaUa3oLWtp1u6pL?=
 =?us-ascii?Q?ARYZpZuwCfJq0FltgbJVcUipTaL8572kTBgiD43cN7MaHT7DgmJY+cy2lPVS?=
 =?us-ascii?Q?HGyM5WpKcy9U4k7StLbnwdwTTgSwuGqQrxq62RwFNqBBAkp3vcbGjBjw42nX?=
 =?us-ascii?Q?HsFlGvD2ytFHMakUVsSYW8ZayZY1C2qLf3rQhXNoElO/TquXEXSgr5DPKIlK?=
 =?us-ascii?Q?8Y5Xb8BWrfG/mY+4jJTtDFv4cheK1QSoqV7lLar7aULIBT8fwlVlh2lcUFc1?=
 =?us-ascii?Q?F3speMWkr35G9sGD6s6zL7N2xr0fHUMssfAUBX8+/RMzx1WTjezJPBo6GfIh?=
 =?us-ascii?Q?zQVpPehPooYu0qhk15HVjX6fqsFTcAhobsO+Oc1zBJ1kfggjStHrdf4ZwBdu?=
 =?us-ascii?Q?HFuqV60PEu/rYhxUoL3cSMTLMOnfDX0mw3aulKh5dsrpIwqXDlm6W/zHn7JQ?=
 =?us-ascii?Q?FuJNKEQb9H0tQbV2iYR2WrWZ/FmLMqKg+t6mDhBksU9k7IfloCQNqRCTtm8u?=
 =?us-ascii?Q?fMPy1aZvzWff4RZ2WMLSG0/pkxNxOpjgf4lk7qBqWrnD0/VkOK4VG4R2M2tO?=
 =?us-ascii?Q?Hy6aDG98m9dRipG16/rO3XQoNlilieMi3kz6QrNUKUNL+jmyt6nI6QCBGnGE?=
 =?us-ascii?Q?Ct0gfjcyNmb+qwEykgMwRXzUFX+F7hF28V5PbY0Lbl+gd3VaMafBaC7YldEU?=
 =?us-ascii?Q?4pzInv9fR4oPLUVIWcwW3J5vRpgvvFDnNl/Wx5/LwSLegNNjA0jeNqIVw1fP?=
 =?us-ascii?Q?2wQogSb1wqPoh79sp5ca97VgDMbSrRaiCQr4tKtHE2EAP4mPvdtdeZ1a8PEp?=
 =?us-ascii?Q?4kM/5NLjc6HsmDOmwPowe0zI6nEFNnnA4TEiJSKb/yaBn6TkAexA1DKe/F0X?=
 =?us-ascii?Q?4llwlExxU7BZzstZSd59YJGyQFT1Gl/DKGkeCyUF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb116af-6884-4b76-104b-08dd8272ade3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:25:21.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkAIj/VFo1eT5ZbK6dgU9qs3zcRc9nM7xhQ3bWcMGXM3ZAjiAB/yBVozKMP3zxjwRtx133QkBXgofSu3KObJtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492

On Wed, Apr 23, 2025 at 06:46:53AM -0700, Jakub Kicinski wrote:
> On Wed, 23 Apr 2025 10:00:01 +0000 Dragos Tatulea wrote:
> > > +static int
> > > +bnxt_queue_cfg_validate(struct net_device *dev, int idx,
> > > +			struct netdev_queue_config *qcfg,
> > > +			struct netlink_ext_ack *extack)
> > > +{
> > > +	struct bnxt *bp = netdev_priv(dev);
> > > +
> > > +	/* Older chips need MSS calc so rx_buf_len is not supported,
> > > +	 * but we don't set queue ops for them so we should never get here.
> > > +	 */
> > > +	if (qcfg->rx_buf_len != bp->rx_page_size &&
> > > +	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
> > > +		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (!is_power_of_2(qcfg->rx_buf_len)) {
> > > +		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len is not power of 2");
> > > +		return -ERANGE;
> > > +	}
> > > +	if (qcfg->rx_buf_len < BNXT_RX_PAGE_SIZE ||
> > > +	    qcfg->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
> > > +		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range");
> > > +		return -ERANGE;
> > > +	}
> > > +	return 0;
> > > +}
> > > +  
> > HDS off and rx_buf_len > 4K seems to be accepted. Is this inteded?
> 
> For bnxt rx_buf_len only applies to the "payload buffers".
> I should document that, and retest with XDP. 
> 
> I posted a doc recently with a "design guide" for API interfaces, 
> it said:
> 
>   Visibility
>   ==========
> 
>   To simplify the implementations configuration parameters of disabled features
>   do not have to be hidden, or inaccessible.
> 
> Which I intended to mean that configuring something that isn't enabled
> is okay. IIRC we also don't reject setting hds threshold if hds is off.
>
> Hope I understood what you're getting at.
My bad. My question was too terse and not generic enough. What I meant
to ask was:

With this new API, should drivers be allowed to use high order pages
from the page_pool regardless of HDS mode? From your reply I understand
that it is a yes.

Thanks,
Dragos

