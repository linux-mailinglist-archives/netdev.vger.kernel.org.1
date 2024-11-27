Return-Path: <netdev+bounces-147593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7856A9DA712
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 12:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B421635D1
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721B81F9A80;
	Wed, 27 Nov 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4nyLa3yF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C71F7574;
	Wed, 27 Nov 2024 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708030; cv=fail; b=RaEZoC6oSDoQdpykUCa8ZOEKeTU6fLdGl2FEjtdOldcFpNhFCGmzPT7Uk0Ym1RVby2sZPqMo04idnfeJyda+kJ/XSHlJQeKMWzWa+SSuIvFc+DQgkXKodLjUJmW+Yzw/0E92GhCpfcR+J6/zCgMGIxJ3L95fRRww+Y1QZsJV0Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708030; c=relaxed/simple;
	bh=GXihAqo851n/Y7x3KzSwmwtBs+WYDhCFnJmWv1TKYQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ou+lNXkH8J1Bj9f8VkBHrby/tfvgkM6026PG9Jx8nJHPp37Tv2dPYRpgw3WdaNhMVRmVoAteOlq2q584CcTTfjGK39UD8t00xxh9y+gr+VobCYrzz+Zu8+L+9zcq0GG8hwYCUK9rrPtez6KQxEqEi2FjqvrhkT2wWsEiQXgpCFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4nyLa3yF; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkUMLLGHExucvX2to/3PDX56ictQmJ+Jtsw/eJqwO5ejNGa7On/1WCTlSAY+OKAe0cfxoW7vfQgrSwUt4CwbBy7vArRPgxEYUpRLdpF+aYqmKDh5+2beDVnm0jEDsEetHWAu33mNpXS/jm8x2aF8evSf/Q9TmWmHdKPtpRcnUg2JVCKdPD7WfuXAyhYQa8C20iI7jt//qJen6ZGiI0xjHsuZN334laU/WI5Mmm/6sFxs3jsc87YhMn+gWep2MbCNSTr/gtbnVBPcuJr85u0phjXRMkvouyhg3NJjhcr7kFMbg4vrjsIBZOB02A25tsvnhlGdYWA/N8X41mJRHqKUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEM8aoIFdV0QWM3JVQEeHl7KXVbdXUZrPwuBhv4SnDc=;
 b=FKFOruPuEmGd4jYxbHD4tzJW0EGuEW2JM4f9EsKJiJXHxyiN4cMs/AAHc5aZzL4WkFB360aPy+SfQgQaGdAC3QT2qt4tdZdj98QjlxfdsGkZPIr4urak7dNBuR5Djz9G2nu6/aAVGtRpzVuAW9GFd1VLVRRsjjl7m1y7KacLxfO7IEJhNAWuyW460BcpBZV/BLJS6IjdSqEVDHTMqQAFQSSrCa5K8SYSk6q1QHG1P2AbeV55ILa8fb0Ppu9xj+VBr9G5aNYn5sPHcbiETsjz61RbypJ876pnwx4u4Cba6CRawb9Opdw3HffzzQxGHQGBjQeIS4p+8I/Y9iwMc5+Dpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEM8aoIFdV0QWM3JVQEeHl7KXVbdXUZrPwuBhv4SnDc=;
 b=4nyLa3yFaBG9ni5pUucVlJTyu5E7v0RCQrVBKUo2jhyiQFp1o9XtUYVn5Nmsl3YPuPgrz9L2hSliDibHJtVnGZWQzXAYvcvWIaO5/dEp0J7XvJWwvCOj4E1R3ZrEmFttWRxARLoDzwxrS786rAo7ac+HjUMiAdQ3ng0gTWCSgSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 11:47:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 11:47:05 +0000
Message-ID: <afc9841a-aba2-f413-2844-dd24bb0a5fde@amd.com>
Date: Wed, 27 Nov 2024 11:46:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 06/27] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-7-alejandro.lucero-palau@amd.com>
 <Zz-1Z6fzAbl_RCAZ@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Zz-1Z6fzAbl_RCAZ@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::30) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: f50823bc-c458-469b-1c3b-08dd0ed9372e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGVtL0x0cmhHZ3lvMlhieTFpWEFTTFhPcHpFSGNLVU95UXIvK3JIY3ZwR2FX?=
 =?utf-8?B?bkNQMEpXaVRtZ1Q0YWFWeTlLa1RQNDBWN0xhSWlNd1pQN0kzdmJUclpzbGRB?=
 =?utf-8?B?bU8xeG9WcVVrNFBzS0VuTEEyV05SeWJvcmxldDJPNWlBbm9KTWJZaHArTlE5?=
 =?utf-8?B?d3VNRlo4RkhDalRwK1JwQnkxM0p2UWpGTjNnOEx3S2FEeGc4MzdpZjF4ZTJr?=
 =?utf-8?B?STU1cThTc3BuUXFYeVVUYnUwcjhreXBRK3IveXhMb0lQc1BHczdDZ1Vnemo2?=
 =?utf-8?B?K3NCMHZNVVErMGlTS252dWx3RW9rak1tNHZHaGsvZ0tOWXl6aU55blh1QVRS?=
 =?utf-8?B?eHJudHJTUWFTMXpvbUJid3hSZDdWaERHa1RwL0tNRmc5TmM0ZTV0N1oxZTg3?=
 =?utf-8?B?Vnk1dGpOaWllSUJLZ0tjdXE5c3dRRnRIOTdKWjhjejEwM1dxMWx3eHhwVVRO?=
 =?utf-8?B?dTZWMzNpK1FIZjNJTHA0Yy8xeFFIeXR3SzdYR29MUGdjb01pY2ExNmZpakFl?=
 =?utf-8?B?NzJrSGhvWHFCK2w5ZkVETmRjcUQzajRjNHlBamJ4QzR2YjZLdEF5NlpXalds?=
 =?utf-8?B?YjgyZWFsL0xycERDYmVrUUtTZEVCZkxabUJEQ2JsQW9URWZVbG96SkZ2YktY?=
 =?utf-8?B?NGd1aWUxOXUzQll1UDBVOFo3clVmOHFiZkRsL2FNQVJ1RDdzWmt5bVFzeTRO?=
 =?utf-8?B?ZzI1WWlYcFhzZlJtSHZMNy9yYjBnTmZuelpEZjF1Mi9FNjVVK0drblFSVGQ2?=
 =?utf-8?B?dWdDSDNkM09jT3hKV3BaRWRmRXNuRk5YTkhSN1N6QUh5c3NIYmxpRmRpdFRw?=
 =?utf-8?B?Ty9qMXhOMlVWUnR6N0laaS9FUFNuUndKNHhDdjZXK21KVHhhOFNsNWdnbzRv?=
 =?utf-8?B?ZFBBYjNVWkF5NWdxdnJnc3RGL0ZFYzFkU0dCTXpWa3FONHBVRndHVUs0QWI0?=
 =?utf-8?B?ZGY4LzFPWnliZUltelhiU2l2REQwblg3cUhFdlkxcGEzekRteStza2h5M3BI?=
 =?utf-8?B?ZkpLUnZtSmhDYkg3RHJyc3lpdHZYUHAwUytBZWxHQWlLNHNUWDhzRlVCV3ox?=
 =?utf-8?B?UVg0TGFZZVcreWJlMFBZb2h5ZEVHNngxeUZPZm1xOUZyTmVQcENXRlloMjg0?=
 =?utf-8?B?M2lMRkVoblNiVHZ1V2dFR05xbHlLcWJNZ2JZbHBpVFlGdStEcFMwRTVKM2ZF?=
 =?utf-8?B?SVBORlhLYkVDWkZZc3NjZnhETFpVeTBkWXFXWUlKeGNPZ0JjU0NEY0xId0VR?=
 =?utf-8?B?RS9OL0V2cm8vL2orQjB1YWJad21KOXo2N2pUbUs5eEJTdFhqTWFsZ2tTTUV5?=
 =?utf-8?B?dDRQaWFqQVJmMWkydm9RV3poMUs3Zzh1LzJWdzI2RW1nYVNJWTVuMG5jaHRZ?=
 =?utf-8?B?TTlkcU40Mm9od29RM3RQOU00Q3c3Q3dOT3lsb2pCdHBUYjl3QWVBQ1V1cTBt?=
 =?utf-8?B?Nk5uUGZkT2NRZndRY2tBZmpsQnV5UjFqSDZxbFJJcUROM09USHA1WWFNWlVo?=
 =?utf-8?B?azdQWTBKaFlzNEhjQ3E2YmFHWUg4T2d5YW5RVmdIRjBacXBzTm01VDdyWWZB?=
 =?utf-8?B?Wk54dEVLeFdyejF2SlhuMmNMSjU5TW9UNXRFRVF4UjMwendoOW5QUUhoSC9K?=
 =?utf-8?B?NFVMZm8wU3FXUEcxbFRkRkd2OGV3RWsyMDZNVWpFczl0Y0psdU92ekZ2T3dx?=
 =?utf-8?B?ZTlZbURXNlRCUTNIbmR3R2ZtaThJbzdxaFNjSlQ5SXluSjd6Yjl2UTV4NUd5?=
 =?utf-8?B?K3Q0UG9Na0Y0UHB1LzhXWmw3anBFKzBwRzA3Z0o3R2c2NDA4ZWFPZ1hhekI5?=
 =?utf-8?B?N3Q0dCtBcU1nQTIxZVAvZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjR3Q1pjUTREeWxZTnNGVUhNTEhORWJYeWJmeVZSYi9naVQ3Mm4wOGpGVEhh?=
 =?utf-8?B?dWdsZFFpU3FnUjN5M0RQSDRycGExT1JHdE9UN1lyTWcwSkJodGRHOVRwSnJ6?=
 =?utf-8?B?VFpJY2lpcmIxY2F4QnhEb1d0TjR6MXVrTHV1R3V2TkNJYkFjT1drd2VLeXFG?=
 =?utf-8?B?aGlQVFo5WGdGQjJRZkdGSTl6TERERjY5TURuZDlmR0RiQ1FxS3gyNFFkeDdo?=
 =?utf-8?B?dk56RktWOHFtbldCbHJsUzlPc0JYL1VxSXN3cUtTUHp4UzFZTVBrZTJoNC9W?=
 =?utf-8?B?SkdIanljK0tHeFBhL0dsQXBPQU5VWHZ6VFlxWjRHQWVMeHhBOG9FMGIwODBK?=
 =?utf-8?B?R3FoUXhWNkZ2ak9BaWRUVGlDTFZKUGdnYTgwVzNhdWZVNHVGUk5QQUlZM1JC?=
 =?utf-8?B?akRVNmZiOTEzcGM5VFZCcUdUQmdKSHE1dUlzT0tyU29TZFV2NWdsNzh1ZzQw?=
 =?utf-8?B?Ti9ULzhRSWRKRmY1ckt3UTNnWS9Vd3U0WXhRSnJnYnJZT2svUXpkcHZ1QndB?=
 =?utf-8?B?YzZXQ0t4U2VSV0duNjltNnNyTjM2NzBkQThmRHBSeWtLS1BPUTRLM2Frc2pS?=
 =?utf-8?B?S2FPOTVlUUFqeG5VaHFSUmkrbDVmVldEbVNhNFhKS2EwVUtiZmx3OUh1YkFP?=
 =?utf-8?B?c1k0Y3ZPSmozS2pRWVZmT0pObkNaZTQxWG9HZGhNZCtBV1FnRitsWDJRY0M3?=
 =?utf-8?B?TDJiaVVtZXpLVWdjbjkzVW9vVCtzNUR0T2tUcTlOSmowYzRmU0daSC9MdlVv?=
 =?utf-8?B?UUUyaWZtak51emtHQ1BpYVl2RmRCOUtJNVlPZTRQUzBLWlNwWmQ1ai9rMFB2?=
 =?utf-8?B?TlZncXZtemtSSWJIQVJ1NVAxTVlwblplOVo2S01oWGx0eEZHbXdNUHhZbG5y?=
 =?utf-8?B?Ym5sU1dzTGZNTVFZWGw5cCtlR2xqMUdwNFMxWC8wdENKN3VodWFncGUxWnBB?=
 =?utf-8?B?aTZqU28wZ3ovSHNnWGhBbUFDdzQxWUV1Y2k0bmtNTWxLaDI2MlZFSER0cEQw?=
 =?utf-8?B?Z090U05OdmxxbmpIVEpmS3lKVlBUU2hVbGQ2eHBlSjFrNnlNRTBIdTR3V1dt?=
 =?utf-8?B?ekhFR2JhRlhjbWhQdGpKejhoejBQMGpvaXVQS1pibVQ2TnRDb0xxVkFoNDk1?=
 =?utf-8?B?WlBVNGMwN3YrY3JrZEcwQ1VSd2hqVVRmN2NCSzgxWnZmMDczbDU2L0VGb2hn?=
 =?utf-8?B?UXVtM3I1VVJaK01pejZSRUN4Z2VMSzZPV0J2ODh5R3Z3a2NFNjdWWSt2SUNr?=
 =?utf-8?B?YVNRTkZDb3NWMmNWbzBibU9yLzVVaUZ1cUNkcHM0bkE4QWc2WC9MSWo3c3I0?=
 =?utf-8?B?OHpCVUNpa3IwVURzeDhzN0tzQVp1Vk5RdnRIYWJvS0hYNFlvdktvQXlYbjJE?=
 =?utf-8?B?bHl6TTRrRTdqTXgwbVdVYis4T3B6L2JZcTlXRzI3akxyQ3FmNWVhTC9FMjRE?=
 =?utf-8?B?KzVtazQ0M0NpdldxSnpjV0k2by9ubXlGdmZqc1ZZT09TNkJnS1h5NExoakhu?=
 =?utf-8?B?dHNoU0lxTmcwQlJpQ1hMdXFkdCtJdTB4alNramNobFJmRkdpdDlKQzA5Z3N2?=
 =?utf-8?B?TDNnb3ljc2dDVlRrVmdrQStGa2tSbmR4eGsvK2JTSE1PQ1liZVhpRVFlN25F?=
 =?utf-8?B?bVNDRjFTWTBUOUhvMXVya2tYdytKZnFXbVFVN1ExTjE1YmZsbWJ0cWIwa1li?=
 =?utf-8?B?N3ZaWk05VEgzbjlUQUZYNXpYRytVU3M0eE1QdUxPZjVNaXVVUkZTRmxBYndl?=
 =?utf-8?B?dFlzbzhIK2g3bXoyQUpuUjJFV2F6U1J6TzJ3REFVanNEOEZBR0QyNDUycG5o?=
 =?utf-8?B?azZiMmowQndnRnR1MFl1bXFkWm5ndGJxV1FhNlVmOVFoNXJnSUd1UkJSeURK?=
 =?utf-8?B?dnUyNXc3a2I5YitEYkhRZE51alpNbDlPL2wvVHlZSUY2RWtPTlZlcW9Gc1BG?=
 =?utf-8?B?aHkzTUFUMmYxVmxxb3k0M2ZRbEs4MDlzNmFJY1Vkalo5bEg2d254T2tZdjl1?=
 =?utf-8?B?eTlSdVkvVWVWek1sWmorWFVyaEplcTR4c3ZnNTRsd1E4dWJNd0JBc0tmQ0Nr?=
 =?utf-8?B?UzFRTGVlbTBCamJGWkxMbXFqeWhoYWpHZ05oVnRGMS80WTJoV0Y1TFNNWXV6?=
 =?utf-8?Q?s89zWTT50bzNbFWB3mhNjtZMD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50823bc-c458-469b-1c3b-08dd0ed9372e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:47:05.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y/gVk3wXjQUfymudsMzY9BcfJhxWO5lQTI+LBZMDNV8lJLaBid9FM79t85toqIGUNYY0HIIjQ3nDhXQDqHu/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113


On 11/21/24 22:34, Alison Schofield wrote:
> On Mon, Nov 18, 2024 at 04:44:13PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device initialising
>> cxl_dev_state struct regarding cxl regs setup and mapping.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  2 ++
>>   2 files changed, 49 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> snip
>
>> +
>> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
>> +{
>> +	int rc;
> maybe init to 0


It is not used before the next call initialising it, so it is not needed.


>> +
>> +	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxlds->reg_map, cxlds->capabilities);
>> +	if (rc) {
>> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
>> +		return rc;
> init rc to 0 or return 0 directly here
>
>> +
>> +	rc = cxl_map_component_regs(&cxlds->reg_map,
>> +				    &cxlds->regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc)
>> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>> +
>> +	return rc;
> init rc to 0 or return 0 directly here
>
>
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
> snip
>>

