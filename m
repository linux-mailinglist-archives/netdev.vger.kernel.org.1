Return-Path: <netdev+bounces-124743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5171996AABF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 23:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756D21C22ECD
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555D1CF7DD;
	Tue,  3 Sep 2024 21:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2DqgCFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9F1C9DC4
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400709; cv=none; b=IWhr9X702fD2p+8uVzyWuSu4bE+xsGq82Hupl6njL4Nm9bg9XBM3jxswT4VvEFr1hZuDbntLQ+V1pm5KLkOjuDvWwSB/WdXq+GbSpXTqW2a0QN/jIC+yTC10+YHIKroAMfU3Qfqnm6gjSoq7sTxZxNp1BzFtH2j5zxL4OkNPqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400709; c=relaxed/simple;
	bh=4iA1AmHB0W7zOfySiVU9ftZEgYALwbM1FzL5qsZdFk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzMBpfk9XZl1vj0C6NxNhRcXoBcDPttCbzos2ce1MeD4zggvVvdBn5Nxlphs+oSy6tmfOkDBTamelmByHVk4QZ0KwZZTGxdBtRCsn7109hm4uT1AndwvRc4hd7/+ZBwYNzlqr7pjE9u4kjrIWo3aMGJLFBplfUZkkVPWOtZv7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m2DqgCFA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-429d1a9363aso8235e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725400706; x=1726005506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2Br/9enDLn+2E7PseEJHUhdsPjvr9uaRQ0xymOYTOw=;
        b=m2DqgCFAhxwwg61jkBUgulvviyUG/npBOOHFl1ECwgWyDBWygG2N/B/Xj/czjc4Lwj
         iJcLg+xzHd9XKDcUwV1+OgHAtymUlHiqrc8M2K3DCBZV8y39Mh8E1gKrVm3qK2aC6NMJ
         nNDGNOBcLO2hfwWLb02knGb5HXi4R4DDkuRwGrHKBe3J60o1FAFqY0d1wDLrwlJdP3GM
         t9Sc0wKQ4/d/MipTagjFmfcCX7q0vxchP3iVYNoIZz2w+jBO5w+LK3DZ6yzbUzEo/BTH
         ykSsNOCTjZjuy+uueuSOQUFrUTB+QY7xIznPVew4O7husZfTpclJ4BF66w8Ursl2HTG2
         0I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725400706; x=1726005506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2Br/9enDLn+2E7PseEJHUhdsPjvr9uaRQ0xymOYTOw=;
        b=uUJx2zyJfmsukBvPrII5Qpy9YiP6Il0kndBXaBk7bPC+qddr1k3OP5tPkTSMsuJBYz
         2I5JkT4zjXW9YDowuUAUqvUsBQovbTyG9msdZatKRVXckRedW9rMrhzPFGO9WwBeuknx
         Tbr/pBO+IjN8gs7uEUnCFCY/rrBnFa2ScSY8EdesIl1itcO8HcZxxH12jdgBr32UXGsU
         LlIz3Dhz0jrN8vtcRn048suR5jgHzLsYmgnfgQBf8N86BMk4vkMS7Oyu2/JCf2mTFK6q
         sRfgehWtZz56K9z5+sYRU/oFxOO//5idhup8NAYBFlC9BXvcOmYU8pQz+3go22u3LKP2
         HayA==
X-Forwarded-Encrypted: i=1; AJvYcCUFkJUKPjLxLMBDIDJwIrYN8A4YETm2Q18SJVdi/t9Kmg33XpfBdKb++al/aGfvov3Dg0iA1/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YztwOJUNRGq55km0T84YHY/N9ftIQuc6hwU1aOZmgyC+iVXcGfZ
	98/rzwEviFut73iSahGWps8DGpOyWr3QgfBenGU8Vtk9OexbSBdKBZ33YZJ38gRbOjfIQd24fXh
	ELUDgMuik3Qi02n/lYym8B6qFjAZyYTbr/ssn
X-Google-Smtp-Source: AGHT+IH95j/71dsiuJGgL0CB7827mirEiuevB5e4uUOdo83AQOJv3RtrY2aNvhGhGeln/fywrlniUATmKIn0YOyXjvw=
X-Received: by 2002:a05:600c:1e87:b0:426:5ef2:cd97 with SMTP id
 5b1f17b1804b1-42c9473d8a9mr473345e9.2.1725400705889; Tue, 03 Sep 2024
 14:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829131214.169977-1-jdamato@fastly.com> <20240829131214.169977-6-jdamato@fastly.com>
 <20240829153105.6b813c98@kernel.org> <ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
 <20240830142235.352dbad5@kernel.org> <ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
 <20240902180220.312518bc@kernel.org> <CAAywjhTG+2BmoN76kaEmWC=J0BBvnCc7fUhAwjbSX5xzSvtGXw@mail.gmail.com>
 <20240903124008.4793c087@kernel.org>
In-Reply-To: <20240903124008.4793c087@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 3 Sep 2024 14:58:14 -0700
Message-ID: <CAAywjhSSOfO4ivgj+oZVPn0HuWoqdZ0sr6dK10GRq_zuG16q0Q@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI config values
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, edumazet@google.com, 
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com, sdf@fomichev.me, 
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org, 
	willemdebruijn.kernel@gmail.com, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 12:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 3 Sep 2024 12:04:52 -0700 Samiullah Khawaja wrote:
> > Do we need a queue to napi association to set/persist napi
> > configurations?
>
> I'm afraid zero-copy schemes will make multiple queues per NAPI more
> and more common, so pretending the NAPI params (related to polling)
> are pre queue will soon become highly problematic.
Agreed.
>
> > Can a new index param be added to the netif_napi_add
> > and persist the configurations in napi_storage.
>
> That'd be my (weak) preference.
>
> > I guess the problem would be the size of napi_storage.
>
> I don't think so, we're talking about 16B per NAPI,
> struct netdev_queue is 320B, struct netdev_rx_queue is 192B.
> NAPI storage is rounding error next to those :S
Oh, I am sorry I was actually referring to the problem of figuring out
the count of the napi_storage array.
>
> > Also wondering if for some use case persistence would be problematic
> > when the napis are recreated, since the new napi instances might not
> > represent the same context? For example If I resize the dev from 16
> > rx/tx to 8 rx/tx queues and the napi index that was used by TX queue,
> > now polls RX queue.
>
> We can clear the config when NAPI is activated (ethtool -L /
> set-channels). That seems like a good idea.
That sounds good.
>
> The distinction between Rx and Tx NAPIs is a bit more tricky, tho.
> When^w If we can dynamically create Rx queues one day, a NAPI may
> start out as a Tx NAPI and become a combined one when Rx queue is
> added to it.
>
> Maybe it's enough to document how rings are distributed to NAPIs?
>
> First set of NAPIs should get allocated to the combined channels,
> then for remaining rx- and tx-only NAPIs they should be interleaved
> starting with rx?
>
> Example, asymmetric config: combined + some extra tx:
>
>     combined        tx
>  [0..#combined-1] [#combined..#combined+#tx-1]
>
> Split rx / tx - interleave:
>
>  [0 rx0] [1 tx0] [2 rx1] [3 tx1] [4 rx2] [5 tx2] ...
>
> This would limit the churn when changing channel counts.
I think this is good. The queue-get dump netlink does provide details
of all the queues in a dev. It also provides a napi-id if the driver
has set it (only few drivers set this). So basically a busy poll
application would look at the queue type and apply configurations on
the relevant napi based on the documentation above (if napi-id is not
set on the queue)?

