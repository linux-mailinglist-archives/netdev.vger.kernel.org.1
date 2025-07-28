Return-Path: <netdev+bounces-210449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE46B1360B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 10:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85783B801A
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F2321C9E1;
	Mon, 28 Jul 2025 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9ltkTmU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9B21CC68
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689984; cv=fail; b=GnvIeKXk3rW8fGHFRi1V0giBxW5lUQJfQOYhjQKHZa1RjmQgASWTJisIx3h9+GmEs4rq3u9Gxvx7VKAdxz9IVED9+oNSQfHBf3eBqAjQ1R9KP9v8ks2Ki/wM0fskjoLzAx+TbxoniPCgKAGr0WRbrpRDa1YpNjUWUYCBl9gp4jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689984; c=relaxed/simple;
	bh=zzgC1x+lt+02IcOf1VCl/RKz9iRpqGUc4Eddea809p8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nIfCCJ6WN4OC02geLPJvzYjUNUgH2xw5ZjfqEqxGR4OT2ze3HE+4BPITHR26gqD0eTMIONP0nJ9eqVj+Xcd7JhVVo7zCnQu7rbF6pyx/O7i7gi0qFZs7mT4RVs/fk8Tv456jlJexUKONnNC95Cf8d3HmvRKM66VPtRsjeW+LwhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9ltkTmU; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753689982; x=1785225982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zzgC1x+lt+02IcOf1VCl/RKz9iRpqGUc4Eddea809p8=;
  b=G9ltkTmUDDWofuiKdju6/KU2vcidEz9UVoK0VACN1Qa7HoH2FGfvD2x8
   ivS+SYXinkq4CYc8H+bl6E0N55aDQbMWtI5aonpHB2bNoX9/clZds1emU
   rrt3etRq1u4UVNMttGOK+Z7iTLPwWSvHkpQ9Eapt4nXhpCtXr0dYL3vHm
   HesuMW7CZJ05VyfBPMhi+ylbZ/dxNZEySFwApM2qphepWkRsez07n8E62
   P97kwWgJjTMon4hIkAO4v9PKRoAHX+jAOSM4dinDMVhxiLW4MIjeidJ1/
   G/+gLXF+0V9PnaGYgY73oSUqA4ZB93S9KpTKllauGrs1JZvEB5mzFoULf
   g==;
X-CSE-ConnectionGUID: sdFfr1wtRgWMIuSj29tjQQ==
X-CSE-MsgGUID: DPog6T5rQ7mVUMJ9MkvhnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55629902"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55629902"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 01:06:22 -0700
X-CSE-ConnectionGUID: Nm0vAeH9SzimU8QNhlpr8Q==
X-CSE-MsgGUID: jvFEAnRyQuC0J9JH/YnO6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166826802"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 01:06:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 01:06:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 01:06:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.55)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 01:06:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDQGrZvZN/Qhx8TcGxgLeZa9Rlum3iwdy+8tom/MIzBH97s3rHn0WNEUeXEgv1fTzdCMn2on3P9UiUAIa37rsLRN0Z1YUt3R8K0MClFTt/HWixoNex8Qg+WA9ril/8VnW7heFZDAWN8opTXdXcpijMwhNQeem5mIgnEhcleLBb1Y281W/VppAs6HSYpLsZppeZwnWXGbtw5uQ/YBbOcQ2eB5Ou0z1INM/ABOvMYsgVNaWqETm/OdP/bkJxr3EwReETQuL6XWnadNDSgbv5VkeFmgrn03qUbnuB2aeF9hLJ4naGSaPXtaf2kBJGcdlQw6wQZKBwXKjjoMNh06LZfv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmOpnNSUkHt0ijQ2g2SlwhRpbxh1Uc5B1f3XwbaSyX8=;
 b=V/Uosqy2JuDASR0ebJDtExledcRruSorr8F1h9YY08pJ3ywmXnOVrMAfMGtVa3EnpEBaGY/cXYQht1kehQfPAYGuqZVYZ8781oaZcH0nbdw1YIMT3yMMew8ttrytKCe3C/cQ/MCeNsKo3x2czp8jXTfCqMU3X+CdlGq59mH//KlOoZik8NDsFoMaaBkYLsXyBTSwCqvpVtP76Cg73dxYyv+m/2IJVr1abhAPGyUf/vlyhXWyPHGn/qa2jSDNVOG9WompYwJ2zx4LiNJsbyl5qUQOcgg6gp2beGy28gIHMlhANVNvGSBR4k41ijjNegsttamgwgkvcUFPtycevm3NLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ2PR11MB8348.namprd11.prod.outlook.com (2603:10b6:a03:53a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 08:06:16 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.8964.021; Mon, 28 Jul 2025
 08:06:15 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"bjorn@kernel.org" <bjorn@kernel.org>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-net] ixgbe: xsk: resolve the
 negative overflow of budget in ixgbe_xmit_zc
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-net] ixgbe: xsk: resolve the
 negative overflow of budget in ixgbe_xmit_zc
Thread-Index: AQHb/fuCBiqluTzdckm56c/1a7PH3LRHMOMw
Date: Mon, 28 Jul 2025 08:06:15 +0000
Message-ID: <IA3PR11MB89865D26E0D34111782E9BC8E55AA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250726070356.58183-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250726070356.58183-1-kerneljasonxing@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ2PR11MB8348:EE_
x-ms-office365-filtering-correlation-id: dbad4d68-aafd-4272-0f77-08ddcdada00d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?a1o3ROt7Xxq7Om8s5eTb+JwadnHCd5VrlrTHjxR70zM6+NPZPjAJbRWEWVT6?=
 =?us-ascii?Q?pwlJZL4aluXjFwqzoE0BkcwpdWcy3SYgdUlHHf8R2M+DaGLstwSdyDS3BlFN?=
 =?us-ascii?Q?62PhpgRLsAvk+fVTqZ698EEIC/lzBdlViaNvGkG9ObcL2asWzWjLe/UzNmI0?=
 =?us-ascii?Q?N/FUCvHFemuvheI0yFQPrTpmA38ZbverlJJGdawXrCwPgbgM/pUh1Q6lfN/N?=
 =?us-ascii?Q?ND7MlAbNx9qFJUl33gtfAVxbwDbjKHIHGkWg6B3EsjHcFa9LgaDewuflg5Ud?=
 =?us-ascii?Q?72mvgCtT2fBg3s+3UvPQOXCtJ4FRYtjK8XPiWJX3kJj+y1f77R9reCAzBZNQ?=
 =?us-ascii?Q?zq8XG+LldJWHjUIcN6m2q9TqnnCARap3bLlCUchX/4VKkaA4AdtIi4pr3oTW?=
 =?us-ascii?Q?84W7I7+NOYnJukj2BsbDhbInwvrIPxDohMdqPW/vb3/6DPLowHtjee3bptRh?=
 =?us-ascii?Q?qAcuukOXLK2pmHLMcT4BwCGYODhWYvCpnbquhB5c3m315NW5YUIcNHnlpOQf?=
 =?us-ascii?Q?xxtMqoeC9Njc+8KqVL3HRNEebOsNYjZLVbLXmXOba5NxEOSL73Nxpw70/yN+?=
 =?us-ascii?Q?CmfKZNwNI19OUPyLGPP27GBB0WCBg0BBQwenamfxfT3aa8q1Dn4IZT2wqmZP?=
 =?us-ascii?Q?sCjY/BHQgpQcY05riMBEX+DgaNOAziKQ2lsZ/S9W5ODu3XEpMJezKBkjh4Er?=
 =?us-ascii?Q?E99AccajStnK3VJqkgo2qSgiOQD6fquNYmgGSn8/d+OjcLK4A0Supn9baOMk?=
 =?us-ascii?Q?mzbycJkQY5rqBppKRYy3vvN5bavATMv4qctkaJBX0hOvlCjMw53TzFwdQaCJ?=
 =?us-ascii?Q?ZcetrV4OuFlHab6SMuuy6cSHwvLj5eqUnb0kNyygSKVI2FcRv0Twla+86MnZ?=
 =?us-ascii?Q?jTmRco/NsdAc2GrIGGFdjlYztAeM/cE06Er033QMy8jUsi1L/hdAnMqtjGpY?=
 =?us-ascii?Q?aItq+RKP5lral2o1DeBHxTNK1nnLZkZgHRk0jSrFPGk+QDrK6WFprBQueAAo?=
 =?us-ascii?Q?hIMTpbH5JCP+7K7/2Oz0XkW41LYqhqIJgHYyC5j1mJncIg6d/LejfwKGB8lq?=
 =?us-ascii?Q?S1E+zlKgBtJgJTzA8eqOX4XZMQ8aXIEdKQfnl5QIZGwpBlYMXqwMitLjKjTv?=
 =?us-ascii?Q?2KCtdQbHBYGGGFysi5/ZxVmrha131Vffx+UP/X077gCfWbeTlVJtcqImm17Y?=
 =?us-ascii?Q?J2q1x06CiJQh/y0HNQ71ktJ3WcK23FaG4JdEw9OWMIAg/zIOYy6DRhzhYo8j?=
 =?us-ascii?Q?w9johRC8BYYtvS3PcNdVHTsS1TfYoLRi6mId2ynl2Oh1+zcQwY/gQez2rax8?=
 =?us-ascii?Q?SFD3PblJ19BEMhV0K+ZoauWCe0m70QA3Q8N3e+T6mDAo91k+C8WnAb5B+wkw?=
 =?us-ascii?Q?gMin+YcayhzmwoHVrC4ilkhyouk5ZcJPKFArrHF8L42VkGUkIOmYpxVvI8v8?=
 =?us-ascii?Q?MllO3lkPA1I5snhq3vYoEI5cleKaCagkZuASVdclDIEwCbi2O7K4mk+SSRR5?=
 =?us-ascii?Q?iHRy1AvrLIcqIj5WZqUPi1D1Tp98Sy7kUNE6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4C90IN1DfaxAbKJpyrt7EqqSA9uo6DRg1/5hnKuxI/keX16q5k7YIZQR15f9?=
 =?us-ascii?Q?NeJLoznNBIg04kHI3R4t3hBvDn9Z+1AC8o+aEC0TNL7WmVWv9cqko/5QOXEY?=
 =?us-ascii?Q?OmmN0AWcArCRT7l3Q31SBC07cmCaDKsqweCzG90kQ66QvzMPL9jQJSzeJHvr?=
 =?us-ascii?Q?OwfoxuXJj7WS25sXeOszrfaBkByO0ZQtoDXiAuMD0ruRXUctd/rz9X9CzfC6?=
 =?us-ascii?Q?TmK88R5UvHb8yQ7me+5dSjlp8p+7UOPOz+nCYp0ahn0/WEwymeTGjJinRju+?=
 =?us-ascii?Q?fS1ZRUJJ11MzVN+TqRtK0l1nl5d4zDsAcbEZOn/K0OHkL8HPnHtZ107h+EdE?=
 =?us-ascii?Q?ws05sicVVqqkR5MPuoUeKteVWMkZ8JXp2J3w0Fh6haxp5KbKBSZP2K2s4GpJ?=
 =?us-ascii?Q?UkCZ98AmObRw/09G1cenj+fSFxZD/AMlN7vCyoWdY07GT5sI6jhZXeBZTw+J?=
 =?us-ascii?Q?VKAQhnJDAhll6yjxOGjzNKuYqPB3Bdof1QC32iWPz0OsT1+QUuZIXxBeeOL+?=
 =?us-ascii?Q?x7TxNkNAc+i6cVnQQK2Px0x1ZEf6grU42EYBrS3gETuKz5ro9q1qaL67maxv?=
 =?us-ascii?Q?XixzkgqUvBdCnVtF21Q+xoC7A+8xRh1rnCbdreJUCQXyFVppImZC0EUhGSFW?=
 =?us-ascii?Q?OTNYuSMXfvcHmF5v+8j2n+smLqbg5cuw/6wDyDDJJW7knZJRw51Ub2IHo7Tc?=
 =?us-ascii?Q?Cy/eNoViKSXKPpYUykWorFvXqHwe5X4FOWP2A+Din3E8OgGVwQihuhgkJAlW?=
 =?us-ascii?Q?r0HG5LKP9RWjKdXrycR3QvC7M3+yOdIbkXCINWFiFNjW+oVZy4p3EcGQmil2?=
 =?us-ascii?Q?08yT9ngp+T4np4VWys2NvOZV9uJ0tdPx/5r5ebQaEpckbSG5wEkFP/X0Kpx5?=
 =?us-ascii?Q?1+XeoPWFQ7+I86UpjugRbWVa1MJXneirDx2WAR9bRigX1Quxes4K4JI40+BF?=
 =?us-ascii?Q?iZ+3MQiAv6Zac52N9wqFpQ6PA2E3WvO2JVdkcRKuvfZ7exhJVYBSHr3Lr3Wl?=
 =?us-ascii?Q?xQk0j7NqCSaYJ9c2ZehHAt8xoc1cjqoJNLk+hZm8iAfyY1EmlnMizYIfo31Z?=
 =?us-ascii?Q?8M9zVq5oN9l50DPkB1Fuk6ohz+NqRh0eAYJ0pS3A73yiGyV0thXVstNU1jDi?=
 =?us-ascii?Q?m4IGRKU0M6L9iQX7qvaQO6db0CsaSJlSbEjAIze2CHSesh70Gsj2Vzl6+n7r?=
 =?us-ascii?Q?chDDw/zvWtxYAo3D4RFXGlmyuWn9EacX8LdmPzRVrYtASVbTs9vEgRHRlqXo?=
 =?us-ascii?Q?Az1SadPNxbqJ1+8yOeRHwJvXhFJVVSTdzzb2xLaDNOh3TlGDk80ZAohl9+8J?=
 =?us-ascii?Q?DpzlKRp7ntaIk/IUES9zHElFJnPN5uVKxR59+YasmtzX+06y1x+lVwuBBSSX?=
 =?us-ascii?Q?5MzKMxVnZ4z9xTQhDm9YMdx9g/454wWGVD0R0I1nG0An8IMwAOaG1Zmiq/ij?=
 =?us-ascii?Q?ato6mNbSBGTRVh+4aTsG3+n1QVlRuoQAipENiRfFRGTASXDj5Iw/5aq9pNyO?=
 =?us-ascii?Q?wpu2EC2A25Qbh6ilUmj6WAGdji6cv6qaVXZQVUYpHeSiUtzYWhGloNxn1LN/?=
 =?us-ascii?Q?Zx70rz8Rvl1PaOqRm+CI/w8wMvDqucAIkHmPJ/etGeSjpmBmGi6W7AMsGjor?=
 =?us-ascii?Q?4g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dbad4d68-aafd-4272-0f77-08ddcdada00d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 08:06:15.4610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRuDonKhHiNtgaOa2JA3BQMVNJWn5ka2yLkBDt4y7ISmY14jDNAiPnKsLkcsWDdRHWC+6FfFNRMEPIjJNwahKPEuQtbQWQZbqdGw1gJahTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8348
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Jason Xing
> Sent: Saturday, July 26, 2025 9:04 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; bjorn@kernel.org; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Jason
> Xing <kernelxing@tencent.com>
> Subject: [Intel-wired-lan] [PATCH v2 iwl-net] ixgbe: xsk: resolve the
> negative overflow of budget in ixgbe_xmit_zc
>=20
> From: Jason Xing <kernelxing@tencent.com>
>=20
> Resolve the budget negative overflow which leads to returning true in
> ixgbe_xmit_zc even when the budget of descs are thoroughly consumed.
>=20
> Before this patch, when the budget is decreased to zero and finishes
> sending the last allowed desc in ixgbe_xmit_zc, it will always turn
> back and enter into the while() statement to see if it should keep
> processing packets, but in the meantime it unexpectedly decreases the
> value again to 'unsigned int (0--)', namely, UINT_MAX. Finally, the
> ixgbe_xmit_zc returns true, showing 'we complete cleaning the budget'.
> That also means 'clean_complete =3D true' in ixgbe_poll.
>=20
> The true theory behind this is if that budget number of descs are
> consumed, it implies that we might have more descs to be done. So we
> should return false in ixgbe_xmit_zc to tell napi poll to find another
> chance to start polling to handle the rest of descs. On the contrary,
> returning true here means job done and we know we finish all the
> possible descs this time and we don't intend to start a new napi poll.
>=20
> It is apparently against our expectations. Please also see how
> ixgbe_clean_tx_irq() handles the problem: it uses do..while()
> statement to make sure the budget can be decreased to zero at most and
> the negative overflow never happens.
>=20
> The patch adds 'likely' because we rarely would not hit the loop
> codition since the standard budget is 256.
>=20
> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
> Link: https://lore.kernel.org/all/20250720091123.474-3-
> kerneljasonxing@gmail.com/
> 1. use 'negative overflow' instead of 'underflow' (Willem) 2. add
> reviewed-by tag (Larysa) 3. target iwl-net branch (Larysa) 4. add the
> reason why the patch adds likely() (Larysa)
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index ac58964b2f08..7b941505a9d0 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring
> *xdp_ring, unsigned int budget)
>  	dma_addr_t dma;
>  	u32 cmd_type;
>=20
> -	while (budget-- > 0) {
> +	while (likely(budget)) {
>  		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
>  			work_done =3D false;
>  			break;
> @@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring
> *xdp_ring, unsigned int budget)
>  		xdp_ring->next_to_use++;
>  		if (xdp_ring->next_to_use =3D=3D xdp_ring->count)
>  			xdp_ring->next_to_use =3D 0;
> +
> +		budget--;
>  	}
>=20
>  	if (tx_desc) {
> --
> 2.41.3


