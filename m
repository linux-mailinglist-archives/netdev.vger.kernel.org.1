Return-Path: <netdev+bounces-98004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264D8CE873
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 18:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458291C20AF7
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36BF12DD8E;
	Fri, 24 May 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QOvJMrLl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8431E12C485
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566845; cv=fail; b=ppBrR8ov5Lg8FsUMGp0XDxk1hpPvxvjHJkqy6NXWyztYvm6VyoWO1CLqjKhlXUi3+X5mdaLE1uVfcB9pnklTkjnJMe07iRhik/lwhfz1Hm4GI6r466+1TWRdp7xh9f+h2vLJUqnJX3/vdY+Nfw7y7lMvmdEtA2V2p1D/pBeNrAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566845; c=relaxed/simple;
	bh=H3Q1FkQPSMw1fB9p0wn8Z8xQx7s25KjMOCmPN0e6wUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WKTqxA4GQ6qoSuvx2m6mvi/n7zUyqE5EDHtzt/827iAW6saBULh0YyCn8RRipExc5Dci7BhWz25qk+UzchoE9eI6Y56Rv/xjz09zIjTZ/1Y0x/ROGS873IZXj8ZOa8WwVXsP2R6IYXQyT1ilXw/AFGsXE03GQsdQgeEFoBSTO0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QOvJMrLl; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmTKvkWmh1B/0HEnEe0bMde34mnt3Oj9iIGhh94mDLIQitDPPIgtmwSNMfva+UentstB2qLVMhLChWIsFIUT5RPfrbcq65XAYx9L7+T73dLX5tsHYO9W4oHVpvMfxgudcMV1zXY5CaOqoTBCkWvF0Agn+GjF0F1FecnPhxx1vChXO+UzYIMcI9Q9B14U3oTGJ9vDajhgAgKvvmXjWn36TtBqf0RYXNhgCZqFxSPWfsq7WXlCSnY6pXyV1DBb9SBZzXJHPupsE4l3MvZ1x9VULhDQSkF1IT1FwQJD+tgImeHcGgVh6QtyfkpZwfaxHCoJXxDBV5jsVkOr0W59yU/OpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol3Q980vmr5lbfKDcFUgWJbgLhvwitM5gRUgU3T7QhU=;
 b=Uutae+Zj3fDZQyeVJK/HJKAsubZwwuEPFMXv3+6mrvYBedCEImM7ssVXrqcF7jVv1B5MNAMnTwdqeFiodnou5H5DbcSSsxUQfPnYw+PazJmk1AGJtlgWVohv7FzA23Ym6IH7NcY1OG09FGz8xs4Q7C36sv6BtcHKHFvDnhzAdPOe9j9ztmpJrgxIhoyjbo3teOIo/JYFD/F5/zt0pCg/jafVMj+UpTNv409PTzJVvCaRsnplelPUglAeL5OF5bUJmgZ42lCcRJD7hCFkmqXz4vTki3aE3xykKkmkryiY95GWvyoF1KqIllyBbEmaRYImXeb8YCH0LUFfSRsHWALwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ol3Q980vmr5lbfKDcFUgWJbgLhvwitM5gRUgU3T7QhU=;
 b=QOvJMrLlUnchRt3aoQivcgWhy3XBuAZSK3iUI6xu8+oEpVzJ90vXWrJKcxUbwIRWwwS+243+keaq8iukaHI4IN+l5jf3YsyJwgbga5Lq+b/U8jnvzlUD4Cf0+KzeigHxd94etV4IJg6/NzeHYyPpofxvqF/O+5YK6bxaEJY8HOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PR3PR04MB7467.eurprd04.prod.outlook.com (2603:10a6:102:80::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 16:07:20 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::f581:5987:5622:e9d8]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::f581:5987:5622:e9d8%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 16:07:20 +0000
Date: Fri, 24 May 2024 19:07:18 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net] net/sched: taprio: fix duration_to_length()
Message-ID: <20240524160718.mak4p7jan2t5qfoz@skbuf>
References: <20240523134549.160106-1-edumazet@google.com>
 <20240524153948.57ueybbqeyb33lxj@skbuf>
 <CANn89iKwinmr=XnsA=N0NiGJhMvZKXuehPmViniMFo7PQeePWQ@mail.gmail.com>
 <CANn89iKtp6S1guEb75nswR=baG4KN11s9m+HQZQ+v_ig3tOUfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKtp6S1guEb75nswR=baG4KN11s9m+HQZQ+v_ig3tOUfg@mail.gmail.com>
X-ClientProxiedBy: VI1PR07CA0307.eurprd07.prod.outlook.com
 (2603:10a6:800:130::35) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PR3PR04MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8414b5-8fc3-43a3-53a6-08dc7c0b9745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGliMkpTSmxHRjJNM1JxSDEvTkM2U0RvUFZob09sVkUwUitvakwvcExvaFg3?=
 =?utf-8?B?emFQTEFnU2NJcE1vOTRWbytFVVQvUU4yb2xmZllzTmZPMlBMaHg3VnZ4aXV6?=
 =?utf-8?B?amtIWUNjeVluZTI2NjBBS2VIdTVlRU8wejV5OE5TWk5xazc0OCtjS0lGcWJC?=
 =?utf-8?B?eEtVNG5yZkgvRVk4WVhrUzhXV1g1S1l5ZCtyOUMySmFjanBCZ0c3OVJmVkJK?=
 =?utf-8?B?Y243cXJJN1NTSW1VUFZmMzB0NVpScGZOUU5WTGw3U3VRZ3I0UHNHRmlkYUVS?=
 =?utf-8?B?TEQxNUxpUkI1aDVnWnU5UklLR3FSNm91UWdlK2lyeGJXdExzbVlZZStSQk5L?=
 =?utf-8?B?eDdWUzF2Yk5IQ25BWjF2VTl6N0JBZFRnYzFtTWVQZ0hFT09FQktVRXpDdlR6?=
 =?utf-8?B?TDh5cmRya2JPWkprTXBVOWJGemhucVI5OGdtc1I1dWZTc0p3MSs5czlQZXpE?=
 =?utf-8?B?bzJLa051S1d4T2krYThvYXBaZUVabEx4ZVI1MGovakd3b3RLekVEczdHUWxG?=
 =?utf-8?B?c294NER6QUd1THFCWlJwWkNYMUVzWnRpMnlldHpaWkZJZUtrT1Z1dzhXeW1C?=
 =?utf-8?B?alo0a3BCbkpEWGpXSVBnMDRwcjR4cG5qMXNGZ3BWK2xlUmt5Rkl2cmR2UlhO?=
 =?utf-8?B?S3IxU3ltTk9ZOHNnVlgzajFiS1RkdERtYnNVTW9RRktnVEF6bUFNOElyRVNu?=
 =?utf-8?B?bjROOEdEUUkvTUNkNlUzT0NaMnpuK2lMUXUrdUwvSG9tcHlPMTUyWmtwZkRN?=
 =?utf-8?B?YWt0VkRQK0FDYzRNeG1ISmw1Z1pnZXMvWElNd2V4dGxpWWtRdURmVDdIelli?=
 =?utf-8?B?VHYrYUZna1kyV25QOXdzaTdlamNMcmR1MWI0U0NRM0M4T0d3aDErd1pzWnJr?=
 =?utf-8?B?dk1DMEpqeW8wYmdlOHcrZlY2Z0g2YXQreHdsUnlmdi9wSWUrUkZZTWtvUU9k?=
 =?utf-8?B?VUd0S2I3SldYbkFjQS9USElEQjQ4YUQyZFdrL3JCd25pS3pzS1phdXN0YmtV?=
 =?utf-8?B?MUZsNmd4d3VOYnZDaXZ0N0Y2MitaUEQ0Z01EYk1NbGlzZjNxeWJuMlJ6WGM0?=
 =?utf-8?B?S0lsNzNVZHhYMVlGN2Vudk8yQXNrU3FuS3hCS3Azb3J5Y0tJalpLZ2k0djBO?=
 =?utf-8?B?cVhjWmphMjJvQnArU1A2bEY5WHFUOTZ5L2ZBZ0VmNkhXWHJuakhTSlRvSENk?=
 =?utf-8?B?WXV5T3AxM09GMVhMRGoxUmx3QXdxRXJsMHF0bENMdlg0eFBlVG1RTE13NUo1?=
 =?utf-8?B?aUVvZ2M5UFd4VnVXRjFRaFh0eWVYc1RrRXFhN2JRYk1ZSGNsUVVYUlF2aGhB?=
 =?utf-8?B?S1JrTENXdGxRWTFUV28zS3RnWXIydFJYY09GalRzZHV4THZuYythdks2WGts?=
 =?utf-8?B?SEJzbmx5Z1NSOVkycEViVlBLbEgxVUZ3OW1Td3B4NzNLa1AyTTJkRERDcmVP?=
 =?utf-8?B?SERWem54eExCaHpoejQxa2dDbjhjTWlQVm1oenVaOTBnOFoxU0lhSU1UQk5H?=
 =?utf-8?B?S0VGVGhWdVJGWVl3QlZYcStiSFd2Ym1GN2xpVkNja3hOVjFuTHlINEpmSUN3?=
 =?utf-8?B?T3JsY2NuNlpabFNRRFVRVktqOXNDeVI4RUtIZGtEd2tBWGhMVzZWSGdTNW5k?=
 =?utf-8?B?YzZEcVQyUzJCY1ZIR0ZhY25lMjdkRGRGYzRaK0pNa2dLNmNuRFlsaFdHN1NR?=
 =?utf-8?B?TUN6QUtJbDFDQTJsMHE5MStDNXJDaEM0ZWRyM0RsTUY4OEdLTHJ6YklBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXRoNXZBczIyMGhRU2ZmU0tEcis4ODJTU3VKc2szUEQ1VDkvV3B4cEdKRUJD?=
 =?utf-8?B?L1gzRFFaREFLTm5xem55cWVac3A1bEtFZkNJNHRsQUhkaXBJSXdyaWVUSEha?=
 =?utf-8?B?aUp2WVRsTmxra2J6RUp3N0x3aDBGb09QMng2WTFvWER6SytKNGpBOWFPVmhy?=
 =?utf-8?B?ZVBXV1VuMUVTRGtIVFNrYUQ3NFk1N0hQcGtXWWkyV1ZtU1JFbFF3OWhOSC9S?=
 =?utf-8?B?Rlk1eENsY3BYS0JrWXVhK2Nuc1ZzL25kMytrQTI5cFMzNE44UW1RcS9NWmtZ?=
 =?utf-8?B?TmhDbXJ4L3Y4cmQyWDZjQ3o1ZGY1d2ZLcFhXRGwwbXhsMmx1aG9RK2k3cGhX?=
 =?utf-8?B?UFVFdnVGV21VTFRFQzZYdG1iV1Ivdk5LdnlUTG9rWC90MDJaNGg3M05wazEr?=
 =?utf-8?B?T0VxeVp6Lzg4cFJtRUY4VE9QYnVzMVBoODJVYkZKZ1h4Qm5Qb2ZMdGZYbkRs?=
 =?utf-8?B?bVpTbm52ZGtVUmlpTktSWGlMWEswSVRVb1VOd2lmQ1FWeGJDZ1VjZ3RpYzI2?=
 =?utf-8?B?cjI4ME4ycWhITXJOYXdvWlpvMmFLL2c0a0ZwL24wcVdmZXJVdkFrUnpab1l6?=
 =?utf-8?B?UHBoSk1tQjFIdXZNSllOT25SMDEyRnRuUm1vZnJLa3N3TG13aUsvQnVTeGdS?=
 =?utf-8?B?WDJmeG5hekdiS1Ird1d1c1dLVllZYUxiVTVMMzhoVWJxTkxvOGROSnhKNXhs?=
 =?utf-8?B?MXZybURRWWxIQXRMRkREcjY1ZWlPQjNjYS9oVHJiUmxKbjVxSXNmbHFDaTVN?=
 =?utf-8?B?c091VkNqMWh5ZHdZMXVKakNDR0FNdUFxcVVzV2NkMXYyVEZEeWF5TlVzZWFp?=
 =?utf-8?B?VmxZbXp0ZzlHcVcxQXFwc2VLK2dxS2xyaDU0N3RIWmpsUHZyaDFobXhSVm5p?=
 =?utf-8?B?WG5xSHlSL2g3eDFHenV3cko2WkFIeXM4eE5JYURnM1BER3QxcHo2QzlnY0VU?=
 =?utf-8?B?Y0VvR0tCKzYxSFNuUWNJc0RKNmMrYXM4UWhDRHJjWDBhQUtWYnBXK1A1T3dS?=
 =?utf-8?B?emlKYXVHUlkxQWJkVGx0TkcwUDNSMDU3ZTZnTEVkYlRkOUNBS0NSNHBBaGdH?=
 =?utf-8?B?REFaczJSbHJDbklyaTJwZmRrd09hajI2dndvTVNET1BZbWNiaDNXNTl3dTYr?=
 =?utf-8?B?a0xKUTVXYlFKcUxxOHVoVkJYNkxwKzdrdmdCaU4xS1FBVnF0U2M1cnZweWR4?=
 =?utf-8?B?UjZ1TFl1ZXNWOEFrZVV1Ni8wbStDTFVvbmNwQUJpMUlPTFFvS0lpM1IwcnZ0?=
 =?utf-8?B?TWRrYkdWOVZNVFRRaHdyQ2NMUDRkN25BWVJtRnVNUnVWYWkvcGdidUVmb2ZL?=
 =?utf-8?B?djlTU29ySERvZituWUl4Qk9pMEI1eEoyNWNlSVBQb2o5K2tIR3VRaE5BRlJi?=
 =?utf-8?B?RHhWL3VwUlhOamlXek5ybWFwYTN0RWc4ZmpKMUVuSmd3QVA4YnJud282Y2pT?=
 =?utf-8?B?Yzh3WnFDc0F5VzJ3TzUySWsrUDFoSzM3MXlzVStQaWlJem9YdU5jY0lPdGU2?=
 =?utf-8?B?b1R0V3YyNHJiWjRtTi9JYXB4c1VmSE1VWnlrZ2VXRGZWV0VPOFRmb2JTall2?=
 =?utf-8?B?UnBIQ3ZzaTg1RWhoa0cvSG5jOTFtQTVTcXhLbXRGdW9aN0FNTUdrRTU5TDlJ?=
 =?utf-8?B?djU1UDdTRDNDby8zM24xRXF4dm1kMHZWTzJXejBQK2dFSTZsQ0FPRU1BV3py?=
 =?utf-8?B?eis3TlBFaHo2aG1NMzhsK0p2T2xmS1FWVmNkenA1S2hoaFZrMkc3VVAwTDNR?=
 =?utf-8?B?b05lWVNsbTN4WjhYVGVUMk1US2ZyMWozTUhGV1JpSXNDckFsZGJCR3hsNjdU?=
 =?utf-8?B?QnpyUmRSaUZwZTBqckxHWDdhaktJR1JWMkFrVVl4c0QwZ2JqbUN1OEZKZE9u?=
 =?utf-8?B?M2lqd2xDNko0Zkk1RDA4MWpWQklBNlc0bEVtaEFKSDlxanY2SnJFNGtIdzNS?=
 =?utf-8?B?QTAvS1NnL0RUNWU0Wko1U1lWd1pSZHZYejJyanB2cU0vd3FhUkt6SVZLTlpR?=
 =?utf-8?B?LzQ4MWpFbEdrZDlIL2VsZVFmb2VZY2ZjUUVack5pTGVXOU01TVRzTTBod3ly?=
 =?utf-8?B?VTNwMW9SRW8wMzJKNHF0aHdUSEZjeVpnUXU4T01rbURyN1NZREJQcitId2Q1?=
 =?utf-8?B?akJqK3FZcDdKRmdaZGdJbVBpMmduN3RsWXFReDR2WUkwYkM4OGZ6dDVNZTN3?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8414b5-8fc3-43a3-53a6-08dc7c0b9745
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 16:07:20.5344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByOK9WiVSWi+qw4Al0GB2nn8v+nptbsoeZjoNiJZ/bj8g1xY6Uv98kOGyYPFTUA22/zudU5Qn7u19+cbAmFl+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7467

On Fri, May 24, 2024 at 05:52:17PM +0200, Eric Dumazet wrote:
> On Fri, May 24, 2024 at 5:50 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, May 24, 2024 at 5:39 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > >
> > > On Thu, May 23, 2024 at 01:45:49PM +0000, Eric Dumazet wrote:
> > > > duration_to_length() is incorrectly using div_u64()
> > > > instead of div64_u64().
> > > > ---
> > > >  net/sched/sch_taprio.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > > > index 1ab17e8a72605385280fad9b7f656a6771236acc..827fb81fc63a098304bad198fadd4aed55d1fec4 100644
> > > > --- a/net/sched/sch_taprio.c
> > > > +++ b/net/sched/sch_taprio.c
> > > > @@ -256,7 +256,8 @@ static int length_to_duration(struct taprio_sched *q, int len)
> > > >
> > > >  static int duration_to_length(struct taprio_sched *q, u64 duration)
> > > >  {
> > > > -     return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->picos_per_byte));
> > > > +     return div64_u64(duration * PSEC_PER_NSEC,
> > > > +                      atomic64_read(&q->picos_per_byte));
> > > >  }
> > >
> > > There's a netdev_dbg() in taprio_set_picos_per_byte(). Could you turn
> > > that on? I'm curious what was the q->picos_per_byte value that triggered
> > > the 64-bit division fault. There are a few weird things about
> > > q->picos_per_byte's representation and use as an atomic64_t (s64) type.
> >
> >
> > No repro yet.
> >
> > Anything with 32 low order bits cleared would trigger a divide by 0.
> >
> > (1ULL << 32) picoseconds is only 4.294 ms
> 
> BTW, just a reminder, div_u64() is a divide by a 32bit value...
> 
> static inline u64 div_u64(u64 dividend, u32 divisor)
> ...

The thing is that I don't see how q->picos_per_byte could take any sane
value of either 0 or a multiple of 2^32. Its formula is "(USEC_PER_SEC * 8) / speed"
where "speed" is the link speed: 10, 100, 1000 etc. The special cases
of speed=0 and speed=SPEED_UNKNOWN are handled by falling back to SPEED_10
in the picos_per_byte calculation.

For q->picos_per_byte to be larger than 2^32, "speed" would have to be
smaller than 8000000 / U32_MAX (0.001862645).

For q->picos_per_byte to be exactly 0, "speed" would have to be larger
than 8000000. But the largest defined speed in include/uapi/linux/ethtool.h
is precisely SPEED_800000, leading to an expected q->picos_per_byte of 1.

