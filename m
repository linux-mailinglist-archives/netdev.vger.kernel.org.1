Return-Path: <netdev+bounces-235539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3AC32485
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E5B54FA30D
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBAB2E8B9B;
	Tue,  4 Nov 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TklF7+SQ"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C323D294
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276260; cv=fail; b=TQKhhlu4AiZGEjX4GYYyOIq8Hj1Oh5ZuGMkwjOyfiM1iVGk2yLOUkabtN0MxJrV8cMNe8macTVGY7qDeIuYOBcpo3YwKi7tsngs1XU9jodZfI96TvEfd4DfyIHm+/ZR7aDQ3+I6omvCrZ5a1rPArOhx1lMLJUhHUSD8XhwFY1H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276260; c=relaxed/simple;
	bh=LyPfAkxmVDiK5ikBgAnLEfDsZ0ezyWs6luILRQVDCq0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EzyxPZW4YzEaD78m6yJE5pZCCy5XWlPgf1iSrLqA/9pI5mBVpGVS8RJcIKVz9BV73lQ91lEf4QVtT04q3Te9UpRasefvWK8tCIFQEX7ptPa6HzF9R4h3cnBATjp6yAjB+R+BCne7n9FDI9aHqzhXcn6+Cm+NLqsv8HHmBVo+4wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TklF7+SQ; arc=fail smtp.client-ip=40.93.194.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sejmezoGu4TcwIhP26UBQk6SO0tqR5BEUeXUen7ozD39mdEzyqYTFln1xfuXFW3lVbjsjrP4rvqd7fek6yvjCfmeZA0fnOyytUk2nM9U9NYEpGy01FXSLknPiM/dlUqNpkpw4CT8lE1jBS3M8Qw9+0U1XwR9aa2WD2Gl88hxRKDBLNbfbQe1BjPeMNSlgZbTT+wtKt1dDoBOIrsQLSXKsIAtUFZH4F+ttV+oiOp0WoY5tNSliW8rLaCnTLaMDslpfFWhKIKeu6EHHnhG1MUALF9sP/Zg1ffywulITZ5n7yVgKd0324ykrkil/0jy7BfyYMKAsuedLrcno9Jx5J81vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSE0BE6EAi6q5LVY//cb+lfQuyPyEsusfrNdMzZ9b/4=;
 b=Vzhmj6JUN9g66gSNo1gVNXKVamx2cIqffPSY1B/n1+l2+LtxrxoRJd1fo3vhdMaQNjl+cR979gBz7RUh1DdcthqA7P4S2KDZjQsICz30yaWgffM0/RlI8sEbiRZIJfedEG23sC7VRlhNjhreVBS9enxPA9skKQAR1LXDR0P6Evbznij/MqskR7PsLhqEhOhKmnRmyOqfXgbIO8lZyIVqJQI0PB7OtAA4kU6k6JY+YDxTlIoR3G1NeSbCbZqr7Jr5ipXrdXuUOAfP1lwzCLRBTMsGw/14fOTRCR1hJFM89Qj03ulzvL9zw8+wtQ39wioWFPW+zmztvwA3470/HBketg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSE0BE6EAi6q5LVY//cb+lfQuyPyEsusfrNdMzZ9b/4=;
 b=TklF7+SQno8M3yZNsAc3eWiDzC+1grCDrYJ3HSgM44tDuMsPLnDo/XCS+PMOnqVXOfgeYk6p1jA2bOzIb3SbyIIEqOyN2J0yMyv4LDa25zp2bWJ1gHkE1ZoGLUTkUS6nmIxh3I4ryev/kjhWnhy+9qhSIG0NSYvTYHbJzbATxisBEKoJ5AfGIOUREfQFwe+QNaJCZs612zDdRIVyGuvBiqUUAfmIJ2uUf4L/TQnlOusXr3RQHMNGGolbdawwxwW7oFRtD5/rxS8TmVui2lWcGCFkfHdizMn1xEsmwTbzlscdccaOgu7DzFaCU0o2SJlscq3mrc5pFrjhMK99u3ajbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:10:56 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 17:10:56 +0000
Message-ID: <2e3a11be-ad6a-4d4d-92b5-eca30166e7af@nvidia.com>
Date: Tue, 4 Nov 2025 11:10:53 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 05/12] virtio_net: Query and set flow filter
 caps
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251103225514.2185-1-danielj@nvidia.com>
 <20251103225514.2185-6-danielj@nvidia.com>
 <CACGkMEun2exfZEAwXCh1XHP-iQTTxcuBVtD9k5R9Zbkrrgsbfw@mail.gmail.com>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <CACGkMEun2exfZEAwXCh1XHP-iQTTxcuBVtD9k5R9Zbkrrgsbfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:806:f3::23) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: f09ebf8b-510b-403e-4d58-08de1bc51df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NCtjZklwRmwrdjhDUmt6V2lRbTdNdE1iZ3c3djQ0SDVBNUhtTjBadUhJemtP?=
 =?utf-8?B?bmRyM3ZVT3RDbGxlSTRhdUMxNndjVjFHU3U1UlRHTnk3WFZIVDI0ZW52ZGxT?=
 =?utf-8?B?a0FuV2pTRGhJM1RNNkhyZ1dJclVicVVzSkFYa29uNXU0R2JnaVI5dDB6cGdS?=
 =?utf-8?B?bmU5Y0NyQ1ZCWWxOQU0yU1hBb2ZNZ01ueDlJK3FJS1g0R0hTWFFDaHRRZXc1?=
 =?utf-8?B?M3FRd1dhK25qZXNsT0owcGVTeWZUc0psNWJ6em5QSmNMQVdOSXBwaFMrYmw4?=
 =?utf-8?B?WHJXcSt2YXhLMGM0VEhiNFVqMHZ6UVluZFBJVm1sb2hHcUlSUFBQNlRHMlJZ?=
 =?utf-8?B?Y1NaQ2s0bGRiQStJQ1F4VzRGN0NPRDY3aE5HTkVlVVpzV0ljemdDMmJuZll2?=
 =?utf-8?B?cnpqaGdrdjYwMjJqUGFnV3FYWitVTTdVMC95bVNrZmJvQUNJTmd1ckVheVF4?=
 =?utf-8?B?VTJTdktOa1h3TG1VMGJsODE0V01ZaUpMWHRuT3BhRVlPcHU1WXlFV2FhY1J5?=
 =?utf-8?B?Ym5TYWtHQ3k5cVFzdFNpYXZiMGZMSnc1SytzamsrcFM3K1N5V01ScTJpV3hk?=
 =?utf-8?B?TXlnM0FpOGYydkFxOGdFMTZYZU4wZDdVN3NhdlNpQ2daM2tSTEJwSjlFRDJj?=
 =?utf-8?B?U0JqV0ZNOFV6a3VjejIybkM4aTZGL1RJekhmTllGSm9ia3ZkN2hWVnRkZU10?=
 =?utf-8?B?Qmk2MGFZYnEzKzdpeFZMT1gzYWNPQUJjY3JwdXlidnZ1bFJYWElQL2RQMElE?=
 =?utf-8?B?ano2alpIZ1o2UUMwYy9kaHEyZS9QSWJmc3E0YTlTL2F1UFNYY1ZtQjdLd21C?=
 =?utf-8?B?bVVMbGd2QnVmNU1qc1krYjR4M2kvcmpJQVlFVFNIeHVXNUdycWQ4TGxEM2dI?=
 =?utf-8?B?dkZadFpWTDVZMzRPUlZvK1FMUU1KYis1MUZReFdhS0kzQlJLSHQ0TndHRzN2?=
 =?utf-8?B?b2FvMVpXTmZuVTErWkRGYitCV2EwV0hJQkRIRStCYlY4VmwxNUpIN0VicUY4?=
 =?utf-8?B?WjlNN0FuL295N0Vzb0x5dXN4NFpBdzMrTGk4OG5VR2JtZHlaU3JTZFdIclJB?=
 =?utf-8?B?b0duMTVqbWRxUjZycXpkVFNUeDdUWS9uVjlYWEQrdTFwYmw0WUhnek16T2lw?=
 =?utf-8?B?dlpsaFliSSs0Q2RraWNaZWZKTUJsOVdZS3RRWis2dWQ0eHVvQ3MrU1lMTVla?=
 =?utf-8?B?SFc0M21henBuVjZWamVKRDljTjdSa0M5MnNQdmhrcmN6QWFzSUYvUXJBcjZU?=
 =?utf-8?B?ZWRROFBReU03MWpWUUpQQVJkeWppb3EzdHlGcUlqRWRWMHRqem1tMXljb3Fw?=
 =?utf-8?B?c3UzTnJMZHhDbHpsdGVnWUY0SjhKNzgya3R3dGdtQ29aRGM0ckp0ekpJckhi?=
 =?utf-8?B?RWZ3bGQ0UDQ5dmFVVnBGOElIZHU1dWZaWGlYaGJyVFBJNGROTkRHdmFxMFQz?=
 =?utf-8?B?aHR3OHppRy9nTlhZdTR0MEpFQWMyM0p5elkrVHhyTTJWM0JZMmh0eVJvM0xX?=
 =?utf-8?B?SWM0ZnlZVEw5UkVzQUIzSE5hSDRKcjNveTNSMi93enNpYWorOSs0SUZBTUM2?=
 =?utf-8?B?cVhuZ0FDT1RmVk9tcXBEN0oxamhWT29Lb1lROG9QazhJdDFYdDdLUXhtTWVY?=
 =?utf-8?B?VG1IZUNicm1GbDJqUzlnb0tWMG5OYmpxY2l1WGJ4amptcFF4RW1WVmUveWdX?=
 =?utf-8?B?WUgvWmZ0Qk1mNXI3ZVZ0WWMyYm51Z2NWdXVUUDVuRWJNQ3pVWnIvUUFBYkt1?=
 =?utf-8?B?TmxZeVJ3R0dHNURlVGFMV1d5Y3NJbVNobnl2cXBIUTc4VXdMQXg3djl1djJV?=
 =?utf-8?B?Q2hmei9vVy9IQnFkaWw1WUhDdXJhckwyeFRQL2o0N2ZWeVNWRCtObUtJYUJv?=
 =?utf-8?B?a0JVSWVqY2N2Nnlrektxa3NtL2xXOWZpajB4ZGQvU0xjdTIxdzJORTZta0lo?=
 =?utf-8?Q?Wejs/ggDKYcMrX6AEg461kYYz7PSp7FF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzlEekJTY040c3pneVZudlBPVjRJMkxWWW1mYytZZE5hYXg2bnlYR1IrSWQz?=
 =?utf-8?B?TVQyN3IvZUczVUJuOVFVM3djWGZ1ckRBb0RBRisrdkxDWnN1dTZjUlltMUd3?=
 =?utf-8?B?dlZDV3NKM1BPcWc5U2wvTzdZOE9qMmp2dFBKUlBvb2I4dk52SVd3MTVEc202?=
 =?utf-8?B?dXBQa2RLaTNGN05waDI0NVBnM2I0QXl4c3lDWjJZRVhjQXAyb0hRZENvQ1J3?=
 =?utf-8?B?Yy9QNGVZUXhUWVU5bnpsWHN1K0tNeWtZZXc5RFcva09Kby80WnN6c1JKbWps?=
 =?utf-8?B?UWIrN3QxYnNPUFZtbmExdWZ6bEdqOXBoUW1DVktsOTE2N3ptbm0wWGNCeElF?=
 =?utf-8?B?NTN4dDd0Z291QjBnWUFjK1pVanh0SzlRejBjV1ZxR3FvQWtBbk50TlRQN2xW?=
 =?utf-8?B?bTRtenZZUkt2Q0ZTaWtKK3NwaHdQd2dndjBYQTlqZ2VrMU51L1pvWEJGR1RS?=
 =?utf-8?B?VFFtUjdsUXdnSGNkYkptcHRIbmwrd05XRG1JVmxIY2V6Y2p6dkFDNnpDZGF0?=
 =?utf-8?B?VkpmZmpOVEdaTTFKVzJmQWczMEtXOTZTMFFGbTNnNFpLeDhBYWV0MGNkaGhn?=
 =?utf-8?B?UzlOanF2bUU0OTBRaEM2UjJDNmRUb1piZWJQY3VOZlhuVHpEbUlSb3p2YWNK?=
 =?utf-8?B?dUpGQlk2TnNBODlNOVNaSHJJbzlsRUlnVFB0dkpIS1FzZ3BnN2ZFcVpvRE83?=
 =?utf-8?B?TVdMVmk2dzBJdjRFYzJiQ3BOZXZvNkU5bi96b2psclpzRkE1K2M4N1A4YXMw?=
 =?utf-8?B?QmJtZ2txNGRDUzdNWUZpcTFlUHozUFc3K2owTndUbXJzT05lWWJGaG12eTNt?=
 =?utf-8?B?c0hNSE5UOGhNN3N0Q0ZQalRDN3hac0tkenNhejlGVkNwd2JMaEl0eFhIbnV2?=
 =?utf-8?B?dWhncTVSV3hqVk1zRGhvMkFWTnhVT2Voem9WR0Q5ZUNoM2REY2k3MjFnUnY3?=
 =?utf-8?B?UndaRzFLOTBvZlFCRDVXUmhtdFRjbEhUNU16SkVOdHpvRUNncldlYTVlTGZi?=
 =?utf-8?B?aEFXRFlGWEhCd29PZUFqVXhESm5NTVYrTS9RSDI2SjVVeUppbnBJRWx0YzBk?=
 =?utf-8?B?U1RKSHpVR1dIdFJ6Q1owUExsM0NDVjUrUXUrZ1Y3OEZtQTl0VzdSZUNZRUo4?=
 =?utf-8?B?UkRJSkxBQWxnblluRVB2MER1ckYrTStNRk9mcjBvVi9aWU9sWTlCQS83U2ww?=
 =?utf-8?B?RW0wMXpvcEZQc0cxVFFJTmFnOUs5OFVQQXBteStXOGtlQmY2VW1XR1VWcE9v?=
 =?utf-8?B?bXhCUUVGL1dJdnlzakZKTjNJQ1lKaThCaDNsOEM4bzZsZml2N0dSN3hMWGxo?=
 =?utf-8?B?clZqWk4wdXpKUXdzU3RwL0Y5d21tR0dwaDlsRm5TN2pqSnpJYjBKRkFFOHJ2?=
 =?utf-8?B?TnQ3YnR1VExWSnRSYjltdFI1WUtkVlpoelRTY3VQcjFOOFVGVHhIVHJRZk1v?=
 =?utf-8?B?UnR6VUt1d0E5cGIveWt2eFJteEt5L0I1TEJXN3REVVZrNE5QbzBxdXZ3VTda?=
 =?utf-8?B?bjRGR1ZQaEh4ckx0Uno4TmhYeXJaKzZIQno1cWhaVS92LzdZY2FtWU8rUFc2?=
 =?utf-8?B?RlVhSWkvMEdqS21RbzJMY0cyT0lnazhlSVRGQk03MGVkSlVXc0JJN0QxOXRl?=
 =?utf-8?B?b2ZwektKUnl5RGY5eWI5aGcrb1k4WW5EaFpUNnJxcE90WWpjSGhBSHM2a3NE?=
 =?utf-8?B?S2pZa3UrL3VSbzVjWStRaDlKdDJRQ3RUZWFUYkk1YlIzVzR3VTN6WkxVWWty?=
 =?utf-8?B?ZkVKQjNkb1ZQRlJUMk1hRFNUeDVqRkc1YWs1RjdBSkthZ2RXeGFUNk5SYkcz?=
 =?utf-8?B?cFRtdDNzVlBXYVVhRy8vd1Q3ZGdTaEJ0R0JneVd5SDZ2dHV4Tkhacm5CZS9D?=
 =?utf-8?B?Y3d4RElpTnFzQ2paU1p1ZHdHNXlpS3VwaHYvS3ZNTmFKQ0V4ZUlaL1NUU3BM?=
 =?utf-8?B?cW1DVC8xS0lteTRZenFmdDNGUUc1c2N5ZFc2NmRnb2o0ZmtqTFQyMldLdk5J?=
 =?utf-8?B?dXdwTGtybDdkTmFEdFdqOHpyUkk1ZjRLYnBTUldua2V2N3MyVGhCNjJyMlM4?=
 =?utf-8?B?WG9GT2trOGNIZVdTT0NVQnlyQmJWaVRSZSs0ZTU4QnB6QWtjOHpoNVc2MFhT?=
 =?utf-8?Q?+UVWClQQyFpIRttQie7VXJP//?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09ebf8b-510b-403e-4d58-08de1bc51df3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:10:55.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6S7lSAfIJLxtNPQpwW5dg34oja3uWeJieD63VC2XrVqUkIFjOKNs7av/czm15x5P7UK5miekTXpNUb9hKH/EiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

On 11/3/25 10:33 PM, Jason Wang wrote:
> On Tue, Nov 4, 2025 at 6:56 AM Daniel Jurgens <danielj@nvidia.com> wrote:
>>
>> When probing a virtnet device, attempt to read the flow filter
>> capabilities. In order to use the feature the caps must also
>> be set. For now setting what was read is sufficient.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>>
>> ---
>> v4:
>>     - Validate the length in the selector caps
>>     - Removed __free usage.
>>     - Removed for(int.
>> v5:
>>     - Remove unneed () after MAX_SEL_LEN macro (test bot)
>> v6:
>>     - Fix sparse warning "array of flexible structures" Jakub K/Simon H
>>     - Use new variable and validate ff_mask_size before set_cap. MST
>> v7:
>>     - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abeni
>>     - Return errors from virtnet_ff_init, -ENOTSUPP is not fatal. Xuan
>> ---

>> +       err = virtio_admin_cap_set(vdev,
>> +                                  VIRTIO_NET_FF_SELECTOR_CAP,
>> +                                  ff->ff_mask,
>> +                                  ff_mask_size);
> 
> Should this be real_ff_mask_size?

It can be. If the controller is sane they should be the same anyway.

> 
> Thanks
> 


