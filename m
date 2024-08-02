Return-Path: <netdev+bounces-115400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D8E9462D9
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 20:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51D21C211F6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 18:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5E1537A3;
	Fri,  2 Aug 2024 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAZQk+Lg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204BA15C149
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622131; cv=none; b=haJKf3DaOUB8uOgd25xKg4x1wMeyw3wiPgcLypWXoCz9qFtAHVaUghJPcCtOQfcBEDfwBfaoZXw9itmFlNKGSjGWDzQvdr+I9i/sbgiDz2Hcuo58NLm0G3N9l9/fepjhhZFgLPvjjhzyIJ/D3Tk5ITZ8ceUAZuGkc+PqNv84qG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622131; c=relaxed/simple;
	bh=1hzYSWBmFCCK+uKRWu72lLr8Q2S3/C2xUqeMNQzuPLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6ZNShGwDB/s+V2w07btfUA932Jfo3oYI77l9UlDhLmoSx0LfZ03A0F0o4WFkWyOgWSRZMlGBAAvjwO5ARk79ldpMO3tJpclrSJqVQCHeNq73JwkbdSQtzd4E6uwXCldS2XfX68LjpdheqEk6rletrHKtfbwl4eVecamkNfAuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAZQk+Lg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722622129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aLcM9MWhiHw0bs3x9mpTiGnVhWovcyriDIOcsgAYyLw=;
	b=CAZQk+LglPlcNhD8xY2Km2xfTfGzO+kfo/S2WGrDUv7EoireppqVeNXJduaU8HcAQwzgux
	b0NuoiOvXC6xGPyBuagUYA1WkNpAuGuzTnL7fyvj0z69voePt/mdJterl063hsuz49NtOX
	x/RoeBAMxKmewINrJrgxPh+yK8JI8Rk=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-BaqZXZwoNFW-5AKngyTUsw-1; Fri, 02 Aug 2024 14:08:44 -0400
X-MC-Unique: BaqZXZwoNFW-5AKngyTUsw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-25e08ee43a8so7041630fac.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 11:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722622124; x=1723226924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLcM9MWhiHw0bs3x9mpTiGnVhWovcyriDIOcsgAYyLw=;
        b=QK01cFY+/0Ju8tUck//mOxjm2IS+Vh7Cw/ACjjV5HjCDdy0bTh0EymJG4QIme3PpMo
         h0Wy3lgGLgkJ4LISd1krh65AWGjtjj6OzfINpKnl0SWCqcA6y6oDksssdaiotXimE26y
         kPDbImQ7TJwTrfXIwruULd9q81wE6BnqrbIXgK1qCS8MVm7RwmJOqh7WSO4bhPyf7yqa
         HvFqBr/ncbb4t6ZbrnZ1VidfmBLiq/BJbO0oYboNQl8jJxcUHg5bvGy4p4wpm2PwcbAm
         5zGWC0Yf6SIPbE2IeRMdOCvEZQim1u2UbKEa4bM/HdfMjQhu/tmSC5o4u4Y/SPhvtMMS
         BZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR9nfd+YZu52GseFft+ewwXyY74y/bhPiDmDIDy0FDL0It5VTiMIXL+g4701j+lvNQGjTZ2XlEjf71qg+p4ZzI9KRicqYC
X-Gm-Message-State: AOJu0Yy/rBs0xMFtp7jHHHT7vrmdZqIn2IjaTAjpqBkC8tR34JGkc3yt
	TiSMJgkZgZT2wP7S61fZGISPTfoUmhVtAAZWgBN0Wba76WiLcvpIMUBJ4P9cKIcUNUwuSuEbcDW
	seGwXON3EuLla5fVRRcalG70G2RJ/vncwJ7DTxRBS+Aoi89rLo+MiIw==
X-Received: by 2002:a05:6870:b528:b0:25e:14f0:62c2 with SMTP id 586e51a60fabf-26891ae014cmr5007850fac.3.1722622123957;
        Fri, 02 Aug 2024 11:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR8xANvIW9PT25/s/1o20v300D34AcEqg5SxNPaonYq0aR8vsoes+Ti9UOB+gaVvGdCgqf3A==
X-Received: by 2002:a05:6870:b528:b0:25e:14f0:62c2 with SMTP id 586e51a60fabf-26891ae014cmr5007818fac.3.1722622123595;
        Fri, 02 Aug 2024 11:08:43 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6aaa56sm9123001cf.16.2024.08.02.11.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:08:43 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:08:40 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 03/14] net: stmmac: remove pcs_get_adv_lp()
 support
Message-ID: <kse4bj55hlnwsmidecriuqvkxj6i2fh6eredcd37jia7u7djbs@gcpastryv7jp>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpo1-000eH2-6W@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sZpo1-000eH2-6W@rmk-PC.armlinux.org.uk>

On Fri, Aug 02, 2024 at 11:46:41AM GMT, Russell King (Oracle) wrote:
> Discussing with Serge Semin, it appears that the GMAC_ANE_ADV and
> GMAC_ANE_LPA registers are only available for TBI and RTBI PHY
> interfaces. In commit 482b3c3ba757 ("net: stmmac: Drop TBI/RTBI PCS
> flags") support for these was dropped, and thus it no longer makes
> sense to access these registers.
> 
> Remove the *_get_adv_lp() functions from the stmmac driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Clean up seems good, I'll take Serge's word on the IP details here.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


