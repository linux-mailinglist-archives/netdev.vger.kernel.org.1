Return-Path: <netdev+bounces-165323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C4DA31A34
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03903A7B03
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2DA31;
	Wed, 12 Feb 2025 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciAzFHV8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30C360
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319048; cv=fail; b=GuqCheJPhrbNig/C4HNTRcePG/83IL/y02plGY3M+OQqyr3ZBhZnOuR4ZZYVyQPthKOLGNAWYCptOzV/DztbJGKrcNjExeSUnJpSZWqTgjQijmhRU+5odJWacLycZdVrzZUMEf2x2cddba9D4MjRFpfw+vAo+eM4XDSF9T2kQTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319048; c=relaxed/simple;
	bh=uRgus6ap6UsFDDBmM2pJHp72WytHzj9mX4PcKkZx2tg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uU4u7xcc4xHAK8GL5WlCphLGbb6BKsSXVwuVh6dMsKdX4moJ4BIB7fCYzMhV5Od8oxkrGbkBLPXgjwmWx3y5PyIFHS4UsZNpAeEzyvka7qkBFkSO92lPylWM1+eVqB6RXDvZd4gTPp5WbYpNH8j4ejrIp0iUVQZ0Diw98OahNC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciAzFHV8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739319047; x=1770855047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uRgus6ap6UsFDDBmM2pJHp72WytHzj9mX4PcKkZx2tg=;
  b=ciAzFHV8Q9zhW+RryzZ1WwZhn/XtBsF62WjYu9HLu0S/eigqQ78gM28l
   dfLunskIvC6i3Y8qus7gt9isQQjLboR5Xpf6ngRzwtn35L6VnpNo9waFv
   /J4CGVWv6GutM0UpD8+9NBV0NRe/9mBBe4X95CKo64QY1yNl81PuLsIya
   mQnXiDg0llFXCbl8ORNLdOwdVn/Gv3JkV0U+BAqwU5ExVO8ilz2EEQkLA
   3FGnR+ztRfyuN1Ra3pea3V4UYUy5zgLM2JeS2DUMJOzg16EFirLSdY3u6
   zpmD3vBSCd1wWeDK5s8RIrMM0mj+LeNeLuQfpRxSjbFZ3pV6Wva21XUdQ
   Q==;
X-CSE-ConnectionGUID: CM0U56fxRD+og/UX1U3GeQ==
X-CSE-MsgGUID: fbkLbTL7ToKGw30tmC+HUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57495314"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="57495314"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:10:46 -0800
X-CSE-ConnectionGUID: 18rxs5MeQcq61Uvhls7fDA==
X-CSE-MsgGUID: ESRYIRhkSKGnoKST/DiudA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="113305425"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 16:10:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 16:10:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 16:10:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 16:10:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cebpqpC2Vn2YPl1UPI27Jj3Pex+RsazVNT1+LZ3gWAvfNXSFkqOkVXRI9OUZ9e7Rwzbf1f/0Vfb3lYsfTl40U7GnQmdwsQATo5NC3cQOFaS6Ta8uv1Ye7uOrWH0sdIaxNfyFzVrXU7hZxPUqgLxaqqfBW8D91Ly7Oadj2hUqy69bd3Xwt5QB61iLDPWId4fPEYU29URLIv8d0BO5KqED/TxHaiiutg3OjxY7Jy68emGmeyXY6FabZrgaZnfvkXE1IjEANlfYKz6SZQujP5LejUQO7I/D5UrXWFRwoGp3bs8w8LKLzvq8Pk3x763tsTpZgW144n+QlwveZzdpTwtFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRgus6ap6UsFDDBmM2pJHp72WytHzj9mX4PcKkZx2tg=;
 b=FyVdYWPL9eA01P4ltfO+o8JmIuU4ooakLKCjvimf0A6SzQxIQ2WLTxKeXevUDU7tBqKhZ4xnz+8AsGr5Dok33AqUy4Q+9fpclPJ4nOpHgaenVNl745ZPtEp3LgzlBHn2Qj9vgvCiplBLPkKxX2+yE2PKgR0Y8IH/N2gFtdUO9s9Sl41qwQjYdknDX77E2HC4Du/dPzM/G39Z+9wHxkIrk7Bsx6cSIHyVQLYfPHXS1kiPWaK7hu/865nJFFuM/1Bj1ZhhrerkwR/sg5oTcOdnXxTMX2gpzG0xEYqAtJLyJRgFBbcE0uChPvRfk2SJTWmBVGkfM6WdBbbPhM9ueksARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DS7PR11MB7739.namprd11.prod.outlook.com (2603:10b6:8:e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Wed, 12 Feb
 2025 00:10:41 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 00:10:41 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Simon Horman <horms@kernel.org>, "Zaki, Ahmed" <ahmed.zaki@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, Sudheer Mogilappagari
	<sudheer.mogilappagari@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: synchronize pending IRQs
 after disable
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: synchronize pending IRQs
 after disable
Thread-Index: AQHbaByjJo70s8XJ+UeLUmJEvt+uwLMZuREAgCk4xtA=
Date: Wed, 12 Feb 2025 00:10:41 +0000
Message-ID: <SJ1PR11MB62974D04CFBC8CEF7072F4259BFC2@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250116134257.93643-1-ahmed.zaki@intel.com>
 <20250116182958.GG6206@kernel.org>
In-Reply-To: <20250116182958.GG6206@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|DS7PR11MB7739:EE_
x-ms-office365-filtering-correlation-id: 6a3258fd-db61-49ae-12ba-08dd4af9aff0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Qb5xFQIotkjjYU1DaOWknpt+uf31U66FcFZghzbPHjM16ORO5D2tKJqu9V7L?=
 =?us-ascii?Q?wmBheISJHuAKrGZHTi6riU01bE7MGFkSrb0ey3WFXJcA2lZLI0tiLihCjZqa?=
 =?us-ascii?Q?r4LLgJRIPL5/NrHjhr0u23jAXL6ovunNdSk0fsWJmcpSyDWpPIzyppI4lv5B?=
 =?us-ascii?Q?yuplwYSBzNsLA/OB2KWdWkNneNjDV5URC8UBFK5HkJPEp7zRytXxiSOvuzhu?=
 =?us-ascii?Q?juzDoBbYccoenAgp3vxWvYznN6NdlCJdnK2x9vHwu/GoH/JtNsmL9mZpBhQm?=
 =?us-ascii?Q?mcwGAvB+laEGo/EgE72nIJ7K2FUqg3psX2queZx8Gqsb898RNT2nGvJ8Hrl2?=
 =?us-ascii?Q?7X+T7QVUY6fVauWWkHC+wnSZAfyklLCBGyaYbwsFDlwzcpqnkRQD87eLJAPZ?=
 =?us-ascii?Q?swgAM9C0bPchYtGWp4eOW3AHU2z2KFYL4iQ+qcLmW6Rc52jmObFBmnJzlrX9?=
 =?us-ascii?Q?RrFvH/lYWiL89zCAPE+EJUlhtOYkGmosSrezUjtNPNiuMTvxZRuCXBtYwKnW?=
 =?us-ascii?Q?8mBWIwbiuQpNKtRW0gI1+51XRHqsfvJ2zneEehurQ7j7izUjyjDr0aftJMiG?=
 =?us-ascii?Q?rReRdrY8n1vdgvt9gNfyCCQpsPjqqCcZ2HI7nognLfqwKnobhBPRoI84utAA?=
 =?us-ascii?Q?qJtw4k5NOCgo4rpTmVr+zFX6y5F8ZF/JBA0ZTvIGiztPUgXAHNQGIhaULgtc?=
 =?us-ascii?Q?v33fsrcM30qOb8coYJThyxFzkKWKtFDaoFZ/5agIYIDb+mXHLc/3rPjzTj2f?=
 =?us-ascii?Q?32XDenM/OMzQICKNtwU5mrOw5tQxOQudA312LD4DKJgieO85rpfuVVnBCwZO?=
 =?us-ascii?Q?YUMkX01sgTKmTXGqB5osWYncoWIIyHO1VMW5r9iK6n+13Ea48uVAK19xjB7E?=
 =?us-ascii?Q?5djJRnNDDVnMuIAXpqw8iuXGxsIW2XSy+nUocH6364nh7wiNPsT73KWP00la?=
 =?us-ascii?Q?3bcJfToHsRQQCRpMycev0zy8lbBaNwHbGQZscYEJWmFsP9OEyfCRlUUx9YJh?=
 =?us-ascii?Q?g98GD7X3Gp2hjtsXF31f9u/p0iavBH7uQ9V/HPC5eLQtMAcHyGkL5YTIYweU?=
 =?us-ascii?Q?xKhBOAKthHDfrqcmNd2Ype2qX2prN0H3WKOvTkoM0Jt+DWF/mHyryzSh9tel?=
 =?us-ascii?Q?gRfIwwztNavCdATMPTNT5mmMG5/VvmSrJA2l01DSjgk/tjPO67CPuQ+ApQR8?=
 =?us-ascii?Q?qR/rBlbBONbiqSMIjwvnsZuzBdGdab/76BFaAzypPQ9yZ2S5eWqXZ6TihNkj?=
 =?us-ascii?Q?KT3K542s3iA5Dc0fDxQ4/tsnT7XtAFZyFiHSHCkXDJhRRttlL+i1sgmBkvj3?=
 =?us-ascii?Q?Weqv2LfhI5iiM+dcJaLRfujGmaUsuqaDmoeE/OqGJFqWVNzNB4v91nBiw5dn?=
 =?us-ascii?Q?DBC96RFpOxCeYnj4qCsPzyaCmgKZlbgeBXzpkKOVBRyd0N6O6iV6DmdJireQ?=
 =?us-ascii?Q?dG8mqcsoBYImNAQUSAEt2NMES9jLUWFJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FbcbWmaxTQOE8snVnB1liMGRDJKttG/mOpe87oWFj5gLdeewfgnUfu5BFpVO?=
 =?us-ascii?Q?p8F4pDQNR6E8OI6meLpP4cp6J6+K7t3F7ZCNEsJ4hNTszbz41amfL75O4oK0?=
 =?us-ascii?Q?rvSjxnsmpmvGw6PQ/mO+CgFhgKHRQ/wOlL9HfjBoijPZt+Q3xGUBpI9XkUOo?=
 =?us-ascii?Q?qRDWtlsUNfsuWP8a1jQnL+hvPuDm4591pi8dtjWEeMbXzcMaLocRnnn62faS?=
 =?us-ascii?Q?g2IleivT/GCxZdJuVgx8bev1lJ3qG8PScDeR18aFx4lvTpEqsrIg0lA4qrur?=
 =?us-ascii?Q?SbxSkoMGSL6LBQCstmAVd0PP+jqApsftD2l0oLsAmK1FbmY0dxLTT71xdV2s?=
 =?us-ascii?Q?dguWbA8A7PDhBjEgKviLqagm1aIqzh7GCmf6kB9FaGout2BQnqGNAo08c9LH?=
 =?us-ascii?Q?dxUPloE3Dqsj5A5rZVP+SMhIe4Wo3Edz31PvXR0oPJmNhsMgcXOw3Dp+st65?=
 =?us-ascii?Q?W2wu4rAg9ahVlk/CYTRRGuN2AJv4uYh+83Wu9H0LbjK1YLiy6lB8/3T9dirp?=
 =?us-ascii?Q?ufnpJPkx2mL9+1uPJEvrZOQTfo0JdjfRn9lcrBW4DDRyy+4iFZ5jFn0B7gbU?=
 =?us-ascii?Q?ueEl+SMFie1+bW3wWMVRsIxBzCZn+ZCu9m4I/MwhoUxSkPtf0nGbX9Tg1N7A?=
 =?us-ascii?Q?CMXDGHWzNQrDLEUxBlWYa+oIKrTPApFaF342EoxurWAAVnzOquyZWSGgVEtg?=
 =?us-ascii?Q?ssCXJB71g3aOY16NArbnMrcPn+EKlT5zzuTiIvEK72bm0ThFU89Y0UvUyZGx?=
 =?us-ascii?Q?4528Qi5ajoZ6c7nchsk91eAVbIaxw7s7T4WHSF5HdMAvUcNoHy5y/vaPk1HB?=
 =?us-ascii?Q?UxbcC0HpnzJshx4s9tkjfYZRTm7kgO8+AntReQHBq9aHUxKuBtI+SmhwWCdM?=
 =?us-ascii?Q?VzGVH3rZOzp/qaNwNuYHMbffne8FngcXEo8fdKrV3cwG/Km+2XOXo69AUDi+?=
 =?us-ascii?Q?9EVlpeMBBhQpfsNjbcupmM5eaJd40RXe40J/qOkggA9TafjhNfmJnq8uKiOp?=
 =?us-ascii?Q?/PJ1t8UX5KV45W++qMK3am0hxWqpmDTxo0wG9/WT3h0ikwnLZEZ/vpPSXqyI?=
 =?us-ascii?Q?Qw3DdtvXbDnBy7M+Ly4VM7k3HmkRk7ZUhz2epNayw+pmnIRm32RdK5XNuOGC?=
 =?us-ascii?Q?VoXmaX3DgxBrQlWZA8gTMBFDxpGc2nOdvcN86LxRQr1Mw+K6l7Q8XeFVfrWQ?=
 =?us-ascii?Q?FQScghqPGQs3NyflVpwuLDUYTKauvyQrselS0aibt0VEo+QKDirdCU1XG9py?=
 =?us-ascii?Q?h03PWw3UE6IQxUiyO2MgIRt5PhYzt9uluI6pHbHs36NmYhFBaaZf6Qk6XNus?=
 =?us-ascii?Q?9mRVCsk3rzc/6/dDgOrxkkrQAt8ehzXkQfzHVw3B67Af3i8cz0gqKofoHA2a?=
 =?us-ascii?Q?x6RhSLPvW54q3gu5oU3mpgrlk1qaGxDFPLEoqOWO10jEhPKi8lpgJbkw8b3B?=
 =?us-ascii?Q?gPPkIbBp+H837zqgWYisVZ6UWtPrQsjt6BF2oImX3sOmGevqoFJKutfKE6Am?=
 =?us-ascii?Q?Ege559+4wiSpUbLvpYjbo6/Kq62R4OxeJaZpdKzu43PPC0nu/eJWpOUegarr?=
 =?us-ascii?Q?hg3mGDyuSUNZb271zFOINIfxUn0AwsezFmeyLAI1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3258fd-db61-49ae-12ba-08dd4af9aff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 00:10:41.4889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xqh6idDpBswd8bQoeKFElmLYWVAVmzVb46Nz0YMW/eY0B01ld8d+3JmZ9nDkKnD2s42Ph4Xys2Pz4x45Wqdsfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7739
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Thursday, January 16, 2025 10:30 AM
> To: Zaki, Ahmed <ahmed.zaki@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Chittim, Ma=
dhu
> <madhu.chittim@intel.com>; Sudheer Mogilappagari
> <sudheer.mogilappagari@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: synchronize pending =
IRQs
> after disable
>=20
> On Thu, Jan 16, 2025 at 06:42:57AM -0700, Ahmed Zaki wrote:
> > Wait for pending IRQ handler after it is disabled. This will ensure
> > the IRQ is cleanly freed afterwards.
> >
> > Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > Suggested-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> > Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Samuel Salin <Samuel.salin@intel.com>

