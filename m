Return-Path: <netdev+bounces-145114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0373E9CD4D4
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722921F21ADC
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF93A1DB;
	Fri, 15 Nov 2024 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbSd8RbR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F68460
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731632353; cv=fail; b=ZmuMjnnAdxoHUFnY7jHybBITfmBTPgkwvDYKpR/o0pLrguMwruJh3idmOzjC7tTzgE0fOalEb14OsPpQavKREl0jiOY6OL3eEg9epSt0z3UYrPD5N2k2locAlb0bnTf2jHItMNnFAqfNfGgYC2B591gYVRbHB+EITgPR6Ouky2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731632353; c=relaxed/simple;
	bh=OG8cyMOSCvJFMQyU6BeFHNrVaKR/oNQKI4Yzbn6Lki0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dl7Q+/TOZDTb7o8SnH40IIEz4EkuAcnK1AVe5rqK0ncLu3BUOXFw7cvdzWQspOYkT/5RYBbMFTq2GX5SUbgfctXPKfo0N7R+1ikzWoi6rg+xdHxkaNw7nAc6PXLCY1v1l4dPpXlywoVtrsTjsMs8cu/Yad/X2o5Rep2lNHcs9PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbSd8RbR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731632352; x=1763168352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OG8cyMOSCvJFMQyU6BeFHNrVaKR/oNQKI4Yzbn6Lki0=;
  b=QbSd8RbR62643S7BUPzFKVTZgH8Pye9beXPAIsQm8WIhm23k2vphgjqP
   p4AG2V9yKkPOFApqT3MqB/AHT9pxn4rQ9ugMc3bI1Czprov/5+caJf1OA
   Q2qjP3ngulv5bAOUGPG2WJsKKIP5lGTpd6BgD6ZWdNeScd6X+cgXmhji0
   2L5LbxtkgZoNlqGIfe6+2pBEZEOFgT7tj+wO9oi2swSF7YmRVfotukyRC
   ZG7+N5x2Y/OQjhjVm2UiHp5xIkORbg5zkr010ZNoq9BacBFchTZWvnEBt
   HyzOmdiP3xfSwd2tstjB9QdKmTkrL2y669sR+E1HzJrzPbjkBShYlje4Y
   w==;
X-CSE-ConnectionGUID: BnGjIQwJS2KHY4MFv/UpbA==
X-CSE-MsgGUID: l87Iu7CURLWRQYn2rEstNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="30992910"
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="30992910"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 16:59:11 -0800
X-CSE-ConnectionGUID: ItqgYrfMShSTxUfU7AUIkg==
X-CSE-MsgGUID: zhz4/ZdIQh2YcF8jpEohHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="88790097"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2024 16:59:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 16:59:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 14 Nov 2024 16:59:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 16:59:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psWZtorlpyPxAIz0RbuaSugysY/Lg4RE+moNTZAc5nFT1T4hYN62faiRiB/KBHL2mRZByfKRviyuI7vKahspy1OJfTgD+itu9p0k+DkSedIOjxEwsGMBQVQ+eMRhV1VD4Jwf58qnl13ZpR4juKOR8bA/AXxAOJ4QcPwGNVDZWY481ZV8blIIL7IJjZS0Srll61LKhV9t2GEGa1iX3bsfiO2PcjFz24F+cBm+SLee860CJClB4fflW5thRZNxSTXb1yyKLTfRM9Fy05SVfr+67OOm8pFI+9sXissQnYTywl5PlpfCz7UqISMwuJwgTxJn0M7RJNSOMw0ZdQJ7NWB5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6tNGccZcFl8Yim1E6oYdExzp0d8CmGXF7TJmc4b/WQ=;
 b=j1U4oExV0xemy0AiUTL0B3m+zRmaE35Qu5BqHDx8Nhq4fYOXGMpxyFIngsXOswWfD7X1ccXe3FlpmNnWgmxeNMum1TPEwUXPl9zgWT/xSXizTq7s+hxnQwLLQjlzSJcsDzr1q9K2F9Iq/fzBVPc9uL3SuHCv7lYORGi8DieTCgJan86wHTb8M1rB+G2f1gbyMKgWm5jmAA3Us2V7cBOnT73rd8nLwXAPPzDmhvz7EMTjerQCH0vs5JLxO/NFw5OKxcOPbxN4TVMR6WPm2ABHk4RlQum7xfpKucN7pYGi84S35tyrMVvFWqrCC7V9dCzkxQs719ThP/3psksur+4+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by CYYPR11MB8360.namprd11.prod.outlook.com (2603:10b6:930:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 00:59:08 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2%4]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 00:59:08 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: Simon Horman <horms@kernel.org>, "Hay, Joshua A" <joshua.a.hay@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: set completion tag for
 "empty" bufs associated with a packet
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: set completion tag for
 "empty" bufs associated with a packet
Thread-Index: AQHbGPX/lYmeeiDJh0Sg7Q0ct/Z6yrKKtTcAgC0Lx5A=
Date: Fri, 15 Nov 2024 00:59:08 +0000
Message-ID: <MW4PR11MB5911DE3AB10CCF79D1C91F3ABA242@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20241007202435.664345-1-joshua.a.hay@intel.com>
 <20241017090428.GS2162@kernel.org>
In-Reply-To: <20241017090428.GS2162@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|CYYPR11MB8360:EE_
x-ms-office365-filtering-correlation-id: 73ec0bf3-49e5-4cfc-7dcc-08dd0510b5d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yT7Ts/hmuubBdUhAYHWX0DOQdnfFKHXGKQK7DiQOMGYojtn1TKVR8bQHW/Q1?=
 =?us-ascii?Q?p/Zt37/b9uKcbwk2ocbh02s8wgF8DqQGjvomtWoe9QHtP7MJhtWBRFmkqroO?=
 =?us-ascii?Q?sW567hpncVTEEY0CA2jDGAcjzcIB5jxRuEgo3sVvdIG6DEoGucKqlGtgkUMR?=
 =?us-ascii?Q?48lqQgP8LuvZAw5ry7LSZ7+rmsJ/eos/pSp+KF2BRiHuxdV7NYDnLSK/T3qU?=
 =?us-ascii?Q?xpw4LcfPs5lGDZnb8N9c420NyQ0maBDyxBUKmH6DnkqDHA54gmz2I7WKEJQQ?=
 =?us-ascii?Q?9Oe2KVBTwNvnBTWexOIqB198nCxlroEgVSCm+pazIrUAKlro4NqMLevkrrxa?=
 =?us-ascii?Q?ukmAzAC85NoRmaYr57PClWVtRPCN2hn2uh0cE+Atn9XrQuwnuoUcDB2VPNci?=
 =?us-ascii?Q?bVoRyhZs6aruMMAV3wvwTpB64sDPdSN88XmRXH+p9Hk4cEQbwaNZ0lI9B0vG?=
 =?us-ascii?Q?JXroANbd6ZMyFt8sNsQpVlXE+4IirChFkV96Lr1v3BV09J8haew0dU+Qqh+v?=
 =?us-ascii?Q?Q58U6a/fCrmOPaJMFMegK7e7ijeoopGTkaWUjTKKeSaAyGod+kETpN0xyiPH?=
 =?us-ascii?Q?mB0M9nuFd8OFE+3Y3wE8/WOpv/g9rReQObLpKV/Tr0VWrEehk7W3vVs8l/d8?=
 =?us-ascii?Q?dYLB9ThvNKYx6NVJaIyscHzavoxn0OXVFGXFK9dYWBtoYdDahMZWv7Pqs4RQ?=
 =?us-ascii?Q?YIsIXaT2KRdUd9WnbR5/kCqgs+wNjcUf9i0HIPjGDc1huKJ1PkYhF2qIypO4?=
 =?us-ascii?Q?voP/WciYqlXsxicpwTdkqskadOEiL7B8wixdAKQZGoFdVWaiZymwcNmvjkI6?=
 =?us-ascii?Q?V/SeWm4zJhi8u+tKnFtNgtrq1ttmRpUau5DBzNlH1IMVG1WfxKO1ZXOZ1L6X?=
 =?us-ascii?Q?uo68nhNRACS/u0iAHOd59Hw5bdF2u5w9bN3Sz775HTQN2Zw6phnynEChIjKY?=
 =?us-ascii?Q?CsqxvrKRKo19GutmN9ho/K3zkomzqZTNoM/e1cTWm1UzqGyVJIunX+N8SDIv?=
 =?us-ascii?Q?d/pQvaXvzsRClZNUehwI67Kf5Vcpomh2YBaHxoMCuv09R/ud9CfTv5kAopf5?=
 =?us-ascii?Q?bYtGZLNRX4P7f8SttBAb7CtNZz2f04xOXsdeKN9wOB4B/o2DXB7oeb5nmZJe?=
 =?us-ascii?Q?JMZQ7xrFajQdCeLEDOGN8+2MS84Rx4lDLAuv9t6mZyPErcohzzaCWrRqshR+?=
 =?us-ascii?Q?gf+TZYo1iIzgr8clRKDYFghePAhDYuB+8zqFkM3iZWHbp5+kQJJkv7+qYgme?=
 =?us-ascii?Q?K57rTYyVfn6toC7SYyanPYpouSURNGRbDpUpcXbV4wM9UjGBDpqpFghYn3ys?=
 =?us-ascii?Q?il3qupDOzWWzGWJhrLTqRx38fmZS8F6mtxqBj4Xduk4o1P7W1xbpYXR5xkO+?=
 =?us-ascii?Q?F+ijFGc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yhBPI7LsKSTceUoELHb1CdzWillWFt+CNXb3L/FcN1hdiy3Dq0GSg2plpnVQ?=
 =?us-ascii?Q?SE0e8dXrEy1nFtWKgKAWZ9qozIU+g+FWapfdf1moYQRi3QFEDnOTK/DvEGIg?=
 =?us-ascii?Q?UI4gtpWLjXVTWzqUBwmZ1wGK68dsyszr6CXShzbSLyVtdy+ztgAxKwY4it/z?=
 =?us-ascii?Q?gZarQk/SKU3ICEuzD1GybvaJWM6aY6VEnrWGW8qpVKOvwjSv1WOtvT0Iv613?=
 =?us-ascii?Q?W2g2Z8Ju0Wf5w5gfAn65rLYxS0SJkyRFDiA+4/bdBMHxAL6eaLznTCq3/A+y?=
 =?us-ascii?Q?6sxXSZvSBPCXtKkwXAHxnshaCiCPzWwmgtakJGN7ISsrqY+j/zbrbf+vzx8H?=
 =?us-ascii?Q?cjAvR96aStam0TRTFDg5BbGptEo3QAFOdEIYI9QlB5d2t3JvB9DO+2fGqz4w?=
 =?us-ascii?Q?S6Tkp3mVcOSzBAP6ipQIk2I9tN+m/rIXfV66pu/8yOZ7On1/+Iyg35e0gg/T?=
 =?us-ascii?Q?SIY2LSSvU1cwl7D2newi9jyFPgdu60/cLrlGZfldmP4mA+86vEmHZXAmcYpw?=
 =?us-ascii?Q?bwWXd5obzeF5wBRRsJUuLAx+811t2Jxu8NmNVoZwMPHRw+FxYjzKvbXSMeeD?=
 =?us-ascii?Q?q3wK2RkzrPkAlDru/15dvn7PX0nGFWFWHoIgOE0UwLAl+4rZjkHOFTY7E9cy?=
 =?us-ascii?Q?xbs5uuS6RxL3cdchJfgZcrS49UinhuVWdAdZ73RQiskMJgEZDWB+nu06YoAJ?=
 =?us-ascii?Q?J0wBAFpcz2poX3vZKPHDc+nbt5sJpWw5cGpTZ5AkRjwouCt1wKfDy7rI/axm?=
 =?us-ascii?Q?7/Lv/dnwthFMG9AIAUG6KfWjdeWIsQcZSfE3G9cddFaJWZn7sYfKepR2xTpv?=
 =?us-ascii?Q?jDXa+jysD3Mf51QX2G6sxJrImHrRbxj2wYD9Y5UtNR4DmyiLvblPl//dO0R7?=
 =?us-ascii?Q?o6YkJPuLWKnvIJDAVhr0PWokfI+wCEA61ccDYyWpGESd+yanduEw2qmOODWm?=
 =?us-ascii?Q?J73FUngfuHdP7kMLVKvLyFzdPJ2vr7r0tsGbw84r3yFCV8i3c4eeelDoRtZT?=
 =?us-ascii?Q?bxr6cg4K5wG1ro8aBBDzrwLvqM3v5BcipgpvYjhI0sipzHuxhrRuEo6/s+ot?=
 =?us-ascii?Q?5Wuu5kOK9dxOf97AFq99pPwTgVLiT13OffZrN81MS3MSYdyrb+9SMJt+Jdo2?=
 =?us-ascii?Q?3d+TqkvM9vDuGoHakFli/Wmc5nYWoPK+XAPfPmwwWlbeJTvSHtOPdON3/6fx?=
 =?us-ascii?Q?Tn7RSjIvY4St3iYZ8jMgS5GvWzSqQm93uoppx3iEV2CcCvB+vlXnBtSWArpa?=
 =?us-ascii?Q?S3Q/HyxIr8YXs8hGCKUBBcOwH1bHbWivMhjov1vpT3V2kioM/bjev/txf300?=
 =?us-ascii?Q?4C/oxWs2N3gtd5OTIUYveMrMrlYK4NAp5K9Csp/XfDl1davjh2G9AUT1ibCv?=
 =?us-ascii?Q?O3+724EOqJvIDhfP6Vjtq0Q6IFYkKKCG4tLbcWhJKhyKe91Rv3lv2nRQJgeb?=
 =?us-ascii?Q?SSg7QO4N/2c+Esc5JtNxe+lcI9NPcKHBUQ+jY8zo4My4NYgCUKbSLxNJx5KD?=
 =?us-ascii?Q?mKPfW0uRN/eC2WKyu/4dJvDRIVT4XhFc628smnZR0TS3qbt1Cw5bHDHorHUW?=
 =?us-ascii?Q?PWnrcOcjw8S3zJUnUMIzs8sPXLP7LIC3p6swXpB4Gi1+zxD+QXcbgtiEHg10?=
 =?us-ascii?Q?qg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ec0bf3-49e5-4cfc-7dcc-08dd0510b5d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 00:59:08.4179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3F3mX3aKmGHb+71Oqn9O7QcHpcgUfpf8JS04TOJBHOs2+9skaSlsIbH8MRmX0T/l/ij8I+9sm0D84BJ75I45XFtXfpG20BbxNI2VIJSwio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8360
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Thursday, October 17, 2024 2:04 AM
> To: Hay, Joshua A <joshua.a.hay@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Chittim, Madhu
> <madhu.chittim@intel.com>; netdev@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: set completion tag f=
or
> "empty" bufs associated with a packet
>=20
> On Mon, Oct 07, 2024 at 01:24:35PM -0700, Joshua Hay wrote:
> > Commit d9028db618a6 ("idpf: convert to libeth Tx buffer completion")
> > inadvertently removed code that was necessary for the tx buffer cleanin=
g
> > routine to iterate over all buffers associated with a packet.
> >
> > When a frag is too large for a single data descriptor, it will be split
> > across multiple data descriptors. This means the frag will span multipl=
e
> > buffers in the buffer ring in order to keep the descriptor and buffer
> > ring indexes aligned. The buffer entries in the ring are technically
> > empty and no cleaning actions need to be performed. These empty buffers
> > can precede other frags associated with the same packet. I.e. a single
> > packet on the buffer ring can look like:
> >
> > 	buf[0]=3Dskb0.frag0
> > 	buf[1]=3Dskb0.frag1
> > 	buf[2]=3Dempty
> > 	buf[3]=3Dskb0.frag2
> >
> > The cleaning routine iterates through these buffers based on a matching
> > completion tag. If the completion tag is not set for buf2, the loop wil=
l
> > end prematurely. Frag2 will be left uncleaned and next_to_clean will be
> > left pointing to the end of packet, which will break the cleaning logic
> > for subsequent cleans. This consequently leads to tx timeouts.
> >
> > Assign the empty bufs the same completion tag for the packet to ensure
> > the cleaning routine iterates over all of the buffers associated with
> > the packet.
> >
> > Fixes: d9028db618a6 ("idpf: convert to libeth Tx buffer completion")
> > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Reviewed-by: Madhu chittim <madhu.chittim@intel.com>
>=20
> Thanks for the detailed description.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

