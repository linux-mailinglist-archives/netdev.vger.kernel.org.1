Return-Path: <netdev+bounces-45886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA717E01A3
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 11:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7635280F6F
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 10:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DA11FCC;
	Fri,  3 Nov 2023 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05D15480
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:45:09 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2028.outbound.protection.outlook.com [40.92.59.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36764187;
	Fri,  3 Nov 2023 03:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzyKs2fKYJSNRJz4s8kEC+BdGJRSeYvrIrC/tvHjrpD0MJfFkIp/B/YHZslMu7JYS+ws0awMMswD/iUfBsX9FyuBKlitZHyLtGSn13K0izyFpYxbwqoRK7qtLvUhEHE/8ljQs+nP++8eXD67YjaaM7f9sokF4vmCcZXC/BfAuDRTqEBdDfm2RJKbG1MGvJFq85XeYVtJHx4q8t9TUKrmxdP882+V0Ayr0YyIQTUcu6nCBFk6v2w3lA8fpQkFmTaGd1yfC0ZymWNl3UqLXeFiBnAVnq/v6Sj+5rq41eWlUgG8fk13+7vw36oDs8LSoFyzfFxePWhAv+k0KdNHHUY2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGeLFUaIuUHoNH0oPFe7qL9OSQz2ZDwZiHAM5grqNr4=;
 b=IjYXmgnJn8MSBDPPzmsFRcFVjmCRRMw+zGnP5jFHhDZ86E6d8jsf1+9eaaQSxhnqnfzTDwErOhDtaY6Q+XhCsVxnbEyt+o5N5VkJCTOz8qlFnUiCOTYvkg4ryPp81L4Uj9zu5i5hUMFWYaNKyr28MuLk0mV6eU+GGlnWnvQInwl88SujBONN02nSlpOnWczPx5w81PNpUO3uAU3smCdnbM/rH/NDNqDv5bpI0bjmHo3WzRPgk/Hj7neEYrfBUtCu0V6eqTCEzsy1YjQPi5sa+1UW2ftWIhktPt6BEPK7HMNAuD2s6dPTR2XYF5yb46ktUVZQoj+2mp6jELb/O6AcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by PR3P193MB0847.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 10:45:06 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::b89e:5e18:1a08:409d]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::b89e:5e18:1a08:409d%7]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 10:45:06 +0000
Message-ID:
 <AS8P193MB1285D01DE5EEB31FC2A9B928E4A5A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Fri, 3 Nov 2023 11:45:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: Wait a bit for the reset to take effect
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <5a265e5541ab1de2258a6e61bd672ef5fb6be65f.camel@redhat.com>
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <5a265e5541ab1de2258a6e61bd672ef5fb6be65f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [qDq5Jc5No+6J1tpK019Wgv8iLLW3wVwjL7rJ2H5n08KhedlfforrBFSAzz5ZOw1z]
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <6996d200-62cd-4f0f-ac45-11a1e4c30b2c@hotmail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|PR3P193MB0847:EE_
X-MS-Office365-Filtering-Correlation-Id: 10331e06-eefe-41b7-fd21-08dbdc59f0ee
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F6bo0K0BSbyUI49OYY14HSQL7XJwm/nfWZH9aBJXwtVgAOQ9cGSPHdjVJ6rYANgvPSLlR8Drh0VVkyQa9LHDVmQxZpj2MJbMcQPMgTSmwTugPXrkA4KNNfPB2jMLAXjs6n496OlDaE5KuU/xt0e1W23AsGUZNvGVLb1MBrXQETfFYlkWjCeYDR89GD+liDbk0bfzYQvT3z+EAB0Gb01D8dPEPZJfXfhle5etayRnBPprEHjvdpT7tcOMKw8MweMb2m9AEqR1zQSh02VTDHC1ASuKmwUrVg0Myl+ZbrBWl1RKgq63vzxEj+6kbNRvjUqebBRIPChaEv+eAdi1J/yE8IKAzFnSZatpOuia/9SO0IK3bYjaUUleNoDmkj3WUuXp027nKSDETidcyvusUXdf8NdY8f7W2zretdVJl2tz68tD+WHA83X76yAZ5Z0KU6QUDp8hiFQI963BjI+bdGzq9KjRq1a5zW3Acgy6pC6quvqJsbfh9OeDev2CQtKmeS500DiCX6xCboZIqW/lwPEMdqVXpnJY29FZIGElXj4gU/nRD44/2ke7SrEG1CDlzPqR
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXpBYnBYL3RUeExTVXh0YmFETTZDYTZBTmxsMEllYnZrYW1oQVZZQmVoaEhi?=
 =?utf-8?B?NEFRSW82ZU1LYnBkUnE4UExYYUU0QTBTYnJWVGlVMjFCUjBrWXhEWTAzQ3pI?=
 =?utf-8?B?bERORGdlaklpUDVLSGlzeGYrRjJWZFp6VGVIeFZpWm53U1N0RjlqWmJZcTlF?=
 =?utf-8?B?ck4rTlN6N2FaUWxZOEFpVmUzbExHS3lnVTdVOTZFWCtJVlZ1TDFwZStuaVFQ?=
 =?utf-8?B?T0k4aDQ0YXQvYWhvN0ljQzEwREo0T3N0MTZzZTZUUmNESWVQN3o3WUJWa1Jk?=
 =?utf-8?B?NVIzOEVpQXUrZk1KN0FNQzI2d2ltK3hySmg0Rk1IcXJRZlFCSERMN1FCQVoy?=
 =?utf-8?B?TmQydVBLV2JvT2FjZGRaZGN4VHQ1UU4rZk5CQkt6OXI1SlA4Uzk2UU44MXYy?=
 =?utf-8?B?OHZtK1pjRGI3VEFoYm5SV21scXZxZy96MmlOMEZvczBjZ052bXVmRUVadmpE?=
 =?utf-8?B?SXh6RHJXeUZ0SjdBdXVMQlRQWFpoV2V0TjhXdDkvTS9KWUNhaWowdS9zNFEx?=
 =?utf-8?B?b3RKV09vK1pTUVhXOFpJYlNXa0lzdkNUZ0hYQTNRSHpSYWE2OGhaeU5HVFpp?=
 =?utf-8?B?L0tCVENaemp3RE9VMGhEc1Q5THV1bEZ1bSsxanhyUWhMWWhWWnNKRnFKZHRx?=
 =?utf-8?B?YVQ0eXhuRkpnOTk4ZzhxcWZIcE9kbTF4cDRSUlNzbUFGc0s5VkxuOTc1WHpH?=
 =?utf-8?B?dmFqTHRHSmZKajRqYzdqdTU3UkRYOGtVZnVOdXgwNTQrNkllQjFGVHdJT1Jh?=
 =?utf-8?B?bmJaRW5uSjdPam4vaVBtWVZReDBvSEwwdFhwbmg5NHhackhZYWJmak9XSi93?=
 =?utf-8?B?c3dtemhqK0ZmZGozbFhFOVFpUHkxaFJDNTZQcXBPVHArMU4wRHZ1RkRIL1dk?=
 =?utf-8?B?QjMxakM4TVZIYUxvUFB1bmptMnFOQTlqa0F4Vmk1Z1JvVnM1a3ZzOUt4eCsx?=
 =?utf-8?B?SXJ1Mml3alY3b1F4TG1nY0dMMzJENnQzdnNVNEl0dUhwdUhVS1V3ZjJqeW9M?=
 =?utf-8?B?dEVxTVM2UjNNd0J0THkybm9zanBHMGlzVk8yVXFrS1VGYkg2ZFVKMzdBQ2lN?=
 =?utf-8?B?S2RCUzZFUi8wU1RaR0VjYW1lVThPenQrV1c5d3o3eG5INW1NcHR4Slk5Z1FP?=
 =?utf-8?B?ZkV3aGdqU1JMUkg5dU1SUUFPNmhPeENYQ1hCN1lvM3Ezb2lrZ1lRYW5zMk41?=
 =?utf-8?B?RHp5NThiVDBzckM5RFlhSU56NUtDWnZJcFF0Sy9TcCtyQU9ObFljQ040dTFG?=
 =?utf-8?B?SmVrZjZOY1VLbzlJRHhQTlhpNlFpSm45K0s1VXQ0NElEYTAwaU8zL1F1WTZG?=
 =?utf-8?B?R3owWTJlNFZ4cEFGejVqZ21tRGdsaWZKRDJOUkV6a0tuT01aeVRBQnRjcWhS?=
 =?utf-8?B?eDJpVkovOUcxMldNWWVZRmdEeGxYUStzbWg1eko3VmpRZXNUSmJjRzdyM2ha?=
 =?utf-8?B?OFJrVFh5bGsxSHU3aDRRYXpaWXphZ3RjVUtYaDlMSnlCWWtjdTc5VVB4dFRO?=
 =?utf-8?B?TDhEenpZS1J4aVB0d1FyYndTM2EzOHZKL0srY1luNmlUbUVNZzJ0ekhhZkZB?=
 =?utf-8?B?L0hLVTNCMmI4WG0xVEFvMHNacENlSlRXWWNJMCtBT0NSdVF3S01JTGlRck5V?=
 =?utf-8?B?MU9yaDJVL21XZnBweWJQNTdZMSt2akE5VnpQUi9ZclhzaStmbCtCelJ4MlhC?=
 =?utf-8?B?MWhFUzJ5bzFHd0JGdklYUmZzRTcxckloM0NsOHBEdFI5U0JhT2QzSjVJWXp0?=
 =?utf-8?Q?DnUPmjGjNYLPtECnG4=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 10331e06-eefe-41b7-fd21-08dbdc59f0ee
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 10:45:06.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0847



On 11/2/23 12:25, Paolo Abeni wrote:
> On Mon, 2023-10-30 at 07:01 +0100, Bernd Edlinger wrote:
>> otherwise the synopsys_id value may be read out wrong,
>> because the GMAC_VERSION register might still be in reset
>> state, for at least 1 us after the reset is de-asserted.
>>
>> Add a wait for 10 us before continuing to be on the safe side.
> 
> This looks like a bugfix: you should target explicitly the 'net' tree,
I dont understand, did you mean to add "net:" to the subject?
It is already "net: stmmac: ..." or did you mean to send this message to
another mailing list?

> adding such tag into the subj. More importantly you should include a
> suitable 'Fixes' tag.
> 

You mean an informal description of what this fixes?
like
Fixes: Randomly occurring "Version ID not available" messages.

Or do mean to pick a commit where the error was introduced?  I doubt
I am able to do the necessary bisection steps, as this seems like an
issue that was introduced by the initial design.  And I also doubt that
it can only affect the GMAC_VERSION register.
To make that clear, the issue is totally harmless, maybe some performance
degradation but I became aware of it only because I was trying to solve
a totally different issue, and therefore I have looked very closely at the
printk messages, so I spotted the anomaly to tracked it down the reason for
this flaw.

Thanks
Bernd.

> Please send a new revision with the above changes. You can retain the
> already collected reviewed tags.
> 
> Thanks,
> 
> Paolo
> 

