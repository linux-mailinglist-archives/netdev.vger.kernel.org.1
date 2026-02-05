Return-Path: <netdev+bounces-257155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHLKNbSQhGkh3gMAu9opvQ
	(envelope-from <netdev+bounces-257155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:44:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 572ABF2BFE
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49B77304CB59
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E33D3D0B;
	Thu,  5 Feb 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dzr7jibM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA33D3CE5;
	Thu,  5 Feb 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770295282; cv=fail; b=N3Srdb23wG9w5fL0Sh75vK30g1N1Hc4Ekj+HcD1E+f1XBsNe/0c0busqnpZNnxtdslrIxwbYnhCv40TtGTsfNIyERsbe8WVNFKT9BPE85FEDUnrpUsHxsSoYvVHIPayLoxO2a39DW3vsOXR04Ve1strmRyomw60OJ3EzaIrRBgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770295282; c=relaxed/simple;
	bh=BpF7bQZ0CJzPl24NBrjvWVOI1F2AiPcXX+gFonKYesw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kDOeMpzMNNl0KR8FTLr72f7jhGSaTQ95LCCZTZiAJYWLq89jrNXqJZdheWev/15gio/ifK9iwrmAVr37X4xCkdFqnicbvww0Du+nR+Y7EvvbO+GSULTrZ6hUiAv3Uuz4J5l2MgaTfdS6+4yCuVx64N6uq7lgXpTEBvEoXInYkXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dzr7jibM; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770295282; x=1801831282;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BpF7bQZ0CJzPl24NBrjvWVOI1F2AiPcXX+gFonKYesw=;
  b=Dzr7jibMe3AXzpReAA5KPMOD2go1LwfOhv6FBoffa9agLFxuIwhi0GD6
   FCxEzi7ITWVTBeSyZ4gpapIfrBlnIGD2B0BoH/A2368AgXbPQ4fikSiTC
   a5IQKhepVCnSUs5/JRF7nK9a5Ib5ejJhpdiUwbZDO63ydglxJGENSJ/P1
   4JbKKViHROpO6Rwvl0blw++VHswOuaRci6wQayN+Cb2tu9QOvqazRN5st
   0VfP/230lt2QV/YHWJj7SS4aYR45GijsKtoKosS/o7vvgz5Tj+Cavh5xP
   0/gpwdAiU0xE292Nu5pmRZPMjmVni/ljoN64HNcnMx6Vu80Skm8QAOOd/
   w==;
X-CSE-ConnectionGUID: HlnlCzZtRYS7WKfDbd4boA==
X-CSE-MsgGUID: 8yOfi90QR5WxYhAcXX7gYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82861947"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="82861947"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 04:41:21 -0800
X-CSE-ConnectionGUID: 4bryPGE+S0K7PHl+K/344Q==
X-CSE-MsgGUID: woVsrA1RS7SeZC1Hov47cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="241181176"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 04:41:21 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 04:41:21 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 04:41:21 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 04:41:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfHRsjx1nHh9GawXq6GVYb9LB2OV9Co+hqGcSFii0Oq+kGzvkn6C/6uZmNm5Muum0qQmlIRBj1V3QNeD8eA7/pm5fSQ0R+AmhGuniL61FvihkdCuKoGEJvJISc091z/+FTYEwWyjvDz26ZAL7wvYS+BVZmaFmPixI3TG3Heec4IyWduJzcHMk3jEZ/rHHThKj4RSQyFQvzxIOILpO4NuykqAZtiGC/4QQSH1ekXuj+bVeYYx2imyT9+GZhAtOKT7/XEyhc6If8FGc4Qn2m10tXF7ZeoyOooMZti6xvo5BnnUNw5kCEoxLmWa0yh87eyut0SZOKjSArQeNHpwTj6RsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX17tvnhQb6/ss1TVQ8V5/raU5Qzzql1hRv7pzr2muU=;
 b=cUiKD0w3JeEHWxEALr65WFUyX3BwkgwcbrEq13PGl/Fx9Og9BOMYJNkNp4g1+qByB/CAuZQqzB0lc9DnBhCjg3yCyxl1fhzIROUjIPEqP8H499J6wRl55EWGqBKMi1FW3MLw1ovE9RrazvSGtn8v9DXkHwbtLRLrsYaV6L2RzHLBwdvVBsO8x3uusMLtzxK95Lv2tq8/FxRUfEyX3ANmAVnD6SCvtolOwd6kneV1g/Na6fG6Q4SYhYhVAYixqm+K8Uf9jKn0Be9Z57fsZIP2EN78W65Y8WiQ4dzyc7nopjC1p5nVysPTzqbz9OzXcIBtc/D9JI0CO8+1xYIuMAS4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CH3PR11MB8416.namprd11.prod.outlook.com (2603:10b6:610:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 12:41:16 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%4]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 12:41:16 +0000
Date: Thu, 5 Feb 2026 13:41:03 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: <bpf@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang
	<wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Andrii
 Nakryiko" <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Simon Horman
	<horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, "Bastien Curutchet (eBPF Foundation)"
	<bastien.curutchet@bootlin.com>, Tushar Vyavahare
	<tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>, Ricardo
 =?utf-8?B?Qi4gTWFybGniiJrCrnJl?= <rbm@suse.com>, Eelco Chaudron
	<echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "Toke
 Hoiland-Jorgensen" <toke@redhat.com>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kselftest@vger.kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH bpf 6/6] net: enetc: use truesize as XDP RxQ info
 frag_size
Message-ID: <aYSP344FT-JlylwY@soc-5CG4396X81.clients.intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
 <20260203105417.2302672-7-larysa.zaremba@intel.com>
 <20260205005901.gnju3zmqimtgeu2b@skbuf>
 <20260204173401.282899d0@kernel.org>
 <20260205122953.lscemcctayrvszdu@skbuf>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260205122953.lscemcctayrvszdu@skbuf>
X-ClientProxiedBy: VI1PR04CA0055.eurprd04.prod.outlook.com
 (2603:10a6:802:2::26) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CH3PR11MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: e535b072-fea0-46bf-2fc1-08de64b3da9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5CMrmQ2zfPotDyTASP2iv85TDHy8AF83qSrGG5+qzYS0XEbIbCieOWSG3Gmo?=
 =?us-ascii?Q?TDm5MY+ANdRkOmSFnvSsex6EZcsP+OaFh7dfI/NvRxwKxMAe2V+ZRGuRukjc?=
 =?us-ascii?Q?xFYGbsdts/R687I+iVc4LKIw4Atw2gc8zZ641VIJ1MLYgTmkKnu0HRaOkPB9?=
 =?us-ascii?Q?odMskmFX/fyfREy1nfdxWWCz7K2+EOCmDiJLx3s7G09+9TFCzAC+tc7TXpYF?=
 =?us-ascii?Q?EDn5w2UroVfX24h7KoUUzpySvL/kTJNDfZH8bgA32neS87sjBo/BMq6C4k15?=
 =?us-ascii?Q?W7TPE4p3Wn6n6xl84ml1S6tbjOkBsl3Q74HYe3ovZ5EGuC/JGfA7Cu3W72MS?=
 =?us-ascii?Q?MbiyzDUbQRiSKU4w0Mqht627ZE7SlXXOPWbtyHbqFMeLw41oktxsTl/FVl0e?=
 =?us-ascii?Q?OtpMJRryBnhyA8/CfR6rZuqn3TX2KTHQ3LZ6j36mvO+nxCMlx+Ntt5OLE363?=
 =?us-ascii?Q?pERN8fdGoTrdy7YGKtKaDvv3cz3qSIEkjFgtm7J73QDnR+aAkut9qhJVMRou?=
 =?us-ascii?Q?gEZeYyWwX8OcJ4svz+tHQtakFX5l3lTIusqiKiD0kUH2P5suxpqvtKQzmcvt?=
 =?us-ascii?Q?LxaxW4fTXbQ/OLZNI+dw/VRU3LBr+MHkoJ+9ggk2oi8jbjikkTTmZmWu/opo?=
 =?us-ascii?Q?V8ljdvusQeh8rjZsz0jBlXRTQBwEcDgWVAJ2/9UTIfsYLPb+Q9AyBqDWMbRd?=
 =?us-ascii?Q?TrGd4givaQjpEOmw+igc30A+mjWTIyS1/9/1ZlFUjvnxlMIVrCCx7b8brdea?=
 =?us-ascii?Q?vSZu56nanz7pv47nTLgIRbijg/ioZcWUR/u68O/kWVwOKY064aVkoB5JYen7?=
 =?us-ascii?Q?F90pqWsVYUqlAY+RBuAYNqK3pdxlrtZxe6+l2JUwSSf9NUpa414sQdlwSseE?=
 =?us-ascii?Q?ebzlTiGMgxFIBHYhFLPjR2nZ7OVnOulpKxyclfUfCYy2OA3zZOupPKsJWrsA?=
 =?us-ascii?Q?k49uGeUUXShcWs4nuXrlprHB8E7+IRkDeN9+McoDaqB322xlZp/e/USf3p0X?=
 =?us-ascii?Q?4X9BWV3tp50aHEVGdwGghH0H4nBakpmD1bcxrs0k/AOCp1y8KLcuAxeO/z/E?=
 =?us-ascii?Q?nXTCN0Gmb4Dbkss60YmglJekGQ57ZFWTqp4KNuYKaGHRlJvioBwl5lnnIN9T?=
 =?us-ascii?Q?DjX+NZcI6gJUfFlAm3X3CJknIT8IAozvE8nPXNsIY5GyOm6yW1pRsWQhjApE?=
 =?us-ascii?Q?nv2nM/G6kT/Jg7t/H6L+2LrZm+jlq96DOxojUP2EByVwKj5tDi7o6LDDatul?=
 =?us-ascii?Q?bkT6NuV76kSOKr02yq0khsd50yHGn00zdC8dpdLGqrek5qLlTn1KODAHkJv+?=
 =?us-ascii?Q?Lar0OPNyHzBNkW76M+g17r2PcMiR/PygtKJ7NipQ5nvUhWn1JzpGpT4ONKwh?=
 =?us-ascii?Q?IBqlbytdhNLB65RPWxR4eGjDLLMAzVte0oG/TTlIPRD7thwKZx8arQ9npyku?=
 =?us-ascii?Q?gLyV6WI/kR7HinFqrswDdI8896qm6yA36Cqs5w60nd2lGLDwVARHRFJE827h?=
 =?us-ascii?Q?Q8oaOL5Kta/vNoagNw8wbUBb63ai9RZXq1wZlIiPX6/27KavdwirwUU/IIq0?=
 =?us-ascii?Q?TZ3YidjEyN6r7IqXZbI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qSGsZn4UdYNZVtHJAEBIBc73rfKtQYpIPN0idjuvilG1EbTnKe6otMt0IM+6?=
 =?us-ascii?Q?IjXm3uqw6L3uDSeOhaWfOGhM5NeGrG7OK5rUx74Rzuf1Unu/hlMJ92oneOv2?=
 =?us-ascii?Q?Dwtei1s2uc6H+ra2AHg3FE6Zaj9H1wdHrCsFXO90T0hbYklAoI+z0mqHPkMV?=
 =?us-ascii?Q?o68D5FFmNJJezHPfUcj/txIBeDput6tRjGhpxreIkaZLe5whnGQOROPSbhDz?=
 =?us-ascii?Q?UHpg58LugzdZKVf255xWg1Av53P2JpXv+oJUQU/xz5JV0LTja8E1FhY/6/rv?=
 =?us-ascii?Q?iELQ8knPBPQOPeqefwdKkExhk0M+MtwNipPmf8PBYvIl1heUUXKV5Z2W7c/P?=
 =?us-ascii?Q?LByn0WJEa2Z9bRkig8gI0z7t41mslwx3lnYfuiG9wEL3c/KsR6vAsb6oabqz?=
 =?us-ascii?Q?yDKc3Ll0bjpeM81xLVmFDwz/oh5ypwVpq/0CkwRC+oMGx4IXOEwtHy146q0Q?=
 =?us-ascii?Q?OpUSO8QDVJhTtjUD60/xaTyWro4L4/shJf7kFclaj0mi9CHJSlmQdcrgMCbm?=
 =?us-ascii?Q?3nE082gtnVthNbbMNeVeBWS9+APhy+F6VjNrFB4iWq17sPss5b8LJU0SF8uv?=
 =?us-ascii?Q?OXgF8+KCQGnVzDY5Up7afnIiEoHAe6o5vuPHgmhQMPlZ+vZnKx6J8PvtpeV6?=
 =?us-ascii?Q?vcNO3YUhOrTg0i/ADFmq17ueBnjcsSXExe+R49hyw8vB/rg3YSMwxtA3RyFt?=
 =?us-ascii?Q?q4ednywRu6pTPTkhq9JuGRwA2MPrygQE5sWfkegsxgcbNigGsQHLU5zu8Pto?=
 =?us-ascii?Q?S8QUTeDhQz34yWav843mlBJ1pnA11DpWOAviex2bDpEFhmsrJ0cyokwVRkf6?=
 =?us-ascii?Q?wYz2lc5OjuuzS7Oe4ZiVaiZgRfzm4ucel+6lPj3LxjR+pLkRP0ZvdKQazxFo?=
 =?us-ascii?Q?+o4YFbdx+rwK3sWEf9GD69A4TUrDubgEf4uDBo2e/EAcROrQZe+AKTUZtcfo?=
 =?us-ascii?Q?fTn84blmgdJmjgDDO6xerhdGCS8IWomsCSYu8xUvNVtX7k60qUqsPWZfkDZ2?=
 =?us-ascii?Q?/Ut7Q+P6MLay+fstEVTre9VmZHM8LNqv4HkKJZQS4BkXTXKpXm8U49wVFNap?=
 =?us-ascii?Q?xaocSAUb9XplPiK/gcYevPVLhnl0csUsqfdAB5dbeM8RRIV3yRe1KJoprzUg?=
 =?us-ascii?Q?//wofowDOgrgyeqPcSiP/w1YxJE9MjbGI6CBeNXSwv/VTbt4EGagfnOcNHH7?=
 =?us-ascii?Q?wUobwZwTs+JE+NOU177GJXKXTojldjt91ZYt9Y5WIscIlbXMtipZxe/EojXg?=
 =?us-ascii?Q?f0wDG2I282vnC5hMkQWZflWPXS3nelyZCnNs7OYivRyYvJHxzFJSte2/lhYb?=
 =?us-ascii?Q?VRImAIB/pSF3ZyNMqOCSQ+cBpqh1luDxYQ3efkvHhBS6StdeFXKlbzxCTYIa?=
 =?us-ascii?Q?TXCIm3cYThf/AvZaOlM3F9/xgYYfg/BvzZtgv9LHQoNZGEy5nAgDvX741SA0?=
 =?us-ascii?Q?Y2POsRZYc9bOw0rh+kfQVcBCnStaFnHpLO0k1wAGVuJFmDKwLdFsZjh+ETII?=
 =?us-ascii?Q?7xddnV2XXCuS3xZ3Cq2S6Y2psu1o5wYePyWnVLPl2rERN7eufGbYMxjKSIbw?=
 =?us-ascii?Q?LdwnUCOJV5rz9qgIgIxjeobTww5IfB4yqznOZG/i8bAzz+UJiIolKTqbvdWj?=
 =?us-ascii?Q?MjZITG/0NWWLHOq58o+IK/x5AN7V4U8Wi9p0QZZ35jYC1ONVY9Ttyuwz0s/I?=
 =?us-ascii?Q?Z8dzm2gZx6ZteV1eO4nntXnRUiXYY7Lmk0O1D6T5ULW+Vpv5MBEPJA9Jct1l?=
 =?us-ascii?Q?a1dgE15ZwCjwhuLKkHCKgCIMLH+G8Uji2+y2m5tVSyB6kLTWq/PRE20BvucP?=
X-MS-Exchange-AntiSpam-MessageData-1: u19EQlz1g/P2kJpBUnUmTM2LKGMilJcOiqg=
X-MS-Exchange-CrossTenant-Network-Message-Id: e535b072-fea0-46bf-2fc1-08de64b3da9d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:41:16.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPUwLAOrd6Slw0A7suFgxZh10oWZYiRfIqbniJqgBjwIuyNHJTlTGLPy8ktOlDzhF0jcmZs77VugJQp/dTSop1RYUNc1cGJ0wkiugMHEk9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8416
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
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257155-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,soc-5CG4396X81.clients.intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 572ABF2BFE
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 02:29:53PM +0200, Vladimir Oltean wrote:
> On Wed, Feb 04, 2026 at 05:34:01PM -0800, Jakub Kicinski wrote:
> > On Thu, 5 Feb 2026 02:59:01 +0200 Vladimir Oltean wrote:
> > > Thanks! This is an extremely subtle corner case. I appreciate the patch
> > > and explanation.
> > > 
> > > I did run tests on the blamed commit (which I still have), but to catch
> > > a real issue in a meaningful way it would have been required to have a
> > > program which calls bpf_xdp_adjust_tail() with a very large offset.
> > > I'm noting that I'm seeing the WARN_ON() much easier after your fix, but
> > > before, it was mostly inconsequential for practical cases.
> > > 
> > > Namely, the ENETC truesize is 2048, and XDP_PACKET_HEADROOM is 256.
> > > First buffers also contain the skb_shared_info (320 bytes), while
> > > subsequent buffers don't.
> > 
> > I can't wrap my head around this series, hope you can tell me where I'm
> > going wrong. AFAICT enetc splits the page into two halves for small MTU.
> > 
> > So we have 
> > 
> >  |                 2k          |             2k              |
> >   ----------------------------- ----------------------------- 
> >  | hroom | data | troom/shinfo | hroom | data | troom/shinfo |
> >   ----------------------------- ----------------------------- 
> > 
> > If we attach the second chunk as frag well have:
> >   offset = 2k + hroom
> >   size = data.len
> > But we use
> >   truesize / frag_size = 2k
> > so
> >   tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
> >   tailroom = 2k - data.len - 2k
> >   tailroom = -data.len
> >   WARN(tailroom < 0) -> yes
> > 
> > The frag_size thing is unusable for any driver that doesn't hand out
> > full pages to frags?
> 
> This is an excellent question.
> 
> Yes, you're right, bpf_xdp_frags_increase_tail() only has a 50% chance
> of working - the paged data has to be in the first half of the page,
> otherwise the tailroom calculations are not correct due to rxq->frag_size,
> and the WARN_ON() will trigger.
> 
> The reason why I didn't notice this during my testing is stupid. I was
> attaching the BPF program to the interface and then detaching it after
> each test, and each test was sending less than the RX ring size (2048)
> worth of packets. So all multi-buffer frames were using buffers which
> were fresh out of enetc_setup_rxbdr() -> ... -> enetc_new_page() (first
> halves) and never out of flipped pages (enetc_bulk_flip_buff()).
> 
> This seems to be a good reason to convert this driver to use page pool,
> which I can look into. I'm not sure that there's anything that can be
> done to make the rxq->frag_size mechanism compatible with the current
> buffer allocation scheme.

I was just about to send an answer.

Seems like my mistake here. I actually think adjusting the tail should work, if 
we set rxq->frag_size to PAGE_SIZE in enetc and i40e_rx_pg_size() in i40e, and 
not to (PAGE_SIZE / 2), as I did at first, but in such case naming this 
frag_size is just utterly wrong. Glad Jakub has pointed this out.

ice and idpf are fine, since they use libeth for Rx buffers, so mbuf packets
always reside in 3K+ buffers. But for xsk_buff_pool seems like all drivers 
should have PAGE_SIZE as frag_size? I will let the discussion go on for at least
a day and then will send v2 with patches reordered and those sizes corrected, 
maybe add ZC fixes on top.

