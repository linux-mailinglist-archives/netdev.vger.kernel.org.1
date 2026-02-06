Return-Path: <netdev+bounces-257617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDj6Aw8Yhmk1JgQAu9opvQ
	(envelope-from <netdev+bounces-257617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:34:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E02D10055B
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 17:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFC1E3019FD8
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320D132AAA5;
	Fri,  6 Feb 2026 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EM58Vijd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC851E487;
	Fri,  6 Feb 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395658; cv=fail; b=X7IPhTq/PhWht3OjQLp5zPwY1FxuP8bvoPo2XQopP0Tuis2eNyssD1RiyAe2U8rQ/MYlgqMeL2z3EjSbxWpCRdUQwTOL2ujJpnKze5Ln/9cDBA+1+uEiqzQ6oRdTc1Nx7mdmVKgGVVpZmDS+1Pjy4lwI4gNRwWblL2LfzTS1Di0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395658; c=relaxed/simple;
	bh=7Hezb4FEIFzVSjuBfYc9CgpY45VH1QHK087BOOXjfu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HTsj0mTYHIIafCAquU4UIjqgGplWqvtratfZIPxy+xyhCOSB2ySg/PxRTT13U4qugmf8hOmJXqxraAv3qhulqVVR5RuUj1hrRseSwZ4bps80DK+jRaHlRetpfKbGfRZjaZxWp7iPo4Fc7SZb0GvtfaroDhx22OlV549cO3XKL34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EM58Vijd; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770395658; x=1801931658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Hezb4FEIFzVSjuBfYc9CgpY45VH1QHK087BOOXjfu8=;
  b=EM58Vijd/NxJx318F6bByzvQZVjYfdALwem/nG5CtdXtOdC2NBAkTOh3
   QD3OJci5VeqDUMNUpGCC/9UrRAVz04EAnJaKCQ7CT0uGVln6Hp58wdVkn
   i7Krptw3VPf/I6Do6HjLhMxhxyQKhu8SKyNiYPLPQg6rOTR7D9MkeobGm
   Xy1jutlUxtZMGyuyeQnB2XvtvoxzkYii8x8F4GEw9nw9/S792X6rIa0d+
   K1/DP4Wb6QpTycjbdk1njKXEBtjcGJyB+BspXTKs47oovs4HTL5J8UDMQ
   jlXSBZpeOEdBnpVw16diYLj6YwqdsV57Ou7blCL5Y+qAmMe+mp2jkHVyF
   A==;
X-CSE-ConnectionGUID: BD7Y2E8PTDKIgoILafnJNg==
X-CSE-MsgGUID: BcZsEebnTF20WA9lMyhqIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="75226620"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="75226620"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 08:34:18 -0800
X-CSE-ConnectionGUID: Qf5LmbbkSeKgHfqXwLMsZg==
X-CSE-MsgGUID: 9PhHzdvmSkym6K4uHwobqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="209999633"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 08:34:18 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 08:34:17 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 08:34:17 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 08:34:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdKee9qR5PMnkgs5TrJ/RQwIcLE7JtCGMRVBosBV0os5Hq2yUuUlMoZy8s1AdGca5tUdt43TsXtjPk4q1yMfgmLrGFbMDymlQoHd/9jm/Jilp7+p4QuPqTvStQGgKlPvLCrg6CXkEMZaj4egF5beV1F4L6VOw6Ve89HFFodztTFhjoIC1yj1cGcQQ+B6yrlj2kROuVdN42Gj21RQMAnQhc3VmsiEeC3z/jMz6hqKsCu+TazBCavU97Wrgu9GsLUtaunfQJmwAmGiqOYPru4SQE6ZMkOQ7Mkqb5/Alu+mn+OlSU0sD1LDw8qbjXNmxjNyFwXfDXQJGGaVgVly5DUHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+Fky5JeAgnzE3wHY73LZyuXE/Bogv+Y0oxcTYqgKQo=;
 b=eOevsG7756tdZrd74mA2+AxHa/FOTLB3KButPLaz/CROSFtI0I1AyXRQtlo5C0bP1KyKwKS9XX6zm76LyacEK+PhtajiVj142oSbabjig9lAe9HSJ/zcpiYjbeFWc1HeituZi7PpcRBwhfwqfizVPC8Hu+UNJgCXwDNVtVXvZ8RzV5vjYDX8UsEduxEAzhmFEXozpDSC5C/HFxEdDqtMAO5IkvGyvGyygQA7kkPW3ii+BLbN/XgFc59rdg5PXI/KGfjJLZV3SgRWp48hwjYnJeABpVYOqhZ7UxTCrG4Th4zzQlBNoarf7ZUuxv9DFgSnHiBGrHGsSfoQsv+roo0lVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 16:34:13 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 16:34:13 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "Keller, Jacob E" <jacob.e.keller@intel.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, NXNE CNSE OSDT ITP Upstreaming
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/5] libeth: pass Rx queue
 index to PP when creating a fill queue
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/5] libeth: pass Rx queue
 index to PP when creating a fill queue
Thread-Index: AQHcZTX0SEMd24M3Kk26QrWd3wj0wLV2QkEA
Date: Fri, 6 Feb 2026 16:34:13 +0000
Message-ID: <LV1PR11MB8790C75AB895620BC6192B619066A@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20251204155133.2437621-1-aleksander.lobakin@intel.com>
 <20251204155133.2437621-2-aleksander.lobakin@intel.com>
In-Reply-To: <20251204155133.2437621-2-aleksander.lobakin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|CH3PR11MB8441:EE_
x-ms-office365-filtering-correlation-id: 0502c7d9-c299-423d-1164-08de659d901a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?1PIBOqjMXDarDkE1dbzNAzBrll0wTxCRLnX4Dkext5wjFgSUG876cm//3yZX?=
 =?us-ascii?Q?AL0hdWATnhSzNM64CtYbHrUDuwJr+A7ZfTW35MWKLoFgsKhtlY6G6mX1ue0s?=
 =?us-ascii?Q?wetOc64xJ6OJnuQwIlTxW1aw7sX2AF4w5PdMc4VJFrnuNLAdUyd06AmvyYUS?=
 =?us-ascii?Q?yj0fwt31jSITNkWVg7C0oL3sf1KTxdOD3/7x1oPhUuVviyDUYyYlPrFmgdsK?=
 =?us-ascii?Q?gE8YedogfPPjTZujpRYunzkFlWuWjRfsLZDtBZXhxIU3dKca0xxt8nuyHvxn?=
 =?us-ascii?Q?mOqIDnAvDej0c7CjFRuWhqBE5vl4xHKU22Vju5+WEE20bKkTegPcRFmePctV?=
 =?us-ascii?Q?ayEDTUSkM/3Z9NlZ6csnWjx8YlFjuhyYxawqLzs1RJTYk7yR61ztTXzt5Wf9?=
 =?us-ascii?Q?iOmCevqCzvHiRonBN12+5NSWS2+5Hadk+aMAiXs2aSAq9P6/+Fe9sEEu97lR?=
 =?us-ascii?Q?7J6VkBQZKReYRdfVcIPAWrjVruBSMyIeuk6v6tqaHgi6aKQIKfTq59UGTyXQ?=
 =?us-ascii?Q?wbAWISW7b0Zj8D9rtOhkV9MkaEqhIJ+UitiTr3meHrw2a8HSYrvxZJ+lERHV?=
 =?us-ascii?Q?F0Jc28ndLD0AMsxQ0eaZmWDnoHuh3URLWRIQ6gc5A+Ye0o2wKT1DuWwiNA3+?=
 =?us-ascii?Q?YW489P0zYXn/xRfSanVaXr7diGqat/q1MTrfXAm0uQk5h0vT8NQOfEDsVRXG?=
 =?us-ascii?Q?3Cfvk6BL8yhaYuYhRsP75ceQJ93/57vq9iewpvIp0LUprrePj1mfchpyJJLX?=
 =?us-ascii?Q?7zfRvxs2CT8Vm4zbROdKb3rHzCcy+29C2njVf1s8vX9ZHpRkLCzdT5+7C3Af?=
 =?us-ascii?Q?Qxo85Ac8/t1cd8RFyIW4Snk905Adv0CWYxYRvMTqsce1GVXOxGFWly38r+n6?=
 =?us-ascii?Q?ork7LQbsTtyUKoxvr5ztjH8o0lLBAJxLP7eXY3SmbkKWcGXe/QDQ8P0yD5oW?=
 =?us-ascii?Q?UgxY5DIPH2qpOlO3gZkFj+PVhxC3g04w+waOG7Usvh99bNB4IYsKV8Ua6mu+?=
 =?us-ascii?Q?CXhaDeObhx81PeTTdrySWLE22UcCtFMZSwPsfMgdtsytz+Lg7Fc5VYaKFuSL?=
 =?us-ascii?Q?HbeClDGRxs9Txb+Y8tGHuXqLiLDo803ZPfM2N2rLcmUbYQcVDWpe3zpU/7DG?=
 =?us-ascii?Q?DcZrUdVwQCUzahcMsUP4ZiTF55rjJrDSV1AVvTlhkRyVb3NV5P+7azGrD3dq?=
 =?us-ascii?Q?UhvUDTpQTDmYR/hofFwKeq+3Biku+Omq0N1zN8mjr2ddPOYBXmIjYaFS772H?=
 =?us-ascii?Q?Aen+cTRT0CeYyO4MjJoapoILPIHBo99a0lAiUuEhcicbnNeGmfMg+HsI2sdQ?=
 =?us-ascii?Q?s+86HN8ExoO3VYb4r6c+IZtThFXepx55GzcRwsUW8hRCu5VO3eyCZshx6tj3?=
 =?us-ascii?Q?rfR/MYQcrBVOGu7AHMOIGC3MUqyWAR3r9zKz/W6Ou0RSkXLLIVqzUiTJ5eL4?=
 =?us-ascii?Q?uhnSnzTvGlkgnBhYkRziPWby7xTA+gCeOllPekZQC4GVUtypqsQzuqF6CBrq?=
 =?us-ascii?Q?VKvDE1E20CbDJLN0yXFnQ5ks2G/NKpwONTaZALlg0ndCLjECr9UMydtrzsUP?=
 =?us-ascii?Q?qwZOwx7VB/U/IFl26ekeiBWNxXzqP86mOhc9g2iQbAkME+m/NsOzctVlAFFX?=
 =?us-ascii?Q?BEnsDSNHyorafONi79ld/ls=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dGYjy809quEo2/tgpXTuSqjfh8Ec9j19KemPO28/INL4IjtArM1VNKD5Mhk1?=
 =?us-ascii?Q?JdE9RpXQNy1lHt6E7q4D9TvECqDEoEwKB6iukBjkHFrJdPsnaFjBxl/F3osv?=
 =?us-ascii?Q?3g/PzPvYQpyq4wMe4xmZikCAh5vj8QCUKuWhW0jscqAnUVHjD8R+7wV7TkvJ?=
 =?us-ascii?Q?amh1O/mJ2NIwIFePuZ7QLeLVHB7RNL66I7kRCI6Ofr03+FJ5Wv+CJNwmbOxI?=
 =?us-ascii?Q?BCbMZlWQFY/rbkGqg9EqR8trPups1Gyaxu8XoPQuywDkpZfssXTTy8jY+la2?=
 =?us-ascii?Q?e/yE7eBBQ6+Famw2EnOHzKLmVK5PF8bVX4UF3QAikt8JIpAeX7SuMDzjqCBJ?=
 =?us-ascii?Q?SAjF+qzd/sSp+Nv7TVQ1OMcGn7shmUTGIqwoZGyKOq5s8zKj4GwZIqTCG23q?=
 =?us-ascii?Q?IhJftJUCactPaMrpexpidrmPkXl1pmnsEWdhddmc3hbUOP0q5zQ8i/TEfFHp?=
 =?us-ascii?Q?zjzaznwU0pp8DZcJyTaH3cNOkd2KgrNTSQ6iJTVxcElNbFE5eqAqvESbdQnY?=
 =?us-ascii?Q?eogGgUlr/tG6NfiII5UscLK/MWpqJvK6UuhnusGEYrEHSqWdx48UCkS7Bv8d?=
 =?us-ascii?Q?gyTdCOT/z2fcmtfMRGi83SwsXeu8Mop7+feteCtrNVsk3m661pW6IbYM50Q/?=
 =?us-ascii?Q?kjJ1xqyvMz6B8u6rKw20VHLHTlIQm28Il0AtJBF1hXINxV9aOvf3CmW+MFYb?=
 =?us-ascii?Q?ebsgI/FD+poa4vgTB18ffNhlhZXfu11zcXRox5o3zVh0lUY9+XpvhdY++1du?=
 =?us-ascii?Q?DXa5RI/QKQBYI9ewW5w+vATkwKgmqmLjlFu3kOoThQlxKh5qMqq6766ex4ja?=
 =?us-ascii?Q?d8Vx1fgLJPDcrpsx4fXbrvky1V4dFllptJi16nJdOubdlaf0foxHGltbLAsn?=
 =?us-ascii?Q?BPumD+3V9pLEwFg9drw3nYfFomslWICPKvfFJgxROBmDXJ8QYTd4zMndxxvX?=
 =?us-ascii?Q?BDdzuQOsiNPiDzNOP9RTneMo9w/bsytrOeC02SJLqvzIe7LLus1RJdR76qBX?=
 =?us-ascii?Q?KJkbyfdYvsVhXvwTEdk0fYrADL1YQkBAozfJpkj6sgwtwERLVh28URsdGIiy?=
 =?us-ascii?Q?ouNuKKbcxnjEfFcgGWCCjB7pqEaHNU1+halv2NOHox+8plwEjtXcqkCL6puP?=
 =?us-ascii?Q?aLRU9purJNU64f3dSFYoNRfj1thFVnRxfSsQqwhMNVl3miQu//o++hQSpMuE?=
 =?us-ascii?Q?ohgoV0QWb11Vt+5m1G8uMC0kL3TwDwzuIuGOLhgQFD3Id5GkFJTL5Dsu/aA4?=
 =?us-ascii?Q?wzZJi3tcHIBp9xxZqp9VBWmHBBxxRd8Cq6id40HSrYbZQpzC3mBeheo7YWeu?=
 =?us-ascii?Q?cOQNPtJ0gHz3n0RWKm6JVEDiH5rQX/1atgTKwtXdHpk9P7bkubmP00yCZISF?=
 =?us-ascii?Q?xqp1YYo3TgqbYTSGP1Xaprzy5UDQyGIDiBuiK2lWhHvzh5cBLJ2igjXRx3r6?=
 =?us-ascii?Q?eOOiiKG95PfEzzpHF6hDMgTNCku5sp0eYxSIjSZZRT+QLx+m5r9qRdduGwE5?=
 =?us-ascii?Q?lM5lWzn9VlvQRcKFnHdrXuZ+AOdlDpu13YFDLXvwF2vUEiUu6ceNvGYgEwCY?=
 =?us-ascii?Q?FXbaGOl6G1iZ2Q564IFpXztqJfhR2ZiVdrsGTK/S1SPof+66ADmQN2nILepi?=
 =?us-ascii?Q?UjWPH8lPepYBpqVKd++enmmZa6wyMvBmgGh72ip7v7Xb86sewMai4LjBUF9D?=
 =?us-ascii?Q?LjGhL7ofhTp5yio32p/Deu3AGFF0N+3dJpXvoYu4Hp4E/pJxEUs0dWodjW4J?=
 =?us-ascii?Q?kKd3O5/6+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0502c7d9-c299-423d-1164-08de659d901a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 16:34:13.4853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjjZJTGKJl+r0sW7xljSwB9A7LHWzwKcM/HfLBGETac3WLqePUzqpeep0AXxAJRgOY8P5ZUHzsN1pBXoKiEL4fiMS7R3weFjLNyNiyjlhnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257617-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,davemloft.net:email,lunn.ch:email,osuosl.org:email,intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.943];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6E02D10055B
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
lexander Lobakin
> Sent: Thursday, December 4, 2025 7:51 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Nguyen, Anthony L=
 <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@inte=
l.com>; Andrew Lunn <andrew+netdev@lunn.ch>;=20
> David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>=
; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon =
Horman <horms@kernel.org>; Keller, Jacob E=20
> <jacob.e.keller@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@int=
el.com>; NXNE CNSE OSDT ITP Upstreaming <nxne.cnse.osdt.itp.upstreaming@int=
el.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/5] libeth: pass Rx queue =
index to PP when creating a fill queue
>=20
> Since recently, page_pool_create() accepts optional stack index of the Rx=
 queue which the pool will be created for. It can then be used on control p=
ath for stuff like memory providers.
> Add the same field to libeth_fq and pass the index from all the drivers u=
sing libeth for managing Rx to simplify implementing MP support later.
> idpf has one libeth_fq per buffer/fill queue and each Rx queue has two fi=
ll queues, but since fill queues can never be shared, we can store the corr=
esponding Rx queue index there during the initialization to pass > it to li=
beth.
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |  2 ++
>  include/net/libeth/rx.h                     |  2 ++
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c |  1 +
>  drivers/net/ethernet/intel/ice/ice_base.c   |  2 ++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 13 +++++++++++++
>  drivers/net/ethernet/intel/libeth/rx.c      |  1 +
>  6 files changed, 21 insertions(+)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>


