Return-Path: <netdev+bounces-239845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5D6C6D065
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8D1734FF14
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1172F31ED7E;
	Wed, 19 Nov 2025 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XbWyOJGh"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2523817E
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535825; cv=fail; b=g8J9U+i4q6MoCRP0ExWdZf/PScxrsWVc/U9mRTpx3u34eoUzr6RbkcHYr3ILCi8HHrx6i5qqsb6ZqL4PclDIxgzEA5szZ78DDG2T35npGaebyrm4vMiEHD19pDiSM9I+WVreCE2apAa1XxrcIaCgK+bWosE0fKfVA3EiOFTMnFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535825; c=relaxed/simple;
	bh=RLs4foiYa9DYN087xqzIIHjnB2yPTU7nlePBMjGuDdA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PXz+Z5ipu9zTYMOjdAotWdjakAMs4UKuYDttFIyKFEgGSMvnrxABBgqVArSqsDYqlKJ050LRZvb6CXHTX6WC0WutxQTSLj3JnVktHRj5MiqWfe6uvIdfo4UefOlHfTlOeGjrgSxuE0AMKzqUIQ585/S3OKKeFh9FylIze8KzTD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XbWyOJGh; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3gSJ8Lr48unfcHQfqOWlagVSqF7SjZhdr8wAaPCLyC2wpHAl3sLC45iucK5jQHnknw4t0OfUsw5lqkYfdDumjw37dqU/dP4tGytsWAOxDi5Ekfwe9OcdAsxcYqk1lXENqdq8vWZl2zx8rIlUOVLjb7N2EKTTc+kLuG2i/poQONORos6KB88Mzq59Xo/nw9yX5TbScbcB6HqbsCzvzhTCKKZ9h4VQx7vVXCt9hhyYruIv3WmgzrPxZ5qqfeOfFV6MasUSZN4k8tQ/8nPZq321RibZ4phUEFXSetTzlnjqPypAEU4wv6aBJ99rTa7nKYUZFPbOG6Cl4mhEdJMTrkNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYCg+s2fthoeb+D6kL9OI39mJkV/UxN+S2tqNj3p13U=;
 b=jbzdMWRFn49uCipg3Vwq3N+h2QQqjfUanqKwPge9fyVQL6zysue++mPb3EE3KOtd8/IzngMRWO8vyfrXaEF0jw1wjSsXx1XKp5iyBvWcE5o2r1zTLhYn7LbkqREPZ9MPRh3vlMwz4Bs1i6kvs9iZmA5wruvYUVgzwIHaTbfVE3nrLC4B7NXOGbw+JDEGrOcTDIIQq121Av+81VB21d+GvhI0/JlyLjlqOaxasX1k96cabfK4p0FqMZegYvoC9mT5A6KMK7b6EMm2L68WeIMhn6b8wCoZl5zPdDsCgKv1bOB4U8T2JtJFTghh4oIow12IRBxixCbYMJ/gTRC0+m8a/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYCg+s2fthoeb+D6kL9OI39mJkV/UxN+S2tqNj3p13U=;
 b=XbWyOJGhZLBM0GQdyGn9+zG5kV1ei9DPMnB/PRoOV6LWTXV7fU9nCKq3HJEe6qGKcvO0DXzmyM9WFfVK2RbbZzCe1dZHTg9qiU1T/jS7/hihKwWkH2Don4+kJReQyd6vInApsKAiA1OUTX+SqMRivDDEzp9ybnDI4+UTSecsOojX0i7YbkTEOQNyXvIMcOaLNVqHn1Xi2ij8+ZdaR+jvGG77WxL1yZ6aXxqiGDZF+ktzEF1wxWyxPHJhxLcCgk0/6CqrzFiFYau79koGmH9ERbnYjxQK547W9EXpw9NCNmanmMeFWibeuTBV6fGFU38u20ktcDwV6KxexboGouKhsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 07:03:40 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 07:03:39 +0000
Message-ID: <d2b57943-0991-4823-9997-2bd6044c7abc@nvidia.com>
Date: Wed, 19 Nov 2025 01:03:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251118161734-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:806:d1::12) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f04ba2-b026-4d23-6758-08de2739c489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?by9MbkF2WXdSMThtZW9TTHRyLzIwTjluSTdJVnBHT2MxVU15QW5uTzJ1RVRU?=
 =?utf-8?B?emlwV3JDSEViY2ZFak80NzM4R2tvVkc4cjU3ZHJVc2hWY0FvdXZIWktKY0VV?=
 =?utf-8?B?L0pLTU5rZjZ1czdMZ2lPUThXZkI2eEdhTzdITEVpenFrVmhNeFRheGJZR0FG?=
 =?utf-8?B?NC8rZGM1Z01ZdFJPODRTSnZrS0FFa3dwRGl5NFJobVBlZlkzQlhkdmJZVmVH?=
 =?utf-8?B?U0dXalUxMzlyelZDNkJZbVRJSjc0dHBWdndiMkQ2TEEzL3V6TmlvVWpiVHBU?=
 =?utf-8?B?RTFhTTBqY05HY2xUdGxZd09MTytuSHhDZU93T2NmeHl0S1hxQmhZZzZweXFK?=
 =?utf-8?B?ZVRoVC9FUFlLTHFNRzZxdDIwTld1UktNNThQWFF5N0NBdnQyZldEaWZzOGgz?=
 =?utf-8?B?ZnovODVvdmRHd3BSVzlsMmg1R2lzT0NiaVhlbWNvSDBLaW1EODIxTWQ3aVZs?=
 =?utf-8?B?TWxHbjIyc2FLVTdOUGlhanorRmhPVk9adDRmSDlCN0V6d1lXSHFiWTF2Q2ow?=
 =?utf-8?B?RzFOTW9wek1tamVJOFZCeVZDTkJiUGp2cjlUTmpuMDZoMDlGTzZiclY1QjFh?=
 =?utf-8?B?NTNSS3grdGdnVThuWm94djJiVk5mY1hGUHhERCt4WUtxazVYNW95eHhXUS9L?=
 =?utf-8?B?bTZDRVRuYk0raC9BSFROanRpeUhHZmtUN2YxZGZUS2lsRWVzQnJFUDJ4dS9S?=
 =?utf-8?B?UG54Mm5zQ3B4UHpraXM2dTNGOWhyelVXSmtsOEdKNU45cXNTTFpzOFRhbUw0?=
 =?utf-8?B?bzQ5TUxVa1QzVU11Y3U0T0tOK0Y2M1dkeWRJVm1QSU9YS08rMHE2RVl4b0pE?=
 =?utf-8?B?MEZVclZrbC9RRVRjN09raUF1bkcvQUNiN2U2dDkrMzczVWV5MFh2cEYzR1Bq?=
 =?utf-8?B?bDBiQnNQNTN1UDBxOXdGR2NWdjZsMTZyRnFrTlRld09rMGtaajBUZ0dRTytE?=
 =?utf-8?B?d2hQSStubmtIQjlYNCtnZFc5Q1ZiRCt5d0ZWTHNQL1E1Q2NGalV2eS9yYmNH?=
 =?utf-8?B?QjBVejRpUDdHQ2hzWnpERDEreFZlT2tIQ3F4ZWNtc2xIU09keEI0YW12V21I?=
 =?utf-8?B?cWZTRS9TRXI5YzA2cUdob3BvL1FqWi9IdUhZTDR4Nks3aXFING9hYWNxY1hs?=
 =?utf-8?B?UVcrd254WWxONzIySWd0K0tiSGhsUC9aVGZKTjBuY1pUUkVWUnk2MVJ2MXY4?=
 =?utf-8?B?ZTZzQ1piRS9ieHYxL2RwQzlqT3lTSTZGNktZTTdFSFFXMTI0VVUrMmRjSEJq?=
 =?utf-8?B?L3QyVjZXaGdjV2NPa0Vlam5QajJ0QnMyRS9nZ2lZZ2FCNldGSWtBRGJyYTJk?=
 =?utf-8?B?K0lNVzJFcmJ4aVpKTVlHUWw4ZjNIbXlLcmRoSWFBemU4Z1c2SVRFUno4cnBq?=
 =?utf-8?B?dk4wU3RVWkdhOWpEbUhrY1R0MTZQZFJvc25mV0lON1U3dDRmQ05WOU1OMENH?=
 =?utf-8?B?N3QwdEdTMEgxb3FRRkg0amdiOE9UejBIWXZvblRpdFMzQi80Vm50a05wYzVS?=
 =?utf-8?B?VFBOWDNrdmVGbHBSanpWbFZiYjlyZWVacFJOY2Myc3lPMUhmWFRtKzVTZWkw?=
 =?utf-8?B?Y0RveTlrbHVtNVFOMThtODlnaXV4dDFIUzFKV1diRzFheGhrakJmR04rVU9l?=
 =?utf-8?B?T3FGWTE0NS8wVDVnRE8yTC80OVpGQ2pKT0JTVFU0RkpCVGVCdDBPUDJLNjZt?=
 =?utf-8?B?aWd2U0ZTSjEwZkwvdGRSWFdTN25OdktvOWJhd2xRNlFFTnVRK2R1ZlJna2dW?=
 =?utf-8?B?T0lQdGVCTzIzZWc2bkhqYUZnY0tTRUx4eC83eHU2VTZLeExMYWFFRk9nOHpp?=
 =?utf-8?B?RWxNZ0ZqbitueXVlRkszNU9EMThpTHBpZWJpQW1pUTJzcEc0dTVLZENqNjEw?=
 =?utf-8?B?TE1xR0lzcFZMaHY2RDRvdFo0cjdUSzNoZ2I2YXdwUVFnRHo3VWNoWEZ0THo3?=
 =?utf-8?Q?cU4eyJpcFLj7O+6Dy4NSrvg754Zrdyfy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzRCSmtrNzN2eGszbEVoOVU4cjF1ODU3a1VXOHByYTI0K1RaRk9pdWFXK0hx?=
 =?utf-8?B?cDJ0RnpCVGNhZWV2WGp6UzRZY2p6VklQVGpiN2hLd1dmcVRLMTBWR2dlRGY1?=
 =?utf-8?B?SFBKd3dGYzh0WE4wVko0WnpvWkN6bDRXYkRRNXVwaVh2Q3BENzkyR2kwRHZz?=
 =?utf-8?B?WWoxalNvRmVNSG1zMGJRd3F2VlFva2IxWGpWRFhaTE55OERnR3ZvRENRSHJ3?=
 =?utf-8?B?VFRNQ3ZhbXQvYnEwZVV6NTZCRWQxTWZad2UxbHg4NzF1cFQwcXF3eHNjK2hF?=
 =?utf-8?B?UkJLSmNLcEdoa2tnSGh6OGR1UEphbVM1RDdrVk1RcGxhTTJqaWU2b2E1bEFs?=
 =?utf-8?B?YVFzekRjeUh6c1Erenl4TXMvQWU1NU1MQ2w3SjRSUVJLMXdqd2FxSkxFbFNt?=
 =?utf-8?B?aGUzYXZTSlcxSHdIL0hKdTUvZjBDNlovc3JJWkZNRFNJaTQ1MjE0Q0t1ZTda?=
 =?utf-8?B?c21EaG5EZWsvL3pXSFpGaHVKd0RmME41U292ZGlyYnlBOHNpNHErMFZVTlU5?=
 =?utf-8?B?M0Ixa1lyc1JxZVZZREVHSzY3MCttZWJHSTI2cEF4bEkvQmhRNVpMVjFuNm84?=
 =?utf-8?B?UkRwd01hNlhEMWhlMEVIbDJjZ1J2WVl2VTFuclo4RHpYdWhHQTY1UjJnNGFI?=
 =?utf-8?B?VXNoWC81NUQ2a3o4TjlBZFE5dWZkZCs4WUhXeHh1NWJweUJxZHJFZFlGeHBp?=
 =?utf-8?B?ZXZzOWJtTEJXd2ZoRmp3Y0R1eGJXNzZGWEdiVThyb2NXVEhyZFZodEh0MFN5?=
 =?utf-8?B?VVlqMTdTa0FBU2tUZ0cxYmY5cm5nTTZVVCt3d2NJem9udTV2RzQrdFlsK3Fy?=
 =?utf-8?B?Y3BFMTJOVjRGTCtpbE5OY1dhcWIvSk1lMlloZ3BFdms0MndQck43Z3FFc2M0?=
 =?utf-8?B?YldYd3dSczhXamZJMWRLMlZkSGc4Ync0NGp4WmJkRHlXMU01TWVJdDVoVUZj?=
 =?utf-8?B?TmxiL2JKTWREQ2FDdUcvWHk4QUlDT0JkVXpGc2RudE5mTmVuemM1UGM3RGlH?=
 =?utf-8?B?YjJYTHZuZlB2NUY2NkJPQ0dpaTc0S09IS2RTREpabkY4Skk0NmhNTk1NZlZs?=
 =?utf-8?B?cjFQa1E3bDJNVkdzY0o0eVpidE52b2J2Mncyb2JtT21nNVdqc3pQQnJtVTlH?=
 =?utf-8?B?ZFBPNG42UXpReFpNa29LNjRJUTRmK1NiaW9CbU5yMWorN1BYd3NnK0dNRFRY?=
 =?utf-8?B?bU4raTRQSEp0VzVPejMvWFp4YUdkZXBNRXhNQXczbXNqaHJNN3lzaWlYUlJu?=
 =?utf-8?B?TklKVDJaOEYrc0NsSnpLa3RrTFRLSmVSUXJtMEV6dndsNEN5ZGlIUnlTV3RJ?=
 =?utf-8?B?eDE3aHpPdlVIbVZWRXhOdndDb1Z5MFNnLy9BRXBVcTV2TXRKWkk4Z1Y1eEVm?=
 =?utf-8?B?S0hEYzNMMng2bzR4dFhoTUxHS21zUDhXZ0ZUV0lDeTZsZlBnQ0VQN0tvWm9P?=
 =?utf-8?B?MGtiVkZSNi9qRUY1SVJXU1VtSnVWU3RZT0s2eHlISWloSEFVQ1k1UnFIQWY5?=
 =?utf-8?B?VmtUS2tkNjlZMlh4WllYbzlHQ0dseTBpVk8rb2FmQWYwc2RLRkczZUdiUTU1?=
 =?utf-8?B?bG5qY1QrRXBxb2xxcmdwNFc3YjkreVlTeDREZG11M2hkZUdGSEhYcHI2V0lu?=
 =?utf-8?B?WXJOYURVeHplYi9LN2RTQnVpTUM3UVhRSjhHNDVISURQT2crZllVc2VNRVhE?=
 =?utf-8?B?aTI4eWsxamFDNWF5UlZRVTVqSGdIaDArdHJQdTNnNDdHczYva2FoS3FEV0V2?=
 =?utf-8?B?R1ZRMWttbnV5R2x6b0hXV1gyZVdoQ2dSL3dwOUd5Y0hjai92aXlTQTU3Um1H?=
 =?utf-8?B?c2x6NFJVS3pXUEgzNW5mVlZPSUluODhvU3BPeXB0UHVnYXc1VWdyYlhWZUFq?=
 =?utf-8?B?RTBsRnhUTkE4eFhVOXZteVhrckFFaXdrNDJwbWJyaG51Sk5tVEVHUUtjKzNv?=
 =?utf-8?B?ck8ycThRQ0I2U0J4Y1VJQ2ZzbnkrMTN5Vi8vWjVaQ2JwRGp6VWhINVdhOC9v?=
 =?utf-8?B?eHRLbklVK2tvTzVWNEllNGlYWVVObVZwMWV0eFZpaGhWMWJUTVYzK1hRNWRZ?=
 =?utf-8?B?Q2JveG12WFpLSk9sSlRzc1VGQTdWN3Z1MVN4UEg2OHFTcDFqcndJRWN1cEhn?=
 =?utf-8?Q?AjUz9ggFc8WaWYOc53g2cvTHZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f04ba2-b026-4d23-6758-08de2739c489
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 07:03:39.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUHpMYtgJbXx6QbXJgYWTwPB/hOpdUlHqd5CUC5FdAuGZ5tnkuOVA5ILX/kO4clMstjC6ovOq4HOebr1hXIJCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

On 11/18/25 3:31 PM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:38:59AM -0600, Daniel Jurgens wrote:
>> Add support for IP_USER type rules from ethtool.
>>
>> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>> +		      const struct ethtool_rx_flow_spec *fs)
>> +{
>> +	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
>> +	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
>> +
>> +	mask->saddr = l3_mask->ip4src;
>> +	mask->daddr = l3_mask->ip4dst;
>> +	key->saddr = l3_val->ip4src;
>> +	key->daddr = l3_val->ip4dst;
>> +
>> +	if (l3_mask->proto) {
> 
> you seem to check mask for proto here but the ethtool_usrip4_spec doc
> seems to say the mask for proto must be 0. 
> 
> 
> what gives?
> 

Then for user_ip flows ethtool should provide 0 as the mask, and based
on your comment below I'm verifying that.

I can move this hunk to the TCP/UDP patch if you prefer.

> 
>> +		mask->protocol = l3_mask->proto;
>> +		key->protocol = l3_val->proto;
>> +	}
>> +}

>> +	size_t size = sizeof(struct ethhdr);
>> +
>>  	*num_hdrs = 1;
>>  	*key_size = sizeof(struct ethhdr);
> 
> So *key_size  is assigned here ...
> 
>> +
>> +	if (fs->flow_type == ETHER_FLOW)
>> +		goto done;
>> +
>> +	++(*num_hdrs);
>> +	if (has_ipv4(fs->flow_type))
>> +		size += sizeof(struct iphdr);
>> +
> 
> ... never used
> 
>> +done:
>> +	*key_size = size;
> 
> and over-written here.
>
> 
> what is going on here, is that this is spaghetti code
> misusing goto for if instructions which obscures the flow.
>

> It should be if (fs->flow_type != ETHER_FLOW) {
> 
> 	... rest of code ...
> }
> 
> and then it will be clear doing *key_size = size once is enough.
>

Done

> 
>>  	/*

>> +
>> +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
>> +	    fs->h_u.usr_ip4_spec.tos ||
>> +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
>> +		return -EOPNOTSUPP;
> 
> So include/uapi/linux/ethtool.h says:
> 
>  * struct ethtool_usrip4_spec - general flow specification for IPv4
>  * @ip4src: Source host
>  * @ip4dst: Destination host
>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
>  * @tos: Type-of-service
>  * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
>  * @proto: Transport protocol number; mask must be 0
> 
> I guess this ETH_RX_NFC_IP4 check validates that userspace follows this
> documentation? But then shouldn't you check the mask
> as well? and mask for proto?
> 
Done


> 
> 
> 

>> -	setup_eth_hdr_key_mask(selector, key, fs);
>> +	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
>> +	if (num_hdrs == 1)
>> +		goto validate;
> 
> 
> Please stop abusing goto's for if.
> this is not error handling, not breaking out of loops ...
> 
> 
> please do not.
> 

Done

> 
>> +
>> +	selector = next_selector(selector);
>> +
>> +	err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
>> +	if (err)
>> +		goto err_classifier;
>>  
>> +validate:
>>  	err = validate_classifier_selectors(ff, classifier, num_hdrs);
>>  	if (err)
>>  		goto err_key;
>> -- 
>> 2.50.1
> 


