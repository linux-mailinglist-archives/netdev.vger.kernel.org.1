Return-Path: <netdev+bounces-304890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vPwNAQ1bS2rXPwEAu9opvQ
	(envelope-from <netdev+bounces-304890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:36:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9955B70D9F4
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:36:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ZrkgjdW2;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304890-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304890-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD5AC334DC47
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 07:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D123451BA;
	Mon,  6 Jul 2026 07:17:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B9381E97;
	Mon,  6 Jul 2026 07:17:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322274; cv=fail; b=g9+7ZGMkR7Sco7ujUKJdxl3UNAQnVi1wquz8VGDeLG6IJA/eJkg2D/C4FOi4KoKhkJiqTLcxIaroiRzhmSR4C6o1nxehWOzu6T/h/VuIenzz4qd8/Qdxs5/cZU5ZBrXNUVvPMcA26BQXefFPZYh8N8v5HePT/DeRsOhrMs3pdEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322274; c=relaxed/simple;
	bh=ZH8w2BAmMKV6M1i5HOmgIswr3zzAkVYaHLBkvLuVTFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6w8Z6XlSU5ObORBkIAknw38WkyEb8P7ol02BizDpmCryIWMeY7MSQDBOftPRZt/DhqXPBiBZnqfYGbqXwXRAUOeOTyzjGYwVRMqECCp8onPxawFIU1rCirteyTdIOuWIsVv3XCkxZdZqciZXLGC/LvBmZIypkVa9VXZH7Gv6Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZrkgjdW2; arc=fail smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783322269; x=1814858269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZH8w2BAmMKV6M1i5HOmgIswr3zzAkVYaHLBkvLuVTFI=;
  b=ZrkgjdW24Dez3fzizuDCcspwXQNNjIOpKhbsJETPsUKsW59oqZHTPJj0
   UqEvwOpfXOUWhognGPopGt0jIVon2q8hmQOzSB1u7a9NMzz5/uHSHdiHM
   JRWkIr3PUWtZWESsyMIuKLQP+11NUWqoFZ8mrzzIAN4Gl8+nyTI2CIAjL
   1pNfUtMAbiLju9sRW/qrd1qescB2Ol1LuuNzDvoUDef624bUEW3MM5Dl6
   R9HezfI/bVcV9sB60y0QY4GCvW1I76jLuv8pZD5709zyZSzHmRfC4BWox
   zfsHMaQLqpn3CmDVetuVJEQ/0ELyfS01GCQMeuPd3cUZjORKYEmKRHygw
   g==;
X-CSE-ConnectionGUID: wPR54xw6QxG8O4fvjUx4Lg==
X-CSE-MsgGUID: RagW7AngQyGpxSYIvbaRtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83810084"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83810084"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 00:17:43 -0700
X-CSE-ConnectionGUID: TprxQZOTQRieEWcvjC+9ZA==
X-CSE-MsgGUID: qUnLjEtDRSqP3LHWNz8h0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="249190434"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 00:17:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 00:17:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 00:17:42 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 00:17:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVSBGWxhs/APKeTTbLsm1yzH6gNxQPxMiGJ5MELqPb9YwfNivo/++B7DDvD/RUHfA2XVXj2LCFeQVdZnIj+WFFktwSXweCRQfj+567TKHun4n8xl5LPlxtk/alNJR8U/D1C36aIIAcrL5coyzwQsdnXL0KnPAZntQmbw2MvfV8N4p++Oza/OkaCSoV/xH1cevcbt7zw2uZFtegxLuy16DvhERY11jttT1jDD+LXv8yeKlq202TeMauaH51kEO7qBPHBEed8yBrQvDjKR495Cag/vLx0MolFR2pCGzxuZA9UX+hoE2r9l4zROmbC6Pi7iS9t4IDytTWZIwn4l8sgI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH8w2BAmMKV6M1i5HOmgIswr3zzAkVYaHLBkvLuVTFI=;
 b=KUIQ7IvfRVeRoj0hpEk/F6/zaaj9z5m6YzkQ71rFe2F03Ulc51E+YVEEwAknZZFxfW27jHi5eSkfmfdQ5DaPI7jHypHhfaGlt09CnxMw5XFay5xbjERCXO6Q0AF0mxyZ1k+V4TA8Rshv2tnHgFmA8Rnnu35Oy2475vuKwbnNujXc5TyvZyGSzHtJqmHm7Wsy66nkLzd+Eip8RQ+DjgGLC12OpqZU7VGfUB1pXnxmk0AWtLqAQaSiyP1Cc4e8Nq6bX3ybenM29A1E7C9mpSJ1MtXvW/rC68n/Wq2fFchWO6nzPgns5LAqQ5DZGo3XgJCSJuLErs/YaLx8nmasvK/bZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 07:17:34 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 07:17:34 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>
CC: Cedric Jehasse <cedric.jehasse@gmail.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>, "Tyrrell, Kieran" <kieran@sienda.com>, Ryan
 Wilkins <Ryan.Wilkins@telosalliance.com>, Mattias Forsblad
	<mattias.forsblad@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 11/17] net: dsa: mv88e6xxx: Move available stats
 into info structure
Thread-Topic: [PATCH net-next 11/17] net: dsa: mv88e6xxx: Move available stats
 into info structure
Thread-Index: AQHdCsFEFCRmTsC6/kqf8XeaVCFfQ7ZgGWEA
Date: Mon, 6 Jul 2026 07:17:34 +0000
Message-ID: <PH0PR11MB5902B0E9FF059E56C5D6D32BF0F12@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
 <20260703-net-next-mv88e6xxx-rmu-v1-11-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-11-991a27d78bca@padl.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|BL1PR11MB5304:EE_
x-ms-office365-filtering-correlation-id: 72364f11-1dc8-4a53-b62f-08dedb2ea676
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099006|6133799003|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info: rld0ycJOqVze9V1Qa0hWxbIKEwP8HTBrByp8j/K4D4ddxrPJZiGeidCH0uoOyBFSrE4/u64OyOYdjsCkquS0/YpqUtgY585fz09xg31YmWnd0FKh6kaZIJ3hzYTz3JxsdgszQQ17ktaBgRutZcSeydBW80uBKV1rlTkIO1ulb/vNUiWGrcoHYEtSoVyM4fqMehynXo1EI2V99DISJCZlGozwPiTAPjiFjW2x03BwHiFIXLg2nDDauinUDHA6NhPSfZOwEVcbPwKmfPgFi0b/Jzlx4V6nKQ2t5dROnzt9WGTZOXQ8TYGSMge08vptOFjSzZmdPK9M78i9mNIR5spbQaIfUmfwSaaAzgk++4c9Ns53tOjSPtpb569rHDE1jHCYJhRFlCN0h7kth/d2MPZPSIirTjQlde5X5tF6BY0+7x+CJZlAfDYoHKJd5OFiHCQALJMYUQTZ5QaTL4rJM361T4elp4ZIWrT8H3aoTre6R3KwN5n1jtroKxtW04QYhv5t/A8o8LGF/dbAgOj9LP4MaukBQ8lpUioU0Z08MaOtWmuj1SgehtmStltMTVF33nybvJnkEPBH35JgMV1+a7+HbgDOBjAiyi4U8fpQmIIb4bzfonar4WbCwn/T+V4H1BdCQs6j2fU1HeLa65LreK5zQJU7MCem7Gla5wmRFcgFXZWd1v5sgAoR8YPLbu+dIq1jgw5JOxdkooKaPuYxkzOM/YqwDGn6XSHNW07XIzu7Crc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2JucFovcWdQbUZCKzRJNXdwbWpsdmxxU0ZzbG51RG8rQ3B0UE9QdzZHRUNm?=
 =?utf-8?B?cVQzNWpoVzNOK3FxVk1uL1pJYmlxY2NQakZIUWJpRCs3bWh1QlM0RTdDUW9l?=
 =?utf-8?B?S3FPbW1zRlNBL2h6R2RXZE5oaDZSaC9Pd1M1azdlWFRwMHNDVWR6cEtRNEFy?=
 =?utf-8?B?MTk0dzhYTWcvQ2ZOTWhuK1RrelE3RUp1Z090a0hxdGRHQkxzdmpzQ0xzSXl4?=
 =?utf-8?B?TTkvbHg3QkM1MVkzcTVxWGFJR1U2L25NeFVsdE9CNXdaU2RYZ3J6YWhOZXJJ?=
 =?utf-8?B?c1E5aGxpckliTXNMWUxrSVZScmw3TGtyYXR3QzFXRzBCdXFDa3B6RFViZG16?=
 =?utf-8?B?ejBOb3kvNDhScGhncTdSK1pyRU40UmZvNDMzVElRcG41SGJMc2UzS1ZGVFNs?=
 =?utf-8?B?cWJ1cFJiT2I2ajVJbXRlZ0ZEKzlOSFE0N1N0ZFVUeHNMK2JBV3ArQ0xaalhp?=
 =?utf-8?B?algrWjlOdG1IbTI1eE9nT2F2a3pXcCtHVmo4eDMxZ3Fqd1A0UUlrVE9TT0U1?=
 =?utf-8?B?anNqQlpnUmVyRm85UkU1eFIzRDRhckI2eWpVNkI0Tjd6MU0xZVl2eUdOMHlJ?=
 =?utf-8?B?dmZ3bXFVUitaVXRKT0gxRzNwOWI3dlVmNlN4QmgrQXhCYndxamVOL3dmczIz?=
 =?utf-8?B?UWlSYlBjYm5DR1k3cWRKdkN1NVAwMnBpU0NiWXM2S29JcWZ6cVRobElEMEUy?=
 =?utf-8?B?ektmVXhHR2dlcm81NzkyRmNSVkd1eDUzRko0ZWxwOUNKT2Fodk1TRW5vV1g4?=
 =?utf-8?B?ZDd3OFhVd0JXRGxqS05DdFNHUVZjeEZ3MHRTQXVBalBiQmhxVWozZTVPYnVr?=
 =?utf-8?B?c3lRY2RscXptS0gvL0RsZDNpcEVEeVkvQUJvczZBNE1lRm56SHYzeWVPOTFi?=
 =?utf-8?B?bFYvWGR1QUNzMXl2aUdJV3BhVVd0aHM0VmVQcEFRZ01FN1JQTHBSWld4NTR2?=
 =?utf-8?B?VXhBaEFCSEdzQzBtNEhHNFp4YUlQc0JmYVhhWlV2bi9YUHFMQ3pZY1BRU1Nh?=
 =?utf-8?B?OENwRlBXQ3Q5cGRyRE9KVXpZTWNtbWgvOEoxNnRxK2tkaWdIa0VlL0tTSDk5?=
 =?utf-8?B?d0pHUW5ySUVEZHRYdC9QUnd2VXR2ZTVacGhWQkszcjB0ZDVQYmxVTmJkYTNT?=
 =?utf-8?B?NWJkMDRSQ0picU5FSVlveVZtcWRKckxZa3VxbzZRUDc0RXJkUkVVRzNqUW1E?=
 =?utf-8?B?ZDlMeXB5YlV5N1BlWkxNbkpCZ0xXS2tFcmtodkpuQ3hmNk5Cd2V6NUYxWEt2?=
 =?utf-8?B?YzlYOTQ5bXVBemlEZDV1aXVHdXhJTHNUckJLNDJvSFJXenhkSGwrekFmbVE3?=
 =?utf-8?B?UFpBajdWaEk3bFpJVlhIcUdGb09FQkNwRE83bDBBbk9CN0NsT3dOVll3dDVQ?=
 =?utf-8?B?TEhwVzk3S0JsaDU1SGhhYmhKWTh1dFcwdUhaTkcwZWNmRGEyN1dBY2tNRHdF?=
 =?utf-8?B?bXI1a3c0OUtyVEJja05kWGRwT1hUNHdmaHZSMVRwaCszL2RFMlhjWmlHZDRm?=
 =?utf-8?B?TTlTcDlDN1BNMnpmbzJsV1hYM25Wd0pGQjRVajdiSUxTVVRxci9XSFphOElk?=
 =?utf-8?B?Um14eUxySUxUUm0xa1c3QW5DazVRb2Z3T0VPcUlZaWZEL0VJcVFQWENGVkcx?=
 =?utf-8?B?MXo3Y3BPZUE1OURqVzYvSG5pVjU3T1BqaTE2cnFYcXA4dVprangrelNoV2JI?=
 =?utf-8?B?Y3NGMTZVZlJWU0RNMDN1Wjk0eU4yNnBzeGovbVFlMk1lM0ZVN0JDMytna3dM?=
 =?utf-8?B?bmpPNmRZdU9xbkh2MEhENGptcGxWVlgwQ3hQa3UxY1BGc0JtSStwZ1h0cUNK?=
 =?utf-8?B?K3dHQ08yTWxLYy9kZHpzVDg1b0VJTy9mUzE1SWo2Zm1DNXNmVGllZVg5QlBr?=
 =?utf-8?B?MXR2Tnd0NVU3MTZKc0gwQ2ZDNnd3b1N5dUxPVk9sKzlSSjlpa3h3eVVFZDlW?=
 =?utf-8?B?TUQyMmM1WXlFUE1iMGlSeXBVZE9lc3JueDQ4N2J3ekl6Ry9lRksyNGx2cDJH?=
 =?utf-8?B?ZzBBNVd3TGFyK0VqaW02bDJER1l6OEJCK2VxbzBjbk4yM2RUM3g3dDZ2TkRT?=
 =?utf-8?B?cVBJMURPV3UyOFcrOFdHTnJ2cnI4WnlaZlBTUzAyKy95S0J6QVVPNC9VaUtU?=
 =?utf-8?B?YnlxTDRoTVZOMzd6RDlOUlVLZzhkVkhUUFFzaUhrSTdFSXJkUmlKdkd3RUJP?=
 =?utf-8?B?MzYrL1NyOVZSMnJJWjNoRzZaMFZjeTBmNHhOYmsxL05PZ2FzL0xtT2Ixbitq?=
 =?utf-8?B?cDdSQjI2YWFYT3kvZ0pDaDN4TkhEUXUvQnFZWDBTYkM1SG50ZVNrWmtlOENI?=
 =?utf-8?B?VmZiRmxuaklUUXdBTStnSDB2aWErYTBpeGNPc0dKeGwwcWVuZUNuUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sPCkqWM59uc+EVs+g6CNFtKKL7+G5LMEuKWeVV155KDCOcP2hwgFPodYDvpFvIyiMOOqVNmkb3lEIjUH2puMrqNAVVgTnbVJqKS3vuoDhKoLZ7oWMysYxMaDz68Ffesp4JhaCj779BUWsCsq4mzSUzBRMT21R8baHKaNs9YVTdGZw3cHYiuqW48TRqHwBKVpOzcRjsdKZaTtXYqqGSdRFKluKM9btmg1PHS3vV3f6HZrOJ2tcjokch7e/1C/EqVznE49FlOLP6S0d8an9j5q8/i1WYGux4lBmbnPw1muFkwtxuIYLvOiVjFt1Y/bJ4FFt+T2jxcvV3ygdGBbHus6Gg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72364f11-1dc8-4a53-b62f-08dedb2ea676
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 07:17:34.0677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAUMsh3iuCYa8VkmFgwaPv1aInHAWA8uSUJ13G7ln3gYRpzM2A//pvTW4/owLgQmw3M42YE7R+TO1S1+VJGfcrPfnNzZCRoEHpw+7ugXGt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304890-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lukeh@padl.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[padl.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,padl.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9955B70D9F4

RnJvbTogTHVrZSBIb3dhcmQgPGx1a2VoQHBhZGwuY29tPiANClNlbnQ6IEZyaWRheSwgSnVseSAz
LCAyMDI2IDk6NDcgQU0NCg0KPkZyb206IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4N
Cj5EaWZmZXJlbnQgZmFtaWxpZXMgb2Ygc3dpdGNoZXMgaGF2ZSBkaWZmZXJlbnQgc3RhdGlzdGlj
cyBhdmFpbGFibGUuDQo+VGhpcyBpbmZvcm1hdGlvbiBpcyBjdXJyZW50IGhhcmQgY29kZWQgaW50
byBmdW5jdGlvbnMsIGhvd2V2ZXIgdGhpcw0KPmluZm9ybWF0aW9uIHdpbGwgYWxzbyBzb29uIGJl
IG5lZWRlZCB3aGVuIGdldHRpbmcgc3RhdGlzdGljcyBmcm9tIHRoZQ0KPlJNVS4gTW92ZSBpdCBp
bnRvIHRoZSBpbmZvIHN0cnVjdHVyZS4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTHVubiA8
YW5kcmV3QGx1bm4uY2g+DQo+LS0tDQo+IGRyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgvY2hpcC5j
IHwgMTIgKysrKysrKysrKysrDQo+IDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+
DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgvY2hpcC5jIGIvZHJpdmVy
cy9uZXQvZHNhL212ODhlNnh4eC9jaGlwLmMNCj5pbmRleCA2NDMxZDI1ZjNjZmEyLi41YzBhMWUy
YjA1MDdkIDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgvY2hpcC5jDQo+
KysrIGIvZHJpdmVycy9uZXQvZHNhL212ODhlNnh4eC9jaGlwLmMNCj5AQCAtMTMwMyw2ICsxMzAz
LDkgQEAgc3RhdGljIHNpemVfdCBtdjg4ZTYwOTVfc3RhdHNfZ2V0X3N0YXQoc3RydWN0IG12ODhl
Nnh4eF9jaGlwICpjaGlwLCBpbnQgcG9ydCwNCj4gCQkJCSAgICAgICBjb25zdCBzdHJ1Y3QgbXY4
OGU2eHh4X2h3X3N0YXQgKnN0YXQsDQo+IAkJCQkgICAgICAgdWludDY0X3QgKmRhdGEpDQo+IHsN
Cj4rCWlmICghKHN0YXQtPnR5cGUgJiBjaGlwLT5pbmZvLT5zdGF0c190eXBlKSkNCj4rCQlyZXR1
cm4gMDsNCj4rDQoNCklzIGV2ZXJ5dGhpbmcgZmluZSB3aXRoIHRoaXMgcGF0Y2g/DQpUaGVyZSdz
IG5vdGhpbmcgYmVzaWRlIGFkZGluZyBjaGVja3MgdG8gc29tZSBvZiB0aGUgZnVuY3Rpb25zDQoo
d2hpY2ggaXMgcmV2ZXJ0ZWQgaW4gdGhlIHVwY29taW5nIHBhdGNoKSB3aGF0IGRvZXMgbm90DQpz
ZWVtIHRvIGJlIGNvcnJlc3BvbmRpbmcgdG8gdGhlIGNvbW1pdCBtc2cNCg0KPiAJKmRhdGEgPSBf
bXY4OGU2eHh4X2dldF9ldGh0b29sX3N0YXQoY2hpcCwgc3RhdCwgcG9ydCwgMCwNCj4gCQkJCQkg
ICAgTVY4OEU2WFhYX0cxX1NUQVRTX09QX0hJU1RfUlgpOw0KPiAJcmV0dXJuIDE7DQo+QEAgLTEz
MTIsNiArMTMxNSw5IEBAIHN0YXRpYyBzaXplX3QgbXY4OGU2MjUwX3N0YXRzX2dldF9zdGF0KHN0
cnVjdCBtdjg4ZTZ4eHhfY2hpcCAqY2hpcCwgaW50IHBvcnQsDQo+IAkJCQkgICAgICAgY29uc3Qg
c3RydWN0IG12ODhlNnh4eF9od19zdGF0ICpzdGF0LA0KPiAJCQkJICAgICAgIHVpbnQ2NF90ICpk
YXRhKQ0KPiB7DQo+KwlpZiAoIShzdGF0LT50eXBlICYgY2hpcC0+aW5mby0+c3RhdHNfdHlwZSkp
DQo+KwkJcmV0dXJuIDA7DQo+Kw0KPiAJKmRhdGEgPSBfbXY4OGU2eHh4X2dldF9ldGh0b29sX3N0
YXQoY2hpcCwgc3RhdCwgcG9ydCwgMCwNCj4gCQkJCQkgICAgTVY4OEU2WFhYX0cxX1NUQVRTX09Q
X0hJU1RfUlgpOw0KPiAJcmV0dXJuIDE7DQo+QEAgLTEzMjEsNiArMTMyNyw5IEBAIHN0YXRpYyBz
aXplX3QgbXY4OGU2MzIwX3N0YXRzX2dldF9zdGF0KHN0cnVjdCBtdjg4ZTZ4eHhfY2hpcCAqY2hp
cCwgaW50IHBvcnQsDQo+IAkJCQkgICAgICAgY29uc3Qgc3RydWN0IG12ODhlNnh4eF9od19zdGF0
ICpzdGF0LA0KPiAJCQkJICAgICAgIHVpbnQ2NF90ICpkYXRhKQ0KPiB7DQo+KwlpZiAoIShzdGF0
LT50eXBlICYgY2hpcC0+aW5mby0+c3RhdHNfdHlwZSkpDQo+KwkJcmV0dXJuIDA7DQo+Kw0KPiAJ
KmRhdGEgPSBfbXY4OGU2eHh4X2dldF9ldGh0b29sX3N0YXQoY2hpcCwgc3RhdCwgcG9ydCwNCj4g
CQkJCQkgICAgTVY4OEU2WFhYX0cxX1NUQVRTX09QX0JBTktfMV9CSVRfOSwNCj4gCQkJCQkgICAg
TVY4OEU2WFhYX0cxX1NUQVRTX09QX0hJU1RfUlgpOw0KPkBAIC0xMzMxLDYgKzEzNDAsOSBAQCBz
dGF0aWMgc2l6ZV90IG12ODhlNjM5MF9zdGF0c19nZXRfc3RhdChzdHJ1Y3QgbXY4OGU2eHh4X2No
aXAgKmNoaXAsIGludCBwb3J0LA0KPiAJCQkJICAgICAgIGNvbnN0IHN0cnVjdCBtdjg4ZTZ4eHhf
aHdfc3RhdCAqc3RhdCwNCj4gCQkJCSAgICAgICB1aW50NjRfdCAqZGF0YSkNCj4gew0KPisJaWYg
KCEoc3RhdC0+dHlwZSAmIGNoaXAtPmluZm8tPnN0YXRzX3R5cGUpKQ0KPisJCXJldHVybiAwOw0K
PisNCj4gCSpkYXRhID0gX212ODhlNnh4eF9nZXRfZXRodG9vbF9zdGF0KGNoaXAsIHN0YXQsIHBv
cnQsDQo+IAkJCQkJICAgIE1WODhFNlhYWF9HMV9TVEFUU19PUF9CQU5LXzFfQklUXzEwLA0KPiAJ
CQkJCSAgICAwKTsNCj4NCj4tLSANCj4yLjQzLjANCg0KDQo=

