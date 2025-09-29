Return-Path: <netdev+bounces-227088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D977BA81D0
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 08:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C749E3B6ACE
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 06:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140F427F163;
	Mon, 29 Sep 2025 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qp6nTHuO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641F9253957
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759127259; cv=fail; b=pv3gRXXAMpUJpuQk3FRNAjQKGlmrxNYCDgt2ZHzDvAJiLQa8CG3R0Y0nJ0XbkYwZxdlJTyZM9FtnOLDOri90PSo6WFy1aijukpEBkmvs5E7ciRpgxyidQ9eVoWLknlAPeUncGk06nZKDKbiJkcv2m1+9MP2lGdsDjr6QQgvp4QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759127259; c=relaxed/simple;
	bh=DPUlZriKnxUMHssVxy0ksw3WWFgw9tqt+z5u5SlVQUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yrp0dopGCzUGwJ98H7jmAqG3itlvl/t7dFEzqXkVJQnGbrTTCzU6f8K3EvwNK+g2LFQpjphAVrGqGcZbQEHqYYKqtL6yTqoTEivcVqCGwGrt3YhdLD76hJhx1fcH8QX9e55VS8467Dvyfox3E6noUCVRJR+63oDRNgP1QgADtmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qp6nTHuO; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759127255; x=1790663255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DPUlZriKnxUMHssVxy0ksw3WWFgw9tqt+z5u5SlVQUE=;
  b=Qp6nTHuOuNWhEJXF8YKcBo37wOwNdCt9H9gXwyd6FdNaipgAunRbxbc6
   T6GtcdNfAZL2Z63q0GOCY6Qq+0g7d7xvYdMT/tjcyoj29d6BvaSiyK515
   NPC+XCqA5TXEz83RPaTp1iwhzA4WZa0Vv3Nrf7BBnV6CgTb1tLyyxQiWb
   JDa0oaoknvVA9e2nrpMb6L0Vo3bBvF2Aq4q9hqQ1dLPq5NafF08apgJCd
   DBG073Swx2AKHiWNlKeVzg9Hx/L5Ac1jePjrqiJfu4RDyg441srdu+Wh+
   wofFVFxaKJKhjHf0SrNI70qMGUFYjP+zcrAOaeF755AoQgWcB2k4pWVkk
   A==;
X-CSE-ConnectionGUID: wZDuH9i0R1OGDCz0UUfzGg==
X-CSE-MsgGUID: d25VO1toQaGYIXA25Znp6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="61251483"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="61251483"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 23:27:34 -0700
X-CSE-ConnectionGUID: MdwcvYXRRZuaP7Ch0e6Bhg==
X-CSE-MsgGUID: LfitatNlRPGMAoPB/VNk1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="182140156"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 23:27:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 23:27:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 28 Sep 2025 23:27:34 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 23:27:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhcfdVbqWKEMXhES/HQDKSSXu4n5EQWa8HmU0ZR5dLY5fBjNqPPwinDKGqF9WZp15eNYPY4gzMq6VeU3Co9EO4fMTTqQmSOzZ2WXupuV/f2taAde1pDV74983y7SDv3DndL/HownjIqPSShPZm41j1vBL9rmt5qxZDwpvpwhhuFLDEGQsTRe0OpAY4RwXSK9AmrHylI+OO7yaG+tLm8kYhHOPPY45jeBz9AxqR/KA4WWPlcX++LBzw0Z/AYF0kj5yKWuztwjodlBl5tXMCtFKUoFuBHOJdMGq7R+fG5tYqju6B/wIzN1Yhg7nFZir6xhZv3BBGX4H6qVlbnHklbkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVcKyap0SyIH5tmetA8QPAr/EXbSm6x2sNx3NYvUU7k=;
 b=Wtf6AA7sj/oTgvNnO2TrrzG4d7gwkWdp5xU0prGC/LDkvvBwKCyj116ZDPJO0t9FoX5jS+Pmlx8XBc7JHQfAO8YyDt0H8IeDEz2Ub/7vSno/VO9yjGqdLknnQIHrdq8VV4KejrP49FxqTtQKC5SA2jP4MqymklJ3bI2JHvMH5UDPu/b3HGsDD4HTZCC/fTrCdfpX9i9g7LtXdnEWWT08/zJgKKTr5mbUny+Omwm59pVVrBZsj31uoz/ElEUKwimHVmvuHvbvaORXUu17wZiWtZNs8F2Zn1ARKUQnq5xPtKsOt/mUngYqUa4PzgMCdl3R9zfmD36ZWqVRX4Ym9icRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB8384.namprd11.prod.outlook.com (2603:10b6:610:176::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 29 Sep
 2025 06:27:33 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9137.018; Mon, 29 Sep 2025
 06:27:33 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "pmenzel@molgen.mpg.de"
	<pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [PATCH v3 iwl-next] ice: add TS PLL control for
 E825 devices
Thread-Topic: [Intel-wired-lan] [PATCH v3 iwl-next] ice: add TS PLL control
 for E825 devices
Thread-Index: AQHcLsM1zu7xo0nCvkytva5IoizqcbSptqAQ
Date: Mon, 29 Sep 2025 06:27:33 +0000
Message-ID: <IA3PR11MB8986036975594843B0A28D7CE51BA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250926085215.2413595-1-grzegorz.nitka@intel.com>
In-Reply-To: <20250926085215.2413595-1-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB8384:EE_
x-ms-office365-filtering-correlation-id: 7208b84a-5730-4c70-5cc3-08ddff21461b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?z45NrQKTsPGrqKw9lfy66FjzytAn9ZZx6no2IfyDKkGB35iONHlg25Ers2us?=
 =?us-ascii?Q?Y6CC0gntJrnBMu/jz/PSEO6DjsEyWdY7J9t3dLJcUiLEAJ14K7UskFT3i2tf?=
 =?us-ascii?Q?fvhIJwwKqe2QpdIArYDMUN1EsgmgPdsohLYmq2hmN2ayvYOkmFvORsT0n2sg?=
 =?us-ascii?Q?5tmGDQBADmKBfkfc5dvqbhwAbtZFu4Iv/UkwpZE1JE705lwkUkvu9qzF5g4v?=
 =?us-ascii?Q?Fx/BnRX6gQP43rhnOLQ8ZHl1+NoMlsbVEzC9iGjHpqBRNY+zzxjKvKA7YtXi?=
 =?us-ascii?Q?BIwj/5+yLM+fkfBjxojj6PI/OvumEoMZwX2kyMhjA+Mw3F72+uw+/doRZtgT?=
 =?us-ascii?Q?ABTyHd4+Rx4XGv1TSfjQsknVBdvoaWiSAvqLX+1ErZBEjyz/oORUukdGxWZi?=
 =?us-ascii?Q?h2nHpGlIH01w/GZR71tzXv+tcTViApXfAO4MziO8jLYwn4Ja3hDVqvrmWii6?=
 =?us-ascii?Q?iJ4r3/WRme0Q+7JygOEpfkxRAr3b76naJF4WXWK4woNBSWQ47HIJbgDMPCYs?=
 =?us-ascii?Q?elTUZOQ7tZE7LME1fXewROBGDjv+SYdE4WHC4y/zVsZn8fUpU5hx4yzzewS4?=
 =?us-ascii?Q?OgYbd7IT4eQW0ckG+nQ/KyN4Xqfl5SBfxr5/3OjH3ibWKk8AW0RS/8TsXIsS?=
 =?us-ascii?Q?VbR3r8ri6KpHJ90gv/H7HvnBcpAn0fO0D28+KV+7t6D+9U3PQxd1dHS4iUuE?=
 =?us-ascii?Q?Hm51LxRr/ixk0dn6DZ6nKonl0gqf8mkQGGHx1gQBcPauW7S8sQAHNU867hpq?=
 =?us-ascii?Q?4wkVO6L2/BDKvb0oC9LXPc4dPKcN4flmKg0V1jye/QpOA1/dS3CP+BiDBmSL?=
 =?us-ascii?Q?0mUSa5vQ7OJiDioNFWEIRGxkR+W8qwr91FBI09YwMUNptJY/fmTGhbyE0j/U?=
 =?us-ascii?Q?1py6Sf3kb60R7Sf5Ksnth+MNZolwUAreRHjMkk6jCSemuXH6d9qUYFq3PP9P?=
 =?us-ascii?Q?FWpDc8BWOAYQ/3g6Q2MeOuiUnedZLGGWpn1SBmo9lDX5gqaMqit6UeckVxv0?=
 =?us-ascii?Q?vyykUPk0ABNCQ3eSRZ1DkntLhw6goBtI/4IG6A4RBaL5sRVikWw2ZQoEaupx?=
 =?us-ascii?Q?+aGDjKV0iU4hxIXiOcQ/q2b5BwCcGcIRe0GmWzmh0B7pLzkurm8MEHrf/NcO?=
 =?us-ascii?Q?oAUAkxy74MgcY0Moehhkj1zAofjXxQZKk52AQAJ1OMbXqxUnArqfod2hiJSG?=
 =?us-ascii?Q?lnbT4pFFc2M41sLCEDMzdGa5vwUdiBUWrALL6BPXmSH/MCHMF7Zd50tmSouO?=
 =?us-ascii?Q?CSucVqVZ4kG2tAe9cwZfpUJHpie9Po6iHk81b09tdDBS14GBZn7r88TE9oPU?=
 =?us-ascii?Q?lBySDDzgojboxTkktca2cSj5bjK9lqcZv1KJJ20OGWRmwtQ6ZyFscgO96jXy?=
 =?us-ascii?Q?/a+mNiw+KeBtcxlHIsJmbbUwAvwBq3dnKXluiUel8sf0gsJrPPGm+S4XfkcY?=
 =?us-ascii?Q?phlNdNhdP3Tweao1spHP502LGgDDkIiPD+qL0XEdBRI6G4wRqq9I8vnoght9?=
 =?us-ascii?Q?HCYd/Ew3MSnahlKPaCOCVf2gL49k9E+t4znC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OvJhxv9PFeU4yBq6NVykTf7g0ufZ0pmeHnMSFQuY18dw9Bvp8helTtUij2kW?=
 =?us-ascii?Q?kvUnTztMrixN+11puy99qLs9DLCAU+MHlP5i32MOMJsXJEwmaUn3GKEJL8iV?=
 =?us-ascii?Q?Ov/+suKBm9fAiEidxkpNo5H6SiU+XzGIq9eefw3q7Vgimdyjdidm7B+LaLRf?=
 =?us-ascii?Q?yDzI9+EudNVDGRG7GDqLf6LJK0IGWo+POSe8Sv/Jj9RQdVsrgGKJRFeh1bid?=
 =?us-ascii?Q?s/LDawl83goV0kJbHUXpuYcLH+DXOgRT0fe7ZPc6dIphsluwuN7z5UdxGIew?=
 =?us-ascii?Q?yaD/pb6c5ds8cHGE0/JJFSIIvnDTorUkKEcFldzyRMNllTR7GtbZMhl28qQ7?=
 =?us-ascii?Q?OQXR59lP5igBGwDEqIUYtBDvB8b8ej7g0BXTvAJ6gxgr+HrAuIL0Lg8A6VIZ?=
 =?us-ascii?Q?5fCCbHZ0R69zwbJK4MPjp2BRxHofs1O8e4rxOZmIcUUpSBcryhbibB2WZfvr?=
 =?us-ascii?Q?dOgjNLpRyqKAYKyMfdCMpVnFVBi0FSjhCuCrKFp/4xhOmprxtzoXvUZI5jBc?=
 =?us-ascii?Q?DzLZKpBnzwDM1HEggS/xfWdeginMHkru2QRimYLfNGz8M/6GyXPOya8chO8+?=
 =?us-ascii?Q?h92Z95b4fzZ/WeW7Boe1vDfJsCaFJzxyzNAx1FBuQbhUDlmvIFVV6kdVQ7XM?=
 =?us-ascii?Q?fcwHDtChQnLp7wI8+2TU/D7m1FbvbqzobdSwP8taOa+DcpF7SFxlg/MpTYv7?=
 =?us-ascii?Q?wENvNHdXpunRmh8lSi/C2VWcgobJgxAE5hGFzCfkz6/4bqIA3ar+X5S1lmYJ?=
 =?us-ascii?Q?XueZ+jtWpM+7OFA9NESosxPehlys/igAHiS3mHq5qtMDmErm+ywe4tvsnJfZ?=
 =?us-ascii?Q?6p+rtYJObmBLMHXWdzuKLrEbMymYdKZIWkDPo2hz9HZAB+4eBG6/seiwQuzZ?=
 =?us-ascii?Q?b6ptteUeeU6zzeP3ONJw1vNkDBTUtaRnzYdDpR/ZguiyJZDrpHZzwv+Mv/95?=
 =?us-ascii?Q?iMNDo0l2KgXPNTHEVu+iZfkDz/ZomS7JCegcYRx4zSus183yR1/J2WOCkPik?=
 =?us-ascii?Q?Isbp3AhCRWWlfcpCu7SFxlBhtzgqp7AvOj19rxR+EQoNYBff13ewM9sbwel6?=
 =?us-ascii?Q?tvgVTQxA3te5BIPA7zi6r6sJH4VzesQjQ2J2hwNtL9tj5JDj67GWFlg014Vm?=
 =?us-ascii?Q?wEdXRC+3XyPjz/FXYDgHNv+senHD7nEvCezE43oLXdHz6RKD5rN7fYA1HSCd?=
 =?us-ascii?Q?jjYzUZjYBF0D8QgFV8WSD5hCOrrj897fnDGd5KmVLIkzoCw5MRkalqVrVU97?=
 =?us-ascii?Q?6ttXakRnHDl/7YFfHdhNfa6GpiZNstNpv+9Wh+5z279FCeTkHymerI5ni1dl?=
 =?us-ascii?Q?wpAYcuJylWosWThim/mXoamfg4beX7/RIJcaTXK7d2ihO4OlGvDiwajmOjro?=
 =?us-ascii?Q?EOQSKV3KFqvKlRWUr46XLCDMUMOnZLPXzjqEI8wGvmYrn7wUU8smPX5dPrip?=
 =?us-ascii?Q?UpNfzMnENXTj23BLvqsb0onXY7poWt+6p41F61IPDtjYZustz5674/ZHq3YR?=
 =?us-ascii?Q?KFvx3LHA1iLUwkRTfGPfcwt3WE0hg6a18b5OLbYDQOxx2aTe+OY9ffHcTyos?=
 =?us-ascii?Q?r1KyBoztLXiSQfWBgIm860G/tGrzSw03Y9UKvUjD0TgH+d+71NDDylyTNVhc?=
 =?us-ascii?Q?ew=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7208b84a-5730-4c70-5cc3-08ddff21461b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 06:27:33.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfdCC3al8ZYXHNaTjFFOlA6wpKggHf8JLJC45bZsHvSTje7u06QOG314BihXSYUtLhq+JIuj0JymnhtfIiL9Yek3LwtAmmU6q6ZyTOFmZrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8384
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Grzegorz Nitka
> Sent: Friday, September 26, 2025 10:52 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; pmenzel@molgen.mpg.de
> Subject: [Intel-wired-lan] [PATCH v3 iwl-next] ice: add TS PLL control
> for E825 devices
>=20
> Add ability to control CGU (Clock Generation Unit) 1588 Clock
> Reference mux selection for E825 devices. There are two clock sources
> available which might serve as input source to TSPLL block:
> - internal cristal oscillator (TXCO)
> - signal from external DPLL
>=20
> E825 does not provide control over platform level DPLL but it provides
> control over TIME_REF output from platform level DPLL.
> Introduce a software controlled layer of abstraction:
> - create a DPLL (referred as TSPLL DPLL) of PPS type for E825c,
> - define input pin for that DPLL to mock TIME_REF pin
> - define output pin for that DPLL to mock TIME_SYNC pin which supplies
> a
>   signal for master timer
>=20
> Note:
> - There is only one frequency supported (156.25 MHz) for TIME_REF
>   signal for E825 devices.
> - TIME_SYNC pin is always connected, as it supplies either internal
> TXCO
>   signal or a signal from external DPLL always
>=20
> Add kworker thread to track E825 TSPLL DPLL lock status. In case of
> lock status change, notify the user about the change, and try to lock
> it back (if lost). Lock status is checked every 500ms by default. The
> timer is decreased to 10ms in case of errors while accessing CGU
> registers.
> If error counter exceeds the threshold (50), the kworker thread is
> stopped and appropriate error message is displayed in dmesg log.
> Refactor the code by adding 'periodic_work' callback within ice_dplls
> structure to make the solution more generic and allow different type
> of devices to register their own callback.
>=20
> Usage example (ynl is a part of kernel's tools located under
> tools/net/ynl path):
> - to get TSPLL DPLL info
> $ ynl --family dpll --dump device-get
> ...
>  {'clock-id': 0,
>   'id': 9,
>   'lock-status': 'locked',
>   'mode': 'manual',
>   'mode-supported': ['manual'],
>   'module-name': 'ice',
>   'type': 'pps'}]
> ...
>=20
> - to get TIMER_REF and TIME_SYNC pin info $ ynl --family dpll --dump
> pin-get ...
>  {'board-label': 'TIME_REF',
>   'capabilities': {'state-can-change'},
>   'clock-id': 0,
>   'frequency': 156250000,
>   'frequency-supported': [{'frequency-max': 156250000,
>                            'frequency-min': 156250000}],
>   'id': 38,
>   'module-name': 'ice',
>   'parent-device': [{'direction': 'input',
>                      'parent-id': 9,
>                      'state': 'connected'}],
>   'phase-adjust-max': 0,
>   'phase-adjust-min': 0,
>   'type': 'ext'},
>  {'board-label': 'TIME_SYNC',
>   'capabilities': set(),
>   'clock-id': 0,
>   'id': 39,
>   'module-name': 'ice',
>   'parent-device': [{'direction': 'output',
>                      'parent-id': 9,
>                      'state': 'connected'}],
>   'phase-adjust-max': 0,
>   'phase-adjust-min': 0,
>   'type': 'int-oscillator'},
> ...
>=20
> - to enable TIME_REF output
> $ ynl --family dpll --do pin-set --json '{"id":38,"parent-device":\
> {"parent-id":9, "state":"connected"}}'
>=20
> - to disable TIME_REF output (TXCO is enabled) $ ynl --family dpll --
> do pin-set --json '{"id":38,"parent-device":\ {"parent-id":9,
> "state":"disconnected"}}'
>=20
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
> v2->v3:
> - replaced pf with hw struct as argument in ice_tspll_set_cfg
> - improved worker for TSPLL control (reworded dmesg log, use already
>   exist cgu state error counter to limit dmesg spamming, disable the
>   thread after error threshold is exceeded)
> - doc strings updateds (missing newly added pins description)
> - addresses comments from v2: use ternanry when applicable, commit
>   message typos
> - rebased
> v1->v2:
> - updated pin_type_name array with the names for newly added pin
>   types
> - added TS PLL lock status monitor
> ---


...

> --
> 2.39.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

