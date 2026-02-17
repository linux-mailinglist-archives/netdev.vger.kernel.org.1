Return-Path: <netdev+bounces-259090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBJHAYeVlGneFgIAu9opvQ
	(envelope-from <netdev+bounces-259090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:21:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55614E110
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D2923030B0A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD70036E47E;
	Tue, 17 Feb 2026 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OwLzuB0x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185502DB7A1;
	Tue, 17 Feb 2026 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345277; cv=fail; b=pOzFo2M+LI1ittJL/gjGHweQf+AniyVNzbs9owUi7wr7bX526QFqAgJrnWX7IsBpe/mAAxkOI3pIKFL8FWY3C0Rl2affebNW2WzH51eD5CFgXYyLEgcf7W948cxV06mN+Um3Zgohn8pYsJyHezdhfm+oQLncBfvqBGsImeUJJjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345277; c=relaxed/simple;
	bh=Jqd1ICiMlTAPo4mQPbXtfkfQuSuIl6ZZERtzswnd1WI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X0lIMWZcrP1lYSG5rNgetvhBY/Rlqr26vFuTf40qGZisrvvZFY3yv0QX29MzRXQKv/giLvT/aJHcdDkUNnIhJ9QA+YC/K8NKRvh69/gQ4YVqMHnNdBQe5ChqyiCkr1Hh2xO6Kt6uqy6IFOxCyk2ABYNEEw8ayGMB7uBYvolvarE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OwLzuB0x; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771345275; x=1802881275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jqd1ICiMlTAPo4mQPbXtfkfQuSuIl6ZZERtzswnd1WI=;
  b=OwLzuB0xClKCbWW9BiS7GZgnDPeUtqXKFOnr7Z75mzqqIZIz6BaugfeI
   Hgim+/U9aYZJIsNLp4/O03POPI87rexWNKWRiIJ+68VYuVKMcZL1oOgt5
   OFihxuZUwH+wp3g7EL+JEMG54JUo4HYDmA/GdwlXz3lUZVYeLhBMcQXBE
   BP9dsCmdbTvbUh0eV/jWTUFK1NXztAqozZEJocI4JMjlG/1SOhM5ahvHn
   t5atKYlBYu7VEpGmrJR1AbO10autkOXAcj2nUyTppNiRqMG0/9WSiownH
   /Oa3AbXv4iPkbDdcZ5cuUjUPleA0eLqmQVW6991rT01Xkm+719A/xvlwQ
   w==;
X-CSE-ConnectionGUID: Ip0b3HBmTlCRtXjUjk/0Yg==
X-CSE-MsgGUID: rydvGT8MSViSS1MpBISXIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72407583"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72407583"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 08:21:15 -0800
X-CSE-ConnectionGUID: AKYTvGbnR0i7/K31mPj+dA==
X-CSE-MsgGUID: Ld5Z6Bv1SJOsV/oZIkrZQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="213765198"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 08:21:14 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 08:21:13 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 08:21:13 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 08:21:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8Whkia9i7gXkBRP9Vyh6tjc/vsDrHCHxinTYrl03xNyPEQ+PhrNzMy6PyS1hPBY3nunZ6+KUTKuFdh3k0I+1mkEAaMigAjJqRCmUSuHcVZltgpRSruDzRomrJCwVWoCDDwEIvLndosxMmtyZJTE0ISTMXqiZ7YYT2fG+sw++zz2V3YBuOLfJYCOQGTctlwITu9Msa/P1KEhh6R7903qXI6KpEzTYrTdE60vVUdKi3H1hRFKp0+x+YFQEgYKFUl0pThkII24YAD0BpEW0ekqyws5pv+iv9FjnyPqAoQ4o4HbxxLCU/3RLiOKhO4xyisdGKfZOFZg94V89gx8am8yaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqDprMxTyn8r3b/jg4DYvOSG4kSRMpq5NkvqiqDGYs8=;
 b=jkTifV6qPjiHrc73M32ZUDUflpFcVn8cc7MRoy7XuNtL4T4rgwA2ArXLArFaDV/D0Sy0m0gbF0tB97MZFXGrJVcZzjikcDlTVIae/lks8sEIAmiAd5HJC1jBDOka6FPZ6xf43jNg0AZ/Kx0Oqd8lgn5hFIb4vvAuHrprYwgKdRHYr1yc4uPD6uw2gEl+rBC6Wfp+naCCQ6iGQYcz1l9P/DDlA1Uwun2IWS2yJbEUxcXG7kIBzpO7128qr+2MxpOQmAnyI4M+0n9rgXM7a1r/iCGPhJoDAoJke3+DdkFS7x4zFN8iSlCa1xsIAnbUHONQUrmulZwm5omPvG3oQa65Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 17 Feb
 2026 16:21:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 16:21:08 +0000
Message-ID: <6c1c575b-9f47-446c-ba91-8491c1211670@intel.com>
Date: Tue, 17 Feb 2026 17:19:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 7/9] libeth, idpf: use truesize as XDP RxQ info
 frag_size
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <bpf@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, "Vladimir
 Oltean" <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Andrii
 Nakryiko" <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Simon Horman
	<horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, "Bastien Curutchet (eBPF Foundation)"
	<bastien.curutchet@bootlin.com>, Tushar Vyavahare
	<tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>,
	=?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>, Eelco Chaudron
	<echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "Toke
 Hoiland-Jorgensen" <toke@redhat.com>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kselftest@vger.kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20260217132450.1936200-1-larysa.zaremba@intel.com>
 <20260217132450.1936200-8-larysa.zaremba@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20260217132450.1936200-8-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: e37919ab-73ce-44ec-9797-08de6e408e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGszazdqMlk0ZmNkQUt2STFKRklXbnRNKzE2eFV3eVVlTjBPOStXVnlnQksr?=
 =?utf-8?B?bFBCNmNPN3U5Qm9rZ1dIOVFnQ0hFSWp0dklTbHd2eCtBbjBWcDl3d1UzekZG?=
 =?utf-8?B?RDNQTEI0NkNzU3RGQytVZGlCT2JNZ3BndnNra25oKzh3MkZxaXZoZ3JkYmlk?=
 =?utf-8?B?dVA3aXlhWWVMSE9kQlRUU0NoVkpVNGtDcC8rbGxrV2J4MExseStuMVlvbTVr?=
 =?utf-8?B?a3ZscWdtdHZLRUJpaFFLc1lzdlFwYlR1SkYybURWaEltTllFQU5uT2NGSEgy?=
 =?utf-8?B?bXBzWXJrS1ZPZk9FTXE3ZWcyUUtVb2I2MzM0cVByUk93eXVWcUtjdWFFTVpU?=
 =?utf-8?B?K3M1TEN1elVYY3lISWh1MTh6djBqcG9FS0lWTXRxWER2M04rUTBQSUZTMVFk?=
 =?utf-8?B?c3NJVFlFOTkwZ2dzVmZRck54aWdpZG91WDhpa3IvVW1HNEZ2bnZweVNwT0tH?=
 =?utf-8?B?TnNuZDZmOTRkMmpPeFlLTlhTRGZpdnpJYit4WmVqSk5UN3g0UUdmalFNcUht?=
 =?utf-8?B?bUJOYkZMOHZzTE1TTmZianNhN3J6OWlIL2FQOFR2T1VlV3RUK3lKd0R1ZFFE?=
 =?utf-8?B?N3pHeFRtbzlybDBJb2wxc2FYMTdncUZBei9lQkV2SXY2Qmc0dVluN0ZETDZG?=
 =?utf-8?B?c2l1YkhiUzBkaFE2QVRLWDhHT29VQThoN3V6Z0pWOVdtYjhOaVdQQk1xbzUz?=
 =?utf-8?B?a2RETlhudEVuZi92aGFqcHFLVHEzNU9CSHhTNk8rcGJIY3FScHIzaGgzOFJW?=
 =?utf-8?B?TVhGam9yRmkvaCtuY2liTXAwd2o0N01qVFRxdCtMR3BNUjhhYlBvY2FZUE4r?=
 =?utf-8?B?djZoT1hpYUIwVXFydXBySmdlSWd5MmlVVlpqeDByRGVPR1cyT1pkQ2pEcTFJ?=
 =?utf-8?B?MC9vWkdpSENtQ0hCaS9zaFErbFZETHpXMDlJazdzQzRFNHdYYkU5aUdoSUh6?=
 =?utf-8?B?T1lHWGcxaENRVDhnREFFMm8wK0NyblkzeHNnWXRjbDJaSlhselNJV085emMw?=
 =?utf-8?B?WGZQT3YzTHkvNmE2TXhqbXlSemZpa2FhSlpKczhkVzFlQjU4SDh6UGlXbldM?=
 =?utf-8?B?cmo1cGJUaGFoRENOckxwY0V2bExrL293Mi9WY05DUm10WGxRZFRSUm0zd3FO?=
 =?utf-8?B?YWlLenVhb01WRE1TVktkaWw0S1BFNmladVQ3b2FZZFhjc0Vsd2pQMG9uTGZh?=
 =?utf-8?B?cHluS0NTbnFiRVppYlE3ekJKb0poVHQ5WDBGUHBaVUsyQThMVGZFQXVkcmxv?=
 =?utf-8?B?ZjBmc3BSdmJkU3hNMWxyaVV4a2kvTnFMN09aQURGV09PYUttU1lvQU5aRTNP?=
 =?utf-8?B?OWgzRVBzdTI5VllUeFVpbEx2OU9BR1BIZ1BGTG82WEdocERpRVBVck5Sczd0?=
 =?utf-8?B?WTRkbUZqdGh1TlpoUjE0RTdNeGZrL3ZrZlBCV0gzYXVZZ2svU3lFTW93NStO?=
 =?utf-8?B?Y3VmZER0V2oyR0NWZDBqVzJhMzZ3b0lHVUh5UG5mbTBNYTVPOTIvdi9WdmVl?=
 =?utf-8?B?d0lHNVlkLy9YenNoKzl5S01uQ2lBejZFbEhDVnBmWWx4WlYwbFVYck54SS91?=
 =?utf-8?B?a0FLL09xeTBIcGk4WTl2VXp2UjUrV2xQQ2dpd0l6MVJ6VCtQMnR3am83MHdY?=
 =?utf-8?B?V2cyeEZPTkwxbVI3ZkRkZk1xUUhDRFlMT3g2NmFPZWZFeW82eS9kTWFhakRH?=
 =?utf-8?B?SFFBY25McllRU281c3AxbVQ5dzZiclV6MTYzcC9FZkNEQmIrR1Y2cTVLZkVy?=
 =?utf-8?B?QVBxMUhKRERwczdFNHRaMENoNWtLVzBPZ2U5V2NMaGYrTnYxOUN1Y28rNXpL?=
 =?utf-8?B?d0V5Vm5meHFEampmQ0E4SmhIL3QxeElBbmV5MzdhSDdhVTNiYlVtSlI4Yk56?=
 =?utf-8?B?anN6M01kd0tIQlVwL2lhNzFFS25Db05FQ0pXcExZeDVKdFVJMDNaY1RlUVdw?=
 =?utf-8?B?VHkrR0U1Vi9LNkswY0h5WlN6NUphMHBkSUdubExzZ1ovSHhsMCtEaHFFbjBN?=
 =?utf-8?B?SEJXRm9nVysxQnRQMjgzYWJQMUVTQ3pZTlpyV1hmdytmOWlMTTBqN1R2OGFz?=
 =?utf-8?B?OWIzTEFDbUY5OHgxaWxabHNueTlnY3Zvd0xheFk5cHpyN05GUEZjZ2p1ektH?=
 =?utf-8?Q?7t5Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlRKOVMwSU1QSWVrL3VtelRVcmZBZ1FvRXc2M2E5Z1BZQXpLaHpvUHMyR1Rs?=
 =?utf-8?B?NE5mTXVSdUl2eUF0RFJmTHZpRWN2cG1HdXJxTVUyS2Fyc3pxdHY2SUU1RWFx?=
 =?utf-8?B?cGNsRW5jL2FHcjFQQy85TVlFUjREeFBHT3QybWczS0xDOVZOZGpLYzVGN0Na?=
 =?utf-8?B?dThJMUJtK3l2UUpmcnlSZWx1R0lBYUFLeXE0UlVsRk41OW5MUlhpbjZGOGxr?=
 =?utf-8?B?ZzVmZnZKSFhmVk9kMVIrWGN3czAzZHlWTUFGWW1VVEcxZHp4L3dicDRLNmhZ?=
 =?utf-8?B?VzVJeExVRi9DL1lGMTdkVS9OYWJ6aC80R1RFQk1SN3JhZWtnQmh4VUF0VGM1?=
 =?utf-8?B?b0JudE1Uc1pNbGluV2pxWFlxZzJncjNscEpDRkptSU9wblBBRlF3MS9nZG93?=
 =?utf-8?B?UnhpVml1OGlYa1hTRlNkcjRzUDFmdUhyTm9UVEZMZUUvYjN4WTRXbTFIZE5j?=
 =?utf-8?B?cXFZOWZwSVM3WXhYa0NYTW53RGNhb0dkeXA3WFc3OTd3N2FqdldnM241dys2?=
 =?utf-8?B?TUZqVnJUTmZyNmNEcEpseSswY1A5Z1VHSEhhUDNPdHcvYklTR2l2NVBSUFJJ?=
 =?utf-8?B?cnRBN2dWZ2RqVzQ1ZWtpMWk1NHNDQXNCNlVCRlNsNVUyRFBmVVZ5TzQwbWVt?=
 =?utf-8?B?amttSlEwM25lVTdlZHlScDZyM09oRzRGOEpkUTVQOGlvUk9yWWJIRW1ya21x?=
 =?utf-8?B?S2U0QjFrcnpQZytnYSs5NnVBRzExT1Zab3h1ZEcvaFh1ejRTanFxamlzQ2lB?=
 =?utf-8?B?VTZPUlJ4Q1dGNW9jU2RySDJpZzM1ZVlqTVE0WHgzc0RndTUwQUpPZnVoQzRK?=
 =?utf-8?B?dkI4aTB1cUtWQmFkVWNNVEtZKy85c003NFQwZXZXL2tQOFJXcWJ5ZmFhMFdN?=
 =?utf-8?B?RzhNS014MTR5OTVJeEQ2L0o3aHNXa2hpK09BNE5rZVU0TUdoeTkvakJiNEV4?=
 =?utf-8?B?d215RlBkNGVuRDY3aTVoQktjb2tOdDU0ZGYxbExUbmlDa2tFQ1lROVNuMXN0?=
 =?utf-8?B?S1ZzS2wrMUdTRkpMai8weHBZaHozUldlMWhjcDNwdnlDV1laWFV1SExKMk1j?=
 =?utf-8?B?OHkweG1TckFTYXFzRFg4UEFIdS9QVWxlNkpMRlh5MUNEZ28xVElJVkdWckd1?=
 =?utf-8?B?bzhBSTRqZVF4OVdqTVhaSk8ybVNKalQzcWE2VzlnTmRWcURYdFMzZWNtUVkz?=
 =?utf-8?B?bkMyTjdldjNGb1JqTW4xU29vTFh4QWFGdGpRVGVQMUo5UzR2cjFzSldaRFVs?=
 =?utf-8?B?V0c5NVJmYmVZN2FTaHM4MDlNNUZnM3BkemxsQWk3VEVKbmJ1NHdFbDk2MzBj?=
 =?utf-8?B?RUxoOUZxaDFQZ0JvV0JReWd1bzVYdWhuV2xnZWJlVjZrbmFKL21aY1VrUE05?=
 =?utf-8?B?bk1tUk1ab1UxSUUxNlRnTVNZTmdnT1AvREJTa3hMaXFTNUVmZ3JUM1ZtK1pW?=
 =?utf-8?B?cDJIZkpOZ2dubHVVN3ZuQXlMWDBqcm9jRnduTDRhdlRaMElKN3gya1c4RkFt?=
 =?utf-8?B?UHppdkFaZzlQSjgwaGNmUVAxbGlPSk9WMkxTKzUvN2twQzBsa2pOUUFRMWlt?=
 =?utf-8?B?TzhvQUswK280ekoxaDFWOWhtbEUydVlUZlNyNyttTWhQK2N3bWpnMjdpYmtD?=
 =?utf-8?B?WkFLaFF2Y3FCSUlBNUdweGlyeDRYQ1NkeVpET3VXQzl2V0JSTURXN0hwOENN?=
 =?utf-8?B?NXVCY0V2KzM3cHV3Q01JZXNBSzBqdUIxU3p6NlptU0pheG9FQTNWaEltOGM3?=
 =?utf-8?B?U3ZKRnRKMTZVNjNCdEw0dmJMK1piazZEZ2pSTkFteVozZkNUNWFjVGZJR3Yx?=
 =?utf-8?B?bjdURmdTRlpZSjJnSkZsSjRhc0J5a0k4ZkROejFOYlRMYUI1NCtMT2ZrWUhE?=
 =?utf-8?B?NFo1S3N1K3poRFNjazBtMlR5aGZOY2tQT3pGRktRcUozMGFOQ2dhZ0VUOE95?=
 =?utf-8?B?TWMyQzZ6L2dQR3FsNlBFajNnTjBkanFJcHVhZHNRd1FiR3NNakx5SEthOUll?=
 =?utf-8?B?bUdnV2krdmFQZm5yWXV3ZTRXdlMvTDJtdzl3bUU0VWl4WGdXT0VZSVF2SjNF?=
 =?utf-8?B?MlhiUVhGU1pvVDRSYWllMW56UGI5cFpoVTB0emMxdEUrZ0dOaG5WL3JROGta?=
 =?utf-8?B?bHo5OEdTUVo5dnRscVM2QUFzLzZ0enpZZDNZVWxubEVWVlhTbmd2Mmtwa1U3?=
 =?utf-8?B?UG9ySGllM2JkU0RYVFR1ZnRBSEhON1ZJbi9OUTZ0THJvTExld0duYzFoYWRv?=
 =?utf-8?B?eTI4WDhFblBiK0xJMXFMbGt1QWtDUEd3dTRwZjVtenVMT0Ewd1ZTSi9UNVcr?=
 =?utf-8?B?VFJ0VmlEUG9xRVhLOTdzYjlrMUMzYXZkdGREZDN5V0pTVEgxV3kweFkwQW82?=
 =?utf-8?Q?zwq+F6RrOUXAXLHM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e37919ab-73ce-44ec-9797-08de6e408e09
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 16:21:08.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXZVvLQ1YCK7gRZn1aKLPkGbEKZWDIlPnIUWs2cLuv6PBQyszzbmb3lp+XRUVFJQJZD9afs3Q54QeJVWiQWhSwkDA4gw4BLPamLtUQIqZbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5861
X-OriginatorOrg: intel.com
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
	TAGGED_FROM(0.00)[bounces-259090-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org,nvidia.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5D55614E110
X-Rspamd-Action: no action

From: Zaremba, Larysa <larysa.zaremba@intel.com>
Date: Tue, 17 Feb 2026 14:24:45 +0100

> The only user of frag_size field in XDP RxQ info is
> bpf_xdp_frags_increase_tail(). It clearly expects whole buffer size instead
> of DMA write size. Different assumptions in idpf driver configuration lead
> to negative tailroom.
> 
> To make it worse, buffer sizes are not actually uniform in idpf when
> splitq is enabled, as there are several buffer queues, so rxq->rx_buf_size
> is meaningless in this case.
> 
> Use truesize of the first bufq in AF_XDP ZC, as there is only one. Disable
> growinf tail for regular splitq.
> 
> Fixes: ac8a861f632e ("idpf: prepare structures to support XDP")
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks for handling this!

Olek

