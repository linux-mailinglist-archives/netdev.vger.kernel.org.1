Return-Path: <netdev+bounces-292971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AtnCGsaGWoMqQgAu9opvQ
	(envelope-from <netdev+bounces-292971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:47:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D785FD25C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF63630053FF
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A17367B93;
	Fri, 29 May 2026 04:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTagWfJQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B322E7391;
	Fri, 29 May 2026 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029725; cv=fail; b=cnPI4ZTy+/O7XGPulvKW5vYFlY6KOgd9Ww8FMYthXNS/wXDpXu/hVbj6ypN84MiIN8uv9OhhYfsurBU3AgAaK1aduzfzSuHidJ40pLbZrIaK4qpXiIJ7N7hCDdNCBWjuVHwdnYH4A6CBTf8iZ6q2YgV51qpilhiwai+Ze0BMaik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029725; c=relaxed/simple;
	bh=257lz2pXUGYYg7DrVwCeVSqG9Jm9OkoTDD8TA3RsPzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S4CGqhRokOL9jNo/TQCal017lte69mK5Up8JnyO06V9ndWaPP9iDyBYL/4ODAh8JqICFfdQbPPbHQ2S5JiCtLkwLHQ+pppM/J93Vrf83HB4ifSfHIcCDJp+dDmhMxUECwJUaSNL69u0GNTH+JqzREgFMa0DUmPQdHpk4ddbf1mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTagWfJQ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780029724; x=1811565724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=257lz2pXUGYYg7DrVwCeVSqG9Jm9OkoTDD8TA3RsPzo=;
  b=CTagWfJQsVFaGMCBBs4tV7GBDjnFiLiA9Om3N0+SXkqf4xDjDTNQWOMx
   +bOf+hAAyPB0AkGOaCEYzdq1B3lfSdHhJRc8lMH3TGIlDRqQBD7hhGr27
   1z2txVz5TkjGCooppthfjsa5rkRKwjaFjJwKUbr9XFq8tPmW78PvTIo1Q
   HusxcCV3qK18WeZMKNBBGnTnnH0aruM7ENbF2u0fkKSaJIryOF7/rqxIZ
   Z74C3NWMEeLCxbXEvy9LiIMok0RdUZLAo+IjhlPfgpXfUpO8805n6SbJv
   on76IdK5PC3rb1U7CYYNSwn8CCa3PAWX331tiCQuMdojeBBrdk/imZn8Q
   Q==;
X-CSE-ConnectionGUID: flmduZ9uQkWKxWvJczosxg==
X-CSE-MsgGUID: dgRJS+uPRCiA5OUYWg0xsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91188424"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="91188424"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 21:42:04 -0700
X-CSE-ConnectionGUID: DktK9mRyRQOgY99NXb+lCA==
X-CSE-MsgGUID: Swo14kpAQqqPKmTSkr+w7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="244561539"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 21:42:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 21:42:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 21:42:02 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 21:42:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdeAZ3bniNKj6hVnQioMblJ5BwIlJfUX+LTVAhoGMdo6zqSXPDLLT7I5VdkRwIWYVgLysSn+hOtBs3SWLmDRy7rK7aiGC4VPdFDIerogGBYYN9pU3IVT92H1b7g46Vq9VW+Ciw2GvYYousWPOXvW3ftyUA7jE21STh1JOoGjiD1kqheJgPhd6z9bNIvDQiI4vDfHKfe6QUP9LBqOfMQaC/yYivPGsRDc2M32q2AWgqaNAkrmGSdcDazJ6qGoZMjhZLC62yyEAD/DAKlngQNgivAwjykNNo4WCJJxERMXsKNcVNKcNuMaoAueWaYLkcwsi7kF18dSw6v4r/NOj4aQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A/oBSC3IBBNJz+M7XzCbbaQornNeoxPQJS4Y6oANvA=;
 b=i2TFd3PRcD6wNWVciJ/uPnGoPrg9C8R2cFqjLSmuyQtIqYwmgoighKf5LZv01ohehLVPjDigPEJxtyuTqViNn5XpTwQsGXolKwDSkLcACvDFoGDCgzh0WVU15aQbUIkRH+zW6Le1tvmWE0hP93M1bfVWtbNiEC4UnZ+HW9+rUO3UFXrlTharra8iRne9Qhyoy1H7CWsDSsyGpiJcbx0On5oqIFAmB+pYbkv6AW/oGb/fz90WrampfIHv6rqvMyEIdHwJaaw3ZUJ6VnDbY6gC0Mi56vD1cCwskMKpjDDlg3/I+PFtEcGsDojlFbaBE0OQIUn3pWbc5kbjPsdZtb9lCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 04:41:58 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 04:41:58 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Eric Dumazet <edumazet@google.com>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix missing priority
 callbacks for U.FL DPLL pins
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix missing priority
 callbacks for U.FL DPLL pins
Thread-Index: AQHc3I3tpwgIsskqJUaVE9frKmtd47YkjzxA
Date: Fri, 29 May 2026 04:41:58 +0000
Message-ID: <IA1PR11MB6241A898FBA41ACC05918F788B162@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260505125108.2019998-1-poros@redhat.com>
In-Reply-To: <20260505125108.2019998-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH0PR11MB7633:EE_
x-ms-office365-filtering-correlation-id: 91e3edd5-cb47-4c39-f451-08debd3c9e5b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|38070700021|56012099006|5023799004|3023799007|11063799006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: Awl3oC5mWTj1Pf5b3zgkib8D8YwcOS3BJrC2lJFcGXDvnGPi9MPZIr8TKwEqWOykz39Xx2lvQKQ/4Wa2sgDLIM9moZLN1E/8OczbHW8ui0SNotizNWcBCP5XczqUdmUBUi9PmWd8Muc65w6pH7noJnqz0rAIEGGMp1M7u/IYVRsGoz/7Fv2Y6IrTiFfnatQZefdCCRpNV8Flej0R5yoEty9KUspAC5jQ1oi4G/F7HDshW5hr4a92PRhkd1n4QNGUX5pY7DA4gBgDxo6X9Rr+8yqQO5lIKAyYnqsEQkAJQUDh8yBD54ocwCvYpF+Ap1R6J2F+ZCzHgl274rjPiPVAiD2LtZjDWkQtH0tt9yJDZcyvRW0VpWscwhEGyG5VBaEbsUlQUupxfFirZI30u9tVhKCgGbHuPbTJxGCLLE6b7LaeWdxaVgEkbTd37JjrBQTHmXaugxmmvEiNjWgaYXjJuPDCq3K9Pyez+gx1TmufBg1mtU4KQy0DnRXzn19IviRoDMt5uvBCfQYjA/4b+EN6TE4nX/01omNQxJE+RoBL2uIH5WJ+9PPWc/Dy8qMTOKdIiuMvf782eLbQSkmC/8V3u/e13N6iNlNFRH70m3aDwnRDhPi2pjZ5RUQe5oG9THii5jff5PAY+UyJjEgp+SVOB3JkWl/Zn3onAgW9ykBVUHLVzuH2PFmJV4tRASYQ+OLHnLTymesYERUDiHfMPvtj6Aqq56Zx88LCRoFSJZZGkSQgpuwSFq/Jy/zwF1V0RME/UQ+vU9/kFXj4rKdCoK6eVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099006)(5023799004)(3023799007)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NSr49L0gNAEGpCdWLy/A2YbNTxxc/n8nIEKnogaRmm9kOLSuu0UQyhqUvay4?=
 =?us-ascii?Q?WurFiTz28R+fUXcVc5hU9jRoy9YBIMKRh412nbKA+JFww+IKlFNg5VMny4zc?=
 =?us-ascii?Q?zvhxTUoulmVwyI4iQBZ34D3LEJ98jBIE3cDFBpf1/OSFtFX28gcUFobeCqHX?=
 =?us-ascii?Q?6zga1jnuz2XpSz3vpV3W/Phc2IB35fL+JhOqzRMia9dkm4pdpWg0qZ8GsaK7?=
 =?us-ascii?Q?ubBJ+cpvP+IbuCxokVUU75LBY/Ke4OdEi/ldi3Cbt90zg2EmBxLSStFfpVbl?=
 =?us-ascii?Q?CuBYc6zRbDj8XgJd0F3Ai623kH5szAxqUolL5t1TaDoj7WoT1tPTcJoS/ML2?=
 =?us-ascii?Q?ulmGsA78Vk255ygeW+cOXI9rr/aB22XiL/UgCD6i0Yvjt2Xwd+PZvWHcmUYV?=
 =?us-ascii?Q?4u01qcTCM5ogHHH9usal3cX+efTQYvM1MTmvxX+IhOljxI15LIY7nWdSjflW?=
 =?us-ascii?Q?HMI+L//FJ/DG+zG9qRC3x74iXTBgjlqkYTcHKWngS8pV91L0engo87gipKeh?=
 =?us-ascii?Q?nnBZt9wrJHH2FOR9WCiH9ODv6QhY64uCZFXqxJbHqpr/zYDpmqQXE8MtP0pZ?=
 =?us-ascii?Q?55RGGvirWa27jyDOwRw6Tqz4MLgrt5R+Sh4Crl5Bc40+Xd4NX8vH5HssqVkq?=
 =?us-ascii?Q?Td9dodk/7rhBGSbqFGFHpGY3lJcAMtreZfipKE5Dx8P4V7IepybTEP9CtlkE?=
 =?us-ascii?Q?R9cJuckJQxSoQ4mY8HFWhnJANpIihPXJCwhh/B2v3f+WvvZVLBIh8f/4UW33?=
 =?us-ascii?Q?zQwJkzbNhBD+Ku1GBfHYYt6wSmf4fM6c4QgO8vNZwOfFbPAw8inO0MpCEHqx?=
 =?us-ascii?Q?ZqQrrzhvO5m0Yr3KUN9ize2vJPN9iich0yN9vopFAtI7/n+dbPg62kVEg0tJ?=
 =?us-ascii?Q?MdhbsPZ9ioJMSnw1xghIW4w2sxDxHGIOmmTwkNSifZ6DRsqQHte/D9t8+WMH?=
 =?us-ascii?Q?OYPGNtIc2xaL5TCmqQxlk1vWvMmciDg96F+8/Gr+bTtcs99HjTmY/39GDYJA?=
 =?us-ascii?Q?llsvNTUCWBDxW35Rhgh8XuoPefEikRSgnNHXZlXBa5kUPExEMsRAYWkUeo7/?=
 =?us-ascii?Q?TmnBA9TIq9rFac6SGrd4T2fobzJPbUySmIYQwpDZVRIbh+N/sCLxDg7R2VXh?=
 =?us-ascii?Q?E7ZvqM9pnlUaSSdZrs4fcqYHGBgEEts9HJKTEb7sTwD7M79u5OE0AvIIDx0i?=
 =?us-ascii?Q?xHjrLwT0HhnEydBle5MddbCfFFHHc/dn/TplD9vXqsjJ3n64VNAHgjkkYhAn?=
 =?us-ascii?Q?x03DwIugEjtDNYI9sGrm1cCq+AWof8PA+bdCRhT9VWkY+lSsI06DZ5ZEY02L?=
 =?us-ascii?Q?IhGy9eGafhBKpDyAfbaitbddbhLAURrZFAudrcZJDyMUjqHJKOwQIQcSMx9i?=
 =?us-ascii?Q?oRs88r/4qpJ/gpax0sl62E7YE5RGTz7lFl8faIQF1cwlGXCHOgtkmGTlFI/D?=
 =?us-ascii?Q?YLyjaNFZC64273iCtDRNhNeoQ1QK4mQYqUQnis3BIuJC2Ita4Kfk/JJMpZiY?=
 =?us-ascii?Q?4RSdf/KcXtij/eQlmJfIxnvDF1EyKYA3P8VvU3hE4Vb+13QN187BvE2MwHcc?=
 =?us-ascii?Q?4MEfNAOJYjxe1mDDBZBoTsMBGgur9Mjwsqwd5TyMlUQEChJ0nahtgn2DhBCx?=
 =?us-ascii?Q?BoNs4TL52693ndy3WUu/KMmXBEfCjj3nCYEpDX5MMcRmsM8xv4a8EOG6PKLV?=
 =?us-ascii?Q?uLa/RfaqLa39oLJKB4pZCPlYPhtYhQ6cVPsx88NlRelX/cY1qVcaOHk2k07V?=
 =?us-ascii?Q?chwlLu596Z9ZliWqY25uLnF5XgNqeSOjXIe2gXgdlzXxC3UXgOwKvCigVKtQ?=
x-ms-exchange-antispam-messagedata-1: 5wDBzBxCnU0dfQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pBKapxV87ZUYZ9RMki1A57DA2bnJyhzLBmtfKuOH5xlJUFX3ZzNiEF7KzTNfxvY/+m1eDHNDlTaPek4tn68nY4hearcMjUhUKvf50X1P1LZvvfl0+Xa560yt6dj/zjW+lif2fuFsV/DCeEuesQyjVEesSY/SXMWykIth3B9ASFDP8Goft5+E/telZHW4tTWpX114FeXIrTDP8d3muxptdFCHcMYWZqwga2uKhi0B6dqKNYKlw4WbbfirHyVKKibGMFifKXIF0qSuvxwZ8V2xWRC7opsKqKMP7HOgIgMSrte2XHYPmTwgfT5nj276EWh+73Y1ePvFfOtlGd5GqlU+0Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e3edd5-cb47-4c39-f451-08debd3c9e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 04:41:58.5222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDBmXoQTf3B02S3l/tYTu90yGx0siwsQzZ8Q6Wu86cGfYLKdpFELbFle6YGMclUtJk66biA1LDDehZKw6EReEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292971-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 68D785FD25C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
etr Oros
> Sent: 05 May 2026 18:21
> To: netdev@vger.kernel.org
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>; Kitszel, Przemyslaw <przemyslaw.=
kitszel@intel.com>; Eric Dumazet <edumazet@google.com>; Kubalewski, Arkadiu=
sz <arkadiusz.kubalewski@intel.com>; Loktionov, Aleksandr <aleksandr.loktio=
nov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Nguyen, Anthony L <ant=
hony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; intel-wired-lan@=
lists.osuosl.org; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@red=
hat.com>; David S. Miller <davem@davemloft.net>; linux-kernel@vger.kernel.o=
rg
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix missing priority c=
allbacks for U.FL DPLL pins
>
> The U.FL2 input pin advertises DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE
> in its capability mask, but ice_dpll_pin_ufl_ops does not provide .prio_g=
et and .prio_set callbacks. As a result the DPLL subsystem cannot report or=
 accept priority for U.FL pins: pin-get omits the prio field on U.FL2 and >=
 pin-set with prio is rejected as invalid, even though the capability is pr=
esent. This prevents user space from using priority to select or disable U.=
FL2 as a DPLL input source.
>
> Reproducer with iproute2 (dpll command):
>
>  # dpll pin show board-label U.FL2
>  pin id 16:
>    module-name ice
>    board-label U.FL2
>    type ext
>    capabilities priority-can-change|state-can-change
>    parent-device:
>      id 0 direction input state selectable phase-offset 0
>    /* note: no "prio" between "direction" and "state",
>       even though priority-can-change is advertised */
>
>   # dpll pin set id 16 parent-device 0 prio 5
>   RTNETLINK answers: Operation not supported
>
> After the fix the prio field is reported by pin show and pin set with pri=
o is accepted on U.FL2.
>
> Add the missing .prio_get and .prio_set callbacks to ice_dpll_pin_ufl_ops=
, reusing ice_dpll_sw_input_prio_{get,set}. The same ops struct is shared b=
y U.FL1 and U.FL2: U.FL2 (input) delegates to the backing hardware input pi=
n, while U.FL1 (output) does not advertise DPLL_PIN_CAPABILITIES_PRIORITY_C=
AN_CHANGE so the dpll core capability gate never invokes prio_set for it, a=
nd prio_get reports the OUTPUT sentinel (ICE_DPLL_PIN_PRIO_OUTPUT) on the o=
utput side exactly like the SMA path does today.
>
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v2:
> - describe the userspace reproducer (dpll pin show / dpll pin set)
>  in the commit message, suggested by Paul Menzel
> - collect Reviewed-by tags from v1
>
> v1: https://lore.kernel.org/all/20260504121603.1702674-1-poros@redhat.com=
/
> ---
> drivers/net/ethernet/intel/ice/ice_dpll.c | 2 ++
> 1 file changed, 2 insertions(+)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

