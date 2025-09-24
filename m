Return-Path: <netdev+bounces-225893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF279B98EB0
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA051615B2
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F06F285CB9;
	Wed, 24 Sep 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qDhoSMux"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AE22BCF5;
	Wed, 24 Sep 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702974; cv=fail; b=RzuIzwKJkiO25v74bL/yQPKvte0foor2u3MtCwXS40lOzTJt9rZnNhTAR1oMtUPNlsDZNePMOgwxS/SixU47VPvIf9MXJshy0MzAKq8c4kwXUT8xM1+IfS8lbPcz3iNbz1fabuU4iXk3tq1APknLKIrzx1/vEnhjpFJvx1hCk5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702974; c=relaxed/simple;
	bh=iw31xCKGDNW4d5q4ULnVwMi/9+kGFPA0BL6vGY4PYJ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KPICNmMrIIzKyOjRms0Re0BvVVxFM9q/WNXOFDNXZMkR/ZOHyg65eJGCDvfm0vQHOXciXQZXt2hcjG6FyRM/Y5IbYxlDxqOQK0aAzCBA8n9rnEShQpvb49MDgEjWXp9gc8B6rlzjL7DpUCoKC/FlHkViCpf1yuLSgeJg2zzPKZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qDhoSMux; arc=fail smtp.client-ip=52.101.57.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Imd/+HW0RAGUQfwGnfEH1c2tPgJ4UH6ZRrGX0O6fOjrp4+COkTWDdorgnnGSePF/cR9rBCfH76Ep+RfNCGe5tC6lgtsp3QJcg58QG+2nVEjeRUdxmqflnaiTI3Lbs7/25P/tpQMGEivPajY0+PBGWIs/tPMAh5cHfmbIU9LMBLk5WAh9VSZFaWA8VZlj8trjZApEpWqapagJkFsZj/u0aPc81cL9qWm8y0Al+qJD3iM6oQ6XrO1s/QSUljXh9pDd+u1ckvEaTKQjHw5MCSXIcRTx++nbM6PGH1x43HuXCnWS2XglByFql5s81nw3bcU7EKRP2aa1dQoZDmP0YVekrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YXbJch6hc71TjLweINuBvNFBcrhJlXsVCBXRs+xzU0=;
 b=Nia/KRXlUDBpEErA0ObDvM4noUg6zV2rwESqVU6/UvlnNFqnrZyH3pKBEuhbQXIfuErxIEX03l+6oIyCy6sq1bnMBqOFADjSTrOXXdzK2h2BX+ckbSLhgZLV7pCgIXcoZ+F1HJ5VLmOxnoz1oqMF1DH9pSIl7N4ka4AEc/yp7mKtW0TfcstduSz3wfmkgKj3xNJ5QCt3ALbvwdbdL/uaHaU4OAX2xFu/RJooRqyzlLyhJn6GwpQmNe7yK/xoKS2NaKysqZFGaMo2hrdpRmAlaZRD3qAY39NlcGwrTZwTVdo1TRO2h7wXHCU02bJ9/pHP4ecVsO+PbSNztrDq/TyHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YXbJch6hc71TjLweINuBvNFBcrhJlXsVCBXRs+xzU0=;
 b=qDhoSMuxkGNp80a3EoBqNjM61DfwCzWg6CExH2qTL/eKiFzp784Y5i0lU03eq0hCaAHOETGPOSNwFKxRQjzCKZTzlnh97qc4P1K72dKANjYPaHHlGGtGAF7CL/9Na80pBdeOAh4jkdCFf21S/uorgO8ELjuV6cJ8gM+PkG3ARV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 08:36:10 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 08:36:09 +0000
Message-ID: <c6e10b16-d8a1-4206-ab99-b957dc3b1239@amd.com>
Date: Wed, 24 Sep 2025 09:36:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 04/20] cxl: allow Type2 drivers to map cxl component
 regs
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
 <1b3fdf9f-079c-41e1-92f0-65ac2944ac00@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <1b3fdf9f-079c-41e1-92f0-65ac2944ac00@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a71d1a-76fa-431c-c429-08ddfb456970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDJVaDdxVVVyeGtYeFFSTE4yY282WlN4R3FNVFEwemREM2htd3RHcnBvL0lS?=
 =?utf-8?B?blZiM2p6LzZ4ZWl4dU5vdGdOY01PUnJTSjJUUndQbFhDdHd2Y2g2T0lCdms4?=
 =?utf-8?B?NEtEWGZCdmtxQnBBcFJlblZlcWxkRzJhZHdBdWdscDBMNStpN0Q0WERxbCtV?=
 =?utf-8?B?RU1BeXRrc2ErYkMwdEZIajE2TXdWM2lVOVlibU9ZQ1UvVnNVWFFVc2ZoV25i?=
 =?utf-8?B?b2JSb2xNMVAvR0J5L245ZmRDb1JZbkx2cS9ZazRlZFczUWZsRldTN202Z0F2?=
 =?utf-8?B?U2l5WWJWSkVpWGxaLzg3eDZNYVM2Yjhwb1ltQnduYmlIaFd3QURVcjRsT1Zp?=
 =?utf-8?B?bHJXU1NnekhwMnRoejJ5enJVWlJmUUFhNW1rK2FlN1RIRy9qT3J0akdhaDJo?=
 =?utf-8?B?VkM2M2d2Z0hlc3BvQUVLYURvcURCalU4ZXRkWjlPai9zcEk0eGdJM0VVYjJY?=
 =?utf-8?B?RVNjSWlrL1lQMEhxZWYxQ2U1TlB0VkNGVkdic0x0WTdLakl0WGVIdTR5d29G?=
 =?utf-8?B?UWZvM1JFeFRBbDJSSlYvME0zeTBwZk1LaDh0bnZTSUdTWnJKNnpIRVVwV2R6?=
 =?utf-8?B?eTlxWXc4SUZUamg1cVFrOUlZOFFISzdvQ3VhcUE4WENtY2ZTOUVqdWJLY2xE?=
 =?utf-8?B?NFptaWtLS2tJVlM1MVQ3MW84QXU2RTh0VkUvQkYvUkswR0FyYUIxbjIvT0tK?=
 =?utf-8?B?UWczSThyNXJMVG81SUxrQW5VdXNHajV5UGd6VFUxNjNad3BxVkRWQnlnbkx3?=
 =?utf-8?B?WUZyK1g4MWg2eTJUWkZyU05XRjdxY3NyWkZkOVludm02Z05WVSt6Qy9sWWha?=
 =?utf-8?B?aXFBSXQrQ1BXaGFESVFnK281Z1FuUkpHbEZCSmpDUE9tUWg2MFREMXcvUmdk?=
 =?utf-8?B?TjM2cHBKMW9mdDlXaFVTZWtHMTAwS1BaRkM5MmE1NjV6Z3dybVhHc2tKSWp2?=
 =?utf-8?B?c1dqc25pTEhVcktxNzQ0Y2J1dkttTCt1ekgwdjhDL1pLTjV5QjU1M25wUGNk?=
 =?utf-8?B?eklremJyM3FxdVFHSm4vWU9SUkUxYkVSUzVSYWdrZ1pCcHdMR1ZsR2tua1Zh?=
 =?utf-8?B?VmxLM0t5UFAzcitWelZXUm4wWE81c0ttMHhOVWJQcFpFdllJYUFVVkxEK25w?=
 =?utf-8?B?RGphWEZqcFhDQUpxMmJJSEpqVHU0aElMZnlnVDhrWHE1N3d5cnFZNG1HY2lY?=
 =?utf-8?B?ZmxyUDdBRDFoUkRVdU9kQlJBY0lBM3ZkSWhaZFlPaU5yWURWSGpQZSs4UFNl?=
 =?utf-8?B?RXp5THd3aDFaTjZ0VmFiUVBtbnlrL3NHdnE0OGNpbmx0YjViQXFSWjJ1SFdV?=
 =?utf-8?B?UEpIYVN2Mm5jUit6Z2lLNjdEK0NuZENyd2lZQmkvSk1hSFVWWmpqWmdCVlJ5?=
 =?utf-8?B?bEZEakx3aHdZMTA3dWg3SnJUMkVmS2xScXMxaDUxZFNzMXFQS2poemdHUnNP?=
 =?utf-8?B?TkorNE8vK3F4YmVzano0c2xjMHZVZ21ZZnp6eDZBTHpKT2p3ejBlbkFOTU81?=
 =?utf-8?B?alB5a1A0d3h0cWw4OEMyc1VCdGR5WlMwQW9UbHd4dWlOQWUxUTQybDk0VjBk?=
 =?utf-8?B?ekVwNXc2NVBKYzh3TjZyZ01ZT2NlemVkV2N2R2huT3RRQnVqQ3I5VDIyay96?=
 =?utf-8?B?TWlBS3NCR09yMm1nYmQ5MFFHcS9veDZGc1UxVm4xc3N1K2JzaElZcmowTERB?=
 =?utf-8?B?NzZXNm5SbWFhM3JvbSsxVjZsK2JIMlFUdndiR3JuRGVsV0xqVjUrQU85WXVH?=
 =?utf-8?B?VERqR2pWMzYvRlA5RzE3aTZFZ2ZscEw3b2l5OWtWbXN4OGNwMWR0TGNvSVYv?=
 =?utf-8?B?em5oTWxvaGFmc1VJY0Z2ZmEzM1hRTEg2RXVNU1FzZ1BRdEQ4MTh2ZGtVRGpK?=
 =?utf-8?B?MDZqN2xDQkJJRVNKWkJDVUl4TjA1RzJHcWZIT1hmRnlDeUozUk53a3F2OUpR?=
 =?utf-8?Q?sP1xLIqJfEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFhLNS9hdWFBbUIxV21TNng2aDNUTmlKOGpiZlhiMHN1azVJZU8xZExxeXVk?=
 =?utf-8?B?c1dpRWVQMUJkNzBTR0V0UGRCL096K0UyUlluNnYxYWRiWFcyRnEzdVhlRVhr?=
 =?utf-8?B?K2NkMXRjUDRSS2hHZnlVOWkySzh0YnkrVlFVd3Z1QlRsd0VzWENVdmdRWDhm?=
 =?utf-8?B?R09TZzB6NUtiVEV1Uk1iL3R6cE5lT0R5K2tuenE1Zjdkby9MRDhhd04wam93?=
 =?utf-8?B?OFlGSmNVL0tlQWpmdTRQRk5ySm0rbjNEQU1hZG9nWG5iN0podnRWaHRpSDUr?=
 =?utf-8?B?SGxKUE95SnZTdWF0emJpQmdPUDRiTjUxWncrN1ZKT3ZlMEFocW1RTkZFLzB1?=
 =?utf-8?B?Z002eng3Zllrd0txWHhleWIwNDZ0TGh0YURyWVRjVXpFTTMvMEFWQkFpZlZ1?=
 =?utf-8?B?Q1RIWmxpM1dEQWJyWnkzamIwMzQ5aDdVVDN2czBpdlJZQ25lTkorU3kxYVQw?=
 =?utf-8?B?WFpnakhtL210N3hSbVowT2daa3VlQTIwMmdwOUI1cExkWC9KaWJiTDdSeGFz?=
 =?utf-8?B?UXlFZll5UnE3Zm16Ukk0R2U3VVA5UGhLNE5vcUFLeGh1UHVtdVJTVkxNbCty?=
 =?utf-8?B?TVh1cUdwL2tPNlk1aWx4d0VOK2NQTXlMUjV1MnNTYVRlOERkakk3UGpTb28v?=
 =?utf-8?B?SXN0Qm5EYlJxWjY1d2U3eGFLSW1YVnZMR084L2MySStHdDRSZWRGZ0tDVExk?=
 =?utf-8?B?aFZhWTh5d1RTT1ZZQm9wYWNrdXorT2p4bk5LckJjdXZqL2xEd3BsWkFZa2NV?=
 =?utf-8?B?RVRQVVArWE9HcmhmSkpIdXNEZEJIRDA2NzdOYzhHbHltbTVUTEdzVDV6SUN2?=
 =?utf-8?B?a2Q0V0toTWNLRkZidEY4S2xUVmlUdnhBQTdUS0hoWWE2RnMwUTUzTzgwV2F1?=
 =?utf-8?B?QmloN25OQW95T2pHemdsbEowVng0Uk4welRYMWoxbVRqdnIrYThkZzdCTUNz?=
 =?utf-8?B?M0xCZm1xT2kyRkRJTXNxbWVzMDc5U0Z5V3FSdEpJeEoxN09URU5tbGg5NVFL?=
 =?utf-8?B?UCtXVkh6Nnl0LzV2bGNscis2eEtnbGhidnUyZnRqbWVrbWdQYTY4UHRJUFE2?=
 =?utf-8?B?cnh0ZGtnMEpBc3FibnVYLzVWTmdBQ1kzNWl5ZDJNdC9JdWhTTnhqS1Y0aDVH?=
 =?utf-8?B?ZHF2OWZzejRFd2ZhdWdUWmZpN0pyY0dJTS9UeW9XWVdkTEc3RHZmNHFwOGEx?=
 =?utf-8?B?bXZic0ZtOGJURU5BaEFOeEsxcCt6N3duekRUd0VTVEFZejdPeWRNNDhLQ1RB?=
 =?utf-8?B?cWRsOGUrWUMrMjBVbEhjY084RVNnK2xaYmQvS2Y1Ky82U2R5T09zTXBuQWdR?=
 =?utf-8?B?NU5UcWdqTzZCa2FRTFRzUlZqbzZHWTVZdFhIQlVlTXk0VU93SVFoVGVONnhR?=
 =?utf-8?B?clcxRk83WXEvbkVJNldLQzkxY1RQaUtJbXhtV0JvNUxkNFRTYnFKdis1RFkx?=
 =?utf-8?B?RmxSZ3VZYU9hS2lDR3ltUUFGTU5EdkFnQVdMYWlEdC9lNDVrcEpldGQ3cGpC?=
 =?utf-8?B?L3d5a3prUExuYmc0YkE3bHlrd2RqcTJ0djhwMVEydUYzVjcwbEJwUmhDUlEr?=
 =?utf-8?B?Q0hJZ09YK1FSaWdaN291T0h0bXJ0Tk5hVi9sYmtPMTdxZVpPU1NMWlJyVmUv?=
 =?utf-8?B?UWVwSENtbmg3WGM3Qmlkc3ZxZDVrTTViVEFrdzc2aHl3T0w3dzNjdzJic2JB?=
 =?utf-8?B?bld0NXZVcWpRQ1hrYWpBNUI0dUwydFdXU1JpRmdxWmNXL0c2WkxSS1hJZmsz?=
 =?utf-8?B?WUtQWDZMelRIdkVBcnZnK3lUNk9OK1doV2c1WHBab2szKzFXMnVGZko2ZFBM?=
 =?utf-8?B?WHdya1N2Ry9BQkRsaHpad2hzbmQxUkpycVZVM1NqOGtHR1ltMmJpayt0QWR0?=
 =?utf-8?B?M1ZkZnM5ajVJeVdlMXRSYTBWaVd5UVowS29RckRocWxDc3hHeGcwVHUrS0FW?=
 =?utf-8?B?d0x6RGJHV2cwVFk2amEzTS9mK1dkVzFBVXY5OXd2cHY4UXZXamU1aXpJODV1?=
 =?utf-8?B?L3h1bHRadCtZQ1FZY0syNEVtYUd2OXFGdjNZU0IyV2diNW9tenUyYkh6WFhj?=
 =?utf-8?B?c0RhbHJMU3RoVy9ibXYvVkVyOFRlSmZsMXV3ZUx1OFVLSFd2SnZtazJEdjNS?=
 =?utf-8?Q?kuHNuQLGgZ94xQVK8kGZxdaj9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a71d1a-76fa-431c-c429-08ddfb456970
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:36:09.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfJ4t54hmhOEHNUwxWzOz7w8Md7uVBqQ5k+6BaE9sNT+Jt/RXa839/p2GPa8QZ6CniYedm4cfzMitrG7apAwvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322


On 9/22/25 22:08, Cheatham, Benjamin wrote:
> On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Export cxl core functions for a Type2 driver being able to discover and
>> map the device component registers.
>>
>> Use it in sfc driver cxl initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
> [snip]
>
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 13d448686189..3b9c8cb187a3 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -70,6 +70,10 @@ struct cxl_regs {
>>   	);
>>   };
>>   
>> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
>> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
>> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
>> +
>>   struct cxl_reg_map {
>>   	bool valid;
>>   	int id;
>> @@ -223,4 +227,20 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>>   		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
>>   						      sizeof(drv_struct), mbox);	\
>>   	})
>> +
>> +/**
>> + * cxl_map_component_regs - map cxl component registers
>> + *
>> + *
>> + * @map: cxl register map to update with the mappings
>> + * @regs: cxl component registers to work with
>> + * @map_mask: cxl component regs to map
>> + *
>> + * Returns integer: success (0) or error (-ENOMEM)
>> + *
>> + * Made public for Type2 driver support.
>> + */
> Nits: Probably don't need the return code description and I'd prefer
> "Public for Type2 driver support" instead (don't need to know that
> it used to be private imo).


If I recall it right, Dan suggested this explicit mention of becoming 
public.


> Either way:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>

Thanks!


