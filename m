Return-Path: <netdev+bounces-232019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2877AC00234
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D683A1A64D0F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55652F9995;
	Thu, 23 Oct 2025 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R1oj8grY"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38B12DF14B
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210598; cv=fail; b=K7Od+muRJFQvWSNmF0pNJmiM/x5d8jNc82gjrOlKdtu+1INllr2kQj5Ak6M1xZiccxhr+27BH/zRt46BWURvoI0uTa3EzGzViLvOFCG4ecNG5KNf3vCsgJ/Fr1ekQD3SOvj36A15JMTBy2JoItTbd2lHjykSsnnDypZqvzqkEfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210598; c=relaxed/simple;
	bh=fw7j3yJ1ROk5/4DHJfFX0EoIPieR4hm6GVNocuyr3n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N3C5JNRllDkv1TG0cgC+Dwt5cMpb+N7I6bVdPJ3g7iV0VKmAXabfj+dej53yI5gcWfsRkX8gOzDxSENd4jzobBGgADJPXrpFSte5Vi7dUll/k9rb6gnwKa1vT5JEPOlWM+aH74SGt3QDtkaiBI9gnmTs0jMECdgl4ad9tVPvncY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R1oj8grY; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7TAzHmPlZCkIW1B6xttCs7O5vRcc681G5E/wTEIbem8f4aVFNTHVqgmWF5+s+YLYxYDn4p2sX9B8SmFDei5uj5YHOoFoVud3id3t65bg10OOr8fH1VoZjRNSZdBn8fqSzw7wwFa2FxdpUGPwMpASQ1DBj5WV9Vo92f2rWofYEWEHzeC/nPt8e+I54lrZRhyt0qp35/odF1jJO+SMGUGFsS25L2erqF+lUgf4qp4NtQVWOqgLuAxQY58Yac5tzkzvPQyb73FG+D1epNQ/TgcD0FVKllM7O47W8+UFeHtC0VypzYMqTj4tY5qm221FpvUC45vx9hCHDAEaNY8D+MNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZOnkuKdqiv1z8/GvhNGtmmzvooEw9imSI9JiUaCeCM=;
 b=A+x0REKkqAbXO0qQxwRXroxQou0UohHvWRaTzElg7FFMAdBG9aGu12jGbTqR67jJWVEsI1pqiDPsPI3jVrhVtW8IqQ+8Rs32+VZ2bL4RhljQ5Tmr9DWn5VcK+T3hX6rHrjvMf/NLvHu2jdv1tqHwRZgdPQk1t2oPlVaiLbkBxAz7VaAwSBF71puWvn2h/EWIvoBfAAVOo8gO5d5E1sDd4ZJvmmFgefqcR9EeOQ6YmAkFF5oLXsguiqnJAyZnLKdOzxW4SkmKKmW/t6Y9qz82AGnXKnzsJGTgjrgFh2LjMvjnlBHvNVZXPtPWaP5QD0KW6De9be8bJBwjPtlOCDXTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZOnkuKdqiv1z8/GvhNGtmmzvooEw9imSI9JiUaCeCM=;
 b=R1oj8grY/apF5x3QadEfebBIDM9BnopUWz+nSQ2w0c0xzKruDBZ7Vj/Lwlt3TWPiZQnIheIwlTXRbHnAhr7KZEH8qKXHSvisx0bXLemn0s2V0g9VkFklr66zZ+1SroAAgnj5r3qzpI6m/ZUtP7zfPkQTuOeFQ1pbWREc+y986wrxsT/ljZB6k4w4IBfSTCmjk3T4ard0WFCWeSlhvDPGb9xtCgACErZuuhAs298wLVB60l3F5UrpZw1HuKUrPZLm4dVXRgkOSNt3LadLR1ffnhoq8GC930SKQ1v2V/xWfhcHp1ddxqQ9d6qs1kfyOzmrOeaNO56SahrMzh2Qf8oNQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:09:54 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 09:09:53 +0000
Date: Thu, 23 Oct 2025 12:09:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	dsahern@kernel.org, petrm@nvidia.com, willemb@google.com,
	daniel@iogearbox.net, fw@strlen.de, ishaangandhi@gmail.com,
	rbonica@juniper.net, tom@herbertland.com
Subject: Re: [PATCH net-next 3/3] selftests: traceroute: Add ICMP extensions
 tests
Message-ID: <aPnw2PkF3ZMP9EJr@shredder>
References: <20251022065349.434123-1-idosch@nvidia.com>
 <20251022065349.434123-4-idosch@nvidia.com>
 <willemdebruijn.kernel.2a6712077e40c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2a6712077e40c@gmail.com>
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: f8cc3492-3a70-4f40-c444-08de1213edd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qbhQfFk34RKBE1keODUOO9wE1CmyJkg7oNCnxUZU1O0Obr+nobSr7Q92ZLz1?=
 =?us-ascii?Q?oN5I51BBQEBxif0GGjFFNJfK9sJS7d/7XN6ulVFJuwUahWOXUZei+BUk4C6Y?=
 =?us-ascii?Q?pkWsoHJsMbyvQlsKYp+2qokdBdYjASqw4M4VzU+9jB/TP+KGlqlcKA6dkrh4?=
 =?us-ascii?Q?kybwmczMBk8oCMcGrZfDhYAnsraRkEvhBDkSTS4UxYJQQdd0mqZZqD5zau7P?=
 =?us-ascii?Q?qz+LvhYccQFSpc0HdMFLrj/rCK4gi9pz6aUv2My58Yq8HqvhYY7ygNm3Hk2Y?=
 =?us-ascii?Q?spvn63yNaEN3fPGVKudcD4bwLpR4pT0SbNZSNKgQ1YFmrFbAy43lYnWJnqm2?=
 =?us-ascii?Q?VazXYqxsEoI9F5+dAWdAKw0t3BjZovtPmGyrK2KffHKuOi67pd1sC9BxJMfk?=
 =?us-ascii?Q?gHhExmOO8Psmg/fnOrgiHfO4hSa8Dyk+bi/8vyQxD8IByBy+sFpY7iiGskBG?=
 =?us-ascii?Q?gdd79OGyWcxnJKBMgAAI/RzPbGrcvdvbi0zWZ3Kekj1xQt8grUmyEkJxK/mK?=
 =?us-ascii?Q?Abhnx0eX5m4CAoA+Wv8gAKFRLY3kXnmbP00YLtmt5nQ9KN8H+6McnskeOs1f?=
 =?us-ascii?Q?2+RC4QwaQyXEasd+QGNEBDjv8vbVs39Wau5Vujw0rN+XLGhcy3SEJgwhrVVp?=
 =?us-ascii?Q?AD6uJ41PbUYkbF1nk2RnIiJk0YeMvLTIppESpMt/ueIVVk21YDQ8KmYCkey4?=
 =?us-ascii?Q?Xh8W5C3wtn433TO7u8JzpNYeMyhyPKWyLIQ8EjXwbReQ44yBcC50Gbm5/WUZ?=
 =?us-ascii?Q?i80B3b7trh1CDpxjyIgupEEzZUjoIriaz3w9mVzNSnOqbZ3GsuFaKGJPf0jp?=
 =?us-ascii?Q?L7JsVJQb9bnlKCqjkbkuIBXNk4yRxg075C5DskVdrS+8nPsXcEaqjpkgowza?=
 =?us-ascii?Q?GiqJy1qTIsrhYYWC+oDywXPfkNfg/VUnxzWq4uE2AypVSw+Rn8ew2H/Wub5v?=
 =?us-ascii?Q?QFCBWaBWn1+/HpqmlTo5fLhn/2JFezxj1A6QvUejMIDhbrM6uVoAu8AHYx7E?=
 =?us-ascii?Q?9vASJnbdRtdzXreF5pmNP7aBjRpCbedP07qdquSTjDWYn3neRqNZkksxmUOx?=
 =?us-ascii?Q?Yc0NZAqRH9Jl1axR2cl9TZRl3mIIiBLpXzWqK9pO67pEaJHKTLSQTJXBBfPF?=
 =?us-ascii?Q?6hCGHi2RAkh0YRzrR6y8U9I2EDP2oxa4bkCr9fUVH2agaPrHO83W8N5WALej?=
 =?us-ascii?Q?+th9hSLZ08wr0GjGom1HR4GEyojKmAumX+sHhJruR5ljFr3nm3j1SRVq6iNo?=
 =?us-ascii?Q?DUg4cPDl7glEPODXcc2XaxQGO+nhPbmzbu6w3ZyrB89qnjqPuDHQ/F9ruang?=
 =?us-ascii?Q?UQ/Z0T5jPkiUe143Zp/5iIgAIQu0HNwYj61aGDgJ7KmVkiyeDk762rjTANJQ?=
 =?us-ascii?Q?NQtnk0t69ynd2Ca5stKx/TEALPD98Tty9MjLCTmE5rvCo/GHrC+UMjXEvSWs?=
 =?us-ascii?Q?fAMAaI5y010IyTiLLLWJHjpZrvac1hkw+i0os1ZOYNeUjUD9AhJURA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y/yKJhKvHCCyz/gA4DfXulPAuLc8dmZ2nhkZ5BuHElYMwExnJqDfTDRfAZ7W?=
 =?us-ascii?Q?MBJaGaINUEEI5rdSJ3HG7kHkHHgNms1jfrSy6lSb7i4dgeIxOgztKJNGu5E/?=
 =?us-ascii?Q?pS4INJ6c7gOYuyVxWeh/J8PGHmjH0Mu1zRXS+Y07nKKQ6xVo6QaYXBsuWyjf?=
 =?us-ascii?Q?kh5kdNeXyjV1AV57hj7JDLZvVi/i5hl6gxF9DciUba81VrdOnQFP8ZNs2bS7?=
 =?us-ascii?Q?3l8QM9s/w7FMf+QNq0mzlVr+YkFx1pXocZTW7pVeuCvFyClQbUnNb5cTXIYs?=
 =?us-ascii?Q?5JmEaHiUPBXtPp75mP8BPYzNVF0w8dEQY5GmkUhLhA0vhc8zxKlQrtub8jTy?=
 =?us-ascii?Q?91t/WP1nvAswscZAP5zZYrgHGIv5QfNmykmIvxIpIGnInr00a/Ym4C1PR6YY?=
 =?us-ascii?Q?ITbM9H/0VcpCTDgozaza97FCSfbhsMxHjJhqONhfFbtYWZQGvErucvrD4Tbq?=
 =?us-ascii?Q?Q2k6c6ZLwVdU7vG+7nGUoHHRblFnGJGBD7VYjXkwJht8ij5gNe7N3ODkkjB4?=
 =?us-ascii?Q?SvS2GRnw2IQ4OTECzU4GGWIF1zWcNObzsrVUn2IUmkidwyk/RS6FPyvfAjM2?=
 =?us-ascii?Q?HnLMTBVtZMoNpTdBq6V1jY25qIJLOc77Uxg7lgzYYTW9YKEgonNdAByR0zkU?=
 =?us-ascii?Q?gvR6z0EMAQHVvo0hm+JuS+mh9/UjRj5NOtcEkSgBUiQPxWjyjT1U+fpCcT1f?=
 =?us-ascii?Q?eohCQdA6b+YsQmBla2R2tqr6gyzgUctjxo/9IPMoLPOf6f9iL1+4hh2jxL2h?=
 =?us-ascii?Q?yzahVxMKcZw/+1mh0Tly8gzdI6QDjZbb7mLf9t4eO1WGLRGHgRFQex0N8E7g?=
 =?us-ascii?Q?x8xsCRivOLGXCz/rkMlo3NstWCUnc4YdxH+yKiJ35HLjhkEnA8TnAskJuyYc?=
 =?us-ascii?Q?5e6f3xOlqSyf3U/IBydqrUjcwF1Isa8oiro9FGZmYjrvwKBFccpc9VnmVFcz?=
 =?us-ascii?Q?Ffz005IY2BLLivYheccXERozoQm0B9iJQkLSRawFeXAx31E62xbKJqbcoX1i?=
 =?us-ascii?Q?1o0/6zF30yMMXtxbvoVesySru0pyWA6kp+mHnQV+nnEDmkbiHIsR6k/TbM71?=
 =?us-ascii?Q?B70HZb5Yyuv7Ejx3wPEChJ9oUI+0xnQ3yG+deJ3mullgkKUz4SCARYw5Qucb?=
 =?us-ascii?Q?+I7apAqFrTV+33K66XAZxUKQkFqonpAvr1maK9TMXGV1NMBF4fwxWturqOEo?=
 =?us-ascii?Q?KzqrJrBqGnbwetRQ77vQddNTm8ZFfbvmSqkskLdN2kNlaBQ9Liqy4E4Qp4On?=
 =?us-ascii?Q?xlZDy4O5Wpj+kaasP83/nVBaObF18t6v2tA7JSqLBGcfChU5ZnQKmIPCCDO8?=
 =?us-ascii?Q?QnWo2wvHSbrStfbEyF1DzbqsZCcg9YUVR/cPf6BPrRSSW0NEeqSRCFWQ2X6a?=
 =?us-ascii?Q?LPNNRB+2GQ2dmE18FadtbX5Z9G+1MGES9B9OYIXFwlWaMLAMlinx8hAIfXMn?=
 =?us-ascii?Q?fJhtPUEPvusee7RFTDuImuli+jR1KpbJI6QWvOwQsy/eXm1vYHi7gZZUY06L?=
 =?us-ascii?Q?Io4K9mTRiR5x5s/SjChdQ4iZw6dbfcofLJsCUDtQUfh1a1RTzAm05NbkJXcj?=
 =?us-ascii?Q?EBnCiQv3UuFRFgtj8DTnmVMEq2Fu+/q5v8+BirRp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cc3492-3a70-4f40-c444-08de1213edd0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:09:53.8076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWWvCZeZkYanllfkeHgUr2a/9OgeMPWH6sA5+DWuSkTn4ZXuWIGjaGiZMtjw0ipQc1LChKGsRgYn1AqeVIP/Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398

On Wed, Oct 22, 2025 at 06:12:13PM -0400, Willem de Bruijn wrote:
> Ido Schimmel wrote:
> > Test that ICMP extensions are reported correctly when enabled and not
> > reported when disabled. Test both IPv4 and IPv6 and using different
> > packet sizes, to make sure trimming / padding works correctly.
> > 
> > Disable ICMP rate limiting (defaults to 1 per-second per-target) so that
> > the kernel will always generate ICMP errors when needed.
> 
> This reminds me that when I added SOL_IP/IP_RECVERR_4884, the selftest
> was not integrated into kselftests. Commit eba75c587e81 points to
> 
> https://github.com/wdebruij/kerneltools/blob/master/tests/recv_icmp_v2.c

Yes, I saw that :)

> 
> It might be useful to verify that the kernel recv path that parses
> RFC 4884 compliant ICMP messages correctly handles these RFC 4884
> messages.
> 
> But traceroute parsing the data is sufficient validation that packet
> generation is compliant with the RFCs.

We plan to:

1. Add RFC 5837 support to tracepath using the socket options that you
added (instead of assuming that the ICMP extensions are at a fixed
offset like traceroute does).

2. Add a kernel selftest for these socket options. If you want to do
that yourself now that the kernel can generate ICMP extensions (assuming
the patches are accepted), that's fine too.

I already verified that traceroute, wireshark and tcpdump correctly
parse the ICMP messages generated by this series, so I don't expect to
encounter any problems when we integrate this with tracepath.

> 
> > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> >  tools/testing/selftests/net/traceroute.sh | 280 ++++++++++++++++++++++
> >  1 file changed, 280 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
> > index dbb34c7e09ce..a57c61bd0b25 100755
> > --- a/tools/testing/selftests/net/traceroute.sh
> > +++ b/tools/testing/selftests/net/traceroute.sh
> > @@ -59,6 +59,8 @@ create_ns()
> >  	ip netns exec ${ns} ip -6 ro add unreachable default metric 8192
> >  
> >  	ip netns exec ${ns} sysctl -qw net.ipv4.ip_forward=1
> > +	ip netns exec ${ns} sysctl -qw net.ipv4.icmp_ratelimit=0
> > +	ip netns exec ${ns} sysctl -qw net.ipv6.icmp.ratelimit=0
> >  	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
> >  	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.forwarding=1
> >  	ip netns exec ${ns} sysctl -qw net.ipv6.conf.default.forwarding=1
> > @@ -297,6 +299,142 @@ run_traceroute6_vrf()
> >  	cleanup_traceroute6_vrf
> >  }
> >  
> > +################################################################################
> > +# traceroute6 with ICMP extensions test
> > +#
> > +# Verify that in this scenario
> > +#
> > +# ----                          ----                          ----
> > +# |H1|--------------------------|R1|--------------------------|H2|
> > +# ----            N1            ----            N2            ----
> > +#
> > +# ICMP extensions are correctly reported. The loopback interfaces on all the
> > +# nodes are assigned global addresses and the interfaces connecting the nodes
> > +# are assigned IPv6 link-local addresses.
> > +
> > +cleanup_traceroute6_ext()
> > +{
> > +	cleanup_all_ns
> > +}
> > +
> > +setup_traceroute6_ext()
> > +{
> > +	# Start clean
> > +	cleanup_traceroute6_ext
> > +
> > +	setup_ns h1 r1 h2
> > +	create_ns "$h1"
> > +	create_ns "$r1"
> > +	create_ns "$h2"
> > +
> > +	# Setup N1
> > +	connect_ns "$h1" eth1 - fe80::1/64 "$r1" eth1 - fe80::2/64
> > +	# Setup N2
> > +	connect_ns "$r1" eth2 - fe80::3/64 "$h2" eth2 - fe80::4/64
> > +
> > +	# Setup H1
> > +	ip -n "$h1" address add 2001:db8:1::1/128 dev lo
> 
> nodad or not needed in this lo special case?

I believe IFF_LOOPBACK is equivalent to IFA_F_NODAD. See the check at
the beginning of addrconf_dad_begin().

> 
> > +	ip -n "$h1" route add ::/0 nexthop via fe80::2 dev eth1
> > +
> > +	# Setup R1
> > +	ip -n "$r1" address add 2001:db8:1::2/128 dev lo
> > +	ip -n "$r1" route add 2001:db8:1::1/128 nexthop via fe80::1 dev eth1
> > +	ip -n "$r1" route add 2001:db8:1::3/128 nexthop via fe80::4 dev eth2
> > +
> > +	# Setup H2
> > +	ip -n "$h2" address add 2001:db8:1::3/128 dev lo
> > +	ip -n "$h2" route add ::/0 nexthop via fe80::3 dev eth2
> > +
> > +	# Prime the network
> > +	ip netns exec "$h1" ping6 -c5 2001:db8:1::3 >/dev/null 2>&1
> > +}

[...]

> > +################################################################################
> > +# traceroute with ICMP extensions test
> > +#
> > +# Verify that in this scenario
> > +#
> > +# ----                          ----                          ----
> > +# |H1|--------------------------|R1|--------------------------|H2|
> > +# ----            N1            ----            N2            ----
> > +#
> > +# ICMP extensions are correctly reported. The loopback interfaces on all the
> > +# nodes are assigned global addresses and the interfaces connecting the nodes
> > +# are assigned IPv6 link-local addresses.
> > +
> > +cleanup_traceroute_ext()
> > +{
> > +	cleanup_all_ns
> > +}
> > +
> > +setup_traceroute_ext()
> > +{
> > +	# Start clean
> > +	cleanup_traceroute_ext
> > +
> > +	setup_ns h1 r1 h2
> > +	create_ns "$h1"
> > +	create_ns "$r1"
> > +	create_ns "$h2"
> > +
> > +	# Setup N1
> > +	connect_ns "$h1" eth1 - fe80::1/64 "$r1" eth1 - fe80::2/64
> > +	# Setup N2
> > +	connect_ns "$r1" eth2 - fe80::3/64 "$h2" eth2 - fe80::4/64
> 
> Stray IPv6 addresses in this IPv4 test?

No, that's intentional :) The use case I'm interested in supporting is
an unnumbered network where router interfaces are only assigned IPv6
link-local addresses and IPv4 routes are configured with IPv6 nexthops.
In these networks only the loopback / VRF interface is configured with
an IPv4 address.

In fact, there are networks where nodes do not have an IPv4 address at
all. In these networks ICMP messages will be generated with a source IP
of 192.0.0.8 (see INADDR_DUMMY in __icmp_send()). That's one motivation
for the Node Identification Object which we might support in the future:
https://datatracker.ietf.org/doc/html/draft-ietf-intarea-extended-icmp-nodeid-04

> As a matter of fact, is it feasible to merge the IPv4 and IPv6 tests
> with some basic variables like $TRACEROUTE, $SYSCTL_PATH and $ADDR?
> 
> (I appreciate that you spent more time looking at that, fine to leave
> if it is not practical to do so.)

Will look into it.

Thanks!

