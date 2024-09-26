Return-Path: <netdev+bounces-130032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE5987A30
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 22:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5CB1F24A27
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 20:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530B157A41;
	Thu, 26 Sep 2024 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1AwveRy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D3145B10
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727383874; cv=none; b=YiXWa3mMuWPnVmVa2OoknNWDY1RNG2lcu7oJKvmTZXae2FvwKjNGXhwt61ncvp5SKSwhKKKMAb3c5Bp/VPJhqixVpDUECqaxfMKbHUFZznS83wX05EtAnV3oojR+m+RQOHiZtXy85smhyRmeEqUQcaYxN3tKGwQEaOqYZsQPxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727383874; c=relaxed/simple;
	bh=h634e7k11VcaV//XuTI96r3W2tvFp+S8blfQwAx+qgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TI2fL4BtXThfwzujxPwT6vVXKzDLe2A+fzQ58TPCsnY6QdmaYU65IDb04UhaeP6MpygOW6O5g13dit0XSdKdvKymvgk/sP42hXF2A1BMSfPYnZNBSWnbPQRFa8l4p4fDYPFA/q4R/Y8VoCDNnhVNK/voyNAwDOxwihLSIFu06FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1AwveRy; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-45b4e638a9aso24601cf.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727383872; x=1727988672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBGSIqE+GazgdOu7+SynVzMTdfIyESylZAen1Aeht9c=;
        b=u1AwveRyQgpaM/9r3Id4w2xiosvZfchdYhd5HXgS7zpjLY2LTgP8jM1sP2BACeHaQd
         S1RN/oRsBJ0MK/285fDHkym3+n+YYw48K6XWt0cBlppfRGgjV7ZlswTySXmJVyuPXBU/
         KnP8T3BjFPFEG6YmDsyrQ12oFZFo1jBL+4Ld8W8hU+5ktV3LKYMrH6eNw0eXldfA95oi
         rXbpQMD+QYJEwicNhq684rvsxHhnqtaPYWHWoOfeaWlD/5c1k+qnaMWYHKaNpgo2Z9so
         A+RRlypr7FcHxHaoO9/AbIc9fURqHhgsBJG756aMSKMc1+dChcqRx+VYny0pgSMEB0M+
         djTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727383872; x=1727988672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBGSIqE+GazgdOu7+SynVzMTdfIyESylZAen1Aeht9c=;
        b=YyFomok4FWu+7dfpMG0ipjZoqVCSmCQUZsyuAAAZ3WqRd1SCEkEWejiFNUvl2gt37o
         Orr41PHXxYzcp2BPAk1uAMU1HHXdD7alJ8n/vnIpZ3Rq5A7WZ+3KjpiuXxwnN2s6SVhX
         5QZWR+p1IfEaJRsz+U5ifjnMAqjU21v1Z5Pg2RWcO0thdBD9XU6bGeksxlBFrgAIou94
         6Ur3NWkUYMi0hnUOVIiy5p4IFlWDRSjcgKGkAsNXyjRWmRChyhBLSaKYQvHzOkUHndfc
         W2GDEyL3g4gPJ+P0mUAaR8VZu7y5gBh48HLH4HMaP60TeL3GEpG+XJtLbltMEZV+lvax
         xFLg==
X-Gm-Message-State: AOJu0YzSSkWY9EfoOgip24D96gvau5KG+nncGR5NfvKZa/Cat8oW3iKL
	ySzAcH0N0sKNO8sZQMjLWmXpwR6NlV3Qni83VzyKTuSY3MOoUFXdxrJ1pLrPYiZJZ8b507pTdSD
	32+zfTRSKUEMISuUAyDaVP+wWJo/Z6eM/g47lKUxxWeHTzllBKM2z
X-Google-Smtp-Source: AGHT+IEUDRL8IH28Mt/ZyWNhoG09w6Wg+VmVQBIab9mydu6i8qOwX2Pr3GUxlKx0M1T8LkorSuqxRrYAh+k4VPCMH/M=
X-Received: by 2002:a05:622a:500f:b0:45b:5cdf:9090 with SMTP id
 d75a77b69052e-45ca1aeb09fmr98661cf.17.1727383871186; Thu, 26 Sep 2024
 13:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913150913.1280238-1-sdf@fomichev.me> <20240913150913.1280238-2-sdf@fomichev.me>
In-Reply-To: <20240913150913.1280238-2-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 26 Sep 2024 13:50:57 -0700
Message-ID: <CAHS8izPKX3rhUytviDa-=Do=jt_gLzE+7H5_0jp+N-6hjHC8dQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 1/4] net: devmem: Implement TX path
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 8:09=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Preliminary implementation of the TX path. The API is as follows:
>
> 1. bind-tx netlink call to attach dmabuf for TX; queue is not
>    required, only netdev for dmabuf attachment
> 2. a set of iovs where iov_base is the offset in the dmabuf and iov_len
>    is the size of the chunk to send; multiple iovs are supported
> 3. SCM_DEVMEM_DMABUF cmsg with the dmabuf id from bind-tx
> 4. MSG_SOCK_DEVMEM sendmsg flag to mirror receive path
>
> In sendmsg, lookup binding by id and refcnt it for every frag in the
> skb. None of the drivers are implemented, but skb_frag_dma_unmap
> should return proper DMA address. Extra care (TODO) must be taken in the
> drivers to not dma_unmap those mappings on completions.
>
> The changes in the kernel/dma/mapping.c are only required to make
> devmem work with virtual networking devices (and they expose 1:1
> identity mapping) and to enable 'loopback' mode. Loopback mode
> lets us test TCP and UAPI paths without having real HW. Not sure
> whether it should be a part of a real upstream submission, but it
> was useful during the development.
>
> TODO:
> - skb_page_unref and __skb_frag_ref seem out of place; unref paths
>   in general need more care
> - potentially something better than tx_iter/tx_vec with its
>   O(len/PAGE_SIZE) lookups
> - move xa_alloc_cyclic to the end
> - potentially better separate bind-rx and bind-tx;
>   direction =3D=3D DMA_TO_DEVICE feels hacky
> - rename skb_add_rx_frag_netmem to skb_add_frag_netmem
>

Thank you very much for this, and sorry for the late reply. I think I
got busy with some post RX merge follow ups and then other stuff.
Coming back to look at this now.

This looks like a great start. Agreed with many of the todos above,
and in addition some things I wanna look deeper into (but not
necessarily set on changing yet):

Loopback: I do plan to drop that. My understanding is that it's a bit
complicated to make work. In addition to the mapping.c changes, the TX
zerocopy code falls back to copying for loopback for reasons I don't
have my head wrapped around. devmem can't be copied. You get around
that with a change in skb_copy_ubufs but I'm not sure we can assume
success there. In any case I don't have a use case for loop back and
it can be mode to work properly later.

control path locking: You added net_devmem_dmabuf_lock, but AFAICT
dma-buf allocation should be already mutexed by rtnl_lock. Maybe I
missed something. I'll take a deeper look.

fast path locking: you use rcu, which is a good way to do it. I had
something else in mind, where we associate the binding with a socket
and keep it alive for the duration of the socket and (I think) no need
to lock anymore. Not sure which is better. Associating the binding
with a socket does require uapi. But it may be good to keep the
binding alive while the socket is using it anyway, rather than the
sendmsg returning -EINVAL if the binding has been freed underneath it.
I'll take a deeper look.

get_page/put_page: I was thinking we need to implement
get_netmem/put_netmem equivalents as the tx path uses
get_page/put_page and page_pool refcounting is not used there. You
seem to instead ref/unref the binding. That may be fine, but we may
need get_page/put_page equivalents for netmem eventually and may be
worth getting them done now. I need to rack my brain a bit more.

