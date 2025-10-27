Return-Path: <netdev+bounces-233169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C867DC0D731
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81206189F7F0
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308E3009F1;
	Mon, 27 Oct 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PHQzKwnE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549672FFFAD;
	Mon, 27 Oct 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567291; cv=none; b=jZM1McmcoXzdSMk6pYJDWqjTDNxuF/ytQm74N+hE34F+yglVjqBadlgor38eVeqH9tZhGxUVlLJbaA4xZStsM3xQ9k9pv2BF/A5CeQlSuJgjGdnlKgcwF4oG5YIc/mh/so+tXYHwi+78iFTNd2vKZKAmsn75tCxZ65Z7QUvV9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567291; c=relaxed/simple;
	bh=3Zql0hnlyyNDcrY8A/YO77WNrcPh/bW0kmJSeTJzSr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGgo7EcHU+0huPZ42l62oYSuDp/3wxKbbl3gFcqmvJGyJbxuFpgjr8F1wEq1NEwmrs35n7AbsrsD1vqrXw4C6DP0AbYzD1cYk6pfWjsjXWbNQavqHshGx7cIiHww+5/3KTx6tczJYTEpg4S2uz9N0MPpJxyN1zkg5ATg8vt67Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PHQzKwnE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PR3bVDmYCxp761b3MImnm37I6RBtXhqoJDwpm/RRsxY=; b=PHQzKwnExWRQY3s9Liy25I2h2v
	7d22XPzeUsfwoke+49ImLMJ5WfyNyfN8D3SDmLRIg88mNg3OTMhS79bbVzJyOECf8CGH6ktaVEVWQ
	6X58g+QzwblOWvA2D/5n53xi3yLVbh2tKhvgo82tzh7eUwmnTqgNr6+JcBSnP6EG29Rw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDM7W-00CBgK-II; Mon, 27 Oct 2025 13:14:42 +0100
Date: Mon, 27 Oct 2025 13:14:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: yt921x: Fix MIB overflow
 wraparound routine
Message-ID: <6d4f0ef0-3c6b-417e-82e1-d7f2635f6733@lunn.ch>
References: <20251025171314.1939608-1-mmyangfl@gmail.com>
 <20251025171314.1939608-2-mmyangfl@gmail.com>
 <cc89ca15-cfb4-4a1a-97c9-5715f793bddd@lunn.ch>
 <CAAXyoMOa1Ngze9VwwUJy0E7U52=w=fQE8cxwAviGm53MSQXVEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMOa1Ngze9VwwUJy0E7U52=w=fQE8cxwAviGm53MSQXVEA@mail.gmail.com>

> > > diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> > > index ab762ffc4661..97a7eeb4ea15 100644
> > > --- a/drivers/net/dsa/yt921x.c
> > > +++ b/drivers/net/dsa/yt921x.c
> > > @@ -687,21 +687,22 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
> > >               const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
> > >               u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
> > >               u64 *valp = &((u64 *)mib)[i];
> > > -             u64 val = *valp;
> > > +             u64 val;
> > >               u32 val0;
> > > -             u32 val1;
> > >
> > >               res = yt921x_reg_read(priv, reg, &val0);
> > >               if (res)
> > >                       break;
> > >
> > >               if (desc->size <= 1) {
> > > -                     if (val < (u32)val)
> > > -                             /* overflow */
> > > -                             val += (u64)U32_MAX + 1;
> > > -                     val &= ~U32_MAX;
> > > -                     val |= val0;
> > > +                     u64 old_val = *valp;
> > > +
> > > +                     val = (old_val & ~(u64)U32_MAX) | val0;
> > > +                     if (val < old_val)
> > > +                             val += 1ull << 32;
> > >               } else {
> > > +                     u32 val1;
> > > +
> >
> > What David suggested, https://lore.kernel.org/all/20251024132117.43f39504@pumpkin/ was
> >
> >                 if (desc->size <= 1) {
> >                         u64 old_val = *valp;
> >                         val = upper32_bits(old_val) | val0;
> >                         if (val < old_val)
> >                                 val += 1ull << 32;
> >                 }
> >
> > I believe there is a minor typo here, it should be upper_32_bits(),
> > but what you implemented is not really what David suggested.
> >
> >         Andrew
> 
> I didn't find the definition for upper32_bits, so...

You should of asked, or searched a bit harder, because what you
changed it to is different.

/**
 * upper_32_bits - return bits 32-63 of a number
 * @n: the number we're accessing
 *
 * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
 * the "right shift count >= width of type" warning when that quantity is
 * 32-bits.
 */
#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))

I don't see any shifting in your version.

And then i have to ask, which is correct?

How have you been testing this code? If this is TX bytes, for a 1G
link, it will overflow 32 bits in about 34 seconds. So a simple iperf
test could be used. If its TX packets, 64 byte packets could be done
in 5 hours.

	Andrew

