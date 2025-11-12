Return-Path: <netdev+bounces-237962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C94C5213E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9747C3A651F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F2727AC3A;
	Wed, 12 Nov 2025 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="hwgqECDs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD830E857
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947794; cv=none; b=hsWCfPMXwqSkqaQ6jJsJx9637Dov3fHhqrcGfhsBucO/i4puxLcFhMDUIDpbwa+rM7EZ+1OIkdZOqLtkJ02V+ndTxWW85bVxx9chOPjBgnDxCQO3g6YRNDrHmt/2Ic9xJQuK8DaRW5pTUB7UA2Tho3TTjkeoyNhZj41gnV5obyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947794; c=relaxed/simple;
	bh=JH9RQWDlZksP3A5WjT/Tdcm9mFgNLOafV5repVUVXmQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEuU6BG5x7dHX9ajkydzaRJXWstRsWTfyHWY+VLxoX8IkjPhu4ndBMIgsYl4fYElGKCGtjl3CaIir1CYyJsLNZKFm4BoVnVd6HtFIx69kT49mS3xA6tWr+pauOcfCfdLx86YjdUF4rYKRp/Uo1M8I4OtD/cdRj8UBg2ul9Bj2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=hwgqECDs; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2E7C43FE52
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1762947790;
	bh=JH9RQWDlZksP3A5WjT/Tdcm9mFgNLOafV5repVUVXmQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=hwgqECDsQzlV6AkQZet/s6MW6kquiGQf88sNdGh4gEQ7/0u/341o10m6Eqjcp7YTT
	 YJ3n4dwsOFKkuRkFZHFQ9I1IYTKpFj2NdNAHKZvw+UoxmQJKWcvGZKhkf11Dpl1N2F
	 3dxvIw9MweMvZCrUSK3IB1aoiJBnHhvj7VwNQLivzJXVWF+AN0bqIuPKwZghteRu9I
	 uLUk+KidzELo/6A2YP0z6l756KVR2cT2SBgxK2gPerQhcSyfVGLTcMreYhVJzBYMd9
	 PNbc/p7Mmh9KVomp3OL6t6ihENY3c3jQsoN0Nz/X73BKLxcWftalvCZlkC/nnHpn21
	 ZCjG8WNfi9xOUzNOauBCld4Tq0aH5rgmmymdHgzHElJOorZ4uS0wqlpYsqlWRGFujp
	 QA+N/+hjJICMLh4+b9hmIwDVwTBIeya8e9R9ex1kmLdkpLI3QV2xbO34DZSBbqX2vr
	 pMZo1w7onvqDEnXdvW9ZxpiaD9l14LaYZATkY7sESRzlHwSalawuNFriZ+mJPBS9IQ
	 qbf8JkdWJ6gM/xiWCdt5kzzdamWTsUHJAUDzVXy+KL9xPkoQhF3QX6pMtrWHOD0YQR
	 2PuxYpi8pj5+7POz6rIgi6To+YSRht4s+TV89jY4e9pNpkhxwdAy+BMNRSYBtnkBTc
	 l5urrNTKcGbtH5AH9HpRTfes=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b70a978cd51so77286266b.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762947789; x=1763552589;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JH9RQWDlZksP3A5WjT/Tdcm9mFgNLOafV5repVUVXmQ=;
        b=aQstIKfBwUJDKPvz7gSblt0U+yAhiIHl4hNRDywaQawOmyo7HkseAyy+p+En2Iipkw
         ezZvEpAHOBJds/Cog08woAsnKVGXvQhPC2T43Gojjd6S8z+216nMql5s9BtKiUAsvFy6
         HR7auNMdC4mxpu9lcf6belh9fVqvnEqW7TZueO8d652TpcY0XpSCVa+X4B4LWAeKSVny
         MjTydyZzanSafFvpWVb2vUhU/9WaCRgQno5KFSFzk36tzuZKjIWECHGidTevm3EWOR1+
         zvqIUA1kSsuLmr4bnkj74XbvWll5W+JAmAmYHK6RbiIzookYqmnj7HLHB/LPE8zAXURK
         3r7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvJi+pA38yg9OlsBCY2PUCnONxSMspCWahLz5la1tc28LxhqmRAphCesbu0wXJeC5Yr/2XgI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzib+KIR3mrrgM0e93DoNrVbm2p8NwLBYpR+QMTYCdGiiLy+rg
	jE7AWPh3RHivFUIh9/noaDD2NbSrjVxh/8FQHau/4ycyPMoXqNN+ee1A7Yc9xqtiGQ0+SmiP1Mz
	8X+jMwjtKyUPNNRi1KqTbki1r3csmUckaf1bld+OMKV+kkvQo7Gf6+z14jlR9tOaSt/nm/hDY2G
	/S0DEe3Y1SWjZy68nYMo8LKY7PU3wJThINWU5TYwJuZYM11Ukx
X-Gm-Gg: ASbGncvDKpm62/MGXRHcoEz8zM4ws99ya98yFrs3z59IU/0c0Ns/flzcM05yBfV12Jv
	wAMMVBAsjoo0E5+5MCxPRY5wZaTMHLJTZmovIvm/dbSSzstenrwhw3JhFnpPWj+J+cax5/0szAI
	2JAil5TKcntKwH/4nN2CN0w7iCaALJe3yUmzrhh/m91oS24R0nG1VzeVAGZgLw3HCZYFvZg1JtI
	MvxUVTJH7v6
X-Received: by 2002:a17:907:9713:b0:b72:5a54:1720 with SMTP id a640c23a62f3a-b7331ae8bbbmr239080166b.57.1762947789526;
        Wed, 12 Nov 2025 03:43:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEACqB0mCN3EX0p95RUNEAUTyaZ39pandxW0+rdirFn7EUt3COrqPK8HKamiHijsSU/fq2Kt0hi/1uzUL2rjsY=
X-Received: by 2002:a17:907:9713:b0:b72:5a54:1720 with SMTP id
 a640c23a62f3a-b7331ae8bbbmr239077666b.57.1762947789084; Wed, 12 Nov 2025
 03:43:09 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 03:43:08 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 03:43:08 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <E1vIjUF-0000000Dqth-0gwD@rmk-PC.armlinux.org.uk>
References: <aRLvrfx6tOa-RhrY@shell.armlinux.org.uk> <E1vIjUF-0000000Dqth-0gwD@rmk-PC.armlinux.org.uk>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Wed, 12 Nov 2025 03:43:08 -0800
X-Gm-Features: AWmQ_bkenMvacX26pAHg6nt10w-7MV8cO1nbkR5cqs-fMNBqO4TpuSWeehZ0dCc
Message-ID: <CAJM55Z9O3BTejaAnTH4nTXT3VcRU701BWdSusRNArt-9vkCFYg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/13] net: stmmac: starfive: use stmmac_get_phy_intf_sel()
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Keguang Zhang <keguang.zhang@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Matthias Brugger <matthias.bgg@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Russell King (Oracle) (2025-11-11 09:12:23)
> Use stmmac_get_phy_intf_sel() to decode the PHY interface mode to the
> phy_intf_sel value, validate the result and use that to set the
> control register to select the operating mode for the DWMAC core.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

