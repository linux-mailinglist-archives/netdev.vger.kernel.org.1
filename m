Return-Path: <netdev+bounces-263273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOSADkn7pmltbwAAu9opvQ
	(envelope-from <netdev+bounces-263273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:16:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 294011F2510
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A36BB3018066
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDF648124B;
	Tue,  3 Mar 2026 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbRpTeas"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9A480968;
	Tue,  3 Mar 2026 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550758; cv=fail; b=dGDbgak13YOiU/SEtEXFWOYsUo9UM2bHUqHMcOA3mygRk8kxtjNPQPWQatTvHCNHgw0ts6r6Zt+zrKBxav2OZes0aDCvfQCm/gm9zsG3YdtgJENZMDi2d8aSUkr3pqgSuWYOGZjzmwkvcj+Z7642eWMHos95RaL/tFoF3MgvBH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550758; c=relaxed/simple;
	bh=ilfLMmX0FLNciJmQ4mMVLV+FhhXLiU1kxcUTEFuJ8CQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAojv3yXY5c1etiu2HwykZrr1UjssxKBcYh+WCvBtmeTQtOLrXeIeWarOGsXlCJXPP2AqJ554GMeZySXNV1tVQC9dIy4+sggKPzYFzq2M82D/5yvF1clkfWI1QXqRS2D81gBYwh7CdF4l7QtuH7REQflUg8492PDmCjf99HMVt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbRpTeas; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772550755; x=1804086755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ilfLMmX0FLNciJmQ4mMVLV+FhhXLiU1kxcUTEFuJ8CQ=;
  b=gbRpTeasHD970XgBKI/U4XyUFB4C0jnZNQBYdikjjqXV4MmIvfEc0Xt1
   0qulVyHAdUW2/2m3QC+qWonMB36KLCdkz7GyUXN5nfANgXYdHHJURqDNp
   Efw2N7Y3BQGrRfi4A80q4hY8CYlLcRcjkHCbvEjunqnqYwd7LmFRwrZB0
   oTv76GsXiIU4eEej3Fb/kI+ycJkOhZ+SPmIG+ZTQPqFlesaVbTHAQsURc
   1nl8Z0HrgKmKaZrgb+W21//D94E/ZHtKwmXulMGPTCfg3Jo1mwL6O80l/
   QiZ6eLbphJDIzriyoyglA3TfE4oLogBRKBdV44mDfV9PjkQik6nOiq4M8
   Q==;
X-CSE-ConnectionGUID: XdSkJmFrQ4SYeKttpwTvkA==
X-CSE-MsgGUID: /iqcfr0mSV+P7nnyec1U7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73710880"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="73710880"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:12:34 -0800
X-CSE-ConnectionGUID: 3bd42/ZVR1i1wEPTI/62gw==
X-CSE-MsgGUID: 9af6KkXIS26IrQFcaaH0GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="244863494"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:12:34 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:12:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 07:12:33 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:12:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZII0TnHX9ghVarlHk1PyYuYPxRQi2rMZeqMv0b4Kwj3yx1hKs8b1HzFEfTQSQszMA48gzodm8aF9Y/jrm2rwrdwhekhYQewB8v5w4IOb0+Qt+OgEo9bvP3fsaqpp5DTDa00dlFfsYFXYusYdsk6rqvV86HbLtA5SpGGn1w1cGwe+kgHvPKFC2YJU9gUcS6JFcsH7OX12XBfGMOw1GQUunpBKU5Ej5MBNvzOZEWC5Bu5FZJbCzf0ycNqFBUYMO5ntX2dgNrz8kDFX/rD0cMPN3fEPL3vBRl1JENFmGGTn5GLYz4/01jF5EPFxcsnGtkZMeULTY45AA405aKdmi7BCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yng8eRcFjah+ePVz1eaps/Ys9kqQ4mx/TdgdWr6vpmI=;
 b=Wp8WeNEelNlS62Zb9HSNt8wkmUlWAOdIIhAEAkr5n2RC7DJayzD850FjuGEq64/qszJEdpJMEBzjPUVT13/9YhBYzPcBV4M4kTgilAM8tlKWnPCQcEO97Nu0sAp5x5PjcPVZLPXuNLSh8PwFTMa578lWDQuX/2vEpQBAfoB9e3Ww5Lx3PlR5b5kccaVU+2m8srzlookKpLgetdjvA1dXoM42h1BlpBGy7SU4vYXiCXO65fZqfTw7ODkk0HKmRxYvlpLzNpejk15665S8NICk40LRVe6rKJR4tfnmi+FJ9WTkozhRzn2vCbMLXw8h5s8bE97N48DHItm3AJCT27VgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7384.namprd11.prod.outlook.com (2603:10b6:8:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:12:31 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 15:12:31 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jani Nikula
	<jani.nikula@linux.intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: RE: [PATCH 00/38] docs: several improvements to kernel-doc
Thread-Topic: [PATCH 00/38] docs: several improvements to kernel-doc
Thread-Index: AQHcoL88GZR54j5iykSjAqU9CRGQErWQVEUAgAylJACAAAR8kA==
Date: Tue, 3 Mar 2026 15:12:30 +0000
Message-ID: <IA3PR11MB89867A79259D027E855F38DAE57FA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
	<33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
 <20260303155310.5235b367@localhost>
In-Reply-To: <20260303155310.5235b367@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7384:EE_
x-ms-office365-filtering-correlation-id: 677b2ffa-8760-4c9a-533f-08de79374a55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7142099003|38070700021;
x-microsoft-antispam-message-info: BVDzw1j5CA5nLs5EYq6bRWW6wURooS0xkTbOerys4tryrgq6sjBGv1PADbqIc0GbnSGIB4mOBtZjgx65XlccXb9OJyoPD8jV3knJogy+AMiFeNAM4BiAZ8pZrBzrvPOibv13bOQAqZxk5A8WkQYNbNor6SDMIzAKSfJNw+KurlPy/CyomJR7YuqkA2e3Fb0ptUAM0wD++CUvvrJqVt3oN3BWNhNs/luuRfQlNoSVFt9iSHA36hZ7zd320MwYFFxOEjcG384pemtdbTfdoTKJ+Ru17pr8sV/QeHexxLdcOnWaJcRoEF6MMxuG6NJ5r/9A17s1Ke7/wfAqQg4l/SJSFNQ5IcPnwE59Uv8559heq67GEbKsPTI/CMAQ3TxgU6OCBkPorwqYKs5OGB2m9rubNkFkV25UYiCkqc/2YJUr4w62k1qOVhQ4cPb5PtKnWzm2sghRK/F2IdI9VmI1CYmjGSCX8GLE8zJb+LxvCvViS02ns53g67I4D92b9Yc8cxiZVFa3yFV988zPia06oLYzEb2xBQMOrBsyYIWG+HH/XYp/13L6fSADC1fqn4h3O8GRVYaxADeOU+GnD5otA99SrzXifOjNvfrgMkmBAZCWEf5CmjxnUsZq5RtAwGSA74LSK9vcWJ1uxMpnpfSXVVg58Y7hrod2NIR+zsI/fVKWKLVtyFaOOdEZfGmfXwhIBn5DxsNcfGBGufG8B2w/QLuVT8YtSczGzUmDuHTS8PablGw2e0OeiIvDEn9IzG+yyuVrdjpXDjHAsOP55morwLAEc1/krd6clCV/8kvM8eahjnQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7142099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5GSe7JBREBnluper344E3dzg9HwRwcSwDZFu0rxgFQu4GS+F50DqFyj1m1pL?=
 =?us-ascii?Q?sHSkqGye6Qs4F6mnaCgxVpqAV7VmTFJTFmkrudtwZgRcOr4MrGEsUp2y21ql?=
 =?us-ascii?Q?eRbzZoK3IX05ONZhLOlZiwoBYWCEzH7LnWgulgMLIzsE2DxckSjp9246FuY+?=
 =?us-ascii?Q?77EiGTPSW6iw34Rurj2N+QdFgAGIaybNWegxVq5tk2EH54/DXbclsb/qrGN3?=
 =?us-ascii?Q?jMg7vVrBHNyZ8k+/rwAgvhjuo6/OqSCzPAvSPsjsZ4BKpKeY4GwhdzEGpxcV?=
 =?us-ascii?Q?XXvo40dF99rNhRchDEDcb2DMKVvNPF3kBOCi+jpcviUzyPbZyVjpNa7fErke?=
 =?us-ascii?Q?axH6ZZUxmqt91FTMofmgzy9rKNh/L9ZDj3Gob0UtLCDzeJimzP6POH0lI2pE?=
 =?us-ascii?Q?Itrt5NO/gyZWXAUk7H+Pn+6HiSK0TfTQsM0jtlXy386rpA4AQhw3Hqrl1daU?=
 =?us-ascii?Q?cOu3lQ6TV3Ye+h52xXkW6mTDkd6KWWYjS5FSD9n0cinaNW3qZR/068brdhIB?=
 =?us-ascii?Q?0/49phCyzQ7VU1Zp46rrA1xuPmnxg2LRdO/RV/jRpsfjYclxyfvpXHl1G4pV?=
 =?us-ascii?Q?xiTnU+ujF18e0wPGj4T+GVKO6JhXS1dXUm4ybEqtAyljGk/8GOAdWTuafKDf?=
 =?us-ascii?Q?0cyLU38H283bwKM3qQiK1b++81p37rr9rSSBY1k2yk/bBi8VNAwBUDIlhMWs?=
 =?us-ascii?Q?CJ6ae/M7vn5YBWMoWv0GSDW6mnTTNBa3W4lMgmJykd8G0N646C8wlbq4tFNh?=
 =?us-ascii?Q?UHnxWdJuBZQObrPSI2aIjm/MvzmgVekXTtho5NiwQyc6NCCdLUArj11uxr0q?=
 =?us-ascii?Q?DqIz4AdBrS1T47zrXiWdBeO+F13ABkLe64kUZeuPk1U2IvyZpKUxp7A/3mEg?=
 =?us-ascii?Q?ihc7QDtJO6ulIHEtPgzFLX6K11dQAixxBNNZZOP8fW8W+hHX8/0eSaQAqg6y?=
 =?us-ascii?Q?l7ECZ53e77rdVURCR5x8Qzs9Y0L9qY8CWiNhABK2gbvuC3JJLePRVT7YSQyz?=
 =?us-ascii?Q?TaicinVi/4E0/9z3el2uOHcuX4M9i7AcoJGvWQVCMNE3AmTA/QiZ4CQ7WAuN?=
 =?us-ascii?Q?NLZsu6y/0IMoOXBkhRjVFJAp106jDk6f3JClpHTiNMj0YyJ2PI9bDxtX7g3y?=
 =?us-ascii?Q?SZ7H2SVzUx84+y1rIWrKAZ/jxuTU5NMmY61YkdzMcoLpKmwlCuTCJoaeCkhL?=
 =?us-ascii?Q?0rC5TAtroLnN6qqXzdZwWrWbMsxE5ys20cBbcf+t9rT5Rq+M3roc0n5PLqeR?=
 =?us-ascii?Q?Hk+litRkjiNSZjvEeZnS6KSKAwCMfsrPMnQN2ZQBOUL1Zlr7J/SO5m1xUe0W?=
 =?us-ascii?Q?UyKlyiVQy9uOAVY/HstzkY3hGzG4xY41K7LlGIEEpzkYQanq3Yywfoz5OyxJ?=
 =?us-ascii?Q?xH6RroRpExfsZ3aFZOFHbFBec0lB28ZqpDFWiTV4CcS7hhk86hZ19+8NPJw6?=
 =?us-ascii?Q?mDYfKlnHslP7pq5N5FqpQwOVWr/xxMQi8SMaBPBrEqe6xB1B1MFncanxRVJh?=
 =?us-ascii?Q?MfBND0FGMNJPmj88QIiUXXvTpDaetYNTnyyy8i8100bNCpzcgkx2bl7vBJSH?=
 =?us-ascii?Q?DxDY42wr7C3wlpJ9kw9dFCrWmxFjk+YToFu0z9L2AI41H9hIVS/nONZx4un4?=
 =?us-ascii?Q?00XBJRWicKxwJqRv5xx8xSrXhJzd8D9c9/gxLZIxAKi6XOK3rtgK2SZXIT/n?=
 =?us-ascii?Q?0EiT1q29nHYUHTovcwp1Rg49ytTd1xjScTaiIpXWp8da3CLiEjoUOofN2hZ6?=
 =?us-ascii?Q?FYK6tlm3DiWaCJ/pc0p3QE7g+5fFe+8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 677b2ffa-8760-4c9a-533f-08de79374a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 15:12:30.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCifkbs9Ao2ibF6+ygDlVZBxePWs440e6mqXVrNcOIHc4zp6g1ajrZ/7ThDAJTt4Igih4Mmc2kmeOhMgNAnhJUO59rWei+Y1R5M8jvEZiT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7384
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 294011F2510
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263273-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Sent: Tuesday, March 3, 2026 3:53 PM
> To: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Jonathan
> Corbet <corbet@lwn.net>; Kees Cook <kees@kernel.org>; Mauro Carvalho
> Chehab <mchehab@kernel.org>; intel-wired-lan@lists.osuosl.org; linux-
> doc@vger.kernel.org; linux-hardening@vger.kernel.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; Gustavo A. R. Silva
> <gustavoars@kernel.org>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Randy Dunlap <rdunlap@infradead.org>;
> Shuah Khan <skhan@linuxfoundation.org>
> Subject: Re: [PATCH 00/38] docs: several improvements to kernel-doc
>=20
> On Mon, 23 Feb 2026 15:47:00 +0200
> Jani Nikula <jani.nikula@linux.intel.com> wrote:
>=20
> > On Wed, 18 Feb 2026, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> > > As anyone that worked before with kernel-doc are aware, using
> regex
> > > to handle C input is not great. Instead, we need something closer
> to
> > > how C statements and declarations are handled.
> > >
> > > Yet, to avoid breaking  docs, I avoided touching the regex-based
> > > algorithms inside it with one exception: struct_group logic was
> > > using very complex regexes that are incompatible with Python
> internal "re" module.
> > >
> > > So, I came up with a different approach: NestedMatch. The logic
> > > inside it is meant to properly handle brackets, square brackets
> and
> > > parenthesis, which is closer to what C lexical parser does. On
> that
> > > time, I added a TODO about the need to extend that.
> >
> > There's always the question, if you're putting a lot of effort into
> > making kernel-doc closer to an actual C parser, why not put all that
> > effort into using and adapting to, you know, an actual C parser?
>=20
> Playing with this idea, it is not that hard to write an actual C
> parser - or at least a tokenizer. There is already an example of it
> at:
>=20
> 	https://docs.python.org/3/library/re.html
>=20
> I did a quick implementation, and it seems to be able to do its job:
>=20
>     $ ./tokenizer.py ./include/net/netlink.h
>       1:  0  COMMENT       '/* SPDX-License-Identifier: GPL-2.0 */'
>       2:  0  CPP           '#ifndef'
>       2:  8  ID            '__NET_NETLINK_H'
>       3:  0  CPP           '#define'
>       3:  8  ID            '__NET_NETLINK_H'
>       5:  0  CPP           '#include'
>       5:  9  OP            '<'
>       5: 10  ID            'linux'
>       5: 15  OP            '/'
>       5: 16  ID            'types'
>       5: 21  PUNC          '.'
>       5: 22  ID            'h'
>       5: 23  OP            '>'
>       6:  0  CPP           '#include'
>       6:  9  OP            '<'
>       6: 10  ID            'linux'
>       6: 15  OP            '/'
>       6: 16  ID            'netlink'
>       6: 23  PUNC          '.'
>       6: 24  ID            'h'
>       6: 25  OP            '>'
>       7:  0  CPP           '#include'
>       7:  9  OP            '<'
>       7: 10  ID            'linux'
>       7: 15  OP            '/'
>       7: 16  ID            'jiffies'
>       7: 23  PUNC          '.'
>       7: 24  ID            'h'
>       7: 25  OP            '>'
>       8:  0  CPP           '#include'
>       8:  9  OP            '<'
>       8: 10  ID            'linux'
>       8: 15  OP            '/'
>       8: 16  ID            'in6'
> ...
>      12:  1  COMMENT       '/**\n  * Standard attribute types to
> specify validation policy\n  */'
>      13:  0  ENUM          'enum'
>      13:  5  PUNC          '{'
>      14:  1  ID            'NLA_UNSPEC'
>      14: 11  PUNC          ','
>      15:  1  ID            'NLA_U8'
>      15:  7  PUNC          ','
>      16:  1  ID            'NLA_U16'
>      16:  8  PUNC          ','
>      17:  1  ID            'NLA_U32'
>      17:  8  PUNC          ','
>      18:  1  ID            'NLA_U64'
>      18:  8  PUNC          ','
>      19:  1  ID            'NLA_STRING'
>      19: 11  PUNC          ','
>      20:  1  ID            'NLA_FLAG'
> ...
>      41:  0  STRUCT        'struct'
>      41:  7  ID            'netlink_range_validation'
>      41: 32  PUNC          '{'
>      42:  1  ID            'u64'
>      42:  5  ID            'min'
>      42:  8  PUNC          ','
>      42: 10  ID            'max'
>      42: 13  PUNC          ';'
>      43:  0  PUNC          '}'
>      43:  1  PUNC          ';'
>      45:  0  STRUCT        'struct'
>      45:  7  ID            'netlink_range_validation_signed'
>      45: 39  PUNC          '{'
>      46:  1  ID            's64'
>      46:  5  ID            'min'
>      46:  8  PUNC          ','
>      46: 10  ID            'max'
>      46: 13  PUNC          ';'
>      47:  0  PUNC          '}'
>      47:  1  PUNC          ';'
>      49:  0  ENUM          'enum'
>      49:  5  ID            'nla_policy_validation'
>      49: 27  PUNC          '{'
>      50:  1  ID            'NLA_VALIDATE_NONE'
>      50: 18  PUNC          ','
>      51:  1  ID            'NLA_VALIDATE_RANGE'
>      51: 19  PUNC          ','
>      52:  1  ID            'NLA_VALIDATE_RANGE_WARN_TOO_LONG'
>      52: 33  PUNC          ','
>      53:  1  ID            'NLA_VALIDATE_MIN'
>      53: 17  PUNC          ','
>      54:  1  ID            'NLA_VALIDATE_MAX'
>      54: 17  PUNC          ','
>      55:  1  ID            'NLA_VALIDATE_MASK'
>      55: 18  PUNC          ','
>      56:  1  ID            'NLA_VALIDATE_RANGE_PTR'
>      56: 23  PUNC          ','
>      57:  1  ID            'NLA_VALIDATE_FUNCTION'
>      57: 22  PUNC          ','
>      58:  0  PUNC          '}'
>      58:  1  PUNC          ';'
>=20
> It sounds doable to use it, and, at least on this example, it properly
> picked the IDs.
>=20
> On the other hand, using it would require lots of changes at kernel-
> doc. So, I guess I'll add a tokenizer to kernel-doc, but we should
> likely start using it gradually.
>=20
> Maybe starting with NestedSearch and with public/private comment
> handling (which is currently half-broken).
>=20
> As a reference, the above was generated with the code below, which was
> based on the Python re documentation.
>=20
> Comments?
>=20
> ---
>=20
> One side note: right now, we're not using typing at kernel-doc, nor
> really following a proper coding style.
>=20
> I wanted to use it during the conversion, and place consts in
> uppercase, as this is currently the best practices, but doing it while
> converting from Perl were very annoying. So, I opted to make things
> simpler. Now that we have it coded, perhaps it is time to define a
> coding style and apply it to kernel-doc.
>=20
> --
> Thanks,
> Mauro
>=20
> #!/usr/bin/env python3
>=20
> import sys
> import re
>=20
> class Token():
>     def __init__(self, type, value, line, column):
>         self.type =3D type
>         self.value =3D value
>         self.line =3D line
>         self.column =3D column
>=20
> class CTokenizer():
>     C_KEYWORDS =3D {
>         "struct", "union", "enum",
>     }
>=20
>     TOKEN_LIST =3D [
>         ("COMMENT", r"//[^\n]*|/\*[\s\S]*?\*/"),
>=20
>         ("STRING",  r'"(?:\\.|[^"\\])*"'),
>         ("CHAR",    r"'(?:\\.|[^'\\])'"),
>=20
>         ("NUMBER",  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"
>                     r"[0-9]+(\.[0-9]*)?([eE][+-]?[0-9]+)?[fFlL]*"),
>=20
>         ("ID",      r"[A-Za-z_][A-Za-z0-9_]*"),
>=20
>         ("OP",      r"\+\+|\-\-|\->|=3D=3D|\!=3D|<=3D|>=3D|&&|\|\||<<|>>|=
\+=3D|\-
> =3D|\*=3D|/=3D|%=3D"
>                     r"|&=3D|\|=3D|\^=3D|=3D|\+|\-
> |\*|/|%|<|>|&|\||\^|~|!|\?|\:"),
>=20
>         ("PUNC",    r"[;,\.\[\]\(\)\{\}]"),
>=20
>         ("CPP",
> r"#\s*(define|include|ifdef|ifndef|if|else|elif|endif|undef|pragma)"),
>=20
>         ("HASH",    r"#"),
>=20
>         ("NEWLINE", r"\n"),
>=20
>         ("SKIP",    r"[\s]+"),
>=20
>         ("MISMATCH",r"."),
>     ]
>=20
>     def __init__(self):
>         re_tokens =3D []
>=20
>         for name, pattern in self.TOKEN_LIST:
>             re_tokens.append(f"(?P<{name}>{pattern})")
>=20
>         self.re_scanner =3D re.compile("|".join(re_tokens),
>                                      re.MULTILINE | re.DOTALL)
>=20
>     def tokenize(self, code):
>         # Handle continuation lines
>         code =3D re.sub(r"\\\n", "", code)
>=20
>         line_num =3D 1
>         line_start =3D 0
>=20
>         for match in self.re_scanner.finditer(code):
>             kind   =3D match.lastgroup
>             value  =3D match.group()
>             column =3D match.start() - line_start
>=20
>             if kind =3D=3D "NEWLINE":
>                 line_start =3D match.end()
>                 line_num +=3D 1
>                 continue
>=20
>             if kind in {"SKIP"}:
>                 continue
>=20
>             if kind =3D=3D "MISMATCH":
>                 raise RuntimeError(f"Unexpected character {value!r} on
> line {line_num}")
>=20
>             if kind =3D=3D "ID" and value in self.C_KEYWORDS:
>                 kind =3D value.upper()
>=20
>             # For all other tokens we keep the raw string value
>             yield Token(kind, value, line_num, column)
>=20
> if __name__ =3D=3D "__main__":
>     if len(sys.argv) !=3D 2:
>         print(f"Usage: python {sys.argv[0]} <fname>")
>         sys.exit(1)
>=20
>     fname =3D sys.argv[1]
>=20
>     try:
>         with open(fname, 'r', encoding=3D'utf-8') as file:
>             sample =3D file.read()
>     except FileNotFoundError:
>         print(f"Error: The file '{fname}' was not found.")
>         sys.exit(1)
>     except Exception as e:
>         print(f"An error occurred while reading the file: {str(e)}")
>         sys.exit(1)
>=20
>     print(f"Tokens from {fname}:")
>=20
>     for tok in CTokenizer().tokenize(sample):
>         print(f"{tok.line:3d}:{tok.column:3d}  {tok.type:12}
> {tok.value!r}")

As hobby C compiler writer, I must say that you need to implement C preproc=
essor first, because C preprocessor influences/changes the syntax.
In your tokenizer I see right away that any line which begins from '#' must=
 be just as C preprocessor command without further tokenizing.
But the real pain make C preprocessor substitutions IMHO



