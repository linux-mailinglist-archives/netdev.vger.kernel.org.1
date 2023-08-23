Return-Path: <netdev+bounces-30107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3A27860A6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9582C2812EE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B8B1FB28;
	Wed, 23 Aug 2023 19:33:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50269156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:33:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026A2E5E;
	Wed, 23 Aug 2023 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819177; x=1724355177;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZYJANV2Ozg/+q4iZI5h0HC5wtu8s7xm+fAOnC7G8hM8=;
  b=cDJzUY66MMWAuhMq6bal6ZaNtF6nH1w/qVTQ5831n7oYECq4mcLPAqYf
   5T132Kwcj1V57avPjNvrNbQ+1e38EPJCiSuJEANZn+9BS1r93/VsIlx0S
   +dX1pjBXaeobGAKnLMkZ3yj/FT1gaN8QWeC1H+rJjj3n8wsKZn/Lb/955
   Uvu/3doyySxsaha6xfdII2TqYakUjGc9qyg7oznkxWC6mWYiEH1q5q+Ho
   siOgopM1Qo8NCMqETArSmx1aMEKLFzBNwnMYGImDjG72e5mk9ldkQlDf/
   xZQggt1v3SK/YhDT4dT4YGW20ShxKCIizjHpthtX9x8NtwaeTmMzAGIda
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="374230401"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374230401"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="730331954"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="730331954"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 23 Aug 2023 12:32:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:32:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:32:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:32:55 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:32:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRsMXrkfmGnPXZ9ZmUCbuKKc2ZPjQVHrSwFbwT/oRK5llL2xFvBUUUK+BGLxg9aNQF3VxbUNvAP24EjuQXNa1MlcVOmdH2CTDC+k+3E5DQcO+KtGc5487JbY45dH0bT4xEonMVEHj14EUJd1KxJufM1DfPtX+FAGPC4f/3W2vkL9xEg1AuLueZYyWQ4vruDKfwi9iZWlCa1bay26HI+ZQCtKvLxrcA5CJ9jILDCCrIYTJn09hZXS7bRFrMnfJzKAu74mr1YWHcQqWomtYE1Du0Fz2upw5LWtF0wK0G2tnog1X7fZ7DLQ3npiMzveMnI84VKsSE7HJUtU7Xe4BCprfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+MgqkMWWXH9cxzXrcC5JTjpIH7fwrmB8OJCS0iYMiI=;
 b=W2IXq+14pkaDOrrC4JxgTYVMgHDV1eQy9goXrpT0iFTm7uWsBsAZndK/UEB/2hvXc4GEQN096lwPJINnlP55ZAKoA4p10IUJMY73dRv7sG/s/bStOP9O9abAoXB9CZItoTZoVrUPjWdT57zfhPHpOpGJoME4CxWBjNkNY9UfcLeVnhMnroHmwO/PwMJnwCBtYcPVL3VRW4yyI5Sav0CJV3UAbJ8jNBA5mcjwC06fwzF/cp5xEcre8TI5lhHX6mWLVpZwtYmnZa7+O3zpjhUwPZLCNhNZaLZmC7jqlTAFcCuPXNf+GEpDAi4XLP/hEaKUfnPa5osy/o13PhAGXr0MYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 19:32:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:32:51 +0000
Message-ID: <005940db-b7b6-c935-b16f-8106d3970b11@intel.com>
Date: Wed, 23 Aug 2023 12:32:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 02/12] doc/netlink: Add a schema for
 netlink-raw families
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-3-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-3-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: e88fa670-849f-4600-cb70-08dba40fbd61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gl1ipajWlbm3jD/buqa+ekeqeadhYogBnWZ2V+gJqwiP/qfGNGsmY2u36pd8JL1YUnLBRhMLvV66dSV1QNU+3PVsHSf6K327QT066hbwlJBpL7g5VdxsTT/k0NZTTyJKsTrNHxQ6Q4C+219spxjpMcBAlEXvC4OaKuIEqLJ1OzvjxpHHOyGrOIqEClvcBF5y77alYS4r/IL9VQzlDCzFQx57xc+iRgGEQVUqD2mcgT2avGtYCylCq6G56utyauGEBYJo7F0svsJAip+fnPOACIJ/GD6Iffvh84QN/n0LYWQcV/0e2NgZJ3PdZenQhc0Bsne5wRZkGKyttl6LbjjMd+y1KRGZfB5/6dpn9sD20w9RYepNw5GF13gV43ShdKJWQaavkDhKZUUfYOBWiK29PHDkULlggSQ261OshFLem+be00+dKq8evmRK+WmCaLt1UlG5An+11BxxtIiWYsk6+L42RLWNhgsi0nLdLi0ip0Axjnaogqh/tcstMm3G3Z4128iP/ZUwquorJzZNxITeONs83fwrKZIKBQPSxJNVv39Uo4ImoJ74UfwWH+GHRbKXHmusD5nFG/RBNENDqipNbUcHVjI9Gwx0eWSYYwBHNfcJgdGO73aGr6ZQk2OThodrAHs1IK9jEIVsTdjKxKgOsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(186009)(1800799009)(451199024)(6506007)(6486002)(53546011)(6512007)(83380400001)(921005)(86362001)(31696002)(38100700002)(82960400001)(36756003)(26005)(2616005)(2906002)(316002)(66946007)(66556008)(6636002)(30864003)(41300700001)(110136005)(66476007)(5660300002)(8676002)(7416002)(4326008)(31686004)(8936002)(478600001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzIybWg3ZEFkUUFTNHVPd0FzY0JzcnJTMDhXRWhrNWhRd2N0alZjQnc1L1RL?=
 =?utf-8?B?OWtXUEN0ajdSYjVFejRhS1VxZ3crem50eGZCUjduSEhadHdkVzQyM0FSYjZI?=
 =?utf-8?B?S0FFeFhTUzRhL3VpSXZqdWQ1b05HOHFZbysvOUFGSDAvdjEvYmJnVnkzQzFt?=
 =?utf-8?B?MDhLdjNhMkNSRmV0aWM5UmVSYXdqYTZTYmVoT3NIU1o0eVFzNGN5eFFDQ28z?=
 =?utf-8?B?Z1FEWGFSbFpLQkx1TjN3Rm5IWWpxV2lWTVZDTmdsY1RjY3ltNG1ISDJXU2hH?=
 =?utf-8?B?eEZZcEFtK2p1eTVXSjJLVVlOR1NpZm54bkFJK2VkdEVCclRIRzhEVTA2bW9B?=
 =?utf-8?B?a0tYV3pyb1JkblM3d01qZUNYN1hEaXFiKy9Gc1BVWGVpR2VwSzNXZ1o0NC94?=
 =?utf-8?B?NnFFVy9IeEttSGtmOGpVanN6RHJrQ1hwUHRURjZhUEdWVHlNWnFtK1JrQWtv?=
 =?utf-8?B?aXVRaWwrYll1M2pWTlRsKytIanNZSXhPNkJWVThrVTAwSHk3RXEyb2ViYXFI?=
 =?utf-8?B?M0pHbmYxRjFCMURtMThxNGhOU0JyTGNDdmFNczZlZTFHK3ZyelJZYWs2bGZF?=
 =?utf-8?B?MGpDQ3hFMnR6a2tCeHFkanZzV1ZheTIrK0JGbHcwZ2xPN1daL29SeFZURUlJ?=
 =?utf-8?B?UXB4eXpVRzlsblU2N3RvaXVXTnFwa1dwU3MyWmVob1daNFpRR1E2ektuYlhS?=
 =?utf-8?B?Uk5VeFRZTHQ2aTB4aUVaSVJUbVk5UFllZEVwTXdiSGk5Y2VGQ29ZTWtJNEF3?=
 =?utf-8?B?MEFlUlYvM1U0SDJtcEVQRzlzb2NEWG9ycm9ITHYreFJaOTVMdDlrLzdoTUpm?=
 =?utf-8?B?M3ZIZ0JpeXpURzV4Y3A4N1gxRUhSbEVmVXI0K0RTbVNoekQrcUVENkNyU1dw?=
 =?utf-8?B?SGUzN1QrelJONnRuN01paUs3YmpDek9EY0poSmtQajZlYlBqU2p5QmV6QjR0?=
 =?utf-8?B?QkdhcWZpZ2g4bEEvT3gwdjdYWEt4L0dCLzZiYTEyencrM0hnU3hkZDV4Yjhp?=
 =?utf-8?B?bElPOWpFVHVxelUzVm1TSGFHUEw3b015Q002cEhuZ3dlbCttcXNoOXQ1eGk5?=
 =?utf-8?B?dkRYMGxuR21BT2NrWHQxdzZ6bkhoNy94Vnh4WEZYTHNWeHFVZnNmbTJVN1d3?=
 =?utf-8?B?SEt1aFh5ZEZva3lTSWpGZmgvNzhpYzNjaGpseE1XclBNVFQzNUdBRllHYSts?=
 =?utf-8?B?dUM3c25KbTdKY1hwSXJOVkFFVEJsWmxCTDh3TzFObElBSXpHcjQ2dnNadmI4?=
 =?utf-8?B?eDdCN3BCS1FUQzVoVUZURUtQdDd4SytCWTZqZGZTQ3F5dlpoSER0T21wM1RG?=
 =?utf-8?B?NzhldGJBV2pscExpNHJvUE9ReVhtL1ZTYXFqWnR6bFlJdTlPV1plWGVCcVJV?=
 =?utf-8?B?RHhNQXdjMHVnOW9EL3RvUFF3TFBIY0ZWQ3MwQnZSamZDRUdER3VNUm8rcmJu?=
 =?utf-8?B?dGZ3Mm5jQStzSk1MajJpYnUrUzhUYllqUEhDbG5wT3pCVG4yZUgxZUhXMzRh?=
 =?utf-8?B?UHM4dUFjUzJOSGtDMnA0OGtaY1R2STVmVlNEMXljdEJuWTJVb2RGRGdCTGlt?=
 =?utf-8?B?OEpXdlFZTFZlck84U0Q3RHV1b2NuL21UNmVub1JUbmEvbUx1cm0rMjNHUlRt?=
 =?utf-8?B?MmNvbzY0TmNqaHRSRWNrdU9zT0FPV2tBMHpxWnJCMDVTeGFlaXRzVHBkT21D?=
 =?utf-8?B?Sm9xbGhTR1pRU0JGdTBPL2RETzVZMENyNnkwVjdzcVJnRGc0eGFJU2Z1S3pP?=
 =?utf-8?B?RmJVeXBqNkI3Uy9RcXFKd3ZQUTZHcFNYeUc1RE96ODJKblRQU1ZOS3FPUHQ3?=
 =?utf-8?B?OFVuR2N0dHJQcjdLYk5Ockl6eWVjUFg1TG03SUN4TlVaWnNjQkxaZkpTbGtK?=
 =?utf-8?B?aTZ3RVpGUXFRa3lTUVV1SG1EWU1tc1MwM2VMcFhJWmpTTHFkQXpFNzNwcGpM?=
 =?utf-8?B?ckhtekhPcWI0OEt4SWJMY3loOEk0QU9YMVFwMVRiRUN0YjZlY3lQdlBrdFcz?=
 =?utf-8?B?b29DQkc0aUkwS1JkS1NxNkJ4Tk9lVUtueVdSN3RITFd4QTBJSjVRcDluRmN5?=
 =?utf-8?B?MnNOdWdwT0kzaUNhUGRUeTNJeGI2U3grbU1wZVNOR1orL0ZhRDZPVjFqMWJG?=
 =?utf-8?B?Q3J2TENnWDZVd2xDS1JEdFdEa1NYSCtqQ1RoNTloY3lBMktLOGluWlNOMk1i?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e88fa670-849f-4600-cb70-08dba40fbd61
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:32:51.3541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X7GTpS94docT+Vt9wQ6y4Cqcptq7rkYg5QmdJxxRJjFQSFavusIwWayaNtU/QOSzc+ShLtPbeOOzsSkJPnPNmqw0qE0zh92l2n2HOAV8S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:41 AM, Donald Hunter wrote:
> This schema is largely a copy of the genetlink-legacy schema with the
> following additions:
> 
>  - a top-level protonum property, e.g. 0 (for NETLINK_ROUTE)
>  - add netlink-raw to the list of protocols supported by the schema
>  - add a value property to mcast-group definitions
> 
> This schema is very similar to genetlink-legacy and I considered
> making the changes there and symlinking to it. On balance I felt that
> might be problematic for accurate schema validation.
> 

Ya, I think they have to be distinct to properly validate.

> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/netlink/netlink-raw.yaml | 414 +++++++++++++++++++++++++
>  1 file changed, 414 insertions(+)
>  create mode 100644 Documentation/netlink/netlink-raw.yaml
> 
> diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
> new file mode 100644
> index 000000000000..ef7bd07eab62
> --- /dev/null
> +++ b/Documentation/netlink/netlink-raw.yaml
> @@ -0,0 +1,414 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +%YAML 1.2
> +---
> +$id: http://kernel.org/schemas/netlink/genetlink-legacy.yaml#
> +$schema: https://json-schema.org/draft-07/schema
> +
> +# Common defines
> +$defs:
> +  uint:
> +    type: integer
> +    minimum: 0
> +  len-or-define:
> +    type: [ string, integer ]
> +    pattern: ^[0-9A-Za-z_]+( - 1)?$
> +    minimum: 0
> +
> +# Schema for specs
> +title: Protocol
> +description: Specification of a genetlink protocol

If this is for netlink-raw, shouldn't this not say genetlink? Same
elsewhere? or am I misunderstanding something?

> +type: object
> +required: [ name, doc, attribute-sets, operations ]
> +additionalProperties: False
> +properties:
> +  name:
> +    description: Name of the genetlink family.
> +    type: string
> +  doc:
> +    type: string
> +  version:
> +    description: Generic Netlink family version. Default is 1.
> +    type: integer
> +    minimum: 1
> +  protocol:
> +    description: Schema compatibility level. Default is "genetlink".
> +    enum: [ genetlink, genetlink-c, genetlink-legacy, netlink-raw ] # Trim
> +  # Start netlink-raw

I guess the netlink raw part is only below this? Or does netlink raw
share more of the generic netlink code than I thought?

> +  protonum:
> +    description: Protocol number to use for netlink-raw
> +    type: integer
> +  # End netlink-raw
> +  uapi-header:
> +    description: Path to the uAPI header, default is linux/${family-name}.h
> +    type: string
> +  # Start genetlink-c
> +  c-family-name:
> +    description: Name of the define for the family name.
> +    type: string
> +  c-version-name:
> +    description: Name of the define for the version of the family.
> +    type: string
> +  max-by-define:
> +    description: Makes the number of attributes and commands be specified by a define, not an enum value.
> +    type: boolean
> +  # End genetlink-c
> +  # Start genetlink-legacy
> +  kernel-policy:
> +    description: |
> +      Defines if the input policy in the kernel is global, per-operation, or split per operation type.
> +      Default is split.
> +    enum: [ split, per-op, global ]
> +  # End genetlink-legacy
> +
> +  definitions:
> +    description: List of type and constant definitions (enums, flags, defines).
> +    type: array
> +    items:
> +      type: object
> +      required: [ type, name ]
> +      additionalProperties: False
> +      properties:
> +        name:
> +          type: string
> +        header:
> +          description: For C-compatible languages, header which already defines this value.
> +          type: string
> +        type:
> +          enum: [ const, enum, flags, struct ] # Trim
> +        doc:
> +          type: string
> +        # For const
> +        value:
> +          description: For const - the value.
> +          type: [ string, integer ]
> +        # For enum and flags
> +        value-start:
> +          description: For enum or flags the literal initializer for the first value.
> +          type: [ string, integer ]
> +        entries:
> +          description: For enum or flags array of values.
> +          type: array
> +          items:
> +            oneOf:
> +              - type: string
> +              - type: object
> +                required: [ name ]
> +                additionalProperties: False
> +                properties:
> +                  name:
> +                    type: string
> +                  value:
> +                    type: integer
> +                  doc:
> +                    type: string
> +        render-max:
> +          description: Render the max members for this enum.
> +          type: boolean
> +        # Start genetlink-c
> +        enum-name:
> +          description: Name for enum, if empty no name will be used.
> +          type: [ string, "null" ]
> +        name-prefix:
> +          description: For enum the prefix of the values, optional.
> +          type: string
> +        # End genetlink-c
> +        # Start genetlink-legacy
> +        members:
> +          description: List of struct members. Only scalars and strings members allowed.
> +          type: array
> +          items:
> +            type: object
> +            required: [ name, type ]
> +            additionalProperties: False
> +            properties:
> +              name:
> +                type: string
> +              type:
> +                description: The netlink attribute type
> +                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary ]
> +              len:
> +                $ref: '#/$defs/len-or-define'
> +              byte-order:
> +                enum: [ little-endian, big-endian ]
> +              doc:
> +                description: Documentation for the struct member attribute.
> +                type: string
> +              enum:
> +                description: Name of the enum type used for the attribute.
> +                type: string
> +              enum-as-flags:
> +                description: |
> +                  Treat the enum as flags. In most cases enum is either used as flags or as values.
> +                  Sometimes, however, both forms are necessary, in which case header contains the enum
> +                  form while specific attributes may request to convert the values into a bitfield.
> +                type: boolean
> +              display-hint: &display-hint
> +                description: |
> +                  Optional format indicator that is intended only for choosing
> +                  the right formatting mechanism when displaying values of this
> +                  type.
> +                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
> +        # End genetlink-legacy
> +
> +  attribute-sets:
> +    description: Definition of attribute spaces for this family.
> +    type: array
> +    items:
> +      description: Definition of a single attribute space.
> +      type: object
> +      required: [ name, attributes ]
> +      additionalProperties: False
> +      properties:
> +        name:
> +          description: |
> +            Name used when referring to this space in other definitions, not used outside of the spec.
> +          type: string
> +        name-prefix:
> +          description: |
> +            Prefix for the C enum name of the attributes. Default family[name]-set[name]-a-
> +          type: string
> +        enum-name:
> +          description: Name for the enum type of the attribute.
> +          type: string
> +        doc:
> +          description: Documentation of the space.
> +          type: string
> +        subset-of:
> +          description: |
> +            Name of another space which this is a logical part of. Sub-spaces can be used to define
> +            a limited group of attributes which are used in a nest.
> +          type: string
> +        # Start genetlink-c
> +        attr-cnt-name:
> +          description: The explicit name for constant holding the count of attributes (last attr + 1).
> +          type: string
> +        attr-max-name:
> +          description: The explicit name for last member of attribute enum.
> +          type: string
> +        # End genetlink-c
> +        attributes:
> +          description: List of attributes in the space.
> +          type: array
> +          items:
> +            type: object
> +            required: [ name, type ]
> +            additionalProperties: False
> +            properties:
> +              name:
> +                type: string
> +              type: &attr-type
> +                description: The netlink attribute type
> +                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
> +                        string, nest, array-nest, nest-type-value ]
> +              doc:
> +                description: Documentation of the attribute.
> +                type: string
> +              value:
> +                description: Value for the enum item representing this attribute in the uAPI.
> +                $ref: '#/$defs/uint'
> +              type-value:
> +                description: Name of the value extracted from the type of a nest-type-value attribute.
> +                type: array
> +                items:
> +                  type: string
> +              byte-order:
> +                enum: [ little-endian, big-endian ]
> +              multi-attr:
> +                type: boolean
> +              nested-attributes:
> +                description: Name of the space (sub-space) used inside the attribute.
> +                type: string
> +              enum:
> +                description: Name of the enum type used for the attribute.
> +                type: string
> +              enum-as-flags:
> +                description: |
> +                  Treat the enum as flags. In most cases enum is either used as flags or as values.
> +                  Sometimes, however, both forms are necessary, in which case header contains the enum
> +                  form while specific attributes may request to convert the values into a bitfield.
> +                type: boolean
> +              checks:
> +                description: Kernel input validation.
> +                type: object
> +                additionalProperties: False
> +                properties:
> +                  flags-mask:
> +                    description: Name of the flags constant on which to base mask (unsigned scalar types only).
> +                    type: string
> +                  min:
> +                    description: Min value for an integer attribute.
> +                    type: integer
> +                  min-len:
> +                    description: Min length for a binary attribute.
> +                    $ref: '#/$defs/len-or-define'
> +                  max-len:
> +                    description: Max length for a string or a binary attribute.
> +                    $ref: '#/$defs/len-or-define'
> +              sub-type: *attr-type
> +              display-hint: *display-hint
> +              # Start genetlink-c
> +              name-prefix:
> +                type: string
> +              # End genetlink-c
> +              # Start genetlink-legacy
> +              struct:
> +                description: Name of the struct type used for the attribute.
> +                type: string
> +              # End genetlink-legacy
> +
> +      # Make sure name-prefix does not appear in subsets (subsets inherit naming)
> +      dependencies:
> +        name-prefix:
> +          not:
> +            required: [ subset-of ]
> +        subset-of:
> +          not:
> +            required: [ name-prefix ]
> +
> +  operations:
> +    description: Operations supported by the protocol.
> +    type: object
> +    required: [ list ]
> +    additionalProperties: False
> +    properties:
> +      enum-model:
> +        description: |
> +          The model of assigning values to the operations.
> +          "unified" is the recommended model where all message types belong
> +          to a single enum.
> +          "directional" has the messages sent to the kernel and from the kernel
> +          enumerated separately.
> +        enum: [ unified, directional ] # Trim
> +      name-prefix:
> +        description: |
> +          Prefix for the C enum name of the command. The name is formed by concatenating
> +          the prefix with the upper case name of the command, with dashes replaced by underscores.
> +        type: string
> +      enum-name:
> +        description: Name for the enum type with commands.
> +        type: string
> +      async-prefix:
> +        description: Same as name-prefix but used to render notifications and events to separate enum.
> +        type: string
> +      async-enum:
> +        description: Name for the enum type with notifications/events.
> +        type: string
> +      # Start genetlink-legacy
> +      fixed-header: &fixed-header
> +        description: |
> +          Name of the structure defining the optional fixed-length protocol
> +          header. This header is placed in a message after the netlink and
> +          genetlink headers and before any attributes.
> +        type: string
> +      # End genetlink-legacy
> +      list:
> +        description: List of commands
> +        type: array
> +        items:
> +          type: object
> +          additionalProperties: False
> +          required: [ name, doc ]
> +          properties:
> +            name:
> +              description: Name of the operation, also defining its C enum value in uAPI.
> +              type: string
> +            doc:
> +              description: Documentation for the command.
> +              type: string
> +            value:
> +              description: Value for the enum in the uAPI.
> +              $ref: '#/$defs/uint'
> +            attribute-set:
> +              description: |
> +                Attribute space from which attributes directly in the requests and replies
> +                to this command are defined.
> +              type: string
> +            flags: &cmd_flags
> +              description: Command flags.
> +              type: array
> +              items:
> +                enum: [ admin-perm ]
> +            dont-validate:
> +              description: Kernel attribute validation flags.
> +              type: array
> +              items:
> +                enum: [ strict, dump ]
> +            # Start genetlink-legacy
> +            fixed-header: *fixed-header
> +            # End genetlink-legacy
> +            do: &subop-type
> +              description: Main command handler.
> +              type: object
> +              additionalProperties: False
> +              properties:
> +                request: &subop-attr-list
> +                  description: Definition of the request message for a given command.
> +                  type: object
> +                  additionalProperties: False
> +                  properties:
> +                    attributes:
> +                      description: |
> +                        Names of attributes from the attribute-set (not full attribute
> +                        definitions, just names).
> +                      type: array
> +                      items:
> +                        type: string
> +                    # Start genetlink-legacy
> +                    value:
> +                      description: |
> +                        ID of this message if value for request and response differ,
> +                        i.e. requests and responses have different message enums.
> +                      $ref: '#/$defs/uint'
> +                    # End genetlink-legacy
> +                reply: *subop-attr-list
> +                pre:
> +                  description: Hook for a function to run before the main callback (pre_doit or start).
> +                  type: string
> +                post:
> +                  description: Hook for a function to run after the main callback (post_doit or done).
> +                  type: string
> +            dump: *subop-type
> +            notify:
> +              description: Name of the command sharing the reply type with this notification.
> +              type: string
> +            event:
> +              type: object
> +              additionalProperties: False
> +              properties:
> +                attributes:
> +                  description: Explicit list of the attributes for the notification.
> +                  type: array
> +                  items:
> +                    type: string
> +            mcgrp:
> +              description: Name of the multicast group generating given notification.
> +              type: string
> +  mcast-groups:
> +    description: List of multicast groups.
> +    type: object
> +    required: [ list ]
> +    additionalProperties: False
> +    properties:
> +      list:
> +        description: List of groups.
> +        type: array
> +        items:
> +          type: object
> +          required: [ name ]
> +          additionalProperties: False
> +          properties:
> +            name:
> +              description: |
> +                The name for the group, used to form the define and the value of the define.
> +              type: string
> +            # Start genetlink-c
> +            c-define-name:
> +              description: Override for the name of the define in C uAPI.
> +              type: string
> +            # End genetlink-c
> +            flags: *cmd_flags
> +            # Start netlink-raw
> +            value:
> +              description: Value of the netlink multicast group in the uAPI.
> +              type: integer
> +            # End netlink-raw

