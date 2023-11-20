Return-Path: <netdev+bounces-49220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AFC7F136E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 13:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5298FB211A9
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D06D79F6;
	Mon, 20 Nov 2023 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JIcmyV+P"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C988D2;
	Mon, 20 Nov 2023 04:35:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ3IU2yLDId+SilFvMgRRl1BXzIiGSBYayJpi58gglv71D11jLX7rqUPhNQo+0zEpQP9e8SLVeLuU3+KYMLrIlB8gA+eLHSojjA4UeCUmRU/LlN3NXLwzv/BMr3EYvAwA1cUx4Ce9OYZ0W61milCK+Rhpkr+8gsN0tulsbVDwdz1/mDy/exkeitOxJQoQ++NLItCIfXnDlD1WxtvOAfnoDKFu2Wx8RBkPyvHlxvAk0qWitxlIw1iQA6vRnraAXFg6VYIxJLk6k6ATj+pTd/kAhtaRyW4HE8cdiB2GZD+58/D6cOHMu4uKMDRCHFU0fi0w94NZGuVPzKjtNCKbTrOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrN2H9dsAmFdh4wABP5fVq94DT2UZKIY/5jVRuXjBC0=;
 b=VLp5k0bNRHxPLzj6RAM9xVDSaffKLursdOVM2Gfo0Slym1w0m5nUu5WYZenNrOSloTRj9J3RXRHCgTlXNMkoIE9SSIsp493lZRz46GCzUmgOYTTFWdWQO6ggnC0PKXDgeFoasWEgHz8XSxYMF+F+M+b9tktN0cS2FlSmJCJ/NmJi7243papTkw8BGGi/7d6y4MmDxxQfCQfRHxyaqQs9sohIa93XWApboC1I61Q3fi2fB0QuCWw06rW/SoYjaXbZAOI6aGgFdayeiRjMdV/MbDT2GpsuWMnJJ2EKE2iD/zj8+B4YpI8uBkVgQtahdiq7FkpLZaslYGKtDrBHNMWUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrN2H9dsAmFdh4wABP5fVq94DT2UZKIY/5jVRuXjBC0=;
 b=JIcmyV+PSKW2ZS5rK/yRdxsMw/29uurqGVBR9DLawUQJTyZW+GZgdiIJgMCGDsLr+2+LX86XJjbUVa3jUN9siEF2SmqpxYQd/b0+vZSVXgIdu25S3cS+fHub2v3VWLAJuexxV+rdc4iKssxcOUw3QtXDKFmpoZFMzi26FYTj4caC6gmmIAoYcTe8/QHuAM16tKIiOdThDSoatGlEiqXXuvLLgUBu9eSKvhlQI1tu84WonWm/hLH9ec3i4EVth80HWqt2iCpcMS09blw/cegDMENXlM6jCCmxLVUjBnhTzoZ6PVT0BsTANVDUGsnbLz4o66SbbgnaN3QHojpR1R54sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by PA4PR04MB8047.eurprd04.prod.outlook.com (2603:10a6:102:cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 12:35:16 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%7]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 12:35:16 +0000
Message-ID: <73f614e6-796e-415d-9954-8a94105f5e1c@suse.com>
Date: Mon, 20 Nov 2023 13:35:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: possible proble with skb_pull() in smsc75xx_rx_fixup()
Content-Language: en-US
To: Szymon Heidrich <szymon.heidrich@gmail.com>,
 Oliver Neukum <oneukum@suse.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
References: <7f704401-8fe8-487f-8d45-397e3a88417f@suse.com>
 <EB9ACA9B-78ED-48C3-99D6-86E886557FBC@gmail.com>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <EB9ACA9B-78ED-48C3-99D6-86E886557FBC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|PA4PR04MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: fd1725d3-927f-4462-3ddf-08dbe9c52616
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A9xt+d+tTLXC3Xjd/sT7unQ0Y+yXLosc1PYaUxJsO+b0Q700co+SOh/QsxeOW0Fo3E4BgxqOWdjGNsyvuDE50ZbM44mNJ6IUsQXWLqG8fe1qCutcaayLw5K0Jne8jkRtLn1/z9/HuuJG8LLHtrH7Z9CoyFWGMt0MODLsn7JDgv7M5t3shOyINA7HEg2XJ6IkNccoXh8TjJQkzbM9NbGx2AnL1Z/L4Z+XY5+18BfnowuiTZs+TKoDu7Jr8YZXRW/nPvhsqrBJRZUhygKVf4S6ac9Y5kAcDU0aR82Qw7XeufK/ow7imge6iKrIimX6fyAH7yL8iqkLK3ScECuYMCzoYG8rsfCqdfreDv8LRHqyAhZdxN3FroDj1BG//Gp6pfx+PSSb90T1mYbMNnaqdMwl+9ujd6MHg3/NWMXoWDGkrFY5bWlovhclVmbgxwn40zueANDG6bu5C5AqTcYH5j9EIXroR3XmNuEKF/gNN9UkO1huWT1gOxmvcRXy4hDrInq5Cvqb5IGUXdXjdXYPf8mgsGiAIwCbgXP/fSTWQkRmzPw5c0mMODjZe75AN/4Rd4rnBT+xjoFw4Cr0K74HoPZc17K1LbDKhEYLgGAWszKW96bw1apoBYnqO4IsadiqlN1TCYBV+Vn5sm4gd0oDmw6+EQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4744005)(5660300002)(2906002)(2616005)(4326008)(8676002)(8936002)(31696002)(41300700001)(86362001)(36756003)(66946007)(53546011)(110136005)(66556008)(66476007)(54906003)(6506007)(316002)(478600001)(6486002)(6512007)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTRwTXV2d2ZSd1Rob0NWN0Jpc1hJTkI0QjF6ZW8za1FXWUY0QWVQRnEwVVhZ?=
 =?utf-8?B?UnBybTFCUnN4OUk1dWl0eFc3UHZIeW4rMlRBNDJzZXQrVzFCMDROOG42NkR2?=
 =?utf-8?B?UVJ4ZXBqOXJPUnEzaHo2L0tpWUg5akMra2FzZ1Yyak42WkJFS2VyTDRZQjVj?=
 =?utf-8?B?TlFkM1hYOVNVbDdmVGpNU3FwS0VBNmMraWFiV3JHRnZ5ZmR4bkZnT0c4UDNC?=
 =?utf-8?B?Y3FYdlA4VitxVFFtVUxqbStwTW1yNTlsZXdCQkIrMHRNcW1XMXIrd1FlK28r?=
 =?utf-8?B?cWVzbEZwVVJwL0pVUjlMb2svSkREb04wL3E4MEJvZTJLNHFJQzFiOXhjeWlF?=
 =?utf-8?B?bC92K2s1TGpoZzN1S2F0M2FFMkZpUTJZTG9FN2kwS0p3RWR3UisvWmRmN2M2?=
 =?utf-8?B?b3kyUnpmRTZYN1lYdHNNWXV5eFRucENKVE9BYVI1RmdSaldzQUVUcnlpK0RN?=
 =?utf-8?B?NDVqRkFzMldDUWVsR3VsdXJVRGJhbkNlRnBkQ0ZMOGZpczBLcHZ3dFdyeEpn?=
 =?utf-8?B?eDBCc0ZqWmpKOU5MOXVnbFdPWDNZRjY3QWV6OTJkcW1yUFZERVpVY2hYQ1Vo?=
 =?utf-8?B?UWFINFRLNXQwL3FZY2FIUy84THVEYlVkSlN5cVBaY1lDZTV5U1Y3NElTQ0d3?=
 =?utf-8?B?a3cyUUI1T0h5aXBRY3RVcUZiMkQyOUYyVEFuUTR5RHM4d2toQmVqd21sc2Vy?=
 =?utf-8?B?QVFBR2NzUkI1NHpqRzBtQTdBTVk4L0x1QlJtSUdXYnZBZnRpYk04MnErb2FJ?=
 =?utf-8?B?cVdsTk1UbHNPbGRpN3hLb0RPU3FIMFU0SE9yc01xT3R5bVcyRUJtYXBFbTUz?=
 =?utf-8?B?c3RtZXJYZkcxcDdmc0xES003Vm01bUk1NHp3aFA5UnJ3bThXblcrSHRjWnZn?=
 =?utf-8?B?QUQwLzZORXlTQWFaeWtvU3VoNDR5ejgvRnkvczFJN0JXWk5lc0NnR01zK1p0?=
 =?utf-8?B?WjNBMEF4VmUrcUNqTVVVWExOR3ovYUt4b1BoMDFmYkRpRkNBbGdnR0RSNzVT?=
 =?utf-8?B?SmlUdWx6dk9wamVUVm85M3BaREMwZktvYzNkNTdrS1RoS2ZHZWNjYVo4RVlF?=
 =?utf-8?B?SVo1RGJBZVhxMmZ0TDN0M3BEZzl6QWpRZzZYeFpkbzVkNm9UbWxPQmh1T3p0?=
 =?utf-8?B?NUdHRS9tYmNTR3M3Tmw4OFNsUnA2Nk9oYnYzbnlad0pMZ2hvN3BaeEpCQ1pK?=
 =?utf-8?B?Z1VTMWtXVE1nMDVZZ081VnZnRVRyYUtyRng5elNOekNJV1BpRHdRelU4YURk?=
 =?utf-8?B?ajI5M3A2QWZaR2tLSlh3bzUvdzB2VUJnYmVmN0JXSDZKNDlPbnJ5M3VvZVZL?=
 =?utf-8?B?c3E2dTRWM25Fdm8zZ2E1MWZaV2VOWkRUT1JFRk9zWG1SUTlxVVk4b1ZiZ2Jx?=
 =?utf-8?B?cUJyU0hEMnllOG8rQ1p2Vys5SEYxL1lHb2lZakF5OERTWjRMYTVWWXhOOUJT?=
 =?utf-8?B?WXVMWElBMmRXZ29iRE8vWDRFdXR1MFlnZzN5ZGdEUjBIdXlQc1d0SnVZMUNZ?=
 =?utf-8?B?ZmFQSytHczlQMUlUV215SHhEa0VqR2g3UDdwdzZkdVpPZ1dDeEhqK0tvZjRE?=
 =?utf-8?B?ZlFuVUJFb1VZVkFVL0NrYWV1RTRjZHdnTXNzS0MvdysyWCtabFVGbmE2M2J5?=
 =?utf-8?B?QlpFbkxPRGUxQVIyWmhJaGFpQTdsYlM5Zm1qR1ZxWDJBS00rajBLOXA5eDlt?=
 =?utf-8?B?cG5Hb0cwVXhkWkx5VHJOTSswQmY3WVRnaitoaTB6T3UxN2ZMMml4YzZKZmZB?=
 =?utf-8?B?QlB2Ujd3dk80em1waDR0MkJZNVM1T0FNVE1rQUlheEM1ak1HVm5qQmNOTi9q?=
 =?utf-8?B?NmU4cS9zQTJ0N0o1UHUzakh4bVFpUUFYNHVnaDcvai9sSGtYVXFkUHNyc1Fl?=
 =?utf-8?B?V01jMlhUOTJYeTlLVDVGY2dZUUl0eDNGVlBtdFdEakt5Sm90MUlsQ1RDTVF6?=
 =?utf-8?B?SFhPTThlUzRkUkVMZy8wTDFCSUw3MVNtaHFUaFhsMld5UzVsalFsYmp1dnBl?=
 =?utf-8?B?ZEpzY3g2ZUt4cklPVVhVYkV0RTR4cE96Tm8zc0UxQjNZdW9rcGZKUlk0S3Nq?=
 =?utf-8?B?a2xlcWZ5WSsyajBBeThKTnh4K3NyZmVicng0eks0QXlVUG5sbFFoODN5TFlW?=
 =?utf-8?B?cVBNcnpNT3Vzem9UN3BlWmRYWGRSS0o5TEszMURWY2ZaZXBUYWJwMEpkbGxn?=
 =?utf-8?Q?00hGYL6GHffOK+x5qoufMhMo8Q47mxBz0RLQ8xwvyagW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1725d3-927f-4462-3ddf-08dbe9c52616
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:35:16.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmhkTUNmCNLJG19/xU84HAXeOMDvigpsswYYq27O+TyVo7rK9j2l+8uk087Nbu2wZz0ggpwiluHlmK3R4qz34Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8047

On 16.11.23 21:09, Szymon Heidrich wrote:
> Hello Oliver,
> 
> Could you please give me some hints how this could be practically exploited to cause mischief?

Hi,

it seems to me like you can easily feed stuff that is not
part of a packet into the network layer, but you cannot overflow the buffer.
In other words, the issue exists, but using it to do harm is hard.

	Regards
		Oliver


