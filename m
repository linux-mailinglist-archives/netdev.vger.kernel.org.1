Return-Path: <netdev+bounces-114341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BF99423B6
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 02:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975DF284C4C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4BA38C;
	Wed, 31 Jul 2024 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8/MzkSr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811737FD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384623; cv=none; b=iFV5u+YWluyyfGbGhGjUVXud8hEVnpr39peTPtOQMWeYIyKLCnXzeDSXCnVrNOCNnheRD+aJ31CklUuHotjUQF+L38Q796u1wP5QH6iO/CTi7IUvbf4Y5HmtwAmyIHwsd/XKPRnexElKqxANylV3WRRE9kiJ9I+Qtpk9cpXSlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384623; c=relaxed/simple;
	bh=hB0Jy8r5BQyaS+m5gZ8Pio9xvFHUU4H2uaH5cwqbjk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMBM5AcpylDyM9IllGJdhQ3CmZkwuovVhgaVkDNjn2UuCVD3tYK/RYDM7/ZcGh+z0GdczwuMNgLdfPEIpUHc2HXOXh8L8bikTHTmXlh4YTBc095XpQ5ThJqGTCr8cPRMoOZpQwpMl9DMpteNK25Vef0XTybcE3zP9ZxfoKMTLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8/MzkSr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso7000990a12.1
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 17:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722384620; x=1722989420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZuIwJcPU3S+4SS9Cs6ewElVLZYFDMC40/1gxn+vxf0=;
        b=h8/MzkSrBcmR/ieODDUor3SkfXToh1Eegl4pGegrnA8XSgfvmBUr6CplnPRbuNK8K3
         MlRsy+R0q1xXpnPREJ01nq8q48nMzIhGiEYXclUWPZDInSw5mpUvfTgTD1Rwk+1sjjzw
         IpsEOVDGn6P51tP+HlHSkBfC4EQp6tHbdJ8J3NdjfeHJIJ8mIT3OzxGQjHYv7P+aZHj5
         2GVRI7tfMpUI+K8pGog9KXZS6IptF8p9KwWNW9j4ZwxtYGOv4Dkws8oL5DwN1PMyxMq/
         be/96A5UVbIZyqGm0Z1RplV1iQWwVWBjpOuOMsCJGXxKpjBWHl/qwN1aVdpwOxx15jnd
         ITWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722384620; x=1722989420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZuIwJcPU3S+4SS9Cs6ewElVLZYFDMC40/1gxn+vxf0=;
        b=A/edAKsqOdqqgNRydBZx89K6W9Sp7Izquf1JalEg0MpuWwBPPEJglWa14PMXSRhvR6
         +xDEl/ENze2aqqPPZBbMIVV30jrk+bDv790rJlaTHDLnbfa/p6e5MfM14naLVFGXOdPn
         GXagWPj44x3NredBGrWTT9eLkqZF3kFLg3+bvAZCEyo5Wfp/DXGv1yxEr+pMdDPCsSC4
         w/6SrJvPTHlKUr2s+IEug6KWWR+o5lTw1Iph5HBMl3hPJwo6G6vloRKi9RbXM6PGaEea
         aC/VHN+tSSLglDqwAlL6Z+iBwenOMLB9BaJ+gg5603ljtICIhPYMqb/dIFWcuhZuefFA
         5b3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2C5iaanixgA54d2r1ZB1cybQP444fbhxmBpERU/csUswi0oQO4f0oT4qQES9iW3d+aQQ/Z5dVfVpc6kBcGke11sNDi6s0
X-Gm-Message-State: AOJu0YzjhXzKQg4/C0FlwRn2mdUgqsNbkwgzXsJbyZyrQNd/Scoqyd3M
	3u+1x/acltR1ve9OUYENO+vvdAjwxfg+fVnt4+Rz1iIUs+ycZXRcYi/4U769373lEuIwboZT3Yo
	0DyygFotBVXDxrnMB84gB8XZBd5g=
X-Google-Smtp-Source: AGHT+IFM1inRzOo38tpBUTr0B6+KTPLNWRqQWQqHQXGvABaXGqE51NwMiBBDodP9zhoaTd3TUhWjORWklE0ILAz422o=
X-Received: by 2002:a05:6402:3508:b0:5a1:83c4:c5a8 with SMTP id
 4fb4d7f45d1cf-5b020ba89fbmr9888383a12.14.1722384619385; Tue, 30 Jul 2024
 17:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730133513.99986-6-kerneljasonxing@gmail.com> <20240730200019.93474-1-kuniyu@amazon.com>
In-Reply-To: <20240730200019.93474-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 31 Jul 2024 08:09:42 +0800
Message-ID: <CAL+tcoB-12pUS0adK8M_=C97aXewYYmDA6rJKLXvAXEHvEsWjA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] tcp: rstreason: introduce
 SK_RST_REASON_TCP_TIMEOUT for active reset
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 4:00=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Tue, 30 Jul 2024 21:35:12 +0800
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Only when user sets TCP_USER_TIMEOUT option and there is no left
> > chance to proceed, we will send an RST to the other side.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/rstreason.h | 7 +++++++
> >  net/ipv4/tcp_timer.c    | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> > index fecaa57f1634..ca10aaebd768 100644
> > --- a/include/net/rstreason.h
> > +++ b/include/net/rstreason.h
> > @@ -21,6 +21,7 @@
> >       FN(TCP_ABORT_ON_LINGER)         \
> >       FN(TCP_ABORT_ON_MEMORY)         \
> >       FN(TCP_STATE)                   \
> > +     FN(TCP_TIMEOUT)                 \
> >       FN(MPTCP_RST_EUNSPEC)           \
> >       FN(MPTCP_RST_EMPTCP)            \
> >       FN(MPTCP_RST_ERESOURCE)         \
> > @@ -108,6 +109,12 @@ enum sk_rst_reason {
> >        * Please see RFC 793 for all possible reset conditions
> >        */
> >       SK_RST_REASON_TCP_STATE,
> > +     /**
> > +      * @SK_RST_REASON_TCP_TIMEOUT: time to timeout
> > +      * When user sets TCP_USER_TIMEOUT options and run out of all the
> > +      * chance, we have to reset the connection
> > +      */
> > +     SK_RST_REASON_TCP_TIMEOUT,
>
> nit: Maybe SK_RST_REASON_TCP_USER_TIMEOUT ?
>
> It's more user-friendly.

Oh, after you reminding me, I double-check this part and find this
changelog is not that right because there is the other case where user
doesn't set TCP_USER_TIMEOUT option:
"user_timeout =3D=3D 0 && icsk->icsk_probes_out >=3D keepalive_probes(tp)"
in tcp_keepalive_timer().

I will correct my comment as well.

I think I can keep SK_RST_REASON_TCP_STATE instead of
SK_RST_REASON_TCP_USER_TIMEOUT to show "we already try as many times
as we can whether TCP_USER_TIMEOUT option is set or not, but we have
to reset".

Thanks,
Jason

