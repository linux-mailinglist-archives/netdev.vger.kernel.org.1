Return-Path: <netdev+bounces-153990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BFB9FA957
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 03:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545441885D9D
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 02:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF792BB13;
	Mon, 23 Dec 2024 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="IsI5tjdB"
X-Original-To: netdev@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020081.outbound.protection.outlook.com [52.101.128.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D518052;
	Mon, 23 Dec 2024 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734920700; cv=fail; b=c2/rNyjmS8y5mgu6iX7CzXML3kY3eonBRk2QAN8Fzc3GK4+X5IRz23+SqapD6D0gOv1aWBa6dAGDGsNLBf13iw5rzq7a5k6THjKk9qYV0EqiuRSAMSnmZIjCukAiy9QT+lHpJ2WzZAGIJ+TgN9zCcZzXY1WyBGJBiexAdtX5JlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734920700; c=relaxed/simple;
	bh=2dcEuU7usy6VGF4YQu3pgbhbtSc98n5XJY6++hv5rxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Br9DJCTfeok5rnY1K95ByUI0lVjlcOOX/p95eIUpnEBn2R/DNG5XvRlaj8Q9qczMmgSamc+cT+0Q0PkL4zqUE36AS2ALBqWB3fsA15dv7cGmC1uF0hrtQFQ7lXrMqdgLBu2bVEIBlrFBVNAgM1WyZzl0fkblMmcRfBOBWsXTems=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=IsI5tjdB; arc=fail smtp.client-ip=52.101.128.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jImH/B9o/kEjFnAycJjzRjGdmk6m+04lnqF8jgceOFMB7Ww63h691sWyxAlO2Ch7YzhBVu22X77kM2V9EbfX6fL1q0Z7wuVe1JFY/YQUG6i+M1yi5GE/9zJVwUnwpfsbOVwrjf0INWQxDsxgdUIxCrekPw2+Tlde979rH5KVF9Gl5V2/J7R2T/byrTJFoKT7JsQ3K+B90jcdl8WH1KMsEsUOHweGmB3n597npV1i9BOsu0QWn7qOynb1BEeHQMOXFeO8cphmuU2XNdGd2ld8OPvwPqDKglGYz3WJQGS5bPdA/oME50Fob19n1V58uBuGv7RjXo4PC8tlxGna6NKRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPIuqAkEIhIc7SIxhIKtNTejNsj54ROHnT0uFQASbuc=;
 b=UAb0AihRGt3afKUqS0UTbtaJbdAwdsWGIEADfPwGbM1bvpz8bpAw21AqrBc0zt98Vp4qNO0bke3yKbD5iUzHsCMm+Ve/iuPXCGyJlqGdDiwW0omP7ads0UFusYr/9m44oiE8cNM0Hv7fr8WJn1r/48dftnw98dg7B/Zrs6Sr5IA4mbDzwCZE2Laiv/NN/BuHPdFfWdNLLiU1DIc3KfSSPWFRr+WFV97Zk+cDbLMMJQvQuVhd4eRv//DCYPVEoFO4ERTvM7wJSIP/oSw5dGQKiZl1ltWyXEB/SP4tewrwF9znEiAfu9uQdttBK4VfnOXMugzNtNhbgrdMpw0maWFbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPIuqAkEIhIc7SIxhIKtNTejNsj54ROHnT0uFQASbuc=;
 b=IsI5tjdB7KY2PGeuenKCPRfGxuLtzG+CBPzPvYMDh0HCulO/5uYq0HzhypbtfPgMohLZlPY+CSnqMyV/1BxqOQWO1AD62LG73ljGIaQfSdkwn0AyZa73BN+EhymCbhW4EXq4qaGcGebGav2UPMN3Oq3bkoDLNwCzfpTY0Rl6wgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by JH0PR02MB6849.apcprd02.prod.outlook.com (2603:1096:990:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Mon, 23 Dec
 2024 02:24:52 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 02:24:51 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: ryazanov.s.a@gmail.com,
	Jinjian Song <jinjian.song@fibocom.com>
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	helgaas@kernel.org,
	horms@kernel.org,
	johannes@sipsolutions.net,
	korneld@google.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	loic.poulain@linaro.org,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com
Subject: Re: [net v2] net: wwan: t7xx: Fix FSM command timeout issue
Date: Mon, 23 Dec 2024 10:24:18 +0800
Message-Id: <20241223022418.5795-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220085027.7692-1-jinjian.song@fibocom.com>
References: <20241213064720.122615-1-jinjian.song@fibocom.com> <20241220085027.7692-1-jinjian.song@fibocom.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|JH0PR02MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c6d310-9e18-4d27-906c-08dd22f8faea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3RycGpZME04YWJnMGJkSXZrTUo0L01SUU9nNjlHS05OeGpTaVFHbjQ3YzNV?=
 =?utf-8?B?RTQvWHYvNnRkZU5USmZRaTYxSDVUa1ZTNXBUOHh3MW9tSWJEVHg2eUdIMm8x?=
 =?utf-8?B?MnNGSDNmS0JVQ29GR29JNm9tb1VoSTdVRkhMd25NOWhtMkhnY2JPclB6ZXJ5?=
 =?utf-8?B?c0I5TkxUMTZValBaeE1nZTFlMzdwN3pVSVhPbWJmOVFMbGdpZ2xqZ1lhbEdy?=
 =?utf-8?B?MGtDSHRwcTNndmduNjlnWjdqbDJUYWZUMk9STUtjUTV3Y3Q4QS9IVCtzODA1?=
 =?utf-8?B?cXhBZ3JwYTBreXpxeUJkSndkdHVBWGIyck5oRGdDejkyaHdHRlpFY1JIMGhj?=
 =?utf-8?B?WlNmUDRCWWRCTk5oaGNZSjFFcm1GWG5KU1kyMkJhRjJZV2lYNjZYQnBxblJr?=
 =?utf-8?B?MFJJaktQMmJ3K2RaNUZQbFFwQTFuTEJ1NXB5QUd6R2NQQ0NIeDFoOGhlMW5S?=
 =?utf-8?B?cnIrUWlrWHBkbzczRmROclM5ZWk0VmJSejFOcDRTY3oybEFYTTBUZVVBMXBL?=
 =?utf-8?B?Sk5PZkRlMDBrcFNHaXo5Z2JhOEIvaHVnUkE5VmRXMnBadFR5WjhZaWloUVVy?=
 =?utf-8?B?VExsREhlaHpBZDZwNVRSQjRxZDlYMWtaeHh5bTdReWxqWG9VV05kdXdkQ1lF?=
 =?utf-8?B?d2pxSzZvR3ozZk9jMUh5UVlwM21WM2crZ3FQbFM5WXV4bTg3a1FnOTRtYnQ3?=
 =?utf-8?B?YWF5Y0FkY3JSYUdVMUNOcEVtMm9vYUo3aU5CTEFkMEFuQVpRN0dYRnBnT2tR?=
 =?utf-8?B?MlE5RVVpNEFlNUFCS2Q0UXhzUjVJY1crZWE1T0x1MG8vVk9Oams4TGxMWVZN?=
 =?utf-8?B?bGluNUYrN25WOEZER0dmVkJEYmFpNUNzMHduTmxrcDBSY0lLOGR1SlBPMTY2?=
 =?utf-8?B?dVRiOGcrMjZ5a254a1FPNnRVOGYzbXRPaFdlQ292SEhyN0Z2b29NS0Y3MkhD?=
 =?utf-8?B?V3N5UWl3cG03U3FPWGIrOU9RckRLVjV3ckg1ZlAvOGdzYmExS0wyQUJOalZ1?=
 =?utf-8?B?ZGxpcUpNbTlaNXRvU21oSHZLZU1XdzBKbmZnMk5MNDZnR2MvbmJ6aEF5YzBL?=
 =?utf-8?B?QUxYeStBejFzZi9zTGxVeTZaZnJ0ZStrTFhWcnNKR3BwU1IzUWxQRWkzbExZ?=
 =?utf-8?B?Q3g2eWpyejg1eUsvdkoxeXA1VUR2N0d0L2lCMXpOcUZjZy9DVGY0MmFDTjBq?=
 =?utf-8?B?MC9yVERucy9uOGNVV211NktEcFQvWjZrTU43eGEzY1lmUUZrdzRadDFQVDJs?=
 =?utf-8?B?ejFWSU14V2pXcFFFZzAzUUhZMkVFRytXZ2RaYTVpS3FzajdKRGFiMVp5OWlI?=
 =?utf-8?B?NVJBc3NIa1NvUXc4Vk9xK01NQ2ZmK0pVUS95TDFzNlM5R0pDL1prU0VDTjlt?=
 =?utf-8?B?S081KzBuMVBHNGY3d1NOWFpUNGJuNVNIcldsMEFXOFkwR3lPZzVHbjRVaVh2?=
 =?utf-8?B?bWxkVS9UZFgrZ2MyVWdUdWRUNDlDaGxmbXpLZzI1V041V211L3NwanMyMVhu?=
 =?utf-8?B?cFdCTDZwOVdiRThBV0NtbXNYeGE4YlFsZXlpbUVJN0I1eVNaVytkczY0YytH?=
 =?utf-8?B?NW1YdUZtQ3J1MXhrM29ZdFhlOGgwYmxpcFVuaXExZU1FQmlaOWFVdzV1ZTcy?=
 =?utf-8?B?NXNwQ1NabXlnVnR4dzJSQmFDNmt4eXcwK3YyNDVhdlIrZ0x0ZENoeDFIL2Fn?=
 =?utf-8?B?N2JMVlV4bThFQ0E4T0NuOHpuWFlEQzlCQko5WXJvY1o5NmxPL2FUSStuU09H?=
 =?utf-8?B?a2lISkN3YlVUanBQWFFWOEEvcnhPL1FOczZ4K0h6cU92M3oyYW1NTGIraEZ6?=
 =?utf-8?B?cVJ3K20zOVVUdzl5NlNDWmJQaTZzS2VwdHdvaFJNWVA0RzVKaE5QZjQ0Vi9S?=
 =?utf-8?B?cklZVEVzczhzZ3A0RENlckVZZzhzcFBPNTRnSW1zTzQ1RnRxMlBGL2dUNk80?=
 =?utf-8?Q?PI/5AqSvIuAR6IwG7kyBboLg3ypTnaGx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG96bFN5UEJ5aVBET0dtR0FzcXRiL2xpR0VIMUpPWnp5MzB5bUdLcU5CejlH?=
 =?utf-8?B?S1Mvell3NXFJS1QrK1JSREJlZGdNZXllWFYvUHhhUDBJcTN3TG1SM3Exenlh?=
 =?utf-8?B?RTZ1Q0gxSXJJbWJCcXRLZjFBelZUeUNSelJUbEFKMlRyNy9rcUFPTzU1c213?=
 =?utf-8?B?UU1leElsbmYzWkhEVHNoYjhGNFFMcU1NTXMzeFlkNThxVWVDT0pSUDZVYmZF?=
 =?utf-8?B?L0ttVFNLWG9NOHBpdlZzQmZWdk9ZS1FRcXZwa1hlM0pvKzNCNURMdzh3QjIr?=
 =?utf-8?B?d3dmSGMxRCtrVVBxeW41blRnTHVubEZGVjJoZ0dtOGpFaXhUK0Z2WmpqMk9z?=
 =?utf-8?B?NWFGN0RXU0s2eDgzTHRDT1lidnQ2cCs1QXVpd2ttZk56QlpOZlI2U3lZUmdx?=
 =?utf-8?B?ckZ0U1JOMmtvUmUyOHJUckxydmhEQytwNkc0anB0cnNteXdkeEpXd1A5aGV2?=
 =?utf-8?B?cGdjNGl2bWpId0UxNEJWamVKNzc0dWN3SDB2MkhYRnZCTkZteHk2UWc1bm9I?=
 =?utf-8?B?QlpEYlJpcm0xT09kUDBHTnJUTm5KSGZQaGZBT0U4cHBSRzFoOUp6YUVaaVlG?=
 =?utf-8?B?dGxzaURUc2lDQ3Rid3BsanJnbm8vcS9hdzZLNzkrYTR1QWIyVHdFZkQ3czUy?=
 =?utf-8?B?R05iRHFhWTBiTjlLZXdkQW4rcG9GTmc5TDl0SHJGdXpCTm40UWZwRC90aitV?=
 =?utf-8?B?cHphYWFUMXRFd3ZoWElBUU5RaVh3QjY3ZEFkUE53REV5QkVFQlgwYmdTckhw?=
 =?utf-8?B?Zi9iWldpei85MUFDRHIyQjRnUWw2NFVqT0xRMit0NTFTcjBBV1lVTmMvQm9T?=
 =?utf-8?B?Umh1dy85U2FTQ2VsSkFtRS9FZ3hLVlc4Q3FnUWtkeWV6dCtCUEgrMHNNcDhB?=
 =?utf-8?B?ZC9aSlRzZ05US0tSUGZZd1N1MTJpSUpwS09PSWNaODBJTllRTVlkUWVwSStM?=
 =?utf-8?B?ZGoxb29jVUx0RDhubHdsNm9qdjB3cVN2ZmJKbHRrRU9waG9lTW9WNzRnZW1Q?=
 =?utf-8?B?Q0dJSjl6aGRGL0l2bzV2cUlaczhIcHorM3RrQkNmTWR5RmUwUWxMeVZiWmJa?=
 =?utf-8?B?K1lxaTVxeHp0eXA4RVp5M0FKbE12VEF3NytXODNXSWt2L05GOW1xQmtWMVor?=
 =?utf-8?B?bkxjYjdTaExtYlg2QUZ6ZkNwajdrUUw2Sm5RN3FKYmJZUHp4WjhKcG82R3Qy?=
 =?utf-8?B?TE14L0Y3cVZ0RmV3bDhBSnlpaytHQWJjb21GV2podHNyd2ZkQ0VHbnlPb3RR?=
 =?utf-8?B?WUJiZzZlc0MwWFhWam5jWWczSmVqdWtHakxvWC9MQXNVa0haNGcwdkRtK2t2?=
 =?utf-8?B?ZG9IS1o2Q0IvS0R0dXVtUmMxUExXKzBqUk9PaHFTVjBwT0dqalJHSXArNjNh?=
 =?utf-8?B?VkxQbFRmamZYTkRsZjRsM0dhVm9qQU9rV1hmbEJicXhjeDBhRG15L0RBY1h2?=
 =?utf-8?B?V0Q5Q0tJSFkvMVBhNmRPVytROTJQQkRkV0craVRnM2dNekpYRUxBNmlQQ0V1?=
 =?utf-8?B?NHJ2UVA2Z2tUSHZoNFkrNUlqZ09UYXVNSktZSXB2YUMyOVZVeUZ4NllPbEY0?=
 =?utf-8?B?bHRhYmkyd2tkLzUvRmpaVCtGMG9GWEs0MzJIcThxcmE4NUNEbGw2Z3ZsRlc1?=
 =?utf-8?B?Zk05Y3BnejdMZTBZeERjNjUzYlcxUTF0bGNud0JGbURoblQrclREZGtUdGhn?=
 =?utf-8?B?NE5zNURWbHpNeGNySUJ2bHdFYjNLcHRwcHFsWVhROFRIckZYa1ljWThSa3dY?=
 =?utf-8?B?WG9tZy9lN0hqUWdBV2Z0d1RkR2JFRmY1RTYrS2FpOVhxdFl3WE5RVVA3VWZJ?=
 =?utf-8?B?dWxWeGxiZnBVSlhJTGU2Zmp6V3FYOHB4RU5NUTVId2FCUUs2ZmJRSmxzK3lm?=
 =?utf-8?B?TVd6c1BIOW1oZzB4MWhCYmNBelJhOStCUVlSQnllVjliaXBmT01kZjVxek55?=
 =?utf-8?B?TlZVQzN4UnBPTHpPeCs4dm8zdEh1ZUgwU29uNHVXUEczT1dGUzBJMVBmTmZ0?=
 =?utf-8?B?ODcyZFVsekJkclg2aFFsVnliQlhWdzJTN21CSmNJMml1djJDOGZnUmVkK2J4?=
 =?utf-8?B?NjZwT0xFQ2o2VjY3RXA2bGNTb0xVKzVzQWxsOEVWa25OT25mUkZxRCtqR2d1?=
 =?utf-8?B?dkw3cUFyVlpSNm5PbEhjNTJSVVM5WFZNM0JCQ3hpcVd2UTNicnZyWm40YXFi?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c6d310-9e18-4d27-906c-08dd22f8faea
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 02:24:51.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ju/9YQ/aiECav1EkToWKgNL5t8ATYu1ZWuDtWv8NSbgdFz/g1D5/4Obhl79B/rANaZ9ffTl0AfDjVDOA/XR5iB6bVrX2siZ13JPacgiyb+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6849

From: Sergey Ryazanov <ryazanov.s.a@gmail.com>

>Hi Jinjian,
>
>On 20.12.2024 10:50, Jinjian Song wrote:
>> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> 
>>>> Fixes: d785ed945de6 ("net: wwan: t7xx: PCIe reset rescan")
>>>
>>> The completion waiting was introduced in a different commit. I 
>>> believe, the fix tag should be 13e920d93e37 ("net: wwan: t7xx: Add 
>>> core components")
>>>
>> 
>> Got it.
>
>[...]
>
>> Yes, the patch works fine, needs some minor modifications, could we 
>> feedback to the driver author to merge these changes.
>
>Looks like the drivers authors haven't enough time to maintain it. You 
>are the most active developer at the moment. Could formally resend the 
>updated patch with refcounter as V3? And, I believe, we can apply it.

Hi Sergey,

Yes, please let me resend the updated patch as suggested.

Thanks.

Jinjian,
Best Regards.

