Return-Path: <netdev+bounces-173883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C24BCA5C189
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED22164D12
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FE0241682;
	Tue, 11 Mar 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n2YIAZm0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C417224244
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696885; cv=none; b=H9OmkSezATVyoquWOsSa7kMbAvZ/G8r3LZqknElgC7UAz0lMff+936ehW9oXUMGYtuyG9HlhW9bp8e8xVu4C7iv2LARmoo/ExbMyWV9wdu0+W1CThtDzPRFkacYM0mHEewRfsXcptH/WU3ysIuQ/p0+XN34+RNZ7sDBqlFLVVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696885; c=relaxed/simple;
	bh=kzNL7/sWPm4xJ7Yg50W9iGwX7NcAmjRwn86H4JADAko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Annnl84k620tbkFmnWwIWhAc/Ue6lpmPy65Q6H4V7ypKZZo/pmlonPzDhuufvQzOyleBuPnPhfpfDC3MzwLoQDBIUds3HmYQjyEqK8YDPpIFdkStKRbcM8Ntj0IJVu0T2Pe1pbCxpus6c5m+hSImkufsbiyMBWOvVkm+VtKgFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n2YIAZm0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eK+uaxL1EO5NoIRU6WfNZp5osnmxjXhTl3BO6u2xOKI=; b=n2YIAZm0PpplayVVoSjdbYa3VY
	Wwb2a0zaBWlPOwZxD9dSBCkU2L1d7qlAc084trTfkd4tWMkGxcyJt4D4bg6mXxcukVYa/dxoWRMbh
	1HH5lNRJdmuM6IVd7PNQVsU490/xrQnXXpfIDtMnS0bb1EMHxxqwcKagWd/1VqvHRqw8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tryv2-004L32-1Z; Tue, 11 Mar 2025 13:41:12 +0100
Date: Tue, 11 Mar 2025 13:41:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: b53: use genphy_c45_eee_is_active
 directly, instead of phy_init_eee
Message-ID: <ec50da60-dde3-45ca-aa6c-eebf59fc5ec5@lunn.ch>
References: <1c1a5c49-8c9c-42a7-b087-4a84d3585e0d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1a5c49-8c9c-42a7-b087-4a84d3585e0d@gmail.com>

On Tue, Mar 11, 2025 at 07:39:33AM +0100, Heiner Kallweit wrote:
> Use genphy_c45_eee_is_active directly instead of phy_init_eee,
> this prepares for removing phy_init_eee. With the second
> argument being Null, phy_init_eee doesn't initialize anything.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/dsa/b53/b53_common.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 61d164ffb..17e3ead16 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -2212,10 +2212,7 @@ EXPORT_SYMBOL(b53_mirror_del);
>   */
>  int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy)
>  {
> -	int ret;
> -
> -	ret = phy_init_eee(phy, false);
> -	if (ret)
> +	if (!phy->drv || genphy_c45_eee_is_active(phy, NULL) <= 0)
>  		return 0;

genphy_c45_eee_is_active() is a function which could be considered
phylib internal. At least, it currently has no users outside of the
phylib core.

b53 uses phylink not phylib, so i actually think it would be better to
convert it to the phylink way to do EEE, rather than make use of a
phylib helper.

	Andrew

	

