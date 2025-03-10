Return-Path: <netdev+bounces-173635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D984EA5A44B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB8C3AE9D6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C75F1DF96F;
	Mon, 10 Mar 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUpt515u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A61DE88A
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636853; cv=none; b=Rd1OcixdbsJ7vKuDvtx8oio0ftDhyqGlk9IaOwLl+9w0afJy04/Ki/4mgPE70pJKIjVKfTG7KthA9rj5dqoIaC7HYZocJs/6KjEvzdrRLNlhgug6NPSjIH+PNKxw/4DnjOoxXBw0rgBKELZak3GD5HFV4+c55g+xy37OsBONuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636853; c=relaxed/simple;
	bh=AGt2QKG+DtqFoUcbhQ3xw0t2YLyBDUEC2Yq67tszctM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJ5bHfS+nUoloDn59U2Gm44/3LnbomH/UhCoNkCRMRFfuSMi1BnHusH1YIdirPCK2GiTkrLGbh2jXktU9rxm86Abdsn50eBfKzUJRdCm/oOPFSO0tGZnnhzeT0L02mHeoHFY2SlL+SGryOKx3kuclcyGTZ8zduVZX0d0dm5S3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qUpt515u; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf257158fso10604775e9.2
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741636849; x=1742241649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RrH66w6hjy8vTdk3/chb+sp4rDPMHTlBdbnwkF+r5mI=;
        b=qUpt515uw5B1Ei7onMIW5ikoEsB2Anjrxe5zfh8KJBdUy3NMHETsQvkOKMhaoUbR4M
         xYnh6JDEV5K1EnsRUybnIjKk4BjbuBT8MOpoybjA0K9iKiUD+Qps2WVS8zebXHpU2kxU
         aQ2t4+0Lq9DI5R7/w4AUWoWcz+sxtFrvsjcVt7te4+VweT3AyT9EGGbEfxiuOJqkxEu5
         e3C0w+KDU2eysvhBPLOWxr5zr2b40lHtYz74Q7UIbrHgw/Or40KGcxWzhbo7Oh3Wketl
         xCSSD/LHYVeFLeEDQL3ajpb4uuErhEKz8Z4ks66FfYqgy/GfL16eJeK9FYVCdwO989nc
         yagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636849; x=1742241649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrH66w6hjy8vTdk3/chb+sp4rDPMHTlBdbnwkF+r5mI=;
        b=l0APYFpPA2VNWmgdA7sYR89vknpmVA1s8mA5d+276rGe97xs5h59uU+RyaoA/IDrwI
         LkkKQBdR4dzJ2ejXz7dEEA2M0gelf4LzbcF6eRu3GhQ986qXVHOnl+FlW13rIYNScp8a
         lKhdGcH117jfA5trd9NwBdibeKrz0r7Eht2a5ofdvL8VL3bfVZTiPEsFbYWzjnN5QrKD
         s2zdhe5S8IEv4JhTVbz4nvwYLaqzfdfJJ61+A5TePNKfQ14+7yuuVQv9I/nhlektE004
         vt4wNPq14OuP4MFWhS39DzgfL/ZhUu4eBiOoftm/obwRVE7hvMUV82B5zl7bWVvbQi+V
         LRBg==
X-Forwarded-Encrypted: i=1; AJvYcCWHcylcx7hEYBW9XLME9xGWuYHw8ClU4cJq6Iu1uqIIICYDIsaPy3Q58jWz8Za3S+HzXG8zg3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnkkA3q3lnQ1ArjNtx0Oni/4w4v+bPBNRztLKpNFzD1Rk2hZ5
	1t0Dya+3A5H5Gb5ITjwIKOqjMjog+Agl2PRWJynJcIW8ZOVcH3PrCEpZw0kvW8I=
X-Gm-Gg: ASbGncvIDE58BAdIs6dTV3fgG3QnJ8kynSNqlmrAMdXIPhdzFJ3i0GdNohZnRRmvk0l
	d0jhmZ73YxWBLJRuOK/dhg4GmTtlnzdnMrBXTJsW+lBwMOcmdxcX2V3q2FmuSF79+JvpJf5P0Ec
	YW0dRwPRnR/U5VMCfXnr4ngXTtKUZ5UReeIatwaXFIlAjE5Zp0Vno4YKFAhaFtxbxObF0IkAA5o
	S1jibLji/K87lnZL8EJm5waz/BBPI+P0nF8KmLyepyKRiS9eqzk+snkIilzxaKy4sh8e5pCEs60
	nzMLClb/nWrQO7M3cj1+BjASbgGFF6pfVojeAptGeyLfWQPyWg==
X-Google-Smtp-Source: AGHT+IFM0bk3L92HPL0a5ZdSUwgEKFaDtW1VyX0wWUqemrb2A9UISJTLPEdrw9TUJkHbZkhUzucD2Q==
X-Received: by 2002:a05:600c:3512:b0:43c:fded:9654 with SMTP id 5b1f17b1804b1-43cfded98b3mr28404325e9.19.1741636848948;
        Mon, 10 Mar 2025 13:00:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfb7aefsm15672875f8f.20.2025.03.10.13.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:00:48 -0700 (PDT)
Date: Mon, 10 Mar 2025 23:00:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: mediatek: Fix bit field in
 mtk_set_queue_speed()
Message-ID: <20f34718-e60f-4361-9ad7-311d3f67e40b@stanley.mountain>
References: <eaab1b7b-b33b-458b-a89a-81391bd2e6e8@stanley.mountain>
 <Z87e75UV0Qc4oY64@localhost.localdomain>
 <aab6d5f3-7ef9-4220-8b67-ee9b09a5f168@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab6d5f3-7ef9-4220-8b67-ee9b09a5f168@stanley.mountain>

On Mon, Mar 10, 2025 at 10:27:34PM +0300, Dan Carpenter wrote:
> On Mon, Mar 10, 2025 at 01:45:35PM +0100, Michal Kubiak wrote:
> > On Mon, Mar 10, 2025 at 01:48:27PM +0300, Dan Carpenter wrote:
> > > This was supposed to set "FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1)"
> > > but there was typo and the | operation was missing and which turned
> > > it into a no-op.
> > > 
> > > Fixes: f63959c7eec3 ("net: ethernet: mtk_eth_soc: implement multi-queue support for per-port queues")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > ---
> > > From static analysis, not tested.
> > > 
> > >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > index 922330b3f4d7..9efef0e860da 100644
> > > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > @@ -757,7 +757,7 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
> > >  		case SPEED_100:
> > >  			val |= MTK_QTX_SCH_MAX_RATE_EN |
> > >  			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 1) |
> > > -			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5);
> > > +			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5) |
> > >  			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
> > >  			break;
> > >  		case SPEED_1000:
> > 
> > 
> > There's a similar bug a few lines above (line #737):
> > 
> > 	case SPEED_100:
> > 		val |= MTK_QTX_SCH_MAX_RATE_EN |
> > 		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 103) |
> > 		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 3);
> > 		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
> > 		break;
> > 
> > I think it would be reasonable to fix that too in the same patch.
> 
> Yes.  You're of course correct.  I'm trying to figure out why my
> static checker found the one instance and not the other.  I will
> send a v2.

Oh...  Duh.  if (IS_ENABLED(CONFIG_SOC_MT7621)) is false for my config so
first line wasn't reachable.

regards,
dan carpenter


