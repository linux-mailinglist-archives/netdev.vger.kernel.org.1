Return-Path: <netdev+bounces-217273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB235B38231
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA62A7A7C0D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC043002B1;
	Wed, 27 Aug 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IUfIUhRn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC30212B0A;
	Wed, 27 Aug 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297494; cv=none; b=fnxSUBuR4qPkH57NSujxvqVwa6qXuM2KlCsP6LrEQUqWUw9eRD56wdo5qzMCibvOLjJYpD6xTO/OU/3sjFEGxdTo5sJroFUXsUH9ufRzcrBdo7rB4bUBnAYg8kN4y7SfUE/6eynZ+3h501JzNdmOdbPwAhMEKhzSM4vxZBzHbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297494; c=relaxed/simple;
	bh=8NniPrND75SaBIzAYSsuz2u5sg1tZ9zb+9wqlGl2oXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqETvwkjY4BxAbkf5RBIQF0WWJudi+0fJJkgAwLw46JVxTsIeB3HkomENNPo2Nkm2V9LtsBLVNmhi9Xpkotb3LrSauatYAwlfsfivD1bUS9x/M9MRmhOY5nHJ0BuVo1ucr6W5mc64inArOcYA8jyA46sOgIlm5eFcfbIZfSUzvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IUfIUhRn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ejVmM74OzePV7mL0FjyFL2LjC29/uRGlhWXi4HmATJw=; b=IUfIUhRnaG6P1yhkTJMhBYVGjp
	a6X0lyT8aPsQ52aev/uGynr3HgeE6ULUJ2wTnxvlp8IVNdSCG4mVnU8uQ2PLgjN1tSYdlKBgPCW18
	vI/QUR9MIVcmg/qPqqh36p8iHC6p93BsRVNMEOHeui12VCJ6wh2xkAzUpU+zdadSZ9vg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urFCi-006CwW-Og; Wed, 27 Aug 2025 14:24:40 +0200
Date: Wed, 27 Aug 2025 14:24:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: use us_to_ktime() where appropriate
Message-ID: <1ed10006-79e8-47c7-9920-e38343b2c987@lunn.ch>
References: <20250827020755.59665-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827020755.59665-1-zhao.xichao@vivo.com>

On Wed, Aug 27, 2025 at 10:07:55AM +0800, Xichao Zhao wrote:
> STMMAC_COAL_TIMER(x) is more suitable for using the us_to_ktime().
> This can make the code more concise and enhance readability.
> Therefore, replace ns_to_ktime() with us_to_ktime().
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f1abf4242cd2..dcbd180c1985 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -144,7 +144,7 @@ static void stmmac_init_fs(struct net_device *dev);
>  static void stmmac_exit_fs(struct net_device *dev);
>  #endif
>  
> -#define STMMAC_COAL_TIMER(x) (ns_to_ktime((x) * NSEC_PER_USEC))
> +#define STMMAC_COAL_TIMER(x) (us_to_ktime(x))

Now that the macro does nothing, please just use us_time_ktime()
inline and remove the macro.

Also:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


    Andrew

---
pw-bot: cr

