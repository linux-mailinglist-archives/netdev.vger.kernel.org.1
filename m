Return-Path: <netdev+bounces-198190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E1DADB8CE
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2854218902C2
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D75C289372;
	Mon, 16 Jun 2025 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWVZDhPK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E818286884
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750098353; cv=fail; b=VQ/m7jRrZH8Qz893Lg/+TFhYzN4HmJGFUjtdHKn0fc5NFtKIl/5KuxXVTMzY05LBMFwSS3LNAivqsKc0c4JQ5TVu0VxRUy9NDc9/73pPArdvJuavOI016l8pl5+MF64UMiGNH5wu1/wsPfL2UBAGOounWQ0gBML7MrAhFgPpSE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750098353; c=relaxed/simple;
	bh=FAqEFKA9VGCHmCoVFLvvo3rv/FPOH0KV/zTbqfBEzuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+6cVodw7C/GkmC0JQfp8FKFGg5GpIeGSEl1Kj9vxBq1TbAiwL7wlvB5vU8pZXbq4BUHSoXhH+XM/RyNLXo8HY+/1SJOHlTPoQk4AEReewqEvfYfIo+colYdgVEcMh8GJhm5d53i6tP69VVtYl7GWpjbsm3g4aGh5ruz77rqSJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWVZDhPK; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750098351; x=1781634351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FAqEFKA9VGCHmCoVFLvvo3rv/FPOH0KV/zTbqfBEzuI=;
  b=hWVZDhPKXV2eF/ziLY7VwvE5+lcoFMSO5sXvGVh0KApW1WeEcN6Dkv6J
   CPrUYUGlMGLrukHQPzPIj2aRX6ldOKpaIETomPDVj92yQpq8iwUjmyi8O
   npZ+QPxCCjKdHBJ237erzICyEHfm+5tJDP1wNV1i8Ou454GL71QTPhYgq
   aAAsH1K0BtcU5NyrM24QvSej3IZWiKPyQ+oldU1pu4X9Y6aRl3Ks2hjE5
   kwLgwqGZJAEPlL5nvGRIxoepdZOVgRE5rPQJKKuiD9IFWUV/7fEqIWE7y
   aJdh1KBntXjMPaGb55HcSY2EvxNyj2xntU1H72ATadhoxEzLKjrVIkhpL
   A==;
X-CSE-ConnectionGUID: T6cthMnCRMy8s21y/NN4Mw==
X-CSE-MsgGUID: 6oycjrTQSv6R/jUt7oE19w==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62859388"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="62859388"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 11:25:51 -0700
X-CSE-ConnectionGUID: oLJqa84ZSTK1aalqLV6TgA==
X-CSE-MsgGUID: j02SMKqjSEG7aKf74SomFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="149416011"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 11:25:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 11:25:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 11:25:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 11:25:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCAIkhtneB5p5i+5jze/sG15yHEU71EpHmc+cciPELh8mtvblSoHHtikZT/jIJ43V0pjTiXVPec221gtoUFOx/zqeQe+AmdbrXvNtYHG3hPJRhbzxh+wqbc8S8yH01pvejo9V7Kbli7KmHdCvCU6PEqinwGg4Wm0orFScLgE2XkKi98dOAApdVpFzZNkko30NSmc28OKvwYGPruCYh4xrGez301Ooq0yGh8MUyhGbaw7toJAbgFdnv65GLxp/G88IkOSvlypmnWs3/58aUzplbAQJtjMTkhCpZvwBiYwb4+o3+TlKqjlkaWrc2k368cIrFA6GElE5jf58ke4p3Ma/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/84t9RLoZ0hSgNw+zYoaaP+m0fs16y9BlIDoNQQoO94=;
 b=nYPDg9VSnIUrVbCEOEDwY6g3KRZMKFfq4LdRHFdAzCQSorQXwXAQpvNtT+m4xl5k3fMVXEsqpDB7MX2oYSDAw3dmO2hmK16rv1yBFODnGpxHRX0cgXEh06rBShSHxagI4/aYRVgfA8jynjmOqhL4Cw6USGDgpeDNJOtkER83jfITR1JEVWIF+Ig+Pf7kOxXGNhpOX7I0afERGwROnB5MJklPHr9/XJIWg85tGwUQYDztz4eFG+tDoUn3YSDt5d68wdbghIFSluj+z2JmWnHt65hRbyhffX0L6jMnfXJ4YOwAcaR5N1u96Dk+TvPfo7bchHnNtsIkhVQ7sSIYQW+f/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ5PPF12B0A4A9B.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::811) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 16 Jun
 2025 18:25:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 18:25:31 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "joe@dama.to" <joe@dama.to>
Subject: RE: [PATCH net-next v2 0/7] eth: intel: migrate to new RXFH callbacks
Thread-Topic: [PATCH net-next v2 0/7] eth: intel: migrate to new RXFH
 callbacks
Thread-Index: AQHb3Vd0fbf/eYwhpkCidI90sNB6srQGHUzA
Date: Mon, 16 Jun 2025 18:25:31 +0000
Message-ID: <CO1PR11MB50898761E6EE25D237C2227BD670A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250614180907.4167714-1-kuba@kernel.org>
In-Reply-To: <20250614180907.4167714-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SJ5PPF12B0A4A9B:EE_
x-ms-office365-filtering-correlation-id: ca44867c-569a-4099-8af4-08ddad032d8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?HWiwIX/zGgNPsY5AoKJpyTitkSfIg0fsISwIFtWsMns/iBQ0JAayQKNZZkCx?=
 =?us-ascii?Q?xXuc9TkAXGuQpopfmwf5RG0mJd1CC/lOsHfsj3LY92wynq2GJcnjzY3LFtkS?=
 =?us-ascii?Q?zsuS5gk/lPa9OP6gtmTn+OyW9Vpn7CRkqE1NtIN1xu+m+be6jqS7zv1qgtQc?=
 =?us-ascii?Q?OTZ25HOiYPXyfngh3PYSzJ9RWVwFl2nGqYNVv89WOdxiIeDgezs0c98xHrvL?=
 =?us-ascii?Q?tfb3LKgrcvKs3XkOTg0SK6i27PG85946mvxs6J5N6HHn7IO9OGwv0q+fZUfT?=
 =?us-ascii?Q?nH4f1/ZwwVCNGdWSgJVPV+JdhBWTXADBERAU+TOyT21Vj5oDRWP3GK8oUxrw?=
 =?us-ascii?Q?e8GIt2xzk9vbjVFrJYhVIm39KDQsRVEbD2T9etPWx4nG30szuBqOavbLuQty?=
 =?us-ascii?Q?X175Wkn7gWxdK3ZT456e+GjGZ+qnxuaKU89rMPAhcDb6mI5wxPAtR/jQCkWS?=
 =?us-ascii?Q?08HaePyLxhE4N2iHf/TzT7X/VqKTJdO0RKhTrMUWA2EsAVtFvXm7cZio5A5t?=
 =?us-ascii?Q?AzjMoQ6gxFVTeaRBN1VyYKAbmuDQzllXSRK2ekV4AQVKLAcdH62vhuTlq+sm?=
 =?us-ascii?Q?iAziwincVWY1D3yeE0YovaRzAnMRG5EYFB81fMz54tR3bxhhm6QLyHhOMexX?=
 =?us-ascii?Q?s0eStOHDUtq/d1IPaLEF4tfI/DObGBJ5gP5SoBgKthl/tGjrcBig+fpkTaJp?=
 =?us-ascii?Q?mMghAt+SjNpZ3Z6DN0JP9EfY3uetfFEnZHG7+eqYfv4KRrs0trHERoaQEUdW?=
 =?us-ascii?Q?YDYaTx2hnroJ12uM158Wd5XdPHzGQOUUcYwtqn9TtorjYt0UFugBEglXiQ8K?=
 =?us-ascii?Q?Rh+uhv6D7CmbVCCNSLAliNeF9mxv/THJSsPnlq+JLhu2IQcYnOJW4F0+Gnv6?=
 =?us-ascii?Q?/9pftf47AP9esj5PnLoLlKIdzW+sS7unuj1uzZuAX20giP3WDTvit213Cb6Y?=
 =?us-ascii?Q?zRsBoTZXIFKoD58T1SIAeM2guuYQJRgtG/RlUMF9F2SPZWWlU81Sazeilx0g?=
 =?us-ascii?Q?2ews5DZHXLXCBeONfMwtEf0p28HSI0jeb7TO94q0j00Wb6QENCRtz1AjoaHs?=
 =?us-ascii?Q?67DmljksgJpWuYBWvAQKBl/qQ4Smsj8K6bFXmxc0RF24hlKwSB/CUFvSR2bt?=
 =?us-ascii?Q?tIaxnRQUizsw9UNNKHyAhZLSjHgPlLn9u7XQbeXnskUYhWN9H9DF6VI3KalY?=
 =?us-ascii?Q?GR55iy0U1sen3vv9SFxKRD8/ew7331rRaNOBgQXZoIdCfh4s8Ih7CY4EfCPY?=
 =?us-ascii?Q?rCxkIJGIenL4YwHoBvuEbVgTC+Xji3DwIAEV6d6T23HCZd325mYlzD/ZMT6A?=
 =?us-ascii?Q?X0pUvNjqBFTeLOpFKlyUK7ghugvdnVl8WjA0DICzBN4s5utHSqeGu/N6yaYl?=
 =?us-ascii?Q?UvHeB0aP97wTrz7HH08MlLgN4si1XkjJV4iKrmZq64zNSs12OnlK7RgQeINT?=
 =?us-ascii?Q?r3PmpnJAfzaiXArUb1a9MC1ksN66Sccov1QtlvyMigiABiBtyPKI6ratxXj2?=
 =?us-ascii?Q?X5x8Gyo2sYB6xu0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dd/iE5obaStwFlwxko9yl9y234QTfGstZ3ioGPb/wShx5mDkASyZEtLNdHQN?=
 =?us-ascii?Q?MYaD1DML1QAv8UiNyVdSd/NE50cAjUbcbDiDqn/NbYQjxdoPIocqmmy0ZUbo?=
 =?us-ascii?Q?OBIIriMC2LdjYPWypS+njQCAZpwPe7Vg1Uxa9mEpFY106zoBbTSWRHsb17cz?=
 =?us-ascii?Q?qpzcsupzYBAGOFznG+myH9jhTovlvRCrCPY1ecQPIYK1Jqt7tA8oEglOMlkR?=
 =?us-ascii?Q?aLRHD4iPK+8efJ1S/WdQ4fVyotlDotTGcbkYm7pyv/qINI78nbIL7HL1Aab7?=
 =?us-ascii?Q?xt3aFG9IS+fh8AEHkMI5/aYj9cQxWC1AqfEZ6ftiCpGt9ZnZKiWkEtL4Kkjg?=
 =?us-ascii?Q?BEmAi6WN6duAjm/9h6snsQxFbJ9oCu36+nVZZoFiXgHfWz5gpaIMvWqEGcCk?=
 =?us-ascii?Q?SRiLZsNUdXvSruRVwev7Ex8vDbQ589DkaiIT2C87l7QxhdTHqRcXUSzs/9IP?=
 =?us-ascii?Q?ShnZND1G8MpuinAKcnyDomGjO9PQr+wUxy6xLk8Qu0HSGCAy6+6GM1TIRaZh?=
 =?us-ascii?Q?LXCMvc5nO41Cjm0KId1jG9WPzqO7cObEcuSQOUzPCR7qV4PR+zordavdtqaL?=
 =?us-ascii?Q?yu+kFbWy0K5EKZ7vUN+ikaeod4TSC56cVN3hFVDm5DlGNn39DV7idkgsrmG6?=
 =?us-ascii?Q?c48sm9prSmAneFP5kw1c1s0nG4xxTvC1AlCKxT3P7mRFQI18cH3GqLszU32M?=
 =?us-ascii?Q?+3DICRs9jdkfysAZ5dM2LJFbsxckISUxQD/BFU6Juu+oZWOnwmtkhDaR0r8+?=
 =?us-ascii?Q?jMaceIRS+0GWzUeoU8XZTLNs+ycGe18fiL2stV1/VWLxDomsulp7oDp/ip5f?=
 =?us-ascii?Q?iPi+Nr/5Lt5xVl9OZ+ekuEcSh+N3qgayWZF2+OGNO248Ym88wZZUw1HcSar7?=
 =?us-ascii?Q?BC9XIz3xaQMI8Lw2hILSUhir4TUxFtYAsf/CT/yhG2ptX0+PlehZo7s8RcF5?=
 =?us-ascii?Q?P+Cr7wn1/qSljJk+/jKv2pQZ1xldffvi7JeYi+uURwVS2iL2FOB1pRF9jsT4?=
 =?us-ascii?Q?KhdNWF5JpbeA+hrOqyHgsdU/pxDGTF/zlThviRJZsb+erb8NTxmCY/gvLR6b?=
 =?us-ascii?Q?vp4uhUObf6+1QWY4DmzyJq7JmcAnUlGi55uF7f0hf5mLof5QCgRNL1nWj/Ry?=
 =?us-ascii?Q?cTKSKKGAJWo6ePTGKy7ikwYVKhdR7FtDSpxydsoxRsNOPULb2r2MmrP6izxt?=
 =?us-ascii?Q?aakmvlMP8uLt/RgLJrgDXsPaeCd6KSAEBAVbYkZc5ZTrMHkZO1EIjZpV7QXx?=
 =?us-ascii?Q?CDTGPk3w5j3rfaU05GKR3z0nyYbQPhftukQqyVIrjIzEyzAxVsB6XK/Mpjea?=
 =?us-ascii?Q?H0LArYYkCLclaq7QbYbGqfw/RcAK2sAd4/eAm99Z5KdAd8DTAQncUkmlbRbE?=
 =?us-ascii?Q?X71ET7VnKUPYPVc6xzV04IaSW3n1YkxWPs2LL4qa9+5RWIlHssbl0YWiMag0?=
 =?us-ascii?Q?ecGli78eVOlzJYO/u19vW44PHC/3PqqJSFm1o4/ibN2uv0zG2Wik1AyD/wAy?=
 =?us-ascii?Q?Ild+RunfIaFNrUE9rBCG/Kr+rq/Nk+GXy2cEuZQSyzQOmSbQKUhE2114z+/b?=
 =?us-ascii?Q?atyG2z3EEXGuwkltWd/KtyHbz43xJKHBpsRNrgiS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca44867c-569a-4099-8af4-08ddad032d8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 18:25:31.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGSxd+LjU4VINQSEHdaWxk6muLrsCC2h06PavGyKacSC/PTrrErfN8xSsVryvaMwG299VxTU2VDpFEC6rscQXaQ9LKRnieysYsD1n7BNkDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF12B0A4A9B
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, June 14, 2025 11:09 AM
> To: davem@davemloft.net
> Cc: netdev@vger.kernel.org; edumazet@google.com; pabeni@redhat.com;
> andrew+netdev@lunn.ch; horms@kernel.org; intel-wired-lan@lists.osuosl.org=
;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com=
>;
> michal.swiatkowski@linux.intel.com; joe@dama.to; Jakub Kicinski
> <kuba@kernel.org>
> Subject: [PATCH net-next v2 0/7] eth: intel: migrate to new RXFH callback=
s
>=20
> Migrate Intel drivers to the recently added dedicated .get_rxfh_fields
> and .set_rxfh_fields ethtool callbacks.
>=20
> Note that I'm deleting all the boilerplate kdoc from the affected
> functions in the more recent drivers. If the maintainers feel strongly
> I can respin and add it back, but it really feels useless and undue
> burden for refactoring. No other vendor does this.
>=20
> v2:
>  - fix missing change to ops struct in ixgbe
> v1: https://lore.kernel.org/20250613010111.3548291-1-kuba@kernel.org
>=20
> Jakub Kicinski (7):
>   eth: igb: migrate to new RXFH callbacks
>   eth: igc: migrate to new RXFH callbacks
>   eth: ixgbe: migrate to new RXFH callbacks
>   eth: fm10k: migrate to new RXFH callbacks
>   eth: i40e: migrate to new RXFH callbacks
>   eth: ice: migrate to new RXFH callbacks
>   eth: iavf: migrate to new RXFH callbacks
>=20

The whole series looks fine to me, thanks for doing this cleanup!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 34 ++++-------
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 38 +++++-------
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 52 ++++------------
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 59 ++++++-------------
>  drivers/net/ethernet/intel/igb/igb_ethtool.c  | 20 +++----
>  drivers/net/ethernet/intel/igc/igc_ethtool.c  | 18 +++---
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 22 +++----
>  7 files changed, 85 insertions(+), 158 deletions(-)
>=20
> --
> 2.49.0


