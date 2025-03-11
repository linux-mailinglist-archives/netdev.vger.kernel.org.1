Return-Path: <netdev+bounces-174057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A08BA5D346
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 00:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DB0189B741
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 23:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E02233159;
	Tue, 11 Mar 2025 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKLjwWDD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836207B3E1
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736625; cv=none; b=IPUe4sw7rNtiLeD4XRJYveoszs2DEH1MEtudBG9gGWcI3IffrcRPXtJS+N1d4crp5lCoHTXeqsYCvMDWpVBU+tCligSHIHFaX+f1D+GRxTmqnfxcYqOBE91r0TT/Y/mlUgQGklgbk8+WBx97fSYc3+jlLzofEsfqfuhu5Ij08eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736625; c=relaxed/simple;
	bh=iCgpy7jqhyG8ncQoVUWtdSeMN+6GBfsiRY/tnxRgmAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/zerbM1tsy3ZPv7YTlK3v1dtEl1yoT0Mv90zgYo9djn90DdLUM5Y3d7+5UFSjaLSNtXc4V8qTTw96hR4A4ZUzNZOIA2dvhj+yFZZkAHaJ5sQFN0ModUhcJSjr/WLzz02nihzmRkwIr3zW1sizP8lAg0diHCYJnL4IC37AmvsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKLjwWDD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so37295ad.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741736623; x=1742341423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ppVOVWNSTb9lRWGG7Ph6sN+tL6fna9IjQIMtQXlGkQ=;
        b=HKLjwWDDNbjvOxAt1qFgKJDaPS22Z/ZIKGIzUeZjkrvuomBtxUErQFAgRXhJ0wNLsN
         SrohY18P+MINSp9rRBqUZePTCduXM8k3SjzAoN0CQ5X4VGeuWXTlNqTHm9wEHq0AawCh
         ZCNUZxpDFaOb8HG+HJ67PPi91lfpjIYL06A+qsWKhvMqVcGFowkOM/1/eAJEfVBkUuc/
         hTqWXDf0U9mGTnibPwSfzrymwM6mvdNTXnnND4XcxtqDDo4+5LvBRP0S3uoi98F5si1p
         KE6Goo+f6XOk2/bONA36AXc1CUc9ySplug92cUINjZO0lPLXox1zMHg0eKY52ZpbX0Y2
         cssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741736623; x=1742341423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ppVOVWNSTb9lRWGG7Ph6sN+tL6fna9IjQIMtQXlGkQ=;
        b=WZXqLUxC+ASwQyyco/Gbp4zgwxFhAaN+RGLReHmwIA+e/HNLKMNaJL+Y/wwgv5pIgS
         oG+T/cQ/65g+vN38T/VZ76c1P6HoBBC9+zxL1ta1bpBAiu85n8qIJh30837HqOuZoMbe
         VpbEsjwSNQZr4K4j0W8sH014ozMFJ1xp7o7NrETW2HFns9F5GEZvGTo35GhXlt+FvQih
         LXuki3FN6T4IUZ03nK8JB/IieRaziqlgrgVwTLRvaWVctecasrTGQimXI8LZ8z5ciFps
         nqCkrKrXxClFeSCW48vnjLmuUYTrjEit8cgPSWFDv+aWEfySHsf+vZ8u5mGPY4w6HFfz
         cyoA==
X-Forwarded-Encrypted: i=1; AJvYcCXhYnPHfu/ZHJep6QuqfXdaA+Wl0prkHaSWsPGF10XglC8bRrGrdCTRRSWvMs8o7vG2SNHibys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMpA6a01F0fHW1kF0/DMSP2T/b/7l1L3NQ+G0BmcJOHGyFvef
	T8+gqubZalb2XYLEOEjk6ztn6xGCwIaEN3ggAV0og3UIp8a/PpPk5fDTeJaI79C+07MUg7Cpkeb
	+pnuw7lqFEddQJ2hwgtScfb2uWHMxVa9BpY2i
X-Gm-Gg: ASbGnctTy+ZRowjqfHyw/v17A6ub3AZ/b4j/G5A4OItpNWKf8SVLTAFXRTIhEmjc8Pf
	QAtXbFizCgzvJOx6y/A4mNGTYNLn73R8IG/7USxKdbuChqiZuJmdvT9Oo0n6tY1tQo1b1AN+TJi
	5iB2/F0DzKnKGbXaZc0sL6rhOQnCLV1mHJt7rrrIWdSGzCD+p+f/SoWJi9
X-Google-Smtp-Source: AGHT+IFLU7rsQR2M0qHo6nW3AteBCzXQjrNolzxyumOYhESi054ErKG3j/6gAo4JH3I1joNusd4jReGkaGHr1pMOOpE=
X-Received: by 2002:a17:903:41c9:b0:224:38a:bd39 with SMTP id
 d9443c01a7336-225a935ef07mr1248865ad.20.1741736622493; Tue, 11 Mar 2025
 16:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144026.4154277-1-sdf@fomichev.me> <20250311144026.4154277-3-sdf@fomichev.me>
 <CAHS8izNVZ0RqccDKGiL2h+MesCrvza_kwck0RmsrTNAcTkcmjA@mail.gmail.com> <Z9CXDDrruPmTjdW5@mini-arch>
In-Reply-To: <Z9CXDDrruPmTjdW5@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Mar 2025 16:43:26 -0700
X-Gm-Features: AQ5f1JpCKj-RR2Ss6cUPvTr95MQ318RQBjbsQc4MI-nxp4MpOAIaOe8FRcqBnrM
Message-ID: <CAHS8izN=fPj+yMqZBFX83Bvbvpr-fXNnuN_GDq0eVXTOeB7aWg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: add granular lock for the netdev
 netlink socket
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, donald.hunter@gmail.com, horms@kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, 
	jdamato@fastly.com, xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, 
	dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 1:03=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 03/11, Mina Almasry wrote:
> > On Tue, Mar 11, 2025 at 7:40=E2=80=AFAM Stanislav Fomichev <sdf@fomiche=
v.me> wrote:
> > >
> > > As we move away from rtnl_lock for queue ops, introduce
> > > per-netdev_nl_sock lock.
> > >
> > > Cc: Mina Almasry <almasrymina@google.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > ---
> > >  include/net/netdev_netlink.h | 1 +
> > >  net/core/netdev-genl.c       | 6 ++++++
> > >  2 files changed, 7 insertions(+)
> > >
> > > diff --git a/include/net/netdev_netlink.h b/include/net/netdev_netlin=
k.h
> > > index 1599573d35c9..075962dbe743 100644
> > > --- a/include/net/netdev_netlink.h
> > > +++ b/include/net/netdev_netlink.h
> > > @@ -5,6 +5,7 @@
> > >  #include <linux/list.h>
> > >
> > >  struct netdev_nl_sock {
> > > +       struct mutex lock;
> > >         struct list_head bindings;
> > >  };
> > >
> > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > index a219be90c739..63e10717efc5 100644
> > > --- a/net/core/netdev-genl.c
> > > +++ b/net/core/netdev-genl.c
> > > @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, s=
truct genl_info *info)
> > >                 goto err_genlmsg_free;
> > >         }
> > >
> > > +       mutex_lock(&priv->lock);
> >
> > You do not need to acquire this lock so early, no? AFAICT you only
> > need to lock around:
> >
> > list_add(&binding->list, sock_binding_list);
> >
> > Or is this to establish a locking order (sock_binding_list lock before
> > the netdev lock)?
>
> Right, if I acquire it later, I'd have to do the same order
> in netdev_nl_sock_priv_destroy and it seems to be a bit more complicated
> to do (since we go over the list of bindings over there).

Thanks,

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

