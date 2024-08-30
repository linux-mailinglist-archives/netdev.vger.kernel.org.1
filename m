Return-Path: <netdev+bounces-123696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36CA966304
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C0F1C21B50
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7131D1AE033;
	Fri, 30 Aug 2024 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aReSiMjB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4C1199952;
	Fri, 30 Aug 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024937; cv=fail; b=VTDGww/VjoawnEucg8lMy7Q0LxgHxlgeWGqj2txV/fXYuXoRSM2Ay+vCj4NpG8DD+ZrHQU+KGnH8ZdBpBqAd8f6Zw/Lv8rUspYnni3c8L1loE4xB8Syjtw9uxaRmB/xqTQ3VSP2R/Ylub3hsgmRvfPLiKNQ+30JYjaKZtTCOGOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024937; c=relaxed/simple;
	bh=AKhPJGr6eEQU+C1tIwV29h0eoC5KDvfdMztqpXJhEHY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bcXLFNUpr0n6R4mJQE42otU0+efAT5X0cbwWXVFZXTidLUll05Dk2OWUtsShUU7AeuZ17l3qhaOVJ8ivjK/dp+fj9vRYSJdw1Uw+0gROKTaFEx0cNmjhgqB+lkYt1/DEZB7EgCuT4zPv/5ffEhCraQ5xHJC8siGudhxUL1ejytI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aReSiMjB; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725024935; x=1756560935;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AKhPJGr6eEQU+C1tIwV29h0eoC5KDvfdMztqpXJhEHY=;
  b=aReSiMjBCKeCo7AHSt5VWNTXXAA/j5WLgP1lUbk99w8n+vfqgCxMDqHN
   7haLNRwCbB5k0pxex8+DRQ8oePRy/JkBrmp2hL88rzpDuz7Hl7YY6U0ZI
   zrVcsl/ivjyyEq6aSfIBnNQnclJjLHG/qJnzFD0wenorUQb/Cx5WEwu/n
   jCX2rCP6rudS5R/Iv0fqSWeJq2gQe9AOR+oiIWXxtI+Z0PMLDhL18+RP9
   EijjQpj96AypQSKrNC9dTsFEFEwxA3GSt4DGKsE/Ui6pLCRr0O8gQFmHb
   zfl0qwFC+pjQPWIZUitXe4YaB6VZo3noj7zuMNaNUxsZTF7dMyOP0PqWw
   Q==;
X-CSE-ConnectionGUID: C+PNLtDuTH22u7rzhhzmcw==
X-CSE-MsgGUID: me2D1xDSQF2oXhjuGxhtRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23803187"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23803187"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 06:35:35 -0700
X-CSE-ConnectionGUID: 5NsynZ5/Sg6ftDHbJvlpMw==
X-CSE-MsgGUID: RMWRk4DbSn+7U8NToVwe4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="63527307"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 06:35:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 06:35:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 06:35:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 06:35:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 06:35:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyGjfoWg5a0nmYqB8VjEyJ/GEiKOos/ZVNrdfoc36Qjot7zMzBw6/x/gIFUUKiJYw9r0UM9mNL2GMBlR851FGPExs3btc8cRllHGJvXEjeGYo0QHr/VxWNKl5Di0104xdDhVc9l2I9ldweE9QBfwQFqbAwx2AuskBSGoaXSlrdihCtW0FVdTZjS8tYLbO+vgUm/vdK/QQ73VWc1qvnqU0RsP0rPfIfGRycjO+t0VFytgDJZ+8XQ83AuyFwheYgQb/hR6St/vXC1xsGlx5f3/17ahz13XfQ0WtkRrOoUsMeDrbmTa7zVS8Bvs/YAKJUzz9eT1MmfbPvSPpqXpc3hUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35DA7G4KA7zyBelONph8WHfTzp9ppFX9yJgXGYM1Q4g=;
 b=aTz+4c9bGWkhMJkoD7Xa9Fc03lPEZR5pjUAcgAPSgCwaJqdCB4F4kJKQO1vZ8u3gCnYFt1qUTHjwQe9HG73qTOallNN67MIABBbx9GkutbEdJjcRKDJHJ0Q46EAT0PPvnS/U0Z+n1kKlow8ClIFnclYgk7yhABnhb1fZiuoCQ75dNUs7ujz4ohfzRIgIoCJkJpDWL6ARXqI8vs2VqVBhEIst/EY+cLOTI8TqbcrM8nBXr+IbwwdErH49LadvLxqJ3rq/AmQTrQ8q8HTambQk2CMOU3jTwHWlCoLIqtw23xKqJR2UTJVysKe+PejqryQwbLpJDLmzvMeVu4uHB87m4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7332.namprd11.prod.outlook.com (2603:10b6:208:434::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 13:35:30 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 13:35:30 +0000
Message-ID: <8de6d7b7-686b-4eac-97da-6c7c9c590721@intel.com>
Date: Fri, 30 Aug 2024 15:35:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: stmmac: drop the ethtool begin()
 callback
To: Andrew Halaney <ahalaney@redhat.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Abhishek
 Chauhan" <quic_abchauha@quicinc.com>, Sagar Cheluvegowda
	<quic_scheluve@quicinc.com>, Dmitry Dolenko <d.dolenko@metrotek.ru>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240829-stmmac-no-ethtool-begin-v2-1-a11b497a7074@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240829-stmmac-no-ethtool-begin-v2-1-a11b497a7074@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: b26b633f-00a7-42d5-bd47-08dcc8f89d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2dmVDlEMEFCd2lBdVUzL0l3Y0Uza05UUkE0dlZMdEU3My9LRUVRZSsxMitR?=
 =?utf-8?B?ZmNUVGU5dk9hekNzbUwxVG1GU004TFRpYTZmTmJDWHR4eWV4bXkzT0dDaHpY?=
 =?utf-8?B?UG5RNGF1c0ZrejVNU0ZNY0VvV2tpdDR2SEM1VytXQkRnVVQ0WWViOGR1ZnJC?=
 =?utf-8?B?Z2ZDd2RzaFdmZXRma08zM0h0ZFgxMHRDMWlyVDRUWFRrLytaQWwrRVJtcVl3?=
 =?utf-8?B?dC9IUmxJVUlDZWNETS9aemNzSG9taG5Td3Eyd2oxeGJZV2k2L3pOaWRkMnRT?=
 =?utf-8?B?dG51REFuTnJRcE9PdUVFdU1jdEJuVTBuSzQ3U3I0WmlCdEN2VGltWnAwR1A3?=
 =?utf-8?B?SEViMFdlWjhHY2d0RW9UNkFyb0gxSEo5dm9SODFMSXJ4NU82Y3BmenhqaG9W?=
 =?utf-8?B?dFRyd0pKS1crc3kraVhQREZJOWdSQ1E2ZmkwWGNpaGpjTVlSY1FnMFNvazlK?=
 =?utf-8?B?VkE0Nm5PNStiT0dOTzhJTHczTHhUWmZRM1pOVHJpSnFxQ1ZGK0tESVUwbE95?=
 =?utf-8?B?US9LaXdIN2hLc0VMdlVISVVHNHNtZ3EzVzJaeVh2bm1EaGFOWkhtaXR6TlpU?=
 =?utf-8?B?S1FEZ1FtL0ErT05HcWNDNEhocGNKTzV0NC96LzB6alVKeWhhVDZ4T2Zualh3?=
 =?utf-8?B?N0JxWVRJUjdTdWNtY2g4K3pwZUZueUZJYzRVdFRYWGFnZWZHTDdVTDNkTC9U?=
 =?utf-8?B?UE5HNnlhanR6NUlsTTlxMjNLWS9xM2tJaWs2N0t1Mmhac2hKN1pZYlh3QStq?=
 =?utf-8?B?SjExVmJaaHJsUjhSdVZrZi9JbEMxSG1zMi9uc1BPYit2RnVsMTkvaXVNZTM5?=
 =?utf-8?B?M3o1NEw0MHpEdk1sWjFNUWJMVHY5T2lzNTRJR0FKNVBuR0NIa0tnKytPU0do?=
 =?utf-8?B?RGZZWS9wYkI1bVpnb0UzQWZqM1AwYVJaMjdyVlBGaUNZUWFmQVJNME03TmFD?=
 =?utf-8?B?OW1NTDUzeHozQ0NVQTFFWVJqK3hpT1JjQUFKN1dCQnlRaE1DOUlmWU5hdlY0?=
 =?utf-8?B?TXk1a2JydklXL0dDcFkvKzlnRzFBNFZsQnNOUFU4U091b1BCWDJhWVZnbHdU?=
 =?utf-8?B?b052QXo0S3p4OFdkYzNtcE00MVhNZE5QTjJaNFBvTGVsQURaU2pKTmR5UTIz?=
 =?utf-8?B?QllxK3dTcXgvek1NdGQ2QXdLTklnVXo2YWl3ckdKbFhUWVJUUDhLK0JCUTZ0?=
 =?utf-8?B?d3FPazZNb1lSWXJLR21mSGdpTHZIVEU0MzNEVXM1SnRMemt5T0p1b1l5R2J5?=
 =?utf-8?B?WTJUQUtURFFDR3F4a0I1Wmw0VHQ1YkVrdXJrbTRiUlF2V1RhN1FaU1JWY1hX?=
 =?utf-8?B?RFI5UEliS2dXOW1oOFl0VzBrbFpGcnA0WURYb3dxTXFudTFmQllqZEI2M3k5?=
 =?utf-8?B?MnlkaFNDTGoxS2Y5TXBWU1g0SExsUnE5UTVtUUEzZFZvcC9LencvbFpXVGND?=
 =?utf-8?B?LzJ3L1cwckZvL21OMTZXZHdDNExyYVBiUzJkSEt1TGZhWmpheEN0MW1XZE1t?=
 =?utf-8?B?TTNIcm45NzNkWXlUVG5lZEROeUlxMzZjZFFVK24zbkw1M1htZHhyUnpHczRr?=
 =?utf-8?B?NkNuSWxNbTJrNVFXSzJwMlpFZ1JPNUk5YncxK3E5ek5WUjhKZFM2QzRlOXdz?=
 =?utf-8?B?dGhWSmpHLytBN2pHZGx4UWd0bCs4YWdSQWRCQWx2Vmt2NzN4enRzajEyc0NK?=
 =?utf-8?B?MzJiRUM2eUVYY244SkRnRm04dmpXc0hmeEVWSXRLLyttVkJ5VVFYQnN6QytE?=
 =?utf-8?B?ajR2Z2c5ZlNRcEs3dWRad1NGZXdkOWpRaGlobUNjRFRId3F6MWlPN1NVNVdU?=
 =?utf-8?B?NHI5YXZlOFJ2aUlEVXBsdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ty9BLzE2YUswRk1LdjNRQ3VXc3BVYUJHellWMjhTbWhuOGFpSmRxckRyVHJ1?=
 =?utf-8?B?ZUQ3MW0vOXM0K0d0Vi9qa0RFN0o4TTM5Q3FlNmx4aGw5QVA3akhuL1J2aUtB?=
 =?utf-8?B?MXFCckY3Q0tWbnh1OE1ib3hjMjhSSWNFcTRmaDVYMDdWLzljT1RIQ1V4NWth?=
 =?utf-8?B?S0JLYkRwd01jYitLVTR5VzFjM2hJbE9xeWNyY01KdGFFSWtYb0laakR5cVNM?=
 =?utf-8?B?Qjl3WllWZjlqQVQ4Q1d2TkVNSUYxaWpMeGlrYWt5b1VkcWI1QVhmczRwRE9D?=
 =?utf-8?B?UC9DVXI2WFY2Yi9vK2tDWUwxZTZsZG1mdEVub3c0TUhxeHJ5ZllzVGwzREVD?=
 =?utf-8?B?ekY2RjlVNzVmZ3N1dWNrQnRBTENjRFcyQ0RGeVVnbTcvbUNZWHV2K0h3NE5k?=
 =?utf-8?B?Uk9vYmk2Q2k2YmlpRTJwK0EyNkEzdjl4eEN2SVFVZ0xYNUJpcVUwRU1vSlZk?=
 =?utf-8?B?cEd0aE5PWHVJeERkRVNUOVlkUzkraUlrMzBROXU2bnFlTHh6TUNLWTZkWEFm?=
 =?utf-8?B?U1EzZzNMUXUzaHV6ZHFjTzA2ZnhXUFZXbHFPUmZKeXM2RjVwTDZ1SnA3dHM0?=
 =?utf-8?B?QS8yN1VzTHBBcEVESmFrRWRoWWtkTmdzM3czK3NqTkJKdllzTlFDbEk2TTRj?=
 =?utf-8?B?UVZQUC9JTWJZZUpEa25IS1dISW80UUw0SzNxckhCblpXcjZnWDJBRTV6M2lB?=
 =?utf-8?B?cG1OWXEvWVZGcWl0emlkbE1tVzBIYnI4UjI3Q0FPY1BIMFFWNXBrS0hGa3V4?=
 =?utf-8?B?THFlM0IrUk9vcXlab3lMdFRUbmIxbTh6dC84Q05HUStiU2hNMVQvL2czTXNt?=
 =?utf-8?B?U1ZpS3Bndm5mQTkzN0NnYUxSaWFlVEhsS2VCaHYzd05kcTZ1MXUwUGw4ak5V?=
 =?utf-8?B?b29qLzRTK24xY1N6NTE5RXA4MEhXbGRyVWZFaDhMTkRlNzdIZ2MxZ0xGU2sw?=
 =?utf-8?B?dGhHNGtYZVlMa2VmZWhja2dkd0oyZi9aNjYxUklCdUg2LzdjYWNTUjNDQ3hG?=
 =?utf-8?B?Q0pIYnFFaE9jUEZvSHJLT2JpMDJhbW9ocFlvdUN6WnBrSGFyS2JqYmFlVktP?=
 =?utf-8?B?U2MwSEFaZ2VDVEJ0SElXdmVjUy8rUE9DampPRnBCTWVzYXlmYy8yb0U1QWdR?=
 =?utf-8?B?WVFJdG5QQS8rNmgrVEtFZndBRVhCL2czMjBVMWNwYit2NHloZzNFTnI1WjhU?=
 =?utf-8?B?MjRsRGVoMmg5L1dEdnlXNXNEQ1dMNXRVU1JmeGpwT3ZCRi8xRnc1YTBXbXRX?=
 =?utf-8?B?bE9uSFdWdW9YZ3pxUUpTd20rSHkzSXF3bmV3Z0ZrYzVWWjlpS2hib0hGTmg5?=
 =?utf-8?B?YjZGYUZZb2VRcFdqTHlndkdsRGloLy9xVTJYRHRnclJtU2p4T3o0ME1jSTZl?=
 =?utf-8?B?aDJQRnkxSGlNL0djWkdycDNLTlNpTTI5MDVZSHVwMXRNNzd4ZjFsOWdaVnFL?=
 =?utf-8?B?eEFEd1FDMFJTRlF4cXQ3WjRaU3FnU0dsQW1XaCtJVHBJdExOdnBEc0pEdm9z?=
 =?utf-8?B?VXlNVXM2VnZuYTdLc3FBZ3J6UENrYWZvcFJPNDZpUFp4VWF6ekN1Ly9EUnVG?=
 =?utf-8?B?NTY5RHVwZTdIeHQxdUJCNVN1ZkNoaENtMUFUYzJqUnZDdGxyRUM2VVdxdnM3?=
 =?utf-8?B?dzArUGdLd1F0NG9hTlhSK1IrZVpUWnNKMHd4SEtpdW1uci9rQ2lEMVRxT1VL?=
 =?utf-8?B?SmhNc0RsTEg1c1dPM09raWtLRlpQdlNWLzJZL1A2MlNUSVMweWZkVERsY2hO?=
 =?utf-8?B?eTAwcEpVTk9UZGhjQ2p0dkhHVnFsY2c3Nmg1UnZXdDdnOVFJdDRvS0ZFRDRw?=
 =?utf-8?B?clFMcFhVK2oxSm5nbFVnTTB0VDlkcTV5K1Y0dlhmUUZ0aHZwNktncUk3SEJl?=
 =?utf-8?B?TkV6Z0ozbGErS25tOVNwZXdEMjM0dFVLUXNKdFVTMk5nMlp3U2svcUd3aERM?=
 =?utf-8?B?TkZoTTNqdWMydTVJOXFac3FqenY1cXhIcFF3WURBRWx5WFRaUzBqek5JWnVu?=
 =?utf-8?B?N2dMUWJ4MmJBNy95dnVjZzArRURreWRuYkNPSmcvS3Q0UkJKeExrVzlFTnkr?=
 =?utf-8?B?QlpnWTN6RXBtKzErdlo5My9sV3JmalNwaXBNNXBITWNob1VsOVlyVXBabk92?=
 =?utf-8?B?V3lFaHh0c2t5TmRYWDhLbnorc3duVGlUTmZRd0Y5V1c5MWtsZzBRQkNUcnpy?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b26b633f-00a7-42d5-bd47-08dcc8f89d8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:35:30.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl3d6rGEyee8dVcn3I0duNOnAYkaplj2/xeFmN5pMkfIUK8lgnAba6JN8NDlj1UscdwDfUpcGceJboxUGAvFXoFrntdsrIzfn8N1z0lkbHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7332
X-OriginatorOrg: intel.com

From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 29 Aug 2024 15:48:44 -0500

> This callback doesn't seem to serve much purpose, and prevents things
> like:
> 
>     - systemd.link files from disabling autonegotiation
>     - carrier detection in NetworkManager
>     - any ethtool setting
> 
> prior to userspace bringing the link up.
> 
> The only fear I can think of is accessing unclocked resources due to
> pm_runtime, but ethtool ioctls handle that as of commit
> f32a21376573 ("ethtool: runtime-resume netdev parent before ethtool ioctl ops")
> 
> Reviewed-by: Dmitry Dolenko <d.dolenko@metrotek.ru>
> Tested-by: Dmitry Dolenko <d.dolenko@metrotek.ru>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Thanks,
Olek

