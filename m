Return-Path: <netdev+bounces-105437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFAD911268
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA83B2396F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C3F1BA862;
	Thu, 20 Jun 2024 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSZiEagy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814531BA062
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912570; cv=none; b=o9ceQZLiKG5382LlS4PsBpfArteJEIQXwWHdaxB/Lxo7ttQVGngJdw+OoZaPUw97cuDhPm3B3aejxjiR/2mjYJ4Ci6e3QT8mCHqwyAsmap3iIOL5r1pO2aslqT0I9GAsermhzDT6Ng42yGaPZer9qkxpo2Wuvu4C5xdmCmVWcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912570; c=relaxed/simple;
	bh=HehlRGEC8VVYuH4plXIVmqlAlRJGpeJ8Synul5a0NSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjrthOLH/WjbxSMZEU+C8wIygYS6uZW08fS+It6ezuGpE5QOt+cvpJ6mGFqjuqS9Xth9ZSMFZNXtZ1MWFiYFxHznste5WYmf+i46IdTqqyrJkJ+GA+FmFTEIiaFYTdBfu8z9LQWuoqct59Yb85O0+bV4HMr1PD+cDzgEIDfIbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSZiEagy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718912567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1agS+ZvCUVxgkXGHHLIbPUJmAmNouL9iIY3PECE7ow4=;
	b=RSZiEagyXXw84zqLbEl/yN/gi9sv9s+3O2xBe33Zxb4aMXtB/rLB8sXDD08gPdtNcpecc1
	xnfdyxAP38ywRSbueZsydQnYTUOBgQZlZ9Zr8m/KwpOZZkoOovoty2N3OVqxidA8lT6aGq
	iUU5x98Myg3pJnkO6/vPUxLzv2a+C64=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-ea0SLJQ7N_W-mWiUlDemOw-1; Thu, 20 Jun 2024 15:42:46 -0400
X-MC-Unique: ea0SLJQ7N_W-mWiUlDemOw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dfab38b7f6bso1935131276.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 12:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718912565; x=1719517365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1agS+ZvCUVxgkXGHHLIbPUJmAmNouL9iIY3PECE7ow4=;
        b=ZyKnj+ATDHoy0J3r7Xv2gZ7eeS7tyQy8XeXPQGtM95BvyBVNaqr4Rry82VGDIFSQjA
         RboIHh2hmg3R9ImHkbgPS611DAY2EOK8ScHDnHDBqSOC5poodhvDF2Td6DsCwPF2E12/
         HUL0qUUtpaQLVKSPdb3Lt6niHvKBEtdaCG+KVFqUqYod/O1BBSL4WPh8pwQXFItP0tXP
         KcV9LhEbBfezcljwmu3/cBMVLcr9Sfv7atRTPWyXysXjtpQvvwedCXYMXQ4fKrvupyCX
         hM/zuOWcShnS89AhDTapZhaaOivE5/3McGgWSZQf5z1xUZRUW/UZsQHl9jXSto0QKPnv
         Ua+w==
X-Forwarded-Encrypted: i=1; AJvYcCXZs1BjsR+4ds+B9oPPozrB1RjLwyBlerOIYxon/VpXGrx/bp6ikmk3USSaLhVaEfvx7Lsa6fjRAGJvABWI3M/h5uiKAzTP
X-Gm-Message-State: AOJu0YzNAKeDGTvfhjKJNxlONP+Tgo/aII31ri/9HznlHpTJIsLqHHv+
	Y0UemVuidJxfLI+swqCvrQEEKEl+3ODNfVcU0ADgB7fBrzHEt4pGdMDu4GWoBkagtPbPzkurYWE
	f6R9idKODuQI6bU275agYdYG8xoBkXINbjIlW1LgW44fg7o7ZvjfKXQr1Vfnceg==
X-Received: by 2002:a25:ae95:0:b0:dfa:5895:7814 with SMTP id 3f1490d57ef6-e02be17a2d8mr6265508276.36.1718912565196;
        Thu, 20 Jun 2024 12:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE4ky/fERanNc8cBhQKDDDU0GeIhg6HjUx/IE8xx/ZXGSXJJZV61VB95Bm+AQ66PZaqk4hXA==
X-Received: by 2002:a25:ae95:0:b0:dfa:5895:7814 with SMTP id 3f1490d57ef6-e02be17a2d8mr6265480276.36.1718912564724;
        Thu, 20 Jun 2024 12:42:44 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5180dd3a1sm5935796d6.31.2024.06.20.12.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 12:42:44 -0700 (PDT)
Date: Thu, 20 Jun 2024 14:42:41 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next 1/8] net: phy: add support for overclocked SGMII
Message-ID: <4ts2ab5vwf7gnwqd557z62ozjdbl3kf7d64qfc6rjhuokav3th@brhzlsrpggk6>
References: <20240619184550.34524-1-brgl@bgdev.pl>
 <20240619184550.34524-2-brgl@bgdev.pl>
 <bedd74cb-ee1e-4f8d-86ee-021e5964f6e5@lunn.ch>
 <CAMRc=MeCcrvid=+KG-6Pe5_-u21PBJDdNCChVrib8zT+FUfPJw@mail.gmail.com>
 <160b9abd-3972-449d-906d-71d12b2a0aeb@lunn.ch>
 <ZnNIib8GEpvAOlGd@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnNIib8GEpvAOlGd@shell.armlinux.org.uk>

On Wed, Jun 19, 2024 at 10:07:21PM GMT, Russell King (Oracle) wrote:
> On Wed, Jun 19, 2024 at 09:51:12PM +0200, Andrew Lunn wrote:
> > phylib supports out of band signalling, which is enough to make this
> > work, so long as two peers will actually establish a link because they
> > are sufficiently tolerant of what the other end is doing. Sometimes
> > they need a hint. Russell King has been working on this mess, and i'm
> > sure he will be along soon.
> 
> ... and I'm rolling my eyes, wondering whether I will get time to
> finish the code that I started any time soon. I'll note that the more
> hacky code we end up merging, the harder it will become to solve this
> problem (and we already have several differing behaviours merged with
> 2500base-X already.)
> 
> > What i expect will happen is you keep calling this 2500BaseX, without
> > in band signalling. You can look back in the netdev mailling list for
> > more details and those that have been here before you. It is always
> > good to search the history, otherwise you are just going to repeat it.
> 
> That's where things start getting sticky, because at the moment,
> phylink expects 2500base-X to be like 1000base-X, and be a media
> interface mode rather than a MAC-to-PHY interface mode. This is partly
> what my patches will address if I can get around to finishing them -
> but at this point I really do not know when that will be.
> 
> I still have the high priority work problem that I'm actively involved
> with. I may have three weeks holiday at the start of July (and I really
> need it right now!) Then, there's possibly quite a lot of down time in
> August because I'm having early cataract ops which will substantially
> change my eye sight. There's two possible outcomes from that. The best
> case is that in just over two weeks after the first op, I'll be able to
> read the screen without glasses. The worst case is that I have to wait
> a further two to three weeks to see my optometrist (assuming he has
> availability), and then wait for replacement lenses to be made up,
> fitted and the new glasses sent.
> 
> So, I'm only finding the occasional time to be able to look at
> mainline stuff, and I don't see that changing very much until maybe
> September.
> 
> At this point, I think we may as well give up and let people do
> whatever they want to do with 2500base-X (which is basically what we're
> already doing), and when they have compatibility problems... well...
> really not much we can do about that, and it will be way too late to
> try and sort the mess out.

I hope your holiday and operation go well Russell.

Pardon my ignorance, but I know of quite a few things you have in flight
and because of that I'm not entirely sure what specific patches you're
referring to above. Have those hit the list? I know you're cleaning
up stmmac's phylink/pcs usage, but I'm thinking that this is outside of
that series. Thanks in advance for helping me understand all that's in
progress around this mess of a topic!


