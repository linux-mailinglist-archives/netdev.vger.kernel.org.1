Return-Path: <netdev+bounces-116591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D2894B1C9
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C92D1F229F2
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F243148FFF;
	Wed,  7 Aug 2024 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcT0qlXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484582D66
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065161; cv=none; b=C5ZlbcHGp5+yrQAHrhSRJqv7bKaTdUnIN+i2E5urHPGMAdEjyLrOqf5LGbfIg8af+vaUqXlcsTxRKiGxBL1z0OxK4HWlz8mAbXQQ2Dx18kscXFZiIuB4w6nU3vUC9kFkuNMmcufhNeFFCD3oXW518ZL5c0H0h/lhpj8UWGNYKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065161; c=relaxed/simple;
	bh=qo8nZsm6qR+4IT+p5NEYEC9kk0HDmIkwnZdYcMGrcj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1YTkEZZa4Y2AgJZ5QtnYa3ovhmbXdluyHFa+nD6CUFOYwzTz2WjVYVVzXDLm+dmio1OX/OUcCcY4NkTdvsBcVf958mwlEdmnI8mrHjJ24C0VaGn7WCghKCy9P+qZwuGFFMIFGYMONY3ZLLzqRWyiU3zYw0C0NADKj0RV8yQ9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcT0qlXs; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f15dd0b489so2931221fa.3
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 14:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723065158; x=1723669958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfjw8iC34PrA5PHgz75UyLcqswZzkWFzyqGWptq5768=;
        b=gcT0qlXsWpBud/L4/7c5+qN5lfpGZFM5Otz7pjuh/wAyuRUIcObiaEaqFvxaYO8HAx
         n+EwecogWJK/NeNcpZiMK29FMJBg3VkhhvHodr4/63hfJuvBejPNBYv1NNimrVImJFnh
         d8s/snLAuZ8XPe8rOeN0SD5PSIIoz6ahEp4VUKUHCOXdfEkLjZWOopT6rgQF2w8Js/2G
         kzsoP+gIO61bkt7S7pjDmYoSbPtg860YpwSRYkzZKvJZ9oe2FV/1ZLgMWjeMHQKBxWR6
         pYycsvtMoKE6yW0DVSuiBiqVAakxLRkK+K7T789zfQYl5yW/SC+9m+sHum6KtumAszlJ
         Z1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065158; x=1723669958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfjw8iC34PrA5PHgz75UyLcqswZzkWFzyqGWptq5768=;
        b=d0q9VWjWMmWDvp+lG4YROiG1N+Rzsjlu8fyXy6yJoWp+RR3wqQ2TESwJUqqfpcKnol
         awS+shRRAtcIHkH8JK+FAakC9jtY9qlYqsfCaiCr+FVN3bej1pRhd1yLcHXPvSAskGtg
         HIRYbz/oW4viR+rfK5BmBZT08OF5nYWnGJfMw12Qe9NTHW4VpKOqSR61xgKBjzrLdkyc
         Yp+6kLArDSrxYUNhii/7PPL++xabwFkem8qMKeiOsrnVgG0I0wtM28fKn8R4daTPM19H
         NYjArjzcqvrTA8QInznR9nhZmyuYclbSHkSBSjY9C/8B/t4TGfpeITl5KddVhCRa1VZq
         PT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbbO1erVk3S7n+kIC2Tk1F4+MWVSqKV30ZCobuLh6jh2oqDBD5N8QgLVFloETW+6LJwuWRTe2pV8F+S3ECgJqNRiDYEgEC
X-Gm-Message-State: AOJu0YwBdwkcbQZxnJZj1+28QmAaKrd9iFfg8xi49dSN3dbW1kXEoV6M
	XvZp7Yf49U03Og4rujan6P/XrheR15MDRyFEDgtzNxAzsyKKBNc1At0L9Z4wVvmG6bwTtMmH3Q6
	BIDGG5oJ2j12Yt1dnGP2o87PsIOM=
X-Google-Smtp-Source: AGHT+IGLHyPSErT6XbM7Pthz1NGSMWPxH4uBFOjmVIvQPaaG2NXzSfEaGlZVl5vIP1t++h/q/XQKvHCHb9gGrKDdkBg=
X-Received: by 2002:a2e:9c48:0:b0:2eb:68d0:88be with SMTP id
 38308e7fff4ca-2f15aa8736amr130598781fa.12.1723065157219; Wed, 07 Aug 2024
 14:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-mvpp2-namelen-v1-1-6dc773653f2f@kernel.org>
In-Reply-To: <20240806-mvpp2-namelen-v1-1-6dc773653f2f@kernel.org>
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Date: Wed, 7 Aug 2024 23:12:24 +0200
Message-ID: <CAHzn2R2HCBEGgOf-8530zUsamL4T2XRLFVB420TtcbVWSBJMKg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mvpp2: Increase size of queue_name buffer
To: Simon Horman <horms@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 6 sie 2024 o 13:28 Simon Horman <horms@kernel.org> napisa=C5=82(a):
>
> Increase size of queue_name buffer from 30 to 31 to accommodate
> the largest string written to it. This avoids truncation in
> the possibly unlikely case where the string is name is the
> maximum size.
>
> Flagged by gcc-14:
>
>   .../mvpp2_main.c: In function 'mvpp2_probe':
>   .../mvpp2_main.c:7636:32: warning: 'snprintf' output may be truncated b=
efore the last format character [-Wformat-truncation=3D]
>    7636 |                  "stats-wq-%s%s", netdev_name(priv->port_list[0=
]->dev),
>         |                                ^
>   .../mvpp2_main.c:7635:9: note: 'snprintf' output between 10 and 31 byte=
s into a destination of size 30
>    7635 |         snprintf(priv->queue_name, sizeof(priv->queue_name),
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    7636 |                  "stats-wq-%s%s", netdev_name(priv->port_list[0=
]->dev),
>         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
>    7637 |                  priv->port_count > 1 ? "+" : "");
>         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Introduced by commit 118d6298f6f0 ("net: mvpp2: add ethtool GOP statistic=
s").
> I am not flagging this as a bug as I am not aware that it is one.
>
> Compile tested only.
>
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/eth=
ernet/marvell/mvpp2/mvpp2.h
> index e809f91c08fb..9e02e4367bec 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> @@ -1088,7 +1088,7 @@ struct mvpp2 {
>         unsigned int max_port_rxqs;
>
>         /* Workqueue to gather hardware statistics */
> -       char queue_name[30];
> +       char queue_name[31];
>         struct workqueue_struct *stats_queue;
>
>         /* Debugfs root entry */
>

Reviewed-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>

Thanks!

