Return-Path: <netdev+bounces-189877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1160EAB446B
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BA119E6F0D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCCD297A4A;
	Mon, 12 May 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7Jwfo4u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7C297B91;
	Mon, 12 May 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076932; cv=fail; b=XTjw1BW+g+c2xkcDK87iyDOTTN4E7Gs6XxCt/U6vIlvWO7qnAVfqMJAmgdb2X1OsFxYBl9zOCMNcfgdKxte+ofRkk10SX9xOl9mxnJVuycuuixGgUlktxGEhK5381uI8cdJmFkJxzkI45W+rKYKf3Jf47NucPkliHpEUHoVFaL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076932; c=relaxed/simple;
	bh=rlt6TQVmzHAMxpkwoEUqRrOWeAPz9SFlptmdaDJTHFY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MRNEADKAbyAJA2U+8dbq/aOgOUPJm+Z7PDIZjQ79tp/fnjXzJ/vrsH+/LypEXpnz9ZAylPxBROqBxno5VkCmbT7CAHeLtZMNZszAsEmtL7PyxUXBUxu6lYRn5008AGOZ2147AXYlTTxd2Zi6eikr5hA3r5yc83585mbDaeDLDKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7Jwfo4u; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747076931; x=1778612931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rlt6TQVmzHAMxpkwoEUqRrOWeAPz9SFlptmdaDJTHFY=;
  b=R7Jwfo4uczeSp+ct5VpZKwv2m61d7v0JEwwgq42mqHrQl8f4w7o8sMEJ
   dxnE34oLHM3mn4X/kor1fO/lYyL+l5093GCkbJlo1hf07lWr+Yv/t1tpC
   0XJhjXqq3oxQ3Hd/dlkJ+QByDwmxZc20nAgts9Gs+aW8xhvVKHNMl0b3F
   g97IzL75n/sMQYNqXRUK+1b+bTzZbV1VED4QhMqEqjnQi7I5RU8HWdCDe
   0FJpIYOC3yUmxcYT8GbaVzGhpX7AM60XGeSLT9eLsP38yFiyVrdmdf/h7
   RRUIHML8AEf57IqSqrTdmcZbjXs+bbmiOtkQPsM1jCQdmB8yz5yfuCIrF
   A==;
X-CSE-ConnectionGUID: RMnzjHxCR7mffo+cBB6ZNQ==
X-CSE-MsgGUID: ET7wA/3RQQe32LLu3i/W2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59553952"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="59553952"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 12:08:50 -0700
X-CSE-ConnectionGUID: hAsxi2+BS5ueLeJ3EAky3Q==
X-CSE-MsgGUID: Jq/2RmV6Sx2SZKYLJuE4xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="168381925"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 12:08:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 12:08:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 12:08:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 12:08:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tweSVqiB+x4qBOZ+cu7DBXm2VG9ocIuJlLK7YZJv5LhrFcSTbV3Isb6vZAPaP/CE8gQRB5+Jl2X7fs0VUiOqltpBu0Fwg45rrTDNv6t+KPYM/t1Q4XsMN9OLp7pvg5QqzsJgtzl8noHwp9r9wMQhXMZDRSSLBIRLuonJDCfQHQXs0mD6BhsLMtgN8kQvA5b/+TkeP5+IDoxsXldedZiGX2y2HGDqThUQeHxG2sBsMgI0Af8YMbNeQPNHcJFMYcvbyO0D7ua3FZ0h8JgUpwD1UZUQDKXP2WYN5j06Bh6dMdF/5qsRuYLrWDsvBJ5UX/PzmppFDYkS1oW/FIgLqT4ZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhG1t+7P+pfCrCTr+tvphRq3147Agbb9pnXAuWTBypE=;
 b=MVFHWU/QvRi557I0jp7Jvvhsb/qYuLjGd6aGhRIWVkgAEOaxM5KT1XfqyCj+znn9T26LedNKp3zTfdmZG1/B0i5qytHJOQSVSbwOMLosd5t1Gf3v+0mSucICutEi2RQDj+7hHRiH6wsgm6SsBiu6X4ewHWsSc/2HYqfdDmasxb0SaUKch/q9DZ8+wlBx+w53yoZeoklCVRP6A/KPLs7XEoR01WXAE7DEv1lZXUyRL7Roxcsy2+VBuxVvj4tmKEX764CfdeMUHG916vYp9TT4EVfsVdFqfCbOEzjafCZgxRubGeXoSwIjMMlU941hZ8d4O+/RKuQYsHTcWUvJmsSLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB8271.namprd11.prod.outlook.com (2603:10b6:a03:47a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 19:08:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 19:08:05 +0000
Message-ID: <e4f8d373-c7aa-4005-93a5-7d364fb571b6@intel.com>
Date: Mon, 12 May 2025 12:08:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/5] pldmfw: Don't require send_package_data
 or send_component_table to be defined
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
	"Jakub Kicinski" <kuba@kernel.org>, <kernel-team@meta.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, Sanman Pradhan <sanman.p211993@gmail.com>, Su Hui
	<suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250512190109.2475614-1-lee@trager.us>
 <20250512190109.2475614-2-lee@trager.us>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250512190109.2475614-2-lee@trager.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:303:b6::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ec8739-d5e1-4bc7-a32b-08dd9188535a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2dRQUw4WVF2WkRjWkRVTnJYSG84V3dUQklnVHZrRzJwamJLdWZMbVcwSUNK?=
 =?utf-8?B?Wm9sTTIwY1FLeE9HcVIxUnVCR0pTbzE0WFVEQXoxc2dNa1pyYnJDSStPanhL?=
 =?utf-8?B?amNxRldBVFE4elQ3QkNFTkdFdm9LT3RNUFBYN3QrSzNrUzRRVWtwMzdKSTdm?=
 =?utf-8?B?YUM0RUpQdndaelhKaUNBV1M3VngwRTdlNE5OTWlnWWdyTDlTQ2NBM0NzbTdu?=
 =?utf-8?B?bFI1dWJPWUZrRUFZTCtLTHlGbDNTQ3VQWDVLNENwdXVuQ0Q1UGdlMHBRbU9T?=
 =?utf-8?B?VmtmV0wyMHgyZnMvQ055WjlBSXVzWGYxaTZaNUxaK2htQ1pmNUFEV1JoYUVT?=
 =?utf-8?B?dFFaSjBMcjJBcU1aV2daTVFxMkYwbWd6bXdtRHVNaml1V01KV21XbkJXY1hJ?=
 =?utf-8?B?SW9HWFNsWG5YVDJyeFpTY3cxcmdPNW5YdVlxL2tBY2UzMm11YkI3MVU3SThz?=
 =?utf-8?B?eGxJZEU0MlVNNGJYRDR5L29TNDdyUFdRWFJ2VUtlNks4ZkVUcHRUSnRYaktp?=
 =?utf-8?B?cHpKSDBrcS9Ra2RVdWpxc3NJdGVWZ1ZpejhLWE9XM0o1Y01STlJaVlZDR0Zl?=
 =?utf-8?B?MmlpVTBWKzRWdXpqZE9vU2tMTDNJN1ZmRzZJejlzdzRpUGVzZUZuRVRKYVNW?=
 =?utf-8?B?U2xmb1ZITVFIOWRMZjI0MlVwTXkyZnh4aEJzU1VKa1h1S3NwQ1QzRWZSOC9Q?=
 =?utf-8?B?NG1xc1ZyTy83c0xjcURPNFpMRWl3SmFMUFN4c2ZiL3Q1YzVPQWRCR0dDUitH?=
 =?utf-8?B?UU5XYUtiaGlKaUxWTFdFcUk2Zk1KMFlCZmZUTVRhUGV0VHhyeVJUVGV2em5R?=
 =?utf-8?B?TllPcGdjSThFUTdLVjVXWnZSanBGTTB2NWh2dndCR1N2cTJiNlpJTm1aK2w2?=
 =?utf-8?B?RkNONnFmanMyNFIxVmJwSUs4QWVnYlpGWEFZSldhRDZ4R0ZNS09FcVFLTVVx?=
 =?utf-8?B?ckRjTWZxWmxwWDlpY09ZY3dLRk5PQnMrMU84THpKWjRmQkhCNVpzRUlkVSt5?=
 =?utf-8?B?c3hDeVdOTnlTenF1QzBUcWswS0ZWRTVGMVpvODgvSGlLUS8vTDE3eWlIQmMw?=
 =?utf-8?B?RFNNdmwwUnJqbjZkSEx6by9PbWpQM3ducFVoVVhJUmF6azVDWXppOGNKeGdn?=
 =?utf-8?B?L3FtMzkxcFZqREQ5VDM5VzUvZXNZN2tDQUt3eEdXYnRpR3Q4Q1l3OGx4c2dq?=
 =?utf-8?B?UkRLU0d5eVRjcHFSWVNwZDFhdWdaaExFUzkzbGg0M09sa01rRmFLTlNaeG1x?=
 =?utf-8?B?NmJYcS9MWjdCTHlRbFRzTm5LVkVhQzdJRHMrakVyMHJJNG5lL05PWVd6RWF2?=
 =?utf-8?B?bXBPQlhoSlVvT1cwVEZGdTVKSkx4MGthak9CRC9qSkFndFVFYnlPd0NjaFNj?=
 =?utf-8?B?QUhSaDV5aXZSRGF4MmRqRDVPM1YyVG5abXExczVzK2EvUHI2b1EweW5saHhm?=
 =?utf-8?B?dGsrcHBvdzdaczBFamEwSmNLV1FUYmxqYThPN01Ncm5Nay9CRUloSzJpVXQx?=
 =?utf-8?B?cE5FaThQRVRLdXR3M2gvT3kwbHlPazVzQ01oUFFrbFpZUTdpaWVidGdHUE9U?=
 =?utf-8?B?TUNJRUdpZkJvOUN0YWp0VjA3VU5xdCtiU2lHazRLbk9NUTFNd0h3dUY2T2Q1?=
 =?utf-8?B?RjhrTTNZQ3JSU1dKOStYSitUN09DcXN1VVM1YkN5NnFSNW5lKzRwa3ZPRUxJ?=
 =?utf-8?B?cTMrN3ljNXhqaGgrRHRTdHMyNWZvZ3V1Ujk4aDhlcDVnM1k4R2VDUWFsaG44?=
 =?utf-8?B?ck1TUXllK1BaS0tZSitCNEZEYlVrNmEzZVFnbzFic0tCeUh1RlVuRGdNMG1U?=
 =?utf-8?B?Q3RYV0wvSEt6UmwwVUxFWGdhMlFYK1YzZnBLRWZZL3EyK0REMGQ3QldQNjFh?=
 =?utf-8?B?ZmhIY0Y4a2xVYmN0WnhGa2FtZGhmU3ZsQ2V2R3BFRWdnSGNBaDRac2VCL0M1?=
 =?utf-8?B?OGQvcFlLLy9adUlkUzFuUm14cVVCUFdVVlgzUG16MW9GVTRyU0FCbVM3aWUv?=
 =?utf-8?B?ZENlL2wxZndBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDN4ajV5dCtPRVVGZEF3eEFDamNkejVqdldYcXJVNmNUb0JuNGJ1dUpRNkxn?=
 =?utf-8?B?cXRvOVF0QVlyQUxPSEJWRHI4TXg2MTkxaDluMER0ZWViK2NEVHplQktsam1F?=
 =?utf-8?B?blUrL2RMcGNpRFl0cDk4RzhpMGltVzRQbHQ2N1QxMjZPRXlqSVpWVmFZWFh1?=
 =?utf-8?B?TTc5TkdubTcya3Y2OExJdjBzc1k1L1d6U1BnSmhsQW42MG42Y0FrZDJlcXZ3?=
 =?utf-8?B?LzVzQUZGa2o5UWZLNUFKNFRFeVA1RmdRaXJqOWptUEFJOG50UGZYZDM1ZVRr?=
 =?utf-8?B?Ykt2WWF0NlJBRHQyMVVzekhHSW96bk1ZdkFzRzZ1aE1XQzdEY0llOGhPeVI5?=
 =?utf-8?B?QlF2Zjd6ZzZWTDNzRVRRZjRzVzRQN0loNWcwZDNSOGNDZ1gvMmM2YXIxNENq?=
 =?utf-8?B?UVp3R3dTY3BpaklncWptTDZEZ3NIWmtSanR0NTRGdjFNRG9EZ1ROK09keGZx?=
 =?utf-8?B?NXUrQ2s1K0N1elZzcnZra2dSSmtnY0llNE1rTUN4ZHRXY21aU0JtNWNta0Vt?=
 =?utf-8?B?czJsb1IwL3JmMy9LbFlsa3lOR2lJaVI2bU4rT0VYaEE4Rk1QWnVOelBnLzBH?=
 =?utf-8?B?RnpXSnRIYmdYTFlOUHZaeTVMRFN4eG9ibWExaE8zaE16L2JLQldKQ09PU0Ev?=
 =?utf-8?B?ZVpyQ1c3ZW1kSm1kR1dTMmJjcWdURTNnNnJLdDBISUxtUzBMWmZrKytGckVE?=
 =?utf-8?B?aTYrWFJMdXR4YkgxZjVPL2NMZFN4RkczSzZMSFNwT3ZaeXZaaHNGb1hzQlhF?=
 =?utf-8?B?TzNLS1FRYnZXTFh1c1JIUjZWK1YxZC9sZDI2aFVBVzB3N1FPdVhEY3N2SE83?=
 =?utf-8?B?M2lROGNaWE5rS3k1akRDQi9BT2themRIZnJESXQyUmRzWFNnT0YvNEdZYU5u?=
 =?utf-8?B?bCtIeEdEOWtKMjA2WktqajJCZ0tZRCt3QWFTby9Zc2RRU1Q2RFlxZGcwd2hK?=
 =?utf-8?B?RXE3Z3F0S3FuYnN0OS9aSTdMR0lEMWhuYU9QaXZySytBTHMwYzVUK2haM0dR?=
 =?utf-8?B?dWVzeC9hT01nVHZMblo1UzYwWGpxZW9JTVQ0SWVoVXVFbDJ1WFRGZXZ6dWF5?=
 =?utf-8?B?ejNQalY5TUR6bXpHRG5xTVA3cEN6RVYySS9NRHJBMEtLL1dVQlV2MHdCT21V?=
 =?utf-8?B?T0tweEJDVnd1b2t1ZklBelVTczNMM3VwZjV4OXRKSEtMVUtpc1FTRTBFVnN2?=
 =?utf-8?B?THkrcjJhVzAxTCtHREZ5eXpMNHFNMGRQV0dtbjNGRHlqU295bld1Q1lmaFp0?=
 =?utf-8?B?ZHp1eTdlRmM3OUR2Zi9ROEVnOVd0L2g3dEJuUTdiZkRIdlhhTjdrRjNvbGpv?=
 =?utf-8?B?S1RLbktTTDl4TlJlN01adk1jYTB2bjEvRnB1bzBNeUM5aHVmNlhDYkZZZ1FD?=
 =?utf-8?B?ZmJnVlJHYk5qaUtSZjZXTzZBRC8yNUhjdURMSkZQTDNGTlZZUEM3bFREcTNO?=
 =?utf-8?B?aEJjZ0lEOVdxZ2pudnJnR2U5aFhSNGdBeUdpK0lhR3g5dDBpRWh0S1VsSS9t?=
 =?utf-8?B?VnZDN3QxMjZxVXdoNFFMY3JVNzRQdjhCTVBSc1hPdTJ2WWh4VkVtV3U2VUZx?=
 =?utf-8?B?WTFDaEs2aWU1N0hsTDRwVE9EWXdhcXFLSVVXZXpEcDg2cDhTMFliejNudC9p?=
 =?utf-8?B?Q0VlbkllVGVZcGVvelNZcUpKLzRqUEJMbGp3ZE1TN3pqdUJXVjVMeXBma1hW?=
 =?utf-8?B?NzNjUmFveUxyWC92SVNQMHpORUpnMWlVN0VUdG94bmlIcTd3MzVBbkNLNjRI?=
 =?utf-8?B?MElyY3JzOG11c0xlY3B1OVh0V0R6bGQrODZpNU5jYXd5dFlmVnZVSWVKNjBC?=
 =?utf-8?B?ak1NbW8xbXVIVnZFSzU5MVFLbnhiV3hRZHpJNUp2R2RCakRNN29yVFR3a082?=
 =?utf-8?B?enNNcE82WGRBT1RPU2laMS9tM24yODljRmc3eXl4RTZvQnNGcENwQUJIcHNB?=
 =?utf-8?B?eWo5TlI5SytSalBHSElEUmttcjZ3SGRBM1ErWnk1V1RzbGsrWVYwcEo3cXpX?=
 =?utf-8?B?VHpIZlVuaWZEcW1maWg0dFA5UHAxUTJiNFplL3p5MldPaGJFMUNHeCsraXY3?=
 =?utf-8?B?RFUxVGdna3daS25OaFBwWmUwTnZCeGVFRUl0TXRFeWlZYUlRQWlRdEJhaExN?=
 =?utf-8?B?Mnd0ZE5tSDRQSDFBbURuVENXbkhZNmlQeXU5S3BaWHRoNHZtRk82My9IS1N4?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ec8739-d5e1-4bc7-a32b-08dd9188535a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 19:08:05.7565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8R8jAmWS763xL2ntwHM4U1c2+qMP5RdJdjXYG9Nt/gw8G/hkcCBi1hjCcmwTHPfmt953Gx7yYhMGYLXwLoCiHe/Hfx7C3XJF6RlFS9SYiIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8271
X-OriginatorOrg: intel.com



On 5/12/2025 11:53 AM, Lee Trager wrote:
> Not all drivers require send_package_data or send_component_table when
> updating firmware. Instead of forcing drivers to implement a stub allow
> these functions to go undefined.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---

I guess we crossed airwaves when I sent my tags to v4 :)

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

