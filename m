Return-Path: <netdev+bounces-280512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPDgObP/6Gl5SgIAu9opvQ
	(envelope-from <netdev+bounces-280512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:04:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7078449256
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67B5D3060C6A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84E737FF58;
	Wed, 22 Apr 2026 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHyP9TTF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE924377EDC;
	Wed, 22 Apr 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877109; cv=fail; b=C7I+YTc7HDEBGnZaBC6BwvBsuLHlisb5BJ5nR5BSfE7q8x2/GwKxVsjgSP1YUVr2ybPfxv1B0xmp4CWAj2MX89389RVw1BtTb2ZyxZeFZy4+WLZhxbTqSPSwRu6Q45LAlxgCJKD1d4C3DQW4cagwO8BziDj4Q0nLqTbO7+psoQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877109; c=relaxed/simple;
	bh=BOmR3qjy75ihQlgjoRrNBP4WGtP+f1YmQedns1ay8l4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LgsZ9DZ9ic5byqHvdIcYKdllidJrrUphiyDIw4A+4OaGpyoUimaCAQCyNWIE5AfqoUWIsAh4pM5yjmc8QXjMY61tcnaI0O/LtYy0JFS0XmORowahtmIvazxwDLE1EGAFE0xq7JLUPuktSHPuafoDxlg+ETX3c4+RWpqcXoRt+7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHyP9TTF; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776877108; x=1808413108;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BOmR3qjy75ihQlgjoRrNBP4WGtP+f1YmQedns1ay8l4=;
  b=bHyP9TTFf8kUIi0SrmyHQBkCxOBBuLAYNhEN+aR/x+gcyxK+WxMNwTQp
   sMNZ1y4uvN0wGzAqZLd20mUzLheEuqXTCIcbytTdv6iX0F8lhB8MCxvuG
   0r+5PZkHrWRVmn1kzH+9ItCPQ6DrRVxTFqFJP4v9IPJaeeqvjob7VNcK+
   YmZvLSCUuv8nKMrEHLC+sAZfrlYqs8J3M2BYGfnPf44jQGft8JS8DL6+M
   8/5TXgCFs768YuhlcYjSRm93xk3us1+8OSxanZxxkyLvJjwFgTakoVsc/
   KN2FQQE9jwtTWNpQ2PmGb9Oz58iqyIGu7CPe+Ciee5GWCal7KfOjfrPCS
   Q==;
X-CSE-ConnectionGUID: JNsja2jfTnC5Trmj+OteEg==
X-CSE-MsgGUID: 4cvjm3BEQSGgdRbKCt8l9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="76868642"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="76868642"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 09:58:27 -0700
X-CSE-ConnectionGUID: 3vFjq46US7muev9rsESJ1w==
X-CSE-MsgGUID: SSg7fYKpRzqgFhUPHxxbQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="231511436"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 09:58:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 09:58:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 09:58:26 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 09:58:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzyKSnFgNvmTKLhUhY+mQOvE8LwpimOqexcx0EheF3TTeTnCX+6vTFDBchsTmeh/m0pYpIuviFcMpGq3SqanClNbwA3bSi5EjVEbxqhWu6ZUPAeNVT8juGAmS/Up76K04zxJNNmJvT+3F3Ey8/qi2QVdcLUnuHG6Cwg/0k2T6eDr5cYhqQ9Q2j3T0QSdudNsmCLA2KUaxzNm5WN1yd3A35iJpvvALz6SPLSms5KJYpWLFP8ByfyKswjDTfd9ah6aX5ChJhzKvb9jRK2PyG2MTpxq1iHlu2Pt28HR0mOIK2yawJhTj4u2rQovVbSd1lBM3aAWkbkX7LK1TKReL8iA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp+w3ZIqnEYr9vVXNq7aXmjERLTIMpDrsx6aaT9a1ps=;
 b=IKOl6d7SMbjtje8PZlcrmzaMwNO2+L5HHFXOSN/E+pVFkqHDKyNblL8q3Y6owqV6kGaTFTPEt/v9UkCDMmt+9FXgqXk/H2cszAbmQ/YDflgHmAlhqXd2Na/E8H4Ns1N9xFkiTCPkyS1vSC2jmKiOn0KjwOjp5p6zaIj25E20ZTM/DLOhZLtRJJCV+kFBhXq9MwiNVJdK0ry1h8Bc7ZyXc2oPNMvqtQCkpU2P2NqKZnC+uj2bOm1U1HZDdRhxmqWabEhQb4WJ5adwHR6+M3RqM3CCXs6bpnixnGwhIzUQ3KZazq4aWwRdZ/9gD74qGuY6tYko0MSYSQRQEqYYL1XLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY5PR11MB6187.namprd11.prod.outlook.com (2603:10b6:930:25::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.17; Wed, 22 Apr 2026 16:58:22 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 16:58:22 +0000
Date: Wed, 22 Apr 2026 18:58:13 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<bjorn@kernel.org>, <magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit
 architectures
Message-ID: <aej+JZyYwUrRXD6e@boxer>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
 <20260422033650.68457-9-kerneljasonxing@gmail.com>
 <2e0e0e18-cb75-4638-9a12-5906de6a8308@intel.com>
 <CAL+tcoDTXEsehprDHeO7P1pcqwu_US3Li-dm_YyGDAwu2aYZvw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDTXEsehprDHeO7P1pcqwu_US3Li-dm_YyGDAwu2aYZvw@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY5PR11MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: eaea2f6e-bd01-43ad-176a-08dea0905cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: p5rSRG6ILix2e4nW7GGh7mCpXqVnZT55P1Uzq+E7ivro0k9hcuD1/G4h4K7aqihINNEytxSOXt2aGmkgAe/SXv7sTM9pwk0y8nwBuc3M+3gkvCT3plVjVdSnoB5sJy4NIOuek/rvK/w/QbHWVnJ5YngPj+cVkZoV64eWEPpBENLP+5BgCasEO1j61D0hHYG0EwawRZJoF4Ekh+kdA2JnvMhFWqOas27UUc7lb5PJ/BqD9RQBR6o+p/qD9i6bTqaFzB5ZpAKcAQU5SAI9x7xoPi7p+oySPLb4JpfQqIHAnDeg8SZrg+XaXOz38dqnYz/9vkDJl7zTIdfx6bdGK1VpoZNEaisrT7w+gDcU8nYGgc7ETfYiGKdmttpb57DDuWG+a97MipDTMeTOqDkrzSfNBw7SsE9HWgywk36sCqGfJkZUazs059E8Iox1Mg3scURcuLyKtCtWn21DHHG2rJtwhZSDrzsEavK1QWBFsoAruzsc19ppNdQ7ZgA9UlUpyMJ1SxMlvA175fKvk2PjZBbge2ln8+k0NomwcrVIOPheF1yPjSAkZT0WoG2ViqYV+rqFGTUv5IAH9L1fHJhXuHeDR5zW9RJ8YnE0XXh+zk4IKq+LHURVKIU3uGnmG3U6d8V81SQ0P0B2H2z2mg27I5PWvZG3sWQVDd6iOv1UVmRDRcMKsz0k6R2zbk3ZkPvgDyEKj4jfkVt5raec+znLfMFIRqU9GgB7U6HWV86ubNRVf0+rc13AKafVhZT0qNClE8JA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJQZXhyUCt5ZVFFa1I3MkVuUXR4dmF3Vit6SUJYVzYvV0pGQ3JZemFySkFO?=
 =?utf-8?B?N0VMYjdpT0M2ejZqK2JYVWM2K0gyK2g3YUVWblE0TDZPWllXV3NEa1RkVmhY?=
 =?utf-8?B?NytwK0hUWllsRTV4SUdOWTdvLzhQZ2x6ZHFSVitUKzU1dXViaEJ3cldGdzlj?=
 =?utf-8?B?eCtaRk9USkFSTEFHcTdjM2dhMEliR1dWdTNtbkg1OXZCMzh5L0k2bTc5REQv?=
 =?utf-8?B?SlBnanBEYllIajk1UTlpeHRGbVVCaTI2ekF5TjludWhHdVRDNFZUOTV5SWxv?=
 =?utf-8?B?OSthenJTMytWTUUyTjB5UUcxSENaMzNMWjBKb3FxQ0xYZ0NWcVQ0UHV1ckxk?=
 =?utf-8?B?NEYxLzNwZGpqaS82b0N3MExaaEFUUDlKdThzOEdQYk54VjZxSmRlM1AzeFp5?=
 =?utf-8?B?dUQvaUJadjNFcmoxaXcrT2hWTytFdktla25COGthdDF4VWZhNHVCRHdiemdT?=
 =?utf-8?B?WVVxSmZseGJBVHZYVTBTUDJodzNZVkxablVra2FWU1hJZEVpRjZRTDJUdE5D?=
 =?utf-8?B?L0VuZkpBT0h4ZCtoOGE5V2Q1N05yeTlDM2xtcGFMSGJqbnFndlBmSG1MRlVn?=
 =?utf-8?B?UTFhQk1ya1pDWGZraFVxWDNCSTZnMVVaUURydUZFTnB4Y1BTcmNBWTNkUkNw?=
 =?utf-8?B?eWhpTm8yVjZhakJOdGtQYUQ1eGVyOFF4eVd5dGw0cCtsNzh2S0tLUi9UWU1S?=
 =?utf-8?B?RjlpbDdwb3JaOHRmb2svRWt0aVFNS1ZEU20yNGpKenlYWGVtNTlGNUo5dzB6?=
 =?utf-8?B?RmR0Sms2Y1ZWZnMvTExWZlFycS9XWHlNRzNibHp1NDRiZldqTFBMYStlSzNB?=
 =?utf-8?B?LzhsLzZlTWt0V2NFd3RiSXk5S2k4MmZKdzc3ZnBvQ3Z0bHRIakIvbTI5Mmt1?=
 =?utf-8?B?cHRHMytqR3lIM2IvVkMwUUZnSEdwbmQzR1Z5dTZETC9UcWZ3R3VGbEtNSll6?=
 =?utf-8?B?WW56TjIycEFiRWZyN1YvWnVUaVZwd2UxckI1KzNIVUtIMnNnTUhBUElBNnZs?=
 =?utf-8?B?MUNvNzUwL1VQSXNaVnB5cit6UzBNY2lNNFcyYkZUNElNMmlFZFI2M1BSbVpW?=
 =?utf-8?B?dHFTdmhzcmprakNoRHZhLy9PVUh5U3cvTlUyRlFKa1VQQ0kvL1dmYVhMTFZl?=
 =?utf-8?B?YU1rSU5laSsxeDRxRTQrWTNmeHlKVXU1SCtpMlRQdGJndnUzWHJYZHV2MnhP?=
 =?utf-8?B?R1k4YitSRnYzTDRmcGZBVFJSelNNdUx3NUJaU3FQN3FTN1FYVGZKdGFMNUMr?=
 =?utf-8?B?eTBxVWhhVkNSQWgyUERwNXgvY3VUWjZ5MXlWWU9BQ3QrOXpvM3ViUG9IdVls?=
 =?utf-8?B?dVZqY3EzYUJwSXkzc3VZT0FMdFlBVTBGS1NBcms0Sk1WZ3FubkptWFdBNlpU?=
 =?utf-8?B?QlNsNUJ6bWR2YnNQUTYwQ3BzUVM1T3d3cVJoaWd0YkR2UG5mWWkxM0hLVi9F?=
 =?utf-8?B?cWo2NU1BeDNLeDI5QTE1VGxSY3VFenl5UEIyM3hnajNoU3VSY0JSWnFKelhv?=
 =?utf-8?B?M09wbTR3Z3NRcXN4RC81RjlHZUlKUDRnK3VFU1dkTUlnbTY3ODJVTWdPUnZz?=
 =?utf-8?B?N21nQ1hkdGhERHdhRkticWljUHIxSUdGVmJtQUQwbEczUEFyeHJGK0h5RUht?=
 =?utf-8?B?eUNlWjFiVWtDUFBnbGtWQXFtUjhSTE1EZHNPenpaL2xvekJyY0F5TjJobStq?=
 =?utf-8?B?Mm9iNzRLRW81d2VZSlVSUVNCTGdWdW53aUNpejIzZjhNY3h6cXJQb1NsY3NQ?=
 =?utf-8?B?WHhVTHJGTmFEeWdyeWJwd25TTGQxVTNDb3BqUElpejVOVmhKMWJ2bGJtRTJx?=
 =?utf-8?B?WGRJZDVqbEVRL0VZMTdiclI0aHNmYWszUHlIYU1zRzR6OEpyVjRMWTl2d21B?=
 =?utf-8?B?cGhJcW1zc25pQnowQ2YxM0RUaVYzQUt6WUR0cllnaFRIMks0YkFwOTEzMnp1?=
 =?utf-8?B?Z3NDWFVnczh6Q2cyVzV0cnFhZ3M4dDRXbi9lNVYyckxMYXBZdkJrSTJBT3hF?=
 =?utf-8?B?bS9xYU1XN1poSENxN3I1NnVVMWk4cTZ3aFRDenQwaVpzMlk2a0sxNEdOT0Iy?=
 =?utf-8?B?UnNCbVFRa2JMRG45YysyZlR2VkttaVZ1UkttU0d2UGQvTDlWcGZ6cStXajdp?=
 =?utf-8?B?bzE4TU5LNlNISFhoVWY2eElSbDRYb0hyNHF5VVNTQjBLYkhDeHFOSnJpWk5R?=
 =?utf-8?B?RSt5U3h6NU9Remt0ZnROYy92OGFLZzY2VCtMZXJZdWpEcnNMTytsTkhOa1ZH?=
 =?utf-8?B?Vlc0dm5LUUtxVnhaYUNUMmFJUGVSYzBxZlBxekJ1Z3d1U1JVNEdLbXZoTEJ6?=
 =?utf-8?B?T1JCTWxKdkgxcHFyZXpTanBsNHJuM2U5dDFKTXBjNHA0OVJFY3Jqekh4Q0w0?=
 =?utf-8?Q?v6ZOoup5MvBwEJ+8=3D?=
X-Exchange-RoutingPolicyChecked: INLo+8LZ4tvzLUzfay7Vd9rEX/rzCn0uzEZXtEAMpd4PdyijWfb4VQSfs3sNotrucUA+Hgb9TPuUxAnCguC3zX5xnc91IFUtjZJ5W60myPZA6qKndEch81zdmVwUFGsMBjGL9mOhstW9qVrKm+qCQ1XsEH1kTs13YCWiVjyXfBqDhPTDWQTeGf5q3xI1uxu3ZHU0x/3FPXRzF73r0SyDye0mpPjIVe3YRIe3xlJ2pRq35bqLg23/vuNZM6zBeYWeJwbqUZd1cpSUUB4zNGubRCb+f2GD2c4NVhnT2U9LiDHHboyuwV0vde0VWf7uZ6yQ4EnjKEvzYoGl6w12lZcM3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: eaea2f6e-bd01-43ad-176a-08dea0905cd0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 16:58:22.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xaTEpbAWri7d2hupRM2sDBvRVNEMry4LxmYAFomkndgwLSSe9+PJWem3WIU5PQgnM/AiFABX4IB8/Ljf6BPEkS33brZs4pz7YfkgCxL+Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6187
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280512-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A7078449256
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 12:37:07AM +0800, Jason Xing wrote:
> On Thu, Apr 23, 2026 at 12:10 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> >
> > From: Jason Xing <kerneljasonxing@gmail.com>
> > Date: Wed, 22 Apr 2026 11:36:50 +0800
> >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > > uintptr_t cast:
> > >
> > >     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> > >
> > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > > the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> > > mode the chunk offset is encoded in bits 48-63 of the descriptor
> > > address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
> > > lost entirely. The completion queue then returns a truncated address to
> > > userspace, making buffer recycling impossible.
> >
> > What if we relax the restriction a bit? For example, refuse to configure
> 
> As to the bug itself, yes, It only affects the unaligned mode.
> 
> I wonder if we can support this after someone requires us to support
> 32-bit arch and use it in the real world, then we can use the previous
> patch to complete the full support (which doesn't harm the path on
> 64-bit arch).
> 
> The code looks like this based on your suggestion. Just for the record.
> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index 58da2f4f4397..03417b04592f 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -177,6 +177,9 @@ static int xdp_umem_reg(struct xdp_umem *umem,
> struct xdp_umem_reg *mr)
> if (mr->flags & ~XDP_UMEM_FLAGS_VALID)
> return -EINVAL;
> + if (!IS_ENABLED(CONFIG_64BIT) && unaligned_chunks)
> + return -EOPNOTSUPP;
> +
> if (!unaligned_chunks && !is_power_of_2(chunk_size))
> return -EINVAL;
> 
> Actually I'm fine with either of them. Right now I'm not so sure which
> direction this patch should take :)

Abstracting from discussion, that is not a patch we would want against
-net. We should not forbid 32bit on stable kernels, maybe there is someone
in the 'basement' using 32bit xsk on stable kernel. Plus the fixes tag vs
patch's content looks weird ;)

> 
> Thanks,
> Jason
> 
> > an XSk socket in unaligned mode if on a 32-bit arch? Or add a check
> > under CONFIG_32_BIT like it was done in Page Pool:
> >
> > skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> >
> > #ifdef CONFIG_32BIT
> > if (((uintptr_t)skb_shinfo(skb)->destructor_arg) & ~0x1UL) != addr)
> >         // WARN_ONCE or whatever + error path
> > #endif
> >
> > I never used XSk on a 32-bit arch, but back when I was working on 32-bit
> > MIPS 1G routers, I wanted to add native XSk support to the Eth driver.
> > Sure, just for fun, now that we have cheap AArch64 and other 64-bit
> > embedded chips, 32-bit embedded networking SoCs are almost dead, but
> > OTOH, as you can see, other subsystems like PP still try to support 32 bit.
> > Especially given that this issue applies to only to the skb XSk path,
> > not native in-driver implementations.
> >
> > >
> > > Since we hear no one is using AF_XDP on 32-bit arch, we decided to
> > > strictly stop supporting it at compile time.
> > >
> > > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> > > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> > > Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/xdp/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> > > index 71af2febe72a..819aa5795f50 100644
> > > --- a/net/xdp/Kconfig
> > > +++ b/net/xdp/Kconfig
> > > @@ -1,7 +1,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  config XDP_SOCKETS
> > >       bool "XDP sockets"
> > > -     depends on BPF_SYSCALL
> > > +     depends on BPF_SYSCALL && 64BIT
> > >       default n
> > >       help
> > >         XDP sockets allows a channel between XDP programs and
> >
> > Thanks,
> > Olek

