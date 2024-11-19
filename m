Return-Path: <netdev+bounces-146232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9D49D25C4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7BD1F23D11
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289611CBEB5;
	Tue, 19 Nov 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SumZm8rX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0DC1CC16B;
	Tue, 19 Nov 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019298; cv=fail; b=tPO+LdGXxqSSwVQlO3MaOBG6shx6f/PFL/efhA7SnyltqtHBhYUBXDED7Q+YZHmgsC02+QyKIe0NHW3y9U89TF4OHIv12RdPnxDeeSMvUQlu0JIEPF46dP4mxVS1FoLEXDDdctxBLFi6kuIkU+USKOQ1kVS8JA5BE6EWCKy2MxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019298; c=relaxed/simple;
	bh=rkpefun1YkQj2RMFIh/q2jbjyvnA0qfuqxF7wepWohQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YFqa1BhlBbpaFhyAvrpMvX7yF6mu1IWNJylmm+IJ/mL2AYgyR2r4tsYAzi2AR2UiFGb61gMkzDMhqsDAc0UqUDqvQCDZ+Yj38Uai/UxhpIhnvIFZG8ftMH0aDuozey40Lz9Kci/IKH70iIo81UQOrqMcu5cCzxUqZ90/dx9aTbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SumZm8rX; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSxamf9xdbWKuge/KUn1Ucyska80Xkanupmn8MF5PvScZaciOcQplOu/XDpX6yCsCODKd7aN/oAVZbk+HkXYECw2xxa0FCEEEbCPo6jQvimXKp2Ba6M7WPjwSAL50TC4BXKuWAzOp7D1fwx2ZDs2f7lovrsCUgk9vTPGc4QDXDIAeNhoIMQ2YrCgcDM3jpt7Rb0A71PqUiApdoWfL2q7+c52lmOAMmr1L118NesvNWIXemyRpf7WPdV4mgsfi0y1CtJZcKlzqtzQpvJ0nXKuHMOLdBaIGdaMzvpky7lZQXitINFdPDPsY1xuxoFSu2v7xAqri+p1iuXi0BSfOwa9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KB92VwEuYu/nMcSsgRq/whnA5oFR6aNUYiPHREaD/Jk=;
 b=L+9SSG2J6xvmf6KaS5a78/0EeZ7COgHzQHkEwFFBEDg/999ED329F3f2Yp2ouosK70P8YXRn2JbV/k505TfqLR45mhxzKnbfUCD03z2uxXzTMFwDP5RSAZO2kEjKcURSwIqpYuO+BBd1xoHbxDg0qTzGdH/QoOylAi76R3geXkv1fCBfnAuYNFqP+IUGZ+MhnQDIbtP1kd+yNmJPeB01cV8mEjM2ffemnnyIBJaneREdDdJbNdaNxJ17fNNG08UnWmC7qCYJMUyXZKKEu6RpErNginrZBWn+FIiA4DyZTRlDu0FxV7eTBFGFdyG66O5FC5XeFm/gfVFl03Ye2MlgUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KB92VwEuYu/nMcSsgRq/whnA5oFR6aNUYiPHREaD/Jk=;
 b=SumZm8rX6LocLp4sUDWF67/bbsBtM2H88EmsWBkAp3GO1spjgdujsFHjF+N+avy/jswHfFx9sUfFFxJagHdZMj84NuQ9kNynCTqxAm0VtUOu+llQcGS2LF36MuJ/4df2CQ8KFYaUlXxGOh4D573yFp1tdQkGb1WE6eRypJmwVM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 12:28:13 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 12:28:12 +0000
Message-ID: <7c988754-fb25-bd8b-49bf-b0dae845e81c@amd.com>
Date: Tue, 19 Nov 2024 12:28:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 03/27] cxl: add capabilities field to cxl_dev_state and
 cxl_port
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-4-alejandro.lucero-palau@amd.com>
 <0ca7d9ba-2d01-4678-b109-ca49091266f4@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <0ca7d9ba-2d01-4678-b109-ca49091266f4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 13be0b04-fd1d-4268-4f4c-08dd0895a257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjNCelhhWG0xbWhnQ3ZpNHl5K0QrMnM5WEdORDlNSHRvYkFPVnRMcDhDMVp1?=
 =?utf-8?B?c0RIL2xVQWxVQjQxTXBRQVN1Y0pKUjZlWnZKbU44YTBJcVlyb1l0Q1Uyb0lW?=
 =?utf-8?B?UURFbXpPTm14cTRoL05xYjkvVWlRSG1ON0ZnaGVxcTFBUmtZUlBPU0dMUUps?=
 =?utf-8?B?UDRvOFUwd0d0RklVM2J2YlkzTEFhdGM1Z044VTg2S3lYRGg1WXpKd1BrVG0z?=
 =?utf-8?B?WndyRE5rYzEvNlZYdW9ILzF3R3NwREdudHlxb1A3a2dUUC9PZnhoL3lSUkNK?=
 =?utf-8?B?RjBDcE1lTi9kd3huOTVMMEhvbm5SUjBWUkJVei9GS0FzWjlUSGxuV3d6Z1Qv?=
 =?utf-8?B?Q0xnZWNhZmZRbnlEaWZ4WnpjVEVMdXhqQnUxcG1ETUQ3bDZJRjBRVnJjN281?=
 =?utf-8?B?LzVmUm9TNHRxZXNyQVIyR3hXTFdzVUNZUHkzME95NktiUEp0TzBUWGVuSnFp?=
 =?utf-8?B?c2pvZ0FWTjhNV1BIcDU4VFV1bm1EMy9va2tDM1hYWDhRaGJPZjlVc25lbzg1?=
 =?utf-8?B?Q1Rod3BVMFJNNE5RQ2FZWWxCNlhBaFU0ai9tUXQzdDYzZ1o0dG1HL2RHa2Iv?=
 =?utf-8?B?Q3BXV0JtZjBRUVpQZjREakEraEN4VFRxU1VLcXlGRGZZNmgya3pTVFFzNlFn?=
 =?utf-8?B?aElhVXNHUU53dWg0aXpUa1hHbk40NGhwM0p3Mm90NkRXUG1mc3FpQkp5RFE1?=
 =?utf-8?B?SVkwMDlwT0F6MW5QM3dSQmU4dm1OM2g3TEUrTlBWQi84ZmRqSVAyVGtqVkxx?=
 =?utf-8?B?WnV0T1BqVWpUWm5XaHRKQU1nQmhoMDFwWEc5bk5SbmE0V0VDWmxZVHhoai9m?=
 =?utf-8?B?QndDTGRjTEdQRzYvdmJ5VUc3WHRRbElZZEFqakhCUDl1ZTdsMVlkWnNlNmdy?=
 =?utf-8?B?dmV3T0hEd2RSQ2xmeW42bWM3cnlwL2RITjVrVUZjMWJvSlZxV1orVkJ0dllV?=
 =?utf-8?B?YnBHZzNOME9vZDBiNEJUbFpISDFCYzlKUmVYNW01d3pFRlI2blE0aWJNTXpG?=
 =?utf-8?B?Y3VMaVlJUHluWVBzdHI1Q0R3c2N5TkJXZ1U3Y1JOWDVPc09DZW9ZcUdQTXVo?=
 =?utf-8?B?MEVkSlhVVDFUbjBsdEVIWGhQUGtSb28rQXpIOGdUdndjSWJIbzhZeGNjOFN4?=
 =?utf-8?B?QnNnbURtV3lMNTM1a0Exc2prL0JQN05oeFRsUlJGYXUwWWtuUWVFSkZPN3dB?=
 =?utf-8?B?RDdBQmE5d1dEYjdOZXJ1Vlk1YVJRVWtkRXY2cEpsdEhvRkc5bjJtRHA1Q0tu?=
 =?utf-8?B?bW5yeWNFVnF0eFJ6MnBjaks1TmhPSERLVWlrQXZuTTNRZDR3RTdod2dnUENY?=
 =?utf-8?B?SjFxVlBPVlJabDBTVUVIaCtkaE0rYVlmQ296emRBQW5CUDU3UWdNTSs0dG1r?=
 =?utf-8?B?Tld2Z3FYSDF2cWtuQ2FCQkhzd2NRdGN4bjRvNGhUUUhvUTg0SU8vbDVFdC9Z?=
 =?utf-8?B?eVNKdk80R0ZJRU1ZMjZjamZCSFJMMmpEZmJjUzkvWXdLNHFlanBqWVZ6akRM?=
 =?utf-8?B?cWU3WGlyWDNrZDNmRU10OHNSelo1eFdpaVRrSWJsRk9zRGZwNGdqeTNxYjY3?=
 =?utf-8?B?T3p1V0VrMFVBeGhQenhkN2hOWGFuTkxYME4rQWVZZjZwRi9pb3BBZ0RMODRq?=
 =?utf-8?B?Mlp3QzVaMWtqYjYzMSs4bnFQQWF6ayt2b29jblRMR1BnM25ZQmcrV0tHL0dO?=
 =?utf-8?B?dVlrZjFpYm0rMGZLUWM3QUcraU1FTU01RXlHbFlHeEpZNDFxdFlEL1oxUGpI?=
 =?utf-8?B?SnJTdXVicmlYZFlFR0djcnZ0VHJwY0dRMFBiZjhtUWhRVy9OTkxRRHVaQVZI?=
 =?utf-8?Q?dfyLs7LFm8QyaH1ZySQd2KtAEk3QKg0gZ/wqs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1BjQXRURktDRkhEMEZNT0hkLzhKd0pYTjFmODFyNW11Qms1dm03aG90UHlL?=
 =?utf-8?B?SVRHSWpHb29ralhIQjJpMXBjMTY5QTdSRkgyZjBxQ3FGLzVpYVFCT09kQitD?=
 =?utf-8?B?SXF3KzJ5b3RHdzVkcW1SR3ptbnJROGgrdmd2alpydjZDa1l4ZzNKQ0JhZU1M?=
 =?utf-8?B?UzlLTHNxbzZIcldjQjRPN3FFWCtYTmVOT0ZmNUlSZ0VtRWs2ZXhvUHlnaEJC?=
 =?utf-8?B?QnBxQTJCZEVlUGt5NUkwVXEweHJNODBucTEzKzRpMm9GSlp6dkdBdG9ocWxt?=
 =?utf-8?B?SE9hVWRTaDZNcU02ZEk0VTUxSTQrRlJpenZTUW1WcE14Wm1aUVN3cEk4Zkp2?=
 =?utf-8?B?Ukpwc1lCdWNKUUg1MGFWZWdVTUxYb0ZidDAyUjBEamZCaU9OYzgzTFdYUzMv?=
 =?utf-8?B?SXQwSVZ6cmhQTkEwMS91VzZnMDhiekhIWlJOd3JleFhkc3dVN092Y3Vaa2pL?=
 =?utf-8?B?dkdmWkRQeVhubEhraVd6TzB0aWRBRHlaWE16UUdITXhXT0x4UzdadFprRk5t?=
 =?utf-8?B?allUYk1xUGZXamFFZXJYRWxPcVI1aVNQWlhDaEhsVFM4Wi9KQVNwN2hzZWdt?=
 =?utf-8?B?NlEwaEFrbFAranVZMVhQY2tpaVl1WHBWWW5sMkNNblRWUk9KQ0VsenFJc2hF?=
 =?utf-8?B?bkk2ZHJoMTkrNzN4bTlxaXE0ZXIvT0UxRUJoKzlPcHNZUGFsL2RhY0VOaytT?=
 =?utf-8?B?SWZ5UWd3N1VkdXhNTlBVdlBwa1BXTnVZczRjdjBsZzMweXBEMFhZSitWZDdE?=
 =?utf-8?B?dkczTVRLeEJHY2h2TXJNMms0WUpLV21uTURjYjlwU0xsSlQzTFRRcG5nYmcx?=
 =?utf-8?B?RzVZTkZPWi9LZ2srOWhaTDUxVHl4N055MjdXeDRsNXpWZEp6S1hHTHdmVWx3?=
 =?utf-8?B?Yks3Uk9KaGhZQ3VnbmlZU0gvS3VqSEpsOXZDb25uaTYzdXJJb2Z3cDZvSkVp?=
 =?utf-8?B?NTNXQlg3YWZURHc3QVBEc0phQ0xEd1k0ejlRNVdGTnh1RDQ4ZjBSTmEzV0pX?=
 =?utf-8?B?MU52WVB2aXd5MDBzYTZ6RGtoRG1DR3VwZ0FmaXRiRlZUb09QS0xpd3ViUFFn?=
 =?utf-8?B?NWVMT3FOUmVybjZ4NlNrNkZicVFrV1NmOFFYeUlpa1RrQVZRMER6dDZDdVhk?=
 =?utf-8?B?UnFPK3VKbThIT3g4a2ErYVZyMFVtK0RLdis1djV2NERyRGd6YjNEMjlEaTZu?=
 =?utf-8?B?M2NBaUVDUkEyNHMzTWRxZ0VrOGc2ZUdwVGZqRzgzaEd5SkNCaUZNcVN0UjVI?=
 =?utf-8?B?eS94RG1vNGx6K0ZkWkQ0VVo2LzBBRFJSOXJFSDJoRGozd25CZDZIanErY1JE?=
 =?utf-8?B?bFhVa01KV2xoQSt0YWduYVhHbVR3TWdva1RPRnU4VGJPb0x0NlNXQ0F5bnJ0?=
 =?utf-8?B?MTZHWTRIb3NuaHNkSGxmV0VaRGEzOVNXNVUyR1dwbW54RHRaNVRKRnJ6SjIy?=
 =?utf-8?B?UGErcC94cXNMbUI4bkx2YjlsKzE2NU1LcWgzWm5PMmRrQ3VWTmQ0SW1iSjJv?=
 =?utf-8?B?dmxTbi9FNXplQmlRdzFmTlNHbFpzYmRhMnhicUFPZTVjWVZ1T1Q0NFI3NnlC?=
 =?utf-8?B?cTFiUHhsbnR2RlAzVnoyNHBjMDcrcElTNFROL28vZ3d5dnJjWGVHWFk4Wk1w?=
 =?utf-8?B?dFpDdFp2Zlo0L1Q5NzRReGFCVzY5ZENFeC9wNXZHT2VNaTRlOGtOUEltT2JU?=
 =?utf-8?B?ZVVia1k5cldOcXVzQW1za3UwVHFEcjBzV1pzMmV4QUQ2VmlTKysrTFJDQVhJ?=
 =?utf-8?B?UGNzV0NncnlBSllNbitFc0JlVkhmbWhSVStwRitOamJaMUFjaWtHN1ovMVVo?=
 =?utf-8?B?b1A3SzdCUEpqa0xQckFiRXRXVUloaXdGcmRhaXFEYThqTnhwQkxxdDc3VEhy?=
 =?utf-8?B?YVFsQXZrTExITTkvZXVwWCtzNXFLN2tVTGt2ZDBKZFNCV0dwL1laRkcyV1Yz?=
 =?utf-8?B?cEQ5OWJsUFo2QjhCNEZPT0djcVVMUDliQUl4RTQ1c3QvV0NjUXMxRzd6bDNC?=
 =?utf-8?B?Q0VKSnlpZTk5dEZKRDh5VmJHQ1c1dVl3NTc1ZUE1WEx3YTFBSStOMTJRRTAv?=
 =?utf-8?B?Q0JEbC9CZ2c0MEcxS0xraFhkZTFMR1gxSGhlUkwzajQ0YkVKTVpMTWRmQXh3?=
 =?utf-8?Q?y2Ts7hbdHQFyMzCGo2/AK1Zzb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13be0b04-fd1d-4268-4f4c-08dd0895a257
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 12:28:12.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbcNG4ZHHEfuoFe8HvHNfA5YvLcgy74IDZqwutbTS8PS+jQeslfTmNqiBSscCmcHrd5DTXBf39rtp8KbVk8iSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764


On 11/18/24 22:52, Dave Jiang wrote:
>
> On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type2 devices have some Type3 functionalities as optional like an mbox
>> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
>> implements.
>>
>> Add a new field to cxl_dev_state for keeping device capabilities as discovered
>> during initialization. Add same field to cxl_port as registers discovery
>> is also used during port initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/port.c | 11 +++++++----
>>   drivers/cxl/core/regs.c | 21 ++++++++++++++-------
>>   drivers/cxl/cxl.h       |  9 ++++++---
>>   drivers/cxl/cxlmem.h    |  2 ++
>>   drivers/cxl/pci.c       | 10 ++++++----
>>   include/cxl/cxl.h       | 30 ++++++++++++++++++++++++++++++
>>   6 files changed, 65 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index af92c67bc954..5bc8490a199c 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -749,7 +749,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>>   }
>>   
>>   static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
>> -			       resource_size_t component_reg_phys)
>> +			       resource_size_t component_reg_phys, unsigned long *caps)
>>   {
>>   	*map = (struct cxl_register_map) {
>>   		.host = host,
>> @@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>>   	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>>   	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>>   
>> -	return cxl_setup_regs(map);
>> +	return cxl_setup_regs(map, caps);
>>   }
>>   
>>   static int cxl_port_setup_regs(struct cxl_port *port,
>> @@ -772,7 +772,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>>   	if (dev_is_platform(port->uport_dev))
>>   		return 0;
>>   	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
>> -				   component_reg_phys);
>> +				   component_reg_phys, port->capabilities);
>>   }
>>   
>>   static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>> @@ -789,7 +789,8 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>   	 * NULL.
>>   	 */
>>   	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
>> -				 component_reg_phys);
>> +				 component_reg_phys,
>> +				 dport->port->capabilities);
>>   	dport->reg_map.host = host;
>>   	return rc;
>>   }
>> @@ -851,6 +852,8 @@ static int cxl_port_add(struct cxl_port *port,
>>   		port->reg_map = cxlds->reg_map;
>>   		port->reg_map.host = &port->dev;
>>   		cxlmd->endpoint = port;
>> +		bitmap_copy(port->capabilities, cxlds->capabilities,
>> +			    CXL_MAX_CAPS);
>>   	} else if (parent_dport) {
>>   		rc = dev_set_name(dev, "port%d", port->id);
>>   		if (rc)
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index e1082e749c69..8287ec45b018 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -4,6 +4,7 @@
>>   #include <linux/device.h>
>>   #include <linux/slab.h>
>>   #include <linux/pci.h>
>> +#include <cxl/cxl.h>
>>   #include <cxlmem.h>
>>   #include <cxlpci.h>
>>   #include <pmu.h>
>> @@ -36,7 +37,8 @@
>>    * Probe for component register information and return it in map object.
>>    */
>>   void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>> -			      struct cxl_component_reg_map *map)
>> +			      struct cxl_component_reg_map *map,
>> +			      unsigned long *caps)
>>   {
>>   	int cap, cap_count;
>>   	u32 cap_array;
>> @@ -84,6 +86,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>   			decoder_cnt = cxl_hdm_decoder_count(hdr);
>>   			length = 0x20 * decoder_cnt + 0x10;
>>   			rmap = &map->hdm_decoder;
>> +			*caps |= BIT(CXL_DEV_CAP_HDM);
>>   			break;
>>   		}
>>   		case CXL_CM_CAP_CAP_ID_RAS:
>> @@ -91,6 +94,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>   				offset);
>>   			length = CXL_RAS_CAPABILITY_LENGTH;
>>   			rmap = &map->ras;
>> +			*caps |= BIT(CXL_DEV_CAP_RAS);
>>   			break;
>>   		default:
>>   			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>> @@ -117,7 +121,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
>>    * Probe for device register information and return it in map object.
>>    */
>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>> -			   struct cxl_device_reg_map *map)
>> +			   struct cxl_device_reg_map *map, unsigned long *caps)
>>   {
>>   	int cap, cap_count;
>>   	u64 cap_array;
>> @@ -146,10 +150,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>   		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>>   			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>>   			rmap = &map->status;
>> +			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
>>   			break;
>>   		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>>   			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>>   			rmap = &map->mbox;
>> +			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
>>   			break;
>>   		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>>   			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
>> @@ -157,6 +163,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>>   		case CXLDEV_CAP_CAP_ID_MEMDEV:
>>   			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>>   			rmap = &map->memdev;
>> +			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
>>   			break;
>>   		default:
>>   			if (cap_id >= 0x8000)
>> @@ -421,7 +428,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>>   	map->base = NULL;
>>   }
>>   
>> -static int cxl_probe_regs(struct cxl_register_map *map)
>> +static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>>   {
>>   	struct cxl_component_reg_map *comp_map;
>>   	struct cxl_device_reg_map *dev_map;
>> @@ -431,12 +438,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>   	switch (map->reg_type) {
>>   	case CXL_REGLOC_RBI_COMPONENT:
>>   		comp_map = &map->component_map;
>> -		cxl_probe_component_regs(host, base, comp_map);
>> +		cxl_probe_component_regs(host, base, comp_map, caps);
>>   		dev_dbg(host, "Set up component registers\n");
>>   		break;
>>   	case CXL_REGLOC_RBI_MEMDEV:
>>   		dev_map = &map->device_map;
>> -		cxl_probe_device_regs(host, base, dev_map);
>> +		cxl_probe_device_regs(host, base, dev_map, caps);
>>   		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>>   		    !dev_map->memdev.valid) {
>>   			dev_err(host, "registers not found: %s%s%s\n",
>> @@ -455,7 +462,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>   	return 0;
>>   }
>>   
>> -int cxl_setup_regs(struct cxl_register_map *map)
>> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
>>   {
>>   	int rc;
>>   
>> @@ -463,7 +470,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>>   	if (rc)
>>   		return rc;
>>   
>> -	rc = cxl_probe_regs(map);
>> +	rc = cxl_probe_regs(map, caps);
>>   	cxl_unmap_regblock(map);
>>   
>>   	return rc;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index a2be05fd7aa2..e5f918be6fe4 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -4,6 +4,7 @@
>>   #ifndef __CXL_H__
>>   #define __CXL_H__
>>   
>> +#include <cxl/cxl.h>
>>   #include <linux/libnvdimm.h>
>>   #include <linux/bitfield.h>
>>   #include <linux/notifier.h>
>> @@ -284,9 +285,9 @@ struct cxl_register_map {
>>   };
>>   
>>   void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>> -			      struct cxl_component_reg_map *map);
>> +			      struct cxl_component_reg_map *map, unsigned long *caps);
>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>> -			   struct cxl_device_reg_map *map);
>> +			   struct cxl_device_reg_map *map, unsigned long *caps);
>>   int cxl_map_component_regs(const struct cxl_register_map *map,
>>   			   struct cxl_component_regs *regs,
>>   			   unsigned long map_mask);
>> @@ -300,7 +301,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   			       struct cxl_register_map *map, int index);
>>   int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   		      struct cxl_register_map *map);
>> -int cxl_setup_regs(struct cxl_register_map *map);
>> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
>>   struct cxl_dport;
>>   resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>   					   struct cxl_dport *dport);
>> @@ -600,6 +601,7 @@ struct cxl_dax_region {
>>    * @cdat: Cached CDAT data
>>    * @cdat_available: Should a CDAT attribute be available in sysfs
>>    * @pci_latency: Upstream latency in picoseconds
>> + * @capabilities: those capabilities as defined in device mapped registers
>>    */
>>   struct cxl_port {
>>   	struct device dev;
>> @@ -623,6 +625,7 @@ struct cxl_port {
>>   	} cdat;
>>   	bool cdat_available;
>>   	long pci_latency;
>> +	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>>   };
>>   
>>   /**
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 2a25d1957ddb..4c1c53c29544 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -428,6 +428,7 @@ struct cxl_dpa_perf {
>>    * @serial: PCIe Device Serial Number
>>    * @type: Generic Memory Class device or Vendor Specific Memory device
>>    * @cxl_mbox: CXL mailbox context
>> + * @capabilities: those capabilities as defined in device mapped registers
>>    */
>>   struct cxl_dev_state {
>>   	struct device *dev;
>> @@ -443,6 +444,7 @@ struct cxl_dev_state {
>>   	u64 serial;
>>   	enum cxl_devtype type;
>>   	struct cxl_mailbox cxl_mbox;
>> +	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>>   };
>>   
>>   static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 0b910ef52db7..528d4ca79fd1 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -504,7 +504,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>   }
>>   
>>   static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> -			      struct cxl_register_map *map)
>> +			      struct cxl_register_map *map,
>> +			      unsigned long *caps)
>>   {
>>   	int rc;
>>   
>> @@ -521,7 +522,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>   	if (rc)
>>   		return rc;
>>   
>> -	return cxl_setup_regs(map);
>> +	return cxl_setup_regs(map, caps);
>>   }
>>   
>>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>> @@ -848,7 +849,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   
>>   	cxl_set_dvsec(cxlds, dvsec);
>>   
>> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
>> +				cxlds->capabilities);
>>   	if (rc)
>>   		return rc;
>>   
>> @@ -861,7 +863,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	 * still be useful for management functions so don't return an error.
>>   	 */
>>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>> -				&cxlds->reg_map);
>> +				&cxlds->reg_map, cxlds->capabilities);
>>   	if (rc)
>>   		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>>   	else if (!cxlds->reg_map.component_map.ras.valid)
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 19e5d883557a..dcc9ec8a0aec 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -12,6 +12,36 @@ enum cxl_resource {
>>   	CXL_RES_PMEM,
>>   };
>>   
>> +/* Capabilities as defined for:
>> + *
>> + *	Component Registers (Table 8-22 CXL 3.1 specification)
>> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
>> + */
>> +
>> +enum cxl_dev_cap {
>> +	/* capabilities from Component Registers */
>> +	CXL_DEV_CAP_RAS,
>> +	CXL_DEV_CAP_SEC,
> There are a few caps that does not seem to be used yet. Should we not bother defining them until they are being used?


Jonathan Cameron did suggest it as well, but I think, only when dealing 
with capabilities discovery and checking.

It is weird to me to mention the specs here and just list a few of the 
capabilities defined, but I will remove those not used yet if that is 
the general view.


>> +	CXL_DEV_CAP_LINK,
>> +	CXL_DEV_CAP_HDM,
>> +	CXL_DEV_CAP_SEC_EXT,
>> +	CXL_DEV_CAP_IDE,
>> +	CXL_DEV_CAP_SNOOP_FILTER,
>> +	CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
>> +	CXL_DEV_CAP_CACHEMEM_EXT,
>> +	CXL_DEV_CAP_BI_ROUTE_TABLE,
>> +	CXL_DEV_CAP_BI_DECODER,
>> +	CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
>> +	CXL_DEV_CAP_CACHEID_DECODER,
>> +	CXL_DEV_CAP_HDM_EXT,
>> +	CXL_DEV_CAP_METADATA_EXT,
>> +	/* capabilities from Device Registers */
>> +	CXL_DEV_CAP_DEV_STATUS,
>> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
>> +	CXL_DEV_CAP_MEMDEV,
>> +	CXL_MAX_CAPS = 32
> This is changed to 64 in the next patch. Should it just be set to 64 here? I assume you just wanted a bitmap that's u64 long?


Oh, yes, I should change it here.

  It was suggested to use CXL_MAX_CAPS for clearing/zeroing new 
allocated bitmaps instead of BITS_PER_TYPE(unsigned long) as in v4, and 
for that to work, CXL_MAX_CAPS needs to be defined taking into account 
the size of unsigned long, which is the minimum unit for BITMAP. For 
x86_64 that is 8 bytes. Otherwise the clearing would leave the upper 32 
bits untouched.

Thanks!


> DJ
>
>> +};
>> +
>>   struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>   
>>   void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>

