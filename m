Return-Path: <netdev+bounces-298016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HeF3D4p3KmrUpwMAu9opvQ
	(envelope-from <netdev+bounces-298016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:53:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2C66700C9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:53:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=leVSwh9z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298016-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298016-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98B76300B09A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315F368276;
	Thu, 11 Jun 2026 08:53:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E23BADB7
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:53:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167990; cv=fail; b=H9KtVHaNYbVcNGwnaYAB3Wx3rt+R31jTeewVSIK1jw1pa9yD1Of9RMGa6WsiwAXr2bLzbnasnOh8kXNq3gp+8D6KCEMXmmzEnTyeWZnUSybyUZlVMT2p4juELHEN/W/e95DEWWYdvVtdc0j0WdnpZ3hCa4fnSABWNPQc2V7W87Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167990; c=relaxed/simple;
	bh=Gd821YAXjIko06kfhDELlbpNFK6vzDUHQW82ZqkNz4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NmXB5habMzYRPW44lhQKrus+r0dmNDI8Ax77LiQlG9OgTKoAv77XQlC1jIEdvkGiRFcyLlwMyZyGrNpuX3mb/p8BbXOs3MlSUV3EPN7cGFKghJuezQiV/jcYDX1RzO5LjaAGGCln15DI/VIBxtYljp144oFhoKaar1mGJkcYwoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leVSwh9z; arc=fail smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781167989; x=1812703989;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gd821YAXjIko06kfhDELlbpNFK6vzDUHQW82ZqkNz4I=;
  b=leVSwh9zbW99ziimX66alkQWI5YjfGXNSHGd67kCko5ugifB9EQfHNOd
   ouBybBMoExOcbj1g3PJ37BUl5oSaZODAwPVTulduSN/tYJFEtneC6iLTb
   WpkUpGJdaW6kXOhRj7Uq8Ubkbe8j51gzGGsx1CEKsW2+gWF/W75m8z/qQ
   etCjVwchV9co/W+fEckPJhl+gWbpHzPRlGVm+B/9JSpi4fLEKcGkSpt9K
   UI1X4fEx4u2Xt8mgv9tfanNzTIwUNjT+qHtR/WHF5DsnJpNFrWDk48SFp
   QIEdyShPJVPs+L0e7JHoohEuQHOXEuRYRzKe9D+micPEiQXlupwqkUXc4
   Q==;
X-CSE-ConnectionGUID: 49CEwSjpS/mtP7uvWKgVVg==
X-CSE-MsgGUID: +4maTJvWTuCPISxWYwAx1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81955920"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="81955920"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:53:09 -0700
X-CSE-ConnectionGUID: G6V8z47hQ/ilRIO7ajSn1A==
X-CSE-MsgGUID: Umcya433QYeESH17LW8APQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="243976262"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:53:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 01:53:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 01:53:07 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 01:53:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3ycqyNTIF9IJ4wzFcUlV6abNGh7A+TqEednY8/bNkqpPTVFUdWJ7/MiPKGHkB5HSMPXg5yuJvSP3v074/Lywkw8/uN8JMH76ZtN8wXCjEBvRE4Zz+rGn0VXeok18sFrf7cSdO4lkGHyBFd8p34rcaOlgKNjB+Gr2R6eKkp1B927PlX7UxcrASWcaLtRrjE3xcBrIW2k7aRIhyrt3UH7myfE7/DRjO9UZcaUcwscx4EN2LdTE9nZgYTF9y6TgUfOqoQ7Rl+q5oHNEJqgywdIoew/pS7zMgIU7llFvjz4bA4eFhuOuKl//TzZ1nuZv86n3fbqolpzWbHt9ieXk2f1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd821YAXjIko06kfhDELlbpNFK6vzDUHQW82ZqkNz4I=;
 b=geyJkoI9lzHkuIp/y9oZL7vvzJERZSYEaOEY3K4gGAXq0TkAuI+VMltwd5ssTSJL3VAkEGYgWToM+xzaGB1BdkYRHE3b0iTj71pdn5/H//TIbXPCMcYX65zfPC5I5HoaqDNjP33xX25BSDvTfn85X+NB/w1zznxyUkRHMZOgZobp4HIkoOOlOZk+UXkkZd+tJyfffmq96JcnsWxpg5ZISjXo0OxwNDW5TvLrWA7a5s1/JsNl+TlPcWuQHOfVw9L/nS2VYKdlTQemOyMlGx7FdwSRBm9AwLsYHVAKIvcxDRRjbb7LNUcY9tJoiHbbzpVrQO5U3mFamHjXKzDAECeKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA4PR11MB9371.namprd11.prod.outlook.com (2603:10b6:208:56a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 08:52:50 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 08:52:50 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lichwala, Tomasz"
	<tomasz.lichwala@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 1/4] ice: fix asymmetric pause
 negotiation reporting in ethtool
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 1/4] ice: fix asymmetric pause
 negotiation reporting in ethtool
Thread-Index: AQHczjOyT/jnXrnlU02+wZhmhays57Y5Ft9g
Date: Thu, 11 Jun 2026 08:52:50 +0000
Message-ID: <IA1PR11MB6241CB4DFFB3143B68E42AB78B1B2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
 <20260417062954.1241900-2-aleksandr.loktionov@intel.com>
In-Reply-To: <20260417062954.1241900-2-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA4PR11MB9371:EE_
x-ms-office365-filtering-correlation-id: 5e74a514-bee7-4036-9eba-08dec796d16f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|38070700021|6133799003|22082099003|18002099003|4143699003|11063799006;
x-microsoft-antispam-message-info: rz1gpv+KPntsLylUiAqGlrMWn6I6G1s3X0Fqa/LaLlPT1FkgFeQEgUy0PwPuk3Caw1ZVvveMShiAT6fgUb7CZgokFLj/qZl9RCwUoF+HUPDYoIovUHbtxwR7hePQLAI97Sh4oaiMZjq/Kbd7Ng4XsXKZVLAV9g13Ns6U9yh4gqsZ/rxnvW1ET2Drh8sswIJ6Cf0J+qe8Y/giK3RvA+xQ0FeH0IC3QiCMeX0/rVkf6NMfgyFzHVpHr0yW4w74bt9ow9ire//r8m+5Xc/6DD/p1dXXKuc3MkztxlRfh9sjKMPKosiGcuOijcKwzLs38Y3z6x20oSaBEA1AGGmhpAE6cFTe3ITtMfcmjL8qZ4C8oh3tj+rB3vAFvGe7WbtbeTGbSdQ2sRTFOy0CXh3NHwTxMIIG/cwU3UXUh7mfWSMu9LrPM6mmhoDZ1D2RXUxL7o6nmiXJa9p568KwD4ElilKomBdfmy+vHBxX7e/Cfr/hrl3dfGBhf8V6mlAfFjaaMd+mQ+62h3N1XiwPom9ZD+ViJZ8sc/5r9IBWvq0zpETSoDWTNgVtB8QlbyZFkpzyFv4SfYIr5VYbDbtK0tiyuqj3QCQEJ6n1fT/ee9QXqJhGFCQ2PWIn6L2QmKwTtdF1RbrUz3FKavBB52L/uwSo2bbBRJI0J20qhbEnKUQyImnvyHzSAjy+NH9Gj3Fpcm2Y/zgBIPYK7Tiy+ZY4pY+n7MU/S0sP0BwlE9GTjXdGPjLPTuSUmXNYcJUrDcUeNMjagH5b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(38070700021)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iCwncwlvNHcNRqOUN1aB7iQUO/Pda9kXMNH21erzdgIbv6u/Mc7Aj3XTu4mQ?=
 =?us-ascii?Q?FZlldNb7bFfcwwvgZssDk66Z6RFQeVCkdoeoGyNdeNx2LN1L3wDzTyAzH/yE?=
 =?us-ascii?Q?QlroogWDsmb73/ZA/2w0qfRNR7SkB7ldQTg/yhzz+3Wfp1NrWYDvcWyduurP?=
 =?us-ascii?Q?cunsxRnsMXrGs32+ABfI/UV8cWBHIAo7VwdKjaXoxZyzxKmKrYRQgZqhZrem?=
 =?us-ascii?Q?BiGyRAS84AoGYl222SrZsbRhwZxdlhLZDO9RE7yUdl+ujMKhxRkHuyZTDyn8?=
 =?us-ascii?Q?HGaWtk3AT6HxxDcCOj20Pu1i3n7iVPp0Qrbg6ocWnGppDmAe5oMQYHTH2HNw?=
 =?us-ascii?Q?A0UzwZhqkWI3lw2hre+E97XL2sPbZT0zaH0MFiS1vSJRP0PY7+Vk2fCQt33V?=
 =?us-ascii?Q?MSTZue1ZGYzLnGSIt1z1J56jxbC70MxuFcrMuMKpDxLqfCi+2ATfdjfWOI9P?=
 =?us-ascii?Q?NanhGMdxFYSS/iZaKF0In4KpEv5eBl9Gw/b7FA+C+pJXTsTym/NKSTEbDRCr?=
 =?us-ascii?Q?aCbETJW0Z0N74t6KhPbLOzb7ECxQTp5IUEi3QUmFW2Sh7X3E4JTMQLvU/gIp?=
 =?us-ascii?Q?z7q57SHLa0ufZSyB2xM1hClcYcxxO5XUYsGiD/jplskM+bQRA62JPXUZeOsm?=
 =?us-ascii?Q?YYMeaFAGqLQyfCTgX7HeMqC209XP1OaQ//jYWhUfdgyxfkB5mwat3ef6FTP6?=
 =?us-ascii?Q?7ch9xHL8zhHbDuKa4rLjgG4LNsUG1aWwhRlFfzYLXIJVZMyQXvDJ1GeIwoW6?=
 =?us-ascii?Q?kts7rhxPiR/D1oOzw2+woSjx/wzXNyoOxn1/nMvRjP0foN6cZ4b+WIiUCMvD?=
 =?us-ascii?Q?dO2ZXhc7Hc2JUw5MErKxOr6uxfDWm2hv1MkbWGQshHHDqJTdWbFWD+FfiTjQ?=
 =?us-ascii?Q?KrgRDleI+Kq370rWRDsipNxqm09U2zLRL/pGpn2dkXq+7Bk5Dn5x+fl/yLf4?=
 =?us-ascii?Q?q2A0etQrVXz7kFOKxt5v3CW8I4SW6hIwrlSyQaOkB09rCYnzGNSSNV/2cxfD?=
 =?us-ascii?Q?Wdym+QlaVEkMka/5qvGzZE0erhoIY9BLyIvzCqUFM4fIr8Zxr75u27jnFgmK?=
 =?us-ascii?Q?BRt0kFYUdWj35uOTgQ0/YuOh3fswOxL1t2VDUdF/IiNMmKw9rXgCxLQ5xmA4?=
 =?us-ascii?Q?vh6hXd98bG2kVxpaM+UL+Iywu5soiVUFSzlLUSrb9W0VMbu5WD0aUdxQFIpC?=
 =?us-ascii?Q?8iW0ayAlSaAUmExjFfld3zlEhpo6Fq0i201JfISWK5siXJca50DGnliLhxe4?=
 =?us-ascii?Q?QaK9SqBwcVxrcnP+2HTfLzmUNZg7AXTi5jrf/MhRDwMfq4ot2NBUEHMu0nNj?=
 =?us-ascii?Q?jXX7U78HLKDpOTzkSMgxpCquxMYY6O68Ic2QGJQYthe3Zwz7v9A1IjNyPSqr?=
 =?us-ascii?Q?qXLLISvBQV0pTzRf7+I3t09CbRJhtKtvcfKsbUxcrKYJhPELrfoi3OBwsYil?=
 =?us-ascii?Q?2m8gfANyAAhFnJE/LBon3q5TxyNDX4FtmRrE00POZDqyN8JvUMM1GuaiQ1j8?=
 =?us-ascii?Q?zOdLpM+f37oKE7K4bINFDjzjFLvpACGry45Nut4lssFruQ4hoK0UfB1Y4eao?=
 =?us-ascii?Q?ed46sZU7WQDOOriHyHFGigxLO/Y6OKnHIPedG7ZCu3wDD6dMmHnTxchlK+zS?=
 =?us-ascii?Q?sMInBe+WWxbfNVneTqjk7mEMfWEOVvwc6HWsIs8BQyn7m/6wq1obtQwFkKm4?=
 =?us-ascii?Q?mW/D47N8Kv1w5lXlvQfnsONCSRGwqq4gFEK4423XGR4Sg7Vk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D6Zv1GoBVKMARl8QaeL7Zt0sIDwdfz1g0Qc0d0BuzATxReIh8MqkU/ZOMcbUw+KZlVHcr3HpsjrhA/HGCEOgB5u9bhqpJZWGXRjwmvlOSCSFCMWGLJ5dK4F5x1Dr5/iqfO9W00EG8OzcjxEEK4NUmYwH28Bm73PcCTpNcsiJ6aiGhD3dsA/DcIoNpAzqZoPFwhmg3XsfUWQNQB/xW4eXRmO9PTP5LXkRWwFyp9/eAmKhwoDn++nbgX3Z++TK/IJ/jP+ZVIWsClEN9IBqYmgziOzndc2n2ci6jkTFSQd1Z0EpdyG8+OL3SYfZWQ++tuWLtPNOg2W+BQWMMv9agRIj0A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e74a514-bee7-4036-9eba-08dec796d16f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 08:52:50.5404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHo329k1BzzjnPk1MzgKPqbqbhvGbuqYpQ5bYRZbJVtET26Kn+8GA/yfGwRh2+bzP+DSDvUEvurXwDMUxCwAhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9371
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:aleksandr.loktionov@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:tomasz.lichwala@intel.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298016-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,osuosl.org:email,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:from_mime,IA1PR11MB6241.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F2C66700C9

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 17 April 2026 12:00
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Lichwala, Tomasz <tomasz.lichwala@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 1/4] ice: fix asymmetric pause =
negotiation reporting in ethtool
>
> From: Tomasz Lichwala <tomasz.lichwala@intel.com>
>
> Add Asym_Pause to the supported link modes so that asymmetric pause negot=
iation is properly reported via ethtool. Without Asym_Pause in the supporte=
d modes, 'ethtool -a' incorrectly shows 'RX/TX negotiated: off'
> for asymmetric pause configurations, even when pause is properly negotiat=
ed and functional at the hardware level.
>
> Fixes: 5a056cd7ead2 ("ice: add lp_advertising flow control support")
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

