Return-Path: <netdev+bounces-65530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52A783AEEF
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE831F21C6A
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA77E795;
	Wed, 24 Jan 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="DBviG16E"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2176.outbound.protection.outlook.com [40.92.62.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627427E780
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115463; cv=fail; b=Hc+2JMt/fd0Rbm+XZq8/dv/+AiLKtXy7F1g1p0/xfVEXDEqJ0sKIEWuafocQ4eGN69CMar+7Q43pP2/6QBKNeP31yW4hKJkj5+4pSmSB5w8D2r/vrLi9dX4O27oSV3XqyFQPCvTwNaUMLE6GLO7NPzLC2KRpgEVl3x5WYQsOmgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115463; c=relaxed/simple;
	bh=3sXLpfD82QxYZ5/5pIFvsopY4fZw/OWoWHnx5oOq7g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8cJaILd3I5ZF5spNI8tntuJtN1fIXwj/xE8bYxM2hxxcdy0vFNftDra162+BNjKb/fx/eCItL87fdQPEN/AnW92+QSnSNuq0tGpbkc32yALjX2VP7acBKVhxqc+iLfY8PtzoSDxoMJrqZ4O8y5BiptZfB/bBa2gqar7guRi7N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=DBviG16E; arc=fail smtp.client-ip=40.92.62.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gywSWE6aKcBxIXnPpLHPTJMUBZrRKI3xn03LUVDNHiWx1EfwNAEx8kPeA1qPYeLeeYCrPUkBtInNbJjF3BqQlenJoqe1rpI8omYZ5HgLK7svmFEuRwUF8q+wbC5lu25hgQjvmBUtux6LgCctDwWHE0bU/C9rANEkWgv8FIBYrpgYsMgdEz5Q4erK5OctM8JdKXRaSI8U808eMgTGvFlkOI/bo0Bsku9f2zZt2gJ9ARQNngFmiIyaeRBB+ExPdvVFqdbfqz11zap5boYyB6fJs0QngdX/RJp76TTMZzW3Plw6qQ079ssumRP+EOyD974T/1i86iF5OTtz7i2a5hjg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwAFqHuGD8U6XeOWgLZ5Cm25z3LjEdzrztDVtfUVa8w=;
 b=TQ9KFBUvQ+mIx+ffn+FBw6uNd6kRZQ7Aec0h7u3pBFKioLRwiSbGT4hr8PEuQIxPH3/TcOWPYK5kcTeyrbS3D1CGxo5wipKQDBosYJWZawHLyr0x3qxZGJ2Hy7F6T0xgugirEdkKaXvzgg6s0G0bMJkj6OWEsTS71j1PKP8WDxp9QAV/jUKvcpPsLKxePFI3P8z1pN05//zXw9SuNlozIWNESchtCKt6rG/VxAV0XEW0kZG6nzkEvyp11pbWinbYhTsobKC+C9PbVL88FHmpCtt/Vp4FEOgcRM53vzCZpTu/qky6LRNBnCltzPrFxB2VD6ZtrEw79npyHtlg20SFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwAFqHuGD8U6XeOWgLZ5Cm25z3LjEdzrztDVtfUVa8w=;
 b=DBviG16EYnBpeMqdTwBgIBN/D4Fs+EoGnuE7GJfCe1SBrispMgkQzcJMOKTWVVvhRkeb+470QNFJiNNnBYu0+F4s8Qyxat3AWLtx8wS7RiV1YHl0tObH4gkT/JrDiwVLBI6S689UF/TuSa5mibyqkRKZS/rlAcDSCM5aRXq7WQXMwWoRj1nZ28XR/HOsiCk5/hFv/FawCjVkZI3vphtiRMl5IDzErZ44Ueutw9JzP2ZovDxeoB2MA/fVqelyp22rsYx7IkID2z9st7zWwdwxtopenGFEaqEAcUlQwVyzS6lCx8oDqep5X6NgCHeVxUUkoOrmiZLt3BR4OaSKaGzI8w==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY5P282MB4936.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 16:57:34 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%3]) with mapi id 15.20.7202.031; Wed, 24 Jan 2024
 16:57:34 +0000
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
Subject: Re: [net-next v5 4/4] net: wwan: t7xx: Add fastboot WWAN port
Date: Thu, 25 Jan 2024 00:57:09 +0800
Message-ID:
 <MEYP282MB269765ECA0ACAA6373F26560BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <MEYP282MB26978032980360EBBB1DAFF9BB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <20240122090940.10108-1-songjinjian@hotmail.com> <MEYP282MB26978032980360EBBB1DAFF9BB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
Content-Transfer-Encoding: 8bit
X-TMN: [iBur4ktLcW3trWgWSNMGmxu27b5dczxC]
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240124165709.19309-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY5P282MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 596026a7-b5dd-4dc7-9a38-08dc1cfd8fda
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WzMHzhLpP+ypAj+dZXc24k0z0IfJXM/40UozJ2RxOk2lDj0VWVlB6tHq8fA77UkT24L5O4UhYMu2PvjUC/cQ1njtas5pXznRQvUQLioFgjPxhtBln9MFK7+1WlRZrqJ7tHi81PyPR9iHy7NwxKhk8jg4TZv/MDNFgvbBLzGbdvsH/oWg2LqSoyjtieRC3GLM6aG8uNXsDchrK6ay5Y8AStTnFZ0POodw5Fs/0NyHxKHVCGov8V12AHQKwtLRBh2/5DCTYoEeHUIROobTgtsomxR370ToaWDJAcQ9J7B5qUagBqZnqvsxhDpJXaGqc0qXBoHon3bFQ8ZOdEKTFV2BfL5Y8aBS6Wb4L6Se1+nKjvXBT/umT31QBaGIJSaoTvRZJpaRj/kk28A5pwFcsxSU/gitJfPtM51qJFFPqOk1YLCG4nt6r8h+XPZHcizzdLRo9XEbteh/hBlAKS1PVyjd5nodQfrlTLcxjrTpBQ/jyeXyusK+aa8wiFBTquj0OXTrj1ZlNbUicJ51dOc3ztm9RUUR/cer8Ph9iHpAQ+RnW/07dZtHRuxrb65uuMlLBeECdqVP0MeLo7I5BZaFLxXFyyTFbwfuoGM4126Q6mnBJGsKOlzab+6T9t8BWjWJKbbJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1lnaktNcy9uVWpCZE5kZzNaZncvc2FqREtIK2cveGorZHlYQSt4dm9JaUdN?=
 =?utf-8?B?M040a3dpWjk4RlpnSHJUQnpSdjVtWEo4c1FPcjlDZU1VaERxek03UElaR3Nx?=
 =?utf-8?B?eEFVSkRqNU96dE91VmIzb0p2bjAvZENkOWQ4RlpGeWk3TDE1Qm9mQTdCVmJY?=
 =?utf-8?B?N2JsUnZ0Y2JNaWpqejRrTDVlQzkwTENqeDFWMk5OdytDblkvRm1kTStNRkl3?=
 =?utf-8?B?c09sZ1Jva3oweVFOOXdnMlhVVndzaUNCcU5UZU94YWlTMk12UUM0by9VdHl6?=
 =?utf-8?B?N1MyL09qOXFjNDVkRXU2Vm9YemxyamJMcXlSdzBMZ1BhQ2c4bWJkRVpTa3dY?=
 =?utf-8?B?RFM3MzVnMm04Vk5CSWNMaHNJQ2FENnRaa1U4QU5LTHBwSExER01EQXdtdFJt?=
 =?utf-8?B?VVpDUVllVDZCd1JKOTVXWldQUnN1c2dnTjBKYjFXdGxLVklIQlEvVTYzQ2Ro?=
 =?utf-8?B?ZGFwVEkvVWxtbmZ4blV2UGhPRU1HZDRJYVJsZkRmL201Y0dmbE9jQkJXanFk?=
 =?utf-8?B?UCsyQitLSGtoLzYycFlqYzdnczJMUVh5d0Z1WDBPc3hDbm83YWZHK0xuQnFL?=
 =?utf-8?B?UVlSTlIrZCt6RnhCYkJRQTdtWThyazZGcVAxWmJ2VG1oZkRtUkVDWFNXR1BL?=
 =?utf-8?B?K3JqWU1PUFE0VG83RENzWEVHTHJHTFB6WmFveldGbUhwUk9MUEMva2xrTm0w?=
 =?utf-8?B?cFNvNExkd2MxSUM1cGZNazIveGdrY1F3cXlnTjladXFjMHdNcm9YUS9aS0RP?=
 =?utf-8?B?VmNHSVJnL1NZckZsbmc3bmFPYUFJYVFRWit0ODRRbzdEZ3gxVkxXZy8zbFlS?=
 =?utf-8?B?KzdMSnZ6T2VZZ3BFczBxSjlFMERVcWEyQTZZNUVqMkxPY051YTNqWU5kYzlL?=
 =?utf-8?B?cjFaOXUwL0pBZ0hqU29MQjdldE9uWkpTTjNJWUpZRkdhdFFLcFNudmhFREQw?=
 =?utf-8?B?dXI5WWpwemRGeU55U3JybkNGRkpmYWlHdCtoaUJlWVFhK1hYeXJzSFZpQ0o3?=
 =?utf-8?B?TEFOSEgzSEZPeml3ZSt1anJST2xsQTRBTlRha0RIY1lVU0FvVWVSWHdBcTNh?=
 =?utf-8?B?b3dhRUZrYXJ0b3FjWnVjWjBOWVpva2dSY3NkMERTdE53a1hTNmx0VmhWTTFH?=
 =?utf-8?B?SHppWGdXYVVhbEpzVHZnWnVHbzZpL2hjdUJ4U09tOU5tbkpmL3BYK2RRZHR2?=
 =?utf-8?B?K0xpbUhUYjlhK2U2cGhCZzIvS2c3QmliRis5aytnZ3RwcS9LMXQvRnVmNXJT?=
 =?utf-8?B?bUZYMUVNN1NlU00yQktoMTZzcXJXWjRRdi9vODhudFAycklIQy81L3REUmVG?=
 =?utf-8?B?dGg3ZG8wUldpMlNOWm1qcVoxWFAwV2UrQXlCVFBvUzdJVFhvN1hpcDc3QlpF?=
 =?utf-8?B?b24rUUFlSkNPQWNyZFJxSzF0VkxnQzFwMlFnLzNUdFdXcmg1bXR0ZlU5VTZD?=
 =?utf-8?B?NFU0akNZUW11OEM5MHUzUGZYRU9HRkZMc2dDMDlXeHhOV002YVduTXNFS1J3?=
 =?utf-8?B?S2hDY3Z5NDdCemdUUVc5WlZWMlJ1TnhNdC9qWmJzMTh1dVlQK1RFL2JVRTMz?=
 =?utf-8?B?UlBiNjBsbGlWYmlvSGRxL0ZHK254aFA1bFJPL1NCZkZ3MmtkdWpzTjVHaDFr?=
 =?utf-8?Q?e33c3DreWlJmO1i/bJGKwyOO4I1Y7TODveHTpVhrV2Rc=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 596026a7-b5dd-4dc7-9a38-08dc1cfd8fda
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 16:57:34.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4936

From: Paolo Abeni <pabeni@redhat.com>

>On Mon, 2024-01-22 at 17:09 +0800, Jinjian Song wrote:
>> From: Jinjian Song <jinjian.song@fibocom.com>
>> 
>> On early detection of wwan device in fastboot mode, driver sets
>> up CLDMA0 HW tx/rx queues for raw data transfer and then create
>> fastboot port to userspace.
>> 
>> Application can use this port to flash firmware and collect
>> core dump by fastboot protocol commands.
>> 
>> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>> ---
>> v5:
>>  * no change 
>> v4:
>>  * change function prefix to t7xx_port_fastboot
>>  * change the name 'FASTBOOT' to fastboot in struct t7xx_early_port_conf
>> v3:
>>  * no change
>> v2:
>>  * no change
>
>Minor nit: you could/should omit the 'no change' entries

Let me delete the info.

>[...]
>
>
>> +static int t7xx_port_fastboot_tx(struct wwan_port *port, struct sk_buff >*skb)
>> +{
>> +	struct t7xx_port *port_private = wwan_port_get_drvdata(port);
>> +	struct sk_buff *cur = skb, *cloned;
>> +	size_t actual, len, offset = 0;
>> +	int ret;
>> +	int txq_mtu;
>> +
>> +	if (!port_private->chan_enable)
>> +		return -EINVAL;
>> +
>> +	txq_mtu = t7xx_get_port_mtu(port_private);
>> +	if (txq_mtu < 0)
>> +		return -EINVAL;
>> +
>> +	actual = cur->len;
>> +	while (actual) {
>> +		len = min_t(size_t, actual, txq_mtu);
>> +		cloned = __dev_alloc_skb(len, GFP_KERNEL);
>
>Minor nit: the variable name is misleading, as the skb is not cloned.

Let me rename it to tx_skb.

>> +		if (!cloned)
>> +			return -ENOMEM;
>> +
>> +		skb_put_data(cloned, cur->data + offset, len);
>> +
>> +		ret = t7xx_port_send_raw_skb(port_private, cloned);
>> +		if (ret) {
>> +			dev_kfree_skb(cloned);
>> +			dev_err(port_private->dev, "Write error on fastboot port, %d\n", ret)>;
>> +			break;
>> +		}
>> +		offset += len;
>> +		actual -= len;
>> +	}
>> +
>> +	dev_kfree_skb(skb);
>> +	return 0;
>> +}
>> 
>
>[...]
>> ++static void t7xx_port_fastboot_uninit(struct t7xx_port *port)
>> +{
>> +	if (!port->wwan.wwan_port)
>> +		return;
>> +
>> +	port->rx_length_th = 0;
>> +	wwan_remove_port(port->wwan.wwan_port);
>> +	port->wwan.wwan_port = NULL;
>> +}
>> +
>> +static int t7xx_port_fastboot_recv_skb(struct t7xx_port *port, struct sk>_buff *skb)
>> +{
>> +	if (!atomic_read(&port->usage_cnt) || !port->chan_enable) {
>> +		const struct t7xx_port_conf *port_conf = port->port_conf;
>> +
>> +		dev_kfree_skb_any(skb);
>> +		dev_err_ratelimited(port->dev, "Port %s is not opened, drop packets\n">,
>> +				    port_conf->name);
>> +		/* Dropping skb, caller should not access skb.*/
>> +		return 0;
>> +	}
>> +
>> +	wwan_port_rx(port->wwan.wwan_port, skb);
>> +
>> +	return 0;
>> +}
>> +
>> +static int t7xx_port_fastboot_enable_chl(struct t7xx_port *port)
>> +{
>> +	spin_lock(&port->port_update_lock);
>> +	port->chan_enable = true;
>> +	spin_unlock(&port->port_update_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int t7xx_port_fastboot_disable_chl(struct t7xx_port *port)
>> +{
>> +	spin_lock(&port->port_update_lock);
>> +	port->chan_enable = false;
>> +	spin_unlock(&port->port_update_lock);
>> +
>> +	return 0;
>> +}
>
>The above 4 functions implementation are exact copies of
>t7xx_port_wwan_*() functions in drivers/net/wwan/t7xx/t7xx_port_wwan.c
>
>Please reorganize the code to avoid such duplication, e.g. renaming the
>exiting function to something more generic, making them non static, and
>declaring them in some t7xx specific header.

Let me reorganize the code, I think I should merge fastboot codes to t7xx_port_wwan.c.

Best Regards,
JinJian

