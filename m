Return-Path: <netdev+bounces-128520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B8C97A135
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1864F2867CE
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9054155359;
	Mon, 16 Sep 2024 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YsZ8LVAA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75F158557;
	Mon, 16 Sep 2024 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488264; cv=fail; b=asZjBdE3AT4y8620Fua9qi54KJHJPMENZZjwq8tlrGJG1KOy0//hmOATLLpCFEgzt61imxBwyM+vdiW2h2blF4xWqggPe3G0KHabMq2LYYrUSSNpafBSLQeHU4Ih/VijunZjUf9c0yZOyMSGcCYhFrGYhnvk+LFW+hZv5UE4XlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488264; c=relaxed/simple;
	bh=ev1KWFFUSY5R+EsxsIeWfeijB2HsUay8rWnd7IjwU1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MIvFaMJbOyBNk275Csxq3RsnBlWN1PuO02vDqOj/k+CphBWfSpuQ/Tw0OgEae+noYtX8/L43v02UiwCY1uwld+mJysN4xAHnX6UMgrsB7uTmS2HmU6YbScOugu0GoKhcQgYIWTxE26IML2bYTNLPeE2voG59BcEBXa3zJ5FUTJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YsZ8LVAA; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzZJ/uvV2wBO3jkUyPkKWXi5STxIIJT+B4iP4z3caxfhs2FuNmdeYEEPvBAnChoEZdegA2StxFhBrUUoDAQp53y7nlOy6ieR8sV0KbQNUliqPjHS8LGbdJp//rDetlDhy6ejVdJqCPYARGCZCx1uf6sLwJ7bE3CsKA0hdK3dWDVlWIw92+hXGuWBb8TdDpocMQEQSFZS6XWJHQNzrTa6exfkV9kd+SRwfzLr/yApPeJSjgDPIC14HHjJ0ipJWbBtJLjEmMLhSQpKqJY79H+T1ok0UWINByWB8AeeQNFhs3XNMReKv85fzMO96tJgCAVMaPG3iP5E1gYnZQRGBEOd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ykBTvGmVitp4NrKGdrWXD8t2lr7ZZbzFpBq1SgOQIw=;
 b=RRu0lOGUTGcVCs6p/hucUPnLujw6/BzVMp762AhLLLXPGvfGwl1Ga0YRn8GjflGe7uuUmiaogbPwU1R3cy6UlndJmR7SUDHpsKN51dBFziRBNjrprjCvFmnO9qi8PGbOwDdNvU5/57q+HMTs4xK1VZoktbByZd69mIoRJ0Kh3S/1jTSE2zIOmWrpvFK4wEVmmDzgXjuAIcYDK4j8UC7uoNfoLI3Bzo4lRBMZk0/wujb2Snv+zakte1J2v4vFnpnXdzXYqUjUFPF0QNlpM6CLJqushz9e3/FbPEdhaOdo/AIev/hzgPVz9Uk0i0EOB1K3P3DSn9Nug/B4/HObIBJguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ykBTvGmVitp4NrKGdrWXD8t2lr7ZZbzFpBq1SgOQIw=;
 b=YsZ8LVAAMyR17E1Q9UwONjVg64/IUdmmVpLkHiBDaHsvgcWVKU7U91wRETxwYOPxoqyVCr59LngLXt3GuQwsXIrj9AVyqj6qFzToQ3wHgd/mX8RT+bz7oPfgWcPyNP5nNwowW94O1ZLviB5O0f4yje9e17uqaiJTJWz2Hz/uU8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 12:04:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 12:04:19 +0000
Message-ID: <5e3337df-cb85-efbb-ceaf-a9d9808d981c@amd.com>
Date: Mon, 16 Sep 2024 13:03:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 01/20] cxl: add type2 device basic support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-2-alejandro.lucero-palau@amd.com>
 <20240913174103.000034ee@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240913174103.000034ee@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0319.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 819b8d7a-ad1c-4848-a8eb-08dcd647af77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck40UzIvaFRZYkVQQUVZZkhWaUZ3Tm9ySFBtVWdRSHNGbHBVbnlzVTlMQVJI?=
 =?utf-8?B?WTJvMFVabURvc1JEejAzTG5zdE9sMytLRlZqVE4zbDMzd1hHc3p5aWR2bW53?=
 =?utf-8?B?bVFndGVRV1U3Vjh1eGtrZEo3S1NWcWRRalMrWjlUOHIxcnoyZVVzTURKZWt2?=
 =?utf-8?B?QXBVZDhBbW0rMGJSSkJIalMybWZxUHVTM0o4WGdsMG5QUXZhVjNMNENUVEd0?=
 =?utf-8?B?T0liN1hYNkV3UUNua0laMjV1cnRxOW93SWhrV2d4ZXlBUVI1YmNiVU1HVy90?=
 =?utf-8?B?L1RoQ05ZWUZuTEJaMm82ZDhZMGNrTFRSRldZRHZaRGExVk9ublJKNXYxR2tZ?=
 =?utf-8?B?RWp4ZDBwM3dvN3BKYTNlcTZIUlVUSC9pZCtKWlQwSnUrRUhISGZid2pRSTJo?=
 =?utf-8?B?UnV3ZUE5VHRjclJiNXF3dWFXUzhEUlRzSnNzcXo4VDFocU1qUTFZTHZPZU5X?=
 =?utf-8?B?WXYrd1BadHZGNTFvc0R1L1EzMzdDczlRMmRvV0FvcmRmKzdjeXdQS2ZacXhX?=
 =?utf-8?B?Rll2QWRXODBnaHdPR1BCb1MzYXFqZHpSdFFyNEhqakZKK2RYeVRWcjA1eVlB?=
 =?utf-8?B?Qit3WVlic3E1eUtrZUs2eWJrSnQrQkJSaUN1Qm5kRmZSNjh6OUJrOEtIaWYr?=
 =?utf-8?B?Z09zQ0lid0dYdDlLMlZ5NloxQ29seXFBL3pFUS9GZWhRU0tuK0FkeDhpUXk0?=
 =?utf-8?B?N2wxWENXYzBFNE9PWE5ZVy9qYWxPNTJHTVhYaWYzYno1V2xNQitnL012cWJs?=
 =?utf-8?B?U2V3TTk3QTBOdjcwVWxyQ2NKWlpvYlhLZDhYVkgwRmQwSDFnSlhRQ3JGc1gw?=
 =?utf-8?B?d0FNdm9Hakc3RjFJMFJXbXlnUjRGclVyMkRCRUtyampSWlExbGp2cGwrOUty?=
 =?utf-8?B?c0Q0aDNJRE1NTnE2dGdKRkNaMDB2OW5QWG42NjNYMWdDWTFEYXFlSXNlSjBF?=
 =?utf-8?B?SlJ0a2YyTWxORm5JY3dQb2FXcGRtUkNUY0xaamY0V0hRWVIrMjVKQ0VpemZI?=
 =?utf-8?B?dlNMVHVyQmdDZ2hkOUZUTE5XM21paFdDSHV4aXFaT3lrbGQzbk5BN1pEMTNJ?=
 =?utf-8?B?czdDNFQ0elQzQlh1dW9PaTQwZk1QTXIzM0tQT2ZQT2hEa240Rzc4Z1dLSzR5?=
 =?utf-8?B?d1FqeU81dFIybG5LYzJSRlRKelFMRlpPMHJmUFRWOEg4ZnY4WmpFa3cydW1i?=
 =?utf-8?B?TW5ZVVQzNmdEVVEzcmp4R2hwdnNRcEw1a2djMjE0ZG8xVzRQaUVHTHJjak9D?=
 =?utf-8?B?UmRzamw0SVdZbkdoUi9OM0RHWGhhMWNRbDBIQmEwV21SVDNiczRNUllVTTZt?=
 =?utf-8?B?U1h1WXlXYjlCS1ZvT2JSWWRVNXBaeVhRV1p2bVRSMTZhaEs5MEwySElvWmk3?=
 =?utf-8?B?ZmMydUF2U1c5OVdhWm94SWlCeTFJYm5vYndMc3V3OFA4Zi9xTGVDVHNuZWt0?=
 =?utf-8?B?UGM4YS9HYUJwaWk0WjRqSjFWc1hCMXYrODVkY2Rhd2NXQmRpWmlXY1prd0hF?=
 =?utf-8?B?QVFUTmN2T281VGxoUG12VVpZSEdTYWNVQ0h5elgvUUQzM05xWmxUU0R5bEIz?=
 =?utf-8?B?SjRBVXBhcVFMZEpTVzBYNWI0VDA1dVRReUpCYU56UXRSWFBtaEF1ZURSc1lF?=
 =?utf-8?B?QnVHY0NkZjREa0JNOTJIQ1MwZ1QxQ1BUYjZ1YUhMZVozeXExYzhFSlhKcUJN?=
 =?utf-8?B?L3dDenRoYlJKeU1HMzZLYVN5clp4eFl0cjloTEowMERQUXFWS2dzRG8wb3R4?=
 =?utf-8?Q?jyPDmHSnNnTtrNJAzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEZ1YjJmTGZQMG5lRGovUUx5Um1xdDVxZTBZdjVJOXYrMFh5cUFpS0RQSTJY?=
 =?utf-8?B?ejZmVFVzdWhOelRTQUFQRnNsTmREM0dDTm84UEhRcTJ5V0FydGtycXBOZTRY?=
 =?utf-8?B?Vm9hcE1uTk9KOEloaWcwdVJKMjJUQi9PbkNCU3JhaXNPbzNLZXRLOG80dU1v?=
 =?utf-8?B?U0toeGRwODBsN05MQ3ZLRStvTnlpNjhBZmZLUk9USkk5d0Z1dUliV2RkSjRI?=
 =?utf-8?B?WWVQWVVtM21WbGFRWUhGZzNUVzk2ZWFuSFkyMWtWWUhORklKQ3h2OHNQcG5U?=
 =?utf-8?B?NDlVemlDVXJaUjR2MGpOcHZJeEVFcUozQ2djbHFiWmZLSkRZWFpEL2Y2dEI0?=
 =?utf-8?B?dzU2SGxsVngzSHdlSnBCT3dNOFJFaElHSyt3VVprTkN1ZmJoYmRVZlQyc1Vt?=
 =?utf-8?B?Y1ZjRlNQOHo1K0IxeUxqOHQyQ2ZFWEd0b2p5Q0JQVnhTb3ZWOWlSQ1JPa1dr?=
 =?utf-8?B?eTdKUkFCbk9NNitIbUttRlE5Uk5oRUF3c0poaDZQRllJR3VYNnZMOTdpWGNV?=
 =?utf-8?B?U0Fid0Y1dkVTS1RDN0cxQk1yb1BWekpjSk5WeU1EcmF4SGFiTkVoVVNrenZp?=
 =?utf-8?B?SHN4QWJ2L1AvMVJ1ejJMT2dOczB0YTlwK2N6cTV5cjlEa2hkalFQbjFDRGxJ?=
 =?utf-8?B?N1c3NFZJeWljNFVhY09EUXhHa040Q1duMWN4anoyMGdidktscXBycHFKNmNo?=
 =?utf-8?B?Tm9QYy9kNEl6MWlNV3Q1bDdOZGpnd2dYUjRvMW1TMHJVQ2pHNjRtSGVnMEFh?=
 =?utf-8?B?eFdsNm9EQ0JjOFhENWNxVGhDNGVDdFVhWHBBb1JHclV1UytaQVA3MUhuY2F1?=
 =?utf-8?B?VVVFK3B2U2FFL1cvMWk0NFJUM2Q2RERUaktIdnc5MVdFbXdCd00xdGJ0cFVx?=
 =?utf-8?B?cGlYZjEzODBlQThueDNTYURVYkRrcEhhZWZ2Z20valR6TURPOC9EcTBUVEhM?=
 =?utf-8?B?WStyV240UVRobmRwZFNod0QzYkdQRTQrb3FtRWpyem5hcXFkNy9Ub2dGL3Y2?=
 =?utf-8?B?ekljWHlSTm14UTZNYWFUNGorY29BSkZKM2dWeTFqU3lBM3BXYVBJNkRDODlo?=
 =?utf-8?B?cGMrelo5M0RnaXdIdXJiN1p6aC9sdHJja3laNEhxQWNyZ29MczJyUGd5MkdN?=
 =?utf-8?B?cHF5Rk5vQ0kycTZua1RXdGlnMVQ5blBmUUc1TGVOUGtyOHJZREw4NTVVcVp6?=
 =?utf-8?B?bnJHaGcwNXNaNGZuUlczMUJEdXZ3dlZaRmxmamoyZFdOSmhPbVBJWDRENllL?=
 =?utf-8?B?Lzc2TGlGdHM1OHVCSjFTcFcySy9WWm1BMjdRa3VKaWNodm5QSk5qRTZYWTN4?=
 =?utf-8?B?MERHb01sZm5QdllPSENIMGpoSHBsR1ordVR5dHVBb202S3VlYzhlWHNIVFlx?=
 =?utf-8?B?em1EMGJjYktuRFA5dHd6cVcvU3o2QkNMUGF3TnE1Z2x0VEx2WjNiZjFNVll4?=
 =?utf-8?B?anZqckxKZGRJWEE0cTlScmlMQ2N5T25tYUJYMk53cGQyVi80aXFVdDhSbzRB?=
 =?utf-8?B?LzhGQktzQjNBWXVraFhqMXd4cGdKY3pTbkRiV2JSR3ZHREs5RG5yekRnWnFo?=
 =?utf-8?B?dC9qelUrRDFPTG5EYlFyaEpvT25GM2s2VnlCSEd5VXJBRyt2Zlk3UnByR3Rn?=
 =?utf-8?B?ZFNrc3dITlB6Z0VZS2JuVGhqNGJNZ09iTmVTUDVLeFBvQUJ5SUxxNnZSTVFI?=
 =?utf-8?B?aEhxZVRYdU52cFE0bWtJQlRVWmtlTEoxQ0RqNmlGck5EVVlFQVRPdFNwNGNx?=
 =?utf-8?B?Uk5laHZqMmFWZEtmdGlWcmhuRlNxNFNYRHk5ZHkzL2w5QklsTnlId1NvZS9D?=
 =?utf-8?B?VVlYM2xodWZLR3Z0VGlGQnNMWk5OU041MUl2eWpkVlk5SmRPc2JVNW52REtN?=
 =?utf-8?B?dkZMdlFjaldxNXF5bXRNa0xyZFpSMk81Q1h2cFJSU0VORW1KbEZvekpCaS82?=
 =?utf-8?B?QjRlOE45VUhLVkFSM3VGN0RiWmU3ZTRvTFRUbzRGL01YWG1oQVY4eEFOZ2xX?=
 =?utf-8?B?Wkc0UUZWL2huQVpoT1BFRlIydkd3YjlCTmZRZjhDL2dzMmNBcjJBd3Q3T21I?=
 =?utf-8?B?L1V5R1l0TXBGcGVOMWc4clNPWW1KUC9iTnI0TWpwdFZqeXg5T1RWVHhvZzFC?=
 =?utf-8?Q?eHpGMR5Y7LPvS5AiVB1d9743n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819b8d7a-ad1c-4848-a8eb-08dcd647af77
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 12:04:19.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZDpi6hzOC3EDm2RGYKgDqWCekPu+hJMcEEXx4Jj6I1rll1Y9sMDwso8Jujpp/2G1SzCLLp26G9Y7WJmSFDClw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401


On 9/13/24 17:41, Jonathan Cameron wrote:
> On Sat, 7 Sep 2024 09:18:17 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
> Hi Alejandro,
>
> I'm mainly looking at these to get my head back into this support
> for discussions next week but will probably leave
> lots of trivial review feedback as I go.
>
> And to advertise that:
> https://lpc.events/event/18/contributions/1828/


Looking forward to see you there along with other CXL kernel guys.

>> Differientiate Type3, aka memory expanders, from Type2, aka device
> Spell check. Differentiate.


Embarrassing ...I did fix that or I though I did since this was also 
pointed out by Dan Williams as well.

I'll definitely fix it for v4.


>> accelerators, with a new function for initializing cxl_dev_state.
>>
>> Create accessors to cxl_dev_state to be used by accel drivers.
>>
>> Add SFC ethernet network driver as the client.
> Minor thing (And others may disagree) but I'd split this to be nice
> to others who might want to backport the type2 support but not
> the sfc changes (as they are supporting some other hardware).


Should I then send incremental sfc changes as well as the API is 
introduced or just a final patch with all of it?


>> Based on https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> Maybe make that a link tag Link: .... # [1]
> and have
> Based on [1] here.


OK.


>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource type)
>> +{
>> +	switch (type) {
>> +	case CXL_ACCEL_RES_DPA:
>> +		cxlds->dpa_res = res;
>> +		return 0;
>> +	case CXL_ACCEL_RES_RAM:
>> +		cxlds->ram_res = res;
>> +		return 0;
>> +	case CXL_ACCEL_RES_PMEM:
>> +		cxlds->pmem_res = res;
>> +		return 0;
>> +	default:
>> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
> It's an enum, do we need the default?  Hence do we need the return value?
>

I think it does not harm and helps with extending the enum without 
silently failing if all the places where it is used are not properly 
updated.


>> +		return -EINVAL;
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 4be35dc22202..742a7b2a1be5 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/pci.h>
>>   #include <linux/aer.h>
>>   #include <linux/io.h>
>> +#include <linux/cxl/cxl.h>
>> +#include <linux/cxl/pci.h>
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>>   #include "cxl.h"
>> @@ -795,6 +797,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	struct cxl_memdev *cxlmd;
>>   	int i, rc, pmu_count;
>>   	bool irq_avail;
>> +	u16 dvsec;
>>   
>>   	/*
>>   	 * Double check the anonymous union trickery in struct cxl_regs
>> @@ -815,12 +818,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	pci_set_drvdata(pdev, cxlds);
>>   
>>   	cxlds->rcd = is_cxl_restricted(pdev);
>> -	cxlds->serial = pci_get_dsn(pdev);
>> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
>> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>> -	if (!cxlds->cxl_dvsec)
>> +	cxl_set_serial(cxlds, pci_get_dsn(pdev));
>> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +	if (!dvsec)
>>   		dev_warn(&pdev->dev,
>>   			 "Device DVSEC not present, skip CXL.mem init\n");
>> +	else
>> +		cxl_set_dvsec(cxlds, dvsec);
> Set it unconditionally perhaps.  If it's NULL that's fine and then it corresponds
> directly to the previous


OK. I guess keeping the dev_warn. Right?


>>   
>>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>   	if (rc)
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
>> index 6f1a01ded7d4..3a7406aa950c 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -33,6 +33,7 @@
>>   #include "selftest.h"
>>   #include "sriov.h"
>>   #include "efx_devlink.h"
>> +#include "efx_cxl.h"
>>   
>>   #include "mcdi_port_common.h"
>>   #include "mcdi_pcol.h"
>> @@ -899,6 +900,9 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>>   	efx_pci_remove_main(efx);
>>   
>>   	efx_fini_io(efx);
>> +
>> +	efx_cxl_exit(efx);
>> +
>>   	pci_dbg(efx->pci_dev, "shutdown successful\n");
>>   
>>   	efx_fini_devlink_and_unlock(efx);
>> @@ -1109,6 +1113,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>>   	if (rc)
>>   		goto fail2;
>>   
>> +	/* A successful cxl initialization implies a CXL region created to be
>> +	 * used for PIO buffers. If there is no CXL support, or initialization
>> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
>> +	 * defined at specific PCI BAR regions will be used.
>> +	 */
>> +	rc = efx_cxl_init(efx);
>> +	if (rc)
>> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
> If you are carrying on anyway is pci_info() more appropriate?
> Personally I dislike muddling on in error cases, but understand
> it can be useful on occasion at the cost of more complex flows.
>
>

Not sure. Note this is for the case something went wrong when the device 
has CXL support.

It is not fatal, but it is an error.


>> +
>>   	rc = efx_pci_probe_post_io(efx);
>>   	if (rc) {
>>   		/* On failure, retry once immediately.
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> new file mode 100644
>> index 000000000000..bba36cbbab22
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + *
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#include <linux/cxl/cxl.h>
>> +#include <linux/cxl/pci.h>
>> +#include <linux/pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	(1024 * 1024 * 256)
>> +
>> +int efx_cxl_init(struct efx_nic *efx)
>> +{
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl;
>> +	struct resource res;
>> +	u16 dvsec;
>> +	int rc;
>> +
>> +	efx->efx_cxl_pio_initialised = false;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +
> Trivial but probably no blank line here. Keeps the error condition tightly
> grouped with the call.


OK


>> +	if (!dvsec)
>> +		return 0;
>> +
>> +	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
>> +
>> +	efx->cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
>> +	if (!efx->cxl)
>> +		return -ENOMEM;
>> +
>> +	cxl = efx->cxl;
> Rather than setting it back to zero in some error paths I'd
> suggest keeping it as local only until you know everything
> succeeded.
>
> 	cxl = kzalloc(...)
> 	


It makes sense.


> //maybe also cxlds as then you can use __free() to handle the
> //cleanup paths for both allowing early returns instead
> //of gotos.


Maybe, but using __free is discouraged in network code: 1.6.5 at

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


> 	...
>
> 	efx->cxl = cxl;
>
> 	return 0;
>
>> +
>> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
>> +	if (IS_ERR(cxl->cxlds)) {
>> +		pci_err(pci_dev, "CXL accel device state failed");
>> +		kfree(efx->cxl);
> Use the a separate label below.  Error blocks in a given function
> should probably do one or the other between going to labels
> or handling locally.  Mixture is harder to read.


OK


>
>> +		return -ENOMEM;
>> +	}
>> +
>> +	cxl_set_dvsec(cxl->cxlds, dvsec);
>> +	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
>> +
>> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA)) {
>> +		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
>> +		rc = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM)) {
>> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
>> +		rc = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	return 0;
>> +err:
>> +	kfree(cxl->cxlds);
>> +	kfree(cxl);
>> +	efx->cxl = NULL;
>> +
>> +	return rc;
>> +}
>> +
>> +void efx_cxl_exit(struct efx_nic *efx)
>> +{
>> +	if (efx->cxl) {
>> +		kfree(efx->cxl->cxlds);
>> +		kfree(efx->cxl);
>> +	}
>> +}
>> +
>> +MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> new file mode 100644
>> index 000000000000..f57fb2afd124
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> ...
>
>
>> +struct efx_cxl {
>> +	struct cxl_dev_state *cxlds;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct cxl_port *endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_region *efx_region;
> Why is the region efx_ prefixed but nothing else?
> Feels a little random.
>
>> +	void __iomem *ctpio_cxl;
>> +};
>> +
>> +int efx_cxl_init(struct efx_nic *efx);
>> +void efx_cxl_exit(struct efx_nic *efx);
>> +#endif
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..e78eefa82123
>> --- /dev/null
>> +++ b/include/linux/cxl/cxl.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_H
>> +#define __CXL_H
>> +
>> +#include <linux/device.h>
>> +
>> +enum cxl_resource {
>> +	CXL_ACCEL_RES_DPA,
>> +	CXL_ACCEL_RES_RAM,
>> +	CXL_ACCEL_RES_PMEM,
>> +};
>> +
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>> +
>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +		     enum cxl_resource);
>> +#endif
>> diff --git a/include/linux/cxl/pci.h b/include/linux/cxl/pci.h
>> new file mode 100644
>> index 000000000000..c337ae8797e6
>> --- /dev/null
>> +++ b/include/linux/cxl/pci.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> Bit bold to claim sole copyright of a cut and paste blob.
> Fine to add AMD one, but keep the original copyright as well.
>

Sure.


>> +
>> +#ifndef __CXL_ACCEL_PCI_H
>> +#define __CXL_ACCEL_PCI_H
>> +
>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE					0
>> +#define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> Brackets around (i) to protect against stupid use of the macro.
> This is general kernel convention rather than a real problem here.
> Sure original code didn't do it but if we are touching the code
> might as well fix it ;)


I found this warning when checkpatch and I thought it should not be done 
then as it was there from a previous patch.

But I agree, I should fix it now.

Thanks!


>
>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> +
>> +#endif

