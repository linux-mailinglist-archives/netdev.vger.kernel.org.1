Return-Path: <netdev+bounces-129974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B25F987518
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 16:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64C1286685
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DBA130E27;
	Thu, 26 Sep 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqm1d5CF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405B76410
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359615; cv=none; b=YEsyVZuVya5nng30b6RiTw2xbpyThm1FLKkS9vOqrBi+3Iioa0DYLPGQ2S7q9BIrNtToVOLBbPiE7wHCB52p4EcAXubcNiki4eymnCkhOkLar0qpz64CqMCKU7lk6k0xxor+JK55eP4Y4Dec70VW2w4dUdV+SIK1TQyD66VPI5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359615; c=relaxed/simple;
	bh=xr5K7rGl2zWOqD9DW0w8PPn3AhCN93PTesWbIZcIiIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3caHo1/Ja1XykK0CSZcVrCZnwi/bP25wmF7Z5Jmn/AqnFRghhDEajFwxM5Kv230DwKCmJL5vH3im4D2CuFd56No1geL8DQ8I3ksFC2zOkLnE0gUX9VaPjp6BithIofWYVzQPB+P+ovOF6TVb4e7oL9jX1jrAmyI1BYUpVwcJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zqm1d5CF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a90f263c60fso11372166b.3
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727359612; x=1727964412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dnBN6W/2Yn8YL1xAQTroO/UvJGFrAyxdRIvWWWIPJng=;
        b=Zqm1d5CFwltcN0C1EtjbEvUSk1nwTX1fgFivK0QOsRMEzkF9Hv4iUhbf48Rwf7vGUq
         sEr5VcIz+MR62BbeKmKbH+Cp00Jog1q0sAFwQlVqzY9d99caLeQVp44VIv4fubOK3Zub
         rgdDvQWkroMFwwNtLcFpvqJfKV2f1XSDQqYXwKqGdRLnVqj80HDSYvPMWLp0PqjMrToX
         Jp3Bl38KEC7yscDRV1Jx2QVWPC/LkwoaJJtZ9TzfYD4w2oKiFaiDW8C56lu8KpNJP0SC
         LtYcjre/SZhU+vqhrj62AmO5jZjpH0eg8D9BNtWeQ0PZnMK1Qe/amFZLQ1SCMlpSYPDC
         JpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727359612; x=1727964412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnBN6W/2Yn8YL1xAQTroO/UvJGFrAyxdRIvWWWIPJng=;
        b=iED0xrUG1XNLr16HQmtw5rC8v85DeJSXlOm5nAbW/ZD1ut8q5Es51StkKaRonLacEm
         izAHlpW4qiGY5XOAu0VOvm4GhRuAoBfCMsu4pB7ihvgvfv7IaXBKPUHMEZbc24Cf8jXs
         fD3YyEsvJL+1ewa6q0X/IPmB3YNzeNl5Cowm9EmqEr7wdBWBZxOxL+F3AnmnDaaXcMV5
         6zUrPMM460w2t8dRf/git1adPGgldvfotvLwAweTajA/IOWMOb9G4VJ13a/4tInb5V/P
         5qVoiC0DbmRfk1Pgt55D+YUyFF1WGRBziaG7OaDhC+b2psuukkUGNdDmCXstSoH9f4Qr
         D6tg==
X-Forwarded-Encrypted: i=1; AJvYcCUo5y1pT07pe13jukFDuBzP5bQm4+c7oTfoqK7saUb75VoXz2BN6msRGTArJIZLzo0wnbrkJE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+17raT2pN/LhUdw09C1buxaoV/w7KVtCp947XRLShRHYDV146
	wX5OoyMn2FJZ5WZnukUAZvAEIZTp+HVxVRqgg3peYX/WesfSblvk
X-Google-Smtp-Source: AGHT+IFvq+Q1MRytKOktEY4oDr+KD7iY0K65f5kEblT+8Z7cHRq/M6AykZXCgjHzqYpBKIWv2L2yRA==
X-Received: by 2002:a17:907:d2a:b0:a8d:2623:cd4a with SMTP id a640c23a62f3a-a93a06b1221mr247104366b.12.1727359604576;
        Thu, 26 Sep 2024 07:06:44 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775d23sm2027766b.4.2024.09.26.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:06:40 -0700 (PDT)
Date: Thu, 26 Sep 2024 17:06:34 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 06/10] net: dsa: sja1105: simplify static
 configuration reload
Message-ID: <20240926140634.kpiwi7xjhkrq3kaq@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjcz-005Ns9-D5@rmk-PC.armlinux.org.uk>
 <20240925131517.s562xmc5ekkslkhp@skbuf>
 <ZvRmr3aU1Fz6z0Oc@shell.armlinux.org.uk>
 <20240925211613.lmi2kh6hublkutbb@skbuf>
 <ZvVNWxIRhKyNLM/J@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvVNWxIRhKyNLM/J@shell.armlinux.org.uk>

On Thu, Sep 26, 2024 at 01:02:35PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 26, 2024 at 12:16:13AM +0300, Vladimir Oltean wrote:
> > On Wed, Sep 25, 2024 at 08:38:23PM +0100, Russell King (Oracle) wrote:
> > > > There are 2 more changes which I believe should be made in sja1105_set_port_speed():
> > > > - since it isn't called from mac_config() anymore but from mac_link_up()
> > > >   (change which happened quite a while ago), it mustn't handle SPEED_UNKNOWN
> > > > - we can trust that phylink will not call mac_link_up() with a speed
> > > >   outside what we provided in mac_capabilities, so we can remove the
> > > >   -EINVAL "default" speed_mbps case, and make this method return void,
> > > >   as it can never truly cause an error
> > > > 
> > > > But I believe these are incremental changes which should be done after
> > > > this patch. I've made a note of them and will create 2 patches on top
> > > > when I have the spare time.
> > > 
> > > ... if we were to make those changes prior to this patch, then the
> > > dev_err() will no longer be there and thus this becomes a non-issue.
> > > So I'd suggest a patch prior to this one to make the changes you state
> > > here, thus eliminating the need for this hunk in this patch.
> > 
> > That sounds good. Are you suggesting you will write up such a patch for v2?
> 
> Actually, the three patches become interdependent.
> 
> Let's say we want to eliminate SPEED_UNKNOWN. Prior to my patch in this
> sub-thread, we have this:
> 
>                 speed_mbps[i] = sja1105_port_speed_to_ethtool(priv,
>                                                               mac[i].speed);
> ...
>                 rc = sja1105_adjust_port_config(priv, i, speed_mbps[i]);
> 
> sja1105_port_speed_to_ethtool() can return SPEED_UNKNOWN if
> mac[i].speed is not one of the four encodings. If we can't guarantee
> that it is one of the four encodings, then SPEED_UNKNOWN may be
> passed into sja1105_adjust_port_config().
> 
> Similarly, as for the default case, we can't simply delete that,
> because that'll leave "speed" uninitialised and we'll get a build
> warning without my changes. We could change the default case to
> simply:
> 
> 	default:
> 		return 0;
> 
> but that just looks perverse.
> 
> So, I think rather than trying to do your suggestion before my patch,
> my patch needs to stand as it currently is, and then your suggestion
> must happen after it - otherwise we end up introducing more complexity
> or weirdness.
> 
> Hmm?

Ok, if we're back to my original proposal, I'm implicitly okay with that.

