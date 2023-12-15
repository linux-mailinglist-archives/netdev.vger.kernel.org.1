Return-Path: <netdev+bounces-58066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8B0814EE0
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 18:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856F41F23A5A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B73A82EE8;
	Fri, 15 Dec 2023 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Onau576s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E830117
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702661534; x=1734197534;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qtls/8aLnfmVOnI8U+CH3aypWPYCwphwWE3kroV/QFs=;
  b=Onau576sqhsl35IMGum+KRzZ6lktE63ITXLAtFY/Crdu80uyNDFSdTCF
   QgTUmYBi7ZypxLfsVtFzo+cRPP1ro012DHFfOlWXW1azSBNUE18ui+4+j
   3fRWYc17MhQZC7vt+ItQS8bQsnsYZ9DYu70Rp0SYrPIgaUGCG+BC2wbRf
   S19Yyiw8QnHuXtzAw2wYeqndicJuxcwbmYYSRNt9Jc5XvTLsj6TnQtOi2
   3rvVkmYa24+sDkfNvzrGs720VSeeXakHxKTisk2vn+q3QXYHYycdmywS2
   ARyr7DBXMfVrlE9mlc9rxvtFEWMvvNkVSvWoiICx/cv2QA3gNoFHL7zJy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="16856851"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="16856851"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="778335250"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="778335250"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 09:32:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 09:32:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 09:32:12 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 09:32:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNbZt46qqCER6pPc2+6bKCCgV/DTSFOmID5BE79TDl17jnPDIIUGlwY/Nrc9/llQkLzzaRxnM3pB1ccVS5mWd64BlsvbFwJZZsLD4HsgGvS2OUSkfEPVmx93kP3YMSzb4gRHQYlMGd05sLPNKu/Z7rTM/avVXAJuITkj3p/VglJdlcldUHyZXsK/1vAvP3X5k7ENMjEPuK/6GaMCcQTNfINEURlklxOxMO8lYGeAPx+pnOUvh0FAJfnF8oqAm93J9cngnBsa9nWrZeusdCXmMHfLEwnZ8IiBHjWvpjpo0LuTdxMiY+lyKfqLnh7oSgttmN06cIqXjKGYM7+5jAPuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RphKDH4nNNoUXH+LgEpbULf403zFTXaeYvL7zq+pT2o=;
 b=MLxaR6hasO9zaE35Mp1D/PZeVv9xwiwFtO+8cc4A4ozoeRSYGaJAmbHbi/E4oM5DolgdsWZ63kMvnbI5hxV7hVCdmVY3A2+UHXl5QfcUQz62pDQeVPkAXp3g61HIJhZv3tFNTws3hd1N1C3x4UgLR5kZ/stE8AyVKxRHycSEnwt7zM3BiTA7U+5T8r8GPIumadX4SflD3l1fvj+VrIcTaJvmqt4gSdKkQnu5ndQvMw2XynrI6Rtkp+i4HKD5fYQ0pm+rePRFO/UkiytFPaqRzqsq2QejnnO4BuZJ/ywZUhZlqkStHPiQfzE53Rj9Iw5s6asXt9J0KZHi+2oem5fJ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by PH8PR11MB7072.namprd11.prod.outlook.com (2603:10b6:510:214::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.39; Fri, 15 Dec
 2023 17:32:09 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::dfa4:95a8:ac5:bc37]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::dfa4:95a8:ac5:bc37%5]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 17:32:09 +0000
Date: Fri, 15 Dec 2023 18:32:02 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Joshua Hay <joshua.a.hay@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<larysa.zaremba@intel.com>, <netdev@vger.kernel.org>,
	<aleksander.lobakin@intel.com>, <alan.brady@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: enable WB_ON_ITR
Message-ID: <ZXyNklin95kqbpMp@localhost.localdomain>
References: <20231212145546.396273-1-michal.kubiak@intel.com>
 <78ecdb9f-25e9-4847-87ed-6e8b44a7c71d@molgen.mpg.de>
 <ZXmwR4s25afUbwz3@localhost.localdomain>
 <f5b560ed-783d-49fe-ba51-c4f77e30c479@molgen.mpg.de>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5b560ed-783d-49fe-ba51-c4f77e30c479@molgen.mpg.de>
X-ClientProxiedBy: DB7PR05CA0009.eurprd05.prod.outlook.com
 (2603:10a6:10:36::22) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|PH8PR11MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: edb8674d-5c37-42d2-5040-08dbfd93c3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cG96kGSlhMnbMwmWvhbZdCvWo6uI9azKXw7ANN+EA0zhcdpvis9F0iZLcsgM7OmOoIs43b/qHXCigGjEUIbGryeWgdDDWQSNUjIEXE5n+XIxe+HG5vB+4ASb2WYenNp+qdBHvPly7o7KA2bEExzjIBusnQ8gLL0p7wpeWnGuBwW5UHjZQpHqBuE8UDPf2T7WQwdTzOaUH+k4Btqz4LdegVyQby4QKhbZI8KX8iOZgw2RAbPAfVwQVqJAXfwh1vHd43fW/OkdjPzguIOYrho3+kAg6FIhda/q4z1Cn0Zfwga+chE1YwnWu6GVY+67p1LTZEYhbUTZJkrb2D4LGVRU9GEQDkklINOl9SmfPTqCRFv/g4GxvwqX/75joFPe4ehigZX1vfXj5ZJ/Tbj7wsPwf6Edu5WhqAeIMQ5tlmyXBAY+pfdLnZWf0SPvS5vsZ+3uLiDbYgy7TVaE+k5rbopsIzmiIFh8tT+5Ul8s7jgAtAVeHLu3DlSaDJ21z0PomrFQUnmP+LsOJDHu2xzkwuBPZY91ePMRYd4Sd78BmyrC8aHF6aPd9kNhjt9UZxsxZ2lO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6916009)(2906002)(316002)(26005)(66946007)(4326008)(107886003)(8676002)(8936002)(6666004)(53546011)(5660300002)(6506007)(6512007)(9686003)(82960400001)(6486002)(83380400001)(54906003)(66476007)(41300700001)(38100700002)(66556008)(44832011)(478600001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkYxVnV4bVF6eVJuVzdZN0xoekxRVDNHRlJHMjFTKzlsTU45a1FHelphak1P?=
 =?utf-8?B?YXhCd0dmS2FaTGpsUjNmUWhuYWMyRUZUbndXbXVLcDV4YzRVZW9jSUFaWERu?=
 =?utf-8?B?THZ0SW9ORkdvWVNkWU1naFpWUWJSUW14elFxZnNOME5BYUoyMnF5UTNDVklJ?=
 =?utf-8?B?Zi9EZjJLRDA1SDFGVjBhazlHWHF6VkNRQlFxZ3RCQTRvYXkzNi9NaW8zdXlI?=
 =?utf-8?B?dFQyMG4rT0xlU0tUbHhmZXlvVUdRdTRJVUs5bTl5MVRqZG9VK1NPNDZNTVJI?=
 =?utf-8?B?aDZ6akZSS2l5ZDd2UWZWVjBrVE52NGVEY3lNbjRnNStuWFdyeEFLVEZjc2RM?=
 =?utf-8?B?eEw0Z0szQkEyWXhSdmxIQkg0RXZSUVM2ekMvUTAvNlhnbkhUZkloTzk5WkRR?=
 =?utf-8?B?YVZiRDgxWGlaQzVldmcrenFkb3lKMnQxSkFkVGtvdko5S3NkdXZ0RFZCQk5l?=
 =?utf-8?B?SnQ3aVBreC9OMTVaRWlCWjI5Z0RVMVh3bjA2Y0JHbTBkZ2s4aml5WmRtM0Rj?=
 =?utf-8?B?ZWE3cUlhMW9nZzAwKzcvWk1GUzFjQm9MbGdYNlhqbS83ZitkbnVyMFMvMzZT?=
 =?utf-8?B?UHlmSkdONFJrV3ZoSDNGWkNqMU9Fd2w5VFdlcjRXM2ZJODhwRW0yQTVzY0li?=
 =?utf-8?B?WmxQbTNoQ05uTlp4TFlPc2Q3czVuM3oxS1ZrS3o5d1lmTUpuQXJWVzRzcXBY?=
 =?utf-8?B?Ritqb1ByeUJQbXB2R2orVmdMZ3hSaCtFY01SV09lTzB4NVFMZXEySTFVcDJC?=
 =?utf-8?B?NGtXeU1WbVFRU0JQN2RGZkxSNVhPZ0sxcVVBb0d5YVhjVmZMZk5iMC9oeEUv?=
 =?utf-8?B?emFUbGlzNDA2TFVkSFlSUjZaSFJDeThPUUpWaTBONXNFajJhazVFMEJXQlBI?=
 =?utf-8?B?bzBVTlZyd1pXdXFNa29mNHA1c1dtb1BRRWtYUW9aYTZsQXZyQ3lQcm1ubFVj?=
 =?utf-8?B?cE9lbWhLaUlkQ24xVWxjU3RDQSszYjBRUks4SGNETUxXK0JUdnFrRC9pNHNX?=
 =?utf-8?B?ZGhWam44T21KSSt6QXZlUmc5TEJja3YyUFk5WnR0NWZ2bDJIVkhDQ0ZORVkw?=
 =?utf-8?B?L0FPYU8rRkdSSDNBWWF3V3B1UmJiSGxQQVdrdFl6VFpWL1NJNTdOcWJOVmtz?=
 =?utf-8?B?bzJnNFFIVjF0cm83a29WT1FQdGpnai85NForWDIxc290aVdYOTRGQllTWDlG?=
 =?utf-8?B?ZG9qcmtFeHMzdmU2clBtTUhJc2ZvZVdpVWdpbC9TQzdKMEhPQk1CNjFRK2FK?=
 =?utf-8?B?NEh1VmJ5bHR1STU3U3NON2Y1NmtCYW5kK0RYRmluSDNzbHpLNlBxNzhjeWYx?=
 =?utf-8?B?Q3lmeUd3cDVZU0pKbTVjeGVhNXJGNEVRNlRJSHJPaEk2Z3doalF4WGVLaGhL?=
 =?utf-8?B?MVNpMlg3a1FQbUFtd3hDVmhNWU5yWGVDbVdqMk1uWlF0MUNRZFN5REZBVjlF?=
 =?utf-8?B?S29FNStySUk3S3lSVVA5RnpCdXZ1U0k0UTIrd2QyY3kvcjhSakJOU2VndmEw?=
 =?utf-8?B?K0ROTFJlb0k1UUQzRUs5bWliZVJYeTMrdEVLUVA1M0E5QlNuWk1kbUVPQlpl?=
 =?utf-8?B?bDJZU1NNM0NBN1JxcG1QQ2RHRThvNVZVVlFLanByVGMrL01sT3BDNzRZd08w?=
 =?utf-8?B?MG5hVmRRTVZvL1ZZaDJiYjE3dU44MDVpMEt1VTd3RGVZSWNXT2g3SzR5aG11?=
 =?utf-8?B?OWtCR3gvTkpoc0t2RmdkWGYzdmhCMWQvYVZ0NmxFai84cTFoMmFYOEEreUxW?=
 =?utf-8?B?M01lS2xlNkRwTzNMbWxOS3B6UmxKQWxYQ1ZrWExxelpBa3lDQnQ3SEMvRTIv?=
 =?utf-8?B?Q1VYNjNpTGhwdzZEZWhUWmZVaVpPaDZydEx3dE9tZFBndW1NS1hEajgvYWxY?=
 =?utf-8?B?UjJGZzhHUkJYaVdYMUM2VFdyZkV1VEE4WDdhNmFuM1dYVmFJVEVYZU4zd0J2?=
 =?utf-8?B?TTJaNjR0VGoveVFlUGo0V3lQd0tXVWNLcHFGNVBsYWVrek1BYldCaUFYMmlY?=
 =?utf-8?B?WkUvM0xNVmpXWlRqRDhabHE4OHAzcnNjTVpWODdxNE1pTEMvYjV5WkJrcTJk?=
 =?utf-8?B?anZBWGJPM2c0d1RJMjBOVFN4ZTdkcVFmMjNaR1RueVcveE40WEJPcEFKZmx1?=
 =?utf-8?B?VkFpQ1B0bW82d1VjR0duTFZuNlY2b0FRN1pnVlZPMi9mUzFaam1idmhydFA0?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edb8674d-5c37-42d2-5040-08dbfd93c3e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:32:09.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXDWImfEDNOau4guVv+647RAGaonU6XQsQvNa5Wx0YckgnUChsC4/GLQUtUqW73Fbz9QixYZrHFTsYChHhCVlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7072
X-OriginatorOrg: intel.com

On Thu, Dec 14, 2023 at 01:59:57PM +0100, Paul Menzel wrote:
> Lieber Michal,
> 
> 
> Am 13.12.23 um 14:23 schrieb Michal Kubiak:
> > On Tue, Dec 12, 2023 at 05:50:55PM +0100, Paul Menzel wrote:
> 
> > > On 12/12/23 15:55, Michal Kubiak wrote:
> > > > From: Joshua Hay <joshua.a.hay@intel.com>
> > > > 
> > > > Tell hardware to writeback completed descriptors even when interrupts
> > > 
> > > Should you resend, the verb is spelled with a space: write back.
> > 
> > Sure, I will fix it.
> 
> Thanks.

Will be fixed in v2.

> 
> > > > are disabled. Otherwise, descriptors might not be written back until
> > > > the hardware can flush a full cacheline of descriptors. This can cause
> > > > unnecessary delays when traffic is light (or even trigger Tx queue
> > > > timeout).
> > > 
> > > How can the problem be reproduced and the patch be verified?
> 
> […]
> 
> > To be honest, I have noticed the problem during the implementation of
> > AF_XDP feature for IDPF driver. In my scenario, I had 2 Tx queues:
> >   - regular LAN Tx queue
> >   - and XDP Tx queue
> > added to the same q_vector attached to the same NAPI, so those 2 Tx
> > queues were handled in the same NAPI poll loop.
> > Then, when I started a huge Tx zero-copy trafic using AF_XDP (on the XDP
> > queue), and, at the same time, tried to xmit a few packets using the second
> > (non-XDP) queue (e.g. with scapy), I was getting the Tx timeout on that regular
> > LAN Tx queue.
> > That is why I decided to upstream this fix. With disabled writebacks,
> > there is no chance to get the completion descriptor for the queue where
> > the traffic is much lighter.
> > 
> > I have never tried to reproduce the scenario described by Joshua
> > in his original patch ("unnecessary delays when traffic is light").
> 
> Understood. Maybe you could add a summary of the above to the commit message
> or just copy and paste. I guess, it’s better than nothing. And thank you for
> upstreaming this.
> 
> 
> Kind regards,
> 
> Paul

Right. I have to add some kdocs, so I will also extend that commit message in v2.

Thanks,
Michal

