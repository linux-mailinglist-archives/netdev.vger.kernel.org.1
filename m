Return-Path: <netdev+bounces-91678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EC08B3692
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 13:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0141F23317
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBB4145328;
	Fri, 26 Apr 2024 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ma9wAH6h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26661422C6
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131382; cv=fail; b=CCmLeb+gbaMhNH+F4A8qoYLaNXqMbQdZTLgPz9S6+Z9lyJtk+5uhTxISX9y5INzz1lmE+QGEcDvflhKnNwfnQTxbc2W7OBJvNrTJ1wQeTX/XxXsJMEiRmtPlOjd/MqQ7YpQKAcRv1qwpWxE175q95CzRSfrG1lBqpmQPiNoE0Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131382; c=relaxed/simple;
	bh=RogWtXXFJ2YcBb+zjq/v/HtM1JUIeS6Fedg96FfnL9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bOKTuBtY6c4NlvIgjTUrJiIn/R/MsqK3J4bQ7tEV3JYlFePXgf+NfRsy3Ynf7CWyAaupNg9bryqysxfmg1Tl5BmHIFqDTB/ech7z93IfFPf6qI87mI3WkMVvGIAFRbpQHEV0xvaEp60RfMdyUiRrOKJGqKi20bXdPYWWpF8vgpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ma9wAH6h; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714131381; x=1745667381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RogWtXXFJ2YcBb+zjq/v/HtM1JUIeS6Fedg96FfnL9A=;
  b=ma9wAH6huuayVLMlCoWxQCz5+6ErDu05oMBxn2OGxLyw7pI3NllMMD04
   iZWazAdB2VfWa/c5Oq+CwP3Gete0QxVqRuW/HJH66PsuKN7avwsURNXOS
   f1965EyrNYSH9pVmls5Jal5GeOJPvOKnZTYHAF7c5tEUvfWW0OkhfhGpQ
   oxpwQoVcw3FQ3sCFOjUxdZAfmmEuNDP2U6zT8lGL1INo/xOd6bkv377D/
   Ya5Yuij1JCxJniiF6oogDcJ3L5qzILGNKBl/tFgmSfheIm4D2dwkGsdrF
   VbjVNZ5OhaaGbC8qgAbT9uJRy4iX08p5HgSIRiK7IMBv0BFtzQ4tJSLf8
   A==;
X-CSE-ConnectionGUID: bzaE92x3TXKKj2MnVEM7HQ==
X-CSE-MsgGUID: 34SyHCeTSOq+CLRRuKgjPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10021736"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="10021736"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 04:36:18 -0700
X-CSE-ConnectionGUID: aaNa58RLScqdPGp2kugodQ==
X-CSE-MsgGUID: vHPLDHIMRhOcOjp/cmpQ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25899727"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 04:36:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 04:36:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 04:36:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 04:36:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 04:36:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeSEOv7TVMXhwllo6/gXajS44wUO3X89BxbWubIsoqbNqYoPqOXfENx5qgJuCt0iABVxs1O8grkuOERtIlmkiSh9xpj7BSkhdPg/+9cfNVM4mCPOgg9prmhy5tm68aBPuZbLKl1nBcjSwubK2OOb0/u3Qm5KQ15OYWni60XoRb67KutMq7YpBU3EHF5fJ4pkdDx+zuNUyRaD7i4gUXp8T/yuHVX6YiwC1ukGGlvQZvQNu/O/lzazzcQKU2xTOB+2WUslFYCdXHmzas0H2P3xRR6iHyfyQJvIhHqyLyMADRrIy3Um1Z2OHPIQpSUQlTpNGeEOKAZaky91sP3mf4SBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RogWtXXFJ2YcBb+zjq/v/HtM1JUIeS6Fedg96FfnL9A=;
 b=Ouwmx4QFYc1QL48xMvi2/H+d+QKmxrfmuXeDN4hFKn1TlDR5YOosfMID82QjZEzt8J1KChbW8pNA45417eT1EJL2BXA8eA1JUlcOZlV71YPUpzqdvkDka3EzRLYLL/dYEeSM8KgKyS9LzbJ3PTKlot2MMKHMw9r0Au7K5jBJ3eaEIBuB1GnvH1DY0QSv91IJIG4tVFBn9KqOMwkzf/y84C8PcfLn2QO6l1Bn1P51i9a2gvN2ld53ko2nIqnV+ifCKwMekjPbSVeY3rPUVXLYjX+7CPdCANE5aOY7VGZR+A7S72ocQiduhqqP+pitdZEou5oszi/EETT0z+Sli+1Qqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19)
 by SN7PR11MB7976.namprd11.prod.outlook.com (2603:10b6:806:2ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Fri, 26 Apr
 2024 11:36:15 +0000
Received: from DM6PR11MB4610.namprd11.prod.outlook.com
 ([fe80::e51:4d65:a54a:60fd]) by DM6PR11MB4610.namprd11.prod.outlook.com
 ([fe80::e51:4d65:a54a:60fd%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 11:36:15 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"horms@kernel.org" <horms@kernel.org>, "Wyborny, Carolyn"
	<carolyn.wyborny@intel.com>, "Glaza, Jan" <jan.glaza@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 5/5] ixgbe: Enable link
 management in E610 device
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 5/5] ixgbe: Enable link
 management in E610 device
Thread-Index: AQHallCoJ6eGku69bEK2B9YfqCpHA7F3gY0AgALsmqA=
Date: Fri, 26 Apr 2024 11:36:15 +0000
Message-ID: <DM6PR11MB4610C53C88941A7F8A1DB8EAF3162@DM6PR11MB4610.namprd11.prod.outlook.com>
References: <20240424142251.3887-1-piotr.kwapulinski@intel.com>
 <20240424142251.3887-6-piotr.kwapulinski@intel.com>
 <1ad7d60c-ea33-43e4-9cc3-033786fce13b@molgen.mpg.de>
In-Reply-To: <1ad7d60c-ea33-43e4-9cc3-033786fce13b@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4610:EE_|SN7PR11MB7976:EE_
x-ms-office365-filtering-correlation-id: ead1bd5e-1e89-468e-c0f7-08dc65e5150e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NnMvSnlOL0Z0Q2VDZkhkaUlPb0dQcGxBWEpXNTNMYzV6c2VvMTlvdFBQb2pE?=
 =?utf-8?B?Qk9TWjlqODJLRWJTTEFHMXNIMjFORDd1SW1yYVZJaW9xZ1d6N3YzdjhVUE90?=
 =?utf-8?B?ajdkamxOaUwyV3JOYmpHSmxqSDc0WkdQNjlSL0wwN3V0eFowWWpYTVhhNFQ3?=
 =?utf-8?B?QVYwTGJqWTdLTVNuU2h1UFhFZkgyUlpmNStYMzYzb2RqcHJWbHRaUnkzUURo?=
 =?utf-8?B?U2NCYVhMVEVlb3RYK0pzWVo5UlRmN2xMekIwcTU3TGRYVUQva2tTU3duV1Q4?=
 =?utf-8?B?a3hvb2JOeCtEWmpuTHRqTmUwL1lkaGlrRDhFQ0dxZ1QxUWR1MGx4c1psdWVx?=
 =?utf-8?B?VnFtUFg2OWF5bCtQSThEZ2VkdjZhOWZzcUk1YVMvck9sTUFSekRRSGt4c2JT?=
 =?utf-8?B?UmpSRHpnelhxT1RMVGhjeC9KSmRJYUhPWkRpTDJxTDNVeEVBSHNVUDdlU0l5?=
 =?utf-8?B?Y1hlV3hRbGFRNGdVWXYxb21MViszV2RneXpZQXdRMTZiaHZkc2IzNGFCOXN3?=
 =?utf-8?B?WVh4YUpncXgxQ3FpVTFyKzZWRWVmQnZTTzFOYVpibW80VTd6ZVdCdUU0WWZi?=
 =?utf-8?B?azVYdFY0akZSR3dBK3ZRdVhIZ1JsbGxGSm5sNDE0ZlRvMHZscHFoYlRjdkkx?=
 =?utf-8?B?SGtoQzR0dnJ5WHhvTG00VDBSZkZETjZWMTcySDAzNXI2T0JoSzN1bWxWbE9p?=
 =?utf-8?B?cTNQTWZTbWEybGpsZC96SEs2ZUJQR0FDemlUUXZvQjl2QW8xU2JHR1hYQko3?=
 =?utf-8?B?Z0gya0NHUlVNMUM5cEY1SUZ0SndkVDBvaWdmUi9XZ1lOMUsvUnBJL1NVbGJZ?=
 =?utf-8?B?NVBqYTAwZ01uYlM5NTNJOUdCRWRBU3BFTmx1WXY5Y0hya0NkTDRXdlJKeUox?=
 =?utf-8?B?ZFZkb0wwZTdSNWVXRXZCekxHRXBRelAxWW5JWXNMa1hoZlB0dHdZY0tQRStC?=
 =?utf-8?B?bFpOMHVoMlovajhVVzVrNWhHczMyMDAwcnNraHhlQ3pESkxwUjlOZ2prT21o?=
 =?utf-8?B?OXVHS01RVldPQ0NwTFBWaForOVE4aHRMUzRFM2tSVUVLMWxkQXFWOVBFUmR6?=
 =?utf-8?B?Q1hneW9GYjAxT2RvMS9XYm5LK0Y2NmhjUENkVFJDdmp3Wm9xbjVUczNEMU91?=
 =?utf-8?B?UEN2Zys3NUVhV2l5bzU2S2lsdkx6MHl0TWVDWlQvRGd0b0l6d1VSQk5pU3pr?=
 =?utf-8?B?MGNIYUlqNFFudFl6c1dhZ3FLYXBrQ3VJc3diYWZhbHo1VFZ1bTZhcG5Yb0Y2?=
 =?utf-8?B?eWp5Y3U5UFlIdlFwZ2xvSVpTd2haOXBOZ3JNeWFEV2RBY1BlL2p5V1lpai9P?=
 =?utf-8?B?NjBHSjE5R0xmbTBZaVYrT0hVZ1ltYlR3eklQbmNSSWVYRi9xK0RLeXp6STNN?=
 =?utf-8?B?ck9ZMjhBeGZuYU1NTFNSYyt4dHJyYnB2YnlNKzQvNGNtQlNJWUhxbXgrcnNK?=
 =?utf-8?B?dzNSOVlrTjB3VDFTUHd0eUxROTdEdlB2TjBuRWMxa3h3a0cwUjNqQ2RSaVFD?=
 =?utf-8?B?N1dwVTVJSGJadmNuRmc2b0hSZ1hUbG5TLzBZTFJ2TW12ejlRQTZDbnFjajBU?=
 =?utf-8?B?cENyYTVIbTdLOFNYaDBhYWc2ejFiV0toZ2N4YnBWZG9JaVhVNnNDWDJqQWUw?=
 =?utf-8?B?TktTelp5ZHF6RHNEOVJyd04vVmI2c0I0WUlqTk5PMXJLa0wvWGowUWJCVE9j?=
 =?utf-8?B?T2dCY1kyZGtZYUFoY3Vkb0tSUFE0Yld5Q0hVazU3Q3dPTDBLOFNBck1hSFNs?=
 =?utf-8?Q?Qj+ZxVWgPI1UWHKCF0aY0dIJ1P+Gl6t4y3eBSoB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4610.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUdtTHpKR21LV0NUZ2RVcXpuVjlSYnVyMC9UVXVCU2QzNlhqVjJBS291ejFX?=
 =?utf-8?B?L3JUMy9oOEtzWG9FUFVHKzBWTkMyR2MxVW9nRjI5WjBzOFRRY1VSS0g4U2o0?=
 =?utf-8?B?bjQ4dmM0SnhzeE5WM3ZSTkVMUlRGeXNPNGhGNnpLckFVRVh6Z1pMaE11UGtU?=
 =?utf-8?B?YURFNFpWOU9SL29zd1BWUFcvOTZLNjNJME55T3lRQVltRlROa0ZtUlAvN1ZJ?=
 =?utf-8?B?M2g4QlhSUFg2SzVRc0N6ZGRoSGRWaDRoaGdFeTNmV0NGWjNZejNLd29oTFMz?=
 =?utf-8?B?K0NEcWpZeWxybDZoc1p0MXUySWxsT1EvMWRzci9QcjZMZUFwOFBkK0ZpTHhi?=
 =?utf-8?B?eDNqNFdMUW5qbGRSU1MzQmdUNlFCR1liYVRFQ2ZLaTUxKzZZcGJOUFNPUzJ2?=
 =?utf-8?B?TDZhTlZrV0craFROK1kxelMrSDk5YU1FaW05aU52a21YTU9iaGRPcDFNRXFC?=
 =?utf-8?B?MW05MThCdXNWWFlEZFh5VC9HUlViUFVQSUtzVW8vRG1RU0N2Yzh5SHp4N1dU?=
 =?utf-8?B?bVRTUDJCR1JoeXU0RFF5RmxkQWd0ZHBsREdDVi85UHA0WUJ6U2ZsdForUWpp?=
 =?utf-8?B?RGxmbFF0czh0Z3JwMjdKRnAweGxsaFdRSlJTYlFIZzZvejBoYlJmaXM3alpX?=
 =?utf-8?B?ZWh6YWZhZDZQQzl1UmUvbmNTc0JhRzlIMHkwWjF0Nk01UkdybStkK0Y3czJj?=
 =?utf-8?B?WkVFQThraGJuSDhSOUpzQ2VoYTYxMHZBSFZjdW1LWlgxbDJkWkdnNkpxMTI4?=
 =?utf-8?B?bGRUYVhaNmVzaDlWVHNXb1dmY3Y1cUVOMVB1bTlsajgzK2NLTTdaZ2JXOVJG?=
 =?utf-8?B?MnUzbktXT0NEakd4bm1XczRQTzhndXpVNWJCUlhROUpIdUQ0N2FhaENaSDZ4?=
 =?utf-8?B?WFVlLzlHRUwyV0daem5QTzU0cm5uL2dpUFk2M3NTUWdkb1BWZ0FSd1Fqb2xh?=
 =?utf-8?B?czdISDBLbG4xOGw3Rk5rZ1NNclRKdDV1aFFINWdJWkR5UFlrRUxRWjJHdVN6?=
 =?utf-8?B?WElJbkpMOVd1ZTJjS0FJOG5aMVRuM2JZd2t0UlJ3UDBlWVdBdGFGMmZVVHRa?=
 =?utf-8?B?WGloNzFDUlpNUjdsaWRnMTNZOXE5NVMzZll5NXJwWXZhR2dLUlJXY3FDanJC?=
 =?utf-8?B?Q2NTc2pwckllZUx0bXQwajBrVlZ1SUNIbi96dVNNZ3ZQMG9xYWVydFhObEFQ?=
 =?utf-8?B?TzU2NE5SU2hseUk2WmRWZjBpVTkzdWVxOCtqcjhqZUdzVUxwUFV3bTE0ckxM?=
 =?utf-8?B?NzNUYmkzKzNUZHV0aWVlbFNleiswWWtrYkdBa0FTVzJINjVJclVvd256cGcw?=
 =?utf-8?B?b3loZStVSGkyR2x6K1RLc1c4Y3dsV1FqVWQ5TW9PdzUyMjNBM1pXak5VMHJs?=
 =?utf-8?B?bXpqaHdhUVlHanFDNitEK1B2R2d2YTc0WDVpVzNuL2F6bHNybHhkSjNGbnZJ?=
 =?utf-8?B?SU9ZMU02UEMwbXZIM21ZblE3cjczNUV0OU5WeGxhdFYrd1AzejBvRE0yaXlY?=
 =?utf-8?B?WFBidkczQytRenlTczdRcHZsZ05mSmkzdnNCTmNtR0srd09uek5ycEg4UFRJ?=
 =?utf-8?B?NjNURjh5NFp2d3l0M1JiSkQ2NW5RNDBXUXAxZGVORWhtcE1qUGUrOWU1cVlQ?=
 =?utf-8?B?MElCSzNwb0hkUXYydmFkcmkrWFpyYmp3VnRTR0xUb2tWUXF1VmJYN1hzVE1L?=
 =?utf-8?B?MGtET1BjbTVRK1pDUWhCdUNPQ0pTRi85YUxDaTljR1I3dkJIZWRuUG84THM0?=
 =?utf-8?B?SkR3c2FMaHZjcGJKWG5TUGU0TldmVjJncThQMWt1d1JHRXpZTkFFcGF2T25k?=
 =?utf-8?B?Q0l0cjY1c3IxdGRnODVwS1JjR3Z2TnhtMHZIbkJkR3RldjhFcUhlbVJidEps?=
 =?utf-8?B?ZGI0OFA2S3ZCOE9OMkRIdkhrKy9VTkxaWiswRnVnUDd6aTBGRTJ1NlVQR1VT?=
 =?utf-8?B?VEhxUGNGY0N0WmFNVmo2QWdydno4M2dQdjNGdFZLNnkwRTBSOVJWUVordXJL?=
 =?utf-8?B?Y2tmOUtDdkJUR2Jzamtsa2tqZ3V4QmF6dWdYME5KQnNlaDd6RG1XaEZxL0Nx?=
 =?utf-8?B?UFhIMW44dmdlYnVYVnl5OTRsek03RkxiM1hNc01iYjVZOGFQS2swQ2RIZEpl?=
 =?utf-8?Q?6prvhGvigDDiL0aRiflwIYiqs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4610.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead1bd5e-1e89-468e-c0f7-08dc65e5150e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 11:36:15.4749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CPbicgcTIF/eKu/1SBxnEFkg37ptwDfPm7flogIU8lNSePghOWmW9xrBv6DnWZTbuBgSy8T3DgImtyHUGZV5OUfKA+5nnBs1/Kd9FrCeGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7976
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxA
bW9sZ2VuLm1wZy5kZT4NCj5TZW50OiBXZWRuZXNkYXksIEFwcmlsIDI0LCAyMDI0IDQ6NTMgUE0N
Cj5UbzogS3dhcHVsaW5za2ksIFBpb3RyIDxwaW90ci5rd2FwdWxpbnNraUBpbnRlbC5jb20+DQo+
Q2M6IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBqaXJpQHJlc251bGxpLnVzOyBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBKYWdpZWxza2ksIEplZHJ6ZWogPGplZHJ6ZWouamFnaWVs
c2tpQGludGVsLmNvbT47IGhvcm1zQGtlcm5lbC5vcmc7IFd5Ym9ybnksIENhcm9seW4gPGNhcm9s
eW4ud3lib3JueUBpbnRlbC5jb20+OyBHbGF6YSwgSmFuIDxqYW4uZ2xhemFAaW50ZWwuY29tPg0K
PlN1YmplY3Q6IFJlOiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjUgNS81XSBp
eGdiZTogRW5hYmxlIGxpbmsgbWFuYWdlbWVudCBpbiBFNjEwIGRldmljZQ0KPg0KPkRlYXIgUGlv
dHIsDQo+DQo+DQo+VGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQpbLi4uXQ0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBwb29sKTsNCj4+ICt2
b2lkIGl4Z2JlX3NldF9ldGhlcnR5cGVfYW50aV9zcG9vZmluZ194NTUwKHN0cnVjdCBpeGdiZV9o
dyAqaHcsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wg
ZW5hYmxlLCBpbnQgdmYpOw0KPj4gKw0KPj4gKyNlbmRpZiAvKiBfSVhHQkVfWDU1MF9IXyAqLw0K
Pg0KPkkga25vdywgaXTigJlzIGEgbG90IG9mIHdvcmsgdG8gc3BsaXQgb3V0IGNsZWFuLXVwIGFu
ZCBmb3JtYXR0aW5nIGNoYW5nZXMsDQo+YnV0IHRvIHNhdmUgdGltZSBmb3IgcmV2aWV3ZXJzIGFu
ZCBtYWtlIGl0IGVhc2llciwgcGxlYXNlIHRyeSB0byBkbyB0aGlzDQo+cmlnaHQgYXdheSBpbiB0
aGUgZnV0dXJlLg0KPg0KPg0KPktpbmQgcmVnYXJkcywNCj4NCj5QYXVsDQoNCkhlbGxvIFBhdWws
DQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3LiBJJ2xsIGFkZHJlc3MgeW91ciBzdWdnZXN0aW9u
cy4NCkJlc3QgUmVnYXJkcw0KUGlvdHINCg==

