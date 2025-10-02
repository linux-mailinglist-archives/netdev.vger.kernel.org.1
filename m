Return-Path: <netdev+bounces-227697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 895F9BB5949
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 01:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25C184E3C0E
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 23:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E77D136658;
	Thu,  2 Oct 2025 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="ZcV6VIB5"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020113.outbound.protection.outlook.com [52.101.61.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E03207;
	Thu,  2 Oct 2025 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759446037; cv=fail; b=NHIZzohSmckEGZYnX13f6YdDjsIm3ARrKL5t6QyfB6fXb/mS/xt50i3xY4XCsCzmVTl1UtXaNsNKtU54sMKnxbigbcH+K5YobCJ4wNA6uDxmFi+Zufx0WHz7sI5MjB9Kd42vrWAjUVzDJaQlNBrkfsUN4iylAKCAQVrCf7isr/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759446037; c=relaxed/simple;
	bh=9UdRB6od4tDynWlmGf5zoB65VY1IAC382IdXNk40TSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aiWW7O3AJRQlilgEtoiyqD8RabuPC2in76OQD+tZVOdRsv6bozqiJiIc16zWq5sEY5P10VGIgmJt4Q6k8d6Kmc0ewEhAh6Hwpl0kNEXtMmAKctd9aGsUjsL2OZZRdQA2MnoZigMqrig4FZFPZDJLKZK6d8t5+AaIXMipPCbRyEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=ZcV6VIB5 reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.61.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL2IRZHAWMRxZmXd3ZsajHsUVLv7nK4q7/Jjl71i3F5J8COct9y2Y+8T4SOpGUekYmaSdAchM+Ceto/oCUmYupQVXjOFynMa9kRwdWHwAiG+N4gMsv8Z7dc2WtIAulpOApUDjb38+eQaHKa0gGg82OUVxIcMuEfocavVrRWb+5MKf1ksTVUyShWypEoiwT1hpSCI7SCDshf64L42x5r3F888PYFAjJ9w5Efw9hClyYkKBcdDyNbs7l6JRVkMNDwjpLgl09M6K9FGKz6J3SNrRqwQkSQ1rAUF2UhiakE+VZIpJ6KYmdz3DP7TbdL7Y3dXO7a/iGbKwiC6y0nPcX1YPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkBDmWKTcErzopRV9vb9oHVSG+Lrf5AqJe8EbfqHvI0=;
 b=lULmWFW+r5uxPc7nPJ6na3SqQ/2uwYJ9w9Roei6ovvis6Gb+FRCmLioNtpbWhpBv6DOTC28iCuxEMh1Az+HmP1oqCjJmrqezxwqq7HYG1ajl7KHctlYJbmP0WJY/DNjQpjcpLeXu4uTka1er5OSosMOjHHfb9ayD4d4LNjY/lbO4xrO+IdgBQdXz2h6AzRj8XuYyi48ITB0tgmKpcpvIhOZ0hg5Wif1qhoYgRUTC+qql5pWowpn/Ogsz5581HsokErff8XaiOHO423Bflk6vv373M+vUC7DtrwC+mb6buSjVucmcK9SZvoXbPKdVMhUWYF1P4a4Radu35TovZhZeYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkBDmWKTcErzopRV9vb9oHVSG+Lrf5AqJe8EbfqHvI0=;
 b=ZcV6VIB5bEM2D+QjrwK7qUI9gad7W+fh6ypWGOXwq1RxeQ2xhjkrY4myZkNgFp5IqaN+2/dRH3SR8fOt/aJPyU/P0/NRL69sr7yzlYEf6maPN1yGVk6pumMR/T/Ls1Pcq5n4UStkozdtIemyiUQH0n9iV58uJpVo7bTdMjhsUKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DM8PR01MB7127.prod.exchangelabs.com (2603:10b6:8:3::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.19; Thu, 2 Oct 2025 23:00:28 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 23:00:27 +0000
Message-ID: <54aa6e28-65cc-425f-a124-372175a6e1c2@amperemail.onmicrosoft.com>
Date: Thu, 2 Oct 2025 19:00:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
 Adam Young <admiyo@os.amperecomputing.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
 <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com>
 <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>
 <20251001-masterful-benevolent-dolphin-a3fbea@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251001-masterful-benevolent-dolphin-a3fbea@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXP220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:ee::13) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DM8PR01MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d95f722-a8df-4b5e-8e26-08de02077a2c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHljTG5uTjhWS01XMFFDQlNESmJJTXM1NHNpYnh3bi8yRFlCcGZwMTk2dkVB?=
 =?utf-8?B?dEQ2UjBJajRLTExqTTVmWGIxUlJYV0F6Q1d0RW5XVGhaVlpqOEEyTHdqMSt5?=
 =?utf-8?B?bklmVXI4dno0WjUxRDJtWXpjYjRNTzFkWVFOQkQ4SWRPYm9YSEhGTllPY2Jw?=
 =?utf-8?B?SFV1KytVaUxBTDRuQ21WWnVBdk45a1Rzcmd6UXNHQlp2Z2MwZjdvN0lNYVpv?=
 =?utf-8?B?Tjg4M0I3amdtNUxwb24wUTN5d3RCTDFRZ2tpdGx3VzJIakJjY1pKL1lVbDQw?=
 =?utf-8?B?SWQyTjg1QWxqWUQyRzNoNm5pb2NNVUZqdi9RSmp0VUdVaWUwVEk3TVFHUmQx?=
 =?utf-8?B?T0NzVGU1dWcwcUszU2VETGdHdEtPNXZoWVFGeW1IT0pZMmFpMDBUYk1Ud3hG?=
 =?utf-8?B?WjFlckJVNkxXeFczMUliNmZaMFVvUDQ0YVcwVTVTdUljb3ZxVU5NTXQyM3NM?=
 =?utf-8?B?NFF3U0lJZzNoY011eDZTcm1zYWl5MlBpTW1Ld2x3OVBzeTNRd0pLV29kRUpy?=
 =?utf-8?B?Uk1JSmtER3FoT2ppT0J4R0pUWVBFWlRBQ29HMnFzaGFnQ2J5MVE5ZkcwcWly?=
 =?utf-8?B?MjBFcWtXQThYYXl6emtGbHNiVHJBd0VXdzlVcmxWTmVJMXVvUHltU21jdTZ6?=
 =?utf-8?B?L3NETzM1SVlKczZlYnM3d21CeUQxYXJFOEVkZHZUcEVBcXF6YUdtd2JxR082?=
 =?utf-8?B?U3pLZ1VIVE9aOTJUbEdSVnFBUGNLczM5bHo2WDVHWFptYlo0cFlzV2l3UXBB?=
 =?utf-8?B?WUw3ckFKYWFHYnU3VXMvWEh1UlZ3K3JYNVhCNUpycUd2cEtlcTF0VXUxMkM2?=
 =?utf-8?B?Mk5CZjBjVVl4Q2VVUlVnUk80VnVjaUVreFFnWUkvVlF3N0hVY2EycDgrNDU2?=
 =?utf-8?B?RmtUWUtmVWthMStWSTFjdXZ1bWxPbUlaOVhvaEc4cGdvY215akMyZmZ5MXI2?=
 =?utf-8?B?K2pINnRiNHhtRzNncENvVmFNa2svQUtlUmZLQWx3SUtvejFtalNicjdDRnpN?=
 =?utf-8?B?Vk93Wkt4WXNObmNib241dU9XUUU4QVArUFJKNjBMZW5jQ0Jkb05ocFRURVYw?=
 =?utf-8?B?U0JWNHVsdHJTaUxHeitaSFRibEs2ZEttZkdrRitKeUp1REQ1Vy8zeE1QSHEv?=
 =?utf-8?B?c0lWTkRRblFjd3N1NmRBaDYrS2ZpL2VuWk4xUzNETWc0RGxzOWJhTGg4d3JP?=
 =?utf-8?B?QjZaZWJOdURIQjRBUkZadVl2V0R1WFR6OEVTNnVFMlJkQzROVUN1bXcvNzg0?=
 =?utf-8?B?OTZ6YlIxTVBzbi9tTEhtTjNsU1FhajlYcVNiZU9QNERiLzdmeDZnL0tob1A2?=
 =?utf-8?B?Qm9FdXJNcnhYK0tXUDV3YTI5NjlxdTlCSm9pUTZYVU43Q3I2dUgzem9ManNI?=
 =?utf-8?B?V21PODRQdXZRVldLcHdRUU9Ja1ZRZGhtbTVpdnZzdmNiSTNOU0FRNk5CZGpz?=
 =?utf-8?B?SW9ncS9ncUZTcHU5RU9kQWs2b3UrUG9pUnVrVDZkR21uVHdRdzVFOUZjK1RK?=
 =?utf-8?B?TkxOTFhHc2dQM1VlMWtPNys2YW1SZHJJY0d0QWk3S3hyY1IzNXZ2NGMzVUR2?=
 =?utf-8?B?cjlmWTViajA2aWZWSlVoMkpNakRHNklkSHZ5K1YyeWhPN1lRaXJFNkpwYnhJ?=
 =?utf-8?B?UjQzbnlDc241VUJxQklEMDAzUmhEcWFvSjNrYWc2QkdhNDladHhQQlpjN0VU?=
 =?utf-8?B?dTMvZTdMN3pHSFZjb2I2TEdnaU5qaVRxNS9HZmxrUjBqTDNWK2hXODcyZ0I3?=
 =?utf-8?B?TUxVTHR0L20zMllqeElWbll2NzFQZ0d6NUUvTzdZdmJPaEZSbkdOVGVLNFdR?=
 =?utf-8?B?cmJsVmJkR2xYWFlBcDM3SGFaY0tOd3NPc2V1bGxWUlV1MS81TFk4cWpmMXM3?=
 =?utf-8?B?M0pFZHdxZVlTbXdIRXBvWDVpR3J1WVo4dDV4OWwyd0hZU1g3WTZuZmVwYjJR?=
 =?utf-8?Q?ZPR/JV3ImaocQS7WuFQR68VJ8J9mE0KT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlMwYVZtSXBhUVRCQUZPSk1TVnU0Y1V5RlBwRlFjWnljNkVVNUU3ZkF4bjYv?=
 =?utf-8?B?QnNiTy9DWUlHa0gzM3ZhS3FGOUZBeVl3VVZFdE1pQkNTRkJ6YzdyRzJod1M4?=
 =?utf-8?B?YTk1eUpjZTZiRDQvMlF1WGpXQlo0N0gvaGs5VkszZWl4THovaWhqZzl1ZnFX?=
 =?utf-8?B?YlZxV2JmWW5xeVJMTHpDT1A0bFgzL05ZcnFDLzRGOFgrbjVENkc0M25iSFoz?=
 =?utf-8?B?dWxkWEJHMjJwYkZwaWtzTjFrUnZqZ2xVV1d3WlA2U0pFT1luaHZGRVBkN29i?=
 =?utf-8?B?R0UvQVRWSmhvOTg1ckUzd1RkRjN6dFgrU3oyWjdjVS81ZjJadHVGZVRCMEY3?=
 =?utf-8?B?bk50aUFmcWNHdHMyU1ZLR0NBUEZySVVtNk5vZDVkMVV1VTFRSGI5ZlhOaTBh?=
 =?utf-8?B?aEF1VDVjZlJRaXBUVTBpZzhaVStoRE92Zksvem5CbGh6S1NtNEJLTDlMVWFH?=
 =?utf-8?B?OFIyV1hrblBZYWdMZHNHcVlWbmVtZ2VkMkE2dG1zNjVZdzN1NzFnRDRNYzAz?=
 =?utf-8?B?bVhtaTI2TnJ0QSs2eXIydGplQ0s1dm5qU1lCNnA2ZTh0TEpUS0piQkhXR1Vh?=
 =?utf-8?B?ZmV1ZlBLYkFqSW91elM1WWIweDhOamZ1bzVWdjgvc0dPbUF5NzBwNU5hdWcz?=
 =?utf-8?B?R2ZBVEJxVlJicGVWa3AxWkU3WFZqdjlhcmFsVEU2WjkxbVJuekcrMHV2R1BO?=
 =?utf-8?B?b2txd1RmRFlzcmlTT3F5R0c2KzhLVHV1Wk1iNktQaVpKaW54c25jTHdCTEp4?=
 =?utf-8?B?YWJNTFdqeFl3QlhxeUkxRXhzZ1hIcFlGQjBsaTJOQTlsN1MzU3ZsT3MvdVhv?=
 =?utf-8?B?RXh1VnZPNjdFaTFsQ1RWRTRUUHJUbnVxWVRteVJ1RVRGYWY4WXhOUmNZZmJy?=
 =?utf-8?B?NDZJK3J4QkQvRjc5ZWdxUHFCYlNLRVppWEJtc2ptTWJpaDBlTlludkFBM3VC?=
 =?utf-8?B?M2o3MG0rWUhHYytEYkw3Q1RRU2puZzBvSlU3VU80ZGxxUllnSm9sU0J4aTN5?=
 =?utf-8?B?eTRiZzZtSXhIZkxkU25qL3pWZGZpcjNPQ0JzTFMvbkNRcXdISjBTL3oyQU1p?=
 =?utf-8?B?VExwLzFwUTdsSG4xNlVDVHlTMWpSYXNIUmtIWEljdG1GRk9qZkVpQXNEdjF4?=
 =?utf-8?B?UTBodXRDSGpKTkY0YVFPWi9URGI2Vk5sUE1pRGU2ZXJaLy9kUFlSZkZsUnl3?=
 =?utf-8?B?Q0htRjVOL2NyNWZqcTIrVDhPN2hDVnI3U2V6TS9YaVFIUDNSQmh2dlFBMVRi?=
 =?utf-8?B?QWJuU1JSQjIrS3BxK0V6cEpFMFcvL3l6RGF3TTZRVGR1ZGcvY1QwRXZoZXJ3?=
 =?utf-8?B?N2tqa1lFcFhVdXo1Qm9KS0R6V2RJQmpLV2dDcU1nZDh0ZGhwVFZGanROeGxp?=
 =?utf-8?B?SC9qVUlCV3JUeURCc3E3TU9BMHhXa1JQeEdsSE9LQkhnWSswSnRranFzbWtK?=
 =?utf-8?B?MXIyNVJEZmUwbUxOYkQ3YkdmOGEwcGwwQ1RDRVdrd2pnRlJWSW1lVHI5VXR2?=
 =?utf-8?B?TzRlN0VxUVVuK0hteUdqOGhFcjlkRTJBejVKd1pyL1QreTllcWhyU2k0Mzho?=
 =?utf-8?B?N1hvVkdTdHgrNXlGaUtYZElURTd6bjRzOHRiaWg4QlVuMGsyQ2NYUjU3Wjcy?=
 =?utf-8?B?dnV3bzhxR2JYSC9GOUd2YlF1UUVvQmh0YkI1aHIrSEZzbXNqK2M0aXArMjRu?=
 =?utf-8?B?d1lBTTAyOG9YLy8wK0JHaS8xZk1CbDZMdTR5R2xocVVHZ3FYeHUzVzM4UUp1?=
 =?utf-8?B?TXJ2NmZyM203bktBeTViaDFyVVFhU2FVdjRsNXgwNHltSllZeDZCN3lpbmpx?=
 =?utf-8?B?NGREWGpMemRBZVhJdlB6aEl1MFBLZnR6RU83dGNqSVloWjRMQnZZWDZtVkJu?=
 =?utf-8?B?allnTEpoMXV1THJRQXJiWXZXMVE5UFVwUnh2alBwUXZTNW9IalU2QmVuaWs0?=
 =?utf-8?B?RFBUdHNIVjIwV3V0eUVkSERFRjg4dXZJNG5obFkrRFBka1pFVXh5UkVJcUhi?=
 =?utf-8?B?UTVPN2hMYVdFNG4wWitvQjRicTdqUWx0eWJLSzlKK25iNkEydEdHUndzbG1m?=
 =?utf-8?B?Wlo3OTNyeEJLMEwwMEFOd0JpYTdsL1l1dGFoRjhBYTFkRGs4ZXBCWjdCUjR3?=
 =?utf-8?B?WGYrUTlIWlNOMTZzTlNxekplWm45RWNTR0pqek1vVEZEUmtBRlBiN2JIaFRt?=
 =?utf-8?B?a1dIL1pJYVE1U1BSWTlUTCt4NTFMYlRseVIxWVFOZmcvZzRkczVxQ3lEd0NW?=
 =?utf-8?Q?tEHoHG5aF3iABvd19PNXxoIkGBsrWqGvSv/XkHYCQU=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d95f722-a8df-4b5e-8e26-08de02077a2c
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 23:00:27.3390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLBPRs1zn9eo+uk6ijyvHy3SUaQj/5rqMQtjes0ja1iBO2wFGs+xXfSTZYsXZ7SjB2UMzHC+1BVH3xK4wXzjznreCrZ1sPP+AW2IBlyBTEcZVyad+EWPRyA5GA+mS4W6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7127


On 10/1/25 07:57, Sudeep Holla wrote:
> On Wed, Oct 01, 2025 at 01:25:42AM -0400, Adam Young wrote:
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
>>> -jassi
>> The mbox_send_message call will then take the pointer value that you give it
>> and put it in a ring buffer.  The function then returns, and the value may
>> be popped off the stack before the message is actually sent.  In practice we
>> don't see this because much of the code that calls it is blocking code, so
>> the value stays on the stack until it is read.  Or, in the case of the PCC
>> mailbox, the value is never read or used.  But, as the API is designed, the
>> memory passed into to the function should expect to live longer than the
>> function call, and should not be allocated on the stack.
> I’m still not clear on what exactly you are looking for. Let’s look at
> mbox_send_message(). It adds the provided data pointer to the queue, and then
> passes the same pointer to tx_prepare() just before calling send_data(). This
> is what I’ve been pointing out that you can obtain the buffer pointer there and
> use it to update the shared memory in the client driver.

So we have two different use cases in the discussions here, which make 
it a little tricky to separate.  Type 2 uses a Reduced Memory region, 
and type 3/4 use  an extended memory region.  Jassi and I were talking 
about the type 2.  I think we should table that discussion for the moment.

To answer your question, Sudeep, I need to deal with the Type3/4 flags 
for ensuring that the buffer is available to write.  In type 2, this is 
done using a value inside the buffer, and is hard coded  by the spec as 
a field in the statis code.  For Type3/4, the logic is this:

        pcc_chan_reg_read(&pchan->cmd_complete, &val);
        if (!val) {
                pr_info("%s pchan->cmd_complete not set", __func__);
                return -1;
        }
        memcpy_toio(pcc_mbox_chan->shmem,  data, len);

pchan->cmd_complete is a register set in the PCCT, and can vary from 
channel to channel.  This needs to be atomically checked with the 
following write.  Since the mailbox API has a lock here, I want to do 
this inside the send_message code.

The alternative, which you might suggest, is to do this logic in the tx 
Prep. That would require a different change, one that exposes the result of

  pcc_chan_reg_read(&pchan->cmd_complete, &val);

the way that the type 2 drivers do.  Putting this into the drivers 
tx_prepare commits us to that path, as any attempt to move the logic 
into the mailbox would break the driver (or require a rewrite).  This is 
part of the PCC protocol, and the Mailbox is PCC protocol specific.  
Hence I put it into the send_data path.

In my latest change, submitted right before the revert got posted, I 
made a change to only execute this code for Type3 and Typ3 4 Drivers.  I 
think that this is the better option than flagging the channel with 
"managed_writes" and I do regret that the change got merged before that 
change was caught.  That change is titled:  mailbox/pcc: use mailbox-api 
level rx_alloc callback


