Return-Path: <netdev+bounces-128569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070397A5E3
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82E01F29335
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A26B15A4B0;
	Mon, 16 Sep 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PolT/ca8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7805D25632;
	Mon, 16 Sep 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503809; cv=fail; b=gQrU5GmXeG9fabOcGi/9AmyJj3QTTpSMcb4gf3Olu/xsqNJuAgAPGhaSCuV8mwYp1c7fXKzIRcAO80uRvNav/BGRHDU9037nQlEs1cB4jWQ+dVyC6BpxYkKq2p44CrR4rvZnKHamtqkAQ4q4nEIgtOS00HUGlkzFc3p4tZ0OFA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503809; c=relaxed/simple;
	bh=KAkJemPeEcLytj6C/bVpqtJvkBCe1UtgrKtH5rTtAdU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yq3U/jEHk0ZGCro3QjsLLP/n1fTu59PQARAEEwheKpOkmUBPEAzj5ov6emNr5pwVZZftkiguIoOZHQtAGjj0t+xmMJZ0BUFDwjS+GJmyY5jrRhpLG2tLlPvsKsj1yhxKJjKdI7sDndsylYi6VfsaPawVxp6QE+6se3GuNg2n7hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PolT/ca8; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwQGnNHcWwgrzunAN/Xqn68RrnQYXYG9xNHuUQjMnCxPh4qBh5LCQXvzZxsCcuZRlbXMCyGmVQezeVUzDLTbEtKeZPS10THhgRDSCGbV6laRTDQJx2MCNxgQrf4KwWYdp1pATUPj/Iz4G1AxgiQxojY6eWYHJ4PZYCluPywdGRMSLlKdfIck9pEsjJJpEPdTzmGsI6XSkM6mGQMLNwg+jH0DFaGtNrpJXayg8V87QJhFDgqsydaJyIamMa92CF5I4fTD1QNugW5gFkeWL6ZSjwYmUwMA8EXKz2yIsz0dgg6CVNnU1DoW28rKLEek2AjjRgXYjB3A7OwC3XRbozxHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv6G+fl3Xv/Hd/8oZXWvaGtiI+AEtuVH1MMZ98NkwoQ=;
 b=nxaQsrDN6CDJz2uJ2z0cL9/A04OOtUkrcMPEMweRJLQVXCd5xrn/csJZAmAXS2pVi1dOhZ+yme2J13nap/RiSkVukaTQ8rvedmxhAwteHUPIh2Mg3m4lQMAm8DIVkso5uRXZAWXRk6fB2SuDNHOhWXrBkKDt/c7PenGs2SsgqU85OesjfZccngzqOxJN8Drkt83d6MSY3clmV0WfA8SgVcgk24SkNXWW++qgAch8fmG/cuUBFUW3KjcuTu+mYj31r/sf2E2xMtmJojeaTZzf05sOnQUzkkSwtQ9ELk5E9fGn+ct+95iHgaKqEjUTL8u/c2B/WgP4ruiFbBsLnV1yQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv6G+fl3Xv/Hd/8oZXWvaGtiI+AEtuVH1MMZ98NkwoQ=;
 b=PolT/ca8yTFgywEqVMFvwzHWNn2NJ7pxatpWrt5bkPDeNLJmNmobC72+JwRBQWDRKFJIL+WiNtFROOfRa6OHg3QUFqIojYa7cnpcN35UyaKYWfG9fOcprpHmjAcgRbwupmrl1LH3H8QdoqeWjg71fDJAdiOUJq8kLgCZAOwKqyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:23:24 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 16:23:24 +0000
Message-ID: <7ec2eb7a-62fa-f340-1ee1-2c9fec7df75f@amd.com>
Date: Mon, 16 Sep 2024 17:22:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 19/20] cxl: add function for obtaining params from a
 region
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-20-alejandro.lucero-palau@amd.com>
 <8afb39a9-c04f-4e61-af75-e7f6adcee36f@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <8afb39a9-c04f-4e61-af75-e7f6adcee36f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0613.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc8fb84-bee6-482d-98aa-08dcd66bdc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHJpNzg4eUg1aUxKbUd5WXY3WjBoem9MdXdkOWh2M0x1dzdVUzY0bUtEamFn?=
 =?utf-8?B?VzlMbUxMTlMxUU1KUFNSeWRwdlFjREc0bWpsQU5JeGxPM1dxVHZuQWJySjFU?=
 =?utf-8?B?bng1cHJkQ00yVnU1ZGVLK0w0d1RSSmJ6NHhRVHBZSmw3RFdyWTROcGlRWjdT?=
 =?utf-8?B?ZktCWlZPZ01LQkhhdU4yTjZURVE4Y1ZPQk1COXNQK2hBdlgzZDhnd3pUSW5J?=
 =?utf-8?B?OXJCRzEvemozMGNjR3M5cTd4dXZkVjZGN0NUK0IycW01MUwvWnc1K1F0bENB?=
 =?utf-8?B?N0NGOXowMEI5RzVMbjZUSTAvM2szVmVDSjZoTTdCZHduTTAwSHZvWjNpd2Zu?=
 =?utf-8?B?d1N3akFLTXltTUc4aDNraEtMTTUwSEdwV3pzTnJ3QnB3UWdYVXdkR0UvTXhX?=
 =?utf-8?B?dWlncm4xSGhYZ3h2eXg5bUtmMWlPY1NrcGZZSVJuaVVWemFpQzdtU0IxUjJn?=
 =?utf-8?B?T2JtWE82YjVnem05aW9nb21XelpOS1VMeHRDdEFQcHVDMlJMUnF0QXJ3Q1lM?=
 =?utf-8?B?MkR1UTZXRXF1eGorSFJEMWRES0hvQzFSMk14elhhYjY3bk05RzdYVmd5Q29V?=
 =?utf-8?B?VTVFdTh6SGEwQUJMeEZHWlBENHc4MmhsQ29VbUt3eERCT0MxcWpIY1hxa3Zr?=
 =?utf-8?B?ZGE3THBIS01rY1hSbjJYMjRlMkJmN3Y1MkM3UXJCL0hRcklWUEQxNTJOckRo?=
 =?utf-8?B?US9tUlMrZXovOXlvdytEWlpOY0RITkRBWkpqdVN4YWk3dmNvcFdlb2dCdDF4?=
 =?utf-8?B?TS9sSXR1UXIreGN3YUdLb1pQclhKNVYxeTJpVU5iWXo5cXpEU1krZWRCSUk3?=
 =?utf-8?B?TzMyVmpPdmpYclBGUFU3Zi9OTkRSSk9xSU5vYkhIMWdJL0ZtZnRjUXdIOHNT?=
 =?utf-8?B?cWtFbjZVLzlQWUF4bnFxRk01c1dFT0Yxc2k0Q1o1RlI5ZXNJclVwWmtZT24z?=
 =?utf-8?B?enBXbS9Kb0tOY2ZCb0hLMGdmZ0pCVG1FZnVpeU5FK1BUL1JuNCtqY3pRWUg0?=
 =?utf-8?B?dE5pTGhHTi8wOE5GZFI2eGJJYytpNlNZSVgvamlBNytvdDJjNjd4NzRqQ0s0?=
 =?utf-8?B?UW0vYjlpTUZ3Z3RQbnZRa1BOck9YNWllSUkxcmw3R1RpNGJzTGVvYlF3VEhR?=
 =?utf-8?B?ekRYLzl2MWltQms3RDVNNWpBVWxWanhjTnk0WnZyQTBIS01UeHFJY0VTR2dZ?=
 =?utf-8?B?YXJ1MDNkSlVQcGJmNkltSng5elpRYjV1Q0FadUdLdVE5TzNRcHpCTUgzUEgx?=
 =?utf-8?B?dVRZUlBOSmRVU0FoVVJDaTZ2eU5ZbDY1a1kzOFFRenJVcytSbzhSN3FKS2d5?=
 =?utf-8?B?QTNNK0theGpUUXdEdDVFQ21YS3RCRGJOYlZiRVZub1pWMGJPaTRVMElvM0RB?=
 =?utf-8?B?M1Bmayt3dm13Y1FNcUpWTzhtK0Z0UjhUbWgyQzVsSnU0R2RnN3B6aWR2d3hM?=
 =?utf-8?B?WWpZVkpFY3RtR3ovZXNtTzZpbitqVEdtVkVTeDZXaHFSK25ObE9NWDI0Z0l1?=
 =?utf-8?B?OHdKVERMN0FIVXZDZUZHTzl0NkJtdnUyVkJFLytsL1VIWmQrcGdOZzdLbFpM?=
 =?utf-8?B?aXV3ZGFJam1BZkJLR2dEdW1PV0ZrUlc3bnBERXVXaHk0dVFHamNmWFc2Z1oy?=
 =?utf-8?B?WldsaDBBTGJLeDhDV2N4SXp6cEROZFczaStFM2pzWFQzMHhtZk01bDQrRnBj?=
 =?utf-8?B?STV0Zy9vSmsxQUE2NGhDSEtnUS8xQlIvWXl3VEZoY09mWWNJSnBod3FtTmFM?=
 =?utf-8?B?QWZvQ2UvYTl1S3BwWlJoVlkwWDRlZUduZHhVS1dJRXRYWUNtWmQzbTFZdE1j?=
 =?utf-8?B?d25EYXlJbjM4UDNXYXZTR2lhbVRXMWlsZEYzZ0ZBbW9Uam81Z0t4bERac00y?=
 =?utf-8?Q?divCOxdvmoWMP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um0zRDE3VmFPYSt2WHZNYzlCSDFVby96YlloV1hNRkZwRGp3a3BQWkYwN3ly?=
 =?utf-8?B?QWJYZ3pGcFBBWHp2MVYrSUxrQ25obFNENUFtdmd1VjRVc3pzWVVKaXUxMTZz?=
 =?utf-8?B?ZWVUN3VIZndzb1lOWXpTbUNZd2tad0p5TUhaQ05KMmlPRGpCZVRXSmxReHY2?=
 =?utf-8?B?K1lnWkd0R2lQWWI1N0w1bVRqODhUTTdzblk0N3h0Nlp4M3pHeWJ3MzVLRWxI?=
 =?utf-8?B?TkRMOWR0T0FCSTV6bGhESkNpazN2MVNrSWxrL3B0anFvQnpBNlZFUlFWVisw?=
 =?utf-8?B?S0JKZDhraC9SWmdjMzRNWlBnVDdPOVBtOURHNFZ0YXhrWE5WNW41U2dOa2tJ?=
 =?utf-8?B?ZUovRUViUXZUTk5ObzJ3T0JGMjZWL1NkRW9IMG10WCtOQlpwYmwyZDg3clJK?=
 =?utf-8?B?TnlRM0pRcy94YWJ2SkFqTmg5MHlpNmtkLy9pbjNjLzdqSnQwc2R4QmxiTEJl?=
 =?utf-8?B?ZU04aGI3b1I4cVBGZElaL2QwNXVRUmhtYjdzN3VYMVZvWjJmcmxUYzUzNjVr?=
 =?utf-8?B?VC9mMjFyUGxBbkNuQXo1aTN5SDNqYnFrTVpOS3gwNU9wR0pxS1Z1NTVDbzN0?=
 =?utf-8?B?YmZIWEVod1d6NGJpdTU2Y29VTWptdnV3VmRxMHJLc2ltcSs0VVdycVVxa0Fy?=
 =?utf-8?B?bGR1TG1IdU9LaGpaTUlUZmdyMGJFMk9DOFhZbFRaeG9BVVhtR0l5M1FNVFlO?=
 =?utf-8?B?eXpPcE5tT0M3QTlMdFdjV3I4RHNYYmtSR09ZZW1WUkdkaGI3aFhGZEp3b2JK?=
 =?utf-8?B?ZkUvYlltQ1duWVBlTVAyTlpvd3ZzbE5yUjNCckhhNTYwOTVxbHM5Q0tHbGQz?=
 =?utf-8?B?VnZ4QlUvZzh6OERLTW00MldFdWFNRE5idGtBYmJhaW9MR3ZLSHlaWHB6aHYx?=
 =?utf-8?B?ZkdMd1RQNUxhOXBmR1hsTlA5OU52TTJ2TDNTOE9mejhDT0NrcWk4bm96L0Ur?=
 =?utf-8?B?T0pzL0FzYkQzekpmNk1SSTU3Zi9rNlVPR0VHT3B1Y3BTMG9RTkdPNFE2blh3?=
 =?utf-8?B?eFpldHl3S1Q3VVFveEpJY1pOdTE4UjF0TlQxalAxQTJYK1djcEJ1Q2x6cFpG?=
 =?utf-8?B?Y0g1eWdhVG83NEU4UnBLTXB6cWp4SkE1d3BHV2RBTlJjd1J0R1hiWFVjNTl6?=
 =?utf-8?B?SXlTcE9md1l4cWwzZlc2aUpYQUQ0dWhkVkVtK0xSeDY0dll0c3hhVDBPMU1K?=
 =?utf-8?B?VnROV1Y5MUdNbE9ZZjRCOTFUMGVKOTUvYjBwS1lHRTlTVVpnS2JqYmYybVZa?=
 =?utf-8?B?TG52ditqVVdyUm9ZM0NsVm5MTXhkVWpyZmFnRnhaRUUyV3BJYnNlUzR5QmlL?=
 =?utf-8?B?QVNTNStGdi83ODRKT0NJMHRPbSt4cVRibHUvL0g1ZEdXbEhqSkJxT2M5MkNm?=
 =?utf-8?B?eER6cjdOblpnK00wcUwxam5jMjJKRlZLT3hRYnZOOHdzWEtKNGFSSmwyc29l?=
 =?utf-8?B?S2FoaWduUk41OGFXSDBIbDF1LzAyc0VsVjBMeWNuMUJkR3pIdHI2SU40cTVw?=
 =?utf-8?B?a0p0SjB4SDR5QmR2eGRFd2UxK2FsTTlKZWZjY2RLUGVrR001WjJhMzRjMDIv?=
 =?utf-8?B?YlhXRlY5cWczNDZvM2IyQmxmcmxRSlkrUldTSnFYQzdaNm9HYTFmSWp1MS80?=
 =?utf-8?B?TEp0T2loV1JXeTNHRnFFYzZKUnNidDN2NW9wam5hb3AzK3E2cTU2bkJrYkNm?=
 =?utf-8?B?bEN6RzNZUUJjbkNna3dPOHVMamI5R3FaTCtjQ3daN2hXaFd3TWp5dkxaNVhT?=
 =?utf-8?B?OTltVkxjWUlpY0lpUjdycXhrUElIeTlBbUtIbDh2dzI4Z0F3ZEc5dngxbmtt?=
 =?utf-8?B?SUU0L0JRUjNoZHJhUGJ3L1hyeUJuNTdreFRKQkYyckJCdnp2emVPNDJObFJO?=
 =?utf-8?B?SElGTENlQmhkQUwwU1c3VllMU0JvYjgrRzdSdTJqbDBXZkZMQVJyRWxOYXo5?=
 =?utf-8?B?TG1IWFAzUUMrRkdMVnlHMjNkM3VlMjVTRzlLR1RvZHQ2Q0JEamwydHgzeFpM?=
 =?utf-8?B?bTltWUxCOHl2K2UxdzM4cEFGa05RcGV5ZlV1aU9mV2VSMGR6dXBtUHo5U1Av?=
 =?utf-8?B?YnJqaThXOENDSll1Nm1YUVJsUEljWlUwK01FZ1lBSFdpNXZnTVlVYTlWT0JR?=
 =?utf-8?Q?6NQU9T+2qdX/Fr1UYhHDgnHJ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc8fb84-bee6-482d-98aa-08dcd66bdc1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:23:24.5498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNNwTKhuOfP8kMiAgTjUryzEJes51+f0AZYDvaEm5s+L3GJkOTqE+zVAj+IXMpkVmmF3wsV8Ae0Neqm7wS7ALw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610


On 9/13/24 18:48, Dave Jiang wrote:
>
> On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A CXL region struct contains the physical address to work with.
>>
>> Add a function for given a opaque cxl region struct returns the params
>> to be used for mapping such memory range.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 16 ++++++++++++++++
>>   drivers/cxl/cxl.h         |  2 ++
>>   include/linux/cxl/cxl.h   |  2 ++
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 45b4891035a6..e0e2342bb1ed 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2662,6 +2662,22 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>>   	return ERR_PTR(rc);
>>   }
>>   
>> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
>> +			  resource_size_t *end)
> Maybe just pass in a 'struct range' to be filled out instead of start/end?
>

It makes sense.

I'll do it.


>> +{
>> +	if (!region)
>> +		return -ENODEV;
>> +
>> +	if (!region->params.res)
>> +		return -ENOSPC;
>> +
>> +	*start = region->params.res->start;
>> +	*end = region->params.res->end;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_params, CXL);
> I think at least for me, it's better to have the introduction of helper functions to be with the code where it gets called to provide the full picture and thus make a better review. Especially if the function is fairly small. So maybe squash this patch and the next one. There may be a few other situations like this in this series worth the same consideration.
>    


The next patch is not too big either, but I wanted to make things easier 
in that one.

Anyway, I'll do so.

Thanks


>> +
>>   static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>>   {
>>   	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 120e961f2e31..b26833ff52c0 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -904,6 +904,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>>   bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>>   
>>   int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
>> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
>> +			  resource_size_t *end);
>>   /*
>>    * Unit test builds overrides this to __weak, find the 'strong' version
>>    * of these symbols in tools/testing/cxl/.
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index 169683d75030..ef3bd8329bd8 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -76,4 +76,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>   				     struct cxl_endpoint_decoder *cxled);
>>   
>>   int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
>> +int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
>> +			  resource_size_t *end);
>>   #endif

