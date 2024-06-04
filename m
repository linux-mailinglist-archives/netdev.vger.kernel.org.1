Return-Path: <netdev+bounces-100778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAAB8FBF02
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E321F214CB
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D965E143872;
	Tue,  4 Jun 2024 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBb3w7rw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9628DC7
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540478; cv=none; b=DQKkIQF9J8uA5qIg2hn27xRWtMhoDlg17FBXvtaHOQ84VqJaE8Jjw5IyvpaD0flijH1gOZnrkHbjCtNWuwXp2CnOmxR6IU1FvbGJZDp8KLZan82CAYWEIh6k8+Z05eOkmEONOVLStDRywAF4FkqyzC4ddlXwuHyQVbdz4Ly2Mhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540478; c=relaxed/simple;
	bh=/MudG5okQYC1W8yeD5jVv9KMmnumXMPu7xzcfLQbc7U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tk1XlKVLxP2u5wWxzrG0MEyE2wgsPU1pd+cM4YNgLU481lKI8kURcPzaiQZR/vuryVnS3CG2igC9n8zBFbp2w3kqCXivPK4QlBCGvelO7mQ4lCu2PcWVDwGvct0TXJJREQw+ihPWSC6ReX/Un9byE4CccZLLaI3LkojVC/KTw98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBb3w7rw; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7952223e66aso42141285a.2
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717540476; x=1718145276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAGeO8OPzVFNm4GJxxxULr+RzPSWLs+NWYo7m9oXDl8=;
        b=UBb3w7rwjv7tW9LJ1nR270FroCZv/0SVIqC8YQOm5MkKIlm1ttxKXudDYY0H9uNibB
         KsLStqqxZu6mlBBY2lLn+TpzqjbJ118e+TLAfhbAqqzRRutZS3SWAAvqRLuxC8+8v1Xs
         uYrbyvjTpylnHdEWaEOSHlmcuObtvcuMSOE10Q1djs9BGv6Q+Z4ULC/sb2oJDGjdAtky
         kmJClOZD3hej0iF0W2ShRKg0csHz+n3+N80acDj++j0jcK8GG2NLRqLki0iKnrkhV8Wr
         eBdQB2LRKZNp7a85qpAgcepg24LMLCTYvXOXVvagDhXJNHQJFBvs4ko/h0a3ICqsn99B
         ynhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717540476; x=1718145276;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SAGeO8OPzVFNm4GJxxxULr+RzPSWLs+NWYo7m9oXDl8=;
        b=ElqUVocHRunPLwZovoK/p5miGBsx/HZ4zGZMUGbNhBSPDRGDIOUvYPxdxbbbPUGm1V
         34FJBF8JfUPat0+Uu8Lwrrb3q6j3EUyICKdINMEOPDS1hL9fDStYi6Io9lwxFQWBassM
         6x+oXiHmDtMlnh6tbgCDNqSYmokp0r40M16urZJmtcyW/LhoXIPrLzBh6iweNvz/5D35
         moLnfV7UBU/vb823AL7Kzdoc7bFl8qLleC6CUUDZylsyumw9+zeNDrVUcQySIlbv35I8
         0jNrS4K3+H/CU45ldr4Oq4k7ROcFh+gwgF99Ro0/b3qf/MF7CyzfkO1F+krAZeNBptOJ
         jvbA==
X-Forwarded-Encrypted: i=1; AJvYcCW2sa78sxH/0BPAFgoFwBs4hkYJvjLjkX6FPiwk+0m5ZTbsW5Fdxs6H3ZOY/Jc7DECwIPYfY+L6OKZjoN+q69cAeNIj8lVh
X-Gm-Message-State: AOJu0Yyhri3bh4DgAgN2kqkJyv/zM6AwH6OR1CwkfZg2vOvdEwvywa+h
	di45zGaoaLu0QzRKa5JuKoRnfl9W5uyAxeM7dd39DugzVktDKZ1pEsaFng==
X-Google-Smtp-Source: AGHT+IHX0Qj2RXdH3G1t4YNgbULJ0xlBwgW+8SN1JbnEKGk3bGMIWW5CI1ZDYR9dePoTn+SXF1WPmA==
X-Received: by 2002:a05:620a:4fa:b0:795:1d06:f32 with SMTP id af79cd13be357-79523fc2d8fmr65469685a.56.1717540475761;
        Tue, 04 Jun 2024 15:34:35 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7951a1a8e5asm75268885a.121.2024.06.04.15.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:34:35 -0700 (PDT)
Date: Tue, 04 Jun 2024 18:34:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: xiaochun.lu@bytedance.com, 
 cong.wang@bytedance.com
Message-ID: <665f967aba65c_2bf7de294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <3ce746bd-e1a3-4e3d-bff9-9d692f4d7f20@bytedance.com>
References: <20240528212103.350767-1-zijianzhang@bytedance.com>
 <20240528212103.350767-3-zijianzhang@bytedance.com>
 <f2621d81-0d85-440a-ae52-460625bfff40@bytedance.com>
 <CAF=yD-KTcb0RfKLuZ9Sx0gTH-iZyvAfv3u=c6y7Gtm=znDS=nw@mail.gmail.com>
 <3ce746bd-e1a3-4e3d-bff9-9d692f4d7f20@bytedance.com>
Subject: Re: [External] Re: [PATCH net-next v4 2/3] sock: add MSG_ZEROCOPY
 notification mechanism based on msg_control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zijian Zhang wrote:
> On 6/2/24 3:29 PM, Willem de Bruijn wrote:
> > On Fri, May 31, 2024 at 7:20=E2=80=AFPM Zijian Zhang <zijianzhang@byt=
edance.com> wrote:
> >>
> >>
> >>
> >> On 5/28/24 2:21 PM, zijianzhang@bytedance.com wrote:
> >>> From: Zijian Zhang <zijianzhang@bytedance.com>
> >>>
> >>> The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.=

> >>> However, zerocopy is not a free lunch. Apart from the management of=
 user
> >>> pages, the combination of poll + recvmsg to receive notifications i=
ncurs
> >>> unignorable overhead in the applications. The overhead of such some=
times
> >>> might be more than the CPU savings from zerocopy. We try to solve t=
his
> >>> problem with a new notification mechanism based on msgcontrol.
> >>> This new mechanism aims to reduce the overhead associated with rece=
iving
> >>> notifications by embedding them directly into user arguments passed=
 with
> >>> each sendmsg control message. By doing so, we can significantly red=
uce
> >>> the complexity and overhead for managing notifications. In an ideal=

> >>> pattern, the user will keep calling sendmsg with SCM_ZC_NOTIFICATIO=
N
> >>> msg_control, and the notification will be delivered as soon as poss=
ible.
> >>>
> >>> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> >>> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> >>> ---
> >>>    arch/alpha/include/uapi/asm/socket.h  |  2 +
> >>>    arch/mips/include/uapi/asm/socket.h   |  2 +
> >>>    arch/parisc/include/uapi/asm/socket.h |  2 +
> >>>    arch/sparc/include/uapi/asm/socket.h  |  2 +
> >>>    include/uapi/asm-generic/socket.h     |  2 +
> >>>    include/uapi/linux/socket.h           | 10 ++++
> >>>    net/core/sock.c                       | 68 +++++++++++++++++++++=
++++++
> >>>    7 files changed, 88 insertions(+)
> >>>
> >>> ...
> >>> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socke=
t.h
> >>> index d3fcd3b5ec53..15cec8819f34 100644
> >>> --- a/include/uapi/linux/socket.h
> >>> +++ b/include/uapi/linux/socket.h
> >>> @@ -2,6 +2,8 @@
> >>>    #ifndef _UAPI_LINUX_SOCKET_H
> >>>    #define _UAPI_LINUX_SOCKET_H
> >>>
> >>> +#include <linux/types.h>
> >>> +
> >>>    /*
> >>>     * Desired design of maximum size and alignment (see RFC2553)
> >>>     */
> >>> @@ -35,4 +37,12 @@ struct __kernel_sockaddr_storage {
> >>>    #define SOCK_TXREHASH_DISABLED      0
> >>>    #define SOCK_TXREHASH_ENABLED       1
> >>>
> >>> +#define SOCK_ZC_INFO_MAX 128
> >>> +
> >>> +struct zc_info_elem {
> >>> +     __u32 lo;
> >>> +     __u32 hi;
> >>> +     __u8 zerocopy;
> >>> +};
> >>> +
> >>>    #endif /* _UAPI_LINUX_SOCKET_H */
> >>> diff --git a/net/core/sock.c b/net/core/sock.c
> >>> index 521e6373d4f7..21239469d75c 100644
> >>> --- a/net/core/sock.c
> >>> +++ b/net/core/sock.c
> >>> @@ -2847,6 +2847,74 @@ int __sock_cmsg_send(struct sock *sk, struct=
 cmsghdr *cmsg,
> >>>        case SCM_RIGHTS:
> >>>        case SCM_CREDENTIALS:
> >>>                break;
> >>> +     case SCM_ZC_NOTIFICATION: {
> >>> +             int ret, i =3D 0;
> >>> +             int cmsg_data_len, zc_info_elem_num;
> >>> +             void __user     *usr_addr;
> >>> +             struct zc_info_elem zc_info_kern[SOCK_ZC_INFO_MAX];
> >>> +             unsigned long flags;
> >>> +             struct sk_buff_head *q, local_q;
> >>> +             struct sk_buff *skb, *tmp;
> >>> +             struct sock_exterr_skb *serr;
> >>> +
> >>> +             if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family =3D=
=3D PF_RDS)
> >>> +                     return -EINVAL;
> >>> +
> >>> +             cmsg_data_len =3D cmsg->cmsg_len - sizeof(struct cmsg=
hdr);
> >>> +             if (cmsg_data_len % sizeof(struct zc_info_elem))
> >>> +                     return -EINVAL;
> >>> +
> >>> +             zc_info_elem_num =3D cmsg_data_len / sizeof(struct zc=
_info_elem);
> >>> +             if (!zc_info_elem_num || zc_info_elem_num > SOCK_ZC_I=
NFO_MAX)
> >>> +                     return -EINVAL;
> >>> +
> >>> +             if (in_compat_syscall())
> >>> +                     usr_addr =3D compat_ptr(*(compat_uptr_t *)CMS=
G_DATA(cmsg));
> >>> +             else
> >>> +                     usr_addr =3D (void __user *)*(void **)CMSG_DA=
TA(cmsg);
> >>
> >> First of all, thanks for your efforts and time to review this series=
 of
> >> patchsets!
> > =

> > Please try to keep this conversation on the netdev list. What I
> > respond below would be good to have in public discourse. Among
> > others for others to come disagree with me and tell you that they
> > prefer your patchset just the way it is ;-)
> > =

> >> I believe compat issue has been resolved in this if code block? I kn=
ow
> >> that the current design is quite hacky, and want to discuss next ste=
ps
> >> with you,
> >>
> >> 1. Is it possible to change ____sys_sendmsg? So that we can copy
> >> msg_controldata back to the user space.
> > =

> > I do think that this is the clean way to support passing metadata
> > up to userspace.
> > =

> > The current approach looks like a hack to me. It works, but arguably
> > is not how you implement a serious user API (ABI).
> > =

> > A more complete solution can potentially also be reused by other
> > features that want to piggy-back information from the kernel back
> > up to userspace with sendmsg. Timestamps is an example.
> > =

> > I did implement the full method once.
> > =

> > Initially, don't spend time on modifying ___sys_sendmsg *and*
> > on supporting the compat version. With the right structs (that are
> > not ambiguous between 32 and 64 bit) it may not even be needed.
> > =

> > But I would be more supportive of this full interface.
> > =

> > It also ties into the performance benefits observed. If they were
> > shockingly good, I would still argue in favor of a cleaner API, to be=

> > clear. But a minor improvement is even less reason to consider a
> > hacky API.
> > =

> > All of this is just one person's opinion, of course.
> > =

> >> 2. Is it possible to support this feature in recvmsg instead of
> >> sendmsg? In the case of selftest where one thread keeps sending
> >> and another keeps recving, this feature is useless. But in other
> >> cases where one socket will send and recv, this might help?
> > =

> > That's a lot easier. And halves the cost of having to calll both
> > recvmsg + recvmsg MSG_ERRQUEUE.
> > =

> >> For sockets that send many times but recv very few times, a hybrid
> >> mode of notification using msg_control and errmsg_queue can be used.=

> >>
> >> 3. Or, do you have any idea?
> >>
> =

> I did not remember the reason why we directly pass in the user address
> and have ctl_len to be the array size. Can I pass in a struct like
> {
>    __user void *user_addr;
>    __u32 array_size;
> }
> and have ctl_len to be the sizeof the struct, just like my first patch
> set? Of course, I will consider the compat issue for user_addr this tim=
e.

A clean CMSG API uses put_cmsg to write the metadata into msg_control.

This will take care of any length, no need for additional explicit
length params.

See also how cmsg is used for kernel to user metadata on recv.

But, since ____sys_sendmsg actually creates a kernel copy of
msg_control and passes that to the callees, put_cmsg will write into
this kernel buffer, so on return ____sys_sendmsg will have to
copy_to_user to the original buffer.

So this definitely

- is more work, requiring changes to ____sys_sendmsg
- may slow down the ____sys_sendmsg hot path with extra branches

So I see the appeal of just passing a user pointer and punt on the
whole issue.

But that is rather crude, bypassing an established mechanism.

Which may be reusable for other kernel to user metadata associated
with the transmit path. As said, the tx timestamping example.

I remain that the biggest hurdle is that the demonstrated impact from
this new API is small. ABI changes can (almost) not be undone. So does
the new maintenance warrant that cost?=

