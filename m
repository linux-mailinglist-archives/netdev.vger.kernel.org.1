Return-Path: <netdev+bounces-232315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26DC040B3
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9881892B47
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B6119DF6A;
	Fri, 24 Oct 2025 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtY4AfNS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191D24B28
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270539; cv=none; b=XvOBcrPp0V/TlgmDQvcmBQ6qOO0xBK4YUkFaLBymxMEiEN/QRwxaHfGWWP8wjUPQrengdaowMgKwGirtKH+/brTQQ9O25sfErA39bNIj80vwjJGFMiVjwHDgE65iCTJRmw6PgKu933ft5pPI7MVGc/CFxkCc0kWFUGZE1gMwnEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270539; c=relaxed/simple;
	bh=L+mUYv0VX4crC/NG7fH+AStQQ5waEx1Ev/rWiY5RII8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1LuZTuR/tkHY3q45ip2NiOpNGJkPPxLs1zec7nzPdJC/u5ufy4Fd/jWx2kyeFrdKLKzSrI76NZu52Dm/EPS9wdMwMlLRRey6J9GC8UIoU4lX7Zb4TtmFwwbTF/yjTUGhifuPepJH9uCEOanXvTkyvw/oqu9zJysy0rzayd+oWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtY4AfNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC04C4CEE7;
	Fri, 24 Oct 2025 01:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761270538;
	bh=L+mUYv0VX4crC/NG7fH+AStQQ5waEx1Ev/rWiY5RII8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KtY4AfNS3Pxd2NJjIkstrouWBR2QmQcW/KNnbz/dvNfs/xfD1BGBwRh25V7ZbWYY+
	 QwPwIEEMHJfIlwR7g47a7KQiJN3zVIOfUGjJQLGRVb2bNoxsPpwRH3UW7Mx4HjRheI
	 80Z8yWB8/IIggPsN2w7SKYSoyQ4P4z4oaYLxXnMH6Anm44G9idG7Ft6Z+uXttswc5s
	 CAWg0GlMu58RnVWPzPyN78CRvzjgZkDnA2OQFSKxe/g9Zquky/gmY/N9KbPF7PyQuB
	 KJ2/UTIgTrw9ULNtM5eJWiWuOhSyUXlfyaiso2Rn/4YJ8IgM5TufeOSH4y1RDtLiHI
	 j9/K6zMw4UOXw==
Date: Thu, 23 Oct 2025 18:48:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, dsahern@kernel.org,
 petrm@nvidia.com, willemb@google.com, daniel@iogearbox.net, fw@strlen.de,
 ishaangandhi@gmail.com, rbonica@juniper.net, tom@herbertland.com
Subject: Re: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Message-ID: <20251023184857.1c8c94f1@kernel.org>
In-Reply-To: <20251022173843.3df955a4@kernel.org>
References: <20251022065349.434123-1-idosch@nvidia.com>
	<20251022062635.007f508b@kernel.org>
	<aPjjFeSFT0hlItHf@shredder>
	<20251022081004.72b6d3cc@kernel.org>
	<aPj5u_jSFPc5xOfg@shredder>
	<20251022173843.3df955a4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 17:38:43 -0700 Jakub Kicinski wrote:
> On Wed, 22 Oct 2025 18:35:23 +0300 Ido Schimmel wrote:
> > I will change the test to require at least version 2.1.5. Can you please
> > update traceroute in the CI and see if it helps?  
> 
> Will do but I'm a little behind on everything, so it may be tomorrow 
> or even Friday. So ignore NIPA for now, worse case we'll follow up.

Updated now, next run should have it updated.
Current one has traceroute updated but not traceroute6
https://netdev-3.bots.linux.dev/vmksft-net/results/354402/27-traceroute-sh/stdout

This doesn't sound related to the traceroute version tho:

# 34.51 [+6.48] TEST: IPv4 traceroute with ICMP extensions                          [FAIL]
# 34.51 [+0.00] Unsupported sysctl value was not rejected

