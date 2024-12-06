Return-Path: <netdev+bounces-149727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E24F9E6F32
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2737162418
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A661E1C11;
	Fri,  6 Dec 2024 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H7S9/Go2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AA20011B
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491099; cv=none; b=Sw182FVBwGQj2i6R6omjDn42Xc/mnrO/rgwRM5FmZnHd1rShdZLbO6n+Qki24XmqMaTk/9BN1e8PSKuHUMowoLMHSm5Uhw8s4rV5UQGKTKgBnSDe1aQ60ZWD/HTnZxiL4LoKZPZLTwCEgD1QLQLi4QHNiv4evi5PHUJLqlbi8DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491099; c=relaxed/simple;
	bh=eiIyDZh3cPmqeBcYcTmf/ipj2jIzFlnwpMTu84w2Mk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gi2ga/KzXhur1QWZ54Cuw7hY7bxRvli6rsR0F9XMpPLSJN7EmMfqC2bh/KJbkgzX3Jwuc/pKtQ150hgx9VxqxbgE5LOU27191xQoByy4aduN/5EAX2fXxUEeroCT69DO0xr+E/Jw1FmwOJaApP7Mt/xTGj3RVf8Teu6dDdF2NC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H7S9/Go2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C2ihFaq0Vddo34M5cin5+JCARag1JsJIqmcyTbMXBGI=; b=H7S9/Go2uvqqf4IPBRwdYbsXw0
	xgbYmIDY1N8epJXIG73/g3WT2OcMuXVcSlt8KPlxLBtxZ1ABOTEB9zYaMe/3kJnCXXaDK2xFN8NMJ
	BfhY1lr986rWL8ZJpTaA3O8RoyaNFdJ8JTuOOtQymvjGjqTz8UKMDB9R5oXFtzTcFQiQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tJYDc-00FPpO-SD; Fri, 06 Dec 2024 14:18:04 +0100
Date: Fri, 6 Dec 2024 14:18:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH net 2/4] net: dsa: mv88e6xxx: Give chips more time to
 activate their PPUs
Message-ID: <518b8e8c-aa84-4e8e-9780-a672915443e7@lunn.ch>
References: <20241206130824.3784213-1-tobias@waldekranz.com>
 <20241206130824.3784213-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206130824.3784213-3-tobias@waldekranz.com>

On Fri, Dec 06, 2024 at 02:07:34PM +0100, Tobias Waldekranz wrote:
> In a daisy-chain of three 6393X devices, delays of up to 750ms are
> sometimes observed before completion of PPU initialization (Global 1,
> register 0, bit 15) is signaled. Therefore, allow chips more time
> before giving up.
>  static int mv88e6352_g1_wait_ppu_polling(struct mv88e6xxx_chip *chip)
>  {
>  	int bit = __bf_shf(MV88E6352_G1_STS_PPU_STATE);
> +	int err, i;
>  
> -	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
> +	for (i = 0; i < 20; i++) {
> +		err = _mv88e6xxx_wait_bit(chip, chip->info->global1_addr,
> +					  MV88E6XXX_G1_STS, bit, 1, NULL);
> +		if (err != -ETIMEDOUT)
> +			break;
> +	}

The commit message does not indicate why it is necessary to swap to
_mv88e6xxx_wait_bit().

> +
> +	if (err) {
> +		dev_err(chip->dev, "PPU did not come online: %d\n", err);
> +		return err;
> +	}
> +
> +	if (i)
> +		dev_warn(chip->dev,
> +			 "PPU was slow to come online, retried %d times\n", i);

dev_dbg()? Does the user care if it took longer than one loop
iteration?

	Andrew

