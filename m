Return-Path: <netdev+bounces-306490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eSw0Gbm/UGoU4gIAu9opvQ
	(envelope-from <netdev+bounces-306490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:47:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAB07393D1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:47:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=b1kx+bTu;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306490-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306490-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8184E301159D
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DAF3D0BFB;
	Fri, 10 Jul 2026 09:44:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF434F497;
	Fri, 10 Jul 2026 09:44:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676659; cv=fail; b=DwKIpXu/jiYVjqfCK4ZxIqK1YQimwcYmAngGn8ctlW2NioHbzfpUaRaJcOWAVe5a8pyot7FzMkw3N2giFtwe5loivuo3JaNbzmTd4dN6CRSB4EdftMa/wJ1iR64a4nsP8NnMAGges+Y5HdC2eVxFpNiOfxJA+4HxK6Fj9Um+Bz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676659; c=relaxed/simple;
	bh=wCqEDsF2GAM5w5+AVUz60kVlDDPYgIDvH729+GSSIcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sm7Pm1Z2wV/DgIRtiAIDOsyQmYoVQmCZtVsxMMJsgwNqvxEy+fShPfs+gCMF3xioE9/T4YzFMoJdCGDPuKeS1mLnyHfmYTf2jQ9igp0Vl2EnNm7v01rS2p4CSWsk2oMGGqkG8nmV0b/uPblUIDaQGEwt8ii1ETXafiX/vVENMkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1kx+bTu; arc=fail smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783676657; x=1815212657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wCqEDsF2GAM5w5+AVUz60kVlDDPYgIDvH729+GSSIcw=;
  b=b1kx+bTu+Ei9anMGdAW4N4phtlv4MxWVCN+0mvP5JsMpZibNlblV8AlH
   h7sjmETtNXnZo7dD5S9Y0q3WTmUyl+ocvZuGXaLez3cS6PWV31qSUwyNQ
   jWoF6fcAil1cruo1VIaZM+4GMnkk89ZCLUjF2k8cniyHtnTQ30jQ9156d
   n4HNc6WfYtF8E0Y8aiW6o9sIwvbgaSZElp2pPtM+3GyE+AJL7NhjHTS/C
   978LWnfU0vmabqCaKN6y8gLu7PzzY8Xzb/JJX556dBQ57GQO8a7tl/MuP
   z76LiQpt3Td0+HkGCTmn4usWWjw4xDizqM5crwu/7tNJCNBS03T8DcYpD
   g==;
X-CSE-ConnectionGUID: mH0WqmfXSCGnyxgAJKXCdw==
X-CSE-MsgGUID: qnPOqHhJSuaFHb8LY17u0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94725158"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94725158"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:44:17 -0700
X-CSE-ConnectionGUID: 8VSDts62R5qDYQ8izaH8jQ==
X-CSE-MsgGUID: /frS/eF5SAON6M7vWJnC+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258727146"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:44:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:44:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 02:44:16 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaW9eGMr9VxYIeDjcKa9y2vECPuOKxedcB4YuQdphwKoAbndApvcGgcIPto7tpFSsQ5prD/LphuL2KJWS1c+ziHC7OgrasT4XTmIAHf2ndgpNcyD2Azqw/tY0D4ANdVe4+VAdZjebrCeeDcJgh8Q2ORXXrx6CaYgsViGiL9qnz8DSmK5/c5/TJc6xi5bX2mglAlkzu/pis4hCFy2PQWqP/4qUvJhE4fA8JVL1w6/1xb4gEQ4R8tZL4f3LUQbGHJzwZCLsvqseopmmERlh2HYlpGG/vRbdFhPN5dyTCYNTmu0xhh4MitGma5YQ0dnyqTvUpfxaFLQBAxsulvsh7y6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5xGwoxXa97V49yVkaykwem+I9KHYxmLhi/I1ugVD+E=;
 b=kPTaD86LH59dRGhj6ktRJJ8UdONyDhANqwoCCcryuzcp4a6qnwvo4fr49QUehIRKDHVxEUwSukCh8zpVA1EPWpMjTOQ7SQDP3efEz8TjxPk1EzaGloZy2P1i67X6mt6m4gF835/QO78d7ioLYZbiBYUbLGQhvHwE7i868A7SLZd4RVv3KoNIK80pVC+m8buDVIC1bNxI+Cp8OgeTFbq27iVX2GaBdVjpBC7qpkfY2JOshsRKhXIzFhn5nHBjeellUkaWL6fBLRrxZGTI6vvHe5vMlT9f0Zjy601b+T37IQTFVwprbc2RDWHGPnkMnRhSqibHRW+w2toJPekJZNHvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by IA4PR11MB9252.namprd11.prod.outlook.com (2603:10b6:208:561::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 09:44:08 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 09:44:07 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Harshaka Narayana <harshaka.narayana@broadcom.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "ronak.doshi@broadcom.com" <ronak.doshi@broadcom.com>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "edumazet@google.com" <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"guolin.yang@broadcom.com" <guolin.yang@broadcom.com>, Sankararaman Jayaraman
	<sankararaman.jayaraman@broadcom.com>
Subject: RE: [PATCH net] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for
 Geneve packets
Thread-Topic: [PATCH net] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for
 Geneve packets
Thread-Index: AQHdDjHBWVs/tuwxtEeQpoqyGnCPGrZlgGoAgAEEWUA=
Date: Fri, 10 Jul 2026 09:44:07 +0000
Message-ID: <PH0PR11MB5902F9C2DA0790439616C7DBF0FD2@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260707165248.1859188-1-harshaka.narayana@broadcom.com>
 <20260709181146.3260540-1-harshaka.narayana@broadcom.com>
In-Reply-To: <20260709181146.3260540-1-harshaka.narayana@broadcom.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|IA4PR11MB9252:EE_
x-ms-office365-filtering-correlation-id: 5475ae6d-812c-482d-a00d-08dede67c96b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|22082099003|18002099003|38070700021|3023799007|6133799003|56012099006|11063799006;
x-microsoft-antispam-message-info: u/LJHq1LlSZj6MHz7nyw059QHjts2fqWg0LCzgnwXIV2kG3pc3k0Onz2fFvSAXmGuZvd1q3sFX0kZsxDZ7CF9ffsaXg5YIhz4wTLjN4Aoz2ke0f+i3hqZwk88pzdMf33nCKXdZlE6Bxoc5gurm16QJ9RItj6bIytCaDW2ZuU5Cfoz6Rsr4LHcfT7cH1c9TCVaVXpyLTXIYvKQDYcS8ElLW4IckCUjr4eRgeO/FHh4vw5S/FqFE7e21GIiIZ5zx+cji7aA/71oa0Cl8TSSgIHC8vcvd5hCpEPKp9bzZr0TEUTzmIG5Z8Yi/8dcYRn9h5+uNws7jG7dujAWpG7NADvd88MyW1Ll/z2y6iDgY8VJPJ3mv2EkTerqH3pnCccECgM6T50hrrrVRHOJz7GDtxwLwXIUXzxNA0ZQKVOJIMtujLxW1q+hGUl0wnbYd4BgIbHb26pTN8EgtjzlezcxEtuPSYCDOSu8OaCIeRMnzlSIw44Zxf3DP/L6o1gvBZ6vMZzVA+o6KkTUmP5Dq67LpEqYosX+6IvtotZXNomMAQfT5ZdtN5ODXRwomhUPG+hoyimP5ltk4BxvdwFTWgK1WAaHwortksuw5o3eH3BPiaepq1XjixxPh4nejj41tYooEqrK+Hilrq9xS15dPW/zcNZ15ukhLQqHvIDcj/2VhIRB7ynuomboIpkCGg7r2kA8ZROE7LYCvZcty7KjO3o5sj/IgwMMD+sSNF5H1cDL/bKvJ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(22082099003)(18002099003)(38070700021)(3023799007)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kq5uaOHP07YGHKN5EOMQl6b2Sl9RsOH1e1jYnTf4FTNaWJl0E0ySi9HFvAx2?=
 =?us-ascii?Q?pL6YvP4ZH+sY50vh3AbIU94WJF/hgFjRy+7wkdxiBDtvBFXlEKRTC+YwJrov?=
 =?us-ascii?Q?xU+vwTFJEdON7zshlRRAiQGaCkOqEkyvjJsXUSYtlRJjca/kIclmgp/SZZG/?=
 =?us-ascii?Q?o6qZHjCfgVq3IcvpvYnO0wliqLpxZHkqsqiVYtX59RW+aIpr2Vq8CHz9xqzg?=
 =?us-ascii?Q?XrSifWXISzEBf+oSdho00qrpJaG4o4Xk7EZbInIgzUPJG17/CUXYYnAIt9kq?=
 =?us-ascii?Q?LveZ4Tf/x06cxQs4YJiobO46GEdPbivN+q5BoFGFI/Ga/IAAHBqStFD+zsY8?=
 =?us-ascii?Q?kHmE5H2vlb0tr8WW78pDfI/Fd10Hxq51QQf7NJxqCjBvxdf1qQ4kr5R/SMo1?=
 =?us-ascii?Q?Zz/jsmYR8RaxxqMRgwZewkl0sb+QEN4fnw3BBOkjqwvWXp8S0OvNvVJhlaHv?=
 =?us-ascii?Q?kt9RbB5TZJO7IwUnM069sAwrshLZ1jPATOMg3mvNmOCgawlNhj8cVs4XcmTJ?=
 =?us-ascii?Q?OxCe6U9rhQ0YaxzufZIa0y51rXGvx5AOFB24JMRYBIrLP7I/oW6gXPox8W7q?=
 =?us-ascii?Q?prIbAvk5ymg50H7v6dodiVAfhf1lFHSGYZtVT1W01T/Up3QN8nLmVfzFWfwr?=
 =?us-ascii?Q?Ezkec3F52ExPNRmm+I2E2NVMNwFB4i+spZsQXD0LU52+cOf0PpBhZ2/+0/Mp?=
 =?us-ascii?Q?+D/Cw6IidYBlUYWviN0u7LpaS/4eY8T1Z/Hd9oSGrZR/3AthO1MY48DfTCnR?=
 =?us-ascii?Q?fybSrUefoI/EaZq3SFU/UjMIHH6aTtUNUV/16r7gAtZN7vByk03e26DadRuJ?=
 =?us-ascii?Q?JYR5SDvaf3bGUorb3hkNSRI3oFquVJ0ehMrlMoDI/QFvhuEkejF33PTudQNm?=
 =?us-ascii?Q?4WtV0G+Vhq0/fJITHGTqy/HxTQmbguOusrWzCbVr4Q9jipEwbY7GSj3YNVaW?=
 =?us-ascii?Q?a/lqpQ/a4Sz9QnrV3dLjXj8umD+VVL5s7xhCtBdcGGGgJzMHPFB0khSF+6Xj?=
 =?us-ascii?Q?RzTIMLgsvYCb7Ef315lRWoenex+7lbcLyz5H2wjI+0IlfK+hExIWpDK9rFB+?=
 =?us-ascii?Q?AJIIUqp3NuLPKzW3rcBQjZAAI6qE5ERBZp+OqsrvS6s5XcBERG6B4ZFY4Mxt?=
 =?us-ascii?Q?GhDa7zdHLF0oXMjdmlAtRgUuDtXYkPlo32M3Pal/m39av+dnGl5L4kh2tNwg?=
 =?us-ascii?Q?5UkorFGYd9Z63ytDNrXI5za5dxIfZrbDzAnp2ELSDdvi3miF/sFK2G3fw34X?=
 =?us-ascii?Q?sbN7D0x60dYEDXAs/nDKTbGBGAAbacQP96YgYdaC122C25bXIIb323DSL2NY?=
 =?us-ascii?Q?u8ihfUFWmf+exM+czlhVgsXBFxHtrazqtRny+OYYhK3BLzy3dO6Pz6P3X2nV?=
 =?us-ascii?Q?D0u8kgisgKur4IiZF8jWM1/k0Ixh4N2L8KdZwRq1UP8UCZknbk/Zbzi66uAa?=
 =?us-ascii?Q?fYoPm0t6Q370jQbJ+HqN5RzmyGq9QkUmhXVi1lMZCy7rsaMKGMPihRfNZu4r?=
 =?us-ascii?Q?qT/U6Tu2biV7jxhWTSlHacuJqcChZVWxlKpNfwnJz8OF6cc2AsdBqKBswNSx?=
 =?us-ascii?Q?+TEd9KwlwyN+lnHx7Vx5rWu6hQjrVn2pCsNBU80nGWzY4tmDgcJcBsBJZZcf?=
 =?us-ascii?Q?AvVlMPYv64Q+N76iX41AwPNFulpfA2/d/6V07Y0Ti4I3guuskIBf962iF8YL?=
 =?us-ascii?Q?YcBBXBqJ662C0Kde0iVNUbsWNwNXQuiKlKzMbweXAIWE2xjY2JrpTgY6q3ov?=
 =?us-ascii?Q?wmDYm2whGQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ae4AMlNsuaO0p4nMh4eg+nNnHHTjb5sCLrkFn1IStdUf8FE7yo2lZTi3veFmAZzKOyWRsYOHprgQPMulpN3sBvvxho+pbTiTdBR1WP+E0yaJ4aW1oyyA1ZnfxyOxzMkLMygZn33C4X82ZShWpK1y7yDmU9PnCaclHY5uMLVu+mh4jXcLSz9aBm+DXwh7Z5cwnTcyYvllF4WSl1LvJJvQzq7zFyBvFTwvZhO//FeInEwBIu8Cy/rPI1P+1k6HowD+8Cqp7ZBoCZJ8kMKHHrl61ZB7B3gChDywL8Q9+zth7y4L4KL9NazZyHNiTkC1Qoy/inH2UocGVSo9JyME5puyVg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5475ae6d-812c-482d-a00d-08dede67c96b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 09:44:07.4770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MK8VmS72Epblj22qIt57PfP1cujT6J5AlUy30dsr4cxwlxHpvONUMZX2aHL3mw2dN6XqspZTBRS89c7+lsaper52nDTux3Laafw2MAED5hE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9252
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306490-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:harshaka.narayana@broadcom.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:ronak.doshi@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:linux-kernel@vger.kernel.org,m:guolin.yang@broadcom.com,m:sankararaman.jayaraman@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,PH0PR11MB5902.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEAB07393D1

From: Harshaka Narayana <harshaka.narayana@broadcom.com>=20
Sent: Thursday, July 9, 2026 8:12 PM

>vmxnet3_get_hdr_len() assumes gdesc->rcd.v4/v6/tcp always describe the
>outer header, but for a Geneve-encapsulated packet the device can set
>them based on the inner header instead, signalled by the
>VMXNET3_RCD_HDR_INNER_SHIFT bit in the completion descriptor. Since the
>function never skips the outer encapsulation, this mismatch triggers:
>
>- BUG_ON(hdr.ipv4->protocol !=3D IPPROTO_TCP), because the outer
>  protocol is UDP (Geneve), not TCP.
>- BUG_ON(hdr.eth->h_proto !=3D ...), when the tunnel's outer and inner
>  IP versions differ (e.g. outer IPv6/inner IPv4 or vice versa).
>
>Check VMXNET3_RCD_HDR_INNER_SHIFT up front and bail out, since the
>function cannot locate the inner header it would need to parse. Also
>convert the remaining BUG_ON()s in this function to return 0
>defensively.
>
>Fixes: 45dac1d6ea04 ("vmxnet3: Changes for vmxnet3 adapter version 2 (fwd)=
")
>Signed-off-by: Harshaka Narayana <harshaka.narayana@broadcom.com>
>Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
>Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com=
>

Hi Harshaka

you signed-off-by tag should be the last one as you're the sender
also unclear what was the roles of other people mentioned here - if
they are co-developers please add appropriate tags

>---
> drivers/net/vmxnet3/vmxnet3_drv.c | 24 ++++++++++++++++++------
> 1 file changed, 18 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxne=
t3_drv.c
>index 40522afc0532..dedf4082eb6c 100644
>--- a/drivers/net/vmxnet3/vmxnet3_drv.c
>+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
>@@ -1530,7 +1530,13 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter=
, struct sk_buff *skb,
> 		struct ipv6hdr *ipv6;
> 		struct tcphdr *tcp;
> 	} hdr;
>-	BUG_ON(gdesc->rcd.tcp =3D=3D 0);
>+
>+	/* v4/v6/tcp then describe the inner header, which we can't locate. */
>+	if (le32_to_cpu(gdesc->dword[0]) & (1UL << VMXNET3_RCD_HDR_INNER_SHIFT))
>+		return 0;
>+
>+	if (gdesc->rcd.tcp =3D=3D 0)
>+		return 0;

nit: as both above return 0 they can be combined i believe

>=20
> 	maplen =3D skb_headlen(skb);
> 	if (unlikely(sizeof(struct iphdr) + sizeof(struct tcphdr) > maplen))
>@@ -1544,15 +1550,21 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapte=
r, struct sk_buff *skb,
>=20
> 	hdr.eth =3D eth_hdr(skb);
> 	if (gdesc->rcd.v4) {
>-		BUG_ON(hdr.eth->h_proto !=3D htons(ETH_P_IP) &&
>-		       hdr.veth->h_vlan_encapsulated_proto !=3D htons(ETH_P_IP));
>+		if (hdr.eth->h_proto !=3D htons(ETH_P_IP) &&
>+		    hdr.veth->h_vlan_encapsulated_proto !=3D htons(ETH_P_IP))
>+			return 0;
>+
> 		hdr.ptr +=3D hlen;
>-		BUG_ON(hdr.ipv4->protocol !=3D IPPROTO_TCP);
>+		if (hdr.ipv4->protocol !=3D IPPROTO_TCP)
>+			return 0;
>+
> 		hlen =3D hdr.ipv4->ihl << 2;
> 		hdr.ptr +=3D hdr.ipv4->ihl << 2;
> 	} else if (gdesc->rcd.v6) {
>-		BUG_ON(hdr.eth->h_proto !=3D htons(ETH_P_IPV6) &&
>-		       hdr.veth->h_vlan_encapsulated_proto !=3D htons(ETH_P_IPV6));
>+		if (hdr.eth->h_proto !=3D htons(ETH_P_IPV6) &&
>+		    hdr.veth->h_vlan_encapsulated_proto !=3D htons(ETH_P_IPV6))
>+			return 0;
>+
> 		hdr.ptr +=3D hlen;
> 		/* Use an estimated value, since we also need to handle
> 		 * TSO case.
>--=20
>2.52.0



