Return-Path: <netdev+bounces-98769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B51298D2679
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496FA1F21E12
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411E616F85C;
	Tue, 28 May 2024 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5hiToBL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E22117921D
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929293; cv=none; b=hbFJaVdWETnFVgAVgfdG+gN0W2i0vqkjTUep1ei69mYSxE/J8dR0RNoH5mqDwyc8AmI2cq/SkUibZnEqtlVlxSA2bSMjj2VyJeYrvATBqpVR2vbhCuaBVBN2m7xeMJcc1fgNqyqH4dZ+Yz5lTNlvrQ9ZHQ/lodN6Xmwbea3pkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929293; c=relaxed/simple;
	bh=SdCPaUNGyR3xmmH7qGw3KuoX2A9XhpNto7Ve1forgj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYsdnlp0f/dTnsSMjbVqa8VQMXdv/O0Qj3oiKIJnPVO6ZN/ffQMbv26qYMmLXAvRaY1n6A6ju4nlNCgBdRCwPqGrANhVxr1nYLXbjyosJ/VJb56bL/37TMnqbDLp1Sv/MuJmBnh4BsrSy/4KMx7+R6SUGFWvBpSiT+508rgD9Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5hiToBL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716929290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=udCxeFic4ovPz9NMjk9vC8Aj4vL6U+9qgfTd7ZRGbUE=;
	b=N5hiToBLFfx/lzZ/RLWffF33Qx5FKOjWu6G1jo398vTqUsWbgPoqVU6ebbtAHvFSW7ETlU
	oR0AP2URGt5gjvVhRyz00WXmPEDote7lh8o36HUz3HCi/S0snmqqEc0LKXsbIQk0Yd4p0S
	jbmkjjkqG8eqrmJr0/s+nt67aju+13w=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-uIAJWbuiPQCXv3gARLPyeA-1; Tue, 28 May 2024 16:48:07 -0400
X-MC-Unique: uIAJWbuiPQCXv3gARLPyeA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c9b08d857dso1200143b6e.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929287; x=1717534087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udCxeFic4ovPz9NMjk9vC8Aj4vL6U+9qgfTd7ZRGbUE=;
        b=SvyrmpQX9zuUM1chqMOyWMAU9tfo6o9OBr1DbVn5cOFGrNciCxJ/M41WiB9ieBnxsM
         S1CqJ9sz4w9RD04SapYpZ+LaRso0jNhtgEVp5sE3LUCTb9eJAhqPaoYyjNlMz4eTFOOy
         nyk91qxyR9AL1+rk/uF7viSVvf+JTVB6N7Y5md7Fz3UNh5uQg99zF6CKANVE9zPWUe5M
         +VbNB4EnD9ROajwZk26biYRkVFUa6TiRi5mz4HWEkJHFwdJVuFjREPz0HGOVuu+xmCMe
         7rZxI0O6jbpKUTZnWPC+m17RdKvfY5Kjx8HoKAEgJn93zu3NW779SMkYeeMmZhD1K4+z
         vMJw==
X-Forwarded-Encrypted: i=1; AJvYcCVo/HR0GeOC8LL/mXGWIq6LcdoVYkOnsLnoZo5dYjIRwNU1/U5DD0TwyMEpFMhFoCmPgxz8Bcao1BVUVyCa6Tjb/pPeGIL0
X-Gm-Message-State: AOJu0YyLJX7firyPsfiEfN+7BkpL/XKUVg8EWSmnwBKbpun+LsRNx1Bi
	lsZhMQsBSgjYp89igtaehWUj4XFyXkSD31B+atpAKls2MYmwSxQyljCBdyC6/wVYcMKTDGggeIY
	jRZxvv0JaWC3eHdPjUJ377WZaR24Lqjs6vzX7F9HuOvq4mIusWpwnZA==
X-Received: by 2002:a05:6808:624d:b0:3c9:6692:dae9 with SMTP id 5614622812f47-3d1a745c373mr12545715b6e.43.1716929287049;
        Tue, 28 May 2024 13:48:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKl+KUY1YuSQYskK8u+IzkICy9/4WQBAR7haOAUO1dKLQSlw3Iv/GIhlKGk8RvwSXZbqV+MQ==
X-Received: by 2002:a05:6808:624d:b0:3c9:6692:dae9 with SMTP id 5614622812f47-3d1a745c373mr12545664b6e.43.1716929285888;
        Tue, 28 May 2024 13:48:05 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac162f02d6sm47533456d6.90.2024.05.28.13.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:48:05 -0700 (PDT)
Date: Tue, 28 May 2024 15:48:02 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 5/5] net: stmmac: include linux/io.h rather than
 asm/io.h
Message-ID: <yesu3ijfhimhzmo5l2i36nilbwe2akhf7frkn4bgamv7ltrvgg@mpueny45zvuf>
References: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
 <E1sBvK6-00EHyp-8R@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sBvK6-00EHyp-8R@rmk-PC.armlinux.org.uk>

On Tue, May 28, 2024 at 12:48:58PM GMT, Russell King (Oracle) wrote:
> Include linux/io.h instead of asm/io.h since linux/ includes are
> preferred.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> index d0c7c2320d8d..d413d76a8936 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c

Any reason you didn't wanna treat the other examples of this similarly?

    ahalaney@x1gen2nano ~/git/linux-next (git)-[tags/next-20240528] % git grep "asm/io.h" drivers/net/ethernet/stmicro/stmmac/
    drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:#include <asm/io.h>
    drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c:#include <asm/io.h>
    drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c:#include <asm/io.h>
    drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c:#include <asm/io.h>
    drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c:#include <asm/io.h>
    ahalaney@x1gen2nano ~/git/linux-next (git)-[tags/next-20240528] % 

Thanks for the series,
Andrew

> @@ -15,7 +15,7 @@
>  #include <linux/crc32.h>
>  #include <linux/slab.h>
>  #include <linux/ethtool.h>
> -#include <asm/io.h>
> +#include <linux/io.h>
>  #include "stmmac.h"
>  #include "stmmac_pcs.h"
>  #include "dwmac1000.h"
> -- 
> 2.30.2
> 


