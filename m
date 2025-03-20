Return-Path: <netdev+bounces-176539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49740A6AB6D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EE718980FF
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2705A224228;
	Thu, 20 Mar 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oajo7DWr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A72080D9
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489230; cv=fail; b=aCKCAFYvcW9ijxZkoIngYgcFdDuCKCriJZCjejJuWweMs4NyUD94Tk7SExG6HxiyLqXmTmRuKf1Wwy2dyTvk080qmRjnVyVy/Zf7GEmaSM04vYqoF8kK5qGVzbd3dP8owt/bkvK+dLpEL31POO4bDbCXR8ras8G3TbqVtV1PJhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489230; c=relaxed/simple;
	bh=mVXwZ8DTXddUqN23h7fZ9neGM8XJT2/12KCEuR5einY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ikPDTHwsNQ81QuKxmCtHwxtyWVsv+7J/d6KOWuEIgcAlSGQ9G/PM5EsK9Xp5adgOSklAXCeJqEIolncuWIfPr9093idqXvvwFhDDzYPM7I0o9d1VxO60vwrhEYp+PSWX1CIzGvuw36IEsk2RURTcQ1oLnpPrsSt4tTfkYRfX8TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oajo7DWr; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6QU+B8Gn4R13KkQI3dq7N3Zp7F73ZKy/h6I4lzU7Hb7adhg3S2FZp8344rIngbvj9tYX6Mg79ODLUnqFetItEYR3I3aiKi9ngcNu+2B/lem5fW3EkR+XO4mZUXDZ0XcQtz/lVUaAXGEyIqjbEOrLucKT57+2Xvmcr6z4tIwQ6ckpqXT37DSdKiJeU+oYbyssgmhURq5VxqwKKAwzQf5aLCWTXjipE+8hd3K8qJRjpkMLhZBccF7qC/YUKL0DOp5lqvL3YOf/KSkpoSArwfCGwG24xnwaVIAki7A9eznFIevx3RG6YLM/XbYJsks9DHKxDROEYZ16Jb+31/Mcyyi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZXIXF+jDJ8MQK4eQlcpFPWu43sXyBvLTIPcyQIX/TY=;
 b=xKE5NwBowcW1BLVbH/sXmEsFMmbZQh2eRUbOchqdazCFvg7vmiX1gLLWEFgYv469ikCSxsExITrRNxM25EKB6u4Yb7Wumjh1dFaAI6H5LCdFaXnl+6KC4XYzg4IRSA/7Fajji/NSdTBHbe3KSqO/Uy65IhEJftqI4shTKJ4HiyhrhmE6jailpGeRDU3jUCk6FpMYRTpthBAwUj5/6udR5GBhoU1QtHKIM+kUM3U/w3EcIit3fAfbVlSzMdRR2fmN4s+rgqDVopmeNoEyhX2esTFMQdDqwpbRTNbne8msVCwQrEGLXvdzgYcSvmbYaNrD/obivA9BDdzjpZNFsrOGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZXIXF+jDJ8MQK4eQlcpFPWu43sXyBvLTIPcyQIX/TY=;
 b=Oajo7DWrWUvAlPqTPTEOCmYp9ZzXppMERqc2AV4W/U1MbrEazndXMck0FH4sJvXhysp5tV9TOJsIR4s69nwRJZFCLMHtvvFtkrOdIMKfnZfMn8n/Nel03GX3GhGm1+FSu905TAuVqLwP3aNxvDOXrio9QVFTRpxzU0wLV6z0bpKecLpMPhueVdnoMlPCWkfhLRmjIabWUp9J2syMIUKIkGtwlJWR/ZOPhcm8OqxqNpOw49LMQidGQVz30ssY6Un7qmU4BA1wX9dNZ2Cp42ti7bdGWiEPhTDLLwrsRjB02VRlMbW12RmM/Hfh1WSbbYYroPKByfMmFGvpeg8TI2YFFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21)
 by SA1PR12MB9548.namprd12.prod.outlook.com (2603:10b6:806:458::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 20 Mar
 2025 16:47:05 +0000
Received: from CY5PR12MB6322.namprd12.prod.outlook.com
 ([fe80::76a1:4b0d:132:1f8e]) by CY5PR12MB6322.namprd12.prod.outlook.com
 ([fe80::76a1:4b0d:132:1f8e%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 16:47:05 +0000
Message-ID: <61db29bc-2c95-49e3-8ecc-fa5485b8919d@nvidia.com>
Date: Thu, 20 Mar 2025 18:46:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tls: strp: make sure the TCP skbs do not have
 overlapping data
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 borisp@nvidia.com, john.fastabend@gmail.com, Gal Pressman <gal@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20221012225520.303928-1-kuba@kernel.org>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <20221012225520.303928-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::11) To CY5PR12MB6322.namprd12.prod.outlook.com
 (2603:10b6:930:21::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6322:EE_|SA1PR12MB9548:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ea8e9f-55ab-401f-0d5b-08dd67ced86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDlhdDRVUDhGZHdZRm44akxsSjhhckpneHErUkx2MnFqeC9wSk11Q0xldlZq?=
 =?utf-8?B?L1N2dVpRdW5Ed0VIM2xoL3lhVjhvSmZOZVlHQ3VqbTNHdEVnWVNpRS95bjR1?=
 =?utf-8?B?RW5qSlJ2SkNqTktwdUxUM0NSRFVSOUhsQ0h4aVZTMnJTVFFjNGR2SVJqeHBh?=
 =?utf-8?B?c0ZqK2puQ3NXU0k1SUF1bjVrKzlkUDBRUFZheEt3TUIrN3FLUnFnSGs5WVp2?=
 =?utf-8?B?RUFLaVdsS0tXK3FIRzA3ZlQvaVFIZVcwT3VVd0ozWmE1cE8ySG9DNDBYYzdT?=
 =?utf-8?B?Y0VuR0FPdU1YMjhUL0hvSWFSWkNYVDJYeFlYM1FpV0tWSkRkaGk5cXRYcDNR?=
 =?utf-8?B?VGpVWG42U3dCRi9SR0lrbksrNUpud0cwV2lUY0VZZ0dNVnNaeldRMVQ5UDYy?=
 =?utf-8?B?cTcwUHlHZnRXdjhieDFlUWpNdXlJcFRtdUYzR2tUc3g5QTNyVDhQdnFUendI?=
 =?utf-8?B?RFhQTCtlNEhHanQvTmtEZFJxeDhCejBzc3p5WnpvR0ZjdS81MmZuTkE4dDBZ?=
 =?utf-8?B?TW16ZmZGK0VmN2xXdjh4WHFGZWxQYXYrWnFZSnhlRTlDODR3TWdJa1N5ZEF1?=
 =?utf-8?B?Rmp3ZmdaOGppbkdWOU9RMklkU0sreDNKSFRvRCs5d21JL09pcE52VW5qMXk1?=
 =?utf-8?B?TWs2U3lyenRRWklKM3c2Q2ZwRWJHM1dGdlFldXlTL2NRTzdvUExJVVo0ME9s?=
 =?utf-8?B?eGhPci93TEVBYktyMDBNVW1hT1dKRi9Lb0c4VXJFMU00K0JjM2syUWxwZTJh?=
 =?utf-8?B?bGgwMEVKcndlcjFqOHlaVCt5dXYvalpFQkhOS3ZTWWZXcGxNd0Q1cUR5bzc0?=
 =?utf-8?B?cVR1VGI3Z2QxR1VCWjFWYWlXYWVzemE1clpGc0FjTHRzanArR0x3QUVqUXlr?=
 =?utf-8?B?RlBheGZ0SlFEbVo3Nnd3bllvWkJLREgvMXRBUUVoQk1PL2NWQ2duN2hNR2gw?=
 =?utf-8?B?MUNJZkxHbk90ZjVqS0pwSlRZV3djc1BmSytVQk82Zy9DZk03SjluOHEyVDMz?=
 =?utf-8?B?TStlM29CTDducDZmeFlBUHlWaVZQcmdBeEZsczZpL0RJUC9uc0JsVFM3elJV?=
 =?utf-8?B?RElFRGNNd2lLU29hcWVNTFBJK1h2UERyQk1WRG9nSDFvanhMUVZHZGRkMytG?=
 =?utf-8?B?VFpnMm5rWTlpREVSL2VQT0UwY3dMV3MzNFpRdVlVMUJYaU90YndLdElhTGE3?=
 =?utf-8?B?VFlhdUxCS3RvbEpwU3Q4VHVRY08xNm9mWXBvVitGa0pBekFOY2VubkZDVjRk?=
 =?utf-8?B?M1pKMHEwWVNuM0ZkWUhFRFV4MzhHaGh3bUd1c29GREZ6TklaK3gwUmd6eWN0?=
 =?utf-8?B?cFQ1V0JwNXBJWDVPa1hKb2tycG5CK1F3ZU1SemUrYk04N3owYUgrVWszOHE1?=
 =?utf-8?B?UnJaekpZNmdkdXQxWWVpRGtYb2RTT2F4N3QxR3NEd3dUUnZ3SGRkTzNjOTBn?=
 =?utf-8?B?NGYySXBkQldvM21IRlQzK3lNbTY3YXVHNHlrZjYxYzlBUi9OSlhLbUdQY2JM?=
 =?utf-8?B?VHk0WUp6ODV4NExZaXFFYS9lVSt5bnowQllWSVQwTFp0WU9sWmtiRERLajRI?=
 =?utf-8?B?dTdTalA2SmVRTzBxTXpya25zWVpqNVdTYWtLdTNoYW1KOE1TZGRFaTZJVjU3?=
 =?utf-8?B?YTg5QStmcEJ3Q0Zid29LQitQKzdnckV5cGxxWmM2a0hZYmh1d1VMbGhac25B?=
 =?utf-8?B?cE03UVlDN0V4L3R0SEw5dnczNlg0NXo0STRjcTJPNGl1TEJyRE5KbGhsYVBJ?=
 =?utf-8?B?cEkvWTBxMGM0RlkyRjkzT3pCNndoMlN5VllZOFdsMUVvTXM4SHRZS1NQMk1v?=
 =?utf-8?B?SjNnV0wyaHZkbkNiVzJuYUtkQmVtL05JTFBmaHdnNGpMWSsrVm1jZlREZjJt?=
 =?utf-8?Q?jEB/KXv6r3x8B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDB6ajdUMGF0YzdvRUpGQ3BVRVNkR0Jmb3k5NGFyMzllYThDaTNRRytEbHFC?=
 =?utf-8?B?d2hLdjJDU3NIKyt0R1doLzZLY2Z1aVdMaGJzcDJzcGZxUTFLNEpQV21haGcz?=
 =?utf-8?B?ajRHYTVZR2RiT1ZaODk1OE1WK2xuVWJDc0VvQWYxU0xKWXRZZUZ2WmpaWmVX?=
 =?utf-8?B?Y0ptZE5KM2JzQ0JJaWpJSkhiQkZxNGdjNWVzNmxDcTBLU2JlVTFmakxNRlF0?=
 =?utf-8?B?RnNUK3l1WFFONWFVbm05NXZsazRNWDNWUWNrZlVLbTV2N3VQNTBmMEZBZXpL?=
 =?utf-8?B?bUs0YWpSSlBlSEljQ2Nxck5MRWRhemFoMWNzSXpMVEJiODlnT25wUzRVMTU5?=
 =?utf-8?B?clFkZlpRYTM3czQrWTZvQnJNVFVRbTRRV3ZDbk5TVUpDd1I2bXg1TDdjdmtF?=
 =?utf-8?B?L1pHWW8rSU0rQUlxRVlkV0pQL0RLa0lvc1dGYTRDQWlsdTZ2dWk5eFhOSGFx?=
 =?utf-8?B?emhDWFlrRnVMeDEwZlUwN1RMNEhBbFd2WkhOazBXYmE0REtBV21xeHkySHRq?=
 =?utf-8?B?L1N3S0tCUzlpN2libzI2WWN1bytwSlo0UFhZc29IL29sZmpkT1h0Z0pQV0Yy?=
 =?utf-8?B?Q2I3WTVEZnZUR0MzTUtibTJMUWh1ODg0UWRQcHVuZGZqaWs0VG0zRVhValcx?=
 =?utf-8?B?ajcxU0VkWHUrTk5scnQwWE1kTE10WlcvYm1Jb2EvMEtEN1BZN2g2UDVlR0ly?=
 =?utf-8?B?YWNlYkNJTUdPZGxTeUVCSzFFUThGZmtseHQvMU55c3RKVkdUaTN1QUp1bXEv?=
 =?utf-8?B?Uk1kNWswTjRFdXBMSHhzVktLdE84Y2gzTFAweHhEcmJrNko4RDR4b21PMVRx?=
 =?utf-8?B?aFgzUGtRcElOamM0ek1qd0NCdldhcU5OL2h6dkdRNWVycGs0TDFvclVSRFFu?=
 =?utf-8?B?bzFRMU5pemt3M3U2U2xBbWtZaTA1Ym05NHRXMDlrZ0RrZVhoTFRyYUlRVWR3?=
 =?utf-8?B?OFB6ZXZ3a1R6YU5IUStEZU0yQUZPOGdmdzZpREljTzFQN0dIa2tkNjY0YXli?=
 =?utf-8?B?UXN5akpqdm1mT3ZIZllDUVcrVlZXWWkzQlJINVUxRWhEMXZhL0RNbndXKzkz?=
 =?utf-8?B?cHYvWUx6K0RXdmRZbmZYb2R5OUYvd293WU9nYkw4U1dObmNnUlhYSlZ4Nm82?=
 =?utf-8?B?TGpHK3NiWUpDY3B6bFFTYW5GN3BCSDJ5RUM5Y05OU1pPWW5neW9mMTFzT0Fa?=
 =?utf-8?B?ZWdBTXZqck0zdXUrVkJiak1uK1Y1dW5sdjMweHVsZmlKSVZBUlE4b0N6SlM2?=
 =?utf-8?B?dUdEZmowUmdOTldranRkTlRFbmxGa3BLY295VTFjd3ZCQUFFZnV0T0hYaVM1?=
 =?utf-8?B?cjFNWkV5MkdLUVFOclFkTitDLzk5U3RTaUY2bzhibGFRMVprb1JMREtKRzR6?=
 =?utf-8?B?cUpWWTVQOVZFeEtFY2wzNGxYMm9STnN5cER2ZmUzS3F1ajV0ZU9iV2VHd05V?=
 =?utf-8?B?NndPU2tuN1NnZ0hmc0hTRkptV0pxakZKeXdBR2NBaE9EeUhJNElqNDNkRDlt?=
 =?utf-8?B?SVdnRnR0S0pBZ1l4TlNHdS9Mc05LOThnRnRhcUh5SXJmZXMxQUs0dHBwUFl2?=
 =?utf-8?B?S0g2VVFmN2FOZytEN0c4bUJZeWRRb1FXdTJXcUFUUVJzcW1YU0RuY0dkVEVs?=
 =?utf-8?B?Rmh2VU5HV0oxZStBVFFpQ09LUCt3UnB5T0hoS1pqWGxZSlVqdGlsa3paV3dz?=
 =?utf-8?B?M0pxWWdJQk85b2NhMWFJWkpLbkJDaGdGV1BkNlJIZkFnVFIwenZzWWlpZ2hR?=
 =?utf-8?B?aUY4Z1BtaEpsUzFyaDZ4QmNEakluUTE2bDR3L2phOFlyelN5eWU1TmVDbG1y?=
 =?utf-8?B?T0dJQzB2Q0IvdXNXOUdVYmZaaWR2RzM5SFI1TVhoVVdHd3RIWlp4YzdzQWZ1?=
 =?utf-8?B?U3EzLzd5L1o2V0lTUVR6YUh5UmVaM3NucEF5T2RnU2JGZklqd28zTXpyOExC?=
 =?utf-8?B?OXprL1ZZMlhka0w3Nk5yUURJdUNQSVFtd1Nja3dONGZkc0orUE5DY0dhZlJH?=
 =?utf-8?B?SXdzYjNkTkxENzZPRG1kQUU3NDNNNFRGQnR1MDM4cldRR0lZWW0vVlNFQmh2?=
 =?utf-8?B?Q0dzWWNyd0JqWDRCaGNMTU1wRlJCaFpIaUFjbms5SXNYcjFrZnJaREZDOGNN?=
 =?utf-8?Q?oFHJwZa3MfIQCrIyeDErvwFmm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ea8e9f-55ab-401f-0d5b-08dd67ced86f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:47:05.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiHnJW7+Tr9bKD83Hs6KstDxuhHMdiWTAJVTNk3ICHO2TyOhbn13S+sWmOp1D1wAhQ351ai9mQ/HWaa1bg+cgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9548



On 13/10/2022 1:55, Jakub Kicinski wrote:
> TLS tries to get away with using the TCP input queue directly.
> This does not work if there is duplicated data (multiple skbs
> holding bytes for the same seq number range due to retransmits).
> Check for this condition and fall back to copy mode, it should
> be rare.
> 
> Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/tls/tls_strp.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
> index 9b79e334dbd9..955ac3e0bf4d 100644
> --- a/net/tls/tls_strp.c
> +++ b/net/tls/tls_strp.c
> @@ -273,7 +273,7 @@ static int tls_strp_read_copyin(struct tls_strparser *strp)
>  	return desc.error;
>  }
>  
> -static int tls_strp_read_short(struct tls_strparser *strp)
> +static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
>  {
>  	struct skb_shared_info *shinfo;
>  	struct page *page;
> @@ -283,7 +283,7 @@ static int tls_strp_read_short(struct tls_strparser *strp)
>  	 * to read the data out. Otherwise the connection will stall.
>  	 * Without pressure threshold of INT_MAX will never be ready.
>  	 */
> -	if (likely(!tcp_epollin_ready(strp->sk, INT_MAX)))
> +	if (likely(qshort && !tcp_epollin_ready(strp->sk, INT_MAX)))
>  		return 0;
>  
>  	shinfo = skb_shinfo(strp->anchor);
> @@ -315,6 +315,27 @@ static int tls_strp_read_short(struct tls_strparser *strp)
>  	return 0;
>  }
>  
> +static bool tls_strp_check_no_dup(struct tls_strparser *strp)
> +{
> +	unsigned int len = strp->stm.offset + strp->stm.full_len;
> +	struct sk_buff *skb;
> +	u32 seq;
> +
> +	skb = skb_shinfo(strp->anchor)->frag_list;

Our regression tests identified a null pointer dereference in this line.
It has reproduced only once so far. Upon reviewing the code, I noticed
that the frag_list is assigned the next skb that TCP receives (in
tls_strp_load_anchor_with_queue()). This could explain why there is no
null check before accessing the frag_list.

I would like to confirm please that frag_list  == NULL is never expected
here (hence no need for a NULL check), i.e. the tls_strp anchor should
always have the frag_list at this point, and any frag_list == NULL is
considered a bug.

> +	seq = TCP_SKB_CB(skb)->seq;
> +
> +	while (skb->len < len) {
> +		seq += skb->len;
> +		len -= skb->len;
> +		skb = skb->next;
> +
> +		if (TCP_SKB_CB(skb)->seq != seq)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
>  {
>  	struct tcp_sock *tp = tcp_sk(strp->sk);
> @@ -373,7 +394,7 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
>  		return tls_strp_read_copyin(strp);
>  
>  	if (inq < strp->stm.full_len)
> -		return tls_strp_read_short(strp);
> +		return tls_strp_read_copy(strp, true);
>  
>  	if (!strp->stm.full_len) {
>  		tls_strp_load_anchor_with_queue(strp, inq);
> @@ -387,9 +408,12 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
>  		strp->stm.full_len = sz;
>  
>  		if (!strp->stm.full_len || inq < strp->stm.full_len)
> -			return tls_strp_read_short(strp);
> +			return tls_strp_read_copy(strp, true);
>  	}
>  
> +	if (!tls_strp_check_no_dup(strp))
> +		return tls_strp_read_copy(strp, false);
> +
>  	strp->msg_ready = 1;
>  	tls_rx_msg_ready(strp);
>  

Thank you
Shahar Shitrit

