Return-Path: <netdev+bounces-133786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0793997058
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85147282C45
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5E61D271C;
	Wed,  9 Oct 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi/jgqcN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516E19DF66;
	Wed,  9 Oct 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488285; cv=none; b=CPXNuy1vuCUUF4xxXmpje8ATFgTRYLz2g//dFx37Xgezr5qQQbzUjzeogiwUguHt/4P6bBBpvIYk1q2Ax+WsyxyGgnimH6BSVu+dvEq9LipVVpTKha+sketcpgfBPAUVhef1B3f2mOfo59O5DEAy3HlqjwevFF7ivH6NZM0NPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488285; c=relaxed/simple;
	bh=NHnaAvn93H+xdWtc1eIfwQdjHyE3NdRCkm+SLUAIP3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8M08w2LgIhL4lTBhK6EwCxF4yGgGsn8OXrcL2Fkn98ivRT7tbNMXPCvMnaSMfO54PH1E/7HMQDCy0rZf9WdevfJXqU+BI6gJDWPuvLfN5RE1LBhb26cm+7iheN0BLKz9S5wT58NfNhxtqx7cFP2kYaneuwnFJ3QqFfM2RZj4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi/jgqcN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e9fdad5af8so2812876a12.3;
        Wed, 09 Oct 2024 08:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488283; x=1729093083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHnaAvn93H+xdWtc1eIfwQdjHyE3NdRCkm+SLUAIP3c=;
        b=Qi/jgqcNRU4ocS+G2QGixALjbANtBxHkBUsdM5UublFT9EHSZZwf2BfeomJ7UhZrWH
         Kt1Jvi2rD7iEGC7OFarRlns+WKt6dENaTaU4u0jNVsqwXocAvzQlTMTSM/pOsUYW2tk0
         T5FmvYAZZyVDOTiHIzoYEc3Ob0+OwDLEtGEZf7asp3lFYv/RqjHXcQRGq7Nz9JbV0k9x
         GcX99ZSs81kXr05LMBg6W6PARcG/LnKxn/DusXYALi0v5ntbGXVWad4xM3VCPw5Z3kAB
         lX3I/tcYc5jnQ1u10bQxPezCpEjSS9ZwiD9cFdpVQW+zMUVpjOQYmTXelumNxbWwn3ai
         Mj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488283; x=1729093083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHnaAvn93H+xdWtc1eIfwQdjHyE3NdRCkm+SLUAIP3c=;
        b=NWAJOqyxGvde9hEWGmjl5OSvRkBB44FzyctlDvRaun+KzvK8jbeaB6mqMRYTLy2yDr
         qbEb35sRQSS65GFVI7lnhpijZN/VglgL5WyCP4V3y9GZ5Dz6YLK2Kzw5fJcCM5yQVIac
         R1s1/u3V2WIwYBv7ixA08G6JsWTC0JbR99k/DLiYK13F7RNwvO5b6AP31vBSWSmKKNfS
         txggX70tmUSSPceZkLjEQsYGlwXA0SQdnSk9NRjURQ5VlQVqKjXkWSI8NQmaaI319KI0
         xy1XTCpDj48DRmqZa2ICCfU24YsUMiHGFN0XI+9UjFnMfaic8tGfipl6SjOr+LPdluZw
         671A==
X-Forwarded-Encrypted: i=1; AJvYcCWCTZeG9KecAxrvzym4mfXma7NCKAeDUBDQm1XZSERv/RHZad14i9KVrDTLMwzWEqaSRY1+X2Px@vger.kernel.org, AJvYcCXf+rFdXqZBovpdbCufmnE8xZ/fH20pVDynprYGEQatuNSdNQY2AzyUlc10g+6eNSmHSmesGc2KoaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY28eWJqjdln5s56ff9e1ifrcabFLJqZ52LCwqm1DhLV8OAh90
	MwKdQc8pKGkw43Eh7gg6ghAIdFJlHbJMs/bNhzXGlre1G3NwHxziMDU596c9vxBvp55KV8iglgF
	b0OI3P8p7ITqEZQh1M8R4unleyuk=
X-Google-Smtp-Source: AGHT+IHvMnSXgZRDFgXDb46A9k1hmtC48lXdRz9TULccZUtpS0/UB9bx44l2tVC+w1wevMlm/x/XISw8vH2/AwICHZs=
X-Received: by 2002:a17:90a:c7ce:b0:2e0:8e36:132 with SMTP id
 98e67ed59e1d1-2e2a21ef11fmr3724307a91.3.1728488283169; Wed, 09 Oct 2024
 08:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-8-ap420073@gmail.com>
 <CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
 <CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com> <20241008125023.7fbc1f64@kernel.org>
In-Reply-To: <20241008125023.7fbc1f64@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 10 Oct 2024 00:37:49 +0900
Message-ID: <CAMArcTWVrQ7KWPt+c0u7X=jvBd2VZGVLwjWYCjMYhWZTymMRTg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory tcp
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, pabeni@redhat.com, 
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

On Wed, Oct 9, 2024 at 4:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 4 Oct 2024 19:34:45 +0900 Taehee Yoo wrote:
> > > Our intention with the whole netmem design is that drivers should
> > > never have to call netmem_to_page(). I.e. the driver should use netme=
m
> > > unaware of whether it's page or non-page underneath, to minimize
> > > complexity driver needs to handle.
> > >
> > > This netmem_to_page() call can be removed by using
> > > skb_frag_fill_netmem_desc() instead of the page variant. But, more
> > > improtantly, why did the code change here? The code before calls
> > > skb_frag_fill_page_desc, but the new code sometimes will
> > > skb_frag_fill_netmem_desc() and sometimes will skb_add_rx_frag_netmem=
.
> > > I'm not sure why that logic changed.
> >
> > The reason why skb_add_rx_frag_netmem() is used here is to set
> > skb->unreadable flag. the skb_frag_fill_netmem_desc() doesn't set
> > skb->unreadable because it doesn't handle skb, it only handles frag.
> > As far as I know, skb->unreadable should be set to true for devmem
> > TCP, am I misunderstood?
> > I tested that don't using skb_add_rx_frag_netmem() here, and it
> > immediately fails.
>
> Yes, but netmem_ref can be either a net_iov or a normal page,
> and skb_add_rx_frag_netmem() and similar helpers should automatically
> set skb->unreadable or not.
>
> IOW you should be able to always use netmem-aware APIs, no?

I'm not sure the update skb->unreadable flag is possible because
frag API like skb_add_rx_frag_netmem(), receives only frag, not skb.
How about an additional API to update skb->unreadable flag?
skb_update_unreadable() or skb_update_netmem()?

>
> > > This is not the intended use of PP_FLAG_ALLOW_UNREADABLE_NETMEM.
> > >
> > > The driver should set PP_FLAG_ALLOW_UNREADABLE_NETMEM when it's able
> > > to handle unreadable netmem, it should not worry about whether
> > > rxq->mp_params.mp_priv is set or not.
> > >
> > > You should set PP_FLAG_ALLOW_UNREADABLE_NETMEM when HDS is enabled.
> > > Let core figure out if mp_params.mp_priv is enabled. All the driver
> > > needs to report is whether it's configured to be able to handle
> > > unreadable netmem (which practically means HDS is enabled).
> >
> > The reason why the branch exists here is the PP_FLAG_ALLOW_UNREADABLE_N=
ETMEM
> > flag can't be used with PP_FLAG_DMA_SYNC_DEV.
>
> Hm. Isn't the existing check the wrong way around? Is the driver
> supposed to sync the buffers for device before passing them down?

I haven't thought the failure of PP_FLAG_DMA_SYNC_DEV
for dmabuf may be wrong.
I think device memory TCP is not related to this flag.
So device memory TCP core API should not return failure when
PP_FLAG_DMA_SYNC_DEV flag is set.
How about removing this condition check code in device memory TCP core?

