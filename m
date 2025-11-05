Return-Path: <netdev+bounces-236060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92029C381FF
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 22:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509101A20163
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 21:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97C2E7BA7;
	Wed,  5 Nov 2025 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDnzh0S2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977DA2E7623;
	Wed,  5 Nov 2025 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379817; cv=fail; b=HFbFkGP/uDig926rrGiAI8n5erYyEQyYWiPQGRt9DClggK9V200rd5AvGNC0lE4rfinocO/EJdrRJXxXwLbZ3+GWIuKpiyWuCZZ9p5zByj/6QJ9ydz+0EDENXfmjKh1sFE+hgp0FqJ1EyqFljONMcf5gkQO1lXhhIwb2bKwoDuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379817; c=relaxed/simple;
	bh=s3nrr4Y5hfjAP9kyytY4MoGTlKzkvzhSz4k+AmprkWo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aC8s9juKwuEaZpLnlP3/WKQgi00tb3LexQE9hXTmxPZ7/avfAVp4khrcASfRHhUmYDah2wMtcpfBW++lxYseMF8nRfn3hoIp1ZZootm84Yz/KBWGg0SGaXIYXmD1G0Jl19Rwy69GH98LnqyGhmKIlnIpyDT/VmUyrY9BS94VLZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDnzh0S2; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762379815; x=1793915815;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=s3nrr4Y5hfjAP9kyytY4MoGTlKzkvzhSz4k+AmprkWo=;
  b=WDnzh0S2/lHtvGI+LmdcNFFDoA/xZYZCcNgmXMsnmza9985Vw/BeTl2u
   zSxiQHfFTE5ofadQWlfrSepmHQYblM8l/QSk80MJfGoGscyDrhpdTik+s
   nBl1Ql8YSx3Ksi76l4mOLYbwpOQIkQVG2aroaCtGaSdH5o7L2jokoiNP3
   4g+ZFXuiK+C46Hv8KULQUcb2wOOG/2LVSIVWUXOM1m622JcOvdGN0k9z9
   LV1FWBmJ9BbQliqI0BGGQuv7v89EDgiBx4B7iLTjrWMO3mZSGRC7B3fpW
   Gwor2NkAQ98neYsjR/yvlFL4LZEeMrkb6jtu8fxXSb+wRGmPfdMppwGMI
   A==;
X-CSE-ConnectionGUID: zIQwMjWhReqe13duxRMIBw==
X-CSE-MsgGUID: DcFY7ma9TXmmSbgci+ApuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64422293"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="asc'?scan'208";a="64422293"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:55:37 -0800
X-CSE-ConnectionGUID: L8O3OKI6TP6MIegO4Ti1wg==
X-CSE-MsgGUID: RjTaSHcgSKe8a5gNj2+T9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="asc'?scan'208";a="211048005"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:55:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 13:55:33 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 13:55:33 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.61)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 13:55:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2W22m/xV9k8/hZOZ6LDkOCbFw+Z6BazH71p0zMfJg+WF5Kt9n63YxnNkvRCHznE+KkTlWi9AHy49QVR3Lg04iqfrYdXK66+rRqDoGu8XoqoXz/A4okraiIFrkcuBdcdWjla2mdAZgHSAa6v7XPITygI/RNd0ILnqeUIpDPixZMySxlB2pRpUKeXQN3X36bvh3UuwKLEWtIWnuPqUeKIKzqu3ipCsYskkjPop4RV0ZztXeszj8SS3rU+gq3WHx0rQvHtSGJHOEEjiP1f5A79va6im4EffgdpeGQ9F02p7hUbv8g0HfKr6yBownv+UsgSInslPzhjX3WWVf/7L18ShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f3v9qs8mH9QmCUqiXaa85e7bMhbtZQs8T5+9SS3MSo=;
 b=X9NqhNtj0Ykpyyhx5JpSgCW1jyCQIWBwU8QrSmV/K8365dBLxf3RmuAxtSnndAIcwsflRfxXUrvaCJma1kB/lhB/CmgtRp5lgq25zpBU+bfUR9G+xaeam9FEC+7WBIbBqC0TpKGA2DB4ZCpvwyJdw1EvWiT6jPTwMu4Qra2hAtoDXRWg2X2ZIudGW03lrIIKso2s60amP0klLV85i4TijX4XPu/QVP/FBUoH7uN3/YaHBECCH7JH1/5hg0BYzM83aHWFcKYm6tn8j092Cn1cfKSVkamFySoONNI5lKqPYZR/UjzfYLgbwy2LKWPuDmld+ZxHpL6PWYdf1YgBy9jd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6105.namprd11.prod.outlook.com (2603:10b6:a03:48c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 21:55:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 21:55:30 +0000
Message-ID: <a5ddc43a-5354-4951-8691-1f3887743e3d@intel.com>
Date: Wed, 5 Nov 2025 13:55:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: rtl8150: Initialize buffers to fix KMSAN
 uninit-value in rtl8150_open
To: Dharanitharan R <dharanitharan725@gmail.com>, <netdev@vger.kernel.org>
CC: <linux-usb@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com>
References: <20251105194705.2123-1-dharanitharan725@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251105194705.2123-1-dharanitharan725@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Si0enKNQUD1zjfq61YgWnnjd"
X-ClientProxiedBy: MW4PR04CA0375.namprd04.prod.outlook.com
 (2603:10b6:303:81::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a29de45-972d-4057-b8a8-08de1cb6093a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?endnNnVMbEt3dTBmQ25BbFlxaEcrQ3pET3Z5b0EzQVg3eklGSEZjMjJwVUZX?=
 =?utf-8?B?S3B3MnNtajk1Wk11Yko5NG9sYXM4dUNZdys4TUZVVDh1RzFCbU9VdU1hRCtD?=
 =?utf-8?B?OHdjSW9EY3FBdjRsaDBZeUc4V1krYUxORi9PT3V6VFp2Q1cyR1kzQjZab2ZB?=
 =?utf-8?B?cUlhM2tJL043MmR5cStVK0loOFViQnFCcHR1VDZuWkR1dG43bGFlOEg1b2lP?=
 =?utf-8?B?VWdRYUsrcVFjbVRyRXc4ZWlDNWdWZC8wK3M3ZXErTmprUEhadVkwSDMra3h0?=
 =?utf-8?B?TXJNOXRnK3FDK0ZEdVNnVmpna3lvR0VzLyttbFpwNlVQUnhNY0VRZUpyam5B?=
 =?utf-8?B?TURqZWhJWmI0aUt5NzAzRDgxbUNnSXNnNVN2MjVSMFplYVVneFJ4WlRCZEtz?=
 =?utf-8?B?dThlRUZReGVyQ2pDYlgyWXdJOVhJL1J5Yk8zcmo5bjc5djZiT1ZLaDR4cmJN?=
 =?utf-8?B?ekR5VUdEWTlubW9Pa3FtS2pGQ1lkR3dTSjM3UjdyM095b1FvZHM3ZXlKRkpz?=
 =?utf-8?B?VEFsTEVkaDVOOTVUcTVWbVozSTRCL2VrK00vU3p0MkdGYlpvQzRsRW5meTlj?=
 =?utf-8?B?WXZpaG9mQUtjR25DM09mNFRlK1dJR2pGRVFQajVpaCs1eTdJL3psNjVMblJN?=
 =?utf-8?B?eElyV3N6MWdUakEzbEhxRFdueG5wRnIwNnJmMjIvUHNpVnI0Ym1oSDJiclNl?=
 =?utf-8?B?cnNIY0Vyb2MzQXRUU2ZtOTExd2wzbFFLUmFMZ05OOTJXS2c2elY2L201M2Mv?=
 =?utf-8?B?QzJHTUYxMFR1b2dYbGtBRm04Zll3OXpmM3Y1UUZnT1pYQ1NXeW8vZFpWci96?=
 =?utf-8?B?OFo2T1BtM2IrdWQ5dDRlOG90WXBBa1h2R3pXcFFVZDlWVm9PZGwrNEp6RTZX?=
 =?utf-8?B?amlOL3FTVy9nSkpqSmlCdDh6cEhNOUtkZ3lNVlNzUXBLUFBhSHc3N0NpV0ky?=
 =?utf-8?B?cjZoaXpiRW8yWCtPclRBWkd6M2t3L0wyMWdsNTFYVTVYT1F5K094WnpQRE9n?=
 =?utf-8?B?R1ZPWE9UTWpRZ1A4aHk5YmRYckNYNXhrZkZ6dWJsWWtkeWNiNTdnTFpyOXdP?=
 =?utf-8?B?TTI1ZU5UL2ZHa0JYVzh5SWM4cEx6Q0daUnk5RC85Y21sMHFYVFMwWE91Qmo4?=
 =?utf-8?B?OEd0MTc1ZkFraWxpNGk2Q2pTb09acnNGQjF3MzVLRUpScGtBYW9yR3Z6UGlN?=
 =?utf-8?B?ejFxcEUvQ3N2QlBBRUR6UjFUMEl3c1I3RDNCOUFRS25VaURtS242QmxiTGxo?=
 =?utf-8?B?UzZsbHRUU3N0U0ozQzlxZUxJWU5TZjgweFY0ZDA4Rm9ZSlMwWDlTdFc3S1NO?=
 =?utf-8?B?ODVMNllGY2FNMVRsMnMrVnphaHJneExQNldJUUZMempMakdsbFdNajhULzFN?=
 =?utf-8?B?Mndma0gyeUZiK2swZVdpZllvU0QzdTNyb3hBb1prNXZzYkVjeHYvbzFXTC9i?=
 =?utf-8?B?djdEWHlNQTA3YkhsMU5BY0R1aGtDNjN1cU0vS003YzN1aWNJeUNibnJzLzB3?=
 =?utf-8?B?Tm5Hc0NES1hma1dQeWZUSnhQWHB5VGhIbU1EWHNJZXdkaDA1VG9qcldxWlVX?=
 =?utf-8?B?RzVTTFNnWjg1T0txTFVwOXBVbUplYWoyU1QzU1UrVXhnc3laa2ZpbkxwUU9n?=
 =?utf-8?B?RHZNSWs1NWcrQ0lBU3hxYnJZb1ZEaUI4SndjL29RRFZVOXVqOE1NOUxMM3Rt?=
 =?utf-8?B?Qmt4YnNkWEs3dm9WZ004NGVRbGxWWXVZSFRGUXRaeTVrcDdvOFBzZFJMd2h2?=
 =?utf-8?B?MEpOUGVhdDJvNG4wOHR2WUlsUjE5dXVyWXZkeGdxNFc3TlBDbnN4RG9KYnln?=
 =?utf-8?B?anBSanViU2h3QnVkRDhYMlQ2c0xRUEFEWmxCM1lRWGZOQ1hhOXlTTjhEZDVp?=
 =?utf-8?B?eFhUakRxVFpsdVBjQmNVQzZKZkZMaGZXVUJFclhGM1ByS0lFcG03Q3hDTEYr?=
 =?utf-8?Q?VZgcjtdPrf5TBtAaPRUEUQFYVtHhY3lW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzFhdEhnODA1UElGWHFzWG4yd1NITTJ0SC9hZDBOVFVMRys0TnllZURLeFFo?=
 =?utf-8?B?cnlMVnc2WGVZSk9NVlRkb2VXZnRKSVdpLy9tR2dYaE50U1hmbW1vSGpZTzhi?=
 =?utf-8?B?NlNRK1JqVm13dG9KOCsyVG5xV0xsRWo5Ui9Ga1VmMGpBcHMraFJCKzQ3MHYr?=
 =?utf-8?B?SStnMVZ4djRIdDdYVmt4c21TdUtwUjhhMFRCM0tQK0doSzFrWWVLalNkNU1I?=
 =?utf-8?B?b1ZBV083OCtaRTFtclhFNlNQMHdSTGs3WFoxSS9IdHllK2w5TitSRnpYYWRB?=
 =?utf-8?B?VWJpdkc0TzF2WW93djdTaHpUeWx1LzM2bzBkc3dodTRnOW5CZXh0dGtEQWVq?=
 =?utf-8?B?ZWhpY29PcU83eXBnNTlOMUlBdkt2YW5hbERFc3hmTUhJNXZhTTV5UGFaMW90?=
 =?utf-8?B?UHF5bnFTb1p1b0krZjJYc0dLa2M2aisxeVgrU1V6M1lJdzBEOHM3czczSmdS?=
 =?utf-8?B?SXl4dUNTM3hvYTgwZHhRNUtwZ0RXQy9aQW1DejlJam9xZXpRa21YeDZmcnRr?=
 =?utf-8?B?TFdKY3hLRU9Ea3V5dUh4RWxPbEtqNW90aS9QKzJWZHkvSEtoRVFBYmJKdll5?=
 =?utf-8?B?YVRRb0RWN2VFbm5BaDlMbTVhYkY1dzNrNE1zTTdHenBLY3ZidW80MEZyUlA2?=
 =?utf-8?B?NVhXUytpNUVpUjNIVFMzOTgvV0pJYU1lRzBuZDF5M0JTcmNQdXNrQW1kVFJM?=
 =?utf-8?B?aU50RldNeHZtQjQwU0tXZVlHdi9XdGZvZ0U1VGFuMUlkRkk4SkMrWmwwY3Rs?=
 =?utf-8?B?aXN3SUErQWR5cFRxem9yaUNZZjlQOHpVMmFKT255SEZIRUhnTTZXSWNyUWk1?=
 =?utf-8?B?My9WWTA0VnZFbXhnY3Vxb3UwMS9HaGkwSzhXditqTWt0OTMxd0MzakdibXV5?=
 =?utf-8?B?aUxjZDlIRHBjajZXY1pGemJ2bzUrUHNEckp1R1R2M2N0ZUlQMTF6L0oxSDVB?=
 =?utf-8?B?a3g1LzA0TWV1Q2hVOW8zQWRpdFNpc0RuUCtQT2p6ZUVqcWNYMGdPVUovQnJI?=
 =?utf-8?B?R0RROGttVGVQWmtuc3d1d2hEM0NiKy9vdTBkdTV5NnRVOWRKN2VhVktwWlRL?=
 =?utf-8?B?MEdnUFh0WTBJYkxBRzVsdmQwQ3kzV3d1ZUQ2QVJiYlY4OHpOQ2tXR3gwQ3d2?=
 =?utf-8?B?SlRGMEdadmt3anorYUFCZ2dZRnJEOXdnall0V0gxSjNUbFhhRmRVeXJYNE9X?=
 =?utf-8?B?cnJNd0VOTmcweDFDMEZ5dXY3SklJWkE0c3NrQ1lLckI1SnhtS1l4ZGFsRmVN?=
 =?utf-8?B?T1Fpb1hnR0ZCRXpldkV1b2lORTFnMkpVMkpWZ0w3UDlDcU1jQk5GTTZQRHBj?=
 =?utf-8?B?ek5FeDhzKzdTRUttYmtxOC9JTkx3RXB5Wmk0Mis4eDdkeTNkZlJUR1lPaVQv?=
 =?utf-8?B?VmJ3SzU0bzlEdU54MlJ6QjRMTEwzUVI1ekpZZlR4bEkzUlNTVE8rZHN4Wkx4?=
 =?utf-8?B?bllKQVUvb0xpcEU0YzdmQmRmbkpLc2R4bDdzOFlJNXB5K2QyV3VTVnZlbHpJ?=
 =?utf-8?B?Q3hwaE5jSTgxSmhhZGZIVndWaERoUUcwVk5BSDN3QTlOcDRKbkcyS21CUjdK?=
 =?utf-8?B?V3duRnZ4cmhaWFZuaWJDOUpZaHNQWCt1bElsbFcxOCtQYjlnejFJT0hwVzN3?=
 =?utf-8?B?UXYyZkZpcG5rZEwyQ095eUFwbWZNdmdKSVZhbDFJUEZVcXBhK3lFSmczR0Y2?=
 =?utf-8?B?YjF6d3hBazNFK1A4QVB2SHFzYUZKUG9nNURTb2NldjUwL0Z0Rm9uaHl0RUVZ?=
 =?utf-8?B?STl5eXo2dDBYb25xSDZIZ3NvSjdTeGlwN2pzWG11VGEvd0s4dlpick9GMlJG?=
 =?utf-8?B?YndpMlJWNCtwR1hMUWdYMnJweCtvdHd6aE1EQlA2cEpaZkU3RW9BWnpzZFpI?=
 =?utf-8?B?YStuSzFMWEdya0daR0NlN2dySnUrdThqa1dHeU95U08xSnR5Q2N0dXZUcDgy?=
 =?utf-8?B?eXFOSFVtekZoVjNTWSs2VzBGNkg0aU1PWXc2UW5tT1UyUWF5d2lEOG9rL1BO?=
 =?utf-8?B?cXl2ajhlenJsZFVUSUJobzFlU1Yra3NIRTM3RDBISlF1QklKdzVqQWxyK3Aw?=
 =?utf-8?B?bzAvRTdHSEpqcG53UVI0MUt3M1gyTHdZYk8xbldwWWhqekxaS2FUaUl4ZnhT?=
 =?utf-8?B?dzJyd1Azd1VpYndQbi9nQUxJR2t1Mnp5WDZjSUZKcFE5dVg1b052Rko3aW5W?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a29de45-972d-4057-b8a8-08de1cb6093a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 21:55:29.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1D9kzdVunIBNFO8LcPbRa0L5HI++XpIjQ0y9MvD9fmFHoxWXu3wvjf08yjdKocu9/jmH5M6Hs2Wt4AnlmQQjfC1ViJw5IjP8DWRj1KwVM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6105
X-OriginatorOrg: intel.com

--------------Si0enKNQUD1zjfq61YgWnnjd
Content-Type: multipart/mixed; boundary="------------uUhamN01a45tpok7B0LgN4ux";
 protected-headers="v1"
Message-ID: <a5ddc43a-5354-4951-8691-1f3887743e3d@intel.com>
Date: Wed, 5 Nov 2025 13:55:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: rtl8150: Initialize buffers to fix KMSAN
 uninit-value in rtl8150_open
To: Dharanitharan R <dharanitharan725@gmail.com>, netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com
References: <20251105194705.2123-1-dharanitharan725@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251105194705.2123-1-dharanitharan725@gmail.com>

--------------uUhamN01a45tpok7B0LgN4ux
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/5/2025 11:47 AM, Dharanitharan R wrote:
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index f1a868f0032e..a7116d03c3d3 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -735,33 +735,30 @@ static int rtl8150_open(struct net_device *netdev=
)
>  	rtl8150_t *dev =3D netdev_priv(netdev);
>  	int res;
> =20
> -	if (dev->rx_skb =3D=3D NULL)
> -		dev->rx_skb =3D pull_skb(dev);
> -	if (!dev->rx_skb)
> -		return -ENOMEM;
> -

None of the changes in the diff make any sense, as you remove the only
place where rx_skb is initialized in the first place.

>  	set_registers(dev, IDR, 6, netdev->dev_addr);
> =20
>  	/* Fix: initialize memory before using it (KMSAN uninit-value) */
>  	memset(dev->rx_skb->data, 0, RTL8150_MTU);
>  	memset(dev->intr_buff, 0, INTBUFSIZE);
> =20

This isn't even in the current driver code, but its shown as part of the
diff context. Based on your commit description this is probably what
you're trying to insert? But its obviously not a properly formatted or
generated patch. It reeks of being generated by a bad LLM.

Please don't waste reviewers time with this kind of generated nonsense.

--------------uUhamN01a45tpok7B0LgN4ux--

--------------Si0enKNQUD1zjfq61YgWnnjd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQvH0AUDAAAAAAAKCRBqll0+bw8o6EeB
AQCEFkfWNm8WXnT1TNjS9TH7rxQBkF+zMH1K8mcCBiEAAwEA5uobAYD9rti4eIUgs6A9Ekdv5kO+
WPjcoe5dh99x8QA=
=cBA1
-----END PGP SIGNATURE-----

--------------Si0enKNQUD1zjfq61YgWnnjd--

