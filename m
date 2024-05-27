Return-Path: <netdev+bounces-98191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F53F8D0185
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87682B28E1D
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 13:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E136C15EFA1;
	Mon, 27 May 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTEAllH8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4B15ECE0;
	Mon, 27 May 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816504; cv=fail; b=UlB2tDKohyddp/DuCrWPjuEU0l1qpUZxoHZwa6hKbFO/+VlTi0BbK0xg8mSUQpXK7aEti6gw7heGp8tb/FHktTBOjo3aABX+6ZAotmuz4sd+AdYm1oTcEvMgxtUYk2t2mWOwrfKmxI8xzrU7VnSTPg7WXGcmQewRgYYw1i+TvuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816504; c=relaxed/simple;
	bh=ue7zyTFeNiUlSG3HPAdX3Y6y5apfvXDEAcMlSd1mM7s=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YkxbItZ9Q6o888spvQuciaDxhaKOfVmC/HGD+Lcs7hTkIC4P5Zkj351HR+gRaITkfpE1OJ6DlfkxW+IovWafr3xClrwgz4EVTOlVMDd1+p47q6CdP+lt/T9i6qYrvLHvUvF4oWNWEKrcvnB0tR0oBRGNWgRVVUsAUz1Smgj1AWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTEAllH8; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816503; x=1748352503;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ue7zyTFeNiUlSG3HPAdX3Y6y5apfvXDEAcMlSd1mM7s=;
  b=WTEAllH8wF6JsscN0dJT7A5h7lTo1OsRkp8qLt5z+6rqqKf8g5Iq5k6E
   KBgP1SQMaVMrmbc7V9vRy7O8X1EO8JZ2J6gHBd5oEEFiSVlpHrKIadApF
   tu2w5UWlJISng7huIXzWs8eQc/6hqayABNlqk7W2pp0geUXC8tjbW1V8+
   lt8IUgV1cu9MY+i7/m2tYgOrsQQmwEfnhzmRxfqOxVM/TsyqqVGObP7/N
   4FiHKvjz11e/hXJ7/yHYVTuL9b4GZtJYdXL8j+OhbZv19XJLa4iv3zdnA
   lygXfZgIsnDJuvDG5XYM6lVGSJJ0MMhAvSBaAm55q+tef4/m+2sQisux9
   w==;
X-CSE-ConnectionGUID: 9nkt8qdTSYSNPc5Bd80u7Q==
X-CSE-MsgGUID: jg+EWFCBRWGsr6anCY3ptQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13360283"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13360283"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:28:22 -0700
X-CSE-ConnectionGUID: WsVYSnj/TpOtZigSCU/Gyw==
X-CSE-MsgGUID: +vora/6RSeGdUwM7uX3rhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39754178"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 06:28:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 06:28:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 06:28:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 06:28:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2toUSrG4X0oFbe4teSqNkcmsD0MkwPk2rY6vTaY0PGg0lrZ/aF6StWYLPczifynILP36oMxae2ge2Kre3HcAuHb1k28EvIOTi2IAksuiaWH1nAOA9E8TqPakb57Y+4UMrVKV7VMStsxOhF5Jxkv3A1O/M+tKStUUNrW9+k62wdK6OIrB3f88mug7ppcvMIgvGaqN2aSvtpbY2Xmdm/lYTJD5sZjzNrASkKZFfdn7tbHcBijLWxVKsOzmmoIa6lTFp5fudVFlqkKaBZfst15PhAoa53FHr2SSDTn/ifJdSfYZceKD6UOKXmsX7tnQtBMQKR0CxwhXgs74ckgW56xpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue7zyTFeNiUlSG3HPAdX3Y6y5apfvXDEAcMlSd1mM7s=;
 b=nSTDCzGL4yVmOM75i0Olp35jMSbbQXirqGq3h915rvA9qsz+or+VhfOyam8+GulS1FWEDx0OhdpIBasRlBtfL9yD1s4EKCmRQo8pbCoPGuWYvuhVe1zQf97a6wiP2BBeVZVW6YaAwlf4vEisMdJG0ESO1xLLcTTS9Y9+OY58IpWWo2vIBoPGw5CM/2S3dp7HAGOwOH0b1OeoKCaqAnFXVTsgT/xFYFy6ZG7i1P8r4LXrq1rVQ1Jsdb7qxUJ9vXNFL31xryCb0e9ALEP09c63hofaWvQI4tb16b2/XR6SluStiyv8AajgIBwjJ878xadPSqC4P7i2WRTZ4Q6Bj94oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CYYPR11MB8405.namprd11.prod.outlook.com (2603:10b6:930:c6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Mon, 27 May 2024 13:28:19 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 13:28:19 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ang, Tien Sung" <tien.sung.ang@intel.com>,
	"G Thomas, Rohan" <rohan.g.thomas@intel.com>, "Looi, Hong Aun"
	<hong.aun.looi@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>
Subject: RE: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature v2
 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature v2
 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHasBkLCj07Z540QUGXqLg1tlacPLGq5HwAgAAuTGA=
Date: Mon, 27 May 2024 13:28:19 +0000
Message-ID: <DM8PR11MB5751CE01703FFF7CB62DAF9BC1F02@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <BY3PR18MB47372537A64134BCE2A4F589C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB47372537A64134BCE2A4F589C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CYYPR11MB8405:EE_
x-ms-office365-filtering-correlation-id: 458cbba9-166a-4b54-eff6-08dc7e50df76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015|921011|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Vej2mcRIGDMH1FXpJ2ee2kvZYbWMfOVP0PTVMQvCz5mcs9ffHvqo3PuaVb6B?=
 =?us-ascii?Q?P3uF2QFDURNYjzibV/bRQUfWgI9CGvTA2Twlufa/IcbZbew6QOaE5uVCejZg?=
 =?us-ascii?Q?0d3xsCJrW5spq5WO67V8OdP2+d5DgmVPPKU9jfDryB668gOSKvW0g3WX9gv8?=
 =?us-ascii?Q?PuUuS9OOQnjKrKFKUDQr4X1FiblM6eCaxfx1VMyIn173hsq6KMiv7R9gAa4W?=
 =?us-ascii?Q?5Yem34yvKd+ml794NIsRsKdaGBCAtacIUXK703ACD1GGkJNJW/IBhnRzmEXV?=
 =?us-ascii?Q?eBmD6iFdV0B3wHcO6KTSxMgcBMwkJA/fZxeuMHJaxKKtM0C1ZKomnbodYbjB?=
 =?us-ascii?Q?QWRAArNDQIZw/EcnmyyAyqps9kGlkB+3IKNy3D/bxEHGT88F0WfQ60kiCuhX?=
 =?us-ascii?Q?AArq2VTc9bvjWbOQClHmPgb+QdMtS9CDp9x5cmP8W2h4BT1J8figr6/G3bYb?=
 =?us-ascii?Q?G/XElpeHmr3wmfwDhlHQsTPfqS4n23KsRdM1aUzt9mFQKeK3HrrM/c62W4qz?=
 =?us-ascii?Q?eyRj1BESvHgotdyR9egc3TAlYcFcoB7mX81j6U1K2ahpR22KyBfUUIyM97Qw?=
 =?us-ascii?Q?8xJR2c6UYogrpA616bSmsn4tpVm3BaTWFGUjCf8070ix0YjoloLjptsIEJw7?=
 =?us-ascii?Q?hM9RkpJYdDjHIQML4F/bLJTmgqdp4l/31d0mSP6It/nvPHIbBi8h2t9lQKPe?=
 =?us-ascii?Q?3iw9JvnnpMHjTkTUn8Pe4/6qn8R2EthVUZ7aHa/QJ08+cOXraS367MISdnJo?=
 =?us-ascii?Q?mrRDoTjbDoE0oi/vjNdxg+I6vhOipbEAxWYcmH/rg13CxJV7TyowVw7PkTM6?=
 =?us-ascii?Q?9ChIeC2JiXasn2lXsodAcmsp5sEKvR7N0yJAwGUR92aseG3u3h35MnzHIyEu?=
 =?us-ascii?Q?SHwYNzJ5FWhgLX0UekcXtDyRAeM9aLmlmgnzx2CUAvn8FwiJqw/rvuF9VWvD?=
 =?us-ascii?Q?aaDR4rgomX78AQXqJMCUiaYdkCvVcJZKDj3jbCSe3FnMdfE+jyvQqzK4zIE5?=
 =?us-ascii?Q?9HD5xYxIgsaEWXCjRpJ+OfMcM7KdQaQT35XhNptwBlPc1vx12L4K3pw8DLsC?=
 =?us-ascii?Q?MCr/v+2DVghhuen8eleutW6bs8JnB0WGZ36BwSLIfA1gJF8AboxvwxFzSUYc?=
 =?us-ascii?Q?56Vhl1hpNse9uCfGG1JG1RX96XAJi8IqAXWUUcOAPbXIInuki1w+HyI2SEZv?=
 =?us-ascii?Q?p8SMhDFBIOBn3HLDAXgF4mO+E0mVbzTYXBr32mdyUsuvlyAsxomF7mid5S4I?=
 =?us-ascii?Q?o11JdFba/1LXN5LvwM4fmU9+jldqSjg2U1xs5NQLfZnLmpFQ8v/Np2ri/DSH?=
 =?us-ascii?Q?SuyqDa8EzpIVkmG8yNkQXFfxKSelyLJGzl/IHTFq3uSPzw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T9LUWkjpchtfcAoRTJKjWmcrz6HsBSWpCm4v1UXbo9PnYoBasQpXBU4gMeOe?=
 =?us-ascii?Q?1z7CxU+LtA9Kqr7TCdndBIA4zDyi99kjVrRK7xp8XdtKOAXR4ztw70asIL4P?=
 =?us-ascii?Q?dcbAU+KcNM/Cz9+Nla1dtKvTSN1BHHuhr7tkLC4uqnp8BmYKWcCydQbVN6oC?=
 =?us-ascii?Q?1TJgfzCkOR41Si601pq19cJwe+A3BfTlmCtmV5jET7ltRJHTv8kfHaAMs/3w?=
 =?us-ascii?Q?aBBiGU4riOJRgAqM8Gohqxk9SvQBKFoFNfie/kWm2ScottEAH+sWAWv91eie?=
 =?us-ascii?Q?BB1Ilf16lk6lazCT8VbED7pXKTNLutvbkowJhevg5IN9pud0AnC/YbHr9fhK?=
 =?us-ascii?Q?icqoyVZritrPsq/mcNt8Im81tfJyjNv/Og6+DS+p+CoLYnGmT7bRpyJV4T9g?=
 =?us-ascii?Q?3l0cI9Dsc19L9udG0PwnJD4yQYMMM0XTQE8o32wtTasqSFPyW0SrFu7FrQHw?=
 =?us-ascii?Q?6dQlI/4K7nO3cPvFUv28qdtPlgHTCK9YBDMd5+kTIbCNXxb5kuECelWCw3pU?=
 =?us-ascii?Q?TrlryuJihd/Ww4GgKpRgd6L145aQQ6qMWpExqufe8Xzsu4+w7eMmeYq5qZTv?=
 =?us-ascii?Q?Dm4xhU5Oi28GqPCDNj331bPZ14+xEjmp+Caxgr1MeaHi64hqCwiHwjjFjeeK?=
 =?us-ascii?Q?FwZForjY1NrDQo08c2r3KxVUq7YIwcMAyBEjpSXOp6C6HVXC22G5mt2Qxfgx?=
 =?us-ascii?Q?hgwlzndoxv8s53b8TJhBrOAfrKS2h57axphR3E2GH4DhkvkZBlKhDxITQTeR?=
 =?us-ascii?Q?v6qVbD6gjXLBspH5/yAeJWQkpPAOzdlst3BGWO1mKx+HZs3qVX9Od33l0QM8?=
 =?us-ascii?Q?T1VfQKyWFHhHVWAks2Vvj++ADkq+ywotCXLpklRGdNaiBsczEzjaf+LTuTkX?=
 =?us-ascii?Q?EvXGxPsRRWe0lBfCcwydqbv3Kgrd0xp/0/fdileNpZ0Cj057M28wKo9JoKmI?=
 =?us-ascii?Q?ORMY30nLvgRNt4ucb5kid3LRKf9FdbR4zilW0JMPTnbmgI2qOhXxdkgWQ0RJ?=
 =?us-ascii?Q?Y6MWhMzt89a3vKJ+0ZiQHQW2j7b5Es/FNxzqG6+Ud/teS43fGtNxIrT6Q6JQ?=
 =?us-ascii?Q?eiSiqI/JeAGKqtcvQEd1VCQJo0kFipDdvYnDUce/MtIigOLy4eXt4ZiWBgef?=
 =?us-ascii?Q?8gOTXFIoHJgoWrBpUTsrn6z34CzmqmmCfIUTyPnHv9b1tObyLiz9PA0DvMIN?=
 =?us-ascii?Q?lXwUuyxrY1/hi3UA9mlAhsgPVFHIX3v0sZkbVrK9Zy/hX/+d07dxxM68vZbx?=
 =?us-ascii?Q?cU+sxWC9NjsYl7echgjcfEcszeSC86tgRrZGwQg/7skCNKTvLHMBZBfbqmNS?=
 =?us-ascii?Q?pOOVFWJpltiIzkvSpZQTa3dXXaWnlkyJnIE7L228sx9kdh/Gitp6w/Q3ohZ5?=
 =?us-ascii?Q?Pl5gWVcSOpGUF7W2aUM3LcxhtF6hzoRRexKmNs8TgtYu868y4tvaUR0PVbyL?=
 =?us-ascii?Q?TlZBDZ5YxtY2Qex5cJaqBAqvx9L19B7hT4/1ZMyaV+fT9LU766hxFYO+Iw+w?=
 =?us-ascii?Q?bgJl3YjpKqLzN4NGPBZykaCAkLkKb6Hq6LlNKdNYB1alg7476pN+BrJP5Nbh?=
 =?us-ascii?Q?lWShZZirtllYUiZLQCxEgX0N83cq+4dkx6RYh3X8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458cbba9-166a-4b54-eff6-08dc7e50df76
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 13:28:19.1183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SA2WbYtt2bi5PLlsjvvr9agQjyO9UGGJnfHkbgFmRGMrf4HsAOjcri/EzFdc/hwQbPW9NsGm4DJSpzEQ442v3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8405
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Sent: Monday, May 27, 2024 6:41 PM
> To: Ng, Boon Khai <boon.khai.ng@intel.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Ang,
> Tien Sung <tien.sung.ang@intel.com>; G Thomas, Rohan
> <rohan.g.thomas@intel.com>; Looi, Hong Aun <hong.aun.looi@intel.com>;
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> <ilpo.jarvinen@linux.intel.com>
> Subject: RE: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature
> v2 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> Stripping
>=20
>=20
>=20
> > -----Original Message-----
> > From: Boon Khai Ng <boon.khai.ng@intel.com>
> > Sent: Monday, May 27, 2024 3:04 PM
> > To: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu
> > <joabreu@synopsys.com>; David S . Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo
> > Abeni <pabeni@redhat.com>; Maxime Coquelin
> > <mcoquelin.stm32@gmail.com>; netdev@vger.kernel.org; linux-
> stm32@st-
> > md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> > linux- kernel@vger.kernel.org; Tien Sung Ang
> > <tien.sung.ang@intel.com>; G Thomas Rohan
> <rohan.g.thomas@intel.com>;
> > Looi Hong Aun <hong.aun.looi@intel.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> > <ilpo.jarvinen@linux.intel.com>
> > Cc: Boon Khai Ng <boon.khai.ng@intel.com>
> > Subject: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping Feature
> v2
> > 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> > Stripping
> >
>=20
> New features should be submitted against 'net-next' instead of 'net'.

Hi Sunil, I was cloning the repo from net-next, but how to choose the desti=
nation as 'net-next'?

> Also 'net-next' is currently closed.

I see, may I know when the next opening period is? Thanks

>=20
> Thanks,
> Sunil.

Regards,=20
Boon Khai

