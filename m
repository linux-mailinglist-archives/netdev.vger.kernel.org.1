Return-Path: <netdev+bounces-154329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FBE9FD0AD
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 07:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B331639A7
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 06:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D6513BAEE;
	Fri, 27 Dec 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NTsj1m/E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB71F5F6;
	Fri, 27 Dec 2024 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735282595; cv=fail; b=biXE0+6TZgh+M9Ku9LbSo1pZHvzWz3xL34SlGWzP5E00WStC2l3i57xuo9N57FRwckjdHcO+W/IB6Z/U7HUahsaBvvc3DvHd1LUrChFBnNHI0jbc9wau9zd2eopcIOXCA1SRt75gh7dtTpV1S42Hj0TAq5RWVM1XBe1nFY04gYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735282595; c=relaxed/simple;
	bh=Mx4161GvvhY4HpZwW2mVAzj7nVwR/l97CK4gnjRKSIs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IHQ+dwfByW1gbhcyvtOpDzXq4cPR86FrJ+UygJaH1ZgbZp+nf0l59drh0YmVpzHFQGjzeDJ9HthJxtdrICo4Y27BxpzELtyJraeYwBIvKfcxJbg7JH0jEraRGISfSrm0KDdTiAYtVaK/RMgCa2RMKF1fhfzGl9w1Da4ui8G2g2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NTsj1m/E; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDNACL7zSXV2XlRzmTRF7I/hhDsHDaLHWXRYxbKToREUcm54aHEnMC0fhIjaxHIUW3PtUYW2TR7NT4B3JJP7BFkWG8JTa5PRtY1o5EDkqrdUJkhcnC20Vd/9UDep2kTekJ1ZkCNasqXGDMbY+oqtCrscUxVNVIPgU89YZXFKSw7be2EfvVpO+xeI4wVzRgB+sF8APPPts1sxmzuUbdrV1fMXH69a/HeG+tK3qECanzbZqV/zkzJr5tlE6cWcj1FrBdB6q9f/Nbiu5+JHqJ9+a865tvce4+igBmlfkiLrEc7PVUDUYdOI/Xqcncc8B8SbPOqamp/A1Kuwj9XSiNgS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoFIwGRIMpQzO4Ep4SWb800TWsGIe6O/RwRwJ0eox2w=;
 b=i17EJEKy90YYqZEgHWS61V0TIY7dxtdFVX/zO3oCSYpuGE9OcMN8aDZi+By8ED5KTeITDOJWO7UNrIpisZBdOMZNq3AEK1CahotIoSwI6EpgEybO6U4UxwMzj5YNp/f3TSXWCunzWFNEBAgN7YSUF//8s4YKDpSrodc1GQw+i8DgL9qqZFfx5jOEklaCzvQZCf6VBSPczRf+5C233Rsn6uFsbgusMzS9NHP8H8FbDJgPG22xWfZQGvUxql2PYkz46gHDETNWt556FtCMwsb8/FK7q6HfNJhqJlGuRFGojMg6QLbDJvKrZ/7mh1uuuyDAv3RNn7wN86lfco5+4bePmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoFIwGRIMpQzO4Ep4SWb800TWsGIe6O/RwRwJ0eox2w=;
 b=NTsj1m/E7M0EAvSnIBR/DAmpYsClMf/w1YAllgu39zjpoPZYiCD1Mee18ZASe92UmV2CnhqUrx6Z93vrIVWEd3H4p/KjJfWZw2WGx7kaVQfdBA7x36EMXzLHapm+Ww7JaFRvaEnAZ2yXCbjsOnPWplW6LDKoGs6Y9Zzlx38kLKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Fri, 27 Dec
 2024 06:56:27 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 06:56:26 +0000
Message-ID: <aaecdc3e-7f01-8d05-e350-6819f604edd9@amd.com>
Date: Fri, 27 Dec 2024 06:56:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <20241224163549.00006154@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224163549.00006154@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: b11f63ed-e6a6-46e2-c1dd-08dd2643951f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWQ5TjFDbllDdHc4cG9jZitBOTNqYlVuRnVURUJYdVpzRHFUUnhkeklkeDhl?=
 =?utf-8?B?OGNER0JyMnJZN0xGck1Gc1h3dzlMVngvZDdCeTZNYWNBM3JYQzBrcENsMEQ1?=
 =?utf-8?B?ZS93S015NHdsSXRHNkhqVVBFdUorVisyQXNQaEZEeW1EY216UU16cXZQMmxu?=
 =?utf-8?B?Z29SeFpYMGZxSVVvMTROOUk0M29RZkJ1Smh4ekpnN082clJ0RnBqY3JrNUdy?=
 =?utf-8?B?SkQ5aVNnZFFkU0ZMZDM1Mm5tTldSeC8xSUgxUFJ3Tnh0N1pMUG9yMXlkSUho?=
 =?utf-8?B?WUR4QWdsbXdMUEtObDJ5SExaeCszNXczeXdCbC95Q1ErcjNBZ2xTYy9EK0xO?=
 =?utf-8?B?bVRNRFI1b0t5dlNZWm9WSFpsdDQyN1Z1YlNqb2NlK0dSS3ArKzlOMUZvbTc5?=
 =?utf-8?B?bFB0bFM0OTluMEdWYmhlMHgzdVh2bTJaS0xPdFhHZk5pQ2xJdWRhVDFkeVNu?=
 =?utf-8?B?UVNYNGJWeTY5dDBLbUh1OXJRREtqRUFwOFd2L3MzSUtBaGJUNGlaT3NIRzBH?=
 =?utf-8?B?U3piNnJtc1M2Y3EzYlE5Z0NQVHlRNDlKcDB1QlVYZU5tVXdxUnpMZDBvNFRS?=
 =?utf-8?B?SDRhQVBnQnh6L3BtVnhRRGZ4SlBvQ2hXcCt2TVBmU0RYeXQ1N050Q1FBeExG?=
 =?utf-8?B?b3lJcWJ5cUFZaGJ3d2Z0dWJJN1BMd0wrbmV0bW1RZHlMcmt1cEtlYzZHNzJx?=
 =?utf-8?B?TEhVditTV1FRaHBPLzFTTWhYYVVMd2x3NjVCTHZrM2RWQkE0Y3oxeWFrNGZZ?=
 =?utf-8?B?KzlvQi9GZUIyMHkrdm8vQ2lGemd2SHk4YjJ1cTI5YTdlT3Q1dmpqdy80OCtS?=
 =?utf-8?B?cG1zTTB3NVJwT3RlNVRHL1Fkb2lwT0dkZitWWjk5dUxhUnJDMTQ2d3h6Rlhw?=
 =?utf-8?B?UHFQQVZudExtVlhHMWdBbGJSbEllc1BNVzlBQ1liRFFDbm50VGtSbWhSYlk5?=
 =?utf-8?B?WlVYOGI5dm9rVXlEenFjejJMVXRjSDAzay9Zek1DSGd3U3dTbUFOQUNBOFBz?=
 =?utf-8?B?empwWm1JTzdvN1QrZEFUUysvMG54a0ZOdUpjMlZIOVZYME9uNHBFcFRaWEhw?=
 =?utf-8?B?T21PSC9FZlRwMWp5N2dueStxd0xHZktPUTUyR0U3cmxqUXp1V1ZFMlJSRHBY?=
 =?utf-8?B?a215S2JtWTNScXBtOWpaYTRyc0srQitYcmIwM1ZjMzNsQjVldVIyc2hGbW10?=
 =?utf-8?B?OEhSdlFtOEl3QlVPOXF6VmdoK1l2MlFHMlFHZm5ZWGhYYXVVQ1BYQ1ozenA2?=
 =?utf-8?B?QThJSkxQdThUc1h1ZjM3WSthUm1NK2hKNHQzcWJlYWR0OFNDSEJkR2ZqanBV?=
 =?utf-8?B?TXJKNVo1UkhKL3ZuQWdxeG1aWVl4TUFoSk5VUDJlZkVIbFhITjltRzA1T2dv?=
 =?utf-8?B?ODk0S0oycjNwRHlOQnBZMi9XZVJIMHcyVmFCTmNIdFk1bTJzZGNNcjNHeExz?=
 =?utf-8?B?SFpkSkhjY3FjeGlOcXFLU2VVVHRvK2FZZC9EWVZ0dWt4UUVKY2dkSmUzWnE4?=
 =?utf-8?B?Z2t0U3ZLbGIzeTEvK21Dby9NQjNjVWYrK1dSZGNNSXNHR1kzakp0NlBiVW9Q?=
 =?utf-8?B?SGVqU2crbDhiTGpoM2pxVWdtS2E3bXlZczlLZmY5UTdDZVp2YzJEdldvS0tV?=
 =?utf-8?B?K2pnMTlGNEJ1WllvTGUxSC80RmExMjg3WHFySGdYaGhXQXR2MkJPdUd6a2dx?=
 =?utf-8?B?dDgrMEJTZTlpY1h1emZ2RWdGVG82Rk5HWWNsbklkSXkxazVjaFZpT3IrWHJ3?=
 =?utf-8?B?N3VrWjZzaDB6Vy9RSmR1U1krVHBXd0gvVEtpUVJtWHJUaHFPTUlhWjgzc1hF?=
 =?utf-8?B?SGVaanVGdWhnRHJ1RUhJcTBFakp6RW1jQXpQVlZESG43aFlGemhYRDlBc1h0?=
 =?utf-8?Q?tPFr7NPQ7llZW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1NUY1Uvd0drOVVITFZMTC9YZDBnT0o0SCt1d1dHYjJXU2pFWE9IVnhGVEJk?=
 =?utf-8?B?dkVRNWZFbFlNZEJ4NUNtV0RpS28vNmZkSFh5OGVSRCtkZDNwZHpJdW0va2xm?=
 =?utf-8?B?dXdVRXpzcDliTU1yblIvcDJTNDU5UlA4ak1paG04L28yVDlHalcxOE9iR3Fv?=
 =?utf-8?B?QU83MEM4NGh6UE9TRlUxUUcrVE5EcnExNWhMdG1JclNHN25wZ2dGTzBtL0s4?=
 =?utf-8?B?RFdyemtaY3FhdnV5bktWQnV0YVpTcDhMZ0MxZ0RQWG92KzhXWk5KVllKUkRz?=
 =?utf-8?B?K0Y5dGE3SkxsaWRiekpJa2RhSTN5ak1NRk1tYjZzd3pMcC82Z3dHV0dSYmhh?=
 =?utf-8?B?WVFEbis1VkUwT2V0b3dCcHpIY2x6MC9WRUptSW5md3hVNk41YUVHNDdBdnJI?=
 =?utf-8?B?TFZJYVpTdEYvODhLQ0V1VEgwdUtMcklLYS9lSWQyczY4NGNvRDV1eTlVMk9v?=
 =?utf-8?B?Z2xqN01jQ01SbGhvUFlSMDd0djR2YmRZdDE0ZHhETldHM2ptUnJzVDI4eTZC?=
 =?utf-8?B?K0NGSmRwSXlNa1lORFZ3ZDlDVnFNRmlyS3VEN2p5SXhiYUFqUjdLUVgvRC95?=
 =?utf-8?B?YlowZWlxNUIxYlZFdHRrVlY2Y2V2aDY0RGtIMlpaZkZPSzZLdlp1eERMVlNo?=
 =?utf-8?B?SlR5WjZDMmlzbkMrd2UxMVBnNU5GR1FYby9Ca0RxSG9QTW55R0tPYVF6MHk2?=
 =?utf-8?B?d0FUNmVTMDJHQnNrQ1k3c1JiZFhsMkZ0UXdIbGFqbk1ZaG5adDlLYXBZdnhQ?=
 =?utf-8?B?OWhQY0JPbk9vR1pHWXN5amdxRnNpWkgvTFAvTHQrWnh2Vy9XNEhUb2xHWUc3?=
 =?utf-8?B?c2ExUlFCSzc2dVVCWm93Q2Y2bTllMDJjMDRyc2o1Ky9tZ2VMM0pBK0U2S3dM?=
 =?utf-8?B?M2k1cDlQMUR5TXo2clp5Q1hIdFYyTzhTWjQxeG9iempoUU9iOFB6RzBsd0VX?=
 =?utf-8?B?b1A0VFA3UUgzL2JyTmNiL280d3NwOVE5bCszVXpEUlFYaDZaZG1xbFNXQUJ0?=
 =?utf-8?B?dURINUN6RExDbXBFZXJJTCtneU04dXFqeEdaMXpTTHZBNnI2Mkx4blRLY0Vr?=
 =?utf-8?B?aWVpTlluR2RnUGJBcW9aUUw3dDlVd2ZFY2FXWEpsVDdySW5qMnU4TGV4bUtN?=
 =?utf-8?B?ODVLWkJuQ0RzT1pNRDlsUlE0M0pBaFZBZ29NNlNDem1Rb2dyb0ZPQ1NTYldr?=
 =?utf-8?B?U1o2UXNkdWZPZW5IK09FSmdyZ3A4TU9uUUdoQ3hWeFhDeTI0LzlFb0RvNkJh?=
 =?utf-8?B?UjRIRGt4VTFGaGVMbzM1RHUyMjNCd3VEVUhRWGNzQmtDeGRYTzZxT0x6TlJE?=
 =?utf-8?B?VzlFZW9YQkNIU29Za1lUNEhIaXJ0V3d5eWhpZC9ibmlmVXFDaTVKb2FKd2pP?=
 =?utf-8?B?dy9QNW5wQ2prN3ovajh3U3JJeTM5NFdEWmZYV1YxM0R6dWNxV2ZreWNpRmI2?=
 =?utf-8?B?bjhGQWNObWNBM1BEZmVBRHAxUXNOTDgwZUdMenBVc2tFVDJvNXE4TC9YcmpB?=
 =?utf-8?B?cUhOL1JicWxpSEJhUEJNZER0OHhBY3ZiQnZrYmdpdVpuSjIrdk1TR2FxRU83?=
 =?utf-8?B?Z0RDZFpsMFVYS1JpMEhCcVNZelNoaFp0QXdHK2UvL3M2S1V6WmJmTkJwbnM4?=
 =?utf-8?B?ZTZsQ0FCc3BXL2gxRE1yTm45RUs2TktZU0JiQTgzSXdwdGQwOUVSSHh6a3pG?=
 =?utf-8?B?Ty9VQXhhVlRQYlNGaXplb3NaYlFuVkpzRDVsdkwwMVdRLzZpR1VIaGlyeHh1?=
 =?utf-8?B?VFc4S3FJQ0o1ZGxCSERveUhXTHhmclNVRWlINGYweHdDWEFvbjJnQ0YrMUZi?=
 =?utf-8?B?Q0RkL0V1TUkwVFJmWCtnTEU1bkRJMHlkNi9ydTNMTlVBYW50VytBdFhZUk9Y?=
 =?utf-8?B?SUN2ZUhBZGlYQ0NKTmt4cWhNUGFtTFVOZVBmdmJuY0dXeTJlZ29DcTAxa2Ru?=
 =?utf-8?B?Q3pLMGxpdlh4UCsvTGw2T1BCYXJ0ZkZDb1Awb2pUN3lkSXFvZHRwanBUK0lS?=
 =?utf-8?B?YUZiakNGeXE0dDBQUWh5M2Q4eW1HSzNLMzE2ZUdONWgxNDVQRDdWVXpFd2Rz?=
 =?utf-8?B?bXJMRVg0SjNxSWVFeEFlbEFkVWx5RGh2QkZBQklMM1h3YUJMU3F1Q1JzNE83?=
 =?utf-8?Q?8DqoSekBS/gXqVlxQzmwL1Anp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11f63ed-e6a6-46e2-c1dd-08dd2643951f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 06:56:26.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puSnIjg+0UKWHYTnJhn7xbatI+1z54xhdlTZPoQ+hZv2RllmYQxgCuX+JAqHUM9+ifI3C9LBJjdQWhoPHzWD+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286


On 12/24/24 16:35, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:16 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state.
>>
>> Create accessors to cxl_dev_state to be used by accel drivers.
>>
>> Based on previous work by Dan Williams [1]
>>
>> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Hi, I've missed a few versions due to busy end of year.
> Anyhow, catch up day!


Thanks!


> A few comments inline - with those tweaked (or ignored for the "meh"
> one :)
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..19e5d883557a
>> --- /dev/null
>> +++ b/include/cxl/cxl.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_H
>> +#define __CXL_H
>> +
>> +#include <linux/ioport.h>
>> +
>> +enum cxl_resource {
>> +	CXL_RES_DPA,
>> +	CXL_RES_RAM,
>> +	CXL_RES_PMEM,
>> +};
> Need a few forwards defs to avoid chance of future header reorg
> biting you.
>
> struct cxl_dev_state;
> struct device;
> Should do I think.


I'll do.

Thanks


>> +
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>> +
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource);
>> +#endif
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> new file mode 100644
>> index 000000000000..ad63560caa2c
>> --- /dev/null
>> +++ b/include/cxl/pci.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> +
>> +#ifndef __CXL_ACCEL_PCI_H
>> +#define __CXL_ACCEL_PCI_H
>> +
>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE					0
>> +#define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
> The brackets around the multiplication seem like overkill but meh,
> they are harmless :)
>
>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> +
>> +#endif

