Return-Path: <netdev+bounces-107173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F9A91A2F6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78492281BD1
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA71386C6;
	Thu, 27 Jun 2024 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ef7Gy/9U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3855132492;
	Thu, 27 Jun 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481743; cv=fail; b=Nq8+8wk21kWo9RWXbOoFuyFRj7K5V5/l6JRJcaG7TY2jnKhYPJ9CYnej+wZhANlkPPubcfGLfzN4H/nUQxm2mG2He9OXM4tbLZEB9TMjEkGX3OQ59aCad6D4I0UbVOkq1SNMbfN/yu7/GYAqx8aMD8Xze/ILROI//6mukL1pV0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481743; c=relaxed/simple;
	bh=YoP8q94v1WXS83D6Vv7qztRmil0PybOo7WF04nl8yKM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lrh8byUAMacoAZjw0V46783QRciyLdqc6+mBTVl5zlEEKq0WQheOWxgbPffYgG9O+DbZMdBU7al7JIHHppvn7mbA3jqrgn21mncuwDn1PhS4WrwtctqHcuk/99B2ANghtqayiBItffQWE+mlTydmThKuzqdE1O328boALt6eQGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ef7Gy/9U; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719481741; x=1751017741;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YoP8q94v1WXS83D6Vv7qztRmil0PybOo7WF04nl8yKM=;
  b=ef7Gy/9UIKfiZIOh+5EyTVgWcXXTWgEEzBYq4ixbYBYMsuCL2SOMwVVc
   7KakPdY/ChfjxeUWUT4nRgptG5O9asN/B/xgsYwzwutM6eAOZGE5fkcsz
   USOWFh1Dn0m6xOQJqMA4z5z0EYTVeRsdM+erWy3tImZeT4ihLdx4rDaMv
   TYCDFEoDOHaNRz25cf36vqnCHoH6vih5go/kR+yh7TLSe6AnQ/YFjFwBA
   srURRGHEF3vjDVbDrdsuXa3jb4Sj6QX/AoicUu6lMjWyuHksr/QBWtAbV
   Eker1QJNRGSBIyAauzoQHLmqWJCXJ/xiUqorD/DXLaJ20po96fCkQ0wc/
   Q==;
X-CSE-ConnectionGUID: L79WlsDGQoKhhFfgBN7qqg==
X-CSE-MsgGUID: PzBvz9E4RyKG2p90Wigqlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27734896"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="27734896"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 02:49:01 -0700
X-CSE-ConnectionGUID: waJxyJYkRLiJSFzNEoqO9Q==
X-CSE-MsgGUID: mxvSRd6pTjudU5y1HNra1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="44981785"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 02:49:01 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 02:49:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 02:49:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 02:49:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRbIAGPXdSe37SL4F6w0eZ9tqh77DlWCl9hnmTwUabiSFOcpQBSj3sKqf+iZvf4TAEMtSpZKGjytiIsjGkBZO1JWWGyjbjMppATTbht18hKDEi1gJCApnfCG97vOKBPiit4l97gCzWDV+FkK9GxfSKxD0ZRm6REJRv2ZdcmJMSUEiVC4vHFqEq1Yeg27Gkvdw933PLMcr4xpSsaXK8m83lPDiwmjkOzG5sPLV4gIBdg+iorZ16lc39UD75+of/nE/nPXf4emCuQWqXgnUg+mgGVl2nCTYgFkpzZRVzZ0pPDlO19oMOnqCaZT7X2eXHHhCtDVbnINokeW/AgmOUM5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbG57XcO7vUl74WECO56O+viyZIJJhA1j3BZLxGM70Q=;
 b=fyM+eGAIJvWYQPM7ht3R92Wc9PrAdj/f7QWClacnBkklQXNJU3QXDyMAMJuDB8U6cCdk1gouLaFnkVjnbDiye8yOOqzWnwHZbA3UAa6/jKKi7Saed14K9aSyweBjzkOWe5BqX9gPj4ODy1XDsv2229zXnQdnVQPTfP2iqh9siprBkL7ikkVc3o/67J0ftmv7j72kqYranCQnOOsCxANXvkrvzFr1zI85KuGCnudoreb4NoZEyQDPy8Zo78xUh2G5Pm9y39tHPXIZOoF63r+gJzYuuE2CTxUYSRveR5+Y2XB96fTMh1CIGmGmZMy4R3m0dLNsXcxH44v9SKPJRBxSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 09:48:59 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 09:48:58 +0000
Message-ID: <d0b4bea5-58bc-46b7-bb47-110f4c5d4132@intel.com>
Date: Thu, 27 Jun 2024 11:48:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] netdevice: convert private flags > BIT(31)
 to bitfields
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
	<andrew@lunn.ch>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
 <20240625114432.1398320-2-aleksander.lobakin@intel.com>
 <20240626075421.1430e8d4@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240626075421.1430e8d4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0045.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH0PR11MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbafd3c-a5f5-4970-c5ed-08dc968e5df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGxXRW5ybFBydzY0T2Y4WE9iUk1BbnZrSFBrZ1NGL3UvMDVKb0liWUduWmwv?=
 =?utf-8?B?YmQ1OFVvNGJKNXh1R2hueWNmKzVpUmlvODM1RFAxd05PRG9oRmV6Q1VvZy9W?=
 =?utf-8?B?Q3BnbFNyRHlQQVk3Q3VialVnNnVQU1NlRnZJeDNLN1BmTG5vZmpYSWN4VzBm?=
 =?utf-8?B?UUJuL3MrdGZrZkp5NFZSRURXQXE4eldDa3NISmdrMlVzTGFJUjJIMnhES3Q4?=
 =?utf-8?B?Y2VOeFFBYkM1NTFOU3ZJY1RRYkVBcElCV2hxcWNPb0FRendmQXZqMVk4TVFH?=
 =?utf-8?B?M3pCTTlNTXdENWNMSHJxTjFYUTYxR0NnVklDaThlY1dhODVDaWlma2dMT0xM?=
 =?utf-8?B?K3cyQktxT21sZ3FERDR6TWxqSGgvZUlIVklMaXJiM3RIbGJVdVRDYUVtdGFs?=
 =?utf-8?B?T1g5a3FIak5jTlNQM0ZyaEpzREVxNmZjd0JIQnBKRjcvck40clpzSlZMR1VB?=
 =?utf-8?B?MTVNQ1YwM3htY2xzSlVCYXc2Zy9qQVVBL2duRTRKdmdLaUhRZG03QXpJakxM?=
 =?utf-8?B?TVhseTRNSTNLVVBWS3ovMStrdDlEYWQ5cnRyNlJFM1BiUzRuSDI1RU8vczhT?=
 =?utf-8?B?V2pXUkEvVzVuaVNIUEh3aXozS0ZxMnJnRHovdW1jaE9ySGV4OXZxSjEvOFZp?=
 =?utf-8?B?clA4NVF4aklqMDY5emU3UzRDUVBlMk0zejdwZ3Q4REZPWHhzMjhiL2tiN0Qv?=
 =?utf-8?B?QnMyczJWUHEwTzJ5RDltRkZYUmtHN25jNnpPUGlmZWFQNlFxN1ptRVpnOUlm?=
 =?utf-8?B?THlwRnFKWUtYam01VUhEd3V0YjM0cFROMFVvNGc1YWgyZE9PWWtTbjhGWWZx?=
 =?utf-8?B?dU1jSUlDcmk3MFpVWXJJV3Z3dG9MY0U1cDRnZDBXUkxDdVFOTFdZRnM2WjVK?=
 =?utf-8?B?SUFOZjAxOEV3YURlVmpNWWZnMUNyN0FMRk96MG96bjZWS0J3R1YwU3k2STJt?=
 =?utf-8?B?eHNzRnJHbGJ0bTFpaTRSWGNreGJKaDR5KzFBbDBrdWt1UmRrRmZNZTBISWxH?=
 =?utf-8?B?ajJBdW9ZM29JVVpPYnlRUnRWUENZS3psK3dLSU5HcG5pc2Zoanl2SmRjdCsx?=
 =?utf-8?B?Z1crK2JEK0lxbTNxUDk5UnlEMXlQeGUxN3RFTFVjejRnNmw0Q2R6V3NKTGFL?=
 =?utf-8?B?U214UWFWSUkraUk5c1JPSVlXRmQwMmtPRGFqdUdHYlRqOW8za2MzQzdoNXdz?=
 =?utf-8?B?bzdRdzJGWnM0cG9IMGpYY0llendYODIrWGpueXFwUTNLYkFiRVIyS2hWVTlZ?=
 =?utf-8?B?cUhNRktBbkQ5c0xtSjJRL1I4TXpjTFQxSGUzc082NTRNbW16Y3FxK21aeGlz?=
 =?utf-8?B?NE9JVWFtRUhaMmRwZGhncGxMN250YlNHL1luZzAxM2lETmRYaGZxeHBXdTVz?=
 =?utf-8?B?VXQrMmo2aHNmd04xKzI3d1I3NG9McEQvcnkrUnhmbE84a21SRzI5dVU0d2Nk?=
 =?utf-8?B?YWVGQ09CSXd5VTMwTEdqak8wTHo2TlhOYWFuL2tWaG0rS1Axd1Z5alUvSE9C?=
 =?utf-8?B?TFozbklpMldqMlU4dmhINFBSSys2WmxiRDBrQmNOd3hCSFFNWEdJYmxITlNw?=
 =?utf-8?B?Q2VLZzhOZitENUhnOTBnOVhOdlo4Q2JaQWZkY1ZZT2h5K2dJQU5qeFIvMlJk?=
 =?utf-8?B?MDRSckltZWFEOU91TUVya1djbmtldC9wZWxsU3U3Q2FwRTcxSy9hakw5cDQw?=
 =?utf-8?B?TzlXYTkyWUdEd2kxSmxjZk5sT1lpUXNaRngzZUY0cUtvUC9PRGpXUGYwV2xE?=
 =?utf-8?B?Q01NWVhJQ1ZGMjBQSmVSWUFsMlFYbWwrVWcrQm9zWDA5alVXRGFYc1R6ZDhV?=
 =?utf-8?B?MmJhaVJPRmJ4U2Y5QkJvUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGEraU9aaUVoUzhaR3poYU5ROWUzRFhnT0JPYkYzaUtST3BsNk8welk3ZTl4?=
 =?utf-8?B?YnJ4WUR1MzY0eWU0b2R5eWkxMzBIdll3aWdQQzNwSUl3bmZjSnRmN09Wc2ZS?=
 =?utf-8?B?TzE4Wkp5aTRpNGE0MHdYbnBOaE92Y08xTUJ6NmxEdEl2YjlPVHRSMlVVOXhl?=
 =?utf-8?B?TTFYZ083ME0yY3RlZmJ4Y3FyRmZZWENab2NBVVI0YzhCV2MwU2pEa2t6VWVs?=
 =?utf-8?B?MHFaUDNFR3E4U05STWZYclRBOEQ2Z3ZJQ3YyN25YR0xQRU5HQmdZVTR5Q3o4?=
 =?utf-8?B?UE42YytRM3NubWVSb3R0TnJTYUFuank2bWxBVzNVT2NaaUNaWjQxQ0xUY0N3?=
 =?utf-8?B?c3hEcG1hVnJqVUpTRUxiYkxHeXA4NTFnSC9KQzJhNEtIYWNJWE1VUU5UNVVt?=
 =?utf-8?B?MWZUaCtqbkwrMU54WUFzdS9ENVFKTjkrYktzQ1VFSGxoenlwTGUzaHEwRW1a?=
 =?utf-8?B?QmNwNDJzMFJBVWo1T0lra0VaSFFaODI1Q1BPSm9pMmhyMk1wU3BZZkhrbndy?=
 =?utf-8?B?V0dyK1RjSjZyRnhFMVd6SFJQanI1bGpZQ2x0alM4bGUwTzArdmFCY05QQmZ4?=
 =?utf-8?B?N0MvZHVjTDUzdnh6amJPOC9qTjB6UCtMUjh4K3FqNUJzNjM5SnlmS0dhRGxU?=
 =?utf-8?B?dWNndGdrZTdQTnZ5MVRJdFN4UHZrRjNPYmxPTXZSeUhaNDVoMVdDaVg3MDZI?=
 =?utf-8?B?dStqYmN1TG8raEdQK2N1NWMrWmxvNUdTU0xpUGI2alVkVEhGbzNVY3NNTXY0?=
 =?utf-8?B?dTdSQTRpS0xBdGRyYUpmWTdVai9tcFVKRXNtK3M1M2RxZ0pRNURTRGd1cXZy?=
 =?utf-8?B?K3N0UjVkaVZzT2p3QW5PcTNQNy9zdWZaVTloajFUbUJSUDFzcWR0VFFyL3dz?=
 =?utf-8?B?YzlIWkljcnNaeEg1WjY1M09Lb04zVlMrMVVWV1Q0RXdGaHIyT2wwbTZHYlE5?=
 =?utf-8?B?ekJhMWU0bTNuR0Z1bE4xTXVsTytIQW9IMDBXNm0rRWU3RnBkRTE5N1hxUnRt?=
 =?utf-8?B?aFZzT1hCVHZjZlRpbVBkTFZzQWtFdzJMc1NSM2xrcm42WU1qbWFmWUE3MGhD?=
 =?utf-8?B?d2swblBlb0ljTVhvVnhlWSswR2VkU2d3TnNrZWxpODN6VFpJTTVXN08yb0Vk?=
 =?utf-8?B?a05tbTNzK3FXblVMRE5BRW1vVm5NWFdyaDJhT1JleXo0dzdMSHU1LzdyNVJa?=
 =?utf-8?B?T0ZJejJjbGFqc2wxcGFxTSt5RFFwUGpWNEwxVE5FTCswcnA4NkdiQXllRFRk?=
 =?utf-8?B?MUNsVExaWlR4RHFjZXRtT1EydmFPVkZaZUp0Y0x2cEhsMnJsdDlsNHU2TzIr?=
 =?utf-8?B?WVE2MDhvQ1N5cmFXcjdnOGJPYXY4OWE0c0M1b0FkaUpPTnl5QzliYmxGMi9Z?=
 =?utf-8?B?WVQ5c3o2b2lSeXI5RDFZMVRhV3JOWVp4NEFNUW85NEFvdXp6d1BJUEFDODNv?=
 =?utf-8?B?b2RPV0tpSmoxVkx5MkkwQjE3eUxMNThNRmJvZ1VmbmlwcVBTVXNCNkJORk5y?=
 =?utf-8?B?WTJYdHpaSEtYVy92d25hYlpsYlhCODQ3eXBLZWdpdnJUV0RPRTVSZWRTK2Q0?=
 =?utf-8?B?Q0NHRlUyT1A5Z2huZk1odTZybmd1K0M3S3lRQ3B0QlJXaU5GNmdjMFh4RUU3?=
 =?utf-8?B?NGVqMVAvbGEycDlSelZJNUMvVzU3TURiRW4xVlVaZVlWKzJYT3pZeSt2ayt5?=
 =?utf-8?B?azBJclhKSzRZVW81VXpUb090a1ZiTHhXeWh5dUMvdGh0ampOd3R2U09QMjh3?=
 =?utf-8?B?RjczMGg2VzBaQk8rSXhRSTlySUlrcUplMGxGa091OExkR2QxeTVsYWtiNHZO?=
 =?utf-8?B?NS84ZjM5UGhjQVVBYzNEMjM1dENCZ0JaSVZKOUF5c3dmbGkxazVSeFo3M0tn?=
 =?utf-8?B?UTQ5UTNEdkhGS1hRTmN0SFpZa20rL1AxZlRjZ0pjbzFQQzJhMTZaQTRKYStj?=
 =?utf-8?B?TG15dkNYTkhFd1JYVnR3ZUNRcjlFS3FjNjNkNFNSVlpoc1F2NmUzYUFRMnlw?=
 =?utf-8?B?UmZ3KzN5YTgvcFRzUUp1NjNQQldpYTl2dklMTVlzeFc4allIVW94VnlxUmVG?=
 =?utf-8?B?aEQyd3BaYzZ5TThhbDh3bVNGREpEV1Q3bW12c2I3QWJpMnRQT2RobDkyWkNW?=
 =?utf-8?B?Q3ZFK2s4ckpSMG1zWkVraWkzaWlXN2FQV2FIU01XNmxIemJVcWN1R1hqUy8r?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbafd3c-a5f5-4970-c5ed-08dc968e5df8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 09:48:58.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyyr4+yRYTkVlHTiXVaqcp4E9TBBsYlb5RxmbheDoGuVCt9vyDU5GlSe/IzyBM8heic/pX2oEaXnhjGdZ4i+1ZeO5Kgtatrsxlldvxpia5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 26 Jun 2024 07:54:21 -0700

> On Tue, 25 Jun 2024 13:44:28 +0200 Alexander Lobakin wrote:
>> -		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %llx\n",
>> +		   "%s  VID: %d	 REORDER_HDR: %i  dev->priv_flags: %x\n",
> 
> compiler says %lx
> 
> net/8021q/vlanproc.c: In function ‘vlandev_seq_show’:
> net/8021q/vlanproc.c:241:69: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 6 has type ‘long unsigned int’ [-Wformat=]
>   241 |                    "%s  VID: %d  REORDER_HDR: %i  dev->priv_flags: %x\n",
>       |                                                                    ~^
>       |                                                                     |
>       |                                                                     unsigned int
>       |                                                                    %lx
>   242 |                    vlandev->name, vlan->vlan_id,
>   243 |                    (int)(vlan->flags & 1), vlandev->priv_flags);
>       |                                            ~~~~~~~~~~~~~~~~~~~       
>       |                                                   |
>       |                                                   long unsigned int

Yeah, GCC wants %lx here, but Clang wants %x since priv_flags is
declared as long:32 >_<
I think I'll add a cast here.

Thanks,
Olek

