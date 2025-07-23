Return-Path: <netdev+bounces-209238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07787B0EC7F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262AB3B740C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C75278173;
	Wed, 23 Jul 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="We7v/14B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6E27815E;
	Wed, 23 Jul 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257439; cv=none; b=FGjHHaGDVctg79e3Hmzw8fMFI5Epe6xDs1cAJQlSr9VovQhWFIqVI7oq7XSaZ7lOv9oYPPFMY4X/+Z1sGSfolNvPwOEZcP20GABz4k5PaRupfAfmFYce6fcaZCLPHNjI6+AB0+/dFaFVIuk3XVsFRK9KDEx5X+JabjZsQf0SvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257439; c=relaxed/simple;
	bh=tdAL6jB4Ko7Lztc4ajkspFeVq6iUKILRJD4GvTuV/9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oK4QpDWArluTbbU6O8vp9T1dtiZE3uUT24GNfywW+dcLPE/rA914zui/v8w+oPE0TAoGC9pex4y7jg81W9Z9WRyemgCZVuLdpvzOVB/00UTOdVqIetvmqgzrUleuNCjH0vOsGdtLWF2Pt99DMEboyHiYR3E5tzIqKpUp8MXrAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=We7v/14B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386F3C4CEF5;
	Wed, 23 Jul 2025 07:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753257439;
	bh=tdAL6jB4Ko7Lztc4ajkspFeVq6iUKILRJD4GvTuV/9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=We7v/14BqDrhc9FrahJg4aqfjxDxm23gqFn/2D1/W1r+LRTJ01euREJaJoI5DMiN6
	 iC6P33QYbZgUY/GaJFmLvrpDQrtyfPK8xZyz5tVdMzGE3ZXhQLuw42vhCeNbODwKia
	 6w2r8fkHhyObHbIH9uK+3tjMchi+eaaMkVd7/Nmi9JwI28U6t5md2GcqFVBHd+21W8
	 yGdZIOosQqN5dP59ta0IFNBLoDH/S0bj0q6+QFeTEm3mwVo5fNyFb6Oqy6BX2VKTxe
	 cSz8e0Qncy40/5bmK43Pt5qbj89NlrE4oGpxuAwrZ9hH0mewFJmkwvaK1a6IdtkZ1e
	 8+a+ZcKS99mzw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so12238901a12.0;
        Wed, 23 Jul 2025 00:57:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsSUKT9pMTFutJGRNORN0zvq8I64y+LoLo4Pe6VffRlOMJ4g5a2fqkGNxgkuMKXCtKUqURTfNa@vger.kernel.org, AJvYcCX2CPaaA2qnpBpro/+ibV3zSzG7CL1kDgzkINJsL5iBxuiEU7ScojKzIFzi1dbuDhbwxuk5H0wFL9hmtXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaL7ZM+1u8Onh3nDdJVyngb8aGiyaWcvN8xg41tpwv+DOoOQPy
	ni8FNcU+rYbZRMZPpAZibce6jUbE5z/jRIL3HW4zoTHkPUF8jAW29QKxYJ0uawO6tvjNd66/XUm
	apcIi+YRehIMxX0K+JrLhCWcQ6X2sXDQ=
X-Google-Smtp-Source: AGHT+IGIF7AVBA9b0CBAQLpikyzPtrMgp6p7LCmQn3Tsnr/SlGGly8L96wf3Glz5EOjEESdHNbzxzbVV6HAoeupH2hc=
X-Received: by 2002:a05:6402:42ce:b0:609:aa85:8d78 with SMTP id
 4fb4d7f45d1cf-6149b427070mr1740625a12.8.1753257437717; Wed, 23 Jul 2025
 00:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722062716.29590-1-yangtiezhu@loongson.cn> <20250722062716.29590-3-yangtiezhu@loongson.cn>
In-Reply-To: <20250722062716.29590-3-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 23 Jul 2025 15:57:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6seOazKUDwpqEwokv2-dYJX8sa03p=2ye8C-d=Bj8-wA@mail.gmail.com>
X-Gm-Features: Ac12FXxUAg2s71SmfpE9ISn67doyybcYHPiL-kDLYehl6ymK9jmGn6iRkOyyaVY
Message-ID: <CAAhV-H6seOazKUDwpqEwokv2-dYJX8sa03p=2ye8C-d=Bj8-wA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: Check stmmac_hw_setup() in stmmac_resume()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 2:27=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> stmmac_hw_setup() may return 0 on success and an appropriate negative
> integer as defined in errno.h file on failure, just check it and then
> return early if failed in stmmac_resume().
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index b948df1bff9a..2bfacab71ab9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7975,7 +7975,14 @@ int stmmac_resume(struct device *dev)
>         stmmac_free_tx_skbufs(priv);
>         stmmac_clear_descriptors(priv, &priv->dma_conf);
>
> -       stmmac_hw_setup(ndev, false);
> +       ret =3D stmmac_hw_setup(ndev, false);
> +       if (ret < 0) {
> +               netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> +               mutex_unlock(&priv->lock);
> +               rtnl_unlock();
> +               return ret;
> +       }
> +
>         stmmac_init_coalesce(priv);
>         phylink_rx_clk_stop_block(priv->phylink);
>         stmmac_set_rx_mode(ndev);
> --
> 2.42.0
>
>

