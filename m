Return-Path: <netdev+bounces-278419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cECVKCAp3mmSoQkAu9opvQ
	(envelope-from <netdev+bounces-278419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:46:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6743F98FA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17ACC307A51F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B9B3DB636;
	Tue, 14 Apr 2026 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbR0T4Kr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439835B658
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166866; cv=fail; b=Y7S8mMOnB5W5XJEpZMkOwTOOe8DaD/f46hmygtS21eduO05SdvmaMI/K278heb7cZrirmZJcVi1WOjiY1eCoGC6UQ0amIL2qtn2isXUB/P37yU9EcLgbYr0qYZtD0X+70fOu9JLHrtLeGF5Q4IO/4nA4tnoAuP/wFDFvz9z8bBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166866; c=relaxed/simple;
	bh=2/p+ai56w1exdtbl8TM41OyKBXE5juav9sNkUMR2Nn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cFPpX3gQo3RRx2IyQkYGjTxwGbh54JaPNL1iFKzLibdITwv+3pEmwU+pjB92fKpixXQSseyab5zj6N8KUo7rnsFhWCaxJSyU2anFkaFQ/XvnmriGpPpJLtTGX8H1/qYg8CHL/nWAYCrMntHBTsrCsBIQh1R1SV2xi5eum/RkY6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbR0T4Kr; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776166865; x=1807702865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2/p+ai56w1exdtbl8TM41OyKBXE5juav9sNkUMR2Nn8=;
  b=jbR0T4KrnCMseVDdo69PKFImCy7aK3SQwcufaLNL65jUNZtb0yO3HbCj
   11OTN30eQ1vFU7rQzT5LaNF/FoP61ujN1wOBaPU1JiuSkGaXmVWuoDf+2
   B4lJnAhTph3XBTtzInWBo1zY/E3dIkftSs14idxGdivfHCpMR/dTuMLgs
   t86/fHwjIPApDg5F4b/Z9hZSzdNbYNBQ20N51dwtCyj9dGLvkrOhG0xOq
   mCtDIJ3WEls+hyvUmfkyGwGOsd1iQ3cLqcnYmqfitVe4oaS39481xMgRZ
   0w4S7FHTFI6HJ9hzG2065qpmZpSEILwtUJYrw2gZb2r0IGm0T00tV12Kw
   g==;
X-CSE-ConnectionGUID: +laoDuM4TDix3LGx9wzahw==
X-CSE-MsgGUID: WD0vCUXyQd+SE/jUx5fm9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76828018"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76828018"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:41:05 -0700
X-CSE-ConnectionGUID: +oUP++LXSSW3n2/0iKpUsQ==
X-CSE-MsgGUID: 9qLfC1f/R46C6lifxJZQYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225769158"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:41:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:41:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 04:41:03 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 04:41:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIShCtDFADJt7rjzbWXsR/JxN3vHUsIuHtg4R844DG87q6iiombSEMbqNB6SmBuXoUtOlUsVqZ2CgnNVJuHJbjAj4A6AAP86P4Sl+cU4yFT5zFwHSmbYC7MJbHEdq3jwYXeafoQvAPgyPcv+Ahs1yFVcKZhNgBust0ZvlzrztdrjdNRKClZT23hb9T/RsVAWeAX2RuVXxlGwFme4xEonRP3Al/gsDqwSYl+Xx8qLPYRZd9vLWaZyrjksziZdovqF0Q1dX8IzYIMZ0U4YP5QfnLTL3sHAEkxu97y/cEShIXhkuYOYOVz7+F1VvMYFe6vh9fXHEKPt0pGJWdZpeeL60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXJ2cVK4wDRFrwEaY5jxyHg1yAztW/DAEgr6cHeKRFM=;
 b=e69im8DafOIXlUgVvg8Wp6P0q02DIuaFjXW4ab1or3qqOjrmLqnSz/o6b3QjiIGESvnHJUfjEfjK3ZLc+YKKaLYL9nkg8MC0nxCoG78koLUG7jgYSQ3l+7MESK+4qc88IHasOF4rGdcuicCw9TijGu0BlyH0B4Z/q/H3eE8yKEeUujCSQVkv1DzDzH7vlQFfISFo3y57HL9lIhA71Ylg2PJDKc0XldIT7jWxOOxJOrMs00A8kBH2bP7aEDR1NYZCHyN+4YwVXqdBCCKOhh/S5VUS1XZCmbSP333+rhW+tYQcbcIQq5iMOQcahV4fWjYpkHuMuMD9Rc/UGTZKWR9UQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9874.namprd11.prod.outlook.com (2603:10b6:806:4d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 11:41:01 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Tue, 14 Apr 2026
 11:41:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH net v3 2/5] i40e: skip unnecessary VF
 reset when setting trust
Thread-Topic: [Intel-wired-lan] [PATCH net v3 2/5] i40e: skip unnecessary VF
 reset when setting trust
Thread-Index: AQHcy/4FD/VDGsl4hkyWju+rfno3a7XebwqA
Date: Tue, 14 Apr 2026 11:41:00 +0000
Message-ID: <IA3PR11MB8986C3C5FC072916F2036E75E5252@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260414110006.124286-1-jtornosm@redhat.com>
 <20260414110006.124286-3-jtornosm@redhat.com>
In-Reply-To: <20260414110006.124286-3-jtornosm@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9874:EE_
x-ms-office365-filtering-correlation-id: bee5c204-8b64-4c7e-a0f4-08de9a1ab3c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Z/3ZSCAcJFLl00K/e9O1q9IWBLQXLx/TWSGyXPzcdpm2WzkXCXZpvAcwdPvq6euuy7cpbpTGbGPbrNFYd2ZHA+XsJYeg3IyJTNAU1m+5wEmCcyrV1MrPv2Osu+pgYp6nRUReI+tF3J/lKebwRFj1ALMavdVS4kD1q6TY19+ub6jLnhlCxP0TpL0+PjkryMDWFc20MkTryTelt8sba3Z4DFp3ekhjUHuNTdqmYPnRJQRyMUcvKoQGJB/QXpKp6HYk1kafPrSMmskbDXgGRaM50KMj4Kt/63P19u1N5c7bY6L2EqOxIOqJvd3BCdKkXakFVgK2hWoqLVzcJdfiYKZLH3aczC0bovJrRPMQiEM0f8m7C5YpMTMoovp+qfDXZunvSp83M0sBAYM0KYXjB2TyNNK1P0huU1k5d6Bsz8sA8o6jpwp/73ILYXte7RGjxW0vl9whzHPNjvmxRQ1zxl8q7jvx8Zzk3fLFXy4e4mO14JQ+gXpqOqqlsblLTwj5aPXgTGrVtqmybVMT9xbhD9uFX611pt33pdZ6R0RkCCb1c2AcLCc0ihP4AJxnss1w1ZFoQ9x1ISNSr+kzIWIVant8lJT7erZ0wTl+Enc1hkaYH94DzS4yFZuQMJ7kObXg1qlLWrMh3HA+YqMtHaktQRz5jUzJJutkpSY3BXoZexN0+u1VKmscGpC85gUXVHhp67u6m2PpKGMfjKArfjKKr+LEa4ltddf+bZzgOD6bAKGrvNhhLFmjTHbOp2jqaZBrKUzp+H54H2M+Bz3Fyt9FZunSAvrnb8ZjItQxbvwSeZXKAjE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CCa7QKOfsfxiJajExhdE0vUEV2uGZDOH9WNcw0Klqemopfdgcc6TR7fXOhYw?=
 =?us-ascii?Q?NVVdM4Anxv2Qn8V2ucPMaxsxcJfe4V21OTBouphRWe4jXfBlGOO8uHl6ZG8n?=
 =?us-ascii?Q?PoApEUA4+W1jCAfsCLAQK7BYudiDr+13Q7bZa90CITATlXp9rdDikgh+L5iZ?=
 =?us-ascii?Q?oChofYmvP3pVG6xEmNDrSMAKIifL6vf+HcKw56jZA2IUTb7yBCd32BGZlbGy?=
 =?us-ascii?Q?R7UaJEdn0n4coJJrlS9BRMyV+nB/mPJFEmIyx2uukjqlvEQHAdx4q3Y1fljU?=
 =?us-ascii?Q?AjMKhtTha9k1CtSXJH945KCudH1YkqyuPFRSMjdYcJYALNDAmtjwjwrqATEQ?=
 =?us-ascii?Q?y40gk6Cd1twnMcyXmlo6TJCG4bs9mffsV1UBoExpgO/rpVt5PyihD50LjHDZ?=
 =?us-ascii?Q?IgbCpG0Fh4JJHGIeIJSpucfzYmXIDcR2PH25McqIdxXrXOtztRwjN5m9YLpr?=
 =?us-ascii?Q?ZU3tqbDYZKoMbP6uvlNm5rY3c/ozsJk9Y4VlgulRHS5chFM9z4UIrfz88wX0?=
 =?us-ascii?Q?lxPxIW7NY2r5ChV02/OuUfifBWCBTFWH+Qn8bqtbTjrVCHfuREB4DWFR1vcC?=
 =?us-ascii?Q?mGpj5dxyx+COJg0Us3STs7y19bLTaiaRVxkg1yeZ46zdrSJ7oBORE9As0s9J?=
 =?us-ascii?Q?0AdCgvnqWbjd9d4Iuh5liwNnziVFKispoTeDNTX6NbRteekvi8zIYeJZL1yc?=
 =?us-ascii?Q?AzU3zG91MXK/rG42NXlneedh2xZtk5oC6I2+hdj0jPNlZ7T3/DRFqYdOVZ/W?=
 =?us-ascii?Q?e7Xsn/MtZEtQ0a7pFmINsKmYivQYcQXcI5Ix09SuG7LKgHg3oV0wptzuMcqj?=
 =?us-ascii?Q?L+cTTrts2DGBMOhzd2E06EqMkvZSzRpmZPCXXrR8cizdQjUSBYfCK218xLBb?=
 =?us-ascii?Q?s+pKeuNaIA5EWqjkNzltFaW4I2qcDNOKPrZIuC871UAXyfW6cy+KBKrMrOch?=
 =?us-ascii?Q?QtQ/eKNGkQy3qWQ9vVVYWVm55KyANOjcygDn7fYJdzGIAQ2fmSq1gYUr8SO9?=
 =?us-ascii?Q?LWBu2m5LiqOPTCxh60y9LzDU0ZUXHGIFpeNcR0HYIYJXV5hUJxl9N0EItmc5?=
 =?us-ascii?Q?hqf4Q9DBEuatDNZsgO6UYgUqWhNu3fgpngeyNOLd2CEaQ7mLOpopVt/t6izu?=
 =?us-ascii?Q?UnJSSDLmwLdNbhKs9iwFZoADbqEQJ/SI58v13WB7TGZaCit3EOibnHTmWWif?=
 =?us-ascii?Q?lx4LdtOgGmLLtgAMmd3vLYqnsPPNPkdajD1uWK3wCzPkAyhShufnT5kY8WN8?=
 =?us-ascii?Q?6UIgFjSW4XLBPAPoT9V1YLfaHVPgsQS39BfNRPR0bmfpza6aB2Vbr3rknwDu?=
 =?us-ascii?Q?XBsmyLUFz/9ZU9qJd3R2P6kOJOfNCEW7XO/ldb4V4gZKN9PQAAYi5RmQwdQM?=
 =?us-ascii?Q?kvy5rPMRYBej9b8dAcLZCyvcduPSb4Pvis+Lka2+I7qk1lwjVejPYJayEJgr?=
 =?us-ascii?Q?adK4EXWdSa/ZUx/D9NNBDSsX1PF24ohE6mFBG9DhV3xsLa9GL4j/VGd97aGM?=
 =?us-ascii?Q?NcoZHdOFax8Go1ReNZP03IkTt3lNsNWW/4mo+pgFhJv4zrpVb6wyP3Vd1CGE?=
 =?us-ascii?Q?AH7g+KRJlmyrb3DOSBtVUwGT8b/jUHZoDKeoFK6OoSng9tR60AYcoIELo3F8?=
 =?us-ascii?Q?/NI7UJfbv37CcP0oXSJW3tpyLD54vDLhP6rlhK0TQ9GGPnmo2AartvlmhEq4?=
 =?us-ascii?Q?1hsTk3NotYXNd37RDVDnzryBn6w97OjObX5Ck+HztIWxGo4TLO0UdYGM6Gki?=
 =?us-ascii?Q?JEhPi3BsRmi3vc/JY38pf57zfvnwY0w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UrS10IxFe8a1GmxWK4lUQDazDTy6Q05juAUWy/mqcSjNzLyjscnukqkTbpC8udl/r5EkcF5wuOwUdXYcLOyT8KBWfzkIg0j/yZr4V5U+4Ar1yjJ+eaUJ3dMSGmio25keoOmrmGFFrzZwE1AMOwQuiE5BK6akxixUva6UgOKxc9Q6mDlOa4zgu3diAJIkf/8KIsT1BV504Ml/yfpAGmQJLTnnoXHYSCmeJtmI4ALmQ99sQrgruDtwgtpbVlQdX9gsU0QRi51cT8qQdlOO6KLpJqTt6CAuBsaDQWTF4aEvhlzRjMKxQJqU8wLbEtzps4/3SHKRafRrjxGxAp+PGZPtdQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee5c204-8b64-4c7e-a0f4-08de9a1ab3c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 11:41:00.8666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XuWgQnxkrtn0yH2gjqEKn7ZjVzg8AYaBEGJ2EB27GW7Q9cK90LBsvOAvro5+m24YXYxNdQqGWynJIpt+EzAJt72myLBXep4RrmadJZjP0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9874
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278419-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3A6743F98FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Jose Ignacio Tornos Martinez
> Sent: Tuesday, April 14, 2026 1:00 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; jesse.brandeburg@intel.com;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jose Ignacio
> Tornos Martinez <jtornosm@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net v3 2/5] i40e: skip unnecessary
> VF reset when setting trust
>=20
> When VF trust is changed, i40e_ndo_set_vf_trust() always calls
> i40e_vc_reset_vf() to sync MAC/VLAN filters. However, this reset is
> only necessary when trust is removed from a VF that has ADQ (advanced
> queue) filters, which need to be deleted
>=20
> In all other cases, the reset causes a ~10 second delay during which:
> - VF must reinitialize completely
> - Any in-progress operations (like bonding enslave) fail with timeouts
> - VF is unavailable
>=20
> The MAC/VLAN filter sync will happen naturally through the normal VF
> operations and doesn't require a forced reset.
>=20
> Fix by only resetting when actually needed: when removing trust from a
> VF that has ADQ cloud filters. For all other trust changes, just
> update the trust flag and let normal operation continue.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec15..fea267af7afe 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -4987,16 +4987,21 @@ int i40e_ndo_set_vf_trust(struct net_device
> *netdev, int vf_id, bool setting)
>  	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
>  	pf->vsi[vf->lan_vsi_idx]->flags |=3D
> I40E_VSI_FLAG_FILTER_CHANGED;
>=20
> -	i40e_vc_reset_vf(vf, true);
>  	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
>  		 vf_id, setting ? "" : "un");
>=20
> +	/* Only reset VF if we're removing trust and it has ADQ cloud
> filters.
> +	 * Cloud filters can only be added when trusted, so they must
> be
> +	 * removed when trust is revoked. Other trust changes don't
> require
> +	 * reset - MAC/VLAN filter sync happens through normal
> operation.
> +	 */
>  	if (vf->adq_enabled) {
>  		if (!vf->trusted) {
>  			dev_info(&pf->pdev->dev,
>  				 "VF %u no longer Trusted, deleting all
> cloud filters\n",
>  				 vf_id);
>  			i40e_del_all_cloud_filters(vf);
> +			i40e_vc_reset_vf(vf, true);
>  		}
>  	}
>=20
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

