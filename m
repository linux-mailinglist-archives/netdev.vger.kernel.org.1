Return-Path: <netdev+bounces-285856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAxDILDs/WlJkwAAu9opvQ
	(envelope-from <netdev+bounces-285856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:01:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A5B4F7817
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53BBC3076509
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506A37419B;
	Fri,  8 May 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWFbeUMR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3443E1CF6;
	Fri,  8 May 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248748; cv=fail; b=hykHH3aLSSO9lgufSS1/bLADrY2dNSIArnnQSz6I4HAVvNOQrXzXhxysMisOfrlDz3/aP2FSfyyiT7l/DmhXqZb5mQE7k3IRAIFcTmXF90Lx2QE218ecSBBKWr/GDnkfz+bSpEudPY+IZqxgvypx6CffvZWubeGmPRHvN1eDl8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248748; c=relaxed/simple;
	bh=ZCol0vQS8fCFXSYrgeFEY/j2G6qiGou2ieYC6O33k6M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7zVCloOlyHBA+jftIl9/G7RGKt0Etkmlcj35BaZPkLqd9mgV4REqHSF1575ja4kfLhgsC/7Y4v86uQw9pYCw+qtbnnp3zX5TRY3eod4/QmJAwmnYy3LU9/kFCeY8ixdu5tvEXPyIZ8NNsGrH3cHU1iiXun0oBnVeycl2R0/6l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWFbeUMR; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778248745; x=1809784745;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZCol0vQS8fCFXSYrgeFEY/j2G6qiGou2ieYC6O33k6M=;
  b=lWFbeUMRie76H/EdbmbLh83lFObcMCPue7SRKzn7Nt9atv36hImwwD3l
   hZTIbo9LB1SqL0H8r5LKhttyUGEVQiQrHnoorhsjmw1fhHOk8zyhIK+LV
   bZydFuHLrPUsG5SvTHzEvOSonVj4t0mSQ5Pj7wX7+n2FywtJ0QB3eixcn
   EIvs6/LEhaas/rU4Hc3YlDeCR+IJXDrBGs/GJ7K27uSl5+wjUYAS1bz3v
   3iE+HaH0FUo+CsFEQR4xUjZqzSoAXYuUg1VC/v6ff+wfKFEnRXFDDtxTb
   oJeu5bRFcpkHv4XFqxsEQNiRU1O/HJdNlc9zrfBMIIw7ZHNjR/7gpCGGo
   Q==;
X-CSE-ConnectionGUID: JmIFHYoiToqo0bY3X9BuLQ==
X-CSE-MsgGUID: ywZCAdJ2Roeia0jFdXlylg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="78235954"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="78235954"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 06:59:02 -0700
X-CSE-ConnectionGUID: dOZ5jrGRSnKLdSXp7mS2HQ==
X-CSE-MsgGUID: bMM7cKS6TYS24YeKeSKudg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="232433307"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 06:59:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 06:59:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 06:59:01 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 06:59:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3rqF0mRAbgjNivGTQDtN1kqAtKBe8DsiqKshJfpsXFdukNACXeXqdC4BRO1JBLYGBWGTg6ttNWu0h5uCAvJO0C9WIvD8gBhFFuuC5VZsRQ0mSSaMcHD3tL/TbDfbjq0ir6hf7KQjq4zkTSEKDGQuQN+2PjJozDyOsmIT5ZmmAe4DH4WHkyv0JLnXdRAktWeYdifeRAV86qvhms2CFz4/Kil/yp1QBNJbltS51Th90sWqOhDVK4x64EqBjWnHKSdL6NKdHrrvEDdH2VjEIhyfmEfUFAkQsFshc1oyAxxj+EdFOij62gvZtyPOh0Wu13wXfmqgcrm8ECuypPGRgQQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCd3pZLX65r9ISI7BSKDqnX3EhbefH0nOEOomUPNhdc=;
 b=gaL2mxkL4wxPAZe4s3p2TYRM00zQ5NT+OLTMspp9IxIp9XVmtrOFoDFd8la9YkIuP0vWZV8lUwGT/miEy3NtfPPxiD1pKPBUPxJ4x8CZlJHI2vMQScAxo9BYVSsTgGSRHMwLwrq1zSSMau5WxV3oOjX3Ep1VYyQlIPhlF7TZmV0ArxDLu277OXe6zc2N3/bR8Hu44UnIUYZYhoTWSQk1qrGGXfCegFgEdAKpYZ/TtpmgjCDgkvKbctjdUFgejGbbpLNH4gb9QxF/6ioaQjiGA+56PlIhNCTEUcDPaRCrQyLXubJ++Ac1vV09fNxIsKLDACgpm93FVKoC3BXRbn5STw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 13:58:55 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 13:58:55 +0000
Message-ID: <5eab9525-6fbd-46ae-8464-12ca9472bea1@intel.com>
Date: Fri, 8 May 2026 15:57:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v5 3/5] ice: migrate to netdev ops lock
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <kohei@enjuk.jp>, <jacob.e.keller@intel.com>,
	<aleksandr.loktionov@intel.com>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260505152923.1040589-4-aleksander.lobakin@intel.com>
 <20260508132827.1183079-3-horms@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260508132827.1183079-3-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b24704b-39cc-4c4f-974a-08dead09f14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: iQx2Ja/AHRd2rEQ7dC77v5hTqCKqOvtLdNWUH4pmwachOYRM8u54iBfkG1IOpKU1UeKGprX+hVpkIKFztIPlSTWkJus4SyyqxlR02EUMoE/ZUJ+ZH2qT9j0W4+S1m8ZtgNkzCqrN7FZm53UpItb2eCjzHOUkKj3Gu5nyeYRn9D+kBBmmrieu2UstKU7+ROTcLsfhNo5ymC3o5gcRh/0p0Fh5+WAo2mvdNO/qc5f9OavriUTA3V6jW9Z3OtIzO6rH93DWUz9W5DDya6ZrN21rFAapu4hTFZoWGD7N52dYkNmbIfQSCHAFpFPUVh8bAE3VBd1mbcZSWXwsHHStcz4JR3XRp03S7QvUUf4yyLkqJnaO/M8EmnC+g70TBGQlW1tzU7pl40jJGJhqCgPAQJOLi5ZXRB3IEVKJ1w6Bx6UkkKvxYuN4oed9lIjQaSCn4pzlW3Zfgj02RjrmvJP/5KTg8Iu7Tc6Q9Xyiz2bfKQkO2hTtLQvC532I76YNKGZq4z9HHit1yf8/Aq09ThnmlFRTIa0JTr6hfgtQtYoyfKxOy6Q2S+gfHbkJt4er5rX/94sjEQxJfo1/iQFwxki11fp0Tkh2EpOtq+PsROxC08thCOve9zZzA2POTxhnRzr09zUws78YLLYuOiOrne/W0WyQSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRPS3NCRTlOYmxUMHVtOWdicThUMzNYM0hoOEVxalhPWjVXOUVuRFhGYVpV?=
 =?utf-8?B?bi9TN0hXWi83NHY2UU5NMWJzeVFrcGl1MFZDRDR6VVdJUVB5ZGlwRmMvaWp3?=
 =?utf-8?B?bjZiRklUZGsyMTdPcldsaEV5Um9Gb24vWERETklrTFkzak0yL0ZuUXBUUXNO?=
 =?utf-8?B?MmtWL0RtaWpkNDJhUFd4K2VpWXVYQjdmWHBFek9ZdE92N0xrU0VUWjcyaHZP?=
 =?utf-8?B?UnpTQU5oS3hVd3FhTUhXOW5BZDBjZEwzOTJ5NmZJaGo0bXVUSk43QlVTd0Zi?=
 =?utf-8?B?NmVyYldoYmFUaldEM2g3eHlpZk9OS0IwM3k0NWpiMWdxaDlmZ1BheGJjZWlw?=
 =?utf-8?B?b0VrMHdLV1lYMHlERTdYVGl3VnQ1VHplejhGM0FkVVprS2t0aGV6ZXBDWTJz?=
 =?utf-8?B?QXBmcmkvOUhVYUw5SFV1Z01FeXhoL0IrWkVuSW1XeS8zam1ZcTBZejVCZzVm?=
 =?utf-8?B?S2d2aVZtNGVUenpoNFpIVkFZSG9lODFpS0thWWNnMVdmZzlkNXhjM0VzOG5p?=
 =?utf-8?B?Mm43bVQ2QXNMYmJ3UU42cHVENFRhZ2NTZHlpWG9TZ1hpeTU2Z0svdDd1eFF6?=
 =?utf-8?B?NUhMaTBlL3NrNWJhejZrWWVqRVk2TEUxZG1CTXVBemM1UUdBMzYwNzBtY1pU?=
 =?utf-8?B?YWVtclFkbGZFclFuMzMvblg0eWk0Y2VHVnlLc3FwSHcxdnRpWUZEZ054disr?=
 =?utf-8?B?ZkxiTEZlU09RNlJoMnkxK2tqL0pWYXQ3Ui8vaHRHaXZsTDdhK0FrbWVVT1M0?=
 =?utf-8?B?SDNvdjNBZHIzYlg1QXd5cjlCSW1ScnQ3N2k3NC96bmNUWFFzYXdvNEQyLzA2?=
 =?utf-8?B?a2NyTm1xSllhTlhXNmRLdzlwdFBSQXdNZ2RtN1orcU1kN3FkS3drMDRPZFNm?=
 =?utf-8?B?RFA3NWg0eldXMHhrVDFXZ1QwWmNGMFJ2Zkg0NkVremM3Qks4WjhWeFdsMU9N?=
 =?utf-8?B?aEp5aWJ0eGpRVGNNSDdjdjlFQndPcGE3dVd1K1AvbG5KbndHNWJBR0pWM1pr?=
 =?utf-8?B?elNNT1BJeDBhYURhbEtJaUtPeTl6V0llZndMQ3M0dnlndzhFRnFSSHZFZ1VT?=
 =?utf-8?B?U1JaREJON1A5WlpzTEZ4Nkl3OXMyYkFKd1lETnRsS1J1NzVnYVNpeGM4d0hB?=
 =?utf-8?B?ZW5RUHRZRE9wM2xSNWZQV1NtVFNPN1gwZmFsZFNQeDVHRTJYbW02SFltb3BI?=
 =?utf-8?B?alBBV0k3WGJ3cUI2VnFWOWM4clZBeXQ0M1V5eGV4NGc1aEhHYUkxR2NreFJ1?=
 =?utf-8?B?OUhuZjdGaVRMRkdxNS8xaTRNNnRmbmpvMnhsY3J6VlROeUNVRFU4NkpoSEtS?=
 =?utf-8?B?TnJpSnQ3TEdaeldaV1NnS0UwSHRRYUhvME5NZGorZHhsbHRXeC9TbVVDa0F0?=
 =?utf-8?B?eGsyOXB5NENFS0tUSy9CNitQK3dnRi9wczBmYXFzeWNkOXVCZEpqVGN1bERI?=
 =?utf-8?B?ZzR0cnJQdm5Rai9BakgrTUkyZXJhU0ZQSGY3NDljb1pIc1N6c1BqN3hZY2Nx?=
 =?utf-8?B?RkxURFBMajdSb0pKY040YWpDYmljUS81OTV6a1BzZHZqT2tkVC9zOGJkYmZJ?=
 =?utf-8?B?VmxMM3FQY2RjRlJYMzhwblBJN1VHaFk3eFhkWllsOVV4N3U2ZlBXa29qbTVW?=
 =?utf-8?B?U3RUekZraTNMNi94MVhLaU53aG9YNFpHNjBMOXlWWHViSVEyQUlBZGNuUW5w?=
 =?utf-8?B?VTdoWlByeHBnWWU0SHcxM3k4empyZyt3dlFvV2NkUWRXa1o1MUNBeVlaK3k5?=
 =?utf-8?B?TVUrL052UDBRaURpVncwU0hBendXc1hPM2xFSjNvYWZVWTFDbkR0N0REZm0z?=
 =?utf-8?B?RWFVdmlnaS93TndOMkxIYWJZZGZab0hTTFBGSENjSVkvZDQvU2V1N1Jzd2JD?=
 =?utf-8?B?N3N0L0g2VG0zYlRPWVlPN1haT0E5WTRhdUhhRDgrRHQ1alc0RU9oTkxqR2tV?=
 =?utf-8?B?RDhrU1RJSm8remtpUGMvWUFKUFNzQkRZNVZOa0ZDZEY5U1doKzllTUtGTFl3?=
 =?utf-8?B?RWtPRUo5NFIyVE1lc0lHUU5nUzRBZndpTkNTcUZ3WlpabFJpLzY1bmNyeDNR?=
 =?utf-8?B?RjlTSDBpcDlmSUxUaTRTQlUvV1JwcHFVYjNtclZ5VXM1ck1UdVl0cWhWbXZQ?=
 =?utf-8?B?TG0xVnIreE1wRVZSMEFlNjY3ZkZMTk11K2hmb2tmSUFOS2IwTjBDTjY1ZXdP?=
 =?utf-8?B?RU9jc1piK3hRc0UyWnJJcHZoaGFIMVNXak1WSVFsMVc0TjhMQzRGTC8zVVgr?=
 =?utf-8?B?VzRIZXFHMFlOQjE5VU40dmRwSnEwbzQvMTdDQUdQRTg4NU5vdW5KbFBTZjIx?=
 =?utf-8?B?MW9Rb0FkNkUyeThYNnVIdkRVU3c2bUgzb291aTQ5VzVZenEwbWdvQkRoVjJa?=
 =?utf-8?Q?VZEwtnDbgTsszeIY=3D?=
X-Exchange-RoutingPolicyChecked: kecn4s4RQ0kKu8Oa+9oDf4ep7Ptj2vOU41ZnxsK72rJ5prPmjkNdALWuY4kiLEOB3Fu1F/upcHqPB3Q9hUTYNetAWFgc+E0xv8d1C5bWet3v2fJMUxbAKo9QiA+fFsWrN5saC2qT71HIH2hB/bVlYvJgk1kYxBlAr8mkxxnbF8H4y1hzBs3C1O2tPvkIwMDuWSdFl33bMfH0w/NeMEciV4LsF6/xy1rL6WBmTXV9fMTMPbZzUQ9W0zre/XkKvLwvLkyX2+9aGLT7gZTAXxpWeWL+MQeX6ElRP7LsJaVEoeGPWxNETXi2CdCRfv5EVLxl3zjTGVl+Fpv17vcwBZpuOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b24704b-39cc-4c4f-974a-08dead09f14e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:58:55.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUw/Bj9zIJbS8hnS33PSYKzDx7zHYAcxriRV5RewIeN1PcgMh4MfzlH8V9IUmP8qHSyQqumiN/O9yyELd9Hv3QRXiEeMO9m+E+SOWQJqA0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: E8A5B4F7817
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-285856-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

From: Simon Horman <horms@kernel.org>
Date: Fri,  8 May 2026 14:28:29 +0100

> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
>     ice: migrate to netdev ops lock
> 
> This commit migrates queue management operations to use netdev locking.
> It updates several NAPI and VSI configuration functions to use their
> _locked variants to avoid deadlocks, taking the lock manually where needed.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
>> index 16aa255351523..7d89c0acc5d8d 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> [ ... ]
>> @@ -1107,7 +1106,7 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
>>  
>>  	rtnl_lock();
>>  	/* disable VSIs affected by DCB changes */
>> -	ice_dcb_ena_dis_vsi(pf, false, true);
>> +	ice_dcb_ena_dis_vsi(pf, false);
>>  
>>  	ret = ice_query_port_ets(pi, &buf, sizeof(buf), NULL);
>>  	if (ret) {
>> @@ -1119,7 +1118,7 @@ ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
>>  	ice_pf_dcb_recfg(pf, false);
>>  
>>  	/* enable previously downed VSIs */
>> -	ice_dcb_ena_dis_vsi(pf, true, true);
>> +	ice_dcb_ena_dis_vsi(pf, true);
>>  unlock_rtnl:
>>  	rtnl_unlock();
>>  out:
> 
> This wasn't introduced by this patch, but does this error path leave VSIs
> permanently disabled?
> 
> If ice_query_port_ets() fails, the code jumps to unlock_rtnl, bypassing the
> call to ice_dcb_ena_dis_vsi(pf, true). This seems to leave the affected VSIs
> (including the main PF interface) in a disabled state (ICE_VSI_DOWN) with
> ICE_VSI_NEEDS_RESTART set, which could result in a denial of service.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> index 2e4f0969035f7..af0cc77fbf718 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> @@ -23,10 +23,16 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
>>  	struct net_device *netdev = uplink_vsi->netdev;
>>  	bool if_running = netif_running(netdev);
>>  	struct ice_vsi_vlan_ops *vlan_ops;
>> +	int ret;
>> +
>> +	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, uplink_vsi->state)) {
>> +		netdev_lock(netdev);
>> +		ret = ice_down(uplink_vsi);
>> +		netdev_unlock(netdev);
>>  
>> -	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, uplink_vsi->state))
>> -		if (ice_down(uplink_vsi))
>> +		if (ret)
>>  			return -ENODEV;
>> +	}
> 
> Simon says: It seems that the topic of locks in this patch has come up
>             again ¯\_(ツ)_/¯
> 
> Does manipulating the state bit outside of netdev_lock create a race
> condition with interface teardown?
> 
> If the interface is concurrently brought down, ndo_stop (which holds
> netdev_lock) would call ice_vsi_close(). Because ICE_VSI_DOWN is already
> set by the test_and_set_bit() call above, ice_vsi_close() would skip calling
> ice_down() and immediately proceed to free the Tx/Rx rings.
> 
> This would leave the hardware queues active and performing DMA operations into
> freed memory, potentially causing a use-after-free.

I ran Sashiko internally a couple times and it hasn't found these =\

Anyway, now that I anyway need to adjust the series after
.ndo_set_rx_mode_asyn() landed, I'll take a look at this, too.

(I hate this series already. I feel like if Sashiko was alive when other
 vendors were switching to the netdev lock, they'd have the same drama)

(I was planning to add devmem/io_uring support to idpf after this lands,
 but given that idpf is way more confusing and inconsistent in locking,
 I'm not sure I'll have enough patience :D)

Thanks,
Olek

