Return-Path: <netdev+bounces-259687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNcoMCEqmGlqBwMAu9opvQ
	(envelope-from <netdev+bounces-259687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:32:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5BC16646B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F952300FEE0
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24924320A23;
	Fri, 20 Feb 2026 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDf7LclI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9ED32142E
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579712; cv=fail; b=Bbkc/eZ4Jw2uijEBUiK9/XcOR4OZN1hooxZznw7bDhcF41pt6SZ+SirXc/3/hpuA70LsU07Mz0lSe0JrgrzVxa5rCepmClHONju21NwfYqPi4tIl+RK1VZhbCSGCs4yzQaGUz0jAa3iyDbaq7mR7QWiKQKXmibio0yfrL+V2Kzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579712; c=relaxed/simple;
	bh=Ejkx3ii+07LjiBBG/JUN46UF5XZjqj65yacDXpZRN2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NDUNKpWnaUxA0sdbgHmDZoY8d5r87aoQx/qyN8aD8/rKGe4kdy7y2CdAyATHw5dfWmG24ax2PcTGOB2UkFTiiDDroaJQPt0IsBT8qQ53VxlnU0A0Fwt8aYiO6yryTe6PgmMP8ZrBkB4oSBBjsDj2SHVhBhw2FeQicLRRs4St2IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDf7LclI; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771579711; x=1803115711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ejkx3ii+07LjiBBG/JUN46UF5XZjqj65yacDXpZRN2s=;
  b=LDf7LclIa/FOohnr0aJfJkV1Wza21B13ywjyW7KMctYKGcgdHrPtDqZw
   eydWLMj/68elt5v2uF3w7p83TKYfVhBmUP843c3DJuDsN8y/S38rznUNJ
   eGhW2S1buPmJ2Zh3VKP0KZxynO5SgNcpTNUGIJYU5p/fbMRo8Vw/LyEru
   eg5DlVSD6YHXdvbS3o+iRU9E48qxITj0srb1jjkJ+jkbCQZpliq+byMWv
   2/RgEU39M6RlmFfiAbE+ZBZjEa9OSEjMWbsSTk0H/Sjfih5m9jO4E0H/e
   nOV7/8PU9HMN7rH7vD48/6ea6Yu9wHBt6BhNeml/60BTB3EsMIr9hFFK5
   w==;
X-CSE-ConnectionGUID: rEDmaTk2TbW3osk7hBq3SA==
X-CSE-MsgGUID: FWknn0mUTFSJZEXnrNPVgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83298069"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="83298069"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 01:28:31 -0800
X-CSE-ConnectionGUID: hTdHVXJLRBuArj4OvuOEng==
X-CSE-MsgGUID: Wh5iAwSjRPOcR81za3P4hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="214654583"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 01:28:30 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 01:28:29 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 01:28:29 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 01:28:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjbH8wIevDk0TyARVYyVvFV6s5j47f4qgsZjPmBR3cdhWTYze1xjUGTUiQwvK7g0ePdqzildgnRMEPVq9HolK8QX+XrpydfCF/vLOZ4LZZ74CBPrhyLzZd4HA+iRKhphvSKuNgZBu5kCN7tTrOjw0tobGQauD1fCUTkYvo6I3aFMx8oF3Kcsk5J+T2tTOIooyVfKGVpFzLg0a0gCixXXNYBxVae8bcBaLpHaUHwGpXAvkzxCZMWNCVPLCcmnlhEJZzgO/utW+3I55uOkruQ+kbcNXPjPFXO6r2jjlUHn7fRRxGjm0C7R4wOkl9vH6IXUGCvDGQ0L0TFCyr6jYJDLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejkx3ii+07LjiBBG/JUN46UF5XZjqj65yacDXpZRN2s=;
 b=uI/VYdNAQidl98XNY5cBiyDeP+sUyXPbLzWpikzCAHCr63wEA1HYhrlWbr3e2Z4hbSLDrGXK45T515SJRLRlK+XWVQmrZCiyQ0A4LSDrpnZd3WUHB1dhBr4/OC7ehAk8GJpiL+rC0doLm8zYSFywpzgps+lfWfHoam8DxhKWcmJbdwV1PsVdsyYIO5NcIfqENAjBnFwdicB684OhEdfU8lRsOQjU/9PlVeM92HVJXEdwALa87raw/RA9isV4R5MJwcLW155vNUqLmyf6k3xr7ElAvb+j5S9g4h6B2x1bWA9kWP2jVVLZaEvHGWHyP6m1ZWajJaQVwBNcaOkqOFO+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:28:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:28:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Nowlin, Dan" <dan.nowlin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-next v3 3/5] ice: improve TCAM priority handling for
 RSS profiles
Thread-Topic: [PATCH iwl-next v3 3/5] ice: improve TCAM priority handling for
 RSS profiles
Thread-Index: AQHcokq2TYc93rA7/k6ntHNDDIn0wLWLUeCg
Date: Fri, 20 Feb 2026 09:28:21 +0000
Message-ID: <IA3PR11MB8986193ACDA1E30C6CC4F88DE568A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260220092409.718632-1-aleksandr.loktionov@intel.com>
 <20260220092409.718632-4-aleksandr.loktionov@intel.com>
In-Reply-To: <20260220092409.718632-4-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL3PR11MB6484:EE_
x-ms-office365-filtering-correlation-id: ddf99301-3866-48ed-fcdb-08de706263c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?rSIWhksmWCkcmbuOIq9r7/glUhQv25nomIrgJBa65/mmP58yA5XKUBFWeKQW?=
 =?us-ascii?Q?wUsi4l1Tq+99VsNDNga9vRUoR0WNImUEC4ke9Mfl/cn6ntnoXCWxopGdsYWQ?=
 =?us-ascii?Q?A3guRNxu7ll98a/dEpHr2nzluwY57TPCzGl8mZMExrCcu3veKE0fB0nCZHgW?=
 =?us-ascii?Q?ED1q2qJbn2i49OYvXqvrsaMYWr8b8BXgNH1haRTRRgX69MhL7TtKzmaaMrha?=
 =?us-ascii?Q?nk+0vu8xaG9oSias+xSdLnKsn4Jur2NsYhIFqmiR/J4kuONNymO17BvJEp/G?=
 =?us-ascii?Q?zAH59ZH4MSooLzrEuEZHFyg4EoPQcDNRWyuIrBduH8o2GPSPZPyacQvizopy?=
 =?us-ascii?Q?Wh5lEuTBOTbPJ33XHP1vb+ANq3uPCZmOylxPzmUBsnT+87/yCRgpS81yFxjD?=
 =?us-ascii?Q?PRsI6BOJlJIs6Mfol6PzhhqnSfaX0iFX+u+rHQWnAoIReAZmga96gx0bkEzv?=
 =?us-ascii?Q?KTE4ABmrtw9j3PUCIo4ArN/kOp67eq1DHxfVD9+jfRos0jGR+yqqV5DUOBe4?=
 =?us-ascii?Q?8OVPFwU8wRbGVewrdMkjrBchwzvvpM7CTUKjNmBzKTjeA4/F8iATp9j7eve0?=
 =?us-ascii?Q?Cbpn9n5xmPgcV+655q7foYcO7SKioZZCkjU6ubVWJikY9oaLiqZbMcgf0saS?=
 =?us-ascii?Q?vc12q34Bc24bce3unSzz7GTFkREErXAc3yZ0r+c1eAyCgk3Sm5r9K419wKys?=
 =?us-ascii?Q?K4dIrxwPSMhSr8CHxowqxzQZf9FIRvPJnrT4GzeB6112kNodLfIsorT4hCDh?=
 =?us-ascii?Q?0IP6/Ar2azcioCEJoBWMdxj2c2DmsqzTxvx6HSsKfsTvC/V0MXsNpaAK4Imr?=
 =?us-ascii?Q?SduDbGxXZxmjURS8vh8Q+EIcHUlm04k7SSaESQSJIk+KeSrLiz6gdKwBxUPk?=
 =?us-ascii?Q?UJseLzYWO1Ulwth+E08qIOjrjOhAYkt94ErOJvmGzmSryXmRCxIFgUxx9pfl?=
 =?us-ascii?Q?e3QuO4P2GfHctVsJaBFH+uyMxqkhrYKdteJ3fHL3vnlDs3/vd+sTsuQXujqn?=
 =?us-ascii?Q?RGxR2kRcNIAURK2ZT0vPBxXt7Ac5DxE45tcGsUPWwP4qQM508tGgSKyYTAUP?=
 =?us-ascii?Q?dW6aGrJyMrYiSCc014XFRNcidDfJufp+OF7wCkV1DQuOcO/8afN9HCLbsX9Q?=
 =?us-ascii?Q?x12MPm8WSjq0FLyPXMPTE+I4+l1CS4sgHjodwro3MpfZsjYi1U8ErdXSCGyS?=
 =?us-ascii?Q?RJjTpcOrIcCibDSdSLjvmw7K4BLsw3zbYTq/qzPjP3Dvk5FENxssx8betnQp?=
 =?us-ascii?Q?y9XdVJFbtQli8ev9L6fAs21Zq5WcVY9n2p+DM2WWEmrGY9Zq749gJjYOhOri?=
 =?us-ascii?Q?3voekPvcknrKJE6F6x+Ghvm/W9NZvc9jQFeu7sjTkhlht3sgrHIHnxufyuPX?=
 =?us-ascii?Q?ttMq4w42rMZoJTnWAcabZVANHmCFANdAVuGM5gW63qPAFm+3EbkH4cyVE0kH?=
 =?us-ascii?Q?s+nl65ulSmvyFrWe/2X3p9iI61oUBvpGP8CQBSfgBB4ENs2r+OyNZTSKzmT4?=
 =?us-ascii?Q?jxE3Kjs4ApfoK2Pe7ar+zwnQbp/7Px6itULrkc21/6cEBF2Ng42lBrVShU/5?=
 =?us-ascii?Q?fFHQ9MwpsXNErClRmmA6eosu2BAMH4sEECy/adpVeQPz5AkjjyJZE2WW03UN?=
 =?us-ascii?Q?ITspzs2x+1JG4I/CKioxJR4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JMOOfX0kuP1h1G0wGtXiF0vnlynR3KPqnSvWPC0sClPLb+9Dq2IU6VqHAgYJ?=
 =?us-ascii?Q?+hyUK7ovG+yGqqBWyfntx7WmzxvKSSMpJDOEpANu4i/shTQgq+6KPgQ/hXAv?=
 =?us-ascii?Q?SidicJuD7T1o17vU0CPyXK1YUwVDw8OoK1UMjw0IkXtHGKKYCeUbfKxzap6g?=
 =?us-ascii?Q?i/PA5tPS8T1MT0bzKZNwbkPVaqS72GpkbWG6c3HnCUtk9SXxKZ5scTY5FkKN?=
 =?us-ascii?Q?UYKpvn+cvxLjep1AXFs0LfacOs4SnB41EHRhdjbrOHtGbb9i2IX63mk+V1bq?=
 =?us-ascii?Q?UwwjfLdCEV9j98eoVhFzcCEEM0jlfmSEz6V1HINMN1G8N+9nPKfkTDmHRp7y?=
 =?us-ascii?Q?WochZrUM3wWzURWFh4DlqXUGVq5+mVx3UtIaCd7Wn1Y80KbTtCd250vfebzR?=
 =?us-ascii?Q?i3AUpB+KBM1c9l7kyYEX74bKAJIIqqJ5PhHQcn/wkbc3WidYog2CTAEjVvb8?=
 =?us-ascii?Q?J44pQ4mcKDHdRtYfYYlO1RZeUGAokk4a2aBLDyWup65di/DKei4XHQMpfk0c?=
 =?us-ascii?Q?vGw74zeRhCWFr0F6ZB/b2uQeS5rBJ9iJ2bUbmaFmK6NBUBwNlxcbAJy4GYbO?=
 =?us-ascii?Q?sRhHxpK3ynyOpwrFw6pLhYHgi8HC/ZphXi+md2H44PqyYg1ih3Ud+SJNa/y8?=
 =?us-ascii?Q?1XNGZL1xtB24tCVYUL5j9ngnT8E+OJ7YbVWgIiD4m0cBBwBiPA2M3xltkQlR?=
 =?us-ascii?Q?FsEAdBhSkxO4rADspam8HgVY5UGqX4GBXLxpP3dhIVAO5H8uL0MEESClqutM?=
 =?us-ascii?Q?AD223I2XyvIEDWFe0kgzH5f1hnMvMvWT29VFqV2N6PGByIRsu9wi2/cywv4d?=
 =?us-ascii?Q?lwobI4zU3S7Ayp5SRS9B5FG6XH5bvoo5qvdOmrnz75PKZpw4k2sOwT53TFr7?=
 =?us-ascii?Q?oTGvDRDaqZFqdfFa7pipf7hRULzJri8MozJb4NQiXzzyBP9n5vqLxFYRd8Oo?=
 =?us-ascii?Q?TTvPa37fuwribCaXmHLDFaHDCCm2U3YYlhwUP8ArVO7fuwOjLPvMY1XZRpke?=
 =?us-ascii?Q?jb1IDcStwJ2vkbUDLum6xNYwYRBlmMWJVOg3WUiAqqd0j+xbdIge5MLtN22J?=
 =?us-ascii?Q?OGqmF33yLNS5fBbUDnw1V96uL05TYhkwjVfbJ/yzamsoBvjktlgvcZXAqMzw?=
 =?us-ascii?Q?XZGPGrBgNVCEjqa9dL8vFR9Y7EYfCHIZL+G9McrMdun1DB3gk9PgvIwyHsS+?=
 =?us-ascii?Q?IJJimThWU71svV/XiiJtcvlzTwvfbzuCNMrXxmKWtyxcorS+BOH13ODsWFFt?=
 =?us-ascii?Q?Tc8Soz+NQYn46tUL40H6aVtP7aaRlvRQ7Ah4SX+xR2EyzBovjGvvDRbVt5lP?=
 =?us-ascii?Q?QF3keis63mXdXt966cG6AwhPWqi4ftZutFpnBZA/hg+JdosjzySD6HpxJRAu?=
 =?us-ascii?Q?96H/9qiHYqwylJ5dfjPGm61A92c7dDoEw+iofFNHRh/Gyz+nSSiBXNLDo2gT?=
 =?us-ascii?Q?bJF/VByoGvWt5eNrePhRgxffcdew5U0Nmeljslbb0dvqWuq6uMkArz2Za4xp?=
 =?us-ascii?Q?L4RkL7Ko8oBhOYD9BiC+Mnew+Ms3o46WRaTUjaGFY/TcduwrBXkfgb/MCUtr?=
 =?us-ascii?Q?aXBxbJDLel4OhkrARoDgamOXwcHwkJwfDscdSjzaijpCDqHt2JLHccF13fg6?=
 =?us-ascii?Q?YF1zr7l3wQUzhUceh0SMXQmepV3SPk6QuPPv/UTr9JmZZ4ElTzs/Dk7uVk2+?=
 =?us-ascii?Q?mKzt8UeAMktbiMaNHZHZV1XleQoVg/Bfr10wruPCx3sCJ+ihOE4RYpBgzmxk?=
 =?us-ascii?Q?hzKYfgJZGw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf99301-3866-48ed-fcdb-08de706263c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 09:28:21.5912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYrT700RVTGnToY/5fUcu5EHOwf/2qEh4ySboUf+Fs6w7eOcQNSdKGaac7cYolXD3MeprKWLSOBlClshBYflRfWOdnbI7JdlR+Dy+PyNmKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6484
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259687-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8986.namprd11.prod.outlook.com:mid,osuosl.org:email,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1E5BC16646B
X-Rspamd-Action: no action

Please ignore this email.
I had personal e-mail issue.

> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Friday, February 20, 2026 10:24 AM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Cc: Nowlin, Dan <dan.nowlin@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH iwl-next v3 3/5] ice: improve TCAM priority handling
> for RSS profiles
>=20

...

