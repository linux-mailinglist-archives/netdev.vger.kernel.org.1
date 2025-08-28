Return-Path: <netdev+bounces-217985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DB6B3AB33
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95B9A00AE3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E4E273D8B;
	Thu, 28 Aug 2025 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cMAPOK/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0391862A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411256; cv=none; b=UwROUzWzHzME13VveuWipZUOfwZGj0ItxKMScxxsu01fBDC/QCBCoG739iAbdCgRYDGX0vJia8xPfA4NPuJzVbjOZrXKQ8VkEQ/hX/iPoe3b8ZVYnGDyDxLf45y9WQO3r+fvMPFSce7vwqI9AiOkqcRDvGy5JaTxlN5MP1RyL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411256; c=relaxed/simple;
	bh=Vr9F3xqCHEdFR93OX9lFs+rhkiKZsACDOAD+/wgW20g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvzPQxbHyKXkNuAwFpN3vrZ3l78+Gy2SjunWS/9Xjf8Z6rFamGiEjw2a7ykq74X/6bT3DFLxS4P+G49wPUtqp0PL0tbisgv+klBG63kZINJ3s7GMvRrOsfcMx/lcHrlVeeKZrPbyIPXBogoZrxB5oZ//raboSkdbukduUmGykK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=cMAPOK/I; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-324fb2bb058so1286210a91.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1756411253; x=1757016053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiCLpZsdgV8UTOXIWEcrK95LvhsGCYsAuVwLPkl0qrs=;
        b=cMAPOK/Iobps4VDptf4DIbqyG+850F8LA0aG6buS+mVbbzHKwwbEwmDVa3C0pdtffh
         upJQP9x0HNCQgaR6NNKA0aHuAojgT7mdUnRIWeo6Vd65+oh8FRid1xrj3h5biKkLMK/Q
         D/KBdGYxzDekR2AzDnvfJ4JLj8Ja3K+lKw7Wx9BG/zPISdY92TREs+dCjA1TdKMa98YA
         HPhX0yPQJg1YFQ1WeP12qbL9R6GdGzgM6TPwf2g7F2cyQuiMLtVoxwADW7FnP0JEpM2b
         tA2H3g1/eto37CMxyDtPjnkhzzIPWGV2KoqsVR2A2T7aH9MbHMgv/xfl34RW1LjAYj97
         3z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411253; x=1757016053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiCLpZsdgV8UTOXIWEcrK95LvhsGCYsAuVwLPkl0qrs=;
        b=aAxr/vnm1SxdvQjBePgHwPuU1b0VtMZ4QMTSAqyyfP9s5gfdzEAYu7MDsHQiFrYqrk
         fDk7VrAY3X43Axpx57gU4MOLqO7VMogxbOYKFm/uzMKyShnzoH0C9q8EVBunU1LGg78d
         R6unu4zUj05LrXF4DvsNYj97Ln7D41DxcBo7c+4Lrk6x8xrODjS+uf7RZ8JQHb7rDnyC
         fJkXzjrmetaA95p38TFXEBidJA84xneyKmreocA+UmxstZ3+yIVH0fE1X/PVVofijgio
         WNkYzy0j7n7245IivjYVdCXx448nROVFmDNcUMA8zqlwe47lZ4Dj5jrw6Cgnn+4aceKy
         pHEA==
X-Forwarded-Encrypted: i=1; AJvYcCVrEFT1qQXZEc9umvVthsBb/4o6Y4mk3i8AmXteFwcUjpAMkZnsJUTeExRbCvKp0qX6QqW+jDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXdvZoeZl58FvXNuL7fWlJhfz03rCBsWbXjuqP/EVQl6g1BPM
	RZe5OgPgrMT6b2nNEoEVBrbZdjArksUseNhpNkHxi7uxJHhtubWyXNX/TjFrB187YMT10noA+IA
	4YhbVpfVlZF0tBU/JR1MS/+P7z+rFwu2gzdqH+1/X
X-Gm-Gg: ASbGncshwgZ4XMeLJmTc6xbkDvtkEZtenchHOW85D+tFSqvPRjZ+yRMJyGED3liEGFh
	3+Xes2OB1ajrEkuuZ72TC1wAEhMnQlXr4P/mbUOezz182Nc6rYvDmFmkNnNQtizpEvWT2azYn/o
	jqAvRg2Vjin9jDD2jc2N4VGtPg2kvPe7k4JuvcPSJ2gFdwnwD7XNTgzWPNHHs3mZuxe6xx+xzfH
	Idr9gKloiHhdNlDghoj1RwyD6Hk6wMLj/adSBfBhZEeKaTPVqT/DkzcVH8LrY/rPgr03NcV6wWa
	mn6Xw3MxsczNjZJu6gBrHmZHUDAdTGs=
X-Google-Smtp-Source: AGHT+IHKuBy4ggyOLAexkSTeg9GziXa5fhPjZLTY3qpGn4B960J4ESwZLGqV9YNSE2NT1zhvnzleI02bA+lsJkuWC4s=
X-Received: by 2002:a17:90b:510c:b0:327:9373:efa0 with SMTP id
 98e67ed59e1d1-3279373f3bbmr8060389a91.20.1756411253161; Thu, 28 Aug 2025
 13:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-b4-tcp-ao-md5-rst-finwait2-v2-0-653099bea5c1@arista.com>
 <20250828-b4-tcp-ao-md5-rst-finwait2-v2-1-653099bea5c1@arista.com> <CANn89iKVQ=c8zxm0MqR7ycR1RFbKqObEPEJrpWCfxH4MdVf3Og@mail.gmail.com>
In-Reply-To: <CANn89iKVQ=c8zxm0MqR7ycR1RFbKqObEPEJrpWCfxH4MdVf3Og@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
Date: Thu, 28 Aug 2025 21:00:40 +0100
X-Gm-Features: Ac12FXxSJ8PV1qCATI4uR3CcwYQR9VTD3hYNVBiW7TY295QuzPGQNawDD8es3iE
Message-ID: <CAGrbwDT7TfgQsPJh=5TE-4tuxUsn3ft52zninaRnZct+OaoAvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Thu, Aug 28, 2025 at 8:43=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Aug 28, 2025 at 1:15=E2=80=AFAM Dmitry Safonov via B4 Relay
> <devnull+dima.arista.com@kernel.org> wrote:
...
> > +void tcp_md5_destruct_sock(struct sock *sk)
> > +{
> > +       struct tcp_sock *tp =3D tcp_sk(sk);
> > +
> > +       if (tp->md5sig_info) {
> > +               struct tcp_md5sig_info *md5sig;
> > +
> > +               md5sig =3D rcu_dereference_protected(tp->md5sig_info, 1=
);
> > +               tcp_clear_md5_list(sk);
> > +               call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
> > +               rcu_assign_pointer(tp->md5sig_info, NULL);
>
> I would move this line before call_rcu(&md5sig->rcu, tcp_md5sig_info_free=
_rcu),
> otherwise the free could happen before the clear, and an UAF could occur.

Good catch! I'll reorder these in v3 just in case the next patch 2/2
would have to be reverted for any reason.

> It is not absolutely clear if this function runs under rcu_read_lock(),
> and even if it is currently safe, this could change in the future.
>
> Other than that :
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks,
            Dmitry

