Return-Path: <netdev+bounces-130042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A26987C97
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 03:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7E1B2183E
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 01:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3B0D53C;
	Fri, 27 Sep 2024 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQe9wLsA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291534CDD
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727400832; cv=none; b=Ii4JmUMmqnsiyPXKox2zQuH5G6rkkQL9OxypE1YAsWKEDEPZv0S17cnp8d6WEEwiGTsWXiEAbibftZM+MorXzftwMClc/L/xA4TRBsfOlw7gf4erFX+LUA6HpHXOfdw61AQ2IUUtMYIKd4mFCP8K1u/C8NFXiuG9BUFis/6qAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727400832; c=relaxed/simple;
	bh=1eNBDY6OGKuSmxUZaUou4Lc4OOHRP8zXLkjGUFsI+lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/2tQPzYmCDEdfTBQNTVtrV0zD3W5Em63CiqwdudTFH9MkrdEW2bfm+o9gPNxUIf7Tg1V0MWe0bPPO1Pqtmy1y1dV55pymsQt1iB1myExgFMZ7gSdOvjwrhRTHADZBvQaDHLpmpEOZGLnrpfrVnZsXo3Kd7inBFR6O2btEH74q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQe9wLsA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-206f9b872b2so14926245ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 18:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727400830; x=1728005630; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xN77D3WeBb8lwn/putJSFUXEJpA56+/Vtw6brC/xs94=;
        b=kQe9wLsA8nFQgdHrH8hO/aESquwl64vvlLp5s1jdLUzkXmyYlBCjKW8G/unqjdC6HM
         4t2idI1G9YNtj44CytJZf7kBfR+vlqXCqxcwTj+M6b2R3Tf/VUfJhjjYySGRLzL7gPSY
         NzV0U5M+Q/oa0LX9TNVPxgjWHKK3k2n09VvCJZDXZ307vf6Kfr5PwVtyNAocSmwGyp2u
         jFEcJsA46R5LgnR9RoQyCewBkNbKoGpMh3SHfuOE8WQ1X3GUqqJusD7gTFFe2KF3Rto8
         D2F/WtIGgoysIkLMzvQo5ekBbvuBmp6EVFEh66DehCzB3BRXWqKryNIBjjpX1FuayFTK
         2P6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727400830; x=1728005630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xN77D3WeBb8lwn/putJSFUXEJpA56+/Vtw6brC/xs94=;
        b=qb7RV9AXaSGEcltzPDk44Qeq7k1UBuzxxjuJkFuvpN8h34Vs5Erdxy3BjJtyl3iScW
         5MdVqlhRoXsK8cZM7mIuv40vkj8hA/+wrVh7lK6lpMPQZkFjlR3StI17K8GKiTpzJ1LG
         TXrAcuHT5o+O480LYpLvjRd4sXkk1+k4HoS4++cdHGlcQ4ffD19kpdfl0YNKxjsYwGOL
         UNHJhmWE+VaryOE37c6SPHl9yjBAvNJ88LXsL/QBxjYBxQ+CN8cfhCDnEgToZub91XH0
         OYroYm8rzcZnbDxNSca8RmsEwwuM9nfyy0iNLovlxhUzUXK46o77guxnA9GlKL69MOU6
         WOgg==
X-Forwarded-Encrypted: i=1; AJvYcCUufaFVLwm0FfqWkRxSKepPf/YLjwh6wOl8j5C0hGWnwY2LggdZ7PDtChComAapkRO8CKW8Dzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqIbHExFtzPyEEQ6pH+jqdkiPX55d3+WbMY2L+KkFOoXis4yN
	IMAulczQH3nL4CFHz9sdS7+Qxzsmxu95CeqF48X6OZiUKsDJZXo=
X-Google-Smtp-Source: AGHT+IF+H/5xkio/ix3flWEguZpDI8NgqwbZg8JpBP0cUF3I9rvPqm9bgfSzZXhX01idigdo8C4QSg==
X-Received: by 2002:a17:902:d50a:b0:206:ca91:1dda with SMTP id d9443c01a7336-20b367d994cmr27357495ad.17.1727400829907;
        Thu, 26 Sep 2024 18:33:49 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d89508sm4242445ad.64.2024.09.26.18.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 18:33:49 -0700 (PDT)
Date: Thu, 26 Sep 2024 18:33:48 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [RFC PATCH net-next v1 1/4] net: devmem: Implement TX path
Message-ID: <ZvYLfLKpdZj58YKo@mini-arch>
References: <20240913150913.1280238-1-sdf@fomichev.me>
 <20240913150913.1280238-2-sdf@fomichev.me>
 <CAHS8izPKX3rhUytviDa-=Do=jt_gLzE+7H5_0jp+N-6hjHC8dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPKX3rhUytviDa-=Do=jt_gLzE+7H5_0jp+N-6hjHC8dQ@mail.gmail.com>

On 09/26, Mina Almasry wrote:
> On Fri, Sep 13, 2024 at 8:09 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Preliminary implementation of the TX path. The API is as follows:
> >
> > 1. bind-tx netlink call to attach dmabuf for TX; queue is not
> >    required, only netdev for dmabuf attachment
> > 2. a set of iovs where iov_base is the offset in the dmabuf and iov_len
> >    is the size of the chunk to send; multiple iovs are supported
> > 3. SCM_DEVMEM_DMABUF cmsg with the dmabuf id from bind-tx
> > 4. MSG_SOCK_DEVMEM sendmsg flag to mirror receive path
> >
> > In sendmsg, lookup binding by id and refcnt it for every frag in the
> > skb. None of the drivers are implemented, but skb_frag_dma_unmap
> > should return proper DMA address. Extra care (TODO) must be taken in the
> > drivers to not dma_unmap those mappings on completions.
> >
> > The changes in the kernel/dma/mapping.c are only required to make
> > devmem work with virtual networking devices (and they expose 1:1
> > identity mapping) and to enable 'loopback' mode. Loopback mode
> > lets us test TCP and UAPI paths without having real HW. Not sure
> > whether it should be a part of a real upstream submission, but it
> > was useful during the development.
> >
> > TODO:
> > - skb_page_unref and __skb_frag_ref seem out of place; unref paths
> >   in general need more care
> > - potentially something better than tx_iter/tx_vec with its
> >   O(len/PAGE_SIZE) lookups
> > - move xa_alloc_cyclic to the end
> > - potentially better separate bind-rx and bind-tx;
> >   direction == DMA_TO_DEVICE feels hacky
> > - rename skb_add_rx_frag_netmem to skb_add_frag_netmem
> >
> 
> Thank you very much for this, and sorry for the late reply. I think I
> got busy with some post RX merge follow ups and then other stuff.
> Coming back to look at this now.

Sure and thanks for pushing it further!

> This looks like a great start. Agreed with many of the todos above,
> and in addition some things I wanna look deeper into (but not
> necessarily set on changing yet):

[..]
 
> Loopback: I do plan to drop that. My understanding is that it's a bit
> complicated to make work. In addition to the mapping.c changes, the TX
> zerocopy code falls back to copying for loopback for reasons I don't
> have my head wrapped around. devmem can't be copied. You get around
> that with a change in skb_copy_ubufs but I'm not sure we can assume
> success there. In any case I don't have a use case for loop back and
> it can be mode to work properly later.

Up to you. It was useful during working on on the syscall side, but
I understand that it's an unnecessary complication.

> control path locking: You added net_devmem_dmabuf_lock, but AFAICT
> dma-buf allocation should be already mutexed by rtnl_lock. Maybe I
> missed something. I'll take a deeper look.

Yeah, agreed, I think it was a leftover from my some other non-rcu
attempt.

> fast path locking: you use rcu, which is a good way to do it. I had
> something else in mind, where we associate the binding with a socket
> and keep it alive for the duration of the socket and (I think) no need
> to lock anymore. Not sure which is better. Associating the binding
> with a socket does require uapi. But it may be good to keep the
> binding alive while the socket is using it anyway, rather than the
> sendmsg returning -EINVAL if the binding has been freed underneath it.
> I'll take a deeper look.

That should work as well as long as we can bind multiple sockets.
Maybe that's even better because it avoids xa_load on every sendmsg,
so go for it.

> get_page/put_page: I was thinking we need to implement
> get_netmem/put_netmem equivalents as the tx path uses
> get_page/put_page and page_pool refcounting is not used there. You
> seem to instead ref/unref the binding. That may be fine, but we may
> need get_page/put_page equivalents for netmem eventually and may be
> worth getting them done now. I need to rack my brain a bit more.

That should work as well, I haven't spent a ton of time polishing that
part. Note that in my tests, I saw half throughput with this API+udmabuf
vs regular MSG_ZEROCOPY. So it's either my sloppy locking, xa_load
or iovec parsing. Or something else, idk :-)

