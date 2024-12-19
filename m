Return-Path: <netdev+bounces-153251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070999F7715
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56291162BEE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C721BD01D;
	Thu, 19 Dec 2024 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bwsoyUjU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8131853
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734596246; cv=fail; b=tWyAhbuvyEjrLOYo+9dLdVwty20ejgGEJ/cR1/khPy6h4/oHL2jpZ4yUDWIuqpH4s2+8PxHf9SdzjM43+V7POL8pM+bZ4uhQkP1AjBhpTa5duRAjIIcxzprKN6FZlVknlOBp/dXK3MJmfTg0ZlMQnkHeaDbPo+lMZytySJPGffM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734596246; c=relaxed/simple;
	bh=fD4wRv7jOPinrjBoKvdU+GoGhKjB2IeOpf3yVEKCooY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GDZTi+i0qPTMnHMNlNziVeB0JzItppAQHIOmQeNdlXhu78FXVeWV7NZ3v3/uB1unco2xkBYrjdkoPLw/iUZGUAL2u5Oyg3YPQDczkkLKk++i3B7Nj2f2JqJwV6l/ntUncFwRwGwJAIcH1rQyRNoRpjOyTpa5U7nqUr7fgQW5S6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bwsoyUjU; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg5KhDP/BLk3fTugRYxkzfEaZDysedyXDb4pVo0sKsEvK5L7vO8EJF3KzaY3DHP6gVHkW4GlasBztskLrc+YItQ7qU7gGLe1bqjdY/8p5re6pHPSZ7Rs0TuRNmR8uYGcuattOlQkuy694PzIZUzomAxPXWIO+thDep6qcgS2g4jZDvcSQgaeqONgUJQIcrGzLyVhBSJsqUC7UxseLnqUiLa9mwNETzqfZZ0pmVvfo0Rxvy6oZC3ffky1Pv14mAoGVInTu6RlyrVduDv1MDkoLKdo6bRhjLWRvHDdAft7ANbVEJXsfb/AVvUpTp2cgIIs5IefvlGRfuI0PqowjQ4/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTRl2PN+AK1HpGBJXzwFpqnjbw/8vNadxBMcHcKnF/0=;
 b=rLwjWc8ukFwH7EOTmDXOz6zPuleyrSwGv3biEJBwmNT3gdfHja2EFitrBkPr2DPqWF9FAN6MrvqET5uheGIAHxMNlzdOWLLZnaeKhUvvRHFyYOm3I526jUfY5obdd9eQ+B+ZvUmwmTBd3+wkVfnFaT3XUIl/UYCyPDcMe6QELIPPip2bv93U5WKKd2Bi19PA05F4QOCyaw42/6qn/Fs+CCSV2aWsOvDE8jUTmhg2Biye3sYDtd6SCiB44xhgxewuMZroYvb9bC7I/z1Ndn/G7U77BsFUUs1Ukkw09OUmgVdZ6uDL0ohmqSzgV1hoYqiquUtgS9vr5g6roBNGwnE5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTRl2PN+AK1HpGBJXzwFpqnjbw/8vNadxBMcHcKnF/0=;
 b=bwsoyUjUFvFwBEXMxTN9H5or3iMQw6qMhctYwJrULr42OOaj52WetZflSFElwy0hmIJCm0i8HX7aSl20W/telJQc3M1EVCSvlG6oGlnIBLkIvbs4PcbRqIY7HD1CuuEMZV+XDNbO6lDKw4rXDxCeuIhbcWRM62+9iPIiGCzynePpybqjwS9EJHQkEy58XIXa+wH7pKw0cnPZFjWZ0j8uHjo9V8WAiLsF0hbydv7R4bziXQML6skw8mxVW6AFqIDiofv70t12Y+Gu9Cx0pnS0r+cv83dC7SGRYVhmfJGdvmd2dHALeDUUOXG77dh8LfMlugMx31bEvqbQeNMsTBzLZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 08:17:22 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 08:17:22 +0000
Date: Thu, 19 Dec 2024 10:17:12 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, donald.hunter@gmail.com,
	horms@kernel.org, gnault@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	petrm@nvidia.com
Subject: Re: [PATCH net-next 3/9] ipv6: fib_rules: Add flow label support
Message-ID: <Z2PWiNKaCHz3yOJ8@shredder>
References: <20241216171201.274644-1-idosch@nvidia.com>
 <20241216171201.274644-4-idosch@nvidia.com>
 <20241218190509.5aba9223@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218190509.5aba9223@kernel.org>
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8a7a39-a6f8-4469-9a37-08dd20058ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xj7AXdSBVJOMLIRYHQ6TqdMX9HSaT5Wv2FdbKPOSRQn0JdKoSlvK5CofMG4U?=
 =?us-ascii?Q?01+y6syTHe3fI/ezAXjeh7F5XgSAk5nS8BHEf02H86xS3PiKJqxWgThDxHCQ?=
 =?us-ascii?Q?05d0lrRCho+jPCHyxQIixFN5x57tOlfC+JRHc1fcQ1C7mNJlXku/BSfS0h7p?=
 =?us-ascii?Q?n7h2dNq7wS6WWiXtHLquo2D+1aGbGOH958sbKkvRFnBW31L8M+Ud/DW6jq6D?=
 =?us-ascii?Q?xqi7B7onRUlaTw38/r4InBGI6DWsd+OwxHPP/I6/pc0/T6BB1jOZerELXiyv?=
 =?us-ascii?Q?PvOuOuLio1TXWkE6WICgByAvkPoecxDRA+41PrUaPecqg+lMGxoAVDcI8/OK?=
 =?us-ascii?Q?+p6obCGTqunLx6cCq4SRCi7cEh6ra1/pdNchgxpnidxqYcJx+S9cHcCrtuDI?=
 =?us-ascii?Q?qGg+WZF3Y1qEO3QbVS8h0/6RHDLSNkRAyuiOUSdZ6uVsMMWFksUUTD4KO4HL?=
 =?us-ascii?Q?Xsqt4k8oBBzpH4qabNddNe10j2kN+fHuxxt2EHhbiNAjohEGJCUAlycQS6pI?=
 =?us-ascii?Q?gmT3tG02tqlFhvradm6nygS4xDTXMijyFb1bOz9CMDYd4ZF6ALUg7tA9/fU8?=
 =?us-ascii?Q?QpJbRi2sqpd9jPg7XKUz/Hw+1YvRw1szaNU+H1nZ0xao88IswTd8CiUrs5gV?=
 =?us-ascii?Q?k8kgiZrU1jMrTVNGrnve8kUPiepFgpYr5w9zOSapH2YEmz2K1gbPIqSLuDYn?=
 =?us-ascii?Q?eUhEPxyN2joYN7c51WESj2hGPJZxKVikrZINdV30VQw/c/qMchg4SQ6rSLHM?=
 =?us-ascii?Q?G1HnQHo5cAgyaq8mDwKWCJullhBmcAUaJGmvLqYDIS5coqJ8vEQrEgYhJDBc?=
 =?us-ascii?Q?Uz7y+fNrO3KRbvh7xiEvw8mjl+7KNnnYxbzJlnZBJXScL9hMHCeIoXazMJpT?=
 =?us-ascii?Q?aVyCme/ldPD7TBeuSDuPCLK1ifMfBlaWGvd0+TWfvwS1EDzgr1KYmzagb/YN?=
 =?us-ascii?Q?LYiGESnPBid0OtuGzODZ7JyVJRgBWKjoOUFfi069R5i1aEr8IPeInS3hjJUX?=
 =?us-ascii?Q?Ov5kfSY9THjfTzGltR9c1QanhYz4uOtitVtNJWtdQ7RkgOldgltMvf2zjOki?=
 =?us-ascii?Q?beAtFhf/TIcqiWyNJttZJm+ltA1FJ5R0jKnLQbkDn4fps1aJkZ6NUmmx3+2h?=
 =?us-ascii?Q?oDg2M7q9SqzBH/CIRdzEx7GHAwbrzg/1TiW10FFH7La1ZD8DK6bgm3yUCKNi?=
 =?us-ascii?Q?J9LXGpzpvWCErronrXLm1QksBuZltLphB7qg4lvCTLN9c/4Mzv5MK28kOm28?=
 =?us-ascii?Q?iakkKvOePk8tayUXfKNHIbu/7Awy8vV9n9ZtYxIiTcika2gDw6piH132BgZi?=
 =?us-ascii?Q?enkAbiaBkRUGYo9eeAM2ojUcPGEVs3X74YNA8luLTmMs7A/eT38/0zdoOqJp?=
 =?us-ascii?Q?grwNz4F7elrVpSimBYWHCYf6R/Q+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fnZ7cpquCTvUXxKI/oYbcKLi4TOK4Vi5VZmP4ZR0njv3NpHzv63uUMTmvRU1?=
 =?us-ascii?Q?jPbln4bh1clXYruxpBPeYVyNl5SBE2l33ix/cWnAM4K/DcproY1A/IS88TDt?=
 =?us-ascii?Q?mLVmhr3mV5bxVkFsVZ4sAELFJau5m3lDiOtaUMGnv3PiKaVI2ViDPCbwyMyV?=
 =?us-ascii?Q?nWoblYXNZeQHiLVRQMgGWGGABBMCJGXjWlqOSO3tQy5cKduoYitce6VXUDO4?=
 =?us-ascii?Q?LHuvOo8Oqj+AskNdC3OzvWDNfZ14HbGrPEGv7KgGsTX0CCDj0ARBbrzRzXqi?=
 =?us-ascii?Q?dZGeDujZuWUbuogC2Sre88fMHlQOMTTJExv8vLLw3Dyt6I5lMvyH5iKFeHBy?=
 =?us-ascii?Q?SqEZLjWW87TR9doPOhgUcOcrFgFhWbsEIUrSc8OzntUpq93uEnHTHFzPbpvp?=
 =?us-ascii?Q?MYfGsOAnVrmdboxkQYI5ddayxp4NeOx8wif7ACtjlp4Tm48oGPi0hkmFPyrV?=
 =?us-ascii?Q?XUUkBMp1fxs6hHAhlmOa78wdEJsVt82Fk/X+EOYxsXafDD1+tY5KMYjJ6dAC?=
 =?us-ascii?Q?dqAioZXGaZsMlyApLkMUsvWuO6KrtV3eMc8ULr4EgrzBvD4aFgrIO1GnzALf?=
 =?us-ascii?Q?4Z5mMMe6cYitfIfE8lEYhI6g8eTaJsHZhQDwB4EmjQTrtrJNNJUwBTfOnGnA?=
 =?us-ascii?Q?EjHg6wa1qVyBmKTqrKdw1GihrOr1/yvNyHU1pGgOvGwCm3E/o+UzqSACCWcA?=
 =?us-ascii?Q?iBzhuC/z14wXoOMDf2BhgyW9DtbQONCnPlS9c0eUR9P/XeW2oP8+2UDqh+sJ?=
 =?us-ascii?Q?vaClnYNiX6t9+R16oCXrXKYwUb9XmW42lfrZ4sMlRT/mcfOoTvoT3hRHcL+x?=
 =?us-ascii?Q?92cJzBei5lN2Kn3BwDIUGGZgqZzuzriSrd1cCC4lmyUGMc2xvt52d1eT+6CV?=
 =?us-ascii?Q?CizkZKjrlm1zEHS7/gTOKAWAItbDg2EHkcnhmAhzixDhM18p+gxrVw5jYSkq?=
 =?us-ascii?Q?JASvtWaWl/A09xugbPS8T10x539SXZ2MpMefmVQQTy5r6saZenerIVDUKG3Y?=
 =?us-ascii?Q?UJU0GTeZhoCqKiG+kIimVplnKNA+5jtT/FwNamkxF00oAFEiXB5uSix7kJUu?=
 =?us-ascii?Q?2TzWGJruAKwOaw5J20h6FO6qrlXPp+brnhyJxLyKHqyYRhkQgcAMVNg7mHGl?=
 =?us-ascii?Q?LkulSpDM36hydpeM6CGZTGomLcIuRJ4bGaqhUa5ysBaz+RKUv8nE8t0WiOHJ?=
 =?us-ascii?Q?wdnNfVQtZ/T1FVMwzMRzI6ho1leAPGX7vfp8QAv33Hcz3Rr48fzulNTm5gcg?=
 =?us-ascii?Q?lYLLJH+Q2zPOSjcZRAvSSfaqqtmd370MOEcX0d5ZT1Y3/tG+qHS+9tM/Eewg?=
 =?us-ascii?Q?zhIZRjJh5oD5G35hpF+OqK1JcW6V1ZQqSYGWE8p+9mb/xkSPyvLupxkHLNO5?=
 =?us-ascii?Q?Ou71krYd20KslHqAbkV4vdoNEaXhcY9re1F6DAGgDTEcC7VRW4JuXr2jeWt5?=
 =?us-ascii?Q?HvBUwBAG88e+vNAWiLRu3r9mX+jSQN7oa3Pje5QezXp3wF6dlB/qda77f7B1?=
 =?us-ascii?Q?11g3yUYPAC9df4DFJ2jHXoHmDku4JE/S0H4dFbaawGpLUAc17cAU4KkBh7SJ?=
 =?us-ascii?Q?40ISmAngTeF8ZsXAA2iBo8MMhC7wRE3OPm4tpD1j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8a7a39-a6f8-4469-9a37-08dd20058ff0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 08:17:21.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOSjE5HvhRwWSxu8CuWfMmB653tJRb1hOgO9Ca02TgQIdQFZ1SgGeZ7KjX6PV5AFCeAgX0BdB8eFjpHWqAJ43g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999

On Wed, Dec 18, 2024 at 07:05:09PM -0800, Jakub Kicinski wrote:
> On Mon, 16 Dec 2024 19:11:55 +0200 Ido Schimmel wrote:
> > +	if (flowlabel_mask & ~IPV6_FLOWLABEL_MASK) {
> > +		NL_SET_ERR_MSG_ATTR(extack, tb[FRA_FLOWLABEL_MASK],
> > +				    "Invalid flow label mask");
> > +		return -EINVAL;
> > +	}
> 
> Have you considered NLA_POLICY_MASK() ?
> Technically it does support be32, but we'd need to bswap ~IPV6_FLOWLABEL_MASK
> and you need the helper anyway... so up to you.

I did consider it, but I preferred to have all the checks at the same
place in the IPv6 code instead of having it split between IPv6 and core

> 
> > +	if (flowlabel & ~flowlabel_mask) {
> > +		NL_SET_ERR_MSG(extack, "Flow label and mask do not match");
> > +		return -EINVAL;
> > +	}

