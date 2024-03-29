Return-Path: <netdev+bounces-83162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 102128911E7
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 04:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41AC1F21E92
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C411037165;
	Fri, 29 Mar 2024 03:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2u4g3QQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E314295
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 03:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682512; cv=none; b=g/8eptVhnUZrvYZHp4kGV08Fw0MxFslf71SfwqI+t58/auEe978GJMW9FOKYbn49dBG3WgLc200pvdpqkfSVIB/femFoCuHLWqR/uZwnKQLAidC0Pok9heQR0fOCfdbf1qQgMGl886pYdSlkpUYy3Pqqk1Qrofm27QtihEQO8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682512; c=relaxed/simple;
	bh=1JUzIWBipXcsLjT/imixpkLGkVOtkjP0NTS089Hpi/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPRymMGX18X6nPf2tmW0Vz8PBgkidmOhv4tMUGF/oUaajJuYDv+d/WP8h9I1KEW7oeYFTGURUz9q7oXWPzRTTJNsBumCtDC7dSounIPeBmdaQLQw6PfH5pElCqJ5qLnL9VqO0ViCcSYzJ8bxuvI51zRcjuTM33QcRIlcnPxbZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2u4g3QQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a466e53f8c0so204197266b.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 20:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711682509; x=1712287309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWwOSzE6w7S+dxg8vCVevwwWvaMsOqOPUJ24xw1pb9g=;
        b=H2u4g3QQskVTORXUJgZt5Goz7RrW+ARH8T0J2XCl9oxI3SP9C4NqKuBhHIoQSrKCfX
         aV3Yt80w3ivu5gbF+KVxsRx+EgaFUc0awrocQWjjzDAW/NYQ4wqrIFVTVGdqZQPCfjh4
         hCrYVHBo15/xhaSms6Z0QsNGrTYJmHv+RkGVErss3BmWQxn+6AyehlYPuKEsHfyufUfj
         OnhFE+tQ9bgSU0kBZQ39t9uKzkTush17KaYluWsPz7q8ioLmvWCuIvDMj+Wsn36r5n1F
         vmXWvXcBhunspBaut902hQHOAi2rHAe2J1R5lfh//DrQDKnvGs58cbPPUM5Kb+gD8KTU
         I3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682509; x=1712287309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWwOSzE6w7S+dxg8vCVevwwWvaMsOqOPUJ24xw1pb9g=;
        b=CtVrTVmbaCUuJeFkCzIBThhQjdpR/IeYSkoKPok6Zn9Z4QrjhDWxEGQ+VbuB4yz6Ki
         Hdxyc2PvDTjNqTDpQSQ60bbMbRGEhlgBHwzXzpcN1WyeCPmmF9h/PF2XTR9dL/R1/SJy
         EfM6C8/YPGmVjHLcjEIxH5geRuxAM4VnwO7LM9asgRNdfRhrSJcPE3KQCjGV2leoPls6
         CwunxZ4Gls5a9qqIQD3YuG5JyhgInJ9zqq+ZO0PCvtZrxBzsEUsSd0x/G+Q79AA7qbvB
         b6T2ZVRWjS+jzEop5uCM0Bp/LjHygcR7Y67apCIkf8wNvArrUgOew5elLYtXC+ML/qU8
         hzlg==
X-Forwarded-Encrypted: i=1; AJvYcCV6dFcWaqac4fYvoz+KP7ATgJdfKcqvx2nMi8XH2NnKTTit8y+7EnardC4thQl+fHcfg1fLf1ITYpIgB1ZdNltft7I2kV4C
X-Gm-Message-State: AOJu0YwJ2lHPWP0ZL7b5zi5VwYtf2K+NJLKUnaAraqEv/cwqGEsX8VfJ
	10kKbQchr/dzz7U1RH++ct4yrTinm1n6D4kVyJH51r1sbEn3QqvUFZaMgxGWT+SPzfEEziUFZaJ
	531j5M7zzVEGSlhBsQ31VDmfPOw8=
X-Google-Smtp-Source: AGHT+IFFhsG7KHAHMwBa+/qkxBXLy2aFIWOyrrCUI4SUonqrUyP9UpNHQHcTOggqD/raO7PYCZmiSQh+WU3KukPXvPs=
X-Received: by 2002:a17:906:c24c:b0:a4a:850f:28fd with SMTP id
 bl12-20020a170906c24c00b00a4a850f28fdmr730680ejb.29.1711682509461; Thu, 28
 Mar 2024 20:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com> <20240328170309.2172584-4-edumazet@google.com>
In-Reply-To: <20240328170309.2172584-4-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 29 Mar 2024 11:21:12 +0800
Message-ID: <CAL+tcoCOwddRuis=3NYOXv0Qwuw9qaLPHY2OAOPyYamKwBHbQg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/8] net: enqueue_to_backlog() change vs not
 running device
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 1:07=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> If the device attached to the packet given to enqueue_to_backlog()
> is not running, we drop the packet.
>
> But we accidentally increase sd->dropped, giving false signals
> to admins: sd->dropped should be reserved to cpu backlog pressure,
> not to temporary glitches at device dismantles.

It seems that drop action happening is intended in this case (see
commit e9e4dd3267d0c ("net: do not process device backlog during
unregistration")). We can see the strange/unexpected behaviour at
least through simply taking a look at /proc/net/softnet_stat file.

>
> While we are at it, perform the netif_running() test before
> we get the rps lock, and use REASON_DEV_READY
> drop reason instead of NOT_SPECIFIED.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/dev.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5d36a634f468ffdeaca598c3dd033fe06d240bd0..af7a34b0a7d6683c6ffb21dd3=
388ed678473d95e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4791,12 +4791,13 @@ static int enqueue_to_backlog(struct sk_buff *skb=
, int cpu,
>         unsigned long flags;
>         unsigned int qlen;
>
> -       reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
> +       reason =3D SKB_DROP_REASON_DEV_READY;
> +       if (!netif_running(skb->dev))
> +               goto bad_dev;
> +
>         sd =3D &per_cpu(softnet_data, cpu);
>
>         backlog_lock_irq_save(sd, &flags);
> -       if (!netif_running(skb->dev))
> -               goto drop;
>         qlen =3D skb_queue_len(&sd->input_pkt_queue);
>         if (qlen <=3D READ_ONCE(net_hotdata.max_backlog) &&
>             !skb_flow_limit(skb, qlen)) {
> @@ -4817,10 +4818,10 @@ static int enqueue_to_backlog(struct sk_buff *skb=
, int cpu,
>         }
>         reason =3D SKB_DROP_REASON_CPU_BACKLOG;
>
> -drop:
>         sd->dropped++;
>         backlog_unlock_irq_restore(sd, &flags);
>
> +bad_dev:
>         dev_core_stats_rx_dropped_inc(skb->dev);
>         kfree_skb_reason(skb, reason);
>         return NET_RX_DROP;
> --
> 2.44.0.478.gd926399ef9-goog
>
>

