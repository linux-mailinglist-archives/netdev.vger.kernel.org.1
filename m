Return-Path: <netdev+bounces-230928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A56BF1F6C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0628B4F4063
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A522D78A;
	Mon, 20 Oct 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hB/0FakX"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28AC1514F7;
	Mon, 20 Oct 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972394; cv=fail; b=tXr4GWNMM9xIpis23Qk13zgz0hrnyLIkjSdCW1p+mjO6yOzP6rcsdo+0vEZmMdSjybZ5UbPvYmUYZAdroaoiMnnBq4sTUyFtJs6grf7AnkAau3nTPdCZZ/WCyKvYd9m0beljbK+MebGFn3nM0EnWVqc14nYDjaJ7n8/DDVOJYqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972394; c=relaxed/simple;
	bh=kDOjwuCPah3EaH7fE5wgTTEmQKYBQFOGqkycEe4xmNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RXJWirvt4KoNdR45x9a4paXR9vsw/CctqHP2PgDDl2VXwlpynmtd8NnHTogIvUZXHeGn8IU5FnpKoLaSrsns5GpB5lAKa2TFE8EYlS4HoGJJffCcsD7UaSk3TKJgcS3iUzgxem1opHx5WIgGIbEe87Xn6ronbVqWMj67fJej9Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hB/0FakX; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tj2l0Z0LOD+GO58gBC5EvHX1LGiwPy94TTCkvqnEsLBBMS4ATRgVRvFaJvVAEOgtD4x452ezZFKChlvMhN9OOFoO8VM4Bk8cboGPHD/fi4dDhEOeVfjwUFJ+TZduMo9jRGyra2AEQF0q8Z8AkXxZfsIxUM71rV6sAj/cqJvw8VBYzR/noDBSXluFcttCDlV3qZrqrTyMRj8pMhullWWMu65EC02ijKrCBYgyKkN9SgbKM4l6zJgAQaPmqfzbUh85ssCcHeo7vFhRNThGG9hztqmoHAr0C47uZ8j1+s+54UyMujugJm54xS/9JmkaBR6sKG2T0gN6SxRcRqlirgCWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDOjwuCPah3EaH7fE5wgTTEmQKYBQFOGqkycEe4xmNs=;
 b=yl9yjTjd00DJ+xoZbNcTfFqYeWo8NOTnuBNvgnYT5kE4KhiTw62DZeGTMjy3c6aAwOJ5OZxM1ONkLw+EjqSAEqc/abKwpTlpRSs+W08tuAjdeASsREwWfI8d6s5V4qTGL+8iN8plBqj0LZ8sHjCZQIeQbFZRvP7twhtfBcjn5v7tnfbfmduxEqQMHXpXufplWCEXJTSEYc6FMxztNNfokz2pj30iotKtHDg6AugBTQxN0IW8rhkDPyG9wqma7BaSMu+hIgwYsbMyb6+6IEEGqvueEBQjrITP84YQbSjHoYP39sKIi81og80CZq0ZL+21O+YA/n2QDq7gWTFfi2GQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDOjwuCPah3EaH7fE5wgTTEmQKYBQFOGqkycEe4xmNs=;
 b=hB/0FakXNei5SOkgmP6qpJDhveoGL2bjLzVBDRyjjosUw0VgBD9eo28AQzvrqjcUZ0EEZt/yHVx1HxrSwJbd9da3Xbtt986kPs44cJ1AWrsCjQ8xbcCnVA/4KddylBt9U0OmT4y9rnhJQ4Xgh1rAX5POGZGGvddq5dfXmlU+tOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 14:59:48 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 14:59:48 +0000
Message-ID: <3c0de7fb-5f0f-4f04-9175-fcbaa1cc07cd@amd.com>
Date: Mon, 20 Oct 2025 15:59:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>,
 "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
 <c42081c1-09e6-45be-8f9e-e4eea0eb1296@amd.com>
 <aa942655-d740-4052-8ddc-13540b06ef14@intel.com>
 <127311bc-d3cd-48e9-9fc3-f19853bb766b@amd.com>
 <616d2aa4-96a7-4ed1-afd8-9fce85b45438@amd.com>
 <a5b85488-2d68-4b78-8f9c-277e169b3571@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <a5b85488-2d68-4b78-8f9c-277e169b3571@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cbac409-e08e-4848-9504-08de0fe9506c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEhtRWRHZ1N4NCsyRUt2cmdKblBKYU1DTTAyUERYbk10NXNuUlNxWjUvRGtU?=
 =?utf-8?B?dVVjUE9Ca0VaU01NSUhJeExIZmhvRld0anM5TVIwYWJTT0xtRnNMNlVYMjdY?=
 =?utf-8?B?bFgxWGwyTTJkQ2hPOUtrNXY2TU1POHFSSkZJTEV5dUpYNjBZdWl3UkxYZmd2?=
 =?utf-8?B?bkxZNVdvdUlZMkZRa01CaTQrTWR0alIydjNSY2FQRnlYUHlaaEdTalR5Q0Y1?=
 =?utf-8?B?QUliZ3RiN085eVptL0tCMDNxb2tSenloblYrclYyZE5EWlFGaTZINWRyR210?=
 =?utf-8?B?OU1OWms1SjFBbk1IOE5FNCtnbzRuZkU4bUh3dTcva2tpSW5mTzFlZnowbCs0?=
 =?utf-8?B?OE55dlduQXNxREVmUFcrUDJJeTZCSVJEZzJxUTBNSGhEUTZtbXdIVmJwN3ht?=
 =?utf-8?B?MDQ0RDNFc2h4bXovQlAwTnByOUsvZ3R6ZFVXK1VuVW5kSFpoUnl5WnMwYzVt?=
 =?utf-8?B?K2MxQkpHMVBhZXRnWURVemFaV1hVNGdoTE1tWDBadXRrNDk3VXJ6aHNCbnNr?=
 =?utf-8?B?bXFGdW9qT2F1bEtLWTdUMHlObmx4SHRraDJmUkwrQU1ocU1IRlRNVTRqSkZI?=
 =?utf-8?B?M0RFVThXaEpCN1l4SzJ2YnFCV3Q2S2pCeVArSmZUN2paWTZYM1dkSk1KbG1E?=
 =?utf-8?B?MzRhSWwySEZEZFBGeitUSTlEdEpWakN5MXYrakQwOGExZ1pBaGRWRTMvczU5?=
 =?utf-8?B?bUVEOWhPMzVPTUJvVXRVQkFyZVh6bFg0V1VZbGpNYnA4TldVZnJRazJ1MU5z?=
 =?utf-8?B?aWFyWFRockQrTlRoZHR4Z29pWTZEdU9HMmQweTJudG5BTXJORXd1KzA1eEh5?=
 =?utf-8?B?TzdwZkJsU2VlUHlrdlRQSTlQVlBqMFVNdDZtcnlkemQ1cGxZVHBUQjk3d25t?=
 =?utf-8?B?Y3picXN1b0UyQ3dpYkFCNEQxYUxQdjd3VDVLWDN6QmZsdGozWlBudWZsbDFQ?=
 =?utf-8?B?QldHS0xTaGxqMUpxT3docklxNS90cU1BVkNHTGVqNUxNRkZpM21SQTVlRk1o?=
 =?utf-8?B?dm1zQW5qaFNkdHdXRFlDUE9ES3JaQjloamVVM3FQSDg0SjVPdktFMGRLVHJP?=
 =?utf-8?B?bXQ2bzRZY2ZIVDJQZVdleWFGM29XdUVqNWdyRUI5K0VDSFpIbzNVYzRpVnBS?=
 =?utf-8?B?aWZ3alJoVTQ0eTRVNWFkM3Zha3k5MXkzVkN3OU1vazQrTmZaYU03SkltaDdp?=
 =?utf-8?B?Z0JIblB2Zk1GWVRBY0M5OG1PU0JOOW81dTNmT2hDMjRvblFEWVhkNjRDb2VP?=
 =?utf-8?B?NnA4T2pJYVVTL013WXBPZEpUM0tRc3gxbHM0OGtoOTgzaGdqckE3K1dWZllz?=
 =?utf-8?B?OS9GS216dFlsajdzaDU0aTFoZ2VNSzlPMTVZcVdwWEdmM21MZ1RJV2cySEMv?=
 =?utf-8?B?RjM2RWZtbENNejRlN3N3UmpQSGN0VEM1blVsSzdOWHVDbmtqU1dOaXZuT0NZ?=
 =?utf-8?B?aWMrTll1bGljNEpuL0l6MHNueGp3cXo3eTJFMEpSeXp2V3dDVVcxMUM0cjQw?=
 =?utf-8?B?UXB3aU5XUmtrM2wyMnpGRmwwM1QzdU51MlV1VDY0WGJJVU5aWTljd1FVQXQ5?=
 =?utf-8?B?YzZMQlRsUndSWmRNR29ydmhSVm84bzd0b1ZiRTBMRGVkM1dDblFwaGJHT2dG?=
 =?utf-8?B?Zk8rYjdpN1ZxNWQ2L2VyVHZWc1lHQ2tkUUxHbkFGVWE0Mk9UT2t6cWxPa2xu?=
 =?utf-8?B?a2JmQkc3ZEJFRXNRc0dwckNqVkpleVZoSHJSUVNGVEhudFBGdjUvdkJYZnZi?=
 =?utf-8?B?SjcwQWQxVkpKbDMxc1hSUkhtNE91Nm51d3ZDOERlbi9MaEpoSU5qbEtudXp6?=
 =?utf-8?B?MHE3TWdWbk5ZV2lxY1VHWDJCS0J1Z3MrZ093NGQ0cWFiUDRmZ0J3WDFLOFJQ?=
 =?utf-8?B?c0xQTmdsOFFadEZpS21JbWllT2NaZkE3SkpNTmNMSFpxcXduc2hkYVE5N1Vh?=
 =?utf-8?B?T3FlQWhuZXd2NXN3STRBRDFZR3EvdW9XWHFBVHVZQlVzWW1TTnhDNHpyRG9X?=
 =?utf-8?B?TGxKQVIyMHNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU5qM3RpOFZibHRtcnJLcjBTdVhPQnF4K2FJSjd4NnVlaGZQYTRadlpzd0Zj?=
 =?utf-8?B?SlZYNU1XMmpwU0ExMDJlZG04L0NRVCtGb3NWRTh0alFxSnNaTXFRQjg5S01B?=
 =?utf-8?B?NmRLYlFhUzI0cEFocDA1Z29nRmI5MDRiY1p6QTJQUW0vZzkxYm5GUmJCZVd5?=
 =?utf-8?B?YThFL0RDTi9FSmtCeUY5dDgvZnlIMjQ0dzVROGJHekdBRlVQOUN6OEpkMFc1?=
 =?utf-8?B?SXd6N21jeGo3WFlOYnNFSmR0bHUvd2FSR1c4Um9TUkIzdFBKaGljYStsVUdS?=
 =?utf-8?B?Q21RbGZSc1ByWHBUNVR5ajhCVklsZHJCVHVxdDBKK3Y5MXlrbm5EU1E5VTlK?=
 =?utf-8?B?MEpEb1lKeEIrR0J1RGkwcHB4NkFUS3phL0kramNxTVZSb1hVZ0ZFV0lTdG1I?=
 =?utf-8?B?T00zRmZDckk4SFFoUUJUMzh0WmhkSDNCaHhkMzN2S1I0bFFmcGpXeExQK2V4?=
 =?utf-8?B?K0o0N1hRTTRkaC8wU0EvYkR6OExxRmJHQ0tkZFFOeFJFTDlKMDdJejhOWXZF?=
 =?utf-8?B?cjJzRlVkMmNxK3NtWkxFSVRCQlkvUE5IUVZiZEVLU3lwWnVRUmt3TGdUc1lM?=
 =?utf-8?B?Q1FLYUlNalVKMFcrc3NBMURqT2JuWkRtcnoyc1ErU0ZuNkswazhZYldTRVZL?=
 =?utf-8?B?MkNlUzg3MC85bW9JTjVyRGtTbjNxWjBmWmtYOURsemdDTEx2Q3VsbEVrRGRR?=
 =?utf-8?B?NHJjK0htWjJLUkZaa1BtT3NJbTVEMWxxZWZDbUZFYWhJc1RBOUg1OGNyZGh3?=
 =?utf-8?B?QzlsYUcrVHBmQldyR3poYkdwemtYZjBKTU83dDNZTHZwYWNtQWtISWVMQ1Ba?=
 =?utf-8?B?Q201OXRtdjFjRXJSeGJOMUg2K1VWcmg1OFliZDRFVTVLSmIzL1B6YkdZbk9X?=
 =?utf-8?B?OUdOR3M3eFlqTlRKa2FGZ050RlRpSnYxdXdoUlFvMlBZSzc1VFcrQzgzdlhk?=
 =?utf-8?B?cy9FYUtEQlM4c0V6Tm5XTEpRczF5T3pPSnNPdS9sT1hyWGxSRmFvVzVrQ0JX?=
 =?utf-8?B?WERPQlJlTjk1UUZOUytmZWs1QjloU0JnakVnWGRvMUIwdTA5d1YxTU5HTitq?=
 =?utf-8?B?N2Y2empKYkYzczZENmxMMHlOZ2V1bU15QnZQdXlCUnlSK0FVVElVcSswb2oy?=
 =?utf-8?B?UjYvejVXcXZIVG9QMmFqREsyTHp5QXFoRmppVmNwK2JhMSs2VFpxenAwYU1h?=
 =?utf-8?B?MkNXVUtQUFRCekFjVEU1U0k1dmlvUUhxZG9VQm9SbWF4eFoyeHExSVJPTFFC?=
 =?utf-8?B?MG8wNEliZzQ1dFdRaU43WXYvRGJvbVAvVTk0MUlsbkRWZWlkZnk1dTZLelNQ?=
 =?utf-8?B?SVpXOWRVMkRWYWNROFM2dXVHazFtakN3L2J1OVoybW9wRnE3Mys1TUg3ZVUy?=
 =?utf-8?B?N3I5NEdZYUIvaTRDMnY5VjVoVERmNHlwM3IyemZkakJaTUNrZC8zR05MVC9i?=
 =?utf-8?B?eHplSk0xRGFKUlRYYStZL2hqakFyakZobTdQMGpPazBsQWNwVkFMMkxyWFF5?=
 =?utf-8?B?MngwTHc2bGdQdFlLdW42eFUxMnFrTTZaWjc1V2RLWWFSaEZzMlZYY3FjdnBE?=
 =?utf-8?B?SUFiczUwcnRTaElka053WUNWcHBPMHBMQ2FXUVNBQXJWRktLSlVueEF3bkRG?=
 =?utf-8?B?Y3pHTjBFU3Rub1J3K2F2R1NiSTN3ZnlObDlBd2lkUDlJMlJ0UG9nVEt3SFR2?=
 =?utf-8?B?R3ZoR0xEU1EwVStiNzBocXdieWw0cVdJekI1bmVWM3dQRkpaRWR2THRkUk9S?=
 =?utf-8?B?WDVQem1Ra0tPVTVqb3g1dk9XbGhrUnhtcTU3RnUwZEVaWEJwY3pvc2NzRjIx?=
 =?utf-8?B?SEpsQ3E2RnYvVkN2UFhMTDhQWE0xYS9ZOTdZL2x4MGVJMWNLc3dQclEwMjdD?=
 =?utf-8?B?MUQ3anppQVQwOFhPakFtK3VvVFRyZDNtb0RzZzFtbUdUN0g2QU9sR1NVd2hX?=
 =?utf-8?B?MWpINDMyT2Jhb2RjL2dyY2I2S0ZHdmI4VnZpQ21xaDgwUHNCWDJWNDh0L1c4?=
 =?utf-8?B?U2RZK0ZkblgvOHljNlZKQjU2aCtsSVBNVmZVVzdtQ1E0NGtWQ3JqdTN3blBB?=
 =?utf-8?B?QjgyakRzNmtaTHFWdXk2Q0JEN1UvejdQbGdMVVIyQ2pxaWw0azViTnFWVFpn?=
 =?utf-8?Q?zMIXqwzg6kpefB/rUcVW839SJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbac409-e08e-4848-9504-08de0fe9506c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:59:48.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh+4KSCgITuVPAVQQU7LAT3DKDKif8djGzrYdLmLbkUdasWUig7UUeiDSt+9mQxZzuzZz7GRHWkpLSWqyyo0aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865


On 10/20/25 14:59, Dave Jiang wrote:
>
> On 10/20/25 6:24 AM, Alejandro Lucero Palau wrote:
>> On 10/16/25 14:23, Cheatham, Benjamin wrote:
>>> On 10/15/2025 4:42 PM, Dave Jiang wrote:
>>>> On 10/9/25 1:56 PM, Cheatham, Benjamin wrote:
>>>>> On 10/6/2025 5:01 AM, alejandro.lucero-palau@amd.com wrote:
>>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>>
>>>>>> Creating a CXL region requires userspace intervention through the cxl
>>>>>> sysfs files. Type2 support should allow accelerator drivers to create
>>>>>> such cxl region from kernel code.
>>>>>>
>>>>>> Adding that functionality and integrating it with current support for
>>>>>> memory expanders.
>>>>>>
>>>>>> Support an action by the type2 driver to be linked to the created region
>>>>>> for unwinding the resources allocated properly.
>>>>>>
>>>>>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>>>>>
>>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>> ---
>>>>> Fix for this one should be split between 13/22 and this patch, but the majority of it is in this one. The idea is
>>>>> if we don't find a free decoder we check for pre-programmed decoders and use that instead. Unfortunately, this
>>>>> invalidates some of the assumptions made by __construct_new_region().
>>>> Wouldn't you look for a pre-programmed decoder first and construct the auto region before you try to manually create one? Also for a type 2 device, would the driver know what it wants and what the region configuration should look like? Would it be a single region either it's auto or manual, or would there be a configuration of multiple regions possible? To me a type 2 region is more intentional where the driver would know exactly what it needs and thus trying to get that from the cxl core.
>>>>
>>> Since this is a fix I didn't want to supersede the current behavior. A better solution would've been to add a flag to allow the type 2 driver
>>> to set up an expected region type.
>>>
>>> As for multiple regions, I have no clue. I haven't heard of any reason why a type 2 device would need multiple regions, but it's still very
>>> early days. I don't think there's anything in this set that keeps you from using multiple regions though.
>>
>> What Dave says is correct, so Type2 should  support these two possibilities, an HDM decoder already programmed by the BIOS and the BIOS doing nothing, at least with the Type2 HDM decoders. This patchset supports the latter, but the former is more than possible, even if the logic and what we have discussed since the RFC points to type2 driver having the full control.
>>
>>
>> However, I would prefer to do that other support as a follow-up as the functionality added is enough for the initial client, the sfc driver, requiring this new Type2 support. The reason is clear: I do not want to delay this "basic Type2 support" more than necessary, and as I stated in another comment, I bet we will see other things to support soon, so better to increasingly add those after a first work set the base. Of course, the base needs to be right.
> I'm fine with the follow on approach. We probably should make a note somewhere in a commit log somewhere that only manual assemble mode is currently supported. And need to reject the BIOS created region and exit type2 CXL setup if present?


Yes, it makes sense, and it is a minor change.


I'll do so.


Thanks


>
> DJ
>
>>
>> Thanks,
>>
>> Alejandro
>>
>>
>>> Thanks,
>>> Ben
>>>
>>>> DJ
>>>>

