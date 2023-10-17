Return-Path: <netdev+bounces-41629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4182C7CB7C9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED491C209A9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582B15CC;
	Tue, 17 Oct 2023 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5Ejo6A7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ABE10E9
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F90C433C9;
	Tue, 17 Oct 2023 01:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697504931;
	bh=jHzMCQWvVZ1Q/xaW0hEOcnP75eSP2Fct28NmE+fM2ZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U5Ejo6A7IGivJxgjcnLAn/xvYjhejkxSLLUq+ISYOO4hgxkafLCn8H+gOyRFR9rsj
	 55vPcR9PbV8r/+Zd/WmCmair8sw52RzbAswebcAHVUJIkQRHIyUZOcvGFurw1NBwzP
	 2JAxU9Vqf17EOx2wBwDek3hce2tEDODuGGZqtoU66waHayDQsR6TDUCUeKDXsnqI/N
	 SOAkbqABIJJalva1wtuOOJmF47ALmc+tQa6XtvEjcfGLL1z9HVeA3XLCXs4iKQGyk0
	 wv2eH7UEqPfYDMNI2yZG5tvJdpuDjgey9j2Hyw3+P3kQ9uslM19cS17gS98qgKDfrq
	 JF+g184XSUXjQ==
Date: Mon, 16 Oct 2023 18:08:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Raju Rangoju <rajur@chelsio.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose
 Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>, Simon
 Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri
 Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/4] net: stmmac: move TX timer arm after
 DMA enable
Message-ID: <20231016180849.1cc29549@kernel.org>
In-Reply-To: <20231014092954.1850-4-ansuelsmth@gmail.com>
References: <20231014092954.1850-1-ansuelsmth@gmail.com>
	<20231014092954.1850-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Oct 2023 11:29:53 +0200 Christian Marangi wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 5124ee87286c..240a18b97825 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2545,7 +2545,8 @@ static void stmmac_bump_dma_threshold(struct stmmac_priv *priv, u32 chan)
>   * @queue: TX queue index
>   * Description: it reclaims the transmit resources after transmission completes.
>   */
> -static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
> +static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
> +			   bool *pending_packets)

Missing kdoc for new param, build with W=1 catches this.
-- 
pw-bot: cr

