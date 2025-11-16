Return-Path: <netdev+bounces-238944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58612C61858
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C459634F9C6
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCDF21CC68;
	Sun, 16 Nov 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0WXg5ea7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844E1A9F9F
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763309837; cv=none; b=Sb6oOl3CeU5XLc9rAelfxVz9gRkkgeNsefcszc6tfBtwtQAaCNMq0l0Ygd9OQWGvTgK+w94nGzzZ8daLytGDduDgh64fDOc2rzxrUn0+W4iVqGNqeDUtfpz8dF+u7tGqqHs5Gg70b2AAivNEsNib9D80MG9jJwEJso4NKlGEOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763309837; c=relaxed/simple;
	bh=r09+Xs2XvTSqr3vhQeYTTTMz+PG+sFMyElYZNXzqUic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5hm8fSUpd/UqIBjiIEbGGurnjQlWov7bwkBy0Jlo7SmZMUuGQutbm88HdTxRRYckOUwyUJ76uB2D2pgvsDCs4H890DOMhtUDVUzijImNZZ7dwakADA7hIl8XAxHip9U0z6c1i57F/aNzHEugWdyUuIseSkT6Li4Eg2ubbCauGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0WXg5ea7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=2ebcCjLENDn+eLXQ1g2raHnfKaHqapkNaBAJisNh9dE=; b=0W
	Xg5ea7rG+XVC7jhgqeED9TWxQqzLZqutL0VDgAWL0M2MO3itdXhXBrWpg0L5lswyj8j/M+hIi3RPt
	e+J143pC+/dZzWAv14dzqMYPHVJHIc1zdn+qBf7ieBHzGPvb9KCyp5r69+673CCfSjcF/JBE9ff8i
	2NKKdSdcI5zhzFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKfRA-00E9qp-Ob; Sun, 16 Nov 2025 17:17:12 +0100
Date: Sun, 16 Nov 2025 17:17:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mietek N <namiltd@yahoo.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH] rtl8365mb: initialize ret in phy_ocp_read and return ret
 in phy_ocp_write
Message-ID: <924dbf67-9973-4f06-9945-05533df35cf4@lunn.ch>
References: <686180077.8704812.1763306985880.ref@mail.yahoo.com>
 <686180077.8704812.1763306985880@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <686180077.8704812.1763306985880@mail.yahoo.com>

On Sun, Nov 16, 2025 at 03:29:45PM +0000, Mietek N wrote:
> This patch fixes two issues in the RTL8365MB driver:
> 
>  - Initialize the 'ret' variable in rtl8365mb_phy_ocp_read() to 0 to avoid
>    using an uninitialized automatic variable on some execution paths.
>  - Propagate the return value from rtl8365mb_phy_ocp_write() by returning
>    'ret' instead of always returning 0, so write failures are not silently
>    ignored.
> 
> No other changes are made and the PHY OCP helper functions themselves
> remain functionally identical except for the corrected return behaviour.
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> 
> ---
>  drivers/net/dsa/realtek/rtl8365mb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff -ruN a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
> --- a/drivers/net/dsa/realtek/rtl8365mb.c    2025-10-12 22:42:36.000000000 +0200
> +++ b/drivers/net/dsa/realtek/rtl8365mb.c    2025-11-16 14:02:57.000000000 +0100
> @@ -690,7 +690,7 @@
>                    u32 ocp_addr, u16 *data)
>  {
>      u32 val;
> -    int ret;
> +    int ret = 0;
>  
>      rtl83xx_lock(priv);
>  


You diff is a bit odd, normally the name of the function is in the
header. But the commit message says this is rtl8365mb_phy_ocp_read()

static int rtl8365mb_phy_ocp_read(struct realtek_priv *priv, int phy,
				  u32 ocp_addr, u16 *data)
{
	u32 val;
	int ret;

	rtl83xx_lock(priv);

	ret = rtl8365mb_phy_poll_busy(priv);
	if (ret)
		goto out;

ret has been assigned a value, before the goto. So all execution paths
have a valid ret value.

Am i missing something?

    Andrew

---
pw-bot: cr

