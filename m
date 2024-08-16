Return-Path: <netdev+bounces-119306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F794955202
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B641C20C42
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5F88063C;
	Fri, 16 Aug 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrAo9Rdx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054E44374
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841151; cv=fail; b=AxPWvTBmbYDYJbSOcSnG1HYmJFJXPkL4ERsaYjDyHMgXYLutzHpu5EHmbzYLCeafnoC1l5VkeKaewLNuw2c1E8q6aXyXfRfJAUXPsonPbmq71xqodxNsecjs1KiZy/3hLxWVVcD1LOLBuYlxwwBldjkt1stIICPtU63r90EM9d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841151; c=relaxed/simple;
	bh=B5lrTxlgsxjrUZ4UJVq7pIc+ufQWoYmb9xF786u0JsM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+RewjjQfzmp+OKdBNYJQKmTv5+riT8q5GVqZdH5XGly2M8kc2PRUh9p+JhLZulD4i7ZjNS2mPD481akRJSuHjrgopBmu1cXIuGC0p1stNPvfmFyPFpCx8QoLWIxMStpZm9YliOXCnUwbtkBLErPSOWedkL/esQ9HVSQBb5eOQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrAo9Rdx; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723841150; x=1755377150;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B5lrTxlgsxjrUZ4UJVq7pIc+ufQWoYmb9xF786u0JsM=;
  b=WrAo9Rdxf0bcOdI3vfd0R6DyHZQ38xHxot51UnY530qGwKAnaUC+b0uN
   Xwz881FBcohFxdtdZIvR4II8FnKShU2it7TrAdhgNNXQTAMnB8PS9E9b0
   pkkeFB2NaXSQnQ1GtOY/wCvuyCvJpjsLxzu2UUwz20NhqOwNyzDNDUnCd
   8IQU3SRVHE4qtEz3zuM8kbx9RRnZdAnWh6Nh8+/3tECsNgTRPPNGanPM9
   XgZ/0PJPxton4ZKVlBmG9loIlePYq1nN7fMAYyvnMtjUWx2KRUXqJupm1
   1Ouo9Kh15pKTAr3ENLyVrUc0WZ2YYCVDCEm0tI99oHkLIslMPKqJrOYNQ
   Q==;
X-CSE-ConnectionGUID: o2kB5SneTW6+SlXQiT9B1w==
X-CSE-MsgGUID: 4JdUoTMnS8y2VlBDLLmsoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="21696472"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="21696472"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 13:45:49 -0700
X-CSE-ConnectionGUID: FLcHjkosTWKdqA7Tjq0t0w==
X-CSE-MsgGUID: 21Ij1UvfQ9OC/xE5UtUV4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64728086"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 13:45:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 13:45:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 13:45:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 13:45:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXrcmLGYuxFIL5Epvd2C6tsXdPmV9R9v+NHNpRYyLpmlCpUN9joh/7Gl0GMP3hPhzGk9bQbtIVwz3umRn1XppAr+y4ZR0NduK1WPLWJCtb5edzUD5ksllFG9mlIUzC/sq7ZpHhTylAuJY+dYo8TaJ//5NFUAQ1AGDs64CNzkZSdgnFdVKIoQONtn9qEJuFyMn+nMJxBTOr4yQ/OBmrDxIVd4mvzY2t7J8jHGw79cftT/yERwVmZTWnQtnBCok1FgYvaJM19KcK7/BvIY2DK3jngmhpwffQYjv67xS0V3CFfp1znr6rILuGt22W4qtvU1dvKIJO9bqUPUvjWZpAtlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgMaBVV6BfHMMB8pJRs6/cR1FeH8AbevNATBQsuqKZs=;
 b=rHuj3b+gP/nyxRigNQclTXSutzGu17UpYdTdPNlY0/R3YxqiiZkhMmGbPC6w4S9Haxornew4ocD55Xy1uq3ZgO+yZAWWfoM30G/X3TX/xg2VGTdiC/wlDcRGWzS/8RpsgCfHFPtE1ahqbcs+69UGg0gc9x5NrRKSfKhBhB3aYvU9F0eK3pFi+pVrjN5cNg/v4up7T8alutMXWdllUaEi3Pj8xynP/yft26UFPlHLtaLFli2/d6ch+wjRX7myE8m1BJxMVkvghJSzh82hf7RBDPE8FMulVGFO2/QZdcnXmJG+hG7KV4aeBicACLmcdG40hpBjLQqihobD9KlCFImxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 20:45:43 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 20:45:41 +0000
Message-ID: <964317c1-9fc3-a96f-3a03-bf5d0dd8f49e@intel.com>
Date: Fri, 16 Aug 2024 13:45:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 0/9][pull request] idpf: XDP chapter II: convert
 Tx completion to libeth
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <aleksander.lobakin@intel.com>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>
References: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
 <20240815191859.13a2dfa8@kernel.org>
 <987c5606-0cd3-8e76-3a6f-25f2406a1d51@intel.com>
 <20240816134049.4f7b6c8a@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240816134049.4f7b6c8a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH7PR11MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 3befa39b-a417-459d-1cb5-08dcbe34642d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDR0akJQTHNPa0o4eGx1Smt2cUY1TFJ2VmJ1N3lhUXAvamc3dGNZa2hXR05R?=
 =?utf-8?B?UHNQTU1PRlRCNlJoc1JQNktxN3ZrK3ZKVEptMGorQ1RweWxFcFpJSG1BeExC?=
 =?utf-8?B?MzczVDNmaEVKRlVtbVY5a2hnVnErTlhvQ3BtRGozY1ZNeWZBS3IyN3JpMVBn?=
 =?utf-8?B?V254OWZ2c1o5d3JTa1RoeXNXUmFKd0dPeEs1Z09sSWJoVDV4SXdhOTdGRFhR?=
 =?utf-8?B?a24xYUFHd0tWRk13M0FBaDI0TU82VHRMOGxBV1Z3SmdYaGtRTU1BUVlJbStU?=
 =?utf-8?B?U3E2U084Uk56ekE3ak5zbXVKSVY5Y1MvSzgwUkFaWFNUVU1aa0srcHJDTko1?=
 =?utf-8?B?VjBxWnpvMjJlS1ROcnJZVHo2V2hIbnY3SERpTnppWU1LbmNId3NOUHlZT0o2?=
 =?utf-8?B?WGtuTDVOMjBkSU1WV1FZc2RXeEhMb3RPMFFGM1ZqS0V3UkkrMjRpYUVSczNY?=
 =?utf-8?B?RnNNR2JDTHpSZTJFU2lNRGN3bDVPZU8yR2l6MlorNEZHaWxRQUYwVDlQV2la?=
 =?utf-8?B?bXdCY3FhRnorMlVjYW8zR25PdWhOYkJ1ZEFFQVBtUmJXZTEzV2pzYm5adVBT?=
 =?utf-8?B?eVJ6RkFDblliUkhURnpyMFk5eUdxWXRWYTFET25Ub3FsTDZIZ2diWWkzSHN0?=
 =?utf-8?B?UnpTbVhZTU5lcVJYbTUxbXB5ZldyWWd1aCtidUdCQ3ZxSlJCcysvd2dmbFpW?=
 =?utf-8?B?NzZBbDVwSXBud1dqUmpOMjdjaDNvSTYzYmRrZTk1OUtNQmlhdGhhd0NadkxH?=
 =?utf-8?B?QnA3eks5Y1J5VHJFVyt6T0s3T0c1eUdpYnN4RTdURnJyK1Evcm1EUm9IZHdL?=
 =?utf-8?B?UFpxVHdrK2s0REZlVU01OHJHQkFwcE5nbUJSQkVCN05ITmtTanZlbzhKcDFu?=
 =?utf-8?B?Z1l1VzREdlJKT0l1ZDZna2djZitGU0hCZHJGOFN2c2VML3N2cnI1YkZoTEZl?=
 =?utf-8?B?Z3JIS3lNcFArdzBPWVlKdDFJeFRzc0hvM2VzR1ErRy9iKzhwNUZGN1UraDA4?=
 =?utf-8?B?UGM4dUxaeXpMVVdJSDVWUGFGQ3VSY1VnNnBTRFlyK1ZBU2ZEZUZxY3dDYWgz?=
 =?utf-8?B?MjgwUmVJQ2lyUllsWWtzckRwSEhiNXJwUkcwYzk2N3JFZ3dGN0Nic2RLY0s3?=
 =?utf-8?B?MmpuVjhQNXZxRlZTbjVTMHRyZUpZM2c5WExQY25sS2VGcnFsNnZKRVhvWnFw?=
 =?utf-8?B?SFdLakwyVUVrTHhRd2xRcW5MYXIzSE5PY3duMndmclNJTU5mUjJoVlkwS1Nt?=
 =?utf-8?B?VmZORlJNYXFxUmVGdk1BYXRMTnIwdWZ3bmIyVU5ib0NsdStuMGdnMXVNenFE?=
 =?utf-8?B?OG4vdHBNMjVncE9BWHVDYjJWazQ4OUZ1ZVhoRVYrUlBaTncxS00rdlNJMWFx?=
 =?utf-8?B?N0c0dUZwc3JTQ0pqSmNOc1pHQTg4NXNNWjVvKzAwNjZUMEEzc2JucFUwYXJ5?=
 =?utf-8?B?MUdZazhUYTZIS2RuaVlMeUFBUTdKcE5CNDNvZ3dhZEcyOGVRRFlyU1dnNW5o?=
 =?utf-8?B?cHhVblVpYUs4SjZ6K2VLemEyaVZZNnAvOC9qWk5EZDV5eE14cDYvL0pmM2Jl?=
 =?utf-8?B?L0cxdlBuOXJQcjVNZXJJbU1YVEVsWjlVSi8rYkVJRFVLWER5S2kwcjNlMnVW?=
 =?utf-8?B?YzRLaXVyWHBqalc2aGg3dm9PZUFzRVRjb2lrUWZRMjNRNDlOeXZZQnB3c3hN?=
 =?utf-8?B?SkhPL0dSSktwVGt5T1M5bExLYUROampDWW9aaFlNREdMMTFaOUorUXdBc0xs?=
 =?utf-8?B?Zm44cDFNaDN5STZXNnhpR3F6aml0clFpc1RlRmFkbjErUlk5WCszNGV4OXBu?=
 =?utf-8?B?UDNOUzZTWEVic1AxcXdzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1dtU2tsbDVzRFJRajJ1U29neUNQQWZWSlpuRjBIV01vZEZLZ0V2bjNETFRk?=
 =?utf-8?B?SkhxUUJsemVCYXIwWlJnYmtma1JzKzZXaTF4UHJHYWhYZTk5MUZwdHduK2VV?=
 =?utf-8?B?WkdId3JnbitkeUxJMUdlNEVKcFdMWlFKb3pMeGw1c1NrL2lldThySElHbmM0?=
 =?utf-8?B?ZEJXaVZsNHkyUmRzdllqYjRoOUNlUUFqQldleis0NGZuWmdHSC9zM1oxQ080?=
 =?utf-8?B?eEpnanpwSnMvT09JcTVaWVcvdEJnTWNWQW1nd3JWWlhIWjFPSWpoblhyMDFO?=
 =?utf-8?B?dTA1Y0dpTVBKcndidEVGL3F0S3lmTkExYWs2WDV0amEyN00ra055L25heFAr?=
 =?utf-8?B?eXFwZ3FHNGhsYXBlR0oxL1Ztejl5cUdKNHpQYkxZZWVJek9yKzFWUGFmODdM?=
 =?utf-8?B?VXhRM3BKVmhyQ3FSK3ZuR0ZqMzI1Q2xHam5INFBBUFQ3U0ZMdVRvM1JFWGQ3?=
 =?utf-8?B?NjdPWlRaMFFSWVo0WCtsWnFkL28zWEw1bnFjaUVzTFVNUm1FazljN1F3VVZ4?=
 =?utf-8?B?R2NLRDhTYkxvbzJwNFhkc0E0L3pxSVdlNXhxaTl0SW5UOUFyb2d0NXBFTXBX?=
 =?utf-8?B?RWhEQ0l3ejRHLzA0bXNoWTBHV2RlWW5ySUxMYlJkOS9VbFl2b1VCeS84dThS?=
 =?utf-8?B?amVGbTk1Uld0VzZLR3F2UlFlR1lIKzRuVG1KNTNPY2NsR2pWYjNXSGc2RndU?=
 =?utf-8?B?d2FabVM3V2ZDVFFxalZwOXV3MVM3dnZORmFXS3BwdThOZWhmODBKUFBFdTFL?=
 =?utf-8?B?UEpwWG53QzRlaXI4VWV5ZnFPejBIT1oyMWNHdGM4VHhvbWJVQ0lSUGNjV214?=
 =?utf-8?B?eTJibnArekVCc0FRQ3RVcG9zRGZWakd4RHZtdkFyNHd0djdNdzVDUjhsYnFO?=
 =?utf-8?B?YkdhQkZoUUFtT21OS2hkd25pV0U4eWdqaGxXdEpKeHcvdmgwYmlpR0FqYnJ2?=
 =?utf-8?B?T2xweFZ0NTZVcUIrY2RLWTlrVVh2QVlKT05jOXlyNitQQTRCVnNHZzlFZGxU?=
 =?utf-8?B?cXBROWpjdlpTTkpzZ2pWK0Q4Vml3QnAwM3ZlOGtJTnlMWEZ3VU9xdEpLVHJU?=
 =?utf-8?B?U0RRWE8xYm0xWmJnTGFRMytxWm1tNVNCcXFXNEpkcDAvd2pJeHFnemRpaC9E?=
 =?utf-8?B?RllNbzNjbUtZaWk1ajVhUE9VR01jVFg2QzR5T001WUtwVEQ1Y2lQbFcwcTlq?=
 =?utf-8?B?bnNGVGNyNC9zWTRZZytoVWZ3eXpjOUpySmxHbmFhVkhWdXNpaGJHbXRERGE0?=
 =?utf-8?B?V0o2UkRlTStDam5NQk13b2FTTitLQWphQlBpN1MwZHpvZnhIRHpjaFJLQjB3?=
 =?utf-8?B?a0UxNkJtQkJMb1JzenZPbFhwWTRTUXh1RmdYazduc2RtSDVtd1dIMFlKOHRi?=
 =?utf-8?B?MmN2ZU94dllXOFdEY2VaYnNBQmZVaUFYVUQ3ejE4N1VuWXQzT3l4enFqSU1m?=
 =?utf-8?B?N25XenhQNTIyanVucVBWVjRjenBiT3JYQ0NzNEhZb0xxZy9ZU3picFRSdHky?=
 =?utf-8?B?aWNkZjlodHhUVFJmSUc4VzVMS1BkZndOV1J5RHFzdFdySHE1RGgyNnBYTjAr?=
 =?utf-8?B?WW1ydzdWUlNnakVLeW1mMG0xdDFRVEdGZks4RHFxWHJWSGgzVkRVblJjOUtK?=
 =?utf-8?B?MFhXcFRoRkV1MDhnSnQ3YmVZRXhEWit3R1dBbU8wWUNhaXRRZ0pXbTErYjhV?=
 =?utf-8?B?VGZxQWt3OTdObmY4Z1kyay9RTTBmSzNBQ2tTRmFDUVZFUnQ4NlJFOWo4U2x3?=
 =?utf-8?B?Nk5TWDNQWENWMFRGKzJGN3VFMXFLWkF6enRrOGlKbXF0SE93NVdKcHg3YmlJ?=
 =?utf-8?B?anQvTTZzTzU3VkRGRndpWUpTL1duVTdVZkw1ZU1nZ2Vad3Y3ZUZjVDg5N09y?=
 =?utf-8?B?Smx6dlgyQlo1emsyUTh5MnF5WXpDTWlWNERiVXUyNm5xYldCTVp3cGFua0lN?=
 =?utf-8?B?TFBteER6R2FMc1hjTHp5cTc0eCtKakZzZGtyVVYyRytucGhBZVZ5YjlYQklt?=
 =?utf-8?B?VytSOGV6WVprY2hVN2FjdkxEN2JrZUZCNHlEbkVUeTNPQ0lwOGllSUdYcTZp?=
 =?utf-8?B?R0krdVJrc3ZJY1BCSHBaTzJlUGtZdVB1d1U1eFF6dUZoQTMxUXJYOVF1TnRB?=
 =?utf-8?B?akFlMmV3UEo3VmZ3ZVI0VHRqeXhTOTJuY3BOYXg0QjhUcVdwUTd5V0FyWTBK?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3befa39b-a417-459d-1cb5-08dcbe34642d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 20:45:40.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWyWTKQFqBk7810114S5o1JYxazNw9XSwu8eHIe9Ja2LFkZOo+TNFxzKrT5WCTEen5Wl44cW22IqdFdubDyaMPvFCcmCf1q3NG03iG6MRdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-OriginatorOrg: intel.com



On 8/16/2024 1:40 PM, Jakub Kicinski wrote:
> On Fri, 16 Aug 2024 13:31:52 -0700 Tony Nguyen wrote:
>>> Eric and Paolo are mostly AFK this month, I'm struggling to keep up
>>> and instead of helping review stuff you pile patches. That's not right.
>>
>> Sorry, I wasn't aware. I'll throttle the patches I send for the rest of
>> the month.
> 
> I was hoping you'd take the opposite approach and push some folks
> to review :) But either way helps, thanks for the understanding.

I'll do that as well :)

Thanks,
Tony

