Return-Path: <netdev+bounces-120372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A279590E1
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6590B1C21161
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED351C6880;
	Tue, 20 Aug 2024 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i6yljDm9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QjR8Yyt/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23718C906
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195166; cv=fail; b=q3tGR/weh4+xdTkZmpK+V2wTzpF9R+cxD3rttX+q0HxxIFE2QRhQX5F8JngtWEBVX350AfWKUNW7zcNFLVs7SJgHhEKR01if7FC5ondYhg9gXb3dElp5MkmhJqWNlX4KPBsljGe7vUIm9JYOKgg9qdgQ8UgwpYCGUrMQhPxfnSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195166; c=relaxed/simple;
	bh=ohlX/3bi3KZJCzt1DLCl+H5WHcZ54/wFqjuq5oKM/Zs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HKi9XcHPBCoAGw+C4vreGJhnaWEfBoUaot8TDPBeeeptnJM9j7ULBuPve7cdzwADJjXwBT4qEzYDleZD+iDb2Q5Q2oYlq960fm5qc9b2SX6D+CpQRJBc7GTmXv9lm5kV9Emg1GwryRIgoaID8KJm/xXpW7NGssNgSj0ZcaTDwJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i6yljDm9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QjR8Yyt/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBWLF020404;
	Tue, 20 Aug 2024 23:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=J2x1sj6vWuW0MOQDcAG0JeHJ3eZwaZsxamQGcwUu2Jk=; b=
	i6yljDm9qjqfyTKd21qfg12T96zj5aJ9vZHbSuGY7olGOKYbAy8o5PcOfi2HXQCK
	0p2ygoSdRdLELEwQm6eu5XOvYbr94jCJajoiOAcU8Mcgh1y8duBig3FRNToPrOxP
	9M+Xb6+y58wVpqcwo97r+ZTTFn7yZAB0+4bXwHVYPuDtowiqdGgbCJtnRofV+dGN
	AUiyOIXMCNETshQeO1hedSKKW7MKNCF2RLhne7rd0NSnO0fwYQJGZHPTbh8O0W7Y
	/6ch6q79IDZl8Y42bLe8iQ86D5MzI9O5h1Ee4GHza6sYwEVrKenB0TCgs+BUASZM
	k7Q6oMKLZ2hqkIVvOR7ecw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gebp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:05:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMJJXE040037;
	Tue, 20 Aug 2024 23:05:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4153u2s5h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEGoR0naV2cK/Vl1s0mLwahDuCWd3QNVVolEO+zYHZMljn6q1CIRJIPxwhRs+9ACsHaOSNbBXpFPoJmGs30ptrWy44ra1XkFNzKeMYlZrgAyhPtPFOQyqM9CiodINpvSaOXgwvyen19jjGVzzCryfS3ao1gJAH2xEG0A0Yl9fobjTG7r1s0tHDyzkyGCr4EcbMFb1/jsN3CV4bVfMEO/g8Sv/4FcSwMb+oWupdv4qSH7mLiNpbGuNh2kwxX/cdnHR+vZHP4p+Zy/XWgwGZPPiQ5J6lVfiRAnEjp87aR1RF2NfhaY8H/RbtNcpR2yVjZ67HRdkLwy87RtKaguKLVh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2x1sj6vWuW0MOQDcAG0JeHJ3eZwaZsxamQGcwUu2Jk=;
 b=g85SiQNMKqL4AT8vxwbGBIUisD0j+CYVGnz5C2axbwtmXPabRQEJQwhYyOSfYn27hwOBiY62j3AxJ/tGuZlFUw7mROHpRbVk0DlD4+vGR2HsRqRy3e52mDbQhw1MeVWYFR8t8ef++8pwlp+JkLNzKOy+NQqVwksM8qj8ulXH2uQkwMBOlnzBS1/7eK+u8P+uBS2YCkiwgnC6Bzkk5JatdcdzhKUQXBi1OueGp1axEultUNSy7nNK21YVZ4RBsu+yfdpsGbW8xE2y9mP+rzXIc7x3zi+gOUemOwjmiVZe4m+6kx843iVrk8Zeb+BRoSFFBFK12h80Pt/1cgaTO2KjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2x1sj6vWuW0MOQDcAG0JeHJ3eZwaZsxamQGcwUu2Jk=;
 b=QjR8Yyt/LPaiLQSALwg/JSoA0YZlhiOl6VME583yURBU6Lm1OyqoNC+sTNoboqV4nCzVUh4Q4mnya/1244y3eYaN5zsGjUMH6Cngp4dSi5axroQsx4wZtgqC26LSh3tzYwV8JvVNF2uAZActj6GBUFyeqLDA2pvz3S+gl6/M3uQ=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH3PR10MB7930.namprd10.prod.outlook.com (2603:10b6:610:1c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 23:05:37 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%3]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 23:05:37 +0000
Message-ID: <226a629f-d2fb-2969-b210-072262984c54@oracle.com>
Date: Tue, 20 Aug 2024 16:05:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux.dev, Darren Kenny <darren.kenny@oracle.com>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <4df66dea-ee7d-640d-0e25-5e27a5ec8899@oracle.com>
 <20240820160342-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240820160342-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0881.namprd03.prod.outlook.com
 (2603:10b6:408:13c::16) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH3PR10MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 558069f1-b84e-4206-fabf-08dcc16c9a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjlEdW12YStJdzJ6RklDU3hnNWhQdy9KUkVZZWVKdER3aTlNWWZkczF0UDZV?=
 =?utf-8?B?TGExOVh4allmL1A5Wm11ajFJYnNCYkthOEdaZVdzQzl2dkxrMjVGd3RMc3ov?=
 =?utf-8?B?Mk5LcEZtY0lVZjlBZFpOSFM2cFBjbkxsRE9xcmpTQjZPSElXc2xPbXhySFcz?=
 =?utf-8?B?UytDVFQzcVNsVzJrUFJjTXpXMG9vQW5zMy82Q1dmRWQ3MlAva3VxYVVRNXlv?=
 =?utf-8?B?WDEwdTlXTTVnVXBpd0JjVjRIemN0RW5FalpaQkNZRU1OZ1ZVZUFzdEw3VXVl?=
 =?utf-8?B?RHgyRzhoWUFweFBQU1IzcmliRjcxSWJJbUI5aGZhdXo3MndpK2hFY0FKb0ov?=
 =?utf-8?B?dUNDYVVsWWduVHJNZCtLQTRBeFR5djdqUDFDS2syM1lKQ1NRZHNnaTh3aTdJ?=
 =?utf-8?B?UzhFdHl1NnZ3a0RIRmg5VmVQbjdmVFZCQitUVUd4QzltNzlnU0IxN04zWWhp?=
 =?utf-8?B?czJDemlkOWxPM3pUZ3E3VkduRlZIbnlrb2ZnaG1NZFd6a2JpZ3dYSUtxdWp3?=
 =?utf-8?B?MmdndGlsWVNkK1BPQVV1U2dRTk9TOFpnUDV5emZxZ3FnTTNnUndnUjg2Y0U0?=
 =?utf-8?B?aU5zcFo3ZC9yZStndzI1RjhNVkVpdGlXTUIzYStkWkRNczNnR2VLcHA4eGgv?=
 =?utf-8?B?Z0tlK3EwQ1g5dVNXdGdlUUxvYXd1TlUvR3B6Y3Z1bmxwVnJNQXIxRlZVRUlo?=
 =?utf-8?B?bG9ENmpodTN1ZUhSTkZRdlVZZDlveXEra25QZ2FrSzY1VjBkeWZqM0ZxMFBP?=
 =?utf-8?B?a1ZsZ3hNZnVZQzJZeEh1WkRyNEVTZ3h0TnVEYVdBR2ptb0FwNDhpdnRLT1li?=
 =?utf-8?B?YWwzWHI1aUl4ektYd2NkOHRldGc1YmtHWEwyR1B1bzRyN25adEFVdUc0d3Zm?=
 =?utf-8?B?YnhBS1k2MjI3RVZqdWFiS0ZNYnE5NENJUzlYMlM1eWZjL3N4eEZGcFdVYXlz?=
 =?utf-8?B?ZXZrRDd5Zk1kcDRrWjZKZ1FoQ3NVK2N3NVNNQUF6WmlSOWk5QUxVWHlPVG5u?=
 =?utf-8?B?RGJxeFpSRGpvUEkwTEh5TVlaUGlZNmNBUTdaZ1g1WTA2MWNPZnRYMGNXNnla?=
 =?utf-8?B?eHRRTDZJdlFyUjJWZkd0anAvajR2RU5KbWRMdTRIVmU3Rys0RWNmTCtMUnZ4?=
 =?utf-8?B?c21weDdSOGpDU3JEMU82QVl6Sk5JcGhJZmc0YTJwcmNVUHdPZndwSGxIUkU5?=
 =?utf-8?B?eDlpVmxhS0docml2WTM4Wk5jUFVOUEljMnpzZFVKTDZBZ2pBSThlWGZpOHVk?=
 =?utf-8?B?QURJbVE5ektsRUxYL05Gc0hEeDRWV24zMGEwTjV2K21udFB2ckRnS21Dd1hq?=
 =?utf-8?B?NllDQTk3elRJb29VWjZ0ZVdRcmdHaWVKcnN2ZHZEemREZmQyajhtUEtiSHVk?=
 =?utf-8?B?NlFYTEtYRk9IWkJPQ29jSHJIY0ZoUkc1cVdCbjR1TTdURWt5U2E5UEptRDMy?=
 =?utf-8?B?ZFFYMzY4YUZmSmpTZEZWQ2RRcVU3RUJWcWxQVEIyYkJUS1IxeUpJNHg5TUc3?=
 =?utf-8?B?UXJWTm5BbWFsc2VIejRwSHp1ZzRlT3lDUWE3QjQwQ1o1OXBxdFp4ZTJBTEZ3?=
 =?utf-8?B?RjZ2WDV1VVAyNlRKMVd1Q3F4WGdBM1UxQUpxZkNOVlFpeTRwMzZpd2lUQjRK?=
 =?utf-8?B?Z1J4YjNpaGNXV1p4VDlDY0RvK1RodExndzhjQy9sa1Ara2xlT0g3b2FYUkly?=
 =?utf-8?B?bm00QzdJak1iMm12SFJSYS9ieDZJUmZmUmJxUlZMVW9QMFE4cDVnWStiUDRQ?=
 =?utf-8?Q?gfiNmFlcdxAHxv7yNY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTZvZTFWdnlESDhSUVZQemkzNUxvQWNYUm5VZ2tZeXhLRitMNlNFOXQrUlA0?=
 =?utf-8?B?YkxHeVdQbU1DalhyR09jczQrWVdBZXo5UHBMNVVCT1c1eGFGRnhXaTBpd2VM?=
 =?utf-8?B?S3lJamdac3pQa21rSzljZnFDRHp6N0RURHFZMlJaeE8zNmE0bVBBcVJMc1hu?=
 =?utf-8?B?V1hMd3B3SzdROXdkQWxOZkl4T29RVVcxVGJWTFM2UTg5bXlaamcwVWZaMThB?=
 =?utf-8?B?Yk55UFlxbGwrczNuMUpaazNCZTdGUGtRMk1WNW5kcDhqUG9hMmZlVXRiY1JI?=
 =?utf-8?B?Q3ZlbHQwdmN1V1JvdVJXREV2SFZvK2ZiMW8wV2VZaGwybXNFejU5cW1Ua2hl?=
 =?utf-8?B?UU53eUM2UFhXaG1XdjgwTnUyME02ZVJ0bGF1OWhrTktGNkFhU1gvQkREdjV5?=
 =?utf-8?B?ZHpZRklNUlY2SEtiekMzdmlucUpSTnd2TXJycVJ2MVh2a2JPVHY4YjhTZjc0?=
 =?utf-8?B?VlJGV0lrZ0pyci85UTNDK0dwSlFwaG00SlRETVBaY1dJTnY2TlEraHR4QklE?=
 =?utf-8?B?YkNONmhFSDlMZE1ySVZBclYvUXVaQnJFZkJ1dm83ZFVpQWxSY3B6MVpnSnlE?=
 =?utf-8?B?VlRUZUZrRkt1QWNpbVFlbkJvVURLeEhLRUQrKzFpZEpabWRVbyt2TnRVTFRE?=
 =?utf-8?B?WXNkcHVhc1FzeFJpNytCTFc0Nyt2clFUWC9KQVMrWjd3Y0lXOVFicTFpU28w?=
 =?utf-8?B?am9ZMlpxejNTM1RFZlRBVFpoZlJodnZrZG0yVjRWUENPanplTFdnQWJzUVFu?=
 =?utf-8?B?QnFCTkx4bjZLSDFES0NSd0NqSXc4ZERmQklYSmo2UHhoZEs5aU5ZS29NWmtq?=
 =?utf-8?B?ZS91UVAxNU41YkVWa3Y0STZRWGorUzVSUTVYeWhaK0cwQU5ma2VVWFFhTzAw?=
 =?utf-8?B?NThXWlNlSlhuZVU3aFZ1Q0NTY1JzMXg2K1NIUUFmTjVKNStMeHFnOU9Pcm96?=
 =?utf-8?B?OEtFamlSSW5Xaks2bzBSS0E5bUQrbmRReGswZEFVcGVDUUkzdklXYmtBK3RX?=
 =?utf-8?B?Q210L1lJTW5lbXFNQ3FpZmlVT09FeFBEWGlFVTRpRG5CWGhGNmxFMmRlckY4?=
 =?utf-8?B?YmFrOWpKOVNOaFk3ZlVHK0hwbGVjeUY3c3RScy8vS0c5TlkwV3A0dExBWlR4?=
 =?utf-8?B?Q001dW92dGFPTGQzMHVJMVpZd29PWDJBeElsN1IyM25LN1F4QUpVVjJBU3VE?=
 =?utf-8?B?N0s0Z0tuVm9weDM2YXFiT01kNFN0TUNmNkFPdEJHOFJsM3pZYjY3aU5STGhU?=
 =?utf-8?B?amxocHlDZk9XUG56Ty9ONkhybElNR3VobEJEWmp3Y2tSTGVGeWFuR0RlOW1m?=
 =?utf-8?B?cUc2RThNL2FUR3lnWE5LaGwyMnlkZzBxbnlrbmxxc2NaeUpDZ3RNb24zTCsw?=
 =?utf-8?B?ZHVmblZNbklSZXhjdWI3UDhucVkwOVBmT2xxY3VFVHdDY0YvQmd6T0NPQmNV?=
 =?utf-8?B?OE1JNGJpeGtLKzlORnNPSGlwbVBwOU9Zc0RiWEJyaUpuQlBrcGswT0dDMWo2?=
 =?utf-8?B?K1B1RE1SS2hUZVdZeEVIL3NscitWYzBKQ3hoVGJHQWRBUTZKOFBRL05iZlB4?=
 =?utf-8?B?TC9rSmI2WmJmRTJUTFg3YkN1SXVjNXdPMEJIbGlwVmtxRHpxM1VRaWhPajRT?=
 =?utf-8?B?d290eWdVaE5BMXRMZVg4Y1pzcFdLT2FndTUvMVpQVG9jVG9nTkdRZVFtb3BX?=
 =?utf-8?B?aWRCY1VqY1p5T3B1NUkxTmlEcFJnaXFFeDNvNThuai9YaWt4TGNXQVpVVmJQ?=
 =?utf-8?B?SnVTeWRDMlZDNUg3UjVGVE1qVG1wc3hmeEFlVTZxVmJzcXkrUU95YjcyQ3d0?=
 =?utf-8?B?cGFtY1A4SUlwcXVYR3I2cXovd0xWUkN1UWhmRnF5U2ZLQ0NBVHVnb3Z5cW11?=
 =?utf-8?B?SkpWM1dwV0JTaXpvMGFHWHBudjlRNndOQy90Tld1dktLN2xVSEUraU14MEpv?=
 =?utf-8?B?UndhSHRzbkNXOHJpQWZDcjFIWUQ2OFBMcFV0VzJYZlNXVXJJcjdiQncvdzlv?=
 =?utf-8?B?MUZON2pFSVlHeHJOdFZic2JjakU1eFpqaEI2Nm1IOTRzL0dXa0IzTy9OYnhX?=
 =?utf-8?B?TGIyb3doekMrT3ZiQVJkK2J6NStSalExKzB3djZ3RnhaSGJZSXhYRk1OdDQ1?=
 =?utf-8?Q?wHgOYd9nIB9AtRYCWmHo87vRV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mJwyg14cr6ozCwaC+J0Z+s54IkPUP4qsrGB4yARNWm7ccEBPsCozIJcB0vBEWdlHpfSOQ+zg9gx0a08dvkNr4Ok8Jxfu9OlmGF/i7UhUmJeW+ZJzfl8AjCzgCTMqJKCLDz3EkGTr9hH5mHpGWq0FETHMn/v/aH3dXdwDdZaVeQIh6Q7y9qTg1F71Bntj9Dr4cMf1nOaOzymc/bwdFpUFPGijhWnlzhO4t/BV3AFQQcewhmbSN5yoECq7Z76HWWZAc84vRmfFGY2p0+bb+bqW+JXR5aT41qGQnX6T4BuYlDOXLDpnGEfoT2H4q0YZ6l3T88cbgJj536Q0r/fydUKpNegV6bMkLo4NFqmZgwnJmVDm0iJLQPTiATbIIk6dZe+yqzIUb4zaRo/15phhbBv3HHfx01Ro/imcKAyogI7yeU0nJm6/LafEi5r/pVlsnSXm3IdqagXQ5kXkvOthTXyZDMOHTqJFNdLCZVQqWvKhZIHicpM+rz/SDNsj/XjNTW/0WrOgTuRkoj93oZpqrJWGg0PE1WozoYmlb3+IBaWn7Tl7rF4bPwndWMHFbmwyFRAqee6G7JGuy7i87kC6CO0U1c7xglRXnVJ0aFAzwJNvIys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558069f1-b84e-4206-fabf-08dcc16c9a39
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:05:37.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xJQzIO+PlHmMBWMutj65yE31sSmSWM1R4d4SGCZpf+H7N/XE/JkU4cjzmKjXFEP4utKyT4mvI+jxONoMFQ2Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_17,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200169
X-Proofpoint-ORIG-GUID: FAu53nvVaV9OPqCyQnpixgCYWibEa1jv
X-Proofpoint-GUID: FAu53nvVaV9OPqCyQnpixgCYWibEa1jv



On 8/20/2024 1:09 PM, Michael S. Tsirkin wrote:
> On Tue, Aug 20, 2024 at 12:44:46PM -0700, Si-Wei Liu wrote:
>>
>> On 8/20/2024 12:19 AM, Xuan Zhuo wrote:
>>> leads to regression on VM with the sysctl value of:
>>>
>>> - net.core.high_order_alloc_disable=1
>>>
>>> which could see reliable crashes or scp failure (scp a file 100M in size
>>> to VM):
>>>
>>> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
>>> of a new frag. When the frag size is larger than PAGE_SIZE,
>>> everything is fine. However, if the frag is only one page and the
>>> total size of the buffer and virtnet_rq_dma is larger than one page, an
>>> overflow may occur. In this case, if an overflow is possible, I adjust
>>> the buffer size. If net.core.high_order_alloc_disable=1, the maximum
>>> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
>>> the first buffer of the frag is affected.
>>>
>>> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
>>> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
>>> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> ---
>>>    drivers/net/virtio_net.c | 12 +++++++++---
>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index c6af18948092..e5286a6da863 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>>>    	void *buf, *head;
>>>    	dma_addr_t addr;
>>> -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
>>> -		return NULL;
>>> -
>>>    	head = page_address(alloc_frag->page);
>>>    	dma = head;
>>> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>>    	len = SKB_DATA_ALIGN(len) +
>>>    	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>> +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>>> +		return -ENOMEM;
>>> +
>> Do you want to document the assumption that small packet case won't end up
>> crossing the page frag boundary unlike the mergeable case? Add a comment
>> block to explain or a WARN_ON() check against potential overflow would work
>> with me.
>>
>>>    	buf = virtnet_rq_alloc(rq, len, gfp);
>>>    	if (unlikely(!buf))
>>>    		return -ENOMEM;
>>> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>>    	 */
>>>    	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>> +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>>> +		return -ENOMEM;
>>> +
>>> +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
>>> +		len -= sizeof(struct virtnet_rq_dma);
>>> +
>> This could address my previous concern for possibly regressing every buffer
>> size for the mergeable case, thanks. Though I still don't get why carving up
>> a small chunk from page_frag for storing the virtnet_rq_dma metadata, this
>> would cause perf regression on certain MTU size
> 4Kbyte MTU exactly?
Close to that, excluding all headers upfront (depending on virtio 
features and header layout). The size of struct virtnet_rq_dma is now 16 
bytes, this could lead to performance impact on roughly: 16 / 4096 = 0.4 
% across all MTU sizes, more obviously to be seen with order-0 page 
allocations.

-Siwei

>
>> that happens to end up with
>> one more base page (and an extra descriptor as well) to be allocated
>> compared to the previous code without the extra virtnet_rq_dma content. How
>> hard would it be to allocate a dedicated struct to store the related
>> information without affecting the (size of) datapath pages?
>>
>> FWIW, out of the code review perspective, I've looked up the past
>> conversations but didn't see comprehensive benchmark was done before
>> removing the old code and making premap the sole default mode. Granted this
>> would reduce the footprint of additional code and the associated maintaining
>> cost immediately, but I would assume at least there should have been
>> thorough performance runs upfront to guarantee no regression is seen with
>> every possible use case, or the negative effect is comparatively negligible
>> even though there's slight regression in some limited case. If that kind of
>> perf measurement hadn't been done before getting accepted/merged, I think at
>> least it should allow both modes to coexist for a while such that every user
>> could gauge the performance effect.
>>
>> Thanks,
>> -Siwei
>>
>>>    	buf = virtnet_rq_alloc(rq, len + room, gfp);
>>>    	if (unlikely(!buf))
>>>    		return -ENOMEM;


