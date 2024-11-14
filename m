Return-Path: <netdev+bounces-145021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560FF9C91D7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209D8B24970
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7110817084F;
	Thu, 14 Nov 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="URXx2akR"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F81974EA;
	Thu, 14 Nov 2024 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609918; cv=fail; b=tWoSfTD4T8vLavPCKYPS41bXYRIrn/dF0uqJ2y40Fl1m6ZnM5N5Wa+xqWxs8Hcz6JeZr1gA6gR4a/1qCVyGycQtzLe41aOpge2C6Fotnc4bffxPaPEhHZrzV5K9O5B9G5cD+qRZ+/fSijwY9Mcz+4NTywxfhvhi6EwYsdEKYiJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609918; c=relaxed/simple;
	bh=4mmLk4Pagw8DTnpz3KDn6224S2C3fSendvwnPBzyXsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f7JdMtouIETpVLJfpB3IuL4+nfVZbMSUSCipkRTTcg9XxeQwVDha1E9dkHyqqRQzyLzH+jUemt8A5i5NufJOFq89tXV+A02zS4soHSC+zWWCfaQ2JlutvYWOKMDG1ty1jXV3MHGTqQ0OcVwARfM71NhIA0Ybec5UX/5vXd8AMHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=URXx2akR; arc=fail smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1318; q=dns/txt; s=iport;
  t=1731609916; x=1732819516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4mmLk4Pagw8DTnpz3KDn6224S2C3fSendvwnPBzyXsc=;
  b=URXx2akRSnSxpIPQokAPIrXVpZeFih6NMNNtSjz2u9LKtYGy23GzoAFJ
   3JdZdlIH+6fQnF77rEOS5Fq/P52jjurJb6/dHmOz6U5wkIuHMmiCWi9N+
   fK3Z3Y9jnPib0mHpBS3IE/f0FUG4wClAEg04ucN+glhdiooM29/Ki+rW0
   M=;
X-CSE-ConnectionGUID: FT8zz6nQRYmGUETLkRBDeg==
X-CSE-MsgGUID: uPDrFdkxRq20MzT/UcQhBA==
X-IPAS-Result: =?us-ascii?q?A0APAAD4QzZnj5L/Ja1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEaBwEBCwGBcVJ7gR5IhFWDTAOETl+GUYIknhaBfg8BAQENAkQEAQGFBwIWi?=
 =?us-ascii?q?jICJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFFAEBAQEBA?=
 =?us-ascii?q?TkFDjuGCIZaAQEBAQIBEhERRQULAgEIDgoCAiYCAgIvFRACBA4FIoJfgkIjA?=
 =?us-ascii?q?wGkdwGBQAKKK3qBMoEB4CCBGi4BiEsBgWyDfYR3JxuBSUSBPBuCNzE+hBsnA?=
 =?us-ascii?q?ReDRDqCLwSCQXqEGSWJAJkvCT8KZRYcA1khEQFVEw0KCwcFY0YhLAOCSQV6K?=
 =?us-ascii?q?4ELgRc6AYF9gRNKgzGBXgU3Cj+CSmlLOgINAjaCJH2CT4ElBAWDaoELg2GEY?=
 =?us-ascii?q?YMZHUADCxgNSBEsNRQbBj0BbgeeVUaCQRBbgkaBRZY8SZoelQ8KhBqhXQQvq?=
 =?us-ascii?q?k6Yd6RChDsCBAIEBQIPAQEGgWc6gVtwFWUBgjw/ExkPjjrJEng7AgcBCgEBA?=
 =?us-ascii?q?wmRHoF8AQE?=
IronPort-PHdr: A9a23:OXflCxyW0bnUv5DXCzPsngc9DxPP8539OgoTr50/hK0LKOKo/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHPGI=
IronPort-Data: A9a23:vA2rfaKpfkf5OEg9FE+R8JUlxSXFcZb7ZxGr2PjKsXjdYENShjFSm
 jYcCGyHOv2CMTHyeot1aN+29EgAuZDcmtIwQQUd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCea/kr1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrX0
 T/Oi5eHYgP8gmcoajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1AMBEkL9Mew9xGBE5z2
 MA8KwonQh2M0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBXLAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEqojx5nYj/7DLo4keqzjX71ehVTqUmeouw85G27IAlZi+i1YIONJYXbLSlTtlugi
 njo82fpOAhAbPmN9X24+UusrMaayEsXX6pJSeXnraQ16LGJ/UQXCRsLRR64rOO/h0qWRd1SM
 QoX9zAooKx081akJvH7UgG0rWCsoBERQZxTHvc85QXLzbDbizt1HUAeRTJHLdhjv8gsSHlyh
 xmCnsjiAnpkt7j9pW+hGqm8gw/iKzpLK1Y4VCorcCY5x9rZiq0+gUeaJjp8K5KdgtrwEDD25
 jmFqikimrke5fLnMY3loTgrZBry+/D0oh4J2+nBYo6yAupEiG+Zi26AtACzARVoddrxory9U
 J4swJX2AAcmVs/lqcB1aL9RdIxFHt7cWNEmvXZhHoM66xOm8GO5cIZb7VlWfRgya5teI2G5M
 BKK42u9AaO/2lP3M8ebhKrsWqwXIVTITIWNug38N4AXO8MgLmdrAgk1NRfLgQgBb3TAYYlkZ
 M/EKpzzZZrrIa9m1zGxD/wMyqMmwzt2xGXYA/jGI+ePj9KjiIquYe5dajOmN7lhhIvd+Vm92
 4gEbaOilU4AONASlwGLqub/23hWdiBjXfgbaqV/Koa+H+aRMDp6WqWIn+J/IdINcmY8vr6gw
 0xRk3RwkTLXrXbGMg6NLHtkbdvSsVxX9xrX4QRE0Y6U5kUe
IronPort-HdrOrdr: A9a23:m3CBjqEK3DrVahLVpLqF9pHXdLJyesId70hD6qkvc3AlCb3p5o
 KTdaUguG6N+UdhG03Ix+rrSdDwPwKdyXcU2/hvAV7EZni7hILIFvA+0WKG+UySJ8SQzJ8C6U
 4LSdkaNDTPNykjsS+E2njoLz9N+qjfzEhH7d2u5EuEY2lRGoldBkRCe1Gm+nQffnhuOXNBLu
 u32iMlnUvmRZyjBf7LUkXtPdKz+OEjz6iWNCLubiRPgGL+6ULUmciKWWnXr1Ijvit0sMtStV
 Qt+zaJnJlL2MvLkCM0uVWjtKi/WbPau6wzT73CtuElbhrrkRihf4lsVvmvuzovsPiz5FtCqr
 e8xGZTTo0Dpk84ZgqO0HnQM/yK6kdM15Yg8z6laLnYzvAQ9FkBepx8bE5iA27kAjIbzZdBOK
 8h5RPKi3KmZimwzxgVLuKpJnca4jv90DZS0NL7hkYvAbcjVA==
X-Talos-CUID: 9a23:ZWi9BGCRUu3II/v6EwdbpFwGRMYcSEzY40r9H2u7M0xFRbLAHA==
X-Talos-MUID: 9a23:fUvsTAvABmM8Y8OZUc2nmQlOLulk4LSUERpVtIc6/PSPDCxaEmLI
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Nov 2024 18:45:14 +0000
Received: from alln-opgw-2.cisco.com (alln-opgw-2.cisco.com [173.37.147.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTPS id B753E18000487;
	Thu, 14 Nov 2024 18:45:12 +0000 (GMT)
X-CSE-ConnectionGUID: 9UUJ3VXlQki3Qlb8S9KpEA==
X-CSE-MsgGUID: f1QONRcLRYG1JK75ySQZuQ==
Authentication-Results: alln-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.12,154,1728950400"; 
   d="scan'208";a="15207611"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by alln-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Nov 2024 18:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNZvJyieXSqd7IPyzrxQy9F1/snaP3iH9tXSRGXiMpQpSFpUD7x+DtD/N7dD3pcGPbEPx1OC7zCfi+4G9pwvMA260rleQ2rUGkmsgRf0C7saSjb6tIvx7VY6fxdIJtMbGLkd9a6UTwEDVlW7Ff7+rQRFR9R9MrZZ5F5t0dyTCUlWMH9ffQMLqp/Sc+RdoVpfe/Fkk8mq1BtN78v0/8iYuhTk2LsWNlfMORdYzXcJDsveiQg0aCgmuE6pDaC8ijvFFq2jVfXm1fJyYsVbY1ntceSz+8zF1xNV2h+jnx3uUsl6jeFncPvNOH0fz7Bhq6MngAf6bgsaimffn/EWegt+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mmLk4Pagw8DTnpz3KDn6224S2C3fSendvwnPBzyXsc=;
 b=JMl5pty5bulGtPElCET89c3JDhBdiOW1zdAZhsitTSITQzP08T3txcV/RlnuwilrY59G0gixdrKedE/qi0dCWJsSBBWGJwsxCg9Tq3hZQtUlBrhZG6ngWKwcL52ELBunorm/ha2yOhVxMvEyiY6bVf2re8HtI5OQDSZ6VmsMpR8yG0fT0g//GiP6e85huwHlESJKhtVUprdzqyLUd7JhLgmVlmVc+MrWMJOCp3w5Dp7QFF2fmCKagyN2TvixDiNdxPbTI7m1CyBwNgLVYZ8ZFJLKIOC08w/n1h8W5KgEGUdDsJw2lBfHX/hvAFgCqLJGiHEkkOEVGVzCSE4llYENNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from BYAPR11MB3030.namprd11.prod.outlook.com (2603:10b6:a03:87::27)
 by MW4PR11MB6689.namprd11.prod.outlook.com (2603:10b6:303:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 18:45:09 +0000
Received: from BYAPR11MB3030.namprd11.prod.outlook.com
 ([fe80::83f3:554b:f590:e3d6]) by BYAPR11MB3030.namprd11.prod.outlook.com
 ([fe80::83f3:554b:f590:e3d6%6]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 18:45:09 +0000
From: "Nelson Escobar (neescoba)" <neescoba@cisco.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "John Daley (johndale)" <johndale@cisco.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti
	<benve@cisco.com>, "Satish Kharat (satishkh)" <satishkh@cisco.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman
	<horms@kernel.org>
Subject: Re: [PATCH net-next v3 0/7] enic: Use all the resources configured on
 VIC
Thread-Topic: [PATCH net-next v3 0/7] enic: Use all the resources configured
 on VIC
Thread-Index: AQHbMigWkRNBzmqR/0i+BVGNzy9SD7K0g5OAgAFthIA=
Date: Thu, 14 Nov 2024 18:45:09 +0000
Message-ID: <40FB10E4-D941-48A0-A03F-627D1A62AC16@cisco.com>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
 <20241112183003.534e5275@kernel.org>
In-Reply-To: <20241112183003.534e5275@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3030:EE_|MW4PR11MB6689:EE_
x-ms-office365-filtering-correlation-id: f837fece-2d0e-4439-6a45-08dd04dc772e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3BGNnJvMjliUVEraG5JaUFuNHp0b0RXR205Vk54TkpBRXBabWdReE8veitF?=
 =?utf-8?B?ZXE1aWJjWm1WaGQ5ZjBRYkl3eXR5OVpQbDJlcFF4aDE2aTJWeDJUb2tHdjZH?=
 =?utf-8?B?QnFvQ0t1bFdMVE96U2YvRnRMM3pBbVlJVEU5YWhBQ2lWV1RiSWVQTVdsR1pn?=
 =?utf-8?B?dG5YQVZML2hHMVNoREdabjdTU1dwbWlUb3dxQ05ZMFJqbmxJd2xmNFFuNE1l?=
 =?utf-8?B?WmZud1A5UkpPMGx5cnpKTVk2Q3QwcmEvanhGMXRpaGx6dFdKQkZTL2ZRQ3pN?=
 =?utf-8?B?YUlmaHpwWDdhWi9sZ25rcHJuV3pqYUErNGhBMlZNUER1bmt2MllwUmlGNFBt?=
 =?utf-8?B?bkRJdmhWYTZjOTZzdUVCb0g4aGtZMWh5ZVlNdW0rb1drcGhPM3ZoK2lENUly?=
 =?utf-8?B?L1ZmL0phT2t3N0hLTVN6dng2NzRIdjZrRUxRYkIwM0k3TTI2QnJkeEEwS1NW?=
 =?utf-8?B?WUJ4RVBnNjVhdEN0dThiNWVWdHYrbjlrOW0yRTI2dzZBYktZU1c0ZEd2b0Vr?=
 =?utf-8?B?ektYTGhic1hZaStkVXN0R0drdHYyZXA1bjVZeTl3Ny9kVVYvamw0Umx5b2l6?=
 =?utf-8?B?cW93b2crcWJBN2NMOW1TWjdaVUNSckZLay94SWNVd3I5Z2xNVWhOekdEb2cw?=
 =?utf-8?B?ZVViVms1eUxaZ0FmYzk3alp6QVBFcWRtalFvdlVrMFNZVFFFVnRsMzBxODVQ?=
 =?utf-8?B?WUtDMVRxVDVDam1YalBzU1JrL3JwSGhERG9sQUUySUZ5T2kvS0FEZTBySmNs?=
 =?utf-8?B?d3p1QjZ5a2FoOVhqNzMvYVlPUVV6N21JbTNHVlVUL1lVcTk2cUpFa01pTDlB?=
 =?utf-8?B?ZUtnRHNmczhmbjlDMUdYUENicEhkam9KZml6Y2NpNkZ4SXRXT3FYcloydWJS?=
 =?utf-8?B?K01oNjBKK3FMMWlWU2l5SEZSaVVVeGJ6ck1oVVgvNjNsOVBEcTI0RWhrd1hB?=
 =?utf-8?B?dG9Bc0dqa05iQ3VrZlVtTGJKUHVYeEh6WnViUUpmRlNWSDRFRFdpSzJaY2kv?=
 =?utf-8?B?MTlKQTBFVmVPNWptYkdMbmRNYWlKOVZZd2tlZkIyNkJKYkFPT0dncC8veDdy?=
 =?utf-8?B?ODNCMDFmakdoQnUySXBwWUsvb3JLOXJoRjZtMzZFdGdXb1A1UitrenNRczhH?=
 =?utf-8?B?bFNrc2RjVUJvTXFQNFpjNkxranRTVDJNaGY1Njd4d2hJV3RBMWJQOThMdkdJ?=
 =?utf-8?B?aDhlZmpHVmFITmV1THhibG14eHVBZW9WenB0eldKY3UxaDBWcVlOb1MyUUZD?=
 =?utf-8?B?dEJmU1dIYlVvZ1l3NnJjd0pyNm1DN2RlbCtmSmV5R3V4MkZnVjBaZUN1Vnkx?=
 =?utf-8?B?ZmdJMWgrQW42S2FqQjdabFEzOCthWGlHb1I5S3Zua0JsZmFhajRWZVM1WThI?=
 =?utf-8?B?VUR3ajRjb1kwSHNUa21WRjJZT05qWXl5alM0RVpEVHhRYVhad3Q2VXZacUpy?=
 =?utf-8?B?cUJESGpJaXBKV25XSXVwWFM0YVkycGJwcnhFQ0xSbEtGSDQ5bnpPWnFnWStO?=
 =?utf-8?B?K3RmUHZSR092QmlPZTI3QWJxcEQvakQ0Z0lEUGRBWDhCR0RVSUVWNXo0REZi?=
 =?utf-8?B?NFc4MkM4SHFnMGxkbVJHV1Uzc3RlME94VGozeGY2TEtuVWhIZEJhUEpMaWxa?=
 =?utf-8?B?RGxLaWVxa1VvRmlIRFJBc05ta2F0Z0VXVTdpRmhMeTA4R2VkRS9iQkhmbVVq?=
 =?utf-8?B?ckdHeWk4bllPbXE0alZkTFJCVXZ3VmJCbURmOWVFdWxmbDVqZFBCT3F5Yk91?=
 =?utf-8?B?bjBkR1dMV29GM3BkcXJjOXNPbEppZHAydkRNQ0xTWXREYlN4RkZ2SitnZ3Bl?=
 =?utf-8?Q?4T9T2dNbno6h7c4iafApHg+GM9l5S4OAm41mg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVdDVXkrMzNZTjVhMVZXcktoTUNqVzJOQ3hET3loYy9ucmVINk1JaDdsalNH?=
 =?utf-8?B?MEdFcWJuUDNPMVFoaGRvbStkMjBNUmZkRmpoeEo5YUZkNnhldTBaVEdVb3JU?=
 =?utf-8?B?YWx2ZUlZRjFvSldhOU4raVNUR2xWY0VuTGFaQ3VnYUd5Z0YzMnRkMHBlQ1dx?=
 =?utf-8?B?OFpUekNuY1c1R3NPeFB1a0s5WTFwdURCU0s4azkxVHg5Mkhsb29USDBYeEJY?=
 =?utf-8?B?V01vTWhDc2lEY0tocy9MeUVRaFZvWHVvTHlUWjYzaFJDZHZGcWhZOHVmWEtH?=
 =?utf-8?B?NlBpYzRsdmI1S2JkdkV0UGFua2VLNE56TjJ3TVp6ZjZoQWp6N0NLRWMrdmty?=
 =?utf-8?B?RW41aFhqcHNMSWZ0eTdaVnA0enVrQ1dWaGxQL2Q1K1RRQmtadzl3S0hOSmNO?=
 =?utf-8?B?dWprcHl6VUY4dWdhdmUvRDY0K3J1Rmo2NC9XWWpvb3drYmI1UzgwWWNneGlt?=
 =?utf-8?B?OU9kRkI5YS9JRENrdzR4elc4ZVlnNnRvVzUxcHl0WDFlQmprdkFUK0RUWUVa?=
 =?utf-8?B?ZE5PbUUxV3YyQWZRYmtONkM2ZkN4T05XdFRyRHBjM0hPZzZxSk45Wm5SMDVp?=
 =?utf-8?B?dEtQN3JxbXJmMWpkc3RvUExxVDdJVmFhN0F3L2Fta09NSnJVUGpxQ21mdlIy?=
 =?utf-8?B?KzM4UnB5N2xMU1FrYndrVjZHOHdJenVDanhSWk1CdGxiUmdaME5kZkM3R0o2?=
 =?utf-8?B?OFZzbWVOTUl2ampTZ0FoSzNOZnRpM2t5R00xNnd1NTUrYUJsbmpXa1NZY3hV?=
 =?utf-8?B?QTFjM242bmFUck9Ha1lpRnhKQ3drazhiWHRDRnBYL2o4Vys1QTJPU2FaMEVl?=
 =?utf-8?B?Sit4VkdpNzBhb3J6NjN0UGhXY0NMTWxFR1FwcFR5VzZ1NTVKeC9WSDM2MmpZ?=
 =?utf-8?B?MFF1YWd0VElUZGErNzMvdTNCclMzSk96OEpXb0trdy9Pamw1eXdWaHQvWnEv?=
 =?utf-8?B?TUJnNHlQQy82eWRKa2xsSWl4V3g5VWJzSUpuMG1FWllyUU9mQjZZUjFjYTR2?=
 =?utf-8?B?U1Y4WG11cWhLWXZHUHRnNkg2MVJ3dzFaTnQ5OGVzZlFzVW93VFN0aGI5dWxI?=
 =?utf-8?B?S3kzR2xyNUVwQjhQVmloYzg2ZzZwRmplTzJ1bVRUa3E3ZnlTSTAxeEc5cG1K?=
 =?utf-8?B?b1FrN3Yra2QzOU0xN0ZRMCtMb1hDZCtBOFNtQ0l4cDEzaVhkVHNvNGFZc0tv?=
 =?utf-8?B?dU84bUdTd3JTeFRJMkFzbXdtVFRsdjdVWDJ4dE5BcFdMMitvWk52RE1JWU10?=
 =?utf-8?B?NDcwdWRNVU1LN0k4NWxqK0w4emxKZTdDelVXS3NmbXpKY2RmaU45WmQ4eVZO?=
 =?utf-8?B?aEIvTGR2VmduWFhGdThRSjl0RGJoNFMvMzFiQXBiT1FXK3FlenNRL2JTZXRm?=
 =?utf-8?B?bHQvR09UUm8rYVlaQ1BNd0Z4SlRCajJwbm1oaXlnRys1WFV0ZVhLc3VNYjVX?=
 =?utf-8?B?R1JBS2hMaUJJc1AzRFBjUkxrRHlYSW5JcGVpOGkrclhZZlhMU3hUSGRyN2Yr?=
 =?utf-8?B?VHEycEkrOExTQmVjRHA0T2hpeml5VmtPcFNpajQvM0xYa3NVNk43TldORkky?=
 =?utf-8?B?RWtxV2pkWUZOQW9nQTdCZzhIaEt0VmhSWUZXRnFMMWd5QVBLZ2RiWDZBa3hZ?=
 =?utf-8?B?WGt2L0FXS1ZIZ296NVRFd01GMGlpN2N5NE44blR5b25CQ2NQUGxwZnhXYWNu?=
 =?utf-8?B?c3M0aEZzeHYzenA4VnJMdllxMHV6ZW1YMVhaMmRTWjRLSVBJRUZ5eStEVFBO?=
 =?utf-8?B?OGRQMXVSZy94NXMwSFhmTEJGQ3JoallqbHM5TU1RQWJQejlYMHBlVTBPMDh4?=
 =?utf-8?B?RVFwWWxrVzZmYnlWZFlhWnErcmVzMGVQRTJDYllscXZRK3YrSSs1SnE1c3dG?=
 =?utf-8?B?d2VuVmtZaENyVGhEV01DWVVGZDNGSUVuM1pEd0haU3ZDZUNSTVRoenlveUh5?=
 =?utf-8?B?YURIRHBSYitQS1JVd3dkTDZqM08vaWpBYVdDN2xxVUIvWmhGK1BSMW9XSGVF?=
 =?utf-8?B?dEIyVVViR2Fya3J2NVVSZzFpa1NiQkdQOFRxT0FLeU1mbElEOFRaVmdzZkxR?=
 =?utf-8?B?cEQvWjZBWFhwZTJMdm41N29TRjFqeEE0TWVUa3o0dlF3ajZ1Y0lqM2syaEls?=
 =?utf-8?B?WnQraU9GekxUcnVDdk9VWGdKMUIrNkRQU3Q0Y1h3eC9aSzNKT0FYamp3K0Zr?=
 =?utf-8?Q?HlTYUsa5WdcOP8gUs9ezFSgsOpW6vwHdAHuZYkYFRz6Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <620F94DBE86C8A4D970C96D6633B5134@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f837fece-2d0e-4439-6a45-08dd04dc772e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 18:45:09.4952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Tpm+ApInB8euMRHxMpABjCe1CFxj+HCkXlAX6gSiAI/oioGGDaXQs/nzvAYU7neyPmwj8xzjKWdljBBFXHAKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6689
X-Outbound-SMTP-Client: 173.37.147.250, alln-opgw-2.cisco.com
X-Outbound-Node: rcdn-l-core-09.cisco.com

DQo+IE9uIE5vdiAxMiwgMjAyNCwgYXQgNjozMOKAr1BNLCBKYWt1YiBLaWNpbnNraSA8a3ViYUBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMDggTm92IDIwMjQgMjE6NDc6NDYgKzAw
MDAgTmVsc29uIEVzY29iYXIgd3JvdGU6DQo+PiBBbGxvdyB1c2VycyB0byBjb25maWd1cmUgYW5k
IHVzZSBtb3JlIHRoYW4gOCByeCBxdWV1ZXMgYW5kIDggdHggcXVldWVzDQo+PiBvbiB0aGUgQ2lz
Y28gVklDLg0KPj4gDQo+PiBUaGlzIHNlcmllcyBjaGFuZ2VzIHRoZSBtYXhpbXVtIG51bWJlciBv
ZiB0eCBhbmQgcnggcXVldWVzIHN1cHBvcnRlZA0KPj4gZnJvbSA4IHRvIHRoZSBoYXJkd2FyZSBs
aW1pdCBvZiAyNTYsIGFuZCBhbGxvY2F0ZXMgbWVtb3J5IGJhc2VkIG9uIHRoZQ0KPj4gbnVtYmVy
IG9mIHJlc291cmNlcyBjb25maWd1cmVkIG9uIHRoZSBWSUMuDQo+IA0KPiBZb3UgZG9uJ3Qgc2Vl
bSB0byBiZSByZXNwb25kaW5nIHRvIGZlZWRiYWNrLiBZb3UgZG9uJ3QgaGF2ZSB0byBhZ3JlZQ0K
PiB3aXRoIGFsbCB0aGUgZmVlZGJhY2sgeW91IGdldCAodW5sZXNzIGl0cyBmcm9tIHRoZSBtYWlu
dGFpbmVycyA7KSkNCj4gYnV0IGlmIHlvdSBkb24ndCBJJ2xsIGp1c3QgYXNzdW1lIHRoYXQgeW91
IHRha2UgaXQgYXQgZmFjZSB2YWx1ZQ0KPiBhbmQgd2lsbCBhZGRyZXNzLi4NCj4gLS0gDQo+IHB3
LWJvdDogY3INCg0KWWVhaCwgSSBoYXZlIHRvIGFncmVlIHRoYXQgSSBoYXZlbuKAmXQgYmVlbiB0
b28gcmVzcG9uc2l2ZSB0byBmZWVkYmFjay4gSW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UsIHRoZSBs
b25nIHdlZWtlbmQgaW4gdGhlIFVTIHBsYXllZCBhIHJvbGUsIGJ1dCBob25lc3RseSwgSSBwcm9i
YWJseSB3b3VsZCBoYXZlIGZvbGxvd2VkIHRoZSBzYW1lIHBhdHRlcm4uIEnigJlsbCB0cnkgdG8g
YmUgYSBiaXQgbW9yZSByZXNwb25zaXZlIGluIHRoZSBmdXR1cmUuDQoNCk5lbHNvbi4=

