Return-Path: <netdev+bounces-103549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAB6908977
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A231F29BA1
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E419415F;
	Fri, 14 Jun 2024 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXd/2q0n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE65194136
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360145; cv=none; b=UmiU1GkO4QFwvOLXAo89MYLamAYpDZoveN3Euc6BWmH8As/ZL+Tireta9d0x1PdBzr7OWQxN8oLj0bBnG/ZfcCFkBLaCb9u2HopAtQVRnOXe6EUswAM1Kqo3xtWAtgwbre9laTMuDoGhdvsgsYUKFF0FfvzV0R1DE6pP85gsVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360145; c=relaxed/simple;
	bh=mSLPA1i53EANLvzv7lD+fCQb3/raPzj7PypBQ1WdFno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=McahFaxO/Z2SaHNZQqW22KA1TvEiOPkKP29k1fvJvHdNzRUVW484RoFNmwUjOaBvVpsDGco+1gMLvO3u+449mHO17CfDiG9Ftia1yPbfY9nPC41oagxJo7p9lfFsqi3pJ/eNOeSFoRNeCWp6IJ5mPEPkB21kQ/stjkITlKP+zWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXd/2q0n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718360143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8mqWsyKxLBqBkwikgUCvnkt5JK8D0SkaAXbzF+jGVsw=;
	b=VXd/2q0nkE3px+C27Xn49hbeDuIqUOPPRof0sNX9JKDJ7ffVvhfJXe35PqcDnq6ycDX9kJ
	g9dCquCoc2r1zEXEtAg4vNGxmIesiPOhUjL1NL8jihTSk+fxfkXwp53LU2uLa7f50ylV6Q
	PixiU4bVTXsdcZMRv6qPLqpdj2vmFMg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-AR1vNHIcM2KvXRkTyDvUWA-1; Fri, 14 Jun 2024 06:15:41 -0400
X-MC-Unique: AR1vNHIcM2KvXRkTyDvUWA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2eae267d112so3252291fa.1
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 03:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718360140; x=1718964940;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mqWsyKxLBqBkwikgUCvnkt5JK8D0SkaAXbzF+jGVsw=;
        b=G14oUXr4SwINE+SH/7ghziAEJO1JjjthYLvuijZW5QvzqHT6XSmZH+BLMq9RBUJC+5
         vjrWGogUzY0ytnG2FQMLc/k0xpOA8nox8/lFUFogTFA4Ux7pO5AmJakytOXQHJpCyFdC
         NG2tRVlyZW+abxLEqxZ95iuOrB6c6x9eNMYk3KCwvaEkUyQDlPOL98Ll0aW7mSGk1PeW
         kTQl3NaQc6aSYh/Joh351nEVQjFSI8ySCM00SAuBPtm23h7jP3RM0tEHUonZ5XMrjFq5
         f87vu43g6WqAeHxPKOKo9IaTn1QsduLE1CVnTNEJHUfYY7b9MSJ6dvvMBM2p8oRZbq/l
         jPAA==
X-Forwarded-Encrypted: i=1; AJvYcCWnUrQv+s/rlRSOSBlPNA1JJ7RrEBv8dV77/8i4VdUs9RTXMN83myY0twDPUCCdygkmEPiyyC+XT3iJjTk6/iDcmSdDdC1I
X-Gm-Message-State: AOJu0YxXPj/FWGkH8m2qttSBBaP/M1QU+GmUXcs3ZiYZhv8tGn3UCV9L
	X6O0Pj/puvfjOKSs59O/0qwwX2X7J5ZKbN7EP8qLN1gNIYdyW8plFXpHI6cwPI52+LMlwviCBcr
	4mu0YFqAPmPVxKArcjLX69RAyGN8kw8TrNHueZ5iTvcJOBQdkXdfdXQ==
X-Received: by 2002:a2e:bc19:0:b0:2eb:de36:676a with SMTP id 38308e7fff4ca-2ec0e5ae7d3mr17238561fa.3.1718360139794;
        Fri, 14 Jun 2024 03:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR4mJllrnsgIeA6uqs0Q3wm4lFXvXmOm54/SyDMjr3RtMuhU3cMVwtOIMBjhzW+v6Mkof30g==
X-Received: by 2002:a2e:bc19:0:b0:2eb:de36:676a with SMTP id 38308e7fff4ca-2ec0e5ae7d3mr17238391fa.3.1718360139374;
        Fri, 14 Jun 2024 03:15:39 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b083:7210:de1e:fd05:fa25:40db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de5d5sm92329575e9.33.2024.06.14.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:15:38 -0700 (PDT)
Message-ID: <86109f6c4a8303950ac13811a3f8506ff44a6cfc.camel@redhat.com>
Subject: Re: [PATCH v4 net-next 1/7] net: add rx_sk to trace_kfree_skb
From: Paolo Abeni <pabeni@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Yan Zhai <yan@cloudflare.com>,
  netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Abhishek Chauhan
 <quic_abchauha@quicinc.com>, Mina Almasry <almasrymina@google.com>, Florian
 Westphal <fw@strlen.de>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Daniel
 Borkmann <daniel@iogearbox.net>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, Pavel
 Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org, 
 kernel-team@cloudflare.com, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Neil Horman <nhorman@tuxdriver.com>,
 linux-trace-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Date: Fri, 14 Jun 2024 12:15:36 +0200
In-Reply-To: <fed7b2ca-5180-417f-a676-fb126157dff3@kernel.org>
References: <cover.1718136376.git.yan@cloudflare.com>
	 <dcfa5db9be2d29b68fe7c87b3f017e98e5ec83b4.1718136376.git.yan@cloudflare.com>
	 <fed7b2ca-5180-417f-a676-fb126157dff3@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 09:59 +0200, Jesper Dangaard Brouer wrote:
>=20
> On 11/06/2024 22.11, Yan Zhai wrote:
> > skb does not include enough information to find out receiving
> > sockets/services and netns/containers on packet drops. In theory
> > skb->dev tells about netns, but it can get cleared/reused, e.g. by TCP
> > stack for OOO packet lookup. Similarly, skb->sk often identifies a loca=
l
> > sender, and tells nothing about a receiver.
> >=20
> > Allow passing an extra receiving socket to the tracepoint to improve
> > the visibility on receiving drops.
> >=20
> > Signed-off-by: Yan Zhai<yan@cloudflare.com>
> > ---
> > v3->v4: adjusted the TP_STRUCT field order to be consistent
> > v2->v3: fixed drop_monitor function prototype
> > ---
> >   include/trace/events/skb.h | 11 +++++++----
> >   net/core/dev.c             |  2 +-
> >   net/core/drop_monitor.c    |  9 ++++++---
> >   net/core/skbuff.c          |  2 +-
> >   4 files changed, 15 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> > index 07e0715628ec..3e9ea1cca6f2 100644
> > --- a/include/trace/events/skb.h
> > +++ b/include/trace/events/skb.h
> > @@ -24,13 +24,14 @@ DEFINE_DROP_REASON(FN, FN)
> >   TRACE_EVENT(kfree_skb,
> >  =20
> >   	TP_PROTO(struct sk_buff *skb, void *location,
> > -		 enum skb_drop_reason reason),
> > +		 enum skb_drop_reason reason, struct sock *rx_sk),
> >  =20
> > -	TP_ARGS(skb, location, reason),
> > +	TP_ARGS(skb, location, reason, rx_sk),
> >  =20
> >   	TP_STRUCT__entry(
> >   		__field(void *,		skbaddr)
> >   		__field(void *,		location)
> > +		__field(void *,		rx_skaddr)
>=20
> Is there any reason for appending the "addr" part to "rx_sk" ?
> It makes it harder to read this is the sk (socket).
>=20
> AFAICR the skbaddr naming is a legacy thing.

I'm double-minded about the above: I can see your point, but on the
flip side the 'addr' suffix is consistently used in net-related
tracepoints.
>=20
> >   		__field(unsigned short,	protocol)
> >   		__field(enum skb_drop_reason,	reason)
> >   	),
> > @@ -38,12 +39,14 @@ TRACE_EVENT(kfree_skb,
> >   	TP_fast_assign(
> >   		__entry->skbaddr =3D skb;
> >   		__entry->location =3D location;
> > +		__entry->rx_skaddr =3D rx_sk;
> >   		__entry->protocol =3D ntohs(skb->protocol);
> >   		__entry->reason =3D reason;
> >   	),
> >  =20
> > -	TP_printk("skbaddr=3D%p protocol=3D%u location=3D%pS reason: %s",
> > -		  __entry->skbaddr, __entry->protocol, __entry->location,
> > +	TP_printk("skbaddr=3D%p rx_skaddr=3D%p protocol=3D%u location=3D%pS r=
eason: %s",
>                                ^^^^^^^^^
> I find it hard to visually tell skbaddr and rx_skaddr apart.
> And especially noticing the "skb" vs "sk" part of the string.

I agree 'rx_skaddr' is sub-optimal. Either be consistent with all the
other net tracepoints and use 'skaddr' (which will very likely will
increase Jesper concerns, but I personally have no problem with such
format) or prefer readability with something alike 'rx_sk' or (even
better) 'sk'.

Thanks,

Paolo =20


