Return-Path: <netdev+bounces-86334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E21E89E68A
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 02:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7833282E22
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1DCA5F;
	Wed, 10 Apr 2024 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRpfIByx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077B67F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707340; cv=fail; b=d+hLFtEJxMi1G8DPxaKSuwqBP1TJDqX1uYFc5QGl1dGcoB2RQTFmBnWq0NpyK6lL/LCE5bOkw8HrEDbVdo5ZoJOV4oFv0ABvSZFKFiuz1kKTP2oBvAYXdtCtoX1o/o+oaVOEHYct3ZlHauU+N0GzRHwx60pGzZbz67rGKf+AfEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707340; c=relaxed/simple;
	bh=NO0+/8ZpxPo8zscBSxzy08bud84qhXBQiswMHwcEJRQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kPAROspi5Y8vDUHjEDRMQZiYXu5J7Zj3eUPlXkx6fD5YEYg9Zn3UuEUhKb1s78hgV5kjivC7C/rpVW/kDbZHAeNV/C06Ze1XFeKT/R+3WGq+MH1dSK/Pd1NGbKaC6Lg7HHBnKzUhjjsAyswJEBf2dSQH9kYNLqHzYTttnAEJNc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRpfIByx; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712707339; x=1744243339;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NO0+/8ZpxPo8zscBSxzy08bud84qhXBQiswMHwcEJRQ=;
  b=cRpfIByxKjj2MCKT8eAgP9fqv0w9SibVj1oZ3dSYePhF/Hp5NZ3Z9orA
   /WECIxLxkPWWp14UfF4FgC8B6S55ebyROEKo+WIoFvJHQ/RxdLtLjrZvT
   Rq1hXFSaCywzbZbmnRpL3/6UWxjWu6NqfeHOYPj2s4JntbtIGGsf9rD/6
   sUgp4JsKFOyuwacaUjLyYuXVpx+v2nhZFZFF3fecZDQr0v9174Vi1bPEz
   TG1aHW1r5QWbF1ORxjfr7+SqJHk+IqkwNivk1Kk4/UNF0KWb5jDZT3+18
   mFIjkxsPIltKxy6onic7W4YNDReyWQETigktjw9wxofltZQJSoHhAr1mq
   g==;
X-CSE-ConnectionGUID: Raxljp8ZQueJ19eoYmzAmA==
X-CSE-MsgGUID: RJRlEj1mRbKu46DoMnD6TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18616231"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18616231"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:02:18 -0700
X-CSE-ConnectionGUID: TMuwAhjETGui6+sk5s8OgQ==
X-CSE-MsgGUID: OIIE9DV0QKeUKCHGar5dwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24992897"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 17:02:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:02:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 17:02:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 17:02:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elqMoDwAZvJ0cNDOlCxBNG//tspkMT8GAi7LCJcfj+ZuSPGhk4XlO8hRr4tHfrSMLdj9o31krH0e170z1SplEL8Umc+xJ05SIm0FYzOsA0RP8A9D+kpE+KbyGtowjTE3JFSr42Tckcvrej+WrQ8SA8522tjgYZDeoHJD0cv3bqPQKWVbEavOGCFPuwHrc3EK2vYNiJ6LSNDZb373qE+qeUGOSs5aE3EMc6OsTnIPEp7xk6UFiC4v9kw9odH8XGEn2eVyFez0Ol3KfvGnlWmtmzU30o4I2UIN14SyIl5pnevILEi/gGFRkyF/6jA1HQzyWUqYXBZ9FKU4Txr7ElbIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTbTmzZqkLBjAnR3d3RhIsQjFMdzPfiBtwurw58I/4Y=;
 b=cIClVqVMc5iarqtbj9CgLpDkC6K9KRBij3YikwTRAKj3N5lEmiCAjXq0+QbWIOYhfyOnRn/qgQ6FwG89u+xt6BJBd2+oTFf54qtlVbwMxPisPMcmIz06jo72nbSQKjJUNJgqwmbv4pTtZ0NigzjDxVhsJzJPdNV7WXyHdP/JpHbHy2kTmvXwYCO6r9u3FTDeXePrBaUpeoUrjpYw+uLklJ+6YOV7eQQXkhWJA6+zHzl21ss/lN4F3xu96SVpHOHk65rVbVh2d9l3hI8zu4aNfsGHvFVvlxFcB0a8tgeZFrVKvgxMPatJjXU1fSENUvREcBwoCn519BKif2L4RjaROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6860.namprd11.prod.outlook.com (2603:10b6:510:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 00:02:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 00:02:14 +0000
Message-ID: <f2b4b62d-09fa-478b-b40b-4b768cc6b2d6@intel.com>
Date: Tue, 9 Apr 2024 17:02:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] mlxsw: spectrum_ethtool: Add support for 100Gb/s
 per lane link modes
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, <mlxsw@nvidia.com>
References: <1d77830f6abcc4f0d57a7f845e5a6d97a75a434b.1712667750.git.petrm@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <1d77830f6abcc4f0d57a7f845e5a6d97a75a434b.1712667750.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6860:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8D2FmczAA67yMBq6F6TjHEbMruF/1Ov7KGMKaiy8S6nyBwxZW7mGLsRsKUn0yIjP0ZwRj69kMvNHToYs9euPe/SXwW/lo00sRYUZCdoQxPodP0LsHWgdQIiZ3OmuAdmiWZy9kFQZIO0svDL0IsIvCG50o76MBlyH5JjZsuH6PhspNaaXtqJCpx25ugoyI3BAPumGPE+wn8AvI0VtVBVBQUIDrqMuX/7EOBshwC3/x0igWUp0/689oQcJuAI0J+dl3oxVdjm9MzTSABZ9Mey1rbUa7zXDREyF0qVYveOg1/IvNvY4NaOEdB3sKVv1hiG8sXbZAs5GGYMeQ7Cdxup+tWcKIciYKeHt9NFHvZRH8nfZv7UlAz0a+CC0AlvFTo6SfqoAeQ9aL5mOU83celNNVcQPZ1T2cwiPw32wz8i2XQnneMepplza9fJU8O8V2QDMmibyLkHUp43SWY2/yn+yKi1jWtLcPBQYORVARIviU1i18JsOpROsnF/k0qFcxXgdmtruJwvGXkMeCqjML9z4/mKdY7tcVwQ4rxt9aJ7L48FP1c+YKoB02cW1RJf78INkF/4yY3a2emO6i61hnqTEaU4xfZvfUyMY/5IVQwBtdcUJ5/G0PW8Jg1nZIO6ClLrZDFDA/0IArbo9VuNwtkdv+sbFCCcZD93HJSNLUMo/8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjJzbU5aYkJ5ZFdXcGhqSUFpTnZ2QTUycnh4OHFCZHJaRkpSVlZna0lkbXpj?=
 =?utf-8?B?dUxOK3FQNmp2Nmd3NVQ1b3ZiN3lpUlZxVjRqUnR0eUNHdjdJSEtJSk1IOS9G?=
 =?utf-8?B?bkZYTEMwa01pY282VTB2eGJOZU5UVWRteXhISm5BeXRUL3VXNUwwWmxUTnp3?=
 =?utf-8?B?K0d3endCVGdoOXByY09PaVBmaUJRcjJIRU1WUkFjeDRNQzZTSTJPK1pKNWQ3?=
 =?utf-8?B?c1ErY3Uyd0ZaNkM3bjcvTEVqZHZncHEyWGdHaVdGRHEvTG9ab0VKZmxPNHhD?=
 =?utf-8?B?SkdBdE1wWHRGQ2dVQ25xb0EvL09zRCsvcDc5VU1QMVhLdGhRNG82WnNCenhY?=
 =?utf-8?B?MHJHQ003YnRZc3BYS1A4bmg0eFlrTzNxb0NxclUzdFBISGhRdGYvSGxVcDdQ?=
 =?utf-8?B?ZG90K0QydGZSb0hRcUl4WHN1NlAyTEphWFZ0ajkxOVZEL1ViQndXSzdNOE93?=
 =?utf-8?B?SXFKczdtWnJYakxpL1JQd0c2M0NOUzZvallDUFVWaFRYcWpLcU5TWW4xZFJa?=
 =?utf-8?B?MTZoWUVHZE5YaGIvemswR0ltL0Q0eStzMGRVSDJoWXRDSHQweG9NcUU4Tkg0?=
 =?utf-8?B?SHNmNjI1LzZCVXd1eUlGY3FvUlNGbDgwSGkvdVNSS09TRTA3VEVkWTA4a1pY?=
 =?utf-8?B?N1M1SU0zUkFzSHFoYnNyWm9oZzd0S3NVeitKV2d1d01pblo5NWpoMEJXdkhu?=
 =?utf-8?B?WWJXYW84R3V6Rnl2S2g1eVNFak9zR3pSL2NsWlprN3dYMHp1WkZ5dXlSbjVW?=
 =?utf-8?B?TzlnZ3hDOGk3b1l5U25KSk1tTmszcXVCWUhINTZSYWtIRXJQK0R2QW1xZzRV?=
 =?utf-8?B?TXNMWS9mYkxpRlhHdzhJUHZLT0NCK1pQZ3VZelQ0dy9ScE1wRERHeE9ZVEVh?=
 =?utf-8?B?aU1QaE5Qc0RPWmM3KzdTSmMrd3dWbDhwUXVhWXBhTnBKd3ZYelBKVFRrUUQ4?=
 =?utf-8?B?TkxWVEtDMERhTWdmUWsxMTFVd1VBUEJnbjlDVUxkWDNWZFdtZHV1RHorOXNv?=
 =?utf-8?B?RFUxVWxZK0R2NFVFdnJiQWtmR3grdHhJQkQyclNQcGtPRFVtczhRQjAvZVcz?=
 =?utf-8?B?a1hCR1VmRi9BTFVlcWNwenBmSXNLclMxY2ZGTUpIL1VCQjM2M2tWOVdSVUhB?=
 =?utf-8?B?U0llTHA3UWlGNnJwYTRjWXlaOEdKaCtSV0RLWjljTisrQk1oTGt3MmVWeExk?=
 =?utf-8?B?L0hlNHlvN0hmaGNrVEIrMUE3dUJMQjFZRHY2MzcwNVVZNHFJb2NOUzF1VjBh?=
 =?utf-8?B?d0dMSVRxcmVobjlRVDdUNHdKS25KRC9BaCtsZmhoVlhmbmpGZ1JyQ3EyZUtz?=
 =?utf-8?B?eUFYS3dNWUhzRnN0dWs3TmsyUzBhWk5NMUI0cDhCaS8yYTVTQkJSTkM2U3My?=
 =?utf-8?B?bXlHWVNYVzZxaHdyY0h5VVZzUkhEOHU5RmVYaTcrcS9uVDh1SkZiKzFjc09V?=
 =?utf-8?B?Qlc4RWF0aTlxNGdqL0VFREc1MGgwaXorSkhNQTZUck0vVFA3TndLeTA3VHA3?=
 =?utf-8?B?V2hVWW1ydWlWRXdaZHU0bUpBdkZKQTFCUU5JNzdyY2VlSlZHUkcxY21ZMkQr?=
 =?utf-8?B?NHBkZVhMVlJ4REpNZHltd0xIQ1JqeWJqWDF3YnFMcmt4RjRETlMzdVNJNVpK?=
 =?utf-8?B?SE5SaGh2YkRkNVRzQmNHREVOcFlvS0FIUm9XclY3QmNSV2pmWndXZG5VMVQ0?=
 =?utf-8?B?V3NwSWhqNEk2cjYrTGU1MWk0cXF4NVZiY0ZVZ0tZQisydU10ZXc2eWxVR0Rp?=
 =?utf-8?B?MzdwZ3NGUkQ2c2trbnZDQ0tDNjlYTFJRdFFqRXNMNUJKeURlSTJLRjlKRzJM?=
 =?utf-8?B?ZDlBRTFReDhLcENkL3VWTzE5dzRxdkVzQnpuSEVDcFI3ODNXSnBwSXMyQlVa?=
 =?utf-8?B?QzM5VmdtUUtxZjNBQzVzRzd3UmU2V2xiYks3ekpQUnlBdS9wMWVhT2ZaQ0JV?=
 =?utf-8?B?a0l1V3p1VmpHdEhsOUhCeC9IeEZWTmRsRWR6OWEydDYzSWdJdFQ0WEFzVWFq?=
 =?utf-8?B?bUszME5EZ3Brb1ZHTTdKWjVEZ1pTMDRGZDRpVmpnUElha3NQcGIzbEdlaGZ1?=
 =?utf-8?B?SmwvdkN2bE05YjBvRTJYbm5HOGlocG4rZ0Y0MFA0UFhVaXBRVjdBK2ZZdlVU?=
 =?utf-8?B?bTRQTkVXUUV5aFpOWDcwUlg3Q1FlM085YVFGY2o3MXlqWDJ2aXlpRDhqWHps?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1045ab67-fc18-43c7-6287-08dc58f17aa7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 00:02:14.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++CH+8L9JrOvcAnUCA4UKbWarwUnB4h0qSUYfGAikNhzXS7F57ykpszcnAKKxkgALcSOLvjdFP22MmfaQsNyqOlRsofEgpf9HOc7chkKKU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6860
X-OriginatorOrg: intel.com



On 4/9/2024 6:22 AM, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The Spectrum-4 ASIC supports 100Gb/s per lane link modes, but the only
> one currently supported by the driver is 800Gb/s over eight lanes.
> 
> Add support for 100Gb/s over one lane, 200Gb/s over two lanes and
> 400Gb/s over four lanes.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

