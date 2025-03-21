Return-Path: <netdev+bounces-176839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31EA6C619
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 23:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE144189E9DC
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE91F3B8F;
	Fri, 21 Mar 2025 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0KStnWk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB028E7
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597526; cv=fail; b=MJDP3dWZw9llV4W1O53OhoofNQRnPVBOxw3qeBDZUJesMBkKgjw5oz4Ku5zcbGa3qXQeUIWmWYCRGn0q2XogzmBMP/Gr+lORNlroYtWG/PanML0nQlRZMjsAJvG21zmi/0pWqS97PTYDqRKLkpsWInbfXzFj/3VA3bAVI1uuXGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597526; c=relaxed/simple;
	bh=IiXK/iDfqrqi4RlbuTVGYeQPYHFmw2csO20rweaT5LA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arCXGfLUKrjegqlWpAqmkzwBfJHz2V+TjctgGPf+kRAm4DQpSlXYkM4dzB8wjU5zZ9vmYLytjMZ9qRkiD//M9vJIUfbJSEdmYea4REMhNczxpRc3ENMdehDeiHQtSrcZtsW6mvIm0YfEV2bjKXtFQ5XIEQKp1VtUQ/lqtwnSjYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0KStnWk; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742597525; x=1774133525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IiXK/iDfqrqi4RlbuTVGYeQPYHFmw2csO20rweaT5LA=;
  b=C0KStnWkzEkraEznHzKoRjxpMIzookS1Z+rAqh/AaQACWfwCC++Ov0UQ
   tGzOU1ML3jGHZcscLtL47Mnr2J2yYRoHpOGUpTB7P5bI2cF0wz0ZUlRVQ
   VYcBHjxeA1ndouDZRnpv4t879SdJDVoSUMqchhYtv38Zsf4PsHckigpEy
   Ezuq0i4tRM+STHSkf7+ajY1kkKxAZt9KxbOyuTEOqhEV+/ZVvXoTYBW+h
   aGEJENOrwPOpMTThIoVMsY1LA7Q7Qny/Y5XUFt/XkPnknXFvyVQQHpziA
   m8/Gs2JVBGxHWNPkuYi/ikttqbyB8N0zB5efpyLkm0VtkKf4ydPH6zLno
   A==;
X-CSE-ConnectionGUID: 5AUkn+7cTbqIuxLE72TMeg==
X-CSE-MsgGUID: 8eHLbzFBRs2KH8KtfwigCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="44037935"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="44037935"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:52:05 -0700
X-CSE-ConnectionGUID: huTF3Vu9T4GFoi3+D2zkyQ==
X-CSE-MsgGUID: 33znW3rDQ96WhvGISPnz5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="154420674"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:52:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 15:52:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 15:52:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 15:52:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOjn1XddmLyh4JQLm3hXE/FOsDh4dokwml4uJHNBDBCNSUQnItamm8oT0L6kYstyDWDaMoy4XRwDs4q6mX2MC/m7/mqH7kV0nVV2Xr2MBm0KO5ywftFI9mPcdW9lTZFltSVOjpQp12nrF9yY+DdD+WujtxS78K2nH3XmoQf4inl971HzpQ+atE4dXJ4N95tYB9enhBEqaPnE01W84CwoBSLMa1X16g6xEJLoLVI/MaUopZd4uvVDd/m9dqGveGC963b18vTLTAkpdiFlmvf8O6JnO6Dtyc4PXPEeCPwhTn3mKLbKZGstrxX8l+/9SN5IQ2Ya2BYV/4gej91YU0LQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3QD+BHj2MtWOgylbYdhSTqwdqKZTMua+A7Zlovxp60=;
 b=PCZ8vM9fmnpOflu5JtK7zNBpHojPvRxPEvMAP8kLkWpUf6CVR80WYrKHXalqmLEyzOGyw4B0/gZCSv5WVPHTXrEJ7aw4XBO5PE2ZXGTr1r11cdf4kNOMoEvKNpsyP3s/EidP44HxUC/IXV4BRf7qftOwEA2bChC1t477uZ+Zvz8n8fK5Kw6eQyGbE7TjTGOdw4gRd42MWV74tAval4xFcZgSEl2w/YsMd0eLYDfpjWBhL+UI7ESM3rOPfrWrg16eOMqlwA5hH1V9TXnIyUw7eTqt0T+ZCcVey6+VCTO6tEnQvqRszKvuVrL12som52q054vWiqjyfBC+cuDBRUm4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 22:52:00 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 22:52:00 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Kubiak, Michal" <michal.kubiak@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kubiak, Michal" <michal.kubiak@intel.com>,
	"Swiatkowski, Michal" <michal.swiatkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: add a separate Rx handler
 for flow director commands
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: add a separate Rx
 handler for flow director commands
Thread-Index: AQHbmnPzxWwYq5cBOk6SoJiHvT4k5LN+Mp4A
Date: Fri, 21 Mar 2025 22:52:00 +0000
Message-ID: <PH0PR11MB50951C507DD78731384B7A25D6DB2@PH0PR11MB5095.namprd11.prod.outlook.com>
References: <20250321151357.28540-1-michal.kubiak@intel.com>
In-Reply-To: <20250321151357.28540-1-michal.kubiak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5095:EE_|DS7PR11MB6103:EE_
x-ms-office365-filtering-correlation-id: 86ed5905-c598-4c97-ebab-08dd68cafd9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qrnuF79pwN6g3+LEo6DUYxxezJAqFQQrS/zgr4upukfs0JL0xLWA9Co5lAw7?=
 =?us-ascii?Q?HwK06F6yvOmCV1YH0zStic4l1FqtPHDlKfLCy3EwMZydHyYIZjyCtDcqm+vi?=
 =?us-ascii?Q?yX0toYm2IiI02p6hPm1lEjKpNMjwh1mFmD1OUcfrn8uakN7PnOiKlBkXsb85?=
 =?us-ascii?Q?d93aLtXuDAhfGyPbVNRCJG242pdRejQQmG4l7qUDGQs5Ne5Ehkd/TT3W1M/R?=
 =?us-ascii?Q?HSDvEzyVXA1sV9zDbGI0qgeZdTYQSBzX6IJ6mkP8CluN/w07diYfITJ+3Pjr?=
 =?us-ascii?Q?xRu7xOeV7pHgjwPdAyvXS+jXUIkBKtXMXm5mzsrjQ1kvVigpime+k5VzN2A4?=
 =?us-ascii?Q?AvwCgBfkohaGN04ri8JxjTF06aLB8g7M5plq2wiH74CtncUI8vdESATjzcuQ?=
 =?us-ascii?Q?RZx4M2XH4YQbwqXzD1L20FKYixTeF5Wy5mKPZOtg158+V4St0/opkvmgnqTc?=
 =?us-ascii?Q?9lvrL00PouFGOfBMcLCzhMOVvLEHGrKTa6jOoW05T7DjMhHvAeVrUl1Y3oVV?=
 =?us-ascii?Q?Z6hhLmtN+b/SwR4g9S9VPJ4yWCibMDmrCM8QGSPP2pBCeB5AJZ9djb3yF22W?=
 =?us-ascii?Q?G+VfA8NzgrTA9YymUwDm1o6gZUEUrQcR5beIeZ6J5ClwQ3DjlLQZEPep4z6V?=
 =?us-ascii?Q?nhAJwtd5Clf240eUHpHYnSpCmsUM9ncp5TIPVqvMgU49efBwaGPsXFTxtmKr?=
 =?us-ascii?Q?lWNc51mADs380Nh3Re/r1LHMQQhsrMyts6hMGv93ZUXkDmdz875vReErdzy3?=
 =?us-ascii?Q?nR8EomwIdBA6v0XApO9MGY1VRuL/EPXBL5s0LitfnzNil1uE29qKJ2dZ+aDL?=
 =?us-ascii?Q?9lL3Tftt7yulm63e+sSdbQEKkxuEDY6Xx8XYWdLTmsPzxB/1GmfnfHP18upd?=
 =?us-ascii?Q?lwEZvz7iW7UBZ6XBLp1tO/ajET5rSINROYs6ybtT2KQIdEy0h19hvBEOe5hz?=
 =?us-ascii?Q?RcT5dGCuJd0qcMaEmAoiWET5bgnYeBXIdTF8z4Gjz0kJGQvoFVbBLEHN+Ezd?=
 =?us-ascii?Q?FjXzJFyhnXXCWBZpzSHKD2nyLlnRESa/iRW8pI5+XcqQL8Oi7CC5nujbK34H?=
 =?us-ascii?Q?2fJAiX3yYV1GKEopxzBccgCNP4q6N9icJPJdmEsIzJ6xl530qpj8cYJaoX1z?=
 =?us-ascii?Q?TOq77XyJfx0E1ZIlT8SRyadhpuBLAHzM6t4W5RhigqsS/o9fgBx37XpN/m5r?=
 =?us-ascii?Q?uPp7HEo8LDol9hio7J6PUxto+TOuHq0K4QhbU5YHaBngUDsPqYq2ueS0o5ou?=
 =?us-ascii?Q?OXwXnE+l4GNQq2MWg/gevcTG9SBjZhaTG8sEPqzKAp4X6bPi09d70xj5tQfT?=
 =?us-ascii?Q?+Ar2tDPloXVA+hoNZv7+Ycrzp03OBXQDsNT/BuyCazK/XBTTzX81AUaFl0Ul?=
 =?us-ascii?Q?Dtg1Tl0WCqnPccR1ftFI51DOxDmDcDpwUClR8pTWLsz1N6qUjMHGUibs/+2e?=
 =?us-ascii?Q?eGKHAo9QJ35Lrl3FwdpKBdB1iZIN93OQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nInbLU5pSbUq9KakKcn3PjwkMxvze+AOq8V6U0N9fYYC/jOX88etLPdrl5Eh?=
 =?us-ascii?Q?AhU0HaE0DoBMZWIPQgcyZ3/744vthlY9s/3xKKjhtAr2uB7TvEk8JEUaGV25?=
 =?us-ascii?Q?Y+bYrawLRAtJtUTqNm1a0H/z8ru/5YEm69+Ft0Cagld2gfUju6ZuPnNs2SGB?=
 =?us-ascii?Q?tiRvd3msbcydOEM0mwJsA1otYe9MwCeBoC57k6wlY3Q7Uygv8ggGyfXd7utg?=
 =?us-ascii?Q?O0yPwla7pTtZAY5tBFKlK7r8MeGEDap+CmhpWXbfsCwx0DOpY1Rkxxis0Uxg?=
 =?us-ascii?Q?Yq86X3B8XrEqB5/Jn+DEyI3tHeX55eZQ5XZW3hSprllrXCBt8wyS7ayYZbTv?=
 =?us-ascii?Q?Fk4mTkg0k9k6V+ycF7pW6gWbM4LeurmusRsgN/JWeFGQmPRQIvznavq4Fflq?=
 =?us-ascii?Q?G+xA0Mnt3yw5cd4D9+5vBi1cG5uf5MZjnlnsb+UDTQCKnrv1J+11ERykRMJk?=
 =?us-ascii?Q?/WbQtfRCkD/oFSxBYKhtSm96xlXEioAqyNli3kHsqhUL9nDC+LvzoPBeotEN?=
 =?us-ascii?Q?4Xz44nsn1I9J85J9dY0vRtkAasV3hnJLGsNwBxzo4Rzf/c63d7VlOVlQOo1z?=
 =?us-ascii?Q?iJlQ9GrrSoQwUj+Yh6e8hp8eIOQell0NhwZiKp9jVbac3y5MfwpIu6I23IeB?=
 =?us-ascii?Q?WfeNUvGbJUy/J+Cggl36ecVRm2aTpEPFPMSGemXZTQ9jsCytI7hd9QyDkmkE?=
 =?us-ascii?Q?JFHbU5uBBg7I+oqHN0bF+VD8rlEJuVXLWXUt3rA36Oa9q8Fc1CysGVx/mFYu?=
 =?us-ascii?Q?HUc8ZO8ZMHXJyqiMVJStZH48ZmtAKRxs5uzPQCuoKb1ghnnwOueFWKlsNYje?=
 =?us-ascii?Q?gbiXF2GMq1bDt8qLXrF0CZS2BwP6qv2iwmxay1lShSNb+E+qILZyA2hJ8REQ?=
 =?us-ascii?Q?2kfe+9ZkNarHtRlOZsaAqnkjlUX7xOTtE8i84iXvxsn1bACvtJGdqLSZttOc?=
 =?us-ascii?Q?c3D1ikdXFF98rDDYsA7cQQHshszOuNKzQzW5RS6w8rdtngLwgi6NhtIPpzsK?=
 =?us-ascii?Q?tJPf1A6gXgSgdj4gvVX1JMYMLOPU4dXWKF7LL3G3y3lj+QIWYSIzemqo+59g?=
 =?us-ascii?Q?5vwMxaSysKu7wVqV+UEMjS6rmwZoLJsXJH70mLPxFgWR/t22xfqcB9Ul6XKu?=
 =?us-ascii?Q?d62cRgYQfPU1UvGs3oW1533Ojmya+OWROpELWfJ/f/MNxvWT0NR2GwEaXpzL?=
 =?us-ascii?Q?y5s6RQ3fXg38f5BtgIeUkMac5IUFyTtwGrLme5cK8NwQplgG3NrQy5dXbzfE?=
 =?us-ascii?Q?YMx4z8zdMMYTDf1s+j3h3uLju5xrRY5DLgXgGOHISX+aUNbJ9cG0oFxHrIJP?=
 =?us-ascii?Q?7pdnIa4keDfFX/CZNqcWFGYzyq7/wnZK7lWwz9Tq6MkVaV3j32D1G7nvVTaF?=
 =?us-ascii?Q?5G/rP2GUeH4pLKlz8U9N8A5yATZdA5MMzEwHsZPk1N1SlOhFNKjpZd+OYLnf?=
 =?us-ascii?Q?ZdZAcWM+VqRJyq/MfycD+fmXtwobyCSjukYmxA+pSSkI6bKNanww/5af/bzv?=
 =?us-ascii?Q?uOG9qPyQpoJQfP5n/A2RIH28cRvd8Zh1bUXTYC4k1iVJ5kwib3ePc/vvSFgm?=
 =?us-ascii?Q?ZHEc00dhFmZbqLHt1BfQmRVTyJD+Vdyd2kXBuj6a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ed5905-c598-4c97-ebab-08dd68cafd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 22:52:00.3803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNl0s8c24Re+SxcbTURZ1Tdrz+a530oYShEHWFFvE9j769DZNzfNJXxyZjhywJuB100TSXTFw0IgE3CPmR9pqhzpkoKMAgfq/Esmh64Hgig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6103
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal
> Kubiak
> Sent: Friday, March 21, 2025 8:14 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; netdev@vger.kerne=
l.org;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Kubiak, Michal
> <michal.kubiak@intel.com>; Swiatkowski, Michal
> <michal.swiatkowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: add a separate Rx handle=
r for flow
> director commands
>=20
> The "ice" driver implementation uses the control VSI to handle
> the flow director configuration for PFs and VFs.
>=20
> Unfortunately, although a separate VSI type was created to handle flow
> director queues, the Rx queue handler was shared between the flow
> director and a standard NAPI Rx handler.
>=20
> Such a design approach was not very flexible. First, it mixed hotpath
> and slowpath code, blocking their further optimization. It also created
> a huge overkill for the flow director command processing, which is
> descriptor-based only, so there is no need to allocate Rx data buffers.
>=20
> For the above reasons, implement a separate Rx handler for the control
> VSI. Also, remove from the NAPI handler the code dedicated to
> configuring the flow director rules on VFs.
> Do not allocate Rx data buffers to the flow director queues because
> their processing is descriptor-based only.
> Finally, allow Rx data queues to be allocated only for VSIs that have
> netdev assigned to them.
>=20
> This handler splitting approach is the first step in converting the
> driver to use the Page Pool (which can only be used for data queues).
>=20
> Test hints:
>   1. Create a VF for any PF managed by the ice driver.
>   2. In a loop, add and delete flow director rules for the VF, e.g.:
>=20
>        for i in {1..128}; do
>            q=3D$(( i % 16 ))
>            ethtool -N ens802f0v0 flow-type tcp4 dst-port "$i" action "$q"
>        done
>=20
>        for i in {0..127}; do
>            ethtool -N ens802f0v0 delete "$i"
>        done
>=20
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Suggested-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>

This is a much cleaner approach!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

