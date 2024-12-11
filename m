Return-Path: <netdev+bounces-151250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB79EDA89
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 23:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED52283AE2
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220841F0E3B;
	Wed, 11 Dec 2024 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="XCrx0dtt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDAC1F2392
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957984; cv=none; b=h10OcWPy+oBCNhcK2lS/QItUoyt9nx0P2I4uqfn/OPPbDFuF3cu4+UX0q9R1H7XcWDnvfrXbhM+LqHSTnpTnU0312P17mwS8WhQAk8jpdEzqJS4ZUw1n3uUj6hsQyx9nd+BFYz4ycR+frBIhfsYqmQr6j1M7tIt6FSO+AhWngWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957984; c=relaxed/simple;
	bh=ghcp3DsYyvlVXHmL7K2gH5gEq0EwllMm6m/f4O6U7tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VONja9gaEE4JEHzFJKs3MeAnRqsMgY4lq4BFOFVjdI4rT/h1zHA07SEfv/Jalox6kUaSfzSWeq/B/4nZni6bC7DWrosFO0TuC1wuGApS1DqgXlvUauKg2ioHlp72R6tHv/AREthDr1igINPoNfsDYVdt93a1TfqNEX0vrGv5KGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=XCrx0dtt; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oGCtYF3lQjdOu3fkPSjIi7qYlg2jkk1TSM5eC6wU6Uc=; t=1733957982; x=1734821982; 
	b=XCrx0dttZ2uFUuSnvtj91ER2Vceo0tqkyxUQHsg//fYRj0ctFbrl0PFU2DJnma0sY+PIkvu2Se9
	K4tnPFs8zyMhZklka39VMuD79kqG6fZ2cCnRHNmBaELl0pEi/eN6gvN77+6wZ7eT9UcyiLZUZSowi
	fdJ/k0DpvwUU/uND6ERxvlf23UwvPnaXKYezJX3ypUOcpri4QeRLdJ+aMBEiHerknc5ucHqWAZeM2
	cjCtoAvmDhut6gbudAqq6OfFsYrEp7vkAedku8djQCo/DIXtgEqTTUIRdBgakZIcb5j0G0hDCj9cv
	rYF8DzjERTrSsovxbY4TnD3k19i3M5/d3zjg==;
Received: from mail-oo1-f49.google.com ([209.85.161.49]:44488)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tLVgD-0008N0-87
	for netdev@vger.kernel.org; Wed, 11 Dec 2024 14:59:41 -0800
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f2e2608681so4554eaf.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 14:59:41 -0800 (PST)
X-Gm-Message-State: AOJu0Yyag9FOAdnHmDv26xP+jMgLeRFapJWwnxGxUyxGo9xlRlMG94rx
	CFMnCVcWyuDx5uo1Lql3E94QpnGUSnj4J153uamgfFe4VHas42nD0uWfqVr1z+D6PkU2n72DHUy
	bAb9Erfn3pjahtSk5tpho8Mjy7YQ=
X-Google-Smtp-Source: AGHT+IE0g3QtKj0qd2+TJDGvXIh38Ua3P1KicJY7Z0xvNvyhfC9tay7HSZo/EauwZxl4OJKt1ZCxodVvxbcGP9ZHlHg=
X-Received: by 2002:a05:6870:c69d:b0:29e:5522:8eea with SMTP id
 586e51a60fabf-2a012e1d7a6mr2302054fac.38.1733957980678; Wed, 11 Dec 2024
 14:59:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209175131.3839-1-ouster@cs.stanford.edu> <20241209175131.3839-13-ouster@cs.stanford.edu>
 <20241210060834.GB83318@j66a10360.sqa.eu95> <CAGXJAmxbv=0Aw61cfOg+mtcrheV7y3db7xYcwTOfjvLYT61P7g@mail.gmail.com>
 <20241211050626.GA128065@j66a10360.sqa.eu95>
In-Reply-To: <20241211050626.GA128065@j66a10360.sqa.eu95>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 11 Dec 2024 14:59:05 -0800
X-Gmail-Original-Message-ID: <CAGXJAmwVyzS34tP5xuK8p_=MM+E06EKuM5NVwd7a84e97i7tsA@mail.gmail.com>
Message-ID: <CAGXJAmwVyzS34tP5xuK8p_=MM+E06EKuM5NVwd7a84e97i7tsA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 11/12] net: homa: create homa_plumbing.c homa_utils.c
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 7e839a9fe5d3c1ffc6f045e071031982

On Tue, Dec 10, 2024 at 9:06=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> > > > +
> > > > +             iph =3D (struct iphdr *)(icmp + sizeof(struct icmphdr=
));
> > > > +             h =3D (struct common_header *)(icmp + sizeof(struct i=
cmphdr)
> > > > +                             + iph->ihl * 4);
> > >
> > > You need to ensure that the comm_header can be accessed linearly. The
> > > icmp_socket_deliver() only guarantees that the full IP header plus 8 =
bytes
> > > can be accessed linearly.
> >
> > This code only accesses the destination port, which is within the
> > first 4 bytes of the common_header (the same position as in a TCP
> > header). Thus I think it's safe without calling pskb_may_pull?
>
> You are right, but there is still a small issue. The standard
> practice is to directly obtain the nested iphdr from skb->data, rather th=
an
> from icmphdr + size.
>
> FYI:
>                 <  skb->head
> ...
> iphdr           <- head + network_header
> icmphdr         <- head + transport_header
> nested-iphdr    <- skb->data
> homahdr         <- skb->data + iph->ihl * 4

Ahah, I wasn't aware of this practice, but it makes total sense; I've
modified the code as you suggested.

> > However, your comment makes me wonder about polling for read on a
> > socket that has been shutdown. If I don't return -ESHUTDOWN from
> > homa_poll in this case, I believe the application could block waiting
> > for reads on a socket that has been shutdown? Of course this will
> > never complete. So, should I check for shutdown and return -ESHUTDOWN
> > immediately in homa_poll, before invoking sock_poll_wait?
>
> Always invoke sock_poll_wait before checking any state, If you got RCV_SH=
UTDOWN,
> you should return at least a mask with POLLIN (not -SHUTDOWN), then
> return 0 (in most cases) in homa_recvmsg(). You can refer to tcp_poll for
> this.

Done.

-John-

