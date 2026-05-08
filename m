Return-Path: <netdev+bounces-285682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB6tGZOK/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:02:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B22CD4F2BBF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BFFB3041AA2
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11837B3F6;
	Fri,  8 May 2026 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNYii+KW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9080520E702
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223681; cv=fail; b=RnRezK0VHz2MeOVpBcjeoiTD5uEIS/MGhawLoEmvzOtHHc6e+moe4jKqr3pcQsDmAvBpEMH3aRwMTGMMJp7S6GpSgwUlbURun+KpF/tMYTzrmUSybc0uiyeppWJwz1veWPPnBlBV70NxKmYeHp1yqCD88pPP3Zhbs2XCxWdQusM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223681; c=relaxed/simple;
	bh=2LHYTNKuFn8MiLXWNkriKnHoTKqwscUlNF/vWyXXkxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ec0tnQm3Lxg9URDuLqggCdKREusjkEzYD6yeOA2BfsSm8Ud083GM+d4NdGuIbwksPGud0OmPLupvBx5iccEgLiPTrEpQH4lg2sA+2y1bKi0gFXAUEPnTwiijiySdwrXiM3xPjw2PPT1NsLteCt9oke4jNesViDgfHGbE1dGILT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNYii+KW; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778223678; x=1809759678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2LHYTNKuFn8MiLXWNkriKnHoTKqwscUlNF/vWyXXkxk=;
  b=gNYii+KWjN1yZSgDtpimibR7vjuQJH1ZRacC/vn2QfKpVTcGR+tDKX3R
   o7xZHx857QG1FxdX187ueJMawm4msfvR53fDOB2JbwR1n3Tpv63aFa4Bi
   UHGi7F/zQL9lxTCmfmsJ2VnifmWeTSVd2h8vUS65H48dm9K2yRu6wNxbA
   mZRnQKy/D1HltdbYahYBg5eFlEM/x7X1iedSgzGer069rpNRzs5tire0h
   bzqTONbn5SyVPIWFRcgsPtPvhXEKS4w5YFWRypN9OJgjKRUFhghbmTYmm
   h5j2RTwEatjGXFhDCQsRRCb9h2x3I6k6EpcYalK0/upK2eaSRwYbxvJ76
   A==;
X-CSE-ConnectionGUID: FeMC4VRyRnKbLsfLbS0cCA==
X-CSE-MsgGUID: m2H4xoMBQyW9b2VbcAu67g==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="82809054"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="82809054"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:01:16 -0700
X-CSE-ConnectionGUID: PnqpABKMRIO0IoUFoPc9cQ==
X-CSE-MsgGUID: Dzf097aRRN2W2ycpO3MQmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="274808813"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:01:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 00:01:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 00:01:14 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 00:01:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXLIT1LFNe1HryrXNSopU9qlNn8jT86tzChMBB06l82c5JOwWo4qn/qe7a3N+IWQCguUldhNiiq9aTckPdabycNeosFqHGlGtL6Bjf7Q2zGn3xX2gkY4uO9TfadBEy1zUrQNS4x0kO1RDyxI+8bzwW+4T0UfGy7P4h+ZpLshH0dloQS8E4onRWQs/ZVCfDCoyGW08FxXp53Fh6R3ch+mBE1Ei2bYZelu1I7MKy/UVP5kgP2OHHZs4A8iWyTou2geoUFc8qq7QRBlWFkNrkm95FWxTCjJKuyZh4usJVDEnhYikwxy2elQXlkTRaltD2DcCnbCLD2dQ3g3mvtZgao69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LHYTNKuFn8MiLXWNkriKnHoTKqwscUlNF/vWyXXkxk=;
 b=ZzmaN6W5BlLsrx/BwlJbvBo9Jl4419AoROkz61zKvom8ungzFQ5Uz+d7WmVLwhSRa7N84UHT7FfFmrKpw67bU9efhc+6WHt2TrKtLXLesfiNe0XwhI7IBbbWhsB57+6mymdIv0zAvMTNMgWeLVYsB50gUfYBPiOMwNrfs9ahaYXaJ9CHk8xHK7WCcTUWjQU2YqfqlYHa17XC7mRjdjN5XoPs5Y/sjYXcPyV6vjIFfGc2h7rfUte2rEuxpU2bibbgPFS4EaMUhLr9VT0I2AotzuLJ0D8eQJ0etM1gZPp4oAa6E0r3bCMgsIXjrji5O3eaSF2Sw+JmB+n9PFj/B91Q8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) by
 SJ5PPF64191BB3C.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::82f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:01:11 +0000
Received: from DM4PR11MB6261.namprd11.prod.outlook.com
 ([fe80::66c7:4013:fead:be53]) by DM4PR11MB6261.namprd11.prod.outlook.com
 ([fe80::66c7:4013:fead:be53%4]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 07:01:11 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: fix locking around
 wait_event_interruptible_locked_irq
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: fix locking around
 wait_event_interruptible_locked_irq
Thread-Index: AQHcvbqvTxlL10IWWkyLXzDvHMN4cLYD9I5g
Date: Fri, 8 May 2026 07:01:11 +0000
Message-ID: <DM4PR11MB6261C4034D8882E969C2BE268B3D2@DM4PR11MB6261.namprd11.prod.outlook.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-2-aleksandr.loktionov@intel.com>
In-Reply-To: <20260327072332.130320-2-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6261:EE_|SJ5PPF64191BB3C:EE_
x-ms-office365-filtering-correlation-id: 44a054bd-f45c-4622-29ae-08deaccf9651
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: /fdurh+hYXv4j2SuttrZSua2rXq8E8gOXT6D62z5dgt147zZnr5S+QpLMbxeOB1mYqZVDNJO3qJf5R862Sl6OkGqiCsfJaoKHh28ejOl842teHODWF3z4h7vwlWI8/ug4eTYliLsZum0MP7CDG0rPjBHCQfF3481H0fgbzu1A+qYdsmWRnL4ByHK5JogKdsA8AB7K7SQEtr7Hv1kskPLJ7ReyTUQx0Tef7bFvuu0lswFokTBMs4yluWADt8heTYgGJaO/Wnyf4LsPXfvgan1nKsh8aVhckTZTBDDmxVw6Az2Y79N3HTNw4Q/1qVJhr3tuSfcesABi6MOzLvqlroWOhFBrCIwVnhsAdio+iHORyQS46w1zFzg7F5sDceE84+Kx4e2DQzCd4CVYm3v3Qbcfs9iPgli4Iz49ZCcxuEfYUDOcSiw5DlLRr+WdqIN4IqV3BCd/4W3UDgnRCQIVLc2zYuG5sfLk58A9QP7YtcqZdMEkz+gU3rTwfQrarPOhJxPg0LewJYG0DPlbh7kK5TovE92hWJGGhQv6Nz7v1Sct+ZZt0hbaCx0djQSFOaGdueW2Lt5KDwhsVbldXZxcTv2UGxRS+anvJi500YYMSUj+77JdqWsqgGTBVQ1uSTSsWhchDvZv8ZSxxTomA+kI0TEkfxe+sYT1M/MRaNlqgtreZXD9DBs9H7C2myGDasOhUU7C5J9GbUe1gojkXoEjpq++em0pwiMrFs3xwes0yZX4Da4qF3/kmfKv+9nuGyNXlKj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6261.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QNiprl1lY/a2LXUzJbTFq5LK0i+z5brx7tiAg1HlrLB3ZIUGMWFX3h9QOb2+?=
 =?us-ascii?Q?9JtmUN0HDJ91a9N3m/tuaTKV8+jPwZ9iSCeAs8LTBnIejtDDRHc8ZDyZAdcE?=
 =?us-ascii?Q?5X0yRd2sPVlSPrgmIUKwJhVcACX629gQN83GNTy2fWPNZm/MN/CdaiuD1u6P?=
 =?us-ascii?Q?azdv7mTPcSDV7fVZ94c60w8GjE6AJAC7CBWrMTLIjsoXKZ9WgBAbbcL45kF5?=
 =?us-ascii?Q?m5wHmZE2mJaaxdoYaGGryjzPbY9O6GDZKVbAcExptBeePoGwkMbXh36D2jBX?=
 =?us-ascii?Q?TWdffNPaprm190LmnIGF4as2F15ecdHN0NiNfisyFdPXD4Kz7dS400PDRf7r?=
 =?us-ascii?Q?ihp32xm6g74kZnGjwjL5X2p15HNGSdQXLBrFvPfcOMAVddRbSGPKV81B/4CO?=
 =?us-ascii?Q?c3w2U8YzUfcSgYtEuQN4wIseXaps/vYwF3mxH0kF7fxGkmXzwVhVt9Y/a9au?=
 =?us-ascii?Q?VSe/xL0xMJj6ibVtFkvBiPvwSSv8umHFDAGcMOfNJB+ukgZXDhn6xBzbDQRU?=
 =?us-ascii?Q?TePwd1Cf0CLdiW71CsNKZQwbpyo98FUGPTS7O899niMBIy1qX+8zrOfrGoxK?=
 =?us-ascii?Q?i4l2V4aPF7IVjqEec+4D/msKlrM7vEy0lkQ3V4c+UPYKAnEWaJpXSeH3M4B4?=
 =?us-ascii?Q?fxG2B5sC+bZD7cYiO2YZnEbassSaMYg3E8S0yR7jGYQf8mtG3Dq34nnCEMjC?=
 =?us-ascii?Q?wulZOm2hMBlb9RINXRgZC73vmqnAp0ypR75YOWhC2kBRveXCiQ/ERuuh7qIK?=
 =?us-ascii?Q?C1LmVZ62A8rZBzwHZ9awxtyyy5QiKkD1MFbNBe067LAmACwIN0SX4XacID3K?=
 =?us-ascii?Q?TCMPutDRFjCPehUEskUaugAAS5LkphpIWLH6Y0ylJrqqA9xHrt9AwTYz9Az4?=
 =?us-ascii?Q?rctFsxxxJHQB3DTTgsnV53vAiMw5vQdeANqrZK2290AW6myGAPx2qI+zZr6z?=
 =?us-ascii?Q?e7Qzy2cE4aYmBnV7CR9mpoQqP6YYyT7UWKevIQGuz1p7PfTPfJv5fuLrZ/LZ?=
 =?us-ascii?Q?HnaeuOcTVWMDkgkiNebWchYP+RS+hIvD0ozI0poQoUZmHP8Yb9r8pAUEg8CX?=
 =?us-ascii?Q?DgHo6gJHzw5Ypr9Slejmtq3Ez5NVQzSTn7qjdsEd243oWsB4QbAxdexjmx5+?=
 =?us-ascii?Q?f5F3Ke0p1tabtBxXO1HENy9SxKWxBbcjMeTlUcfX74ceWvQMkdclL11QDORf?=
 =?us-ascii?Q?hJxIHGQOa+FkfjOmoBbiG6+/EGVP/T0Y0kC1bSU17Umfz9E38S1shiG49LKf?=
 =?us-ascii?Q?AlWalEy70ibu1Vs89+ZwAIrMCATgYejpukk/AXEsYZ+gFubpNfjW+NLXOJvH?=
 =?us-ascii?Q?odoZfeWDeuKjnplYAOrww78r+fkvj3ZbxOnaZUMelcsnUgewipVFefLY4Rvr?=
 =?us-ascii?Q?ry6i9fJoz+VNXal+6NxmmxsKsAcjf19Hlg7yI08poz6Cud3hieOH1MnH8Trl?=
 =?us-ascii?Q?omZr+gwA9bVog8ZaVL+uc1lRbbjVXYraGuK7A8jpQHHeJdUnn4C06J/zMQIn?=
 =?us-ascii?Q?cnXBnNcrMdsgVaKnmNn8u4xyaX3lX/2cgtn+Spq4ZP4geinBK287vIbb1PO9?=
 =?us-ascii?Q?r7Yi3LJuP8FHfBK5LAkQ4QdB3hEw8pOoKqpXV9AMjXeIchThXg8dKJycxT0M?=
 =?us-ascii?Q?e20uTnJicd688bWmBjrP1KamjWkY7M9y2+WCtWoiVI7aDXED1TtWX5rasGaT?=
 =?us-ascii?Q?0NqNOSTnWqCPNvUBhlsX/9hHvONK9KvGCniOt9zsQjC1Wxez?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lHc5pH+XoHZMrBwM3MCmyfoeBSslP4/OygTe8V20wWfi2/J6XJl37X3U5US2yW6/iX43oM6urz+fnzg3q68cWrZUzxXerqq2WrgZ/2V6TABxQZh0Iyv2QolB0QCTI0stCkBvKpOAXTiAHXbi/waOzHY25WG060rlreRVbguHwburB+DCMq1WEoJ/M+lGq7+XBROp6TUM9m6mSIPKLQSppgmkX7bE8EDhcjJgyV34NxMZRAJSim5UzN45mikvycU1oI5vrTZoGsweN3k2/vbRp3A2pwFQwF1U1pwiJeByMaQQaBi0GHq9Y/t3VZiaDtig9qBRbhSdr6z2FQeImb4Kug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6261.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a054bd-f45c-4622-29ae-08deaccf9651
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 07:01:11.2466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wq7vydtaSp5+mrD10qgfsEPjsiGCkanVGEx/iTIUXPV+NnPMMaf3jf1gIkk34lkqhxwBQB+1WpnHoXxUh5mVGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF64191BB3C
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: B22CD4F2BBF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285682-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,osuosl.org:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 27 March 2026 12:53
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Keller, Jacob E <jacob.e.keller@intel.com>; J=
akub Kicinski <kuba@kernel.org>
> Subject: [Intel-wired-lan] [PATCH net] ice: fix locking around wait_event=
_interruptible_locked_irq
>
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> Commit 50327223a8bb ("ice: add lock to protect low latency interface") in=
troduced a wait queue used to protect the low latency timer interface.
> The queue is used with the wait_event_interruptible_locked_irq macro, whi=
ch unlocks the wait queue lock while sleeping. The irq variant uses spin_lo=
ck_irq and spin_unlock_irq to manage this. The wait queue lock was previous=
ly locked using spin_lock_irqsave. This difference in lock variants could l=
ead to issues, since wait_event would unlock the wait queue and restore int=
errupts while sleeping.
>
> The ice_read_phy_tstamp_ll_e810() function is ultimately called through i=
ce_read_phy_tstamp, which is called from ice_ptp_process_tx_tstamp or ice_p=
tp_clear_unexpected_tx_ready. The former is called through the miscellaneou=
s IRQ thread function, while the latter is called from the service task wor=
k queue thread. Neither of these functions has interrupts disabled, so use =
spin_lock_irq instead of spin_lock_irqsave.
>
> Fixes: 50327223a8bb ("ice: add lock to protect low latency interface")
> Cc: stable@vger.kernel.org
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20250109181823.77f44c69@kernel.org=
/
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

