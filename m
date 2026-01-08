Return-Path: <netdev+bounces-248215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 945DCD052F2
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 949C230069A0
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B62D6E70;
	Thu,  8 Jan 2026 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4gE6Wnm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8A2DAFA8
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894642; cv=none; b=GNbienE4Wi9buKiUKU/cnETUgQpEd1Ld9bt1VZvrPpvGFYSGOj3PuuIw5xTDRO3j313fdtHFsV1b4exuT5G5JOwbetg1t26s6wasod/ODVOsW6cxPuJ9EONROJdXJdWS1YP3sJyXN/fxCyraZsM3/WFS4/AM9S5QzrVno3/tNDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894642; c=relaxed/simple;
	bh=RfQVyKUXBw6cuxkLX4XJaOO6aX7s+1kMyYL02xwHHxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZICrRzM0qdJH6JjwjVfNMtlBmTWOt4InPcllD3mrPDTYjKKAW7dzPH2FbGr1TAKwTvs0AYLabYC6z4mnjFHFY/EL2wF7IOp8V696Bke1v0b7eK+P8w2MCauTygL6thNKLnxF+DYFvFDLZSSmFUypjHe/3qcKQxdv2bBriFg5O/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4gE6Wnm; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso35700481cf.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 09:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767894640; x=1768499440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9EKwNjRX/VJoL3Yzvpe0aHopVtj/2lVjsAvDNdDh+c=;
        b=f4gE6Wnmv/4I3sBnRdV82sY+EfBaAV1E+PpOkDZnUUOYhfK/FoeLOe5B83WHkJiWDx
         gm8C8Gvl2og2thV5dnl624pPYDf5pMspt4ccDzUO3VxJCvFEbJzbMZt6XefCNkmIEVfX
         exx/ftx88sh5xGoKUkY1qBGbEZK6y5wVEWfpdC20McqfOic/V2RtITSBMFdA6PhK9jnC
         hpEc0S3IOmjtey6MhTQMAJoiPcldX00Qsb8W1gc3vJ0A5bY7KNIaeor8PkAZ329hjEHA
         /FwDvEHWWf0gbjP5rQIAdH0jjCt3SqMjtZ7gyWu2ZS4WWDmvCFOD40p3FUa6BH/F1GqX
         TdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767894640; x=1768499440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u9EKwNjRX/VJoL3Yzvpe0aHopVtj/2lVjsAvDNdDh+c=;
        b=grFVDSiXjn71/NKKLHflBOPAz4MQoWVQXlJZEoIcuju84hYPQkzsxHqxQ0P42q2Nsn
         dlAgGFV3jiccaN9epPOlfrdazY51cnh4r44ZFrSexFGwphHxeyVr/mwbuIYco5yHnLQx
         VkLHgMbpUIhoi+JmSAk6T5+DCnve44v4pCDHgH2M+JQvAXDYPAxrsR2h9WCkj1KB41TR
         F+Y5az10Bng7+loNVvKiLoiamHvFdTo542Yzd6kr56X6hzazXt9zQlehz4fy3tc8hPm+
         sfW7W7M2vrRZGNRmA9u9v9wC9Rwn7CQUS9noBDTzoF38Aqm62+p2r6O9HUW63GW0G569
         zZpA==
X-Gm-Message-State: AOJu0YyFQ9KIvlXxC2fiRwwWIE7EVF8gHGvrxcrbWUDJm2HJjQ0SJUz7
	afPMKyPvNnZyQZum+U4EocgP5cIZo7dJ/moITuTxHo0nSb3q1QlwceutD1Hkxnz60rm/hu7gZxt
	TxreEZgyuOR6T8tZXKgSyUMOF+EEfNCOYYaE4jiAD
X-Gm-Gg: AY/fxX4TrbmS2JS/lvvGMVSlWwDmRnPHjeFswRbc1slKCr3ZWC7xBPG9NMUejc0kEQ4
	OOdEKCFmDGaup9WpFtSBtjRnN/DFHmuflMVz8CDGZysWh0IStV0bma1061xQ9ZlugyUfic4AZwl
	1ElplKT9QqtMMY5lgwv1E6P5HRDzYPjpzqh3u8O0iwcYdZUrFrhtIFrVZEdUO0HRMUjJ9FadtsX
	ZqBGblH4uFOnmuHBCpgOExpGLaBdZtwXaOugTK+PndWLbXiAuDtQWdWIzgSUNGfQd/yPw==
X-Google-Smtp-Source: AGHT+IHSQ3bsqPZl2nmCzswv6vCwgBTf3tZqTP32TJkE9bfCxTQfzSbItY1py9Vn6X+L6dFuK5uwijydgTwTB7DFFqY=
X-Received: by 2002:a05:622a:5a12:b0:4ff:8fc7:917b with SMTP id
 d75a77b69052e-4ffb4a31a01mr97075031cf.80.1767894640110; Thu, 08 Jan 2026
 09:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108174504.86488-1-boudewijn@delta-utec.com>
In-Reply-To: <20260108174504.86488-1-boudewijn@delta-utec.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Jan 2026 18:50:28 +0100
X-Gm-Features: AQt7F2pV9HAk3RSHDWyQ3Ei4bD2-VYn4RdWxEyEaJoCdyqTaBfvwZffqfsbu3oI
Message-ID: <CANn89i+x2LGnBJES1y0HWQC2xVo__53_QHFYjuSs7s6+ShNBtw@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: Fix use-after-free in macvlan_common_newlink
To: Boudewijn van der Heide <boudewijn@delta-utec.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 6:45=E2=80=AFPM Boudewijn van der Heide
<boudewijn@delta-utec.com> wrote:
>
> The macvlan_common_newlink() function calls macvlan_port_create(),
> which allocates a port structure and registers the RX handler via
> netdev_rx_handler_register(). Once registered, the handler is
> immediately live and can be invoked from softirq context.
>
> If the subsequent call to register_netdevice() fails (e.g., due to
> a name collision), the error path calls macvlan_port_destroy(),
> which unregisters the handler and immediately frees the port with
> kfree().
>
> This creates a race condition: one thread may be processing a packet
> in the RX handler and accessing the port structure, while another
> thread is executing the error path and frees the port. This results
> in the first thread reading freed memory, leading to a use-after-free
> and undefined behavior.
>
> Fix this by replacing kfree() with kfree_rcu() to defer the memory
> release until all RCU read-side sections have completed,
> and add an rcu_head field to the macvlan_port structure. This ensures
> the port remains valid while any thread is still accessing it.
>
> This functionality was previously present but was removed in
> commit a1f5315ce4e1 ("driver: macvlan: Remove the rcu member of macvlan_p=
ort"),
> which inadvertently introduced this use-after-free.
>
> Fixes: a1f5315ce4e1 ("driver: macvlan: Remove the rcu member of macvlan_p=
ort")
> Reported-by: syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D7182fbe91e58602ec1fe
> Signed-off-by: Boudewijn van der Heide <boudewijn@delta-utec.com>
> ---
>  drivers/net/macvlan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index 7966545512cf..d6e8f7774055 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -47,6 +47,7 @@ struct macvlan_port {
>         struct list_head        vlans;
>         struct sk_buff_head     bc_queue;
>         struct work_struct      bc_work;
> +       struct rcu_head         rcu;
>         u32                     bc_queue_len_used;
>         int                     bc_cutoff;
>         u32                     flags;
> @@ -1302,7 +1303,7 @@ static void macvlan_port_destroy(struct net_device =
*dev)
>                 dev_set_mac_address(port->dev, &ss, NULL);
>         }
>
> -       kfree(port);
> +       kfree_rcu(port, rcu);
>  }
>
>  static int macvlan_validate(struct nlattr *tb[], struct nlattr *data[],
> --
> 2.47.3
>

I have sent this instead

https://lore.kernel.org/all/20260108133651.1130486-1-edumazet@google.com/T/

I think my patch makes more sense.

