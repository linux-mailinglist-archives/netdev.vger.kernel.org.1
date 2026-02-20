Return-Path: <netdev+bounces-259686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLc6DjEpmGlqBwMAu9opvQ
	(envelope-from <netdev+bounces-259686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:28:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8686166394
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F110300F10F
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6B8321426;
	Fri, 20 Feb 2026 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRmNW0Xz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC264322A1C
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579693; cv=fail; b=bRSKqTmfTnqWFikmYnF3ehulOsSWHS1KncZ+yifb7sVdSkyWSWNWOmiAujWoJtCN0w18jBcnplHUPQD8dsisaYHdzszSO9yYPXQQqHVSnnazoHrsZFbykMKbP0imGB8LwoRI+RQ2Mks8GrmRP+7DV+sxRjmPuOf67s+cKlmEKzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579693; c=relaxed/simple;
	bh=9O7Iq5lSpj34QsthmyM2oB8tVUlEn4OghdxbcsMbuKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SveQlTXdFwxQG1PMrLmZljHbEAypPSK448vwpXaRpDc3YTC9y23hLAfcVeysxF9dyQbi0VJ5swlRzRT0rqxTyHWS5hAC+lDvRjVgYctNbdy5j57zSNGh02ARo4tTFMuZE2bwbzY7sSu6aCh9JXqLw8rnoZ6NA2rdoqnwzfQeKNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRmNW0Xz; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771579692; x=1803115692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9O7Iq5lSpj34QsthmyM2oB8tVUlEn4OghdxbcsMbuKg=;
  b=hRmNW0Xzm3Ba+XFwBZuVPjA4HeaUsbooY5sAjRfyAxUKvA1OPzXfjuif
   yApN4uPrm0NFesWbBJiQdUMdrmHvmp3dHoQPYtlGgML4+gVgmPLircyB9
   89zdF03iUsWI/cRkd0y0DEDaHMiUXqvq/+X66aIdYzYJsun6WWAVJ/xEn
   c8pb8NQfMqnyyA25l2mwfDtBgkJK9QhnM4QN5SIVj2Pi7IQT6UvmO9JK1
   F7Eizz3yCT7HoqzZwkp6R8KmTINQmF/AVzIUY26400iXME9j4rksFZ78w
   0CneYxrfXcE9Cpu5iVvA+unzuNzHYMCXx95ZdAt5SZqzhQe6yjZXX8Dtq
   w==;
X-CSE-ConnectionGUID: 1ha2y+wxS+ib/IUXj7KEBw==
X-CSE-MsgGUID: lq6iMcYRR7W+s+0GTrH6PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="98136171"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="98136171"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 01:28:11 -0800
X-CSE-ConnectionGUID: zGXB+p+VThSpeEikDp90jA==
X-CSE-MsgGUID: HJHKjXLURhueSXbQgBaikA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="213909507"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 01:28:11 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 01:28:10 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 01:28:10 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 01:28:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5goyqzqP3tvVCPgDNgLcfSAOxjs+K8ZTBo3wcARgfjquC7Oj8IRPdKQ92SO06vKdC88cu4byy39KPQzSrxkNYex9Uh5fBuc7XjM2YSR32mbDxEyEKqFU1Usfzq3yx44y6IyuSwF0nkmBLGkHOuD7zHWkMULnUniApegp6IUUw5AdmNW1L7m0DGNFLR7H9QwRXYNttizCHgicMAuLemW5wltCcKez5gg1Kfq0RAmryyf1WrmGojwze6RguQfhdT+RTyRo5XBoQE7f7gFH9QHbfjEaLcUIe5/Bk5i4XNVIeGBQNDmMik/iouIORwLlHZZessGv5XTSnk9bwLOJBARhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O7Iq5lSpj34QsthmyM2oB8tVUlEn4OghdxbcsMbuKg=;
 b=UeOqBB30kBVxMC40g6QkXs4+6LSLVZwiTPOuf2k5id0sXYRxQLkeYg0mBE7A0wZ7qbS4z1mLgRkCkDq2xoBh5D178NhCL03MZlMaQ/mpYr7o6YtPWivKnHMbsjG0gA+kS3yxAHnakjzy50PKhBPnEmfLd3A/5Qcdmlzt73T5eCQhJWbz+8vvHZXoTP5GXP8Fe6Re/DVtpRQYibSfzc9OOR0PCGtSil5Wfj0TwdHujXSqGaSrAypQyB3iaIIkmMRMJ9rGvzsuntzmcsd7do+dBVCFCp2TrcvZMk6Ql8lcve1OdA7D2zq4IQ4NLyi64ZyotMb9i7Rdv0IWSWOawynhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:28:07 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:28:07 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Nowlin, Dan" <dan.nowlin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-next v3 1/5] ice: add flow parsing for GTP and new
 protocol field support
Thread-Topic: [PATCH iwl-next v3 1/5] ice: add flow parsing for GTP and new
 protocol field support
Thread-Index: AQHcokq17GOhBlEfmEuMntQVVmhes7WLUcRw
Date: Fri, 20 Feb 2026 09:28:07 +0000
Message-ID: <IA3PR11MB8986D3A080CE8504CFFF4B82E568A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260220092409.718632-1-aleksandr.loktionov@intel.com>
 <20260220092409.718632-2-aleksandr.loktionov@intel.com>
In-Reply-To: <20260220092409.718632-2-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL3PR11MB6484:EE_
x-ms-office365-filtering-correlation-id: ff9b0fca-9c8f-4ce9-348d-08de70625b33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?EiYLInURjhGqkEIb8hu3qfv0wQLV5/bArdKlhTfnEc78OxB9BC2YemsCCyar?=
 =?us-ascii?Q?IJdqP9FX3eSqsyuRwImqFq5ThLTN/yMcQ7wVuJ88qmcgv+gVEO3fo9gLx+aK?=
 =?us-ascii?Q?a4qpU25K8kUC6hMaEG32G7YZtyxhgXUBv+YIg6CYASVgcV7CgOYnMgu7Z8Q1?=
 =?us-ascii?Q?8KBqAFIP+tRCBfBai7xpK3oxa3jqxQaAZEvdLC//3gr6WKJibwb5TyyBs7NW?=
 =?us-ascii?Q?5tXz2zxrqoHYteyAL5laukzQu+HijbrvmJlafOVr9K6adOQvNaGe1gAjSZNj?=
 =?us-ascii?Q?wHe07YmF0nhDd3dLLLPh0Jq6lEOqfbV8bXy+nzzEMdT9/gj2S6W1oj+Cfgnk?=
 =?us-ascii?Q?nzLUAh9UCsSGeBHYYOs/vHFncAnJFbXfPm9rietwbEVeH0hR2TVLxBI5iMnz?=
 =?us-ascii?Q?KDne8gW8UVYCUkFsFE8p1dh4PB4hDMDMaHTpXIMhe7A2AfV5vdkvmLsqnN7t?=
 =?us-ascii?Q?FzXQrrZxZIpsfxY6AhFccZPn7fcYnHynTV6utm9m3mXk1bVM5onlUaCIXcSq?=
 =?us-ascii?Q?982uvpCnKDAoYhBdUTJc3Fp87pSdPvq4giS4NB2pdBb6OOzgficEh25/wtE/?=
 =?us-ascii?Q?4flTU8yFc+7f4T0e4chrrLoJq3XZgOMbOpfUsQQxo2PDoWF1fWuAFRaVOCDV?=
 =?us-ascii?Q?8SyO+1gv9E/1KPGcBUjZyUASUMuVYeAHfOY4xKaiVD3nC4uC1YoXFtHjGlN8?=
 =?us-ascii?Q?AdRuFLM12EW1qfXIVevtvKa0xSnV8Q1KhM3x7W2p5ThAPhC6JPbvjA+GIufC?=
 =?us-ascii?Q?iQd/mshCyfY7kKoNUrHDQyxUE6NrhkDMuzEEFYho5rYnvTlajHPXl29glT+y?=
 =?us-ascii?Q?cF5BtQRPPOj7a3kqSz/j3nz5sFjJ13RJyaRugN1ldpAlGvSUKZ5hPuJ27fIi?=
 =?us-ascii?Q?zrhl7ASsam6rmhDHPyesMlj28gNRh/9w2Mbpvgulq9rnUEhGu1VIgd/kztPN?=
 =?us-ascii?Q?gVGE6x0Lf0BppkJzV/7F9B+EwPiz3fotIAlEZzDmizuSkmuiz2+VIzv9TQna?=
 =?us-ascii?Q?TWLgvaFOWzJblaLHVV9kQlFswYLh66yUMwSRF/Kn4oKef8RQNv69NGxAHGob?=
 =?us-ascii?Q?zpHq8nIFUHpcX3SPQmyzMXEXjJhpiPFcHfcfotjE74qbnpU3IMoKtezr9DC+?=
 =?us-ascii?Q?KijjVO5bWEoKjP0e+vFuDbyOIhQOvk4L4H5BP0+u6FzuyxKP6jJKB4lcI0ya?=
 =?us-ascii?Q?RM02IF5+luV5hA9Ldmsmxx3f2Kqz04hLrEjottOxPOkTfLgS7hxj+Qvo+Cfq?=
 =?us-ascii?Q?h5Smvbhqxlp7Hf5Nw5TmjcUvAooRn76DGmEuz/lKXLw2S4hOL4oGn7FHfqWc?=
 =?us-ascii?Q?rrHqAZx8XcAdDYQvBidiPVKZLRY2v8Lbk81EUjP+ZjUx3GvyNApGT1+xoAfE?=
 =?us-ascii?Q?Cb9enhiHLPrWKhKPqIUQ02cOXowTd26zFgl37frOwqHzohfu2NUEkEF96mmT?=
 =?us-ascii?Q?D9zE8MF1VWsgmokMHLdUM4K0JdPeS2dbIt7gRkeHkQ3NJQ+LLfYlIlfmN/03?=
 =?us-ascii?Q?Hj9BGSrbnLLgQmgT+G/fvzw8jiS6lrkAnrIR4rUpaCgrKQOJ7Owyi5k/ouks?=
 =?us-ascii?Q?BOa9ZTZ4qN3cfOBlecWX4y9gY3u+8mIq2m+Wh1/XUqUSX7n5cYSwtXghqbXh?=
 =?us-ascii?Q?CDXkVHdawa/+QhLDD5q0ITw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fXyWzLzXfGdmWHV+/slcHpH2GIg8DjbZ96zQxoNntO3qdUfrFWCBQWW/przc?=
 =?us-ascii?Q?3DC5U911a2fIpLJrlG5QHACXDSSWijaHyNHkxXr5NMa9kVzDtao+aZVc3B7u?=
 =?us-ascii?Q?bDU1gF940VbXEp62qaQTowkuSq/nQj2CZHJAXGSnlyJ5y0OhDwf2JMaOtbqQ?=
 =?us-ascii?Q?x6xRx7GMannllY+pX5MkL1L5gcVRzBl4eHJkSA1A6/76uS4bBT3ynjXoUgXy?=
 =?us-ascii?Q?KPGAKHqF9SWZhxt0m2Bl5JGvVnVpfn95HDChYpTgRwo1TYANaNQqVUZm/9p8?=
 =?us-ascii?Q?CGHuPHf9q90nxXtPSBVfYijaUC+0w4FtN08dwgI5GwqKhck0oyxiPVJSDDNV?=
 =?us-ascii?Q?b8EGKkLV10CPP41DgVrIvFUoHTjFdsDkzl3yJjKxCYuBsGQpP5yDq9UW4ZAU?=
 =?us-ascii?Q?bkSTqSUs0TQiOHFuBvDktkOub4mt9bCtDBswo4XVAy+6z9AHAPR2VI3bFJCc?=
 =?us-ascii?Q?00HjrTaO4cePJMmvw8mcw1NY3IJAwkBa+o0r4ViA/9E6zIL/YCZNlrPwhhMu?=
 =?us-ascii?Q?FHem4wRd2TYhaBl/VVleWNaEIX+qJJjoxU4NqV+D3oUjTQGvKa0ulSBzJb9q?=
 =?us-ascii?Q?qm64HcClGCXMpzoDCSiSdmE62TMwHYOZd5P4get7EEnL10xVRtgY+bSMEZN5?=
 =?us-ascii?Q?7T6N7o6lsu6ADChb5LpoUaf3p5nYtgxVRaSkG4O4XFVqRkbbgIqpnDmoZUdN?=
 =?us-ascii?Q?Yq/2pcWRXETyuqnISIsKMN/EizzSwb9o6PcTXocoU6ix0lt1TRxA4dzpv0pl?=
 =?us-ascii?Q?aIUgrc81P7tVRLVpaJ9/o7GGVapVJrVEy145+wuAsa1bAsMs+dnVKV/FaIpH?=
 =?us-ascii?Q?l287/C1qsRHkx50LG1JSmTzVQLgF6HlB3+x+lcQdt/2EOPqpfROcv/cQmDD2?=
 =?us-ascii?Q?f9TBYl9Vvf2vNUUFrTckPe9BX56v7Roi478CFLVoVrXAHl46Q4YbtvLNwaZI?=
 =?us-ascii?Q?E1qiLO0P7MJ4ueiAJBlXqWYUgm2Jel5aagLyc1GxljShj5W60qc7mNFkEklZ?=
 =?us-ascii?Q?mFF4dFTziqm802FCWv7Apx5YMW+Z4ooFnnjaJVidnT43k5DIkeTO3Xv0JF3N?=
 =?us-ascii?Q?mL5CwsGIc+BoKL7UsPT/usooFOUN+ITIZv7M6zf38yCOnamPYGR7V8XRuzaP?=
 =?us-ascii?Q?8GBEW/uk+pzl/jGbJ02ldKSn0e4Zd1QgeCCtcsgvl4p2FBd/zciupe7vyc8Z?=
 =?us-ascii?Q?egktfpI5OQPj0yQ79PxSw/lhmmRjryoSctLp/JfggzvoxWZF1Inf5mckKu5n?=
 =?us-ascii?Q?342PVmeWHUnuz4Bt6hw9/v4L3ZZiGtoyJvl0DWRJehjaRcB02zt8ETRi7SrX?=
 =?us-ascii?Q?Rz8OGEOLAt/YuWD+mtAvtgJKHbngGlrPVOqUNBeZdmOY+nazonyClNk6aJ+Y?=
 =?us-ascii?Q?G2DfMoE3mCgx9gTqBEjrfvw0myR0YSVh6k3Z3bkM/FgRwN2yF/KywUHdQt/e?=
 =?us-ascii?Q?zE37DRsOmjCeBorbmWuavvdaNaKobzXva5nCmSAqi6lUxjP2YMrZsjsY5gJ5?=
 =?us-ascii?Q?2oSxUzasWdZeLLWGSZZJvPlZOMIq2Jhlm7O+8rbF2o+HOLPPELISuA+5sAd9?=
 =?us-ascii?Q?looXYyjJlP1D/TMAHsBCVhRWYlspEQeT4Pu5bhkAQgGIbwCQvnKRxIlU4YgW?=
 =?us-ascii?Q?YaBCjwKMOobniv/keUzxGE+v5Go5nTv8VUK88p+4unROS1rhijqUY8VRlodA?=
 =?us-ascii?Q?uX1FPLcGyVPqZ6hfuGdf/AUobFtvVwDfCIZCFSMmzNVAaYCZIpRr75YQ+oL+?=
 =?us-ascii?Q?vj2Yrtu+3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9b0fca-9c8f-4ce9-348d-08de70625b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 09:28:07.2078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tk4JqCBkFQKHPIZWyBWQ99ozDUyKK0U5cwoAl6hw393d8Rr/MWbsblhBcsaK652yepEVZeHm1k7sfBJ/a8kaNeorBB1vR7ozKtRltW/dZPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6484
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259686-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,osuosl.org:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D8686166394
X-Rspamd-Action: no action

Please ignore this email.
I had personal e-mail issue.

> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Friday, February 20, 2026 10:24 AM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Cc: Nowlin, Dan <dan.nowlin@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH iwl-next v3 1/5] ice: add flow parsing for GTP and new
> protocol field support
>=20
> Introduce new protocol header types and field sizes to support GTPU,
> GTPC tunneling protocols.


...

