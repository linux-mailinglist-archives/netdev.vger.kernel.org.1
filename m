Return-Path: <netdev+bounces-223938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BBEB7D8DA
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FA53AF96E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5905D34A330;
	Wed, 17 Sep 2025 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl6Cvxtk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9C2F9DA4
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103371; cv=none; b=nWhHB7L/UJDg6wNQNq1aMd1FH2eOKentB69JQZjDdmue3rBHQklYG6likMlBnbpeil6sIVfXQvuhbeLPwawmWuKc99V82NRnAfjWSeEf627TJRGD9OaO5WbqBy4w4+ud8vzD1HIAhMAIAThb/zsjPgevoL5sHj5QtdMIrbNkarE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103371; c=relaxed/simple;
	bh=eitIgTv7GwxROzOoX6w5BE9GZOWDF3FR13hWKajvlBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHSOmoSJxdp6P4aBfYPAyIV3eHh1IrhuolJrqKfbs5AEfebI939lWupDvJuKHewHDBNiaAHJieFFKp1F3Wgo/axFjtXF8mbXsb9Ziba6sTIzE16aotuNVZ2l8jA9RaoXVxtyAsI5NK7BjOMyDzRYBuIUfDaNqtKL/aWcHgoCtOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kl6Cvxtk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45ddfe0b66dso13736325e9.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 03:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758103367; x=1758708167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmvDAXhB3YF18ndychtadEGtlpqabkSgHGl2UaFJHtM=;
        b=kl6CvxtkecGBAh1D2JdlnjOoyqB/nSK6+59G2lwOk/LBUsFcSffxAUTJaYmSMVl7GV
         +SVTO2RA3Pk1Jr45MZzzb0F2vbGUUqComRCBW02TMjHXVRIJQbFTR35otOQ80g1kYQPo
         qSefXdDdt3R+eTs24fANfyvo/m+jusMkEpqMOraMZJid2pWbKxm6GUjklJq5ejgWOD2+
         7vV5Jsqv8LlB/bCedcDTwCBkD/KoYuZcMhR17yjCrgNDlNIfUpX0sAiT06mXKi2eK6Fi
         g+oOxrKgwhEGEwqFMSObiytXsxRiwS56JKPhHA3t4xNcizBYlbtKbf7Y8CaUU5KlrrRM
         vQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103367; x=1758708167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmvDAXhB3YF18ndychtadEGtlpqabkSgHGl2UaFJHtM=;
        b=TXwtrgFlENDr1s2myd9dyjkPjpuHI4A/lp9C4rPCLIHTiOmG+cXwRhKEX2mT8aBGWy
         N8SzMbkilc9NxdWAIuSMGEWHsXqT1kSExX5KdBjGyWJQULC5rl51/E01Es8slTuEKFlj
         0akV5gZYKO/J7/STDP4JghJzY2we9M4sP3A7LKW/5y+YemMlJl4or3qVBE4AmJXyXGxt
         YdjV/qFROfnsUKlqT1AJTIYI8f1TkBm20hF/gYJklOxCk4RihP9bvIQYPdR9cWrjkGnh
         cX3DJGeM+es4iTbAD4hj9zLKmlQNH4aSPFsExRMgw9Zl8R6yaJQvFs6H+fyF/W00EiQ7
         mIjg==
X-Forwarded-Encrypted: i=1; AJvYcCU182YCxCnQDuhL0C0ko8d3ryqCJ2vcuspkCbWTSROBgW/F8Y12YLlgurdE+fv2llq75QNM+Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWHJcQNZjFEEP+CYRYe0bL1MUiy/P1cyVmN8jyS3F1vKh5dj0X
	jKTfiVXLoR1/d5Rmnb45stk1UL+6nl9IzcnbIl1Q6/bWhtn1fVMauLZ4
X-Gm-Gg: ASbGncuKSxJLmw/HqlK2wjvBxBzhJ597LGB/M+fgfI0fgrrqmXija3r6p/w3hNLGWNW
	oHzYmjoOkry/0doY+mE2i3EXgfvx3VFSR6lHpYnHmHedfeyX7oRuymLf4KTCHJWYswnvFv/gGxp
	3QH+3xmmKBZA9eW5Vy0JUCoWOSGYf41WAg/XdqoUvATKv6iyDFH17j3/Rqq8CXzowY3Z0YaJz7t
	eDgOFLLAhYL2BKcbtCnuSaKp881BFs+JC53VZqbfV9dNphUTSXvLOaF3nt+7AQB2Iq7ZlxBiJhc
	9QF0aZIUvNAMT1m2ytVvV1jgZJWtA6HkwWxw9lreonkBuPrIYclcQBRUPbnFHnl0Ar8fErrMgch
	yQgwbFFsbG5brTyY=
X-Google-Smtp-Source: AGHT+IEJSD+XRqxq7Nyy97GWdJgdPxBloPmolF7AIID/h3YZTxRJteo3lDDYW9w4cvIOkM3qFATA5Q==
X-Received: by 2002:a05:600c:3555:b0:45d:d401:2777 with SMTP id 5b1f17b1804b1-462024532c8mr7748625e9.2.1758103366267;
        Wed, 17 Sep 2025 03:02:46 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e80da7f335sm18935412f8f.8.2025.09.17.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:02:45 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:02:43 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <20250917100243.s55irruj4bzg343v@skbuf>
References: <20250913044404.63641-1-mmyangfl@gmail.com>
 <20250913044404.63641-4-mmyangfl@gmail.com>
 <20250916231714.7cg5zgpnxj6qmg3d@skbuf>
 <b0fc2de5-bccc-4ef8-a04d-0c3b13cde914@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0fc2de5-bccc-4ef8-a04d-0c3b13cde914@lunn.ch>

On Wed, Sep 17, 2025 at 02:08:31AM +0200, Andrew Lunn wrote:
> > > +static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
> > > +{
> > > +	struct yt921x_reg_mdio *mdio = context;
> > > +	struct mii_bus *bus = mdio->bus;
> > > +	int addr = mdio->addr;
> > > +	u32 reg_addr;
> > > +	u32 reg_data;
> > > +	u32 val;
> > > +	int res;
> > > +
> > > +	/* Hold the mdio bus lock to avoid (un)locking for 4 times */
> > > +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> > 
> > Andrew, are you satisfied with this lock?
> 
> This is O.K. You snipped too much context. As the comment says, the
> code is about to do 4 MDIO bus transactions. Each will take and
> release the lock. By taking it now, and then using the unlocked
> version for read/write, it will make it a tiny bit faster. The time to
> do the bus transaction will however dominate.
> 
> > Perhaps I missed some part of
> > the conversation, but didn't you say "leave the mdio lock alone"?
> 
> Yes, i did, but then the mdio lock was being abused as a DSA driver
> lock. The DSA driver now has its own lock. So what we see above is
> purely an optimisation, not a locking scheme.
> 
> 	Andrew

Ok, I misunderstood the reason for your comment to leave the MDIO lock
alone. Acquiring &bus->mdio_lock I can agree with, regardless of whether
the "driver lock" exists. I'm currently reviewing drivers/mfd/airoha-an8855.c
and it handles this the same way.

I'm not sure that a "driver lock" is something that drivers need.
In this case it creates a lot of red tape. Function yt921x_dsa_X() takes
the driver lock and calls function yt921x_X() which does the work.
IMO that's part of what gives "vendor crap" drivers their name, when
there's no reason behind it.

