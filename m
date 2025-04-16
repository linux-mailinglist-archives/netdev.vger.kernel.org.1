Return-Path: <netdev+bounces-183346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F2A90739
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A17189E250
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5461FCFF8;
	Wed, 16 Apr 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrqnPilG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912E154430
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815734; cv=none; b=EhPt6+tm3GxKdZ7c+LT0SidMNqTuZylGb3KFvYpbUTNNbmUGvpTRcNwTH4QsNViFKxmCiNpcHiwBlraRg9dsksFoVrpjHsMw+j9TGdKSEzlh5SuNIDVGh0ymwu9sYKSH8JyZ0WYD9kf6TxUj9WEKIO0835EjHbogZ1n+wGn38yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815734; c=relaxed/simple;
	bh=sFk6AzCNmzcQWTmmV5UfpxeE01+a0qktAGHnI6NpFc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=py87jOPRQ+dIcChyD+Ul8WlMtbamCeVVXv5Q4XbZ/ewLlBuzuT/C1zeKRnJ6MTLt2nJgAPYn+tyTFECt7cxOInyWOVlyyfLAVNRw2auMqr1N7/UJoA6TfoGm+css7YlmiTeGMC/usGMXqXqoxIfopYYIirpoDTaJGkh9hbxFPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrqnPilG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2241053582dso96029405ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744815732; x=1745420532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMI8leTo/cRlYQldT3bW4Unca0nC5R+Pb1ZPLyerO0g=;
        b=PrqnPilGdaY4PTvB3rEgPCwaNYE4eBhvXT0QF4VovaBrYdnM7d/xMz0A15jMfDc4fk
         StbnXKyiNyjfG/s9i4SpYSUkRpirEyF/L3wmR2s3hjkFvk477S2I9gZdGsEu6CnXg2Sl
         mCnjks7KZlApGDIVJcZmsZWdxKx+MFeh+KMxbJVdXvYWfKeg3KzTepU2b6SLtfqgqWwS
         sU/KtxeLAvtjSvwR6fjvDTn0SYzlLItST4QyWjeVy9sezRa10x2IQChsyeMmu+1g+e+A
         rNUPOHvX9BVMYNT4BxlBSxrWjWQjfHvuUthLZhaQ7BazrDDPdZ4dLzwUankqolOI7oQn
         wg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744815732; x=1745420532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMI8leTo/cRlYQldT3bW4Unca0nC5R+Pb1ZPLyerO0g=;
        b=iujKMqEdEgyQ0IdfnuIMel7gMRmD1lk/9rFeYu/MRUN//ECg3tKDthMwmvCHLtyPSZ
         MT5haqzYWgqxIoq+qC15YYC+Zoy0BHpgqagKVWMvd92AJaxBM+05frza+hojS/l7L2FN
         x80Ww/GVyVkQUZsB6t+Tms5KeY3B83zVhHQ6UvO2v7xxuxyEcIXGLtvMlpLoanYcOAUi
         K/6DKwkWFR1Mu30igdPGf8Kco2HQNK2Sy1X1wJB7S0rqPYEjRS/czvYnyDEuZbH/viTW
         QVWA4DcJaEmTXup4xgGtk3sX61PoXF7jWexrDroWpguzXR/h/slVhvi8dGw6PN5ayHEP
         8x+w==
X-Forwarded-Encrypted: i=1; AJvYcCXmfTDksJ56M14esC+FJ28VxQR5g040mATGKLRJ0LiKGDABxmG1A7ybokDh+Xoeg5QKRUeMxYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEb2vcPsLqsQP1K4ZIBuUOvSQlWfgFncQo9qdyU6RImVM1y+v7
	zBJMCm4WrdkA17DDwfg/DtsIy/XQ4IoqLibRLpq/KmPmC6as50UenfMSalkjXN83TzpibuYASi0
	J5twisscbIyX4moUHjmRv4OAzK308Agpk
X-Gm-Gg: ASbGncuqXhfkt5Yu1tpI+/W02xQ0Hra0DgGIs5z01uQl/kl4wfwZ7L6W++Vb2dCXDy0
	UFld2eMdQJ3h6pkHUTknkAbuzgmTUGkggdo8PPpdrsxCVhXlPdOh7wCrxGQHGybQGQ4XWQZz7VZ
	Q82aQnYsXe4dnxrmCPtu1J+o4=
X-Google-Smtp-Source: AGHT+IHRtyOJYjaXTKJ8oczbUA803JOOeP7OssKLmSsL8lPy1QeV4QLXHgp14jCeAiH+Hai9DjiZj/7cajYon+fCNeg=
X-Received: by 2002:a17:902:ea07:b0:220:be86:a421 with SMTP id
 d9443c01a7336-22c3597ee46mr37127355ad.38.1744815731848; Wed, 16 Apr 2025
 08:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415092417.1437488-1-ap420073@gmail.com> <CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
 <Z_6snPXxWLmsNHL5@mini-arch> <20250415195926.1c3f8aff@kernel.org>
In-Reply-To: <20250415195926.1c3f8aff@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 17 Apr 2025 00:01:57 +0900
X-Gm-Features: ATxdqUGSHMddZmOYELNvl28WyiLKzYqfX14PD_nP6LvM5gSuJ65WOlcF_49FJg0
Message-ID: <CAMArcTWFbDa5MAZ_iPHOr_jUh0=CurYod74x_2FxF=EAv28WiA@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close after
 module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Mina Almasry <almasrymina@google.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	skhawaja@google.com, simona.vetter@ffwll.ch, kaiyuanz@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 11:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>

Hi Mina, Stanislav and Jakub,
Thank you so much for the reviews!

> On Tue, 15 Apr 2025 11:59:40 -0700 Stanislav Fomichev wrote:
> > > commit 42f342387841 ("net: fix use-after-free in the
> > > netdev_nl_sock_priv_destroy()") and rolling back a few fixes, it's
> > > really introduced by commit 1d22d3060b9b ("net: drop rtnl_lock for
> > > queue_mgmt operations").

Yes, you're right.
The real fix would be commit 1d22d3060b9b
("net: drop rtnl_lock for queue_mgmt operations").

> > >
> > > My first question, does this issue still reproduce if you remove the
> > > per netdev locking and go back to relying on rtnl_locking? Or do we
> > > crash somewhere else in net_devmem_unbind_dmabuf? If so, where?
> > > Looking through the rest of the unbinding code, it's not clear to me
> > > any of it actually uses dev, so it may just be the locking...

Accessing binding->dev causes a crash after unreg.
I thought binding->dev is needed in the net_devmem_unbind_dmabuf(),
but it's not.
binding->dev is used only for locking, as you mentioned.

> >
> > A proper fix, most likely, will involve resetting binding->dev to NULL
> > when the device is going away.
>
> Right, tho a bit of work and tricky handling will be necessary to get
> that right. We're not holding a ref on binding->dev.
>
> I think we need to invert the socket mutex vs instance lock ordering.
> Make the priv mutex protect the binding->list and binding->dev.
> For that to work the binding needs to also store a pointer to its
> owning socket?
>
> Then in both uninstall paths (from socket and from netdev unreg) we can
> take the socket mutex, delete from list, clear the ->dev pointer,
> unlock, release the ref on the binding.
>
> The socket close path would probably need to lock the socket, look at
> the first entry, if entry has ->dev call netdev_hold(), release the
> socket, lock the netdev, lock the socket again, look at the ->dev, if
> NULL we raced - done. If not NULL release the socket, call unbind.
> netdev_put(). Restart this paragraph.
>
> I can't think of an easier way.

Thank you so much for a detailed guide :)
I tried what you suggested, then I tested cases A, B, and C.
I can't see any splats from lockdep, kasan, etc.
Also, I checked that bindings are released well by checking
/sys/kernel/debug/dma_buf/bufinfo.
I think this approach works well.
However, I tested this simply. So I'm not sure yet about race condition.
I need more tests targeting race condition.

I modified the locking order in the netdev_nl_bind_rx_doit().
And modified netdev_nl_sock_priv_destroy() code looks like:

void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
{
        struct net_devmem_dmabuf_binding *binding;
        struct net_devmem_dmabuf_binding *temp;
        struct net_device *dev;

        mutex_lock(&priv->lock);
        list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
                dev =3D binding->dev;
                if (dev) {
                        netdev_hold(dev, &priv->dev_tracker, GFP_KERNEL);
                        mutex_unlock(&priv->lock);
                        netdev_lock(dev);
                        mutex_lock(&priv->lock);
                        if (binding->dev)
                                net_devmem_unbind_dmabuf(binding);
                        mutex_unlock(&priv->lock);
                        netdev_unlock(dev);
                        netdev_put(dev, &priv->dev_tracker);
                        mutex_lock(&priv->lock);
                }
        }
        mutex_unlock(&priv->lock);
}

Also modified the uninstall code looks like:

static void mp_dmabuf_devmem_uninstall(void *mp_priv,
                                       struct netdev_rx_queue *rxq)
{
        struct net_devmem_dmabuf_binding *binding =3D mp_priv;
        struct netdev_rx_queue *bound_rxq;
        unsigned long xa_idx;

        mutex_lock(&binding->priv->lock);
        xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
                if (bound_rxq =3D=3D rxq) {
                        xa_erase(&binding->bound_rxqs, xa_idx);
                        if (xa_empty(&binding->bound_rxqs)) {
                                list_del(&binding->list);
                                binding->dev =3D NULL;
                                net_devmem_dmabuf_binding_put(binding);
                        }
                        break;
                }
        }
        mutex_unlock(&binding->priv->lock);
}

I think the uninstall code looks good to me, but
netdev_nl_sock_priv_destroy() is longer than I expected.
If this is okay with you, I would like to stabilize it with more tests.

>
> > Replacing rtnl with dev lock exposes the fact that we can't assume
> > that the binding->dev is still valid by the time we do unbind.
>
> Note that binding->dev is never accessed by net_devmem_unbind_dmabuf().
> So if the device was unregistered and its queues flushed, the only thing
> we touch the netdev pointer for is the instance lock :(
>

