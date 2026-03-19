Return-Path: <netdev+bounces-269379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBvZLRnCu2n1ngIAu9opvQ
	(envelope-from <netdev+bounces-269379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:30:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 321212C8AF3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E6103044365
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593A3B6379;
	Thu, 19 Mar 2026 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0BMlSzX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD883B6347;
	Thu, 19 Mar 2026 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912483; cv=fail; b=CwQXlO88pk/4Ji8o7kx+aa0KzIYaw/hBnyLYW+4xALHjCOO3mcYzkuHciFc8m0pP9DXH//xOa4geU5lfYkVkA+6Zkt0/zSdoPQOMGAj6QiujDvZ6KFRxiaNWZJus8Sb69rEO02JSLzNXfMl4N2El1V09UgcTMHQN+lIaS18rC1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912483; c=relaxed/simple;
	bh=BIwQKppRpWbLF0gQsGmIAZR9Uapo4Gk4eeW0VhlcST0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=AL2/w9nn5GZZ9KC/tkmGth1jsM/PI2lQS9B4kqnLUoMEtelIrmJAySWyXJ3cyM09kK7XvFu9osYgZrlu0drpfQPMfC3HmW7ZSj79aPb2Cw1+Omc/jD40iX8JAozK5Z30DrsCg9TafUKza4SmOEAR+JLB9iEmsLzRd9SGojEnxeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0BMlSzX; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773912482; x=1805448482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=BIwQKppRpWbLF0gQsGmIAZR9Uapo4Gk4eeW0VhlcST0=;
  b=J0BMlSzXa4tqmNuRZMFKZBKcsNJ5MznPCWqJzTVKLlU0wcu5hSGiHNDi
   mysOAcNwhirGqucfY6Zfwb4EBXeNf5SOny7nL6fdUxzkeURtQj0czuT0G
   y32i+6szlIGXdgE3ZtdUHpEzYdcT44Pcp24KuZFD+wYzjOMRIQE7RIy2Z
   zUiC/0W3lHKXtB73n1I7lFuaFQDq32Ev/agECfcHB6gDI/1iFw1/78Bvr
   WGBSpioJToqShWQQtY6G3ug0CKnxkl2Req/wgVhDLg92TIQPShMM5hvV8
   kFNrXErE7F/PMQUbx9SlxqW4f2Z5ieNysAa+/KL6IA4m6ClMFbRvD0oi4
   w==;
X-CSE-ConnectionGUID: iG9WRA+CTbWXX3RUjTdvJg==
X-CSE-MsgGUID: cKUlwQbzQ/KW1MMfH3X57w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78838032"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="78838032"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:28:01 -0700
X-CSE-ConnectionGUID: W9/YXeEfSx+gXGHBl24dUw==
X-CSE-MsgGUID: k53Dbf2JQyaIR/uMYiDyag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="247235033"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:28:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:28:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 02:28:00 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:27:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWfkpspJ9gBi4k/mHvKoIVHYYJSPJGMsWPeU0371opQkmlKdw4BO/Ea8v4EqlcYRWWZwAffigXYmepKm7WHW1IJYH4/7IUPAwutlx3G6SH1rj6pGUCDXjBNAUw4SQ6ih3Y6hkJF++kh4lj7ewgvNlg//d2/B/1Uq7tmCCTBV/5eKIs0l9xuzFRhMQwtha8oe3Qa9yNs4XhAEnAGqx9o+lbDr5iKnn9eBFcUEOo/HEOAvSPGXc6JRGVzWSqnwD6r7Wr4TlQ/4D0/kZpKghwl9rOFMdU8VqqW0LRgx6bX7EhKYw0jh/Gv1iKhl2qPSFY+LyOae6Fc+OxzbTYCluu0gFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zHA/CzenbgloBgDs2SiLzffQ1HVqCOIEpkKVtDc2eQ=;
 b=dslLWCICH/kp6SFOhAQKbQ1uvRJuIFK5r4YvAqqWJO8AWseNHOFpkfkPI/9TTsHv7eTwIKuXblQMK4Fzq50gYN8deZwXkoC4PlMp7IcThuvgEZBV005AEWMuQTRL9SgQfY1F840JlPcj0xSCGkcdeVzisJVKseDn48o72Lzqwgea7eKWyXZJYJDsduPn9nI59c5lpacHY0tVUoqrngtgu2Npm196VnIm3iC0qcv/PwAJmZgGIZjblj/NTE8ZIcNbBoej8u73cseo9KX6nQtDAEF/8vSNtWtChTellEc97p+Ml/RjcuJlsR7/KxXw1vEugjs+n2mjxLuINRb/WfUipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by SN7PR11MB7602.namprd11.prod.outlook.com (2603:10b6:806:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 09:27:50 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.20.9700.010; Thu, 19 Mar 2026
 09:27:50 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Oros, Petr"
	<poros@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Eric Dumazet <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: use
 ice_update_eth_stats() for representor stats
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: use
 ice_update_eth_stats() for representor stats
Thread-Index: AQHcm/TA94F6OT9T00SDoZU2J8y3pbV+ujkAgDcTCXQ=
Date: Thu, 19 Mar 2026 09:27:49 +0000
Message-ID: <IA3PR11MB930142EA25948984CBA748DE8A4FA@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <cover.1770882260.git.poros@redhat.com>
 <27c3027a6cc22b565e2a741bbf5ee7d3382e80d7.1770882260.git.poros@redhat.com>
 <IA3PR11MB89860309716B8F26B066FE10E560A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89860309716B8F26B066FE10E560A@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|SN7PR11MB7602:EE_
x-ms-office365-filtering-correlation-id: e73232a1-8c22-4752-e5c7-08de8599ca14
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: kW4Kcv0xMsTN6p50rc8utx4jf2qjx7OfQk6vySc0VGnV+G05f5XsvgQJTmW46q1XsrBpCRGCVk8bgqrj+WEgBnCjAfNoBcdnAtcyrIjDZsfE2P7bck1AmPtHpazqp6XRJyBOhxcQtQx2oSWSx/Gp8CFpNldgjd0ddWn1OsWajMzeG+gM8pW/vQtY2/5qneed/pU3t6Vwjx7Iwk1jkEJ6jIV10XOcTlRQ/CY3MTXos54lsr/VQQ0L6E6lWFDM1GaFHO6pQe7BW2djApx7OyjsR4UrzkZgIzPMchVfL8yofu0+xRdONERUyVwR/g+ckrBoGoFRn25n/9y9cpnFBBB+H8ZU9B6eDWJTK11pctJWzpZfdsBHuzWDaoBBU9B2aNBVW2Z/eKobQYRgFaT53S6L1VW8jSFOkZz0zGITF8awPC9E2NYvR1+9TwyzI5bFNcrt+UR1zO0UQ2QKlRWay0KEhY1HG2OdTLc0fQPLa282HnALR71D9Vz+RCuaQVOYe0n1HbReGn+JP/giOYlG5H+naZJlxPWsQwj9fzUhbjfCsQnaTho9xtdYDMi00mfiPqcgE+Ggrf096fnCd2CyZD0prB82wFlubx4wYLXm2gPhXQrrIw+/jD0gE2bUvpdUzVsImnoviqoJHE5gYZvRglIW04eCc0mvTrD/9xnmMH23wZ3D/Z/hCGKz2+XC2msX6hdXUVKDtX8VKD093Gx9QZ+ORtRKgJY6/R25HME+UIoC3s2xI+AJIbtUuiqM48k6kL+0my0M18qben6wE3/rx3e4BiXEUAL1RYAKx3kGbNyh9Vc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?pzY6V9hp6sscd0F4jH2moetQd4NDSbIdJA0CcqYfJ52ECy7UxjIebGFY?=
 =?Windows-1252?Q?bqs0DSq5bw1MamaHkYHHhaPOIrl0/gxCrolGcIuYe4GCgnUh7H/+bqnJ?=
 =?Windows-1252?Q?MoT5F0oOCi65Bo94NW54tRRX2Yx8v7RVz9ssu8vfGBU5pcyKjsY+jzcP?=
 =?Windows-1252?Q?JCVkXuB5Is/WUKdpGgTUbXpuu7VM7oaPioBP7o1kP5EDR12/r0B3FnVV?=
 =?Windows-1252?Q?wCGnqPboaLwWoNg/pljdaTJc3cevmnTXnmmyDZ9myBca1E+Olf/Nuh2D?=
 =?Windows-1252?Q?i7o/ALzvIB41Kjq5ch+L6NfJsYX9I0CBcH2nOtW2GqjctPlvc75uDOdl?=
 =?Windows-1252?Q?695JKkEEUtdMGcfzSIunNdceZzqzrg3mKpqNLbZg4aiuz5O2omBQwWlI?=
 =?Windows-1252?Q?4UKSkepPe1LofcXmJOqRn/QN/3CAva4ylfygaJ/HUHFZV2RKtdFEoC1i?=
 =?Windows-1252?Q?ABnue3YuwIuMwNyYSlafLx0KubPR6xYa3hg0J8J9nMs3vZM01yPZ/UiM?=
 =?Windows-1252?Q?5M5g+zsKPVjPR+kkY30PDkXQJMvcBs+bOvFa5NcooL4nwk5c1eyI9euC?=
 =?Windows-1252?Q?q8UHH2c2P6NtnfviqNmL2C8zOqFqGFSjkAYmecO+KhdR3TAbEH2MxYiF?=
 =?Windows-1252?Q?m53TOfXNl7IHAA/wGCudymSmVGmaR4eQb0z+Hrl+NsLAfIucm7YZkaVC?=
 =?Windows-1252?Q?9LZHOqpgAqoF+lX/wHN+X9/hXUYjzNoWcpAXZg59nqhJgWIP//fBBPOp?=
 =?Windows-1252?Q?/XKB4MOFQeoTcqxO4WEqQZOoE4dqR6u8q9+uEDHUndAJLwPrIjCgNc8D?=
 =?Windows-1252?Q?xRN3wPO5cMK/ZROSI+mfGLB4B+o6ANuAG9k3nneFSjw3sWmWsB2SzVBq?=
 =?Windows-1252?Q?baf5gen1jxbamWSHizkb19XGqPYs+Qu2ojdJwn8j/dkjUYxruDWD5xpr?=
 =?Windows-1252?Q?rYLghlM4QVP/eF4kpXfLIqZPpwN/QK8F54u6QXHfIzbMx+XFENohCPa8?=
 =?Windows-1252?Q?LQ8qIUPaLIpWmUFQsI7hcWOvTJTUJ+EaJtkwHBpWrEbRs5v8XFZIP5Rq?=
 =?Windows-1252?Q?stVJhnNCQVx1DsZpzR20KbkwXKfQukWSzjtjvnw7BgicBCahA1POs8Hs?=
 =?Windows-1252?Q?SS8Y50BTErC9N4T96tCc2mrJHnAp3nFykn23pEeLCmS9XWUakpdut9Ty?=
 =?Windows-1252?Q?5jfb9nD+3SiCpvdcyT3COkR91QRWJUW4HUHHan+ALWTYI5IlyYme+vhk?=
 =?Windows-1252?Q?66C8MxXYLxmCk1j0T/C7vjOZK/tkbBVK/TiPsNttKRkhdouSbn3SexT7?=
 =?Windows-1252?Q?seyzLzNqiQzLhNLI5f1sMnrQfa21TiQRj4n52mhKPbqww3QZvpHhVu3g?=
 =?Windows-1252?Q?2nYTEUVK/i5YEl9DUKmSZ5wMTrZOmsRMl+8t7O3mCQUIOw0WxtqjzliR?=
 =?Windows-1252?Q?Kzvcg+L6DAoX/ghs02X9q7ztWWaCVfDGBhzMyxv6tjFxYtdohJxUhRsk?=
 =?Windows-1252?Q?HPcxa5W9lBNpe+ht1beyNsVjdXMxTCgz+eN1+vLXPgZq7CFUQtIriqbz?=
 =?Windows-1252?Q?ml5jDciu1V73dv6J4RZaUic9lnlj3iaWmEe3/MsiFaPrCi2TzyOoEBIK?=
 =?Windows-1252?Q?BPDb/jcz/3YDsUxWl/FrBvZXXg0fPwNMCSXRo4zxGcq8LW3cMHnlSPen?=
 =?Windows-1252?Q?mDf2OpoJbBJdEwXwa/gUc5wyiyzqFzYvycclXpkLdo+DAsTA8REipZxN?=
 =?Windows-1252?Q?4dsh4nnp0s7UMg+nBevlItGwKsgRS7J7+u6UuJWzI4KzzV2hK6ZJmR+5?=
 =?Windows-1252?Q?VuL+6Dc8VtZCypBo0Yhu2/7t1v5UjVMx81f4Ng4PwsuKBmDg?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HJMghJ271cJQokIwzjlXBaoDP2D1WimTusbg2MfAU4jlC9xcs1sYm3/IVDY/RkDftCTLCVXXAIKQr1NQ/nKFbTaajzZ0t8GhR22JR22TX3+JNVsARkIuuZ72UrNsLPfMLlM3Wpjz3DfF1y5InDeBASfMVdTIzfM7117iwMataHcU4MVsubCDSioXwpNHhIBoF3T7bwhnWIlpsZNJQmLrnvbQfso/aMqmbktV9Q+T0j8MTUQ725QXPbf2Q+6Q++pgkzmv2WtjTxfy7Lzii8tUye2oMVC0tkKuLVinjO5t6gdrX9QZvI+NsAIw8N7cK1V/p3+oVfAESDvElaYc1UfpcQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73232a1-8c22-4752-e5c7-08de8599ca14
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 09:27:49.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgKAeRRDsC8ISxEuzkfrzHWs8f6x5FAHy9whPpmx5ZwgSe6sGJ1OZ1/sHmyc0FamWFVAio1aJXcON2AxYzeKmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7602
X-OriginatorOrg: intel.com
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269379-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,IA3PR11MB9301.namprd11.prod.outlook.com:mid,davemloft.net:email,lunn.ch:email,osuosl.org:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patryk.holda@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.977];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 321212C8AF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr




________________________________________
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> on behalf of Lok=
tionov, Aleksandr <aleksandr.loktionov@intel.com>
Sent: Thursday, February 12, 2026 09:24
To: Oros, Petr <poros@redhat.com>; netdev@vger.kernel.org <netdev@vger.kern=
el.org>
Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; Kitszel, Przemyslaw <prze=
myslaw.kitszel@intel.com>; Eric Dumazet <edumazet@google.com>; linux-kernel=
@vger.kernel.org <linux-kernel@vger.kernel.org>; Andrew Lunn <andrew+netdev=
@lunn.ch>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Simon Horman <ho=
rms@kernel.org>; Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; J=
akub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. =
Miller <davem@davemloft.net>; intel-wired-lan@lists.osuosl.org <intel-wired=
-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: use ice_update_eth_=
stats() for representor stats




> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Petr Oros
> Sent: Thursday, February 12, 2026 8:53 AM
> To: netdev@vger.kernel.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Eric Dumazet <edumazet@google.com>;
> linux-kernel@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Simon Horman
> <horms@kernel.org>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller
> <davem@davemloft.net>; intel-wired-lan@lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: use
> ice_update_eth_stats() for representor stats
> =

> ice_repr_get_stats64() and __ice_get_ethtool_stats() call
> ice_update_vsi_stats() on the VF's src_vsi. This always returns early
> because ICE_VSI_DOWN is permanently set for VF VSIs =97 ice_up() is
> never called on them since queues are managed by iavf through
> virtchnl.
> =

> In __ice_get_ethtool_stats() the original code called
> ice_update_vsi_stats() for all VSIs including representors, iterated
> over ice_gstrings_vsi_stats[] to populate the data, and then bailed
> out with an early return before the per-queue ring stats section. That
> early return was necessary because representor VSIs have no rings on
> the PF side =97 the rings belong to the VF driver (iavf), so accessing
> per-queue stats would be invalid.
> =

> Move the representor handling to the top of __ice_get_ethtool_stats()
> and call ice_update_eth_stats() directly to read the hardware GLV_*
> counters. This matches ice_get_vf_stats() which already uses
> ice_update_eth_stats() for the same VF VSI in legacy mode. Apply the
> same fix to ice_repr_get_stats64().
> =

> Note that ice_gstrings_vsi_stats[] contains five software ring
> counters (rx_buf_failed, rx_page_failed, tx_linearize, tx_busy,
> tx_restart) that are always zero for representors since the PF never
> processes packets on VF rings. This is pre-existing behavior unchanged
> by this patch.
> =

> Fixes: 7aae80cef7ba ("ice: add port representor ethtool ops and
> stats")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>=A0 drivers/net/ethernet/intel/ice/ice_ethtool.c | 14 +++++++++++---
>=A0 drivers/net/ethernet/intel/ice/ice_repr.c=A0=A0=A0 |=A0 3 ++-
>=A0 2 files changed, 13 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 3565a5d96c6d18..0b8775621f1567 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1926,6 +1926,17 @@ __ice_get_ethtool_stats(struct net_device
> *netdev,
>=A0=A0=A0=A0=A0=A0=A0 int i =3D 0;
>=A0=A0=A0=A0=A0=A0=A0 char *p;
> =

> +=A0=A0=A0=A0 if (ice_is_port_repr_netdev(netdev)) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ice_update_eth_stats(vsi);
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (j =3D 0; j < ICE_VSI_STATS_LEN=
; j++) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p =3D (char=
 *)vsi +
> ice_gstrings_vsi_stats[j].stat_offset;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data[i++] =
=3D
> (ice_gstrings_vsi_stats[j].sizeof_stat =3D=3D
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> +=A0=A0=A0=A0 }
> +
>=A0=A0=A0=A0=A0=A0=A0 ice_update_pf_stats(pf);
>=A0=A0=A0=A0=A0=A0=A0 ice_update_vsi_stats(vsi);
> =

> @@ -1935,9 +1946,6 @@ __ice_get_ethtool_stats(struct net_device
> *netdev,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
>=A0=A0=A0=A0=A0=A0=A0 }
> =

> -=A0=A0=A0=A0 if (ice_is_port_repr_netdev(netdev))
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> -
>=A0=A0=A0=A0=A0=A0=A0 /* populate per queue stats */
>=A0=A0=A0=A0=A0=A0=A0 rcu_read_lock();
> =

> diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c
> b/drivers/net/ethernet/intel/ice/ice_repr.c
> index 2a84f656405828..f1e82ba155cff2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_repr.c
> +++ b/drivers/net/ethernet/intel/ice/ice_repr.c
> @@ -2,6 +2,7 @@
>=A0 /* Copyright (C) 2019-2021, Intel Corporation. */
> =

>=A0 #include "ice.h"
> +#include "ice_lib.h"
>=A0 #include "ice_eswitch.h"
>=A0 #include "devlink/devlink.h"
>=A0 #include "devlink/port.h"
> @@ -67,7 +68,7 @@ ice_repr_get_stats64(struct net_device *netdev,
> struct rtnl_link_stats64 *stats)
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
>=A0=A0=A0=A0=A0=A0=A0 vsi =3D repr->src_vsi;
> =

> -=A0=A0=A0=A0 ice_update_vsi_stats(vsi);
> +=A0=A0=A0=A0 ice_update_eth_stats(vsi);
>=A0=A0=A0=A0=A0=A0=A0 eth_stats =3D &vsi->eth_stats;
> =

>=A0=A0=A0=A0=A0=A0=A0 stats->tx_packets =3D eth_stats->tx_unicast + eth_st=
ats-
> >tx_broadcast +
> --
> 2.52.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>



Tested-by: Patryk Holda <patryk.holda@intel.com>
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydz=
ial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-31=
6 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu usta=
wy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w trans=
akcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata=
 i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wi=
adomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiek=
olwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the s=
ole use of the intended recipient(s). If you are not the intended recipient=
, please contact the sender and delete all copies; any review or distributi=
on by others is strictly prohibited.


