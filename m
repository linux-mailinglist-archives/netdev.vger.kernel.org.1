Return-Path: <netdev+bounces-130868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3579598BCAD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E993B284E00
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE241C2458;
	Tue,  1 Oct 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="IiVQoqac"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6841A0AFB;
	Tue,  1 Oct 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787037; cv=fail; b=ZMQSP9DyGoenlo18zWCc1quTeKTilB8QdsLoPhiuzMJq63hUzbLDSH3+4MrrXZ+Iu2NwQ4dg2zLckQUuD4PqL0sBUl39/6qBs9HSAf72P/D3nd9u6X91lgMAlGJXHdsYsOYk/oi32bVLR9jDQNGeN/bpouQd+jwf2InFXL9Vwks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787037; c=relaxed/simple;
	bh=lUiyt0NsYjGzXJ5Y7gje46TLGFUOseAVIznzMj3WEws=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fEQjby9cyu6UuwK6Din7HyLYrE+o2FsBa7EJQ4hgmjeXOnpNMuZPiH8TXDCrxNrnKadijB/uU4or3CbwXpHOq1EYa9drj5d0yGPn/U8NmWxA6rfhi80KyQASd8h37eqND9NaM9AuVcaM8lHv5hG/hQxLm1FvmkuIEmV+50/1r28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=IiVQoqac; arc=fail smtp.client-ip=40.107.247.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSEawGN4bhjz73l05R+Zi69XqAiENQiT9E6+xW9IVnOEac+/aePTQMSEtLdM0gzHiyIRRbMauFgJmhuoWUzECBse1LnMnGrN6o1tORo21vHLw6e2cJtQy9gp+cicrhuCw7J7Ym7w77bqqXVy9NxKfnqmUETYr45I2YjRUuNe8viyTzB2MK0qTgcHDJuFyDSrECnSNshcp6m59VHJqMCkq5CuIRjtXq797TsbqtFrQyi/FlyqULQu1sUFyv2loyFpEAcQHUR+IF6qy+0oGpbwFKXt2JqHfGl5YhJ/qtQ3a2hFcVAq4ChSBJxPlJBzkl9lSUjkVDI5uvlRJ2Xc+010sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubFrv2bLCxNIFqhe0X6ESZ17lP6+1Koq6gCMa3KP+lI=;
 b=vVEkuFvJh0Dt3348TyP+AP4pH0yJdp8bFt9FvnhMkw01FLcvEzqBWT593d7YblPQj65zwBFHNnhSpdf4KSbSXuYvaBUaCEJM728DXwsjNrhxxrdaqbwAzcw8Ad8Z58nGow8fF2l/sg97D2KpEVyScz7UcVYkl0RIZTeSlkQgvnKoWhGYp2azd6QNrbQyt9/mCHLra23brvZBzi/jSOn46Rq3AnPIGlyU5b2cSaTqHS+TFAMqqZmw4ufIWwkwSwUvaa4qHXrxhibnxEJTXsDQYFpRLqZ2q2Ft9XT2FcQHH58h6JIMvu4JlKQ0dpkEVDi+8Auf2g9zdHdERSpoN7xRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubFrv2bLCxNIFqhe0X6ESZ17lP6+1Koq6gCMa3KP+lI=;
 b=IiVQoqacLe0GIrFscwIZFk/3VXbR55W+B5IFXC/emnUeikMTMsYc5MnuLb7BaOQWMG3Q9pv21ucl89vPvU0JM1KxpTiY9kcxklDnUxgC1OOY7PZItk/OSsbSdbemGPpCxHg5AE0u46C/XaTtpXPNPmO1WM8iagLuVFtf4MlONf2UsiodKoC2ElRdJr14U3k1ktwPjIgj/RRaD11Ps/cB49iQg2BiuUiKJybNNCa+ySvqkfN4k0fXvW3VuVUlXspt1WnpjB/pN5IgpfaHsw9rc2siawgyQ1T/iFvjqg0DSh4fcdYgBGyM6pcl9nm1uT2gOb5gmyrPfBog4Vl8ocp34Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by VI1PR07MB6253.eurprd07.prod.outlook.com (2603:10a6:800:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 12:50:32 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 12:50:32 +0000
Message-ID: <4e84c550-3328-498d-ad82-8e61b49dc30c@nokia.com>
Date: Tue, 1 Oct 2024 14:50:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ip6mr: Fix lockdep and sparse RCU warnings
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Petr Malat <oss@malat.biz>
References: <20241001100119.230711-2-stefan.wiehler@nokia.com>
 <CANn89iJiPHNxpyKyZTsjajnrVjSjhyc518f_e_T4AufOM-SMNw@mail.gmail.com>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <CANn89iJiPHNxpyKyZTsjajnrVjSjhyc518f_e_T4AufOM-SMNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|VI1PR07MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dad24b8-f3ac-4427-56ab-08dce217a2b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2JBbnJhVnVZUG00WndhdnMyOFBvdFgxSWFoMmlkTkJEN0xVTGZ6UFdBcTlu?=
 =?utf-8?B?MmlRck51cGlzUnBuK1ZJRTkybHhkWE9lUDlPU2JESElhQWp0citvajY4YXMy?=
 =?utf-8?B?aGlNdEJlcUh0cGk4UGQ2eG9YOFNSTm9ITHBBQ3ZZQjBkaWFGMlk5akZkMXRZ?=
 =?utf-8?B?dVVNOWlsUlBnRktoTU5FdGFrYzRYQnNWdlpscm1nTWFWeHFEbktOOHhlc2xa?=
 =?utf-8?B?eCtVZzdJRFNtYlhKeHoxN0U2UVlzTHQzNG4yNi8vUnNFZGIrWW1IMjN5R2V1?=
 =?utf-8?B?b2F0dHlzZDVhTTVWaUs4NFpqSXJEZjRnTzZEL0ErYnJkalpZL0FtQ1JycGl1?=
 =?utf-8?B?aEN1b1Z1RU01SUVqaGl4U3ozTlNxUlhDcE42SldjcUNqZTRmRU1rV3ZGN0pZ?=
 =?utf-8?B?TjVBMFJPS2FPZnQrMlNDQXZnTFovcXpwSE9aZlZ0cWM0d2hiUU5lMHJBRjVK?=
 =?utf-8?B?Q3ovSmNTdXFFUzZnVUlNQmk2V0toUUZUc2JKUm5LM3o4TXczZFJWZUZWUElo?=
 =?utf-8?B?ek5sQ1FIM050VXJRRVpWd0V5aVpWeDFFMVl0TXU4YkM3YlQ1RFBTWWgwbFJm?=
 =?utf-8?B?WUhTbE9HVitiRFV3Q0ZVTEd5djVaZVp5cE9JWjF5My9UYm9JZzdWTnJrVXRu?=
 =?utf-8?B?a2hpc2pJeHFPYVZnQmxQREJJaGJXUWtxOUtzeWhweVRCVitsNjlGQnlRa3pa?=
 =?utf-8?B?SC9RbXgwYnJYN1VtcDljOXlaSGw4Q25JOTczYkdGN285MVJiSmU2U0UwdlhQ?=
 =?utf-8?B?QWRHT2tBd3BwM1d3Z1JJdjY3OGxnb1hXK2g4anFCSVlvR0tPR0ZYSDUyREtJ?=
 =?utf-8?B?RXN1ZjZBRkF2OVVPWk80Y2NLRWwvc0FaN1BiWkJBdXE3cVh5R1NORkV3QUor?=
 =?utf-8?B?VDZXSnlCNmlSTjRSNzI0cGpyNjM0c1p6WGNMMkcrazh3RkwvUEk0aVJVbnl1?=
 =?utf-8?B?QVkwM3owMVd1Z0ZTcmZ0L2hFdUsvSUY3U0lNQlhUQzRtQWV4cU9STTJyMHc5?=
 =?utf-8?B?dFpVYjIvcGE2bXRLMVVGOElaNnVGQTlhOUs3K3NEZ2QraUVEZExxWHdvdlgv?=
 =?utf-8?B?Zmx3VDZvSk9XSTRkUGxmV2dVT0ZCTFlod0I0VWFWVTVoRzVCVHJ2WEQ5R3li?=
 =?utf-8?B?N3BKOWV1NjZPcnFyV0ZsL2U2NDFzR01OdDBiRzZ6YVBaMlp1WXA1bVhGZ3RN?=
 =?utf-8?B?bjZaNU9xVFd1RnUvZVFuU0F3ek1tL0RmREJnR1d3bHYxY2lKenZCdHZIOGxJ?=
 =?utf-8?B?MitQTnlheFdYT3JTSFRtUnZwdVdONzE5UFQ5OWYyYUZza3V0N08zK1pFelhs?=
 =?utf-8?B?cXA3Y2hBaVdaZHBINENsWk92UUJjQkxPZVBEYzJGZGtsS2NaMXB6Mm5nenZW?=
 =?utf-8?B?U2UvYlFkdktjYkRkU2gvU2dCaVB3eFJjZjYvZWEybFM1eGdGK0dRZWlNL0gr?=
 =?utf-8?B?S2lBVG5vWEZIMGMrZTcxblAycGNXbWxmTHg1NVM4b1BFVVFPV3lLL2p1U2ZB?=
 =?utf-8?B?a2w5Zk1ROFVJU2JkNjFKQkJJTGhlWStMdVl6YStqREZ1WVdsdFFacmVBb0VF?=
 =?utf-8?B?UE1PU1Z4K0pFWmxnRVlUa1lWaVFzZllWNDhSeXJNNXNpU1Yzd0M2djh5Mnhj?=
 =?utf-8?B?Ymg4VTdCdGxMc0VLbGc0elJxLzBzTHpuNDVoR3pxVmtDVmZ5MFhOL1prbGh6?=
 =?utf-8?B?K1JGR3N3MXB6WVJPTnU1SXdhSGV0OUhMQTF6N1psR2ZBYTdabnpKeGtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHdFK3dvWDhzckp4YXlBVDRrSnl3cW45Ynh0UXpNMEtiOFh4S3B0RURDVjlp?=
 =?utf-8?B?bFhYcVJQWEJlZGNQdEQ3dGk1ZWpyYlF6ZzNkdlJGeGhwTGVnMlpjQzdKZWpl?=
 =?utf-8?B?WEppTFdLWnB3WGxvZjlTcmpjdS9hR2tQSFpSMU5KNUlhUWxjWk45QlVGeTY1?=
 =?utf-8?B?TVMrbmRUWG9CREFOc1k5TlgxM3VRQVBnaCtLTWZlRzRoN1VHSGJob2Zncm5q?=
 =?utf-8?B?bzFCUWQyUGxLQ2U2UUJLYlBYbVpsVGVDUkFuK3RBZlBzbUVNR0l5elJrZHB2?=
 =?utf-8?B?OS81bmNVcE03TUZMcTc3alNhVDVsU2I5TnFxbTJ5RGdsak5wdWl4UVJsVmlG?=
 =?utf-8?B?b1VoV29WRGIvbkVxWEpDeVB2Tk1kMEpFYjdpYlh4UHF6YkVibEFhTExDOU14?=
 =?utf-8?B?cGt6YnNzZzJKUytFbXAxL3pTbWEwMXBpWHJXOUFBQmtOYzZYUE1zUXdORS81?=
 =?utf-8?B?N1VtUkdZVEs1UlBXYWpkYkM3SHBEeVQzQlczcXVNcUNwVnBHcXZ5YlJVbUh0?=
 =?utf-8?B?WHltRlZVMi9ad0U1WFloc3l6ZzVBZGZYUzJkQmpQZU9mQjVBaHdZeGlGcmlr?=
 =?utf-8?B?Nml5ZTUzejV2S0lkTElud3NXUzROM1hYMzFoN25hTHZXaEUyd3NyWlpjNW9q?=
 =?utf-8?B?ak1QY1hreFJaQ21MQnZhejF1dWFuamV6Q3h0aG9lWHVsblFaTWsySVBIUVdJ?=
 =?utf-8?B?VFhvT1N2VkpKTXczQnh6aWJXcGM4OVc5SW0vSzNuTXJLbittUGdabFR1MktU?=
 =?utf-8?B?QkpVUk1INE04Um94NTR1MXZDMzVFSklkYWl4VU85SWRBTzNUQnV6aDNCeFRa?=
 =?utf-8?B?TUx2V291UDBVVlRpQUJ4QVpZUnMvMWhmQ3VNSFdJbUdsSEdhQ3h4WnVXRUFr?=
 =?utf-8?B?YVkwaEVZTjJBNS9Cc3Q1L21MTEJ6Nlk1WWJWVngwRm5qVWJXZmp3SmlZbDZv?=
 =?utf-8?B?eDc2cGg3TzZzNHUvZ3ZYcjNUYzdaeFVYN2xJR3pEbnUxSyt4K1RkMjFLbEFy?=
 =?utf-8?B?TTUwL093aHlBSkkxNkVONGJEalBoWm0rUE5YdFI0UDB4T0FmQzBtek9mMTd2?=
 =?utf-8?B?Qm1zSjNkRmRhejNUbTNTbzdjTUFHSmVGYWdadXRvUXdtdlZTTEdKdlArNUsx?=
 =?utf-8?B?Z2w4ZU50YUtCcjQxdzZIbXNjSmtaYnhvSGVlRXQvdkdvSEs4dk5SYkJDSjZy?=
 =?utf-8?B?a21LcVdGeGJ1aVVnYWFseHVJVmlvdTVIejlCQWsyVmVUQklLZ1h5RVdqM0s4?=
 =?utf-8?B?dUZFaUxIcS9FYlpLV0c4ZWVhSHorSjgxVlVENmp4dzREd25WdGxwckllRnZk?=
 =?utf-8?B?aGlQRG91bnUrcU1xZ29sWUxVYi9Ya1Q4dThqN3NJSnJ5V2x3RGIvWmdnclU1?=
 =?utf-8?B?Z05pZUJWclA2V0w0ZUVFUW9IeGlPV25MN094K3gvV3ppanhmNlBJL1VtQ1F6?=
 =?utf-8?B?cWhDdERpeW5TSkVUSnd1aTJHUzJ0TEl3RFp4a3pRQm56dmZZUHRvcitLNGR6?=
 =?utf-8?B?TnZYUVBFWkZvYTh2K0k1dVZMY1lmQ1d0bFQwb2tHbUFtNS9MZTdPYlg3azNy?=
 =?utf-8?B?TFMya0ttNjlKbFNuODFna3M1L2RZZGZDM1NuQlVOb1lZeERmY2xJMXBXdlZB?=
 =?utf-8?B?SXVMOTB5bW5QemhBcU40c3h0Yit5dzhBd1c4K0paemYybXdFNlhCeVp6eGN5?=
 =?utf-8?B?aXhwcWdRRDQrNFlmZ2xiejJQbmR1cEd1eERKNlN6WW0rc29lMUREbEYrZ2gz?=
 =?utf-8?B?S0llSDhWVUU1RURHaFFoY2l4RExvZ3FzMHNZejU4Tlo5ZWFoQmlrMEFYbFZC?=
 =?utf-8?B?NjNGT1Y1RFpqeHczNklhTHd5eDhyRHF6UkI1eVJidmYyQXRybmF0MHlES216?=
 =?utf-8?B?TU85c2tEQzJEcUhCcUxBLzhWNnhHUVc1N3NJV0h1MkhMRVc1c0IvbzZmRXl2?=
 =?utf-8?B?WjRvOVNkY2lIZGRhaExJSUhBd1ROUnZuUnpxbFdWdXVpN2h1bGdRWUl4bmpS?=
 =?utf-8?B?NXNaQU4xeWE1VWZpUzUrVzVzdUVsci9xTjk5d3JaN1B6akJ0N1V5cmVHM051?=
 =?utf-8?B?OE04b0wxTmo5T0dOQkkyVEJLdG5RcEE3Q1lnUzdXaDZMVHh4aHdkLzUzQ0U4?=
 =?utf-8?B?c203NEpKbS9DRnlMR2pHZGIrU3RHTDVJdGRkRG5hTFdjMUcxWnBaUjg3NXl6?=
 =?utf-8?B?T0FoZzlZOCsxSzdTUGkxbTd4Qlh0TEJMZVpGQlQ5SEJpajRCNzFWYWk0V3VF?=
 =?utf-8?B?eVNOcnM5UWxQdHFSdVZwRzR5OGpBPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dad24b8-f3ac-4427-56ab-08dce217a2b1
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:50:32.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMbBHUxNU0wFUonyu6DzPxS7Ielz4BW7guOvChK49mbLXj58BVnS7ngCY4kJ2E0dD0RPrWxZzqOMtdZJfRg4YM5390q7wj1zuQupq+dsmZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6253

> OK, but RT6_TABLE_DFLT always exists, ip6mr_get_table(net, RT6_TABLE_DFLT)
> can never fail.
> 
> This is ensured at netns creation, from ip6mr_rules_init()

OK, but nevertheless we need to enter a RCU read-side critical section before
ip6mr_get_table() is called.

> This complex patch adds some code churn, with no clear bug fix ?

We should have probably mentioned the Lockdep-RCU splat that brought this topic
up:

[   48.834645] WARNING: suspicious RCU usage
[   48.834647] 6.1.103-584209f6d5-nokia_sm_x86 #1 Tainted: G S         O
[   48.834649] -----------------------------
[   48.834651] /net/ipv6/ip6mr.c:132 RCU-list traversed in non-reader section!!
[   48.834654]
               other info that might help us debug this:

[   48.834656]
               rcu_scheduler_active = 2, debug_locks = 1
[   48.834658] no locks held by radvd/5777.
[   48.834660]
               stack backtrace:
[   48.834663] CPU: 0 PID: 5777 Comm: radvd Tainted: G S         O       6.1.103-584209f6d5-nokia_sm_x86 #1
[   48.834666] Hardware name: Nokia Asil/Default string, BIOS 0ACNA113 06/07/2024
[   48.834673] Call Trace:
[   48.834674]  <TASK>
[   48.834677]  dump_stack_lvl+0xb7/0xe9
[   48.834687]  lockdep_rcu_suspicious.cold+0x2d/0x64
[   48.834697]  ip6mr_get_table+0x9f/0xb0
[   48.834704]  ip6mr_ioctl+0x50/0x360
[   48.834713]  ? sk_ioctl+0x5f/0x1c0
[   48.834719]  sk_ioctl+0x5f/0x1c0
[   48.834723]  ? find_held_lock+0x2b/0x80
[   48.834731]  sock_do_ioctl+0x7b/0x140
[   48.834737]  ? proc_nr_files+0x30/0x30
[   48.834744]  sock_ioctl+0x1f5/0x360
[   48.834754]  __x64_sys_ioctl+0x8d/0xd0
[   48.834760]  do_syscall_64+0x3c/0x90
[   48.834765]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   48.834769] RIP: 0033:0x7fda5f56e2ac
[   48.834773] Code: 1e fa 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 1 0 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <3d> 00 f0 ff ff 89 c2 77 0b 89 d0 c3 0f 1f 84 00 00 00 00 00 48 8b
[   48.834776] RSP: 002b:00007fff52d4bda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   48.834782] RAX: ffffffffffffffda RBX: 000000000171cd80 RCX: 00007fda5f56e2ac
[   48.834784] RDX: 00007fff52d4bdb0 RSI: 0000000000008913 RDI: 0000000000000003
[   48.834787] RBP: 000000000171cd30 R08: 0000000000000007 R09: 000000000000003c
[   48.834789] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000003
[   48.834791] R13: 0000000000000000 R14: 0000000000000004 R15: 000000000040d43c
[   48.834802]  </TASK>

Kind regards,

Stefan

