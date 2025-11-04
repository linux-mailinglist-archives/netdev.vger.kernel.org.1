Return-Path: <netdev+bounces-235389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F580C2F9DD
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 08:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049B13BBE12
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 07:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF31306B31;
	Tue,  4 Nov 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2v1NGXW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56567126C02
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241428; cv=fail; b=U09Lnay5efWwdYt0lin/AA07UyF6JzjkQCAqz23ddI+gJeqBJZKdAKZKoUJxdg7SxLDR9jipZvj8MFdQK/pavlv5V2U84t5jMUfQ3CdcXZdi4R/jPSWqpescRb1qJfzHx77B0CD2WGyCbKvQi4TEcpmKn0jBvxy/ccrSZ99KmTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241428; c=relaxed/simple;
	bh=SkSYM0lPnTOMaKRCc1WnZoB/BQ56roqWRO4FuS31fBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KoynIk8eAcdzFnTS98QVRTLVRv5aFkmkY/xlfnFmfYCIIGvvgA+RUsv9iuKDkjzyFHtvtn8Ir0X6FSrgdZvR+9L6iVnYlaA9K0+PdNmQhW4aBuZjd2ub0qmkDwGAhTqZVtPRKR+Td9IrKN8pkYq+5/9rvy0R9wRLM+EJ41uWv+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2v1NGXW; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762241427; x=1793777427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SkSYM0lPnTOMaKRCc1WnZoB/BQ56roqWRO4FuS31fBk=;
  b=S2v1NGXWcG/7+pGhcquNTv5GHPv5eIdLznDb3Xdc9kDZvJQxbrQd102q
   ps/+euo5eew6L0sgaeUepFu6ZZ3vRVIBk3ozVCk3vrDcU3O5J1K+Bgliw
   Vytsi6j6Gz6NirXBFUWFtr7U12zE2aPHzPdA0XPwXPNOArutBEsdf9c4a
   HPRoOv2cb22okc5oGCynWPdyD9vaftiD3dGB/dkXEOnq7h44bPXOAFohl
   f6NwStK9DmpgQsM0yL3+2SvAVqmhgk+Z6MQgjb/OwM9bGRN8Pf6CXRHS0
   cMjur4GkV5YDkPw9rCELPKPc7nJ7a94tgTtQCMLdjSF09O56zocUuA5Sc
   Q==;
X-CSE-ConnectionGUID: SJs487PTT2+EvfJhK16osQ==
X-CSE-MsgGUID: iujOQT2nTne26lT6xD0pEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68166154"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68166154"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 23:30:26 -0800
X-CSE-ConnectionGUID: kNPY41OVT+CqtUNbp9R1jg==
X-CSE-MsgGUID: w9MIjNMuR4GIhEl1H+Rg6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="186944916"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 23:30:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 23:30:26 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 23:30:26 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 23:30:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHdzsuCklJ7kff4MjbXuzxsw3kfzlI3V0Dn2FhZSyVzehoSpj7+u4TLG0DzqoeWHzD5zt0KsEzjwbQHrnQ0kqQsreAA50nDWODT7DmjLvv59DnXK8+My7YbcxQDdcME3HFyYtbN08l9n7xDUYf88m0bMjF5eySvzPrNmDsr0hgkj7ET1AYbivGzX0F9MhMKsXE3cf3F8aFF3WU5bOhXLoi3MHjShVLtw6+Xkxo2ZichUF7oK2WhcLdVMkQsgaPCmX9LajoqrSHscSOX0guDqPE4qUdA4NccySm8ZCqJ/2k2qddwCv9WtffyAeCInDUgfhri7nqyA29gY4w59kp/pRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkSYM0lPnTOMaKRCc1WnZoB/BQ56roqWRO4FuS31fBk=;
 b=nCRQrodHOUJRIYeIVCZJuPaHcRXcq79B0EmYVhD8CF4aVi0yJOniSGrUuc0G/pNKuntxuxBZSvrHE0eQD9dlCH9pjDnDoUJqCIo6jootUcTsFFttB32vg1FsKah3UHO1Wv6yc+W999jXn7c1TisKRcjjO7OHWEQGySdzXZKTpybMPkKh5kXKyPyOfn7dAWMdlcdaBQdhVfda5lWlnu3tXAFaWY46oYhXCYNNXuNg/3M8kPHWZ6l+l2iczttEUppJWff9t7LiT3U1Sfp//lAkpw1WNcc2iUPvQeCQ6eIXDS1Y7OaXlYkz4AdFc9QoL4siGLx5J8h/GgmLJH6+g34YpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 07:30:24 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 07:30:24 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next 3/9] ice: use cacheline groups for ice_tx_ring
 structure
Thread-Topic: [PATCH iwl-next 3/9] ice: use cacheline groups for ice_tx_ring
 structure
Thread-Index: AQHcTSdoHLyYh/E78Ua0FoLy3uW1lrTiH0Aw
Date: Tue, 4 Nov 2025 07:30:23 +0000
Message-ID: <IA3PR11MB8986010B12E23F70DF598C65E5C4A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com>
 <20251103-jk-refactor-queue-stats-v1-3-164d2ed859b6@intel.com>
In-Reply-To: <20251103-jk-refactor-queue-stats-v1-3-164d2ed859b6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB5143:EE_
x-ms-office365-filtering-correlation-id: 8de8aad1-00ed-423a-7c67-08de1b740490
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?bEc2dEFtUEVUS0hsUDNsd2ZDQVdneHRqQmR5bDloamNuWnNyNDB1Z2hOV0I2?=
 =?utf-8?B?SCs3citVaUdSdDl3UXltK29BcG9sc2FGTTBVbCsrK3FVTFNYdHRIbFYycjJr?=
 =?utf-8?B?MFdtQ1NIbzhTNTZPc2dXNmJQZHFhVzhwQnhzVXQ4QW1pbWVMVHF2SzdLa3Q5?=
 =?utf-8?B?VXVhb2VRa2xXTzhFdFVza2wxL1cvSEhhbnRaWWRpTndkUUg0VkhBeGR3eDNH?=
 =?utf-8?B?WGRTb3VBb2FpQTFkTExWZzcvWkNQUHFodXhTcDJ2eWQyUnlWb0orY2ZnSUoz?=
 =?utf-8?B?NlVFYUVjNURDVVpMWjhtTHMzWXBSZTlsK01kcVFQM3F0THRoNEhJcDVRTDVl?=
 =?utf-8?B?YTNDMnVxdllhOUE1aU93TzFBYk5lL1hVMFpESm1jbi85M2tOTGJidXNDdktG?=
 =?utf-8?B?S0sxWHVUVzJUMG91L2RNNVRyYUMwcUZzWkJaRzMrZnloT29pUU1xU3kzVVls?=
 =?utf-8?B?R01NcVJpaVIvbTBKeTM1cnR2N1NBVFRWNWkwVG9jNnpRcUd2Wk5rblNPY1N5?=
 =?utf-8?B?SmdaR2tyK2REem42V0JhQklkZzFnYUF3dDdtQUsrRlFEQTB0aTgwWTllQXFG?=
 =?utf-8?B?ZWhPcVVKT3lBdWx2Lys4N3ZpbEJRUDFpOXFnSVJSYVVjdTBobCtidnBzNU9D?=
 =?utf-8?B?MWNRUVcvQi9jOS9qR3dLSk9JQzBvRGUrZE1BU2hFT0lGR0QwL1RhR2ZSMnBY?=
 =?utf-8?B?OHlxZXl3bXZUSXcwdTh0cjI3OVFIUnozcm1IcU83ZzlNYkZSL3ZTWXNGWndt?=
 =?utf-8?B?Y3BjajVnNk83VDBJWlI1NTN1N3hiOUpGZUFRNVl0cmJRSGRPUDA2SGlUaU1y?=
 =?utf-8?B?aE9WYXBwNUIwMkhEZXZHVnFsSlhEcStWN1RhQXRlWDFLRGRDWG1QYlltZExU?=
 =?utf-8?B?UHVuYWVZT0tNbXZwT01ORURsVzArTjVDaGRnejIvUURYYUwreUxQaEUwcStJ?=
 =?utf-8?B?TXpITVJ2UVJvdi9RQzhCUEpUb0RINi81S2k4UGRtUndEVzNPSi9UUEJjYTF6?=
 =?utf-8?B?TGo3dHo0SGFGWHhRbGNjd3kxTmhNRzFaMGY5OEdLbVMxc2Vjdzh5NmtsZ2ZN?=
 =?utf-8?B?cktnSGtLQmt2bis0OFJyTnBrd1o4bmFjSXh4NTArMDBSdk05Nk9DNHk3cUsr?=
 =?utf-8?B?MjlUTHdVWkxYZXZBa3pHYUlEQ2VxbllreGZDM3NGVVRmOGVXd3I5UlVFM2VQ?=
 =?utf-8?B?dThzVzJ3MU04UmYwb2RGR25SUHlaT0h0ZVhVdzdEZmVDbkFBVXVBcnF0cFJa?=
 =?utf-8?B?aXVpcEFWaEJkejNqcE1JUjVnTys1OEk4Uy9nTjhnSzIyaFc2ZHd1MHdDRnVI?=
 =?utf-8?B?Rk4xNGNzRFk0WnhvWUVyVWlqNFdJYUtiZHc4V2hROUZaT1FGaGdyQlhqWnVE?=
 =?utf-8?B?MWhrM2RJaXR2VGpKandOdDg3WmFZWFU0Sjc4MVVmOFpKdTIvWUVHeHpzaDFE?=
 =?utf-8?B?Q1NLWGkwYXgrVnJ2Ums4UExQWFg5RWQrR0FhRWZiZ0NDdGZtUHNlY1M2UlY1?=
 =?utf-8?B?aGhhQkMvMHQ3d0pWM0o0UXdrV0lNUGdUTUl1REQ3aGFnQ1lKRld6VU5MT3NM?=
 =?utf-8?B?WHphQ3BSNlROOTFNK1EvTElVLytTU3UyY1NpTHVqZ1VLMk1NZ2xKR2pxYVpC?=
 =?utf-8?B?VXdFbjE0YU05L3RSK1NNQ2pwekxUMk9paVA4d3JuUk1Kem5aWitoZVB1R1ZX?=
 =?utf-8?B?a2ViVVhLU1lKdzdzYTBWTFg2MjNBUVZpak1rRUp0dlZEZElVS2xHNnlqaDk0?=
 =?utf-8?B?Z0Z5WlNXMDhFSGw4K2Q0QXgveHI5Z3BiUXZqMXVXUDI5QWZYZjdhcHRQRE1l?=
 =?utf-8?B?RmFUNGFNb3hJMUt5WHFWY3d3RFN3ckRmd2R4Zy95aVZYRGFyeVFodHJWMmJs?=
 =?utf-8?B?N0hmditXVnc1RHIvLy8zL0U2SGpuOCtqMWhzY2VxWG1ZSkdsVUVvNHNUbEhp?=
 =?utf-8?B?Zjk1UWNLSnZtUEtJVTR2RU45UUo0ejlkR1phcStOSExnaytSRHV1b2FRbWpE?=
 =?utf-8?B?QmZRczdKR1RIVXMzbHpTUklDZ3IzV0QxRE00bGZQem1tTVl6dGhiNlc3cjRU?=
 =?utf-8?Q?d5U7rZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djRnWm9YQUFET05ldEJLcjl3OCtrbVlwMmdaZGRNN0JadmZiMTg4MnN0SWRK?=
 =?utf-8?B?bDhTL1o2aEg2dmJrd1BVOS95N2pQTVQyZ0NVNmpOTGVXQXh3eENmaEhHbm9v?=
 =?utf-8?B?Tm1kWU5VbWZHd3Ezam41QmFnREpMV0RNRE1SN3F6a1JteEFTdTNySWtpRTJ2?=
 =?utf-8?B?bEdZZUJuVWRCU3d2UmpYdk15Nkh1eDFUOHVCVDY5QjE4V1ZOWDQvUmVGRGZa?=
 =?utf-8?B?bVB6NHJnaWdQY0g2YXQrOUxzNGJEeVNrbVFtNkIwTW95UlZ3WmUvbzVMV0x2?=
 =?utf-8?B?dVp0SjNRdzNRaGNxWW1vQ0Mrcm5ObVhQN0prMkxkRFVtQ0psVUNHeEM1aWlC?=
 =?utf-8?B?eW43Y09JY1N3VHpITHN3UDlUOXlGMjN3T2U2RVhubWd0YWJTOHV6MHBjNkRK?=
 =?utf-8?B?VzgyMzNjMEJuUmp0TVJ6Y1JLOU9GMEh2QVhrdGc4dlk0U2M5VGphbEJUS1JK?=
 =?utf-8?B?OVo1QW5EMFRtY2RRdEt6MSszWWo5eHpyWVRVdlJpbDE4NDNOb1ZwdjhUT05H?=
 =?utf-8?B?N3EyekErKy9oUlVUSEtIaHI0bXh0UFZ4bnJiZGdvenR4czZYeXV6QlpHRVRV?=
 =?utf-8?B?aUJXbGVuTlBpaEUya0IzbnhXSTNpdENQQUorV291UG1HTlFBZFJ2d3dlNlAw?=
 =?utf-8?B?cEQvSGpubXkwNW5rM0JMY3c4bmZoVG1EUktkdklvOFFVSE5OU1NYNlBoY1lH?=
 =?utf-8?B?VllIRWtqdnhOdXZWTGxXbUFNc0NwbStWMklYT2o0cGJsSW9MK0NBdnNMQnR2?=
 =?utf-8?B?U2lFeDFWdWw5TEJSSjh5Q2pVUjlHQ3RIdnpDRHRjeDIzYzRLbFphVFBLRUhF?=
 =?utf-8?B?S29Gc3NGeW5zRzBFMjVRVTFNRDZMUE96WHZ2TEZMWEg0Q3JtczlKK0RjK3R0?=
 =?utf-8?B?cENQNG9yOGJUblB2Vk9xYU1WS3lIWXJKanptbmp0bngydTV1MGhkN25YQ3Y1?=
 =?utf-8?B?bDZEUTdXeVlPNjExaVNDWDJMdG1NWmpXTGcrVkJyRkU5SXhNSlFOYzFuQ0F5?=
 =?utf-8?B?L09tWjBtNHJ1YUQrczRaM29NSlZGd2lOYXJRQm5Hb1BDZkJXTTN6M2FzMGpS?=
 =?utf-8?B?bUxaMmdzTnBCUEFKMmFLZ1BjSkFxNUx3V0RYQ3BBN3A1MlRuWnV1dmgrV0NC?=
 =?utf-8?B?NU9kMyt0VldCZURWRU1zbFJUZy8rK0RORCtGaCtxV0x3TjhPS1RCQllKL2Vr?=
 =?utf-8?B?N0dBcjRKbmZ6RFdNSHRlZVcxMWQySFVqZlQ1ZTVReXdmV3ZyWnhrWXEyZnF3?=
 =?utf-8?B?bFRsa1ZDQXEwNEE0Z0U5RVZaQjQ2Wk4yMVB3YzRCemlvRW5ocUNNalR0MnQ1?=
 =?utf-8?B?YXZoVEl5MjVtMlQvZFpYMURjc214MURsUEJ0Q2VVYjFwNnJmNTZNajkxSk11?=
 =?utf-8?B?UGFPaDFqeUs0YW9FVHcyVmY3Rk94NkFpYW9LQzhVTjBlNUFqY0drRDlwcVFB?=
 =?utf-8?B?emFYZ1NhQ04rNGZrR1NLeVZxOWlzNk1OQVcwWmdGNHlheDNOaXhTWVl1Y0VZ?=
 =?utf-8?B?SHU3UExvWXNDbENqdm9aVkkxQlFxaHVtNW5YUko2amNqUnR3ZlVhbmY2Wmkv?=
 =?utf-8?B?dGVVM2p0M2QwUnA0Ti8xRldXaXRBakhBQklXWk1XM2dDUGh3cFpJV0NhdlZq?=
 =?utf-8?B?d3ZZaWNmVlpxSm40UjZyQkN5V3VscVJyZGwxSktSQ0hrVmlFdldEVVIvd0FQ?=
 =?utf-8?B?djltem1IVlR1bDJFbWkwMzRieHhrL3hLcFpyemFDY3JsOExYd2toZTR1MXBW?=
 =?utf-8?B?V2d0MThiVEVrZ1psQmdPd1Q4RHBwdnNVTTNmRDA5MjYyUjlsOFNmbFZxc2Rw?=
 =?utf-8?B?M29UVzBsVnlONmFIN0hxSGxYQlBiLzNqeGxIUUZsWTF2akRreEF2cnFZaXV6?=
 =?utf-8?B?UWVpeHVUVWkyTHpLdXovUDd0a3ltbDVxQVNTQUtGZ0Q1MzF5a3ZZeUExM00x?=
 =?utf-8?B?dE40QkJ0N08xS3NVR2s1Q3RTN2IydUpYa3kxTjUzYkVDUGNKQVhXNElseTFQ?=
 =?utf-8?B?S21ZL1U1VWEraWMzWFFCZGFXMjZWSEprTHh5QnZIbDN0WVlFVzBZbFJWY01u?=
 =?utf-8?B?aGVWL21HemVHMW1VdkI5RGZBbmloQUxvWmxKZW9PZjU3aFFpakFhTDg1Yi92?=
 =?utf-8?B?Z1V1RjFtWmZSV3hQQjRTZmZ5dm9iZDh4OGZEMHY5dUp4YUhnTEoyY080SXM5?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de8aad1-00ed-423a-7c67-08de1b740490
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 07:30:23.9329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SR29ea13ZLT04f6NK0s+rvtLjWOMaTgPRsslm7gnoSg5DfLkobgBGLT9/1axMmMVJMVC2R/TrfrSh0olWoD70ILmnpxrJV0WegBuKuUYbbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2VsbGVyLCBKYWNvYiBF
IDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDQs
IDIwMjUgMjowNyBBTQ0KPiBUbzogTG9rdGlvbm92LCBBbGVrc2FuZHIgPGFsZWtzYW5kci5sb2t0
aW9ub3ZAaW50ZWwuY29tPjsgTG9iYWtpbiwNCj4gQWxla3NhbmRlciA8YWxla3NhbmRlci5sb2Jh
a2luQGludGVsLmNvbT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGlu
dGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRl
bC5jb20+DQo+IENjOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgS2VsbGVyLA0KPiBKYWNvYiBFIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSCBpd2wtbmV4dCAzLzldIGljZTogdXNlIGNhY2hlbGluZSBn
cm91cHMgZm9yDQo+IGljZV90eF9yaW5nIHN0cnVjdHVyZQ0KPiANCj4gVGhlIGljZSByaW5nIHN0
cnVjdHVyZSB3YXMgcmVvcmdhbml6ZWQgYnkgY29tbWl0IDY1MTI0YmJmOTgwYyAoImljZToNCj4g
UmVvcmdhbml6ZSB0eF9idWYgYW5kIHJpbmcgc3RydWN0cyIpLCBhbmQgbGF0ZXIgc3BsaXQgaW50
byBhIHNlcGFyYXRlDQo+IGljZV90eF9yaW5nIHN0cnVjdHVyZSBieSBjb21taXQgZTcyYmJhMjEz
NTVkICgiaWNlOiBzcGxpdCBpY2VfcmluZw0KPiBvbnRvIFR4L1J4IHNlcGFyYXRlIHN0cnVjdHMi
KS5vDQo+IA0KSSB0aGluayApLm8gaXMgcmVkdW5kYW50LCByaWdodD8NCg0KLi4uDQoNCj4gLS0N
Cj4gMi41MS4wLnJjMS4xOTcuZzZkOTc1ZTk1YzlkNw0KDQo=

