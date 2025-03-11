Return-Path: <netdev+bounces-173821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A98A5BDD1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A03F175FCE
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA681233145;
	Tue, 11 Mar 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtXe7Clr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6323099C;
	Tue, 11 Mar 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688741; cv=fail; b=e9D8X+LrkTu4EqQHOIHY58VNHhy07dR1rz2odvm41rRs/v/kWU8YVlfqginGDkeqhjt6eutTH+j6vd/sDe0YiVueG99VJzq9SISi3zrpJrBpmYdekgwDrGolc7LCwojwxCSdp9eRQKVYxHFW2WtAeGKa33RmJjRLFgUlWWEqN0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688741; c=relaxed/simple;
	bh=ofdIZnrUDqrOlKtFhhaVvuinY00vcKIpHYorxdeoHNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aXWFVsm+TBBclyR1I9c+S9vDueb31KaCBG/RkMPzOrCBgWNkkAyC0NJR7VtVKqYCgDmrDHUF231NPMdJj99KzOmKzh87EK4NH+2YsE1mPcKmCfShxF+CEKBjtZVDP/81OnCP3bgJF/BVDe3daRdbGPDU78k/GX1Vnebls3ydZEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtXe7Clr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741688740; x=1773224740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ofdIZnrUDqrOlKtFhhaVvuinY00vcKIpHYorxdeoHNg=;
  b=JtXe7Clr9kDCH3LRqLsoepUO8sKm3OikD5FJZCoiifwJ7b7hy6K9nlNn
   K532FYP3gRz0RpNQO1TmTZFf3IwoTD9YTJI9CDEb9GZfy7HEjpzrMntbZ
   4Ft7xHCwECxzOKo9SwfSN6cOD455bwKVZcr8Nzq/ZEEjPwL3xohoPy3t7
   Mc5NYdBLaY5Z2iSWeF4fvJsbPb6wW1jtoubUm4cZiZCPkfs5vHUTRZio8
   bWjiqIn6CRILOS7M1hJxlXN1k/jJ01Yg+lEAeHEIO5pGG7ZOZEUynAIzF
   VSH9yf3SsESlJtxsQsNbbFvXQE5EZ+XosXSguKVqCJ0sYhwrUXJATi6nN
   A==;
X-CSE-ConnectionGUID: lqyh85rpQfOe6cUGScu98w==
X-CSE-MsgGUID: vCvTgaaXS5SRJZ/LWeOSUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="45504411"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="45504411"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 03:25:39 -0700
X-CSE-ConnectionGUID: nBKAasKBSD+Bn+PGcoZRXg==
X-CSE-MsgGUID: xLgcQP0OTNSMQ9xEQjLEZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120005417"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 03:25:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 03:25:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 03:25:39 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 03:25:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOnqs0PwKRdz1dizLy6l8rV8Jdy3OBnOvjl4g6A3OpPIsBt+39YKtrvdnWPOqFF0eajzx54EYy4arnatAj7LbwPg56cuXD/nftxKNonZ0CjVap+tAUjSaab+l5kDySHlCK1aVsedEXNysTQpqjiSotZaPrSvgGQBMgw3gB0dwhvAFagyqay9VmVBgRHmoFIbMuUdlM/6bhE2ja07pmiWEa/F2nLUkzuyaxLrcEGEmXN0EAyTJbS8h5FPyINb1fiThBKfG3nrwHbIaEgIlVpme3DHrajW4xC7A1N0cUvMLSZYwnJGuHQkMPxbeY8+VnMDQ8zWoTqMEhzVkPXu5H8yCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofdIZnrUDqrOlKtFhhaVvuinY00vcKIpHYorxdeoHNg=;
 b=x1d/c36Ui8tDoiWppYxttlP7zvQ1HJhEVJ5z0AqXT6S7YbIhzB+Am5ghwtk8z2hgccUhqP2Fe2j76HzA3fcpnGt90o/bSAlKwwYJ8Acq3l17EUkx8Jn5F8zD9jPIIxVRmRma9VXwZVd0DjFME+lcX6q3OJSbVKRSLB6vpt4YOaUlfLkTwDrQVEpIAl4B3TYdKPIEl74YuNDYAu6kypWpzNt2Jy7wvojowlxqEOodRTQrtH/43vn+c+EP0nn7CzEXOuUdJqpTyg9lID12EJdHOvk/vuGmstc4KOr6dyFkETnxk8igdu0sfwzvShiw+hjutdNVf74SWykL7vbiSLr18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 10:25:15 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%6]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 10:25:15 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, "Pacuszka, MateuszX"
	<mateuszx.pacuszka@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 3/6] ice: receive LLDP on
 trusted VFs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 3/6] ice: receive LLDP on
 trusted VFs
Thread-Index: AQHbfsAmtwZCApXRsECCoPs+4EvX2rNQUi6AgB2QBbA=
Date: Tue, 11 Mar 2025 10:25:15 +0000
Message-ID: <SJ0PR11MB5865528358986FE6D21C67538FD12@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
 <20250214085215.2846063-4-larysa.zaremba@intel.com>
 <20250220145803.GA1615191@kernel.org>
In-Reply-To: <20250220145803.GA1615191@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|SA1PR11MB6807:EE_
x-ms-office365-filtering-correlation-id: da05c4b0-2fbe-4a6a-b327-08dd608703b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?azXn2/EeXkNASG5ZxUl9qKY40Hm/OkgXT2hlNdOiDP3rE2O3ehJrWRW/n9Qa?=
 =?us-ascii?Q?DYluKwsiQ48sNujzFDGI+u2TRNAG4BovzsJGeGyKa88HGb76pswU4v8mCVNT?=
 =?us-ascii?Q?kZAzqF4TkTZP5mIBYchY25DYIhzLFyWlMqHhwt6vZtFbk1V5SK29nEPRB0VE?=
 =?us-ascii?Q?S7w9/IEzZDNmhFtM5CyDKjqzhqvLc5y3EGPM6+Jn2OXXIm2+Ftp5CTSZaITy?=
 =?us-ascii?Q?aON7vvyqKJhH/H34vbHC356UEWogEJOTtPGZI2gNcoJURfWf4hyFEh8PakUi?=
 =?us-ascii?Q?DrZSmR4UyrB2uh0NK657fZy4LStYf04djpJWJCu9Pullj5kfGOYzhs42mfFN?=
 =?us-ascii?Q?TmLD7+Zq5j2XTqlP2r6x/mbcn4xMcGz4k0K7hXEKzJbjdn+fJmD2lnLDXHYb?=
 =?us-ascii?Q?Ae/8YKJaaPrOYJBfdAO7+BNlf31kwlhCR0LUmdTcE1k3SiDpxCY8ZI57vMcv?=
 =?us-ascii?Q?FlXq+nnpeGFqbLgoQgY2J5gmdUlLxN+i/di3AOTAR9lwLY9s/HlRbK2FUh3/?=
 =?us-ascii?Q?GtSapggAL7lJ4vQsB7GTT0T4g4aTvul4SwCpJRvOmlElYYTj3v4kVmsvYBk1?=
 =?us-ascii?Q?8t1IOeX/y2/DwiAWf5BVtcPpTKNKNkY4WIXCOMLo5XvzlAF1/9zPYlKKSkkE?=
 =?us-ascii?Q?ZnDrkI6temNqxbCbj/YAa13O+5zaKe0boqE2mI6gJeTY4UYA7B7wTuBEb2MO?=
 =?us-ascii?Q?/3IkLYGcggxKi22GgZPjs3s62G+XKC4Fpc5GovYcsc661pue53pw/OTpu+lf?=
 =?us-ascii?Q?5njs2TCjHQYYU9/uIsBnIhFQXYG36r7gYd+lQBujMkPeCjighMV/v2tfZtue?=
 =?us-ascii?Q?OAnDQgxHFC9E+A7ucIGeRgT0lfBCNHGjHbPL+oVYBbPf2abfNqVE6QUQ6TCw?=
 =?us-ascii?Q?83zWeEAsE4s7NXQDPPb4CFUVSwszVnycXSweZHYkDeL3vFhHhgjD9Nktp/X7?=
 =?us-ascii?Q?+98Mt4VOB9WEWqPZ8dB/RKJZwcsdBsbMauYmoxy8vdqQDI3tF2sbE8kuI5X5?=
 =?us-ascii?Q?GA0JmehGkmDNkoLHznnSqjlr3Ixdy9Mzjc6l1N09LDWcRltYGfSBHCFjIHCT?=
 =?us-ascii?Q?B9fIjAPHDrjonKyCNBhB9UJTpLytbACyE8teCv0i20Moxag7NDMKsggvXxBz?=
 =?us-ascii?Q?XfyLXaPa1PddsA3D9sbhT1n4X+MaiGxrtrPmf7AwmnZ7uyvAgPe8KiO8+wNx?=
 =?us-ascii?Q?hbw7TUfCs4jen2RyPM/qorZge40C5eNa71EpJP9Na6FjqJQjBYMYXaverQ6N?=
 =?us-ascii?Q?ToF60/ztY+NafsSPNT50n5zUpceLqgRanSvYaTrs30hytR4yFIfAKvOAxmgy?=
 =?us-ascii?Q?qKB/QALuciPqfhZD63ACsTgJCnborxsiY0nfmt1jzYeePcilhpt2UBar13yj?=
 =?us-ascii?Q?Ls8T2gdLPBNagcv5eK4Kg0SY3nJuch4MfB/tURaU9XUyFntnYzoYDoWNaBa2?=
 =?us-ascii?Q?gv8Q+44QzCfBCFxmn8e1ZSVXsgLlwpPS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n3qTKKBhFBDaZqEGznr+Yef6Y+Hqs1PDLobY03nzIMoub8VMAFvWcMkpRXpO?=
 =?us-ascii?Q?ARJ855qif05BFSVBVqAquUxRyxtK8wJRbaGJH17di4zZevQoUjvdsu2SCPJg?=
 =?us-ascii?Q?m4X1pPI+vL6bGxOswBzVfIB/rpqh0bhPDXhWC2IWx3Laer1WEoMT3KjCDdh3?=
 =?us-ascii?Q?8EthUBJejVMVg0YKvWWINN1fl6mOqKOVozbzCXpIE6k1rCUdic7rUXaMUZVq?=
 =?us-ascii?Q?ozkG98lizVeGApbT+xQosxq8gMcjSjoqtMF7rhkAAj7x9WOLch3sST3XuIC7?=
 =?us-ascii?Q?G5rkUXiQxF33ZZLv2poARtVJGi8Uu2LWVv4JWNeSYH37ClGtwEkZejNB6QHm?=
 =?us-ascii?Q?nzU/GbNabwRr58rNmyCZpFjM+zssouIrdsVVH7KKXkLGTufiQ9uHgi4M6zns?=
 =?us-ascii?Q?D80LWCsF8EUp+X0NQqE1xqbE85NVwMVGPJmlOCD1WyNMT6UdyEkNX3oVszTM?=
 =?us-ascii?Q?wbl04XMWHwBX6pm5lU0JCzGCRGMWnNu+eghx8Awb81z3SaCq0aUNVRj2IuhS?=
 =?us-ascii?Q?Muq4MW1n0S03Pw8H+gdUqEByogwCrkvUWHBzDzFxRnJG4JUg5g8VDMStPeq3?=
 =?us-ascii?Q?MxHR4uRM8HoNKcI/rrQc0CGkse26iFkSlTCSLBi3a48rTixrqUKMlkVcg918?=
 =?us-ascii?Q?mHT4VqGiKuiCygFY2z46v/XVzostQA6LdVPX6N91LXyos6gQkwa7O+f1sPUp?=
 =?us-ascii?Q?blKlf0GvfzGc9KYr7VAtEUFmY8xLyugHFVFGxAqwoG8jK3Ii88ZhG+8I0YLT?=
 =?us-ascii?Q?oXQMDKINHSSTlqZ81Nm1GQXghCiwF7f44APiq4aqEaC3SapSKIiRapEYZPy/?=
 =?us-ascii?Q?1QVMk60tG6xzKBFNq8pz0IvoCyM95hFWAq0XMmseCj5278vhJgjo85h8BJu2?=
 =?us-ascii?Q?dCGqpYiyfgw5aN5xlyz9w1pa4MnJGnJ8JAUjsNmF9cU8ESjLwKx8/qE3bJRE?=
 =?us-ascii?Q?ZpXxiLhlU4R1SnVoiSb4RyXdiSFxccg6bKfmGQmX3WPwqbdf15Q4zZft9M5W?=
 =?us-ascii?Q?u8+8Ton30kUcG+nB2vHTL4bGRpTFDzSWZBm54D8frsF8T1yZxpAhj7eqL+Qt?=
 =?us-ascii?Q?rerzjHuJ0W75RK5znsm3t3/UftrvQS2HpiU2T4X8Gh7eqL19bVJMZd4bW78F?=
 =?us-ascii?Q?hbKxgE/My1o+c/7agDGyX60jcXj3lp4U+j9SuOYa9OtAbmAxKQtYqlno36rm?=
 =?us-ascii?Q?5DhSdzmYUUSv4h8KG/JmBAoxe3C87BwqPc/l4G6rqE0yRJGMhHEhmRp9laPp?=
 =?us-ascii?Q?CSqYuAnsws8bbTxLRAWkLIqbwVBv5UESlT3ojPAHk4zQixplKrlnZt9dcdl3?=
 =?us-ascii?Q?XSrJINaobSr1bzNbamRQTnPjZtsQWLNLOX/UVrGLCGP8vWOfskSkdnp5Pprz?=
 =?us-ascii?Q?YLgv4jeX2zKn/72xmkRTQmfn/WBGsjtDkMnJaVWrtO5h13WKFNvs6Lm2kEiw?=
 =?us-ascii?Q?SNw4anjMfiZEsbvfdXFL1ahSvgNRtFh4QBp8WuE5nqLvt2G+GfPYuj3ZCGoS?=
 =?us-ascii?Q?UsNmda21j2RXrSqpPMyqRrwLw+161T54NSIdNGAX26gHS4dk/YWM2P5r9VAk?=
 =?us-ascii?Q?lTnTjAFwyaDrmGQ07FJZKnvpLM3ECnUmDgYQaUiBun4jgkUshd330Yrhq/Ug?=
 =?us-ascii?Q?EQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da05c4b0-2fbe-4a6a-b327-08dd608703b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 10:25:15.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Gr6qBjPuMg+Pf/jL4xyssTmGx7F/9280bCkoxHwEyH8Ada05SjYM4p/Qqnv6sI6PygwT/+gfW/niGMQwF9anHdAaj4EcTRUiHTB4/5HO/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Thursday, February 20, 2025 3:58 PM
> To: Zaremba, Larysa <larysa.zaremba@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan@lists.osuosl.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Pacuszka, MateuszX
> <mateuszx.pacuszka@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 3/6] ice: receive LLDP =
on
> trusted VFs
>=20
> On Fri, Feb 14, 2025 at 09:50:37AM +0100, Larysa Zaremba wrote:
> > From: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> >
> > When a trusted VF tries to configure an LLDP multicast address,
> > configure a rule that would mirror the traffic to this VF, untrusted
> > VFs are not allowed to receive LLDP at all, so the request to add LLDP
> > MAC address will always fail for them.
> >
> > Add a forwarding LLDP filter to a trusted VF when it tries to add an
> > LLDP multicast MAC address. The MAC address has to be added after
> > enabling trust (through restarting the LLDP service).
> >
> > Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> > Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



