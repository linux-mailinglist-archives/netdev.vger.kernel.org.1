Return-Path: <netdev+bounces-149896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ABB9E807B
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 16:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2F018842C3
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1247014883C;
	Sat,  7 Dec 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wAmlYxcL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687F22C6C5
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733585924; cv=none; b=Fpx5X5+wapIPDhNvhzV76u5kfHMg6/jlJFPPoYlwlqz0rI9U0OxKwejhJdtLDIJx1MIS0LyK57dJivzBJ7x5bzS1A38RdGKSCeNwP+Kaxsc6MCwkF7UMOqjAeKGWlzrXRC6t2S9fiZYhB6UHAID6sG6nnGDQR1IuJbRGDS10tkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733585924; c=relaxed/simple;
	bh=kxG80h4cz5ibfuSFWnqaivhfFJtaxL7RYBli6MQODz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=likcw53je7xxLuyv5UdMZNzlnLgianvWtfASjNIZC5G6XGIJ7bhO1geH2CslQRhn/V3vBPP5Lns1Ma5VF4YRIqixNIjINBZZ8j8Cp19coYqbIhwZk5miwO1izjI5s+i4PYCcl9kGEVpzUgHuFiM98Keh2JPAv38MDomzYCpRt38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wAmlYxcL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MYeiLoHGaphpC65gAxoHt3cIJrRLQXtNPwV0ho6+G2M=; b=wAmlYxcLE4qdFAzEvBXLqRKbzN
	zVnxti2vf7OEI8SjcR1HtX0LIEeQuIY05YCCbvBHHGs8DI0PqhaRjnwOY5ie9e2fRsGgO4HqIGbDe
	jYaYCG//mXFInMhNiRZ4c7BfVNebGymlDDPWpwjgK8+MjrUDJquW24pPm+hosU4mdb9U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tJwsy-00FUcp-Em; Sat, 07 Dec 2024 16:38:24 +0100
Date: Sat, 7 Dec 2024 16:38:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH net 2/4] net: dsa: mv88e6xxx: Give chips more time to
 activate their PPUs
Message-ID: <9ba73b5b-1b76-48b2-9b37-fd8246ef577a@lunn.ch>
References: <20241206130824.3784213-1-tobias@waldekranz.com>
 <20241206130824.3784213-3-tobias@waldekranz.com>
 <518b8e8c-aa84-4e8e-9780-a672915443e7@lunn.ch>
 <87ldwt7wxe.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldwt7wxe.fsf@waldekranz.com>

On Fri, Dec 06, 2024 at 02:39:25PM +0100, Tobias Waldekranz wrote:
> On fre, dec 06, 2024 at 14:18, Andrew Lunn <andrew@lunn.ch> wrote:
> > On Fri, Dec 06, 2024 at 02:07:34PM +0100, Tobias Waldekranz wrote:
> >> In a daisy-chain of three 6393X devices, delays of up to 750ms are
> >> sometimes observed before completion of PPU initialization (Global 1,
> >> register 0, bit 15) is signaled. Therefore, allow chips more time
> >> before giving up.
> >>  static int mv88e6352_g1_wait_ppu_polling(struct mv88e6xxx_chip *chip)
> >>  {
> >>  	int bit = __bf_shf(MV88E6352_G1_STS_PPU_STATE);
> >> +	int err, i;
> >>  
> >> -	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
> >> +	for (i = 0; i < 20; i++) {
> >> +		err = _mv88e6xxx_wait_bit(chip, chip->info->global1_addr,
> >> +					  MV88E6XXX_G1_STS, bit, 1, NULL);
> >> +		if (err != -ETIMEDOUT)
> >> +			break;
> >> +	}
> >
> > The commit message does not indicate why it is necessary to swap to
> > _mv88e6xxx_wait_bit().
> 
> It is not strictly necessary, I just wanted to avoid flooding the logs
> with spurious timeout errors. Do you want me to update the message?

Ah, the previous patch.

I wounder if the simpler fix is just to increase the timeout? I don't
think we have any code specifically wanting a timeout, so changing the
timeout should have no real effect.

	Andrew

