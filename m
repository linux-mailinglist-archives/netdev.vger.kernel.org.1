Return-Path: <netdev+bounces-138562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FDA9AE1FE
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9031C1C212E4
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91B41C07F0;
	Thu, 24 Oct 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="XQI83o4O"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2115.outbound.protection.outlook.com [40.107.215.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5D1B85E3;
	Thu, 24 Oct 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764212; cv=fail; b=ehQVTiVbcviXYNv/Fkto5gSNDEbfVb3bMpVxjwMDFwBXxQhFbgVmdYN7XDDkXOAmubu459KVgA8sEi769hiRBmKuOJv74YiBFQTI28e5JE/U5XKHjuqpq+up+o8Vd4bXiWfxFJuASowxaUQRReu1ukioYv1wi0VDbDNNJowsfxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764212; c=relaxed/simple;
	bh=EBsO1pmNJbliPEO1aR2Xo7MCzqzRNuuZGH43VYCz2YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:Content-Disposition:MIME-Version; b=ZJkqfP2+nE3KERf/k/QvTJhEGGFl1cxyed+BAT6TP2eBSSRKwJTlAECW3OkkwWrCL4gvfN7Imw0rDbivOCmidu81dgsqg7XM8dsSoMl7QaVA/hdwNjCBmV7gJFCuUi1nmCi5QfuZT5Cn5Rmm/ybIVqzbyaxxNoTn05YZiNJA0KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=XQI83o4O; arc=fail smtp.client-ip=40.107.215.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV8c0fiNlq1x2OFzilV58weIE7TEaSz0AsegkPsV85wmSAcl8Lmt2VZEzt3+PgwUKRuzn5Lb3hLYaiMjPdSWAlrCxA6AqQMEp7ZwUknnJEaJ/W82N3oEFgl1wWGAVNFnfvQOt0xYLZBRYNxjsInt5IeIubB0xvaRHW5p6EXXbBn9BMfPhZoX4fXjUEo4R6Su2IHj9wu0iyRrHpNUcoOwc4PvpqgOIaTLKp5nOfCZ0vbvgz5i3JZGtHY5Tp6Sh+h+0dfhSlwlA9t9PrZxzC3h0kbFe21l8nNe0bcIc0CaDf6/qjbcDXt+UX6SVUjC6Y4wyt4QHJZImY4IQQ4dZlVPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEc7dEDgeqoTXaskQEsftjNfq2L5HwDIQUhIchBi/FA=;
 b=VfsVDZPk363nqsIQm9ae1RKgoDpc6ucwJOIB3htLhQP06tHNaGH0U0LJgEFpiW7N4EvF9QEoErKk4aj46UwYyPT8ZqAGEyd3+Kwf6DfoLL7yTYOB5bIzd8e9TXliyhMkavYoWNPI1ItgP8R9pINItCzN4Kev5SKTLkffEdoOub69VZ+2a0PDXDh8TZxqFGA8CBSrYy16X7RmyVn1M03Imx5laWNvxmSwQhP2I7eRpMmdTRnEey6sbVv3RrjPjBQwWCBUS3mdehi9ksxZyH+yJIK4lJnl5p/ddVaK2DB7WSPzOh04jUd8hGKWBID5CdLUZ++iPczHbWTKyQCDpNSY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEc7dEDgeqoTXaskQEsftjNfq2L5HwDIQUhIchBi/FA=;
 b=XQI83o4OzKD+qDXUOdq5tPFQ2vRCK/8MGj4jX6KJs/MIN10bo0S8lA3DgPRci5DOD7JnU3Rpwf4JFmheAvEHkWDmBmJlj/Ib19QE1gMMto3f5wAsAjiyn/RK5As9vT1Ohi/heP7WEeDSu7UM0rNx2+Ji42CjNWqIPgJBm4suWMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by TYZPR02MB7411.apcprd02.prod.outlook.com (2603:1096:405:4a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 10:03:24 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 10:03:23 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: horms@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	helgaas@kernel.org,
	jinjian.song@fibocom.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	korneld@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	songjinjian@hotmail.com
Subject: Re: [net-next,RESEND v6 2/2] net: wwan: t7xx: Add debug port
Date: Thu, 24 Oct 2024 18:02:56 +0800
Message-Id: <20241023124014.GU402847@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023124014.GU402847@kernel.org>
References: <20241021121934.16317-1-jinjian.song@fibocom.com> <20241021121934.16317-3-jinjian.song@fibocom.com>
Precedence: bulk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|TYZPR02MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f22fe9-09f5-4b9c-d46c-08dcf41317d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|4022899009|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?enOZJi4ty58b9aR7VyJL9A+N0LIb6b2B4784zQPVkzUwE0lUCXO2rN+6b7sN?=
 =?us-ascii?Q?BEZjF1lp7Fb0K0UCx6d1gTK3jRAcLAsw81tnBfJxTyAy77cbMaXgxMc49qnc?=
 =?us-ascii?Q?DGJYSRGLfiMU3O8IBjnBtHfUaRhYbEKO85lcED8wqrvV2QqA3lSPS/pzsscD?=
 =?us-ascii?Q?eE48+25umLovwdwvdz+37DS1m8BROwc+g4IOB+z6Z8oZ4HE3pAKOvcRdUdyA?=
 =?us-ascii?Q?LadkJn10YzuPlfWl/0HBR0+70BMJD7reehDbqBDa5s+W1tChvtSqdAHQ7jaL?=
 =?us-ascii?Q?Wm85gG7moxjblwG/xl23P4nlV285sTofnBaURjMnRAQsj6G1DZxhbuDoEbxT?=
 =?us-ascii?Q?1kz6cVMmuWkds29HX9EeGGpbY06sMHHWrPNnOC7Q+EAGilXqB44Odviixzi4?=
 =?us-ascii?Q?jtdLN8KEigT8zhYd2RsVbp1BOoTs/Kugr1G32SgvY6o4u9LhnUjQYscK/Uo0?=
 =?us-ascii?Q?HOFqKErFibfrCwIz9JCEF/+kdlft3dI7s8ULLeH1N4xcQH5MLb55dr6cWBYv?=
 =?us-ascii?Q?AH+tTVU2AeGQj3XTSCvRjzcgF9auJW1HVGuI6bo9t4dAPiplJ0CG1uJxbjKZ?=
 =?us-ascii?Q?0UQW7jyx7EpL3Nu+KE3ff4kZ2HNuLpEAEJw/dwTERH8zb3kYfN2jWfcULF3a?=
 =?us-ascii?Q?81WnZkVkBDS0Dr5HKPKbSMmZNKgPmmC9N7godOg2cnxrJVrvG+CUJM4fHpmD?=
 =?us-ascii?Q?0RXTthEDnt+708MVPk2woNM4NhkfajRB6PFvF03g9O5s28Y9nPSQMfqVl6PA?=
 =?us-ascii?Q?ctYN8HO9rEO5UIp5fDXLxaJh18gxk0cyEe8PKfNGtgbe3Qc0MruhkSnXDklZ?=
 =?us-ascii?Q?9tEFkBwsmgabUFZ3MmheoaqMkTQqEcKvkAWnKqqBQiI8LVdY/WV3uCejjJc6?=
 =?us-ascii?Q?JgFBsNdCK13Wcoc2m+K9z5NaV6wt7egbsKNfWnW1ekdhL+nIkWpxoCQvVp9A?=
 =?us-ascii?Q?wZKj9sJWgyYTOxYt9LSJIitp1U+qpTVBB+9+9QViDjAsssYe84PDUHOo74qJ?=
 =?us-ascii?Q?6ri9NqxRJ6Et064FF8/wlFAoHXijFEWCeOA6+edzYH6fklsN8RY3FVzmg93a?=
 =?us-ascii?Q?RTPknld9XKW7695hoCTbffv0YFAAd3Kz+cnGAZqkQ3pOlPvGNnGh1sDNXYRj?=
 =?us-ascii?Q?achzlmCC6chT8jSIlhqgCchAxfMRZMYchZhnD6wml8lPplj4JwW58SSCs5ZD?=
 =?us-ascii?Q?cpx/XB2dy7DlxQZpRR3bJULhMbWMxTpqBIycYn4v/PB9erX8GOhqVj3dtckV?=
 =?us-ascii?Q?fRI1KbUnGPUgt4JX/jiSUv8pgb6vUP5uYtqHGhZMGPRueQKM0egqbPo+qEKb?=
 =?us-ascii?Q?uqVLALMoCA0Il5WybeH6+mFj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rh0mOwRmaUSoXlOTPOSsrsas1j0WZIiF5WdUONZ09UyNBW5cLCw1cuQZt85t?=
 =?us-ascii?Q?S72N9e8TmbqIjRowc/2BrkDwo0TNJPWr7jzidj0QB/wdUegs7uL552vjtGPH?=
 =?us-ascii?Q?siVHpnMW/jfQZyvZmb2Jhsqi7hlUhKHMrQsSwu04sSET6lRxxD/6tTQD5dsc?=
 =?us-ascii?Q?mNGINMFXcsYZh8pyzt8VWEqNpl5/U5KRSbQIa7TcA0uiDdCJ8d3EZc4Wl0ai?=
 =?us-ascii?Q?tjh3s00yEzuyfsiR8SWpqSxYlXtRGF+AtRxdUovURODWFOWtfKe7gZz8ngtu?=
 =?us-ascii?Q?yTt4iix5W4MVyoT25QS8hebAWLDBEFB+bU2aV9P9LOeQx/L+OiN3NJlUVIpV?=
 =?us-ascii?Q?yhbTWtqFl1en21qvM3SN6RcOp8+VUoi4EmHWIAhVlXIm/DPK4blRlxsHOkZE?=
 =?us-ascii?Q?oxrg1+8tnJkQmeLbn3YofFSJTlwci55hVogoji9fxXEwm9gNMmeDzVxNKeoK?=
 =?us-ascii?Q?SKm/BH+hVIzWHhnLuRER+0qAsHy/SjiqoEGUo9hh4dUCZtFl+EOHunyyF1LD?=
 =?us-ascii?Q?Ym7kCYWAOXgQswTiyIYp4yaxn6aZkAnA1rGLvGIUocGWqmm3ogNDYroQMr+C?=
 =?us-ascii?Q?OOZObxIugJ88U+FjxCT0EfgToYYfbwu919FCc0zLib+gvVin88r+ozpR/Mbx?=
 =?us-ascii?Q?QLC88U86BfVobksctdI9mhfSM04GmzR7p5RBwgMVXGswYWY8i8IUf0nJejjT?=
 =?us-ascii?Q?yAqL8jfznkl4AU0P4TteB0gth3kLKVPjs2asU7DoI4fbfTT4ajOj6qEnsw6/?=
 =?us-ascii?Q?TJw/86mpo94rODi3ktHQSHipVJYcaRxebDKtGFnErdA2p+B8OeR+1oYODlpX?=
 =?us-ascii?Q?EQQryVYA82tgvV2s5u9M/kGUp6tQ4MuKTpYWD9Q36vOCPqWpllZWgVyDTmbN?=
 =?us-ascii?Q?oYyI/0koV5jnCvp93CtW0gh9ifUASdYaaDYHohIgJrmREzR0imRFPVORorlf?=
 =?us-ascii?Q?nGWtEDVmrt/38E+8OPoV0jrB8HMB43ROe/tpFD5pAxaGbFkrw1pUWxXWKuoS?=
 =?us-ascii?Q?N0iIqqfxHVid4fV/LT/gX7Ze9fiJf/HRyypujIouxMy2zQHiA4HMaMAu6+Jd?=
 =?us-ascii?Q?tYs4OfR1vOeHmSA9BEZsu3bAUyXbmUEsggOMjESk6iS+umkmrOBb53GRmn+o?=
 =?us-ascii?Q?DPGd/vMCgQe0pXJSlKv4Vx5zdv4pWgC3e7QPILsMF1muYgKf2ezT/4LGX5fU?=
 =?us-ascii?Q?22f3Iy00qSww2LrJqGzmvRVw+vICdGuhDU5bNxhAvu5EhO80J8ShRNicVZ63?=
 =?us-ascii?Q?B7O8qA2KEy9tJOFOOBzihHq31yJUITihkK+Ve/oRrMfdw84Uol6q+/DZJXmv?=
 =?us-ascii?Q?G/N7hDh2oAV8ypkoPc1rPwG8IaD1BUZE9f97uWuJegp93vGmtp9F3uFTi7YI?=
 =?us-ascii?Q?KCl+R/RYK7HmWv5siInk+HXULzHJW0/XFD6ljmrbeLceHMc6Hz5WInRqAU35?=
 =?us-ascii?Q?yX79lTiUcgZP9VF/RLBh1hlIpIxzGcYt9gmX2DM6QCpS24DG8mdQZWj5L5bo?=
 =?us-ascii?Q?DemYTBTXf98Tq3zqQi06feel1c8uHhlUfLzHQT8KTSVOQuzD+qDyW3YncUbw?=
 =?us-ascii?Q?Yi+79++AizygTy7J2wlm3VIq0l7yM+9udXK8ZxS1YBqmLqpAd/br/XkH1Yye?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f22fe9-09f5-4b9c-d46c-08dcf41317d1
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:03:23.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrs/zmMwtUiViCFPPfF1abctidKl47zdZPGrqyjSuMJf+l4NgkmT7hz8fJxttAaYD/xNdOFcSGf83JBlhLOiQ7ewAhYjELgIK/+0RuNIWWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7411

>+ Jiri
>
>On Mon, Oct 21, 2024 at 08:19:34PM +0800, Jinjian Song wrote:
>> From: Jinjian Song <songjinjian@hotmail.com>
>> 
>> Add support for userspace to switch on the debug port(ADB,MIPC).
>>  - ADB port: /dev/wwan0adb0
>>  - MIPC port: /dev/wwan0mipc0
>> 
>> Application can use ADB (Android Debg Bridge) port to implement
>> functions (shell, pull, push ...) by ADB protocol commands.
>> E.g., ADB commands:
>>  - A_OPEN: OPEN(local-id, 0, "destination")
>>  - A_WRTE: WRITE(local-id, remote-id, "data")
>>  - A_OKEY: READY(local-id, remote-id, "")
>>  - A_CLSE: CLOSE(local-id, remote-id, "")
>> 
>> Link: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
>> 
>> Application can use MIPC (Modem Information Process Center) port
>> to debug antenna tunner or noise profiling through this MTK modem
>> diagnostic interface.
>> 
>> By default, debug ports are not exposed, so using the command
>> to enable or disable debug ports.
>> 
>> Switch on debug port:
>>  - debug: 'echo debug > /sys/bus/pci/devices/${bdf}/t7xx_mode
>> 
>> Switch off debug port:
>>  - normal: 'echo normal > /sys/bus/pci/devices/${bdf}/t7xx_mode
>
>Hi,
>
>I am somewhat surprised to see vendor-specific sysfs controls being added.
>And I am wondering if another mechanism was considered. It seems to
>me that devlink would be appropriate. Jiri (CCed) may have an opinion on
>that.
>
>...

Hi Jiri,

T7XX is MTK WWAN device platform, ADB and MIPC channel is common in all MTK
platform, the ports used to debug, and we need a way to create the channels
to usespace, so use the sysfs to trigger that.

The previous plan consider using devlink framework to set param to create 
ports inside t7xx driver, but later after communicating with Loic and Jiri
, it was replaced with the current plan.
https://lore.kernel.org/all/CAMZdPi-qZ3JjZmEAtEmJETNzKd+k6UcLnLkM0MZoSZ1hKaOXuA@mail.gmail.com/

Best Regards,
Jinjian,

