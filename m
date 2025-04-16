Return-Path: <netdev+bounces-183462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D80A90BC3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F9619E0235
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B9223719;
	Wed, 16 Apr 2025 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mh3vLNeE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6A29A5;
	Wed, 16 Apr 2025 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829869; cv=fail; b=Q8kyMpK6vRCyuUrGAAlWBIw+1T2AJhC5WsVc3NLwLXvJo6b0zVSCk1H22Za05OK9XGBaFvUqyh3Lc0o0X/qcLtSQwjpNYyiDk4zGkDRBrabkm8sJRkplO2BV14qOtQ9Pfm57dhk2GOTrINm6Wjk63AMJL4a8Z18/1xb8j2iZ3f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829869; c=relaxed/simple;
	bh=uL80oCURDCTh0+TCHS+XtrZZvfqO/KUmdTjdKcLXc+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XAF/JWlPx59K+I54XFk04Dh9RKr5PXezsGDi7wOO8bVKAaOFVxoG+Eik43Wjbj0m628juH0SBxqFwsnmhxvlH9VWUGX4d2TDuGF1Ba3n/JcZ8jvS+KNOqoQ+/nfhwEUnUGwfNyBerIq3eN27QWyOnGbzdLTOePPBIS8PaNf9+Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mh3vLNeE; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744829868; x=1776365868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uL80oCURDCTh0+TCHS+XtrZZvfqO/KUmdTjdKcLXc+Y=;
  b=mh3vLNeESpjQ/4EtK1NEG/cW+7xNRYswanhNsv+NC+cm7ubSL4VQCmrM
   WmjF9eU4u4O392fc1IewM8wuK/D7bzkDQFAjsxUkBZ+wJwZyNjazDZj5b
   KI9qqTttoPbjwgxokbptkd+HQzuLfvl3L6adqDPoYJxPdWbjZSu57XWTS
   tkt5RSPgF7itxP1vcpc5PpG9Fspl6HDk7cPoW6JOQT0jO8UglqpYmIoo/
   icjqGCoekvfRlloi6aOx4hX/OFxYk/iMcH3xhYFffWe7W7mtToAlubDCk
   yUMSxATwzzjH2L6Qsu1QhSOtFywo3ODwGEgj4Xxb7PN9/2GrHjNdGjUvM
   A==;
X-CSE-ConnectionGUID: iMgoQVmyRxuAaaw2x955aw==
X-CSE-MsgGUID: ogpyAtJWQ2u0DtNeBkq/QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57768490"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="57768490"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 11:57:45 -0700
X-CSE-ConnectionGUID: 6vxgg0ZuSDOKtLBsvnFZwQ==
X-CSE-MsgGUID: t8YqcQdXTlSbXHutHp8i/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="161610551"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 11:57:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 11:57:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 11:57:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 11:57:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrLWMQKR6hytjb7xn1Cnz67QMmTvweXO8BZ8FwTGr0LDvq40Ag3hhd+CB3AatSpK0kET4FortbyAQCTP2E85Lhk7Qh/ruYYkbFjbpVWg2mUy9UrTysH23eNvy49ZtxjqNq7Q28NA0nbessyZ20S5ZrxGBphXJ/2Lz6HIv7SFY7p5sspSF0L2MkeFP4vv2fFkk2xx/T0tx/a1S4OFepLyLkWWVEEySY08OWdIz4+PAskNWOd5/K9Vx/P6mm9L//6dluX80BZM7ua5PP4H9Y3L468dBPhyjRgLWpotUhDpownAY6+0AiL2WxehHW/jUr6s1CKNOnKMUp5GG8es/r3poA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL80oCURDCTh0+TCHS+XtrZZvfqO/KUmdTjdKcLXc+Y=;
 b=Cc1y5UINOL8V0HjJkQBMhmohyZ11VUyBxK4ArMf7gv+oT9YWZzxZPfpIgXrQq8eCrxb09tobCP6Hbk+8khjulOa6jtxelqJWGHjpfdA4N6Z0qwU4mAfDsLZOEn2EVzTeJL3B57MjWu8FDqSXwkP9oth4Vvug7DSVBRlRbsTlg5qDhfmYD6L0nOwCT8xy1TRDBNgP5aDPSip68Uma9FgZVcnZwMyvVqg/T3kEvYZso0QYFC0r+QPvXNPUo16XIs0HROL9OjjdnyIjzG82+HwArF5WO3JbCaf7l7nPD293g9o7iGQkEf3jnO7ZzsDv0/yzhC4y/qBULdILX7H+1wmiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6126.namprd11.prod.outlook.com (2603:10b6:8:9e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Wed, 16 Apr 2025 18:57:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 18:57:35 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Kees Cook <kees@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>
CC: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, "Dumazet, Eric"
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang
	<wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Jeroen de Borst
	<jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Simon Horman <horms@kernel.org>, Geoff Levand
	<geoff@infradead.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Praveen Kaligineedi
	<pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, "Joshua
 Washington" <joshwash@google.com>, Furong Xu <0x1207@gmail.com>, "Russell
 King (Oracle)" <rmk+kernel@armlinux.org.uk>, Jisheng Zhang
	<jszhang@kernel.org>, Petr Tesarik <petr@tesarici.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Richard Cochran
	<richardcochran@gmail.com>, Shannon Nelson <shannon.nelson@amd.com>, "Ziwei
 Xiao" <ziweixiao@google.com>, Shailend Chand <shailend@google.com>, "Choong
 Yong Liang" <yong.liang.choong@linux.intel.com>, Andrew Halaney
	<ahalaney@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] net: ethtool: Adjust exactly ETH_GSTRING_LEN-long stats
 to use memcpy
Thread-Topic: [PATCH] net: ethtool: Adjust exactly ETH_GSTRING_LEN-long stats
 to use memcpy
Thread-Index: AQHbrmtesaH7QN6MtUGVItUSQ5UO8bOmABqAgACSqICAABMdUA==
Date: Wed, 16 Apr 2025 18:57:35 +0000
Message-ID: <CO1PR11MB508977671F23B9E45863417DD6BD2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250416010210.work.904-kees@kernel.org>
 <20250416110351.1dbb7173@kmaincent-XPS-13-7390>
 <202504161047.79ED8EF5@keescook>
In-Reply-To: <202504161047.79ED8EF5@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DS7PR11MB6126:EE_
x-ms-office365-filtering-correlation-id: ae77acb5-671b-426f-27d1-08dd7d188d35
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0/Z/n/h0xqPoF65C9HF3IHKntbQk+OuptpdI3Z/kf1+zb+UdKzqG0U928xve?=
 =?us-ascii?Q?+lCe16UmePTXJBIuQ9QmRt9q/emdOOHzhHEzWTIrFwhVHgztlq9HlJKCxWBA?=
 =?us-ascii?Q?BPYXNOYT0F21jDS+tIZfdhbkEgoV+dXqoRVGS07QDrOjYYl7v414kJUk5hF4?=
 =?us-ascii?Q?bKOx6h5o1Qv4eAYFjeKCR1qsA/0+73ayWXp8Ltu0LN6LQoQxNGr1ZtQ7HAXz?=
 =?us-ascii?Q?H6LHzlNVocCNHH8HPi+TgSJBWJKln9Ibi6NUt9L7offTPiCSnTcBBOvu8vq8?=
 =?us-ascii?Q?dr3UMczrurSXO6aaxRIbmMBK2f6rNGB141NmgLYbyh9W6ARJlrt8FzFZOP5z?=
 =?us-ascii?Q?BXBtO62yk1B/zDIO+ZefEb2Hu8ctbLI0Xp+PONFRYPiMrNjjChTIhcsRkbEH?=
 =?us-ascii?Q?Jk/hRzDzGqkl2wyNhOgoJ+038YUhGVM1Tdn0FPuCiZFDF5cP9MNou1aS84tn?=
 =?us-ascii?Q?WXN42FGj2eFT9o7GiYlzb7ENFTHFKvZEekxrh779HVAaeCBmoF6ISv0rn/ar?=
 =?us-ascii?Q?70iTc/nGhT8++3/NoujHnRiQ1orH+rAWXJg3+j1ejDINSz25o+6j/cI8uP7N?=
 =?us-ascii?Q?YJj32nOjwJ1iW6aH7PJi5BwC4XczWnb6Yb0vVq8xKTYPmq4cqHZk03FhLp6m?=
 =?us-ascii?Q?w8Jkvin64p3mXdVolxXsix/BMtR9+SnKkQt3mUJiBUOA8KltMdMKhgpFC5WG?=
 =?us-ascii?Q?NGbdeg/W8WXIU5sAJTp34skYQwhvR4K9USuCtMt6y08feKcizLTMXIT6stX2?=
 =?us-ascii?Q?cvhmfkID4u+sWDvbvoeqzlJS/5EqH6TEVSQtbZwaMB9CTHWIN6bHuA42/lvQ?=
 =?us-ascii?Q?EGMo/obxea5WA1ECjdpY6dL5ngQYo21jHSK1/R0sdxW9MYrcDtPgt6yn2tWz?=
 =?us-ascii?Q?ESBThHptZgPvsnkhoMqKzulHjMCKjBpo/2ZOx2AkLGJLo6fsdgLa6xYElSWF?=
 =?us-ascii?Q?PswPIKvz/TuzxHjCzhEdObtL0ZPV9IUfBDsUdfkXKLiZwJqsrdIjMgM4SM4S?=
 =?us-ascii?Q?PAeDbJ1x3JbLxbjk2qLBaPwrYItvaU7FAbLr+oxzbKAmvAsFOhIe/nln1c7W?=
 =?us-ascii?Q?pOnxHSsQRubPKI/f3FcHGbulqRqdlgU9CJOX1/XLUspBUk7IEXzz5ZdGncF8?=
 =?us-ascii?Q?PaVGOcy4LK6q37BNwfHWROItiNqhGQN8DSc7DOQKWfe7HLCRVaLFmrtlyPBo?=
 =?us-ascii?Q?6jDaQskCI/AN6G7aavz49JFlpfO4aHWcUUcTUJgbB7V7cwJCX+UFIKrD7p7L?=
 =?us-ascii?Q?HlQ5Psmy1mDMvBGoUIR740Qv9fo/UY38+0vwQojdMzBbOD8PmQw/oNChuzFc?=
 =?us-ascii?Q?jJ6bdC4fabq+eLEFHC88eXh2yQBt3f/1UO30tB8OZnzSAuV8zFylFmcbZiLT?=
 =?us-ascii?Q?VRNJWVhGJ36ISrUHEUCs5+l5NnXrbnOlFz40mdsO37w9unW13DXVF9EcS2xS?=
 =?us-ascii?Q?6ar4ZVvbJ0sK3Ge5oFvYm0JABtYF4us4rBUkvrPS31cokcntXzAZew=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a9g2JKldIbjw5+mhIum9J5yEtg5XaojROoLMnsFbzGPZs+EULHzI3gT2F1cY?=
 =?us-ascii?Q?7+Oip9C2MD8Gs6PRjBGYjUjrskSp1hEOcbqf3CbqWuGMOmSCarEM4EAE73U3?=
 =?us-ascii?Q?X/XJzCZed3i0dURlKZarR8uLo7PROSKoPIr/cLTKgn7hAlB2Uu01wD35D1CJ?=
 =?us-ascii?Q?2TfyTm15GP0c0BHnwSwmQdJrfRS3NMh5EifFv+fIccSiwCOfb20pLZxA8r5d?=
 =?us-ascii?Q?Xwwi+BM+K8dwfHOnQG/2CAPb07Lkj85zRd/UgD/zZ+6rRh2P59V5pIgEIUGW?=
 =?us-ascii?Q?NNYjZzA/0CUToo+RllRX7J8fr4UqxrMT25Lp8CzELflGacZMcVPIz9iBXnzN?=
 =?us-ascii?Q?qxTDq/m+iK/ESDezYb3sWEUITi+0KkGyNAcGilrtWXC+2FOEWwb5rOLmrPZR?=
 =?us-ascii?Q?eBEHHFQ/Lu0SuvV7+e51bzXm9SiydIc+h+qbMrRbkwyP1oIVeZ+P/+tL26JY?=
 =?us-ascii?Q?TQgDItTb0jwD1WP6KPsDmoicixZPfrFwFNmvInRw5cj+nWx4gEmH/XARNmQQ?=
 =?us-ascii?Q?S4fZHYhYkwRy6x4jVuGNWkk8cK9L6lqY0yNQtKmL5R4Kj3r+v/JqZEJ5818p?=
 =?us-ascii?Q?gW3jRSKdHTu2+fM4FbmaM6LM3Z9sL8tU++ZSJIqwH5iXt9zj2q02aL1rzsb1?=
 =?us-ascii?Q?t2jQsNfrpgbM21/5Qrb7qsD18WVvBH8PfJOWiN2TgLyE5PaRvOJQNG7Lr0F6?=
 =?us-ascii?Q?1Ub6gQWZuOcYl2nyIrIupa9dfXrdctifApWQRCLDdQCjT7kwalodPvaCLiv9?=
 =?us-ascii?Q?M9jv9i0I30Pl5Wl+KPqh3WvK7+x33xTvrVABfyntb04ouGAV/HM8BxOkty4V?=
 =?us-ascii?Q?kFWXGOaKvxF3yGDama6Vmx+KigM/JoVrIxZXwq/tKD91sHGjvbNplw95lw/O?=
 =?us-ascii?Q?n6eVb1QymtfxK63w+MM7Xc+N1IzS0dNQkAr4m+ipwSAuEA0TB11SdQjAV+CH?=
 =?us-ascii?Q?LnSZAQOJLni4zaigsm76cM8mHU8LE1noMdm/xtP9MiADVJF/iqQp7g7KtcUz?=
 =?us-ascii?Q?FGV43Y/PhBrKnPHDWKay816RZb7OVf19O/dWZW8GgjMMlKWeCrCNEZFdSuSW?=
 =?us-ascii?Q?PlE6veQjlOpbhMoEgELUmqDiVI3jM6hmX3qHazsxvuAcN8cR3G4I+KCKDKGt?=
 =?us-ascii?Q?7AbJ3gn+BpIIOeHrv1iRrqf2yg7mOytzh8FjXPaVS3l0mdmXKu6DMbcY77Pi?=
 =?us-ascii?Q?nTbn7GWgX7WepQamFpu6xJ+kCs6EDP7SHnMl5ox0a9d5Qe+QOAgN29/qw6KU?=
 =?us-ascii?Q?f+DxNH68UAdnBOHOxOKRy1xi1Eu91IkyrTQxakJUkOtNK0vuLQ3+dK1NMHQu?=
 =?us-ascii?Q?VpZn0fFsTifcHyI+lDuxhR4eZSqamYa6Px6tr4Nn4MMY7gesemyKKBLs4M25?=
 =?us-ascii?Q?oFlLnKQLu3LcP9BmM0zgekjsuyeRqB9wSMBKFGIhZCiQxJbq/OUCLAVLzKOB?=
 =?us-ascii?Q?T5g4bt2+bHvJeSIVDnc+8ElRSXLK7n/hIFAjM/ynRYgE0lYpK4doIu5Ya1UR?=
 =?us-ascii?Q?dxXJ/H4X59xyd8/fMaJ5a7J1k9t6qQ7WFtQtPtoJdA42vFoalzNGRNawXEP5?=
 =?us-ascii?Q?wXCNp6Pmm99Op4Aq067dKV1KLUHF+RGR+hBuDnRfKf1bxpmM4+f9w8iUdUWy?=
 =?us-ascii?Q?Fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae77acb5-671b-426f-27d1-08dd7d188d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 18:57:35.8124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfGr1iG718iMGTiHMeRWed+m1xb0TI8X9w3J2yHMT+7ty5NfoVc/nWr2R0aM2+Q61MM/+SlMzb288Sl/7tpAqUoDCAwJLyrnk3rkEDTsmSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6126
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Kees Cook <kees@kernel.org>
> Sent: Wednesday, April 16, 2025 10:49 AM
> To: Kory Maincent <kory.maincent@bootlin.com>
> Cc: Jakub Kicinski <kuba@kernel.org>; Andrew Lunn <andrew+netdev@lunn.ch>=
;
> David S. Miller <davem@davemloft.net>; Dumazet, Eric <edumazet@google.com=
>;
> Paolo Abeni <pabeni@redhat.com>; Claudiu Manoil <claudiu.manoil@nxp.com>;
> Vladimir Oltean <vladimir.oltean@nxp.com>; Wei Fang <wei.fang@nxp.com>; C=
lark
> Wang <xiaoning.wang@nxp.com>; Jeroen de Borst <jeroendb@google.com>;
> Harshitha Ramamurthy <hramamurthy@google.com>; Ido Schimmel
> <idosch@nvidia.com>; Petr Machata <petrm@nvidia.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Simon Horman <horms@kernel.org>; Geoff
> Levand <geoff@infradead.org>; Wolfram Sang <wsa+renesas@sang-
> engineering.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>; Pra=
veen
> Kaligineedi <pkaligineedi@google.com>; Willem de Bruijn <willemb@google.c=
om>;
> Joshua Washington <joshwash@google.com>; Furong Xu <0x1207@gmail.com>;
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk>; Jisheng Zhang
> <jszhang@kernel.org>; Petr Tesarik <petr@tesarici.cz>; netdev@vger.kernel=
.org;
> imx@lists.linux.dev; linux-stm32@st-md-mailman.stormreply.com; linux-arm-
> kernel@lists.infradead.org; Richard Cochran <richardcochran@gmail.com>; K=
eller,
> Jacob E <jacob.e.keller@intel.com>; Shannon Nelson
> <shannon.nelson@amd.com>; Ziwei Xiao <ziweixiao@google.com>; Shailend
> Chand <shailend@google.com>; Choong Yong Liang
> <yong.liang.choong@linux.intel.com>; Andrew Halaney <ahalaney@redhat.com>=
;
> linux-kernel@vger.kernel.org; linux-hardening@vger.kernel.org
> Subject: Re: [PATCH] net: ethtool: Adjust exactly ETH_GSTRING_LEN-long st=
ats to
> use memcpy
>=20
> On Wed, Apr 16, 2025 at 11:03:51AM +0200, Kory Maincent wrote:
> > On Tue, 15 Apr 2025 18:02:15 -0700
> > Kees Cook <kees@kernel.org> wrote:
> >
> > > Many drivers populate the stats buffer using C-String based APIs (e.g=
.
> > > ethtool_sprintf() and ethtool_puts()), usually when building up the
> > > list of stats individually (i.e. with a for() loop). This, however,
> > > requires that the source strings be populated in such a way as to hav=
e
> > > a terminating NUL byte in the source.
> > >
> > > Other drivers populate the stats buffer directly using one big memcpy=
()
> > > of an entire array of strings. No NUL termination is needed here, as =
the
> > > bytes are being directly passed through. Yet others will build up the
> > > stats buffer individually, but also use memcpy(). This, too, does not
> > > need NUL termination of the source strings.
> > >
> > > However, there are cases where the strings that populate the
> > > source stats strings are exactly ETH_GSTRING_LEN long, and GCC
> > > 15's -Wunterminated-string-initialization option complains that the
> > > trailing NUL byte has been truncated. This situation is fine only if =
the
> > > driver is using the memcpy() approach. If the C-String APIs are used,
> > > the destination string name will have its final byte truncated by the
> > > required trailing NUL byte applied by the C-string API.
> > >
> > > For drivers that are already using memcpy() but have initializers tha=
t
> > > truncate the NUL terminator, mark their source strings as __nonstring=
 to
> > > silence the GCC warnings.
> >
> > Shouldn't we move on to ethtool_cpy in these drivers too to unify the c=
ode?
>=20
> I decided that the code churn wasn't worth it. Perhaps in a follow-up
> patch if folks want to see the removal of the explicit memcpy() uses?
>=20

A follow-up seems better to me.

Thanks,
Jake

> --
> Kees Cook

