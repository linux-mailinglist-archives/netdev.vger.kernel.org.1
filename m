Return-Path: <netdev+bounces-239708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F991C6BB67
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D72644E93FA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544CA2DAFD7;
	Tue, 18 Nov 2025 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9YLrU7e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14393702F4
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500968; cv=none; b=JIJ2Zy0GcdKDgpPxZPXQcgHJd0Jv1Xskm6KFez0M1NqbipVbL3iGHWYRqNLy1ZC8KOT9uQD4hoJ8pJR3lYV35RJtx1Hgu0cJ05o8UFTUvYxppK1H/Zy59gSlb2+X4rg0Rbus26/hexdglpEbDmEg5nwCDI630dvf91ZhEfNYr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500968; c=relaxed/simple;
	bh=Dy2Sg9+Qsaj3OfE8eiz3xfEMWbFINRXPW0sQ2n+j4zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNXW4GSnLIxSys680Cq4bUliguBG7SNOLEXEgsw6oBK0U4hmsJdjFHHoq2SeGhFgVjLBg/WwSbMpoaD0/cjxBtzG/xWNlTtw7Q106JNWD3IH3opGMBycXf8bvXvMF1uHSHZ0aXCdoOkoKELlLG3v1etm3lv7wyyeSbZh7DUEjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9YLrU7e; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee1e18fb37so31123951cf.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763500965; x=1764105765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsyVM0jAdeFuDQONIkggzDFdhjVdiakl96XaMauOqD8=;
        b=A9YLrU7epIoeXibtxlTNHg/sFDSLbvpC7fCCgesY0ZoXh8B5Q7Jxpeb1uCgCk14bIJ
         w0oOJim+9dtSqCmZGVuSohVdpRDdoQLKYdKCDSOLkwQIZxNAaArxSdODatin1i+Hy0Ps
         LpuTjgsO/5amcyotm+4ruGm+1cvG0vdjCUeFDXnAvIrjuasr0xpkDhDaJtGkBC4YQQtU
         8r/S1tp8zeT0dNnZQkuP06fqz/r3yyHIgzu6k3Hap51ZpKOklFmGFi215vRf/OhnidA6
         XcZyBflvisYTFPyoE3yCXyi0inSK6doXC0RopvOkUqXe3tkicOAPwbyK18Ah3lTr2tva
         4/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763500965; x=1764105765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GsyVM0jAdeFuDQONIkggzDFdhjVdiakl96XaMauOqD8=;
        b=dwh0KuXxXg6TUPld2YGX3J7Qj/wN8yfUkaizWeoQ1VAhIY82Y9Rgdfcx09vFl+gcmp
         oHzloRdm+U4IH9Jd6Vngh7XlIIdUcTXaMMCCoIx8x25mj0kFuduZoDkr6EsgLrANrnDz
         1yffJ5YjOLrX9I9OjnA7URhbeehgYFAF/YWBmL4qDaW2pSpliISFkyH6szeaP/hUeEGJ
         X0pPdD3uLzsBLNh3mjz3Lk4TOEXDWcN43SFe5jNhLyuPNHgEv71uCm1pco1BYg1zZuq/
         Kpun437AkZDmJx+AMxAR4w0HjtH67Z9oD7mFZifp/bJ/8Nwz4KFbeQgSI6qyhJEZJJY8
         //DA==
X-Forwarded-Encrypted: i=1; AJvYcCWghhVDWJfsa4Wr2nuRwbBVW4NE81Nl12hLrzll0Ez0hnlA0Oq88b25kdSPXT7Lis3y23Wd2jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsWE544wfxrqgkCemL7NvjEhQmUc8rpuPNFrlgl4pa8UcuPE8R
	/pxxwOYUHBZh3KBH6GvMuS2Gt0QEXwnOOmAjnE2dDc05tvuX0Srh/o5HRVE5kMuwWLqtRWTPlMH
	drngAUn2f6kXDQyDYvy7CkL9U/A6P9x83qDsf14Vs
X-Gm-Gg: ASbGnctQlop5moIyDokmoKRpLsgfdYKzQfFR8M5vyYmbZUbtY4yi5FiMGb1OkfBa7Ar
	xJMY5r/NByd3oOqHOc/Z4M5yuZYOxuFkGedQgHXY5wr+GztrfgMfsxRlAvywSCu1kBxGbxtGhCY
	3I6wiN3qElJdoE29o7PQjuwFKeu4O34AzozldHaFq5TozG7bOGvBYqz+0jXqATzTT3InZmmpBkR
	KUdCn3z3MX2VFjhCbST12Nhe3iY8hq4xJxKRih/ZqNJIW6x9ve5QKHaEolEyx7QZDrWRLuDf28f
	iJN5YQ==
X-Google-Smtp-Source: AGHT+IENU+3dxARHm1x2KefUe9pHIgEUHaLAK7y5jftByqcV1bwrTDxtqv08K9XNnOY+wzor4iLmm3gvewLIXARos0E=
X-Received: by 2002:a05:622a:5a87:b0:4ee:5fc:43da with SMTP id
 d75a77b69052e-4ee05fc4bbdmr180580831cf.11.1763500965223; Tue, 18 Nov 2025
 13:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117132802.2083206-1-edumazet@google.com> <20251117132802.2083206-3-edumazet@google.com>
 <c1a44dde-376c-4140-8f51-aeac0a49c0da@redhat.com>
In-Reply-To: <c1a44dde-376c-4140-8f51-aeac0a49c0da@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Nov 2025 13:22:34 -0800
X-Gm-Features: AWmQ_bnInGcaNh9Xk0aj4hyvkSyDlRXMSHuTOHYBneIzQAQ2KHE0Zt798TcrfEY
Message-ID: <CANn89iLGXY0qhvNNZWVppq+u0kccD5QCVAEqZ_0GyZGGeWL=Yg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add net.ipv4.tcp_rtt_threshold sysctl
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 1:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On 11/17/25 2:28 PM, Eric Dumazet wrote:
> > This is a follow up of commit aa251c84636c ("tcp: fix too slow
> > tcp_rcvbuf_grow() action") which brought again the issue that I tried
> > to fix in commit 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
> >
> > We also recently increased tcp_rmem[2] to 32 MB in commit 572be9bf9d0d
> > ("tcp: increase tcp_rmem[2] to 32 MB")
> >
> > Idea of this patch is to not let tcp_rcvbuf_grow() grow sk->sk_rcvbuf
> > too fast for small RTT flows. If sk->sk_rcvbuf is too big, this can
> > force NIC driver to not recycle pages from the page pool, and also
> > can cause cache evictions for DDIO enabled cpus/NIC, as receivers
> > are usually slower than senders.
> >
> > Add net.ipv4.tcp_rtt_threshold sysctl, set by default to 1000 usec (1 m=
s)
> > If RTT if smaller than the sysctl value, use the RTT/tcp_rtt_threshold
> > ratio to control sk_rcvbuf inflation.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> I gave this series a spin in my test-bed: 2 quite old hosts b2b
> connected via 100Gbps links. RTT is < 100us. Doing bulk/iperf3 tcp
> transfers, with irq and user-space processes pinned.
>
> The average tput for 30s connections does not change measurably: ~23Gbps
> per connection. WRT the receiver buffer, in 30 runs prior to this patch
> I see:
>
> min 1901769, max 4322922 avg 2900036
>
> On top of this series:
>
> min 1078047 max 3967327 avg 2465665.
>
> So I do see smaller buffers on average, but I'm not sure I'm hitting the
>  reference scenario (notably the lowest value here is considerably
> higher than the theoretical minimum rcvwin required to handle the given
> B/W).
>
> Should I go for longer (or shorter) connections?

23 Gbps seems small ?

I would perhaps use 8 senders, and force all receivers on one cpu (cpu
4 in the following run)

for i in {1..8}
do
 netperf -H host -T,4 -l 100 &
done

This would I think show what can happen when receivers can not keep up.

