Return-Path: <netdev+bounces-154923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DCCA00598
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE3A162C36
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88D1CBE87;
	Fri,  3 Jan 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SBDtlJ1u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B81B2186;
	Fri,  3 Jan 2025 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892194; cv=fail; b=TrMHRRNRRXcEB0Ct3VQUA+R+Jibv6tYvocqbP2XkMHh8ZncgSTzlA3xxfzlLuaMpe9uNHaL6YORdNzxN0Xbqu0l9KPtcG1/HAFH6eXYUK1Ta8YzqmMOmsqHu8eiW4R/MfXEZEVQbLnboCV3ukSvFTUJa2DuM6t3gV6dmCE/X8E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892194; c=relaxed/simple;
	bh=9v+J1pV8NFJES/QAkPA2p6Zyadyn8pamMgp0IRHcQ6I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGkoy/ugJyWY7RzS/RHbvlvfRgcqJqt6cWlKKUZ6QFAYx6tKYGS7Tkz3jvLM2SQektDHC4ixXEvK0sccRBsmRvA0uVG0r3/x+luQqIg9QK23Yba9IYaqR8QVU8rAQi1c8z5cDytWW4yd9VlfWGH9CUlyGHFObo/LeJNmuUC8h8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SBDtlJ1u; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb4Sd0QVHx6ppKofjlXTjVVH+enyFhVSCE4npFAzNN+1Csyq+kSEc8RSiBjWr9jWldWeYi2htO5fE51x7N54pX4CzltPHc1AZFxI+5CvZOJ+kSZ7KrU9v/Fw7szbnqMKEYpGBt5W3l2OX9LuqP7LGpzJP614OoEHQIVzXDuKYEJfj/P3lnDmVZdAvzmkneZldSPKA3XowMCGChVTFJAYiKq1Cjwko8IBsmR0bnVD9qXYiJ64DRJh1DOcj0Ehcct85E3HZ5cUC1E95VzIr/0SGSYAejsINyJvt0ySg9M5iopOaWwzCOQMoAscytHDPgYLN4pIdk5aZ0gOROJgD9UOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5IVNphm4zrbkq1rmzP3wJD1rNBD02RWOGFTzHwJvgc=;
 b=t0xv43ZJCFapyHbExTgI+rpwTzFX16NSdaXFo3/j31asSH6hkvX5CsUsiVAP0WMYLrXxcwY51iO7Bf81fZS7Csl1Z4unk6Dsc5y3HC2uXIvZLTZ0qK3M5FC/X+2qilsybeXeDzk/geHqTWLJ3xqUXpHZj3pwuLTNz8jJyZ8Q+5Fw5hDutdgtKxlAHspZT222wrqYya49x9gp+Fyq6Cr2KDCJhzqFV80KViUkuMQbQ0OtOD0L4jwWpibxGQuV+S0jeg0kDByepZx1TQX838ODV+37eP9LmIQ51aylGylCxmC9f7I2eNsqV07ZRbkFTOqcDw+BENjbU9xfBu386yvOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5IVNphm4zrbkq1rmzP3wJD1rNBD02RWOGFTzHwJvgc=;
 b=SBDtlJ1uaW+YDYM/61udL1cv0MBjdQknitbRVFVEVyk6s21NvnPGTN8AmaKv3dAufESopOvzFMW+fUTLe7Zryas244HFVPM0fZFie2yDrOtn6m6UNU2v9FfUTxsynDnHO0dYChVt2PMNLOqs1lsrJClevwZe7b+Qlm1BKSbeS4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 08:16:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:16:19 +0000
Message-ID: <eb7409c3-d0fc-fe43-446f-3401f379392b@amd.com>
Date: Fri, 3 Jan 2025 08:16:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 22/27] cxl: allow region creation by type2 drivers
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-23-alejandro.lucero-palau@amd.com>
 <20250102152243.00006b59@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250102152243.00006b59@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO3P289CA0007.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1f::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 6696a0b4-757d-4d6b-2c97-08dd2bcee6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUhaRFFlMFBQSTZuS0VQUUZCNFZSS3pPcTdqdW9HenU5NHZka2pjZDE4cE9R?=
 =?utf-8?B?UFJiTEVndUdTUnFoQkswRlkzaGlUL2JrVEhEQ3F5T3NUcXdjYzYrd3ROdGdF?=
 =?utf-8?B?OHRFTnZjdjdmZkVZZyszY3dwOGVmZDZsUFpMTDRNRGlxUFJJamRMTjZNK003?=
 =?utf-8?B?dEpyNWdON3pCWExOa2t4eFcrWWhWRW5hRllCWS9KM0M0ZmVWeDcvd0d4SzBh?=
 =?utf-8?B?M1lzU2tTWklMSW01M2NhZEdFbmxFN0R1M3ZPUkVQSHhHRkdOUGY0dWlLM0NP?=
 =?utf-8?B?VzVzOEJCTGIrVUpHZWN0SnM4T0NSSjhZVElBRmgwOXlwTkZFNGMxMmUwUDlM?=
 =?utf-8?B?ZS9SWitFYlZsZE1ybzBoK1FIZloxcGVEckpGVXNQSGZVQjlSV0tnTCttM2lC?=
 =?utf-8?B?RFA0UEgyWkc2UEZVNDBvcjdhS29nMHRQUGR1TUZoNm04L2ZGTGdsa2x4OEN1?=
 =?utf-8?B?NXpEOWxzQmJnVmtOTFI3RkZzNnZxQXJycmxqZjNocjIvWXRDdFlSWUJ4QWlv?=
 =?utf-8?B?VHpnaGpJVnBTc094UDJ4akpkWldTMmhmN3JkZ1FzdDBiUk9NNnVtalNBblJz?=
 =?utf-8?B?NXgyM0thSDlaM09EczhhNml3SVcwUkV6czd5a3BsNUpKYlkwVjhsOG93MXlH?=
 =?utf-8?B?U0ZrM0lhTUMzZ1VITkFMUDVJbzdSWTAwVGJDakJGMXMyR2x0cEh6VEJLdXpN?=
 =?utf-8?B?UGlTNThFVjY3RjM1bGJlUnlXSU1BZFdObnRXcERJWXNkc3gvYUpzQmZuY1VD?=
 =?utf-8?B?cG1nYUVZZ2tpVC93L3FXUzNXRC9IZ2xkTEg0dUZSY2RBSGMzckJYYkViV2Zw?=
 =?utf-8?B?clp1bjBidHplSDZkMk5LL1RLd0dicVRFMTJRbjNSY2p6N0JLYmVzR1kyT2tn?=
 =?utf-8?B?T0gwQ3l4Q0dEd0t0bWt3enR4c0VoWlE5UVVnUW40dWE2YUYyZXFHdTg3M3pk?=
 =?utf-8?B?WE1NLy9kMGw4MFl2SkJ4SExZcHhBQ2dOanRqcUFqU2JxZFdFSi9tVFhhWnpG?=
 =?utf-8?B?b0Uxcm13SXFaODlmYVNQSFIxOE01T2dIajUvOVlzS01KY2tLM043Q2UwU0xF?=
 =?utf-8?B?ZHNIMTkwVGtTYjhqVC8zZnlmVlJnTjRVc2tBUEs2dFFxdGptT2ZjYlpSOUNQ?=
 =?utf-8?B?WmtyOUYwS3daVlljWG13TTdTNk1QMGxMeTg3Yk53YWlTRGM1L0Yvelh4UXU1?=
 =?utf-8?B?WXB3RlVMTjY1YzZXdHprOEJucUdITkVBTXdFdEpKQTcyczVvRUtneTN2TGp0?=
 =?utf-8?B?d1k3YkJkK3lnbzVQTjJidGp3TEh3OFArM29OYVhrRnZKcVBIUXRBdmJlZ3k5?=
 =?utf-8?B?ajgveTViZ0pUa3g5M2dkVHJxTlM5d21lVWJYM2xYMDdFcDAyRUFIeFhFcW1u?=
 =?utf-8?B?MTMxdEtCb29Ca1RoV1VsOVhnSTN1K3d6WTdhTWFxdWczcmg3ZkUzTFkvblJL?=
 =?utf-8?B?c0FiRUdYMzY0ODRlUzdhVUxPRTRNTmxrN0Zkd0dTRTdEU0hLbDFJQVFmZTdG?=
 =?utf-8?B?dTNFc0VkOWFaVlZvWHRCNVhWMjU1QUdWSUk1cXd3S2xHdEZmbWN6TlA5QWF4?=
 =?utf-8?B?RTlWNDA0Z0lVMFNLNjZHMWhsTnFTa0pWamNabzZ2TnMwS0hQYTg4T0Z6Z1lk?=
 =?utf-8?B?UHRLdm0veTJsNkozakpEblNTYjdhb0JIblVZTTlXL2JRQ0hucjZkYk12Z3R1?=
 =?utf-8?B?Tkx5Y3BIQk92NmJnT1pOYWFBT2YzSEg3OGJCWEdRSkZmakZVTnNlMVpLTlZS?=
 =?utf-8?B?SnJtT211RzRrRjhFVFZ6ZFpKYTlONGl4cGpXMitPeHY1Qmg2Uk1lK25DSnZx?=
 =?utf-8?B?V0NvM25sb3lTMGI1LzE0d2NNMGJEc2RLbzh4MEFmTnFZRjhVN1Jqa0FDdTJ3?=
 =?utf-8?Q?pXQ83jZ4X0SVw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzBCODNlNGphQ3dqdjlFU2NUNjBwNGVpQkJhQ0ltbWpGQXRFc1Myb2R2WXUw?=
 =?utf-8?B?NE8rWFJEVndFaXN6Vnh6WHhYdVBGM0R4RW82MGJ6YUhkUWwreGxOOXV5MHZt?=
 =?utf-8?B?RS9pNmlkdFc3T3liNzVSWkdTaW4xWGE4QUVPbGRSdjFkei9jNlUvUkU1cjJv?=
 =?utf-8?B?MjhQTndhZVhadU1wNUd1Mm80RlE5YlNEWHUwL3ZXdEljNkp0VUcwanlxcXkw?=
 =?utf-8?B?NXRwazRlU0o0YnMrcUdpVXFMWllGZnQ2d21wZ3k1NmtYZmdvc0Z1UGR4eVVh?=
 =?utf-8?B?Tmk3bXZ0TFNNRVA5SjZ6NnlGanBna1F6bnh5MnlObnNFOEJKT012dmgzOTZp?=
 =?utf-8?B?OUd6TXMzNXN5WDlaSXRoOGZSYnc4OVdabVhJVllyTWhiWGk5UUJlNEk1R29S?=
 =?utf-8?B?eUZMT0h0RmZJUmpwZjlGMXNSNWdzbUhPcjdIZ2xqVTdOWUpRaDdUZ0QzcXRJ?=
 =?utf-8?B?cGJwcW5pMHVEZmorc050L2RPclFQNXhkRGU4c1BPL2lLSlE4eFEzMyt6cVdE?=
 =?utf-8?B?Zm1xRDFGVmpxZk1uQnhCVVAwMGpYdjNXVG0vTmJYNDlSaDlPWFNLQ0JjeEtj?=
 =?utf-8?B?RzdSMnZvRVh6TmFUY1VYa0FuS0VUNjBJWmVXaHc3Y3BnclNNZ3o2ZmozeFBC?=
 =?utf-8?B?cStCb0NKNnF1OEx2emkrbFZoS3QzQUlaS2hRL292enNFWkNZaDBGMmZkRnVp?=
 =?utf-8?B?cFNzRUdWVVJOV0p0VGNidXFOYlgvUUxzVXJOakxRRW16Q0xDMWxzc0FFY1dB?=
 =?utf-8?B?ZEJDcGEwa3ExNlZmaVJjSHVDRHdXSUJZanRyN2JXdVpYayt6bVZnZVBZbWdI?=
 =?utf-8?B?RFF2QmFMcmlueWdMUUlIcG5GcXBWWWZyczJJY3BTTHBadzNFMjRtY3psQlds?=
 =?utf-8?B?bmN6eC9reGh2dzVYcWppOG5lZmlTNW05U1pUY0piREhSZEFxVkh1bjNLN0hN?=
 =?utf-8?B?VzVTY2lPNitONktNdnVPT1E4UDVLM3RHVnJYenluZVhCQXdqNXB2WDM0cE1T?=
 =?utf-8?B?dXhQNjVVYnFlakF3Q1J3Z2VWM0FVREhtZW9tV29sTEtSRUcxRlVpbkJ6OVZ1?=
 =?utf-8?B?R2xtZm1TMm8wait3UnJ2dHNaT2UrSGd6TktoKzRsUmx2RTQ4SjcxU0ZJaitJ?=
 =?utf-8?B?NmxaZ0pGY0NMZVVMMS9tU0tsTElScDJCMnowTUQ5bUM3S3FPellFTDNJV2Fs?=
 =?utf-8?B?SVBqOEQveEdEQ1pRK0lSU2pDUlkxOUZIMDNERjB3dTJrUUo2MXUzUTFyOVRZ?=
 =?utf-8?B?VGdrSHVWblg0SVRGNXFacEhIdXpsZmFNQjZCRnZkUDhIUC9HS3dDSnV0Z3hv?=
 =?utf-8?B?bUN0YkQ3d1VFUzNmNitZcERFMFBYOG00YVRCSjA2Rm9TR0NjcG5RcUVVdTc4?=
 =?utf-8?B?Y0hybjZCczQ5b25Tek9IcFlJTmtrRUVKMzBTWmxLSklacmU2Qm5TTHFxSEZJ?=
 =?utf-8?B?WmNRU0hzOFBOZ3F6MnZTNWZUdmo3VmpzRlNFVEdCWDlzQ1N3Tml1aUhTMnhD?=
 =?utf-8?B?NGtDYW9pRHZudm1COWxydzA4MytGZWZka3Y1RFRuYXc4MlIvTEdJRVRzSUMw?=
 =?utf-8?B?b2d3WjRMTVIyNkp0OU1veTU2Y2lobGVMUGpaM1FDbStWWmRqa1lQY3hvckpk?=
 =?utf-8?B?Y3dzQVZEeUpiWGtwajRnVi85dEg5d3RxYmdRbGpFeFhkY2N5MkJnK21LMGNO?=
 =?utf-8?B?bXl0Yi9xVTJoQ1hNNGc0dzY3RjJCUXZQQWhBNlIxbW42V2dudlRjZHN2QjV1?=
 =?utf-8?B?SGZVRGozLzNFZjVGL05QTTNQWXltQ0tUdGZadStTVUNjdXFMeFVwT0RQajRk?=
 =?utf-8?B?MHVmYWVYOGJWZlZPSVZoc1RkaE5MaTNIUHJpdUVUdmxWc2JsZlFXOGtqeWhU?=
 =?utf-8?B?MzNSUURwTXYwV1RZRC9BL3lCWEtSa0F1UFFGc2YzTktGSjl1NmFNcXlHMXVu?=
 =?utf-8?B?Q3dyM2FISFcwbTlUdWRXQ0Q0MmFEZVhWREhiMlNwYldHTk1rVnhsYVk1MklU?=
 =?utf-8?B?dDZqWGhZUDVIcFdtTUh5ZTMzU3BUam05LzZ1bEIxanRUUTdycmtsazQzOHN2?=
 =?utf-8?B?NzZsUW9MTXRNV2dERGtHaEhzOVo5SlNYQUFML3I5eGN2amVpamY2V2MvWDZU?=
 =?utf-8?Q?G+gF6xX8F4f019xo8BrzYS/dy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6696a0b4-757d-4d6b-2c97-08dd2bcee6ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:16:19.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXW4i2rTojMgddKSCfEVfKa3X4mf4aIEYKt2akWzebb2qUdZaSaMynqpqliVqn6b0sz1h8Y4gbFZVup12jZeNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857


On 1/2/25 15:22, Jonathan Cameron wrote:
> On Mon, 30 Dec 2024 21:44:40 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Trivial comment inline. Either way
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>   drivers/cxl/core/region.c | 145 ++++++++++++++++++++++++++++++++++----
>>   drivers/cxl/cxlmem.h      |   2 +
>>   drivers/cxl/port.c        |   5 +-
>>   include/cxl/cxl.h         |   4 ++
>>   4 files changed, 141 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 1b1d45c44b52..a2b92162edbd 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2270,6 +2270,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>>   	return rc;
>>   }
>>   
>> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
>> +{
>> +	int rc;
>> +
>> +	down_write(&cxl_region_rwsem);
> Could use a guard here so you can return directly.


Interesting. Not familiar with this automatic cleanups, but I'll use as 
it is already being used inside kernel cxl core.

Thanks!


>> +	cxled->mode = CXL_DECODER_DEAD;
>> +	rc = cxl_region_detach(cxled);
>> +	up_write(&cxl_region_rwsem);
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
>

