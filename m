Return-Path: <netdev+bounces-168054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466BA3D37B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E360C189F427
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193051EBFF9;
	Thu, 20 Feb 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvuDOKZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611ED1EB1BE
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040883; cv=none; b=F+38oCtEo9zloOZ3go9GlQmNhVHIFITPh/w1FsrEtZrokuHHaQz19+moTQnJOmudh+TNdJgY93gO5f2eXhKn/tExWNfYF5/0NR9xWnFrNdiCz8JJ0d0f7nhIu1wUkEnEwNtCRlteiN1E9Z7eHl8Hf0WTp3NJ+wztT/6Hw+TeS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040883; c=relaxed/simple;
	bh=L664zTQ1YO5UiCR4eV/bv8qw2cOnMXFx6Vdv9gD0gtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roVLe0jf9nvX4Iltci0O6v9qb5MSiTEltwSUEsVC43wNpd0OWjqPkM+COnOa8qj2HkqqSmuoSl2HMinrc0J2X7aIVTRVm5eScNw8I0Tzx3RRtMEoD9quOisIcsyB381xnjIgZhQ8dasYPvvliwnUL/yF0/O/bAJ1ZgCfHOocuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vvuDOKZZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so1167721a12.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 00:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740040878; x=1740645678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/B0GfEgs5YAFmdnX0UDSsDPd37I3/eSnTdtkRhowSE=;
        b=vvuDOKZZh0edXdFrw517xJlg/fgu3R81X/k0zMZfHKL/xW3ffLlOs3dfx9FLdQ+/Vz
         5mNKg3g/thW4SKnfK1XaPLZ/koeRfrQURAPmFDCYoN+3XxM4ArTgfqtCYWkpedZL1Qw0
         7+tiSX4lj4rLWqtiklMp77JEmE9xnSKuxPeQOaGlUZ7E7A+DHx/4UXEy+/ODimGu2N5O
         /wPx47NerzK5IlqHR7DOTr+EmJcLlemA/nyNU4DYOZjAWpZrgYa/PH+m3D0vCn3uHr3o
         q9rJjom4hsGgwzG2Icrz6m+O09ZVcX1TiXfSwi/o/+NRGLNblLI4L5n0T34HKxPoQKiU
         2QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040878; x=1740645678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/B0GfEgs5YAFmdnX0UDSsDPd37I3/eSnTdtkRhowSE=;
        b=vlUoLg+/2tsKS9lgQPZf14Va4KvCJTfrOIWbrj6n4IMUsVfxdIKg+VPVLW6YbonFdS
         GTqr2vbe7ksMsxhoU51SBjra/9rpIqm67LBa/wq6okTI1mYcRJeli8m6hSf7tknk6f3P
         pw5PEWfRhHeW1dkn1GnTrrdduTHG0tAHb3y0RbP1V/oWWI/M3+jLMWlZQ/6a++208GD2
         YxX3J11R2174WT52LTaBz61vhazinwVl/TTW1yNujvWh4FbLgvPhapWScUBU5GPlrdq9
         xkhdgXeyGDHarQO2SOtGBU7MhDr0zB6GQdR6mOiKa9LEM274K3r0tL4tbyrtvjqkaGAR
         f0tA==
X-Forwarded-Encrypted: i=1; AJvYcCXmy7Hyj5uj3M0sZM7XN8nZOWszMvdGR1swbMJqMg+0+lHxJ3+3+Xccna9phZVxTzZm71g3eTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+gC++i3XDLwlcwXYf+n/8WN3sHQpyRpH0RQ79S+zvtWvcVJk0
	EZqQ/TSPpJI+FMxw7t08cOUjxAlSEOBDxgerBHyVSp4jWcBdoVzWKVNcTQv0iGiOg2EJlU+NkYA
	Hd6PdeilyiMHEeI0FZ6e5E2/SjQSv/3A9OSAO
X-Gm-Gg: ASbGncs+F3SBByDneEyEjajdxFwlpwddCOzNH97BREWy238hLaqClDl+ta3vFs9bylV
	B83mOZW71prgaxKh9CiL8ZFDi9uVlUhR9kGUF5jyuwhx4XVwmfTVruG4yQ7abOZB4nCdGMYULgt
	PfyVSMfYs2Xb7jc+/ITBaJt6qoWX2Dpw==
X-Google-Smtp-Source: AGHT+IFXcAFjpaJKujW5+KZDWSQQYXeZUtaOWrv/hWArWKingf+nZ1HYZNj6AugPO4FJR8wHz+Cx53odmSQ5wEFD2SM=
X-Received: by 2002:a05:6402:5246:b0:5d1:1f1:a283 with SMTP id
 4fb4d7f45d1cf-5e03604866bmr18955746a12.4.1740040878368; Thu, 20 Feb 2025
 00:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218105824.34511-1-wanghai38@huawei.com> <CANn89iKF+LC_isruAAd+nyxgytr4LPeFTe9=ey0j=Xy5URMvkg@mail.gmail.com>
 <4dff834e-f652-447c-a1f0-bfd851449f70@huawei.com>
In-Reply-To: <4dff834e-f652-447c-a1f0-bfd851449f70@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 09:41:07 +0100
X-Gm-Features: AWEUYZlEUz2j68qETDQCnXjzA4LCLg5wCCIyRAG4vH3HmM2uGgUFOuI3cdrgTlw
Message-ID: <CANn89iJGzLBVpOExJyeR3S3oVU2pUp62BpuqD3HgRay5aBK7ag@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix error ts_recent time during three-way handshake
To: Wang Hai <wanghai38@huawei.com>
Cc: ncardwell@google.com, kuniyu@amazon.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:08=E2=80=AFAM Wang Hai <wanghai38@huawei.com> wro=
te:
>

> Hi Eric,
>
> According to the plan, can we fix it like this?
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index b089b08e9617..1210d4967b94 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -814,13 +814,6 @@ struct sock *tcp_check_req(struct sock *sk, struct
> sk_buff *skb,
>          }
>
>          /* In sequence, PAWS is OK. */
> -
> -       /* TODO: We probably should defer ts_recent change once
> -        * we take ownership of @req.
> -        */
> -       if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq,
> tcp_rsk(req)->rcv_nxt))
> -               WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
> -
>          if (TCP_SKB_CB(skb)->seq =3D=3D tcp_rsk(req)->rcv_isn) {
>                  /* Truncate SYN, it is out of window starting
>                     at tcp_rsk(req)->rcv_isn + 1. */
> @@ -878,6 +871,9 @@ struct sock *tcp_check_req(struct sock *sk, struct
> sk_buff *skb,
>          sock_rps_save_rxhash(child, skb);
>          tcp_synack_rtt_meas(child, req);
>          *req_stolen =3D !own_req;
> +       if (own_req && tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)-
> seq, tcp_rsk(req)->rcv_nxt))
> +               tcp_sk(child)->rx_opt.ts_recent =3D tmp_opt.rcv_tsval;
> +
>          return inet_csk_complete_hashdance(sk, child, req, own_req);

Yes, this was the plan ;)

