Return-Path: <netdev+bounces-244270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6245ECB3713
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 17:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CD9C300721C
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00C4327201;
	Wed, 10 Dec 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkkHka/p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD92868AB
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383400; cv=none; b=WynC9juK2MJQJ6Riq3eB05T63F3AzJdBkrBLHZU860Q8mxDCew0MauXppY7Hqi7T0qBxQqUbw01pi2TmcoPHMxUC2iie4fDVBTKt8FpWm5XIvqcXm0iU6xMmrHG9E5ctwvaFmWWtEhWLFdIUqQYXVocKW+JW1Gw5TRO9dC/sKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383400; c=relaxed/simple;
	bh=KY7UcVKJx2M5vV0fy/PMjqMS2fQo1kzZvxVGFq1E7iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsYS9jRnjomtPmk74LzimwprABKSWPucpRfkM7H3xLZaE/8SkyxaTA1W3A30UJ7u3n4w4Nvtyu4h9++gN2Nf3yrfo+DH6SMv3SA6vrAxA8vwVTI1WKp16PAXvwCc3RTc60m5bzxW6zQ9n7tL88kwellFVPvYWziwUKDc/BVa2rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkkHka/p; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779e28ebefso5995875e9.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 08:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765383397; x=1765988197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7gaiGsdHBlurzADrHTXibNWYhZRYOpdVz83hckt/C8=;
        b=dkkHka/pe/1yLTARMD55cmjZF7iDyvnKa0tfWrL4JwwW6eGKk3fXVvDGOziPSNuPxk
         33x2iiTE1S2CnYQAU43Lb4CI55uTIskpGNF31JJnEAYcfdqhxIuGAlIJxw+tQ2+aVV9I
         YgodhWs0E7FHERtC6PMJyPJhb/QspxdN/6LUJBL0fNJJwignQt16vBPH1Jmid423Rc71
         sg0ebORgQIBrtlw4fM8PX5mbUUPJzetkDPwMLfkxKraM8QsQet7EXF8h2W60Kb0vZrDW
         XVPRs6MW3cx0nBZfzID8NCNL2MTsekNgYnl3Kl/oYAvIb+As5y4SlDBYFoc0K084YMm/
         wdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765383397; x=1765988197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7gaiGsdHBlurzADrHTXibNWYhZRYOpdVz83hckt/C8=;
        b=J5gmlLq5SHjdn3t0Jwfj+EZ/zHa8LIcnyUKeeNagxrAgGuSnf6UZ3boWRXwY1qGXDF
         KzkNs6bRF14ZaqwCPcYmg+/wJGlxCjV4l+FDxKCMUlb1kALRoJBsHybDfe0nhO+wDUrF
         mIK6enXiuIm3uvXe5+4Fy6dDyO+7G+KrQ2YgZcy8zbhJxmAk+9hGcN++935VsOHXMh/0
         MN5G9AGd1v8S41B8d4jbwGtO9aRZX9xO43IvY7d8dFHaF4uvLH9u7Mbk6q4hrAGERt5c
         ckS02mk/hgzIZOZkfK3grwghekTcVfKBZwUSkn5Tl/L4Y7uIrFumxx6qmovEXn+wvMHH
         38NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQSaCkW6F7i/2IAg6vJ2O6E3npljb2ejON9D/hCvOSAXhDZIHegcxI1pSsaXddGXqBc0m4gdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKc3qdCJmWmrymZxjB1jyjpw7YwACSfLA5NRZ//4idsYnEWNwH
	mtRKt2p6SsKYOXjzX2kadvp4oydYJVfXALnC9duVcty9bVk7KPHuR643
X-Gm-Gg: ASbGncuE2ttmmIznpTEwz2k+2KjYSO8n1PvRZiDOmFzLjL7DOGxQmpWC1hPmSJvvkSW
	ib8EidRX/y0pzUcDhvv6wruwNZYZZ5ynaVRR16sfTcembgsbELqSE4/DSLfDNeOBUfgLHE5IkC0
	aP9qoagSveV0L+7itLrL3jN+zsibkVv388uOvSraSE74tnKDpZ7krmn0gCnb3ebjtx4V1GW2/Xw
	02e3c1RrFdAjpOdN5TLloPNAv67vU+jxbsEXf1rpLavokSPCISCW7kzRbEktPiJf2PIDtYhKqHO
	uyXSucfzqNiPWQg9ljKbrSJKLUUWcC+y7QdkXQwOq77JwPaQwwuannN6mYfGcgmCCS3RUWUW0V6
	sZ50V42yMrjybq8KLxtKqZLi7FmMbCUTjfxLJ/JcWTihYPSgh2u6cCderT38YL7GcMoBjeyX4zY
	8yOz8=
X-Google-Smtp-Source: AGHT+IEn8XVJm38BXtgQpJHwPIRYh4SSmVYEP+9EFtVHZZlB7PB7qz8jRUrBe8HeGAVKj/Wk4hOcHw==
X-Received: by 2002:a05:600c:1c93:b0:477:9a4d:b92d with SMTP id 5b1f17b1804b1-47a8380c622mr19222925e9.5.1765383397243;
        Wed, 10 Dec 2025 08:16:37 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:6346:5010:4ce7:245c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a882fe683sm270275e9.5.2025.12.10.08.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:16:36 -0800 (PST)
Date: Wed, 10 Dec 2025 18:16:33 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net v4 0/4] net: dsa: lantiq: a bunch of fixes
Message-ID: <20251210161633.ncj2lheqpwltb436@skbuf>
References: <cover.1765241054.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765241054.git.daniel@makrotopia.org>

On Tue, Dec 09, 2025 at 01:27:42AM +0000, Daniel Golle wrote:
> This series is the continuation and result of comments received for a fix
> for the SGMII restart-an bit not actually being self-clearing, which was
> reported by by Rasmus Villemoes.
> 
> A closer investigation and testing the .remove and the .shutdown paths
> of the mxl-gsw1xx.c and lantiq_gswip.c drivers has revealed a couple of
> existing problems, which are also addressed in this series.
> 
> Daniel Golle (4):
>   net: dsa: lantiq_gswip: fix order in .remove operation
>   net: dsa: mxl-gsw1xx: fix order in .remove operation
>   net: dsa: mxl-gsw1xx: fix .shutdown driver operation
>   net: dsa: mxl-gsw1xx: manually clear RANEG bit
> 
>  drivers/net/dsa/lantiq/lantiq_gswip.c        |  3 --
>  drivers/net/dsa/lantiq/lantiq_gswip.h        |  2 --
>  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 19 +++++-----
>  drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 38 +++++++++++++++++---
>  4 files changed, 44 insertions(+), 18 deletions(-)
> 
> -- 
> 2.52.0

From a DSA API perspective this seems fine.
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

