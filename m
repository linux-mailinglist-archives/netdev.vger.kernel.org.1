Return-Path: <netdev+bounces-144533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671019C7B6D
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86FE1F22115
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDB22038B1;
	Wed, 13 Nov 2024 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="sPIcrq90"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022084.outbound.protection.outlook.com [40.93.200.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A371E0B7C;
	Wed, 13 Nov 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523318; cv=fail; b=VFZ0J0su92EK12Tmq7fpDKHmDdfox4m2YwEbXTEicWqoqT22sfATBX6hCbtbmcA5i4htGx0BUYuohRcdSOIo9KSk6eO6QXO6CKdTSMDG8dY3q1yyftHhJV8/p1suRcez5Fd2V04880HXRsG3JvlJU0dyTAnipg16Lg/LdLApELk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523318; c=relaxed/simple;
	bh=h+4LNdG9HZ/nYdg1OJon6LB7TG30TDAc6QB9IrOy/nw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O1o8Ue5e/wtJUQUv6QNw3iuevY09iD96Ps93hFHnCEwSyqrSHkLVZZKtAeniDzvbm/I6kHoIf4B3gCOHIU1fxLYNYJTFi8KYQS5269fp32n7qyQILkhe3B4229pzfpMJsPvpLDG+yyek7iouil2WaKna7jGGxy095kVOdmNZMSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=sPIcrq90 reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.200.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yent3uM/bnP56UU6I4SV17F39QJfv02vfLT/00OYsKY3mUSUYRhXcYaDEQeeNXDZD5YFfD+5ay8K18MW+R3wKX3XcyWcoAehgNNoO4KwS/lLzxFZPFihfE/OmOB3Lq8QBEANHXTqOaQz5qF89qoRttyp4fwMizJT7+Rl+opHc9QcDzqIq66oXDdo+PRZ6nqwJu4ld2/gJfacrvNxgowGtKmT0Xp9egembdJBI8pHjDnnOk2xbRtXL36CuuYoYtMm71QoeqbAAJG27tZzPGxKm8TqOog64uhEAFyzXszx2n6xxauLl8BWRT5VcOPFZ4XZ8WroudEtR2WD8FPMB6yLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WEQCMfbkKzaRffni97wluFPiKJmte2+XOBXFa4Mjpg=;
 b=MFoNPRKwdTFbArHN7yYqRMjvp5ebm33FssdUOzxNd/Muo9/bui/j8DD/Ny8GgriJN2SLLlg4V4eBMLddpzpuyOEoc6z/g8rGNVJtgEed7J3C4ixeO3OWhW1XX4jPq5Bw2GYPhqNyYEohV/02TPO+8Sir2BjVm9uM0/t6AgDPYQdkSjMU7eGas6JqN7mOx3WOr/n0i+T5/ZGJBs5AWpvHlkHWdhvFkAddAP0BmruMiKTd5bKAufgQz5+Ae7i9dCGFROBW/Af91UFjeKk8VIU6rvvPHAcgNnBorFq41wX9jukNQ6+IItZwsFUej2xy65psumakvcTQKcCVdLxk+ZVkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WEQCMfbkKzaRffni97wluFPiKJmte2+XOBXFa4Mjpg=;
 b=sPIcrq9025rSfCjM4DCqEStcCYTlHgG/6vmetudtIgBKyb87IIvbzwinhW8pY4b+ZD3PfyvfQIogBoQdnPzVzM7hD1IP+sCPQE3W1zL6Sbp7fTMNCQRkVSAJ6RjiaXCgt4dTiQb2I4jIhxaO+k1OHt9hEU8PT78GtDsL/YDWS4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SA6PR01MB9022.prod.exchangelabs.com (2603:10b6:806:42b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.16; Wed, 13 Nov 2024 18:41:54 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 18:41:53 +0000
Message-ID: <7c1de9a0-9d82-4369-bdb1-63c110d81194@amperemail.onmicrosoft.com>
Date: Wed, 13 Nov 2024 13:41:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
 <20241029165414.58746-3-admiyo@os.amperecomputing.com>
 <b614c56f007b2669f1a23bfe8a8bc6c273f81bba.camel@codeconstruct.com.au>
 <3e68ad61-8b21-4d15-bc4c-412dd2c7b53d@amperemail.onmicrosoft.com>
 <675c2760e1ed64ee8e8bcd82c74af764d48fea6c.camel@codeconstruct.com.au>
 <c69f83fa-a4e2-48fc-8c1a-553724828d70@amperemail.onmicrosoft.com>
 <f4e3ff994fe28bb2645b5fddf1850f8fcc5d1f89.camel@codeconstruct.com.au>
 <3224c94c-e4c0-43f0-9d1f-c68d98594932@amperemail.onmicrosoft.com>
 <a4cf6516df6a7db734898a45907ff6f545acfd17.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <a4cf6516df6a7db734898a45907ff6f545acfd17.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:a03:117::25) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SA6PR01MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f8d8db-e77a-47a4-5c6b-08dd0412d7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWtiZWoySnNtY00xSDF3TEtHcU9JNVdMdE1EVmFQTTlNTVFmS3kwRElQU3lF?=
 =?utf-8?B?ckdNWHFWdVY3eTRHZTc4VWdYYTVHVkpTZTROamNrVFB2RFVPUkhWS1ZmZ2JJ?=
 =?utf-8?B?VG5oWTVSenZIeTFoK3ZYTUpualg2YkJjc0QyK1BWeVViOWR5NHcvZGt4U1Jv?=
 =?utf-8?B?T29GbDdwU3ZLUVArOUhhSnVXM1BYc2c4S2RQdE1UMHBaTHVtUmVnakxYdlpw?=
 =?utf-8?B?di9ja2dtcTlYOWw2RUhuMmZOOENVbDYzcDFMM2ZuQm9YbG9yZGtBTnRjTGtE?=
 =?utf-8?B?YTBQcXVJbFloTnJnNmNyUHFyN21NU0x2WTFqcmlwdUtkOUlYRysxWnBuNzRr?=
 =?utf-8?B?cXZJaGl3L2Nzb0hVaWZhTEc3bmt1c1lqQS9kL29KNmFGYVJ2VlBOd1lQaWZ1?=
 =?utf-8?B?SUlmUGl0VCtuTWthYldsdEtVbm5uWnRUREJWQld2WW9SK0RjWDVkQzJqejhE?=
 =?utf-8?B?TDV1NnRkd1RobUp1aVRqNTd6bElCa2hJa1FmdjJ5R0srLzNNVXVMSFZiTGxn?=
 =?utf-8?B?Y2JDZXhBU2xyai9US1dSU3hLcmdxMnhma0hkck8zSGxiU3JuYlJmMVpyQVJy?=
 =?utf-8?B?Y2ZWMWNEY3dtR3NuNGY3QmdLdVBncmkrWkR2ZWdiUDExNWx5WWRieE12MFN4?=
 =?utf-8?B?OXBhTjRzZ1Jpc1R5NnZveUppMXh6eUlueHBVZlB3emdXR2ZUbDNPZGY4U05o?=
 =?utf-8?B?c2ZQNjNaTFBIaXZQcXM0S1B0STB2Q0tkaFhyUUZQaW04UUVVbVVKNnpSYmpW?=
 =?utf-8?B?cUY2bndoKzJPZ0ZyTEhpWGlxU3liWTc2TWh2YURuQldWYlpNK1NkUHpKaVRG?=
 =?utf-8?B?ZGhiUFpIVWhhNVJKa1lYVm0yeS83OVlrOXNZSm9zUjJGcWxPcW9CaHpsOW5D?=
 =?utf-8?B?L2ZPVzJQd2REa0RXZ2lZQldIVDR6SHM1VVNJY1VjRG1nNmJMOTBMUDRxUkNx?=
 =?utf-8?B?REZVZThmV0Jpa3E1T2RkMWVzRWlac3BOSWRtd2RHamFaZWZldHNVYTBEYTVu?=
 =?utf-8?B?ODIxSm5BNis3K3krYjZpQ1RHZzh3c1VrYnhvOWd4R1FSb21FdmhjeGljTEdL?=
 =?utf-8?B?TDNBL2RVd1oreWYwU284dzEvdzBnQkJYbUUvZFgrQ1oxQURrNVBnWWZSMVN2?=
 =?utf-8?B?aUtzN3dtK0pEQVIwdWRPTDQrL0VXUGJLWXVDNEo3bzR0Mk9VbW1WVnhSMTRK?=
 =?utf-8?B?bWlseEFsUnZtU1ZrMDl5VEE2WEV4bVBMS3FRUm5MSmZtelgycHlSSTdqbWZI?=
 =?utf-8?B?V21sQXJWOVNha1dZa1VWRkN6ZnJITEFPMXJuRHk2akg2RjZnK0YvUzRlLzZU?=
 =?utf-8?B?eVZSQVdXaDhaMUZsY2ZmTDFFaFJ0dU1xUEhkSGIvaFFWZ20zVlRaciswT2pV?=
 =?utf-8?B?Y05ZbTl3Y2Nrb0pQeWp0N01wSG54QTNubS9WQ2ROdTJ4Um5YWlBzS0xiNG9a?=
 =?utf-8?B?eXd2REJEY1U2cUVRSGZUWElWWHdXTVFPRkZ2dWVqRlRDNzk1emdQSE02NWFW?=
 =?utf-8?B?TDJHb3pKQzNkVjl2VVN0eUpxQ1N2NEJLK2V5NVJOeHRkd05mWUUvWG11TkJh?=
 =?utf-8?B?dGY5L3p5OGVyR0VWOXFpSURweUdsM0ZQbEt6aCtCM1Q4RS9uOGkwNStYcTBJ?=
 =?utf-8?B?bUJJbWc2VE9aNXd1SHRMWE1GNFJCOEJ3cFowQnZlZVQ0VGVNcDZEUnBzU2Z1?=
 =?utf-8?B?TUYvSzgrQi82L0ZXU0txdnEyZTQwWUNYaHdyTnFIZWFXZUFQMDRjbEY2MUxj?=
 =?utf-8?Q?XE5tneaI6mQ/TN9ptoWF2cSnJrzKtvF8KKK+HlF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTV4UHZBbXR1anpPdHdJRTZsaURCamFlSk1OWXNsTmswY0hQMTg1dDNzL2Ez?=
 =?utf-8?B?SEUxT0xFY2t4VWZNTTVteUdTWUt3b2s2K1ZpT1JOZ29uV1ZkaGdGd05kMGcw?=
 =?utf-8?B?WFMxakc5a2QvZ1FXb3lVV1dnNitjaGxhSXRGL2dpa2FVeHIwVHEvVXBlVHNk?=
 =?utf-8?B?NlNrNnQyM3lpeEFlUElHZU14YXN5MU5XeW45WVdmdEhzaU1QMFV5Z01ENCt6?=
 =?utf-8?B?OVNyUUxRMzRwUk15UFhadjBzYnZoSzBNTlZ4YkpuYjhZeDBObXpnRngzRUli?=
 =?utf-8?B?QldjQkk3VStEU0prWWQxdWRZVlpPUVpVeitPSVJobklkNHE4enp5VVZuTUdq?=
 =?utf-8?B?ak5vLzVBam5QVFhiWUd4WERWVXlhc2xhZVcxbXFXdTZSU3BvUkVQL2FiKzR1?=
 =?utf-8?B?TWpEdGg2Qk1NOUthQVRYTEVuQ05CYzBXNnRvL2VmNzJUU1FWS1JnRTVMLzdj?=
 =?utf-8?B?cmk1eFJaMHlDckdOMG1oeW9iWnpLc0NzTklZQkh1cHhLMFlzRDB1RXFUNUt0?=
 =?utf-8?B?dGtEMmpaS1JHcWV1VnU0dVFZdTNwN3BHUDhoNnJmN2NNQW9DMlJSYVJkTU1j?=
 =?utf-8?B?ay9LM2dnWWVCV1RSUTVJM0tsWnVXOVAzU2FWL0dhZjRPalhmUmNNdy9velV2?=
 =?utf-8?B?dmlYcStDVmE2MVE0aDFBeG1wM2RRZ0k5VGVoMTB1WUVjaFhmVDdhZ0psUjhn?=
 =?utf-8?B?TG1QOW8ycWFVZjk2c1BudmlkWnZkelMzQkxKVEVmeXlQY0RkdUI0WCtyUkVp?=
 =?utf-8?B?Rlk1Z1RleXdUTm5JL1FsMm1LbmJpdGhhcEdqNU93ME5oZVBCdGJxK3Y3SVNF?=
 =?utf-8?B?WGQydjJmc1pjVFk0QklNMlVmSjVoRXJVOWFGdTJCNUFmaHZtM3hlQW8xaklC?=
 =?utf-8?B?VVRaTzllODh2bTRFUkY1UG5FWEgyT1g0Y09lS2FZN0M5aVVRREZYNlpZZktp?=
 =?utf-8?B?U3M3MlhTMFcrb01DM3crem1rYXBBM283OGwxT3RHVmdTN2JUVW5tRXR5ZGNG?=
 =?utf-8?B?MU43dmZOc1FqQUd2SE5YU09haXJxWVBsNWlDSzhNQkhZK1NPUjE1bkhzV2lM?=
 =?utf-8?B?WFQ5YWFjMDJ2Y2t1WVd3S29yMEZEcHhlN0lBT3E3Tm5nNG9QcE1kakNNNFNT?=
 =?utf-8?B?NnRlNTBBSU04Sk5iVHMrSXZOcFA3dXNlM21sTHZDdk8yWUhSdmJMVCt2UTBJ?=
 =?utf-8?B?dmI4WURMS1ZueDluS3Nab2YvRXd4Z2orQXozNzdhcE1KeFVHcmxRQWpnUnRB?=
 =?utf-8?B?SU41OGVuWVNjRDVJeXNvQ1dlMmdia3ZBeTEzQ0ZsZmZTb0pxZFNGQnpBMFhn?=
 =?utf-8?B?RVlZU0dUSmlCVFhyMnovZ2loOEg5MkJqZEFoSVBSWmY2YjlKWkFmdFpQVmZI?=
 =?utf-8?B?ZzZqeE8wcjA4Y0JRL2RaYUpIZU5CalJueERyVXhMUGp2WkU3aHJCQU1wNEJB?=
 =?utf-8?B?UmlpakM3Yk11Y043ejd4QnlaYVlRVWJUZ0R3THVObDY2MlB1MUlOcjhtNDM4?=
 =?utf-8?B?anhpbVBUZFhmQWlBTHZrMDFxY1hCZ0l0RFdzK0ZwMk4zV2YzM25nNE1GVzdz?=
 =?utf-8?B?bFB4T1FMd3NUVEZwbWpQTGREbEJNd21KRE1qenJQTno4N1gzN1Mrd1hubUs1?=
 =?utf-8?B?c1piYlUxcVVkZVNFd1dJMk1sdHJORHAwbzA1Q0psbDNLbWR4dS9HRkFoMnJw?=
 =?utf-8?B?c2xyUjdTNWtOQk8xRTBqN1Fpbm5qU2xjMVhxNjNabG1DS0RYUmd3WDVsYkt3?=
 =?utf-8?B?b1E5a016Mk5lVWNsWGVXN1psb2FXKzZQdUlaVG53QXc4SlVSbzRIREh6Vm1t?=
 =?utf-8?B?WXhaWS9LT01pNlg2TEg2dCsvZFBsU3J1dld4amRJTGdXaUhCWXpQVUxNNVMv?=
 =?utf-8?B?aTdTc1huRy84d1lYai9XVHVGUVFNMVlVNllyMXluYy9US1Z6amVzUVQycG05?=
 =?utf-8?B?WUNXSjhtS0NJeWQrSmdySHRUZmV1UWRELzVSSmNkcEtMS0x5S3JuOUFKWUla?=
 =?utf-8?B?bUtGbW5tVXNpeUdoQTNXb213bWlBbkFCTXFQQlFGQkprb2xYTG9BZEdzMmRU?=
 =?utf-8?B?TFl6cDhpT3J3ckpvS1RqNTBuVTM2TjdhQ0pvdkxkVlhSTXltcUczaHZScjRa?=
 =?utf-8?B?T2gzTmI3WDdqS2tIdDRxZ2VPV05SZXJFbEE4SXg5ekI3c1gzbGVScDdrUDhN?=
 =?utf-8?B?T0RQdlk2VjFZek5XRUt0eFNTeExFc05GNzIraW1YZG14c2M5VGpudzcySWJk?=
 =?utf-8?Q?eTAcNcnxQN1FKHr6ADAPwJzRn1NJnvMJDWg4RWm+JA=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f8d8db-e77a-47a4-5c6b-08dd0412d7f0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:41:53.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAYWzWIzAqvk7cZteMUKYdDT93pkw2p1Rq88G39vbvE/n9MynX8SRZgnLFsumTQr24UWetA3xVmwxf/ipFyg252Zi9wJWchARIc/APhDdC0LuPzwvRxXzxVLa+fzR9YQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB9022


On 11/11/24 20:00, Jeremy Kerr wrote:
> [EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
>
>
> Hi Adam,
>> "The PCC signature. The signature of a subspace is computed by a
>> bitwise-or of the value 0x50434300 with the subspace ID. For example,
>> subspace 3 has the signature 0x50434303."
>>
>> This could be used, but the inclusion of the "PCC" is unnecessary, as
>> it is on every packet.  Thus only the subspace ID is relevant. This
>> is the  index of the  entry in the PCCT, and is what I have been
>> calling the  outbox ID. Thus it is half of the address that I am
>> proposing.
> But the signature value isn't implementing any MCTP-bus addressing
> functionality, right? It's a fixed value that has to be set the same
> way on all transactions using that PCC channel.
>
> Just to walk it back a bit, we have two possible interpretations here:
>
>   1) that the channel indexes *do* form something like a physical
>      addressing mechanism; when packets are sent over a channel to a
>      remote endpoint, we need to add a specific channel identifier.
>
>   2) that the channel indices are more of an internal detail of the
>      transport mechanism: they're identifying channels, not MCTP
>      endpoints (kinda like setting the PCIe target address when
>      transmitting a network packet, perhaps?)
>
> If we adopt the (1) approach, we'd want a hardware address to represent
> the mechanism for addressing an MCTP endpoint, not an interface
> instance. That would end up with something along the lines of:
>
>   - MCTP-over-PCC hardware addresses would be a single byte (to contain a
>     channel ID)
>
>   - the interface would have a hardware address of just the inbox ID:
>     incoming packets are received via the inbox to the local interface,
>     and so are "addressed" to that inbox ID
>
>   - remote endpoints would be represented by a hardware address of just
>     the outbox ID: outgoing packets are sent via the outbox to the remote
>     endpoint, so are "addressed" to that outbox ID
>
> ... but that doesn't seem to be the approach you want to take here, as
> it doesn't match your requirements for an interface lladdr (also,
> implementing the neighbour-handling infrastructure for that would seem
> to be overkill for a strictly peer-to-peer link type).
>
> So a couple of queries to get us to a decision:
>
> Your goal with exposing the channel numbers is more to choose the
> correct *local* interface to use on a system, right? Can you elaborate
> on your objections for using something like sysfs attributes for that?
>
> Can you outline the intended usage of the spec updates that would add
> the address format you mentioned? Is there a use-case we need to
> consider for those?

On consideration that the spec is still closed, and may change between 
now and when it is published, I am going to pull out the hardware 
address from this patch.  Once we have a public spec, we can implement 
it without fear of breaking userland.




>
> Cheers,
>
>
> Jeremy

