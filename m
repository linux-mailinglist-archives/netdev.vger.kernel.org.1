Return-Path: <netdev+bounces-227698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EFCBB5973
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 01:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6895F3C7D05
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 23:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50052727FA;
	Thu,  2 Oct 2025 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="J8lMHf52"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022122.outbound.protection.outlook.com [40.107.209.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383D253B42;
	Thu,  2 Oct 2025 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447057; cv=fail; b=S189s5nSKo8SqZcaykN7dqrA9TRaRGTqMG3Chb9dGTkKkMRSm+ILfR0N4v40/Fn9NucXOT1ZYI5uVMMxUdflpyi2uFQ+OWWWBBbzCyeZZjLtPvGqNKCi1bgYKMocXZxyvjgX0TxX39bf4l9Oeh/NwPs8ha0jLQ8KsnI5gNX/zlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447057; c=relaxed/simple;
	bh=VpEDHjoKCTQ2XuQciYf2HAUwHU22Moa8lUqwtUOsmUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gNVdqoVMRlNey1MhknVCMF8R4cm79kDMEqc9v1hTxoNq6VS7ZCO8LMMEMebQhcw90+/mSkxWLFfseBr1SvmtawVWYGpfxGWQxusHJw2COsZF/eO+BkcUj7vAcCuBfvX3DxJ2hg0tEjI/LE13laUM17BXKnVsBtbT6cnbvGGsBkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=J8lMHf52 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.209.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbtkG0ddAgEy5aVIL25Rt8lSPyoRV4HaoH3if6N70rFJRDNwT24SLbISfHE8mHkhNKKGMvmZXaRcJkEsDhizTy1R+ovwh8JOFjian8phwZFTwRyUCcNFB8cXmM5cbrsoADO322ZMaz5cVqTgLo7J6hH//w+W7OX2ftii/3Lrmdu0Sy3FVB5gNkhN6tL39LXZBBC3IAp9145XzLgkNkvYpZWiW+37K5bOSH87vd5U1qW0zHy7evk6UF+ClaiWRCipRcsz66SjL1F3MfvQ0fd/cgYGF3hkl7/pWqnYFYwqtEz933cSGRWrt9Sh1qEbqBNJLqauhQIo53rji0cSVNQ/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G42P4TxtATkYwZm0nQX/z0e/gsIJR8AHxIOLqZ7p/BU=;
 b=mRjeap5v7W+bBe9qoNs6aX5XLui0Bin9KOtrdiXZy1vJV3lKR2J8/wMbGAtR2WsoW0F3tTJ3j6LbP/DkF/B9PRijMGl4TbKNdTmEVxZ0hRGlbA9MUeESPQIXEwFgxQ0VJgZwphJFNMQZcvz6Wj0QGCH+j/tvNkR70FP14Gb2ItAxgWt/ouKzi9olG6IPeyqwVE/m8yns0G6Byld7m+/UvGO9Vw5kx0CkLEUlpRpUteFMKhQC/C1Nv7VI11HvuF52/p5bJySQIljmcoDYh6Fm+x9b2sic0qmJ2ke/feWpf21fOX98Vp7SIabUwETd1En2N856HBMHE4vMTNEMkDwqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G42P4TxtATkYwZm0nQX/z0e/gsIJR8AHxIOLqZ7p/BU=;
 b=J8lMHf52g4AuftCAwaBCLKAU0XKBn8E24SOwVX+0HPSL3z4Gi4IOAElDanTT/k7Pwzv1jC9LRUhBTWSY2k4GGH4zug3wIgjUxjLVVurm/Hh1FtIaqdnsp9hcslgiudrYOYvrQsb0ejlTlBo6sTW2gaE/gXahjUus/vytJTkcbDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH7PR01MB7978.prod.exchangelabs.com (2603:10b6:510:268::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Thu, 2 Oct 2025 23:17:29 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 23:17:29 +0000
Message-ID: <3c3d61f2-a754-4a44-a04d-54167b313aec@amperemail.onmicrosoft.com>
Date: Thu, 2 Oct 2025 19:17:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 Adam Young <admiyo@os.amperecomputing.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
 <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com>
 <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>
 <CABb+yY1w-e3+s6WT2b7Ro9x9mUbtMajQOL0-Q+EHvAYAttmyaA@mail.gmail.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <CABb+yY1w-e3+s6WT2b7Ro9x9mUbtMajQOL0-Q+EHvAYAttmyaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::16) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH7PR01MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f46a28f-ce56-4a86-3925-08de0209db6c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUx2TnRiZXM1SzVTL1pZRWNEc2pmUlhqMXZ2aXhHSElBT2k0VUQ5ZzBQYVRI?=
 =?utf-8?B?anhjamNUMW9FejZFV3hrMnZqQkxBUkJKaHBkQUtpSHM2Yzk0aFhUaFp2WCsx?=
 =?utf-8?B?ZWRhUkZLS2x3dS9ZdUZpNk9jam5KbloxUlJaVDBlMDlTeVFubUlJYUdNNys4?=
 =?utf-8?B?NmZaNVZ2T0REUm5scTNBWEtXbk5uY2pqZ0ZRcDRzaG9LczFjT2R6QXkxdnZN?=
 =?utf-8?B?SG96YlZyWXIzZE1vYUtncEtTTjRvdWJsVjFDZ0NEVWlHQzh2Qy9tTnJOQlhV?=
 =?utf-8?B?UFFRb1V1Z1o0SG44MjlZYkVBSEw0QUxiQURIT3NMTlN4OW9nYVJHcWJMQ0F2?=
 =?utf-8?B?MngyV3hhTXVkTHFmUGN2R1ZjWUVROTlqUEtmTkRvU2pBR09iVTlSZlJLdWx2?=
 =?utf-8?B?NE9BQldNdTVPaTcybkNiQ085bjdSMXdEQnRpQmszWmRjZVJqOG1KcjBYdTRU?=
 =?utf-8?B?VWFGdmRvbG9sbFVveWEyb3JDQjVDWjJFd3hMVDdRdHBwTUVBbVRUWlYwZExr?=
 =?utf-8?B?TGhrdTQ0cFZDMkwwUGZnRTZwZTM1R21qUExsSWlhVmFRbEtQNGhaeDRlNGVr?=
 =?utf-8?B?QWt1VHB1blVEWUk4NHJnYU9DODZqYTRnTys0RlVjSWlVUTcrUWZvY1BNNXJF?=
 =?utf-8?B?bkdCdWprT3hNejdMWmlVaUMwNGtVRk8zcExGdVNJR1ZlMktTWVdTTXJDWDRW?=
 =?utf-8?B?SjQ5aUprcG1qQVE0bUVvZlVkQTczR25EVW56WjN2SDA1SGRja2hFQlVvZjlo?=
 =?utf-8?B?d3ZwZ1ZwM2xPQ2UvYzVYMU13d3VJbUhaM1diUi84Zjk1Mitob2FBQ0p5UjJs?=
 =?utf-8?B?RUlKaFBTWGpvOGlZRXVlMjl3YWZqNFZUMnNqNk5QYVVHSHFHcEFJYWhnc3Uz?=
 =?utf-8?B?dDBtd2tmLzdPcnVzMHc2dlppeTh1MXVxN2NpVXhhV3VtT0djT3J2VFFma2R0?=
 =?utf-8?B?bUJWWk13cHJWMmtSQ203UkEzS3VodFU1WWpvUDI3WHQ2emdlU25tT1g1V2Vq?=
 =?utf-8?B?bjdBb2Y1ZzgzMC9zS3ZTenp2MHFaNkFLS0lkd2JBbEtxU3czMWE1OW5QQ1N0?=
 =?utf-8?B?eXl5ZDVYOGttay9EZXZ2SHV3ZjhVV0ZTN1RYR0F1alhrQ0NuU1NQT3pxWEFw?=
 =?utf-8?B?NktCbmVCdjBQODF4QjVrcE1wUGgyRlVDVU8vR3JmYmNteHo1UnB6cXdVMTZx?=
 =?utf-8?B?OE83RWk2dEJNZVNUeU96WmYzbUxxbnVvQkxGNEpzVzdUcTBzcEVUZ0cvdUhO?=
 =?utf-8?B?cjB6RzRScC9CbGxCeEc4aGpwdXpycjJuTW84VDRDeGNQQlVoOEN0VE9EUmxr?=
 =?utf-8?B?T3JjT3laYXM4amNxalAwcnFPaU5iSnVoS0RIcHRhTEEwRlhiUlRFbFF1RXJk?=
 =?utf-8?B?bmR6VUs0ZmdlbTRoYnoySytWcHg3RVIybnlwOStYVlFzaG8xM1NDcm40ZVJu?=
 =?utf-8?B?WVczOWlDbFQxQm9DbTJ6REtBa1FmTjU3TkdZdVVlR2J0ZmUxMHlrOHY0Wi9p?=
 =?utf-8?B?OFUvdzlOazMzcE1DajFuNEZDS3FRZ2Jhek9pTWRWd0ZPaUlRNittVW9qeUNT?=
 =?utf-8?B?OFVKTVFaR0RJSk9QaER4YW5JYWI0VDFtc2x3aHN6bHF2MHVaQnRYcEhXNXNK?=
 =?utf-8?B?azhHMlhSblNPcnNXdGVPTnFnV0VWcE9mSTJuZ242dFY3MnVmMHdqZ3lvREFq?=
 =?utf-8?B?MFFSTDhacVRGUEFEWXpiWjkwcW5KQTNsRVNvemdxZXFhYXR1RFZYY2hFMzRz?=
 =?utf-8?B?azI2TTVubmoxMTFmeEh0QVp3MlRpSS9Jd04yaWFQYzRCU1FMTEw4c1BBYUJU?=
 =?utf-8?B?WmpldU5wYy9ORnhNMld2WWptZnpOZ3A2VUw2QWo3eDFjY0tsQUR2S2VReWs4?=
 =?utf-8?B?dGMyK20xdnF2bGdPRE80QW1VdW41aVNLYkIxa0tjRGtyc0F6SG4rN0ZrMGhi?=
 =?utf-8?Q?cO1oEte+oKUKrDRdwcZNCzYfG+eKC8zv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlNSc2Vmb29LaUZ1dnJNL29SQkRucnljSkdKdkpFZTl2c3htYkQrb3Y2Q0M0?=
 =?utf-8?B?WktjcEU2ZUVveVJTM3g4cWZ3VEMrQkZSTkpiMkpEY1F0RW5FN0VzZ1Y4UEZo?=
 =?utf-8?B?Rm1FM2NBL21ITFRMbkVockliYlV2K1c0dUNDai8rak5ta24ydXBnaXI1cGFs?=
 =?utf-8?B?UVNqbDhEekZBQVdIS0JybTNhZHZhcXNQN2JMWGw1bHNMU0tjNmdTTDNEQndL?=
 =?utf-8?B?cVFTM2puT2w2TURaU1AxTVlFM0s2YUNjZXFkR1RYM0ZEWlQ3cUYzYjNIUis2?=
 =?utf-8?B?RzJrN2tVTDlsdDU1TVBTL1k1VzJ3b01IU2ZkaW1WVVlBcU1OazllOVRvMzdZ?=
 =?utf-8?B?Tyt1N21sdDhlQ29jWFBjb1YzTnEvQkVvWVk1bU9Fdzk2TGE0R1VPSFY0bjRy?=
 =?utf-8?B?andZb0VGNXRyODB4UG9SaUNQUm9heGYrM2dOZjBUS2YrSC9DWmpDWGpxcmhU?=
 =?utf-8?B?VWEwOTAwc3EraTZHaE1qcFpMTEkxcm0rakF6UlhqVzhZSFJtcFdxN0s5Z3Uy?=
 =?utf-8?B?dDNJWTlKVzF4c2kxMW9yb3dYVUpudVZtMnVpTyt0WXlqR2hmYndXZUJhQkMr?=
 =?utf-8?B?SVFFU1lGZTBqVm9IdUx4YjAzc2FWSWxtVU1ETVo5aWFnSThOUGJvOHBGcXE1?=
 =?utf-8?B?WG00Q2RJNVdVOEJjNHp4ZERlcWZmcjhuSWNBUXdVVzdyQzZLNytOa2xTbkJh?=
 =?utf-8?B?dVMyeUxuby8wWElndDBXRzY1NHU1V01YVmdSajI3NzQ5WG05cTFEUWRwNDZB?=
 =?utf-8?B?ZTZWTkFvYUxjSUxwVUh5cWtQZTlCTjdsbEtzcExtRFl0dVN1RlNUZDNSNVRz?=
 =?utf-8?B?MGFFV2FCcXN2WDYxMWp5czVieldPQlF1OFdyRGtpaitaM0VVczBsQktRMkQx?=
 =?utf-8?B?cjNUSEtHWmE2cnBmZEZkVTZpL0ZvcnlycUlpbkFtRVFCMzNSZnZNb3NNV2Ra?=
 =?utf-8?B?T1pWcXh2RExwS1liSWwxQ01zYlJVbHlWa0xWb2xpeVlCUGNZQnRWVzdTeWh0?=
 =?utf-8?B?YnlOY0h0UDlXQlJNcXdZUWdnYk1jN25HY2R6Mk5BTUE4L2xZdEY3ME5hOWhG?=
 =?utf-8?B?NUR5OE9rYi9MRlhuSCthNWhGNEhwdTY5WWFmZ1BTeldoMnpONkxESmZMcVdT?=
 =?utf-8?B?bzdLRnBYSU5ZaWtaSkR1S2tmcmhKNUEvalNBVWhDYW1GUlZPQlFGL29JbjlS?=
 =?utf-8?B?Z2xUS0kwNy94d0ptcVkvT0d2cEtTZEVBTlhkYllFZ0NnQXZuQ0J2REQ5eHBj?=
 =?utf-8?B?ZTVsdlRSQWNETDk4YjAwZldDcGpNUnJZMEpiai9Razd2dVhwMjNhWWN5VGpE?=
 =?utf-8?B?NTFiSVpOVGJiMFJGVFMrWlVXMFRyVTRQejhvUEZpenJLNmtTVnB5U2w3aElR?=
 =?utf-8?B?RFQ4eWR4Rm5MKzdKemFqUldINEZVbGx1eDFxSE5FTG5CbitnTXFpME1kT3lt?=
 =?utf-8?B?cEZwTkxZK0QyQXNhQkNwdHdnMEM3RFAxbjdxN1diTGVQd0YwNXFaazkvOU5H?=
 =?utf-8?B?QnZXcEIzakhubi9BZkdpWnRKT2l4VVNOTDVxdWRtZTJaS1ZYMUx0cmRJMmRP?=
 =?utf-8?B?V2xzWExHaHVsMWF6MXd3UVk3UjM0bm0vbHdhWXBCTzRsamcyaStnN1RtT1d3?=
 =?utf-8?B?WG9hTjJhK3V1ZWxtOSt5M21VUUppaWF0L2djSSt4aXg2UVc1U3dIUVJGNisy?=
 =?utf-8?B?RGNEeDE5VkpLMU5iL3grakVZdi9NRHhLWUpUL1ZoR2JEQ2p4dlJTbTlsM08x?=
 =?utf-8?B?WERhZ1hVWlprVGREWEhSbVFmUC9tdEFna2ZpUzlPOVc0ZzRjT0dMMXFrS0N2?=
 =?utf-8?B?ZFc3OXlyOThVSWJCcVExK0lrMHhWQ2pKUVZvMzJPTlJST3duS3FkSHZncHBJ?=
 =?utf-8?B?VldyMCtiVUp0anZqczAvdGZLSTdtZ2c3eG5DUWtyd3Z5eVdnWEVSaG00S0JU?=
 =?utf-8?B?cDRNdnlUQnRvZmpuZEhvdDJOVU9Ed2MyRjNXU0J6MVRoK21xYVlJL2tFcXBI?=
 =?utf-8?B?OGNaa2NHVkFDamJocktoVnVIUXJqVFB4SEdiOGs4elEyai9oN1lIdmFKeGZM?=
 =?utf-8?B?RkJUM3BEQmtacWZwTUI0YnY5bDg3ZU5FWW9WT01PQm94SWxoS3FHT1Zpekp5?=
 =?utf-8?B?TkxUNHRwZ1UybVc5Y1JzczB6NmcxcWNHdFlkUk5VQStKNXNVeXJLSHhjV3NP?=
 =?utf-8?B?YXBNTlNHdWU5SHRQRkZwWndNUkRZYWl1UDJjb1NaMjcyUnJYL1gwbVVibjF0?=
 =?utf-8?Q?I5Ec4uKgvAetO47PAPnI+p/IMZo8WHoTm3z52ZjO7g=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f46a28f-ce56-4a86-3925-08de0209db6c
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 23:17:29.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiSRajtuMziABT941vo4YFwoj+4okskhn3hDXR1wLg3CHY+KmfSUhRr805MzlTTIp1pNla/Y9e9GNwE7Riu1z8fzsCRW0Uq2P6Y/jqKCeP+xwvCqLY58yR93sKtoxfqO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7978


On 10/1/25 16:32, Jassi Brar wrote:
> On Wed, Oct 1, 2025 at 12:25 AM Adam Young
> <admiyo@amperemail.onmicrosoft.com> wrote:
>>
>> On 9/29/25 20:19, Jassi Brar wrote:
>>> On Mon, Sep 29, 2025 at 12:11 PM Adam Young
>>> <admiyo@amperemail.onmicrosoft.com> wrote:
>>>> I posted a patch that addresses a few of these issues.  Here is a top
>>>> level description of the isse
>>>>
>>>>
>>>> The correct way to use the mailbox API would be to allocate a buffer for
>>>> the message,write the message to that buffer, and pass it in to
>>>> mbox_send_message.  The abstraction is designed to then provide
>>>> sequential access to the shared resource in order to send the messages
>>>> in order.  The existing PCC Mailbox implementation violated this
>>>> abstraction.  It requires each individual driver re-implement all of the
>>>> sequential ordering to access the shared buffer.
>>>>
>>>> Why? Because they are all type 2 drivers, and the shared buffer is
>>>> 64bits in length:  32bits for signature, 16 bits for command, 16 bits
>>>> for status.  It would be execessive to kmalloc a buffer of this size.
>>>>
>>>> This shows the shortcoming of the mailbox API.  The mailbox API assumes
>>>> that there is a large enough buffer passed in to only provide a void *
>>>> pointer to the message.  Since the value is small enough to fit into a
>>>> single register, it the mailbox abstraction could provide an
>>>> implementation that stored a union of a void * and word.
>>>>
>>> Mailbox api does not make assumptions about the format of message
>>> hence it simply asks for void*.
>>> Probably I don't understand your requirement, but why can't you pass the pointer
>>> to the 'word' you want to use otherwise?
>>>
>> The mbox_send_message call will then take the pointer value that you
>> give it and put it in a ring buffer.  The function then returns, and the
>> value may be popped off the stack before the message is actually sent.
>> In practice we don't see this because much of the code that calls it is
>> blocking code, so the value stays on the stack until it is read.  Or, in
>> the case of the PCC mailbox, the value is never read or used.  But, as
>> the API is designed, the memory passed into to the function should
>> expect to live longer than the function call, and should not be
>> allocated on the stack.
>>
> Mailbox api doesn't dictate the message format, so it simply accepts the message
> pointer from the client and passes that to the controller driver. The
> message, pointed
> to by the submitted pointer, should be available to the controller
> driver until transmitted.
> So yes, the message should be allocated either not on stack or, if on stack, not
> popped until tx_done. You see it as a "shortcoming" because your
> message is simply
> a word that you want to submit and be done with.

Yes.  There seems to be little value in doing a kmalloc for a single 
word, but without that, the pointer needs to point to memory that lives 
until the mailbox API is done with it, and that forces it to be a 
blocking call.

This is a  real shortcoming, as it means the that the driver must 
completely deal with one message before the next one comes in, forcing 
it to implement its own locking, and reducing the benefit of  the 
Mailbox API.  the CPPC code in particular suffers from the  need to keep 
track if reads and writes are  interleaved: this is where an API like 
Mailbox should provide a big benefit.

If the mailbox API could  deal with single words of data (whatever fits 
in a register) you could instead store that value in the ring buffer, 
and then the mailbox API could be fire-and-forget for small messages.

I was able to get a prototype working that casts the  uint64 to void * 
before calling mbox_send_message, and casts the  void * mssg to uint64 
inside a modified  send_data function.  This is kinda gross, but it does 
work. Nothing checks if these are valid pointers.

One way to make it clear is to modify the Mailbox API is to provide an 
additional function:

int mbox_send_int_message(struct mbox_chan *chan, int mssg);

And modify the ring buffer to store this value. Convert the field in the 
channel from

void *msg_data[MBOX_TX_QUEUE_LEN];

To a union.

union message_data {
int int_data;
void * message;

}

union message_data msg_data[MBOX_TX_QUEUE_LEN];

Or even a structure that includes a type field to know which it stores:

struct message_data {
int message_type; /*int or void **/
union data{
int int_data;
void * message;
}

The message_type field would be set to MBOX_INT 
for mbox_send_int_message and MBOX_VOID for mbox_send_message



