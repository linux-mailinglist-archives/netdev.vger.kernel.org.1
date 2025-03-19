Return-Path: <netdev+bounces-176195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C550A694A3
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BF517A7DF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611671DE2B9;
	Wed, 19 Mar 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP1PcTKl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAC623CB;
	Wed, 19 Mar 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401137; cv=none; b=cByhxkkQPWAY4wRWCeZFGt+D7cwUrBVigi8qeSOzpPNyLb+qXy2yVmibfPRpBR21gysXBmG9mq2FT8+nQxH84E1FDms40VO9QKpC+cGG1nN0O2zzDq+2Zll6AcMerUzd1oS60M9LGjyEnvH304QvlnVGStfTgEH+XmKTZVotZVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401137; c=relaxed/simple;
	bh=OwSOG0S77bZYMXP3uV+OlswjQx5n7+0S5n88oWJIMDQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+YCbVBuiz+0welgdTmV0Dj+Ca/BX9vZgpOUDD3No/2OuqhSHqXiqIOhBVm+sQ5x1L33qM/R025KHAA1zVZ2g6jJDYNdvnXCg7CAIAccamORVjcjWU31vVk5+cZjFoNNqLC92XXgbu9d39ypw+ZH1cNuTvJ9pio8DyB1TRAACXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bP1PcTKl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso51058425e9.1;
        Wed, 19 Mar 2025 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742401134; x=1743005934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bnfoU7mBjVkA9Th5z/zOckcEnqVK4FlE3A1hCQeMHDI=;
        b=bP1PcTKll/roh8pWwM1uXIR3sBg1BXrGE6bvkQVj7gkq6Kc0M3Mgi63/HSaN0Z0ZyX
         ZRQ5nbmWm89Ket1DrtCxff3jvulAkkffBh93cHMejqimW+GUWnF+Fi9tsPabUhw44yX0
         7V1g+ttCdEAuxxlrGFMbwLxjfm91OLvEzrAT35EYZaFsU1xuyTnFP3T8tuAaVYrQJkFS
         +uI2n1/a4haIFtgOrD1iVmjLXDqFRjxPI1iKo0wSzJE9xJ1UzrwvsY3hSlIZXrNaltb4
         JcxtpB3IFVH5QB9DxXbvbfoKgI2XN32TVkCN54SlrMFtO1CcRntcOg5bqrMfgbWCl8RO
         W6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401134; x=1743005934;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnfoU7mBjVkA9Th5z/zOckcEnqVK4FlE3A1hCQeMHDI=;
        b=HUctDEOtT3rNj23oYaWSe+DcHjHslrInATJMkuPL88KVJztBE6UOc76/45MwAUK4L3
         wPCG7FwOfiQGWcgylHz8qAn+jHj9X6yev80UN92ShahqOyJkCIuGcQ/x8IeFIjHxOZvn
         b/5ab3RkbQIX2ajcRwyJD2DGRcth7GgAY7LAGRUMvS9oC6r8PQ3YK7StPx556hNDWKoe
         2UMpRtXSdEH1tuXUfSj193syKIB79eixYesOAfHzcu7Rteb0aOoEpVva8YwK+FmsH8uT
         /Pki/FVAR30vOAXFoznC37kpaffNRhxnY9Rr/dPqQjjFRcNr+83KpjWWunSIQY6sEJNh
         kN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU850ZPBcYYZmAJAB6nJzo7n4lSw2gqvo1wVDO1c7xoiZkfi0coYmQ4Ti+mWtRhEhmPfG3yj7ix@vger.kernel.org, AJvYcCUS6EEMb/kl1JKu05Lrn1ih24XeDLpSspDZCAAGgSAFXJnxQFzLDZz/TFMBkEU6oZlRQ+odGlZTjsAZU5Cv@vger.kernel.org, AJvYcCXTHGqzO7DnrbHUgfx1Ib4OglnoSTgRXz/I629BT+ujHg68sPRE7bao9VzFCKrGfCdl4HI66+UJo8Jz@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZIReAabyjy9wAWF58vkfGfJ8DI1cANhNI6m90D8CWaFSx1Jv
	gvqcu9wQGcyUD7KtKdw3YTfXYkI204dwql3DpVis+J5W1SS0x3SGAHNuRg==
X-Gm-Gg: ASbGnctf9vPb7m7vPPK04MevAa95x0IdwRsMYLA4ZV5ZXYrO7VJoEJv/my/uDznhhpN
	DNqyLh9sizfilN/5EzRLKpV8Xk6/wbCgrp26VyzgbPeoG/Jawf77d9hHSmVSlTDM3NvcfpYzJNB
	P5kzlNrhxgOYBDzDrhvkoW1I/7G2PDrl8QikMtuFuV99lrF5iBaHvGi7BNnmAK/+xxGaOH0wTTD
	WQ1puD5qJIKIV4TW/ZfgOU9GB3CnaEewabNFYNi7DjqWDmdNW2ipT2g9zSOvh5uEdj9eY+90M06
	Q3hZ+gxfFRuaOaCpdTQ1NCJiwmdT+VJsuspAv7mVVOwgVdE7jPJckjdABP39Nzhn2N+Pn0noPeR
	B
X-Google-Smtp-Source: AGHT+IEpifywlizkokePwCA1fLwRkKkEZbzzINfV8vWGnim6yGIkREN5/dWJ7lOKx8kqyj7QsVI+4w==
X-Received: by 2002:a05:600c:5250:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-43d43781768mr32164955e9.6.1742401133303;
        Wed, 19 Mar 2025 09:18:53 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43d803f6sm23684435e9.0.2025.03.19.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:18:52 -0700 (PDT)
Message-ID: <67daee6c.050a0220.31556f.dd73@mx.google.com>
X-Google-Original-Message-ID: <Z9rualj5yVQ38KPe@Ansuel-XPS.>
Date: Wed, 19 Mar 2025 17:18:50 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 3/6] net: phylink: Correctly handle PCS probe
 defer from PCS provider
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-4-ansuelsmth@gmail.com>
 <Z9rplhTelXb-oZdC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9rplhTelXb-oZdC@shell.armlinux.org.uk>

On Wed, Mar 19, 2025 at 03:58:14PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 19, 2025 at 12:58:39AM +0100, Christian Marangi wrote:
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 7f71547e89fe..c6d9e4efed13 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -1395,6 +1395,15 @@ static void phylink_major_config(struct phylink *pl, bool restart,
> >  	if (pl->mac_ops->mac_select_pcs) {
> >  		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
> >  		if (IS_ERR(pcs)) {
> > +			/* PCS can be removed unexpectedly and not available
> > +			 * anymore.
> > +			 * PCS provider will return probe defer as the PCS
> > +			 * can't be found in the global provider list.
> > +			 * In such case, return -ENOENT as a more symbolic name
> > +			 * for the error message.
> > +			 */
> > +			if (PTR_ERR(pcs) == -EPROBE_DEFER)
> > +				pcs = ERR_PTR(-ENOENT);
> 
> I don't particularly like the idea of returning -EPROBE_DEFER from
> mac_select_pcs()... there is no way *ever* that such an error code
> could be handled.
>

Maybe this wasn't clear enough, the idea here is that at major_config
under normal situation this case should never happen unless the driver
was removed. In such case the PCS provider returns a EPROBE_DEFER that
in this case is assumed driver not present anymore. Hence phylink fails
to apply the configuration similar to the other fail case in the same
function.

The principle here is not "we need to wait for PCS" but react on the
fact that it was removed in the meantime. (something that should not
happen as the PCS driver is expected to dev_close the interface)

> >  	linkmode_fill(pl->supported);
> >  	linkmode_copy(pl->link_config.advertising, pl->supported);
> > -	phylink_validate(pl, pl->supported, &pl->link_config);
> > +	ret = phylink_validate(pl, pl->supported, &pl->link_config);
> > +	/* The PCS might not available at the time phylink_create
> > +	 * is called. Check this and communicate to the MAC driver
> > +	 * that probe should be retried later.
> > +	 *
> > +	 * Notice that this can only happen in probe stage and PCS
> > +	 * is expected to be avaialble in phylink_major_config.
> > +	 */
> > +	if (ret == -EPROBE_DEFER) {
> > +		kfree(pl);
> > +		return ERR_PTR(ret);
> > +	}
> 
> This does not solve the problem - what if the interface mode is
> currently not one that requires a PCS that may not yet be probed?

Mhhh but what are the actual real world scenario for this? If a MAC
needs a dedicated PCS to handle multiple mode then it will probably
follow this new implementation and register as a provider.

An option to handle your corner case might be an OP that wait for each
supported interface by the MAC and make sure there is a possible PCS for
it. And Ideally place it in the codeflow of validate_pcs ?

> 
> I don't like the idea that mac_select_pcs() might be doing a complex
> lookup - that could make scanning the interface modes (as
> phylink_validate_mask() does) quite slow and unreliable, and phylink
> currently assumes that a PCS that is validated as present will remain
> present.

The assumption "will remain present" is already very fragile with the
current PCS so I feel this should be changed or improved. Honestly every
PCS currently implemented can be removed and phylink will stay in an
undefined state.

Also the complex lookup in 99% of the time is really checking one/2 max
PCS for a single interface and we are really checking a list and a
bitmap, nothing fancy that might introduce delay waiting for something.

> 
> If it goes away by the time phylink_major_config() is called, then we
> leave the phylink state no longer reflecting how the hardware is
> programmed, but we still continue to call mac_link_up() - which should
> probably be fixed.

Again, the idea to prevent these kind of chicken-egg problem is to
enforce correct removal on the PCS driver side.

> 
> Given that netdev is severely backlogged, I'm not inclined to add to
> the netdev maintainers workloads by trying to fix this until after
> the merge window - it looks like they're at least one week behind.
> Consequently, I'm expecting that most patches that have been
> submitted during this week will be dropped from patchwork, which
> means submitting patches this week is likely not useful.
> 

Ok I will send next revision as RFC to not increase the "load" but IMHO
it's worth to discuss this... I really feel we need to fix the PCS
situation ASAP or more driver will come. (there are already 3 in queue
as stressed in the cover letter)

-- 
	Ansuel

