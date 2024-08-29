Return-Path: <netdev+bounces-123425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B926964D3B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5591F2250A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A111B6545;
	Thu, 29 Aug 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAbqTJxp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71201B3F30;
	Thu, 29 Aug 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953856; cv=fail; b=Tvjv8iqbNlC2iwoxA6kO5nMXfohwrl9fWSOmJr/eoQeQ/oO4rNkl6/RqiKHygWNx/gM2gGHemetMK09kWa++7YzOb0PZ9cTQQEZSgxnbLnb1mUv4rMWz8vIgS9kpznJWHMv8Nb+mpitg/PZgoB8w0r+K/2KSfH7IYUHxF4fBfCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953856; c=relaxed/simple;
	bh=GBXqr9djjCuSgupcsu59Vl98l6PXQmryLvm9+nERcGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o2TKVpZS9GiBXgdngesenjp9YSlr9mduaBsyXbOeDcOKjhA1LBTHPuFICiy2vSIdh6SIKGcZYOnNML3oq4pY7h31wI65/rdJtEE0kBXBQdBGMLy2A+5C7oztIQTl/f1nc8jbRhWp10YdWt6QzOjcOea+eLzoDKAlP3wOFypWfSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAbqTJxp; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724953855; x=1756489855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GBXqr9djjCuSgupcsu59Vl98l6PXQmryLvm9+nERcGw=;
  b=FAbqTJxpUVgIoRVLjdHhcJ07ksoWjhocxhzEcHiNNvE0jqo2Fq2HFSys
   d8v7thucB1l30AnKpukRu6C+zQMw84FjML19EJxig8VqI2T3YHV7wIPTh
   RviAk9WXvCCQUV+qVdJe7BS2hS2MeHMTDaBL4et2uDqs+cPOiiGa4D9iH
   GI6VaxUAp/OkMhyY9IeAqlOvgZ9lPOMaIKdy2KxglE8y2TbO9SO+MCgaB
   7ko4Gf8kxNA1TSHXL0cYiAE2Jt1zAfnf0H9NsHZ8As/eb1a3Lm40VOaSQ
   6dnL/44ZlLuCnzSz27pNmtm4rOe2PFqi4Bp0mE6cOb+ncLNES87fiDIvC
   Q==;
X-CSE-ConnectionGUID: hAPEdslgS3K/UHAJIizFiw==
X-CSE-MsgGUID: 96tmGhgHRCSkaOpjuIxNFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="48952175"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="48952175"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 10:50:54 -0700
X-CSE-ConnectionGUID: KXAwZ0QqS7SCx6BvWs5uiQ==
X-CSE-MsgGUID: OXmxfjXqSdWhXDcoz4iVVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="94472110"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 10:50:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 10:50:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 10:50:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 10:50:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPptJTUurMRbKn2G0WmAq//M1MVu9DXOH7KHotyShqszZ7vsd87SJAC5CUxsOHf1lQ7XTAnTmlJ0QdHDY3RgC0o5UBr59wHmcf2rnU1/JUPeFrY5mnvb97l7goy+K5RTz6yORaxDU890twCaKJKWgVmTjfUQSzFJtVw4fsfE7M0k84XHyja6JCKjq9473NjAKSfLKmr9+jh983WLluvZgqYPdwt9bFemQF0PWyjnQcdxNVq3CW4cUUot34+SpqbTMYLTwfgcUw+PjLmAJEo2COWlObZpmUrcLOuwotDvsL0NH6tToj0A+22RQgIqOYFe6nZPZXBDavjn3ke4qIQd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBXqr9djjCuSgupcsu59Vl98l6PXQmryLvm9+nERcGw=;
 b=ZgP7VP3Nrz+IHwj5gGAUi71/tSKhEUtnc1c8zy9xfmi3S+2pXeBZoKw969KTAiKRHvMbuqntH+EWCU5xII8c2WsvJ3VusXZ9cx+6LXXb9OAG2Y6HjWYeS5ZVwLdDQSx2ir7GOI/SyTBIZfyPdDQOokYIln2kguyIZ1QaNnSCy/bERkMmAKgnlo6rfuIbQlCI5F4iiXhuNZTCuJBS0ndQ8xqnxfPqZ0Opyv4InoEUR9RA44V6M5uKxP3R66r8CMhVdm4BY2xNl5wEORBBiSSqp6BO1E7QI5//4PigA3wA14/PTt8u7Psy9yqSXVPBczkRNDCDcA4EZ9DdPaDo7/upOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6016.namprd11.prod.outlook.com (2603:10b6:8:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 17:50:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 17:50:50 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Rosen Penev <rosenp@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>
Subject: RE: [PATCH net-next] net: ag71xx: disable napi interrupts during
 probe
Thread-Topic: [PATCH net-next] net: ag71xx: disable napi interrupts during
 probe
Thread-Index: AQHa+Yu4HzEwDYYTWEKXpy2lO/vDbrI8s6kAgAHQBYCAAAEAoA==
Date: Thu, 29 Aug 2024 17:50:50 +0000
Message-ID: <CO1PR11MB50890C939694ABA5C4A75B05D6962@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240828204135.6543-1-rosenp@gmail.com>
 <cabb111b-37b4-493c-ad6c-c237c7091bf6@intel.com>
 <CAKxU2N_fHp1oWxau3VG7dFK+sdwqDUkzYvFbfjBCdg_VvobrVQ@mail.gmail.com>
In-Reply-To: <CAKxU2N_fHp1oWxau3VG7dFK+sdwqDUkzYvFbfjBCdg_VvobrVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DS7PR11MB6016:EE_
x-ms-office365-filtering-correlation-id: c6699bc7-3595-4326-458a-08dcc8531ee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UWF5c3RWeERzMGFIRk5tckdzY0N2SUJzdEFCYmJjSXAzdnNnWjk3UVpXKzhB?=
 =?utf-8?B?aVgraHdSQktWWWVrODRNamRSYXVPR254N3U4Skp5TEE0R0c5elhoVExmMG5H?=
 =?utf-8?B?RUFKYXJYN3FHQ2JwRGhkS1BmWjg5d0RLbzVqZERpQmI4TlQ1L2Nvd0VmcnEy?=
 =?utf-8?B?U1VWYUZUTFlqUGM4aWRkeThLYmVYOU95M1Q3d2p3OU1MVkJRUVJsMG05aHlu?=
 =?utf-8?B?akRFWjArd0Y3QmxVK1dTYlZKcVNqcWRKdzFMUzdDcSs2b3ZsNmJpb2dGQTRH?=
 =?utf-8?B?ZDBqTDRESitMTG1nTnJaY1ZSaFVWUTJwVy8wSWdZcklPVWUyVDh1eGtEcnBO?=
 =?utf-8?B?M21mQUc2WGVxWlcraEtKQWhCd3VFL2FtR2FsMkFYS0VVU1BFWW9IeG9KT29h?=
 =?utf-8?B?cjFINGg3b0dBM3lFZzJ6NTlGOXJFNXF1SnU5RE0wL3Y4NnlsQW1pVmJwbWor?=
 =?utf-8?B?MHBqU280RWw3Q1pFaUNSaVRzY2kwN2JMTkkwVkRuQmxLbzNsVjNGUEJ5c1lV?=
 =?utf-8?B?dGppajN2L1RScnZHODc0MENwUXhUcXFNZmtaRk9mUTlTc2hNUXVFM2JCaXhr?=
 =?utf-8?B?bTN2eTk0RFpXK2Y5QVhVK0Y0L1VCdHZmSG1LQ3p5OWUwYjV5cFduL0ptUnFF?=
 =?utf-8?B?UUg3WUZKQTRndHVnSmpaR3JXellubEhMWFBVazVrWExHN1pSd0I4cFhFWlRj?=
 =?utf-8?B?em1VamVmbmxKTGRnZVhScnRnd2xoeVNwcU1FR3ZtcW10amJ5aGkyYkR5TmZ5?=
 =?utf-8?B?OHpSUUZ4NlJCMnRiTFdmc1diNE8yQ1JsN1BSVVNGRDZYUzY4OVJYc0NxZkUw?=
 =?utf-8?B?TlJTR2QrMVJjVUJHalNnOGZZYmUvamtUVVk5UTdDL1B2MzZmOVhLMlBFMkRm?=
 =?utf-8?B?VDlzTVB2VFlPdlpYNVJLMUtFaG9hVHZ2LzJOTWt1d2QxM0J4REhEY2toaW9G?=
 =?utf-8?B?WjNad0VHMG1EVlp2TjJERHdDaGtvcnRlTUcrRmVjYWs0TFo3QkxQbEhKRnBt?=
 =?utf-8?B?dTJxMGFoVFF6ek5NRkJGU0VLT0dSdysvV01Rd2VpOHplR1o1eXdYdGlhMG9v?=
 =?utf-8?B?NEV2U1NmRDNXUE5GbnRsLzJ6ZDZGZmtUOWdIcEZUTGRjdHA5OTJIZkVqMGZr?=
 =?utf-8?B?WE1Bb2RiRUx0RDM3TjRKL1NHSkwwV285azNkQ0F6dVZyWDliVzg5QnpLd25J?=
 =?utf-8?B?Rkdrdm5wQ2tNSWFMUVAzcTFTTnZBNldTSHNGekVKRk42MDA2alN5eVE0MjFH?=
 =?utf-8?B?ZlFlVEhMRFc1MmlMM3phZzZ0VGp2QXJ3QzZlRWNiS1Q5eTQ1VjVyczNpRnpl?=
 =?utf-8?B?eXlwczViS1lPMjBhTURRaDdERnhuVEo4Yno5MGdYNmpMNXFBb3YxK2U4bE1K?=
 =?utf-8?B?TGg4Y05DQ3RudG55OTZtSGFvbEd4enhMVkpDZ0huWjNDUVFXYWhxS3djRFlx?=
 =?utf-8?B?amdNZ0ZmQm5HVU9zdWw2YmJOZkhsSm1RZWRQMmtPR0VhaUM0TFVaeVFIeWx5?=
 =?utf-8?B?eS9KS1VDcERqQVdwMlVRMUtuWW5VSFNCQ2FrMTllejZGTUJVMmV2VHBJVW1z?=
 =?utf-8?B?MzBWOWVtVmloaDZjaXlBUmVjSzB0aldPSTJmWk9uY3luUXlDTDdYckRDTHUx?=
 =?utf-8?B?VS9ZdTlCUjZZZnhlcGhWZklab05za3dwVVdBbnRYNVdFcVFuMUxkOGQrTDI1?=
 =?utf-8?B?RDYwQ2RIaFpobWsydUdvSVJJMWkyOUgrLzFyMnlaL0R6YnR4KzRaQkE3MWx0?=
 =?utf-8?B?TlVod0dwQUhxRXFLcnBrL2wrR2l6ZlJGUURXN2w1ZE9oemk5OGhFRnVDSHBs?=
 =?utf-8?B?UEFvMHk0dGl3MVdNL3BESDVoN21iNzBjOWhjZ3FVZldCaFB3RVFpMkMyeUhI?=
 =?utf-8?B?UnRZekVYV0ZCaWNHc1N0Ni9XL1A2TzkwUWYvSkcxb0c1b3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0RxbmdIaDFyRXVuc1VwV2Jrc0tpUG5wbGZCRmtRcXhwU0drb0J3bHRQVzNp?=
 =?utf-8?B?V2lNamNlYWp6U2s2TExDdVNsbVlKNUl1QnpDMERPZXBrV2VwMUZ2enNpQk0w?=
 =?utf-8?B?ZUMyM3lvbmpzZ2txQUpoRXYrWHBkZ3c0ZVJsNlNsM0x6MFI0NENQcktHeWNL?=
 =?utf-8?B?elpudGlxM3MyMFBUVmlCSmhaNjRjUEsxV1JXWDkvcmp1bWRBZzZKY3ZBTG4w?=
 =?utf-8?B?Yk90bHFpT01lL2xrZGJJcFFVREUzTW94Z0kxcXJKWTQ4UnRhRmk5cDZyVW1K?=
 =?utf-8?B?ZHkyeFRwaHpMWjQrTDZiRVpFWEJEVTk2SVZzTks0T2tmMGh2UElqVCtuaEJG?=
 =?utf-8?B?TFZyUnRZNlh6T3VBaFBwdzBIVFRQVlhackZTU3NNMHB6WUE2Umk2ZnQwQ3M1?=
 =?utf-8?B?TDBjRWVIcHRydFJlVXoyNTltTW9hODltamVUaWtDZ0E0YmkzQi9Bc2tGZ1Iz?=
 =?utf-8?B?SXNGUStMb0ZMQnppcHo2QWhRekx5VENka2lneFFRby9wSkl4WGlxT2RCd3oy?=
 =?utf-8?B?K0c0T1lNQlEyVW1aNDNRcWd2Mm5ZQmorczVSNEVTakNiRzFOOWVLSHNFblQ0?=
 =?utf-8?B?S2ROWWdRaGZ0TDNrZnZXMHo1OHVZbi9EbUZDem1ROThGc1FWVXJBakNtQktk?=
 =?utf-8?B?RjJvQkwxTHJiOEZ5d0IxNkdsVVkrMGhRZGMwT1hDUTRjbnNpa2YvelB2cjBn?=
 =?utf-8?B?bHNlU2hUdWtia0YxOGV2eFczenU1OFNGWURENHlVb1M4dnFWcERqVjc3R3Fu?=
 =?utf-8?B?MEtvdWNUQkkyUTJ2Q3gwMnRPL2ppMSt2UGZRZFJJVWlxL1BvcWRtZkQ4djlV?=
 =?utf-8?B?Vm02eDhhTWU5YlJ6S1pTcGVza1pxMDE0QVZ0VDkwNUtyU1VQNXAwTU10UWJz?=
 =?utf-8?B?RW5VZnBlZDlzZ1BUNlR1UndGdm9ZQ3ZiNy9sY2RkbmJabWNqb1VXV3JkTE9V?=
 =?utf-8?B?NE16UERVajdDVGRBQzgydHBlS3NBU1gwZ09odTNpUDJMK1M5c2RzTy9ja2dQ?=
 =?utf-8?B?UzRkeXMyZlE4RFNjN3ozSTJlWGhKNlQxN0dncytNSjZmQkJ1UkMxc1NzKzQr?=
 =?utf-8?B?bElZcUdhVXE1a3A2U1NqZEw2THBVT1RCLzAxc0dEcFB4Zkl1TnZNeSsvU01x?=
 =?utf-8?B?UFJwbCtnY1c0NjhMY3lMcHQ3bkJ2cVRKUkx0bHpoMkJCQmxBbXdubHhCSVhp?=
 =?utf-8?B?S1VnenIvb2tQdTV4Y1NSRHJKQzFPVWlnc3hmL3RVK2M4Y0Ziclg1NmF3akpq?=
 =?utf-8?B?SURYSzBkOTBWYjV6dnFWL3MyNExVc3Q2ckJXaG1QcVVaVWlzODh4YzB0cHVK?=
 =?utf-8?B?OE1ENUJ4S2N6YzFhMlROYm05YnkyQ0ZtR2w0NVFGQTFURWRVcXpEeVJOMjlJ?=
 =?utf-8?B?NUZON1M3SXhtcDNKZ2xKV25pV3FUTXlNVTNsMHorY0tkZGZFSHNBcGtzUFR4?=
 =?utf-8?B?S0JQY3cwUlFCWE9WbTFHOEdSZnB0OFFrUW9GU3BtaFlyMUpYZXdQT2xIQW5h?=
 =?utf-8?B?RW9YQVg2ZWhFM0VwMDlSdXhvalF4Q3EyNEZHVHVCRnFhUzhPSkhBZ2tXSU0x?=
 =?utf-8?B?YUo1VFpESUtpTGd4ZDF0N1JxdWNVdWg2NkhpUUM2Rmh6Ri82eXA3aXVIekow?=
 =?utf-8?B?cHlsUGpPSU8wZnZFYkR3VEdiZ3ZTZzJvRUF4UXEreVYrSytQaEdnUjhzSXRn?=
 =?utf-8?B?RWVkdVArR2xGdHVxSEFCcWJqYXRZdU44bGZ1VDRMbUxlR3NjTC94eG41NWFY?=
 =?utf-8?B?dWZRR2JDME5CaEh2blJKRWZzWEJKcTZLWVhyNUZIK25VdHl1bUErdXFrQy96?=
 =?utf-8?B?STVaZzRnQjVMdzhTOC81QmMrTzd3a2E1Nk01bnoyVUFuZWxieTFZMi9rOURa?=
 =?utf-8?B?eXdHUThYS2kwZDROb0dUUitNQUVmK1R3OGJIM3NqdDNFQ2UzRy8zZGZVbWh3?=
 =?utf-8?B?TXJoS201eStXUHRjUGhwY2Q3OWs1MmtvWGk5bEFQL3BYOVo5Ukl0YjBqZElj?=
 =?utf-8?B?ajdueEMyWENOSWUyNmM3MmpsNmhMZ1VneHJlcFBCRENVK254blNRR2JlR2Mv?=
 =?utf-8?B?eGRBM3RkU2RyUFI4a2tUMGJqaTdMRytmZS9qcGI4SjhSSFIzMUhiZlhwa0Zn?=
 =?utf-8?B?VURKNDYxMjU3VjRIeXE3UlJCVTBNYTZ5emVmZjhvWVVZWEdDNVQyeFRrUGtF?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6699bc7-3595-4326-458a-08dcc8531ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 17:50:50.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XOLJ1PG3/2/yw7lB1dK+PzUEyxOe+nMujIUvLiTVZrdXeJDsIprDScFm9SnptIhKtzd5/WgdYZSwza7ex9fW3IBf11RIlsZFJetMxbE9Soc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6016
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9zZW4gUGVuZXYgPHJv
c2VucEBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjksIDIwMjQgMTA6NDcg
QU0NCj4gVG86IEtlbGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBD
YzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRA
Z29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgbGludXhA
YXJtbGludXgub3JnLnVrOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgby5yZW1w
ZWxAcGVuZ3V0cm9uaXguZGU7IHAuemFiZWxAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBuZXQtbmV4dF0gbmV0OiBhZzcxeHg6IGRpc2FibGUgbmFwaSBpbnRlcnJ1cHRzIGR1
cmluZyBwcm9iZQ0KPiANCj4gT24gV2VkLCBBdWcgMjgsIDIwMjQgYXQgMjowNeKAr1BNIEphY29i
IEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4N
Cj4gPiBPbiA4LzI4LzIwMjQgMTo0MSBQTSwgUm9zZW4gUGVuZXYgd3JvdGU6DQo+ID4gPiBGcm9t
OiBTdmVuIEVja2VsbWFubiA8c3ZlbkBuYXJmYXRpb24ub3JnPg0KPiA+ID4NCj4gPiA+IGFnNzF4
eF9wcm9iZSBpcyByZWdpc3RlcmluZyBhZzcxeHhfaW50ZXJydXB0IGFzIGhhbmRsZXIgZm9yIGdt
YWMwL2dtYWMxDQo+ID4gPiBpbnRlcnJ1cHRzLiBUaGUgaGFuZGxlciBpcyB0cnlpbmcgdG8gdXNl
IG5hcGlfc2NoZWR1bGUgdG8gaGFuZGxlIHRoZQ0KPiA+ID4gcHJvY2Vzc2luZyBvZiBwYWNrZXRz
LiBCdXQgdGhlIG5ldGlmX25hcGlfYWRkIGZvciB0aGlzIGRldmljZSBpcw0KPiA+ID4gY2FsbGVk
IGEgbG90IGxhdGVyIGluIGFnNzF4eF9wcm9iZS4NCj4gPiA+DQo+ID4gPiBJdCBjYW4gdGhlcmVm
b3JlIGhhcHBlbiB0aGF0IGEgc3RpbGwgcnVubmluZyBnbWFjMC9nbWFjMSBpcyB0cmlnZ2VyaW5n
IHRoZQ0KPiA+ID4gaW50ZXJydXB0IGhhbmRsZXIgd2l0aCBhIGJpdCBmcm9tIEFHNzFYWF9JTlRf
UE9MTCBzZXQgaW4NCj4gPiA+IEFHNzFYWF9SRUdfSU5UX1NUQVRVUy4gVGhlIGhhbmRsZXIgd2ls
bCB0aGVuIGNhbGwgbmFwaV9zY2hlZHVsZSBhbmQgdGhlDQo+ID4gPiBuYXBpIGNvZGUgd2lsbCBj
cmFzaCB0aGUgc3lzdGVtIGJlY2F1c2UgdGhlIGFnLT5uYXBpIGlzIG5vdCB5ZXQNCj4gPiA+IGlu
aXRpYWxpemVkLg0KPiA+ID4NCj4gPiA+IFRoZSBnbWNjMC9nbWFjMSBtdXN0IGJlIGJyb3VnaHQg
aW4gYSBzdGF0ZSBpbiB3aGljaCBpdCBkb2Vzbid0IHNpZ25hbCBhDQo+ID4gPiBBRzcxWFhfSU5U
X1BPTEwgcmVsYXRlZCBzdGF0dXMgYml0cyBhcyBpbnRlcnJ1cHQgYmVmb3JlIHJlZ2lzdGVyaW5n
IHRoZQ0KPiA+ID4gaW50ZXJydXB0IGhhbmRsZXIuIGFnNzF4eF9od19zdGFydCB3aWxsIHRha2Ug
Y2FyZSBvZiByZS1pbml0aWFsaXppbmcgdGhlDQo+ID4gPiBBRzcxWFhfUkVHX0lOVF9FTkFCTEUu
DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU3ZlbiBFY2tlbG1hbm4gPHN2ZW5AbmFyZmF0
aW9uLm9yZz4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJvc2VuIFBlbmV2IDxyb3NlbnBAZ21haWwu
Y29tPg0KPiA+ID4gLS0tDQo+ID4NCj4gPiBUaGUgZGVzY3JpcHRpb24gcmVhZHMgbGlrZSBhIGJ1
ZyBmaXgsIHNvIEkgd291bGQgZXhwZWN0IHRoaXMgdG8gYmUNCj4gPiB0YXJnZXRlZCB0byBuZXQg
YW5kIGhhdmUgYSBGaXhlcyB0YWcgaW5kaWNhdGluZyB3aGF0IGNvbW1pdCBpbnRyb2R1Y2VkDQo+
ID4gdGhlIGlzc3VlLCBtYXliZToNCj4gPg0KPiA+IEZpeGVzOiBkNTFiNmNlNDQxZDMgKCJuZXQ6
IGV0aGVybmV0OiBhZGQgYWc3MXh4IGRyaXZlciIpDQo+ID4NCj4gPiBUaGUgY2hhbmdlIHNlZW1z
IHJlYXNvbmFibGUgdG8gbWUgb3RoZXJ3aXNlLg0KPiBPVE9IIHRoZXJlIGFyZSBjdXJyZW50bHkg
bm8gZHVhbCBHTUFDIHVzZXJzIHVwc3RyZWFtLiBKdXN0IHNpbmdsZS4NCj4gDQoNCklmIHRoYXTi
gJlzIHRoZSBjYXNlLCB1cGRhdGluZyB0aGUgZGVzY3JpcHRpb24gdG8gbWFrZSB0aGF0IGNsZWFy
IHdvdWxkIGhlbHAuDQoNCg==

