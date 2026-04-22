Return-Path: <netdev+bounces-280317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD8CJPVi6GlaJwIAu9opvQ
	(envelope-from <netdev+bounces-280317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:56:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E320D44231D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BF02300C5AE
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B53F2652A2;
	Wed, 22 Apr 2026 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfBIAPme"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013D2AE78
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837361; cv=fail; b=kSeSoG++TmVquthDBdmyDzVy/OaSaa/YuJfX6be4zXE1iq+W72sl6d8AhhZPs+YMIKLyn4ymLHVAdB4q+bfgvBMMj7dNaYS0MNZ0vcC/YfUyhqDgbdQMKI2tIvTdx21NF9jN6bNuMZm673dpOr819moipu/KkclQ6MoZZ2njh1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837361; c=relaxed/simple;
	bh=3Usxr1TNtMBa0DnVFkxPSxLVEwqK/gYuBC6RpKy9H8M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nKYN++pm5rMkVAfELGtq4uaYHzTSUPeOWVtWijU6DKBf14s6chs1cbhNALW1wcrCB8qBjUXptS9yvK66YTPgL3E6jFHcDWE0IMgG8RUJHwR5nudiYcGwp4qrmChvqh48b6Fel3ijypNlhKas9BnUbHS+mvwHQU0g/pOPfEz0JpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfBIAPme; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776837360; x=1808373360;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Usxr1TNtMBa0DnVFkxPSxLVEwqK/gYuBC6RpKy9H8M=;
  b=bfBIAPmekcZDDaPO4agyZc9b4hxzTQtleVpLENWk8SigrTpA7UeE1cHG
   rb0Sl01qc8nNgLkb1k6aD5Xr3TkcezI0NSi9rau6C/b2GxveVFpW5EgiJ
   Bah6IaaN7+483m2ddp3+bcgoeh1KOUluyQQXNzprcg75jyupQjnA1258b
   7m+3zClz049O78FkrtsypzgShOK7MEFquA6M4tDEUr+v1bPPOFyB8v5e/
   qXKyLGxYYFAsyHCYIW7LTJC44X0hdyVfo0J/TdXuctSAoyQvMhHIHH3Hd
   bfvOOrRIVpO6C4dqV11SKs/rDkgjcN8EqYSEA4/wvlFW3z1QhiWV462mh
   w==;
X-CSE-ConnectionGUID: gmAUtnPTS/KIpGhgXUGVBg==
X-CSE-MsgGUID: 7f4/eHs/SI+nlassgI/uEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77797681"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77797681"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 22:55:59 -0700
X-CSE-ConnectionGUID: Uf6luaaFQ7yF+E8TiaMdbg==
X-CSE-MsgGUID: DauryPXHRoq3icP1Yh9Y2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="227660182"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 22:55:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 22:55:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 22:55:58 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 22:55:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLBUWwM1jy1ewZyBPy1qIhlEQFQb3eTVuvq7Zh+I8OS/Q820PJ2UlG6YC4ob+c25mqnCjYXpdu504VXqzSgypc+964CKocDycE/6sCBaO2OzPjiJf6eEjYqEVLMR5FqSeKD1/CZmzOKc2+Z8PSG3aqEgiBjOLlPLw9FKPv3zXTGE/n5EC1HZjWl7EFgTbOYi7t93KCdQgO199QanQc18rP4fb6GRxa5zqd6hWJASlj5p62ipRnJe/9YYQvo2gPdaPFBl3VGJl36XuYZAvheerBLTVhgAzPkC2jjU//K4v2h5OyFng9OwYLKE92y5OorcDMcnU2/kHiX5ySqO56r0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Imn4vep+KYGZ7cme8z/0/htPpFuFx0CapP9TcF6y8Y=;
 b=VdFR0te38Fu30PdtPBJ4uIFQvnCooph+LAJzhUtp0DP7qZT+l7Go+pLUebou0jMbxagGhVyPsSPVQ/eOPPpnK/Y4OAagW43qo5O9jLPdVW4mt0BYXkGPqoSdhYDD+5X9bpfaPf2lmI9MzdDllTWesVWJivqd+yh8xnzGOhio4q6T7RPzMoqIQrukyh1rINn34dfje5uq1JEi7qVGOwExCWA/XeS61H8HB3rirWPF8TIw4Cd4wQ3jNgQ8MpXH9nFpRqc3jpaBjdJ5flL2cGIzRDleWiWJnAM9mJ7iLSBK856TFypAp0ugWREfRvpQ4nBtNIIRBcG6/Z8Dgb3Zn8lmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 MW4PR11MB6810.namprd11.prod.outlook.com (2603:10b6:303:207::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18; Wed, 22 Apr 2026 05:55:55 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 05:55:55 +0000
Message-ID: <c5ae7bab-ee42-430f-abf1-e062439c1356@intel.com>
Date: Wed, 22 Apr 2026 11:25:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] drm/xe/sysctrl: Add system controller interrupt
 handler
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <maarten@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<umesh.nerlige.ramappa@intel.com>, <mallesh.koujalagi@intel.com>,
	<soham.purkait@intel.com>, <anoop.c.vijay@intel.com>,
	<aravind.iddamsetty@linux.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-6-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260417211730.837345-6-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::12) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|MW4PR11MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c75608-1872-402b-e9fa-08dea033d16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CtcGaMFvu3U1GNG2VOCEXfyUubug4dPh+eZHJFdngFiZVviBf8OgVMCvzKk3gEcw24a41AWPfPrnIv9p8qZdY2LP0aY0UJnb0XyiGEl+EAcI5j4+zFaCy5xAJGsvDt12XEMQeE+NsxI3PdZOd0+joABY11XbLgntht0nglpg1XktrjtOWz8SJ4nOGvbyhVRfSlH4/rqmN4BR4cSy7e6Cqsg+A4t++stPvWCdDe4VN5UDX5t574eDRAI8isi9p4aiW236YDyr4xu0VCFLJYowkdC3OkzP3Pv7I5bdgqUQ1AAXtp+oeJIgJ4q8G1y+OZh3+h5aw0jgdS2O4EVEz9rtZrddfrb4BHkc1m9nIo3jX4NOl2SfRkq+32+/SgagEwaqf2vK3ZsyTYEXZuZmlxXuAIlw2v35L6NEmZVipNdJVchRO/ramaSnUZ650oTIfr3PE1/P0dnU6mp1z0p96Vzb+3usd8rzPNs39CDxxtXnr53KplUDlh05B/vcuaL1zajxL6ABLT1PWIklibyw9Ah48QVP6OppnEj2zsfCo3/Ewkef1W1TwJUSRSHnIM6XxvSlOggFRo86nIqRW5+tgcwU1S1DTedDS9rNRdvAba8JwSXRS8mYqsNyi8nD/+KbAx+Jz9OfYypkMcVU6NLdfMTzo31+wTPdeCdaY1exijddEoqgcESdNsZBCZGFGYDgJiagV7oj+qRZmZ0RFD6LzE8FRgdoV6donoXWoCdNwLideEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VThhYkxhci9QQ2lzczNyRmZ1VGVzU1hrek1zQmg1NHEzYjJYT0h2N3pValRu?=
 =?utf-8?B?bEtOU2haRURSMUYvcVZLRGNhVmlITVFBY1p2bVhrTzdDUWpLK3N1VTIyNm40?=
 =?utf-8?B?T3BNaFg5S3RiVUpuNHVKYTJhRndYbjhLeEhJNWdmN2psbUVFc3RWRTcrZXZz?=
 =?utf-8?B?bllBK2x0Vmo1SHgrVnVJdW1rWGpvS2pLR09aYk84QVl2Y2IzL3hrTUtUdGtM?=
 =?utf-8?B?cXE2amx6TC9tN1J5Wkd1K2NjWDBpa3lzOTcxVFRlQzJlUnJYUkEyL0RQcEJ1?=
 =?utf-8?B?UE9HSDdPVFora0F2cFFiSVhuNzRVdlIxcUVxS1MzeXF0aVNtRExPSnZsM00x?=
 =?utf-8?B?S3F3N2pjMS9LdXZCQ0FjWURPRnlEVEk3RTl6dUxkM2pKbm9LRERhekZuay9m?=
 =?utf-8?B?UDNwcWJ6bnlhYk4xZWdXa1FWY05vcFBpdXEvcE1xb2JFTXlybG5UbHpaY0xQ?=
 =?utf-8?B?MExBY1U4NElIcGVIeHl6N2FxaUgxNHpMdmRsY0Nrc0tzbkNncjZ6T0g4QnJP?=
 =?utf-8?B?eXB5N3RVWWRWTlJTWEdacXA1WXJXWHY4V1Jya3FMMnltbVhXa1puSTRoNEs3?=
 =?utf-8?B?UEU3cGVOYmE4eW9xNkp3T1lISWVzc1J2NWpyZlFuN0pzNXBJTXBCZmNzUXdJ?=
 =?utf-8?B?MWNPdFFvTDN5L2ZpNjJLbnZWaFRodjhqWUdVZDloWFpLMGlKM3VWZWxsWUE4?=
 =?utf-8?B?dit6cU05cXVDQVJwMHUwbjhVUEsxWlR4QkFGVldQeFFpUnltdTZNY3NJTFNu?=
 =?utf-8?B?NGxqcEh1WnRsa2UrMVByd2Q1ZW42cXFiek00TExITHFnamJibFFGK29aWUFX?=
 =?utf-8?B?NE5lZXMweWpXWU9tV1hXWlhiYUFVT3JnaHNwVlFTTEhWTFFEZGtnQ0o4MS9t?=
 =?utf-8?B?M2ZQUWpIb25VcGRoMVQ4TjFNQ2dvem1aaHZPQWxBb1c3aHRzNTNKZm1qUHND?=
 =?utf-8?B?VVMvNTZpWm4xd2tGQmtvblJBa1hTQzhxK1FCM2gzVXVnSkZuaG5UUUdXTE5w?=
 =?utf-8?B?NEVCVzlMZDNBMW9OOFRRQnhwTS9pZUFTY0ZjTWV5Rkh4RFhKZTFWdlFaMUpT?=
 =?utf-8?B?akg3anBIazNzRXVpekV3b2RLVHpqVWFMRll0Z25HVXUvZFdTTk0zMmE0WFE5?=
 =?utf-8?B?bE5yWmorS0ZrT3MySUdZMm5RUFdsbzhveENUVkZNYnNKS0phRU1NWkg1ZjBP?=
 =?utf-8?B?ZUNwZ3hpTWdLSkIzNHZsTCtLN1o4d1ppZFc1NExHT09hMGtPbXVEdXJTR2Nu?=
 =?utf-8?B?cVBXSlliSm95TUpLL1JVeW8wdWNEZjJBUlBxUXJib2V6WE1qUzBWcERMcWQw?=
 =?utf-8?B?TW5OMzVwVXdXdDdFQXI5N1BYcmNyUUlPYVNjR3UvUW1NNm9LWGdHS0hsVllS?=
 =?utf-8?B?U2lacGRnaC9pazZsc210a3o4N2pvTlI3b1lWSFlINnZWM1Vjd2Vkck96K0pv?=
 =?utf-8?B?ajJGK1JYZGtsRHVZY1kzYWtWREx2NFJPSjEzdVpyRzF5WmtNUFRhNEYwazNK?=
 =?utf-8?B?UllWbTJiQk9jQjhVZzRvTHB2WktiUmd1N3FCQmt3QWFrVlJjSG94S1J5NTJu?=
 =?utf-8?B?Skl0ZjE1anc4OFlDeWRnWk5QM2FPc3A3MW9HWWUyRW1zU2pyeXRKVzBJSUhp?=
 =?utf-8?B?YnlVWHdOY1ErVlg2MWpoM0JsbVBINDdWZEtNUExtTmdRSzQ1TFZlTUtpNk4r?=
 =?utf-8?B?cmIvR1lzREpSRXVVM3lqOTB1alJOYWNLWXRqQkprbDZmOHpiRGFvc2NhUGla?=
 =?utf-8?B?eFpCM0dBVjlHRDgxcU96TjBlT3c3WWVUYVVQNUduZjFZYk5oSzk5aEFraTdL?=
 =?utf-8?B?bC9qelkwVHQwMkEzMzBtV1B2VXR3bzVRUGl5TitpaW80Y2U5THlEUi9zK3c0?=
 =?utf-8?B?dEdjUXNPbVd1aVZUaXlFaHFZaERPck41YVBrMnA4UEltSUtUWm1RUTlIZTRD?=
 =?utf-8?B?ZUtlWDhLclZ3MElYR0hMd0p6a0tYb25YQXdhSGxleTcyUkx0aUNGUVVtSHVw?=
 =?utf-8?B?YjhUNDRaL1NWUzhVTFpBSWV2Um12ZHBsRmdPK01UeXFUTkRYVngwVmpRL3du?=
 =?utf-8?B?K0tUZ3NiOVFmNUM0bENTQVNCcVpyMWk0Rkx6OXJRTTRpdGZhYWdwdG9pb3cw?=
 =?utf-8?B?dVMvc0djTzBFNENlZDc1TGVmY2FCVnArZS94SE9lOGpTM2FUaitoVjJMa2Qx?=
 =?utf-8?B?Z0RmUmlGa3oxVHVhWGhXOFRvUnRJRDBoNmdOM1c0YjB3d1pDVzFvV0haMnBI?=
 =?utf-8?B?N1dJYld0dzArdnd6UDNwR21aTThnakJBV0FLRzBLOGRyUXRSY0g2U3pLUnBL?=
 =?utf-8?B?MDFNelZKZXl4ZEZCSnR3Q2lOWit4dFlEQ3VBajg5ckZmT3JFNHNpQT09?=
X-Exchange-RoutingPolicyChecked: JobKxdNzcKfFeBYMqEdCJAAC+ZdBKp6Qf619ofwugIXytqTuwOMXWxHtl/ks4EcSdsFrNKisX71VjfFiELAPt69XtyZbBIu75zZs4YBb+xKxqy3aLhkwQ+BvRSe1L1ms9fWZVwyiJYNiSlum6L4Asyrk7isaWKxkcoo2YuU+o2B4E2C3UFenqh8fK2JiBycGojz/EBmYGiiLCkcoWTEl89chgFaPCjqZG4PiuHRF7txTSY8ZgghoJwWyg+/42QHU5QKAYObiGRRlTJjWHPgFEvsbPyjQNTvgXyInHfDJBBPmoeeT+zwjMiT+hssrZclnIgIYCuNVJjA2drDRa61P3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c75608-1872-402b-e9fa-08dea033d16b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 05:55:55.4542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0u+LYp0Vtya3d4jjCHgb5rXPYiXFToTmxfrbGB04CunxcdOCiepXBzc35e2jESum85r+XgMYSJsCDQ9bdmOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6810
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-280317-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E320D44231D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/18/2026 2:46 AM, Raag Jadav wrote:
> Add system controller interrupt handler which is denoted by 11th bit in
> GFX master interrupt register. While at it, add worker for scheduling
> system controller work.

Why do we need this series in the threshold patch. From what i see, we 
need only structures
Can't we only redefine those here?

I know you will have to rebase again once any patch is merged. But this 
is unnecessary noise
for the drm patch.

Thanks
Riana

>
> Co-developed-by: Soham Purkait <soham.purkait@intel.com>
> Signed-off-by: Soham Purkait <soham.purkait@intel.com>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> Reviewed-by: Riana Tauro <riana.tauro@intel.com>
> ---
>   drivers/gpu/drm/xe/regs/xe_irq_regs.h |  1 +
>   drivers/gpu/drm/xe/xe_irq.c           |  2 ++
>   drivers/gpu/drm/xe/xe_sysctrl.c       | 35 +++++++++++++++++++++------
>   drivers/gpu/drm/xe/xe_sysctrl.h       |  1 +
>   drivers/gpu/drm/xe/xe_sysctrl_types.h |  4 +++
>   5 files changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/regs/xe_irq_regs.h b/drivers/gpu/drm/xe/regs/xe_irq_regs.h
> index 9d74f454d3ff..1d6b976c4de0 100644
> --- a/drivers/gpu/drm/xe/regs/xe_irq_regs.h
> +++ b/drivers/gpu/drm/xe/regs/xe_irq_regs.h
> @@ -22,6 +22,7 @@
>   #define   DISPLAY_IRQ				REG_BIT(16)
>   #define   SOC_H2DMEMINT_IRQ			REG_BIT(13)
>   #define   I2C_IRQ				REG_BIT(12)
> +#define   SYSCTRL_IRQ				REG_BIT(11)
>   #define   GT_DW_IRQ(x)				REG_BIT(x)
>   
>   /*
> diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
> index 9a775c6588dc..e9f0b3cad06d 100644
> --- a/drivers/gpu/drm/xe/xe_irq.c
> +++ b/drivers/gpu/drm/xe/xe_irq.c
> @@ -24,6 +24,7 @@
>   #include "xe_mmio.h"
>   #include "xe_pxp.h"
>   #include "xe_sriov.h"
> +#include "xe_sysctrl.h"
>   #include "xe_tile.h"
>   
>   /*
> @@ -525,6 +526,7 @@ static irqreturn_t dg1_irq_handler(int irq, void *arg)
>   				xe_heci_csc_irq_handler(xe, master_ctl);
>   			xe_display_irq_handler(xe, master_ctl);
>   			xe_i2c_irq_handler(xe, master_ctl);
> +			xe_sysctrl_irq_handler(xe, master_ctl);
>   			xe_mert_irq_handler(xe, master_ctl);
>   			gu_misc_iir = gu_misc_irq_ack(xe, master_ctl);
>   		}
> diff --git a/drivers/gpu/drm/xe/xe_sysctrl.c b/drivers/gpu/drm/xe/xe_sysctrl.c
> index 2bcef304eb9a..7de3e73bd8e0 100644
> --- a/drivers/gpu/drm/xe/xe_sysctrl.c
> +++ b/drivers/gpu/drm/xe/xe_sysctrl.c
> @@ -8,6 +8,7 @@
>   
>   #include <drm/drm_managed.h>
>   
> +#include "regs/xe_irq_regs.h"
>   #include "regs/xe_sysctrl_regs.h"
>   #include "xe_device.h"
>   #include "xe_mmio.h"
> @@ -30,10 +31,16 @@
>   static void sysctrl_fini(void *arg)
>   {
>   	struct xe_device *xe = arg;
> +	struct xe_sysctrl *sc = &xe->sc;
>   
> +	disable_work_sync(&sc->work);
>   	xe->soc_remapper.set_sysctrl_region(xe, 0);
>   }
>   
> +static void xe_sysctrl_work(struct work_struct *work)
> +{
> +}
> +
>   /**
>    * xe_sysctrl_init() - Initialize System Controller subsystem
>    * @xe: xe device instance
> @@ -55,12 +62,6 @@ int xe_sysctrl_init(struct xe_device *xe)
>   	if (!xe->info.has_sysctrl)
>   		return 0;
>   
> -	xe->soc_remapper.set_sysctrl_region(xe, SYSCTRL_MAILBOX_INDEX);
> -
> -	ret = devm_add_action_or_reset(xe->drm.dev, sysctrl_fini, xe);
> -	if (ret)
> -		return ret;
> -
>   	sc->mmio = devm_kzalloc(xe->drm.dev, sizeof(*sc->mmio), GFP_KERNEL);
>   	if (!sc->mmio)
>   		return -ENOMEM;
> @@ -73,9 +74,29 @@ int xe_sysctrl_init(struct xe_device *xe)
>   	if (ret)
>   		return ret;
>   
> +	xe->soc_remapper.set_sysctrl_region(xe, SYSCTRL_MAILBOX_INDEX);
>   	xe_sysctrl_mailbox_init(sc);
> +	INIT_WORK(&sc->work, xe_sysctrl_work);
>   
> -	return 0;
> +	return devm_add_action_or_reset(xe->drm.dev, sysctrl_fini, xe);
> +}
> +
> +/**
> + * xe_sysctrl_irq_handler() - Handler for System Controller interrupts
> + * @xe: xe device instance
> + * @master_ctl: interrupt register
> + *
> + * Handle interrupts generated by System Controller.
> + */
> +void xe_sysctrl_irq_handler(struct xe_device *xe, u32 master_ctl)
> +{
> +	struct xe_sysctrl *sc = &xe->sc;
> +
> +	if (!xe->info.has_sysctrl || !sc->work.func)
> +		return;
> +
> +	if (master_ctl & SYSCTRL_IRQ)
> +		schedule_work(&sc->work);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/xe/xe_sysctrl.h b/drivers/gpu/drm/xe/xe_sysctrl.h
> index f3b0f3716b2f..f7469bfc9324 100644
> --- a/drivers/gpu/drm/xe/xe_sysctrl.h
> +++ b/drivers/gpu/drm/xe/xe_sysctrl.h
> @@ -17,6 +17,7 @@ static inline struct xe_device *sc_to_xe(struct xe_sysctrl *sc)
>   }
>   
>   int xe_sysctrl_init(struct xe_device *xe);
> +void xe_sysctrl_irq_handler(struct xe_device *xe, u32 master_ctl);
>   void xe_sysctrl_pm_resume(struct xe_device *xe);
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_sysctrl_types.h b/drivers/gpu/drm/xe/xe_sysctrl_types.h
> index 8217f6befe70..5f408d6491ef 100644
> --- a/drivers/gpu/drm/xe/xe_sysctrl_types.h
> +++ b/drivers/gpu/drm/xe/xe_sysctrl_types.h
> @@ -8,6 +8,7 @@
>   
>   #include <linux/mutex.h>
>   #include <linux/types.h>
> +#include <linux/workqueue_types.h>
>   
>   struct xe_mmio;
>   
> @@ -27,6 +28,9 @@ struct xe_sysctrl {
>   
>   	/** @phase_bit: Message boundary phase toggle bit (0 or 1) */
>   	bool phase_bit;
> +
> +	/** @work: Pending events worker */
> +	struct work_struct work;
>   };
>   
>   #endif

