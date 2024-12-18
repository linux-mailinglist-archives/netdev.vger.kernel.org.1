Return-Path: <netdev+bounces-152858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE49F6062
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5A518851F5
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C1E158A09;
	Wed, 18 Dec 2024 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KmRfjIUo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D34A3C;
	Wed, 18 Dec 2024 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511582; cv=fail; b=hlCSLo7QUkJe1zsl7nsKc4zopHSCv3iUckgGEpsSDGTgwKvuXOew8cFissJDhy0UeESJ1LmCl5LicBh417IdxjuaDZqxdpMxal5pft+L8tSn32VFhm6smvnINUivbm9DBfMdMLJYi7bgjfyUyYihboFbByEYdqspWXpgjnV+h5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511582; c=relaxed/simple;
	bh=5CLeyEv2grLGgI7jz7JbufGiiueYSl4tx6/wgyBQfxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MMeKCY8FMQSPLbKUSqCUzX6+VDaJHO7ULyb+jvm1LSwhJ7lxkGFxcSn7lKsImYM+SC/qo2WUGQh6sCliaAgD6Dxp4n29lsNdllvPJ7fvM13mnNt7w1GRL/eN8DlaZLKYuiBE2xssq4922jvMPsNQYIN7DwMop32x2JS6tHYSlQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KmRfjIUo; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hkbou1+fn47Scmlk3me69S03R4s7RO9tAiOg/fBbeyBBIFbDnUnySdH63JBGXwJG980pOcybx3/GntZvEkmQbb07Q6q6F5H8upFgzFOUV121keDeHDH/gqvLqqlY2fL/QbyJ380XFWpKGLD3vZ0DyIqeE+zYsLNVw/ax2xQDzCmkLMBngZ2O6SyLMx7HEbfDGpvt3c926tswTEI/+v6jxVP4gv6uxIuaA8kaIn3tJTLtlXYl2Wr4boRHkumO6hZNAWshoNL9zIWmCASJPe1R9fwYVd6AKAutEdICq+1ZphTgXZUJu4HuQKNZNTcApB4tvF9ezyA794OJZK2fOZHjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNA/9tI4opCBkTU0xM+fesgTeVW/0dw6XRs6igxiI2g=;
 b=ZAJM5F0MLTDem9/pD8mh7slOlS9P4Ob6saVHcnLODISV8wbC7qUqGyvI0Zz6rdp4SFK5sos3ngcMkEjqn+3byNFkx1MAeh3Hk5nkulyJF12XbreKHXZ7Z94efSaeBt8E+9QWPpn9F1zlQVgu4WyATtDGRtvTizn+jojpxBjP3HCz7alVRGmNQ0OVoCkHrU08LJUiGm0Gvo42DwnAqHKxxw8ZVuodmW+flO7I6gMa7eBZQen+eOnV/qI64p9KwIew8OzzDmkHUFnnth0bUuBkp7App9j88zJtBXByjZBnZAEA/SPJ5jz3HTfOI4lHfNJUh6M9uO2ZmcZ3fSTmvuayjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNA/9tI4opCBkTU0xM+fesgTeVW/0dw6XRs6igxiI2g=;
 b=KmRfjIUo6eQiZBtbNuLCg7ccBVhcGcuSa/XNxO3jP4XgekSEibvtT6vu+KzO+/2xbJtW3bOwJscebBDP6eVvIF/8rHO0Us5/qAbfJmeuJS8XJ+FPb5XTG1EiSpcbE7ZiwHQ1oNK9JSm67GR/1EdgFcz8LpvHZxkE0qZQlDbLuk4nx2bGPCBt3fKUIqbT2FPirG2jQ0hoI8o1kmxU9DeY5GUCwwoIcUZweCLe073nZVKk1b0CGDYVeZxumv/OD7z1/TCvedeSMR+tjod2/3KAx4ED0jDRvp18hYA7u/QGNs2B0BpQCRXopHdfj7jcV+PAdJouG+koG4Pz4wHTCw59+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 08:46:18 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 08:46:18 +0000
Message-ID: <bf189e58-710f-49c2-a419-e3d3e71576ca@nvidia.com>
Date: Wed, 18 Dec 2024 10:46:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] percpu: Cast percpu pointer in PERCPU_PTR() via
 unsigned long
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20241021080856.48746-1-ubizjak@gmail.com>
 <20241021080856.48746-3-ubizjak@gmail.com>
 <7590f546-4021-4602-9252-0d525de35b52@nvidia.com>
 <CAFULd4aL+qVxyFquMTTQLyVFpVSc1DwcahJprj73RtvrW_XsXA@mail.gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAFULd4aL+qVxyFquMTTQLyVFpVSc1DwcahJprj73RtvrW_XsXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::10) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: a652cdd1-3183-4055-4612-08dd1f407073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVVQU05oYVhlZTdZVjhaNGxQOHY0ZldpTGpnYlZZd09hTVJkNHJORDVTK3FF?=
 =?utf-8?B?N0duV3JnbjJtbkFJZlNySmU3ZkpBZE5FR2E4OUhzLzJNaHBKYWpqTTB5eStQ?=
 =?utf-8?B?TjVNeE04L0hlQ1NwcUsvcUQ4ZGFmd21ZdUdnYkYyNkpiVmJXZFVFemdkNFhB?=
 =?utf-8?B?ZjBuY0hmM0U1WFZjWHNORVlWWEIvUWs2S3pyTytUOTBhaGxOUDFuUmZhZkx0?=
 =?utf-8?B?WHZ4dHBaR1dTS0lRZHBLN2krWGJzWjRaZFNWcmZVUGgvSFovRW93TTBNbGRx?=
 =?utf-8?B?a2tCeWs5T1FMN2hCK3NvTGlzSzZFcU5TUWRxWkcwRmRkL2NwM0h2Mm12UmtE?=
 =?utf-8?B?TnNOQ2JWSk9KQmhnS2ZwYVRDZlR1Mmh5dzRhK3hoVlFQL1BXd3NWQ2ZlS3Rp?=
 =?utf-8?B?Q2hMUjVoc3FXS1I1NFpraHJ3UXphYjdjSllUd0Z5TUlWbGl4S3Y5bUFhdkdR?=
 =?utf-8?B?czZqYUJRTHl1N2pyQnlRNnR2MUk3bmlsTUFDeFFzY3QxaDYzdVEzY3kwYjc0?=
 =?utf-8?B?SFBMSGhWUGxYN0hEMklON1BTMGZoQlRSdXc5djJDYmEwU0c2Q2ZJVktTaGdR?=
 =?utf-8?B?bVA0NzFKSXVSd1hMQjNBQjVwZ1l1ak11OGRKdHhqVkIvc3JjQWM0VkJKSUU2?=
 =?utf-8?B?WjJZaGkrbHovYkFZU0w0dFV4dzhWYTdkVVU5UFUrdkQ3S2ZVdC9NdmYzNDFS?=
 =?utf-8?B?amNEa05hZ0JYbm1SNVczaHY4VGJNYlA2UTduN3FYcnU0VnFyV1RyZHBHOUNz?=
 =?utf-8?B?TXFMRkg0a01oVExvcTJ4bW81YWpCTG9LcTNUWnBoaFVSV0Y0MzJnSGNkcXNS?=
 =?utf-8?B?SWF4MlV1ZHNXQmJyR2xkMURBTDNadGNPUE01SVBJU0ZWZmhJVVR5YktZT3p4?=
 =?utf-8?B?VzhkUEE3TEFvMjlIK2UwTitvdGZPUGMyQlVwMDU2bXI0N0dZcjBrQi9WeHJh?=
 =?utf-8?B?UDZvS2U2c3E1RURsSXFxUDNncWh0K0ZLaS9DK3ZkUWwxQ3dWMTgzZU9KbUpN?=
 =?utf-8?B?OVRZbC9pSm5wYmx5eXV5OTZnL1U1RzBMUWVXNlhmOCthMGg3VVFDR3MxOEt1?=
 =?utf-8?B?M1VuRUFZOXFxSEJOVzNsT3ladDVsc0lERktaZjNQUEc0eC9WTERGR1pScEtp?=
 =?utf-8?B?cFRsQW9EVVN1MGVWN1hVcDEva1NOQ1NpVGVqVmRIMnhRallUZHc1QTUzTHNR?=
 =?utf-8?B?bVI5c0kzaHdhVG16Mlh4dDUvMEZHNlZYS2M1MkhyZDJPUEZ0WnRxMEVZenpZ?=
 =?utf-8?B?T2sxdGFsNVRxNldJaVRvL1NsY2Zsd0xWTm4xZGIvcnJyd2JOK2xHVDIrNTlr?=
 =?utf-8?B?R0tKb3NMaEZ2RUVNYnN1YUdVZGd2ZlkyZjh6UDQ0dXVzQ1NRV3A5UHYvME12?=
 =?utf-8?B?Z1k2NVhmZ3NrSGxoTm9IWXN5N20wc3FNRHJuUWxNM0pBeG9JNjFONG1heDFM?=
 =?utf-8?B?dUs4K0R1UVVKbGxKcWtRSkpTaGpLQTY0MVVpdEdEU3d5dmg1WjVsN1d4QmtQ?=
 =?utf-8?B?a0RHWjQwLzdYdlVSRTZuU3U2ZEZpS3l1NTEyWVBidmJCWVVmWkNtNjNRNkdu?=
 =?utf-8?B?cVdOL3gwN0YyL1VXb29OdXBnU1lhamdsVTRMUEsySTdQQm9QRnN6dExUZ0I2?=
 =?utf-8?B?ai94bG9NTFZJNVR6QVBxNXlHbjNMcFFNeVUwRUVVeVhHcEtjOEdFa1hRREZy?=
 =?utf-8?B?eWtOLy8xNEVFdlJNRmtSckQrend5NDBPdldISk5CZXRZMExOMGlCRTdRSDRB?=
 =?utf-8?B?SUhNOUZ3dkVTWThiVlpNc2pjN0MvT1dKdFpTWStIL05seEkyd3JEcFU5TG5D?=
 =?utf-8?B?WVRGVFRRSGZJbEJmVU9vc3YycjNBem5jWXc4MFFDdVZSdU1EZmVwaC8yMTZQ?=
 =?utf-8?Q?gnJFv/hgp6H9a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEc0NzgzWEoyeFQ4S3J1azZjbHZydnhSYXl1QmJDbXZOQ1VDMFdsajZRbHhH?=
 =?utf-8?B?eEI2ejJQRSt5akttcUFWT0lTanhKNStYK2hQdlZBOTZTKzVOaFdzY0pVU0ZG?=
 =?utf-8?B?QXZlNGtwU1lwZFhGZDBBSGN5Rk8vaHp4YWN5TGZuZmJmS1BaT3ZReXZ0MTJw?=
 =?utf-8?B?bWZSNVpFQ0JKdEhkRzdteWdOcXUrRWZ1anBpOGxYbHJDNTNyNGdTMUZuMzMx?=
 =?utf-8?B?TzFmdmtsbmhnRGJkV2x6am5ES3lwWkdZMTNodk9sTEJuSjAvY01oT0ZrVXB4?=
 =?utf-8?B?N2dvTVRlemlsSWQrQnI1bkExRlNqeDFFVHV1WFlhbjJYZDlHYitNcS9QQURv?=
 =?utf-8?B?bEVzUEpSSVBrY3EzUlR5Z1N4K1IxaWd2WXlBN2YrdFc0ak5kZklsRTZPWktD?=
 =?utf-8?B?VTFZRStPRnZEWThsOGRjeEtKQUJPOHhNOE1NWExyU3dCQ0VHaDhoazJaLzdp?=
 =?utf-8?B?bmFqTElITkg3NnFIblJSZDRaeUlyeEJLT3RtWjdyMkVBbVBCTkltNlRyaEZm?=
 =?utf-8?B?VU1TZElLS2dZREtCeXEyb1VrR2FLYWVLb3R5RW1sWnBROUtvTEw0OTFqaklp?=
 =?utf-8?B?QUJZU2NUTk1jdWlTbmJCN0UwWmQ4cTBZMXhlaDMreThrYURDQzUwU1VtM25p?=
 =?utf-8?B?Sy9WbUZCZWhqZXIwR0NtWWVPcjdkRnVRM09UMk5IWjErOGhORjZrYkZJUGFR?=
 =?utf-8?B?aVV0bTRFWFluM1lvMjBqYXlnY3FPU3RuYnh3M0lBVEViSnp2b2lDa0lNUWgr?=
 =?utf-8?B?SVZhcEN6M3dEeWgwdTFvbmZwNjArRUpUUkIzVXpXWmJkK3F3bXAzSlVKclBr?=
 =?utf-8?B?R3RLd0ZteDlNTnN3TGNDT3JJVjhCOUduemd5dCtPRVB3aDd0N0NPTTcwWTZx?=
 =?utf-8?B?TzBHRVA1TklUVHZaVGZWdFdEeDNjV2NNYVpGSFFUdE13cCtSajFDQzFEcXBC?=
 =?utf-8?B?RUM0c0hSSC9ZVEk0djlZU2FzTk9iNnlGSjg1UEd2WGU2Y3JwOFdFRmEzQ3FF?=
 =?utf-8?B?Qmk1bjFXRjdKWlRnMFpEVi91dW9zUG5NbGFWMGNBSEM0L1ZoVFpQMWdkek5r?=
 =?utf-8?B?TlM1ZXpMRDdNRHA2WklDY21kK3RqZUxzWFpCV212dHhsMEdGcVlwb1hoVG01?=
 =?utf-8?B?SXhRNFk5cXdPY0NtOThmcFhOWnRoQ2NuL1JIMjFoUnBmZWlvMEd1WFRFejd2?=
 =?utf-8?B?YjhKZlVScHFJT281bkxJWFhSVXZYZGNmNXFQUW4wemMrc2M1Rks1ZVRXbWxB?=
 =?utf-8?B?WlRoZFJobC92SlJQYmtua0NMUXFOQkNGYzdveTl0ZnMwU3FBSzZ6ZnlqNm1i?=
 =?utf-8?B?Uk1pUTdELzdhb1kyMXV2OUtRaVc5VXZuM1M3QjYvNW5ydnIvRTJZaExVMHFT?=
 =?utf-8?B?MFBINDc5QS81cmE5M043eDJKcjBKWk90bjU1MHh2VkNxMEZxbTdhenpKUUZB?=
 =?utf-8?B?bWFoUThUZTEyenZKNWJHV2xCeHpvR0phQXhabGtHa29mYVplN3dFMVo3M3Z5?=
 =?utf-8?B?MDVMNmFud1hzWEMyLzRuRzduSWh0c1RtNWx4VElRTXJuQWdoKzJqeDdjNUlT?=
 =?utf-8?B?dG5HSXhFMWs3TjJlUTNPVkNPZDNYd1Zhd1MwTnlOQnV3aDhvSVo0cm15TXpQ?=
 =?utf-8?B?ekE3dDJOcFdzSS85S1JCeVZwbktmOFlIaEFFMWlBWUlWVEhPQUZ5YkgzQlFR?=
 =?utf-8?B?Q2V6bUVBQ3hNWEJNeHlxVHlkTXpSR0k3cFd1M2tidGxKQnhDUWN4QnRUWnMy?=
 =?utf-8?B?TzY2Y2k2OWtUV0MvUWJXQ2QzRkpnMDFQcHB2TVZYMFYwbUNUUGFsNDJTNm04?=
 =?utf-8?B?WVJ1R0J3VE16R3R2YkFxeGNBTjlSWkdQUFY5dWNQbXpncjBBbG0zM1pKQ0Y5?=
 =?utf-8?B?b2tSZi9LblNabHJiMVdpZE9qM1hwbG9saTdON3kwL0JubmkyZ2JUaHNVaFNt?=
 =?utf-8?B?cWg4bkhqVVNSTlVmdUZqNTd1SXNoUi9QMldnMDJhTGsxRFd5bm9DRk80QmMv?=
 =?utf-8?B?b3JrSEhMS0ZkMFNHNDFuSGdqSkQzZkphRC9TWWRRcHZBc0pScm13TzFVanVt?=
 =?utf-8?B?UVlRYS9PeUZBOGFacmYyS2ZxWEQ3RjNoODdSTDFhbHl3VTJZS3BDRVk3NklC?=
 =?utf-8?Q?SBEXOJnrcGcjSKTcGFca4efsg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a652cdd1-3183-4055-4612-08dd1f407073
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 08:46:18.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dyvg0T5+8CXPGFicK9iUz/+hrdnw1HG8APBL+rYj/rgLpowoipWmUZJLYGhJ1RC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038

On 18/12/2024 10:40, Uros Bizjak wrote:
> On Wed, Dec 18, 2024 at 8:54 AM Gal Pressman <gal@nvidia.com> wrote:
>>
>> On 21/10/2024 11:07, Uros Bizjak wrote:
>>> Cast pointer from percpu address space to generic (kernel) address
>>> space in PERCPU_PTR() macro via unsigned long intermediate cast [1].
>>> This intermediate cast is also required to avoid build failure
>>> when GCC's strict named address space checks for x86 targets [2]
>>> are enabled.
>>>
>>> Found by GCC's named address space checks.
>>>
>>> [1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-space-name
>>> [2] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Named-Address-Spaces
>>>
>>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
>>> Cc: Dennis Zhou <dennis@kernel.org>
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Cc: Christoph Lameter <cl@linux.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>>  include/linux/percpu-defs.h | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
>>> index e1cf7982424f..35842d1e3879 100644
>>> --- a/include/linux/percpu-defs.h
>>> +++ b/include/linux/percpu-defs.h
>>> @@ -221,7 +221,10 @@ do {                                                                     \
>>>  } while (0)
>>>
>>>  #define PERCPU_PTR(__p)                                                      \
>>> -     (typeof(*(__p)) __force __kernel *)(__p);
>>> +({                                                                   \
>>> +     unsigned long __pcpu_ptr = (__force unsigned long)(__p);        \
>>> +     (typeof(*(__p)) __force __kernel *)(__pcpu_ptr);                \
>>> +})
>>>
>>>  #ifdef CONFIG_SMP
>>>
>>
>> Hello Uros,
>>
>> We've encountered a kernel panic on boot [1] bisected to this patch.
>> I believe the patch is fine and the issue is caused by a compiler bug.
>> The panic reproduces when compiling the kernel with gcc 11.3.1, but does
>> not reproduce with latest gcc/clang.
>>
>> I have a patch that workarounds the issue by ditching the intermediate
>> variable and does the casting in a single line. Will that be enough to
>> solve the sparse/build issues?
> 
> Yes, single line like:
> 
> (typeof(*(__p)) __force __kernel *)(__force unsigned long)(__pcpu_ptr);
> 
> should be OK.
> 
> Thanks,
> Uros.

Awesome, I'll submit a patch unless I hear any objections.
Thanks Uros!

