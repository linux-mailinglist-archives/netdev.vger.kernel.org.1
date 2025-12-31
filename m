Return-Path: <netdev+bounces-246398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BABFCEB2EB
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 04:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9967A3009B3F
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 03:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DE923185E;
	Wed, 31 Dec 2025 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joqT0hl+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FFD3A1E82
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767151223; cv=none; b=DeQn+WlasFXt2+Wk7OQpv5QtIhXKyez1OUWBMBSkUlq1vaAD5ZDK1DXlvJky+JBGcbKWgojCMlS7lU2K9jEJLQO4yv8Sw44wgLVJ+d5fFrHo8IhChAQw6zb7P4wH/HZEGcUzb5V630+n350T3/XQEeu5rB4tS/3K1DhaSpAsrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767151223; c=relaxed/simple;
	bh=r6vMqqM2jZLeB0PLgCa0Fll/U48sBe8gA3EU1sWRjEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATDgwru3LqJxAtQFXWpIHLW+eKFXnIKrHoJ2g8/nFJyid8QJ767+OjrDgu1kl1BUE1jqvIOFwezDqnkrXiUz5+4pxVi/SnGwlxAQgrdic1ZgwJd7+8+ShrZxdkshCPCMHlNv0Fdc1I/akntWA8Pd33Xs0xfrq5e4ISGcHzWLgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joqT0hl+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7a02592efaso1593836666b.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 19:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767151220; x=1767756020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ITBeSz5GH6UKtnCqK1HWw82KHhqoye+7vSkCmlUCo4A=;
        b=joqT0hl+25Aeenn9xV7IwAd6fgGB38iP5tcT4pzXhDQn810e2abPvPwD7M2e2YPn9w
         0eJ2hobWa/DsIc2Cm/OukSaXMcrFkxxLklsw3R37njJUY4PU2wlGcUOUuhNNKp5PwbBL
         9ogomTn8+p24W3jVZBI8BZD9d3ROZDriXHAO5xRM16YYvRLz27BKZ/3z2dztnneyXt14
         7SiqRHvONSgrms9RTbGnXSGstDt9qxGaX1glKqAYf0cbTjHh1ffgN48WnM/dEbG3wC8z
         9vzA0GWHUmvF1290LDscs5fxSil4d+OIGJNZ6CldPO02/lo/twqcqAMRenbKZfw/0XE2
         ALfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767151220; x=1767756020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITBeSz5GH6UKtnCqK1HWw82KHhqoye+7vSkCmlUCo4A=;
        b=SkfjoTqbt+zz7s98ilFn21EeXtPdBiMKUX/XoiUp/SGboaHdFrWCfHr+0ZhYD544fC
         OrUT8tAjnhWPSikLo5trFHHmE8TGXgiPfpIGo2Zs8Zq9JlakiVh33zVLIfLawlorS4kf
         R2zMUNYDdcthbZ6hVCRpv55y1IO9l5yU3sU/c/pVbN2pCvvn5lx4hJVJLG0BWi90HT0F
         ufN9xgrEHeCATue4TdYovSd38ofZCdmRL+Kf41QHGdJYBpjXaCdJ4xUydsOxMb9P57xC
         7ny3+UrjC2+Pze9svHTwGUpDQH3snDGnowOz8leZC4R5c/2irlaeJWzM4NjeopJzMUIZ
         sHdA==
X-Gm-Message-State: AOJu0YyguJsATXBmmXnbXR4JcSiBOjR2BNFMidCkvtbikaHboTnGtBrB
	DKfKooNRbqmSeBzIKdiUamaae93dEUzPE/LiZfytB/U61tNqakCdHwXG5ZUZP6gTpsXRtSgit72
	4jXVx08+epcmUnAxWzgsZWyE81RCujek=
X-Gm-Gg: AY/fxX7F3LzJIORQ2EoY7nwsOq504bwqXAqEpJCz+KSqGLU2+lcn2nN+KTZ3npDrmMq
	SktSvdWtF7dE/Wz6uRB2aS7wKSTOJg1Yq/e/+j/CzE/9YSAKT9sZGXByXw04g6mkjqHGLRE+84q
	x2WMCmU8x4nEcFy8AdTWF9mmM0bzzxcuK9V6gscAfDv9wOY5LA9OCqpfGSIQknZvBJdI69ZSPmT
	tqVfNNYtB7vc+Sanvnp9SANrS9g7kvuYEM1b5i5iaXsdKSxbeT2d0JeeAs16n54rjCsdP3tKCe6
	2Uz4vIs/nR8iYLqVvhprXbm8IV3t0Q==
X-Google-Smtp-Source: AGHT+IG2ev7NrLUsWqJjlqFF9+0xciVV+5qs3YdEu/IcAPnTg8Fqymr84wmdOe/RPE8IBugTDLH+ftWV43pifuqkboE=
X-Received: by 2002:a17:907:7213:b0:b80:2b9b:39e4 with SMTP id
 a640c23a62f3a-b80371da5afmr3702592166b.55.1767151219910; Tue, 30 Dec 2025
 19:20:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127120902.292555-1-vladimir.oltean@nxp.com> <20251127120902.292555-12-vladimir.oltean@nxp.com>
In-Reply-To: <20251127120902.292555-12-vladimir.oltean@nxp.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 31 Dec 2025 00:20:06 -0300
X-Gm-Features: AQt7F2qwcqcc4wrBjUR-HBWMDNRqV986U8uNobrwT6tN76_ouSbHMSYFgy7mYws
Message-ID: <CAJq09z4nOL_JCmVLM87sDYBn4+1c29Fed9mGoqMQahgUJrZfyA@mail.gmail.com>
Subject: Re: [PATCH net-next 11/15] net: dsa: tag_rtl8_4: use the
 dsa_xmit_port_mask() helper
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/net/dsa/tag_rtl8_4.c b/net/dsa/tag_rtl8_4.c
> index 15c2bae2b429..2464545da4d2 100644
> --- a/net/dsa/tag_rtl8_4.c
> +++ b/net/dsa/tag_rtl8_4.c
> @@ -103,7 +103,6 @@
>  static void rtl8_4_write_tag(struct sk_buff *skb, struct net_device *dev,
>                              void *tag)
>  {
> -       struct dsa_port *dp = dsa_user_to_port(dev);
>         __be16 tag16[RTL8_4_TAG_LEN / 2];
>
>         /* Set Realtek EtherType */
> @@ -116,7 +115,7 @@ static void rtl8_4_write_tag(struct sk_buff *skb, struct net_device *dev,
>         tag16[2] = htons(FIELD_PREP(RTL8_4_LEARN_DIS, 1));
>
>         /* Zero ALLOW; set RX (CPU->switch) forwarding port mask */
> -       tag16[3] = htons(FIELD_PREP(RTL8_4_RX, BIT(dp->index)));
> +       tag16[3] = htons(FIELD_PREP(RTL8_4_RX, dsa_xmit_port_mask(skb, dev)));
>
>         memcpy(tag, tag16, RTL8_4_TAG_LEN);
>  }
> --

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

