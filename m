Return-Path: <netdev+bounces-104453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A320590C966
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3BC1C234C3
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73627345B;
	Tue, 18 Jun 2024 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuZI/Gsy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36601865C
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706416; cv=none; b=SoTqdBCPw62CYsiDRhwfhx1/POsKFPf/l7jbi5iBSf+GucyI+Hy4VgGB7fwyC3vsXiHbDJSh7oBwDm9MZ6oIqNnGbOiPggoQsVlYHKN233M5WW6/jCXV8k/egr3/kmY04/yX6uZe08aD+/lBK7m1RU72wPoYVoSWrjz64upTUx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706416; c=relaxed/simple;
	bh=e0AEhbFMObHcXn8psToo1zbM4abq/p1rGLetMpZT+as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTCoYBGSoOyXGwlymznWsTFiY1vM0Hrwyee/KSZkX2KsHxzEomEi+Q+5K4/3swCQ4PXtufH7t/5wc10NbSszo1Is08ngZm+aDxMCnJDKn5qOV1yLhDEjt19Vgdae2RixXNoM7iGFWBSP/lsiLrFax/17e1oMT8nrMfKULbYiFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuZI/Gsy; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c7fbad011so6174788e87.0
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718706413; x=1719311213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hk2nCrXYKa/i3AuAbXWHqowD8DL46I50YE8wSmEWrP4=;
        b=EuZI/GsyAO6TArcN1pttnEjzzZtOD8FBX0XK0noYO/dDYATVnZyKQJIzp0TTp3bEIB
         n0gdZhC3bt7/jtGk9zGciwc8N2z5hGBEhSpzlPlPg4Dad8oZRa/ZAnDS3EW2iVuohIgF
         xj4R2o67rKwhGixL2zfdva5j2P4EycLtyl7fwzHqozSxveT5PP+1zqyttMYUkKbKfAlg
         mbqGQnUdN5lGpaoUwoTKKesPbMDz7kwEGYNVcv6E0Aw7lmqHxfEeUYv+sb+HG2PdvBAd
         3tnr1XLRH+LeVa0sntJkM5yT+p7pm/SNBKAh2RT5g4Wjjk44xidd4hm1kpALqEMXOJ8a
         8b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718706413; x=1719311213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk2nCrXYKa/i3AuAbXWHqowD8DL46I50YE8wSmEWrP4=;
        b=F3KRl1kH1FB375u4L4VdY80XegEZenlXgBIqUjrH+gYJhD0jptcjzkZmHBSlcmbxLa
         vm/EpI8/3CGvQnaaBQCzX0d1NbGunkF23c+T8AV1/NtKZc5EPXRfdYDPBM3ZKEZn2PMJ
         6h16WEqGXMiHa9YwyCAfoy08rkz2EShwDqFEflktaK34miQP0MK/a3rjHZsjW2LWvmtt
         FkcwV+6p/IpNweaNAGIxti5EUbaoRLEMjmVjcgGQRQ+RSUwF+u65E5jSyLVveXU9cz3R
         vDotIf5wEVRCIYvygnuDybkEQfm5gUdkew/jOXModI+pomxr33eMyf8HVcpqeorqYPBO
         z5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVOU45tkHdGZatCMWcb8pPD96MtUOWzU+bvNS/tmnOP9Cuq1Nl21XVneBzyZI00L5EDyAiodqFgHpXSfSnGjOtAfVkEzb0u
X-Gm-Message-State: AOJu0YyMIJrnCIkykte+8St/sOBJZIIvP6wqwqbzMoP8fZnmANz/CIZd
	YAcok6yAObubeF/OlDBhij4fv8A0kXZLITTAn5L5Hekaw/m6CvEp
X-Google-Smtp-Source: AGHT+IE7iaQ4aAesL72SBnry72umoPj/MPIxf/7q3WKQGtDtNwoXCYXe4NQkqU47oIbZwd6Zm79q+g==
X-Received: by 2002:ac2:5295:0:b0:52c:8944:2427 with SMTP id 2adb3069b0e04-52ca6e6e293mr7261489e87.31.1718706412752;
        Tue, 18 Jun 2024 03:26:52 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52caecd7edasm1049484e87.275.2024.06.18.03.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:26:52 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:26:49 +0300
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
Message-ID: <v5apa7efqvhh4yu5jnfkgtgp2ozhqyafhm7nddvdtls5toduas@7bynm2cts2ec>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>
 <6n4xvu6b43aptstdevdkzx2uqblwabaqndle2omqx5tcxk4lnz@wm3zqdrcr6m5>
 <ZmbFK2SYyHcqzSeK@shell.armlinux.org.uk>
 <dz34gg4atjyha5dc7tfgbnmsfku63r7faicyzo3odkllq3bqin@hho3kj5wmaat>
 <ZmobWwS5UapbhdmT@shell.armlinux.org.uk>
 <doeizqmec22tqez5zwhysppmm2vg2rhzp2siy5ogdncitbtx5b@mycxnahybvlp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <doeizqmec22tqez5zwhysppmm2vg2rhzp2siy5ogdncitbtx5b@mycxnahybvlp>

On Fri, Jun 14, 2024 at 12:14:21AM +0300, Serge Semin wrote:
> On Wed, Jun 12, 2024 at 11:04:11PM +0100, Russell King (Oracle) wrote:
> > On Tue, Jun 11, 2024 at 03:25:14PM +0300, Serge Semin wrote:
> > > Hi Russell, Andrew
> > >
> > > Should we have a DW IP-core-specific getter like
> > > stmmac_ops::pcs_get_config_reg() which would return the
> > > tx_config_reg[15:0] field then we could have cleared the IRQ by just
> > > calling it, we could have had the fields generically
> > > parsed in the dwmac_pcs_isr() handler and in the
> > > phylink_pcs_ops::pcs_get_state().
> > 
> 
> [...]
> 
> > 
> > There's a good reason for this - dealing with latched-low link failed
> > indications, it's necessary that pcs_get_state() reports that the link
> > failed if _sometime_ between the last time it was called and the next
> > time the link has failed.
> > 
> > So, I'm afraid your idea of simplifying it doesn't sound to me like a
> > good idea.
> 
> No caching or latched link state indications. Both the GMAC_RGSMIIIS
> and GMAC_PHYIF_CONTROL_STATUS registers contain the actual link state
> retrieved the PHY. stmmac_pcs_get_config_reg() will just return the
> current link state.
> 
> Perhaps my suggestion might haven't been well described. Providing the
> patches with the respective changes shall better describe what was
> meant. So in a few days I'll submit an incremental patch(es) with the
> proposed modifications for your series

The incremental patchset is ready. I need to give it some more
tests, then rebase onto the kernel 6.10. It'll be done in one-two
days.

Thanks
-Serge(y)
.
> 
> -Serge(y)
> 
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

