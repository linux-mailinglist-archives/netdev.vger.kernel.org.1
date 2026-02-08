Return-Path: <netdev+bounces-257843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAC9EeK2iGkrvAQAu9opvQ
	(envelope-from <netdev+bounces-257843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:16:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC1F109629
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC7373004DFF
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECB434CFC2;
	Sun,  8 Feb 2026 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U0qDeobl"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEBC348477;
	Sun,  8 Feb 2026 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770567021; cv=fail; b=Mz3BUZvm0EIoxlUgc0cj6xF20XiLe4pKOgx32XZs6U5l/6PStv+G83TpdlRi49JCWxPXG8M1UEwZi0eBeMWer/e1w6dIOn2yeYvBcsrIMK2W1nBc6IVN6A1CnOFu8jJjyvFZRVAZye6tAA/4pxJUgWlkFY8FSiwKYdphM+nPwd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770567021; c=relaxed/simple;
	bh=RjZNivrjHWAMDBoilmgwPCEKEuNOgIfU7m3dXxogxrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gNsJYDfJFlXYi3cdDqoX6XObuXEypPiF0dlaNR57jWWdaTRRv9dQc3RmR4V13+dFysnkuWJglY7niohcOA/3WJ+rCk2PQHJ44GKQzjUipoMinLsR5yPMCdh9JP+o32SXc1V0N/uUgfqw38ivZP7y+vDRmnnJVYPxDPb7V0osKxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U0qDeobl reason="signature verification failed"; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=murM5R+n8xGSFDIJiyD7WsPKWXXog4ez7rtIbgmDzcWMHXRs3pFaatMXLh+G0aDoVHVA135siTWSqHa7NeqbRrxL2daQDTPAOwXa6xFQci65anSsuiKs3UawCiCbnlScFfHVfY43YjEY7lHYco1TZVFSplxul5zR5OLojmBMn81x5edJ8SJwU6qvb9K1JCTmBYfMsHlQyXwpp7bs3MW2YbK8xkDS5N+S9xBxWveNHECZaE/9UvhBL2dDZ6+EiaA+to2lokrc/p4ro1Ug6Hja6pws1ZT9vhXHNHsjabbQ8WMapDEWoyJAn6v8tHjisKBiP85LhAwKt4rRi4qtSY9jGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1Zer0vvHBYEwjlry9gmsrcx+W5cYGQyWAZE4Fm7RG0=;
 b=lDpb7fECmchigyhduSN3kZcbIuXw2Z6HCBfV/fjJhDSAHrMOdugjQwIs1BihZjfoL8ZL8q1Cl6WTpDSi6v1hCjhxO6XaoBRQSDS1FSs5crQIw1ZW2HVy+7YAz6ZTQvDKjdWRaoMnDK9wYCRLfd5qES6xceSWQVIy5iM+bFf0WhvGfsfGytZOW1e4ksekXlBg4VuWEipfKzyGqLFzgrMt9CW282b202FcNdtTKnRtjp5TOi1TOBlTKam4dEeVFHuF3QMQ0Pl6sgyO9JekH0pVRBv0g/zMZpL/eSq9P/otS2dyZcajrucyi0kt+O3AJ9thIdOFNKlAB4Cvm1Gm6U/1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1Zer0vvHBYEwjlry9gmsrcx+W5cYGQyWAZE4Fm7RG0=;
 b=U0qDeoblInujQaH3HBvKUgn6jL1L/PynZ9Teac8REBYeu3gbQaUvIY7/JB9k0kgm6wPJTjBtsau4Cxgr5GpZH3McQy1LOkihXS/WtHNYOjGG9jatlmxytJqvmdJ/5W11Md/N+KJlAAvxUDGjs+rywMuSy4H5gHQR9Z7opXf/DQDaNLl5yxx0DmZaFzr0pfnqhmjz5ZRTHVEUUYhgFxSz0vLTDQwjU4FFgzGS8xVFg2TJemvAucXXMaboxjeoN+QQK59022JdnlqEcsccIFvb2sOGue8On9Qi37JjJRHIYr8PRLMF0FNRomsO8L42q7BpGMrEDygNo7+g9h3ZYK5TUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:10:18 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:10:18 +0000
Date: Sun, 8 Feb 2026 18:10:10 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v2 09/14] net: bridge: mcast: track active
 state, VLAN snooping
Message-ID: <20260208161010.GI154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-10-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-10-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR4P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 35296d95-24ae-439e-2a7a-08de672c8d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ULnBXNxRx0B9BnRm2bgNobRA/hk12OapolpBnUIRYlH6IcE6iZeYGuRuZz?=
 =?iso-8859-1?Q?hNJ8LvipRXdALL+Ee51VdR2+VP3QHkWo7BfjYEEj2V6kV/thqcLVHUVqnn?=
 =?iso-8859-1?Q?v8y8Nfde4B0tExQPgZDoSIhDlwwE6FftBjx+IAnDzcKf0PO1AFbssxD8X2?=
 =?iso-8859-1?Q?9JRxuTiM9hHAZV/kBH8t+47hnMK5u834UfEwUs5cbr6rcMWp3wr5yaDzyS?=
 =?iso-8859-1?Q?TM8HJlK8QX0i+lnOajnWe2BgTWAqc7AXaqDUi9mWoBvaRCcj/5Ko6CsQvw?=
 =?iso-8859-1?Q?iQ4TyoRnt3FYGUmPUrJOFfQzgVifNlU8SwXdBHfPnuUurx8YqdTw3DfcPA?=
 =?iso-8859-1?Q?FVJZpQlS4PiSngDn4KYB08CVhU32q8n2XZzpKqQ4/8VOuYg5wZTjVYvMwL?=
 =?iso-8859-1?Q?ZsTxtuVSxh785WmpVB8SavBjgE5EqkHSlZPeisVHj/l6yTcHrOxJfjRS93?=
 =?iso-8859-1?Q?TAue5NkeMQWhR9MhLFEtNCh0VI8ALQeABNfDpU+NvvkekaVpkgCAjTaYT7?=
 =?iso-8859-1?Q?GHq0FMNOlK3T4v75v6kOcP1QI42RaLXB8dveNMFcNf9CQVRuurLWTF/FtW?=
 =?iso-8859-1?Q?xOyVcHRGaj0kUIa6faJzJw3H7cNjsd/GdtN/0CQanfTWbqxdVLrIlxx7gh?=
 =?iso-8859-1?Q?A40agqTw3fpKoRZUP+l5lvCpsnF2YjDv1tGyQC0mg4yusxiyHCsOy33L0O?=
 =?iso-8859-1?Q?KI9sNcqxLF6ABDF/BJeugTUcsT4xFdp7CpE95KAxW6fpxxvc1usg+87Ots?=
 =?iso-8859-1?Q?c0IJLit6StDSsN+pVukrfU+St4Zne0aeElDY3KU8hfN5aX09ik5on7tN7x?=
 =?iso-8859-1?Q?ooOiwWYqh3idhsVjeky2jwtzeM7tdilR9mLDYqJcxr95FD5xpAD/HYkCHo?=
 =?iso-8859-1?Q?0aPxzqIRHo+GEGZtcCOEHVLJHJPnxb+s8SYA6xQjInk4mpM+78SRhuwHy/?=
 =?iso-8859-1?Q?OiucmcEDdqGE5u6NubmSC2VBq9YnLHvb3tTM9u+BDKTn98dVuDIf9IpCyX?=
 =?iso-8859-1?Q?t8AMbaHwO9SZsjD823+UJkA3Zm2jcbOTAJUxtePkYFZcwYkBNXAjJIBjXU?=
 =?iso-8859-1?Q?6I2RemL3+Db+YxJrI5SERwXLJzSwa9Vrni6BMxrwC/xTPEfiZ18E7rBBfA?=
 =?iso-8859-1?Q?1qxCnU7TuRSkTnYpD6Yrsxy+zOD17f3eiR7L2prsQzVYKgfBnrmmBrkgcw?=
 =?iso-8859-1?Q?vUzWQCjYdq2UzMPsOcUSS8Ve/9stIip0HUHnbRohy6XeONE6CaJd3W7dUM?=
 =?iso-8859-1?Q?wJvMIEywNhza/MNQ+X3GQVTMW9AteubgXo36caKwJXnZGiQCovipDWGO7e?=
 =?iso-8859-1?Q?Gm3sm0SxPhjmTZwKcNevPXJfeQGE0yP0rKLey3q47rb81ta3dMOBPJqxKQ?=
 =?iso-8859-1?Q?keF2rHWTURY83Rdbb0WsJzYlQWonq6/HZnRZH57pg5XfeHeb5FcfECrRfp?=
 =?iso-8859-1?Q?uk5jomsqn4fcJQl4QuZ255K2qBpJCalwf+fNSDAeJrZ3x2qGdTuzxvuvtj?=
 =?iso-8859-1?Q?aymWQy4P8nkeERl3CWO76nWk4eOmGlYrTycKRxsAFV1vm4PrnGrjfD4Atf?=
 =?iso-8859-1?Q?rdlNZWErwby9C+WzmCtB0/h6rrN0g+3BB7/A3Ss8soQDPqyiYGX7S0WMd5?=
 =?iso-8859-1?Q?06vZEX0putK6I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?DCkTlxto84BAXIukEA8rsoii5Tkdslv9NxZdTqb+jxrE1XE6uIgA65qNc5?=
 =?iso-8859-1?Q?7WQan6qB2q82ipb4ChordUXWBGFpazbgVRXUyoTDEaytOsCrsw8OtMPP2k?=
 =?iso-8859-1?Q?pdv3/vCxwuyTlMRGYjs6tYEh1OnkKQwH4nkyVvh4jT5GktWuF0SG6dnIeL?=
 =?iso-8859-1?Q?GSVBa5OA04K/oZiFfIQg+wUjz+jGRdVxhTuxpGtRfzf4PyJ3PWluG1Ns0m?=
 =?iso-8859-1?Q?BW4BdprdJm46XmJS/BN768WUCOQ/iM+yWZHByXAXT4rQOE1Bxk5mTLharp?=
 =?iso-8859-1?Q?OI5NfduIUFpdfYYhW7N5YMR4RD+HXENoUrIJhP48SKAt+yUw4zJ4HvosCJ?=
 =?iso-8859-1?Q?8e1SanN28I2SmY6W/plcwvJpdH9xWNb/pR2klMavf/srIv0uwSEwj30m+X?=
 =?iso-8859-1?Q?UJHCRpDZQqej7WYz+G7Zv/2bdBQvpoigW81XK73TDPmx01Tz/sZZeXLr9l?=
 =?iso-8859-1?Q?0nTz49zo05T0xwgrqFqzeHtMUzdP0W6K7U5eYx669CnEFHU8WUUxkvR6Ug?=
 =?iso-8859-1?Q?yEFbUYJj/k/puGTSGnWrc36tUF3tGKPVurMGuQnPTZ1aiU2Zx+2yzI810Q?=
 =?iso-8859-1?Q?YaTdoyaibdpt1kJiv8f2tILoUFzaDr55i/zoyHg1vxwpB/RANG1y3W9P1A?=
 =?iso-8859-1?Q?S7w5PhJgptD8FECHBP+UbcA0IXiVey9rKzeXi6auclrrpT7wNxcef+DDmm?=
 =?iso-8859-1?Q?8UQgKAmmScNaTvki7F38yM/5s1P249L1h4G7S5fOaxJZkGfy45lu89iF8N?=
 =?iso-8859-1?Q?laBTtpSC0MuSiAkVEXJc7oCaSWHTLAq/FC/bCA/2A1wkeD6c6HYAsN29I7?=
 =?iso-8859-1?Q?WVVN3rHL1rrv0djQYSg/Yxbx0eJnyTTfDnpPAanHlct14D6AadbVzTakEe?=
 =?iso-8859-1?Q?xn4quYdGMVm7uB9Xi9neNEtBmG4Vt3dw1Bcw28tXstMAP0YbNL+xfQZV8R?=
 =?iso-8859-1?Q?qZoGqLnhhXCFhFjaQ+2vBxMunX71r/jnG0db9Q/qSVt/Rr/zls749PuUoC?=
 =?iso-8859-1?Q?KFB7mMF1xUYlX3A4skoGIw5OY7bWb9Pdt6iVvgInwuZ7bNzGQa9Hx4Dvkd?=
 =?iso-8859-1?Q?YovLInP6E+OZP1ynJwz4FMsk6+ydtuZqMyCK4gkiHQdKWTilsvNboPnxqR?=
 =?iso-8859-1?Q?LOvgC47FU8SaT2E3rwkJlUCKvwVf+lN2J4OAY1vcY6bdjMZA3NXsLddvci?=
 =?iso-8859-1?Q?Lt0cxK9vadk9wTy2XoTHbT2qUm1Yr7V5P9zgTCgaqtMN1m4vm8KOBQjFq1?=
 =?iso-8859-1?Q?jm+Qkim8/kBaew/u/igtl7KafJOFJuhAoHN55zdcOTH+GUDAP9DcFdlShz?=
 =?iso-8859-1?Q?bzFayuee/XWozZrBTEV4uH+zMvvsMX9mgRII6iqCyyHsXbqUgutw4naxlt?=
 =?iso-8859-1?Q?0XOl9RKXILBU9sMHcV+ap91yXkIfEhHbEYQws6aTXUABSCUt9YBJiabOGi?=
 =?iso-8859-1?Q?afGYKt/cyrGxlucV5pHI5f5jy87m5Xo+4y5dGxN7Wh10c4tKJDjYQvXxLO?=
 =?iso-8859-1?Q?ujmn4VWOPmfrcOQRX3vUQnho8L/Glxoa20b6ImjXK+WSHz2EgoEkwi+10Y?=
 =?iso-8859-1?Q?nBOLTXvXf9TRvlaWaAXCetUyAu83HU85XYWgAVQPU92Qh7bB0IMrvwMIqz?=
 =?iso-8859-1?Q?+K500jhPQBa3anclf0RcZKoqOGjDt7FCPO2izrkNCeUhyZF7Js7RcloWiF?=
 =?iso-8859-1?Q?CF6HGiH2AkAa39rN10hn1+xRwRjgu++88e34rd3MVbSVZkEAZAMJsPbu11?=
 =?iso-8859-1?Q?osIuf33lVRFKYCZ+HfB4+7N/tA0QW7BOlXiAQXd/I+eeh1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35296d95-24ae-439e-2a7a-08de672c8d76
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:10:18.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TivMNTLuvCnwIxh75NpQa7rEmxXNwq16GLIR7LFlgTHvEpcfzyR4dI2Dr5WJUxdofHlx2lx/+JOXUzXNHLW7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257843-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.972];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DDC1F109629
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:52:15AM +0100, Linus Lüssing wrote:
> If VLAN aware multicast snooping is enabled then we need to perform a
> few extra checks to figure out if multicast snooping is actually enabled
> for a specific VLAN, as there is then an additional per VLAN multicast
> snooping toggle.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 4bdc3838c3dc..2a2f54009e0f 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1143,6 +1143,26 @@ static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
>  	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED))
>  		force_inactive = true;

Once you set 'force_inactive' the other checks become redundant, maybe
just jump to br_ip{4,6}_multicast_update_active()?

>  
> +	if (br_opt_get(brmctx->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
> +		/* with per-vlan snooping enabled there is an extra per-vlan
> +		 * toggle to enable/disable snooping which we must check
> +		 */
> +		if (br_multicast_ctx_vlan_global_disabled(brmctx))
> +			force_inactive = true;
> +
> +		/* with per-vlan snooping enabled the non-vlan multicast
> +		 * snooping context is inactive
> +		 */
> +		if (!br_multicast_ctx_is_vlan(brmctx))
> +			force_inactive = true;
> +	} else {
> +		/* with per-vlan snooping disabled a vlan multicast
> +		 * snooping context is inactive
> +		 */
> +		if (br_multicast_ctx_is_vlan(brmctx))
> +			force_inactive = true;
> +	}
> +
>  	br_ip4_multicast_update_active(brmctx, force_inactive);
>  	br_ip6_multicast_update_active(brmctx, force_inactive);
>  
> -- 
> 2.51.0
> 

