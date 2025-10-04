Return-Path: <netdev+bounces-227850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D28BB8C3A
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 11:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C293C78EF
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 09:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD2F22A4DB;
	Sat,  4 Oct 2025 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VxH8l+2+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jG9e3F1y"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1E213E6D
	for <netdev@vger.kernel.org>; Sat,  4 Oct 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759571648; cv=fail; b=m3M9bBVo23pukOIoWM0ILWEIhug9nz6XpybVQKbjH8bX/vFuXwftpEmI3W1sg+2/yPR9u5IE/VKo3Uye6eM9fpXLkKdijhrW5kgo28zWDTCz8BA7GsClWywZmuSK/JtVrPgawloQAeZIEQqEB3k9g4SitAuRNNjvrWsb0N0kjXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759571648; c=relaxed/simple;
	bh=Vtl3d+b5/6Bi7qE8OuXowexetmdUG5m5v4DsfhQEuWY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eOpnZtPjB6Zd6gqGRlufW7MQvVkBfyh14vM6Ak0a+wepdJ1++YAKWUxu+/dO5MSwIPb0ogHxCxIAiWqB4k8rFiXkwAKIFqYIt0dkTqid2oizJ3JlSy0AuHnuv3lOzIBwWQNLgDIBWTtxqvUDPklwpY7FTob+DwNCcCWB8nqb3Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VxH8l+2+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jG9e3F1y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5949e2b1024358;
	Sat, 4 Oct 2025 09:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=C3HkI1frw+9VIp3T7tSXOLtxf69Wlq9Xv6o+gROf51I=; b=
	VxH8l+2+9V9KB840YcWpVggOybcsJ15nl0XRZ8oqoAGhhClcmzHhCJFdgAm7OwlR
	BaTx5otseXcQmKi/4L56oTfHgCzTbej435qNpOtXM9IZu8Lsop/htotXtYkoQMQA
	/iLP1oj+FbJ2O/cVIQAkYmhiYh2Dt6UwJkH474vaulKQtP+GYAlLs3xRF4pz9Pg0
	pcFo35+K4fQ7mtyaKbRCnhEmpcSKur50gCuzLzl7JCZo4QTJRNkro1hA28DHEipX
	esbvcR20uEf/i/0/bXsYG5p9gbyPHuk5+dzorzsj3JuJ/1teDMCaqPScoz72BUbC
	iEyY5MimYFAuSXCnb5gkRA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49k150g07y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Oct 2025 09:53:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59470IjO028815;
	Sat, 4 Oct 2025 09:53:49 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49jt157mc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 Oct 2025 09:53:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTLP4B1N4rOTNByDjl6vgIIiUxjU8D6YEZk0jMg9jPDoxxFVXqi6mBgoNo0CDPSz67lRziSHM1UycOfyqBPkMPcU/99gklynURqUiKvGWebJ8C7LRdua/tJ+MML8v+1dDMh0wWEjIeiUGQQeLVnY5e3xsQEo8w5iz29UCyoafdjPr9V2U7wQt8HDdH/eys7r+NR3FdROJDWVPTUbX30VEtpf0c9PWnHDLjAd62ndKKjPqJ8nsLfGWTVZ9hC+91IbzrxxGo3qsujH43RqYpbf/7nmVHDBqPjsvD7JM5axYFwLgkba7QoFMzEYIrSAb0ov6iqEaj0VusnpcXGdStFGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3HkI1frw+9VIp3T7tSXOLtxf69Wlq9Xv6o+gROf51I=;
 b=khpJYFGZ7NB9IDOkgdFk7IX8u0NpBJfDAAMVF/yjgMmslf4saq+qxTbK58zSfOzMyuUkiHrcG5hTrT5rRTIkPhK6s2+6Lp1Y++O08CArxohTXhh7Pi314sQ8bVxBfTg6hzdwlK88n30JESw5wUfLSrWaV+9A18Oh6Ez+HzYYUC+V8x9I/hFdWyRBRJ6mSfLyhjwryI4tsAMqTB/CiSXQcgxfNz2ghrwXG6DyCYCiDTxKwtR9beGWmJ4wAkwkI6SkG7SkhxUCvqwAjhOCrONud8dkY1WYugkN3ZkYCPcntEuPx5I6fH97jRXFfqu5nS33KwjZlpOD9a4tRvmPIkb5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3HkI1frw+9VIp3T7tSXOLtxf69Wlq9Xv6o+gROf51I=;
 b=jG9e3F1ylcSnK/E9zjoZRcfLrycUvSDXlOJ/nhpV2NSdwFHUl2iOpO5lwI1RYEgFuXeL9YsnbSvkZEuv8cvM2mnK+IZR3/mXz14feUbFEHN7lJobRpbJvAX02BjOtiiPGqjd73inIgH1wSDiLcguAdTjTqoPnN/wMgaQKpBvKlQ=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SJ0PR10MB4463.namprd10.prod.outlook.com (2603:10b6:a03:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Sat, 4 Oct
 2025 09:53:43 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9182.017; Sat, 4 Oct 2025
 09:53:43 +0000
Message-ID: <599e8a11-3276-4d67-8ef6-c335be560ea8@oracle.com>
Date: Sat, 4 Oct 2025 15:23:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH ethtool-next] netlink: fec: add errors
 histogram statistics
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, mkubecek@suse.cz
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20251003225253.3291333-1-vadim.fedorenko@linux.dev>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251003225253.3291333-1-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0219.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::15) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SJ0PR10MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c223cfe-d84b-4aee-3a0f-08de032be6de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDJjdXpqcWhBWTVmMmo2NU5JOXB1NTdYeUVCS1hsa1E2dVNYUjJDRjVtN3hj?=
 =?utf-8?B?bmVWV3ZPUnBLVE1ndE11NUd6WGdtYWlrekRtbVJzWHkxeWk1KzZ4WXl5cWJu?=
 =?utf-8?B?U3l5VHNlVE9vN3N2ZlBWa293ZVZwYzEyWExySE1XOFZMdm93RFVSUjF1aGlt?=
 =?utf-8?B?d0Vka081Qll6diszSjZQYmwwSm4vYi8zdVkveFZJVUJ2Nnd2YzBqcXpMV2pE?=
 =?utf-8?B?VWV3eDlPZFlLeEhLTk1pOVhnYVRzOGUxZTNYKzYzd0RMd0g2dUJSUUF2MVJ4?=
 =?utf-8?B?eXlVcTJweVBpcjdHSlJuUVdOV1NoOUF5bllmTjV4dGtGRjFYMmFUbTE3T1VX?=
 =?utf-8?B?ZFcyK09FbzcwV3FSRXFHR3U1Um9WRUFXZFZZMUhPUUZoUFIweEVQZ0MrRnJs?=
 =?utf-8?B?cWo5ZmEyWkZBWmtQcnVnajRZZHZUSUxkSXVyTis3VC9XSksyR2U3VEs1SHds?=
 =?utf-8?B?aWgyYkRLcnVXUm10TWNtdDYxV1NCbmExcWxGNmxnZE5HOE9kNjgwV2E5Y0Z6?=
 =?utf-8?B?ZC9IOTFUZWN2eDB4Uk9RSUQwTlg3dE45TE1Wdkd5MVphbkM2bW1YZ1FzdUtF?=
 =?utf-8?B?SDk2ck0xQ1hqTkUrcm1jMGl3clBqL3FmYStjQ0o1djlTcG8rdGsxTFlSNEVL?=
 =?utf-8?B?UjNmcUdpRlBPclBhL2hXb1ZYQzNPM1RmMXlWWFp0cDhDUURVeERFdUxSbzd2?=
 =?utf-8?B?VGdjQ0hIcWVKV3BMMWhUQVp0Mm9hN1Y2SGh3MzdhcWFtZ0dEQmZlbm1ydjBr?=
 =?utf-8?B?MjBIckpzTEdvZFE1RWlMbjF2ek5hQTV0SzJuWjk2cXhwVmZ6dGo5Y1RqYU81?=
 =?utf-8?B?eE52NzIrMTl0M1pHVkhKN2lhNm10ekwraVRjWk5Cazl3NUc1ZUVFeUhCZVZu?=
 =?utf-8?B?VVZ2eFdyVmxvOHliZUtEVjJWQm5NRVFmb0VRdmdLdDZVUk9rek5GclZXZEF3?=
 =?utf-8?B?MVo3cDRMa1pHMU5oUXcxaERGTkNSMC8rTmlBTUEvTjVBVnBPbU1sSUNNc1FR?=
 =?utf-8?B?NXhQTjhUN3ZFT3FRK1g1RVRQSGlLRkxjRTAyVGU0UWEySmwvWmF3YnV3VFpY?=
 =?utf-8?B?c0RPTzV4V0dydGFOc21oNUpMYWpTNkFyRG1hbndZVXo4UXBoZFZuQUxlcmxP?=
 =?utf-8?B?L1I4OXE5ZHJiR0liMElLK3B4dkhtSTB6UHl5elN5MUJMVEVpeVAzVTNrN2Jy?=
 =?utf-8?B?SUdESy9HdkMwRkFiUTk2Q0tpSTYvVURBOGZnR1lZa1d1R0VMeVdtS2piVjJu?=
 =?utf-8?B?bUtYL2U4UFJqOXJyVnJyTGhURnZBaWxPQWpOenY4cDZ4TU5QTWJUS0R5NGJM?=
 =?utf-8?B?ZFlDQlRMR2c0dTR2MnRySGUvUTFYR3lCNERpRXdQa3ExMUk5M0dSblkySExa?=
 =?utf-8?B?ZE5OV0VSTldWZzBMTTViRWFsYXV2YXFqdFEzQkt1WEdHN1FQTHY3Mmg1ekdN?=
 =?utf-8?B?SWxpTzhsbldVVEt5VStxdm9KWkFTb0t3MnRkRS9WN1BkV0hYRDkrdlVZVktr?=
 =?utf-8?B?blpsSkVWNzFZYW5mc2FjdThIck9UVUlUKzZCTzZCRlU3MXEzL09TZTJyZWh2?=
 =?utf-8?B?ZW5ZMGl2bmI1THEzRlhqTmNJbmp3WHZqN1FLN0lnQUkwOEVsSHZpWUh0ZXlj?=
 =?utf-8?B?VWx2N09oNGhyK3NPRHZhYjlHQWZZZW1KVEFsS3FEK1gzWUE0VllDZktBb2hP?=
 =?utf-8?B?bG9YcGltT08rZWkwSmdYeGtyRzhCRFpvcEZtTjRIQmtHS1BYMUp2RU9yOXI2?=
 =?utf-8?B?MS9IZDZlUytSeHQyYWlvcHlIclhpMUR2UjVNQkpvd3FoalZJcW9wNGwrZnBV?=
 =?utf-8?B?TE1hWmhDSlVVNkZKQUo5NEJGcnNuVWZ4WDg4OFpKbWxzVHkzcys3SGdQVHlR?=
 =?utf-8?B?QmkrSVhEcHcwUVp5YktxL01HR2lycXkyaWh5MkNQZ1hiL0FQSFVva0F5ajZN?=
 =?utf-8?Q?+rHiWWhIh2+Uv7ie4BzwopJs4m0RGTIa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjltNE1KYmFBQW5MaVFuZWVFUEJhNTJUdmJTdmxNRkFzYUwvSGEvaklzMzhZ?=
 =?utf-8?B?dW9HRmV0bEN2VS8zbk9UK0MxYXhnZ0JkUGEzS0RFVktQOGJYYTdvaXhsdHE5?=
 =?utf-8?B?S1doYnVQSU96bDYrRytDcmxadVo3a29ZZTNNTUhqelRKeGVHK0NreHhpb3V3?=
 =?utf-8?B?cXpzbWxjYU5UeW8zZm9kM1RVekNGTUl6TTdqa3pxM25FT3JBbnYyejRDaTNh?=
 =?utf-8?B?d1UrdnBDQVlCdXZwdnVKSk9UK0pMRDY0VTlmNm4vMzhudzJ1NUswdjBPQUZR?=
 =?utf-8?B?L2FoYXYwekxqTmxpWFgzSzdBYnJjbURUczZHVXY2a2JMOUY5MHVMZDRVanJK?=
 =?utf-8?B?OE9aRmRYSTlSRFNCVzMyY2VXcGlSc3VmQWxza2VWWUhpNUFFUURqSDlFaytv?=
 =?utf-8?B?Q0VhOFE5YkFWZWZUNmpqWjNJOSs0SE1QVVN0UmpucGsvWXRkQVI1OVZZOWxq?=
 =?utf-8?B?eGJuak5wTFFhSjAyVnptRDV3R0Y5UU40dnJ5NHFzTlZuM0hwVzBuR2VjbS9C?=
 =?utf-8?B?U0dncVgwdU1EWWVPM3FpdFd0aVAwQ09qdUh3TXc2RW1BaWVSWUZDTEJoYlhC?=
 =?utf-8?B?YWtUa055SVV6TkVrYXNSUkwzV1hUNlhWWkkzZkNwSkJpZGxrOTFZYkdUbnpz?=
 =?utf-8?B?THpHV3d5N0w1L3p4U0hZa2Juc3ZUa3d5S0VvVjN4aWU0SGtFOXd1V25rSlRt?=
 =?utf-8?B?dVZmb2lFK3pzc0ZxR3FCSU1KRnliVFROeU5IZy9kRDFaTVZ3SzZDTzhiSTNj?=
 =?utf-8?B?WHFaWmdIYWtpTmZwRnFLSW5rS1Y1djVoTXhIRkN4RkxTditHbEtxSkdxTGZs?=
 =?utf-8?B?YWczOTkvcklTV1ZBeU95dVRBYlhCNDFnNFlpcFNPSlI1R0NtRk12eVNvcld3?=
 =?utf-8?B?eFhVckpsY3lVaURDTTY0cm9ucy9RUkt3M3dOUWkxd09sbGlCZ2gxbjcvbGdq?=
 =?utf-8?B?em1Fc2dlTElTU0pSSXpEa3R0VE45L2tQNm1uVjhBTmpnSjRkQVl1aDhhbk94?=
 =?utf-8?B?clJIbkUvUldXOHRvV2oxVGZ5VXhTS0Q0WkxzNDk5cVVUaEtoejFWbmxIaTNU?=
 =?utf-8?B?Mzk2ck5veDI0aVJrWVg1ejJUbVJEK3NsT0ltVmpvTWZ5dUdLSXMxdEVkdzFj?=
 =?utf-8?B?QUQyOE5oVXhzK0hkVkgxWFlueVg4U2J5aXVQcW5sbENjRzBEZHRidHBwUDhW?=
 =?utf-8?B?VGkvU2g2M1lxaTVDUVFvMW9rUnhTVmJOTlhJUXl3dW9UMG1EWE9lQitBQURt?=
 =?utf-8?B?M25ydjJEQkJTdnBqYlNnaWRadENDU3dHYXNqL3BadmlORncwcktwdUNUYVRt?=
 =?utf-8?B?L1B3VFdhMHIxM3BHbWVvWFZBbnJtUGRlMzdVclhBcU5Pb2VEM0tVTzJjemV0?=
 =?utf-8?B?Q29vUDc3a1NPSlY3NFhndW5DdUNhLzFCelJFeVhBQW5NRHNZM3VoWCtXQTZD?=
 =?utf-8?B?c2tDbkVhc04xY3V3YjdVeitYWWw4cjQ5SC8xN3hQQ2FtYVRNUEJVSDBLd2M5?=
 =?utf-8?B?U3FnNTBVc0w1TXA2WFNUYk12MHNoelRLNnJ3TmR3VWo1cUdWcmVHRmZYWnhQ?=
 =?utf-8?B?Qm5HV0w5YzAwTDhNVERGR1ZmU1pFMkUzbkU0Q0RlUFFuV3VCWWFtd2ZoMVJr?=
 =?utf-8?B?WS9sakRvbEJYakxwUktRb0MvMWtBS0ZPVnNvMzlzWnhsUnN4TEpPQkEyT3ND?=
 =?utf-8?B?clNWckhBcStROGtqL21ObnFydEx1U1pkaEdEM2dnSFF3Q0V6TXlJZDE2L0Yx?=
 =?utf-8?B?Sy9XcGFYV3IyUWhDWURMbWQrZUpYREtFRGJnZHVCNUVsdHFEa1pJTkNqT0s4?=
 =?utf-8?B?eS9oUkRuanpoczlzRmRsUDVVR2FCNTVoRFlJa0o4VHZQV0paNnRZTVRITVYr?=
 =?utf-8?B?ME85Z3YzSXhpVDdmdHppYWNvYVVVbUtYejdmMW9IU09JY0hTOUg5cTVVNGRz?=
 =?utf-8?B?MVB2c0ZrR3ZTT3E4U3NIb3ZwT2Z0STVidTFqNFFRQnV0RkdBRTdVQnlQeHlS?=
 =?utf-8?B?MDhnYjBQelNIamJQRWNUTHdXL3ZsbHJabXFKODFkc0IwV1VIbkNkOUJaOTJo?=
 =?utf-8?B?NVFxU25mRXhoM0NDemRuVXdwR3c4bjNlZWlpd1Q2RjZjc1k1Ykg3bndvcFFD?=
 =?utf-8?B?b1ppeVg2YXVpb0FTVkppbUVNblppUmUvWkVqSzlmNSsveXpVSitIaEtsMWRC?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xGonVtoN2AvjvS/3jwjzR3+cZ5fB2woD4yaZ0636Pwjz3tSfKKBUz2oodB9G9HpoKlrk25zsGWX0dzbR2Lr/rG0V6qq/R0H/499UuDZUJCCuqWDuAxdQs7Umq0Es310DZHdoUos3I3khWI1MDTrPXu7qsEGseJO8Wyr4wUPkCa7zW0dPe2puvEGEuNyEU+mol/DM9g8v4IIZ81etbuxBGxSeGnq15YJodenFrSOCLrD/Nehq115s0PqE5XfN3B1dKOllZSnZok7kJEKFH4VvTIQASCkgefXDs0byeoKKPzYuQFHJH7Lukz5nx3jYgW6KrxuSVoHzI5DX7OHsbDcvlnPhT/s4KSjeJ8opBJmmah46tsLkJdZBCIeuHT9PkuDN1m821Spq9U3ZxtDelzsB/3KU3rEMvZHJMqd45d6Rn65WZUM3pbJB3xiGyiSzDKzoXBKkJK39WsTuj5+Eptg9Qiwf2GtH4U8msvC9fIKOLPJAiq1K+lwnNbuUVw6ygvxD0X5OeYWWL1LxBQKkT3fPEbuVPDSmNxrr8d8BzlLEFulKngNxvuh/dtVgJtq9CW5lpzS6PPGiIqJ6wlzVw7d+p+4c7u76ET3MVpOLc5BcOxI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c223cfe-d84b-4aee-3a0f-08de032be6de
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2025 09:53:42.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJnF0v1vkLj/LKYNFDQXhOp2QtYb9eaXzvbhRgoZdOy2bXGgKRrGep+vz+5e2Bd/17SJg3WGWrgnmVQSTkMznW9hqhrCMEH2C1bDX3KpnP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510040086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA4NCBTYWx0ZWRfX69hYIFV0QGDd
 A1jyXYZsNlRjfep+GV0lvFmCQZizLtaKV4Her1q3cOZDJw2TsiOs8B9SfK+gXakK/twg767TVzu
 GJ2gA7FtPKhHvoCL1j0JZRWcztS4sPcyecewa1ftwEzQJAbI+ZoEYEQbgzO4z1YBcbIM1TIR26m
 lEM36yHMuf3fv445mxgLpuCGkQIUvfW2eT/dnpOMPgIAn7LYYmxRyKITIxiFMS5VUSyFLMtd+WI
 b6Fa2R9/Wr7kCot+Lz47Z1BXbfwyfFT810voeNb8057NsNTcqVZ+fhLx0d1SzcrWvUjD/M0xA9i
 6TOCiqQ1XS01Ph+ptDxpjjvJgCxFyiFzxrv3GAix5Dc+Wi20F/12g+jgb5rWxlxww1Pggwoum/Y
 ilQ9xI534Jqqu7IuSGjphKw6lsQv60H3kjXDDp+N3qK0WwBSuy4=
X-Proofpoint-ORIG-GUID: COcD4e5VKmQYOsC8ZQpv24fQM-SeNbtR
X-Proofpoint-GUID: COcD4e5VKmQYOsC8ZQpv24fQM-SeNbtR
X-Authority-Analysis: v=2.4 cv=Zovg6t7G c=1 sm=1 tr=0 ts=68e0eeae b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=QTUsDGnIpaBiuu3vvHwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13625



On 10/4/2025 4:22 AM, Vadim Fedorenko wrote:
> Linux 6.18 has FEC errors histogram statistics API added. Add support
> for extra attributes in ethtool.
> 
>   # ethtool -I --show-fec eni8np1
> FEC parameters for eni8np1:
> Supported/Configured FEC encodings: None
> Active FEC encoding: None
> Statistics:
>    corrected_blocks: 123
>    uncorrectable_blocks: 4
>    fec_bit_err_0: 445 [ per_lane:  125, 120, 100, 100 ]
>    fec_bit_err_1_to_3: 12
>    fec_bit_err_4_to_7: 2
> 
>   # ethtool -j -I --show-fec eni8np1
> [ {
>          "ifname": "eni8np1",
>          "config": [ "None" ],
>          "active": [ "None" ],
>          "statistics": {
>              "corrected_blocks": {
>                  "total": 123
>              },
>              "uncorrectable_blocks": {
>                  "total": 4
>              },
>              "hist": [ {
>                      "bin_low": 0,
>                      "bin_high": 0,
>                      "total": 445,
>                      "lanes": [ 125,120,100,100 ]
>                  },{
>                      "bin_low": 1,
>                      "bin_high": 3,
>                      "total": 12
>                  },{
>                      "bin_low": 4,
>                      "bin_high": 7,
>                      "total": 2
>                  } ]
>          }
>      } ]
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>   netlink/fec.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/netlink/fec.c b/netlink/fec.c
> index ed100d7..32f7ca7 100644
> --- a/netlink/fec.c
> +++ b/netlink/fec.c
> @@ -44,6 +44,64 @@ fec_mode_walk(unsigned int idx, const char *name, bool val, void *data)
>   	print_string(PRINT_ANY, NULL, " %s", name);
>   }
>   
> +static void fec_show_hist_bin(const struct nlattr *hist)
> +{
> +	const struct nlattr *tb[ETHTOOL_A_FEC_HIST_MAX + 1] = {};
> +	DECLARE_ATTR_TB_INFO(tb);
> +	unsigned int i, lanes, bin_high, bin_low;
> +	uint64_t val, *vals;
> +	int ret;
> +
> +	ret = mnl_attr_parse_nested(hist, attr_cb, &tb_info);
> +	if (ret < 0)
> +		return;
> +
> +	if (!tb[ETHTOOL_A_FEC_HIST_BIN_LOW] || !tb[ETHTOOL_A_FEC_HIST_BIN_HIGH])
> +		return;
> +
> +	bin_high = mnl_attr_get_u32(tb[ETHTOOL_A_FEC_HIST_BIN_HIGH]);
> +	bin_low  = mnl_attr_get_u32(tb[ETHTOOL_A_FEC_HIST_BIN_LOW]);
> +	/* Bin value is uint, so it may be u32 or u64 depeding on the value */

typo depeding -> depending

> +	if (mnl_attr_validate(tb[ETHTOOL_A_FEC_HIST_BIN_VAL], MNL_TYPE_U32) < 0)
> +		val = mnl_attr_get_u64(tb[ETHTOOL_A_FEC_HIST_BIN_VAL]);
> +	else
> +		val = mnl_attr_get_u32(tb[ETHTOOL_A_FEC_HIST_BIN_VAL]);
> +
> +	if (is_json_context()) {
> +		print_u64(PRINT_JSON, "bin_low", NULL, bin_low);
> +		print_u64(PRINT_JSON, "bin_high", NULL, bin_high);
> +		print_u64(PRINT_JSON, "total", NULL, val);
> +	} else {
> +		printf("  fec_bit_err_%d", bin_low);
> +		if (bin_low != bin_high)
> +			printf("_to_%d", bin_high);
> +		printf(": %" PRIu64, val);
> +	}
> +	if (!tb[ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE]) {
> +		if (!is_json_context())
> +			print_nl();
> +		return;
> +	}
> +
> +	vals = mnl_attr_get_payload(tb[ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE]);
> +	lanes = mnl_attr_get_payload_len(tb[ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE]) / 8;

8 -> sizeof(uint64_t)

> +	if (is_json_context())
> +		open_json_array("lanes", "");
> +	else
> +		printf(" [ per_lane:");
> +	for (i = 0; i < lanes; i++) {
> +		if (is_json_context())
> +			print_u64(PRINT_JSON, NULL, NULL, *vals++);
> +		else
> +			printf("%s %" PRIu64, i ? "," : "", *vals++);

"" -> " "

> +	}
> +
> +	if (is_json_context())
> +		close_json_array("");
> +	else
> +		printf(" ]\n");
> +}
> +
>   static int fec_show_stats(const struct nlattr *nest)
>   {
>   	const struct nlattr *tb[ETHTOOL_A_FEC_STAT_MAX + 1] = {};
> @@ -108,6 +166,20 @@ static int fec_show_stats(const struct nlattr *nest)
>   
>   		close_json_object();
>   	}
> +
> +	if (tb[ETHTOOL_A_FEC_STAT_HIST]) {
> +		const struct nlattr *attr;
> +
> +		open_json_array("hist", "");
> +		mnl_attr_for_each_nested(attr, nest) {

"mnl_attr_for_each_nested(attr, nest) {" or 
"mnl_attr_for_each_nested(attr, tb[ETHTOOL_A_FEC_STAT_HIST]) {" ? please 
check it

> +			if (mnl_attr_get_type(attr) == ETHTOOL_A_FEC_STAT_HIST) {
> +				open_json_object(NULL);
> +				fec_show_hist_bin(attr);
> +				close_json_object();
> +			}
> +		}
> +		close_json_array("");
> +	}
>   	close_json_object();
>   
>   	return 0;

Thanks,
Alok


