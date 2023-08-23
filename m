Return-Path: <netdev+bounces-30108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0B7860AC
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF03E1C20D01
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989A1FB2A;
	Wed, 23 Aug 2023 19:34:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D182156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:34:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A43E5F;
	Wed, 23 Aug 2023 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819264; x=1724355264;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+tX4dy7GDeki9xrW+UzqiqaqxvRYlgnSapejIW0hJoI=;
  b=lmQCykezSAb5cuc09VlhtSijKfSuzFym8n7itsj9kSS/p/W9fQ4FvI3x
   ug66t59vhg6Th72kZnzA0aBxbCM+uupcomAQRVs+tQbVKR82Qj6iICzUE
   nHR5XXkFM2dzuO3UOqViFbw2ZK50e8Hk30Ir5W5M0PQD39u11h5WNT7h5
   9g2Ygr+TsiM+qz67uzqOOSZYtsfe80i2rI2LoS10ybWds7RI7RphD6l8L
   oFegxCzQPu6b8YcwADA6WeF+RiwX5A++TTgShb6JpdBv7AztecFieusaA
   U6FkUtJkb6fbrIxd03lZ47bQ2oV+C/bSbI6VIe3Wkr61/mIdYxEfTJGkx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="371668845"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="371668845"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="1067567957"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="1067567957"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2023 12:34:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:34:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:34:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:34:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNLBBspB0u6fs3pUJJ5L7aYvu/pSDPmckOlRR1eqxPlKBqPVvWkpRF9BzKhSNtJ8aVvFt5HgaCYA3i8Vd+vlOnHd7ArkR/7AfG87QxL7u2+gHOcv82wf3DBQ06Z244SycJYULMiCgbTIg/B2UfvbX8JuabAARyrKJY75OyZFBTBr6otLz++dLhzqyO6BsUT31g/kjLZaGWzoEzUKiU8E53fOT/LGGRAMxxHzENGzUYXc2S1L/d3k4UVrqTOZ9FtcHwLYsrNi+C6bgpMDaLdxa2yXUb7p6b+UGxX/WjZ0mNujteoO1vIo0uqzG0wwglsejt7t16DppjZB08XmY/NZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwOHvrC7mhJXHTeqKhwlbO8XSmdv7KESPDdvH+RGM68=;
 b=CjBDtHC8ZAJbMybHe7W4fvznNEngNRMWy2NtLtQgX4aRwn+g4QYaZyjoWx1UxP19yXi3TFY6ylRC0jQJ0Ny1phw2UyiqzSoLRPaH5o76KBo+FUzZ7OBwplo64zbqW5AKrx0ean+HaSkMEKyB78CUSdxh5A+ILrE/Of+0m+GFdBWLDGI4uBbkCFZeCesZWirWQlduTCIghofERQHK/hGIdMcH1hs13lcViT8CVXby4oY+2ahFR2TjOpyp9fhNq+ckxTciR9WtPWJzje+mo9EhHEOthYnRBw/eFKPatV4/+JCtGW3QJuS9INdW7WwdM0jElcmNTDjDjmtARuPtOw+o8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7173.namprd11.prod.outlook.com (2603:10b6:208:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 19:34:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:34:21 +0000
Message-ID: <976b1b8e-39be-1c45-ee6b-b66c94e0db98@intel.com>
Date: Wed, 23 Aug 2023 12:34:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 03/12] doc/netlink: Update genetlink-legacy
 documentation
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-4-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-4-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:303:8f::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 7088f820-6729-49b0-2ee7-08dba40ff2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LP1icxw0ieOBqWrlHgs3EtQz0kL0nu42jKBxl3fcYJjby1S0e8cTR6cbudjJZkIhfB2u+zHbOpyR1aW8LTm9qd/BIemxW4MqO7FAt4vzvq8bsvvnaWhjGg0d7Sfg3qJ4Bofl6kQpjjBAG+byGSO+koQU93AL/C60yfYXDnIZUVk3T7R6BI6m5USAvFtlwmed2r0YxOuqFBu4iXpcNVDR6LKFeZrNC9S9o2tBYCy9SMAsGDffedap5c3eIMJIdmizD3kUyaztFO1215x58kMlBvYxNLcANG0wp5ZGOAhK+IB06KSi8Nx9GV8bZ+3z0r6gD/PFI9BofpVdONO5Qvg6nlc8ZoD/Ohr1er00MPi9w7IznSvGRS/+jer8v1VbGjhyQCCPgu/zaZEmHsUZIsTNOyAtESiSIAgObf/B89LJpHLd2nlgWJAYdIPQUUzKLA4mJhdtruK3erXaeDCeafsUsyjZ0bmnRIBog1Djtu2zZ+n/96fDuTF/2KP4w2doVwNKaFd6SHVxQjf2bDurk/QkKnj+j8b08fmaoCHfGlAmPcsBFgBRQSFZ4ZPPDd/SSZN6Q0AuoVXlK2gfwSd1AHWP3zaOSdlRmUYqy9ydrr/mGU53urA3SySb9qv5Hzvs41kK5jB+HlznQLNxSPS3+B9eVQv+xaEhYngfXpy8frJ2qI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(2616005)(6506007)(6486002)(316002)(6636002)(53546011)(8936002)(8676002)(4326008)(110136005)(66556008)(66946007)(66476007)(6512007)(41300700001)(26005)(7416002)(5660300002)(6666004)(478600001)(31686004)(83380400001)(36756003)(31696002)(558084003)(86362001)(82960400001)(2906002)(921005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEVlaENpalFhMW5GQnNRdzJGYUovNEJiVC9McktZUFphTFprOTFLTmx0a2h2?=
 =?utf-8?B?bHFNV3c5ald0TTNDaFE3emFrNldtcXB0L0NtY01pWld0Zi9IYy90Zzk2M0hD?=
 =?utf-8?B?Rm9nd1hVWlNrKzNFSjZ5VHlBbjZUNGpJVFNBeWljOS9BWUl4UnE0aUdSM2hM?=
 =?utf-8?B?S20xUmI1dG0zTHZLaGNXVmJ4a0FGN2x2MXY3QmlRVzZtenF0NExQUloxMzcx?=
 =?utf-8?B?YUxrVVJxOTBWeVJHdWhHRGlBVG5ielZlK291SWdkUGNJS1ZNZDRURnF4ZmdG?=
 =?utf-8?B?cCt0SDBvNk5zTnJaQVBFNG9ReVduQW41WnRrTTdXbEdIU08xV0llOUN6aDly?=
 =?utf-8?B?cCtkSXlmTklBZzRJcldKblBYOTl5RkMxM0FhV1Nkdjh3MEo0TWpnS0IwU291?=
 =?utf-8?B?dEdpQU9VSTFEZVhsZ1NkVFdxNUk2bUFBcFF3TStwZXJrd2FDVmNzSUQ0WFho?=
 =?utf-8?B?Y0ZXU1hrNmpUclQ4dlBhV3pMT213aTcwQ2lNSldWSHFONDlmbFBPZmJKZUlz?=
 =?utf-8?B?SHJjQkFrOVBDNkNRZXlPNzdFRVllT1FZQitMNG93a3NGTUNIVmY2VzdIQ1ZS?=
 =?utf-8?B?VVV0eTZwSTRkUlg3L2RLcHltWXBXVjRZc0M2MUNDakIvM0VYN0hSL2MwOEJM?=
 =?utf-8?B?N2pXVWtTRXN3YjhvVHZQcEZaYnhOWlEwa1drbWdPYms2UTlPajljdktRbGFt?=
 =?utf-8?B?dCtiVVZuaXBOaVZOQjE3TFIvUG9PQWRvQUVGV0JNN1BYNFpCKzRBS1U4U0RH?=
 =?utf-8?B?cURTZERhY2VpNEhlcW5DdmIvbGFHWXd3bnpKRERlQmdacXZsMjBvUnBDVjZr?=
 =?utf-8?B?Wi83dWorVGlRSXluY1JvTndDc1puZHhpQkxicmlwWVJ5d2g1M3k5TkRhaGwr?=
 =?utf-8?B?aGp1WVNrYlZtcjdVL2xxNGpmRXFEaU1jRU9ycUh5QXdMTTlkVi9aTDNhaHFu?=
 =?utf-8?B?MmlrNS9iVGRzKzJXOS8xTXNoSmRwQUhIeDBmeTMvTXFucTh5VFVaazFWblRp?=
 =?utf-8?B?ZU4vZmpGeVI5NHc0RTN6WGNGNi9vdzFpZlc3Z3VhaXlCbHBrOUh6eGJTOHVJ?=
 =?utf-8?B?RmVZdVRBbWs2Si9tVEQrdEgveW85RjFVa01hNjZObmkwdEd5bEM5SGR0OHVC?=
 =?utf-8?B?dFM4UENkTlJLVzBwL0RsbUN0MnE4VG9NeWRhQjlOTDlDQ2I5dkRuMWhaUUlq?=
 =?utf-8?B?dm11OEFQOFBPZ3JvU1grMDR3T3lhb3BYb1lXNVR1eDc5QlJlczQ3OEJVZS9k?=
 =?utf-8?B?bkRDa3IyTmVCSVUwUFRaVmRvSEgzRDdMQkJ0M01vOFo2RkZleGRmZStSaTkx?=
 =?utf-8?B?WFppdlpQaVN6NnRHaC9rZm0zN3pWNTJNdnFCUG5GcG93ZEZQUW5SQmpXd1hF?=
 =?utf-8?B?UmYxdVRURDh1OUUrQUxNY2dmcU1vMERGM0REUEgyOGhLRjBWc2xuYWMrTDY3?=
 =?utf-8?B?bUNCT1lHVkZrRjBTWWc1d1QxenhoM3VhTFJIYWhrUWltN3pLcXVlK0pCYkFL?=
 =?utf-8?B?b00rbjk2TFJ0NksyUVZXY0JlQU0yOG9NTnh5bTJlS3Btc0gzalJZamIvakRn?=
 =?utf-8?B?QnUycStVQkc2eWtqQ1NJWDRianVwQW9EaVkrVlBoNkRhYXFqLzJPbnR1SFZw?=
 =?utf-8?B?TWlvc2RyRE9xcWc5dm1SU0VXQURicDYxZUczVXZhRm93c25BUS9QQTN2eTQy?=
 =?utf-8?B?VTQ1MnE1bmNQZHVhTDVESnZOb3g1NGxQeEFrTC93U2d6eTNoWFllWFRwQkpr?=
 =?utf-8?B?cEhqU0M2SkVLUGFWbDMzeFRDbGRPNTFOUGdpMkxzbmNrRDdGSjdUNGNBckp2?=
 =?utf-8?B?MzFwOXE4YUU4R2Mwd1Jxa0VUVVNpczE5YjJ3TCtIejBSeFNlQjdrNkgxTjJJ?=
 =?utf-8?B?cG52V1JnSE91SXRTekhkdUxQdlNUTlZQM2pLcEJFdlNYTUxHVmRsTFBIaEtZ?=
 =?utf-8?B?cEQ2WkgzR0krZEZCZVlLQUEyOUY3RWloTGQ1NVpXMzZNSGd6ZXpyaVg5UHBC?=
 =?utf-8?B?eU9PUjVnSHpSb3d0R0o0U2QwOUV2K1JPZ2RMM1VMMFdjdEg3U3BEMTg3SDQ0?=
 =?utf-8?B?ODk3ZUtZOTZlSktmNVhQM2dqUlFRb3UwUitWcjg4MXg3TFVkc1k5Qk1uV0xP?=
 =?utf-8?B?UnJBa2x3S21pTXl0YXpPZXBuWUFWN2hGQ080d280allHQ0poTjNVU1BCdmJm?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7088f820-6729-49b0-2ee7-08dba40ff2d9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:34:20.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjvZ7QC83fTu2e/NKXDf7FRkYn5+m3x8L13tDoqKXX8gPQ19ukutvEwvyTgd9RHjgYXl6QcMbbdF+yquMPLiPxhMmzLe7iAyqjZeD139CeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:41 AM, Donald Hunter wrote:
> Add documentation for recently added genetlink-legacy schema attributes.
> Remove statements about 'work in progress' and 'todo'.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

