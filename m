Return-Path: <netdev+bounces-70803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF3A8507F8
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 07:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29962866AD
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 06:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD13A8F8;
	Sun, 11 Feb 2024 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlANF5aH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2223C5
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707634435; cv=fail; b=VU8rTKau9aLStE3pHZTIADBkbD2BLFl39SdHZ8eTAvFAEzmOTZ08F8TiyBqtfUy4/8z1Tea7KQ0Xs6yVqHWFB94PPGbcT09K6Fpy4yTsrm91VWiaUq5AxjV++rFogapOh1u5YIAXDtofS5gHiuhUnEN5bvJiR96cRI02LLZRacc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707634435; c=relaxed/simple;
	bh=97MS8PXb1Af74OCWSE3kPvzgT61Lh/v+PQtWvmY4jt0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p4D9W/fm9yx+BygAodE7M50201sk9QS62y1ERWZzFEXU9pqnlKlghu5KZeVSIf7dEQg/s1O/VKMq04sdlcZc8wLGgrRANRSdtZq/0GoQ8+5el5s0V/7jeptxt8r+39TQ8h6H6EjyYKjrKb6QA9LTNUGyJ/EER2cenF6yG7sSdsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlANF5aH; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707634431; x=1739170431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=97MS8PXb1Af74OCWSE3kPvzgT61Lh/v+PQtWvmY4jt0=;
  b=IlANF5aHdjbP8Hi4tB4I3G2fTGLYBZkwCQ24EPJJgQ6zQROFEiPwF9LH
   A6DnYwRFxYyZptLzFPAZ2BSxf5ZY65KUjAaDfkZgJXYMDTPPD5eifWA9m
   Bxy6ULDD6Rv/wgQunijO1m/iI4lhdVeFdsBcb1qWN9DKItxqCxxbCqm++
   JFyGUsCDfOvafg1PA9hKc1MeabyotSGv9h/L9KRNtNUW0JEumk4IsQxyf
   10C3V0WIlWEnmFoA/zzre+HfBTlBUSBw4Bh/BQ15YnprOmq7+j3bxgoph
   S75ANahhMBijwCvFbvy0A1aMUmSdtmCz/HFFhp+SeFNQHGGkH6/X1dz/v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1500226"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="1500226"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 22:53:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="934789539"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="934789539"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2024 22:53:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 10 Feb 2024 22:53:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 10 Feb 2024 22:53:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 10 Feb 2024 22:53:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLmhgcS0GnvWybbfm1TTK9numxrcbyfdv3broDIHlW4Eme2g9YZaFVE86w8DbHTmKCChcpjHOc8KK53Vxx4K40BGQoLEhq5xFNqTFCEWiNI0ygu86YDy3GFKlE7pSxfbLUzc2bcFlJv4Ah+km9H7p7W4WZamoeaS1KoXhKiGY/FtKLsdHrwbgMTgW2m3YvfB8UZ4sIRZoLvm7B7D3FujqUBeNmkem6VPIPHYhT52YdkswQF/IFUPce9yX9GfZyU2lsD4zC/VGTV7QcPiAVFMA3ojEcDWYldfUowpV9HFMq4YyIjfE1s8Vhhk5qjKWkYFdHwUaNbUgMyZh2mRUMSayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8msWpobB0tKFNBHrmf1jFrlcUlMAPAx6RCvy4cnQN0=;
 b=PKuOl4fassCtTD4mftuSsDhmHd9DJO5Mtb/UITmAWLTHwb/ChaXddbpm0TkLaRwFmVDpLREm2vo1W0UbzZwqCvTRcsZWm2Xoh83pM6RsJ/TBlyrByACZKTrze3RBlJ0bKvP1QCqXTno/4krBYC9A/hkQAipr4l6coPSZPbGYXeYORta3S/8NlPuzV3WNjreASMj6wJjusxRTyyLyqzirCpplxCKNvvoKXAUZGdBM0+5oEdX+MI/5jZ4qqnrWHd1DOR0ZmyH0rLY7aOClzWKsrcwWRXnW2QOCAaXHV1opgH9lUtg2BxtBbZ/a/NZyS2t0XrnFJUdiZPy1c070of5ijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13)
 by PH7PR11MB7962.namprd11.prod.outlook.com (2603:10b6:510:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Sun, 11 Feb
 2024 06:53:43 +0000
Received: from MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::5e2f:2e89:8708:a92d]) by MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::5e2f:2e89:8708:a92d%4]) with mapi id 15.20.7270.025; Sun, 11 Feb 2024
 06:53:42 +0000
Message-ID: <ce4065d5-656d-4554-b288-94105a3631cc@intel.com>
Date: Sun, 11 Feb 2024 08:53:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] igc: Remove temporary workaround
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>, Naama Meir
	<naamax.meir@linux.intel.com>, "Neftin, Sasha" <sasha.neftin@intel.com>,
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>
References: <20240206212820.988687-1-anthony.l.nguyen@intel.com>
 <20240206212820.988687-3-anthony.l.nguyen@intel.com>
 <20240208183349.589d610d@kernel.org>
Content-Language: en-US
From: Sasha Neftin <sasha.neftin@intel.com>
In-Reply-To: <20240208183349.589d610d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::10) To MW4PR11MB6738.namprd11.prod.outlook.com
 (2603:10b6:303:20c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6738:EE_|PH7PR11MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9accd3-71c4-4d63-161a-08dc2ace2f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtdHQN2OMn8IVGY9ex242HErTfzpewsqdBteKlrhRe4XgMb8Z1XTAlDamEDBpoZ1sNd2T/QWg2uibtikxzFXmNlsquVXRFcTmfDI4rDySHPIxoTUVHamMk2jdU2CXwR9NMQjPz4IPWDpgg+x7AQf0leCnviBYrWKOwjouAhO7P0UzIV3CX7Q4yej1jrSJDgdMCLLTAAGD22JZ1Ceh3e9ANdySOIcKIi4zY0ZgvKQEMqNYS1hWzl6TwXGcziYJrYm1nFUVyBA3CZn5U3UPaBwzQLPR3aeKvBvFb8yiAiE+KUnvCWPN6NaC0+ymaaiKawnTyCGknux9mxwiDY/27BYg7NAWYum3e0KLc/VVtH0AjYYRqDsLh870pnFBn8QrqY5TKNuhJlkDZbnQbrUCP2WHLvB5ETssJ9/kxxOTATOWAy7182pHpXle57FFaPqzI7csS+hu4p68ajIP3++GhhTH2NNLn/xX+b02xz9dHR8iDs68o3z0rVQbvPDMRu0CMbdLJQ/pyUdg6Xrmbpu4yXOD/xmiVru+j4qBngfLEMErldMBOT6NxcSxFR9eLznD0bn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82960400001)(38100700002)(31696002)(86362001)(6636002)(316002)(54906003)(110136005)(66556008)(66476007)(66946007)(6486002)(4326008)(8936002)(8676002)(478600001)(2906002)(4744005)(44832011)(5660300002)(83380400001)(53546011)(6506007)(6512007)(6666004)(26005)(2616005)(36756003)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky9vUms0TC9ZWEtsQXNXOFF2VEQzV1Byc0krLzdEUzhiaENGbzNLQm9JQjlr?=
 =?utf-8?B?OWx2R3dKRkhpREJkSGZGcllCZ0p0Y2JVR2xQZVJJdUc5RjZLYlVhekJGdGJG?=
 =?utf-8?B?RlFWSHoxMHdwYU1oWEkvQkw5OGhobW4wOXQ1RHhFY2lFWUEyY0xSdEFUQktG?=
 =?utf-8?B?dG5ySVVmMUV0V0pjem9rUkNaZ2JTMGM3a1FUeGZJeXhUNGhKY1RScVlib3hB?=
 =?utf-8?B?WEFabzV1Sy9GZ3pxdHRjd1ZVcDVWMUNwYkl0ejZVUUV0Q0VobVVnWlAzMEto?=
 =?utf-8?B?RjNEcS9wWXBML05hR2VzVFRlZzAxQW94eVVzTGMzUXF1QW1iT1AxQStDbmJs?=
 =?utf-8?B?R1hwN3dGd3o4Y1RGVWxaMHFycjFRZlc0cHdsS1I5M3QwQ2FOM21HaGdVVitT?=
 =?utf-8?B?WHVpcGdDUWc4eE1JS3NCdU5hMjRCZUZQUWZYdGw2K21mdG1IM25TVmQydGh6?=
 =?utf-8?B?RWF4VmJJQUlaVENqb0V1Zm5PazRiSzRoVDBDclNGUUxILzlQK3h5ZmQyRnox?=
 =?utf-8?B?SWJBb3hxeDdDOHhOZFNuaFFmQXBGcU9iWjVuSlc2ODg4bkhUZ2xNaDFtRUNN?=
 =?utf-8?B?TnNTdGtMUk1aK0dRN0w0cGE1aGFaZWw2MjU2Nkt4NWhjZ3VLVG1SZzdUazdG?=
 =?utf-8?B?ZUhBOW1wYjBZOGpjZFdjS0RSMlJBRTR2dXVFem9MZ3BGUUMxSG13NnlWVmh0?=
 =?utf-8?B?OXRHVnFqekdpNDZjZHFadHR2S0h5ZmhvOUFjL2RYUFViSVd3VC9CKzNEeEJw?=
 =?utf-8?B?d1hwY3NMdXprdUlGbkZoZlN5UDlsL3hTVTdtYlBGUE9ROUVrMFJzeTJKb1c5?=
 =?utf-8?B?ckZlS0VTS1cwYkttWHZmbHFIVDV3RUZhWE9xc0pOcFhhMFN6NzVlZml6RVU4?=
 =?utf-8?B?dVE2MkFPNlVWSWNDKzVjbzFXN2VCNTNqS1ZNbDh5NzkxeWpHKzFvWElyeWJu?=
 =?utf-8?B?ZUlJRkxMUUtidUhQN082MTMwbm5HMm5zdkFFbkxOVHN2TSswWGlhTXVYME5W?=
 =?utf-8?B?d1hYM2kvang5Wm5ZQWRNaFpmY0tBQ0lScEZYb29aU3pOaVNVbkpQc0xkNi9n?=
 =?utf-8?B?SCtUajIwVm5ycENsNW9pN2I4VnBIc0hIQVRJZFVyVWVPSVB2aVRJUDdZMzFa?=
 =?utf-8?B?Tm8vWjBKVEd5TTR2eWN0cFl5eHhtWjRsTTN1ZWpQMzdDcTR4WFNIcDhseUdw?=
 =?utf-8?B?V2hMTWlnS2JISFEzcnNVOWg2WjllTUJtelV0Tk5zRlJhd3NoYnVkdVJ2aUpN?=
 =?utf-8?B?RXkydWRjVE1EVGpmOFdpSFk4QkxuK2ZNYUdkN0lxU0JhSDRvUFhCaVNtRzJL?=
 =?utf-8?B?OHZHQUh4bkJ2SHJzV201dHpqcXorRFB5MmZpMkgzTllFNVc1WHBCYkQxODMv?=
 =?utf-8?B?aTdpSDlPUm5rdU9zZ1hRODBRbzJoMUtWU0ZMYXc5M2pLQWlabDhGdzdqMGph?=
 =?utf-8?B?TjJNbVZJQlF2Mit0QmNGZmliUHJQYWp1bG5tMmo3SjZDbXNoc3ZHOG1XMUZ5?=
 =?utf-8?B?RmFBV3pUU2t2bmw0YS85UVhQOGIveHU4OVFlRVYwSUdjOFhtOWpKd0tEakFF?=
 =?utf-8?B?dGNZSC9LMG4zUWVOaWVkNERERFFaZUV6N2ZqME1waWRXQ0xLR0RKWjd0S3NP?=
 =?utf-8?B?WWxITStEUFU0MWhoaHFTMHBuckhQa2wvRTFkdDBLV3ZESlVEZktSSG1ZMFVI?=
 =?utf-8?B?bVVaeXJhUU1GT0J3MWNYOGsvR3h0cEZjRXpBVXlwT1N0VG9ZTXRDczJwK0FY?=
 =?utf-8?B?K3RkVXorWDNKMnFzeWQwY3F5QjFjVisyaHBnL2VJTTdINEw0UjMxN0NabGRr?=
 =?utf-8?B?UWNSQTVkSkhrTWxQYndwNGIybWlQR25MOGNUWVA4OUpwei9EUVRXaEVYeHBV?=
 =?utf-8?B?R2t4aWpxWklHNDZNM1M1SVlGSWZ3cDkwNms4TE4vd2ZWVGpNUG45NEhOQ3dw?=
 =?utf-8?B?Mmh6b0EyOTgydWp1aE90TE9XaGNnMHVzOThVVnhkbXBBRWYvQUMwbktHenFw?=
 =?utf-8?B?WllmbWxDdy9zdFEvYVRBRGkzcU9sNytweExNMktwdjZHbkRHZVJkNk9ONHg4?=
 =?utf-8?B?ZnBUTGhza3RmblNxYTJKc3VxN3JQOWdmbnlBSnJMSWRVdU5sRHRmRnYvbVRM?=
 =?utf-8?Q?SCm+J0k3iF1PowV57U2FLa94u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9accd3-71c4-4d63-161a-08dc2ace2f69
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 06:53:42.7959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHXbWaGIE9ocrSX4ahKmhkw+wVvXGYeyI2+7GZnJwYk/LKSPJxkBXlOq92ePihU5bmNT3wGgjmPLSN/FHnC3Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7962
X-OriginatorOrg: intel.com

On 09/02/2024 4:33, Jakub Kicinski wrote:
> On Tue,  6 Feb 2024 13:28:18 -0800 Tony Nguyen wrote:
>> From: Sasha Neftin <sasha.neftin@intel.com>
>>
>> PHY_CONTROL register works as defined in the IEEE 802.3 specification
>> (IEEE 802.3-2008 22.2.4.1). Tide up the temporary workaround.
> 
> Any more info on this one?
> What's the user impact?
> What changed (e.g. which FW version fixed it)?

User impact: PHY could be powered down when the link is down (ip link 
set down <device>)

Fix by PHY firmware and deployed via OEM updates (automatically, with 
OEM SW/FW updates). We checked the IEEE behavior and removed w/a.

The PHY vendor no longer works with Intel, but I can say this was fixed 
on a very early silicon step (years ago).

