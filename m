Return-Path: <netdev+bounces-173548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C787A596B1
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA93D3A471E
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51F22AE4E;
	Mon, 10 Mar 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0K07uMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5221E0AE
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614634; cv=none; b=AUbN7MzZMhooIEI0Qr4uHL+Gz0jgZKO275jG15U+RkrQBMA6G2/MA/ZgqduUbrMuny3Q4M+ApLHdYd+sR98wqMjlVh3XjVnBsrZ8r+ntAJLFiCD0Y1MHJxPwPVhDETffUcBcQbvTPYOo28nD3QCtAJNbbr/+j2PFEPoJtuwb9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614634; c=relaxed/simple;
	bh=GfwYy9gjsNDmrgTne/V843ovOtp0n9twXRRWpfSZTco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc2i/ayETLY9U6WI5SIJM1/7l3BF4HOLbGBzGGuw6kCPAJhuPihGGwIgRmgo4lt1rQsh+D5mlkMdJn3IUGodXTBQ0wv0DAQ+QAkxlwz8Imcv7xGEoz8qwpfg+hyEpzCw+Cuuy40LbXrUFOwYOg7xjOfgp4Xv9S8dLDlgv0Yzif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0K07uMG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47690a4ec97so6396081cf.2
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741614631; x=1742219431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gCaYCDs8Pg1kazKM+cvSCawahLTAgaONKg1fx0h8QI=;
        b=O0K07uMGZqi8mffCDUapyTD2t5MNTPUZPYvyRj8LHJlH5pvRMDNvoNx7GHYzQNxgcO
         N+Oql3M5p+uZpPtc3JuQOqZzngk7Z574j4+eXcM5pioqJvKnU3Rj5gSVBljDlHhdoUf9
         FmMBOv3/cnPR7ryDAY4vYaeWoljZtXVdn2kPGh4250mkBZ+OQTiSCY9GkhTB0HOK5WRF
         0/kLYaday8+y/Q46rS5l03GsSny+LLqsqrOvvwlW2xjtYY2dAUdkk2y/J2iSNtuFCpOF
         xPwVCVlF8SAcqbj3B2BhbiX6cBQ6yrin669xJDCQY2gyLzFJD+vM1+Znrnt4/BbpUSTB
         WeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614631; x=1742219431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gCaYCDs8Pg1kazKM+cvSCawahLTAgaONKg1fx0h8QI=;
        b=lJYmdnQw3nBwuj/KDU0oacJDsgFqE43vMMeSARJG2S9UMq+794PjgQPMH4/LVhBbtM
         LWJ8PjVjns8E75blY9rbmRNvEDwffE6vtr78DVPKyD/I1nEImnGwamGf++cqRDpLXMSa
         I4XWFEgdugdUn0h+AYZyuaozv+rkOWYIht4jS8rawq7l35UHNLpQrGF+y3imAZbUEbrP
         wO595rCjL1F2ini+E6xLAmXRs/dhhcRy5ya39u0csnnvtQs/2JqfeDH+rWEA0UPH7xnB
         2R7zVfhbQMQFKJuSQOVZB7lSyibVQAIQpV9xS3c3rxFA8t2b7jw9hSmh5dIlTy6jz+uf
         lpBw==
X-Gm-Message-State: AOJu0YwksiIR6pnCCema9xuAEJu/OPSeWtDh8Hp1V2AzH78AxFSAUS78
	5wm8Qm8gRoaLqGf1xitCXCUBgc/JPvpQm9b60bzQt/kkq9zM2svuYTtFsOhQROQYnNJT8X2PqwR
	3WSxWLrDVerwHxHvmva0JcPGmleNziaG6fay6
X-Gm-Gg: ASbGncvKyNoe6ipBFH0LfFqKVEhJcUstyM6u+IrWSIGaKkwbVO3DaRoq21sJInkvLvO
	phX2SyHcSWSeradvIJu3MaCNEvglgQzKGEeXojGCdyR8T4PQsef1WqD637kREQQkmwf4BML5SSn
	AZU15yWZPqJBffFrizxloxc8lmi3KVifw2MfLN
X-Google-Smtp-Source: AGHT+IFsdQMEPT30ed2pS0BN7tbO7W3VKJdZvIwL3jZvuKUeU7dzMuWa0MC//ByEudsxjQK6b0Xp4CTZvHVVJ6AyXHI=
X-Received: by 2002:ac8:5793:0:b0:472:744:e273 with SMTP id
 d75a77b69052e-47611854d1cmr141155951cf.42.1741614630594; Mon, 10 Mar 2025
 06:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310112121.73654-1-nbd@nbd.name>
In-Reply-To: <20250310112121.73654-1-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Mar 2025 14:50:19 +0100
X-Gm-Features: AQ5f1JoNjMz9SHsATO0f1HJDcw0fpi9KS-ZrtFDNFcIMDzgUlSPLXMKF9X993po
Message-ID: <CANn89i+tX02HsfcGx1g5fdg9N4Cx=FNDk886KNPqsiem7rPcJA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ipv6: fix TCP GSO segmentation with NAT
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 12:21=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote=
:
>
> When updating the source/destination address, the TCP/UDP checksum needs =
to
> be updated as well.
>
> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO pa=
ckets")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
> v2: move code to make it similar to __tcpv4_gso_segment_list_csum
>
>  net/ipv6/tcpv6_offload.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index a45bf17cb2a1..34dd0cee3ba6 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -94,10 +94,20 @@ INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct =
sk_buff *skb, int thoff)
>  }
>
>  static void __tcpv6_gso_segment_csum(struct sk_buff *seg,
> +                                    struct in6_addr *oldip,
> +                                    const struct in6_addr *newip,
>                                      __be16 *oldport, __be16 newport)
>  {
>         struct tcphdr *th;
>
> +       if (!ipv6_addr_equal(oldip, newip)) {
> +               inet_proto_csum_replace16(&th->check, seg,

th is not initialized yet.

> +                                         oldip->s6_addr32,
> +                                         newip->s6_addr32,
> +                                         true);
> +               *oldip =3D *newip;
> +       }
> +
>         if (*oldport =3D=3D newport)
>                 return;
>
> @@ -129,10 +139,10 @@ static struct sk_buff *__tcpv6_gso_segment_list_csu=
m(struct sk_buff *segs)
>                 th2 =3D tcp_hdr(seg);
>                 iph2 =3D ipv6_hdr(seg);
>
> -               iph2->saddr =3D iph->saddr;
> -               iph2->daddr =3D iph->daddr;
> -               __tcpv6_gso_segment_csum(seg, &th2->source, th->source);
> -               __tcpv6_gso_segment_csum(seg, &th2->dest, th->dest);
> +               __tcpv6_gso_segment_csum(seg, &iph2->saddr, &iph->saddr,
> +                                        &th2->source, th->source);
> +               __tcpv6_gso_segment_csum(seg, &iph2->daddr, &iph->daddr,
> +                                        &th2->dest, th->dest);
>         }
>
>         return segs;
> --
> 2.47.1
>

