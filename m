Return-Path: <netdev+bounces-294128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EPuKuWnHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:52:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE08162BEEE
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E662300B9A1
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A7A3D1705;
	Tue,  2 Jun 2026 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUsmNqNp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C037EFEE
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393872; cv=fail; b=PA7wh24df5Yo7ah1L32tRlzcmPDgTvOvCJbo+5th2ZpnSS66UpbQqGQlqhthWOBYC5s0R1M1TugvXbHQ7aYM4sY2OAAZa5vB4P7ejHY/SmSPlCLT/Ojaj2qXVdNCsYkAgip2QmVswthRFp0upB2kFFvWz1+ktKVJ66tQ2ueg5DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393872; c=relaxed/simple;
	bh=x4ARRw1d8zEOUsGbEzdFwILUQmtu3uyUCyq6npgUML4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cPvtFZL4F3sg3/ATTTSjhZOiGxTBlJdU4nvHgr64O9rZdGN0BALn02P90axBxYbkovjP//JO99/YlLaDAdhC8F96FC9VRC09HqWjRf5oJgtYPIdgM+qY6BOeqGOjnaxLa4uLsHW0HjnKORH/oVNy8V1sFP5dys13+aSEvOb6PKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUsmNqNp; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780393865; x=1811929865;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=x4ARRw1d8zEOUsGbEzdFwILUQmtu3uyUCyq6npgUML4=;
  b=UUsmNqNplMxR9pVAaIUJX89+BOvFdjFHe/gxeMGKTHIIVeSl6IIJfL0D
   2KPrNwL29GKKaGEjJbuglx9GhqdaD35IxXnVVamlqIGldTxGo9xzJCI0G
   6OzhvDWpl0+HMcDF04Uj1EOD2olYmJzIPVwpkNngM53xkCrG1XgQ5X9Zk
   eIH+XlkYjfYjEAf098Vvgsn5GUC/uIONVX87BNf6iNWTKpDm6bOBZqhF5
   d/4TpcwqINVErTSezWWcRotTZIC4pHFu0oqXOvt/9dWg0Uor8NtBBZovC
   jsWxecm+Z2gH8i8bDvRa1sZEbTnICYO7T8y/2ta0WJLWtm58ZvsypQmKU
   A==;
X-CSE-ConnectionGUID: bb/KAhW9T1Ke+QTaieGTGA==
X-CSE-MsgGUID: 0Wt9KbBmREKzC68fN04vcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81166833"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81166833"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:51:04 -0700
X-CSE-ConnectionGUID: o+FnRf1NSUmvDgAggFFiCQ==
X-CSE-MsgGUID: P8c0GMp1ThSUbPl+taKFuw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:51:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 02:51:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 02:51:01 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 02:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRG/Ct0wOikaYfPoA1B2KieM6UG7N98oSRpKZsSLNu/X0K9ER/gtNuKahseMzH9m24+hZv8+wT+/1h0DvdEsYgYDNry3R63d7wAfXDXClVU0pPqg19SSfWR2U2hOB3FmazoOXg79+kEkqEz3KAQAraIqF2UmBOb6eODfHwN+n2EHeQf7SNHYUfjKY2l+/OAx8N1Xv7hUDh7bPtKGyboUkwSV1dd8ubAc5l9+rSgATqX9EzNKsZpd2zXWUheCHYaiYzaWxCLkAc4R2GuvjcvY/bAzH1U+cJrYgNfj+D+7X4G4wmGPtifLzH79QIPsfWUbtSJEKWMcEdG/ZRTez1EeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Drbmsp9QTlSBbPlufFZ540QAHB4peTAgazEeyIpZWU=;
 b=qIC30vneILvTAMFchUY+3VNHzyi0S8jc539ohtOKFEPbtyYuDH/mFp0RALw1fCG047G/wZl4WjIHc+fjoxtWMHVIL14tilHjwV7TQyE47gFsdJyBhCiGLShxvCKVaLYRRGitxa9YRsybMuU9R9cus0oVNYX+B0y6UEtxjZsCadnCoJ1XrfW6QTUB2sXrfs4k2K5YEHE325WfHhzvGa+d7iIfHZqS+NOUoJjJtpP7dsiA3RRqyud3EU2lTP1KKaNZPyklmanQTi8w2NAQtMD8esgp/ySuieOGP2AHLULG0Z4ZqALGmur98qoaMc3ObYuYcPjRV5yRiUr0M3XFozSr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 09:50:58 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 09:50:58 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Markus Stockhausen <markus.stockhausen@gmx.de>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"chris.packham@alliedtelesis.co.nz" <chris.packham@alliedtelesis.co.nz>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "mensi@mensi.ch"
	<mensi@mensi.ch>
Subject: RE: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate
 topology setup
Thread-Topic: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate
 topology setup
Thread-Index: AQHc8lENXhQg0E4OlEaIcjRSAe8HELYrBAHQ
Date: Tue, 2 Jun 2026 09:50:58 +0000
Message-ID: <PH0PR11MB590280FD1EBFDE793A92A97FF0122@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-7-markus.stockhausen@gmx.de>
In-Reply-To: <20260602052640.93083-7-markus.stockhausen@gmx.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH7PR11MB7449:EE_
x-ms-office365-filtering-correlation-id: c9cbc1ee-7448-47ad-026d-08dec08c7271
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021|921020|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: /LQ0No4ooliUAqpbHc/gIYGSHdnHbbRpRpsBpAps+wbQgASgJhFgj3kdgOMWbPNKyNujmG06j/QclI70gxPZ9YKDqj4TFZy4hNcKca77W/kx8MQcgkWR/4g59wzgSj9dVbUdshwnihixgTf3G2nxWi7ProbsIZ+ulg+ILNoBDKsukVkV4NYFmE2E6uhOiiY05LiH7TgbYVFmHMGsgLBXibcy8zSWkoW4zYlcCRgfHbA1xL2fKWvJ3r4VNVBG81uTQqkp43hqEO6htTgH4g7ZnqbAVvwlkWjK+GdyYxhWAKji8NtqGngz9BbWuBRuE7wdXKDMCldQb6RvFgL5c/ptnGePq+E+J2G/sE19Dcw7rPuXO0uPugIVrNEPIx0vJ6xSdvly2Of2ITHdxnxXUlDHsdQHZ7MDrGCqPtuVUJnnU6SuWiE2Fhkvagu17cDmbBow2nBXSCfVAe7/NWAfJtYyrJDbMiMd1PRN+NGvCkjtSRdRxCbaCLOI6VJxo55SjFRc+P2CzEqMpiMJNZhofbn1iO7OYjJXR1evlQMXrE39lUvTdJMLfh/brZ88zkznHD3ofrm0aEUReP5iRwJ+Pzn3Qt4F2SwNbcMbKOejfsvsTS9AIastx7P7eUoEkA8npTBqsHSPOzkdTAeD0XgiMibBM48hBfpYnm+Q1tGrDokeWaz8h/A5l6vkr5PYBzc84iIhytnMAtmY/XpybdW/Fl/y4aISLy7RB0OBajwOfmslWpChP3wD9ys7RetGSQW4QtfqlXLvHHMU7ZCGt1JCGxj3MA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(921020)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4EhjBnyVD2Q1vvdxbAfb4tifoq0kEjlrk+ACrIyRtt32WW0dPp83J1xNLIDQ?=
 =?us-ascii?Q?qrvjeMWYt/MjfV6f79zTe6PyNdOTdsoTybzbUZSjwCOnfnzGA40Jhhf0rMJD?=
 =?us-ascii?Q?emnTytwC8Re4OUgzgYL1lLklxF39i1qKI5PJbKlIaADKvtOyHWsADJevnlEU?=
 =?us-ascii?Q?vVuyDoUYn8OeI3oJ72+9cjKvvPZ1ca2AtztOSatU44W2NAhGaf8YkxHIHVB+?=
 =?us-ascii?Q?OCpnq3A/iWV2gxhUWiFMv6kvce21n8r06JHRefVQnQqQL68XMdR7SvdMx6/A?=
 =?us-ascii?Q?GXI8i669X3US3UHlkL3eFpzFR1E3A0+9p7iyhg+KV68CgsXgRpv/+DIk87Q+?=
 =?us-ascii?Q?VsWs4SbCFfOyRjeOMiO0iHpUUco/1KODrbwHV15kATNid5OKwxkBEaEWGR4q?=
 =?us-ascii?Q?APn7B13DELzr7mcUYWx3gfa4UBtyDmeQ3NjFucKo0VvUi6MdQAojXjHbZaHG?=
 =?us-ascii?Q?Cad8k+VD9vP8SRN40h6u76flvrnmxvEDfNcFPSrkV1qdgyNcat522jRpvRvq?=
 =?us-ascii?Q?tdAIBSsRViNg10cIAFhqf31dlhAEpBgVa2l7uTx01q7NMv87vN+sO21EWdkU?=
 =?us-ascii?Q?l4bZeXTdN1P3k477Bpz7UOlWH/FMZ8ymb4sQwyZcvErmOAoiAu0w3NU1rMlS?=
 =?us-ascii?Q?OhJy92HKbzrmvMAnSZvgUrcI8yvdkTxqtjA33KzavL4SZXbL6wZpFFIen3ZB?=
 =?us-ascii?Q?maDEny2h1Oo26oXNMCEVO/3t/ptEMO+wBwqs/eeM7++fHUPLuclVryNEQRry?=
 =?us-ascii?Q?aMgJMy8nvOuUDMgnfvYhiYUVVTypzV/+mB/mpxasX5Pp0M7np9wpbhqEpwIO?=
 =?us-ascii?Q?+rEVot4M8VNGLK6VpCVmfqYf19lb8XCI8G0v23O0HL2KS5qLK2yT7cv5U6o0?=
 =?us-ascii?Q?BZflrWPy+CTO+vVKGPSvJCxyW/jGhxXPepkC2pAKudFo4jL2L1ST3EfpaOoR?=
 =?us-ascii?Q?uzKe6+ptApywNG6UekcHS46SfHi7WnZVp0jd7mqchmogLNrBsx051yrT/t/b?=
 =?us-ascii?Q?gKaD9+B+AzhCpFX5iqOz99vEEaaE+LLSgw+5v4N40aBoW5XA4jdlItkR6iOs?=
 =?us-ascii?Q?MLULK++p3zG/szu0q63gdV33qKLhJ++t95Aoa1yetqOJCSvE7j2YE5WbJ/pb?=
 =?us-ascii?Q?uoexwZ267juCWf4Z8olbBFBO2+bX7YwSc4BbCZdD7ZjUEN5huzv+khr7qp+2?=
 =?us-ascii?Q?VEDJIYcvuNFooraq4jzgKWzs4LzdIZG28YR6+wmhVHEWKb0cm3lAHboj4NKa?=
 =?us-ascii?Q?Q3xf0iTW4PbwFo8LgLGEeIAlQJxm7tjZygt/8p1giWyLVD2aNupyTu769n/d?=
 =?us-ascii?Q?1sBGgMhnlib3TcXq/wHgnWvN9rR5t+DWSyCMpe+vhGawONheRy3HWObowNTP?=
 =?us-ascii?Q?ntNd8B1ewmsdybYyWb6Z48zKdG6YKO+pWtlLy1UEMdgis4fP0iZv3xDLQko2?=
 =?us-ascii?Q?hBZjOL1g4lXdKTSIfWAyWU84I4qKrbAxnF8JnbYrclbL46z2eH0X/taNGYoc?=
 =?us-ascii?Q?hLPP2hrT9kz8sAcZASty8wF+r+1avpZXNJpyYMn0EeZl0tOjEQB21EF8r44l?=
 =?us-ascii?Q?xKpBC+Qz0N2lvTCA1RPLqIiMEb261RSwidkilUgrjJZRHV8KB+ktTpV6E/be?=
 =?us-ascii?Q?N/1KdpUXv9Yql16NYvuHMY5NkunNKRjFKFZ3WgjuBjrWejvTk3o82kfNN+h5?=
 =?us-ascii?Q?/02f6D38K24Q8at27zqKxJktrxznGw9AuB+X23vfm78l1EYl3j2z3bHXRo8z?=
 =?us-ascii?Q?n1eDWBgi7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sx8RaVTNW1dohdooAQlLWHu24A/hA+PMJ957ooczrb5ODSPktTstG8mKZXvXQsXIjgrHx1eUUcOxMmBciMxtiyn1R5u2HzeGuPLe51fXO6W0k7HOlG/zPCfk2/rcFzz1qa3yxWpICU/rYDTJItJXSh7mYvdSBpUuOVGHt+KwE9SX25jKhOojA4Y0zZ3uC47HpUIViutgrQ5bMzurPLbfgivTFxI2Tu3sKe4yE9Ew543Z53yuhbd2CWKoaRB6fd0+iVOXR+/W62UPHwZj6Gdjmsn4eI7UKFsOIx5BgwJ31fqxzbMSVBlyodw1vN0n/XCBEh9dD5KtcKTgv0vM7VWu1g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cbc1ee-7448-47ad-026d-08dec08c7271
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 09:50:58.0688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hS5eVB0gDWuKsT+yZ+6l7XwD3QcUbMFsXVBXEZlqwNGRtkV5BTJHhbevzMcSGYF4+0PfSvKDqhT8eYOKiRoGqkxuXZINNIZX2ml8xWZr0B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: CE08162BEEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294128-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,PH0PR11MB5902.namprd11.prod.outlook.com:mid,intel.com:dkim,svanheule.net:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

From: Markus Stockhausen <markus.stockhausen@gmx.de>=20
Sent: Tuesday, June 2, 2026 7:27 AM

>Until now the driver sets up the port to bus/address topology of the
>controller after all buses are set up via otto_emdio_probe_one(). This
>does not work for devices where U-Boot skips this setup. It is not
>only needed for the hardware internal background PHY polling engine
>but essential for access to the PHYs during probing.
>
>Depending on the SoC type there exist two different register arrays
>
>- Bus mapping registers (RTL930x, RTL931x) define to which bus the port
>  is attached. E.g. [1]
>- Address mapping registers (RTL838x, RTL930x, RTL931x) define to which
>  address of the bus the port is attached. E.g. [2]
>
>Relocate the topology setup and make it generic. For this
>
>- Define device-specific bus_base/addr_base attributes that give the
>  register base address where the mapping lives. In case one or both are
>  not given the SoC does not support this specific type of mapping.
>- Create a helper otto_emdio_setup_topology() that writes the detected
>  topology to the registers.
>- Call this helper prior to otto_emdio_probe_one().
>- Remove unneeded code from otto_emdio_9300_mdiobus_init().
>
>Subtle change: The old coding used regmap_bulk_write and silently wrote
>bus=3D0/address=3D0 to mapping registers for ports that are out of scope.
>The new coding leaves those untouched.
>
>[1] https://svanheule.net/realtek/longan/register/smi_port0_15_polling_sel
>[2] https://svanheule.net/realtek/longan/register/smi_port0_5_addr_ctrl
>
>Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
>---
> drivers/net/mdio/mdio-realtek-rtl9300.c | 70 ++++++++++++++++---------
> 1 file changed, 45 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
>index 74ea2550e652..9f67d8dd4185 100644
>--- a/drivers/net/mdio/mdio-realtek-rtl9300.c
>+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
>@@ -56,7 +56,7 @@
> #define RTL9300_NUM_PORTS			28
> #define SMI_GLB_CTRL				0xca00
> #define   GLB_CTRL_INTF_SEL(intf)		BIT(16 + (intf))
>-#define SMI_PORT0_15_POLLING_SEL		0xca08
>+#define RTL9300_SMI_PORT0_15_POLLING_SEL	0xca08
> #define RTL9300_SMI_ACCESS_PHY_CTRL_0		0xcb70
> #define RTL9300_SMI_ACCESS_PHY_CTRL_1		0xcb74
> #define   PHY_CTRL_REG_ADDR			GENMASK(24, 20)
>@@ -74,7 +74,7 @@
> #define RTL9300_SMI_ACCESS_PHY_CTRL_3		0xcb7c
> #define   PHY_CTRL_MMD_DEVAD			GENMASK(20, 16)
> #define   PHY_CTRL_MMD_REG			GENMASK(15, 0)
>-#define SMI_PORT0_5_ADDR_CTRL			0xcb80
>+#define RTL9300_SMI_PORT0_5_ADDR_CTRL		0xcb80
>=20
> #define MAX_PORTS				28
> #define MAX_SMI_BUSSES				4
>@@ -89,6 +89,8 @@ struct otto_emdio_cmd_regs {
> };
>=20
> struct otto_emdio_info {
>+	u32 addr_map_base;
>+	u32 bus_map_base;
> 	u32 cmd_fail;
> 	u32 cmd_read;
> 	u32 cmd_write;
>@@ -327,24 +329,46 @@ static int otto_emdio_write_c45(struct mii_bus *bus,=
 int phy_id,
> 	return ret;
> }
>=20
>-static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
>+static int otto_emdio_write_mapping(struct otto_emdio_priv *priv, u32 bas=
e, u32 port,
>+				    u32 ports_per_reg, u32 bits_per_val, u32 value)
> {
>-	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
>-	struct regmap *regmap =3D priv->regmap;
>-	u32 port_addr[5] =3D { 0 };
>-	u32 poll_sel[2] =3D { 0 };
>-	int i, err;
>+	u32 shift =3D (port % ports_per_reg) * bits_per_val;

are we sure @ports_per_reg cannot be equal to 0 in any scenario?

>+	u32 reg =3D base + (port / ports_per_reg) * 4;
>+	u32 mask =3D GENMASK(bits_per_val - 1, 0);
>=20
>-	/* Associate the port with the SMI interface and PHY */
>-	for_each_set_bit(i, priv->valid_ports, priv->info->num_ports) {
>-		int pos;
>+	return regmap_update_bits(priv->regmap, reg, mask << shift, value << shi=
ft);
>+}
>=20
>-		pos =3D (i % 6) * 5;
>-		port_addr[i / 6] |=3D (priv->smi_addr[i] & 0x1f) << pos;
>+static int otto_emdio_setup_topology(struct otto_emdio_priv *priv)
>+{
>+	const struct otto_emdio_info *info =3D priv->info;
>+	u32 port;
>+	int ret;
>=20
>-		pos =3D (i % 16) * 2;
>-		poll_sel[i / 16] |=3D (priv->smi_bus[i] & 0x3) << pos;
>+	for_each_set_bit(port, priv->valid_ports, info->num_ports) {
>+		if (info->bus_map_base) {
>+			/* 16 ports per register, 2 bits per port (bus index 0-3) */
>+			ret =3D otto_emdio_write_mapping(priv, info->bus_map_base, port,
>+						       16, 2, priv->smi_bus[port]);
>+			if (ret)
>+				return ret;
>+		}
>+		if (info->addr_map_base) {
>+			/* 6 ports per register, 5 bits per port (PHY address 0-31) */
>+			ret =3D otto_emdio_write_mapping(priv, info->addr_map_base, port,
>+						       6, 5, priv->smi_addr[port]);
>+			if (ret)
>+				return ret;
>+		}
> 	}
>+	return 0;

Magic numbers appearing here and there, what is discouraged in netdev i bel=
ieve
Any chance to replace them with corresponding defines?

>+}
>+
>+static int otto_emdio_9300_mdiobus_init(struct otto_emdio_priv *priv)
>+{
>+	u32 glb_ctrl_mask =3D 0, glb_ctrl_val =3D 0;
>+	struct regmap *regmap =3D priv->regmap;
>+	int i, err;
>=20
> 	/* Put the interfaces into C45 mode if required */
> 	glb_ctrl_mask =3D GENMASK(19, 16);
>@@ -352,16 +376,6 @@ static int otto_emdio_9300_mdiobus_init(struct otto_e=
mdio_priv *priv)
> 		if (priv->smi_bus_is_c45[i])
> 			glb_ctrl_val |=3D GLB_CTRL_INTF_SEL(i);
>=20
>-	err =3D regmap_bulk_write(regmap, SMI_PORT0_5_ADDR_CTRL,
>-				port_addr, 5);
>-	if (err)
>-		return err;
>-
>-	err =3D regmap_bulk_write(regmap, SMI_PORT0_15_POLLING_SEL,
>-				poll_sel, 2);
>-	if (err)
>-		return err;
>-
> 	err =3D regmap_update_bits(regmap, SMI_GLB_CTRL,
> 				 glb_ctrl_mask, glb_ctrl_val);
> 	if (err)
>@@ -534,6 +548,10 @@ static int otto_emdio_probe(struct platform_device *p=
dev)
> 	if (err)
> 		return err;
>=20
>+	err =3D otto_emdio_setup_topology(priv);
>+	if (err)
>+		return err;
>+
> 	device_for_each_child_node_scoped(dev, child) {
> 		err =3D otto_emdio_probe_one(dev, priv, child);
> 		if (err)
>@@ -548,6 +566,8 @@ static int otto_emdio_probe(struct platform_device *pd=
ev)
> }
>=20
> static const struct otto_emdio_info otto_emdio_9300_info =3D {
>+	.addr_map_base =3D RTL9300_SMI_PORT0_5_ADDR_CTRL,
>+	.bus_map_base =3D RTL9300_SMI_PORT0_15_POLLING_SEL,
> 	.cmd_fail =3D PHY_CTRL_FAIL,
> 	.cmd_read =3D PHY_CTRL_READ,
> 	.cmd_write =3D PHY_CTRL_WRITE,
>--=20
>2.54.0



