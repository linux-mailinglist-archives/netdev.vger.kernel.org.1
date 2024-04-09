Return-Path: <netdev+bounces-86282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B724289E4DE
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C62D1F21294
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58C5158A06;
	Tue,  9 Apr 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Em6SanlY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092042905
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697805; cv=none; b=XIF082qTIrv8WrIOwRmacuCUiNLhKzMgwoiEmlkwxki2vTi/bH+LG8UtzmJ7M2T11vViP69Y8i2BsdE9LiQxWlbdb04btcvoP6jeEVUSgn3S+0CSf3ZynaGsXMujoqFJEYHCUkQee0vHUvuUmkH+JDtz+PQJkvS3iCeeBEtHeu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697805; c=relaxed/simple;
	bh=FiX8W7HF1MK/0zsip7oUBsBlEvtQZNIz8g011vOB+XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak1Uqk1D100wUfzYOXGfg9JoLprgy+6UB+DYzAo8Bb/FYXS1awtC01uNOvq29necmK7vlQE35CULTCCyuiDxM9MaHhzpvbCP+/Xi6vtyWjXPZHDaRZNkHc0MqtF+c2N06sHbNJxrQFyyp4+MH80Lh3V0jukTDwzqpeJAIJfz7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Em6SanlY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so1709a12.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712697802; x=1713302602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmr60K10E/Hz9GEYdYJj0oUpVxSw9dVZslvAtQU8N6I=;
        b=Em6SanlY6rVJ201h/6jFKWfmKTUr3CQvZBpI+OZi/Uf/PmHTy/9ceLBHHj6Gr+L9CD
         DcnDEtsMW0TybT12LPELuDibGdxkxTFA1CB7tLRYhCRav31ZA+4zCH1YKpMl/G57/GXU
         PkcCN9QnXth+Cp5g1tHcyFlzAGATflgF9dQQcXYcQVoRuIZ2Rj0pgjypt+nMV4+P+Zsh
         YRnNvcSojaZv1gCk8rLKuvfka6P2MPdKwYwi+zkrHfcSRE/NsZek/vyhBOeYKtVgDuQw
         U7BZLVdNTQi+852YM1ZL/L4ghNC3ZX9Q1y/hrlLZLY08OA0biXLCPAKOB33laZmnIC8B
         93+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712697802; x=1713302602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmr60K10E/Hz9GEYdYJj0oUpVxSw9dVZslvAtQU8N6I=;
        b=EsN5Rqjdguk1PWo/NMR4qdEF9jz2Sq4e9f3hslHAHxlEsG1ea0MK9ozdO9hsQ9+mbz
         +YVIAbaqvqfYn4peLTpdGHnV1nxATqnRFwZV3i+0CD73AG7QVq8feaUJdFf/S7+w6S/b
         86OSsjnMLKyIwjRlKNzGjBP9j+42DyAw9p1/sgakUvMmIsVcYj/YNXmkAWu41WISHYHV
         hg/gSMcak+Gg8ktKMCol0BOKcDats5A3aPEuWuXsxK62jcxnU4DRx7U+4WXbYAZouWIk
         w2ZhoCTNzaNis04iwiqRA+07TXtTwFph5rg4EgbZzhgP4YUokXjgMMKIDzoDLkGh/zdt
         fOnw==
X-Gm-Message-State: AOJu0Yw0hldrP0uaN554WRm1FHOK4ykXA8g9+Dfd8dOozgsnwNLbq5ie
	jkPeQ2/f9EOKch75SiHDVI0PuyghqkDydjgTVf2qPySlzOw0vxuy3HMSrAFgzAmZbhXl1lAqAOx
	RcIvDNGQuunbaXZZX8QCGXlzpp58MB25XmRK6
X-Google-Smtp-Source: AGHT+IGnIEff66cm8k44AgSjESZPelQeiTVI3ipmTO4l9urtP105xh43lnLAxfXCVpiQRw7isqRk7kDthCYd4pJYscg=
X-Received: by 2002:a05:6402:c0e:b0:56f:3a0b:8e05 with SMTP id
 co14-20020a0564020c0e00b0056f3a0b8e05mr2475edb.0.1712697801978; Tue, 09 Apr
 2024 14:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409205300.1346681-1-zijianzhang@bytedance.com> <20240409205300.1346681-2-zijianzhang@bytedance.com>
In-Reply-To: <20240409205300.1346681-2-zijianzhang@bytedance.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Apr 2024 23:23:10 +0200
Message-ID: <CANn89iKjoEaSgHHKNvgWJ+Ro=rY_Z4ZzukTKe1Qn3y3Bt3X_-g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] sock: add MSG_ZEROCOPY_UARG
To: zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, cong.wang@bytedance.com, 
	xiaochun.lu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 10:53=E2=80=AFPM <zijianzhang@bytedance.com> wrote:
>
> From: Zijian Zhang <zijianzhang@bytedance.com>
>
> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
> However, zerocopy is not a free lunch. Apart from the management of user
> pages, the combination of poll + recvmsg to receive notifications incurs
> unignorable overhead in the applications. The overhead of such sometimes
> might be more than the CPU savings from zerocopy. We try to solve this
> problem with a new option for TCP and UDP, MSG_ZEROCOPY_UARG.
> This new mechanism aims to reduce the overhead associated with receiving
> notifications by embedding them directly into user arguments passed with
> each sendmsg control message. By doing so, we can significantly reduce
> the complexity and overhead for managing notifications. In an ideal
> pattern, the user will keep calling sendmsg with MSG_ZEROCOPY_UARG
> flag, and the notification will be delivered as soon as possible.
>
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  include/linux/skbuff.h                  |   7 +-
>  include/linux/socket.h                  |   1 +
>  include/linux/tcp.h                     |   3 +
>  include/linux/udp.h                     |   3 +
>  include/net/sock.h                      |  17 +++
>  include/net/udp.h                       |   1 +
>  include/uapi/asm-generic/socket.h       |   2 +
>  include/uapi/linux/socket.h             |  17 +++

...

> +
> +static inline void tx_message_zcopy_queue_init(struct tx_msg_zcopy_queue=
 *q)
> +{
> +       spin_lock_init(&q->lock);
> +       INIT_LIST_HEAD(&q->head);
> +}
> +
>

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e767721b3a58..6254d0eef3af 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -462,6 +462,8 @@ void tcp_init_sock(struct sock *sk)
>
>         set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>         sk_sockets_allocated_inc(sk);
> +
> +       tx_message_zcopy_queue_init(&tp->tx_zcopy_queue);
>  }


FYI,  tcp_init_sock() is not called for passive sockets.

syzbot would quite easily crash if zerovopy is used after accept()...

