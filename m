Return-Path: <netdev+bounces-158296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B256A11576
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD2F188AB95
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16825214201;
	Tue, 14 Jan 2025 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIX+Pyfh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C620CCC9;
	Tue, 14 Jan 2025 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897608; cv=none; b=RVyzKAdWnj2sAXalbONo5X7LWhAbKYzwBkXjm6L7VnKiVVMKMU1rFS1EhHpkuuMOfBUoOwiM4TyVlJQdjR7ugfghAdPFMxGKZFTRFsfgpkcGYXf6SQLEkXO61irqrgFQL+S/n16Qcp+xB0WXTY9xA96J7oUnvE9nxOu9hzGiS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897608; c=relaxed/simple;
	bh=X5Ab8rl/ZfcDU+B6erAbyO44V+L5S9IEQcTx/ySbb7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3CE3kqm9aafhHw6uzuk+hXTOo+S/tl2Hsa31HXj9OWBjj1lTj8l1vnGuvtlyftYUJKj+6xEIddim6vs2+8+EIAmg9ggRh4dfghpO9GkTeiNlY9y7PH0WBzMidlWMlsHLc6MZFh5S9ZXL+rwLEdk/m7aS2xVSSXW2/mhXROvoS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIX+Pyfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F86C4CEDD;
	Tue, 14 Jan 2025 23:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736897605;
	bh=X5Ab8rl/ZfcDU+B6erAbyO44V+L5S9IEQcTx/ySbb7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XIX+PyfhSFtenIE7nWye1MzLtmVbzVNdXg471YrFy60Hm0OUi73bqq5vfORfr2I+j
	 uUxm6GLPc4/zpChx0/5vqhjH5ZqCfVCr6dIQ8effQ43V0wEg4YSb1/0o6mLobInSzF
	 Ul/Qi8Y/lr4Q9DCAicCwZaQPgE9EXcByk6CUw5Wb2WlY3nUQoxNUaCWaSMILeJknXE
	 LgPeRHdq4zBhSqQ1TAL004oClxzOiOPczjEHhjA4jjggK2yDnele2dQ3Sx0ik0eiGF
	 ysQ3QwUTfsS+nTmpjn6I6hqnHfiiv8bcr3pYr15pLSYqTgdBkGvgTcCoqdk4hUCQDw
	 9WqcsEam7uBgg==
Date: Tue, 14 Jan 2025 15:33:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, Andrew
 Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v7 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
Message-ID: <20250114153323.527d4f63@kernel.org>
In-Reply-To: <20250113055434.3377508-4-a0987203069@gmail.com>
References: <20250113055434.3377508-1-a0987203069@gmail.com>
	<20250113055434.3377508-4-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 13:54:34 +0800 Joey Lu wrote:
> +	regmap_write(bsp_priv->regmap,
> +		     macid == 0 ? NVT_REG_SYS_GMAC0MISCR : NVT_REG_SYS_GMAC1MISCR, reg);

This is a pretty long line and you do it twice, so save the address 
to a temp variable, pls

> +MODULE_LICENSE("GPL v2");

checkpatch insists:

WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity") 
-- 
pw-bot: cr

