Return-Path: <netdev+bounces-91577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091558B31A1
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B392028A4C0
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503A13C830;
	Fri, 26 Apr 2024 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oawk07lh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D713AD25
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117496; cv=none; b=c7bWwjqrdKyKc9bOpGOPquexcREc0HoOlXQX+sYUJ8fq2PbuQy2/EOnYuM+fg5fo7HsBbrpdIEkh0sZWeN4yEOQauuCZYEXvnOxsuRSMUgJmrc9PMAaB1YBM1pgNc8dzplwuh0vENk3xUdbxozzygdZM1kguGQ0wjNWGx4ZoCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117496; c=relaxed/simple;
	bh=IAy3KSdWgKQ5Dy6jkMVe3ewR5lCzfv6BECAXxzU/b10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7RlAU4avgxhPmdehEiujt07QCw5uYNSxZEBID3VaflVRetO/QxxvwnjOiC6nybbmSFbi+Wfn2ZQDiQkn/yqjRSWHFJg6AmgZ58QZUL5IAxtMuEHRRLFvyEG4TR8AKeM8uGzXV33a4JC4zFyXOpyi/q9n5NoMptJmGnzPs0U+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oawk07lh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so9312a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714117493; x=1714722293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A33BurzJz4OQByTITh6Ot1PgPb3FP3Ow3zWOTt8U/FQ=;
        b=oawk07lhJBcKEp94xHEuT4kwtNRyk0fJ6jXQFmX8JTGtEEyc7zahwKQtM/GDNtSbIG
         20DdU4UHCMpnTh1Vo4rSdKKs/2tg/iy0bjN1sfn7gkM+BHPJ0sX8XRdDIR/Q9I36g/R4
         ryJVNu3Sk7JS4fB+FTlwJDi9VmTQ643IAMft3uJHrr9CFZFj1xFb9bxR2Bj1PfuMjyO9
         o5DF/Le5mOmd4PImviZJzV6cTQCMPILS+DHAeRMSR5Yg0kET7UboBOHkkLJVnBaPEK42
         4+mElj8jGyEZ42+pvJf5pQ892CRFDX7mOOX6Ss+B0sA7TPQNs4yLijQde8x/wevZfzqS
         GnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714117493; x=1714722293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A33BurzJz4OQByTITh6Ot1PgPb3FP3Ow3zWOTt8U/FQ=;
        b=Pzb5G2iNv3wBnb5naovVAr8gop0mBGCgO95BU47dXH8wnTndilHYa1DgejkSxHf6u9
         SjKvJpq6+jrc2iBT3gmuI+TwmoZAaU81hqTpWEIbjXWAeE34yh/0pQnoEiOXM9wBJca5
         7PsnBsNbrsDOy3Rsdvg6ozr0kqhrilZ1b6615fLCRe3SSZZt+b0bpQmdhNpW4sbo2O2C
         M5WhWhnCS7bc5pC6QYsLMtczXZgtzfKm4bntOuyWs2Kt/H2ATuDWXGIiZ0SKEloG1b0C
         pL7ss3JPGKngZTvj+WTydzCbSB7AR1cYTbUs4/BclocCoLkdzNu/v2JzUwAlQljd9GxH
         fdfA==
X-Gm-Message-State: AOJu0Yx1PImN9qWYmdzZ7OvA0KNL4f5mmoA0WZBD/I/tZ9FWFD37tsKs
	uU2jevmtxhOJF4RG6YlvVmxh42uleA99WovnX7oOdiZvRHJA9e66rlzHHrBgV9IUf+QrO41GkSv
	59G0E1o5GsGao8rFxpcoHlvc7xPceslaRwWohuMsrFVPctwvBFRzA
X-Google-Smtp-Source: AGHT+IEk1uXUIDXCS1Qd6f2BzElPYf3TlvuOyrYn14Ix9f6DOldn8oT6ET0aMSrOaQ5UNNf8yUYn6CTwM5ZjbPhg3Ow=
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4516 with SMTP id
 x12-20020a05640226cc00b0057257d84516mr47477edd.2.1714117492798; Fri, 26 Apr
 2024 00:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065143.4667-1-nbd@nbd.name> <20240426065143.4667-3-nbd@nbd.name>
In-Reply-To: <20240426065143.4667-3-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:44:40 +0200
Message-ID: <CANn89iJKfgQNNXUL10-7aVZTn+ttqvVNZbnKi6jCdQGwzbFFYQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next v3 2/6] net: add support for segmenting TCP
 fraglist GSO packets
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> Preparation for adding TCP fraglist GRO support. It expects packets to be
> combined in a similar way as UDP fraglist GSO packets.
> For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 65 ++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c |  3 ++
>  2 files changed, 68 insertions(+)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index fab0973f995b..c493e95e09a5 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -28,6 +28,68 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsign=
ed int ts_seq,
>         }
>  }
>
> +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
> +                                    __be32 *oldip, __be32 *newip,
> +                                    __be16 *oldport, __be16 *newport)


Do we really need pointers for newip and newport ?

> +{
> +       struct tcphdr *th;
> +       struct iphdr *iph;
> +
> +       if (*oldip =3D=3D *newip && *oldport =3D=3D *newport)
> +               return;
> +
> +       th =3D tcp_hdr(seg);
> +       iph =3D ip_hdr(seg);
> +
> +       inet_proto_csum_replace4(&th->check, seg, *oldip, *newip, true);
> +       inet_proto_csum_replace2(&th->check, seg, *oldport, *newport, fal=
se);
> +       *oldport =3D *newport;
> +
> +       csum_replace4(&iph->check, *oldip, *newip);
> +       *oldip =3D *newip;
> +}
> +
> +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *seg=
s)
> +{
> +       struct sk_buff *seg;
> +       struct tcphdr *th, *th2;
> +       struct iphdr *iph, *iph2;

I would probably add a const qualifier to th and iph

> +
> +       seg =3D segs;
> +       th =3D tcp_hdr(seg);
> +       iph =3D ip_hdr(seg);
> +       th2 =3D tcp_hdr(seg->next);
> +       iph2 =3D ip_hdr(seg->next);
> +
> +       if (!(*(u32 *)&th->source ^ *(u32 *)&th2->source) &&


> +           iph->daddr =3D=3D iph2->daddr && iph->saddr =3D=3D iph2->sadd=
r)
> +               return segs;
> +
> +       while ((seg =3D seg->next)) {
> +               th2 =3D tcp_hdr(seg);
> +               iph2 =3D ip_hdr(seg);
> +
> +               __tcpv4_gso_segment_csum(seg,
> +                                        &iph2->saddr, &iph->saddr,
> +                                        &th2->source, &th->source);
> +               __tcpv4_gso_segment_csum(seg,
> +                                        &iph2->daddr, &iph->daddr,
> +                                        &th2->dest, &th->dest);
> +       }
> +
> +       return segs;
> +}
>

