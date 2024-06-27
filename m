Return-Path: <netdev+bounces-107464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116B91B1A9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C381C22373
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 21:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7FC1A070C;
	Thu, 27 Jun 2024 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpueqDv6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942E22F1C
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524922; cv=none; b=k7wTMOYyQ1sidZ+Ghg13+6c8ENkCmPWBUp9keNmklv3pR4y9dIinHyh0WizsCQQChE2llWafkGtBlWrIhO1Vez3zPZa0zafx+EPYl+vuhFDuGHHC0gJNt84FbVVhldvlo/lLBlvPobiftA8RqWsHysLcY6tY0Ff7l+XwnkmzQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524922; c=relaxed/simple;
	bh=MyhZhvzWKPeEDKyrQNxpUzLYBHtM1wRWMBIuxRlX6LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i09EdwkV7e8reS6VR/5MNq7GigvKFvBfHC77BoBRKKwZij2HxZab7iNsKQUdNXKwP3MNWZ09tMfxEGPLdORwx8ZJ8WvXchz3SGyKvslH5pIrPDcSnELFv/PymiINSjILYvDfLBULDK2Mg3f5YiWzrL+Lt430nw2R/yXvZTvXlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpueqDv6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719524919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHcfOWsEcITl9bu0E1Ymw7ooI8Hv1gK+grR8ONGP2Xs=;
	b=YpueqDv6rj+hr40yDfZcuLHjfVV/cD5QxzotNWNaNXCdZqaDPSc8ZUp7DGJlLHRWMnEZGF
	kipvZDKJsdUx0IPEuTHparqlHT8xrEtmKSEJtJphTnTJed1R/Xt01yQOQxZoiaWzZuQ9oo
	s2ihdKv7HHjLMMmF29EXpp9NAQxi3bQ=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-ZD8-u1JgPQitlFW1XPsddA-1; Thu, 27 Jun 2024 17:48:37 -0400
X-MC-Unique: ZD8-u1JgPQitlFW1XPsddA-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-48f792971cbso2046707137.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719524917; x=1720129717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHcfOWsEcITl9bu0E1Ymw7ooI8Hv1gK+grR8ONGP2Xs=;
        b=dRUKqiSmXxgmMcqiag+6neha9e70kwzMlYgEBlAGdAZQ0Mp074uDUjywv6KDUibrHB
         TQ6fRw/gn0N7gtFssYKp+M8b/M5gaclgx5LxAQWZ46/ic6+6desJj+Zk2gjX5YKbH3Vw
         GMkkmw37vt3YgCaeLksJBAImO7PgiGDDLoorm+m56q5Xtv/4p+CohDSsPI1NJvE7vnBr
         TtWmGehiKM30IEYn8AELO5yFdBBZiplR2EuS9VPkmFmzMu5sVn/jPwbdTtW6jnxULDsl
         7ZRMcTwz6Vqe1qBWJUT6+hD8iZx0JeeRCqi3I284Yh7UV+PSA7xosjAKw/FFSd+dNuZv
         MvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXjFdcqJ+s1/p5hOWkxAKlZeKzTlIM/ryuUY1IuE7b6vA0N9n1Art0KKPb3yBNHV/xyUmByvNLSmPGwn1MS51yhiOX39nH
X-Gm-Message-State: AOJu0Yw+2Ao7kvI7kYVI2LmXxBoz4J5hiKwH4IwsKJXIxD1JnNZvYz/s
	NSRfQnYndRgfCQFj7xftZrohGrs3xhG54gwt+HbJTi5ktzWH11qO5zUSmJspgpXPdbnZmd+7eO0
	4Munqlvo/K36Fqv1wH3Cm7xM2zSRMiTNlzD3ziyCV3GaJZdtXkkTdGg==
X-Received: by 2002:a05:6102:2acf:b0:48f:8e88:583d with SMTP id ada2fe7eead31-48f8e886086mr4055819137.26.1719524917137;
        Thu, 27 Jun 2024 14:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5z22EvNhwn2zPZtn6j+WLbwXAvrBCWXFpiuWOMgt/1osDgKWNuZFANeop8KLzzBv36NnwMw==
X-Received: by 2002:a05:6102:2acf:b0:48f:8e88:583d with SMTP id ada2fe7eead31-48f8e886086mr4055788137.26.1719524916653;
        Thu, 27 Jun 2024 14:48:36 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5746f5sm2378616d6.52.2024.06.27.14.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 14:48:36 -0700 (PDT)
Date: Thu, 27 Jun 2024 16:48:33 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Russell King <linux@armlinux.org.uk>, Vinod Koul <vkoul@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 net-next 2/2] net: stmmac: qcom-ethqos: add a
 DMA-reset quirk for sa8775p-ride
Message-ID: <4zaewv4watlf7v3phu3qnjtutdnez6a2gqkymrfln5bsu2pq6x@sclwhdzmhu5p>
References: <20240627113948.25358-1-brgl@bgdev.pl>
 <20240627113948.25358-3-brgl@bgdev.pl>
 <td5jbseo7gtu6d4xai6q2zkfmxw4ijimyiromrf52he5hze3w3@fd3kayixf4lw>
 <CAMRc=MfznDaaNcfvRBg1wpiOkyTE=Ks-_nx=aCY1MR5-50Ka+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfznDaaNcfvRBg1wpiOkyTE=Ks-_nx=aCY1MR5-50Ka+A@mail.gmail.com>

On Thu, Jun 27, 2024 at 08:35:16PM GMT, Bartosz Golaszewski wrote:
> On Thu, Jun 27, 2024 at 7:07 PM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > Although, this isn't tied to _just_ 2500basex here. If I boot the
> > sa8775p-ride (r2 version, with a marvell 88ea1512 phy attached via
> > sgmii, not indicating 2500basex) wouldn't all this get exercised? Right
> > now the devicetree doesn't indicate inband signalling, but I tried that
> > over here with Russell's clean up a week or two ago and things at least
> > came up ok (which made me think all the INTEGRATED_PCS stuff wasn't needed,
> > and I'm not totally positive my test proved inband signalling worked,
> > but I thought it did...):
> >
> 
> Am I getting this right? You added `managed = "in-band-status"' to
> Rev2 DTS and it still worked?

> 
> >     https://lore.kernel.org/netdev/zzevmhmwxrhs5yfv5srvcjxrue2d7wu7vjqmmoyd5mp6kgur54@jvmuv7bxxhqt/
> >
> > based on Russell's comments, I feel if I was to use his series over
> > there, add 'managed = "in-band-status"' to the dts, and then apply this
> > series, the link would not come up anymore.
> >

This works on rev2/rev1 (no way to tell which one it actually is, shouldn't matter),
here's a branch I just whipped up to replicate the setup I had when
making the comments in above link:

    https://gitlab.com/ahalaney/kernel-automotive-9/-/commits/russell-cleanups-and-inband

The last commit has some dmesg/ethtool output etc to show things
working. I reverted recent changes to stmmac just to apply cleanly.

I tried the patches Serge added on top of that series, but that was causing
the link to cycle up/down, so I dropped those and went back to just
Russell's patches to recreate the setup I had when leaving the comment.
I need to try with Serge's stuff again when I find a moment and see if I
can work out why the link starts going up/down with those + some
compiler fixups and removing INTEGRATED_PCS flags. For what its worth,
here's the branch, logs are in the last commit:

    https://gitlab.com/ahalaney/kernel-automotive-9/-/commits/russell-plus-serge-plus-inband-link-cycles


Without Russell's patches the link doesn't come up after switching to
'managed = "in-band-status"' otherwise I'd look into switching the dts to
inband signalling now instead of after those cleanups land.

> 
> Because I can confirm that it doesn't on Rev 3. :(
> 
> So to explain myself: I tried to follow Andrew Lunn's suggestion about
> unifying this and the existing ethqos_set_func_clk_en() bits as they
> seem to address a similar issue.
> 
> I'm working with limited information here as well regarding this issue
> so I figured this could work but you're right - if we ever need
> in-band signalling, then it won't work. It's late here so let me get
> back to it tomorrow.

No worries, I understand how this goes, stmmac is tricky and getting
information/documentation and understanding it can be tough. I appreciate you trying
to get this squared away.

> 
> > Total side note, but I'm wondering if the sa8775p-ride dts should
> > specify 'managed = "in-band-status"'.
> >
> 
> I'll check this at the source.
> 

Thanks!


