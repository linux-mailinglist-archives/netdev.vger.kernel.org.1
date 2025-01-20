Return-Path: <netdev+bounces-159809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F69A16FE5
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647143A5BEB
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA21E8855;
	Mon, 20 Jan 2025 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gDRRHIr4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D91E9B1D;
	Mon, 20 Jan 2025 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389431; cv=fail; b=JdvBWCAYH4W0dT2nU5d4sOLPY13OlF6QZ4+DSClZmmE6ee6lfXWwtr8iFFcnUDK/mis44G8HBJDDaAq7bpaBpl+kXY+J0a8FnBdp30fXkvlhsrENJ3284PScgWBUShUJ58RR9rEnSQNAOSUPizXVUM7P9drbzY1biaeevrlJHFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389431; c=relaxed/simple;
	bh=Phi4Y9rH/JNPopdP9tg6femocNYfnz9e7HL3v/pKMVA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ft5CnEnv1WXIWgoQa7rXmJmaQz2/QjYmw4osv6zlqVATxuwqup2u2fflccj8gePBvwLgT10wCSe8uka/nH8oD/eX7h3EvzF09RXqtrtLk356OBNeJ4l97B/M5ZPs+ZSXC5nlJWt1ShuoDSxGnISiOsiun1a5Lq4wprACT58eElo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gDRRHIr4; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1GEj2wrc1n3lrU5bYBflUBD4oMVobAxadN7pOvPGpQmxbec62UVWazw6DQDlIycSGfQFZ8zpe8Hjo7hPQCCvvibRiYI20lZEs1u/oC1vja4UYhOOecWILJipdQx6+ai4KIxyC2YRA48W1KdDtjUwOMOiCe7gfeKXKQ1ioNra3veg7aY6RVb6kd+/JE/Bdr6iQqX9uthd+ptGlhhXzNbOzlFqau4i0dyU/SD/a2a06aSl5LeST/jjH8APGJtAfySskdtfHh/VcGFMsgkHISIw3JeghR0zdFF+1jaF4YBL+s39fsPFDbWlQNvy4WYMTvcxRVkh9idfQq+HfdG5CzfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffWGytXDxImkukZ6QQpGFs9YXN8Q8kVDPH86wjGZV6s=;
 b=S9susbP0Iy+vS2EQJMAyxVSCityNX8oIUc8FpSTR+PQLEow2QK+wIromaez+CvRFJwTZEI91osuXRUsy/PgyDA50hnqcUewB3b9pCJTVMdk/meh4lWJ+J1fHIY7xMsruc239ncEQSwMHcEjFXjVceRAktTpVejGiFRf4WT8Cg9QomV418Oqoi0OXdu0EdVCqJQYXfJbGcqdAi3Ng/WFpjU6c12jIrn89uz0ChZx5Q/lH0scwPuocgYpdiylvEVa0owFYXg1wwdbMzEQlT0iEI3BvDnmwnCNTwGgCBn4fCMAGvLont+tAhoi63a/luH46mpDf8MnVCsp53ycepX7N4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffWGytXDxImkukZ6QQpGFs9YXN8Q8kVDPH86wjGZV6s=;
 b=gDRRHIr4o7q0UOyc9pFhO7lFGvzhPEZdvK1dGo2gb8pniml5VXMaKux1ybxlh2UNKyJnwPesGaeyVIiCqIyb3cJoNC4ie22PZgynCaaxCdgH/Y+Mp19LhQB6TV6K5PRnCsugTfcf0efuMu5cLnL0tA9i/IBKGKTapp6151HTLsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 16:10:27 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 16:10:26 +0000
Message-ID: <fe48e2e9-5a13-78fe-d8f6-6c3faeecebcc@amd.com>
Date: Mon, 20 Jan 2025 16:10:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 10/27] resource: harden resource_contains
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-11-alejandro.lucero-palau@amd.com>
 <678b0c0ca40ca_20fa29484@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678b0c0ca40ca_20fa29484@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0011.eurprd03.prod.outlook.com
 (2603:10a6:205:2::24) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 44db78b8-7a62-4ee5-8927-08dd396cf3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnZKM2wraXVPNStnWXZrVVF4c21ONzlnUG8wd1pzbnJhVkh5WUFlbnh2L1g1?=
 =?utf-8?B?V0VzZ2c2d3d4d3hFMVBJMjF2MXVuT1BlYVBOMVl2alNETWlIUDRRL290N1NK?=
 =?utf-8?B?aWEwd2cxakZsaXhQRDkvdWpTZXYwQjlhR2xGZUE1TVhRTjdnUGpaZjloenFO?=
 =?utf-8?B?WmFUbCtNN2RlejNJRnlzT2Vtb3NZbXc5Z2g4R0xCMzZNbVFzNE9oTS8xRWFI?=
 =?utf-8?B?MTEya1hjZFgyS2NmNlA2WTJvdXM3dS94U3UzRXRqb05FbDVHTHhEK3cwUTU2?=
 =?utf-8?B?dnowd0ExbXlWeFdmcFhvWlpmcTNUdklLT1p4WkVGRVl6cmhKUy9YbG1tWTBk?=
 =?utf-8?B?NVkyUTJjb09Ta3N3elJrRHhUNDlxZTBoWW5oK3BzY2dsWDVabDRtNlJBQzVK?=
 =?utf-8?B?d1BoY3VGaE1GVFJNeXV5eGdZVCtZZjA4bUdEbUhVN0MvQTNRVVFVWFR2OWVw?=
 =?utf-8?B?ZjlKNWlNKzVxU0ZUL2xiczk3Mkd3bnJGQU5WY3hNcUVaZXVYYytMZ3RHazU1?=
 =?utf-8?B?elNtREZaNGp3bU1OQWI5WUpvcWhUV1hUQStFY3o5L3ZteTFyWG8xRVFhODI2?=
 =?utf-8?B?VmtvdlE3TTZYVkk3WWdDQTBtU2ZSa0dxT3dNTXN3NzhRV0lidjFPd2lBdjNt?=
 =?utf-8?B?QkRmKzloVVE1bll0R0tpR3YyWEY2M3pwbzd6bHNKM0djU1RpajB6K0Njb3Iz?=
 =?utf-8?B?akVRdDVodTRqd2d1RWZmR25rNVgzMmpySUtlWFQwTFprZnJxVTNOVW1UVzN2?=
 =?utf-8?B?SGhhQjNzbWtpTFJtVDdrTXZiUTNvRm1QVy8vcDBraEwwUmtBUnJqUUc5SGwy?=
 =?utf-8?B?K3lCZVF5OE9GdDJ0bjdSTnVBNHltdXp3eXZkSzc0NDI0bFU1WGE2OUQzaVJF?=
 =?utf-8?B?YmxxYWxLWmR4N1EwRHpMTys1V0daWjNLUEpUanJUZmsvcllzOHI4TU0vcURV?=
 =?utf-8?B?TERpQy8wa0xsV3ZxQkRYR2JoNXBBeFJYUVl0elFjYkVmUzhiZ2ZReWRKbHhR?=
 =?utf-8?B?V1p4dFFJcWhsREhZN0ZvRmpuUVVKZXZ2ekhaWkFyUmprc05BNC9naU5jMHhZ?=
 =?utf-8?B?Y0t5Vnc3M01UYzJNT25LWXp0cnVkTlJrdVJaUlJvNUVMTnVodWlJeU9yaVdS?=
 =?utf-8?B?d2F5ZVZrMmJIOEUydW5YSEtlT05Ea2ZSWmV0VGQ0bTRFcE1BVk1pRndPeHY0?=
 =?utf-8?B?NDhPMWNzWVZiSXRSUUxJbkdFczFMUEtiR0RBUUlkcDNSK1hueTNQTDRJYUM1?=
 =?utf-8?B?em5FdkViaysvcEhraXgyU0E0eHFWVUVQNkNZb3BzY0tPT2QxbE8yc0hjYlRP?=
 =?utf-8?B?WVRKU3RydEx4QUF6OXpFVEN0WDFhMUtPSStrSmxuVkkyYW8rMlFicStRYkFR?=
 =?utf-8?B?OTBmU3d0dlpDc0RKeHhYUVIvYnBsK002QWpxSkZDanVQTGhhU2lTZU9vTWJC?=
 =?utf-8?B?OGthNkNxU0JqVGhBUmU5WUNZVDh3Q2RPWndabUx4SjVUZVRBbGRhNUhkYWJr?=
 =?utf-8?B?bmQvbTVBUHVXdGQ1aGl1Ukp4Z3BvMWFySkRJeE54WGt0b05UQmI3bjhjMWtC?=
 =?utf-8?B?cWlYb2tQN0tlMTYvZTQ4aWJGazNnbmhXYjcyZlVGQkZRUU03L2taT1ZzTnlK?=
 =?utf-8?B?czFmQ0ZTTVg1bHNLbmlMT3ZNaW5qcHBzR1NRYzhHYVFqRE5CdUJNT2M1M3Z3?=
 =?utf-8?B?TmEzOEtURVd0dzJyUnZJckQ1RGJDdXc5UjF0c3ZPeSs3bGR3ejBIejB4Skd4?=
 =?utf-8?B?ZXZTNVlLeU1rSUp2VHNSVnBva3E1V1kxcVU0WDl6NG1KRmlQdWVERk11TzhQ?=
 =?utf-8?B?MEw2NzY0Y1pHTWVxWTJtSEYxeHB0U0xQbHVTQjdheGI3OGJOZkI0ZFJZcjNB?=
 =?utf-8?B?d05DVHFxbU5Kdlg2YUwwdHRZd0t5TDBFcWtkRWZ3d3FYRTF5S2Z6T1o2OTZ3?=
 =?utf-8?Q?0tzIu6Ldi08=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUVwOXpZZldxNExDTmV0TlV1aFZzRVJNYW44QnFJVmdiOGhLeW05WHlFTlph?=
 =?utf-8?B?ZG1Odmlobjd0WjlnNXBSSjN4azJvc1NVV0ZXNWZxSklkc21KejBVWWZVVG9j?=
 =?utf-8?B?N1lPRWZPWjg0WEdDbjBCZytoRVRQeTd3aVl0R0h1Y0hRT2g0TlZsZkNGUUFk?=
 =?utf-8?B?V2pRdSt1K0RGQm9LU0RnMWhLSnJsM2lQNEJHQmcyWXUwZlZSM2xFc1VkdXJ5?=
 =?utf-8?B?dTZJMUdra21OMUlic0JRSHc5MUNtQldZTGtpKzZ1dUNiYS9rUnVRUmJtdlVF?=
 =?utf-8?B?ZXZjaHhvRk8yczQwc1YxSkx2UXcyWVptRC92aFlneElESzBKd2Y1TTlPK3Bh?=
 =?utf-8?B?WU1zcHRyRE1JWlZCaW9zVmVmZVJNUzZHb0J0TVpWbFVENEVVMnN2Q3NDREJ2?=
 =?utf-8?B?Y2FBazRST2ZBNUoySytjYnhtTWZPRmlEdDZINzFvS2xUMHM3V1pvdS9rRjB6?=
 =?utf-8?B?djJuVnAxYjkxSWxiTmtSTXp1bzNGZkNxenpMVnh2WFFTeXFBb0pzOTZZQ0Rz?=
 =?utf-8?B?Vk8wU1FiZ3B6YXlrUWxrcW5pM3pLV3NoRnpSbHk1K0JRczNiTjkxV1JuNWFh?=
 =?utf-8?B?L1VQTUhVaHVtUGlEY08zaXBxYlU1cVZRdDhUaFIxcDk1RWx3cE5tdE15Zm00?=
 =?utf-8?B?OFRmSDRIeHhudmdKNFNVTlpETExUcTV0UnhyQ2IzTTVBaWQ1ZjVCQ2NVTGli?=
 =?utf-8?B?Skc0Z1dtZmpFVnc2M0k2eWJYUUF4a0RTNVc5Z2JIVkYyQmNkOWl6MTJnNFRy?=
 =?utf-8?B?MUF0bjhOV3ZOY1ZGY2kzWTlZTDI4WVllWUkvbU5WdmFmSFNycWRTb3duQUxR?=
 =?utf-8?B?UWV1T1YvcE1hdlZDbE42NnJYa2RQd1JLREphcGhNRVZuQXF4QmhnT2wrdWtV?=
 =?utf-8?B?MzBRcy9yeUIxc0NBN1gwcWxEV0JWOFVZaWdiNUQyS3hscjA4cUdmUWRkR1Vj?=
 =?utf-8?B?WDJPakwzbFVYOHI5dkdGcHJSY0FqNEpieGltMDUwNndnbERqbWtESDNpN3hy?=
 =?utf-8?B?MnVzakxLWWRzS2dFamprVEhaSExEMEh2UkdzdmV3UmlabmJMTFNnKy8vVk4w?=
 =?utf-8?B?QVQybE92emMzSWtOREgvZ2hlNFVwNS94b1NBQVE4ekJZcnUrQVJmcityMDR3?=
 =?utf-8?B?N0wzSVZ1Y0tkSFVtekxsRUlqOVdjeVRESFVGeVhnQ0dTVjV5WDhwYTJVd1dD?=
 =?utf-8?B?TURtMDNyUkNYMm91UitkK3RBR3VzVWZsUmtGbW5NMWRHb0lLMGRUSm5qQUQ3?=
 =?utf-8?B?OFlxb21DMzhXbmF6cldRTmVmL1IzY1daOEwyZkJVaE12aXQvZjBsNktVYlkx?=
 =?utf-8?B?akFlVm5oaExYYk51Q1hud1p0TXlFaGgxOVFiNFVaTGJiN3I0djVTVnk2T1RC?=
 =?utf-8?B?d3NLazg1Skx3V1JwWnVtZUYwM0tjdVBCKytrM3BMbWFBM3oxelNydVlqaTlM?=
 =?utf-8?B?RGtnWmdkZnlneTBVVjFuTFpURkltbUxra2hTUTZsSTlJUHExRUhXaXdHbmhL?=
 =?utf-8?B?Z3pqUzJ0Qk4xbTdLa1Q5NlNWMnVPbW55MmxCQ2VFMC9uM0NjMG9MbFpvTXNT?=
 =?utf-8?B?WnAwTmEwNnc4L2VHZmEyNDE3NDV2VFBlQS92R095U1N5TXUrRFNwZEllOXNX?=
 =?utf-8?B?RkltbjVCZUh4SEw1akpzTENwc25jRm45YXlKRS9ZTndidXN6bWRxK0RFanZk?=
 =?utf-8?B?eFZ5alhUajM2T25RR3BwVExPRXYyLzhpYnVsNVprZzJsZGNabk9JNDVPT2o0?=
 =?utf-8?B?M2UwUnU1SnF0NFUrYUZEcFhnZkZMNlJJNUNkZ1lPM2NKSnlJbDdZNTcwZXN4?=
 =?utf-8?B?SFVYMFI1V2RlUENoQm9qemNYWVZrQ0VtUTZzVWVDWGQzcjdEczdVeUprNkxH?=
 =?utf-8?B?TVQvcERRY0xFc2VxWlI5NzBhcG9Ueml3U01iUU9IMjB1VjRNVkJHbmtYb2l2?=
 =?utf-8?B?T01KQVlnZS9CL3NoeVJXMStjMGFUYW1ZMHpYbWE5WGNCRmZWUXp3SDhYREtz?=
 =?utf-8?B?N1Y3aEJIMlhXelFLQjd4Yy9HTXVuWE1WRU9relVDVGsvU0orZ1JpZ2pYVjdM?=
 =?utf-8?B?MjFnMmtsMkpxVHMzMFdaN3RIYmFrSGtsazFaaXpzSXMxeGx0VWo2aGUxYks1?=
 =?utf-8?Q?EHNrWzbCjZJa2V8IZ8ElgG59F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44db78b8-7a62-4ee5-8927-08dd396cf3d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:10:26.8607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9vedYTz+u/zHZDKzD7YvAEWRZVvknvSDz10gN5ohacDWIHt+5qNEnKZDzGIKeqpTRkgBq66k0sK97F/o83CAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765


On 1/18/25 02:03, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> While resource_contains checks for IORESOURCE_UNSET flag for the
>> resources given, if r1 was initialized with 0 size, the function
>> returns a false positive. This is so because resource start and
>> end fields are unsigned with end initialised to size - 1 by current
>> resource macros.
>>
>> Make the function to check for the resource size for both resources
>> since r2 with size 0 should not be considered as valid for the function
>> purpose.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   include/linux/ioport.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index 5385349f0b8a..7ba31a222536 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -296,6 +296,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
>>   /* True iff r1 completely contains r2 */
>>   static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
>>   {
>> +	if (!resource_size(r1) || !resource_size(r2))
>> +		return false;
> I just worry that some code paths expect the opposite, that it is ok to
> pass zero size resources and get a true result.


That is an interesting point, I would say close to philosophic 
arguments. I guess you mean the zero size resource being the one that is 
contained inside the non-zero one, because the other option is making my 
vision blurry. In fact, even that one makes me feel trapped in a 
window-less room, in summer, with a bunch of economists, I mean 
philosophers, and my phone without signal for emergency calls.


But maybe it is just  my lack of understanding and there exists a good 
reason for this possibility.


Bjorn, I guess the ball is in your side ...

> Did you audit existing callers?

