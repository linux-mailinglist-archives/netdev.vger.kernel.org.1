Return-Path: <netdev+bounces-133215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0D5995544
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5BDAB24A28
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491CB1E0DF2;
	Tue,  8 Oct 2024 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRrFwc82"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6B1E0DDB;
	Tue,  8 Oct 2024 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407101; cv=none; b=CCKrcozZ9dAPZG26nM/HNMypCa8iOkH+qIiwwwgYsm5tGN37ng9W9VuOXZLHRD00k3hGmB5mWffRo5EBl+r51c/azC4gSulgGWaIvsd6kVHz/rcMOU6xbbBHFFTvRZ7kzrL9QZLmI/WmyBAec+vegi9HgTtdmHIE/hit55eQ7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407101; c=relaxed/simple;
	bh=Ef/F0ql35nGbjKTRVh+Ybbc9GSaSifVk/OXqChMbje8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1ad8Z4lGNfYsbvT/fplgvLbzlx/LB3vpR3dV+vyAIEtZp9przYlnYjFxbvXMNITADif58iIq4K4CfMJFuKfExPoNQCt14upT2/XEnps97tH01E09Ek0j4tndsD82+nSEkPelvFzAt+J+JrJqi+a2LMMqUE0fg3V4M8HdKpdqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRrFwc82; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539983beb19so7331277e87.3;
        Tue, 08 Oct 2024 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728407098; x=1729011898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sV25p3p0AZj5gbkOQsaFZy2qZUkBS8f2wwinSGp8NsI=;
        b=GRrFwc82GXhusHQJJE5nirD1E1pd3Y8aEFBCzVU8ndpN9f0gVdkWUNVjsnGxliz5/9
         ljscSbnkxMEbvQtRtw9+t8SpYcN8NTEyUKRve0VeGT8FyBsmXQhd9Ym8HQClFD6TXuLg
         UmOqAxjmBx+0w7oujlnvYUOHk6CReXdYje4Q2b6vk65gjFCPANZvvafrRBeXktaw9SNN
         DFjykElW8dc0mpiBiNM8LgzSnqwSxMMJhG0XElJbzdphD/fkM5CGRAZZYnaOkqiX5Au8
         u0LikWRu0LZCIBNixCDvT6Ab+ecA/h5KHFTHQVfEgnlDqF8FKprNvmGTbKd9oroNWMf4
         Jb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728407098; x=1729011898;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV25p3p0AZj5gbkOQsaFZy2qZUkBS8f2wwinSGp8NsI=;
        b=lBnLnnkh1IrpCLBGBUJ6YOQFokpGHLiOAZLaKOByxX4RaevYJFIhpNma1XngN0sqRG
         uyoKLIGuw4fDBzhIo4/SXdA4N2JRORLV4tazJWU7adJA4B7wZLCArGfAo3340bHsDDrW
         Ik6LijBpC+4/tBlCrOrqcQugIa7Eu7rNt/jcqBzF7oqEWh8BrtXgI7RZZjKnz4KXStod
         NcjLipVgB9z+3dA+Pl+NTTK9ZY51xtwXH3wzAlGBbEo2W/7L5kDAQrz3RbHWtAvO+JZf
         vo7UtgHt6eQLCHGsI6/6ElcfZOXGrW8Dj/mVJ1XFPrWaPdFlEvd7TLLV983OzM6srngo
         hOCg==
X-Forwarded-Encrypted: i=1; AJvYcCUjsHek3qB30vlvNJHaCrqE8KrNjc1lsxxkjB10tMqB0YdnfrWUUkXpKUWu26vzlYwGzsyqYLlTTypWlv8=@vger.kernel.org, AJvYcCVWm5El5RLyvaBrYemFyF3h/El+DdBFJna2r2GEnf0ynKeEP2ofA6lGaNLR4eFO2XYWWLCDMvdQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ju9jDjSdwRM4jX86OPlJPliOJpcb/fXVJ2wJRv6XW2yudluG
	h4LaccNdjv1BvXXOWs0ZUTm06ZGp/eJB2RoxRnwBOwdDWgH5drgn
X-Google-Smtp-Source: AGHT+IFsyAihu1FRJ9mpa6itKK5ZBborXJn6yq8sKvbEIfrbzDZSK2IfEDLUjTGaAZmwQnuFv2rrvg==
X-Received: by 2002:a05:6512:138e:b0:539:9505:7e5 with SMTP id 2adb3069b0e04-539ab87e201mr7970572e87.36.1728407097278;
        Tue, 08 Oct 2024 10:04:57 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d3963413dsm151122f8f.45.2024.10.08.10.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:04:56 -0700 (PDT)
Message-ID: <67056638.050a0220.179d84.0dc1@mx.google.com>
X-Google-Original-Message-ID: <ZwVmNlfpC0olCPkf@Ansuel-XPS.>
Date: Tue, 8 Oct 2024 19:04:54 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2] net: phy: Validate PHY LED OPs presence
 before registering
References: <20241004183312.14829-1-ansuelsmth@gmail.com>
 <851ebd20-0f7a-438d-8035-366964d2c4d8@lunn.ch>
 <67053002.050a0220.63ee8.6d11@mx.google.com>
 <9ed5fd73-b4e8-4be1-9642-9dbeb8bfd892@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ed5fd73-b4e8-4be1-9642-9dbeb8bfd892@lunn.ch>

On Tue, Oct 08, 2024 at 07:02:18PM +0200, Andrew Lunn wrote:
> On Tue, Oct 08, 2024 at 03:13:34PM +0200, Christian Marangi wrote:
> > On Tue, Oct 08, 2024 at 03:08:32PM +0200, Andrew Lunn wrote:
> > > > +	/* Check if the PHY driver have at least an OP to
> > > > +	 * set the LEDs.
> > > > +	 */
> > > > +	if (!phydev->drv->led_brightness_set &&
> > > > +	    !phydev->drv->led_blink_set &&
> > > > +	    !phydev->drv->led_hw_control_set) {
> > > 
> > > I think this condition is too strong. All that should be required is
> > > led_brightness_set(). The rest can be done in software.
> > >
> > 
> > Mhh the idea was really to check if one of the 3 is declared. Ideally to
> > future proof case where some led will only expose led_hw_control_set or
> > only led_blink_set?
> 
> Ah, i read it wrong. Sorry.
> 
> Maybe apply De Morgan's laws to make it more readable?
> 
> +	if (!(phydev->drv->led_brightness_set ||
> +	      phydev->drv->led_blink_set ||
> +	      phydev->drv->led_hw_control_set)) {
> 
> However, it is correct as is.
>

Happy to send v3. Np!

-- 
	Ansuel

