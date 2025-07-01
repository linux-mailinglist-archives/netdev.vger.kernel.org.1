Return-Path: <netdev+bounces-202952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F83AEFE2F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BD3445F9E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2921A27EFED;
	Tue,  1 Jul 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u1JsZ+eS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761B27E7F0;
	Tue,  1 Jul 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383551; cv=fail; b=noEQ6zMgrLGe4wXDegiq+PzOqLOwKgkccPx1U6dnk8eu2K9WcUAcfsdmwA+bd6eyjvWwFlSEDACkL5fxByrS2K/Ep1cPl+pXcMPL26njLEhRNm+z0qL3yq/lsyIQT/c2z+K8CG2LXvCPMD95NKufVSH5j9NdRwDxZb8TObScDz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383551; c=relaxed/simple;
	bh=3zHxTE43XCVPvboD+Eu+Sxt0gff3PW+HRvKeZ4UYUPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tDNrpSiyQx4o2XOY5bTyKSGEGYOQ6sRyAoj7JErQ6ZJbgq33dzrU5aliTA81UoBlRCt6gsUwTP1w4j+vOwm8m3OR896T3bRTAiS2qwnBY8Qs5ZarBiuK/pfzkFMa7oRASG/ts2A+66UL/3DJ8rUO4Nun7XPppGoW8ksU5qimDzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u1JsZ+eS; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH5YOcqvxi+E4YkB5Rmf46/vFjMKKBepIsDz5Ex51JkjkojmOlUiYpH9BzW+FUmG2O571s87QFtBVsJ5rWZfNPFJzFtq70UfKqBMmjVFod+hSp9DWLTdV7/CP2d3qJY9gS9vkFFv8J3xDzsuZa/z8mMsD3NItFMOzHGEH19r8wcyPrGNCmgKZZQcKX253qbd+mzMzIbNFH3yw9/OcW7z8p0z8DrkodOUSOdw0Oq2KS3KqhFzAguelvVEAyFvFYejx/K0hW8iwX+NdMKkF3DAFRPiZhZ/4jPx54UgJf9ugxV8P+ViIJmXF6A4vCeiRcTmxIND9P0gKuD4mUvNnzAANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFOvREISKYmlGCeZ33RJEsJjl7ldJsnmdw+mIZ5RSgs=;
 b=RfQszMCol7lbl6YmsZ7iY6yALkxLZ29UygJagxe+FDXkNyrejqh7Jhck+i6bCUzmYGEJUzAEHBO8MAS727njRAeKAEfPnnunLXO2+dWA4tlOVEgHaCCx4QflxgM07NkIfIN7+C3n5YNQr+KgG2QfacmZD0MHfKOETiKnts9yIC8BnkvQuy0n3DME6J5GkbUfwpWGlDDmc0Ff1pnLejU86D3CrVwViShTzqSZX1ui8BYryuRWLBec4SQvD/oqZ6IcJYyq6DKKPwODswWyOC/XCwvEHc/IV8SqIDvSRo0jFpo8I966nK8x0cinO/XcfbO+CEW0gf+/cK7PhFURsKp1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFOvREISKYmlGCeZ33RJEsJjl7ldJsnmdw+mIZ5RSgs=;
 b=u1JsZ+eSBy9IH4tQPmwaDemWUFhNqvgbPCKhp5og6bsa2SKfuxz1pG56j1oFGxxeZPZrg5t70T+fq5s5dEm60KD8urxnsVhKwdg9wDyLNrP3gfJXVyprQg+rPYtnE1xHItrKuobGHX5wrX5Hv3KjgoC54E2MbXLMVYxSsWixims=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 15:25:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 15:25:47 +0000
Message-ID: <a935a07a-e81f-4a60-8ea8-017e2a6593fd@amd.com>
Date: Tue, 1 Jul 2025 16:25:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 06/22] cxl: Support dpa initialization without a
 mailbox
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-7-alejandro.lucero-palau@amd.com>
 <20250627094332.0000223d@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627094332.0000223d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0277.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::21) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: b31a7ed2-ee9b-4d6c-139e-08ddb8b38d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?empMNS80TjBzR0d6Ty9Ha0UrT3V2YVFiYk1yV3pqV0xKVUtUL3daN0tBVlp5?=
 =?utf-8?B?MEFBZWtYaDZVZEFiaE5VeTdaNWF2MVhxRGNrTHVIcmt2cUtVQk80RUhiTU5w?=
 =?utf-8?B?SzVjN3VDUWdHUG9QdkdsRWM5ZkVkNjZwaCtEdFNQNEFKVDg3QjZNNnVvcDlT?=
 =?utf-8?B?cHkvekhhL01tZXFXcDJUL29nUGhuK004NVNUZUY1M202cjJiaW5DUGpjaW0y?=
 =?utf-8?B?cGFJNi91akVGYW5mTUVDdVNTK1Zvc2E2VzY1TUdzYVd6WU96ZDN5eHpoN3Vy?=
 =?utf-8?B?UGg0Slk1S2xuNVpTa3FIcDVPbnc0UWI5T1g2cytYZUxYcWtjaGxvdTlHak9h?=
 =?utf-8?B?cm1qUm5ZME5VMkhMeWxxSGpENElwYmxTeGdzNW1yeEo5VTFEb3dxS3VqRHE3?=
 =?utf-8?B?cXA4cFN2Y3NBRnQva3NCY250dmxnUU9LOGlGTURYYVFGdFdGUEtuckZBdWw4?=
 =?utf-8?B?U2hvWlBGU1hSYVRqWGtXb1F5dGFyUFF5ZlViRExMZEwvZzBnbjdLSnNNQ1VZ?=
 =?utf-8?B?M2VrdiswWGhjK09RRi9iZHBBdC9wT1VkcXEyYmcxZTBJWFhaNzFEWmJUaUtY?=
 =?utf-8?B?UkVnNURHUGZDRXovNFQrb210Uk1sbFFwVU1nVWhVbnVaa0dmZ2tEWDQyZlZV?=
 =?utf-8?B?eHRGR1RkZEpJT2I1Ym05dkxBY3JCWktHOU8xNnNRSmRqOXkweERzcHIrNGlS?=
 =?utf-8?B?R2k3Ti9YUlBkVWQrRUUvRGgwTWlOb3dQMURCMnpRU2svcFVZMVM0Vko4clkv?=
 =?utf-8?B?Zi9JcUR3blc3UmZPYjZzWDN6b0g3emRSc2cva1dScWF6T1hjNk56V1dWRXRY?=
 =?utf-8?B?bUk3SmpoTWVBbHgxL3Rlam93Y29jSFpIdExweWJkdjdyMCtTVGNNUjFzaS9P?=
 =?utf-8?B?NEJjRmZnUGF0aXVtWGd1aExsV09wbTBKSDQ5WlBuQnpCQkxMcXlsZ2gyYjJ3?=
 =?utf-8?B?VzZKem1oRWxCcC9nS09EQklrNGJDWlFLRi94Z25DWDF5MHE3clRwTTE4RjVQ?=
 =?utf-8?B?QlMydE9Za3ZrWi9IUGpkbzJLNlZaRExrbElSQ1RUQ0xmWGlXWDdtNmJEdE00?=
 =?utf-8?B?Qi9lMjZoKzRHejNlemNQSXVSMlZhWGJ2N01hcWUxUEczSVdVbERkRmEzTG4v?=
 =?utf-8?B?UTJXTFNSa0JrclNxZkFsV3Z2UUFnQkI0bEFMcFFhcXRKZTM5TTdWREo2WW1W?=
 =?utf-8?B?SDlROThwa01RcThKK3E5c0QranF6bmcybnMydm41ZUlWNTlGT0IvQk1wdm9N?=
 =?utf-8?B?WFJDaVdScmN4bkZHRHlLWDFoaEdHV2Q1eC81NjNNN0RxN0tTenRmS05xRkNm?=
 =?utf-8?B?UnQyTzZBM3cxRjJjUCtlNkNCa292U1lNT0plSng2RENEMlovSFRDWjZuN1c1?=
 =?utf-8?B?cDF2NU9MZHNmd2ZUTmMrSjUrcVZPWlE4dTFqQ01RaFFVb2JGUXIrRkQ5UkhF?=
 =?utf-8?B?VWRuYnVaeTIxaW5EaVhOU1hIRjJsRit5S1FTY0tETitvOEpuc0JPMFVoUktr?=
 =?utf-8?B?R1EyQTd2VmdWcUhOTG54WVlPd1VUdDArNUlhbEFYdnlQTGI4ZzlSZnN3S3Vk?=
 =?utf-8?B?dXgyRTRXcE1zT1ZmZjdUSFZ6bEJVNmRCb2oxcSsrT3ZIcHZKb3JUOTlPWkF2?=
 =?utf-8?B?NVZJK3ZTTkg5bFNsc242K0FYL0NpMjVTbDZlTmZ4dUhFNXhZQ1RWNW9vSUR5?=
 =?utf-8?B?Y28xcFRNM252ckttVkJlWUpmcTJvTkI2QmUzOTV4Z1ZIaUE4ZWFGT084NlNr?=
 =?utf-8?B?VVRGZzA3OEZ5cXFFbWwrTW9vRjZWbHJlMUJOREsyV0JIYmZ6MTNmcmtoeG9x?=
 =?utf-8?B?UjJqWmg3bDBtc1R2cUhOQWU4SGg4d05wdG5UeVhvZ3U3TFNGWnFQRkJ4VVlu?=
 =?utf-8?B?S2N2ajVac05WQ2pldmpkakgyYW5COWlwa29hY3NvS0JDSXl5ZmxyaTZrK3Va?=
 =?utf-8?Q?9m6GJnB+b0k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm9wQmdFcnQzNFh2MWJ2SFZ1SkFEeGI5SUI4aFFZVkNsb3g3OWE4LzgvcVRK?=
 =?utf-8?B?K3BpR3puamx5d2NJMVE0S3NsOXEwczlIQ00yWnFRSTlNQi9pVFlMdmdSU3VS?=
 =?utf-8?B?SDVPTDh6WDRTczg4QmtNQm9sNXdNTVBhT1NxbUxWTGk2S2pLOHBpcmtpSTVI?=
 =?utf-8?B?QTZ6Z2VmRGVpcnpnbWhEQ2doODNGY1ZBVVQ2UlpPK3FybzB1WUxMMXZkWExJ?=
 =?utf-8?B?S2IyYmNTRmE5bmlaZHZGdHpUUXJCeHhuMGFocDRUcWlEeU5UVXJ4WlYwSFdY?=
 =?utf-8?B?L1NHaXV0VzMxRGNSVlRkMThYNUhWL2dIVnAzR2NyRk93S1Y2dXI3YmJieTI1?=
 =?utf-8?B?ME1SaTRwWFZpakl2WUMwc2hqMmtUTlJrblZuRGlOYk92c3o0Q2tQdVFqOC9j?=
 =?utf-8?B?c2hyZkhyZUp6aVpuOFByMXBKVCs1c2hvNTdHSklVQzBreExFVzlibjE5NTVE?=
 =?utf-8?B?YUo4cThyVUtXUDV4V3kySExpUEZKK2V6aTRBZStKK2E0UDlRUHhnd3Nna2xw?=
 =?utf-8?B?QUh5YzdQNHRKOEFSMmpFT3VlK1FBSXhrU3JxTkdzQytPaVVmYjJTREQzUEI2?=
 =?utf-8?B?RUdUMUNiVkZTdU43a0tUay9OUjdKS0ZoZGZDNTdLOStYMG9jcnBiWEFEaTNN?=
 =?utf-8?B?U1hORXhYa1dLTTZrSFAzYzl0V3hmTS9ROHVqSlE5dU1qSWtvaWd0WURObkFu?=
 =?utf-8?B?L0h4dFhybTZMTlBjcndUak5QbmRwcmRHakd6U0doNFlhN285S0FCei90MXla?=
 =?utf-8?B?OVJLTlV1YzVIL0tDZy9oN3RnaXdtVkZMRFJoY2lwcDFPZy9vQXlrWjUrK09Z?=
 =?utf-8?B?NnJZR3M3SW9YRzVHVVFSb3puNElhcFplNDUzOXk3MVZpdDhpSGxGTHBCL1M4?=
 =?utf-8?B?Z2ZRZnFUc3I5ZGZXM2w1YmgzSTRnUy8vY2VVU3ZvekZRMlN2dkswWUk5Ukt2?=
 =?utf-8?B?U09MYXI2UUFDMXRnOUZ0WXhvbEE1a1BWZ1F4bGtiUGFWeEF2T21KZjlwcmZR?=
 =?utf-8?B?c29KQkFGWU56VEVzbWVFcmsvRjdDdEtEWmJXbG0wVldRM1IyazJkRlJrUDlE?=
 =?utf-8?B?N2RVZ3FyZXVxTTBUSlBFZ3pya1A1R1Rqa0pOM2c3ZUpacXdQSnJ3YWdOQWVp?=
 =?utf-8?B?L2d4dGgxUVJsZXNUMGxmTUQ4YXc5YUNJbFlJbDlKK3p5U3BUb1RhSGNNWmRO?=
 =?utf-8?B?eDV1WXBHbWd2eGdMZFJGVEVpdDR4R21yVE9lWjFGd1BOQmphRVhjUFh0SFpM?=
 =?utf-8?B?bzg2cXpSUHc1d2MrcHZRRjhBc3ZTYlBwczJXTUxseUgvbGpxZFdBY0wxZVM4?=
 =?utf-8?B?eFJSV3hxcXhNY2FoNk5FWnBrMDlUWVNyUU02YTNybXgrb3NHZXJBQ1UrZUxL?=
 =?utf-8?B?VFl0UjA0ZzhGbkcxNWpxcjE3RGRZWi9BVVdwbWpkSmRsR0d4d3YwSk8yTEdv?=
 =?utf-8?B?UWRvUnBaa2dOUDdVWGRyZlNKQjZuT2daSWxGOTl4QjBrTzZ6U0k5RVUvQjNU?=
 =?utf-8?B?dVdSeHc3UkNVNStYRnh4cFJ0RFozMjRWMjlIRmdFOTBqdXdNQWwySlBweFdt?=
 =?utf-8?B?OE4yNU85S0dpN3FqZWFCeVBEajA5dTN0bTFmSExvcTdVOVdpelc4a21jMHda?=
 =?utf-8?B?ZWpwOWltWHJyZXdveUY4clA0ZXhVc1k5RGppaUxTNmVaUGpPT1VVdlgwOWlu?=
 =?utf-8?B?ZXJwNlhOcDFZWlVEUkdJUHdJbElFcVJDV3c2ZDQ5SG5ra0lvdGNVQVFXZnUr?=
 =?utf-8?B?SVV5bEljWGNEUkY3WWcrQ01CeXdPLzdtcnBZNEx3b1RoWjMrZDZZS0FEMG9T?=
 =?utf-8?B?d2FxZ084LzllL1FjbkFZRm5rckNlQ0llODU3bzZoa1JXelk1ckFKVDBGbFJP?=
 =?utf-8?B?NmUwTWFpUFZHS1NpcGxPV0tUS3F4bXROWG9MMm1DdEZCanIwMDhPa21SSGNQ?=
 =?utf-8?B?MmEvUm5oYVpFQ1o3Y3c5UkNuMnlVK0RtYkdYRVdGckR2ckJHTFpFbU9yc0Rx?=
 =?utf-8?B?NDFndTRkb3UwYzF2NWg0K3RpMDRVYWd1WDRmNDhHcmZHSmhCVmJqM2g4Njlx?=
 =?utf-8?B?NTdsWjE2VVB1MTBuUHpyR0NQMmlGZmFmMldKSkZjZ1BKcGQ1blVJQStLWFJL?=
 =?utf-8?Q?ezFGLzHoLCPz5aEVxUr6WPMNf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31a7ed2-ee9b-4d6c-139e-08ddb8b38d70
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:25:47.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzdiIXI5hPjsExWYp754LibQd9/o2GyVjif4dPnRR4ik9DWuVKW1F0yVd3JZ/BITg+guMzd9lypISoVJA5Zhpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022


On 6/27/25 09:43, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:39 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
>> memdev state params which end up being used for DPA initialization.
>>
>> Allow a Type2 driver to initialize DPA simply by giving the size of its
>> volatile hardware partition.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> º
>> ---
>>   drivers/cxl/core/mbox.c | 17 +++++++++++++++++
>>   include/cxl/cxl.h       |  1 +
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index d78f6039f997..d3b4ba5214d5 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1284,6 +1284,23 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
>>   	info->nr_partitions++;
>>   }
>>   
>> +/**
>> + * cxl_set_capacity: initialize dpa by a driver without a mailbox.
>> + *
>> + * @cxlds: pointer to cxl_dev_state
>> + * @capacity: device volatile memory size
>> + */
>> +void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
>> +{
>> +	struct cxl_dpa_info range_info = {
>> +		.size = capacity,
>> +	};
>> +
>> +	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
>> +	cxl_dpa_setup(cxlds, &range_info);
> I missed that this function can in general fail.  If that either can't occur
> here for some reason or we don't care if does, add a comment. Otherwise handle
> the error.


I do not think it should fail under a controlled type2 initialization, 
but as it can fail and maybe future changes will make it more likely, I 
will add checking the call result.


Thanks


>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
>> +
>>   int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>>   {
>>   	struct cxl_dev_state *cxlds = &mds->cxlds;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 0810c18d7aef..4975ead488b4 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -231,4 +231,5 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>>   int cxl_map_component_regs(const struct cxl_register_map *map,
>>   			   struct cxl_component_regs *regs,
>>   			   unsigned long map_mask);
>> +void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>   #endif /* __CXL_CXL_H__ */

