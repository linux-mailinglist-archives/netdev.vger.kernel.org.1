Return-Path: <netdev+bounces-196854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59969AD6B3A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18831884263
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC1221DB1;
	Thu, 12 Jun 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFTMRgMX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD531B412A
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717890; cv=none; b=eeueCLWRy7oBdn5x90HabbAZrPwC147TXdTxyGw1HFGrTmWkdPqaDxcA3ayYfhQNJHyc6HButqYwhv+gNl5FnjskSsOg7nP/FQG/oqm0sd2THQwQI11vAEf5RYWdEj308co131eTvEJQcGNMy65JkN1DyJHMPsJQM6dAnQ2FCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717890; c=relaxed/simple;
	bh=rNTbSvQjmtm36dJjYb+8KYjVtBDjiIzJsQLY4I9jU7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETdU/nBgHEMOysdtUm6uLZrn/78wqJAfhORoTDOk14jFT8Dw6rrxa9mbppVPd3E6nQ4RjaD7MAHKkIRfQmAEzkWXqK0ighhsCykksO1XNru++agy8SHIqgrb4VlWA63IeRFz1ngtLLCRJXEFW8VoZ5uoN43Ti7o2wXQm1mUS+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFTMRgMX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749717887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rNTbSvQjmtm36dJjYb+8KYjVtBDjiIzJsQLY4I9jU7k=;
	b=NFTMRgMXm/X3gM2DQDMlGyTQaiBW5DtLRjLob7fTP9mSR2CZf1EdCNWzPwYU4mIQF/DT9m
	JtdhV+uh4UtzMiCmI2QaLv9CSQJyMRUXdP6Hu2Y1MS+FrVGAQSI4uF2PR6zClioFy80InD
	IczhfYE2Og1ON22uZEB1zXE8h6cMKS8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-ti8nZtXbOKqVHyMLoJ825g-1; Thu, 12 Jun 2025 04:44:45 -0400
X-MC-Unique: ti8nZtXbOKqVHyMLoJ825g-1
X-Mimecast-MFC-AGG-ID: ti8nZtXbOKqVHyMLoJ825g_1749717885
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e81733e4701so1088514276.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 01:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717885; x=1750322685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNTbSvQjmtm36dJjYb+8KYjVtBDjiIzJsQLY4I9jU7k=;
        b=Z1Fw2esErh22p08G9eOqF3v7w2sQcVkEozWay/8MRCCJOYBwiPAdFOGNqds6gaizCw
         Et+Oe6KpFtFsdVmsFjbZiDvPEJPVA4eHhzSsvjf1HAiS6kK5kBXz//ng/FM/ZSuWz4zN
         m889BaFenUoxUaZjzUHbWabkqXMQ4QNp/W6haLzmiJptLAGmW3P9/AlAbGDxVYKxtFdM
         tkbWMkHQ7WMCbAIB8h805+YIoGBFH7DTDBX6SvUVlBQZrtkCnon1s30WVv+SxhrNQalv
         zS0/Zt1oGWu9TQ1XD6ctkNFmYlMe/1f6L9zdFDoL2rOy8ruQvNOET1Nv3I7HDA45qbW1
         GfMw==
X-Forwarded-Encrypted: i=1; AJvYcCUr8X3MDqq086qEg/OYje6HFJDYAgobZcX/ROVomYkF1gokxLbfuRYPLLICaaai3h+Y7DgE8A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR1uUnAhmzO0mwjbRmjCq86F9canywpd6r7Z6qHxPhLc7kVEFr
	V63KaXk6vBsHR24Tm3SVIx5Ixeq2kregGni1UuPMod0GB3t7vNeRKkp1O3m9H6y3CRu0XTyKlbO
	5wVDA1XkREC3OIRMZnS02sMvXtbDlfLxUztW7SnDJknLR1iGW4EWuMItfbzlnoo58oI2w6es9mW
	Rdh46JDHZEGNBQ9Ubikc8T9W7h3g2RVzwn
X-Gm-Gg: ASbGnctGerlp/7X57+uZU6WFqDYDWCjxrIV1HYynvoNJfqVWmb22siP2s/RMJcxP9je
	KSwkuncUdln6gcFPxZOQBMGrfenE5Z5vS6wmuU/0k1hbkyMzFDLPU56NUaGKOfNACgwA4dWXlE+
	4zuMjN
X-Received: by 2002:a05:6902:2611:b0:e81:4e9d:9e79 with SMTP id 3f1490d57ef6-e81fe6b8b7amr9216280276.40.1749717885019;
        Thu, 12 Jun 2025 01:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpO7imw7/y6hUBA3+X+9+644bvWl/2xN24NgD0/xASJ+Z1iQt0UZZ7qIi1/vJ8aGKQCfn0PwMZVX01PvmLRPE=
X-Received: by 2002:a05:6902:2611:b0:e81:4e9d:9e79 with SMTP id
 3f1490d57ef6-e81fe6b8b7amr9216251276.40.1749717884673; Thu, 12 Jun 2025
 01:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGxU2F6c7=M-jbBRXkU-iUfzNbUYAr9QApDvRVOAU6Q0zDsFGQ@mail.gmail.com>
 <20250612082102.995225-1-niuxuewei.nxw@antgroup.com>
In-Reply-To: <20250612082102.995225-1-niuxuewei.nxw@antgroup.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 12 Jun 2025 10:44:33 +0200
X-Gm-Features: AX0GCFs5PNoVhHhHZsKNXS6ADWJpjexmyZKqj4oyHShXjy9f_WC9YKjQLjFGOUk
Message-ID: <CAGxU2F4JkO8zxDZg8nTYmCsg9DaaH58o5L+TBzZxo+3TnXbA9Q@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream sockets
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: Oxffffaa@gmail.com, avkrasnov@salutedevices.com, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, horms@kernel.org, 
	jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	niuxuewei.nxw@antgroup.com, pabeni@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 10:21, Xuewei Niu <niuxuewei97@gmail.com> wrote:
>
> > On Thu, 12 Jun 2025 at 08:50, Xuewei Niu <niuxuewei97@gmail.com> wrote:
> > >
> > > > On Thu, Jun 12, 2025 at 01:32:01PM +0800, Xuewei Niu wrote:
> > > > > No comments since last month.
> > > > >
> > > > > The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
> > > > > patch. Could I get more eyes on this one?
> > > > >
> > > > > [1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t
> > > > >
> > > > > Thanks,
> > > > > Xuewei
> > > >
> > > > it's been in net for two weeks now, no?
> > >
> > > Umm sorry, I didn't check the date carefully, because there are several
> > > ongoing patches. Next time I'll check it carefully. Sorry again.
> > >
> > > It looks like no one is paying attention to this patch. I am requesting
> > > someone interested in vsock to review this. I'd appreciate that!
> >
> > Which patch do you mean?
> >
> > Thanks,
> > Stefano
>
> I am saying your patch, "vsock/virtio: fix `rx_bytes` accounting for stream
> sockets".
>
> Once this gets merged, I will send a new version of my patch to support
> SIOCINQ ioctl. Thus, I can reuse `rx_bytes` to count unread bytes, as we
> discussed.

As Michael pointed out, it was merged several weeks ago in net tree,
see https://lore.kernel.org/netdev/174827942876.985160.7017354014266756923.git-patchwork-notify@kernel.org/
And it also landed in Linus tree:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45ca7e9f0730ae36fc610e675b990e9cc9ca0714

So, I think you can go head with your patch, right?

Please remember to target net-next, since it will be a new feature IIRC.

Thanks,
Stefano


