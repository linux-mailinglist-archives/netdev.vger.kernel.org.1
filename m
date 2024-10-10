Return-Path: <netdev+bounces-134360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3027998EAE
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D411C20BA7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A955F19D07B;
	Thu, 10 Oct 2024 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASqowXn6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643519CD19
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582295; cv=none; b=g3Ufa5LnN/jyVKKKnf1rDkc9MKtBjy5fOZBhK6GKd92vm1/6zEJbzBYAasYLL8FeI6ve6IU2Njtdc95oBix+aeKREyoPniwr4iaib8/1U3+4USfVZ2XOxvMdWnfcU6PcGkJY0k42BpQKQ16Zw+20M09EgKElHpzj0hR9TXdxPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582295; c=relaxed/simple;
	bh=G+YlhLMery7c2PQZuybl3kAqhPqj+cOokjVVbYtmDys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqAzXqYd6Pdotmda4uqWB6eCFN6odnrEy3v2DxOKLrchaWVnKThAeQ7Z0E1pvKLP4EBN5cA7OM+AXCmtDCcKXrWhmgvV8yx5j0+DyS05giTmgXQFucy1fnWyy2m0aY2uano7UsgW1YGsS5WZd5QBOssO1WIVuf8trWaC9GwWi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASqowXn6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460395fb1acso28771cf.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728582293; x=1729187093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+YlhLMery7c2PQZuybl3kAqhPqj+cOokjVVbYtmDys=;
        b=ASqowXn6r12SAwlzz3G2qqnr1AW0tYJIanIt7myEDZvm+r7l7JPxfsWvYAI16bcdZW
         p9oMoEP8/bksftUxpUNyVJvJH+cE0yCyC0CToTOYKCfyK5iWcJWcA9Jg4Dovp3DNJF/h
         nNftGF3b7KjFOU2/EJrlRdQEVLjJ3z74anPCJZxWVjegjyZ3GTrSgDT5lo3/0hYhp5ro
         3LcSm75XRCDEzKb3DccfyN0WB8J0Bj3d7vpQfNbXapxwIcHbTQ45W0bxIdFRfL5Rd0hC
         +LRaB4GPa475RlPDT/lWdUM5tV6fM9UcarvwJl6pfRnkrIu4wElAXQu0zzFyS0gUGg7S
         f0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582293; x=1729187093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+YlhLMery7c2PQZuybl3kAqhPqj+cOokjVVbYtmDys=;
        b=Sk1MC1UrNZ/jpa5xeRV3g308esnresaaCLnYsPfYpiR0+gYeZRLwlJp9/BHLtOWPGt
         E1MN2IRceSlKjyROQ8gUAT0Zm1NqGA7FwdFvln9T+3icV5A7TCwaR7qrbGnmvwKtfLqA
         +KUw1I7Tzk012wi8/kCMwa1Mxru/1aKSEfd8i/UcABuR8f3n4j+f+U4Ukq4YBDJf3O6s
         CUFGeVK9kymFdQW4V9uWXxcw2saP1Gswk+fR8sXcmvoUAaJArA9jwJndn5nkblTGI1pg
         LUNBIc5rZYOxaWQJVYLG2UpJEzzQCS7p+gAQ1aQ37Z2KfObfhRNyrpguDn2wRrKPTuYR
         LnFg==
X-Forwarded-Encrypted: i=1; AJvYcCXSsxM7/n5wboJmXx7ipn4WbsIQETIXH9yAvmsUlwX5aVcnJ/PC0t66lqZmHW+NmCwzDiIcwLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxouWYEZ/FiFpViJ4wpkmz7LNm9e7OiAHspQBJ4waBwAhrG8ds+
	x4qWcgw99D6T9SvdMtxzzJ1W10sSKxyLHvSBo27/QEDX/tS5kX26niACsOPR7vr47Y0hlhgvP6R
	DdQvGn+meqsRebQ3NnmRIoyAmBDtCTMA3aozx
X-Google-Smtp-Source: AGHT+IHBhsaTPf8MZyXqXn+ky4tZtEVMbF5vDoqwo8wznqVtpsAMJ1C0i52LynbA8eDXzYQiG2Dtr0LY6Sw5vk7+MPY=
X-Received: by 2002:a05:622a:a38b:b0:460:481a:d537 with SMTP id
 d75a77b69052e-460481ad644mr1794981cf.25.1728582292604; Thu, 10 Oct 2024
 10:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-8-ap420073@gmail.com>
 <CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
 <CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com>
 <20241008125023.7fbc1f64@kernel.org> <CAMArcTWVrQ7KWPt+c0u7X=jvBd2VZGVLwjWYCjMYhWZTymMRTg@mail.gmail.com>
 <20241009170102.1980ed1d@kernel.org>
In-Reply-To: <20241009170102.1980ed1d@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Oct 2024 10:44:38 -0700
Message-ID: <CAHS8izMwd__+RkW-Nj3r3uG4gmocJa6QEqeHChzNXux1cbSS=w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory tcp
To: Jakub Kicinski <kuba@kernel.org>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 10 Oct 2024 00:37:49 +0900 Taehee Yoo wrote:
> > > Yes, but netmem_ref can be either a net_iov or a normal page,
> > > and skb_add_rx_frag_netmem() and similar helpers should automatically
> > > set skb->unreadable or not.
> > >
> > > IOW you should be able to always use netmem-aware APIs, no?
> >
> > I'm not sure the update skb->unreadable flag is possible because
> > frag API like skb_add_rx_frag_netmem(), receives only frag, not skb.
> > How about an additional API to update skb->unreadable flag?
> > skb_update_unreadable() or skb_update_netmem()?
>
> Ah, the case where we don't get skb is because we're just building XDP
> frame at that stage. And XDP can't be netmem.
>
> In that case switching to skb_frag_fill_netmem_desc() should be enough.
>
> > > > The reason why the branch exists here is the PP_FLAG_ALLOW_UNREADAB=
LE_NETMEM
> > > > flag can't be used with PP_FLAG_DMA_SYNC_DEV.
> > >
> > > Hm. Isn't the existing check the wrong way around? Is the driver
> > > supposed to sync the buffers for device before passing them down?
> >
> > I haven't thought the failure of PP_FLAG_DMA_SYNC_DEV
> > for dmabuf may be wrong.
> > I think device memory TCP is not related to this flag.
> > So device memory TCP core API should not return failure when
> > PP_FLAG_DMA_SYNC_DEV flag is set.
> > How about removing this condition check code in device memory TCP core?
>
> I think we need to invert the check..
> Mina, WDYT?
>

On a closer look, my feeling is similar to Taehee,
PP_FLAG_DMA_SYNC_DEV should be orthogonal to memory providers. The
memory providers allocate the memory and provide the dma-addr, but
need not dma-sync the dma-addr, right? The driver can sync the
dma-addr if it wants and the driver can delegate the syncing to the pp
via PP_FLAG_DMA_SYNC_DEV if it wants. AFAICT I think the check should
be removed, not inverted, but I could be missing something.

--=20
Thanks,
Mina

