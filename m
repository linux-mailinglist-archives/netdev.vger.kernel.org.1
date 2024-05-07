Return-Path: <netdev+bounces-94093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A38BE1B6
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A671F22F65
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F00D158A13;
	Tue,  7 May 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4GclqcgJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EF6156F37
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715083759; cv=none; b=L+sp54u8fPf6j9de4YELsDb0OoPg6weJgOd8CQXFqDWjKJgIZUCZTzb6s6QGNqzAQyB37OP8wUAUC4YEjlRKDuaf5t9E7Mym2u9M3lYhE76dFPEiKG+QJhQjf0lTLx7KKUml7WkZe0g6plCt8vuRT2yY34bvRSXTHoyAYRn5uhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715083759; c=relaxed/simple;
	bh=nCTjlUzmtoOmhK2cGoJ2k79k+dMAvYg7fw4RMC20he8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glUE4qHrzh+GJnKGwAuIuSF86qyJpHlMLlvssy6Ysp4nYpd18atk4eZifCkchKRaXFwzjOmKr1ZCgefR5xvzMT2qhJ5qtXttp86Gy13HIF1RPvoftmOZSuRqCc/frAGUfgutWu07tAYg8fWz3h7bFro2RQOLLep+j0BBYEy9xPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4GclqcgJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso10771a12.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715083756; x=1715688556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTjqFCQBhDEh9ASvoTn8Tyz7XDGxyH7/+g9gqGqGy60=;
        b=4GclqcgJ8weDWIPiJ0yuHnuywLP3ITz7AkUENHadNm2kypcAw/CEk3rb9ghrA66F4b
         KiTvDgIJFS3B0397DYt5B4yPbjxwmwuooNlPprv1+2CIDAfW2GbypaAFsHuMUsvo5YCX
         Jsz8/EiOQgVepAzk7n4A4jtTdVcZav28l+n8ZXik1ijcDl/26XFkkLy6QBkB5pTuj6/B
         ELg6NHCfnde2B3B8g+wUsdQqbacCZ+8Qil5wcZH04cDfv0dUNrhOfQLiJItD9zc+yvoE
         m67ujIOzXvWdm/p7e9gOhVg4oaaAZIuW3GYLYGC4iDoUKBvRpuFh0LGayGFRwS0/S1QY
         ViIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715083756; x=1715688556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTjqFCQBhDEh9ASvoTn8Tyz7XDGxyH7/+g9gqGqGy60=;
        b=irTjeJ0hheYn7HU6k6dQiHdbBXT/BMzs3K4e7jAAZ1ILOiUWoOBLx50l+l680ZNm1t
         SPD72GdVmy9I8ztUV0XkwEZ7OBWQ1beEQ+f2rC1HGNszrGFvJAY0CsbKtC9GcUs39JFZ
         3TKpimj4Li/YtjyeH1s1un1l2fclVpGncUyvMZ4G0xLDXBX9ioVXx4KohIFyDvtZdv8H
         uhO/8W/gZCUQawvpIRfxQQcfmCWSI0uGN4bECNGasEfX1tDnF1PQ4iGAHLEZcb4Ug/kU
         ljsVadzfs5vrr4dGrRS2x/7qGa2S27zgMmfJ49EXIBiFWJZMqYz0+72FxeO+4sEFFgDs
         Nc3g==
X-Gm-Message-State: AOJu0YwW6vrUibivUJ8SyLLx284JHJlxsKHL37ncUbBt2r5O9CoBmnuB
	dw5qkNECI33J7Scdcjb9nXzCq9a/Ww2EUkmd40nIQmxsj8zQon7JnXh0nIWjah2gWPlPQuOtWoE
	O+5TVv3yfSf4wUtNw0HQpTaPydIIDXrMPDjrd
X-Google-Smtp-Source: AGHT+IGgzl+2Z0Ch0dEtdnETwkNx2lRaedYtL0MIFtrAOe+HBYQUxIjeACu5IumeESNcsEAmxvBVxOcyRLD9CkexnEc=
X-Received: by 2002:a05:6402:6d4:b0:572:25e4:26eb with SMTP id
 4fb4d7f45d1cf-573131c667amr137073a12.7.1715083752780; Tue, 07 May 2024
 05:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507094114.67716-1-nbd@nbd.name>
In-Reply-To: <20240507094114.67716-1-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 14:08:59 +0200
Message-ID: <CANn89i+kjcpuh8ecKkZKkKFGv2nTZxp1BA+BSgyPvSXLX-yfwg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add missing check for TCP fraglist GRO
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:41=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> It turns out that the existing checks do not guarantee that the skb can b=
e
> pulled up to the GRO offset. When using the usb r8152 network driver with
> GRO fraglist, the BUG() in __skb_pull is often triggered.

Why is it crashing ? I would expect tcp_gro_pull_header() to perform this e=
arly.

Please include a stack trace.

> Fix the crash by adding the missing check.
>
> Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index c90704befd7b..a71d2e623f0c 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -353,6 +353,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *hea=
d, struct sk_buff *skb,
>                 flush |=3D (__force int)(flags ^ tcp_flag_word(th2));
>                 flush |=3D skb->ip_summed !=3D p->ip_summed;
>                 flush |=3D skb->csum_level !=3D p->csum_level;
> +               flush |=3D !pskb_may_pull(skb, skb_gro_offset(skb));
>                 flush |=3D NAPI_GRO_CB(p)->count >=3D 64;
>
>                 if (flush || skb_gro_receive_list(p, skb))
> --
> 2.44.0
>

