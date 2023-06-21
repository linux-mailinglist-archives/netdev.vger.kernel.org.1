Return-Path: <netdev+bounces-12797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD5738FA2
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065C11C20E9D
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8F119E45;
	Wed, 21 Jun 2023 19:07:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FC846D
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:07:44 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA78171C
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687374463; x=1718910463;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p4CfBcJ0FZ/x8gkC6wLcYan3QYK0boAByILPzn+f7mI=;
  b=HPkWVI6oHVHphDroHPWJsIdr5/raSB56osVCkrei+KQFGRk80tlwiM59
   4XRYZbAAQqY0fRl9dAwrvqU7lV9X5kjUIDETql60yjCBJOjSifSrC2THY
   Qi4ctwvZ858nuo6d94/BPTI879jUIcoGwivr/X1z45YySdG5zp25QOzCK
   d1ij+fobERlPGkalgM5WNXE/xJ/CWykACQqhZNhjikP+0s+zaGUbnuvQ9
   ybwP2MRdEVfezIsg5C9Rc00yAFDeN6Tus+gv1UFyZgwF9Z89Uye9gTq1m
   JFsnpBHjLRH5LC/kZtAAzUOK8Anz9v9eAcepIEfeECVzCw+1nnG8DUQ6h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="357772998"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="357772998"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 12:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="1044848029"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="1044848029"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2023 12:07:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 12:07:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 12:07:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 12:07:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 12:07:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfEKxDd0yZ1lFhrmAmi3MiLG8mZsdvbHgoPMIF6DTyLTKOc83cn65B7nPs4mU6hWT9jX45IK0SRXhQcHtkx7j0HIzVUdGQcM8OKjub4DypcZ1zXc/k/Lpivy3cYgtZ2QICe/qX/scfZJZt3Bk/+azjHr5mM49D52+Ph+c0sh+B6ca4n3ca2V6h2zm1V9rJG9JwajqcvdkPVMVuncmG9cX6tgdcNEnxMtV9HRGjLnsYQj15mo0LxH+AVXCvLR303TgGmlrQmwCs6yN7jgo1s4YFVzEIBhEPrDso9GpOGwFXZrUJjmGYKuvO2Qdpg1T2zJR4D9uZ1anBBXrpgovMOCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Co3QOIKonftp1KGl9sdZtulr9qKtbqz+5NgJlZ2vSW4=;
 b=l4b5QcskBl+pLvoTtvg14w/sNJly9SDK0Eapxmn1diVgHsOUmbuSX/R9aZcq+XwfuSxJYNbKZv1LbIbuu8UEl5B+tm+eKLOR/FE+nfKpnJdhMw5me3g8Gcajud04PU0NpyJMcimKEZt9uxAmX1RZOJJq93DVskyBnLVDp+rEOgDqb2XpbwO/Vf4GGdt87mpTPgt8EqBcvJHETZZthsMZowCVpsRMfNwULRWiIDa+mzlhyVtK/KONntOnNVBP6d9qtMAG3wkH1Jsog2ZmYuTrSIIThKcjqJZhvBsp9jQLXS3g+QyqYFhDIU9GToT+E9dL2MDDcMvbXn4BarMbzHqkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2599.namprd11.prod.outlook.com (2603:10b6:a02:c6::20)
 by DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 19:07:38 +0000
Received: from BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::ab9d:1251:6349:37ce]) by BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::ab9d:1251:6349:37ce%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 19:07:38 +0000
Message-ID: <bca91094-f349-30e1-7835-80a5069c2ca4@intel.com>
Date: Wed, 21 Jun 2023 12:07:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Subject: Re: [PATCH net-next v2 04/15] idpf: add core init and interrupt
 request
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <emil.s.tantilov@intel.com>,
	<jesse.brandeburg@intel.com>, <sridhar.samudrala@intel.com>,
	<shiraz.saleem@intel.com>, <sindhu.devale@intel.com>, <willemb@google.com>,
	<decot@google.com>, <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>, Alan Brady <alan.brady@intel.com>, Joshua Hay
	<joshua.a.hay@intel.com>, Madhu Chittim <madhu.chittim@intel.com>, "Phani
 Burra" <phani.r.burra@intel.com>, Shailendra Bhatnagar
	<shailendra.bhatnagar@intel.com>
References: <20230614171428.1504179-1-anthony.l.nguyen@intel.com>
 <20230614171428.1504179-5-anthony.l.nguyen@intel.com>
 <20230616235041.4d3f99fe@kernel.org>
Content-Language: en-US
In-Reply-To: <20230616235041.4d3f99fe@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::20) To BYAPR11MB2599.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2599:EE_|DS0PR11MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3b89ad-bb1f-4d50-f0e3-08db728ac7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jm4Lmfy31gf+NN0cwaOTaFGIUWv5hUI5bKzQZ1XvTqTp97TLDaeNJXgwIofFKkoHik2V155RduA2AKClsnXDLAzvrukSKnUTb0ZLbx+/MDeCiS3e3bvT5V09jL0Mq+g1HUrr7ILBjraHZE/BF4xTAyk0XMyRqLCdxOkbnVmxtHQE3/O/54DOguOBrf2xR9q+rXAENhy3uRKPAf6l5kXa+yzQhMtxvhjApwkXcvrjgzxLpu47Zdd3MB0V2ZKO4GjXiVC+DLo1JvqxxiXj9hEMwHHp7DNp6774pXNng8FF33YYZ6KTxCCIXsPfbAeKG0euTwlfg7S6IDQRJ5QfEhdTBRmgm/dYDoZqP0wY5cr/a2iiElZ90tJ4u8NVs3RPUfEhFXirjnTzc/ScCTHXQARBcY3IHCzdQPijHpqUO9RN4iY64T8zGetE7JFPVYZIkYMqoZMwSkuxtXvEwEqM6xNNpsr4PdvFKLveA/dDJ5pNcRVpqTYBIbRekotPumF1n5DE5oyS9sKi1B6uRZ0Ez7YQpqAZNqa5Uwtegky4FxmsFRtWDL03WX/YkwLCRNHJQ5mjKDY7aFaDK++ldocC6xZd8Nn7YbJGjhtDPv2F0jExacEOkc6KVShEsTM6L2PS4laF4stwHC1MW1Lhygr4g0nMHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(31686004)(36756003)(66476007)(5660300002)(7416002)(41300700001)(38100700002)(8936002)(66556008)(86362001)(8676002)(4326008)(6636002)(316002)(82960400001)(31696002)(66946007)(6486002)(107886003)(26005)(6512007)(2616005)(6506007)(53546011)(186003)(2906002)(6666004)(478600001)(110136005)(83380400001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCtlUHdaVDlXb3VCOFJ1KzZQZ1poaUpuZENZdkhCVjRYOGpIVkp0QXp1MlRR?=
 =?utf-8?B?bHZJS2JKa2RnZEU0WUhZUmtuK25sT2ZZT0RDaTRzdWlYYnFVeWtVdUVOSTc5?=
 =?utf-8?B?eEtaUWxoTWJWb2piaFdVdzAwQlNTNmd1NXhUdEU2aTdnaFJuczRWbUVMRXdk?=
 =?utf-8?B?N3NNZWtPN2VvUkZXcmtpSldOY0QwYUZycWo0WGVZVlA3bVFMVVlWeWpYSlky?=
 =?utf-8?B?RDJGc0I5RWk5cCt0RGl0UmxINUhLZkZUKzlkR2YxSnJUbEdnei96SVdvRi9F?=
 =?utf-8?B?R1BpMWxLM1IyZzQyMUVkaDFYZXJRWUVwMC9iaUVYQlFCaFpCYmtJeWdmSGpx?=
 =?utf-8?B?dU95Tkd4NEtFQVFWc3NMTzBiQ3dxVXNncEpacU1aQnlUaEc5TkNFRGV6WndB?=
 =?utf-8?B?d056cjJ4SlQ1U1VqK2xjSC94bEt6ZXhXOVBMVEI1Vnp0ai8xSVlxRVI2U3Vo?=
 =?utf-8?B?aG11anRQOElaWTYwN3hYVTQ1V2UraHNDMVo0K28rRlBKajFPWmpKNlF6dGpn?=
 =?utf-8?B?MUJHYmJRY3FFdGllM0V3ZjBJVkZJNko2ZmNkKzBlam15QXJuNWwwb2FPVkF3?=
 =?utf-8?B?b2RtNlk0d3U4WnhVZElsVkVOTWcyUnRJb2k1Wit5bGJBSlZPRVFCUCtXNXVn?=
 =?utf-8?B?QWVTcndyNUlySFZ5c1ZYb0RDQS9nb0xqTHFaY3NRVnE1RXBjRmNJU1JFMlJL?=
 =?utf-8?B?WlcyYVJkNjEwQ2ZkU1NBY0JlMjQ1ZWNHRncyTnhBSm5rZUhscWVGREFPVitN?=
 =?utf-8?B?QXZCOVZwdWluZGdzT1c4eWxuS0s3RXNuL2dHOWVnN1Fub3lZWnlZR3FBZGZl?=
 =?utf-8?B?YnpxaFd2Z3RrL1ZIelZiZzF4WFY3dWtPbEF3K2ZzbWR0aXlxbzJPUUdWYXha?=
 =?utf-8?B?Z2lkdmRzWXJPaW5Za01zQXhybFpWbnZ4RTBScXhQZ0lzbnZvVktXVUovSTIw?=
 =?utf-8?B?RUcveDBHdUJQUWl4ZGFGMzZmUG5qcEt4S3dHOURGdnFLcjNvRHVaUmFTSVpQ?=
 =?utf-8?B?bWJrV200eDM5S1o5VlREZjVtQVp1TDRSSUJWK3REVmtsZ2hLWlJhTlQ3Qk9o?=
 =?utf-8?B?R2F2ZUY3V3NoS09nU0g4S095OERDR200Q0RsV2tjQ2RBNmJCSkpldlZRVzdB?=
 =?utf-8?B?MDUvblpSZE0rYlFtNllSTTVnUkl4aDZyTnhwSUt6UzFPdVdyR3Bzc2F0cm9z?=
 =?utf-8?B?UzlQRHhVZ05ITXRjUXJwK3BraXV2NVpTVnFnSTVnZHNuVFNhVTZmcHd4dk9C?=
 =?utf-8?B?WFRPcHNXak1kd3kwcklZSTMwZ3BKVGdrRVhRVEdpRFRnRGZIbEhHdmt0WWFv?=
 =?utf-8?B?cmI0SXFZM0FML0lIQlFGSi81WHhmaUJmUEZBRXd3Q0JUeEFXTlhMaFpNNzFp?=
 =?utf-8?B?d0lzMUdQU1hVcjBRWDNFOGtzTkkzcjJKOUFBSHFZaWNrK1FVd2oyemYvNmt4?=
 =?utf-8?B?SW8xWHFQREVhRnBYZ1dYL210YXhrV1ZIVTUzZ2dYcXpIVjBUeTZFaUVuMm5m?=
 =?utf-8?B?akdjUENMcE54UEp1SWZ4S1dFSEt3TjEwTW9TRVpnOUJYNlF6NDJLbjZJN3VE?=
 =?utf-8?B?VHZYZ0ZCbEFKU3ZzUTNXUENQS3N4YXNTRG5xMFpQOThGTG9zeG8xQ3NOTHhL?=
 =?utf-8?B?ekVxcElOa25qYllJektDbERFOU54UmgvZURteFdySm92citYMkQ1Z3ZvcW53?=
 =?utf-8?B?Nk0wc3ZhVDd6bjh4S0NxdU15QjdmZlJOL3pBMVZkSUwwS2pDU0ZnR1p4Wm9O?=
 =?utf-8?B?cmZlSk5XL2JjN1RxblVIQW9jajdJaW84QzJPVGNrZytuZDBVQ0RnUVgrNi9s?=
 =?utf-8?B?ZDV5MS9BSmQyUzhKcG9oL3RoZFp6dVBvVk9wd1AxdUpDeCtaVC9pZUo1YjVD?=
 =?utf-8?B?R0hUT1UvalFqK2Y4N2pYMCtZS1RjRUNwTWZPN1FoaHUxNkFDNUxWK09zTlM1?=
 =?utf-8?B?MWF3L1RnbXJRUGwwa0U2Z2x4WnQrT2FuUDlLSW5ERm9aZTFqYUdqQWtyUm1H?=
 =?utf-8?B?ZEdEaFdRb2tSYlNvb3hvZVBiSDdBaCswNDRPN0hEUEdrUm9kVThSZ1lGOGxE?=
 =?utf-8?B?RmpGNFJkeUFOTVhvOFQzaWs5SWRXWHVrODFpVjhsUzJEazBNWmFicEhIOHFK?=
 =?utf-8?B?UFhFM2ZUajdhWSs5d3EwcC9TVkgrdk50a0YxM1pVZE1RanRFa2I1UDFyVU12?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3b89ad-bb1f-4d50-f0e3-08db728ac7b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:07:38.7053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0gBSh6j1oKi09BtUxSLNL4fMfc/6MSDIzfZzS0zlhbBDZN17SXUqIqgzkVx24ILmcmU6FYpthG2sRuJuV+amN39XZYsIAFemEK9d1EbENY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8205
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/16/2023 11:50 PM, Jakub Kicinski wrote:
> On Wed, 14 Jun 2023 10:14:17 -0700 Tony Nguyen wrote:
>> + * @IDPF_REL_RES_IN_PROG: Resources release in progress
> 
>> + * @IDPF_CANCEL_SERVICE_TASK: Do not schedule service task if bit is set
>> + * @IDPF_REMOVE_IN_PROG: Driver remove in progress
> 
> Why all the X-in-progress flags, again?
> 

IDPF_REMOVE_IN_PROG is used for the conditional checks to indicate that 
the rmmod is in progress and there is no scope to process any hardware 
resets if the bit is set.

IDPF_HR_RESET_IN_PROG is used on hardware reset to not send any 
statistics message to the device Control Plane and to avoid releasing 
the configured netdevs if the bit is set.

After taking a deeper look, IDPF_REL_RES_IN_PROG does not serve the 
purpose as IDPF_REMOVE_IN_PROG already takes care of it. Will cleanup 
this flag.

>> +	set_bit(IDPF_CANCEL_SERVICE_TASK, adapter->flags);
>> +	cancel_delayed_work_sync(&adapter->serv_task);
>> +	clear_bit(IDPF_CANCEL_SERVICE_TASK, adapter->flags);
> 
> Pretty sure workqueue protects from self-requeueing.

Agree with you. Will remove both CANCEL_STATS_TASK and 
CANCEL_SERVICE_TASK flags.

Thanks,
Pavan

