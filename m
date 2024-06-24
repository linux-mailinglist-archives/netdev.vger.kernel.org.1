Return-Path: <netdev+bounces-105974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1656A914014
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 03:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E361C20D15
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 01:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C558139D;
	Mon, 24 Jun 2024 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B68aI3Rp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F87138E
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719192777; cv=none; b=t4X9qrbTv1rZltJOdMB/LDxQtAzQicslpIEQLpwVABX9H+nd0gc2/HWqIvQH32Fb2yb01znfWzXf/w/Je2+9UDyaaKYo2Lv1KiXdNn6Dzigr7CDg5dDDIKk1pNAob7T4kYC0x+cuhhzB7Msw9icGqBB591X9ZyBIF2J22uDR3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719192777; c=relaxed/simple;
	bh=ytcRSlrxBOKMPj6qpHAXjuJPnZ7OeKII+XZ1AE1+bR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWfH62DFeUUJ7imkPoo99GbHIB/eUhUHkolhMjtaY7KtfWJ7ltjJj4SdqLyTRFJGoYuKbPYECEwiW4lbFDfxvpE0lJuLDSUSRjBMMA2OGfvsc2xiz4VsyhekXNwQhkFWK3JVd+kVumVTrMuZTJ1ElZI312l6nEr5H8/hOSND9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B68aI3Rp; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso39288661fa.0
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 18:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719192773; x=1719797573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2yJkKsQX045oB6naGAtEeUsYVMIvP8cElJkj48R2b4=;
        b=B68aI3Rpcxn8UEXTZMzk2FmuiKQ9C91J6iW1irGIV4D3WfI90xj3JwSg2Oa3U2LRo4
         OsFWtAQqe80/1JG7NgOXi9HG4MgU3mlAEYPTTKFdwShmDUut6C2GImyJquZJ5yq1oGIa
         HQgX2wCj8TtlwJVS4nPSQ5lOlHhIjVTsKHD36H6uPkDlp2fX47QS+ANFnuS5WVDaHPlu
         xpE0aTu5BqX/IGTMMWhxoWfICqpxDJIiwNuCS/nhw2iVFHwuSwjY09/CrmsPdlmzxm27
         KFiY/8gB5mvtluDqyIH++187vhCteCGOqF2oEVuGqx7y3LmzPXnjnHmshin9PZ/DZaUx
         xZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719192773; x=1719797573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2yJkKsQX045oB6naGAtEeUsYVMIvP8cElJkj48R2b4=;
        b=uOK7XHa+dPh8lB2M1U+7LR9shvq+398mOBLFgP65KbgQTbDBDtMS2PUESOUbU5KTh1
         DUc9/KvXF7CRlCV6llkosBwY9UdhSuQ7jhnJZtYk1jrkm8iZpk+9K97vB560tKHrlMVP
         nF6okw2+uzwfDxZwuE08+oUuB7Af8haO/NY4M0nxq5ji1uCmoHfY1A1jLd9l8G13cdfu
         TgvxZWvbdLq0PVVCkhoTViHUtLLaWU5liFBTYSYg6QW+b1x+JJwdZnkAUA3hMQ10nNLG
         SkiJ6R827YrhODRWxUh3eEkmcnMODWK6z4e0DwhsIjteOSUQeGsMWyEa/XzenCzcDeyT
         4SMg==
X-Forwarded-Encrypted: i=1; AJvYcCUhu+clnAmQyHkSbLOSywf5glGUVYMGfMffjZV+4UhjNqDZMr6176nkkvC/cOE4Qi9dUvfIaqL6OoX6Z5klojOavcXzPUI6
X-Gm-Message-State: AOJu0Yxh4zM6ljHmHYMmsculFemfdT0EqyM7WSjfJNcmeUpqG8IAyEZJ
	ggjmThMgwYLs49etF5EWoZQhIfTsPkdxC0dNBLgOmVuHfF39In4b
X-Google-Smtp-Source: AGHT+IGRgAhQXDrU5szyHmGzHJgvUt+6gIwFu72BLDSRhOzFH7g5Uj5dtXHxvWEvtjNQtytWhNfb4Q==
X-Received: by 2002:a2e:9b0c:0:b0:2ec:54f3:7b65 with SMTP id 38308e7fff4ca-2ec5b2f034fmr19299901fa.36.1719192772931;
        Sun, 23 Jun 2024 18:32:52 -0700 (PDT)
Received: from mobilestation ([89.113.147.178])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec5fdee72asm2299251fa.102.2024.06.23.18.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 18:32:52 -0700 (PDT)
Date: Mon, 24 Jun 2024 04:32:49 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Halaney <ahalaney@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC net-next v2 3/8] net: stmmac: dwmac1000: convert
 sgmii/rgmii "pcs" to phylink
Message-ID: <d527jazwnhsflzqilxf2rpe363jty3srrad2b6j3imadq2xmq3@w2nk4zogxwsb>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>
 <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>
 <ZmbFK2SYyHcqzSeK@shell.armlinux.org.uk>
 <dz34gg4atjyha5dc7tfgbnmsfku63r7faicyzo3odkllq3bqin@hho3kj5wmaat>
 <ZmobWwS5UapbhdmT@shell.armlinux.org.uk>
 <doeizqmec22tqez5zwhysppmm2vg2rhzp2siy5ogdncitbtx5b@mycxnahybvlp>
 <v5apa7efqvhh4yu5jnfkgtgp2ozhqyafhm7nddvdtls5toduas@7bynm2cts2ec>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v5apa7efqvhh4yu5jnfkgtgp2ozhqyafhm7nddvdtls5toduas@7bynm2cts2ec>

Hi Russell

On Tue, Jun 18, 2024 at 01:26:52PM +0300, Serge Semin wrote:
> On Fri, Jun 14, 2024 at 12:14:21AM +0300, Serge Semin wrote:
> > On Wed, Jun 12, 2024 at 11:04:11PM +0100, Russell King (Oracle) wrote:
> > > On Tue, Jun 11, 2024 at 03:25:14PM +0300, Serge Semin wrote:
> > > > Hi Russell, Andrew
> > > >
> > > > Should we have a DW IP-core-specific getter like
> > > > stmmac_ops::pcs_get_config_reg() which would return the
> > > > tx_config_reg[15:0] field then we could have cleared the IRQ by just
> > > > calling it, we could have had the fields generically
> > > > parsed in the dwmac_pcs_isr() handler and in the
> > > > phylink_pcs_ops::pcs_get_state().
> > > 
> > 
> > [...]
> > 
> > > 
> > > There's a good reason for this - dealing with latched-low link failed
> > > indications, it's necessary that pcs_get_state() reports that the link
> > > failed if _sometime_ between the last time it was called and the next
> > > time the link has failed.
> > > 
> > > So, I'm afraid your idea of simplifying it doesn't sound to me like a
> > > good idea.
> > 
> > No caching or latched link state indications. Both the GMAC_RGSMIIIS
> > and GMAC_PHYIF_CONTROL_STATUS registers contain the actual link state
> > retrieved the PHY. stmmac_pcs_get_config_reg() will just return the
> > current link state.
> > 
> > Perhaps my suggestion might haven't been well described. Providing the
> > patches with the respective changes shall better describe what was
> > meant. So in a few days I'll submit an incremental patch(es) with the
> > proposed modifications for your series
> 

> The incremental patchset is ready. I need to give it some more
> tests, then rebase onto the kernel 6.10. It'll be done in one-two
> days.

It turned out I has created my series on top of your v1 series. I just
finished rebasing it onto v2. The only thing left is to test it out.
I'll do that today and then submit the series in-reply to your v2
email thread. Sorry for making you wait once again.

-Serge

> 
> Thanks
> -Serge(y)
> .
> > 
> > -Serge(y)
> > 
> > > 
> > > -- 
> > > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

