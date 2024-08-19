Return-Path: <netdev+bounces-119550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1CC95624A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 06:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9044B21D3A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 04:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578FF155335;
	Mon, 19 Aug 2024 03:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBdiiLJK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6A158210
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039908; cv=fail; b=DUz36MwEJZV1K3T3uyb/DxtFZcwNjAviR1HHUWSCW+Qw42km7HcR6LmPHBi/OFSOSTYaDBcZ7nkF3eacIOC+X1amnpswcgmcmJFtH73stwZIXrMyrST1hmauDbBKurA1zlIbNMdbuGRxcudjYZN9iMD7gd9ufFsEv+ZZlgvpvKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039908; c=relaxed/simple;
	bh=nWemNtABRJhs9ER/O+toP31mbuj4DgTZ0FxJ97q7zsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TfN5GLlbzb87URMXDZ8cqUAGmTtJfDXq8GChhgmyfElSv5WqMSZ7vQEg+k35TdcrlWavEWLwYkZ1cqRPkK23VKWiIR5KzWQhV4IwMrxZr/GfEzLtAY4E32Z5qL/QcqO70tx8wa003dSrPAm2Ivy1KoKqk/Pn7gjCoSVIiQYANdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBdiiLJK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724039906; x=1755575906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nWemNtABRJhs9ER/O+toP31mbuj4DgTZ0FxJ97q7zsE=;
  b=cBdiiLJKFTbSCVaR4+Mz7Cf7ET0cYGpmJcmz5l67iz/RR8rYGW6beZxt
   MwnxQKu/ZthWEp0xqOUhQ7oFUJNza0W0m4joaLsT92UUftwh4KEX09ZaH
   zqx3+j/QAF5RinhCb7DAPr6U4cPymLmE5Z3OcORNmAguJDIBVFrWvEV8R
   Ibe6ie9RprsW7CSrOhqOOrqnaGC89RXzkpsWABbr7D4M+d8E9qfQ4lvqo
   16iF30rwDA8GFxYjMQ0eV1ST64Te4a8wWjqhPJALE/HVSI4SexkSecBWE
   Pxi3QR1T/bNTRg37hwA6LbhUVdX/Fz9v+17r/m7jexO9Ex4UYFAi8cxIa
   g==;
X-CSE-ConnectionGUID: RGVt4TQ0Rhin0Aoe9/JKJg==
X-CSE-MsgGUID: ZtLGPspXT3+vTTS5T2Sb4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="32932431"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="32932431"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 20:58:24 -0700
X-CSE-ConnectionGUID: q6n4YRumRdSH+TwgIIWy5g==
X-CSE-MsgGUID: +vPPESE5TtKFarrh3a06Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="65205201"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 20:58:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 20:58:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 20:58:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 20:58:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igfA2IO8BBvhsBX7kj20cMqxixfriD8WBfsevp1FKWiVe+/t5nUg80xkleziaO3PPcdX4bD1uiQVJO1oLacradYHinfbLT/CkvosPy8/9zI0YbTMPT2XcNqYY6ESxSgM1iPzprCwGuj7WnU1bwheQ0PTTbpXP50VrjUMMFWApG7LA4QtUuTgyXmcmx7y1HnGI4Kvg2dsCbs0Kg2CoilcgfcMp3C1mh+wmk5U7vRV3OwuYOq4Wc8hwZfGGD8ze212yl2EiUgP6uswtp90+o4K3Ge/UZ74ZK2fnWiDgPFUKCAm2H1FCjFJyRJ0jLqVeqhtwHli7949Q9Ol99QmlG9L+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXdEe2F3ZhdoNfLMkpMx39V3ZA1WMxiPADLSGubEHRc=;
 b=v+7KJLtlTELKc2p1SvPbnH0gpPSHQSpgzBk0LjMXRJClqr/Vj0ElTciFudAA1i0kyLCh/gGG2AdicYRniMZOU6/a9c5RPHfGHaD7LY0llm9gl3lYnS3PQxEoWVyOQRJoIXiXTrtMPBwljWeP/UWjUVTcerdM5x/1UcNx0KMN8K8PP3/wVkVKxkXn72Z1AJB0ekFMioelS01xfwjygmYh4MgK+sOEyG2DfCVb1TDyiuqxtTpdI5azEkw4xrFsIppcp12hDdG9yzaIB0zbUjND0FJ1KmS9IXqnOj2SY2AKeXpAIkIL+wQH6bdxhIejLCwwCw4UZ433IZrR0RYnrSUIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Mon, 19 Aug
 2024 03:58:22 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 03:58:22 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-next 1/7] ice: Implement
 ice_ptp_pin_desc
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-next 1/7] ice: Implement
 ice_ptp_pin_desc
Thread-Index: AQHazIYfo7BRKawdT0GK+fC5PvWKvrIuOx/w
Date: Mon, 19 Aug 2024 03:58:21 +0000
Message-ID: <CYYPR11MB8429182573159BB5A5F2E48EBD8C2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-10-karol.kolacinski@intel.com>
In-Reply-To: <20240702134448.132374-10-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SJ0PR11MB6792:EE_
x-ms-office365-filtering-correlation-id: 8c9ccd85-4ab2-49bc-fe98-08dcc0032b11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?og5Ydy7fLKe3SCDER4fOI4HbeR4WwzCLl5GDP/R8rH3vye7qRnmc1/bs27IH?=
 =?us-ascii?Q?mgT6A61DW7l++7IO+akKZYUfoLbn5WJOCEEbg3wTLBJr4a912CX8oSBrrGdm?=
 =?us-ascii?Q?zAfeAbBbtqyODJ5nqKYFthXp9qGMSOfaHZhRfe+wj6bxRPCxWTL/xnnKXU4M?=
 =?us-ascii?Q?Xx2skQu8lkG72cEk1WhFPmYMPXtedi8j+AMxHIJnxXaICcB1ANxQ4rFbnrWo?=
 =?us-ascii?Q?GwqpPeJ2ou66Y13atptcTaI/QLtGZj+FESz6kZWmvhC2u5ai+9DQWL53RP05?=
 =?us-ascii?Q?QlCEnMdRW0+dPUtdzfv8d1OHg/3o1pLdbbPxsWuRQMdfEChqr2akEMKyKtr+?=
 =?us-ascii?Q?Y6n+j70tKH3hUHm6oB9MwADOk5GZ7bVXUPsN75pZUMZGPPnai6CgSF+CVmzX?=
 =?us-ascii?Q?klW3HIIg0diqMmSD+mq7G+H0PHIID6uJ8r0/RPNVupIN9DRJIfVpWcXY1RTk?=
 =?us-ascii?Q?WqrG/RJ0M6n76P0a5jdo1IkmGUX+5Q4ETCHcAxMe7J0vkJ1nMScux+73hHnd?=
 =?us-ascii?Q?Ltng6pYptOpDyjtdrSVwTBCCWmL5UzJpqEY0gewQVwEoeN06w9cCC9HfYUcS?=
 =?us-ascii?Q?zpmflRXan6Hwd/OyuEgwxsqCrS61ius92k99tdz4s0R61jF7XsPRKuVLHjJP?=
 =?us-ascii?Q?rwS70CvWfNTsqyXK4ai7+wWRe10AH6HvuftPZC6JpkPKWw037/HB47pKQgoj?=
 =?us-ascii?Q?/qf8/dsJhw0ct/R3Nya8hi5ossrazn+PG6vyC9t5D1KyfGTA8MhA1tDTB/8B?=
 =?us-ascii?Q?9NkxTJJakMhTLGcasnsxghRQGpUdDkVApYnO1sZzyvXhASdfxRDylaX5FkOR?=
 =?us-ascii?Q?uIwWFY+8Zp5A0rkrizPcm/xF6k8tReQKzsjBiedFBfL5ua04sY/SucxN+ndx?=
 =?us-ascii?Q?kI0cGlCu8sp1jHcuyaeXHCi15YrF5NCF1DgU8XEfU2M8p9Qes+sIaPk/KSDo?=
 =?us-ascii?Q?D1XGwkm03Uf0yXr/1XJbc1GJKIf8aqBaiqQBOQaSzUFSq3tq1Nk+CxE2vBzK?=
 =?us-ascii?Q?8rXtPBW8JJSWEnH57I12Atn6r3ph7Sx1AsZrBIm81r7zS12x8OBFaP1+ik8t?=
 =?us-ascii?Q?vKyJP8Svalz6ow2/9J/WACbQVZLU1eI/7pZXlYoarBXTV600GThWzq0AX4Zh?=
 =?us-ascii?Q?5jSyLWBiNsk6k6Pmsd3yet/OR4SEfdKZQ9YhjaJEukiw0qqOkxv0mD9fclEM?=
 =?us-ascii?Q?ox189vKbXS8Yj3tne1CFCMiSmGFEo3NdKD2FiuqVMmIr19xjV0vsBEz0/4CZ?=
 =?us-ascii?Q?Z4zFO8BZGyJwr94G2dmeD/ayHx8KLG43NxKBlm45Y3Pt6992j2JIHUkzgaAK?=
 =?us-ascii?Q?CieBeneAsaTdjhQoZcNfXO/NcfIZXJE71r/Xmm/J99SALv5y3W6BM6E/KgpH?=
 =?us-ascii?Q?feSEWmWElv7NTqDMJPmfEeuU1jmMIJT9gxKptugsN5MsR21D5A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KH8DrNT7Tle+4+9H8MAx6ZxTfJ9nYMhxdL392SrCoLRo7OtiSKcmGNZejN33?=
 =?us-ascii?Q?VJXKqQflC2yaRHcUrDPyeEP2fF8ZWwPoq4rt5o0by6Q/WA5+lOfoKo5D9ROK?=
 =?us-ascii?Q?Bv4qc2JSYzGfnQL3YGfzR99SOro6lH3o1iKxbU/hzI4vx1PfLuvLWhl8s4Sc?=
 =?us-ascii?Q?4VmccRoWiUa1oN0wePav/XY0g8OXIGzThYOLcIhIuXYd6TFzL0IvSlNeSKMo?=
 =?us-ascii?Q?Xk/AgMd6WX/fiKTs+MGAMO6LFb1VrzdtYkZ+J+Z8uy3VYjHVLWi/E9mEhdLE?=
 =?us-ascii?Q?H/nANsINy1bciHdS+vSmqHZusAB5QN2tuG0sU/5XmP8wwS7KBUdZNOKkEDqi?=
 =?us-ascii?Q?Yef5GsLu4EU7zR80N4hsQeDgzIyjOyq7IQdv22JxZ192C5vIvGfV1+zubLUM?=
 =?us-ascii?Q?TKHat6G/ChY7174ZvscR1YlkC8FiOlsdaFeP+PUx+DuzNN0sjcdC2191BX5O?=
 =?us-ascii?Q?6Ebr2ifntTto0I90rd+uWKfv8nxlEJz0PLA6rAdHpioyNRSCZpvcHSlx3JvY?=
 =?us-ascii?Q?P4ol0Rmc0pO4F92a46J1//OM6QnW2Cl2TSn9klI412Gk8E4Vc2PPOj1yjvt/?=
 =?us-ascii?Q?Os7vN0qEQeVd3SgepTN3cMYkALABowVZZl0Q4X7HVU8bpL9ewgNjYngmzSAR?=
 =?us-ascii?Q?bHyQGk8I+zge0fD6Ro9rBBus5k+dz4+PyBI0LjhDxyMlzEcJlunA37+83L8T?=
 =?us-ascii?Q?2ulaK8ga7ixIjc1c1b+HBLnhhaC84z4UQZ3lX3sNz8zYm1K5VvqhhO+QATLk?=
 =?us-ascii?Q?OSEMY7pJ49IKD/PYbC05Ro/WzJgj9MeY3ZW+G9G9LWoMdzFse2l2wYiJOFks?=
 =?us-ascii?Q?cpj9uIHvTowQyt6UYyxtEHiYi5Rq1PEvinlL2M7jqVtevaoDmCVAWGlfjzwE?=
 =?us-ascii?Q?nehzdV8H0Lt+8vDfRqiR/qTdkLJvMOxVX7SbjsfgqrTOr4idLIwYBzLOyVcj?=
 =?us-ascii?Q?hLAL8jNThOtWgwQAkNtQssRmzrDTaq0O04KMIblpI3Gi3SnA2dxSrrKJGmPJ?=
 =?us-ascii?Q?LBMUTreY+A7IyAqF2CAme5NNH8uNvGDKdMEtDM3pEV74z2yU5AJkJKUrp18j?=
 =?us-ascii?Q?zMN+x9XijaxZGz15ivViyxAXTMlD3kb5U9cfWk4ep0f25rG95nTSHS3SpYzp?=
 =?us-ascii?Q?2Y9O4oyi1oHAmCaGTuExXnQicqmvQ7tdal+Fi753CQgurH/oRWZeNe81+uCH?=
 =?us-ascii?Q?+AXWDL4rJrwGkJ9miJkjkMB1R/EShaYzRzOZ5VYxBZ6td7DR3NBMC05LBJ82?=
 =?us-ascii?Q?dLmxyEuY0ueQhyfA3PWuVuMUdciBnBuP5gJta97fdV6xtG7GDRWwrYg3ztoc?=
 =?us-ascii?Q?+FhKNx2k/i6ECuRn6kWmyE8q0GSyDB1Uq/mLn98y78VO7Xmj6+A+bPShImLK?=
 =?us-ascii?Q?LgYrGqKiiJB820uQPc4l5NZZW1yqMW627U6Ns4qmmJzvNKErFqDihp6M43em?=
 =?us-ascii?Q?/OfHMYKp1iWQhDbaj5j4nCYhxEKEBMgnv9VoNKiJNpFbJnyXA6rZ5RnJPoVh?=
 =?us-ascii?Q?nyZcduqIZKXCifMhGE3xKRbvNytE+n2H7h1LsyaAS7ecq8SWWBGa74pCO5fo?=
 =?us-ascii?Q?w6+Bfz1NGeKdysZ06zELh60M4nWOOuMM9nGd/pdnt29IvDTjkJGdj1NgnMx+?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9ccd85-4ab2-49bc-fe98-08dcc0032b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 03:58:21.9561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvxTAtZrdSQNdRxqEl/o8M2SCAwQ5wN1AFG1PPpIVwqs1FbmJNbdNFFdhZkEyRpt4K1hQ86HlhUMxI+jRChYoiM+olp6E/nqUQTjEXBXfR2TTZ5AAS9wFz26CUBiwfns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6792
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Tuesday, July 2, 2024 7:12 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kolacinski, Karol <karol.kolacinski@intel.com=
>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Nguyen, Anthony =
L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH v2 iwl-next 1/7] ice: Implement ice_ptp=
_pin_desc
>
> Add a new internal structure describing PTP pins.
> Use the new structure for all non-E810T products.
>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: Removed unused err variable
>
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 270 +++++++++++++++--------  =
drivers/net/ethernet/intel/ice/ice_ptp.h |  65 ++++--
>  2 files changed, 228 insertions(+), 107 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


