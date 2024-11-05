Return-Path: <netdev+bounces-142085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6019BD6D4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 21:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC9BB20BB1
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2F01FF7B2;
	Tue,  5 Nov 2024 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="7Hr+tHdg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2139.outbound.protection.outlook.com [40.107.237.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CDA1EABD0;
	Tue,  5 Nov 2024 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837790; cv=fail; b=qW+3hriSh7mfGGiEptJRt2VV2n+TQXYg03YwQ17PK0frQNpyk3CZkaqfa0Z2TZ39LOa4ci5eAsmoPpKDiTMiZl5HbxL3wkDqHcwr71N3OX087E39Ma9NVTEWdpXZ8QwsTz49+cKyZEQe075BiV1QCjsNZNhvZJ/UA8jdmSunhbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837790; c=relaxed/simple;
	bh=QGRu8e7Q8cMWbxkUQKXJDLkF0a1GKISCgJEGmwDJRKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lj9a0c3KBHYaYyrxZqwRsrRGvBw0E+sqFpg2CA65DBnejguEW16VfFoIAKTFeIVAYp0yS2OZa/2m6yHaxEAIT43NK+v1u1+LMcwFHMHHf/slQTLOgxcZwsW6cgpMIVHF4B8Cus+tCDroxx1uBTC7K6nbRzYMo3CpEfIti8soGJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=7Hr+tHdg reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.237.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1AxyS2wCF/ySXxSpHavrmmF95fgKZiqq1kVtVxFK0kpbUFTfmmWw7FLbIR004CzMUMbVYLTXpikA3pI0bjBR4V0pq94Ka5ToDUbaBiV0muWENYZIKUSznEuoDDwI6ViOaoXUc5hXozmjVjKpnpAE4RvFRCCBKr+z8kWdJiKGY8nOiiiQoIl7E/Z1q6iiHOfkJquAj8DQDMCH0yRoNhq01oZZ49K8zoxR+bEqh/VAN4a9o6dqeT/HtuTVM617YoJ3hYVmiPnAZLA4QzX/VeRGgfhv0sVu6oc2+1npgpd2ixDanzYDf6wFvdSYPHWA9XwTyIMUEwwK/9xbAxStpYCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv8QdFk2GF7o9Ljjm0s/1doZenir128EfTZatqIsACA=;
 b=nUZ6JnjMBoMWWXgAKdAsY2C78pJL/PzEF9vjlylPmj3MSQd2SKK+j76IeJv7oxkJ6TX0bPmkhmuyDBX6q8TZgOV1zMqpjWo1WSb3Hmah5+4uWom+9eRuSYCmmT6j+uqt02Q0R/EGYfE1tkTb8QzIXOIagbJPe5QMNHhXRUd75JEgceLDhLI28FetsrrHH0VWbz2iQGNd1TfTXD8oNolW5aud5XftJOmzn6tWAKX9bt9x5TjUg5tuCkoN/JOC56VnLNOGDi2UyE7zQiL6/KKhMUcPOqXsMluFZafcX2qEj5ljPmS1BE/c23Wf79ApAvvC3bjd9crPqBAs/KOwAz4Gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv8QdFk2GF7o9Ljjm0s/1doZenir128EfTZatqIsACA=;
 b=7Hr+tHdgdJ+Frb7q/l8pFWkdZ9DYsNXWJh60xlOCVAYLCHWeJtaxyzD21TXsofHAwXbdarJRx/SyZCJQOtTRyqUVw3Q58DAhC/A6ybcAwYwYotLtazIxwGfbeTzGxL1rKn8CaPUjEBlGepVeIIjbuAp4HqKK5NozfzsVJhlSOmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 LV8PR01MB8499.prod.exchangelabs.com (2603:10b6:408:187::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Tue, 5 Nov 2024 20:16:25 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 20:16:25 +0000
Message-ID: <693f39f9-9505-4135-91db-a7280570fbc3@amperemail.onmicrosoft.com>
Date: Tue, 5 Nov 2024 15:16:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
 <20241029165414.58746-3-admiyo@os.amperecomputing.com>
 <b614c56f007b2669f1a23bfe8a8bc6c273f81bba.camel@codeconstruct.com.au>
 <3e68ad61-8b21-4d15-bc4c-412dd2c7b53d@amperemail.onmicrosoft.com>
 <675c2760e1ed64ee8e8bcd82c74af764d48fea6c.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <675c2760e1ed64ee8e8bcd82c74af764d48fea6c.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::17) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|LV8PR01MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cf5ff0-f4dc-445e-2b89-08dcfdd6b93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFVuTCtVbUk0T0NhMk9hZTgvT3k3V0luRkd3aDh1MEJ0NkxYS0RzT3J5NVBj?=
 =?utf-8?B?enhteUkvRzYvNDFDNUMxclo3QkZXSFBicWdWaGlZWHZZSHliakZDaFFseHZP?=
 =?utf-8?B?bVJDWEJoNjdxcnBiOC9kbG5oQlArWmU5b3B3N1dlK3Z3S210NG1aU2Y5cCty?=
 =?utf-8?B?N1YxaHMxN3MxSHhScVY4cWRhYWJRODhsVFY5UVhIQ0dBQTZNWW9NVlZMM2NO?=
 =?utf-8?B?RUlteHBWMVlwUk0vQVFTYVFCWXlESmFLR2d6cnRiaXZNTjdsbllMVzQvNnEw?=
 =?utf-8?B?c3lWVk1hRzlybS9rK0lyQjJjazNCVi84RDBwWEpQcU95eWNYT1F2dm5BU25U?=
 =?utf-8?B?NDJjRzFkenVPblA5eG1uaS94NjJGWjNpQS9TWFVFWVVxVVhKWkRlNXJJQTJX?=
 =?utf-8?B?bDY4Y3Nxd214MCtrVEhFQjMwQUJsN3VKeXY3NEpreHRUK0dQOU4wRlQ0YjdH?=
 =?utf-8?B?WlFOTGs4Wk03eUdGTkU5cEY2UzFzeDNpcG9LRGoxNWl3NnlicEE3RU5ySUpF?=
 =?utf-8?B?OU8rblk3MnE0VzhqZzBJYmlFQzR2ZXVwblN4VGErcDE0cVpST0x5SXg5S1Ay?=
 =?utf-8?B?WFVWbDByTTdvLzhnTDA1aEtUNFloUit4UWdUb2l4SnNYWngwOFpaTWdKcVVZ?=
 =?utf-8?B?bytHWFd1QVhsNFprSUZ5NS9XSjN1WEhBanpYSkNOTGpKQlhXdmhGdk9tcmtQ?=
 =?utf-8?B?Wjdkdk9ZSU5RYUNSN2huWDJHajYzNEVxNjQvWjh4cmRHUmNud2o3ZVNwbGYx?=
 =?utf-8?B?T2tiNlA3UHN4cjBESHFxb2xXYnlyMUY3WWU5MGFzZHBUUDRNS1pUVEk3V2s2?=
 =?utf-8?B?U0RBVTQyTVFialhZSC9UVTNicWJCK3VTREswbGdvZ0crL0NSRUtyYmg5aWQ4?=
 =?utf-8?B?d3pLdHVhRTdkbzR0WUJTMGR3V0JINUlzVHVVbm9NbFpFb0c2V0J1U2l6WE5x?=
 =?utf-8?B?dGpqRlJTZGFhQkxhNnI1UUlGZ1NvSHRXYjNhb08xOTl0YzZEcHJQMnVwUUhT?=
 =?utf-8?B?eFBQWWhMVk9BQkpSbzN6ZFVzellKZUwvMU5kd2lTY2hibHFON25mNmhZNXBR?=
 =?utf-8?B?VlgvWmhncThpQmVNWUpadSthSzNUcHFhWU9CVzZ4UXZDT1FhYVJlUmFzZDJ0?=
 =?utf-8?B?S2ZTWld1MUhWK2JWOCtjZFpEMG8ybVNtRjlvNzB4bmZOZElRN1hnM1Fxd1B4?=
 =?utf-8?B?dXFNK2QzWndiQmNBZGxBdGtwcXdDYThpOUlEdTZ1YWV4S2ZaMjk3UFgzRWVN?=
 =?utf-8?B?Y2lNWlh0NjlRS1hCSEFBeDZ5VzdUeVhVbWZrSCtIVnVzU3B6NnVWUGt0My9r?=
 =?utf-8?B?eXJhenYwSUptbFRRQkRkNGh6aDIwWmdQcFpna3ltY3doU3hudzdLdGFhY1Na?=
 =?utf-8?B?a2loQkVUZm50SndtZlR0Z0hPTndVQnpXam9ybkZHMCt2VmxWY216SXMvc2ts?=
 =?utf-8?B?NHFFQ0R1TW1HVUE0Rk91eHpveG5XTUZ5YW8rQkRxT2ltRndDMVhQN1F3Ui9u?=
 =?utf-8?B?N1kzc1FIQVhEY0ZCN0VUVTZ3ODFKaE5WRU9ITnVTL1UxNjdidjRYc21oMnMv?=
 =?utf-8?B?MlVNeDlPbmM1cG9CeVdxWXliNk8xNURHTE0vQ2dYVmpNNXUwVlhNeDBrdHhn?=
 =?utf-8?B?eGtkdmRzc0p0YmlUV0VpZmFQdFdJQ0M0dlBJblMyWDhWTWFSNmMvNWNaMFZh?=
 =?utf-8?B?R3pXczYyRmU5cGVNVWJLbGJGd3kvOUFJWjNPVkg5NGVBVlp5L1FCU3ZmcXRS?=
 =?utf-8?Q?uEyf1P213tcn8/tqNys1UdIYcgkxe+JePKJIVY4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWJVYlJGc2J1anV6UmtjanE3UVlwV3JrL3NURE5scjQ2RzVObDFpYlAvbkJS?=
 =?utf-8?B?SkREOThHVXU1cVVoaEdnYzZaQ3M0YVlSNHRFY3BMRkIzK0FJZm1YU29rSU96?=
 =?utf-8?B?ZkVWWVBINU5TRG15TSttQ3dpbTlhZWI2UmcycGYrQWJlWWdkdTI0eGJMOXpW?=
 =?utf-8?B?TzRyQzI0RU1rNEdCbkFpVWdmNHZqVm5RRUVsNENsS0ZxMHYxS1pXWlFiUi9I?=
 =?utf-8?B?SjN6cnNEeEpQNUUzNTBablBMNkxZMUhjVWhyQis1bWdmMkFzeFNwakNNUldW?=
 =?utf-8?B?UnEwZld1aHNySnhVSHcvMDFsTjY2SWFvcFFlbndGYnRHcWRuMDlxZkZ6Nmxr?=
 =?utf-8?B?OXVVVlEvdE9TWGpuc21RVHh0S2VFUU0zVE5oZnFqNUc5SzNGSEdwMi9YU0da?=
 =?utf-8?B?NVpDdndNRUxKemZVZG9HZDdhMXhoeE9QbVZibnh2Q2h0K3NxKzk0SjZYVXdq?=
 =?utf-8?B?Y3FyVU1LUExCQzJJbnpCVUdXUDRuMTQ5a0JHeDM3M0pkL0l2bHgrdWwveTZC?=
 =?utf-8?B?bnc2WDFsblJ1Zkpsc2kwOXlnVnRrZWVEeGh2YmVPc3VaWWwvcnlFNmtNK3NT?=
 =?utf-8?B?R2hYbm9uUVFpajFzQTA0KzRvV3dRcEE1RlVJbUYzemtSemlGN0poaUQrT29p?=
 =?utf-8?B?dGRlallDTjY2bHRNUXlkUzd6OUh3MFpjbHhIbVJJbFc4ZnlZSTYzRUNiZ1BX?=
 =?utf-8?B?RW5WdU1Md3lZMDdYdE5GS1J0Y0czZ1BoMStmdVA5NTdOM2g4OU5nMlhhN21y?=
 =?utf-8?B?dFhpUldtd2FsYzZrLzVtWldCUmFlVkdlTmI3b3FJRnlnNWVHQ3lTd1ZQV0s5?=
 =?utf-8?B?eWEvOW9saFJ2ZklxTDJJMGZZaTNNV0lHak16NkpzM25hQnluZk1BaHl2MG1i?=
 =?utf-8?B?emN5Y0dQR3pyUXI4elo1Sjh3SS95VnR0d1RTOVZEUjNOU3p5S21GcWRQMjVt?=
 =?utf-8?B?UGNpWUE0WnVpdzVYY2d5YTIvSW5JTHFqUGVIMEd2UGdhSjRaQzdZM1dSZkNp?=
 =?utf-8?B?QU9sY0J4ZXF2MjBEbFljSGdsaWhOa2NFdjg5ZGdxUmt6cUU5UjZMNFR5MmlC?=
 =?utf-8?B?ZDdNOUdIQk1pU2JkWk05U21LYXkvVWVTVHlRYXhGVTcyMThXdlRsZWN5OHVi?=
 =?utf-8?B?RUVBdjFnYnZNSnBkaTFaUStPVVpwNG41Vnd5WlFYSG5Ta2diakR2aTFtcXc0?=
 =?utf-8?B?aGFGUnUreG1KRzRydnh4R3V6MGRwVkY5ZnNyZHlBZGg0ekV5TDdaZnpneGVT?=
 =?utf-8?B?VWY5MlEwM3Q0eTN0aHFaSzBYZmZXNmZNZFZURGtNWndHbWpXSkZuQjJIRkJE?=
 =?utf-8?B?MUV2amhxd3Voby8rMERtL3VHdURPOVZoMk9nRUdERVRYcXZtaWlCbmMya3d0?=
 =?utf-8?B?bk42dzlKdGtvbnBYdU5LSzZBd1FXV1pyRWhjeU9ySHE3aGVDVE5NZVAwcjVy?=
 =?utf-8?B?SWJNV043QWR0cWc4RmxzaGsxcFEwQy9SNXdwNUZsaUl4djhYY1NPL2ZibGgv?=
 =?utf-8?B?cllDSWtHVFlWSTQzTG9ZUU44QUUxc1ZPK0lnb3QxN1NPQTdubEtCZkVaYm5Z?=
 =?utf-8?B?d3RUR2dnZllwR1kxM0tkVTZIT29PTENOamdrRHJTdmhZZW9YdHM5ZU14V1Ni?=
 =?utf-8?B?cnpJK2RONklHeklEWEMrVlpjVVd4T1NabGpQQ20rclJsYWxrYVdzU011eDli?=
 =?utf-8?B?QzBKbzBwVFZaeUF2ZXZNL2NtOFlyT2x0c29BZlBOWjFvREpmWFdmNkxEbkNH?=
 =?utf-8?B?dGFNdkxLV0tRZWNQUWgvZEVsVmY3dUovMk9nVWZubE1HTlNwSGdZNnY0TVNx?=
 =?utf-8?B?SzkreHduTEFaLzNEcG1yaEZvbXAyNjJIc2pWblh6aHp4dDdnVGQwTENFRUpW?=
 =?utf-8?B?QjFtN00yMWhDTlJmMjNzZlZCdFo3NnVMbmhKUFJGdXhNZ2pPcDZxTkwxVmgr?=
 =?utf-8?B?NERoM2MraHQvV0RpNXk5YjNmZFZKbXMzQk00VTNpWk1WenpEd3NVNW9FaERh?=
 =?utf-8?B?bUVwOU5reVFTa2NtWEZOUmhRVDRlSm9hUUxWMXh1SisxOEVxajg2RFV3bDdX?=
 =?utf-8?B?cmZyblN2ajFFa2lpRVQxSS94Qk5ubHRuNlROSGVMRE5wUTZKQmdjRXdDcjJl?=
 =?utf-8?B?Y1JjS04vVUFUR0ZFS1krYndKcXRGcW95S01YM01BdTU2aUlmekRSUUJpa3hq?=
 =?utf-8?B?VnIvdDF6WERibzdNUkJqZzdqUFFXY0hHNnFtWHNPcElzMHRSaklBcDNUNTFv?=
 =?utf-8?Q?fhJ67nPSjqezJ2IDthOEEr0qM333FhZsoY35Rzk+X0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cf5ff0-f4dc-445e-2b89-08dcfdd6b93a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:16:25.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boxyklQSxJrlNjEfLodxKwkVBILFtdjN2b22OSsivnG/8BdlQeKGnjEtSq6WZL0pTiyi//gFLbyBT/IijEJZpOMGFDnE/HbH9lj67zetxUNYSaZcjmpO7HQowXX0kXhY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8499


On 11/1/24 04:55, Jeremy Kerr wrote:
> Just to clarify that: for physical (ie, null-EID) addressing, you don't
> need the hardware address, you need:
>
>   1) the outgoing interface's ifindex; and
>   2) the hardware address of the*remote*  endpoint, in whatever
>      format is appropriate for link type


So Here is what I was thinking:

Lets ignore the namespace for now, as that is a future-proofing thing 
and will be all 0.  If The OS listens on index 11 and the PLatform 
listens index 22, the HW address for the OS would be

00001122

and for the Platform

00002211

This is all the info  for the calling application to know both the 
ifindex and the remote endpoint.

They can re-order the address to 00002211 for the remote endpoint.  If 
they have the link they have the ifindex.  It seems like a clean solution.

Adding the inbox id ( to the HW address does not harm anything, and it 
makes things much more explicit.

It seems like removing either the inbox or the outbox id from the HW 
address is hiding information that should be exposed.  And the two 
together make up the hardware addressing for the device, just not in 
that exact format, but it maps directly.  That is what will be in the 
upcoming version of the spec as well.


