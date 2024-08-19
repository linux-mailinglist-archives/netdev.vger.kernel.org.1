Return-Path: <netdev+bounces-119757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5A4956DB8
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674A01C23647
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D916BE3F;
	Mon, 19 Aug 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqbdimS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FB171E55;
	Mon, 19 Aug 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078669; cv=none; b=BnUTgbpq3Me3XFYchK5uSCi/Q5K5oiRvccaNuLFj2NNF+pssNn2n7GUVHQmDXcKj1sfK2gW2J1oKnwccz32iCDL2/Souo70L+kNwOfRe6HtIIICdp4s+1MxicbVJCLFunSdFXNWObqN1wh6V0Ms2vZcIyF+gy87f2x/lF3fT2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078669; c=relaxed/simple;
	bh=3p9lZltV8E80RCbmETRjYh5iBlWki/oaEyxIniifm2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeekqU25pkIZcJLl638WN2Mw5t8MARqahgg8QzRr9WrkIIQ9DfdOb+B2rCkuMjbXyYddFZLD4gErAxG4rVvZNTjTI1Y77xwfOzQHMJQUxZ2tmTEWFReWKMkhBPq4EsvdJz+s/5UPfLDERXiqVpCrduNZRDFyIdW4TeOflB9scbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqbdimS7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bef4d9e7f8so1688718a12.2;
        Mon, 19 Aug 2024 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724078666; x=1724683466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zb6F0HNbTZX23uf0i9iclKqAAe/JFVipCwV1qTRY4HE=;
        b=BqbdimS7tFL7mtgmLtndewD0xs+nHEjKyC2NHOMrK3X7VKO6VHFu0UpJtpKMD+8mlz
         i1JU89y1JDaR+uD8pow5UVlWDJ3BjX6xbpUe2K+pg742bncqnObgI2sS5v9mqw6cQOkw
         NAf0Rr4JOuHghBduyXrL7gYSk+2g9b/I+c4ek3y61MKV9ZyHan0BdBoVkbv44rqhX+zZ
         0ATEuNj4N5D/sFlQ54VJen10Hdqrcy4hEqwOLXbMzwbkisBfyr0S0D74WkwCNZWKHog0
         /SZwvydCwonvEl7xhaV9ls5wzO/8+7mGbzgQD3eCJlTOgRxdmHuWTf3AcJ5cTTbVDwd8
         s/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724078666; x=1724683466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zb6F0HNbTZX23uf0i9iclKqAAe/JFVipCwV1qTRY4HE=;
        b=kTKWULe9Ahny3IK12Ze0pPpUbHZ+mNEyrHPv5VpsWGhoJKJP+ZpZCjC/alOfTBUOoV
         LlWpoY9Hz6RX+68b5995Xl6UQLZWoINsUcy6ZHPwBDZdkvrgygalYH9JhQoQWiynLEUw
         eO4cuy0XW1NFl+5wtMexxPfs+7nMiUP9ExYej15N10RiTSq6ol3I/DEM+2aAmc3TKKFN
         zuv8bXFq1tPHCt/kkjdh0ciSxuyGmSYE+LNKk47OpIapY+KQL5pJak/7a1a7TW3YvP5b
         kaeND4kjk/Ix4CScqZTCkqzGkV3dofMklqg7NwrxyewovrPC/HZa444WBLetOiaOd0J5
         yQ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmrrNjdYJYSJI+4PrhnV+1eMEUDkvEywKKq5wm6Vi03v5Y0lIeuOZRMmamK3bfgRxf0XsW24cFCWuZrh+263rVmJycMbu61YZQ97eMTMluGbRbucYbXMm/7Y+cTgVD0v5kaL66
X-Gm-Message-State: AOJu0Yy0SukQaOFgBhJjWQq0iut5HjFkfeRoj5nlSHFfIVbdydLcgysq
	4xKTzIK/5ZgNFO/XztTMj4j/dLLhHxouNPQP3YgiRyLndesShUxA
X-Google-Smtp-Source: AGHT+IHov3eos8LRePbZ0LJRgiJq+qG+pDNhA/L7pQm6KabReb1rCRtTCC8EcKnbLVQqHpztFqwGAg==
X-Received: by 2002:a05:6402:1913:b0:5be:d7d8:49ad with SMTP id 4fb4d7f45d1cf-5bed7d84a88mr6401079a12.22.1724078665096;
        Mon, 19 Aug 2024 07:44:25 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f92dsm5625433a12.60.2024.08.19.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 07:44:24 -0700 (PDT)
Date: Mon, 19 Aug 2024 17:44:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pieter <vtpieter@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
Message-ID: <20240819144422.fxop5fkg4ruoqh43@skbuf>
References: <20240819104112.gi2egnjbf3b67scu@skbuf>
 <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch>
 <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
 <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch>
 <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>
 <20240819140536.f33prrex2n3ifi7i@skbuf>
 <CAHvy4AqRbsjvU4mtRXHuu6dvPCgGfvZUUiDc3OPbk_PtdNBpPg@mail.gmail.com>
 <a45ef0cf-068e-4535-8857-fbea25603f32@lunn.ch>
 <CAHvy4ArnEy+28xO3_m6EPFQxOKR1cJNkWLEVbx6JFBzLj6VMUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHvy4ArnEy+28xO3_m6EPFQxOKR1cJNkWLEVbx6JFBzLj6VMUg@mail.gmail.com>

On Mon, Aug 19, 2024 at 04:41:29PM +0200, Pieter wrote:
> Hi Andrew, Vladimir,
> thanks for your explanation and patience!
> 
> It works as you said, I will have to do some changes to userspace to
> ensure the DHCP client uses br0 instead of eth0 but that's it.
> I just tried and br0 obtains the IP address and all is good, with
> DSA tagging enabled.
> 
> This patch can be dropped, sorry for the hassle.

I'm pretty baffled. Was this unclear from the user documentation at:
https://www.kernel.org/doc/html/next/networking/dsa/configuration.html
? Maybe we should change something to make it more clear that this is
what is expected.

