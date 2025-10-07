Return-Path: <netdev+bounces-228068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B31CBC0C01
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F8A3B8B4F
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC7A2E2659;
	Tue,  7 Oct 2025 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhlOsGWK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370872E22A6
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826084; cv=fail; b=GQO9mVyMlb1uiX+Fqc0n4Wz2JAV19qbo3ghya24hCnsJ1CsJj3am673rdO9z36xNTlqMkXXW994CgvS867OTWCRHNaG2qrM3prv/fqfi7KEJzkNPWSQFX16hCqO5CLDCbB3Dsa/Lr1ep9lYrl4tuwNB/sEJyfQn01Nw5hmV7Gs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826084; c=relaxed/simple;
	bh=xesylYVnk5iNyt6PQvO0Nw7aJXT+2qPtJPtik7HtqZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TzaIco3xHirpu3FtCEeptOrmgPcgcj28ooRl4IwtmDxVXs6HzBw+XUTIUH1jOU6VtjZObO0jqNd7zmYVG12BMxxIcVGxl44z4CbPvAsMWjcKypHnLXkP2vv6G1c2KLNnlJuPXsPgz+QWQ/mf0AzKeyEMvMcB9NtP2wcybuPyb+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhlOsGWK; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759826082; x=1791362082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xesylYVnk5iNyt6PQvO0Nw7aJXT+2qPtJPtik7HtqZk=;
  b=XhlOsGWK66bez2XHydx1FNa2B21EBQ5I6m16mhWSy4GkLWiOMczmHCKd
   mDiQJhmbjhOKaHIY1fxFmhohEIlEKNnoXX4qOaI9yoJ/DB/FRfwnF8Ikw
   O52kUGJ/jIiVOr7hmPoLzAeHqijO6wnqOqdy6PUdwozAERaQLgTmacRD0
   4yqdC/jDaZxnAd/M4xffxWrcNJiII6yFQw2e9GB9BdYQt+T0Qr/ew1SYt
   hn55TNAd+jxV6DJuReW3IB92pdY6j/1MBmmdKHKEOl6Q8iIkAyv8klKAo
   S6dSb65ouUO4KpIrJNSNMi3/Yr19gjtcCHzrujCP5s/uuF0xTXR1EMJDA
   A==;
X-CSE-ConnectionGUID: kCBNwlLIQPOxzdWg+xGY9A==
X-CSE-MsgGUID: vuhVlg/ZSnqkGMmO/z6zaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61920176"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61920176"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 01:34:41 -0700
X-CSE-ConnectionGUID: xtty5bOlTjCt0bgwpOiwnw==
X-CSE-MsgGUID: Hm2XtTtYSym7TO5PoP7OBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="179764458"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 01:34:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 01:34:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 01:34:40 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 01:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzKkrIbARgkh/EX5IZdjt11wmDtNX1ZTu2i/LxPDAl598xTVuubGQI0noBW+kV93VXtS0A2H2OOygnbhRx7zssgQIi9JWbE+1oWBu6cNV1+7W3/ddthdls9QT37EF+epGZCJBCJJEyDhkDtSzEg2BicWXQXKdFP+fUna2CIQ57laIp2d2pbNaHoi3g4z3kA5YV2gLf9FwYEx0dnSaj3S7+teBow+canE9k9MymM4u9WaFoNc2uRYAHky7gtIsCGfuzBBhz7K8+F6m/prsNZslgQIgxbLLApgsdJqqICSUIMlc74wcm8pFHLrv07mYhGX/34sLWc1Rah4jyFtLRkqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs41EWnALBCo9pWmymd4QmY6vb/Uz3RRogl+l5D7PLU=;
 b=c9OMOf8J9c2Y3qUPcpURGsZsE3AbBHDHKA7FcgXqGxNQVak6boCk50QGb/BcChfwPcq16d5k/VeqEIbRWDqMtG0v3UVfIHk4IZvAN5zhLtcpTNsjgcC9UM0l9T4TFB3ahwjctdYPGBlEgnX9XfyuKDTgSr+jPWLFGLl0FDw9JPnchVbCaMHVFDmMg2ze7g6FeJZ94wAUCvlCLQXDvo8qKFxnF5GWaaU1mYIkCzV3qb8DTfaFCiJN+5I4ISs0rTVvsJ2dSGOjpystSEo2EVnogrBViIJqcSb+DlVN/joOTvqWMPMM0RSYgpHl1hiwJnbxtLLYPwHxAaE9S3gf/TCkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA3PR11MB9013.namprd11.prod.outlook.com (2603:10b6:208:57c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 7 Oct
 2025 08:34:34 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 08:34:34 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Kohei Enju <enjuk@amazon.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, "kohei.enju@gmail.com"
	<kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4] ixgbe: preserve RSS
 indirection table across admin down/up
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4] ixgbe: preserve RSS
 indirection table across admin down/up
Thread-Index: AQHcKhkJWoXzl7pM5EqRpHNSC6xNOLS0644Q
Date: Tue, 7 Oct 2025 08:34:33 +0000
Message-ID: <IA1PR11MB6241D8B141819B59034B8E428BE0A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250920102546.78338-1-enjuk@amazon.com>
In-Reply-To: <20250920102546.78338-1-enjuk@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA3PR11MB9013:EE_
x-ms-office365-filtering-correlation-id: fd60667f-3da0-49d8-3672-08de057c57db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?cHm0R0EzHIw6J4gLqrcd+BedkUSfFrn1liLC6U0twkMlZ06V7h1LC/EtNHP0?=
 =?us-ascii?Q?nTrGeyBgFhQaS5UgVctV+6VWNGOp/QQRAtdSG8N455J/Nyot5sfoDBiv8o7e?=
 =?us-ascii?Q?SHEkOsfYGxFUkk/HcNbfUlmhLR/Y8+p2fZMiEKLTKDXMTLvvdhKsirp7XWsX?=
 =?us-ascii?Q?H3Y3nBbk9JC0kKiywE+VuoKL3LTfT4kJdYEdMI560vuBnCTfHC/lTswWN2YT?=
 =?us-ascii?Q?UGPQqvauqLZ3NrnvYcmZhmFnK9jFx403gHWtAsTYrmklpCcxwvYiWGeDnCU8?=
 =?us-ascii?Q?Au8dEu9cfvD5jaufg/IuX4YCKjEY4blpMXEtNMJhQoqw4cussDe5tRKe/ZV/?=
 =?us-ascii?Q?dnr9fINMedeVmIMyhw2KawTlbXTjGb6YTl8KSJtD/8Xn0Yuww3M5wUPJMwau?=
 =?us-ascii?Q?7Vw0C837Vj8UIYzNr5T6p1TCIpSUx6f3BPZjaID0DCjvLGo2letNSjIfzRws?=
 =?us-ascii?Q?wbtwM7HdhqH1Y/rGPbCMbc2VHMXuX7SAlJ9UUk9lNKnHc6HDMGBvAsyt9FDR?=
 =?us-ascii?Q?UDFz5nDHN4ED6uL1rSMVyut2fDcuK3K2EkzQuBpvJ/jZplfraqW3hYflLrHU?=
 =?us-ascii?Q?gOdqHsMX6iIytlfc0NFSu8amwgVZ823/aVOYrc8+tcbJzoicBJjXtxsvl2WK?=
 =?us-ascii?Q?ES/mZPNmPBdbJs+zSy2uNKvechC/yZ1KBYiT1zxU3c6r2wJSQK9Eo6qQb67+?=
 =?us-ascii?Q?MFXfaqBPJKjdbT2tUgVXbKW4wWnjs6YyOJ7J63hZCYaPw/78dHeJ4fEo5ULf?=
 =?us-ascii?Q?SEhoRotWdx81aKeM7QdtZmgQpy/33ILBZ25TLg/y4At2XdR+WV1EpYZfvmC3?=
 =?us-ascii?Q?EWyVnlVIPnoadgv+ab+MIpBjGs/uDNUOoR/jScYURUXFxvwEae0bd2ZSA8tt?=
 =?us-ascii?Q?0TI2pkgA9MDKOvUtXyZ95ExkE9ZrxiuZW7YFTzKIy1VpzLdaWrDSzPZH7n3c?=
 =?us-ascii?Q?w/sQaRu1ZKA2U2u4ySk/8Py6Akp3f8olcrL5doY9i+NSbR+Y1/FxduykkpEU?=
 =?us-ascii?Q?SbV4zo+UWrIw7lIcegavPERlg+LkYHI7pzJCHJM4awqLbtv4upuZnpT1oYRf?=
 =?us-ascii?Q?NQ/z1uEQ2f15HB9P8WXMBDuatHH2jKHbrpbwedn5yATTgtHfmaPK9J+SO/Yo?=
 =?us-ascii?Q?9o2LC3XPz5YfegVG7OJRuDCjfzNHXJSVcuxg1uO8/FGlBSrKMQBY0M7cAqQE?=
 =?us-ascii?Q?zVFGvqvfYnVONBW43J/Vcnsdc03lRB8FQ3doobcUEbVTXPBwK62Ls3iol69F?=
 =?us-ascii?Q?Z3qo/FEnAsw9y2NKh0HNpI5Ry5zJjVWQgzZUf+ZTuhfwhRzV7Crw5XVPZ2KV?=
 =?us-ascii?Q?T9OruNqAC7hwyz6MErahasXCAe7TKh/IO3x0HEFVnkF+vQmo1JjTansJL8Zr?=
 =?us-ascii?Q?iaPzOPM1JJleEosY5ZiSE0iwf/zi6LwNFmYXDSutCOu5KRXZXZEm/ZZRbHBq?=
 =?us-ascii?Q?pwFsWBhyWKxMCmfRUF/fD4j1UMhelTwAfqxazN8Dgns2smDBp7sl9KOwWJeK?=
 =?us-ascii?Q?GnTIKSNlywpLUX2rF+zhiXkM0tR0G+0s+9vYtoLY8z7ro32XsdlMBYR/vQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M7zRR6bVi50n8OTPwyVqWim2ei0cVG/m/R6RC0fV/9DjQXezAIe20tbEmE8t?=
 =?us-ascii?Q?iYhrtGOzw8IU+ZP82gUSiYz1tNfWOA+oi8dL4eprjv6YRfwfKdxDKzyQGnxE?=
 =?us-ascii?Q?ebTTbZ48rro+xE/QUryiqUXxymK2JRmVr9m96KW0QeTP/4hzqwuCCyOIRPoV?=
 =?us-ascii?Q?PfnwavAPqbri8l/H/w/8UCykEK08YkHqkC/fstVtA5bdjCeDlWHll1AM9OZT?=
 =?us-ascii?Q?P9+NS9HY12OGoJ66jaA7ttkGmtSv+UxT5yBzMIeiiM+raYmPi5z9i7I2qooG?=
 =?us-ascii?Q?+y+bJj7/QZki09j3e6UkgGy4Y/n+r7oGgn2HRmpsFl8QeqzFgWoNKfUkx8nX?=
 =?us-ascii?Q?kvZ9nVE24LapaVt/wsB6t7G/6tZVkvlNTOvNgYwRRxlaH8NQkydXDCE0gpgP?=
 =?us-ascii?Q?lMfSsYQXJyHDs+fRVUxGXZ3Q4eXjvk7czrCNKi18YrKKLVRIyJQBpCLOX/rL?=
 =?us-ascii?Q?TortkBFAhCCCeidZepvKvhC9rk3J7NjdYubgsIRn7rZaKFibbdwbpXCVpSWd?=
 =?us-ascii?Q?tyv3nwPfL3LjpsSeuLx8UFZdetWtX0C2yjLE8eV+9ZJTXh4TNUhSui+iGZfJ?=
 =?us-ascii?Q?06jQH5jvv/+3wcChVvcMY8atxnXKsUv3UQyPYwhykz3EVevEgApIHiN5y8dt?=
 =?us-ascii?Q?LMcdf/GYT5jZ7vRNJxHqGH2HZBNKTNRdah3jc94As4BwzmjJKU7Bc52R6+Nu?=
 =?us-ascii?Q?m1WC2jedHcFSzuZ3w8JfbEd2+0ZiG9S/XEubDdJbHDF/MngktAFShGBOb/PL?=
 =?us-ascii?Q?zuh49/9H8YJXFRg91SsC+Pt71vdPyOth0VLrNP1x/CuabCBigpK8vgPU1vwo?=
 =?us-ascii?Q?gf0ahXp9vJaaB3ZYmKlBFLcX2T2j9qdqHa24U24GyWR7PwyJgNPGWaYaMxpv?=
 =?us-ascii?Q?A0BrtkjZoNFUcB+WlfigPNIfQ8RgfWLftDgZ3dTALppJzgeeVeE1CDL4QSM3?=
 =?us-ascii?Q?vrwYSP+Y0RetySB7tM9607wmoWvHxDLdMvum0QDHUGQQvIOhWSg0n6WWdGAs?=
 =?us-ascii?Q?kbkyeYhy2QGDrz9iAut9e++IqdEOo7LRIqwi+w6exyE2D2pvODtxDwJgFkCI?=
 =?us-ascii?Q?x5fQW0gxCBZaFon5qzcx592sJAJW1D3dhBPawCJt+GWaoMoY5gGrfezCRBnH?=
 =?us-ascii?Q?qiNh/heTiu6oqkc5WoAWm6j7/ZrTksMmDmyYJzSX6j2aKyx/QjWg1YUqh9OC?=
 =?us-ascii?Q?xsc6T1EZ4DMY0a2n12N9YeqzSRP/JK2kS6hFJqk17lVdU1Xaxb0ysSZcSGn2?=
 =?us-ascii?Q?JPxZt5YHIPl6h/1zKG7/6tmKtqh7Qn8b6LT3/noidgMWsbe7B1Pad7JocHOC?=
 =?us-ascii?Q?yLhpQu20Drc6mdnLuYwPH5G6ehljeYqGo2WAAuv91uHTHCxk9CCUiPtSsDYj?=
 =?us-ascii?Q?4mC44Rho5I+daBMEHI+DB6agFFY7/ZBm8i51s9RgpIssVT2Lb9dB0fmX5UiK?=
 =?us-ascii?Q?WdiZquCuUnI8bMcbe4vtTGH2GLXsJ716RXOCz/thMKHOUqla/ZwVsuW7weuV?=
 =?us-ascii?Q?fUhj279KpLj23VwBsG54/tyGJUzuqrjZx2S95DoqtQmB6wWc7E+xALSHu4Ve?=
 =?us-ascii?Q?oySMO6ry+0G8sLNKdw7rGo63r2dv3n/B2vMgNpob?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd60667f-3da0-49d8-3672-08de057c57db
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 08:34:34.0467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxXVWL+ICEHL1uH+AuPD32EcuI6FfBDQ92DuEVj0szWHmgKNf1Gr79PIn/eBqQZ5HqJBtqUJT0z4NWDTVWZEAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9013
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
ohei Enju
> Sent: 20 September 2025 15:56
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Loktionov, Alek=
sandr <aleksandr.loktionov@intel.com>; kohei.enju@gmail.com; Kohei Enju <en=
juk@amazon.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4] ixgbe: preserve RSS indire=
ction table across admin down/up
>
> Currently, the RSS indirection table configured by user via ethtool is re=
initialized to default values during interface resets (e.g., admin down/up,=
 MTU change). As for RSS hash key, commit 3dfbfc7ebb95 ("ixgbe:
> Check for RSS key before setting value") made it persistent across interf=
ace resets.
>
> Adopt the same approach used in igc and igb drivers which reinitializes t=
he RSS indirection table only when the queue count changes. Since the numbe=
r of RETA entries can also change in ixgbe, let's make user configuration p=
ersistent as long as both queue count and the number of RETA entries remain=
 unchanged.
>
> Tested on Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connectio=
n.
>
> Test:
> Set custom indirection table and check the value after interface down/up
>
>  # ethtool --set-rxfh-indir ens5 equal 2
>  # ethtool --show-rxfh-indir ens5 | head -5
>
>  RX flow hash indirection table for ens5 with 12 RX ring(s):
>      0:      0     1     0     1     0     1     0     1
>      8:      0     1     0     1     0     1     0     1
>     16:      0     1     0     1     0     1     0     1
>  # ip link set dev ens5 down && ip link set dev ens5 up
>
> Without patch:
> # ethtool --show-rxfh-indir ens5 | head -5
>
>  RX flow hash indirection table for ens5 with 12 RX ring(s):
>      0:      0     1     2     3     4     5     6     7
>      8:      8     9    10    11     0     1     2     3
>     16:      4     5     6     7     8     9    10    11
>
> With patch:
>  # ethtool --show-rxfh-indir ens5 | head -5
>
>  RX flow hash indirection table for ens5 with 12 RX ring(s):
>      0:      0     1     0     1     0     1     0     1
>      8:      0     1     0     1     0     1     0     1
>     16:      0     1     0     1     0     1     0     1
>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
> Changes:
> v3->v4:
>  - ensure rss_i is non-zero to avoid zero-division
> v2->v3:=20
> v2->https://lore.kernel.org/intel-wired-lan/20250902121203.12454-1-enjuk
> v2->@amazon.com/
>  - s/last_rss_i/last_rss_indices/ for clarity
>  - use modulo instead of top-of-loop equality test
>  - use ixgbe_rss_indir_tbl_entries() instead of magic number
> v1->v2:=20
> v1->https://lore.kernel.org/intel-wired-lan/20250828160134.81286-1-enjuk
> v1->@amazon.com/
>  - remove pointless memset() in  ixgbe_setup_reta()
>  - add check for reta_entries in addition to rss_i
>  - update the commit message to reflect the additional check
> v1: https://lore.kernel.org/intel-wired-lan/20250824112037.32692-1-enjuk@=
amazon.com/
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  2 +
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 45 +++++++++++++------
> 2 files changed, 33 insertions(+), 14 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

