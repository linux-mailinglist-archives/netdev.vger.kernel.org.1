Return-Path: <netdev+bounces-262766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLSNFGrMpWl3GwAAu9opvQ
	(envelope-from <netdev+bounces-262766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:44:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4EB1DDFE3
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C293305E379
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D263FB059;
	Mon,  2 Mar 2026 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Baf1W91X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C1410D3B;
	Mon,  2 Mar 2026 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473215; cv=fail; b=WaqFI11esyhWk/65t7fxsSdrWMWsYI0CT4qjdu9bMOwrikZTMP9fmeLwbvuRlCrJ+Y9Wjq/YyJzOz8fR5XlUMi/XLj0J7YdaaPgqs8ZtjaAqitGf43eHqq+ds0OVuZZ1SLMrdqdfluZIy7+QZmpO5dyxtuPJo0ViHo/xzFN3thM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473215; c=relaxed/simple;
	bh=Op2kFR1MMGHtGmG9WrUE/j6XqWRhcMEHuntnKZkkqA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PllbDnKbL6UB6Pr0ChoirBcKlgXuaW1cPzgGR3MYeSSxBVRIfCxAlkCOHwTnlTcg0mNT7W8dOhFzhoTnvssnZcPhiVYREQpAlnrLMXUdmcBSu2Zr6N4nTzr1r3t+WwD8V3abSmefp9cDmHHXicI3UiV43IELL7GxTAZeMUvExpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Baf1W91X; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772473214; x=1804009214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Op2kFR1MMGHtGmG9WrUE/j6XqWRhcMEHuntnKZkkqA4=;
  b=Baf1W91XK1/W/6/VXnmDHORHTcqjKJGdLAOVYnQIXL5Z7tN7Fg4zwxCQ
   p6JWSVywa8IWTkL7lOD5JWr/7RAaUOtSI2S0RJ3TGiQF0+NUjKelTQyR7
   IyJIYtc0l8EUnpgrksWLJ+Go4BujDwM5OVO2wT0Cv9rIuItVWfLsfqv5T
   V+oiFLGBPBI93wtdIeb/8jlT4un+qOyB8W3QaWHuACUb3NUpmySc3jgSx
   MKsj7qrUK3Hb4o6sVsgCNRso9MWfm0n+NBYwkkuFXAN6C3CBXOmsR7rQY
   sUp7jcKnB31Df9fWqHv9wXzrdwCELjn4AcnBWgbO5PC3SZEsW+b/VChtB
   w==;
X-CSE-ConnectionGUID: hnT/h5QBQsmURqaF0o+Hpw==
X-CSE-MsgGUID: MjKgjT4sS8yW9n1zRaNndA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="61061207"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="61061207"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 09:40:13 -0800
X-CSE-ConnectionGUID: C3RrWvjVR7KqrtWb08v9XA==
X-CSE-MsgGUID: no7xduOnS0OsfsHy4LEmyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217642333"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 09:40:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 09:40:12 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 09:40:12 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 09:40:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CG1BCmHaLaJy0szwmOGy599EtoFU6VabuACxfczY/9gmLO6drgVDSKHBOYZ02At/uISqhmsCXZqBTIL/8M/pCJfg6qmVFdnMk04hYwCXqAEoeQjDpD8OXsge0xh7DqMakgddYlV4Bxv0G5OMHpt820MmPDUlsO7EEP9LfofRfg/HfbucXqsD6cDvtglN9vmA08ueOxm5/d/AEAt35eL+MxpGpggjoDZZsPF/gI9bDlZ+YaNAMXpWoWuaY80BZw61qB76mFITq6bBu8XQLMBauDyLjogOvLgzZC6vvySv1rr3nO27B+uWBbEt0M8WHmLs83RhY/Ep7fwiaY1bSUW3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIQGGxKcbtWpqstd3heBddni7ytOa+ynocZ91Oquzdg=;
 b=lcJVHdsch+GzNoeCNRbZiGMe0jNUcSlmI6jrTeHhkRmrAVYiN+sWjIvh/vdqJz8Zv5MRkNZc6OZmkqPFuVrQWzmEHzJeJe3ubiz82sqiOdGcmX/rBnGJzAqGdJOKcoS3IIS1OFyzu4vg8ta0v3xD5OYpQNDaYxVAKcwbPHpMqQ1CdIkq6jGAmgGY0cGHPUMhJTT/ZwqIXV89Z2XRHfWUZusdsyfytf0Oo1FesNGPblla+n6HvljJqnoroN8NkfPegMPdxJojzCr6xeaV05o74AHeunPPcSY1BMayI9YvqIQFH3+HILZw8/QqNIpQLiNhbogQM7BRdGNSPrronW1fwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF6806D69E4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::831) by BL3PR11MB6458.namprd11.prod.outlook.com
 (2603:10b6:208:3bd::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 17:40:09 +0000
Received: from SJ5PPF6806D69E4.namprd11.prod.outlook.com
 ([fe80::16a5:1a74:21d8:8e3d]) by SJ5PPF6806D69E4.namprd11.prod.outlook.com
 ([fe80::16a5:1a74:21d8:8e3d%4]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 17:40:09 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Slepecki, Jakub" <jakub.slepecki@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "Slepecki, Jakub"
	<jakub.slepecki@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 7/7] ice: in VEB, prevent
 "cross-vlan" traffic from hitting loopback
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 7/7] ice: in VEB, prevent
 "cross-vlan" traffic from hitting loopback
Thread-Index: AQHcle1PbDvcOZbavE21yW/eAHtrPrWbq0mw
Date: Mon, 2 Mar 2026 17:40:09 +0000
Message-ID: <SJ5PPF6806D69E4A400CB47BB1CF4A129FA8F7EA@SJ5PPF6806D69E4.namprd11.prod.outlook.com>
References: <20260204154418.1285309-1-jakub.slepecki@intel.com>
 <20260204154418.1285309-8-jakub.slepecki@intel.com>
In-Reply-To: <20260204154418.1285309-8-jakub.slepecki@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF6806D69E4:EE_|BL3PR11MB6458:EE_
x-ms-office365-filtering-correlation-id: 14cb01bd-aeae-43a9-8b5a-08de7882bfe7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: Ihh5TZWarJtI6TSCgEYazofOU07PNT3K04/68xsv7Qh3fVQDvUAh/8DCuRK3YSFjXhBflXbzozO0s9SkTz073ZnWaGqeu0bzFxdVuhjA0Y8zDaE7gPidPCH7KlXN2OB0QppgpsIkofS6sJFPoPqbmJabTD1XXRniyrUoLjCUYHmYIw1uoFR+DDcjsOjOR7eby8d1uDjYU2j4WQ+qe5rNSo+hdcbkIS6ewN2vlTk4m5yqzW4hKvUTCzVtFvsqWfOamCGn2qlNclGmLiNv29Q/TK9PKHLvjIpq99iOkpFFmSP985bwA/P8wN2M/h1HvQlCR8n5Z7J3Y4Gfcf3LvKiGmFgL/6dTjgYFxPNHr+F1tWTZIfJ6d+TvIJFZXym04eRODPVOz7/5iCtabxNYYq1kB0sTZ+8322OkshVKPaoo4L92LxzxXTz7jnnfx+G1VSh+hyDq4tjALY7ZjRbzrw5ikYq7FkGz3yB+ufcAsm5x6YgFoDJs/+Ljjq7hOQE2Pt3pnNi8kOYMogWSgpFhPsJER9r1mk5u8ZnB+RiMQVzt4RkW7rwQ7KC+cJ27dS7A3eCwFz+Zj18ZOvaPCKMsWf5L9bRfEmdZqtD5tg/NNdLf1fYXzdXvzxv0pEcmAjolbMyCUWe7RLEKThykzVwDengolQBH9S1bYAn5gryUTHLp8UXK1V+iG56pk80cEgW6VAPqnxFbMhbUvGqkWibGCXGHvK6eGMwaqkr4FOiHXpsShnZJH8qo7uxFrdfQzVMh3XUe/6pU2Epo2VABUzrIblwJ+eGeMEaFqxbCZtXc4uC45Jk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF6806D69E4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PpAvkRadIJOizJsGJlFsAcuwVqVoO8EU1hO0mp79IAFKIRfvjJhPhNc3CIC5?=
 =?us-ascii?Q?iamf4hASyD+gb7Pnx8vUrUn5OILOE6HrYZclrYpFHoYm4OrurpRf060lZC7P?=
 =?us-ascii?Q?Sd2OwD1e89vMB6a/8xprtRNdiXQctTKB2GusHB4GLOcADrpgPM4wrtw8t8jw?=
 =?us-ascii?Q?AButxfW45hybk0M5sis2kBLHxvlyHk75BlNvSktqRKvZ56Gs7VNKGVd3fC7i?=
 =?us-ascii?Q?QYlWibXy7BGwl2BP9es6dRjiJYg4PiySJ2c4DHvlTMqmRyc+wmO2r506A0MW?=
 =?us-ascii?Q?os2m6DTTDjtDH0gjL4FgeUGLIvwkxJZm0k/TUM+5oEctGj+AjNr5u4iLrXFA?=
 =?us-ascii?Q?444sHVRDTzkZG93T4RyzRbpkpyS5oz+EPsG6wLlhBK2PixjB1LR42g1BGpHy?=
 =?us-ascii?Q?FNaQ9iYStE4fCMt3A5wAR420QZwsjyq6CUpKVqjvG97pLT0bXIGLzQGE3iz1?=
 =?us-ascii?Q?Bjp+Z/q1Sm6wY+gqgie3ihz41QP8mcq0WZXP4dAQ/efkvlOHP6hx82p+5i2n?=
 =?us-ascii?Q?efMH/ejc70n0poyhF6kFVbweaS/APt9aAH5hstEqmdCkad5ZZpX0RovvPNqb?=
 =?us-ascii?Q?bPS9+1sjixa/NCUlY0nSoyWX6+wNvj//+bLRYETAY/FWgmFWDjNs+eNrr6Tv?=
 =?us-ascii?Q?CRxy1/hgc3I4cwc6vEmtAr8A9lWoxRwQqVt15V+xdajlRMork1Qh6jflrGrj?=
 =?us-ascii?Q?Gs91Q3Z9GXXvZ2Nm1iFgx7RdUQbuXeQ5Vko/l/yYZ5oeZrKI3/kU2eEMwXkD?=
 =?us-ascii?Q?H9NyYRIphN3s91fUcQ4ewLJrAqj3Us7OzgtwAzbrC9nOqDJuJXKgNj/3/FfH?=
 =?us-ascii?Q?PYNQipYeSF337C69HXXoF2aK8KRueHuyk/yrzf/gC175f1VEDGC2Ovmd178K?=
 =?us-ascii?Q?GVKV8n/LyolBIj2ZG0bcBD6Sp/67C0Ws8T/F4vtpTC6DtmEOqrPEx/gKGZWs?=
 =?us-ascii?Q?gK1ehCZmkjXPd5WwMEqxDNY+NGDshegXNujppeZ4DaxUhWyl6Te+waj82PiM?=
 =?us-ascii?Q?6+ekpv7HbtjxIDARtDHpvKkZ9v/w3zn3tCkh0BE+e1LwuUwI4gZFIoyCd/kb?=
 =?us-ascii?Q?I+bWpw2xWNP0vW+vFD9OMXNlyS+i4AdZD53QZOuEb738LcMfenXZWcubJt42?=
 =?us-ascii?Q?73kOLkMcG7RGEwOSwlIya1b6tw2xVeroEHl80wvDjL+SHlHNzrCO3oCj9iAW?=
 =?us-ascii?Q?oBeW0QAIAQKUYAh99QI7H5myDzEOPA8H0R1Qg4l3N/QtJYodAP/5xIocXbrF?=
 =?us-ascii?Q?McSoTNQc5LnFA7OJWZieuj11S76/VH6fGfHzClHESuXlaBRF9mmSrbmoayxR?=
 =?us-ascii?Q?fqT7tOevQo8WhTaICI/iHrlbncCYx2dsvwkJoSjMRWmJ9Vh4lK+mvL+VSWYl?=
 =?us-ascii?Q?BcquhsUCKyvcwYwpDwEYrFp1elxPEuIgQdaLQ/YKTDyo6bK50VDxNuxm6OPz?=
 =?us-ascii?Q?E7Alq3GzDNdA8g6eJKpOpIXEzHSqACz2Rs7WGD3m52cwb3C/GRQlbhMJ8KgI?=
 =?us-ascii?Q?ZZeytk4Wt79NW6hx7iXZI2l4CNHS6qus9F1wL/ufSn7LREF2Ss+qqc8Zj35Z?=
 =?us-ascii?Q?Ye9z7VPnV10UiV8CHL9qEnOSberVM+cC8JxoUwzq9wUrtWoT/Ntz++aNflDU?=
 =?us-ascii?Q?Lgiia+CergPPYOtth/ZtKdABFmFKIV6LqbdBQH0B/yepT4iSSuKjSb9fImAJ?=
 =?us-ascii?Q?wPwWVZf/o6IkMeOu0pmdaB6HJBO1+hZY8j2FqhO/byiP7VAOevLP5+Ms4cxs?=
 =?us-ascii?Q?1DCtoVR5Yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF6806D69E4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cb01bd-aeae-43a9-8b5a-08de7882bfe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 17:40:09.3400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nxhd2lvbpPmRsnvOU1ySQtwZzHwbcCz1Tkdpm9G7/uC0bZRAdvu22rBq18tJNThZAXbBOJJyrclsG7KsGTnSHbaZf2Y/hqYK4jzgYmOPelA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6458
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: AB4EB1DDFE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262766-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,SJ5PPF6806D69E4.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
akub
> Slepecki
> Sent: Wednesday, February 4, 2026 4:44 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; Kitszel, Przemy=
slaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; michal.swiatkowski@linux.intel.com; Slepeck=
i,
> Jakub <jakub.slepecki@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 7/7] ice: in VEB, prevent "=
cross-
> vlan" traffic from hitting loopback
>=20
> In Virtual Ethernet Bridge (VEB) mode, we use MAC filters to forward traf=
fic
> between two VFs.  We also use VLAN filters to prune potential destination=
s, so
> that they don't cross VLANs.  In case a VF in VLAN X sends a packet to a =
MAC
> address matching another VF but in VLAN Y, both these filters will be hit=
.  Packet
> will be sent to loopback-only to VF in VLAN Y, but VLAN filter will prune=
 its VSI
> from the destination list leaving the packet stranded in the internal swi=
tch and
> thus dropped.
>=20
> Since there is no destination for the packet in the VLAN X, it should ins=
tead be
> sent to the wire.
>=20
> To fix this, we introduce MAC,VLAN filters in place of MAC-only filters i=
f VSI is part
> of any VLAN.  We consider VSI part of a VLAN if it has a PVID set, or if =
it has a
> specific VLAN filter and does not have a VLAN
> 0 filter.
>=20
> This approach does not attempt to fix interactions with upper devices.
> If an upper vlan device requests a separate MAC address filter resulting =
in a call
> to __dev_uc_sync, the VSI will start receiving all packets destined for t=
his MAC
> and not just within the VLAN.  I don't see a straight-forward way to reso=
lve this:
> information about MAC and VLAN filters coming from kernel to driver is
> disconnected from one another and from the device that requests it.  It c=
ould be
> worked around by, for example, tracking all upper devices with netdev
> notifications and adjusting the filters there.  Hence, the scope is limit=
ed to VF
> traffic.
>=20
> Following situations were considered for VLAN filters additions, removal,=
 or
> changes:
>=20
> 1. ice changes VF's vlan
> 2. VF is reset and rebuilt
> 3. vlan device attaches above a PF or a VF
>=20
> And same for MAC filters:
>=20
> 4. PF's MAC is changed
> 5. PF changes MAC of a VF
> 6. VF's MAC is changed
> 7. ndo_set_rx_mode et al
>=20
> When VLAN is assigned to a VF in (1), the affected VF is reset and rebuil=
d.  This
> makes (1) the same as (2).  We end up with two cases where VLAN filters a=
re
> added: (2) and (3).
>=20
> To correctly handle (1-2), we move the VLAN filters initialization before=
 the MAC
> filters initialization, since MAC filters now depend on VLAN filters pres=
ence.
> These two handle PVID (or lack of thereof) and because they are always
> associated with a reset, we don't need to consider updating MAC and MAC,V=
LAN
> filters afterwards.
>=20
> In (3), we will always have a lower device that is expected to receive al=
l packets
> for its MAC regardless of VLAN tag.  Because of the caveat described abov=
e, we
> will do the same for each MAC address associated with the interface regar=
dless
> of VLANs.  The result is we only have MAC-only filters in this case.
>=20
> When we create MAC filters in (4-7) we now check for existing VLAN filter=
s and
> depending on PVID and VLAN 0 presence we decide to create, respectively, =
a
> MAC and MAC,VLAN filter pair, or a MAC filter.  This is done implicitly w=
hen
> requesting to remove old MAC and add new MAC, so no change is required to=
 this
> flow.
>=20
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>
>=20
> ---
> Note the /a.s. dead/ branch in ice_fltr.c.  I decided to make it explicit=
, but it can
> be merged into VLAN 0 branch as well (with or without a comment), because
> their final effect is exactly the same.
>=20
> No changes in v4.
> No changes in v3.
> No changes in v2.
> ---
>  drivers/net/ethernet/intel/ice/ice_fltr.c   | 71 +++++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_fltr.h   |  6 +-
>  drivers/net/ethernet/intel/ice/ice_main.c   |  8 +--
>  drivers/net/ethernet/intel/ice/ice_switch.c |  2 +-
> drivers/net/ethernet/intel/ice/ice_switch.h |  2 +
> drivers/net/ethernet/intel/ice/ice_vf_lib.c |  8 +--
>  6 files changed, 83 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_fltr.c
> b/drivers/net/ethernet/intel/ice/ice_fltr.c
> index 96a4e4b1b3fc..c0fc1bced167 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fltr.c
> +++ b/drivers/net/ethernet/intel/ice/ice_fltr.c
> @@ -3,6 +3,7 @@


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


