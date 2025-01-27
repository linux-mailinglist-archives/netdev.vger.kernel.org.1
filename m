Return-Path: <netdev+bounces-161116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68507A1D7A2
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 15:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9DC3A5248
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9127925A643;
	Mon, 27 Jan 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVk02v4z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF685672
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986594; cv=none; b=RsB6rNmuwQm4QSLnYXNuA+GiL3hyB9kz0UafYj8o8tfx76d1I1kZLE+XUz25tfUVQsW+XghfxZWPNersdoqR35Pwwpqpd+y6EIh9D2+1wdgbzVoYEXaldq43jg7NnH6+scJtJTcB+gCzjMIrA5lUH6qOB8zJ0EQ1KwC9g+GcaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986594; c=relaxed/simple;
	bh=UYU4dzIJMyLfJHKnKewgJlcxIYZnzejpina/0JOwPgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAr0uy42Y/O6UDZdVqYM1foIMo+yhPcxW/GPSFHUqQeuQAlwbyEogXktKVuzfuydjbMTp0yHNEqJmWwdd9zazEAc7Ey3G4lEN84DuppetkgQWPChD7g6vuU5tqphw8YhnpRS7oPQLoLHHGwZIx1/fZS8vzWsL1REp9acz8x4s7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVk02v4z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737986591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yEaKPHLKMOA5meZrsgLJjdr3xqDqApW5Y4VWczVlm4=;
	b=cVk02v4ztQ0qOTOQtdRkWDFYkdhR8ggqq+fJsWwGpoF4lH09r3KKEomOWl5HIV0WvHD4Q9
	kcyenH+rZBqkzaeVUH26nlPyF5lMhfiyC1J5bRI1AVRtPLybp2ZZEdLp4ctXeyzJXXhzt6
	txxR9eSWNTgwzWuhuVX6t1uDaA+uilg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-xGKjPJrAPb-B8tZmG1t8BQ-1; Mon, 27 Jan 2025 09:03:10 -0500
X-MC-Unique: xGKjPJrAPb-B8tZmG1t8BQ-1
X-Mimecast-MFC-AGG-ID: xGKjPJrAPb-B8tZmG1t8BQ
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5401af853fbso2331931e87.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 06:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737986589; x=1738591389;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yEaKPHLKMOA5meZrsgLJjdr3xqDqApW5Y4VWczVlm4=;
        b=hM8h1NP79NxN0Xvzpd+WWXI0Qpw1/aGsAIb7Kpq0EiPxpt3XDoffCyfws66/zdAuBE
         14E/iPTc5tokSaAhobuIcihIZEuZEgp+teKTNa05DtGmphuxR7SLGPTfhEAad7jRRuIo
         JbURvk+fDruIxt+p5wqIhMQ6EtKse0mn1f1DH+G/qGDTU3DH4hT6AS119hl6LhBVH+zv
         ns8wqq7Kfl/KIJ4TkDw/JdUoR+JQF/4OK8XYC1asU6CluD6qmTwhF0rHJE+JcRyNy5t2
         FUz1Sbp4Ljgu/PYtwzNH19wRdjS4Se4L0614L/lZgUO4X6KxNeOQA7XfFighuvFlAXEu
         NxcA==
X-Forwarded-Encrypted: i=1; AJvYcCVzQld7KnJQG77tbVBLL7z0r+BkWADcahyjAUE2BEcwPl3PploJ7+R4cpUjDqvFtd68qK3iuM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2700234nyKiSkcYsIacWW1h6kA3OVYkJFDGGrG5QqQC/vl4Kp
	69FoQKa7OkrtU+DYSBcXqRRjdzJ6eRBQ7JcivyxT9ADXek0pZcwEDHsJB7YfcwJTt++BTdunNEO
	fmtSbFOg+XJXNr85z+uAGGID05Hb4osdN5toz8eXALM5AqzjYUwMaFw==
X-Gm-Gg: ASbGncuxBLE+mwox1BbUhuyVtipwarRvB1qD+f7PGX0InE9CPeNqrjjbTYfg4zfEHfx
	3erPnLat4njvFUtZlHok6z50FNGGmbGlzSJH5EGp9fsGKHBRFtC4urxIZmwzoKrKcvkO3scfh62
	OhpC1gpZKl6+wglmooQNUbOqR3wO44LWEGSSfoLRATSZd3AZDUIPEvsI7sKMUJLy9KfS2UD8pwe
	DO98vbkY5gOO9HliaMc/JOJwN5vRwJiz2TdU1fPv8CFkTiFwPeoInY3Qs2M+w/VPbM4lxINzhI+
	uMiKijcUViS6ZlnR
X-Received: by 2002:a05:6512:1154:b0:541:1c48:8bf1 with SMTP id 2adb3069b0e04-5439c24108fmr13525734e87.13.1737986588497;
        Mon, 27 Jan 2025 06:03:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPdnM5+tvUc7QDNtq/WnuXpbAUzEdHRTJutlDgDEGZNmEe8Hq5/yP4BmMPPqY0Qi/KewVCbg==
X-Received: by 2002:a05:6512:1154:b0:541:1c48:8bf1 with SMTP id 2adb3069b0e04-5439c24108fmr13525547e87.13.1737986586733;
        Mon, 27 Jan 2025 06:03:06 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f355sm131207135e9.4.2025.01.27.06.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:03:06 -0800 (PST)
Date: Mon, 27 Jan 2025 15:03:03 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, lvivier@redhat.com, dgibson@redhat.com,
 eric.dumazet@gmail.com
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
Message-ID: <20250127150303.46c9d9f5@elisabeth>
In-Reply-To: <CADxym3Zji3NZy2tBAxSm5GaQ8tVG8PmxcyJ_AGnUC-H386tq7g@mail.gmail.com>
References: <20250117214035.2414668-1-jmaloy@redhat.com>
	<CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
	<afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com>
	<c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
	<CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com>
	<e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com>
	<20250127110121.1f53b27d@elisabeth>
	<CAL+tcoBwEG_oVn3WL_gXxSkZLs92qeMgEvgwhGM0g0maA=xJ=g@mail.gmail.com>
	<20250127113214.294bcafb@elisabeth>
	<CADxym3Zji3NZy2tBAxSm5GaQ8tVG8PmxcyJ_AGnUC-H386tq7g@mail.gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jan 2025 21:37:23 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> On Mon, Jan 27, 2025 at 6:32=E2=80=AFPM Stefano Brivio <sbrivio@redhat.co=
m> wrote:
> >
> > On Mon, 27 Jan 2025 18:17:28 +0800
> > Jason Xing <kerneljasonxing@gmail.com> wrote:
> > =20
> > > I'm not that sure if it's a bug belonging to the Linux kernel. =20
> >
> > It is, because for at least 20-25 years (before that it's a bit hard to
> > understand from history) a non-zero window would be announced, as
> > obviously expected, once there's again space in the receive window. =20
>=20
> Sorry for the late reply. I think the key of this problem is
> what should we do when we receive a tcp packet and we are
> out of memory.
>=20
> The RFC doesn't define such a thing,

Why not? RFC 9293, 3.8.6:

  There is an assumption that this is related to the data buffer space
  currently available for this connection.

That is, out-of-memory -> zero window.

> so in the commit
> e2142825c120 ("net: tcp: send zero-window ACK when no memory"),
> I reply with a zero-window ACK to the peer.

Your patch is fundamentally correct, nobody is disputing that. The
problem is that it introduces a side effect because it gets the notion
of "current window" out of sync by sending a one-off packet with a
zero-window, without recording that.

> And the peer will keep
> probing the window by retransmitting the packet that we dropped if
> the peer is a LINUX SYSTEM.
>=20
> As I said, the RFC doesn't define such a case, so the behavior of
> the peer is undefined if it is not a LINUX SYSTEM. If the peer doesn't
> keep retransmitting the packet, it will hang the connection, just like
> the problem that described in this commit log.

It's not undefined. RFC 9293 3.8.6.1 (just like RFC 1122 4.2.2.17,
RFC 793 3.7) requires zero-window probes.

But keeping the window closed indefinitely if there's no zero-window
probe is a regression anyway:

- a retransmission timeout must elapse (RFC 9293 3.8.1) before the
  zero-window probe is sent, so relying on zero-window probes means
  introducing an unnecessary delay

- if the peer (as it was the case here) fails to send a zero-window
  probe for whatever reason, things break. This is a userspace
  breakage, regardless of the fact that the peer should send a
  zero-window probe

> However, we can make some optimization to make it more
> adaptable. We can send a ACK with the right window to the
> peer when the memory is available, and __tcp_cleanup_rbuf()
> is a good choice.
>=20
> Generally speaking, I think this patch makes sense. However,
> I'm not sure if there is any other influence if we make
> "tp->rcv_wnd=3D0", but it can trigger a ACK in __tcp_cleanup_rbuf().

I don't understand what's your concern with the patch that was proposed
(and tested quite thoroughly, by the way).

> Following is the code that I thought before to optimize this
> case (the code is totally not tested):
>
> [...]

--=20
Stefano


