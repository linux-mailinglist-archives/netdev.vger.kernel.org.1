Return-Path: <netdev+bounces-302113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ShEnAugtPmrVAwkAu9opvQ
	(envelope-from <netdev+bounces-302113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:44:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B05F6CB092
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:44:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=FtUyVBZg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302113-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302113-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E92F3024150
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99AD3E3C76;
	Fri, 26 Jun 2026 07:44:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983103E1233;
	Fri, 26 Jun 2026 07:44:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459877; cv=fail; b=sUs/iLC8UVkuI4q7TPfsgCx9h6PhmIBudI5HyDEUVi6lUc+4MpYPCB1KX/rq9BU1glWPVezBHUAc1BnO51DEGdG6uhoChyzTZa6bIihr73zNr1DvgpLnnBwTFdgVn+UeWYBlFX+tUXeukYQg0wPAslNpPoGKL3F9EP36McH1NJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459877; c=relaxed/simple;
	bh=znW9JaYKhg6v+nXgzDa3kKR+LYYqeZWRT+evQP0qnL8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e35S9NG6rkHo9wYRN+75A3t9Q0tDBzQgyrpN7THVhynnDTIFIdNrQwFamT9RrK5lYrtj0A0lQ+JtIohByRh/Zhf25d4en1bZfAuptZMHnvMHECHl4qe8xTUCXpHQScQsQJQ+l5kgQA3qxW3KpKGT9cj/ocg61Uu2C/MCuHF2yb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FtUyVBZg; arc=fail smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782459876; x=1813995876;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=znW9JaYKhg6v+nXgzDa3kKR+LYYqeZWRT+evQP0qnL8=;
  b=FtUyVBZg5YxW0Q74UUh90EwSDxlRi2mi9dIfP6njWxqAf2uoCxHL5rEA
   38ny2INWneAgear4EhLsfr2JfGcb4Q5cSv6U5+AJRi3DTigfJ0nhQwcpJ
   kTGSY+LiegVjADcbAP6tEKADX5YrPrj0yyJ+/eiJwT0ELQbgkWLadiZo1
   XIMmxD/Te+FGpIMbwU/0gB+iHoH3LZpt1s5zXjNzKJYz8Fh15uRI/Fd/E
   sMJl5NQoSd38YqldMJu/iD43+Pw3dAPunNDamZmTe/JLslJV3KA2O6fit
   29XplSIgHdpaCSkoxTuhhxQ0AjInmBNzIu5b0Jp4lCfudR/3zGB0auCAC
   A==;
X-CSE-ConnectionGUID: 7sP0R+grSc6tVxTysbSQ6w==
X-CSE-MsgGUID: dllI3Y87TAKHg5ybk+L/dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83022410"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="83022410"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:44:35 -0700
X-CSE-ConnectionGUID: RSvn/HwrR1OaeMrmPO/m3w==
X-CSE-MsgGUID: cTINfrogSY+4q2bEZoQ4Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="249607366"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 00:44:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 00:44:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 00:44:34 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 00:44:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHFaBBE+7+CxDaHunVW3LMOmQ1I1ZRqmoLqi36Q5YdpJpjpyAPphex/jOhrhWRbwQ2F4uzCDs8om7ZA/lyLH7Q/Kga6Oj/6aMw9Wrb2X3Y4vU1iT77Wx6/WelCM6CTdpMBW112ZOpQ/G6c0llmgq0bKM6yri15XRn4+NiWYvJDrvNnuH0ZoZNcuCqIaq25xEyUkRmFO1k1oYMnFOxU9BEGciPO3gELd1I/7af0cTToJAstwkCO/z9erEexiPe0kz+tp0fgmRrkZDUHxF/fC9KM0a/RXA7Vejpnbkbb97bOYta4rhU32LzzXzOzEVz5sTIeGGyC/8TB/mp8VXcsTsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/6pWjMann8Ztc8ccde3hrkGujO5r8QDmAGwVIturng=;
 b=gDef10M8afZVpcRz+R8ouhRvckzGclRQ6utGVS45sBEoLp0gGr9ItVfke2UVBUZ+QvmNJcDkLCsMbWu2sjsjpK1e0E7qlxwr5MfnaVXWtvRKdkHbLY8vQSEQglzdO6y1ygMjQnIDQTuLzhBbbeHsdtfNDg+aeRjlxmLkfAYVchpJMlo5ZFWan94OR20izkaurrUQHYHsrWBKFRaI3TTFvfSrJGVuYuUbTNzgEh3dV1lq5X4gGqHNc4yzFv4PvSSka6z5HdRfQVw1Ny7mb65doM4SqZFimivwXIa9gBRW55QsZ5RKfZ+xFTVyQPuePrnMJMLlY/cuIBUWWsYW5AHK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 07:44:30 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%3]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 07:44:30 +0000
Date: Fri, 26 Jun 2026 09:42:08 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
CC: Jason Xing <kerneljasonxing@gmail.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bjorn@kernel.org>
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <aj4tUMqAXmQskO6r@boxer>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com>
 <ajwHuCp82SazSwKv@boxer>
 <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>
 <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com>
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MW4PR11MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c8e1cd-b3e4-4b32-c762-08ded356c171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: EyF/Yms1dc9eX/+EzgSQcXkxsPLXb9mE9POFFABlYkjwC7D9O61SRiDrovCqVh8AxWVo7VVSCEK8VTjfyr06q7lEcpHQc/ntxj4gN6ZoLRIdU8ruVTUfh+qBt5Kade4069wbMNAgb+b/eeHgTp4E08v9vo/OldvZ9RySCpgrj2r1PR3wItgcfmWtzYyNjvy4jjffPtL+wlKCmEL7P8Y+50pa2yk7B4G28aA7nZr6M65uKswzZ6Wrz9vN4WR018YbmJ0mRCkKIllJil+ot6cATCHZ+e+8VZY7PSVPJrIj1TRSqG5/2bq2gwLalmzRgBXfXyNkJzM7CQNFVpQqzS3NQ0r+cUP0jY9rjIHRqSyYUN0DQVrTL0Oyyy2HTTb3YnWzyZX+C28kZYT0vjzSuZRW0TO8DFjrQ5jRm5bOT39a2MvEEkYYPeAxQbfrmP86+mBqOPgePpAuCjXu80+gf3GVjuLgmoEDQZdK0iR+yvA+4U/CctAS6uLe/UYNxCSv53S19nsVrVuZf3D9aXfFADLVJl8D1kBFY+RqqCYto4ogSt7RGdGJ3e0Jt95mSDoVek6SAYYFRcuVq9hkIhISBnSWQHoNvANcibaPJ08rWrekp7XlabDTAY//BJOt/5vN2yHZj1OW7FZ4IOQbGCBY+PcObuAAJdNNARbWorOQQk5CV7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0RIeWRlU0NTSlZkayt4THBMTUYxbVFrQXA2V1JDRTRKaDFCaHNnNWN0dVBx?=
 =?utf-8?B?ZVRQamFucjJ6eldIMVdyNjJLYnV6TU5QYTVPSTNjbEEvZnZFZVZ1N2dld1FJ?=
 =?utf-8?B?bVFGMnRjczB1NmFDRE1Gb2JYd2N5U1JFU2dLNmpUS3RjSDU0QjloVDBKeXFp?=
 =?utf-8?B?cVJha0lQdzRuamE4UzBOVW9wMDVVUDlTTVdENFJFMG5FWXJjQkVKWWUyLzNv?=
 =?utf-8?B?ZFYveFowUitoYmVGRXQvUk52ZlllZ0JrQ2hpa2RvSVNXRkEzVTZHV2hyRXZF?=
 =?utf-8?B?WWJKc05vS1h6ZlV0L1UxWmZLMnlRZThkSjh3ZGwyaXVBWXZWamlsWW9xc3Zl?=
 =?utf-8?B?RnJJSFU1VzFSenptMk5wUEtaeUxiR0dTQ2VYdTQyOWhxRlRUVVBGSmdpQUxi?=
 =?utf-8?B?QlB5V2JDZlpqdWlZZlhBVTFSUVYrNWlBOTA5c2R5S2RQYnpNaVpHNDNMb2pJ?=
 =?utf-8?B?bEZGTzNyaFNyWDlwQU1BanppSWJ4TWxVaWtEVFJUMlFHN1U0ckIzcVNSUlpS?=
 =?utf-8?B?Q2FTcXhuWkx3cEd6S21tSUJBeUppdDM0RDF6NmM2Wmh0eUtXU2VPMkxpcUhG?=
 =?utf-8?B?cHlMMTBFZUZTbk1vMzBWZ29vN0ZZdWlTR3Mzc2ljNmNJWGY0VHpTdTBmMEJi?=
 =?utf-8?B?R3d3Y0prRlF2NmNSK3I1SGMxNVZON3M0VG1mcFFVMlIyUUUyYkRvY2tLem9V?=
 =?utf-8?B?VlNBYSs4L1lKSlBxa0JSMk1vbDQ0SDl4ZnIycGdXbWx6ZnJMa3dDSHV1bGk1?=
 =?utf-8?B?bW5OZGlFUjlBcnB4Sk5uM1NnMlJCUS9YcGtjTVAxMnRUZ2grVzYveUdmTGUv?=
 =?utf-8?B?MlBZbGx1TE9kTVhabE5TTVl1cHJDMDVySGd4T1VZTlhEK2h5cjNwYzB4TzRk?=
 =?utf-8?B?dlZYUnlBcnQ0cFB5NHRReDdnSy9nbXFaQW1iSzlOV3NyU1czMG1ENWV4RzBR?=
 =?utf-8?B?dElaRndHaktCY2tkaCtWZWplbk9Bb2F3ZEpHOXc4REZzSG9YY3Z1aWR6RVZw?=
 =?utf-8?B?b24zbG1SSDVPK0dzQVJ4QjM4dmtYZ1RjaE5zQTFiMkRsOHIyOHZTS3AzUjlP?=
 =?utf-8?B?WDVjWFZ3SEUwVUJhOFhwUk5XVC9pLzZWQW9NWWJSQUlBVEgzRU1sZmtYcU5G?=
 =?utf-8?B?WjR6dUl4ZWM0VnIrMXRubVY3VmdzZHg3Tlh2d2s1VDN1dGtBNWRFZUExaW8x?=
 =?utf-8?B?RFJIOFZ1Y2VmMEZhWS9vT2U4OW5XTnZNUmVuUHdsK1lOYzhzdTFWSjdKbFpa?=
 =?utf-8?B?ZUtRRHdkcHNYTTdDb25rUGswVzcrNUtjL0VBWW9SMUhNckhwRXdlTE85ZnB4?=
 =?utf-8?B?RDhWQU84dWxSYTlGemR1a2ltWDR1TWpuNnAzNHZPNlU3SENYSEdRVExuTEpB?=
 =?utf-8?B?QkFRODIzL0VPdW5vSkJWaW5aRW42eENlcTdPTUs4OCtzZ3AwQ3Bpd0RaeFE5?=
 =?utf-8?B?UkhiRk9yR0w4WXhFTjQ0eEsyRU9QbVpBUTV1cHFwdlJVckRUcFpFWmpDTG9S?=
 =?utf-8?B?TTNveVhrM2dNRC9QRTJ6eFVsVWpoZ0Z4TWlUWmZsemNIdnhvUWJhdTVFaFJ5?=
 =?utf-8?B?aUM1ZEFzdkl1UThKMjNQZm1pUjFTZ2sxUDRyZEk5MzRSdDIrRnF4UjFFbnFP?=
 =?utf-8?B?d3FnZENHeUo2YVFyVnV1T2VSa1B5M2N5YzZjUTZxS244QzlYY2ErQ0FoY0VS?=
 =?utf-8?B?R1czeHM0OHNPT1VZZkoyVXprbkh0clpWbGx1QWJmaWFCR0NKWS9UaHhpSVJ1?=
 =?utf-8?B?d2JsaFRLOEVjVXMwMjJvZnlkZk9tUjdBTnMwYlB4cWgvVDZNa2d0NW5jWloz?=
 =?utf-8?B?RUlLQ0RxMnBvcmcwd1BWK0lQaVhSQ0xuYzBUZnBvalM3Yjg4VDArQldGN3ow?=
 =?utf-8?B?c1JFdFBIUktzL3VXSlFUdEZuTkMxbWYrQnNJUlBVdVhOdkRvWXZ6a0hpNFpG?=
 =?utf-8?B?dHB2Y3drZmdvM1crcUd6NzhFa0VGQ2RaRFV3REdwRk14WGQyR1BLWmdMcDZ2?=
 =?utf-8?B?cU12NUFCUVNuNHNLN2NvaGgxVzNsYWhkKzRteDRlbktTWExmTkcwbUJUTDdJ?=
 =?utf-8?B?Q1RYQ2lGMW8yNDU1MGpZeFcvc3ByNGwyMVcvc2RaaFJQMDVMa0tQdUwyRnFW?=
 =?utf-8?B?LzRha2NYaTYwc2gydFJ5UTdrYkhoK24wMityRWNrbHYvU3hQZzAzUFl1UTFq?=
 =?utf-8?B?RzFvOXM5bVJqbUJpaUFhOGxKQTVnRkRZUzlBZS9EQS9nWjAwNWhzUmpYTmF3?=
 =?utf-8?B?S0ZPNFBOSm12bSsxdnQzTjlxVUtsSm84OWJMR0lJaDhOejZqNGFvZ0M5V0Nz?=
 =?utf-8?B?dlRNanJ1dnRpZHFNb1JWdVhsQjhQb1VqNU1KdWVONHRCVURwUzc2dGJSZGFa?=
 =?utf-8?Q?+KKxVkh/6wQ/7ApY=3D?=
X-Exchange-RoutingPolicyChecked: OW/MvOglULCu/FLyddCDgX4gQv+aC99rk0Ze7f1AUksE5ahRelHlz4XFRgHL05wzwmMezBTTfMJZVf59T1xMeEuhFlDxtGs+IGvoM/rRcbE5dn8HZO4uVySF8X3PUYHF5+VW2Vtzg0JAXmQOLLk8QEoQxvrXpEKnCH0aoEBs5FF6CdlaKO1WYxU7M4Wovll1yoNSoFFsToYmyVsTmObftFfrWC9uYfOwAk8ZTGP36Jfpi32zT5vdxcZ+DkA0Gxg9uUG6rUgoQQe0jiMIG7qlcC8BrwMEmPAF+O1HyLKVEzKmsHyMDZc6/tQ73hhbVsDZ2gzX89O95yAp48kI3PZO3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c8e1cd-b3e4-4b32-c762-08ded356c171
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 07:44:30.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIGZN3d2YRRVDmsxp72eJmh1D8EQiympha9a0ax3uiR9L2+mUJGo8jkasbYnFv4cptyFDhyVyVEwK7tfv5a4hgXL3S1N+ELhqsfuXCsh0p8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302113-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:from_mime];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com,kernel.org,redhat.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B05F6CB092

On Thu, Jun 25, 2026 at 09:05:28AM -0700, Stanislav Fomichev wrote:
> On 06/25, Jason Xing wrote:
> > On Thu, Jun 25, 2026 at 12:37 AM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrote:
> > > > On 06/23, Maciej Fijalkowski wrote:
> > > > > Hi,
> > > > >
> > > > > This series fixes several AF_XDP multi-buffer Tx paths where descriptors
> > > > > consumed from the Tx ring are not consistently returned to userspace
> > > > > through the completion ring when the packet is later dropped as invalid.
> > > > >
> > > > > The affected cases are invalid or oversized multi-buffer Tx packets in
> > > > > both the generic and zero-copy paths. In these cases, the kernel can
> > > > > consume one or more Tx descriptors while building or validating a
> > > > > multi-buffer packet, then drop the packet before it reaches the device.
> > > > > Userspace still owns the UMEM buffers only after the corresponding
> > > > > addresses are returned through the CQ. Missing completions therefore
> > > > > make userspace lose track of those buffers.
> > > > >
> > > > > The generic path fixes cover three related cases:
> > > > > * partially built multi-buffer skbs dropped by xsk_drop_skb();
> > > > >   continuation descriptors left in the Tx ring after xsk_build_skb()
> > > > >   reports overflow;
> > > > > * invalid descriptors encountered in the middle of a multi-buffer
> > > > >   packet, including the offending invalid descriptor itself.
> > > > >
> > > > > The zero-copy path is handled separately. The batched Tx parser now
> > > > > distinguishes descriptors that can be passed to the driver from
> > > > > descriptors that are consumed only because they belong to an invalid
> > > > > multi-buffer packet. Reclaim-only descriptors are written to the CQ
> > > > > address area and published in completion order, after any earlier
> > > > > driver-visible Tx descriptors.
> > > > >
> > > > > The ZC batching path can also retain drain state when userspace has not
> > > > > yet provided the end of an invalid multi-buffer packet. To keep this
> > > > > state local to the singular batched path, the series prevents a second
> > > > > Tx socket from joining the same pool while such drain state exists.
> > > > > During the singular-to-shared transition, Tx batching is gated,
> > > > > pre-existing readers are waited out, and bind fails with -EAGAIN if the
> > > > > existing socket still has pending drain state. This avoids adding
> > > > > multi-buffer drain handling to the shared-UMEM fallback path.
> > > > >
> > > > > The last two patches update xskxceiver so the tests account invalid
> > > > > multi-buffer Tx packets as descriptors that must be reclaimed, while
> > > > > still not expecting those invalid packets on the Rx side.
> > > > >
> > > > > This is a follow-up to Jason's changes [0] which were addressing generic
> > > > > xmit only and this set allows me to pass full xskxceiver test suite run
> > > > > against ice driver.
> > > >
> > > > There is a fair amount of feedback from sashiko already :-( So the meta
> > > > question from me is: is it time to scrap our current approach where
> > > > we parse descriptor by descriptor? (and maintain half-baked skb and
> > > > half-consumed descriptor queues)
> > > >
> > > > Should we:
> > > >
> > > > 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
> > > > PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to userspace
> > > > and do a full stop here)
> > > > 2. now that we really know the number of valid descriptors -> reserve
> > > > the cq space (if not -> EAGAIN)
> > > > 3. pre-allocate everything here (if at any point we have ENOMEM -> cleanup
> > > > locally, don't ever create semi-initialized skb)
> > > > 4. construct the skb
> > > > 5. xmit
> > >
> > > Yeah generic xmit became utterly horrible, haven't gone through sashiko
> > > reviews yet, but bare in mind this set also aligns zc side to what was
> > > previously being addressed by Jason.
> > >
> > > I believe planned logistics were to get these fixes onto net and then
> > > Jason had an implementation of batching on generic xmit, directed towards
> > > -next and that's where we could address current flow.
> > 
> > Agreed. That's what I'm hoping for. There would be much more
> > discussion on how to do batch xmit in an elegant way, I believe.
> 
> This doesn't have to depend on the batch rewrite, we should be able to rewrite
> this non-zc in net, this is still technically fixes, not feature work..
> 
> There was already a couple of revisions with this drain_cont approach
> and every time I look at it feels like the cure is worse than the
> decease :-( Obviously not gonna stop you from going with the current approach,
> but these fixes feel a bit of a wasted effort to me (since the bugs keep
> coming and we are piling more complexity).

Well this is my fault as I took Jason's patches as-is and did not realize
Sashiko had issues with it. I *think* I got ZC side almost right so I'd
like to have at least one last round with trying to make the generic side
right...


