Return-Path: <netdev+bounces-190213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F26AB588D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F5E16387C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E595287507;
	Tue, 13 May 2025 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2SyjL7xC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C2D155A59;
	Tue, 13 May 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149886; cv=fail; b=NujYzbip3khbJSVj9d0tJPC3ssGvy0VX6teMdx/rHAhqExoTCXXMdX8TUwymgN/y3pz7VlbM0tj0eBGNY2PXokZA8ujhjOxSJmI7OsJtKfHAx1/7eoUTGUz81Jk0dycYJmzeHGcReNy+CP7r9IlUkT4xlFyinGCv9AV698bFGUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149886; c=relaxed/simple;
	bh=Mb3/zD0QgAQzavlGLUQkL6xZBVEUxheoMf7PWziRr0g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MM00dvGx5zKF2lW+rEk1FWS4pjch/lKnmTB0IjAUjbOn81E0JXK3QcgPHBEcem9MLoMgMT3qCA+xRPVGGffS8jqYnwgpC3NnHbcdf0R3XhDjiynqSfj4zsN1K3iLn4uqlHfu6KNcDRGd9DbwjPSmyo7Uni3BzRstsXjtg4aOndE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2SyjL7xC; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lejHNtK4SsWWsQh1mtWmZZjtf+uySlcfUGhWhMiliX/QFswTl4mJcGZVac1rkTOS7hrxL/fWpkUCzxRbNoWhJ1xIYYqYV7wnQ8dbA3ARCM6SpCDskKcXbIFbQbNKal7VUMjBEtavpKvM5nNMAAMfuvjzSVbV7Eyeuyf4KbJWNiQ+VBAL3Zqri1nKjkgAlb0x4xdbgvSIAqm44KFc7Q2ClQr1JjS5VUM/BgoRnpNw8nSOpUJQAeRYG6YLgAGaIq3uyjIqtsGPmr1w3vrgvTv4pBfzMUIRRhugFbkZefd0Re1ZW9kJRjKl1A54ZDSMJ/+OM9131yvwWOQ3n+9eNdz9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn6r9yNezIginG/cWq6c/XVLSVdGipvI6gtnWFWY17Y=;
 b=MqFHzjbZbV5saGdE8/9WthfOLxXJQmBVzLYtBMXL5KxMNxxUvQshdpU4hW5TqmU2fmjyIgmvnFA/8c80jsCeWKhjM6pStmm1pusmGrGaD1biH+3eVpDnE/MPvh2AGV3leOuPXadJpsGwwDlHBtJrp4RI0PdduC38y1gQbHqKyKoD55uizsoM0qyAeXtu+1ryVxCPhiM1QEvQ4yLggz5MW8TRuljbOPBrHaw44Jh0c8RTZtkV/D5V0an9lmSBYTcV2m0DJHZWlos6ECgW4VRs/mwfHXs4dxn+faZRaqAbg+bqw1pniXPb+WpvBZi+1X5qs2SRGLiJplq0xKLU326ukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn6r9yNezIginG/cWq6c/XVLSVdGipvI6gtnWFWY17Y=;
 b=2SyjL7xCT5Ca/1ykr8xQeTgXYkDBPqe7KfDeieOgv8uZY9g6sZQ08vgsLcHs6AD7S34+FCmoDbuZRB9NzzmPTeLvciu5mMVelEr/qQeWIFKRe+9Jriy33UFAAVR16uq5kJeunL/EJQg57E6PgDrBeqbil7qzwhU3apNPkm24Svk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Tue, 13 May 2025 15:24:41 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 15:24:40 +0000
Message-ID: <fd9888f1-ee5d-4943-89fa-32d6e0fb61a5@amd.com>
Date: Tue, 13 May 2025 16:24:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/22] Type2 device basic support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
 <59fa7e55-f563-40f9-86aa-1873806e76cc@intel.com>
 <8342ea50-ea07-4ae8-8607-be48936bcd11@amd.com>
 <ef2782e6-74d1-48e8-8159-069317bf6737@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ef2782e6-74d1-48e8-8159-069317bf6737@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0089.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::6) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f620af-f453-445d-8161-08dd923247cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1hlL1ZUTnlEYXVjOHlWWGI2blFpVXphMjMweExaN09CWGhMVXprZUVLSTlv?=
 =?utf-8?B?WDg2VlFZenJiNndvaTNDQ1lWZGNGbE5RSHFQZnJjMGlVWjZxRmVqRWE5SHlX?=
 =?utf-8?B?MFlVVzVlbVFra1Z1cHVBRlZOd0UwS090V1FiM3dLU0hWWTEwT1VCNDJncGxN?=
 =?utf-8?B?NTMySU9aUWhKcTFmSTVyZGpncDdqdEM0Tm5ua2dRd2I3MElNdFpVblNTejcr?=
 =?utf-8?B?K3ZyZHc5YnFkalB5bVNHSjM0cjNYbkpyV21lbWM1QWNLV3c4V0lOVTZMd0hG?=
 =?utf-8?B?Y1Bwd083WjFBaGp5SWgzNHBJbnIySXRwNWVFb09STTFSMHMyQUlVYXVRSWpJ?=
 =?utf-8?B?cWxvd2JtU2twb2RURUlBQmRIVnNtTDcvN0ZudXJ6NkFVWXRITllSYUwyZUV2?=
 =?utf-8?B?RGJXWDBpMVBQSktvUEpYNDVRb1E4WGE3M2ovb0w3ZVREQlVVcTZORk9rQkll?=
 =?utf-8?B?cllIaVdkanpwakhNa3VqVHZxdGhaTlc4SHJxYy9qM1lNMGMxTTBnai9GU1l0?=
 =?utf-8?B?NFdpOGRmN2VISkVYMUFsOVpseEpwaDJHckdjcXMzWHVuUGtRek56YlpZUXEr?=
 =?utf-8?B?TmhJMEkwelBkN2FLMlJ5MGxlZ25zR1pPeXZWM09QblpRU05yM1pnT1dDZkV2?=
 =?utf-8?B?Q29WOW1nbGdqU3NzV0Zld3BsUTJ3UEtwK2tOak02THArUUh2OGNxL1pOQnNO?=
 =?utf-8?B?eldUYzhCVU93ajlMV0x6KzlMc0tUMlhlc0tCcVNKSFNXK2U5WkxlZWYzTC83?=
 =?utf-8?B?TUZFQnpDVllzMDZVcHhzSmpYT0tmZDA5RVp2NVRnanpKVUFZbTFjVjRkWmtx?=
 =?utf-8?B?aGI0T2pjS0xUbytHVFdMK3RLU0YzQ1BxMU5VODVEWGs4bVpsVURONGhmN1hH?=
 =?utf-8?B?SHNQdUl2bVVpNkNhWHBkRjhTcENzTndFWlBpR3R2bFhNcXRsbk4vVi91OUt1?=
 =?utf-8?B?b1VIdWxvcmVuVzNzM283ekdLaWNPZTdBb1hTOWc1TndWbUxJYVVYbE4rZDJa?=
 =?utf-8?B?YU5FaHRxV3RSUkkvOWZVd21acWluVmNZRkNkVnhyZnZ6dDBFemsyZFRXaWc3?=
 =?utf-8?B?bk5kaStwY04zY2RzQ3VOKzUwRUR1VzF3M1oxa2dXMStqMEVESGcxOHY2S3dS?=
 =?utf-8?B?aWhuSE5rTGdKOHJ4eFdQdlpENldvMTRVQnFaNzRXZUlQaVRPTWR3NWRPRzJt?=
 =?utf-8?B?N1NzMXNzVllMUVVMbXdIRzUreEtzY2ovQkJtUGpwdS9MOWYvc2FuSldKQmFx?=
 =?utf-8?B?MEg0RTFuUHlmK3pnV0krdzhIdHBiYm1lSVV3VWEvZ3REajNwV1VMcXBuU3pW?=
 =?utf-8?B?S0t5T0lZUDg0OTNpOU15aHVwNTVlVjJwMGliR1ZMQnhRR3RzNVRFRFQwZ2RI?=
 =?utf-8?B?OUIvdWNyTUxzVHlLOTRCY2NrYjh4QXVlY0tYYU9rRnYzRlFTc3loSDBTZDFN?=
 =?utf-8?B?OWk5TEorWmYxTzA4S2hUbnpweE1wYmhNZTRyMzZBNktLSHAxamh6U3dsS0Rx?=
 =?utf-8?B?SUI2dWdtbS8wOS90RjVNaklrOFZ6ZjdpV3VHSVlvS0dCdllCUzJZZCttZW9T?=
 =?utf-8?B?MWpROEZZcXFnUGptaWtwbTlFNURMVmg5cEQ1bjBCWmg3c0VvZXFBeHA0OVNj?=
 =?utf-8?B?SEN1bXljd2pLUTN3M0tNM3hzZFU4NjMxbVMrTEQ0Y2VHNjNZT29iN3EzcXg3?=
 =?utf-8?B?KzNTcGdRZU03WHEvekVOY3NxME9hd2hmTkc4eU9TcXA0R09IMElwUFZ0MlZV?=
 =?utf-8?B?VzIzcUVBRW8xcXpBVktDU3dYbUJaQlhOZ1RmSExDNUlRazU0bnFTTEI1UFVK?=
 =?utf-8?B?clg0aGpRNmwreUpjSEYzMmVCOFJPR25QSGViQXdqMVRheU84LzRSd2I1SjNp?=
 =?utf-8?B?eFUzdXRHWWZPR2hsclRoRVkxaGtFVHExSzYvWWhtL1A5RHRnam55cFRyazIv?=
 =?utf-8?Q?n9MJEwEjpi0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUhSL3RkU2Y4V3I5a3o1QWRmM3VuWis3NytEOHlvVFcyWklIUHd1NzJHVHI2?=
 =?utf-8?B?d21ySWppQS9INmUvWTlXUDgzUURTU2FuSG85dnFaQkxDeEJaYkRrRTM5TStC?=
 =?utf-8?B?L1hwdEpKNElTd0RpMGtrb2k5RWZEN1Z4ZE1mQUVDU1YwdCtXQllFVkdZOGZB?=
 =?utf-8?B?M0htMFkxMmhXVE1FbFAxZHBIR0l2RmpwcWQwS0EwVXhmelZRckRZOU11RTY3?=
 =?utf-8?B?Wjc0bTh5cGtJWlVSN2kzSkNsWTNmcjlIdE0rKy9ML3Z4elRuT2FMNEdNMUZm?=
 =?utf-8?B?ZG1Yc1Y3SVRJcithM0FVNXFrOFdySTM2Q0t2d3M4b3BDbzhSemt4REtYSFpi?=
 =?utf-8?B?YUpkNENLM2VXTTNZWkVYUmJIb1hMQzRkMFJ4UlpycVFaaDNuTU5vcldrNE5t?=
 =?utf-8?B?WjZnYkg4TU94REQyRmkxYU1sSlZLeHBWTS90S3FKTCttZTN3M2ZRUitOWWNM?=
 =?utf-8?B?aGZTR0prRFFZMlp6OTZYWUFjQ1FwNk1SUm9QK2V2ZE40QmEyWGtkQnFNTlI2?=
 =?utf-8?B?ckZsV01YcXUyZHVjTFE1cEl1bFpqVDQvV3FBU1J0OFl3QXhoL2pwYjRDMkhR?=
 =?utf-8?B?L0Nub2JkRGJkVXVQSDhYYUczL2Y1bzVjUmVmQjdLMDJ1QlZmODZMbFZ0c3RW?=
 =?utf-8?B?SnV1dzVDWE1sa094eWxwWkhzTEVOUGpGUzRoVHhnWGdyQ3RtRWpTSjdHWXhQ?=
 =?utf-8?B?NGVseWsrYjM4eEpsVnRqZi91SVR3eVlURVBpZFVXVDdLSVgzT1FkUHIxY1pF?=
 =?utf-8?B?dmVGWDdCRlVYdm1hWDhMRFZmTy9ReGh3KzBRWWdqelBmTG9DV1pXUjA1c285?=
 =?utf-8?B?MmVWTTdqM1dxSFdJdkpyMkJLTkN5WDJXK2oycUVzMUFCSDJ1V1pOVi9QV0My?=
 =?utf-8?B?cDc3T09WQlBBd081UmNCczN4Y0ppVnJwVmRGOVJYUjQ0TWRjVFZtalRZTjZY?=
 =?utf-8?B?Sm4vQUViazV2TllVVS9HTnVjYUtidlk2OUQ2SFFBdWFBK0puWFZFUTBuWmpm?=
 =?utf-8?B?M3kvYXEwak5kVWp0TGxKRy9XN3hDWnF6QW9yVWlDSVJQTWtLbVNQcjNBTzZI?=
 =?utf-8?B?aUR5WERCQnNBQXBMYTFkNnB6RDZmWnU3RGMrZTg0QzRqQTZVNGF2d3lpSXg4?=
 =?utf-8?B?YTB5YnZQNHdFRzZic2RGSVhkUlR6aWtpWUQ1MjUyNndBZG5nZG5XdlhseHdN?=
 =?utf-8?B?NkUybytzSDVwdVFQTXRKRGV0QkpFamlpV2RNcHRIanIxS0cvM3ROb00ySXlQ?=
 =?utf-8?B?Y09HdmtvYmxuMmFRanpPTVEvN3ZnaG9nK2IzeEpiOFlCRTl4aWFmVUE3c2Ex?=
 =?utf-8?B?bVFYRG9HN055NUh6dzd6OUJVS2I1KzlxYmhDUlpNcWg4dmNFV2hqZm1ReSs4?=
 =?utf-8?B?QnZBM28yRnI1M0Iyc2g1c2w2NysyekZDelJSQ3hTVnZYTjhJcC9CODhHNUF0?=
 =?utf-8?B?LzNTZDVKbGFtNCs1eUQ0c1BDUEo1M2xuQTRYcklEU0FNREsyK0tlTmp4NTNW?=
 =?utf-8?B?NzJicHdEblkvbGZ1ektLMjRvSVB4MGlyRkhsMm1WSWVmU1huL0hpQURrUlRI?=
 =?utf-8?B?RVpRNEg5RG1tRnZKRlRvUFI3TlF4VEZ6NnJldkw2WVNhZHorTElrbk9FWTNU?=
 =?utf-8?B?SmcrU3lCQWl2eitCY0k4VWc1Z0NVUUFHazhrVTZEZ0ZmRVVBK3dFN2RXYjZ1?=
 =?utf-8?B?Zkx4aGVUU0trUmxBVHU1eXZHZkZXWWh5bDNvWnowb1QyOTAvMXcxSFNRa205?=
 =?utf-8?B?ZE4yOXlCb0dvdkxpRWlCNUJkbHlIQ3Q5UEsrVHE1aURQY3E5OG5qNCtqVkJm?=
 =?utf-8?B?cWZoeW5YT1daQVM4U2RySEpsQy9KUmxTVlIwWmMxMUlhUTI0NmVEMTUxK293?=
 =?utf-8?B?by9PY1BGK3JFQVlOQ1Y4QXFPOVl6bHVHTElKUVhVemVZQWl0QU9IcWJ4NS9B?=
 =?utf-8?B?YjI5OVBsd2c5OG9VeUJsQmhOMnZkUDZxZ25Eei9TUUxtbDFLZkRmTWpvUVJq?=
 =?utf-8?B?UFdOM3FCNGJvOUhIaG5jNnRTVWM4UzJoeG5wdm94K1MvQjljUG5ab2JGMGM0?=
 =?utf-8?B?M1dXZEFnMk1ORDRUVG9WRWlZcWF3MS9oYTZlSk1RakwzZzFIVU1HTXJVdFNp?=
 =?utf-8?Q?1daVScCwCU/SrbW91o32D+zba?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f620af-f453-445d-8161-08dd923247cc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:24:40.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBN7ei/Kz+MbklLHKUKwOUzsi3mBAFHi4xMxJ/84KPhm20C8l0A4kI/GbZrCg3Alhnbw4zneK4ulB+uTzTi8dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327


On 5/13/25 16:13, Dave Jiang wrote:
>
> On 5/13/25 1:12 AM, Alejandro Lucero Palau wrote:
>> On 5/12/25 23:36, Dave Jiang wrote:
>>> On 5/12/25 9:10 AM, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> v15 changes:
>>>>    - remove reference to unused header file (Jonathan Cameron)
>>>>    - add proper kernel docs to exported functions (Alison Schofield)
>>>>    - using an array to map the enums to strings (Alison Schofield)
>>>>    - clarify comment when using bitmap_subset (Jonathan Cameron)
>>>>    - specify link to type2 support in all patches (Alison Schofield)
>>>>
>>>>     Patches changed (minor): 4, 11
>>>>
>>> Hi Alejandro,
>>> Tried to pull this series using b4. Noticed couple things.
>>> 1. Can you run checkpatch on the entire series and fix any issues?
>>> 2. Can you rebase against v6.15-rc4? I think there are some conflicts against the fixes went in rc4.
>>>
>>> Thanks!
>>>    
>>
>> Hi Dave, I'm afraid I do not know what you mean with b4. Tempted to say it was a typo, but in any case, better if you can clarify.
> I use the tool b4 to pull patches off the mailing list. As you can see, your series fail on rc4 apply for patch 18.


But your head is not what the base for the patchset states. I did work 
on v15 for working with the last patches in cxl-next so the HEAD should be:


commit a223ce195741ca4f1a0e1a44f3e75ce5662b6c06 (origin/next)
Author: Dan Carpenter <dan.carpenter@linaro.org>
Date:   Thu Feb 22 09:14:02 2024 +0300

     cxl/hdm: Clean up a debug printk


>
> ✔ ~/git/cxl-for-next [for-6.16/cxl-type2 L|…138]
> 08:08 $ git reset --hard v6.15-rc4
> HEAD is now at b4432656b36e Linux 6.15-rc4
> ✔ ~/git/cxl-for-next [for-6.16/cxl-type2 L|…138]
> 08:08 $ b4 shazam -sltSk https://lore.kernel.org/linux-cxl/20250512161055.4100442-1-alejandro.lucero-palau@amd.com/T/#m25a578eb83108678737bf14fdba0d2e5da7f76bd
> Grabbing thread from lore.kernel.org/all/20250512161055.4100442-1-alejandro.lucero-palau@amd.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 25 messages in the thread
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 955 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>    [PATCH v15 1/22] cxl: Add type2 device basic support
>      + Link: https://patch.msgid.link/20250512161055.4100442-2-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: 563: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>      ● checkpatch.pl: 773: ERROR: trailing whitespace
>    [PATCH v15 2/22] sfc: add cxl support
>      + Link: https://patch.msgid.link/20250512161055.4100442-3-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: 213: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>    [PATCH v15 3/22] cxl: Move pci generic code
>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>      + Link: https://patch.msgid.link/20250512161055.4100442-4-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 4/22] cxl: Move register/capability check to driver
>      + Link: https://patch.msgid.link/20250512161055.4100442-5-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 5/22] cxl: Add function for type2 cxl regs setup
>      + Link: https://patch.msgid.link/20250512161055.4100442-6-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 6/22] sfc: make regs setup with checking and set media ready
>      + Link: https://patch.msgid.link/20250512161055.4100442-7-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 7/22] cxl: Support dpa initialization without a mailbox
>      + Link: https://patch.msgid.link/20250512161055.4100442-8-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 8/22] sfc: initialize dpa
>      + Link: https://patch.msgid.link/20250512161055.4100442-9-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 9/22] cxl: Prepare memdev creation for type2
>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>      + Link: https://patch.msgid.link/20250512161055.4100442-10-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 10/22] sfc: create type2 cxl memdev
>      + Link: https://patch.msgid.link/20250512161055.4100442-11-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 11/22] cxl: Define a driver interface for HPA free space enumeration
>      + Link: https://patch.msgid.link/20250512161055.4100442-12-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: 133: WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>    [PATCH v15 12/22] sfc: obtain root decoder with enough HPA free space
>      + Link: https://patch.msgid.link/20250512161055.4100442-13-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 13/22] cxl: Define a driver interface for DPA allocation
>      + Link: https://patch.msgid.link/20250512161055.4100442-14-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: 127: WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>    [PATCH v15 14/22] sfc: get endpoint decoder
>      + Link: https://patch.msgid.link/20250512161055.4100442-15-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 15/22] cxl: Make region type based on endpoint type
>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>      + Link: https://patch.msgid.link/20250512161055.4100442-16-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 16/22] cxl/region: Factor out interleave ways setup
>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>      + Link: https://patch.msgid.link/20250512161055.4100442-17-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 17/22] cxl/region: Factor out interleave granularity setup
>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>      + Link: https://patch.msgid.link/20250512161055.4100442-18-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 18/22] cxl: Allow region creation by type2 drivers
>      + Link: https://patch.msgid.link/20250512161055.4100442-19-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: 126: WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>    [PATCH v15 19/22] cxl: Add region flag for precluding a device memory to be used for dax
>      + Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>      + Link: https://patch.msgid.link/20250512161055.4100442-20-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 20/22] sfc: create cxl region
>      + Link: https://patch.msgid.link/20250512161055.4100442-21-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 21/22] cxl: Add function for obtaining region range
>      + Link: https://patch.msgid.link/20250512161055.4100442-22-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: passed all checks
>    [PATCH v15 22/22] sfc: support pio mapping based on cxl
>      + Link: https://patch.msgid.link/20250512161055.4100442-23-alejandro.lucero-palau@amd.com
>      + Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>      ● checkpatch.pl: 219: CHECK: Unbalanced braces around else statement
>    ---
>    NOTE: install dkimpy for DKIM signature verification
> ---
> Total patches: 22
> ---
>   Base: using specified base-commit a223ce195741ca4f1a0e1a44f3e75ce5662b6c06
> Applying: cxl: Add type2 device basic support
> Applying: sfc: add cxl support
> Applying: cxl: Move pci generic code
> Applying: cxl: Move register/capability check to driver
> Applying: cxl: Add function for type2 cxl regs setup
> Applying: sfc: make regs setup with checking and set media ready
> Applying: cxl: Support dpa initialization without a mailbox
> Applying: sfc: initialize dpa
> Applying: cxl: Prepare memdev creation for type2
> Applying: sfc: create type2 cxl memdev
> Applying: cxl: Define a driver interface for HPA free space enumeration
> Applying: sfc: obtain root decoder with enough HPA free space
> Applying: cxl: Define a driver interface for DPA allocation
> Applying: sfc: get endpoint decoder
> Applying: cxl: Make region type based on endpoint type
> Applying: cxl/region: Factor out interleave ways setup
> Applying: cxl/region: Factor out interleave granularity setup
> Applying: cxl: Allow region creation by type2 drivers
> Patch failed at 0018 cxl: Allow region creation by type2 drivers
> /home/djiang5/git/linux-kernel/.git/worktrees/cxl-for-next/rebase-apply/patch:644: trailing whitespace.
>   * @type: CXL device type
> warning: 1 line adds whitespace errors.
> error: patch failed: drivers/cxl/core/region.c:3607
> error: drivers/cxl/core/region.c: patch does not apply
> error: patch failed: drivers/cxl/port.c:33
> error: drivers/cxl/port.c: patch does not apply
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
>
>
>>
>> The patchset is against the last cxl-next commit as it it stated at the end, and that is based on v6.15.0-rc4. I had to solve some issues from v14 as last changes in core/region.c from Robert Richter required so.
>>
>>
>> About checkpatch, I did so but I have just done it again for being sure before this email, and I do not seen any issue except a trailing space in patch 1. That same patch has also warnings I do not think are a problem. Some are related to moved code and other on the new macro. FWIW, I'm running those with "checkpatch --strict".
>>
>>
>>>>
>>>> base-commit: a223ce195741ca4f1a0e1a44f3e75ce5662b6c06

