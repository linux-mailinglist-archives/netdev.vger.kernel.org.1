Return-Path: <netdev+bounces-66801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF02840B37
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724531C2040B
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013FD155A58;
	Mon, 29 Jan 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIL7PiXF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55725155315
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545322; cv=none; b=MiPegBDs5iGplmXbC/AQVgataywDR8yi4+Mg3lY4uOHi8+N1Y7+gYUOaKFS1wPVV3lXxc2MOmgfM60tOerYyKOLLX21zzR0P+Qeh+5TX90b4vW/2sG8wF+/lLwmrMwsPE8quHEdZ0jcbjeVz6huutVUScXSPlnDXFlw8RnP76jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545322; c=relaxed/simple;
	bh=sbkQHHZFrgIdSWCYVdrd55Jz1lALDxQx9DQd1ctdtyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCPK2ZPZNZsFN7iAHfbBaH44ESw2us1UjL3xQTwqslKHoV5avoCB5uLdfuKea8+t+BuIS6fA0mKOaxdruDRBco5Yrph9z7GZDbEBmRNVSe2QrJSEJj4vzYARmLu5KJHnHFQG1V/5Lr0vmmcZvBFkvsYwySJyULM9xyntYk5cLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIL7PiXF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28fb463a28so332386866b.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706545319; x=1707150119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCOzyVpb1L6ncPLL7jfGOryqXeuK8VvBf/5+sy6Xscs=;
        b=ZIL7PiXFm/K+kahDGex/GDT3wVf9154P5MKrDpy3ACRqI7R75RbOtRdeGzudLypAqC
         41cKHrxhvQxLCST9ZF6VBpBXj+MXeqrA9kdjLT5zYSL5yBDa+Ba7/wJ/Mh68sC0pmqIz
         Wdukp2Bl7LovZgAarf2XdZxPxrRxCRx4Y8T7TdvEywMqVH/OvhzDQOM+Ego3Fqu22IS9
         riaAbKMtUUqFKElUtBk73aLMzujd9xvSOZJx+YsxBbfRVzGl9sd7g/SVHC7j8Wl8wQD9
         /t3tbRS5clwhPJbN/nIuyMgLZL+sCw/HM1xOLtvsudheMzFe/oVDay2j/d9jo6U05SXR
         E88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545319; x=1707150119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCOzyVpb1L6ncPLL7jfGOryqXeuK8VvBf/5+sy6Xscs=;
        b=jIrW9lUtLT2+y66nQSYAc/dKDdI3Tfsq1CCPE5DqSqPHcLdzby/+Xpxfh8Lr2yTJ1w
         0JU1AI7/wOpbFFJYqf3zi+1V1YhRMKGT4W0jM0QMbbS+vU6xtZVruWdEglhA7b6WInOs
         JCZ3cq0/+QW3TCOBAjj911L3q5mpARa8u9VZiEb/aIAwoGZixtuHrdcOFVZL7ajKK9NO
         AwK+hQmAoXa9W1+fXxZnr5SVwaOTEaINK4IIY+g8KHIMINcM55uC0XDmqOzWt9mAAQYy
         7xzPRCOkltj4nXjiyZNMO9qVjIfl9TXQ6aBin1sA7rMeafcIBjtasIwuVp1oAnojo9gO
         eQWw==
X-Gm-Message-State: AOJu0Yy8TsDyhAClxIKsyYtgXprVVO90QkCqgKd1AjSrbxti0PHgu54I
	y1NIGlAoycxLfweDWSia8xze5zztXObnLUs+aB8hfYs+yZ76ivwXQl+c911LYn4=
X-Google-Smtp-Source: AGHT+IFeglagYXgCfwRHn6wRG5fG6PBF+wZ3xr6Si/qLfq1o6DdkXuFbnbARGDjfJsds0DhHBEzHbw==
X-Received: by 2002:a17:906:2354:b0:a35:7191:d952 with SMTP id m20-20020a170906235400b00a357191d952mr3573632eja.53.1706545319404;
        Mon, 29 Jan 2024 08:21:59 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id kq18-20020a170906abd200b00a35c8897a16sm995261ejb.80.2024.01.29.08.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:21:59 -0800 (PST)
Date: Mon, 29 Jan 2024 18:21:56 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 03/11] net: dsa: realtek: convert variants
 into real drivers
Message-ID: <20240129162156.wrahfl4rdev45ro5@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-4-luizluca@gmail.com>
 <20240125102525.5kowvatb6rvb72m5@skbuf>
 <CAJq09z4dOF4_XzKFRSP_ABoqN8y8ZXD1kOgxuL7TvC=8_M9Ojw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z4dOF4_XzKFRSP_ABoqN8y8ZXD1kOgxuL7TvC=8_M9Ojw@mail.gmail.com>

On Sun, Jan 28, 2024 at 08:34:29PM -0300, Luiz Angelo Daros de Luca wrote:
> > > + * This function should be used as the .shutdown in an mdio_driver. It shuts
> > > + * down the DSA switch and cleans the platform driver data.
> >
> > , to prevent realtek_mdio_remove() from running afterwards, which is
> > possible if the parent bus implements its own .shutdown() as .remove().
> 
> I didn't think that both could be called in sequence. I learned
> something today. Thanks.

And neither did I, until it happened to a user... More details in commit
0650bf52b31f ("net: dsa: be compatible with masters which unregister on
shutdown") after "However, complications arise really quickly".

