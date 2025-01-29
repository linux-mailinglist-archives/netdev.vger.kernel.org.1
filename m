Return-Path: <netdev+bounces-161449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC85A217DF
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 08:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332753A72C0
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 07:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0CA1917D7;
	Wed, 29 Jan 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iKtKtpWO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9A189916
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134381; cv=fail; b=sttZuvKrkBWqcIynICajnJGUfRnU1gSVRsyagSVYTVJlywA4E1nGLQfS2IHNsHkjq8gnfRvY7B0ZBuI/uRfB+qWgBUago2/iMaj01Ghstaq1oH41BUKBROPdZm+n5pRsvNYT40/8lDFC678Vj0vStAGnewMTJP8xvB0j5XcZ+3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134381; c=relaxed/simple;
	bh=fMvGSeVR+O74SqoksMcyuqnnH7ejno2MmzNAuxTWZbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B4V1cWZfaW+g/O2reFzxAyfjyg1FqgnzCufnItS/W0DwZf/GTx622/oBOve0t3Q8XP3HSdScbkU57yxjaGUXIkyHsNWaapnC9YWnuemjt2inewl99e3GXdYuB+v8pWerwqmAzGlpFZfROi67jy3IRrw+uG4N6O8VR/OFmVcZ9pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iKtKtpWO; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qp5xb9S/XD1rh3o9y+Fm8dEEb5VQDhpoHhRx597cdI8xYzKUGZns6BlXOsXIfnlL0DwxK2WVIdH+psJiRy4Kcwdl3rwRTxNt99vBFV/sv2OmV9K9bQtKUgGUIz8y/NguUHs4EIG953gYe+0gIbnqWLFpjd9op17AeCkkBqUYkzv3IozM2K2gbtWAhSNZt+tXZQE9ePI7SkeuEhehXyszrRyqJHDlyCxOxvOWGYolN6/vzSgz05txC5ZrEBgGS9zoC5dk7r+5EBJ7CftpJ6EAOA+ugfPSwuNcv+McPi6aFM/4Mc8Tty188IS6vlz7nYKLhpF0vbASjkGFxpoAsJZkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMvGSeVR+O74SqoksMcyuqnnH7ejno2MmzNAuxTWZbE=;
 b=yCEirZIkotvuFMMu4M7oZYkjSg+O/ROdkvHkoGb/IvxRa14mo+kAlTThvv/XwpbESBNZiIhDMxLfF6y6HKgK2Mtgso7oy2+2l/pgzoSaGF8zzcseQZxKopn5zWNVcDWWblUBeB6WilrXkrMwP/AvLPm0JIIcZ3js45+V8/AikEoXz77EdOY0ij1ImxvS7+I657L16jifBGMExw8wnPf8EcDTm8RPu8OoJC7M53b82wVhkOcKC5eliQoNi5iqBT532qY7wUDNYIpWXIPk9UEaZVQcqwt9UJWP6+OxXlmMhkaBZK9iprWuT/cCGA8BzgS5wSE8t7epQYy69AU9I0LGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMvGSeVR+O74SqoksMcyuqnnH7ejno2MmzNAuxTWZbE=;
 b=iKtKtpWOz1+/2BjyHyA9QbRdZbZzh6lQj9PTHb3W8XusgJheqBqfN2OmK2WdfkJPSLfjium157v4e4ymRRqledOJbTam0eo1Ab2GF7YnE4IlA4MksY1Snt1IivBLxu9dN1yo1mym0pwnesnfIhZqw6jpgYwgDDWWgdWEddOppIvlYNvDLS0Dv7r+mU33Wi84UXROMlCPRrB4k35iYDhogL/Nlk+Fv+BVFATr5COedzaWm9TQbt36VTeE481Wxrfxtfh1PwXU743wyG/gcL81ZuATJ/RcqlrZIOj3ARrUbDxm++1PsJXET6G1UL2FVm+CkNX7HKNtuWTb1sjCRmVeTg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 07:06:15 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%5]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 07:06:09 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mkubecek@suse.cz"
	<mkubecek@suse.cz>, "matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, Amit Cohen
	<amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: RE: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Thread-Topic: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Thread-Index: AQHbb+l4mmigAbpb8kyWjZyRHuAtqrMrD+QAgAEebmCAAJRtgIAAlESA
Date: Wed, 29 Jan 2025 07:06:09 +0000
Message-ID:
 <DM6PR12MB4516FF124D760E1D3A826161D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
	<20250126115635.801935-9-danieller@nvidia.com>
	<20250127121258.63f79e53@kernel.org>
	<DM6PR12MB45169E557CE078AB5C7CB116D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250128140923.144412cf@kernel.org>
In-Reply-To: <20250128140923.144412cf@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SA1PR12MB8163:EE_
x-ms-office365-filtering-correlation-id: e06bc890-eec2-402b-756c-08dd4033684b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3RjVVMxZklacUpXa0RITTVnZ2dkd3pPUzFOblVUVEtGRDNIYi8vbkZWc0py?=
 =?utf-8?B?VHkrbWRuY0p4VW1HamhEREFEaXBNQ3ZyUmw5Y1NIM2E1bjdaQjhEQW5aQUpB?=
 =?utf-8?B?bWJzMWdRem9mc0ViL1hUVmVGTCtIeEdNMExDbmgxd0hIRGNBdUxLT0pJMjBh?=
 =?utf-8?B?ckRabi9OSU9BbksxVGVwV2VWdlRhckYxUjM2SEdab1RJTWFLSjhqTE1SUTl3?=
 =?utf-8?B?TTZPTTcvTGc3aUVmTzhWV3VVUFVTZkk3WlI4R25nYzFlWENLMUJkZXlkeThX?=
 =?utf-8?B?NkNqT09wSkI0Rkp3anZuaHFRRERSY1NkWmdPTi9QYWQramFSdXVMT1lzb2Yv?=
 =?utf-8?B?Z3JnVmFoL2lRbkRGSVJKRURCRGVsaHNHUi9uWkdqSUNMZ3ZOK2hudkFxRER1?=
 =?utf-8?B?V09MTGJFOHcza3BYTDExcktab21rU0JPdWJicENlMlhXMjFCWVlYT0lvTFlN?=
 =?utf-8?B?TllrRnZ3OWxvdlpqTXZ0dUFSNENkbXdZbzd6Y0szQ0ZKUUJDT2Y4cUxCU2Q2?=
 =?utf-8?B?RWROYUN3SElxdkhpN0Q3Um4wVHJGTWJyVVdabStVOXZ4ZXZBVm5wRHU2Qkkz?=
 =?utf-8?B?NGQrMzhhOE1ZelpLbFZSWWhNWndwQjRDbS94Y3RhM1FyazdYQ3BNUmZxajlZ?=
 =?utf-8?B?NWRyL1ZueXJ4OUU1VDFtMjVReE9SSkNFeDZtUDhYOGk3R0tTMndHNXZrRjFH?=
 =?utf-8?B?eGFjS0NKNHFybHoyeDBQREJwR0hXWmVBMXNycUx2MDI0RlNNeUY3Qm1SVzRp?=
 =?utf-8?B?UEduWnNwWUJzUzEyWUI1RG1WUklMNFBDZk5MUXg4TTBEa2xyWTBHVTlmMXdH?=
 =?utf-8?B?bjl3QktMcklMK3ZXU0tKbW0xQnFLRVpOUEJjZTBCbTVmNTc0Z0xGRERhaEJl?=
 =?utf-8?B?UFk4OC9HY2M2VFBXNUwzZVNoSDFOUmJQT1BmZyt6aHFDWmNndUVtYmprZTZs?=
 =?utf-8?B?RjZ4clo0R2YwaTBtdmdNSVBHeUJZR2FlU0RPVllvTnM1clJpT2dXSWpJZjlq?=
 =?utf-8?B?bG9EaExiaUEvTjFQYzJYbzMyV212bHVWRHUwZzlnekorUVBJYldURlp5dnNL?=
 =?utf-8?B?UGZQc0pZeWxEVVl1a1laOXczZWU1eTJnK0xmUDJHTU1yMFdzc3NJendPY3Fl?=
 =?utf-8?B?NUw3UzV6Y2tEbEhjMVluQXd1K0hIMTlUZWFpSU1YeVpVWGpOaDRpYisyVExO?=
 =?utf-8?B?bGdwRjJMZjY3TjRlVmI4bHFqK3FMcjlYT0hhdGtrYVVaZkp4YisrL0xQS1Mv?=
 =?utf-8?B?VGRtUWVzK20xeFFJZU1NQkIySVY5YStVMXRGdWh2MlFtUEVpRXJrYXpFMWVP?=
 =?utf-8?B?d3lONmhyV3lKZ09ZNUlkL29Rai9YSHc0VXgvd0VReWFiMENXQVlieEVVSDhI?=
 =?utf-8?B?RmplTkVxd0ZEbmEyaEY3eUs0Z1JYRW0zNThJNlowVis4N0s5MWFCcjRQU0RO?=
 =?utf-8?B?emx3L1JpaFZTZTJWaE9hbklnUDBsWnpzdWZSVzU3V0cvM0U3S2I5RWw3SUhS?=
 =?utf-8?B?d2xRNXhUaXRud2pVTS9rK3BFZXl0M3krY0hNUVpFbUNDbUUrZ0FRajc5UUpO?=
 =?utf-8?B?NFZlSTJzVGNlSXlwOTRxUDZsNkZxODJUODFBSFI1bm5xUk9xQ0hYOEtvNC9H?=
 =?utf-8?B?cEhvVC83UjZHTWxrQjYya2xGU1I1bEhVMElBalhQemFWOE1BVVZsblZhNFRo?=
 =?utf-8?B?aWxsdXFxMmhXTXBKYzhtZjVIZmdqTlgwSWlpZm9OSlh5RGhXY21zS3dhU2ww?=
 =?utf-8?B?ZzNxQmNid0VzV3RFT21wR2RzQU1pSVJGbDVtRnRnYUxicnJwVGE4MmZWajhp?=
 =?utf-8?B?VHZQZUZDckpLZEkrZGVvWmFCWnFKY01ENTB5azR6TU1PK0tCamV3M0NPajc2?=
 =?utf-8?B?YmhzWXJIVklBcUxQSnNPUXdLZHhWR3hrQzZzdUZoOUFLWFpjeUtBZXVkUi9R?=
 =?utf-8?Q?XFfbTH5PuMJSsgLSUq9vBNsf4A24K15K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlNRSlN2cSs5NW9PbmhHUGxCU1NNWEJVM1FzejlrclF1VnU3RURCNjh0RHFr?=
 =?utf-8?B?TTYrVTFkc1kxd0x4TEYyMWI1S1NaQ3VVUUhzQzNCbmVTNDhrSlAzKzVZRks3?=
 =?utf-8?B?ODlqdERuMnZRRmUwWkZJSzltQVlWV1pKZnVPeXFETVVCTFI1KzZTQzZUWm9w?=
 =?utf-8?B?VG90NjFjNEltRXRhOW81WE13Q3AxajZiMmxoMHJPMXJZM3JBNE5UYU5KRGls?=
 =?utf-8?B?RWhNQTZXVDAxNXVWcjNXSWRZSTZVNm1CdkVwQlR6SytqNUVUYkVsMVdXTEFj?=
 =?utf-8?B?ZTJGZFRPTGJQZ09udllSWmZqbkN0VkxPSS9OQ1krM2hha3hOTTJEd0d3cG51?=
 =?utf-8?B?OCtUVHdVbFFPYlRQVFBHa3h0VHdDTzNMTEVIekpRbE9SeXJlRE1ETWFOTVVv?=
 =?utf-8?B?Sm9iaitrUk42RDA5TjNiaGs0RVB3UVpxSUdmUHlqbXFVSUMyb2V1TlZFREww?=
 =?utf-8?B?YS90WHpQUCtuSlJQaDNFcGhJY3RXUmZxVmduenJ0UmRqdGJzYjdzekRacWgr?=
 =?utf-8?B?UXZFV0g4SldWaXFTYno5RG5BSVVER1FIdXU0VTVmOCtGOCtNR0hLUHA0WCtY?=
 =?utf-8?B?SVJIMjlXT3lVY2FSOHBPTGhGbnltdDNrRjdLcFhhMkNFaE5qZHY2bXhRalRQ?=
 =?utf-8?B?emFXNUFiUXUzTzdNd2htYVd4bzNXTUl3S3V5bHdHTzNLdGJ5VCs0N2ltMGVt?=
 =?utf-8?B?dzVibWRETWxESGlXRTU5WXlxQnJvSGcvVnhsRm9iQWFMUjljTk5IL3RCOUxs?=
 =?utf-8?B?Vlk1NGNmbjFTWDE5YVpHcjlnUCtxTXFWdHgxSkZ5TGxKQUJ3MU9tQUNtN3c2?=
 =?utf-8?B?QlFQSGpObCtaQXpWNE1ndzNRRTQ1aWsxT0c1cERvOWNJa3NiRTJzbjRoYTJy?=
 =?utf-8?B?TmFRNzdoV3FLZTVsUEVqT251NkIvc201VnE5VEJ3SG1JWGJ2OHVHN2JUU24w?=
 =?utf-8?B?OVdyNFBMQXMyQWJ4STdOcnIwbUhnTnhrLyttUmhHUHJPcy9PY0ZmMjdlSlFz?=
 =?utf-8?B?Rzc3UG9TN3NhcFVvLy8xU1hJK2lnNk5qZkhMZlhhR2RyUHk5K0dKb09jbytm?=
 =?utf-8?B?c1JoWC8xQjcvYjBxR21JY0ZKcitEbkZ6MzI5WlBYbFhOeU1raGkrN0NJQ3VO?=
 =?utf-8?B?ZnpCZ1lBK3dlcEpCQnFWV055bW5kTm5iK0dZUXFDRkFZRzg1Mkx0RGcrL1BJ?=
 =?utf-8?B?NDNBSGgrYUhQUVNRejkvQlY5U2s2SXh3NDUzNVF6ZGdYaU9CZ25saFI2d2JB?=
 =?utf-8?B?ZEV3TnVSbTh1M2ovSFRJSWZZNUZaTldTUVAraG4zcmIxdXUxaDhhSXQxK01n?=
 =?utf-8?B?ZXk1YXhhZUtZb25PdFZROW4zZ3RGK3k5dC85aElEVUNPeWVrRjNoQ2FhNGlG?=
 =?utf-8?B?N01aL2VHb1FjNjYvb0pkMWpHOGNaVzJ6QXd1Q0RlR09QcldZM2E0NWdwTjBT?=
 =?utf-8?B?MEYrSlZ4T1loZ3ZoOVZlUTZJVlVsd2FjZmY0QjdMTzE3R2kwWTRIaG9jSnhL?=
 =?utf-8?B?dThua08zendvQldTcHRpMXFLdmFZV0ZPVFgxckZGU0xWM1FhZDJWcjh2SEFG?=
 =?utf-8?B?VnlwZFJBUUJpMWp1ZXhCbmlTU2V1SEJNMzE5TFJpOFExbkYrRTBLMVZ5UE5H?=
 =?utf-8?B?OGJLNlk0OEcyaHByNnY3dlFtenFJc0ZwTk5pbTBiY1l6UVlDNGozWGZXSlUz?=
 =?utf-8?B?dUVZYWZIRldWMy9uSTlsSmQybUFMby9iRWpHUHduMFVNWElxMHUwRkwxKzI4?=
 =?utf-8?B?cWFCM1dWTlRqV0RuM21yZEo2MEZ0dXlDWXY0emJ3YS82T1hqcW1pdXZ6a3Qw?=
 =?utf-8?B?cjFmOFFQazA2Yk9wdmhCK0FMaHZNVyt3TmUwZFN4SVVUQlkrOFRZQnlYREhh?=
 =?utf-8?B?ZnIrelY3N3hMWXFiZUFEcTJiU1hCU0MrRDlCWUROcDhGa3NGY3RjUVR1WGNW?=
 =?utf-8?B?TG8xdGNtU2E3Z0pKYS9zMTFZNFRrYWZ6MHBla1U1KzFhZE9QNEVBOTArWGdy?=
 =?utf-8?B?QWpMYXQ5bzFabFVOQXNUMHV4UWE1ZmZHajZRSmdWSDBFaGhSciszV1lKbHVI?=
 =?utf-8?B?MTZVY085WEZqSTBrZXJtdEJGNThLV09wVkhmRkVPZ29tSlVJcDRReDZZYkpo?=
 =?utf-8?Q?WXj3FQ+sPVzRTwXdKdOIozC4d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06bc890-eec2-402b-756c-08dd4033684b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 07:06:09.3419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTIMsg5y/1GvgEwt1Nl1o0yZVZ6vUVtAgw+nISn4o9ko8riWGG/uVFl8ESqXMCEkA2TU5WyO3RtaRHynY+I6mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163

PiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNk
YXksIDI5IEphbnVhcnkgMjAyNSAwOjA5DQo+IFRvOiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxl
ckBudmlkaWEuY29tPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbWt1YmVjZWtAc3Vz
ZS5jejsgbWF0dEB0cmF2ZXJzZS5jb20uYXU7DQo+IGRhbmllbC56YWhrYUBnbWFpbC5jb207IEFt
aXQgQ29oZW4gPGFtY29oZW5AbnZpZGlhLmNvbT47IE5CVS1tbHhzdw0KPiA8TkJVLW1seHN3QGV4
Y2hhbmdlLm52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggZXRodG9vbC1uZXh0IDA4
LzE0XSBjbWlzOiBFbmFibGUgSlNPTiBvdXRwdXQgc3VwcG9ydCBpbg0KPiBDTUlTIG1vZHVsZXMN
Cj4gDQo+IE9uIFR1ZSwgMjggSmFuIDIwMjUgMTM6MTg6NTQgKzAwMDAgRGFuaWVsbGUgUmF0c29u
IHdyb3RlOg0KPiA+ID4gPiAgICAgICAgICJtb2R1bGVfc3RhdGUiOiAzLA0KPiA+ID4gPiAgICAg
ICAgICJtb2R1bGVfc3RhdGVfZGVzY3JpcHRpb24iOiAiTW9kdWxlUmVhZHkiLA0KPiA+ID4gPiAg
ICAgICAgICJsb3dfcHdyX2FsbG93X3JlcXVlc3RfaHciOiBmYWxzZSwNCj4gPiA+ID4gICAgICAg
ICAibG93X3B3cl9yZXF1ZXN0X3N3IjogZmFsc2UsDQo+ID4gPiA+ICAgICAgICAgIm1vZHVsZV90
ZW1wZXJhdHVyZSI6IDM2LjgyMDMsDQo+ID4gPiA+ICAgICAgICAgIm1vZHVsZV90ZW1wZXJhdHVy
ZV91bml0cyI6ICJkZWdyZWVzIEMiLA0KPiA+ID4gPiAgICAgICAgICJtb2R1bGVfdm9sdGFnZSI6
IDMuMzM4NSwNCj4gPiA+ID4gICAgICAgICAibW9kdWxlX3ZvbHRhZ2VfdW5pdHMiOiAiViIsDQo+
ID4gPiA+ICAgICAgICAgImxhc2VyX3R4X2JpYXNfY3VycmVudCI6IFsNCj4gPiA+ID4gMC4wMDAw
LDAuMDAwMCwwLjAwMDAsMC4wMDAwLDAuMDAwMCwwLjAwMDAsMC4wMDAwLDAuMDAwMCBdLA0KPiA+
ID4gPiAgICAgICAgICJsYXNlcl90eF9iaWFzX2N1cnJlbnRfdW5pdHMiOiAibUEiLA0KPiA+ID4N
Cj4gPiA+IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdGhlIHVuaXRzPw0KPiA+ID4gSWYgdGhleSBt
YXkgZGlmZmVyIG1vZHVsZSB0byBtb2R1bGUgLSBzaG91bGQgd2UgYWltIHRvIG5vcm1hbGl6ZSB0
aG9zZT8NCj4gPg0KPiA+IE5vdCBzdXJlIGlmIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLiBX
aGF0IGRvIHlvdSB3aXNoIHRvIG5vcm1hbGl6ZSBhbmQNCj4gaG93Pw0KPiANCj4gSSBkb24ndCB1
bmRlcnN0YW5kIHRoZSAiX3VuaXRzIiBrZXlzLCBiYXNpY2FsbHk6DQo+IA0KPiAgICAgICAgICJt
YXhfcG93ZXIiOiAxMC4wMDAwLA0KPiAgICAgICAgICJtYXhfcG93ZXJfdW5pdHMiOiAiVyIsICAg
ICA8PA0KPiAJWy4uLl0NCj4gICAgICAgICAgICAgImxvd193YXJuaW5nX3RocmVzaG9sZCI6IDAu
MTU4NSwNCj4gICAgICAgICAgICAgInVuaXRzIjogIm1XIiAgICAgICAgICAgPDwNCj4gDQo+IG9y
Og0KPiANCj4gICAgICAgICAibGVuZ3RoXyhzbWYpIjogMC4wMDAwLA0KPiAgICAgICAgICJsZW5n
dGhfKHNtZilfdW5pdHMiOiAia20iLCAgPDwNCj4gICAgICAgICAibGVuZ3RoXyhvbTUpIjogMCwN
Cj4gICAgICAgICAibGVuZ3RoXyhvbTUpX3VuaXRzIjogIm0iLCAgIDw8DQo+IA0KPiBXaGF0IGFy
ZSB0aGVzZSBmb3I/DQo+IA0KPiBJcyB0aGUgY29uc3VtZXIgb2YgdGhlIEpTT04gb3V0cHV0IHN1
cHBvc2VkIHRvIGJlIHBhcnNpbmcgdGhlIHVuaXRzIGFuZA0KPiBtYWtpbmcgc3VyZSB0byBzY2Fs
ZSB0aGUgdmFsdWVzIGV2ZXJ5IHRpbWUgaXQgcmVhZHMgKGUuZy4gZGl2aWRlIGJ5IDEwMDAgaWYg
aXQNCj4gd2FudHMgVyBidXQgdW5pdCBpcyBtVyk/DQo+IA0KPiBPciB0aGUgdW5pdCBpcyBmdWxs
eSBpbXBsaWVkIGJ5IHRoZSBrZXksIGFuZCBjYW4ndCBjaGFuZ2U/IElPVyB0aGUgdW5pdCBpcyBv
bmx5DQo+IGxpc3RlZCBzbyB0aGF0IHRoZSBodW1hbiB3cml0aW5nIHRoZSBjb25zdW1lciBjYW4g
ZmlndXJlIG91dCB0aGUgdW5pdCBhbmQgdGhlbg0KPiBoYXJkY29kZSBpdD8NCg0KWWVzLCB0aGUg
dW5pdCBpcyBpbXBsaWVkIGJ5IHRoZSBrZXkgaXMgaGFyZGNvZGVkLiBTYW1lIGFzIGZvciB0aGUg
cmVndWxhciBvdXRwdXQsIGl0IHNob3VsZCBnaXZlIHRoZSBjb3N0dW1lciBpZGVhIGFib3V0IHRo
ZSBzY2FsZS4NClRoZXJlIGFyZSBhbHNvIHRlbXBlcmF0dXJlIGZpZWxkcyB0aGF0IGNvdWxkIGJl
IGVpdGhlciBGIG9yIEMgZGVncmVlcy4gU28gb3ZlcmFsbCAsIHRoZSB1bml0cyBmaWVsZHMgc2hv
dWxkIGFsaWduIGFsbCB0aGUgZmllbGRzIHRoYXQgaW1wbGllcyBzb21lIHNvcnQgb2Ygc2NhbGUu
IA0K

