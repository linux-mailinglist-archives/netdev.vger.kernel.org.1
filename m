Return-Path: <netdev+bounces-119756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CBB956DB3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1409F283397
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000F172BCC;
	Mon, 19 Aug 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYW/3GRb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1E171E5A;
	Mon, 19 Aug 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078504; cv=none; b=f2mZ/2kpCTwL84mnwAXpB5SN7Ma1k8o+zk6yYpNwHl8R3WfrejjZKOx+sUxQZ9/nDaxz1swHE22Cxa0ob4aITq3l2do1pMJOvVxAzqs65Mc0oM5/ZH+kW3Jfb8+F+NOuYsKE1YWyJeoWHwgbVGVgZjnWldzgRX6szXNk+vE/jY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078504; c=relaxed/simple;
	bh=EeyrAxH4iUIpbR5rG8574I5rRH/rohJmKW6fVAzzb+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMqzyERvGT/4yqU3QoEd5RkdOlnX74og/mdL9fse5dM6J1O0/2za4E0FiTm4mKdLu+3CpFJC+yZW44lSovA+52I8ip804m6gN/Wbha0fF9kENXHQihn1M7nWRdbUwZR0qpiUvOZzJT18DgwFZua//O6Tc9VklUVJUhjy+rkRYrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYW/3GRb; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5b850d969so2758812eaf.0;
        Mon, 19 Aug 2024 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724078502; x=1724683302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EzJuUirV19NWzxmbHovNe/sp8Sb2oe3iPgDc4AhYD8c=;
        b=WYW/3GRbu7sSsDfs1VVGR0ezZWu6JWkNhWU9NT0xbdvtGZSKslSiIZinAvORYDXdD4
         6+9WKtiOq6phNOqnll/SXLjx1Lc/dkd65RFLtxk4hQLvJ0iYik3BUrJEQwsNoru7UB90
         2neKD3rhoEdTqw1TQTxg63TgeZU/9cGJZnA2RfrTIqqvrapebdLyBeOGrfu/U3TXtGYw
         2S9J3BRLfYRjjrxYtfuS+NDru8618sgt0VYAfhGHm5IOPdHgWzm0u5VFmFIjarm5PKj4
         Ku/e3r1w1TDYTlUfGbYr45eStr51wK5pvmfSpoaY2fHuQkkzkNMGpqgoaGJqEPnu7W2J
         Wcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724078502; x=1724683302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzJuUirV19NWzxmbHovNe/sp8Sb2oe3iPgDc4AhYD8c=;
        b=XaocH+AfEVThEVceJuBBPY8BXCOjXpoMEQGcoi/jjOF1+bmp3e69R0hQpce40RaxwM
         +mNsZNMX0ZFTVtZyb+w1pkoe6HxORZm8d9uVofhUMVwmB0Lwop8OiVV2i33/41h1JtYo
         URgUI81FXhGWjHUnFuwgtSrNG941ArGf3JTW91Mya1w8g/B0hGYuXHZtW7Mz39CIxt2G
         Z3CH5DRgiHzbxEY5rr/M1u4rBtjfXT8f2aqi7kMWmwNQCLzsrvYhRfjE1R4d62P0GGY6
         bUXi0lREFBk9piMpqW4ObZaPJOCFdCokXuQ1TCJlqJhnk8pPRWwVme9WKne2OeX91yK1
         nzyA==
X-Forwarded-Encrypted: i=1; AJvYcCUTA1QqfiWDn35GWT2O4f98vd7ZcL9f3ngeYnP+HOvrbhjZJ45EGvCGo+R3DjkrQfZQNHgmaqFLuQx1o1udLgCXbBR6A7WapL1bHncFnX5t4KaYfFeZmJVTk0i60x+FcXotzP9K
X-Gm-Message-State: AOJu0Yzz6G/ucuCxNCoiJ7ZxgmNEkxt5TeXcY4Xu9w7bHde7cwkVHP/Z
	SXc6ulg9vF4FtY5XAQ5CArcjVaLYyoJI+VPHsXKGbBbRPPvsft0WyHu/708zj3gQw4pgqUWEBmZ
	oWN3zF2SBNQfL6ZwcaIaNmAHOFXI=
X-Google-Smtp-Source: AGHT+IEiSS1aBk7awFzvqhgY+/kZgvOW2fg9lcMANK9MggJ0Pj5sirtKm9OgJMZ38AQUDSa4/7MPMp77od6Uft3WrLs=
X-Received: by 2002:a05:6820:16a8:b0:5d5:d718:1b7f with SMTP id
 006d021491bc7-5da97f5a925mr10394790eaf.1.1724078502087; Mon, 19 Aug 2024
 07:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819101238.1570176-1-vtpieter@gmail.com> <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf> <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch> <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
 <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch> <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>
 <20240819140536.f33prrex2n3ifi7i@skbuf> <CAHvy4AqRbsjvU4mtRXHuu6dvPCgGfvZUUiDc3OPbk_PtdNBpPg@mail.gmail.com>
 <a45ef0cf-068e-4535-8857-fbea25603f32@lunn.ch>
In-Reply-To: <a45ef0cf-068e-4535-8857-fbea25603f32@lunn.ch>
From: Pieter <vtpieter@gmail.com>
Date: Mon, 19 Aug 2024 16:41:29 +0200
Message-ID: <CAHvy4ArnEy+28xO3_m6EPFQxOKR1cJNkWLEVbx6JFBzLj6VMUg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, 
	UNGLinuxDriver@microchip.com, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > On Mon, Aug 19, 2024 at 03:43:42PM +0200, Pieter wrote:
> > > > Right so I'm managing it but I don't care from which port the packets
> > > > originate, so I could disable the tagging in my case.
> > > >
> > > > My problem is that with tagging enabled, I cannot use the DSA conduit
> > > > interface as a regular one to open sockets etc.
> > >
> > > Open the socket on the bridge interface then?
> >
> > Assuming this works, how to tell all user space programs to use br0 instead
> > of eth0?
>
> How did you tell userspace to use eth0?
>
> In general, you don't tell userspace anything about interfaces. You
> open a client socket to a destination IP address, and the kernel
> routing tables are used to determine the egress interface. In general,
> it will use a public scope IP address from that interface as the
> source address.

Hi Andrew, Vladimir,
thanks for your explanation and patience!

It works as you said, I will have to do some changes to userspace to
ensure the DHCP client uses br0 instead of eth0 but that's it.
I just tried and br0 obtains the IP address and all is good, with
DSA tagging enabled.

This patch can be dropped, sorry for the hassle.

> The conduit interface should not have an IP address, its just
> plumbing, but not otherwise used. Your IP address is on br0, so by
> default the kernel will use the IP address from it.
>
>         Andrew
>

