Return-Path: <netdev+bounces-244566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF41CB9DCC
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 22:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E8AC3135C83
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 21:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224E330CD84;
	Fri, 12 Dec 2025 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbwyMtFC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5E302159;
	Fri, 12 Dec 2025 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573697; cv=fail; b=LDsG4ozAAM540AJtWz03dI1lBtSZ2Sy8NorWBc7Z0f783RquCUlSbW4kuFsAuOLo3zxDYshx3lnJrhEfiCbHvcK67bJX4rIDITkN4uJivbq6dg33eEGSiYEcAEjsr1IFXojz28yeJX7KlJjSKhSeDmlucITj2FbIUZMV1pPaAHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573697; c=relaxed/simple;
	bh=fOmOeH5OVfUtKou1T7NWNLelTAFlMWFUkMJPjMYPTSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fhuooSF+JE5FhWiTKuprThzpq0wTseqsX9VlywXgHar+QF13EKx4DIyUN0GNVofCRd7SEqlfnIJptSs7BOrHSGGmBQPDjRxrRlbHeQFdVuMzJJYWgOeHLZeT21SMsIMO27RytdkdCgpnjZ6lZald3+DGnT6jopxgwROmr4WxY/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbwyMtFC; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765573695; x=1797109695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fOmOeH5OVfUtKou1T7NWNLelTAFlMWFUkMJPjMYPTSQ=;
  b=SbwyMtFCCKF/rcTMVsaJ3r5CsGowyWjjki2TSXLvLlXtWs67wORrrm71
   QLIWrs2BWAtv6Xug2BxNeNxcnd9SXgdCfvieB+7GLSaSLMv9r7u+MveaG
   +3fnDQYiqrfTJc8nzkznbHAaP4urtNy8pcAmn1VzPNQTOdA4J3U7HB9v/
   IzSeUJqxuBEl7eJZdM3Mih77r1rxEVW55qiQmpvSY9Zk77lznDpCAJM1X
   jw42v5NLNULPYhNlKW//XTYL+jVJTSGKWujfSSROhsnWiYo43XDzIVb2A
   OoKFDP4JFmOYyH8KSkJW0Pok55skbd/zL9jueGjZtFbpk7yJS6xxyeJ+h
   Q==;
X-CSE-ConnectionGUID: rUg+mgW1SeCbiPHFa9gZqg==
X-CSE-MsgGUID: ojk8Nlr9RK6ewc2tyz/ing==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="77897959"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="77897959"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:08:15 -0800
X-CSE-ConnectionGUID: dg5044TVR8+oAYSUo+BxOA==
X-CSE-MsgGUID: EYE+MdxAQDmwxGMDCf9FTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="201671643"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:08:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 13:08:14 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 13:08:14 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 13:08:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAOo1JhwIKXHtJjqNn8rYRoQPwl9gTaGesQjL39q38CANtq8DFTT1SLDd/Jan+ZrbdZUXYPwK/gCFlraH8S9ehxZUYKgK9a35Dw6gLmy3Q3BXZM2NB4RDmHtoJ45BNWSXr/jv3sna41Styia/C9c+7GycgI8PzFOzVKqe4P4m/SGLXnKvx/AZAXDx4h96nbwIvr7acNWawPQyULDHpNdsi40oQVCZEu1aMOtgsFSyA7geM+rYHx31nffSfWefjeGTdZrMcww4VmPEoxdFP5ZQ6zo0GoPg4p5Zoi7Gw2lei0YS6z/IsYY6MxgL/Zqj4CI+/v+u5WQE2wC42jCZnlHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOmOeH5OVfUtKou1T7NWNLelTAFlMWFUkMJPjMYPTSQ=;
 b=euDOrtKae5jS+QaNHrillno/Q/eCjA8/p/JoAF+FSn6b+UOtygT7BI9zFjnAEh2F1d3I0fw+p+ojvEnXtzH5HrsJe8z5w6eLlRc1epdl1sG7DcPUUbP3euQTNVPfgDCd79iEdCsQxONS8JoJiI9lYlDcb5qQXhkYYxfxVs/sVTW4nV9/NtKBtRsBQapQOdkRxWnqK9s7i9htD6UvAYjfeq/7V4VGx4tEjk/Hyv/mGGQ0+XgVgPIw6TBRcV2t3j8HXA6W1WOm1ekbR26z9hfAie470HKq6N7kJE2MqRQFQJXR3zWStrxD95/+f1wqLE2ihv9EvgXSu0Xl6pF39YfASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB6715.namprd11.prod.outlook.com (2603:10b6:303:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 21:08:11 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9388.013; Fri, 12 Dec 2025
 21:08:10 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Mina Almasry <almasrymina@google.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Rizzo,
 Luigi" <lrizzo@google.com>, "namangulati@google.com"
	<namangulati@google.com>, "willemb@google.com" <willemb@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Olech, Milena" <milena.olech@intel.com>, Shachar Raindel
	<shacharr@google.com>
Subject: RE: [Intel-wired-lan] [PATCH net v1] idpf: read lower clock bits
 inside the time sandwich
Thread-Topic: [Intel-wired-lan] [PATCH net v1] idpf: read lower clock bits
 inside the time sandwich
Thread-Index: AQHcaofClTtAOthzAUKjmruLMS4cvbUcPfEwgADByoCAAKUxAIAAxSOAgAAXi6A=
Date: Fri, 12 Dec 2025 21:08:10 +0000
Message-ID: <IA3PR11MB89862D9C81A1411B201CDBA3E5AEA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251211101931.2788437-1-almasrymina@google.com>
 <IA3PR11MB8986D6D6FEB5B8D443E6F087E5A1A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <25a83e83-46d1-4a16-9383-6d492cb37c7a@intel.com>
 <684b2ce6-c8f4-4ecf-9fbc-b75137689083@intel.com>
 <3be0dc11-8fea-4159-9f58-40594ef469f8@intel.com>
In-Reply-To: <3be0dc11-8fea-4159-9f58-40594ef469f8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB6715:EE_
x-ms-office365-filtering-correlation-id: 8d051199-2e1e-4959-2a37-08de39c28e69
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cVN5SVdKYlErWVFUS3B1czRmM0dGNVBHbnB1S01RMGs1SVRoM0YyNU9WSjN4?=
 =?utf-8?B?dDgyZWVwQ29TbjlobzErTk1JLytZbU5uOGR2SmgvOUNBZHkveTFIT0VtaUtn?=
 =?utf-8?B?ODFudWZXS0xmeiswTmpZYWlWckp4b25oSm9BRkFmZjIydy9yS0tMcDZWaVhT?=
 =?utf-8?B?L3RmbEtHUjN2anBwek1sWWQ2L0EwR3JDSi9FZFRTVTA0RXFMOUtGYlRuanF4?=
 =?utf-8?B?RDI1WFQrYUMyeGd6Z1B1dy9KMG96d01Fc3krdEpXR0JJL0xJalVOWXhaYndN?=
 =?utf-8?B?WUc5TENrbFFxaWNQYXlJUmZ5eWJjaExhOTNhSTZ2YTJwd1VSWjZuaGloSHFS?=
 =?utf-8?B?UXdaVnlzTnBwLytmQVdkUjBpTW9NZjZEc21nQTM5NFNjWi94ZllvVzVkTG9q?=
 =?utf-8?B?S01ESlRMcWxJR0MxWjB4cy94SkZZRm9RUlZBTU9rOUdlaWdURng0RVVZYUJy?=
 =?utf-8?B?OUx6UjE3YmtQK0ZaZ05jbDZTditLRTZNZVlNMEZlT3pDdUN5Qk1UekFqVEZE?=
 =?utf-8?B?Wm5vV2FFRGo2NzBJbWZRVTBEVzBKdURBbjBsQTZXVmVBYmtsWGhMdUY1ZmJG?=
 =?utf-8?B?WnJKNFJlOGJ6YWZ0VEFaWitEV0hPdFhZN2x0NisvT2pNOWpnTWlSMGN4OUFN?=
 =?utf-8?B?bXd0VkpwOVJKdTJWN2EzVnNocnJwSVhnZHZWVy9nUDdJK2IwZUU3bzRZcDlD?=
 =?utf-8?B?MDU5MVpIeFdhNm5PUVIzU3dCUUtKNnNJVmlMWFV6bjFYWXFJaFV2N3ZBSDlQ?=
 =?utf-8?B?NEFLc2VqTmhjM3RvcEs1NmorQk94Vlg5aCsyTGx0elZKNHZXeElkN0JJMVlk?=
 =?utf-8?B?MnNGZ29ONjhGcDJLWjBTbHNabVNRSTNqenp3VFhaUWFRN1JmcFBjVlBZWFBB?=
 =?utf-8?B?YkZrVEUzSGE2eVcxZkpScWpLZzJKeGNVR1hBTjFKMjdCbkRBc0I5czZoQzRB?=
 =?utf-8?B?QWJUWGloQ1ltTWlsRU1UbTBvdzI1N3BYU1RhN2FSYTBIWWdLSjR3UzhoY2lR?=
 =?utf-8?B?WEUzaUJYbXdxNy9qZy94YnFLWVF2TGFHSDlaaWREV1BzMEhzSFh2alNhd2VH?=
 =?utf-8?B?bGVPMkJQSWN0RzZBWjNPUWdZRXhMTG9pV1FTRmdYQ1F5VHBEOFcxZjU3L3Vo?=
 =?utf-8?B?U3hNLzVWRlhjTld2a2ZDSU9ZUkxaVTFqdzE0WnZVaW4xY1B2cktyaHNmVkZE?=
 =?utf-8?B?dkpHNHpENGR3K2tIY0hEYkE5Q1ZueXcrVlZYVDhPeURUMTZ3WEczWmw0MlRH?=
 =?utf-8?B?amczbTFqVHVwZGFSZm5lc3lJQStDSVM4Ym1NbVpqTTdET0MrVHBUaDY3aXlT?=
 =?utf-8?B?MFQ1NlM1VU1rY1dxU3V0eExvNXRzbWVsS1NKSkIwUm5XSElJSXlyb2IyeHFi?=
 =?utf-8?B?Z0F1WnJ3bm9WVVhSU013WEFsTlBQb21WWTZRbG9kOUZQSHZyOGZGUVNWOWhv?=
 =?utf-8?B?WXpIUnhlTERVeTFrbURtOHMrbXlVQkZ2YllsVmNZT2g4QlJ1M0ZYMFEyUFRM?=
 =?utf-8?B?RkpjajJkRy9tUk8zMHFBNjI4RHp3d05pWFYyay9zQnBSV0xzVk5iaTJ0cDdM?=
 =?utf-8?B?K2lEUUY1QVNLTTFhekw2enA4U2kxck1pNWZOcHZmb1hLSUp2VUFwci83ZzFx?=
 =?utf-8?B?TlQxbjVoV0IxVWowdzh3ampZSFZlT2dTWVlmaHMzTFBYeHp5eTZSTEZZeGZm?=
 =?utf-8?B?WUYrc0h1b1JOam04UUN6d3JhUzJnZ2pXNVZHV1oramhyeno1Z0h5d3Y3T3JM?=
 =?utf-8?B?c0kyMnYva1U3NFhubHhSVU9zcEZRanVueWJwWkJmM2RxQzErTjhxckhEbzZN?=
 =?utf-8?B?SDFFMlhJQjBZN3pIZXZYNjNBd200VDlhQjVIMi8vWHZpUEhaL3ZPYjBFZUJt?=
 =?utf-8?B?YVRVM3R6Zm9YdE9EV0IvR0hsNjFXQ28zVDc4MlhkVmpLbEV6dXJONjRTSU15?=
 =?utf-8?B?R3hGalRVS3plaFRMVXc5S0xuc2g2ZXZvWXg0Q2VUUTlSYWkrVHdSMWJjUEN0?=
 =?utf-8?B?cEhMdWR5ZGdnVUNPTi82N2htMnhaNTF4dng3aFhHNlJNd0w5Z1ppWUNtNnZE?=
 =?utf-8?Q?Co3E76?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGx1SEQ5dTBVaGZMcGRqYkJvT3Z0bVJQV0VydmtMaGM5NG96QkNhUk9CQTc0?=
 =?utf-8?B?UVk4WWdpWi9QNTNGVFdRYkFUbnY1OUNsZHBrd1ZvTE51RGU1L0VuNnlaYlhG?=
 =?utf-8?B?Mk0yU1Z5bm15elVNRVRIM0N4Z0VXWXJEZFRZQ0NzQmpDUm1vLzUzdjlJSVlv?=
 =?utf-8?B?d3gyQVBSWGFyODkzT09oTzlLdFJoc21QNzRKbHRuQU83SlIyVmRXcVI2Q2VS?=
 =?utf-8?B?VW5pZDVISzlYMEhHRUMySW5IRnpNR3JsdFovUVNIWHpvMWQzREFGNGlRSnNz?=
 =?utf-8?B?SWgrZis5T1ZtVllNNGdYVHZIemxXdnJGdFQxSTlWQWF0TUIyVzdGN2xXRTdK?=
 =?utf-8?B?ZnFhamdyNzc2cHdhMStqZzRIalI1bTl3aEdZVU9lTENUUjBEOGdpMkc3M2pN?=
 =?utf-8?B?L0Iva3NVdm5hN0NIUWM4M0puWnZaV1IxYlRaK0Y2VE10TFpCeThPYmJkQnp2?=
 =?utf-8?B?dzdWSTVmL25zTHJsYVlXVzBZNHJRcERZNGZQbFhsQ2dvOTBCVXpReWFtaHQw?=
 =?utf-8?B?c3RDOXNGVUhWNEZQMlBqbUZXWmVLbTNDWjJCSXFCQXovTUdkMTVtTWovY21I?=
 =?utf-8?B?QjBCU2tCQXZ6LzljMjBwZ1lWcU11SnNxeXZJeUpNWnRHemNYWWJMWnpIM1ps?=
 =?utf-8?B?KzUvS3ljWWZDeU9jaVhuSVMwWEt5NkVOWm1WZTJLZGtSazIybDc1a3Qrd2R5?=
 =?utf-8?B?c1FuRFIxa20xNCtyT3cyeFoxdU0yNlhTclpHc1k1SU45S3hZbXQwUDVTQ1Ri?=
 =?utf-8?B?T2hFa1UrZGtSYmxTNXkwdnk5clBQVTd3UlpmU3B6di9KbzBhYU5TQVF6WjZo?=
 =?utf-8?B?N3k0QVk5aWJnQmlDUXhsM1BvQ2tQRjZwdU84WDV6ekRMeHAyVS9rOHdPYjNn?=
 =?utf-8?B?a3NvRjdDelVuY2JMSGtwUGN4Vzc5SHF3SWxMQmdqRVVRT0tWcXVOR3orNW9U?=
 =?utf-8?B?b1V5SjBLbjg2bTdJd3lZdGdSbVI3YzF0SUd4Zi9kNmFSQzhQeS9CWWowd0xm?=
 =?utf-8?B?VU5lcC9xeHdZbjZ6QXRRN1RFQUlvMTRDckNWdEM2c0xSYUdsSWRzb2VFV3BS?=
 =?utf-8?B?M1dxTHNnUENiakNML25QVEVKZ2FPbDZVRi9hNTJnaEx1TmhpOThqcU9HUlpU?=
 =?utf-8?B?ZmxXSHdKWXcydU1RKzVqNXNJR2lncTBuMlR6ZnJGOGRTamRWdnNjSElFYTRT?=
 =?utf-8?B?bkpTWGdlMHBZMGJWOGkzc0xHRUZGbnNuUWhKYUVIVlcwRGdPeHVSbllhWG1J?=
 =?utf-8?B?dzkrcWtMYmNNTTR6bWx2SWRacEh2czRlSk80Qmg5ajFCZlJ3TEp1a1VkNktE?=
 =?utf-8?B?ZkIwbCtJT0ZWMlZkTFhxalFTQ09JQ3oySjdZVWFwS2k4RmR4OHpPWU4vOGpP?=
 =?utf-8?B?dmNxWTBiMnU0MGVMSVNpazV3ZnFpRXp5U1lKclB2dGtpVHdqVlZ6NnZEQkQ2?=
 =?utf-8?B?Y092U0NnU2d3cG9EYnZxbDRkNTNTUTExMWtQaDByL1oxRE40YlN3bTJQQ1B5?=
 =?utf-8?B?SFAzdm1XQ1ZQQlZHQnIyR3BDQjh1YmRIS1kwKzBoUXF0b2syK0lNUkdONFJ1?=
 =?utf-8?B?Z2x5Z3lkdVpEUGJJQjdKaUpFbXVpbFY3eUdLN1BsWnAzdzg5OTVwWElrTTJ1?=
 =?utf-8?B?aXhOYVNVYzlCRlBRa1U1Q1hPaW5aaVVQWm5rTGdTQXc1aGUrRE5Vb0NBYnY0?=
 =?utf-8?B?UENOZHNTYllTRk5EVytuYnc1a1o5L0RwZ2owcGJmL2NRUXNyUVh3NWRVNG5l?=
 =?utf-8?B?L0o2N1BpKytLQUlqa2NxK0RXaDF4cFVXSGNTaXRYMnlyajROZUQ5MWVhK0Ri?=
 =?utf-8?B?VnkxLzFTV2ZNcWk0cDVxZ3VQTEwwOTZoaFlhTjBXM0o0Mk40THFjMmVBNkpX?=
 =?utf-8?B?Z1YrQmNsRmNDeDNraXlqaHRxZE9XZlcrTXJvcjE1L0FONGhhZEtoLzdpVmp5?=
 =?utf-8?B?ajdKVkZkR3Z1NStLdVFQNXdOcW44aCtQVWhtb2tZRWx0dm9mamliMDg4Y1pC?=
 =?utf-8?B?MGdLNUQ2cGZ0bW1nTG9GUnNWdEFNenRTUm9YNnNNd2E2Y3hXOGZOcDdmeVZH?=
 =?utf-8?B?a0lJSHdPckx5N0xTZWd0dnRkaUhVZEtQaVRiblNWbC84Qm1kMTE2MXprZkNs?=
 =?utf-8?B?UjdUTVVtSlNyclBYbzJHekdMYkZncGhlcG9Za3p2RkRuSE12am5qdWEya0hs?=
 =?utf-8?B?VkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d051199-2e1e-4959-2a37-08de39c28e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 21:08:10.8399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xtQmVzR8yuA25vE48bBRDulSnGo7UwCtrbfEUPA4f0NfrauJHea9Dh+vW3PQSD/nOB1jhgv886pMZrxiiFNEo792qq/FNmIebCJoAh/YwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6715
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2VsbGVyLCBKYWNvYiBF
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTIs
IDIwMjUgODo0MyBQTQ0KPiBUbzogS2l0c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xhdy5raXRz
emVsQGludGVsLmNvbT47IExva3Rpb25vdiwNCj4gQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlv
bm92QGludGVsLmNvbT47IE1pbmEgQWxtYXNyeQ0KPiA8YWxtYXNyeW1pbmFAZ29vZ2xlLmNvbT4N
Cj4gQ2M6IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEFu
ZHJldyBMdW5uDQo+IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBFcmljIER1bWF6
ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJl
bmlAcmVkaGF0LmNvbT47IFJpY2hhcmQgQ29jaHJhbiA8cmljaGFyZGNvY2hyYW5AZ21haWwuY29t
PjsNCj4gUml6em8sIEx1aWdpIDxscml6em9AZ29vZ2xlLmNvbT47IG5hbWFuZ3VsYXRpQGdvb2ds
ZS5jb207DQo+IHdpbGxlbWJAZ29vZ2xlLmNvbTsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9z
bC5vcmc7IE9sZWNoLCBNaWxlbmENCj4gPG1pbGVuYS5vbGVjaEBpbnRlbC5jb20+OyBTaGFjaGFy
IFJhaW5kZWwgPHNoYWNoYXJyQGdvb2dsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwtd2ly
ZWQtbGFuXSBbUEFUQ0ggbmV0IHYxXSBpZHBmOiByZWFkIGxvd2VyIGNsb2NrDQo+IGJpdHMgaW5z
aWRlIHRoZSB0aW1lIHNhbmR3aWNoDQo+IA0KPiANCj4gDQo+IE9uIDEyLzExLzIwMjUgMTE6NTcg
UE0sIFByemVtZWsgS2l0c3plbCB3cm90ZToNCj4gPiBPbiAxMi8xMS8yNSAyMzowNiwgSmFjb2Ig
S2VsbGVyIHdyb3RlOg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAxMi8xMS8yMDI1IDI6MzcgQU0sIExv
a3Rpb25vdiwgQWxla3NhbmRyIHdyb3RlOg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGludGVsLXdp
cmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uDQo+ID4+Pj4gQmVoYWxmIE9mIE1pbmEgQWxt
YXNyeQ0KPiA+Pj4+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAxMSwgMjAyNSAxMToxOSBBTQ0K
PiA+Pj4+IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+ID4+Pj4gQ2M6IE1pbmEgQWxtYXNyeSA8YWxtYXNyeW1pbmFAZ29vZ2xlLmNvbT47
IE5ndXllbiwgQW50aG9ueSBMDQo+ID4+Pj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsg
S2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA+Pj4+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29t
PjsgQW5kcmV3IEx1bm4NCj4gPj4+PiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUy4g
TWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsNCj4gPj4+PiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraQ0KPiA+Pj4+IDxrdWJhQGtlcm5lbC5vcmc+
OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBSaWNoYXJkDQo+IENvY2hyYW4NCj4g
Pj4+PiA8cmljaGFyZGNvY2hyYW5AZ21haWwuY29tPjsgUml6em8sIEx1aWdpIDxscml6em9AZ29v
Z2xlLmNvbT47DQo+ID4+Pj4gbmFtYW5ndWxhdGlAZ29vZ2xlLmNvbTsgd2lsbGVtYkBnb29nbGUu
Y29tOw0KPiA+Pj4+IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBPbGVjaCwgTWls
ZW5hDQo+ID4+Pj4gPG1pbGVuYS5vbGVjaEBpbnRlbC5jb20+OyBLZWxsZXIsIEphY29iIEUNCj4g
Pj4+PiA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgU2hhY2hhciBSYWluZGVsIDxzaGFjaGFy
ckBnb29nbGUuY29tPg0KPiA+Pj4+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBu
ZXQgdjFdIGlkcGY6IHJlYWQgbG93ZXIgY2xvY2sNCj4gPj4+PiBiaXRzIGluc2lkZSB0aGUgdGlt
ZSBzYW5kd2ljaA0KPiA+Pj4+DQo+ID4+Pj4gUENJZSByZWFkcyBuZWVkIHRvIGJlIGRvbmUgaW5z
aWRlIHRoZSB0aW1lIHNhbmR3aWNoIGJlY2F1c2UgUENJZQ0KPiA+Pj4+IHdyaXRlcyBtYXkgZ2V0
IGJ1ZmZlcmVkIGluIHRoZSBQQ0llIGZhYnJpYyBhbmQgcG9zdGVkIHRvIHRoZQ0KPiBkZXZpY2UN
Cj4gPj4+PiBhZnRlciB0aGUgX3Bvc3R0cyBjb21wbGV0ZXMuIERvaW5nIHRoZSBQQ0llIHJlYWQg
aW5zaWRlIHRoZSB0aW1lDQo+ID4+Pj4gc2FuZHdpY2ggZ3VhcmFudGVlcyB0aGF0IHRoZSB3cml0
ZSBnZXRzIGZsdXNoZWQgYmVmb3JlIHRoZQ0KPiBfcG9zdHRzDQo+ID4+Pj4gdGltZXN0YW1wIGlz
IHRha2VuLg0KPiA+Pj4+DQo+ID4+Pj4gQ2M6IGxyaXp6b0Bnb29nbGUuY29tDQo+ID4+Pj4gQ2M6
IG5hbWFuZ3VsYXRpQGdvb2dsZS5jb20NCj4gPj4+PiBDYzogd2lsbGVtYkBnb29nbGUuY29tDQo+
ID4+Pj4gQ2M6IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+ID4+Pj4gQ2M6IG1p
bGVuYS5vbGVjaEBpbnRlbC5jb20NCj4gPj4+PiBDYzogamFjb2IuZS5rZWxsZXJAaW50ZWwuY29t
DQo+ID4+Pj4NCj4gPj4+PiBGaXhlczogNWNiODgwNWQyMzY2ICgiaWRwZjogbmVnb3RpYXRlIFBU
UCBjYXBhYmlsaXRpZXMgYW5kIGdldA0KPiBQVFANCj4gPj4+PiBjbG9jayIpDQo+ID4+Pj4gU3Vn
Z2VzdGVkLWJ5OiBTaGFjaGFyIFJhaW5kZWwgPHNoYWNoYXJyQGdvb2dsZS5jb20+DQo+ID4+Pj4g
U2lnbmVkLW9mZi1ieTogTWluYSBBbG1hc3J5IDxhbG1hc3J5bWluYUBnb29nbGUuY29tPg0KPiA+
Pj4+IC0tLQ0KPiA+Pj4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3B0
cC5jIHwgMiArLQ0KPiA+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWRwZi9pZHBmX3B0cC5jDQo+ID4+Pj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pZHBmL2lkcGZfcHRwLmMNCj4gPj4+PiBpbmRleCAzZTEwNTJkMDcwY2YuLjBhOGI1MDM1
MGI4NiAxMDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBm
L2lkcGZfcHRwLmMNCj4gPj4+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBm
L2lkcGZfcHRwLmMNCj4gPj4+PiBAQCAtMTA4LDExICsxMDgsMTEgQEAgc3RhdGljIHU2NA0KPiA+
Pj4+IGlkcGZfcHRwX3JlYWRfc3JjX2Nsa19yZWdfZGlyZWN0KHN0cnVjdCBpZHBmX2FkYXB0ZXIg
KmFkYXB0ZXIsDQo+ID4+Pj4gICAJcHRwX3JlYWRfc3lzdGVtX3ByZXRzKHN0cyk7DQo+ID4+Pj4N
Cj4gPj4+PiAgIAlpZHBmX3B0cF9lbmFibGVfc2h0aW1lKGFkYXB0ZXIpOw0KPiA+Pj4+ICsJbG8g
PSByZWFkbChwdHAtPmRldl9jbGtfcmVncy5kZXZfY2xrX25zX2wpOw0KPiA+Pj4gVGhlIGhpZ2gg
MzIgYml0cyAoaGkpIGFyZSBzdGlsbCByZWFkIG91dHNpZGUgdGhlIHRpbWUgc2FuZHdpY2gNCj4g
Pj4+IChhZnRlciBwdHBfcmVhZF9zeXN0ZW1fcG9zdHRzKCkpLCB3aGljaCBkZWZlYXRzIHRoZSBz
dGF0ZWQgcHVycG9zZQ0KPiBvZiBlbnN1cmluZyBQQ0llIHdyaXRlIGZsdXNoIGJlZm9yZSB0aW1l
c3RhbXAgY2FwdHVyZS4NCj4gPj4+IC8qIEkgdGhpbmsgaGUgInRpbWUgc2FuZHdpY2giIGlzIGRl
ZmluZWQgYnkgdGhlIHJlZ2lvbiBiZXR3ZWVuDQo+IHB0cF9yZWFkX3N5c3RlbV9wcmV0cyhzdHMp
IGFuZCBwdHBfcmVhZF9zeXN0ZW1fcG9zdHRzKHN0cykgICovIElzbid0DQo+IGl0Pw0KPiA+Pj4N
Cj4gPj4+DQo+ID4+DQo+ID4+IEFueSByZWFkIHdpbGwgY2F1c2Ugd3JpdGVzIHRvIGZsdXNoLCBz
byB3ZSBkb24ndCBuZWVkIHRvIG1vdmUgYm90aA0KPiA+PiByZWdpc3RlcnMuDQo+ID4+DQo+ID4+
IFRoZSBwb2ludCBoZXJlIGlzIHRoYXQgd2Ugd3JpdGUgdG8gdGhlIHNoYWRvdyByZWdpc3RlciB0
byBzbmFwc2hvdA0KPiA+PiB0aW1lLCBhbmQgaXQgd29uJ3QgZ3VhcmFudGVlIHRvIGJlIGZsdXNo
ZWQgdG8gdGhlIGRldmljZSB1bnRpbCBhDQo+ID4+IHJlYWQuIEJ5IG1vdmluZyBhIHNpbmdsZSBy
ZWFkIGluIHNpZGUgdGhlIHRpbWUgc2FuZHdoaWNoLCB3ZSBlbnN1cmUNCj4gPj4gdGhhdCBpdHMg
YWN0dWFsbHkgY29tcGxldGUgYmVmb3JlIHRoZSB0aW1lIHNuYXBzaG90IGlzIHRha2VuLiBXZQ0K
PiA+PiBkb24ndCBuZWVkIHRvIHdhaXQgZm9yIGJvdGggcmVnaXN0ZXJzIGJlY2F1c2Ugb2YgdGhl
IHNuYXBzaG90DQo+IGJlaGF2aW9yLg0KPiA+DQo+ID4gdmVyeSBuaWNlIGV4cGxhbmF0aW9uIEph
a2UsIHRoYW5rIHlvdQ0KPiA+DQo+ID4gSSBkb24ndCBrbm93IGlmIGl0IHNob3VsZCBiZSBjb25z
aWRlcmVkICJiYXNpYyBjb21tb24ga25vd2xlZGdlIiwgb3INCj4gPiB3YXJyYW50cyBhbiBlbnRy
eSBpbiBjb21taXQgbWVzc2FnZS9jb2RlIGNvbW1lbnQgRm9yIHN1cmUgd2UgZG9uJ3QNCj4gPiB3
YW50IGFueW9uZSBub3Qga25vd2luZyB0aGF0IHRvIHRvdWNoIHRoZSBjb2RlLCBzbyBiYXJyaWVy
IHRvIGVudHJ5DQo+IGlzDQo+ID4gYWxzbyBhIGdvb2QgdGhpbmcgOykNCj4gPg0KPiA+Pg0KPiA+
PiBJIHRoaW5rIHRoZSBwYXRjaCBpcyBmaW5lLWFzLWlzLg0KPiA+DQo+ID4gZ2l2ZW4gdGhlIHNj
b3BlIG9mIHRoZSBmdW5jdGlvbiwgYWdyZWUNCj4gPg0KPiBSZWFkaW5nIGJvdGggcmVnaXN0ZXJz
IHdvdWxkIHRha2UgbG9uZ2VyLCBhbmQgd291bGQgZGVsYXkgcG9zdA0KPiB0aW1lc3RhbXAsIHdo
aWNoIHdvdWxkIGxvd2VyIHRoZSBhY2N1cmFjeSBvZiB0aGUgY2xvY2sgY29tcGFyaXNvbg0KPiBt
ZWNoYW5pc21zIHRoYXQgdXNlIHRoZSBwcmUrcG9zdCB0aW1lc3RhbXBzLiBXZSAqbXVzdCogcmVh
ZCBvbmUgb2YgdGhlDQo+IHZhbHVlcyBiZWNhdXNlIHdlIG5lZWQgdG8gZW5zdXJlIHRoZSBQSEMg
dGltZXN0YW1wIGlzIHNuYXBzaG90IGJldHdlZW4NCj4gcHJlK3Bvc3QsIGJ1dCB3ZSBzaG91bGQg
ZG8gYXMgbGl0dGxlIHdvcmsgYXMgbmVjZXNzYXJ5LCBzbyBvbmx5DQo+IHJlYWRpbmcNCj4gdGhl
IGxvdyByZWdpc3RlciBpcyB0aGUgbW9zdCBvcHRpbWFsLg0KPiANCj4gVGhpcyBjb3VsZCBiZSBw
dXQgaW50byB0aGUgY29tbWl0IG1lc3NhZ2UsIGJ1dCBhdCBsZWFzdCB0byBtZSBhcyBhDQo+IGRv
bWFpbiBleHBlcnQgdGhlIG9yaWdpbmFsIGNvbW1pdCBtZXNzYWdlIHdhcyBzdWZmaWNpZW50LCBz
byBJJ20gbm90DQo+IHN1cmUgdGhhdCBJJ20gYSBnb29kIGp1ZGdlIGZvciB3aGF0IGlzIG5lY2Vz
c2FyeSBmb3Igb3RoZXJzIHRvDQo+IHVuZGVyc3RhbmQgdGhlIGxvZ2ljLg0KDQpUaGFuayB5b3Ug
Zm9yIHRoZSBjbGFyaWZpY2F0aW9uIQ0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3Yg
PGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KDQoNCg0KDQo=

