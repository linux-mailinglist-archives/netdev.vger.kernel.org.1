Return-Path: <netdev+bounces-71282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F32852EC1
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034BA1F233E7
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962172BB11;
	Tue, 13 Feb 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIJgpSYD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA5134D8
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822375; cv=none; b=NwWeQSF+S9fcXBKeb4flHwdI6kyWf1rJDaVCpk+Nc2ivd9KHN7lwRZiwPx/7ttiaBjE9YA2Pa3Qk3icvy9GaHytTKARsXZXeGmFlm6Jnv8RG1uVDztnWnZUgcPX5DOAMROhvE4LHzmBcDM4Ilyd+oLr97LyspPAXbpS3hkfw+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822375; c=relaxed/simple;
	bh=F0pQhtqBv14yPji64KGWHKRDD5MfyyKbvlIQvnW80IM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d0Fv3raZNZpPKUB6y6gy79np31a1i0oowCCjByzH9f0Ede4Bu/SkkjCJyDTjqTrUsKxCmznFAHTETbknyYQ8vTIDeAOGHib76ihxM1uZZAYca34IHILSLfDaPgjwm9S+O593F2kxWxyb6T25y9Syj+rGpz0Wesk3P0fGyvUuVJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIJgpSYD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707822372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SV7ytk7u9OKA5iU58nPeIwpcrTWTpEXJuNDL9kuOWN4=;
	b=IIJgpSYDmI5Vmo/4DRQnwRZUAY6GvTL57ITID9XfC22rUBsj9fNPaDEL33pCJTVc8m64/V
	LYxUcLF09RfGkGVmAyV69BeNAjMSJ2g5CNS6k9f512gA9er/SLU3RI+z+GLbK4bvtjhfQN
	/oKwVPbZa6k2GuZ6wZxAA0anob+xWwo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-D9ivCmItMQCDdnApgoH8BA-1; Tue, 13 Feb 2024 06:06:09 -0500
X-MC-Unique: D9ivCmItMQCDdnApgoH8BA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6818b8cb840so16737466d6.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 03:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707822368; x=1708427168;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SV7ytk7u9OKA5iU58nPeIwpcrTWTpEXJuNDL9kuOWN4=;
        b=CSlIR9CR8e007h0BBRbq3OrfqXrU/qtLfiFGSfrXllasQh8zNKypGKqUVo5AMMH0dV
         k9gM/aCnZiBRqOu2/teemRfiweEhpHwY77O/HE/MXzRhsX5qlBKHQ33k0TcdaUrYUsgf
         o5tc/poeOAs3CgWLGFTTMOWSwunS5DtdIo14i/EDquIB3/EgS07rBuObtjGNgqD/R1En
         X1/BZBLoAd+FuIvOGY3QmvanFsFgvB/wPYfjA9/1Rx70bpDYOOnREtDWDufUNIFNuZoF
         ViCDLlr3bgUcKsdmX8du6S95N26UJVVL0AIZATVGb8f4QU7LUvbsbACiVmE3zx2cYwco
         pkug==
X-Forwarded-Encrypted: i=1; AJvYcCVGNccc+e7e+E7/glV447x2fcehm570f76U91+mGi251xVGEm+v3ozrJW3E2pqiZQwdkvqjG3lZ9ufxW0qxzkK7mTcjxIju
X-Gm-Message-State: AOJu0Yx8J/PdMSaksmut+hpXBDdhKOxByVRWt3GobU/PwEqVJbgMft4c
	ehwCEpd51nwRPZxiVbHjLcvE3A2X2Kw+48DnSlkqy6Xsgl1DvqARPU6usY0U+JRF9iuiFXubavt
	oMNJR1/C3nQKpkMKu4qyINEfh/Bxvu/zlqUY0X4oaUtNbv9QdGi+HWQ==
X-Received: by 2002:ad4:5b84:0:b0:68d:14b3:917c with SMTP id 4-20020ad45b84000000b0068d14b3917cmr4610072qvp.0.1707822368711;
        Tue, 13 Feb 2024 03:06:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETcitgDDCEWkdjU8N0sxsnQ/E3YCzgz563tL1/QIWf75VMK7x6rmBeYKXmQg0e22V5WTlisg==
X-Received: by 2002:ad4:5b84:0:b0:68d:14b3:917c with SMTP id 4-20020ad45b84000000b0068d14b3917cmr4610055qvp.0.1707822368426;
        Tue, 13 Feb 2024 03:06:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7GZ6ISyVvNeA7Sd5EdTdwKYsBNXpdnmW9lbvhYdJNsXV/CTm1PYLqIz8fWiYtWmlj2csI/ETs74jB1G0GoR2iAhqYq/qV120Ye+iO9jouVblue8DFWsUncXKOEh8fYTAgIsX7Jr7Wq36lOcrI7cr2D7XPgeQ1kJiPI9eN5fYuCpF0/riQEHXMh2ApGkc0zV+EVmqiEPgJfcAS56oQLExT6kgVBYK/QSZs3V4dQsZsKC1Fryzk8pqKDcA5zrE7boOyoQjLqeHzId4ku9vXO+XeRkQsAurFZnIfrW92vNhZquX6OA==
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id og13-20020a056214428d00b0068ee9d29b4esm392891qvb.140.2024.02.13.03.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:06:08 -0800 (PST)
Message-ID: <93a346087193c57f4df807c478d0f7fc8e7db6aa.camel@redhat.com>
Subject: Re: [PATCH net] net/sched: act_mirred: use the backlog for mirred
 ingress
From: Paolo Abeni <pabeni@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Davide Caratti
 <dcaratti@redhat.com>, xiyou.wangcong@gmail.com,  jiri@resnulli.us,
 shmulik.ladkani@gmail.com
Date: Tue, 13 Feb 2024 12:06:04 +0100
In-Reply-To: <CAM0EoMnYyyf7Zpa9eUFBU1vzx5QrUhFfXSFH4_utXOPU4+YFxQ@mail.gmail.com>
References: <20240209235413.3717039-1-kuba@kernel.org>
	 <CAM0EoM=kcqwC1fYhHcPoLgNMrM_7tnjucNvri8f4U7ymaRXmEQ@mail.gmail.com>
	 <CAM0EoMnYyyf7Zpa9eUFBU1vzx5QrUhFfXSFH4_utXOPU4+YFxQ@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 10:11 -0500, Jamal Hadi Salim wrote:
> On Mon, Feb 12, 2024 at 9:51=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >=20
> > On Fri, Feb 9, 2024 at 6:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >=20
> > > The test Davide added in commit ca22da2fbd69 ("act_mirred: use the ba=
cklog
> > > for nested calls to mirred ingress") hangs our testing VMs every 10 o=
r so
> > > runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
> > > lockdep.
> > >=20
> > > In the past there was a concern that the backlog indirection will
> > > lead to loss of error reporting / less accurate stats. But the curren=
t
> > > workaround does not seem to address the issue.
> > >=20
> >=20
> > Let us run some basic tests on this first - it's a hairy spot. Also,
>=20
> Something broke.
> Create a ns. Put one half of veth into the namespace. Create a filter
> inside the net ns.
> at_ns$ tc qdisc add dev port0 ingress_block 21 clsact
> at_ns$ tc filter add block 21 egress protocol ip prio 10 matchall
> action mirred ingress redirect dev port0
>=20
> Send a ping from host:
> at_host@ ping 10.0.0.2 -c 1 -I <vethportonhostside>
>=20
> And.. hits uaf.... see attached.

It looks like:

netif_receive_skb
run_tc()
	act_mirred=09
		netif_receive_skb
			sch_handle_ingress
				act_mirred // nesting limit hit
			// free skb
		// netif_receive_skb returns NET_RX_DROP
	// act_mirred returns TC_ACT_SHOT
// UaF while de-referencing the (freed) skb


No idea how to solve it on top of my mind :(

Cheers,

Paolo


