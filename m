Return-Path: <netdev+bounces-221305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F9B5019F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 331F57BED6F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC95352FE8;
	Tue,  9 Sep 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+nXkTF9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA89E352096
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432021; cv=none; b=CpMA5j43dpOVzYYCdU//AFMbVFuJyKWn+moVKJMK0xNvimeznHcRbv+3b6R5qOVpWH6w8C0yDhJ1u+GD/HybZrNMhGZnzPBn3EpSFyEqbwMhfY0HDHU2IKDe6gs1tz5Z9+Y+W6ZgjU6ddlehGqLsiMHqBMTEGlBIYsmzdsgcdDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432021; c=relaxed/simple;
	bh=eXqcsEVT0O/GOfA/Ca74pae233qQpT8kMZ1DFItem6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LW4M439EruPUAOZWmIagyPIJpyr33saeuoq9TO5keLA4sHrhuK9P815k7B1b3ozqJ34O33hVVakRlfspxTf9ygZhXhG5K9kdM3n0sbZfR73XLmLTGSRRKyW3ZzQCcmY50fS/cdTAMmVlBAiV/6nYkEzcooDUvETuOnVREF6gR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+nXkTF9; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b3d3f6360cso59114151cf.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757432019; x=1758036819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH53MCx6ogN1k+/cTYDbkLwp7+QCPYAr+PyETboPxPU=;
        b=Z+nXkTF9JfnULQd3XbzxXlfRdTzzgDr49lrdpLuq3FXi+I/MaDoS4jQRaHR6rOOQhF
         B/3pLnFn9bjNO1++zCzgpyqUfunnQ07fMWf37xR7NueFFIvkF8T6AyvbM8opEwlS5JYW
         kftTpR7HzlG04ODQ9DSDefG6P1JtarUJ7noZfTTsRAT+2cyAFzKhTqtrWkC246XJVNDK
         2lbhqkoG7F7JofQnoDh4ZAXllkj5suioJJJgj4lQ+kCnZy78NO7ZhbLTAYWxzNXIljS0
         CJDlBsbb5hEYXEBsBz2pMD3UgpBP++xQ+cDVAKmfcuauQ9+AYTYweAyb1aCkekZ3oPTJ
         corg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432019; x=1758036819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LH53MCx6ogN1k+/cTYDbkLwp7+QCPYAr+PyETboPxPU=;
        b=ltuu+sykgb3BMftob0viFT5ktfGXDecuOv+uYOh5iEVgOfsFecDCrAUbpq9O2OGsnx
         9SzglknLytEHIKG6F9O1C49QCyb1xdcoo6IAMXAVB44oyfjsnMwgpWE5iIswmMlZAgAT
         XytXNEoT6bpQYIqp12Q+AA40Dl4J6T/AOnD7sXLrXDHhgB5wzwFU3empHhQPIvUE6tIi
         4p62IojgM/pHEYyDBBtfNMHS1bnhqhxjyvBAjlF993Nfjby91Zx6/gyMIwR0BJRDNdVO
         3prPZDJuttFSa1GsQShyskpBxZ/74+22z1SI96konmxtM58C0Myhu6Mfk/jCcBj7l/j+
         JmJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYhq/7ME0VB0vU0yoXT9cHxDybwM2GceIxJksC5IpNDuf9yDORCdCTBrHq+5Km7iabLe2U3II=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4FzIKPFtUj4hGuQM5UhjaG92wHrPV2fK9eptyHs1fMzkEOav
	MqFk5QxeY+WS6XpGISH37T+MW61VT/sWQMHFzFwOhng9YLAPS1gvawYOS3rGNkAV8xY/IoLoM3w
	6VWe7LEN88vBTFRREU930Cmj3RWnOk8ffJEoPkaQ2
X-Gm-Gg: ASbGncsq6IhNWFFUeBk2vVrGfuiKnEqRTpMYfE/eSpfxlmDCLFcQYwI+dIfLTPAaYu4
	U6L+RJYJVA/Z8DE30OCywjazP9cVDxczajJCN7CuhInkyAFSTeEnLl525VQuNSTXODSHsAc67IU
	7FMDvrrssMXf7UXUoPT3i3tUAXlwCBirj1ARas/c/4u5NB78Jzky20NrydDFt8F1iUL5QESuy1s
	R1RBZTG4yk8SG9pffU4bSx0hDLR+Ig2t2zzwxU9uhnTBYCCIkEEnZXBodA=
X-Google-Smtp-Source: AGHT+IEBSJFGC5HE816C89rHJ7brsZIZ78JEBVc19MhZewWuyBdDU+KpX7j08rvkOLFoUtfGNDkZcsKLsSZemorc0Ok=
X-Received: by 2002:a05:622a:1887:b0:4b5:ea94:d715 with SMTP id
 d75a77b69052e-4b5f8390522mr114936061cf.1.1757432018215; Tue, 09 Sep 2025
 08:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909132243.1327024-1-edumazet@google.com> <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
 <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk> <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
 <20250909151851.GB1460@redhat.com>
In-Reply-To: <20250909151851.GB1460@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 08:33:27 -0700
X-Gm-Features: Ac12FXwmsBi8N5rZnVovo52dil5DJvY7h1QqJGILCkzQ81ibk4sKlJtshywQWDc
Message-ID: <CANn89i+-mODVnC=TjwoxVa-qBc4ucibbGoqfM9W7Uf9bryj9qQ@mail.gmail.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	linux-block@vger.kernel.org, nbd@other.debian.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 8:19=E2=80=AFAM Richard W.M. Jones <rjones@redhat.co=
m> wrote:
>
> On Tue, Sep 09, 2025 at 07:47:09AM -0700, Eric Dumazet wrote:
> > On Tue, Sep 9, 2025 at 7:37=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wro=
te:
> > >
> > > On 9/9/25 8:35 AM, Eric Dumazet wrote:
> > > > On Tue, Sep 9, 2025 at 7:04=E2=80=AFAM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >>
> > > >> On Tue, Sep 9, 2025 at 6:32=E2=80=AFAM Richard W.M. Jones <rjones@=
redhat.com> wrote:
> > > >>>
> > > >>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
> > > >>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
> > > >>>>
> > > >>>> Commit cf1b2326b734 ("nbd: verify socket is supported during set=
up")
> > > >>>> made sure the socket supported a shutdown() method.
> > > >>>>
> > > >>>> Explicitely accept TCP and UNIX stream sockets.
> > > >>>
> > > >>> I'm not clear what the actual problem is, but I will say that lib=
nbd &
> > > >>> nbdkit (which are another NBD client & server, interoperable with=
 the
> > > >>> kernel) we support and use NBD over vsock[1].  And we could suppo=
rt
> > > >>> NBD over pretty much any stream socket (Infiniband?) [2].
> > > >>>
> > > >>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
> > > >>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
> > > >>> [2] https://libguestfs.org/nbd_connect_socket.3.html
> > > >>>
> > > >>> TCP and Unix domain sockets are by far the most widely used, but =
I
> > > >>> don't think it's fair to exclude other socket types.
> > > >>
> > > >> If we have known and supported socket types, please send a patch t=
o add them.
> > > >>
> > > >> I asked the question last week and got nothing about vsock or othe=
r types.
> > > >>
> > > >> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A=
12+ndzBcQs_kZoBA@mail.gmail.com/
> > > >>
> > > >> For sure, we do not want datagram sockets, RAW, netlink, and many =
others.
> > > >
> > > > BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL
> > > > being used in net/vmw_vsock/virtio_transport.c
>
> CC-ing Stefan & Stefano.  Myself, I'm only using libnbd
> (ie. userspace) over vsock, not the kernel client.
>
> > > > So you will have to fix this.
> > >
> > > Rather than play whack-a-mole with this, would it make sense to mark =
as
> > > socket as "writeback/reclaim" safe and base the nbd decision on that =
rather
> > > than attempt to maintain some allow/deny list of sockets?
> >
> > Even if a socket type was writeback/reclaim safe, probably NBD would no=
t support
> > arbitrary socket type, like netlink, af_packet, or af_netrom.
> >
> > An allow list seems safer to me, with commits with a clear owner.
> >
> > If future syzbot reports are triggered, the bisection will point to
> > these commits.
>
> From the outside it seems really odd to hard code a list of "good"
> socket types into each kernel client that can open a socket.  Normally
> if you wanted to restrict socket types wouldn't you do that through
> something more flexible like nftables?

nftables is user policy.

We need a kernel that will not crash, even if nftables is not
compiled/loaded/used .


>
> Rich.
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> virt-p2v converts physical machines to virtual machines.  Boot with a
> live CD or over the network (PXE) and turn machines into KVM guests.
> http://libguestfs.org/virt-v2v
>

