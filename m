Return-Path: <netdev+bounces-180589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05131A81BF7
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A254885FCA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E111D63D8;
	Wed,  9 Apr 2025 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYWO0MKW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E3259C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174573; cv=fail; b=uJGjiP/hIMCNE72CXLU+fe3retfUDrWPLGrZRNh8tBSwA3VNwCbgRqwm1TMqerkw5kJXu9uGVe2ofRPo0pCmGmeMbgtSYUHHoCZmEVVy9Xz6C7Fu3x4ulO5Kt1t1NM54tfbmZpUah91nY1hMXiDiw7esXom0cqIsn58tnzzytQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174573; c=relaxed/simple;
	bh=y5zodrXqtrDtMF2HZHwuUQAl1IbEEmpCn+9MfE2L+7s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TXuR9R1cYwAh1MedP6UglzPhOWXk5WlB0eVpjChWF7JScPL2VpcCa/rhpJx1WH1b4DzdeUAZc2E8WWtCKpJ2PYde+v/LL0cgiVwopVSro9zhmBlZBypNFB1y1gMsquOV7J+OJy3GQQUvCAbqrv4o4I7Gp6/D1ve3SHEA2ik6D0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYWO0MKW; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174572; x=1775710572;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y5zodrXqtrDtMF2HZHwuUQAl1IbEEmpCn+9MfE2L+7s=;
  b=mYWO0MKWCkyAp46tJxBQFZl0HSSUyOB9kcFrgldpUiPyHDqYXt5KcYSJ
   QaNQyKv1gs4orRE1kg54wgp4BSwHDLooTFM5RTZFSyTFnURlA+jRG4LPY
   xZakVPRZ+qh3puAesH+4JfG/3pCHh/yxs/S7O6hpfKoxjXQ2EdnotTppI
   HX1M4gEVrXmRxH6ru0LWhlMqzn6zM3cgM+rda8K1+MTecQOJqoIocP98T
   l2rfQs16RCnZ+biMMQyPuzwN0VmdUXITBN3VlEjdP06Zy7ItlhCNOfaTS
   TSCSMGLJES6+tRtHFnjVm9HOCBgjb80nt4lYIqQub7XeCPdt9w2eEBjEI
   g==;
X-CSE-ConnectionGUID: cmOokvQ0S0iOPWpzD3hAzQ==
X-CSE-MsgGUID: Mekih5A0ReqaPFwgjz3jPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44773748"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="44773748"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:56:11 -0700
X-CSE-ConnectionGUID: d/mB+viMQMOWhp67fn2zlA==
X-CSE-MsgGUID: JpgqeM5bQyK37tJYnor0eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="151660818"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:56:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 21:56:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 21:56:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 21:56:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPrBSauB+gFOI/5tWSm3MPxhamriDZMEok9YPyZyCyaLm8tojioCU+vGXOZGYRqQgxWr1WJ52nw8HWHNwM3oL1usXuf3pNr9hpvONH0QjbX8E2HDmkVhsNYwqcbfututgBezn0Q/Iz7lLSm9Z1xDGEJwkVUbRt1tdH8/rWD35MvjlnG/BvUWugTGWlAMfbQaMZAwopN66WLLAvlLYkdMJipmSOVrAD9VAF25wt7ofni8RolSpZaAMHGpf3TJAqtB3b4h2EvuuQKUgVI/ncGOcdRv6wob+/lnY07L20TLMLqCZXavDPKVi7u3qUodqMsCbCeYUOdDMU5UB9QV735QIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9SGigENujSzf6VHI9oRenLr0o/qW/06zTwzlcdP0iY=;
 b=p0EK1BVwcQAmb9krXg9d8d+ECylIwkSrpR6YERBbg4r3M74ytDwQzPT+yEhD6KqxPhKMoCdrTKjKv46BzuM9+FxLk5eTQFp9DGZ7LkPkR7B+pp4aXiv8IAWbUZjrqEB/iCDCsNDO8m5hAtrueFp+JjF1mnuOyNuyZ5MLTtXCnv3VxrfeMCFyMQrOzR7IqUCWGYrsowHZRbIiPKkuxFR4zLjguJGC5gyi1S+0923fhPf2Z68uNhGs78CZ9WBsMY1L4O1oHqD89NF6h3gZKyt1RA6jAbOL1VfwrFCS6U7FuVrf5koCq+BT+XwdYH1C6FwqbJdUln+J5tEk889+zk4hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 04:56:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 04:56:06 +0000
Message-ID: <88286d74-8123-4916-bc17-da0dd179cf2c@intel.com>
Date: Tue, 8 Apr 2025 21:56:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/13] tools: ynl: support creating non-genl
 sockets
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-8-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-8-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:907:1::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL4PR11MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 361cff24-3415-4513-9fa9-08dd7722d653
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enQwMHhxYUpEMjZPWXptV0k0enp0Vm5rQmdiV1RUdFJ3UmxSRDB0QVgyRzBq?=
 =?utf-8?B?NjZRS0I2NnBRK3VGamYvemM1Z3NWbnFkQklpQXhpQmY5dTRJdWVNWDY2eHV1?=
 =?utf-8?B?WDhJL2R5S1N3QVFvUm9xTmNoVVFXYnJodEh3dmNUSGZNWnZiSjNYTGtnQ2k1?=
 =?utf-8?B?WXVRTFhtR0pNak1DTjNBL1FuWTVjU2lONmEvcStDQkJJTTUzTUhhYWh0NEpp?=
 =?utf-8?B?WGdqL2U0WGRtcldSWWRic0ZwUkxnM3FPUktOKzVKbVlVMDh3TmMwQWhlOGtY?=
 =?utf-8?B?cTNBaWEvSm9BZVhFK204ZERaK2tSRzBPVHlNSXFuSC9DQ2Y2MlhJTTVWR2Fo?=
 =?utf-8?B?S2o4WmhHTDFMYVNjZXU5NDFlV3BUcmtyaU9meWtCTkFKd0licktJVGZyOFhG?=
 =?utf-8?B?R0UxR1dLOE1hOXJIaUhGc2x3Z2xPNWUvZDhVcWZYWW5GdVQ3VUE1bFdmQWh5?=
 =?utf-8?B?UmF3bzNJMVRDZ0t0VUVmZmo0dUpGa2pQeHd6YjBBZmVxRytQT2krbGQwNHVo?=
 =?utf-8?B?ZHErT0krcVlWYXU5TTlhSXJrbld2QUpSNUZTeFZieDYvVDZLMGgxMHgxdUI2?=
 =?utf-8?B?VkIxQ0ltSisvUW5QRms1TmxiS09oWDBxaUJZakNvaGVabHFTaXRoQjNSMHlh?=
 =?utf-8?B?UzI0bDFBMWlaQnk5Nk1sT3ZqRE80U2hJak9FZUdZekhVUGVpZ0VQVXo2Qzdt?=
 =?utf-8?B?ZVljNnM3L1lNMXRkR0d2OWU0NVRCVUZJV3hVM0E4Y1VVT3ZMMHVjajdFd0t2?=
 =?utf-8?B?ZE85WFduNTJQMHEzWGczMmdiSWtzbGtQckJSQU5NUGhPSTdoaGpjaHlLUVdV?=
 =?utf-8?B?NnpYaUJLMzkvazVjQUZ1dFZaZU9abHhWb21pNFh2VlFkRDV0VnpidVM0eUE4?=
 =?utf-8?B?S2VQbU5QZHdkSGc3QUhXZGJHUDZ5RVlOYjlNSjBoMklSdUttODdoTERoNjd6?=
 =?utf-8?B?T2F0VnNSd3dHUitpUVQ2b3Z0aW1VMEJiVWhlMXlIaDEzTGdGbDdVd2JkOWVI?=
 =?utf-8?B?ZnpWTVNSeDgxS0RTQTh5bHpUb3E4RWhueXNFS0RIWmRZLytBQkM5bXdCK09L?=
 =?utf-8?B?Z3BoVTIwRnRlanFRekc5QXhsd1Nscm9SVnVhbHFUR0owTDVOL3EwejdBc095?=
 =?utf-8?B?ZlJuRHMvSFQ3K0lNbmptQnhmdHlRV1Rsb0p6b2dJbHBKSWhDMy85K0o5SjRU?=
 =?utf-8?B?Vi9TU1FYUndZQ25jOXRERXNqVXVVZTR0Yk1rOVFPcEh4RnA2ekJNOEFRSm5D?=
 =?utf-8?B?VTVqWDU3NVlzR1JiR2FZR1FRdXNNeUloQUppZVVNODh5dVBYazlNbENwTzRx?=
 =?utf-8?B?eVo0Q2RKYlh0eWdqZGI2MzlGNWo5UnVjYXNkVEtncmlFZHNXRHJhdldqdDhD?=
 =?utf-8?B?djhCS1F0NngwcDB1MWE0SzFHeUVRR00zR2FCR3N5Qkp0YWNKdmZpMDh4T1d5?=
 =?utf-8?B?c3pMWDJJQXFWbFl4ajNXdklMUEhwRW9ONHpvc2ZBbnFuQnk1cmJ1WUdHQnZZ?=
 =?utf-8?B?Tnc3RGdXVXlBNWVXOXBsYXB2aEcxWmd0TFpuQWR5dWFDRXh4VmlVMHgxUUlH?=
 =?utf-8?B?UVREL3BpczdFa2JMY2lqY3cxdUxlWXRCekI3a1k3bjBobjNaLzlzMHpRb29L?=
 =?utf-8?B?aE4waHF0bHdLM2QxZU9TMkd6aXdaM0QzT2M3dHhMUHk4NE5SL1h6Vzc4dE1G?=
 =?utf-8?B?ektIRXlHTDJSU1hIbFF3OFc5ZU9aOHAzeS91c3crZi9BdmxwRkZNOXdSdlYz?=
 =?utf-8?B?blNQMlBjbmFJbHRUeDNhRDdUcVhnNUozNm93RmV6bFFoK2RXdityWVYvRExv?=
 =?utf-8?B?aDhqQnB6OW9EUDloT2RZSTVmc2hpUERxOFdqVHA0aHhsSEpwVTVUTXdUdG5l?=
 =?utf-8?Q?us0zVU0E5cLuY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejdiMTR1Yk1GZnJCdDcrU0RVVmkwM3JKclJsaGdBVjRuNGRrZ0VxUlVWdWZJ?=
 =?utf-8?B?SVpZUUZyWUZ2R2VubUlyQzRIQ0FHWXVpSG5vMVZINUV4RVRrVU1teFVpZklX?=
 =?utf-8?B?Vm9wazltYy9tYTVBZFFHNlA4MVRWWTZGeXpPRzFRRXN3T3JGeitzMFhvV1JG?=
 =?utf-8?B?TjRqakZxWStFMU5COXVNUGtlREJrYWtNVk1WbEdFRjlPWUZjZzJUUUZIcnBR?=
 =?utf-8?B?M2RrNUlPcmxVTDNLeW83QThac252Rm91cFlQQUdQRnBhS3Y1NWJvNXZCZk15?=
 =?utf-8?B?T2l1SmhxZllhbkx1ZEJJYjFxeTd4a3RiQ2dKREI5VkZsL0dNRGl5SGUzYTNi?=
 =?utf-8?B?TTh0Mm1HV0pzRE9rZlJlYzVmNVdmekRNZE1xTnV5WjlSb1p5YWNrSkV2TFdW?=
 =?utf-8?B?YnBTTU5FOUdPeG9YUVNjR01mcmxYVm5tVG0vSUJET2VsYjFOYnIzS3ZPVnNN?=
 =?utf-8?B?VzBlM1p3eU5BYlhOd1NtVzhBbytUNnRibWpDcHZ5b1ErNElTNVpjaVZvalBF?=
 =?utf-8?B?TGlackdWdWVoU1JYbWdjaVBXRk40Y1dOL1VRWVZCZXVITGhWUlR2c21iNE9m?=
 =?utf-8?B?SUFlL0hlckN4YmFWODZ4dHlobE5idjRXMkhMRmNhU1J0RTRWTUJYcVFPSDNw?=
 =?utf-8?B?Rjh0dFJaYXh2ZUJyQi9QTXlraVhybUtCdk9mcDRoQUVWK0ZKNi9NdE1Kc2VT?=
 =?utf-8?B?b3pqZDJSbHNWRys0SzArYy9CZGttR3QzNUlwN3VJQktxL3d2cEdaL3lOdE4x?=
 =?utf-8?B?VTY3MFN5NHFiZmxvWVJXL2IzcElmUWpwanJNeWpHUGgwL2I0S1VESERweVFa?=
 =?utf-8?B?SlNPNlV1VlJIK3NIaDQvdE9XcS9OWDQzamFyeDF4dGpaa0NtZVZGUjhoVGdn?=
 =?utf-8?B?dVdYWkFZRVFyVnlBSTFJbW5qcXNxYkFCZEJ2TGhSbFF5YkwrS2llSjdiWXQr?=
 =?utf-8?B?c0NoZUR5aUludjJqVTNNUndWOWY2OFF0aVNPTGJZTjdOcUVLSzNOSWZLUDdQ?=
 =?utf-8?B?bWRTU21Fc3M5emlJbEZyT0tSOEp4VzZKcTRBL25lZTZIaWxVSWQ1Q1NiWG9y?=
 =?utf-8?B?Z0lmb2g0S2NkeE9rK1p4Mnk4OVpldTF4dUNnRnMzcVpIcGwxMktDT2lVWEVm?=
 =?utf-8?B?WTRoWDlGL3lWRHdpYnhYU05qQitGMG4vTHh1UERueFZ3b09FK1Jjd2NNYk0y?=
 =?utf-8?B?dDQxM25EQ0VUNzZVNGNCeDFqRFcyMzV6MmN4cUlzWi9DWGtua09yRXBoWFF3?=
 =?utf-8?B?UTlyY0plekVWNDJmV0VOUVFUVmFoYk1rR2dSL05jRVRCd3JJRDFFYnhuOTZx?=
 =?utf-8?B?VUlyR3BOa0ZVWjlJOFZhSnAzN1dVNzcvOHZXYnVDemJPdndFVkVuVlB3Qncv?=
 =?utf-8?B?OGs5V0x1ZVNCN1hjdENPVkVwbXlHYUgrOHNsMXZWSGQ2bnR0elAyM2lreUhR?=
 =?utf-8?B?YVRjMG1DRmlkdm1HVWZaSkVvZmN2Zm15QTBlWHlJZ2V0VW9VQThJLy9MeENS?=
 =?utf-8?B?ZWg5Q1lRTDZub2NVMXRNWUFGVC9YcXhHTmVQZ01wOEQ5M1NsVEZ1dWZlYTEz?=
 =?utf-8?B?ZWsxMThtR0g2MklGV3BkU0RqZ0kvQ09QNWR4Tm14c3JESjZWU01sUzlJMGZi?=
 =?utf-8?B?MlNEMTBtVExsazZJRzYzOE1tMDVYcURlbW00ZStNVXlyeURwTFlUK2xMVFZF?=
 =?utf-8?B?TkZDSzF6cW9LbGRhQ096TFFBWTdEeW5nUDVHWmVVZkhQbFlURzNZMTJNOHNm?=
 =?utf-8?B?eXFlSUJmQmUzZmFSWmtiVFN3clZmUlZFZk1wQ2VXQ2JqWTZleHJUei8zMURU?=
 =?utf-8?B?ZHZHYXhxMlYxbGc2c3ZOQU1Hem9ZeG9xSUVPT0tWb1ZlNndLYlRiRllJREh4?=
 =?utf-8?B?VWlTWUxkY1FpUWUzaFlNZmlTQk1RNzFQM1g1dlNTdm1NNGVmQ3c5THhTdVVl?=
 =?utf-8?B?SkhrWlMrYlZxeEpNNGsxOW90Tkt0NHhyVGdGTmhnN0VJbnV1dTd6Z2kxVk14?=
 =?utf-8?B?aVRrWitBc2JUQlhKUmhEaHJ5eFRjVWtGS0VkN0Q5d3ZCbnRGdFRNY0Myb2pr?=
 =?utf-8?B?SXJYWTZoVEt3T2w1dHJBbWxxVDhrZnRDaGplOUovb1p1T2hlakhTaHJ1T2c3?=
 =?utf-8?B?SFUwMTlJNWphTHRZbWJ0MkFLaHgwenhTVW1aemJ3ZDliRjBrS3RrWUFiTWRQ?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 361cff24-3415-4513-9fa9-08dd7722d653
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 04:56:06.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IK1iqtuX6cyhMJv0tMFsdARywrc/KrX1+TeY4w8al7jNvl4AY2kEKV6oFcwq5Z0YQ4dJ//mhiRS9/I01TZBH2/4pvpbjMw0ioSXi3ENhqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> Classic netlink has static family IDs specified in YAML,
> there is no family name -> ID lookup. Support providing
> the ID info to the library via the generated struct and
> make library use it. Since NETLINK_ROUTE is ID 0 we need
> an extra boolean to indicate classic_id is to be used.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

