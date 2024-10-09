Return-Path: <netdev+bounces-133376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFD6995BEE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6772828629E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6635A195;
	Wed,  9 Oct 2024 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBRmMhB7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D18F45
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728432177; cv=none; b=hhVFdLniNQL1yniYTaiAWyaz2ujPWzEUwSONIdpm9K0csdEd0YadMP/WxUgfIrxOUHFC/TORoUyA6BEOXAoLeaduSyRvwG5DWEMKQiXl/7JXK2ves8p4he9Q3Tj57eetz/mSg+T1/mBbqib5yQARYVjJLL2p237NIwMAy4RCbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728432177; c=relaxed/simple;
	bh=j/0VhKTGskmJswbxxJ8sN6s4NWZYJwMNh6DtBUIln9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVjZUdcZFHr/f+JaBEWNcLfOUUZ3WO9JPQNZgGiS/NTUyDRXELkk9tLUfGiZh68fCxsOZtK3AhiXVeV1VxggkOSIrR2JwMuGKaQt/JKv2emh/14PFCIPvBK1RmuJReGd+V/N31sSIauAH4cxT87qFj+exyXreaFLQ3OLIw3DXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBRmMhB7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so7708263e87.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 17:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728432173; x=1729036973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxwtbH453mr49OxFcpLGTroCcnxd3uo1nzwIRj8mAjY=;
        b=HBRmMhB7uQkqVOnGK3kCUSpQsdMIqQQRcGTOzlIZHN6t9y6fNOCyc05Wvp8BWeuidk
         KGoN0P8gQcbZmwVm6p/8ZLK3haYfQ+zrA+TGgfym8YhLwIYSALD6I6KRJw84LxbiOt2g
         6LBOF/EUGAg9X5+Hr41F6cN2RBAXefU8TLjpkO7qwRx0rIdKfgghPVWZcTMYP7KhrwVt
         Q8iweNpXZG3SYaDQv7G+Dd0jl10q7g2IuKwWJe5rLLVyNVXurOxVqnialwRTRMT/53XN
         dXqg1XzEVQO+8jxSbTSNWSFXXNbAFKn6lqg43P1tV949RJQkoh1SSzJYwiHt0cHeGnSD
         rwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728432173; x=1729036973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxwtbH453mr49OxFcpLGTroCcnxd3uo1nzwIRj8mAjY=;
        b=LoY8Q7YwyumCsa9drjueqRc3A4ZWcCJdOEDmjvGiINQhTeZ87kYvfPHejNgl7GeTL5
         x8gqAjmQZKt2rmGVKlMnKrqHg/mTDxec38RaIh0Mug/uD9lHR+t3DgWaYmVCAwWqqZV4
         WxrcjMb8E3kQyc0nsivQUv0jA9QDF/bXuzDsVTE7WNglaTYfqlbEi39cKTxWsaj2dF6D
         3pI5IizXRQdsVfwE0wsBlHhgvcfzVQ0apM1Wwr4NutxdfYRoJL16nu5Gp5nxT8AGGG52
         Po7U5lhW9NeLcnC06ph1ovPNLurx3WFwXce2I8Vwy67MfhGeW8kcT0Fyc3XJmMOpB0qK
         RFUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpdw7MHhz0PbmKE0iwOzAnZ0Ofv/iXOFqusuf8LwEvQErb+CWfWSLUwbb3B0XSDMP5uNE4H04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpHxtD1FO+1OWX9fAB9aBTdPT+4WmvgYYsgg7voFK3Zadnw/6
	dP7AA+7Bqp/WN21l5NnTHIOQBqNJ1lCpJycRN/27ox3YBxyuuaCO
X-Google-Smtp-Source: AGHT+IFfScSg3RqS13Zl0PHySDZWYYC+q7HHP6edX40rKGP/tQPnLvRLh2CIs9u4G9RZhlvjAnDbSA==
X-Received: by 2002:ac2:4e08:0:b0:533:46cc:a736 with SMTP id 2adb3069b0e04-539c49481b2mr207653e87.37.1728432173098;
        Tue, 08 Oct 2024 17:02:53 -0700 (PDT)
Received: from mobilestation ([85.249.16.95])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff2346csm1365785e87.210.2024.10.08.17.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:02:51 -0700 (PDT)
Date: Wed, 9 Oct 2024 03:02:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 00/13] net: pcs: xpcs: cleanups batch 2
Message-ID: <rxv7tlvbl57yq62obsqtgr7r4llnb2ejjlaeausfxpdkxgxpyo@kqrgq2hdodts>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
 <vjmounqvfxzqpdsvzs5tzlqv7dfb4z2nect3vmuaohtfm6cn3t@qynqp6zqcd3s>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vjmounqvfxzqpdsvzs5tzlqv7dfb4z2nect3vmuaohtfm6cn3t@qynqp6zqcd3s>

On Sat, Oct 05, 2024 at 02:40:42AM GMT, Serge Semin wrote:
> Hi
> 
> On Fri, Oct 04, 2024 at 11:19:57AM GMT, Russell King (Oracle) wrote:
> > This is the second cleanup series for XPCS.
> > 
> > ...
> 
> If you don't mind I'll test the series out on Monday or Tuesday on the
> next week after my local-tree changes concerning the DW XPCS driver
> are rebased onto it.

As promised just finished rebasing the series onto the kernel 6.12-rc2
and testing it out on the next HW setup:

DW XGMAC <-(XGMII)-> DW XPCS <-(10Gbase-R)-> Marvell 88x2222
<-(10gbase-r)->
SFP+ DAC SFP+
<-(10gbase-r)->
Marvell 88x2222 <-(10gbase-r)-> DW XPCS <-(XGMII)-> DW XGMAC

No problem has been spotted.

Tested-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> -Serge(y)
> 
> > 
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c |   2 +-
> >  drivers/net/pcs/pcs-xpcs-nxp.c                    |  24 +-
> >  drivers/net/pcs/pcs-xpcs-wx.c                     |  56 ++-
> >  drivers/net/pcs/pcs-xpcs.c                        | 445 +++++++++-------------
> >  drivers/net/pcs/pcs-xpcs.h                        |  26 +-
> >  include/linux/pcs/pcs-xpcs.h                      |  19 +-
> >  6 files changed, 237 insertions(+), 335 deletions(-)
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> > 

