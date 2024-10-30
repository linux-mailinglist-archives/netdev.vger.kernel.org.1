Return-Path: <netdev+bounces-140257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536299B5AB6
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 05:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCDE285005
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 04:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA511991D7;
	Wed, 30 Oct 2024 04:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="tqFYDU6R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B91865E0
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 04:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730262675; cv=none; b=TINmTKLAP4Y260tWEw2m2wrzv51h8xyCLDlNzFQvulRc2y8Ta1Fp2GQCw5Hk0aEMZWFRf1/GG42US2F5nK13NkTddr5gD7wGkdJi5AwmexMt2V0zEDTuF96CVd6hpJQV6i1G5r6VMTEdUBYfHm+N0xLnTNmesU2zbdUXeZknoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730262675; c=relaxed/simple;
	bh=J1jzOaDaiBtZVIJ0t3sQB6ULHBIKEAz3/3qoaL+qHo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWsyoz2C/0to8NXm0ty5WWDb7U3on8U332lagdDo4Jac29NH9faCV0pYyLMZY7CIhsCmT/89FdfdZ8HOT+deY9WG39Se3Wpw6pNRrYCwUm0/6zOE3FtXf6RpiBStNxGEflesORq5X0IOI+QD8jDwp9NLDLODi93S9va+NBVlyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=tqFYDU6R; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XFe6aDoitI1PBZsZXYiRGpiaoh0pD4KNAclD1EPvAZc=; t=1730262673; x=1731126673; 
	b=tqFYDU6RnpwpW+w78+mrBUwsjk5allC9cCYT2sUuqNUMwD1yrB7XxHtrMBa7uNiLUk4JNSv4ZL7
	KT/rrIiWl57++nrp5RxBH14Af5WcYSlqjyL9ZsJ968eakhx68I7Ph2drisx4J3bP+s4y1KlZmHGNx
	8d/ZtxxLF4IyE+Q6uytsv0wmkyeyCuoDvz1iXV+e1276fj8id3OHLk3Sxfd0FGI4RGtag2Q2s6Tty
	mL9QGLnKkmZ7lnkEcaAcH+pMpHjGVUIHTsP1Oft4+x1lWd4k3MpUfT2rpqYlkB1owZRBNZEnlb9nY
	VASZIl7YAaWUanDoagmI3rjb1lrLtD26CDxA==;
Received: from mail-oo1-f46.google.com ([209.85.161.46]:61466)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t60MQ-0008P9-Vc
	for netdev@vger.kernel.org; Tue, 29 Oct 2024 21:31:13 -0700
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ebc04d495aso3520896eaf.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 21:31:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YyGzAMSoiXInYAAwE8u7n7rY2EWwRSu06NFBPVGaOv5RbVVA+J1
	FAYpe9yr7o6HxkRS4ZR09UzsMdOo8I4vt8XqZWWo2qyPuc/44xb3epo/WRX40TUvz8HlRkTyw0v
	nELVXJ4BRG2IxoAij2Q+zWLMDjHw=
X-Google-Smtp-Source: AGHT+IHHv+PDUdCBCUsOYW4TNFtfZd/nvqmxEx90pUBDAyQK4bu9Ytjd0aGrwfBGByK18LOWx6M91wPxwTCKzThtHwA=
X-Received: by 2002:a05:6820:160a:b0:5e8:3b4:ac22 with SMTP id
 006d021491bc7-5ec23a2838bmr10032095eaf.4.1730262670358; Tue, 29 Oct 2024
 21:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-10-ouster@cs.stanford.edu>
 <55bc21b1-2f37-4ade-8233-b30a9e0274c7@lunn.ch>
In-Reply-To: <55bc21b1-2f37-4ade-8233-b30a9e0274c7@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 29 Oct 2024 21:30:33 -0700
X-Gmail-Original-Message-ID: <CAGXJAmypjTj1udx4x5i1Y0mxrTeWQJKUuGmR=4qiE-ky3Tc-ow@mail.gmail.com>
Message-ID: <CAGXJAmypjTj1udx4x5i1Y0mxrTeWQJKUuGmR=4qiE-ky3Tc-ow@mail.gmail.com>
Subject: Re: [PATCH net-next 09/12] net: homa: create homa_outgoing.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 127ff6e1eac6b45a32dc112250ed777d

On Tue, Oct 29, 2024 at 5:42=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +/**
> > + * homa_check_nic_queue() - This function is invoked before passing a =
packet
> > + * to the NIC for transmission. It serves two purposes. First, it main=
tains
> > + * an estimate of the NIC queue length. Second, it indicates to the ca=
ller
> > + * whether the NIC queue is so full that no new packets should be queu=
ed
> > + * (Homa's SRPT depends on keeping the NIC queue short).
> > + * @homa:     Overall data about the Homa protocol implementation.
> > + * @skb:      Packet that is about to be transmitted.
> > + * @force:    True means this packet is going to be transmitted
> > + *            regardless of the queue length.
> > + * Return:    Nonzero is returned if either the NIC queue length is
> > + *            acceptably short or @force was specified. 0 means that t=
he
> > + *            NIC queue is at capacity or beyond, so the caller should=
 delay
> > + *            the transmission of @skb. If nonzero is returned, then t=
he
> > + *            queue estimate is updated to reflect the transmission of=
 @skb.
>
> You might want to look into BQL. What you have here i assume only
> takes into account homa traffic. BQL, being in the NIC itself, will
> tell you about all other traffic as well.

Thanks for the pointer; I hadn't heard of BQL before, but I found this
page on it:

https://lwn.net/Articles/469652/

It sounds like this is the same mechanism that includes dynamic queue
limits and the NETDEV_TX_BUSY return value from drivers? If so, I am
familiar with that mechanism, though I hadn't heard the name "BQL".
Unfortunately, it isn't very accurate: it treats data as queued until
skbs are returned from the NIC back to Linux, which can take 100 us or
more. In contrast, homa_check_nic_queue has a time granularity of a
few microseconds (delays of 100 us for short Homa messages would be
cause for concern).

But you are right that this doesn't consider non-Homa traffic, and
that is a problem when Homa runs concurrently with TCP. I am just
starting work on a new qdisc that will replace this mechanism and
incorporate traffic from non-Homa sources as well as Homa.

-John-

