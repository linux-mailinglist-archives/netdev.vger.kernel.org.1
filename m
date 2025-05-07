Return-Path: <netdev+bounces-188522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC94AAD2EA
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655DE1B60462
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A0156228;
	Wed,  7 May 2025 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PPIboIYk"
X-Original-To: netdev@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010005.outbound.protection.outlook.com [52.103.68.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AF4B1E61;
	Wed,  7 May 2025 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746582467; cv=fail; b=gJW9EZ/Vo5mQ2DAh7Gigd+VQA+Et73iMDrp+nYYYP8oo2ExrFbbytv0QGmqKmQUmvAgjdCaYyUDuFkasulzfs+D1m5Y8uAy4q2BFX0iuvEFVcZI5ax2QYtCwLK3TPmdwUbdCpV8lJEB7S3+WMvAfmxI0pds+x0/2u+v0ALbAOyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746582467; c=relaxed/simple;
	bh=FZntVLQFQvL8L+PujlYDBTfwxXCZZM8xD6nX/Lasmro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LhdG4Fo/8oRYdZ8p13FkjB51UWlAd1DCQSq7rR6RFXHwRgv1Z6jibOpON9526G13AK5Muwon3c6MNt3Eav9bJ1JZj+EOl25Vcl9NV601TgyLAV93WWKy+70TinbndbMJg4Bi/o9xdFmnEe7zClAWM4r81MG1/JOS0coiOkUuDws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PPIboIYk; arc=fail smtp.client-ip=52.103.68.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvaiCCo8HbUN53t+VvouEBufyxIUnxRleF6xmTtRGB4K5IGIgx+EQqCSErNZmTI04lS14suEg5Ya9qiqiTdFnTRphslcAvaGOzO8hgMqkSL6fbRD9q2GCVMdyEqFBdW52ruqqicFwnUH+bZnZz3ZA4PhBtNRPdPV+rykDt5euo3o/tc9YG73YQhGzRCG3obtpZYNZvAc5rUun6EKH0wye9JW3v3wNg2d9RmjrrzN8NL0PQD+wOQTQEbwrxhcKlqZqMx8wVxZWK4YeW5H3NAHiwx3GdtG4IUmvu5+1rtM8cK1q/C2FmrlCt4jRDEN71nFt0KU3RTsIvkDV8R3mZDJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xcq2YGLzZXPvlBASLds0hbyqqs9kKFdeu4Zng9IEtMI=;
 b=ZgNkEbtvX4b5G5cbINMoSe5Txm6vF55pTJ/Af96Rw6x+8xe1/g2JFTTfNuA0zmIC2a7XzLHzBUNRrQrGIJ0GowWW6ML+4M7WE6r2C51+MsQT96+NHEoXBIhMD9N9BlNXJoNnDEAA5la+9c0DNy5WJo3JlR0cc8KadX69/2ztCfKuj+MplYQgz2YiF3NknX0aHPHcOAUzY0g5Oy74vnceWAP7XMRjtXclJVpNLQdT25Ek+xNbDuQCkcKDZVeg48VN22C/pjHB2TchQSRO4qTbFozXxhmjXLJKsjIkas7kQq4ngxqc5bIDuhXVUftn/McCMmTC2USpU8AghSWimdbl5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xcq2YGLzZXPvlBASLds0hbyqqs9kKFdeu4Zng9IEtMI=;
 b=PPIboIYk7qqn5rzydsWwoszOX3wjwCADZJ5z1vTAG0S7kokY/c0Rcvm2m0Zhpr4+nZ2yHeg3xjoV1OFyPZsmVm65lytoQKB4dNF3Xj+DIc2FRWQY2SdmOUdvgAFsk3jdW3EHhAE6bTR1/wKPgefK7Qv+/0N8j9BWlo6PzgLRUVWPCjLzIkrANvmztbhNWz6FJgvOET5YC0tiwOG2OeENNmLB0gpL8qzbhEt8b1IKdarllZaGIQLINMDaoZlaARWht4P/u1y0LX8QaeCEDlEkrgi7dXkEiCpAq5vTJds6we8Yk+4MVBN27Qv0f1GBrZorE326UQ7hFuh1EdJItQZvbw==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by PNXP287MB4098.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:28c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 7 May
 2025 01:47:33 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%5]) with mapi id 15.20.8722.018; Wed, 7 May 2025
 01:47:33 +0000
Message-ID:
 <MA0P287MB2262AE2E8C2765AFBE6D41DAFE88A@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 7 May 2025 09:47:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] riscv: dts: sophgo: add ethernet GMAC device
 for sg2042
To: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Guo Ren <guoren@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, Lothar Rubusch
 <l.rubusch@gmail.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>, Han Gao <rabenda.cn@gmail.com>
References: <20250506093256.1107770-1-inochiama@gmail.com>
 <20250506093256.1107770-5-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250506093256.1107770-5-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::15) To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <5f5663b7-ba40-4bf6-90d4-949532dcd7e0@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|PNXP287MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abd396b-2817-42b1-f374-08dd8d092289
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|41001999006|5072599009|19110799006|7092599006|8060799009|15080799009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXkvMTJqdG9tWkxpcExuR3RSUkJ3T2lkM2x3a09tbmdEWWgrcy9Sb1NYV01I?=
 =?utf-8?B?U0EzVFkycFJDUlBrcHJSc2xhd2gvN3VhUk8xQ1R2bVBYeElDcWprTE9CWGlV?=
 =?utf-8?B?UWQwVTZGN0ZlZ1JMVlFmTHIrTmRIbndPcFpaeHp6RjVreUkwdzhiWGJiOVNP?=
 =?utf-8?B?ZnFTNTI1OVJ3bkxseE1zZWJXY3pNelFOUVdPK0k2NjY5eHc5R1dUMHBIbzNi?=
 =?utf-8?B?MHlLRWpLK2xzazlHaUk2ZnY2ZXBxRlNRWElaemJlMU95VGpRSTZLeTk3T0dr?=
 =?utf-8?B?OVBzV2sxMEtPYmRIaUExeHhlTGNLcTdZc0tLd1p3UlN0SkpXN1VWSGtreE94?=
 =?utf-8?B?NEQ0Y3I3MEVHeEl5MTl6bTZzWmV2WlRtUFlIaXM2VHpzQnZ6cXpxdEpJQWJo?=
 =?utf-8?B?dzVWSU9OM2FoS0w3Z0ZMZnowQ3hIbTU4RGRNSjQ3a3pFLzJ2OVROZC8rQ01Y?=
 =?utf-8?B?WlpXRFEwOFFOTjVFMEtkWWdRdGIrVzA4Z1NKYWtFRlVxZlU5MkhFaDloZ25S?=
 =?utf-8?B?RGFCY2c3bGdJMWRObEJlUUhjMi9ueHFpS3hjSnJCQ0E2aEVqZmVOMFphR1FH?=
 =?utf-8?B?T3B1d2xPVmtZV3k5aDRJVEtzdUFEVi93Smx2Q01oOURyemxPdGdNSCtnL1ds?=
 =?utf-8?B?UG5GVlg3UE15cDhuWHRSaFlJb1l0UklPTVJycDk4b3JleGdTcCs2RHB6a1NX?=
 =?utf-8?B?UFF3SldZMU1FOWlaUk5OTW9vUHJTNW1ROGtyQzRiVk5BNVQ1TnlCWEYyK1JS?=
 =?utf-8?B?TGVlbEZ6Ti91ekgydHFaQXBjMXBTQnE2K2JwbURidU03UVNJaDVJTUhsQzRB?=
 =?utf-8?B?TE5PYW5LelF4b1k5V21YYSt0Q3FFTk5rYnNZWVJIVzFJNjFuVFVBeHhYRjhY?=
 =?utf-8?B?SjZoN2l6SnA5Um1vaWRFeHdZQXhHb1YzdjF6alVuU2hiY1lFakRYVGk5bjZO?=
 =?utf-8?B?M2RNOTZnRC9wMmc1cW9aaE9vaUdtTi9iU0s5MCtQdFBBVE1MZzBybDJiamFj?=
 =?utf-8?B?TlNUVXdBbDRQZDNxK3VaZUp5bjhwR3VDbjE5VTlpVERkUlJtVmRDMU51RS9T?=
 =?utf-8?B?ZktLaEhDcFBFNDk2ank5Yk5CdEowWWhsRGl2N2xyUUdEYUtjWnRMQnltRkRy?=
 =?utf-8?B?VE9lSENwRW1CNisvaFNHRUZkb0dqcHU0eWQyeDdtYmtaRDdoQ1k2NWhQaEt3?=
 =?utf-8?B?dmFwMXRMMFp3aG9UMFZwWVYvRFNHL2N2T3BJQWd2SGwyTzBzRDk5U0s1YXha?=
 =?utf-8?B?N2xqbXBzaXNTMmoyRGl4Y2tUT2Y1b2JNVlJsM216UUVnVWtZQXVjMEdBRzZm?=
 =?utf-8?B?bk1jdDZwSGZiU2JGYTRIY0xCbVdEaUhkY0dpME9UU044Z2JzNmRuNk1nbUJm?=
 =?utf-8?B?QWFvaklwQ2VEM0FmcUFtblBGRGJhY1pJQmJEdk9rRjgxbVl3Q01ETGZlb2ds?=
 =?utf-8?B?SU9DRUhwK3NwdlhubmVEdUU1L0RKMVhTYmdTRktNSmVSTDFidTZ1MTd0YUFh?=
 =?utf-8?B?a1J5RUlBcVlDMTVWaGpDNXluVnVvSmxRN3BzY3NjLzdrZ1BXdzdLTHhvRDZn?=
 =?utf-8?Q?8lqU0kvQFoYfcXu6yIQsrPsaI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEhXNVlnN216K2hJdWVySTVkMG84U28xNmV0Ry84QkcxUmVLN0dlSk15QWRG?=
 =?utf-8?B?VVlBcjNyR2VyVDRGdU9MMmVwVlpWWEFPNG5GaTZDWGNuYnFPRDdWU25NWnBi?=
 =?utf-8?B?SjhtV3pMNFN4UFZvdndibVFqa2hUYjNmSlBONmwrOGdaN0F1Q0FqNXhFUGhE?=
 =?utf-8?B?Z0o3REdYWUNzdGU2STlZYXJCMDFrVFBmMXJHK202MDk1VVdSVDBYZkhCMUli?=
 =?utf-8?B?RkNockRHckVoU2NUTVdldStoT0JRWVhVY1Z6Z2F6eXlLWXJiUzVMc2lES3kv?=
 =?utf-8?B?djRsOXJqQk9Ga2poRUZrbEJ3TUowYS9UWVE2S0ZYOFhETFA2S1h2dXB3RTdC?=
 =?utf-8?B?SnIrU0JCS0NDQkhnRXhvRHdSZUF6dEFJUlcxaSt4QnpBY0hRV25BeFhCWlp4?=
 =?utf-8?B?Qkh4VnNaZ1B1dFg1WFBHQ2VWTFVEMDlEOXlselBRMHp5eGxSRjlpSEFTY2Nu?=
 =?utf-8?B?VGNSZ2V1bTRhYVhlYlZvNS84cW8wQ0ViTHJvb3dzWDNyMUk4Rk1SckNDUDJa?=
 =?utf-8?B?R2s4QVUvME1xd1RXN240d09uOFROOGh6a1V2aFpCcTVNd1VCK09OZ1dKOXBm?=
 =?utf-8?B?a2JqMkwwNGhjaEltNnoraTYycUg2RUk2U2pFQUhxMVo2Qy8wUXBhZ3VMUHcr?=
 =?utf-8?B?Y2luN25lbVNRN1M2WFlmSXdseUp3V2ZOTjBORkZQTlZlY1Jka25pcjZhaHJW?=
 =?utf-8?B?KzMwQUpoYUZUeVlpVUszQTFxcHZIVVFvcVArTUxNM0U1N0xwNjBlWUpMY0N6?=
 =?utf-8?B?OVJDUFA2bG94cUdydjRKaldnRzRIbS92NU0zSHJGNVR1bi9vc2FrbUpDME9i?=
 =?utf-8?B?OFZ3dC9uVEtzRTA2cXMxRERONTdtM2NFeUZaNnlla3FJSm5EMUJKcWxKK3k4?=
 =?utf-8?B?SVI1TzZncWtEcmQ2K2ZwcThVdVVJMXNlelNYY05oR0QwYmVNdmdVU29TSnJy?=
 =?utf-8?B?ME85LzNhekNXS2J6R0tDWHova2NlQ3JuVHJCNlY5YUhjWWtKYy80Y29wWFBv?=
 =?utf-8?B?THptOXphMXJiOHQwNTBDeWQvdFJIbjcvZ2RvMWdEbzNQMGRjb3c3cnM2c09W?=
 =?utf-8?B?RG1mb3hpRzNoWlZtSEduUUx4TXNuamxNL0F5Ukg5Z3VqZHByMDNiQUNtbVhu?=
 =?utf-8?B?YTdTNEpzejlya2xBbUhkQkFkUmhSRnlqaTI4RmtRUTJyYnRJdHNta21GR2ky?=
 =?utf-8?B?UmwzcEFIalV3NHBpdzc0NDc2MEVBeEFKYU1VS1FoSWxMK0NYOXc3K1ZuVjhX?=
 =?utf-8?B?ZTdqUGNocVA4K1NhUmhvbzJDNUYycHlRTm01bGFjTnkwV21tMnlvOGRsN3M2?=
 =?utf-8?B?Q1hCSFM5cFcyR3BZVEt2eU0wbUdiNU5DYjg5MGxRTWVtNGRiUDM0VTV4bHln?=
 =?utf-8?B?OFlzNFhsNi83MW81L0E4ZXN1Sis4aXBKOHMyVUhFOFdJOEpWM1ZEOXFJNStJ?=
 =?utf-8?B?cmg4Y281U1hKa0lHWDZQcDBOZSsxY0Fub0s3cWhidGw0UURBekx4aWNYaGtE?=
 =?utf-8?B?WktuMGhWSFFoamxoMEZQU3czeFR4R2lrSlZ4Z05FODhrRjIrNFBjU1FrS1l1?=
 =?utf-8?B?cWh1ZCtPYVNqdGVLaTQ5TjBxVnI0dkNTUGdOdG5Ib2cwemp2SkVOelkwcDdj?=
 =?utf-8?B?bGdZNFNZMGtBUDNWNlZnVzhLU3JVMUs0cjVTKzVxV0l2R21SZXhvYVhzMlR0?=
 =?utf-8?B?a0Y5UzBPQ2xhd2FuSk1KcTJtcitMbUVzcUpWZFgycmFOcDQyaElibWhPT1BR?=
 =?utf-8?Q?JujeHV2lWdKHabNqj3yFMsEsayX/j6PbzF7Y5eo?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abd396b-2817-42b1-f374-08dd8d092289
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 01:47:33.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXP287MB4098


On 2025/5/6 17:32, Inochi Amaoto wrote:
> Add ethernet GMAC device node for the sg2042.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Han Gao <rabenda.cn@gmail.com>
> ---
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 62 ++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index f61de4788475..886c13cef6ba 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -543,6 +543,68 @@ uart0: serial@7040000000 {
>   			status = "disabled";
>   		};
>   
> +		gmac0: ethernet@7040026000 {
> +			compatible = "sophgo,sg2042-dwmac", "snps,dwmac-5.00a";
> +			reg = <0x70 0x40026000 0x0 0x4000>;
> +			clocks = <&clkgen GATE_CLK_AXI_ETH0>,
> +				 <&clkgen GATE_CLK_PTP_REF_I_ETH0>,
> +				 <&clkgen GATE_CLK_TX_ETH0>;
> +			clock-names = "stmmaceth", "ptp_ref", "tx";
> +			dma-noncoherent;
> +			interrupt-parent = <&intc>;
> +			interrupts = <132 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			resets = <&rstgen RST_ETH0>;
> +			reset-names = "stmmaceth";
> +			snps,multicast-filter-bins = <0>;
> +			snps,perfect-filter-entries = <1>;
> +			snps,aal;
> +			snps,tso;
> +			snps,txpbl = <32>;
> +			snps,rxpbl = <32>;
> +			snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
> +			snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
> +			snps,axi-config = <&gmac0_stmmac_axi_setup>;
> +			status = "disabled";
> +
> +			mdio {
> +				compatible = "snps,dwmac-mdio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			gmac0_mtl_rx_setup: rx-queues-config {
> +				snps,rx-queues-to-use = <8>;
> +				snps,rx-sched-wsp;
> +				queue0 {};
> +				queue1 {};
> +				queue2 {};
> +				queue3 {};
> +				queue4 {};
> +				queue5 {};
> +				queue6 {};
> +				queue7 {};
> +			};
> +
> +			gmac0_mtl_tx_setup: tx-queues-config {
> +				snps,tx-queues-to-use = <8>;
> +				queue0 {};
> +				queue1 {};
> +				queue2 {};
> +				queue3 {};
> +				queue4 {};
> +				queue5 {};
> +				queue6 {};
> +				queue7 {};
> +			};
> +
> +			gmac0_stmmac_axi_setup: stmmac-axi-config {
> +				snps,blen = <16 8 4 0 0 0 0>;
> +				snps,wr_osr_lmt = <1>;
> +				snps,rd_osr_lmt = <2>;
> +			};
> +		};
> +

LGTM.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen

>   		emmc: mmc@704002a000 {
>   			compatible = "sophgo,sg2042-dwcmshc";
>   			reg = <0x70 0x4002a000 0x0 0x1000>;

