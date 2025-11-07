Return-Path: <netdev+bounces-236788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C012C40241
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F35F189D51A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C072E7F02;
	Fri,  7 Nov 2025 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RZ4K8Wax"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4104B2E6CB3;
	Fri,  7 Nov 2025 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522556; cv=fail; b=FOT/0K2/AJKepBh/JK964NCTL29xeupgq8Oasn/9SvB7uLOgw5hwP532YQS4xQThmXb7WECUO3wrC+s1vBwBMxHdd+KlMzBMUmuj2FJ11pERwI/eNB21YXIgDgzWVGPmGcbmoevVBQo2LYgmEhSCW59H36EWphO5wB8w+8A3wsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522556; c=relaxed/simple;
	bh=txgQB6fTUVMfrkby7kmZEwE+kLWGFQV8CPJGpcTpvKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iZ90F9IqGJM6eDQodeUw0wjUFCHfuLvXIkvMt0BrrsWI/k/iH/kL4AwjOhl1mi6pxXgUNDiPlMt4BUtJBu1iuPJdf1MSWS7ehc9RmTYW34Rq4vBNG4M0tGYAWjlOBs4Xdooo5F/fvXALmtPYP2xNp2T+AnE4NKMKJ8HSg68Ua1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RZ4K8Wax; arc=fail smtp.client-ip=40.107.200.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHZWOIWl5Qgey1ZYkD4yVcd3thCrm3KCk9e4AgaTqR6STjCDnrlNQcCbHIlifWT9AbS2CX6oHU1XQhfjEJj7CzfZpuaT03FKRAhHDjIH/HZmJai8eG73fXVhsKA27lGJM6cqzjIKUHFbsuh9RiFEvIrKefs72uSC1Hf+sJEfMVZF3Icz3/+RTcUnarLkyW6aPwwrM8SYK/hhVQl/vmUegCAESIXkFM1vsabcjFShUk8qpdmILwcDoXvvElAykwDT6srmlYryvzcyu8cUWYSRXE86lLv77PzNngnI6qVVOYxpoTLaxlYf1U42wdd9vSBoDxSsgAYM/HRQOxan8o2wdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flcIANn0BlSEhOLob/9YkASWsfuWVHvTgMfWmiStBds=;
 b=bvLb4A04FMMBS+W/SvEL4PbqcpaP5YnFITP+meebE7qkkBUlOPMzi9mKRiWtAT1FYVHXSB7HD3VLphBQjOorEKXyfDxZ+omy8O25/1vs/kkYFmrBsWiDUnNCLECaIGkXyNcleEQAxjpFpjIMxwlNbRoTVhG+QqLLIrk0iNZEF74ekE9Z11D8QV0Ja6uBDMC57qWvzm6uA0RDGlzhMJpEESvRLgNjt0hV72pn7o6DlqX3zh7oEvawPnaBKw2tt2WYFVkykDxZJxVLPW6JeOPjBSFcUzRjioiTKETOQUmGTkkyN8fDOVprvgBahNKkGITyH1uiHDESexOKlbuc1xF6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flcIANn0BlSEhOLob/9YkASWsfuWVHvTgMfWmiStBds=;
 b=RZ4K8WaxyXrVydI/mgFGMorkTKBTJxYC3Xt20+cvlEN/bnbzt5/kNuYveinM1Q05TQuu5+ImOQi2GaqCIt7OVTZClELCXZeanqAjwtf0rOpQuOaSvJVHmTr7ZMLd9SJqK0tmmp49NwYmOug4oJMWLawBmBJf6Kh4cp9yDo8LgzVSKOKrx472pGmi51BvDEn8nMuJEXod8NBEq0kkdr0WVBnU0lvBqHrmiRRWvx7DOitBvnI/CdPwznYeRd720PwayVpFFbmZvXiFUAZtWfGVfaa/zvFkoRsKaQ5mR1NC+voDXHVtb4A7BoSkVft9YAdWmL3xP9JQur3btRN+DpRwKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 13:35:50 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 13:35:50 +0000
Date: Fri, 7 Nov 2025 13:35:44 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, Vedant Mathur <vedantmathur@google.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC
 page_pools
Message-ID: <k3h635mirxo3wichhpxosw4hxvfu67khqs2jyna3muhhj5pmvm@4t2gypnckuri>
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com>
 <20251105171142.13095017@kernel.org>
 <CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com>
 <20251105182210.7630c19e@kernel.org>
 <CAHS8izP0y1t4LU3nBj4h=3zw126dMtMNHUiXASuqDNyVuyhFYQ@mail.gmail.com>
 <qhi7uuq52irirmviv3xex6h5tc4w4x6kcjwhqh735un3kpcx5x@2phgy3mnmg4p>
 <20251106171833.72fe18a9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106171833.72fe18a9@kernel.org>
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e848f4-401d-47cd-f95d-08de1e0290a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEs2SWVVSm9WMTM5cTRkdjZlVGtZVUJxeGxMcnI1dnZCQzhjUjhRUk9PaXVE?=
 =?utf-8?B?TFFLT0djWW9QVEVOaDl0Q040bkYyMFd6d3psaDFYQ2lPQ3VtenR2cWlkWXJr?=
 =?utf-8?B?L2hkRWVLbndWcWRITk51dHpKWk1DaDVIbDY4dUZVZTUrSjJXaHNoeDQraGJh?=
 =?utf-8?B?NVV5b0Z2OTRvcFpVRGtJci9iSjAwUmVOclQ0Y3BpR2thbU96RVJlOFB6aFpM?=
 =?utf-8?B?MGVZS0RjaHpIYTI0V0NUTXRMRUZxZ2F1NzV3R1loNHB2b1o4R2ZkWXg3bzZK?=
 =?utf-8?B?dmhFc0xwUUVqKzZOb1p1aGtsNGt4RHJGUlBUcEM0UElUbnE1Vlo2aFRuWXMx?=
 =?utf-8?B?MVVaSkNpWWhOaUpYaHZzdFoxMFMxM1lsc0IrYkZqL01TN3VmMGRhTTNEUHU0?=
 =?utf-8?B?VGRsd3QwamMzRkx1YmlmeUNkNE9OWEh4S3FXcEtCV3lETHM3bHlyeWhVVnkx?=
 =?utf-8?B?YUxOcTRDNzVVNkxrcWJPZVVhZlhkcTBOM1hLSlhFa2ZyMFNENVJhS0orSnBp?=
 =?utf-8?B?UjNwQmNKRFB6SDFienVKeXhvSkRmeUxYT0RYTzdPOGh4TURvQXJQU2ZBTTlF?=
 =?utf-8?B?czVHSVVYZHRneXVrMno5bHltWHJSY3p4WFBhUTJFN3VhTnJQUFNvcWdvNmRi?=
 =?utf-8?B?dDhsbFJ5ZXlHSmFwQjBvV3hqNm5xTXI2aFpYOTBaOHhnZnRBckh2UUtySjcx?=
 =?utf-8?B?aFlHUVZWK093RWQ2MFhMNVErZmVNMHpkajA0M1NUU2l6YTlBcUdRWDlRNHZk?=
 =?utf-8?B?ZG5JRVEzbnRXUEM4Mk1aVVdJNEthbnZKZWlpdkFaSlhLOEdNQ2hsT1RYdWFu?=
 =?utf-8?B?NFNLclFEUDhsY2FrN2ZwcFRNQ01GQkNOS3ZpcmlxZ3kzMlppaXJFY0dYcGps?=
 =?utf-8?B?bXFiVjlSS1puZzN6cTBVdHQveVpzaHU3ci8xaVdiM0pZMXF2c1QzSGd2L1Vi?=
 =?utf-8?B?N1pTZFJJUDJ4T1MreTF3RU1MNVlocUszcUVrUjVIZG1XUEs4MzFYRDAycXk4?=
 =?utf-8?B?NVZsb3pTTlZQbHRrc2d2ckM4WFRtTWwwMXpDK282K0gzaS9Odk9oRnJ1dzI0?=
 =?utf-8?B?SWJNZVRBUlovVFlrRUxZcTBhV3F0UHpjYmZUNlZLSUVwQzRyTkVWZkFoRWRT?=
 =?utf-8?B?WFJoR0FPUTc1VWxXWGxSTWRSK3ZuQktnVnFLaktEaDFGMU9SdCtXdDg5Ulh3?=
 =?utf-8?B?aUxMQ1JHa1VpeGVNMDFuWCtVMXphM0kxaytIVjNOc0ZGMTkxeHpDTmszdWZD?=
 =?utf-8?B?dU44U01kRnBJekpoOHNEakhheE0vYkExdG96dlVZd1k2ZzFSVmh5T3dVZGRl?=
 =?utf-8?B?ZnYxNHRWMWNKNEVGcFVHc2d2MStkaTB6VWtoOVJZbFJ2a1crNHJmcGtJWFEv?=
 =?utf-8?B?Y05TeldpQmNWaEtxUVl4UDErakQrbHpDZm55YW9lcm9TaStHZkJMeldYVTFs?=
 =?utf-8?B?bUJWbFRtMFZ6Tm5GOU13aTc4dlMvYUVwaDBUc0ltNmNOWjJRbUd4K0ZsWHVo?=
 =?utf-8?B?S2laNmxVcVlqWEgwUVV3MXRvQUFjVHdQcGpONGNiM1A0ejZSNGpFdysyTnVi?=
 =?utf-8?B?enlOL3QvLzV0eENBNEhVSlo2NkVyRmV2YVlqa2xWYzNNaDNxSDNrRTBCVkpE?=
 =?utf-8?B?NEd6czFEeHU5akgyQndDV1N5STVxNEV2ODZxZVJIcVNjd2lXVUR0cDNXaTlJ?=
 =?utf-8?B?dC9ud0w1cFBKYWtrRVd0ZkthckhCNHpXSVNKTXpPUTNyM0RyWnNVZUFiN0lk?=
 =?utf-8?B?bWowTlBmK1NvYVM1T3NSL1NmTklVMENwZFV4YlQzUGc2V3o3NHJaSS93djFt?=
 =?utf-8?B?bVpmdE44TDg3YlUvajB0Q1RPTlF5Rmo2eDl2ZUU3M0RSQitVUllOTjFtRXRT?=
 =?utf-8?B?MEJhbHk1K2VlNDB1QWxkVXdFWTRpTmlLVVFSNHhZS1Y4ekhiMHdJcjFOY2hY?=
 =?utf-8?B?bmh0RE1YWnRZTFRvUXE2OThrVk1NQVV1TnRJdUpYaHZKMm1YWG5PemJjRnBB?=
 =?utf-8?B?SGFjdkI1NFpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a00waERTKzRHcEFObEdPVTMyVEVBSXgxY0ZXV21YdDFET0dZTzVzYjZCUkJi?=
 =?utf-8?B?VDNrTm15QWtwK2R1MnowSG1hOUJhSHlFZVdadHBJNGhheWJmQm80RFdQWHdI?=
 =?utf-8?B?T0pzWUVobkdLc2dyWXkrK3ZNZlNSNXVsUFh2bWxaZ3MzSWpvSUlscXlRbmk2?=
 =?utf-8?B?WEV5M2NPTSs5Mk9Eak1qdUpXaDk1M2VSZVROTUlrTFRLc0gwdVZqWmV2SUhI?=
 =?utf-8?B?U2NqSFdYMmM5TnpKUm1JUWpiNlg4UFZ3L2RJZ3NreU9VeWZKWWlNd0RuOGVD?=
 =?utf-8?B?dGNXWWpGWlE5Ykl3S2Q1QXgvdFlYcGx1U2VYbzVYZE9OZ2E0eDhneVJOdjlx?=
 =?utf-8?B?cmlvc2pKVStHWEZEeVhvZEV1eERCQXVSV1hURFVQV2NVVjE1VGRtK1p4WHVK?=
 =?utf-8?B?SzliVUhsUnJ0bjVrbnM4NkU5NFJwUU93M21JemFwUjVHRDhnZHArVUNGQVBh?=
 =?utf-8?B?R25iWHB4L2hHZU1vTCtVdFN3MUVjQytwbXdLQTM2cEw1bGFubUV0ZVhWOVQw?=
 =?utf-8?B?elRCVDJNWjFkTmw3S0hPT1dqWFoyd0FmcXU2V0U2cHVkblV3OXB4ZVZBY05K?=
 =?utf-8?B?cE05SW0zWnlFSTJoMGFoRzYxNWhaTHNQTUpvRmlxRmFNdWtLRkVKV2poOHQ4?=
 =?utf-8?B?WWF0L0svRzBmYkFFNGZndkxNQ2ZKWFhxUEhYTFhPZzVoV05MK3FHZnZhL3dX?=
 =?utf-8?B?WTZSR3V1Mi9Nbm9SMG84bEtDdytNOWFLZ2FyaW1DZmRCUW1DWHBlQXZUb3VY?=
 =?utf-8?B?MitJZWpUMXltY2JCZjZJYVVTR25McGlvcy81K0JMS0JDRktzZXlrU2Fpemk0?=
 =?utf-8?B?cHJrYTN1bUUzemsvcDFFQjZKRXdrUmxPSGlsRHhEMnE1NWpvN0JudXAwbEVq?=
 =?utf-8?B?UXg2QzNSWUJETXhmdGMwNU9GdVJxL01aaDMyRGlMM0pMS3c3aHB6c205WnZi?=
 =?utf-8?B?Z0VzMEVlSDJzZG1SWWtXTUJjblYzcmE3NmJQN29XcmROVjZCaGlEQ3RrQVlw?=
 =?utf-8?B?R2t4TEdPd3FjM2FpZk9wYS9nQk52dVlFMW5sOWpDbkM1NlhoYmhUZHZFVC8v?=
 =?utf-8?B?bkJvVzg0bzh5M1gvVXozcml0V0lSam9TZDc3amlSb2JHLzRCUzdaYUZUaEts?=
 =?utf-8?B?Z0ZVSVBPYXlzbnZTOGlEVTNaVGdmK3NhcnhkSVRicnZtRk9rQW5ZYjBLc1VP?=
 =?utf-8?B?OWhuSEpNbUY1QmlqNGZMcjZNSUVYWXUxL0VRTG8wS0N1U0MwYU92QVMyd0N1?=
 =?utf-8?B?RWdkNDBTU1VKd1JTbWtadXFxNXlaSnVRSTQyVzlhS3MraHk0Z1RYdEJvcXl2?=
 =?utf-8?B?dk45MjFJOE1rdFYyQW1ZNEFpakFMUms4bFhtdkYwRmxSd2RvOG1vbnBUVmdh?=
 =?utf-8?B?ZVZkQ2xZNUFjdHdFUjhyS2Nhd2xsK1JHRFZUT2RCTmNwODREV1gvMlhBTEVm?=
 =?utf-8?B?TEYvK2ZVN002ZlNnSTg5U041M1M2cVBIR1pNamFrcWtGYWJiWFY1K1BNdmNP?=
 =?utf-8?B?My92RzYrdzEzQ1N2ejU5enh1U3FHNXIxM1AvTFZXbVdPR2R6THMzWlNTandR?=
 =?utf-8?B?dzdrbTJpQ0VCWCtHbm1ZU2pqaUNUdmZDSzNFZjE4WDZNd01ITzhNK1V0M2Ri?=
 =?utf-8?B?eUFqUHgxejJwUzZhRDNKSjVUa3d1bm1GMjJUWDhObENHOGlsYUs2TDR0dVJT?=
 =?utf-8?B?QVZVdjh3aFJPd1ZSNVYyS3gxOVVveWtZZTRIS3dxNnlHemd0NWtpcFJUMFVK?=
 =?utf-8?B?WHlnT0ZIWEtZWkRkcHl3cXRINzh5b2hkR1ExVWl4SjBBL1hxWWZkeEsvUElZ?=
 =?utf-8?B?bHEvZG9jeVJFTkwwVzdrN052enVoM1licGxNdTRnMG53T3FPYVZYZTk5YzlH?=
 =?utf-8?B?Vm9xcHZqOGdSZFp3bmg0TEZmVTM5bUlGSzhLTW9LcFBUakI2Y3NUcVJYTHph?=
 =?utf-8?B?dVd3RDJ3enVveFJZc1ZkS2ltY2dwQ2Jkd2h3S0JIeFVrS0xrS2F5ZkRnNTJn?=
 =?utf-8?B?TVpQZytaS1JKQ2J6ZVZJdlhCbTJjUlplWTZoM3J6bm1oN2J5SUFYNWN5SHJy?=
 =?utf-8?B?bUh4bGdPUU1naGJwMTRPME5PVlJ6VDlsa1E0UnNYc0xaeVdEWFVmRlFLYmlG?=
 =?utf-8?Q?i0htVD1c1vI54J5U77XzpaeAm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e848f4-401d-47cd-f95d-08de1e0290a6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 13:35:50.1403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1K7yUSc70F6rg8XorOK3isVCDVXlNx0sYRnN7tNyvqQbpMd70kV473+F+XGLGZiXl8zJZOmF4Y2bAyUKPmU0sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158

On Thu, Nov 06, 2025 at 05:18:33PM -0800, Jakub Kicinski wrote:
> On Thu, 6 Nov 2025 17:25:43 +0000 Dragos Tatulea wrote:
> > On Wed, Nov 05, 2025 at 06:56:46PM -0800, Mina Almasry wrote:
> > > On Wed, Nov 5, 2025 at 6:22 PM Jakub Kicinski <kuba@kernel.org> wrote:  
> > > > Increasing cache sizes to the max seems very hacky at best.
> > > > The underlying implementation uses genpool and doesn't even
> > > > bother to do batching.
> > > 
> > > OK, my bad. I tried to think through downsides of arbitrarily
> > > increasing the ring size in a ZC scenario where the underlying memory
> > > is pre-pinned and allocated anyway, and I couldn't think of any, but I
> > > won't argue the point any further.
> > >   
> > I see a similar issue with io_uring as well: for a 9K MTU with 4K ring
> > size there are ~1% allocation errors during a simple zcrx test.
> > 
> > mlx5 calculates 16K pages and the io_uring zcrx buffer matches exactly
> > that size (16K * 4K). Increasing the buffer doesn't help because the
> > pool size is still what the driver asked for (+ also the
> > internal pool limit). Even worse: eventually ENOSPC is returned to the
> > application. But maybe this error has a different fix.
> 
> Hm, yes, did you trace it all the way to where it comes from?
> page pool itself does not have any ENOSPC AFAICT. If the cache
> is full we free the page back to the provider via .release_netmem
>
Yes I did. It happens in io_cqe_cache_refill() when there are no more
CQEs:
https://elixir.bootlin.com/linux/v6.17.7/source/io_uring/io_uring.c#L775

Looking at the code in zcrx I see that the amount of RQ entries and CQ
entries is 4K, which matches the device ring size, but doesn't match the
amount of pages available in the buffer:
https://github.com/isilence/liburing/blob/zcrx/rx-buf-len/examples/zcrx.c#L410
https://github.com/isilence/liburing/blob/zcrx/rx-buf-len/examples/zcrx.c#L176

Doubling the CQs (or both RQ and CQ size) makes the ENOSPC go away.

> > Adapting the pool size to the io_uring buffer size works very well. The
> > allocation errors are gone and performance is improved.
> > 
> > AFAIU, a page_pool with underlying pre-allocated memory is not really a
> > cache. So it is useful to be able to adapt to the capacity reserved by
> > the application.
> > 
> > Maybe one could argue that the zcrx example from liburing could also be
> > improved. But one thing is sure: aligning the buffer size to the
> > page_pool size calculated by the driver based on ring size and MTU
> > is a hassle. If the application provides a large enough buffer, things
> > should "just work".
> 
> Yes, there should be no ENOSPC. I think io_uring is more thorough
> in handling the corner cases so what you're describing is more of 
> a concern..
>
Is this error something that io_uring should fix or is this similar to
EAGAIN where the application has to retry?

> Keep in mind that we expect multiple page pools from one provider.
> We want the pages to flow back to the MP level so other PPs can grab
> them.
>
Oh, right, I forgot... And this can happen now only for devmem though,
right?

Still, this is an additional reason to give more control to the MP
over the page_pool config, right?

[...]

Thanks,
Dragos

