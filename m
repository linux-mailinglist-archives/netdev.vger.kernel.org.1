Return-Path: <netdev+bounces-76781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB7986EEA2
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 05:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5277B210AB
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 04:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC05F63CB;
	Sat,  2 Mar 2024 04:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YATQyt/u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06464B
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709354321; cv=fail; b=hH5Z7KuLnT/tw5x7/o0O+g/FLgovN9IDhfQawY3io1rIKUg6Wob1ughAv+E1ZUtPKme3d+fVGmKSgf/rqVJtd0grDVsfH5gGoUQsS13Da6J6TFY+fLq3wj3+7+ddkOpVc2mnfyO0dKpQ3568S9egDo1CoT3pCGZrSdfyMS1AvXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709354321; c=relaxed/simple;
	bh=KwRwH8q/e2V5khtDEXL2xzgUXC77ntw1QgBTS8IjNYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RODrmxeRsdotxP1HCK9C3HRLeJBHiwZBJ5xbBsH6mjbLyFO726SY2ErZlU3aR69QIeIy6H0rIvW6dPNghkg7jmi5etx/EbzFrIR/WesXQWm4uwOTFWYmLhVS+Y/jj3vk7an0xc0etAc92Aq/eC+MVVMeJdO3+oZc/KgINqiF9YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YATQyt/u; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709354320; x=1740890320;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KwRwH8q/e2V5khtDEXL2xzgUXC77ntw1QgBTS8IjNYk=;
  b=YATQyt/uprIP3ZcQwcbWheEcKAan9COhytcEdoZgBF9N/iVk+WVlS32n
   czKGXd8StA5Xye1Wkw13hxDhqtuvDnXJjGq4kFnlaLRlRTUAKxuaHjxQT
   rEAJmwLGP/Fp7eCdkhsX8eM+qe9iLLqpfuOWl9PS0azM/m+zPopATPwan
   CPSaJcm93tgTzyHRUFf2oi7IlIqX0F38zw9bbVZ/N4Ntchiqu1kpFqi8L
   LZlerFK7A/lwl5FmxcU/gvTdHn+s6q6yAhXP8QH5LtCXPKxH9PooPuxMh
   4AlD5zsjucgc/70MidN49YBOOiC04wCoVKg+3nJDQ/lR6Z0sLUP5HVDMb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3834298"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="3834298"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 20:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8343225"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 20:38:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 20:38:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 20:38:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 20:38:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 20:38:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e317Kvm7khtFwcvh4hSXCjJML8PvlsW4qW3omevx/entrSzRy4p0dKfS+9GADZrkNihpODtpm09/kysUXN3phAwfrq4zCVDLnhGnqon0JwiFAlNSNOIZ+YUQGPkdggAdh/4o3ZDi19bqnbycM6fxVLf7yGP2Q5amM75mq8jUmA7uxvqSc2c4cKRZ11tK1syLoEyulnqqeSgC+odopSWhvRYpsbhrOSzJvfOfNqrtWuCKpBHtE69js7AgLn13ekQBZHVZxiPAQza3Vut05mtwc39Kiit5ijOgE0Civ8TaZeUFlWuQ4KIN2momveiZutQEue1Bpn9kL7XA0kBebwNyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5o5yp2Z9HtKjULTTQ/l2BlPiyjD9iV7Y+aaUM7C4hU=;
 b=n1VzpK5zbz1zCmVdwevXs/+ASXXGkK1dkO5Y5cYcH4GvI9DGjWR9OzpErkteb1kK38Ohv+btpyWxtU0udahJlyL7iSklrXv3Lgyv576NxSkgZvzEyWhHsvwP6PE5TogumTxkmSmLQvUFyCIDzVziz/Rr5ku+Qoj2kqXV4i+YsMXNI7/P+o4fHYucD7WjaFenWu0A/30/X8a4yjqjeicWCULr58OtRw1wl2D82D79Ca6t5Bax9J7ZHjUKNfsuY3rmMmsCSGMBiQ6nQ7ZDOQfCFIzII/wEfkz6Vw42+NY0hzvGcj576/yAsqnr3eWU8wiHx05xrQh7a66lIiENgC7Nog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Sat, 2 Mar
 2024 04:38:36 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636%3]) with mapi id 15.20.7362.017; Sat, 2 Mar 2024
 04:38:35 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: "Brady, Alan" <alan.brady@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brady, Alan"
	<alan.brady@intel.com>, "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
Subject: RE: [PATCH v6 07/11 iwl-next] idpf: refactor idpf_recv_mb_msg
Thread-Topic: [PATCH v6 07/11 iwl-next] idpf: refactor idpf_recv_mb_msg
Thread-Index: AQHaZcIxmkJryppC1EGmrhrTFjlYqrEj61hQ
Date: Sat, 2 Mar 2024 04:38:35 +0000
Message-ID: <MW4PR11MB5911A7DE62B47EF848A692CBBA5D2@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20240222190441.2610930-1-alan.brady@intel.com>
 <20240222190441.2610930-8-alan.brady@intel.com>
In-Reply-To: <20240222190441.2610930-8-alan.brady@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|SA3PR11MB7628:EE_
x-ms-office365-filtering-correlation-id: 2e84d23f-2a0d-4844-2a11-08dc3a729fa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 98rX+qyxNZ4Ggm5PZr5kE+DRjqtl5NA96Qcnxjs6h+yT7LwB0XoaniyBAxZzUky001vUaymY9BOdGlTlokqSEUux+yXwema7tJ+kP0vdn6xQiTVSPOU8TMxcYfayJPR7+FZfauzCzxM8tmpd30MG2KBq0RVhy0u3SHM8jerFmBIYfgEQRoMMnzWMNWhosJWM7P7qv3djS+Wyw6LlGtUjC9xIN/F0kBXhB3DHdmun7d/0h7jATcl3CMFhUGpk8kzEXbFCSc8bUe+CwsQ9Z84pNnBOGWqEZg2mjrph2+kt/Xv7Apz0IPwGP5bdFrGjV6wIAiKH7QuWPHyUsbrtPP8Pra/OKDoq2sqhNsUNRt6NTCojrjqyUYvXFCoG2jXE7v54EVjbAvh7tf1/lEBmHBiIq46cGVSy4rv5VeGMbno/ZvShrBvhD81wrj4b2Kw5eytMuwYsS/v6FH4I3Vrz5jqL+X5f6ZQkFJnUqE/0y5eT8oD7F079gBWObPj+Dy8lTa7JJtfifEX1/CG7tGnM3aSQZH/HbfVfEIYm5Oj5Lihs3RmhdbjwqckUHHKCijtQX/VhWVqVohQa8n/1H/EIaxawuhM/3IAl98fgL7rueWUZ4O7sbV8Git3ZsuRRj9egefq9XDT/mGIlQAhzbsTCVxb4N1O7x1idiQRzBTacQyrSPIEvlBlxxNB4Ikbq93p/q9tbpOWiGmJdpzO3+6qtHYZI0mMF1tYbLQ4UytoByjW47oo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?knyu2bmKXQt6CUiPbxRkvwGrRJaerxkUirTP8MEt5B2UF2W0YtwAjg5Ap6ew?=
 =?us-ascii?Q?/yTNhKFxjvA5yaFBX3fijl85wB3Xc9vr3JtJ5lLVvwm1luckvqEQjsNm1DU5?=
 =?us-ascii?Q?8Ml5Ik9AfqD/VHOfeIZJ+hzR+J/im8R4vQenElmrKbULicEXifsp0hrvNwRj?=
 =?us-ascii?Q?0W1zFiPT0imvl+/T2zxBliFlr2fYHAHsymFWucz3PxNnxts3hbCzDh1eSq8I?=
 =?us-ascii?Q?PqrzpOIG5Qzs/B53PJP7cQNls36B1tlOzZ6EndRbzWuYx063+n1ei2qU9LuS?=
 =?us-ascii?Q?/J+wLpl739oY5NeTPWYEK7IDMZy7Us6FAkOdRRsBLEYjsAbIwesysqP1nwR7?=
 =?us-ascii?Q?M87MqSUDWroC7M8r869ESa2cnEkRC0d3CeO7jlzuCQAfwu69sWpNModdBcWy?=
 =?us-ascii?Q?ymgB5Pg0o6Nly4mltTbjTVlcdTXlKWklBFCXbbK/gAlIQ8L9RCfYUi9mBiIo?=
 =?us-ascii?Q?/kc11tcnc2Sllm6Bwp/OGWxRRdrnpN09bobLA0DLdqBTY4Udhv0wnxda5IvR?=
 =?us-ascii?Q?WS4L/1SsmC2aDQ/xnqrrQAsRUDt/HY32DmfW9ysdGGvugX1ItycE7t5P7kOh?=
 =?us-ascii?Q?vA4KedMEXpWytRcpw6O8rg/8ywX5meMiWKuLZSL6GGT68riltolb+6ip3qDi?=
 =?us-ascii?Q?Sh6GIQWmPLGGs1r6mHrZ+DRGUZo7TKA00j86a4nALfQR8880FoHhqzJnCy6u?=
 =?us-ascii?Q?cW7GLmoRJttt2aoLwLgxPnCFYMsufCAqIT+bXFvlfT311BMEYuco8gKpPlCD?=
 =?us-ascii?Q?/ib+cIrurKzlXMn0g9ACSuIHS+mHRibY917P4t8d74ElXoMDHTzYnPkTXeG2?=
 =?us-ascii?Q?A9gzW9hsxdxLMQY6w8Pv6zl6Oo/e0sii41IPALiqUyVBNBTr5QDGozSr04fj?=
 =?us-ascii?Q?kX5M5v11fMzbhysWFcelqikKDqwkJ/ioKPORvlKWi20SQDalyb8ZJIn53KVS?=
 =?us-ascii?Q?y4dC2Ozm0aFdTSXtVizhBLU6mOvuYU5zbhpEz22PvAKb26V8rbCIq2ER3Xlo?=
 =?us-ascii?Q?5fkvXjy4/mMBJpEG4+Yxw8mXPJpwE92Sm/nsbHWQ2KZQpmw73zv+obQM46Lc?=
 =?us-ascii?Q?OMUOy5kDcw8+OfHcLoywvfr2KjVLxCCCO/1EphhDS4jKrPjAngsISW/08Zkp?=
 =?us-ascii?Q?4+gjstVJ8uifwxmePzUOlrE9IZ9B9UMlwK2QD4h26nx4/vbS9L3NSlh5uEJc?=
 =?us-ascii?Q?wVhi7VG8emJV/jBiLbpLtVuovssj3rcd1aqKwOyeZV+pwkFj1UBlpESArg9D?=
 =?us-ascii?Q?nUOoa7wOgRYutmvy7USqEHdDkdI85vM8aeLWOXRXtF0qAaMrpajyVbTn+fho?=
 =?us-ascii?Q?5HQN1G8lZ8nhtkzn+fYijioDgR4wpj6Vb6eGq399eTcbwA3v+ExuP7Sd7V7Z?=
 =?us-ascii?Q?+jDHhFNZy/I4OUPpKW6lVpodLJuIv7/E/qt/TrgVka+Hc5BBtmKZw8Vb86ne?=
 =?us-ascii?Q?QF4y4J8GMoIqybXB5L9wKR2BMMImOMaFSn5dgdUJpBt0Dhx6+y1iu/ktQt4d?=
 =?us-ascii?Q?lhQq5qneK6/Sffj1Hxh23UkjX/QJyhfljMnhLsN0e84c4BzQlzzhiagMVJfR?=
 =?us-ascii?Q?ztt7N+x9KTU2PqgtaO345LlQ/ZsHYsdbzvw0iYEIbm1GSwtdyiTDdu6SBBlL?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5911.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e84d23f-2a0d-4844-2a11-08dc3a729fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2024 04:38:35.8157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLc5vI5+YtJtYyhYZzDNnU1qtpZEK5QOg8FXgTUy0g0SxCUyrW4+cm2bQojXRpi35Uu+S6DHIFAhgfS8HfEi6GPycga5vS5L87ZOWGM5RF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7628
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Alan Brady <alan.brady@intel.com>
> Sent: Thursday, February 22, 2024 11:05 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Brady, Alan <alan.brady@intel.com>; Lobakin,
> Aleksander <aleksander.lobakin@intel.com>
> Subject: [PATCH v6 07/11 iwl-next] idpf: refactor idpf_recv_mb_msg
>=20
> Now that all the messages are using the transaction API, we can rework
> idpf_recv_mb_msg quite a lot to simplify it. Due to this, we remove
> idpf_find_vport as no longer used and alter idpf_recv_event_msg
> slightly.
>=20
> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   2 +-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 254 +++---------------
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   3 +-
>  3 files changed, 37 insertions(+), 222 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 96c0b6d38799..4c6c7b9db762 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

