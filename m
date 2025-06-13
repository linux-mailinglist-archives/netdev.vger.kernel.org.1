Return-Path: <netdev+bounces-197339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9952BAD82AF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514CB7A6534
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1540E24C68D;
	Fri, 13 Jun 2025 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="S/LBkSyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E002475CD
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 05:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749793462; cv=none; b=sAoMLrplPaXjUvQ4uqbfzEIOLutmMdimd3ALFSdBbCG+1P62RIxfKRlDVij0J/luGYr8jeN/3affkkz94Xo52wzVEG8yeKlmqn8fYqSVtcDmxYOx3WE5BEp1y7k4NoDaTRfwW+miXpoZV0yZ2zIQbVqX8kLfAhlJc/boiDe60pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749793462; c=relaxed/simple;
	bh=/u0arpuLxhgzKttnYWprTMY06QyGbNmIwT2mkYUqVZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWzvQbwIlxnPCxIIzyLVWU5FP5zTbtUPmIJpL+OJPCZY8uInDIGGj0WnamWGj/T0ZYjxAPYRH8z4DdYI1YpAncr6ROJYhriAeYi0/7lxdR7X1Ij5GSNVXLuaPPimhHjvpYtZXMQ0ZpkXWLIo0WqAKs86LiVmrmXtb8iJGlRpz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=S/LBkSyi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so19839695e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749793458; x=1750398258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gykoMnS52RP7gDSHkbQWw5lL6WmevKJQr79bb2ZfQk4=;
        b=S/LBkSyi/lsoKQQi0MD8RcS2uEjvmPPl/20Ivc/0U9WAK6+/Z7uQpZ4jHu162GI3uz
         i7vDssmwRv3hyIoUw3m/FBIAh54KxTef5QSBdjN6B2RHST7I11LSr757F7mT1j5h92aA
         wrK6g0jl3Ui5WUJDREk5HPb5qs+u7/SJiLTKd8ur90y51+D56rAi4+7YlP34m+9BPPXK
         tIDEaPZSyRzUlF7d0Ra85aA0/1WT+Pp1e2NaYtB3WuLrcttWNUY5lynpxxXX8DyqD8A0
         uOOfldZqVZVwdClbNjrV8twpYv1WTf4M8fKqtyaGlwTaVAls2cwdGgfuFFMFWWuErHB4
         ue3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749793458; x=1750398258;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gykoMnS52RP7gDSHkbQWw5lL6WmevKJQr79bb2ZfQk4=;
        b=RgFmKMCOBfM+qnRPo5sUFZ7VTMs694hiBAFS5DP0R6QDHxAr6+ndLIwYzSqgPeAuhT
         8P/5fW94kLS6G67T2rSsaTJxHsGXgh3ntQvmAI3kabc/ALAvJaWmjyTM0+lDUDiY+ofj
         UOOHBTKnEcOAlWv76dc/fItd+3jqP1naQu7vU7yYfwrrjBjkUGmsoUmCRx/MJ6gy2BbM
         6zsc/AMTtsGvBtQClAQdVmfGQ16ltDSBlKwJ1miv/AGf4NbxElDgf5HJ1Dx+MGMSFHiZ
         obdSLQmecNmyr8LFNfzZwuMCfKeFCvyMvzreKqfkO5KEY5N0MDnr7wNYaBp1RHpbADnN
         51XA==
X-Forwarded-Encrypted: i=1; AJvYcCUDTrhz/IyKg/8VMh8Fq7fuWj5achnt0DJIrcOToOcLWK87A5kpjOGOrmeOsJIR1z+CdRXYaUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/aMhKMQpKc5w6SjZM87usWPrHCuFhuKk8JlmXRtqpMo2hN+/
	BsbOszd6inLe5FuuyPqO8VHNOQ56X9Ef5HCeauiZ37HV4wC5/uuH3NyIk2RETdkMRAU=
X-Gm-Gg: ASbGncuWm/0FMJiR05c6gHZb1u+ausmSqVk7XvM4VKe6XVoYLow7fex5+o4yTTblL80
	Hw+YKomhcqiy1BuZwnGvtIpTnmwy1QrzSV3IPrNQ7J3eQv7TCDy7nyyJzJZLU5TZEF2+s0FJpBu
	x9m3Kpmd3RbOg2xWOImMb37sarSltHTWuBZsbsExgEAzu3UGpfQqrSD70tKX/gPjtbSvdh5u7c5
	CNmVeUERKtNrkfw2TWuMUtWgnlKRyRsm6DugYfJ4CBCmlvELCT6X2DWWoxPJIjtLL4X0jm19BFC
	1nWUUO9Mft+T7EWJ54nLz9uezehfTi2kK4mWrITcFcvkYekkAxANjmwfKfkoVS2Z67w=
X-Google-Smtp-Source: AGHT+IGBv3Aqwtn7lt6O5w5s9XFTW33H9ZaQD+WHnSPEU2tjIcBqQ3CXdzA4IBwXSMWFuMfZRQ00dQ==
X-Received: by 2002:a05:600c:6207:b0:450:cabc:a6c6 with SMTP id 5b1f17b1804b1-453372c1b4fmr10520265e9.15.1749793457478;
        Thu, 12 Jun 2025 22:44:17 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e14f283sm40965495e9.27.2025.06.12.22.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:44:17 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:44:13 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	bharat@chelsio.com, benve@cisco.com, satishkh@cisco.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
	xiaoning.wang@nxp.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, bryan.whitehead@microchip.com,
	ecree.xilinx@gmail.com, rosenp@gmail.com, imx@lists.linux.dev
Subject: Re: [PATCH net-next 3/6] eth: lan743x: migrate to new RXFH callbacks
Message-ID: <aEu6rQHAW4pXJ-1Q@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, bharat@chelsio.com,
	benve@cisco.com, satishkh@cisco.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	bryan.whitehead@microchip.com, ecree.xilinx@gmail.com,
	rosenp@gmail.com, imx@lists.linux.dev
References: <20250613005409.3544529-1-kuba@kernel.org>
 <20250613005409.3544529-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613005409.3544529-4-kuba@kernel.org>

On Thu, Jun 12, 2025 at 05:54:06PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> This driver's RXFH config is read only / fixed so the conversion
> is purely factoring out the handling into a helper.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/microchip/lan743x_ethtool.c  | 31 ++++++++++++-------
>  1 file changed, 19 insertions(+), 12 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

