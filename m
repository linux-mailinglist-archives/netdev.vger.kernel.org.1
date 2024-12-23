Return-Path: <netdev+bounces-154077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386689FB38D
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C591636C6
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 17:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418A1B6CEF;
	Mon, 23 Dec 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="BXhZKUh9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330E1B4120
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734974310; cv=none; b=eyCiEF6m5EiGFSIrQ6a/Bt4W8pwuTvgT0RDiuE/OcwWc5eRcNkPq4NJkWIMCemNbpoiamo5/R8UTAOhFcXNQpjMCgeqkWL3VIgZUtRRYGjwwXgxT7dIOpH8YnYo3QN3SHOdUIZe/vTiyFN7MBvuUqMFSkIoewTu46JkJzZ1VfN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734974310; c=relaxed/simple;
	bh=ZFjtw8mVlMznxfdXZbC8x7yvA3bZktZPf3wIGguvL5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrYhsV1HYiYrPe36XeE04AEf/bOIXc4ZNxSuXTbFCLx88HDO/55Hviori3M5x57d1MRorLfPOvlIcwuZ8SDlkt+ak3FV2FzgtWruPaxr2hnVIR17CqtkSEmu7IzvN9j4szN5shsKO3iyCnrWSYzWxEPjRslMJxJBDIHjwdrhgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=BXhZKUh9; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZFjtw8mVlMznxfdXZbC8x7yvA3bZktZPf3wIGguvL5I=; t=1734974308; x=1735838308; 
	b=BXhZKUh92NvT4hJbYF/wJZYjMkDiMY43bt6U46rSbuzbuWVrCtTl28QKkq1ZSt/+fXuV0gKteCu
	TFeFG394P07kDk90RqGZihJuHkYjdJumD0wSnWDJAV9qY1CKNKkmxsnbBmbMayXKuzj5n0bVgkyoh
	2nHn/S3k+hohqZF1w8b50dSXXFh5/378vm9dv1xqtzH3JmPHyiI3UUhDnoCIeVfFGfYoifPCfzItq
	JsNwIyQv5Btj31pS0jLAr1WdHGJ21u3uIwqTJ+NsIC3Ze2xISrt1bRlwFdLdOPMCvC5kYN9cR7xfE
	2LpViLzJz3Q96WbYhUhe0qtvOMaof3yzc38A==;
Received: from mail-oa1-f47.google.com ([209.85.160.47]:61458)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tPm4S-0005l6-VQ
	for netdev@vger.kernel.org; Mon, 23 Dec 2024 09:18:22 -0800
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2a01bcd0143so2941247fac.2
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 09:18:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUalH3ZCQA9mRMekytmQ7Mli3yDHYwoo25QH6YZ9Uk7xLC9OdV2ikh0AE+NJISLIo/+FIXgwSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22Y+nZ+I8FNwn9tEvRqLZkityO4AZ0IdF0SX72qYNP50++BuM
	ZAcxbELWcTeveZStXuK40eWRsZVC9k7CQB/b8JG+tyz4xYTgwyKWlqciwdjhdoC6llkd5c2uigs
	iBJ/7Qq5GLU//pv58+QqGYGuFDpA=
X-Google-Smtp-Source: AGHT+IEE3jaC2ucf93fwI55SSQW+DS3K6j69v9PEtECB+2MiMak/iFFi1rlAjBV0soeTseGXHNIXyA9G7/x0JwqabPo=
X-Received: by 2002:a05:6870:1592:b0:29e:7f8c:8f57 with SMTP id
 586e51a60fabf-2a7fb4b7987mr8450299fac.27.1734974300375; Mon, 23 Dec 2024
 09:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217000626.2958-1-ouster@cs.stanford.edu> <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org> <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
 <20241219174109.198f7094@kernel.org> <CAGXJAmyW2Mnz1hwvTo7PKsXLVJO6dy_TK-ZtDW1E-Lrds6o+WA@mail.gmail.com>
 <20241220113150.26fc7b8f@kernel.org> <f1a91e78-8187-458e-942c-880b8792aa6d@app.fastmail.com>
 <CAGXJAmw6XpNoAt=tTPACsJVjPD+i9wwnouifk0ym5vDb-xf6MQ@mail.gmail.com> <728cebe2-6480-4b55-a6dd-858317810cff@app.fastmail.com>
In-Reply-To: <728cebe2-6480-4b55-a6dd-858317810cff@app.fastmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 23 Dec 2024 09:17:44 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxqk14LdwtxER24X4wuFO0SrjALabE3=t7SatugbLqOQg@mail.gmail.com>
Message-ID: <CAGXJAmxqk14LdwtxER24X4wuFO0SrjALabE3=t7SatugbLqOQg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API for Homa
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 6890477ab20817755420d5b1edd0addc

On Sat, Dec 21, 2024 at 5:43=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> >> That probably also explains what type of memory the
> >> __user buffer can point to, but I would like to make
> >> sure that this has well-defined behavior e.g. if that
> >> buffer is an mmap()ed file on NFS that was itself
> >> mounted over a homa socket. Is there any guarantee that
> >> this is either prohibited or is free of deadlocks and
> >> recursion?
> >
> > Given the API incompatibilities between Homa and TCP, I don't think it
> > is possible to have NFS mounted over a Homa socket. But you raise the
> > issue of whether some kinds of addresses might not be suitable for
> > Homa's buffer use this way. I don't know enough about the various
> > possible kinds of memory to know what kinds of problems could occur.
> > My assumption is that the buffer area will be a simple mmap()ed
> > region. The only use Homa makes of the buffer address is to call
> > import_ubuf with addresses in the buffer region, followed by
> > skb_copy_datagram_iter with the resulting iov_iter.
>
> Right, NFS was just an example, but there are other interesting
> cases. You certainly have to deal with buffers in userspace
> memory that are blocked indefinitely. Another interesting case
> is memory that has additional constraints, e.g. the MMIO
> space of a PCI device like a GPU, which may fault when writing
> data into it, or which cannot be mapped into the DMA space
> of a network device.

Homa doesn't map the user receive buffers into DMA space, so this last
issue won't come up.

> > Is there some way I can check the "kind" of memory behind the buffer
> > pointer, so Homa could reject anything other than the simple case?
>
> I don't think so. I still don't know what the exact constraints
> are that you have here, but I suspect this would all be a lot
> simpler if you could change the interface to not pass arbitrary
> user addresses but instead have a single file descriptor that
> backs the buffers, either by passing a tmpfs/hugetlbfs file into
> the socket instead of a pointer, or by using mmap() on the
> socket to map it into userspace like we do for packet sockets.

After thinking about this some more, I don't think there should be any
need for Homa to constrain the addresses passed into it. Homa's usage
of buffer addresses is the same as TCP's; the only difference is that
instead of receiving a buffer address in a recvmsg call, the address
is passed in earlier in a setsockopt call. In either case, the
application could pass in an arbitrary address. Assuming that TCP
properly handles all of the possible variations in addresses that
could be passed in, Homa should properly handle them as well, since it
invokes the same underlying functions. Is there a specific example you
have in mind of an address that would be problematic for Homa but not
also problematic for TCP?

-John-

