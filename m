Return-Path: <netdev+bounces-84560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB54897515
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 18:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CFA1F23822
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690F14EC77;
	Wed,  3 Apr 2024 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="31tQzLjj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3F14F11C
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161294; cv=none; b=lqOYPvzMnot12hW22HCdl+holetS2vWk346iwLFi4e5nCQJ4m8ldhBLqg8KRo8eFYFemJAN68lqEbd4khE+TIxTTmrRDFhKxf6tmXZv0H8hZCUSx3OgvWKhesZJ0DmhPhLILEseUaYZW4uCPVE5YNI9nUYRhLnycICQ/E0XNbFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161294; c=relaxed/simple;
	bh=mGMMo3ZLfBeEvFFcEaT6KGVRAap1af/uQhQPH9tC3L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2yiyng0n16993Gwhh2Umv/QmW8l085untvcB0tLxSlxg4hiJSHT5+n2B2kh/bv7qEyzIZXFSXHgLqvpDWk4mVP7FI2u7AQjnpNYS0pvRBkqQ4c3IlkzObt/n8z4uVxkT+SNFUxKZoroA+2pv8MWzownWXEq13TzFaY7lCoBo28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=31tQzLjj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so16891a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712161291; x=1712766091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrWLuZ4ObysZMS0zaWAlDYfXTxfcPhZfcNQjqQVazpM=;
        b=31tQzLjj0U75P+/+l2i2haApIOI2XR4r+BMyLbNHEQ+ffMkccL2oY5pwPx5HFYuMMb
         XCDF3s5LDHcWMmqM9VuNFX6p7vVGllBHb7GXhbe77KJjOsiV3142kF1EuVHMUZ5G1MtI
         Ca7Ccyi2m3MwJTr2TyFcx0RpHZ8CQkjp7JjS2QbBOgB212JP3SUHxtioM9gXK1+2AWbc
         WjGDpWzC+z8Gs7ZnAUJvrlNEWa0T1/pVXuyoxtf1zkev6NszZrRKMeZYSJRUCDykw/Xq
         oplWxotKhM5FC22kd70M4KBGzYcWMyVZqZTu+UcGAi7Bzs0z8fM0Dk1GkDfaZr/c/rec
         Regg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712161291; x=1712766091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrWLuZ4ObysZMS0zaWAlDYfXTxfcPhZfcNQjqQVazpM=;
        b=AiVFChRwe4bDRqiVLFIdufwCaDUJKo0OXDLmV02C7MuTa2pKhZRoaXiTZHmxh/wSX5
         iGlwdFKEmZw55UbbZ8tP+CwajBvQBbHdzWOs/MqF1PzyFwywwkYIEYUe5ZFLc/c2HVD0
         e6UZBWUFyzzcBk317R+fPIBn0BqJ6Sm7UL6UQWg61xubuaBcCtycVfmviCyNhjz4NC1U
         SCEjRtQv0tPMk/NBkn28tr2mhoNNYOBg4/VYz8hmNx9dq0MXCrPlLIu+2ibVRRVpqW2S
         Pg58mGMUsxWMFHHI3VuKMaZB3Retd5AEYqI6HPaKRwDlKqnhKN1omWhgRhh0azqmwHl9
         i4Yw==
X-Gm-Message-State: AOJu0YzIRQq6mhO2v0UqTrlQ7d3WZAsOGnB2mZ0uWF4LOmtsISnc7BN9
	wh1TAI7XNWkjMSZUc1ISdWBXZnyElOC3dOW253A+c96AvMEhouphoWn4EaWQFnwsbXc21TOItgq
	Ddk7/LV+3nlShj5yNImF/XfIxp4gNoIEz7NDo
X-Google-Smtp-Source: AGHT+IHqV8nh3vs9uhNkXP0lLQJS/1dz3NMJOgbEg6uNtHu92rE4PVTE04B0MRBxCsUDGhcO1KcLKcgChP/Y6+vvnXQ=
X-Received: by 2002:a05:6402:3591:b0:56c:5230:de80 with SMTP id
 y17-20020a056402359100b0056c5230de80mr305436edc.2.1712161290502; Wed, 03 Apr
 2024 09:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403152844.4061814-1-almasrymina@google.com> <20240403152844.4061814-3-almasrymina@google.com>
In-Reply-To: <20240403152844.4061814-3-almasrymina@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Apr 2024 18:21:19 +0200
Message-ID: <CANn89i+X7er9A+gF-7Q=DB_EQfWxQO5X+kPuPqMi1xGbVAV2CA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/3] net: mirror skb frag ref/unref helpers
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, 
	=?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Florian Westphal <fw@strlen.de>, David Howells <dhowells@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:28=E2=80=AFPM Mina Almasry <almasrymina@google.com=
> wrote:
>
> Refactor some of the skb frag ref/unref helpers for improved clarity.
>
> Implement napi_pp_get_page() to be the mirror counterpart of
> napi_pp_put_page().
>
> Implement skb_page_ref() to be the mirror of skb_page_unref().
>
> Improve __skb_frag_ref() to become a mirror counterpart of
> __skb_frag_unref(). Previously unref could handle pp & non-pp pages,
> while the ref could only handle non-pp pages. Now both the ref & unref
> helpers can correctly handle both pp & non-pp pages.
>
> Now that __skb_frag_ref() can handle both pp & non-pp pages, remove
> skb_pp_frag_ref(), and use __skb_frag_ref() instead.  This lets us
> remove pp specific handling from skb_try_coalesce.
>
> Additionally, since __skb_frag_ref() can now handle both pp & non-pp
> pages, a latent issue in skb_shift() should now be fixed. Previously
> this function would do a non-pp ref & pp unref on potential pp frags
> (fragfrom). After this patch, skb_shift() should correctly do a pp
> ref/unref on pp frags.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>

...

>  #if IS_ENABLED(CONFIG_PAGE_POOL)
> +bool napi_pp_get_page(struct page *page)
> +{
> +       page =3D compound_head(page);
> +
> +       if (!is_pp_page(page))
> +               return false;
> +
> +       page_pool_ref_page(page);
> +       return true;
> +}
> +EXPORT_SYMBOL(napi_pp_get_page);

It seems this could be inlined (along with is_pp_page())

