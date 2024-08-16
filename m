Return-Path: <netdev+bounces-119284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C7A9550DF
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3DEB210A8
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427511BE873;
	Fri, 16 Aug 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XzgIC5Qp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1C1BB6B3
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833074; cv=none; b=m+9JRU0EAAg/fvQyGjc+DyBHEhDUcHi0+12BGgaMOgWbyb5QTRYO2lhUG20vm5S9yqEfQsglKHMMDQaGgV4ZlIabNhHn00m5NBwskvgoRF6ye882Sqr6EuW0pf1IYxPWwKkPT1ihK9qdWHfVoS7ZXBJNXlokYDVm80pgDReZtd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833074; c=relaxed/simple;
	bh=uhcp3WZFLxQgQfnu4wAaQeAS1geKbGsIKl4HHwyijRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5c2vZ8E7RphSB9Ss1mxlG6z8UsJvXDXc+9KhxCkPtl6l/7SqYOjeorU1ZRf8Vnlg0u6ulF+gF6xufCYaD7zZRSls+pZBWU6/pyvOCBuHDoPDAfHO3jX5dTPe5+ZdOJmgNcdseLm/Fb09a71JD6BhhCVlYCg39OrLy0UWfBsS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XzgIC5Qp; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f6b8b7d85bso781302e0c.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723833071; x=1724437871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQJAIgd/BEbyvSRpuIu0cmDP252zyDFStxo8ODaclzY=;
        b=XzgIC5QpIf9kkgNf4jX/jTeceR8tRBtHxlriboaaQKw6esNU6d1/54Y0B7/u3pXLGG
         S/uR7gtfNTyAzXLHDHP3/j4ttOD8uRuy6Mb44mAWvPnTaAJYaCM3+mw6n6ZiZqe01xzv
         NB68hLNSnt65jZApVLeg1WL+DXVrNyEjBiAOmahQw0R1BpNOdxCESTFO+zs2sd3RR2A1
         1xRj02jSJwGMRy3DyoKC5PpzvVc9UKndG3I2RRaPSFxb4eIai78kTcOZ7lg8TkdEyIS1
         q6rsOD91oI6RaHOuGTKrc0yCzaROuQ+i10gtsHurWWPcGEVVpUsNYwmqYIyciepH5iKQ
         vkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833071; x=1724437871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQJAIgd/BEbyvSRpuIu0cmDP252zyDFStxo8ODaclzY=;
        b=vetqvL7prS5fpj5PDM0CRiDMocMMKoB1ApjQ/NqF35+IAc0wVj41aacArTWI4Gxrgf
         hEipgAQx/oAq4Pw7wnsbZpBD+Q9ElaacKeA1uawjrVL8ZppPCwEkPsz/IkRhsdq7s4qs
         OPgT65CCCbkfMuSLpVpozjdhTM6mffom1oYh5KZkd7cC6YO7EdvvuV7vcGkPRvQUdGvK
         gjeFFSUy3EsLggRUv6oJjib1Hg0eoPoOLJoB8jsN3m7H/w+jl1EKwD5e38gxEwmSkJIC
         QX2rlLb3ievvwpFlcV7FoUJN+FGrYijUcQRBG3P38oPK8Tn4ZhnyKLfBkOPMzPkCn9u9
         xx2w==
X-Forwarded-Encrypted: i=1; AJvYcCWnnsgjqus1ILpTsSmjW8XB+0YFiYzld/I3RSMMolm+vdpNuIFhf94QqimfGUOtKp2/0yWRkUnbFQhIFKbCxoFH5q8NTmVM
X-Gm-Message-State: AOJu0Yw0195Ww4SNrj4W9edr36XXHBVe5sfzwKrQM1vmZxT3FqQQc3Le
	cO+JC7IDl1s7KBxWbb5LrdGBg/XS0IUDNkM2BkSjwckt4fyCL+dDegiDnvrGzsUyiH178GVJdNa
	6/2t7busUA5mqMl1wBhfBkumjbKUD4l+0CqCAP21Nv8pvpOAEp0HG
X-Google-Smtp-Source: AGHT+IEo7ihw2rCkZ9z2tQcHda907ojygUEBgq2VAYybHsuz3+8IQenZr6hfJCQXXyuiRvZohAzF85ygqVzPh48vUck=
X-Received: by 2002:a05:6122:17a3:b0:4f6:b18e:26e4 with SMTP id
 71dfb90a1353d-4fc6cb22c20mr5066861e0c.10.1723833071255; Fri, 16 Aug 2024
 11:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815214035.1145228-1-mrzhang97@gmail.com> <20240815214035.1145228-2-mrzhang97@gmail.com>
In-Reply-To: <20240815214035.1145228-2-mrzhang97@gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 16 Aug 2024 14:30:51 -0400
Message-ID: <CADVnQy=+Ad3cHHCxge37OKm=fHi6+aHyyy_0hp7p4VCSAGX4cw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/3] tcp_cubic: fix to run bictcp_update() at least
 once per RTT
To: Mingrui Zhang <mrzhang97@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org, 
	Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:41=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail.com>=
 wrote:
>
> The original code bypasses bictcp_update() under certain conditions
> to reduce the CPU overhead. Intuitively, when last_cwnd=3D=3Dcwnd,
> bictcp_update() is executed 32 times per second. As a result,
> it is possible that bictcp_update() is not executed for several
> RTTs when RTT is short (specifically < 1/32 second =3D 31 ms and
> last_cwnd=3D=3Dcwnd which may happen in small-BDP networks),
> thus leading to low throughput in these RTTs.
>
> The patched code executes bictcp_update() 32 times per second
> if RTT > 31 ms or every RTT if RTT < 31 ms, when last_cwnd=3D=3Dcwnd.
>
> Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
> Fixes: ac35f562203a ("tcp: bic, cubic: use tcp_jiffies32 instead of tcp_t=
ime_stamp")
> Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
> Signed-off-by: Lisong Xu <xu@unl.edu>
> ---
> v2->v3: Corrent the "Fixes:" footer content
> v1->v2: Separate patches
>
>  net/ipv4/tcp_cubic.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 5dbed91c6178..11bad5317a8f 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -218,8 +218,12 @@ static inline void bictcp_update(struct bictcp *ca, =
u32 cwnd, u32 acked)
>
>         ca->ack_cnt +=3D acked;   /* count the number of ACKed packets */
>
> +       /* Update 32 times per second if RTT > 1/32 second,
> +        *        every RTT if RTT < 1/32 second
> +        *        even when last_cwnd =3D=3D cwnd
> +        */
>         if (ca->last_cwnd =3D=3D cwnd &&
> -           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
> +           (s32)(tcp_jiffies32 - ca->last_time) <=3D min(HZ / 32, usecs_=
to_jiffies(ca->delay_min)))
>                 return;
>
>         /* The CUBIC function can update ca->cnt at most once per jiffy.
> --

I'm getting a compiler error with our builds with clang:

net/ipv4/tcp_cubic.c:230:46: error: comparison of distinct pointer
types
('typeof (1000 / 32) *' (aka 'int *') and
'typeof (usecs_to_jiffies(ca->delay_min)) *' (aka 'unsigned long *'))
[-Werror,-Wcompare-distinct-pointer-types]
          (s32)(tcp_jiffies32 - ca->last_time) <=3D min(HZ / 32,
usecs_to_jiffies(ca->delay_min)))

Can you please try something like the following, which works for our build:

           (s32)(tcp_jiffies32 - ca->last_time) <=3D
           min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)))

thanks,
neal

