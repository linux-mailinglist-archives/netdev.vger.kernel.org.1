Return-Path: <netdev+bounces-231601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD4BFB455
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D2F5811D9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB132145B;
	Wed, 22 Oct 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkK7do7t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7531B11F;
	Wed, 22 Oct 2025 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127097; cv=fail; b=u8dVsgGPgNcQHRA8/mdYjjXqxaBSM6tU63teKgH3HnDcz38olsVj2gMJJANPVfYRxbcn1NR1iBxJlQ7KFn3DkngE+mfRhJFsVELcM1nLRrWAiDISogOIoNBDODdq6GlH7NuwWwpATi3NT9Y5ntyLwhi4n0L/F6uYPFpjAZ0mUlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127097; c=relaxed/simple;
	bh=CTOtajeE1r+mKwyQTBKe/3RbTPo3oPs109QEBPp/pps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bwDqDUEsW5aqMVf6k0Q7q1mldc5XNTJS0YtMSoW06vuRFMfJ2S5b8LH1SN6vM/Ckjpx+m7GO2lX8DBW5D/NZmc78ag6vESq0cshlRSz/8yLbZZTpG8lpuXOMw3m+jw/ZWXZe7HDXo/9Eb0/hBMVWYDJ+6hDSzJk8of2Todxdzh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkK7do7t; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761127094; x=1792663094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CTOtajeE1r+mKwyQTBKe/3RbTPo3oPs109QEBPp/pps=;
  b=YkK7do7tF9AXwFWdDVVSU+ttqQBU01UsaGRpKhboNwoxuSqhBKCSeHAL
   r+G3Sk9hFxWCwmD/SROsrzwHCGPRZKLA5O8iFlarUzH9jC0q8eVLe+yIz
   qZYyaHYjuT2I5qQEeCAtAv4pTtdZMkiBNVieJRYuyFLB8Q5WLTxZZfu7v
   nt0x/qxoxAhTi111nCjiYeVxu7FXeskMoh11oH16NNuvJeanNrxTva+VL
   fnR2PNYtxslFJjMZFrk0iwgfENYJwhpvl3onuDuE8lrhw3STZT1CPbIdn
   fIbB1Wqq3uTg+NxZKxmthW0SCQNSnE1v9zfNMTU8pxtj+1pJpojXNPznD
   w==;
X-CSE-ConnectionGUID: HcW//WUfQQOq9VIUBufS0w==
X-CSE-MsgGUID: PS/wZXV/QGiQyBYLeg4rFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80891961"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="80891961"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 02:58:10 -0700
X-CSE-ConnectionGUID: K0JdqG5ZRF+rAjtAjLRVyg==
X-CSE-MsgGUID: YirJUQKXQGy16CCmDEQLQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183769023"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 02:58:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 02:58:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 02:58:09 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 02:58:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1+CKgVrpjyyIySUu+anwgiSs6qtCp/OCSY7COMvChpOBJXfePbKcjCWGw+gTzvX/AAsVfjeB2Wqujgx57vEcmEtw/Ric372PQALssa6UKYohGmodgxdrYqjcl+jm7wQ2k7oAZQGicSKW/U2UgNb4uzLgG8RiqDCvIDw2HEslK/JS+zDQ1Sodtk9CtGEc5mdzFGS/97oN/f3GL2BUHRjcRpBrQ0F12tvmNUkV4n0fzCKQkuJ2w/cepQkGNVHDjshRMEOwZlvr5OwDsJCbQU86u5KFYHV7I68ERr/wR40VZHIpPKDKC3mwb+oSvi1vmRXp5GG8vL7fYFeG9ILTBcGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LURjeB1nm3Zsseu0zkGiBokF9TpasTCkUMQ042bu3R8=;
 b=yAnJdlNSW9JpzBli3zpEeObOWWPweh06obD3/vw3VziIY27ym2h8LU3JjWx5T+hwkS4hF0FH1q3t8Y/xgwn1cylsb/nRA6oY8Vc+FEwN6s/DqCsUr8JisgUjlwIFHVjzhgvojzRRNkxjDtIDdWU5IvAJQyofV0f70TALMUHg1tpKWohOktMZfHEICOTpot9SklIsn4RMRfd8lNbqQSm3+KiUh+pdujdF+I3JYFR7O/qDUNSUdHsePtVX1KozxUzGVg0KsMZyR06F6X0v3i+ilgYnXyN8lbRkP2TPAFZe+HfQ6W1LMVfblX51p/UgnAYyp8Ny1fSB9nx+69kUJqzukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8746.namprd11.prod.outlook.com (2603:10b6:408:202::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 09:58:06 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 09:58:06 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
CC: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nowlin, Dan"
	<dan.nowlin@intel.com>, "Wang, Jie1X" <jie1x.wang@intel.com>, Junfeng Guo
	<junfeng.guo@intel.com>, "Zhang, Qi Z" <qi.z.zhang@intel.com>, Ting Xu
	<ting.xu@intel.com>, "Romanowski, Rafal" <rafal.romanowski@intel.com>
Subject: RE: [PATCH net-next v2 04/14] ice: add virtchnl and VF context
 support for GTP RSS
Thread-Topic: [PATCH net-next v2 04/14] ice: add virtchnl and VF context
 support for GTP RSS
Thread-Index: AQHcPyzQ67kmtolwRE6l0/KrGxH3Y7TL1AKAgAIgXcA=
Date: Wed, 22 Oct 2025 09:58:06 +0000
Message-ID: <IA3PR11MB8986ECE1CEEFDE1E6972BE75E5F3A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
	<20251016-jk-iwl-next-2025-10-15-v2-4-ff3a390d9fc6@intel.com>
 <20251020182235.7db743ee@kernel.org>
In-Reply-To: <20251020182235.7db743ee@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8746:EE_
x-ms-office365-filtering-correlation-id: f21e71fb-642a-418d-aa67-08de11517f80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?dMRR5M1794NotEvLdbTMkmp146PeSRQ6HDDf7WU3Sq4xbo1okK6s8jxHcg/V?=
 =?us-ascii?Q?Kztsxl9geE+JYA2+mJZmqRnpR1enBeXLI1GWOdHqJ2rty8IXlxfqWY4Ta5ds?=
 =?us-ascii?Q?3y1Mn3S1VDvkQK6wh385ZseX1FAU2Kqm3oNtwU9jinN1yJOMc7+ptMQNFUeQ?=
 =?us-ascii?Q?tScLkMBBckH1a7D0jTBmnobIFtDWXtBxYVXYwxs5uZQpa7J//Zx3+9f4QzzQ?=
 =?us-ascii?Q?L1Jd+6Ax3LfxwyjfWkY3JiL+f6ZYdOqVQ9wknG6JywIop5htvCftN47DMdNL?=
 =?us-ascii?Q?6tsbZfURjdKHgnORzNp8X+VaSW1RcNdMWudC8eFwoYIlKwappeyhOhBV8m4g?=
 =?us-ascii?Q?Lx4za2bt42PodXFhiuVSPbfB1xj45Ef8HGfH2hsYnXojLfbQ3r8CKDfNaAYw?=
 =?us-ascii?Q?f6NDzR3oJAz0WQkLieCVcf0yp1XtFR4bXCFX3MN2flXTJNfdEcVClUK8/IHr?=
 =?us-ascii?Q?qaU/Ox1IoPAG1SBkzfcOD7uH5r/2tbZaPwpkx1SXHyCofH7szz5v7W/koTLM?=
 =?us-ascii?Q?eAgAPD6FLM+3Hh7n2yuw0DMc7yd1q4xIZqYZo5SD7rTCMspGI/uch7cj7jnM?=
 =?us-ascii?Q?g/i5r3FGUp7XlXn2e8e27SjFXY8OoqEfSK8TSmVFN43B9PUO01w4ZAg+gs3i?=
 =?us-ascii?Q?xtElNSWokLyipp1Oa50CrjE6GzM9c9hIOLQJcnf8tG4B+aSlHjdPjWAZfDNI?=
 =?us-ascii?Q?nNO5VrBKbsiZVcZw8Hkb/a6wFBX7ZES4m/aGPvW2D4MY4mV+g/XusveSgm48?=
 =?us-ascii?Q?rnaacFZB803dYff+5YfgBLUpBXAt/RpjU2oVWuTsTMKT2vCmjLzOd8K7yrmM?=
 =?us-ascii?Q?ssMjiYhHb8lGHmpJz/4H53BojB7250WxsUaQZGOKC09eVnSsYoIt2/XkPsQR?=
 =?us-ascii?Q?aHOl0fs68z1WqO+/iJwtnCTLrdZwuvU5EWoKiTgN9EtxbS7ZQLLTVIqR/34X?=
 =?us-ascii?Q?/LxP31TVo78kGNhYBKW+C9W8uVc3l89H99q36MjG13yi42dEJlaj2HaNgl4m?=
 =?us-ascii?Q?wU7jRhQqiIokb7IEutWwKTnDqhcDD1ts3EjOjTXaolYoUN1tWOvxnuaf71qK?=
 =?us-ascii?Q?BjlQ9y3ACk4vJFaxLnB2u3FFM1JafFaiouprVIBhxwVYWl7GSvfPIRk5Md6g?=
 =?us-ascii?Q?mpjQ/cYC1rAU7FgmQ5zQe1plqOo/Tc8M/V/KHU+Stibu4AOObwnKfi4rUXPG?=
 =?us-ascii?Q?3diWabTURgehQwfU5j3iGIcdKSvSLDT4rs80SxygJwDHCWyPaM8AP97UsJoC?=
 =?us-ascii?Q?nh7phWrYaauRfkKY0OXWW0H15mUvmw+ZztzTZWbSnQH1+D5cjh5gLWILF86x?=
 =?us-ascii?Q?cCvc+YmWlR5789fYGCZ6GrPfc8DnGXWbMExCCpXyt7uc5noZRTOtBxnixbsL?=
 =?us-ascii?Q?ZYlUiRrXRh3KJUy16SgS/vPaBXh1UHmX0URv0gkPpNYiztKvEr+KHG5pjEus?=
 =?us-ascii?Q?aYTv/APx2csJlj41cCLdqtfX6NwhcLuY4w8HCUEKdFqW9skL2hn1hGzPogY8?=
 =?us-ascii?Q?gL4JWBpsnm56wxFgUhNI0Oha7u3EqwcQ3abk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5/onW+La26RNLyvMsWJ+hwtkyLjk7aq3f1obDLrPH2weo875jy77rbmqGQxi?=
 =?us-ascii?Q?4uxGmvogYbxpALCgzeLtCyi7Fz41XS0e0uMuDqn7zLE5SwT1i/tQZJ09w+Xr?=
 =?us-ascii?Q?qmHhIrnpO405N8A8swikFnGzcaspQ968hyu6MTaRNayOoFopUSOE5p1c+57o?=
 =?us-ascii?Q?N5ol9Zc6DOARpGU+fEgbJBxdzoD+a4VHa//MXPQRQkOCmlywYe4B+bm5DtMp?=
 =?us-ascii?Q?bI2Ry2T+ewdga2GthustTxe40rMpCwtBVebnHL+xFONFuV6EHvW8Ko5399cJ?=
 =?us-ascii?Q?90zvKDx4XwnWlngtC9QK+YRH8n29o4490lpmY2yzITNCQAwBkCknMOLFJeA7?=
 =?us-ascii?Q?cZO7874fEUfyHkPY/KiLksgKVLceF74yxZIvBxjPWksxzUB0lxt+y6kAEXJc?=
 =?us-ascii?Q?6P2BE35Y+3wX5ECwTZ6xMYEaaoArZZstpMGR9hOvUF8B9MA0K5Zgtj7mMb6j?=
 =?us-ascii?Q?aIrJ5PibhueEhAd0NysqBNE8zmkatiy3bPXFA0NRQ/6OlibuiUZhg2rNwXRW?=
 =?us-ascii?Q?EbHrBiU/BNi4r7WUhXaYXZigRwMbVdLObyuewrJKRQQ0OZ0YfkYvoBuKlKZ6?=
 =?us-ascii?Q?uhQr3VRj4sC2Oklln1nC9wrP1Fvx38Nmi8tCap9Iil8jYKxPLBbbQZGF1kvB?=
 =?us-ascii?Q?YiIKraOyIKxUldAQBD4aCGlrY5FzQEgdjXIy+f8ePLCmIRdqoE0CdqEU1zZ1?=
 =?us-ascii?Q?SLT3Y8T8TXpsl1u7PEtyasUk/+YWp20Yo1vNYiURUkSMWDBPO2mnk2PPu9+r?=
 =?us-ascii?Q?SmuU+Pg9fQlB43fEQZmC3wV7lwdaJs/lEWnA0P4MBVzszuq3Pk5cdNDmgj1a?=
 =?us-ascii?Q?rjqk0SanM0e/KC/se5n3SYeasaxGSFzyfVEsbeafsAElT9l5JJgq1h/vDJEM?=
 =?us-ascii?Q?xhbPah1XyJpCdr1J5yccq78eXCAsCMIFVbaQnpYf70WtgjTu6C7MJ3ULUJID?=
 =?us-ascii?Q?vUxtw50saOeIIBZGtqHRn33k74pjtBBO5xMouKW5wzwG0LPNvYUeg+Mdlplw?=
 =?us-ascii?Q?p5Q6URu3iFU19PoPYYZ+MfEs8DoffCwHrPhocW0fVxtLbTkpaoqf229lft3H?=
 =?us-ascii?Q?cGJTbChvZ51qHIwOh0msVDMCa6rlX3YBUpqU3ByJ45s8PRWCwewqpebSe2Pk?=
 =?us-ascii?Q?9Ju+PbZoCww8Qn/A39kr1P3i+I4RsOGfKQbQr7N/dZUb6oIB7VAjmignOwQi?=
 =?us-ascii?Q?z16TMwj51m7eJ/h8HWsE+mvlgR4NGLc5rWV9a9mIcDR1TImNafBlhtS4aRV2?=
 =?us-ascii?Q?1e6qxvD2L6Koi7Lhpw53v9/wl3Qd5lrZMmCeQudqSqLIlDDSlU0LJpEjGV8j?=
 =?us-ascii?Q?wd7CSxsJ7uGoWDOeYE7uTM4cmkXMaxaYm0uGF62kmYC0waX60HQjf+BmdAg9?=
 =?us-ascii?Q?CCO+2crEEzffhNP6kwZvVxnY2Yl32nspsJDgaTn/4VRQ31G+xZNpTtcssx9i?=
 =?us-ascii?Q?JDUVZQu6R+i0fCTzWZ+KubRLfE+ohI2oNi2URTho+RnzQY6E7orEsW9bjles?=
 =?us-ascii?Q?8sEwjoeEdWLaEj5HOjG4lhKrjkYMA9G95hpqrzZbIH+adN3YLSSK8C8FOjMk?=
 =?us-ascii?Q?1XR8IUBanKduv9tP01gMn9cs+bNANAFWxdarL3AWNjOVGXzPGbBOv0HhxUj3?=
 =?us-ascii?Q?6A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f21e71fb-642a-418d-aa67-08de11517f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 09:58:06.1848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IH6LWL5lVI8m2CkqyZD0uRUxa3xsu2HoUKp4Vlb2EpWi4svHAcS0UmjVgm3wuC+2vMS4VMIxHGQwoa55MbzEeX7jX94N3pWB5zSqzs6uq3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8746
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, October 21, 2025 3:23 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Jiri Pirko <jiri@resnulli.us>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Nowlin, Dan
> <dan.nowlin@intel.com>; Wang, Jie1X <jie1x.wang@intel.com>; Junfeng
> Guo <junfeng.guo@intel.com>; Zhang, Qi Z <qi.z.zhang@intel.com>; Ting
> Xu <ting.xu@intel.com>; Romanowski, Rafal <rafal.romanowski@intel.com>
> Subject: Re: [PATCH net-next v2 04/14] ice: add virtchnl and VF
> context support for GTP RSS
>=20
> On Thu, 16 Oct 2025 23:08:33 -0700 Jacob Keller wrote:
> >  void ice_parser_destroy(struct ice_parser *psr)  {
> > +	if (!psr)
> > +		return;
>=20
> questionable
>=20
But it potentially simplifies cleanup code in different functions (no need =
for additional if (psr) in functions).
Do you insist to move it from here?

> > +	{VIRTCHNL_PROTO_HDR_L2TPV2,
> > +		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_L2TPV2_SESS_ID),
> > +		BIT_ULL(ICE_FLOW_FIELD_IDX_L2TPV2_SESS_ID)},
> > +	{VIRTCHNL_PROTO_HDR_L2TPV2,
> > +		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_L2TPV2_LEN_SESS_ID),
> > +		BIT_ULL(ICE_FLOW_FIELD_IDX_L2TPV2_LEN_SESS_ID)},
>=20
> consider moving out all the static data and define changes to a
> separate commit for ease of review?
>=20
Ok, will do my best. Patch #2 is big, but everything is related to the cont=
ext.


> >  };
> >
> > +static enum virtchnl_status_code
> > +ice_vc_rss_hash_update(struct ice_hw *hw, struct ice_vsi *vsi, u8
> > +hash_type) {
> > +	enum virtchnl_status_code v_ret =3D VIRTCHNL_STATUS_SUCCESS;
> > +	struct ice_vsi_ctx *ctx;
> > +	int ret;
> > +
> > +	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return VIRTCHNL_STATUS_ERR_NO_MEMORY;
>=20
> I feel like the VIRTCHNL_* error codes are spreading, we've been over
> this.
>=20
I can understand your feelings.
But it's:
 - static function (only used within this file)
 - only called from virtchnl handler functions
 - "vc" (virtchnl) in its name indicating it's part of the virtchnl layer
 - not exposed in any headers
I think this is appropriate because it's part of the virtchnl abstraction l=
ayer and only used within virtchnl handlers.

> > +static int
> > +ice_hash_remove(struct ice_vf *vf, struct ice_rss_hash_cfg *cfg) {
> > +	int ret;
> > +
> > +	ret =3D ice_hash_moveout(vf, cfg);
> > +	if (ret && (ret !=3D -ENOENT))
>=20
> spurious brackets
>=20
Yep, have to fix.

> > +/**
> > + * ice_add_rss_cfg_pre_ip - Pre-process IP-layer RSS configuration
> > + * @vf: VF pointer
> > + * @ctx: IP L4 hash context (ESP/UDP-ESP/AH/PFCP and UDP/TCP/SCTP)
> > + *
> > + * Remove covered/recorded IP RSS configurations prior to adding a
> new one.
> > + *
> > + * Return: 0 on success; negative error code on failure.
> > + */
> > +static int
> > +ice_add_rss_cfg_pre_ip(struct ice_vf *vf, struct ice_vf_hash_ip_ctx
> > +*ctx) {
> > +	int i, ret;
> > +
> > +	for (i =3D 1; i < ICE_HASH_IP_CTX_MAX; i++)
> > +		if (ice_is_hash_cfg_valid(&ctx->ctx[i])) {
> > +			ret =3D ice_hash_remove(vf, &ctx->ctx[i]);
> > +
>=20
> spurious new line
>=20
Will fix it.

> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> > +	return 0;
> > +}
>=20
> > +static int
> > +ice_parse_raw_rss_pattern(struct ice_vf *vf, struct
> virtchnl_proto_hdrs *proto,
> > +			  struct ice_rss_raw_cfg *raw_cfg) {
> > +	struct ice_parser_result pkt_parsed;
> > +	struct ice_hw *hw =3D &vf->pf->hw;
> > +	struct ice_parser_profile prof;
> > +	u16 pkt_len;
> > +	struct ice_parser *psr;
> > +	u8 *pkt_buf, *msk_buf;
> > +	int ret =3D 0;
> > +
> > +	pkt_len =3D proto->raw.pkt_len;
> > +	if (!pkt_len)
> > +		return -EINVAL;
> > +	if (pkt_len > VIRTCHNL_MAX_SIZE_RAW_PACKET)
> > +		pkt_len =3D VIRTCHNL_MAX_SIZE_RAW_PACKET;
> > +
> > +	pkt_buf =3D kzalloc(pkt_len, GFP_KERNEL);
> > +	msk_buf =3D kzalloc(pkt_len, GFP_KERNEL);
> > +	if (!pkt_buf || !msk_buf) {
> > +		ret =3D -ENOMEM;
> > +		goto free_alloc;
> > +	}
> > +
> > +	memcpy(pkt_buf, proto->raw.spec, pkt_len);
> > +	memcpy(msk_buf, proto->raw.mask, pkt_len);
> > +
> > +	psr =3D ice_parser_create(hw);
> > +	if (IS_ERR(psr)) {
> > +		ret =3D PTR_ERR(psr);
> > +		goto parser_destroy;
>=20
> goto free_alloc, surely, parser creation has failed, there's nothing
> to destroy
>=20
Agree, easy fix.
=20
> > +	}
> > +
> > +	ret =3D ice_parser_run(psr, pkt_buf, pkt_len, &pkt_parsed);
> > +	if (ret)
> > +		goto parser_destroy;
> > +
> > +	ret =3D ice_parser_profile_init(&pkt_parsed, pkt_buf, msk_buf,
> > +				      pkt_len, ICE_BLK_RSS, &prof);
> > +	if (ret)
> > +		goto parser_destroy;
> > +
> > +	memcpy(&raw_cfg->prof, &prof, sizeof(prof));
> > +
> > +parser_destroy:
> > +	ice_parser_destroy(psr);
> > +free_alloc:
> > +	kfree(pkt_buf);
> > +	kfree(msk_buf);
> > +	return ret;
> > +}

Thank you for reviewing
Alex

