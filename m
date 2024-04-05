Return-Path: <netdev+bounces-85120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D77889985E
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D651B21361
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B09156F41;
	Fri,  5 Apr 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqlnanNG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21F1E898
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306805; cv=none; b=cTQFbXCD/NzEOUkASYXEqvrIweija5gcFlhGJc8+h3VXsuFt++TR5mCC0GdpHDfgCO+1Z/oDKcgb0AQ18vCjJ3Cg2Begps0KtZctRYBUajTCuGNjK8kNT+ncBr69qU5nsggn1dnQfcmih4KDqT//Sn9cvfccDRNIWoqw0du3y+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306805; c=relaxed/simple;
	bh=idk0MM3W2P2J2l37DE4I486TwtzE8HyFdg/Q+f0/0Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOKBIz8VqViYO1kb1Mjq2AmNMq49a1Q/WGIZOGrOdcrb41k65a1Mlkg2PwpY/I+nYtdmFQu8GkVYYU5P26NYVOI9MI8wW7UjEk8LVLFCaJckhv9qSNgmAIohGDS465Wf/Y1m1XhBiE9HVBavCATjke+hXgHJDeba2v+XWs5+zAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gqlnanNG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so7293a12.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712306802; x=1712911602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLjMSi+14Hj3xEqyxme36Gwoz1Gt1Sz3UQ5n2a0WBGM=;
        b=gqlnanNGfouu/IdEcVfZTgN8MmllTemhGHnQnzg/sW0AD7iHUUAVrZxqHhAzK7D/PT
         D1F8YOHTxt1ATZBJIICAcm9DHWlVFZb8TQh+6cQF7GmpVSiloCztu1yDjdDB6weHOa/H
         B7U2rS+b+xf00tmEJjnjd5sOmHRynn5PwqxFlUGGfCF4Z6I+tvheCl1EcVYwQaAz3qRe
         mgMs2HP9qo/94i+m2dBU+ZmUR03+KHStL1RQTDcTI1/CJVYL0AghjGC6tJlLUkQZTfbZ
         XhgUxYd2z4ykAUs4A5IGRbReKe8oF+gbKDVBVvgnv/KciDKe4cLwgC0yx0zTk2AbIDuC
         pswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712306802; x=1712911602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLjMSi+14Hj3xEqyxme36Gwoz1Gt1Sz3UQ5n2a0WBGM=;
        b=ns2K0snD2HtD20aJ5TVLYZV3dIHDfx7XPjHzJ2ndF955xcNd9ddaWOPxxVqaSy6srR
         A1kDg2wRxCX5GPx9TGgmTKqW554ZV9Aitwo14sJNOU/oChGKsPZ2DMhWh5VMRt0d0MwY
         +J1od7jr52PAi5nkjhnTdeBr5aRKQLX2fpP0+59cERU7FgrTWRAeympLnvxSZfEtnQan
         WF5Rg3ufRc+0nruzFlC5z2T7ZxifVfqZB/Sr+CGxNfwBgWC08nM6DimHG9KbORlFpvqK
         8Ex2Xjda99U6K4Nh7gopJaMUZlst/AkjHqaOOGHDIhmzqeRnYPvAgQL97wQXUHFth5rj
         86Hw==
X-Gm-Message-State: AOJu0YzxeYviSPTtkIG8NKZMLe7gRROX8Gc+HZxlkKvTzanYAntu/Pyz
	4sp7zjMr6pHdpgME86zvy7DzOTI20hg6TcqrvaPKQLFl9GEWb39dLuKx3Px+MUIVdCXMFt1AjDF
	GRP2W4NVEucQvn8jH6lhiKJi3R/UqbnL5oTu67iPDqA5dpos4/S5D
X-Google-Smtp-Source: AGHT+IEBlV7UfM/9iAiMTJjcTRPHesarzXb7VqFVFovM3bNRvsXU58sw2YINrqhAxIJhBcATxTlZluEl5DT6y23lNCY=
X-Received: by 2002:aa7:d987:0:b0:56e:2b00:fcc7 with SMTP id
 u7-20020aa7d987000000b0056e2b00fcc7mr181317eds.0.1712306801567; Fri, 05 Apr
 2024 01:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00c5b7641c0c854b630a80038d0131d148c2c81a.1712270285.git.asml.silence@gmail.com>
In-Reply-To: <00c5b7641c0c854b630a80038d0131d148c2c81a.1712270285.git.asml.silence@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 10:46:28 +0200
Message-ID: <CANn89i+XZtjD1RVBiFxfmsqZPMtN0156XgjUOkoOf8ohc7n+RQ@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v3] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:38=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> Optimise skb_attempt_defer_free() when run by the same CPU the skb was
> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
> disable softirqs and put the buffer into cpu local caches.
>
> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
> throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
> I'd expect the win doubled with rx only benchmarks, as the optimisation
> is for the receive path, but the test spends >55% of CPU doing writes.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>
> v3: rebased, no changes otherwise
>
> v2: pass @napi_safe=3Dtrue by using __napi_kfree_skb()
>
>  net/core/skbuff.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 2a5ce6667bbb..c4d36e462a9a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6968,6 +6968,19 @@ void __skb_ext_put(struct skb_ext *ext)
>  EXPORT_SYMBOL(__skb_ext_put);
>  #endif /* CONFIG_SKB_EXTENSIONS */
>
> +static void kfree_skb_napi_cache(struct sk_buff *skb)
> +{
> +       /* if SKB is a clone, don't handle this case */
> +       if (skb->fclone !=3D SKB_FCLONE_UNAVAILABLE) {
> +               __kfree_skb(skb);
> +               return;
> +       }
> +
> +       local_bh_disable();
> +       __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);

This needs to be SKB_CONSUMED

