Return-Path: <netdev+bounces-65476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F211A83AB93
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 15:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1E7282FBA
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FF67C0B1;
	Wed, 24 Jan 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVjZa+uU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68C67C08F
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106078; cv=none; b=uczVm/1uElGCkD7kiKas1tWgdcG898tZdsvqU5lDnLIwHbSHyqGaRT4mrYEXR1yWBFAKer6jVODhh4K9TfTr6RmUCXa9607kaLD65aSkxTy8hLVXqUYeo2PNzQe0OxSMa2vPXTnhDeGo1gxr1x7VUmlI1+YoU4Y1rpLv+Db3lCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106078; c=relaxed/simple;
	bh=GnTjBsyrCuegyOmbA03kOsK7Opyc1DUlg5LnFIoUnTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhKr+JxN+TASUQs8SiiCLxe50ZIWyaB9XWkmU45vOIWZIrDTb522rBvhJo9phtBVVamFFCCGLlvi9zOlFx6NEwKO6Vp3wVv1EnJDedQdJ6znwjSe6yqBd+2DGKMoTkJ+mzUNiVJImBnh7tfq2Pg8/oaM1liRKVGG/m4Ro47IlXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVjZa+uU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55cc794291cso7112a12.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 06:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706106075; x=1706710875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPkt1O53o4y1Mb37GtkgExXvpnZ2VLaGyLQKVoeFog8=;
        b=HVjZa+uU9csG7kksR7prAOqKD0LI8Lft5HDCz9XVmGAGm9BpYj9dBmLM/h0eNnIKkR
         9QG5Dvk5YBjpQfiVXuMoaaR15TwalLwr+GTvAOcNAGoePLegWSbfz3yU51W2WwD9oM9l
         b1xDL2aGKeegCX9dBHrqMyoX/pEnjBa2llhQL3DlR5mkJBJg6uk/wqF4V1S/KXyQKoLp
         B/REsifNTjDI6+vRJ9p4ECAGMxaV9yHh7EIpo3zpyzcNxulM/02M8WusNtg7z+yiOYBW
         nQi9TYii/b0QgWP46vGsqycoclrtCfe5SR9YfLyPVWvg/yunfZfN7BMQqx+x2DU+pWjV
         ChiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106075; x=1706710875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPkt1O53o4y1Mb37GtkgExXvpnZ2VLaGyLQKVoeFog8=;
        b=RdtkcZ93cC7Lz5rL2stOKFV9F5GxpD7uN+ji0MSUKhKR2Ak32Qvh6zbm7tChDizO3w
         4Sf//yyAFp0dL4oXreTrYo5R+CSovpOdA60o5I4ZG4f9rAWAbGKmgj+qCQ+Z97ddFXon
         7fUQmWGsjI1Vj/9svy8B60fDRv8Gkc4DkIOWsnUR3fgq6Nl6DXxfIs8p5KH0P/nDpyNv
         G7eM1i1+ihaSQ+lodgEVeM6sXF2N99V1vKIszlVRfa+OB0jKLN7wX8OWpUJfzA3E4Xk9
         wCFdyx404TJe/K5FJV2ILk01R2qQICoikgIMx/rCmQKuOzaVLuAlYZ+uKFnhGWBaIZnb
         zmJw==
X-Gm-Message-State: AOJu0YwZeDbq+GzdqCVGzVTjaRppkdyBoxCHiTJaOuwDKBlBAe8gIJ8y
	5gF6QMVLXOTWrVWfmXLqWZ0s/POs6QgS31ZU/GAIHDFM94cCVwee5aURBEM6Ir4jje8Vs5OqoqY
	qHB28/sEjwM/Uv2HJiqlmS0Lc0InMtQBKXjva
X-Google-Smtp-Source: AGHT+IGzPIW/ZTiE5rM4s1QmgeYCRbqoqDwCLlTosiqzLqsOQ9SGrLdR2PNEwLRpjtvOpk+/mNF6YQnMOCmYvWE2bbY=
X-Received: by 2002:a05:6402:313a:b0:55c:c0d0:3eca with SMTP id
 dd26-20020a056402313a00b0055cc0d03ecamr115349edb.5.1706106074730; Wed, 24 Jan
 2024 06:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124121538.3188769-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20240124121538.3188769-1-nicolas.dichtel@6wind.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jan 2024 15:21:00 +0100
Message-ID: <CANn89iJkEFuvYMHjM6g=4Jc2mp4wW1rN10QwxxvyfOJYC2h8mQ@mail.gmail.com>
Subject: Re: [PATCH net] ipmr: fix kernel panic when forwarding mcast packets
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Leone Fernando <leone4fernando@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 1:15=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> The stacktrace was:
> [   86.305548] BUG: kernel NULL pointer dereference, address: 00000000000=
00092
>
...

> The original packet in ipmr_cache_report() may be queued and then forward=
ed
> with ip_mr_forward(). This last function has the assumption that the skb
> dst is set.
>
> After the below commit, the skb dst is dropped by ipv4_pktinfo_prepare(),
> which causes the oops.
>
> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  include/net/ip.h       | 2 +-
>  net/ipv4/ip_sockglue.c | 5 +++--
>  net/ipv4/ipmr.c        | 2 +-
>  net/ipv4/raw.c         | 2 +-
>  net/ipv4/udp.c         | 2 +-
>  5 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/ip.h b/include/net/ip.h
> index de0c69c57e3c..1e7f2e417ed2 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -767,7 +767,7 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct ne=
t_device *dev);
>   *     Functions provided by ip_sockglue.c
>   */
>
> -void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb);
> +void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bo=
ol keep_dst);
>  void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
>                          struct sk_buff *skb, int tlen, int offset);
>  int ip_cmsg_send(struct sock *sk, struct msghdr *msg,
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 7aa9dc0e6760..fe1ab335324f 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1368,7 +1368,7 @@ int do_ip_setsockopt(struct sock *sk, int level, in=
t optname,
>   * destination in skb->cb[] before dst drop.
>   * This way, receiver doesn't make cache line misses to read rtable.
>   */
> -void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb)
> +void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bo=
ol keep_dst)
>  {
>         struct in_pktinfo *pktinfo =3D PKTINFO_SKB_CB(skb);
>         bool prepare =3D inet_test_bit(PKTINFO, sk) ||
> @@ -1397,7 +1397,8 @@ void ipv4_pktinfo_prepare(const struct sock *sk, st=
ruct sk_buff *skb)
>                 pktinfo->ipi_ifindex =3D 0;
>                 pktinfo->ipi_spec_dst.s_addr =3D 0;
>         }
> -       skb_dst_drop(skb);
> +       if (keep_dst =3D=3D false)
> +               skb_dst_drop(skb);

IMO this would look nicer if you had

void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb,
bool drop_dst)
..
if (drop_dst)
   skb_dst_drop(skb);

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

