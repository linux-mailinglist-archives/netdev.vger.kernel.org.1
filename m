Return-Path: <netdev+bounces-293691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O1qBu5rHWoTagkAu9opvQ
	(envelope-from <netdev+bounces-293691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:24:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A552661E46B
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C8323008D4A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B938947F;
	Mon,  1 Jun 2026 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJ9gFBCa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C513A382D;
	Mon,  1 Jun 2026 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313065; cv=fail; b=b86mDh85QNocJZxXNhbtnCtabHjy5MQ89pfwGEFr+bRShS4fQ9gH/SFefurhTKJcJdHj91xHRqF8DyyUEy9WPYf60hMsK25VtRH7BijzLuCi0+T1zxr5vJ7wyHLtNFNXcLYDYnc/TiJYU3qHhxm8nzICLxejg1Q/MZJ2kihRMnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313065; c=relaxed/simple;
	bh=acDybKsW2YJmy7GQr42TYoNzYQTHumM/d1onyKYtLYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r1RlGxJF/jULUbfE5svj5dwytlDzaxia92+X89G4EzkE71imO0nMh/ftQQM4NKX5F+lQOCJWIX9rmWJRsdFKz9KTo8qRGgegiyJp/EnbxRjVVKA/tL/6bE9XZXREkeYVXYZ5z608VRD8uLL1H49Nm5LVLKLMxTtgsSjkNrblick=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJ9gFBCa; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780313063; x=1811849063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=acDybKsW2YJmy7GQr42TYoNzYQTHumM/d1onyKYtLYU=;
  b=SJ9gFBCakj8zGWLljameR5SVW8eekZyZC53N09UefA9OouUenDr03CuZ
   dhNZy4A3wFdO3N6VvSkrD6uKMR0DW4LB+g3wx7tpK+ed0EQ1at+eiowDt
   tPnF5uq9I92fJaly2nrH9pmdMqj3dnCU46xfMklcPWgKLXd54QQqidY/L
   YDcC9ZwryDwY85WNUkcUpIIaFHP+lT1RiQxJugs5la9UHTfXwZ18Y4J3D
   3Fhm8K8zoSHMizsMaMpWR0GGFxzTO96H0wUiB9puhWi/6IROcwRB6ftaw
   9W1PXqBM5watx2uD/fd149j7CPHqOHyt9XFvIFbcoKm8D8pq/n99UFjap
   A==;
X-CSE-ConnectionGUID: HFpYgPCPS4+lerdci3n4fw==
X-CSE-MsgGUID: l8WwxFwQQbGvWSUKEuHf8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="84694592"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="84694592"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 04:24:23 -0700
X-CSE-ConnectionGUID: qJ6/kW3dT3+QPv2BYBbJUA==
X-CSE-MsgGUID: no74XYpGTqi3Odr+dU4iiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="267191070"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 04:24:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 04:24:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 04:24:22 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 04:24:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTUMEikEoc9ImoOwLfzOv+C8P7/GZ02PbCkyndAmKXZqZzCWHfZ9LQZgxmWXv0MdQQvQA4Kn5av89uCpE2B7pcplxai2DphLEgp+o8bK0ejrsiZI73YKA+728CaH5/HZl0ktwtjO6+odnJYxP2e7PwM0GIxH9Z2NAJoy+BYx3YHMD/YaIaetrJTulkhvCwbyLk9Th08n3V+vCYSsSUs72aiEGuWeeOU0CFlGTua6O4RYC7cSNbF8377kbpgC7mcyBKAdvvxtQstPuD4EsMXykVu/XThdx6kZ3R2jHQgkm8iEewD3WdG9Rl4ftcm2DP6cacYZTs+b0tkJGiW9f/qlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acDybKsW2YJmy7GQr42TYoNzYQTHumM/d1onyKYtLYU=;
 b=YKPR/umFaUeShhL4LcDCI5dHq3g85H+XmFu6TpZ1DszszlZbArdpbq6+P3fakU4YP2/qlZHLbwiKqTw5TbJujUrf2ljEzbZnp7hzANKcTVal9ggX4rtLSxjm/IXC/7U8opdE1g6vAmmFNKDDjE/mZTGV4c66r6AUSskS+lCqWYI1agfBG9DIMD+wxwkHyXIVJDJ6OFLL3Db7FmxLSObuk1QXy3WWjCQ8BvearleEIpihez4/LNAWXRl6D7VZE9qUoAxJ6Kl40b6y1wMNCuJS6VsPJtJ8mZICvCgVym5ePhmZVXlc/KqWcROGm2EV4vG45CQSPc0tdIC84Pkvy5nneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DS4PPF399DBF572.namprd11.prod.outlook.com (2603:10b6:f:fc02::1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:24:17 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 11:24:17 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "jackbb_wu@compal.com" <jackbb_wu@compal.com>, Loic Poulain
	<loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, Shi-Wei Yeh
	<shi-wei.yeh@mediatek.com>, Minano Tseng <Minano.tseng@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH 02/11] net: wwan: t9xx: Add control plane transaction
 layer
Thread-Topic: [PATCH 02/11] net: wwan: t9xx: Add control plane transaction
 layer
Thread-Index: AQHc71hNaC5RpQM1jEq4901dslGC+7Ypk3yQ
Date: Mon, 1 Jun 2026 11:24:17 +0000
Message-ID: <PH0PR11MB5902FB4FF84AF8041B72D455F0152@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260529-t9xx_driver_v1-v1-0-bdbfe2c01e57@compal.com>
 <20260529-t9xx_driver_v1-v1-2-bdbfe2c01e57@compal.com>
In-Reply-To: <20260529-t9xx_driver_v1-v1-2-bdbfe2c01e57@compal.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DS4PPF399DBF572:EE_
x-ms-office365-filtering-correlation-id: 47b6d976-8905-4e6e-4f27-08debfd05186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021|18002099003|22082099003|6133799003|3023799007|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: +NK8CRfSsF4MhZ/uVl9sJpoBK6+FjoIlg1oVqlVo9+j2L+oyIYGK6Qc4nBwZb9xNRTqPzBk04K+bIyX59nXkkWeKmCNtX3QGh94Y8sVAz9pcNOiywsldJkKf2W8St528sWydKeAstEGNK5Jr1axkt0j7qShry8kcC1gDFQw1RVvY2S4ufqHECM8afVBNJH4jDfakWNVbQz1vIOGUh1UTmf1kqNLQW+dZz5Qxgjtnu0dix6FKAgpWmHI/ZSebebdxeOLKyCMvxT6vCHSZqYc2hYNDbjEWmSG6OMLLAoucqJnhTq3XkKhu+rGNxA6XkmLZjaDMaE4FP2rvKhD3FpoxhDTMaUTblMcHhCVJI0vA56HIyvmpJL7LylGI0/PFu8Ef6b1NxTg1vEqJe76JpT+JwTxarOEgBh7KYhnoNVUPDvHV4i4zOKK6qbeDkof9RczZIvitBUHdUjhu/w5iMhsFerPkbUeM3ZjwiAKs4IugzppoSNTdbNAbXO0fAJ2boUYxIpwSs3EmQ6F6BTjd1/dNYofHjmee97CYmHR5XkzsCVnWYZnBHG0ZJQADA0qJeLuBgrDEPSxfvlM5cjf49xWyGOLhTgT3lKKJENcFAQsoDU9hpa3qAxxJhDaV1KS2CsZ1qMcQySTkquAZwgI8Nuy8KYZp4O25VDo6w9qzi1MiLNB69/x/X9kdV2EokxAJIh1+S7uo0SY0V2y6n/vt7aDycu5Rvkzl5WwBN4c9wT7cJ5m6yQJniDkSuWRVkb+qx6IT2RsmJfy6vDy9q5tlJtBipg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUdqeXZiSHFhY1NtUjNuaEp4b0xlVitnbkVVODRLMWRPNURiaERabHZmK2xB?=
 =?utf-8?B?UlpOTFZzWEtMZG5TR1gyRWtadWRONGZISm1PK2dKejRid0V2ZmRyNHBFVExD?=
 =?utf-8?B?bzZKUnBaSmNON0FoZnNKWkN6WmRvWEl3b3lBLys3NnBHanl5U3NVN212aVY5?=
 =?utf-8?B?TnlDY1pYYUgyTnBFdllWTE9PNE5mbnJyam5nUlkwbVdEN2JZMFJIMnBLaWQy?=
 =?utf-8?B?MDJaaHY1L3FYNG5YelRNQk1IQTBadllHYzR6UEtnQ1h2ZGJSQXBIWFl5Sno0?=
 =?utf-8?B?ZmN6em5VZ21kQ2txbFN6Tno2bTVOb3BnSUhtbzhxVmhNeENxSmo1Q29NczdS?=
 =?utf-8?B?cDZmN043WEk2aVBDMjF3RHB6STIyMFdGTWpaeUZ0UkZKVnFId2lQOVJRWmpR?=
 =?utf-8?B?WXVuRVN2TFhLb2pjVTBKZzI0d0p5aTJ6bzlWNGNsZTFIRGtLZkZqU3BUZXdT?=
 =?utf-8?B?V1pnV2ltM3o3S0tHUEVXY3hGV1U3QUppbFk1SmxYUXNxd1d5bTdoR3czZ2ZD?=
 =?utf-8?B?ck8vUHV3WUpueXNHZ2NmeWI3TTY4THdubFhmRlNleFJvSWx2MS80SUx2UklJ?=
 =?utf-8?B?US9xNGMwSGxJZ1puVTdWdmdobHdhNHlQRXJQcnBJK2QwNjlmR2IrYkdrMmRv?=
 =?utf-8?B?ZjBxTUUvSXhhNUVSNHZKdnVZcE5malVaV1pMeHRLZnhTTTNTVDFlQURXSjdJ?=
 =?utf-8?B?bWx0dmVqRHk4M29abmY0SVloL0srWmNzaFB2VHI3djU4TlZWZUYrWXNHNlZQ?=
 =?utf-8?B?bXRuKzRTYnlBU0V6YVRBVWRtMCt4TVpObFVuUnhkcmdNeVVySGVZY0M2QXhT?=
 =?utf-8?B?MGU2SFkzZGJaM3BBTDZ5MXpTVmwrUnE2Sk5oTlBNMkFrL3ZVTCtkYXBhVDFy?=
 =?utf-8?B?bjZEalZyZGtVZGtIc253ZVF3NFVaY1ZIWitkWSt1dHVlTFV4OVdkVVNpa2xB?=
 =?utf-8?B?eHZnMVpJZ1ZsUlNZZkM4aWUvWmpkc0JGM3NFeSs0cHBSdFNmTW94U3hCRm1W?=
 =?utf-8?B?RUZRZTQ1KzJHMXZPS3VnZFQvY25QZnErQWhHMWtvR3hPT0d1M0lGWDFnU3dN?=
 =?utf-8?B?bk1RcVltVk5yb2NMMFVFQURmQjkzYXI1NGx2QWdreWZpREt1UmFGR0pkdFBR?=
 =?utf-8?B?NmRCS2g2ZnNIbTk1Y3Jpb3pESENncjJQNUFVZG1FYkNtU3NMU0trdUd5a3Uv?=
 =?utf-8?B?dFIwUzdqZjAwNDN6NzdtUEVET294bVg2M04zR0k3SUFrN3Y3dS9XMElJMnlm?=
 =?utf-8?B?WjY0bEhiNXpvTS93VU9Kd0sxKzZSV1BQYU55cFVHMzI5cldTMmg5bWxleWZM?=
 =?utf-8?B?VVNkUEtPYlNrMkkwQjFXTnFiS25oMU96VHBXenB5dnRPZkZ1M0xNTElpeEVC?=
 =?utf-8?B?aWR5aHNWOW1TUEtIZjZtYTEzTW1kTmFRYXViaXRBNE1uRVlVMkkzeXliN2ln?=
 =?utf-8?B?emN4eng0aEREbUFzSjZ0L2VXN1hGVUd6a3plNEVqcUkzYTNUUXZUaHB3RDBr?=
 =?utf-8?B?ekhEV1JzSGxTdWxPK2w3d3hOQ2N0K1ROcGNBbzEzcy94eWUwRC9rMTlzWjk3?=
 =?utf-8?B?dXBManRuWS9rNUpwRmloTG1TbVhJb1QrVG9XTFdlSUJTa3BJZWhmY2xEQjEr?=
 =?utf-8?B?SlZhS3JlV2xBTXVaWmVJVVRuMjRHNFB3bmlIQmpaamRvSFdpNnRTZmpGWjNi?=
 =?utf-8?B?NVFzLy8za2lRNExpVlVNYkovZk9rREdEQzQ1bnk2dG1qQ3hrME03VGFwYVh4?=
 =?utf-8?B?dTRQRCt1YlRaRlBIazJPS0MvNnIwRCtKQ2txUXp0Q3F0elNSRGt5UlNzRkxn?=
 =?utf-8?B?WkFzMkZmeDlnVlBsbmVZSG9GN1hDaG5icFF6VUFITnBKeG1INUh1VmVyVkt4?=
 =?utf-8?B?SGxTRWlaRGFsMFRSZHltTmZXOTZzVm5xcUM4ckZrZU1iRHBrdC9qTmY5ckRj?=
 =?utf-8?B?KzltR0tiQ1ZyRkphK0N5aUFiVkk4b3hhdERkeXhkSG1IeW00RWdmYit2dFhN?=
 =?utf-8?B?aldVM0liZGpRbi9SNnFvQnd6aDRDczFVdUNHalVmOG1zNlNybzVmUTZwS2g3?=
 =?utf-8?B?RlZ4RS9SMXRwVzBJb0s3MXd3b3RnS1dEb0pVVUtVZjFWb1NUcnBLcmR6T0hz?=
 =?utf-8?B?Wml5Y0k3b2c1NElTRk1FUTRjdWc4UytuOU1OdTAvY3BtRCs3NGVHM0Q4UTRi?=
 =?utf-8?B?MUZRTm9xMWR2eU9VY2pkVTJBMFhwVFBISjNpUHJGUEFBV0hUL1UxQW5LbFR5?=
 =?utf-8?B?NWxncGNtcG9Td0t5cEZsRzczVk0yais5OU1PYmRrKzVNSHljQ2RWV3ZHYXc2?=
 =?utf-8?B?dHgzZnNXUWVGVTRPSUFTUE14cnl5NGFHVnl1b1BMdG8wV2I2WjVuUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: slJySK5u9GvtjXVrXYadd9WMp8A9YOQw8JNlBeh2sqMkV6zcQUwsI9ak2WxBjrhrZZx//ldAV8rwHW1x1WL62rUz6A4N6erTNHjd42/H6HfjJow44ZODWHpx/wWomMVe0KB/4u6e2Ejm5+NZFy4MenqwwmSRWjfSQYVA8jKCi9HlEiURxVcgVtvF4j/SIIg3L3iMwqWRFJCpAl4PEemNrKEA/X7elnoRiZxSH+4Vem7XG+hd648vMiyEc4MDTlgrKxzuaVoZxvu6Zjkdzj39UBJZyZv7d4fNEQ7Rkokm0nKz7vJKwkPWIinErE9egxIhcOYgZ1y0AHt+F+HLGesDGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b6d976-8905-4e6e-4f27-08debfd05186
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 11:24:17.5005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmzi6dK2GIGzBVq9uLhfhFWimow4q8QuRkde+5CAnP2XMy4dlS017JIxBSqRzY9738oKzy/ClM5rjsABUONX2/fdwlePhK3PnZGzZay1VcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF399DBF572
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-293691-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[compal.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mediatek.com,collabora.com,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,PH0PR11MB5902.namprd11.prod.outlook.com:mid,intel.com:dkim,compal.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A552661E46B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogSmFjayBXdSB2aWEgQjQgUmVsYXkgPGRldm51bGwramFja2JiX3d1LmNvbXBhbC5jb21A
a2VybmVsLm9yZz4gDQpTZW50OiBGcmlkYXksIE1heSAyOSwgMjAyNiAxMjozMiBQTQ0KDQo+RnJv
bTogSmFjayBXdSA8amFja2JiX3d1QGNvbXBhbC5jb20+DQo+DQo+VGhlIGNvbnRyb2wgcGxhbmUg
aW1wbGVtZW50cyBUWCBzZXJ2aWNlcyB0aGF0IHJlc2lkZSBpbiB0aGUNCj50cmFuc2FjdGlvbiBs
YXllci4gVGhlIHNlcnZpY2VzIHJlY2VpdmUgdGhlIHBhY2tldHMgZnJvbSB0aGUNCj5wb3J0IGxh
eWVyIGFuZCBjYWxsIHRoZSBjb3JyZXNwb25kaW5nIERNQSBjb21wb25lbnRzIHRvDQo+dHJhbnNt
aXQgZGF0YSB0byB0aGUgZGV2aWNlLiBNZWFud2hpbGUsIFRYIHNlcnZpY2VzIHJlY2VpdmUNCj5h
bmQgbWFuYWdlIHRoZSBwb3J0IGNvbnRyb2wgY29tbWFuZHMgZnJvbSB0aGUgcG9ydCBsYXllci4N
Cj4NCj5UaGUgY29udHJvbCBwbGFuZSBpbXBsZW1lbnRzIFJYIHNlcnZpY2VzIHRoYXQgcmVzaWRl
IGluIHRoZQ0KPnRyYW5zYWN0aW9uIGxheWVyLiBUaGUgc2VydmljZXMgcmVjZWl2ZSB0aGUgZG93
bmxpbmsgcGFja2V0cw0KPmZyb20gdGhlIG1vZGVtIGFuZCB0cmFuc2ZlciB0aGUgcGFja2V0cyB0
byB0aGUgY29ycmVzcG9uZGluZw0KPnBvcnQgbGF5ZXIgaW50ZXJmYWNlcy4NCj4NCj5TaWduZWQt
b2ZmLWJ5OiBKYWNrIFd1IDxqYWNrYmJfd3VAY29tcGFsLmNvbT4NCj4tLS0NCj4gZHJpdmVycy9u
ZXQvd3dhbi9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICA1ICsrKysNCj4gZHJpdmVycy9u
ZXQvd3dhbi90OXh4L01ha2VmaWxlICAgICAgICAgICAgICB8ICA1ICsrLS0NCj4gZHJpdmVycy9u
ZXQvd3dhbi90OXh4L210a19jdHJsX3BsYW5lLmMgICAgICB8IDM0ICsrKysrKysrKysrKysrKysr
KysrKysNCj4gZHJpdmVycy9uZXQvd3dhbi90OXh4L210a19jdHJsX3BsYW5lLmggICAgICB8IDIy
ICsrKysrKysrKysrKysrKw0KPiBkcml2ZXJzL25ldC93d2FuL3Q5eHgvbXRrX2Rldi5jICAgICAg
ICAgICAgIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gZHJpdmVycy9uZXQv
d3dhbi90OXh4L210a19kZXYuaCAgICAgICAgICAgICB8ICA0ICsrKw0KPiBkcml2ZXJzL25ldC93
d2FuL3Q5eHgvcGNpZS9NYWtlZmlsZSAgICAgICAgIHwgMTAgKysrKysrKw0KPiBkcml2ZXJzL25l
dC93d2FuL3Q5eHgvcGNpZS9tdGtfcGNpLmMgICAgICAgIHwgIDggKystLS0tDQo+IGRyaXZlcnMv
bmV0L3d3YW4vdDl4eC9wY2llL210a190cmFuc19jdHJsLmggfCAyMSArKysrKysrKysrKysrKw0K
PiA5IGZpbGVzIGNoYW5nZWQsIDE0NiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0K
PmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2FuL0tjb25maWcgYi9kcml2ZXJzL25ldC93d2Fu
L0tjb25maWcNCj5pbmRleCA0Y2VlNTM3YzczOWYuLmQ4YmUxMmZiOTg4YyAxMDA2NDQNCj4tLS0g
YS9kcml2ZXJzL25ldC93d2FuL0tjb25maWcNCj4rKysgYi9kcml2ZXJzL25ldC93d2FuL0tjb25m
aWcNCj5AQCAtMTI0LDYgKzEyNCw3IEBAIGNvbmZpZyBNVEtfVDdYWA0KPiBjb25maWcgTVRLX1Q5
WFgNCj4gCXRyaXN0YXRlICJNZWRpYVRlayBQQ0llIDVHIFdXQU4gbW9kZW0gVDl4eCBkZXZpY2Ui
DQo+IAlkZXBlbmRzIG9uIFBDSQ0KPisJc2VsZWN0IE1US19UOVhYX1BDSQ0KPiAJc2VsZWN0IE5F
VF9ERVZMSU5LDQo+IAloZWxwDQo+IAkgIEVuYWJsZXMgTWVkaWFUZWsgUENJZSBiYXNlZCA1RyBX
V0FOIG1vZGVtIChUOXh4IHNlcmllcykgZGV2aWNlLg0KPkBAIC0xMzMsNiArMTM0LDEwIEBAIGNv
bmZpZyBNVEtfVDlYWA0KPiANCj4gCSAgSWYgdW5zdXJlLCBzYXkgTi4NCj4gDQo+K2NvbmZpZyBN
VEtfVDlYWF9QQ0kNCj4rCXRyaXN0YXRlDQo+KwlkZXBlbmRzIG9uIFBDSSAmJiBNVEtfVDlYWA0K
PisNCj4gZW5kaWYgIyBXV0FODQo+IA0KPiBlbmRtZW51DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3d3YW4vdDl4eC9NYWtlZmlsZSBiL2RyaXZlcnMvbmV0L3d3YW4vdDl4eC9NYWtlZmlsZQ0K
PmluZGV4IDZmMmRkM2Y5MTQ1NC4uYWU5ZDZmMjM0NGFiIDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMv
bmV0L3d3YW4vdDl4eC9NYWtlZmlsZQ0KPisrKyBiL2RyaXZlcnMvbmV0L3d3YW4vdDl4eC9NYWtl
ZmlsZQ0KPkBAIC00LDcgKzQsOCBAQCBjY2ZsYWdzLXkgKz0gLUkkKHNyYykvcGNpZQ0KPiBjY2Zs
YWdzLXkgKz0gLUkkKHNyYykNCj4gDQo+IG9iai0kKENPTkZJR19NVEtfVDlYWCkgKz0gbXRrX3Q5
eHgubw0KPitvYmotJChDT05GSUdfTVRLX1Q5WFhfUENJKSArPSBwY2llLw0KPiANCj4gbXRrX3Q5
eHgteSA6PSBcDQo+LQlwY2llL210a19wY2kubyBcDQo+LQlwY2llL210a19wY2lfZHJ2X205eHgu
bw0KPisJbXRrX2Rldi5vIFwNCj4rCW10a19jdHJsX3BsYW5lLm8NCj5kaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd3dhbi90OXh4L210a19jdHJsX3BsYW5lLmMgYi9kcml2ZXJzL25ldC93d2FuL3Q5
eHgvbXRrX2N0cmxfcGxhbmUuYw0KPm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+aW5kZXggMDAwMDAw
MDAwMDAwLi5hZTVlMTc5N2I4MTcNCj4tLS0gL2Rldi9udWxsDQo+KysrIGIvZHJpdmVycy9uZXQv
d3dhbi90OXh4L210a19jdHJsX3BsYW5lLmMNCj5AQCAtMCwwICsxLDM0IEBADQo+Ky8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4rLyoNCj4rICogQ29weXJpZ2h0IChj
KSAyMDIyLCBNZWRpYVRlayBJbmMuDQo+KyAqIENvcHlyaWdodCAoYykgMjAyMi0yMDIzLCBJbnRl
bCBDb3Jwb3JhdGlvbi4NCj4rICovDQo+Kw0KPisjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+
Kw0KPisjaW5jbHVkZSAibXRrX2N0cmxfcGxhbmUuaCINCj4rDQoNCnBsZWFzZSBhZGQga2RvYywg
ZXNwZWNpYWxseSB0aGVyZSdzIEVYUE9SVF9TWU1CT0wNCg0KPitpbnQgbXRrX2N0cmxfaW5pdChz
dHJ1Y3QgbXRrX21kX2RldiAqbWRldikNCj4rew0KPisJc3RydWN0IG10a19jdHJsX2JsayAqY3Ry
bF9ibGs7DQo+Kw0KPisJY3RybF9ibGsgPSBkZXZtX2t6YWxsb2MobWRldi0+ZGV2LCBzaXplb2Yo
KmN0cmxfYmxrKSwgR0ZQX0tFUk5FTCk7DQo+KwlpZiAoIWN0cmxfYmxrKQ0KPisJCXJldHVybiAt
RU5PTUVNOw0KPisNCj4rCWN0cmxfYmxrLT5tZGV2ID0gbWRldjsNCj4rCW1kZXYtPmN0cmxfYmxr
ID0gY3RybF9ibGs7DQo+Kw0KPisJcmV0dXJuIDA7DQo+K30NCj4rRVhQT1JUX1NZTUJPTChtdGtf
Y3RybF9pbml0KTsNCj4rDQo+K2ludCBtdGtfY3RybF9leGl0KHN0cnVjdCBtdGtfbWRfZGV2ICpt
ZGV2KQ0KDQpkbyB3ZSBuZWVkIGludCBpZiAwIGlzIGFsd2F5cyByZXR1cm5lZD8NCg0KPit7DQo+
KwlzdHJ1Y3QgbXRrX2N0cmxfYmxrICpjdHJsX2JsayA9IG1kZXYtPmN0cmxfYmxrOw0KPisNCj4r
CWRldm1fa2ZyZWUobWRldi0+ZGV2LCBjdHJsX2Jsayk7DQo+Kw0KPisJcmV0dXJuIDA7DQo+K30N
Cj4rRVhQT1JUX1NZTUJPTChtdGtfY3RybF9leGl0KTsNCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvd3dhbi90OXh4L210a19jdHJsX3BsYW5lLmggYi9kcml2ZXJzL25ldC93d2FuL3Q5eHgvbXRr
X2N0cmxfcGxhbmUuaA0KPm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+aW5kZXggMDAwMDAwMDAwMDAw
Li44Mjc2YmUxOWI0NTYNCj4tLS0gL2Rldi9udWxsDQo+KysrIGIvZHJpdmVycy9uZXQvd3dhbi90
OXh4L210a19jdHJsX3BsYW5lLmgNCj5AQCAtMCwwICsxLDIyIEBADQo+Ky8qIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4rICoNCj4rICogQ29weXJpZ2h0IChjKSAyMDIy
LCBNZWRpYVRlayBJbmMuDQoNCnNob3VsZG4ndCAyMDI2IGJlIHB1dD8NCg0KPisgKi8NCj4rDQo+
KyNpZm5kZWYgX19NVEtfQ1RSTF9QTEFORV9IX18NCj4rI2RlZmluZSBfX01US19DVFJMX1BMQU5F
X0hfXw0KPisNCj4rI2luY2x1ZGUgPGxpbnV4L2tyZWYuaD4NCj4rI2luY2x1ZGUgPGxpbnV4L3Nr
YnVmZi5oPg0KPisNCj4rI2luY2x1ZGUgIm10a19kZXYuaCINCj4rDQo+K3N0cnVjdCBtdGtfY3Ry
bF9ibGsgew0KPisJc3RydWN0IG10a19tZF9kZXYgKm1kZXY7DQo+KwlzdHJ1Y3QgbXRrX2N0cmxf
dHJhbnMgKnRyYW5zOw0KPit9Ow0KPisNCj4raW50IG10a19jdHJsX2luaXQoc3RydWN0IG10a19t
ZF9kZXYgKm1kZXYpOw0KPitpbnQgbXRrX2N0cmxfZXhpdChzdHJ1Y3QgbXRrX21kX2RldiAqbWRl
dik7DQo+Kw0KPisjZW5kaWYgLyogX19NVEtfQ1RSTF9QTEFORV9IX18gKi8NCj5kaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd3dhbi90OXh4L210a19kZXYuYyBiL2RyaXZlcnMvbmV0L3d3YW4vdDl4
eC9tdGtfZGV2LmMNCj5uZXcgZmlsZSBtb2RlIDEwMDY0NA0KPmluZGV4IDAwMDAwMDAwMDAwMC4u
ZjI1NGNhN2VkODc3DQo+LS0tIC9kZXYvbnVsbA0KPisrKyBiL2RyaXZlcnMvbmV0L3d3YW4vdDl4
eC9tdGtfZGV2LmMNCj5AQCAtMCwwICsxLDQ0IEBADQo+Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9ubHkNCj4rLyoNCj4rICogQ29weXJpZ2h0IChjKSAyMDIyLCBNZWRpYVRl
ayBJbmMuDQo+KyAqLw0KPisNCj4rI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPisNCj4rI2lu
Y2x1ZGUgIm10a19kZXYuaCINCj4rDQo+K3N0cnVjdCBtdGtfbWRfZGV2ICptdGtfZGV2X2FsbG9j
KHN0cnVjdCBkZXZpY2UgKnBkZXYsIGNvbnN0IHN0cnVjdCBtdGtfZGV2X29wcyAqZGV2X29wcykN
Cj4rew0KPisJc3RydWN0IG10a19tZF9kZXYgKm1kZXY7DQo+Kw0KPisJbWRldiA9IGRldm1fa3ph
bGxvYyhwZGV2LCBzaXplb2YoKm1kZXYpLCBHRlBfS0VSTkVMKTsNCj4rCWlmICghbWRldikNCj4r
CQlyZXR1cm4gTlVMTDsNCj4rDQo+KwltZGV2LT5kZXZfb3BzID0gZGV2X29wczsNCj4rCW1kZXYt
PmRldiA9IHBkZXY7DQo+KwlyZXR1cm4gbWRldjsNCj4rfQ0KPitFWFBPUlRfU1lNQk9MKG10a19k
ZXZfYWxsb2MpOw0KPisNCj4rdm9pZCBtdGtfZGV2X2ZyZWUoc3RydWN0IG10a19tZF9kZXYgKm1k
ZXYpDQo+K3sNCj4rCXN0cnVjdCBkZXZpY2UgKmRldiA9IG1kZXYtPmRldjsNCj4rDQo+KwlkZXZt
X2tmcmVlKGRldiwgbWRldik7DQo+K30NCj4rRVhQT1JUX1NZTUJPTChtdGtfZGV2X2ZyZWUpOw0K
PisNCj4rc3RhdGljIGludCBfX2luaXQgbXRrX2NvbW1vbl9kcnZfaW5pdCh2b2lkKQ0KPit7DQo+
KwlyZXR1cm4gMDsNCj4rfQ0KPittb2R1bGVfaW5pdChtdGtfY29tbW9uX2Rydl9pbml0KTsNCj4r
DQo+K3N0YXRpYyB2b2lkIF9fZXhpdCBtdGtfY29tbW9uX2Rydl9leGl0KHZvaWQpDQoNCmlzIGl0
IHVzZWQgYW55d2hlcmUgaGVyZSBpbiB0aGUgcGF0Y2g/DQoNCj4rew0KPit9DQo+K21vZHVsZV9l
eGl0KG10a19jb21tb25fZHJ2X2V4aXQpOw0KPisNCj4rTU9EVUxFX0RFU0NSSVBUSU9OKCJNZWRp
YVRlayBUOXh4IFBDSWUgV1dBTiBkcml2ZXIiKTsNCj4rTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0K
PmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2FuL3Q5eHgvbXRrX2Rldi5oIGIvZHJpdmVycy9u
ZXQvd3dhbi90OXh4L210a19kZXYuaA0KPmluZGV4IDgyNzhhMGUyODc1ZS4uMzdlZWMxYTM1OGZh
IDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvbmV0L3d3YW4vdDl4eC9tdGtfZGV2LmgNCj4rKysgYi9k
cml2ZXJzL25ldC93d2FuL3Q5eHgvbXRrX2Rldi5oDQo+QEAgLTU3LDYgKzU3LDcgQEAgc3RydWN0
IG10a19tZF9kZXYgew0KPiAJdm9pZCAqaHdfcHJpdjsNCj4gCXUzMiBod192ZXI7DQo+IAljaGFy
IGRldl9zdHJbTVRLX0RFVl9TVFJfTEVOXTsNCj4rCXZvaWQgKmN0cmxfYmxrOw0KPiB9Ow0KPiAN
Cj4gc3RhdGljIGlubGluZSB1MzIgbXRrX2Rldl9nZXRfZGV2X3N0YXRlKHN0cnVjdCBtdGtfbWRf
ZGV2ICptZGV2KQ0KPkBAIC0xMDUsNCArMTA2LDcgQEAgc3RhdGljIGlubGluZSBpbnQgbXRrX2Rl
dl9zZW5kX2Rldl9ldnQoc3RydWN0IG10a19tZF9kZXYgKm1kZXYsIHUzMiBkZXZfZXZ0KQ0KPiAJ
cmV0dXJuIG1kZXYtPmRldl9vcHMtPnNlbmRfZGV2X2V2dChtZGV2LCBkZXZfZXZ0KTsNCj4gfQ0K
PiANCj4rc3RydWN0IG10a19tZF9kZXYgKm10a19kZXZfYWxsb2Moc3RydWN0IGRldmljZSAqcGRl
diwgY29uc3Qgc3RydWN0IG10a19kZXZfb3BzICpkZXZfb3BzKTsNCj4rdm9pZCBtdGtfZGV2X2Zy
ZWUoc3RydWN0IG10a19tZF9kZXYgKm1kZXYpOw0KPisNCj4gI2VuZGlmIC8qIF9fTVRLX0RFVl9I
X18gKi8NCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd3dhbi90OXh4L3BjaWUvTWFrZWZpbGUg
Yi9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9NYWtlZmlsZQ0KPm5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+aW5kZXggMDAwMDAwMDAwMDAwLi43NDEwZDE3OTZkMjcNCj4tLS0gL2Rldi9udWxsDQo+
KysrIGIvZHJpdmVycy9uZXQvd3dhbi90OXh4L3BjaWUvTWFrZWZpbGUNCj5AQCAtMCwwICsxLDEw
IEBADQo+KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPisNCj4rY2Nm
bGFncy15ICs9IC1JJChzcmMpDQo+K2NjZmxhZ3MteSArPSAtSSQoc3JjKS8uLg0KPisNCj4rb2Jq
LSQoQ09ORklHX01US19UOVhYX1BDSSkgKz0gbXRrX3Q5eHhfcGNpZS5vDQo+Kw0KPittdGtfdDl4
eF9wY2llLXkgOj0gXA0KPisJbXRrX3BjaV9kcnZfbTl4eC5vIFwNCj4rCW10a19wY2kubw0KPmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfcGNpLmMgYi9kcml2ZXJz
L25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfcGNpLmMNCj5pbmRleCBhZGVjM2NjZGVlMDguLjUxOGMz
MmQ1NTY0MyAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfcGNp
LmMNCj4rKysgYi9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9tdGtfcGNpLmMNCj5AQCAtMTQs
NiArMTQsNyBAQA0KPiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+IA0KPiAjaW5jbHVkZSAi
bXRrX2Rldi5oIg0KPisjaW5jbHVkZSAibXRrX3RyYW5zX2N0cmwuaCINCj4gI2luY2x1ZGUgIm10
a19wY2kuaCINCj4gI2luY2x1ZGUgIm10a19wY2lfcmVnLmgiDQo+IA0KPkBAIC0zODUsOCArMzg2
LDcgQEAgc3RhdGljIHUzMiBtdGtfcGNpX2V4dF9oMmRfZXZ0X2h3X2JpdHModTMyIGNocykNCj4g
DQo+IAlTRVRfSFdfQklUUyhod19iaXRzLCBjaHMsIE1IQ0NJRl9SQzJFUF9FVlRfREVWSUNFX1JF
U0VULA0KPiAJCSAgICBERVZfRVZUX0gyRF9ERVZJQ0VfUkVTRVQpOw0KPi0JU0VUX0hXX0JJVFMo
aHdfYml0cywgY2hzLCBNSENDSUZfUkMyRVBfRVZUX0RSTV9ESVNBQkxFX0FQLA0KPi0JCSAgICBF
WFRfRVZUX0gyRF9EUk1fRElTQUJMRV9BUCk7DQo+Kw0KPiAJcmV0dXJuIExFMzJfVE9fVTMyKGNw
dV90b19sZTMyKGh3X2JpdHMpKTsNCj4gfQ0KPiANCj5AQCAtNzc5LDEzICs3NzksMTEgQEAgc3Rh
dGljIGludCBtdGtfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3Qg
cGNpX2RldmljZV9pZCAqaWQpDQo+IAlzdHJ1Y3QgbXRrX21kX2RldiAqbWRldjsNCj4gCWludCBy
ZXQ7DQo+IA0KPi0JbWRldiA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqbWRldiksIEdGUF9L
RVJORUwpOw0KPisJbWRldiA9IG10a19kZXZfYWxsb2MoZGV2LCAmcGNpX2h3X29wcyk7DQo+IAlp
ZiAoIW1kZXYpIHsNCj4gCQlyZXQgPSAtRU5PTUVNOw0KPiAJCWdvdG8gb3V0Ow0KPiAJfQ0KPi0J
bWRldi0+ZGV2X29wcyA9ICZwY2lfaHdfb3BzOw0KPi0JbWRldi0+ZGV2ID0gZGV2Ow0KPiANCj4g
CXByaXYgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKnByaXYpLCBHRlBfS0VSTkVMKTsNCj4g
CWlmICghcHJpdikgew0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93d2FuL3Q5eHgvcGNpZS9t
dGtfdHJhbnNfY3RybC5oIGIvZHJpdmVycy9uZXQvd3dhbi90OXh4L3BjaWUvbXRrX3RyYW5zX2N0
cmwuaA0KPm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+aW5kZXggMDAwMDAwMDAwMDAwLi5kNmRlNGM0
M2I1MjkNCj4tLS0gL2Rldi9udWxsDQo+KysrIGIvZHJpdmVycy9uZXQvd3dhbi90OXh4L3BjaWUv
bXRrX3RyYW5zX2N0cmwuaA0KPkBAIC0wLDAgKzEsMjEgQEANCj4rLyogU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPisgKg0KPisgKiBDb3B5cmlnaHQgKGMpIDIwMjIsIE1l
ZGlhVGVrIEluYy4NCj4rICovDQo+Kw0KPisjaWZuZGVmIF9fTVRLX1RSQU5TX0NUUkxfSF9fDQo+
KyNkZWZpbmUgX19NVEtfVFJBTlNfQ1RSTF9IX18NCj4rDQo+KyNpbmNsdWRlIDxsaW51eC9rcmVm
Lmg+DQo+KyNpbmNsdWRlIDxsaW51eC9saXN0Lmg+DQo+KyNpbmNsdWRlIDxsaW51eC9za2J1ZmYu
aD4NCj4rI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+Kw0KPisjaW5jbHVkZSAibXRrX2Rldi5o
Ig0KPisNCj4rc3RydWN0IG10a19jdHJsX3RyYW5zIHsNCj4rCXN0cnVjdCBtdGtfY3RybF9ibGsg
KmN0cmxfYmxrOw0KPisJc3RydWN0IG10a19tZF9kZXYgKm1kZXY7DQo+K307DQo+Kw0KPisjZW5k
aWYNCj4NCj4tLSANCj4yLjM0LjENCg0KDQoNCg==

