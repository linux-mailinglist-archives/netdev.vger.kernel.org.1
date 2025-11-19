Return-Path: <netdev+bounces-239890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F2801C6D96F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id CB30A24275
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4A334C1A;
	Wed, 19 Nov 2025 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHNzEXUh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF4330B10
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543258; cv=none; b=trJ/43hvoYQnU8s/f0GWIpeEfdbb/Zvy70DnohSV93eKXj2xrIeAYUHVk8fq7qFDxmh9YDhuMoumH8gIPin2bkeMXPCPUOEvLkW8eJhxgyjQ4zayL4+f3Fj64j3fxvQsD5KbfP0z75ig3dXO9N8Fv34Up+LdbuaedzVSoB7fhD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543258; c=relaxed/simple;
	bh=RmceqjczZSnZDprCGAdNER9QpB7/4WXmD/cZumeLti4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c34B+33xOtC/XSIJ3ge7jGlmIQZ38Os3YQEhJFrY1cZBkhucuK9iC135NaoCtv9aQavsIfqlk4gc9xjoJKBYbqFdWfnUvddseY4nFBUAlnCB0rTxg1FqxPdFGUlpDP9yfJbNiuZWhFad7QybvTeyEgpi/J+fGVNRNTsiPeV+F1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHNzEXUh; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-786d1658793so58752767b3.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763543256; x=1764148056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhzbCUkV+K5/GHPAg8y+qVpyumP9/5ZDthN9X0H4izw=;
        b=PHNzEXUhasb6Q5Lvs/S0t/WIa9iPfvGsZuZ3iJlDjzHnKqmtRz+kHAivq+5wOXUH/y
         RMb8vokSZwOoOmJBilypNjpQefM9qCYQ42f10PAe7BNK4qooS9p7ut8AWMJdYclft18g
         DrkNWOC8OrGEFXndKUNpbvlSt9aZsjhPi8xXnmJd3qom1k2TfMfhpbGatKmkq6wgOgD9
         eKcri6y52OGNREla6S+jOFNXxJUsbNCUwBx1wI7x2R8qB6XCjcf8EjzUuLs5jR8jvx94
         e55mvDO4Jve0WFY1V5ipvwpdFFMjjNKCSGK3g7Vy99vQCOIdYGdHQeReFI4uG0yYT2/s
         MzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763543256; x=1764148056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QhzbCUkV+K5/GHPAg8y+qVpyumP9/5ZDthN9X0H4izw=;
        b=GH7IaOle+TheaFjAWzhfIck3tUGfVA5HHYRnQ/6874BFklGVJIXnVOklZbxo3uAGRj
         soyH2780Joeie6GZ4e1bePxw0ar0/io4PaCVHp/iHReP4NAoawpbarC7QYhESWlCTUr7
         0Y/9vlES0AI9fIcg2UyALbDQRU/ljLwRJQA3KN6XFPHzPX+ZggEzTyqQ1Gvk+ySJHo6J
         YfTaUZGW5S/5KKr8lz3Mg36a+EBTQNkXJjDbkKLGfNrt9QRTLuxY6fDC3fArcgA3zhjU
         LLM1QJoZj31CLNd+E+nbXRW1MWru5vBb/4Q2BBVziKgM2iGHksuxvd3BfczeOep/Ann/
         DYew==
X-Forwarded-Encrypted: i=1; AJvYcCVsKNcB+FpXVxMYucDfHDAhvLeLJzkpQ6kE6Rl/6PjPkWINHoGqZGwge1qeahrPbcpHLR2a9rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVlTiEmghFnn/hcO8JcQIKR4ujGSpT6xWfIz5HQ4IdUZfbBi9
	pWrRFmwMi/CYCydPpYXHas61h7LfJ6U1/qfVuXiDSxLX2Se1rMX3PDFWtJFPN5eo9eHadm84F9j
	7WoQeZQx5D7LiLKz2AI+MB2Nw97aegdYZNP4wqc/O
X-Gm-Gg: ASbGncv6wbuSe94eHAEmpcU4leHzzxqND4TRiIGXWftS1fcO+/gTy1v/BB/nSpUwRj9
	u8S/T24/PnuLa1BSVJhBQ1vJgqiPHeGl2A3OWSWZqcdwJWIie5oAj0SY2pA8d23GpzWwRvwP+Lf
	0tN3SyS04zOQ/fR3YF5rMJdOjiTd60mnzwD0Vi2DpUuczRj1gzUe5GG/5xZYsbNfWAGd7fI9LS0
	kdNI0qvuQETnFwsUAE4QvAiJICI1uqsb0JGvasBk5tTuszSbJEVSbl2DBMFzG+d1I+ExIIWmTPJ
	BWg=
X-Google-Smtp-Source: AGHT+IHAibovEChWtVH6D0mpSrOkMxnVK4yDSz4WCJmKy0RaWwmQwuI/pLm4AbI853+LaWvElKD/Q/TgWklI8apkAD4=
X-Received: by 2002:a05:690c:c3f1:b0:787:bf86:a161 with SMTP id
 00721157ae682-78929e4ec6amr269479897b3.30.1763543255627; Wed, 19 Nov 2025
 01:07:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117132802.2083206-1-edumazet@google.com> <20251117132802.2083206-3-edumazet@google.com>
 <c1a44dde-376c-4140-8f51-aeac0a49c0da@redhat.com> <CANn89iLGXY0qhvNNZWVppq+u0kccD5QCVAEqZ_0GyZGGeWL=Yg@mail.gmail.com>
 <9e1011a8-70bd-468d-96b2-a306039b97f9@redhat.com>
In-Reply-To: <9e1011a8-70bd-468d-96b2-a306039b97f9@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Nov 2025 01:07:24 -0800
X-Gm-Features: AWmQ_bn_nTjCGK067SRsRoTkQq-pk87r6ml9RZCboWe8Xmy3_dTLSVcDDkXuM4Q
Message-ID: <CANn89iL9g1Hxd74uvencxthK8aWNLtFKAHjtSm4o5aWsb7y8fQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add net.ipv4.tcp_rtt_threshold sysctl
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 12:59=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 11/18/25 10:22 PM, Eric Dumazet wrote:
> > I would perhaps use 8 senders, and force all receivers on one cpu (cpu
> > 4 in the following run)
> >
> > for i in {1..8}
> > do
> >  netperf -H host -T,4 -l 100 &
> > done
> >
> > This would I think show what can happen when receivers can not keep up.
>
> Thanks for the suggestion. I should have understood the receiver needs
> to be under stress in the relevant scenario.
>
> With the above setup, on vanilla kernel, the rcvbuf I see is:
>
> min 2134391 max 33554432 avg 12085941
>
> with multiple connections hitting tcp_rmem[2]
>
> with the patched kernel:
>
> min 1192472 max 33554432 avg 4247351
>
> there is a single outlier hitting tcp_rmem[2], and in that case the
> connection observes for some samples a rtt just above tcp_rtt_threshold
> sysctl/tcp_rcvbuf_low_rtt.

For very long flows, scheduling glitches on receivers tend to inflate
the @copied part and can
lead to a wrong tcp_rcvbuf_grow() response.

I think DRS is reasonably effective, but as many heuristics can be
slightly wrong in some cases.

>
> FWIW I guess you can add:
>
> Tested-by: Paolo Abeni <pabeni@redhat.com>
>
> Thanks,
>
> Paolo
>

