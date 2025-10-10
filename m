Return-Path: <netdev+bounces-228504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB46BCCB84
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 13:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 090894E1E80
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A17018872A;
	Fri, 10 Oct 2025 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o7gn8zJl"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C0F9E8;
	Fri, 10 Oct 2025 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094985; cv=fail; b=QzmGoCM36H46pFh2mZbGf8nqZxPVhB69teECguzduTgnN9+pgF/3m7lFS+LOGXz7JpApAvTRiFvmnZQ5IoOpnZkX1DmpPbhWIifxAeY/vVNvDPbxb6fLz2zulj/3yvIkCZgS/aekuAAFR9fJg6+WPo/TELCEaN3N4co0j/HDMQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094985; c=relaxed/simple;
	bh=Zsiqh730+u3ZpZmY6+alcTdX0IOgiZRa9gc8t965Bdg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pJulmL7XC9Drv9XPghd4HHSL6FZlnIEnclSLieYWk4pe8sLHeyqy+FlwijD6v3sIWFS8yNUbQcKsnIpMxMOjCKTnHGEpzmL4/EWPkGvlgNcUIuPkzjpCqWTghxmqJhMjSKtMT4N551Zh5rIjOqthXog7qUY/DPXmnfws63QogXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o7gn8zJl; arc=fail smtp.client-ip=52.101.61.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD7j3RiRpilLofPkf9PNWmCBb0AjQXvHMcGy38r34Ho9OT/4kcyv6qmXqekq0+p0l0OYMjCELMfY9aq9O+mzv3P8Peopb0KostDsEl2S7nQ7CAP9omdb9p/GwyCn3D5h2IEwqt5C76KZvZELQpoJThphf3hjYuJ7o+WUhrRp+FNfGbp/x/1ahZLkOFEcSgUOMuAn6a6dh0oEkZXFkD9htgPU2Y7UKrtchLVGrCjkWPWTDzImKERJGTf+7Vppf9uy4DiSkQEomFekDDdfU3230Ib3Xeu42WezJNrkSO0DgM4v+BdBcapY7y4i8PKCih3jz8kVrdBBxdXI6pSs/TqnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osHSsvnwiveZ9P34+XZfk+tif6lShgH9H6bfb6z5jQs=;
 b=r4weafmJp94XMp+AjSYivSt0dJ4xM5qysY5TDlMa+s8L8iBxCMNzgoAlf/r2nBZVzBFG18UqKEfMWF6dzZ16flx/GAefQaRUqRcx7zdTP4zC8GwXo6TDixtVJ01VTaaVGs43g/KocrjhZG/Us8ND+LZsqNhnre0cqChaPMRqlBbeOND8wXOymxQHFoHQ1bcmqGIAbMLXJE1DIYBSsr8OE8NVOq5cV6gxYBLwcvx2ONqjwrg9cPbACvBinfpfZA9YLuncmS9SjGdvwyX/5JjqrkD6AdErtShdWy204w5j6xDvj1MEXBT52Slv5uCNLMu90wx02jK+uhki9QUanXrvqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osHSsvnwiveZ9P34+XZfk+tif6lShgH9H6bfb6z5jQs=;
 b=o7gn8zJlGK9NA0uZwN0B8QrbOegOS7Sub9d0iEMxUIb6Zdvb88SGI/5R83yhMt+mMS18VGqHZp0mdWBjRvESHBMcn0XftVbGMaMu9DH68fouC+p0c0JYSitoxSSgExG1KYUZ4lpgJFSUIGwau0SoBq7jrJL9cE4QhWd1GfMXZKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 11:16:20 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 11:16:19 +0000
Message-ID: <6fb97a7e-d39b-42e0-9443-8ea9271f277e@amd.com>
Date: Fri, 10 Oct 2025 12:16:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 11/22] cxl: Define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-12-alejandro.lucero-palau@amd.com>
 <7a3d3249-ee08-4fe0-a016-829ece6f7b8e@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <7a3d3249-ee08-4fe0-a016-829ece6f7b8e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0222.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc86c1a-c185-4281-8ec8-08de07ee7000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFBnM2lkTnZFaDB4emtwOTFjWkxoRTdJY1BLOUxiUUJRcTNQcjUrREJHUWYx?=
 =?utf-8?B?WmtpYzVBSmJJdjVqUEVJWm1ZbURhNUpKeXlqbVQ3QzFiSjlJTlRwYmZjbWgy?=
 =?utf-8?B?Qk02N0ZzTFk2blN3clNPQ0dvVFU1RjE0dkRjcTRaQUNjZUFJNFFQcUFwclda?=
 =?utf-8?B?QVhMMEtKalZBWGR4Nko2QndPeUluMWx5NE1CUW00RFBQMGtmN2hFK3pyU2pD?=
 =?utf-8?B?RVpDcUIveHhWeE9hNWtaczhCTEViSzF1cllzRWhqRi9EQjZuSWU5VU5QdGNw?=
 =?utf-8?B?cWduaTBNUEwvTGFiUFFiNFMyOVlHM0tTcjhsSUM2dzFSN2NrcXNteXA1OXQ3?=
 =?utf-8?B?OUk3c2JHQngxK3F0MjVWTHo0SkRBenkya0V2eUFxdXBDeklRYzNKaUNkSm5E?=
 =?utf-8?B?azZhU0F4V0xpLzNHWU1HSVB6V3duWjk0OWIxbEx4S2FqQUVLOGRqNU1QeUd5?=
 =?utf-8?B?U3A3R2dzSnVEd2hMRk9MMUgvb0phYXdmZUp4a2l1a3d4eU9uR3hhRk9nNng4?=
 =?utf-8?B?cGdXT1ZHZEt5TlpMUlh4cy9TdmdZemJIVU0xZUoyL2s3aVBDSHJxdm9BbHNn?=
 =?utf-8?B?TjQ4czFVUmZKNmVCeGRsZ2xMVkduV1BTOWdKUWx6U1hER0lWTXA0S1pzSHlE?=
 =?utf-8?B?Q0plcnZUcG1XeGVrbEorSmlVYWphMnBGWWFNUDNmSmdMa2VDR3l6Q1hnZVBy?=
 =?utf-8?B?K0J2eC9qTENJU3A4WXlXczB2WDgvVEZ1WFJ5Qmd6a3dXR2d2Qlk3VUVMNEZF?=
 =?utf-8?B?bGZ3ZVp4YklacEs0b09hb0k1ekhCZE05Y0pZM2NoK3IxZldqZUNicVBMbFRU?=
 =?utf-8?B?WlNIbk5jVkhXUUYzWHRxaXB5V3YwTzM3Y2hMaFJ6RjhLRnlaNCtzajZkLzls?=
 =?utf-8?B?K29XRnJKOU9pMlhZbTBFa0tmSnM3T2gyOVVjUHRyZ0RGQmlDZzJiQ21sbGtH?=
 =?utf-8?B?cHdPTlNCSkxHU1ZMOXVLKzBaSkFtN1V4NEt0QVdvSjYrd1lyajlwTCtYNmNI?=
 =?utf-8?B?YWZZMlpPeDJXaDNmc1A0UE9EOGIxRFp5cURhM3RZVlFFTWorTzJ2NzR4VE85?=
 =?utf-8?B?ZEJPbTBacjBwZkUxaUUvKy9RRDNNdHZxMW82cTNtaFNkVXhpVEM0dFoyOG5K?=
 =?utf-8?B?K0hOT0RsaHA3dnBLQi8xRXNDRjJVTXRHWW1xMDlTNEMwUGw3bjRnNHhkR29i?=
 =?utf-8?B?b0FWbFBiY3cyRmhaVzFncHpWU1FtL29ENGZBMmFFMlZ3U3RCVjRhd0J5a1hu?=
 =?utf-8?B?QW82Z09rVFIyVXU3eFlSY3MrOElJTnBlQU11bGZvSGdlSmpkSkREUHJFMkU2?=
 =?utf-8?B?SUlRRWRBenhNU0hRaENqemJraGsyMk9vSlgxYlZsTW1RclAwT2NYbHZ6emVB?=
 =?utf-8?B?NWFHem82RE5LZUlYNVJ2UlJ4a1NUZFJJbDk2V0ZSSlpOeXplRHJzMFcrTWYx?=
 =?utf-8?B?NWRob3BXOE10UzloVTI1V3dDUWZjN2VSaVRXb2ZYeStFdjYvRCtFdFZnV1Vl?=
 =?utf-8?B?bFRuZ25qWHZWWVBvRTU2NWNNZEsrbFM3bk5Ocmd1eGtjYWxxTUZlMEFjS3lE?=
 =?utf-8?B?ekFJby9NeUZOdUFIUUNOanRJU3o3RElFdXJLREZtYTBnd3NFVjhGSmJQbzlQ?=
 =?utf-8?B?ZnF4TUZUOUx4RzBNNWd5Q0IxZGpvSUNOZXFCaER4ZnRqZHBxanNsOG9aakdP?=
 =?utf-8?B?WEJPQjU5c3VGRzE4cnJHWU1VazY1RUNlUDUyaERwYXBkdTQzTm00M09KSTdm?=
 =?utf-8?B?Q2kzeGM5TUVYYnA4UWh2b0pNR2xsZGZlT2hKTVR3UmhPOEUzQm9xVXY5V1Bv?=
 =?utf-8?B?L2VVWnovOTZsTHMwQWd6KzFGeVNnNENTaS9KWW9WV05kZUdsa1RORHNlTTJv?=
 =?utf-8?B?d09PRkwvRHhTVURjTW5WQkVwWUdSUU9UUVNlc041UzZWZGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzlueW1xODhmalRPdVdoRjhrM2hic0t3ZXZpY0VFM0NLY1ZMTVFlY0RyUEpT?=
 =?utf-8?B?czFPaHd6UGVDamh3SHhMYldNR0JEVHp3NTMyUWJhZi9IY3pXN21XTDhPNnVG?=
 =?utf-8?B?RklTWVlDQkttSEFXcVdTSzVyeGh5QmNTOFpyNjZrakFQZFN5aVljTS9CNXRv?=
 =?utf-8?B?R1E1WlN4OXZSNmFyQklwaXhEdnZPbU4yMTJYYUFyM0V6MUIxdHo3SnJZMHdJ?=
 =?utf-8?B?OEQydFlUUFhscnFyVFg3WmhJT2JuVUxCZ0dVWE1uV1d5SmQ0NU5iUUhJN0Zq?=
 =?utf-8?B?emxNbHREYUpHc0s1MU1TbGlSRGxzNG1qbGdrUkdsWS9JZm9yQ0xwMEc5MVdJ?=
 =?utf-8?B?c0E4T1hHZkcxSDZGU210TTY1Y2FZY0k0ZEcvRmRERGZaQzhzMTZwSUpDVXpP?=
 =?utf-8?B?dFJEOUJzLzJwOGhGVlE2MGJrNU1lNE9VcXkzUGt3cGV5VTA5Tytob0NoZzRZ?=
 =?utf-8?B?QWxtRWtyK2poTGl2MlhiVDQrMDQzT1ZaU1VlN0k2bDdnSyt3Zmdndy9Vb0ti?=
 =?utf-8?B?OHdhWFJIaXVNVnhMSTNsbmFWdFlibTRybXBIOXFqRTJSOGY5cU1QVnFzYStz?=
 =?utf-8?B?bkFoZFdXSFRZNWo2dDZzVlJyaXZ3U2hpeTNYeGkzNFlvRnlQWHo5dzh2ZXAz?=
 =?utf-8?B?YTVxZGx1OUZoZkF5NG9zT21oRXQ0UE1jajFOelNlY0c2WFJTMUdNcjY5c2oz?=
 =?utf-8?B?SEpvVGx3Y1BFUGQ0TnZxZDhJSlU5c1dHbEt3dDJLODhTV08vRG51bEhOODZH?=
 =?utf-8?B?V0FTZS9NUC9iL2JhK3FjdHlYeFNFUUNPWnBRd1A1TkFRaXBydDhNQ0E3eUhV?=
 =?utf-8?B?NmdJSDBmTTRlQ3ArYVpDVVhUY05JZVFtc0xaNEFNUGg1Q0ZtRjBWaVdoWVow?=
 =?utf-8?B?bEt4UnlyTitDV3llVURBZmxBZHkwZmV6UGZwL2JmcWFJOXMwVWNJR0dxSHV2?=
 =?utf-8?B?d0hVd0p4WFVCUXVjUmVVeFpabkRjYkpQZjlHbjRDSzA5MVQ4R0tCV0MwWWtB?=
 =?utf-8?B?TmRaV2NuNWYxck1sWStzQ3JLbUhHcWMvK0NCeklzdVpvUEpwOWJTb0QreW1k?=
 =?utf-8?B?dzdiMmhuTkZXQmM5UEJpdkFFdVhEMndIckVCakRYbmRKY0Z6M3BqQlptdjl5?=
 =?utf-8?B?MGZBN0lkN01iSlY2NFhjZ0QxdmY2VG9Mek5rZjAzV0NkM3lab28xWmd0WEFj?=
 =?utf-8?B?Y0hzcFplOTBDUTVJczFMTUcyMjhJM0YxRkU2QXNLWnVZK2ovcmQ2enl3VzlL?=
 =?utf-8?B?V3ZiVURDQ3FzUVNKZnpxS2I0bzFDZ29qb0VZRWpaWGFUWVNNVjltYzR4N0NB?=
 =?utf-8?B?aWZkaEJBRHRqalJETEs5QmwxK1dpa2d6RHpXdnBqYkhTczIzdmV0cC9PR2E5?=
 =?utf-8?B?QUxQQjNIZU82SlZ3Zk9TKzdZMHYreTBsRFNsQTd0Szk0RFNyZTVBcVZnWUFU?=
 =?utf-8?B?SUVMS1JVYnFxK3FEZm9tbE5NajdMNmd5Qlc1N2JmYm1tb0NFYVg1WlhLSytQ?=
 =?utf-8?B?aVgvL1BmVWJWZVpkVlliMWJwMVl4YW5Ub2cvVldIeHBoU3JmN2hEME9GUThF?=
 =?utf-8?B?UGYvbmhQR2R3b1BwelIxSDlDNE53TXh1UkNzTmN3WGVvZGMwSVV3M2tqQjhk?=
 =?utf-8?B?MGtFeUwxNytWZ3dPWVZUTW1rUWtxeTNFWWUrQ0VObnEyeEFmQkZHdnVhSis4?=
 =?utf-8?B?QVVXNnY2TFVhOGRUWWlUTWRvS1YzTWtCOUlZc2ZuRHVCUFBYTXRwT3l1bUtS?=
 =?utf-8?B?MmtqWHRoL1Nid25kam81TGZGYTBzRU0vRTYrSkRQdjJzMlhiSFZuN1lKYm00?=
 =?utf-8?B?aTVSc3AvVU5FRjVMaXp4NzRvSWFDTW5QN295Njd2OW1DREltZXBGUHlrN09y?=
 =?utf-8?B?a0tvVG50RXFZYldhQS93R2p3aWM5by9CQzg4N1ZwdWZ6dTRtbmlUT2xnUU5l?=
 =?utf-8?B?aXpJT256dnJuZ1J6YjNoOXBCRU83d2RPcWxwNUd6Ky9ZY0JMTEhqTlpCb1Iy?=
 =?utf-8?B?TmNBKzhXcEt2c2JhQ1RGWHFHZ1MwWkp5Z28zb2RYQUhSK1pkOUhkSmlaSFNX?=
 =?utf-8?B?OGo3U29ZYURKZFRkU1ZKektCckEwZVBUUk9wSWdJY0NBZ3EzVzBEb0RMZ3Bm?=
 =?utf-8?Q?+rea+b2rGjlnOgVIWDRto3QJR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc86c1a-c185-4281-8ec8-08de07ee7000
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:16:19.7735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAFnPnNpmLZgOF4a88dwfaEs1sKpgmcEyPrD6q1wXOA3h3E0M+2sD7ltDLFML5EK0N7X1yHJB9IUsu/1Z53z4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792


On 10/9/25 21:55, Cheatham, Benjamin wrote:
> On 10/6/2025 5:01 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from Device Physical Address
>> (DPA) and assigning it to decode a given Host Physical Address (HPA). Before
>> determining how much DPA to allocate the amount of available HPA must be
>> determined. Also, not all HPA is created equal, some HPA targets RAM, some
>> targets PMEM, some is prepared for device-memory flows like HDM-D and HDM-DB,
>> and some is HDM-H (host-only).
>>
>> In order to support Type2 CXL devices, wrap all of those concerns into
>> an API that retrieves a root decoder (platform CXL window) that fits the
>> specified constraints and the capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
> Hey Alejandro,


Hi Ben,


> I've been testing this on my setup and noticed a few issues when BIOS sets up the HDM decoders. It came down to 2 issues:
> 	1) Enabling "Specific Purpose Memory" added a Soft Reserve resource below the CXL window resource and broke
> 	this patch (more below)


Maybe we should talk (first) about this internally as it is about AMD 
BIOS (I guess). I have been talking with the BIOS team about this 
EFI_MEMORY_SP vs EFI_RESERVED_MEMORY, and I'm afraid the discussion is 
not over yet :-).


> 	2) The endpoint decoder was already set up which broke DPA allocation and then CXL region creation (see my response
> 	to patch 18/22 for fix and explanation)


Yes, if the BIOS configures the device HDM decoder, the current patchset 
does not do the right thing. As I said in the cover letter, my 
expectation at the time, and hopefully in the future as well, although 
I'm not sure about it, was the BIOS not doing so. Most of the 
implementation is based on QEMU, so I found this problem when dealing 
with a real system with a Type2 aware BIOS ... . I was tempted to 
include support for this case, but I did not do so for several reasons:


1) I want to think the patchset is close to being accepted and changes 
at this state could delay it further. After more than a year, and 
because this patchset is about "initial Type2 support", I think it is 
better to do so in a follow-up work, and when there is a client 
requiring it.

2) Because that conversation with BIOS guys, I prefer to be sure what to 
do, as there are other things we need to clarify and in my opinion, far 
more important than current Type2 support.

3) CXL is a fast moving part of the kernel and I bet we will find 
another case which the current patchset is not dealing with properly. In 
fact there is another report of devices with the BAR with CXL 
information being also used by the driver for other purposes and 
existing a problem when mapping the CXL registers after the driver did 
map the whole BAR.


So, I think the current patchset where most of the API for Type2 drivers 
is implemented should go as soon as possible, which will facilitate 
those follow-up works for the case you describe and the other one about 
BAR mappings. If not, even if retirement is still far away for me, I'll 
be concerned about the impending future of this work ... but of course, 
this is my suggestion, so let's see other opinions about it.


Thank you.


>
> The fix I did for 1 is a bit hacky but it's essentially checking none of the resources below the CXL window are onlined as
> system memory. It's roughly equivalent to what's being done in the CXL_PARTMODE_RAM case of cxl_region_probe(), but
> I'm restricting the resources to "Soft Reserved" to be safe.
>
> The diff for 2 is pretty big. If you don't want to take it at this point I can send it as a follow up. In that case I'd definitely
> add that auto regions won't work in at least the cover letter (and in the description of 18/22 as well?).
>
> ---
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index acaca64764bf..2d60131edff3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -784,6 +784,19 @@ static int find_max_hpa(struct device *dev, void *data)
>          lockdep_assert_held_read(&cxl_rwsem.region);
>          res = cxlrd->res->child;
>
> +       /*
> +        * BIOS may have marked the CXL window as soft reserved. Make sure it's
> +        * free to use.
> +        */
> +       while (res && resource_size(res) == resource_size(cxlrd->res)) {
> +               if ((res->flags & IORESOURCE_BUSY) ||
> +                   (res->flags & IORESOURCE_SYSRAM) ||
> +                   strcmp(res->name, "Soft Reserved") != 0)
> +                       return 0;
> +
> +               res = res->child;
> +       }
> +
>          /* With no resource child the whole parent resource is available */
>          if (!res)
>                  max = resource_size(cxlrd->res);

