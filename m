Return-Path: <netdev+bounces-175199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28AFA64468
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B2A170AD5
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 07:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EE521B19F;
	Mon, 17 Mar 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KynU4Ozu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078BC5789D;
	Mon, 17 Mar 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198152; cv=fail; b=lUH2GFclMF6YviUiu1KCwUmqd5rKAQ2sTyZWOiJM8TEWt79sh8fm5t7vCRg1PMnYFZFpomMDj+YgxQ8D/xmrZgiKEtixQd39vueTrazMM7FvGYhMY3OhW73YcHMuW9UvZsRpNAbhDFBAC7sM9gQY9W7yvSgsF/Nw8YtLaTtfuR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198152; c=relaxed/simple;
	bh=2iBbO51SX/OP/fnpWnKTE6AerVdre5UCdg07OqP4zt0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oz0YVwEEF+G48jL+I4jLoFlbm7puV5SHWXy7mi5qsidKo4kcXteVZQrSjf/bo0NEW+6ll72soHSPDFsXrhuXcJPnJNsxQ6ZDD3dXGNOOOSxMYvB8/0CD0vGp0tgGgdA7PUhdbGHTj2CSnrMgmy8igYbsVh1XQGtz5omqBx3LMVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KynU4Ozu; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzreEaxEmahykmYnzka7y4tg5yONa3dw5bDSy9lb7F0+l3mUi3I6BX4FgOkqRSUF6ThnzS+w8bhyaSvyNvEbERHZwVpmhbLe0PPtKErd9LUVdfFPa9z75aONWHNmS5Kc9z4B6GX8f0AgOSAvPd2NZVBlcsuV9kszNfp7bVHjPwjUCuRGcJzyXYFFdvYm8nexOSNImJ0sa0cXW12gkrbMx/bL/0OBUh36wVU59r8F7eDgxZc0wizP1qEFuyYSNVliXeJ/16AMPedjHYxUNb3fp/3YVH2+Ik2kfT+0pCgDqVgkq66NPtTkC9JutV2uO8OSdy7aje7i5yWSjFHMwLgBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=speyElalTxLkYRpBcgNlmBC5LB1uots4puR9FKnMArg=;
 b=ELoU2e22QcfjDOit+YGQa8hbpmzntWroU0co5PNungZNMqN7FGbKLfZHZVxvPllbt4AciKep2rfZGW73TWlJkIHiMV8qHnBCVp2ilCyKU7D3xgG/P8HfT7vr5Q+JkKpqDC/ZsL1ohYTddA1Q+VSlLnWpiHgH3U3ZZmtf7Scu6m5C89AkVkh7mzqzUJ/ZbS8L30ihySxlyDhaVN9Un3w+2IwNJwLfvg9DL4VapJyKP/IxJEFzB87Sho5O31j3CLWzOWLLlT2YRqgBubvm8hqutlM0vDjwCRhXMqtZndibVxYL0nKgNGwJ84AGlWUaSLZLyjf6WNLL64o4v/gbjS1qFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=speyElalTxLkYRpBcgNlmBC5LB1uots4puR9FKnMArg=;
 b=KynU4OzunAKoykbXtc8/Oju4kl8hFe8GekfSgW357WiA5rofrdkbFc5hDj103XKtQNKOeXIdkLBlz5oNChfYfAcpa5U7MLCOBdqsU6YKViPO5DFh6tGLyK8gNNQE/NCwhzmxNwGEtPEjv0Dik0cHTluHla3pjrcg1RB+gCtH0qA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 07:55:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 07:55:47 +0000
Message-ID: <b472829d-c79e-4cf1-a789-427213fca28c@amd.com>
Date: Mon, 17 Mar 2025 07:55:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] add type2 device basic support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <Z9HK9A6Dh3h4Ui1q@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z9HK9A6Dh3h4Ui1q@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB7PR05CA0047.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::24) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: c01d0d11-e6dd-4aa8-f3e9-08dd65292071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UktBS1RrYm40UXFNQ09sSTdua0orZDZaVWxacjFzYnF1Nys1V0t0dmovVVVC?=
 =?utf-8?B?a0xqOUV6eXkrZUFzTkF5dENnTWxNTjROR1RKdHpFajIxcHA0eC94ajhmRGVH?=
 =?utf-8?B?cTdvQ0pQdmdCNUllcWtJV3BqdC9hd3F6Zk1LUm55YXlHckFxaFgrK1d5QVpq?=
 =?utf-8?B?VForWTVOUzdFMmhVQ3gxRUNTeEtPd2JBTzBHSy9qUnh0dnRneWZ2bEtDNVFF?=
 =?utf-8?B?NDd3cjhpVHk1ek9oODlHdGsyNzl4bVFQRElOL3Irb2kwd3FoMjMrZlJrZ1FO?=
 =?utf-8?B?NVMvQXhOWW9kNWx1YWVUTmRCUExpOU11T2s0aUNka1dNaUVBSW4rTkFLMm1L?=
 =?utf-8?B?Vnp6OUl1OVVRd1l4eXJQY0ZCSWtRVmdZTEp3akF0VVZWZFc2U0JJb2hESm5s?=
 =?utf-8?B?Zk9FVFphelNubENJa0oyYlBSWFNpMXFTMEZjVFpWWmZsVytuWEtUeG5aRHdY?=
 =?utf-8?B?TjVmYjFyMTBEV3U0dWRIeWo1MkMwbytjNTlncFVjMHdPeTZ2WU1nc1pQZndC?=
 =?utf-8?B?S21KUDdGQmJ0QkFzcWl3bU96dVF2amlDbnJzZ1orQWxIZWtjSk5CV09KaC96?=
 =?utf-8?B?Z04rZ2laVk9CTXlYa2ZHLzNYMUkyTUNmL0RUc2phajJ0UGJIbTB1b05MWHQ3?=
 =?utf-8?B?OUQ5cFV3N1ltN1VPUnM4WjVZeFVid0FaZU8rL1ZEZDMzWklvdFhmSFUwZis1?=
 =?utf-8?B?Z1hoZ24wMCtib01Id2dwWmdSK2poVFVSSEtoSGM4VGh3UkoyZktaYWYyRENl?=
 =?utf-8?B?anVXbWJ4ME5CMEFveXJUa3MrMVc1ZFhIRFdaQmlDZFVlSlN5aE5qTU1pcDcy?=
 =?utf-8?B?REplb0R3alJ2VVlpaHVOeWhUbUxDZFJ3ci9DOHBiOW5kWlRaY2lOWjUrbWFv?=
 =?utf-8?B?OGRldUZmS205NDFPUEVjNzhna1o3eGliKzh2b0J4cWNPQTZaZmFwR2ppaDQz?=
 =?utf-8?B?NE5iOFM1VUlHQTFzMVVLcmlBTTZWYnhlR0paT1d2R25FQ0JIRG9TbHp3aDVS?=
 =?utf-8?B?OEg3VDE3QzZiWEhlelBDSTV1RFNVKytvcUFaeXpCeVhFTVhaWnliOXF5c1Rr?=
 =?utf-8?B?am1hcUQ3am9BQlBlbUZxcEkzSEZVUWxsdHlwREQrZUZtWmpRS054RmFJSzhO?=
 =?utf-8?B?NGRVWnRWd2JsekdXYm40ZXBPMVJJVi9XYVhlL2IyZzg5M0hLYzlZOFR3b05z?=
 =?utf-8?B?dlhVc3AwZDl6RE4yTjhUdE1qRDY5MURZS0d6ZkR6dXpac2luck5JNW96ZXFB?=
 =?utf-8?B?UnRGUmpCelZuWEdTY3FsTHZRMkwxNVpWSHQweXRud2tKaU9tZDhSNG5XRVNp?=
 =?utf-8?B?Z09rZXhnRm1ORkZYQ0IwZU9veWlQRkNOcGVCY3NISFlqY0Nvb21GQmxSTEVq?=
 =?utf-8?B?QmRjQkljdHA4a21KeE1yZDJMemNyNEdRUEpkOTZxRDltMG9FMTZhWTMyd0lv?=
 =?utf-8?B?clRZbXVvS01wcUxtczQ1enVYTmNMT2RtTHZ0d2ptejVpUTRWQ3J2NDZEUy9i?=
 =?utf-8?B?ZjY4ZlFIVE5vNDVkZFlranF5ZzF0Z1picnh1Yzl0YlEzaVBCbTV0c0xzV3RK?=
 =?utf-8?B?Q1FhQW9YRlo5NE83L240QmliWlpLZThzVXoycE1SZmE5OWl6Y05mVlVVQlp0?=
 =?utf-8?B?bzMzRXo4ekt3UWRxUHJUS2Q5OGlMeFVaNXN2TC83ZmFLYUVuV0F5UUZHL2FQ?=
 =?utf-8?B?N2pnRk1vamlmTEJENUxGc1dqZGZ4WnhrR05JMXl2eXFYNmE1MWVkSVRBL2ZE?=
 =?utf-8?B?K3FqZkJ2TmRCbEU4YndMcUd1bVdvNjBPMFE4L04vODUzcVFtRzBUbzI2Tmh5?=
 =?utf-8?B?a1F2bDZvS0lNcnBHVWxNeG40K3pPNkI0QVVnQlRzWDRIWndjK3FuWkJoVEFh?=
 =?utf-8?Q?tsRNszxcJF17w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjVac2NuODUwYU5Tbk1iVnhRRmhJSjlwRm1TWkRHSFdWUGtZSUUvNTFkcE1O?=
 =?utf-8?B?bUlJTVJ5V1FMREZTck5GNE5JSXhuUzNyVlU3Q1NlZ2xwNjUvRlhnUFJwUE82?=
 =?utf-8?B?dlFZU2EyOU43YXJqYXRVWmdmN1Bma0gxT2F1SG8wWjVPdVBmSS9CeWhUVDB1?=
 =?utf-8?B?RDVtQkF1ZzYvM1RDT0c2a2NpYnc0MlRxaXpVd04ycDZVWFhaUExDeHRydlpy?=
 =?utf-8?B?SEdKeXJjTjV5T3owWlk4d1lnb2Z0aXo4OHZuMHJWem5vbzRjdlZBeCtFRWNY?=
 =?utf-8?B?dEEvbHVRQ1lnRVhrTEF1YVBPOEVGWk1iVXZxWjVuSlU1MmxRcm9qczIrSW1Y?=
 =?utf-8?B?a2t4MnNHSlNOZW11V1pkY3RrUFZPeUVYa1NZaVR6a3pGaDhkTTNENkR0RCtD?=
 =?utf-8?B?cnNQTW0vL1Vxd3pzMTBXdnRjc0hFRWk2b0pzNHQrczhmV1EyZXJnWUtrTGFK?=
 =?utf-8?B?TDN6dzFQblNwZGQrY2tiKzloUWFPeUovWjd3ZEowRmVxVTZBaG5VRmpiblpj?=
 =?utf-8?B?MmhMOW9hdWJXQVRBbmNzUU9qTzgrUFovOURBS2c1UWIvY2RrVllDSUtGYUh4?=
 =?utf-8?B?dXV2b3NRZG1OS01LSXdFcnMvdlZzTHpEOUR5aXc0aVU3Vkp2a3dVUkg5WnhY?=
 =?utf-8?B?S0lpQVhYTTZYalJvMEMyd0Ftd0F2Z3JaU1lxTzRUVDdFanlvbExrWWllRUxT?=
 =?utf-8?B?Y1NKOHhPdkoyZUVHNzZSdHJTRjBnQzVRL0JkR1k1UC9LUno3MWZaT1FIdGdp?=
 =?utf-8?B?eDdaQ3FlbEp6MnQwUy9UbEpmVGgzZjMrZ2poVGMxeE5IcFhoUHVBbUJEM1Fx?=
 =?utf-8?B?SW80WUV3Z3BBS3dUNDJIR0d5a0lBNnBBbWc3MXZGbUxPWTFQMlFpdkhXcDVi?=
 =?utf-8?B?SG5QOU0wR0Q5QmRJWUhERGtCQ09sZVArK1dtY0xtREdKMFdjMEVPS1BRbGxH?=
 =?utf-8?B?Zm1aLzRyNnlDcldYbkdXWTFTVVI0WGJxVmRPaklGZmRWeVU1SFJhRlhVSDM2?=
 =?utf-8?B?N1VYS3ArcTVIOWw2VWNDc0xVUnpPY01ISG1icHZYcVA4S3M2dGQ5cXVYbm81?=
 =?utf-8?B?bU5FOWpqN2JOQzJlaUdvWjloTG5XMnNHRE9OMTcrb1h1YWpEN1RoZENNalZK?=
 =?utf-8?B?U3plUVNIYmNYMjAxU214UWpPSld3QzBKV3RPMHVEQXprR1dPNXJQcTcrTng5?=
 =?utf-8?B?SFNXUjR0N1FnYXFMR3FtUkNPZWlTYjRCb09zQ1YzWkJta3o5MUZQZU5YdTJy?=
 =?utf-8?B?ME54NllUQTljUlhPVkRTbUtQRExHYncyVWszRWUxS05DT2syOEhYTFo5UFJL?=
 =?utf-8?B?bmcxZ25jQVNHaEFZK3I5VndkajlDcDJSS0QvVTh6YXJWcHZGNUZPRUZ3azFz?=
 =?utf-8?B?aSs4TDlrQ3d3aGpJOXR2RlNYYnVTQVl6dDBsQzBWdXVsSkF3bTN2M28wcS94?=
 =?utf-8?B?Y2lWbEs5WHZUM1MrTHVLRXhGNlBtb09ZNk4wY3NJV2FOZG9SUThNTmJiR041?=
 =?utf-8?B?ZTQrMmZmR3FpT0djVkFnWFJEYzlvYVZWNWFqRHVWZkNGNWl3cHdrUHRpRTZZ?=
 =?utf-8?B?VTBMZnVycFowTGxqalBuQ21XVVl5UVB4NGVnUmtqU20wZFRkam9yb1preTlQ?=
 =?utf-8?B?OFNPTXVCY3IvNjRJWlVSVmxDUnJxK292aENldmdVVmFPVHBCWFhkUm5XM1BZ?=
 =?utf-8?B?ZUJiUHRhMmVOVEpyNWdIWENIUkkvTzRtcDFtSlBjZitXcDJ6MEdVVGVodi93?=
 =?utf-8?B?RjhxSXF2VitZc1IrRmsxa3JLTmdSbTd2OFBkazFMV2ljbVFyK3hrcjhvN1ZJ?=
 =?utf-8?B?L2ZZbXpyQzUrZTJWUmQvM0Q4bnZ3cGdRTURCcGdRUlVCNTBPdlc5Q05zRG9K?=
 =?utf-8?B?ODlLTExkb1NIYjY1MWpQS05ZRmNKL2svdytxQ2hXT0JLTWVsNFN6V1QyeUI3?=
 =?utf-8?B?ODA1YTBxU1YvYWZOMFhvV3VKakU5TTVYV1c3YWJzU2h0bVkvN2NyTWhwL2FZ?=
 =?utf-8?B?SHVNdlNYMkxLZEFjd3h6Z2svcld1LzBhV2RmUGR2Qys1djEyM21GWGRDWmEz?=
 =?utf-8?B?blpaeHhwYTZHaXNCU1hTZUYweUd6RVlaRnM4L1JySjdJWmRla3pZRHUzNFF0?=
 =?utf-8?Q?BirmSSEyFC43ciUu2jVVzE7wy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01d0d11-e6dd-4aa8-f3e9-08dd65292071
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 07:55:47.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oXb97Pfy76igLxN6um2M7R2T1xqpODwHjFO3W+rGAxLjAIKhvzAGyVWt3eeFconAO7wB5vPGi9jPXD5lo36Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238


On 3/12/25 17:57, Alison Schofield wrote:
> On Mon, Mar 10, 2025 at 09:03:17PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
> Hi Alejandro,
>
> Can you restore a cover letter here?
> I'm particularly looking for more context around kernel driven region
> creation.


Opps, I did not want to have this dropping of previous versions and 
original RFC.


I will restore it properly for next version. Meanwhile, this is the 
missing text:


v10 changes:
  - Using cxl_memdev_state instead of cxl_dev_state for type2 which has a
    memory after all and facilitates the setup.
  - Adapt core for using cxl_memdev_state allowing accel drivers to work
    with them without further awareness of internal cxl structs.
  - Using last DPA changes for creating DPA partitions with accel driver
    hardcoding mds values when no mailbox.
  - capabilities not a new field but built up when current register maps
    is performed and returned to the caller for checking.
  - HPA free space supporting interleaving.
  - DPA free space droping max-min for a simple alloc size.

v9 changes:
  - adding forward definitions (Jonathan Cameron)
  - using set_bit instead of bitmap_set (Jonathan Cameron)
  - fix rebase problem (Jonathan Cameron)
  - Improve error path (Jonathan Cameron)
  - fix build problems with cxl region dependency (robot)
  - fix error path (Simon Horman)

v8 changes:
  - Change error path labeling inside sfc cxl code (Edward Cree)
  - Properly handling checks and error in sfc cxl code (Simon Horman)
  - Fix bug when checking resource_size (Simon Horman)
  - Avoid bisect problems reordering patches (Edward Cree)
  - Fix buffer allocation size in sfc (Simon Horman)

v7 changes:

  - fixing kernel test robot complains
  - fix type with Type3 mandatory capabilities (Zhi Wang)
  - optimize code in cxl_request_resource (Kalesh Anakkur Purayil)
  - add sanity check when dealing with resources arithmetics (Fan Ni)
  - fix typos and blank lines (Fan Ni)
  - keep previous log errors/warnings in sfc driver (Martin Habets)
  - add WARN_ON_ONCE if region given is NULL

v6 changes:

  - update sfc mcdi_pcol.h with full hardware changes most not related to
    this patchset. This is an automatic file created from hardware design
    changes and not touched by software. It is updated from time to time
    and it required update for the sfc driver CXL support.
  - remove CXL capabilities definitions not used by the patchset or
    previous kernel code. (Dave Jiang, Jonathan Cameron)
  - Use bitmap_subset instead of reinventing the wheel ... (Ben Cheatham)
  - Use cxl_accel_memdev for new device_type created (Ben Cheatham)
  - Fix construct_region use of rwsem (Zhi Wang)
  - Obtain region range instead of region params (Allison Schofield, Dave
    Jiang)

v5 changes:

  - Fix SFC configuration based on kernel CXL configuration
  - Add subset check for capabilities.
  - fix region creation when HDM decoders programmed by firmware/BIOS (Ben
    Cheatham)
  - Add option for creating dax region based on driver decission (Ben
    Cheatham)
  - Using sfc probe_data struct for keeping sfc cxl data

v4 changes:

  - Use bitmap for capabilities new field (Jonathan Cameron)

  - Use cxl_mem attributes for sysfs based on device type (Dave Jian)

  - Add conditional cxl sfc compilation relying on kernel CXL config 
(kernel test robot)

  - Add sfc changes in different patches for facilitating backport 
(Jonathan Cameron)

  - Remove patch for dealing with cxl modules dependencies and using sfc 
kconfig plus
    MODULE_SOFTDEP instead.

v3 changes:

  - cxl_dev_state not defined as opaque but only manipulated by accel 
drivers
    through accessors.

  - accessors names not identified as only for accel drivers.

  - move pci code from pci driver (drivers/cxl/pci.c) to generic pci code
    (drivers/cxl/core/pci.c).

  - capabilities field from u8 to u32 and initialised by CXL regs 
discovering
    code.

  - add capabilities check and removing current check by CXL regs 
discovering
    code.

  - Not fail if CXL Device Registers not found. Not mandatory for Type2.

  - add timeout in acquire_endpoint for solving a race with the endpoint 
port
    creation.

  - handle EPROBE_DEFER by sfc driver.

  - Limiting interleave ways to 1 for accel driver HPA/DPA requests.

  - factoring out interleave ways and granularity helpers from type2 region
    creation patch.

  - restricting region_creation for type2 to one endpoint decoder.

  - add accessor for release_resource.

  - handle errors and errors messages properly


v2 changes:

I have removed the introduction about the concerns with BIOS/UEFI after the
discussion leading to confirm the need of the functionality implemented, at
least is some scenarios.

There are two main changes from the RFC:

1) Following concerns about drivers using CXL core without restrictions, 
the CXL
struct to work with is opaque to those drivers, therefore functions are
implemented for modifying or reading those structs indirectly.

2) The driver for using the added functionality is not a test driver but 
a real
one: the SFC ethernet network driver. It uses the CXL region mapped for PIO
buffers instead of regions inside PCIe BARs.



RFC:

Current CXL kernel code is focused on supporting Type3 CXL devices, aka 
memory
expanders. Type2 CXL devices, aka device accelerators, share some 
functionalities
but require some special handling.

First of all, Type2 are by definition specific to drivers doing 
something and not just
a memory expander, so it is expected to work with the CXL specifics. 
This implies the CXL
setup needs to be done by such a driver instead of by a generic CXL PCI 
driver
as for memory expanders. Most of such setup needs to use current CXL 
core code
and therefore needs to be accessible to those vendor drivers. This is 
accomplished
exporting opaque CXL structs and adding and exporting functions for 
working with
those structs indirectly.

Some of the patches are based on a patchset sent by Dan Williams [1] 
which was just
partially integrated, most related to making things ready for Type2 but none
related to specific Type2 support. Those patches based on Dan´s work 
have Dan´s
signing as co-developer, and a link to the original patch.

A final note about CXL.cache is needed. This patchset does not cover it 
at all,
although the emulated Type2 device advertises it. From the kernel point 
of view
supporting CXL.cache will imply to be sure the CXL path supports what 
the Type2
device needs. A device accelerator will likely be connected to a Root 
Switch,
but other configurations can not be discarded. Therefore the kernel will 
need to
check not just HPA, DPA, interleave and granularity, but also the available
CXL.cache support and resources in each switch in the CXL path to the Type2
device. I expect to contribute to this support in the following months, and
it would be good to discuss about it when possible.

[1] 
https://lore.kernel.org/linux-cxl/98b1f61a-e6c2-71d4-c368-50d958501b0c@intel.com/T/

> --Alison
>
>> v11 changes:
>>   - Dropping the use of cxl_memdev_state and going back to using
>>     cxl_dev_state.
>>   - Using a helper for an accel driver to allocate its own cxl-related
>>     struct embedding cxl_dev_state.
>>   - Exporting the required structs in include/cxl/cxl.h for an accel
>>     driver being able to know the cxl_dev_state size required in the
>>     previously mentioned helper for allocation.
>>   - Avoid using any struct for dpa initialization by the accel driver
>>     adding a specific function for creating dpa partitions by accel
>>     drivers without a mailbox.
>>
>> Alejandro Lucero (23):
>>    cxl: add type2 device basic support
>>    sfc: add cxl support
>>    cxl: move pci generic code
>>    cxl: move register/capability check to driver
>>    cxl: add function for type2 cxl regs setup
>>    sfc: make regs setup with checking and set media ready
>>    cxl: support dpa initialization without a mailbox
>>    sfc: initialize dpa
>>    cxl: prepare memdev creation for type2
>>    sfc: create type2 cxl memdev
>>    cxl: define a driver interface for HPA free space enumeration
>>    fc: obtain root decoder with enough HPA free space
>>    cxl: define a driver interface for DPA allocation
>>    sfc: get endpoint decoder
>>    cxl: make region type based on endpoint type
>>    cxl/region: factor out interleave ways setup
>>    cxl/region: factor out interleave granularity setup
>>    cxl: allow region creation by type2 drivers
>>    cxl: add region flag for precluding a device memory to be used for dax
>>    sfc: create cxl region
>>    cxl: add function for obtaining region range
>>    sfc: update MCDI protocol headers
>>    sfc: support pio mapping based on cxl
>>
>>   drivers/cxl/core/core.h               |     2 +
>>   drivers/cxl/core/hdm.c                |    83 +
>>   drivers/cxl/core/mbox.c               |    30 +-
>>   drivers/cxl/core/memdev.c             |    47 +-
>>   drivers/cxl/core/pci.c                |   115 +
>>   drivers/cxl/core/port.c               |     8 +-
>>   drivers/cxl/core/region.c             |   411 +-
>>   drivers/cxl/core/regs.c               |    39 +-
>>   drivers/cxl/cxl.h                     |   112 +-
>>   drivers/cxl/cxlmem.h                  |   103 +-
>>   drivers/cxl/cxlpci.h                  |    23 +-
>>   drivers/cxl/mem.c                     |    26 +-
>>   drivers/cxl/pci.c                     |   118 +-
>>   drivers/cxl/port.c                    |     5 +-
>>   drivers/net/ethernet/sfc/Kconfig      |     9 +
>>   drivers/net/ethernet/sfc/Makefile     |     1 +
>>   drivers/net/ethernet/sfc/ef10.c       |    50 +-
>>   drivers/net/ethernet/sfc/efx.c        |    15 +-
>>   drivers/net/ethernet/sfc/efx_cxl.c    |   162 +
>>   drivers/net/ethernet/sfc/efx_cxl.h    |    40 +
>>   drivers/net/ethernet/sfc/mcdi_pcol.h  | 13645 +++++++++---------------
>>   drivers/net/ethernet/sfc/net_driver.h |    12 +
>>   drivers/net/ethernet/sfc/nic.h        |     3 +
>>   include/cxl/cxl.h                     |   269 +
>>   include/cxl/pci.h                     |    36 +
>>   tools/testing/cxl/Kbuild              |     1 -
>>   tools/testing/cxl/test/mock.c         |    17 -
>>   27 files changed, 6186 insertions(+), 9196 deletions(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
>>
>>
>> base-commit: 0a14566be090ca51a32ebdd8a8e21678062dac08
>> -- 
>> 2.34.1
>>
>>

