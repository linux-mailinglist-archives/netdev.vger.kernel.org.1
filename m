Return-Path: <netdev+bounces-53246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB712801C3D
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 11:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69268281550
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3142CBE64;
	Sat,  2 Dec 2023 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sfgp9dqk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF3D123
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 02:35:02 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso3141a12.1
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 02:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701513300; x=1702118100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7KLR1V49A85aDqj3DT7Qp07q2fPdNDOn1B86Di+C7g=;
        b=Sfgp9dqkHoGHTj07tOsTyG+y3GawVn/Cq62ywh00q+1ixz21bYWFEcTQDdl84Ei50E
         hRNzK2O6z/JserAzvZUDCYUhlQlLYsaW+aCVrNActBbvjf2bu0MMQ1qS6bD6s6AvRzUl
         WuxPEzKz+anfzhSdKXH8xEcXyCYZNrf+vJ+R/XfefhnxzuLuBNq3HXQPMp1kQ27xEzj+
         L6k9z14f0jkfWnnyK2Dq2b7qvGxgH9xpEfNnVBtjlHjWxgCbd/Jb1FlmkCgW1n0aROFu
         s5n2Ge3yI5XpfDwRFF8A6G047tvG+vrVon31mzf8F63QZNaYeBAercHEVEXQIwJpm88I
         q6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701513300; x=1702118100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7KLR1V49A85aDqj3DT7Qp07q2fPdNDOn1B86Di+C7g=;
        b=S6MGYVK2txV2WbWXKIgO6/OTisXIIeQKZzeL7N04KO3O+ryIW91tlHzonS06yi/nbx
         6mN395ha31Uo8vuNFU4PujAw7y3Y/56Y3As8iNIDA18XnxREX7FHaofDdoNFLJwGA2dL
         vrMyB0sQjP38Ie0Z/5mPoes5dgvygbfaFyo6e3NYeNPnhKt6HUSvH+6bYJuyQykl8X+2
         9EbIbREH/d73/mREOHQKHB6nkIPkqkdo8qV1gm20RKu9nqfRjh4kHYqCZfrWnMIL+Pl5
         BYXFwCKNS8kmLR9yUQBwawgR1RHdx5kZcRjafnolZV0AiWjnBBbmR++rz91E1mPbxey0
         vp+g==
X-Gm-Message-State: AOJu0YzvbToXpcFgnVOD8Fy4Ye+r9C2CUP0VnEkdwFS9IEs2YHLyOc9v
	4Byxkpo8jpn2Hf9bCiFs2IitD2EsrFwPuPL0zUajBg==
X-Google-Smtp-Source: AGHT+IHUq8X4h15xM52/LypICK/y4gsVcQNhc1jtFO/Hy1h7vmTZe+8RM5wyX8Cft2+EviJMvXlVooAfRQNXHt91Ifw=
X-Received: by 2002:a50:bb48:0:b0:54b:bf08:a95f with SMTP id
 y66-20020a50bb48000000b0054bbf08a95fmr278726ede.6.1701513300138; Sat, 02 Dec
 2023 02:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201025528.2216489-1-shaozhengchao@huawei.com>
 <81b8bca0-6c61-966a-bac8-fecb0ad60f57@huawei.com> <6569fa1a427c0_1396ec2945e@willemb.c.googlers.com.notmuch>
 <61c80195-db33-fa38-6b1f-007f651eebe2@huawei.com>
In-Reply-To: <61c80195-db33-fa38-6b1f-007f651eebe2@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 2 Dec 2023 11:34:46 +0100
Message-ID: <CANn89iKXDvO8MHFn4fbuYdCjqzsYDNR0QkRpXNqj+1GDD9Jkww@mail.gmail.com>
Subject: Re: [PATCH net,v2] ipvlan: implement .parse_protocol hook function in ipvlan_header_ops
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, luwei32@huawei.com, 
	fw@strlen.de, maheshb@google.com, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 3:14=E2=80=AFAM shaozhengchao <shaozhengchao@huawei.=
com> wrote:
>
>
>
> On 2023/12/1 23:22, Willem de Bruijn wrote:
> > shaozhengchao wrote:
> >>
> >>
> >> On 2023/12/1 10:55, Zhengchao Shao wrote:
> >>> The .parse_protocol hook function in the ipvlan_header_ops structure =
is
> >>> not implemented. As a result, when the AF_PACKET family is used to se=
nd
> >>> packets, skb->protocol will be set to 0.
> >>> Ipvlan is a device of type ARPHRD_ETHER (ether_setup). Therefore, use
> >>> eth_header_parse_protocol function to obtain the protocol.
> >>>
> >>> Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver."=
)
> >>
> >> Maybe Fixes should be: 75c65772c3d1 ("net/packet: Ask driver for
> >> protocol if not provided by user")
> >
> Hi Willem:
> > Definitely not anything older than the introduction of
> > header_ops.parse_protocol.
> >
>     Yes, I think so.
> > I gave my +1 when it targeted net-next, so imho this is not really
> > stable material anyhow.
>    But, if skb->protocol =3D 0, no matter what type of packet it is, it
> will be discarded directly in ipvlan_process_outbound().
> So net branch will be OK? What I missed?
> Thanks.

This never worked, and nobody ever claimed it has ever worked: this is
a new functionality.

net-next seems appropriate to me.

It seems that skb->protocol =3D=3D 0 is only used by fuzzers, or careless
applications ?

