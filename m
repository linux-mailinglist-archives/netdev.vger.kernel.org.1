Return-Path: <netdev+bounces-113276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A01F693D73E
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 19:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3217D1F23303
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 17:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218A528DA5;
	Fri, 26 Jul 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEcNFMch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363F5684
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722013233; cv=none; b=ZNIl8hsvjbTCknrCiaOdmnQz8WhRF02a9fRgtL6cRcrDc4Qxw1xvXzOve1EIUuopEIyCeFUiAoXCtzk1KPAO4bQmbWEFfgh71Q4xh8ezWZ2q3PlJZaRZN2EpDgcWiG7anF71sNcCfmrA1k/m7F7vtJVY2l2g7pmBUrVDqztdpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722013233; c=relaxed/simple;
	bh=VHay4RBPslQZDT8zvEjVldMdgYKuBwi9VSk2XRSqT5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKVNj5/vOqv93xBSByGHqmJRl1stC6bhDleffg+UD10mmW4EP+0/ISCVmkaECcMDz+R/tVsW4m7/mSkbNWyARIPRxiAynebTbl3cfV4v3jSYIRKSZhzshG1W6FSr/Y5LiSeC1rcVDl80jKY7xWhyBbljvr1+k0z54FPO3WNDsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEcNFMch; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b7a0ef0e75so5374306d6.1
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722013230; x=1722618030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jrqz1G3e2QNrf1Q0IaDDTTq9eRDp3YSsvE+lRefkuM=;
        b=gEcNFMchi7dTD33WKEAiuZz51wEaZRvABjHPB+bzIMo9kmF6og7rILrb1aaFbUHk3V
         IwZbUmpTXtH/TS7L0v/dBCCsogoZXoDsYUHcwEGWQ08+4P1eDm4AElvAdnkEFz8Zua47
         Sxz+ragxYc6o0OQcbB+RDwSj5psw9GlIHlVJtzKTeQV08zPYi66aj33DIBmFi76aAs+i
         8sbxb6QfkpjcOErKETtXcA7bu1wOFXtSZyKi8ADVXi7BVGtPx/qbCZVkNmdIiXblkqhB
         +DDP4iQIWhDqK3N/yODcTnqk60w6GXYOwaAwcFM0Lo1DYXBwm21szYWQ5pyLWTcHjKYn
         6EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722013230; x=1722618030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jrqz1G3e2QNrf1Q0IaDDTTq9eRDp3YSsvE+lRefkuM=;
        b=UdcxxXfqWsEf2nZbhietoBocACwVMkWjfpylV5yP1bsYnJbSeicsX1HRpQnlxEbJfg
         0+uobxKcZK+9wM9C7KzxRe3fkFtu69adsQq/Js/uROdmVBIIcJ+5V79KyVCL79IeoKZQ
         62JziJnAhpKBZkz6bAp9+TTrXfvBcOv8atx2pqEVn3A7MsyoSMS8E5n5F5FIjBUT6Tum
         rMzviDs9RRsCA0zcx/8rY3e5+EkRj3c3/0SGZ6uM0GcA+50FtZM43VFo7wdy2Eo/ujAM
         7ZDipyHUit9EyovqY5iGZHytC0bRZAygCDg2voSlo07T8g0WK0NJGoS+G+67XaKs4GRJ
         yS6g==
X-Gm-Message-State: AOJu0Yx0kKSuHivfrvKLh+freWRWZU+Eic3Wd/elGxMPwMldfwR9+xj4
	w4esk9eh5VKhvor3dfYtPQeXeM9xqHqGlafeFF/wnyxw7/945MiUqwOcbzpN+HyFLcU4Jchf6h0
	7hniciPx5/Ks0NjHV7z4RU5ZNDjOvs3JvBALZ
X-Google-Smtp-Source: AGHT+IFtxYGR7lY6JOp36dJQbPLqHKz/UtGDX2rNr0bKUa9tCiBGEJ1uSXmP2rorR2H49gQqhnQ2vfiETEIKwDPA0R0=
X-Received: by 2002:a05:6214:f6a:b0:6b5:413a:3f96 with SMTP id
 6a1803df08f44-6bb559bc83amr4875416d6.10.1722013229767; Fri, 26 Jul 2024
 10:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-2-zijianzhang@bytedance.com> <ZqLE-vmo_L1JgUrn@google.com>
 <6b977a8c-d984-4d1a-b33d-15e2e875602c@bytedance.com>
In-Reply-To: <6b977a8c-d984-4d1a-b33d-15e2e875602c@bytedance.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 26 Jul 2024 10:00:15 -0700
Message-ID: <CAHS8izPsK_+WffSBiaEEc7cb44dapure=L=1zhLWkjxAy9cpwA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user
 space in sendmsg
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, 
	willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com, 
	xiaochun.lu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 4:51=E2=80=AFPM Zijian Zhang <zijianzhang@bytedance=
.com> wrote:
...
> >> -static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sy=
s,
> >> -                       unsigned int flags, struct used_address *used_=
address,
> >> +static int sendmsg_copy_cmsg_to_user(struct msghdr *msg_sys,
> >> +                                 struct user_msghdr __user *umsg)
> >> +{
> >> +    struct compat_msghdr __user *umsg_compat =3D
> >> +                            (struct compat_msghdr __user *)umsg;
> >> +    unsigned int flags =3D msg_sys->msg_flags;
> >> +    struct msghdr msg_user =3D *msg_sys;
> >> +    unsigned long cmsg_ptr;
> >> +    struct cmsghdr *cmsg;
> >> +    int err;
> >> +
> >> +    msg_user.msg_control_is_user =3D true;
> >> +    msg_user.msg_control_user =3D umsg->msg_control;
> >> +    cmsg_ptr =3D (unsigned long)msg_user.msg_control;
> >> +    for_each_cmsghdr(cmsg, msg_sys) {
> >> +            if (!CMSG_OK(msg_sys, cmsg))
> >> +                    break;
> >> +            if (cmsg_copy_to_user(cmsg))
> >> +                    put_cmsg(&msg_user, cmsg->cmsg_level, cmsg->cmsg_=
type,
> >> +                             cmsg->cmsg_len - sizeof(*cmsg), CMSG_DAT=
A(cmsg));
> >
> > put_cmsg() can fail as far as I can tell. Any reason we don't have to c=
heck for
> > failure here?
> >
> > What happens when these failures happen. Do we end up putting the ZC
> > notification later, or is the zc notification lost forever because we d=
id not
> > detect the failure to put_cmsg() it?
> >
>
> That's a good question,
>
> The reason why I don't have check here is that I refered to net/socket.c
> and sock.c. It turns out there is no failure check for put_cmsgs in
> these files.
>
> For example, in sock_recv_errqueue, it invokes put_cmsg without check,
> and kfree_skb anyway. In this case, if put_cmsg fails, we will lose the
> information forever. I find cases where sock_recv_errqueue is used for
> TX_TIMESTAMP. Maybe loss for timestamp is okay?
>
> However, I find that sock_recv_errqueue is also used in rds_recvmsg to
> receive the zc notifications for rds socket. The zc notification could
> also be lost forever in this case?
>
> Not sure if anyone knows the reason why there is no failure check for
> put_cmsg in net/socket.c and sock.c?
>

I don't know to be honest. I think it's fine for the put_cmsg() to
fail and the notification to be delivered later. However I'm not sure
it's OK for the notification to be lost permanently because of an
error?

For timestamp I can see it not being a big deal if the notification is
lost. For ZC notifications, I think the normal flow is that the
application holds onto the TX buffer until it receives the
notification. If the notification is lost because of an error,
wouldn't that cause a permanent memory leak in the application?

My humble opinion is try as much as possible to either fully deliver
the notification or to save the notification for a future syscall, but
not to lose it. But, I see that no other reviewers are calling this
out, so maybe it's not a big deal and you shouldn't change anything.

> > This may be a lack of knowledge on my part, but i'm very confused that
> > msg_control_copy_to_user is set to false here, and then checked below, =
and it's
> > not touched in between. How could it evaluate to true below? Is it beca=
use something
> > overwrites the value in msg_sys between this set and the check?
> >
> > If something is overwriting it, is the initialization to false necessar=
y?
> > I don't see other fields of msg_sys initialized this way.
> >
>
> ```
> msg_sys->msg_control_copy_to_user =3D false;
> ...
> err =3D __sock_sendmsg(sock, msg_sys); -> __sock_cmsg_send
> ...
> if (msg && msg_sys->msg_control_copy_to_user && err >=3D 0)
> ```
>
> The msg_control_copy_to_user maybe updated by the cmsg handler in
> the function __sock_cmsg_send. In patch 2/3, we have
> msg_control_copy_to_user updated to true in SCM_ZC_NOTIFICATION
> handler.
>
> As for the initialization,
>
> msg_sys is allocated from the kernel stack, if we don't initialize
> it to false, it might be randomly true, even though there is no
> cmsg wants to be copied back.
>
> Why is there only one initialization here? The existing bit
> msg_control_is_user only get initialized where the following code
> path will use it. msg_control_is_user is initialized in multiple
> locations in net/socket.c. However, In function hidp_send_frame,
> msg_control_is_user is not initialized, because the following path will
> not use this bit.
>
> We only initialize msg_control_copy_to_user in function
> ____sys_sendmsg, because only in this function will we check this bit.
>
> If the initialization here makes people confused, I will add some docs.
>

Thanks for the explanation. This looks correct to me now, no need to
add docs. I just missed the intention.

> >>
> >>      if (msg_sys->msg_controllen > INT_MAX)
> >>              goto out;
> >> @@ -2594,6 +2630,14 @@ static int ____sys_sendmsg(struct socket *sock,=
 struct msghdr *msg_sys,
> >>                             used_address->name_len);
> >>      }
> >>
> >> +    if (msg && msg_sys->msg_control_copy_to_user && err >=3D 0) {
> >> +            ssize_t len =3D err;
> >> +
> >> +            err =3D sendmsg_copy_cmsg_to_user(msg_sys, msg);
> >> +            if (!err)
> >> +                    err =3D len;
> >
> > I'm a bit surprised there isn't any cleanup here if copying the cmsg to=
 user
> > fails. It seems that that __sock_sendmsg() is executed, then if we fail=
 here,
> > we just return an error without unrolling what __sock_sendmsg() did. Wh=
y is
> > this ok?
> >
> > Should sendmsg_copy_cmsg_to_user() be done before __sock_sendms() with =
a goto
> > out if it fails?
> >
>
> I did this refering to ____sys_recvmsg, in this function, if __put_user
> fails, we do not unroll what sock_recvmsg did, and return the error code
> of __put_user.
>
> Before __sock_sendmsg, the content of msg_control is not updated by the
> function __sock_cmsg_send, so sendmsg_copy_cmsg_to_user at this time
> might be not expected.
>

I see. I don't think sendmsg_copy_cmsg_to_user() should unroll
__sock_sendmsg(), but if possible for the notification not to be lost,
I think that would be an improvement.

--=20
Thanks,
Mina

