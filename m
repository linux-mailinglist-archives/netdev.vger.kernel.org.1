Return-Path: <netdev+bounces-115510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 508D1946CD0
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 08:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF884B20C82
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 06:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B01078B;
	Sun,  4 Aug 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tGOajxq/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C9C2FC
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722753673; cv=fail; b=mf8Y7W9di+L4owSX6RB1R6/7eXgt/oylyf93zQlH/Vn2H2AKi9WrBmj+JMsEugoaaS7do5bWeUD2FHF3OrK3FfiILxX8laxq4DKtDnNESyj3dPnNgmkPNOAH4BpYs+Vwvaq0xlD9UIfUJ4pHcjzN6dcXDDBOqp+yu0aIuqb6BeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722753673; c=relaxed/simple;
	bh=8LGt/D+6JsvrspQYsx7jcozzNcNLQQkAcU2MZYRQ1XQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H06nRVQBREPuy6Rj5UsQpuCJnHr9WAxcN4KnM/uCrQggnpUnEq3Go2Fu8AK0SepVqKNjs0Bl89QF59204FUkfSKYjmce9ssSOu3y12HhbuyTxs5UFqYjAEV32vYbOy4q3Gf+hQ0nDnvDR1WzzKQQHT86P3tN6c7HEIqxJRnsXJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tGOajxq/; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mqo05cL9xX6EbkNswqcd+nXeaN2YlJ1btsENiq5yhO9HpD7IGlW1e0LySkrUzpSS4DS419dPNHRAEdyplR/DbC5t6t+TZM2LG2Aj1StTrvxQilyKTlb6vYxkkVeIko/GHuIV4548ai8cIADyxdC2CLUzISUo9j5ZYWd4q5Ic1XFqhJGdzMPlpw12F5kCTBPnAzMoyB5dHfkMtDKH5e0/HCHIVbqzNTnSisDsvWzRp12/PSzaqFBlDtfVkxzreG5AfpBQokZnabWX6L8lTNTiMfPki/LcEq+dhqONeheUHz1rqGSvCuynpJM0PWzIV/PAooBHhRpO/bDJ+R3IEvR3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heyaCTvsybHCOLU3SS17k8riryukLpnsqLWrjr+kRbE=;
 b=DJtYlOwb2DsQJaqasJx8psm14n1R2Vl4uc6OgnMsG7CmZ12QMul2NZR7yjRLPcROp882xHYs3A+inCO9Mjl73LsvTjqtF4n4LwYZDJmoceYC2vzuqhJVxy5ezgRLnVCIVjiDLzJWgAtlt664GirwmH0J0dZnU3jM23Zdky4gEjcyXbarweXBzIXn1oTmvUa9Rts7K4XX7ud7pRRMEvhktqAfFlXadvXvguGAUnrynDEK84R17E+CLOLXU6bVbiChTVjVfvLBI/z2mtKAMtpSYXCiTl2tl7RqZKYQeQmjtucWEui2ql9lRJIQXqyDBmwzZeJTQxvWhycpeIb/LsO8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heyaCTvsybHCOLU3SS17k8riryukLpnsqLWrjr+kRbE=;
 b=tGOajxq/pSyOLOSeRg4BzvuFBVy8z1yWKMLRFyvm3yMblnsK/4yiMK2HD+mb0tslCn/Fw6jD+pwsSI+NLGKZDUCPfZVPGsjbtVjoiDTyi2pUYti9BtFr0YXd3Zj9UMlDTMDwjBoFqp5hq6IdDB5qwOs8xowwpDYWCLMsKPwo4lxdmZvUj8vQiwI7wXpc2oHRh2UiJM/zj04Ddms3bahAqXp0PbRxVl+WeqMyNk6qsH+Iz1kzngw2lCbyDTe2A34Sl4HsP11MAKETiUXtce+5o8W7XYj/C6PpKJbIJcE0dGK+QKxoRXjNDumSzRlPkpG406WG5IZdk0OFdFsp4jPwTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Sun, 4 Aug
 2024 06:41:08 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 06:41:08 +0000
Message-ID: <e30e3dc0-e7d5-4550-b532-d3a36a87cac7@nvidia.com>
Date: Sun, 4 Aug 2024 09:40:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/12] selftests: drv-net: rss_ctx: add
 identifier to traffic comments
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-2-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240803042624.970352-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF00003668.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::384) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: ca42c521-b483-4899-7492-08dcb4506c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3ZKSENMSnU1T1ptZXBYTEZTSUI1SnYybkRUUmIwOXBoUjdmaWZGdTJWMUdD?=
 =?utf-8?B?a0FQWWNFbDJXa1l2NDlCVGZ4NGFtVXcvS2gwd1lneTRqK0N3WGU3YW9YMDRU?=
 =?utf-8?B?aTBEd1FSZUNQZzdlU1VseW5lamFad29YT0JhNVd0bnhkWG94cm5rQUdaYzAw?=
 =?utf-8?B?cklvL2w3MkgzYUlBQXhzN0ZjZUNxdlFYWkFuakd1d25qQjVGeUliOTZ6VVg3?=
 =?utf-8?B?RVQ1VUJCWTFqeTBRTzd1ZDFyckxaT2JzWWI1UE5xNGp5bXBkdkhtdkYxcG9m?=
 =?utf-8?B?WWFicDZTVlhQbmlGZkl6cUZHM3ZUdWFDYU1aRGJjbjF2dWZ6T0F4RVNQSWhK?=
 =?utf-8?B?dkxDV05GSTVQNHdaNFg5ZVVobVpYQ1R2SU9lN0o4enZPOGMrK1cwcTRXK1VK?=
 =?utf-8?B?SnJJWHYvbVNPNzVBMmY1QWVLa2xKM2luQlBCYmk3VmF5VHplcjlrV0ZhdEFr?=
 =?utf-8?B?UnVxMTFKSTN5NC9hd2toaStMNUpoc0RhbFlOVXM2cGJGNld1YWhLNko0MXZv?=
 =?utf-8?B?cWJQZEpxK21NMi9vU1BkM3g4Tkh5c0xaaXd3Z09mL1FsckxjMU52b1pBTVAy?=
 =?utf-8?B?QWlYVW90d0RXeFVScnRLV0JYRXdiS2VtVXZaSXVmTXNpMGRzNUdWc3NEMjZP?=
 =?utf-8?B?aCtYT1NxZHgrdHB0Yy9rdEJzNlAxTDJyZTZ4a0hTdVdLMzlsT0cvZklUY3ll?=
 =?utf-8?B?UkprVjl4bmFLai9YZDhjWjdDb3FNU2p3aXlybyt0b3pueGJESlJycUwvNUg5?=
 =?utf-8?B?ZWYzZU5iK3dKeHhBaTRNbVlCUk9qK012eVRra0RtblkxTGt5aWRWMlluM1pY?=
 =?utf-8?B?SlVGUU5wamlxdHE5d1J3VVduYm9zTFl5ZWRZajdtSGJPZUxxV0k1R0wyWUpz?=
 =?utf-8?B?c05qc0xYY1E1NW5xcVBjOXpBNCt0MGtkTXBpVnVkYlFUNC9TN3M2UTJsRHJK?=
 =?utf-8?B?WHFBTFBPQ1hLcDhEcDVkTEFEMEhCckFOTkROZEErRm4rZDhBbjEwTFZpM2pT?=
 =?utf-8?B?K21lRnQrNGtDL29Gb08xV1dYOE52TWxZMDMzUlhrQVJveFZES2hENGc5Tjlx?=
 =?utf-8?B?RjZTRDJOSy80bXYwbTN6YjVnRkRHZ1dXRGJLamhZUE05OGZEWGRCUmtMb0Ix?=
 =?utf-8?B?ZDdncUFndk05aFRoeDRIR3E2eXRpUWp1ckZObzl2MGJaWnI0YUo4aXd2Rk5S?=
 =?utf-8?B?YU55WGZXWE55Nm0rTEszb3R4L1VSd1ErR2FjZmtndFgyYjZFUlJVMjFiVlhm?=
 =?utf-8?B?SWVnQ25MWHFRR1ZodExiVHhEa0F0WUVhL3dlYU9mS1BBSFNpeDlvK1pwVHhv?=
 =?utf-8?B?VGIwN0NudDN3NnVOSW0vSzIxYllGK1FGVklGaWY5Q0JsWUF1bW5DL05WLzZV?=
 =?utf-8?B?c09KcHJzL3pHNGZhZHRaOXc3THYvRkFiQzA4cEh5bTNQY2dYM1c0Qm1lRnBI?=
 =?utf-8?B?bVdTTld5OW9wcXBueDRXd1FQdWphRldqbTU5c082ODZsMTBOb1krMVp5QitQ?=
 =?utf-8?B?RHNQbWRWV0lSQUg2S0ZmYlJYeGdnc0xyQVozbDhmZ01hcWs5WUVtUlRCTmJT?=
 =?utf-8?B?MFJMcW9tZ0VXc0R4WXFMZ25WRVp5UlVEV3RCRytMK3NaK2Z4RDdhT3crYyt1?=
 =?utf-8?B?Z2lGbFlQM2wyU3Z3b1UyTEEzSUJVL25qMVlGVS81Nm5hN1MrZmZWbk5YQ3d0?=
 =?utf-8?B?c3M4YXlQL2RxQlFxRnRmd1h6N3VUald2SlJSand0VG5GZXp0c1N3V1dOKzdq?=
 =?utf-8?B?VTlCQ3BFYXkyUTBQNkR2TWZvUkcyN1VTZ1VweUExVFRYTUMzOHI2dFAxVmRa?=
 =?utf-8?B?Qk9raDE5b2ZXd00xVTlEdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVFxcVJWWllHcXhkUlhKak9qQ3JHRHNXQUVOcFpTZnMrR3BRUUJWaW9qV3ZL?=
 =?utf-8?B?cEV6TU5PeGhvZ1RiNTZMY1NmVGM5SjBpcStBcm1GNlYrYmhFclBWam4xNzVW?=
 =?utf-8?B?Vmw4dnZYYk16NWY0TWhBL2dIUkRadFBFOU0yYUFSQlFXWlFXcDJ6TlRCRS9n?=
 =?utf-8?B?ZEtyWWlNbzRMQ2JlcE9KYnNnTWtna25DVjJUTmdJbTRjNWE5KzN5TUhMZEkv?=
 =?utf-8?B?L1FMSVRYWHVQQ3ordis4QmppU0hSVU5uNnorbGRnOTFScHdPcHJJQVptUVNC?=
 =?utf-8?B?elhkVGExeERBN0p5YVZodE9uS29xT2pSR2tHU09yK1Y1VUZtK09yUXJTdHU3?=
 =?utf-8?B?SkhFNXlqcVRudVNmREJsQUtvWXFueU1JcFFxNGU3SWxnVnhsSG5VNzdaZnBl?=
 =?utf-8?B?WlpoVC9GS25sWUdhbUw2Q3hxVlFyNzEvb3JsMFE0elNSVVNzaGhocHBNTnhs?=
 =?utf-8?B?clpBR2Nxd3l1YWczSDYzcitQcTMvdHhrTVJxNmh1UXFLWlZpQWVrbHZjWkEr?=
 =?utf-8?B?Si96bUtCN3NmbldYZUx5dExUUVcyb1FrN3lNRTIwQ2FzT0p4MGVUSFJrR2dT?=
 =?utf-8?B?cnk0QUsvMkJrZmR1VHI3QUM3aytaQ2dDMzZiSS9rTUZrY0ZQTnRVK1MveTFj?=
 =?utf-8?B?S2tSV05nL0labnBQNlMraTNnclB0anRTYnAxTVhZTzI5SlowQWMvTTZ3dzFK?=
 =?utf-8?B?b2IrUjFiOWFldUhvZExHbVBzRWQ5NlREKzJZNHRZNExLd3djVHIwTVA4Q2NV?=
 =?utf-8?B?OGxjVnR5L2tnQ2s1NnNLanpsVjZwV0UvczRwdlB4d1ovMXNzakNrYno1WlBv?=
 =?utf-8?B?WEFwLzJlTGdvblZBWGJqL2FGelY3VFZaWGkxVVRxUExyOHVyUzY2NVF1NS81?=
 =?utf-8?B?R0xLdHpKVEROdldmVk9WVWdOQlM1OTBYU3pxYUF6MEgzbVJYWTdWcFN0RktJ?=
 =?utf-8?B?YzhodGw0bUVwd2JBMHZoQ2g5SW4wUkR6RGNTb3R5Wmtmckc3d0ZSL3NrUVZt?=
 =?utf-8?B?SmhWVEFtelVhSW9rYzZGbEpXUTFBMTRUUXU2VWxLQWw5ZVpDUi9GbE43KytJ?=
 =?utf-8?B?MmNLT0tsY3g1QnNaTlBWR1V5dXRKcWlmRUN0cW5TMi84cGY0VWkvYmNrNnpa?=
 =?utf-8?B?ZGdGbStzWktqYUIyMWc3Ti81clZKckxhRUFJc3lKR2RydnpjNERMK0ZzOFA5?=
 =?utf-8?B?NklXZkl0ZzhsLy9oZ3dibE9Sc3Y5aGx2K3l5ampWV2Fnd3IvVDNraTFNbWlQ?=
 =?utf-8?B?Q2F2SnhMUnYxOUZOY2hHMWpHSWhCcWNINS9rZWhHT3BKenNKZmQ5bVdkZ1Yr?=
 =?utf-8?B?WmZjdVl3ZzVqaUJxTFgwTlRUN1FjYXFPbVFYWGVIeHFIa2l5Q0xCU092OTFo?=
 =?utf-8?B?dmhwdExwd1kwWlhDZHEyQ04vcTVLSU9VSHB3N0tQYi9WY3VpOWFESE9qc1ND?=
 =?utf-8?B?QVN3cjRXaXZyUGJvRmRMaWMyUUtqZHZMdm4rZzhwdytYM2NsejdsS1dvQXNn?=
 =?utf-8?B?V0kvb2xoVXY3MjVUdFlJTkFqWnRQSkNYVVFQZFZSVGovRzJYa2paUi8rNldx?=
 =?utf-8?B?WHVoRWJLNVNrMFlSRkMwVHFjRnI4MTFmMmljL1FraENpczFaeFN3N0NYWGo2?=
 =?utf-8?B?SThGZmRWZVFOY1ZSV2ZZQmFFQUdhNEZQdjVmWVJ4UWNmS0xSMUMrS3krS1hO?=
 =?utf-8?B?NlhMQThIZEFOd2IrSXV4TW1ob1ladTFCNXBnQ3FjMDM3QlpzWWROanpvN3Uy?=
 =?utf-8?B?N25XZmh2bzAvTWpBVEo2ZGJpUWN1NS9hd1Z5UnFtTDNNWTV3RnpIZTBGNXlo?=
 =?utf-8?B?MEZXalFNMEo3c0Jua1RrbFBjQVExQzFpZ0w5dlZTckRCaCtIMU54OXUrQ1lN?=
 =?utf-8?B?WUtBeGQ2cXJFNWlvUk5DSE90TmFNd2h4M0kwTTRiK1V1VVNZNW56MWtVckh0?=
 =?utf-8?B?VG0xNHEzbStkTk8rUlB2ZkxXeDNTNnhaNXFKWXBadzhvekVtcGxlSHdUSGJt?=
 =?utf-8?B?cHFZNUg4ODFPVkIxcTBpeXdVR1lVMDlFV1IzNVJPSnpUcTVJVDJ6NlZEdHht?=
 =?utf-8?B?Q1VLVGZPRGE3OUsxTDFtMWFhY1RXTWJGdTU1L2I2Y2RCdCs2ZTNyeTF5Q0Rv?=
 =?utf-8?Q?+VSQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca42c521-b483-4899-7492-08dcb4506c0f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 06:41:08.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP3u0Y35NC+yjChminWv4nLSEMflU9pl34m6azRAtyKAIXie5YXJm1tKwgn0auX6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

On 03/08/2024 7:26, Jakub Kicinski wrote:
> Include the "name" of the context in the comment for traffic
> checks. Makes it easier to reason about which context failed
> when we loop over 32 contexts (it may matter if we failed in
> first vs last, for example).
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/rss_ctx.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> index 011508ca604b..1da6b214f4fe 100755
> --- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> +++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> @@ -90,10 +90,10 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
>      ksft_ge(directed, 20000, f"traffic on {name}: " + str(cnts))
>      if params.get('noise'):
>          ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
> -                "traffic on other queues:" + str(cnts))
> +                f"traffic on other queues ({name})':" + str(cnts))

You've already converted to an f-string, why not shove in the 'str(cnts)'?

Reviewed-by: Gal Pressman <gal@nvidia.com>

