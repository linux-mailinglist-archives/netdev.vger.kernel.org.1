Return-Path: <netdev+bounces-267418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC2eLQn1s2nYdgAAu9opvQ
	(envelope-from <netdev+bounces-267418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:29:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1912328239C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A8E4301F31B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3138944C;
	Fri, 13 Mar 2026 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zm/XdTk1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69E387355
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401317; cv=fail; b=F3YNIKil0gRn9sYRwDyR4V/SNnMTPwg/9LU8pKiF6lBB0j+3COr26OaBOAVjmpvqSa42WgFSNLLGMaQyPsJ2YBvsIWhOJ/dlpVP1TI8Jlxchmedk1sQDhVKPFBXvfiCUhnd/25lRim7wNJ1hV3W6CTDF1udBXgAWWIv3KX//4RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401317; c=relaxed/simple;
	bh=bvpIu25LBiMss+hgD3M62gbe9LiakN3OU3LnMEsBq0Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fP8mhzJWXznXc6gmT89orzzdWVjC35sG3u7f4lGjPkI/Oc4adLj8gGkSrvB8eiWScobt6ET6gamys2THXOF4wqnZGBspe58tuAGs9OtrXeXY0VRyF+2rSb6/Pczq96zJLH0S45Lb8YIOQ/UzbTJK10azqHWnhotpOPWSA7R1LJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zm/XdTk1; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773401316; x=1804937316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bvpIu25LBiMss+hgD3M62gbe9LiakN3OU3LnMEsBq0Y=;
  b=Zm/XdTk1phQBiRgckmqvWh82EgCmPmGYva6qu0wBs09CQ+QJ9+T1pZnt
   g8sA+/MoZjJw2FWMh1u4Za1opwfoE6hQCmXXItMSfDjVO+N0YN1hAt0S2
   6k/OEL6q8Uv9X+BsGQTCCsW1v2DVgfLCVcUYaY3ctpQEJy3W/tQmFMt7r
   16TNuSLoVX5lkKsBbvgTVrqkOyRZZx9Xhxz8FmzwI420ylLqJDveo6udj
   Lv2r3rQY5kIfgqOVkW8SCRG3vWsXiQZ0NW6LVvR9mO6EntJ7d3Enfzx34
   4uyGnNwNBzQyMoYfKghfRRycnMPcE5CzLnr1K0cDnTbHSIQbkO8JgCltQ
   A==;
X-CSE-ConnectionGUID: uNZVmvADT1WJ6Srum816yA==
X-CSE-MsgGUID: 2Ul+wjPeSS2AV7IAHnjfFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78397614"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="78397614"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 04:28:35 -0700
X-CSE-ConnectionGUID: H2ZCH0UqQ+iAdod9QKG1PA==
X-CSE-MsgGUID: knbbFvjoSKaZvJLX3KIviw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="251654436"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 04:28:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 04:28:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 04:28:34 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 04:28:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzLBI7ysA6ahOEpJNcyEbOuyUONA38ZJ9xF4Sy8NzNxVxs4+XU7XxvYeKV5bVWHLlcb9m03/kpQiKmrKOdG5Kp6UzxORphck9KuCsWgkZG/wMxa+fZAR8NwGqWFitoqoncglPKDQ+XbvtRNK+3w+8i12ljSQigdJcxH6iX3NyxcBwClGiGvAE+i+slqLhvW/Z9hkX1y95Bbuh7BGWV0Oivk66fJmTUd81cRMJVLJGkvDDEyzcsxuDOF3x33JF2T4zn1tn/oYV1VJQKTa34tHpYQM3As7ECo11Ms/zTyAuX+ZtjR+671lHhJQL1nZpAvEnCLz6pIm/6tIiWVLCVOhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLKqpI76kPuzNfIAVG3L2PiJ+rwdpGI0swPBYtqMDNM=;
 b=CkcF7ksGD7Ahdwa4cV3AKrNW/RAj7P6PWQ7hr8wjN9AkeHuvuTd8G8ifoCdIoYwBWW0v8SjD3Wb7i3z60QytwvYAdJVtwSjpky8o/3IyNaJehYJMpeO2m/r4Ht49N+4mykN64Ia8icONENuT34Xf7JpcaWxgqdWJkH9FFAF+8kbGqY3VVRDiPkSj/qNaV1aB1O1D3B3ggLfk7B9QbuiTgqrfZ+PreBHeXCedOMwFjdHLzpRtGR8Yczl8C+l24R1WT3LvhQtczpXDmHc0w5cZ44SYswBQgGr/v9NDggKjKypINMBy/ZtOxPGPDnCyh72aolpxuK2ihIlNM80Py82pEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6449.namprd11.prod.outlook.com (2603:10b6:510:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Fri, 13 Mar
 2026 11:28:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 11:28:29 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
Subject: RE: [PATCH iwl-next v4 1/2] ethtool: treat RXH_GTP_TEID as
 intrinsically symmetric
Thread-Topic: [PATCH iwl-next v4 1/2] ethtool: treat RXH_GTP_TEID as
 intrinsically symmetric
Thread-Index: AQHcsgL5WeTVzSCjfkSLA4GrUYOeK7Wq+NyAgAFba3A=
Date: Fri, 13 Mar 2026 11:28:29 +0000
Message-ID: <IA3PR11MB8986CA12EE22E9C07BCE7E83E545A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260312093101.1589970-1-aleksandr.loktionov@intel.com>
	<20260312093101.1589970-2-aleksandr.loktionov@intel.com>
 <20260312074225.27a4a7b3@kernel.org>
In-Reply-To: <20260312074225.27a4a7b3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6449:EE_
x-ms-office365-filtering-correlation-id: 485c0acd-86a6-4aa1-8c40-08de80f3a6c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: JxEWHJt6UgruOQdDLhU9R3jRDIH2+9aJa0csQwosUY/v0QPUylQUfbksQ7OGALGHSgCmygsD4Hz+HbjbrKn/9YUbaDvNkMA1q5Cks+f9hfh6voVldNnEm3zV67ePlzJXRdyZRifit4WdovkyeEDg4RLSXoQ/fshVVuvQEHSIZkvIU2NeYqTJFMAWKYLG6k7VDyvFmLsCpTrwbErLADOcTrbepgTj3NUp5XgYn59hAriB8gudKHXfjGb6f4MKNJVep71m0jNok3Bpi/g8axF1FNv4ULaYS+mltJT24CPCgoTTJ3twzsKhYIg1qrooVv1tBCxwxd4ycAIN8r4E+akJZRBl4iZMa+QRKwNvQK7HF726raHn1iI+2Zg++GF5MqFTkTTJvYnaT1VEOASb9QiLdJVpL8ho2YozRnIa6CnJ8GHNSUtAhvXfXAGcz7MpykZOT9P2Vj/dF58avgfzTztfCOE6N9L2aw0zSMnrj3Q+ESbyMAR0+a9EoUViPqxZElDJV4YtG8ZKiAY8KAfJiNh3/xnp5BsKaFGhDqoGuG8vc6tHbrq4Yisr+3yKy84ZnBPj+psWo8XMyjjd/sGc2iEYUhTGKKcTap2a35B0y8PgRIByLZBaWcn61Ldw/bvgqggOdapfbDnHxphLAWFXSJyrBbzdx824+Q/hmwA6sUTdsbsRPa8XcgD6ty4z8y9H3P0R3IP3UmMf9kmPsw/rsGtG08g2I3VLSPMIA+nYpnJqNo5OQqWZbDjd7yvJX941LzJHqYMqFQrPeluiUhpnMePeMBQkBcKfgjVYVWcpiAWW/VQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cxV5dv8etY4Khq9n6JYLFb+mjwg/mSZtz6zEfcuogqzlTUM6rpe71KvXaiDM?=
 =?us-ascii?Q?BmJ954mPFt2zNwaVSGh1wJsIG5Ic1KElrHNV0i3ieKCgFZnM3r32FRlIGITQ?=
 =?us-ascii?Q?ff4IIhbF6a/8Fa0V87w4QddKzfj9G4Ao0Z+kQd8EhKXyTPwPg2albfXXB7Zf?=
 =?us-ascii?Q?58SNXeydpDhiRViono6GosWQrPXqPcN7lcgWgFV2TnUfxR8m7G/AXbDWE67T?=
 =?us-ascii?Q?MO/WeQ0XyE+bGs5N37HxxgbtSLGeUr9/zidxIqoPaothh1bduZAs+9Y5OA3x?=
 =?us-ascii?Q?BvYFk3GWCUwLuFKdy4IgZP9ksBJdualoZTm7aEszFgp8BKuzUkjMCXDyf3Pj?=
 =?us-ascii?Q?RJfKkrqFZi3JTFiJIo+nRXvgSV/u+IlE/MKdGGyOz3hpC8yqfqSbrhCkKd0E?=
 =?us-ascii?Q?Bye/Qks5zLAYQwC7wZL2E7Tgv9zjg8tVWUMZwd1fXQjhI52zA5zzW/DpjRKH?=
 =?us-ascii?Q?dUphgg9iTR4XSMvd8y7nSzJqcB2hyDoIRbakah81ODhyTow1G/5J5qT8HhCk?=
 =?us-ascii?Q?zVLBZHCLhaQeWjhjre17SbsQf3t7cWd8S6ClVTtFHTlfWxm3naJhs2frRQoE?=
 =?us-ascii?Q?XQZhXPmKOWXyaCX/+1ZODmd3P2nRMii+3pEMLHkDNsRkA9EGD3UfVsItzE5y?=
 =?us-ascii?Q?w8uXudvsOzjHBJ6N2Uh6jDU5i4k66hgjPkWTKFZWYrAXHjBEaYYsWqREbbU8?=
 =?us-ascii?Q?uBwETnKeFSkDOKCPPhtWzfzCrIVPbNAADwyjLWXE8HjPI/tlWyZyyVgxquQV?=
 =?us-ascii?Q?nq8KqxZ71AcwWmLj1jpo828J2v4B5blG6nYXf34cRU5O/An0BcOC+vnfwcRn?=
 =?us-ascii?Q?6lN6KmM7iOGcOtYgpGMH0WVPOWp63yEnXXnuilYsEsXb9IXjAS+DsxDykV6F?=
 =?us-ascii?Q?+TYvjwVRmY7BQLnt3eyzPrRp5u2j3djRzGmE0/XHwagjkENtfcBj2dkxma4Q?=
 =?us-ascii?Q?7d4CLCSycuH/YfYpiETZfm4nYxRvYOaIp/qZrTcpkg39A5+2syhIO2bfPlX/?=
 =?us-ascii?Q?6nhFSzhmVzoe0OQ935EXoLOZCGJqliI8HbZZB8ZY7D3iivpu6boHINfvTLn+?=
 =?us-ascii?Q?n3r3KTJxFyqWdBuQmRwD/RLObch+uwPupZLYyGOxvJX/RjQXpcmCez3TWpAk?=
 =?us-ascii?Q?Q1A5MwH7CpSVmPm7RSBJ8dRhYXs4Fu8S5jhfeE5F7ms7AnwLbl4voRHmj9l6?=
 =?us-ascii?Q?UZZra01RaEpcgpYl0ZzqX4MA2gLL61ICJLQ+OyfNmv2yqErXWOs8Z63/rpnq?=
 =?us-ascii?Q?4b6Xq4jFPPsj3yGWLjsYvTCVt29LVJHvPBZI6nfrqJD0ZdOUHrAxecLfZQGw?=
 =?us-ascii?Q?KPgAaG0HF4BvEHs7TTCgpsjEJwHa/R9ciVLYz4NDBkYlCeI6ClJiNX4Gry6j?=
 =?us-ascii?Q?ajiPDJ/De7O0UBbkNmiNSiBPWtwoOxhbbEV0pwiofPMP+DfMDU9LwpsSo3Aq?=
 =?us-ascii?Q?vrNnJc4JDzRjfZ/+Yvxb3rvqlk9wHnNgzFloDVtWFn7tjsTkdFSsEk30iYcJ?=
 =?us-ascii?Q?nIncvA/dE3Xu5I6Y8mLM7gWEmSr7HuIrXEC3vskXOi5x81lSI6+6lI94syjF?=
 =?us-ascii?Q?VhWwhjwULOPhfscMISMRXlTP4CWu/FLSAsAe4kfaRI4QPWHjntlIvZQP8okh?=
 =?us-ascii?Q?TrzCJeQX+3ETDKZp+PbQNEOsVckHrz+A/ms6EMWmoIaBwhFmO6Pe5k7NJ9RV?=
 =?us-ascii?Q?EWnsCd1m512SUMh0cDLxnSe5bAb1TYfs4FWhwv4+Kibi1G6dOo4O1x4AXUb8?=
 =?us-ascii?Q?js5i1Ha4HwmoHVlp2rOUtmVzRXp3Y9Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cbCpykp6UwBgcIQFIGymreM3d7ojxK23AteL8umw8dxpDi1KwISM3RZq4nN4pjlhL7aVH5i6/5Hg9AyItR8IBzQlixnM54YwK2oVK7qrTxBTHKL/rZHQbwCMF2ktlECvwtfsQiFX78aqW/4oZaEitYGNTpk0ulKES7pfP9RBCdxQUfZkn7RHEgorqR94YkEprp+tmhkBmLvwpwxaE1LG+SIgZnnuJNgVTzI27b1CtNPIha46w+xbQESmBuLEc/aFmnqmi4VGX0qRdBgfRq8xFYcaGmS1RXFpGhNrc/s+X7Evm08P0LNVvLynSYYeQfJFjAQRJipCmUCUlev+308zRg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485c0acd-86a6-4aa1-8c40-08de80f3a6c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 11:28:29.6254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEGFOV7KgAX67oinsIBFmpZaVFv1sfMrJppG/PBDn/C9Uw1r5QmVK2L8B4eh99jP7wPK4LBkpN5Fe4yr3oL2oaIqSu+pHoy/LwE/gTre+nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6449
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267418-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 1912328239C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, March 12, 2026 3:42 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>
> Subject: Re: [PATCH iwl-next v4 1/2] ethtool: treat RXH_GTP_TEID as
> intrinsically symmetric
>=20
> On Thu, 12 Mar 2026 10:31:00 +0100 Aleksandr Loktionov wrote:
> > +	/* Strip TEID before checking - it carries no src/dst asymmetry
> */
> > +	rxfh &=3D ~(u64)RXH_GTP_TEID;
>=20
> No need for the u64 cast.

But without (u64) it will work only while it defined as implicit int
#define 	RXH_GTP_TEID	(1 << 8)

When it will be defined as BIT(8) or unsigned int it will break.
What you'd recommend preventing such issues in the future?

Thank you
Alex

