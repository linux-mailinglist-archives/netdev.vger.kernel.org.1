Return-Path: <netdev+bounces-127102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D7F974200
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26ACE1C25146
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FE91A4B81;
	Tue, 10 Sep 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9mFQrO0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B216EB42;
	Tue, 10 Sep 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992566; cv=none; b=jrk2t2LSeBHDAF/0oTkbJYzW1dKr9P2seiGOfH2bhkOEsme4O72CkACLoenEnEP8o2C4aVooOtd2qXFycILjQbokJU5QwfM0OURfIK5vIH9oKMXqpQqSPrjxhY1euSXNscNetixTAggyt6v9b+9oSz7WWwB3Jf7oEZUHQtyDsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992566; c=relaxed/simple;
	bh=xR5NTaSMbYj4ZehRGp1/cl6e1HcoqhLmP7LUPF2RmLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifHd3yNXm1mPfWwcVklIZhrNSPoFICYjxmD4+9+yxiCm+1nq2LL9CjFH+45DCJFUtrNtG6mx+avdK8IBekFSfZGvpcVpI6AYMYtfK7LrMteWU9iZBCGlznHX5FzM9wuTVsQEBNap0WyIb9B4unrFDurw77O8C2YbPloVTJDlQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9mFQrO0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6b5b65b1b9fso8453207b3.2;
        Tue, 10 Sep 2024 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725992564; x=1726597364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbeMAeN0RAbJbXbFRhOX2bNfTFBkVjN7xMef6UeUJ94=;
        b=H9mFQrO0kje4o3RFnXGCS+14lm6d5d+grG361cqMR6x69x2bOVwA8ILe7bAxwwnBCT
         CA4R0vS33JtGLE452zbvmK8pcuuC+tb7iNzDCZ4+LnWbjdxnZKAuRLet8AOxCLO6IpOb
         NB4lTlX6RK4VH2GsdZrZygUH8xbSg9bQNfQldzsR8mnbmHrAYHdRT5sfZE4MY6iccIst
         H8GyNDIInkVAi7ZLeXd4Fdu1A9gN2CakFTW4stbm0WpD+i0FHf5YvlJ5OnVW9V5LJohT
         UUmxNNlHBiEygCSDKvH0dM2Rb2Pf1qb5UOIRjRkyXrq/OgfXUaTvM4lIWguha5FjPGGt
         +HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725992564; x=1726597364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbeMAeN0RAbJbXbFRhOX2bNfTFBkVjN7xMef6UeUJ94=;
        b=fXzkpsEEt+q7ycul1RTRt30Y8Egz8RVHHazAgxkbayGCeTjAL7jVEW01ZJxiMCV3Lr
         y62s/3pDu1wk+q5/3l4zCaaWzjBsWBKnkbkGLCkpNX6T5JMn4w9XZ8oNDeYNmYZNwnXj
         4hLGlTxuGMbU96j7WmRq+1kYxup3F2KPZteElyBsUd1ZT9pU5E4ckuFOtvIiuNiCG4sp
         otobDb97rXfwXpOcKoTD7UcN2DLYXW0icElsfwbk+V0+WTfF9pYDt/fq8abw/fYh0glB
         kd+xSunp7oIZPWFriWFAx3f/vrq+87gB+HOApr99oe+ybt3nChhTEPy6r2VngDcN0Iu9
         +kmg==
X-Forwarded-Encrypted: i=1; AJvYcCUwDCM0jgu+rQVTtLmGRvIVVZfXfwJb1yHysyl4SDkQZuD34BNruldLn6HABHNRwe3vRE5fcg4zh8mQdVY=@vger.kernel.org, AJvYcCWVSj7DBCSWFW+zlpLxzFGKfZTRk22J2EgKRBaHTevF4eoBRiOpaNJHUgqhccl927ghExOcjoBU@vger.kernel.org
X-Gm-Message-State: AOJu0YyvFzN73LEiIghSkmDqiQIG14aYhaz72D/zWiiTroT23ajmYE+1
	ntSR+OYEDhyEyPJQriSWE0jhBCLYgiw8b7mp2TK7Qnr74JZuhgVFRpaudKVU56qHRLWYMVBqtyJ
	qJtmdqCTu64bYVkmw39SgG3Ny/a/eFng5
X-Google-Smtp-Source: AGHT+IEnHPvAdaRqE5rS/F8CivZTzc7aS/kKCnvmwbW0RHuJSnS+D9vNolNxYrn+nXgEyHkas05vs+wFx+E20Xnn9yI=
X-Received: by 2002:a05:690c:fd2:b0:6cf:8d6f:2bef with SMTP id
 00721157ae682-6dba6d780f1mr7008587b3.7.1725992564452; Tue, 10 Sep 2024
 11:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910152254.21238-1-qianqiang.liu@163.com>
In-Reply-To: <20240910152254.21238-1-qianqiang.liu@163.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 10 Sep 2024 11:22:32 -0700
Message-ID: <CAKxU2N-nLMn-VnR62xfuoJR2-1mtNTYQyLAiazpdmp89JSNndw@mail.gmail.com>
Subject: Re: [PATCH] net: ag71xx: remove dead code path
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: chris.snook@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:30=E2=80=AFAM Qianqiang Liu <qianqiang.liu@163.co=
m> wrote:
>
> The 'err' is always zero, so the following branch can never be executed:
> if (err) {
>         ndev->stats.rx_dropped++;
>         kfree_skb(skb);
> }
> Therefore, the 'if' statement can be removed.
>
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
Reviewed-by: Rosen Penev <rosenp@gmail.com>

err was used downstream in OpenWrt when platform data was used. In the
transition to OF, the function was removed. Which was back in 2019 at
this point.
> ---
>  drivers/net/ethernet/atheros/ag71xx.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet=
/atheros/ag71xx.c
> index 96a6189cc31e..5477f3f87e10 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -1616,7 +1616,6 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int=
 limit)
>                 unsigned int i =3D ring->curr & ring_mask;
>                 struct ag71xx_desc *desc =3D ag71xx_ring_desc(ring, i);
>                 int pktlen;
> -               int err =3D 0;
>
>                 if (ag71xx_desc_empty(desc))
>                         break;
> @@ -1646,14 +1645,9 @@ static int ag71xx_rx_packets(struct ag71xx *ag, in=
t limit)
>                 skb_reserve(skb, offset);
>                 skb_put(skb, pktlen);
>
> -               if (err) {
> -                       ndev->stats.rx_dropped++;
> -                       kfree_skb(skb);
> -               } else {
> -                       skb->dev =3D ndev;
> -                       skb->ip_summed =3D CHECKSUM_NONE;
> -                       list_add_tail(&skb->list, &rx_list);
> -               }
> +               skb->dev =3D ndev;
> +               skb->ip_summed =3D CHECKSUM_NONE;
> +               list_add_tail(&skb->list, &rx_list);
>
>  next:
>                 ring->buf[i].rx.rx_buf =3D NULL;
> --
> 2.39.2
>
>

