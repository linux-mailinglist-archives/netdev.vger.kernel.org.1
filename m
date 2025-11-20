Return-Path: <netdev+bounces-240466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6E9C75516
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91CEB4F44AC
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80784350A29;
	Thu, 20 Nov 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="cn24UjkO"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011026.outbound.protection.outlook.com [52.103.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680AB2882AA;
	Thu, 20 Nov 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655216; cv=fail; b=RwoTMsHf64dvx8TyCKoq69TyGmfZx54WDeGsV8QoEDmSc/wYIVNumU2JsuXxsm65DqjQcHty8rKXHP48fZLTzzmIqMqd/kvK4xSWqnCE6wnDdN0iY4Yqk6e8pfYgm16vDUMhCw356pD2sZ2OVG51QHCsRWqkonMR8wl2zBQua+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655216; c=relaxed/simple;
	bh=t/f06+40Q/YaUpaYknRI0emIVK2nSXqebsX5N5zmvAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xl6iGMn4p4AHNZEhUp84mYTZD4xTPhfNnRuhRMV3g7gA8K/OQ20KqT7fH1988wwG6BUUdlBPAVR4Rk/7PNP0x5fXuYdktjOAiWMgSO+eRCjMZHoe0BqHE+kLPcY1MN7rMVLMfWxY/m5nANe3oykPZ/AQwrpPAPXKmst7Eqo4e5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=cn24UjkO; arc=fail smtp.client-ip=52.103.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgtdetd/iJ2usAbf45BYkT7smy4/VH+U5DruhwPQ7NiSGaGfLjcwP5ZBEALUI+G1mNqqyEC/DM/sRTiX/0LU+w9ynLrorqvPUUQAGQEVazH24cvoVyRE/+cLKhWPj2xPc1dyfgdXZ/U7Dfsf2fp2+efmAmu+jMhdbahJVUGD2tDRywERvzm9oSu5LE/XtVWBl1a4eUZkolMnHeue0yH86XUc8rSrbGl9h0zQ/vrwxYejKdAf2RKLjXwjyX0H1YdE9Ht9lR62gKRS6HiPTx3D1rG1vWBEssMAwIKgziTtJPRSEb+sHl8+5AIh2C6GlIJGPKUvZR/3jll4B91uXXNI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5GsHElwzRe+1cjBtpzt6rmCHt34a4wCv4+Qd7cx1j4=;
 b=UEWJHGUkEWJez4jsQstrqs3W7hwfDuwsz8bk+tCPX6gSIoLqD/eFeWskdeWTRt2L/pBDNFTW7rqX2se1btpB8mncoW7y8i46CbBx/rDknMYlyHedmVdDk/jBZ+e8KYAWepDl7l8NyDntzBJE9P8ZAJhENN1YdXaaNRtIUlWLEJmkejUzPazXXmQ4Y4mUGgSCS1c5V6JVihj9KPVCKosyCXouXLtYpa56Y/c8fbRVf1trriFQH6Sr/sT996B9HlgGIFgBQmT/L5W1Rs7qatm66VB154c3PuTjgdCSd/zRWCm8pfCB85mEnoaWc9OQDOhADR7AMlOTXGw+4rp4nzQyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5GsHElwzRe+1cjBtpzt6rmCHt34a4wCv4+Qd7cx1j4=;
 b=cn24UjkO1HSE1P4AZbP/smChvFC4+BcF/w6q6AYusFg0xuVd4QHPyxwDDIAisED2bkty9SrgAZvor7c99vkkcM3ug/fpLMN+9jwAETBf07vBq04q8+3BTazctoDmnKv3oDGgGOEyQEt5MwV+sqfptMosf3pTwiFc2803Z9azDdRe60TFMTDng09c3d61GnT//xmOKq0dqjpF12x6f6vmLekbte6g6FdO3sqMtoh/Z2tp9EP9HBbr7t33/5QPW3b8s5y2EyS7JrV6rLtfdwH0cMdNhsHSNMmyxkx6NDsqgd5xctJ6a639+RkXixcfQH/IE/B8ttMGYjxbafGplSylFQ==
Received: from OS7PR01MB13832.jpnprd01.prod.outlook.com
 (2603:1096:604:368::14) by TYCPR01MB6834.jpnprd01.prod.outlook.com
 (2603:1096:400:b5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 16:13:30 +0000
Received: from OS7PR01MB13832.jpnprd01.prod.outlook.com
 ([fe80::b2a2:7807:bbbd:6021]) by OS7PR01MB13832.jpnprd01.prod.outlook.com
 ([fe80::b2a2:7807:bbbd:6021%3]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 16:13:30 +0000
Message-ID:
 <OS7PR01MB13832DD044176D127AEE48B2995D4A@OS7PR01MB13832.jpnprd01.prod.outlook.com>
Date: Fri, 21 Nov 2025 00:13:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcp:provide 2 options for MSS/TSO window size: half the
 window or full window.
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <OS7PR01MB13832468BD527C1623093DDDA95D7A@OS7PR01MB13832.jpnprd01.prod.outlook.com>
 <CADVnQy=4BRX-z97s2qnNjLDSOr5hce4x6xknaySy6=Wrpjhn1A@mail.gmail.com>
Content-Language: en-US
From: "He.kai Zhang.zihan" <hk517j@hotmail.com>
In-Reply-To: <CADVnQy=4BRX-z97s2qnNjLDSOr5hce4x6xknaySy6=Wrpjhn1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0041.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::19) To OS7PR01MB13832.jpnprd01.prod.outlook.com
 (2603:1096:604:368::14)
X-Microsoft-Original-Message-ID:
 <a1f13f54-3ad4-4cdd-887a-111b27262d34@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13832:EE_|TYCPR01MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: f4275960-c1d2-4b85-51ac-08de284fbd9f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|12121999013|6090799003|8060799015|19110799012|8022599003|23021999003|15080799012|3412199025|440099028|4302099013|10035399007|1602099012|56899033;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXR3VTRBRGtYYTYwQ1BIcGc0YTRERlR5RzVROWRHSXBEanlNdmJydnlwalVW?=
 =?utf-8?B?bnlreTRNRGNlMzVkNjIvTzNocU1YeUkzSDdIbStJSXdxdXNwdUtuZk41dXo2?=
 =?utf-8?B?NWw5V1JqNjBwTkFhUGh5S3BrTlFOVTlDa05vQVRQZzg1RW9iYlJucDE2KzVE?=
 =?utf-8?B?R3BzTkxSMk5OUE9lVk1aRDFPRk5JVXpoQi8rM1hlbE9qM1puam42V05Oaitk?=
 =?utf-8?B?NWt6WElXdWs3UUMwUnVRNEFCSnpjcTBqenUwbVoxZTJjS1p2S2tyb3N5NThh?=
 =?utf-8?B?QWthMkZ5QU1EeG9PK3dXcVNHZ1AzTXpxME5wbDc1bEUwa3o0SEc0OURtWGhz?=
 =?utf-8?B?ei85ZWp6QkZjOGw5WDBoLysrSTI4SGFOZjRGZUJNSGpXd3ZDbmhFdUYzRUNi?=
 =?utf-8?B?ay8rZCtSUDlYeGVGbE5Od04xOXMwZVVqdnk2Q3FPanh2YlEvR1Nzcm9zYU9M?=
 =?utf-8?B?eGhNNUllbUNvMUQ2SjFrUFdLbHVZZWIzOVlPUmc2bnBOa1VRTURkMFBFSStM?=
 =?utf-8?B?OUJKY212YzVpRjhSci9qZzNaRm9oczMwSFFTMHdaODhqSCtJUVlpTXExWGk4?=
 =?utf-8?B?dXRacFRHZ1h5dXlJZm56NzNFYnZBTDF4di9KTmdjSDFTejBoTC9WUlorNFhW?=
 =?utf-8?B?OXlycm5VQmdqNnlSSzRURm9WUzZncFRlK01MU2pWaXp4SGoreXNnZHZMVFF3?=
 =?utf-8?B?S2hJRWNPMUFXYkxjL1c0WUN4N0N4VjZmU1k2MllVY0l1eVFzcGhTelR0NjVh?=
 =?utf-8?B?QkdUbnlkOXhLY0w4K2dFTU81bW1IZC9GT0cyUnl1YWtMYVJxb1FVZ1FZeDJr?=
 =?utf-8?B?OUp6cy9ZNGl3K2EzdTdCQjRHT1RsVy90YkdhTkRZZFNhNEtzeW8wcjFBaHVY?=
 =?utf-8?B?aytpUTl0enN2Z0MvL3c4RGIyeXJBQzJGR05McnhhR2RZeWpSRGhpRWV6RU5T?=
 =?utf-8?B?R2tGeERlc000M05lMkk0MGEzVXBNWDlmb1lhOThSbStVeVF0cTJibytiNnli?=
 =?utf-8?B?QStMVFI5MnpyY2FuamxhRVdjK20vM01UZUFtdUZSVks1YlpMclhRMjdvRUdE?=
 =?utf-8?B?MHl0dmVxSWs4bDZGYzU3RHNGeDdYeE5VTGxpd3BMMG1MUVRTZTEraGpkK21q?=
 =?utf-8?B?eWMrZGZRb0R5dlpuajlEUFZNWEFhZVEraWtrVTFDUitoV2ZrRzgrd0wrMVFa?=
 =?utf-8?B?Q1I3NHpJWWh5RWlsakdPanF0WFl1YlRkdm1KWlJrOHRnWUxNNlZhQUVjKzNW?=
 =?utf-8?B?Zy9hU0doaFlTU1hOZ3ZNZ2ZBU0UrclFOakJmRXJ3eGJFd3JNTmo0cVF4NDVq?=
 =?utf-8?B?MHRQNkplN3RnQ29EL2pVcUQ0TWVzb2hjckRuSHh6dlgyQmpmQngwNGZsL0ZD?=
 =?utf-8?B?SXJrZXdvdWVMK2FaaXRTd25nY2dQSStXS3lxWmlGOUJEZEJuNlZKR3N2YUtQ?=
 =?utf-8?B?VDZMRXllYXdrMHBrbUNmQmRwejdIUVVlc0JYOFUvQTJPV0MvWStvZ0pnWUNN?=
 =?utf-8?B?M0dZYjJTRXlEaGh2L25uNUcvNXBPcENZcC8za0lLSzJ4a0xEOGFNWWsyVC8z?=
 =?utf-8?B?REtYczlBLzcrZ0QxZXpTajk2WnpqTlJ5Z2FqemZjQlVGNEM1SWdFNGNVM2hW?=
 =?utf-8?B?TklmWWpxVmZ5ME8zRmNrWngvSHZ0ZU5sK2xVMlRBazZUVE1vNXBvZjFkaVdJ?=
 =?utf-8?B?OGdmZWhGRm05L0hnNFZRb0hFMFZvUW9ESUd2aU1hOS8vcTRpc00wNmR3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3VQTHNiSHZaKy9xWStldFovVVVUNmRIMXpFeWRYN3Z4UTFCd2VrUlVKTnBI?=
 =?utf-8?B?OTdBeFRHK2IxZk1HeHQwSmRtQ3VCeEg0TEZKRUd4Z0F6MmJpYmR4cmNLbWwr?=
 =?utf-8?B?WVVPdjBSNU9POXJNbG9uZ3UxT1JWTGdHa0hqM2xaSG9kc2JibXJaQjVGd3Rt?=
 =?utf-8?B?UEtNNlo0cWNPRER1MVZaWVpCM1ZXL0JIYmoza0p0U3ZZcjVrQUh4elY0bm41?=
 =?utf-8?B?RjdxRk1sTVRjZ1ViRjdRRzFDUUxESThNTFA3QWFoUjN1QlM1UERSaThiNytq?=
 =?utf-8?B?anh1WWdqaHE0aGg0K21FYitQWVBxOTltYi84RHNZUWJnN1lKUWxtS29Pak1Q?=
 =?utf-8?B?K1U4RWhMeS9aYTBIYTlHK0dpVkZxa1RCRFQ2dCtUSmQ5eGNBeWJQdlJhRTRC?=
 =?utf-8?B?cC85LzdjalNaU0tDMnlyZ25zd2VwR1Z2djhjRWNIcjZsMTVsM0djN0xCc2Uw?=
 =?utf-8?B?U0NvMkdnT3lubUZUc21VSSt1NC94MmNMNGNxQURUTUxpZC95VFIzclZuSXRV?=
 =?utf-8?B?S2YxejJtYlJLY2FCOUM3amFFeC85TU84blpvMGU4R3h1UHk1Y2d0VndkVVdp?=
 =?utf-8?B?ZFNHcDJ6bnU1ZW9oV0NrZnBDOWtZT0ZpaWpZdDYxTnByY2FQRUp1dTBnT2Yx?=
 =?utf-8?B?ZXVtbHFDcktPNG9wS0tiQStFbUhGdW8yS3pCUllmeWxCeHh3RFpidTJwdXYr?=
 =?utf-8?B?UmlhdHhXMXE1aGVoSVE5aWhwbzRtTUlwbUE2Y3hQS1IxVDdpNmprd0gzekJR?=
 =?utf-8?B?eG54Qm9yNVA5TVE0THVjVWpheUVQb0xDRHMyMHhiclhwazV5WXdaM2JMSmx6?=
 =?utf-8?B?UVNUd2huem9KQ2RTdWlkM2MvMi9QNjIxY2ppdTdEcFZnWkVOaTJVQm5reGsw?=
 =?utf-8?B?QkV0M0ZrYzJ6MUlMRTBIcEsxME4wZHN4azB5SXlrbTlTQXhWUmlvREgwYmxK?=
 =?utf-8?B?S0lsWjJ2am5laHRncUMzbFZHcEhjaFYzQWFjRFdxK25BZDlubWVBYzlad045?=
 =?utf-8?B?RG0xbEpoTVo0cVpVUmEzNTdZMy9zbGx6aUcxbytzUU9sUzNyYm0wS3pES2FW?=
 =?utf-8?B?d0t6Sy85YkcxYkJGRndqVGNXL2tCTStheXY3NE1LbHN3Y0J3T21MY21QM1FY?=
 =?utf-8?B?T3o1aWNEdHR0Qzl5VnVvRWQ1clY0US9GYXdPcE1POVBEaWY2NzdFUEZkSkVV?=
 =?utf-8?B?VDFqL0s1d2g3NGo4cys5bkIwZU95dndpZFN5akdiUlJnbU0zS1BMNFRJK3Fy?=
 =?utf-8?B?NVNjMjR4YW5Qa2ZudW5FYm5BMmNXUFFsLyt3THdDR0pxeEhId1p0Q3p0b0h6?=
 =?utf-8?B?aU5MZzNUV0drOHZxd0xJZlNZWkV0bjNtSDZhUnVRUzBLVXZDbWJlNGt6eno0?=
 =?utf-8?B?YWFMUVlLTW1IZ25neTNQbE91ZTlnS1FpckVEdjFPWnU4ZFRnVElTS080RFcy?=
 =?utf-8?B?VDlQSzB3NFZraVZ0QW56dVVBaG1JZWQwQ1lHOWdkWnZML2oxdWRpNWtyM2Vt?=
 =?utf-8?B?MjVGOWNZclM1TnpnTFlkZmZ1VG9tWTMxTmtac2lxQ3ROZndrWWlGUlhuUjJ5?=
 =?utf-8?B?SFZKKzI2czc5cmdTVDNQVy94M2xseWtvK0Zna2MwRHdLYlJTalArQkVPNXc1?=
 =?utf-8?Q?g6KyzaHhUv6NLRocLJy7m6v1lS4zB4j8pACYq8J9KJ6o=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-9a502.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f4275960-c1d2-4b85-51ac-08de284fbd9f
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13832.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 16:13:30.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6834


On 2025/11/20 00:43, Neal Cardwell wrote:
> On Wed, Nov 19, 2025 at 11:30 AM He.kai Zhang.zihan <hk517j@hotmail.com> wrote:
>
> Please read the following before sending your next patch:
>
> https://docs.kernel.org/process/maintainer-netdev.html
> https://docs.kernel.org/process/submitting-patches.html
>
> Rather than attaching patches, please use "git send-email" when
> sending patches, with something like the following for networking
> patches:
>
> # first check:
> ./scripts/checkpatch.pl *.patch
> # fix any issues
>
> # then send:
> git send-email \
>    --to 'David Miller <davem@davemloft.net>' \
>    --to 'Jakub Kicinski <kuba@kernel.org>' \
>    --to 'Eric Dumazet <edumazet@google.com>' \
>    --cc 'netdev@vger.kernel.org'  *.patch
>
> On the specifics of your patch:
>
> (1) Can you please send a tcpdump packet trace showing the problem you
> are trying to solve, and then another trace showing the behavior after
> your patch is applied?
>
> (2) Can you please provide your analysis of why the existing code in
> tcp_bound_to_half_wnd() does not achieve what you are looking for? It
> already tries to use the full receive window when the receive window
> is small. So perhaps all we need is to change the
> tcp_bound_to_half_wnd() logic to not use half the receive window if
> the receive window is less than 1 MSS or so, rather than using a
> threshold of TCP_MSS_DEFAULT?
>
> thanks,
> neal


Thank you for your reply! I will submit the patch according to your 
suggestions next time.

soon
(1) This issue actually occurs on Linux 4.x.x, caused by the function 
tcp_bound_to_half_wnd().
This function first appeared in 2009 and has never been modified since 
then. Moreover, Linux
4.x.x is no longer available on the homepage of www.kernel.org, so I 
assume you probably
won't accept patches for Linux 4.x.x. Therefore, this patch is based on 
Linux 6.x.x. I will prove
  based on my analysis that this issue has existed for a long time. 
Regarding the tcpdump you
requested, I will send it to you later for reference.


(2) In the current era, when dealing with embedded devices which often 
use the lwIP or uIP
protocol stacks,MSS is generally around 1460 bytes. However, in the 
tcp_bound_to_half_wnd()
function, the value of TCP_MSS_DEFAULTis 536U/* IPv4 (RFC1122, RFC2581) 
*/. When the peer
has only 1 MSS (i.e., 1460 bytes), and we want to send 1200 bytes, Linux 
judges that this exceeds
  the 536 threshold and thus segments the data, sending it in two parts 
(the first 730 bytes, and
the remaining in the second). But Windows 10 sends it in one go. What I 
want is to send it in
one go. Previously, I considered changing the threshold of 
TCP_MSS_DEFAULT to 1460, which
seemed convenient and safe, but it doesn’t seem appropriate—this 
threshold originates
from the RFC 1122 and RFC 2581 standards. What do you think? Is it 
feasible?When the peer's
receive window is less than or equal to 1 MSS, we can avoid using half 
the window. The
tcp_bound_to_half_wnd() function introduces a variable parameter mss_now 
and then
performs a comparison. I'll modify and test this approach later.

Thank you!

He.kai Zhang.zihan



