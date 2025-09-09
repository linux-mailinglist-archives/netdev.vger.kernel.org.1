Return-Path: <netdev+bounces-221271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833DCB4FF90
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3099E4E0EC1
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5742734AB06;
	Tue,  9 Sep 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUkq/IVH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7B343202
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428563; cv=none; b=aCyQSLbzy7qYCsAsdYc5Ql06F8XidFfkK2mK0ow6RiWCStXzD6OPt4A015k2Z7ojqHc22QlEdQ7jXxjhaj+3aCd0iwHDHUSFdkfMXQgRhodOvASzn1mestSsfMmgj40LtoCWqBoZ37GiFXcOh+ByHRVF9LsEE3fuUucirfHLBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428563; c=relaxed/simple;
	bh=w6dVntwi3vOqnbpF7RfQzGrHtsQ2AQbXOFzdBAw2bew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1d3yjGf08vlNVV2nIpbAWhaJQdufEg5GJbMIhEZtCBS+Q4hRAU/xF6knC08ruvZIdUNJp3QStdas3/5oV5PG7Lw4vl5zkCzG7dO7wzlLhgAAWQqwMmikrJNf7kUre54fGoJoMjdqUQwpIIJZF2ucVJn0eCcn6hHKPLsXkdNHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUkq/IVH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-80c45a0b023so536682185a.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757428560; x=1758033360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HraNQc0UftoQGnAHFz41MD+6PWIU9oXjn/T/bod79Lc=;
        b=bUkq/IVHdirLJJAD9GoCtsBQyHtXMDJSzGjai0DW8i80nPAaB3j8OIR48i6vemFDxv
         OOj2ueEQcvuMguL70hflLOCbtEyOR8u4+lHkE/fr5XW+yuaWsDY92n19ZWMNfsUB8jNe
         9VR4Eykow9FDTm3kQ5WrW4ZtMY06Bx8YqMLZuK2byT2C2vFrkpDDc/tUj9b28hNI9Qxj
         K5AufdyL1VzVUIt2IS1596wOL8R6DoAOnSRxZ5jxAnMvpVaXQGAKchuKXRS86FCl8U1O
         lNXBux12xGOMOxjoQQYb1TgrOjvQfSvabL/mswz9Ae+zsC6iGjTTxSKA2ihEMmhyeVm6
         e8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428560; x=1758033360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HraNQc0UftoQGnAHFz41MD+6PWIU9oXjn/T/bod79Lc=;
        b=mrIKQNKbgl++uW2uy1WYNpQZKcfu8tmOcNxvj7VkxJE3pahTSdi3TLHVd6qzhnlIn4
         EIiHM7DyZ8ykj9Nb09bYfy4ej9lbKR3lKwQhqZWBWcw9cFm5jJGndTN3XOJnr98qUlBv
         lFCQRPh4BITt3JLSf2jIxAmvMhgC7hbibRT7iclFKwslb85wDzNeV5+690E4m5KOU/0q
         2wsfykRRb28DdsV2rdMkll2ODasKr3c+dFmiFmDRn283b1pHO1teCz/bzT4tCbCGK2ZN
         QDzrWazfOc3d+EE5QJ/EUwwencITQmfEQscqF+GJf6G9FLpjC6eTkIax1r00jhMpHaaG
         XCHg==
X-Forwarded-Encrypted: i=1; AJvYcCVhQUsAIsEk6G6FUGFvgpfcpI2wi6efnEtNtb+Kevju8Z6wG7dNKVVf57+wqPr3BSHqZXPa0pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LoZYN4QxxHh7TSkZWcVPw/rAl+6c1PObFUPOfZSrYpMbXHrG
	BFq8hEJD21dLgT4pIINCAbU6rMLHWGOJ93knHpIeMdtZx3qm6keznRmyl1dStEtg9osFhJjDV6d
	QHgBXF04GY5fVMPrf/VRdKK/0ljwM9LA3nTunr5/f
X-Gm-Gg: ASbGnctLwgA4EFMUv1+rbvbZHAVjLg0m0+bNw2D6bypKbh4uQnXa0ewXgVWR5vBA9bT
	1xl2az1fosSfhTWEvnFJsJgk9lL5e+WGnrVZxsNdSU7uNR/w23FD8TXRmlUfWBL9huW6unRWYFw
	pgQdmXE0kiSWku5Ghd9DK1/4CmYTatmDtHDLwBnhSMB9/hmu7ebXqJZ+1wWFAdhtS9JMHoVl2l1
	XtNrkyIVJ1XcpNdPNTbQYhBtYTL0CL7kF8V0oefM6aG9tYNpwpf6dRfyrw=
X-Google-Smtp-Source: AGHT+IEcQgssG3xpRvjhJBiKRjyFcvptOCwG39IVu/CLtP2NQ1mCQBIQWJNjR4pgnF/UmTo5naxxM4HNF2TQoVznEMI=
X-Received: by 2002:a05:620a:1724:b0:80a:865b:41c6 with SMTP id
 af79cd13be357-813c2f05abbmr1254106885a.71.1757428559921; Tue, 09 Sep 2025
 07:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909132243.1327024-1-edumazet@google.com> <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
In-Reply-To: <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 07:35:48 -0700
X-Gm-Features: Ac12FXzzB88yrAkRmM86ZkLSUzK_othsjEAnd_7hIylswOuaxXv3xozERw8g82A
Message-ID: <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:04=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Sep 9, 2025 at 6:32=E2=80=AFAM Richard W.M. Jones <rjones@redhat.=
com> wrote:
> >
> > On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
> > > Recently, syzbot started to abuse NBD with all kinds of sockets.
> > >
> > > Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> > > made sure the socket supported a shutdown() method.
> > >
> > > Explicitely accept TCP and UNIX stream sockets.
> >
> > I'm not clear what the actual problem is, but I will say that libnbd &
> > nbdkit (which are another NBD client & server, interoperable with the
> > kernel) we support and use NBD over vsock[1].  And we could support
> > NBD over pretty much any stream socket (Infiniband?) [2].
> >
> > [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
> >     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
> > [2] https://libguestfs.org/nbd_connect_socket.3.html
> >
> > TCP and Unix domain sockets are by far the most widely used, but I
> > don't think it's fair to exclude other socket types.
>
> If we have known and supported socket types, please send a patch to add t=
hem.
>
> I asked the question last week and got nothing about vsock or other types=
.
>
> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzB=
cQs_kZoBA@mail.gmail.com/
>
> For sure, we do not want datagram sockets, RAW, netlink, and many others.

BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL being used
in net/vmw_vsock/virtio_transport.c

So you will have to fix this.

