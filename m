Return-Path: <netdev+bounces-106895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395CD917FDC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525061C20C48
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F35B17F38D;
	Wed, 26 Jun 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="YSeP90qN"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2180.outbound.protection.outlook.com [40.92.62.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C017E8E7;
	Wed, 26 Jun 2024 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401918; cv=fail; b=gNtW1rM+sOjwuNi1DtLCKcJhYryA4vWePf6nMZpI6OjGZCzc4Iom1f7e5r8qTlq7kVOstGWbRzt9Hs2KqFoAzA7PLWelDlvP6eJqggrNBp/CPPRd22SxLrKcxzzHWZ3inWvZjhEygfpWCTqG8AfGds2wTB0luuXLvUAzZnodJHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401918; c=relaxed/simple;
	bh=sWMkpqhdN7VTf4Px5P3ThkDuuCSgSL/4YGrUbRI8xw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iNDkvRoHJrVnUBYhjkCgphXwquOW/51PHkfBWDRV8HXkBLs7jVAXTrIsKkSeunKzRKc00BejUayTlQ7fqC+0aqDJegOU2qk/0oH4U1mxSM4dIsvxQ3eTDHWq9QSkuQL7Jwva2nj4zYD/cp0l80Ayj4RPJt8HXKUNgojhov/NOng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=YSeP90qN; arc=fail smtp.client-ip=40.92.62.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRXDuEqryeVZz4NXvXLY600YsrPuFOygyLTdG1MiphcF8ipR1IyzvJH6tAkHO9vwFY9NQLW7UkirDEjNxCPymfVK2Uu/sn9/H3EycOkPCH9C0emn7dt72ZuSsQ2AT92iKWF8EGavwPGdGStZOmqoxRf7tDhnGqYALIaXnm495Rb/ZzqcvVrfRvjp+5qu8Kh0AreiyHj3KtyCFmbT+/mhmDzJYyrdA5DujigiuuznJvfu0+EaxsKEAbXilP/oTaOoYOfE3b8m775SUxxaiuDwhi2Ptwqha/Sl6/yfl5vSEoduFxVSsSS6ZpzP2Lw3+SCRUzLNTZmCm/KX7z6+DNbACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYVFkH1bFpWtv0oiMYFI3TxTh8U44913omouICzLHdA=;
 b=CzDlpeM3DiwXPqUJvYeJgtqjbpPgjyONm973o7rQvCMKofS7syBQ80ij+5h/vuDvapKyzzx/R/wihwkqtMD5cHPNQ8NcC/KcjMnI8l7SrkEmn4LNcRhfyUZ9Tcg6OcJ1gPFFhuhPZdWaZ9ADVGpEGPervQT7YsD9fnYCxt5rsR2LTnRrDU60Qb1TFL4r/BiKXAuf8YFZaEaFIZmFBYPGYfAMhQ7vOInX6OK1np/lnwRZfyOiJlIFZFuRZSLh1CEjPwEdcZ/ik9imLeHlyQD0v5PC1Mg4eg4wcAcytCxQ+Py6xows6EYUvPxp1AC5nhCIlrkKbK7Tvez7ygIl9sOcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYVFkH1bFpWtv0oiMYFI3TxTh8U44913omouICzLHdA=;
 b=YSeP90qNaoKl4e3k28EflQUC5Gal3jQFKS/VgNihMhn6nAlyxxxQyb06kmYLYX79U7pLvAx/X9UzPVvhcPjdDMJVZzgZk3ypQLSn/1+oI/F46R0IWmDY2kBDv6mnl1kOnPkmFfRuPpfz2YFgfhXkn/rz377+lxV7yIBnzOc/kwCM3BMZfszYcwm+4YZf4CT7NfSkcIpKH701oWTJMYmULJYbr2JjpX1akLN17o6XQIwf5WjAiWZaA9Ufo06fwsymx9OLDuqIBWtFdEp8fchc6XqACjp+qm7v51FeGSf18zAsfNj6Cd4bx2Txu96KylCdQqvcp/EQXzlRuNisiS3lGw==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 SYYP282MB1438.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Wed, 26 Jun 2024 11:38:31 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:38:30 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: ryazanov.s.a@gmail.com,
	Jinjian Song <songjinjian@hotmail.com>,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: jinjian.song@fibocom.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next v2 2/2] net: wwan: t7xx: Add debug port
Date: Wed, 26 Jun 2024 19:37:56 +0800
Message-ID:
 <SYBP282MB35286B93C3FA936192CF270ABBD62@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9cc44560-2226-446d-9b95-02edc9c8a008@gmail.com>
References: <9cc44560-2226-446d-9b95-02edc9c8a008@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [BN5I7K1CUpSHXmIsJ9GQwf+4lgXqmVjR]
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240626113756.9198-1-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|SYYP282MB1438:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fa4945-11c1-480c-8cac-08dc95d480cc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199026|3412199023|440099026|1710799026;
X-Microsoft-Antispam-Message-Info:
	A/34uFI2aDYWYDg0bEF228UAotaWrDiMTrjSrFCJUcMRE1VSzzGe86m3XDZc0ibG/o0iExLXv5FHNKKbNcPDVb9AD24Fjr7C+Yep8rvUSjlXZvkVIfp+lcp1OiytXScguJdp5azdSVLAG9qj+oqGgzQHhd2NwT1M50A6SoRvyAlRhiZLLKvnGuMzIthzTlNEGls0Ke4rPTSyvrZPrs1QLx8q7Ib4/aM8N32tYCAemMvNxk1Cosi8qIi1vjcUVKSQlxFES7ac0yuytaLZH/LykNsaswHyz9j8+rQzk8hZkHfqqZb3MLNa5PRrsoa040wRIhFgkZZ6C3VtQxT2OP42xuNrhxTsh1AkM7CZe92rQViw3fZYjtlkpns7EqBriqJ0AJDzkF0Bhl3gE5hNFbqc3kYYypT9gY46vRN2IQVoNW5aeK24MV6i9ca0rYRg4MK44X4JrwweYdj0i3fduND8XdfEma6y9ZMoQkpBqRlw3i4QWmj4zn6pLnDlkTl7HZrEJoZDJGm02wYmFSV5LABYRVjqp6hS1W38GY4dlL1Hk9cgnu3CTIiEP1Nq6MSpgcx1iNbGAP8e0CCYgVEhzgEU/S0HUPVhZ8OWA9cReYVAeSIlx2PNcsKCGG20IAvL/xHy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WqrgfTP4Ysl/Urp+ZKoMMRqmpKLAPDKLUk9WQjFQepDSkPeCEZa2LCxJpeUW?=
 =?us-ascii?Q?AdEnR6N1LLwVvI04etW02WfcxDy/LpCr7ZSTEpd7rjzCi9mGts79WbKfSrnL?=
 =?us-ascii?Q?1cKmNEldWRnyn7gMQOs5GgEilE8BTD9jdoL7rwvQ0MtcmOJf+l03tn14sHbW?=
 =?us-ascii?Q?gHZJz6dT3SjHnBg/GKRTgCgD2M8AsV/g/8kI4oiqqpDwIVbvgZ5rykaM4rCP?=
 =?us-ascii?Q?5QVXb8w+NV6E5pQiM7ZrlzMlHBnFObi+HHrpGb3EscgWAhESNGU+ZfhGDzIv?=
 =?us-ascii?Q?iZk0c/f0EmjiqCc7To43DA6LRrdU/G9udL26LQdviHOxjXP2h64i7tK8Pi34?=
 =?us-ascii?Q?umCFdw5GoEcZiaCjo9OniUyR+f29O+fcKWiKW2AhQO7WWNSkhvGaTh+5cN39?=
 =?us-ascii?Q?grDo56WTW9gO/Fl0QZhEsdP6jN9FLu6raC3kzgUVH513jyBmSTDmwLjtWBVV?=
 =?us-ascii?Q?6ELzpllaBbMPU9CyB4Ul9GCgb0SjRuioic8rQlQAnbbOyDMPmAcxuChC2688?=
 =?us-ascii?Q?iXITmQFZQ0U8AcAuvcFQ9D9+JKfF4F2XjKIe3LYKunUC9O4mnjFLda/B0XkB?=
 =?us-ascii?Q?xmJ/6zidGixx7kVEvh88dlE6yHJkblqj1Q3CUb83wQmsaYnc7eemq7fzVbqi?=
 =?us-ascii?Q?decy+CqbgvQHGhAjvr85KtVoSDZZ+0+Zsa29TXV+kMdZCwaOq9jcun0YGDN5?=
 =?us-ascii?Q?FkeXJoFQFcaHT73SUy9xRzOTFheaGsCbEL/SvktqaKP6/i7tlWdz3bbpHMK/?=
 =?us-ascii?Q?WqJ/9gbcCKEYi3Tz2RsKbRtPK6a+tmAy5QmemmL7BvoKU35m+8whDr7qkX/P?=
 =?us-ascii?Q?rUXCeJDG56GbQ6rji8/BOZv226/KAeAzc/cO8ZmIwhBqglmYt1hJAjTYBG9q?=
 =?us-ascii?Q?wuK3xgHlEu5+anVIZDQnzdahjaAcplcf395Sa+ZHvYauZFTho50Zw2Ajs7QU?=
 =?us-ascii?Q?eY9Tc0GxYjgfSRyqVUJ9n+jJ+P0T1cy15+jWLddC7NdaWvSiCh5xPEsm3YaD?=
 =?us-ascii?Q?pxeIczNp2aWLs18ipdx/W+RTfj8c5fzFYIIVNYoH8QcwTXFzyG83dG7xqHGX?=
 =?us-ascii?Q?OdfDgEQk66Y3G1+UwHoXPw8Lb0e0U35sik/FTsyvsIGnXehd5v8vBgGykKb3?=
 =?us-ascii?Q?CnNGizaJL+wyS34uJcguooi7duemayUYH+2tb1KPLkGY7m3nUGqCHETRhkNx?=
 =?us-ascii?Q?7D2T0nXVJJwL7X8PJHTUm1pRoE7iaCx5n5TeEqjYlXX5S9l0EKcSmxDsJAkb?=
 =?us-ascii?Q?J4v64ZPOb5OZcuxemSfT?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fa4945-11c1-480c-8cac-08dc95d480cc
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:38:30.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1438

On 25.06.2024 11:45, Jinjian Song wrote:
>> --- a/Documentation/networking/device_drivers/wwan/t7xx.rst
>> +++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
>> @@ -56,6 +56,10 @@ Device mode:
>>   - ``fastboot_switching`` represents that device in fastboot switching status
>>   - ``fastboot_download`` represents that device in fastboot download status
>>   - ``fastboot_dump`` represents that device in fastboot dump status
>> +- ``debug`` represents switching on debug ports (write only)
>> +- ``normal`` represents switching off debug ports (write only)
>> +
>> +Currently supported debug ports (ADB/MIPC)
>
>Could you clarify a bit the availability of these debug ports (ADB and 
>MIPC)? Looks like these ports are always available when a modem is 
>booted in a 'normal' mode. They are available among other types of ports 
>like AT, MBIM, etc. And you want to hide them, or speaking more 
>precisely, you want to make debug ports availability configurable. Do I 
>understand it right?

Yes, your understanding is basically corret.
1. ADB port, When we want to pull/push some files from modem or run shell command
on modem, we usually use the adb command.
e.g., "pcie-adb shell", then commands we input will run in modem shell terminal, if
we input shell command like "ls,pwd" it feedback the result on modem side.
or "pcie-adb pull xxx.file" to get the xxx.file from modem file system.
So if we want to get some file(config or dump) from modem or change some file on 
modem, it will work.

MIPC port, When we optimize modem antenna tunner or noise profiling, we will use
this port to set parameters through this MTK diagnostic interface, the command
through this MIPC port defined by MTK.

2.All the port channel configuration is determined, so if modem open the port
channel, driver can communicate with modem. It means if modem configure 
AT/MBIM/ADB/MIPC channel open, then when modem booting up with them.
I want to hidden ADB and MIPC port, because the ports channel is off default
by modem. If needed when debugging, we can open them.

>I just have doubts regarding the chosen configuration approach. We 
>already have a 'ready' mode indicating a normal operation. Now we are 
>introducing a 'debug' mode that only makes available ADB/MIPC ports, but 
>reading from the 't7xx_mode' file will return 'ready'. And also we are 
>going to introduce a 'normal' mode, that actually means 'hide this debug 
>ports please'. While easy to introduce, looks like puzzle for a user.

Yes, it looks like puzzle for a user, 't7xx_mode' should be the running
state machine of modem, I want to express the port status by 'debug' and
'normal' of t7xx driver.

>I also would like to mention a potentially dangerous case. If a modem is 
>already booted in the 'fastboot_download' mode, and someone writes 
>'normal' into the 't7xx_mode' file. Will it switch the modem into a 
>normal operational state. Also the activation itself lacks a couple of 
>checks regarding a double port activation. Please see below.
>
>How we can make this configuration process less puzzling? Should we 
>rework the state machine more carefully or should we introduce a 
>dedicated control file this purpose?

'debug' and 'normal' only effect the ports which configurate the attribute,
'.debug = true', when modem in 'fastboot_download', user set 'normal', then
driver will find the ports proxy configuration which '.debug' is true and 
call the port->unint to release the port. 'fastboot_download' has no 
attribute '.debug = true', so no oprate will occured.

How about create a new sysfs node named 't7xx_port' to control the ports
state in t7xx driver? 'debug' or 'normal'.


>   
> @@ -100,7 +102,27 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
>   		.path_id = CLDMA_ID_AP,
>   		.ops = &ctl_port_ops,
>   		.name = "t7xx_ap_ctrl",
> -	},
> +	}, {
> +		.tx_ch = PORT_CH_AP_ADB_TX,
> +		.rx_ch = PORT_CH_AP_ADB_RX,
> +		.txq_index = Q_IDX_ADB,
> +		.rxq_index = Q_IDX_ADB,
> +		.path_id = CLDMA_ID_AP,
> +		.ops = &wwan_sub_port_ops,
> +		.name = "adb",
> +		.port_type = WWAN_PORT_ADB,
> +		.debug = true,
> +	}, {
> +		.tx_ch = PORT_CH_MIPC_TX,
> +		.rx_ch = PORT_CH_MIPC_RX,
> +		.txq_index = Q_IDX_MIPC,
> +		.rxq_index = Q_IDX_MIPC,
> +		.path_id = CLDMA_ID_MD,
> +		.ops = &wwan_sub_port_ops,
> +		.name = "mipc",
> +		.port_type = WWAN_PORT_MIPC,
> +		.debug = true,
> +	}
>   };
>   
...

>> +void t7xx_proxy_port_debug(struct t7xx_pci_dev *t7xx_dev, bool show)
>> +{
>> +	struct port_proxy *port_prox = t7xx_dev->md->port_prox;
>> +	struct t7xx_port *port;
>> +	int i;
>> +
>> +	for_each_proxy_port(i, port, port_prox) {
>> +		const struct t7xx_port_conf *port_conf = port->port_conf;
>> +
>> +		spin_lock_init(&port->port_update_lock);
>
>This lock initialization does not seems correct. Should we reinitialize 
>the lock on port hiding? And looks like the lock was already initialized 

Yes, it should't reinitalize, let me fix it.

>> +		if (port_conf->debug && port_conf->ops && port_conf->ops->init) {
>> +			if (show)
>> +				port_conf->ops->init(port);
>> +			else
>> +				port_conf->ops->uninit(port);
>
>This part is also does not seems correct. Existing of the 'init' 
>operation does not imply existing of 'uninit' operation. See 
>t7xx_port_proxy_uninit() function.
>
>Also t7xx_port_proxy_uninit() will call the uninitialization operation 
>for us. Is it safe to call the uninitialization operation twice? Once to 
>hide the ports and another one time on a driver unloading. Or what 
>happens if someone will write 'normal' into 't7xx_mode' twice?
>
>The same question is valid regarding the initialization (ports showing). 
>If someone will write 'debug' into 't7xx_mode' twice, then we will 
>register the same ADB port twice. Isn't it?

init() and uninit() has check the pointer of the port, if porinter is NULL, there
will no more operation, so it will not call then twice.

Code 'if (!port->wwan.wwan_port)' will check if the port has inited.

static void t7xx_port_wwan_create(struct t7xx_port *port)
{
	const struct t7xx_port_conf *port_conf = port->port_conf;
	unsigned int header_len = sizeof(struct ccci_header), mtu;
	struct wwan_port_caps caps;

	if (!port->wwan.wwan_port) {
		mtu = t7xx_get_port_mtu(port);
		caps.frag_len = mtu - header_len;
		caps.headroom_len = header_len;
		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
							&wwan_ops, &caps, port);
		if (IS_ERR(port->wwan.wwan_port))
			dev_err(port->dev, "Unable to create WWAN port %s", port_conf->name);
	}
}

static int t7xx_port_wwan_init(struct t7xx_port *port)
{
	const struct t7xx_port_conf *port_conf = port->port_conf;

	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
		t7xx_port_wwan_create(port);

	port->rx_length_th = RX_QUEUE_MAXLEN;
	return 0;
}

Code 'if (!port->wwan.wwan_port)' will check whether port has uninited.

static void t7xx_port_wwan_uninit(struct t7xx_port *port)
{
	if (!port->wwan.wwan_port)
		return;

	port->rx_length_th = 0;
	wwan_remove_port(port->wwan.wwan_port);
	port->wwan.wwan_port = NULL;
}


Thanks.

Jinjian,
Best Regards.

