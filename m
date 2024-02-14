Return-Path: <netdev+bounces-71854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA645855586
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E801C20A42
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B23113F01E;
	Wed, 14 Feb 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwxOYDfY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232E13EFE3
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948362; cv=fail; b=ETzhk08SGFtPpH0s3VKhLDVrjExzhhzATQ+6/S/B7KMhMLEbuBSYuLkefMhY2JgwcxiulUg7GMJO7wyxb62OhK2J9dnpmZMCHBiWVk9SalPq0r43m4wKykG0wxTGnimKt2+K0ZXo1M0RGwbhcpm7rLOm3AQF0Pf6Aux9Ql4/81I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948362; c=relaxed/simple;
	bh=7s8SYE8sZhtAmI9TPoi4MLEDNY4LhNfawZZDvk4n1Fg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DwDRmzA/DlFN64RXLnbs8Shp8mY0eimlX8q2jTK+lkapUmM+rMP+Gv/L4L5UsduyuroFffehkhSLtir/XmVrK003ppDFMUAxYeE0Q89Fkf5FAgrOwoxLj8Grdf5dKJVEfw0jwiliUoZdrXXQk2QJPsUgJttsO5IyWfTbRkeYILM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwxOYDfY; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707948360; x=1739484360;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7s8SYE8sZhtAmI9TPoi4MLEDNY4LhNfawZZDvk4n1Fg=;
  b=gwxOYDfYi6xRC8+iwD/bPyt8NnuHfWR7FF/GcxU20S3OL3k135DjrS+1
   AHSPcSmpIQS8iwL2623QD8YrrbTXLKgPidsBmHq01FzOed9xODbRSfeqJ
   kVWwOBESJcJxzDmamxKqAW6qisTKCIaJ7bihR1IbeIRmlW5xREdgf9A8K
   PuWrHkqdMKla3WIabdbySL5iR1bL8u4TVDTCWjDxEwGsvfxMAQxF0bVmk
   MU4BIFB4F1joNjrio8L+EK6Cf4D1w7RrJctey7vtfmm595v9ARIj+thu3
   iqIo+Gzka6EMsnqP9Qd3LVligOYqq7mbKU4Da74tLPRFV9OLrBgHlav+Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1873212"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1873212"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3617948"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 14:06:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:05:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:05:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 14:05:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 14:05:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efso7IR5e7NZZM+1PRBCCQfjTkKrO4GzirRGW65ckISEJ4vhpOX0Zjqb/dMVk9nT/fKyA6zk6dsC/7TDXKAWUvOvTwCwL2qvSarXakxeuyxd/xqW2YpPox0VRzgPKUbeCCpfjz8auX+dL6rR1kl7fzGOjI/2pn0wS+lc3VUnHKDFbnQcAPtsNxWf4sQ7hG5CAAMJMmpia61H1A4R87R1gZVY+q+V/vU/ezFtkEaT10ZEQ02v3H7RFiNMcDhc3u4Hl+K1rJGPGtuLgeMXbZFZ99vSfK6CgLWmDBOhA/ACEgyR4miCbsV+I1EZ0vbCr6z+Ir0HPR/IoQ6JEwZvi0yqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oq88sbkNXhCcKlhZ+voZEYcH+LLFFI92xlqLVtyhY3k=;
 b=foZmUmOFlJo5yZRlrSG/4mQk5VNNteGiwMbLlaFPaRM7pvNdMJalrmfMPbCzlpet+uUE7I6DI/kcuj0EWOXlilYNqmBpC1F3MTqzwImU5i0HVjtUUYTD+2ry1OlbashysnfqT6mJ1wR7HCQr1txIxBCwTL5Ai4TJvmoN/IY1gDGsO4pevOpPP5LPKU7KE242eUIDnYER1tdSJDbr2w7F9EQkEbl6HWoBkhTclFeRuHitK17aF47HKLtnsiVwiuU+y3P69O83TZTEZPUAd9VPevQTWTzBgdP0QRjM1FUVkguefYZJkORIbYrMZZMONuNjM9g0Lp2SM7xE8ycyRsSICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 22:05:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 22:05:56 +0000
Message-ID: <d248cbf0-c255-48bd-b610-5da56f28943b@intel.com>
Date: Wed, 14 Feb 2024 14:05:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 8/9] ionic: add ndo_xdp_xmit
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
 <20240214175909.68802-9-shannon.nelson@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214175909.68802-9-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa78f89-b101-4f37-9279-08dc2da91e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ooAqXNa38D0Ox7x24NsDbvu4b9ep3WsL598nNuwFU+fIHSqugnlwJapSQsd2ZI5VBtoLZT+X/FMY1YROSpnLnBXK34GsS+5tMcwBLC0OsTHnMqD3k+6FJrxtDhBlfNluCLDBFTRsRaBKzPFmtVH1MPsk7IgczUighAsGCHzg9cwJd7V/aUFyhVUEVfdGks8JB17LjPqdpDojJN6GpKFkJha1fBQaYLMCpQv+NknNk1DqrxTmzFqXg/Oy2g8IQ2urmWnut3q42uEZDQAuGQhJIaME7a1+Z6Q1rB5r63uG2AVbQxyKiXmvddqNLr/VMAqfy/F/+Eef9O4p3s0QeJdFGYJJ8OfisDUDO2uRGszxevuQT2tMjQyCfEUDE2MI/dwhRdJgYTOK2YPEc8odTuujxVqI6ZD8DLc8l6nMMWX4fpH8e488UlqGYZpV8wUexTNY6sL6vudWlsEg6DhGcBN26wU2EhsEaDXqk7xAXugCZEsCFS5/XsAAGAM1DjXjymCSDv9aAsMUMW1DuqwyeD/iAn7UH31g2yrt8qpoofAEk2xt/UZPI23O0kj9tXJoIr9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(376002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(2616005)(82960400001)(41300700001)(38100700002)(4326008)(4744005)(8676002)(5660300002)(8936002)(66556008)(66476007)(66946007)(2906002)(6486002)(6512007)(478600001)(6506007)(316002)(53546011)(36756003)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjJRa20wM3NTNWFMaFZ2SFBhU0RxazM5VVJZb1RTU3ZXekl5aVd5VG9WRTUy?=
 =?utf-8?B?My9UQ0RIMTlSbW03bWw4eUlPcVdqZUVmSDViZUNpQ3I4cjlCMjNyU0s2cjNP?=
 =?utf-8?B?d3YyNkZWbGpKdHdiSVg3c2F4QjZ1cXpON08rWEhpZ2lYUVduV0tFVmNWZndk?=
 =?utf-8?B?RWdCSEs3T3ZXbjJRWDNMYk1JYzU2eGtXTTBzTmJUZlVzZzc2SnprWWlTaFlW?=
 =?utf-8?B?MmtYOEw1ZE9QV0RjZ2JXblJHdjU5S1BaY1ZpZm9rZm15bExqSS9uQVBySSsy?=
 =?utf-8?B?SUZLbldMUHgyZS85dVI4YkwwY2tWeCszUTYzTFhuN0hnSFA5Z2ZvWjIwUU9y?=
 =?utf-8?B?ellSdWk4Z0IvdHFqNkpZVGp1VXJ6aUtIcWtTdThxYS80NGxEbXFqVityMTBC?=
 =?utf-8?B?WlBSYlE4NnZnc1E2ZXNUdFBxM1ZESzZ3YythdHNjNW0zSU51UEVuYm03VXA1?=
 =?utf-8?B?U2p4eUtrUzNZVC9LRmliSXZ4SXdyaTh2MVRhR1g4VmRBYmN5NWQ4Zk1mL05K?=
 =?utf-8?B?RFlLM0NUQmEzNWhEZU1td0V6TlZBNW5zN3oxSGVSTWpvY21vOEdmenh6UTBH?=
 =?utf-8?B?OC9UYiszME9ncWhta1pFNDVqMjJza2QvdnNtZFJPRG9wRTdRL3c3MCs3QTJM?=
 =?utf-8?B?YkdGT0o3aW95em8yYlp2TGtJdDRuR25BcVFSdHMxUUVIRGQ1aUxJYXhrOWZS?=
 =?utf-8?B?VEtsVjVqOE92QndMcDZpd1JNbjdlSXlwWXIwN1JoTnRHNzJqT0pvdHRzblY0?=
 =?utf-8?B?QjF0R2lCV3JuQUEraC9HSWxSRWhaNzdyWDR2QmZMbTlJVVNML0VrRFpvR0pD?=
 =?utf-8?B?SDZMR3NFU25rYmduMFpxYzZITHpEVlIwTkNENTlxdngwN1B0bnBTVmx6NHF3?=
 =?utf-8?B?M1VxTGFzNVcrbi9IdCtGNUpJWDcrVTN5d01IUHFNOEE3OGdhRkN1UEplUTVn?=
 =?utf-8?B?SENEdjlRMFA0Zmw1eThMbHFza3NVNWpRQkQ3QmNPUGJUajlkV2YvVjdKek9r?=
 =?utf-8?B?V2RqeTh6c1RKVGU2VW1mcDVYdU0wdGlzWTFiclEveXlLeWoySzg2SGIrUGE2?=
 =?utf-8?B?THcxcUloMk02UW5oTFA4NG5tMU52c3g5akpZSG5XWDlhcXpOdjVRcEo1NEc4?=
 =?utf-8?B?bFJPQm9MS2U5MkdhMnF1aXlnUkVFM2xaZ0NCcjVBN3VsQzV6bEVDenJZcCtK?=
 =?utf-8?B?TG1JZDdWc2dJNlNJRzFaZEpUY3BFdEhqNzd3QWxwb0ZweXhqMnBMQ1Q3aUk3?=
 =?utf-8?B?Z0dxQWo3REdZZjZVRGhGZmFPRkQvSG9zcVI1RjRmOHUwMGRmeTBMeFV5RGxj?=
 =?utf-8?B?dGNsMVRQS1ZmUUxwekRKczc4SkJEaEFTNVlzTVd0Q3FqdjNhSlg1VXJlUXpD?=
 =?utf-8?B?a2doNW55K1RvbDF5cHZhUTNCeFdUZlNjK3YwRmFwbTV2QmEvODljWWw5dTl2?=
 =?utf-8?B?S0lFMW0yZ21zdlEvUGk0SjZaTTNhYnpqYnZVYURTQzYzckc0NStydklwS2VP?=
 =?utf-8?B?Wks3MWVtb0NlQnBaTjNiUXJWRGJTaThlYzJvNEVTNzNpSEVzMTRpZDVKOTBL?=
 =?utf-8?B?d1E5NGppbEtKenUrZ3NocTcvY0hJNFg3bEExYjRkSjNJTmVGaHJXMFNlKzJO?=
 =?utf-8?B?aXRDeVV1NEYrNHFkZ2ZiZzJ0UlN6VFROVHJ5M0JVajFhTGVIcDVSaThCVXU4?=
 =?utf-8?B?QXkyb0JjRzBlSERDczBRSUY0amN0TXp2TzJEY0s0dkltOThteHIyaGxzOVJ6?=
 =?utf-8?B?Z2FCYkw5N3Q4MGpqU0FsU0lEa0JQWkNXdXBXNDV6MWhmTStoNHZYWDZmVFRv?=
 =?utf-8?B?KzBEQjVUdFdEZERnMXZHUklPcmFUOXpPM3dTdnJabjE5Nnk5Zm9ZQlkxRHpV?=
 =?utf-8?B?alR3U0xuMWpPYmtoVmlQMndFSFFnenZ0N0NpZGJKUHUrV010dlpZR2lTSFNa?=
 =?utf-8?B?TFFBSnBUenhtbS9aZlI4NW5HM0lNVDh2c1BIMlo0a0FOM0Y3QWYzOFd2R3VU?=
 =?utf-8?B?WGVXMFpBbUFrRTNwSXFONDhGeDR2dVFGUzJzT3Q4K1lzaE9nbHZVRU1rYjZq?=
 =?utf-8?B?UkZ4QnNrWVJSOUJWc2FRTHVYbUpKblZiVldCOHdMazUrS0krNUJ3bGtIQ1lh?=
 =?utf-8?B?eS84NzBjMXpNM0I5VEhteFh1dm1jOVpmZEd4V0xiUlJuM3RMMnlkbzBlbGhR?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa78f89-b101-4f37-9279-08dc2da91e64
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:05:56.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhyXWhrSMaJd0C28n1RTu7+Dw5BQn5mr/VszCgMnOsDsAsSeWfYlqRypmuZaEwOWdZjKF00WgO7tsvDKP1YnE7mXs3vOZiz1lQBrwV68e28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com



On 2/14/2024 9:59 AM, Shannon Nelson wrote:
> When our ndo_xdp_xmit is called we mark the buffer with
> XDP_REDIRECT so we know to return it to the XDP stack for
> cleaning.
> 
> Co-developed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

