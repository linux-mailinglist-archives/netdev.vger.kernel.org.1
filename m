Return-Path: <netdev+bounces-262116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNCKO7XTomn35wQAu9opvQ
	(envelope-from <netdev+bounces-262116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:38:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A491C295F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 887CE301E9AB
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF043C053;
	Sat, 28 Feb 2026 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KV7PX5pm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043E439010;
	Sat, 28 Feb 2026 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772278707; cv=fail; b=MkH/z2lj4Jd3SJwmufhXpZhgLJNzkU5VqeAzkYbZDj2BiRAYpbjxypbfO/aTnU1+WL8qirggzEEfoWqgCbd8a+9Z6FC0v2bd9wfzBUBj5ZoPabSLE+jLtWzy5BX5/x2fjGQPeLEj3RzEV5fODB2iGH6/qrjvwStERlFqZqqhZBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772278707; c=relaxed/simple;
	bh=lZ8Q6yIsycbLWoeJhVcdSAWtSF3JTjrLvz1Rvt5p2As=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HJUyoORIIfZvKHCORsrSW0HnbShvWF4Pd7cpzwEqgbIsjm4cOkH4oLwXnJftUMTdpAsBXTHfJnJUHKukI0s2PpyyE9u6FJyG7CplMYl0NaxMxIPwq0sZxt88D6wzV1dhAs/8dhxKauapcwvOywdZA5bz3LjjqE4bKiPgHqGrj2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KV7PX5pm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772278705; x=1803814705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lZ8Q6yIsycbLWoeJhVcdSAWtSF3JTjrLvz1Rvt5p2As=;
  b=KV7PX5pmY5jsJqr79ViIq5QIYpSsfpBO/iuP+A42euW3vzLO57dJnyHh
   IRz9Bn67gKSdWBAFqGJw566lNsxy7kgfHv6Ja/gqvy5h6R0/1EwOezLM3
   yakOwVkZe8SIzjhSWMwFoWutpWhNbalm6svBA6qpeTjleFVsbCpVwCa6n
   9tHcV5GpivW3v7Ozdz6LL4GjaztjepAYLwWOo1aqtXHcZ3ctoaQ5wlDSS
   OMfzE5mYFD3CPO+zzbwviPDTKjo2n1Oc+vIEPZ+XNcbwwdRDPVelHyrtw
   bY7r8iclipI7lG5RbTl0wX154tkJ6e8ikWIAIqfSva/6DqyolUqIt7t8e
   g==;
X-CSE-ConnectionGUID: JSbprUbsR0eVV8f8ghjh6w==
X-CSE-MsgGUID: EhbMn/fHQCG74GQIzQx9Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="90927800"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="90927800"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 03:38:24 -0800
X-CSE-ConnectionGUID: /SXkSGr0SEaveYubTMm2jg==
X-CSE-MsgGUID: 3EHsuYNPQDKZj0Z1zotziA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="244405357"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 03:38:24 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 28 Feb 2026 03:38:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 28 Feb 2026 03:38:23 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 28 Feb 2026 03:38:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XB9mE0v5zypZoQbVwHGyv7IIqvHqC5evJuiURemDTdRS259dtpVC/GPl5XtkwwSjVx5hfXPa7M5meZqbwSU7JXpMaLwaMQoeX4F3J1As0w1mfP9VHZ3mS0IgRpSQ9fs9l1V4rf7ceZdBiSRJ2Umxpv59yywX+zj+nqdSfgkIvm/x5QzinkAWs/na7uo+KTAEFowgVocZZJpN1DYjiIwn6hDjqNU0fMkP4sTbYd6BDOm5Q1jAoiQ/u8pYxU4PyJo3H6c3DeJVQMM3oZEmjQHeuntGH0jo2i3fHZQmZqpzlpk+uaqs4H7BwnQUsdPd+biuj7wnJEA970ZA3XYNx4fPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ8Q6yIsycbLWoeJhVcdSAWtSF3JTjrLvz1Rvt5p2As=;
 b=M3eFx7DsVk/MJjlh7Jr4Ya6rlR03fqnDLlBTx7J9NXt6FP1sa6rFiVaXYJIWtvJ5yPKOTUr5KXCf5HCMvuQUEzv6OefzRxAu2432DVekyjPGi89YQDj4kEaEdlNQ85RDuIhXQFfx2fD3vWYmAZg86HaXfBXyIr2SZ+ntQPyedwsUilea05GGPJjZeer7LL+2nQa34oSb4YmTXVuAZgnH1rrQwO7WvdId0sGutIdon00G5PYUV0RC0eTnb2p60PWWi+bJqCsJJeDLZqHsVEjNzdFe/CEw07IkXS8KMijn0K1jxhNcwBaNZP+BPT6YW1B86fzKozhdtieaAmzbOTJc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 11:38:20 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 11:38:20 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Zilin Guan <zilin@seu.edu.cn>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jianhao.xu@seu.edu.cn"
	<jianhao.xu@seu.edu.cn>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: Fix memory leak in
 ice_set_ringparam()
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: Fix memory leak in
 ice_set_ringparam()
Thread-Index: AQHci0+8OzENVPon4k21P+oh1qh+1LWXwn5g
Date: Sat, 28 Feb 2026 11:38:20 +0000
Message-ID: <IA1PR11MB624105E17B9AE5468CC256CF8B70A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260122032644.183754-1-zilin@seu.edu.cn>
In-Reply-To: <20260122032644.183754-1-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SA2PR11MB4891:EE_
x-ms-office365-filtering-correlation-id: f4f693c1-fb39-4c2b-21c7-08de76bddfb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: 4NmzJC/0zqmt2j6axyxV+yeR15eoE5hECm6h2bwFUm7FVPNGE3KNY57GyT1mCMv5UkpRai3/E94u7g3SMKA92Rzk9A9xxchRGgVf/2PR5hU5c2Q1uSARRQ6r17/P3gLQnlpnBt6awjTgDEsw5BRqqe+kpv+w2foElbznhyo63TLZnoxcsJZCn4qZh0PBIb0dpg8gKbRRzf9UtRC/DvubbqWS6zbKkzY/upxR/9EmUiYwYpbk2mWcgI4y9QwQSewrbvltYDr/Bg/EsV57QxRxqaC3w8mQth/0AKxmAKiiMszWFDburC6PkVncSmM4tqWjjARGxql8BTHyrxvxQ0n+s13gU33Hj5MHXaBZFhC3dDBi0cemG9lLAZo64vIRC0Re/i3XOIV4W4QPhe3IsR/uueHLWa51M2i997rGJBCIg7yO6DvNGeq91S4Wb5QNMR0hcG7s2qc0iNVF71WWgonDWbIrGMYERZgFnu07oOBo++rHNVPwcp0ub2IWlaAR8iK3Xqemke+dAwo740kd1u16LvDuVc9wGU3xVhS6FM4gmctaXy830skGUvWBVG96Cjag4bMemBMBru7CfiXeT160wAXnQKTiEKHAICne13GL5K67J2ckYg9y5SU/dERduGY4AlO/JaRHPM/IhHmqikAq/iH5eI4prK1E47Y7qeii/tFhpsyA48yCSNWMDhCcvi4NRzRHv7m3EE2N6D+osLOryFM2VIK+Ftk5uL3fwbpkHbu/qmg+tQXdh+g8Afg2pE6jB8pyDf2inThrkxHEJBwL+zi9SKGHTuiUBH0Vy0itBAk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1/cnj+u1ESJxObU7Ph0coRsYK1JSUqFWOdWn7i9hRtL7cLfliLyCYCNNjokx?=
 =?us-ascii?Q?XzQjhiyhAC71qmRs15IAfZlPyN2gfXWxn2bl0SvkgSL4Air3RcaDQZsSsZy4?=
 =?us-ascii?Q?2TC3y3rBkC7ajW8BeAQqoAPuR9ganLByFiWoHhxc1TtVLBLWUerWeT+PbBaV?=
 =?us-ascii?Q?XU8slZzjvWAX+TsoGcmBfAXasv4n8edsy1qauKCIpzaA2q/GKVjaJHEnf2Lm?=
 =?us-ascii?Q?sZDNFXQztaAEK/3nM7IaER8E4R/B4G9tW9u9KjO7iKDwB9v6W7kSveEto8RI?=
 =?us-ascii?Q?loIvKvCNgT2Drn2diOYMyEX20NONKOtAPVvapS5XdaDadk2I62OQXZgi6pyN?=
 =?us-ascii?Q?QfoGLlcvNzmuBpmvjzdAIsAA8MTKs4ZpUQJhBU0DVQUYIF5pev7lMirI1hYy?=
 =?us-ascii?Q?7vP2MhA9mLoenWLq9dgP8Q16ULdUFIP178w1pd5TPzvcwV+opKbeC0lzZ4OA?=
 =?us-ascii?Q?K0IWZmRR5OLLiLZMXGZiKAFs4l+1gn24dT3sbQiGnQAL4fpVlEdEqp5QvZFY?=
 =?us-ascii?Q?nUcrLXc0/E0TRFKZs+dypqIYA5RkscK22t25iAM7LwnjFqjACwOldAojyKwy?=
 =?us-ascii?Q?9KuaiJjLmpnyDcj0qO4wtjHY8bXPXjb94OkKDYHIfl7serSBVOTRcUbAGWt+?=
 =?us-ascii?Q?pAy3fqTrO6soyRjH3uG+tE9Wfs4+qtOf7imrE+nHRwkGDD4vkzGXikbtD87I?=
 =?us-ascii?Q?3Vlf0It2/2zmeWAafz4/fNr5VU+R+Urz5OvXW3a87zDBcxyydpyQvQD4yXcE?=
 =?us-ascii?Q?sWFx1XwQS/5ymh+EWxz4On0we/MmPlDdnbbS3dHFUqTQZET3HI2MvED+3yeb?=
 =?us-ascii?Q?5thyYsOIappIozu3BXL3wP3j9El0x0ve9X5wnIJgdx2vDMdTZ4Qa5cDyIUAW?=
 =?us-ascii?Q?F4vWJJQa1AuvmXBUFamif2HRNqjz0TC+2Ff58oIXEYOCop3pQRp6aD4IG10P?=
 =?us-ascii?Q?Nn+NIB2SYhcdhNZj43BoNGeK6H8+D0JGBn465Gs81B0yNu3vgmB5ssfx2PEi?=
 =?us-ascii?Q?NxgH4FqXYIkfJdLoTZqNKv0HZrF803NvxP/jSBrKTCH+i10aKrKPwKbRCs/D?=
 =?us-ascii?Q?+ncb/Haxvb0XDt+motCGTsv6Z86E3BUW92FgvLqKq07ZBGVo9T/owffONSsf?=
 =?us-ascii?Q?zZAQHTEvvetGjlax25DU4TH05jg/Ro8BP0jkh8tRgEk91VsJWq6abGaP/YKp?=
 =?us-ascii?Q?R4Vt99cDuAmUHoDfuQrbLbiGSRCo+I+PzYrnZKFmHNJrbNyvw4dzSErDQb7y?=
 =?us-ascii?Q?qmkFWUAhSc80mNZx8U1znBEgz/XsLgw9QT8p48QNzimbVc0vIbpnV/uqGLrp?=
 =?us-ascii?Q?YqVsqCslNQPCrCdBgpUfcOjx2fmRTOk2P3Tzd2d+lH24qlq8LxIOeR9pC3kc?=
 =?us-ascii?Q?xBKYXSjxyzo8dEWV02JPDGRcPTGTMMITmyjNBia+5BUvr50vXP8CEkSzJGgc?=
 =?us-ascii?Q?4Wrhvm/dN0UJSsHZApyvpRyiLgiUqV0BwbMZlPDfXp20HyujMof8Gi9fQGY6?=
 =?us-ascii?Q?CzZlE91BG65/vt+2DFb5IICAqy6sZG1kK2uEMB9oZLiwV/BYRUrAqNJGRtqm?=
 =?us-ascii?Q?G4RQa/Yw5/6jocIWmGqRS2C4Hmvai+9DJlNnr7ICM/c8eflnza6dziaY88p/?=
 =?us-ascii?Q?BYIj1Rfge1wGohL1ik+Hp89+D7QHj1JYg+vbIQ3c9FTkfx/3WSpQM/E8U3uI?=
 =?us-ascii?Q?iCotd8gUetKgfxJ5txWvbuk1htG3XghlfwbkyUMXqBZhaZao?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f693c1-fb39-4c2b-21c7-08de76bddfb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2026 11:38:20.7302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUstWAhSQ3C2NbGrI56qz5QX8vPLX5DRZ3k7DA8bNzpO9KX/oh8pt9eyGOuWeB2g6pHOUa2kwxGYsIcNorVXgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4891
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262116-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 84A491C295F
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Z=
ilin Guan
> Sent: 22 January 2026 08:57
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lun=
n.ch; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@red=
hat.com; intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org; ne=
tdev@vger.kernel.org; jianhao.xu@seu.edu.cn; Zilin Guan <zilin@seu.edu.cn>
> Subject: [Intel-wired-lan] [PATCH net] ice: Fix memory leak in ice_set_ri=
ngparam()
>
> In ice_set_ringparam, tx_rings and xdp_rings are allocated before rx_ring=
s. If the allocation of rx_rings fails, the code jumps to the done label le=
aking both tx_rings and xdp_rings. Furthermore, if the setup of an individu=
al Rx ring fails during the loop, the code jumps to the free_tx label which=
 releases tx_rings but leaks xdp_rings.
>
> Fix this by introducing a free_xdp label and updating the error paths to =
ensure both xdp_rings and tx_rings are properly freed if rx_rings allocatio=
n or setup fails.
>
> Compile tested only. Issue found using a prototype static analysis tool a=
nd code review.
>
> Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

