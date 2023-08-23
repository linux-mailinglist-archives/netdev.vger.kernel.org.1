Return-Path: <netdev+bounces-30129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023317861AB
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 22:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A506D28139C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 20:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE07C12F;
	Wed, 23 Aug 2023 20:38:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F0F1C3F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 20:38:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CB410D8
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692823128; x=1724359128;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZsPIDo8Gr8vR34QFW/Ua42CNVLr1PQYkykjxA5uhk+Y=;
  b=b69G0Zd2Ys9GaS8ducYd0LIXHrugG7tiAa17MQEn36b7Md6k3UDmVJor
   b7o63mQCdLSR5fRZWnM4qPg1EWpazJF2yXs3N/Giq8egiaBMsQ2gRmxl8
   8IKKimOKxb0Es91TXOxMD+praBzmaSkqqOSDFyauTUx9ZwOz5YDA5IxMo
   5s3gh2tPh8DR+1zbekY6U5qSUXQK3qef2cKDYVlLMTFmhOdYwU6Wqi+3m
   OUoDRq7m6Etwx97BtScMIvXGvj9wBTWh/A3g++5yKAYtGWoGcMliteqGX
   tuJet+KWdioQrJto0hK1LRXhc5Tl53wSbnPypKaPG5IIAZrjaI3Y7UUYu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="440620648"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="440620648"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 13:38:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="739907013"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="739907013"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2023 13:38:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 13:38:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 13:38:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 13:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hbk7TTajuRdBepVgijZrtdg+rIy58U1dv+zE6mXb5fA1NrgQA6+oaUuzbcwABDclT25CnMB/rLD3p1e1K3ED7A++FV6uDBDNHpcXEKtJtbLq7KhEZUr9juFWQZeCwlZq0JgWQsD1vvONCazLHU2IVoFnP4i35VKI2NqqrwAxseClUAxm4viUnSmanOezKvvnKmQsP/k3QzXxcf4xBTLiuc7lB7UxbTWhgRlUI7cA4McU+WjojibiXlIMObawGCTG+zZlJQ7OC0Ne9DbigJMOGlriS1tM1IozmW/X8NxWvwXCTH3IBCsYoBgJ2bP30K53h2xLM36x2XlIZaq/dkoESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3L2wY88qG5nC1gBVqsLwqiT8TdtJ0ydhiOhZVTDXJ8=;
 b=d1l7SDYZiGjTpCK2nDeatJxB8cUumK8GI9BkpTSV7QvAsH/ZCwPEHDjVJqZhJw1yfOWp5Qb9VGKqeJlF/gFeLRTh+ZnwARK55k/pP/INgrb+IqRZylJzv2mjfeK/4lz/VDzNSCjUbWTSX3vbBV7KD9l+71TFJ71rdkm9TOC46mOQ+axDOEyie5J/XIP2MEUw1BT+Nd14mnGHl+zEfsPQ9PY9dOKZyeZO0HcWobwhjpRMCcC4yFDTJoWHtOd/0dxv0zZg5iUdkp0gqLBM9XUa35zJpL0ycYJYIEuWuoAtVupmThRyoe+ozMr4BFg4MhdDo5z0hxgSTLWJy2lEnYGfsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SA2PR11MB4889.namprd11.prod.outlook.com (2603:10b6:806:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 20:38:43 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29%3]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 20:38:43 +0000
Message-ID: <2e5a15c4-fce3-c944-45b9-1e778ec4178e@intel.com>
Date: Wed, 23 Aug 2023 22:38:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next] docs: netdev: recommend against --in-reply-to
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20230823154922.1162644-1-kuba@kernel.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230823154922.1162644-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::19) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SA2PR11MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: 39edc35b-7b49-48ea-6e43-08dba418f0df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YtfgUXejKz2Dy2QPihYCEw1kw4M95U7VNi3RrPXyGkqAX/L3u2PUIycTqbf7Ob7hVOSYRe04nBMGAyNsEjhUrqbZ8eFpLsC1dINh8et6BestQtoZom811vMXYHMgIsOjhMVWM28p6nV/aGt5HTBhL9orD/wOKySfeSMC0gkvfQJ3URiJ22D7jy6le8NULr94B8bkZJ+Y1yDcjuAVML4T0OKqX+aunsXm7b3R58mus7X0e7LT7uYCnlcUI76XI2YbsrRgYGP6/dZvoVKxLY6gT3+8mMJAWWJMX1qc2AKTk3xL54AGw+YAgjrJS8mU9xHHjIiyIDNYW0qX+1i6wtQdZrKzs6mac1J4DOv8buMLVwg0E2SMyu4ZBMT91ZBJtJEwDfkwWYs+fwYsMADYV1WIUENlGoh/g281ooIe3jszAHHeKX5z9KyQD8twRFhd/rSQoy5Zq3bSwVwws0zeHrrsbLonKes7jrsWKJbRzxxiN1YF5D2rcXcFRh65/gnB1NmAh5+YHt17ILQW4BSaFw3WeLVV6xL+tqI5ng0TEVgAoLz+b03G7bYQNEk/T8WVQnMyCH6lhWsKHd/qmulAlXdRBbPgRg2594ekh3InsjrHw8TX8D9QvN97TCMcJxly4s9h80/Jxwx07UcdKc1zDMkYAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(186009)(451199024)(1800799009)(36756003)(31696002)(86362001)(31686004)(478600001)(8936002)(8676002)(82960400001)(26005)(2906002)(4326008)(38100700002)(83380400001)(6512007)(5660300002)(2616005)(66476007)(316002)(6506007)(6666004)(66946007)(53546011)(66556008)(6486002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNNM3g4OFNWYTJ4YUhRdGcvWGR1c1QxZzFMTERua29XTWpEaU4zMktPdC9y?=
 =?utf-8?B?YUlHWi92U0ZMMG5ZNVVYM2VzWlRZbkM0bEE2ZE5VYzdtaUs4ejZQOUNMNjVX?=
 =?utf-8?B?RDVFTTdmSFJoQWdaWGRXa3FIbHg2ZStHa3huc04vMy9PSjVTY1lYcm80SUlG?=
 =?utf-8?B?NHNMdjh4Y1dsUXJDdk9mOERNNUsxam91eVhwUXk4SEVnYzVhOERPK3hhNktx?=
 =?utf-8?B?OWZPd3VjVUllRWUxNUxTYWhXODR1OEsrSU9QWFdtQXdQRWtvY0FjdkJkM2F1?=
 =?utf-8?B?dmVyK1Vsek9jaWtPblN6enJqQmVxQVRqbTZNblE2SDVMdW14RXp1VGNJYmFJ?=
 =?utf-8?B?U1BXYU41MkVsaGVaZGh3a2ZxaG5uUTlaU2ZtY0JqUmxVbGExR0sybHVic0pF?=
 =?utf-8?B?M0dtOGl4Sit3dk5iWHpqL1BjOGFubUFrQzZJQmNWQkphVlVlQldTQVMyLzNW?=
 =?utf-8?B?YTBaMzJCa2p6VmdXRlRFTGZkVE9NeHp1S1lOaHpUTnpkUTVRWkZ3Y0d1cUxi?=
 =?utf-8?B?SjN1MG9ya0VBa1BxNkNIMnFvd0NhSG9xd3pjRWtRdjBMajRyakcrZlRzUVJa?=
 =?utf-8?B?V053dW9OVVNETThsYUFGT0txMWVTRTFqOThEaWRRTGovSFU3ZGhJRWo0ckl2?=
 =?utf-8?B?WG9YWUlMSVIvR1FVT2Z2OFd6Znd0NkVIWldvVkpTd2FTdmJobi9TZi9IRmM3?=
 =?utf-8?B?UUNDbjhNeWlLZFBHWHhscFowM0ExNktHNkNmcjVYcEVoWE8wQldVZnpMM2Vj?=
 =?utf-8?B?RWhhdVZ0REw0MVhKRGNSYzlnMWJGcDN1aStIZUVtUzZ6ZXJOYjBtYVUzWFlo?=
 =?utf-8?B?WUQ4YUZ4WXNPWWphb3VPbEtxSDVuMk1yUEx3VEI4bVVDN0dVdXhXQThkL1ZI?=
 =?utf-8?B?eE1CS1BQeEZucVgxVUZES3pUaWhwRTB3bEtjN2x3Skx0azUveGN6akYvNllG?=
 =?utf-8?B?RGxxbHpEeFIyNzN5RWpvc3VCMFo4QTdhL0hPbDVKTjk1aWk1b2g5V0JMRXk0?=
 =?utf-8?B?U01iZTM2OE1kR2JJVGFVZXg0QllrNWV1M0o1cmptc25FcEhscE1odERaaEVG?=
 =?utf-8?B?SElaSzVid0oxYng5aytLdlpXbXNrenIyb0w4UnFsV0p0bmFQbDNyYWthRXVk?=
 =?utf-8?B?eVY1L0t5WTcwVmdBZi9vc25tbE15aTVWYmV2Ny9uZDZha1JMb2M5cTY1bVNl?=
 =?utf-8?B?TlFLVHRQaVlaY3hJTEEwZGY0WTkrYnZlOWljbEtRS3B0eWQzVXY2TWFRUjN4?=
 =?utf-8?B?UlA3dXBDekdxdkJvTHhaYXEzSFNOcW5BRlVESmVrWVVHamhGKzlXVUhYbzYv?=
 =?utf-8?B?RnBZZThUbFhVNUFvZkhCL1RRL3BreFRvbVErdzF6WFc2TWhoZXI5bW92QUhy?=
 =?utf-8?B?YWZHNlVTRUdPK3ViNVNncWZ3a3FkeUhBUTBFTnBlZDk2U0NkMTZMVFd5am1j?=
 =?utf-8?B?cHhPNGdwR3BtSEhwNkFoeENCRkFCMmdSVlQ0ZWdSYlFSeUFYRlNNcUhtaUxp?=
 =?utf-8?B?VU02Mm9TWGVUYTVaeC9iVWFrRkVrR29GR3NRK2JvejdIVTJ3VTBEUG16U0FE?=
 =?utf-8?B?OWRKQTg4Y3lzcVI5MUIzdXAxcFo3eTRGMVdSRW9IN0ZYT0ZOMTRXSVh4TE9z?=
 =?utf-8?B?bWc5RDMraDd0VklISVNqQ0FycUhCbHhWSGx1dzA0UFpuQXJoUHg0eis1YVI3?=
 =?utf-8?B?bmd1VXJ2Z1YwU2dzZUxwcEpIcW1LdWVZNk4vejM5UVVyLy9LRmw3enlGRnhG?=
 =?utf-8?B?TGZXWXpqRUgwR0lLc1ArUndHSzYrOUtxTzExUWdVTWxDR0RBQmQ0bDRNK0xD?=
 =?utf-8?B?YlVNU0ZETGhrV09vRnBVOEY1MG8zV09McHFIVUZ3UnJLMVFZY0RGcm9mMmpy?=
 =?utf-8?B?Z1kybHY0cXVRRG14djcwQTFxT3NVNmF6bld0ZnAyNTYrZUxqbWtFazBxcm9H?=
 =?utf-8?B?LzRtL2dldFVsUlpZbnJROUh4aiszOS95Y29BR3JjZTNzWWlOTE5neUovOGZp?=
 =?utf-8?B?Qm9Xd3BuVk9HdUtkRUZmL0JSMmxWK0lRNGdSM1c0RjdxTVIyNHo5dXBBekUy?=
 =?utf-8?B?eEo0WUttMnNRSUFscEZGdzF3MlgvbzA1Ny95Qm5IQmpmQ3ZkT0YzM0Vlc1dj?=
 =?utf-8?B?TXBjRWdzK24rcmlJcU4zZFJPaGFRVEZ3MitEMXFBV21tZ2t6dUV5RGJnSUkw?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39edc35b-7b49-48ea-6e43-08dba418f0df
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 20:38:43.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRIOgHK+R8VS68Bw9ck9BqS1Y9YygvV2OGgWXlVtFMQeghoHH2SzM3sqh7TTPq2l1iAOOo4FI07RF9HhKdaauiywwJT4VwxQXXNCJfWDaHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/23/23 17:49, Jakub Kicinski wrote:
> It's somewhat unfortunate but with (my?) the current tooling
> if people post new versions of a set in reply to an old version
> managing the review queue gets difficult. So recommend against it.

For my setup it is also annoying.

(CC IWL + BCC to our pre-IWL list.)

> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   Documentation/process/maintainer-netdev.rst | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index 2ab843cde830..c1c732e9748b 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -167,6 +167,8 @@ Asking the maintainer for status updates on your
>   patch is a good way to ensure your patch is ignored or pushed to the
>   bottom of the priority list.
>   
> +.. _Changes requested:
> +
>   Changes requested
>   ~~~~~~~~~~~~~~~~~
>   
> @@ -359,6 +361,10 @@ Make sure you address all the feedback in your new posting. Do not post a new
>   version of the code if the discussion about the previous version is still
>   ongoing, unless directly instructed by a reviewer.
>   
> +The new version of patches should be posted as a separate thread,
> +not as a reply to the previous posting. Change log should include a link
> +to the previous posting (see :ref:`Changes requested`).
> +
>   Testing
>   -------
>   


