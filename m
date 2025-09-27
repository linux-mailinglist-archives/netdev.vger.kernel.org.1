Return-Path: <netdev+bounces-226844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F221BA5922
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 07:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0F8189D134
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 05:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C705C1E7C23;
	Sat, 27 Sep 2025 05:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kIrsol81"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5918FDAF
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758949340; cv=fail; b=Id3R0ij56/O+q44CQqodZC4ZU05gO/a8FVnrd5eHhkFzsGMYNl0Pcij9kMRNR4a7tEg2IdvaDTYPLALI1xNkzDsDoCLUrOJ1NBXGZkqyNiiVfbb7+665eq9b1wrrG5F6IaMqXnF/V7XK9z2MGTq/CTjOikQYr4ks9g9Z5hPMqe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758949340; c=relaxed/simple;
	bh=88N6Fh6pPhQozXYJvkbi+IFZCuVrh+UcUwr7TFGTDBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TCL16PAw1DehY8RXV1ybkcsI+f5iRYbj6Tp8Rr3H8u7j7hL0B4ANrkhL2amXLMM8GFuSrux8Ytyo3JpscQdPtZddWhKb/Klw4EggNTV/s0AnntYJKoet7wV8yzMntnjmI502PvJ3eU4L4Qr2jJFi0EELKFGHgMr/fJBe/5LSOLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kIrsol81; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oktT4+sf6En3tJCbmlW7Opd2WYVcJrXugcHjaDE6gwed8wDxevg0Mr7zhOuZAnyZptz8mSUdenftlEdnxkLh8JeE8w+kFXCyV6myHkVJYkVd3gquaUEqv8rWAQ7h2WI8pl79jWaID0b9vBdyQXDNAtEmiDdJjRrkqDesz8v7GvknxPwXTY3rls+3ayJ4Xb+IEGXucM+TZ/0zCEzCXnboRyFZWoVEULBuQnCDkIRqyWJBHYnZ7dtd1s+5VEit2hw+ZGrXDrHGzK1QOy94AKd2HxGAyq309hF1e3w+8Bar6JJ5AsUXgTubu6ovLsmUOiPgn4iJkcZjxEyuO68rHvWNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01sBuL33BHeA3j5wxjdOPt6imF7LsORRDIffUsYXYn4=;
 b=YF01smvVPpe4Y7O1aibeVBrNJvxZ3AoidU2N1ldaUo9gUJ+u3FrXbRw1RIq/2X7k4e+hZqWq2xla90HrYphCL6caaYKmosLWHvF1q9fJ8E0C+rg/VvQiAo1uGLxBHheg+9wTFLd/+5BOzyeMCwj3SjqdW04L2yxEQCyL31uXBrC9k+QAnVuZTTvFieD+3mwsLQGnPIH9xOWFzdpops/RNL5drrebmcBg40wtJ1RNeqEYWzYCrSuEtRef355keRkwJR5wQptYYvjCWVxlJndZb4oTRkdY8txNHBrkmZCEQeQbHutDM3Gfest2owNZoFpqfwE/nV1PvH6B6dUx8u4ybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01sBuL33BHeA3j5wxjdOPt6imF7LsORRDIffUsYXYn4=;
 b=kIrsol81cJp4+KeHHMXHelsKt2ViCVDhvaCjYUocNvhercbVnwoa0O/SObjl3fpUS0HeeCvLiBj1ZcU3dU7EKjvjiy5Oofa17sxNqdoZ37IbnekR9iOhaFnqHTNHu3Nyx5EW7J2f1BoPJn/D93pkuBIAlhVGTPMYph3mPwxewfkg7ngLwTsnz0q37QUXUenWLeB62j3vhhgD/SNnuJ4AxVW9VsgKGw8T/E/WmJj1DhMdzQhwD/JGCXtiGxvdpin2BuvsNk9nkGk1rhHMYUa2puilCYIktJylBk+FDTfxStAkasvB+pQvgSA3sY/zAhp4nbY5cylJ5SpZKlpTHhNfzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Sat, 27 Sep
 2025 05:02:12 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9160.013; Sat, 27 Sep 2025
 05:02:11 +0000
Message-ID: <a65349eb-9194-4a2d-aced-ccfdfeca1ccf@nvidia.com>
Date: Sat, 27 Sep 2025 00:02:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 06/11] virtio_net: Implement layer 2 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-7-danielj@nvidia.com>
 <20250925170210-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250925170210-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b557fb-d259-41dd-6b08-08ddfd83047a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWtpQnoyWFhCTTlQUThuTVpnYmFrcFA3TFdGNUlaQWZ6MTNnRDBPQ05qM3hE?=
 =?utf-8?B?ZWxod1RFZzBGSVplSVREUE5TQWRuK3FYVHdzT0QvL01qRXVLdDg2RWR1cjFZ?=
 =?utf-8?B?Mk4xREhudjVSekZ0SGtWL2U3L3pURXQ4RHZ6S3FmQjc4eVZxNHhaRTZSMXhU?=
 =?utf-8?B?VWwvNGU3Y0gxa0Npc0IyMHdLVUR1Y2ZGZlhVSllKM3RCeUNzWHhDRUk0bG1Q?=
 =?utf-8?B?b2RxOFBqQkNDMElDZndqcDV1QVM3S2FZdy9ndEx3bStjWXNkd1grNGVLN2Nn?=
 =?utf-8?B?dnI3M3V4OGlqT3FlMDVJTTBoeG5YYmFPbGd4ckNFQWxab1A2V3RUZUpQT1c2?=
 =?utf-8?B?aVpsVzh3WitLNnY3V2grOW9NS2MxL0ZNcktaY3YrZDZKQWIrcHJ2V2I0Ym84?=
 =?utf-8?B?c3dxTFVrSVcrd0ZWN1ZhWTAzUGkrTHNnMEVJRkVJWEhub2NEd2tGTUMvY04w?=
 =?utf-8?B?WjdTT2pyUHp0T1Q4dm96VlBuU3g4bU5aY01jVlpSWHVZTGZISmFnOHlxaFJa?=
 =?utf-8?B?aUlKNXBvL1JpcWZxREc2QmcxeG5FcmpXSnZNMjJWTUNXb01VcTdMK0NyU0Zh?=
 =?utf-8?B?TVhybFdhMHNsRVdaZzlucnR0eUtvV0VRQm1HbUNnN3JCZjJDYmJEQVNVV2Nn?=
 =?utf-8?B?V0Q4NVRHamxXQnVNVHRyb2dpMVZRU2Mrbzd6WVBMdUNSZmpKd3FxdjU0aHRq?=
 =?utf-8?B?OU1qaVBsWUp1Nkx2QnptSUljTDRqLzN2bXVIQXJjNSthMWdNanBPSTFZWi9t?=
 =?utf-8?B?VmxOZm5jL1FOeGo5c3JyTlk3Ym4rRWplL2pURlRTZGxHSTdKelFoRHAzRGxZ?=
 =?utf-8?B?MTNTVElZU1ZaRDVQdnVpV29RNXBZS0EzMlRSQ2g4eFIvZEVvbmYwVEZIZE9u?=
 =?utf-8?B?NlZRbU1RMVdiMU5wRElhVis5ZUkzZTFkaEZOWG9wMm1wVE8xcURSMVB4eEk4?=
 =?utf-8?B?dVUrempBY0Qra2F5L0s5RkcyVmxEUnJncEpRTjk4cnBydDUxT3U4c3VwVTkz?=
 =?utf-8?B?NVFONXFzUUZBTmpWU285b2REekZOb0JWUFBOMXRSWHM4b2JvTHo2VjgrQXAz?=
 =?utf-8?B?WlJFb3BkN3MxK3Q2M0lERE5xaWx5cEhEN0F0TU5kUHpldXJNU3o0WlpCcE9t?=
 =?utf-8?B?NDExaDN5cHpGM3hpZ0NPSmQ1Tlk4bWcxMFlFckVNNU9GcVFGVnNua1NrZVRp?=
 =?utf-8?B?bGoxb1g2ZVFWWWI0b2s0d1lTaFRMY3NOUGg5MEk5WkhBd0oyVVovbGJjYzI5?=
 =?utf-8?B?YkxPRFBXSEJDUG5rUTdxQnJFN2JwWlZyMDhBU3JLeVlHbVJnMklxUGQ2T2hR?=
 =?utf-8?B?NG45dTdpb2plM0YrOTJ5MXl4SXRZVFdNZUtqekxheEhBS05RQ1dVQ1hDcHRs?=
 =?utf-8?B?bTdRLzBwWll5YmI4OEQ1blZHaXQzYmpQVmNTa04rRzRGeDAyM1Z2VWRvc1Uy?=
 =?utf-8?B?bzVFL05WbnFsYlhnSDhOU3ZVUzNseXduMHlYUzF5UnN0UW9tYVc3RDZnTHRy?=
 =?utf-8?B?NU5mY1F1cGlYMUxaeDU1ZE9MUG42TXRnM1FWSm5hckMzU0JDU0NrQXJCUDg0?=
 =?utf-8?B?UHZROHdCNUJwRS9aay9ueUpWalloNGpNVmhYNFRsdk5aeU0yRlZwdVhwc3V4?=
 =?utf-8?B?cm9tUys0VytLQUVXRk9NK1hJdXlHU0VlY1d5bnlGYXhNM0NpME1KcXBTdlFW?=
 =?utf-8?B?cjFOakhzamhGY0w3MWNobk5QVytmKzZmV3A4LzZQS28zUmx1WGkyWjdWNXlK?=
 =?utf-8?B?cGpPRFBYb29FSXhqelg1aExVOUdlaWxqNkFTdGllRUdKek42d29EK1h1bFpa?=
 =?utf-8?B?NUh2NmhwOHYxdkJGK2hvREJDN3dXTm1rWXJqeEticEtjdmI2bHJoQzVmY1R2?=
 =?utf-8?B?N21qQyt3STNXT0hSRVlIUlVhTmx2VjNjZStlNWtlUThiaHJDY1o5aTJoalVQ?=
 =?utf-8?Q?4ve7ZVKZBNMmMUwxRMPvpYcrtfFyUVlK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkNKRStQcHoyTC9JZVROeXpMSFlneFlBVVJvNmppamdyTFNsRXJlSHFPcVNa?=
 =?utf-8?B?UkZaUFJCbWtPbjlldXlBZlRQaUNDRU1MNTVadytWbHhKT0NhbWxTV0lBRkhr?=
 =?utf-8?B?aXVHNC9LQmc0NDRjUCt0L0RTLzBvelliTnJuY0RHaWZPVFordXN4ZG9Vdmpw?=
 =?utf-8?B?Q3ltTFUyc0Rrb0tEODNGYzFnb2JPVUZ6bXdQelk1eVQ3MS9ERUMrbHE0RmZp?=
 =?utf-8?B?VG94WnVJZ05IenNCbk5IQjc1aHJjVUFvRlUxZExOTU5WOTI1OGhobk9YTHV2?=
 =?utf-8?B?dmFMN0ZZdVVqQm5zSVRRRmduQWZlUGpyZFIxc04zU3lRS2xUcUlIL29UMU5V?=
 =?utf-8?B?amxpR05HK2dJVzMxL2JGVTNuVnEvRXZmSWgyL0FZQytBQUlLcFJZSGVwc2RM?=
 =?utf-8?B?d2N2TVdLbEgwdjJjMXpVN3B5OWZ1djNuVklieDM5alU4aVU5YUFjYldpTFpY?=
 =?utf-8?B?L05uNi9Pc2xBYkdCRDNRRVVKbFAzVlgrdTdabGMxZ0ZaMDg1QVFua0xrUml1?=
 =?utf-8?B?d1BWTk9lcG5Bem4vOEppNkFNLy91Q2d3MUVkMDk0cHl2bm10Z291Ujlqay9Q?=
 =?utf-8?B?NGJDbEIwYVNWUlpxMTBLbmp1SmRGalJ4N2YzS2plSnVxM1Q3dXFQNHpNRXBI?=
 =?utf-8?B?MXluZ1NqVEQwS0xWdEdsWFZ6RjlxOExyZEdiallzMTdYaVNWOTl0SmY0NDY5?=
 =?utf-8?B?cTRQOUFrTDYyQ2Q1UnlIemx2eXdSMXhtS0xUWHR4RGRUMHYzQlhnQy8rSk9G?=
 =?utf-8?B?UHhFd2gya0xjV25vQ0M1cEFTSjAwUExxUXpaODFWL0FBS2N5YUZIa1d4YnR6?=
 =?utf-8?B?L2RrWG5qMWl5Zmp2Vi9KM0VuVDFJUlJ3aldTdFZybTRreWRUSFZrRHprVDFK?=
 =?utf-8?B?VGM4aUlVcXdYZTZrdjdJNzVUZ05LcnprSElCRmErQzlBMVdkdWdRSnh4NmtZ?=
 =?utf-8?B?cjl6SXlLSmZicG8waHJsaGhHMDNYcXNsL25ac0NTS1Nnd3Zhd3FVdENvZElT?=
 =?utf-8?B?RlpiclRaY1YzYTQrNGhWZVJ2ZDIvZmxVc0xvMzdlUzBPTFhXalZGZFpTT1NK?=
 =?utf-8?B?VHlNZ0lyOHB4QzNZR3dmVkMzNW94R1YyNEt6dTBWdVZEMmhFdFd6eDZMRWN1?=
 =?utf-8?B?VGhpak5meU9BeGhnWHRLeHNCRUhBR3lXY2NiQlB4czZSSFFzOG1iS0lmVmNQ?=
 =?utf-8?B?TnBOdGdkVW5lSm5OUHk0cmZ3OGo5QTNTSlJXdFUrSmlZM3l4NWxJcmd0QUtH?=
 =?utf-8?B?YWZFcHJWY2s5WktiSG0wem1sMDdoTXl4Tk1OMjhuMlhlZjhoMkV6bjBNRDNS?=
 =?utf-8?B?VmdtKzJ2eDRMc1VWd3d6NXBoTmhhSjZPMlU5dmZqMXllMkFLNjkvaWZKRjVS?=
 =?utf-8?B?UDFlS1JxYytMV3h4YWIvcWh3YVBpOGg1ZzV3Ui9RWEZFMDZRWTFNVVl1ZGZt?=
 =?utf-8?B?M1lmajhsWkZocTN3MWU0RjdvRU9XeUNiZVNaMm9Lc1VoTnR2dUxyTUE2UTls?=
 =?utf-8?B?OStOU2xKSmdKL3VYL3NRK2RMb1JXT2J6cVRCMnhYZFd4NDd2UEF2d2xuRUNx?=
 =?utf-8?B?c2VNSjkvcXdhMzZPdEswbWNOZTlYeWk0RnpMUnpKZkJsVjdrNlVvSyt0M0hS?=
 =?utf-8?B?WXNBdjNqd0Q0NkxsbUNidFB5WFNaa3Q0eGljdmM5OS9pNmo5Y2pEcHZYT1Rl?=
 =?utf-8?B?eGVtNmtoWWROWVlvbVJQYXBBTXlnNnVFUnFiWFNseXJvZ1JzQUVZeUw1ZkdF?=
 =?utf-8?B?Y1ZDcVlkM3ZRLzNZS2lxeWRrMkw3YWFWdFR5NUF1QUh2czdaQWdIV2srNnky?=
 =?utf-8?B?Z0xENDFTeXRkSFBRbDZPOXVybExLYXFNOFdVUDRlRlFRQmxaQkZZUXVDWjdK?=
 =?utf-8?B?OG9IVmk2aiswZVo2bE1RNjNkVXJtSTgxTFB0Wm9aNVVvSXI5NmdySE5Bamdt?=
 =?utf-8?B?b0tJZjNXc1EvaUR5ZjBvbWVCbnQwNUJDcFUzWkxzeHhXYk1ma0IrUXdyYVJS?=
 =?utf-8?B?cElzRjJWNkJOYXVybVU0bUgzbGZmVXEzYkh3MlNieExGb2VhWXh6bkJDY1FH?=
 =?utf-8?B?aTlLQ1J5dGc1b0x6a3NQN0VkNW9pQ3lhR0pkWFJIbjZZRU5iMzdYNndrOUpR?=
 =?utf-8?Q?7TVoq+rD37rWl+tuoHjyTORGM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b557fb-d259-41dd-6b08-08ddfd83047a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 05:02:11.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKwnBghbl8saEQFlyaTMZAjcRJsD7NQgmKcnjDXOYw6chuPlhp4E/Pu4OhtmFX9YGqejpT5JyyJJuAl+IxTmsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

On 9/25/25 4:10 PM, Michael S. Tsirkin wrote:
> On Tue, Sep 23, 2025 at 09:19:15AM -0500, Daniel Jurgens wrote:
>> Filtering a flow requires a classifier to match the packets, and a rule
>> to filter on the matches.

>> +	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
>> +	ff_rule->classifier_id = cpu_to_le32(classifier_id);
>> +	ff_rule->key_length = (u8)key_size;
> 
> Do we know that key size is <256?

We set key size based on sizeof headers even if all 5 available were in
the key it would still be less than 256.

> 
> 
>> +err_ff_rule:
>> +	kfree(ff_rule);
>> +err_eth_rule:
>> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
>> +	kfree(eth_rule);
> 
> This is a weird way to handle errors. You never added or allocated eth_rule,
> which are you erasing and freeing here?
> 
> 

Yes, it was left behind during some refactoring. Thanks.


>> +	c = kzalloc(classifier_size +
>> +		    sizeof(struct virtnet_classifier) -
>> +		    sizeof(struct virtio_net_resource_obj_ff_classifier),
> 
> do we know all this math does not overflow?
> 

Yes, classifier size is based on size_ofs



