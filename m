Return-Path: <netdev+bounces-108891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7B9262B7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E632807DD
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A241741CF;
	Wed,  3 Jul 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYKHouMI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213117A599
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015085; cv=none; b=dIBbtSsx1q/0JTojEj3hpcJgb7F0UgGZ342sg29e/C6qP8lI9qVC2+mYUTUqPlYdZyfvHXdVtt9hoOQf63qVXSSvye4q90PMsZMQtln4+8jZoUQuh0oSYZf+XHm71+MBuGxB6DrNpaaxuDiVJrIWTIyeJ4xjPJyW5MMzwZNBzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015085; c=relaxed/simple;
	bh=yyS6XuMZFmh4i8I/j8re9ANvFSa6nOi0by+MLx85GZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaGVrIORPCj43ZnWSlaonZL2CmTXt5MVOp8FSS0x2EMjMwNtZp/LTqPMe9K2RsM3saWxhX2Soou5v/TBHBWcQMkvdiy2/CVz4vKKEQAcuW/uK9T3hgAa/40OBcfhuNs3yX2iDBw2BHO2k4yGysTpsPheQOu+MAW11qKZw6hh2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYKHouMI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720015083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pYNDn0y2UwX0ohYZMBTbepKl+5H26DhfIFiMV92J61U=;
	b=bYKHouMIrC+ZEZyMuGitlCH9jkQ2khxfFMbkRj4RBOHVSlNbFbWco++HERM2BYP0oQs/A7
	PDg+NCvcVTuxb1kmAQN7iw3bK2VRqQZ4sfOQ5TqVmTZ2qNn2+gcFg/FNpEjcd1ZNPOU5M+
	jV2uI3fpebmhn2gU4KQCxiozeHTB9XQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-nYeXveHfM-Sko_Ym8ix8Pw-1; Wed, 03 Jul 2024 09:58:02 -0400
X-MC-Unique: nYeXveHfM-Sko_Ym8ix8Pw-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e03a3aafc6eso2498243276.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 06:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015081; x=1720619881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYNDn0y2UwX0ohYZMBTbepKl+5H26DhfIFiMV92J61U=;
        b=BF9GRlvsUEbDQyI2J6MCgN8BftuxAsXhwh+B/YvMyPTrcfdquzdL8DZ6mA+RXqISXC
         0WCnEpDWybb3iU3OkHdzeKFfNUV1iAQSHXwiEGGrRQYrjgVFrRClGIScxwRPMObysclk
         WI290WS8AdPOyHqi0ll97DZIhLc+NSRcJphaPP2jlS5hbeWqaMgZEow0lFSRFZjJYWrF
         3DB5t9iz2q6lBKP6sD0ZoIaYB3OrCx1ld55ROHw1SuwUX45aLhka2mBkh/i90jUlmFpf
         o+jbf14Ux7ydI6rTM/vE9hv/RrBpX93bReZrt0l590A7AKpapd821VoqvXxEXM7tzJeo
         cObw==
X-Forwarded-Encrypted: i=1; AJvYcCUklSjUCLrKmzBnZO+aXmaC7vCZJ1leHpZoqCdN3ApR06bYxlS86F5iN9PXkwIk0xq1IN7SAnqET4Lud6wYPFBDTFxi2buo
X-Gm-Message-State: AOJu0YxzGiL1igx7gkgUZ6yRTiUiL1ADNFPefqyIwco+W9D9JGphTbuh
	uVH5AQm1yXg3zwbhHWyrvqTLuL5i/LMHXvmf9vDl7HWLvZBbPddLrST0TvfLD0zm4NUtlDV5fhp
	5koGik2lQ9jDCNDimTiW+2y/KnAlc7HecjpBfH8x63WSslGEf6UkAAw==
X-Received: by 2002:a25:bac7:0:b0:e02:50f2:784d with SMTP id 3f1490d57ef6-e036eb28e82mr12646109276.21.1720015081584;
        Wed, 03 Jul 2024 06:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxHgUgpetMLrKPihZvI7LJnxM1ykQ7IPeHC6fC0Rby7GTglGg91Jc2cSNUr0pwm3OY3KUObg==
X-Received: by 2002:a25:bac7:0:b0:e02:50f2:784d with SMTP id 3f1490d57ef6-e036eb28e82mr12646098276.21.1720015081297;
        Wed, 03 Jul 2024 06:58:01 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e562916sm54005196d6.30.2024.07.03.06.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:58:00 -0700 (PDT)
Date: Wed, 3 Jul 2024 08:57:58 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac4: fix PCS duplex mode decode
Message-ID: <rp6fxpz7iaolxnh2hga4nyu7v5umajuvbktn4ltgcrv3asttge@553u2gsohdtv>
References: <E1sOz2O-00Gm9W-B7@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sOz2O-00Gm9W-B7@rmk-PC.armlinux.org.uk>

On Wed, Jul 03, 2024 at 01:24:40PM GMT, Russell King (Oracle) wrote:
> dwmac4 was decoding the duplex mode from the GMAC_PHYIF_CONTROL_STATUS
> register incorrectly, using GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK (value 1)
> rather than GMAC_PHYIF_CTRLSTATUS_LNKMOD (bit 16). Fix this.
> 
> Thanks to Abhishek Chauhan for providing a response on this issue.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Fixes: 70523e639bf8c ("drivers: net: stmmac: reworking the PCS code.")
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index b25774d69195..26d837554a2d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -791,7 +791,7 @@ static void dwmac4_phystatus(void __iomem *ioaddr, struct stmmac_extra_stats *x)
>  		else
>  			x->pcs_speed = SPEED_10;
>  
> -		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK);
> +		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD);

Since GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK is confusing and unused I think
removing it altogether would be a good call.

Thanks,
Andrew


