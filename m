Return-Path: <netdev+bounces-128545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965DE97A438
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EBF28E3AD
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8030156C76;
	Mon, 16 Sep 2024 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZItnDa02"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5314F12F;
	Mon, 16 Sep 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497226; cv=fail; b=TBQ3j95+mWi0kl1hWJPhlk42IRSvLswhMeImJRfxd6zFqKrQrWSPPjEfUYUH8ENSkZmFfMxysL3GAkQSSiK0NyB0jXA7f0dYl+5HbCdAAEP5+SxKhcHsd71QnZjaywFLNSBeFjoKeh1ZRPXlAa8Tm4kC9qnPcEI+6LtuyrDnUR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497226; c=relaxed/simple;
	bh=Jwb820G2+R40OH66wHwtWtSC5jICoENGKS2F3zxx7SY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d9RbxQEPuRc7BhmZrSmViYu2bSJc67qr9tdk2miltTZCjCD6wfQZzCGGE8/LPcChE5DNDAW2qXu9PTwjan9Lx+M4pajB3ojAKaI5+ToNd+so14Cf5DhD8vARDaxOkutceUfgH92rO1k6Rfx3fJnFpQG2QPeGl7QmMCXVa/bD30A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZItnDa02; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPpDUF5oYBVyiZXkJIS4lqWFCSODTjLpMjsTIiboELho11DyG94IpV3a3d6giE2YcJxfCLvg/VD/XBxXiYtlrwVN1DVrb6jdZ1WFj166i+RLDw5AuEGL0+uVDyDiNQZwaFdIc67cmsPPu989eC4ABkkJdJvMsky07eUrkbMbdnWWwjmcmgC2CqXyHFz5cQolFR+6wWgbD7dAkDdQI4guO/ykd1pHZUHnZIbaQxTceqa8rdR1YSpAbZm61CXWiamwy+plR5o4HfFWovuVYnvnQfYaH0QfCmcXbZcs0cqd1WVHvXVIgrm2AaOJsAUdPTSidC5NuRgRQS3vwLYlLhbxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSiYdthRfTNxw3XtX6yK5usk8NK7oSmP+8D78vRwYIs=;
 b=opKQPaHnClxbHYtstXi3BAF3YmuxpHbMBheBQpQPXizZH7O2EeDsc7j42nlWrypbp9dONzySOmAWR8piidIh+vm9gAVaz+NvKVFmrO+E23HRXwjL3pL8iBPMkiLnCOMWHN7zjABtaIP7BULaZ3WetlcpXuj/WmM3eFgC85rkrOOcPE6GjIlEW8obw5wqZ4ULpC22LUIyQaPBuTlN9VGUTHIVDKOQCXjS/E407VjXQzMdo8Ywrx+z6mPk8ZDU4y13GKD7Y+VcimhRYsgn+zmdFSbGI65L/8fqBhvPu/wK266T9emqnUEwgZIh4wMj8PFVxhyHhDr4zPM0FNdN3mK0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSiYdthRfTNxw3XtX6yK5usk8NK7oSmP+8D78vRwYIs=;
 b=ZItnDa02fpW+U6j1MvaAINp9CJhRGq9aUZfFbecZ2D0s+3JeKZ5iOLmnEIz6kGp/S+V8h18+SHdZU86G2SUz/ZnrbYEO5t+SLFRd6SJsghKlZMcOi+BMwyq9mVE2VLNpsWdAZzZzNDr94ruOOXeaM+Y/l6UExtrEF2EL64zVXy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 14:33:39 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 14:33:39 +0000
Message-ID: <fd540034-2dcf-2f36-916f-1e8f1e091462@amd.com>
Date: Mon, 16 Sep 2024 15:32:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 18/20] cxl: preclude device memory to be used for dax
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-19-alejandro.lucero-palau@amd.com>
 <45aeb8f4-b452-4ecf-8dcc-1b0a9f89e2ae@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <45aeb8f4-b452-4ecf-8dcc-1b0a9f89e2ae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0594.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e21bbda-c311-4dac-f447-08dcd65c8e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGdMNGRnYjRRTzZvM2tJWDBBZXFlSjBBWDhMWllkUWprTmxKMWduOFRkMmJH?=
 =?utf-8?B?Z3JNZG1IY3RocmhUWUdWOWxhOWQxVmRJWGJlRUp1L2xldWRkcHJ5NzhQYzNQ?=
 =?utf-8?B?eWhaNTlUa0FQdlhmSzhRVjJGLy9BY2FuZGtYVkpzOVJDQnkxSnEwWHltYjdQ?=
 =?utf-8?B?L3NJa1NwMmZsRzBGQzVsY3ZXT3UycTZZWlpVaTdQWHJYVEpYTXF1NU11RFc5?=
 =?utf-8?B?ait0ajc5emtVZFdzenp5dEd1dEdqN0dBUS9WSjFMdFEwaEg4ZDBCb29sVnFz?=
 =?utf-8?B?YlZWNHNlMDRGVk5ob2h3UUpiSGF5WWdtWlR2VUMzRk5NSCtCT3U2RkdvWTRj?=
 =?utf-8?B?S0l1WXZ3QWUrMXhrYmFGdjJSVW51cjVuakxIc1Q3aDZxZWlqZmNvMDFZMjZp?=
 =?utf-8?B?MzFERlBRejFCVE1qQW9seXpMTXNzQ3ovU1R4c1ZQTlExVmNxR0pHVVJNRkZs?=
 =?utf-8?B?cHErU1RVTlZUNmdLQWszSEE1ZUFmcmd4VlA5QmU5aFh3MjlWNkIzdVhleEMw?=
 =?utf-8?B?Wm1uMFFRdnNLTy9rYzV6d0l6L1h1eDJKNDNCZVFWRGJCMVVodWc0WVV6ZVJ6?=
 =?utf-8?B?TUQ4VmlMSlZqcmJYUHBLZm5yVWQ2NDZOTk8xeUxmd0luZHR4azRyYkg0a0tM?=
 =?utf-8?B?VHdYbWpMekdtUVJNQkJEd0FRTm9NR0JDN09BVDNkYzNFTEtzL1NvdkRmR2hN?=
 =?utf-8?B?bnBQOXgzT2FuZk1XY2dzbVVkZC9KVm5hdThsY29xRXA1aTdHYnZHb3ZnSDRI?=
 =?utf-8?B?bWhnNkVpZXZMSWQ4Y2RhOGt2WHhLWjVKa0N3WDFMUUFYeWxQWURiRzZWblEr?=
 =?utf-8?B?aThHSlBsVHB0KzVYa1ZaZXNra0l2L0E1N2FVYklIaDNjdCtoNGs5RFlnRFpu?=
 =?utf-8?B?NG9FWk4xblNaaTRFOE9FcXd2M2dYSU8vTGZJWmpTUHMyS0ZYQWwrNE1UR0JY?=
 =?utf-8?B?Z0JvcDkxUTcydGZ3NFRMRHljMk9QV2tqVkhna2k4bjd2UU1kVk1NaWp2aEJ0?=
 =?utf-8?B?N05iZlZhU0orbkNCUWVtZjZDZHVpZmNMbVRaVjR0WkkzZWp3K3ovTU1hakl3?=
 =?utf-8?B?NTJoUUo3LzNBd2tsTE9GclQ3NzlNOS9QMVZSTjhBdmI5RWdtS21LZWNHcSsy?=
 =?utf-8?B?dWpaVHF0eWRtenRYblZ2Q1VFVk1XK29jZ05oQXdRb2RzQjkwcllqWE1mZ2Mz?=
 =?utf-8?B?WnR2eGduaUR0bVl3QVlpTzZJYTEwUWxxV1lndzJDc1pHZjRtdEZ3QnE4Njg5?=
 =?utf-8?B?Yk5yU09HL2N5STdlWmtDNnZoUExkYmZLNDNjUWFxYy82Rm9wQWFlKzQwTytz?=
 =?utf-8?B?VklHQ2VPYWhaT1htVllZU3ZPZXMrRktWVDhtWnhMbnFQU2c1Q0hPQkJiczJT?=
 =?utf-8?B?WWFPYmUreFpiREtpZkxLYi9yeW0vSXh6RDVtc0Y1bFRoUFl3VHhKNVlleDJp?=
 =?utf-8?B?RGlPT2wxekpGZkRNeXV3Yy9ZQkJ4akpoay9Na0tTMXhnVFZwb3pwWjdBZlNy?=
 =?utf-8?B?UjNmTnlsYUU1c1BqaGMwcTR0c1B5YUxTYXlnaWhsdzVwSFNqRlFUQmxYL1ND?=
 =?utf-8?B?N1ltUmovWWhFNFZ3R2R4dWJkT3Q5d1g1ck8vTk1FQU54UW1lS3dTM1F4SGNE?=
 =?utf-8?B?VlNBdmZSNkF1TzVwSTVPRnhweXdwdXhRTVF2QmxRQ1dRa1ZIUzhEVEpTUTl5?=
 =?utf-8?B?N2h3SmVhaCtaSHF3dXNMTUNyK1JydGExZlIrS01wRzVpanRDbXRKQzJvNDBu?=
 =?utf-8?B?NGJsRHN1Z3R2c3JjQmFIV0ZmZE5zdmRxayt4NktWWGdqOXRYSExtalBxQjB6?=
 =?utf-8?B?cFI4c1NJM1FiMmJvUVJxZ0c4bzMvMzRwbDE0ZkNGTEMxOHJMVFZxVVlkVi9x?=
 =?utf-8?Q?Ejjg2G4xOAYV7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blFtZHloM1ViOXRLNTlYdkg0R1dWSWplZ1VGYmY2NzNWMFdUWTdiWmY3YzZ4?=
 =?utf-8?B?dGJwTnBkdTl5V0pRSWdTS3M4blFBWkk4STdHZWZJWGF1ZlpreTZXZzRWd3Nq?=
 =?utf-8?B?ZzBNNnh0Qmlvekc5dFZXRHZmZURCTEtJOXkzYk11Vm1mTDBCMHBoMnkvQnJW?=
 =?utf-8?B?cGxQNS9CbENQRlY5Ym9UZXNRZmF6NHdxL0M4dUJOWHRORkNLNllVeFFKWFgv?=
 =?utf-8?B?TTFja0d0ekN0SmZkaksrYTlSMUFNMHdNV1FnNzRxTFBkSDlKS1JRS3RuWDJl?=
 =?utf-8?B?NGNIblJrNTY5eXBFNmZYL1poV3pPbHkrQmQwU2h5RGZ3a1hzNGI4a1k1L1g5?=
 =?utf-8?B?Mm05MUZpNGdqbzYwbTlJaDRZaHBQcld3RlptalZhTG1jKzdKN056bWZxMXhr?=
 =?utf-8?B?L2lyVkpMakpMaDg2Q3IwWXlGSER1TkV0ZHRydmUydUxwTlhyeEZLbmZWbXFp?=
 =?utf-8?B?ZDVVYWNOVHAybzdBSjU3eGdiWExLbjRXOTNtTHZ3cDZaRmhkMXN5cVpodHRw?=
 =?utf-8?B?ZmtyRG92WERiOVU0V2hMNExCODhWYW1PSU1lN1JscmNueVRUUytxWXpMTk05?=
 =?utf-8?B?Vk4yY1JvQjdudVMxYTNqZlQwbk1TeGY2Q0MrWFN4endHMlRUTlJ6VE0xK3Ja?=
 =?utf-8?B?aUdvSG1kL0x2ZFc2TDlEbjRDeUVsay9FbUNJUUo2alFLSnE0NjNSdFVZK0Nz?=
 =?utf-8?B?RWFTTzdJdW9admo1WXlsVVJYT3daSGdweGN1MHdVNlkyYjlPTVQ2YjFCUThZ?=
 =?utf-8?B?cGcvbnRKUzVTbjI2U2hwZVpjbGVqUXhFS3lkUjJwc0J3V0E1VGpXZU5Ic1kz?=
 =?utf-8?B?TjNscGg1WFl0Tmt4Y0htQld5S3RndnpBK29qNzJrVTlsdndYZWYrajYwbkRV?=
 =?utf-8?B?OXcvbDl2R3A4WEc4ZmZCdFRJVjZsWUhtWjJrdGsyWGVEaDNhM1E4YXc4N3dU?=
 =?utf-8?B?SVluaVZMeU1Zek1JaEJUL2ZIWXBCV1pCZEd1MFVWd1Q2Y0YxbEwzZkt4emlJ?=
 =?utf-8?B?b3U0dmpncndMSyt4M1plSnJiVFA2V2M3a0hDTVkvZkpyWlhOd0FFVmVNMWxO?=
 =?utf-8?B?UHlBSXVrdEVycm5zaUIwOU4yUUUyNFhPWFRZYlRBbys2M3I4V2pJREM1OG5T?=
 =?utf-8?B?QUlSWUVSR0IwdFhHMGJyNWtaajBvR3FFS1hEcWQvdnBzWDJObitoYlBZelhW?=
 =?utf-8?B?TTZCZktmdnQrcFlvUXZDeGV3ODlXRFZZVGNTeCs0eFVWdEFUdThiMlFpUTBZ?=
 =?utf-8?B?N3ZQb1VvM1owMUtod0ZPeTRjby95MkZlRkFIcTBWbmF0cXJVdDZsK1N3S0c3?=
 =?utf-8?B?VWlRN1dLUGZia2p5VXhmbkxOVU5kMmZuL1lCNDl1ZU0yTzNNWFhYZ2hVR2NI?=
 =?utf-8?B?bGh4R0Z3MkZOVGVCdkpIOUtjLzc3bEVvaDdsa0dHL0s2bkZLeGwrdzg4ZmZE?=
 =?utf-8?B?QVZweTZNcFRGTHI4NEdzYXN5cjdZTUYyalcxVW1XcC9qNXlhaHlKQnd4Z0Rs?=
 =?utf-8?B?NEVSMXNnKzFIUFRiYTRxb2FGUmE2TWNnOTJ2c2hZcWd4M0dOc3d2UnczUUxo?=
 =?utf-8?B?aU9iZ1ZpdG04aTc5NkFEbisySjVSMURGR2JMVXRuVWwxREdqY1NrSXdEc1hD?=
 =?utf-8?B?ampPWnpYY09YZWF3NnVLbjNTV2RIaWFJL0dpeURQSE1ISWFMVWdTa01IUG5N?=
 =?utf-8?B?Mk5vM2pkS0g0aXJwcHF4U25Qb1h2eHMrTnRxclV0RzNPWnZzMWlOdWVuRXpU?=
 =?utf-8?B?ZnZIOWlGTlExYmRqZnZRTTVvNlI2UlNYa3pkMHpqbFVybTEzb202elJSaWgr?=
 =?utf-8?B?TGNNVWNOQkY4UGN2NGdkc3pINmtxNWMyWXl4SVl1YWQ4ZCtoY1pHNEd6QmZG?=
 =?utf-8?B?dVJNeXMrNEhBbDdJVjZnSzQrY3JEbWJpdDhEUXhUZXFDZmhvQnZSanhITGVs?=
 =?utf-8?B?SnhydlE1T0JyU1g5RE5udmRqMzF1bGx5Q1drVWczeituelFMcUJaUm1SWENz?=
 =?utf-8?B?bHVzTFp1VG1QWHE4eElaTDNrSHZMSmsyVDFCWVlqVkFCUSs0QTBlUmwxazNi?=
 =?utf-8?B?MmVZMzJDNEZaV053MFpVb1VoSU02WStIZWM2VUpNY003T3pHN25rZS9iVUpW?=
 =?utf-8?Q?/kchir/atVcUHhmwEFg97BCvf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e21bbda-c311-4dac-f447-08dcd65c8e04
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 14:33:39.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICAv/utsogX2R27nzAVUemjFSz9PfeQ6FS2SXoFpLZbbuYZkx7t1VFYAIQwTzxgwpnck0mRe02eQjZ8f5UXH5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681


On 9/13/24 18:26, Dave Jiang wrote:
>
> On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> By definition a type2 cxl device will use the host managed memory for
>> specific functionality, therefore it should not be available to other
>> uses.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index d8c29e28e60c..45b4891035a6 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3699,6 +3699,9 @@ static int cxl_region_probe(struct device *dev)
>>   	case CXL_DECODER_PMEM:
>>   		return devm_cxl_add_pmem_region(cxlr);
>>   	case CXL_DECODER_RAM:
>> +		if (cxlr->type != CXL_DECODER_HOSTONLYMEM)
>> +			return 0;
>> +
> While it's highly unlikely that someone puts pmem on a type2 device, the spec does not forbid it. Maybe it makes sense to just return 0 above this switch block entirely and skip this code block?


Yes, it makes sense.

I'll do it.

Thanks


>
>>   		/*
>>   		 * The region can not be manged by CXL if any portion of
>>   		 * it is already online as 'System RAM'

