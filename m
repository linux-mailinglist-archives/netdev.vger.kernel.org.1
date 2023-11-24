Return-Path: <netdev+bounces-50709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD7F7F6D39
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 08:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE511C20DC4
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F02D7465;
	Fri, 24 Nov 2023 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3ZOEYBV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71F8EA
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 23:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700812445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tM3FbA/FXKwKB680LSCg9mPgd0J8u7S5eRMQXElH1k=;
	b=M3ZOEYBVzV76vZD+lZ+LR15XLLUbpg8XDQm76MxVaN3v7ZI6on2acpBYuWtC0voCOGlrD9
	rKcGIDfBVNM7btOoj+7M6bsXTaqT7zSXzMeIb40J8wBy1vCVqIZW/0bEYv2KNAdZGFoXK6
	gEvCpt4U+ZkkJWJp/pGDzbGuMSJTBuU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-kzWGk-7BOkSHjj0b4G9zOQ-1; Fri, 24 Nov 2023 02:54:04 -0500
X-MC-Unique: kzWGk-7BOkSHjj0b4G9zOQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9fe081ac4b8so32833066b.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 23:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700812442; x=1701417242;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tM3FbA/FXKwKB680LSCg9mPgd0J8u7S5eRMQXElH1k=;
        b=Du9r1OXq5jKdc92gS4KCShol4/p6adTSKaxuEUddkbux+CK5+Ju0aopGJdp+mectOl
         6BQMqxVqj/8oSX9DNN4iU78+9jmMmMAxuxrnrzRtqSGYRmjfDIJnp2xJz0TqCefhMajF
         xbmqOrldYGOVEmIoSfh0eiPFxiWFDvawUmHO6zO+3gSOxknCgapE79K0n7AMhqq+jI1D
         eYYXBjqNhfTfpAP460ar2ID+JKObisa3bZip6uYlLWBiOsfN9aVC57n1+105bglayl1S
         BZ69J+tluz4+s/uJ1c4W7ePYMI0p0vBHd5IGLWsyBaPKGwqla+zd/N8TXV79gRD3Q633
         AZdA==
X-Gm-Message-State: AOJu0YyjiBc3TGku89JBQGyy9eJcOl94jO0PCbSwCLb/FNzfoMLtQRGc
	GMh2D4yT8VDO0Vv6yQoIb3RGImYbTvbg6p/M8+dnSWHgCxYf1/bFcuDPxneaAQxRQ8oN8mWoCo8
	KDXtlUYQewgEHjawKVhdy/QY9
X-Received: by 2002:a17:907:bc7:b0:9bf:b83c:5efd with SMTP id ez7-20020a1709070bc700b009bfb83c5efdmr1054786ejc.3.1700812442679;
        Thu, 23 Nov 2023 23:54:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdwHBrMGiSTpfHuLBwlXHYYPeMPfG7qnhuBWRB9BkaxxexSdXucn3mqbBLzKa2htOl8iZLxg==
X-Received: by 2002:a17:907:bc7:b0:9bf:b83c:5efd with SMTP id ez7-20020a1709070bc700b009bfb83c5efdmr1054771ejc.3.1700812442296;
        Thu, 23 Nov 2023 23:54:02 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id v5-20020a170906488500b0099cc3c7ace2sm1772378ejq.140.2023.11.23.23.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:54:01 -0800 (PST)
Message-ID: <3f549b4f1402ea17d56c292d3a1f85be3e2b7d89.camel@redhat.com>
Subject: Re: [PATCH net] tcp: fix mid stream window clamp.
From: Paolo Abeni <pabeni@redhat.com>
To: Neil Spring <ntspring@meta.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Wei Wang <weiwan@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
	 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
	 <kuba@kernel.org>, David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 24 Nov 2023 08:54:00 +0100
In-Reply-To: <SA1PR15MB5187F56AEFC6B6A581E056C5A3B9A@SA1PR15MB5187.namprd15.prod.outlook.com>
References: 
	<fab4d0949126683a3b6b4e04a9ec088cf9bfdbb1.1700751622.git.pabeni@redhat.com>
	 <CANn89iJMVCGegZW2JGtfvGJVq1DZsM7dUEOJxfcvWurLSZGvTQ@mail.gmail.com>
	 <ebb26a4a8a80292423c8cfc965c7b16e2aa4e201.camel@redhat.com>
	 <SA1PR15MB5187F56AEFC6B6A581E056C5A3B9A@SA1PR15MB5187.namprd15.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-11-24 at 05:27 +0000, Neil Spring wrote:
> >=20
> > ________________________________________
> > From: Paolo Abeni <pabeni@redhat.com>
> > Sent: Thursday, November 23, 2023 10:16 AM
> > To: Eric Dumazet; Neal Cardwell; Wei Wang
> > Cc: netdev@vger.kernel.org; David S. Miller; David Ahern; Jakub
> > Kicinski; Neil Spring; David Gibson
> > Subject: Re: [PATCH net] tcp: fix mid stream window clamp.
> >=20
> > !------------------------------------------------------------------
> > -|
> > =C2=A0=C2=A0This Message Is From an External Sender
> >=20
> > > -----------------------------------------------------------------
> > > --!
> >=20
> > On Thu, 2023-11-23 at 18:10 +0100, Eric Dumazet wrote:
> > > CC Neal and Wei
> > >=20
> > > On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m>
> > > wrote:
> > > >=20
> > > > After the blamed commit below, if the user-space application
> > > > performs
> > > > window clamping when tp->rcv_wnd is 0, the TCP socket will
> > > > never be
> > > > able to announce a non 0 receive window, even after completely
> > > > emptying
> > > > the receive buffer and re-setting the window clamp to higher
> > > > values.
> > > >=20
> > > > Refactor tcp_set_window_clamp() to address the issue: when the
> > > > user
> > > > decreases the current clamp value, set rcv_ssthresh according
> > > > to the
> > > > same logic used at buffer initialization time.
> > > > When increasing the clamp value, give the rcv_ssthresh a chance
> > > > to grow
> > > > according to previously implemented heuristic.
> > > >=20
> > > > Fixes: 3aa7857fe1d7 ("tcp: enable mid stream window clamp")
> > > > Reported-by: David Gibson <david@gibson.dropbear.id.au>
> > > > Reported-by: Stefano Brivio <sbrivio@redhat.com>
> > > > Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> > > > Tested-by: Stefano Brivio <sbrivio@redhat.com>
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > ---
> > > > =C2=A0net/ipv4/tcp.c | 19 ++++++++++++++++---
> > > > =C2=A01 file changed, 16 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index 53bcc17c91e4..1a9b9064e080 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -3368,9 +3368,22 @@ int tcp_set_window_clamp(struct sock
> > > > *sk, int val)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return -EINVAL;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tp->window_clamp =3D 0;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > > > -               tp->window_clamp =3D val < SOCK_MIN_RCVBUF / 2 ?
> > > > -                       SOCK_MIN_RCVBUF / 2 : val;
> > > > -               tp->rcv_ssthresh =3D min(tp->rcv_wnd, tp-
> > > > >window_clamp);
> > > > +               u32 new_rcv_ssthresh, old_window_clamp =3D tp-
> > > > >window_clamp;
> > > > +               u32 new_window_clamp =3D val < SOCK_MIN_RCVBUF /
> > > > 2 ?
> > > > +                                               SOCK_MIN_RCVBUF
> > > > / 2 : val;
> > > > +
> > > > +               if (new_window_clamp =3D=3D old_window_clamp)
> > > > +                       return 0;
> > > > +
> > > > +               tp->window_clamp =3D new_window_clamp;
> > > > +               if (new_window_clamp < old_window_clamp) {
> > > > +                       tp->rcv_ssthresh =3D min(tp-
> > > > >rcv_ssthresh,
> > > > +                                            =20
> > > > new_window_clamp);
> > > > +               } else {
> > > > +                       new_rcv_ssthresh =3D min(tp->rcv_wnd, tp-
> > > > >window_clamp);
> > > > +                       tp->rcv_ssthresh =3D
> > > > max(new_rcv_ssthresh,
> > > > +                                              tp-
> > > > >rcv_ssthresh);
> > > > +               }
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > =C2=A0}
> > >=20
> > > It seems there is no provision for SO_RESERVE_MEM
> >=20
> > Indeed I did take that in account.
> >=20
> > > I wonder if tcp_adjust_rcv_ssthresh()  could help here ?
> >=20
> > I don't know how to fit it into the above.
> > tcp_adjust_rcv_ssthresh()
> > tends to shrink rcv_ssthresh to low values when no memory is
> > reserved.
> >=20
> > Dealing directly with SO_RESERVE_MEM when shrinking the threshold
> > feels
> > easier to me, something alike:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (new_window_clamp =3D=3D old_window_clamp)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 0;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tp->window_clamp =3D new_window_clamp;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (new_window_clamp < old_window_clamp) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
int unused_mem =3D
> > sk_unused_reserved_mem(sk);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
tp->rcv_ssthresh =3D min(tp->rcv_ssthresh,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_window_c=
lamp);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
if (unused_mem)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tp->rcv_ssthresh =3D max_t(=
u32, tp-
> > >rcv_ssthresh,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tcp_win_from_space(sk,
> > unused_mem));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0} else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
new_rcv_ssthresh =3D min(tp->rcv_wnd, tp-
> > >window_clamp);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
tp->rcv_ssthresh =3D max(new_rcv_ssthresh,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tp->rcv_ssthresh);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > Possibly the bits shared with tcp_adjust_rcv_ssthresh() could be
> > factored out in a common helper.
> >=20
> > > Have you considered reverting  3aa7857fe1d7 ("tcp: enable mid
> > > stream
> > > window clamp") ?
> >=20
> >=20
> > That would work, too and will be simpler.
> >=20
> > The issue at hand was noted with an application that really wants
> > to
> > limit the announced window:
> >=20
> > https://gitlab.com/dgibson/passt
> >=20
> > I guess touching rcv_ssthresh would be a bit more effective.
> >=20
> > Not much more in the end, as both window_clamp and rcv_ssthresh can
> > later grow due to rcv buf auto-tune. Ideally we would like to
> > prevent
> > tcp_rcv_space_adjust() from touching window_clamp after
> > TCP_WINDOW_CLAMP - but that is another matter/patch.
> >=20
> > Thanks!
> >=20
> > Paolo
> >=20
>=20
> The patch to fix the bug where rcv_sshthresh is reduced to zero on a
> full receive window and cannot recover is:
> -tp->rcv_ssthresh =3D min(tp->rcv_wnd, tp->window_clamp);
> +tp->rcv_ssthresh =3D min(tp->rcv_ssthresh, tp->window_clamp);

FTR I considered something similar to the above, but I opted for the
present patch, as the above does not pass the pktdrill suggested by
Eric here:

https://lore.kernel.org/netdev/6070816e-f7d2-725a-ec10-9d85f15455a2@gmail.c=
om/

Cheers,

Paolo


