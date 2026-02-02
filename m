Return-Path: <netdev+bounces-255975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PZ4EO7qgGleCAMAu9opvQ
	(envelope-from <netdev+bounces-255975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 19:20:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E09D0136
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 19:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9ED30038FE
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B9388853;
	Mon,  2 Feb 2026 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyQUQ7gL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF029ACD7;
	Mon,  2 Feb 2026 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056097; cv=fail; b=tBNRO7PfhmWXKuT7XQxYoQ2X/dle+hWWDOX/2co+CUZ9TJri6PlKP/MRfL9rh++RDNUuuAb86pe9ZToYoawOQVE0qqsbxRgcriEZ9m9LUA8K0BmHf5feRqCuDj1sIQJ/nV4MCLsB7mqWMxD5pqkojovTiJcMPfGQkKkhdkZcpXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056097; c=relaxed/simple;
	bh=3Hf+mwE4TPqP8HNAI2HdQ4mjsc3+vmTqXWWROoklgK8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O0d4QoQsmjidvIoVyuxpcaKZxFo4RhOKBe9o4yERPH0dJ7eSYrC+JbPz8+E0KGc180SQaVsss2IRj/+aHJjVIpykj6PppsX2ucYTAGRtcDjd6uL6mceTOxdEFKpHCWOBhQWNuHV1TDFMRUHPqCZmzculbjV2QZoJI04InqmY/4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyQUQ7gL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770056094; x=1801592094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Hf+mwE4TPqP8HNAI2HdQ4mjsc3+vmTqXWWROoklgK8=;
  b=hyQUQ7gLSgsfuf+XyNrzWs1Yj811mree8zlrhXMFkV+HyXaO1hVWNdaS
   zgwCez72ZA4mTF3sIgwkKXof8+CElCVxSO3tCfyBO1HVVi4X7aexOhn+r
   Xc3w0KtUeKYdAkg0tMFSzCoRrcgWHKZ8rjwxjE7g5acRDUY1BSjnnNi57
   7VEYpzEw6nU/yaI+5lpdJa/O40KWCcNXcBo9GLbPMYP/uQJ1HrBpKmOFO
   LgV7k4R22/sg6Dt5BV2+DxbBujkrLYnUk5Tfr5fmMZKxXF1MC0Q7o3ew1
   AMM5dqYWN15SncxxXPw3An03rJFxUBNvA53tnbJ7OQ22TkgnxH+wDkmlt
   Q==;
X-CSE-ConnectionGUID: ONbZtz9tSGiH4/mZy9oFng==
X-CSE-MsgGUID: oE6UO9oXRlKIRrMJOG5PVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71303662"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71303662"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 10:14:54 -0800
X-CSE-ConnectionGUID: m3OfZAM1QceqLtqBwptuTw==
X-CSE-MsgGUID: /1QosgEoRDqOxXGZDT1Enw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 10:14:54 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 10:14:52 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 10:14:52 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 10:14:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5SwFeiY1TQQB7XWPQxoYLzw/vPwWqjozVVUE2xVi4yEAJ8JWcMnn3x5yWtEWlcjUwgf0zId8bRXb+2dpyrsNIgmsiiywE9qxYwR91yRW05pjwalpq9D5AgoTkPRaWtcWwz1UUWSz+R8c2LVjmOE6CzLsJ6slbf13wd+tItGDo6pN5Qpq0eC2LTB41zgolRAYmOxwj/IJ/xeztgha7g/G8v0CMw5XbQ3hGhWlbNyk0lgh6bdnF2gKm/qJ2ABB2oBgBURBCzL0QQbEe6rmYbPjaQu0XeEb9zeCNlPdBXcCXIWL2MgcG7GtxCQrcjnjkdIlOVkyKxCX9BeW+Fz4QqaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Hf+mwE4TPqP8HNAI2HdQ4mjsc3+vmTqXWWROoklgK8=;
 b=BH9nVXrfiGPdfAk5AQeNeilrKvXvXzV+A7omdTXGabWYN/dmm6uhb8DzYTIPCJ+ZsQUgwmYqb5B4WvZKvZuZy04GzMSlYnPPbZpuJBSP4Dyokiu9W4PHxjB41/0TvgLObm7RHhG2l2IxMGfiEscUmgvuz3h5S6LU3VPlb/0/UyAIBdJJGAPksFidRy5muSulElAPH4FKCb4hv3WRKveyRyJUl8HIC3I1tdzx9ZnhGbvmzzW+gyA9aWLxIlaaCnNgPVu5hoMP9IqpnL7ZMWTjXEktxLt9OTfevGtWx/pIxTtHtyWwqHIjTUbkfdiWqF6Jcxaz07seNDhXb61XkFpCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by PH0PR11MB7544.namprd11.prod.outlook.com (2603:10b6:510:28d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 18:14:47 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 18:14:47 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Eric Dumazet <edumazet@google.com>, Brian Vazquez <brianvv@google.com>
CC: Brian Vazquez <brianvv.kernel@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "David
 Decotigny" <decot@google.com>, Li Li <boolli@google.com>, "Singhai, Anjali"
	<anjali.singhai@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	Brett Creeley <brett.creeley@amd.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-net PATCH v3] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
Thread-Topic: [Intel-wired-lan] [iwl-net PATCH v3] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
Thread-Index: AQHcjw6j/J5Pvz2IVkKLTfYdHXHMRrVmOI4AgAmInyA=
Date: Mon, 2 Feb 2026 18:14:47 +0000
Message-ID: <SJ1PR11MB62974FA134978745DA0505229B9AA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260126215600.3387171-1-brianvv@google.com>
 <CANn89i+ioEJFnZF3B36xGXcCPgtiLevZOs9pncXhgLKb80sm_g@mail.gmail.com>
In-Reply-To: <CANn89i+ioEJFnZF3B36xGXcCPgtiLevZOs9pncXhgLKb80sm_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|PH0PR11MB7544:EE_
x-ms-office365-filtering-correlation-id: 97c85123-093b-48aa-7956-08de6286f317
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UThnWHpjdHltaWNtMFN3RHVkUXJrUmJCZFJyQ0ZuWjRhZURXMGZ4NVNrakFi?=
 =?utf-8?B?Z2thSmcrS1lnN3FZaGFjalcvQ2c5KzdHc05zaXVjVVl0M1BZRFBJdCtYK3ZL?=
 =?utf-8?B?SWpIU21MWkZiMHNMblNPQ1FZRFhBalo5NjAxeGEwR3NEUGJ1aHhlOEJyQ3dW?=
 =?utf-8?B?U0lwYXJ3dFJySmRBb0FXcEhMUjZUaEJmTStqOGxwVk82UHg4TlljamV0SlRj?=
 =?utf-8?B?VFZhZW4vRXltc2tzYnNTR3hwYkd6NlN0azJqWDByazhqMFQzVllOanloVzJF?=
 =?utf-8?B?U2h2UTlyNkMyOGVqRGhQN1pOWjhNaDVseGlJV3BHUEx0U2ludTMyd2FkSGRX?=
 =?utf-8?B?WEF3SXpLOGtDWElDWTc3K3lCRWNlVVdpdm95NUlHQUVBZkpPU0J0VXRmVFpt?=
 =?utf-8?B?aGp1bTBTc0R0b3pNK2dOVXFvd2Y0UTJ0bTZ4WUpaTDVJSDBtU01pOWhVc3hl?=
 =?utf-8?B?S2RRSnF4dFNSOE5qVG4yUytMY2ppTXJsKzZmczMvL2lnWi9QTUMyd09NWElU?=
 =?utf-8?B?Q3JXc0dncllhTk9jYloybE5jcWtORUIzKzk2T3hNclhWWnFoUmMxZjI5REhi?=
 =?utf-8?B?dHZLeHFMRXJTd0xWcTBtRVZNcHlDK2xQYk1yNHRHVFdXK2dQVzN1YkROVnNp?=
 =?utf-8?B?bkt0Z0ZabEI2Z0c4VkFRejdPZmlWWDlvS2Y3NzhzTzJROXZwZFpwbGg5clZz?=
 =?utf-8?B?NDhPUXF5d1FtSkE0ZllmcFc3ZzdaWHJmV0Y4andNdnlicmdrdnJHWjRncHRZ?=
 =?utf-8?B?RmREdCtITFJFYWUrN0luMUFGNnVqVFRvY05kYTNuNzZrUnFGUW5vUzJ6cUs2?=
 =?utf-8?B?SkR5TWFxQjBId01lNEdnbWNwOW9FWlM0aGpmNUVrT0ZYZ3gvNE84TVBYc1lR?=
 =?utf-8?B?R1NkT1NxcFg5OFNXc25tYklRR1pwbysrczJMbEVlc2ZxUnM5aExNaXhyaWNa?=
 =?utf-8?B?eVVHRFNENG9wVVBpaHNjNTFIQW5lVnR3RHFBRWFWUWVaKzNIbm5GWTFVSDNu?=
 =?utf-8?B?NWFzaXo0RUV3dnFkNlRYUjlVUmRSeGl5OVZEcGltZ1FTZHcwOXYwN3hZb3lS?=
 =?utf-8?B?MTVTWXpYOVQ0UzU0aXVmSE0wWCs2NUFpaHBsYXpyam5vbEJHMDZGbmd4UElL?=
 =?utf-8?B?YlNyUXhCN1RMVUpwb0RkVGE0WENCN1AzcXRnT2ZBL0xxck1GSXJHcmI2OHhX?=
 =?utf-8?B?a09qSXRWMVZqT1ZGaEoyWGtqbVR0dDRqVC9WZ1A0bkNmTXJjZ2xIQXdqMTlE?=
 =?utf-8?B?TjErOUdDTlVWVHY3ODNweFJTenpCc2l1OTQ1OFpEVnB2UHJjY0tkZEl5QTJH?=
 =?utf-8?B?YTBBRGFjKzFkTXREYzZsZVllaVVuemxvVEZwTzhXb29ESmJWRVF0WUVySnN6?=
 =?utf-8?B?QkFYbmlYMEZQQklTdVZGdVFiWE5ibkZHcW1qVnFCbldkTVZ1ZVI5T1hnWXl4?=
 =?utf-8?B?ZUFVU1NMUFUyWnFTMng2dWRoQzMzZEdqelFvUHRiMlNjMlV1TUV3K3FhaW9J?=
 =?utf-8?B?R0tPOFFlYVJtNXdJVG5qVFpzUWhmRnpMVk9MTEhFd0pRNmpjQkhvN3FUZjlO?=
 =?utf-8?B?VDg4bW1qaVh1amw1L0lWbFludi9jbHZNU2xhU0RpM0JZVVNWdU1uOHg5ektk?=
 =?utf-8?B?akpWTWNqeGNHU3lzV2RESG52aU5pUDhRbG1IQ21WaDNNbEdPdHkxZW1MakY3?=
 =?utf-8?B?MkFFaXV2ZktTa2NORi9xYkZldUI5SXFyamVMbGNQd3ZSTWUyVFd4Rk0raHli?=
 =?utf-8?B?ekFTNFdQMDdDVCs4dks0dzVZVHMwTTUxLzRIcC8vY3NyWS84YXFibmZ1RmJY?=
 =?utf-8?B?SlkzK0o3cnE0SUNsQ242S1JTTk1sZ3JhUWlvdWEzMDZzaEtuYjhTMDhGL1Y3?=
 =?utf-8?B?MnZIbHBITjBtR3VLa1hMU25JQXQvTWNzT2MwQ3JJYVhQTFRoODJaQnI2S3F5?=
 =?utf-8?B?K2VxWXVNS1ZhOWF5aGpQckNhQ09USFc1NWZmWUNQSEFmeFhmZ3oxcC9IUHVq?=
 =?utf-8?B?ZURMRjlzVFVCSlpuSERvSXJ1VFJHOUZLYSs4cTBITFVZZ0JaN0NDYXU3Mk1w?=
 =?utf-8?B?TmZTYVhCTDQrRW9QVUE5Ym9FT1lCU1RHcHUzOFNVaUJvVDg4L1F0WmhURnVJ?=
 =?utf-8?B?RnRTWWlMTEF5OWl0bmUxMUZTemxsRmZ6eXp3OXFJVFRPR1RaMTFwejZWNzV3?=
 =?utf-8?Q?kj2KBqjgMjDjb0R9kKH4ddg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2JKTEFkOWFqSStYYVNGa1o2eEFzdklxQmxYcWRBM3lUck5wVnNhbjN1MkhG?=
 =?utf-8?B?ZVA4N0lSaTdoclpKaWwxT25MWURPbTQ4enl5SzNsUmthV0JqcCtIcENBSDNC?=
 =?utf-8?B?VFdxbk5iQUhPWWFVS2ZjWFNRc3pLZ1NXRUtUelhMOTVxTlFBYkI5elJ5U0lK?=
 =?utf-8?B?VDVtVThvcmtmaWtwalpTcit5bHRnTGI1dFRvMVk3dFRPVnA4bjFacitvVlZu?=
 =?utf-8?B?TkNKZytGRVFtSjVBc2ZpUTU2KzBSVkZkNjNaWW9HRVBLMHg3aVZMWHk3V2dz?=
 =?utf-8?B?WkxXZE5qNGExUkMvS3NWVVJvKzBqMTgyejRyZDVDc09aNUdzMVdRQzUyaC9u?=
 =?utf-8?B?NitWRjFiM3Y5ZzlMTzhjekl5Wkt6OGRnbTMvWHhQMHNZdE9LRUYzMTErNXVy?=
 =?utf-8?B?bkFmUFFlUlZRYjFUQnVtbmNLMXR0SXF4T1dlQ2Z3Wit5bTgzSmpHRTErUGpS?=
 =?utf-8?B?YXFaeE5kYitPelp3VG9rYy9GS2gwYzJxZlcwODZmYXRMT3R4MHZmRHhCc3pR?=
 =?utf-8?B?L1cza3lPb00wWU1teUpWejhaaDV2L3RyTGY2K1Y5bmsyNDNKcEFCZE43RkVD?=
 =?utf-8?B?WG01eCtNTmw3Z1NKeGlHcVJMZStMcCtJUy9SOFR1bmpjUHl0UkhxVE1jNEtP?=
 =?utf-8?B?VDNra0VVSUROckR3a2NnZHNMZTc2ZTJpcmVLcnBRV3g5Q002SGF4SEtSNEVD?=
 =?utf-8?B?TkpnN0FJZE9XY04zYjNHYm9UcEdsdHpTNWNBOXFwK2tXSVNDVVdBeDgrNDB3?=
 =?utf-8?B?RDJMWXM3djczTzBjQTRZRFI2YzUxZmdqVmR5ZlgrRE5ZREFXRGxhcmZzS3BQ?=
 =?utf-8?B?MnJYaDE4OWxhMm85TG5wbHpFKzVlVE9kbk1pZU5acEJuUUd3dEpsZ1ozRnNj?=
 =?utf-8?B?eHJ4d3Q0VmsyNVRLVHZBRVovZ1IyQ080b2xnRnhNRGppUjZ3L3Fic1ZJTy82?=
 =?utf-8?B?R2ZVSW9DelFiRnFUS2FDZUlWQTFiMWQ2OHZyK29kdWMvU2hHb3AyRGdadVkw?=
 =?utf-8?B?RVA1TWFiMUp5WnV6dlZJRU92bldKbUVWS0lzOXBEaHJDUFlwOXhrVFJXYVYx?=
 =?utf-8?B?dUZoUnZqQy9XZzZtTWlqTllFTHFyQjJvRmpWaTlXblk2d1BibXBLb05id0Qz?=
 =?utf-8?B?S0VjS1VKMW1oc1VJcGN4SEJzMkNqOUxRVWFUN2REODNDYTU3Zk01VEJBcHhh?=
 =?utf-8?B?cnFjM3hEMTlLZG9WM1piazZwc0gxYnlRVFJoN0NjU3VJSWdXbVViMUs2eS9Y?=
 =?utf-8?B?ekFUb0c4dnY2RWt6VUlDWFBieHFyZHpFVmtPUE5VVUdndFAvelZSN1I2aFRi?=
 =?utf-8?B?eld0Wk9nR3ZEU05peHJoN0hpSm5lM2p2aG1jRTAveWxpTlgzM1NSdUZLNGVw?=
 =?utf-8?B?N3lLWjZQTTZvRnN6a1FYbVl1MmpmTUhhZGNrbXVEWS9hS1lHVTJqVmorQmNI?=
 =?utf-8?B?ejlCbVRKNkgzelQ4OW40ajNSL1pudTBHV0NMWk1oUUs5SUNUTFdqcHFDMHNx?=
 =?utf-8?B?T0d6VjROakFXcUwxRjNRaTFCbWRaNWQzM3VjODRiWG0vVWVhQ3BmQStTVTVl?=
 =?utf-8?B?a2xwUjZza0JJcndKcXJodEJvVFcvWXh6Q2JRWUFzbVpsUTZpZmJwekZhRi9X?=
 =?utf-8?B?MVArbmN6bzE5eVJLdGtVNEFYNEY4RUVXSTZBbzNvUGlreGVNY0k5bWp2OG5u?=
 =?utf-8?B?Wko4RkhJaU9CcEgwUEhtT21OTC9tTnh6YTZUbE10SFA2eXRFYjZYL0RBMGw2?=
 =?utf-8?B?eFFVb1h1aUN2UHE4Y3VnKzNWV2NBbENDU0xuOHFEWGhBdkYyR1g4SmZEdVF4?=
 =?utf-8?B?cERySFMzWG1tbkRhZUl1TEVOczZBcm9GaHFTd3hnSEZ2SUlkNlNHMEt5UkpQ?=
 =?utf-8?B?QzdFSFJUTFBiRVRUcjRIWEwxNkhROUtqQ0swdUQwQWF0bUY5SnFEeVBMNmZ0?=
 =?utf-8?B?Q0hpS0xKdzBJV0VEUExuSncvWUFVMURQVmNSUW9XYkxGMk54bDFJT2NMVTdh?=
 =?utf-8?B?SVNzQ3FNNy84a1I2WGhRR0dPWjR1bWN5VzVLUllWakRyV0VETEx5V2p2T2Iw?=
 =?utf-8?B?VUg1RG5mU2RCNm96TkJDcWhlYnIzb2hEY0lzYU5VamhpOGxkZit1Vkw5dkNJ?=
 =?utf-8?B?Tm95NmVWdHo1dFRxMmRNcUpEa25VWlJFeFlJV1Bta0xmaytNbE1FZXowNkts?=
 =?utf-8?B?enBNNU9NVGc2QmlvVW5INnhCeXI2Q1c5Ulo1aHl5ZTJjZ2NKdnBvdmZQcnc1?=
 =?utf-8?B?aGVtOGFhcE82NEVlSzN2T3NLcFh3S1RmQ0JDYU9vZE84d3A2QXc1UFhUdS9P?=
 =?utf-8?B?WWtYZWJuVXFzUlZoTlByay9IV2F2cU1FWXhibW5rSFhrK3VPLy9zZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c85123-093b-48aa-7956-08de6286f317
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 18:14:47.6524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w5eV3rXZR4YsDcVPzNtaUpWZo9JFTugSnta7AvX8CJDVDPK74VrQRG+tIUCyoJm+mvyOQ7yv7awzZz8srvHbqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7544
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255975-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,davemloft.net,kernel.org,redhat.com,lists.osuosl.org,google.com,vger.kernel.org,amd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,davemloft.net:email,SJ1PR11MB6297.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.salin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 68E09D0136
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBFcmljDQo+IER1
bWF6ZXQgdmlhIEludGVsLXdpcmVkLWxhbg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDI3LCAy
MDI2IDg6MzggQU0NCj4gVG86IEJyaWFuIFZhenF1ZXogPGJyaWFudnZAZ29vZ2xlLmNvbT4NCj4g
Q2M6IEJyaWFuIFZhenF1ZXogPGJyaWFudnYua2VybmVsQGdtYWlsLmNvbT47IE5ndXllbiwgQW50
aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNs
YXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBEYXZpZCBTLiBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+Ow0KPiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsg
UGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgaW50ZWwtDQo+IHdpcmVkLWxhbkBsaXN0
cy5vc3Vvc2wub3JnOyBEYXZpZCBEZWNvdGlnbnkgPGRlY290QGdvb2dsZS5jb20+OyBMaSBMaQ0K
PiA8Ym9vbGxpQGdvb2dsZS5jb20+OyBTaW5naGFpLCBBbmphbGkgPGFuamFsaS5zaW5naGFpQGlu
dGVsLmNvbT47IFNhbXVkcmFsYSwNCj4gU3JpZGhhciA8c3JpZGhhci5zYW11ZHJhbGFAaW50ZWwu
Y29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgVGFudGlsb3YsIEVtaWwgUyA8ZW1pbC5zLnRhbnRpbG92QGludGVsLmNvbT47IEJyZXR0
DQo+IENyZWVsZXkgPGJyZXR0LmNyZWVsZXlAYW1kLmNvbT47IExva3Rpb25vdiwgQWxla3NhbmRy
DQo+IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtJbnRl
bC13aXJlZC1sYW5dIFtpd2wtbmV0IFBBVENIIHYzXSBpZHBmOiBjaGFuZ2UgSVJRIG5hbWluZyB0
bw0KPiBtYXRjaCBuZXRkZXYgYW5kIGV0aHRvb2wgcXVldWUgbnVtYmVyaW5nDQo+IA0KPiBPbiBN
b24sIEphbiAyNiwgMjAyNiBhdCAxMDo1NuKAr1BNIEJyaWFuIFZhenF1ZXogPGJyaWFudnZAZ29v
Z2xlLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgY29kZSB1c2VzIHRoZSB2aWR4IGZvciB0
aGUgSVJRIG5hbWUgYnV0IHRoYXQgZG9lc24ndCBtYXRjaCBldGh0b29sDQo+ID4gcmVwb3J0aW5n
IG5vciBuZXRkZXYgbmFtaW5nLCB0aGlzIG1ha2VzIGl0IGhhcmQgdG8gdHVuZSB0aGUgZGV2aWNl
IGFuZA0KPiA+IGFzc29jaWF0ZSBxdWV1ZXMgd2l0aCBJUlFzLiBTZXF1ZW50aWFsbHkgcmVxdWVz
dGluZyBpcnFzIHN0YXJ0aW5nIGZyb20NCj4gPiAnMCcgbWFrZXMgdGhlIG91dHB1dCBjb25zaXN0
ZW50Lg0KPiA+DQo+ID4gVGhpcyBjb21taXQgY2hhbmdlcyB0aGUgaW50ZXJydXB0IG51bWJlcmlu
ZyBidXQgcHJlc2VydmVzIHRoZSBuYW1lDQo+ID4gZm9ybWF0LCBtYWludGFpbmluZyBBQkkgY29t
cGF0aWJpbGl0eS4gRXhpc3RpbmcgdG9vbHMgcmVseWluZyBvbiB0aGUNCj4gPiBvbGQgbnVtYmVy
aW5nIGFyZSBhbHJlYWR5IG5vbi1mdW5jdGlvbmFsLCBhcyB0aGV5IGxhY2sgYSB1c2VmdWwNCj4g
PiBjb3JyZWxhdGlvbiB0byB0aGUgaW50ZXJydXB0cy4NCj4gPg0KPiANCj4gUmV2aWV3ZWQtYnk6
IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCg0KVGVzdGVkLWJ5OiBTYW11ZWwg
U2FsaW4gPFNhbXVlbC5zYWxpbkBpbnRlbC5jb20+DQo=

