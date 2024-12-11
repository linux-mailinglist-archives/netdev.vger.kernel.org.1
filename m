Return-Path: <netdev+bounces-151036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842769EC8C4
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2794E2813A8
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8FB233686;
	Wed, 11 Dec 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JkI+aHSH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96512336B5;
	Wed, 11 Dec 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908732; cv=fail; b=Ebcunf9pPy7Hfuo2p9bmmK2bxOXZeLwOpFxZ8Wf2FMAAj4EJb8t0hLgDJW6OUKEyUXLXjzFREMCnxl1rj0vUa7WHm7/fYVBjJwXBU9l7/OQoPBa8Ovxnf97qZs2+sAJYd+HuSLuLUDw91MOk0zalU+m/4fS07iEGKY8PeKcVL90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908732; c=relaxed/simple;
	bh=zCogt0JDzyOIhXM8D9XCy1S8WI/h1f2cfebb3TRuBXI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h7X22nLRN2lryFftyCc/KmF0BRD4P+gxK5hEEdFxee/uyffPp8FI21RjanRskTVNO+CJ0LaEZ2KXAxW87dVs524Q0/TcfC8pGfG8/ZbSrsHpEuvSV1OEJDh6fsmK3SRF1kpUYXlEJgFFbfPE5pExopN6VkSSqmW8k9IpDe4VXCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JkI+aHSH; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fi3bogcLSzaVlgUcTDd+o/1d7hWYPdlIx9n14+dUTCwgvMyIj3gjd0hg3Lh8DrcmYux5JZPKrpBD7IjwZc8j2s8XsbTTs7xW5Dh6984JEBp6Bf1JZ+2bzooVbJXEoAHpy0bSA/yrAEjmOYs5MCuAw71AuXQhQ5Ih09QP2tqqW3RsGSSKG6QDjNZOpIsEYWtCp7sFdypF33rs3YzyKHDL734V3C8csszqCBYhNsc27br+O120cmRm1WNzPhUqn+o+b4e+27SUcLXopS0T1VbQeuc0H39lxsp/geXEVboebaXYwbmRZ6PKk7RxW5X5erdGqMJqTjIFWO4ynW95ZTwn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x8ZlV4usOCK+RCtnPWgg6wzQouGBCIhLLQwPWV008Q=;
 b=Xmklweqk5X4qeobINUf5PDU0H0mzE+/8n9nCQltPPqL2hc/9RMcqAUxSFsx8SSTKSLcaqOFvf0ZthykV18is8tAG19IM9nAtq7EVuUic70UXJVTkV2WVgUwZuhxWndf0+r70ghMc1vaYRUUv2Ibx3cQL/WYFZ84KkEMQcy2okMzjnsxdGs054aMBLajz80V838Uyn2uMC9KqTP+A/lujdfznp7uSWkxx1CfYLmt3x8UZEVi31AXkHSR2O+ZOFUT86G/544dU2umw5WOzpK0517ZA2FGaAEpz4hsjMrc5WYgDOtzlYn3vIW7c4zPPpgbtIq9PPEJer+gkmWIu06Ghmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x8ZlV4usOCK+RCtnPWgg6wzQouGBCIhLLQwPWV008Q=;
 b=JkI+aHSHMUxtGrVVRr01XfSeKG+lNgrIDkXESsLwKJJ2/5d7Uqc64dWoVbLTfoVjpvXq8LmOvY39LfjvEQ/r/QHGpYNSvxmObkDN0gIsT/2QkbwLnsofOoAweHk6FE08I90P17LOTuYbKM6O6a6qrwQV3T6gI942hzk39KseJlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 09:18:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 09:18:26 +0000
Message-ID: <e6c268a1-a186-8fbc-81b2-302611abf8ec@amd.com>
Date: Wed, 11 Dec 2024 09:18:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 23/28] sfc: create cxl region
Content-Language: en-US
To: Edward Cree <ecree.xilinx@gmail.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-24-alejandro.lucero-palau@amd.com>
 <5aa783dc-ee17-d72d-98cb-0d0a64fbd96b@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <5aa783dc-ee17-d72d-98cb-0d0a64fbd96b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0447.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: aead8ea9-3335-419f-390d-08dd19c4c4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zlp0cjA1QngwcFJKT0JJenFPaENjYUorbTBPM0dlM0VGVTI2OFhSQWduMGl5?=
 =?utf-8?B?emozaExYcUhValcyYWZCR0pLMmRpTGlnSGJ1VkpYalNiVkJPMzdOU2ZRbjZT?=
 =?utf-8?B?aEFJN29qZml3dWg5YWtnSCt0ZnBESzdyZVhzb0w5NWhsczMzMmFBdG14MEZy?=
 =?utf-8?B?aXJoSHlSbW5DZ2RWSjFKQ29LVk10REp4NDVaS3Awdk95a2xDbDc1Vk9XaWdy?=
 =?utf-8?B?V1JwYWh6aFdjWnErM25tMExsTWVHdERYTnpmZGhlbjRRME1XZEZGU3VBRXZx?=
 =?utf-8?B?NW1qU0duaTRSK0g4aHIvdDZVYVgweHIyRFQydEp1ZFZXcUxPVmZub0NmQXhi?=
 =?utf-8?B?aDdWUzYrVVZOSXlLY01hUHAvdXNMcWpMSklDTEtyMjJjd2dNZDZmRHJBcE5T?=
 =?utf-8?B?V1lKcXdEYWtQN3AwaitXVFN5N2I0SVNKaGRGQzZUQUFTU3RJT1p6bFdZL2xw?=
 =?utf-8?B?cGhSMzl4V2FIUThIbUpCTGFZZHdWTmhPMHBIKzNtNDg0amFrUFdXdHlZZDJz?=
 =?utf-8?B?VGY0Q1J5S3krSHlEUkM3L0VkWDZlS0xUaTA1dHRwN3B0NkRqdXFkOXVXRDFM?=
 =?utf-8?B?RWtKRkMxdUlVS3doSTJYc3E2SWFTVjgvUWpiYnU2M0d1UFVZVmFUT3Vobys5?=
 =?utf-8?B?dzVKU0MrUFM3ZnpiYUhoL2ZPZXB3dU1nL0hydjRsaHA2dmJGMVlTUlFnNCsy?=
 =?utf-8?B?Mmt0MVkyQUpMRFU0MVFMT2ZKTk1aNzNhTlRqRDBpbGMxb0hDb1FBZlFWN0h1?=
 =?utf-8?B?YVlYdGI0YkpjczJPMFo0M3VCb0pzMXN4RXQvU3owYnVVVVhqWW0rdUN3dDdu?=
 =?utf-8?B?dzVDWDlDYW1jWDhXUWYwbVczbGdVL090V01nKzJPNWRHMXNXTXNpOUo2aFZy?=
 =?utf-8?B?cjVzY0xYS3pZZmo2MlNJYW11dWpKblVvWEUxTVdWSGg0TFV6eUg4d1doeXVq?=
 =?utf-8?B?dE0wUDR1OTExTFFVdHBoMzJuZC9BQklWb0dWMEN3WElTRWZUMmNHLzVXK2wr?=
 =?utf-8?B?SHdRcXBDQ3hwK0VCNnIxamprd0Vxb1VmeGxUelpUZklsYnNjenp2dzg3bzRz?=
 =?utf-8?B?eE8yK2o5RWF3STRrUkNaZGZneExibEJBT0h2cUN3V0JaTk9QZjNPSGxmWFk5?=
 =?utf-8?B?eGQxbjIrUFEyL1ZQZUVEMCttNFZwZzVSS0VIcVQrYVBUV0cwRkZLemt6SHMv?=
 =?utf-8?B?a2dsYm5iUVgxNFo5d1NuVURhVy92aXRIaW1tdUZEZW9lSlRWUC9CMUZLQ3lS?=
 =?utf-8?B?YW9zVjhVeFhIa1Urc0NiUzg0WkFOdThlalpBMjVrVVVHT3FIL2xwT05ZQkJP?=
 =?utf-8?B?OU1HMTlXazRzMks0N1pRVGE4VnBpcjdPcWo5OHhmaTJ2YWhRdVgvT0x1UmpW?=
 =?utf-8?B?ZGJneU94ejhXeXd2WEo2SWxTMDBSbjQ5ZjB5b3dsaTZ0clUybzJUeUZhMjR1?=
 =?utf-8?B?emNjT0FBaW10SG5ySHBkUy95NlV4RFhIa2JJd0ZxM3Y5YlpaeEtrWk51Skdj?=
 =?utf-8?B?YmM0a0IrSW1FaFRlL0o0czZKb21nZG9tYXdoalc4SThwWldrbDJIcFZHTTVv?=
 =?utf-8?B?UVVhUU1vTVV4cVZVTlA5QUE4R1UrZVc5YXVRaXl6K3p1U3dMRGdaRDVxc3hi?=
 =?utf-8?B?Wmkwc2JGQzB3UU5JZ2NZZTlWR1Zlcy8rSG1UeXBGc05yR0xxWURQS2VraW9r?=
 =?utf-8?B?VmZCTXNTazhuYS83K0JjeWNWcGRmTks0Vlp2cVhNWHB4ZnVXNTNLL1AyYllR?=
 =?utf-8?B?QitKOFhiZDRVZVZxRkV6djVmNzdueFowRFBETG5UNWdqckh5YU4ycGNLaVIw?=
 =?utf-8?B?K2dLZFlJRitvZXNIQ0xrMDN5YlFCekZNdWcyZnJtUTg0aFA3aDNwUkNoSzRy?=
 =?utf-8?B?RVhHMVBIUnNrQ3c1TXRCMy9wT1l3aE0rVWhGcnlLZWcwb0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTRyRUduS0tpckQwRzBtVEx6UlpNMTR0djZGRGV5U2tHVVc4TGUyNWkvc1A1?=
 =?utf-8?B?dkFsejFBNW91M1ZiQVhMN1B1TFJyWUVOVzJObFg1S083YlNFdzJCUFNDMTVP?=
 =?utf-8?B?LzA4YUpPeFNoT0MrdE9PbHRhQnlYMXNla29OQzg0cENta3IvVjNaaGt4VENn?=
 =?utf-8?B?VTM1OHh2Zzc3NTNvMFQyZHh6RmVaM3FCdzQ4NnhCbkwza0hTVks5OHJ1K0sz?=
 =?utf-8?B?REFuWkxSekw4alEvRGxvNk5UekFWb01hQWVvV2Y2K1ZzQlVUbWcyOC83OTI5?=
 =?utf-8?B?N1pRWWFCVlJUQTVMR0RjbXJzcm44Q1ZYeWVPNTlrRzZNd1BQTmhQTjk1NGFJ?=
 =?utf-8?B?bG9RMXRSelNla2F4RHlLMmd1cFc5c0hEOGJiYWZQL3I5ZnJyUDBjTithOG1P?=
 =?utf-8?B?Q3ZhYmJFK0ZsakNtNWFzVkw0azN4MS9tWU1hV094QThCVWMzajRpQ2d4cjVo?=
 =?utf-8?B?QWJsbHFWZWtrS1ZUR1l6ajdCby91VWkxSURmSDRidHVhOVZiT251N3dGZWJQ?=
 =?utf-8?B?K203Mk1OM2Z4MmtLS1kzUUtQRlhabVdXYjJ0Ylpoc0UxYksxYnh5NlFOaEp6?=
 =?utf-8?B?VTBMTm9aeno3VjhZQ3JSaXNaNHgvQ25ubFB0a0Y4YkxTOTNTU2hSWmxUNmNG?=
 =?utf-8?B?QXNkL3NlZ3RUaEl1eElxSmlsZ1E1S0RtTk54NVpOVGFlT2wvRkNEV0t4R3F1?=
 =?utf-8?B?VFlmbE03cGdmZ0xyejNUU3llV3gxVXBicjVnMTZUM0hjbHdXaWM4RnRWZzJa?=
 =?utf-8?B?dm9nYThxYVh1aXZ2TURicnMxYXhaSFlmVTRzbTZrWWtncS92dnIyaDJTODgz?=
 =?utf-8?B?ZzNsSldubkZseEcvQXExZmw3c1JUc29UcERxUkNlUGxnTlZqNmRUQklJWUZX?=
 =?utf-8?B?UDBhaFJ4dFdGNXdQeVBPWXhTSnlOcy91cENzYjlnVTd3b1JheHJsQk5DRmp6?=
 =?utf-8?B?ejRJZmpWY0lJWnVYNWtwS1IyeStQN0duYlpDS0Ezay9LTlVYNmN0TE9nVGQw?=
 =?utf-8?B?aWs0TklaRjBHQXAzSXkvUkc2MEtDOXZVMGgzVTJ1c0R4T096L1BNd0NSWmJP?=
 =?utf-8?B?bDNVaEh4eFJoUWtxNkVaZWsrNWU5Mkp4cXZCOWJUSEJ0SjllbWFXTjNRTjFX?=
 =?utf-8?B?ZHdnQ0oxNHNXanNGcmlNVnZKL3FRUWk1djZ1NVFDNE9peUZKKzR6NnBOQ053?=
 =?utf-8?B?L3MzUTZ0Si9ZVzBtbU03SXdEa0RpRkh3d1BsYmZuZjN5cWxqcjhyWWZJNm93?=
 =?utf-8?B?OXhkdmJiMEwrUURUS2EyK2ZJa1V6b2pYbUwwVzViTjR4SkRsN0l6Slp3bGZP?=
 =?utf-8?B?Q09qOUhSZk1rMXlpcUh6Umt1cU1hNStteXg1Q1FBSGlwa2pQdytHMnVScFk4?=
 =?utf-8?B?ajIwZ29BQ291T1kwNm5ESjhGRTRkclZkN2xYVmdSZDA1UmgwTS82NmxZTGVw?=
 =?utf-8?B?SWlOaVZCdTJ1aGFwS21zVkQ5Ykt0R3ZOUkxmbUhGMDJXSkxFMG5qT09ZV3pY?=
 =?utf-8?B?SDl5bXZ4M0RmTngrTXBZd25keklOTGFnclVMeHZjNnp0T24yWFA1OGdHdG5k?=
 =?utf-8?B?dGdlZ2d0V2psWFdUWS8rOW9KdjhoOVF5dHlYbnBqeVBlS1V6K0hNN3A5N2F2?=
 =?utf-8?B?R3UraHJSRUE1NnVyZktEZTBOLzE4TFh2dHdFbUM5QmVJKzdSRnRhMmN5TzRQ?=
 =?utf-8?B?R3hEOVJjVGUzSGNjZ0VTTGtFZE93Kzc4cXEyN1VNcDNodkpYSVl3RlBTWVZF?=
 =?utf-8?B?bjdwalRBeWRYK2Z0ZTNYWSttY0ZETEpIMllqOVZwb2pOMkNlVWliQndDUE9E?=
 =?utf-8?B?Q0VqbzNxRmY2ZEZsamNXK0J4eWwrZW44NUhyZUZaUXp2ZEFVcVVkMG5VZTNp?=
 =?utf-8?B?RzZ0UmVrN3hGWTZaKzBDOHpzU3ZxUEMxNVl1aVVDSlozaVNaS0Y4d0tQemNY?=
 =?utf-8?B?cmJ5SXptNnRNcFpLM0VSSlRINTd4OGFKTHpVMjlSeDRXRW1KK0I0R3BFUG4v?=
 =?utf-8?B?L1hzQkdMcWhWZWRHUEppczlHd1RGcUZ2VzVOMXJlbWtMZVdOaUE5bm9GOWhM?=
 =?utf-8?B?Y3lPQnd0NENET1JsYTk2bFRkWEE1b3BhcEhGZ1hHRSs1SFJ3REFOQm1OVDNB?=
 =?utf-8?Q?DumcvxLSKFlt3qzdnZ3VYTqfL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aead8ea9-3335-419f-390d-08dd19c4c4a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:18:26.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrCqvxgw2EMOzwVjNcN2SnWsvAQeH4YL9yS5GwbEf2fERTThZsPimKw9x67P4sSC3Ox6udaylmZP67OrRS44hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246


On 12/11/24 02:26, Edward Cree wrote:
> On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for creating a region using the endpoint decoder related to
>> a DPA range.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 09827bb9e861..9b34795f7853 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -128,10 +128,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err3;
>>   	}
>>   
>> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
>> +	if (!cxl->efx_region) {
>> +		pci_err(pci_dev, "CXL accel create region failed");
>> +		rc = PTR_ERR(cxl->efx_region);
>> +		goto err_region;
> Little bit weird to have this mixture of numbered and named labels in the
>   failure ladder.  Ideally I'd prefer the named kind throughout, in which
>   case e.g. err3: would become three labels called something like
>   err_memdev:, err_freespace:, and err_dpa:, all pointing to the same stmt
>   (the cxl_release_resource call).
> But up to you whether you want to bother.
>

I agree it is not ideal. I will try to use better labeling.

Thanks.


>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>>   
>> +err_region:
>> +	cxl_dpa_free(cxl->cxled);
>>   err3:
>>   	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
>>   err2:

