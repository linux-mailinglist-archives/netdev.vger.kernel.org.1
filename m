Return-Path: <netdev+bounces-227139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C76BA8E0C
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 12:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F441C1F20
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB37A2FB99B;
	Mon, 29 Sep 2025 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HwWhnFyg"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206A2E0909;
	Mon, 29 Sep 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141302; cv=fail; b=rdUvXoBjN+RA2k97RBgeETh5ll1waw+Dtx9i80YiOCA7MEsUyJYIjTDtgmneF7RPaxR9vbEFE5/pqvmLYOOxBWh00gH3as7yO0MptdKWVTUAX48U7xRWRtqjyGo6LTIZONRseQbiadXCHHeuy3XULs7RXnkTQVV5jFA04fkR32c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141302; c=relaxed/simple;
	bh=f4bJ79yGEFiMXSAvB6aPaTPCBrEEjhqZ7OjhFhcZ2NE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jKCZaqUuvbJ3hW16ipcgwui2mObMbGlE/ZeP5qC8U0lfyNNg6CWnmOW2qNvU/zMCtjpz0OGOfxNBuW08tL9YsosIBxlVj4LodUxGXX/9qUwGIQajKI1WtVYlok94kTq42O7A3iyJ41kZ6vtGWpI2r8jbWGofSrW7Re6EJeeoR8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HwWhnFyg; arc=fail smtp.client-ip=52.101.85.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO2viwP6VJNquB4HKCOC+3vPqVRHWs35rWOZUs6BTpid+NzgrYkeIJqyJNR8m8ImMYA/U1eX08OqQhtOHurQ1ILByhnNYRqGMeZYkiAcLTCZBp2RTMteHWWvDxAjsT6j8QOdM6FWmV5n4vq6Z70wwFD51ELRBMjE6H8IZnLwlQd9ZwaF/b62DFbAsrd4oD0wbYMaJP8l7u9PLCTxgt7ldIPQ9wFx5iwBeTb0XcWd3UtcfJnsTZXEUqZmnCQZHTX9A4e1CZMBUtkBjRhGxIFthk4aB6qlR0tvguh77+1SMsFqrZxJkdioOqdvJYYALjDhJRllyh8qAALYA47V6fjz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xl25uE37nD3jZA84BF0OJAnHIieg7Uhv9zGkV7VzBuQ=;
 b=OxEwPO6VGFTLvl8frTFuvGebAax8yITG7yLPMNDBx4t2Id1GNlTjjyXB8ar6bGj5y936h4ogfZN16lRnJNrLrfzbxDjCqNWzCuDP1rOyFszXb1l7aIaGc5AqcsmFr+SBYh9XFhyOB2T5cUZsYPYMpfqR5O47M4Jhvf9Qg1zmReJmEdE6uh60or6Hvy2zUcq78eTI/x8loVUm5J9K1QcW4wlVimQIIQgb83wbVg/seaI1yCQPvvXWDcZjQbCkc6zitB8NbFYla7R1ipxT0fmeEHaU2/gkR6BBvYzceIuP5+7tvZMwqb7MbFazr/FM1qcvdHwnIiZLLAJZ7NemH+rY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl25uE37nD3jZA84BF0OJAnHIieg7Uhv9zGkV7VzBuQ=;
 b=HwWhnFygzo1spCbLt/hVEaeaNz+tuyKMra0K1g0pIenxQzfWMkXEOFbqFsHE0oExwTWMAlGiA6w/yVJgcI0YpMrbPyKV4HNVdMi8Yhu6Fd9YwQkvbNGj8/gQ4mGWPJcJtyasiOu+kL9uCQUo35FqVVUzkjnMvAeFyYM40JyCVhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 10:21:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Mon, 29 Sep 2025
 10:21:38 +0000
Message-ID: <ee5d4ff7-da7b-4caa-b723-b4b5a09bfc39@amd.com>
Date: Mon, 29 Sep 2025 11:21:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 01/20] cxl: Add type2 device basic support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Alison Schofield <alison.schofield@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-2-alejandro.lucero-palau@amd.com>
 <20250918115512.00007a02@huawei.com>
 <7d80a32f-149c-4812-8827-71befdaae924@amd.com>
In-Reply-To: <7d80a32f-149c-4812-8827-71befdaae924@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0260.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: ae010433-9520-443a-f7ac-08ddff41f96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm43ZVRBOUZ1eStmMEtNeFZjVEJhSU9rYmdsY3JJWUFkWGdzTXZpdEo3V01t?=
 =?utf-8?B?YmY3SUZQZk5SdVRNWnJpZEdjMXRpbUwvelNEOGxxSE03cjg3bnR0WXVqd09P?=
 =?utf-8?B?MEF0RWJrQ21nWTNnS01RK3M1V0Vmck01MVpPdS9HSjlHKzZKVHBxZzBRTjZV?=
 =?utf-8?B?c0liNjFPZ2NIYUdia1g1VlVKdUpiajNCMXRGdlRhV2FvY3l3RGkyWnc1SDJi?=
 =?utf-8?B?b3pVVkNyY3hPN2lLSXlTVkdPRDJjZWg3NitJZFVHWkRkL213U3FFdWZzYkNt?=
 =?utf-8?B?bnh5L2gweFA3aXhoMWhqUDFMYzdGdVp3WkNYUlM5UFNtQUhjbnhVb01tM0xG?=
 =?utf-8?B?cmlVaWx2aXVnb2ZSemM4eGZIdFJsa0FkV1pUQWE4bllHaVdYd1ZpRjJCREJv?=
 =?utf-8?B?aDJJQkJPeGhPRjVCQUlHU3hjak1lOXR3N2JZRFJ1RXB0bW9icEtsSlJ2RllF?=
 =?utf-8?B?ZGhQVS95RGRaMFlmVThHSyt2ZUw0M3IraFZjTUF1T25JNUg1ZUpiTFZWd0FG?=
 =?utf-8?B?YjduRVdnWnhZSHpGVHM3UmhHYUdUMXJBOGFIakFNMzNVNGtwTnNZUGREekhh?=
 =?utf-8?B?ZkhEYjhsWC80bmkwL2xrMHJMUzhXWEpxOW9mc2dXRGhkSW8vajlKNVVCSC83?=
 =?utf-8?B?bmpqT3pGUUlLS3NXeTFHSldwdmtwVEw0eSs2T1ZTMFcvWnJBL2VCWnR6ZDVz?=
 =?utf-8?B?VUk2THpoTXE4eE9XdmZ4RlIwdUV5bzhISnpISTJCMmlqZjdsaGF6bTdNb2FY?=
 =?utf-8?B?QzhOaHJjY0NXWVZtY21uUnpCSTdtZmlEOGhsaWU4Z1BIeUs0bENmU2RNMW1r?=
 =?utf-8?B?d25PNnlvVjYvU2VGQ20wcmYwNXh1ckwzSG9kUTJOeWpXaE1VbGREY09NcmEz?=
 =?utf-8?B?MWwvaUlXUlJJaXNNaWV1N1BnY3Nkc0NBYk1weUZIRUs4bzZacS9JK2N6VlFi?=
 =?utf-8?B?NVdVdThJQmw3ZVJMQ2pVMlhZUjBPT2ExbFo2ZjRwOUZOVU5wYk5JQjlZdkJJ?=
 =?utf-8?B?TEcvYmZmdGFHcW84cll4bzNHSlVBeXRzTERCdldsUysvb0FLM25VU0h2Lzcz?=
 =?utf-8?B?Tmd5YjJKMTRXRFA0akorejlkZDB0L1JsR2NQdGtiaWk0L0EvVGpDRTFLUlRC?=
 =?utf-8?B?SHpwMjNReHp0a2ZhUktnclRHR0pWOEJZZ0lsQS9UOCtEcXllR3R0VjROS1Nj?=
 =?utf-8?B?WmY3engwYW5BeEJmL0s1RlB0VlFndlR2U2FmY2tSMXJWRGpMMWRtOTBjUElv?=
 =?utf-8?B?SmRQeGY1d1lDVWpPOEtVZldqZzM0RDV6TjdFcGZjMExrQlNWQjlKWXl1NjRj?=
 =?utf-8?B?Y2dMaWFOVkFCNTFvc1pSYzRZcHNlcWhjc1VEOVZMd0tLZjlPeFZsSVhsMUZS?=
 =?utf-8?B?NTN0K0JvOFVRMzhMVzVKSnFseEtJd0JQMW5CUWhsQnBuYTRNRFFKTG9TbXRK?=
 =?utf-8?B?bisySW5NVkgxa2NJTG1zY1gyNjJqRk0vUm45bWloY1RuY3lEYXVnY0dzZGdS?=
 =?utf-8?B?T0ZNeG1raG1ma2FKTUlzQ3RiTHdqbEtFa25PUkJjOGthaHpscUVsS2w2eklh?=
 =?utf-8?B?L2lYTXQxYmNnckNGUndOenRTQ1lONmhDb3IySERUZ29RdkZKekNCdFg0SzNU?=
 =?utf-8?B?NllvdFJSYVpsc1YzMnROQWw3SVF4N1ZvbjBDR1lnblBUM0xGbENET2I4SkRN?=
 =?utf-8?B?MFJPaWoxMTdFQWZhUzIzTmNnRUZ0cmp5TkdHdGhJSSs5dDJqRitsR2loTWFS?=
 =?utf-8?B?MTR4TXBueUtWQWhlNEF5SUpSRGFua0FCN0I1OTYyUm8wdmJMOUZkeVBBMW5P?=
 =?utf-8?B?NkprTlNwYUtwb0Q4SUdxVGlIamlFSXpVQ1p0aEUycWtPS1NXUnM1UnNQc2lB?=
 =?utf-8?B?TTNRTlZGaWdsY0hHdnkyZmlUZms4U3FJSUJpYXNtZ2tmMjBkUEFabG04cVNE?=
 =?utf-8?Q?DWBGNsQKU5FlUSNv4DQf5WqOPoOXuhWa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHc4MUthbmRwUU13anVKOHFFMWNsMzNmQlFUMWNIZElIZ0dXN3VkTmZudDRr?=
 =?utf-8?B?dThmeERvVnZURDVkNDBlMUZMSXhrTU9nSFlvMnFYS21pSWJ4N3RuMGlLdXhR?=
 =?utf-8?B?YTNJWkFxZy9HVVVLa1k2RzhBb1RPUjJXc3JsMjh1YkxsM3NDb2VCQ1VrTVg3?=
 =?utf-8?B?ck5LQUpPNk51emlTb1U5ZzN1Q3QvaU9FUUNEYTdnSEJYMHo5NWNXYlB6Yk1H?=
 =?utf-8?B?TFdMVGlUbUhvVndsRi9Gc1JmRTl6aGFia0ZRa2h0UXg1L1diNENOWXF2a2gr?=
 =?utf-8?B?T3hEcjlEUFhwV2RkSnVQVkwwbUV0dTA0bWpJZG01d3hRUElpRFpyaXVsRnBO?=
 =?utf-8?B?dXFBWVJyVE1UYUJ4a1owRG1FMXo2eUsyUHdMV0ZXZkFNRFdMd2hFellDSGtS?=
 =?utf-8?B?TEtZUDg1QysxUTlJUmRSMk9MWktueTJDN2V5ZDVVa0JjWXd6TGpIK1BGbjFu?=
 =?utf-8?B?eEQ4SXVnUk5Ta0w5RXp6OEZXTWJmS0R4QVk0Tmx2bEVWVVlZUFpSTTdHVUVt?=
 =?utf-8?B?cXRhdzJKTkkvVEFuMEZZbjRhVDhhL1VLZ1pUUG5RVCt5cDdDWmlaVTQwZnZp?=
 =?utf-8?B?L2lOc2lnazBGMEdwd2llTy8zWVRXdFhCUGh4a2NnMHMzK201ankzTk1ncWlt?=
 =?utf-8?B?cFBTVkd2T2EvbDRDQXFzWG95N0JpTkthYkc0MnRvWUcxQUdhR2dGVDdMQnRk?=
 =?utf-8?B?amJ6c0FCVENKSXFqTThkRXZ1QzdxVUZ0STJFMGFLN1FRTG1PQzBKNkREcmN3?=
 =?utf-8?B?MDVKUFpSQUJpNUY3cW5mK0ptWGdzbVZ2cGVQekdiZW9QNGFKWFdwdHhTNFUw?=
 =?utf-8?B?UG1qSFR0TDhnZWtxTlNuWDFRRUNJS3BFU0ZXMEJtNmxYQWpTalBPcGFpNmVt?=
 =?utf-8?B?UXFDVmYrZXZPa05LKzZyVGYxMzZKRUdkMnZpMmtNZHFyL2hwb3FCVFdRKzNj?=
 =?utf-8?B?ZzFFc3RDaWVHOUo1bWltamxidDB2U3lJWnU1cVdqSXBNL0JtWDMvL2JNS2Yx?=
 =?utf-8?B?aHRKYUo2Y0Roa2pMOTJ1YlRBQTFzQ1VETERvbVEwNlV5UnFDVkZhVHFWNG4r?=
 =?utf-8?B?UThCOENkQm9rOE82TnBtMnMwTjNWMlFuZUZONFlMRTA5VUM1TStyWFR6bktL?=
 =?utf-8?B?aG5BRjczZ1lrb3I4Y1pMRjRJODFGUHk1STgzaVExTnZhSnNNZ2MxSXZSbW1r?=
 =?utf-8?B?Y3lGVlNOK2xEdkZuSTY0U3F5UDNYVnY5NTFlYzdxQ1UzZ010QkVEczQyQ1lV?=
 =?utf-8?B?YXVQWTg2UWdodWJPN3pXSmFFbHBLK0xWclpRcHZ0Q0dibVdWU1BKR3cvN053?=
 =?utf-8?B?WU1TSk1ZOUt4Q3lhSjMrVFpOczA1SWVmeHQvRWFYckNhbFFKVCtXNEVrdElx?=
 =?utf-8?B?aHg2cFVmSnVJaGF5V05YN3JLVDlyVVZZV1lsYlNOTFF3WGovdjhnVUs1d2lk?=
 =?utf-8?B?cFRWQ21rdS9jRGpxQnRTVFNONm5tNjRvZGVJdDVLK044dlNmTEtETGQ2WWc1?=
 =?utf-8?B?Q3Z4MFNlb3Y5QXNvQ3ArdFRqZ0lPVmpjZk1yV2k1Y2JBeG1mTWVVU05CanNp?=
 =?utf-8?B?dHBFUXRkRDhUa09SR2hOZVN1TEVkaG53eUlLUVNYSThXbjJpY0tWQS9sWkds?=
 =?utf-8?B?UGRSbk9Ob1owdnZpdGVoa0VZYVdERkdrTU40V1IxNU05V3g1QWpocWg1M0ZM?=
 =?utf-8?B?R21UTDBpcWJLMXZWYTRTcnFRSlBQZlZ1ZVhGb1hjREhVK0dXbTJLSS85N0Vu?=
 =?utf-8?B?dmNLVXhmTVNEc3ppaXVxQUU5cnRTMFlWNm82SWxHRlc0KzNnVUdBVWIzdjdP?=
 =?utf-8?B?SDlPRDh4MDViS1ZCUENrUUllVGpDVEpQR3ZkVnAwSlNuRnZHR3d3ZlBNSnda?=
 =?utf-8?B?dngzamFycHZpbHVEYUEvbTN2VzRWM3ZLczhFVTlJYmxmUGhsTUZPcWN3cGc5?=
 =?utf-8?B?ZGJRa0xPdW9Ma1dWcytFMVdsWlNiSXRGNXRpdWk5bVAxNXc2VVcrdCthZnBE?=
 =?utf-8?B?MTNOZHJEaGg0ZVBhOU92VnVuVDlzVXE5UkJHekFPSGtxQ2E3b2hWZnYyUVl4?=
 =?utf-8?B?ZU9kd2VXTGxpM096ZTdGaWJ5Ny8rYTF3YlkrR3l2L0IyN3cvT0NGK3RtbEhF?=
 =?utf-8?Q?+jKExDTx2zIYeMdZhR1ULT69x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae010433-9520-443a-f7ac-08ddff41f96d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 10:21:38.2079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5s+f9zxHKLm65+63SWq3l+3GRElyvZVEle+0ZNGTg57TX5YR1kG+IPKh2UUSXAcUCS4uYiY5JxApOClcWTjYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884


On 9/23/25 12:21, Alejandro Lucero Palau wrote:
>
> On 9/18/25 11:55, Jonathan Cameron wrote:
>> On Thu, 18 Sep 2025 10:17:27 +0100
>> alejandro.lucero-palau@amd.com wrote:
>>
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Differentiate CXL memory expanders (type 3) from CXL device 
>>> accelerators
>>> (type 2) with a new function for initializing cxl_dev_state and a macro
>>> for helping accel drivers to embed cxl_dev_state inside a private
>>> struct.
>>>
>>> Move structs to include/cxl as the size of the accel driver private
>>> struct embedding cxl_dev_state needs to know the size of this struct.
>>>
>>> Use same new initialization with the type3 pci driver.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>
>>> diff --git a/Documentation/driver-api/cxl/theory-of-operation.rst 
>>> b/Documentation/driver-api/cxl/theory-of-operation.rst
>>> index 257f513e320c..ab8ebe7722a9 100644
>>> --- a/Documentation/driver-api/cxl/theory-of-operation.rst
>>> +++ b/Documentation/driver-api/cxl/theory-of-operation.rst
>>> @@ -347,6 +347,9 @@ CXL Core
>>>   .. kernel-doc:: drivers/cxl/cxl.h
>>>      :internal:
>>>   +.. kernel-doc:: include/cxl/cxl.h
>>> +   :internal:
>>> +
>> Smells like a merge conflict issue given same entry is already there.
>>
>
> Yes, I'll fix it.
>
>
> Thanks
>

Hi Jonathan,


When double-checking for v19, I am not sure what you meant here. It 
seems my answer was in "automatic mode" since there is no duplicate 
entry at all.


Note there is one line for another file with same name but different 
path. We discussed the file name for public cxl API for type2 drivers 
time ago, so I think this should not be a problem.



>
>>>   .. kernel-doc:: drivers/cxl/acpi.c
>>>      :identifiers: add_cxl_resources
>>

