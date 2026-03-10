Return-Path: <netdev+bounces-265909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMJjGOjLr2nWcAIAu9opvQ
	(envelope-from <netdev+bounces-265909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:44:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC88246907
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EAE23013CB6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 07:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFC2126F3B;
	Tue, 10 Mar 2026 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQzKy653"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30113D649C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128664; cv=fail; b=W/bjoebVnZBivoGkZvrzGUMtaBfTgap0kfadbbYp4pjtXxHcTWIeL7E6x9jE1jAG4pvw1B+N4ActZrBfVhvmdohcKqhL7voZi1si/KOPzLz5e3BdIXPcTvwnAkasvftfmubAhWwLcSutJaB8Uj/vVsMf1NrYm5iYdr5rNThhf3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128664; c=relaxed/simple;
	bh=NI+ZsLlyAp0vCsHTBjSSfX7x42wLafVICoVl5LoKmpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CCYtbE2vJeJ/zOiSldsHfp5sx61erCrw+2WLHr+tN3/QxpcQHNHcouFJ4m2pOSjSc0zpoQ6tIe3IsPFAa2gbCvYDPNOKVErTRBOI5IAoRY+c/lpEMS0OO8u1zUuyaIId1+bIZoFul5qnxEKHW1hE/9UJMHZ98Apc28kb3oTeEWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQzKy653; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773128661; x=1804664661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NI+ZsLlyAp0vCsHTBjSSfX7x42wLafVICoVl5LoKmpA=;
  b=FQzKy653UQSzjFjmxtB+Ytlji2RciZVEtyaNgAplREPE+233yzryM5vg
   3BAUMSZ5kw8w3bxHj26hxF2Zg2A2tBEhtvhzBc7dU21wNdCTBqhm52gwG
   z0UTrNk0TqjNMnYYX3zixLmhM9wouiSbelfaX9a9Eg23B+qvpRvkFeghX
   A8ZKw6J2DHofTXrEhJpuv4W6qaB4m3QQ9ufe5ChltgFdoUEJS9encXlZZ
   yHYUaFgtxQv/Fwc66WeTURZzCUQijxT370dN0Cg9vKdXzFUdLtAMajXBc
   CWxKCaHzHrNBhxCtEIXOQVAOSIwUkuPnQUDTBv/xWPOxLW9XLu5PVcjuL
   w==;
X-CSE-ConnectionGUID: DVQ5taFjRW6Ot5oYzR5V5g==
X-CSE-MsgGUID: iw+vrWy/Rg6D/1YNufVJ2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="78044001"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="78044001"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 00:44:20 -0700
X-CSE-ConnectionGUID: 3oCsnzYdTp+sF8Ge/pWhUw==
X-CSE-MsgGUID: hT1mQrlATV+A6HbcU+K6Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="218017349"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 00:44:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 00:44:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 00:44:14 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.59)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 00:44:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G556tbvROK/Cl5wzKmeD5Y5haVygWq+c2SXBnb3lwE4I9w45UEZSBlmcsHMuXb025alhWEUtqCFHX9iHhdwcUR6jvNgH2zAD0IZhoB0Jj3QzLFuaOS4YCDn9wFQF6cE6LO0ho1skeX5FQBxYH8BWJ0m6tupJ5iv8FlCCwmGZiD4FaIK48roRNn294fe5xeqGEb0Y/kGcHBzLHs3uDo2lGpvJgHfCwYyZa3+uFXZbUpmX94emOF/qRFvmToRacPyBA0dpCI/73HS3LyeHpOrR1XMaLk6UfhbJXSiCFv4FuzWASg0Al3EKPbH186LJ0fsAdpcVYwt1SQbiIC0SW+Lwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+FV0BsV1KvqIK+a7A7T7SYiW7uKEp4bkrJ+2NE9fBw=;
 b=F1vMN3Rl5ubB3dUUPMhRWK/Xae6i/xYh8KYG8c0OGJx/fjxqyGtTlCMUc1rifht+KY9W2YGk2qxvoEZnL6MXDiQc8w/U5x8RpfTIUq+tEOTRUhoCd+L2fiaH9lmK9qrZniW9DmspqGRg874hycSOCKU0K1+wpk7U4QpUID7XNBrIcuhGiPGgXSEMnfgiEU/sc8DY52Zc6FZynSrR9JpuA/jnqJTv+I+WHI0oHQTAf8fEWSdJgyZ/NFWsn6CRPu6kEGMzP5YTevrPeDnxjybgo+fUEBNA+L//0GkAQ7ovHnUuV3MI2Atr82ux+cgCFMoxZsObWnnbkCu1BxzNzWmnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 07:44:11 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 07:44:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 2/2] igc: enable build_skb
 on the non-XDP small-frame RX path
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 2/2] igc: enable build_skb
 on the non-XDP small-frame RX path
Thread-Index: AQHcrmBIrluTPj9hFUCvwnCkNEN1QbWnZoJQ
Date: Tue, 10 Mar 2026 07:44:11 +0000
Message-ID: <IA3PR11MB898643FED5DCC14C0B208BF9E546A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260307182808.155027-1-kohei@enjuk.jp>
 <20260307182808.155027-3-kohei@enjuk.jp>
In-Reply-To: <20260307182808.155027-3-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB6938:EE_
x-ms-office365-filtering-correlation-id: 07f19f1b-a085-4339-16e5-08de7e78d1d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: ltNF0WILIRIV3IHxRzKrqtJZQB9XdRosSwbGDFCuNFJEjSizVUfM/g67jnxkH8bgIrDE8KZ9gjc8FTEOaOtAI6L9W5JQ/CYiodqKr4OZhcFLDz0vlmiVkChw8y/SBgsOVuH/Dtxlvvwd6toFZR9/wTtzo7Sy3XRivQe/HnIvRPVaXIHVlwZZbcpGkpk043xGTa4VqUgeDdX3o4u+Oo0lq4MYpRMvbGvj9v1FNmogv1yX5hvzWgh3cibnzxuEX6eF9Yn7kyWJw8DCDOPHhUfsNdCJq7hltyxY6eEG7WUhmlVCK1SCaDm6ptyA/7/JlUsPpTwwXKcXGA16JlDY9nehXZyOzvlvCuz43r4cD2vWDTU/2QBKHMra/SdzHUS2esFDePjAPYV4NAHuUHfHXcK83Pnzpeqq1Thdtw8JiZOPTzpQo6cpkTrki+vLj9cWwxikGT/oRm01RyQFO8p/3MWQwOlANrUISUJ+MgqtS9lrRDAoa7GjxOkgYifwGkZsJ4WbeWvMLpskFXi15gIvnyN/fZPPEslHUrcOTanuymaWK8IVAwTZrJ3yNkPrgdvL1CkBXosoNuo4a/X5Q4vaBG36fm8uIJ9AJzzzAf9EKUqgBql38WvGdQ62NpkaqPBPF0dIh5J3UrVtyU9VcmrYe3z/CaCGnb+kdFiwFyiPJvNqhoxRCvIcU2hNs/oMqvbtswu6nUzf+LtRByqFvVVTZF5Ln7YqTwE1uL2O+/LDEIg3Hsl2tmZJCMalEPSxcWezZVoOPvVddLEaUKaLm5kiIsAK4G48SKWmqjR/an2jEYXWXdU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?umvC9Nd+SoUGI/7wQETspl2k37oF9Yh7GU9AuglXj5CBMqq+864jbMJnPhph?=
 =?us-ascii?Q?Lm6TcTbbT8xIRsy46U5WTodB4leWIf0IPQ9OTkakb47hiv3hyMznryp5hoiJ?=
 =?us-ascii?Q?PDu+EDi5kmc8wEspTIUgKAzwwyVm36Plmn8pj+kPCR53i51Br+DGwZSx81Ql?=
 =?us-ascii?Q?aWRRgsBtqoDmELkCWNFfeEDIi7AiAmV09k1q/dXzRaJQQKV83RR3/D75LXsd?=
 =?us-ascii?Q?ToX8Ypo5nN5oiJEJCdrFyGRbkLEPP2klbIVll/z+2P9zEfmKs67I1b6NK6uj?=
 =?us-ascii?Q?jF1/almIKK1wMmYEpK5qsU2jMcmti+3hOvXDFWW7E0VmZ/IRjj8rGK2sOyzK?=
 =?us-ascii?Q?C9uIA1VpEsYO9PhUpEMrv2zOXl18ZRrdiSKZvwndNIzGQaViOCh+8QGNFlsz?=
 =?us-ascii?Q?wCIuXtndG/EXnQxZRzP2SJusERwGBdf5A4gfP6WC+onoWqRiGHJqLIlfk/Os?=
 =?us-ascii?Q?c+mZEcQJnyCDsN8Rxs6pET8qlSbGhZ5xPhhZHaNtsRToWZD0WahIDDXZVbPZ?=
 =?us-ascii?Q?p0mCbk4PFzGm7yJ3cpP6EIlnce1iXwPuh8F4q01a5aMkE4T6c0+KAXeho1bD?=
 =?us-ascii?Q?QWABDmZmtTHeyPDufBkgTjZCtwWPw8bOMjyF3wd7mrnEHlWDRbK0hXAwYM3v?=
 =?us-ascii?Q?nwgb0GtS6Sbze6STYftgxkJ8Pgd7CD0uV2oI7V4Ky5P73JV0Il3u+W/cAzEK?=
 =?us-ascii?Q?PWhn/3O+2vbLdnyivv1vEdSN1/nKiDrvmlf30DO+cTTL8cQeGgrgKTJ81pMX?=
 =?us-ascii?Q?X4ZRr3s0A3zrAxa6Td1YDqdUEyf19P2B/ThUmzWaUcx49rop3PwStLc8ACE9?=
 =?us-ascii?Q?Ed+bVNIlGQ/+w7CH1Ny7TbZ9SmoInasXAZVyE63eKEarY/dYXOcOHDHrQurB?=
 =?us-ascii?Q?nZFG8L4g8O1I42SxEUsbc46f1x83a2KvTYz9zRHkkFF2kldJ4UHzLU92R/eH?=
 =?us-ascii?Q?9tdCm8IYMCRNqH2+dzBoTTQ5w09zPpOXyqaTmbtiGyuf2y0qukRbn0wNX9N2?=
 =?us-ascii?Q?vxogFxTYXp1oJwRydShlyjNIwDBVfuTc5JQAhMphO2OO2Xdcv86rWLmtzo7i?=
 =?us-ascii?Q?dClynN00VFc3zjrfcjAq9lxBUWmLx4ycJD7Oxdqja3lmurQfGWSkWrbUmKjX?=
 =?us-ascii?Q?ujZA2hhCegr2nt6uVwJezhrhLIswexZ7Ed0g3RmY0YURF+NU0aGuvnZRI6Cw?=
 =?us-ascii?Q?ceDsYy9prn6cBcub/D1HGuQS7NHwC4zErbjm+oNsOIzxSv911m2jo+XqOUNo?=
 =?us-ascii?Q?B3RZnILL53f9lXQl8GnBOuIWdPQ9THUILa5s8TLlXzZRwMRCDR/KlPKe509U?=
 =?us-ascii?Q?dFviVHwK5dAbVWI9S8/XdYPvwqXgl1ThVKDFjgJLMEI6+TJmLVR6aPLoXIp5?=
 =?us-ascii?Q?uWERiEMoOCz4699DQMyPreQr4ePDQ8IzGca3O+kfEftUmZDBKNyR+Q3rmBst?=
 =?us-ascii?Q?ZJeS9eCX0qNy5HU+tk7BvtkgJMKKdDNU0CY5D1NH7Lw1y12pxr9X727rQuTj?=
 =?us-ascii?Q?cl4vwRxb1W6BFj/z7f3GYwRpVztZnCCazLZnCxej7yDh6DT4Z2IVHrEGbOwX?=
 =?us-ascii?Q?BNW4jqahnxGuk1yGJE/itFxcBJli/A3Wsl8HDNg/kMCJB9Fmd23no3KP0XLs?=
 =?us-ascii?Q?Ue7z0wiH55010VMovx5t5uwWJeVznULCxZSK9Iopl9UCjvj4NWgOTJIw4wr8?=
 =?us-ascii?Q?rS4XsbKJW9I5NmK5yKXvC1PDUqP4QJhy4gOyOsbRVdsq5UpnvDSMuvZtyHg+?=
 =?us-ascii?Q?/DxI7qWJgn30spcjmPdHzpl4779xXt8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oGuL8Wl9ssWVPY/4CvdRFuROt5bSzNIeHrt5wgvcHVUGXJEPJmQVa1nP1mtKuBhheqJKzwd0Mvsu9uNe5lIm19nrRrMQ1F18JXtjssBpjpUh/qHrmtPB8459DcrcB0GxsoYLazuOgtqlbioOJNDg3VtcqqCIt8Qbg6bg6OdG6c9CafBoEmdaLuNdJRYy73eoplptb8Akbx+5dJhkc0Ck1h9h2klEImU9P5jFpiLppfRRNW+mLijhbXkaBmRrO9k79niLDB6GHJZULGCOxX5lG3yY3CHlwKMxkWi1hD9/vx7gYg8c0ifFKQXfYRJdi2MPo2MlA4UeC7q0rU8q0UToVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f19f1b-a085-4339-16e5-08de7e78d1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 07:44:11.4575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZeHxGJlexNF2HR0xWjAQt+Jus2ryGt50pENbjEFuqzAjQJdcm+gMmMclpsOMZS0n9eZBfnYr57P3IxUG+WP7pmGZ61GZhqZd2/oLQ0otsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 6AC88246907
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265909-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,davemloft.net:email,lunn.ch:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Saturday, March 7, 2026 7:28 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; kohei.enju@gmail.com; Kohei Enju
> <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 2/2] igc: enable
> build_skb on the non-XDP small-frame RX path
>=20
> igc implements igc_build_skb(), but it is currently unused because the
> IGC_RING_FLAG_RX_BUILD_SKB_ENABLED bit is never set. Enable the
> build_skb path when XDP is not active and the configured maximum frame
> size fits within IGC_MAX_FRAME_BUILD_SKB.
>=20
> In a single-queue small-packet (64-byte) RX microbenchmark on my
> setup, enabling build_skb improved the receive rate from about 3.11
> Mpps to about 3.30 Mpps, while reducing missed packets from about 484
> kpps to about 300 kpps.
>=20
> Keep the XDP path unchanged for now, since it uses a different RX
> buffer layout based on XDP_PACKET_HEADROOM, and enabling it there
> would need separate validation and buffer layout adjustments.
>=20
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      | 4 ++++
>  drivers/net/ethernet/intel/igc/igc_main.c | 4 ++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc.h
> b/drivers/net/ethernet/intel/igc/igc.h
> index e66799507f81..acbd2c237667 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -734,6 +734,10 @@ enum igc_ring_flags_t {
>=20
>  #define ring_uses_build_skb(ring) \
>  	test_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
> +#define set_ring_uses_build_skb(ring) \
> +	set_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
> #define
> +clear_ring_uses_build_skb(ring) \
> +	clear_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
>=20
>  static inline unsigned int igc_rx_bufsz(struct igc_ring *ring)  {
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 3a4c1ebe4faa..1f3ed1e4db1b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -474,6 +474,7 @@ static void igc_clean_rx_ring(struct igc_ring
> *ring)
>  		igc_clean_rx_ring_page_shared(ring);
>=20
>  	clear_ring_uses_large_buffer(ring);
> +	clear_ring_uses_build_skb(ring);
>=20
>  	ring->next_to_alloc =3D 0;
>  	ring->next_to_clean =3D 0;
> @@ -654,6 +655,9 @@ static void igc_configure_rx_ring(struct
> igc_adapter *adapter,
>=20
>  	if (igc_xdp_is_enabled(adapter))
>  		set_ring_uses_large_buffer(ring);
> +	else if (!(adapter->flags & IGC_FLAG_RX_LEGACY) &&
> +		 adapter->max_frame_size <=3D IGC_MAX_FRAME_BUILD_SKB)
> +		set_ring_uses_build_skb(ring);
>=20
>  	/* disable the queue */
>  	wr32(IGC_RXDCTL(reg_idx), 0);
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

