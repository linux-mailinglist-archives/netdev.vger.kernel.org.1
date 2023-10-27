Return-Path: <netdev+bounces-44800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7507D9E40
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF031C20EE9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C839847;
	Fri, 27 Oct 2023 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzuEHqKa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800988833
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 16:58:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E11E1
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698425936; x=1729961936;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=fk5FFwGyO6DrUURBqTw/iW6jpJ9RWyBTn2VNe2enJZ0=;
  b=CzuEHqKa722mDnkA8lKJ0v3/Ai21Wix6xtjSSjE8vWU4ecjXNou2S8sS
   rG6Ax/4SaaAUjnCoqTmu8EAWInC0TzCl3KoDgvu4OAKVPBYyRRdKy3327
   Ja9DL0T2tqGgnMEGInQlEmMZG25qikQJv/pvDce++Nl8cRGl4F8HA9QWu
   WKBysJNK6TYWQAzJizDxkY7qJqJpQqb87ZqQg/Sh9lRqMb3K+A/M0stK0
   i1joXmQz8k8nMolBuH0QIL0QjVwIBoTgA+6OvhgwtWjkUHvPhOO4OZlYS
   KYykB56RIqkgch7Oabuc+HJ0WcGV9yNYEKABkZQuhNxHprCN5Phjliu5C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="387626792"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="387626792"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 09:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="763283146"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="763283146"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 09:58:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 09:58:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 09:58:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 09:58:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 09:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgbpbQU6qRpqtqULlBmpMLSUPtv6tQT4lOXkKoqVoA44K8HltZi9qAQ3oy2FE976Doks8iNC+Ki/fovEHD8RX/Ep2uj/LRX8vXcXvvJrMAkbYNt4jl+9fVjsd61ddui4F2f5JNGa2e8skzcFQsMDeIoLdI1tbCjAZtw+FlvGmqmqHKK4mB6MYoQn7zT+XqyiiIzN+zRu9sUiqVPYXGpD6nDukx8aX7JrApQkciETdc3gAGFRIKPD15etPmGte1FIAYU4o9Br7V4b3NdlvazPM6BsDu1ZubzyVhUgwGy0+rz95YO1rplgWYDMkMib8/tS5CIdmLgjYW63gLXhc5yVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3Y7LWiZODgxLNUMIgsImBOM1Agtdj4Zf/8n9w8m9Rk=;
 b=Fg9JEOG4iW8PJZgSyXZnrT4iKomNwjVKbPVMq0+7UB/UpJ/5eKdV/RLZfx9JSZvCeQxLKL4yQltT1hc5cvRO0YBd5SrNaENCkoy697H/aWyONTIBGW1Anl7jD3mtUzbkzmxxFxOdY02zHhbqbgzOs0HTgJwpbN6DPDnQDR+I5XkXKB3Lnn3N9I5KRTxIMD5x+UGHckamtWMLReA56DEvfUCoyJVVtU0h0fzli002pOJBRUOGUaNGCWP4LNfbaAgDeU6b1m9CSBLj6Gpz9gHxzhC8YwI2q7s7Reyzf3pDy2wyNDKEImdSYkFiNpu/qr9/XsUOGaNl4i/KAbNJVtxDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7201.namprd11.prod.outlook.com (2603:10b6:610:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 16:58:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2724:db16:fe7b:2ffa]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::2724:db16:fe7b:2ffa%6]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 16:58:39 +0000
Message-ID: <fbd68251-9fa1-4668-a551-b4aaebeb0340@intel.com>
Date: Fri, 27 Oct 2023 09:58:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] Intel Wired LAN Driver Updates for
 2023-10-23 (iavf)
Content-Language: en-US
To: <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231023230826.531858-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:303:8e::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb11cfe-1e8a-4024-f1bc-08dbd70df7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /U5LoZt/D77uVfj1/cxH4e+hmxNvAhwi290+wSBG9hImdH26sCKtPu5GSuJsuQOPGFgmkPMoKwjYWLNsF7vNLvxmjBy6yUc0/UNsPkk+IHY1+xWLRvOeV3nnJYhFJYqs2tgMkFIwsqZtgS5QRwfcsFYyNZDVf7mejt9MHTokKRrWGk7FANFM97hEK9E7f9r/bUtwnAIzf1simpoDAiwAGPAOIRvAehttNFLqX0rn7KvQA397W9zWhjHYomO+skHVjR3eiX9YWDuxSnJB/Z3yWrEC924+jcGTWtoSdExOvOLgdtQGvLhCfojaB/c6GYg9NBsl5uek/S4Z5HAW2emcwlmMWeIPygTbYL0yP200Z6ix14gdmkwlBTRjBTiRYEgpJpK9VJYPzp8OpDm8/2NhTM/jVbggXFA3GmADoYJ6bBCPcnWrcmc2xmqBUt2p7IKQDr3FVtFLQNRm6+pTyy3zCIAOmMYpY8f2Mv5ejOSvAi/N04WEuHb4LMOtKbt7x1YRgNKB4bDGkxoSlzK5c/jPB1xvA0m9xEH6JOdyaPCM73MpnI1B/1sgC2fMgwddARFYyImeYFlTtIuN57ay5D53j0ea5iaItYxvuz5YIB95AEQlnxbxSdAR3kaISvMAELk4iwjXe95JD1wVGVidA1DM1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(31686004)(66946007)(110136005)(6506007)(6486002)(316002)(66476007)(66556008)(478600001)(53546011)(6512007)(82960400001)(8676002)(8936002)(15650500001)(2906002)(2616005)(31696002)(86362001)(5660300002)(41300700001)(26005)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0YvZ0lodnFsZk90clVHM3M3Yy9sUU9DTVIyOHpLcjlFR1E1eWxPQnEzcjFX?=
 =?utf-8?B?UDBqMlRJZ0Z1QWwxa3F6dTRJc3NNWUJYZUxRckptT2s2dG5nemVITm56TDN3?=
 =?utf-8?B?NFB2RGt2aHpCTkhyUnhHamVRbG1Dano0Z2RBa3piUWNTVDdEUUlQWXBEOUd3?=
 =?utf-8?B?RjZmM3hFUkQ2cVRJQUlrV1BHU0dlWWl1c3VjUmZ1Rm5NMUpIMmJvK2ZsUUNl?=
 =?utf-8?B?enZDQzNWL0tHNTlSZCt5UytSckRGZFFXcWV5RHM3VzNaWVBUTWtvOGZqV2Fv?=
 =?utf-8?B?Z3pNUXZFUnZwS3IxL0xTQmxWUis3U1plN2J5OWR6TmJQSWh5czNCTVlHSWk1?=
 =?utf-8?B?QzZHc2xBbjZmZEluZi9sRWlOTU52REd4Z1RzQjhRS1FwWDRsZ2VGWmJ2T25q?=
 =?utf-8?B?d29SZFRkSG0ycXVmUFhNK1Jxc3ZBd0E0dGEzT2cxTWIzU3dpTFpYRU40WkJh?=
 =?utf-8?B?R2hEd1dsaVYyTnRVcTlvWTg1MHJ1MDV3NlZQdmVwTkxsM2pERTZsWWh6dTVK?=
 =?utf-8?B?dFp6cjh1VHI0MVYxOVM0cHJvcm9VTG1KbHptNlF2SS9EWW9xYzVOQi9QbHlL?=
 =?utf-8?B?R1luTTQzajNJUzloOVFLS0hTRXNRaHpqejgyQlczNWIvLzFOZ2Jrc1ZPTHB4?=
 =?utf-8?B?aUtTRmM0QlROcDdZZjM0cUl2ZmZBcU9uMXcvb29yNSs0amppUFNpYUNaSzE1?=
 =?utf-8?B?K1hNNFFmWEJUQWl0U0N1bVY2M29OYzNtOTd6eW91MHczcTIwekxnWUdlWWd4?=
 =?utf-8?B?c2ZaZmdaTFV6UW1OTng1ZWhWYWtaY2RTMW5Vdk9QSjVqaUttblljcWR3MkRZ?=
 =?utf-8?B?c0dnMUVadk91TDhBRCtVNjdDQm9Sd3VGVXdhMGFTd0ZNZmZZUXdSTlN4YjhZ?=
 =?utf-8?B?U2RabnA3Z2ZUUHNLVnZRUmFaekJ2MG1Qb0IzTGI0amJrY3FhcjYwR3BYbGFw?=
 =?utf-8?B?SEtrdm5rOHlxYXMwNFJ4eVVaZm80dUlnc2RqZUxiZ2hQVEE5eEJzZlJDY0d5?=
 =?utf-8?B?TGozbnlsT3hpenpjS04vOGh4YWszd3lHNGFSa01qSnZ6TVl1cTlFM1dnVFh0?=
 =?utf-8?B?M0dUVGI3UVN0TWRja0cweGREVWFSWmRzK0VMOENlZGlBdG9sS0U4R3lMSjU2?=
 =?utf-8?B?dUF3MmJBL2l0Y2taU21rbWpkVEF5dHJZeDdsYlFGKzF1dWZrUHZrKzhISCtB?=
 =?utf-8?B?aHNITmFkUkQrU2J4b1NvVDdsR0dBSnMzUTQrMkhZMFZGZHVsVWJPVzZ3cmJP?=
 =?utf-8?B?clJKRFJHUDJZSGpXK2NpbVBmVkZ6SElGMkRFaWRmV1VjQUdHT0V2TGZhSEpD?=
 =?utf-8?B?VkxJd0gxN1VlMjIzTnJoUDVnRENmYzQrOUhCY1lscEIwT2MzVTlERlhlWTBn?=
 =?utf-8?B?VEVodWFXQWY1YWhkeE9oTWJ4SWNBSVBQcTRMaExoUExUaWVnVjZ2Y2FVUjlm?=
 =?utf-8?B?TXFSOWNsNUI5UjJSazZZUFgyaENvY3g1MW9GYjM4OTdqNTk5TFFoTjV3dlhh?=
 =?utf-8?B?OFU3a1gydVhyNGVHUVYvWURHVlROS0w2UnRUOUxIOTA2S0t3NURVTnRGcFBw?=
 =?utf-8?B?b3dqemdYd3U2dEppVVZFbEpkYVh3QXE3dUhIeVYwa0pBRFFVNWpJaXRyVjN4?=
 =?utf-8?B?TDlTSXhhdnlEeHY4TitXdVZqRnJMRkZzUlV5K1VzZlJhVG9lWmhsZThZRE82?=
 =?utf-8?B?eUZKTFZGRTVpRzB6N0w0Z0tCc2hrY2x4eUVYT3c1N0hXc3ZVK3RCZE5ZbHh2?=
 =?utf-8?B?aVNLcmNuaG9BSTVtbncvWWlpeHd0M1FUYjl6NUE5Uy9PRm1hOVhQbVZNWTVN?=
 =?utf-8?B?dmtaNS9nbStidXRhRXljc2VXVkJWKzA1WXQ3OEVUdGdFQW9pWHVmTW1tbklj?=
 =?utf-8?B?TUgyM3ZvNXZEcW5STlZEWE9yZjcrWmhnSWVucFVRQXRaWTloQWtZMXZoSnlj?=
 =?utf-8?B?WDZVWW5KRGRBdjBKMmVnTXFWdm5MNnFyNnU3cFRTeFdwZ0o5SVZXa0haeDU2?=
 =?utf-8?B?RHBGYlduMnE4Rm9FYTYvZGRuZnJHaGRwdUlOSVFmMUdwOVR6VU02dTNGNysr?=
 =?utf-8?B?RDl3dHNiUE5YL3lMT2dheXFBV2RaT3hicWhPNlVONVh4Ylp0b2o1UTlBY2Fv?=
 =?utf-8?B?VUQ5dnFqbGl6OWxBWUNlUHU0UGExUW4rKzVsa2hxSE96Nk5jTmEvSUszTzZ0?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb11cfe-1e8a-4024-f1bc-08dbd70df7a7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:58:39.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyiwgRj2KUJojwaMqAkFcOh7vY039QxWW8pCrbG4un4Gf1AYdEF355iHozmNbODNfSfOCabPnNQuaPSfMp2KSZObWLQHrTKBoXr8y29Rfko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7201
X-OriginatorOrg: intel.com

On 10/23/2023 4:08 PM, Jacob Keller wrote:
> This series includes iAVF driver cleanups from Michal Schmidt.
> 
> Michal removes and updates stale comments, fixes some locking anti-patterns,
> improves handling of resets when the PF is slow, avoids unnecessary
> duplication of netdev state, refactors away some duplicate code, and finally
> removes the never-actually-used client interface.
> 
> Michal Schmidt (9):
>   iavf: fix comments about old bit locks
>   iavf: simplify mutex_trylock+sleep loops
>   iavf: in iavf_down, don't queue watchdog_task if comms failed
>   iavf: in iavf_down, disable queues when removing the driver
>   iavf: fix the waiting time for initial reset
>   iavf: rely on netdev's own registered state
>   iavf: use unregister_netdev
>   iavf: add a common function for undoing the interrupt scheme
>   iavf: delete the iavf client interface
> 
>  drivers/net/ethernet/intel/iavf/Makefile      |   2 +-
>  drivers/net/ethernet/intel/iavf/iavf.h        |  28 -
>  drivers/net/ethernet/intel/iavf/iavf_client.c | 578 ------------------
>  drivers/net/ethernet/intel/iavf/iavf_client.h | 169 -----
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 139 +----
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  14 -
>  6 files changed, 29 insertions(+), 901 deletions(-)
>  delete mode 100644 drivers/net/ethernet/intel/iavf/iavf_client.c
>  delete mode 100644 drivers/net/ethernet/intel/iavf/iavf_client.h
> 
> 
> base-commit: d6e48462e88fe7efc78b455ecde5b0ca43ec50b7


Since we pulled the fix out into net, I assume I should resend a rebased
v2 of this series?

Thanks,
Jake

