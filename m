Return-Path: <netdev+bounces-89390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360288AA2D7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A004E1F216D7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34AC17B504;
	Thu, 18 Apr 2024 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VVrO7w1S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B986E176FA7
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713468755; cv=fail; b=Ih6g33iPSLdnW/gRZFVGr5eNHbDNotjv0jIoyVzV+Cl3A5ccTjDpjE+mz97cgC3L4zblmKQ+k50pBlQRSIcgDl8VENUviDk+oq40OC6/TOGKlJEzHooiSKmu8DsPo+WOuXEuJlYNt1Zw5TrqIy6mmgFe7OFSIidQFUQPq8aNvuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713468755; c=relaxed/simple;
	bh=gFJNP5RrhxekOeqc3fA59T78GWDl2IXBpWK239NqFkY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=D0YtS1CSgg3Srg+bxT09WMhsdC+yyWwdsEa9oPGAPUS+c7qWHSo5gNNFWD+iVLF76X/zPjlagcG6Ty3tqLyaU1qLi6zvBEg/wRVahf40Rh4pkzf5S9enqsOr0XTLLxDvr35yZwNt1ZZAD13fXOIs1uNdgNO8PRdgZAwu4oU+Gqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VVrO7w1S; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5MEDKId3ZrUglRPcbAj1UNSOAU94yhhpojc0aE5LLNul67+1QbGk2wyS85ek9KSkpHg23cdd7XRK/ehVNUbt9wuVISObl+tbysd3MSZApo7Hh6FPJ6TBcoV4TJYbxrGMkXsEJnT+eE/wMluINVZZaEk1KWUtCPWLE9AywGhQxekkwrlEwx23yJkEZ5hj2BYs2Ugz1A3u0GhVbUgS2J84E/sWDu5mFPIHEnG3i1UC3ByWha00G5jDPA1wDsvPxSkFliP4k4tDR4IoxJvo05ZsO1AB1jYajqJQxTKzeLOsgHfwNR9rRS1rdAVuf44CNYD/ArnRVtfpQKnryyUGYZYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90AyufbDm6Xw+Biri3wGKMSNi7GTMNW6oXRc0ro4X1U=;
 b=S0HurVDD5J2hJ7fG/CyGiQk8MG/mZy5cxU6oVKpHSQrCj27nsJKOrQGTqDspab6iCTCMX2Jh7snP+Mmpw36FhbKZ+ATxss77Q2zriSWAfQQ2wY3uLG/cBOoPQTNFSAtv41EgCS2+BWNRKWaN2FchWE9hkYm9Oqr+P6TG5xikbPbHT7RacAxHTSjr4AOXvEeEfR3Cy/m36Sb6OSAqLQe4F/WoZHB4A+iRaz9oeKtnWbjpAZRlRFcj1yw3xl2QnnfV4KzPBbsR7y3oT5Oyeo8dfUi1fXrYQhjppfGjQ+VziqtJLh9bzqNSDG0hM2VcOI/92rksT/znIn8W0m74o0ptdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90AyufbDm6Xw+Biri3wGKMSNi7GTMNW6oXRc0ro4X1U=;
 b=VVrO7w1SsopokNTHxOdAQvKBYE4bQtQbF02XaVIVr7+q3vBZO7htPf6FjGLsNv8HqRLFmcbIF06sDCpw46nUjH3QSLCVwtq6V/f0jAjDkmBGTitZDZ2VWQzf82p56IxWY63PcDDBIbEySCRkkSsz+zaQIzrdTHFUKj/LhGL45cWMRMLAJTMoGGC20xdIEzTfnMPZS2jSUWtFqGoMx42rxbtHYuPZ/bcF7xEf1wUP7FkktDrdmlkISsQOAaR3sko7Y7Lh5aE+ttMVAgsecG/m/QQ0o48H0oI7WixiUU/xiEgafRxl7KPRzngCbI5kJp80w1g8OlZAGwXDs0H7pI16YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 19:32:29 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 19:32:29 +0000
References: <20240418052500.50678-1-mateusz.polchlopek@intel.com>
 <20240418052500.50678-7-mateusz.polchlopek@intel.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 horms@kernel.org, anthony.l.nguyen@intel.com, Jacob Keller
 <jacob.e.keller@intel.com>, Sai Krishna <saikrishnag@marvell.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, Ahmed Zaki
 <ahmed.zaki@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 06/12] iavf: add initial
 framework for registering PTP clock
Date: Thu, 18 Apr 2024 12:28:06 -0700
In-reply-to: <20240418052500.50678-7-mateusz.polchlopek@intel.com>
Message-ID: <87sezieab7.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c35dc4b-6ab9-4919-bf69-08dc5fde4937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wnfzDu5JyGFRe+Yc9fkQlyuzwIhGHM1CFYfuYgmxG0pDQlkgP0OShQvDw/TDL8sIgFCfxdCoavUgJEttXUWlmRoINWGqMPkDycsiLKg1lbMAKXc+I97f8ZVeCaEqNpBsPON0xJLyfi42MNUxOsQDOB1mX5r7iD1M3dQtsB7tqZ3Mp78WWcVwkVh+L+TI2q7D0X2ne9oHlbZ2ih1UTvetLEVVP9IslVD5AnJkYN7EH9k5WlmQqMiCt8NaJCSFW1M7HzHzTVyA41YX+UWmtNQganyuR1yl58FYnl+29wvxWK5cGPn6sLDTqASFYC2FRQwE5SRw5v5zJBWwufivN/LClG/rumSxcS7kmEpw0zhOc4LzFvrLI0h+mlbr6utpFslbVh2b2+diyQrgWUvm3+FU66YP5IwqemKbDiSQl7GUw5NF6ciWdzolCCB8Ujs4LTNoQ+rEUJ+6YtXMZwmOcO5kyLsmtpXmHJP3mEvXFwvRhbZ5l1CPVUNZGZ2WpuLR8SO3em3/5WGuS1jbNG9SPJonz+qp5+PXoItRrwJ9kQqg4Q37EisW2LSeOfOkrdhvHKjYZWGTQbG4Mm84jDcVV4KXifQKkdkY2MxEW5X7w5pIIOD8a0QnKWLyZHrjS9YBD2NaFk4K8IzUOhboHbFrYKuf6o/M268QNif6yDvmpvV4blI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?61zEAE7oPl9MTPxL5LxRJfQRiarvo2LPgPBC/RWTVXXs62JF2oivx2W2IgiL?=
 =?us-ascii?Q?P6v5bfuJ8U6eFtArt0yOiqsCAhJoyEmllM+dbYBj06pmqaR7hPNAufhr7Wob?=
 =?us-ascii?Q?/P5tMVjgV6CSbPtttdAS6eQI5qtnVNWYdQBtMEzOh84H0SN8UAM3ym2ThcCf?=
 =?us-ascii?Q?np3yQEFtnU+Pn+3GgzcRQg0AdjuVnPleBJLU15G60FXHYcTB8P8c8exCmazc?=
 =?us-ascii?Q?x18WqVBTLjW3DkTo3BckmIVZ4w2mYR4ZkffIN7iyNFewQ8arvbSr9U+KK5hq?=
 =?us-ascii?Q?TSyZcaqAB8iDotfdFRyRQjP6R2wpdBkX26ahqbFUhFKzkyb3Fl72rWgl76SU?=
 =?us-ascii?Q?q9X8lPyiBfeevNeW+EXBIVWNQ7RS/xDAwXCfUA2LtMrYz7jc8j5polHEpJPe?=
 =?us-ascii?Q?w3qE+dX7jvqLbqgL8WzHsyx1M5AJ4dRLSEjAU1JoLZrHGMDWB+wqwH/pkogG?=
 =?us-ascii?Q?bTKpkNeG0O0jtp2YQzt1ufiPUvP7DWj0dyNG/i6fEAY3csKkaP4JIM9U/c7z?=
 =?us-ascii?Q?/kZuYVfFVaOOl9xu2TBevqXfcD4zOyRq+Xwyw0kvdKDHzp7qVzfJ3IN5uDoo?=
 =?us-ascii?Q?tamoBtrovYX2mG4SKwOxhqvIbY/nF+BKDge+1XAom5V9cOBzQZAERcujg8l8?=
 =?us-ascii?Q?2UKb0QQ/JgO9bHrK3X5Djsp0UZ+/0xg5DIGznqkMlMcYzGzFfpjLvLAcN846?=
 =?us-ascii?Q?C9tAU9I5H0d7lvTlxaGtTpbTZ8KYsD8o0iIrXTqyoIlGWG/jDN2S2w0KqBAw?=
 =?us-ascii?Q?+v3xyAWjt2pWQoXM2JbBtHUPTS6TFuH7U2W8+frW2UGFIf1F43d6VN6/JWrY?=
 =?us-ascii?Q?05+VcnF56ahqNybbBu2Pxt8bJL/5+IivmDoRO53jXKgajmOTXtRCeb/DqvtA?=
 =?us-ascii?Q?WXTBrUHNWS5+kTxKu+u4S7fYLLhw7HCEb4Q5UH1WDq3RigPlKeeH4m+LxZWe?=
 =?us-ascii?Q?fNw6Mn7y2Cfh4wC7/h/anzDfArMx9tVZDr3tpD3lKYRqx9nLYWHbtincSgOd?=
 =?us-ascii?Q?mGT6gKgqDFn0+vO+8zVdd4ptEg9X6sU7gUJoE3q0PWZ/YizaXETNtePeCbgP?=
 =?us-ascii?Q?/p6mC60rjeujXFTJG+I2YVAxP65njwHR1PYQRXWilbKEGCrhL5Y2UotqW4b8?=
 =?us-ascii?Q?5eFZ0JUBZrcMBOLY/zOjmL76jWXe8V3kC18TDC4AtOZPZsywoohiW7beWxaX?=
 =?us-ascii?Q?YjT4/sDYD11M8RWHNAbKi1yjgb/9dNyef1ODJluh1yL7jcG7fCQP8KxL4y77?=
 =?us-ascii?Q?hSdX+7NrEkELlMBoKsifATpeWnRp8L0HvzXrKHFpVE0moEaOXG+mh09Ma5q/?=
 =?us-ascii?Q?9/nR+YcE9mjeJkaNtnzjVR+WAIQwyppN19D26G25m3KBYl8oT3rqPHmFYfnx?=
 =?us-ascii?Q?/kNPtpHEKzz/4gCXYngGpwOXYW9zSo43NabBMOO+XbyhQU3GgbDGnhma/7Wc?=
 =?us-ascii?Q?RAIS+gsh1vXIiR74GE4fGVJbvVpFoznqxeRotAi+Htzpad/hpSsWBm1a1V6P?=
 =?us-ascii?Q?kFB5ewoKRIQ1hA+Y7T8/qPUKz0CFsTngqY3Uf9Ii6i3rYjlP3eHZANKANe8d?=
 =?us-ascii?Q?hKdYGhjPnd1Xvtc6V9Nfteagkg1+LtE1ToyjuNWLjCUSpkrsdbhhFhy0gfUC?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c35dc4b-6ab9-4919-bf69-08dc5fde4937
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 19:32:29.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2/NaodU6zzDvttInbcQEDA+wzl64cX+oSA0+sKJkRh5jK5nIOi9aEIpaOZ+2kBs9icKwhPkZQJC7oN6YH+DdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820


On Thu, 18 Apr, 2024 01:24:54 -0400 Mateusz Polchlopek <mateusz.polchlopek@intel.com> wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> Add the iavf_ptp.c file and fill it in with a skeleton framework to
> allow registering the PTP clock device.
> Add implementation of helper functions to check if a PTP capability
> is supported and handle change in PTP capabilities.
> Enabling virtual clock would be possible, though it would probably
> perform poorly due to the lack of direct time access.
>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
<snip>
> +/**
> + * iavf_ptp_release - Disable PTP support
> + * @adapter: private adapter structure
> + *
> + * Release all PTP resources that were previously initialized.
> + */
> +void iavf_ptp_release(struct iavf_adapter *adapter)
> +{
> +	if (!IS_ERR_OR_NULL(adapter->ptp.clock)) {
> +		dev_info(&adapter->pdev->dev, "removing PTP clock %s\n",
> +			 adapter->ptp.info.name);
> +		ptp_clock_unregister(adapter->ptp.clock);
> +		adapter->ptp.clock = NULL;
> +	}
> +
> +	adapter->ptp.initialized = false;

I think teardown should be LIFO order to initialization. I would move
this line to the beginning of the function before any resources are
actually released.

> +}

<snip>

--
Thanks,

Rahul Rameshbabu


