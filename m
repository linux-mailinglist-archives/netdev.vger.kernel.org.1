Return-Path: <netdev+bounces-287719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLBUCI7RBGr0PQIAu9opvQ
	(envelope-from <netdev+bounces-287719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 21:31:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D371539F7E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 21:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D766D3001180
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD73B19A8;
	Wed, 13 May 2026 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dc6TdnIS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1A3B0AFB
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699942; cv=fail; b=lHPK098JO08GKO8jB5ylKBNLaDXbE26puoBYdV/G7qRBQEntKHna3FuAyhuV1mElOEkDf+KN/e/I1IS0Hppk7MDuGKktc5NJfJnPUoFg8BYjF+5wjn1gOjJtvB4K/9Pj/Yxis2i/prVSL5/IOmPs2t5dHmNmZvm4BiOBGEQ0dnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699942; c=relaxed/simple;
	bh=pg4PnATTdqxs65Wo0T3cupR72rsDw8SWGbkivTSJaVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C6EDDfSe9qe/wNxt+GKuSAWCpz/vwyQAXEvXUAF1zvmw2arfUDGsTL61O7naIogPbL4rW1X3AYR3dpHy7d5M6uzWfKnO8k+mveU2xCYW4ZqNZantExYWQ+QHkJIx+ZkTOapX6p015PIVjcryK1m/IYLwaB2hmldl7JLLYZufCSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dc6TdnIS; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778699942; x=1810235942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pg4PnATTdqxs65Wo0T3cupR72rsDw8SWGbkivTSJaVk=;
  b=dc6TdnISvs4J2XbeGeQd3GKja5hQt7i0V+SjyjhHM3BwupO08lo/rjwm
   SLUw84FUw2sR512YA9MSFXNu4iDlwq9FA0SI7AZPX9oDl9+5k/Y7ylL+G
   uZ5SOawYsW5WuWFU42RQNcAcjpzEwY5zfhzzrYbO6MUl5Z03j4M+u0UP9
   AavQChFC4NV0tMdSUt8d9lycbQHAozB3XJMmg/DZSAwjeoYK0lXRooZ6i
   vfdVFsBwmU8VWyJOyrcW10C9XBwbJyn9DQQmD6hkemm5hTL/vrOhpm98v
   FnnKyCJSWsQm69TJwj5Q4O23rrGO5Igdnj5vWTojcUDr18Pgdrsd5Ptew
   w==;
X-CSE-ConnectionGUID: KWoq4DDPSjqsb4dEt3ra9g==
X-CSE-MsgGUID: 8f0Y5GoqSmGVBKnoBRUgqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79589967"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79589967"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 12:19:01 -0700
X-CSE-ConnectionGUID: nnWAxKktRM2jWTJcjNBgtw==
X-CSE-MsgGUID: HOF+YQG6QBy9uq28wU/Jvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="235107338"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 12:19:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 12:19:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 12:19:00 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 12:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyUy5dOwe4DMrxE0Wl9fXvChlNXWcWU4QKhoNX/8q6Vs5JUZo9S0LE9j4tlTuvVYcE6MzJYL5RDG7L76TFWwOrTdf6qQcFStPX99TZdzsySjMzK+84bDjR7eMK9H4J4M9+edZ7hPjCmY4FW+JVSDAjU7dBKb05VN9zGwAOYhnBcZ9NGa3Wr4qvZEBLPMboyEnnLRG+70fKk00RHehgTjuXWkkg31uMMc0E2GJA3plFtlnQ1GBzacywiEFY42DnLYBUN0c6dNZDgaAToxhB6PxSjMs3oG85HaY8SEKlS7H6qAs4lW5s+3hEacha4sr5+pSLbtIoOWmKrgO9drMeboXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGrS43HHZIYJJh+QJPvhYqKWXCP+xPSK43++C8cAMMk=;
 b=gEWxFqha00CpI0wW+4a3efeEKux2A2NlsltYze7VokoHtCR/2xPDoV4lpTZ04ezXkoBCTgmvCnC5iSIVwDrXuJsUY1Adr9ADW6gklR1Wq2RmPVRIjwNN9kPQN6vpEnGONOn0bPrMtJm8jS6j3aEzV5aXI/F61bs9crhAcv4FwF4z7iZhTov/sdm2KtbQ4Jr2Qdr8aTLYauTpDkRiFk2iZcCl8CIMbLFTtndyioP/pdKtvoYlhwYu0lwfR80HdQn4cN+HFCJzwoGHcUwiu4r9SxZLEH5qK6Kiv1Y+6s4PdpbEmhq+OYf+qEy4kom38twEiLcUDidlwHKsWpk1d+trnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SJ2PR11MB8348.namprd11.prod.outlook.com (2603:10b6:a03:53a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 19:18:55 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 19:18:54 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, Simon Horman <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] ice: fix ice_init_link() error
 return preventing probe
Thread-Topic: [Intel-wired-lan] [PATCH net v2] ice: fix ice_init_link() error
 return preventing probe
Thread-Index: AQHcx2GdYs0VjLEBcU6PxqqGzpXYcrYMi5hA
Date: Wed, 13 May 2026 19:18:54 +0000
Message-ID: <LV1PR11MB87904A9C0B45CD89EA45D8A590062@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260408141105.2781683-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260408141105.2781683-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SJ2PR11MB8348:EE_
x-ms-office365-filtering-correlation-id: 761fa111-788e-4bd5-23dd-08deb124797e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003|11063799003;
x-microsoft-antispam-message-info: D2SZMK/7KV0boWb7PKGTSn4MTvGWXhBsDCPazoiHVL2F4PDk2OtPaHFPzcLOVdizm3N6suYQ3rE1F+vmj7oKfddASvf9VDQe8p+N0XGzGGzuvnvqc/gL1lpojbLwb77hw4mwRP7AeRc6PL16FlpBeMpzn96bPilpCUI4u48jkmbEteFYexJINrE7+tay8ahil7hqOeFzYqEJGqWNoiIckSi2XMYlQoNoXQveRJVHgfhhATzdgYadCpfcFe4BKVjyeRUaErYaQ5fmLNjXviUotlURD4YLNEtmVHKuYCPJsfbGBOqtJfm4ew8RljH3WSTO7zedRDKd4AqldACD6vSq3Ljy2sudIKtP92sdaHxxLy+WXgQ2OMlt3pyX1zM/efL5+Fj3MgOPhrtVrSK1nXoR4Ee4i3YgtwyYCsWHX5xH+/6gsm/UzCB0ek0Q95WBDzw+hpShUB4NmuOJ3A+Pvx7EZH5XGgwM1mDkOt/L9HDMUZIcD+O8LgkSQX88XcT2AEV21umpiwkZLlEnB0KSsh844WkvcYxTPMJ5jvgnAMjtJFQi2dHXjA2kYFTEQzXx5KlXrbwgcTqiEANwPp26Sj2Y5R4Gpxsvw2HC1KKlfawSRJVln6yGQdFJspXbVc+bRxD2VhYg66J9RAml51XX76AebrixJIhzIaS+L/MdskLndOE2stq3YaR54kSznkmfldxgSZbG8Vf6H/jROk+L2HMIKTZPt1w5qkCH5kDaWekF6S+dMhNhTV5poD8MoE8crYpa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y1RmnoHnVTG8J2wMQ22JdAleJyjqkjQliABLhYzeUmJXj/V0WK7/DI/DauG9?=
 =?us-ascii?Q?E/wshebYZE2ZnqOlGEhwihSdcU1b1YO+ZoskwQFJ805EVLtWC1W3LjfO75PC?=
 =?us-ascii?Q?aWVzpFRTD9Dm7s8P4AymXQ4juTFG2kpPnQSILMHxJFxya46UE6psj1UYQ5wZ?=
 =?us-ascii?Q?Z3tyB3Z2cFfvxuJtFynYyase5+s099dvQkZmeIySfTO57oe5RqwNvornSAh7?=
 =?us-ascii?Q?nwuTXUHiP+YDwNGdlOkh1x21gwKuh2I/5byviaq7zZMGVvhj0hnr1Bc5eo+k?=
 =?us-ascii?Q?7GB45E5t1ONM/NJN5AI1vlwSZsD1hnjoz7WeQgD7TIIX2DszIjRF/vYrvupe?=
 =?us-ascii?Q?Edxpwo8ZCM4nJkSAdwB5oSXXnqMXHlne6fZOLPcfRsdlRsnLAgKYo0ZsMiYD?=
 =?us-ascii?Q?nhpPRMkpdr80MldHCeRUO1oLfmwELkU93YmMsOtuFa8avqRsrkZHzQ0BAQ0p?=
 =?us-ascii?Q?gZaqKGw9LatrDxbIo2PxIg+D0RDLOsVBaj80cJGPYcJQ/dW2w58w+GnDUCaH?=
 =?us-ascii?Q?KWvwJqLzVhn8OdBCjeo2oDHp34ledin388ZVLIT1mD6Ug3t4W/Sy7bk9zHhu?=
 =?us-ascii?Q?I5By7uoBIon6b2DqyV73Rbgui2EoYtxZSU1Yy2Trxz8kfR5UFG1gxBjwGAv3?=
 =?us-ascii?Q?EfxGdY63a4cm85nD+EjwAyddJSGAVrQDPB53Gndt4n3TiZZ1kBFQHTJfb3fY?=
 =?us-ascii?Q?1cWt43Uc/UwAwAVPm67S9d81CYMrl0OoLPAua+JXHdXZqkPPv00s6aGwWfRW?=
 =?us-ascii?Q?uzWTm6UC3yW7ctQTllVIWAvo2Gu/WJQQ5jlueVv503fh6JPKSNRnE5ueqKuL?=
 =?us-ascii?Q?AKqp2fU0ATs+jGjykzrZv7t8vhorGZT8IhYDHgArTXmPkab5pXYdzfAQbcDk?=
 =?us-ascii?Q?KPAaXQeIZQ62fiFzaGv7Xpvp21/pikD6w+GZvzdRpjLhwkIKt3F3feGBJD4h?=
 =?us-ascii?Q?N8H6GxYPFSJ7fbzVDs/anNPYjGLz3rCdtPOTD5h+AJmrTW9pfKtiB/4Uvfaw?=
 =?us-ascii?Q?+XO57lAQyXB6aQYGUkP0EmSXnDQWFEfyMw1nsjdoVczI30cXCa/cSpLsiDQs?=
 =?us-ascii?Q?iXwXUQcGvOkgXMrhqKUnZHOB5oxZAveTxW3jbepjFGhtCyO9WNgR/zrDEgoK?=
 =?us-ascii?Q?g2djpgjl64W9ReQeNvY+g4DavgN42F9RhqYlSuApAaJdKCjF+MYpPTquRO97?=
 =?us-ascii?Q?B6tp4r43TUdRRAlp2IOjn21+0PIdS6EXayjObd3tHq24ccrqe9ZEIUTHl6I5?=
 =?us-ascii?Q?0/JNgVO4pZJGPsdvrl0lCQYHGXwBzoz7vkE7B/Oe1AVQAyMg9FBhHJNooRst?=
 =?us-ascii?Q?mIxubIM9HtteGm0iiLQYD378D83/3aP07BphgNEw2B2AZcqxE+t0VaFQOL+R?=
 =?us-ascii?Q?5pAeVZqwhmav0eXxdVRUKN+gexLKHQ5xCRKKKz0fcvVTMm2L554J9lLt2uyh?=
 =?us-ascii?Q?laUTHQAxCU1hlmrXYSlZog0TJs9qYM93ZM6ntmjhYuC96BWf+z6U6AjsfKns?=
 =?us-ascii?Q?kTwRpKJ1i+XRA2EipRsw/NrQCH1VSikAB2VeGvyCPJTse2v/9HodWvCBtGAU?=
 =?us-ascii?Q?ELDLUSTE4OBFJpvRZXATjb/mc/wzGSuZj+LT+cJB/Ob7gSvzHQdLXC8nFxh3?=
 =?us-ascii?Q?le3jq86Hu3Vs4D8Q6Pn8O44CPs31RIfpRU3+s6FcgBu1BWGGIBag1QoUP2in?=
 =?us-ascii?Q?A8SSHn8FbPNYu8o9VA3C8meaG/5vQBNMaR9G0665OHjUhX/GjG0eFF/kCAw5?=
 =?us-ascii?Q?HGLt0YoR1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K2oos1JrGg+f2QtYHvcYRQtq5Qv9LsvvOBntBsSUc4l6qExlmzDcwMtpFhJXF/6Jdd7FajqP853oK+GjQv89vJdqs/uMIN2A7TLKyLHBj/ugWBGIa5wSpcgsV7BYfHQb+bZgYI3Vv6bpLdV3fX7hDOyzLmO4pfXq/rW808uZRaXKbH7ifX9/d33NEOcFff4NBHgIIg3h7M6HwcA2CbXkky9sjCwvcIzR0WjK3qulThMzUAu+jVx4CIYpi0EIi/ayyNu8pfVl6CINL3XgmT97VVtxdC63WJHjZEdLI0tic7lTa9ydvB0VfkX7kBAd+VZskAeBgRGMMTBchWGj++E0gQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761fa111-788e-4bd5-23dd-08deb124797e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 19:18:54.8182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtCALZF7aB5TQjsgHYPObPmMCBxkmu69GOKCD+HnnuKHm77PpbyO1qNqj0sqd8BcvUGRLCgzy/ow1iGzye8aOVDsAqopeKtqfG5BGgEH5SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8348
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 2D371539F7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287719-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,LV1PR11MB8790.namprd11.prod.outlook.com:mid,osuosl.org:email,intel.com:email,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: Wednesday, April 8, 2026 7:11 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Greenwalt, Paul <paul.greenwalt@intel.com>; S=
imon Horman <horms@kernel.org>
> Subject: [Intel-wired-lan] [PATCH net v2] ice: fix ice_init_link() error =
return preventing probe
>=20
> From: Paul Greenwalt <paul.greenwalt@intel.com>
>=20
> ice_init_link() can return an error status from ice_update_link_info() or=
 ice_init_phy_user_cfg(), causing probe to fail.
>=20
> An incorrect NVM update procedure can result in link/PHY errors, and the =
recommended resolution is to update the NVM using the correct procedure. If=
 the driver fails probe due to link errors, the user cannot update the NVM =
to recover. The link/PHY errors logged are
non-fatal: they are already annotated as 'not a fatal error if this fails'.
>=20
> Since none of the errors inside ice_init_link() should prevent probe from=
 completing, convert it to void and remove the error check in the caller. A=
ll failures are already logged; callers have no meaningful recovery path fo=
r link init errors.
>=20
> Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v1 -> v2:
>  - Rename the now-unused goto label err_init_link to err_deinit_pf_sw
>    to better describe the cleanup it performs (Simon Horman).
>=20
>  drivers/net/ethernet/intel/ice/ice_main.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

