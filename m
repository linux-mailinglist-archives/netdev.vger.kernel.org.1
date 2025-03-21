Return-Path: <netdev+bounces-176838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B1A6C5D1
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 23:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450641B61536
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 22:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913C7233153;
	Fri, 21 Mar 2025 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9QaZ2IE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E89233136
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595372; cv=none; b=MLm5+lfhQHUZT16t84W2oLDc4MmR9u1j+rCaFbOGaSlUW7iWu7SdSKUC1AE6IpJCDj1FJx9Rzsp9rnNIlqS0zPCkUZ5SiTIHO6j/yqa1esidBDes3N8FxAHCqiqkFgvXN67iDIuNq0K4zkxKOkqzXle6FMuq+MG1Yb3PuSmL0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595372; c=relaxed/simple;
	bh=xTN8uHl1SeuIX+6Go9vzBRBl5rKlx9/gkpF9UMsFCuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMkmKFCNwsCmosfMwl5uJxsVKHmdPi0O9fY1R+3te92J1+gwQ5YHIJ+EwSR/6WraWjslEf5NPHW7sAdihOmMDooXCptaIKKS7TR+1KEEtofoYyI7p0Tg5FKdwEvbnCh88+hL63VUp+nqpHUjoAKwZSwhWY/YMAsGwutVUylvyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k9QaZ2IE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2242ac37caeso27265ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 15:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595370; x=1743200170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KM/OqzMgVHyAstUImFrYrGve1V5xobanjZKdFyJS9w=;
        b=k9QaZ2IEHPEZY5y/aOSkfFUXsm0QLdx4ngo8Rd2qKM0/vjWIZFwDp3J+bMRNrGnqqQ
         wYtDm1aPW9NkgxH3Gc/mYv08vEL7Sb/b+qnMdDcjIbhqsNyusfcqeKVZZj3nL2Q4k36/
         fKntHDbZ6AXjF/t2TK6rSCiXwsGTXkBjUfR+MZ1uUZ9PVNFoJciPgX4iDSwFjHKfz+5g
         QGLmRR4bPTUQhJdoz1oBNpYbJ50bNNAEYjKOQhTS+d6dppdPZOIXY0j8HTGW2poytBt9
         Bt7/NL7iwcBZXVoXnx65s1OikkdWCbbFGYmYPXy5atrYI5l/ohbF59EXL595VDcf75Ym
         KdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595370; x=1743200170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KM/OqzMgVHyAstUImFrYrGve1V5xobanjZKdFyJS9w=;
        b=ffzvbA5NQbyWfCu06ct8ivv4z9PId1QAJ+GHxEwLVov1G6oEhcpioZa+tK4MES4kpk
         oo90rffzTCan6ZExTjx7wHmaj21Od3nGgZHK6w1V7t2LRHreLdT1yV4M1Q4pFpMW9f26
         l22WBxhJ+As6d16UTvfDvNXqhkZ2k5OOIKqc+O4RmzjVyajF5x/dQn6jrJQPYi89eReU
         A2Fs+6F8bjBgu5f0S4I474dx6D6zbQRb69Rr7M8euCdMvsHOKVFM5IqOt8yn9ETtYXr/
         /ocbQdhMp9sszeZgaV5bO0fOB95VCnLSO7XcTbfqDca+YTRJJpUEPxW86wb3BZ4MtrJ9
         NU2w==
X-Gm-Message-State: AOJu0YzRV/SI/sZtaw6orO0wRYOVV0FkCSGwCFhaWHw52ZyFwGvKVNX/
	muy/FovO2zXaOeemMkU/UGvsilVaCtL1F8VjcorYaUzL1zVbNvDhefn43B0YMHTzTE2+vpyPI1/
	9X5ItMgj0zCvB8l+7+KjB+G1cZrcDgWgIinpd
X-Gm-Gg: ASbGnctTUpi9JNSNMY0ooMRmUA6LGD9nYiuMVXUuB5oE4KjS2PofueSutDs/TT4oudN
	MRxZqAOn2mXjwKdBwMFvdBMkmL7pJNMtZIYEcSAqn+OBJxsyL16Li7E5hKjmkmH+WujlpFF/3Um
	7U6SWyJpSC4OazK+vTh3p5WXdmSawTe+sag7xBUrv63AlOnQUmbK9TBs0=
X-Google-Smtp-Source: AGHT+IFB6PSWq8585YC3bfe4eP32Yir6EYNkFzXJi8bOkq8iwWtXfNlhA5baw0lPh6UvS7ldsM4iZisORLPef1bKOlA=
X-Received: by 2002:a17:903:19e4:b0:215:86bf:7e46 with SMTP id
 d9443c01a7336-22799f6adb8mr317095ad.7.1742595369962; Fri, 21 Mar 2025
 15:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-4-almasrymina@google.com> <8fb48d36-f5ce-40ce-bb05-b4c342da8b4f@redhat.com>
In-Reply-To: <8fb48d36-f5ce-40ce-bb05-b4c342da8b4f@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Mar 2025 15:15:57 -0700
X-Gm-Features: AQ5f1JqTqeE1hEQJimNEPqykmM1XOpBm4kOaF6t5YahF7_VNclL_518XjsZaXEs
Message-ID: <CAHS8izNu6biiVg==pri8PeDVP9unZthGrwSj4fGr84o61sLFgg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/9] net: devmem: TCP tx netlink api
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 1:39=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 3/8/25 10:40 PM, Mina Almasry wrote:
> > From: Stanislav Fomichev <sdf@fomichev.me>
> >
> > Add bind-tx netlink call to attach dmabuf for TX; queue is not
> > required, only ifindex and dmabuf fd for attachment.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v3:
> > - Fix ynl-regen.sh error (Simon).
> >
> > ---
> >  Documentation/netlink/specs/netdev.yaml | 12 ++++++++++++
> >  include/uapi/linux/netdev.h             |  1 +
> >  net/core/netdev-genl-gen.c              | 13 +++++++++++++
> >  net/core/netdev-genl-gen.h              |  1 +
> >  net/core/netdev-genl.c                  |  6 ++++++
> >  tools/include/uapi/linux/netdev.h       |  1 +
> >  6 files changed, 34 insertions(+)
> >
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index 36f1152bfac3..e560b05eb528 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -743,6 +743,18 @@ operations:
> >              - defer-hard-irqs
> >              - gro-flush-timeout
> >              - irq-suspend-timeout
> > +    -
> > +      name: bind-tx
> > +      doc: Bind dmabuf to netdev for TX
> > +      attribute-set: dmabuf
> > +      do:
> > +        request:
> > +          attributes:
> > +            - ifindex
> > +            - fd
> > +        reply:
> > +          attributes:
> > +            - id
> >
> >  kernel-family:
> >    headers: [ "linux/list.h"]
> > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > index 7600bf62dbdf..7eb9571786b8 100644
> > --- a/include/uapi/linux/netdev.h
> > +++ b/include/uapi/linux/netdev.h
> > @@ -219,6 +219,7 @@ enum {
> >       NETDEV_CMD_QSTATS_GET,
> >       NETDEV_CMD_BIND_RX,
> >       NETDEV_CMD_NAPI_SET,
> > +     NETDEV_CMD_BIND_TX,
> >
> >       __NETDEV_CMD_MAX,
> >       NETDEV_CMD_MAX =3D (__NETDEV_CMD_MAX - 1)
> > diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> > index 996ac6a449eb..f27608d6301c 100644
> > --- a/net/core/netdev-genl-gen.c
> > +++ b/net/core/netdev-genl-gen.c
> > @@ -99,6 +99,12 @@ static const struct nla_policy netdev_napi_set_nl_po=
licy[NETDEV_A_NAPI_IRQ_SUSPE
> >       [NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] =3D { .type =3D NLA_UINT, },
> >  };
> >
> > +/* NETDEV_CMD_BIND_TX - do */
> > +static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABU=
F_FD + 1] =3D {
> > +     [NETDEV_A_DMABUF_IFINDEX] =3D NLA_POLICY_MIN(NLA_U32, 1),
> > +     [NETDEV_A_DMABUF_FD] =3D { .type =3D NLA_U32, },
> > +};
> > +
> >  /* Ops table for netdev */
> >  static const struct genl_split_ops netdev_nl_ops[] =3D {
> >       {
> > @@ -190,6 +196,13 @@ static const struct genl_split_ops netdev_nl_ops[]=
 =3D {
> >               .maxattr        =3D NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
> >               .flags          =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> >       },
> > +     {
> > +             .cmd            =3D NETDEV_CMD_BIND_TX,
> > +             .doit           =3D netdev_nl_bind_tx_doit,
> > +             .policy         =3D netdev_bind_tx_nl_policy,
> > +             .maxattr        =3D NETDEV_A_DMABUF_FD,
> > +             .flags          =3D GENL_CMD_CAP_DO,
> > +     },
> >  };
> >
> >  static const struct genl_multicast_group netdev_nl_mcgrps[] =3D {
> > diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
> > index e09dd7539ff2..c1fed66e92b9 100644
> > --- a/net/core/netdev-genl-gen.h
> > +++ b/net/core/netdev-genl-gen.h
> > @@ -34,6 +34,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
> >                               struct netlink_callback *cb);
> >  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info=
);
> >  int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *inf=
o);
> > +int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info=
);
> >
> >  enum {
> >       NETDEV_NLGRP_MGMT,
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index 2b774183d31c..6e5f2de4d947 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -931,6 +931,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, st=
ruct genl_info *info)
> >       return err;
> >  }
> >
> > +/* stub */
> > +int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info=
)
> > +{
> > +     return 0;
> > +}
> > +
> >  void netdev_nl_sock_priv_init(struct list_head *priv)
> >  {
> >       INIT_LIST_HEAD(priv);
>
> I'm sorry, but this chunck does not apply cleanly anymore.
>
> Please rebase.
>
> Disclaimer: unfortunately I must note that due to the long backlog
> pending and the upcoming merge window, I'm unsure I'll be able to
> process the next revision before the net-next closing.
>

Thanks Paolo. I have also been under the weather the last couple of
days so I haven't even been able to repost. I guess I'll repost after
the merge window if netdev closes today.

--
Thanks,
Mina

