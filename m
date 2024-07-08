Return-Path: <netdev+bounces-109917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7126392A45E
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B811C21A5B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4CF13C69B;
	Mon,  8 Jul 2024 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9hflAOS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794CB13C3D2;
	Mon,  8 Jul 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448047; cv=none; b=IsLlSpLPLO3Nv/8e/uf8gQ9k3DEHrp+0KZE/JHl0CtsQ8ck+zTnXfhGo+bVcXoRTdAI05ZXPS4ENucSotjkAPhLL5huUA+ppRiXPi90m/R69/JlLOZTMdPjAb/71dscM+xEwWJSXRW9a1NDBUGO628jkKFIvI7fIxr9BAOqlskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448047; c=relaxed/simple;
	bh=7ag2vUUkNiiqzEIw5G9KKqVlh8v0Rj9Ng1deqOVj9rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyfqhuLKIHu74jVNXi5/XJZ3y0DGByLNZTDmPxz2BjhVeuB62CdTIisR0ly+M8h+lJZIa7ceDwy8LjAAg6CkHBy+vxoLBTde93X/2J1CSpDwWKSySsbpgVmxOMOamvpF1ziz4AY3oZFDbJMHsFkiyI7qyShrvagF2BrQsTtirPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9hflAOS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4265b7514fcso14626435e9.1;
        Mon, 08 Jul 2024 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720448044; x=1721052844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvZGRxwOuoxAgqAvDBjxYmKyF/+4Ihq85ZsbxBLBQsE=;
        b=W9hflAOSYnGJyO0ZrX1VVuZ5CZQSSLxqkPBBFcbJnt/YxPL93pOqk8UpRdxYTvx4Fj
         zlJ9C2WWrZflB2JKAYo+8DPolhorU7k7NOtxF6l7INhKeAxMs4aiAPeo/ICtLYI4hRsR
         OO3N0rFLXxGIdIXR46vLUftmT5YwEdjlbHGKqv5ZCaW1tsCVkuv0T7WOMEaNiixydyE7
         MULB24Mm+8CFJEHI8OAZRA3kLBZT/u5HxdW1/jEn7sIpTcdVXAW9nyWjKFC/joH1g5PK
         9huwMYSMuRWF3M0BBLesfMfcUc34jK7+SS30n++3J0tBvFUI1LDv29ApdhG8kARFYTrL
         q/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720448044; x=1721052844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvZGRxwOuoxAgqAvDBjxYmKyF/+4Ihq85ZsbxBLBQsE=;
        b=v8uWLdF6C/hXr+RWU9A1hmqTAiNnEZjlqqeLghbnqa9QNuTR2BHAbtXSbwpSmJZ+x0
         JqY+Z734tzpcIS5rTSd0kCVrXh/rURyW8EOcIjTqSACDfO/U+x49MaIMlvaAFHOcxfWB
         tvlFdvZteDNgHz9sIF+18GPMm8nvZ6dJlA6AyFKa4oQVEBFeTU9DvqOPdm4UmZsktlZu
         za69ztJNmLrIcOV3S28YSPu31Fv2XqpCm+4zdob9XKO0vGOBF5E0YY9537GnuKfDyT1z
         /XPtthn1cMPST2v9pL+6EOgLmNB1tjBwQrfNjySB5En5j9VxmOBibWRcxotV31cQuFZh
         diFA==
X-Forwarded-Encrypted: i=1; AJvYcCVIAl8aLXvYtSk16uG+FC8Wd2eFuO9CM6Kl/6xqfa7VYo109j/C3+tWVWt3MuJ5h6QN/PsbNRkXEXMc4zJ+GVRZITMSyJ9QUVZ0x3D5KZ+k0AnHO+oEmR43/gVIp0bhjE06sZgx
X-Gm-Message-State: AOJu0Yw86w7ZOLNDww0jyXwgnHkJBxdxzSqH+r6kpWZPUGhkzsp3d8kA
	dnH4kfkRjMwgAsKspW6wAvHYn6KJZxTbEHqUFyd91QNeGkEa6FP2lgqJmRJa
X-Google-Smtp-Source: AGHT+IHdjMaaUIYVHXztXF5gbplIxnDeJktpRWhzhs/msMmg4In6jR6hy4EJse8j2tV5h1ajT0Splg==
X-Received: by 2002:a05:600c:1c98:b0:426:5fa7:b495 with SMTP id 5b1f17b1804b1-4265fa7b6c3mr53157515e9.15.1720448043692;
        Mon, 08 Jul 2024 07:14:03 -0700 (PDT)
Received: from skbuf ([188.25.110.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f07dasm546485e9.12.2024.07.08.07.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:14:03 -0700 (PDT)
Date: Mon, 8 Jul 2024 17:14:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	"ericwouds@gmail.com" <ericwouds@gmail.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"justinstitt@google.com" <justinstitt@google.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sander@svanheule.net" <sander@svanheule.net>
Subject: Re: net: dsa: Realtek switch drivers
Message-ID: <20240708141400.xbuor67hnnkxyigh@skbuf>
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
 <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
 <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com>
 <b15b15ce-ae24-4e04-83ab-87017226f558@alliedtelesis.co.nz>
 <c19eb8d0-f89b-4909-bf14-dfffcdc7c1a6@lunn.ch>
 <c8132fc9-37e2-42c3-8e6b-fbe88cc2d633@alliedtelesis.co.nz>
 <65566aaa-ba49-4ad9-ab3f-9d49780a809b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65566aaa-ba49-4ad9-ab3f-9d49780a809b@lunn.ch>

On Wed, Jul 03, 2024 at 05:39:49AM +0200, Andrew Lunn wrote:
> > One reason for using DSAI've just found is that in theory the RTL930x
> > supports a CPU disabled mode where you do connect it to an external CPU and
> > the data travels over SGMII like you'd get with a traditional DSA design.
> > It's not a mode I'm planning on supporting anytime soon but it might come up
> > when I get round to submitting some patches.
> 
> You might want to look at ocelot, which is both a pure switchdev and a
> DSA driver. Its design is not great because it became dual later in
> its life. I suspect it would be designed differently if this has been
> considered at the beginning.
> 
> 	   Andrew

Another thing to consider is that you might want to join efforts with
Bootlin who had a similar (and still unresolved) issue with ipqess/qca8k.
See some of the feedback that they received.
https://lore.kernel.org/netdev/20231116215645.3ex4yp36hrrm4uti@skbuf/

In short, I am in principle in favor of extracting core stuff out of
DSA into a more generic 'eth switch' library which is frontend-agnostic
(this is also what the TODO in Documentation/networking/dsa/dsa.rst is
really about, despite not being very well described). That new framework
would essentially be the things that DSA does well, except for tagging
packets, handling the conduit interface, etc. I just don't have the time
(or incentive, sadly) to do it.

The most advanced switchdev drivers like mlxsw will probably not benefit
from it, because they have their own highly specific use cases, although
most of the rest should, since there is a lot of boilerplate which could
go to common code, and which nobody really likes to re-re-re-write or
re-re-re-review.

