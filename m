Return-Path: <netdev+bounces-180037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2362EA7F2D2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30F317A6AD
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6777A22DF86;
	Tue,  8 Apr 2025 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZwmIVoiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1179C4
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744080778; cv=none; b=s0A8EdbdE7owfCqjhtyqM/tLdD5AIpK/gZ0h2DSJ/klsI7Vkwz8iafAB4KHEFqmXD8X4iEXfNhrzHTbFPJVa4t7XTG9kLz5YfY5t6CcCLX/GB76NpIPQuKbFMkZKG5fvGTLD92UeAUtKVBClRytPIS3cUWIpdV4zhoAY4gplU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744080778; c=relaxed/simple;
	bh=60S1+/YSlpfYMOGoTgRMKtt/u1MPKqI1kRHBZI6N8yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7z4Wubm9BQpXehHF+0FMPGEuKzx/JTo8rurRzf1/b/tdo5yrKUa+5lyf/ScQT7b6emu+8MIa8fxqXgc8O4Ns0VG0xL0SsOfFYOmiZDb6IuPNVVEBlin8K4/flzIFPD7/7Zj8w6IkbMNUYf/cUFmyZy6F+kX2v+DUGIlp3+cf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZwmIVoiO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22435603572so47777235ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744080775; x=1744685575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0h6T1LiujnBjC/vomQ7cAvUQmljojvP8vSChQckRxM=;
        b=ZwmIVoiOvO6zoFyqQCBNmxCLOz9jCyqWNapOwVNntwLKJJQ1M2vOfco8Dh30zurZEn
         Hs7CXWER47N1w5JlPfA7lZ+5epQg2xw+67NT3HsafxKl/VbnF9qqij7Y14ZfqRBuxdvZ
         srS593zlfpbtLyQHRBDQ7ED17rC88K5tGKul0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744080775; x=1744685575;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0h6T1LiujnBjC/vomQ7cAvUQmljojvP8vSChQckRxM=;
        b=oEK3wojNmsUWAm3psET8e4dYmqiCoFgTmkUi4O6eNfasVqoln18Yx6D+Y23KphnY3G
         S4g8lzXFQE59I06nYOUEjeKu7hF3lwmQ/C4b3nM/wcz38ce8LB5TegZhNp9Ri14n+Ki1
         uVm4iPIB1cDsdlJRMrm+aUVZVPBlZNkR4Ywk/edFJllQO13avSMpEXk2OSUFzQ2RF+at
         tG0H4EeUFeX4cTOrED901YwxT+pQTHqOJjtJnDi1rsMZUS0GrpsnVr6Hz3jdwxNEVOa3
         ds6pbS1G3Mt4DvPUZ2dadxlnwLrR6oH6OB6CkAPQiMp+Ok99lgnxvsLGgSyrfai7fIxh
         aC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUW+wrRRTGPfpUX9bgjTbYk6CwQoweYmK5XY5f7PYO+JlOq9cTw7yD1C+OHROQkX2Rz46FCN2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8YxVsE5sDDPopJ23ISR1xHURKIrUxHK5qaDK5/PDBbxbJPoNN
	7VpOYaLDPHdg0vFCTntKiFG+GN52XVks1o0QGM8Zqb2Qgj5jraj/R/Sd+jZlE8M=
X-Gm-Gg: ASbGncuDJrm96etmVM6n8Uet12jKRjRjgmY/yyBXZLWtzI5KlbszBlUIWe0RvnphiYl
	YhFss58V3UOY4gKkya8/IclWW8s65xCiJGVzhm4otzaTmGfC+Ks/IS+082EQ3ejRqE+OGVbuDMk
	011AU0IYnr+KSig5syvpfB2703N4PX2Bw33C19ioUEZcAsZvI7FmCsQXmBW303g/RpN35mVEq62
	dKIekQDK/Mx/JQHfHDeokbyC8iWZg8gQxVjQodZ8HMyKQVPRWrNYNztcuwMJppkfpA5bdFV/Lou
	QzR7ZPLEn0yKnywJ1dWe79OVdRpg3a6K67LoFPZdW4eZmHWfxogqnB4MGU8Ud3bhUNVRWfFKal9
	37xtxLXiTi3k=
X-Google-Smtp-Source: AGHT+IH8b8p2I+52yY87o/1TaXOtj0iK0dhLgiybbhT5iLtjWiLlKMEXX0KM/6fTJUD/p6A/CmDIXQ==
X-Received: by 2002:a17:902:f684:b0:224:2a6d:55ae with SMTP id d9443c01a7336-22a8a8e44camr205629735ad.48.1744080774274;
        Mon, 07 Apr 2025 19:52:54 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978771cf7sm88708495ad.249.2025.04.07.19.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:52:53 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:52:50 -0700
From: Joe Damato <jdamato@fastly.com>
To: Michael Klein <michael@fossekall.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND net-next v5 1/4] net: phy: realtek: Group RTL82* macro
 definitions
Message-ID: <Z_SPgqil9HFyU7Y6@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Michael Klein <michael@fossekall.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250407182155.14925-1-michael@fossekall.de>
 <20250407182155.14925-2-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407182155.14925-2-michael@fossekall.de>

On Mon, Apr 07, 2025 at 08:21:40PM +0200, Michael Klein wrote:
> Group macro definitions by chip number in lexicographic order.
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 30 +++++++++++++-------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 893c82479671..b27c0f995e56 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -17,6 +17,15 @@
>  
>  #include "realtek.h"
>  
> +#define RTL8201F_ISR				0x1e
> +#define RTL8201F_ISR_ANERR			BIT(15)
> +#define RTL8201F_ISR_DUPLEX			BIT(13)
> +#define RTL8201F_ISR_LINK			BIT(11)
> +#define RTL8201F_ISR_MASK			(RTL8201F_ISR_ANERR | \
> +						 RTL8201F_ISR_DUPLEX | \
> +						 RTL8201F_ISR_LINK)
> +#define RTL8201F_IER				0x13

If sorting lexicographically, wouldn't RTL8201F_IER come before
RTL8201F_ISR ?

>  #define RTL821x_PHYSR				0x11
>  #define RTL821x_PHYSR_DUPLEX			BIT(13)
>  #define RTL821x_PHYSR_SPEED			GENMASK(15, 14)
> @@ -31,6 +40,10 @@
>  #define RTL821x_EXT_PAGE_SELECT			0x1e
>  #define RTL821x_PAGE_SELECT			0x1f
>  
> +#define RTL8211E_CTRL_DELAY			BIT(13)
> +#define RTL8211E_TX_DELAY			BIT(12)
> +#define RTL8211E_RX_DELAY			BIT(11)

Maybe I'm reading this wrong but these don't seem sorted
lexicographically ?

