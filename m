Return-Path: <netdev+bounces-86982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE528A1386
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321B81F22290
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0677614BF8B;
	Thu, 11 Apr 2024 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THn5ighc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C8414A4D6
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836070; cv=fail; b=hAmPjgcfNPKPKjOxTAqbcbp7OjGQq+imbd64Ye1ZyQWj2CQX/RhFIO0WkrEJ/zLbVBBDfdRY3/SrqjblEDMpsiJ71NyWlXL0gDNVyrLrjjiuI9GWXslBa3ZMgmvawrsARpbKzrd4yRE+6w8e1m7SZYUD8nlSIQ3hY7PMhUGUepk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836070; c=relaxed/simple;
	bh=KmKBsJCxJO1ujOhpZzoT8wKXu/dA35+wj4EaAKeIhvQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pnHSkzG0drE3/x6KgCUucYY24f8hfPEyl92luhMaibEU26uuiOcQzTiWAXiFho/f0p24qE6aRjO/PO1T2AJGdf2B924/l2j8zABofbzaLaCB5S4Kx8V9xeTAhntggWvqN4AzCqKG6fhGHVqlGgrA+Qy7T3C799bwbjA2Y5Q1Btw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THn5ighc; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712836069; x=1744372069;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KmKBsJCxJO1ujOhpZzoT8wKXu/dA35+wj4EaAKeIhvQ=;
  b=THn5ighce/w6LGmOO+i9B1K6ezuHS+DDbV9C02lYhXPLBu9S4Qiw/9SU
   ayLCIYZ7xaxtwWuxq/478QOh1XVEuXCTpeLuT5luujsGPfTj0GhWmKPM1
   D+WPV4gr6CpRZARlZk5TP+Zjea88JKF0CVrzCgcVmxRcCIXKl3xW5kPwu
   pRWMgfdcA8+lmb4WbbCGTO+Q58rHH2u71Dug3nne7efAmQJluvV81POZN
   eyusO5NjINVoMRQwvAgMo8xyZzUP0ZoUzOnqkeNVkEG6qPCuuZyRgrPck
   GzZ9sB9izDNfhMfLys4c6UE2eZaHuJzPF+O4hMK4+22Qd4g21x9PfPhAu
   g==;
X-CSE-ConnectionGUID: xEYUHYl9TpyJTx7mRklo2A==
X-CSE-MsgGUID: dBr7d0RPSwSZstbWDEPevw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11201535"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="11201535"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 04:47:48 -0700
X-CSE-ConnectionGUID: XqbokS2US9eDE3nqZYr5Cw==
X-CSE-MsgGUID: w78eLuJLTIWZhj5kadttlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25653807"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 04:47:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 04:47:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 04:47:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 04:47:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtQdEJnYx+1v5JxR97w/2jHqtG2bEURlP2gOy8iF7Xl0zIWlzSHr1ssaqljsTFrGviZH/iFYkLEQ5/J+opG2cKiwQDNhGVfvepSNnqnXqG0D9GiRnTwKZISOctkT3St4EWD2RA1YwEUcSNNfx7USyn4DH5hCdAU/NKDoMnsLcwZcM9iAdXESzYkQdJlCTmgkQRfYlkAZsN6NxK11t3XprHhS12/mLfuiqzhkOURD0EPQ8FBSzz7dUqRtSwbHnS98DiadzjiW6+3YpvMxiWGC8cqcTnTaUQ07dupdAkCnaIKneRcodd2sHR1OhWiV+Dqx47MKkbYxP5/d2tf2JtdaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxtHgnXx3HKLJiZI4lGY5vas4O9eOstulftbDzVpBgg=;
 b=jOxUnZwC6vIyk5lkGvWiKgWXdmo61fs03fHyMhXD2vDerCNyXecEl/vKbljATggcyr/kMvQko0EsG+Np4B6HLsT8FWbaFjfv1HKLWADg1VsworNkm9gvA0kEHgLP8lZ5OBRGNawXtHxDfcL7bgxJnkxFs+JCdnlNvhRHI18U6vphoacdZgxq95+dWFeQfCcExqPzyCBY1DF2X6+053s+zNqLgWfosW5gWsr3Nqb7NFrzrcH3w8z/KgkzX0DaVJX6p4O1DdoqHg6VE91KBGOkmzhGsG4ehl9Mcc+mMZ8JrgysuuttOHSa6tQAYSOlNeHbBcOj7zjJbIbtcoMfwFKY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6954.namprd11.prod.outlook.com (2603:10b6:510:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Thu, 11 Apr
 2024 11:47:44 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 11:47:44 +0000
Message-ID: <1db181fd-8d08-4f6d-b32f-20d06029360c@intel.com>
Date: Thu, 11 Apr 2024 13:45:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vhost 1/6] virtio_ring: introduce dma map api for page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: <virtualization@lists.linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-2-xuanzhuo@linux.alibaba.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240411025127.51945-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: f0123cf6-1264-4506-e525-08dc5a1d3360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DlInsVE0f0GeZU6ii/G/GowvuHDqv1KEQw1SQM7E0Z9yHB2YJEQrZC9/uDZHH0PdMviOFcvjabLeaexoTCKE3irS8Znux+gJtAMpPZms3ehSOgtU9ikvMX3k76+Ozx3qL+zjkXB3kDqYc4NK56TbApHoS5OUhRlGJPe5awMz5pWX+k5nUExkDn3kcWVuRQgcHp2e1dFy5ZNwmMfLgYWvy5vidGiPTOCF16CrTGTYkzGT8EVx5Mg//v7NfevpTsGA9nkr8ZNZJqNU/hd397dDK2YusEu4UBibWgOvQQDAvRxlcu5wavxZBgh2FRvxuqlR4DHhUsb7i34Tpobx9FX40q4mP2BJ20DnwK0ojZaJBSDK2BWmkpdxXFvEZLxmWAzlH8C9475NnfbKNa2MHHsCuwhWv6XstitbGj0FzW14Pis9kpmVurbKpUfcmfHaV9Z12YZe7noeN9b5CrAX0gre7fDQoiPgQOwMlgMuDR86uOtUCN91FprZRxdBZQmBOnYns4ye8dGRpEFPqLZCI234kfn2tCpjE6QqLwZ4n8LUacG/J3YsmDkwXS6JR9K/O5WBiRdj0A1ao7Xalf6CXkKyfqlAngvY+qcI9ZkgpgPjeVk7o0OfZHcHIhYVQVlUx0TIACkExVBoAKMFyExwTSaSqz8S6tt6tu8cp/lLNTdf7fE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlU1dmJ2SDJTWlQ2aFBOM3IzdWZXZkFZNjhuZXNudFJSL0hXbFpOWG04bVpl?=
 =?utf-8?B?VG9qS002YlRLWm1IeFdvbGNwdndNU2R0WVpOcHFiY0J5TTZleXpmVGVqVm1L?=
 =?utf-8?B?M21lOStuVGlZTTl1clNTbFRDNDhlRnF5R3pGMkNmZUtZMEo0dkdScGxSa2ds?=
 =?utf-8?B?NHlCamhpKzVRTWpFQ1VLNU84Y3FzaGRlUmZOaDgrSnBOWFlOcXh6VG1YZ28v?=
 =?utf-8?B?VU5lWG1pZWU2VHUxOVgrQ1g3R2M1dlFVREh1eEJIYVcrQThsendrdUdUQTRB?=
 =?utf-8?B?a29xSmR2eFV1TDdjL1dqUTd4ckI5VVhiWGFidk9jV0JyN05RNmNHOGJPUlhi?=
 =?utf-8?B?aFVSN0FuYk5sZFlKbHIrU2Z5Znc5dHNZb01KZHk0VTRFT0N1OEZXdzJXTGNS?=
 =?utf-8?B?S2lvVi9oT0YxTlAyYllYaFFsbWN1VXE0N0puUVEzeGlCelBFYzZJQWJRNjh1?=
 =?utf-8?B?S3V1SG5ueTJ1dXAzWjBxODY2bTdPazRjeEZSSnJsQUJNaU15ZDhDNmYzVEkv?=
 =?utf-8?B?YTdWZmJrOXJFVWc3ZGttR1p4RDhuUU5nd0NiTW40RHQ3cjlsWmk3Qm1SR2Zx?=
 =?utf-8?B?ZEgzSkI3Qi9HdjNZRFY3aHlGU3A1SkcxUVNiMXV0TWJaNXpkZE9aYWZpWWJZ?=
 =?utf-8?B?dit1QVJqK1M4TmFuTWJzc29CYWJQUWx4V24rOWZKZjd2dDYrZ0xKanI3ak5h?=
 =?utf-8?B?VURYNmMyU0FLT1VKZUpKc3VEMk1ZcTNVL0RXVCszdkUwTzU0M0prOVdEWjRk?=
 =?utf-8?B?NFJwdWtVdlpQTGVNQ29ENThkbzVaL2o0RjY3bTR6bmhnd29relNmNEJ4UkZ1?=
 =?utf-8?B?dHI0UURFNTJtYnVTZDNBMTEvdFVlQkRHZnhNeUtkNnRvOGpHSmxuclM4ZTZr?=
 =?utf-8?B?UFNPL2d2dzd6SEZOcFZUVFBQR3BvQlBsV0JVdGxMaHgyTHVjaHBrcG40NlJB?=
 =?utf-8?B?cUFiZWdLWlBWNE9NaW1ISXdiaHBXRUxwVW9QK25FdWtCKzdSUFh0azFVRkVS?=
 =?utf-8?B?dWRVUGIxb3paQ1RFY1A1ZzYvWmxqKytXNW1nU3NDMUlZb3pmbmM4YWJjcEN5?=
 =?utf-8?B?U0d2VnlLQjlydXhUazgrQzdQVDI5b0JCZDEvS3phVitUeW1Fd20vQU1zd25G?=
 =?utf-8?B?WDd5Z2hiZkdVS0lrUkpnSFYyK3hFckhzNDVUa2xWQXQwTEx6T0h1VUtLeWVp?=
 =?utf-8?B?dGJvYnRGd0hkZDJjZmJNYzZzOTlCSUJKTitUVGNlbHA1aVV6c3RCQjVmU1Nw?=
 =?utf-8?B?bFBTVHB1Y0gwTXlJYWRXdDJyWmZjN2d0VlpvV29KajlVT2hCNUMrZVFaa01w?=
 =?utf-8?B?RFljclJhdG1Ja1l2dUFQUThrM2xuRit6c1ZvTkZEYldmKy8vd2U5UTFZUlR4?=
 =?utf-8?B?L20xT25RVDFmbUNMcjVDbXFIWWJIS2tHQit4aWZxdnRGNlExWEx5Tm5DL2pj?=
 =?utf-8?B?Qm9zNDVtTUhHN2pxbW9HTTU2cnExY2hYa1JYaXdHcFZ5TEJJTFlraU9kc2pJ?=
 =?utf-8?B?N283aGFXd3lhVTFVK3JrRzVCTEljeEpkbDAzZkpFNUI2WWlIbnZBRjU0ZkJl?=
 =?utf-8?B?SjVxQTY2Wk45L1pYMFVGeHdIRjNRSUtwNWxDZ2NqRFc4cGc2UW96WjhnRk0z?=
 =?utf-8?B?dUdES0RLVGN0VjB5VDZGZ3FRSFhETk55WEhjcWY3anVlWGhxYXpCVTI4NGUv?=
 =?utf-8?B?UkRsNmN3dlVJRy9ScC9wdCtIdEp3VHRZVmpvMW5VZElDbkFFVGRWTEhMNkdT?=
 =?utf-8?B?WlRTSW5FOW5YVWthMFgxTFYrMVBXYTBkY2ZySmhrZEEycHZtVTVaWUpZbEc5?=
 =?utf-8?B?UGphVzRtSUZPUFB5WFk4OGh5WkRNMmdrcXc3RjZSNXZIZVZrby9HZzdEYXAz?=
 =?utf-8?B?RnpXMEV2c3IxZkZDMm9nWjliUEJXTTRLMlNKLzZ6bHM5K3hibFFtYXdBM0hj?=
 =?utf-8?B?ZEE0Zmx5MDVYVzBsK0cyY3NjUk5MTDdMSWM3RDRXcUdXR3BBWVhOYWg3VVBw?=
 =?utf-8?B?bTl4WjQ5S2lkNmtkVkNmc3lxTEpnQmJLeXhaS1N6cHk1eVphRnlHc1Myck81?=
 =?utf-8?B?aWF6SXB0ekNscmIxcjNEVzJTYWpYRjY2SU5OK1MzNSszd2k0UFg5YjdQSXFn?=
 =?utf-8?B?S0d2dnRCWWl3TUFQS09ZOHFydSswVWZrQm42L3JNT1JFU1I2NnZ2QTd2UGxK?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0123cf6-1264-4506-e525-08dc5a1d3360
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:47:44.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WNTZ314emEoX3bkP4wB4ofPS3ddgB9b3QTZpV2lLJCFLOTxvJ8u4jqcXoKk/MSzb1Y3jmq0iGvyH0VIG6We19bepUX64T78m+bR4G/+v/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6954
X-OriginatorOrg: intel.com

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Thu, 11 Apr 2024 10:51:22 +0800

> The virtio-net big mode sq will use these APIs to map the pages.
> 
> dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
>                                        size_t offset, size_t size,
>                                        enum dma_data_direction dir,
>                                        unsigned long attrs);
> void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
>                                    size_t size, enum dma_data_direction dir,
>                                    unsigned long attrs);
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 52 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  7 +++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 70de1a9a81a3..1b9fb680cff3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3100,6 +3100,58 @@ void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
>  
> +/**
> + * virtqueue_dma_map_page_attrs - map DMA for _vq
> + * @_vq: the struct virtqueue we're talking about.
> + * @page: the page to do dma
> + * @offset: the offset inside the page
> + * @size: the size of the page to do dma
> + * @dir: DMA direction
> + * @attrs: DMA Attrs
> + *
> + * The caller calls this to do dma mapping in advance. The DMA address can be
> + * passed to this _vq when it is in pre-mapped mode.
> + *
> + * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
> + */
> +dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
> +					size_t offset, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	if (!vq->use_dma_api)
> +		return page_to_phys(page) + offset;

page_to_phys() and the actual page DMA address may differ. See
page_to_dma()/virt_to_dma(). I believe this is not correct.

> +
> +	return dma_map_page_attrs(vring_dma_dev(vq), page, offset, size, dir, attrs);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_map_page_attrs);

Could you try make these functions static inlines and run bloat-o-meter?
They seem to be small and probably you'd get better performance.

> +
> +/**
> + * virtqueue_dma_unmap_page_attrs - unmap DMA for _vq
> + * @_vq: the struct virtqueue we're talking about.
> + * @addr: the dma address to unmap
> + * @size: the size of the buffer
> + * @dir: DMA direction
> + * @attrs: DMA Attrs
> + *
> + * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
> + *
> + */
> +void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
> +				    size_t size, enum dma_data_direction dir,
> +				    unsigned long attrs)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	if (!vq->use_dma_api)
> +		return;
> +
> +	dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_page_attrs);
> +
>  /**
>   * virtqueue_dma_mapping_error - check dma address
>   * @_vq: the struct virtqueue we're talking about.
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 26c4325aa373..d6c699553979 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -228,6 +228,13 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size
>  void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
>  				      size_t size, enum dma_data_direction dir,
>  				      unsigned long attrs);
> +dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
> +					size_t offset, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs);
> +void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t addr,
> +				    size_t size, enum dma_data_direction dir,
> +				    unsigned long attrs);
>  int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
>  
>  bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);

Thanks,
Olek

