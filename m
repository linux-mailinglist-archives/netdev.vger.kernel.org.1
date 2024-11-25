Return-Path: <netdev+bounces-147178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAE29D81F7
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948C7280F01
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA218FDAA;
	Mon, 25 Nov 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhVksNXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C5318D64B
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526060; cv=none; b=lMv89vMM9neOyEFogllDPpU5R0Q8eK4jeqrmBWWsFnflo4bJPX7gDd7aj2cGlbRETUl479nwAfeSPn/7bJX6SrV0GUHswkEO938L7/hAe8ebJmwMQkT/ISca2KkH7xHX8E0E0E/HTFqB3Dk4l4JPq4+J0m70w584EFMLnVqQVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526060; c=relaxed/simple;
	bh=JMjvK4k4bb6oOKg6iGuuP6gQATOT6WiJruAMfADfNzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFJh7KxHfrmmwYpGb4PSwofl2PeUGKSX5UlQXtcy4SmLvQQgd3cXiFw4lflUGrSZooRw2jyj8/pscqbvlZwKYfbfMI/l2HeCI/UZnTqcsg3BXcBAWFTlS3B6BPJoScAVtJnqdFo1JU2eZ2hfj/aeCpMGeT9jFqwmxjljiUNuse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QhVksNXI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfd28222f9so2356935a12.1
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 01:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732526057; x=1733130857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uc/PIcYtA0WSqWtyRURVTdWtL1SYLs0y0Yck4mRgpY=;
        b=QhVksNXIduuhiLN+iY6WXA3rPWLbwPONt3caLV6VNrcM9mdLiiFHlEUDd4u41iN0j7
         5PEx8Fm+U3t80GeiatpHwdhHniSS8LglRT0Eno/QtZ7j74P3K6Ll4ECXKRSQ2UO0+1qV
         0zUND8UWWlpt18mIC+9qdfxfzkS6P4DOqg1zQXJEawMNz0hIlV68MMO2tvbzJYA3ST4A
         vmN6BKQRSsRmZx6dBbBFcZ0wAF8ZYmL29SSzGiGLK8V4mx25zlvuKTBfUHnfDoEmdh1d
         slXHno5Pl52AzUuWQ8AbSZKqi+MvtxHnvydzhIknRfydBDKm9Rm12dgaJYK3a/BWALS2
         2nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526057; x=1733130857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uc/PIcYtA0WSqWtyRURVTdWtL1SYLs0y0Yck4mRgpY=;
        b=uI97b7WixhH36DO4LBYgHTkr8IWzqIuwA5FC9qJntwEGyOQNoOQWfziUbeRaXUMfQS
         HD1zzB453WzHnnCDu4aT/BcimcDsebzH14R31yXAojl/CSUwDKBb+S+7ZeTt/yVVD6Gj
         wy/TlSTXf9bVb/7GszPFtRWP3frOM79y4/rW6HyFaAv7N6j0Up8fKsoyoyv08jKx2jIQ
         IMgZ5UbzS4CBE8kedGLevzzI8AxLb8/gJudnbAnWyhLS2PNd23SVMlpAS1/PU93v2a6d
         iu7tVvYEju+k/TivLp188G2s60g88GXsWhkrKemIvTRmxn1Asf3E15T0T8BXjlcFiFFf
         NyIA==
X-Forwarded-Encrypted: i=1; AJvYcCVxymdDMhFBTBj5ytYczR+vitZuH/XOfAt+7hBCfKwHOa6P6KY1JZJjGp/TPVQreyj+40l15lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcexfPVAiC6fQGSKxu0CMeT0s8/MHhIvsc+De5k/AW468Ei2d
	qOqAXLJRj4gmZZ0uXq3gurqMfCLULicrENzVFBLwTrTANpBSMJHWVcriyD/u8+wPs/qaS/HVH/q
	8+4mDcGInfrdX6hI+LOt08TgIbHHwlWuz1YZ2
X-Gm-Gg: ASbGncsYQq5rSRe5I7NkPsgavNP0pIXS4r1WZrWmmC2TGvQZCAOPfJln3lzcRzuK3lK
	pNnUcFiylly0LGbCe+5EXtZmggNEqXIE=
X-Google-Smtp-Source: AGHT+IFtbvbAtSiSyTZIhN4PEqpSTnsngRDrZP/p0JgPk7O8GPXGlP0p0SpxSPwNyfKG19/S+jLPpgmCbQZGuN/XaN4=
X-Received: by 2002:a05:6402:5298:b0:5cf:f248:7707 with SMTP id
 4fb4d7f45d1cf-5d0207c46abmr15326200a12.26.1732526056529; Mon, 25 Nov 2024
 01:14:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123174236.62438-1-kuniyu@amazon.com> <0c958770-2797-4a5c-997a-4df9ed068de8@huawei.com>
In-Reply-To: <0c958770-2797-4a5c-997a-4df9ed068de8@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Nov 2024 10:14:04 +0100
Message-ID: <CANn89iLjWdhr35M9VRbuznO63Ue-jqWcC28DGC9pFoTPkqepbg@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Fix use-after-free of nreq in reqsk_timer_handler().
To: "liujian (CE)" <liujian56@huawei.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:19=E2=80=AFAM liujian (CE) <liujian56@huawei.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/11/24 1:42, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> > The cited commit replaced inet_csk_reqsk_queue_drop_and_put() with
> > __inet_csk_reqsk_queue_drop() and reqsk_put() in reqsk_timer_handler().
> >
> > Then, oreq should be passed to reqsk_put() instead of req; otherwise
> > use-after-free of nreq could happen when reqsk is migrated but the
> > retry attempt failed (e.g. due to timeout).
> >
> > Let's pass oreq to reqsk_put().
> >
> > Fixes: e8c526f2bdf1 ("tcp/dccp: Don't use timer_pending() in reqsk_queu=
e_unlink().")
> > Reported-by: Liu Jian <liujian56@huawei.com>
> > Closes: https://lore.kernel.org/netdev/1284490f-9525-42ee-b7b8-ccadf660=
6f6d@huawei.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >   net/ipv4/inet_connection_sock.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index 491c2c6b683e..6872b5aff73e 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1191,7 +1191,7 @@ static void reqsk_timer_handler(struct timer_list=
 *t)
> >
> >   drop:
> >       __inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
> > -     reqsk_put(req);
> > +     reqsk_put(oreq);
> >   }
> Reviewed-by: Liu Jian <liujian56@huawei.com>
> >
> >   static bool reqsk_queue_hash_req(struct request_sock *req,

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

