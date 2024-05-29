Return-Path: <netdev+bounces-99200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D858D4106
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055601F23772
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 22:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1031C9EB3;
	Wed, 29 May 2024 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvFIlA9u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080816F0E2
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020131; cv=none; b=XdbvYy1MEu9AgxR3erMZzbubEEOacXd2cY0/eItdk9vJqIMKMdepS0pjD2c27wwPlQzKvGfOKrl6JhKtqYljqxqgy/JINH97Pevejb5eFrxhaV+T482FF4EcRN8jNBfWtiGRMZA9uIQd5vkKiDnQsFksk4nuCxBy1hsUQY5MEsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020131; c=relaxed/simple;
	bh=aiEf8aBmKboLgZO4pZajIiK7HATVueIFHDvNi4JomBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpAOrQRl1Fk4GCEeK9hyhRmiCv2ltRNpUJfqyVFYxW4H69g8ZS4Q5/KGN1jt3I1Rd4uVXk728Y/LjwzVEw//3Cr00WuYBO7DTIHQgw5o9K9nLv8qy+XgdpxM3akoUbiO1h7Y/OTY4jpWYBMv9r4BhCjfVbIuKP/bOrDDMM4sAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvFIlA9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717020128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32CzNa62jddabKFggnPjJ1ZOuhMzVDs8eJ1sh3z1xGg=;
	b=MvFIlA9uWid1qFnYbF1rnL4Zv9VVbtk7V8A70nqTD4kFvnrEdYkspx5DOrUIrReuQ8+nsq
	XpMgPyR2Z407qfvExmLJCTwrmuPDxJXVYcjwb3KSHhaAyHU8UM64LnJokRPWJpQLvPmPFF
	cTmosyFKcQo0TJ4qW4zv0YFJKE13/7Q=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-BgpLWlgcNFCBgg7JZojTGw-1; Wed, 29 May 2024 18:02:07 -0400
X-MC-Unique: BgpLWlgcNFCBgg7JZojTGw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-794ab206ad5so20910485a.2
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 15:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717020126; x=1717624926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32CzNa62jddabKFggnPjJ1ZOuhMzVDs8eJ1sh3z1xGg=;
        b=qLQHrZJUg+lTu4h7HIDasHDZ5Kg/zb/XyiShsMNGvFLW2P2nCFz37cx60kJsK4iPPg
         gKqS7Yfxv8Vpv/GgncPWWXf5srqxLVavDmqYlIBMZ1o+J6Dj2sQTNUysKLgJn2MSWpaR
         TXQIzdmkTSWL+j8RD1Pda1RpuXUsO+bS7a0cqORbK2JRLIyewOmKLowQNhXNnWxtb+J0
         o4dlOvpwjjgJUfv8vktTDYQ9RFXlXS6IKWyqslq3r+GcPf9xDZIvuIT+xCEhR29sGQr2
         bJtb7QUE2TuIPCYC/6hlsSkvTzZHGyhCQaSYv+J0c66md87ulvP6Dzgw8mtM4k5LVgmy
         1rFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj41Px1/xZ45whT6IODvfrEs0O2mLkjfasz6wgVOeZ7LL44szWN/T65/1cg5FH9jGWZpcEuV+EBhKaq8VTLf30Iew6sJiR
X-Gm-Message-State: AOJu0YwgLXYln1t539GOJhnlYgRk78/Tyipt5Wghnx2Xtur5oZzaG3TS
	k7Ks4fh4n/etsgmXBvmtwEfC83tQs7pKYvvLdQOhlJ3CHqiJMyxKkaVBwBBfRbgBEmxRzEO3FzM
	jrMFOnnbkchJ41AxX2/hNuN8Gn8lF3ov8UEWhvku4CgC2oqfoiX79ig==
X-Received: by 2002:a05:620a:15b9:b0:792:c473:f645 with SMTP id af79cd13be357-794e9e11ebbmr49437485a.54.1717020126303;
        Wed, 29 May 2024 15:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJFltyeZE22UFFRHWLdfe4j9lK7hQIYxgrXrWxKRxQ+NAs6sdTr1G6ajFGS0Ru7QKzBiG/eA==
X-Received: by 2002:a05:620a:15b9:b0:792:c473:f645 with SMTP id af79cd13be357-794e9e11ebbmr49430685a.54.1717020125523;
        Wed, 29 May 2024 15:02:05 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794c1130acfsm308726185a.129.2024.05.29.15.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:02:05 -0700 (PDT)
Date: Wed, 29 May 2024 17:02:02 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Madalin Bucur <madalin.bucur@nxp.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Sean Anderson <sean.anderson@seco.com>, Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH net-next 0/6] net: phylink: rearrange ovr_an_inband
 support
Message-ID: <7wmrxqrkruuvk3ceqy37gtu23axhm5aun3afi4pfs5lohtzwku@dmedpa32pf6v>
References: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>

On Wed, May 29, 2024 at 02:28:42PM GMT, Russell King (Oracle) wrote:
> Hi,
> 
> This series addresses the use of the ovr_an_inband flag, which is used
> by two drivers to indicate to phylink that they wish to use inband mode
> without firmware specifying inband mode.
> 
> The issue with ovr_an_inband is that it overrides not only PHY mode,
> but also fixed-link mode. Both of the drivers that set this flag
> contain code to detect when fixed-link mode will be used, and then
> either avoid setting it or explicitly clear the flag. This is
> wasteful when phylink already knows this.
> 
> Therefore, the approach taken in this patch set is to replace the
> ovr_an_inband flag with a default_an_inband flag which means that
> phylink defaults to MLO_AN_INBAND instead of MLO_AN_PHY, and will
> allow that default to be overriden if firmware specifies a fixed-link.
> This allows users of ovr_an_inband to be simplified.
> 
> What's more is this requires minimal changes in phylink to allow this
> new mode of operation.
> 
> This series changes phylink, and also updates the two drivers
> (fman_memac and stmmac), and then removes the unnecessary complexity
> from the drivers.
> 
> This series may depend on the stmmac cleanup series I've posted
> earlier - this is something I have not checked, but I currently have
> these patches on top of that series.
> 
>  drivers/net/ethernet/freescale/fman/fman_memac.c  | 16 ++++++----------
>  drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 15 ++-------------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  4 ++--
>  drivers/net/phy/phylink.c                         | 11 ++++++++---
>  include/linux/phylink.h                           |  5 +++--
>  include/linux/stmmac.h                            |  2 +-
>  6 files changed, 22 insertions(+), 31 deletions(-)
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

This all seems more clear to me now for what it is worth:

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


