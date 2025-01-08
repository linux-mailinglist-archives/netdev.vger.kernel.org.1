Return-Path: <netdev+bounces-156288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A878A05E1D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD583A636F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D902594A2;
	Wed,  8 Jan 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xC5CUqn3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC6A80604;
	Wed,  8 Jan 2025 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345515; cv=fail; b=p9ogR1TvvH0z5vcxtOUVySdn4Dn+iUl5dw+Uq18EFYurcoJJQKfneudL2ekjxsUCfqRHh1WuAYWbIrGR/d1sEGUtmEpQ/+fEk0rjTfAqbyZQx5Ynd8AZXVULMmcAR1Q082/rqNzgiSJ4PJWeKRpgYC9ObIdhMvLmDAuHnemkvvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345515; c=relaxed/simple;
	bh=ZuG7M3MwB6Ae245pxj3ChZpTqPljVIiANmayg800PqA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TTwMNADkyZEJjmk/NlfIo8+Aj6la9HeYiL8jlP6lFlIaVdiJvj0jqWb1y/hQtHINwA7qPa6NsdxrmnVtVAl6lT1rq8TWuCBQi61RySc4YOElTAtC757wu6goCtEWY3/l5Qa8/46d7L2xJBtStOBoz008zpi87bqHF5dWOBKPzyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xC5CUqn3; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg8zAlGF4k/l0g/ZrZKZajNRvEUihp3ettBsrWCcgiwpmws5mJv97tA8SYlOLg9zuvta0EJ0Db6IMuYWGJemfSPnMoEhSJ2+EebWCsmKX4dndq2JYadYUnOvUDmPDDoyuTuJbG2Wa9qculswQU0n7nRJJDdH+sh9DVF6AOdVvxzdM6XVx7D2/rpiTynjjSnHhYhyB9cwYsynHEEDhyit+JUg+bmdgZDFVALp7OfLT91jJ0RuS2HxhY0dRLhAmGLldFJ/HXMTqvh7bD405LcR7CCwqzmUAPF5OYNZ2c492Z7vYNymOeF5tQAzy8D2++ozb4mVkin+zzqQSTmyqNbJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCSmwc6a0kmexdC2vVZEfPN98fLFelN1rZ4tgbGFj88=;
 b=GJ0pB/UMapKA2zKcKG7n1KbUEcgtBBviF6BE5Ie6cuWckbHZcipzMc/RvTLCVwKE6bwVUcS3cQYVeB2pyyGwJY4kbF4hvNrMwym0vttXTRrTa4ARWlPu3IuzWoAOpl7G1Ksf+YNi+6CL5e5QBCfKZvHfDdbL92e+FuZdrtzPFBi+QmCEQ8/tLWf+AX98Beh44omRBbvEO1WmfAhgmxL7rXxeWadWjCj2qn+Hd3P22Wdywufl0dvYcXcZhjEatn5UloHbVE+z9l4Rlg8+t5iPOeAvV/K9/H9kHHvn45cj9e6/zMGZUp9l434wf0s0zJIpyD1uUii7t+uouhIRhRYQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCSmwc6a0kmexdC2vVZEfPN98fLFelN1rZ4tgbGFj88=;
 b=xC5CUqn3aKbMSGtfD9ELdXoZPfEKRoB6Wp7DL834ffbyI5mA6cvn5QC4DDqFXYsAADeOtZbsQX0cTVo4xCPEbxzM+Uwem+ODecQapcbwBrvXDO3D1z/nfvSU041J3f6MQ9gv4IoRxFg6UITBGJ9C8hXZdiiSyfZ+iUy1/dk6n38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 14:11:52 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 14:11:51 +0000
Message-ID: <58981468-ca67-0bb4-86b9-5cb2c3678737@amd.com>
Date: Wed, 8 Jan 2025 14:11:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P195CA0091.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::32) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 97080a14-c046-4a29-7c6a-08dd2fee65e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDNrbGg0SzlDQ1BrMStwcUxHSEpON2NiTkJydHZPQkowQ0FSQW8wdlQ2Y25w?=
 =?utf-8?B?QTNzQWo1RjVwckpZTmhxdVdCd1BHekpRZjhyaWFzZ3Q2aGFFRWx5ZEpTQ2lI?=
 =?utf-8?B?ZGdnWFVBcEJkWTRVV3VkRlVHdUlTQU9BcjZNK1I3WllHWEhub1ZHUzJROGlx?=
 =?utf-8?B?cXVha2pJYk5kSW9uVWk4WXR4RytGWUt4dFo1dXdRd2xsZlh0V2s1SEhxVmVn?=
 =?utf-8?B?dGp1RWFjMzBLYnpsbXpLTzhxayt4ZE1NWUo4RjhoNDk0RmFSUG9XblNPMXZv?=
 =?utf-8?B?dlVUUDRFazkvWFp3UWxZODJYSU5Xc1lEcmIyUTQ1QzRXRzZSdnd4T3pOZjRo?=
 =?utf-8?B?QkpaZEp4SXVxdERXYVU0bHQ4TEkxYzVXTm9FMzN2aFoxRmMzbUFWaUd1dnRQ?=
 =?utf-8?B?aldzZUYyKyttSzdqNGdSSlkzbzhXZEc1S0xKdGRiTGRVdXgrNHNicjN2VUQz?=
 =?utf-8?B?dGc5VkNBazdUNHJVc0ZCSG41MmlPeVNTRUxMeDRJdXBDRUh0ZzNFa08xcDZm?=
 =?utf-8?B?M3VTNFp5SnI3NmJDdXJtRkdGbjM1Yitod0VvenlYeVVuVVRlcjNzNit2Wk9j?=
 =?utf-8?B?RERvK2pYSTlHU29JbWpVZzlPenNtR0ZPUk8zS2s5NXNtTzFGeng0RFR1S3lF?=
 =?utf-8?B?TFR1YlRjcGozRE5MZUgzS25haGRiT09FWVd2SzdBbXZnQUQvcjBuT2REU0xU?=
 =?utf-8?B?bys1L09TazI5RnRZdUszbUlDZHJDaFBFQmlVbHdoSUlBY0hGOU5RT2xhVmNr?=
 =?utf-8?B?VHJqLzY0bnBBdStDVTY1cmxWWTFoRmJFZDh4S01oemRDaDBJT3ViUFVvTmJ3?=
 =?utf-8?B?eS9CMGdXazZ6RHRIWjVpYnQ5M2djcGlnT1J0QjBacy9WdHN0dTUza0xjUE5Q?=
 =?utf-8?B?a0g5QzEwZXVrWkwwbHNrUWw2YWh1TTVBR0pwRDJYZThhTk5aMnl0cHRLbDEr?=
 =?utf-8?B?QWViTklqRFpTeHVIU2JkWFNOeGtUcHpxUWUyWFUwRWV1UzREK05BZ1RQamJH?=
 =?utf-8?B?UUxZYUVxYXF0SU9tRXRuN3V3TDF1Z2c0WDdabGpoa3Uwb1puOXFOOTdDS2Jn?=
 =?utf-8?B?VUMwUnl0YTRSVUhRTTNUWFJVNFZFVGZBTUFIQmpBaHB1KzZRWDl6S0dJQ2I1?=
 =?utf-8?B?MHJEY2dLMlJnYktSeDdSRFhydEhwakFNZ2dWWVJuejNEanBNdnAxRFBFYTYz?=
 =?utf-8?B?SlhpeXdRN3dwN253bGNsL2dLWjdQNCtCa3VhWHROYlRBS1ozTmNrNk5aZzdw?=
 =?utf-8?B?UGdoYzZ2NVJxWDlNRUxUbkF6c1FGbUhMV2JRcjhwNmhIcUhVU1JvQ280V3Zw?=
 =?utf-8?B?L2NnK1MzOUsxSENwZGNNUnFwZGNjRU9yOC9WTUlsUGF1YUpoSlBMTkNTcVVB?=
 =?utf-8?B?WG9Xd0QrL2N0TE9aWHJlVnhvNmZUcXpRbzF1alM4KzBybmNIdWk0engzY1pM?=
 =?utf-8?B?NjRsQ2FVTjdlOGdtVTlJMjNuK2l6NVllc2UrbVd2RmY0NzRDaUVsMCsreXkx?=
 =?utf-8?B?ek8rdDd6YWdJVXozbWVCdFJvSnlIUVB2OUxYbkNZaGF0K05RYkNEanVZekx5?=
 =?utf-8?B?b0F1cVJ0eTl0U0kwVlVKRE5XMmQ1NHlTck1TUFEwVm4zZUloa05BdEovZDVH?=
 =?utf-8?B?V1FrUDlvaGlPRUoxTHBueG9VNjFJeTg3aUJIRVQ1cmZGTmRySUtqR1pUUmF5?=
 =?utf-8?B?b0pLVVd3a0t4bitvWno3bjk1K01lZGMyK3drdlNoM1dtRjdHVi9hQzdTMms2?=
 =?utf-8?B?eWRvdTRFbnpBMGlEMVdnc3FOang4dUlSdTNTZFBTeEJsYmRtUjdUbmtVdkpt?=
 =?utf-8?B?QVNDT0NyRit1R1lXUjJ6SnVaTFUrSklJSEgrSUxvdkhFY2tzMDBnd0szN2hF?=
 =?utf-8?B?K1o5aHNTZHFLWThkYnpSNWVncVAwaWJHcEJ5RVpGc2JhbytoSmNNY2VCVi9R?=
 =?utf-8?Q?yT37IkHmtVndYPessR6PkRAKRSuSUEgX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MC8vcUxLd3QzNkZYL0ZMYkJlL2duRWNWQVZYaC8rM2VienV3ZFE2YzUzMWEr?=
 =?utf-8?B?dzh2aEtUUzRQeGdvOXlVY0tyWkE1SnpIZ2laU3ZNZUh5KzhoR3JMSjZ2S1ZK?=
 =?utf-8?B?bzlWRTRZVW1MN3RwYzNLWFcvd0p1TjgxZUFteE1CLzROdjVOdkE1WWdYMXQv?=
 =?utf-8?B?cGxZSlN2aWxmZHRDT2Ntck5QR0dYMi9xaDJmZEJaeE0zbVZiL1A2aGc4ZFVS?=
 =?utf-8?B?aUVYTVdNbmIrQ0wrTjFXSDVqZ0hnWkhjbmVCRHJtTllqVTlPajRkaUJNMTRZ?=
 =?utf-8?B?M0xIV3E0U0l4TytrY25BOUJ5cCtOMk16ZHdvd1JrYkQ2VGl0UWhHWGRlL2lh?=
 =?utf-8?B?UmVoVC9BUEtvN2Fjci9seUJPM0VOdlZNbDlhb0tVd05PNlBDZG1Qd2xMUlhV?=
 =?utf-8?B?SUxieXBUZVVyZmNROVoxY0VDZWYvRFlEbmk5cTNORVZuSTJsQ3FMY0JTZERR?=
 =?utf-8?B?dmI3Qkc3ZklkcmRlM2NiaEZZNEpxdlE5aG5QRU9Wa1RHT0ZnM3duNnBZTmV0?=
 =?utf-8?B?RXJpa3dtclpIVVJYRFdWb28wTVNtQW5Gak5Dc2Z1QmFMRFpiMTVjUVpISktl?=
 =?utf-8?B?cmF5Wko1aHgzNVBYUFFaYW9pUVVMbUM4ME11ZU9mWnBzeVFUa1RqQUl4Q2o1?=
 =?utf-8?B?TGMyQkZjSFkrVFhOK2JOUm1ORVFZdzFSZXhvS1h2dDRybmdNUVZEdmV6K0hO?=
 =?utf-8?B?NHZ5UkdMQk13ZWNvUVoxOExvK1E4ZzROVCtyTEVhd1YxWTNGTmJqMmhCb2c3?=
 =?utf-8?B?Z09VcTNwcFB1TWllN0hDTWV4aGFLSTBxOE5zd1FBNXp4OXZNQ2RObGhTK3dy?=
 =?utf-8?B?Mk1mSnY5aWJsemxoc2pCRitCNWErbitpelVnQjg4bFYyQ09mVnVZc2JNRnZ3?=
 =?utf-8?B?ZUFMc0dnRGZsWlF5RlRCK3Ixa1hxN1pxbkNoR21zaXU2NHVIRHROZHpkT1FZ?=
 =?utf-8?B?L3VienJpUkFsaWVLYUQwM09kWjhnV2dqR2kxVkM4RkhSOUMvTnNLUUdHVHQ3?=
 =?utf-8?B?anJlUDRmOXBITU5kMGFMSWFkTm1CUUNXK1NxOGFWU0pvQjY5dGNTR1I4cXhW?=
 =?utf-8?B?RlhJdEkxajU5TEswVmFuSDhlM2JaZHl0aitGaytDVGdyUXgrQVBuSlhxdWtq?=
 =?utf-8?B?c05HWmN2S2VKOVlqQTRwNkxMd0xyQmJnOFUzUUEvYkMwWEdlOG9xM3ZNUC90?=
 =?utf-8?B?UDRCNGlhUFlURlAxWHFlTDF3N2UwZFpGRWFzamRQcE1ISmo1QWJYUkFIaHFk?=
 =?utf-8?B?emg4cUw4RHVlZnZjM0d2c1VhTGt3NEpmaWNYUkhneU5rNHhaWFpmcnp1QU5q?=
 =?utf-8?B?ZnRaZDdoL0xZcXBKME9xZFZKWlBGNnNXU3lLWUJnOVdYaDhsMmNNWFdNZjJV?=
 =?utf-8?B?WmdPMFhEL2thY2p0R001M2czVEhQcDduY0srV1AyUFZZUUdiSHFObVRnYkRV?=
 =?utf-8?B?SDdVcWhCUHNiSFlKSDVYTzZrclYvaEpPSGxuUmthYi9WSVhuRUlRT2xLYWhr?=
 =?utf-8?B?TWZZWUM4TFFLSW94c1pCSUd4SVZ1bTVUcDJNdysyN0hmcDMvb3R3NFUrVURw?=
 =?utf-8?B?d2V6aXg1SEpmTHNKaFozZEZsOHhLdTRpYVMzcEpVcTFZV3RiVVhheVRlNDEr?=
 =?utf-8?B?bC9ONVJUWmdHRGZsRjIxenMrcGJ4RGREZXhkSndVc0p3b0tWUjZ0Szg0ekRl?=
 =?utf-8?B?dEppb3hlbG5XTHJ6OU1nbWNkVjRVb1ZTRldiYjdlcldIS09XNHcyMDdkYzJE?=
 =?utf-8?B?MmRud3JNYnVCcEFsRFFsRWN6M0NnNnFpN2t4MUkzaGN3aUo1Z0NvR3ZFeGJU?=
 =?utf-8?B?V0ZVVVFFdzNLR1h0eFRJOVBmR3pYUFdwZ2VPT3crU2ozOFlCVVlBdnhVVENK?=
 =?utf-8?B?M3lzSWNhYVA3eGI0ZkdjNDk2MnQ1cEZzNnNRREhBa0pVb0xXOVNNdHJ4Y1o2?=
 =?utf-8?B?c3ZmcS9ZSUZoMmhycEJ3TDI1dlE3UTM3UHBaTDdWelBpb2szODVTQXRjL1k5?=
 =?utf-8?B?TlpBckFPSzRaSVg1Nnk5QmY2WEpmZnNpOFR5TU9hUTVyeWQwRUNNckhxajJm?=
 =?utf-8?B?aFhBOHFpTU9QOU5jU2w3aDVSMi9RRVB5RWt5eDdWRjdEaWl6THFTdy91OVdr?=
 =?utf-8?Q?Wbna/O0sbTV+jf7VJN4CNFSm7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97080a14-c046-4a29-7c6a-08dd2fee65e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:11:51.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaaWfrYWH5uSQDnU+DUIlH9pEeEq4+ibZNOPyE/RzEoJBedGT92sFkTwt8CssBHEXbqesvOrd3OdhhFPT41L3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124


On 1/7/25 23:42, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
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
> This patch causes
>> ---
>>   drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/pci.c    |  1 +
>>   drivers/cxl/cxlpci.h      | 16 ------------
>>   drivers/cxl/pci.c         | 13 +++++++---
>>   include/cxl/cxl.h         | 21 ++++++++++++++++
>>   include/cxl/pci.h         | 23 ++++++++++++++++++
>>   6 files changed, 105 insertions(+), 20 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index ae3dfcbe8938..99f533caae1e 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/idr.h>
>>   #include <linux/pci.h>
>> +#include <cxl/cxl.h>
>>   #include <cxlmem.h>
>>   #include "trace.h"
>>   #include "core.h"
>> @@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> Lets just call this cxl_dev_state_create and have cxl_memdev_state use
> it internally for the truly common init functionality.
>
> Move the cxlds->type setting to a passed in parameter as that appears to
> be the only common init piece that needs to change to make this usable
> by cxl_memdev_state_create().
>
> That would also fix the missing initialization of these values the
> cxl_memdev_state_create() currently handles:
>
>          mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>          mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>          mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>

Ok. It makes sense.


>> +{
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
>> +	if (!cxlds)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cxlds->dev = dev;
>> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
>> +
>> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
>> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>> +
>> +	return cxlds;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, "CXL");
> So, this is the only new function I would expect in this patch based on
> the changelog...
>
>> +
>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   					   const struct file_operations *fops)
>>   {
>> @@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>>   	return 0;
>>   }
>>   
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>> +{
>> +	cxlds->cxl_dvsec = dvsec;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, "CXL");
>> +
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
>> +{
>> +	cxlds->serial = serial;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_serial, "CXL");
> What are these doing in this patch? Why are new exports needed for such
> trivial functions? If they are common values to move to init time I would
> just make them common argument to cxl_dev_state_create().


I was told to merge those simple changes in this one instead of 
additional patches.

And I have no problem dropping them and use extra  args.

I'll do so it v10.


>> +
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> Additionally, why does this take a 'struct resource' rather than a 'struct resource *'?


The driver does not need the resource but for this initialization, so it 
is a locally allocated resource which will not exist later on.

It is a small struct so I guess your concern is not with the stack, 
maybe about security. If it is due to some rule to avoid it which I'm 
not familiar with, it has gone undetected through a lot of eyes ...


>> +		     enum cxl_resource type)
>> +{
>> +	switch (type) {
>> +	case CXL_RES_DPA:
>> +		cxlds->dpa_res = res;
>> +		return 0;
>> +	case CXL_RES_RAM:
>> +		cxlds->ram_res = res;
>> +		return 0;
>> +	case CXL_RES_PMEM:
>> +		cxlds->pmem_res = res;
>> +		return 0;
> This appears to misunderstand the relationship between these resources.
> dpa_res is the overall device internal DPA address space resource tree.
> ram_res and pmem_res are shortcuts to get to the volatile and pmem
> partitions of the dpa space. I can imagine it would ever be desirable to
> trust the caller to fully initialize all the values of the resource,
> especially 'parent', 'sibling', and 'child' which should only be touched
> under the resource lock in the common case.


No, I'm aware of this, but also I think there is a need for setting them 
independently, and the reason behind this code.

Maybe you have in mind some complex devices requiring another approach 
for this set up.



