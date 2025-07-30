Return-Path: <netdev+bounces-210987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC0CB16060
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D96544CDB
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99A5239E70;
	Wed, 30 Jul 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ask8ropn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC22528E1
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878738; cv=fail; b=s+lFo6CcfNsOElGwUvUqJPtlHPIPPrWqQ4DXKRqQCfIPKlJ3mtD3dUz01SrDboG5XbBgfCZ6pVjji247RlihJmsAZtdmzaSjBNrbA0ibjkXGlTRQ+hnlzlNX0j95K2C0M1IU5SI8ioCvaNrLgCExXlwpmIWZt/YHND7MQQbJAs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878738; c=relaxed/simple;
	bh=rozSKDqFtJzKNageFKZ+wYV69y/haT+06n8ld0z+b10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUx78Eir9Hyb0027VxNeK3cJlljg+hrXDWI3WVRIZbqdNzJWMRpxNYl7hDYdrDgyAP9PEsrL5hUYzc6ZutACd5qX551BRSfapjOqetKQUtyVpRGG2l/RovVofEmRTz7DzBsSbWMJA+QWI5lQhHaCRKwXN2TBtsPgicGEMuCYVuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ask8ropn; arc=fail smtp.client-ip=40.107.100.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YykPaCDGqZR7QymAVY4vrMgbuignhc5ywW96LR6Bt6KGKIOvU0ejNoJnCO1Ut9Ty98fNO4uF+IrqfQKBLFuh2zLs/TALrRsoOC/FK/lvu7F4Ia/WflkZ+toen5w+aJ/H8JE8TQncKLstVhdnBYNPbjqZQdDzoYSFhGIp9RozxxtlTunrZSCZ/io2jy/uG/eiohwHKpu5hAMXWVFO8um4JyWF4eoGazjYUbb+RDuoEcYv3C2xnAGLWq9DhniBIktOCfW6oJSbXKcnPUcJBM6fpnp/SiNlpvul75tJx/Faa1TkNm2u5OYSEfrbYsKXda298vPS+qK6Nx4ksH0WJWb9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rozSKDqFtJzKNageFKZ+wYV69y/haT+06n8ld0z+b10=;
 b=Yrf8+bOJcRGTRJTpLR4pGL6xDNt93InRLNG0etzs/4Rao1vg4ag99dzQ6/5RUQZHZAj+heXMpEXJt5wbOCK+lahv86g2ZI0zDYxZGe7NZUJzmH4v/K/LDO61V9EiZjOhPNOYXxzrw4sqH7Zj/kVUrLi1z/HVkQMG/DAtHp5Ctl0MZ8IzLl5r8Yr7ZcG4Kad6ZgjMbwK83qeBlAjastPRlmSSb6OrzCUat6Ebvg6JC6apUBi2E7y7jv2St97esDQPS93XNePbEvJJthJSBDN6M/uY1EC87dD8ww08dnIxjnGJlM+cay62u3VDH8tFknlgt5ZlMwGGbmIKcna6CuSVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rozSKDqFtJzKNageFKZ+wYV69y/haT+06n8ld0z+b10=;
 b=Ask8ropnhBLWO9WzIopOrFrWIvaL1YqKt/Se1530tlkCvr24OxpAB8180r15z4OKYmiGA5b2aP2D4DWRCIRWyZm9iMcRu3cLu0CWTiDOjcLp4jImCjQ/xJym8SFLTDV9K42wxO4rKbfoBS/Oggi8A2roKusOpal8k2QeqRGN5+XGf3N03bGGXHrCMH7zzZlIQlev5PuLp+vAK2crY5v3RA0TGypERaAhZkg5jDE+VIaxQ1/qO6JrdiCkO5Hs+Z0BmqeLGmyll0FcSe7AlNTfIX25Zhgr2fu0xcofVUtRFToe5wG1MYL0FIvAbRJttK/vE1FFFg8TGXbiZwiawsSiUA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by LV3PR12MB9188.namprd12.prod.outlook.com
 (2603:10b6:408:19b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Wed, 30 Jul
 2025 12:32:13 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d31c:9027:c5d8:22b4]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d31c:9027:c5d8:22b4%7]) with mapi id 15.20.8943.029; Wed, 30 Jul 2025
 12:32:13 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: Leon Romanovsky <leonro@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "razor@blackwall.org" <razor@blackwall.org>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec 2/3] Revert "xfrm: Remove unneeded device check from
 validate_xmit_xfrm"
Thread-Topic: [PATCH ipsec 2/3] Revert "xfrm: Remove unneeded device check
 from validate_xmit_xfrm"
Thread-Index: AQHb/9LUQIxbYYOolEihGsgvsHVMy7RJOvaAgAE+O4CAACMXAA==
Date: Wed, 30 Jul 2025 12:32:13 +0000
Message-ID: <2b6578f3fa54feff8d7161e3ee46f204e0ae2408.camel@nvidia.com>
References: <cover.1753631391.git.sd@queasysnail.net>
	 <177b1dda148fa828066c72de432b7cb12ca249a9.1753631391.git.sd@queasysnail.net>
	 <6d307bb5f84cdc4bb2cbd24b27dc00969eabe86e.camel@nvidia.com>
	 <aInzWYscMcTRylVg@krikkit>
In-Reply-To: <aInzWYscMcTRylVg@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|LV3PR12MB9188:EE_
x-ms-office365-filtering-correlation-id: cdf3c021-61e2-44b6-d9c4-08ddcf651c81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkwxNlJUcXZaaTZ2dlZodU1VNnlSeG11d2NXUGFWbmhhN1ZKeDU0TExZWmdn?=
 =?utf-8?B?R2RUWXFycTdNa1JRcXB0RWpnUzFJYW02Q1ZOclJRUzZFR0t2Sk9wTGVpaTJJ?=
 =?utf-8?B?Z3pySFA2S2hNTy9oWjJEWGpLU2ZFNTR3VGtYY3VPWWNvdXZZVURlRDE4RG5n?=
 =?utf-8?B?WTNIdHljeXRjNFIwelhxR1BSTnBzN0pDWTEwajdBQ01OTDNCeGdOY1d2WHBl?=
 =?utf-8?B?SmpUVGlXTU5QaVlyY2ZVSmw1RU5Jdkd1UjFia3FiSXp3YkpiUFU4NUcyUkdZ?=
 =?utf-8?B?SzAzZEk4TFlHMmJ5c0NnYzRwWm1UVlV5bnhaTDJpVGVJKzFNNXNnMFJwVnNq?=
 =?utf-8?B?RmZNcWYzT3hBZE5FUTJIRndlUVhJdnBVb0hYcWMwdjF0SnkyL2tvcWs4ZTFs?=
 =?utf-8?B?T0UzRmhiUEZwc0w2YTk5TjVqTUxrbEQwcmtxa0poRTdoeGU1S1hGckZSU0V2?=
 =?utf-8?B?dUhpSG8zMHJzNkY3Z3VxcXRzOXVLUzFMZ0VuWVYzOWVyc0tXa1djalFKSVhE?=
 =?utf-8?B?ZTYwN2VxNHRmSmVid0pJR1gweitpcm9TTDQ3QmdCdENUVWRSa3QxM3R0b0ZO?=
 =?utf-8?B?TmRKVGVHam5KV3Z1eEl4dUZDYkN6aFVpWEtOcnBCaXJMRk9rVWt5WWt1aXZB?=
 =?utf-8?B?YzJHakgxWDArbksvaHE4UUJUeVdGeVE3SWEvaDhUTXlOTXQ1clVMSUd3QW9C?=
 =?utf-8?B?eDJqU0NrN1lvMm5CaFNBalZGR2dzNi8xOEt5cStJL2tEUG9GcjVsNmt0NzYr?=
 =?utf-8?B?WlRDekE2Ujl4cno0MHpHbis1NEdibDRMbzF5Tkt3Y1dobnJRYmdlYmNaYzV1?=
 =?utf-8?B?WksrOGFmNE5Ub2VsSW5vVGlFdVVyUUF2ZzVsVm14ai8zNjJidXd4TklkSUlM?=
 =?utf-8?B?T2U5QjlqWEM4QThyaWk5MWllUTJ3a0p4bjJVZHpCZmFtek8zMkk4TGFNRldz?=
 =?utf-8?B?ZjQwNVNqNjB4YmdGcEhiRElWQ3EvZWpOTHAyMlVBVnUvenBxSnlwMktBZUJ5?=
 =?utf-8?B?bWR6QlVKQWVMRTdaTDk5dDJGVzlCemxsOWxsb0JqY25DU3lmdENPTXVXWWJT?=
 =?utf-8?B?Mm5uRjdiM3NWSTRFOXdYeEtCTVFFYTl0blE3QnhHN3JwY0ZtN0FDaDRQUW1W?=
 =?utf-8?B?VHJVVTV1eGhqZ2JQUEVzY2RGRVZuNy9hRWpxdG1ONGpobE5pM25ienZ4b08z?=
 =?utf-8?B?NlA1Q3g5UkVxTXUweUpHT2Ftd0taYXpud2d2bkc4NHR6OWRheXdBN0hVQVFN?=
 =?utf-8?B?Y1dTUXBaL203TGdQRU9OM3pjU1dVNWttbFRWZzZ3OUkvbWNJMGdYRFZnNnFB?=
 =?utf-8?B?aGh3V2lDN281d056UDdBcTAwaERPK2hQRmNIZE1vNy9Gbi9SS1N0VEFYOXJs?=
 =?utf-8?B?cTUzWlZPRURBdlFvVU5lNEpTV0ppSW14TThlS1RrYzdFTld6WjllNGRoM2J4?=
 =?utf-8?B?d0dBQTdLRWJpRXVSc0VGMmNHelBVbTB6Z2xTMDJwdnEyakNiZnBya3dQMmJt?=
 =?utf-8?B?bkh0VkljcEpKa1NhT1NIZnYwVFRWbm5za1pVZ2k3L00ydGp6WXZ6dE9iTnEv?=
 =?utf-8?B?TkZOVWlRWGhuZ2JCTi9YanJEMngxeUxDMkhrWkRrNk90a0ZrU1QyQlB4czYx?=
 =?utf-8?B?Sk0rbjBuVk1rMlhPUWwxYWFlUDNndEY3ZkNJN1Bvd0pXUWpuc0xsb1Z0Vlhr?=
 =?utf-8?B?b0NqTUxwYTZneDU3Q3BZOUN4ZGd0K2prVlBsbkZOMmtGVDNYdVE4TVZRcXkv?=
 =?utf-8?B?WjRpclMveVF0QUp1U3JaWXg5WTZrSWt1ZWVOMzZuRTFWYTBNWFFZdi80OVVw?=
 =?utf-8?B?dTJ3UThEQUE4RTZNQ2tQZ1dBSkQ3bDZqVHhKeVVVU1J3QkZ3TkZyUytOaDhz?=
 =?utf-8?B?RElnbmx0ek16bStkeFY3djcyUHo0V3hZZE9WZ0pEZWZoRFhQcytlSERxY21C?=
 =?utf-8?B?dU1aMWRqM3VnUzhIak0wNDEwWnZBdnVlYW52UWhNZVl1RkxpZUdWZFlGTjUw?=
 =?utf-8?B?ZzM3WFNYalJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1BMRDlGdXJuWkxhSEE4OUY2L1VPbzlrVXJOTXU2dStqTTNHem5qU2JZNGQz?=
 =?utf-8?B?N0ZvdExScUR2QUFubnN4Y3RZU3JTM2s2eFFIdDFjQkI0TGI5VUMxaGVIU3g5?=
 =?utf-8?B?ays5SWY0Ykd2NTBsMWlWaDExL3ErNWp6a1lBcVM2UUROSlhDL3UyT3ptbGQ2?=
 =?utf-8?B?V1U0WnJPUTY1djNuRlduZ3FUK2JMWUEvSitVaE5GNmpXZ2VLRVFnM1RSZjJu?=
 =?utf-8?B?aGtCOXlyRzZmdTd3TGNQSnYvNktWWFRoWEcwbjcvVy91ZEpqbjNYaU5vTEhB?=
 =?utf-8?B?M1J4NDB1VW1nTkEvYzZYajNFdkdWcEFFNTY4WEpqNGRCemRkRkJyTnN0RkZj?=
 =?utf-8?B?aitlSkcraE1obVdWeXRhMmR5TCtVT1h4cllMYU44S29STHhmV3RJL3J0Ujlt?=
 =?utf-8?B?dFpEZEdLWkszSHFEV2o5VVAzbUlPQnN1R0xhZExnNUdEaEpab25uOUxRN3Fa?=
 =?utf-8?B?bFd3akNwanN1Smh1Yytodm5TVFh6eDJ4R21hMWVzdnIrNi9aeFh6Sytud3ZD?=
 =?utf-8?B?QmhQOTFUOHpvc1VmaDd5MkxiUUFXNFNzMEh2R3BZSmtUV2k0TTYrN3pUc2lL?=
 =?utf-8?B?TU5ySnFaTUFlUjR3ak5hcUc5bU93akNPb0pGd25sRTlONFBjWGN4b29iNzVZ?=
 =?utf-8?B?blVVZEwrMWZTb2lTUDFmaUVSMVRDMllGdDdsNitRSjdCbFhkbi9vS1pLMWp0?=
 =?utf-8?B?UlhYVWVLa0ZNSnFnVU5RL1dMVjFxL0MyZm05dTNtRU1SckR6YldrazhmYUdi?=
 =?utf-8?B?NzBHRERacnVOcko3MnFVcWZRNkx4N2svOGR3bm45UXZhNWF6b2JLeHNINjl6?=
 =?utf-8?B?N0NYTmFEa25pb201SmMrdTJRZ3FTN09nRkIzalZVYVBkSVhvcm1iRlBhZkQw?=
 =?utf-8?B?amNVS0FXci9RRURiNUxNODAxS2tnZk5VNjBpY1puU2JrNG1Mb2p4bktzZnBV?=
 =?utf-8?B?blVRSzBRZG9WRkpoenQ1Z2xMbmJzcEJ3WkliRUp4eU11WTQycXJPS2cwbzN2?=
 =?utf-8?B?K016dGtvTitJYTZaNWdIanBMQTVUd2VERktiWWdmUnA2M2x1cEJrb29PTEFT?=
 =?utf-8?B?WTRTa29zN1Z2cGU2YUVheVVGeVpOalVON0wxcHVFaFRrVUdnd1RaK2pzWS9S?=
 =?utf-8?B?Qm5MeDNBS1hya0JMTVdCWDVWK3U1TFp5c2ZUVzZjYjR3bGJ5YVpFN0JlbjdQ?=
 =?utf-8?B?OHpYMzJMRngzQmNyZ1d2Ym00MkFPYXNyM21nZTY2T0xHeFZyQmMyQkhibXoz?=
 =?utf-8?B?VUFRU2o1SWhGTVJWYXhJaXl6bzVZT203MnJ5U0lUVytkSGUzeHFDc0JOV3NV?=
 =?utf-8?B?K2pLNTRIcUNNVzgxTE0vRnhVdGgvVStBZjBMblY2SEpneFdlQ2UrVzZhYUtS?=
 =?utf-8?B?NXZrRjdLcXNsYmN1NmRISUpYUjBRc3ZYYmY2UHhELytvajlGUmx0NHc2YkU0?=
 =?utf-8?B?Yzd0bXdVYmY1TTA4VExZazlUTG4wL242YVZ3QTdNTnFzRzc0ZFpqa2hRWDdE?=
 =?utf-8?B?N0tHZ0pXanMxZXYwU0N2RzA3R3BBdkdjdW9TOEZBOU8rSlJFMjMzSi9nM1Mx?=
 =?utf-8?B?OUt5Sm51Y2JyZ2xGNFBEYmN3UnVvL3h5eGk3Q1lkRFFSK0RTK1NKQi9JY2xz?=
 =?utf-8?B?aW1yZTFGYys2MFVqbkZZWEk3MUZNQlpGS1pja1J1R1MvV3FmZ1k3M083OXVK?=
 =?utf-8?B?T0Q5OFBxV0tLd1pQWHAzWFRoc2dST2ZhUld5TGNrR3dPT2R5MWJOKzluNU9D?=
 =?utf-8?B?bHN6ZUFGWnJxd3hmTzJnb0JXbmpUbnJGRFRaN0J3aUkrVERoT3EzRFNCcXVh?=
 =?utf-8?B?ZWs1cS83TyszbFZpcDhtQVJqdG5pdmpwS1pSQU5hZ09TeTZxc09mMDNWVU9N?=
 =?utf-8?B?SjhOYVJVSCtPU1gzWDNZems5cHlNOGFlczJFSHR2QmNtUGlTeHJOMXFjdDZl?=
 =?utf-8?B?U2hhUVFmbGdROWlqYy8wU2VhV3UxS2wzeVE1MThESzdXKzhQMy9LR2ppZ0xn?=
 =?utf-8?B?RzR5VXdhUEgyeG1SenVkWnlEMWlXYy9rUkEzdnVXZ1hTUnVrWnFERmJURXhj?=
 =?utf-8?B?SUF5Z2FtTkc5L1RZRmFDbGZ0bmI3S2x3Q09vbEJ4cFNjc0NzcDAzNm5DNHJW?=
 =?utf-8?Q?Q+m4QtiRFFhkF8kQceYYPRqUd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42919C688225644895A0DFB3B120EC17@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf3c021-61e2-44b6-d9c4-08ddcf651c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 12:32:13.2985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9pia+7CAN3Ld6KYtrvENP4HkhIK/L1V1hJyENobw7D/JpzzEMQPFm/ftRRrheIz4fv8rZLgVLrUaOQs4Wb0qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

T24gV2VkLCAyMDI1LTA3LTMwIGF0IDEyOjI2ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjUtMDctMjksIDE1OjI3OjM5ICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4g
T24gTW9uLCAyMDI1LTA3LTI4IGF0IDE3OjE3ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+ID4gPiBUaGlzIHJldmVydHMgY29tbWl0IGQ1M2RkYTI5MWJiZDk5M2EyOWI4NGQzNThkMjgy
MDc2ZTNkMDE1MDYuDQo+ID4gPiANCj4gPiA+IFRoaXMgY2hhbmdlIGNhdXNlcyB0cmFmZmljIHVz
aW5nIEdTTyB3aXRoIFNXIGNyeXB0byBydW5uaW5nDQo+ID4gPiB0aHJvdWdoIGENCj4gPiA+IE5J
QyBjYXBhYmxlIG9mIEhXIG9mZmxvYWQgdG8gbm8gbG9uZ2VyIGdldCBzZWdtZW50ZWQgZHVyaW5n
DQo+ID4gPiB2YWxpZGF0ZV94bWl0X3hmcm0uDQo+ID4gPiANCj4gPiA+IEZpeGVzOiBkNTNkZGEy
OTFiYmQgKCJ4ZnJtOiBSZW1vdmUgdW5uZWVkZWQgZGV2aWNlIGNoZWNrIGZyb20NCj4gPiA+IHZh
bGlkYXRlX3htaXRfeGZybSIpDQo+ID4gPiANCj4gPiANCj4gPiBUaGFua3MgZm9yIHRoZSBmaXgs
IGJ1dCBJJ20gY3VyaW91cyBhYm91dCBkZXRhaWxzLg0KPiA+IA0KPiA+IEluIHRoYXQgY29tbWl0
LCBJIHRyaWVkIHRvIG1hcCBhbGwgb2YgdGhlIHBvc3NpYmxlIGNvZGUgcGF0aHMuIENhbg0KPiA+
IHlvdQ0KPiA+IHBsZWFzZSBleHBsYWluIHdoYXQgY29kZSBwYXRocyBJIG1pc3NlZCB0aGF0IG5l
ZWQgcmVhbF9kZXYgZ2l2ZW4NCj4gPiB0aGF0DQo+ID4gb25seSBib25kaW5nIHNob3VsZCB1c2Ug
aXQgbm93Pw0KPiANCj4gQWZ0ZXIgcnVubmluZyBzb21lIG1vcmUgdGVzdHMsIGl0J3Mgbm90IGFi
b3V0IHJlYWxfZGV2LCBpdCdzIHRoZQ0KPiBvdGhlcg0KPiBjaGVjayAoInVubGlrZWx5KHgtPnhz
by5kZXYgIT0gZGV2KSIgYmVsb3cpIHRoYXQgeW91IGFsc28gcmVtb3ZlZCBpbg0KPiB0aGF0IHBh
dGNoIHRoYXQgY2F1c2VzIHRoZSBpc3N1ZSBpbiBteSBzZXR1cC4gSSBkb24ndCBrbm93IGhvdyB5
b3UNCj4gZGVjaWRlZCB0aGF0IGl0IHNob3VsZCBiZSBkcm9wcGVkLCBzaW5jZSBpdCBwcmVkYXRl
cyBib25kaW5nJ3MgaXBzZWMNCj4gb2ZmbG9hZC4NCg0KQXBvbG9naWVzIGZvciB0aGF0LCBJIHRo
aW5rIEkgYXNzdW1lZCB0aGF0IGlmIG9mZmxvYWQgaXMgb2ZmLCB0aGVuDQp4ZnJtX29mZmxvYWQo
c2tiKSBpcyBOVUxMIGFuZCB0aGUgY29kZSBiYWlscyBvdXQgZWFybHkgb24gImlmICgheG8pIi4N
ClNlZW1zIEkgd2FzIHdyb25nLiBPbiB0aGUgVFggc2lkZSwgdGhlIG9ubHkgcGxhY2UgdGhhdCBh
ZGRzIGEgc2VjcGF0aA0KYW5kIGluY3JlbWVudHMgc3AtPm9sZW4gKGFuZCB0aHVzIGFkZCBhbiB4
ZnJtX29mZmxvYWQpIGlzIGluDQp4ZnJtX291dHB1dCwgYWZ0ZXIgdGhlIHhmcm1fZGV2X29mZmxv
YWRfb2sgY2hlY2suDQoNCj4gVGhlIGNvZGVwYXRoIGlzIHRoZSB1c3VhbDoNCj4gX19kZXZfcXVl
dWVfeG1pdCAtPiB2YWxpZGF0ZV94bWl0X3NrYiAtPiB2YWxpZGF0ZV94bWl0X3hmcm0NCj4gDQo+
IFNpbmNlIHRoZSBjb21taXQgbWVzc2FnZSBtYWRlIHRoZSBpbmNvcnJlY3QgY2xhaW0gIkVTUCBv
ZmZsb2FkIG9mZjoNCj4gdmFsaWRhdGVfeG1pdF94ZnJtIHJldHVybnMgZWFybHkgb24gIXhvLiIg
SSBkaWRuJ3QgY2hlY2sgaWYgYSBwYXJ0aWFsDQo+IHJldmVydCB3YXMgZW5vdWdoIHRvIGZpeCB0
aGUgaXNzdWUuIE15IGJhZC4NCj4gDQpObyBwcm9ibGVtLCBnb29kIHRoYXQgd2UgY2F1Z2h0IHRo
ZSBhY3R1YWwgaXNzdWUuIFdpbGwgeW91IHByZXBhcmUgYQ0KZm9sbG93LXVwIHBhdGNoIHRoZW4/
DQoNCkNvc21pbi4NCg==

