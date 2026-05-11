Return-Path: <netdev+bounces-286511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJI7DeCRAWrTeQEAu9opvQ
	(envelope-from <netdev+bounces-286511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:22:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA83750A054
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30DA93006804
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E973BA248;
	Mon, 11 May 2026 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU0lIznd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CA3803F1
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487770; cv=fail; b=kWAjynUOjQeL6A1ekAtUbgk0FAyQJpROJM48Z9y53Of9HIPeQEbdfYwCaH2UEEMRSbuoXBrFDCkjwPVsWMNUR4dk0Jz/T2ZooIvT6+XQ8ESEGM8YeH+KflfmbQhLquDAaVWogmbN7NmFlvPF8qF9KU5xK/fi74Rc29wu2dHMVr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487770; c=relaxed/simple;
	bh=DvrU3/s+CNQUtiO/gDT+9ejIBE31PdmpESV/HX8q+l0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0Q/2b5c5XRQZZ7haAxQ5ZXVJbZDf6sXYwLefi/qCojUNV1MIHGBfcwzqQBVjb75VxjMt6nyZvZ22/dgEBhyJ7Oqvc2ElZNTYlBieKoJSVy7t+tEvH2LPU1+qPUHDRl5mh0qhw4qfUeE6Axsq3jG/F0yF0p8NEOoS2LrlPuJUIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nU0lIznd; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778487764; x=1810023764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DvrU3/s+CNQUtiO/gDT+9ejIBE31PdmpESV/HX8q+l0=;
  b=nU0lIzndmU7L5gTFN16TNyBPQ5+ecztnqUxM4ZjjS9CM3vGnfqibZA+K
   Pq1116+K7qPv8dgSJTD06HyuLf/xIDvTqMFiXqdojccUgh2C1JbBboDD1
   SknFRbedOh60mA84nNt1JmAoo+gdpbeSt4qPtqgDwT4gfag2PfmTs4aA2
   WXXFHVh9vlLH+Tg7ErkbszzSCIdDJK6tFnMxQ/PwU7MNXncAZq/ApQMGC
   QjPpgliUMe4GaZU7dgFemlz0FX4QvdIwpHGzJn8tqFblRRqQB/DCgKYP8
   YvRsZAKZt9R4YqxWgRlZAc84VIJQaW1n0CbxMwlN/jfCdUTN/Ch2DpJt9
   w==;
X-CSE-ConnectionGUID: tAEjzLqDSz2e0dHe+UzxTQ==
X-CSE-MsgGUID: nT0ndhmpT0e5QuiBDcfRZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="66900245"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="66900245"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:22:41 -0700
X-CSE-ConnectionGUID: yrh0309UQQShPeGJeWxhhQ==
X-CSE-MsgGUID: Pxd4RH/qQ069d4BDYFmm2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="242356616"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:22:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:22:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 01:22:40 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 01:22:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtCDWFdOGgcmRmgP9U8PpvCAXaglJOA48hBbOchsaZx2kzd6E9FOR3uTEWom5b6wBUJfSh1n4sgcIe8RwZpF1Kr5NLuIaZ8iuF8JrX86VjRN9z9Z6swX5zMDcvLnLS4qAiZHrS7WskSAKDcVowtXU8mCKakh4k3smfEJU5eHNXiK3Qi50FFe2HNR20DOCHETzo89hFC5wg+hFCEvm6O+uvAOqo85rcUqYLgd8tGCqPq/mTmXhSAt8PbSAaOc6/fi9OaIm2plQDgSVfhGBBovtfKZ4Dek3N1VfNCz5JVJRVIBT94CgPD2cprdmiD6bgqBrHww8KV2PfEUZ9ViLaGhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhX75Ghg12vw1M9EteIgsiDjdWfH1akdsRRP39tOeNI=;
 b=Qs4iDV+7lpS77P7Bj1G4e9XjAos2wNrLC645Sv3xRCnchNGFUxS4Pjak4tUX8zoxaaMpo1kBWBgWmIvsjOJ5KvgE1znx+lXuvEUA5AqdzuMIMxGXuI5z4h0t9O5bu/mfI6W1tSzd7gNMoT9IYfLUvwItLlKMmC8lSHOy77zONBwZt11zvjWQGheuQrMESqlHeHXJX1UL1+z2wuRo+2Mg631M4QdOzSSiX4UTx8zk0K1Mh1yGRSgqGfXSFdvQwn5Zz1XYe5U/Qnx5u5pPUyXsMiCJo8EWjEsefg+WzRbT/pWkeniy6mQpxcNN4F+0DTHUAQQAio9ZMCfBctcb07BahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CH2PR11MB8816.namprd11.prod.outlook.com (2603:10b6:610:285::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:22:38 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.20.9891.019; Mon, 11 May 2026
 08:22:38 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Avinash Dayanand <avinash.dayanand@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 4/5] iavf: fix TC boundary check
 in iavf_handle_tclass
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 4/5] iavf: fix TC boundary
 check in iavf_handle_tclass
Thread-Index: AQHcyxeIPoWlHT7n5EGSuqCEvdqtP7XgJmYAgCiB/TA=
Date: Mon, 11 May 2026 08:22:38 +0000
Message-ID: <IA3PR11MB89854F2BE90AB13EFEA4BB808F382@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
 <20260413073035.4082204-5-aleksandr.loktionov@intel.com>
 <20260415134642.GJ772670@horms.kernel.org>
In-Reply-To: <20260415134642.GJ772670@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CH2PR11MB8816:EE_
x-ms-office365-filtering-correlation-id: 4b495dd1-66a5-48c3-ab09-08deaf3676c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: U+rFPaqG0ZzQLaM9UFHO/7mYEKxy5vPHukzJeKJfAPjdd8DBqffLtrDGS2m4RxKo3HcHnQ/nW4G2Sdx4a67Ycu6aM+Nv+ERrJyLtMXVZZNrX4xzPg93BWMM09Bfh0CcVQymjez+PFbebIwzsruIH1PNEHx9V+Yb5973v3cPzH2bz2B1JjhjFHb+rgAJsHQ4EvfuS0X8RQKvmBI1r4GkqST+OhHd/UwlvMyh+fwec4PlBHDXnTVhnas90naluzJOUbCgy3ToI8CUWQbgBfAa7YUF9eD6GSJb3YYQrhObi73T/9UXhW+BtoUWdRRO0p9AGw1WYyTTWmMdORfbXAu4BbrU7nMzgOT+AsLYK21xMJZeqrpMvAJDDscUX1cRIJgUklftK6PmLWh2mrt2I4Pznb5CDch6d0qBTLmcMMdIV8Yrf02/C/OIpIGGgCxVuU/soaCFaamzc40hzlM5uBlQw3SXDNMBvEuE1i9EkwyiraWtvXMOcuLhaXqZkytJ1OCoMUHo52x+RnzUdC1FpCG3cURm0KwR2HILSYhN8r3iMGLtXt0is3eFP20tVZkv6zlkP9bUpP1fejqSF1mdCWW6EhTi5t4B64iURIk1C1Dfz3nqv19IGfMWbZppxkgr+FcRnhsTu9qkjIyY5M/ZguUOgMldjwSgzRg+4R+0T+Znq7Xlcf1PronPpxK6eSCg/tOetCVRRJKJZ9UW6MUGhDP/l/u+Upr/+MsY5bczTaDTrvPzh/5mdLqK+UBQWAiViqkST
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZU/TrxcrULZy2Q7uTcWZVMZinJ6XJex8qLefcxU6/Usg+IU7ui/zBNhQa4Fr?=
 =?us-ascii?Q?Rk2zOo74UZyQpulkZHtiMRo2qUkJFu+jEH+F/ZzsHwzoOOxOH9HkLFXLrUqz?=
 =?us-ascii?Q?a6kq/ZjjWpjK/Dx4BS1am4EvnD7VeY74pg5fiWuTetkwNqxY3uPYCmNBTxEw?=
 =?us-ascii?Q?fv/6D3ua+NZzDlXV+jZ7JsdG67NySRgAA75zpRPV7SwbGjh7TG82saUicOTN?=
 =?us-ascii?Q?+zYQxUkbv99CWYP/nyMX9KQ6eh+f6r+8PeVoL/gp2gyZJAtVOw6o1YpheZ7/?=
 =?us-ascii?Q?qM2szHXxmiYxvW+EeRz93qUSu4QciZ7qQM7eGvqPTMOzBn2xoCb6VkoCPNAP?=
 =?us-ascii?Q?QBSFvSGRpmj2Zc+b1GZrp5mg8eJZStx80V2+vMEM6aS3Vaugb2gTg44Nobql?=
 =?us-ascii?Q?N6tPL0cNJt8otWrR/HDr9AdsNf0YPVRtHUtWBYpv4lOcmZExvJSJwCdqH3wt?=
 =?us-ascii?Q?xskjNS1VsHXR945eY2BUktFWyuNJtDlS2PEdQRDJCnYCvRVDbvgvaCHju9l4?=
 =?us-ascii?Q?uvfIN63aQsmNqyxkSI5W7EVEmlrjtRtj8oN9hTBw5hnu7gmpjaBu7901s2t6?=
 =?us-ascii?Q?oGlBxvWz5IVq3t38MJQbC8KkUx4dUIAlUU0QQ7FQURpodhfOHsrNM3jPJVAn?=
 =?us-ascii?Q?bYryf81wrq22mZdFqO8Uqd+Wk0fz2Y0ehQ8pYGmsX1X4PtufQa3ESawGZX3F?=
 =?us-ascii?Q?sFOWV2Vho60iNm6KS6u4hOA4lCvGE1O4jF8ZHrMSnNNe0j7Z3xlvwxinODF1?=
 =?us-ascii?Q?fGR+GLUu420yRUK6HtaxDFUCq82YTCVgVuINyKdscrfQwP3fUa9PE4O4FP32?=
 =?us-ascii?Q?PkWjOYtdVwww3MFpMrW0pppm0SfAqehkM/3+FQn7JuWruEVpt9/dFcb9J9zG?=
 =?us-ascii?Q?bQ28FYfb7LsCZgWrY0Rts1UwfD0eAA52gENSt8bEhorBD7WSgFCM9SyF2f1u?=
 =?us-ascii?Q?PcPgltVXof6ekSZQ/oQHUCeE9RKxhPM/qoZ2rw5Z/rKKEmITWkhKNWUeOdgu?=
 =?us-ascii?Q?Shs9pflB6TnsKc5VO1t14cS/+9xOufszLWmbx2CbTc/YGY59+/1IYew52XHy?=
 =?us-ascii?Q?7Z+g4LfOalgdmo1gSfdjFcQO6fsjln5zdkU75SBsscZi2p7VqqHkoO8w7Oj9?=
 =?us-ascii?Q?2I/JIqCIviFUXKzhMVgjN9Yw7FPoxDh35VCkJy8wi+i101pzloQRcO3A8iFI?=
 =?us-ascii?Q?OVt4lmHQeVJWftfTJtJacVX0O4VMnV6AUa6Fj/QIp+/0WzAXYEEgkxKycG+3?=
 =?us-ascii?Q?HRBkU65ATk56iiKMXrQhM/8kHB8AgxqdX+7nq3nXMMnuQt5QhP3bP6UV7Sn7?=
 =?us-ascii?Q?noHsyL4by5PUi0erUIVt1MDIujSGEkco0qQgZpxRA4tIEyW+znTtW2ordFkh?=
 =?us-ascii?Q?QRTGCv63i1bJ2dasPy/Ba9jraGTiDIQkInuv6QblK6a2dFfB2hP3mfTt7Z8i?=
 =?us-ascii?Q?l3xInVaCBHEmF94U5fDk3KHGzl7aVbZy/t1y0KrS+W8kGb1sHdO8VpyGKx6/?=
 =?us-ascii?Q?oteCAcYq2mkzRysYVHIkwTepKZoL3G9phlbul+e57bD4l0io6g6vxW1TVXNj?=
 =?us-ascii?Q?g9FmsrCH2sySpZ+IpgN6iJn7u8WeD76LmF2etX/7rctd/C2miV2HAIF3YAGC?=
 =?us-ascii?Q?pPgO4eGTcZuA8yBAcPEbBIMmO0S91MboxnGENuMW+7SG1/HZctDB5xmDzkHv?=
 =?us-ascii?Q?hoSShk4n/d1+n2WNVOB6DRNM9dOLXlJlEcixKXpaYoSEqGH9h3pcYvxT5rap?=
 =?us-ascii?Q?jPdaKltYIA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Afah1OeD9aYuA4DJJFe2SAGSweofJ/x8X0217SL+9D2D+RjeWA7tnsO+/aQ69KyoLgk8vZH+qGlBc0JmJbi9d9ccLBB/DfrdhvQ2uyMiMtzvBFIyLy4sajuwWNc2bmSua+RKC8QS3TcH80uLtQWM6QUc/AUxcpOQ/Tdj+ocwlE5+6XEdQP4G587Nq172whrB51j2uTN824Dj/59DbILx3D8Gv3Uitifc0Y9s8QOlZjx7EmwWbPouW4zyBHqlsYRcxxiQsj4W3SSeb2hMfqax2MOFkFRmrOrFokMu4t0WjBS6ueDU0pPl1QXDXn71/vRMdNnLQdOXzNBan5oUNoL1Zw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b495dd1-66a5-48c3-ab09-08deaf3676c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:22:38.8798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reSKpxu9b2pX3EJFhIS99PuTkyAUhSjNS29KjyfVqFvGK6IymxxgebU7uN9/rUyzE2qKxO+GhVlrc++jK3uolSPfSOdmhcT7Bs16mAfDGqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8816
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: CA83750A054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286511-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,osuosl.org:email,IA3PR11MB8985.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Wednesday, April 15, 2026 3:47 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Avinash Dayanand
> <avinash.dayanand@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net 4/5] iavf: fix TC boundary =
check in
> iavf_handle_tclass
>=20
> On Mon, Apr 13, 2026 at 09:30:34AM +0200, Aleksandr Loktionov wrote:
> > From: Avinash Dayanand <avinash.dayanand@intel.com>
> >
> > The condition `tc < adapter->num_tc` admits any tc value equal to or
> > greater than num_tc, bypassing the destination-port validation and
> > allowing traffic to be steered to a non-existent traffic class. Change
> > the comparison to `tc > adapter->num_tc` to correctly reject
> > out-of-range TC values.
> >
> > Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> > Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> I am a bit confused by this logic.
>=20
> With this patch applied:
>=20
> 1) For tc <=3D adapter->num_tc, which I assume is valid TCs (other than 0=
,
>    in which case the function returns earlier), the filter destination po=
rt
>    is skipped.
>=20
>    But the failure path for that checks logs:
>    "Specify destination port to redirect to traffic class other than TC0\=
n"
>=20
>    This does not seem consistent.
>=20
> 2) For tc > adapter->num_tc, which I assume is invalid TCs,
>    the function will eventually assign fields of filter->f and succeed
>    if filter has a valid destination port.
>=20
>    This doesn't seem to be in keeping with the patch description.
>=20
> 3) The above two points aside, is there an out by 1 condition in
>    the condition tc > adapter->num_tc. It seems to imply
>    that tc =3D=3D adapter->num_tc is a valid tc. But I suspect that
>    is not hte case.
>=20
> In short, I'm wondering if the function should look something like this (=
completely
> untested):
>=20
> /**
>  * iavf_handle_tclass - Forward to a traffic class on the device
>  * @adapter: board private structure
>  * @tc: traffic class index on the device
>  * @filter: pointer to cloud filter structure  */ static int iavf_handle_=
tclass(struct
> iavf_adapter *adapter, u32 tc,
> 			      struct iavf_cloud_filter *filter) {
> 		if (tc =3D=3D 0)
> 			return 0;
>=20
> 		if (tc >=3D adapter->num_tc) {
> 			// dev_err(...);
> 			return -EINVAL;
> 		}
>=20
> 		if (!filter->f.data.tcp_spec.dst_port) {
> 			dev_err(&adapter->pdev->dev,
> 				"Specify destination port to redirect to traffic
> class other than TC0\n");
> 			return -EINVAL;
> 		}
>=20
> 		/* redirect to a traffic class on the same device */
> 		filter->f.action =3D VIRTCHNL_ACTION_TC_REDIRECT;
> 		filter->f.action_meta =3D tc;
>=20
> 		return 0;
> }
>=20
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > index ab5f5adc..5e4035b 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > @@ -4062,7 +4062,7 @@ static int iavf_handle_tclass(struct
> > iavf_adapter *adapter, u32 tc,  {
> >  	if (tc =3D=3D 0)
> >  		return 0;
> > -	if (tc < adapter->num_tc) {
> > +	if (tc > adapter->num_tc) {
> >  		if (!filter->f.data.tcp_spec.dst_port) {
> >  			dev_err(&adapter->pdev->dev,
> >  				"Specify destination port to redirect to traffic
> class other than
> > TC0\n");
> > --
> > 2.52.0
> >

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


