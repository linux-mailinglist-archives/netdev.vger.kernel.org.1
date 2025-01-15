Return-Path: <netdev+bounces-158571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A59A12889
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4B4165375
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93D152E0C;
	Wed, 15 Jan 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="+yvzigj8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2121.outbound.protection.outlook.com [40.107.212.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5C33DB;
	Wed, 15 Jan 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958090; cv=fail; b=LWckSEnoKpHw6Pd3nTxA5S2EOJcZLTlvFQAsA/B59IljxLiKANn0siiObVPGuFa1RfmWNN1iCGUFRl8XTo65tUR7yfD0OZFfnrN7Q3MJnmD82De+DtlQtKNckVz7YCHJpKiQfCc9BiROKHuO0Oy7b4iLU4jrpyYBPOQkzxxHmXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958090; c=relaxed/simple;
	bh=+O1bfFcvbu7j7B9KQ9YhvkBoTPZp4soW0zeW/zX2FFY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fPJk1xPJ3tS7IYVWAXBkFJ4yi1syZuTKp/J6hS/mcYPyPKniLa7n5hRynLY7TnCcMm0VVVyzw8zFvRVWNlxD/TD9O+SYxbm5scClX7WMHDVDILhDgsE0SD+5ug1Zci7tZfqNoJWR3axRRcpsZQHA8Nal2HN8O+lvhs7Hz7r+NvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=+yvzigj8 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.212.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkJsV/cYD20vn8u6EGezuE+rEyV9qOd18EHnMBp11r3S3kNVa2a97CKAQKqZS7ADz/d45C8ye8uLsNEMzGgNOF2IAy30so+JBxwhiHLcVnl82cFPAeRSMIjK3G4/Jg63BhbpYVRyFGUipAVDn0faXHRvl/cl8dL+ZcOu91yxdXQ1rddzEVcwWNyBJsBqBDqB31/O2Sctl+VBie78NbQ+QBl3euWsBXKtWBNsvDlaVq/L9G6YyZlsfHeVSO/OCsz7S5S5obBtQr1glQyqP4+6Fysill9uNoBzcwvhJD8SE8VsMVGloj45jiANf7qmcgNb9fYfDwgktsgzchEAAYv4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpzWkwEh7eekH5tGq5YBBH3YiHs8Vu8SQe2qBCnHJn8=;
 b=BKQK7E8PA8ax16F63Md4Ysm1auO9Ajes2ACBKzaOZpMvhCXtMTkxdSxq/Ne28/iceUlPlwfaCfXfRrkkHtknZaamGsrzfnmiHZmGRy3ZUHYBIKKbjcYlf7KgPVtTmbYvyle+JJF2W6NY20YvcpuLrTkNAH0PxUQH3V/0I4iaTkrT+bUtp4pGCjIu6dvBc8lH7kHq1V/pTS1Ch/Tcfc9UAfaTctDxSnzH17eWRWxQMZDH5ujZqeRhvOkLwYKxfgOsPR3GSfmB+VL6juTXjcoz58+xmyEMxdFcZu+Wuo3joSs6yhB7WFEQcnn9VK7so6Knn+3en8hu04p9iwQug6hPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpzWkwEh7eekH5tGq5YBBH3YiHs8Vu8SQe2qBCnHJn8=;
 b=+yvzigj8sf8ZBJ4LyqdrgY+i1jOXl625P8bCPQeN8qktJh4D28ML/OQrr0aGqtAO3rl4XJmRGK67xKAdf+zoJod0BNLQIOvUrook+utVx4AeaBSzgXMm94YS0QaZNa1u1MG9naQr28x4XZRRfZ1A7fR61hTgJ8HGdgieuBdlGNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SJ0PR01MB6464.prod.exchangelabs.com (2603:10b6:a03:29c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Wed, 15 Jan 2025 16:21:21 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 16:21:21 +0000
Message-ID: <dbadafab-c70c-490f-bd34-ac7c1026cda8@amperemail.onmicrosoft.com>
Date: Wed, 15 Jan 2025 11:21:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/1] mctp pcc: Implement MCTP over PCC Transport
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250114193112.656007-1-admiyo@os.amperecomputing.com>
 <20250114193112.656007-2-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20250114193112.656007-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:208:52d::16) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SJ0PR01MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 21aa5c26-70f8-436e-6da8-08dd3580a5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVNsazFpY1IzcFE2dWpaanpCQzNPTnY0VXJOOGVOYzYwV3Z5ckFJU1lZemV3?=
 =?utf-8?B?eXBKOXM1bG0xckZEM09HcTM2UUJEMFlEb2pOd2haaXhQNW9FcEMwNkU2bStk?=
 =?utf-8?B?azZxTkF1KzFSd1YvRXAvbG1DNStLNDhtdCtIaElqZGcxcmZZR1VPRm1uajhU?=
 =?utf-8?B?TjVqUndycDBXQlRpalllMDZleFZ3OVlsaHA1UHl0aFBPV0h0ajIvMTVsbEk4?=
 =?utf-8?B?MXlNa1hqY3puQ3VPaXBoZTRYNFVTbWdGc1BIdFdTck1jemdOaUxlYy9QZnY0?=
 =?utf-8?B?VzNHam5oQnd3dU1qYStKbDFKd0doOTNZN2tGblFiTlg3Lzdvai9kbmptc0ZL?=
 =?utf-8?B?cE9DQUI1eU8xRWMvNWI4Wkl5Um8xOVVuR28vRWwxNmpqVmFucHhKWlQwMDVm?=
 =?utf-8?B?bTk3eDRTSE5uY1paV0ZjTUJrOG1MWkJpTk9VUG1ZeDNOWVl1V0ZiaFdFd1Mr?=
 =?utf-8?B?bHFrSGNGcmsrSEh0bWZWZm1OYTU2VzhPK2h4Q1VuaFpTdXVOQWV0eFdTZkhz?=
 =?utf-8?B?Wnk4NFAvZjVzZVVvMFFUemRCOGttRVBwdjNpL09PVTVkQjlTUVJBYzRkdWRj?=
 =?utf-8?B?VWdPMUhZRnZWbEE2bWZISnd2aUZVb20vZGZtUXVyRCtjOHU3aW55Ni9YL0Jm?=
 =?utf-8?B?a0dxYkY4MnQzMlFtZFU4Mmhwb1NvN2NnRjJYSWdxRCtwZ3dSZ0dCd0sxWWNp?=
 =?utf-8?B?OVZBMmhMem4vWmF6dnpGd0o1dnQwL1RuSzFERWlBWGVpR1FRekF2cm42T0x3?=
 =?utf-8?B?S0d4Z09rTUU1TkhhNVZxcGMvdFZhcjdLSlMvMHJWUTByNzRiWmw4SWIzS3lN?=
 =?utf-8?B?anVMQWZubnJRNTQyRGFVMDk2QzhPd3hDS0dCdjRzSDNNL0FsVnpnTXNGWG9a?=
 =?utf-8?B?bGdHTzYyam1hUi9HY0I4Z2NSbzl3NmQyYS9VSzlBT1E4Y01HV0swUjJ3bk5j?=
 =?utf-8?B?SVhPYXUvMU5qVGt6dUNPSjNtUk1jTzRreFdZQll6VC9DZ3J2em1qV1lXdmlJ?=
 =?utf-8?B?SHd0U2RIcmV2alh1cFd0QUFiZUdyTGMzZ1BuTlJaNWtTemN0aEErSXdIS05Z?=
 =?utf-8?B?bloxa2xBKzZjMjM0OGZicTJwQVhFUkxUaUZBNDNVUEhHSWlaNzJCdEhtZW9t?=
 =?utf-8?B?bnkxWjI4YzNTYUxLci9QL2Z5R2s3Q2hGNEZKV2hPQTd4OTNPdzRyRmNDN2ND?=
 =?utf-8?B?OHdUaTF3T3dhMEdFS0JDWC9FZTdVbWtsRW5iQmI2cSswaXQrdGozVDdFWUEr?=
 =?utf-8?B?Ym1LR0V2N00wOGtSUWJnRTJGUGRjQUp3b3FHRUVSdFFPdEtNVWwzZ2hXUUh4?=
 =?utf-8?B?dmVWZTQ0MFJ0VjYwaExmK1FsWENHOGVZRFNEaUhRK2JCeVIyMEc1Q0NUS3pY?=
 =?utf-8?B?bzZpTkltczRYZUtROTYvUVlFcFJvUmM0U00yMk5nT0ZLR3Z4YTlvTTBvQXp4?=
 =?utf-8?B?Z0wzVlR2Z0pXR3ZkeUw3WTVxNTEzR3BHUXcyS292aTM0Rndqc2tZVmhHUHRr?=
 =?utf-8?B?U25ZWjQyNHRqTnFPUzQ5NXNuTW5aK0wzTFV4YTdGZ0g2T1pvbTNLa1J2bzdO?=
 =?utf-8?B?SURJMXB0MU00aXVKdVVKSE9xZm5aRzJjYkdSYXdjRnhwbnNHS3pXYmdmb25E?=
 =?utf-8?B?QWk3cE4zWXpSd3FBUElrYXBlQnl2UVc0UFJVbkE1Ujk5YjlFcFhmb0JEL0Vx?=
 =?utf-8?B?MHlnRnlrUFdHZ0tsMUhtNjBXSEtLRElUTE1JODdlN2pNRXZ5N2Z2UWpZREMz?=
 =?utf-8?B?aWhQZDNqU2xSaHU1aVFKR3pjTlpNWm44RElnZURJUWdyZlI4bHBteUhmT2d1?=
 =?utf-8?B?K0h5S2tKN0JUNVlsYmx1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1d6TFZIVXI4QVZ5MmorYnFXM2NoNWwzaldYZ2xGVWdTcURyaGJoQlJlaVlu?=
 =?utf-8?B?RzdVNXhUR0NBa0RVQS9Qc3VxSFUzeiswSlh6TWh6dSswajBuVmJEMThaYktT?=
 =?utf-8?B?TWxkenR4ODBONEdsNy9VemF6WjdQeFJYVVp6UTJySzBNdWdNNHhxMEZIQU51?=
 =?utf-8?B?dTlYS0FtNldUTGRMcUZkMVFEVDM0eklKTm83OGZheUsweWduYkthOHJ0dGxx?=
 =?utf-8?B?cXRSV1ZWMWNVbVlTTmp6dkxSRU1aUUdETWRWVFRRaDNxQWNYazVKNHFrSmpX?=
 =?utf-8?B?VU5xTjVPNDRCTXYwdGE3WXgyeUNxTUswUHRFUGFpZExaWnN1dytpSVY0QzlK?=
 =?utf-8?B?UVlCU3FrSHNkRmcxNGZWMW1DTTVPZXdQSUg1WWd4Ulp1ekxES21NS09iM3RC?=
 =?utf-8?B?clBlS2xnWUZUOFgyY0JLWG9nYWM0WnJ0VHpwUjRiQ0xhc2pIUS93eTA5a1lj?=
 =?utf-8?B?WEFLbFhybStGVFNlc2pUV1JNVXFtSmZLQ0gwdnBXN244VUFLazRhZE9aWEtk?=
 =?utf-8?B?YlhFUk1jTHVYVWVLUGRpUTNFUlhZRjVObUJWendYRFJCeEtjQ3hpaTZMTC9T?=
 =?utf-8?B?czZBdG9heG8xN1IxNzNWV0dwTEoxWlFybkNYYUF4R0ptNmVTNW1yQmdwVjY4?=
 =?utf-8?B?QnE4bldFUGJTamRWaGpuZHRHYWQ4NlNnUUNhTVhZc1R3REMvazRuQmlPUDdG?=
 =?utf-8?B?U3ZxZUhYckMyT3hEOUJJcFJXMk51dGZ4bHEwY0NRck5xUW9vSWlFZlZNYk11?=
 =?utf-8?B?OWE1a1JFVkhJQnQ2aDJUSjU5YmhNYWxuREIxVmtkeE5wR2hiK3ZQb3JmME9a?=
 =?utf-8?B?YWxkKzd4eHVCcEFlQi9kdklkR3BnZitGczhuSnkzdEZPYVNrdzEveUE4ZDdS?=
 =?utf-8?B?V08yOW9wdm1WaGJ1RndUUzljdnBNWkhGSFhTYnczL1ZhR2M2MStZbFhNei8y?=
 =?utf-8?B?bVF6ZUM5M3B4MmZxcHRic1lVdVZxOUxsSzNyUjg1K1QveEQzNFFLZVBPb1Nn?=
 =?utf-8?B?dk5FWWx1cm5uVCtwWTk5VTBReFdEVzVhNzBwQzZSN0NEMjQxODRrVGtLK1ox?=
 =?utf-8?B?OWkyaFBwVHRTbWpBL3pBQk50L2xYVmIzMkJDN2NBVlIvOHZyZXRjQ2xXZzZ6?=
 =?utf-8?B?ZVBsZWVXTmlRV3ltOCtNQnNwWllLcm43STI4MXJzTFRPUlNEakx4ZVRKQTEr?=
 =?utf-8?B?Q003K1NzZ25wVEV5NlNtekNKUEJ2d24vSUR6UndNREpSdTgwVFlqU0NUc3Vn?=
 =?utf-8?B?b0p5ckZ1eEFLdWRsSjE0RjZtb2JmSFdTYUVpd0ZHSjBzZytlQW5IbkNaTzdG?=
 =?utf-8?B?OUhTSUFxYmNPcWRKb1ZBWFN3Y3FOYlUxTGJzRWo3YlVSK3cyUnhEWjRtUHNE?=
 =?utf-8?B?NHZ0VlJJRVQ3NWFTMVVwUzZoNXY3TjlFNDBnNSttSnc5aGJiSkpVUTJvczMv?=
 =?utf-8?B?NVExODhZeWExbTVLcmQ5QzZOc0w0STRxQXgwVjVBbmZ0VW1jQ3hId0dtdksx?=
 =?utf-8?B?dk5Jck5WU0VUcUFkSm5zTnZrN0d2dncrOHZGc0UwbHA3N25NZ1RSYUI4bWcx?=
 =?utf-8?B?d25xR1Z2VUVXN3BEYmtVbGI0VVdISWNla1doTXViNkpxaW9mcWRyVitGa0di?=
 =?utf-8?B?bWVYeUt3bWRaQklPYUVhSXlPQVY3MFJIR0hzR3ozYk1lZG9lL05qUFZOajBt?=
 =?utf-8?B?T0VrRStPVGJXZnVIa0xXbWZzbGkvWDNoQVRHQjQrOHJkZEg2OGg5aWQwbW11?=
 =?utf-8?B?blEveUtqc1NXbGoycmFLeFZkSE5iZFJWcWFJNzFnNHlUY0pscnN5Z0F0clVs?=
 =?utf-8?B?eHdtRDN3SUdyNUpvWGhPeFNtQnZIVEVwZUd5K21XQmZzL3VXQVR3SE9GQ1Ir?=
 =?utf-8?B?SHl1WVRKbEhkN1hJaEY1aTd1VW1PS2U3NUFSdWx1cEwxdXlyTTJLQzU0K29w?=
 =?utf-8?B?bUlSa0RiVXYzcnFiT3k3c2hhL3dLQlFYYzBPU01vNkVvaUhCREQxVUE4ZzZt?=
 =?utf-8?B?OEJITjQzUkJoaGxoZDRXckxaeVJXMmwwRzg3ejBMY0drS0JEUmxweDBRekZy?=
 =?utf-8?B?Q1ZvbFBvVThBQXVoZzBIVGZTVjY0Vjg4WGs3VkdCOWJpUEtRTVVnSW5YTm16?=
 =?utf-8?B?QlZySGZvNkk3dkZsVEoxMEhDWWhNYnhWcXNQdjRzeDlwdU1QbXNBZzlOcG5G?=
 =?utf-8?B?YVo1RXVodWMyMWY4a0tiRTRLMGs3aCtmS054emRQdDNmL0hPUUpURDVFSnp3?=
 =?utf-8?Q?O/40FlJ3LBBbP/J1EByhdbrhrr12G4sGWE5UFNQ8S0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21aa5c26-70f8-436e-6da8-08dd3580a5fe
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:21:21.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEAdEhdMEj4lqwUSu3DOtfXZibJV2Nr0qlm3hYzkCOvgOn9ubpI8hk4iA6bYt8qCZE9hFyQIVQxeteHDIsUdy5zLJURyDxLSAVnHDB5NGOFuN2hgXWUdGY9tzJMdrY/6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6464

Let me self report the tab issue on the maintainers file.  My editor 
originally put in spaces.

I made the change in code and did not update  the patch, so it fails 
checkpatch.  Update in next version.




On 1/14/25 14:31, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
>
> Implementation of network driver for
> Management Control Transport Protocol(MCTP) over
> Platform Communication Channel(PCC)
>
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
>
> MCTP devices are specified via ACPI by entries
> in DSDT/SDST and reference channels specified
> in the PCCT.
>
> Communication with other devices use the PCC based
> doorbell mechanism.
>
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>   MAINTAINERS                 |   6 +
>   drivers/net/mctp/Kconfig    |  13 ++
>   drivers/net/mctp/Makefile   |   1 +
>   drivers/net/mctp/mctp-pcc.c | 313 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 333 insertions(+)
>   create mode 100644 drivers/net/mctp/mctp-pcc.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1579124ef426..a4b8168cb346 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13789,6 +13789,12 @@ F:	include/net/mctpdevice.h
>   F:	include/net/netns/mctp.h
>   F:	net/mctp/
>   
> +MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
> +M:      Adam Young <admiyo@os.amperecomputing.com>
> +L:      netdev@vger.kernel.org
> +S:      Maintained
> +F:      drivers/net/mctp/mctp-pcc.c
> +
>   MAPLE TREE
>   M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>   L:	maple-tree@lists.infradead.org
> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
> index 15860d6ac39f..073eb2a21841 100644
> --- a/drivers/net/mctp/Kconfig
> +++ b/drivers/net/mctp/Kconfig
> @@ -47,6 +47,19 @@ config MCTP_TRANSPORT_I3C
>   	  A MCTP protocol network device is created for each I3C bus
>   	  having a "mctp-controller" devicetree property.
>   
> +config MCTP_TRANSPORT_PCC
> +	tristate "MCTP PCC transport"
> +	depends on ACPI
> +	help
> +	  Provides a driver to access MCTP devices over PCC transport,
> +	  A MCTP protocol network device is created via ACPI for each
> +	  entry in the DST/SDST that matches the identifier. The Platform
> +	  communication channels are selected from the corresponding
> +	  entries in the PCCT.
> +
> +	  Say y here if you need to connect to MCTP endpoints over PCC. To
> +	  compile as a module, use m; the module will be called mctp-pcc.
> +
>   endmenu
>   
>   endif
> diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
> index e1cb99ced54a..492a9e47638f 100644
> --- a/drivers/net/mctp/Makefile
> +++ b/drivers/net/mctp/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
>   obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
>   obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
>   obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> index 000000000000..87283e5b1490
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mctp-pcc.c - Driver for MCTP over PCC.
> + * Copyright (c) 2024, Ampere Computing LLC
> + */
> +
> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0256_2.0.0WIP50.pdf
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/if_arp.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +
> +#include <acpi/acpi_bus.h>
> +#include <acpi/acpi_drivers.h>
> +#include <acpi/acrestyp.h>
> +#include <acpi/actbl.h>
> +#include <net/mctp.h>
> +#include <net/mctpdevice.h>
> +#include <acpi/pcc.h>
> +
> +#define MCTP_PAYLOAD_LENGTH     256
> +#define MCTP_CMD_LENGTH         4
> +#define MCTP_PCC_VERSION        0x1 /* DSP0253 defines a single version: 1 */
> +#define MCTP_SIGNATURE          "MCTP"
> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
> +#define MCTP_HEADER_LENGTH      12
> +#define MCTP_MIN_MTU            68
> +#define PCC_MAGIC               0x50434300
> +#define PCC_HEADER_FLAG_REQ_INT 0x1
> +#define PCC_HEADER_FLAGS        PCC_HEADER_FLAG_REQ_INT
> +#define PCC_DWORD_TYPE          0x0c
> +
> +struct mctp_pcc_hdr {
> +	__le32 signature;
> +	__le32 flags;
> +	__le32 length;
> +	char mctp_signature[MCTP_SIGNATURE_LENGTH];
> +};
> +
> +struct mctp_pcc_mailbox {
> +	u32 index;
> +	struct pcc_mbox_chan *chan;
> +	struct mbox_client client;
> +};
> +
> +/* The netdev structure. One of these per PCC adapter. */
> +struct mctp_pcc_ndev {
> +	/* spinlock to serialize access to PCC outbox buffer and registers
> +	 * Note that what PCC calls registers are memory locations, not CPU
> +	 * Registers.  They include the fields used to synchronize access
> +	 * between the OS and remote endpoints.
> +	 *
> +	 * Only the Outbox needs a spinlock, to prevent multiple
> +	 * sent packets triggering multiple attempts to over write
> +	 * the outbox.  The Inbox buffer is controlled by the remote
> +	 * service and a spinlock would have no effect.
> +	 */
> +	spinlock_t lock;
> +	struct mctp_dev mdev;
> +	struct acpi_device *acpi_device;
> +	struct mctp_pcc_mailbox inbox;
> +	struct mctp_pcc_mailbox outbox;
> +};
> +
> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_hdr mctp_pcc_hdr;
> +	struct mctp_skb_cb *cb;
> +	struct sk_buff *skb;
> +	void *skb_buf;
> +	u32 data_len;
> +
> +	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
> +	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
> +		      sizeof(struct mctp_pcc_hdr));
> +	data_len = le32_to_cpu(mctp_pcc_hdr.length) + MCTP_HEADER_LENGTH;
> +	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
> +		return;
> +	}
> +
> +	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
> +	if (!skb) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
> +		return;
> +	}
> +	dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
> +
> +	skb->protocol = htons(ETH_P_MCTP);
> +	skb_buf = skb_put(skb, data_len);
> +	memcpy_fromio(skb_buf, mctp_pcc_ndev->inbox.chan->shmem, data_len);
> +
> +	skb_reset_mac_header(skb);
> +	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
> +	skb_reset_network_header(skb);
> +	cb = __mctp_cb(skb);
> +	cb->halen = 0;
> +	netif_rx(skb);
> +}
> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct mctp_pcc_hdr  *mctp_pcc_header;
> +	void __iomem *buffer;
> +	unsigned long flags;
> +	int len = skb->len;
> +
> +	dev_dstats_tx_add(ndev, len);
> +
> +	spin_lock_irqsave(&mpnd->lock, flags);
> +	mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
> +	buffer = mpnd->outbox.chan->shmem;
> +	mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | mpnd->outbox.index);
> +	mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
> +	memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
> +	       MCTP_SIGNATURE_LENGTH);
> +	mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
> +
> +	memcpy_toio(buffer, skb->data, skb->len);
> +	mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
> +						    NULL);
> +	spin_unlock_irqrestore(&mpnd->lock, flags);
> +
> +	dev_consume_skb_any(skb);
> +	return NETDEV_TX_OK;
> +}
> +
> +static const struct net_device_ops mctp_pcc_netdev_ops = {
> +	.ndo_start_xmit = mctp_pcc_tx,
> +};
> +
> +static const struct mctp_netdev_ops mctp_netdev_ops = {
> +	NULL
> +};
> +
> +static void mctp_pcc_setup(struct net_device *ndev)
> +{
> +	ndev->type = ARPHRD_MCTP;
> +	ndev->hard_header_len = 0;
> +	ndev->tx_queue_len = 0;
> +	ndev->flags = IFF_NOARP;
> +	ndev->netdev_ops = &mctp_pcc_netdev_ops;
> +	ndev->needs_free_netdev = true;
> +	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
> +}
> +
> +struct mctp_pcc_lookup_context {
> +	int index;
> +	u32 inbox_index;
> +	u32 outbox_index;
> +};
> +
> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
> +				       void *context)
> +{
> +	struct mctp_pcc_lookup_context *luc = context;
> +	struct acpi_resource_address32 *addr;
> +
> +	switch (ares->type) {
> +	case PCC_DWORD_TYPE:
> +		break;
> +	default:
> +		return AE_OK;
> +	}
> +
> +	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
> +	switch (luc->index) {
> +	case 0:
> +		luc->outbox_index = addr[0].address.minimum;
> +		break;
> +	case 1:
> +		luc->inbox_index = addr[0].address.minimum;
> +		break;
> +	}
> +	luc->index++;
> +	return AE_OK;
> +}
> +
> +static void mctp_cleanup_netdev(void *data)
> +{
> +	struct net_device *ndev = data;
> +
> +	mctp_unregister_netdev(ndev);
> +}
> +
> +static void mctp_cleanup_channel(void *data)
> +{
> +	struct pcc_mbox_chan *chan = data;
> +
> +	pcc_mbox_free_channel(chan);
> +}
> +
> +static int mctp_pcc_initialize_mailbox(struct device *dev,
> +				       struct mctp_pcc_mailbox *box, u32 index)
> +{
> +	int ret;
> +
> +	box->index = index;
> +	box->chan = pcc_mbox_request_channel(&box->client, index);
> +	if (IS_ERR(box->chan))
> +		return PTR_ERR(box->chan);
> +	devm_add_action_or_reset(dev, mctp_cleanup_channel, box->chan);
> +	ret = pcc_mbox_ioremap(box->chan->mchan);
> +	if (ret)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
> +	struct mctp_pcc_lookup_context context = {0, 0, 0};
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct device *dev = &acpi_dev->dev;
> +	struct net_device *ndev;
> +	acpi_handle dev_handle;
> +	acpi_status status;
> +	int mctp_pcc_mtu;
> +	char name[32];
> +	int rc;
> +
> +	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
> +		acpi_device_hid(acpi_dev));
> +	dev_handle = acpi_device_handle(acpi_dev);
> +	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
> +				     &context);
> +	if (!ACPI_SUCCESS(status)) {
> +		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");
> +		return -EINVAL;
> +	}
> +
> +	//inbox initialization
> +	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
> +	ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
> +			    mctp_pcc_setup);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +	spin_lock_init(&mctp_pcc_ndev->lock);
> +
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
> +					 context.inbox_index);
> +	if (rc)
> +		goto cleanup_netdev;
> +	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
> +
> +	//outbox initialization
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
> +					 context.outbox_index);
> +	if (rc)
> +		goto cleanup_netdev;
> +
> +	mctp_pcc_ndev->acpi_device = acpi_dev;
> +	mctp_pcc_ndev->inbox.client.dev = dev;
> +	mctp_pcc_ndev->outbox.client.dev = dev;
> +	mctp_pcc_ndev->mdev.dev = ndev;
> +	acpi_dev->driver_data = mctp_pcc_ndev;
> +
> +	/* There is no clean way to pass the MTU to the callback function
> +	 * used for registration, so set the values ahead of time.
> +	 */
> +	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
> +		sizeof(struct mctp_pcc_hdr);
> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	/* ndev needs to be freed before the iomemory (mapped above) gets
> +	 * unmapped,  devm resources get freed in reverse to the order they
> +	 * are added.
> +	 */
> +	rc = mctp_register_netdev(ndev, &mctp_netdev_ops, MCTP_PHYS_BINDING_PCC);
> +	if (rc)
> +		goto cleanup_netdev;
> +	rc = devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +	if (rc)
> +		goto cleanup_netdev;
> +return rc;
> +cleanup_netdev:
> +	free_netdev(ndev);
> +	return rc;
> +}
> +
> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
> +	{ "DMT0001"},
> +	{}
> +};
> +
> +static struct acpi_driver mctp_pcc_driver = {
> +	.name = "mctp_pcc",
> +	.class = "Unknown",
> +	.ids = mctp_pcc_device_ids,
> +	.ops = {
> +		.add = mctp_pcc_driver_add,
> +	},
> +};
> +
> +module_acpi_driver(mctp_pcc_driver);
> +
> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
> +
> +MODULE_DESCRIPTION("MCTP PCC ACPI device");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");

