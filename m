Return-Path: <netdev+bounces-108858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFE59260FD
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35AB6B21379
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC1917334F;
	Wed,  3 Jul 2024 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXMISsik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9001E4A9
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011492; cv=none; b=uNGQrf7WUySsgVJvfZPRpaGDbMC2YXX1xM3VtkbJLqNLz02wMMuG4IZ/pBGcQAJywfVNkgObQtPOHowfJNUbRaIiqpL8htQBTMgGvaYs5tRHwls775PlRtQ02b8sUCnD2z/caxy3RwVm1XPCNZbkSUFX/adBwZBQVcZnBa6GZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011492; c=relaxed/simple;
	bh=AY5W4wRU7EgGuEN7NQ19JHhpswBkigcgo+Tsk+a9yFY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DZNi5zZIUPfaHxb4u13p7vW2YXmk+gmBoEsI9LktF7gKr23p4GiurnbnNH/ZKG01H0385Ff382CpOobqFsNvCUBel2eJWLl4Hv4tvcLahmTmsNkcqG+DIFQiCxx3HE7jGl1+ImvzjdCw/JF2GDNmp1Xu388WfjCBMUH1jML1yV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXMISsik; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c87a7df96eso856567a91.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720011490; x=1720616290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXVFIiIUYfoxHdro42xuevo9niN2lvAoiBpgZ+TRXR0=;
        b=CXMISsik3/pqA2Fu7f3GcxN+d7o0281e959IPt/sEqGPuEitU+fPaWXirdv8cUMpE4
         W3No24DkJQd2RP6dFIRHMJlXZea0dZJReeCUsYk+u3ZctaYwT5ZyieDFhgc9zHwZmIGF
         ib56ZR8LJUox2luBCFqFLjG5laZYSOcObuqiTTzIiErfLI6qFl4cFUKzAOW0scjkwZrk
         ifAPVYheaS5H57jmjzv9gjL54ZnrblCA6ad5GwO+MzI0CaOMSjSdVGT3bAtINITD/Beo
         uPcUxz61KkkEUCoMNPHw+65nrZXPSwRAp3QCJ1j+Y+AZWBUkfhb7Z6DqMGRgJIPeUgjh
         p3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720011490; x=1720616290;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fXVFIiIUYfoxHdro42xuevo9niN2lvAoiBpgZ+TRXR0=;
        b=KMQwLQRWSfClmB1Adby3LN43zfsUdgecXz0v3L+ogkpIqX7wqQ07ViutEpl5hLXrJI
         JlVHgOeQmhAwzQr4F40uMUh3mIh7RYwPwrt6rNVkIqeIQ29mcGoIXbIQrdQWt1x3md9C
         DqOUREUIKJVSiAFe6vfRzljpw8GtItEEiASChvpGWRR8otv6B+hmrVDGR5xXeKoAdlBp
         Gvu15eglDKI4gLoTDxRuI1oN1HAdpfpCA4I8bk0QxGY8C5Mdg6ykl9XJiw60iqIz4Ai2
         YBrzLspcnsdHJd3AQH/qF7brK6z3vTOCb2+b35fJ2w7qnsImwHpu1q70BiHAOPaI1xr5
         +apw==
X-Forwarded-Encrypted: i=1; AJvYcCX0JgSRjGgPcoOZQhoANlLCkRl4DpWbHXm5J2wgtqGD5GfE66aZSScLX/vM0h0h+mdQi3J/cK5032jlb2NU8xliKpjiBIWj
X-Gm-Message-State: AOJu0Yz+GkBkRcW4thy21uiNJtKC8+ByC+/SOdKN0byB00U/olwbGNME
	NVs0OdaxeRIcGQ4eO9/mnS+DIN1ST15RruZvkS43Q13gY93AuU1AFPl/a0WG
X-Google-Smtp-Source: AGHT+IHS3qaCeUDqW4aAKfnWBxI/J39cLSGL3LWKc267YYQI2vGq/bCbnHM2EVv+M/2Q/LtToXQJ7w==
X-Received: by 2002:a17:90b:68c:b0:2c9:36d3:8934 with SMTP id 98e67ed59e1d1-2c93d6deab4mr11789441a91.1.1720011490299;
        Wed, 03 Jul 2024 05:58:10 -0700 (PDT)
Received: from localhost (p5199240-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.11.99.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc5a1sm10654460a91.36.2024.07.03.05.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:58:09 -0700 (PDT)
Date: Wed, 03 Jul 2024 21:57:28 +0900 (JST)
Message-Id: <20240703.215728.957684876602887757.fujita.tomonori@gmail.com>
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next] net: tn40xx: add initial ethtool_ops support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Zn7afU9DiotL92jZ@shell.armlinux.org.uk>
References: <20240628134116.120209-1-fujita.tomonori@gmail.com>
	<fe33e69d-a17b-4afd-a5e5-1e1539e6572c@lunn.ch>
	<Zn7afU9DiotL92jZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 16:45:01 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

>> > +static int tn40_ethtool_get_link_ksettings(struct net_device *ndev,
>> > +					   struct ethtool_link_ksettings *cmd)
>> > +{
>> > +	struct tn40_priv *priv = netdev_priv(ndev);
>> > +
>> > +	return phylink_ethtool_ksettings_get(priv->phylink, cmd);
>> > +}
>> 
>> Have you tried implementing tn40_ethtool_set_link_ksettings() in the
>> same way?
> 
> I did think about commenting on that, and the [sg]et_pauseparam
> methods as well, but when one realises that the driver only supports
> one speed and duplex (10G FD) but no pause it didn't seem to make
> sense.

I have not been able to find register configuration to make
1000Base-SX work with QT2025 PHY.

> Not having pause effectively rules out pause-frame rate adaption
> by the PHY, so the PHY probably only supports 10G link speeds,
> and if I remember correctly, 10GBASE-T requires autoneg.

I suppose that the HW supports pause because a register named
regPAUSE_QUANT is set up during initialization. But the original
driver doesn't support [sg]et_pauseparam or give the details.

> The autonegotiation specification was improved in the 1998 release of
> IEEE 802.3. This was followed by the release of the IEEE 802.3ab Gigabit
> Ethernet standard in 1999 which specified mandatory autonegotiation for
> 1000BASE-T. Autonegotiation is also mandatory for 1000BASE-TX and
> 10GBASE-T implementations.
> 
> which is loose language - "mandatory autonegotiation" does that refer
> to support for auto-negotiation or require auto-negotiation to be
> always enabled?
> 
> We're already seeing some PHYs from some manufacturers that seem to be
> following the "require auto-negotiation to be always enabled".
> 
> So why have I gone down what seems to be an unrelated rabbit hole?
> 
> If tn40 is connected to a 10GBASE-T PHY, implementing the
> set_link_ksettings() method would give the user control over whether AN
> is used on the media side.
>
> If 802.3 requires AN to be supported but is not necessarily enabled,
> then there is use in exposing the set_link_ksettings() method.
> 
> If 802.3 requires AN to be supproted and always enabled, then
> implementing set_link_ksettings() in this case would not provide any
> value.

I've read your comment on stmmac patch:

https://lore.kernel.org/netdev/ZoQX1bqtJI2Zd9qH@shell.armlinux.org.uk/

When implementing BASE-T PHY support for tn40 driver, I'll check the
situation again.

Thanks a lot!

