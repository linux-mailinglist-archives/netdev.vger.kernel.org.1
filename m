Return-Path: <netdev+bounces-123243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246059643D8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0146287559
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D61A704F;
	Thu, 29 Aug 2024 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBPX3krO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1F1A7052
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933029; cv=fail; b=crczCx1Aknt6gKEF6IqffoAsYtFjyumJLAoaA1qzCeWpBgPJYSTIJXoqvG/iVcpXAqiix+k4Y0Ksgpz88zDCyvoEMGmPz2q/bWzYuh4H6I0Bl/4vdfY+jlQ+a025b4HAVKBIDrEhtaNCtrNdacjIOsawk0tbxgNvwGZeqmSDJac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933029; c=relaxed/simple;
	bh=Of1bzXPxKs33P/YO2V7WWCDPNRRyqRghNLpRCSiSSCc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kckmIWH5R4fwc4iYDK0mIn5AgwWYdPBaq4T7jVJt4kffvp2Bad9fQry6irznH3Gxg9yfdW60V2QB3A9ktFVTYmX1zjD1xpUyIc2olepTwgIK1sLFvcsP6MfkodyENJZ269H6NFysf2Hi9mn6NeCLP0oJKRezh3Uayq4KocNREkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBPX3krO; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724933027; x=1756469027;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Of1bzXPxKs33P/YO2V7WWCDPNRRyqRghNLpRCSiSSCc=;
  b=IBPX3krOpXTxT+MWnD6Orl4WZQJDBB0j1r6QuClsorDZGRU6c8yukhOC
   QTkxBBfneN4iFzDz0Exe0Q+l6ogwdhmS0bnzGL2TcUQ5CDxCqdiR9N3FF
   FXG8stl1MHzMTEuCeSRUl/Cl8keIwRt6C66rjHWsxTrDIDuoVmWBIJeii
   oTXczm/exxVbTDxxw62CJY6lKOwpZ1kNc01Tx3pA0ar4neWBR36pE9s0u
   /D922mCluICICoycforZORFytJQsszGGyYTzXKcscPUG89CyedUy6UGeQ
   Jnk5ZWK9vdz9yR3gIH7dL59IEpNlcvabTxqgPL6yBUFGP5GAEp1dmIJTv
   Q==;
X-CSE-ConnectionGUID: 6SUe/Y0DQWujiiEgIhUr/g==
X-CSE-MsgGUID: fqthNy7WQVy4IrX5GWa5ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34894086"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34894086"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 05:03:46 -0700
X-CSE-ConnectionGUID: Z+ggoeoXQ5GlnBsSB9/DeQ==
X-CSE-MsgGUID: vMjuJRMgSCSeIZk+5FCtKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63889838"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 05:03:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 05:03:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 05:03:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 05:03:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 05:03:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enjTPAr9JhFph92Lc0t3vOGdmp6PQKfzrJpIJ4gbod1+GAgLIsEL0OidjrP+kdyr4KfApZORe0gDRLCZnEpx0OtA27Oaz3o0rAnu9W+r54bDhS1p2caivF3gj0pJrD9aWAD5w+9Y4rOfccrXednQbmzgAQMHISot+YeUQ3EsW72enWtAYGSwT0FcdOvHWpjtpfFP4VmCziOmq0C28bW9izeLHY7qNx2g9lFxjBKe8BmFZOGZ0UmFMiDNG9MQBF2FwxbNTbkDDZ85n4Vqbu08EHwagc6YDIBnP5j9XkutUxMKrPChnoacvAgFY0qXg/r8mJcICNwONwgJWC5RheDnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUbKesLCpDzdQsUztNClKUEWCjocdZ7LFiAOcQWCOlc=;
 b=bDeriRS1WE7Er5fZ+FVf8D3x/OSIeP2qMS0WqIxQNZRZ76QvNV+o0A5oHAJAKZUfABSB0xXtIbXd7g2oXE33yB8RQjBlnpkVw8A4SS4GoTFu0pPYQXGPE9iR6FfE/6JwsvDWfJ+uE/UxR7SLNdb6UpaxEiRUl39hJNpZG7OjjNgu+4Veo1NzNT6Y7ZNgEbBCClnyISODI2xC/jHbUS9grAZxyIGHjKFcwH6yI/+4sdEkoFTm3FW9z8RrlPpN5LvCq0LFPvIb2n/bwCmSvzhkT6u6UaAFsJdSw/BxL9+3CIPP2dNA7J16zdMtnXGC0ybi5XeKL40YDsa/KidrdnT8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 12:03:42 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Thu, 29 Aug 2024
 12:03:35 +0000
Message-ID: <85f06f1f-2253-42a6-add3-ef7bad199322@intel.com>
Date: Thu, 29 Aug 2024 14:03:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] sfc: implement basic per-queue stats
To: Jakub Kicinski <kuba@kernel.org>, <edward.cree@amd.com>
CC: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, Edward Cree <ecree.xilinx@gmail.com>,
	<netdev@vger.kernel.org>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
 <54cf35ea0d5c0ec46e0717a6181daaa2419ca91e.1724852597.git.ecree.xilinx@gmail.com>
 <20240828174114.412e4126@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240828174114.412e4126@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4c7808-e56b-4cff-669f-08dcc8229c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmxrNW0xRzdpMHR4NC8rU01PQkVxOXlZaTR6aVQwVFNQdDZLS0tBRHJDcnFr?=
 =?utf-8?B?VWFCSGQ3QUZyczJuNjhaTTBITElUSEJuNXZhbnFZNFMrb01iQ2F4UFdlM3Jw?=
 =?utf-8?B?NE8rczR6SU4wT1BOaTdPSzU5N212SXZDOThTWnV2Y010aFhoV3pGMmRlVC94?=
 =?utf-8?B?ZDB4cjhOaG4zRnp2WWpTYzVTWHU5Q0ZHRHhxVmp5Q1I2b05SR2dobU4rSzRi?=
 =?utf-8?B?OWNhTjUzSnNjeVFYYnZoMXZheFNrUjJaYURCZDFzOER3THVrcHpDSUlteUN1?=
 =?utf-8?B?bGROS05tc0tUY1pJNjQrVW5KRW1nSjFqdWhtYktDZzd0ZkRxWTlYc08vakl1?=
 =?utf-8?B?S2tsS1l0V1NHZFgyOHdCOVZBL05tQ3ZCR3pWNUNTeTIvZHNSMlZXdWV6dTRu?=
 =?utf-8?B?QlhhNGlRS2R4bEJxT1VtUW5idkh1QXduZ0V1eXpyRVlwdEpHNkNBcHFnY1RP?=
 =?utf-8?B?UWlmblNhV1VsTVBVMnpjcUlxaW4reFk0YlBrRW9tZ0hYcDVGSjEwdldtdldh?=
 =?utf-8?B?akZZSURkSS9nL3pjUlJQajFQZ2xNcU96SnRhNDJhSTZJcFE1OFNLa2tkNXJ4?=
 =?utf-8?B?OXprUVdwYXVBM0o5SEdPck9XRzJUVnkzM2IwUXU0N2pvcStQTVlYb2dLQXlM?=
 =?utf-8?B?UWYrYStpaUpyQjRzbCtNVjBqYmdwbjMrU1hvK2ZxSWsvbXZyY204NnJ2NldE?=
 =?utf-8?B?ZnMzOVhkSTl4cndaajJlNnpTOFYxRVpnZWtRVnAyY3ozbGQ0NHlKTmZqaC81?=
 =?utf-8?B?ZmRNUjRRYk4yM2c0d1IyRW9sYjBaSFRuTmk3T2ZkbldyVjJQWGpCbVBPRmI2?=
 =?utf-8?B?MUNPMVZzTmRUY1RJTHNEVlZIQ0M4bjlsc2VNc0lIMmlvdG8rWnV2V0JEaGh2?=
 =?utf-8?B?ZFRIbTlDQ0liakk4aVdwTGdkY0JUUk5EV0NTZnFZdnYzdGEwNWk5QlM0Qzdk?=
 =?utf-8?B?L01mSGMwd3NpSEFBUlpiNjJUalkyYVBXU0hiLzJsUmNaL0lGd3lyV09pM3Fv?=
 =?utf-8?B?ck1FOGtYaFNhT2dNUGxDSlBxSkpKQ1F6WHhPM1NzaGVLNEFTbUU5Q3lPY2Vx?=
 =?utf-8?B?T2loa3hHcGFKbTdJQlFNSFNCeUxSRlJzeFFKcTBpbDNsQnBzV3NYRHRlSXlj?=
 =?utf-8?B?NnpUUVNLaWpUc25meTJadWUwd3RZR1hqMSs4aTRCaW9ZWStYRTNjeTZjRmp5?=
 =?utf-8?B?ejZ4bXZuSDRKZjkzNFdCd0tTeW8vY1hPMThRWnI2MVJVeFA5VGlHcXI0dXBP?=
 =?utf-8?B?ektSTVp3VnNVeWprdUNjaS9udzJOZENnUmJHUzQvcGRXK1FyenhmdkFJR3d0?=
 =?utf-8?B?RW9JVlNFdWlVNlFDZmtlckFwOGR1SSsreXF1Y1Q2aVJSTEpsUUR0TEgzb0lV?=
 =?utf-8?B?Z0lYYzFnZVNjMmtrOHJaY3F4Q3N4RFVIVHpvVHlrcUQ5SXVRUXEvam1Ndmly?=
 =?utf-8?B?TlZpSFdjTHV1QURLTTFFOE14YzZ1Nk15dnRTeTVoTEhQMC9TVFdCeXMyWjZG?=
 =?utf-8?B?SEdtNVRHcjEvSjNRRDg0aFNLSU05elQwRXRMNEVWWTkvVlVpTkxaVFQwcDJt?=
 =?utf-8?B?dUxNV3Jya2Q4c0NCd3RMMi93djY5eDc4U2RrWGxqNjVqODlRNUg0aUlFdlpw?=
 =?utf-8?B?SUE4dk1jVEFDbkZwOVlweVZjaHNQL2F1V09TZWdMWktCeXB4VmJsOFQ4elJl?=
 =?utf-8?B?Yjd3VXVsazgxMmMvWFNPLzEyaStNNnRqUVV5WmVsaUkvaExJeURqNTY1dTZH?=
 =?utf-8?B?QjMvekxYWFNFclVUTHlrQktOMVl6SWtBSTN6RVZuVVVBMEpTWVcrMEt1SHJo?=
 =?utf-8?B?cjZOODByVGRYVXRwbXZ5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW5VUVdxdGk2NjNubG1DaDEwZVh2ZzgwelVQUGE0UlpiQzJmSW5WNVMweGk5?=
 =?utf-8?B?Q3JCTHFuN2xMVWlmRFFSd0xybDR0SURvYTVwMEJMYk9KcHh6Um5xUTcwRThj?=
 =?utf-8?B?KzNFU2lEMmRaWWlUL3Jna0x5eU1MNmFXTDE5bDhxT0pvS0RwQUYwRWVYS09o?=
 =?utf-8?B?UXE2ZEtaNkVKT05KcGpHYVc5aXBHWU9JTkN4Yk9ybHp2UWlNZUNLYTBVa0l0?=
 =?utf-8?B?SXphOStUcFE2SWs0bHZaQmdmb0tWL2FtandlL2ZFa1hUSktKd3pNTzFWUGFn?=
 =?utf-8?B?ZWl1SWl4VHowRlpOUE0yNWYxbE1rMXpKTmoxNklrUlR3Uzd0V3VKaHNkSi9C?=
 =?utf-8?B?VU40M2pENVYwalVYT0ZBa0RDTTNFZDZVVG9xblNES1RudEZlREduMGp0dVdl?=
 =?utf-8?B?RTYvUXVrT0NHZnpqYS95Y1pxbjNtRmFTNEhabkR5c2pzaCtrb2dhVW9WNWJH?=
 =?utf-8?B?S2hjZjRyalBxYUZhQXhTNy93R0g4dHpuWHJxLzJUL3k0MGM0b0tRWkpBOXZX?=
 =?utf-8?B?emsxbHRIRDZEdEZlQXhSU2VjNDFuTHVQVWk3U0szRmk3b0VnYjdvMEpZLzJ6?=
 =?utf-8?B?MzJiTXpmeFZnYkZTa3FZbHdFeTlsUkJRWUE2b1V1ZG1lMndsWGpTRGh2UW5l?=
 =?utf-8?B?VVFKbUJDNE82SGswVElLd3hYOHZPeFFGSmNOcUUwYlVFbXVkQ1RDUThDNnZq?=
 =?utf-8?B?c0QxN3JqTGVjbzlnZ2h0WXUwbkJhYWluUlhTUDJpY1VXQkNRWGVvSW9iOGsw?=
 =?utf-8?B?UjBlYnQvN3JZTjN1eHZJdWxSN1pzRDNUb0dHWWo5aXBHdCtxY2JWdEx6Y0FW?=
 =?utf-8?B?ZzhTSHN0MlJIK3JBVkJVazcvZ2Q0R0ZuRGE2WUdIL1N4R0t3eXFUVTV0ZkV1?=
 =?utf-8?B?RE5JZ2xwaXVDV1lIdjlBMDE4cEJtcFZvVUtpNitxQU0vZkx3Sk0ybTUyUW5Y?=
 =?utf-8?B?OEEwQlhweFo4RXRkTTlhU3BXbnI1UlZ4WkVjTFdZeU5BZ2ZTcGZibzUxQ2FR?=
 =?utf-8?B?L3Ewbmc1V0NZNVo1WlQ1bExoOG1xbDg2dFJtU0JGcHJPK0k0UTZYaTArV3RW?=
 =?utf-8?B?ZnNEVFcvZjdLN3ViOFB5bG9sNFExVDU4NVVFdWQyREpranhCRCtKR3AwTitk?=
 =?utf-8?B?RjJUU0w0R0YzN1k1Z2RCa3o2cUdBS2hlWTNnUXpLZXlocTNybzMyWHlzdHBr?=
 =?utf-8?B?U2dJUjhGT3pRZldieTBlK2JpaWx1K1Y0MjBvOFc0ZDR5LzdLeVc2aG5Ud1hl?=
 =?utf-8?B?dUFaYzlrcDlSNmU5dXgwY1dBdmFqd1dNNmNQZ1VtWWdFK2grOTBxYllhUDdU?=
 =?utf-8?B?aWpkTVdnVG83Yng1RWMyR3FRdGhTSStTTlY5dXJ3QnNVRkwyd3lSeHlrRFBT?=
 =?utf-8?B?dWpqQ2ppV1dNYUg0TFVnMnJHaGFNYytFZHJTWjFuVE44azhCOEhjWXFBbjNZ?=
 =?utf-8?B?YjdZS2tGTWw5NUY2MlE1UlhmeW0zTlF0emw4NXlRU2pGNWNIaGJYSFYrYlFT?=
 =?utf-8?B?MTJPVVlNTzJSU2RLUXNpTnJhRDdmSktqejNtYWV0OXd3Q0F6QzA3bVQ3TDFk?=
 =?utf-8?B?VzlQQ1Nvb21nem4rOUdEdjFGaWZzY3JuR0hGVU01REwzaU5WNkVEQUIyVE9t?=
 =?utf-8?B?bngvOEF0anl3dFVEZXI0eTZhc0pLSWdGZDA5dFRkZGM3VHBtK0ZjVzhMZi9z?=
 =?utf-8?B?N1loNkpEeStwRjRzSEcrakxvcnhGWnVEWUp3UGZ0NlNjdVg2aU9qblBZTWxI?=
 =?utf-8?B?anVmZXVEaklwYWw4cmtBYjFJOUc2Zis2L3YvWDhidGtra0FWenhUNWRIaU9G?=
 =?utf-8?B?VzI5a01GYXlRbUdRVlVQNzdsalZ3MG12emtVanN1S0ZFbUFtUDFaMzVPREZI?=
 =?utf-8?B?cG9xNHFjZXN1MW5HZ2hROEsyZk9acE5YaVVoTHQ5bGdJV3h6QllUbVNva3FE?=
 =?utf-8?B?MjhFSTU0NW03ODZLSGpvaVhWRnZRazByRzBteS9xM1M0Z1pIYnhUbWpqekpp?=
 =?utf-8?B?TUtRWTF4ZUcvdnQyZ282a2U2bFU0YWhJbXNHWGRLek00cXNLeHRPZXhyTkhD?=
 =?utf-8?B?YTN6WWRCR2xteWx1VHlLRDh0elYwS3lFd3A4RXc5UHgvQW93emp2VDN5YVdD?=
 =?utf-8?B?Z2VQU0U5L1pxU2hlUmdKWVI5VHFuMG9ya0ZKOW1lT2F5RGpVNmRENUh2cHdO?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4c7808-e56b-4cff-669f-08dcc8229c56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:03:35.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2H+gvpt9g2SIEGr3k2yGMRgbvY7ZgcqexxqGKp1yvnkp/QbsmHpbulMA3CFPApwim1i0dwM8NeJ7D/rKTQK/mWvqniN1Xh5m5ppGvJmOVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 28 Aug 2024 17:41:14 -0700

> On Wed, 28 Aug 2024 14:45:11 +0100 edward.cree@amd.com wrote:
>> +	/* If a TX channel has XDP TXQs, the stats for these will be counted
>> +	 * under the channel rather than in base stats.  Unclear whether this
>> +	 * is correct behaviour, but we can't reliably exclude XDP TXes from
>> +	 * these stats anyway because in EFX_XDP_TX_QUEUES_BORROWED we use
>> +	 * the same TXQ as the core.
>> +	 */
>> +	efx_for_each_channel_tx_queue(tx_queue, channel)
>> +		stats->packets += tx_queue->tx_packets - tx_queue->old_tx_packets;
> 
> We haven't had to deal with shared host/XDP queues in the other
> drivers, yet. But talking to Olek about his stats work it sounds
> like he's planning to add support for reporting XDP queues. 
> At which point it will be relatively intuitive - if XDP queues
> are listed - they count XDP packets, if not, and XDP_TX happens
> - the queues must be shared and so are the counters.
> 
> IOW let's not count dedicated XDP queues here at all, if we can.
> XDP traffic on shared queues can get added in.

Yes, I agree. If a queue is shared between XDP and regular traffic,
everything should go to the NL stats. But if the driver allocates
dedicated XDP queues not exposed to the stack (i.e. above
dev->num_tx_queues), they shouldn't count for now.

Thanks,
Olek

