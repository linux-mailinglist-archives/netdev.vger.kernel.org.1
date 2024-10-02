Return-Path: <netdev+bounces-131388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 559AD98E682
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50211F229D0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6370219CC03;
	Wed,  2 Oct 2024 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaSsXceB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1019AD5C
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909795; cv=none; b=p6oJrko+Y8EV0HUNITlyZeGAuHaE9khLpvzp6AA0VVYqBXooKiBsS+9AcdSSDyrtAqowsXvzOrZ3Iy40mF28WJ4cEfkMAigJf9y+GZyjyjfa4xTLbjJPglhQMsc2BbvE0IY/vCF3J381/6SmeF3ggRYQHcxBeGmzSynXHm3b9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909795; c=relaxed/simple;
	bh=P0iRrE8fW9CVgyX29nxmYqPZ9fE0kIbyZau1Dqo80p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouX/xyft0kHJR0HqEpo9rXrVN/pzi3PnPigbacCp4N/CS1aXJYPjwEa8xdP/T/cuvblpCJXcZ2njH/J/50uYNik4tPLT2owhN+X2rBaF9MA0isJaDnL+vdiN3L6zSjatjBTCZwFao9dcI0f5yIspC++im+KneI6UPe7bMowOBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaSsXceB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cd3419937so192707f8f.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 15:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727909792; x=1728514592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9nNJHMJzZa//MtYTMs/NP3fiF/jicWlbNBLj+9FqAg=;
        b=MaSsXceBlJi9JDn5eqSsLl84so4GJoyqR7MIr04vrWXO55BC5UgSzyZ9uXugwUoYG5
         wtIb54prnjASxUEiFqFfnASUklQ/7D0pqoN4vxVVUEJFRvY652z4asOZQP3FbqdcXRfv
         SRRo7cMnIVsOiAaJ7TV7A/RTAuZr9432opPEwfzC8m9CUHdvPh6vwoabtw1fpNO9l2/8
         X+VVmjtTM/cWz6yokV8mwyvSkJSDR6dFUHhQskFoaiL3RJ8DI+2hZT6bRRFjzDc4hkzm
         J6zBZlNuHkzznlKYUEUAxItzocbYl6DRVjoBNANrQjZYifGvZ7lOFVmWHhhsZUm17BVE
         LJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727909792; x=1728514592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9nNJHMJzZa//MtYTMs/NP3fiF/jicWlbNBLj+9FqAg=;
        b=pQnN8CUBq+rLrcezx0OLjcARSz7g6T5iEVF7ghGVpYtcYLdgImRE7bFsO0OUVbmbf/
         SLn3GV0+M22LijZjqQR11xresp91c/cK9M6y0qVDrSPM0FwBH25FCZaW1moeglcg36CP
         gXbSm8hybkj3RtGBa3eS2b40jRuysmBAtZZo5GwPlGdYzBJdcBK74z/od6MXX84pN3wz
         vDsswvo1cchVp3XYwTnqQ3JDfFFihja7ENOQTs3rP8u73vMDKiDHD8aT4D+//lWFy2pr
         7hgakcmVEWnFjVC4SSAo3pHUBqv/g/sEULBBAoEUcIxXD8CFMcICFqDd/J+u06ycM8a6
         XvKA==
X-Forwarded-Encrypted: i=1; AJvYcCWfl2QGI7NM+cSPcPf03Zkvp8En3a58TaokAb8fd3WdrvF7Pe6nZfPJWPlCMxePAm+ZyCQIH/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xiKQr86QJ/6U9vaJ+Ias1qCAcw3okRVNQo/uxGu3NQKPiac0
	6aUbBGak3zxFshdJk3e64Opva2UEgE9tL39cggmrkO4rO+cw7DUR
X-Google-Smtp-Source: AGHT+IE427cWTEeq2+pHLe15Z/pWV/cuH7qlt4Cfgx04Usxy8O4WLti3cilzlGBc9RTaaecACAAsvA==
X-Received: by 2002:adf:eb8b:0:b0:37c:cd57:d91a with SMTP id ffacd0b85a97d-37cfb8b63b3mr2564996f8f.12.1727909791457;
        Wed, 02 Oct 2024 15:56:31 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e62d5sm14773143f8f.57.2024.10.02.15.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:56:30 -0700 (PDT)
Date: Thu, 3 Oct 2024 01:56:27 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <pm7v7x2ttdkjygakcjjbjae764ezagf4jujn26xnk7driykbu3@hfh4lwpfuowk>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
 <E1svfMA-005ZI3-Va@rmk-PC.armlinux.org.uk>
 <fp2h6mc2346egjtcshek4jvykzklu55cbzly3sj3zxhy6sfblj@waakp6lr6u5t>
 <ZvxxJWCTD4PgoMwb@shell.armlinux.org.uk>
 <68bc05c2-6904-4d33-866f-c828dde43dff@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68bc05c2-6904-4d33-866f-c828dde43dff@lunn.ch>

On Wed, Oct 02, 2024 at 12:09:22AM GMT, Andrew Lunn wrote:
> > I'm wondering why we seem to be having a communication issue here.

No communication issue. I just didn't find the discussion over with
all the aspects clarified. That's why I've got back to the topic here.

> > 
> > I'm not sure which part of "keeping the functional changes to a
> > minimum for a cleanup series" you're not understanding. This is
> > one of the basics for kernel development... and given that you're
> > effectively maintaining stmmac, it's something you _should_ know.
> > 
> > So no, I'm going to outright refuse to merge your patch in to this
> > series, because as I see it, it would be wrong to do so. This is
> > a _cleanup_ series, not a functional change series, and what you're
> > proposing _changes_ the _way_ reset happens in this driver beyond
> > the minimum that is required for this cleanup. It's introducing a
> > completely _new_ way of writing to the devices registers to do
> > the reset that's different.
> 
> I have to agree with Russell. Cleanups should be as simple as
> possible, and hopefully obviously correct. They should be low risk.

In general as a thing in itself with no better option to improve the
code logic I agree, it should be kept simple. But since the cleanups
normally land to net-next, and seeing the patch set still implies some
level of the functional change, I don't see much problem with adding a
one more change to simplify the driver logic, decrease the level
of cohesions (by eliminating the PHY-interface passing to the
soft-reset method) and avoid some unneeded change in this patch set.
Yes, my patch adds some amount of functional change, but is that that
a big problem if both this series and my patch (set) are going to land
in net-next anyway, and probably with a little time-lag?

Here what we'll see in the commits-tree if my patch is applied as a
pre-requisite one of this series:

1.0 Serge: net: pcs: xpcs: Drop compat arg from soft-reset method
- 1.1 Russell: net: pcs: xpcs: move PCS reset to .pcs_pre_config()
* This patch won't be needed since the PHY-interface will be no
  longer used for the soft-reset to be performed.
1.2 Russell: net: pcs: xpcs: drop interface argument from internal functions
- 1.3 net: pcs: xpcs: get rid of xpcs_init_iface()
* This patch won't be applicable since the xpcs_init_iface() method
  will be still utilized for the basic dw_xpcs initializations and the
  controller soft-resetting.
...
1.1x Serge: my series rebased onto the Russell' patch set

Here is what we'll see in the git-tree if my patch left omitted in
this patch set:

2.1 Russell: net: pcs: xpcs: move PCS reset to .pcs_pre_config()
2.2 Russell: net: pcs: xpcs: drop interface argument from internal functions
2.3 Russell: net: pcs: xpcs: get rid of xpcs_init_iface()
...
2.1x Serge: net: pcs: xpcs: Drop compat arg from soft-reset method
+ 2.1y Serge: net: pcs: xpcs: Get back xpcs_init_iface()
* Since the PHY-interface is no longer required for the XPCS soft-resetting
  I'll move the basic dw_xpcs initializations to the xpcs_init_iface()
  in order to simplify the driver logic by consolidating the initial
  setups at the early XPCS-setup stage. This will basically mean to
  revert the Russell' patches 2.1 and 2.3.
2.1z Serge: the rest of my series rebased onto the Russell' patch set

> 
> Lets do all the simple cleanups first. Later we can consider more
> invasive and risky changes.

Based on all the considerations above I still think that option 1.
described above looks better since it decreases the changes volume
in general and decreases the number of patches (by three actually),
conserves the changes linearity.

But if my reasoning haven't been persuasive enough anyway, then fine by
me. I'll just add a new patch (as described in 2.1y) to my series.
But please be ready that it will look as a reversion of the Russell'
patches 2.1 and 2.3.

-Serge(y)

> 
> 	Andrew

