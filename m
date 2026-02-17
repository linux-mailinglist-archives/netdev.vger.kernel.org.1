Return-Path: <netdev+bounces-259064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFsDIAuElGlBFQIAu9opvQ
	(envelope-from <netdev+bounces-259064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:06:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 389CE14D666
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83315302F435
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8B36C5A2;
	Tue, 17 Feb 2026 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aqyaw3/6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8EA36B047;
	Tue, 17 Feb 2026 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340780; cv=fail; b=d94wUPXEqAqUK5F+BHnEe+/KVtqAZKk71bTqLn2ltjP5CYmPRwCvycXslNSpvaTi3gjWw78u3qvHxoDycptdIRpQCaTL1COt/EUJ+A0rH6z9gGHB4O7v9UUT1BNjHtxgCsJWQsxJuHaJfy78IZr7z4L6WLs4E87tNlbw2PIybYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340780; c=relaxed/simple;
	bh=uVhEmux/Dv4OIuWGz8x2ziwMnjQjD4sAWPvYMbYmCk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FcmUiBtPHD73e+VDUP8ZQE4fg16kBF2gP05PR3wdBRFv2L2X4MBCCVW+oqrGr+xmvfu7NCFh5mGbhZgw0K+WTrvNuRGpvk5fzoCmQgFzNAoAG1TuKetl/wr5GHhKYUJQi4fWxmBZd73ecfewZ8IW5d4KyBETFNT7UBEBUKisIqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aqyaw3/6; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771340779; x=1802876779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uVhEmux/Dv4OIuWGz8x2ziwMnjQjD4sAWPvYMbYmCk8=;
  b=Aqyaw3/6J29UbI6+zI3vgkkvuAJI98GNuXm7EYrreVSiupjPoRP8elxw
   eVy9Z33Z07DbTUTQIJzLFmpuXofp87NreYaYdb0NpkLemEcc4lY/xuqua
   c31AJtCmSM4MN2Q1Z9hZeQmTc/oHmg1L33TDdu+mfI/MXSW7pnGtlf8GA
   USpf+vPFUWtj9Tik4QBFgKogv6O+SbgHd6KQjlze1E9zUNXDmFYTNhDhq
   7UK7XsoLxRKLPl1Ut+gEOCTZqLsAYdfUNVCk8uXlA/ecbV1BH5EqO6I3h
   R0C169pvZ19SGzQ78CkAHDaDB0c7Q7d6jf9HVi6xOUfC9iUbgffxMZHrX
   A==;
X-CSE-ConnectionGUID: X7oqj8d1SnWXSWKkF8/7Mw==
X-CSE-MsgGUID: OJbJdeYFT5qKbm5Z8tW+cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="59975221"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="59975221"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 07:06:18 -0800
X-CSE-ConnectionGUID: oIptXFPlSu2IGHfs3f/G6w==
X-CSE-MsgGUID: 1bVCFsDIQ/uBHTOfYUa8dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="244497013"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 07:06:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 07:06:17 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 07:06:17 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.40)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 07:06:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Th2dhI3v6nypQIdM9WWvZXhORKtqnYUi+Qc7xCztNGZ7oBaLoRvKs9+iRXDtbKyjVX5nWip+6n6T2rPlWL2wsXpiDdWUk6PBHO9axY2vmy4zTRdmYoo7y1h1D3Qj2P+uXtMFzDRyk9pn1MesfR8jv+a/I2nZCbrFI1W7WpfJa5K4pqHa8Zvk9y4yQN3reCFjBO460t3rrcHM9tzM0K723/Q+58D1vH4v2BqUURv+hig9EvsfrGp+KFwP2k2+7W+CCY9MwafntUXOHuFo/KaocZQd0BVh3XAPNo4rf4s7kfDclzVHP1AWwLylJ6uDMq9X9ZuZ0beH6HBMfPkP7HDVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6aem1H6npaPxWjgdnyCMGHCJZIxwr8N4OropbvoHsw=;
 b=SoJhgH9CkMCoCHYNCoCyBlfNKpVHHRPAEddbgoWYIQcovy2kjCos3y1Wf79DWW/nwEBRPuZfjNE9681arX+ccJ0ed9xID34uT006jXn/VXqm+Ge9eyu1uU11+1zAiiBfuAQ1GEyfYnqSdV7x/SQOCQyVKeNqGMQJMD5Omj+tOQszZVUKPD6mKgg8dlhmwukc47IBs1/oNJkN4WiquiBDOogKwqYs687/8AsGrXLtOIAKRmZkc/yX35SupaNdYD6nmB2Md+dQCXZhbE/G3McYCvXW+yy6aAzy4dCaUYNlZefJuxLcw2wbCmdIEfqPptAqA4zDqL7XRYf3gVfx8jFH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB6685.namprd11.prod.outlook.com (2603:10b6:806:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 15:06:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9611.008; Tue, 17 Feb 2026
 15:06:13 +0000
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
Subject: RE: [PATCH bpf v3 7/9] libeth, idpf: use truesize as XDP RxQ info
 frag_size
Thread-Topic: [PATCH bpf v3 7/9] libeth, idpf: use truesize as XDP RxQ info
 frag_size
Thread-Index: AQHcoBUFQ/lEUbNxA0yExtYj5JXe3bWG/XYw
Date: Tue, 17 Feb 2026 15:06:13 +0000
Message-ID: <IA3PR11MB8986D2F18F6FEE4356C08D05E56DA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260217132450.1936200-1-larysa.zaremba@intel.com>
 <20260217132450.1936200-8-larysa.zaremba@intel.com>
In-Reply-To: <20260217132450.1936200-8-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB6685:EE_
x-ms-office365-filtering-correlation-id: c307ef20-04cd-48b4-7883-08de6e3617b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Yk0Gxui67mRZ4adyRQDQvofuGN2T4SdDyhs0vXycQK/P1QqJPLaaY7lHqF?=
 =?iso-8859-1?Q?Lp6q80ce/vMI8/0u7gNs/VVpiA9gp+j12qimYg2KyHVPrhjDhrmEiI2GSu?=
 =?iso-8859-1?Q?6T/V9CVdmuuj2Mc0HNoS/KduqFMgqG/Y/6qpfh7dVn6TDEOfu9tQ0CMaDd?=
 =?iso-8859-1?Q?JQA29Ty83P9w3wHR8Gy84JF8UGB20LV9mxHN9WqQeS8fxhc07Nvm2vxK9l?=
 =?iso-8859-1?Q?p97dm5EpJA549gnlftmuAlK1S8DpMhAgQfjafpdqWXxvWQrgUS44Y5CT0E?=
 =?iso-8859-1?Q?iSo07rsDxRq7Cicc2cg9yO1iXFN1gRjSjdNivNWjl/jAfp7mnm9zD+FbDE?=
 =?iso-8859-1?Q?oTlFYvKFDpO0R9aqtYoz/gDhjV390Hdwp+NoZIXx7xVRESftN02jaQPyWD?=
 =?iso-8859-1?Q?aHOwmr8ipzjVNSpVUb0+f+I0BMls8c++yzxAWSo5+dGiofkSlq1KRUjElS?=
 =?iso-8859-1?Q?GjKeKPU+FZwefyFbbnmjC5oPEGUwcZYkNk244H12Dys7AliBwPGVXWXILj?=
 =?iso-8859-1?Q?h+hy0xFZzYWFGkH/Vk9jeEza8yYZJwiykmx0AgVleb3VC99XAVoVQR9uiu?=
 =?iso-8859-1?Q?N3otq5pzcaghcDXcx4Dedu4vc5jdileG9xivge28Ann4ktMzlIVy0edait?=
 =?iso-8859-1?Q?8i2v80GSTt/tG+0flz3zjHg5pxamHCgX4jp+Kt9Qrtu6qKef9EP/oSaP3V?=
 =?iso-8859-1?Q?aQktK+FBC3J3rcPTMLJFd6SX7sADcGVaGRn0OWkM7KRLtGkTfnx6Lh3jbl?=
 =?iso-8859-1?Q?QOEWXGfa93rJRrLVtMpqAZnimyNtwcC157XarHOntsqsn4MEp5SC7Y9QvL?=
 =?iso-8859-1?Q?3Mhrn+u7A/1Ftj4l3u5j2LB9/49LcrufPHWd0cSb6sKydirqUr/AUnqGeO?=
 =?iso-8859-1?Q?WO+3eIxMV4/A7zoCoews0ZWuJc+7hkwxXGqFICe+JmTUWgBXSY3RQZO1eA?=
 =?iso-8859-1?Q?7P55ha4hvmAlovp4llJTxP6oDmto5AmN+4+4liuSvFCN4Feh3mQcgaiRIl?=
 =?iso-8859-1?Q?EgYFF4FGcbC5Bn2HZZAkV11KDVLtf+0o+8OI7ZQFoQvvGKRlPwiETWjURL?=
 =?iso-8859-1?Q?2Fjo6k78YvohXtzpCIku8r49nSrss3SP2sEfTCnnN26No0w1vqEH95+rGG?=
 =?iso-8859-1?Q?KdPRVOeq9F5+Jn3L2Zkbi6iizPu0cmqpCQPswmd/kO8q80YB555PZ2Jy4D?=
 =?iso-8859-1?Q?GTPoByGEJfnTOret0tfrGH0SXyyGPAYsNz0EGZxLl5GKqgPOsUH/GMnV1t?=
 =?iso-8859-1?Q?V56CLoNcVLLbBV7JUXodNeyW6noO6jnWYLarZLndXgwTJ3Dby/XXsYzN0/?=
 =?iso-8859-1?Q?aWst4jk383omBlHQFoUtkcenBzJtYRPdUfNdAXQqgxUoTps4rFcLTa3NZX?=
 =?iso-8859-1?Q?kma/vF9bsj87WXOcjUfAq6XXyjNSCTAE7QkUIXj7Gx89gOyZKt0NomlOe1?=
 =?iso-8859-1?Q?D6SK0JI9UmUETgEHs42PZfn7dcDBgeD6ZiIOxcZ4Fyxo4VOKXNTSufzKvc?=
 =?iso-8859-1?Q?CLF/UnmXvKIgjlZq7WmNCio2deC3qP9yUPAF6cZuAr3ZxAibmw+buiTwLp?=
 =?iso-8859-1?Q?/L+fnLQ+i87ila5k/6fv7YutlGL6+pTBWYGLIL2tt1LMdWdYB32W9VOm8r?=
 =?iso-8859-1?Q?H6kHRx+8/5iz4BBKeuRMBpkx2c+OZO1j1JBy7ELtc1RpUZS1i6HWYT0FQC?=
 =?iso-8859-1?Q?Z0bo1FYhF2qod6NOsco=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v7sKGBbjutez0qR6Po0di8MZcR9P+GP4TrQUmAFKAPA0xPiOrWrRyr8Pl4?=
 =?iso-8859-1?Q?Jafbvy+Y1JRok/ccnIV7NnGGjVwwmKdG1NzmNtDnVv15vHC4+/Xr2XghwV?=
 =?iso-8859-1?Q?OtaBDpv8EqBp/uPhvzpueKGkwEjP+TfE7FAgzxu+mEB5UynTbHaCu7SDki?=
 =?iso-8859-1?Q?voc1gxxv2XuGy3l6YUMVEvgG5h0ms1w1i85WG+C+ucb9h0enTIkZatlSY/?=
 =?iso-8859-1?Q?f2gGEJWk8S/dcfOryvz3vFJ82fSaEGFiQL9CQmvleEBD5rJMUFDPj/BNGB?=
 =?iso-8859-1?Q?iiFQQytQt8JrjcKXQmSH8m5lZD1PBxcHmnRYo26dTr1PzcDW+vYf9jPND1?=
 =?iso-8859-1?Q?8LbxIwLTChfUCkzgBB5HnodL7OX4K4nVEqIfJfuBZ+UA7CGW/Zx5Am+1L4?=
 =?iso-8859-1?Q?uiJixqehiropm2OptA689MCoS8e8A/hDTROossiPuAej0nHHfhi7W8eCVm?=
 =?iso-8859-1?Q?R4WqPDfD3TBhPu9GreAgY01KiB4JcQp/eu0CTY1LLWmI53rN/mrztMS+Tt?=
 =?iso-8859-1?Q?4enLTEaEzTAtviVzmTiCh/hyo58/TKsmI6T7YGxfghF/v4vtAeLMoTvDKu?=
 =?iso-8859-1?Q?TOWSAyrv9Edjf7zVTZzDYV21d/xRiRiamYwuGQ5/L1p/fABycgKMYoHS6F?=
 =?iso-8859-1?Q?K68/gx++zBqZLRzcoemqcCfNaEyeIyfWxqpkKFGqVssYpEovOFJ+rf3Ioy?=
 =?iso-8859-1?Q?GbF5NHHtGduKyTrtuW4WBOsCJZhQgnYn0wMkfO2J+tYPNdH1zBMVctuMkx?=
 =?iso-8859-1?Q?lnCVufmbvBd/fCltkjM3LpCUuD6QJrY2gjaQ3maVMbBR+3tap8HSr4DWlv?=
 =?iso-8859-1?Q?0xkv3KqD0cvShE6y4DDlgi6If/vDroSLniwFU29ZZQDj0eveNCS8rgMpKd?=
 =?iso-8859-1?Q?Vu77xNGyQ6zNQapCN14OzWX8Rf9u/SZfAj0Fibv3nCHYUvGV+NhkBsno5U?=
 =?iso-8859-1?Q?l7D3uDFZ1cLu/1vS2hCibwHbYv4d62hdoOZ/SLXvpeWaqMVLgzBsa/uGeE?=
 =?iso-8859-1?Q?sCpOBQf6QAep2mFv4XXU/tiPwZj+w2xfEHG1LZUheh8Z51ZV+EMRjDT0Y6?=
 =?iso-8859-1?Q?iDadqX+z6F9SQj3OAQvNRhqiR0zM6cYlyV49bxnTH2LC6k5T1nPYCO3yBO?=
 =?iso-8859-1?Q?eQ1f+T+mIN7D+5Av8NExMxRjnOAMPejPuGv4eivbrF6rLmGk6WQDstL6HU?=
 =?iso-8859-1?Q?Ny6hTZwUP5Q33ce9w/GZIGQtSnD5nHco66D8LDQhSm4k1nDXbAeZdIrmTm?=
 =?iso-8859-1?Q?6YMjCX2eKpMGLGeANh6bE2MHiBiYXmpQMdK+XsFZorH8+fFNEFFewFF0ip?=
 =?iso-8859-1?Q?EVJ3lrxbgvkvHApOqRUBmz2pZf9GfsXr3kB8jQv6J/hVRAViWRjRityBwF?=
 =?iso-8859-1?Q?f0eLG9jZqKv99lFUl6AcTmSC4z7P3GA4Qe3Ah47TGnE3wgP64HPWNBDuay?=
 =?iso-8859-1?Q?ZT9OotB46w4P3tlYcAbV4/FWhC2QSxspw7U5XuE6zPkUoxig/lENNy0ZxT?=
 =?iso-8859-1?Q?Tfb64kGA7MlXk5I4ClcPOpJ+kVzHT46vNzneSXUBJVXjpDOBFsLsJI6QVM?=
 =?iso-8859-1?Q?CYcJAkfJcmcaG86ws8+vlAeSEldisr4M/u3Iu/glboLW3mbisKqz97K2PN?=
 =?iso-8859-1?Q?BpwFX7t8hF48faZfu+4QLI7LQkNLBztqhFClNMw0N9TxEuGsRFg9kzuT6T?=
 =?iso-8859-1?Q?GhhrJfpehweu5GOWyk0Rmn20SNerUyMAiUNY3uOPR0IJKI+XPZ/el8E6T3?=
 =?iso-8859-1?Q?p7RNuK7XeZ3XsE7lPGnCUqm468EwJph7EyJmBLNWhpP+qFvdoG3xk+XBez?=
 =?iso-8859-1?Q?bc0xKdXCEksk3a2KnjOPAvUtTbvi+VE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c307ef20-04cd-48b4-7883-08de6e3617b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 15:06:13.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLR/eP/S/RooDN+xbu6WkYvxt+H18Ph6F4bExJW0ZFkYEykFVUkvgG8kEHpNZypFe2s2ISQ/W45GkmTUsv2KVCptbcSa9undgsMvPZ+iWdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6685
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
	TAGGED_FROM(0.00)[bounces-259064-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,vger.kernel.org,lists.osuosl.org,nvidia.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 389CE14D666
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
> Subject: [PATCH bpf v3 7/9] libeth, idpf: use truesize as XDP RxQ info
> frag_size
>=20
> The only user of frag_size field in XDP RxQ info is
> bpf_xdp_frags_increase_tail(). It clearly expects whole buffer size
> instead of DMA write size. Different assumptions in idpf driver
> configuration lead to negative tailroom.
>=20
> To make it worse, buffer sizes are not actually uniform in idpf when
> splitq is enabled, as there are several buffer queues, so rxq-
> >rx_buf_size is meaningless in this case.
>=20
> Use truesize of the first bufq in AF_XDP ZC, as there is only one.
> Disable growinf tail for regular splitq.

"growing" -> " growing" ?=20

Otherwise fine
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

>=20
> Fixes: ac8a861f632e ("idpf: prepare structures to support XDP")
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/xdp.c   | 6 +++++-
>  drivers/net/ethernet/intel/idpf/xsk.c   | 1 +
>  drivers/net/ethernet/intel/libeth/xsk.c | 1 +
>  include/net/libeth/xsk.h                | 3 +++
>  4 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c
> b/drivers/net/ethernet/intel/idpf/xdp.c
> index 958d16f87424..7d91f21174de 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> @@ -46,11 +46,15 @@ static int __idpf_xdp_rxq_info_init(struct
> idpf_rx_queue *rxq, void *arg)  {
>  	const struct idpf_vport *vport =3D rxq->q_vector->vport;
>  	bool split =3D idpf_is_queue_model_split(vport->rxq_model);
> +	u32 frag_size =3D 0;
>  	int err;
>=20
> +	if (idpf_queue_has(XSK, rxq))
> +		frag_size =3D rxq->bufq_sets[0].bufq.truesize;
> +
>  	err =3D __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq-
> >idx,
>  				 rxq->q_vector->napi.napi_id,
> -				 rxq->rx_buf_size);
> +				 frag_size);
>  	if (err)
>  		return err;
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/xsk.c
> b/drivers/net/ethernet/intel/idpf/xsk.c
> index fd2cc43ab43c..95a665cb2f33 100644
> --- a/drivers/net/ethernet/intel/idpf/xsk.c
> +++ b/drivers/net/ethernet/intel/idpf/xsk.c
> @@ -401,6 +401,7 @@ int idpf_xskfq_init(struct idpf_buf_queue *bufq)
>  	bufq->pending =3D fq.pending;
>  	bufq->thresh =3D fq.thresh;
>  	bufq->rx_buf_size =3D fq.buf_len;
> +	bufq->truesize =3D fq.truesize;
>=20
>  	if (!idpf_xskfq_refill(bufq))
>  		netdev_err(bufq->pool->netdev,
> diff --git a/drivers/net/ethernet/intel/libeth/xsk.c
> b/drivers/net/ethernet/intel/libeth/xsk.c
> index 846e902e31b6..4882951d5c9c 100644
> --- a/drivers/net/ethernet/intel/libeth/xsk.c
> +++ b/drivers/net/ethernet/intel/libeth/xsk.c
> @@ -167,6 +167,7 @@ int libeth_xskfq_create(struct libeth_xskfq *fq)
>  	fq->pending =3D fq->count;
>  	fq->thresh =3D libeth_xdp_queue_threshold(fq->count);
>  	fq->buf_len =3D xsk_pool_get_rx_frame_size(fq->pool);
> +	fq->truesize =3D xsk_pool_get_rx_frag_step(fq->pool);
>=20
>  	return 0;
>  }
> diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h index
> 481a7b28e6f2..82b5d21aae87 100644
> --- a/include/net/libeth/xsk.h
> +++ b/include/net/libeth/xsk.h
> @@ -597,6 +597,7 @@ __libeth_xsk_run_pass(struct libeth_xdp_buff *xdp,
>   * @pending: current number of XSkFQEs to refill
>   * @thresh: threshold below which the queue is refilled
>   * @buf_len: HW-writeable length per each buffer
> + * @truesize: step between consecutive buffers, 0 if none exists
>   * @nid: ID of the closest NUMA node with memory
>   */
>  struct libeth_xskfq {
> @@ -614,6 +615,8 @@ struct libeth_xskfq {
>  	u32			thresh;
>=20
>  	u32			buf_len;
> +	u32			truesize;
> +
>  	int			nid;
>  };
>=20
> --
> 2.52.0


