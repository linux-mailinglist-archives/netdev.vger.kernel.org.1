Return-Path: <netdev+bounces-141557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F16A9BB584
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320411C20E65
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC621BBBD3;
	Mon,  4 Nov 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBP2c8+g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329561BBBC9
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725987; cv=fail; b=IpNf0EsoG+hg8pATXBvdUizYG0/V2+WoN0Dbw5TR6EC3S+Tr4fb7ZwIAeB+/TlIXYA/XDwYEl3B8NwHgDMVr0cRBlx3nPGkTJgVD7F8cgu01nhVdlrINRG3Kz1/UdUNUMqbYirDjNTE4BHBVkLsyZXmSJ7BWFvQnxuOf7992vV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725987; c=relaxed/simple;
	bh=Ektrkh+37jLMdR4o+cPYz3NkTgOaMBgBMMkxjWu7BSI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RjABApZinQlW8Dau9rXjEReqpn51SMjuwozax+/bECDZ/0TM5EyFYCvuoqeyLuTq9CGCSPR+gtLCwscNqgMwE9TABwleixGTMrSxx7FppKt6GLtEnyM47KgPGyUIavQncGOXD6/OjRGlTSVtKfheqLUjlhUyPnE08Wai9w9pTK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBP2c8+g; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730725985; x=1762261985;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ektrkh+37jLMdR4o+cPYz3NkTgOaMBgBMMkxjWu7BSI=;
  b=ZBP2c8+g9V6TTbwSusa02gdzl5jnc9BvQ2uFUCq7ti5xM5QLaGXfCGg/
   QU3nFkhijjizEgwLtHl83ZnIj9QA02GpMGLdTs1/bywNAtyZyOyoLikPY
   0ef7R7rqdyGZjGLq2ZANZ4d7xfl1vgNqjpmVYhPRm27IkVLV8AREeaQxT
   FOX5z8hhHyRYjt+7jDpxtgnOb0ldHIZraGLlvjBBZMNm7XUTsJ1TtWbnI
   jA3H6AhuxYcwArhGxZWmnm0AWlKuZebGGoV+LxYWqxomcT92ORiwYaXQE
   fwfGoiEuJWYEA/HP4ixRw6izC8lTmd/Q56ab+Yj99AQNH+OkHocDvrmGx
   w==;
X-CSE-ConnectionGUID: omhFgLldTlqA1UPEasxETQ==
X-CSE-MsgGUID: +W334beWTn+BjHc/BTuMyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="41811300"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="41811300"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:13:05 -0800
X-CSE-ConnectionGUID: N749RtfNQky6zAC/BWeQxQ==
X-CSE-MsgGUID: sxnEMbXBRxmTgobuvXVN4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="121119420"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 05:13:04 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 05:13:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 05:13:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 05:13:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ts4R07OxFSVVATUsRPsCRcgMT+uuK1n2ubScMVCJ8Ehq6Tn7Itkzchlavf0Ms5pBLAns4xrstI3V903C/5zWmRGLV+QmM/2bzDghNXuz/lhLf6nanppDtPGGcs+WaiRzcd/QyZjdS+BZRsdoMhZtXfM+vf2BBGke1eSwgFyatXhPPW1Gbg8wF1cv1dCSCj2a/drbbek79aJHQgxVjfNRH7+EpWuv9tH0eq/wVOaIcb3o2tLTB9uUPvx75FHPHkJ4FbdpSAlAkUXz3FUSEUYn09jAjCAMeLwUH5L5vU4wLXEFXqvDC+yDPGHIjIrpO2DmLC5qQ91XuLVBOmUJvzjg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peB7yV5yyD2w8xGpfSMxoq53DPAzrAwU60zxGckaFis=;
 b=g7MTmN4QfZyuRP5/7GEJ+Up9Y7d2FPwYvr9L74MX+x4CamB9B6JGFp3XearWuo3UDncd6c/m2YFbu80uj6RdKXHeVME2oGDKLq3HC0iLgtnMp+Fs7XBeaM9B1n8TV8zVpvsmqnhBpv3ZhVEaqrSnC2x1He+axWG2n2T5DjAnc3kDAR941cKm2w7uIakZMFcBgSaJghwfB5AhKAtysy4h8k4PgFU+EPDMIBurkyPCBXuMlKl3DZq9Lesl5sRo4u8XahHiBffQJygT1RNrHMPhGtydCEyU9GCD6LFlSozYBVIE/Jf9pc8ryCHApZ4K54NlreFmt2ccHUZeBzPbt1bTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 13:13:02 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%6]) with mapi id 15.20.8114.015; Mon, 4 Nov 2024
 13:13:01 +0000
Message-ID: <bfb037fb-ee80-4b34-9db3-bd953c24fee8@intel.com>
Date: Mon, 4 Nov 2024 14:12:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/12] net: homa: create homa_pool.h and
 homa_pool.c
To: John Ousterhout <ouster@cs.stanford.edu>, Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-5-ouster@cs.stanford.edu>
 <dfadfd49-a7ce-4327-94bd-a1a24cbdd5a3@lunn.ch>
 <CAGXJAmycKLobQxYF6Wm9RLgTFCJkhcW1-4Gzwb1Kzh7RDnt6Zg@mail.gmail.com>
 <67c42f72-4448-4fab-aa5d-c26dd47da74f@lunn.ch>
 <CAGXJAmyOAEC+d6aM1VQ=w2EYZXB+s4RwuD6TeDiyWpo1bnGE4w@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CAGXJAmyOAEC+d6aM1VQ=w2EYZXB+s4RwuD6TeDiyWpo1bnGE4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::21) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|CO1PR11MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 0650fa1d-20be-4b0f-21d0-08dcfcd26927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHJ4cGoyVVRzSTM4M29IT05zRmVGajdZRWZDNVc5dnh2NklBYy8xc1RQa0lz?=
 =?utf-8?B?c3pRdTBWUUN1TTI2dHZCV2JSSFZpbUVFLzhvM2t3WThCbHhib0s1Rk5NUnps?=
 =?utf-8?B?OWF5OTlzQ1JvMmk4YzhOL0pZRFJ1S2l0NEVhV0tCTjd1Q3ZGajIvOFhEOE5P?=
 =?utf-8?B?N0ZTd2txSjVHOUFkMlZteE9RMjI0L3kxSy9vTXBPMFRGaW9kVE5CUUI3RWc0?=
 =?utf-8?B?amYveFNiWGdiZERTL1Bjc1QrTWEveEN0MWtPZVdtSlQ2SG52QS9mUHpXeFlv?=
 =?utf-8?B?UUZBNXlnTW16QjhvSGZhQjVDWmR0a3R5TVVSZ3hncVQxaDNKUmlpTlhIWmJC?=
 =?utf-8?B?YjEvUmo0aGwwbzV2K1JLR2xCeDEzMlpST0xmaWpCTmxZdEdOUTcrV0JLR3k3?=
 =?utf-8?B?UGU1dHJuOGIyb21yVEVrUjduOE51MW55MjBONlBKYVdOeEwvU0l5QzVvdVZK?=
 =?utf-8?B?Skd1dkVQN0Z1bzlubktDQmFYTEUvTll4bzRGZk50SzRIdWxZOEZJc0FZbGkw?=
 =?utf-8?B?ajNyN1RVSGQzUU16QS9sOHdyWHNPRW5yUzU1cXZob1NFcnozSVJUVHVaQXF1?=
 =?utf-8?B?bmYwYTU0a1MwRUFack0xa0ZaU3pTY0NSelhXTXkrK3lVbnlxOEErN1dlS29K?=
 =?utf-8?B?V2hWZFpsdmVTbzNXTU5GZDB4QXZVZm14SzEwR3dNam1mY3lmdDNjNzJVOHJj?=
 =?utf-8?B?YXhqV1ZFUTRDTU41SGhITHRhWlNCQlZ2S29qbUovVVl5bzRrN2JJbmxzdlVi?=
 =?utf-8?B?MlZ1TTlIQVpFMUsxTWhmZ01od3duVzdSbjBPYlZXc3pNMTlpVElWeFNOVmhU?=
 =?utf-8?B?bktLWmVIUjB6R2wvaXFNMk13NWZud3dWcFBSRXJnNkRMQk51d094TXZzRjVY?=
 =?utf-8?B?d2dRMzJBV1ZzOHVqVVo5OHFwSGttM0Njb2packRDdHZRdS9OdkxrNkJIYjZJ?=
 =?utf-8?B?M1M1TnJMeGRpeC9VaEhLcjZoWm42N3lLaERFbmFSK2ZnZFVxRHlXdmF4RThk?=
 =?utf-8?B?bkdNNTNyUHVxSEdSSXEwUjkraXhzYjg2L3cvRm5IZFI3UlpiNzZheTRxV3BS?=
 =?utf-8?B?U05TWStlUDhkZ1lUVVFCZmRlYmxraUNyUHlLNWJiMGFxY09vejJ2ZEIybysw?=
 =?utf-8?B?aUxucnJFQ1kzaHhjb0J3blpxbkxNU1R0MTlDNFhBem1PS3RpQUVFVHFJUjEx?=
 =?utf-8?B?Rmo2NEY1bTBybVl5MFRUMDBEUTBCZjZNWGQrbE5BRHVlWjZEMEt5cFUxOWZW?=
 =?utf-8?B?aGlEQ2VJTURLTmM5OXVnM25TTmExVENlcGFLejBnNGRLdi9yOEJqNk0zRFVY?=
 =?utf-8?B?VFE1NnRFcm5jYkJxTUUySUQvSzVLSGFGQWV5WVZIMksyVFFWSDF2b1lVTHRt?=
 =?utf-8?B?THZEcTEzVlQzTU9IdVRDTkhEREFuWEphZVg4MVIvNGtRS2JteC81WkNFZUFI?=
 =?utf-8?B?TDZVSVFvbEw4NEl6andqWk9uM2VJSGxTV0NRN0xha283Y285WXFTSmZWZnZh?=
 =?utf-8?B?Y0d5V1BUSzFiaUpjZUM1RTc2dVNsdXMyYXJaOEJaN0xUZXRTVVV0SkR5ZVZO?=
 =?utf-8?B?Z2FpSVFseE5xeEE2Uy9tSFJKWVYwbzVqbzBnUStPSjZXUUQ0UUpVZXlQTSs0?=
 =?utf-8?B?TFhrcTFBWFE5MzJTc2pHeEdPL2tFckprYndGeXVXbjE4cUVwVDJxZ0M0MUZ6?=
 =?utf-8?B?Y21CbjBraDI1TGxVSEd1Znc3dmw4cm5EUmdhYVpGallYOStKOS9TK1BKMXdq?=
 =?utf-8?Q?OXcSnaAvFiCdBsLHoaTlzDD5ViwRrp31MDoTR6G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJIajBvL0pySkFsUm43aE9YVGQwK2tSc0laNWFDZmEzV3lDS08vUXJOUC9C?=
 =?utf-8?B?ZFppaXM5bkd1R1p3S0MrdkVxbHdaQSs1Y2oxMEV6QW14ZTBScm5ZQXI1Q2Va?=
 =?utf-8?B?dDZKSmt5Z1NzSTdZZG1BQVFwNDBiZ1hzRmRPNDNlckMrVkxpVm5pbzNpVVhX?=
 =?utf-8?B?a3FraUZoQVd4bzNWemw5UWs2Tm16bTQxUE9jM0w5cytJSGNhTVBLSTVBMVBp?=
 =?utf-8?B?cU95VnBOVENWSFlLOFhDcFZDWk5iN2d4YWtaZlBsdXJ5bFN4c3RHcHM0TmxQ?=
 =?utf-8?B?V1ovUy9NUytwZk5rcGZPUllvcno2KzcvNG1COThYK1lZTUVadFE0Um9Pcng4?=
 =?utf-8?B?TW94ekdSOWU1amh3azVlZGNzVXlBaVZSRHJrbTFNWjNId09Zci83KzVUb3Yy?=
 =?utf-8?B?NTNRcEQrdHRBTlFjZFQ1NWl2RC8xZy91cXpNaW1SYXhGQUhWRkZ3ZmRXQm1n?=
 =?utf-8?B?eWo2UitsMWt3VXluS293YmN4REFGanZwNUdFL0lXd2szUWNUL0ZtTldSYUZD?=
 =?utf-8?B?bU93a3NCNk9DRmxmTElBamlRdUNKNnQwaFE2L3BDUEhSVVZBZ0pUOXJiN1Y2?=
 =?utf-8?B?QWhsZWJLeitPTG9lNCtBbDlXbVJaSDlVckZMbXJRUkxQRGpiUklscjlZY3Vi?=
 =?utf-8?B?MGlMWW9kdEsyZ0V1Q1h1NXRMc3FCeVBORVhKb0M1TlByRmhSVllId1VHcnRi?=
 =?utf-8?B?WWVoMS9JSGRvOTFCN0VleC9Da1RKei83anJCRUZuZ1hjQkNmOUVTNU9rbUlj?=
 =?utf-8?B?M09yYUR1WE9ESXZkeTBBL2hPdnNQSXNqZnpDQm9rL3dBRnhKT0JDUVJxZTcz?=
 =?utf-8?B?YTA3WCtWZ2ovVkpLU1lJNDRnMzBrTmx3WHJaY0Yyd2M0QmRieTdUOUJzd0Vr?=
 =?utf-8?B?dWFvRHR4eGxMWUg1anc1WFlSbzN6aEVSRlVwVTlTZWV6cWM1RDVDalZUVTdO?=
 =?utf-8?B?ZE42eFlpOURXZlhxaSt6dXdvbkY4K0tvMC9xWUN4NXgvY3dZSDRXMkxidENF?=
 =?utf-8?B?aVF4NzkwNFBXbnV6bUE1YlhVUmx0N2MzVWJ6RUFvWG05eXppUm9WakN3azNV?=
 =?utf-8?B?YkdjeUE4TTJiNUswdXBQS3V3S29uMGVwQ2Z0eWJ0ZDN0cXdVSmJ2Znp2N0F6?=
 =?utf-8?B?YzliWTlhcDNiWmRLTytZUUVUTmtxeXRjVmo5RU1wOUZJWUNQVGREcE1hL2Zp?=
 =?utf-8?B?czJQYjU0dWlkdTF0RHZnU0pMVk1BLzlzVWZZTkw2Tm5QVHlHS2tEbUxtcVhE?=
 =?utf-8?B?Y3NHcUlXT3NNMWpjWndBZXlZSWFlb1ovbStobStjOGszRG8reUt5NVBuQXM0?=
 =?utf-8?B?Q2NNaGxBNCtyS2EyZ3FmRys1ZDh6MkY2YWlYZ2k0bXZnb1E1Y1VwejIwc1Nv?=
 =?utf-8?B?aThxOG94aXMyZ0RPRjVWd0l6WnlDSlMyOXdhSDdIaFhFREFaRUxkSTZqMW45?=
 =?utf-8?B?bnJ6VTNQc1JLckZkMTBScERJdUVITWczeTdqTUJIdEFxSkxlL0hHSEhtWElI?=
 =?utf-8?B?eXE2VE10Unl6NStmOXFEMzUxTk5HRWlGUU9yMW5kbnRMZXdOVm84cGI0YjlP?=
 =?utf-8?B?MnJHREp2RmcxN1RpNUVlRVZVYUJZZUpieXp3ZGd2WnQ3VCtTSGZYdXllVWM4?=
 =?utf-8?B?VFpSblZYeDNvTTcrWWJSRjA0cENxU3JDazl4SGlNcTM5Zmx2N1J2REIxSVRi?=
 =?utf-8?B?ZjNtOW84ZFN5TVVLMTYxenVDVDFic29oaEk4em9PTG5jQVNDcmt2OWRLU0dE?=
 =?utf-8?B?YVZ4TXRaWmM1Y21hU1lzbGJaRks5WVZSbXRFOS9HcDZPQkgvbTBNT05qUnBu?=
 =?utf-8?B?RGVjWGpKcDRBQm9WcEw5Sk9TQ1M4Y0Y4djg5N1MzRkl2eWc5UUh2Mjk0cXlr?=
 =?utf-8?B?ejZ3TlFpK0k0b0lmZEtLVVpqanhVNS85cjJYS0FGdGdEMENLdjBBRTRVTHFm?=
 =?utf-8?B?elIvTmI1YXRIdHluMTdvOEljT1V1VUg1ckRxU1NCVERNdUM2NFVzcWkyaDQy?=
 =?utf-8?B?WkJrbkYvNU15NldiOEFiVlpudW41SG9jL21qMlh5QjVmUXBFVXE3MUxYekkv?=
 =?utf-8?B?TjRrYWwyY29RQkxNb1Z0QkxRTk9Jd0xCSGpSZC9BRlkrTm9QbzFqVlhXeUVr?=
 =?utf-8?B?UmdDcno1dXY5TXBjM0llekFRcGJzRjhBWjd6V05wYk5WNmxqR1ZnNE5Geklr?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0650fa1d-20be-4b0f-21d0-08dcfcd26927
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 13:13:01.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgLYNK/K3shbmpPnFrzKUw22Em8jrW3I7V5XzJ93oOWLPuWExm2kPU3omhM2YHaJX/0M0Nm4rv1HFRUVge3g9HPs1QOSVN1+afv7Kbupy+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com

On 10/30/24 16:48, John Ousterhout wrote:
> (resending... forgot to cc netdev in the original response)
> 
> On Wed, Oct 30, 2024 at 5:54 AM Andrew Lunn <andrew@lunn.ch> wrote:
> 
>>> I think this is a different problem from what page pools solve. Rather
>>> than the application providing a buffer each time it calls recvmsg, it
>>> provides a large region of memory in its virtual address space in
>>> advance;
>>
>> Ah, O.K. Yes, page pool is for kernel memory. However, is the virtual
>> address space mapped to pages and pinned? Or do you allocate pages
>> into that VM range as you need them? And then free them once the
>> application says it has completed? If you are allocating and freeing
>> pages, the page pool might be useful for these allocations.
> 
> Homa doesn't allocate or free pages for this: the application mmap's a
> region and passes the virtual address range to Homa. Homa doesn't need
> to pin the pages. This memory is used in a fashion similar to how a
> buffer passed to recvmsg would be used, except that Homa maintains
> access to the region for the lifetime of the associated socket. When
> the application finishes processing an incoming message, it notifies
> Homa so that Homa can reuse the message's buffer space for future
> messages; there's no page allocation or freeing in this process.

nice, and I see the obvious performance gains that this approach yields,
would it be possible to instead of mmap() from user, they will ask Homa
to prealloc? That way it will be harder to unmap prematurely, and easier
to port apps between OSes too.

> 
>> Taking a step back here, the kernel already has a number of allocators
>> and ideally we don't want to add yet another one unless it is really
>> required. So it would be good to get some reviews from the MM people.
> 
> I'm happy to do that if you still think it's necessary; how do I do that?
> 
> -John-
> 


