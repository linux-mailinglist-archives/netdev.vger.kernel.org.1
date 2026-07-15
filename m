Return-Path: <netdev+bounces-307721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ihJFDBxVV2qyJQEAu9opvQ
	(envelope-from <netdev+bounces-307721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:38:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A02CD75C92E
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:38:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=bf82tzt5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307721-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307721-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A9AA3004F38
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8168B437870;
	Wed, 15 Jul 2026 09:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0198435AB2
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 09:38:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108313; cv=fail; b=F/OxrbiLdkBcQvAZxAo0PTor7gVulwQzV5TPlthbtv7NCcaxEnwh6kqOpFthtdzuvNwDmrf56AySvscjiXNdrujhO6r9ue1DIg3q28nzt3y9+PLhpQ0NGbdHl/Pz//1rZ53KRUx1gyBU9KheWLp9ezeF+LOgiFHtyfOsc0pQaEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108313; c=relaxed/simple;
	bh=0nMmfHKktiI36GurrmmdsN7icqrwcqpCod3b4FQDug8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IowRivpXRGhGHu8ejWxA3CJctskASU79sDeHZp0GZLDjh81WaYUx688UCnLmVQz5NxrshNzlWfBIH6H6GPT2lyZHC/87H1TXGyCfMa9SEP+e6kc/kPFu9KJQNu+Zhy2I/s+pZ9d9cCn6CCS8qD9LR1gXRQuJ3Ywg+lhwavBRcok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bf82tzt5; arc=fail smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784108306; x=1815644306;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0nMmfHKktiI36GurrmmdsN7icqrwcqpCod3b4FQDug8=;
  b=bf82tzt5BsdtTHJ7pyoKFpVREJdmquL7vvjm7M/5SKXUBVjLvwj6Rz3e
   qgJCq8rhTpml2hOuMvhIDi8PdvCchfh8P0mEs8QiRccNF8/ZhQ6siGyKq
   K8CFLxiV/ThdOFc8fkSPPbxtqkdXfcmmoi6K82hwsPLG4bgxPbFUIAeif
   2DkWKUTQISUT5Y0Jv5Da8ghxAodEbMl9W5IsZkO1GYL77reKhrCqiU9v0
   I4Q2vdThhNnizgKTwkiIZf/QvVN6kucT96Mxg6KT+VtJqqnloc31BK+fl
   jk+zRFWiYhuWnBu7MKZRQ2qdDHRl7ygdjnCOHB4XzFU2ig+RTW7DsamLr
   w==;
X-CSE-ConnectionGUID: r9a6V+ifS8yPGHEzuNX5OA==
X-CSE-MsgGUID: iD0+ZiSuTayx6DKXyMKUcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96256717"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="96256717"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:38:21 -0700
X-CSE-ConnectionGUID: 49Q2J+NSTT+tiCsKj89sSw==
X-CSE-MsgGUID: hciVY/O3TFK7K01Wg+PB2Q==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:38:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 02:38:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 02:38:19 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 02:38:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTUKjR+0RNY41NQg2wPxWlLf6KYt8Sd8pjdvRxtdLiREv70lvvHjZ7a/L5Cp3Kp6NVB1x182/4U25UHGmnAVfp3qGhEIllkRQwohxvDMglFw/pAZKeSc1CxQkYq3im1XBq9OMfWQIfkkXwpx+7KTil5M+tH2Zutxc/3osW4oqNvLZ3oqvelb6eODqy24hCR+jY/LLZqvgQugJQmy1QIFltBIOARuQsGVX2VwKCRk8mVpObNkt2peh2c31KKdAO7r+BpObhPak+bnOEzCMH3PX0rn2T0ZTovJ7vWFhCyxb8A/8ZAuaytlgmU3qREbu+FP9wSlQ4/ReTY/HiSq1QHBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fiu5o3ID3xILqy99zyh54CeqW66p9AgFqzJcXx1m2iU=;
 b=GRD0ddzIEw8deqbdwkjYXbct+7JN1wodv/Zx4sAiWBVjURGx2vJpXsMtECz9SjgrXN5iMjEqLrvUM95jjXnzSrqLafaT9756UUrsw+i7pxnRBMSJlE/Vcn23cZf02YO4OE917zErKHZly00RgDLHWz4KOHF1gslYNoSHh8TWejq1ogcxVqih4otK8F3Lr/u1rtaLq+A+hdlI6xlLrTXzNEcpP6fzBt3w7BVvIGYKM3+8Citt27CRrOqFnIAXFCVIz/Kq3ATkNjJBxgfvVivB9d8c5e6zQrUj+9K82im6NmMSf4jH8YKJXMVJ2YsZsT0WM+lRldzzPJe9m3VAfwfijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL1PR11MB5287.namprd11.prod.outlook.com (2603:10b6:208:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 09:37:42 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:37:42 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Chenguang Zhao <chenguang.zhao@linux.dev>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Chenguang Zhao
	<zhaochenguang@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: xsk: fix multi-buffer
 XDP_PASS skb construction
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: xsk: fix multi-buffer
 XDP_PASS skb construction
Thread-Index: AQHdEzuhmkbPpN+08kmfIyAa3uvLcbZuVKNw
Date: Wed, 15 Jul 2026 09:37:42 +0000
Message-ID: <IA3PR11MB8986AD34DC026A4FB3946407E5F82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260714025112.284724-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260714025112.284724-1-chenguang.zhao@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL1PR11MB5287:EE_
x-ms-office365-filtering-correlation-id: 160f67c4-4276-4eab-437d-08dee254b7c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|921020|38070700021|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: wKLJHGhX2DKGerLP7BafHo/lkOAPvgYXM3/Nlm/ki7cnwrlWcywlsum/zDdq6ESmtVGuuHnXuwmXg2Kz8dBWIQtfiygZfoWcE7ZsINHer8gHXjT4MbaYzjYtKfxeu6TvvPqfTlyY7RnAtlEd8DNhL4s686N8Ci5bbP14d2PwjQ7u+vLSjBOIm72sGB6AMVbGFqhskPZuYXmWM/xmJu23ADmfRU4ZxCZv2u7IbAxguUVLj/CyrLukZTgwKhtO4N3dexX8UYCAnbmj9+V6eGreiXgyuuIdMK7TQHjd1qCwIJNibmbXDfh4mLs68RbOmpmpbcQYC5JZHb15ni10tWGorxPajUd+LQAumS+lnmInB+SvAz901CClCZ54GUbAHI98gCFla8uHHWbYAtu0pXZ/lnCycJU+X1K4lrYF/t3Qm1VYD0laf9JsM/KEQHs9ABWJGM7GewvY0XY2mgEhRuETk/fNeI66aFfRiNEk8eI4jAmw+OTnO6967xn2hHtc66TTShTAjm4UOMJu+nvlf9VMqQxFPPrMiASyKp+Bx0Ll7qBeKgu3jxuWeSNrOExeu7ZGF+NtDwiBKL9kmP60EpfcBuB5Mprx/l49JdiJvtfP3XMsGBvClakAH2edYORo9NUuVN5YaL5filTiYXlFw6hMzx+EZpbk+uZ7EsFRQO1qpej1W41fO0Rq/6pRKPNG14J6sgtKwLlUcSyp7854oVsIginvaFTC+HE8gtcWJhAi2sDbBJwCXmolbkuB4tIxN9/+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(921020)(38070700021)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?npu2sJkUlhhkp9QVfcLGL8VSy7Mjnd7jrjameqOIaSfNEYYg0ee2Sfr/HDjg?=
 =?us-ascii?Q?YC2LOGrxQMQmI/T/Xd6F3zFwXV6tslwPo12txU1JNt/403cCf8ZiRIF76LUF?=
 =?us-ascii?Q?MafniLLKA8G1WauWBCXXoSnNPP43B3mfksSckd8HzcfnsptPRGEN6MfVhpZ9?=
 =?us-ascii?Q?y/b0sUqQs5qUV2rj5FZ/Fu0LjHptSfnjnQ8UtR1Ur/cuad1bFbLqSj5KChP1?=
 =?us-ascii?Q?bw3u85lmNBZW3DXjnGZEcDI/RXuL8V2Tz3Ti5N97jHoLTCt/aC3J1YGO/pXB?=
 =?us-ascii?Q?UJrHZ0gwGV8rfSeWzoUF3FGGM7lJ1EBLxYR7OKVoO5+0Plai5894HprzI4fm?=
 =?us-ascii?Q?p1pg4ZZy/WAa7WsYETHoSC+5YV/EtXDu/kL7PB9AwbTcpveBXmU/DZfNFDuI?=
 =?us-ascii?Q?jFJUCx11XAggl3GuC3mAEKgle5fnrkTqSRlzZ4HF3JDDvq0HzY5BZSyP4pta?=
 =?us-ascii?Q?nuHnGbvw1KeG1BXAtbRF+O33jCcWQ4mXpYxSHUp3q5pR7E4oBzcShXldDSDZ?=
 =?us-ascii?Q?H4TcE0FfzVWzYaMOCz2qnJoUY8zFxxmFrmQJm1/54vOp+X/TSPlYokM/QeMd?=
 =?us-ascii?Q?92KweLIRR1rjwjCaCxL085YmyDpzyG1bgA+J7cVcSrFoHhbotMrqGKzVcq2/?=
 =?us-ascii?Q?BLWxykVROM9Zeabd4Ds0yMKVA7M1s4CxSCMGvARv0THrrML9yTb60LiClzoX?=
 =?us-ascii?Q?IlIZPmsCs/ggr9KL0XtcaBdiApOffwELrk8sH1FGukphcZ/JY7/QnHbLZ7Cc?=
 =?us-ascii?Q?L3uk6b2s+EMz3rIWQisyg2OKklN/klrbOkyA0bL74QJ9+lNScjTmphkUG2b7?=
 =?us-ascii?Q?8GLSfvePVAf5/uGQHNkSMefCnbH8Ph4B1tvkDynlJnKmWtEj6iYhHYpxg7kT?=
 =?us-ascii?Q?zNiNgQbwD+mXNOUddVb68Oq5f/B57k7/bZPJQHagfzcsE49mJst9ECblWHnH?=
 =?us-ascii?Q?lBHVWzBi61GDVuZt1rvEJ5EAKEnLN40FaOsiAf7yzBiwGs/Twjr9Bn5voemD?=
 =?us-ascii?Q?kCY3WyPgO/WWnXtLZf/2JBucpBWNIlGOgyaHpRn5KR+f4630o+P3q4YyTg11?=
 =?us-ascii?Q?7D3jcfbaNKVJlRwimeZ1D8q3qloxtQm8z0j0Fj62ra2aPjYToAKJQ8FavZwM?=
 =?us-ascii?Q?HE7LexV9uk5RK5zW4+pAO7/PRZAJZGsMNt5TB2vxMPW/ZGuuDBvrxiW5Ul++?=
 =?us-ascii?Q?wcxNqt2Wi7N74CErqBIUm9Q6WnPW+4LDKoBiWrUIrB5pgWr8fPX+mVOg0d7A?=
 =?us-ascii?Q?73noW5GrE+XGfz0lZL1yPZ8WJeJ5T24esuVvOdim6tFJPfBCfOiiZLu0FbJI?=
 =?us-ascii?Q?8yE6/FN3P7p1VLSckrvua8yyidudwHV1wNnLt4mfvagiY1RWLV/gCRCeK61e?=
 =?us-ascii?Q?4pxu6S4mFfqRgHSdxJSx583xHZvDQZcCBb8J4EAVquaE+w08DbWf55UpKV9Z?=
 =?us-ascii?Q?LBBJRLYStxHCv/wk81Nfs5RrDmpa1U2mDd3LH9sKv2FqJiueYQ72kT8d4EmF?=
 =?us-ascii?Q?6rKN3tXfp6zw4JqDbrRo3dX2D7pKhaSpXvlYwnchrDaCbbShc2SW7JLzD+Ch?=
 =?us-ascii?Q?RVAuhVRESvvkiZU00WRfGF0DMspbRhO8cpwQ2q61ZdPyILBYu5VCAkGKuKb6?=
 =?us-ascii?Q?pNafUfjGPiU7Ut2KpvDsBgUzqApUMjvRIn3nayXmmQ95s8KncW2Fjol9L1/g?=
 =?us-ascii?Q?8pKzN1t9F0+qfzPD3vkARKAZ+sctzI9q4DzOhIdNA2a5A0mWDdsc2uZMnIAT?=
 =?us-ascii?Q?D4nNoE0xF6lXpU3wAozoy7mXesJeyEw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s3YMMVMrn7jL8Xi36l4zAzgwE+c0L5b9r1msdj9nam0CaFBBtncbinpVS0Udi/1eD6W+ZSCIwltWY0GG/YHYcKOKhnI+gfp/W2pQAIS7Wv7qzozpMg8bxoxSxUlPKPrs4U5ZqYXWPFnPFeRZr8GhX0TSU+LB/7/9Zq9DnszyaZeOkz5UwjuqKmRsSdj1HxzHyvCi+1v+CbqMjLK73i/DQ/TIGIigdUtaXa25U0vKwrhyq4dnSwyrHBnVzVT3/9pa3E3Cj0il9e+Ly7SCA0MJd/uzIgdAiSPvBcoGzDSbuE6y1AzN/e1zOw122EbcxlVxhoHtfENgP3NVPZb+HS1z8A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160f67c4-4276-4eab-437d-08dee254b7c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 09:37:42.1058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCa5wXz0l/KIEVSXgnDCpOe5Jv3988CCaYTROH0WCJd/cOrfl76ZRBqG+O27FNDgEIGu/PqtD3txMhA96jKHD97w+SThGvpct0kV/2OAZQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5287
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307721-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:chenguang.zhao@linux.dev,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:zhaochenguang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A02CD75C92E



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Chenguang Zhao
> Sent: Tuesday, July 14, 2026 4:51 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org;
> chenguang.zhao@linux.dev; Chenguang Zhao <zhaochenguang@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH net] i40e: xsk: fix multi-buffer
> XDP_PASS skb construction
>=20
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>=20
> When AF_XDP ZC receives a multi-buffer frame and the XDP program
> returns XDP_PASS, i40e_construct_skb_zc() copies frags into a new skb.
> The copy used skb_frag_page() as the memcpy source (page metadata
> instead of packet data) and passed a virtual address to
> __skb_fill_page_desc_noacc(), which expects a struct page *.
>=20
> Use skb_frag_address() for the copy, attach frags with
> skb_add_rx_frag() so len/data_len/truesize are updated, and on
> dev_alloc_page() failure free the skb via the shared out path so
> xsk_buff_free() still runs and previously attached pages are released
> by kfree_skb.
>=20
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  - Fix memcpy source: use skb_frag_address() instead of
> skb_frag_page(),
>    which was copying page metadata rather than packet data.
>=20
>  - Fix frag attachment: pass the allocated struct page * to the skb
> frag
>    helper instead of the page virtual address.
>=20
>  - Use skb_add_rx_frag() so skb->len, data_len and truesize are
> updated
>    when attaching copied frags.
>=20
>  - On mid-loop dev_alloc_page() failure, go through the shared out
> path
>    so previously attached pages are released via kfree_skb and
>    xsk_buff_free() is still called.
>=20
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..a4247710c85b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -318,22 +318,19 @@ static struct sk_buff
> *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
>  		goto out;
>=20
>  	for (int i =3D 0; i < nr_frags; i++) {
> -		struct skb_shared_info *skinfo =3D skb_shinfo(skb);
>  		skb_frag_t *frag =3D &sinfo->frags[i];
> +		unsigned int frag_size =3D skb_frag_size(frag);
>  		struct page *page;
> -		void *addr;
>=20
>  		page =3D dev_alloc_page();
>  		if (!page) {
>  			dev_kfree_skb(skb);
> -			return NULL;
> +			skb =3D NULL;
> +			goto out;
>  		}
> -		addr =3D page_to_virt(page);
>=20
> -		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
> -
> -		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
> -					   addr, 0, skb_frag_size(frag));
> +		memcpy(page_to_virt(page), skb_frag_address(frag),
> frag_size);
> +		skb_add_rx_frag(skb, i, page, 0, frag_size, PAGE_SIZE);
>  	}
>=20
>  out:
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

