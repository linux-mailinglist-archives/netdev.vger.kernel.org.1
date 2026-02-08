Return-Path: <netdev+bounces-257841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNFZDDG1iGm9uwQAu9opvQ
	(envelope-from <netdev+bounces-257841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:09:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9ED1095A4
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 17:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F8673009986
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8179534B1A1;
	Sun,  8 Feb 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iq6EKfHM"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FDB346E7A;
	Sun,  8 Feb 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770566958; cv=fail; b=W9S82X0BuWJ5pWqSl2BReThW6e8prPuSSkiI5/kHTExpuIvus4/Y4Szsi37PTl2yL0CtAEVyBFpChCoCriXuxA6KbXaVoXOYRdrJTKMv8E3uDeSzgElSKu7/GhHEYuYjrGZDOitnsMjg6Hk4I1Afb+WxRlcJx9JOAAqJmqgBLpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770566958; c=relaxed/simple;
	bh=B/UnZch351YUP39bYdAoHdXj/pjDlXowz2uyNcqVdHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NQF0cc78pK8w4llbld5HEXRia2/9kqW4Yqsnmw7hRumtFOudKgTA+i1a1DzLEIhdFgV372xDY7p75ZfH7zbD+P+9MPso77lftRIzeDMQVq751qSlfrGx0QpeKy60/8cgoPeL7ZZP9b8eZgI4ZAi2+nJHzfTyeW0pdtGMzT4gaJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iq6EKfHM reason="signature verification failed"; arc=fail smtp.client-ip=52.101.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuICL4PWB4NLGv7gyff9uvdxv4uuXb0ySMpQ90j/HTBuc+8lPGFNtip26QbkFn1Kn1oiKM+bOH5m3hNcft4My7xWQ5is7qrJg5njwiP/kAJxz5PVL1fP3NA6Q0SfKo4VgIaev7uinGVLEogm1nohUuWmox5c4rlWDZfm2bWFe0wxIr4Q+H97SvJBTgGIR8MwmnIZdD3Gdz5x4sG2prFcocT6kLZKcM7V3ITDhAXQF0EYOLYaXpcNTCwj2YOR/H7RahE9VCROkxNd5aizOn/IZregcG3iH/vDvJp4knafgvmZxxXEckFSXCogMhpBKVn49TjsHP+uIR/Ak/Dyu4tffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmMT4Wx6YUfomKArTs/tR0GQjTnQJr45daarOQGMy2g=;
 b=kSQ+qpA8tRkON3apLRmf2W7dNSmBByMAOp/+j2IxcZxv/ntLU2jh1+X2064nGoAvwXj5zifkp3PAFv5W3uNjD43UQmKfShKUIFRUTeY17aPD+cdwoGs6qVL2U2kElmrGr4rZz7PfqMF++R9MNAqlEKaftD91r7s+yHn7VR+DV9CbVart84tSPTkj65Xhs6dE/rXiyjBR3xPldwAQ1LScd4jAclI+kLWfyv+a7RhBfQ3QDrjgkEfs/Jsg+tlYahQAVj6lMkJYXkglnZWjK6t0KNZrBf+tqdAOqFflq2YyUu0ondysUZYnbtOtGl8L8Q6xj3ObUCjLY6i+H2+0f+lXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmMT4Wx6YUfomKArTs/tR0GQjTnQJr45daarOQGMy2g=;
 b=Iq6EKfHM2CsygJ/cSqWUws0oG7UlQb5F1FhnfVtCmu7nttuRUGeocwHcwIgdpNM7ZQZf62GX5axyaQ9Tf6ki/w0Bqqdpz4XSCio+Pbvb8TBoA79Kh4oEyPAf9BTveHjr43trIe1JpPfe2Mz62uAgGvd0LkTUpXlcTY5x6lLOZDMXPvR1MhCUJc0VyW0tM3Jd3WaGXPBGJ48iml9oGcE2FFOTZjwBypEKiSknpcuzIG3CtN50NVbYpc8wlt8AhPhR4/D8z72cn8pzD87KHLMTXfSWaRRZzc/e5Y6QhKbWj6PPd9WeXDPlbmqpO9qrhW2lmlVnMB4cvqyLLrMzwOw2hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:09:16 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 16:09:16 +0000
Date: Sun, 8 Feb 2026 18:09:07 +0200
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
Subject: Re: [PATCH net-next v2 07/14] net: bridge: mcast: track active
 state, own MLD querier disappearance
Message-ID: <20260208160907.GG154003@shredder>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
 <20260206030123.5430-8-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206030123.5430-8-linus.luessing@c0d3.blue>
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8eba43-4465-4c7a-7df1-08de672c6847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?82ZzWqFv2wWMFByhhZkD7NDSNL4DjZmfpx7//FodxGB2LtMHLBw3ZaMD1z?=
 =?iso-8859-1?Q?UYPoDCWJCDW9cosSuIU/YUN8cMel9/tCTvhx7aFsxyxQcVLfyhjAcQyLHH?=
 =?iso-8859-1?Q?BLArIeDoucUBvSOdB6J0cT0vyw7Xc5+/qHMgDQ2jE0fGNQqCwkho+kmyRI?=
 =?iso-8859-1?Q?aP+Cc9xfvXdNzLNFVsI0mn7+0Z4caSuouHF9paQSq9vDD5EPPbEa1tUMRL?=
 =?iso-8859-1?Q?gdz1/XdC9RsvrNuBRuSzlHFED3B0YpNJi6Sut0QSTisrrV2Tuhl7I2BH2m?=
 =?iso-8859-1?Q?ivgFHviZMWpjB1y4xj4rglhXXzVklL9eyaoYyVsD6KGrR5210EaZwB6aVz?=
 =?iso-8859-1?Q?8Trz6yLYR8Yn2bWCJ+a1bQn7m9CzEeXbKV+hdiC3RL2+VVYNSLkWj4cg4m?=
 =?iso-8859-1?Q?F7jd2WBy43//lpxeli2f9zdCS5g+nEmQHqFqClhP4nuT/m5gjPQBHgRPR5?=
 =?iso-8859-1?Q?uHV9mn1A842phSBVoeIUg7EhqGWBV9uBcV6QXjiDnJ6rwjoiUEtgORHa+c?=
 =?iso-8859-1?Q?2DuxxFypvWv5uZRoP8LQICxEoJEWFcvx2PZbw03YsJ/L2uNAdWLL4wYAzh?=
 =?iso-8859-1?Q?3KyR5Nhk56fRacySUsFcFkh/IBTr0TuvIOZr17XOrUMj+zNh6uqRKPFD9g?=
 =?iso-8859-1?Q?zB0TRanMwOvqdgpmffzy24eYCvL7KUVgq0b2nXmlikTTWuYKbcP4vUnMzx?=
 =?iso-8859-1?Q?ohi1D8/xSjqQwmVvpbXN+kUovoZKMjQcURrYlJ4vfhn512J7ktpVbrlduu?=
 =?iso-8859-1?Q?cCjEM/WvF/zg01BcUfi5V9FFWX6cp2LWhAgOjUM20KtoE1Sdu8flL98OWN?=
 =?iso-8859-1?Q?3ciXF1cc2r3HpiMHCNqdX8Vy0UEq9L1N+DBVYcrK7nHAxFcLsAhjiz2Onj?=
 =?iso-8859-1?Q?QsC6uBiBVWB8O0PLo25gdQz0ioapuJmmaG5Qw8jzIviHMMDJbR6QNbgY2u?=
 =?iso-8859-1?Q?OUQ7+YPAZIC8ZRq1iYnUy2fgblJKTWOGh3btTItNzKhlsk5TyXrjxKvhT6?=
 =?iso-8859-1?Q?fbx1bVXfdch3Xk9x61nBhrkkaLW6BvyuM9d8Vkh0DxUOT2guQz0L3q87Yt?=
 =?iso-8859-1?Q?/DuwSbYFpN+ctBPlJdzRa7iKAkVjmVdYme4Sj+ctqVG+spygJxjXWBG53f?=
 =?iso-8859-1?Q?8nwL0jYHYByXi7awwRxjI86gR5qomxzcdbqY2laaqvfyrCiXdD3Y9o1sKs?=
 =?iso-8859-1?Q?8KOtzZd99kukOEvPcIPWUliRjy+lOEsR4CV3RJZS1dQpvOFqNgu7hGe2ds?=
 =?iso-8859-1?Q?4J7sdntx2W8fV/1q8HNLEm49R48hOm1KkjIY4WnAL7qyHUJfeGsg6kjoV4?=
 =?iso-8859-1?Q?a3mcqzTN8djUiOg7iH92s+bI1W4+yLRy5PP0ondB3m4jwcVZVDMtX1vtKn?=
 =?iso-8859-1?Q?+QkiwMOOg7QqDgKic7RsK6lEL3q+fE2XTJHROJbyk36y4+9ruNKj115Q0B?=
 =?iso-8859-1?Q?NvRoPKf6ixejEcFkZwdN0cfsmS2KbFQa4I/DkfyoN32x8c3VquqKL25FKH?=
 =?iso-8859-1?Q?g5mkYJ3h83Ug5KaJN7TDqAZC7zA48/h5HQkpu30uXi1m5ZRytTH1q4H3+o?=
 =?iso-8859-1?Q?JRxBGq5sTD/gzBI5GHHWoR+gmydu+2jf+cEEz1IFnkYCughhqOHjv8P5/8?=
 =?iso-8859-1?Q?3QIZSI/zVI1Jc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?oqaDCVP8b06seSA4Vco7AzdNh7OoCJ2vzab2VGYlfsRxRwI6wyOuXEfpoY?=
 =?iso-8859-1?Q?4JI9Ya79GoMDNQKKa4XErnIqPjPfCucZR7J5BojO6/4nHuXRTy/klLTeCo?=
 =?iso-8859-1?Q?cHRLj3Mr1W7iFHrOxMVXz3vCqurhaXzrf1kbSsB0VZhSUJuw+WEMcVzwtT?=
 =?iso-8859-1?Q?wF+t0H1CdH0JvgAz9hkc0uiBfw2LEHAFLTSJ5LOvR+u56fLYCkNJU6S+3u?=
 =?iso-8859-1?Q?f+CTPa0G2n5fsF4BPMM4kmGN4wMsnSNF4DLDigi8/q/+i7Uz5QRrSuT6Pj?=
 =?iso-8859-1?Q?IqHP7SJSDNmT3ij2xjgoGNG2EXEHAAqCrUYs6km8ea6ey1zLjnCl3YL6Qe?=
 =?iso-8859-1?Q?GpXpfuNm/ylz7S99xDPpTB/b3LmbmK4X8qPyk0ud8zICz67YoRuFpE12ni?=
 =?iso-8859-1?Q?BwROy7bBGki//DlGBGRaWbysI77zeHQeyPJY0oPCWtwMzfZxx2oFumvh4f?=
 =?iso-8859-1?Q?Okf1poKjluR2bGflQeY4B33qS6+4v6FZQtT+HpsEZqxnRqtwuiNaQ7qSvw?=
 =?iso-8859-1?Q?d1vZNml8nlf1+XV3bGQlkaTXEXMcgJTgbjQvfk7KzLZCm8YUPhl5St07CL?=
 =?iso-8859-1?Q?+wLiCRDCnVNY83mVaJJYcZte2BVdMQ023saop/ACa23N9jpIl/w2OPjoyO?=
 =?iso-8859-1?Q?t2TxImWClCgaFfrEZ4pDhQiHpQFSsT+M/o0RgPf5evgb/A9MndGFj0Ue5W?=
 =?iso-8859-1?Q?nk9C/HasnjmGdwtFjx3nwsVoQNKgooBdlWmSb/8x0iBSQll90ZMYlFeLm8?=
 =?iso-8859-1?Q?4P8v/pijpuD8wVvABmAEifYc0dTJ2/4+PNxtfRA+if+ZahxTU32j5pv9t6?=
 =?iso-8859-1?Q?mcw7G57GaM4z4WDZPCaDPZaOjQdcWdlL3zUuHyOuhADYHY/4fGZTrfqBoc?=
 =?iso-8859-1?Q?5way9Osrt+c2PPYpMblAJujhpyU+Wfod24MFI6wJOYEbjTICdT4craeCcd?=
 =?iso-8859-1?Q?Y/CqlsfulqUzX6SIE1nqDvskGqw31xrcyljmbHg6qYQZEBUBVbY36uDXSk?=
 =?iso-8859-1?Q?Dj/Mhe0sjnccdS1ZjiCv4rOzgysC3enXlGOtkXltgRHvlpQmiIr9PBzkVT?=
 =?iso-8859-1?Q?Hut4rP2Y8/BMnnX8aMTLrHlWoUC7PbQ9l8JHK23DJ+bZ5g1KSNjcJk+LyK?=
 =?iso-8859-1?Q?hcTpIPZVHsXyFqVQAOhosFzVyX62bC1m8UhNoCtLoq34ivRdl6zxHzjz4V?=
 =?iso-8859-1?Q?UikfOm5serXvEbMbInsybxr9qDyiP+qqmnLoFp4Ur005Ketcg1Zx6x5xLX?=
 =?iso-8859-1?Q?GmLmgslESynXl8VaE/3y73xnOraPjLsv2fRnyjGR1kKCaxO7po9cegaXMA?=
 =?iso-8859-1?Q?LFuliuJ7sFARQD2ocz36kTS3fuf6S9w4dbgmKs0rqmw7IPKX6OkzqkZjRw?=
 =?iso-8859-1?Q?eVeD+T+Lz7xqYyU6ZgukvLMphf1z1E+RcnrnmwB1R5Nrf0aPYxNHG9WlZY?=
 =?iso-8859-1?Q?47wlsLQ9Pv8GrJ4Y4HzS3YmaYCsjv0q4vFrbl97ncSxGNwAE3actwEoWhn?=
 =?iso-8859-1?Q?M9xntFRQ1c3L5R+rMWf91IhJomJTyZJjqB4sk6lDdIVTX6Wltv+H+xRgTB?=
 =?iso-8859-1?Q?WP19NfoD9Y1YmPj39isSg84r1OnbaWH1ci1le/8oV/FwdoCz3BcX3SC809?=
 =?iso-8859-1?Q?INETxhd7xSwlQTg/3tOKxYt6rdOvO/0yk3rG9bR8WjLB7KQmPRXx/0W0Un?=
 =?iso-8859-1?Q?9TTofn+4ftPlxkttw23bkpoVXR6jsC9ylFIZBz1ar6Zs8jo8AcKqT76JhH?=
 =?iso-8859-1?Q?UzhOjg7PhDZT4ajJIsSeHT5KEJGJtEP7yoxu5mOMl+Idx/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8eba43-4465-4c7a-7df1-08de672c6847
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:09:16.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cph3okij9jLUnJRjivxDYm6/+5BnGaIH4wqLCiEcfn9JLkFQ1u34KD4u5DDS5ATn9A+fEXu7zRzDmdQItTZZ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257841-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9A9ED1095A4
X-Rspamd-Action: no action

In subject: s/own MLD querier disappearance/own querier disappearance/ ?

On Fri, Feb 06, 2026 at 03:52:13AM +0100, Linus Lüssing wrote:
> This change ensures that the new multicast active state variable is
> immediately unset if our internal IGMP/MLD querier was elected and
> now disabled.
> 
> If no IGMP/MLD querier exists on the link then we can't reliably receive
> IGMP/MLD reports and in turn can't ensure the completeness of our MDB
> anymore either.
> 
> No functional change for the fast/data path yet. This is the last
> necessary check before using the new multicast active state variable
> in the fast/data path, too.

The last sentence needs to be dropped?

> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

Code looks fine:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> ---
>  net/bridge/br_multicast.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index a1cde2ba2a3e..2710c21daef5 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4914,6 +4914,7 @@ int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val)
>  #endif
>  
>  unlock:
> +	br_multicast_update_active(brmctx);
>  	spin_unlock_bh(&brmctx->br->multicast_lock);
>  
>  	return 0;
> -- 
> 2.51.0
> 

