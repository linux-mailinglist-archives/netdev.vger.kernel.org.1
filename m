Return-Path: <netdev+bounces-284003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GMQKXjo+Gmt2wIAu9opvQ
	(envelope-from <netdev+bounces-284003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:42:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C5C4C2B43
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5096B3029A6B
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389F13E4C6D;
	Mon,  4 May 2026 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PintKIDh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24037C909;
	Mon,  4 May 2026 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919952; cv=fail; b=qFZzQ9LbSQhvWIhaEtZnGaK/I0VeuNRip2rDOVRxzm0Oi+aiBWEWAC+yUIhpFtJLFcJJo6UYCZdvZ3zblIeHBW7GoeFVioFI8ByqCqKxLoElQJApC9TnebzYy68RslpkyYJgkoJ86ZjAfxOWJJfp9NQ2JQZZ/fcg7XDJ0/Cw+Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919952; c=relaxed/simple;
	bh=hkOJvOlfC/grcLpreje5fhFW6J+V8stan7hEnng2McE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ObW9c6RooFBaaUCLV96dd6rsAz2+UKsqab4Cn3PeHRhO3JIaz2EIDu8phjyDQdGa1uCsOb9yVdvWzoRMdS5cpE1eStGv/WSvsDSCKHvFr+cLUUR8RuVU2hjMZX4mH0HfO5gOEw2RktFSlnbL1j7Y1MplL0SdRjUSHhNsLXmZS9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PintKIDh; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777919951; x=1809455951;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hkOJvOlfC/grcLpreje5fhFW6J+V8stan7hEnng2McE=;
  b=PintKIDh/vKzt4xYVzOZtk04fv87SzDBdWO7AbkP8VwNN9U9P69Vli9D
   W7yO8E7dwsEh4/a80/ckANi4tK9N7UVYkyUhmlUUy5uFxi53WeAh45qMQ
   2MnByPimjTs84aVapP3PtkE8it+6Qd1z5B9Qq4ihsXxtr11Dn1d3Rpech
   7Fjyo7Tl5m65SBhyoY3MRJx8cNEUrai5hSpmnV6bEDZD2BjHSEd2tvlQo
   hQMEDlGQaFG1K03xrH9uQt7OHRNAiKp0hK0iVaTqQl+v8qfRjNc0jEysx
   GLEIoyPoFpZFtfLYVmGhK8IHJ6FAE/FuNWtseRDI9DHF+OAY99KyWzZuO
   w==;
X-CSE-ConnectionGUID: eMNOTqW5SJSzQdAyMB8sLg==
X-CSE-MsgGUID: or3y5ID1RheXcHB2CQ2fEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89370617"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89370617"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 11:39:09 -0700
X-CSE-ConnectionGUID: 9jis6WlLTRa0GaQkEzzZZQ==
X-CSE-MsgGUID: KgPpW6+FQFOeU+H4H2abUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239551553"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 11:39:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 11:39:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 11:39:07 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 11:39:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4gPSscg1smRWT5mNOYk/gmSgfFHtqRoYQQoKbPXKXjougNcMd6Hl0i0OFozOLZG7dVxNJDvSCNh0RlnTTh2nNyl42sJDsXsGKznEB1kPTaZVkPDWVjerZaBSaAmgyUe3MpCiCy7zm8WRd78+GXJ+YiXBbWEy2oXSnm/wf1C/y9Uft/W6seF60JDSgrWDlcjsDcwvAX60sLompD8XfN2MaeBG9NJqUqJMW+1xAAKaL+ILe5v6hrEjAPYTnTwuf6BLG9XVn2+4iAT79t/iVBWDA219EzBTt25K9zDQsIzwd9U6aLFW5jhhTwcEs3VXC15nBEL25YplHPvZh104oYVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkOJvOlfC/grcLpreje5fhFW6J+V8stan7hEnng2McE=;
 b=O2NcsEPza/ugAvmKsMZ4O0NkFSyaj/jHA2TAM/YQy/Gq/pX9o5X8n8o1ES15Ym2/LOC0DbROllveRmmSEw6luKfbOMgWeZaYdSEBvRg954GNDzF0mH3fcnLBgcuGoMc8htcC6cwdXHifjwpsQueucs6nso+5W9R1a2FY2LWff0X1lXLSU0xVR5NZRBJdQsZ7kSVgucESq8GNZ7IyYLuL6BRDz0iN7N8NjQBotKZ0YRu/30evOjXr7pFaXwYMGXUYoTM8U1jsZNKqf87pISpV3Cz7NRbRJ5raybXsoehkeMdjERVktHx3QsSBFz5hNs54w/JxNytgS9+URWqFJm/Rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:38:52 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9870.022; Mon, 4 May 2026
 18:38:52 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Vecera, Ivan" <ivecera@redhat.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Nitka, Grzegorz"
	<grzegorz.nitka@intel.com>, "Vecera, Ivan" <ivecera@redhat.com>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Wegrzyn, Stefan" <stefan.wegrzyn@intel.com>,
	"Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 14/15] ice: dpll: fix rclk pin state get and
 misplaced header macros
Thread-Topic: [PATCH net-next 14/15] ice: dpll: fix rclk pin state get and
 misplaced header macros
Thread-Index: AQHc2TUoYPJ4X9m7SUKqbzq+UK6iGbX7kXAAgAKlMWA=
Date: Mon, 4 May 2026 18:38:51 +0000
Message-ID: <SN7PR11MB75929B70DB2AC21CA8E36116D6312@SN7PR11MB7592.namprd11.prod.outlook.com>
References: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
	<20260430-jk-iwl-net-next-2026-04-30-v1-14-6f27ae1cd073@intel.com>
 <20260502190952.063d3eff@kernel.org>
In-Reply-To: <20260502190952.063d3eff@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7592:EE_|DS0PR11MB7997:EE_
x-ms-office365-filtering-correlation-id: e3681576-cd27-4452-c8fb-08deaa0c6370
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: y4eo5AQiUIF2ifrvYnXC/IHWDay3neDoU5WTTarOqHNPSXUv3vqZ3je2jJmIJ+l7gGP4tvU/Lv9NXyJVYb39YWEvB4W7CPkOZ/kg23ZWRChCA1B9z1Rjn2UBCTziWSUyDirWXqIq/qC3rm6IF5+wtBNxHvEHJDkZy2sJSfmHhbWRac2PnI0N0NUrhVGi+Hh/pre1NSCFfEc2+2AzUMVMeIXDrVChDgWKWCZCIPClmpf7o3MGsBK3EZGIUW+OzdDgPg+AVw0UqpU5fYQ9Mhzmkx8se25OmxHKrINnDTTTFmkCGJkZEASWB1F4ZYBBNe2DexUr/ZLq4ay67kBJmY3qlJTiQ4IddtrbSvIOdK7yyYqHFl1u3uAE5Y3pGwjSN+vZUzEyb4dlaTUag5RIIYMyFZ9cyPWzaZkxSgVj6MKu2I4jyEaGnbUR6vTyD/xdsMd2Pq2Hkvghh1FPcny6ctF5TR5LoCXhlE/fTbyF08SHw//VyTag1zNNBiDVZqHfuyHoF0/kBh2voZtoTXYjMTlwqvTvH+o1qxRzjo004ZRLju3bsDCNHctfXKSpGt/GBo1vZTElrobhepFzzBhn1/6HCVjQyjFrwCA22QSW6ZJ6Slnha8h1FgQkn9DC8iUVz1bhGFZeuyx/8bct1AygrnJbMWtmnNAXX3po5cShuMnujtK7gAYBtPyrD/vr36AgIeyziRmMasX8yj7bqvqN2hP6I4GCFkLcXG4PIiW+miBb9fx+HjNSj75PoJrJBEdvql3Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6dm4aVELY0dLsHTCmUY25Y0U4dwzI9WYwz6P8ACDjiBiUiugsJa3MLBbFi/3?=
 =?us-ascii?Q?WzzgNOIVHNAXP5YmaF0sph3RcyJF7cbSOUDJNJWIJrrzq3HIz8PGyPNawnIk?=
 =?us-ascii?Q?Cjeh4pR8/1mJ0160/AM8PWVpiqUzgw2MgdNzswI57JMOcl4TNhTi7tXUkJ0E?=
 =?us-ascii?Q?Zg4kNNb27udxakjzw2/9zeZuSYWeNOwy+n/ethps5w1aCIfPHvsqPg3+8vDR?=
 =?us-ascii?Q?R8Di32DPqW71D2rUjZELr39hJExtXzQFDJeXFSjazTzScqCHXUpXzzD/nGg/?=
 =?us-ascii?Q?S2G+uwM728+Ujjxv6S1lWh3Gu5iqQ7t08Y0tpyGN7kmrqlBOMcRh85BeOShQ?=
 =?us-ascii?Q?O4t7KDejuXM2/c8wJABvW7D39h2i8KaA11NoRnnwNe+aeFUXnLFv5v853OXH?=
 =?us-ascii?Q?uMeCsztCvmLe4CpeICW9DN0XUrt2CbjrBLUGpsSJl+mIwE0IQIyrTrLr9Gkd?=
 =?us-ascii?Q?28DAjVbbRSg6Fm73XywDcCTss2vK0dnQU9m7Y89ERttdP7kbr6hqFaB2dOr3?=
 =?us-ascii?Q?Wlv0P3UVbtkLdEBLLUwE4fcgnreNKba+fhJIsY2kDqz6711BYKOCx47CMEOA?=
 =?us-ascii?Q?EJEBs2mlSVlMp06qF8eNyj6VRkTh0u1XQV9xMHW3dorl1cq9MKSD2aZorv8b?=
 =?us-ascii?Q?mOvHoUVzGaSAs2ddQXizUt9pyNNlncRltxlUtVmyCMz2icfoz3YPQph1dFn3?=
 =?us-ascii?Q?lWHzr6MfyuiQyP5C4oJmfLGlqSCOsSiwUAvfJ8hviMDCc7jTOloFmFF+aws2?=
 =?us-ascii?Q?2NBGfDMuHLgBi7G/0PD8Hghln/T6ZYDni3RY8KBPW1r5cQumGmzjVaZs29Eb?=
 =?us-ascii?Q?OKfzzpGz5YP/RoIjrCcUKcndyNmT6B/3GwKrro+nEUcjz5XqO8B1q2i1NI0m?=
 =?us-ascii?Q?g0RwH3mavZN/JMysCCtUHQDnz+mMavXvdvrUZQcbDLyR81Go8q+Jfc8Ev0X2?=
 =?us-ascii?Q?DMysHDm8eiGZQdGwG6Mzet6gaUMDiHLGOtPrHrQhFKqq0RAoguF+2tXZKAxG?=
 =?us-ascii?Q?jWnUHdc6vrAtZKTk/fOIu/SHDtjc2LcAq8sCT+kQ5H292b7ds/ZHhyzwhY1s?=
 =?us-ascii?Q?y8DaP2TLWdozo04C4cx2KkuHHFMfrKFtn8zmFg/Rso6gzkWsmNsxw3XQXUfb?=
 =?us-ascii?Q?AUVaJqLoY2RupHHkskwi3aU+3qOcyPW8e4/lp1IkvvsPPqXSIP6Ntuymsj8q?=
 =?us-ascii?Q?WandyLUubCsVifKGhYNX83m135VS9HhwewmXkOCoCzEiGFx4wjkNvq4biS+c?=
 =?us-ascii?Q?zRkpeJjiqAzdDhl0Q/fZVm0W7M82jHaqaf5HKE/rLnei2U2mzvJj2qSrsCbj?=
 =?us-ascii?Q?mye9LJ4NW+NIzFiKW7Yd9vFpcJp2j4SuymmyDMUjPRnn/g0DlBbet9HVRyfE?=
 =?us-ascii?Q?4msciJ7i5Zraqt7+FLJkWQTXaP/l/4/hOKlY+jUo/BJrZKxIXHj0EyNuj2ps?=
 =?us-ascii?Q?Izu41LfQqOnZdck1sBUepi9F1UsdLwp7VfO7zVhmj7jXP6VpRXY+4t6eHFRe?=
 =?us-ascii?Q?sC97FO7p5hOg3LWi5pLNGFPrqpfZmPen9s8Z+yWFsXGcygk2t/nTkifMob0J?=
 =?us-ascii?Q?eSCcigNruPJxVXxTvZstkNxrHavBiFcE6Soqgsz339d3by90hdQelcdQsa4Q?=
 =?us-ascii?Q?zwJzxLbwYMDxGSscJ4TkJP90tgzhFj/WWc7JSHJdg2YAenVrGwdDLByJOdUT?=
 =?us-ascii?Q?35V5Ap8VwWv5CsC92NWXcwzgbyJdctYr4K5t7jLLJCsQh6J5ffHtAJcmesBP?=
 =?us-ascii?Q?cePkvGb+qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bdF75NLC4KIjZK0U17Qn3NmlLCpm0AGPdmhW+9D3ZL8GvVu4FJl3f9OBb2AE6dUp8LgSECc0PCiDbh6stYrUUUwLk8Dgb9TtNJHnGrE8ddE6/hqt+bueZtJxCxNcGz7Z7oadE3risyU8T4lcIu64aCmS5uV6XYSbRhGvpojnkf4JzpAkjAhEIhTFXJa2bTy8UqZpccPL8esYSXq1Ig9WdIVPvW4g2wzOodaKCJ0vYS92sv3OPCC0Hn0y5QK+/rUOokUiOHOY+rI7toM6gG8EXvdfpdApHHcLGiQzHbOR3EDJBjb3aSyu+mAi5QubHWbad9Yf4/0gB01Ss5izKsVHyA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3681576-cd27-4452-c8fb-08deaa0c6370
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 18:38:51.7368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3K6YtscsR/95RhLELhJyxYQM+YpJ1xEj+sXi+oA2Z+8tFTrR40y1tQBKO2Fr5QfXpLWrNiZXoxzDljdZ4DNWEaO6MSb3fQIbOgJND9z78Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7997
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 19C5C4C2B43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284003-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, May 2, 2026 7:10 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>;
> Lobakin, Aleksander <aleksander.lobakin@intel.com>; Simon Horman
> <horms@kernel.org>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Nitka, Grzegorz
> <grzegorz.nitka@intel.com>; Vecera, Ivan <ivecera@redhat.com>;
> Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Wegrzyn, Stefan
> <stefan.wegrzyn@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next 14/15] ice: dpll: fix rclk pin state get and
> misplaced header macros
>=20
> On Thu, 30 Apr 2026 23:37:25 -0700 Jacob Keller wrote:
> > Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin
> discovery")
>=20
> Why are Fixes going to net-next?

Hm. It was targeted at next in the IWL patchwork. I'm not sure why Ivan cho=
se to do that. I opted to include this in the series because the patches fo=
r unmanaged DPLL support have conflicts otherwise due to the placement of t=
he header macros. I didn't consider that "net" material since its relativel=
y minor issue that I think only causes issues if the ice_dpll.h header gets=
 included twice which it doesn't seem to currently.

Thanks,
Jake

