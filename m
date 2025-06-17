Return-Path: <netdev+bounces-198775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08806ADDC28
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A808B17FD5E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F41825BEFC;
	Tue, 17 Jun 2025 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="RuyUVvdT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDA020297C
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188067; cv=none; b=Cs3kWIgypFYUDkVRRziqAmQyn2g1kW3+Cb3ivqnD8PQRpI+/byOfxHwPNQyzgvYDR6TmaPP8Ie1yuc5AkxUo2Vigu/V36BTG0qVklNWRahqFIPGW0iBVGRWYUonI5JxhX8B3XVJ4xUS7pcR5kwgCOKkLt55VO2liXzvIQ77z2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188067; c=relaxed/simple;
	bh=m4CmsPwi1LYcihZgdD+bmOz7Mop8oKPwflndYy/Webs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpY2dCOI65Txkoouh1wvHm0E4RJrRhW6UPf1XKVqjRbQCyPHdKErVGKDaKsl/sPwyJ9JGHAspEv15Oro2gC+SyFSh0iDVC8UpdDgxXbC8K0lzHcHEjuUl9n5Xc7XGjdUbs13TA/ExNW722HJ3Lhi+k22r5SrlfUKYtNbUTvtEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=RuyUVvdT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d6ade159so51380515e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750188063; x=1750792863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYnTvqEzbKEHc3jOrWk/rFOyt80FMkGIZEqohOmHsiw=;
        b=RuyUVvdTmDCr6RRnHSBpXieSQnsxAbC+kBKcpWdFFHfpcB8VI6+NZfiRu6U3iUfEOA
         zbJ+QVU/Q96Lzf5V5XnzkqDQlPoUL7P41Xs29Duu4pmCmQBlk+6wlRNTaelEFWsu29/1
         B7+E/OzuCjuTQ5nwv8fVmQ+O/p7T+rLsegnF3g0YTFoCcTP2sIjmePVhL0MePazMz+xz
         YfFqCSwPeWlr2IZ0HPmYfePxNQkGwRXYygYUccv+Ah43H3HgPKf32RuoXze1sqN7dJ6B
         EqIF22ETYEbqfsp65TUvhK2rf72oHpPC67cbQxt/H2YqO30f7rZ5/aWV6Z+lNk2hPmpa
         im0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188063; x=1750792863;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYnTvqEzbKEHc3jOrWk/rFOyt80FMkGIZEqohOmHsiw=;
        b=iMpaGG8A8ZMvz/9ZYpbrNvFv7xWgYZiExK52ufmaKK99Pn2cMBk2jCKq6bubfpfe/r
         vGXnZ4iuoZVza5vZEYtqC/2AjkcWZUO94tmjDbCEwSa4Nt2ns//JAmMYrOFc08GMdhoZ
         aEgso/ebsfWvEejrbaWmGzoQ31S0J8x7+LbpsA3L8QVBCJ9XibpS6qZet8YPfL7zE4Bp
         BjauGgvvfKPKyZYJzSeytFFiP9aoeSes34KYEPSZOatyAFtp6tIzLAQ1clXKMfUGP9tB
         tVsSfyGo198O0zNGU3VD7PriO+aopC9FkDH+w2vWekHTY95gh6FYo/WsE3UuvNxZixWz
         NgnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBdAkBkZpRSqqzqb0ymGp1XLBT1DjPtRK7x4P0eX/CD8wlrTDiII2GXGcoTpwI0KB4ivmGyEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxdYvdPu00/OLUMdNusZD4/43OdC2M5U/WV305mORmCUJBMn3S
	K6jbxcHhZvPZnw0sW1GewVQPtHIvqv89jSlwQZ69JyHiXwVpY69qOIz+uZ/reQ7BK2s=
X-Gm-Gg: ASbGncsi/Xgf6iX0p+toJDN2eozjOZFF+Sxw2c+6MBakLvqdrjAqzN5G0IopMQNOorX
	zuKMHS0BBRdTmC7I4STBXILFOjKdDXye+URsf25K2Asfg+Ud8fTlAR0uJCeH3hlT/xAaM6DI/5R
	wxgXUYz1DaeR2d6VJD6imEMbO/dujFfRTV0zH2q9eQPqjDWtJOiql0wA7dPMYpvwzrUH1fmH8sl
	LHeoeviL4jqc10qJdUmqMQ9t3tcDV9GIQV/qQX8glXUsOhLodOzPxvqmbYkaLDTg58wOqMU5PcL
	279gzYJdUodQCfZtmleBQN/g2WcfZ9zuAIUtICZEv8PJ/L7aWm8YGy1PZi6m0nyohsw=
X-Google-Smtp-Source: AGHT+IFCngCCBjqWrGJVjxyEGSCQO8KrIo44b2+A2LtAvPVHfuZY1iilZmGThH2+VFZpFeIf9MblMg==
X-Received: by 2002:a05:6000:144e:b0:3a4:f975:30f7 with SMTP id ffacd0b85a97d-3a572e58f6fmr11553498f8f.56.1750188062774;
        Tue, 17 Jun 2025 12:21:02 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b089d8sm15003128f8f.57.2025.06.17.12.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:21:02 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:20:59 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	madalin.bucur@nxp.com, ioana.ciornei@nxp.com,
	marcin.s.wojtas@gmail.com, bh74.an@samsung.com
Subject: Re: [PATCH net-next 1/5] eth: niu: migrate to new RXFH callbacks
Message-ID: <aFHAG86ALakLJRa7@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, madalin.bucur@nxp.com,
	ioana.ciornei@nxp.com, marcin.s.wojtas@gmail.com,
	bh74.an@samsung.com
References: <20250617014848.436741-1-kuba@kernel.org>
 <20250617014848.436741-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617014848.436741-2-kuba@kernel.org>

On Mon, Jun 16, 2025 at 06:48:44PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/sun/niu.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

