Return-Path: <netdev+bounces-204690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EF9AFBC3E
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 22:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119087A21C4
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDC626A1C7;
	Mon,  7 Jul 2025 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTB3dSbj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3C21CC5B;
	Mon,  7 Jul 2025 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918508; cv=none; b=Xg7O5IBixQW6FB+5CdH3fU/IDqUr5JMYD+79lGFsciF4u/iEdQ67Stqnpt0dZHRxWWo34XfIW7ihse1PktXS8T7eOP5fDZDpAbfpNZSZ0efTQk+VxQ2q6yBiFGTAUMMqm1eTup5HLveugeRVZLkR3vLPZUNW77sITz1yXIDHAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918508; c=relaxed/simple;
	bh=/Npu1SJ5EGsg4b9sZc8UEv+pMeJPLKZBxue3kulMFbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFWvGTvWdRP41HaLvgBy3ASfOuMnbrsIs9WPobmU7GQBFXWwSYsztm5C3XOa5O+0hg5/GlkdEd35EcNU+sWhU0nJ2XTZYu2pXra+uReuE2DrGXE36Ti534vuohjSzpTTmMeAEyCiUpa9XrOarErm2Pz1Z2GF2VQbmS6adC5aMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTB3dSbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA8BC4CEEF;
	Mon,  7 Jul 2025 20:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751918507;
	bh=/Npu1SJ5EGsg4b9sZc8UEv+pMeJPLKZBxue3kulMFbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTB3dSbjdcxPvCqYgHzGxx0c+0R171UlQ4cG/QjGvsQQOvmCzGv8ghMpBwve+iZrg
	 0U+YoyH57lpHef6d2B4M4UHhj0yyTY024DMoeCLAHjTHLnNHM+AIY7ShALrtbonYiA
	 LhYJue8HJZMCLR7d2ow6Kv8ZhdAfxPxkjOzehHSw/og1+RQzjkIGQYU9wd9LyTNRaD
	 bS+1NnQ1+tTJxzQl7RC5GXto29KntmpnocUoHQ4g9Kp8kkBHBpkVpD38hG81vYnYmh
	 CMpTn2K79Nduc7iHV6DW5tUavW1jk0B31hQS04SzrijJuMWgQqGcdnti2WiYJwJiZ5
	 Emo+bSjjPRAKg==
Date: Mon, 7 Jul 2025 21:01:43 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Mark Einon <mark.einon@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ethernet: et131x:  Add missing check after DMA map
Message-ID: <20250707200143.GD452973@horms.kernel.org>
References: <20250707090955.69915-1-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707090955.69915-1-fourier.thomas@gmail.com>

On Mon, Jul 07, 2025 at 11:09:49AM +0200, Thomas Fourier wrote:
> The DMA map functions can fail and should be tested for errors.
> If the mapping fails, unmap and return an error.
> 
> Fixes: 38df6492eb51 ("et131x: Add PCIe gigabit ethernet driver et131x to drivers/net")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

nits:

1) There are two spaces after "et131x:" in the subject.
   One is enough.

2) I think you can drop "ethernet: " from the subject.
   "et131x: " seems to be an appropriate prefix based on git history.

...

> @@ -2578,6 +2593,28 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
>  		       &adapter->regs->global.watchdog_timer);
>  	}
>  	return 0;
> +
> +unmap_out:
> +	// Unmap everything from i-1 to 1
> +	while (--i) {
> +		frag--;
> +		dma_addr = desc[frag].addr_lo;
> +		dma_addr |= (u64)desc[frag].addr_hi << 32;
> +		dma_unmap_page(&adapter->pdev->dev, dma_addr,
> +			       desc[frag].len_vlan, DMA_TO_DEVICE);
> +	}

I'm probably missing something obvious. But it seems to me that frag is
incremented iff a mapping is successful. So I think only the loop below is
needed.

> +
> +unmap_first_out:
> +	// unmap header
> +	while (frag--) {
> +		frag--;

I don't think you want to decrement frag twice here.

> +		dma_addr = desc[frag].addr_lo;
> +		dma_addr |= (u64)desc[frag].addr_hi << 32;
> +		dma_unmap_single(&adapter->pdev->dev, dma_addr,
> +				 desc[frag].len_vlan, DMA_TO_DEVICE);
> +	}
> +
> +	return -ENOMEM;
>  }
>  
>  static int send_packet(struct sk_buff *skb, struct et131x_adapter *adapter)

-- 
pw-bot: changes-requested

