Return-Path: <netdev+bounces-156389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBBAA06407
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BB53A6C15
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09A1F4E32;
	Wed,  8 Jan 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3sQfZUY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1315853B
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359808; cv=fail; b=YqvcewueqYhQqd4A55eSUoexr0CwefY+qyjDFu8uJ0cm7gEWtfjCUto1DHcMn3iWoKEh67VxODaYOvIWiZTUxA+97eb3bqeXjiEgaX78T1aLPkTmN4/nendUEqgO2TioBgtH5lTOsh+9LqpCAy2RVnULLk4iYqiOsby+av+Qgm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359808; c=relaxed/simple;
	bh=f0TK+65Ixhy+fYHpsYPH4ISnsed+8uar79xN/ADmgoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aSYxqDZBf0eRRurh+/XOb2JCPzO2pJXkWQl8BTVBzn11h0T6qsep1ti2a/JNS4xngXQugV9cXi//34/sItBlNlZBpxa6IW3Jc5uEaeMQmbKpX6PnNav70lNO79SduBV03KfGdMVpQKbxkC35Jeremfomr3slLHAgZ6DlKJA4nbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3sQfZUY; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736359806; x=1767895806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f0TK+65Ixhy+fYHpsYPH4ISnsed+8uar79xN/ADmgoU=;
  b=O3sQfZUYhfHtBPSssnHE+7KTAynHsT54HEG4pxBXL/hRQHeBJdhgZHGJ
   qiYuPKiI/b7ZHEA6kEB56Hzen5LsQ1PadDQANNtG4BNEEyGojyO2oWl8c
   0p3N34WBwAxgtcv4q8ozJAUU5Ul7UIE/R4cwpYb3ROKiEEryCLhZ/GqYa
   c80Cqnh5mpgB79Q8q44p6Cae6cHJx5rR5odYAZ/5tk/jkBb7jXtMVdrZa
   fdaoyiBRkLS4lQqGv7lXuOjI6hUR/cxMs5TWZKtwmuFqNu6m6g/wTxW9X
   ThMREQt0XE69Za/oBHGFGXj8qgIEvsalytk6gr5Z2ueAeK3ccu+GuekoP
   Q==;
X-CSE-ConnectionGUID: FMOMiINySdqp8WgbF1Y4Wg==
X-CSE-MsgGUID: k/vthbLGTeyg3Kb/Yu4Xgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="47956530"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="47956530"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 10:10:04 -0800
X-CSE-ConnectionGUID: /2WEqpVxQuGIRRj0W0Jj6w==
X-CSE-MsgGUID: UVp/SjjwTrSpRD5JCi7ERg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="108221787"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 10:10:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 10:09:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 10:09:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 10:09:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ON8IGJi8EU3DgSYPz4cDqQZ3do2ARF4v2kBR/3G6aVPUhlz5krlAc7EnAe30mprKzyYq/n6oMtrpN2S9VTofGZP1oIfh9qka6b/YrfXGYKyzTuf3rHO40/oNUTES7uXRVsFouRmaAwiVuH5ajxZteEoKKeYJyDl0YBgnx01EsMMGdk+8H6oDOoD5Ka5SKOAJPq2UUY7JMPj9DeNxWKySksa6nu2Qc4eYtHeZ+Mgt6wM7dZgRqu6IEOVckbWVdfrvN0aZh8FxsVed2WyqN6cw+qnr6NLp2U9HbneCtwmhZutSZtylVRuYyQ2wC9fsNC71z6B/xrK0m4V46t1dOvbtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui9Fms1bLbP1lEVahnaRigmFOa3asjz3U885Kz942Ko=;
 b=l9A5UqEO74BhGm3qUcM31mbWQy+GBFr3N8s5fhZhO6HEsrdkp5d2rCQz4lf/3bO2ft3BTQkAHtejjxBFFcdks+wDYteHEPpnaD93J7A+ZH8nOBMsYLFiUaR/XTn1TUrjUkjD8VKBj/OCguP+XL8IZp47aVpM7VkhhdEvJsghdq75uhQmGYU8uA/2nm8aBwMyux6oU+bG1vMHzK+h9d4nN1C4mzpgI5IsLrHKce3KNbQKqIj052DGAiYGwtZme4Dzns3IVLy1qWRz7EVGsfOqRMPKrz86bAzFDeYJJH8Edf/1wL9W46PmtC9pxSZ7APF1mAnSrXsE8VQF5ueu5C7cWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8139.namprd11.prod.outlook.com (2603:10b6:610:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 18:09:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 18:09:30 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, 'Richard Cochran'
	<richardcochran@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>, 'linglingzhang'
	<linglingzhang@net-swift.com>
Subject: RE: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of
 ptp_clock_info
Thread-Topic: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work of
 ptp_clock_info
Thread-Index: AQHbYBScY5vYzjLaEE6Lwoq9cluMmLMJ27UAgABpgDCAAI01AIABNhxwgAAn/4CAAP8FIA==
Date: Wed, 8 Jan 2025 18:09:30 +0000
Message-ID: <CO1PR11MB5089D3D27BEE4206AB772E04D6122@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com>
 <20250106084506.2042912-4-jiawenwu@trustnetic.com>
 <Z3vzwiMzYDvmKisj@hoboy.vegasvil.org>
 <CO1PR11MB5089788E11ECC1F9F704CEA7D6102@CO1PR11MB5089.namprd11.prod.outlook.com>
 <035701db60c9$4a2c1ea0$de845be0$@trustnetic.com>
 <CO1PR11MB5089A5A5ED6C76AA479BE1F4D6122@CO1PR11MB5089.namprd11.prod.outlook.com>
 <03ce01db6178$581f2ed0$085d8c70$@trustnetic.com>
In-Reply-To: <03ce01db6178$581f2ed0$085d8c70$@trustnetic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|CH3PR11MB8139:EE_
x-ms-office365-filtering-correlation-id: ebdc5bb5-8237-4456-cc61-08dd300f9920
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4kSTFUQ52Em5crStI8z/4pTV4UuMgAMY9H1Kl+DRiAsBAoBGQkZYl4b9rpBB?=
 =?us-ascii?Q?Tk+hd0oCXOBiWfosJtSlRA+Zs0x09QJ1KpsP3NHkEPzYu+AO6D70gFIGU6m4?=
 =?us-ascii?Q?8Xx9dMJaQuHowU6B8frKkJYeHTt8wrvI1Zh/80lqL0QFS1RH8sY+6lKxsr3h?=
 =?us-ascii?Q?Afvu/ZcC8IE+kZpZ5befrlnFgHfHqijn+OvxVwWX5luhW30vyMI/SxGynlEs?=
 =?us-ascii?Q?l8wUruWZ55O/bwYdV4J2IGwRMtT8esTaozKr1Sp3aOY7TwyYFKv79x8ClWQH?=
 =?us-ascii?Q?VYZZrSoVFl61KrOGt8dhJBvUjVuskrpotUOdQGKWnZ74rgtw2DLJj9YuV5+i?=
 =?us-ascii?Q?uOOxSjOTsxir8yMvy4Iu9HCXiY4l/Io2/YnQV/i39gnTTDCHPR6m44Ua6O+R?=
 =?us-ascii?Q?amjmAfV0qD9C91ac4WHpTGpsCD8ShFlMf7eYSGw187AA8FI8isznH2YU++mr?=
 =?us-ascii?Q?QUZRDbABOvDf+Pbk1ZezvIwjPECUKoVJj21otgvrReVGF75xlPBGv8p/yFwa?=
 =?us-ascii?Q?cboeBO6PT/YsEBQfocqHeVDCRQyQVrBJeOD2gszPte2xCbw7OQRMBAw/Os8B?=
 =?us-ascii?Q?GXa0tXsEhjwYsSKqMFcAmU4O5EojvmFNTeWY6PQgkiVHnz3LvzYSKY9kzLwc?=
 =?us-ascii?Q?vPe6AnyH14D8ankmYbyNoX/uqgKIr3Wj5N9JS2SFcVXjnb00/JwOoD1QvyRv?=
 =?us-ascii?Q?18s5DTPcmf+LqAAtbt4CgYfWjgQX9ppxTFPjuBXK6eE4VVvM71Gq6MaAY5V4?=
 =?us-ascii?Q?8CTwTMy23YEVjfHaqwl+g1/RvzY5/YOhdbCqjBPyecZxKS8cYEyMQoSSRCjA?=
 =?us-ascii?Q?9hvmfg5wYZ4ul9UDUi3au4NTC30c0Cs9BxJGCZWpeowzFB5vqcApqiGkMurL?=
 =?us-ascii?Q?wttTJoII0GKOglLGY6LWfAWG6m5v2rEU5W5omzEbctRgAlM1k160SopERp2I?=
 =?us-ascii?Q?8kMZVdCb7GSQ0sx3wmGkl8CSwjcMZn9fMMY/jn46swRkMv0QyqWjOtGyKrIT?=
 =?us-ascii?Q?TyKHW6EUDFELrj/TRMPw3muswr+ucooboRbTFDuaE6nqaUtGxePDR1jHCs+O?=
 =?us-ascii?Q?+9LfgDo3hmpe+8X178At5w66aXxntJgB3U9Y54ss75+mvKxO9+NRZLOkC5v0?=
 =?us-ascii?Q?H5ZH+zZy1ZVQSCTLmXaeXHJNQQfKXGKKbUq50vG6tA4GKtOVBZPhNJND/SM7?=
 =?us-ascii?Q?X3w7pGpFnPX7+Ij5iOw2k3fvJOUvvMvUob9044IhGqN3PfwGh7ceWt8qV++V?=
 =?us-ascii?Q?rGKTTZAncCVgH06CKOcPFEOOBOwuaU8/9KaVL9DGTwihck47nhBYixuzRoW7?=
 =?us-ascii?Q?gRXuPDNeJFJa2jVakBJIQfvX1JURuZSaRhfkQlgFuwrVp7/yl4ep07Tgg6bt?=
 =?us-ascii?Q?4eIixwuUhDrzQTB8up+x+KCE38JJNnzZ2c2/O5F8/jCT+V/SPs/ufLQ2m3fg?=
 =?us-ascii?Q?RqXVACXKSRu0aNZ+XuS6WIlvXez4DNkr?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ODtv5ncBcblxXAgZVct13A82YPgJeDznvMeHjSyDrujq925ZuNaSlqVRMAlh?=
 =?us-ascii?Q?v7E7ZUVYcjhJLzGkQlRu4UEQPA2RzePFKrNEJZhmF5lk3jet3npFlydXhXgR?=
 =?us-ascii?Q?ymAsGC9SqK2WAHAEi2PzmYwgyACG4sSoud75eVjkMtYuHZQ+BzEHSE7WypiK?=
 =?us-ascii?Q?sFDDYun6lQ71EvxYynjYdYI8RxdnJj5cHRhyFoBUA4phnasgJbxAsVM+znKe?=
 =?us-ascii?Q?Xi/wcXzVIpnnzZthxn16EuMPMviStoJgBHJPZoF+LWW6quIedPRqMIvut2tU?=
 =?us-ascii?Q?H0MSnEZid62bCV4D+/BKe2yOYUoTzdy/hGHYbwVCnShVrzH1RrYqHp4gw8pI?=
 =?us-ascii?Q?uGZw6bkcJKdYkJ7k8OqtPyG5tKvzWNk2QAJXjKfSjcdiugwLBl/cGKm5iT7s?=
 =?us-ascii?Q?4aTU1uM/rr0FrN8IvqZqNniO7NJ4VJpbd6bCYCYdvBJ6qX2A2JFBeFubHdPm?=
 =?us-ascii?Q?Ch9hnHIHvyws1YQgW8G2HAO371lcoOjXk3GVLrhKMZqTCxsTaurWE1prvrGD?=
 =?us-ascii?Q?tkpNfuBGHfIn274fV71vIdTatCxrenmuNRYUA6DTaX+NAUfWwNZkZKyZwXRp?=
 =?us-ascii?Q?5NnrfSHr3g2q/cXL4wEpjT0yLAVbkca5chxdLWhGV0YO6Dpx3Vpo2kV+vc0e?=
 =?us-ascii?Q?DrpDvB/ii15eBg8bcgsLCa9GXWOVA701VYl9BBQEnchlK3EXIW+jcgZ26JcX?=
 =?us-ascii?Q?gidx4bbhe6CYKN865wbEPEdsNsoBFDvHsPLCxS+cvN75YsCeu6STAI6PJA/V?=
 =?us-ascii?Q?5nkyTx+1IbWXm8UrqiExDnuzBrBp4nsWQ3Vb39OqESCOtsHXUKLvl5CZ0GXS?=
 =?us-ascii?Q?aSHpGikFgHxTSuh1Kv1Z7uqjnKb7vqBpBaZbXZEt5TEOgQd+tZ7q6Dusn8TG?=
 =?us-ascii?Q?fJrDBgoZnNw1Q+AsiiAXLAKilK73hTtV8OQH0iCNlUEpObta6D9NwhmCHate?=
 =?us-ascii?Q?HFj6YpZnEtUz4mdTLyst1ksHT6lqG36qcJ2JI68df7a0evYpzUQEZXkvW/uU?=
 =?us-ascii?Q?k+fb8wLxED+Td5lEjhsPAveefHsA0eA8aEGJNZ65MiPTXkQuK1WNG+hijBjT?=
 =?us-ascii?Q?9b3pXzvFtiKSDMDLSIEdkpAmYqrejDbAdWfUC4KRhPEV07nYlKyNeeEzBArY?=
 =?us-ascii?Q?BHxuq+B+b/VHGAAl+s4oj0mf0SuRfTLKB3mfU2oPZel+qyZNeFxfCbjQQ+O5?=
 =?us-ascii?Q?c3FzAWswA/J4/yB6uCjNI61oEQ3uU12WTXRynLueqdMUNoV+0sRu+j1Hwomq?=
 =?us-ascii?Q?W0gh8YX+9G8qCZwnSK5YXxQMasdiW2aMRKQeZL9yH9LxlnntUqMCYqZIL+mH?=
 =?us-ascii?Q?8Qx8PG4TGmMgsonaw4+bxnXu/5stYI7fssh4KYX9f/GXjareZC5zFSqQNgX9?=
 =?us-ascii?Q?kRQpotPtQzPLIhrSu/j5wZnyG26R8ntPPGhfSKATRX1qdH49o/M2lmjokKiV?=
 =?us-ascii?Q?bI9P1SgSgT62dZ8fnSEl6gNrzfjBVveJGmZGDDdDII8EhApv5EjIaeXRDEi3?=
 =?us-ascii?Q?gXxAt2V24NVS3ol26hxZ4HiVx4vpJogIbe4FMoXKbFprMhdZnMv0hvv4lsnp?=
 =?us-ascii?Q?+xM99R70FW8yS/pcaRojslL8tut5BkUEtvphDgmv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdc5bb5-8237-4456-cc61-08dd300f9920
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 18:09:30.7609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmwcdCD7tFiSmNYC8pXcLxlUPdkKpE4wzzA7Cixpv8wuYhqL4yEESopR78VJBS9PvAeAoK8edwq3QYeppjpXh9kQmRv2GH4QdcleHaLBLvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8139
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Tuesday, January 7, 2025 6:52 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; 'Richard Cochran'
> <richardcochran@gmail.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; linux@armlinux.org.uk;
> horms@kernel.org; netdev@vger.kernel.org; vadim.fedorenko@linux.dev;
> mengyuanlou@net-swift.com; 'linglingzhang' <linglingzhang@net-swift.com>
> Subject: RE: [PATCH net-next v2 3/4] net: wangxun: Implement do_aux_work =
of
> ptp_clock_info
>=20
> > > > > > +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> > > > > > +				 struct ptp_clock_request *rq, int on)
> > > > > > +{
> > > > > > +	struct wx *wx =3D container_of(ptp, struct wx, ptp_caps);
> > > > > > +
> > > > > > +	/**
> > > > > > +	 * When PPS is enabled, unmask the interrupt for the ClockOut
> > > > > > +	 * feature, so that the interrupt handler can send the PPS
> > > > > > +	 * event when the clock SDP triggers. Clear mask when PPS is
> > > > > > +	 * disabled
> > > > > > +	 */
> > > > > > +	if (rq->type !=3D PTP_CLK_REQ_PPS || !wx->ptp_setup_sdp)
> > > > > > +		return -EOPNOTSUPP;
> > > > >
> > > > > NAK.
> > > > >
> > > > > The logic that you added in patch #4 is a periodic output signal,=
 so
> > > > > your driver will support PTP_CLK_REQ_PEROUT and not
> PTP_CLK_REQ_PPS.
> > > > >
> > > > > Please change the driver to use that instead.
> > > > >
> > > > > Thanks,
> > > > > Richard
> > > >
> > > > This is a common misconception because the industry lingo uses PPS =
to
> mean
> > > > periodic output. I wonder if there's a place we can put an obvious =
warning
> > > > about checking if you meant PEROUT... I've had this issue pop up wi=
th
> > > > colleagues many times.
> > >
> > > Does a periodic output signal mean that a signal is output every seco=
nd,
> > > whenever the start time is? But I want to implement that a signal is
> > > output when an integer number of seconds for the clock time.
> > >
> >
> > The periodic output can be configured in a bunch of ways, including per=
iods that
> > are not a full second, when the signal should start, as well as in "one=
 shot"
> mode
> > where it will only trigger once. You should check the possible flags in
> > <uapi/linux/ptp_clock.h> for the various options.
>=20
> Looks like I need to configure perout.phase {0, 0} to output signal at th=
e closest
> next
> second. And configure perout.period {0, 120 * 1000000} to keep the signal=
 120ms.
>=20
> But where should I put these configuration? It used to be:
>=20
> echo 1 > /sys/class/ptp/ptp0/pps_enable

You can use /sys/class/ptp/ptp0/period (assuming the driver is configured w=
ith a periodic output properly). Note that this may not be a fully featured=
 interface. To access the full power of the periodic output support, you ne=
ed to use the PTP_PEROUT_REQUEST2 ioctl. You can check the code in tools/te=
sting/selftests/ptp/testptp.c or possibly see if there is an example of use=
 in the LinuxPTP project.

Thanks,
Jake

