Return-Path: <netdev+bounces-231546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E20A2BFA481
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D816E4FAAB6
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02C22F0C74;
	Wed, 22 Oct 2025 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OW2Ow0Kq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F992EFD8A
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115445; cv=fail; b=JFEJbRjwkZOFLrawMsCsUphJ5kW+nB8x6jJIjNemUqrVmWB32pJ55QlqUxErXA4s+gRdzkCGcX0oIFr7LtUQegH/46CUJobbI94YR1YE6SboUkkW2LxwCMEN45n9plVFyMRkCHt/x+wuRyeXfVpz41Bh9ECUAsYby/Rd8jN0UBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115445; c=relaxed/simple;
	bh=AOhiyydmqFlJHOZSc0e5w4yfnr7ez67fCI1iMOV9qC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EAr8sUQDF64A2f5lRk163wrnr4INvDGwnBZvSui9kIU+e1vBddszaFM1ZOCUmVMnSG/Urync4i/D7qtkSAr+tC0u7hSlBJOT3vBRsrXbQtxDsKCvxxrFOl5re/SN9zKsqeRA7ER90gMfzDVL6zolTT7enjqFU35T+jc/zTQrGSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OW2Ow0Kq; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761115444; x=1792651444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AOhiyydmqFlJHOZSc0e5w4yfnr7ez67fCI1iMOV9qC0=;
  b=OW2Ow0Kq4PkU4AE8bwa6PYx3xYEZoTumvcovr6cdUIHl9kNCECE7LNhB
   2O2bCIJKFKzcUutmNwNdxfCwYScf3YI/gCu+PM9E8ntZYiZkEMnQUITbO
   YN/5LZjtSp6rvBUhlaK62JHm24LGdZSX1Pa6IVbZMm97B8J+TrXiYKVZx
   nANDwbBOCuwt9xiCD08iKp8SQPapTZRIJlIMteCIJrNmFRoFEkPNPFzu0
   to2Wyc/CCZQJ5piPJeF+wVko0hAKkPA2bt2uGDRq1N9y0pVZ3CJEWMSC+
   x33b7P7UNWTDs+D0KaSHumMb5lR/d/ZWynXOpwk67Nw8tJp+4HRxTf/7B
   g==;
X-CSE-ConnectionGUID: I+FNBDPPQgaBQlb56IO/sQ==
X-CSE-MsgGUID: XpFKKKcbSeCKcsfLDsqwgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73859493"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="73859493"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 23:44:03 -0700
X-CSE-ConnectionGUID: thzE7c0QQGGH19KqrPWH3w==
X-CSE-MsgGUID: k6h0a5YyQd2ob5aDn5CTrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183824094"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 23:44:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 23:44:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 23:44:02 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 23:44:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQYXPMEmSP/5PKy27zGA6TRctmUFGDha2jlq1Bwmeq/tYE+0DFnoDCo5t7W/4ZhWXqIAJHwLvoa0EoX6R2LqvQONjP3MvTtXKG7TR2NevCqbN3ITltD40TPLBbYD8dcWQ9WXRPWzQKJac9gX0TMXciuJTFNL1CcOjWszae3wpuQGgWEaZRcgTk4Wev5iGhlGwZxnA/CLH9OwfW+pQ9wwHTAynJLwaVULg4tCD0/Lk78gMZeIC2l+TCl4F/ehh79jV6RWkMAUHrM72dXp35mP+l0J95y6j1P8YVmFXfTmkkIDqViw90iuFWBDs0yCNDcMA1eZMKgnIWxihcwQ8ZH1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/vUuL84/mAYlnhopUa53zH3JFSwk84+a++ICYXr1IY=;
 b=K/Fo0ow609sgIPLYqDbuPQ1jO7QS13NOrQqq48rlUc8FnfKtEcZoPRze6nOuOdBh50+QKVp+RLpuoTrgi1Bo+Iwj3P4IANm0czMPKXT3Ic+I7/UIM6cImVBDQQUsRm04vpybUI37xZB84Xww88i2CZDAacZ/AWqXmLI+nzb5CF+DgukhcqYdFudfudU46paRMyoEmnGk6Bv9AqeRT/lzhWT8oMl1Qa4rLVTCy3x4S98NEv5tB+9pS0LyEejqPyUHZmrWD025IkrewBgfPafT7xP1QQN5LGO0X7TDu3phbMXkZbpndIFoWHuqBxgdkap7KkAPJIxcKu1vim/IdnLsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ1PR11MB6155.namprd11.prod.outlook.com (2603:10b6:a03:45e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:43:55 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9228.015; Wed, 22 Oct 2025
 06:43:55 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 10/10] idpf: generalize
 mailbox API
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 10/10] idpf: generalize
 mailbox API
Thread-Index: AQHcQuFandtxmaiw/k2ddmsWPunyQrTNuJaw
Date: Wed, 22 Oct 2025 06:43:55 +0000
Message-ID: <IA3PR11MB8986CE8111F7675437B3CE86E5F3A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251021233056.1320108-1-joshua.a.hay@intel.com>
 <20251021233056.1320108-11-joshua.a.hay@intel.com>
In-Reply-To: <20251021233056.1320108-11-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ1PR11MB6155:EE_
x-ms-office365-filtering-correlation-id: edd7357b-5b9d-45c0-c7c2-08de11365f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?QeGd2bh0fVxei6FAfmOfTKCGSk4UoYP06Hs67PVvh8213PMW+YjxFLE6A4xG?=
 =?us-ascii?Q?SxTYJD1Y1lz5msWga34uZPXjZfB7CKzkX+40EBuAcfD4hQg1kFbKHHYSZAQ+?=
 =?us-ascii?Q?BEK9kqitAYv87twJ4/g52bVefmLMHVfzHWlxYEkRzt6tOzsc/yfReu0TVaaA?=
 =?us-ascii?Q?aO4C+Wf/Rty5XDJIDm4nk1EAr7UKvIfuULQw2q0rKG52bZM+88ZW1o+EzTgE?=
 =?us-ascii?Q?BA8fTrQZ2bTu6eEj/qBSKUyB8tkSOaY2UsQacubdxz1HnNoTWHQEoTZI0MfO?=
 =?us-ascii?Q?Rny7yMxhUcQ6Rv6SOX+4EdczmDhjowBuB/A8I1Cibo7121aY0B9+/6zuYQfX?=
 =?us-ascii?Q?qfoh9+xj9dPH3Su59BVR5N18Tr0wmVGXRyGVw4j1l9KgcFNzgy8xzqPIMUT/?=
 =?us-ascii?Q?YXCn2sNbFIJDDNRbm/BFsXxt97WwarlRAUjN+DUvwG0b79Rk97i+dvkB7fqq?=
 =?us-ascii?Q?ctP0RkcjN5l7NmNNmxThbw/LihJaNh897Z5V2m3RVOsx8VJo44f21pYNlBqj?=
 =?us-ascii?Q?xWrcy2Uah7Tl7CsAyksK04io9GrTbzwoOgp+nyxbGwp+QqcAv5nMemhCNc49?=
 =?us-ascii?Q?F0L5y8kxPYy/QUdzevyXSjIVvia07TpOcv7m9bWP7jv5MsIPgnF+RoipgZDJ?=
 =?us-ascii?Q?Wva/JXNS0jlQX3IRZPdHbczcoKRH3WKNAoyHrYARndcYpGJJ1+IVn18c/9FR?=
 =?us-ascii?Q?pjfad3vhY7Io/7mGagV0Yz5H2Su8ccijdgRX/WaHH27SMLTCywQZSUcOrB9A?=
 =?us-ascii?Q?mI8MNU6ANxfiHiP2VBwvh2uZUAgXVSqk6WzLKjywaqyci0GczAgLv2bLlZFT?=
 =?us-ascii?Q?kqdHaWqukryhX7HMzsCR/Ua5yxTqo0121WeSOp+XLC16rcuTGumwzg7jSR70?=
 =?us-ascii?Q?6fLOJHjcHLcZHZ/BOVncwcRuxZgySHmgT0lIz4NTWsomb69BNqgH0E+jJGKD?=
 =?us-ascii?Q?EmqNSnsZiT2flt7u1Vikm/qlwAj6tKyqN/DzrTSZ7Vngm7Yh5J5ssukcJ41i?=
 =?us-ascii?Q?+Mj9UxL2+/YaTQXuVFpX0mr9Sa2vWwG2N8Az+XqOUSvtwpESu8bBGlFRcdJy?=
 =?us-ascii?Q?Z1XiEt1J4tDvzZOiiqtGyWaxbdYeExhsNSkYD0b5ly+E9G3WeMPqqu1mwocc?=
 =?us-ascii?Q?Gaky/4xPmHf61nl+NsrpqEfNK3+3p+ODYroAu0wqhVAmTnzfB59fbkoIvaM3?=
 =?us-ascii?Q?mhU3zSCOnYgyJ8dnMLILA1tMOkzKlp5CdKUkvkWnNO1vhVJl4ujo5KidUfng?=
 =?us-ascii?Q?cbZTNt9w1Pk6lJ2Qqpkprd1/Ui1aPpuudobPRCXf5eYwCTWl2ymwdj/0GUQg?=
 =?us-ascii?Q?JzFtCBHbhVaqKOaXAjF5/7YqtuE+LTPaJOPAJWE1ppR/rwZwe5htdj0mZwGo?=
 =?us-ascii?Q?vZgjHL992vy5Hbh/dX61IATonR5XC5dZR+w0QDlAKtwcI0lWCJpIme51fx2Q?=
 =?us-ascii?Q?2S2MxYsYqlBSx6IRm+cr8y8LBxswEK5bn/chfMuzDzxomwpCtkdif28B2Kjw?=
 =?us-ascii?Q?iomw+xhFPmKGy+QEH3V/Wc8pKFG2BnBs/flJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tlc2cIzksAxJGdOKmJ8gKqSQH5eWGfuDjgxNdiYEFASNh0w0Q5c20lNGCi8X?=
 =?us-ascii?Q?DjBNZrEIyLXTs+drm4RW+5vm6Awhb3IwjpK2qyJV6y9FeLANcxHY7SOySdyi?=
 =?us-ascii?Q?4UJf6eqGj83WjzpUbsUTbxCzt56KCowzo4JkqacXefP1l55QxBt2d6le8Sn3?=
 =?us-ascii?Q?3V+m/cowAeQ1PwGhgC6GwNFZYL7YQo/PVloY8NU4ls0lr3tH0SGYW9DEgCg4?=
 =?us-ascii?Q?VzbBGqXt/kc4iP4mRLE+PlxTvmYmveKHsqvCd0FKjjMhe2jONHNbnXpdD1rp?=
 =?us-ascii?Q?+WiSD4yfIQlOaKhtms0QYaeACZggiHinaBGse0U6PuBDdhv1YOA6n+R3Yjhs?=
 =?us-ascii?Q?ErQSSPgpurgU0aJJkFu4IoOnrJU4gOq3PnXdfoCdkA+B+Ioie3t5LKgnvcs0?=
 =?us-ascii?Q?5/5GgRfY2wgEv1K36AawcLrqxDrYdYh1p9aTfqekPJPhsxDkhDsOhoyE/AaK?=
 =?us-ascii?Q?yuIV1vPBZ2041XpVkSgByoibEWSHV1GaM+VMXmCWYkxohhRFzR+dhvKYPZYG?=
 =?us-ascii?Q?ikqrDej1OpiM+3X2xRDGwNZ0IEJA3oRhx5DoLPxHdKP7UKBR/kKJjX61Rpio?=
 =?us-ascii?Q?Q68Y5Zwsr4yb4v7iQdJ87Fbkjoh3SkPRJNtCq1wrR6Be28mTZTyFU3ZZ+gk0?=
 =?us-ascii?Q?7t7khHFDHhZpl1n8cqfsfQCaE0XidXEJUYdhslOH3jGReLYAkR/uLFV8zC+6?=
 =?us-ascii?Q?QzofONQAEEWLFyZ+z3LEaEhBrN8Lm2vbMgc5ESVSZ4LGpfAZiPfFBdreaiTC?=
 =?us-ascii?Q?zt++KHeiYbTdMtRvd0SaIuVQXqIq33qwvi7l+i+TfIsuSkNvVTLZZZOetTwk?=
 =?us-ascii?Q?8LgrPtk9/oOZd1JGQUg887UST3ERMSbykKYE9pGWPptLRchvlzZ2mNz+X3XV?=
 =?us-ascii?Q?Ei/2ok8H9dUUwQTd52J9w8wEM3K8TJZUaPPqNjICLBml4JKCJQUdJYaxBtdR?=
 =?us-ascii?Q?4vvIe2QFWesi7IXVYGnt8aUf04u6XPcqafzH43RDtLQ9g111JFcDPu28rj0I?=
 =?us-ascii?Q?T+me8sx9udjIZq6PkNvQxJMNkMDCWil3g7R29FBaLWtBdknxeRnwBEcoEGy2?=
 =?us-ascii?Q?X3g/eZVLWcZG8pA73lQWYDerlPPNUuk8pWa7gLnxlEeb02uad4CQwh2hREyF?=
 =?us-ascii?Q?2Hx5L2vLAMGmj/AUH7fc3m/2wlah0EMHOZJESCrn9xADkJA4Lq5GefeFuNsn?=
 =?us-ascii?Q?i7LPzVit+Rm9RomempTANe6kHoo0j+iKlm5+6+r41Cx/9WAra6qMwbAB+kmj?=
 =?us-ascii?Q?d0jYBnIgEwcLOkSdwz9SlcNZXo5poD9fJWp0pmXGLmLvKgG8aC7HPScT2A2l?=
 =?us-ascii?Q?Z8/DNPvhc7eRC6DZqqyRC/b3BRe2Q8nbRGTQu30kx0inFDNU+kzcbBbuY8zM?=
 =?us-ascii?Q?0bv/9+h+NxCHILdMp4+JrTuHZVuAIQXvL0FTPHPRbznq4oIMHkxIKiWCdqDA?=
 =?us-ascii?Q?bIWyPmnBJZPKPZCNnbNNvmr6wqaIG6/vgFbSKOacHJsiIFT1Br84kiKxDy87?=
 =?us-ascii?Q?LHLR+xT76u0XeLYQh8yjo/DZfmnHm5CLBKUVfiCocScO9pz98koYm4VC01ZE?=
 =?us-ascii?Q?h+J3GJb/YUtr1y6Q+8K4KlK61Wc5iVM+/mVYrA0JYuDFUZJKA+JvEXx+50A/?=
 =?us-ascii?Q?dA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: edd7357b-5b9d-45c0-c7c2-08de11365f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 06:43:55.4522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LcP5Lw6R+vKESEirZZtI/z/F9qlYdCUjLwR9KlSaW7Bq5KLa3EsQFyNgAnK4q+W0N4HnB7K+Mh4RE/UGTc6f3uQBHiRFGt82KfK5uGkLeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6155
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Joshua Hay
> Sent: Wednesday, October 22, 2025 1:31 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v9 10/10] idpf: generalize
> mailbox API
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> Add a control queue parameter to all mailbox APIs in order to make use
> of those APIs for non-default mailbox as well.
>=20
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
> v8: rebase on AF_XDP series
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 +-
>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  3 +-
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 33 ++++++++++--------
> -
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  6 ++--
>  4 files changed, 24 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index d9086be69af0..7c86e4084006 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1315,7 +1315,7 @@ void idpf_mbx_task(struct work_struct *work)
>  		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task,
>  				   msecs_to_jiffies(300));

...

> --
> 2.39.2

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

