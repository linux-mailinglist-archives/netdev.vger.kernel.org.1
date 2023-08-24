Return-Path: <netdev+bounces-30514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F437879DC
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 23:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056442816BE
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7227494;
	Thu, 24 Aug 2023 21:04:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D067F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 21:04:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D41BFA;
	Thu, 24 Aug 2023 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692911080; x=1724447080;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TNG7j0dbt9nv99Ib1k17LqEUdkmh0Q6kbAEUQNg8sgw=;
  b=TBs5vKicez/5HnpiDiFkqWGzpjkR4AVp+8pSK9kepSkVozKERV3kRyau
   LPHR8HlQJGetQtjEVeNU00+f33svSsshCjzAVx4POIBoQigejEiL3rcFH
   cHVSvrGnFW7VADNbIBLXGiN6NZR+CgN/Q3gGHx8e74qlSS2+Ry2UvZDLQ
   +kqbNB06JaW5eQvtTsHtirLJca9RFJwYczJ/KhoDw8tBhi44Z0UOKuClI
   SbEQ99UL3l7Vkce+ElgvEnR2b+oj1Yi7DlowImPGDOPt9S6a3koKA5Xy9
   IyScmS3kQQn2LMja4/oax0hr/89oUQ496677aL9kuxz3aeTifqFVEQcdH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354886715"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354886715"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 14:04:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880921143"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 14:04:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 14:04:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 14:04:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 14:04:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 14:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEhbeJtMi7InhpTwyF6CBd29guD/OFoTP1SYpGOux38yvuh5Qjiyu0YA+eMOchA6RtYCZg7M5Wcvx6Hm4fwq2WQGK3oN62JJO/QbfJvsQty8qv0ZUErred3Me+oZs7EoARVdBP7PDkYwlTiIjigjDJRocPG3TImD0Q66ouPC99qxkz5UFJPn2Em7r1JFkd5mLZgUhgh37jcoJM0/9ObPDng96stUinwjZ1BBwBVFRq7sFT+FcHTnIsD12hHsG+1/n/L6ZkwTNrfGyGXqGq11MlA1rEhVvAwDPgqbrI9UGeQBmZP5ZcDpebAz/7EV8KagUcQY/frmczVwGrZAYeSXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2+aZDRr8dot2DdhkC39BXi557Roi7LH89xDMrqaI+M=;
 b=GzIuLHaWu/iXFUhLjj+6ztMFypOLOKe8fBn1xnjBI8rCIT1ivKhjOhSJ5/SPfYTOG54ZKkw2utFqE/Jm2m8hqJHaFOhOSDtvTzLXLRXTz0RCIVEoBEjHp3mFXS5Q2HgBk6Jjd20mAb9Od9qFOiPg0uzo3a4jU4KGtICWM81xR9ylLXVsde8027n7gHZnv2q3r6EMOGKItfVPFQeqZ9I2fTIyPVm7RfnNRU+UCkVLjdAGwI8aZo9DorIVSzhLWTGZoY2nMexcqEQWtpCqKSJvdsg8694H6ha4CTPXHTyTSFGdPHdqODNrHT5B9VJ3vXcH13UsxX0oExDmwOd4Ndi7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB6315.namprd11.prod.outlook.com (2603:10b6:208:3b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:04:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 21:04:36 +0000
Message-ID: <70f906ec-5352-1b43-5baa-e02ec838a0e1@intel.com>
Date: Thu, 24 Aug 2023 14:04:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v5 02/12] doc/netlink: Add a schema for
 netlink-raw families
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230824112003.52939-1-donald.hunter@gmail.com>
 <20230824112003.52939-3-donald.hunter@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230824112003.52939-3-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: a6252b51-6035-4dfa-96a5-08dba4e5b928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mScKN/q5V4c5YIQgdXQnKlt+8yKuwaGOl8ddgL5rbJEW+MIUk8pGekI5HOBsVKNz8vrkiIH/AWONmpCeatrP4HURo3v1EgxOHWDppPncuG5+sdd3uAcxmKtfDmtAekUZ123iKE+lOPY30cO01swsc3+BMchNPeyvk3Vys8iSARtL/Jmta9ZhqngteCnMGWOC5IAKeT8NGXXcNWJvtT8nyArlUUUaeQK0wAL4Hpy849f/5dnwVwYmITgGqaFDGlX5uRDkPxHTWYESCOOK9GPUq0D9U50/8zQatBlFbR+nAGTo4SOkff7NQQNv4C8v3gaT/+NYsdXf4EwPXOvLw9QrtoRWnmo8/E1P1mHjGacuhqcPXwwgrokDszR/ohM6bvfddNBn9TGU15vuscz/huGG7a+tHpBwnPGpHUHFZXuBF9b/jgaDjMrgctsS2kzlklNcCwGb5qFTS5cGoomc5G7k5lnGgH1+nny6AfAPwZLD8Z3616HbB3R0+1hV3fxJ/NuzN6cwhPuWfJES2od4ZyWfQkLeV8K0mx/J8B7AYK9IGqi3cC3KkkSgeKz9wSP3zK2QPnp9BICS9oj84qeYh3eLvM770Q7lrqBoN7JV2zuYvVKL9gjzYTh4K3+FOZC2D58PoPYwW/IE5NHeKny58GEMUwhNFDHmzyRTg0WjJoRoHQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(1800799009)(186009)(451199024)(2616005)(4326008)(8676002)(8936002)(83380400001)(5660300002)(4744005)(36756003)(7416002)(26005)(921005)(38100700002)(82960400001)(66946007)(66556008)(66476007)(6636002)(316002)(110136005)(478600001)(31686004)(41300700001)(2906002)(6512007)(6486002)(53546011)(31696002)(86362001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N213NlRWWEJCOWkwSjhwbTg0dnlvQ0hxMDdORUdIYnJWd1R4dTh5TUhWSWd4?=
 =?utf-8?B?R1J5dGwwaStnVHp5bHc0anZ2V0gyU01KOVlJWXo3TllML01nM2hRK1pIVDA3?=
 =?utf-8?B?NmtXTUViOVdEQTdjMHlpcjNSWmlVY29CYjI3Y2Q4M3AzTzB2bjZMaTlIQ05x?=
 =?utf-8?B?bGwrcm1veEZGa2dNV0hBeGRVOGxVb0JCVGZwWFVxQXZHZ3pmOVdLMHo1NUxH?=
 =?utf-8?B?Wm8rdFBQRkhnMi9UVWJkNkgzQ3pDWHBHQjdOTitCUzZkaTY2N3ZJVU9WbVNv?=
 =?utf-8?B?dndPU1FCdlFTN0xRc3R1Z2hVSWhxN24wckdqRGRma05EdE1tWWlYbnh5b3B5?=
 =?utf-8?B?RHgrZGRsRGUxK1dDaWpwL2xWelVBL3FHSzZZY1RWajZYU2pLKzhOWXE3Zm9N?=
 =?utf-8?B?N2VRRGw5QWJON1BKTGcxQm0wZnVGOVhCSmJjeDQ4ZVdYbzIrVEt4ZWlwWnVW?=
 =?utf-8?B?WWdKZGIvTTNwQ0toVmJvSklHNTk0SGJiQU5EcGZJc2lsb21VMkRmYllMVlY1?=
 =?utf-8?B?d1RKc1NwL2sxb1NFY25YOHRZbC8zSGpETjdIZ0sxMFhIVVp0d0ovbEY1WDlC?=
 =?utf-8?B?Q0wrRWFpRk5OSjdKaDVPY3ByQ21CY0dZVXFjUFU4R2w5MldZN0tzZ1ZuN1ZD?=
 =?utf-8?B?MzVTNkRjMHFYV1QxOVBpVG0wMzF3NjMyTDhQZm5pcDhNYkw4T29CZzhkRzQ4?=
 =?utf-8?B?SWxyOGlDU3l4TUdIcHdsYW9PVzVxUTZ0OHkrcDFvQU5nWE5EaCtLcXhQMUtu?=
 =?utf-8?B?SmNCYTd2K1VLNEc5aEJnSHprQ3ExbmJxa1FZemtIR3pzOXk0UVIwQ1ArczJK?=
 =?utf-8?B?SWJuNTJaQVdEK1BlZkFKS0s0aUgwU242VWVBcVJoMTVxODFkZVVlVXZ6N3ZG?=
 =?utf-8?B?ZEVBMlpNWnV0QkNLd0dGUFY0SWVKdnc0dkcwR2RXVzkrRUYwNUxISFlxR29u?=
 =?utf-8?B?RXF5eWJpampnVFF0U1dHNUNMZThtbkl5dmNUVjl3cTdFTEFpSW4zWDJKT3J2?=
 =?utf-8?B?ZXFhTVZTQTZtYVBYSzMvYkdid0VSd3RFajJTNzhwK0FhUms3emcxS1hCSE9Y?=
 =?utf-8?B?VlBPSXNmNnZYbjhUVUozZGwxVnVlaU5rcno2MHk1bTNvZUpvWjhGREU3YVlV?=
 =?utf-8?B?NU85QmxJQlpLWFNuVzZNamZxakV6TVJCTlByUWNldXJlZVBpQS9LZkJ6UHh6?=
 =?utf-8?B?U2NKMkZhcXE5ODZQZExsUzVZVHppSU1pbWJhejJFYkVTaDNZc2toYmNOUnlD?=
 =?utf-8?B?UEpoK3B2ZlVGSFJ6aWxCcm5qRllGZ1Nqa0hTa3J4b0tkZTNKMVc1OTZLekdU?=
 =?utf-8?B?MVZ1L0oxbGlrSTl1YldGcFBrdGNpa2NhcDFjME4wb2p2MEQ4aWV2MElWMTN1?=
 =?utf-8?B?aVplNms0NitmVEo4dUhUWFZ5OVVrRzk3RCtPSWRveHdWemh5aWlhTDVEa0tM?=
 =?utf-8?B?cWozanpNM3VmNWlrMStWbFc3QmlvTzQzK2E1eGJtVmk0QjZrNzhVWElKSXl0?=
 =?utf-8?B?ajJXVWMvdGM0bzg3SnY3T0I5ZnFUV1BaOUpEWFgrY1JRcnNLa1dvcEJDZjBn?=
 =?utf-8?B?TG54M1U1dmlBV2dSckJaSkVwYlJmaU5wQmJhSERCN3F6YXRKUEQvcXl0cDFt?=
 =?utf-8?B?MjZlRzRSeHFZMFhTQzJtN3Vjei8vRmw1SVRGNFl5RGRiRjRRQXExam5xdEdG?=
 =?utf-8?B?bWcyQ0lvWitYWlpiMjNZWDFtVzdNanplQ2cvczI0WnlNLytnanFIMDdCWGNt?=
 =?utf-8?B?RzJXQjBQTTBIWHV0WEtxampMditBOUN2cDlmM1AvdGY2WXFNeVRwY1RaeElP?=
 =?utf-8?B?cFpxMnhMb3ltMi9NaUxnamFPV0gxVFNwMUViRzluZzlZeHdNYXNEUzZXcmxh?=
 =?utf-8?B?ajdya0x2aW5OWnJYckVYanR2S2JTZUhKNEJPbFk5N3hkRlBRb01oSDA3UFZm?=
 =?utf-8?B?bGFqcGFQTWM3VDJSYjRMVDhMNHhjbEExVWJsVGlvdXZmeHE4R3pINytpSmJw?=
 =?utf-8?B?c2IwdVlCVCtQL2xRZnl6aE80cFV5OW05akl1ZmFDS3VJR1lyMHg1Skt5bEJL?=
 =?utf-8?B?TXFlK2svaGUxdVIveEoyblhVZ2Q5WCtUT3V5aWRjY1ViWm9jWkNVTTU0UTBM?=
 =?utf-8?B?VmJDekVZUklpWjA0SXNEUEJFQzlDTXU2SkhONE8xUXhXd1NTdjRYdmFYWkw2?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6252b51-6035-4dfa-96a5-08dba4e5b928
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:04:36.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPdWvzJmf5pUAdfV0hcG+14F0zisSOjcYizlYrq6IrSnTITz/XLaeK3IyDk3kEIMSwt+409xNvhd2qWQO+8oVuRhFmjGOWuQ6p2Ny2pKGmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6315
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/24/2023 4:19 AM, Donald Hunter wrote:
> This schema is largely a copy of the genetlink-legacy schema with the
> following modifications:
> 
>  - change the schema id to netlink-raw
>  - add a top-level protonum property, e.g. 0 (for NETLINK_ROUTE)
>  - change the protocol enumeration to netlink-raw, removing the
>    genetlink options.
>  - replace doc references to generic netlink with raw netlink
>  - add a value property to mcast-group definitions
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

The updates to mention netlink-raw look good to me.

Thanks,
Jake

