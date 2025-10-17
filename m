Return-Path: <netdev+bounces-230290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E196BE641B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 497584E205D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 04:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BD11FE44B;
	Fri, 17 Oct 2025 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsoacO3z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC31758B
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760674032; cv=fail; b=dzL4mo+zEyPWrwVvS20SAKBv+oSGYfI0jytWfO7Gr4HytuBq1HmRTRB9urRDIkmPvDFOnLtvl0UT2IH5hcp8yEbbH7q5lpOVBRCn90IG4fGAVDNggYwfj8NJV37/eGQ4R5We1uLKtneq/FWQV7U1a00yLKmOEqIk/1GUC+Ch1a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760674032; c=relaxed/simple;
	bh=M5dqvPNq81zS7mrRwpmmF9x1BNTWOiqNl68cy2DDJEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LBNg7r6tLXnm4kcFRndHHAzWcUlqhtMBs2byiwkf2+D1o9jaz0rgDT2/aYT/22hiK2V1PffGvJsYFC+hdRdQR2D3+02nhP87zWPjxheKDNKu6PS211vAXnkIKIBzAFPm1YTcUgelhGyA/F2YjNNYEJqSAE+s01T8+h9uHQNE4MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsoacO3z; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760674030; x=1792210030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M5dqvPNq81zS7mrRwpmmF9x1BNTWOiqNl68cy2DDJEg=;
  b=hsoacO3zjn2scj1nPWxukzLQlnDv/F/tQ4vQlXA0vnlbrIAvpS9GUvCX
   y3DZyI4EU9uyHLDHIQRL1bYOagteAd+49oOufMye6MUKPNp7FsnuHJ5qJ
   2G5oFm5ZdO+q6P8+4R6HWCGHsQqgZk4RPneXhVTnJ8FpLrA6oKvqRuSpp
   byz6wsgPV6f0jBEbAKYZg1rtAsQfeNPfg1Cmm2t8sDiWar8CEMK2TMoQT
   1+e82jFhDLmK1tlShOY6JPfSuY8sVS/dLRMr5am/TjImfKdn7HwpKHSMF
   xwfGmuJLyFWtjfttUQaZ8QFoac3rPXv3kXgMds5eD79kc8rK+tuwpDWaj
   g==;
X-CSE-ConnectionGUID: iWI/iPRTRkuyYXlE5ekZUg==
X-CSE-MsgGUID: 5gkVnWeVTGm1JZFFSDolIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="66525620"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="66525620"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 21:07:10 -0700
X-CSE-ConnectionGUID: C8EUeOJlQu+sfQ2lcCKNnA==
X-CSE-MsgGUID: Wu2r4tYaQP6UD9SqMZMUyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183424778"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 21:07:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 21:07:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 21:07:09 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 21:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmEj+cJeVSC0dLVeaRvV13ArxZEqdVjnnhZeLYJVVP9l4EXHhfC4uykmNFlv1dh9WNWt/0G8c3w6m1dgwoXBfXMc9S6+B7yJYwRXYSbh/0H0GpWA4Yecr/IN8mPpxC+JO8PYe4IuxC/dZTDyieuvru58PJZjn4iuHMPVhmUkKliPD+PZWdlU4E+7YCHSbJUESKo9TVpg1qZbiI7qr0KS5xVuq5XtV/qWCMGbwPn50lG2KFR70+KYhk7me5PP/0+/nj9fPYfqx6uo5xWQ9qBgN903QCxgapZMi0thkUWQkeB9yt2xL41qk9xw7Qb4Dcik7CZvMN5jtQmerhscXFh4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5dqvPNq81zS7mrRwpmmF9x1BNTWOiqNl68cy2DDJEg=;
 b=hg2JyphA44zlaaDBjpz7HB0HHOdfECKsmH4rEJtu7mWFY6kNrzQeIaQ+pSHAcTYSlIlFbelPgFKvuyH3CVl/uUOGlm4BVlTamTioHSWRHZioMl9FdBJjlqIqMJUsPrWrki7CRMzFPcJ35SMqr2FCl+Du1rV+MKRkpCXaCMj9NB4Xs2htb6T2a9f53WQVVATtLipNxRk6wh3rfPpE/H5eL+uizHJSchtB+ULXTV4yiEWYVfCfLEcs9jS78JXvFnKw8ohgGYssJtRZ4/RJS27IMOYhzgC0NwZsoDamgO/YgJNbS9pXLgh/berCpxvWr0KP8VCNDPK6vaZSeVsR6UNcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CY8PR11MB6914.namprd11.prod.outlook.com (2603:10b6:930:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 04:07:06 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:07:05 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Kohei Enju <enjuk@amazon.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Wegrzyn,
 Stefan" <stefan.wegrzyn@intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "kohei.enju@gmail.com" <kohei.enju@gmail.com>,
	Koichiro Den <den@valinux.co.jp>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] ixgbe: fix memory leak and
 use-after-free in ixgbe_recovery_probe()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] ixgbe: fix memory leak and
 use-after-free in ixgbe_recovery_probe()
Thread-Index: AQHcGraYenSS/2sXuU65gDtgOIvanLTGALXA
Date: Fri, 17 Oct 2025 04:07:05 +0000
Message-ID: <IA1PR11MB62410AA1F608C7BCD85424488BF6A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250831203327.53155-1-enjuk@amazon.com>
In-Reply-To: <20250831203327.53155-1-enjuk@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CY8PR11MB6914:EE_
x-ms-office365-filtering-correlation-id: 79944cb2-0eda-4c41-9862-08de0d32a264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?/wCjJp5eYdXi/8vzKDXUul1NuaAi72s6sPA1FG5Khmxh+Fcl6Z2/bFZzdhR4?=
 =?us-ascii?Q?T0Fgi+AIcU/SGcBeOhhMylL+EioU/XjGSmQONv7insSdl8/EVo8OelF9p4wa?=
 =?us-ascii?Q?QUHVRoDF7E669WrQFlN1yltqT3VVT7695NWd6crHvnicRO9MhVyh9AqQvQCn?=
 =?us-ascii?Q?ywbDu7ILa/yTav1+Jte1THRxuYiuqdFXMLNzvUVGFwMJU5d3YH88Hkv85MPS?=
 =?us-ascii?Q?VGkx9zzOOflHmHetX+udR6dArRKyH78TooQ0o/6ZT0VFlBwLYwdECntP9CHK?=
 =?us-ascii?Q?xJz6rECVECJ1KZoNbVoqwKOt3TFwRaZ4wlVy6jmb4kgD6Li6FbxdeoO0Tspy?=
 =?us-ascii?Q?ekueU/FWVMqSRx2M5CzOHCMGzD02FfCQhlTMSpsk44rlcErH1cJmShKPCIwO?=
 =?us-ascii?Q?CufabXDA72IfSF50Kd7v77av4z1ORrKzJZS4BpoxA8UkvY4f0utK2U/u8H+g?=
 =?us-ascii?Q?pWlLAkRtYnQ53bBEklRVa/+4WUA0u7HVVmQugfHLYjyXLyVOIKfYq6DkKOAC?=
 =?us-ascii?Q?xe4vHtgdmKN3Pa8jcn/JfhD4xRt45Wl0mm+7JJ0Cajv7PzvhTnOWZs7s/P7b?=
 =?us-ascii?Q?uHUhXQh1iKxpJAD4pDj7w1W3GzyBJNC7SJrP0pobm4iOvpvpFoMIFZRk+iQ6?=
 =?us-ascii?Q?YC32x7M15qnoWHpeDKRHRajQq8353EEpa9Lq0uBXNxnB0rjhvsnr8LR2OqaI?=
 =?us-ascii?Q?Xz+YIiapd/yMrkOTZfILcDlkWoFEHt97VJTv1bnPWHwM1YvkG8Dkh2dpE90r?=
 =?us-ascii?Q?nSxO18uA/GnzKyUeoGd6JGLMy6noXZmW6QcQkYsV9GTgQcaNb19YWNHx+PkY?=
 =?us-ascii?Q?F3rbVHSYQflumi81C8y9dBK1eiM6bxXeR/1ZRergXFWE/wjnipeMj28q9HLn?=
 =?us-ascii?Q?SnYz4B3+BDZOVv73TMGtOMMtTf1RKMWKmGC4PWMaASbN1GyFcpnepVBFcIt6?=
 =?us-ascii?Q?zZW3gcLFfRceIM9+sNjPupNvO0BYsoAnFzlt6rLdJ5wAOR0E5EXEovcBp3Qb?=
 =?us-ascii?Q?08BqKR7WrPpgbv35LkqLEXyNTBxlbSR3bpe5mG4P9ZPi++tGaPvFED5XjNgK?=
 =?us-ascii?Q?QEXDIfXjUa5h8TakxjUQKIF4bW3SV+/TkgD8lPhn3/rt0AGhYthKNinnMCK2?=
 =?us-ascii?Q?Gyhf0j/6Zvrm8vN/byLB8ncKk6d9aPrA9meR3I+Qi2TOrO7bPxDUoI6KmOw9?=
 =?us-ascii?Q?udfDLEaY8fOzdYjs9MPsNodQvhI7cAyjFIwGxJ18bhyW2L6eH7+j+dPyc9kD?=
 =?us-ascii?Q?T2BWPOHbwMm4+5esTDeqQ66cZyQheLPrRimQgDu/y0LN74OnTP93JSpkcDyo?=
 =?us-ascii?Q?ntHlkYjKUTyg3CGB/N2q2+SvkBrqDgI25e8UWlLoJ+T3pE4ywgZbxAVQ9hIB?=
 =?us-ascii?Q?aDfCzJ75NA6s+pQ7P1wa7+s8YsjSHC/9kGKqUgKeDYWVgnhIkLodsTozDaFz?=
 =?us-ascii?Q?ETBsqbiX1XBgTXLnX4f4q7inBNhpC0W1JtbnoxBM9+o3J29++T74u45ZgRCT?=
 =?us-ascii?Q?2E4EsGS6ZvxxkEi/fI6ZpFA8lt7D68VaS2za?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VwBTpMU7wbDIyrDI3lVOYT5NhFLP7kjTNFVbWx+0/RfCVmgxwiDE+Z3jH9ST?=
 =?us-ascii?Q?yslzCZ3YlDwHrDwM+Er38vPBfn/cbv6P92ki0AkBP5BrMt2d6UORo+zq9L8M?=
 =?us-ascii?Q?2d3DkytKwN0o04N4As22M9ZqgqRSKQ+6T9Ir9QW885/U11qxZCkCz+DDfCKJ?=
 =?us-ascii?Q?SdNLWMQaG+dpX5gkPaYff3YQMm3lYw7a5G+7ZJGdXt3JFGETen4cHe3L6RJN?=
 =?us-ascii?Q?0ZuPXk50lJBm1VaMC+R/rtdX8rPWH4Gj2UOev0PV/OkUByk2YiZkIKuYZK5w?=
 =?us-ascii?Q?g+xIbu4I/Ijbe4tXRBS1ycbQO3zrpaqapEZFQ0ctO9ENU1IcyCNKJxCLaEWA?=
 =?us-ascii?Q?tTA29JDgRScx1QRgs7aVKgGRv5lc21V/4+O89pW23P0VyFvmSrll/HQwFlzX?=
 =?us-ascii?Q?5/+qao8fVc3mLWIA0RiWSq5rmIIMZrgrL2YnLn6c5Ud/nAFA2ZBDZyLHwkeq?=
 =?us-ascii?Q?v+IT5lMiWGDL+UnTlRMi3vRa7rgjJxhtazRCq1KNnMgg6idYWcBAL15I8vCB?=
 =?us-ascii?Q?T6LAOs1+VqeNqAGQ0/dTQ9CF1rXXN9pZqoIXmSjT9omd3/zJg5HBU26tpFMc?=
 =?us-ascii?Q?nY8QM3N5C0j2DW1AX5OkFjToxhRGVmY0AxBpbqKpSDXGNh81O2HVgllQdiSA?=
 =?us-ascii?Q?EnpXRWu/jMvT9rB5cLuW1iUHf8hoNZrWYFV5hnXW5ekzwM/dPPrAZDiPJUzG?=
 =?us-ascii?Q?w2E1PO18FncCGu8wSvLxAUF5FEWOVD1ghka3NWrYRR9uWJ6rpmrlWxM32jUF?=
 =?us-ascii?Q?S5Cth4CDGrs5Deq8ROQLGcIR0S1A0US9EQf63upEYvsAmtYAW9AlgaBv/jfe?=
 =?us-ascii?Q?ay/Rz4Fhy3SRiZt+HiBTDV2frtKvQKNv4phdlNb71asaNrKxDErOtmSJFSCG?=
 =?us-ascii?Q?bGJD0EfmTcphXR9O/jj5t+Sw2zMcy7DCKo1SCZvcdGSPqVuR+7usVmtySg6u?=
 =?us-ascii?Q?bpz2LgdEUOCOtt4syDbTqGzf99fd5PCXzGXoZCZeKaaz6TBixSi8XEkr67A/?=
 =?us-ascii?Q?uq5z/wkHtVJAX6IOujqtn7a3zRIYBzXJVT2C2N+A+gYnF/O/djrJD5Eplo8Z?=
 =?us-ascii?Q?AXGZ8vnPQW02b7zVc6HvuuW734YJqc0oiwGC75eVZ8z/JRB3RXn8jm36YlQj?=
 =?us-ascii?Q?fXmUXXWFcewVVNBAK+VDXfq+RO68Zl//t2PqpS1K2Nk3mdeB3ujZAuWnHsIm?=
 =?us-ascii?Q?ZcrJ/zGMLN2Bg7n407nMXodhvUrdmRmeDd5eovNFC31nj09gyEYVvpij2e/r?=
 =?us-ascii?Q?U7HOMssJZ8TRBZE0ENrnBDVYsn6cjpL2RiOyi/Ulv+sbkDntYdymXWxSG2BL?=
 =?us-ascii?Q?ftlEZnRc9BwibzNsxYLWnRhjsTfOJwdKE3pfaSBIaAw2UJWs/kuxw3Y7p1Xu?=
 =?us-ascii?Q?gtp5qcB/P2E0jT3fobva1Xj8JbkDHTX0tXpDM71+Yu//seDAJr8f26mTlDhp?=
 =?us-ascii?Q?RD8B/uwnE27WNX62US+a6x2tepnS3cwnDCsPDcyzvCrWxH3hWP1aoELASG9Z?=
 =?us-ascii?Q?cYsEOP7kiZSpont8ZEkAVCYCl3A/1jsANjDPrfY3MNiqGbQ5vvCSZUEhHSN5?=
 =?us-ascii?Q?YiAlSbs5XsgOs09KkzhTzJchKKl8H6QTUR9k4oZz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79944cb2-0eda-4c41-9862-08de0d32a264
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 04:07:05.6770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zeWhj/1qC+8I62ZB0h3vE+Lo3LfhVe1wdqmTRvw1FRB1qSlhrGPWIG+LxvZWqLEpef44MOjiZx/y0Wa7z3zwWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6914
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
ohei Enju
> Sent: 01 September 2025 02:03
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Wegrzyn, Stefan=
 <stefan.wegrzyn@intel.com>; Mateusz Polchlopek <mateusz.polchlopek@intel.c=
om>; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; kohei.enju@gmail.com=
; Kohei Enju <enjuk@amazon.com>; Koichiro Den <den@valinux.co.jp>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] ixgbe: fix memory leak and =
use-after-free in ixgbe_recovery_probe()
>
> The error path of ixgbe_recovery_probe() has two memory bugs.
>
> For non-E610 adapters, the function jumps to clean_up_probe without calli=
ng devlink_free(), leaking the devlink instance and its embedded adapter st=
ructure.
>
> For E610 adapters, devlink_free() is called at shutdown_aci, but clean_up=
_probe then accesses adapter->state, sometimes triggering use-after-free be=
cause adapter is embedded in devlink. This UAF is similar to the one recent=
ly reported in ixgbe_remove(). (Link)
>
> Fix both issues by moving devlink_free() after adapter->state access, ali=
gning with the cleanup order in ixgbe_probe().
>
> Link: https://lore.kernel.org/intel-wired-lan/20250828020558.1450422-1-de=
n@valinux.co.jp/
> Fixes: 29cb3b8d95c7 ("ixgbe: add E610 implementation of FW recovery mode"=
)
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
> Cc: Koichiro Den <den@valinux.co.jp>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

