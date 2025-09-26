Return-Path: <netdev+bounces-226591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5F5BA2698
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 06:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C783BFBDF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A58272E4E;
	Fri, 26 Sep 2025 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VbnnhrWS"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1438DD8
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 04:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758862458; cv=fail; b=Cr1MLJLv43sV74ucZ0hqzNEwiLE0fXPKI59ezd2tJuWsOCStDkm2KVn9kMw2c5SIzzmcMKmUyb43JSV7Szop15kQEYKr3hzq7PJCipUS/TmrT5//nj09dq5mc2NeuHW4Z0xcNsQYG/Y2+0GZZReLYR4Dod6spakZ9CekqA+WWnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758862458; c=relaxed/simple;
	bh=elzaP9BOnFml9IhMwiivd4uiDRQYxEVlAzGtIHp2Hxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wk4qRM5megAP5pLWySSygdKrYXMyu9Hzs1dnoSNlwvYqP0ICuYQe7j8KZorLSixyyWWHY6TGx7BbiZYrtVK5QKpcHY1rG3iHGXFwSb6PWwIb60l2L0WonUABStDDdKD5Eeua/e8SsYao7oMiltETAg1lZNOqKT9nRR8nr41xbBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VbnnhrWS; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4V1TYA1gzxbm0mcgeP/Xyn1qXEegqKb8FPbVy8qskrx9OZ6/HtFecHGCxgp5pwbn/wAZj7dTSWQfaByKVbjT57i2gmt4FQuRQ55FGtSaQ9p76N9Z0r0Bf1LlKZdb7g6uI99ZuhKJIxJnGLFgDctmoz0wPqPq//A1Etrpvb6TM06AdRQjDWOOAho1GSmWx374nj3vIYoqSrM6V7y47DYeGe8rkHbDlOaHvzv+9PfDH3s3g9r2cyDPw6iKtfGRlM4/4Oa2GMkGdjqiPE13c9kuekCnaPsKvSFpWgJfOmj08cKV+twTpnPHLr0ldLgv6/HNJbRDwf4udYfr5YxTU7DbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST2ihNkEWjTtXLNKGl1fHlXf2DGEw2a1a0qfoSJuISY=;
 b=yMtuQaFidLqLQJCAh2rICiPYrabPC1PX4TNNS8kV9fhPwxamIGtKymhidK41TCJcI8EK+GEUh969v56DULjxRIDF0zR2hHL3zZ4emTA3tODGvybSAFUs5wCjELKOiDVA2nVzdg3R6j47BbJB7VLwlYpy/y7xEXKqiOKnI5uFRtM4W9vKZM6CA51uLrNvzMgICUYgzsGSAbQ+T0ARJP8qQa0W6hZqkZwmW/651QxHqu0qGwCzv5gtWie1PhwxSQ8xaLXQ4xLhYztFEall5/l7RHOh0mE6IAwIG+L+tvQRmZ9SqPfsFBavG7VJyqaxVCDMhQEorYoYmJoikHST5Es+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ST2ihNkEWjTtXLNKGl1fHlXf2DGEw2a1a0qfoSJuISY=;
 b=VbnnhrWSP7QhBPDKrGF0HCiXzuFOsmzf4j9ZwgivDNvDq5wErmERNPLG8JMgVWsiTv460BqFfVMdpylJdPV1D/k4QFQGbgTBJCo96dCd5RKLsmEp2yOttjmuVNo//4mUMafqHb7LYVRWDY81xUQstiRRQOmQSppKbsJytk96SP8SC/8CT7YmC49GzdEXfB5xs18VoZl3nQjcuEveXBrRKzAsGkFs6hLnekL3gypD2mgnJi8Dxedjzm+dOneDAVEEw3JLrWZrjmmuhBjQniF/qq3Bt4c/F64hi2gfclL2dNyitpaEYOeZm9uSt1RwvYXqdheA2RYTGZWc+7i5D0F3ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 04:54:11 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 04:54:11 +0000
Message-ID: <1610fb1f-9fec-44ff-9a95-9bbb69e5b6a2@nvidia.com>
Date: Thu, 25 Sep 2025 23:54:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/11] virtio_net: Query and set flow filter
 caps
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-5-danielj@nvidia.com>
 <20250925171327-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250925171327-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::35) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 964c2783-cba0-4c71-42ff-08ddfcb8bbb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3BjVGpyU2FmYWx1Sklnb0NDZW5WZmJhYW9Yai9oWU5FZXQ5Q2diT1dYUno3?=
 =?utf-8?B?d0R5TVZVTXNTUHBaN013U3pkNDNLc1dWUWJXbndWQllOM1dkOEVVcjNHeWo0?=
 =?utf-8?B?dDFBNUtyKzBJR1lDOW9CU2diWDE1TmREYS9DQ2toN0kvQlJ1YWhsV1k3VGdD?=
 =?utf-8?B?TmQzRmhRcEQ5Kys1VHVYaVlPSDZ0eXRlaUNzNFU3Q1lac0FTdERoRGNoaVVx?=
 =?utf-8?B?SWpGSWxrQlJzZzRaUXgvTUNRazcxV1VuaXhSWjNXQUNhRS9EZzM4Z2o4cGpE?=
 =?utf-8?B?YXF6b3lhOGhmMFEzUHluR28zTkw2UEFRVnppQWJEV2NER0RpR25SczBJMWZ5?=
 =?utf-8?B?NjBkdGZSdmV1VlpMRDd4ZkZFRFdlc1c0d2xkOWM5eDdWU1htdngydU53S3h1?=
 =?utf-8?B?MVhaOWNhTjQ4QzFjT1pwbkwrTFZ6Ti9HSm9FMmJhQmx5WUdBMGh5Ky8zd3Yx?=
 =?utf-8?B?YlUrbDJNaHRNbmlTT3NHSzhNaTV5NDh3TGZjR1J1N2lEejUwamFLWU9GU2FV?=
 =?utf-8?B?U1ZBc1Z0eFRpZjEzbkc1aUxLYXdYL240dnNnVW9maXlSZkdJSEtxVGRiTmFQ?=
 =?utf-8?B?SlhSWjkxT0RxL1J1SXlNWkhBU0J4UHRMNkFYZkxZek1zTVM4Qm9iMlByNEs3?=
 =?utf-8?B?MkRpb0p1LzZ5NXo2UDNMSFNkaCtjNHJMUXNUeWowaGFiMW9jVFA2czdNYW9N?=
 =?utf-8?B?UnpvZWlvTXhkVndRa0k2Q1JwalIwd242S3VacklCSERZMFhNbUNwakZmTjNY?=
 =?utf-8?B?RHdDdkcwWjEyREc4NEF1Q2J6dDErSjFpaXlFL1VxbG1hcFJUUTNFV2J2KzBR?=
 =?utf-8?B?OUR4SDI3TEJUc0lBSm5OVnFBbEd5UnJQMG9wdk52YkVuYXB6MjdHS21JZ1RI?=
 =?utf-8?B?TVVWYmNieHNXQVlqZ1pidXZyU2E2Tnp1RGtWaWVBNlAwZno1c3dqV3NhcmVQ?=
 =?utf-8?B?eld1VXcrNW10bmFMRkVVdFdtN2kxZGcvMHNLZkpuMFM4VFZTTjBnQjNCSi9R?=
 =?utf-8?B?NjRYbmR0TndLRUVoTFVJVDV5OW5PQVdiQVdiNEJrLzJOY2VsaVJGNnJRSnpY?=
 =?utf-8?B?Z1NaWSs5UjE2VEF6OU5HSTdPdWM3b3p2WHN3N1RHc2FDSDFoNWZjVGlPRURh?=
 =?utf-8?B?REN2eVdZZzJSZTUwS0V4ajgyMXJEWjRzTTJuSXY5aVMxdU5BQzMxWlR6dVVJ?=
 =?utf-8?B?Y0FpcDMzb2VRZ2Z3eWw0cFF6MmpHZlpscDB6OXZJeTlLZFgvdk1aSkZCT3JJ?=
 =?utf-8?B?SlZUYnEwTWdTYUc4VFRuOUh6MURvMFNwcEZZeE15L0MwWjAxV3Z1aDI5UE05?=
 =?utf-8?B?VGpQUUtnUG9qYzFwZnVwQ2Jvc09vNFdZWDJBbmxmZUZMTStLVVFPRWcrelBr?=
 =?utf-8?B?QUxXSkd4Y1NMWHVqejlERVJwZUlzUERUYUp3WnRVMkNpb2xUWDRZWDZDRTU0?=
 =?utf-8?B?WFcwbENmM1Zvang5ZUx6RWJ2TjdlSFhWR09VSWl2ZmExUE1SQnc5V0g2d0pJ?=
 =?utf-8?B?TkdhNUFJTlF5R1d3TGVkczJNRjhXWEJHODNvU1BxSHVqc3E1TDFFbnlIR0hr?=
 =?utf-8?B?NjRjbzJ2TG1LYkxyRCtnVTBHWU94SUtwcnpEUU9tQTY1c2VnNi9DM2l0Y3Fx?=
 =?utf-8?B?NytjMCtVOE9xZGVmQ2JOL1ZKRmgyNTNaMHlCUXdPQVNldk9IQ2dQREowejRN?=
 =?utf-8?B?N3A2eWxReTJRVW91aTluOG1BQjhQR0JDZVNFQ1VCMk4yQjJlUGl5WVhObUdO?=
 =?utf-8?B?TzVmTzVaL1M3Zkc0dFNYaDJJTDR2UzFkZGUva1pCOXNya1hnQnlGc0Q5Q2lZ?=
 =?utf-8?B?aXVubDBtL3RXZWMzeGJSc2tNczBrRk4yUGszZnJzK3JFQzZlNEVySHpqTlhw?=
 =?utf-8?B?d1VrcGtPdDMyVXpxalVPVEMvOUp3Mi9ZVm5QWXBkOVhBblE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1Q0bFVkTHdkUXJkU041V0VlUVRiemgzT3lEbGRud1RmWkVuSmMzNDhzRWly?=
 =?utf-8?B?bFY5YUZSSEE5Q3Qrbm8zeEVDSWpTUVBaTndSVjF5ZU51RzVyQUJnUThaQzJ6?=
 =?utf-8?B?V0JPV1lCZEJHdWtpTzViWXE3NHRHT1ExSCtSTmV1a2Jndk9JNW5vVEgxY1Q2?=
 =?utf-8?B?VkxDVlFwaFpqUzc3Y0FnZ3V2MjdTMjNyenRYL1V3UkV1QWNCOHVUTC9rMFQy?=
 =?utf-8?B?bGNJSVl1U1lOVDloSWE3Tjh1TDI1WEttTk1sNlIzQWUrSW5VN0lVSDRsMUlm?=
 =?utf-8?B?WTNDY2M1ZlFhTmkzQnhmdlc3RDV4dFFsUkhRdTZNOG1KYUUvNHBpcXVZYm5V?=
 =?utf-8?B?eEpKWlNzNU1oWVluNUlUM2xLOGhERDhDaUlwTUJSWGZIbU1FZHJKVDBseStv?=
 =?utf-8?B?bGdGRnFrcTdxdTJsOE9MZlFHN2l0Y2tZZ0ZqVXk3Q0tlZ3pwZSs4aVd2MkRo?=
 =?utf-8?B?OVBQdy9rWUI5SVI2R0NCNmphTFQ1K2JZSXhJbjFPOG9td0FMa0lTTEtPUmpo?=
 =?utf-8?B?QU83dXp1NkQrbEtoV1JuR1NKUmpwSXFPN2NZNmd5cUVjcWdQMXptakw0bWZ3?=
 =?utf-8?B?Mk1udE1la2xFc2dQU0x6QTFzVWUwYVBnY2ZzU21uNDVqMkNZYVpVNXgvR2Rs?=
 =?utf-8?B?aEJUVnhERHQwWUd4V0txZThZckNXc2hhNlB1cHlPV0lQbk4wc2NVT05LMGZi?=
 =?utf-8?B?bW5NNnEwRjNaSWRlOVZ6MnR5eGE4K3lPY3ExQVl1MlR0WnI0TndBN2NOenBu?=
 =?utf-8?B?WkVKRVc0cmNydlQ0OFdydFRWQzFicm5WeDd0ZGV3WXZjS3RKVHRuemVwSHAw?=
 =?utf-8?B?alJ0b080SlNMTFByS2U0a1Z1TFpDNmZ2R0YrcHVpZU5jejlLbUZubmp4WE1M?=
 =?utf-8?B?czNhdy9UM0RRODRnNmR6T0hUNHZzdVFHbHlqVGVySFFmSmVEYXBtT09lVXRN?=
 =?utf-8?B?OXZ5cDVwdUoyUEFwMHRraWh6eTJWYUN5djIwQ2Q4b1pxVloyMmpTMTk1Uk1z?=
 =?utf-8?B?OG5zV1plNStiQWdnbHpZeitlMFhnaGN1TWprWFI4UVVycEl1WWppMWtPMHcr?=
 =?utf-8?B?Q1Z0bWFldWFFdEZjM0dLMmVwZXpwdFNITVhWTGlFUkEvNk11T2pGY3pqZ09L?=
 =?utf-8?B?dXBjcm5jVVNZa1RITUFvcXg5R280dHBjTFNESDFEYmpRTXlmSEtkMjZWelR3?=
 =?utf-8?B?c0xtUGgvdWlkWmlyTVJNQVB0b3NONGFkSUdZU0lvRFlKcXRXYit5b20rY1Zx?=
 =?utf-8?B?ZkJWT25WTEd3UmFsRkJwVUgxUXk3K0JkNGJWQ3hsN2pzMjFXU3dhSXFQWkdH?=
 =?utf-8?B?TlZ1RlpKaGhETmpVYTQvYTF3dXM5UjNqYTJITUxoYmxxT2NPM3E5WTczVGtm?=
 =?utf-8?B?a29OVkZVNUwvU0xqNkFueXpuTXlkejJyYXJkYjVrMnlxSm1IUHJGWE9XVFU3?=
 =?utf-8?B?bUcvRW1mM3o5TUxEYldyMlhnVjZLY0JyRTk1NTNGNmdZaGV3QUxvckdtb3di?=
 =?utf-8?B?MHozbThTMysxUHd3WmxpYUJyU09lQXFRUG4zdDBCR2xvT2NuRnR0a0lxMllh?=
 =?utf-8?B?b0VVWHlpdVlyOXhvQUMyQ2pJMkV0OE5UeFdNczJReGFvc0RJV1JKTU9NVkt1?=
 =?utf-8?B?M1ZEOXFrVi9LbTNtNHVBYzZXWGNxVExxVm02QUZWMGw0N3JNU3ArSGptSlYx?=
 =?utf-8?B?OGtsNEh3b2VUdEl2STdoYmU0VEwvQUJpb1NGdXV0cktLbTdmRTJaVFpIOHVx?=
 =?utf-8?B?dTFXdUdHZGg3QkNHNXNaeWNKYW83VThWWlRCVHhDQjBOV01QcHMwcDN3aWk2?=
 =?utf-8?B?VWszRzhoTVZTL1BBL1RTREp4bHVnTmhxRDI0MlNGeUVyMUtiQ0JsOVhOekpM?=
 =?utf-8?B?TmxHdmxtdEl0V0JocGJmY00wUGRuejhUL0RTMTB0bTlUTG5YbjZSR3pFbVF6?=
 =?utf-8?B?QnI0bUlLYytENENBMFVTYTJqVzY2ZVd6MStCSG9RanBoSmE0VHVrNlc1UXpv?=
 =?utf-8?B?WWM3VSttL2xaV2dTVXo4UTdXNWYwVGdoL3ZzdlVZbmdqNnRrTm13K1pYbW1Q?=
 =?utf-8?B?RWhLNzl0WGNZcUdYYzhVM0l2VVFoaWlPaUlrVm1aeVoyaTRDdUdMcE5jelcr?=
 =?utf-8?Q?srm3A62lUVECG5UuS2BEuUHDy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964c2783-cba0-4c71-42ff-08ddfcb8bbb0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 04:54:11.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpJ/bRXVlZpSVBgaYSysiWbvzxJchsYFlBdYcw4X0PIoLESPNVEFanyJiFS9WaXqebWPJ2KmbYnKh7zy5QWMfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795

On 9/25/25 4:16 PM, Michael S. Tsirkin wrote:
> On Tue, Sep 23, 2025 at 09:19:13AM -0500, Daniel Jurgens wrote:
>> When probing a virtnet device, attempt to read the flow filter
>> capabilities. In order to use the feature the caps must also
>> be set. For now setting what was read is sufficient.
>> +	ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
>> +	sel = &ff->ff_mask->selectors[0];
>> +
>> +	for (int i = 0; i < ff->ff_mask->count; i++) {
> 
> i think kernel prefers variables at beginning of the block

i was already declared. Removed this.

> 
>> +		ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
> 
> do we know this will not overflow?

length is u8, ff_mask_size is size_t, so probably not, but I added a
check of length against the max length we expect.

> 
> 

> 


