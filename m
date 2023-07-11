Return-Path: <netdev+bounces-16851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2316974EFF9
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2ECC28165C
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF418C0D;
	Tue, 11 Jul 2023 13:14:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C074182B6
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:14:41 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAFFE4F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689081279; x=1720617279;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jKhx2OiaZ7P1DjUgN3CH85Q1hduuBIii+6sDRURLvh8=;
  b=FfU3Z1rR/Lga/DAGVDYkcGsK4poIhuA0zpqk364oop3A4qQzY0jWGRSS
   tvoB411ZbyXlW/o5szOaP0/y4nn8p1ap1D05q4Y/SIGNKL+/R+TVxX+e8
   Pb7Hd0bEPYq92J4xKYNY4VChWgbF41nNv9vurBFCNFensrwsh1VdcezEq
   h1g7NfS9bFWOpGuKXI3e+Cot6qpI4aqznmaH9wo3EEOTSTWZBZoxuSubJ
   NqowKtAZjJGWA7ea2kmb7DY8sRlJX7yUgu10SrQw6CpDQah7XbCJJYl3k
   ee5qOBPduafHWOG/iZpryo4sxDrx82jh8aENS/3OCHA6HQI0IzQLtEYv0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344210657"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="344210657"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 06:14:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="1051774806"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="1051774806"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2023 06:14:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 06:14:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 06:14:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 06:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOi6iKgT106wkgXJQtKCIyzy8JPMHkI9WAUYwIzdJjf/DXhtkCutz2v8Rv8d1WsSOfGslAjSpYl8O/qdTwR5Qse80rYtpjvC1a4arb1XyKzwXEQgku+qeQL9A64M8jSxnzgo1CplWBTJHxGvhb9sx0lj68qI4rC2+zTZdutoa297xfnZnwFGQJ2IUoz2wzvU8/SAiL7gKxGlRC11gk0a01F9jWe6IWAviMKoz7zPPnlhlvetAK9GCzr6Jl96APFGzH0tP6GuvN54OF/DSgM2gcErAukTqzhg62WOeF3A9eiLt2wfk+M1P4SHOgsYwgKgmBTyeK6UikCWSx2zd/tpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKWt1SK0bj9NnnUZ2ohZ/KIjnznpKFg2oIjxV8OIiqk=;
 b=S9qXJ8u1QOt/phMX3lOsaSOFo5vf5Ayon+qCsmi5xLgmw+SvnocPAB5z86BlO16zI2/qDn1SUMpUleUhy9UDoXmZddc9tUp7DPbpstZ8Vs2ct3sQLlEM45Q5nP1CC0se1wIRVECpMqSVO076qsdTZ2bVwSNDXllb7/5h0jMrJ67DJxypZNgl1du5V9Bt9AqI/JMalc52g7JUB23HqgTC0vqyB+G3yCZxX4BwJcU7gn82Z6io+6+r2xv8MIKBpjzwT+4gyKpDDplaWmnMO/vxu9ZhXT7NP1M0/pLj/qlpVfpZddkxsXEz9IIZkmB2fWGLe9YJ5zFEIYmOY6BHNlNh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 13:14:32 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 13:14:31 +0000
Message-ID: <b3e340ea-3cce-6364-5250-7423cb230099@intel.com>
Date: Tue, 11 Jul 2023 15:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] gve: unify driver name usage
Content-Language: en-US
To: Junfeng Guo <junfeng.guo@intel.com>
CC: <netdev@vger.kernel.org>, <jeroendb@google.com>,
	<pkaligineedi@google.com>, <shailend@google.com>, <haiyue.wang@intel.com>,
	<kuba@kernel.org>, <awogbemila@google.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <yangchun@google.com>, <edumazet@google.com>,
	<csully@google.com>
References: <20230707103710.3946651-1-junfeng.guo@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230707103710.3946651-1-junfeng.guo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::11) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM4PR11MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0f9613-034d-4fe0-4ba0-08db8210c386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDMmnI7SPM8Pl2solTLyt4XoTcTF0ouLygqVAkTSp8lha4d1UxieK543KiEFCw4LC5w2WSbTaIJobewsqJPRRPwnIzmKrEep4dvCNYkNVshf2++85cgZDk7aZKIn8xfqkP7SUB+Mg92+TvshjcivGkMETVtbFqs/bCFGRdWcp+lriijYpNpCoqeU0srNeZnwN5AquOdqWK0RDc5EsSXUh1Woj81uYgtbSo53Shz+bFwQSMAX3TKYWX52PvuzxNZg8iuYCzw84zWNSIIIe63Gs4YkIoCXLmQnOlBCMA7HLsnVOpojMKq7cUrrPhqp3wwHa1gfiVOQostkHcdW2pcxbRbljxxSkeKCIT2nz9yIJj1b2Jg9ulp72aeLupspl7HhDyHttvVym3/sEPJDDndKsOuOkzlrPM1Tb2FKxmzrKiZ8SZd/Inx2BVKOlJzUzkWIEZTKZaHHISF4a7PYsZl2Jrprezj7942+Z55Dco569RrJ8eUuJNDDByZaZE/tn5TIFRqeiJznNxyN//IeX3PcQCpW1t6iuvDPiAexSVges9Xu14WXkwCYG2JIuudPzDf3yEjcR+jTaCq8ii18N3TwOYVfKoirkr2A8u99XZ27ZMXCi+qwgQujEN3PFdw8C9JTtCBavy0G2NV8OwE8i1Byug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(2906002)(2616005)(66476007)(66946007)(316002)(6636002)(4326008)(6486002)(83380400001)(37006003)(66556008)(478600001)(5660300002)(7416002)(8676002)(6512007)(26005)(186003)(6506007)(41300700001)(8936002)(6862004)(38100700002)(82960400001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHhqRzRPRXFFc0lyYy8rVW4ra2xpMDRsYVpJbENSZDVwN0JRTlVCb0kxL1VJ?=
 =?utf-8?B?UHFJNkdENTJkRExNNUs5clNQczNJUTdxbkNwazFrbnZ0ZkRwakxEK0xCOWZh?=
 =?utf-8?B?NFYzMTFrKzJNS242dVQ1aEorY2JLTVBRNHkvRzNrMHlXbURjeCtmWVQ4bFRC?=
 =?utf-8?B?dVg0YW1uMlN0RlJJelh6UUptNWlkbXVJVUZua1dZVEhhSTFMLzJNbUovZ3Jp?=
 =?utf-8?B?YWcrYjdrZmdkWXV3c1dUeXpzS3U1UEh3dmJhSjRQb2M1WiszdG5KbExDMDMv?=
 =?utf-8?B?bGVkZ3Z4V0FoWHFjd3NPc1BYajFhZ2U1ditabjErOEZwckdFU2dFRWZQQitZ?=
 =?utf-8?B?Y0ZHTTFRM3d2bW1ieFZIWTBOSXpmb1h5Y2l0VXVtUkc0cFpJTmE1bHgrNnNZ?=
 =?utf-8?B?OW1lNHNmRTJlR2tTWE1QQ21LWlFBYUdoN2tZM2dSaUJxNEk3RkR0dnJ0bUh5?=
 =?utf-8?B?UVlHb2pLcVN0RjIxb2tnNXRzdDhiQytxN0FGMVhmQTFmVU02YUJTalYvV1Vn?=
 =?utf-8?B?NEg0RklxTEhzVE1OL0tzSEdDcUt6ZTIyazVlL2pnRWxYU3NjK0RSNGxsMHgx?=
 =?utf-8?B?NTM5TWw4ejgwVTVRN240T29uQ3M1L3o1Ky80c3dYSDFkWlNoeStLbTJ2aDZ6?=
 =?utf-8?B?Z21sYTBEdWgrY05mNDZIRFphWGZlemJ3c0Q3UnBnUGl2SVVYQ0NSZXd1RXF0?=
 =?utf-8?B?dzJKaktOQmgxb2tvR3VGcGlBTC9ZYkRtdlVBeCtDWVJMNjhXQkFvWFR3M29y?=
 =?utf-8?B?aEdqM2hzZEtoV1hYSDJxMEF0VnMzbG9OSXJlUTBJMWgydjZrREgyNGtxZ1NO?=
 =?utf-8?B?SEpJVmxIUksvYWVEYWJ2UUFJaTJwb29iRUVlSVRhUUo3QXlJeG16QmlXcDRj?=
 =?utf-8?B?QzZuVVNaelFldHJ2Ty8xeGk3WTFxdFdjQWI0NzhZaHJHWlRPRmRGQjY1Kysx?=
 =?utf-8?B?THcwWnJGQWNWdHRkTjBjMGFubWZma3BEZGNIN3hZQm1VYk1vb25WV0JEam1l?=
 =?utf-8?B?QTFFTm4rOGI0YnMrWGViTXV6Yjh3azBxM2JLMFZQMFNyMmo0azZjUFAzdEp6?=
 =?utf-8?B?d1VUcHp0Y0JUNXZFMDVkRTVkWUF6SCt5TW9odlhqcG1kK0U1ajlZc29SUXVS?=
 =?utf-8?B?dzVhbHJVVnMzVXhHNUQxZEk1ZDQ2SnVtSnlSYU93U1lUUzlPTTlNY2RHVTY3?=
 =?utf-8?B?YlB4NGh1bnUrZHYyWjAyM2Y1UENnL0NUQXlRb3QrV1pvWndOODVMNkxrVUpF?=
 =?utf-8?B?dGpWQWMzN0JOL1ZiZ0pNMVVxYUFYM0FTdFg2ZzA4UmQ0TldpUmdJdmZOTnR3?=
 =?utf-8?B?Q05LRzBOa1JYT1QzWGNzUnFUQkdEU2grd0lyNldvNFBOOFhtbHVidVdsTlFP?=
 =?utf-8?B?akRmWEpHa2tlOGtNV3pVTE1wdC9aWlhSM2ZLdXhDbTNueTRURW00ZmtSM0lM?=
 =?utf-8?B?SjJTZFFHWE56Ym5qN1BXdk8wN2N0OHkwcnNpN1JzWDBOcTNrcDM5SlR4OU5X?=
 =?utf-8?B?alExWWZnbG41NjRSeklkWTM0ano4OVdHWUtiUHhkQVp4T1k5WkZmMFhFZlY4?=
 =?utf-8?B?cDE5K2UybnpzKzFJcUhBVlpKOFBuRElTTGtGSnBPQTJqb2F5bHN0QzRtREVY?=
 =?utf-8?B?d3BiOHdab0N2V3VnZGwvNkVrOHRKbnBMQzE2VmVUQWwvZS9kczQvUHE2U1BY?=
 =?utf-8?B?L3l5OXNXVTdzYUEvYlNxWHZWQStwdHRXY1A1bGJOOE9GOUNFbExNVzlBenIr?=
 =?utf-8?B?VHJJa2ZpS0IvenpJN2VYUnlFOTdDQkcyMFV3eHBJT3N4dXVhYWVaS1Z3cm9H?=
 =?utf-8?B?ZTVPdTFWS0YyT1lmUTM5d0k4Q0pXaG0zU1h6WVUrbFRjblBiSlltcitGaG1P?=
 =?utf-8?B?cjFrRnRxS3NPeTJlNlpjdFVqQ2RhT3JiaDFKT29ueTMyelhxaVVZdEF3MVJZ?=
 =?utf-8?B?aWFOenMzWEkyOURtMVlXOWx0ZEhydlpLeGtpbWZ5VkpRQkp2cm5HYWNlbFFv?=
 =?utf-8?B?Qkk4dGpCcDh2dHBKQk9nK25aQ3BmWHFwcEd2U0RhZEQ4VjFORmZxVU5tTmFF?=
 =?utf-8?B?Mk5aZlM1ZUZlUUtaUTNvSG5sOWVyMzlEaGJpZ2kvYUNiZVRwWVV0QnhzYzU1?=
 =?utf-8?B?Qmp2UDByZ0lwdGJMeURGVVcveUNzdlZlS2s4RFFKZHh1dXBRRjQ2K0RCWVRS?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0f9613-034d-4fe0-4ba0-08db8210c386
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 13:14:31.7202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7jyEnNMmgNM+glmNdH8uqJba2KNU2mJjSyJ2OfuSDiK8dRWR+YSe9Kg+fSU7/uxIZNRV+GQIIV63R7dikizUiuzJKWyjl94nJbYPr0r8a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6189
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Junfeng Guo <junfeng.guo@intel.com>
Date: Fri,  7 Jul 2023 18:37:10 +0800

> Current codebase contained the usage of two different names for this
> driver (i.e., `gvnic` and `gve`), which is quite unfriendly for users
> to use, especially when trying to bind or unbind the driver manually.
> The corresponding kernel module is registered with the name of `gve`.
> It's more reasonable to align the name of the driver with the module.

[...]

> @@ -2200,7 +2201,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (err)
>  		return err;
>  
> -	err = pci_request_regions(pdev, "gvnic-cfg");
> +	err = pci_request_regions(pdev, gve_driver_name);

I won't repeat others' comments, but will comment on this.
Passing just driver name with no unique identifiers makes it very
confusing to read /proc/iomem et al.
Imagine you have 2 NICs in your system. Then, in /proc/iomem you will have:

gve 0x00001000-0x00002000
gve 0x00004000-0x00005000

Can you say which region belongs to which NIC? Nope.
If you really want to make this more "user friendly", you should make it
possible for users to distinguish different NICs in your system. The
easiest way:

	err = pci_request_regions(pdev, pci_name(pdev));

But you're not limited to this. Just make it unique.

(as a net-next commit obv)

>  	if (err)
>  		goto abort_with_enabled;
>  
[...]

Thanks,
Olek

