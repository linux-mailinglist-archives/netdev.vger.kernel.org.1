Return-Path: <netdev+bounces-67567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7223844156
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 15:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB441C216E8
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3E48287D;
	Wed, 31 Jan 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="vTS4rGKi"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2161.outbound.protection.outlook.com [40.92.63.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDD812BE84
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709962; cv=fail; b=Mr7xLf+vjfnxPniwCV51M0hcNtav4N6/hXB7JM2rDdmRAdcKovZHqEcct7TkGXYhVU9VANnfc6uqL6JjVuDxwO+EUJiTDDy6zfSzmGD9rJB2f+ZhbCXvZbP5gKPQH84FkFGbKNAz3RIddbZlAOFxagGYbdmmRRxB8Kee4x6ivnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709962; c=relaxed/simple;
	bh=1slaDxYmcd4z2kQ05Mld8kYTJ8CBuYnHkRr5wcV5CIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CvuSCuTlsvMCoaKuvKPQHQgyMxGu/rPXQ0UAM6beK+xToXM0ckKwdzi+XiPgYgzdtV5A5sBskMeBpG7HSVzWXNcz9oZkVjEum6miaOEHRmaP61rpQA0r/XGNON7dTKiryfGMS4B97PkiSQI9u0Ol6gdzwqaBboHEP2mQ976gb4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=vTS4rGKi; arc=fail smtp.client-ip=40.92.63.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H01vYORSERipV6ZnUnpxI00XrUhg0KGIsYfH4CZZDOwoSOQ9cz574QMAndvE5YGzk9clSy/wvkWT8N6pq/5padI8E6/LTa3JoQkENZhTAO2J+Xywki+qiWOXM0riSTX6eKzDXhiMTG6w3ERSxZxV6W87v3qxDHx905OYbtHo17ITqmMKAeBO4nXHLuvykFTFT19gdSQZg+losTdPkxzwLbppWH0jkug/Q8r4oeD9fdz8y54WySgUMZtlA5bAUes5dOHACJIZ1ZgAVWULDtIRgxsZPTClW95Cz7VESKnnrcVwEKJXAqnvEyuOAan7qjDMyw6v13yP3t8AYwSMVBa84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJvPBHaXWrDoqrVadZyoD4ffiYVVF3OnA2SGtr9rsn8=;
 b=FxjypyOnESArLO5jJXMvSLmsxbKu3a11FgfZFIcQRtWcLWYpo+4sr1W7o+YqU6gh+yFA60qnRz+KPItz3EYe8fCeILbcbenyafndzQ8+ttHgbfzm0BKEFz83DKFEB6vNWXj6Wsqau4TyLoT/H60VA1J2j9TYNxreLw7nvNzwsGTUKgCWz7fWZ1L0dllLG9iZidcjNJ2iwcATEULwiJ43/t8JsMR3zER6UbmV3YTuNRR4/QywceX+XmUA6eQu116csuPW3DmfS6U+fQXJ7b0tF1Zg88PdJWU9/PUpBR2ueE2hGg2OC5mdzTOFU/n+4iXdNb/PPvW4egESXbHKxDjCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJvPBHaXWrDoqrVadZyoD4ffiYVVF3OnA2SGtr9rsn8=;
 b=vTS4rGKimGIxjve+yuD5jUsZBWHIUUZ4LsMyZBF5D0eA7WmgcK/EUBk1cRd/TBZQmlCr4/A8/MYwmmPpAB3SYaUbXy+GqFgVQ8zvvihknIhMvKhwMNQKXAS3FTCW7uY0NBlju9tFsYy+RzKLSbiDuwyNmmiWYFwkJGqeDHi9fkTI/tdak70Ep2j8lFVadGIqfNFmIo1hLHAoMHPWwrqCsNmbaeGBZxPx2ivYFAXoPBf3RFCQffWI/YrwT/FWO9x3iOWMphaJVpkeU3fdA3TWnxfULrqkcpky5pb8r3tA0qhrND/A28/BGtbIQXtpMObnbjvL4BdG89+UUSCx6j7uVw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY7P282MB4777.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:273::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 14:05:51 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 14:05:51 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: pabeni@redhat.com,
	Jinjian Song <songjinjian@hotmail.com>,
	netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	felix.yan@fibocom.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	joey.zhao@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.com,
	liuqf@fibocom.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	nmarupaka@google.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	vsankar@lenovo.com
Subject: Re: [net-next v6 3/4] net: wwan: t7xx: Infrastructure for early port configuration
Date: Wed, 31 Jan 2024 22:05:29 +0800
Message-ID:
 <MEYP282MB26970D9BA7E93D553283DE2CBB7C2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB26972B5DA665DF10282EB108BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20240124170010.19445-1-songjinjian@hotmail.com> <MEYP282MB26972B5DA665DF10282EB108BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
Content-Transfer-Encoding: 8bit
X-TMN: [+gfDFRfEZXYJR0PYKmO986dDMVmpHuF1]
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240131140529.39382-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY7P282MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: 1209de8a-a7b0-4f44-a869-08dc2265bbb7
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3gE/aWlXKmkCxBE//NgnKDSvReiiivl+HqBC7SCZwHW1IxlFQpe3BYT9ghBKbqVkkDTz07i/PnVmDP14pj+9zjaFDwZ3x7475UnB29R0bnfpbjclA4FSnnwuYnC/2DT71stGJTu8MQmjDOCWR9o6D0oy9da4UYdxvwxkfXcigAuerI88yypjiBQNjsOqbSaEjAtAVt9nqdptrOWtcRKLyyj+hdZ3CFpDvKzPAHCVVwK7DY6BRlMrhFSnxsuXak9rH0oAbtRgstKucgg9S5odxlXD/ZiCsMABKOYjQ/c9YYIpvyLoSIZaVu3/BAqcZzq5ngz7tWHmuACEHtpxxST82MMRJIrFUPQDPOG631Yc706q50unKCRfGtj9IL3FjCMkV5ei6ZjDJCoaxtTVlburK/gvxzM08aQhG7SMZcyUSj9JaDYp6DuvqxApjeWKqRh+GbbPRBtD6LwXrJG34zyWylopYG+MVT1Kk/CxJnCiab56Epy9Mz4sNcjeuvkskPNrD3gjjwYMe7uB5+H+CU0oJbvPecG+rAHftAxRFdTfVAYXsfX+SSu0Ib99WQhGj02XOpK3bB+NPgYfbYe8baJOK3tn1B80q/txcCuchOfO9GjC70ANbyNLU94QDwgxvN1jZDigOE3AFLg3e8XliLQvRizOPQ2hD2sXV7jcIwR+mnNNxomAEuDW5XXiTx+zLc41qYWRjIsZYRgYNye/2Hu82V2q8hChmPiLMnX+sPrMswKrvvPOziMpOGvuF41dgJgxA8wXcR09hKCfY5SMaKGUXo0lc253AhsuH8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/oUPF8Jvx9whRTZfD7arcknZXGxSkYURlbvxMrD3EF+1P1ZYLvHowM1J1tZCikKwtR3DSfQB+XlJfjSV/ArFaDdh3Hho5YOC4w6rQ+dYxuXDpOZnRcmmG/hQvrT9XLeOTD4YZY0IfAVwfb89AjN/Prxg1bSmidYp9JT2pJJGBGBzAQ+UMRpwQa+QnYztg6QUydedWxSJfkQ5fQ/rPnLeDE2irfDPWVLvGO4NkKMqVD1r0LRNlej1pgXSyH2gYpRi8nM9EHk2rEwOYFU8IerqwyCIjP0MzKADdzr8vp3ObMszamFsqXQe/Yn74szi5I4EbZONWiBe0lAiv24OrAAeAjE5VXdc1i6xj1xY7tA5Dv1onBjp0oIw82PNTy6uJW2K9yyAXvOje6Gap6FtlEi1HtKFDMzzsoKCty4O4KMNo5DpLMwThnV0Z23xxJpnODnVcAaQQn0HAtbADc1DUVdiECT9GEq+FxAlpIofPkX8+VOQ9jFOF8tYl8mEtYASCY6Me6hhw/LJrWgi2tj7EOl/rcjIy5NYebYXs07Q9LUi4o9crfAaeq4Swol5rF0eWfFfOUvfLehfr4uQKZs3t4Ye/+r3IHjHgxvMWgn8rcRQA7o=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUY5WUZ0V1lKemNBZTVwRUtUS0syYVcxY0NrbGMxalpZcVdmTWdxZjZFOVRx?=
 =?utf-8?B?YkJIa1pMSFlDb3lSb3ZFRnFRRGgzT2wwbWV4SkIxZDRwajR3bVdacTR3QjVa?=
 =?utf-8?B?bWI5Qm1wdURlQWU5L2dPYVd5S2N6ZHdadmd0MWpOQ1Z6MmxpZGxuS0JRaU4y?=
 =?utf-8?B?WlpTbzBtMmcyVlB1TnQ1VzFWbWZ2VVMyZWNQZFBaYjRQSDRWNWpyS1JuRGU5?=
 =?utf-8?B?eWhkTFZpY0l4UFFFWk1tN21SbzJHNGVGR3d6MW00TzdWVEVZa2JpcmdSMjNP?=
 =?utf-8?B?enZCY09wNGpUVmNVdEZWNWtTWHdBak12OC9MZnlyNndqQWxpRzVBUXVCT09k?=
 =?utf-8?B?Q09iTjBJVFpHRHVmSW9aSFBTYzNacFczNU9SR3VrNnZ6T2U4bEp1T3o1Wmxz?=
 =?utf-8?B?WE5heU8vbnJhalJWVk9USEtHVkZhazJYeERPakxHcUM2QjVEaEdsV3REL1Vz?=
 =?utf-8?B?UUMzeklzaU5OWW1LRjBEb0VvOXNlaEdSTnlzQ1cxdmk1MEg4WTVReDNycDlP?=
 =?utf-8?B?MlF2RHdmenhwMEJ6MmRJemVOREVzemwyNjZGNTlOaC9uNk1KMTByVlhQRndy?=
 =?utf-8?B?MDJxWGdzZzRJRllPSFdZYVc1M0x5RjlpLzlFVTd5OUYzanRxdElsb3NOMTI4?=
 =?utf-8?B?ak9ycWpQdG10U1BJVGd3SS84b1VOd1VIZFBzWk53VTYwdWNxMWtZWkVyeVY3?=
 =?utf-8?B?Rm9KRkk4VGZpV0RGM0dJWDRaZzdMN3VpVWtYcThUdVNGSjZwaEc2ZHMyWU5h?=
 =?utf-8?B?THJwRVc0NUpQUHd6K0pINU1rVW9zWmhoVFZPV1NYbjMxWXVjMkluQkxFK25a?=
 =?utf-8?B?QzNJdkd0RWxTMi8vZXNZNk1Qd3A2UDU2RTQ5MzBRYUhha25ra3hzYm1GZk5r?=
 =?utf-8?B?aitTeXlRRUVxVHgwcjNGQVErWDR0VnlnYzR6M0YvcUNtUFhtTnc0cFBobzcw?=
 =?utf-8?B?clpBY3VnaXhDcVNwRlVQaGFvcytSQzYyWE96aEk3RUczTzM3WUhOalBWZnBy?=
 =?utf-8?B?MXJsZnh4SlBSUTU3NlFTVGNFaVBScXR5SDlBYVVlM1hYeWhJK2V1eE1Sd09G?=
 =?utf-8?B?UFpVbG5XbzYzVk00d0dJVEcyRUJMYkhzUy9FUWdLVVBvNld1cVNoVzllYlRD?=
 =?utf-8?B?SWlJdzRlZU9UNGJzaGpwb1phY2dqclErUkorOTNFZERhQVRIemZJYlVOTEs3?=
 =?utf-8?B?OWZobUFUYTZsL1QrS2ptZlhHMGlBUFRDdWhncEo3bGF6RFhuaEFUdVVCaG50?=
 =?utf-8?B?dytnTEdjZEQ2TG5kcVFHR2hTSFBOYXZYTTBrZlVwYWI1UnlCa0NGdDNJanBx?=
 =?utf-8?B?cDlFcGM4YzhHMDMvbTZ0OHd6amVyc2VzV2xJeVcrcjArUlRZN0N2L3R1SlZG?=
 =?utf-8?B?YXgxWlRGaXFtc2pja3hIQnR3cE44OHVmOHZmbW9SZEVZU0wrSmg1Y3piTHVp?=
 =?utf-8?B?TmVGdFJ4Q2cwdzJIUWxkRWNpVzhuVTV0Z05KNGF2SjVUSCsrWTBodW5DUUdx?=
 =?utf-8?B?d1I0QiswS1U5V2NLbUlQbm4xVVVMRHVBaVdFa3FNZWZsQi8zSVJGS0ZZNXdQ?=
 =?utf-8?B?S1Y1cFFXS3lreG14ajBzYVhvdktOS3F5R25tdVFFU00zYWl3dVIzSDRoak5I?=
 =?utf-8?Q?Tfl/k/I1dvl4LxFDQ1csCoAkSr454TLMs1x2AwNNtjkM=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1209de8a-a7b0-4f44-a869-08dc2265bbb7
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:05:51.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4777

From: Paolo Abeni <pabeni@redhat.com>

>On Thu, 2024-01-25 at 01:00 +0800, Jinjian Song wrote:
>> From: Jinjian Song <jinjian.song@fibocom.com>
>> 
>> To support cases such as FW update or Core dump, the t7xx
>> device is capable of signaling the host that a special port
>> needs to be created before the handshake phase.
>> 
>> Adds the infrastructure required to create the early ports
>> which also requires a different configuration of CLDMA queues.
>> 
>> Base on the v5 patch version of follow series:
>> 'net: wwan: t7xx: fw flashing & coredump support'
>> (https://patchwork.kernel.org/project/netdevbpf/patch/3777bb382f4b0395cb5>94a602c5c79dbab86c9e0.1674307425.git.m.chetan.kumar@linux.intel.com/)
>> 
>> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>
>It would be nice if someone @intel with knowledge of this specific H/W
>could have a better look here, thanks!
>
Hi Paolo,

Intel team handed these over to fibocom and this patch was reviewed by
them before, I think they shouldn't be responsible for t7xx driver anymore.

Thanks,

Best Regards,
Jinjian


