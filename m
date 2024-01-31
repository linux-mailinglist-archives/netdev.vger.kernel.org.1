Return-Path: <netdev+bounces-67568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B4C84415C
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D954F285979
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4520779DA0;
	Wed, 31 Jan 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="S1a0PXNR"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2166.outbound.protection.outlook.com [40.92.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5919380C17
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710026; cv=fail; b=RRinkralOpeMMuI4q6BzDEIil4eF+sde3t+w0iJ3YKQxGYWdFUUeoAGzRWvtkVobYXM0JdO2nYVc4RrgGTXMJYk0r1hwJ2s7hEmjBeEmvLO+Up+Zmps11ArqgQfllsJiPZACRPnU59qM3gf0wjPlFE3hD5VdrTMogPFVQQt8pjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710026; c=relaxed/simple;
	bh=USJjapWj57+duoftKq0qJkEJJ6bFQWnoItH8Pt2M+d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XbiXJ/3CbeOH15dxjMya9ihrllUkjMSAmYMGaMs38XWIZw140GWcrHiKlGl3+fYOUGewN/heno/8le4pFWYixscpapkuJLmQahJdHtdO7H0KvlSMogK4ANIlEY9LzuNwn9gxvo9TKHCN70ZXuWOwT9akL3cPY92GW0/nrwngp5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=S1a0PXNR; arc=fail smtp.client-ip=40.92.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8pfohxKbymgIx8Pz7YEnlAgNiBBamWK6ciuL/+BUMsPdD35UXGukmkL0LZT3daIOEmJn6ijoA6WMGJa0h/FgnrTdNyRfmFFCEOyAy93z+2A9kCnsg3o5Ry+eWrROeCOBJPP99irWB7MOrRSXeDh29D8WVDq6k9E2rHH9U1ElI4Q4gJCRo3Leiy6vZovsjcutGPJjkt8chRx1X/9LFn/BOQfE3t8JPSLJF3/QU4tsUXxo4Y1VN4yJBC1nN2IfUnEim+h5g7u4ftdeTvULOkL/9Ae6JYWpuSYiPN5u4PvJ83kqFsOAQXeODA+IBWhZcaSiZQyfC/UzyPhB3aVpa40pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qVbiGssZffb6CC4EU4iMmGUsqsS8e/BbUPtep4Twj0=;
 b=g/+GtEzATSOMgAClxrgjG5a5NuZCgAl/4zVuFce4sWIQDvYS5Ag0TQAMYoM0hzE+K/3AKlTl70l/op4MLVBcF6H96GK+gYVk3a/59Ne2z+ULJS+sUFCL4mDxLMTuP/ZmGVfBzk6n3W7hvUA1IipQn63qllCwxOzfFakmUBL04j4ULHvABSQnfSfTrS9GqyreRwD7R+9zNqiZEcWcYhXoz9TC6ereOTHslR8CKf6fxJjElW29AvM3LvG+yZBhbqG4e7TJzdCR8o7EDKfQgkuPLs/1wjJTm19+wf8Ks3bfJJX3LIl60Ys5u3H3XGmJju74tnv74bun9nf9akAsto8+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qVbiGssZffb6CC4EU4iMmGUsqsS8e/BbUPtep4Twj0=;
 b=S1a0PXNReB2oixICc4bu4I6Hu752sRtcttMmWiSls6I86Os5F2+VZYW+szmtcv3Rbtx9q6PXh82HujyL8A9wEgGep2UXm53t4Lr7b35zZHhBsbe4ryOoCdLy7BmXdNC5vSiiR/8/WkwMH1lR+eGb0qkxPSWQTH2RZJyNJME9uz1RZX/BwxSOXm0fBGGVeFcAVgk74slhpB5d7HVkg2Mv/AH2+Am03brZrtdlzJxLRqBB/ILNNONKn5DNKZvWFvMBKdfk4p+D+Tww65QdEv+bz48LUgKpMCfnjWPCkAPSEBEcPYOsEKlwwgciq0FEDpbcEnxfTkwKg0sL+e0YCpY7bQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY7P282MB4777.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:273::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 14:06:57 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 14:06:57 +0000
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
Subject: Re: [net-next v6 2/4] net: wwan: t7xx: Add sysfs attribute for device state machine
Date: Wed, 31 Jan 2024 22:06:34 +0800
Message-ID:
 <MEYP282MB26971144401D483B2C947180BB7C2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB2697447F0AFBA93A9033DE23BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20240124170010.19445-1-songjinjian@hotmail.com> <MEYP282MB2697447F0AFBA93A9033DE23BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
Content-Transfer-Encoding: 8bit
X-TMN: [1FoBu5yx6KgorXs+W6PVPaydQBjGulfv]
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240131140634.39399-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY7P282MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d377ae6-d100-4d0f-9710-08dc2265e2b6
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQAWp67Aa5r2XlO6c0JencQZS2qA6ZNJ1Jkssfxsm04up8qBkn4ftAy/wcpqwTnTLU8WXbKCQbXaAdOWc/T7ykqAHGsdZ7LkbJHcoso/sguc6pK5Wsr1uy6Ks86pEts1L22Dk2++pTgmInLQoHRsL2ci+xS/U9LCkORiPAy/923is40Bn6E1wDC5sxK0fdkCr1n+zc2ZiXC/sv/ftbK0gGTIYCeRxeaz5kVZ7rKyLQXtI/MRKg9odM4w58GLBgXFl13ZMGrqF7TS7DUIqR1PHId/K2jg0lOL2mdfZrxEvuuSE85/3WsS//bupu4IeYwmA8frf77fBCl/O6tVRu4hmtB256UmDm7Wi/qFPGTCIblrlHIFZoi4X2J4fDCSrGq0OEeA3MhqbQWdMo7PuNlrqpE+FUrO6sad/BSfzfcyyPCABxJOhyrFhi0NFGFxytwt9O/P61WiS4aI74AG7YLBy1qqDhQoJSzEMl4bDv9ZFiOgdJAFPD0IzoYta5Rjj82y0hB6nI3lEzIS6yaCpO5jupN3s44dIfEJj4ib9Ex12FEzzqNcT9wtrcAjd8RaYqG/C4Rgvaye6lrEei6wbeKLCx1IGqLErWho/FkrXFxXAgzA2eFkGjlesvkZazqttEH+YYlFltsxDZevhR3xWKUrLHkE363j2AysZ/sTpZpeM4AjlYdXNv0ZaEI381WfP+BJ9dgoz6J76WEUPS/9meiPybCHR0fDpZfzM20/X0gQw1+QJYuyu9DqK1O/FMBIXbmEKkhwGAwml5kECFFeNdZjYmdws9MWORN/1N3Jnp9kgQuRtMz1sHzMbrjd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s5ZKQBpjuTg6TxxiWIKAeB5pk0cDwKMOqSGKaxd0B74YTx4BJuJt8As1A6mfxHz9v5R/xDfJ+DrZTc3K7N8iPQTt9igu2OdeKlWly/VVcIt8K0qrUp+lKlScBkRGr+e+rzY5LQkEnfeG8GZbHRE/N9zHGYkP2NrgYgJFlcSHNxl+kfL4z648a041uXsLDIKtruXK0LFtnmUdZS2bqQVm+Xf8OZr+UB9jwe5VobwFdDiO1Wmtxi2iumZX2+5vwaLq87iqP2OvxMkhF9btHt6Sc1KW3upuNrZm4LqWKTWxfiqZxWeIKnzwEn53O4TxUgTchDUkHK+UFNvaZCVPuJu2OaWijL0FKyNc2SfytZNmQVjI6C7r0gltM2g3Eo+C3kQ5+ePsb6qOWA7SPTUljMiZX25hKlib5Ckhak/koe1mgmHDTe+z2lE9vm1h2wMCWPyYJ8EqlpH15ISPBx/U4pcNfyl7V4znjQnlxstJHdGPrN/m3bajUPMnKtC4PqUjZy133jgrYuuVZ2ydRH/USmSl6iUAuh5JQI6hyWW5FZlqz0dkdKl+1aE7PDgFby6WSAvLbAQvAJrR9rhu0LgheOlZF/8zY837Tr1cT6tKrFwGVCmnYll17mK5HVuHhg6Eiv2n
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFovYi9SOXhBby9LTVk4ZXlsY3N6ZktCeSt2MStwbUhmK3NGdjQrWUJpSnc2?=
 =?utf-8?B?SXYrMXp5UWtaRmtFQ2toYi95NS8rajBGUmZudXJlQUNPamJadjBjVU1NRXA5?=
 =?utf-8?B?ZVR4ekErUFErbkhqallCOFBSRkE4SnJ6T254K2JNM3hnRys2MmFrMnhuMW8z?=
 =?utf-8?B?UGR4aGU0K1czN1ZSSnFJS3lpV3RxMlUwUWRva3hHcllyYkNhVDExZWRvcndi?=
 =?utf-8?B?R1J0Qzd4aTRuekpIN3EyelZ0dDkrM09la0MvaEZFYndGdEhhUkM1b2tGVXBQ?=
 =?utf-8?B?dTVtSGNONzFZTXlMRnEyb1QwQysyckV4Tllrd3h5bjJVbDdmVG9OZnNmblR6?=
 =?utf-8?B?ZWtlYTZ4Snl4MVh4WnhyL0V2aGxtaVEwZHZSQW1EaG9YK3lFelY0QlgrSll2?=
 =?utf-8?B?OUxWeEQvQVFNQWw3Z2gzS25RaTY4OHd5QlZJQUl3Z2Rwa2tJM3habG1qZXJB?=
 =?utf-8?B?UXdGbGZLb3B2OCtabWpmZG1ra0d4ZFkwdWZUbktuek4vWCtFSEhIajFneDZW?=
 =?utf-8?B?NnYrYWxJY3FLMVpYWjFyMURZR1BXNUI1TDllOHA1UXRVSUwxdWllQ3BMUjh6?=
 =?utf-8?B?Ykx5eWYwMUhyZUl0Wlc0bDdsRVVKVURCWGRqaHI5bjBRRnFMdkFXS250elBN?=
 =?utf-8?B?bEVoV3pkMWEyMTNkWTU2em1Xa2JidkgzRzArNHdUSU1jemZaOElYcWIyNCsv?=
 =?utf-8?B?OWdMZ3VIQzF5UTVSV0l2R0l0S2k1L2tleFRVYjhBVUNpOGtmZE9McURDSGF2?=
 =?utf-8?B?OVhqeW93eFBRSlNTaGt3TkQxaXR5K05ITFk3UDNZN01RS2xCbER5Nm9oa2dL?=
 =?utf-8?B?SGZDVkt0a1RBT0xDam9LSFVrWE9rTW1BUDFvUUdDNlpDV05YYU1wbHc2eGRz?=
 =?utf-8?B?ZHMyYzV0QjRYdXBVbTYxcW53aklYZlQyNTFrd29zUnpRUURJVnZ0aWtoT2kz?=
 =?utf-8?B?VzI5R1JKQkxCMjVrTVcwN3JBcTNyWmZqUUpBSzJuY0NtUG8veTNJeXgrZVFD?=
 =?utf-8?B?d3lTd0g1Q1MxeUNmKzJxanRRY3lzb01Gb3piMG9UVDlxbzdmTE11S3Q1STFF?=
 =?utf-8?B?blhLWDNCZUwrU1hJcTkyN3llb3hwbktiVzV6c0tDWENFNFp3a1ZxdWhlTk02?=
 =?utf-8?B?UmVEaHZ2OGVWeHQxQ2FTUUdxcEhxd0JUOGp1REJSZFRUMWV6RUp4MXpTKzhr?=
 =?utf-8?B?ckxFem9GeDVGTzk1TU1QcDZ5ajhsUHdFdk1JU2hneWVFM3ROcmFoSjNSYkNj?=
 =?utf-8?B?VzFQOXIwTldaZ2pIQ25qRXUzM0tuS2tEYVdmWEl6eVdWb0R1bTNWQUFYeGV6?=
 =?utf-8?B?L0dZNXBsbytiaTV4bXptUGEyTFlDRUZhaVlLVGJRWFZDOEZSNE9QVHhhWEZ4?=
 =?utf-8?B?RC9ZYzU2MXdQNys5Zk8rOG5wVkk1c2NNaUNOSnB0TWpmeFNSajdFWlpENDRH?=
 =?utf-8?B?bnNtS1FsWklUS3dZVzYwQXIrdXk0MHg1Mkh2UTJTL1FQUWNCNTZmaFBrMG0y?=
 =?utf-8?B?QjFuaXZKZ0xvRy8yQ1dHS1R0ZWRBRGdKd2VQd1E1VCtWZlBCUHd4ajNSYW8x?=
 =?utf-8?B?UHYvWk1YWEV0WC9BVmhqN2RWdXJaQTBsbTdRTGZaVWVVenJBT0ZidlZDeFRt?=
 =?utf-8?Q?JV7iwozn5eXzDPLWZKl68H6mYJfOYlr2bsKdSsq1pAvk=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d377ae6-d100-4d0f-9710-08dc2265e2b6
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:06:57.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4777

From: Paolo Abeni <pabeni@redhat.com>

On Thu, 2024-01-25 at 01:00 +0800, Jinjian Song wrote:
>> From: Jinjian Song <jinjian.song@fibocom.com>
>> 
>> Add support for userspace to get/set the device mode,
>> e.g., reset/ready/fastboot mode.
>> 
>> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>
>It would be nice to add a reference to the fastboot documentation and a
>more functional description of what can be achieved using this new
>interface
>

Hi Paolo,

Let me do that.
By the way, Add to the commit info or the t7xx.rst document?

I want add the fastboot document link(https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md)

I want add the functional description use this sysfs t7xx_mode
e.g.:
1.query the device state mode (READY, RESET, FASTBOOT_DL_MODE..).
cat /sys/bus/pci/devices/${bdf}/t7xx_mode
2.set the device state（cold reset, switch to fastboot mode).
echo RESET > /sys/bus/pci/devices/${bdf}/t7xx_mode

is that fine?

Thanks.

Best Regards,
Jinjian

