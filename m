Return-Path: <netdev+bounces-172651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62195A55A0B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924331898430
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496427CB23;
	Thu,  6 Mar 2025 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOTan+I4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB61F4185
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301097; cv=none; b=pDyInEylH1VxgozI6o585CHoYurFQqrmWJUT9uTovZnKET42Y3mK4nA1PV9NiyFFntrzTrIAsyzDBg1LVaoELYAuYftyWMdzWHxrP87HLqqYSUj48YvefvSWtr8kfM24JWfsQa2TMDF4v5mlft0uVO4kNTcwE5G8KpdOoUveZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301097; c=relaxed/simple;
	bh=WJGCuAvULpegUxMdbOK1NHjZx/sGgwb92zX49N6RDkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okWbktn+MetU++Fp74PPh0ZMQbN8ZI305sz0eNeyQhK5U2VTcCQCr2puIWOZB/WUzsYH48+P5qfKIk2PmSD57JZcBX5imbqTBhyu/XJ3BdmntFvCDD9+fpLYKFUtmCigh5RNlv1XJZN8OLatWrgaFJL53K7JS7qr0JF40l7CvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOTan+I4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240aad70f2so61745ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 14:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741301095; x=1741905895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJGCuAvULpegUxMdbOK1NHjZx/sGgwb92zX49N6RDkA=;
        b=MOTan+I41gCr2d1GB8Xs6Lbx8+4B5Eh49nNkmhmZ1JIhS0QEInna++EqD3GkW4LIQk
         G6xBxiFM4ehF43qfNLA08eTgyjhAuELXyV2gy8vY5k06fNTfam8NUTR6Anjd7oH/oSEa
         j08o51JuN2Mcoj9ZD5ro39XQCNJjpc9WRGRtz2iZOKjE57Cr5TK13FU6WopaDuKmc24x
         D+gorw/IlxsnwFb2L0mZaGJ4xIG0OjLU1K35/3+drfaLv5ld5qvbs94+Ak1P2eMmfJit
         Lhcpe0tlhWmW6Mld8IXbCNiBglX3jM72vrpesgZZxYRB0oXIhRYWuZpP2L5vDfNvyAVG
         LqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741301095; x=1741905895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJGCuAvULpegUxMdbOK1NHjZx/sGgwb92zX49N6RDkA=;
        b=dAu6WNW6lHiFsx4IwrXYrWxYLL3aoX9DMbxTGA3KPu6phcwXgQUFSMlB+gRhoLUshx
         H9K/pNPoXnxPrrRI8znrgu/Jcwj08ACqjum6WsWmFPF3uNWX2QLc5qltbLwybmWN7uHO
         t6gdtoW1Xs2vomq0E9FZPsVTIXcyeNGqJODnutkjNICHqQrxAmaGfMpFGixcX4G9EbO1
         X9Rt6HRyChzCw6bF/oiWBvqHCyzs7TlYu56NMa2f5pIuVEexH8ETFR7KBdFZmpGROTHS
         ZAPphoQ9XovkYxghEoCFfEYRky4tgCEQ+1xC9DBUNdkjoI6O1t0OE69U5eGuMJjoLzPa
         V2gA==
X-Gm-Message-State: AOJu0YyqJnwUxRw9dSouJBgoiTaW0i2Hd1g5nRHj6Om/d6cVUZM5X5c5
	VX3f4TiTHmxsBdO1YH09McN6ZjS6vfLwMMiSZOfSxQ7NLyRdJhXyUHq6NgWqZjjpRe8fLEsMALu
	9W+pO9UE645RI4GLaNzqu3Lp+Ig771igQ4HVu
X-Gm-Gg: ASbGnctGQMH6pE3i7naabG4b26Bl+3X9oyoWMj9mJUkviq6gp+nV4S36TSCXPQTiKXm
	jk6a1zqdJTaw9D/4HlYxywfJ3Qww/MzO4jlfFmq880RK5rSX4I+Be8UsEQWLiVHwTAIVqSwEolR
	iKJGmI/W8EUqzSqcXO6eFLInCbh014MGNLiOzc1XkJL/UPI8k5+LKiwQ==
X-Google-Smtp-Source: AGHT+IGS+g4ZXFAp2nGdJpOHDce9EEY1Ln9JHFM0oHkP+LPpqqepXFJR4Sm8vslWM6D7/epATYsYkpZ1n4ukdSKEsNY=
X-Received: by 2002:a17:902:ea0c:b0:216:21cb:2e14 with SMTP id
 d9443c01a7336-2242a62b87amr242655ad.21.1741301095087; Thu, 06 Mar 2025
 14:44:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-2-almasrymina@google.com> <20250228163846.0a59fb40@kernel.org>
 <CAHS8izNQnTW7sad_oABtxhy3cHxGR0FWJucrHTSVX7ZAA6jT3Q@mail.gmail.com>
 <20250303162051.09ad684e@kernel.org> <CAHS8izNWt2-1bC2f0jv4Qpk_A9VpEXNvVRoXUtL43_16d-Ui-A@mail.gmail.com>
 <20250306134019.1702e609@kernel.org>
In-Reply-To: <20250306134019.1702e609@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Mar 2025 14:44:41 -0800
X-Gm-Features: AQ5f1JpdzmIgb4Qp1uwhgyjnsZGuDnrddzCXLNm0isLe9E-TpLpq-VU4X-9HjRo
Message-ID: <CAHS8izM8dnFNj5p8vKiyhV9qeE+9=a=BWRnH=vCu49Tq_XTL9g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/8] net: add get_netmem/put_netmem support
To: Jakub Kicinski <kuba@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Shivaji Kant <shivajikant@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 1:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 4 Mar 2025 17:39:37 -0800 Mina Almasry wrote:
> > > > Yes, great idea. I don't see why it wouldn't work.
> > > >
> > > > We don't expect mixing of net_iovs and pages in the same skb, but
> > > > netdevsim could create one net_iov skb every N skbs.
> > > >
> > > > I guess I'm not totally sure something is discoverable to syzbot. I=
s a
> > > > netdevsim hack toggleable via a debugfs sufficient for syzbot? I'll
> > > > investigate and ask.
> > >
> > > Yeah, my unreliable memory is that syzbot has a mixed record discover=
ing
> > > problems with debugfs. If you could ask Dmitry for advice that'd be
> > > ideal.
> >
> > Yes, I took a look here and discussed with Willem. Long story short is
> > that syzbot support is possible but with a handful of changes. We'll
> > look into that.
> >
> > Long story long, for syzbot support I don't think netdevsim itself
> > will be useful. Its our understanding so far that syzbot doesn't do
> > anything special with netdevsim.
>
> Meaning it doesn't currently do anything special, or you can't make it
> do anything special with netdevsim?
>

Meaning it currently doesn't do anything special with netdevsim. I
imagine we may be able to create a specialized syzbot instance that
loads netdevsim and starts fuzzing its APIs. However I'm told
specialized syzbot instances are much less valuable than making the
feature discoverable to existing syzbot instances, which is why our
thoughts went to adding devmem/unreadable skb support to virtio or
tun/tap.

Do I surmise from your question you prefer a netdevsim-based approach?
(and just curious maybe, why?)
> > We'll need to add queue API/page_pool/unreadable netmem support to
> > one of the drivers qemu (syzbot) uses, and that should get syzbot
> > fuzzing the control plane.
> >
> > To get syzbot to fuzz the data plane, I think we need to set up a
> > special syzbot instance which configures udmabuf/rss/flow
>
> To be clear for Tx you don't need RSS and flow steering, Tx should
> be trivial for any device driver which managers DMAs directly (not USB).
>

Yes, we don't need queue API or page_pool support or header split
either for that matter. TX fuzzing is definitely simpler. Maybe we can
start with that.

--
Thanks,
Mina

