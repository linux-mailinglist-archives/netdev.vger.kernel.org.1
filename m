Return-Path: <netdev+bounces-126322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CABB970B81
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 03:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA88DB21AC0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 01:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBC81097B;
	Mon,  9 Sep 2024 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Wg3q6fFh"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF918E29;
	Mon,  9 Sep 2024 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846489; cv=fail; b=bNDdpyKy4Rqwg3xYXkWMJdxJWzWbpUx/cnfTFe3xjn8bBrdALsG2Bz10U8vqjC+Ho9/0kuTPZXOMuWxnQFyYD6SlLOzMxWeQBavBXkZxn+hguVgB37BT48mxonIlJGPgJTYoeRhgBlBOSF9o8VDjCAGchJEf0jjNdrCpllS74XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846489; c=relaxed/simple;
	bh=e6/JT6dvxGYWmvmbQawI7JZRzBnELmE+ee5atz0lGKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e92DbwMUizjietz7IClT0gdNjobLFiGAQdOw9xdOIDOFriRwRcvF3UZcuBTr1UKfX6/p/DSfMmQDIk2XyNuXdeeIaqMPncHvuggM7HJM8gdK0V8ctxk1pjQHPdEoitFkSqXlQw+n8wtmnMqFtWY4uVWgIWKrRtXeLuUkv/uV204=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Wg3q6fFh; arc=fail smtp.client-ip=40.107.117.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfuFKPQ00mHr1wQov03tzifKkEOwlYhTe7sEplZVzNiLggcE/wQNySTABhxnir4PaJiNoc1gdlurBSye8f2FU+7aGuwP/vuB7iGGvcOIr8PTSKIh4df/qoru0GViVdgC03J5Bv/EAMbX/4sL99D8aSSKU8TfIifoexpevD656zJR64m5hyVUzb9ESjEXzzuVpuvqVOVeNgw7xNUWsWVQGFL/0lEsluj0+B6AE5dsX8ieEXWaF9YC7CBCXZHhGiYvfMZUoRxAbnbmPPfyziVmv1ssaTY/fYCKPKBcJj2AP8mIDuv4Gw5jnUueLPyNpOIbyngshQSBSE3SQzbAyIYzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6/JT6dvxGYWmvmbQawI7JZRzBnELmE+ee5atz0lGKE=;
 b=K+UvlORoGNtpxRLfA7d5bgn9SpTQ6gOPqHVABCHu8lSsFohLrXLmOrPHrBNOx7PqfO63ttukXk7T+V2Zx5sRDteujBdwR+uEIdam+REU3Bb48tXNnO0b7ButeJJhhTUhCdM+t181IBg3kQ+9KlU7tpAa7nItfIz2wujNt3cIeB+Id9hgUdMN4rjqaqW6+FULu5jda19qiZQJASSit3KJJsR2MbIp2oWNwQ4XtT3/kl4NfH4ONtpksDYYcJQuO5ObYZM0er8WCfi/AZXaB0rc6nE7m9MTkAcfccPZEk/0vXcmXH8Z+5PlLMjrOrIRCjwjS1khzwPA0yds5/Rnq0WpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6/JT6dvxGYWmvmbQawI7JZRzBnELmE+ee5atz0lGKE=;
 b=Wg3q6fFhILOlSd8YWJxbUlDTj3pgK8NeG2FNo7zg9sDmlLueAwPwaPSXu/58OG36/SC05fbiFGVpua2sWbSejppp9TifvfxhkcZwI79CKGRhpU+LezRUJObC1big8yL1FClu1f9ts6eYArWDOeJRBWITon5KvOHpoGyLDN5QJk0lE32JZI+r9x4yY4CGyB9Zjzd3EqNRRai+Sm74MpRh2ep6BTJ38wrB/oq/NogqwZ3fc8+cQyloLHxxIMnm3ocPfDkuLATqxe6ohy0dPQMsFXAILp0lHaib3vUg9Xi2pVmcNgCtRYmX7HHJiYyOWza8prpbdosA5JFebodc2t0xCQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6262.apcprd06.prod.outlook.com (2603:1096:400:33f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 01:47:55 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 01:47:54 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Dan Carpenter <dan.carpenter@linaro.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Jacob
 Keller <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHRdIG5ldDogZnRnbWFjMTAwOiBGaXgg?=
 =?utf-8?Q?potential_NULL_dereference_in_error_handling?=
Thread-Topic: [PATCH net-next] net: ftgmac100: Fix potential NULL dereference
 in error handling
Thread-Index: AQHa/1rfMsgzpIAVIUKgpr/yLMfBE7JKRNDwgACk0ACAA8oWYA==
Date: Mon, 9 Sep 2024 01:47:54 +0000
Message-ID:
 <SEYPR06MB513433B0DBD9E8008F094CE39D992@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <3f196da5-2c1a-4f94-9ced-35d302c1a2b9@stanley.mountain>
 <SEYPR06MB51342F3EC5D457CC512937259D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <6c60860b-dd3c-4d1c-945b-edb8ef6a8618@lunn.ch>
In-Reply-To: <6c60860b-dd3c-4d1c-945b-edb8ef6a8618@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6262:EE_
x-ms-office365-filtering-correlation-id: 34b4b4de-e802-423e-a195-08dcd0716c6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RDRHUEovRTdtTjc4alFIeTh6QUJ6U1Q0WUg3S1oxc0QzOGpmckdNMkV6WHJK?=
 =?utf-8?B?R28xc2lCMGhRd053VTk5RmtoSXl3bDhHUWt5QSs3T3pSMWtLU3dWcm9pY0lH?=
 =?utf-8?B?MWhQd3QxRml1UzZkSHZZdDVZTWd6elNRVGVWZzQxdDBzWWpxSmtiZ3VxOFlx?=
 =?utf-8?B?d0lRSlBia3BObzJiV0J0bGZQQWpoSE1BVjB6SXZrYkJSbWozU3Y3Y0pNcHFM?=
 =?utf-8?B?SXFOU0xRYnYvOGhlQU42M0xZa21RL21GdlNHU05ZdS9NQnRtUmNVZVkrQTRQ?=
 =?utf-8?B?OVM5UUtDYWFQampMU2ZGUVRDYXhreTZ2dkhySXEyZEhnNktNYmpiMjViZU4z?=
 =?utf-8?B?ekZpZjNyQXNGSDBFNmZ6TkNIb2Nua3VnbVZBdlE1UGdoeldrKzAvbW5lSUtG?=
 =?utf-8?B?RkpKZkZYbUFlMjJUcXY3bWluTUt2WlJlMzRocTU0UTVDbHdobHVhUEhteFRM?=
 =?utf-8?B?Y25MSVM2RStsMUlPSC9wUjF6aGFGWXNVMGoxc1E0N0VFNXlXMjJ1eUMySlp1?=
 =?utf-8?B?YWpBMEIvdk5DUXJnNTUyeWNyNktoVHdEZ2dvRXQ1YTdqbjY1N0JxQlZoZldh?=
 =?utf-8?B?S014UXc4UG1KR1NGN0xSYm4rdjFxc0VudzZjemNFODMyVHBybThONFd3V3Uw?=
 =?utf-8?B?eHBwRGZ2VVI3amlmZk1SVUptcTJsL29pWVE1LzJvR3orN001WnpON3BMUjJZ?=
 =?utf-8?B?NXk2OHNCQVZKYWM4NjlpY2dvLytBbkROWFowSDFzdUtvcFBUa0pEbjdPMDVo?=
 =?utf-8?B?dmtrWk1pZFppRzBUb2x5TXBRTnBMU1dwK1NKaXRkWVdlNlJlRDlQVzNYTUJ4?=
 =?utf-8?B?cXRsWFRicFRKRGVETU9IK3crK3p6MUhLRlVYM2gvMnFvYzNJSGt3bEQzQzVH?=
 =?utf-8?B?Z1B5eVQ5ZFdoUlhLdVI0dDRtS1BkcFN6aXNNSmVyVi9vblVuVEJOamJTQmxH?=
 =?utf-8?B?dWU2OHBjWC91WGNYR3ZJZDFwY2lRUEVhbkgrWjBvTFBra1ZWNnEzcFliaERK?=
 =?utf-8?B?bEZtOFE0QnVIN29UUENZS3VPdHNQSzg1V0plVFFMZEQwU3VKQ2JWdlJDOXhT?=
 =?utf-8?B?b1VzcytRQTE3Tmxma3gvaWQrMThIYzNXMDQwUHErSzBQNVV1NHFlMmc4aWV3?=
 =?utf-8?B?ZWZJandQVmpEUFgrUVYzWEIrRE5VbnU1QXlMWjVQcXBGTkpkMWRTVXJpSmU5?=
 =?utf-8?B?OUQ0Tk1GMG12TWpXQmJQR0VTOVltSE1rRGxjWTN4SzlxbU1HY3llT2ZEeWVU?=
 =?utf-8?B?QUVwdTJiZXpwUGRtbEQwSzk4dmVneWlmQXRTbzZWV2tRMWN3RDZjVE91TzZO?=
 =?utf-8?B?ZW5DQnNZVDVFUmtrbnlZOUdtTzVpNUwzeExFbWVab1owRmEvYVQ4Ulh2Y3Uv?=
 =?utf-8?B?d2drMEZocVJubmpZSWIrRUE0b1RTc21kVGNwZjM2eUtRZ2RrYjZKdFdSN2Q4?=
 =?utf-8?B?K0l6cEhxYXc4bWQ4NGVFUnRGNmpURk9heWtUOUJhYVpFM1BUbndHeGttbUo0?=
 =?utf-8?B?WGorVytuNGZXbGxQSEt3dWkwTGNCc25vRFlFZ1hvRXRKL2pCWVppaTFtZXlL?=
 =?utf-8?B?R0xOUURMcHRqUkFqUVJqb2lVa0czd1daRk9uMXJDVUNWcWc2NGVhRjRYTjFD?=
 =?utf-8?B?MlZmcndrT05mMlB5S2hZeUhFZXhiekwzQnl3NnF3cVB3dEdiREVQQzhUT2N3?=
 =?utf-8?B?OGx4Ykw3aGpoUlB1RXlyMjVtTHFqemRYRStGS0JCUmtQTzNqTjVoVnROdTlV?=
 =?utf-8?B?VWYvMFdGQWtqa2hXTU5hUGIrK1QxWHc1TjhZZ2NpYlJtbEJtMzBIYnR2cGY2?=
 =?utf-8?B?UUk2TFZPc0dERFF6clJ4d20rUk4yWlFPY05VOXUwOGJMYUpoMVFyY2FvUUZV?=
 =?utf-8?B?OVFLQ3VVblZOdGZHVXZmM1pzWGxCQ2VnbENIaW9Sck82dlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWIrSWMyNnRwUHcxWHBVMkl4Tlk5c3lDYkpTbGdmMldTcFNzNUNWUTFPNksz?=
 =?utf-8?B?ZVJTNXNkbHF0RVFnWU1UaEdNWE9ZOHVqaWhiNHZYSXhXT3pGQm1KNjVzZUNw?=
 =?utf-8?B?Z2ZUL3ZMMjJiZWZabmF1TkI3SHBnRmErZVJyV0VzcjNlYU9KUkRpdjNBZ1hl?=
 =?utf-8?B?a3lKYlFvd2l2M3VYbHVWZjF2ajQ2bm5TK3FuSS84ckE1Ujh0U2JvUlIxODgy?=
 =?utf-8?B?cEluYTZnRjVXVWdTLzMyTnYvWnJGcGMzNmd6U3BSMzI4ZlBsZ0lrSVAzelpy?=
 =?utf-8?B?Ni8wVzA3bzg4R2N4ZTRObUJITUFwUy9UZVBscW1tTHZFc2NIZ0ZMS09pckk3?=
 =?utf-8?B?NHdyekE5Z2ZsWUdZVjlsZ2hDMlQvRjBBdDd5TExQK0Q3Q1ZNMlJOaVJlOTJC?=
 =?utf-8?B?VXR5bGxWblgxdVdjWnhzWmVMdVpLVFJHbVU0bkwwZEJmWmVKUmxWNnJrTEhk?=
 =?utf-8?B?VkFVV3AyR2ROMmV5MENMajBJWlBPU21ZQmxBWFNRT0JqOTFiREdHbEh5Y3VQ?=
 =?utf-8?B?bU9WVGxlRUdMT1VlU1JHakhtUVRIVGRDNWM1OE5DY1Z5MmwyQjVYWUkvZ1Va?=
 =?utf-8?B?cDNZNHFpOGNmaHZBRGFDUlFyVHI1T2xUM3FkeWQrVFZpZ2Z4QWpSRWNWS3ps?=
 =?utf-8?B?UExrZkNZZ3FwY2Q1eHd3c3lNUmViNm9uYWhOV29zVUlHUWNxd2JPQW9sdFJF?=
 =?utf-8?B?RmlDSXJrRVE3RWJ4L29YMEF6VFZ1LzdWQXJ6c29LQVM3QnE3T3ZnNFE5VU04?=
 =?utf-8?B?dHlUaVloVitTWTRNY3VCb1dXNEMrZ0lYUDB1dENreVdEZlduSFIwcWFCTVhs?=
 =?utf-8?B?cVlmZEt2ZmRwa0d3ZWlOTVhxazdoZ1BMa1VaSmJPdldkeXAxcXMrRnpvQmVH?=
 =?utf-8?B?STM2TVZyTTJHcFlOUmhGdGJJWThLMXpDRlJEOEN0dmdzaitNVHZKekxjcnda?=
 =?utf-8?B?WEZhem9FcnhaU2tPNEhXUDBZcytPNnRTcHh5WjFIbUpEVGhwYlVyZ1YwcEkx?=
 =?utf-8?B?YnBLWjgzQUtYUUp0bXNRajFlMmlIRVdZVTFiMWJYZlhLbUliQnNFY2gwS1Ay?=
 =?utf-8?B?L0N2UEpjU2FOMFE3NmtGWkk5MnJ4TXhUVVJ0Q2k2cmFxWmRYQ0dkQWd5S0F4?=
 =?utf-8?B?dWF1N1lKNGRqWkNNWjdjRmYxVGJBV3VMbnN5NnUrbTVRaUdZYlFtaDBzTHF4?=
 =?utf-8?B?NFJNTTV2ZDJNMmpXOUJhWHV5M3RsYldFaFJaSXpOOHB6MUM5ajRnNmJyaWlH?=
 =?utf-8?B?c1V5T0NyRzNWdGo4cktVcHJZd2VsNmtHcDZyRDBoZGVzaVZNOXRtd1JCWE5Y?=
 =?utf-8?B?UkpEWTgxaC9Sa2RXOTljZVlIa0VBd1RRVEhWc0ZRQUpNellNMmZDc0phN3NM?=
 =?utf-8?B?d1l2b29KOWhxT0hHTWgvd3BMSVNWZ0NrOFpEM2UzTCsvOVdNQzR2YzhVNTVZ?=
 =?utf-8?B?QXh0enNmOVlxL2x6MjcwWVUrMzlJd2UvQkVZTGw4UVJIZVZYT1FqbzlJTWxG?=
 =?utf-8?B?ZG0vYW0vVmZXeWlRV0E4b2plVnBLd3RyMFlnYjh6YSszckd2RnBGL092d0Vy?=
 =?utf-8?B?TnMyY3ZiNVNSanQwOFB5QnkzT0d3Q2gxblZjWndCR2hZdmtPRmVPTlhWUzIr?=
 =?utf-8?B?TTRWMHRIaEFJU3hzUzRFWFE1VGprVVVKMmMxRitKaU04dkd4YzB5amVqcHVk?=
 =?utf-8?B?U0UzZ3hGcjZDN1M3Y0VDUkV5UkF4VzN4OEhYZWtaU2RCUHRDS1dDV2pRTi8x?=
 =?utf-8?B?RHBMd0V1eEVsMit4RHY3M1hVelF5dGFVUlN0cjk5R2FBQXpYV3VMdzdiUGpU?=
 =?utf-8?B?ZFpLRkJWREFHSDZuNWpPSmdBbkdkdzZGUmNqVThaVE44dkZaYys5MFBGaE1V?=
 =?utf-8?B?TDdhdForYzBEQ0pLWWVoMkFBOCtucTZ1RDZGekJDRGpVbUlEazRGTjM0dHF5?=
 =?utf-8?B?MXJTR3p1dWsrVEpqaHlscHJEdGIyUkpYMnpMQncwYk82YjVVQ3pBZElpMmF6?=
 =?utf-8?B?WDM2ZlI1Ylo4eHpwc0VjVTRvUDVnaTdaUm5UMGpZdURNN2N5b3h0aTJVUENQ?=
 =?utf-8?B?a0V1S21jbTZSVytuNjJHenFSWitTMVNTcXBJM3daV3hpTE43TldMeHpWT2Vy?=
 =?utf-8?Q?BSo757Tq7TxkdzpHUH1s0U1D6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b4b4de-e802-423e-a195-08dcd0716c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 01:47:54.8347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghO254JN/ySz5Ez8MIC8BqZjgVrLM5px7q8BLG9cartE5wqXfoBKDGyWPYibAd2STDOAPTeaFMTlV3s6L9h72BV5RFL3ZSk/gE1F2NaV3U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6262

SGVsbG8sDQoNCj4gT24gRnJpLCBTZXAgMDYsIDIwMjQgYXQgMDY6MDY6MTRBTSArMDAwMCwgSmFj
a3kgQ2hvdSB3cm90ZToNCj4gPiBIZWxsbywNCj4gPg0KPiA+ID4NCj4gPiA+IFdlIG1pZ2h0IG5v
dCBoYXZlIGEgcGh5IHNvIHdlIG5lZWQgdG8gY2hlY2sgZm9yIE5VTEwgYmVmb3JlIGNhbGxpbmcN
Cj4gPiA+IHBoeV9zdG9wKG5ldGRldi0+cGh5ZGV2KSBvciBpdCBjb3VsZCBsZWFkIHRvIGFuIE9v
cHMuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IGUyNGE2Yzg3NDYwMSAoIm5ldDogZnRnbWFjMTAwOiBH
ZXQgbGluayBzcGVlZCBhbmQgZHVwbGV4IGZvcg0KPiA+ID4gTkMtU0kiKQ0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiA+ID4g
LS0tDQo+ID4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAuYyB8IDMg
KystDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mYXJhZGF5
L2Z0Z21hYzEwMC5jDQo+ID4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZhcmFkYXkvZnRnbWFj
MTAwLmMNCj4gPiA+IGluZGV4IGYzY2MxNGNjNzU3ZC4uMGU4NzNlNmY2MGQ2IDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAuYw0KPiA+ID4gQEAg
LTE1NjUsNyArMTU2NSw4IEBAIHN0YXRpYyBpbnQgZnRnbWFjMTAwX29wZW4oc3RydWN0IG5ldF9k
ZXZpY2UNCj4gPiA+ICpuZXRkZXYpDQo+ID4gPiAgCXJldHVybiAwOw0KPiA+ID4NCj4gPiA+ICBl
cnJfbmNzaToNCj4gPiA+IC0JcGh5X3N0b3AobmV0ZGV2LT5waHlkZXYpOw0KPiA+ID4gKwlpZiAo
bmV0ZGV2LT5waHlkZXYpDQo+ID4gPiArCQlwaHlfc3RvcChuZXRkZXYtPnBoeWRldik7DQo+ID4g
V2hlbiB1c2luZyAiIHVzZS1uY3NpIiBwcm9wZXJ0eSwgdGhlIGRyaXZlciB3aWxsIHJlZ2lzdGVy
IGEgZml4ZWQtbGluaw0KPiA+IHBoeSBkZXZpY2UgYW5kIGJpbmQgdG8gbmV0ZGV2IGF0IHByb2Jl
IHN0YWdlLg0KPiA+DQo+ID4gaWYgKG5wICYmIG9mX2dldF9wcm9wZXJ0eShucCwgInVzZS1uY3Np
IiwgTlVMTCkpIHsNCj4gPg0KPiA+IAkJLi4uLi4uDQo+ID4NCj4gPiAJCXBoeWRldiA9IGZpeGVk
X3BoeV9yZWdpc3RlcihQSFlfUE9MTCwgJm5jc2lfcGh5X3N0YXR1cywgTlVMTCk7DQo+ID4gCQll
cnIgPSBwaHlfY29ubmVjdF9kaXJlY3QobmV0ZGV2LCBwaHlkZXYsIGZ0Z21hYzEwMF9hZGp1c3Rf
bGluaywNCj4gPiAJCQkJCSBQSFlfSU5URVJGQUNFX01PREVfTUlJKTsNCj4gPiAJCWlmIChlcnIp
IHsNCj4gPiAJCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJDb25uZWN0aW5nIFBIWSBmYWlsZWRcbiIp
Ow0KPiA+IAkJCWdvdG8gZXJyX3BoeV9jb25uZWN0Ow0KPiA+IAkJfQ0KPiA+IH0gZWxzZSBpZiAo
bnAgJiYgb2ZfcGh5X2lzX2ZpeGVkX2xpbmsobnApKSB7DQo+ID4NCj4gPiBUaGVyZWZvcmUsIGl0
IGRvZXMgbm90IG5lZWQgdG8gY2hlY2sgaWYgdGhlIHBvaW50IGlzIE5VTEwgaW4gdGhpcyBlcnJv
cg0KPiBoYW5kbGluZy4NCj4gPiBUaGFua3MuDQo+IA0KPiBBcmUgeW91IGFjdHVhbGx5IHNheWlu
ZzoNCj4gDQo+ICAgICAgICAgaWYgKG5ldGRldi0+cGh5ZGV2KSB7DQo+ICAgICAgICAgICAgICAg
ICAvKiBJZiB3ZSBoYXZlIGEgUEhZLCBzdGFydCBwb2xsaW5nICovDQo+ICAgICAgICAgICAgICAg
ICBwaHlfc3RhcnQobmV0ZGV2LT5waHlkZXYpOw0KPiAgICAgICAgIH0NCj4gDQo+IGlzIHdyb25n
LCBpdCBpcyBndWFyYW50ZWVkIHRoZXJlIGlzIGFsd2F5cyBhIHBoeWRldj8NCj4gDQpUaGlzIHBh
dGNoIGlzIGZvY3VzIG9uIGVycm9yIGhhbmRsaW5nIHdoZW4gdXNpbmcgTkMtU0kgYXQgb3BlbiBz
dGFnZS4NCg0KICAgICAgICAgaWYgKG5ldGRldi0+cGh5ZGV2KSB7DQogICAgICAgICAgICAgICAg
IC8qIElmIHdlIGhhdmUgYSBQSFksIHN0YXJ0IHBvbGxpbmcgKi8NCiAgICAgICAgICAgICAgICAg
cGh5X3N0YXJ0KG5ldGRldi0+cGh5ZGV2KTsNCiAgICAgICAgIH0NCg0KVGhpcyBjb2RlIGlzIHVz
ZWQgdG8gY2hlY2sgdGhlIG90aGVyIGNhc2VzLg0KUGVyaGFwcywgcGh5LWhhbmRsZSBvciBmaXhl
ZC1saW5rIHByb3BlcnR5IGFyZSBub3QgYWRkZWQgaW4gRFRTLg0KVGhhbmtzLg0KDQpKYWNreQ0K

