Return-Path: <netdev+bounces-99591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 569AB8D5682
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9407B215A2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C611117D34C;
	Thu, 30 May 2024 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="uVyaAPh/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2094.outbound.protection.outlook.com [40.107.237.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1955896;
	Thu, 30 May 2024 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113099; cv=fail; b=T5hoPqo7nG0Z8ryHRo6KuV1GKkRIMW8iUQ8jB7GVaVTjQsDmWCIJEyy/GgIq/IJuo1j3bquxYOBi6yQFbAcLike821+75mQN6IjWGfwnMndKsNYzzFolPkrM5v7e/GsvtQTwcjHwD/VERhDOf3P1/CFlKzdjAKjUwXvYDvaS8oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113099; c=relaxed/simple;
	bh=De6Hx00g0oSi7fz59Ss897s8ju6+w298pVp7oBnM7KY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PeG339+SIhByXaSt1+hy+0jenxuX+raxKIM7m9m3XwOEZ8xhxi1dMEdU2Bk6qGWcWjfAsSoEbSo7SLEWeQRGbHlPxxnT9qkOTbLTp6O4/LiMUW8X/E8l+ou7g08QMcbS4j5rKV0PwETR4GEi1RwaebMoiWby6XnRaYPnNo1Rseg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=uVyaAPh/ reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.237.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9zX54qeLBvM8zTguSmUnYeeZKxoQa5mnavTqaUWuiNj0DziN7xAD3jKChg9Th0aisY8Pu7rKEjl046ocDnWcd/pcbD04G9Qcwj3LCLl3JpQTd+A/OPEpBPSkvjrChsUEZXpewX0/KKn1UqFpCkh/Fys5BGWEvdyKfwfKh4L7yJNPhEonPDzkOyZRNL7nz4fTcU0rHUGa9v2oKnS8FTWMfqNNxuOwvWrGLzmPOCxYFPlBslhC5R/Rlw+GDIVXLDFf223IK6a7GrB4s8Tyd2HGiFT4wfRFAtuTiM5CbYm60lSHR8T3DYQjhuUf1Zhae9xMi52wknLDe6SmZnLt1uXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNykjmx7RozDP9bIjOJ2xc3jXrNA/ybCEND4gAymjyk=;
 b=c2pAN9LcfoDU0P7Ob5NLP6RjcHQvoYMfZyaH1eAlec47hSt144HB0U7ujit/jvqgqgRO5UaOMFrE0PlkQ2w05z38UfLkg5jhBEUVnk254+OJQJjeQnR5J3FXdO8Gh4vdVL0FQ770KTG+KQTHGbq2i2h0MUUw0WNjlSBB/uWdhrq9CcDnGzTK49yqyMNqGWCCRVttVoNj2dNEEtgqxICbbz6Iv7Y2CP8drK03rSnHwgHhJBxX5PsgimOxEY64XFNA2ziK8Pvt/8IXBTEOc3bVrMLYSz860KVz3ADeyXJnPknr+eAcZJCOqkYnTS2xwx5tok1dfImnB7K5nV5mM1ohEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNykjmx7RozDP9bIjOJ2xc3jXrNA/ybCEND4gAymjyk=;
 b=uVyaAPh/g/ZyD9GtR/lDwNfckYDyG4rJk8YcGzkfzZDfLm+c1cEXh2Jg4A1pt80iYDTLPKpCnI8+l95cLupGdMOQ5zDHLG1HWUcUeyijdx0DheNqyoLhC1UfmJKTHkQTu1zIEydNmgDJ0l+RkzG0qjmqwz+QE2FQTvuSCfNCiMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 CH3PR01MB8630.prod.exchangelabs.com (2603:10b6:610:17e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Thu, 30 May 2024 23:51:34 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%4]) with mapi id 15.20.7611.016; Thu, 30 May 2024
 23:51:34 +0000
Message-ID: <cfb8307f-39cc-4aaa-a394-295234dbbe95@amperemail.onmicrosoft.com>
Date: Thu, 30 May 2024 19:51:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
To: Jakub Kicinski <kuba@kernel.org>, admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-4-admiyo@os.amperecomputing.com>
 <20240528194557.7a8f522d@kernel.org>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20240528194557.7a8f522d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0037.namprd20.prod.outlook.com
 (2603:10b6:208:235::6) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|CH3PR01MB8630:EE_
X-MS-Office365-Filtering-Correlation-Id: 387d03c0-3349-4b1b-3d73-08dc8103700a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjBXSjVBbCtmMStxY3Q2a2w2Zjk1RVpocFU3VzV0S1Y1K29YUGVHa1FWY1RV?=
 =?utf-8?B?RjF4V1dDdlhYc1pDT3lmbXU4WjVXNFg3UWV5VzFrdFRoU2ZSK09JY3plVzFI?=
 =?utf-8?B?amZWTEE1TU40aWxsVmc4ZElkdnNGUXh2Yi8zOHh4bFJXeENsT1Z1Nnh4ZlBx?=
 =?utf-8?B?SW41SWN2ekxKZ3RVMlY0QjlhVFByOTdQdnQvNGdiUzVvWlJ0QlYxbGhFL2ZE?=
 =?utf-8?B?ODQ2Q1A2dWVKdkJ5Z3BFeHBFaGxObW14NGhMZUVJMmJCQ0w3SSsrUk1DZmYw?=
 =?utf-8?B?SlFzMi9QcWRXblU0eDlQOGdUWXlvRm9VY09GSllOcnVOd3hwQ3dGemxPYkF3?=
 =?utf-8?B?Vk95SytyaDNha281ZW5Ed0x3ZGJMODd5MTJRS0hrQzJQRTZkczJKQ1FwU1B3?=
 =?utf-8?B?d3pTYmVjcXB4dnE1a3ZKaHVwb01KSVhwSEpzVDN4aENTVmtxTFFKeVU3eWxk?=
 =?utf-8?B?OVNvTXRJU2JQUFlMYnNSV3VtVU1wUkRoQXMyTXlXcXV6YW4rRFVnNi9NcEVm?=
 =?utf-8?B?OVg0VGRpc29HdkRycWFLNENNazBuend4NGZUek4yN2Vzdi8ya1Z1UmJvQkNQ?=
 =?utf-8?B?VG84UGpOTitDdUozT2o2dHJuelpsLzJiN0FNN0RIR3gyVGpRak9HTktNVmx1?=
 =?utf-8?B?SE5BNmhQRE1SVyswY2x5VFdSQU00ZVhDdGllQmtXZnVWOVZCVE1zaXI2a3Ji?=
 =?utf-8?B?VDlSeXVBUTVEeFArZlMyZVZwRE5zUTg4dW82MUp2Z25mVUM1clMxOVNDVnJy?=
 =?utf-8?B?ejJINm51ZkFiM0hEdk8yd0Q1YS9XaDl6OWpxRVUrSERWR0VPK1JrV01ONUE3?=
 =?utf-8?B?YXFiRWlGRG84cyt5a0x2V3RDRitJSWZWZzJDQ0pjM2dXcUNzTWRHdUlIR0Mr?=
 =?utf-8?B?SlVyODdaT1BkOVZOWjZaeUpaOHpEWDUzMDhWenpvRFVWVUx2L3RQKy9veVRR?=
 =?utf-8?B?VVRvalBHbmxwUHFOM2pFelJsZkkzNmJibjVaSlRUY291cGlBdVl0azJ3ZE1M?=
 =?utf-8?B?QWpLZnFBNUFtYUFLOEtMOHdqK0Ura1RnMDB5ZjhDNlM3YWJmSExBUDJiVWNL?=
 =?utf-8?B?MWFmSkYrcDhHOEJXRjJicTZSWW9lQk9ocWVKWHkvZzE3cWtkajY5TUhkcHd4?=
 =?utf-8?B?UEFVYzE3WFV3TVVCczlXQk10Uzl5K3hEYmF0T1A5ZjkvblhhQmY1dTc2SVlW?=
 =?utf-8?B?N3ErYmtpNGE0M0tiZnc2ZCtxWjQ5RXJ0TndYc2FGdkZ4RjJmQjJHUE5NRUxJ?=
 =?utf-8?B?ZFBBSnRPZHFEWmhFVElBSjdvNVRxZWdjUGNPTm5tZkxLblp6MmhZLzJ2L2Fh?=
 =?utf-8?B?L2FkQU1mUkpJaHM2VU1tK040MDZKTDVBejFKbE8vMXdNQWRVeU43cmtlZXlB?=
 =?utf-8?B?OTBFb2I5emJ0Y2Y1Um5GdHlwWWlJNGVNV3ZEWjlLcVpkNTZJSEtVRWdsbkVV?=
 =?utf-8?B?WktONXdjb1daKy9uUU9oQlNKVTJCT1EzZzQ5b3NKVWF0eEljMUFpR2RXYmFD?=
 =?utf-8?B?emdIK29RYzBHS3ZQUzluMXBMY1FCNkdTbWhTaXhyRUxIRm50cDN3OEFvcG9r?=
 =?utf-8?B?bGdQdzZPTXV4SkEzK2xaNUpyUkc2Yjl3TG5TRzVmcGZBNWxreEFZaWhuNk1F?=
 =?utf-8?B?K1JOY2N3NENBd3grbDdMQTZ0RnhRRWQwamIxOW5KNkJlVUdZSFZSQmtiSHdi?=
 =?utf-8?B?VG9pN1hqekJXOWNSM3VFN3NwbkdpQ0VEUkM2MzJxc1I0VDU1Ti9DMGhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW5zV2JFL3VKdHlnd2FneVcwZzJDTlRhc01qbUZhbThiOExVOURxalNQblJj?=
 =?utf-8?B?cEFNTzVuQ2VTekJ6d2pHcWE3WnBGY3djR3RrUUh4TE9vT0VoalVIaGRXSkFt?=
 =?utf-8?B?cXhOK2hpakp3eVFBdTVJRjE3bWNtcGFaQkhYUlNkRWpySTRTQkJPK2NnNlY4?=
 =?utf-8?B?OE5FU1AxRDRCamdaZ3QxL255NFQ1SWVMcXFhSjJHOVBuMVprcUZsempuOTJr?=
 =?utf-8?B?eE5aUDM2ZGdhdlltR2xqb0NlTWZ5azN2ZDdxSWFnRGRJVW9ZdGg1WVllRVhX?=
 =?utf-8?B?Um9TZS94d0ZEVGFZTThFWndGb2hYdmZLbVRTSFZXMFhOUnY0VmtNZjZ4WEgv?=
 =?utf-8?B?UXFkMmFGdGZwNERXV0tFZUhoMFhnVkl3M1lIK041Vmw4Y0ZwK1kvUFlWSFpY?=
 =?utf-8?B?Z0E3TDJ4cXFLcWJ3eThEZElKSDBmNERuMmM1RElsbGJPd1lqNk9Xd0hkdll3?=
 =?utf-8?B?Z1N1eWJQRjFkRWNtamlnV1dtY21GRklqekU2U05odVkySWdhUTBDdUZvbDdt?=
 =?utf-8?B?NGRMRGxpT3ZqUGg3dmJrRVhnMDUwRG9ONDNDVjNNcWtjeFV2M2dpdVhTRnA2?=
 =?utf-8?B?OUtYL0FubTNPMDRDZUZuVURwRERXZE13TExzR0dJUW9iZHR6MC80aFhBbS9Y?=
 =?utf-8?B?dEpmbEp4aG4rSHY2cFZCalZGUzRqTnBZY1dYTGVKNnFaVjZyOER1emZTVFlv?=
 =?utf-8?B?MXhHYk9DVDVwazdob01QVnBWeEx4bjFpMG4rQjU2b2RkamJmVHNFaENQbmNM?=
 =?utf-8?B?MnNLeGdPZ3AxRW5sUWg0UUdKb0JubTA1d0FBYU9NNDFpYk41U3hEWG5yQS9M?=
 =?utf-8?B?NXN3eHFtcGNWVmV3bllwZjFTWmNETmRPRzlsalRjNkdpZ205SUxLSndKQ1Mz?=
 =?utf-8?B?RURMQXdvYmdpRDIzTHZXeGlocWpRSkF0OGF3aVpOSENkVUFILytZMFpEcm9N?=
 =?utf-8?B?a3VHclZNRlJuUXRQTXBPQjhNL0lWUDZNTFEzdHlJVHR6UU5nSjBGUUhEaFA4?=
 =?utf-8?B?alR0NWRBRm9JbEpVZkpKa2tUSU1jTHFNVDN6YjhCTUxLOThTR3hVdVdXQ1JL?=
 =?utf-8?B?UGVZampmd1BzZ2VVRDhidGlQNlpHQ28yRmtPNllPVm9JRlR1ZGxka1BFZ3J5?=
 =?utf-8?B?ODdHYng3QzlDVkR3N243cGZGU0d3elVUbURhbXRnSjJzT2N4ZnNjZURGVXVU?=
 =?utf-8?B?aU9QZFZiekRDVTh6NWZ5Nm5tdkRhM2gxdW12MlR2cmhiaEk0R05Ddm5KSG4v?=
 =?utf-8?B?WTZNaGRqWGFEWFI2U25sUDRYNkttZWl3QmZ6OURhYUZhU2hhcnl3dGlRYk5L?=
 =?utf-8?B?Uk8yblZDWXdqZm1GSzV1NVhqamZEZlhTOXZzRkp1d3RFUkQwdUFIMUJBREtn?=
 =?utf-8?B?ZlJET1hsMllsd3huemh4dk1BSTZGVnMyemwzWThqaFl1NVNrZE1WZFNJNmhN?=
 =?utf-8?B?Z3hjb25yQUdKQTcxbHdhYkJCZzM2Q3VjakRqdnk5NTRuV1hRZlBmLzBiMDhs?=
 =?utf-8?B?eU9Rcnd2UE5pZ1V6Uk12bzFRZnNkOVpFYVpxRGdVMlV4MUxPbDgyUVRwNFY4?=
 =?utf-8?B?WDU1SHRkV1pNY21qSVRNZHNjbUtzc2srN0dXdFVYSFB1SDViZ2NxRmYxcUlC?=
 =?utf-8?B?V21JRFhFVHFST1R5NFpCZFVqcjl5TzBEVFVHa2FHay9pOEVaektqUGhiS1hr?=
 =?utf-8?B?eGgzTTlQNFdwZ3JBb0FldmZGMVhxTWs5RVQrZWRNTTFaQmVYaHQyam5LVWho?=
 =?utf-8?B?STVJOU96MVdlUlY2R2lUK29Jd2V6dlVWMmFqZ0Y2aWFuSWZ0V3RLQnY1blV3?=
 =?utf-8?B?RHFRbGV3NVMwY0pJR2FsVzJ6MzJSY3E2NjZ3YVV1RUpYWFlMUXlXRGRnc2wv?=
 =?utf-8?B?ZEQzTkhSV0lWUjVmVW5uZ1NqdE9UdWx5bUV3WVNuajkzU2dlbUhoRGxIODk4?=
 =?utf-8?B?QWhYdkJVSHVYUStxalYzd3BkVmNZWnB4MzNscFlnNGFqK1N3cVcxOXVlc2p3?=
 =?utf-8?B?Vmh3a3J0WUh6Q3RTbUUxMldyQlZLTXpNbkhvamErZjkzTFVpeDFQeUN4Y014?=
 =?utf-8?B?b1BrK2FJL2ErOFJTbVZjc1J0dHpDQWRMZmwvdnQ5MGZZc0lXQTI3NjFoR3dH?=
 =?utf-8?B?Z1lhM05mVytEbFpLcU1ud09pcE83VDJFeWd1RUVWRW84UXBDWUpYRmhtYmpS?=
 =?utf-8?B?L21YOWFuaTRTZDNJT08xQ01hSlE4NU8zWmd0THlPSkVGSXFaN2MwSGJrYnNQ?=
 =?utf-8?Q?GbZUnmvTCDMETCtaqanA8davI7dUClaAHzDul5RQzM=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387d03c0-3349-4b1b-3d73-08dc8103700a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:51:34.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FEfoY8zQ9je6bdgKxEYheRnZPiZq0UdsZHWrqaOus8uVJGeee2UtB+mXmnE9WO5h+OYoq4RjlrMTs0e5AkP6URDmK5oxF84rbfJMiag1kT1cRSCqgqHF0jDj82ENM/C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8630


On 5/28/24 22:45, Jakub Kicinski wrote:
> On Tue, 28 May 2024 15:18:23 -0400 admiyo@os.amperecomputing.com wrote:
>> From: Adam Young <admiyo@amperecomputing.com>
>>
>> Implementation of DMTF DSP:0292
>> Management Control Transport Protocol(MCTP)  over
>> Platform Communication Channel(PCC)
>>
>> MCTP devices are specified by entries in DSDT/SDST and
>> reference channels specified in the PCCT.
>>
>> Communication with other devices use the PCC based
>> doorbell mechanism.
> Missing your SoB, but please wait for more feedback before reposting.
Sorry, must have dropped it when redoing the last patch,  It was on the 
original and will be on the next version.
>
>> +#include <net/pkt_sched.h>
> Hm, what do you need this include for?
Gets the symbolic constant
>
>> +#define SPDM_VERSION_OFFSET 1
>> +#define SPDM_REQ_RESP_OFFSET 2
>> +#define MCTP_PAYLOAD_LENGTH 256
>> +#define MCTP_CMD_LENGTH 4
>> +#define MCTP_PCC_VERSION     0x1 /* DSP0253 defines a single version: 1 */
>> +#define MCTP_SIGNATURE "MCTP"
>> +#define SIGNATURE_LENGTH 4
>> +#define MCTP_HEADER_LENGTH 12
>> +#define MCTP_MIN_MTU 68
>> +#define PCC_MAGIC 0x50434300
>> +#define PCC_DWORD_TYPE 0x0c
> Could you align the values using tabs?
Will do
>
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_dev;
>> +	struct mctp_skb_cb *cb;
>> +	struct sk_buff *skb;
>> +	u32 length_offset;
>> +	u32 flags_offset;
>> +	void *skb_buf;
>> +	u32 data_len;
>> +	u32 flags;
>> +
>> +	mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);
>> +	length_offset = offsetof(struct mctp_pcc_hdr, length);
>> +	data_len = readl(mctp_pcc_dev->pcc_comm_inbox_addr + length_offset) +
>> +		   MCTP_HEADER_LENGTH;
>> +
>> +	skb = netdev_alloc_skb(mctp_pcc_dev->mdev.dev, data_len);
>> +	if (!skb) {
>> +		mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
>> +		return;
>> +	}
>> +	mctp_pcc_dev->mdev.dev->stats.rx_packets++;
>> +	mctp_pcc_dev->mdev.dev->stats.rx_bytes += data_len;
> Please implement ndo_get_stats64, use of the core dev stats in drivers
> is deprecated:
>
>   *	@stats:		Statistics struct, which was left as a legacy, use
>   *			rtnl_link_stats64 instead

Thanks.  Was not aware.  The other MCTP drivers need this as well.


>
>> +	skb->protocol = htons(ETH_P_MCTP);
>> +	skb_buf = skb_put(skb, data_len);
>> +	memcpy_fromio(skb_buf, mctp_pcc_dev->pcc_comm_inbox_addr, data_len);
>> +	skb_reset_mac_header(skb);
>> +	skb_pull(skb, sizeof(struct mctp_pcc_hdr));
>> +	skb_reset_network_header(skb);
>> +	cb = __mctp_cb(skb);
>> +	cb->halen = 0;
>> +	skb->dev =  mctp_pcc_dev->mdev.dev;
> netdev_alloc_skb() already sets dev
>
>> +	netif_rx(skb);
>> +
>> +	flags_offset = offsetof(struct mctp_pcc_hdr, flags);
>> +	flags = readl(mctp_pcc_dev->pcc_comm_inbox_addr + flags_offset);
>> +	mctp_pcc_dev->in_chan->ack_rx = (flags & 1) > 0;
>> +}
>> +
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
>> +{
>> +	struct mctp_pcc_hdr pcc_header;
>> +	struct mctp_pcc_ndev *mpnd;
>> +	void __iomem *buffer;
>> +	unsigned long flags;
>> +	int rc;
>> +
>> +	netif_stop_queue(ndev);
> Why?

I saw this in other network drivers, both Ethernet and MCTP.  As I 
understand it, without stopping the queue, we could take another packet 
before this one is sent and we only have one buffer;  that said, it 
should be protected by the spin lock.

I am tempted to leave this in here, but move all of the statistics into 
the spin lock.  Is there a reason to not stop the queue?

>
>> +	ndev->stats.tx_bytes += skb->len;
>> +	ndev->stats.tx_packets++;
>> +	mpnd = (struct mctp_pcc_ndev *)netdev_priv(ndev);
>> +
>> +	spin_lock_irqsave(&mpnd->lock, flags);
>> +	buffer = mpnd->pcc_comm_outbox_addr;
>> +	pcc_header.signature = PCC_MAGIC;
>> +	pcc_header.flags = 0x1;
>> +	memcpy(pcc_header.mctp_signature, MCTP_SIGNATURE, SIGNATURE_LENGTH);
>> +	pcc_header.length = skb->len + SIGNATURE_LENGTH;
>> +	memcpy_toio(buffer, &pcc_header, sizeof(struct mctp_pcc_hdr));
>> +	memcpy_toio(buffer + sizeof(struct mctp_pcc_hdr), skb->data, skb->len);
>> +	rc = mpnd->out_chan->mchan->mbox->ops->send_data(mpnd->out_chan->mchan,
>> +							 NULL);
>> +	spin_unlock_irqrestore(&mpnd->lock, flags);
>> +
>> +	dev_consume_skb_any(skb);
>> +	netif_start_queue(ndev);
>> +	if (!rc)
>> +		return NETDEV_TX_OK;
>> +	return NETDEV_TX_BUSY;
>> +}
>> +
>> +static const struct net_device_ops mctp_pcc_netdev_ops = {
>> +	.ndo_start_xmit = mctp_pcc_tx,
>> +	.ndo_uninit = NULL
> No need to init things to NULL
>
>> +static void mctp_pcc_driver_remove(struct acpi_device *adev)
>> +{
>> +	struct mctp_pcc_ndev *mctp_pcc_dev = NULL;
>> +	struct list_head *ptr;
>> +	struct list_head *tmp;
>> +
>> +	list_for_each_safe(ptr, tmp, &mctp_pcc_ndevs) {
>> +		struct net_device *ndev;
>> +
>> +		mctp_pcc_dev = list_entry(ptr, struct mctp_pcc_ndev, next);
>> +		if (adev && mctp_pcc_dev->acpi_device == adev)
>> +			continue;
>> +
>> +		mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->out_chan);
>> +		mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->in_chan);
>> +		ndev = mctp_pcc_dev->mdev.dev;
>> +		if (ndev)
>> +			mctp_unregister_netdev(ndev);
>> +		list_del(ptr);
>> +		if (adev)
>> +			break;
>> +	}
>> +};
> spurious ;
>
>
>> +	.owner = THIS_MODULE,
>> +
> suprious new line
>
>> +};
>> +

