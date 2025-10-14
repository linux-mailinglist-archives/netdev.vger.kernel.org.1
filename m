Return-Path: <netdev+bounces-229101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15838BD82E0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BC13B9920
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FCB30F921;
	Tue, 14 Oct 2025 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swJo4U9a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2EE24A046
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430604; cv=none; b=gBWqHJ6aLS4MigECh8W3sXE9U+H5EZZFXSK0ulcwqrqtyI7cur9XUBnjDPI+ToU2PeYZD+Bj02G1JZyoWp2s3dE8SO7VxmlaXnATyG2tp9NNbS/3XXk/hnkkFSrFK+kvxj3v+tBEn/KEJDeh4Vh1/s6/T1qgZOEeke7DSl2YxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430604; c=relaxed/simple;
	bh=TesxODKziGU9W7eGyPR3WzVG+TN2W2VglPXs2zQjW5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWTCld2dW2gS6EHNXE/V8I03FK2gB6OogCkNUHeMQ7s+1Z8NdspTdV+iGBR/bKLMu6dxPceHWb2gK0EEb6Ggh21L+CfIE6QNzHs1AOGJAuuvdpmBjG0e6MUzE2xUYWdlkC97cITVz4tFrrmKp5S/Jc+OPMYmZ3moQwIYjA0wKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=swJo4U9a; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-799572d92b0so66870056d6.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760430602; x=1761035402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXmgDIF1sFqL6K9TWHB3ywbQ4jmUGZeIqIRTxjmCg0M=;
        b=swJo4U9a+E0e5TWqvlHiO3P0v+PZBSbBdKd5pjXSbnQ76QfSc1f94ZJDG0e95tmCxM
         IituxPrQ/YW9nnsxK+Eegwyk6jUu3G6H4IXuW3R0jZdN/E7azBoLokOIB8QjWN1C+07K
         B2q7FpvGi/Ngja08pQoEYLaH+9oLv3XTPQGLg9nPZhEGGWOOWgSaWSMIQXmwdFP9iBeo
         4XQWLYkZjROPI44luXz9juLqp/pUg6sG3kCQoRReJ2eZt8Yba66IImazptpbVVjXpPQB
         BrSmnMiHXKyIhV7rM+2L3QAvMy2nvKDMdt5GV3gpdL+Ha+B2vOzaBxSMcB5GRvosLcD/
         xK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430602; x=1761035402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXmgDIF1sFqL6K9TWHB3ywbQ4jmUGZeIqIRTxjmCg0M=;
        b=rP9xXzRWJR2FU/gYQdN4sUpv6rbqnJ6WNMfhg0s3X0QaYTmxiHPvdbqj09TdSeHKuV
         TjieIwHgV1DUSAAyxwUEzyRbzNjMQpjiVLgBccBbaB1eb3Jgn+SJX3QSjd8/U5HWyeZv
         SR9fpv+I+w+SmbxCviyWnCesHij/ubLywBVDM+Ugj+ghfyvBb/zOKYocm3icJl+lqNqN
         qxY0r9NpebEfc1KEACz7S+RG6nEgZ9I+/tZhsRDvwXppIz7/6To9w/hTE3d8oud0WtdJ
         bkLPjgxLExt3nDKCvCe+vaI4lIggR3OLdas+rEOgdK7OCUtetO7tKOoBm2vCrLAxP/5V
         /AeA==
X-Forwarded-Encrypted: i=1; AJvYcCXtv/kxowxT98NE8rsBrBGFYfvvde1XSxXuBn5NMZqXGMdM9cXGX0F2Vj+LiwawLiu5Y6YP64E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWEI1lL9y71a9+iGUMNxfN7jAvHOZTaMtjSV+RvWJuBcOHgsA
	noODSz6+hYNA61iYZyouAGjsOtW3uhjZ5gybuHwRI9UcN2RSS+6PYoocxCVwIZymXK7DuSZR1cE
	YWlb9V8uD5jKwTj00ECsyOIW8EIbm6ErKZP4nr6WH
X-Gm-Gg: ASbGnctjwX0Z0lX3vS4oqwK68HioenKj9e/tFfx7EKyYjJSWhf2wUHc9wdFCQsCyY4g
	nMYq5PZlyqBQUdd86IxJjASw85BoAUSkyzRNcba+ItXiHCPeuos0gM49K3dijWdk/QOlS7PbLCO
	S6hylt7h/ZtlK+Q/DmF2zjvPxOpcXO6BfJd5+wvFW96ZS4vbMtTNrFXlpPt8Rgto/kGaY5QCdMv
	yKCQvVeBbXbPoMYT0k24f5csG3glAaeL298KtQcvgg=
X-Google-Smtp-Source: AGHT+IGkPpVMIvZfA2IQGSAz8UXRG4sEt4rJvn8s73ceXC5wE5vkmTf95J1Hr5ZThEjiu5nMcZR/U5ZDd3AwgiJW1Eo=
X-Received: by 2002:ac8:5d50:0:b0:4e7:251e:e1cc with SMTP id
 d75a77b69052e-4e7251eeaecmr95046941cf.27.1760430601331; Tue, 14 Oct 2025
 01:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145926.833198-1-edumazet@google.com> <3b20bfde-1a99-4018-a8d9-bb7323b33285@redhat.com>
In-Reply-To: <3b20bfde-1a99-4018-a8d9-bb7323b33285@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 01:29:49 -0700
X-Gm-Features: AS18NWCPvaVgui9h6mLynr2pYgfII83Q4Tf3p-Gxh3XMVC2VPd2xNrgfFwqqZLo
Message-ID: <CANn89iKu7jjnjc1QdUrvbetti2AGhKe0VR+srecrpJ2s-hfkKA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established flows
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/13/25 4:59 PM, Eric Dumazet wrote:
> > Some applications uses TCP_TX_DELAY socket option after TCP flow
> > is established.
> >
> > Some metrics need to be updated, otherwise TCP might take time to
> > adapt to the new (emulated) RTT.
> >
> > This patch adjusts tp->srtt_us, tp->rtt_min, icsk_rto
> > and sk->sk_pacing_rate.
> >
> > This is best effort, and for instance icsk_rto is reset
> > without taking backoff into account.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> The CI is consistently reporting pktdrill failures on top of this patch:
>
> # selftests: net/packetdrill: tcp_user_timeout_user-timeout-probe.pkt
> # TAP version 13
> # 1..2
> # tcp_user_timeout_user-timeout-probe.pkt:35: error in Python code
> # Traceback (most recent call last):
> #   File "/tmp/code_T7S7S4", line 202, in <module>
> #     assert tcpi_probes =3D=3D 6, tcpi_probes; \
> # AssertionError: 0
> # tcp_user_timeout_user-timeout-probe.pkt: error executing code:
> 'python3' returned non-zero status 1
>
> To be accurate, the patches batch under tests also includes:
>
> https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1010780
>
> but the latter looks even more unlikely to cause the reported issues?!?
>
> Tentatively setting this patch to changes request, to for CI's sake.

I will take a look, thanks.

I ran our ~2000 packetdrill tests for the tcp_tso_should_defer() fix,
but had no coverage yet for TCP_TX_DELAY, and started adding
packetdrill tests for that.

