Return-Path: <netdev+bounces-184875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789BA9788F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5577C1B607D7
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 21:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF2F1F2377;
	Tue, 22 Apr 2025 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GB7eL9mu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D57DDA9
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745357460; cv=none; b=HwyuoP128jbtINuOHpWplArEKAkGjNGzA9QPskyL9nVVbBUXJfjWMirFhJB46nx9I5qyBi/IuIi9TIJtZKq3SlsjsZPurcc79UC3oVd/2mMvrBVPg3m4P5Hq5S3E4J8SgyOOZAc+IoavZs8QD893jgyPLYrktoCNDezDMLvwhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745357460; c=relaxed/simple;
	bh=QgWx/mGTOHW5+7tGU+2WKWru7coX4Xp6cIn7ZGTb7ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBrEuswipuP5xZxLYBrQBNWQN1GD/f6UTaJ2vRYColdVnOjEpFgztbctMHjJHX/ptmqf1cCHdz8ZGtFfoA4jhexov0WVqZlqlcAp1hAnaUb6STACD8j7oH90TIb5dH4AjFrT6FqIeq3mpqk0ezQCB7K7C90h+Iv49IJ6IRi/fV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GB7eL9mu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2242ac37caeso21945ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745357457; x=1745962257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Svf2ygZXkmCy0ML2RTDTzsfPn2nyYFTdu9KxKlqPAMw=;
        b=GB7eL9muGEq2eNRHjsAa5UlA8JCZVgnhmydKuptdQE9PiUvhitHuM6+nHl7k4fP6j0
         I1jbWoTqUSt+FBJJaRSjdH//1cpvP5jqCQBqH6Cegb+j9XcV09M2zJ61iTqdndkB2aAp
         GjZeu9EJk9PDm2NXxkTw13580cEMqXX6LzjP+eNIcgm7B8o1g2Ynh1vfZD+6byvbhdvF
         YobfiM53q1xsDnAryKQdgc/W+m4KICbdn4qvcZ858aOU4Zr5hJDE6mKVvNt+q56YV+Iy
         YrzRZIYrJvekbfs9gUk1fb1ocKhivgNcDljcEx5YFVx3CsDIJ+AOZJgpbo9sfxw/sABW
         bGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745357457; x=1745962257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Svf2ygZXkmCy0ML2RTDTzsfPn2nyYFTdu9KxKlqPAMw=;
        b=ZBre9z9EcYfRlNOAt3s2uTeoaKPUFDPiKEmTTTcz8D4gLuyO6vW85ou886Lt343NcM
         e6wPKqTdJDsXwILgNXLACfLPoS0xJqXfRBIlCNGeon47zZ307xj6YbGgyWsUvPIyFdrN
         EPH/9UPBgaBH+vM+xgXauAYAv8KoXiK9vftj/hZ6DvyfD+YuufX+tM2a7wwWgz75IdpP
         n3kWzA9qL/IIvfAXJ0JwGN5EmrDCmVazAObLkkzrhrKw9iRWvF9DwbQVey3BfDJS1SRR
         zrtbybZz5BJ9nJZva1n5fjPgeXUVfSDaNQExrSyuA6yBNik5i9l/U2U1fdlLc4NSFk2N
         iFew==
X-Gm-Message-State: AOJu0Yys72gGi+FlyQ9bKFqYQi12gCkL4LXeRMfmUkD8Bol396Uf9oBn
	+SjwIaGHtXGso4u1KDLczHm8aMV0vl7Gcvhw8rWnV74QDrkPGPrfpupEFkkzS4PyHtI1KlukHeO
	sT+XaU/NjNKS6mWCquFK1v7gxo+LIz/j44hHl
X-Gm-Gg: ASbGnctm+SqRh2wwHKmPfvv7hSudj/u+33+VFv+1vyormDa0YR5EnXN05ay3Lq7RYqb
	fDGhwBSGfGyqvfwjNRCWno2sI0+xnq6h/i5qG1YA/bntPke3LcKJdYKd3OCkMUesQrrOuwrOBeQ
	rM4VysqYG3wJ9JzvfbXqZ8GKQJ04eNw7M3ZhS8/4HwjQAWYUo4IGIZ
X-Google-Smtp-Source: AGHT+IEsxPoKV42ELz4r3PlLIa9B44ITOq/P7IHVyPrE3pHPM2hSBs7ANYJO9Qlwme81VQmpCIMF5XJigErG9Bs9itA=
X-Received: by 2002:a17:903:f8b:b0:21f:3c4a:136f with SMTP id
 d9443c01a7336-22da2c11b3emr916085ad.28.1745357456832; Tue, 22 Apr 2025
 14:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-8-almasrymina@google.com> <CAEAWyHckGSYEMDqVDT0u7pFCpO9fmXpEDb7-YV87pu+R+ytxOw@mail.gmail.com>
In-Reply-To: <CAEAWyHckGSYEMDqVDT0u7pFCpO9fmXpEDb7-YV87pu+R+ytxOw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Apr 2025 14:30:44 -0700
X-Gm-Features: ATxdqUF6FGOZDMaVY4FPxfYTFEWH1OIzJQfd7hMv2NVJ5VM5o9Gd234gao1kzAo
Message-ID: <CAHS8izNZXmG0bi15DpmX2EcococF2swM83Urk19aQBvz=z3nUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/9] gve: add netmem TX support to GVE DQO-RDA mode
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 10:43=E2=80=AFAM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> On Thu, Apr 17, 2025 at 4:15=E2=80=AFPM Mina Almasry <almasrymina@google.=
com> wrote:
> >
> > Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
> > enable netmem TX support in that mode.
> >
> > Declare support for netmem TX in GVE DQO-RDA mode.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v4:
> > - New patch
> > ---
> >  drivers/net/ethernet/google/gve/gve_main.c   | 4 ++++
> >  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 8aaac9101377..430314225d4d 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -2665,6 +2665,10 @@ static int gve_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
> >
> >         dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
> >         dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_=
format);
> > +
> > +       if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
> > +               dev->netmem_tx =3D true;
> > +
>
> a nit: but it would fit in better and be more uniform if this is set
> earlier in the function where other features are set for the
> net_device.
>

Thanks for taking a look. I actually thought about that while trying
to implement this, but AFAIU (correct if wrong), gve_is_gqi and
gve_is_qpl need priv to be initialized, so this feature set must be
performed after gve_init_priv in this function. I suppose this feature
checking maybe can be put before register_netdev. Do you prefer that?


--=20
Thanks,
Mina

