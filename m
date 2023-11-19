Return-Path: <netdev+bounces-49053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E217F0861
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 19:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE586280CE2
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87212111B8;
	Sun, 19 Nov 2023 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMq9Cyu1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C486179A7
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 18:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FFAC433C8;
	Sun, 19 Nov 2023 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700420021;
	bh=PQkiYSwgy2Ik9bE+xTktdc1gARfnvhW7W1Xi1ky8tb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMq9Cyu1Ee7cGFPHY7IzkKTxOjkiDfQTi73UxKkAMFK2kQeDvQCU49qzo/Gp/nOFH
	 ijnHjs/GWIg7OblZnmQWloN/DbrucdPjy/3uimg8UZg6UoJ1tUd6CjRj23CGfXcAXG
	 psso0EhMA3Bm6x48HHE9pHnrDsVnJVRCD7OaJEKn8aTFgHn5OEXD+Km7G4R6N+qiQY
	 lFZmsWGvyW4oSTZ1pXcJKlY4xcF0H4sVcY20qZ8hwNwJ5NNt+OQwHzjatglwykBNUj
	 oRe7NgHdedgFMvj+Bg3edvfPBdypr0bJQPsHd85zBHxGZoR7Aq2FuKpkkoK4QKiLcq
	 fxTrPhXAkL7kQ==
Date: Sun, 19 Nov 2023 18:53:37 +0000
From: Simon Horman <horms@kernel.org>
To: Ryosuke Saito <ryosuke.saito@linaro.org>
Cc: jaswinder.singh@linaro.org, ilias.apalodimas@linaro.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, masahisa.kojima@linaro.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netsec: replace cpu_relax() with timeout handling
 for register checks
Message-ID: <20231119185337.GE186930@vergenet.net>
References: <20231117081002.60107-1-ryosuke.saito@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117081002.60107-1-ryosuke.saito@linaro.org>

On Fri, Nov 17, 2023 at 05:10:02PM +0900, Ryosuke Saito wrote:
> The cpu_relax() loops have the potential to hang if the specified
> register bits are not met on condition. The patch replaces it with
> usleep_range() and netsec_wait_while_busy() which includes timeout
> logic.
> 
> Additionally, if the error condition is met during interrupting DMA
> transfer, there's no recovery mechanism available. In that case, any
> frames being sent or received will be discarded, which leads to
> potential frame loss as indicated in the comments.
> 
> Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
> ---
>  drivers/net/ethernet/socionext/netsec.c | 35 ++++++++++++++++---------
>  1 file changed, 23 insertions(+), 12 deletions(-)

...

> @@ -1476,9 +1483,13 @@ static int netsec_reset_hardware(struct netsec_priv *priv,
>  	netsec_write(priv, NETSEC_REG_DMA_MH_CTRL, MH_CTRL__MODE_TRANS);
>  	netsec_write(priv, NETSEC_REG_PKT_CTRL, value);
>  
> -	while ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
> -		NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0)
> -		cpu_relax();
> +	usleep_range(100000, 120000);
> +
> +	if ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
> +			 NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0) {
> +		dev_warn(priv->dev,
> +			 "%s: trans comp timeout.\n", __func__);
> +	}

Hi Saito-san,

could you add some colour to how the new code satisfies the
requirements of the hardware?  In particular, the use of
usleep_range(), and the values passed to it.

>  
>  	/* clear any pending EMPTY/ERR irq status */
>  	netsec_write(priv, NETSEC_REG_NRM_TX_STATUS, ~0);
> -- 
> 2.34.1
> 

