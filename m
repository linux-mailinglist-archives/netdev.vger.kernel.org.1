Return-Path: <netdev+bounces-229060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E54FEBD7C91
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E9FF4FD3B2
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 06:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9AF2D3233;
	Tue, 14 Oct 2025 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9vDS8CY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9552773FC
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424855; cv=none; b=OphVwv7tUq3uLzJ1rpvSMaq/7BofaFUPFB/h7gZ4ndMasRuaz7s6uwRlXzq2pJ9o40vI9cXr4m78k9bpzYtMLTKn+JmUtRC1tWaikVQcVac3wLyO8IIdLRKIXPqYD2riGpE2KXHzxgkZlqIZj4Z5w19O7+IfIzFZfpI4ANoBVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424855; c=relaxed/simple;
	bh=C77vjtoQLp4Ub906Pu9+IX7c5GBfEFPHSL90pMrvDXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssJ1vRu0mA0yy7b/sStLv04QvHaYUkDN9sUBOdRvnJOSuSbKKR+A8TIIVD6rmtC8oaVibNzaV9ThhG65bvm/KiflVPwSqCFXulsnbjf6+9PLieU9Ft+R7BCbjT/t4bk9Y/BvtyXNuE8DYZZJPE+j3Q1NTT01f80AAljmklDioiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9vDS8CY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-86302b5a933so531537485a.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760424853; x=1761029653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RbSXbsYD7yQDx2z0s3W+hp6JpYT4VL+rMoWcRjt0qc=;
        b=I9vDS8CYrSCLPc3wu5duq/dLRaOHuSvZ8eu2jcuKEI5MjrUC4rc2m+V4BNc353JhlH
         5TwNkMbQuYP/UFXKoUBgDrlWJcFlasMVnztXg2eGQ9Twl4AS1bZBQr8lrDnKPplPVxXa
         qSLnoT5rWDukPqD6SmQJ7ExDLULd9IISbMpf1XRQJU1+w2EjVBm2YDQcjpDf9nMQ8Zve
         TpRsQGuAUTfU6LYnPLfapPVPyWR63fMYQ9NPq0Iiqs34GwRF/MzajN8mMrknSl/tnoCY
         AklITxKpyWkuSDYZxY0nvDs84GazAliWAhJPmY4n9indDYgQSORomJ/RXLUIvdftlQGg
         yGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424853; x=1761029653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RbSXbsYD7yQDx2z0s3W+hp6JpYT4VL+rMoWcRjt0qc=;
        b=h+4iEHLKaUMkavXB+JvFegQoQTN1wBIDrxSAh4um+LFtb/vRMmekboY2D2hO5rOrIQ
         ljwWVMwPQmhhmjyGQBRl7WKmrWSSKutToS3s1zSbWBQlsalkcSOsm6h9hxdlZRP59N7k
         eFt5B4970KLXM5SS69Pfm40rox04fNxUOZipNYPUaFSh/Sv4lSUgkv46yFyn8qD70hCl
         d/8FtN63e/5jMYFjrb6Bqe3GT4o7XoBSGdk3+z4td4ZeDmhRi5yWzcSzE0s5ijqq68Se
         hGdRDMll1CrdTpK/2tOaxr+IWEa9Kab0vjSo43LI09PnumPHFoqkNa75pONdfjnySocX
         Ctwg==
X-Forwarded-Encrypted: i=1; AJvYcCVlHc3cSq8vPD0qXwwiR6VaeJxrk7JJsrblSyqzz6yX7kH9ezS6zuKGhjfOOuGf07v9LOqaPX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfN0pPDjrqKkmvvfvfNSqYo3r6Xhpn7t9VlH9FJgytVnf0ryq
	RWApJnktPxFh3p2B+H4t9BTGe8+PRSAIAKdhPMTcZ9bSZWi8TqG9qAULQVgM65D2vLQmaxleEpo
	1ZSP6mKCr1N9M5xCOdNIDE17is17HgcFS4EKYNSOZ
X-Gm-Gg: ASbGncvLOZ9bzHQCUpO8JG0ew8NRa7xRYhAsQODoQNpdwyw2eZnYl2MW6aGaRsiscsK
	WW+KfaC/QoSAMg6LSGcV4DKFh3OacWcFnibIQQkHUf5++7uRRv9sCE4bu29z9EdZL1RoTJ3blzj
	fpW4J8YQFCJUxsh8JTGGeGDP7znpqrc25o2u22VY4WdDKcqOzDtunZDsU9YsJ+ptRAVItPgzAzL
	4UBzAk9kT4hgcLo9UfZPbuxrZk0y10Aor8A60Pflvw=
X-Google-Smtp-Source: AGHT+IH0YIn9KY7F9e5f40eQDfKwPl1GYGI1uOZiMKY5q4lLw5fqv8PJ7OMMrOkkuyoU0YVB5qhLeOvjsHy37jLgN/M=
X-Received: by 2002:a05:622a:1813:b0:4b6:1a4d:36f6 with SMTP id
 d75a77b69052e-4e6ead8238fmr327480171cf.83.1760424852641; Mon, 13 Oct 2025
 23:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014060454.1841122-1-edumazet@google.com> <aO3voj4IbAoHgDoP@krikkit>
In-Reply-To: <aO3voj4IbAoHgDoP@krikkit>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Oct 2025 23:54:00 -0700
X-Gm-Features: AS18NWA0n86BCSU0SMSu_uQnpyhN9Cz-_DtQqdBWw6t104JvaXPn8lAEAj5qCng
Message-ID: <CANn89iJ-t1sHTrRKQfnHVa7xyAh2=WYW27PthNGXs3=pSKY+MA@mail.gmail.com>
Subject: Re: [PATCH net] udp: drop secpath before storing an skb in a receive queue
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Michal Kubecek <mkubecek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:37=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.ne=
t> wrote:
>
> 2025-10-14, 06:04:54 +0000, Eric Dumazet wrote:
> > Michal reported and bisected an issue after recent adoption
> > of skb_attempt_defer_free() in UDP.
> >
> > We had the same issue for TCP, that Sabrina fixed in commit 9b6412e6979=
f
> > ("tcp: drop secpath at the same time as we currently drop dst")
>
> I'm not convinced this is the same bug. The TCP one was a "leaked"
> reference (delayed put). This looks more like a double put/missing
> hold to me (we get to the destroy path without having done the proper
> delete, which would set XFRM_STATE_DEAD).
>

Hmm, this was bisected to use of skb_attempt_defer_free(), surely holding
xfrm in a per-cpu queue looks the same to me.

We also had recent syzbot reports hinting at that.

> And this shouldn't be an issue after b441cf3f8c4b ("xfrm: delete
> x->tunnel as we delete x").
>
> > Many thanks to Michal and Sabrina.
> >
> > Fixes: 6471658dc66c ("udp: use skb_attempt_defer_free()")
> > Reported-and-bisected-by: Michal Kubecek <mkubecek@suse.cz>
> > Closes: https://lore.kernel.org/netdev/gpjh4lrotyephiqpuldtxxizrsg6job7=
cvhiqrw72saz2ubs3h@g6fgbvexgl3r/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Sabrina Dubroca <sd@queasysnail.net>
> > ---
> >  net/ipv4/udp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 95241093b7f0..3f05ee70029c 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1709,6 +1709,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk, s=
truct sk_buff *skb)
> >       int dropcount;
> >       int nb =3D 0;
> >
> > +     secpath_reset(skb);
>
> See also the comment for udp_try_make_stateless:
>
> /* all head states (dst, sk, nf conntrack) except skb extensions are
>  * cleared by udp_rcv().
>  *
>  * We need to preserve secpath, if present, to eventually process
>  * IP_CMSG_PASSSEC at recvmsg() time.
>  *
>  * Other extensions can be cleared.
>  */
>
>
> It looks like this patch would re-introduce the problem fixed by
> dce4551cb2ad ("udp: preserve head state for IP_CMSG_PASSSEC").

Arg, I tried to not slow down the consumer part, too bad for XFRM then.

What about then :

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 95241093b7f0..ac45e4056c51 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1853,6 +1853,7 @@ void skb_consume_udp(struct sock *sk, struct
sk_buff *skb, int len)
        if (!skb_shared(skb)) {
                if (unlikely(udp_skb_has_head_state(skb)))
                        skb_release_head_state(skb);
+               secpath_reset(skb);
                skb_attempt_defer_free(skb);
                return;
        }

