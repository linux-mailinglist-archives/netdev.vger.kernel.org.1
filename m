Return-Path: <netdev+bounces-189740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C73AB36F1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680FC3A35EC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E779293732;
	Mon, 12 May 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2eGK1gJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2842918DC
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747052974; cv=none; b=VRyqk8qNbxRyRyfIZgpsVWNY7nlnAsX36LgeDQAN6VHnYn6tul25u2YTxBsYpO5vHE6GCs6HPKe029D+P5lDAFMFHwDgJa8QF3E+sla7zlK1Zj6rwncwk2SvrHCHYEOFCtgSn3XhASuCzy6tyjPWRRwxd8vohGiAUc5i2pqml+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747052974; c=relaxed/simple;
	bh=tJUy7lLmXYcF7E6mCCr7BGqQ9L4GgJNGI82AWY3FskM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfGPsTu9V5D3Zb1s7aWWHGyqjCF+0WjMeypuUiNaQR9rECVPUef1bP/cYGa7AIm8Eoj2Bg9NnWlnwUvD+isFfm8FUGWJhTxqy5uHarLYQ1hXpe/X9VELKcMS6We56HIWA+PkshkU/idNia6PQ7xxmLdxAyJ58+IjQmQ6l7SvQpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k2eGK1gJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54fcd7186dfso2450269e87.0
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747052970; x=1747657770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJUy7lLmXYcF7E6mCCr7BGqQ9L4GgJNGI82AWY3FskM=;
        b=k2eGK1gJclzsLed40s4wc8jUcw4LUmxI/SisMFqTkOi68//tT8iGfK6MsQNPkuoz88
         ER7HA1jd4OHKKJLHFERbmgl6SNK4a8KF4MBtzFxZIc8vMdnNimyLb7VrCBE/bHZcV5XZ
         yEqGl0DtLuyqWdbtw/xepgQYoypXK4NfvLgCY2Z27UPAKbBYeziCT0GvAGeARu9MMGkq
         iDiAgUaREt/HmfBqsdtcgkfgRQBR6veUv9XePv0tk93nr+9EbYz69ymDcDDW/Yx42xQM
         LPugv3v/s/78BF2uMveJ3pdoerPqJszdJ0Tq6pPpUv44GhXf+fChXQAhl6kyh71+Rsxu
         2GBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747052970; x=1747657770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJUy7lLmXYcF7E6mCCr7BGqQ9L4GgJNGI82AWY3FskM=;
        b=Ff1lVFUvyHAg9de/rMktLY6F0hE9Yq9LMfgmoEzXQfJqeb7kDVpuqzn2hDNz+gcyVe
         djSsajPFHGQIBnaipLPr1xt1mVSGP4Quumzv0Ihn/tNyxktdmFZZReV5hoPiX9juc+t5
         ATPAVNH/O/bHTxxWASd39h7qOaJEHMgPAy1Ql3G5E5tw2D32DjVd1bSu6B9XwqptvhGx
         GR51REvBGtY24p2kiSI8j1qxUbzCepvEvXbnHBh7XVCkrkNgbMwwfkQ5cwHlg5j0PBmJ
         pUZtX18LuJgYa2BNwER1PqrImb6a4a4JuK0iwvVCoHT3wnPlkn58XoTtfWzHLJH9Pra7
         cYFw==
X-Gm-Message-State: AOJu0YyZN+kQtvW5lI5gvWsz5Um6N2KC1otUdwsGsj1K+xeN45O9o6Ts
	SVZxIBkyml60rXAV/0essD+je4zk0C9QmxIPxCb3pEXJyR7KjTpIXN8q65IccwdpZRjTWgMtP/Z
	bhj/nnxK+2dDfciGDn4EhtzSNqhpJcXAvQx1f+Q==
X-Gm-Gg: ASbGncugBIBAGEjRBmowtn+SDDZFNMUAE2/ybIwhxEHez3ubCsztQZsnvTKDlN6x00s
	DEu6nAjFiODQpxTD5ccBhVFYjUk/YlkL7zs/xsOOWL8ofA5NRTWI7U+2cSOmCpxJfnN/ogrqp5p
	wpq+Mrdx6uez7dSUnXaF7i7qvxqw9U3dzUND2ZY8V6Uso=
X-Google-Smtp-Source: AGHT+IH5teHFpZT2DOrcAB+txD7/G79w+37iktbttp2yohMQWhCCqnOPjEwdESmtjygl2sxgr8fUwJazQYzfyOJpzag=
X-Received: by 2002:a05:6512:6816:b0:549:5c5f:c0c0 with SMTP id
 2adb3069b0e04-54fc67e28e2mr4791732e87.41.1747052969843; Mon, 12 May 2025
 05:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508211043.3388702-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250508211043.3388702-1-vladimir.oltean@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 12 May 2025 14:29:18 +0200
X-Gm-Features: AX0GCFuVB3OcEUGN1FzLQPrl4GJJ-z0JMr3VodsFOFwKqSoHqyxxq7JqSWnGH4k
Message-ID: <CACRpkdY58DH9O5g35Ai5PjE2gDSSbF1GodDNj94-xhPKfHURkw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ixp4xx_eth: convert to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>, 
	linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 11:12=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:

> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the intel ixp4xx ethernet driver to the new API, so that
> the ndo_eth_ioctl() path can be removed completely.
>
> hwtstamp_get() and hwtstamp_set() are only called if netif_running()
> when the code path is engaged through the legacy ioctl. As I don't
> want to make an unnecessary functional change which I can't test,
> preserve that restriction when going through the new operations.
>
> When cpu_is_ixp46x() is false, the execution of SIOCGHWTSTAMP and
> SIOCSHWTSTAMP falls through to phy_mii_ioctl(), which may process it in
> case of a timestamping PHY, or may return -EOPNOTSUPP. In the new API,
> the core handles timestamping PHYs directly and does not call the netdev
> driver, so just return -EOPNOTSUPP directly for equivalent logic.
>
> A gratuitous change I chose to do anyway is prefixing hwtstamp_get() and
> hwtstamp_set() with the driver name, ipx4xx. This reflects modern coding
> sensibilities, and we are touching the involved lines anyway.
>
> The remainder of eth_ioctl() is exactly equivalent to
> phy_do_ioctl_running(), so use that.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Overall looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

