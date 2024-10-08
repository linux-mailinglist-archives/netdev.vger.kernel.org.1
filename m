Return-Path: <netdev+bounces-133308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E6899593F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62211C21059
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC881C1AD4;
	Tue,  8 Oct 2024 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z73u6AO7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09C1791ED
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728422583; cv=none; b=D/rkQL6GkLMP+Pn/5unEclhcXZitkf2mzGUemi2958PU6fv0zvy5ke+INc/07w8M9du4IECfxtT6QLJKashuc2c7r+xTSJdG54sPI1RAZWOvL8HuzFzG2kTOpnF61B1gXpCLpIir/bNgYb4B7UucRaSsyK/vSIyw5JQoGOLaUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728422583; c=relaxed/simple;
	bh=b+nb8jhg8Bwp9P/k+ZqmrCMDrQPZuHm3fEc40YOrwb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSPWkeZb5JEjLZzzXO9NzBowlqHw0SqI20TQcCTD8ipfbKyyxaOT8vEJo6KeH0680fo0TbahXhiXiO8ooZc7VN5btrDXZgmn7ivA9L6l6zuMrwPLHDRmhDquAGZy4i74Owt3KDbWYIDtZkwxOKcBUNOd0O/BBLPWVhKIsU0Dw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z73u6AO7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mRSHcF/vAfmzlhniOtJY8Bmdumz9/1SoRC6qJcjHI5I=; b=Z73u6AO7iiKgJD2rfdhMRrjZW2
	YaZ0SHxkP+tSr2jm5922b/dyW5V+8ethd+ypLb3YojoQKayFpXrpP8SHQYgCbfSWwhb6IX8IP9Z9m
	N8yY63EzuCLIzJ8GOY6/Ou2iMe3Xy23oaE7ah6ffvLonSZuuI8tkIGzzOmPAmK8s7OqE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syHfX-009Pnz-RY; Tue, 08 Oct 2024 23:22:59 +0200
Date: Tue, 8 Oct 2024 23:22:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenghao Yang <me@shenghaoyang.info>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
	pavana.sharma@digi.com, ashkan.boldaji@digi.com, kabel@kernel.org
Subject: Re: [PATCH net v2 2/3] net: dsa: mv88e6xxx: read cycle counter
 period from hardware
Message-ID: <9b1fe702-39b2-4492-b107-f1b3e7f3c2a9@lunn.ch>
References: <20241006145951.719162-1-me@shenghaoyang.info>
 <20241006145951.719162-3-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006145951.719162-3-me@shenghaoyang.info>

> diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
> index bd66189a593f..a54682240839 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.h
> +++ b/drivers/net/dsa/mv88e6xxx/chip.h
> @@ -206,6 +206,7 @@ struct mv88e6xxx_gpio_ops;
>  struct mv88e6xxx_avb_ops;
>  struct mv88e6xxx_ptp_ops;
>  struct mv88e6xxx_pcs_ops;
> +struct mv88e6xxx_cc_coeffs;
>  
>  struct mv88e6xxx_irq {
>  	u16 masked;
> @@ -408,6 +409,7 @@ struct mv88e6xxx_chip {
>  	struct cyclecounter	tstamp_cc;
>  	struct timecounter	tstamp_tc;
>  	struct delayed_work	overflow_work;
> +	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
>  
>  	struct ptp_clock	*ptp_clock;
>  	struct ptp_clock_info	ptp_clock_info;
> @@ -714,8 +716,6 @@ struct mv88e6xxx_avb_ops {
>  	int (*tai_write)(struct mv88e6xxx_chip *chip, int addr, u16 data);
>  };
>  
> -struct mv88e6xxx_cc_coeffs;
> -

It is better to put it in the correct place with the first patch,
rather than move it in the second patch.

>  	memset(&chip->tstamp_cc, 0, sizeof(chip->tstamp_cc));
>  	chip->tstamp_cc.read	= mv88e6xxx_ptp_clock_read;
>  	chip->tstamp_cc.mask	= CYCLECOUNTER_MASK(32);
> -	chip->tstamp_cc.mult	= ptp_ops->cc_coeffs->cc_mult;
> -	chip->tstamp_cc.shift	= ptp_ops->cc_coeffs->cc_shift;
> +	chip->tstamp_cc.mult	= chip->cc_coeffs->cc_mult;
> +	chip->tstamp_cc.shift	= chip->cc_coeffs->cc_shift;

Once these patches are merged, it would be nice to remove
chip->tstamp_cc.mult and chip->tstamp_cc.shift and use
chip->cc_coeffs->cc_mult and chip->cc_coeffs->cc_shift. We don't need
the same values in two places.

	Andrew

