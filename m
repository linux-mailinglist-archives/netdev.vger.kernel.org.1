Return-Path: <netdev+bounces-177614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BCAA70BEC
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA2B16E49A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FEB1A3A80;
	Tue, 25 Mar 2025 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeSj6kDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F692907
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742936951; cv=fail; b=lBAyVpffE3GQwtO9lV8AKzLU9btWwiIFiZP4cezFoqQdm8FD9WpD/gw2hfJa4k4n2MFwK6RcYd8TEwRB4/1FeeZ8foR2NEyComhDps223aoI3lh3QuxFiTDq65v405wMVLofDTCHzofFqpXsZ9me9P7HVM2o2PzEEC4APtOfVCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742936951; c=relaxed/simple;
	bh=+Z8uef8p0KCqHbN2nsybL5NC1DJUwskXoAZzqtndsOs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fsozVBrfU1vt8U2Xvc0sUikf9L0v2972UF0I/88pxPXjhFZhDmDSGEnSGSQe5nIt17ycn4dnsqxMfb/h2veQHnIYQbnniQU0sYRQDv7sDv8uI+pgJKTk7F21tx0Vf7OVaEEIrP1oauWVBPhd4u+NZPEqtSg4YIcLSghSiAOgNYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeSj6kDZ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742936949; x=1774472949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Z8uef8p0KCqHbN2nsybL5NC1DJUwskXoAZzqtndsOs=;
  b=BeSj6kDZn7K3iZxnfPGyvhZs0g6UH7LDHT0d3Ot/KbYVDRuDWV3Hdx2N
   +o1QYduOYWJ3VAh9kPhe0PYwO9Y+yVBaRH9XyZHTRNLWNGjUew8aDwTdM
   2lIzOxNJow61U+Q9MREl8lZh18/7XT275045OvNkT9joLo5YJW2TdngSR
   6lX18PORvW3oFywD6vsC4fLNJCWOl9V4lK6EgE4HBXdK6ZN94D4hLiPEC
   DDf/3LcXKgbSyW6onsedkAbNLeNb2TXnPvDKRKyDSa99yCuIjjX/RL21L
   rfG8B0o+i2FxWhdKJKA/jVwUIgEfec3og8N/WQvx6lqhvbLcv4a1KFt67
   g==;
X-CSE-ConnectionGUID: UCZw4WL0RL2GrPlT7xH5lw==
X-CSE-MsgGUID: UhyBASryT+u9JusCqeYQEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55194857"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="55194857"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 14:09:09 -0700
X-CSE-ConnectionGUID: +ueGGUCxTN2N5JX6/ysUmQ==
X-CSE-MsgGUID: wHM+XvTiRnS+xtBWqwTgtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="147680203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2025 14:09:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 14:09:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 14:09:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 14:09:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCAhHvWUOAbfRK26K3BFwkKFCdokm7g1LGaV2Qfc8zR+h8NZZ7Ftd3fTPw1er6J2mj+wYkPt/FYl9xinkMbtajj4LS3S2GvxHKBb6P8vbMCem9gWdqB0J62Bui+d8ZS0pridjT/wKROAPEZAOYGzNs6MBMCkpZoA+FVYFZMETlC8yAC8vbxhi0jN9SU/3aXJpjbQQprcJ10zBCrMLJmgkUsb7PSvv2oi1fRt83y73szd2Slcj/QwRDaW+gT7bPYOHu9Z38CnNenSUWXfE9SHTkOuNmcs8BOihAnhL+75jML69wuzyrcmOfJLD3GApcfAO5HwUa8f3816LpaxGPsneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkRH7a8izp/vKN3UjjiVJ1XzsRV4GoavBbZ67FZB6v4=;
 b=wgw7bTpqHeTDAYPnVUdX1JO0g+iAiGEVK9C6tNB1HTIsaKM2kzOJqCsZ+f8YHkg67nOut0vuTBrWHblSHYKn+mXG6SvRXp1jAL2sR+irtXjWeQSzgRdLAAa8tf/pYjuwl8vpX6dku8avmW3yrKxlGRr1r3RZ/BM0fjV/1lx4q0zfGaBSjvlTIaIuQ/DpXfFmGsX5cYKYxuVAdGo63JDci17qefTHdAF6bOraAHy72PrXkjwI8UIgn6OMcFALnJIajODvpcFwN2kmjn7OPClqEPo6lPiuL0LS7+GbtlgID3S+HRl1/xgMBEH4eTOUmEjDqpM/GOp6ZWeJGlFbgih75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8705.namprd11.prod.outlook.com (2603:10b6:610:1cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 21:08:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 21:08:58 +0000
Message-ID: <2cc1c107-b244-468a-9692-3fa5206728fe@intel.com>
Date: Tue, 25 Mar 2025 14:08:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] idpf: change the method for mailbox
 workqueue allocation
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Milena Olech <milena.olech@intel.com>, <przemyslaw.kitszel@intel.com>,
	<karol.kolacinski@intel.com>, <richardcochran@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Samuel Salin <Samuel.salin@intel.com>
References: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
 <20250318161327.2532891-11-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250318161327.2532891-11-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:303:87::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: e7765277-f480-45ad-9346-08dd6be1424d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWJqbWorU0hTTzR4WUN4Tzh1c1hWSUE5SWw1TllnNWcrY2h2UmxXb2Y3VG9K?=
 =?utf-8?B?NGJ0YU13ekJVUDJ6UVBnUEUrL3IxZjQyazJhdWMvcExsRWhxVWQ2UFNjb3Jw?=
 =?utf-8?B?bU9sMUN3blptUHhMaFRkQTl3b1dqZ213VFhQemg3WVdDOVlUNWxQdHpQVzh2?=
 =?utf-8?B?MWJmTVZNblJUOEVaRE1INEg1YThRMnkwMytmK3U5NzFYd2tLYTI4UHEvem1M?=
 =?utf-8?B?L0tWUnJhQTQwT1A0SmlYRlk3aGsrSEZsbzlHVk04Q1QzOUQ1VkVUK21nM3VV?=
 =?utf-8?B?VnhGNStzWVNYU0lsR3NMcDdaT0EwM0t3c0QvWndTaXJqcXFyRXdScll4YWsr?=
 =?utf-8?B?dC85STd0TC84UW9BaXAxNG8xR1B0a25XZnZ2QWlxWmd1MXE5V3FDUTlsL3VC?=
 =?utf-8?B?Zjl5ZWxZUGpZWnpaajVGTWtlWUF1ajBiM1BYWkRUbklJR1c4NlJ2QmdsZVZ0?=
 =?utf-8?B?Ylp6allqNjR0azRCRk1oZVJ1SE5XWXJIYktaZUtxYkVVa2VMYnc2TEpRNFV0?=
 =?utf-8?B?dHNsOVZ5TlhFU0x1K1lNdE1Rc2RDd2s4amVFZ1JIOUN5TnRZVW1ma3pydkJw?=
 =?utf-8?B?elhRWjhrWXJ2bTlsUk4zamp5amtqeC93L2JFNE1TbUZVTlluWEpjancyY2Va?=
 =?utf-8?B?aHF3OE1nOUVLNGIvMWEzWlRrOWp1eUtCOFNleGYvaWVMWkxMWUxsWldYdXdl?=
 =?utf-8?B?UkpERjFZYUlhaHZXUzU2KzEvSVJDZWpaOFVzZnJObmdJalVqQjRWWk5pM2FE?=
 =?utf-8?B?YXJYVzZ2ZDBRQjM2ZTZHRHNtOHFnT1NMUDlPeU1GbURhNk4ydGhGMGpJNEU4?=
 =?utf-8?B?THJEb1VTTy83NVhVWjdKc0Zld0taMDVIZXZDSTZ5UWw0eWwrYU9RUWZyWkhP?=
 =?utf-8?B?UmY2ZXFZbXBZeTdmNVI4SnR5OURHRVJ5cmtxZnRaSkZRdmtqMUFBbW4wcWlU?=
 =?utf-8?B?MlFEWTJXRDcySUJXcDIvbFo5Q2ZLQ1RtaEM1czVwT3Jrb0krSTlickNvNGlT?=
 =?utf-8?B?bksrYXFJTjA3SUFFQk9yUWxvYThzdFUxa3NQRkpsSGpnWTc2ajNpaUZsUHBD?=
 =?utf-8?B?WWxoZkpGelJDVkFXUGQyTzlTY0t3WWw1ZHpKODZhUnp1ZVhMaWF6d0k2Y3Z6?=
 =?utf-8?B?UEVLdWQ4Z29ycy9lSi92dFZPcmVZSXcwR2t0ZHJjQmxJWnJMTGNFM1UvV3FE?=
 =?utf-8?B?N08zQkR3NDZ6VmwvanlvRDU0MGplNHc3VUM5T1RZOWpncjBwc2oxcG9meDdu?=
 =?utf-8?B?TmVnVE03V2h3WjBDa2h4Z1RtbjhtNjFUOVJFdXdheFV3TU52QVlXWUpsd3R0?=
 =?utf-8?B?TWRLOGtQYzNGM3FCRjl6cDUrWWpVY2M0dWpHSVo5TyszVEJENjZqbG9uYThQ?=
 =?utf-8?B?QUVrZ0dybXdYQUc4amQxakUvNzVBL0Y0K0xscm8vN3VmbzBrK256KzExT3My?=
 =?utf-8?B?dTErTUdkWXJ6YWl6dWd2Z2VyMW1GenhFaExBSWo1TkFvNVhJNUtXeFNIYS9E?=
 =?utf-8?B?eEVhQ3ZLcTFSUFFCd2FyQWNsZ1NnMjdkVysyMTJKMkdocG9rSHBIQlphbDl6?=
 =?utf-8?B?TUk2Qzcyd0xBeDlBNkc3akhMbDlrL2o4Skx6T1Y1amRPVjI2aGIrWCtKcXE1?=
 =?utf-8?B?TFZTNTZPQ3FPajJ0MVJIMDhNbHdveGhvZmtvYWw0MC90RnpBZkFhSHNFaGEr?=
 =?utf-8?B?c241Mjlra2pUK0lQSzZCb1U4VlZGVjZPRUc2WFEyaUdueFJOMW44MkN3K2xx?=
 =?utf-8?B?TTdnY3FiK3QzL0ExWmI5Nm1QZjV3b2pDQkI4dTZXdE1CUitNODRyREoxYit1?=
 =?utf-8?B?a2hWeTVrcS9wVXQwTEdyTVB6aWQ5L2s2Y2JCM0QzdXFCMFBqcGlmWnVrU3Fh?=
 =?utf-8?Q?k6RPVdOE5gW7b?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JSakh2R1VIWmZRNW5wVU9DTU4vWkl4RW1xUDNqcExLWklqYzd1aGYrTXlU?=
 =?utf-8?B?dkV6L3h3OXpHb3psb3FMOXd0VVJsdXhyOTNVOGoybEs2dFEzUHZ4TTBXc1VO?=
 =?utf-8?B?SzhXYzZMWUR1T3B1QVBLcWJwVGVqQisvVSt0eCtkSzBJWjNPK3lMMTd0dm9E?=
 =?utf-8?B?THUxaWZYbDk2V2R1S3h5TEUzUGpldlQ2RS9EY0hwT0ZscTB6YTJ4bjZyRlNS?=
 =?utf-8?B?S3pyVjRTWjUvR2ZENGp0YzBOTmhLNVlLSHMzaHptM0hyeGNlR2kyUFgwcjc0?=
 =?utf-8?B?TFBrUWU5QXlFYm9tR2tNWGwzUVlRMEtub0ZUODFGenl3UUdOQ2JEdm1KQW5O?=
 =?utf-8?B?b0FHcWRvR2tWdStqeFYvTEY4MjlUb1JaOVBWaDAvM3NiTndXeVBwRHhxMHdp?=
 =?utf-8?B?RGljNmxpakU3Qzg0Z3hWTlVLNFNtN1FGbGR0TTlQU1NLN3VVQzRHTGhWZFZS?=
 =?utf-8?B?K2k3M1UraG5TTkdKZkNYV0djKy9jR2J2ekNxUVVQQk5rekpGUndxSG5lZzNW?=
 =?utf-8?B?d1pJL1JZbmJadTRiekNuRVZqQjNvdHE5ZVdhZURkNDVkYlZQSTRYZjNPeHBE?=
 =?utf-8?B?ZElWcUVpYk5pOWd1Y0NzNXZnMjZEeHVGNWNZTHMrUldCdFRISHRadFJIUU1B?=
 =?utf-8?B?RlJnQzRWUFZqeEI1cEo3UVdOekJPRFkwZ25jL0dxcVNaUUw5RFFkN0lReEhy?=
 =?utf-8?B?TmZMSEVBYUdsZ3Vhb0JUUWVGS2RCZ3hMRnZPM01RNVJxMnR2aklnSWpEMGZ4?=
 =?utf-8?B?VVlWMU0rbEprdkFZRlQ5NW9uNVNlQWNPRVFoQWFkTlBEZW1BdWIyVzl4WHpS?=
 =?utf-8?B?c3BJdWlsaVpiZ3RORVBtanN2ZDJzOXFmNGNLUUVVRFBWWlcyMGdCenQvdzhH?=
 =?utf-8?B?SnRiUDR0TXRjeVJVZVlRNlVzbnA4aG9JdDF5Slkzc09DbGZ5OFZsM1NBWFVN?=
 =?utf-8?B?NFY5UE81R3FwTWJkRklnM2lROTQyQm5nT1pDbFNZY24wR0tqa1NBYVRUL09w?=
 =?utf-8?B?UWZkUVFCUDdlcHJvZkc2S1JjUUVjUzVPQ0pWOWNzWjl1NWtTeVhiQ1ZwWk1i?=
 =?utf-8?B?Yy9idFBndHpuSlRxbDU5MXFYTnlCckowK05qemErS3FzZUgwOVdEeXk0YVli?=
 =?utf-8?B?RDdrKzVqQW84VGI5R0pYSmVpS2hOaGtNSnpnZ0h5RTZxcXBIekNycEI0TGlV?=
 =?utf-8?B?NUprcFNMbHdQMm5ONW1tbUJ0K04wd1ZOWVBsL1BRMjZyQjRBdklUM244Z3pI?=
 =?utf-8?B?bWJWUXNOTVhnZnZhNDBlS3NnSnFBSUVsYk5lM0xoUGtQSFJUQWZwdjdIL1B3?=
 =?utf-8?B?a3lXM29pekhzb2ZxS3RZUDQrM1FqU2hVbjhVOEtESXlibk5KWENBL2o0Qm11?=
 =?utf-8?B?RmlMWStpSnVDd3J0b24ybHdtcEJnN1pSbW4vYndmbElGbTBRTHYzdHYrandR?=
 =?utf-8?B?MFVhRENmWFQ2YzkzMmdxa1gxckNPWVQvTEhkNHMvV2QyYWQ2eUppWFNGWWkx?=
 =?utf-8?B?bVZHTmMydytiVGZyZmQ0QzIwcEc3V2xiL1JIUmI0d3I1TVBxa3l4UVZLdi83?=
 =?utf-8?B?TG00Z1NQOVZFcVl0ZUZ0a1JlWnllb1VwenYwaTlJK0c5OVFMWG1yQ0lPSFBj?=
 =?utf-8?B?OVpTazJ6SXRuRDJHRk1LYitEVEJFTHZCRTJRdzBHUE9UNjdJRXJqNG1aTzhr?=
 =?utf-8?B?ZXRhMGxMMytMbjlZK0FPcDJ6bjd0YU1xdVlCUExRdjljb2xCK3FZMk9sTzJu?=
 =?utf-8?B?T25xc3NRdS9MbTIvUmdONEx1RW82NTRtejZDa3JyeExjb2lScEU5S2tLdzVM?=
 =?utf-8?B?bU9STkdqOEoxN0NTbXpYaUlLM1RMaVhVRWhicmZkWEM2QlYrdDA4V3FSaTVG?=
 =?utf-8?B?SHhVM3BNenZEakwzUGdlMHRKYUZDTDFtUEp6NEw2bHI4SmkrS1FJZ3RjZFVa?=
 =?utf-8?B?bkxRaU9PWlhZMm1QSFZwQWI2a0x0SytZYWdyZkVZL3BoWm9zeDUyZk4yaXp0?=
 =?utf-8?B?by9ta1VGNTZFUVdQZmszWnF5ck5FZTRza0ZQc0pGaUdBNDdReXdTYWg2US84?=
 =?utf-8?B?dTF6eno0VEhEWUFCa2FqLzB3Uk4rMWdJT1hNbVJhMndNQzVJaXRQSHNEN3M3?=
 =?utf-8?B?V3FISXhENThkV2RjZFVhYVFGbSsrYi93SFdSWFhoNStvQ01DcDljQnJQVmdJ?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7765277-f480-45ad-9346-08dd6be1424d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 21:08:58.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWNhXM/lqGILW/PtOwD4+bHxt/agHbGjHwgB5htdDR7eEiClLBdZT7Pa//kz3uOgvUh7SUoHHtmaWXRCxHZZk0grAqmUFJkDNQEOerj2suA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8705
X-OriginatorOrg: intel.com



On 3/18/2025 9:13 AM, Tony Nguyen wrote:
> From: Milena Olech <milena.olech@intel.com>
> 
> Since workqueues are created per CPU, the works scheduled to this
> workqueues are run on the CPU they were assigned. It may result in
> overloaded CPU that is not able to handle virtchnl messages in
> relatively short time. Allocating workqueue with WQ_UNBOUND and
> WQ_HIGHPRI flags allows scheduler to queue virtchl messages on less loaded
> CPUs, what eliminates delays.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_main.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 60bae3081035..022645f4fa9c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -198,9 +198,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto err_serv_wq_alloc;
>  	}
>  
> -	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx",
> -					  WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
> -					  dev_driver_string(dev),
> +	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", WQ_UNBOUND | WQ_HIGHPRI,
> +					  0, dev_driver_string(dev),
>  					  dev_name(dev));
>  	if (!adapter->mbx_wq) {
>  		dev_err(dev, "Failed to allocate mailbox workqueue\n");

I would reorder this patch first in the series, since it is required
(due to the way idpf communicates), but is not strictly related to PTP.

Thanks,
Jake

