Return-Path: <netdev+bounces-269081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FlrAx7Iumm6bwIAu9opvQ
	(envelope-from <netdev+bounces-269081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:43:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A352BE7BD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A8283001AFC
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BEA330339;
	Wed, 18 Mar 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dg5CGZy6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573AD2D3ED1;
	Wed, 18 Mar 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848334; cv=fail; b=lBK1SLZ5D6SFmuz5nkeM6LB6eefxyn7fJb0kE7pKBaHjrlXOGn0LXzd6WQAPRcCfmjJqL83xjmdJT/VafV3qeGqtOCF1ymC6wFm8Nwhs7aW+iSfXj5yEJFk7YrdvpTFeToHWCCjipUgcslvE7yeHtXm5EUuITnlVDZqm5tMQDMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848334; c=relaxed/simple;
	bh=9bAgvooKKzsR4KDfTNf05LEzxOXMOI7y3MhGBu+R5wA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fc3K7KUxB+PnWS8lHk7GZREbkCyy2mr3DIHCOz4Sl6hRJByA75qJMwK7GnSE3mzeqqh1ds/zl4PrPB2EjmSDrKJ25ISkKBKb5kTa98/r7bhvoz46HI+OuUXilrUmnaJecLTA9HYhiMaLVmcpxgkjmPDqHGpYj4fvnG0qHgp+oyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dg5CGZy6; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773848331; x=1805384331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9bAgvooKKzsR4KDfTNf05LEzxOXMOI7y3MhGBu+R5wA=;
  b=dg5CGZy6ZxEMlp4TsK0CxR+gP1H34hOkQMoSRw+IibLDZLaOlrqv0L3t
   43ldYsMYtobzGxlkLmtjZRY4y7Crsq5twnT2Sp7D+4euy6IEeN5Q2q6Ov
   VS3ZHfwI5TlFAgsqZdLgAHcRGzun+0xhMAwSoQbyI4TfC6iIIfqjkDeCw
   XToJNa4zPhBNzxggXktoap5m0WsJGIXm4sonEKRFkVxJd36Wm+sgu7F/P
   0/EiUeh5zpipde2RjhdYPvGvInDPlXXR1awBAOkehiRqfEiWfpFLGRjG6
   NFepH7H/LtMCsfxw8VdcC4cw6q2BmVM5IIMq6vcp37MbomnZu7kkpVfZi
   g==;
X-CSE-ConnectionGUID: VwHeaSBzQ66JaR7DJjcQOA==
X-CSE-MsgGUID: 8o2mwcH3R2WjvtjC3Idgdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74605840"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74605840"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:38:50 -0700
X-CSE-ConnectionGUID: b0V25hOxS9mgrjJaP9Qh2Q==
X-CSE-MsgGUID: 799m4D1JSg2ASmi4tNpZqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227352266"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:38:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:38:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 08:38:48 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:38:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaQrYhlOQHjbpUe1fSBlCbiwY3pqcBuVEQ/hyc+yGnfFTPKJRbbSB0jk/kDJDbqPS4+XSHeg/5zqB0+vKzK5gtDXh23rTH5l8sNshLBSRWPMZaHYpi1bNJAYg57RcixqdUzT0TpN8Oc9sf6ufnAsrnZN5SnQrtHz6nQvgbFy69cYUEt7CphDTIi22UBBTw/1Ir3j51EuEETOdtR2hBB1Ll04k51Ex7VkeOgGWaRVCqlnovqBs1RnPQ+xStB+rCr7sNatBzX2rtYJ0/zaSwd0XcOGJzQGHvoED0o69VDZn44OQWRbWuNMSdQK1xHKcSL++KMTw/TUEMlqlx6TG6JFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCmxoghRL7yYQBF8j6cp/4wL9ibb4pAdpVn0GE1D8PU=;
 b=N6NKbsNnaaYbeH5/tslRYqxq/3XFcvNLHSh+dZV33lcrpunl50r2FEcpiIXPgLvOchUsvCwQDgwyW0K8TV+6NNzGs57/Q1kFCS3FFDmBw5cNdAk7VljdEr0MFUukv/HXXyRYDm6SkcmrlYdVY3QIQ4peK35ZS0N+Zb8QKQ3P++f03ofYELSMSLYv7XKxKe80O21QShA1oUL337bjw0eRPUOZi0kA4jFVRIpyw+rb8V8G1BEnWCXN/0UAR+0EESyO+PUYrnvOnMIETDyOJOUdl/WFar9LDLdfU40EGDyhXZrSK6Dy8FQ2Pzruzup0tvFTBWEWGlu4qXZKlEkuQqNKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 15:38:43 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 15:38:43 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Agalakov Daniil <ade@amicon.ru>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, Daniil Iskhakov <dish@amicon.ru>, Roman Razov
	<rrv@amicon.ru>
Subject: RE: [Intel-wired-lan] [PATCH net 1/3] e1000: check return value of
 e1000_read_eeprom
Thread-Topic: [Intel-wired-lan] [PATCH net 1/3] e1000: check return value of
 e1000_read_eeprom
Thread-Index: AQHctuo+O4PLN66nZU+868YDYYuZsLW0bLMw
Date: Wed, 18 Mar 2026 15:38:43 +0000
Message-ID: <IA3PR11MB8986306AA92F2427C16A681FE54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318120512.687149-1-ade@amicon.ru>
 <20260318120512.687149-2-ade@amicon.ru>
In-Reply-To: <20260318120512.687149-2-ade@amicon.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6500:EE_
x-ms-office365-filtering-correlation-id: bcdd1a5c-cb20-4345-097a-08de85046fd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: vl6fstFhgxUMeHXAQ92j+GH7aV+VxoOwkeeeu6eAesOSu42h4x3ZAN4Y1AcPievj8R8XSgX5PzTvZhMRUW8iCSiQChrLtuBuGadn6MJwGB0gtMLhFPnbG2EvUIxR1NCNo1Z0OOqsH92pBrnMbUuFBSH5zlTa8TTZFmdDl8nqOy5tUv4G1kEvCsmkydN6Q3eHMfPQCK+BoHSQy+WiJG56w4VIQReYLbIHFJEt+STmKPHXIrLFpvmg8cSkvWIiepp8ISUlqNMQen5n1XdgSCCGOzZ58TENPczKdmufvbSrp4M0lZg1yEN1gKEAQueEq10yAE3UZLl1fNfMqTKS8Fc9j9Q1DwtyzNyhTir9zoB65IJcaqLiCAvgOJXY/i1b9M3uTYiyRqDo8tJRqJVq+p6ErzJ4eVPV2BL1+qmhECkGgkqrJW6XpPbbiui0nkmD/fn6F0JlxM0U2jS/upb4WSeRY0rVdeeMdthsNwSscYd010eIis/M7XbgABNS7oBKLV0rGYPUAecQHOAyQ00O+o/CR1pyFpqBt/bCD95dBKhl2p2TMhsWt340FvAM03xztEZkouYP4FKeWxo9I6AagbqPXHyneDdebZud6ULOCOXWKyViMz47uiUMvjBgPbiDrF648irLv5Asr6JVUzmh8EUiXqgO9B+PSFxmouxpzbYXAca81vo19KZjLc5bb0fpBnQB5BvPFMuDfXHPLPir39+ybTmQHQkTALmBa/v/LdwiaYdPC8kMxwsqEdoapLRf0R+21TLB+ooWRtQ57jA6koP7uNFCObunCdLKPZ11dde87cc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e3SPx1zuAoGWHgnKb0NKOkZjjv5kFW2kzuu4AGXnT1lViQeFcgCumY25kB6Z?=
 =?us-ascii?Q?/S5a4Kpqzzu/gkjbNbMRs7hGwn6KwXzysdBjGb5SBePaaq+bBsKr8tBBgpYV?=
 =?us-ascii?Q?2dSUupPicj0Kgesrxvs10XRpSCers5QWn1rMvIw8TzwhI+yCZRA0/jKEDIaY?=
 =?us-ascii?Q?gKQq4wT92yfO/2+KZAVIhKpyIkVOe54E78CKeM5x7oA4wH9Xr26M8wrAFyJZ?=
 =?us-ascii?Q?lBMgRLv+prgQXAIZr4GbKkH8/kKaYRe6krn5PP9uPMQKZ0+w2HiFfU6a5Del?=
 =?us-ascii?Q?QPkgAKcUp/975B0ScdzjsdPdIZqXR05El9mKt+ohMQL8ZT+41F+7YNGFAhSA?=
 =?us-ascii?Q?0LAkGJfUIlv/vXELC0FF66IhyGDkGcb0A7q6B6wHe/tqMIgWPb1jSIyFanEZ?=
 =?us-ascii?Q?apkqP6F5xklPAeHgnUd6ES2atUzbYyqNGgPBIXBYYuBK16zl2BA8aRNZM7Cs?=
 =?us-ascii?Q?bfTwbK+DXVkEQFaQl8A9YH4v5HoP6s0+rxN91ng9pq4oPhlxEQfGTzzLKcJZ?=
 =?us-ascii?Q?UyduViSP25vXZjlYe2+rTbhtmdw1suoVONj/HWWZ2EoUS/2170ZPQKdKrfNM?=
 =?us-ascii?Q?ixI6gPv29+9ML+Gt6rLBLpNWdh44kuLYZsBD8U5Jogsq5LAlzBooODbj/5G/?=
 =?us-ascii?Q?hg9shlWrxcH0rtL5m5lbVHf1iNbpAzoqah6QprTx8XdDIgcSs/0mMThEJx2n?=
 =?us-ascii?Q?GiS7LEYnQF0vi3HhQEQh7fPNKVgK0UBK5sVA/2n/1zzbto7tBqFZwQe+VDmX?=
 =?us-ascii?Q?Ctw1dVybBuWaLXTdnrjXmHlDKju39+OZ+Ql0LRDTN/H9KNZ7XKmynmR6f14y?=
 =?us-ascii?Q?6ExAR6KSyPDJN+JDe7tSOFoVepiwCH369Y53PFZPxv5lDRHQO6VDCiW5Mt7a?=
 =?us-ascii?Q?XCH1PfQeJ0Kq5/ym5GODJlXva/qbJ7sOwX1RHEHLm1sUJkgcGbMKQse76Ae6?=
 =?us-ascii?Q?ATFfjWqGO+a/UIFZk5uHiq3HfcCivCbLD9/W7CuHWWue/LWwFyfBAgerSz50?=
 =?us-ascii?Q?8X2ZvXjbiFJrjkdNCjgrliCS+/emUcnopOml7M2x60zS/mxkg1VHTAXo9Nl8?=
 =?us-ascii?Q?lLW9R2WSI2quN2BwQT9imZSuIEiVe5MEYJfi1CWfLHsw+Bqz4AojGzStcBeV?=
 =?us-ascii?Q?TrQEVQHUA9ctEqN6rsww1fs2jHfEzDZJ1dyagOedrsC/K+kR677S+F8C74Hb?=
 =?us-ascii?Q?blUXV4eOAzpbLYgfiX+qICPNGcWrxwOFTo8KVn/iZ5Ky6/bcL5RK3BIJZm6p?=
 =?us-ascii?Q?KJ/41Wwpsvig9GQgFBUvuOjh67N32rmdvkqSroFiqL5E85GuZuwihXbNYshA?=
 =?us-ascii?Q?b7DO06jzLPkkkjhXs/QMAiFgatk+3Z4aeu4SxyEBP8nK0Ic+S8P6lKVGlnMf?=
 =?us-ascii?Q?rzeVKe68tbJuPCb9n5vCIuvFBZzdqwP8+nytDZonSjtusajewwAYsVI+vMXv?=
 =?us-ascii?Q?VMlQhLKO7SUzZFylRbBZPdAqAfxzfVvOIB9Pnq8KmbHz2+yfAkM26jcEBqHe?=
 =?us-ascii?Q?9BFxjW8dZ8DDR8jhu7nzAozCMC0SjzyBpzUdVA69FPNtGa7GwcEretujRyCj?=
 =?us-ascii?Q?4KMk3wxWfHX20EZvdWaqcFUNzTtVbUXcoPwVB7PhTUhxHf1ErJ0sX5P0VaWm?=
 =?us-ascii?Q?d4giQCtirLRt9RGheq/sJbTcKCwvufRIATGXoZ4CG6GvTcfqeNcBbjKSC7wL?=
 =?us-ascii?Q?t0aPmWa+r378sZPYIFBqRx1lcTdyedsvdItByAoMlhmwt+WjQmGugH3tgx7k?=
 =?us-ascii?Q?1UiRjQikg05GGC9WFr4M6MONswha+4E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ns/Pr8b3UVqFwQpnRKSe77+n/d7v51hJIkFUgWV1JYLG1gjXnyY2l8V50+luDnjyBJn87RVEn9f+7FCATQ+7lFMithZFqtsS6xfHlPSPyuFkECQl4SoEJMOtheww32EdhNZVGGsBPlVAZqsJkQc+RU6aZwCyGIMZOG3ZyMhHXNTtGQTFSVOLgwwIbQidw3Xi+uWfj2k6u26oNhFyBBriDZitdS6mSt5z4V2EL3XrXt/e280q06itPYNavz5MNlQP0IE1MpS/iI1V1xn1vYlvpsTuwn6mKu0gs6PYOPoDMC6aHYQrjfYaYfQVDc/NEk4+P6KFtEKGxNDq5H15ObT+gQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdd1a5c-cb20-4345-097a-08de85046fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 15:38:43.5439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcJwXS+MW+WR1SFEQsr1W4XpTpa+HX1WujmUaqxnbdSPCa0l6Om1LPgYNNREbFX4QEZ/Q26jk7J49jTpTor1Wz2yuj6J/hyHKIKYKGkDalM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269081-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,davemloft.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.952];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 83A352BE7BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Agalakov Daniil
> Sent: Wednesday, March 18, 2026 1:05 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Agalakov Daniil <ade@amicon.ru>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; lvc-
> project@linuxtesting.org; Daniil Iskhakov <dish@amicon.ru>; Roman
> Razov <rrv@amicon.ru>
> Subject: [Intel-wired-lan] [PATCH net 1/3] e1000: check return value
> of e1000_read_eeprom
>=20
> [Why]
> e1000_set_eeprom() performs a read-modify-write operation when the
> write range is not word-aligned. This requires reading the first and
> last words of the range from the EEPROM to preserve the unmodified
> bytes.
>=20
> However, the code does not check the return value of
> e1000_read_eeprom().
> If the read fails, the operation continues using uninitialized data
> from eeprom_buff. This results in corrupted data being written back to
> the EEPROM for the boundary words.
>=20
> Add the missing error checks and abort the operation if reading fails.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
> Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
> Signed-off-by: Agalakov Daniil <ade@amicon.ru>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index ab232b3fbbd0..4dcbeabb3ad2 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -496,14 +496,19 @@ static int e1000_set_eeprom(struct net_device
> *netdev,
>  		 */
>  		ret_val =3D e1000_read_eeprom(hw, first_word, 1,
>  					    &eeprom_buff[0]);
> +		if (ret_val)
> +			goto out;
> +
>  		ptr++;
>  	}
> -	if (((eeprom->offset + eeprom->len) & 1) && (ret_val =3D=3D 0)) {
> +	if ((eeprom->offset + eeprom->len) & 1) {
>  		/* need read/modify/write of last changed EEPROM word
>  		 * only the first byte of the word is being modified
>  		 */
>  		ret_val =3D e1000_read_eeprom(hw, last_word, 1,
>  					    &eeprom_buff[last_word -
> first_word]);
> +		if (ret_val)
> +			goto out;
>  	}
>=20
>  	/* Device's eeprom is always little-endian, word addressable */
> @@ -522,6 +527,7 @@ static int e1000_set_eeprom(struct net_device
> *netdev,
>  	if ((ret_val =3D=3D 0) && (first_word <=3D EEPROM_CHECKSUM_REG))
>  		e1000_update_eeprom_checksum(hw);
>=20
> +out:
>  	kfree(eeprom_buff);
>  	return ret_val;
>  }
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

