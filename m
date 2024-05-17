Return-Path: <netdev+bounces-97024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931AE8C8CC2
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 21:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47A01C210E8
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 19:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2083613FD94;
	Fri, 17 May 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on9tiZWH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A413FD83;
	Fri, 17 May 2024 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973840; cv=none; b=s0U4paFSgtFiwMdvWanWR/pNzJSDxuNkiFmMTAcVglgsPZHqqtI+LxBYC6aQTBYIiWe6QcIoMagaTJTwVD80B3LvI/fts2TKTu4LFDKE1LUBExlOidcYfM6NDDBkJk1pm/boHvXE8q0BOZa8txpWt3ke5qqKbfFVhQgYaUud56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973840; c=relaxed/simple;
	bh=+YaIyH/rzSTxIu7TV2GIrivyhTVp89FNH+Tksr+GA38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC5HHWbHvbABalZx5qZ4GKPkMk/GpUkIsB6oC/1vFQyvwoe6aBv0/QiDlwB9B+5w7lcr205f/WJeEAvO8kyuDDMg0K+MJV0dwTxllWvxrbjjYv9uzB2sk9HShJ0VEzS+L7eWnqQVb8Kaldcu4fdA3XxY3n3iRYVniwud4oYYKLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on9tiZWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B37C2BD10;
	Fri, 17 May 2024 19:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715973839;
	bh=+YaIyH/rzSTxIu7TV2GIrivyhTVp89FNH+Tksr+GA38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=on9tiZWHjsFwno2GElOcLOmnbPZjEa2QPlpGYug07Akpm2k+zYnYUMAlb2CiOl1ui
	 EMkB3Lxy1E4AAV0vtd6tjHIW+hCs2RqUQykEocqVnCOIlaKRNmKSc6I4bu8C/DH1V4
	 oht1jEeHKC9LI6Pm5VRuVltcj5nzCHqi/bF6Lchewi574vE1t0u8hLiZjfn+VQRUXZ
	 GWWHKwBRZsYxVTMDRSw4v5CJ39fi84bhVrRp4ZVlrjdURwCzY2zHhxHqo5Z43O8PIA
	 2Rhs/ThkWG0SMAJKEMLhcfdWwttlUeZg2JSG+us4C+XbxLGGrYx7mvqVVLw8kihTqw
	 OrHOG72v5eU5w==
Date: Fri, 17 May 2024 20:23:54 +0100
From: Simon Horman <horms@kernel.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Lebrun <david.lebrun@uclouvain.be>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Subject: Re: [net] ipv6: sr: fix missing sk_buff release in seg6_input_core
Message-ID: <20240517192354.GB475595@kernel.org>
References: <20240517164541.17733-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517164541.17733-1-andrea.mayer@uniroma2.it>

On Fri, May 17, 2024 at 06:45:41PM +0200, Andrea Mayer wrote:
> The seg6_input() function is responsible for adding the SRH into a
> packet, delegating the operation to the seg6_input_core(). This function
> uses the skb_cow_head() to ensure that there is sufficient headroom in
> the sk_buff for accommodating the link-layer header.
> In the event that the skb_cow_header() function fails, the
> seg6_input_core() catches the error but it does not release the sk_buff,
> which will result in a memory leak.
> 
> This issue was introduced in commit af3b5158b89d ("ipv6: sr: fix BUG due
> to headroom too small after SRH push") and persists even after commit
> 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane"),
> where the entire seg6_input() code was refactored to deal with netfilter
> hooks.
> 
> The proposed patch addresses the identified memory leak by requiring the
> seg6_input_core() function to release the sk_buff in the event that
> skb_cow_head() fails.
> 
> Fixes: af3b5158b89d ("ipv6: sr: fix BUG due to headroom too small after SRH push")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Reviewed-by: Simon Horman <horms@kernel.org>


