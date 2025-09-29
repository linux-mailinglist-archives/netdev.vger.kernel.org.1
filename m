Return-Path: <netdev+bounces-227089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98751BA81EE
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 08:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB24B189B71F
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 06:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED2D253B40;
	Mon, 29 Sep 2025 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZAhT9Bs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C56256C9E
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759127306; cv=fail; b=q9mVXIqWNAhlVRbHELsLTxqOLIJKWoA3uY42/Ag66rB1Qkj2ukWCmnW+sMob4CkWRxgeeysVUnUGdWT9OEyJpNW/nSEOl2smTktLcN6AQDo61YW3AlLOgpwraG7HctS3gsnNvtoLDNiZzF7UGgY3n4IYYITbzqPT+zBkL5nZhKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759127306; c=relaxed/simple;
	bh=cM5XB0uLLQwN5VvdEKusBkHP4HJEDTtMuCbZfr4Ta0E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ueqvfMaDZXq5sa+7kScNwpfqpGwJ+IAS3hCcWA3Mw5R4fiu6+wDHyYMP+Dmc8+tZbqnFUv5LGTn4EAzaJGyJ/m7vK4EaBE6qggRa7VzHwY7IyoO4PU9SfPVrJ6lUNwDyh8v582tlKzGLma0AzMGROSaYK5P8IV144s9z58a1C0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZAhT9Bs; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759127303; x=1790663303;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=cM5XB0uLLQwN5VvdEKusBkHP4HJEDTtMuCbZfr4Ta0E=;
  b=kZAhT9BsjzQH7WQAtUwAxJaU2OYMlAFZDH9/VcG1z5cRKwISXSuXDZgE
   3zLdHU98aTfvwGUhHR7PPapCmL3jsJQX9xmgsrw3EOAgqfcYvHmuXPxnB
   cECdCvDasvAeSBS6OOd0oyI1hZB7majZkgSOjC4bteGjyYPDamMWOJsgm
   nhXEeLyvFyRUfU5yifM5W09noslRXASlG6EiiPflJOM1CcJb7t2JHHNWz
   FmaGslhYA3tg/SlwNarFH3QEw/LlumhCUJWnhKgDVFdUB04FFXjlckTdw
   6LJCV7/jx3gZov1VUJLWiYPIYt3LOlMnqLqw90jI8u6esqsc83kzLavDU
   w==;
X-CSE-ConnectionGUID: WlzuIm46TauZdK1wqVw0Hw==
X-CSE-MsgGUID: 9Ez2kYX1TeuXFTnw09sWAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="61251567"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="61251567"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 23:28:22 -0700
X-CSE-ConnectionGUID: /JVvL+ShR52VU8MFoL12Hg==
X-CSE-MsgGUID: fICMH1XcT4mhmuuATWff7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="182140238"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 23:28:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 23:28:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 28 Sep 2025 23:28:23 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.68)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 23:28:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8RN5u0M119Xx3w5cpxNkBtXtJ//tv0CRllK6tbCMC/frLtdHO6SF/zPnmmVmpxRiryTN3hmienbI/q/9NV/IOtoof3PS5BCqiTmnNPw3YzeCNJtrXY5N73CXHSyuCIa3ljNCvLYFKGAnN44CdWco9rkxvINvtljZ6tg7iCZg3+N8txzMZJJi5cg8lic5qZI/xz6rO2S3/tgrfxsk2oq7ysCgUXAdGes8coHz025pLVT0PEWnbEmEZAWq9isYUWSToetv4mgAfJyUi0qKT10UhgQPestpD/4jfdJri+dQWU3aHA601cABS0VxlOwd4KqsLkMNaqpbO10VA7jaAkkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EfzdaKPsaCggGq3fnQrO1MMi19KYz74LjgYouPWsgs=;
 b=B+Pbi3m4gKGqPHCz0yBCRqBYJjP2y30biV1FW7VdiHFvxqVZk6ZNDTyJs+13QtWhB5sa3yI1QmQZkgi6RHGbqr0MzaAqx/p0lVNHqaHnBlNF/gIGBwZIdMrUu/F8A51n4j5UANjSKvhf9TEWBNilM+u9nUqk5kVuCIK4JDZ9FfYslkC0gqAymXQZ+Roivc18ySfurwrAd28klSwprtZ/RLA8KXfSpoGyQ7kIpMQViqfjONCo/QJiIQQ4HFJKOcqMxuRkiIVu9pyaXAtDfLaY+4BfuSYiRwIbi26y+YGtHm4djbpvHR+nYWUqjyE4gLQBbFmvtL94jbi0ptgvmWe0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB8384.namprd11.prod.outlook.com (2603:10b6:610:176::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 29 Sep
 2025 06:28:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9137.018; Mon, 29 Sep 2025
 06:28:20 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "Singh, Krishneil K"
	<krishneil.k.singh@intel.com>, "alan.brady@intel.com" <alan.brady@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net] idpf: fix mismatched free function
 for dma_alloc_coherent
Thread-Topic: [Intel-wired-lan] [PATCH net] idpf: fix mismatched free function
 for dma_alloc_coherent
Thread-Index: AQHcLkad8vDkx9SiDkOx1dMjN5Xeg7Spt9oQ
Date: Mon, 29 Sep 2025 06:28:20 +0000
Message-ID: <IA3PR11MB89861412BAEF2275D26AA95DE51BA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250925180212.415093-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250925180212.415093-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB8384:EE_
x-ms-office365-filtering-correlation-id: bcd0db0f-75e6-4875-39f6-08ddff21624f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?xyjHcf7jajbBKKxJDq+Pm1vwFgyPElDdsp4jdXacjt7iIqJIBEK4IecGUQ8b?=
 =?us-ascii?Q?YUvx1jtPpISza5mcW7eUHM0XP3xmVdLXv9qugvCTRH3w7pFQ5JFzYHVVWlVx?=
 =?us-ascii?Q?NAmXUTikTAWWKKCL/XrroqNiYcEEqgwk20KIBQbxijNQGYS/TbW83/4g/g1a?=
 =?us-ascii?Q?mRyQZsGd5yPG5em0oVA6EYktPbnegXrK+5Kda2Qj7788ir0HxxxC1228Rzui?=
 =?us-ascii?Q?Kft7ZuwU3qkU7fu2gQOBd0gp3Jk4R6TKsEEGwE6nT70lSN6hYQJazmdLqNaV?=
 =?us-ascii?Q?AG5dPrM/iHkeVkXQi5e1aomK099lECaNTARlYOdN/xbt707r0HmZA4P4rxGt?=
 =?us-ascii?Q?2+hCcutd60SpI6Bo0kwQew0syZQBHT9i3N+LmlH722+3HbLITL4M8twN6wOA?=
 =?us-ascii?Q?cONnkAPnDueR+gU3IK1U4EcpbbhJhAjeLcR6HsmNumcbHYe7XwQpdCoNQfNW?=
 =?us-ascii?Q?OB2cR9/kHb+QbWvqKuy/F1nwYzRuRVyLwzYIsgObjVpRl1Ky4gETHlrKkx2J?=
 =?us-ascii?Q?NL80ayJg0KUdQIxVhadwG48Co4jFSZoY7YoGlltmLYPulN9AAv4/MUN6NO8A?=
 =?us-ascii?Q?v1MmQr+dWrMRHGMnXGkJNDA3H1IXUiSb5RNo26OWRRUjJ5Xy5u8dc648BTIF?=
 =?us-ascii?Q?wgdbvmRrDxlq44fGginLmrVG24bKxL9yP97ejcBcLnOPrD2XfPsTDwQA/jo8?=
 =?us-ascii?Q?IC71aRU4LToX1OaPyeDa4InCkR9Gbyvv5I2nab+EOOn1QaZilElmFIbrORsQ?=
 =?us-ascii?Q?ITDhydRgA6Z4yxLmWt9ubRzU5PXRljFum5pD3QVj8bL59NRdxbiVmGamPOpv?=
 =?us-ascii?Q?kzfBSi2OC47zgphwipGaFafk0eXvm7GzVlJj57FQYrJNphhCiu7P9T/QyZhU?=
 =?us-ascii?Q?gknN42IZEA9107JQdTwQWBQxz/TDP6/AqgLoXBzhsxDOFhVFRhZ3YWEnbvUN?=
 =?us-ascii?Q?TMusH0yEB2yUlH5HtP+1v8gcgDX9jP0SnbVWOK3+u+6Tx248jpxn/EfsQVDw?=
 =?us-ascii?Q?h6UJ7yUcKIIFsNYGL39yalCULaYgyIRucI/mpA5drQc+VyPOJwNRyNm9c9z/?=
 =?us-ascii?Q?N88NjK7CN6WUNFRJgi+9ek11xzhc72LKqKp5UB3sQlA4mOlDpE3wZQ4sCrAS?=
 =?us-ascii?Q?Mq1RlJrFgZw2ZGLIuEroJzp/ElS3xvMCZ27raPCxWex9aR14sQZJo4Tj5PrL?=
 =?us-ascii?Q?9+vtzeTtxzZlZSLZAy/6soSwebnS8GY6Rz2I3ZdIkq8OFL4PkyVXeunaj0eh?=
 =?us-ascii?Q?GFK6EusSviVW3J3dLph6jWfiuBn/ppFpN2LAyxPjwESg2+l3TkUxVbqlrtIN?=
 =?us-ascii?Q?RjfI5ibZ2I81HwnDDow1gxOu4ImoA4jV1Q3NAisBrxjmXFWE889f51a/2VfE?=
 =?us-ascii?Q?qu/vAMmLvm9vnJSMV1RorC6U+1pgg2MZkVbgB+/y2DmUIAfaPRQthVQxZ2go?=
 =?us-ascii?Q?tZatbEG8R1ONKNmuOlKxqcwgqAQJU2oZxEq9gPJRHY2E/peqE0BJpHp6TvNX?=
 =?us-ascii?Q?THn3A5g5AgCBqDpb+kxrhx5QB3pZ5hX6vnTi5uL6rUIUsgxCgM4RVrTZwA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cAoDx9hogLBXGgHT8SL49mglu7b633ezi3AbEXXczbgz5C2sR41nMfTg16it?=
 =?us-ascii?Q?FYaePIfwU8cMpRdbDhUEnz7YvPp5hztar0CCjetr37soXJI3Y1VxGkAw6CFd?=
 =?us-ascii?Q?63xTdGmhNQm7QNEXakh/Zm3UPI+e8yxFMPtF7++qNLtE+YaXxIs2CHNL4Wb5?=
 =?us-ascii?Q?0KW+ecdMoPN0VXL6YKOo6eH3zapdVhVfOgxnyBp4tUBTb7ZoySKSUf0mqoYl?=
 =?us-ascii?Q?89hmkqwv7M03M1KuuTWmTTYRLdkzGdMVAEByzh/IKjVIsH5zpjzFKz51JqWW?=
 =?us-ascii?Q?GxMdcq1ours+x0Hxgocf8clIwjM0OtwQJZroxgyJycUbWVQ778cfBHrPvEnZ?=
 =?us-ascii?Q?hpwVocttX6RZPfBYPtL1ohXe23RX0p1xcTqC4lxFZYk7DzYTIMHtjGXOoG3y?=
 =?us-ascii?Q?P333Zp8psuqvG/QcgGndBDqox/IHrujPdk0d8McH21nemW9lMUiW0wAF26jb?=
 =?us-ascii?Q?PN1Pso5N+s5OIRnPbWXx/v7FCE97nNSfxvcEHiiOyHo+bulHY7ciywQ4ugCy?=
 =?us-ascii?Q?OoU1ZRbKhdIf96lg/MtNyo9WcgV+HqRwl/Hon43n4FBr5uDoZlx3MLgFYdA/?=
 =?us-ascii?Q?GCe+O5d1jYTHBbOm4VeYASpG8A3WPcoIIx/t804NOzjUJz4bmVP/p5+6EFbU?=
 =?us-ascii?Q?LJbW/+bAh0vjqO/qPDllTeiuW7gkR72oGpgKDPyE0XTXhX+vsZMAm1rKUjZF?=
 =?us-ascii?Q?sflKd6LkwPuiMVnP6ADH+QM3m6VnyFfeQQmuCutg7qtEqppxj46lLIJOlI4V?=
 =?us-ascii?Q?5pOQxSXRph3ELH16gTkh5j7vPVdilK8HeaO8SMDOZw/S2E4QR2H41nTBkUqH?=
 =?us-ascii?Q?oOy8NjPZgmiucHCoWFhXOy15PIKQW0GdFQoLYl/z688vs83BLrTAQYvp3ocA?=
 =?us-ascii?Q?KPLExplnT4Z4w0kdjBB2BFlC8H6HeQ1OGcA8Yjr6lXZK/mqVhvuLWWm0ntx0?=
 =?us-ascii?Q?oJArQw/9mnCtIrmzSKWTVVvNbNd0tmFj7POnOImffjnveFHWXVjifrm2WONq?=
 =?us-ascii?Q?fFbRsGAsNUWk0UOVkFj2EhpLavN6ZHFpd+XF/7N/wRH8tqk5SM/W4fZ1a9ds?=
 =?us-ascii?Q?IhG/ZvPJh+Wh5efNkz4P/QC8uT8ckzs9lRHblgaBcxSNinW8HuZh1MOLnX94?=
 =?us-ascii?Q?1Yk0c/4gFcGNoi4loKsH/Uf2DtaPeglawSa4YK7+dWa0n/cNfeb4MDc5JR3z?=
 =?us-ascii?Q?5kyV5Rmj0Mg6o3eGCSEOJFGO2c9XvJMtx+adtloFsUQKx9rDkynIinas753+?=
 =?us-ascii?Q?o+fD2ncagkWDODuwp02Q/2qTGWTHJX7ANs0jwyaCUOuu4V8WLFhA/rLYCXa/?=
 =?us-ascii?Q?wmLHIJo8KGByqFRiuDu0RKdpnfglTrrDpPjUyw08LJXyQKHMTap5YIpD6BS1?=
 =?us-ascii?Q?1LcIDHfl1ZJfDy43ubjdI729E1ZE7J/iAYwEBokq8Dw3o/Cz7psStwZiLRGj?=
 =?us-ascii?Q?+ZO97VjzSLCwMO13qGRmyjanV2uBqVdOFb+/iqNDHCB5AUBM6G8amtfIFuYO?=
 =?us-ascii?Q?dq8J6M4iMzUEH2glskMPSGj6G25zJ4F2lL5FEPn4dSLV7aptlazDeaw7rjCB?=
 =?us-ascii?Q?/m7uxNdapN5vmgC48EpivnhmfTdictPMTjorqKYZOqJLQGUZmXxXWBrHfoyD?=
 =?us-ascii?Q?Aw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd0db0f-75e6-4875-39f6-08ddff21624f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 06:28:20.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEESMtkrakkexqT6+njP3U9y6E74lYiTlezhbQRNnrcCooKR6z3Ofb+5i9aUjQRzc9EAOJFz1t0PeQ7jEnJ4snVzn8nvS3HJ7diMZl8ZE9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8384
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alok Tiwari
> Sent: Thursday, September 25, 2025 8:02 PM
> To: Singh, Krishneil K <krishneil.k.singh@intel.com>;
> alan.brady@intel.com; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; andrew+netdev@lunn.ch; Nguyen, Anthony
> L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> horms@kernel.org; netdev@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org
> Cc: alok.a.tiwari@oracle.com
> Subject: [Intel-wired-lan] [PATCH net] idpf: fix mismatched free
> function for dma_alloc_coherent
>=20
> The mailbox receive path allocates coherent DMA memory with
> dma_alloc_coherent(), but frees it with dmam_free_coherent().
> This is incorrect since dmam_free_coherent() is only valid for buffers
> allocated with dmam_alloc_coherent().
>=20
> Fix the mismatch by using dma_free_coherent() instead of
> dmam_free_coherent
>=20
> Fixes: e54232da1238 ("idpf: refactor idpf_recv_mb_msg")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 6330d4a0ae07..c1f34381333d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -702,9 +702,9 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter)
>  		/* If post failed clear the only buffer we supplied */
>  		if (post_err) {
>  			if (dma_mem)
> -				dmam_free_coherent(&adapter->pdev->dev,
> -						   dma_mem->size, dma_mem-
> >va,
> -						   dma_mem->pa);
> +				dma_free_coherent(&adapter->pdev->dev,
> +						  dma_mem->size, dma_mem->va,
> +						  dma_mem->pa);
>  			break;
>  		}
>=20
> --
> 2.50.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

