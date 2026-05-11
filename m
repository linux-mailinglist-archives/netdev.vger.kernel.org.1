Return-Path: <netdev+bounces-286555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLh4B/SiAWpKhAEAu9opvQ
	(envelope-from <netdev+bounces-286555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:35:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3367450B02F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6C60319B5F2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF83B19BA;
	Mon, 11 May 2026 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeCR8tp0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7C363082;
	Mon, 11 May 2026 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490402; cv=fail; b=kRjo2WVTWfstkpL3BAqOWsE3DFytV9Fe7Pn/+FF4hQ3Hm2rsrEuZgJPegi+OSYWOF47JCvpoPoy8uJP7u/L9RhhG5pgt6cN8ddm5JRgeJ4rEZWUY/Kvgz5IZ0+7ZqiQwGdHZ6hmAcZg7VvZRXFhdyo7aRbjNp9K77fw69zmlJaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490402; c=relaxed/simple;
	bh=wk29vsZbz3PqHxIIzxSIQl6fRxyisTtxydZB2zPVXeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ktKHHHcknE2pEV87rwouj/zm59IicI02XQH8ps5zTLEI5vYbqtTpUGnqTz19Kc+N1rU9Zkm8t+EJpWGdxq+1X638lbUe5lg2JzP7kBIsMA8J9B3i0CHPsWkqPTQJ4T3RE55qc8aZBwH9hVlM18fImN+JK2NuCTOhpX5GVHaKr0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeCR8tp0; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778490399; x=1810026399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wk29vsZbz3PqHxIIzxSIQl6fRxyisTtxydZB2zPVXeE=;
  b=TeCR8tp0KZE1AdokfrMB9EZ3pD4P8uasbsdA4x9ZKMPd2M1SPzmRXpIr
   NMnIfPjsaFau4ADn4Nnew9C213Asj27OhdHWnaxHdIRbTjGXxGSVeeZA8
   Q3bltMGRbmtAOnGHvOKNsGbL+34GJ7gIvXhS+Up9Z8VGxxiVgYgDZqtDF
   PWFhdDD9iSFKUmJMU78//Zj2SZQ16nDWMZQkV+L0cC8ccOoM46TF4Px/3
   9oDFX3gU5Y2pgBiveJIsb6UwsQqRUPrGJcUEj/17vDItUmIqmTaHMZoaB
   rZjT3PCasZPNhvWh473OG+A5DDnof/H39Dli0ho/eHbe5KtyKYXKQl1Fv
   Q==;
X-CSE-ConnectionGUID: 4eT8VdpuQnSjdnbm62LTNg==
X-CSE-MsgGUID: vJRFS2peRPqmAVVvqS0obQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96796028"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="96796028"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:06:39 -0700
X-CSE-ConnectionGUID: M8OzNkFYTvOcJT5Mgk4+nw==
X-CSE-MsgGUID: xpL/OVifT+KPEMrVX2ouFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="261132416"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:06:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 02:06:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 02:06:38 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 02:06:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gdv0FJDjDnR7UodA7KdMLG1J6mf/mIim3Hsk0an0i0qu3WbkQoPiDeieRYiev4Geeqd/zv/ZtrVdclAD0Jg9S/AIpjkgYiwLdiHLCueicBDYXD9a/vWOFObvnrBN+jX/kdaAtmUZa0SlzEMDSbirPJ7WssmsmDp7r+Zy1cmgaHtwlATAbcJJn+PW8dg1FRxs9qaaiTvROFx1/tsa26vZ9KFll8gEnThUtCPjWBj+v+V6DI3VN7p/e4dJlib0iu6LgK45lT58R5Hk9Q48C01T5cVp95uvSNfQBMREfGPGCR2fIINrYVwY50XkiyFA74EtRjwjc0ebiz5cb0GyOxaARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk29vsZbz3PqHxIIzxSIQl6fRxyisTtxydZB2zPVXeE=;
 b=lwZKSa3KwuvPPyMOb5N82jhoZGHvElPjaH+vl+k2jXjGMXwrZrYn+E+AdMWzclTQ+cJvZcX0YnPh9epuHWxXkFMgPmIf3XBF0BiD5U0fXfm7R4Jjtnd0UglA+YrAud2d/Rxd+dXzLE2xeaTnLrNis4MUR1jLq5Bjkhx10nVSrlCcQc9m6PF+eDVqcVymou7KpkudHMTfnxRCiU66/t3jF3Ka1C/dYuKnnt84qjnYNslLtFl1+bnPazpzkX7ewviEJ37NXlrzpH+lzvTfbC+p3WcqF+KPpVmVx/IypEKC6m/lw5l3uQjlYmm9DzM1ELQ0lArFhquEAbr+s2oF36M3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by CH3PR11MB8187.namprd11.prod.outlook.com
 (2603:10b6:610:160::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 09:06:35 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::62a:1a7c:6360:a580]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::62a:1a7c:6360:a580%8]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 09:06:35 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Petr Machata <petrm@nvidia.com>, Johannes Berg
	<johannes@sipsolutions.net>, Arend van Spriel <arend.vanspriel@broadcom.com>,
	Marco Crivellari <marco.crivellari@suse.com>, Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Markus
 Schneider-Pargmann" <msp@baylibre.com>
Subject: RE: [PATCH net-next v3 1/2] net: nfp: Drop PCI class entries with
 .class_mask = 0
Thread-Topic: [PATCH net-next v3 1/2] net: nfp: Drop PCI class entries with
 .class_mask = 0
Thread-Index: AQHc4SS7yWHQCd1KEU6sUgiQp7lPFLYIiJTQ
Date: Mon, 11 May 2026 09:06:35 +0000
Message-ID: <DS4PPF7551E6552513C078724671437E3A3E5382@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260511090023.1634387-4-u.kleine-koenig@baylibre.com>
 <20260511090023.1634387-5-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260511090023.1634387-5-u.kleine-koenig@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|CH3PR11MB8187:EE_
x-ms-office365-filtering-correlation-id: 295acdcb-e6c4-4719-ae88-08deaf3c9a54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: I0lNcXF6fTRDB4hMhRkUYE8qwOe30VXsAH9c+ob/vByVOaVRz1VFlRgzw6dMxYamSgmFgzgiy4tGWT/hWARsODuEGtCiWj0sE3Gi5hGyoVuKyQ1j9/xR45GEV4nh0sihfwcpF1CM02AaoRTg616AHtkYOu4RH0LJULL/qiMDspZOq8nFaJKnvEd/JfGgCJW/UwM9i3bCu6QEEe5FKMEiswp2Xvbprs9e3WgGj7jRfF8lfPU6gUARlZbwvCHUVKat0Fmwgw1LHO1xwISJv6Fb4ch74iE5WjtxRpD+pJIFchKzTTwWjDYv1mCeN9mo/L/uhD+2cIGy9OrQsg4NHX/NE0gnO5qQgI1tWZLC9UoCgFWC0V0aRElvJKrhvpY9EK7Yt8ZZQqzfQV80y/VsKV7AlfcGmNkxnHeEWo2+amXRwMxM+w4fYsha2C9Nwy/JR3zye78h7WuJa9rEur+fg0FVp2CZRW2G+2taHy9Go7mYi7HiqCms5LYOxDvaAp7io4y6+NzShmaA67qc4MmoOtTPO9ta5WZYxic88U30WwufNXi3HTHhwd6Kk2TzavrLtpa/xr6mPEbdHu0IDbpYaJnPiFpDV3/nRBAITt5PED2xWemU6O0/PXFcAhrubsaqYZto80YdrtkO6lmMib/IiEeZSCavsmexm1PcnOGjOCgqlbZP1GM7WCMLNmCDyz7fEylxLhaZbekDWCi002hpmD6KBLxxXoDPNnk6LLL5UAHYXGwyOGvwBDDTZPE7FgsWh05i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7551E6552.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dml5RkJlUGNoYXZ1dFE2cmxsc2ZOaEplWUZKUGxCNWIzS2lRS04wS0hVVWhn?=
 =?utf-8?B?YVl6VzZ4Q25zeU00Q0xCQXovYWh2WWlENEQrVjM3UlBSdEJqMTV4dTRhK1pK?=
 =?utf-8?B?TFRIUmtoajhSc2ZtUzMzRUVQVE9HUi9Rb2xpNVFRbG8xaXJFalhFcVdzZjN5?=
 =?utf-8?B?Vy9ieFlIRXJvVm9uOUxDQXd3cTBkQ1dnV1M2U0hsLzhEWXk0ekhuY2hCTUhX?=
 =?utf-8?B?Z293cTQwYTJ2YmpoRndOWW1nZWMwWlZOM3h5eGh6NlVEUWhwTGRGWGdnUXZH?=
 =?utf-8?B?bnhQVW9Zdmo1RzFzUC9IWnU2dmFyQ0E0ZzErcXdlNlR1QVVubE9LNXBleUdk?=
 =?utf-8?B?VTRKT01WWUsvZXdyQzVodlp3NVhzci9HVHdwUXc4QnVqWVgrczVHOFg1TTN6?=
 =?utf-8?B?UTJ1QXRqVllKMmhWanBBcVVvVmxoN1krSmY2NWlIdTI4MzNRdytzTWh4UlMy?=
 =?utf-8?B?SGl1Zys5Q2JYc0hjeHFZYjRML2M3T1draU5ONDJ0ZDArVzREMzN3TGdGdVJH?=
 =?utf-8?B?anhtY1dnejRTcXFYQmkvY0RZQk9ORTR3OExha2hlUlZxYWlqNDJIaE9xQXNL?=
 =?utf-8?B?RjlSZFpJUnVDRTkyN3NSdDVtT1FtN2g2SElZNVk0SG1acE14T3M2cVFYVmgx?=
 =?utf-8?B?Z05FNkxKSUVkc2luU005dmJzKzhkUFFJeGtHbmowUkc1Rll0ZXNsR0Y0NHY1?=
 =?utf-8?B?MFFwYVVWaUQ0MU1OZ0RXWGU4RHcycDJsMWZmUDZLSThnZnVvK2lBMzZFeUlx?=
 =?utf-8?B?T0kvWXZJV2RjTjVTK0FvN21TeGdDUTFhRS9DWFlsc0RVcW9CRlhGUk83TEFy?=
 =?utf-8?B?cHU0d0dOTzVUU0Q4SFBxUUdYSXYzZEtuS3hOM0pIRWIrdFEzcklOUzd4WGZy?=
 =?utf-8?B?Y3FpV3RDL2Q4SndlOXRGbDl4a04xOG1nNkhaditvUi83KzNuWGtkaFdZWXdw?=
 =?utf-8?B?ZXRJWXEycmJFOTJyZGFlYnF6ZEJydU1tTkRMT2IvRHpOQm5QZWRaRUZQejFm?=
 =?utf-8?B?Ymo4M2graGFYMHpPVEVYSFNuRVM2RHFlNXcxRm14WlU1Z2ZyVG5hZ1BNN0l3?=
 =?utf-8?B?R3FoZDhpTE1IZXZiemxiSkdjVTFMNjRrcmY4YzNiaVVISm1IT1M5bjJWakl4?=
 =?utf-8?B?QUpRZ2ZNZHBEQ2tCaC9abFJxNzhJMEhOcktFc21uQ0Fsb1hISnQ3VC9RQUtw?=
 =?utf-8?B?bWp6Qk9VUVdRTTczcjdQZ3g4QjhDSWVoTnJ0Mm5PQWxVTEpRcU0rSk1hTGgv?=
 =?utf-8?B?djl4d21HR05pOVVZTUp0Mm16N2YzOUFPdEhnb3ZyZU9VSVBLQ0ZJL2FnQzFS?=
 =?utf-8?B?Zk9hK1FuMzhlM29kVGRsWXU2elRBeDl4dUJSV3ZLaFRMOEU5MnV3ZmFZbm9p?=
 =?utf-8?B?RjExK2F2bkhyd1VrWXRKcFhQVHhNcUY1WExVby9pWFkvNm9NNWI0aUFMZ0lr?=
 =?utf-8?B?bXdVd1M1NHZoZ0duWk80bUVpUStrUUhmc2NZTUUrYk9UQlF4RStpaGQzY0Jw?=
 =?utf-8?B?elN1WmcwWjdrU2NpSDNocjU0d2pVWk4ydnk0K3NnT2EzdFJ0eVNiUWpCUnI4?=
 =?utf-8?B?eUlWZGROTzBlOENiNHowdjRtakNOdXlsamtrOUdSL2lnMzZwV2ttd2lYSVEv?=
 =?utf-8?B?dmY3RHo3dFVLRjJZRThTbCtXaTdETC94MFlGNytFbWtOVERYWUxRanJGRmxh?=
 =?utf-8?B?cTdpbHU0RzdPY3JYU0VkTXBKTUpmS3d2QThnZS8vK2pMRThrMmc5a1ZGVGFD?=
 =?utf-8?B?RkR6WGRPZmc3cnNmZUpDcTNzVWI3dVEwRzlwV3pGU0djcCtUa251M2NITjNZ?=
 =?utf-8?B?NDR1NXpVejlwZzB3d2ZsN1NJeWwwSzlxQnlHT2twUlprS21ZSWRRY1QwVFpQ?=
 =?utf-8?B?T2gzWU9uZ3BxR2pBUXJ2ZGhzeG8xT1ZPY2UrNlNrVSswMGlQR1M0SzdCMTZW?=
 =?utf-8?B?ZW01MnY2Z1M1RitrWjdXbnJJSzNnRXoydWhIUURmdCs4QWtvaTFueHJaWWhN?=
 =?utf-8?B?cjFvVEI2ZTExamJnS2xiUEhacXh4UEt1WlQxZGRQNFVGU0pOK0Z5NnRyMXJu?=
 =?utf-8?B?YitodGxxNkVteHZQNkFyZForSWJYRnN1MmhwVXkrcHkwU01zZEdCdUUwMkx5?=
 =?utf-8?B?UHA4dnlneVdUM0FnTmtoLytqZk9Ea2tTK2NMalJBNmxlcnkvcFYwYnZoTVN2?=
 =?utf-8?B?b1hnbkcxMnhGemF0U3RsV2h5R2U4VlUzU3VJSmZpSHhvU0V1R1lyMlVZcEQ0?=
 =?utf-8?B?TW9GN0c0b0VITjFBWFpxWWd4cERZVExNM2J0MXRTSkgzaDhOeEVoME5rNVp4?=
 =?utf-8?B?VDJCMFpEalh4Zk1SZnF4djVEcWRxcDBMd3JGSzJLZEpGU05weFVkanlEWjJu?=
 =?utf-8?Q?GhctwOjovtFawS9w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vX9uHSW/2tkaQX2nrXqJn1Lh9cOe1QOSIQAGN19mm3HDDdNhaKYD5vGHiivzY0vB7URo85Vlq3CjXDkyytcZHFdD5R09pMalld6unXdZuxmgfokRCM8U/tbaqPHixUpTpEmGABLyj9KVHXcZI2G3i+f8+5UMQh7PBcRO6m9Z2g3ioqlJlzVnXa0wi7eZ8c7+TEXeUbSVjOKk9QEFEHNOEHe1Of49rt7UwUphIt6m0EyeMfg4JPQmBDeVQkcPYm9Xq+SWv7rQqIUCK1B/Ix4Vl20qif6XP8KdUzm6g4zNykKVGVLWQH7rQUXVhy2TYqUbFmYMMbiSBX6msq13adDitg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295acdcb-e6c4-4719-ae88-08deaf3c9a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 09:06:35.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+quEQCBEdWF0V5lgWXoRMldLVINCWZowe6MOToFwv979Mg3CBO/IiCPgGgTh4F7eOKvdI8+QqySYlGEkOJMDsgKIRnuaVCV2UVCUm/8GwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8187
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 3367450B02F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286555-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgKFRoZSBDYXBhYmxlIEh1YikgPHUua2xlaW5lLQ0KPiBrb2VuaWdAYmF5bGlicmUuY29tPg0K
PiBTZW50OiBNb25kYXksIE1heSAxMSwgMjAyNiAxMTowMCBBTQ0KPiBUbzogQW5kcmV3IEx1bm4g
PGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMuIE1pbGxlcg0KPiA8ZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IFBhb2xvIEFiZW5p
DQo+IDxwYWJlbmlAcmVkaGF0LmNvbT4NCj4gQ2M6IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVr
c2FuZHIubG9rdGlvbm92QGludGVsLmNvbT47IFBldHIgTWFjaGF0YQ0KPiA8cGV0cm1AbnZpZGlh
LmNvbT47IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+OyBBcmVuZA0K
PiB2YW4gU3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPjsgTWFyY28gQ3JpdmVs
bGFyaQ0KPiA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT47IEtlZXMgQ29vayA8a2Vlc0BrZXJu
ZWwub3JnPjsgSmFrdWINCj4gS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFNpbW9uIEhvcm1h
biA8aG9ybXNAa2VybmVsLm9yZz47IG9zcy0NCj4gZHJpdmVyc0Bjb3JpZ2luZS5jb207IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNYXJr
dXMgU2NobmVpZGVyLVBhcmdtYW5uIDxtc3BAYmF5bGlicmUuY29tPg0KPiBTdWJqZWN0OiBbUEFU
Q0ggbmV0LW5leHQgdjMgMS8yXSBuZXQ6IG5mcDogRHJvcCBQQ0kgY2xhc3MgZW50cmllcyB3aXRo
DQo+IC5jbGFzc19tYXNrID0gMA0KPiANCj4gV2l0aCAuY2xhc3NfbWFzayBiZWluZyB6ZXJvIHRo
ZSB2YWx1ZSBvZiAuY2xhc3MgZG9lc24ndCBtYXR0ZXIgYmVjYXVzZQ0KPiB0byBjaGVjayBpZiBh
IHBjaV9kZXZpY2VfaWQgZW50cnkgbWF0Y2hlcyBhIGdpdmVuIGRldmljZSB0aGUNCj4gZXhwcmVz
c2lvbg0KPiANCj4gCShpZC0+Y2xhc3MgXiBkZXYtPmNsYXNzKSAmIGlkLT5jbGFzc19tYXNrDQo+
IA0KPiBpcyBjaGVja2VkIGZvciBiZWluZyB6ZXJvIChzZWUgcGNpX21hdGNoX29uZV9kZXZpY2Uo
KSkuIFNvIGRyb3AgdGhlDQo+IHVzZWxlc3MgYW5kIGlycml0YXRpbmcgYXNzaWdubWVudCBmb3Ig
LmNsYXNzIHRvIG1hdGNoIHdoYXQgKEkgdGhpbmspDQo+IGFsbCBvdGhlciBkcml2ZXJzIGFyZSBk
b2luZyB0aGF0IGRvbid0IG5lZWQgdG8gbWF0Y2ggb24gLmNsYXNzLCBpLmUuDQo+IHNldCBib3Ro
IG1lbWJlcnMgdG8gemVyby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmln
IChUaGUgQ2FwYWJsZSBIdWIpIDx1LmtsZWluZS0NCj4ga29lbmlnQGJheWxpYnJlLmNvbT4NCj4g
LS0tDQo+IEhlbGxvLA0KPiANCj4gdGhlIGVxdWl2YWxlbnQgb2YgdGhpcyBwYXRjaCBnb3QgYSBS
ZXZpZXdlZC1ieSB0YWcgZnJvbSBBbGVrc2FuZHINCj4gTG9rdGlvbm92LiBBcyB0aGUgcGF0Y2gg
Y2hhbmdlZCBob3cgaXQgbG9va3MgY29uc2lkZXJhYmx5IGR1ZSB0bw0KPiByZW9yZGVyaW5nIHRo
ZSBwYXRjaGVzIEkgZGlkbid0IGFkZCBpdCBoZXJlLg0KPiANCj4gQmVzdCByZWdhcmRzDQo+IFV3
ZQ0KPiANCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L25ldHJvbm9tZS9uZnAvbmZwX21haW4uYyAg
ICB8IDE2ICsrKysrKysrLS0tLS0tLQ0KPiAtDQo+ICAuLi4vbmV0L2V0aGVybmV0L25ldHJvbm9t
ZS9uZnAvbmZwX25ldHZmX21haW4uYyAgfCAgOCArKysrLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL25mcF9tYWluLmMNCj4gYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL25mcF9tYWluLmMNCj4gaW5kZXggNDgzOTBiMmZk
NDRkLi4yZGQ4ZmYzMzBmZDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L25l
dHJvbm9tZS9uZnAvbmZwX21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9uZXRy
b25vbWUvbmZwL25mcF9tYWluLmMNCj4gQEAgLTM1LDM1ICszNSwzNSBAQCBzdGF0aWMgY29uc3Qg
Y2hhciBuZnBfZHJpdmVyX25hbWVbXSA9ICJuZnAiOw0KPiBzdGF0aWMgY29uc3Qgc3RydWN0IHBj
aV9kZXZpY2VfaWQgbmZwX3BjaV9kZXZpY2VfaWRzW10gPSB7DQo+ICAJeyBQQ0lfVkVORE9SX0lE
X05FVFJPTk9NRSwgUENJX0RFVklDRV9JRF9ORlAzODAwLA0KPiAgCSAgUENJX1ZFTkRPUl9JRF9O
RVRST05PTUUsIFBDSV9BTllfSUQsDQo+IC0JICBQQ0lfQU5ZX0lELCAwLCBORlBfREVWX05GUDM4
MDAsDQo+ICsJICAwLCAwLCBORlBfREVWX05GUDM4MDAsDQo+ICAJfSwNCj4gIAl7IFBDSV9WRU5E
T1JfSURfTkVUUk9OT01FLCBQQ0lfREVWSUNFX0lEX05GUDQwMDAsDQo+ICAJICBQQ0lfVkVORE9S
X0lEX05FVFJPTk9NRSwgUENJX0FOWV9JRCwNCj4gLQkgIFBDSV9BTllfSUQsIDAsIE5GUF9ERVZf
TkZQNjAwMCwNCj4gKwkgIDAsIDAsIE5GUF9ERVZfTkZQNjAwMCwNCj4gIAl9LA0KPiAgCXsgUENJ
X1ZFTkRPUl9JRF9ORVRST05PTUUsIFBDSV9ERVZJQ0VfSURfTkZQNTAwMCwNCj4gIAkgIFBDSV9W
RU5ET1JfSURfTkVUUk9OT01FLCBQQ0lfQU5ZX0lELA0KPiAtCSAgUENJX0FOWV9JRCwgMCwgTkZQ
X0RFVl9ORlA2MDAwLA0KPiArCSAgMCwgMCwgTkZQX0RFVl9ORlA2MDAwLA0KPiAgCX0sDQo+ICAJ
eyBQQ0lfVkVORE9SX0lEX05FVFJPTk9NRSwgUENJX0RFVklDRV9JRF9ORlA2MDAwLA0KPiAgCSAg
UENJX1ZFTkRPUl9JRF9ORVRST05PTUUsIFBDSV9BTllfSUQsDQo+IC0JICBQQ0lfQU5ZX0lELCAw
LCBORlBfREVWX05GUDYwMDAsDQo+ICsJICAwLCAwLCBORlBfREVWX05GUDYwMDAsDQo+ICAJfSwN
Cj4gIAl7IFBDSV9WRU5ET1JfSURfQ09SSUdJTkUsIFBDSV9ERVZJQ0VfSURfTkZQMzgwMCwNCj4g
IAkgIFBDSV9WRU5ET1JfSURfQ09SSUdJTkUsIFBDSV9BTllfSUQsDQo+IC0JICBQQ0lfQU5ZX0lE
LCAwLCBORlBfREVWX05GUDM4MDAsDQo+ICsJICAwLCAwLCBORlBfREVWX05GUDM4MDAsDQo+ICAJ
fSwNCj4gIAl7IFBDSV9WRU5ET1JfSURfQ09SSUdJTkUsIFBDSV9ERVZJQ0VfSURfTkZQNDAwMCwN
Cj4gIAkgIFBDSV9WRU5ET1JfSURfQ09SSUdJTkUsIFBDSV9BTllfSUQsDQo+IC0JICBQQ0lfQU5Z
X0lELCAwLCBORlBfREVWX05GUDYwMDAsDQo+ICsJICAwLCAwLCBORlBfREVWX05GUDYwMDAsDQo+
ICAJfSwNCj4gIAl7IFBDSV9WRU5ET1JfSURfQ09SSUdJTkUsIFBDSV9ERVZJQ0VfSURfTkZQNTAw
MCwNCj4gIAkgIFBDSV9WRU5ET1JfSURfQ09SSUdJTkUsIFBDSV9BTllfSUQsDQo+IC0JICBQQ0lf
QU5ZX0lELCAwLCBORlBfREVWX05GUDYwMDAsDQo+ICsJICAwLCAwLCBORlBfREVWX05GUDYwMDAs
DQo+ICAJfSwNCj4gIAl7IFBDSV9WRU5ET1JfSURfQ09SSUdJTkUsIFBDSV9ERVZJQ0VfSURfTkZQ
NjAwMCwNCj4gIAkgIFBDSV9WRU5ET1JfSURfQ09SSUdJTkUsIFBDSV9BTllfSUQsDQo+IC0JICBQ
Q0lfQU5ZX0lELCAwLCBORlBfREVWX05GUDYwMDAsDQo+ICsJICAwLCAwLCBORlBfREVWX05GUDYw
MDAsDQo+ICAJfSwNCj4gIAl7IDAsIH0gLyogUmVxdWlyZWQgbGFzdCBlbnRyeS4gKi8NCj4gIH07
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL25mcF9u
ZXR2Zl9tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL25mcF9u
ZXR2Zl9tYWluLmMNCj4gaW5kZXggYjU2NDZjODg0MzcxLi4yNDE0YmNkMzE5YjEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L25ldHJvbm9tZS9uZnAvbmZwX25ldHZmX21haW4u
Yw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9uZXRyb25vbWUvbmZwL25mcF9uZXR2Zl9t
YWluLmMNCj4gQEAgLTQwLDE5ICs0MCwxOSBAQCBzdGF0aWMgY29uc3QgY2hhciBuZnBfbmV0X2Ry
aXZlcl9uYW1lW10gPQ0KPiAibmZwX25ldHZmIjsgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2Rl
dmljZV9pZA0KPiBuZnBfbmV0dmZfcGNpX2RldmljZV9pZHNbXSA9IHsNCj4gIAl7IFBDSV9WRU5E
T1JfSURfTkVUUk9OT01FLCBQQ0lfREVWSUNFX0lEX05GUDM4MDBfVkYsDQo+ICAJICBQQ0lfVkVO
RE9SX0lEX05FVFJPTk9NRSwgUENJX0FOWV9JRCwNCj4gLQkgIFBDSV9BTllfSUQsIDAsIE5GUF9E
RVZfTkZQMzgwMF9WRiwNCj4gKwkgIDAsIDAsIE5GUF9ERVZfTkZQMzgwMF9WRiwNCj4gIAl9LA0K
PiAgCXsgUENJX1ZFTkRPUl9JRF9ORVRST05PTUUsIFBDSV9ERVZJQ0VfSURfTkZQNjAwMF9WRiwN
Cj4gIAkgIFBDSV9WRU5ET1JfSURfTkVUUk9OT01FLCBQQ0lfQU5ZX0lELA0KPiAtCSAgUENJX0FO
WV9JRCwgMCwgTkZQX0RFVl9ORlA2MDAwX1ZGLA0KPiArCSAgMCwgMCwgTkZQX0RFVl9ORlA2MDAw
X1ZGLA0KPiAgCX0sDQo+ICAJeyBQQ0lfVkVORE9SX0lEX0NPUklHSU5FLCBQQ0lfREVWSUNFX0lE
X05GUDM4MDBfVkYsDQo+ICAJICBQQ0lfVkVORE9SX0lEX0NPUklHSU5FLCBQQ0lfQU5ZX0lELA0K
PiAtCSAgUENJX0FOWV9JRCwgMCwgTkZQX0RFVl9ORlAzODAwX1ZGLA0KPiArCSAgMCwgMCwgTkZQ
X0RFVl9ORlAzODAwX1ZGLA0KPiAgCX0sDQo+ICAJeyBQQ0lfVkVORE9SX0lEX0NPUklHSU5FLCBQ
Q0lfREVWSUNFX0lEX05GUDYwMDBfVkYsDQo+ICAJICBQQ0lfVkVORE9SX0lEX0NPUklHSU5FLCBQ
Q0lfQU5ZX0lELA0KPiAtCSAgUENJX0FOWV9JRCwgMCwgTkZQX0RFVl9ORlA2MDAwX1ZGLA0KPiAr
CSAgMCwgMCwgTkZQX0RFVl9ORlA2MDAwX1ZGLA0KPiAgCX0sDQo+ICAJeyAwLCB9IC8qIFJlcXVp
cmVkIGxhc3QgZW50cnkuICovDQo+ICB9Ow0KPiAtLQ0KPiAyLjQ3LjMNCg0KDQpSZXZpZXdlZC1i
eTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

