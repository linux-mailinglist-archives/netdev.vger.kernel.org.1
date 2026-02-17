Return-Path: <netdev+bounces-259071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD0oJMeFlGlBFQIAu9opvQ
	(envelope-from <netdev+bounces-259071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:14:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED61F14D7C6
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CCC6303B175
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BC636D4EB;
	Tue, 17 Feb 2026 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkvPUWwg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AEE36CDFA;
	Tue, 17 Feb 2026 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341196; cv=fail; b=aqTEWWBvgSShUMhVInl+gHt99ZjzLZTvmbomoqeh1nPG9qMx02pFv+1aqrrO10643BA8L1rkgdpxAcN0EhbozE/U+6FQ4CCE4PtEbgTujEwZZyzRShXLhaECeM/fdaHVyORilCIGeAkTXZDfkw0W/kYnWVZzP5NVrg/L7Cq7mvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341196; c=relaxed/simple;
	bh=DOsoBUM0gfgxICBlM1mWVUNURhKVYnfzFq6T0mayTpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MKL8/lOsU6pyV+EVbFqyfanX3j3DkInqXRj2zdscAe8ywNMQMaXweMmWgaYc6A73+UJsInX0gogoewM843KNUkEnYh0fG7c35GgFU8rh75egOZGhNtr4lYWIyhGv0qrxAcz+ptaCtzc2Jrc9IfNU32xSISPVIOu03KtCH3DbZ2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkvPUWwg; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771341195; x=1802877195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DOsoBUM0gfgxICBlM1mWVUNURhKVYnfzFq6T0mayTpQ=;
  b=VkvPUWwgfqPocxoqbUPIa4Yvh8Du52x0p8k7Py5mhtA/vjMZhOiWm552
   KtMEWeRmxca9d0U/rUyq80jG8TiHX+rgfaFqA7mX9U9p7doQspjg4evk7
   TvpCKSo4XiOMj0+JCHTm8hgS2PehkzAzBYOW5BeRUJlpu/st/rfKayCqF
   mT6au9/XJS4izA7UsVjMvrXmF7hV88lvXmCYd2rEt3FNywdccknbXGPJt
   wUWdjCSDrPLq/dOgZsb7Isplf7Zi0ydK9+hdw0b1vXgB2MA+4YfjaDN7L
   6pI/KsThni2rB9PjLtnkUFDVOV6XR+1MUqm9vZidP929pZryRa8yBeZmc
   w==;
X-CSE-ConnectionGUID: XfKY7vzMRE+Av84XxOMcBw==
X-CSE-MsgGUID: 6m6GymQUTRK2BZQESekPAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="71433012"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="71433012"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 07:13:14 -0800
X-CSE-ConnectionGUID: BbKBZmg2SjigzCUtYgh9mw==
X-CSE-MsgGUID: 1FgMNHRrQxq1l4Y4ferCHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="212631211"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 07:13:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 07:13:13 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 07:13:13 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 07:13:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Apv/ZmCbSYSGbJW73Z7QEzsw+qCNHMe8a8MtyjYAtSCm5f5rki/+irlxxgJlW4SmxvsrIXY/EWog2pSbKUR23zTJmHw1iUiWvqL7cxm+DDP7I+NCl1lM0hhflDNWF4ei9oAqNQS9eT6F7FctO7UMwYVxsn0z1dxjUQCDKUFUs9e0EWscXSGCe5JbJwL2woQI6inrphrIaXkZYdJ1zufNeU5LAD0q4TxMdK2vteIjv672GY3DQnKpXOzvSj9m/4oV7bcemkuj6iWsJ4xcu1x/RznWkNfRFVczLMwbVephhfri5BOEWJKg9fZ0LL/ZA3+fchqYmNiLttzRagrXLDPXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIwpqWmzcPusPRKTpDOkhoneOYIWyOc1Py+YjPVsH10=;
 b=nDheWvNnx2Yx8v7wANpG6vtlk+DUdfQSgGsqt01uDoOEtA9Ub+EPOJ1bnLpyYpHemIGC4hjqp5oVtJwqzVPFQdiiw40cArY4bMFsjTZHHJhGplZP3P62Ct6obRdSlhwdyAGUgXyPjtDBjsb7Lq/tWwtGfCFtveXMkoiRFMba3J0awU9zOVbZ5wUVRlYgdzUMXM5glYqKBK7KfcxX7GBGTrZM2ueJCaMjI/8bJKVqbpFPGasLviq1yRDcDAAPcvtBOJB2T/AiGlMnoLmUudzD1wpVl1Bh0I2igCq3q/ARJoD6vrri6JFtrlj6FOdwRbYoONGW8JPnwERy9IfSWcskPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB6371.namprd11.prod.outlook.com (2603:10b6:208:3ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 15:13:04 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9611.008; Tue, 17 Feb 2026
 15:13:04 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Bastien Curutchet
 (eBPF Foundation)" <bastien.curutchet@bootlin.com>, "Vyavahare, Tushar"
	<tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>,
	=?iso-8859-1?Q?Ricardo_B=2E_Marli=E8re?= <rbm@suse.com>, Eelco Chaudron
	<echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "Toke
 Hoiland-Jorgensen" <toke@redhat.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: RE: [PATCH bpf v3 6/9] i40e: use xdp.frame_sz as XDP RxQ info
 frag_size
Thread-Topic: [PATCH bpf v3 6/9] i40e: use xdp.frame_sz as XDP RxQ info
 frag_size
Thread-Index: AQHcoBUB5WVvt+54HEimVdQ/qpROALWG/5gQ
Date: Tue, 17 Feb 2026 15:13:04 +0000
Message-ID: <IA3PR11MB8986B5C67D3A7965DB89984BE56DA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260217132450.1936200-1-larysa.zaremba@intel.com>
 <20260217132450.1936200-7-larysa.zaremba@intel.com>
In-Reply-To: <20260217132450.1936200-7-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB6371:EE_
x-ms-office365-filtering-correlation-id: 66b8d320-cf83-4283-2724-08de6e370c4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rw9nOtSpoFBiyDcd/0ACA5VhKFiwg6gcInLo+v9/DseT97X5Z15cIPAzYH?=
 =?iso-8859-1?Q?BJ8mXRpbP6kdWcIe1O2To5bgFPA36wN0Tq0YTb5zn4W4ltqUY1Wh8ecWdU?=
 =?iso-8859-1?Q?cz5MXO2QAjyCcy5wxU1m9eLI8UqQPiZjZk8NPdZT1fpjGktN//24/uZC1Z?=
 =?iso-8859-1?Q?GSKlZA0pCSXZvi5T1tdgjmdiOKtvz9PvRQQYBGCwsKaE+SQg0dCtyJ/0Ri?=
 =?iso-8859-1?Q?89FLYTjxlUR3EwyqzlZhdoAJeTff1dQQWr+LLr/Xjayq/BFdp6wiAwNdvM?=
 =?iso-8859-1?Q?2Vb1w11ZesMnS/BHZBZtwsls3HZ8+TJfYQAzJxEBSdsrv46ZMMhytM95Ti?=
 =?iso-8859-1?Q?I/VXF+AF+JJnv/mpGNDDcS5NJrgVsVFmkqvhU7558obEayDyc7s0pMTpF5?=
 =?iso-8859-1?Q?kfy1rOlHPH2S1zVB1a5h+FeTrFsrR0z/l0jMQgZImG9uK9940V0UPVkpZx?=
 =?iso-8859-1?Q?gppZNTwe/Gunqh9Cq9NmuOGvsLujwp3mGUn5qPE6IDdmjbQgzbE62LL3+q?=
 =?iso-8859-1?Q?5590shBOZvmR2P8Pcpb0Lt30kEY0kSJSksXFpRZ0HjTRqM95pK5cNisP0b?=
 =?iso-8859-1?Q?p8KSdH+LLidUqYExG7IhmYQ/tjx4zVcV/s7VW4XV3jyy/MYqDtUUXDNgq0?=
 =?iso-8859-1?Q?0touVTb5jctVKYQgm/WGAurGgMU4w1OqZXdB3qxtOIq3QXjwH29sfwhf1i?=
 =?iso-8859-1?Q?euFZ2rZWTOlBOWxCeSUn3XgyK1XYTE5f9EHbTkYHm8ABcvAvvz0G0qHqPq?=
 =?iso-8859-1?Q?tnxffEPqifiH47uEQQdoelgC+bzHo+OrzUD798Fjm5HSqHNrBMRL9DhFsk?=
 =?iso-8859-1?Q?5amElJYRI8NJDVK/nABAWua1qyJB6ksRNza6pp0owd3ZJTw3KvylOV1omL?=
 =?iso-8859-1?Q?JNf0YIsFVR5x/o7qQ3+SKi+WJgvuKpT3CQ/fHtw1eBzZH7mfKlgJGQNkwy?=
 =?iso-8859-1?Q?8Q7IVu7Ieb8h8evYHXZ2PiiJkd2RlxKX6k2Iavze+8SaiMXYZHp/YTccJB?=
 =?iso-8859-1?Q?n9u/W8nU9Q2x4lOFtin5D7sGBQ0UjumIqCqvEEJsAaY0iCqR/Mywc1x58N?=
 =?iso-8859-1?Q?u81EJbaWwC8wGi5g6O25N0+EmCD3OF47y6EJHSpCkrL84TwHWguVFpE2IC?=
 =?iso-8859-1?Q?W+/+/UDXzJ7lz+RvlYD2jKMMzDAyRxvA4hucFt2eKwjAT/WZ6gZ15Ntrqt?=
 =?iso-8859-1?Q?vULd6R6XzrNly19+0uAMkNFQG75tS4lKQL3YBw7yFvt9prPvMEnTz8J6lo?=
 =?iso-8859-1?Q?jMlZYU5HqMfLvyMZeoj5e8F3i1rjWDnpAcETgEzuyM3H2MVh5pgA9zGVUk?=
 =?iso-8859-1?Q?cmSoRo/NTAauBLXd3QefJJi9piZtPw/R05rnoMyqFoh+i4UND/o/0uWQe6?=
 =?iso-8859-1?Q?/ktFbKky5fUd2+wW95B38oBZto2BVs2KaISVqOgwVEibsUVmm9e+Z0Qibc?=
 =?iso-8859-1?Q?7RH2ysoDfm3AchPqLqE1eLYK10mvj2T0g+95ZU8X2utmfXdA/zACBYC6yB?=
 =?iso-8859-1?Q?EniRS7rFRTMRm+USylK18Uh+55ab5baGXhZwWXW1Bx30RaCQa04QfQemZm?=
 =?iso-8859-1?Q?SdpNCiYni06Im7ozHOtVrYyA8JOb4ZZfCyI2JmPlRuM0AdkL4uHEXvl1FZ?=
 =?iso-8859-1?Q?oDIZxIsUqBeT5uNn+JaZWFNEGoaTcgOW+vdWDHZ0t3cpRgtEQOrUb+IWEk?=
 =?iso-8859-1?Q?2sIPWS4ifV1PzPl7LLI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cK/cLRR76i/vj5ARLw3Yl2065/C2jVx5BFHuV8cdInxUzAXqOPNZPLfLKu?=
 =?iso-8859-1?Q?v7eG4HRtexMKhMWpqUQesNhaJLsJvNl/Vyjv1iN8mAGxpgouyvRT/ALsSz?=
 =?iso-8859-1?Q?L4i8reCtkWEHVA7uaDjzS3J4/0TmzwvajqVAZ5RZ/w5olTBeVhK/vzo/Ik?=
 =?iso-8859-1?Q?M2D/a6zAtm/FTI6U0hJ1tmyeMvp2BQmRE3gh1ut8+NHji7Y0D1wgGaxRMS?=
 =?iso-8859-1?Q?hdkGJ3mWTh914D0APZgUrYL80Wzv0sHOPYZsEa/oc3W+VKDzYpJUgemlWn?=
 =?iso-8859-1?Q?FSu+UAyan5V9Ihii8szbBTgdvr7YE3sBsqeFOBZSkEUcNkkVJqwfp9+8Jg?=
 =?iso-8859-1?Q?SEnNdip+ZBvmBS264B7mR+09Y/Fo7wZ44QT+V0YLKz1KcKZLrUILYR88X/?=
 =?iso-8859-1?Q?M1Ru7fttqL8rOV8AAqHVVMWz5V2vBUpNpTdxrwBINSJ1urAttmBh8ZtATu?=
 =?iso-8859-1?Q?DvdtLIacT49ZgeKM5+m74nanBdEq2E2AbkyV2ctKxGP8XkPSTR/YLroX8/?=
 =?iso-8859-1?Q?/RZ+DoFwDQRN8ZHLzaZWCWcwRToXW2k048Q7kZ0O+wrLmhiLMA4XfvXKGP?=
 =?iso-8859-1?Q?XrStMZl9REUD3059dBSX267TUX1xk9iAcDeCb0cVP02FpfHagwkBwbkTX9?=
 =?iso-8859-1?Q?uZwyDQN/SwBFY+RxmeSc04yGHBLxa6/H+K2TwGWFZ3MQ/ilAokAWb+eROR?=
 =?iso-8859-1?Q?d2mCbOEnBk+HiFgCyQha0Xou/GedHYkVhg/WoB/CoWEAyrAZ6d1i5vhgB3?=
 =?iso-8859-1?Q?qlELMtDyFNbMn8eOcho9zvbxk9GOlARFteYiWfaHd3gdGAcIH2yIzoF4ob?=
 =?iso-8859-1?Q?0FBMWm1TUqtxSO4tUfXDBtV0S3sYdOSTZAvlDz7er6To+Ty2P+tGbk9e7b?=
 =?iso-8859-1?Q?POO8kWTDFHni7tU7Nnn5L7Go8hNPrZzO9Cn0d1lZo+s5sMgaPCKRi2qmem?=
 =?iso-8859-1?Q?/3G2LfXdibtffAZbJYr2fYe19xmyhykv+hLGG5iYPo+UMWYkPqtApQR4vY?=
 =?iso-8859-1?Q?gSXJXBnCZgt8ts9rB1JUfYFYMaUsrdSeiOxWX6AG4yLHMOfEsyMZzA7OL0?=
 =?iso-8859-1?Q?XAivlentHCjWaUcBLDwC+Y20S3lQnGD3Y/52t74YiLL5B7LARJX3EeJ9Rh?=
 =?iso-8859-1?Q?ICHl17eh91npmWkFqWCIdTRO9N8jS9RQn2nUEDg8driV+EecGTqfec3sHE?=
 =?iso-8859-1?Q?cQZdnLkcrV5k6+FogbIzD0GzdCj2OJJBykvfkmAQSd2VdjiBvo4/Ec5lMB?=
 =?iso-8859-1?Q?/F2ytW637yjTGtU9oHsmhsdosAwsim0fsdHAVBjOyiwH6eDPq6ivhWuWHE?=
 =?iso-8859-1?Q?v4JGqn6hGxqK6UED6tL3CnLl+qvDiziE665bzwV/VuZD0ZTI3zMQHwNJO3?=
 =?iso-8859-1?Q?63c8K9nd7nxNwY4/oi50Ttobf0lNSXGPgmIhY6feTBr6Q1RP4Ul1jbWpdk?=
 =?iso-8859-1?Q?4Twn+eDY3QSNM4ao3BIGZnZ4xmadCXeG7rSGNAkzeuYxaA9At2gIU76GcC?=
 =?iso-8859-1?Q?6XaCIyOD9PN32LkNI8SfGEIyXcR3A5qj4XZ7qAy7PxWz9jZl25J2CKDtWo?=
 =?iso-8859-1?Q?XCfrfn6s4iNUIAnk+M2an/tarUN2hjeSald1iN9me3gtsuw6SW3fgl6Zq2?=
 =?iso-8859-1?Q?Jq0n6GMWJDbvUQEfWq4/QnT27wV6BHW3uq+ScD0dkh3Fe360WOOYC0R1/T?=
 =?iso-8859-1?Q?LnfafeDH8XBEIOwUcASIM7XXJIu7nPf9L/2+3I+mRTHkJkWga8O8UAQpWE?=
 =?iso-8859-1?Q?qy7MJm29kRZ79MunBPcc95uusJQcERZVkKVi1lE0ap1kwYOULH8ePcNkDY?=
 =?iso-8859-1?Q?TAgfL9lc+fvTZi6u6QhI/9XuGX5ovuA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b8d320-cf83-4283-2724-08de6e370c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 15:13:04.1408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTXVWppvHqDBBEYEXu5t+jLYg2zZoY7xNXx4/TocyJCBa/G52+qbWiCl8yBu+B64ClUNx94o803qa+D3VfrjXaizzHwsfn0KbvudFhuXtnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6371
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[43];
	TAGGED_FROM(0.00)[bounces-259071-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,vger.kernel.org,lists.osuosl.org,nvidia.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: ED61F14D7C6
X-Rspamd-Action: no action



> -----Original Message-----
> From: Zaremba, Larysa <larysa.zaremba@intel.com>
> Sent: Tuesday, February 17, 2026 2:25 PM
> To: bpf@vger.kernel.org
> Cc: Zaremba, Larysa <larysa.zaremba@intel.com>; Claudiu Manoil
> <claudiu.manoil@nxp.com>; Vladimir Oltean <vladimir.oltean@nxp.com>;
> Wei Fang <wei.fang@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Alexei Starovoitov <ast@kernel.org>;
> Daniel Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>;
> Stanislav Fomichev <sdf@fomichev.me>; Andrii Nakryiko
> <andrii@kernel.org>; Martin KaFai Lau <martin.lau@linux.dev>; Eduard
> Zingerman <eddyz87@gmail.com>; Song Liu <song@kernel.org>; Yonghong
> Song <yonghong.song@linux.dev>; KP Singh <kpsingh@kernel.org>; Hao Luo
> <haoluo@google.com>; Jiri Olsa <jolsa@kernel.org>; Simon Horman
> <horms@kernel.org>; Shuah Khan <shuah@kernel.org>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Bastien Curutchet (eBPF Foundation)
> <bastien.curutchet@bootlin.com>; Vyavahare, Tushar
> <tushar.vyavahare@intel.com>; Jason Xing <kernelxing@tencent.com>;
> Ricardo B. Marli=E8re <rbm@suse.com>; Eelco Chaudron
> <echaudro@redhat.com>; Lorenzo Bianconi <lorenzo@kernel.org>; Toke
> Hoiland-Jorgensen <toke@redhat.com>; imx@lists.linux.dev;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-kselftest@vger.kernel.org; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Dragos Tatulea
> <dtatulea@nvidia.com>
> Subject: [PATCH bpf v3 6/9] i40e: use xdp.frame_sz as XDP RxQ info
> frag_size
>=20
> The only user of frag_size field in XDP RxQ info is
> bpf_xdp_frags_increase_tail(). It clearly expects whole buffer size
> instead of DMA write size. Different assumptions in i40e driver
> configuration lead to negative tailroom.
>=20
> Set frag_size to the same value as frame_sz in shared pages mode, use
> new helper to set frag_size when AF_XDP ZC is active.
>=20
> Fixes: a045d2f2d03d ("i40e: set xdp_rxq_info::frag_size")
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index eaa5b65e6daf..e012a50a0448 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3561,6 +3561,7 @@ static int i40e_configure_rx_ring(struct
> i40e_ring *ring)
>  	struct i40e_vsi *vsi =3D ring->vsi;
>  	u32 chain_len =3D vsi->back->hw.func_caps.rx_buf_chain_len;
>  	u16 pf_q =3D vsi->base_queue + ring->queue_index;
> +	u32 xdp_frame_sz =3D i40e_rx_pg_size(ring) / 2;
>  	struct i40e_hw *hw =3D &vsi->back->hw;
>  	struct i40e_hmc_obj_rxq rx_ctx;
>  	int err =3D 0;
> @@ -3579,11 +3580,12 @@ static int i40e_configure_rx_ring(struct
> i40e_ring *ring)
>=20
>  	ring->xsk_pool =3D i40e_xsk_pool(ring);
>  	if (ring->xsk_pool) {
> +		xdp_frame_sz =3D xsk_pool_get_rx_frag_step(ring-
> >xsk_pool);
>  		ring->rx_buf_len =3D xsk_pool_get_rx_frame_size(ring-
> >xsk_pool);
>  		err =3D __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
>  					 ring->queue_index,
>  					 ring->q_vector->napi.napi_id,
> -					 ring->rx_buf_len);
> +					 xdp_frame_sz);
>  		if (err)
>  			return err;
>  		err =3D xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> @@ -3599,7 +3601,7 @@ static int i40e_configure_rx_ring(struct
> i40e_ring *ring)
>  		err =3D __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
>  					 ring->queue_index,
>  					 ring->q_vector->napi.napi_id,
> -					 ring->rx_buf_len);
> +					 xdp_frame_sz);
>  		if (err)
>  			return err;
>  		err =3D xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> @@ -3610,7 +3612,7 @@ static int i40e_configure_rx_ring(struct
> i40e_ring *ring)
>  	}
>=20
>  skip:
> -	xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring-
> >xdp_rxq);
> +	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
>=20
>  	rx_ctx.dbuff =3D DIV_ROUND_UP(ring->rx_buf_len,
>  				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

