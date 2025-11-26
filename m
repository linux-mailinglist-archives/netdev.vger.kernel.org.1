Return-Path: <netdev+bounces-241780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8143C882F1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E3355A14
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE07927C866;
	Wed, 26 Nov 2025 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WT2Xaiqg"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A84F50F
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 05:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764136132; cv=fail; b=qz0pcLpU+FsLlzdgYrNFQF7cGJxZxhgbazky1GlORuGG6PoVyky0qKJ2diy6XtDY9e7GSOZ9yS2hiri61xvfUXFwwpM4cZFFOPHScxzB9Xo65bnYOR0C/ZOphO5PQaGaKYxnPQC/wGNlbFAfycA7cR0qO51PMLxD/kCX5fgqF20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764136132; c=relaxed/simple;
	bh=W4/lLNeiWjG7AE9ezNWolF8zLENIWE+cK3ci470acwM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iyTPuOva66ZGXn0qWUT0EFunFc82Svb72e1dXmHg4dqh1u9DoK/v3xBJB30zMVl1JCRjIMQJNGWdvbOnmoFrZo/Lu1h4DdvF2x/ETNqAAxEu7tOCo8YfEiRt3T1aF22eAAMj4B7OUlpZBKQNYNgRbiLPCoIsFuFgMN98X+w9woQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WT2Xaiqg; arc=fail smtp.client-ip=40.93.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGZzyyi4nsI3SqxwGDHXucZx1oVITpHi7AGIsiyNjOOlHwAEu3/6p6XXXjz5GRUX876SKg6JLWZFrWOwK34lm7uUFuV7lykAJMZKRuwJ1i8nPKMkTWbCumSka56bQL6HGKbOWfwcPy8AVM3xCMr81NAakB4JTuegEJef3U4n9kWK4nN/3EPqfWz8zwsv1jbsE6fDU93S+mUX+17C1HmY8Qbd5kTsNfX/wTjHJPJpkqi8Cu0zazAvT4bsr3LWNK2LMoDRx33YANCxfTJJRgQ4uxipW8HXdNUX78RBVLak3eVWucnj1QXpeBNsb3ptUf5U6uXJpT8OXgjWomgS6TV5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwnERKF6P2/XRNRr0/tfpk8Rr9Y+MvadLV0MkVukwv8=;
 b=nK16EX80MnvpO8kSOJt39xDe12YWABEmGMl+5avBkea8QGa6QYSubwKO07DaaQdhoqfmAfiD2/PeRDAXmCFe+ob//0gvE402bPAEz+9+0l//FTj9uDfNVsMa5HpfbI9JXq1sjv5O+Vv8rUs4auyaVH4PSvPz+vDIFjreoft8/ejvbkiaKxyeYt5ehhfrt3i6B3RJu0MC0gpGFqjxwU91pOxENFC7QZZXtSz9Oj5V7cm0ZyxBnFVYxnCHrxarAq53nyJS7fgC6KBnJxf+EyXLuErTLyt9MMqx5SQkHYLASmdGIx74q4W+9hu3GVZp2/sfpoUkp9jP4oBF83bbhJPaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwnERKF6P2/XRNRr0/tfpk8Rr9Y+MvadLV0MkVukwv8=;
 b=WT2Xaiqg8qIjHtgrnXeSNI/KgKJh6TuOHotfKYd61T2nMNYm+KURJTjyv7rtWAso4Al13FNgybNEUJhX4/raeoL89gSD46G2oePOa60vbAgIoDPn6XuLAfy7WDXXoCNzmU+NsHe8Ur3bmJ6Nj0X8qTcZk4kMOBg4tMK24oqN1S6qDhu1LQ9LWsDtNrhm/qN3E4gbvMtNDey7YNEmTkIwOOIIyl0YXHHZ05Zv6JskQcGqm+0vwEnWEiNadQvPcZbkc4ghF1crjV8lgjsR2TmZ3Q+BI6AyEEVHEW8BD5EQT0WjGy5ksUuEZ5WbnLpGetMnkervRFAK992glwcnN2EO6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 05:48:48 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 05:48:48 +0000
Message-ID: <66bfbcb1-5cb6-4038-be49-4dcf610dfac8@nvidia.com>
Date: Tue, 25 Nov 2025 23:48:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-10-danielj@nvidia.com>
 <20251124164600-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251124164600-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::45) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: fba02b67-3713-4d07-031e-08de2caf7876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekZWdFFtSVZUdEZrR1VyNjBmN3NGVGtmVGhhSFJMNnEvWWZEY0p3ZTNweDQz?=
 =?utf-8?B?bU5HZmkxLzI5UElnU2RpaWM0UUZRS0pUZCtaODdCbEYyNWNCbDFkUTM2K2My?=
 =?utf-8?B?bmlKM041ZGp0VGhuWXZnNytZNUtIRzdNYVZVbVhoQTI1WjlzTStlL0ZLeGs5?=
 =?utf-8?B?WU0vd3djZ3ZMQ0JTY3dSOXBidGFzWHI0Wkd3OWR2b0pqVDhMZkd3ejNtL2Q4?=
 =?utf-8?B?R0tDYnNNay9vbjVSSFkwdVJpWUJpdnhPL2ZTeGh2YkFUQnlPanE5NzRmZGFT?=
 =?utf-8?B?Y3ExanBVRGRQZGNzWHAySlFEU080TGpYbHp2eUJieHlEMUhyRmI0WTY0WVkx?=
 =?utf-8?B?bi9WcGJMMFN3bmU0dldDL0JSTDFLTGxqb0wrZ3MyWTNoRjB5NWhLOFRDcFA5?=
 =?utf-8?B?K1VkT0pKdHhNNWJST1BjVVpoNS9yS1lQM3ltbW4zZmdsUjh0MWZ2RlNFMVdG?=
 =?utf-8?B?TVVLYXp0Vi91OUppL2F3VGdZSXpHZTFtZkY5NkhHS3R5bDlJck9icitLcXFL?=
 =?utf-8?B?aktYSjZvZFpjQkdWVmkzUjB5VzhVWThwUlRCaGs0MUtNeGlvQ1V2VDhCa1Bv?=
 =?utf-8?B?MlRJbzdHbVNXM1BHczhESzBiSW9KbGszRTlRcTVxUEh5QjZvY1RGK2xmVmRI?=
 =?utf-8?B?ZGlENGprTlQ1U2F0Z01EUXpkeUpac0ljM0V0U1ozM3Iyb0NOQlZBUlBIQXJV?=
 =?utf-8?B?NUUxOTRpblR5ZEpzSzNqWG5ZcVRIS0VSMXUvQ0ZFT0hFTWFBVGpWMzVKT3Ew?=
 =?utf-8?B?V0xMY0s2aitnWE9va25UNWhDY2dDVjZVT3pxeURNQ3JxV0ZRaHNTVDhzMFI0?=
 =?utf-8?B?NDhmNmpDc1A4blVzVUFBSEJ4QTdTQ1lSZ2RDZkhBOFFRdzllYXEzd1BjTjdU?=
 =?utf-8?B?L1ZjY2JkRmN0ejMxeFR4R1ZPTmlRWFRRNXBuT09XQWg3b0p3NElaTGhLTGNo?=
 =?utf-8?B?SkxYbm80Rks5QW40QnR3Q1RxM1BrK0JKWWgwV3JnbzRWTWxuc3FiS0JlUlFY?=
 =?utf-8?B?Vm4rb0tocEhEaDFWNjA1WElSOGtFczNKUURCRWJORm9tdm5zVkJJMVBRK1NW?=
 =?utf-8?B?RjBJa3ArcmpIY3R2b3hURzE4aHowR0NHRW1JWTZzNjBEeHdJWkZLOGMwYllI?=
 =?utf-8?B?ZjI1R240aVByY3dKcjFGc1liZ3RKWEQ5cDZ3NGxsbW81eDNBYkJoK08wMUQ1?=
 =?utf-8?B?NDZEZlhHbVRLdzRLN1JEUkZaaTB3dVdhYkxlejBuZmJJWFN0MFUwUDU4aWQ2?=
 =?utf-8?B?NngyRG1kL3FjUXBBSUU2OUt5NkhRMTJqVnpRTzJMc0FyM2dhYkZNelBPMjRo?=
 =?utf-8?B?RUtXZVpFbkwyN0tpQlAwUkhqM0pBUkYwWFFZVWo2bkJBQ2l2VWVVN2V1VXNz?=
 =?utf-8?B?L3MyMUw3ZHdwOEt0Z3pnYXJFYmUyUG5lTGpqUTdoVE44SEdxM3RRRTlHUHVw?=
 =?utf-8?B?UzRBdjlXdnk0ZFN2c0h5ekxRNkdxc3NLSVMxRGtHZXdVc1NBMlJ0dElLRWw2?=
 =?utf-8?B?eDRhbkd5YWpPZGowR09lbnFIWUp2dDczTjl2clFQc043TkVwOU0rb0kyNllX?=
 =?utf-8?B?eExzWC9MN2ZtNXV4UUlNV0tmWHlaL1I5VTdQRlJNWlc3ek1zVzlMOTNzZXR2?=
 =?utf-8?B?d0s5QXNmVVRKMUQyVU1GaHNJVjVINXAyNWE1aEFjUFBiWUtVbFRiRFJnZEZy?=
 =?utf-8?B?cFN0dmhrSytIUTEvZy81VUZMSVZHVVZNNUd2U0YyT2RMYVl0cHVvSXhBa2p3?=
 =?utf-8?B?SlZwT0Q0bTdEczV4ZnpWU1FCcHFkRC9HSGFaWm1hVEp3Y3hKRGpRVXdJZit3?=
 =?utf-8?B?YUFBZzJUMG00dEdKSU9ERm1TTUtUQmxRcHJvMldyWjlxRW02N3VBWlR5a1Ft?=
 =?utf-8?B?S1FicCt5Z1FjaVhFZ05QTGZ1ZWdMY3BBeG13R3VxZk9RcW1IY0lDcVVCUnUx?=
 =?utf-8?Q?d7LBqJtNUusNEvSPEB1W/nRiYYoc5Diu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amZ3dVlRT3JkdHhQWkVURTRjdVk1SW03TDNXS0c4YksreVpUMTVhaXFQbm1V?=
 =?utf-8?B?MlIyVmZocGJ0RTh4K25BOGJDaG5JUjJuTVhLQWRvK1Z0eTZydDlCS1dmNXZq?=
 =?utf-8?B?bDhuUDlHS3dqc3FQU2lYdmNoMHlkazFnSlphNjFWQjY1MmQvd3dVaWhObW8z?=
 =?utf-8?B?N1hDT0RGZHJmeGh6MTFiMlBlSk1FUDN4RlkvMElWK0tTRmF0dVBjcUpFekNR?=
 =?utf-8?B?bnF4QlJScUdsK2RDakdKZTVKNGNkdFRhczNtQSszS2hPbzQxV1FxQXFHc1hB?=
 =?utf-8?B?eFI2QjRrZmFNT0d0cDFRM3VOelR2WS8xY2UvSWEvZlZaZ3ZhZEhwdzV6QWhn?=
 =?utf-8?B?WVYyMkdnb09ZRHZlU2JVM3JYcU9oZ0hFMDNwaHAwWWxNVUhWNHl5OFd0NG9q?=
 =?utf-8?B?cmhWeWFKNHdWc01CYU1tb29zeHhhNGd1dk5OQ1ZIU1FWdW5Da0cyZjl6Wi9n?=
 =?utf-8?B?VkhIeWdOMFMyYVpNc0tPOWhyYjhHMXl6Z2JpRmtGVkRFRU9LYWZOY01oWE95?=
 =?utf-8?B?OW1xZEEzK0NWeFhnSXhIL3JSRC8xbFdHcmNIcW1LQm9yUzFQYnNKeXFtdkpr?=
 =?utf-8?B?V0FBZ054a0xnWEtTYnRWcTNGV0V3NkRUU1FES2FpMHQ5UG02aUFYNi9peWxY?=
 =?utf-8?B?ZFZoaFBNT0Q1SGpYaDQ2VGYzMlJtZCtEaW4rT05IZDBJalU5NHJXOFJCTEZU?=
 =?utf-8?B?Tm5jRnkwR0ovczBUY0FoOTB4TEN0YkRtMWFkbllGeUZEQkJISGdiQ1pFZHgw?=
 =?utf-8?B?Z3BDVlF3TVlXeG95ZitLRGR1VnhjZG9ib1h6Y2pZQll1ZHJueWZ6TmFTK1d0?=
 =?utf-8?B?cmpqaDU1d2gyQWRoaGJRZXNUVWc4N3p1S2pWK1h6TDZBdDVIN1FiU09zMTZy?=
 =?utf-8?B?eXFXVWs1S0V4RTBxbzVPUFRTRDBTN0dnK3R1ME1aNXNmTlV1dit0OEkwWnFB?=
 =?utf-8?B?Qkp5OXhFYWZJOWRybldMNEx4cmxrZWFIWFJlNTd3ZkNGUk1lelBWWHVqc05y?=
 =?utf-8?B?dTd2N0tNZlpiRlFPM0ZpRU9JRExrSHhmQkdsOEYvbVF3VWxLb2llL1NZZ1la?=
 =?utf-8?B?U0dUZ2t1bE1wR1dHVlIwd05ZWTBXQXlRL0NIZlIzaC9YUlUrU1oxbTVqZ05k?=
 =?utf-8?B?OVkzR2Y3L1dIWm1Yd1U0ZnJ4ZEsrTFBrWVF6bmdWdmpqZnpCTzVnZDNqbWNt?=
 =?utf-8?B?MEdnaEhKb3lpZDhjQnBSQlhqdjA0R0V6dHRCQXd2bC9PMysxWnRRQ1hXMjBE?=
 =?utf-8?B?aGRVaFNrMDJscFE1TU5PV1hSZVNwbGJhSkNQeSs4dmpNSUhSeTNYem42Tkw0?=
 =?utf-8?B?YS92Znh1dmpZTGFtSzgzV2tWeDI4NE9RK1dNdTMra3huVXNTMElpT0hjTk1k?=
 =?utf-8?B?Q01CTlZDWUhGT2dMeXJIeXhKSGJJYzl0UDZJdzd3WmZvanhsenk0NlBtS3h4?=
 =?utf-8?B?OHFJM2xqeENtUG9xb2J6TmMvUUlyYzlwR2d3NnpLWUU4Wk42TTVrUTRoWExC?=
 =?utf-8?B?ZFNJNTNOWkdJa3FRekxHMFdDWklwY0RaT2prYzNEVDFxOWROREdtMVQ1ZUhQ?=
 =?utf-8?B?M2lYYW8ya1VXNE9yZTdOdlAyUU1JcVBNZXVTbjZ4UlZNSXZnT3JvcEdMSFV1?=
 =?utf-8?B?M2thUFJFQ0JDMjY0SXFjR28yQWo4eEF4a0VubmdnZU9SYkVTMVl2ZXJ6TmdR?=
 =?utf-8?B?UFM5b3IwUERtMFh1THdWdFRJSmVNa0RJM1RtblpwakpVcGFBS1NmM2pXYzBz?=
 =?utf-8?B?UWFkcjloaTl5V3ZDMEhTMUlEU0VxeG8vZEJUN1VwdE1Cd3NlcFEwUWpXODRQ?=
 =?utf-8?B?dFB3bmx5RVJ4TDM4U0RCOWdKR0lBM05CL1Q4UWVzbG4xRUg2QkhWZjVhbCs4?=
 =?utf-8?B?ODRNTTVCdUlGWlZiRTlmNUx2NHdqS0ltOUdWajJoQWNiS0NsYk8wNHloN3B2?=
 =?utf-8?B?djhJcmpGelM3Y1Z6REZWR0pMRjcyMlJlbWIzQ3hXNjFZeE5kclBYbVF4QlZn?=
 =?utf-8?B?WHh2MlR6UWdrSFZTQWZNMk0zakFPbEs3eEo1SURlMFlxSm5WNXAxb0N4YWhP?=
 =?utf-8?B?SE1VQlU4L3FablVLSE5iZGZEUFZOanFwODZ1Y1ZFRHcrUTV5Y3lEdVpXNUFD?=
 =?utf-8?Q?MqQivkAI31mg3CWZ8Qjb/MYMZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba02b67-3713-4d07-031e-08de2caf7876
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 05:48:48.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWfTgcRuxkl/ujEhJOtVgt6s5KLVatBRWZQECnXnGjTxMDA1YIuA6vykVxUDR65JaqvC/AjTDSuRfiZfVFOUaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117

On 11/24/25 3:51 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:15:20PM -0600, Daniel Jurgens wrote:
>> Add support for IP_USER type rules from ethtool.
>>
>> Example:
>> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
>> Added rule with ID 1
>>
>> The example rule will drop packets with the source IP specified.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>> v4:
>>     - Fixed bug in protocol check of parse_ip4
>>     - (u8 *) to (void *) casting.
>>     - Alignment issues.
>>
>> v12
>>     - refactor calculate_flow_sizes to remove goto. MST
>>     - refactor build_and_insert to remove goto validate. MST
>>     - Move parse_ip4 l3_mask check to TCP/UDP patch. MST
>>     - Check saddr/daddr mask before copying in parse_ip4. MST
>>     - Remove tos check in setup_ip_key_mask.
> 
> So if user attempts to set a filter by tos now, what blocks it?
> because parse_ip4 seems to ignore it ...
> 
Added it to validate_ipv4_mask.

