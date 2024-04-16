Return-Path: <netdev+bounces-88387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C27E58A6F50
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 17:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F34A2819D0
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAA412C7FB;
	Tue, 16 Apr 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dB+oy5JU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E85D12BE89
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280003; cv=fail; b=E8BhPcUEAn4A09fgiQd0ZbW+wgqTCOLBlOwRptDFcP9hIILuwhHsex/h7Ts7R2lxRgTgZEkFhOhLXQxAgu70YHr4b5x3nToOQzgSUryU+M6dul1JVJRb/HfvOqxtL4cSVr+nsIgo7VfPAFoMgjHGyVSBS0Qh3sS5RSjLnWjgEJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280003; c=relaxed/simple;
	bh=QRIZaOxx8ztPai5Q84FT4JzWLPix0cYcyknVreXhLF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FbnwyjEKhtd+rJGYFbKA7XAM7Z6F48NJ0h2LZ3tH8G6ZLiKwZ0lmPmmej6YrG+DoN3mqb/DChf/uJMYj2kyXHYbDPlSlBWCONPkW4F91YRLi5rXetU8eAGkYfkAW5tlymXnkVX4/NjWne9hGQ+S1FyOpIDcGg3/RzSnUrru759Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dB+oy5JU; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713279998; x=1744815998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QRIZaOxx8ztPai5Q84FT4JzWLPix0cYcyknVreXhLF0=;
  b=dB+oy5JUxMHwx6mZ+/of9tyAV6wR3k0DM3WjDTvr7qwLIPFgV+MZJ5ki
   kKZ4jIsq7xabpi67y25vOh0Ck6jRNWOkNaNPg0aHQIC57tJ2k1R4WYocx
   S+7xXAcQWLn5bh+ZGjep4GroxiqDtKb/fOzhFlzJNQsp8ZtfrsbUXdvfP
   XvrricAPI90T/sc5+JJFUFu0PPXD6QmMrZ3Zmy2cp6e6OnxYtT0HNpDoq
   yygrNSo15DQumrGMZvZk+x8Nt7sVK8hTSl/k+pmi10X7AG03pgKuerM3O
   x02dGA6hUjwU9Uy6ilF47G/8ofWeUWzpv/QvAvMEDqyNwqQMV2Pn/j0sn
   Q==;
X-CSE-ConnectionGUID: JeU1sUovQPCBLn6WPaHDgw==
X-CSE-MsgGUID: /d9yV18QToirtYMUfxNvsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12512424"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="12512424"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 08:06:38 -0700
X-CSE-ConnectionGUID: qclXDwaNQDKtP+AtWw8PVQ==
X-CSE-MsgGUID: h/28QpLAQ3qhUuqkTXz0Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22344917"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 08:06:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 08:06:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 08:06:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 08:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKbdgaRvS83Zrc6am27qARX9rCQnRyDpKCExlcc8DTjXvXN8ywdnI7ih3NX4/hkOxLXlxFGfz0Wyidryec8tBKcUtM1EOZ03itS33hxfFeb77H0y1LmvnIYDZCrf4nAQrINs8AwrXyWqg9mnbXteJef1PLl84kts/4JWu+Dl693r/oDvKilOuvp+0s173DK6PjUypdoOIRf6sQ5GIoTmW8i1IGRCYhbERQAswYRSUkMAp0fkG1mBH6DRPyCd+bJLo2ZifqFD4fKuQXxxUJJDptAVv3kRf+zXj5ufkiHM9hoa+nxFUd3dQuThHTPwiMRYllgzyLi6bmVLzTOncaW1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRIZaOxx8ztPai5Q84FT4JzWLPix0cYcyknVreXhLF0=;
 b=ahSgdqq9ABbu+79FCD7mHm6CGFIPIXbdSytmp2FdVbacY2CObV56z9v4EYoBHTW5dcTQS3gT1oNCT+CBxuIAUECdwTkrScalC6+9tpkjxX6WGgHAxY9cv6cSbMef3PrS/BRi0rjMlQ/cLspFGVL3XiTb21X8dHirVJA9nE6PzDNAccikxzLIw4cqBJcb9dE+uTo1hLJUcQvxPlKiz6DoTDQojSs5qujiDuku+QGcVkAU8bKVcV2LVPopY2fxr4vuuBl9INUI0H9Bfvp5/lRVJYEurmWZYuVo3RSwmb7hKqisBYYwhILFKo0Ot/QE64fRf1IxmdwzsLBeTsyYQm7scg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Tue, 16 Apr
 2024 15:06:34 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::27b8:e131:8ea6:a4b8]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::27b8:e131:8ea6:a4b8%3]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 15:06:34 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>
CC: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Chmielewski, Pawel" <pawel.chmielewski@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Wang, Liang-min"
	<liang-min.wang@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5] ice: Add automatic VF reset
 on Tx MDD events
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5] ice: Add automatic VF
 reset on Tx MDD events
Thread-Index: AQHahpkhndhrf2Sis0KwNztK0x5gB7FeZSaAgAyswxA=
Date: Tue, 16 Apr 2024 15:06:34 +0000
Message-ID: <SJ0PR11MB58650E908FAE86CBDDBA5DFC8F082@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240404140451.504359-1-marcin.szycik@linux.intel.com>
 <20240408133217.GI26556@kernel.org>
In-Reply-To: <20240408133217.GI26556@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|SJ0PR11MB4974:EE_
x-ms-office365-filtering-correlation-id: 7e4c3bc6-0e8c-4eb6-36f1-08dc5e26ce8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dz4wJGbN8hPszWw4xYaJauVCDb7PfgtnL9KIMVVlBMQVXvTAseuapqc/PH30cgXZawGdg5QTkbwT/a/BmsDeHZP0ZG9ysp6txzYdg+9q5ZQOHdtRRf1o/BFmf5x6PvOaXfCJMNq8mysXo1Gw8f4cfLVzQpmLscjl4zB9c4f/acI7ZvdbcZWIk/K++hxhIdSgC7xEpYHNlDzGUXWFMdph0iR0ULYUhy2Y6G5q6Yqh/mIZGubUbHQK4Z67AN4fP5pIY/0AYq3qrG7j2jp47Suig3LW/YRjhMKn1S4a/czyCkW4F4tXxn4nmYtBZC4rBshun03hoewPWDkP003wt0Inx179UbwFbf5zG3uJRd9C/59JYb7XnC3TucJ2lhdqGUgY/VOD5bY9pGspR+uYzOfS0ZW5S9E5euXPWcbNruKTyLDQBsSLtL5Ug8bSElD8jfHVQlbFhb4ZCcSR+K65FwzIOre51hyQiRaRdyuuTcyVBKijqzZnaan3m4/Jhrb1oKF0eqRTV0oz54cVhtp17UxHbf1498O2UBte7swbI7UwmEqCSLtbgP9+X5Ou/4gHhjizuSuQ5wIeyAodr7uf/+6HJT58B8IxpGDSSEz0sGLR+RHh9Reh627NrLX1AtnUl73P44WZQI/S5CfXIu06oU3troprN8NVcaa+aQ/etHQXUPlEYy9affY1VNIxZSWBog7naIc39smJq40yxV5TdUE2cXHqzzCdNqdqZ43m52K6ETg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WsRA8rUigIfgQ9QH3Xvlf5WVBIiwi058SiWLgJ62ZOJgX3lXXa4OWnHedo5s?=
 =?us-ascii?Q?+d3THBrJsB5WCL8xF2vrRKXnC87dpgzEG3bTfJLSgf88Zyt5ldsw6Z0itTti?=
 =?us-ascii?Q?sFcr/Fz5yYHOaJD6yIOpUISSQ6sjBH455cIOnrSFPCfKqYUlrxpb0A/2HMrw?=
 =?us-ascii?Q?B8SXBDtIHOvTANcJi1SWNmS9Y/nyZ5GhjVwja3OZQ8BiWblGKi6XUsL8BTIQ?=
 =?us-ascii?Q?fGmnwDtLsJ6Pfq/YSl6qaAbjcGdT9ztSZ3woDMH2eFtTOFunsrrn6iO5BeyF?=
 =?us-ascii?Q?7PdcGU/eruIFUBN0NB+fz42YE+13Z3/Ac5Uh8Lj34cH1BO/xaTUGoKYpqmZx?=
 =?us-ascii?Q?9ZS2lkEBr0FHsPwMJb5/BOicS4CxV24nErb/kln9bAlFAkG8/5lMAmld1cMz?=
 =?us-ascii?Q?Uhnooo2jfXwhFec11WGV5YCl8azbNDzgeTfwim0WYiR97GJqxFXcBBqrQ3Pg?=
 =?us-ascii?Q?1eKszQY/4hcTt/xpEo32luFAI9s6kaD+u4avfknxEbqhZL7eDAXqu6ZV6K4W?=
 =?us-ascii?Q?7e5e6xhc1xblryhZZKMXT5tRW6u6VcAJZuFhspvB8b0gImkHzG3CarhOUS3e?=
 =?us-ascii?Q?CEO1UD98aHgVhpt30gpGz/qC6hqcr+BPXAY5OPQQVx4J8pX7Kl73Z6tYWDH0?=
 =?us-ascii?Q?h4MgZGiPr8N5XLThBnYMvTjfURM81MSnAXs7z9nweZ9ruJW2Z9HWUO7lpnXW?=
 =?us-ascii?Q?fyKZJ8f4eDh3gzmHcpo0LFsvXwhJpNSl7C4TGf3NPdMQoM3Q3CVy4gBgw2iT?=
 =?us-ascii?Q?4eHa5jg+Nn7fWJR1h0S6BDEL1/CfYWO7+LNStoV7UJcPIhJ0+gW3wZ7yJApB?=
 =?us-ascii?Q?QKxhilLqKCj1picfxQD9meKFCLVU8sq2gxAOUIx9oWs6Up+a+EjhHU08mjHi?=
 =?us-ascii?Q?BrnxKWSZCqXWrrN0nA5eKBYp4l4MFUaxC33Pa3fJ2TKs1x95ffqPfM0oe+AS?=
 =?us-ascii?Q?sgqCJeO37GpJZcJRjPk/A53DpzaJo52+DLl2zKVibdH9diDYBYvjTbwCBMZr?=
 =?us-ascii?Q?XRUYEVzXUjxz4wkMpTtvg55Lb09o1OXa5wSmmB+uI/SbU7/3k/DtA0o3kFio?=
 =?us-ascii?Q?dATu80STJZUdozUdsO6qB88fD96An3tBCBeBXmfy4jorSqj5TaR9stIccaYT?=
 =?us-ascii?Q?QZc3chBZkBK9H1IeDVgC0B6Ln/V/1gmKj4gHV9mXz6cPy/EYBDuP236hUxxd?=
 =?us-ascii?Q?QRZJop+9aapkcU6ZJU52jxGHteBNKEjPh53lPUEksBpdxXii+Ey+1l0ZG6MZ?=
 =?us-ascii?Q?cnYtz2VQDSMgzqcYPF//Uz4t+UV847Dtrsjy1d2y2dusWrEIfnkPbH8N/HT6?=
 =?us-ascii?Q?lXTfLIjjQrV9HzUeWXkhwcjgNIXMQwjcOueZKBiVZhT1jJaj+KLe503LPzXn?=
 =?us-ascii?Q?mAZe0Bl7jaPjTBCxkXtQ0lUGinKL/Sj/37yO7p630Xgs3+8UbjBWcAdH1koB?=
 =?us-ascii?Q?UllK5eluDDoqDqzS3q6wS38qoKNMqhmi3wdKRiux2u6H0rPsQHiKJ2JEU1rj?=
 =?us-ascii?Q?nXLGvk3HkQGK2X2vDDuaaKJxK9gjORV6/Uv8n++vHaZYhat9a7WKBIl0ooGp?=
 =?us-ascii?Q?AJ1hPzgyYuk0Crm445r/rVdt2HK0mZUolSnyRLwK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4c3bc6-0e8c-4eb6-36f1-08dc5e26ce8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 15:06:34.6746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wyIykM5X3BBBDlXrDFaBa824YvmCGIuX/8J5oUimO4KEwkD1qV37P1cu7lS8uBDAYFGlymhrcgqMQufvwMKaz5TZ3ksPm2DVKoUHPh2hl4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Monday, April 8, 2024 3:32 PM
> To: Marcin Szycik <marcin.szycik@linux.intel.com>
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Drewek, Wojciec=
h
> <wojciech.drewek@intel.com>; netdev@vger.kernel.org; Chmielewski, Pawel
> <pawel.chmielewski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Wang, Liang-min <liang-min.wang@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> lan@lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5] ice: Add automatic VF =
reset on
> Tx MDD events
>=20
> On Thu, Apr 04, 2024 at 04:04:51PM +0200, Marcin Szycik wrote:
> > In cases when VF sends malformed packets that are classified as
> > malicious, it can cause Tx queue to freeze as a result of Malicious
> > Driver Detection event. Such malformed packets can appear as a result
> > of a faulty userspace app running on VF. This frozen queue can be
> > stuck for several minutes being unusable.
> >
> > User might prefer to immediately bring the VF back to operational
> > state after such event, which can be done by automatically resetting
> > the VF which caused MDD. This is already implemented for Rx events
> > (mdd-auto-reset-vf flag private flag needs to be set).
> >
> > Extend the VF auto reset to also cover Tx MDD events. When any MDD
> > event occurs on VF (Tx or Rx) and the mdd-auto-reset-vf private flag
> > is set, perform a graceful VF reset to quickly bring it back to operati=
onal state.
> >
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Co-developed-by: Liang-Min Wang <liang-min.wang@intel.com>
> > Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
> > Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>




