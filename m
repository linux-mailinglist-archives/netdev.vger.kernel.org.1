Return-Path: <netdev+bounces-88222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41D8A65F2
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3784F285B1C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B2612837B;
	Tue, 16 Apr 2024 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw7+Xf9Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543386EB75
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255624; cv=none; b=ouXNplaxEHn4jlNhSSeBp+3j6YqymvO4yBe22TEwdpDVswHKfW2zZup8AspWHh5xvZl9gqYM1Zh3sdosE90GR2jqgGnunRXxzCBqE2ZqJVSM/btk+6Mpe8EMm/kzIVx6URsF5lqsLe+oH0cvfGTFNi+z9iZBiWifSjH44dXKl5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255624; c=relaxed/simple;
	bh=mn0axZeWa3rV3fphwoeUmwyANcoprQ4GAQmafSk8R/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTfuVsDlSVqtJtBWDVAb1y4IcSO0qCsKeYgNMBj/n8Rno68cmUqfuy/+Qn2ablP5xMuwTZAdcGSWzwCQLWHR5yS/R4b7VagQyQRPSbgyNXsswO+ODN+4DWuMsKXyZksSKT4ZIkUAd/AIw1+YGxmqHAkY78dPRolL6Xv57ADNuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw7+Xf9Y; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso4830595a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713255622; x=1713860422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufa+XzCLAc4Sqi13iK5xvLeI5rKMZ8RSSCPvL04id4U=;
        b=Bw7+Xf9YHmDUnvh3xPvYzqrfazW0neLmUAH0dR4xEq5msFSRVWY4b/C4WYlMfbAVAU
         i4YU8yUSRHdKzSDozlFTSMK9Bw/r5y1UMZUEeM7eMb+P+1winWhzxoT7s6o0YbliqG07
         8LEFjeG/eNShbQR9GXCzUf/kYsBhLpy2JgQKdv/TDGF3IiCOMoXzE7L6Szf+m4RLEHb7
         o9H2LwtVPCOyBYFao4G2V8LqcphKHKxt7uoFxNJxgxoqyrQRnBPTxE7faybCH1QBQgQY
         8Y6tXpXEYUgme1xwJ17nTZfnbw2yTwQEXi5E4N+oJ1xggIy5QlTWtqGFdroIM6n+6MYj
         aOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713255622; x=1713860422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufa+XzCLAc4Sqi13iK5xvLeI5rKMZ8RSSCPvL04id4U=;
        b=iUlGRcPxSf6D8Xqdxo/4MNpX9K24nz93JthKn4HTwqQKjKh0gt4yxSvFUsSI0IxTtI
         nXCMwRnXj3DgOZAZiz/cUYoXxNy4ta3/RPommAykfEqwmHJcy2xGORTS5g6zYGaBN8gu
         Yk+rCw2sow51Ohe2SC4A9OVhcP3xce0n3gglYITl1uljNMpnFSnxWtIB1TqPquEXPIek
         YCj3wkTsI1mw35R1Q7oTIq86hI45jwimjeoAv+kwIY0JOtq/vFjpT5nRnwHfS3CpnMWm
         SG/LjdZJhwp/l9UQFstd7gNr24MEeYxZ9osEmXyXVW+TTtzRYCZiGY84P0dsdMCDfTBZ
         Fe4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUknJkBlvvYGgVxPY6ddymzhrEjT+KUnp9H+q1N/zdHPIhlM50K8azQzzWRhdMHb8DuRxxuLLCckZPKI0Q152vYHIu5uhqw
X-Gm-Message-State: AOJu0YxssOzTlGzDXmnqRUqBWlJYjfLTO+AiUu6t2mpIpuEqpr9LoHw5
	whz9dKNFKSuyDRbrULDo30JiX1Y4XoY/nf3UQ5NLyKwJAGMJYk5+WOPV4ykanhAlkRUchW5M9ON
	Ie65pIfwo/nVNKkrniGxCCx8jXH8=
X-Google-Smtp-Source: AGHT+IERiaeKxO4AatIchFxfQmny1mV0EcdvPqGEQnbjwfzwANJjLFlnnhrRekJl3uQ8iUU4Y171SfPElk3BxeJGURU=
X-Received: by 2002:a17:906:7f8a:b0:a55:3488:f730 with SMTP id
 f10-20020a1709067f8a00b00a553488f730mr2066240ejr.31.1713255621579; Tue, 16
 Apr 2024 01:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
 <20240411115630.38420-6-kerneljasonxing@gmail.com> <3b53762fbdfb7df1b3e79ea5138fabb714449d28.camel@redhat.com>
In-Reply-To: <3b53762fbdfb7df1b3e79ea5138fabb714449d28.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Apr 2024 16:19:44 +0800
Message-ID: <CAL+tcoDgYh3JVHOv9FGKA_dTjoDBD0CK+E4284RQNy6dUFbm2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/6] mptcp: support rstreason for passive reset
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2024-04-11 at 19:56 +0800, Jason Xing wrote:
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index ba0a252c113f..25eaad94cb79 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -308,8 +308,12 @@ static struct dst_entry *subflow_v4_route_req(cons=
t struct sock *sk,
> >               return dst;
> >
> >       dst_release(dst);
> > -     if (!req->syncookie)
> > -             tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NO=
T_SPECIFIED);
> > +     if (!req->syncookie) {
> > +             struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> > +             enum sk_rst_reason reason =3D convert_mptcp_reason(mpext-=
>reset_reason);
>
> Since you already have to repost, very minor nit: even the above
> strictly speaking does not respect the reverse xmass tree.
>
>                 enum sk_rst_reason reason;
>
>                 reason =3D convert_mptcp_reason(mpext->reset_reason);
> > +             tcp_request_sock_ops.send_reset(sk, skb, reason);

Thanks, I will update this too.

>
> Cheers,
>
> Paolo
>

