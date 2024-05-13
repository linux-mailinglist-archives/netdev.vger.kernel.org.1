Return-Path: <netdev+bounces-95896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892838C3CF7
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2CD28238C
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2803147C75;
	Mon, 13 May 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dq5FSfpI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F296146D6B;
	Mon, 13 May 2024 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588114; cv=fail; b=F+hw8ofQpnAVKT1oZfmGkBSP3mA+ec/O1NXl+pNx9D39HiNT9zwv6/Z+mLCzPDzZyTDEohMMCRdqL3sYf0icg62zKNNkM+aO3Om2upMkuZwpO72rgP5NaO82WqrWheHR6qLQiwwH4gO10KvVbSrKJOunNP7XF3lWpl4KyIZDGzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588114; c=relaxed/simple;
	bh=DbFz6whZqLrlKUEv3adzqBaZ62TXMorrz0W+YJr/CAo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IV0b6lVfs1y8Ca6ndpa+/mi+Xw9ZGDErhA4EIOVXVxDzhwyXO50/6cYbofn4SwgVzplTS+SHf6FGdZN16g4l1OEa8orH1Jo9CSSrTyluZeYQbwwDBhdpFFme98WMI5xFpzjf1MCglEkoVZNar/8cdMCtpZT81UGYFv5o/TDysw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dq5FSfpI; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715588113; x=1747124113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DbFz6whZqLrlKUEv3adzqBaZ62TXMorrz0W+YJr/CAo=;
  b=Dq5FSfpI5AwZG43VCfniKbJnkk6KSVhpUMcwesH4EOynQwpHD3TWZiAb
   rRpyuD8LNxTDEG6e9BT/geiCSC8UXtJMtcNnq9aIOQfhjHOlS6XHevBsD
   MLGI0bc9MHzsBAf3iuz/x/dUokDe/Pujqyu3M01+S1F4C5Lahmm9coY11
   uo1VJ6extQRhFD7ndH0AwfzGb1ealHCwRQNsF4OmenRMfi/IwEOoZojUp
   zvaMN/asdnLDlWfJM5rZW4vNzO9wD84jTvwfyMQv2xoU36HYjQncOjkO7
   IGpwmsBPyK2NAoJ3gCOlyLubpEbw8ctVjHt/em9RbbYaW5XSUUcqT+xgG
   w==;
X-CSE-ConnectionGUID: XHtS1ihqQYqEVILT+wUAsw==
X-CSE-MsgGUID: BSgv1mkCTvarxajoAS4qVg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11666876"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="11666876"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 01:15:12 -0700
X-CSE-ConnectionGUID: hX7FW9XJQyy7IxLxl4G/4A==
X-CSE-MsgGUID: 8fzAlEjVRLONQYS/jQv8cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="35024235"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 May 2024 01:15:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 01:15:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 01:15:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 01:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZYTJ9/JtBeurljUnwIX/QHQPPuBzfZ/KwJisVWt04C9Rx0JTj7U6fxrbN/aQmBV/UqH52gq26DVGzdnCh0G797PdO2SgWouVfXH9jxQ/ej7rdUGyaaWEm/uJ6FGnl+T62GdysbsF/SNGtSgoBXhjgOtsNgX7yu4ln6Ray1RqAPi0Mc3PybN4BVu6ufRq5p7u3qmkvns7nxMKGX0saUXJEiO5LC4I1TTGPhBje+FnEcBk1QvzoenWR9RPn+3BvLTmf4YIAoSTP9jU92y6gyNvyJXK94scgr0ZyeElCF7eCqsbruvsPAyM+nb4rxJpi/MlzJAMC+uPJ6Oe03XxbaHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyAIWCEiTKk3Vmhrah6UY0Jxu9Cb/vjuObGlL7qXYkc=;
 b=c+b4O/spgNM4JEqMS1O1fuBDdg2umYC65af/zG2oWpTbQioc8RMOCBbq5HBEPj1k1qUk+wxUCl/mYAGjMwqX3+5EoaakiE4eW9gVlo+YsdVGYyXKem1GQ6yldP69szfaqZ01T+bstsMcmSupX/44m3L68W4mKYxD929FsEkTHy9gUTLoYtqbvQqbc52MaJ1mVUcPxUNYruGWlC4rHj1q1PWbm3Ll1ruTA/8ipwGQU8NQXvwQgrZx44iRoc7aOv8KnUMQ7sSfiJuiym0NnlESIcl0jiYEEBent6byvWnwwnE+ufUXkx3MKHOr+41OQfsogA8U1UtdezPmwZ5ljtGTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB4811.namprd11.prod.outlook.com (2603:10b6:806:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 08:14:50 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 08:14:50 +0000
Message-ID: <8f599fc9-99f4-462b-838d-6da2fb19fa10@intel.com>
Date: Mon, 13 May 2024 10:14:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dpll: fix return value check for kmemdup
Content-Language: en-US
To: Chen Ni <nichen@iscas.ac.cn>, <vadim.fedorenko@linux.dev>,
	<arkadiusz.kubalewski@intel.com>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<davem@davemloft.net>, <jan.glaza@intel.com>
References: <20240513032824.2410459-1-nichen@iscas.ac.cn>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240513032824.2410459-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB4811:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f89f17-a84d-4346-84c5-08dc7324c293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eks2eFhTZzNrWHJVRkkxeWgvOWVQaHVZSFpENHFDN0VxS0tIc29FRWhaakZE?=
 =?utf-8?B?c3huMlhqM1BKK3hyc2hTclRubzBxTjBvWkZOMTdUVHRkeHhiK1VRY09FYjVm?=
 =?utf-8?B?OFo4cksxSUVsd0dyOXF6SGdFU1FmVGQzN2UzU0pDNFpoeldSNXpaZVJQZ09y?=
 =?utf-8?B?cXE3TWxMZlRDNzI1c0JrZWlDVWo3VG15dHlBV0hSdldUeUE3U0tXa1k1c1lh?=
 =?utf-8?B?V0tXcUJuYjFrSG1kdXh2NGN5T0pUaVFYWStlUEFYYWN4Q2YxdURaRloxL2Ex?=
 =?utf-8?B?RHM2OUVlYjV3S254ZmR2MGxWbUNWTUduWFJJL1NTVkovYzFvUXdES1BUYkRU?=
 =?utf-8?B?c0tqUGZRNkdEQ0p1Wjc1S2Fhd3ZHZmJ2VHd5V3EzMjgrY2F0WW44SEtJbGJm?=
 =?utf-8?B?dmdWVE5VU3hoelFvVTZjRXcyaVRUcTZOQmIrN0lZUXNwT2M1eFRNWER2V0xF?=
 =?utf-8?B?QmpieG0yNm0veS9yQzJXL0xGK0RpZHFaeEt6RlRpVUl5RzBTb2VwOXNUbWt5?=
 =?utf-8?B?ZzEwS2F3MDF3ZjI1d00xMXlZS0Y2Mm1yeXV6RjN5Z01jTFkveUYxMXVIYnFC?=
 =?utf-8?B?V3kzRWZmRXNDVU1sWU5kb3A5dEU3QVV0elVzU1F4bzdtRTVTcC83dmM0T2Yz?=
 =?utf-8?B?TlV3T3cwQ0o1ZWpsMm51WEJyTklmS0d0SUxMekpjd3QxQzZEcURjNjRzekoy?=
 =?utf-8?B?RVBxMjQ3TURvNFJTTTM4eWFqZzBCTFk4WHJEeU9tSUdJa0pFcG1CRWJlS2Fh?=
 =?utf-8?B?dHBHdmdJYUdpNFpnNStlMzFocW53S3V0MDNZcUlUakVDSHZ0NkdWNVNUUjBs?=
 =?utf-8?B?dFFjK2s1UU9NZlJ1VWN5MWNKd2xhKzJvYnltNlpjMzdaTHZvWmRyT3ZzUFMy?=
 =?utf-8?B?TVZEUTVNUkdwT2xocThmS05PN1JhZ0Jnb0Z2TmpWeUxTczdqVisxQ29QRk1B?=
 =?utf-8?B?aWhnTm81Q2I0dFEzWmNaQTRYRVltU3lCWTNUK3FJckQwd2cwSUZLaWt5NXlk?=
 =?utf-8?B?cUMwWENDQkx1bXBEczE5S2tVZVFDN3ZsVTkvWE00WHIyVkdnVUFEZWpHOFgw?=
 =?utf-8?B?Nmh3UFo4VFZGTlY2UnZhNEVKcVpadlpaRDVXTllodnI3T0FBeWlEcXV5c3pH?=
 =?utf-8?B?bFdSQktqNmpoemNURkVlMEZ3R3h0SUIvNjR6NUovZmlZdSt1MXIzaXVMUUFi?=
 =?utf-8?B?Z3lIMmxsY1hjY3NBM0lWUEdxMTRjU2xTd1FPY2o4NFFBOHVLa2dNTGQrREU2?=
 =?utf-8?B?a3oyQndGanVXTVVPcElhMTdFbFdjVU1CZzN4elFjL3hTOXJySUVRNE9Yc3hs?=
 =?utf-8?B?L0lNaXdTbjMvZWJQczJkK2plbjVQd2owR0lvSWlUQjExOXNOLzFjYTBtQWNy?=
 =?utf-8?B?U3dvL0JtNGhsZHdmQU9FK21lQUFvcVdaa3VmNWRMSFVHaWo4RjZkb3UwcTEz?=
 =?utf-8?B?eE9KdW9CdnlXVTZFeU55MXVLalp0QlVTWXhUWGNWZEhtclExTklRakZvMmJa?=
 =?utf-8?B?UkRuWkkrM3k3U3RRZVhYN2RZckxxbG9HcTV3Wmk3R2Q5ck9nVlVqNXNkUEda?=
 =?utf-8?B?L2hDWjdENjAyb09yZHU1QUVEWmVmZUtVQWFUMnhpYzE0Z29tek53R1lTWGRx?=
 =?utf-8?B?ZGl3eVJUNTh1QWQyVE9GOTI4SGVPV1p4U1RUY1dxZ3BtNFZXbU5UYW1HWDEy?=
 =?utf-8?B?d2ZxRHY2cXAySmtCVjBqVmkrYVNSVlZFMEFMQmlTbVFNUVZscTZ4UmVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1VYRXhrOWgyWHB1WXFqaFpoNjJXVGlWZVhVdnZvMlVCbzljcUJ3WnZFRW9O?=
 =?utf-8?B?OU9nc1RDbFBWZ3ZtaFVWZEwrekVHbGpRVmo5ZUhhWFB1dUtRdTU0RzFXanJC?=
 =?utf-8?B?aUM4UlpjVHcrdHp3WkJQUmU5eWtDYzhtS3lhMVhYTURIQTRwb00wcVM1L1pw?=
 =?utf-8?B?REhBeXdRNEhvcTd3WERVSzRMT0RLMFNJeVBBcUNzMm5xQi9ObTkvWldkYWk4?=
 =?utf-8?B?N2tWWUFWS0pzTmFQMDgyMDlzRHJYYXBpNVczRkxyOS9yZk9pdXJ6MG5XSEpj?=
 =?utf-8?B?SWVPVXkyOXFKUFNJR2swNjBBQzJVaHNyRWFqenJ6enZhOGhLN2t2QjRuT2pK?=
 =?utf-8?B?YUpYOUN4MlRRTW1PRmRyM2VudWc2cC9SUjMvcmFHZ05tT0JoY3NyUUJCZE9O?=
 =?utf-8?B?a0FhakdOZlVESkxKbXdGTm1IcVg1d2xrK1JDbTFqRDNEQjhnODNRTklEKzFy?=
 =?utf-8?B?OStmRGp2TXlOaFhyRWszeXBiSHFPN1dCaWFNM3dDYjFQcmZYZ3hwSTdnR00r?=
 =?utf-8?B?WmZrTEFTU1hhK1hZaVhPbjF4ZXM0NHdRdUdyY1BLb3VGMmFJd1NQcjZyMTk0?=
 =?utf-8?B?c3BDK3QwenhOb0kweElZMzBUdER0ZDIrRjBReENlR3MrVS9jL24rY0hYRDF3?=
 =?utf-8?B?ZlZJUGdwTmJ6WW15ZGk1dDZBNUx2L2pEazh6MGJBbUMycDRpM3hKV0lCRG42?=
 =?utf-8?B?VmlIRmFjVWxoVlgzeXcydXdqNldIQXY2MDRBVmltVXZ1QTNDSkx5b0phZStC?=
 =?utf-8?B?MktPWW9KY3VVU1RRRXRpQndEcDA3SHU3NTU0MmtJdFZpZnR1dHVWQVhjZ1JU?=
 =?utf-8?B?VXViOXhPVE9XYStJakk2OXVZM255MnBaTUoyL205SnZwVGY4cFZkRXR3dmM3?=
 =?utf-8?B?SjNTOFdoNHRXc0VyblIzUzcvbzg1Q1FFK2RHZ0RKTHVhNUV5YlZJeTVYZnRH?=
 =?utf-8?B?Q2R4ZllwWk9LOEFEUzlOKzBoaXluOGo4UVdoVWYzaXkxYlNqVVA2UXRxKzRt?=
 =?utf-8?B?NFZoYWRhcVVHNEhmcFN3bWh0dW1OWUpVZjMxZ2JlM2pKVDgvcWZmaEd4SU1H?=
 =?utf-8?B?eW9wNEYzOENDb1pNU3dYUXMzcXVaQkJKbWFPQllwRjN6UHBLV0ZuNHRldnow?=
 =?utf-8?B?M051S1N5eUU2RXlxcUpvMkE2Tkg5VUkxR3lpajhOUzNOYkNpaC8zMnFkeGlG?=
 =?utf-8?B?TFgxcHVsUzJ4WklZTnlQZklyMFk2WUEwYnprWVNockgzL0x0eWJnc0ZyUkFS?=
 =?utf-8?B?RTVpcXJsc3hjRUIvWTRLN1BNZnE4Zk1yZUlTeVhlcXgzQjZDS01uSGpsTm16?=
 =?utf-8?B?d0dJVXhqREVPeUhMMlBLdURuZUxXWDdZODVqSUxCOUtHSU41UFZqUUNXWWln?=
 =?utf-8?B?UzM0NFVXR0pjcnlYQWRubC95SmhIWlQ4dHBsTlFDcy9hSWNUcjdnbmxRaUNZ?=
 =?utf-8?B?SHVDRnBWV3MyUy9hMXE1aFljaUlMVENOTGQ4aXEzeDZIb2ZVVUF6WWZzM0xV?=
 =?utf-8?B?R0dYL0ZSL0dMTUpkT0hIamJYcW1JTWlNcm1QS21jeVcydGpYTzhlT0xsU1Ir?=
 =?utf-8?B?QmkyVU4rMGNrSEZjbmlRcjJxTHlZOEJSQ29CSEZsV25uakNSeWxHWXZML202?=
 =?utf-8?B?TWJwQkVRVDhkZldXdUNra1dpZlBlM1JFOWVIaExqeDhtVXhWT3pRSkRXdTVp?=
 =?utf-8?B?STI4cXJFM2NXZWpyK2NjQ211K0FHK1lsM1RucGJtOEpPNXJyamtBRjJQTkE2?=
 =?utf-8?B?OTQ1R2EzN2pSdWFXM1Q5VmdFY29MYXVMMHNmYWNkcTZqdE83ZDNGVGw5OWc2?=
 =?utf-8?B?MndkLzNaaDlackY3L2ZJMTVwZWlERlMwRU4yU2hqc2Q0MFVlZWZvMmtNV2V0?=
 =?utf-8?B?VE04ckp3U1lyUStLQm5xcUZzemdHRjhqdFlzUmdid3ZKT05KUktXT21QSStX?=
 =?utf-8?B?c2dMd3FTRE5MeElDQnkxbXFJbFFaRlduVnJ1a0hMQTU2bWt6VTVGR1greVFE?=
 =?utf-8?B?R0EvNzdqNDFtMlNIckRMYzdDOUdPOCtYWi8vUnBNQjhkdStZLzhUQ250bWUw?=
 =?utf-8?B?ZVBYU082Ri84cWNyZmh4R1pLbHJnVlNOZVJCV2NPZGRCM0hFTlhkZlphRWVi?=
 =?utf-8?B?eW05VUtKcmFrc3Z6WURGUytLQmRIUEtDOW5wamJWY1FnUlpSTDhMU0V4TXkr?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f89f17-a84d-4346-84c5-08dc7324c293
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 08:14:50.2326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWSrXlzLjPvThiQrEffVsju9N4YMR865yFWin1D2uMsCeuUHOay8NuPZvZxxo+GYTDNK14b7yV6/0JJ/RVBXTFRtRt8hVOEEE7CqumhYo4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4811
X-OriginatorOrg: intel.com

On 5/13/24 05:28, Chen Ni wrote:
> The return value of kmemdup() is dst->freq_supported, not
> src->freq_supported. Update the check accordingly.
> 
> Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/dpll/dpll_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index d0f6693ca142..32019dc33cca 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -449,7 +449,7 @@ static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
>   				   sizeof(*src->freq_supported);
>   		dst->freq_supported = kmemdup(src->freq_supported,
>   					      freq_size, GFP_KERNEL);
> -		if (!src->freq_supported)
> +		if (!dst->freq_supported)
>   			return -ENOMEM;
>   	}
>   	if (src->board_label) {

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

