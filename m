Return-Path: <netdev+bounces-285843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK20Ks7n/WkPkgAAu9opvQ
	(envelope-from <netdev+bounces-285843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:40:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1E44F730A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB2A730C14A4
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F193EB810;
	Fri,  8 May 2026 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7TQWxaa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424F3E8C65
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247129; cv=fail; b=JMWQxrJrlU5ZasknC28yvajRuAfCDUglz6OdlfswzFgKSg4Cl1+iimLsniHMuDkrCf4304C7CJsZrUMCnwvMQFPNjwjRENHpzJOqofj4aIluLWjXevabNBHGplvPTvPMGr+OOfaU4deIp50rdYMt8RnyEXQK5LRZJnTHypSqOdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247129; c=relaxed/simple;
	bh=1zd5VtAElPk6odNSMHUcyKjQtKUdayWIR3PxBN8XXNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IDp8r0qDSiexBIhy0HjP44JVjmBxZgiiJEA6FaN6mFDF6iNJTWr2h505wrds8PYBm2fs+Z39gPQf5cai7GaWS3J98YvMPEZT9JFe4oymtiurjx7VnpObXBE34C6gxdGo3Ec+C1jAvgOGxwhFZlGxpuWOigSmgcdHsjBLbrCYmqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7TQWxaa; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778247123; x=1809783123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1zd5VtAElPk6odNSMHUcyKjQtKUdayWIR3PxBN8XXNA=;
  b=K7TQWxaaLwPdSsorY/73FUaQbhULiabiuNM/mDx5s73rBge9gLUYnBYa
   DEMmXkMiD03EWm/BBrS7ms00xoEkegzMGqOS/rlqP/rqh1DmI+7yeXE7s
   tQBMr4qDm8h7kPRKu6RK6g0SjTAwY1wU3lg/VZ8ZQCXkUlugO7yMxSdZR
   eYhCN8SY/06ygE808f/PA1V1yUs4Q4Itj99JztcO/2aH3N9mSn5lZcsdo
   ZNb8mNdTP+DcJxoRK7pR14r0GOuP1K9Rrbvpqhgcg/GSRNat2klP3//wx
   purVEG6zlC+xLmGt9Gtt7sjzMzhQkC2KrRIjRy489x/QfW2u3cBQSJL0j
   A==;
X-CSE-ConnectionGUID: Gk5u9MFCQHSkipwmxHKDGQ==
X-CSE-MsgGUID: mvy7IHPrRB6ADWtSzqyNoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="96783863"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="96783863"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 06:32:01 -0700
X-CSE-ConnectionGUID: pqutQ20EQQCAZEojFmwZ/A==
X-CSE-MsgGUID: zNR+zP17TQmeLCWyHuXJng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="234108651"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 06:32:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 06:31:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 06:31:59 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 06:31:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmru4lTvFPg/RJe0C1qCnl2OVe0mwlG6LESpMSTGulZaVJSvYX8fCFTDYOq3QQjUSkqZriYpe8ir+/v5lnL9DEFSAN6l+rwDQlRtW/JyK0TlcJ4aArBjBPrmKZ6V+F+/c9mBZe7c7mWHpJ7kjAE936uEuEZXKFZHwWhCRExgGbiEbD7FGEx/I0OzmUQWtI4ako9jQasmSmqkbqatw+WjOhr0hArFbHp8KMnTnBzSAO5Dr6V1Zxl6g2cqlnM5bNk9QqMYRz+0FlY1Yz7+f0N/RanHol3bPcpn/klBg93o5o9QJ2gXiFxDYB7QAGTWI8eIlBlrZ6Fc8LQOPoF4YkkUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4UhrMmJ2jBbcmXkniIRIK8IWxqAg3kCHcNpJggexn8=;
 b=nGYr+5oxmYzYuRLJ9D1eHw3upYb0evUdX7nCUZ/KXr/MRmxOqAQLg3NuVAERDy+h2TX6PcLSmtTwOPY6RNtXkkQMNX92dIoUDRNe3gpAtB+af9lROeFMTRyzV1Kmn7KvLkWdP3MrTMAqYOs50V/FT2+JhPxRTZDcmoohCMAVRsyvKLJ6vs7jCQ/qrUmhSlKybX1TvtUuybqslQNA+Vc2rEtM4BUSCrFS6vYCB9CJfShRYB/vRDV3xdHYlCRRnk9Mbmb9j+OVvdYqJYXe1LGMfLwDfbFxRNC6UulHJMwcM2qLU80Vkl1IgijJyOrIaDnjtGGxorRE7ECS2f+OosvoFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6545.namprd11.prod.outlook.com (2603:10b6:510:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 13:31:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 13:31:54 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Schmidt, Michal" <mschmidt@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, "Richardson, Bruce"
	<bruce.richardson@intel.com>, "Medvedkin, Vladimir"
	<vladimir.medvedkin@intel.com>, "Connolly, Padraig J"
	<padraig.j.connolly@intel.com>, "S, Ananth" <ananth.s@intel.com>, "Miskell,
 Timothy" <timothy.miskell@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: RE: [PATCH iwl-next v1 03/15] ice: simplify ice_vc_dis_qs_msg() a
 little
Thread-Topic: [PATCH iwl-next v1 03/15] ice: simplify ice_vc_dis_qs_msg() a
 little
Thread-Index: AQHc3uqTZU59iluE1kmrax+P4Qi0VrYEICWw
Date: Fri, 8 May 2026 13:31:54 +0000
Message-ID: <IA3PR11MB89860D580281C5FBD7B05F88E53D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
 <20260508124208.11622-4-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260508124208.11622-4-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6545:EE_
x-ms-office365-filtering-correlation-id: 418a6a4f-ca9f-4241-448b-08dead062b4f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: O7I6x9vf12XQqEoAU0U8ipg4mDOtPLt3HYj61oyxTHjuGU5j/ukbI4HSqQBb9D5ThC1xC2NpSQmo9tp5LMyt9E8lBD/lONo9M9i0fh3l4CTsmlX3GE2xcYXG0fDpZ3m4rIBc6ZyURngTpVcpDV5iplUdLErfo7oIwK7rVThK/ByU0RNHbFIwX4oe0MJtPhnAwGXpdwvV4bfJKd617NbzZ765hiNYPAx58Ae3vn7gq43ResWWHXpjf9Q3DEqcVf5IhPTZWkqyOSfEmeCxjf+bJkwTX4SRkVWFYleLOj7AdnwbKgU18LuYTmhIMoUK4SOA7YAdqPP6zp6KU2q8ygkACbQab8iRKuL8tcHwleEkOi9IWFb6d4pAVPTY4ot8Vjz8TAbb2JT2+TMIKh04s1+Qh9cOAQwZwBcHYvjokvDFxuv4neyfMywJZVtpbmzAXsFef9xtasV31NPawOO5erHRkLFRhl2pM3kyHP7E4bJd6xTV0gZh+6PFpP0/LD25El+95goKJd07HbXeLN/ccsFdWxJaOvFaQE5XutIFgg7kqEJUBgpvnwHrfAe7qNr1O0PSMiDafuPP4oJDBgDUx2oaD72Gz7h6Ztm+zZJhwdWEq8BbTNLNk2vyBwGR4W8d3GURrnZGwKXW6ntahZNFn7O+4Q67FIYeLlh3anZ7V6xWhPTiKdwQz/MtFZChBkxxvmT9SbHIK7LSgk3DAHBatoIAK52+mCVC/dCHUhJnnD5cCDImKnKchVTJKhe6dzlRVM1n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sjKOzgxfXq5k5V/yIzLc1cizKJK5UXbrxhwalm5y9CsVcpZEfXyso97E3N3q?=
 =?us-ascii?Q?+4lGqRV+h6lP3lo+jO1wazQfeaFP6POuyWCMaN+LiXgVR5a2hse1nhOO0fN5?=
 =?us-ascii?Q?3BBfOpQBgaqWnRjdX+Y34vtgRqOR8hX9tk/ToM/3TwiAAFRc2WLBKiNjZAgn?=
 =?us-ascii?Q?TfKuW1D1sYz8tDavy5v1QTTQhG7WdIYpmyhQQndUNDvF2AvnFmB6YzneURbD?=
 =?us-ascii?Q?HmIsR8oEuxPl9vzozoiGX8c5+zx2gcFuUGq6EjajiNrO/9nTzfFbum0FXen8?=
 =?us-ascii?Q?bo130XTagvM7KmUFULYGbuij5rKkiCrRL5y9HUX5rFnkN3k8QDqpuVHu6JV6?=
 =?us-ascii?Q?m0n2Kdx6+m/dgT3nXufZcqisNr4GbjiiCGcP7bms7KIrgC4OT2kTU5v1HIpn?=
 =?us-ascii?Q?F/3GB4/gDR+VAOcT/0g/1YYSZLqGZ0yFZAJNwMYV6KnKbXW11s7Svw6ez5HB?=
 =?us-ascii?Q?Y1tyurXI+aITS+gvfI+jQUO7xVTYgCP3LQuo0/CeiO0ue1TSOBNFa9V3hKZe?=
 =?us-ascii?Q?cfH/dQesS+VND1FoNuVR8AvXwHsghFZtZCc+UQkoV6Tq7/VZqByj+MLCGw7U?=
 =?us-ascii?Q?kshAXB/M1bcfqVADRJ3IyQypf6OhrJC0zrKc+1JVwzdi0TF9QwGoqs4TED+L?=
 =?us-ascii?Q?aZj/Bydxo1fOVktqJNV4KABfEQ5mJoCb8qUznb/bEiNlDVXXwefXBXNiVW6Z?=
 =?us-ascii?Q?Sa4gEEQ+ZM5hg56szWZ6zqREHixS32SeRrL2eyW9QXtPoxcOO8jmuQg4KuGn?=
 =?us-ascii?Q?1St7RFahSBxxNkoLZsvy81B07DAF+AJAr7h2RyKX3uQuNcHtYz+Gzc3A5XJu?=
 =?us-ascii?Q?+pN1cQtgLZs/UC+LnEjfffasGeHJFb5ARyvrg8AdJMqtQmlFss+5KF3dEaDV?=
 =?us-ascii?Q?kWESK75M49lay8Wu4+jXN/5b9VKXR5Yf56xxskNemE71dW0PgBkGbxT5YcTA?=
 =?us-ascii?Q?5cvz+ntUoqW9viTEwptrdFacjb4vt6L8ab7P/OJVRryKeJMehgE7OZXpETs2?=
 =?us-ascii?Q?mjlvfgBIbMiqx6oPG6rRn/2DfqLcraktPtSkBbDx2kQp9yIQdeVVWwYHHiqK?=
 =?us-ascii?Q?NoHQ40fWUgPzEZpvVurlY9i6CS3U7I7+YbiQJFPDY6uV1nenQgXovTP/CU/z?=
 =?us-ascii?Q?X0NIOD6NyNIeY6oHmACGSwTXuM8QsjNlSCZwY6ATL823VZOFN3Cvxih8qOum?=
 =?us-ascii?Q?kMmpQkzAgbdr7Mel81Hn/VKTaxXRArCgDXIRKXTH6VAyAMJjP+rSzPSq3iwS?=
 =?us-ascii?Q?L5W8LBLOoIDSm5Z2Mztp8iooYt+T+FtfPlXtAtZqm5WZ5Fek3Q5IiJDaatSj?=
 =?us-ascii?Q?8LpnwBVWVHhoSoZ20i7eXN13np0AW82ZMjBxaq6brGNk17kFI5wg/WdwLFlV?=
 =?us-ascii?Q?QpwnP5p/1+9RWNMtbVfx6u/n6VC7/OCCl5r+JGvIULLeVCUml5ClnoBMumMw?=
 =?us-ascii?Q?Ep3cbqdOQkrgG/TT2/Ynecgr9c1bdfMpuuu049sC/MzVsUynNDpOCApJ+Ee0?=
 =?us-ascii?Q?Gh+/Ja4rxq/xz2OmJBFeYSXjrmF8yW2AYJn6+mh6FjM2F7RmN4vLr3SoQans?=
 =?us-ascii?Q?jFwfi390rnLA5bi/p45YuIOPJer73XCMm8DXU3XwHs5Z5wDEVUIE7JIujzZY?=
 =?us-ascii?Q?h9Zfsj0EZ2fd6cIgwMMMNCjjClpwinzTCBHV+gNbZ357ZOY4PpERE3/bKjKs?=
 =?us-ascii?Q?IhAu5bIunMlwDmYWS8V4POTkbGFV2cNXBbrFgtqV6y0bZ/8LMPkVCyTogENp?=
 =?us-ascii?Q?Mvi9qYZoXfqhvnSO0evwRPeAQBue6DU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rI5R96lJ5Bnl8GllciBz+37aa4koJLfRciN14G31ybAsD2iV5DB6cKUtFFOGnhcoxfEfhKL1HRDeToCAYQGDClgFFyXrbB4kXK+sqX5Q4OASFDCcpTpFgDb2w+CF/NkOFJ7GHSh3Lm25IGnCMnnQsueHodeufRwzU5mLhCmtRuShaXoC2jkCmD87r8SEVT8ugX5ttwNg2h2r7A096l/oRNrCf+ZlM8G4fYm2rO6xlDnm0EPoB8P3AFifzS0T1BQW1dygEeOscB6rvQxsZKn+RQEONSsogAqaehpwoPdxCfNbPNyPAdGC8sU2CL41ki2x2djEkuNAk/RFrumGcgqWRw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418a6a4f-ca9f-4241-448b-08dead062b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 13:31:54.1127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BSlXQfEwuIGZ7hJKSdhhwDltmCRbG2RaVs2lDyIhi2oFPVzjInRWgawSpFbqt0UGrxrcd50b9ichdU9a4lo5jQtqZShVmqTk/Jah6Wzgp2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6545
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 0C1E44F730A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285843-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Friday, May 8, 2026 2:42 PM
> To: intel-wired-lan@lists.osuosl.org; Schmidt, Michal
> <mschmidt@redhat.com>; Jakub Kicinski <kuba@kernel.org>; Jiri Pirko
> <jiri@resnulli.us>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Richardson, Bruce
> <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Connolly, Padraig J
> <padraig.j.connolly@intel.com>; S, Ananth <ananth.s@intel.com>;
> Miskell, Timothy <timothy.miskell@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Czapnik, Lukasz
> <lukasz.czapnik@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Saeed Mahameed
> <saeedm@nvidia.com>; Leon Romanovsky <leon@kernel.org>; Tariq Toukan
> <tariqt@nvidia.com>; Mark Bloch <mbloch@nvidia.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [PATCH iwl-next v1 03/15] ice: simplify ice_vc_dis_qs_msg() a
> little
>=20
> Remove special case logic for disabling all queues in
> ice_vc_dis_qs_msg().
> There were no actual speedup from it, the only difference was in saved
> bitmap checks, but the HW operations take the majority of time anyway.
> ice_vsi_stop_all_rx_rings() used (in the removed code) loops over
> rings anyway.
>=20
> With a message added just before removed code, in the "remove VF"
> scenario there were no noticeable difference with the "speedup" and
> without, and it takes ~0.06s on my machine from this point to the
> whole iavf removed, so really no big deal anyway.
>=20
> Next commit would otherwise need to complicate the "speedup possible"
> check, so it's another reason to simplify here.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/virt/queues.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c
> b/drivers/net/ethernet/intel/ice/virt/queues.c
> index 31be2f76181c..6e4ec681fd07 100644
> --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> +++ b/drivers/net/ethernet/intel/ice/virt/queues.c
> @@ -357,6 +357,8 @@ int ice_vf_vsi_dis_single_txq(struct ice_vf *vf,
> struct ice_vsi *vsi, u16 q_id)
>   * @msg: pointer to the msg buffer
>   *
>   * called from the VF to disable all or specific queue(s)
> + *
> + * Return: exit code of sending the virtchnl response.
>   */
>  int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)  { @@ -406,18
> +408,7 @@ int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
>  	}
>=20
>  	q_map =3D vqs->rx_queues;
> -	/* speed up Rx queue disable by batching them if possible */
> -	if (q_map &&
> -	    bitmap_equal(&q_map, vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF)) {
> -		if (ice_vsi_stop_all_rx_rings(vsi)) {
> -			dev_err(ice_pf_to_dev(vsi->back), "Failed to stop
> all Rx rings on VSI %d\n",
> -				vsi->vsi_num);
> -			v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
> -			goto error_param;
> -		}
> -
> -		bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
> -	} else if (q_map) {
> +	if (q_map) {
>  		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF)
> {
>  			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
>  				v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
> --
> 2.39.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

