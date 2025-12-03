Return-Path: <netdev+bounces-243384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84295C9E963
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 10:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C473A9043
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB812DFA25;
	Wed,  3 Dec 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1Rj4sfT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474C2D9EE3
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755407; cv=none; b=qCPl1sg3J/iewcH/fUhuFvkmIOa4A1yziWYH6WI5gWVbUnm8rldXr92BUxPPRPXU2Thd7IP61hh9ecIl1EYoRAZyLZhKBt1WY4Q3kfgRnlxlIJkkGLNoCOXwwRHupqOAwJb3S5IvRssfebqPVQEHV3xUkVjfdpALBwUwambAHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755407; c=relaxed/simple;
	bh=Mbz0n8cyh17soj0KqRceu2sn7o1SXquavh9ps5fYNhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuoNp1fSxLU88Bxz0X6Bz9/cZ3wd9Hl0kX0kmxPy7Xz6hz+vhJoKcu47Yyhwsu4Roy69f6TtuudSjYwoO/9ooRkSOZwEaV76+xz0N/JZ00TUNqk7cHk6P+1F9g1cpVqAwULm9E/xmIPQpnMRzkKWWhz9W0zUUvMLsNED2GLF3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1Rj4sfT; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b53b336e6so328353f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 01:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764755404; x=1765360204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6t7gQAzch95pFm2hDKYFDULXCw39e6YiDiTD56qT8jQ=;
        b=H1Rj4sfTr2TMvSneC0W2EY1KFTMyspXebLHychIP/S9znLRIp4UbSXVPAPVdrr8gF+
         xhGWrcAEGQIASpi0yS2xofQN7qCBFoOvg5r/fmMJvlJ2XK7keHK22K7B7OsOi45cGaoG
         WrzA+hwveIZ9HS9KCKrL8VSjSToZ+EHvqHI0iNDH1bzS29yM/HlFogAKakcZJPQqyuG+
         QM+6kg5CdT10SzafQfqXqQeV/YH2PTReIkiQB80TZW5L1URsSsT9iuN4Go5SJGPc/p8J
         HPVIFxvk4Z/Ok4JIr/mgGKNbeWuGHuZYnuIqStL1HNktuapObjv+K9ldqTTZXOPy0Fhc
         mUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764755404; x=1765360204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t7gQAzch95pFm2hDKYFDULXCw39e6YiDiTD56qT8jQ=;
        b=kcc06iaYzprxc4RDDTD0tzZIm+lLmXkCwT+umRLxqJx27+pI0AkgHENSEz0o0ai7fj
         HunMerH0L0SxMz3lJd3r60ydC/FVtA434egakuoziqPskWx0DTCLvzg/ecOhptJbsw+A
         ksGARNfc8Gl4x4YM9R1J3373DcnwtBv7SIyvJ3+VYwFpzfrF9T+K8Qlg6iN2sHWjEsOQ
         VsHeVW7eS/gVHVYGWmp1SlJnOh2Xa61z9FvL0AvyO2gSB01yUeof7gq+hLHCC+OLofmi
         6ge/hiEmjR/GZon6qZfteTlmvs9/Ilk9BFwQ/tO6K7Ftr+jg18q5z8KpyInt+97liPKi
         bniA==
X-Forwarded-Encrypted: i=1; AJvYcCUGW+p54GfdIUBgt52PWsxgjS2iI5SSzlRklnX3nnOlxVDZoqdbQ7IPTiKQrgg2UCZM9z15mUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNDzKmwNoOhmHOh/z9rCdKO8NMTjU2VD+okneUAWapXgesS54
	Xr3xHMlv61UxlcEwk5SpvoMicHpZOm+a+1kZUieTkewB6J+FSM8XbJfh
X-Gm-Gg: ASbGncst0XVUBJ3rIe6ZFobhyXolATzvsG5g0qdbct9vcsGVdvJiXO6703wK+FE29Yo
	SrWdhAtdA23kvXdYtVP+HXQol4biAb0eOnEl70dFvAOk+CySNTHqmyCVoa+9GNZDwvBE1E4nUY0
	ZjElUSp8QUbcVEBBzaLDZqLeJzlk5sEM9QlZ0p0/ITxBhHLL5umw2UBDiZoI606KROVtEMuF2yH
	sgv8wDWk7QFdUnwinhm4cXSK9olBJzEWv+P1RCPFmi4cPWY3goPCt6Wh5fJkhoOVczV2SJm0VWD
	5tjc2WSQEf1Zc/k4g/WKizmznt/ypcGL65jr5k6i5s3zloojCULTmq2/z56QF2qOmigY92PLRPO
	dZcST2zfwdVhTIUEd6tGsrAi7zZDex1DkYQ+AovwePBsNSBjOyUZyKeDYp8TcVN9qBu43KYpRVe
	JyAOk=
X-Google-Smtp-Source: AGHT+IFl2CLZadWRzEn8wsY6IvI3pNarA97yc3Lz32M1yUqW+06+IY9ge2pnW0Hhl58KlDjDZ8R1bQ==
X-Received: by 2002:a5d:5f55:0:b0:429:d084:d217 with SMTP id ffacd0b85a97d-42f7310eaaamr907744f8f.0.1764755403544;
        Wed, 03 Dec 2025 01:50:03 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:bbd5:36b7:a569:69aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f6ffa18ffsm7371894f8f.5.2025.12.03.01.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 01:50:02 -0800 (PST)
Date: Wed, 3 Dec 2025 11:49:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>
Subject: Re: [PATCH net-next] net: dsa: mxl-gsw1xx: fix SerDes RX polarity
Message-ID: <20251203094959.y7pkzo2wdhkajceg@skbuf>
References: <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
 <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
 <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>

On Tue, Dec 02, 2025 at 09:57:21AM +0000, Daniel Golle wrote:
> According to MaxLinear engineer Benny Weng the RX lane of the SerDes
> port of the GSW1xx switches is inverted in hardware, and the
> SGMII_PHY_RX0_CFG2_INVERT bit is set by default in order to compensate
> for that. Hence also set the SGMII_PHY_RX0_CFG2_INVERT bit by default in
> gsw1xx_pcs_reset().
> 
> Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
> Reported-by: Rasmus Villemoes <ravi@prevas.dk>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

This shouldn't impact the generic device tree property work, since as
stated there, there won't be any generically imposed default polarity if
the device tree property is missing.

We can perhaps use this thread to continue a philosophical debate on how
should the device tree deal with this situation of internally inverted
polarities (what does PHY_POL_NORMAL mean: the observable behaviour at
the external pins, or the hardware IP configuration?). I have more or
less the same debate going on with the XPCS polarity as set by
nxp_sja1105_sgmii_pma_config().

But the patch itself seems fine regardless of these side discussions.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

> Sent to net-next as the commit to be fixed is only in net-next.
> 
>  drivers/net/dsa/lantiq/mxl-gsw1xx.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index 0816c61a47f12..cf33a16fd183b 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> @@ -255,10 +255,16 @@ static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
>  	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
>  			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
>  
> -	/* TODO: Take care of inverted RX pair once generic property is
> +	/* RX lane seems to be inverted internally, so bit
> +	 * GSW1XX_SGMII_PHY_RX0_CFG2_INVERT needs to be set for normal
> +	 * (ie. non-inverted) operation.
> +	 *
> +	 * TODO: Take care of inverted RX pair once generic property is
>  	 *       available
>  	 */
>  
> +	val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;
> +
>  	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_RX0_CFG2, val);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.52.0


