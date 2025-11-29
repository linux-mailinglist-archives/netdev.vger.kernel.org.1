Return-Path: <netdev+bounces-242724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B91C9433E
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174763A6991
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29DF2652A6;
	Sat, 29 Nov 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V0N3C8Na"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35DE217F24;
	Sat, 29 Nov 2025 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764433582; cv=fail; b=C9k1eupNmrhTcTUkj8BvKkgnANRTA2clmII23gP+SOAjWfvsz962Re7cpfnDtkJR9tp+NAsYF0Zc/oR4tajlsrYrF2l1B06XR2zfVfwA0koKD+3AuiOvTKKgtB18Tykj5pr3ofTeNDCURxUTX1F4bQ3Udjo2m3inKVmra5S160s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764433582; c=relaxed/simple;
	bh=Pwr5QVyG0S9aOc7fGr69UF6GD0pU4LPGJcEttbTHvtY=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TQ7dT5V13qGPkaeNdlH6+fspvcUiyMAlpnKnJLSmhP6clKDm3EeqjK/HS9sQQg1y6UidMAzuBoKZIC0QINvbxyLMvcrUcwD/qB13bUxkotKIixWrcgg0XcrYki40Ogb4x0Ud0nugfMgQpc3tdqaqW0XD9OeT4hVzz9MxNnsxYwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V0N3C8Na; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ve/uH+TYAKEQF6uwbMAbNoK+TwuGE5x1/aguQrlVzLxSL8HSvsjiYaxb8/jih58VBF/ssvUqhvqNt7EFEm2ximNiUGEyCg3axVzxB7C/g7b/1NbL3yfkBo0wFC/b/peBumkJTCU66SXH3ob8duNFFWG6Gabif9JsVKI+25SOOOmaM5jASLmyPL7oQSQ6MjHIdpoULxot5F4xUwVsHhgUK7+bijT0/95zwas89JFAUWGWI3jw5ez9LJb6UeA7IFnJzgMJA4d/sX5/Ua9GMm/x8cDrK6UGBoq5LFeMvIsicPeAvzhZQ14U0/os3U2ctLOd+63QtHAjkeOh19618EY9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFbcXH7Db4xNiC1u0J4oQuc4+eYJLAe1CVv8E1x5LK4=;
 b=vS0UFSbVlGrUvMEKa56x+CySLwGR3ks6g1F5finMMPJmyGQtycXs9sHRfpA+J0XcUVCDZQ78/8E/XWAYCPKTGvlWvlDL5Df65+RwqKnJDNyHoKDjjl/PEKQgs/pLhD1TKqUFQouWy6KNe2v7nMD9+aXNEfKJE6DZJXKx4Z/5fBaqGr0z9COZtrWsbaCfAQyI1X+wiQudKUEGtFV5w2Wfox3pvl0AghNn44ekcXtGqKKrVqA4Xhii0ULGvobpZ6uiZaSKJJH5Xj0C61BBizR6vppA+23wvKY/HaVevtYFLHn+Ir3tYMetjnR0jp1RRhc3q4M1v3YXElOxOgbJMWWFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFbcXH7Db4xNiC1u0J4oQuc4+eYJLAe1CVv8E1x5LK4=;
 b=V0N3C8Nay+3J0pMgh3DMNyfhBFhj5qYhif7EOKtCVlSIYXkoIBb0fBVcpvcVoNGyr3bTVDmmUigUyOx6D0M7NvY0mMQ6vANFGm/P96Cs2ytqdF3nspz8c7dpYP/OP/yEtko0ljxEQBZ+o0GMVdHXbFxdSwf78/6/WaRLLWBRMaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Sat, 29 Nov
 2025 16:26:18 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:26:17 +0000
Message-ID: <ada17fb1-0935-461d-bb60-05beaeb2d0fe@amd.com>
Date: Sat, 29 Nov 2025 16:26:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 00/23] Type2 device basic support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <31dae6910b0863dee44069d01a909f8ed0b19bb2.camel@kernel.org>
 <d1de6633-e068-442f-98be-8d0cf5345f04@amd.com>
In-Reply-To: <d1de6633-e068-442f-98be-8d0cf5345f04@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf6903a-6782-4524-de41-08de2f6405d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVg2RitTZGxicTdDT1NwQitxZWVBbTBVc0RhaDlDcHVncitiS3pKenBRYlZ6?=
 =?utf-8?B?RTN4Q2doSDJHdjB5S2s4cEM3SEh2OW9VUkV5V3BKcHF0Y1RNeHFuSjRNdmlx?=
 =?utf-8?B?V0tRZkkrT2w4QlBhSXhKUFZjcE5jNDdxd3pacVBQbmpQeUV6S2dEMUluczhE?=
 =?utf-8?B?Zm1sL29IeG8yRzNja3RWUmVvMzlTV2t0L3RZZHkrSmV2UDA2UHZUeWJ5bjhC?=
 =?utf-8?B?MmJ3eGlNcFNzaUFxSGNhSmdWellsb2hYVk1lOWVQOGphUEZzMUJsRU9RYlFz?=
 =?utf-8?B?cUYyVk5EcFBKM3JaM1I4THpITkxNcmVtWndJZHVpS0pNM1NJTHlBMTBpcXVw?=
 =?utf-8?B?aVhmalpmUHhodzRXbFRvaUM4T25idUdyK0E2ekhPSU5LdkVuckZES0pDK3BC?=
 =?utf-8?B?WVFFTFBwUnVHdU1UWHE3dkdzN1cyNzYySWdJUmd1bTVPVjF3b2ZGQ1dzWnZ4?=
 =?utf-8?B?RkM4YUNNT3RZSTRtNWVjM2g4dlRHVG9NZ0dlbS9keWl2MkorelM1WlRDSHZU?=
 =?utf-8?B?cVBLK0pOZVZrYjV5dVJVbml6cEZmcWFrbkNBK3I1L3ZHQmhKWlNleEJjekJN?=
 =?utf-8?B?bVFmeEc1TDMxTmJvdzdCbGs3QTBoaVJjckk3anFSODFFdExrTysxWFVNdUNH?=
 =?utf-8?B?U2h2eWtwaEhTT3R1anBBU0I1c29XWkovQTg0clJPSWp2ZEVZc242V0YxMVli?=
 =?utf-8?B?UHlYZ2JxQnBTUTJ1VHpvSXFDeC9iK0xqbEcyaHRTN09lT0hJYmNkUWJzUER3?=
 =?utf-8?B?UFRQSE8vNHZXbWRpeGZqakpzb3A5a3kxQUJsY3pXVy94clFDdXE4TEUwUHZU?=
 =?utf-8?B?SEZzZnhMVUgycklGbXBUVGNscnphc21Qa2pnWFpFazNPMHNHdWtSVDJ2ZTcr?=
 =?utf-8?B?ZXIvaHNEQjZwR1BCSVJnbUNlMnJJUXVCdVBYNGpjUUJydXJzN3hJblM3MHgv?=
 =?utf-8?B?MDhSZ2FwRmZTanZsQllGd3VNUGQxMStDWEtqV0lrQWo4RUYxUmJHZ1B4aklC?=
 =?utf-8?B?d2pPakZFM0UzYlJwNGduOTZCMjIzRlFkS3hOSkxTd2lpK0NOOU5rRWpJcnNX?=
 =?utf-8?B?ZG5wOGNGQVVSMlRCYlFqemVEbm5TODNvTFFoTEhtWFJTNkFRV201Q3FGMzFv?=
 =?utf-8?B?NDdZYVE0V296cjFpVXA0czFVS0dLKzJEejVibXowVmd3ak8xQ3dma21VUEZm?=
 =?utf-8?B?NXdzR1RMRlg3cWxxVTdSNHF5bHBRZ0lFQlN0Q2liME9jNVpyV1Myc0dxS1Bz?=
 =?utf-8?B?VFVlUE9vL2dTa216WU9sbEp6dm5qVGtNbnhuODY1LzdSU3pRS0EzdGNEclpk?=
 =?utf-8?B?M0RRdGtrZUVRRENScjZLSElsSzBpY1R3Q2o3bXVaNElsUkl0cTFtVUhuVkRW?=
 =?utf-8?B?TmtZS1l3VXdFRitsZDJTcTNaOHBjKzF3THNDM2FzU3VOTkorRDF3V0JZc1FJ?=
 =?utf-8?B?VDhvb2V2Z0JRQmZBTXFFNGk0RllaYjBPWWZiOVc0Rmh6WGtMektLVDdXR2hO?=
 =?utf-8?B?VXhERmNIU0ZQZWgvUXRTVXlUcW16bmwxZ3FLUURjclI4eEIxdGpMTThxOFZP?=
 =?utf-8?B?TDM3dkF5MzQ2ejVOaUQvUzBURFk1UW9aMlh0ODBkNFJEbmgyY2tlbHpnMmpP?=
 =?utf-8?B?c1J1WDhtQ29GTFlCUTFuL0xFUk15ZWhGYnd1T3hkaTE5cXlzblNHMk1kd0N2?=
 =?utf-8?B?SHdta3hTWHltNWRxQ3gxYjNuVjNIMWFiZk5INXFBSUxHb3FoVmFnaWQ5ZGdM?=
 =?utf-8?B?eXRReUNyemtSNHFwc1VLQkN2UVVMU3kzNnh5YVl6TGRZaHJreTVxRGtUTlhV?=
 =?utf-8?B?UUhYUmYwQXJYYjZaU1kwUHhFYWZYS0lxdE1ObUpPOWtkaXorbEIyVjNjN2VF?=
 =?utf-8?B?bGlIdVlyeml3VThwbGJLZU1HV1NxejJNLzFwZ0dzMXZ3ZmpxV0UwWlJHeGk3?=
 =?utf-8?B?TzZhTGljWHlNZEZqcWtrZXA4SDVWem81Vis2NENncmlGc3pQZ2xmQ2xPY245?=
 =?utf-8?B?cElRemc0MjhHMk9aOFExMnI3eGF4MzdoY1R6UVFBMmNPWFlxcE5TTzhoTVRy?=
 =?utf-8?Q?TiR+a8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXJneldic1NQZ3BXNmx2Um5KVFlrV08wZUxxTkNPYnZpbEl6dHBwcDJKSVBV?=
 =?utf-8?B?TTNzUzVIdzNvZEdvelVUY1RXQWZlL0dSYTlRVmtnZTRZNGxiL0dZTHBCK0F0?=
 =?utf-8?B?eThMWVhMYXluZkg3dHR4MElkQWxnZ0VtTEs0Z09VenhrSkhSbHh2c0JQK3Ni?=
 =?utf-8?B?Y2FmcFJTdW9GNElKWGVXa0pvbE9zcGd2VHpGc2VYZ0w0c0tMN2NCbFpwTnZp?=
 =?utf-8?B?VUlJRitMTWJkeWxpWGNwVXRFMzc2OHRNV3lldnBoRWdubDNoUjlKaVM0Y3ZD?=
 =?utf-8?B?U1ZTRGttUnA4OWVYanc3Q2tiR0w1azJ6ZkFvakRiUGVLdVJVTHVST2pQNzVq?=
 =?utf-8?B?ZFZTSVBtU0RnVGM3eTJIemY1THMyL1BPZDVUQW1YWjJkZmVGQWRnVDlsV3hw?=
 =?utf-8?B?Zit4VS8yTVVDd2RaNW1uVDRzRERPT040Z1VxcVJIcXJDM3Z4OHZNTTl1VWY5?=
 =?utf-8?B?c1lSSzZTVm9QT1BwY3FMS3ZiQzlKb2RmRXdzbCtlUDVCZWp4cUZybGFhenFJ?=
 =?utf-8?B?dlZZREJneVkrOXZ3dnIvTHUyN1RnRElxTnhvYUZqYTBYdVlMdEhXdGdicTZ6?=
 =?utf-8?B?QWFkQ25Hcjd4WE5KZ1k5cGMvNGRoMFZRMFJjZjRHT3hBUFN6V2ljbksvQVhR?=
 =?utf-8?B?VERnWVdoVnNtcHY0bE9LdVpOeTlnRmRxdHpmbVF1NlhObi9iVkF2TVQ5Vnpz?=
 =?utf-8?B?a3VRbHhDSXRHZFNhUWVtTEhzYjZlTFZkZ3BTLzBCMjAya29OWjhZUm45MndO?=
 =?utf-8?B?eHI3OTdnMi8wRnZQbWJURlp2K2V3TnFnTWdYT2pzZGt5NkRCY3ZjeS85ZTFK?=
 =?utf-8?B?aVBDNXpiSzJrSEdTZ2R4VHcwdFdSQW9GRmEvRDFQSThpUFVJakpPRDBEOFRt?=
 =?utf-8?B?dEZQYzBVS0ZQOC85b3dTMTBVT0Y4T0JkTCtCRUNJMGtuOWJZcU13bGU1L1Jt?=
 =?utf-8?B?SmlSczhtNWhlTkVjdHk1NVFwUjFlQ2diR1RIUkZaSnhYMkFtTlY5UjhpZERM?=
 =?utf-8?B?ZVNNZmk1R0J4U3JIT0FzY0srUE1ML0Y1ZmZ3dXVrWDAxRm96UmpNTklvaFF0?=
 =?utf-8?B?OE84ZS9XQXdDNjVMMnlxUjlpbk5WOFFtYWxwU08zaTNiNEdkeDVFS2tKUC9t?=
 =?utf-8?B?UUZGZHJIUGVZNFBEQmdsMTlLc2svUXlPa2hWclI3UmJJWnA4TWg1Y3lzMXQv?=
 =?utf-8?B?MzAvV2VsY3FDVnlrd09YdzhNN01UREZBeEtveFlLV2NIZTlpb09vdnZVUldN?=
 =?utf-8?B?KzJJYTJ0ME5EVXpsbnBuQjRxUDFNM2NWcTNjMmoxQ2p4cEJqVjZYQVAzSUdL?=
 =?utf-8?B?azZDRnByWDhrUCtMSGhVZlBRTDM1eEhmRzlJcjV3YkNNN2xTOTAydjZZTXdC?=
 =?utf-8?B?dTIvVTdBZXc2Rm5IdFpZRkJ3Sk03cDN4WDZWdUY1WnpPWHozSDNyMWpFZ0F2?=
 =?utf-8?B?TGwzeWRKKzZ6d01HdHgrdG5UZjRCNmFvNEJQeExXTjdxVk9GM1NnSzkwL0Fm?=
 =?utf-8?B?QndVS1hwS2Y2QldlRW1Lbk9BaktVWDg0N1hxSGNoMVUrOE1WQzJ5akdsdTVx?=
 =?utf-8?B?cldqWHNIOHRGVlNGTjZIWTRwWFBkUnFwVWRDck5wVnRSZE9DOUYzU2VSSmNu?=
 =?utf-8?B?U2VoRE5LTTVselZnamQrWWRPZUdoMHBNQkZKUVpjWk10QWFCRTFROVJuSGlt?=
 =?utf-8?B?TDlRWVhwTllzaTc1cmw2d0ZFTUludmU5ZDI3QitGZExFbTd3eElFNXNqelNp?=
 =?utf-8?B?dTRQNUUwY0hVNmpJL290RHV4czVGM283L1dqR3dhQ2JzR20vdWFCdW1vbTBq?=
 =?utf-8?B?eGMrRk1VdjRHMGZGYU1aUEV6cjdyM3dLRlFlTTBETjg3UkdyRVMwRW91WDcy?=
 =?utf-8?B?OHJReUczZjRRajBFM1U2MDdVekgxcTNURmprbUFZQVpCb2IrWDEwL0pFUnVm?=
 =?utf-8?B?R3N0a1dqTnJ6cVNkMWczTHFGK25tU1RDKzN4RzNkOFcydGlCZUE2QkdPdVZ4?=
 =?utf-8?B?NDVyeUNSREdycnBXZjU1amwrMmF0MG53MFVmMGZpMkZNTytSd3ROTy9zRmhl?=
 =?utf-8?B?WlluUkFYVXQ2dFpyK0w0bUlhQU9TVzNLWW5mWHF6enY2Y3ptK21oYXpsMm50?=
 =?utf-8?Q?Z0LafoxLwUx3KF1ymZNxmCVTO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf6903a-6782-4524-de41-08de2f6405d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:26:17.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ShzVokxCGM8iJ+k7yPPjyiHsiOQOZBPJLPxTzK10JqXbteg+LsKWxihNaH0XTbjCDll2+QiCYwHozazrI4HoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001


On 11/28/25 20:29, Alejandro Lucero Palau wrote:
>
> On 11/28/25 19:44, PJ Waskiewicz wrote:
>> Hi Alejandro,
>>
>> On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
>> wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> The patchset should be applied on the described base commit then
>>> applying
>>> Terry's v13 about CXL error handling. The first 4 patches come from
>>> Dan's
>>> for-6.18/cxl-probe-order branch with minor modifications.
>>>
>>> v21 changes;
>>>
>>>    patch1-2: v20 patch1 splitted up doing the code move in the second
>>>         patch in v21. (Jonathan)
>>>      patch1-4: adding my Signed-off tag along with Dan's
>>>
>>>    patch5: fix duplication of CXL_NR_PARTITION definition
>>>
>>>    patch7: dropped the cxl test fixes removing unused function. It was
>>>       sent independently ahead of this version.
>>>
>>>    patch12: optimization for max free space calculation (Jonathan)
>>>
>>>    patch19: optimization for returning on error (Jonathan)
>>>
>> So I'm unable to get these patches working with a Type2 device that
>> just needs its existing resources auto-discovered by the CXL core.
>> These patches are assuming the underlying device will require full
>> setup and allocations for DPA and HPA.  I'd argue that a true Type2
>> device will not be doing that today with existing BIOS implementations.
>
>
> Well, I'd argue this patchset is what the sfc driver needs, which is 
> the client for this "initial Type2 basic support".
>
>
>> I've tested this behavior on both Intel and AMD platforms (GNR and
>> Turin), and they're behaving the same way.  Both will train up the
>> Type2 device, see there's an advertised CXL.mem region marked EFI
>> Special Purpose memory, and will map it and program the decoders.
>> These patches partially see those decoders are already programmed, but
>> does not bypass that fact, and still attemps to dynamically allocate,
>> configure, and commit, the whole flow.  This assumption fails the init
>> path.
>
>
> Fair enough. We knew about this and as I said, something I would 
> prefer to do as a follow up work or this patchset will be delayed, 
> likely until a new requirement is found out like the problem about 
> DVSEC BAR already being mapped, then waiting for the next thing not 
> covered in this "initial Type2 basic support".
>
>
>>
>> I think there needs to be a bit of a re-think here.  I briefly chatted
>> with Dan offline about this, and we do think a different approach is
>> likely needed.  The current CXL core for Type3 devices can handle when
>> the BIOS/platform firmware already discovers and maps resources, so we
>> should be able to do that for this case.
>
>
> I'm sad to hear that ... I'm getting internal pressure for getting 
> this Type2 done and I realize now it will require "a different 
> approach" for being accepted.
>
>
> Being honest, this is quite demoralizing. Maybe I'm not the right 
> person to get this through.
>
>

Feeling more positive today ...


Looking at my hack for solving this problem, what I suffered (as I did 
explain) with my testing with a BIOS not supporting yet the 
EFI_RESERVED_TYPE and the EFI_ADAPTER_INFO_PROTOCOL  protocol, I think 
it is possible to include the changes with some minor adjustments and 
without too much code. It relies on the same code than for Type3 when 
initializing the endpoint decoder, so the region will be created 
automatically at that point, although through the device creation + 
probe for the port and the region, so the way for the type2 driver to 
get the HPA to work with (iorenmap) needs to be based on other means 
since the region could not be there after the call for creation the memdev.


It brings other things to discuss about what the type2 should do on 
exit, since the endpoint HDM and the CXL Host Bridge HDM should not be 
modified then when doing the unwinding. So the sooner we can see what 
could be done the better for starting such discussion.


I will send v22 including this functionality early next week. Benjamin 
Cheatham solved this problem with a different approach, what, IMO, is 
more complex, mainly due to the region creation when endpoint decoder is 
initialised precluded by a check, which interestingly Ben proposed in 
earlier patchset versions ...


>
>> If you're going to be at Plumbers in a week or so, this would be a
>> great topic if we could grab a whiteboard somewhere and just hack on
>> it.  Otherwise we can also chat on the Discord (I just joined finally)
>>
>> Cheers,
>> -PJ

