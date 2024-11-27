Return-Path: <netdev+bounces-147611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F369DAA68
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1E4B22557
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 15:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D6E1FF7C3;
	Wed, 27 Nov 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CHxiG297"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39851FCFD9;
	Wed, 27 Nov 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720044; cv=fail; b=Noxvuoe8aFgcn5QxpJpyXtcRyKLZ5xLHOOpaM9zLwiuC4GUeM0/oRtliCoBm9D7pYlK/hMS3Mmh8pzEw8kaqj/WFC/fciEY+7D0+B4IhgxTFkj+0nGY5HTxt2NvAhdTHBfl+8eI0ZenBejLhoviQnHrlCTNNO4nPXPgcxkj5kgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720044; c=relaxed/simple;
	bh=LijXrHYH0N7a6nXrgtBrTwzVAtXPa9euoRuEKl698S4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HA6q3Vr3MX1hUNWKsfhcjm7Zff2XPVgdwb3dME59cB5nXx83PlneZ+d1sTS0Mz/woJ0xq2Lk/HohiJRoL2X2Ta0fqohtzhXLdHkBWw+cSquDKe8pmudD0zoznX7Cc/0ZHXYKyvVlyKeX9FzDkde6TTmE99TEVLtERbt6LeqxVwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CHxiG297; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peTFOV+gyAAStj7fPY3V6T8uRbZiqQn1ovmausQ9RVwF/lDCfcKDVoLAV8CgBOML5QHJoGKV+25uxfh3DBaVk9rlvXZP6bYYh+QKsgN7t9LZuch26vvUdI8EItambPdHVLTEispeeLj+uFrxVz0ba7XXQ/F+fKcrLrPFGzbFmb/DocBvRWRLA87peVXrt8ZYMYI0FfGAyjBwTKMhgSevQPh2yi1lxNJSVj7V/tIpvYsbsD8BIGZvl2uiOUOov3ZfdP1KNVWgyYqhkZo+P7gXJrrc00/IEVwBpQbw3uuw88ZwbLwnBO8KuPjRJMCbjobQxWnvxRO7teLoz5kQYkz0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBro/mkt6a0jNXZ5S39KD5TnVU33c7/OzCAUykM8Qyc=;
 b=FjX1wkrmV7QSQ2nYuwOZqP8avCZQS9SKfA5qTKcEZuBRn6NOQpUlzGQUM7SyKZxxWv0a8waUl5yD9O+1MLLdDrbPcaVxOZPODVkXsSJbz+VtZLY1K3tKutuTeZnksMdzF5Nxz9gioPCM7ozSu207UqCftWq2yOXTz9ARW69nt6WiGSSqLMk6METarNkTPJYAGmAH01fmCMIUhJYtXpknbS5iKpcd5JIE6TGZfCErmn2Ru0Fk2r5DbS/7iJU492Pj0grjkeklw5s+3num1xcoJiTNtPtKosiFoAqmFygEyUTX5+n5z0azk3dRfXuqtqgqcBWbMxpjxx/KZhx93wxokA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBro/mkt6a0jNXZ5S39KD5TnVU33c7/OzCAUykM8Qyc=;
 b=CHxiG297atO2bvs2OmugTMvOYYec7U39vfPD5cU4pAfNZNdtazLZtOfycSksXQsB21kscfCfCV8UxAB+HscH7GRYOCiYI5Q3GLlDigXiLDYgbgsoWGHTLmAYITOSDPM1MIn2jvGApVFrwWK3kqKjsaWLZIevlGJTWoQoiNVG0DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 15:07:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 15:07:19 +0000
Message-ID: <322f158b-d8ea-6c8f-358f-9feeac4f851f@amd.com>
Date: Wed, 27 Nov 2024 15:07:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 11/27] cxl: add function for setting media ready by a
 driver
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, "Cheatham, Benjamin" <bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-12-alejandro.lucero-palau@amd.com>
 <135eaf81-8f2a-4a86-a227-eb6b5476ee50@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <135eaf81-8f2a-4a86-a227-eb6b5476ee50@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d372b2-6417-4fa2-59b4-08dd0ef52fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkdKMzMxemxMVU5pb1l5N0ZjSmJiUVorZFRUK0xOY2RpVUJMNWROZldGMWlt?=
 =?utf-8?B?S2I0UWpTUy9EdTE3dWptdUg2UDc3a1AzU3daenp6ajBqVS9STXlvTzJMWllI?=
 =?utf-8?B?Z3RDMUJHMndMbVVNbjBCSVgvbkEvY0VQMVpscEpYNWhMMDdpRm5PaUZtckxt?=
 =?utf-8?B?enB6TnAwdVhBYVh1djdPZ1N4RllQM2FyR056b2EvZVpGNGJQckRReXQ5R3FX?=
 =?utf-8?B?Z1hlS1hwT2Vaa21oWGpJb0FhQm5iUlZubEd0d01xR3RYSXZld1NUcm1vODJI?=
 =?utf-8?B?bk83c0J5cnBGOURPVnNvT1NhbVQzK1QzZkEyakNnNGN3WFEwMmhWM0Z0UVZp?=
 =?utf-8?B?Vy9vZWZpdnNhaWo1SXNEOTY2aUZnWXhjL2Rab1g4YlNFMUlkNzV1bmVmWnRS?=
 =?utf-8?B?VEhCaVBjUEJqMHk4Y0FGcTZVNlVNT2JONGd4Smc3SmxoWDB5UUMzN3Jjb3N6?=
 =?utf-8?B?a1hqM2VnaWNTMWp3MmREMEg2c2QvNXNBZVVQdDJCR2hFUysxaTcyVkEvNnVr?=
 =?utf-8?B?elNTTUNJaUpnQndIVUkxRDROeVlWb0hsdGxWRVJxY0xZQ3lPclY2L3hxeFZQ?=
 =?utf-8?B?S1R4cG5IMEJsZEZKcnd0U0xTSWVyaTdQWVE5aG1kWUNzam1jazhpR0ZtOE0v?=
 =?utf-8?B?SGkyd29OVTRXTVd1aXp3YVVMYnVUNlJqbVJiTXdqSmZtN3FoZTh4Szh4Yll3?=
 =?utf-8?B?b1FCVnFHclNhNzlweDZVVFNkazJZVGRaTjdvUi9IQTZSRnBPSWNEOHo5bWV3?=
 =?utf-8?B?UmhqZjlGODlzbDlPcVFDSy9pbXV5bStCNHFyYmYxYUZDN3dhK0IyODA5Qmoy?=
 =?utf-8?B?R1l6azBWeDVBSVRLWXVxU05wS0FINDZSdjI2RHU5cG1Zb3hxOFY2RGdBS1BC?=
 =?utf-8?B?Sy9sZnVwOFkyTzI3d1VzRDNvTlNnRnlXaHY0U3QwTVhteDZHc1FEVlNHYllQ?=
 =?utf-8?B?T3hSVTltd05NNjlyT21SUWViZGdNZytwTFVoS216YzNJS0wySzhWbmxqOFJF?=
 =?utf-8?B?T2pLUDdxRkFQQ1d2MnVhKy9kRkxYQm1PU1JvY2ZVWmlUcnNGYnFLV2tOTUVt?=
 =?utf-8?B?YW5kUW9HTU1SSE9lbU9SRGVDQlVzWStHNkhONStlWEZWaE1sdkRGRzJERkVU?=
 =?utf-8?B?QXc4OUltSG5VKzE3cTlyV0xWZ1lzZWxPYTdkNXZBSmE5TkU4bWF5U045TVZK?=
 =?utf-8?B?UmhUK0dFVUNCVyszaUxhWDhuSXk5K0hTMCtVc05EU3NrZVZpbFRYaUNkcTVF?=
 =?utf-8?B?U09ZbmhGMThhMmR5MS9WMkhua0NBdUN3TERONndUQmtUZVE5QmpzbVI3bnZD?=
 =?utf-8?B?R1IrbkR4M2FHb1Y5RUxhd2pGdWRLL2oyMHM3YTMvVkJEdjhhcGJqWThldnIv?=
 =?utf-8?B?S3FOMkZzQ3VlS0VodE1ZZGRyeXNTUWhaY2NiMVhiV2RzOHkrL1BZSTNOOGpo?=
 =?utf-8?B?czkxUXB1cW5vWkdNYjhVOFRINnpTRkRhTzYrbWI0a0NBMXNlWkJsWUM4L04x?=
 =?utf-8?B?RU5mdDFhSURSM0xCeHR1VG54OWRaS2VicWU0WkZOdDRzSFNoVWpWTmIyVFFY?=
 =?utf-8?B?TjVmNDJicUx1ZHpwbXgzOHhjM1ZCS1lZS2xnK0xLYlRFRE1JdTBhTGtqOWZB?=
 =?utf-8?B?emZxQlU5NFVqMlo0VE5sdkRUdWhXZlNUR1NDOUswYnJUV2FzZUVLWlNzcXpp?=
 =?utf-8?B?bjFIMEYxUmIvU2RQQXVCNE9wbFUrblRETjZEZjNIUUJpU2ROa1k1cG9zRmgz?=
 =?utf-8?B?dkQ0S001VkdnQWNUamxSYzFrWGtxUit4VWRuMXQydXo2V21zYkJNdWRPcDZw?=
 =?utf-8?B?ZmRwelpCZVIyZVZKMkQvQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3E0WWtEaGZEMTAvbXdvVmhkTTNta081NjZRNjFERkRRQmxnSk9hTzJXU2VX?=
 =?utf-8?B?clZ3MlNMT0pNV1JTb1llaHJHNjJPQnJrSklQVGQvemFSTGRvZ3JqMWc3anNB?=
 =?utf-8?B?MCthbGNxWE1GZUhSSklzZzdWd1V6QjBtemdpMGk1MUlJZE9xQS9XaHVPRUlW?=
 =?utf-8?B?YXZ5dVhMVThkaEtPSTN0QTVud0VNdVhSdkxIdm1qODFWdVpJKzBpZFh1RGhl?=
 =?utf-8?B?ZTd1a0JLLzBYVmdRWHhSOUtOWnpVVVJqQXFMb3IzVGhWVUF1UmhQVytDUVpu?=
 =?utf-8?B?UVEvdmhXdEs4OGlmOTBpVmVXUko4SWVydmo3WldYaFBOa3VPemxCaXV5YmJH?=
 =?utf-8?B?QVJkb0NjbHFIZGdpUDdCN3loTTJwaDRTMDBka3c1eVNTRUJ0NEtYWVYyT0RC?=
 =?utf-8?B?MGpXaUFJRWVGKzRHdzJVRzYyclZFWVZVVkVXcFBjbDRQMExFZW5kRUo3N1Aw?=
 =?utf-8?B?c1hCSmU5RFk0QzIxcHV0b1Z5RXRDQTRwTENXWHpkeGxiSzNGYWcrOVR6TGJy?=
 =?utf-8?B?TnFxTUNvRnY1b0dYaEgrOVVnNnByR0NBWlZOWmNiYjdRc05PMU9uUTBjRWd4?=
 =?utf-8?B?NDhGWVlnUUFSUTh0cUowdURvRkdnckNNWG1reHNzQTNjemI3U29ITFNjeFFO?=
 =?utf-8?B?RFZhQWtjdmwvNkU1bXozRlIyWVYwNVV1TTdxVldyUzArNEdnN2pNcmVnOVd2?=
 =?utf-8?B?eXJSbXZUMU0rU29ueG1xM21NMDkvSTRzUHQrcnFwUG5ZY0hKR25HMnVXQjky?=
 =?utf-8?B?WEZPOWdQMGNqbng5N1E2NlZwbzBWR2FQOUpjbVQwUU9hd2dLbEdRRHJwUUoz?=
 =?utf-8?B?V2RSa0V0ek1DUEFvZThxV3R1QTZUMGEyaFZMcjlvc2loUytjdzVCeXFrYksr?=
 =?utf-8?B?NjJNSW5Kc3R4SWpwSHNsclJSWGVnUis2Tm1lT0lpMHN6clIzdnNDc1ViV2xB?=
 =?utf-8?B?ZFZicGNXUXMxblZjRGU3eDZsbGl5SGl4VWxwcU5lVUdFbURza3ljcjd1dDJD?=
 =?utf-8?B?TjRYZDhvVGdMTlk5ODdWUWhrdUpYREtEbTZRZ3dkbkNPZWxhYkdzbGhQSXhp?=
 =?utf-8?B?TW12RmQxaHlYckZpYTNmK2FzdzdybU9JenJmczh0TGt4eE9MZTgyVWxIZUFx?=
 =?utf-8?B?eG1hRWRveXU0aW54ZlhrTDlZZTJ1azRRb1JHQjJWRGpaak45ZDNBUDJ4S1VU?=
 =?utf-8?B?RVYrai9JdkNhMGZDeDFzMi8zZE0weVhQelVPeWFXYzlSbFk1cXRQWW9FemFl?=
 =?utf-8?B?RVkxVkdrZndJanBwdHh3aWQ3L052TjBJTUxZTi9qK2wyQWJ4anRwQ2p0eWZs?=
 =?utf-8?B?ZzYyd3ZBK3dCaDRwRmVHNGFxWXA2RFY2cVYwckRnbGRGMmc4RFJCZEJKR0dO?=
 =?utf-8?B?cXpkVFZaUFBYVHVlalRqUHdaZm1SR3JoSDl1Q09UZ2pUYkFsMFBBVUtUZXRI?=
 =?utf-8?B?VXhZelhqTEJpVkVZVzlvTjFjZWw4bVNIdUdlRWlWK2VvQ0YxaGxzQmJWUTly?=
 =?utf-8?B?T0lTeXJKY3hHdEx3Q2llV0dhTTI1N3V1THpaV3pENWc5TlBZeDV2OHROQ21z?=
 =?utf-8?B?UlBodXQrUHJldFRZZkE2aHVHMHUzVnRyckkyRE1VcEsyYVk2UFBNWmZ6MG9U?=
 =?utf-8?B?dUVlSFE5OGxNZDFQQUY1cWgxWlVBemMrMXFPRk1qYkJHa2NrTzFpajhvS0hK?=
 =?utf-8?B?WlJSSUdRRDBqbXdzMGFwZ0RFZ3c3SUo3aVNBWmJnSHZlemhiNEpOMElQTkhs?=
 =?utf-8?B?Z29Qb1BwbUpoM2hHUUlMeGY2Tk5PWlg1Wk8vcy83V0JYTVIwVUdveXVPejZu?=
 =?utf-8?B?clNWYUpYZTJ4dFlHNTlXVVI1MEFZMXJ6NjJWQXM3VmxrR0szR090V1V2RHpl?=
 =?utf-8?B?UGw0ZVdVczV6dEc0RUZQYUVsQVM4MkU5V3R3S2hqandNUVZyUldWOFBESHZQ?=
 =?utf-8?B?R0xyQUxoM2N5Ky9RU29uK3NqQ1dJRW1GbHBDWWZNdW40UzAvOFluTGhCdm4z?=
 =?utf-8?B?T2d6SDR5UlNrc1FRTzcwd1QwQmNteHNTelBLR2dqMmt4VU52d0dsQjZjam9u?=
 =?utf-8?B?S2wySUU3WkFRRjhXQXllVklHclEwODZKMHRQbmIyczl2Y1BDSXliUEd0N2oz?=
 =?utf-8?Q?8EPG5FEDopI8Qo0yQ4gsX2jqo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d372b2-6417-4fa2-59b4-08dd0ef52fdc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 15:07:19.1732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXX9hoji9MnFvwZj+CSi7yG4j6keqkvyabd6CiAEpzCcEw3LA5iklEfj+b+79MNikJ1cN9iXbF1CPrDHYvlUqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794


On 11/22/24 20:45, Ben Cheatham wrote:
> On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A Type-2 driver can require to set the memory availability explicitly.
> Little grammar nit, I think "may be required" reads better. I would also say
> why, for example: "... set the memory availability explicitly due to the
> possible lack of a mailbox".
>

It makes sense. I'll change it.

Thanks


>> Add a function to the exported CXL API for accelerator drivers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
> Actual patch contents LGTM, so regardless of nit above:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>
>>   drivers/cxl/core/memdev.c | 6 ++++++
>>   include/cxl/cxl.h         | 1 +
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 7450172c1864..d746c8a1021c 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -795,6 +795,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
>>   
>> +void cxl_set_media_ready(struct cxl_dev_state *cxlds)
>> +{
>> +	cxlds->media_ready = true;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index e0bafd066b93..6033ce84b3d3 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -56,4 +56,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>> +void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>>   #endif

