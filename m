Return-Path: <netdev+bounces-230909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFBABF1864
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A493BED61
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5932F8BD9;
	Mon, 20 Oct 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kk63EZdX"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D1241665;
	Mon, 20 Oct 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966684; cv=fail; b=HaXZl0CNyK1o9zIN/yjFTiG24D0SxVmNBMczigYsDtBG+LfNUGtQKG3KKkscOUosUddIPjLL98/ot8psPuRpxIzfCDvIgk3szl4mHo8ujXtJAMv23bXa989s6DwSGgpI+v2RlLhbBUQXqrxsnjRKE+73Txp0is0pQvDTKqEvVm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966684; c=relaxed/simple;
	bh=PwMHjldKzebPe82wFTKJKPwVsUFK3HLsKK3QKCTnV38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J6mlG8s69uOC9A7hp7FhJmSdpJ+vtvkMDLQDgDDi1fsfC9SHlj3K+X0Jwskh/qH3KadkYEZRGRnmAXk6WvkqH7/OwG9dnyhqUPfMq93ufwZwSL9mesN/D4xvqrBnkBBVjrJx/m9Ls8AhTdDwuvCc9GHE/EF+r3gLxsXtQr9Aq8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kk63EZdX; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swSVdJu9w9D/HImERIJd5KaW+V8MGfKGq4PcnCoR+WQaHC9RgRthfXbwM8Dss4gjIZ04BvqJbusM0R8HU/mP+vpVCtoZdvD6EnRUaQo4tMr92YfF/tvIELlzwiBXv2/5m8q6Ihd8+qgK0ezwgcXsj7pKlcjlnpVDBQwi13+k8/AhHxuPJj+3EzCZ3j6yaHXNjOWWAJ5fm2Y1GKbTzaxeFzFImPXigyseAE8xujoiPvh50OPS8K32Kl8KGbzYXhlLwL8j9OSJL0FPjTEV/zjUfuffVzGaOzZ/wKL+DnyWi7gG6p1OlkJrWwamX5KKkUW7HZNrMx8/Lerv5SLKohptAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfB9mK6A0QD4hyxmdZJSk2gte+tIYpi507A6SBX5LWs=;
 b=dcGoKi2EPHFSIZti9QhBu/LKMRDJO68NyyDTEIutzKDtby3Nn1hzWJ0zP1HHhQa/2rk4vVhSbwd7KpMnc//owpN4KlNXd90+27/CiW/oYy0K2v2jLkiK3gsEI5iSsxcOAeVMqjG5iFZDxWiMKvIoNF0P8LzRdMIpQHnkROlDiI342u7Y2C6uCFclNT02dNDf8MbkT1eRKVfVxhlUIiY80f2y2ZWauLEDkvpa1SuGLT5QuJjTq2uvSoH/dOY8KNvfyB7j55wLcOH6ZEupH6YP0DneHteenQVfTDLVCRlzrQVGNcmPzEs+AucfBD78LYAGPqTgMnzYTD9+rNPKQn7kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfB9mK6A0QD4hyxmdZJSk2gte+tIYpi507A6SBX5LWs=;
 b=kk63EZdXTULY8pqEAD9fHmQNWFH75HvTTamsberVM8/uZAaSTO9PUY3yZMG0FqoY76vx1Wm08wM1am/TQGKHv7k6GpBLi3ghbjN24GcOTEioQQ+j/KQ1Njhrp7Bh9AuR9oX9XksxAjw+HIrBxHFZR3P62hAmYVrnw9kVcX9Vq78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:24:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 13:24:38 +0000
Message-ID: <616d2aa4-96a7-4ed1-afd8-9fce85b45438@amd.com>
Date: Mon, 20 Oct 2025 14:24:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
 <c42081c1-09e6-45be-8f9e-e4eea0eb1296@amd.com>
 <aa942655-d740-4052-8ddc-13540b06ef14@intel.com>
 <127311bc-d3cd-48e9-9fc3-f19853bb766b@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <127311bc-d3cd-48e9-9fc3-f19853bb766b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0084.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: a69c0982-f5a7-4ad5-7f6b-08de0fdc04de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eExkK1dDSlRKUnBRalpUemNhVkhvTUhPQ0VLbFdXQnJpTkJxelVrVkRlQU54?=
 =?utf-8?B?cE4xZ0RlUmpqRzBNS0NHblBwQ2dCWGFVSldGdy9HSnpxd1RTa1VnZlRRV25M?=
 =?utf-8?B?ck1rNGhqYVBjUjRENTI3YkVRd2p6ZUR3WDROUTArcDJGaVRnWkMrWXlOOU9W?=
 =?utf-8?B?SU1lTFkrYWxuYzJrSTdVRmhrU3UzS3gzVDd2MXgwcTJlbGpiZ0pxczJWd0Ju?=
 =?utf-8?B?N0lsWVU0c2xlMDYyeVFVOVE4WjM1YnczLy9vTnZpUDdSNjJ4WjFkLytCN0FH?=
 =?utf-8?B?elJrdnZYUVEwRTh6ODQ2T2U3VVJqL3M0VUQ1bjlNZWFCSEsrVHBSNlY2b3ZC?=
 =?utf-8?B?dit1eVhxYlNGTzNsY2RmNlpISjI5VDVvVW1IUzJoVUUwNDBkU3Z5aHh1R0Nh?=
 =?utf-8?B?MUR6bDhpT2liNVR2dEpVUDFaNU1oWThXbFFBUDJ1VENsckpDNGY5R1ZmbGdt?=
 =?utf-8?B?K00zbjA2YkJLeld1VC9tL3hlWnJ2MkpXNEgvdU5HaHdPSGNtdzY0eVZ2c1dD?=
 =?utf-8?B?a2U1YkdDbWsxbmRtY0hUbWlrei92L1QwMy9NcFRkOG12K3RpTG1qcG82eEZ0?=
 =?utf-8?B?MmlORkhFLzM5QWh3QXQyOFYvdGhETms3bEwzUVNvQUV6OTRWcTZNd0tjc2Fp?=
 =?utf-8?B?ZUMrWGloOHpXTy9hc09YbXg2d0NBaUNlTHVFL25Sa25leTJYUzE2ODZUTy81?=
 =?utf-8?B?d01aalhNd0FscU1TY1pNWFM0SlBuc1kxUU1tVUZpd292cFdkUmJKVk9IUXNG?=
 =?utf-8?B?UnJxMDc4YUNLWE5CdlB5a3VJam15ejBNSGtMYUFlYllZalRJOXN1TTdkZjVv?=
 =?utf-8?B?ZkoyVURrOG1uazc3WVdKYitaSVl0OWowcjZNQllueWZERTYxNUNDQTBCamkw?=
 =?utf-8?B?R2N4S1BwT3cyNHhrWXNyL09XTk9YemlOYUYwK3hTMUtocm90dzFyMytVUnlZ?=
 =?utf-8?B?M0k4cnFOK0NWZy9qRnVVYWFXdDM0bys3a0djUCtLNi8vUzc4c1hWVitubTdn?=
 =?utf-8?B?ZFFWK1VqNGlyb1BGeHlQdEFCTFQwNkQySVRwU2lVY3ZCSzRtV1lPY2JzLy9x?=
 =?utf-8?B?dkt6Smcra0VhUjNkUDFFaDdTaGtUU3NmRk9Sb0JyakFPUVFSMHBoWlp4M3pM?=
 =?utf-8?B?WlEvcTB4VXZtaDh2WTJaQ1BLNDloM2RxNWJ0b0h3NlROTjEzQ0U4SGJJUExB?=
 =?utf-8?B?d0phUmEya043YXlGNlVTTWRXbEIzZ1ltU1VUMlpVdW0xMlAzeEpzOEJUUWFV?=
 =?utf-8?B?QnQ0cENISDhBYW94STFUV3JTaWpoTWNETEVLclVHNE95Skc3YzNYU2ZZSHoz?=
 =?utf-8?B?QldubHVTYy9DM0c5VHBMMS9FY3JEczBwU3orbTJRazNRSlJtNHREbllSeGsz?=
 =?utf-8?B?MWJFSzV4Wjc0a3o4cUY2Ni9kaldmN1dqeHBYTmVlWlcrWUdCUVlnUlpnT2dJ?=
 =?utf-8?B?STBqWnZHdGhqUXdrdjZJVW9XbFJEYWNBbkJCbGI1WVZhcWRXdUJRb0ltbTlQ?=
 =?utf-8?B?QVFyT3dIclM2b3J6NzhLSDJpNTVFN0c0bVhITVY1aHFscUE5aHh2Y3FHbUpy?=
 =?utf-8?B?Tzc4ODYvRW5VMVlEMUd4WmRmdXh5a0F4WUVEeGUwMk5GVUFGYnBVUXk2WHVF?=
 =?utf-8?B?SlZMQkFsbGc3dmFQVU11dHBxdDBhYUhzL3N4MkVkR25oNktoM2hHckFDQ3Rr?=
 =?utf-8?B?QVF4RTdwanZERnhWSzkvOUJNN0NMSk1URkJzQjJBL1ZIcnVlaGZVY3gxMVFM?=
 =?utf-8?B?RTQxU2ZiS3hsUitXNXhGazc0UnBiSmcxRzUvZVBGSkFZMDA1c2hQMitVWnRK?=
 =?utf-8?B?V0dadXl3OUU2VUdvWFBrZnRGdGNuTGl1a1FHOXROQTY2NThIZmw2MkE0V1M1?=
 =?utf-8?B?N3BOVEFTRXBtN1VPekhvL2gvQllER0ljdFNGc1AweE9wc3NXWEJDYjZubnFI?=
 =?utf-8?B?OWEwditiaWZPaUdrZjJOK2tQTS9JUldnN3E3KzRXa2tSWWJOM0Y4eGFoSXZE?=
 =?utf-8?B?YmV1dlZ1UGNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzcrRk0vdmM1c2dxVzVRUW1vODVFU1NlVnBEbUp2Y0FwZ0NMYmpVb3dVMEo3?=
 =?utf-8?B?SFhzbWg0UkdJVTVXY3g1SnppLzljZmVLaENRSktLYnRoOFRxRHBPQVIyc3NS?=
 =?utf-8?B?aFVzRDZGeVJScmloN0Jla244aS9zS29ZREp6U2M2VzZTeGUzcS9kbjI2bHZM?=
 =?utf-8?B?V0dvMUNSV2hERG9OYWtPSXRWajhsRXFMRllyT2RXV0d3YWZIajB3RU9pNndx?=
 =?utf-8?B?NlI2VjRRN0xENkRFUjVPNWpxOVBJN25tYk9XU1dSOVc2UWtycXlGN3lta0ha?=
 =?utf-8?B?Qlo0RlRsT1Z4WkVwd1NyTnVqdjR5SlJXb1RNazlCVkVuY2xhaXppUGZreVV2?=
 =?utf-8?B?QnlrdVhycFFBeU9sM1BhNms4RkZtSVRJVkFqZ1FzUnQ5NUx6Um05b1dkZU5k?=
 =?utf-8?B?MU9jaEVYcWJUQ0t4RmJpZFNsbng3NlE3TDBhTFUyb2FRbXJMZm9sYitxbWJV?=
 =?utf-8?B?WllucjJKWEp2eGpCQVZzekQ2QTNrTWk3UWRsM1N0eXZPSDJ2MDlDbUJ2aGJu?=
 =?utf-8?B?VVhpWmVnSXV1OWRjY25LNHVLVkNUR3hWUDBJbVorQWp2LytkdUl1Ym5uaHQy?=
 =?utf-8?B?MUVqWkQxUVRxUFh1RXYzalVsTUpOR1VZRmRlWndyT00rUGV4a1RhSEJ0bHlW?=
 =?utf-8?B?cDVkdXk0YThVdTN4cWZIcHJ5M1dnN1BRZXpXSmJoWkRLZURQT213UkRGTTVD?=
 =?utf-8?B?OXNEOTFHMU1WdnRYSDhURmo2aSt2TEwxZThtN05td0dZa0tkMmxsS1BRdEZH?=
 =?utf-8?B?ZllKaHBHZVFMT3F5RU5xTmk5dlJpWXJneEZvaG81NW02eGRNMUkyZXhzcUxN?=
 =?utf-8?B?d09qajJLMHNDcUhidFJ3emJrVktSSjlwamZUVndlTFdBT3dOVm1lMFpERU1N?=
 =?utf-8?B?TmRSckFaR0tNek1mYU9xbUZIM3pDUTFiUldMVjh3UjQrUFRYWEZRTE9xa3NN?=
 =?utf-8?B?TWtGbFZTVVdHcDB4QzVqbFZlaC9QQjFmRjVHaHpDUk9IWXk5cndhS3R4a0d1?=
 =?utf-8?B?MFVNM2tyRmdtb3VGYU9ma2h2UlhKWlRxaUZ2R1RCK3BHQjFDb0t4M05sTUxP?=
 =?utf-8?B?N0tVZUFDUngrVm52eVhMR25aVVFIbFJSNGNKc3BQRWFNazZ6TEViaHdVQi9n?=
 =?utf-8?B?b1JaOGZoOGJ4NlovcEV3UWpyczR5M3ZmSGRCOU5USTVQYkRNVUZ3SW5wMVFi?=
 =?utf-8?B?MXdCRlp0TUJsTk41Y0lhZ1Q1YU9LQXdRQXhUK0U4RTZET1I2VXpMLzJPV1ZV?=
 =?utf-8?B?dEJ5K2s3aCtTSEtWU1pISjFKT3p0cWlTa0JKbTN3RGNxRjdBT0NQOW54TnhH?=
 =?utf-8?B?Y2twUmpPem5YanpKeUFDMGlyR2Q3b1hUVEh4Y09aNEwrUjNkVzMrZmpUTFVh?=
 =?utf-8?B?MWFPMWVDazBRM3RSQk1kL0d4djRQZXVCT1N0RlcwUzhEWm1YUFFEd3BabTVj?=
 =?utf-8?B?TVYyMzVYeldHaFgvaHhxMXZlWXNKd24xbGI2b2JpQmdRWHE3ZXlTMjk4UUtn?=
 =?utf-8?B?YjRZNDVLMk9mUHZOZnRMdVM2Vk83cndFclk0VXNxOXIzMlh3bCtjUCtMRXdC?=
 =?utf-8?B?NGNteXJvSXEyYUxRcGRBWUoyWVgrbmVhWWhTTDl2KzVxV1RNVkpZV0tlQ0kv?=
 =?utf-8?B?TWtnazY1TzhVWW5WRnk4bThOYzZYSjRwb2IrWW53RzlnL3RRUUhQQzJ0TGZj?=
 =?utf-8?B?ancvbEVDRjFTaWpBNlVGZkd0QzhHdDhUdGNPbVVyUWdSMEhGejFMYTNOeFJR?=
 =?utf-8?B?WlVKdzh6VVhtNXhiZFMrRjRtS29lVjdHcnZPNlY4UWpjWFJnVUx2K01CMnlK?=
 =?utf-8?B?cUhYVS9yQ21CUi9mUUhBcGRJWUFJOW9tOG8wUXUwcXZIVklpanJzOEdFVEZi?=
 =?utf-8?B?RHlpZklWRkFCaFhQM1I4UzdIdTVhb0NvSi9pZ3FLQkFiYTRWUnZYem03RmJv?=
 =?utf-8?B?bmJBK2M4QklRSkJTNmh2MWdaaHEvZm50NmsvcVZmbFlyWW9mNnFhcHI2czNH?=
 =?utf-8?B?Ulhxc1loZ2h4a2c5Z2xMTVhrWkZDd2h6Q24vQUNtL3Bhby9xNDNHeVhLdENk?=
 =?utf-8?B?clRjd1I1TmZYdWJIclNRdkpQeVIrNjAvelBvQUt0bE13cWZ2S3RobjJJSHhD?=
 =?utf-8?Q?xLlN2RIny15WJAdoklq4yrde2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69c0982-f5a7-4ad5-7f6b-08de0fdc04de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:24:38.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdztHZa9G6B3j7aJVftyXRAVp2Rlmt83DqyIs8Q+zDqjCMhQ/ztkpn8u5m8JlE5MXzP+7NbB4S2+VeJbBSwVJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113


On 10/16/25 14:23, Cheatham, Benjamin wrote:
> On 10/15/2025 4:42 PM, Dave Jiang wrote:
>>
>> On 10/9/25 1:56 PM, Cheatham, Benjamin wrote:
>>> On 10/6/2025 5:01 AM, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Creating a CXL region requires userspace intervention through the cxl
>>>> sysfs files. Type2 support should allow accelerator drivers to create
>>>> such cxl region from kernel code.
>>>>
>>>> Adding that functionality and integrating it with current support for
>>>> memory expanders.
>>>>
>>>> Support an action by the type2 driver to be linked to the created region
>>>> for unwinding the resources allocated properly.
>>>>
>>>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>> Fix for this one should be split between 13/22 and this patch, but the majority of it is in this one. The idea is
>>> if we don't find a free decoder we check for pre-programmed decoders and use that instead. Unfortunately, this
>>> invalidates some of the assumptions made by __construct_new_region().
>> Wouldn't you look for a pre-programmed decoder first and construct the auto region before you try to manually create one? Also for a type 2 device, would the driver know what it wants and what the region configuration should look like? Would it be a single region either it's auto or manual, or would there be a configuration of multiple regions possible? To me a type 2 region is more intentional where the driver would know exactly what it needs and thus trying to get that from the cxl core.
>>
> Since this is a fix I didn't want to supersede the current behavior. A better solution would've been to add a flag to allow the type 2 driver
> to set up an expected region type.
>
> As for multiple regions, I have no clue. I haven't heard of any reason why a type 2 device would need multiple regions, but it's still very
> early days. I don't think there's anything in this set that keeps you from using multiple regions though.


What Dave says is correct, so Type2 should  support these two 
possibilities, an HDM decoder already programmed by the BIOS and the 
BIOS doing nothing, at least with the Type2 HDM decoders. This patchset 
supports the latter, but the former is more than possible, even if the 
logic and what we have discussed since the RFC points to type2 driver 
having the full control.


However, I would prefer to do that other support as a follow-up as the 
functionality added is enough for the initial client, the sfc driver, 
requiring this new Type2 support. The reason is clear: I do not want to 
delay this "basic Type2 support" more than necessary, and as I stated in 
another comment, I bet we will see other things to support soon, so 
better to increasingly add those after a first work set the base. Of 
course, the base needs to be right.


Thanks,

Alejandro


> Thanks,
> Ben
>
>> DJ
>>

