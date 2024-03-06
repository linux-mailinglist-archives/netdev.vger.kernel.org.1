Return-Path: <netdev+bounces-78032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D142873CB6
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DC71C20D83
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580F137938;
	Wed,  6 Mar 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsBG46XW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B3137926
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744214; cv=fail; b=J0hxR0I8RrhnIgxpLZtDZE/7fx2nwuKS1lI5BKMGP80rS++gIKF0HuMV27maJ6iyjJ1EAAh/R85TplgzDGJtf97uN9qfn3sBl5y4S62QKsEdK8gw+EHe1+aY4/KEUSBLb8HWnCQmA+bjDxZPabayFZSC5Q/Gaa48bHZgWPuLs0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744214; c=relaxed/simple;
	bh=ZhwQAA+9Gwx9PHjKjeZlUW84WnA4CbWAF56pad4Zet8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rD1FJ2nIPVuFJFNnYGNmZ5+UbkVFXt420hK5AjgwE3CzTz4sgmTHO+/7mg6evbMneuoQyAYlJx2RKqI7giiq0nPgPOi1G+KABZZyS2KXEy4yQKYUiJNc/EpbcF1T57Z0UnCG+s1NpcDSHYHzkg/IfOiMbus8RCtUwoqe9ogkj5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsBG46XW; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709744212; x=1741280212;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZhwQAA+9Gwx9PHjKjeZlUW84WnA4CbWAF56pad4Zet8=;
  b=IsBG46XWvkFgEKIFoDyTkh+LMlgwy37CT0Bi7D5V+espE7fBhD9k2rkR
   41SQJWVKzLyxLQw/InGC7apXxaTIaHBoCPCk0XB/ETjIekb1d/11MwWhv
   1CGYnJrMHjGW0CF3sE3267EQG6rBgO1LCgOmY7zk0XwSrRUuwsM7A/bbc
   li4rh/O9t4qhDdEK3hthOM4bIxNsMDlCfmEvfxXeKwJyyO5t3Kle5Qj31
   YwRIqqYpZYclJMRhKgZTvTuO17+DjV5IEXzazp4ytFO8cRk51wsj3piC4
   d6JDTMUGsAhvWIafDz9RRhZyZfhwdtKu2hy1ar8k31hR2mqnu98hSMdek
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="14945432"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="14945432"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 08:56:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="14494382"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 08:56:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 08:56:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 08:56:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 08:56:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAjSAW2SAO9+aEhtchCHMAwkZW/SdYHlX0HJ401F0zz2llIOwK5g5otrU4D82vwjOmsQ3u10pGUDbpqzI87k+itv6fo/0YYgmX0mQVERQnokQziAvr7GyO6nxFhKQ3GSn3kwOMMA0HGulByPJOxc0FrmQ2nv1PDgUf+LAhPg71l4vDijoATuRhAxM3qcKwQ/bPFe/L73X7TGRU2OTEeqUKRTaNwKa3tol+84koLuQXOHS/7jX84+Rbn7ButfIhF1VbiunGThbTielNBMUtxOlw5/Ao3NBB/++jjCsECJWSMNdddRCBF6pk8pDzLTDnbZiA3FbFPoJXTeF0d2Oe7BGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxnmMezxNY2oLwLIV8bVich9Z+UxabYIros0+Lzzybg=;
 b=O8ew0M8dTkSrMKWql0PDOIvuVBuJZXic8n5lKKHlvzlpqQsY5evcDdKdSECyDEj3EUET961LueLTskprcUi0bEnIFiUHKXQz+Xv6vs5tQpEdM2X2gr4SyoFgQU5rat11URUc4IT5TGIP/iwrfw0ugOL1n6wl5Caa/wXBtFNsg64u9jpryf5QTkoBN5/19ZtbOey8VAzVaWTjgqgp3OZgRb3Fwz33//b0MdfA5d2LoDnqoeE8eZ62IWGS0b8nuGH/EfHgIaOJ34MLAtXRgG0hclR3Sgr6eCIGNzK6ufM/46ocGPz8kvGTDkgTiCtzYzGSaVbLOKoz7U+UNHCqM/Tmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB5815.namprd11.prod.outlook.com (2603:10b6:a03:426::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Wed, 6 Mar 2024 16:56:44 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 16:56:44 +0000
Date: Wed, 6 Mar 2024 17:56:33 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Robert
 Elliott" <elliott@hpe.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH iwl-net v1] ice: fix bug with suspend and rebuild
Message-ID: <ZeigQdj9K6CZocbL@boxer>
References: <20240304230845.14934-1-jesse.brandeburg@intel.com>
 <ZeidykgnELeMx6xm@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZeidykgnELeMx6xm@boxer>
X-ClientProxiedBy: WA1P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::21) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: cefb05d6-c39b-4752-b570-08dc3dfe6743
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6vx4n+pXvKNi8eE756jMG45ZM4cbQjMFB5x5GnTx7k8dlI8eKEniHNjsOmSMhwJalrpov3Vuy2BqVV99NhB7zEC81412nojUFenIcEhZ4JaRf9KiWFXOkgALwIjeAoOtQPAP6u1ff5IIHMLVDOi22+M+Lu7zQizklUDGaYY2n9VmMMj0N/wTOohjUYpY8SblpWB/d1uWh4iKFVrAmSOEL97brA1o2pAUwpMo+EG2c3Jz7Mbs8vYLStADmZlzhrjhf9q/Wnt/5u5HwgleMT0tX0heyIPeuRIb8XyWR2CeSnAuUrEprKMpQoAkKC7FVHdG/nMeDA03WzdLAw4SbyFrM8kjALIvYt0oVtDu89kRWzfYXhOYGsc6ggyu6u+fEFli/3pE93HbsEgMzgor+6iXsH8a5uC0Nhtj+Xhf/CimjYnkACquQYXw7MqT4C8KWBfRYJIuwdI72kpSfgUA9TWbMzGcm9pq+QJWqtktyjaNOU6azmyLJoA6fe8S2LgN4wdXPP/pj04UQ9BNAGDlKhOlNm3BMgn4byut81NvhgMJXauqPiMzb4c2K7UnI3IaGBiZw+BddPW0JROr8CdZ81KmIeNDnGru4ZxYqcUu+2GGDc69syxCHKliZiCL0Gaf6a0pxE2cwOwzOTUF7Yyddu903pz75I5Pe03e+QTCP2htHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vS1XgHthjiGqqfSd+WJGvH+cVxCI8X9+Xde3VHLASdrJs8oNvs+nQ41r8cTN?=
 =?us-ascii?Q?kTSH66XlZViVILTlKR7CpV3ugKBHwe1ccJPpx1RM/EIoNVj1TjQFW8+oSkQ+?=
 =?us-ascii?Q?Q72T2mjh2fP5L58F6eRzqA+JptR6xmPxBrsCxjGWEHQu1UJ2o2a1tFs2ctB8?=
 =?us-ascii?Q?ZzyMCzNknDTxI5r5w8VTVUjAZy3xCkou6dong3qWyMCiWHPFB25xLRuc5eyV?=
 =?us-ascii?Q?KsVssietYz5CgT6fsdipfemQm/OeH2oEYf1xuHK7PHFimgN7y5KlLC9yUqyK?=
 =?us-ascii?Q?QbFSJ/kTAXjklM75w3XoaKew5ETsUR6R+L0EsTf7IuLnn7A9TI1k1ksZKuY9?=
 =?us-ascii?Q?ZFDK0PJgtK1fcd4jAci14z5J00EcowbDjEcOVsEw+anOe42HEOERXDU06Mvo?=
 =?us-ascii?Q?GYWGSYe0VtAxjmbPyUeOt+mQM4+N+P2P8WAS8PpEGykn1zIAFcA++6S4NKeg?=
 =?us-ascii?Q?QBsPoR5impwbluTyBeqTlJqzC0CWgpVdln+PnkkF8DTlNpUT+tMba2DIv+sL?=
 =?us-ascii?Q?24UOlDET8jYjfsKw1Sr9y5Z5jGteEOS1H8LLOKXVIOpFF85z80GBqEuyQ6dN?=
 =?us-ascii?Q?fc6EjysFq1BNrKRa+sHIVJZ/K+U25hPtyLnxRYoz1wGb+SYoLfs4YXPzrPeL?=
 =?us-ascii?Q?H8Do0YfbDC73+CBGouxXIN1Dwm/CCj17B1oMtm1EcGrrsVg3q6jMg6bVy+t0?=
 =?us-ascii?Q?Fo0xrP8GnomOgkyCN1zXBU3nBh24SlvT9upksC6YVUTmbkuPRkTrbX1r0XdD?=
 =?us-ascii?Q?z6dd2yAmgYDy+W062jYq2JXu9e13JrQeb4G/oZnZJQ85ypy6vx9AJezKnVlL?=
 =?us-ascii?Q?Ix1vVHg8PRpfIzVfZdD/S2ocrIKsoL8MCX1RwYDQIQIDlmb3AMVGNTqlWKJm?=
 =?us-ascii?Q?4PHwYNLVSm/uBMC9G6D38pLx5vPNHlLKFJ6MruqbIjnDGIzkQMmiUVo+3Rr/?=
 =?us-ascii?Q?QZf8wFANf+cmavWuPZS81Qd6tcW6QcxH0IbY/IWE0HmPMhfQ62V4bp/Z/j9O?=
 =?us-ascii?Q?ss/aVilyo8q688nUv9/6HcyYvAOGazkIikzQ4Q9VeB943dLoiQOyWUxXCNJn?=
 =?us-ascii?Q?cJFHbltlwk553RT4IrNKhOGDU1x5PYVYg76B+v2PwefIgCDKSkRWBp6A523L?=
 =?us-ascii?Q?IGEBebxRvCT+c/7o4chuZBE6WKuBUe/20a4jEeuRtBe/dns8zHXUlgJMpxVv?=
 =?us-ascii?Q?TcML80SVFyao32mDafto35SEeujE7NOhWSINVbVPolslwYGf+2wnnnQjca7v?=
 =?us-ascii?Q?lmmkFgN7xykJ0lsQv8qWuSCx3zHpex+BOBzHC1xAplCX7BPNaL/Byd8Z/TA7?=
 =?us-ascii?Q?uNQQehjT0zxb4NoV10uyxrrOEP4LOV3TXbVEDilep61uOJYUjo87Y42vP8vF?=
 =?us-ascii?Q?pZGQeAT59DqSLBuZ2GsZV+IJ8oHdLFWMy1GPAsEPq+aqpDeLsel4CQUWC3oW?=
 =?us-ascii?Q?MiXWghjDrXMl+qaTXudIe195A4VNjTouuNgou68LxvYZBjAJOl4S/4ifsQh2?=
 =?us-ascii?Q?z7N47Da7doNWN5N6nzWD9ujP61CYpXQsUCS36U6XjwWzbTLMgzymo1EEExFk?=
 =?us-ascii?Q?5QOs3DvxGopY81nsfCVosWtaPDtEM7Xw58lry+RMoaZ5OFy89Tzrmdu2X4K9?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cefb05d6-c39b-4752-b570-08dc3dfe6743
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 16:56:44.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSpGF1f9Q+cUZ3IJtk9LNI84MPe3GGcAY2+goDHEXVj79alE7/718Xx8/ZjjH9rmbwcLnVm+rZXqRcJ95Qqa2FFvu2pgHvjaGkXinMVWqvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5815
X-OriginatorOrg: intel.com

On Wed, Mar 06, 2024 at 05:46:02PM +0100, Maciej Fijalkowski wrote:
> On Mon, Mar 04, 2024 at 03:08:44PM -0800, Jesse Brandeburg wrote:
> > The ice driver would previously panic during suspend. This is caused
> > from the driver *only* calling the ice_vsi_free_q_vectors() function by
> > itself, when it is suspending. Since commit b3e7b3a6ee92 ("ice: prevent
> > NULL pointer deref during reload") the driver has zeroed out
> > num_q_vectors, and only restored it in ice_vsi_cfg_def().
> > 
> > This further causes the ice_rebuild() function to allocate a zero length
> > buffer, after which num_q_vectors is updated, and then the new value of
> > num_q_vectors is used to index into the zero length buffer, which
> > corrupts memory.
> > 
> > The fix entails making sure all the code referencing num_q_vectors only
> > does so after it has been reset via ice_vsi_cfg_def().
> > 
> > I didn't perform a full bisect, but I was able to test against 6.1.77
> > kernel and that ice driver works fine for suspend/resume with no panic,
> > so sometime since then, this problem was introduced.
> > 
> > Also clean up an un-needed init of a local variable in the function
> > being modified.
> > 
> > PANIC from 6.8.0-rc1:
> > 
> > [1026674.915596] PM: suspend exit
> > [1026675.664697] ice 0000:17:00.1: PTP reset successful
> > [1026675.664707] ice 0000:17:00.1: 2755 msecs passed between update to cached PHC time
> > [1026675.667660] ice 0000:b1:00.0: PTP reset successful
> > [1026675.675944] ice 0000:b1:00.0: 2832 msecs passed between update to cached PHC time
> > [1026677.137733] ixgbe 0000:31:00.0 ens787: NIC Link is Up 1 Gbps, Flow Control: None
> > [1026677.190201] BUG: kernel NULL pointer dereference, address: 0000000000000010
> > [1026677.192753] ice 0000:17:00.0: PTP reset successful
> > [1026677.192764] ice 0000:17:00.0: 4548 msecs passed between update to cached PHC time
> > [1026677.197928] #PF: supervisor read access in kernel mode
> > [1026677.197933] #PF: error_code(0x0000) - not-present page
> > [1026677.197937] PGD 1557a7067 P4D 0
> > [1026677.212133] ice 0000:b1:00.1: PTP reset successful
> > [1026677.212143] ice 0000:b1:00.1: 4344 msecs passed between update to cached PHC time
> > [1026677.212575]
> > [1026677.243142] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [1026677.247918] CPU: 23 PID: 42790 Comm: kworker/23:0 Kdump: loaded Tainted: G        W          6.8.0-rc1+ #1
> > [1026677.257989] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C620.86B.01.01.0005.2202160810 02/16/2022
> > [1026677.269367] Workqueue: ice ice_service_task [ice]
> > [1026677.274592] RIP: 0010:ice_vsi_rebuild_set_coalesce+0x130/0x1e0 [ice]
> > [1026677.281421] Code: 0f 84 3a ff ff ff 41 0f b7 74 ec 02 66 89 b0 22 02 00 00 81 e6 ff 1f 00 00 e8 ec fd ff ff e9 35 ff ff ff 48 8b 43 30 49 63 ed <41> 0f b7 34 24 41 83 c5 01 48 8b 3c e8 66 89 b7 aa 02 00 00 81 e6
> > [1026677.300877] RSP: 0018:ff3be62a6399bcc0 EFLAGS: 00010202
> > [1026677.306556] RAX: ff28691e28980828 RBX: ff28691e41099828 RCX: 0000000000188000
> > [1026677.314148] RDX: 0000000000000000 RSI: 0000000000000010 RDI: ff28691e41099828
> > [1026677.321730] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > [1026677.329311] R10: 0000000000000007 R11: ffffffffffffffc0 R12: 0000000000000010
> > [1026677.336896] R13: 0000000000000000 R14: 0000000000000000 R15: ff28691e0eaa81a0
> > [1026677.344472] FS:  0000000000000000(0000) GS:ff28693cbffc0000(0000) knlGS:0000000000000000
> > [1026677.353000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [1026677.359195] CR2: 0000000000000010 CR3: 0000000128df4001 CR4: 0000000000771ef0
> > [1026677.366779] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [1026677.374369] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [1026677.381952] PKRU: 55555554
> > [1026677.385116] Call Trace:
> > [1026677.388023]  <TASK>
> > [1026677.390589]  ? __die+0x20/0x70
> > [1026677.394105]  ? page_fault_oops+0x82/0x160
> > [1026677.398576]  ? do_user_addr_fault+0x65/0x6a0
> > [1026677.403307]  ? exc_page_fault+0x6a/0x150
> > [1026677.407694]  ? asm_exc_page_fault+0x22/0x30
> > [1026677.412349]  ? ice_vsi_rebuild_set_coalesce+0x130/0x1e0 [ice]
> > [1026677.418614]  ice_vsi_rebuild+0x34b/0x3c0 [ice]
> > [1026677.423583]  ice_vsi_rebuild_by_type+0x76/0x180 [ice]
> > [1026677.429147]  ice_rebuild+0x18b/0x520 [ice]
> > [1026677.433746]  ? delay_tsc+0x8f/0xc0
> > [1026677.437630]  ice_do_reset+0xa3/0x190 [ice]
> > [1026677.442231]  ice_service_task+0x26/0x440 [ice]
> > [1026677.447180]  process_one_work+0x174/0x340
> > [1026677.451669]  worker_thread+0x27e/0x390
> > [1026677.455890]  ? __pfx_worker_thread+0x10/0x10
> > [1026677.460627]  kthread+0xee/0x120
> > [1026677.464235]  ? __pfx_kthread+0x10/0x10
> > [1026677.468445]  ret_from_fork+0x2d/0x50
> > [1026677.472476]  ? __pfx_kthread+0x10/0x10
> > [1026677.476671]  ret_from_fork_asm+0x1b/0x30
> > [1026677.481050]  </TASK>
> > 
> > Fixes: b3e7b3a6ee92 ("ice: prevent NULL pointer deref during reload")
> > Reported-by: Robert Elliott <elliott@hpe.com>
> > Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Well, that refactor of config path introduced lots of issues. Could
> validation folks include a short list of tests they tried out against
> tested patch?

Sorry, I got confused and now I saw the same thing Simon pointed out.

> 
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lib.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index 097bf8fd6bf0..0f5a92a6b1e6 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -3238,7 +3238,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
> >  {
> >  	struct ice_vsi_cfg_params params = {};
> >  	struct ice_coalesce_stored *coalesce;

struct ice_coalesce_stored *coalesce __free(kfree);

?

and drop explicit kfree()s altogether?

> > -	int prev_num_q_vectors = 0;
> > +	int prev_num_q_vectors;
> >  	struct ice_pf *pf;
> >  	int ret;
> >  
> > @@ -3252,13 +3252,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
> >  	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
> >  		return -EINVAL;
> >  
> > -	coalesce = kcalloc(vsi->num_q_vectors,
> > -			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
> > -	if (!coalesce)
> > -		return -ENOMEM;
> > -
> > -	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
> > -
> >  	ret = ice_vsi_realloc_stat_arrays(vsi);
> >  	if (ret)
> >  		goto err_vsi_cfg;
> > @@ -3268,6 +3261,13 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
> >  	if (ret)
> >  		goto err_vsi_cfg;
> >  
> > +	coalesce = kcalloc(vsi->num_q_vectors,
> > +			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
> > +	if (!coalesce)
> > +		return -ENOMEM;
> > +
> > +	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
> > +
> >  	ret = ice_vsi_cfg_tc_lan(pf, vsi);
> >  	if (ret) {
> >  		if (vsi_flags & ICE_VSI_FLAG_INIT) {
> > 
> > base-commit: 6923134fc6b62d7909169b3ad913ab72ee04233a
> > -- 
> > 2.39.3
> > 
> > 
> 

