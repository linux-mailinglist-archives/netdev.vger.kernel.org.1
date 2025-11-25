Return-Path: <netdev+bounces-241551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD63C85B93
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5973A2D96
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55092327C1A;
	Tue, 25 Nov 2025 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9blSrgO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299CA327C12
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083754; cv=none; b=GcEYcYYs71AfiDSH09oe9oJvQ697ABi3KotjK4/Lx7qrJsnTsL4RjlqbcwX1DqHE24mQmuocn3A4+mE08FIXuqN7rKXttcbc0YUp816SRmPhN31f/qmPrNcdpa5LttUC7O2NWcDdyt80xN35ZcNHCUvCuTP/OqYZKZWEZrX3EeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083754; c=relaxed/simple;
	bh=K1JjRo2hUFdAtHdoVAFMajKI3GQegMhwkD77uUmVv4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W25IX4g7gIMCfts1lLB+rO/KROf1EZaNWiB6UYVwa49AGTOCKjDKBbAKfaxSzYeAhpqRShJwiifKp6G9iQitIWkEPpxj9idB2JFncR5TkGMTWkYrEc8GiZQpfeyThvjvNZty586U7lommrOViu1KWdN4TpvWLF0CKTlDSgqBeGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9blSrgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61693C4CEF1;
	Tue, 25 Nov 2025 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764083753;
	bh=K1JjRo2hUFdAtHdoVAFMajKI3GQegMhwkD77uUmVv4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9blSrgODs4qwEbSPPxIv19bQS7XBvQyWD3llvzhJqj82krfTfD7M3nQSy2s/alK5
	 O5gyETyaVSoh6FC3TcmeUlmmKuQDCpbgfJ08VIFvmaDKgv1LzTNRjp0cUP6gLiFpWD
	 LhKuSMM/MfzzbikDhTqUdvqNfO5vqDbikEq/SN72oumXDzhzHX43AgP/Lrsdabcttl
	 1ChFuF5t+hnerdeF2i5KCDvfJlziP63xP2sljZoSIV/lhRhRavJeUjY7e3TIpSX1tQ
	 r5kdJGmVFukNbEnbdADnqNyyJ62HfRc+Fb9yQdLmF75nZnkVukzndRQvRqkbiiRqyz
	 Q7hgxkOtWLU5w==
Date: Tue, 25 Nov 2025 15:15:49 +0000
From: Simon Horman <horms@kernel.org>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: netdev@vger.kernel.org, Byungho An <bh74.an@samsung.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Girish K S <ks.giri@samsung.com>,
	Siva Reddy <siva.kallam@samsung.com>,
	Vipul Pandya <vipul.pandya@samsung.com>
Subject: Re: [PATCH net] net: sxgbe: fix potential NULL dereference in
 sxgbe_rx()
Message-ID: <aSXIJZ3EztBeCfPg@horms.kernel.org>
References: <20251121123834.97748-1-aleksei.kodanev@bell-sw.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121123834.97748-1-aleksei.kodanev@bell-sw.com>

On Fri, Nov 21, 2025 at 12:38:34PM +0000, Alexey Kodanev wrote:
> Currently, when skb is null, the driver prints an error and then
> dereferences skb on the next line.
> 
> To fix this, let's add a 'break' after the error message to switch
> to sxgbe_rx_refill(), which is similar to the approach taken by the
> other drivers in this particular case, e.g. calxeda with xgmac_rx().
> 
> Found during a code review.
> 
> Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

Thanks Alexey,

I think this is a case where it is hard to know the true effects
without running the system. But I'm assuming that we aren't in
a position to do so. So instead we need to try to reason at
the code level.

From that perspective I do see that:
1. Without this change there will be a NULL pointer dereference *boob*
2. It seems that the refill logic should work with the proposed solution

So, I do expect this helps.
And I do think it can be accepted without hw testing.
But I do have a lower confidence level than I would if there
was hw testing.

Reviewed-by: Simon Horman <horms@kernel.org>

