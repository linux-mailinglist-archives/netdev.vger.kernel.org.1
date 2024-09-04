Return-Path: <netdev+bounces-124923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0269B96B62A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C1CB23BBE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8168A1CC886;
	Wed,  4 Sep 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUiNypu1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F44146A71
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441044; cv=fail; b=u/tBvM8qaUvsgzOxOTtX6HuGM6UW1je0eyuUaxxsmDZ5i9BUwvWF4JuzKIHFVXkSGGEEPkL/DDjC9xrkTRJaX5zyDTOvE21knB1+O8Oy04ppM4HtmN8oYfrp4Q6BamRiG4gRpiTKFuEyztuVHl+sIa9Cb6BXx6ua5rOHJk3jLG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441044; c=relaxed/simple;
	bh=aB8x7IRHLqYyK66ZfDUbCfWOfPWuMs0hOi9g1+szceE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gv7FbbdlXlFAaJ+UkCXkJWJ/EN+OB/JxVtxjGPdI1lv5HDQPuiiOUqgGnU/SJrrQf7N+ezwARB8GQREhw5MQVAYaHpjxxEmN/dXvlYx42akQwGDCj6RzlaULKFHv3rGkKBK4ZQq2w+DcMA2ARqWk7f7q/RAp1+DKnyw3PQadvvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUiNypu1; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725441043; x=1756977043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aB8x7IRHLqYyK66ZfDUbCfWOfPWuMs0hOi9g1+szceE=;
  b=ZUiNypu1WsW/nyaSfpo89U48rJDmV32cFh3Bsk05Aj6xF3/SqMQ7g40J
   HKE6McZF/aBX1bGvOKV0V5dvJr2EHm7d0At1/U/+tqNeot7RyBCbJToNt
   GJcZSvWbzIWs+YELOiNO6vgjv/j8M6dkIcQzQiHx51Pk8yoSFn7xnDeDz
   6Tv0eZz5UuY3Q678Fc3I2AyjEPlayQMVLoajAhDKHoY9ca8LK+dFtbU4v
   9GeAzRjh50vgw8/j2x1tdAp+HZFcZRmGfxah/Pl8d5ueBEfFoqoxtB+Wq
   MvODA1ULCKUrZJYHTdDzU6QZepMgPter+XYpLXlVcGJKWQWwmGGpko5rA
   A==;
X-CSE-ConnectionGUID: XpHv1nFjStGZlMGoCFChQQ==
X-CSE-MsgGUID: lg/tNoDBTP+RXwxzkGSbwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35246588"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="35246588"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 02:10:42 -0700
X-CSE-ConnectionGUID: q102G1acTdmpteBzrD0IeQ==
X-CSE-MsgGUID: W8OxZu2zQk+uszSaVxuIjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="96002567"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 02:10:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:10:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:10:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 02:10:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 02:10:11 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 09:09:36 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:09:36 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 4/5] ice: Use ice_adapter
 for PTP shared data instead of auxdev
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 4/5] ice: Use ice_adapter
 for PTP shared data instead of auxdev
Thread-Index: AQHa88vH3TT9ViMRk0SitdYceNJxHbJHRblA
Date: Wed, 4 Sep 2024 09:09:36 +0000
Message-ID: <CYYPR11MB84298A8503A906E87E35ED93BD9C2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240821130957.55043-1-sergey.temerkhanov@intel.com>
 <20240821130957.55043-5-sergey.temerkhanov@intel.com>
In-Reply-To: <20240821130957.55043-5-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: 1efa20b0-e4ab-4b68-1a3b-08dcccc14c61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ieq85f4kMe7kEQ/OEZdrbfCClK39AKrIj2Ir/ymkCwQVUZWl7CIWgzABH3kM?=
 =?us-ascii?Q?PjsHQeH8KLGLtYoWt73wvpElxqZN2wkh2v9ZhnaTZIvI3AlWURM8mKzbpzYS?=
 =?us-ascii?Q?gKfbsBQo9CdJUJIQPB1CSuAV/VdaVAUdjXYFg4/IxuvIMRwQF06gyTLZvZ9l?=
 =?us-ascii?Q?vcX2FT3ka3kSLOxdkKtrForl71YJCyqqZAdghufbNSnJ5rqChE5ow3bgXLTv?=
 =?us-ascii?Q?ryUPT2Yo0h7FkP7y5bvIBMgBWxC+skqko7rXOx151id3fCQBxv2omcUy9OBo?=
 =?us-ascii?Q?5imVUKRgFrJRgBcMVi/wkIWYnAY24sigk7EAlydWzWZ8+6sTQN4tjRWwPclm?=
 =?us-ascii?Q?2DYhrXaZC5PyzlmPn+1EBVHtZ1O3aTCwFdph0Su6gcRNo9qe1PRa5HxrMiDz?=
 =?us-ascii?Q?EsbGIP8m7U3LE9ZeAcTh1RO0LmPvnA5Mv9NbgcI/fM1W4pnbPcvz/xphu/c7?=
 =?us-ascii?Q?RwnOgwh3yLIKRPhoWoa2gb6Qp9MCPJ38zBBxGhz1CVp+gbVLLyCOUjSZnewW?=
 =?us-ascii?Q?LRa8kgL0QJgzqwN6K1MhhAPliPQWwA6a9Y8LV6meC5DlpQmFoYPVPM7bEjgg?=
 =?us-ascii?Q?JAQ/fATjrOmuViKKMJdf8HpOXCOaoh6FxLIwa9KAfyQSdvafWcMKJAa2svSO?=
 =?us-ascii?Q?5oQrNG9rbXLAo9qek1agQlhlYWOYxw6wefpRhbBhsEfj55eJTmlmAsfEcUSd?=
 =?us-ascii?Q?uFUYXaLcvTnmL1gRuoTUU9rjW/TI7l1Hn3NES1Gbh3+zqOlWUH/u9EThZtXr?=
 =?us-ascii?Q?VMNUFezY42y1js6lbT9fHGr+HaccAwVCf43iuoEJQhZKRlgZO9lfuiBsw5GU?=
 =?us-ascii?Q?3teLKXVx0dtxMfwB1zP5TPIdhyZzz/A+j+ZLobussEbAJIYsy9Fcs/65OxWQ?=
 =?us-ascii?Q?Lc5hs2tKA0yLpntE3CuDoljWbLyZdkZofXQQbmvi2GzEDO2b3WSXc2lsUeWS?=
 =?us-ascii?Q?mN+Sl2BAv8eZE9D7U4OhBxN2wU+THh6wAe8ChRe7uYF30ZwMy3sM2fJ69ueF?=
 =?us-ascii?Q?n+r/mZI/tGBUlQv8k8HLymDSBsrmAuFpFxyn18g7j8yhm3QjIt0KiV75GH8i?=
 =?us-ascii?Q?d3mTE9PL3naKVMljkepLpX42DY7fPPAHh7EgMntCWBfzcLgFqSHTRcM0JkoB?=
 =?us-ascii?Q?sLZAcK/9SKg/Qo0+YmvThCjKkfUgPTXqECSBwB73aKZWZai/ULw2zXWrOdvz?=
 =?us-ascii?Q?11W/cvV+kTZDgi5fQrHhb0jhWZuC3ieEtOQXIa3UIaGas1iy7pxzTWJMTqR+?=
 =?us-ascii?Q?J1XBgvg9HaoNLCZuuWEdaoeuglxMTc5oBUUlAd9qFZeV+MO3yjyl4sO1Y/bH?=
 =?us-ascii?Q?8lROTr8EIDD1KYnYMqKQzFARknDjCj3+ani0TPSoz3/tYn/KPx+gG+MwIadd?=
 =?us-ascii?Q?NPJh6GNfl+4CuffOqO7bGN9ggPF0myzCIryuBvDDlfFZtVVG0Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FdQ8nhCZpqf0Gzo62QELsJ1qN8gkceGsd0U6YfS3hvqrxQ42OfDO1mASc9Z5?=
 =?us-ascii?Q?+7Pdm0vVAaxOonmWnsHz1DGA/Y79opeI0vHu31+IDKh+XogserfJS9EMXmiI?=
 =?us-ascii?Q?it0VEtqTRCCWJO0KC/pJQK5W5IT9Skz8wyQWvKv/u37km0HqgKOUDE+Hbt0o?=
 =?us-ascii?Q?a0huoUnWyEuZxKkQ8z2McwzDblLvCOtDariM39HTrrisTAqzMlTiSgRfvYg9?=
 =?us-ascii?Q?7AMZdyUXZtRvxz9ZDHqBK+W1VfVJ7/dpa47LeNZ5C9ZMGNerkM6n5ORiOzPA?=
 =?us-ascii?Q?u6Hui0kmjs3Oh/Oq08f8On+9IOFRhOQ+ElGIOZ0wxHrdi3/mt3kyWE/fjzpm?=
 =?us-ascii?Q?N23kyKPexoSgk9C6MyU6jUwNmiuIse5WodBgYvFmKK9EgRNXkccVK0oWiEzR?=
 =?us-ascii?Q?zgdDrvnVO3xClfG7E/6TLK1GvtX/Iljk5lp1YPamVliIEi9yd+GvZ9q674cN?=
 =?us-ascii?Q?yKF6ITYRenr0mkPHrr2lX1fjTHAEwGCtqzRx1Lb9i8hwkfvF1Rv2SDEWHPxh?=
 =?us-ascii?Q?GXLuEzd6+i6o9Q+LSRfJrs2XALhWDQV7BY262LkMJaWXK9s1PoB1xLWhNydK?=
 =?us-ascii?Q?MDQnaiu8zFv3GShiJGqIxpy6wkLmza021Y8vo76soB7BMcSmRzHYktX1IsSf?=
 =?us-ascii?Q?iOLJjpTHOzByRi4Dkb8udhP53EMdRH3tzIMmC+H8Hzm2Qmr/XOkXNnXU/GwY?=
 =?us-ascii?Q?g8g+JhnM8RU/u1VczoklSA+UTJMMDvzoY9+jWN/hyWgKOi2sTkWjQ6tBqRZ4?=
 =?us-ascii?Q?lBQarND/FmWMep1xeWNUSjKOk5AIJetPk8NFzDJvm7b1CO68f4aE+3IOw6uB?=
 =?us-ascii?Q?n2PcmaU2ZLgftfY62mcEkku1hhxYz47EQEewfnCOt8d+RBCKPGZDogIVx7K1?=
 =?us-ascii?Q?n1bb8yRz05xRpNc76CN8dZ33h5iLBHZonleIaSzposXmiflX71cVDqsnBqpQ?=
 =?us-ascii?Q?N6HblF6xW4u/kmD8G9WYq4oysNpq/XCfQ1pvDUgknoi16S73lmRdZ7OixCBN?=
 =?us-ascii?Q?pnnjyfmhkcONe7I+zO3zx282hxssXi6A+DEK+w1H/2SeAJIVSi3GTPGFUdKl?=
 =?us-ascii?Q?ZR9gW5qZpWP/fWqcqDpYoDNgNXydSwErehpsNRrSyVoG0Tt7K6MdBrBgfkFA?=
 =?us-ascii?Q?/vhi/s/jfP5wBG9y+YARs9WgQzXg0lhNCyRgBsmJJyE2lKAx+mN9cRDT4gVT?=
 =?us-ascii?Q?cNFxEkO5Ihpql4jmnDjye95iTyP4armP38/lmCuaC5TvWQjbs3jljncAHhfE?=
 =?us-ascii?Q?8j4uP62nQhj6c8N3F2ukZuGJjcsaudZgpL17c7BqqdgC9fEHeUeu94ymlNg1?=
 =?us-ascii?Q?zkfVZ0iLmKjc/BYj729JEJl4uybsOYROkFYJxrrWB+0zBFfGz0NDvdfxhVYv?=
 =?us-ascii?Q?wLxPFpEZcCrcXlQFNuzq0MhLcU4/9gMn7bK/o02TPFwIjPO1CZpJ2cVmWVNZ?=
 =?us-ascii?Q?l06/M/NZceLIMCPSP2bHA8NtQkaIXDypMD0bPlhrMJe02umNcUKws6n+DtgP?=
 =?us-ascii?Q?A/Kql8VUbZpX7Jjmlc3DXTckal5hlEYnK08w3II/Q5Y/nQb/LXoMqy6y2mhR?=
 =?us-ascii?Q?nRkuv3R+Pzz6Y2lzmnkbNYKeyz97pUYijvV+IZxZ7B5umHNN8Ujgs2giXnwV?=
 =?us-ascii?Q?Sg=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoTW9eX+hCS53t7wOPdsKG2PzqjaRqGTnSDahW3Z9kXoYsnQTXRRWhlJJXUN2EdJntToquHbabwJyCH/7WS8GjJsSHuOBHavKt5TVNol3eYJp4c+jG2LiMt3eaGfnXQhoxIAxVYSFTFAk+Gf8RMQBVeFMQHo9tB5VBdumFvm/8n3jqtdIlQCFhVQjFrQ1PnAxaPwuuyxuR5VOl0Cn7JTht8Np1wtK1G0fXgzxwTpWDPDqvOCmqlD6OvTnr1iJSyIhNiP7GoUcEPaT+ebPO9h4RRmkQ/NyI08uJX7P3X1WpDxWAWtx8+uHMVf5/gvJwigGzz7u6m2hcIq2k/IOM7tow==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCbpKTsr7zeI1ii4/nZnjTopkO9pWwbX+PrdI2Pcf9w=;
 b=Le1ANdD456A+Ft0NSzX7xiIfPtxPMlI3uA0zkd4yms8+hm9BqoHGPP5OLWl7FoiJn/4mjsR0Y1VI2qFcemUHQ2AyucTB8GxEYfqpbL+gGfQtc8Yk2tJeQnEB4NMV4CsTFnIOFRfWe7ZxO/LMhdox3sIx2OXRNGKrh7IYseYKO1jBxA/vdwRbaZCCIReNYBBym4z7L8IQLzFq2Ak+w6TDw5fVElFDKyq3ma7KzSK8siFvhi+VDt1GxUOEhzIPA3vuYEQYjFVy+gmzZ7b9kXoCMkL3QNQAQjxzsCFHnna+NYJn7HGKi7iNqKpvNEExiPCt92hMKElXMCdbzz59NCGp3Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 1efa20b0-e4ab-4b68-1a3b-08dcccc14c61
x-ms-exchange-crosstenant-originalarrivaltime: 04 Sep 2024 09:09:36.1416 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: bw4oSZaq6BjT8fVcc6cfwTXof22BZ1c3KEDJLNEi1Jq9b2m3Gj1TjbYPFnzZ8sCoRaF3MIuF/Ge3S4XMPVQv4KtDPTZ+AUM+1BlgAbUYaU6Wio+IuAhqg4CChtQ6eVCk
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR11MB5830
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
ergey Temerkhanov
> Sent: Wednesday, August 21, 2024 6:40 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>; netdev@vger.kerne=
l.org; Simon Horman <horms@kernel.org>; Kitszel, Przemyslaw <przemyslaw.kit=
szel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 4/5] ice: Use ice_adapter f=
or PTP shared data instead of auxdev
>
> Use struct ice_adapter to hold shared PTP data and control PTP related ac=
tions instead of auxbus. This allows significant code simplification and fa=
ster access to the container fields used in the PTP support code.
>
> Move the PTP port list to the ice_adapter container to simplify the code =
and avoid race conditions which could occur due to the synchronous nature o=
f the initialization/access and certain memory saving can be achieved by mo=
ving PTP data into the ice_adapter itself.
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_adapter.c |   6 +
>  drivers/net/ethernet/intel/ice/ice_adapter.h |  17 +++
>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 115 ++++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_ptp.h     |   5 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   5 +
>  5 files changed, 105 insertions(+), 43 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



