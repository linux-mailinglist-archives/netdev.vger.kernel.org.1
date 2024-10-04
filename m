Return-Path: <netdev+bounces-132010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB0990229
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116121F242E7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2E156C76;
	Fri,  4 Oct 2024 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM5K76zq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA111EB2E;
	Fri,  4 Oct 2024 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041859; cv=none; b=DFqdQMEkYddiAZMq5m5/pcYYpMbPpXvJ0lTo7OjsGgRqAr2s0YJ6n43tH9tPHORiaUGXGsjV8c8ASRaVl6OQX5zzQI42rZbbgQIXlMVhGXcGN19pe2KSWOqBSxWcsTm1t3Wsvu6ZXaf+e/4NHzUMlE0Wq2HrxkjBzyU0x69nA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041859; c=relaxed/simple;
	bh=rk740CcH2b030qs1gmhkNSFoyMfDASvIeoiLscAFh+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5ZA/4Y3iyDj6c5CL9VqiZTZ5zkNVJdoZQ26tUmyQDwPNONgQQLaaxsmjnGY/x0INnxQuD8nTxDHcEruRkpenNE9vlVk8RipXiwcE/D7/qqvoqphR2FoxpLMFc2HhKxXkOWWd4OAYAODk3HZRqRekL2flyqGNC+yt71L7lpk8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM5K76zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA29C4CEC6;
	Fri,  4 Oct 2024 11:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728041859;
	bh=rk740CcH2b030qs1gmhkNSFoyMfDASvIeoiLscAFh+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HM5K76zqjBvsXjjsqyi1So7XPf7ovHaCKZorvsUtyJu+zm5ll+KpKgtiwi9/k2FMJ
	 R/b9R31CTBlxV8/Q7pfI1Wm3Lk3TO5tuYvgrRw5bpGVQyAvbyt+gaUm9D/OkMmasDK
	 cdkxK1BO4RP+ns2bli9i/GDx6TQAIB/nZ7qwhjWMX6gLli1viK1MmwOGGYGEXQN13X
	 1yvzsrAymMOoKrOTeb3yB/NL5w3MX2RMewrJ53tHP2szfuLKtzKXzZdOu20VN4Bpzz
	 W/j0CJ6OHbBGH2lAzWX2W+A4Zqy1befXtj3wYT2VTvqlngYvCZxG1yRLObYxZOZKKT
	 XwGqQOE5p2Yvg==
Date: Fri, 4 Oct 2024 12:37:35 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lennart Franzen <lennart@lfdomain.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: Fix some error
 handling path in adin1110_read_fifo()
Message-ID: <20241004113735.GF1310185@kernel.org>
References: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>

On Thu, Oct 03, 2024 at 08:53:15PM +0200, Christophe JAILLET wrote:
> If 'frame_size' is too small or if 'round_len' is an error code, it is
> likely that an error code should be returned to the caller.
> 
> Actually, 'ret' is likely to be 0, so if one of these sanity checks fails,
> 'success' is returned.

Hi Christophe,

I think we can say "'ret' will be 0".
At least that is what my brief investigation tells me.

> 
> Return -EINVAL instead.

Please include some information on how this was found and tested.
e.g.

Found by inspection / Found using widget-ng.
Compile tested only.

> 
> Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative.
> If returning 0 is what was intended, then an explicit 0 would be better.

In my brief investigation I see that adin1110_read_fifo()
is only called by adin1110_read_frames(), like this:

	while (budget) {
		...

		ret = adin1110_read_fifo(port_priv);
		if (ret < 0)
			return;

		budget--;
	}

So the question becomes, should a failure in reading the fifo,
because of an invalid frame size, be treated as an error
and terminate reading frames.

Like you, I speculate the answer is yes.
But I think we need a bit more certainty to take this patch.

-- 
pw-bot: under-review

