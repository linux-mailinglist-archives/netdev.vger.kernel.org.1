Return-Path: <netdev+bounces-70393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5E984EB5B
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 23:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1321C24DD6
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935974F8AB;
	Thu,  8 Feb 2024 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="TiF3HWMr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7634F8A2
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430278; cv=none; b=bHinrSzvO+dHia7NuM4QmWP4yA0ALTnjrilwk1IjGN8koo9MbpE30Le7RG9NRAxzDxq7nXzSN94ouiUyoQYyKJ0f9K/FanhgQxJb5gBYKrFGKzEfGcsnW9+2X+OClNRE4WeqHoeTshWv/SzBG5X6qVrvtIMPddfe5shhlwQ1Psw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430278; c=relaxed/simple;
	bh=WEf2O+BigS2jZRoOKQXdQYIoHZM4Jwq2kgMcdS0LIGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBWnIr+vmLHeujAZfbFN1LazEYk6OyJJ9dQ7ntroAEJ5DDNNE/dxoDYb2fyYO9EoTqsqPBThYi8iHUixEAoLr/eAWe4+gJ1EPFLcxP3sFQNAC0WjVPp5ENKQx/e7agVp8etbEjaWz/lfLqhq1L50MthFvfnUkUsZl+8ixCrzMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=TiF3HWMr; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc74897c01bso313287276.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 14:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707430276; x=1708035076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbD3Ab67e0FuudOFI/lHLwL0zswy8Knqo0sCgR8RT4s=;
        b=TiF3HWMr9WL2SGx9LUoHoFYqtaBlWfjZ0vkXvCE3oERG3jQlmLbISOik645lGUUjPN
         FfR/UdV9vxXhmty/V8Jg1JESPNl4lgqbT9R/dGrCsMS0eMUPHcGCYEroj7JDCSqtygEZ
         wp0miv+qrYysUH/YjaygI4+cEwyoMyNJ2p5A62EjUMEu4HgeJN4WsYDXG73a1XxopkmE
         xOtJcmV3hWHWOaROE8D2i8HivQWxusJ+mHaKzbTe3WuPE7nqXI8yRQZwQpBQnmSBIUsQ
         O9vAuFEkEoX1HZ2d/5zUmg2Fi150vQzfis9cdkh3h+YYxphabPW+Ih0SqaRKU32R/IDA
         8rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430276; x=1708035076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbD3Ab67e0FuudOFI/lHLwL0zswy8Knqo0sCgR8RT4s=;
        b=PKHm/NxtQtIYqhD9VFKLCdsuXovelZBgsJZJVyeFWUE67OBdXfI1pyFvIZWBT8Bq0e
         GB+oLxIeZiiMQdsxT1xVdr+ZpZHyKJIc96Xq11HxqsChGJKNDhMCqttbsttAhmSmg8s6
         EtIyrhUp8N0eR275y6zck+YWcHIE1YhuRuJE75PWYz7bMWUqZTu95YuRTlxjCu589oAe
         Oan7RjniVTPQvOD1aH04KRfx05bXHv2+W5jcD3Tte57erNuUIjs6y9wUUwcZO7DuPh4w
         FZnnyFhke65hU+SsGwLpi/kTNhqKKDtSFryzTmbyfflLuMkuDz7JQpu0zwlZQWgX1rfZ
         r4wA==
X-Gm-Message-State: AOJu0YwZszBb1JBdk5tEQczjdssjh49ATe0AheKTLjtI8+Im8UAuU8x4
	dLCiZF+WwcProKWw6zrwf8rfDUOxJOSA1K8SgFugu1XcLOiJtQO8z79wlJ1nnRu98ZlYIbCJVNw
	6QKPBV6DIHNxfh/o5UA/uhPgFPStKV7G885nV
X-Google-Smtp-Source: AGHT+IH7HT2xjL2wo04Ce3vG2hy8V8F1MsA5zD3w7pmCZFDAtcTdmu8xY+zNdQ7KU7jg1CfLuRNGKPXsey2rtvJaZdE=
X-Received: by 2002:a25:2606:0:b0:dc7:4cb1:6817 with SMTP id
 m6-20020a252606000000b00dc74cb16817mr876351ybm.22.1707430275645; Thu, 08 Feb
 2024 14:11:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208164244.3818498-1-leitao@debian.org> <20240208164244.3818498-8-leitao@debian.org>
In-Reply-To: <20240208164244.3818498-8-leitao@debian.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 8 Feb 2024 17:11:04 -0500
Message-ID: <CAM0EoM=A81V8X-UMAivq_u=52tbv8z+dAzE3TfYG5wqzww6ivg@mail.gmail.com>
Subject: Re: [PATCH net v3 7/9] net: fill in MODULE_DESCRIPTION()s for net/sched
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:43=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the network schedulers.
>
> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/em_canid.c | 1 +
>  net/sched/em_cmp.c   | 1 +
>  net/sched/em_meta.c  | 1 +
>  net/sched/em_nbyte.c | 1 +
>  net/sched/em_text.c  | 1 +
>  net/sched/em_u32.c   | 1 +
>  6 files changed, 6 insertions(+)
>
> diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
> index 5ea84decec19..5337bc462755 100644
> --- a/net/sched/em_canid.c
> +++ b/net/sched/em_canid.c
> @@ -222,6 +222,7 @@ static void __exit exit_em_canid(void)
>         tcf_em_unregister(&em_canid_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch classifier to match CAN IDs embedded in skb C=
AN frames");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_canid);
> diff --git a/net/sched/em_cmp.c b/net/sched/em_cmp.c
> index f17b049ea530..c90ad7ea26b4 100644
> --- a/net/sched/em_cmp.c
> +++ b/net/sched/em_cmp.c
> @@ -87,6 +87,7 @@ static void __exit exit_em_cmp(void)
>         tcf_em_unregister(&em_cmp_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch classifier for basic data types(8/16/32 bit) =
against skb data");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_cmp);
> diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
> index 09d8afd04a2a..8996c73c9779 100644
> --- a/net/sched/em_meta.c
> +++ b/net/sched/em_meta.c
> @@ -1006,6 +1006,7 @@ static void __exit exit_em_meta(void)
>         tcf_em_unregister(&em_meta_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch classifier for various internal kernel metada=
ta, skb metadata and sk metadata");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_meta);
> diff --git a/net/sched/em_nbyte.c b/net/sched/em_nbyte.c
> index a83b237cbeb0..4f9f21a05d5e 100644
> --- a/net/sched/em_nbyte.c
> +++ b/net/sched/em_nbyte.c
> @@ -68,6 +68,7 @@ static void __exit exit_em_nbyte(void)
>         tcf_em_unregister(&em_nbyte_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch classifier for arbitrary skb multi-bytes");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_nbyte);
> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index f176afb70559..420c66203b17 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -147,6 +147,7 @@ static void __exit exit_em_text(void)
>         tcf_em_unregister(&em_text_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch classifier for embedded text in skbs");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_text);
> diff --git a/net/sched/em_u32.c b/net/sched/em_u32.c
> index 71b070da0437..fdec4db5ec89 100644
> --- a/net/sched/em_u32.c
> +++ b/net/sched/em_u32.c
> @@ -52,6 +52,7 @@ static void __exit exit_em_u32(void)
>         tcf_em_unregister(&em_u32_ops);
>  }
>
> +MODULE_DESCRIPTION("ematch skb classifier using 32 bit chunks of data");
>  MODULE_LICENSE("GPL");
>
>  module_init(init_em_u32);
> --
> 2.39.3
>

