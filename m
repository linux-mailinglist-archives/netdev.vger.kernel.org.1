Return-Path: <netdev+bounces-69274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B955484A901
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B787289806
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70BB4A990;
	Mon,  5 Feb 2024 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK4FQClS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73333CCC
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170781; cv=none; b=BmHW61Mp+we/YzwBhrFUhpdFEstgSNf7B+fbg+ZB5Gc5qPvYt9vi+NY7vp6m1fZpGR6XDchI5nAt1CYpuoVGO/Z666vO2IYoaTHU0Dg2WbyXBafUNHzuZc8A5tXUdm9aEKi3yPPRRXRFoVZyIXWditzXqXv+qXO29RvtNW0/xT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170781; c=relaxed/simple;
	bh=SL5i9nkDxjzWlUuAv96BA9Q5eE4AZje9CrMug53p5II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WddB3jvE3SC900DE/fDyyegMmGCiaJ6jcPeNKyW4D7h34l06qca91Jmp1BQKAlaiMAXoEh8trTq+8TpKJ35hjypaP337jiWUTTJbl6/1CL6k4WFWluWDrjhWHTlb8mXIYnequZmXWm1/tYA5opN2E0HWaQ0D3QJHQZIEoG8hKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK4FQClS; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51032058f17so297589e87.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707170778; x=1707775578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oaG+2288e5EFOBFSRmlWxH9rBCGobRAYYVymST5ds0A=;
        b=nK4FQClS6gzfdQZQkPvMvpMOTT0sbQ283nYtGIQJ16RPa/VxQ1vKzxI1/gNrdh2pgS
         gyl789sxiMPxRRDho9LO4I8+JgforrV3eMl+dL4YDfvG5KzhPRvqPPdmjyKazufm1XMi
         o63Npo00Q442an2UddUMWghn7kMpPmtGvJP0y55J2fmIG5F/yX4YmsIkBfiPQKcL7gqX
         3vN6CnzHxPDBDy+szGn+gY/KqWOhXrI0yjfFYEPuo+yA0r9NlAVLQSwLw52FyM79fvS6
         wL8XNJOA7p+CObishpQ9mXIJPCvXCIlznkSCv54V4NwUTFskNBvue/NjK0BvvMVIE5Vg
         1Y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170778; x=1707775578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaG+2288e5EFOBFSRmlWxH9rBCGobRAYYVymST5ds0A=;
        b=eCOTrZbqxbvQr22oaTyPG60Cf7cDYzNNrI0xR9dz9hr0euF8CMGveDr+aItULFzDVi
         BfPKpjQrfe8QsjLgIBiIcRReAwFMyYyUgOQr4q1w4H1U9Hf53GyC03XxmlcPaAz2A7Gv
         B+Zw3HOzQQU+EGDLN1yfa3+AbJd3S2j0GiDwUErzG51WHXAe1ar0YGFd2TEz09RFNa/L
         n0LYusBavfwYLfElQ0zrZ/jT1YxsL0V0NPhchbFrvmOI6l/sFIu7H2WajFrJFFrTuRJz
         y4G5LQ7T65Se94FOyH/M6WSgfs3mMdf9QrjiqeHVZxp9dyQri1Jo8O9Y7BArU6O+YNHa
         DBDA==
X-Gm-Message-State: AOJu0YxpE+e6ImHHOkfK4eMH4jfkuvpGiSorfgOpPWuoTp97+5Hkt7hl
	JkZdNEznEvxnM1oncCi6nY+h8ls2TWTPzzQga6HwQqmvKYjoXsHc
X-Google-Smtp-Source: AGHT+IF7Ouc/4Vc+/Zd+HvB5MEX7fB0D0KPQh56APCIwwz6PalIU+8M02bwdQ67hP6kaZeygRgxdzA==
X-Received: by 2002:a05:6512:12c9:b0:511:54a8:3adb with SMTP id p9-20020a05651212c900b0051154a83adbmr841788lfg.2.1707170777840;
        Mon, 05 Feb 2024 14:06:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVwp57onEb7emIDxdf74HNomugd4WAc6BLU1EGsLY4FTObN4+/yCscLGvnapqcFQF5lUKAXeiV6ufUPZ4ju65tzPtLVkXGrBhTR0wp8EtJLTnQ7foQwIFCT9Pug+gqKr0zyuVoDRz6v9MR8dnVm/8t6/uNgKVYsmcMaZ3wZsfHQO+kRUDXTKRbirtAlJq9MK+HTL5AuqJQFkGq1QKeAPUThdgh+YWDHyuFFIkYGpKEEHRdytkxYQHc4q2M/Og02zXhtQ4exdOkbNayzxz9xTc461XRULvcWSfDg4CAW4KixVFKINRlVv7t+sr6ommeaJer5nK4wSLJyo5A0o6MaHJ4NUskkDPg1a8PemKi1jgUAzt8gbxQlxWGe9rzX7obO+EOAmQjDwQ==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id w25-20020ac24439000000b005114db52b4asm64411lfl.29.2024.02.05.14.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:06:17 -0800 (PST)
Date: Tue, 6 Feb 2024 01:06:15 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half
 duplex
Message-ID: <vostvybxawyhzmcnabnh7hsc7kk6vdxfdzqu4rkuqv6sdm7cuw@fd2y2o7di5am>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
 <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dp4fhkephitylrf6a3rygjeftqf4mwrlgcdasstrq2osans3zd@zyt6lc7nu2e3>

On Tue, Feb 06, 2024 at 12:58:17AM +0300, Serge Semin wrote:
> On Tue, Jan 30, 2024 at 04:49:14PM +0800, Yanteng Si wrote:
> > Current GNET does not support half duplex mode.
> > 
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 11 ++++++++++-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |  3 ++-
> >  include/linux/stmmac.h                               |  1 +
> >  3 files changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index 264c4c198d5a..1753a3c46b77 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -432,8 +432,17 @@ static int loongson_gnet_config(struct pci_dev *pdev,
> >  				struct stmmac_resources *res,
> >  				struct device_node *np)
> >  {
> 
> > -	if (pdev->revision == 0x00 || pdev->revision == 0x01)
> > +	switch (pdev->revision) {
> > +	case 0x00:
> > +		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000 |
> > +			       STMMAC_FLAG_DISABLE_HALF_DUPLEX;
> > +		break;
> > +	case 0x01:
> >  		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> 
> Move this change into the patch
> [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> 
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 5617b40abbe4..3aa862269eb0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -1201,7 +1201,8 @@ static int stmmac_init_phy(struct net_device *dev)
> >  static void stmmac_set_half_duplex(struct stmmac_priv *priv)
> >  {
> 

> >  	/* Half-Duplex can only work with single tx queue */
> > -	if (priv->plat->tx_queues_to_use > 1)
> > +	if (priv->plat->tx_queues_to_use > 1 ||
> > +	    (STMMAC_FLAG_DISABLE_HALF_DUPLEX & priv->plat->flags))
> >  		priv->phylink_config.mac_capabilities &=
> >  			~(MAC_10HD | MAC_100HD | MAC_1000HD);
> >  	else
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > index 2810361e4048..197f6f914104 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -222,6 +222,7 @@ struct dwmac4_addrs {
> >  #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
> >  #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
> >  #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
> > +#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
> >  
> 
> Place the patch with this change before
> [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET support
> as a pre-requisite/preparation patch. Don't forget a thorough
> description of what is wrong with the GNET Half-Duplex mode.

BTW what about re-defining the stmmac_ops.phylink_get_caps() callback
instead of adding fixup flags in this patch and in the next one?

-Serge()

> 
> -Serge(y)
> 
> >  struct plat_stmmacenet_data {
> >  	int bus_id;
> > -- 
> > 2.31.4
> > 

