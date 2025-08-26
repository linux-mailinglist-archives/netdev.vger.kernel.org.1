Return-Path: <netdev+bounces-217094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7228CB37592
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30153361968
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119FB27B323;
	Tue, 26 Aug 2025 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GM2Usx1P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D58E269CE5
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251208; cv=fail; b=MWb2RyK0l3caiAo8igBP7/ToiSKquE1Mak4VJrG3viAlpCRZOuibi1ZCpUUeAxHBs4Zn1QL1AYzZ+KqnmxIqJQhl8oIoEsrgt2odzPS+toUE6RkEPYIHQ7M5eGAxR27DorZ+nYzsasC3NW2iQepThQHAS5a7opKzltI2t1Oc3dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251208; c=relaxed/simple;
	bh=1aJd6E6tKqXAWmfMRWNsq4w56JibUx3AZF3f1nfibrE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LtQrnwqLzl/mcbf3j3o/8qyELirTBE911fBsPQw5h/MZOcJYwyF6A2pIAv2Jo0kJzQZaqtHGsKQzOIHLoUhNsdsoHahGQCwPgv2i0HII1ZxjCWuuys2J09do6pELUnoanyMzy+NdWhMdimxSRlkue0Q9eFVakwZhalWdvHflDfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GM2Usx1P; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756251207; x=1787787207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=1aJd6E6tKqXAWmfMRWNsq4w56JibUx3AZF3f1nfibrE=;
  b=GM2Usx1PG/IDOHJPQ4s02dV8rGlih6G9tMGXTdVYE/AQuNPX39yV15Iy
   d3xkIW+MnwUlDPeGp9U09GYRsyJ1nHqaTvBSGfsqkwHAtyZvO64bp51NH
   aMlowuytIfjWID/sx27dMTY5N6gtVIRaexi/Per+zr14WL3v6gFGbZRCN
   cDW3qbDZtKTDQvQR1lGhBeq68+2HpTh6qRYe1NUQAudlp/bENrZJGAXWJ
   XZ6Tf9+2tsvNCrrsE2qTseELuRMZq5wm624/0r6NencplMtmXryNfBUHt
   MXcI2v6WqpUGq4NMY1PFZTntD0vXJix+cj6XO59oWXhn1t5wthF+MYVf5
   Q==;
X-CSE-ConnectionGUID: gDVP45KzRjqxFX6Qx38wgg==
X-CSE-MsgGUID: HqjBpKAKRMGvZrGqbH1IBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58653142"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="58653142"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:33:27 -0700
X-CSE-ConnectionGUID: 0J6QN9yGT9G7M/pqR43D/w==
X-CSE-MsgGUID: +j1lqB3YTW+oQt8pRbhcOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="asc'?scan'208";a="169634612"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 16:33:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:33:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 16:33:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.61)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 16:33:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uklq0i6ESW+gpbjm43dyUTrtOjROd/GrFn6NZIV9IRONeTs2bgHJXcwqBsu7k8a8XF3R4HeaeqoXURYYEOhPg7j9tOtXgAJbuWCeNKyHePBRD6LTkHFeCpljTv09jM1OH9hPUHvduTuU7kUmkfaEz+REcbFBIZf1zUixV1pbkGK6B7s8dXtPbpFkIDz94dXeRFCsnAjzi0bNJB9jkUhQfn/6S0Fy4AoXRp7T1iC3IxEladepRH0M4HppffkHdX+pA/yaFrPHJBx8x4fZlySr56Amzn+1viPWckU0cuONhR5wodYqfEeUYO6bwYzwZrafkgWH4X4YHj1ygrGyphIToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aJd6E6tKqXAWmfMRWNsq4w56JibUx3AZF3f1nfibrE=;
 b=jVpO99/qJbsB5oa6QFqbuhYwmGfnQVxr8RUcCHoBBh+9dNq7Oy2nqntN6UUj/Jqwn2YA8cjERcFWwiHZEOuzSWZZkIaNxZwnm4hsgzwdFDENtjc4SwANTatCpssqOHL86kN0p47nvC4GUMQYDmKbn7KGn1qR82gk2L96lZT3Av04/d3Y+F5NClcV2EhhzvYk2bIZ0Yg1xzkkSrLML8xa29ANbM2iw7xd7+3xWsQmlJPjQEQ4EnYFqvAIQLPM/6Q8i4Zwq0dsDfYWc8CtDJd+2jq5ki1Lk8Je/QspM8PXeWqkOhmp5ezHH+N1evgHowv3TlKjjGLIYWsrOeQK2TowXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6128.namprd11.prod.outlook.com (2603:10b6:8:9c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Tue, 26 Aug 2025 23:33:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 23:33:16 +0000
Message-ID: <63d66bfd-c082-4bc3-9797-5c91b972cb1c@intel.com>
Date: Tue, 26 Aug 2025 16:33:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/6] eth: fbnic: Reset MAC stats
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <mohsin.bashr@gmail.com>,
	<vadim.fedorenko@linux.dev>
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-4-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250825200206.2357713-4-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------0lVhTl2xdqoQcBQ0C5MiQxS2"
X-ClientProxiedBy: MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d60bdf-ec2d-4ce2-7ae3-08dde4f8eec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NURHeFUxSXo2VU9sNmtRSER4elFJOURzR293N3E4eTIzdHhDYU9QUGo0NlFl?=
 =?utf-8?B?UWpVTDIxc3NMQTBTU1Q4UDg1Zm9wZThjQi85a09GT2t4M3NiQW1IRGJDdGVs?=
 =?utf-8?B?R0h6ajUzYW9GQlBicVg0VitLS1QrUkdkTkh3TTZNOU01M1ZsRVVUUE1LYVh3?=
 =?utf-8?B?SE5QMWZWUldSMW9objlZMUN2TmpqNnlGSjgycUJaeENWUzIyWGczcWVUL0E0?=
 =?utf-8?B?cXJ3Z293MjN5UUpCd2gvL0NxSWswRzAxM29ERzA1NHVabDVGa2VobDFPOGMw?=
 =?utf-8?B?ajNueGI0cXlIRXVPeGl5U3ZpU3U5MHR5UzFTYW9YNWlmcWZsK3hTUDBPWjZp?=
 =?utf-8?B?ZU8vNTg1WFRzKzdLSHYvbWk5TVZmS3dza082MkxFd1VsMUJLY1Rjb0YrOUxq?=
 =?utf-8?B?eVBocTF3STZEdmNwSGoxZkVZZWhrc0g2ZCtvVisyRmM2Zm9SZXNKc0ZjbmZM?=
 =?utf-8?B?VmFYdDVrS1Q1UUR4MU9XdjJtK0haVjF0MW50eERnalRRUThuTXJvdFA3Y3FX?=
 =?utf-8?B?QitQdW5oVnl0SE1vdVFVR3RMVytsUmxHZyt3UFBYaE1aYmtlQ2RVTGxjN3Fq?=
 =?utf-8?B?VTQyaTZWUXgvM0FlaHl0RHQwaWphWjF0dk9mbXpzSXlzcGZZdHd6alVMa0M3?=
 =?utf-8?B?bHNHWkZLbFhsQU00Mmo3Unp2bW04R05DOTR2aVRSWjJza2FYbDhqS3ljZVF6?=
 =?utf-8?B?VUpNejduSjFkbGNuek9YcGFsU2l6TEpveElJVXduUFRjMlZtcElvSnZtWkZO?=
 =?utf-8?B?MnJPTitGcndKRzV1U1JEZ1YzWDJ0OWc1RGNxQ2JWQ1hpQWhLSmcwTS9YSSsw?=
 =?utf-8?B?eGdRLzQxT0t4Zll0WEswMW1xZHhxc1JERFNMb0xkei9UYy9vS2h0N0c2Wmp0?=
 =?utf-8?B?VS9DMHRCWTRDRWU1eWdiRThkNjVHc29LbG5RNHFBUGhrdEFzV05PSWJnSW5w?=
 =?utf-8?B?Q1FCT25VQ3FsSkdtNU5pTXF4N0dnQ2Z6SjUzTjdNU3NUclp0Nk1tTytjNm84?=
 =?utf-8?B?TXg0OFdzNW5KSktIUVhhZEJ4NTBEQVN3MzRTWXhiT2wzNEZaZVB5bGViemc2?=
 =?utf-8?B?dHZnbkhRWkdrdklGNEFpL29LR1B5bnBCS3FkUk5YMExPcXJ2bjM1UzhMSHdk?=
 =?utf-8?B?eUZ5M1NJbG9reVl3bGZwSWZHZFByUU9vMkczcWEyMHVRcThYN2ZDaStOZFlV?=
 =?utf-8?B?bzRTTnZPZnVDR3Q2OXFRZVZRNFl5cHRwKzhUNU1CMnozek9yQy84RVAyK2Nj?=
 =?utf-8?B?Uzl5SW94UGhLdTFCQTFjVllidUdWTnlDVWU3d05jMG9uS0pVNU55ZTIrYUZu?=
 =?utf-8?B?WGFvUjNEOGlldm4yM0JnNis0Z0JUdDA3azZwc2Z2aHozRjJpZ3FRTElETHU3?=
 =?utf-8?B?dTAvSHRjRnBNckFaZ0lmSnJoQzVyVEMzUnJJWDZ5ZUNWV05XZ1VDVmlzTmw1?=
 =?utf-8?B?S1VYcEJXY2RXYU5rekNSZEl5YWtJM3ZQTXhybGUyV1ZIdzl4dHVUKyt4WHU5?=
 =?utf-8?B?SVcrUkNnMGVuVm9FWEluTHpKTVFBTWJJVHRldUdRMGEwenFmOWRyblJUVG1K?=
 =?utf-8?B?c2RleDhuY0FjSHpwSy9uNkhCNThBSXVjMWhkejhoNnIvQzdGb052OFF6dHNi?=
 =?utf-8?B?ZWFUS3AzbWl4Z0VxY21IVkRiMTlrRXhpUmc5VW1JalNIbTB4ZnRTNmRWZTBK?=
 =?utf-8?B?MEhtYWNpdXp6bXJDaldTWVN4b2FHT3ZWc3NxQkZtNEZHSUFZN3F1T0dtKyth?=
 =?utf-8?B?QmlRNlZrcXVxR29YTmg0QmtLdStYbmcrU3NhV04zTERUWW9TN0pHdWtCY1lt?=
 =?utf-8?B?b3hEdDJlR3lObFJjelFFRHlpU1NrYXB5NVNrcUR1Zk1IaU1RVnVSMnh5dUQv?=
 =?utf-8?B?bDQ3cXVtUG9mRE1mNkRnTGhFemJJaFFBTnkwanpoNGp6djlPcnByQ2ZScm9O?=
 =?utf-8?Q?dG165P+O9Dw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZjTENwVlNVWm8vamdMYUNCaDgwZldjbFhLajVOdWpCT3g5SHVtbmtSZkhi?=
 =?utf-8?B?ZWFvUGNudndUU0JEOWdvbVZYR0xjbDV2Y1hOUHJSZGxORzYyZkovLzBlc2dV?=
 =?utf-8?B?RWh1V2FCWXVCWFY3T3VVRThBUWh3bjhSTUhiSlVIZ0hoWE5sc0ZHRThtd1Zw?=
 =?utf-8?B?MTJCQWxvWFAxRXJERGprWDRtSncrQVFhdmVIVE9CYno5Q2NNcjg1V3dqQnNt?=
 =?utf-8?B?aFR0Y2dSZi9STStWRUZodUVXeTVsYlFkWUo0M2dqamNIYW1zL3JQZHlSeHFz?=
 =?utf-8?B?eVExV2xvbUFiS3VkcTdNcWJJcitJc1JtclJUMndXaU1lZlluMjlldlJwWDJy?=
 =?utf-8?B?ZVVVbWpzMW1HR2lyOUpnaTlhKytoWFRGaVUrU1FzUXFuOEFlam1iNkY3aUc1?=
 =?utf-8?B?UWhVWDRpQ0Q4L3o4ZXRmaUZWUGhNVm5HcThnMUxXZ1pXTTRMVitNMk14Y0Rh?=
 =?utf-8?B?N0YyTGJqdUVCQzVXL2ErTUhFYXJLZmFwVzVBc294L2hRRFBJVTQxaGZKZ0NQ?=
 =?utf-8?B?b3pCSDI5QjFobmt0eGtaYUExZUs3L29jT2hRZXlRZHVWUEppajF1elY5TWJP?=
 =?utf-8?B?RnNNYlFTSzFsdmlFQ3FJSHFnV1h2WmJBOSsvNEpVQUxPREM2ZWFjTks5dDkr?=
 =?utf-8?B?ejd4ZmtleGFxVzF3VURxVzJPdVJRUElrTXRxcUFEQ0poSzN6bTVQVUZ2UUtF?=
 =?utf-8?B?ZFJWVGIvTGtJaGx2MGlTeXhYczV0bFhUTkVicWxLQTRSVDk5WlZQY3pSL1VK?=
 =?utf-8?B?dmxxRytPU3hkWUtUZ25YTGRuU0wwa28wMWlVNjMwN1Z4VGFFM0cvYUc3ZVpo?=
 =?utf-8?B?QXhIWHhibWdZbWJTVmFvbjBOblpicnZ4dDlGK0RDblJuaFJDNDFmSGM1VFpI?=
 =?utf-8?B?NThzQ05zb28xZmRmd3Nta0FmVWtvQjg4dWxTUkhRVjhsWVJwWnpTYnhZZnV3?=
 =?utf-8?B?QkFMeWNkbG5WcmVUdlczUHlhUUtOaXBrMDhFcnB3L3R1Q3o5b2VnNlhuQmE3?=
 =?utf-8?B?dy96NUlvclZlcW1taER5UWNNRS81UzNXeXFEYU43MEw4Y1hXaXFqQ2hjQ3E5?=
 =?utf-8?B?TExlQnhoQlkwNTNlZ3FaZUhGNHZGMjVNQ2dCQ20wOEU5K0tva0dKYW9EM1B2?=
 =?utf-8?B?NjVybnRWYzJyOE5sMGowQVdFRUZRU2U3d2htOU85L0R3VnhweXFhaGNIYzB3?=
 =?utf-8?B?Nzlmb0RMZnBMS05VZEIxc0ExMncvRFAzbHovZStQZTlFa1FaQjZhV29qNjVr?=
 =?utf-8?B?UTRpaWNDektLb2w5bFlGUUFCaHVHSGNwcDJWT1Z0blRuS2EzWFpEcWliaUVm?=
 =?utf-8?B?d2lWQS9YOG9tM2VLQVFqWWd6Nm8zQkYvTExxTW82M3cyYUFnOUhYc1h3REo1?=
 =?utf-8?B?YnhjM0Z3UFEvZkE5SWU5QURxN0thRWZ3ckdCYWtVMHZwYjhiY2hPWURzclVO?=
 =?utf-8?B?anRTYUJNMTFEZnNFWXltb3VLY1FnaFpKSkFBMVdnVjZSV1VIc1VJRWlTbVJE?=
 =?utf-8?B?QkQ4czFnSXNQYVNjYVZlTUF4MFhHSXVWbXVHTWlLWHNIdkp2NUM1T0d0UUI1?=
 =?utf-8?B?Q0ExTy85cWI2R014b05uZVh0elhTekZreHo3S0psUVZUVVVkYmtQZ3YvWW1Q?=
 =?utf-8?B?c2hxb1pTc21WNG1ocDVCTmtHYzJMOWxDaWtGZllEZ3NiL1c1YkE0c2RCdDVK?=
 =?utf-8?B?WmdlZFVLRng5aS9PdEh0WTZMWk4ycXA5ZGRPSGlEdGljQkZkN08yVmRRVkwr?=
 =?utf-8?B?dXhwdDRSSWJGK2FXSlZLOVowR0M2U2ViYkVkeGxHWkRQQ09yQVQwNEN3R3Iz?=
 =?utf-8?B?ZkpucVF6aE1VcXh4OGRzb0p4emJEK3V1ZSs0c05HRTZ6M1Vra2Fia0tVZWpT?=
 =?utf-8?B?REtzMmhFcUgzUUVnNkdLK3Ivc2JqYWlOdU9MTE83emFxOUJsVkNhckhCM0Nr?=
 =?utf-8?B?cCtDS1k1ZG1ncFZ2K29JSGlKbVJVbldEazhzMjRaV2Z3VTZVbXZZa040VTRM?=
 =?utf-8?B?RS83Q3IrNFdYNlRiMHRPSGluK2VOQTE3ZVdiUWV2dEROSDhZWUc3cVNCN2t2?=
 =?utf-8?B?Uk1ZWGhhZ05DWlB6WHc1bnIzeU9qUzNzcVZpeVd5ZU1VNnZmeWpnNHk3VHRR?=
 =?utf-8?B?U3hjTmx3THNOejRxWUlFVjRlNFRyNnJPRHdnUkJQS2psVlNpbzZOWmRXWENE?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d60bdf-ec2d-4ce2-7ae3-08dde4f8eec8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:33:16.7293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIMiJ9JY5iXCeUgAEKt0lWfz2zfpTnHLRTvtLVLlWP9Vo23QctmIMZxVJiXSADi1bZSaFwzFnr7nEzsjnQuNBgX5ZD7m70SVQ8764lgjc8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6128
X-OriginatorOrg: intel.com

--------------0lVhTl2xdqoQcBQ0C5MiQxS2
Content-Type: multipart/mixed; boundary="------------cc0uCbQJ8zLAIA43KNT0880y";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, mohsin.bashr@gmail.com,
 vadim.fedorenko@linux.dev
Message-ID: <63d66bfd-c082-4bc3-9797-5c91b972cb1c@intel.com>
Subject: Re: [PATCH net-next v2 3/6] eth: fbnic: Reset MAC stats
References: <20250825200206.2357713-1-kuba@kernel.org>
 <20250825200206.2357713-4-kuba@kernel.org>
In-Reply-To: <20250825200206.2357713-4-kuba@kernel.org>

--------------cc0uCbQJ8zLAIA43KNT0880y
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 8/25/2025 1:02 PM, Jakub Kicinski wrote:
> From: Mohsin Bashir <mohsin.bashr@gmail.com>
>=20
> Reset the MAC stats as part of the hardware stats reset to ensure
> consistency. Currently, hardware stats are reset during device bring-up=

> and upon experiencing PCI errors; however, MAC stats are being skipped
> during these resets.
>=20
> When fbnic_reset_hw_stats() is called upon recovering from PCI error,
> MAC stats are accessed outside the rtnl_lock. The only other access to
> MAC stats is via the ethtool API, which is protected by rtnl_lock. This=

> can result in concurrent access to MAC stats and a potential race. Prot=
ect
> the fbnic_reset_hw_stats() call in __fbnic_pm_attach() with rtnl_lock t=
o
> avoid this.
>=20
> Note that fbnic_reset_hw_mac_stats() is called outside the hardware
> stats lock which protects access to the fbnic_hw_stats. This is intenti=
onal
> because MAC stats are fetched from the device outside this lock and are=

> exclusively read via the ethtool API.
>=20
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------cc0uCbQJ8zLAIA43KNT0880y--

--------------0lVhTl2xdqoQcBQ0C5MiQxS2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaK5EOwUDAAAAAAAKCRBqll0+bw8o6Bif
AQDn8QEXKY6/1pSNKMa0eVjQM4iPlabc2Po/odNTcpDzwwEAuzlSsN9lFO2vrOOKb0JtChVi3ZKW
wGmcOJegQAtZBgU=
=6QW1
-----END PGP SIGNATURE-----

--------------0lVhTl2xdqoQcBQ0C5MiQxS2--

