Return-Path: <netdev+bounces-74960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F206E86796A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6B31C2A6B8
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0328312B14C;
	Mon, 26 Feb 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBsoNznR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA5128379
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958484; cv=fail; b=RsxyWLtT1vkW2JBHeAU0IK6+uGEQdvn3X2xw/d3akASGiijChbO3MfXsWIQ5RdptqQIfoMETvMTKAmzFEegQi/4F1ip5wgN/1Ac9YhlmxFK7vRmQ/Y4usgqHMWsZNQRBmMhDArlAFG+8FiVuvtHQF3pnB1u15njCsnCz38/qJZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958484; c=relaxed/simple;
	bh=MTY8IN9pZKD7Ix67CWHadsjOevh46fryvl/Y3gLC8GQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ge8gAe6ERBWBx3OnV0u4rpvJvhabFcRMxoNkw1/pvjRxaPomh4s8GcFJVLSv5AFfgJET/7RkSJL19cnuX7951RPtRoBFPAoBs3JYJBS7CzOSALMSFJsSNBhWbNYNb/CMfj3EGguyOzTJmyukmBcguGqQS4Jo/lofT+2Q9M5rIvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBsoNznR; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708958483; x=1740494483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MTY8IN9pZKD7Ix67CWHadsjOevh46fryvl/Y3gLC8GQ=;
  b=RBsoNznRqazw3iRDPh68rXueQHOJuUvin9EdxBT2R4vCsKkrCeRJAJ6I
   1kStv13SO/q6qV/v5GjnpTio1alt7L48HTKrQbV1BCNqqoSDzLb43RXNv
   FJHpZxoQ9grf+vAWv/6a66jnkf2KZRI/a7MXalpIrGD0UzYVko1Bvj9hf
   KEVVYburS08TYV3WCR/LX7LXfKSVNONDweYJaeVmmuDzX7xw+qNfy02cF
   EQuthCSeJGVlD45+8qOyGMXfoKR09rHEU4czVSuRvJf5gyp0/t1aUvJ6i
   mWSugD/SVFVOr41SF+NBc0H7jrO5GHMYhiVhg3X1A44UGelR0Ahc9hv4k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3407426"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3407426"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7229997"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 06:41:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 06:41:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 06:41:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 06:41:07 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 06:41:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2YKnzO6iNDT4GriQ4mdJEnbjAP74H4z00dHP9c4j/Su40VAeFf7aZRKq24NOzLRo4q9fsA7yDAcpKzYXSBfKNWIcUVQz5lt9WmuVsfKhrRnCnNpeamrRRVB/W7EiQFgETkU/x+LfgTJ8ENM5X/1t4UnqWHg/ccXKs6HrKNdUpFQrcOygMye80WTh1ghxkGEfvDnL4lE1jE8/UXTeAkTVR9ral8tJeo1wBM2LaJAjZRrwi5QwNADbM2cf45H+Mj5fKrkvn2cLPG1Z1FL+7xCG6XduqzYF/EeGa6NEnVn+WN4vv4mcEPMAlO5mrAydB6HRcRrfYeR7zXg0VchQ++ZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbInnKrajDrbzXngfCwe2idWC1fI+gV3Of9Qm4QROpg=;
 b=DUxoAKShpQVb+7g8JdzOIbRspHwv6cPl7/wB5KdP+OpLc6HAgv5SfvqMZ72V1KSFQv0+obxuM9eFF2KD66pFwQZrTtT7pS3iF4TyPrXS+f9LsDeMGNzKCBa3aT7l8+SIBB+IA7Y388wNUbhEpRHabpU3KN4EhgPJS/lEzLou0JFSEDB8QppYiR2un0eUbbf1vHvrod3lQv+ziEG9BQ87jZKbCL1a6uyW3+UlGNW1YmakwM4or4vCL8DaMzwnvUw+2RyRA7urEvnyNf4OX5S9YhBFPNCkJ30D23fMYK9LMENeRK9Bv34U3hrrE74Hd/2FrDShvA1ANGlxaKvuI/nGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by CY5PR11MB6092.namprd11.prod.outlook.com (2603:10b6:930:2c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Mon, 26 Feb
 2024 14:41:04 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b%7]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 14:41:04 +0000
Message-ID: <40539b7b-9bff-4fca-9004-16bf68aca11f@intel.com>
Date: Mon, 26 Feb 2024 07:40:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC]: raw packet filtering via tc-flower
Content-Language: en-US
To: Edward Cree <ecree.xilinx@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
CC: <stephen@networkplumber.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <corbet@lwn.net>,
	<xiyou.wangcong@gmail.com>, <netdev@vger.kernel.org>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, <amritha.nambiar@intel.com>, Jan Sokolowski
	<jan.sokolowski@intel.com>, Jakub Kicinski <kuba@kernel.org>
References: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
 <20240222184045.478a8986@kernel.org> <ZdhqhKbly60La_4h@nanopsycho>
 <b4ed432e-6e76-8f1b-c5ea-8f19ba610ef3@gmail.com>
 <ZdiOHpbYB3Ebwub5@nanopsycho>
 <375ff6ca-4155-bfd9-24f2-bd6a2171f6bf@gmail.com>
 <CAM0EoMkdsFTuJ-mfqBUKZbvpAzex8ws9jcrPEzTO1iUnaWOPZQ@mail.gmail.com>
 <3c5c69f8-b7c1-6de7-e22a-5bb267f5562d@gmail.com>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <3c5c69f8-b7c1-6de7-e22a-5bb267f5562d@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0020.eurprd08.prod.outlook.com (2603:10a6:8::33)
 To SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|CY5PR11MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: b0da3554-ca65-4313-6fbc-08dc36d8f58f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKjatWeK2PuEsO1/UFbnVmL1wrzw2Fny5sqQQ7v18ktjLp1/6v21rs9ZshDwpimg615UweF2BeBpKUxIKQzD8on33xk7KCrM5RgaGE/VVypMVlud6UvFmaDyDJzwOFNCoAtQukvHCraWc5hLzU5ze66cJuKIuCn5bxVLUx5QhnC8mQpdLhdXr9syALc2iZUCaQztKyyMPmbPK3KZAE+d0E9uHBbOKx+a0fBZzNFqX1h8pO1fW/DFF0IXqXtUFLPyzFwJ5Pxg6W1NSMV6QoczlMwMGf673eL69G5de+Q8m7l3vQ3nXmWkeJk8g6V0OCUdrXybKaBBMRixHX6E10jpHmAlVLX4YyPbDmDpuOp/k0lyP5KXpbVI+HdyxXjI9luZ3dNZqQucULACPEXVFraUNoQYiZg9pvKJn5+c1yxMEBSoG9aypc1vfL70DJ2M+RDOTa6Rf+kxS9dhg1fGujSStJieCgt7rAb2mXEfYG5TsLKosJC7k8T9jITLGhEEtA/Bebl1Wg6HV1tXWDHC9aMHYs53s9pM3H9jd7hxXof0vMzLQyGIsjH9hDe0I3q4vaKmF7NVY5GKPSJqtSJEt+qlufJFY6tZGCpGZgkdDltcY5FQRkJXTHgrr3vT7ja1xoZj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjNsWThSSnFhb2pBOEJHU3JNTURSVFNRdnREanlBYUZlWHZ2L1RJK2lBZUlH?=
 =?utf-8?B?K3VSVE5OZnRqdzluQmtrbGVkMkVWQlFOMjQ4QlZyN1oxM1ZmdFlpdURFUno3?=
 =?utf-8?B?MElTQmN5V045VE5RNm1Bc1FndjJ3NCtEVHhmR3hqcnYyZlIyVFA1Y0lRUWJZ?=
 =?utf-8?B?UEp3WTJNdG1iOHl1aGxqdWJ6aUMxcDdJVG90ekNFZmduQitHT3czd1FnMVVn?=
 =?utf-8?B?VjZNK0k0LzJsWnFvbndOWjBhdkUyYmd6M3U2djdNVW1KOVMvZjcyeGp1S0hx?=
 =?utf-8?B?dHNpMzJwaFFic1hFNWxqZUtBcDdndTF0QUU1MTdtVU5tOWV5VStsbU5JSUlu?=
 =?utf-8?B?SkNJc0FGQi85dlFWeHhGWEQ4clkvYjUyK0tHa2xNR2tiS3g0MEYvZC9Calgy?=
 =?utf-8?B?SjIvY0dZUFdSTVBmM3NUSExDSGRjYkVVam9BYXNtaEpiMnZBY3NKVFluOFFn?=
 =?utf-8?B?WFU2eS9mazZBcUYya2FlOVAwYy9hS3dmT2hZbVV1VGNrbG9vSDhib1YzZGFy?=
 =?utf-8?B?WERzNmd0U1JxclVSaEdiSGNPNTh1SlcyUHhZVEJWM0ZPYmFMQmhBaU1KK0d4?=
 =?utf-8?B?bmN4RHV6ZUVvcVNVRUtRcmUvb1lHMjhBSmJvVVhWTlhvWERKWDdxL2hLcUVu?=
 =?utf-8?B?cElnZjBZT3JnWUJVTzdKUk15SENFbG5TY0RYYjN3U0srSHRkdDB5aHdTa0o5?=
 =?utf-8?B?REFKSG5yNzBjU2hKT2E2UFRKS3RTRjJUT28rcWVTWGNwU1pHSjQrWUFjaGU5?=
 =?utf-8?B?cXBicWs3d2FzYStVSHNBLzFlTkQ5ekhpQXFvRFZTekErVTFSemNXSFRtMzdX?=
 =?utf-8?B?OUd3QnZLWTRYaWpkM1lPbmlnOWhKYWphMmlFMEhWWnF0aUQ4cTZTUXlnNVRr?=
 =?utf-8?B?WmtBazhLcWR6WnBjU3ljazhOdlVpTVAvR25Ra1FWWndDN3VSQjlLZFpjYWFD?=
 =?utf-8?B?ZGRYZEVtQ0dJWlByN0dXaVMyNkFVa2pqZFVISWtEQmtJa3ExK2JCT0dsb0t6?=
 =?utf-8?B?a0NFUzJyaExLblJWVFQycEs0WUpJN2JyZ3MrMTdLWmZSYnRsSXRSdDRtekli?=
 =?utf-8?B?MGFpalR2Y3FLMjRIVFUxSitEVEhjaGFUcEU4N1lITTZneHRNQUNjL2xPOE9P?=
 =?utf-8?B?Zk81VVc4cGtIYW9aRitGUHFVZTg0SzRrbzh6UWYvaHRROWFYQXpiQzRlU0Vz?=
 =?utf-8?B?UlJjV1o0NUR3U05uRytnVVZPaDAwYkw2NHRmR210U0hZNG1TSUVJUFNhbkN0?=
 =?utf-8?B?TzVOd2VtQW9XQmROYVhjNnNDZUI4dHRKbnpXM0U1Q2pRaWsyV3NhZGkwa0JJ?=
 =?utf-8?B?U0sxbURXdFdoSnZtakFLeEFJVmFtb1VvbkFtckVYU2xuUDdMWW9HdTlXL3pw?=
 =?utf-8?B?MHhJRUhyM20xK1ZiMmRBOWxCYW0yazZ1YlBDMG5FRXJ0UmlVUEFJZ1JkK0Ir?=
 =?utf-8?B?N25QVldnMFZJQ0s5MjM2UVJ5YU96L3FqVGdmTDN2R1dkTkVqRzF3Y0tZSWl2?=
 =?utf-8?B?K0lLKzNqeWlzQkFFS2tyTmFvK2ZJY3FaenJoczY1a0MwZGZkNURqQitOR1lP?=
 =?utf-8?B?ZHZpei96WXUxY3dkV3lVTFYrSnRxVkpWcVRUdXRMT1pnaFU4U3dML2NRSnc4?=
 =?utf-8?B?bmpueFBCSWoyMFN4cTBvYnY3b1M0YTZHYW03Q0cvekxrYzVDdUxML1dsVVZj?=
 =?utf-8?B?T0hiUVdDTGVrZk1DMmEwQ0xNcnRyUTVqK2xiME1RNlMxOHhYR0FWS2Eya3Q1?=
 =?utf-8?B?M1JwejlJaEh6bFEwbzBvcjB4MEJ3NUJsSHVGcHpERHlBbG15K1RrZ04wdXdY?=
 =?utf-8?B?cEZ1ci95QnBXb2RnTEhXOGFqQWxRMVQwM2xuSXlUM2QxdithYk4wZU1pNFkz?=
 =?utf-8?B?ZWpNMWdPSlM0d2U1OWdETXk5WGF3Qjhid2U5aGVwTTA2NTNvWE5PNTltejY2?=
 =?utf-8?B?bUdSZThVcUlIbUVPaklLbFd6dEpvRjdUTStzVFdWcXkrNWZSQzhTOUZIdEdS?=
 =?utf-8?B?VEc1aVJydnlBT0YxUi9ib2tOVkhZdHVvdkZ2T21KVENMbFZHT0UzUjkxU1Rh?=
 =?utf-8?B?a3RPVWc0MmlWVk9sbG9GeFdUQTBVejBNbHhPNy9vcG5hSk5NeHZXQ3RSdG9V?=
 =?utf-8?Q?S7mEOvAP7Mt+bEy+9Gbvv8jzS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0da3554-ca65-4313-6fbc-08dc36d8f58f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 14:41:04.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL/Gvczh17DbW5JQ7+ekL9P9SZbPwuEW9pi0T4PhTC5DR5kzSzVGciUhwZYjkuSPw5FuKQsinqI3/kO1kFnevw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6092
X-OriginatorOrg: intel.com



On 2024-02-23 6:44 a.m., Edward Cree wrote:
> On 23/02/2024 13:32, Jamal Hadi Salim wrote:
>> u32 has a DSL that deals with parsing as well, which includes dealing
>> with variable packet offsets etc. That is a necessary ingredient if
>> you want to do pragmatic parsing (example how do you point to TCP
>> ports if the IP header has options etc).
> 
> My understanding (Ahmed can correct me) is that the proposed raw
>   filtering here would not support variable packet offsets at all.
> That is precisely why I consider it a narrow hack for specialised
>   use-cases and thus oppose its addition to cls_flower.


Intel's DDP (NVM) comes with default parser tables that contain all the 
supported protocol definitions. In order to use RSS or flow director on 
any of these protocol/field that is not defined in ethtool/tc, we 
usually need to submit patches for kernel, PF and even virtchannel and 
vf drivers if we want support on the VF.

While Intel's hardware supports programming the parser IP stage (and 
that would allow mixed protocol field + binary matching/arbitrary 
offset), for now we want to support something like DPDK's raw filtering:

https://doc.dpdk.org/dts/test_plans/iavf_fdir_protocol_agnostic_flow_test_plan.html#test-case-1-vf-fdir-mac-ipv4-udp


What we had in mind is offloading based on exclusive binary matching, 
not mixed protocol field + binary matching. Also, as in my original 
example, may be restrict the protocol to 802_3, so all parsing starts at 
MAC hdr which would make the offset calculations much easier.

Please advice what is the best way forward, flower vs u32, new filter, 
..etc.

Thanks
Ahmed, Sridhar, Amritha

