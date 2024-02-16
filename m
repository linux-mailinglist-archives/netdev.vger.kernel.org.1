Return-Path: <netdev+bounces-72567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD09858882
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1521F22D37
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69C72CCBA;
	Fri, 16 Feb 2024 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZtNq/bV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E031CF81
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122704; cv=fail; b=tMeE+Ulzc39HcytUSmfcdqOZTCrltB12Y4YwCCVKoCxQ89I/3IniCwJxshqEkCkvNAGzJVkktsMu4biEgSDNm60pnPr69Q4eOMfG4zSYy1NKEfBNUpSl+DtcbMS0cC2gcFpQFBcc0/odi7v+CeCo+stSBs+jRQzhu4H5DlJhJcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122704; c=relaxed/simple;
	bh=dXGlEOv6au6ozZjmDHcjl+41Xw01w8dyxrCVKVTND1g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nxf/NACDcKEIw22E3n8Da9Cuuy/bsZtGHLiCN7oHV757JDX5fSkQss2CiXuaFRA/o9SX0N80JIKLU6MS9Swv12Riw2RhdTN9vBBTEyhxolYQj/ZRrQPab7YXcTE7SUJqNQTlHu32Xxm+jHPxGD1oSElmJsG5LsbZPoDcoZ/Wga4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZtNq/bV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708122703; x=1739658703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dXGlEOv6au6ozZjmDHcjl+41Xw01w8dyxrCVKVTND1g=;
  b=kZtNq/bVCm0tbtzfbKUsJQyo4YqVGn+8nEPorMgvm9oLSrI7dkmfB8I5
   7nDZ9SvqADIxVB+gC2fsZ+S8L3ZWUUD56JkEo+dYzsTeoA1A44RB85lal
   3GVLhubo78JpN85sp9eLqFaLQ1BVYqPeMdDkmS9FKJ/dKdN/oIF/Rm0pS
   2VlCqVbzOkmxLpSZXrtfQ/o6M3U44W9FmzuHsg/Ac2J6tYePmbutiT8Re
   OW+zviCiGyomzXqk/mGCrwWupPER8O0AX/l3kNTtVUk4vu8h9LT8KhwRC
   HhhB+SzIbS6EM9Xbl9TLgU2uNq+ykGoWVlLtiJ3cB1lc8Yt11lJdMxL+m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="13371413"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="13371413"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:31:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="3934639"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:31:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:31:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:31:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:31:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnjIbuaAuHmDVciOCOmpREIzewWIzMGk4OW5wdSWguMHnAnot222CsrGknoDxLi/rN3iGdb/gPrVwKWnMx1wmdw5u7kqMrhVfmNDmxWb880WXu0E9nX1SwMXh5QZIb4QPd480/Z7Sgw1sOiSMmNNT5JTfIXjV8h6MKmY31BpoSt/V5on7AlZCEbUzKbSHrTXqg4kdrPrHY6tiQejn6Z70oQVDGR22Q/ofVz1UVovNghG86A1vsykJpYDi/8mX9ANTkErRzkkRyspleGz56YOy7EUsdDWOokIuYbSbv3/JC6OGJWOO54fOLp3PbWfRk5Y/LTiJ3CqKhRu6eT9OqwrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7tZDcGQ41ltSq361hPquVNDedUw2tXkFZ8OI/APM7Y=;
 b=bX9VMjiole8OJOZsu5oKZ3JLlo6+41ibrt6G4BZTuYwxp/6cAPcwr1tLScJOhjUI3UYFx5nmgPYrFU4CQjnKGquzb+j95yvc1/yhWO7wX1mNOBBKDLyybR8mx+s1Meu0J1O3yf7FPNd/04NtVhdG7iSK7xIZieuvmK51nWB7k92WEFtHTANVkRHnPeSqOh4gBwSa1w9pXp9Wias2ouuBRpoLH0i1nc8lA57vQqp4lOpBIVMOnwvLNfDBA5rnLsbbpk2YDdwZWT+1tMsWb2ltDLBe2Y4eyCyuaGySlcR6B+GYX3LWMhlNBhYz9RXhwouCoYeykKdldakka4O/6P560g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB6542.namprd11.prod.outlook.com (2603:10b6:8:d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:31:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:31:39 +0000
Message-ID: <407e3b7d-b0b3-4e5a-b265-462193e5b4b2@intel.com>
Date: Fri, 16 Feb 2024 14:31:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ena: Remove ena_select_queue
Content-Language: en-US
To: Kamal Heib <kheib@redhat.com>, <netdev@vger.kernel.org>, "David S .
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Shay Agroskin <shayagr@amazon.com>, David Arinzon <darinzon@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	"Saeed Bishara" <saeedb@amazon.com>
References: <20240215223104.3060289-1-kheib@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240215223104.3060289-1-kheib@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0310.namprd04.prod.outlook.com
 (2603:10b6:303:82::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 39cea3f4-4f92-45f1-cbf4-08dc2f3f0b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Okiv9vjWBqouHe1WdRlPgQDqZdxr9bqylDSlO76QByGO4NVgYXuvgxrGANVbwjOLLUna4aOuSDCe9JxvEmzx3gyJkfQeD0W2zNq9XCRwCnL8YH76Oj+Qh9QTfCbYsXcbW7hh8UD2GhTNN03z2ThoPFg60ispuiXhDnX0j44Ya40HUQRZIhNKbQkaTkuELdami5rvq8iQfRCr+uOfaRyOIoip6Ifq0fvJH0k5fTepZgpr+NfIuPuhV6WVWKhQyaUlrF5BW86xLMb775NIIi2bNcJ23smpnVu6+IVNqHmMSLsxhPmeWMsb1CTeoGpA9J7WMFie/EJrlgR071sIcMSuWviD5eyglq8LOOA7AARYQeF2A+Ag89Ep8W5mhmXQn3cn+1Z5yofEy0DRk3qYUX52QetHh9SdAPG7FdnTb3UtS16/KGRTpVKLFgBVFAFBUqrC8dn0ZqIx/HRcgkcm7YLklvJkwrywsERQ35oJqKMeoc9/y89yzJyu/OO9iQOcYZxG3Ua+4QGsdI38bdfwjzweyabr0MQX2NbGBBga4F2ArMvEbkopDgpKjTwyLH6xg+6B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(36756003)(31686004)(86362001)(31696002)(8676002)(316002)(8936002)(110136005)(54906003)(82960400001)(66556008)(66946007)(66476007)(26005)(6512007)(6506007)(478600001)(6486002)(4326008)(53546011)(83380400001)(38100700002)(2906002)(2616005)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vjd1djlnQ3VKU3lDMTVaS1VESW1jL0szK1hSYzlNcmZHQ3ppVUdKa2ZUMlNV?=
 =?utf-8?B?VGlqNHpibnFqV2pOYTYvNVVsaGxaa3ltZ1N2VTJNNkk5MFpaYmMvTGYvR3E4?=
 =?utf-8?B?b2xZQmtOOFJjbzhBSmFrV2pYWUtNbit1aVV5Szcyc1dYbzhWTGU0aDFRM0J6?=
 =?utf-8?B?OVJ1ZmRJbTc3djIxZTZ1NTJqNGpQdEpTdnF3UU8wYVV2SGpJVFc2SE1qYkJn?=
 =?utf-8?B?aTVvRk5PUjJYWnhDME1CQWxqUVRMOERVL3FnOFhWWGNCWmRtdkYwSlBtdUVM?=
 =?utf-8?B?VytzTzVzZDJvWGJ6Vm9lemZ6cHJ6VFp5cFF1N25IR2pEeklZaWhYTEFtQWlS?=
 =?utf-8?B?UEhtTnJQeks4bU8wTlpsWlNidzg1NUxQYTUzWlZXdmx6akx1dFJXRnRndTVk?=
 =?utf-8?B?NC9WTlRFN1RXWlZOdUR0RWFKWi9TSEZyb01DRE9va3dJdnNiRE1Qb215WjR5?=
 =?utf-8?B?Zi9zc1BOUG1PdzBETFc5RXB1ZTMzcXJ2RWp4ZFlEcW5rQnlOeFZ4ZWN6bGZN?=
 =?utf-8?B?WTBOR0hiT0RHT1hZZEplcTlLbVpqeS9Qa2d4T080RXR5NVhSZ1FCbHJ3WnlH?=
 =?utf-8?B?Nm9yRUhqZ0pHSVRFci9UdVc2Qll0TzdwUFpMekt1NGhwZ1JnajdFK09TdHZM?=
 =?utf-8?B?NExrRzVYOEt6NzJ6VDd3SG80S1FrNHMvYnhTNDZRNm9jNnQ5ZWkvT1VGdDc5?=
 =?utf-8?B?ZHVHT0R0bURjL3VQdzl0UG5NNWMrSFAzMzFuSHhERjNVQkVFdmk4TkdONHNS?=
 =?utf-8?B?ejR4d2g2TjBSVHAxWDV6RHcza3hsT2E5d1FGM2tkeFdnUTFJNk11UHZmNVJF?=
 =?utf-8?B?ejRmb3Z3aTNaRnVuUWZBK0xWZitDeWVaVlZQYXh2c2hYMWlNVUdLZEp4Rm0z?=
 =?utf-8?B?UEFXNW5xbUkwSXE2Z2x3NmJyeXUxUmNtSUNMWEdDOUVld25nNmtxM1pidm9o?=
 =?utf-8?B?TDlOZ3pnTHdCOGNlQkdveVBDZE9mVmo1U3g0bHBxSGx0eHBxYkkrdFQ1ZUl6?=
 =?utf-8?B?RFVUWkJoQWlLNWNmMjZycktMN0x1aE4zOGIvazNocERUNjdRS01vZlNzSk5s?=
 =?utf-8?B?TktabXZiSU93OEdMVElHVnpOdlYrTmlsUWlBSmhLUDdlemxBSERHakgzd0M4?=
 =?utf-8?B?UjVhRlU0ZU1hZk96Z0dkbjhSbTg5VVYvRG5jRFRQWUhUVjhxbG5FUUVBNW9p?=
 =?utf-8?B?K0ZuVmhBSXVmMHA0Nlg4OVRpQVRkZEhqUWZKeC9maCtGYzhMT0ZabFdIZ3Bw?=
 =?utf-8?B?aGVkVlZiUXo1Q2FoU1ZVNGVMbll1azlvWGJGTnRTR2ZJd29hUDJUQVNwbHFk?=
 =?utf-8?B?N1lzMWw1VzJCelZ2djhQMWNoSEpTVHBoa0RCdTcxT0htZEJtTnFCWmRBb1I1?=
 =?utf-8?B?TE81ZWlZb04xc01vMGVVbzUxMDFIdFhjSzZOZjlPTHg4N244YzdpZzRDQ2VJ?=
 =?utf-8?B?dTBNWXkvSm9obFN5TkhnWngybkZjeXM2NHZHUXI2OGRSKzdaSHNCcGZBcXFG?=
 =?utf-8?B?MUxvY0t1Yk1TRjdGRHI4UjM5czQ1ZFJ5NXFHdy9FRTNxNE1McEVBV01CVUx4?=
 =?utf-8?B?Y3ZvNVAzOEplblJLZmRQNDhUUmxqUDFsQ3dqK0hMekRhdTFHeVNxbENnUDVa?=
 =?utf-8?B?b3ZNRFNjd1A5Q1pZdldNeTYxMDVYNzV2ZVZ1dXlEWFFDMDUwZjBkU3VOTHVY?=
 =?utf-8?B?ZTZNcC9wSXdEdUZYNTNoYmI0dERoWCt6bHZLbytVU2MvbU9XTmZEZm45d3Bv?=
 =?utf-8?B?L285bldwVWpBQTdBdlI2ZVd4djZEKzRGM0xwK3crL1lOdTc5QnZJa0Yrdi9p?=
 =?utf-8?B?NlVFMFRvcnBmTGdHSzl4MEJvcDZrMjF1NnU0NFFvWXdoZEd2Tmh1RDJjMXhQ?=
 =?utf-8?B?a0d5Qm4xb3ovWmNjUlNGb2hRbUhPMHFSYkhVRGFUT3ErNWZ3WDh4c0Yvc3VJ?=
 =?utf-8?B?dHV5dERsSGVVOUU3a3VxVXJpZG1qcUdTc0NVVmZ4L3grRWpCSmhuU2E2QnFO?=
 =?utf-8?B?R09aR0dvdHZGclFjbnd6RVUvOG56WnVpSVNhbE93S0h1L0h0aEU0RGFRbWFY?=
 =?utf-8?B?a3hVcmRGQStUSXprNHRqVFlnaEVsS1BNekhRU3ZSZHNlVEZQRXVBRXNYdzRK?=
 =?utf-8?B?ZndHbWFiYzR0NFAvL3BlVStCT2NsTW1yK0hPa0VnL0gvRC93M1FvWWpJR0kz?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cea3f4-4f92-45f1-cbf4-08dc2f3f0b2f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:31:39.7956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhOkjjc1clpI5nqSFKzuc0DsL50bHhQTS5i+wzGYEeVacwp5DhiPUZxYuiDnZausaoPW3dfZJqQbUyig7PkH0GgKuSHDSMzfat6DpGxVTDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6542
X-OriginatorOrg: intel.com



On 2/15/2024 2:31 PM, Kamal Heib wrote:
> Avoid the following warnings by removing the ena_select_queue() function
> and rely on the net core to do the queue selection, The issue happen
> when an skb received from an interface with more queues than ena is
> forwarded to the ena interface.
> 
> [ 1176.159959] eth0 selects TX queue 11, but real number of TX queues is 8
> [ 1176.863976] eth0 selects TX queue 14, but real number of TX queues is 8
> [ 1180.767877] eth0 selects TX queue 14, but real number of TX queues is 8
> [ 1188.703742] eth0 selects TX queue 14, but real number of TX queues is 8
> 
> Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---

You could blindly do something like modulo the real number of queues...
but it seems like its just better to let the kernel decide.

I did check and there doesn't appear to be much of an explanation for
the select_queue implementation in the original commit either.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

