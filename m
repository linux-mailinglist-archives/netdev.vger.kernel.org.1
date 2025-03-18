Return-Path: <netdev+bounces-175731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBB5A67483
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74692189AD23
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B95238DD1;
	Tue, 18 Mar 2025 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9umPwkJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17E23CE
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303194; cv=none; b=crBGTesFe/S2GFwEK/ek80XT/FnRmmgEs1H4VO8Unjj7AqnKA/w0nnJCGc6+W/bkMTc00qynR4SZIZKtbZiOdBoRITjdCnHb2XJLHsbIjgrTkitdss5Bzlp1BRNH/nV/eVUNjAph7GD13b0qvx3LwFkNQvBexkqf4qwj7FxkPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303194; c=relaxed/simple;
	bh=d6la5dY71s3g73xScdW8km3xg9J3GolabTjdJmhfyiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcj2cpJ8D0/szw1pVJxq8VfyeQcQWp9GXnVXglb5YftPXl9l4Iw8U2pEL4QhwVzdzmoDUcGTmkllpH74XdFaNm45/wzosoXb2EXAVcUwEvczLqnlHjb57x9xiPOQU8Z2IgL4gwA6TJrnenpJWlgm52G8yGnTRrtsAuTzNVxq+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9umPwkJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4767b3f8899so65558501cf.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742303191; x=1742907991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOS2ZpxQwuhtn1RrTev+YukTEID8ek/WfPzSF7JPDB4=;
        b=R9umPwkJG3R1tbTHJBBNZEYu/VjxVfeDnJCmlrXxJKw2oCxuC8o5Nm/7WW2d4Ijz27
         mVU/SGsBDxeTUM8jVTkuJX6OPt+nt9zOOvT3olPg7LzzobcHzO6OyrReb347vJMcZlhP
         S0elrOT3WyOdasXHpAlY8ZviAoC/kyyr/p77JmQ5qYY5Y2kTPA6N7f/yFbMrk5PLIfO4
         c5/WROBdkycDqzH9nBQytPk5XPJl64/DgI7LSe6CP9/mv1KdtRsAd8MOozGcKWlrS1uw
         zivjp5KDVGTYLD4J4f5/G6yHVu/nsXx/FQ0lTZp1eLDz1g3Q8E+QSRKqWM7tkaNxSsNi
         QXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303191; x=1742907991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOS2ZpxQwuhtn1RrTev+YukTEID8ek/WfPzSF7JPDB4=;
        b=br5w06Fv3E39uO/QEnMlfZDGOYH6IE2dOj17JM0b11xUwfnEcMNC89uCggsvKbOfRI
         hUV5zTL/SZU7cEEyvpVL8BaqUxqfK0h96FvXCdc4YXLYVhbNDKlnLJQU62NW0NY2bVWu
         qdJcWCqAcHAnJj2FT0CzA4R7BIePLTGgz4RcXMYJMRJrThiFT0jg/ZoHPFoBSV1ZAiWV
         sXwFrNh5NzH9MtJxoeYeRGgm1GW9+Tt7W6nhmgPkJkF84B+41Nc/E2+6wnSfFA3ZUzYr
         fhyWcJJ6OqKUqSZPx3gYUXHTC6KvfKQ58qQsw/FSM0wYjoNpq5ZpaMvCtbAZJFJ4DE87
         OSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdLng97FLw4JXF/yA5/8egJQKR0WsNjIRJPzcQJ7A3mKElhdeOWx6b7TXgb3SxIws+jOUEdak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+w30DuEZDeN2Gv97lhc05jznqOQ/m47l2BxaJiC9EwGMZEkvj
	B7LioszRfm0QnGJ5cg55jhUHi+j3tZRxA/7HHFdnsDG8wfhOYR+6ebK47uoPEx9lhMXorvSsbMu
	VyZcfKZQ3Tp70KsL2NMv1b4EUTEyWzMdciGTa
X-Gm-Gg: ASbGncs8hYSxnjjS54Aq8xX92qIGSVO9s07mRb+JLlrRWSIgZ0E0P4gendfgiyk2M2a
	xC/LbhiJ/berVedkLgygMDeiIiL3lf8GaFtfVPemwmUrLCtQqB8K8Cz1C1sXVxLt4R5U557hd9s
	kPEVT6KeItQ6FRCdK+pS9PO0SWIgs=
X-Google-Smtp-Source: AGHT+IGvlrnJ3Pmdt/XCyMr/MZGH1APyOAOUbS+vBkkQgBMcbwAEgHfhSoMyuA7S3g2IOSCDQIMv6krYvAD/M+eqbu8=
X-Received: by 2002:a05:622a:4105:b0:471:9e02:365e with SMTP id
 d75a77b69052e-476fcc8cc0cmr57418251cf.8.1742303191177; Tue, 18 Mar 2025
 06:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312083907.1931644-1-edumazet@google.com> <7f89705b-f4a8-4635-afd0-55dffe84ab22@redhat.com>
In-Reply-To: <7f89705b-f4a8-4635-afd0-55dffe84ab22@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Mar 2025 14:06:20 +0100
X-Gm-Features: AQ5f1Jqhr8vn2PE7JJZmNUKB1WDT8AEHp7hU8lCS2xB9vTK2qP9vjA92Fy-sGzc
Message-ID: <CANn89iJL8AD-JOw7oMbBehLmHbncwAJmhyNS+Y-YEx-+MwkRAA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: cache RTAX_QUICKACK metric in a hot cache line
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 1:44=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 3/12/25 9:39 AM, Eric Dumazet wrote:
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index a0598518ce898f53825f15ec78249103a3ff8306..323892066def8ba517ff59f=
98f2e4ab47edd4e63 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2565,8 +2565,12 @@ void sk_setup_caps(struct sock *sk, struct dst_e=
ntry *dst)
> >       u32 max_segs =3D 1;
> >
> >       sk->sk_route_caps =3D dst->dev->features;
> > -     if (sk_is_tcp(sk))
> > +     if (sk_is_tcp(sk)) {
> > +             struct inet_connection_sock *icsk =3D inet_csk(sk);
> > +
> >               sk->sk_route_caps |=3D NETIF_F_GSO;
> > +             icsk->icsk_ack.dst_quick_ack =3D dst_metric(dst, RTAX_QUI=
CKACK);
> > +     }
> >       if (sk->sk_route_caps & NETIF_F_GSO)
> >               sk->sk_route_caps |=3D NETIF_F_GSO_SOFTWARE;
> >       if (unlikely(sk->sk_gso_disabled))
>
> Not strictly related with this patch, but I'm wondering if in case of
> ipv4_sk_update_pmtu() racing with a re-route, we could end-up with the
> first updating the sk dst cache instead of the latter, missing the sk
> status update. Should ipv4_sk_update_pmtu() call sk_setup_caps() instead?

This indeed looks strange. IPv6 seems fine at a first glance.

