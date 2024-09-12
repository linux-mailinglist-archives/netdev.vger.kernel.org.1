Return-Path: <netdev+bounces-127782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BAB9766D5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A700E28256D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16B19F132;
	Thu, 12 Sep 2024 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgK8D1mp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BDB1E51D;
	Thu, 12 Sep 2024 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137756; cv=none; b=afUN8MyYWXzj0jr8n25oiu4YXQr1G4K/n/kkVZe9Y1ioZ25NKJ+2q0QaAmkiFaVWYP1+koh890lm1/FjMZgznCccUeWYmOngkOGYPn5GB0jX6IoBTelAbm8l3SI04exY7opNsL8dEN4PJ5CEX7+chMXkJH8AxWDNkhv/9B0zF78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137756; c=relaxed/simple;
	bh=5njcJQR9Y+tMWWeZYHF7muYUSlgVAPJ6qhbVsCrmMY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQpl3j/mLf2lnSeS0GcWwpjT8zemMQAkkSw6F2dzpJd0gEG7xsew9NuQEahRbUtQNK02MDxmW1+2Gn8YbtVJuV6/NNBx2p07S6LFzsw4wZGyQ6UnF3ZhD8i9o8qxMC/LhqeD5jTUYS49UH0n0vrYqkSXrVbYB0VhEYlbhFHAHdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgK8D1mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE3AC4CEC3;
	Thu, 12 Sep 2024 10:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726137756;
	bh=5njcJQR9Y+tMWWeZYHF7muYUSlgVAPJ6qhbVsCrmMY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pgK8D1mpI5egVmKnM6DdtD9uD4UkNCK3LuEcwrHcKa63OZs3rCfdCH3t6VDEkvgPU
	 7E7REgOStliB2JpBC8/JlzEC5K14f2ofgkoDs9vAcCHLHcsBEjOeq4ZnJs5yZ68Nhn
	 jvc/O/G+ae5EtgkCY2CELdpkQg5ueMNqjs1fQ1jSkOTcXyC/UPYNXHowdSVz/ebSoF
	 7efnOBnELeuUKoSRTYu+p+F01BK8GATNbGcrEzWPpxdLZJ08oxuUgH/Zyvu+ogDMFF
	 /I7dqNTxdtBoNYXVQF0GdFoQb1d1xGKy9g8qdSwPp+W52EbNqb4GoPDNEAzBuay4lz
	 wbmmEV2vRR60g==
Date: Thu, 12 Sep 2024 11:42:31 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, aahringo@redhat.com,
	alex.aring@gmail.com
Subject: Re: [PATCH net] net: ipv6: rpl_iptunnel: Fix memory leak in rpl_input
Message-ID: <20240912104231.GH572255@kernel.org>
References: <20240911174557.11536-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911174557.11536-1-justin.iurman@uliege.be>

On Wed, Sep 11, 2024 at 07:45:57PM +0200, Justin Iurman wrote:
> Free the skb before returning from rpl_input when skb_cow_head() fails.
> Use a "drop" label and goto instructions.
> 
> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>

Reviewed-by: Simon Horman <horms@kernel.org>

...

