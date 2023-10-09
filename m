Return-Path: <netdev+bounces-39177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9FE7BE443
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FD1C20D27
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFF637172;
	Mon,  9 Oct 2023 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MArwBHtq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421937150
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:14:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C8129
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696864454; x=1728400454;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oiSJsgB+0lDQqfcCBAG95N+UjOPx5U7nibaHPTskvwg=;
  b=MArwBHtq9H2szjoJVob2rhptAgyrY1G7e/Us0a0TFvy/iRUkdlP1Qkyd
   +GSdQTOGvaJevFzeUV23YqJiaTVe8fBsT1p0OLKXAALZPE4BLUJHy2kjP
   NNAFwtyOeKG00nDiSa34y+brl3oQytZ5nNgF0z1sj+kjDEQC/+P7kE/6i
   JbwhcHGDdLgXVKEYa8C0rxgD0pY+dK+5WIC+iBL6h3y4qwu77pHv9/9bA
   g+5FX2J2X02tphMNenAIHfabP2P5AyVeXAMuenfFycyuWbAc/SXaMSgRu
   m3G/2jcCAiicZf1sb+FxVN/krhpC/TiAhxZA+mzxjG2mB2NSNEPZiwHnB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="369232570"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="369232570"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="753039719"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="753039719"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 08:13:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 08:13:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 08:13:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 08:13:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 08:13:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUahSpKiZ5HS/YlJj7ncpOS+OWDb8Xo3fqKXwMOcenJH3GJ0XwcSOhNMfk2/EuT9UYqRqO1V5LyVS5UzasbMnaHSbIkdVjnanHRnN9kMpghtJVD1yImFI+YX0t9SvOMLZVi038m9ZpSV7B+dI26p1hT/dQNWaf03MglDn6paWtjYgRC+du05DF6Pnx/zB6GdWwAjk/ZrFoY0OQMryqQevM4Ii2fLdlqN8nGKHHSsEnxiwOFCOF2LFPVkorsWu4QY+V6gYEyvHuf5mbRUx2wbLm5n0NWFlqfGtM2CUkP9/PuTp8oL4XKs8cQOvUP7kihf6k6bh6y7BTuh4xi2MhfjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JonUF+WaL18+z7oQdkbo0+qdoLJJUhTKGXqwTXbr4eE=;
 b=LZz1n/zi+nlqrAPNekqwhbDFzgww3ar9fLtYm4EZVUiv4YrV/GmHHP4FvWZq308W3KmrJGLHBpedQLMxe8Eaz9gaxQVM0exzR/s7+U4oGqi0WcJTwXNTs1hDLV8MSW+BycHhJo2wKviuQR6oQo2xEBPB6JwAL9fBMbscDRuL4tG/s6BtDlCkHbwXNxVcoxJhWtys0bORJOcb0K2dcgzu5S3F6R0oR7jIBTJzWHY6dcrdGorJVIhuRhH0AuE8Fn6Gsqqre/jzJ93SDFwQRmBLOybpk2qaHYFJjtYWWZIQTgGp19rngnz9GYpsvo5vpR6NpPKjM/CyU+csqCK2mfYdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 15:13:54 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6838.028; Mon, 9 Oct 2023
 15:13:54 +0000
Message-ID: <fad9a472-ae78-8672-6c93-58ddde1447d9@intel.com>
Date: Mon, 9 Oct 2023 17:13:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC] docs: netdev: encourage reviewers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jesse.brandeburg@intel.com>, <sd@queasysnail.net>,
	<horms@verge.net.au>
References: <20231006163007.3383971-1-kuba@kernel.org>
 <8270f9b2-ec07-4f07-86cf-425d25829453@lunn.ch>
 <20231006115715.4f718fd7@kernel.org> <20231006121047.1690b43b@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231006121047.1690b43b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::18) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DM8PR11MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 9100414e-4d09-4371-411b-08dbc8da59e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12DAKATty70Q6oCY/DmfvtR4caEQg0qxwGy2n97SFuVQIkb7ktzRhUtPFm+aDOd2xDftqvC7LS/ootazUj2waGoIqI2i5y9aZLt2tfwoHw3I3q6LgFyXj3GZzOkXZs+7RsqD+xw339wnhuMExgsp/auv9xuG+KkkmuSTQYE85NkIfJvmH8/f0t0Fxs69TPcGa/hwBCvPzj1gH6QcPQGLYngyoPSgQEjemlmQ0lR0hV0Vb8Xgl4QrILkyEhwu8ctvm/IVEmeo/5/Ub6O2NfbMHhtcogC7QJYS19I4Cx6+J995lqPNc9+9nlQ6iVHUK+Nj0eSQOSsa6EDCJw6b7iICJ/926jxZOzUOXlfCI8rZIYezTsiiVCE//s1baaF7Rr3kzom3vj/BhKkOe4/ce/NgXy/yAB6KkMmQFPh7N/fqpRYVhENAcyWRRl6J1V5KYbq2Ak5Xg8a1R1VK9WX8BUW5jQTfOygZdh8GDWfTFUNay2BSN33yVi0htv3Z3XDy8Ow9eHvNf/cvlGsqJFvRuE+FgUK6ItO7mb0k7uHCbmOIVmS3M+EjThcIaT3eGlK8xF8Xpr6CSbUKYJbwnG+W1DLyYC6M7lwfbWtO1VogBqKaU6kiFM21HYOq9sbHt2mQbLjbJmlmNlnLgZDBBW6zFKknfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(82960400001)(38100700002)(8676002)(8936002)(4326008)(66556008)(66946007)(110136005)(316002)(66476007)(478600001)(41300700001)(6512007)(6486002)(2616005)(5660300002)(2906002)(53546011)(6506007)(6666004)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1d5MnBvMGV0OTZWS295NCtoN1oxT0lEekFEc0FsaVErejJGUm9tN1hCYVhK?=
 =?utf-8?B?UkVRRTA0SkE5eXMvbWUxNXlSUDZsamRIVTAxbEVlU2xzT0hYUFFCY2xXQ20x?=
 =?utf-8?B?ZTRpOXR0RkZDU2V3cE5qZ0JxVngzN1c1QjJFOEtRTWE5Q0Mwb3laNmtXdG91?=
 =?utf-8?B?aWtkU3BycENZbmJjRkRLb1NDZTF5SEI1SHBSaFFPN3Baa0U4VXUxTHBONjBm?=
 =?utf-8?B?ZHRQZWYwNlExZDNWRnpyQi9IeWNzMTNobjF0b0EvcmhPNDJhS04zcVo0aTV4?=
 =?utf-8?B?R0tRTnRqaE5jWmtQeisycEZua1ExK3pMUXF5WFArQ2tvaWx6bkNtSUNNQll1?=
 =?utf-8?B?ZVlCV25LNjZjM3B3MjF0ZUNXY0VEZE02V3MrR2RUMkVQbEU5OGY4QWh6aEJC?=
 =?utf-8?B?SGwxMGJsNjVPTUlMbG5WUkR6NkN0MmQxOE9kSHBvRHRnK3h4dWtITnJQMGtL?=
 =?utf-8?B?VmhBeHdOdml2NU5OclZXMEV1YWYwTUd2bXo1aGM5blNacUNvdzh3b3NhRG5P?=
 =?utf-8?B?OEFLY3BmWERTMCtRSTZkbkZYTTV3R2NnS2lTWXZTNm9XaVY1SFhsR3pmZUE2?=
 =?utf-8?B?SFFjQ1dDcE9NVzhZNlZuckxMa21OSVhjQ1VLQlllOXNuZEw0QjNpbmI1enBs?=
 =?utf-8?B?UTRXZzBBQzRxdG1PK1BqTVRSSXJleXc1S3Y4ekg5eklXUmdscEh4MVFzMXNj?=
 =?utf-8?B?Sk5oWndnRUtRUHFJU0c2NGI0bC9ybmpjbUNhL3hBdmNlaWJUUTlseTNBYlho?=
 =?utf-8?B?Nm9EN2xvUERJVFc3Nmp4UzNGWWlvZk45Q3gzV0s1NGJrbFc0cXBNK2JsM090?=
 =?utf-8?B?bFFhTjVFRU1BMk0ram91dTJKcXFmY1MrTWNmT3VLZ3Z3VTB3TlhCYjEyY3Y3?=
 =?utf-8?B?ak9NT1JZbExJTkVWenBtSE9vSzU1RHF5SC9uaDRmWXFvWXVWTFZaVXZza3Rm?=
 =?utf-8?B?SVd3bk9PVnRLTlJFYUZadWZzVnIzcHFhK0taRFk5WElqNFA3aVZzMGFWZmc3?=
 =?utf-8?B?dE5QWStyN2trWVMrUTVCRng5VWxDZDRHZWxCQWRvNUs5YlVFYkF2bnEvUVlR?=
 =?utf-8?B?S1ZoeWdiRzFMZGZaUzBQb0RYYUFIRWwwWWt6RVd2MmM4RmVqWHRqZklKaGoz?=
 =?utf-8?B?clEzcmt3Mkxpb0txV2FIWVR0RnAzRVJXUU9Oa1dlQVpTZFJ5cDRINEg2SVFn?=
 =?utf-8?B?c1JyN1NNaVdCZWx6QXJteloxdU5xTEVUc3NlY2piN3o1YTA5TS9nZHozK1Yx?=
 =?utf-8?B?Y1duMzQvVndIalFTZzR2T2hZUHU0aktGNlVRRERBNGZ0MHZtU0tpRXE3Q2NB?=
 =?utf-8?B?aFU1cnl4MWd6aFVzb2N1TjNFd1E4WFZITStnWWowL1lMdDNWS1dEekxUaEhp?=
 =?utf-8?B?RUtSRXd4TjJTWVNOQnRmSit0TDNtL0JWZ2ZJR203dnRQWTEySjhvTGhXL3ha?=
 =?utf-8?B?dDFYcElMd2M0bi95bVFUdXJvQis3SmJTalpqRGRPTFJxYVRBNGZjbEFnODdP?=
 =?utf-8?B?OFRaN0xPZVpPdGNKeDRuUkJvK09QK1RTaHF0em1YQ0lXL2xRMFFPamMxaUND?=
 =?utf-8?B?eWF1RS83dVlpbEV3ZjkzcnFlZkROSW9acUNBdWhDS3FPVWVobENQaitPZ3dr?=
 =?utf-8?B?SURjKzlxTlhIS1l1dXQ3ZXJFWjlhTHFJSmRvTHZYc1JYN1FXRkxQeUp3ek1I?=
 =?utf-8?B?aGN4YzNuL0lEYmd4Ulh4MGYzUzRqU2s4SkI5cW94VjMrZlFHR0RoZFRHeWVG?=
 =?utf-8?B?azZZZVhqTXNKT0ZYYlNyQ1NjOEtvc0dnSjNpNUV4eXB3V290eWIrM0h5NS9M?=
 =?utf-8?B?UzQxcnpmTkZXQVJ2RUs5dXVuVXl4enB3eTBqcEtqYzdmTzZWcHM5YWV3R2dG?=
 =?utf-8?B?dVZodXZQS3hUMFJHNlBPcmdoZUZpaUhiUFArdkZtSkprZVI5ZVgwU25aS0JV?=
 =?utf-8?B?OVJ3MXBXSUZSQ3YxK2pEaVBsaWtEWXVVQWMrTzdJRDlCQ1RhdyszTThCZzZT?=
 =?utf-8?B?NUtITlhUaVNhOEFnL1VNd0ppSGxkdUtscW43c1MrUWZicGZiQ0RBdTlvVWJY?=
 =?utf-8?B?dEE3RnN3dkxadWxFK29NTEFyQUxXTVNHUkI4YWtnWmQ5bjYzcC9NWUw2SXFP?=
 =?utf-8?B?b3UwMFNSOS9Ca1hucGphTHN6bUQxUFhMYnB5alRrU1lSRDBUMVM5aURXdGl3?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9100414e-4d09-4371-411b-08dbc8da59e0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:13:54.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/j/L2OJSdu6/COv7rix51sgbZRCf9aCAXWLd4LBfmbHxm3m1Spsr4Kl9RLnCaKQ/ccV8APQK73UiyKuwvjGtAon19AY09PCxOkk1UYiBuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/6/23 21:10, Jakub Kicinski wrote:
> On Fri, 6 Oct 2023 11:57:15 -0700 Jakub Kicinski wrote:
>> :) If I can't get it past you there's no chance I'll get it past docs@
>>
>> Let me move some of the staff into general docs and add a reference.
>> The questions which came up were about use of tags and how maintainers
>> approach the reviews from less experienced devs, which I think is
>> subsystem-specific?
> 
> So moved most of the paragraphs to the common docs, what I kept in
> netdev is this:
> 
> 
> Reviewer guidance
> -----------------
> 
> Reviewing other people's patches on the list is highly encouraged,
> regardless of the level of expertise. For general guidance and
> helpful tips please see :ref:`development_advancedtopics_reviews`.
> 
> It's safe to assume that netdev maintainers know the community and the level
> of expertise of the reviewers. The reviewers should not be concerned about
> their comments impeding or derailing the patch flow.
> 
> Less experienced reviewers should avoid commenting exclusively on more
> trivial / subjective matters like code formatting and process aspects
> (e.g. missing subject tags).

that should be taken for granted for experienced-but-new-to-community
reviewer, but perhaps s/Less experienced/New/?

> 
> 
> Sounds reasonable?

yes!

other thing, somewhat related:
I believe that I personally (new to community, ~new to Intel) would do
"best" for community trying to focus most on our outgoing patches (so
"pre-review" wrt. to netdev, but less traffic here).


anyway,
I feel encouraged here :)

