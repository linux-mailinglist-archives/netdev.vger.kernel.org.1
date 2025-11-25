Return-Path: <netdev+bounces-241408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33749C83905
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFBF44E7D55
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 06:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D82F6180;
	Tue, 25 Nov 2025 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyQC62CL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592EE2F5466;
	Tue, 25 Nov 2025 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053359; cv=fail; b=YWwca4mAbM0t5hsKde91J/yU0gp0sVk5UHu/V6dGZozUsWE2+UZQ42JmBlvOa9zOAdrXsiBl7S52As/MgsqJOQ6oDLFy33hqmyAUr0biL4C5P/wlDAKPU2rpxJi3TeG3qBVx4R14NhHogUrJYCmPcABeD4AZy+WetPwQ51ibjA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053359; c=relaxed/simple;
	bh=ArCgefuQLRkCyxE4MVkcL6v6ylNB8v7ZSbNcDzqacMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qChyhoIcL6ZodqwrUQVuB1IjsIcLEXKqbZ3UhauLxa7it2oXTldcDYZjD3qMmn8T9ei+17l5hajVEekIWTMcdPj9+goxaMbID+foGZzaYTPN7D9hzTgLLBtYtKINn7FmZKNMqrK1CMQQcVE/Fl+TmKXog03sG+6rm1vTmwyLk0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyQC62CL; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764053355; x=1795589355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ArCgefuQLRkCyxE4MVkcL6v6ylNB8v7ZSbNcDzqacMI=;
  b=YyQC62CLPMux6IEG90OfIeiUE5ioiwQQaGFl1nXtsaipuYBnlGiWl6jM
   bItZZK0IgQjoptfxqyz/SY0LUWSm5BBKVT3K/M6pBFWRsjrSn5rki0IV5
   FiyVHqBC9pgxno1qeyc2YQumoh0tRcDC5RtD9oz5Y9UxuiCllv6N0fDKW
   dfO54vDihjt1YGvP50Lj+dGUWXUayVFhpAQN6IlB4cNEfR+5rXJXIaitK
   liN5YKOEck0g3eY0xfd/yd4Ns2rsIEYQhvz0Cg1vSPvi3ww7iONfR4ZmI
   JzcfD13ptUOzuAQVyDpQDWlYqradaEb8XDZDVHgmfRk//pxr3OK3JirDj
   Q==;
X-CSE-ConnectionGUID: kZYLbkHZQMuiQE0mothoCw==
X-CSE-MsgGUID: IvRwS6HrR1W1KEvmvck+9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77174813"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="77174813"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 22:49:14 -0800
X-CSE-ConnectionGUID: ixwuSPs9SYmXJi1UOrjwUQ==
X-CSE-MsgGUID: MFVJsMcrRpWeRL7YCaHPHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="223525863"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 22:49:16 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 22:49:15 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 22:49:15 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.11)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 22:49:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWoTO6Ut8zzoxrJUwNdPR3+6xvEC0M46NG5qd/lTvCEb3MFLfyI7URsCc5tk/sT5I0O9R9MggZIibFKjF8xuSbROVvt4XO99F511ErZ6lU/iuth8RZD+bCLg7xtoRvZ+9ZKjuDXcoYjL3KkZXcW1Zcuf7EzLuz9S3tP7ylVqkKbLirOXMuMn1gbLWRctv52UJwh2yh09nXj9usfwVmxLVT0Ap0h5th4MbKzNozp70m4mRUFlJotFEfe8ZV6Jt3unjlM7wPADivncwxqeH1NyM6WY0QmdvGVrsk59qRKXD+yinZo21IDJRJ4IAe894bCa1rTos/ZulKDlM0X4GcxdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArCgefuQLRkCyxE4MVkcL6v6ylNB8v7ZSbNcDzqacMI=;
 b=AcdeUTqS3A1h8YVSdb6yl+OmJjOJ50irUGEbqTobYb0ZZGF9MOSCnVQ0VUYdbgnJKOTkz5czfpIMHcjgI3SGUsWlBbf3T4OUDPNqvN7IoF9GGr3ur12nw1FGvwFDwnKQJoUvDqaOvvDYQSdIly6C+9O9pb4yPkZsFUaKoqntME9U5z1Po3Br3mJeBRW4BD6sGIyVoP9Za+1uR+fK2LS8lbp+nV1WeWqjHOwmcJ4hjiKsHZaJpGW/tefWo22WVzdXV4jUXDOsWJrYVz4ltKRLXlC5JlWUsvJEM0uCyqcgoK0sTyJH5A7810ewQpQAc8GzpxcRpLSqfj3YUHcQz1ydqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB8073.namprd11.prod.outlook.com (2603:10b6:806:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 06:49:08 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 06:49:08 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Breno Leitao <leitao@debian.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"michal.kubiak@intel.com" <michal.kubiak@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-team@meta.com" <kernel-team@meta.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 8/8] fm10k: extract GRXRINGS
 from .get_rxnfc
Thread-Topic: [Intel-wired-lan] [PATCH net-next 8/8] fm10k: extract GRXRINGS
 from .get_rxnfc
Thread-Index: AQHcXW75ZBppDB36dE+rAPrDQGY7J7UC9Ekw
Date: Tue, 25 Nov 2025 06:49:07 +0000
Message-ID: <IA3PR11MB89869BA2186EBF7726E6DC14E5D1A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
 <20251124-gxring_intel-v1-8-89be18d2a744@debian.org>
In-Reply-To: <20251124-gxring_intel-v1-8-89be18d2a744@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB8073:EE_
x-ms-office365-filtering-correlation-id: fac026cc-4a8f-4952-aa2c-08de2beebb74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?NVgrdlc2bHhTZUxXN3ZMZEVGZTJJdCtSVFRnbjE5bGdDTlNNV25GMmtZclR4?=
 =?utf-8?B?b0J3SklmU09wK29QQmZmbjRSRlV3SU5lK3VISjVIckJmYzNHRmk5cEdKbFFx?=
 =?utf-8?B?cE1UU05RZW4wWDUxb0ExbHdoWHNKWHlFQmhENS9jVHdXcUlYQUtWVjZGTmFG?=
 =?utf-8?B?U3dCbjBjMlQ5U0hrQ2Zkd25RMDZBU3F5RjV3bXdmQjlsMXVrZEZOckd2WGNL?=
 =?utf-8?B?MGpvVGIxT1RoRGVtN3pyQmNsbmRaTE45cm1ZNUpSTGpMMzZsRllHN0luaGI0?=
 =?utf-8?B?cHVEaEIwaElvdEIzTi9kRWJBTVMwVklKcFlsbWJyVW1MUnF4ckR1OHhMQlEv?=
 =?utf-8?B?WHF5YnBnYXNvcVNzUkp3T0JQdVI4V1FWUUxHa2xpQzYwT2FJNFFaOFptQlVC?=
 =?utf-8?B?K3UweHh1dmRZdlhTNWNPYXgrekdUOVJOYW8yYld5U1JCdHo0dWxTY0s0MEF1?=
 =?utf-8?B?eHFhZnphM0R0dS9JQVVqMGRMUDVsL0xnVXJxUVhCTGtJVEllTXJWQ1k1R3hY?=
 =?utf-8?B?NFdyUEErczI0V1dKRHYyUDhzWUhUTms4T0VPTTNJVGdhT3pqajE5WDB5NVR3?=
 =?utf-8?B?SUU5RkV5MXZTeEErdERxdGxHVVhqWDhCaG9CRnQ1cnU0dVpRemVtVTNnMWdp?=
 =?utf-8?B?Y3pxZkM4aHY0TVlORzArVnVzYThIQjczWDFWQ2tKQmZvNUFMTmRpTFF2R1dR?=
 =?utf-8?B?VUFwenNpeURmYTlZQnRXYTA5cmxySExSNkNkYTk5U0hDWGZRM2tJa0ZIaWxP?=
 =?utf-8?B?VHEybUdNckQxNXN2a1UzeFE4azNyb2JJVkxXZkhFalNNcVdwMFhMd1MrK3hI?=
 =?utf-8?B?bXMzYk1HOUlNelhYTU1PWWgyZWNIbUdVdmJNZTRsSlFPREdkTHVWd2Rsblgr?=
 =?utf-8?B?aTlDd3FHZnZVcFN4NDdDWit0UXJ0NU9NZTdIek5wckwzVXZsZXI0Q1Q5Nkls?=
 =?utf-8?B?aG5EbkJOcXRpOGFiWkhNZlFyUDg1U1hvNjVPdVhhWnd4V2NTaGJmRVhHNnBI?=
 =?utf-8?B?Q2tENEZidkZ1RWN5Zy9KZGY1NmpWTmQzcHlTMVNJMkorNWxpaDlLYnBVN1lq?=
 =?utf-8?B?M0Qva0xhSWF6NW1TZUtmWFRjck9aRXd4a21KRGphNHdPL1lRUG4wZlhtSmow?=
 =?utf-8?B?S1JjRGg3WEdGbnFsOUhKNjgvVml4TDNveEpzOXZhYnFUNzhWNHgreXhRamVV?=
 =?utf-8?B?b0JxTjV3TFlSbXgxMTJ4Mm5vUUE5akEyRXRUSEs0UXI1RGlpWE55cUZhR2wx?=
 =?utf-8?B?SUNiNVdKTHRZNnpVa3FMNXNRUjIzODlQQUdMd3V1aDYwRUkvZmp0aEh1MFVl?=
 =?utf-8?B?ZXpHUTBjZlZDcXR6UEtueU1WazBXbjdpaDg3NjZ1MlFLTFNhOWxic25JbzUr?=
 =?utf-8?B?NVRpRzFONS9mTmZKMUxYZ2l0dWpwOGFBRE90ZlhXS0h3bTFUMzhibGZEYm5R?=
 =?utf-8?B?SWd1WXh3bXFYaXo2R0JwNUtzTEkzamJSbFJSVk1zWEtOQS9wK3YzTnlDM1pP?=
 =?utf-8?B?aXp3cWloYTJGc2hhdmdZRE5PQlprcVBmWFhYMHdld2FXb21iQnVVNmdBcFhy?=
 =?utf-8?B?NEhjRVIyR3lkdit1aVY5QW1PaGE4SFRMQmR6SkdnYndSaGloMTM0Q1lGWm55?=
 =?utf-8?B?ZkZRYVZJSXcrMUNRN0JQR1VTeXRwbEJacWw3dGlXM0J1c1hnNmFBUmI1UERZ?=
 =?utf-8?B?bkMzbWlwak1mUUJaT3ora3BjOEF4VkxCRStyQzAyNkhqUTJrSjdUa09jdWp6?=
 =?utf-8?B?cEVtRU5zNXhac1pLY3BEZGxMUkV5TWJFNWlVRjhBVkNDenRoYTVqUzhPeDRD?=
 =?utf-8?B?QkRvaGhnVzVicVczYi85TVFnTkxvcTB4eXk2Mld4SnZlQzFsUDd6eVVkazZW?=
 =?utf-8?B?M0p5QUpCN09jdG9LaStCamkwSTZyZlAwcUIxNUw0L2ZIV1JQTExQUWY1T2J6?=
 =?utf-8?B?UDRueVFtWjF6V0RqRUI5bjJMaGJaeSsvU0RhVEJSZHJ5TjhPOVZzNDNFMjVt?=
 =?utf-8?B?NDExUjF1a245R25kNGlJK1kyMGxqZllVUENsa1dudEd3dlBPZG9yaXBjQmpX?=
 =?utf-8?B?a3lYZnZ4OXVtK0dOSmhVbVJHWVZsWjRqN1JrUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGxHSmZpb0hBZk5qR1ZBVGpvQk5iRmh1Qi93VVhGY0x5Uzg4YlBTUy90YkY0?=
 =?utf-8?B?N3dYY01aVE0wTXNRYzhhZEVkTHAyVDlUeW92UFlacHM2eGR3b2ZhcVAxVWRp?=
 =?utf-8?B?bHh1enpRZ3cxMmZra0ttZzFkL1NPb2laV2VCUGhjbWNFemdRcDZGVURtYjFY?=
 =?utf-8?B?aUNPUFRTRTY1eUZ3N1pNdS9OTEpqZm1tZTVVMEsyMXpvTUI0TjRsY2RIMjJH?=
 =?utf-8?B?emE2UEZteEc0N2VDWk5nTEsxblFLZnJlbGkwU00rY0JRQmhZb3ljK01oa3E0?=
 =?utf-8?B?SE1hYnlyd084K09EdU1rNXErQXpUdk8xTU8zZWtHQ1BEb1U2Z0ZtNUtnVytQ?=
 =?utf-8?B?YytFNk9oZXpTcXM3cHNacVhneUNKcHFyTmQxZlJZNTJNOGh1OHp5dld1RWhR?=
 =?utf-8?B?ZlVYbm1TYzRrdDgwcmFHa0s3VHgxZHAzdm5lYXdhNFNBTUxHVUg5UnVkWVdu?=
 =?utf-8?B?VC9NdEZmUVhic1lHV2ovKzNia25HRTRoV3ZDZVk0azhtZzltWG4vNEhBeTVl?=
 =?utf-8?B?OENVZlVqWERsM0JIbkFJVXEvNlY3Z2FLc0l0akw2aWU0eFB2Z3ltRzJQdkNS?=
 =?utf-8?B?R2IvcTcyTjNqUDFETzNFM2NwcVljVnpHTnJGb2NPbTJBWnJOU1FKaEVKc2xO?=
 =?utf-8?B?T1JSTW91M0dTWXhyQmZFYVJMNTlQK2E2VE4vZDEyaHNCVEkrWkhqdlBnZXRJ?=
 =?utf-8?B?NmN6SHFxRWVwK2w2S3JtWTlnKzhCYkZtcVZYeHU2dEVsMDNVaGovOE5GS3NZ?=
 =?utf-8?B?dUI2cmUvZGpwTitvNXRhTGtzVjRkQ21oYmFEL2JaUHRpK0xJYXFjT1NiNUEy?=
 =?utf-8?B?YmRqazkzcUlHVXA5M2ZpaU9sUkRSYTN0dnNTV2dQSTllZzBPaDViRTJxUHlD?=
 =?utf-8?B?dDA3MnFLU1ByS00ycmdJd0RhcE1CSlZIZjVONi82WDBpQ2szOEJEbEY3dzE4?=
 =?utf-8?B?VlYzMkNGUS9KbGJSM2t6QUswYmVsd1Qxd1JXYTdJYmNvckJSN0poUDJPaDhB?=
 =?utf-8?B?ZFNDZS9BU3orYVl3ekU0NldoSVhzTzBPK0NXTHVlcnljenFwc0QrRUhidXpP?=
 =?utf-8?B?bDNjMUJFTmdmRkVmQmlzMnM5bjZ3Q21GT2twMm1BTk5YVndELzBQaWlMTThU?=
 =?utf-8?B?SFh1UnVJT2VlaDBZN1IzQS9aWEYvMHh0L3Q5b0diN2tDZXJOUDVjUTB6WFEx?=
 =?utf-8?B?alQ3SldaaElJRGN1V2s0cDhSYk1aTjhHekZ0YnlZNk5hNmxROEJGR0Y5UEQr?=
 =?utf-8?B?SVMzbmJBR1JuWk4rUVFHT1p3THYwTmU3OWM1VmdkbEhHYVdlSkhXRVhSNisx?=
 =?utf-8?B?b0E3RTI1cEh5NkNLSnVieTFmZUxhYlF0YnJ2aTVnRHNhSkZwdW1qclpQTStT?=
 =?utf-8?B?MkJiVUI1Zk9YMDBxWkNDWlRES0xTdWdsRjJuRjVEaStxam9mUVBwUU5ZS0lU?=
 =?utf-8?B?U2lnczE2d0JKTmtVV2pMTFpBbXc0MkRIenpCeXVjZTI1djhXVGgxeHdmQi9y?=
 =?utf-8?B?d2kyOHFEUlU4V0RSS3UyWlhaelhWbDA5T2JLRU9GUEFneGZBa01uYjJxZktn?=
 =?utf-8?B?SXFRcnlyOHRGRXAxWXlUYXNFbFo5N3Y0TW9LY29hNWV1UVpxVk4xR0FFdHJo?=
 =?utf-8?B?ZnNKSFVyMzlxQ0pBQVBYVitXcWV0ZGJHSG90d3FESXNrc2JvVkZ4SERES205?=
 =?utf-8?B?TTNlWWlsak5xT281WjVLZFJJS0hNbm8xMXo4WHYzR0o5OVFrK0tCRGpxUTZT?=
 =?utf-8?B?bjQyTE9CNXYreUV5YnhxbTd2K3ZSZ3ZRYzhVeGNYei93SUlFMHAyZW1vV3ky?=
 =?utf-8?B?QStZcFRybXk0S0JXWHJtMWNrZ2ZSMmw4b3NxaFNXUGN5ejFUMTlZOXpqUUdm?=
 =?utf-8?B?VFpybDBwQVE0UFVlMzc1TXdVUS8wUlZhOXZqeGE0dzZGeXlUWVBkbWRpU3lj?=
 =?utf-8?B?WjNhTTBWYUlCUzlvTUdBTjF4T3pLb1FydUFNamZSeSthRGY5emlYRnhITGZF?=
 =?utf-8?B?UjNHWEMvVDVSQWtITEh5a3ZCRjFIQThqZ2E1cGtEd3NCQm9lYTRLOUhKdzZY?=
 =?utf-8?B?cDRudk5VU2xRZkpOalV3L1ZwUklMVm9WRE9SZlhid2E5cDEzcnRnTC9HUGtZ?=
 =?utf-8?B?aDVRRk1Md1E2T3FEWW8zQmI3cHlnKzZ1WFBzNGFsTlNjeFZUaW05SyswbUc0?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac026cc-4a8f-4952-aa2c-08de2beebb74
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 06:49:07.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4N1aGCF+nZTl2CVQy6AjmiSERYK3pbJIshjuWx9aUHwFXvNKwvyQtF7ipSZJRkagRvz6OfSokejlb74tdE0nZDDgYeJ2gBec5f6dFPS7P/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8073
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgQnJl
bm8gTGVpdGFvDQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjQsIDIwMjUgNzoxOSBQTQ0KPiBU
bzogTG9iYWtpbiwgQWxla3NhbmRlciA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT47IE5n
dXllbiwNCj4gQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWws
IFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBBbmRyZXcgTHVu
biA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsNCj4gRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0
LmNvbT4NCj4gQ2M6IG1pY2hhbC5zd2lhdGtvd3NraUBsaW51eC5pbnRlbC5jb207IG1pY2hhbC5r
dWJpYWtAaW50ZWwuY29tOw0KPiBGaWphbGtvd3NraSwgTWFjaWVqIDxtYWNpZWouZmlqYWxrb3dz
a2lAaW50ZWwuY29tPjsgaW50ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3JnOyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsga2Vy
bmVsLXRlYW1AbWV0YS5jb207IEJyZW5vIExlaXRhbw0KPiA8bGVpdGFvQGRlYmlhbi5vcmc+DQo+
IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBuZXQtbmV4dCA4LzhdIGZtMTBrOiBl
eHRyYWN0DQo+IEdSWFJJTkdTIGZyb20gLmdldF9yeG5mYw0KPiANCj4gQ29tbWl0IDg0ZWFmNDM1
OWMzNiAoIm5ldDogZXRodG9vbDogYWRkIGdldF9yeF9yaW5nX2NvdW50IGNhbGxiYWNrIHRvDQo+
IG9wdGltaXplIFJYIHJpbmcgcXVlcmllcyIpIGFkZGVkIHNwZWNpZmljIHN1cHBvcnQgZm9yIEdS
WFJJTkdTDQo+IGNhbGxiYWNrLCBzaW1wbGlmeWluZyAuZ2V0X3J4bmZjLg0KPiANCj4gUmVtb3Zl
IHRoZSBoYW5kbGluZyBvZiBHUlhSSU5HUyBpbiAuZ2V0X3J4bmZjKCkgYnkgbW92aW5nIGl0IHRv
IHRoZQ0KPiBuZXcgLmdldF9yeF9yaW5nX2NvdW50KCkuDQo+IA0KPiBUaGlzIHNpbXBsaWZpZXMg
dGhlIFJYIHJpbmcgY291bnQgcmV0cmlldmFsIGFuZCBhbGlnbnMgZm0xMGsgd2l0aCB0aGUNCj4g
bmV3IGV0aHRvb2wgQVBJIGZvciBxdWVyeWluZyBSWCByaW5nIHBhcmFtZXRlcnMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBCcmVubyBMZWl0YW8gPGxlaXRhb0BkZWJpYW4ub3JnPg0KPiAtLS0NCj4g
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ZtMTBrL2ZtMTBrX2V0aHRvb2wuYyB8IDE3ICsr
Ky0tLS0tLS0tLS0tLQ0KPiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MTQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvZm0xMGsvZm0xMGtfZXRodG9vbC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvZm0xMGsvZm0xMGtfZXRodG9vbC5jDQo+IGluZGV4IGJmMjAyOTE0NGMxZC4uNzZlNDJhYmNh
OTY1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9mbTEway9mbTEw
a19ldGh0b29sLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZm0xMGsvZm0x
MGtfZXRodG9vbC5jDQo+IEBAIC03MzQsMjIgKzczNCwxMSBAQCBzdGF0aWMgaW50IGZtMTBrX2dl
dF9yc3NoX2ZpZWxkcyhzdHJ1Y3QNCj4gbmV0X2RldmljZSAqZGV2LA0KPiAgCXJldHVybiAwOw0K
PiAgfQ0KPiANCj4gLXN0YXRpYyBpbnQgZm0xMGtfZ2V0X3J4bmZjKHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYsIHN0cnVjdA0KPiBldGh0b29sX3J4bmZjICpjbWQsDQo+IC0JCQkgICB1MzIgX19hbHdh
eXNfdW51c2VkICpydWxlX2xvY3MpDQo+ICtzdGF0aWMgdTMyIGZtMTBrX2dldF9yeF9yaW5nX2Nv
dW50KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGZtMTBrX2ludGZj
ICppbnRlcmZhY2UgPSBuZXRkZXZfcHJpdihkZXYpOw0KPiAtCWludCByZXQgPSAtRU9QTk9UU1VQ
UDsNCj4gDQo+IC0Jc3dpdGNoIChjbWQtPmNtZCkgew0KPiAtCWNhc2UgRVRIVE9PTF9HUlhSSU5H
UzoNCj4gLQkJY21kLT5kYXRhID0gaW50ZXJmYWNlLT5udW1fcnhfcXVldWVzOw0KPiAtCQlyZXQg
PSAwOw0KPiAtCQlicmVhazsNCj4gLQlkZWZhdWx0Og0KPiAtCQlicmVhazsNCj4gLQl9DQo+IC0N
Cj4gLQlyZXR1cm4gcmV0Ow0KPiArCXJldHVybiBpbnRlcmZhY2UtPm51bV9yeF9xdWV1ZXM7DQo+
ICB9DQo+IA0KPiAgc3RhdGljIGludCBmbTEwa19zZXRfcnNzaF9maWVsZHMoc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiwgQEAgLTExNjAsNw0KPiArMTE0OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZXRodG9vbF9vcHMgZm0xMGtfZXRodG9vbF9vcHMgPSB7DQo+ICAJLnNldF9yaW5ncGFyYW0JCT0g
Zm0xMGtfc2V0X3JpbmdwYXJhbSwNCj4gIAkuZ2V0X2NvYWxlc2NlCQk9IGZtMTBrX2dldF9jb2Fs
ZXNjZSwNCj4gIAkuc2V0X2NvYWxlc2NlCQk9IGZtMTBrX3NldF9jb2FsZXNjZSwNCj4gLQkuZ2V0
X3J4bmZjCQk9IGZtMTBrX2dldF9yeG5mYywNCj4gKwkuZ2V0X3J4X3JpbmdfY291bnQJPSBmbTEw
a19nZXRfcnhfcmluZ19jb3VudCwNCj4gIAkuZ2V0X3JlZ3MgICAgICAgICAgICAgICA9IGZtMTBr
X2dldF9yZWdzLA0KPiAgCS5nZXRfcmVnc19sZW4gICAgICAgICAgID0gZm0xMGtfZ2V0X3JlZ3Nf
bGVuLA0KPiAgCS5zZWxmX3Rlc3QJCT0gZm0xMGtfc2VsZl90ZXN0LA0KPiANCj4gLS0NCj4gMi40
Ny4zDQoNClNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0
aW9ub3ZAaW50ZWwuY29tPg0K

