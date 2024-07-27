Return-Path: <netdev+bounces-113377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F293E01B
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 18:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40571F21B79
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A6186298;
	Sat, 27 Jul 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwT6opiG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B21EA8D;
	Sat, 27 Jul 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722097032; cv=none; b=Ylqosb+2Khq/oURQvlhb/U9ozIq3QPUIYLn+pU9nhn9VL6ZuF+Z1DlkaTgWMFVeaPHZDYHwdHApYZ2sHHlCDgbVfe8vRKtfG7zaAOf0adPiVPP0l0zm1MQgQfzbJHgSC9/YKzav0fXgeFKK3DdesHCoktj1Y8CG08rVAhx+TKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722097032; c=relaxed/simple;
	bh=NqSY7cGWR/o4o8BKGRxfjXQ4+UBje56OMKrK4V/+nas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWtHvJe9vr3jwauf8lVPcvoHuJEmHv8gOnHJn2wXKjOpjlcrH2mZhBG797WOuBf9pHEteDgkXX0SNgVJXYh4mLbw/3Yq8VayWBzWWBqmS4WC/J1KJTHgNMkp2ZxXGwFbT2zL37Oe2768nrndDUKLWrpZVhh++E35W+YMxyAGW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwT6opiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20790C4AF0A;
	Sat, 27 Jul 2024 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722097032;
	bh=NqSY7cGWR/o4o8BKGRxfjXQ4+UBje56OMKrK4V/+nas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwT6opiGoFfluZ/7HmqzfFkjSVKigc0vkxyTd0MHd29e8BrnWOCCkEn3ceyPDz6Y0
	 rJo/n86DRnaDA0VYNumwPCF8agRoWyflP9dPutQFSOkiUM6KuDFqkWIiurtLFjy1kg
	 gWCIeG28HIPUXIiRoYg2H+bFmBQxevSH32hPjIt8/cU3PCdYdXXaz3OdrRMnwdG+k1
	 HMic4JI2oZOGK2gu/TzRn/4t5Ukfvlfi1MGbasiGjeV+EnZcGiTSHXx184XDHcwuuN
	 3gbi1eT4YJMCJrWnD+C5gtroCiZh02mrQP3qNrDKjdsJ89RW4PYWewIoo6ipTltvK0
	 H+iHjwhG+uZdg==
Date: Sat, 27 Jul 2024 17:17:03 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: David.Laight@aculab.com, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: Use clamp() in htcp_alpha_update()
Message-ID: <20240727161703.GA1625564@kernel.org>
References: <22c2e12d7a09202cc31a729fd29c0f2095ea34b7.1722083270.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22c2e12d7a09202cc31a729fd29c0f2095ea34b7.1722083270.git.christophe.jaillet@wanadoo.fr>

On Sat, Jul 27, 2024 at 02:30:45PM +0200, Christophe JAILLET wrote:
> Using clamp instead of min(max()) is easier to read and it matches even
> better the comment just above it.
> 
> It also reduces the size of the preprocessed files by ~ 36 ko.
> (see [1] for a discussion about it)
> 
> $ ls -l net/ipv4/tcp_htcp*.i
>  5871593 27 juil. 10:19 net/ipv4/tcp_htcp.old.i
>  5835319 27 juil. 10:21 net/ipv4/tcp_htcp.new.i
> 
> [1]: https://lore.kernel.org/all/23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

## Form letter - net-next-closed

(Adapted from text by Jakub)

The merge window for v6.11 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after 28th July.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

