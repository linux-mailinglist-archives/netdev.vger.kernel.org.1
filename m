Return-Path: <netdev+bounces-127146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F4974520
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A16A1C249D5
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 21:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040C51AB51E;
	Tue, 10 Sep 2024 21:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJjWwEHT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2C1F951;
	Tue, 10 Sep 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005491; cv=none; b=aqy53gzEQLmmg/CMjKHK0yhMnSJH4ZxegebyEsRAOWTwSX3Ya1C6FZXJ49Qt+rlE2fcn4UXl/t0x10yVbxcvj937Qxjr2IvBqj49RLNJp+w/vxc70p5jExqjuWcFoVnSp2g8SSXOwe8kCRyS9R2FeAQ5AO4dq5nq+dhwmKQHzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005491; c=relaxed/simple;
	bh=NW7MV6SxJoJXvAH65yMk5+pebvFxIRSu8hogkyqwnkU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niNBuDP70P/th3ICEDGEoGlh+yiqX1pip/6Zrf4NI+//KH1/XcP0lMTeR7eKHp2nCJZdedb9e3lE8zNIvmT2bVo8m892VpQsunjGRERgFAxo5lNPapm/djEndYs9+hqvmtaZuz6hK10eGvmsNfvO9XRruY31t7JaGmMzUgFRyOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJjWwEHT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c3400367so5217876f8f.2;
        Tue, 10 Sep 2024 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726005489; x=1726610289; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FVnejKReoIDTbvMWWE7dAzfm3ii4URx63I5jfLRsSaw=;
        b=gJjWwEHT8F4WylCsdtpucQcSuDOBhOMvNuRTANjrxUNj4DZjQnS+Cwgz/92UnO0+Ld
         jrHCNaew6rPM+r8LAqJIpCQbH4ty13SWLYMXjjY2jxRxrJEoGZMLu1NvNi6BrIqfrRyG
         CmDefor/+DPNmFeZ6X+12+RCLR20OCie6Q6GP9ZE0Q20yZ7HwKtTdmes1+9IK23lenqC
         VR73Wh1XIjNiVo/mQToIpMxXMYnCcJqsd4Jm37ofnNFnceEsCClFG19RWlbsADhU5QVR
         V7x9BpaTga/4a3Z2UpQQePL0JnKOsZTVBrSxtraOX8hdQTTKA/kSbQ7nhc0wB7now9uP
         WUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726005489; x=1726610289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVnejKReoIDTbvMWWE7dAzfm3ii4URx63I5jfLRsSaw=;
        b=pWEwpJqYE8Pvwq9KcdfJlF9NUIZT/iGSGH31YdODzaxLCIe3Yh3bN0G19tuAmDE8jQ
         tK6BpUTvOr2MT9jjwMxhoR8gMXkvxzd7PVLh2nXUvS2qGgdFFjBddh/6hS/oKPSryPDk
         uUXOVQQSOZnADZzSEh36Dnyg7kXDvPIhdPz6UVN7qr+B3l1C3c4tpi/AVYmLRbR5ifJp
         pQ6VnCCffw99eST4peVJBldPcILvB+v9c6EE6AzdAgDt0tSDiUlMvTr/1v91XBU5TbKM
         kCsJ9B7VpJ5T5e3zSVWmJvy6DKZkJEBvU/IPpbLmoVBxwFYDvlpTtHhA7Wmwi5KC0iDB
         hbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSxbqO0KlxoCiiDd75juHohSymkBpxOzzaG1f1OTj0K3DUpj1G3wd0eYVRT6RJ3KRyevzvMItngbeszdU=@vger.kernel.org, AJvYcCVq3HV0hfwy51uFl8IqHvCGrwlATiBnqLc4Ly//RWDfJU4wm6nfBJXIapPZHSCX4DknCXHYwIgp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkyu0mhGi1UkTGbdP7E/3uXn91a3+6KpbikNmy0owcIOJBafQE
	BY298aR6tHtutMP2R55JWjG5A3s1dibLRD3m+L2tv+GQZ+BseExE
X-Google-Smtp-Source: AGHT+IH/0UH/CxP2mmHRM0NmdkAggVtURCOYsSNNnSlKLDQmpV6qsCifoivRe6khBf4Y7rPbFQbJng==
X-Received: by 2002:a5d:64ce:0:b0:374:c71c:3dc0 with SMTP id ffacd0b85a97d-37892466d5bmr11191212f8f.52.1726005487833;
        Tue, 10 Sep 2024 14:58:07 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:5d47:19e4:3e71:414c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d64880sm523479966b.219.2024.09.10.14.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 14:58:07 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Tue, 10 Sep 2024 23:58:05 +0200
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"nico@fluxnic.net" <nico@fluxnic.net>,
	"leitao@debian.org" <leitao@debian.org>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"thorsten.blum@toblux.com" <thorsten.blum@toblux.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net: dsa: realtek: rtl8365mb: Make use
 of irq_get_trigger_type()
Message-ID: <20240910215805.GA12725@vamoiridPC>
References: <20240904151018.71967-1-vassilisamir@gmail.com>
 <20240904151018.71967-2-vassilisamir@gmail.com>
 <guos3naz2r7ur5pxjbyvqkulg6e3a7xzlst374g4guv4qg2r2h@2ctrjlbw75v6>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <guos3naz2r7ur5pxjbyvqkulg6e3a7xzlst374g4guv4qg2r2h@2ctrjlbw75v6>

On Wed, Sep 04, 2024 at 03:40:56PM +0000, Alvin Šipraga wrote:
> On Wed, Sep 04, 2024 at 05:10:16PM GMT, Vasileios Amoiridis wrote:
> > Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
> > simple irq_get_trigger_type(irq).
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Looks like you missed my review here, you can add it :)
> 
> Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>

Hi Alvin,

Sorry for missing that, but thank you for reminding :)

