Return-Path: <netdev+bounces-227732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D569EBB65B7
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 11:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9077B19C6150
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D8250C06;
	Fri,  3 Oct 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKOphzEt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857D18A6B0;
	Fri,  3 Oct 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483381; cv=none; b=WAJoJ5bPJYv2UHY6rejRY2JA7lh62e87xCMwPIh3etVJTIAPSyzVHZwUk+4V6oE86gpDEAcJEpuA4NFMVXCZQv3VoG0+s+zbrYW5prAjplg8uzks2YhunJspCzpLLwRWcBWRPF08osslyEg1+xmj/V+I8gHJiNKV7HBhWYCUat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483381; c=relaxed/simple;
	bh=gZlFWVR4yYekU834mJQpAfE/pKy24RTUeR8qbrDbZDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvCy/D+QQj4joRGL79u68+sE9qF+YY5Lr80sIDQLch57EC90f0kOSYd8J8qsQUY3RJpxS6fIyvTTN1NCerYR7/VHtB+i5sJ7AxV/jDfYipV+jpsJ0zqYQYR1UnVnuxG3JItUcRZ7HQiDB5KvwBRqVLAaowkjuonWsmj1UekwpjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKOphzEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1163C4CEF9;
	Fri,  3 Oct 2025 09:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759483381;
	bh=gZlFWVR4yYekU834mJQpAfE/pKy24RTUeR8qbrDbZDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKOphzEtVKQjUdhiK2e35HMlXBAacZxK0ccc+wNJdPAT4DZhGBcK0mxXpF17ti9nI
	 V/K0z5sClhu2RyDE4zU4MmGCGwgo5EMh5+RqQJfhC++3Ao2O7+lPOD5CNLzCIojXKi
	 Lp1PxyDtDkaOM2otSnRRcAlxK678tfsvrIZvu+KgveeCfFefXVlpVXyA3Ko7rZEH32
	 bQh+ENCw1PIqwOuo28wRVEJbEBcKUUTXuv9XMfW4XqNoVcJeMZ9+F8kLDkMxB/TVUS
	 JUGqjoEV62yThLUHhROuJ8midCth3DA+vLCWNuVSrIq3tL6wOaG+q+t7kyvrVlxkFd
	 A/SpfZDMjii2g==
Date: Fri, 3 Oct 2025 10:22:56 +0100
From: Simon Horman <horms@kernel.org>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	david.hunter.linux@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fsl_pq_mdio: Fix device node reference leak in
 fsl_pq_mdio_probe
Message-ID: <20251003092256.GB2971550@horms.kernel.org>
References: <20251002174617.960521-1-karanja99erick@gmail.com>
 <20251003073324.GA2878334@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003073324.GA2878334@horms.kernel.org>

On Fri, Oct 03, 2025 at 08:33:24AM +0100, Simon Horman wrote:
> On Thu, Oct 02, 2025 at 08:46:17PM +0300, Erick Karanja wrote:
> > Add missing of_node_put call to release device node tbi obtained
> > via for_each_child_of_node.
> > 
> > Fixes: afae5ad78b342 ("net/fsl_pq_mdio: streamline probing of MDIO nodes")
> 
> nit: no blank line here
> 
> Slightly more importantly, although the code you are changing
> was added by the cited commit, I think that the bug existed before then.
> I wonder if the fixes tag should be.
> 
> Fixes: daa26ea63c6f ("Merge branch 'octeontx2-fix-bitmap-leaks-in-pf-and-vf'")

Sorry the above is obviously bogus.
I should have said:

Fixes: 1577ecef7666 ("netdev: Merge UCC and gianfar MDIO bus drivers")

> 
> > 
> > Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> 
> One minor comment on process: as a fix for networking code, most likely this
> should be targeted at the net tree. And that should be denoted in the
> subject like this:
> 
> Subject: [PATCH net] ...
> 
> And if you do post an updated version, which is probably not strictly
> necessary, please be sure to observe the 24h rule.
> 
> See: https://docs.kernel.org/process/maintainer-netdev.html
> 
> The code changes themselves look good to me. Thanks.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...
> 

