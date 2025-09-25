Return-Path: <netdev+bounces-226230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD1B9E4FE
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FC73AE8D2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBCD2E8B9B;
	Thu, 25 Sep 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="axjDkvJ/"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0863A2E8E08;
	Thu, 25 Sep 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792342; cv=fail; b=p1pD0lOnTonEpfVlKAd/xWFtCndcgNp51wXIuneQ4oT6OG7PLuXuajoVRjpw9cw2gDBA6EdpP1C/xpm7DhlIfywOyB1Rzf3pAATDaBrSIqdxHHh+WXggQf4QlGekrbCk/RUTE2sgPve53XWvOJ2SCaGM+bEl5rzOu0llNbNiDb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792342; c=relaxed/simple;
	bh=lcMZQC8uawQdZf0kNXi/mFUlETTpdoTfdBkHcS2n+K4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDtk2sWfA1H0OVEvZ8f5tKbviKhLvXC4jECbxS23WyKibw3Op//qxnwpQcWDEVWdrtCa+nO1oCYaMLKE/hNX7exH80UCNTTVM7X5jrriB3ADJSPJbraPZNHKX3plYRuuDd3oO+fLjGUyiZxmQbIFzzVaBaL+BmnoodcrAZMMNg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=axjDkvJ/; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBMJTxO2Sy6Lya+mdz7tX6bZ07l2ZN3FBKd+LyYHyCkp8hvD+ymQjfBIPbj9pI3EI4RFOs3zyYJZrpCkLFva9rMCq6NiOvgFB47WTA4dsSo7KJsSvP/tgm2zLisit4mL6h36LB0v6TTBG3TLfjA6SeVFinGHvReNEyFjXzYRzD9l2Uf3Fp6Tff6AKDHvd4pWemV8qo2KzlI9xH6qDeJgAhK7wNgcqzPTiMrUP/R85MTD+JMuq0y6I34M29FuVbYGFBRuhYhg8tGQeB3kTPZQcN0OwDL8JXnDxkQkQHyswScRCQWntVMjSyL/vjk1BtgIXO6anFdTCs42IKrXiKql7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0k2P7BrZFXALlZCVmvqFs2Y6IVWzR8TxspWPj88NlY=;
 b=v5UfqCIWvuozZRNjBEvKWbztwmPQ06hRHij9FyqWIXEq2vOavgEgEHgzdcFfvoc2m0To5j8u7gO581Hwm2tpYt7r4hNpZHWb1tQFX7vcQTPSotCjvKpy91S4lxCZ8qqfQNLI9cfup6sLjrYHV6UuPBwQoNOcYlXkeew1yeMKER4RtgRub0kYNfeEakMBGQo74hVhXHDG99HuCVj52nKRvbyOwDp6pjD5uASO+vVVluZlOOtl8Vsx7lkm3/GOyjF1XHzaMk/CT73e25FNBF6rk6W3OiIN5N5ARSri1LAC2IAV5kuPfjGQOHTIXuS2t3ZSujTjhSwemPZOwwDsfjxhuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0k2P7BrZFXALlZCVmvqFs2Y6IVWzR8TxspWPj88NlY=;
 b=axjDkvJ/6X35UDsF8gmV/B47+hccj6Vr7RbNZwqrlvboSNHpIUMB5JPBFTDzR/Fp0t7yMRvRtq7K8Em7gKjCQptqnmVq+W4H5kQSejGPt+GYME2WLQ/bcme0Pneyq3TPuNksqta6DNyVog6q97chgJ0Z/s9DWs7zgU2ESuk6ao0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 09:25:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 09:25:38 +0000
Message-ID: <9f296075-dece-449c-9cf2-cbd080846755@amd.com>
Date: Thu, 25 Sep 2025 10:25:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 11/20] cxl: Define a driver interface for DPA
 allocation
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-12-alejandro.lucero-palau@amd.com>
 <0a95bc03-883c-4c84-8131-7a09cdb90be2@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <0a95bc03-883c-4c84-8131-7a09cdb90be2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0491.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: 3736fa82-4361-436f-8ce3-08ddfc157d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjZoVk9GaG05cWxOTGZpcUllRkxpTTliNjRLak9sdTc5QW5ISG5ib0RzcC9E?=
 =?utf-8?B?ZldjcXNvVWNDVGR4LzdhbFNNUitickorS3ZIaWF0cGJCeDV2VTdTcUg0OVJM?=
 =?utf-8?B?RGFURDdCejBoSlVYUmp3N0JhRnFYV2g1ODNYd2tFV3AvMmtNai8zOFljVDBv?=
 =?utf-8?B?eWtES0x1SUFZSVptMzA2SFUvY1laQUFIeHBLTmtQRWtRSmFmUHQxejFSbWdQ?=
 =?utf-8?B?WlZxTXVSVkMybHB1SHIxaFhWbzVMaE1pSFNtTnBjdnhXczU4aHZUNnhycGR1?=
 =?utf-8?B?UTdlNEpvNDhWZlhmdndrN3lDSEUyNXA3NG84cUdMcEszdlVheXlnTGJ2R0Q0?=
 =?utf-8?B?SXBCblpGTVdlcDlud09SU1h3aC9Dc0g1SkNlditTSHJyKzBuaTk0cVpkcXdz?=
 =?utf-8?B?SWg2K2RoVjJDR0lDNlhLL1RPZG5VdFNmN21YYmFPS04vcmZvQW1ZUDRTUlJN?=
 =?utf-8?B?SStrdjdLeWJrMXJEaDlOTUpGb0Joa1dhUWpQMnBBd2orY24yaERNOFd2L0RN?=
 =?utf-8?B?eGFTeVJKUXpheVg4cGZQRlllY0pLdXE2aUd6V2JtOEtFR1VXUnBISGcvdi9p?=
 =?utf-8?B?L3FDK3ZaNDE3TGZSbFIvdlJ0dkRWZTg4N1BaR2s4QmJJZXc2TUJiSTgvUVVU?=
 =?utf-8?B?QnFzS1pRVytBYmtvREZNZjQydUZybmFlU01nTXc0ZmJpRUE2UEJyMjlvSkV0?=
 =?utf-8?B?N0xod0xuQTlVakN4amhSbjVteWlqMm9vZTNKRGRVdnp2SVNFckdxem8zRXZ2?=
 =?utf-8?B?MlpjYWZJNjc1N0NvY3R3anJzQUhEbEpldTVQOTVlZ2Z2Tk9HNnR4ZlAyRXF4?=
 =?utf-8?B?SGU5NjdNU2loSG9GTC9iL0ZXSlo5TlZ3cFV5dG9DVnZZZFlDMmhnNWdBUTUw?=
 =?utf-8?B?N0psamU3bnF5b1M3OVdBTUhPcEsxb2Z3Mm5vTGhjVmpuZFBhVmFGSU1wN0hl?=
 =?utf-8?B?SStscW1RWDVxRXo0cVFoNGhYNS9JRkZmajUvSlgyMDE5SUVMWVVXUk4vRXNu?=
 =?utf-8?B?STUrZzdNZm9QTG8vcnZiQWR5eWRpcXRsRUZZbndNU3pwNHBFN0VDTUhUSCs3?=
 =?utf-8?B?ZjRGWGJnamw4T2xCZ2ovWWJMU29FOG5hMlI1clJJYlJWaXVLanlXK2dWS0M3?=
 =?utf-8?B?WHR5WlkvOHJNUUplVVdGeXloQ0p0WUp2bXZRNmxkbTdMTEswb2RkSkN0M0g3?=
 =?utf-8?B?bUpYdUhXSVZkOHVBZHNKYlVUa3pZTTBLTTFSRFRPSTc5RUdibkl1NUNheWpn?=
 =?utf-8?B?MHJHa21sTEJsNWR4YjE3c0FkdkpZVytLeVd4elFOMWFRSWttVHBnYXRjYlFE?=
 =?utf-8?B?QVR6cWM4d3YvaFJhSVdhdm1EWnpHZlhLUUsyZnNzNlNBeFc5R0p4aWVqc055?=
 =?utf-8?B?OGtJdGExQ3d3clBpbXNwbEVrUnpvV0JIMnkrUU04U25qVjdRalZHWCtiK0Fr?=
 =?utf-8?B?SlUwREFSUlNlSzlKYWE4RktJNENVUnZ4ZThuWDlMWlQvMWdvWFE0cFVia2ln?=
 =?utf-8?B?T0NaRGVRNXAvWlV3WGNrdk9ZZVhDZ3h6UFpQMGRYbmxBZDNjbVA2bHZ0Z2pq?=
 =?utf-8?B?dUhlZXdTSU1mcUpseHBkUXRPTE43eWVQbFBYQWdlQUNac0tmSzEwbWVKUWEv?=
 =?utf-8?B?c1JWWHRlVnVLK1A0eGJ6ZDFjSzdmSnhKQmtsVU9KaUlMQVdBQnhWajZsTklj?=
 =?utf-8?B?YjIySm9CUDc2eFZuQmgzUnpqdUU0MzFQMUkxNnVDVTBBVlN3OURtN0xrSElL?=
 =?utf-8?B?NGZIQjY3L3Q1MEZMZzZSSi9aK25xY09UNHhnTDQ0RjFzZW5rZlNZQnNjaGsy?=
 =?utf-8?B?bXZBUXI4M01EUjdRTFBjLzZwejZmdElMdk1mczd3ZTAxaTFyNExibDdRbGVy?=
 =?utf-8?B?SWNnRjExME1keDNjUUxlZWNvUUJ2ZWJ2TnFKZTk0bXYwSURKMG1SS1BmRHlH?=
 =?utf-8?B?RVhLYUthVm9NeHhoMHc5NU80TndQUXJ4Q0F0eE5rNjV0Y01PNjlKS2QvS2V5?=
 =?utf-8?B?VFRtbUZ4THN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1QxdVA4dlF4WGtOYWhHVHRqUDNVUUJ0V2JYVVJ3dU5Kby93bTdJNnppYmhF?=
 =?utf-8?B?dzhCWWkxTUlKZkdLVXpSTTVaVGFFd0VmeEtBZ2tDUUVuTTNReEFiWDYza2NV?=
 =?utf-8?B?Z2FQdGVBSitrdGlyVDIvcmUzUjFpd3hkNzV5RnBiQU5tY00yQXFWbnloZ0h1?=
 =?utf-8?B?TFJ0a3lpR2N4RFhZeGY3SWdZRVlTdSs5UTExVnV3OVNSb1BmcjFIT0JNd3Vw?=
 =?utf-8?B?WWU1Zjgwb3d0dlpPOXcvRldoQys1S3VqTEt3c0JjOW5GUWhvZ0x1RTg0cGs4?=
 =?utf-8?B?LzJLMFhOYmlaYURYa1Z4U3NFVzZPb0grbFNCamw2R2dTZDRnQ3Q5S3Y2Zkpm?=
 =?utf-8?B?R3lXWUFXWVhPd3YvSW1XNFJTNU9yTEF1NXVobWpuaE9DV2JZd0lyOGxISW9S?=
 =?utf-8?B?UFN5SHVlUHRzcWZjWnFnRVczZGNLbVprL1pLN1pqU3h2eENQNmRvKzZCV2xy?=
 =?utf-8?B?K1krb1BxNWdMTVBSMzhMemp5NHl1dXhHejkyRFQ3ci9hSzBwTUdkcFdadXND?=
 =?utf-8?B?alVZV1lMcS9YR2wrRXl0aHV4UVVUWG9tc0Z6dFViNGF0c2VBUGtDdFlTU0pp?=
 =?utf-8?B?TDFnL2FwS0tOOExzTkZVYVdHQlh3eDNPbEFwN0hHQW5vU0lxRXFYakZ0aFpT?=
 =?utf-8?B?S2I5RkhCZWFUeWFua3MrcDJRSDQ0S1pyTTRVcjVQSG5mcHNwTHoyeHJiMDNE?=
 =?utf-8?B?ZjlUYzNHVllKVnpqTWx0YlBNUXF5MzBuTmdWeHkzdnJtNWc1WVp6TjhvMENH?=
 =?utf-8?B?QkZxUnpLemw4SE1iTkpOcmhqLzlTNU5mSlMrcVBoSHFIYUlvcUNVSTBGcXdE?=
 =?utf-8?B?VnBMMEtlV0h0VzNzVDJBOUJpNEtiMzBtbVNtbllmSHJYUmU5K2dZSVFXa3Av?=
 =?utf-8?B?VEZFQ28wRHlrb05uaXdQeEkrQTEyMjNzUGh2RlEyeHNPMTJva3lNU1ZSNjgz?=
 =?utf-8?B?djJsUjBpMzJDYkRSdk1NY3dmbldGS3Y4R3FzOXJaVTBuemdrRG0yYW9LVVYw?=
 =?utf-8?B?QnNFOVFCRXFIL05jSHZ5cm5uOWxIWHp1Uk4zOWFtTGttN1ppeE0vaDdIbHJk?=
 =?utf-8?B?K2phVHNIZ21pbGsvTlBURnNYMXJHRVloaWtCNWhRRFRmdzBROEg2OUVFZ0lU?=
 =?utf-8?B?TWRPSGdQSkRzWnk1TXJjTHVFL0U1SERtUHNBUzZMUUZUS1FmTFhFZ0FoNVlq?=
 =?utf-8?B?dElERVlpSjhSUm41d1Nob2RrdkQ3Nm9tTXBQUWMzRkJ2eHg1NDFOOVJtdUNi?=
 =?utf-8?B?OXNnaWtXZnU4K29RaHVmUklqVHdlcGloUVl2eDViRWZiNWlkanRjTE9yaDAv?=
 =?utf-8?B?RWdXKzBRdWFkZUd0blJZaHYzbEl3VmtVdlFTN0I5YWJaMkxGZko0TFJXQkZ0?=
 =?utf-8?B?cnlUako4bUZtd25yVTdtNXlaUVhnTEdpZVlpRW9DM2c5ZG5vMTVpTEVyZGUx?=
 =?utf-8?B?bnlRQTRONWZzdDF5NFlxUlRyWHJibW9zSDZkVGxBellIQ0ZjcUF5c2hkdjZU?=
 =?utf-8?B?RlNCLzBDbmkrNWtFU084cXgrYW5zbnN0VFdDdmdVbG5HUTdQTDFhUVBTclRU?=
 =?utf-8?B?VjMwUVFWMllDSnlRUjBOMTE2WE80ekZ3QzhSOUs3cU1jdFlWSFQva2RudXRU?=
 =?utf-8?B?bUplVEJ6YWhxK1h0ZkZpcytpb1hFWmFyT0JFSmdaSzVQL1lNOEFwVEQ2YUZm?=
 =?utf-8?B?bU9uSGxpQmN5L1QyaUNyYWswZ0tjVWdHZHlrUkNrNkI2KzlGVXZsN0tZSWRv?=
 =?utf-8?B?eVU0MHhUV2hRd0lSMVpJYXgzNGp1NVREb3p5YmtmY1NibWM0NEdmTDFicWxO?=
 =?utf-8?B?c1dITFBqU2NEZGVOczFSNklkLzZ0YnE0eElRWGZHQnh5Um82QWtlTnkxckRB?=
 =?utf-8?B?Qk1heHRNQ01xZjR5ZFlWbEhNLy9hNkVWVFY0cTBZVEVRcytETmdhTHNjS0ZB?=
 =?utf-8?B?QWw5L3cxd2xPTGNQL1A0V2oxc0NFWE93VUJHZHFWa0hob1JFZlFJeDlQd2Zh?=
 =?utf-8?B?Z1hrRVorZFRJTm01dTNEOGxscVRJYW5kdTZ2Nm5POXlnM3VUWVplVU5JNG5i?=
 =?utf-8?B?cU9LUHlpWjRlOSsxWDQ4Q25ZUThuR1lMOTdUNmo3LzFCMEZueGVPeW9XSERR?=
 =?utf-8?Q?AI63swlF3AxPmBgeTeqZFeck1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3736fa82-4361-436f-8ce3-08ddfc157d34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:25:38.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cntx8iI16KU5aMS5BhhzK8nimMOlo++DeIRU4Hzufm8/rIwiJgs3bgqJuSFkfEnLtxlYtUpQ4a//8oK1Sl6MoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263


On 9/22/25 22:09, Cheatham, Benjamin wrote:
> On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space.
>>
>> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
>> that tries to allocate the DPA memory the driver requires to operate.The
>> memory requested should not be bigger than the max available HPA obtained
>> previously with cxl_get_hpa_freespace().
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h      |  1 +
>>   include/cxl/cxl.h      |  5 +++
>>   3 files changed, 89 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index e9e1d555cec6..d1b1d8ab348a 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/seq_file.h>
>>   #include <linux/device.h>
>>   #include <linux/delay.h>
>> +#include <cxl/cxl.h>
>>   
>>   #include "cxlmem.h"
>>   #include "core.h"
>> @@ -556,6 +557,13 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
>>   	return resource_contains(res, &_addr);
>>   }
>>   
>> +/**
>> + * cxl_dpa_free - release DPA (Device Physical Address)
>> + *
>> + * @cxled: endpoint decoder linked to the DPA
>> + *
>> + * Returns 0 or error.
>> + */
> Don't think you need this comment; it's not adding anything you can't get by just looking
> at the function header.


I think this is needed for proper docs generation even for the universal 
and simple int return.




