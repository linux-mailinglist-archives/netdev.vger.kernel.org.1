Return-Path: <netdev+bounces-105185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE7910092
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE7BB224FB
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254DE1A4F0C;
	Thu, 20 Jun 2024 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC9io6Vr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C21802E;
	Thu, 20 Jun 2024 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876458; cv=none; b=qt8VjbxZ1Hc13BkU9pcqCr+GZ1XzKBuiwBQkYqW6utC/pQQe7BD1jL8ZwLr16AmCsrdHbeUSkGAH9DOok92fOQrBtyaHNSKxkoYwrl5bi0fvyrEMykMe3ubR1e6S7H5VT5Ki9J7Qo9/s8PMI7/7r6BX8uB6iY7Gt1auvI3xR5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876458; c=relaxed/simple;
	bh=iA23UnyppenpynP4WXQAzISgZINqp+rlmvESOUk8KoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY3v+WZtkoOC2ji3hhmzB4YD39Tff8cnmR4gaqey8tFoPcIQZhLALc+qcF7d+S/uSc/EvOyqe+Ja8DxzZS37FTsfNqViFj/9DfpbWZBXW27PJbqGEfTbfvIoH1UFC2YO02R7WrGyRb1c+edurIkqzWDH53mLrIwHmWTzlMwi4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gC9io6Vr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6fb696d2e5so71403466b.3;
        Thu, 20 Jun 2024 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718876454; x=1719481254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eV7X9tsGjM8wqUROWjyFBARy0GsDsOCdgk3VvKppSk=;
        b=gC9io6VruOoIUL5I9tq3eH44ls0djK5iQxoPAdbEG+04t0CP5vmM0S8hPpAKwoq5jA
         44GEIzsEI+H2x+EtZ3B1UHgmDBzcvIzIVFyJjuUUdUwuNAmEo7b/I1WVLMhlfZgRLu/+
         uGeqjdQya9sWlAX4DpJT2rVD7ZnsI33xfKk8Ex8xLEzKBSupNP55JgTfNsSVFVOpZ0CW
         qlFcycM9/aG4Adc28UUwCYVLqiBNStW9FH+h9EAnNKbdksbjF0P9zL//2VOQ0BGuTcEl
         eqbInyEkTUPzAz9E9AsEm5ffwbWBiVCvZjx1xjyejxewZO2Ik0ETaZSaJjV+/CgI7hnw
         byUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718876454; x=1719481254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eV7X9tsGjM8wqUROWjyFBARy0GsDsOCdgk3VvKppSk=;
        b=mMHiqD27DrXslRjaHOaRrK/ryGGXBYmvdHAyeA/WcvtaR2pxu2DhTD6arL6SaZP1uH
         ZB4EWzmUR7qB4Wgjlin6IYCe8s5jDpos8RgMibSnGfzd68Av7EyoIEPHEXFJpS6rc21R
         JoeeK2jkd5eh3NZZgZ/TL+hCVq+6E9ULhN+mUYHL66pNamSXRVv0s8wMcvJ/uIe8xutB
         5Q+iPY1f9XaZ6zH9zbwqVrtCANU5IjEb2zmVZVc2XtheGA83rzJx2N2JXKLu5hG2NejY
         5n0OmUpoIEyO70HxwQYEsDT/Op37jbIiaQHh0e9TxJG5XS97jT0vi3f5u6YP/QDcoHvl
         gCTA==
X-Forwarded-Encrypted: i=1; AJvYcCUBnh2q5j+6hA/nYIzTTHW4NWTca+9ROSw+OHsYN5BDIhnSJGFsaKpN9hXGZlLGh7fDxJUxzZ3VCOJO9x3ZWVH/osjgUed5Swiq4o3db1RYCWLdKPsY60EliCRErvq2TmzqwXYF
X-Gm-Message-State: AOJu0YxZzAIeWk4iboNaqJ99AldleMEpo1akkvbd7OqFE7GES9NrnxFn
	qKIS30eUDXCFydXaPq63on/d70WL3AFnfOggSH5EEblLAdbaJ+mf
X-Google-Smtp-Source: AGHT+IFFL13Uj0dIQY5oe0enFoaWcUgb0f4dQ5OO4ieWFcPuCWbwtxt0nKq1k8eBJo7kF2FECpZPLg==
X-Received: by 2002:a17:907:9405:b0:a6f:5c1a:c9a6 with SMTP id a640c23a62f3a-a6fab77a20fmr329753966b.62.1718876453944;
        Thu, 20 Jun 2024 02:40:53 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f99e0csm748270366b.194.2024.06.20.02.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:40:53 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:40:50 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: Arun.Ramadoss@microchip.com, Woojung.Huh@microchip.com, andrew@lunn.ch,
	vivien.didelot@gmail.com, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net] net: dsa: microchip: fix wrong register write
 when masking interrupt
Message-ID: <20240620094050.qz543iyd252nrxqg@skbuf>
References: <1717119553-3441-1-git-send-email-Tristram.Ha@microchip.com>
 <20240602141524.iap3b6w2dxilwzjg@skbuf>
 <BYAPR11MB3558B815C8FE0A9E28365EC4ECCE2@BYAPR11MB3558.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3558B815C8FE0A9E28365EC4ECCE2@BYAPR11MB3558.namprd11.prod.outlook.com>

On Tue, Jun 18, 2024 at 11:55:22PM +0000, Tristram.Ha@microchip.com wrote:
> > Subject: Re: [PATCH v1 net] net: dsa: microchip: fix wrong register write when
> > masking interrupt
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content
> > is safe
> > 
> > On Thu, May 30, 2024 at 06:39:13PM -0700, Tristram.Ha@microchip.com wrote:
> > > From: Tristram Ha <tristram.ha@microchip.com>
> > >
> > > Initially the macro REG_SW_PORT_INT_MASK__4 is defined as 0x001C in
> > > ksz9477_reg.h and REG_PORT_INT_MASK is defined as 0x#01F.  Because the
> > > global and port interrupt handling is about the same the new
> > > REG_SW_PORT_INT_MASK__1 is defined as 0x1F in ksz_common.h.  This works
> > > as only the least significant bits have effect.  As a result the 32-bit
> > > write needs to be changed to 8-bit.
> > >
> > > Fixes: e1add7dd6183 ("net: dsa: microchip: use common irq routines for girq and pirq")
> > > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > > ---
> > > v1
> > >  - clarify the reason to change the code
> > 
> > After v1 comes v2.
> 
> I thought the initial version starts at index 0?

Nope - you can cross-check with other posts on the list. Both RFCs and
normal patch submissions on the same topic start from v1 (either
explicitly specified or not) and increment for each submitted version,
regardless of whether RFC or not (the first proper submission after 3
RFC iterations is a v4).

> > >
> > >  drivers/net/dsa/microchip/ksz_common.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > b/drivers/net/dsa/microchip/ksz_common.c
> > > index 1e0085cd9a9a..3ad0879b00cd 100644
> > > --- a/drivers/net/dsa/microchip/ksz_common.c
> > > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > > @@ -2185,7 +2185,7 @@ static void ksz_irq_bus_sync_unlock(struct irq_data *d)
> > >       struct ksz_device *dev = kirq->dev;
> > >       int ret;
> > >
> > > -     ret = ksz_write32(dev, kirq->reg_mask, kirq->masked);
> > > +     ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
> > >       if (ret)
> > >               dev_err(dev->dev, "failed to change IRQ mask\n");
> > >
> > > --
> > > 2.34.1
> > >
> > 
> > What is the user-visible functional impact of the 32-bit access? Justify
> > why this is a bug worth sending to stable kernels please.
> > 
> > FWIW, struct ksz_irq operates on 16-bit registers.
> 
> As explained before the initial code uses register 0x1C but now it is
> changed to 0x1F.
> 
> See the real operating code if not modified:
> 
> ret = ksz_write32(dev, 0x1F, 0x0000007F);
> 
> The original code looks like this:
> 
> ret = ksz_write32(dev, 0x1C, 0x0000007F);
> 
> BTW, all other KSZ switches except KSZ9897/KSZ9893 and LAN937X families
> use only 8-bit access.
> 

So you're saying that the original code made a 32-bit access to address
0x1c (aka byte-wise accesses to 0x1c, 0x1d, 0x1e, 0x1f) and then the
blamed commit changed the address of the 32-bit access to 0x1f (aka
misaligned byte-wise accesses to 0x1f, 0x20, 0x21, 0x22), leading to a
failure to mask the correct IRQ? And that only the byte-wise access to
0x1f is actually required, so instead of restoring the 32-bit access to
address 0x1c as would be expected from a trivial fix, we can just
perform an 8-bit write to 0x1f directly?

Sorry, but if this is the case, it isn't clear at all from the commit
message and later explanations, at least it isn't to me.

