Return-Path: <netdev+bounces-303011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ShUWGPRyQ2paYgoAu9opvQ
	(envelope-from <netdev+bounces-303011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:40:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9876E143B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:40:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ZH1LI2vl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303011-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303011-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DEB5304EABE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020A22E736F;
	Tue, 30 Jun 2026 07:37:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043F40D574
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:37:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805024; cv=fail; b=C/l+nEaA2b9Q0+BVrnARuc2MUgxQplCE/IsrsWxdA2RAtI4jeUAv4di1irZxYY1V4s1p6SQuQu4NtSdo4WTT8dPzQjqdT9yS6gc/1Y4SAOTa4Wey337q7VB8D35dagCwlO5fJMmhroETmhSov18aI+Mj8lLShZR3plOZuQm5m74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805024; c=relaxed/simple;
	bh=gjBH763tXcofMX1gAH+MZ/gE6n356OAhXEq+pEVGq4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S4Xm0rpybIXchfQq2DsHhF0GGybD8tnntFsa3OFYQbDUFNr7sRRDJJsTWsDqAnto6L//bfza7qw+U5DXkysImsPvjIjNDSgLdNarCPgRaerNOYwsumDE0n+UseuP2LERDAWTLDxjwuh4UUzTWPvr3QLWPWAYYnCTKJbATM+ddzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZH1LI2vl; arc=fail smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782805022; x=1814341022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gjBH763tXcofMX1gAH+MZ/gE6n356OAhXEq+pEVGq4I=;
  b=ZH1LI2vlAc+l1Y0+2ujcq/20a4b59j3NQgMDsXSKyxw9Up0LF0gtm7vy
   o2ypViie1+jSRSpzurZiBs/xrziQw6+fcIuRp4Ayjz9Rk3t3oiKrQHLKU
   dvIn1Of2bw5Vg0YjfghtpMQ+50L63LgezEd5QUG55HzylrZtCAt2/3lQm
   zARXfUMalynma7jOzG1rI81VsI5JtNr6N1uNTdQdA/HZWSEtbiYmOcDNK
   ZetrUNl1m6VMCj7vcpUEfH0kRFeBD3RP71fbf0qcUkVA2KRVceZghGp9P
   o+/NddvFLLdzlQOSXlUENHRZ+TIG5V9/Iv6OC+EZaSG7949cnvJ8wFyFL
   g==;
X-CSE-ConnectionGUID: pLEn6nCNRvW6buhWiR0Mjg==
X-CSE-MsgGUID: Ds+WxDjVSaeCMadt4Brv6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83508107"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="83508107"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 00:36:58 -0700
X-CSE-ConnectionGUID: PinDfkX+S2qrSm9ma5fgXQ==
X-CSE-MsgGUID: oAPphddyQkOdmwjEcTjL3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="249551005"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 00:36:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 00:36:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 00:36:56 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 00:36:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOvssuzO95NIq8QorpDOAk1mKNv1eogSJrDAq85L2U9enIuRMFQaDymmLoh0PwI3LN6fJcVD/kwx3xLIJ6oLW3mvGeLCrk4ivCe1nbzuQYqbu/M8yKXjhTsoVr0h01PAAO9JqeaYhU0S64KPK9r+wACZ+0lqGMnYpODZ48WF7ThuUHtqVfNLrJVuhRjs/O/0AFM9fgAFLMPBzT3eNHkam/fW/smOwsMnCCW4Ey/Rm7A/xfYMLOwg4crrL5GAp4hdzxq9E16JMoOF4FKZD5Wrp2QptM7E8SL+5Fs0Jyk/NHa5yDlwGtvWv2q6AQvkgmCc2ecbRJNuFiSaHwqdovrAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQeJ9YqW2FPyhGCRqyVr9gzBlmib0fkAViZL6MNZ+NQ=;
 b=AMRrPra/n6PJ7fdypFZoNQh3J+FsMvvVfKg2tYXBB7ou5APF99m0nULHeki5m4I2pYso+c0P0vwIGdQ2mwUFTndfz/MPHG/p1LUliuOA2w5BsI2o9KGEFCAuR9IB4SycnI5REaVKkv7LN0Ac8Bzwp8l+o7zya07rtUhAaPHYpKV4L9ECYT4GqTbsodYGRiNNcUaj5RJI6u7Q5x//jKK+lXPX5LXscdInIgXxj/crVTEGNp7etF6K9atFXR5ACxraKk17eYEjFW/+URzZfJEcaoS6PgRrwqaRVJUviNnWxQgxbLpRrR/Q5DlBDdJ+ViIiFwDMMkmFmXZzU+kbFePXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:36:48 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0159.015; Tue, 30 Jun 2026
 07:36:48 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Ren Wei <n05ec@lzu.edu.cn>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>, "ncardwell@google.com"
	<ncardwell@google.com>, "kuniyu@google.com" <kuniyu@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"chia-yu.chang@nokia-bell-labs.com" <chia-yu.chang@nokia-bell-labs.com>,
	"ij@kernel.org" <ij@kernel.org>, "bronzed_45_vested@icloud.com"
	<bronzed_45_vested@icloud.com>, "fmancera@suse.de" <fmancera@suse.de>,
	"idosch@nvidia.com" <idosch@nvidia.com>, "yuuchihsu@gmail.com"
	<yuuchihsu@gmail.com>, "yuantan098@gmail.com" <yuantan098@gmail.com>,
	"yifanwucs@gmail.com" <yifanwucs@gmail.com>, "tomapufckgml@gmail.com"
	<tomapufckgml@gmail.com>, "bird@lzu.edu.cn" <bird@lzu.edu.cn>,
	"roxy520tt@gmail.com" <roxy520tt@gmail.com>
Subject: RE: [PATCH net v2 1/1] tcp: bound SYN-ACK timers to reqsk timeout
 range
Thread-Topic: [PATCH net v2 1/1] tcp: bound SYN-ACK timers to reqsk timeout
 range
Thread-Index: AQHdCEPR68GxIgLI8UOfze3lA7+RTLZWtbkg
Date: Tue, 30 Jun 2026 07:36:47 +0000
Message-ID: <PH0PR11MB590216E374E56FE30EEDE69EF0F72@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260630035009.55201-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260630035009.55201-1-n05ec@lzu.edu.cn>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DS0PR11MB6495:EE_
x-ms-office365-filtering-correlation-id: c1e78899-6b58-4715-b4ef-08ded67a57c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: bPU2p6gJWutUjCkB1rctmnVXqbdscWum/RpQL4n4VBLNUFt279lFRkozHWa5QqYwgNcQ33/3RJrgP93r9fwnDcCOJQdUy4DuP3rxLTYUtlqeMaumK7VoZRBWXnabUVEGD9VPl/rA2x+jYWPxrmu5JxfMeMm345cyabw2RPfFnNsnl8EN69L/eT01HLZHc4+ELQ5Ihgh12ZHgetEkBe0TZGVRMCZNCRZ6Fs3ZR5zcCgLev1/9SLMRLuuSCFicVTocQx6GBhHmxWW1i9H9brZNfNelBiDgjjJ4cdBjTIwfVqz5F1TWLnjBGgZp2C45PnAMqVM5bgSWB3BpdzJ3hJKQPMeEkE/teCHfFBBlfiaXl+a/IG3B0PT444KnhVmi/oiqbvOKQn53rHevwikVopeEXOZJfDTIO+prwkczJC0QUdVVgqQW1CbRBLmxCHY6l4u+FRU3YUskDOq20SLb8x+zAEeCP13r6Z3Ze+YVJYG5DipVSXwnVhnbz3ukWb4bXwi5JiJXh4P2KnTkch/ZsqpXUItmCiusJUSnHrtTZOs8hqU3sCq2IrpovzoZVBIQwWi0hJEd2WYvzP4ry7dzTwhkDQO8Yuw9t5BEyH89AfWe5hPu+/M6aznAWRe7e/ly5p5X9VeGwYSJdVpsO9VOfQ1+Y/tilRCYS1wH6hNRi+5sDtQh8UWxM5/eei/X+YTnvvNwqMHA140/YPeT8FLq1FBk7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tS9l84Q+eWghnhEI4H2nHH0mhHy0sZlmsqNdAVzv4Ib9nKBwquNXYVMfMoKQ?=
 =?us-ascii?Q?E2C7M/kMlNhFdfv7tuNPDQJuVfykx+Rub3TI86AllCuMuF6wLsi/5ZaWGIva?=
 =?us-ascii?Q?wrbMzxJrahAhPpHLwBqFEJPA36OAZ0Oz0XdNgkIPHrxp8yTshjW2HXhhji7Y?=
 =?us-ascii?Q?38wf1ggsh+wD0D1gEVzuggTvqo35KzA3DuFYjPvkLG4IT4WLdbIVkSaOgiGK?=
 =?us-ascii?Q?PvbArlIiypOZ7+1wcR0JbTP5eHb5QulkoAGszcvr8O2/MPIIQ1eYAOrhH5J6?=
 =?us-ascii?Q?PteKDrYbljX6nUm/F1CDyKQLrBhWRUHVtBAXhgQpMY/pXrH9MJxILJ0dnMur?=
 =?us-ascii?Q?mdyO2sjP5ZWDY0jtQ+6Ju87s9ONbncV5rBImxleLnqOHZjbQZzsVnbBynqSr?=
 =?us-ascii?Q?HR30aJ5l4KzBl2Or+h1BG31Z2BvpiVRktSCwGp9gkiY83GbW8D6XLZRElJXX?=
 =?us-ascii?Q?KJ+o3fe81XeD3QRgr1DPCR5kMGdOgsB4ADEJacVfMKZ7jEUkh0Y5Qj/mTs31?=
 =?us-ascii?Q?WbwKSS85DuoBDvX7f9tOzxQ423xTR+mJZNbFIXhT2iZtFUj0E/YzNglQZLQX?=
 =?us-ascii?Q?hZCl3cZDA0G6ZQ8rpNVNfP72zbezX4I/Ya/8J9sz7wDFeVVK6D+9irXnKj1M?=
 =?us-ascii?Q?SnKJeSll5aLb+vjbjTQ6EyLTmSEyMu9Z4+6NV6R1zZwUV58V6Ql731FPZihX?=
 =?us-ascii?Q?+FnTDbv4VRYdJQTBPCwuCkd0HTq/4+nAsws9WkD4EL6yWKACENerVSFxhcIW?=
 =?us-ascii?Q?fCg6QPt1R7qULvwtxB8WtYxo6omCabI8Ksqyp0TbuZe3vjcx5Mj1VY+IjhgV?=
 =?us-ascii?Q?3XykHV0s62Cnb+1uCrhS6f5q+2YWQt08oEEQUR00IafmYQVKfn9Inj97fRUY?=
 =?us-ascii?Q?ZbHRWV+fNqX8YFk34ZxX5mp6cIfzor0rT7ntIeZO6vGPd0oqEMZbAUBmDL6n?=
 =?us-ascii?Q?O7h3tVWPd5dik2QKviJwPOpYysZwMWl/BliuOFBYYSQuL9w5lXUz/+1xp7V2?=
 =?us-ascii?Q?0wLmup35yOHQX7oW+rCLop5SLV2IX4o1+TFDyNGm/jwkSqIf/2QzfvIwIsuT?=
 =?us-ascii?Q?u2VolEmDY/Ybs6+W9RGXMPXrrj1PyAk+lK+eew5UQDTGRk97ocoxPGx2mXJ8?=
 =?us-ascii?Q?KQWLnHCkCI4S+QcqCAuvayiTI+xfw4AOFjmM0J1/zf3oqYpviGgfiTcmKr8s?=
 =?us-ascii?Q?wUnRYkiJACxiNnGRbr4B+eY11Z8qs2ahlOuOTiBOvfj/EUdqk6MGmb6uIl6e?=
 =?us-ascii?Q?/2PufV9wAYG6mlVQpazEsYs3pBXkO19ZP+GJB/tDpeMeSFRawUM3pUdH7EGb?=
 =?us-ascii?Q?HzkZDK8lKTOfB2ehecIunZfdPqGeE2D6OICc74uKNm6Y0w7y/GH9aRQJkirF?=
 =?us-ascii?Q?Hyc8T5oat6NYGUquvSp9NXcfiuUMKszs7BHqn64NOmAafadrmdM8b+EM1C1q?=
 =?us-ascii?Q?KIJbVHiV2NBQqrP1zrwrrEWsKTOAJ05SIkWauz+AFmuwqx3ie4asjz6OGQRP?=
 =?us-ascii?Q?T9nJXcg009BTdYXDgb3uJ3wM4LMTU0SKNYxTxC/xOUUPjW8Xzjevj3Q4FYJK?=
 =?us-ascii?Q?teE+qPkhVBqJISaoSkKVEyClQS20UAPJUZpgkg4CtX2Ou6RUG8ykB3BnZ9vx?=
 =?us-ascii?Q?Cfl5ZFLLRzopDGQbtM/7VAcCo8Q9XoCIYO8oQYFiAdmigKB67X53VmYMOlf8?=
 =?us-ascii?Q?zXfTQDQlTHObgH6B3/W0aKMToY/eDgLqF0a1YIx+EMPi2gKDaBSEyIzWaEI/?=
 =?us-ascii?Q?oVtnG9MsCA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hGOQ7C4uI9UW7cem3F1AoxdHt/YKZvV7CzEamPNVqzO8fOX+g3E4U5iYtspQCMAP2grW6s4NDay6OFFNgetnOhczA1Hw4FDG84rfIBFEmKp2SItP5fuJVzmx0zO2mJNUJEXD8etDJbzYrs18U3Gjeuwyx5LbJWk3hYsl7gslCtQcPNQy+7QfxTZfa3mLyImxZjbRsjFE9wbBg9KkocBoO7B3lw+RCPpxKNSYmxQwvruKPSahDIipainPx8K2y83zovqyrpAWrOPmKV4D6c8Vm68T6G863dRy65vzLLJVRRWQ29Rvel/A6iBzc0NY4XCUkp2UYIlit2Xjr8ohNEn8Ow==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e78899-6b58-4715-b4ef-08ded67a57c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 07:36:47.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xD8Z54MNuhnZh1r1aoLVILDTq8mSdelwsLKp4ipO8iBmoRG2A1Md/R0BoR4KkWZXV7Pc/RLtV/YphoSGFJ2MiPbWxzF1yKfieZtLtszhPho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303011-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:bronzed_45_vested@icloud.com,m:fmancera@suse.de,m:idosch@nvidia.com,m:yuuchihsu@gmail.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,redhat.com,kernel.org,nokia-bell-labs.com,icloud.com,suse.de,nvidia.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,PH0PR11MB5902.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB9876E143B

From: Ren Wei <n05ec@lzu.edu.cn>=20
Sent: Tuesday, June 30, 2026 5:50 AM
>From: Zhiling Zou <roxy520tt@gmail.com>
>
>tcp_synack_retries supplies the SYN-ACK retry limit used by request
>socket timers. The same effective limit can also come from TCP_SYNCNT
>through icsk_syn_retries, while TCP_DEFER_ACCEPT can keep an ACKed
>request alive until rskq_defer_accept is reached.
>
>The request socket timeout counter is incremented before it is used to
>compute the next timeout. tcp_reqsk_timeout() and the Fast Open SYN-ACK
>timer shift req->timeout by req->num_timeout. Excessive retry or
>defer-accept limits can therefore drive these timer paths into invalid
>shift counts before the request expires.
>
>Limit tcp_synack_retries to the request socket timer range, clamp the
>effective retry and defer-accept limits in the regular request socket
>timer path, clamp the Fast Open retry limit, and make the request
>socket timeout helper saturate before shifting.

...

>-static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
>+static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk,
>+						 struct request_sock *req)
> {
>-	u64 timeout =3D (u64)req->timeout << req->num_timeout;
>+	u64 timeout =3D req->timeout;
>+	u32 rto_max =3D tcp_rto_max(sk);

Hi,

please stick to the RCT rule.

