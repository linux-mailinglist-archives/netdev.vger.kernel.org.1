Return-Path: <netdev+bounces-118811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3D2952D47
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C897283E65
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4303B1AC8AB;
	Thu, 15 Aug 2024 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOj422S5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE111762D2;
	Thu, 15 Aug 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720491; cv=none; b=Hp3xD9YZkkUn7l5ucjys28IrEybRMdSMfWssIQ9MzyHD32EgmTuiNGZOnuVlEWQ7uemadzvBwYump7gOI6WLwXN0k8mhLrg45Ewn/lHmI9ZsZOX9VRJrXF81+s4qtcfIyyVWr91botjB3ud1ORyzhl8DzEK+13x3o+DGeIXsVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720491; c=relaxed/simple;
	bh=GDQwlN5DPjWLrOlb1hR+0b7VhuI05ISKwqDKJnGLKmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvtBLAAmDVZUWP22C6Dq0opG+HTMM5FTSgjOO+KDyHkyXxhcxmN/qOjofMWv7rZ3dr6qnl2dWFYVZHHR0EfZMPebEcmk7zkOULjm/asof7MQ2Yl58y7Q5gqxXNhiAuLLS7ShXeQVzjpecslpFrAxrD7JG0tcodY8WZXZXRfcxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOj422S5; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d2044b522so1413615ab.0;
        Thu, 15 Aug 2024 04:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723720489; x=1724325289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPIOn7129p2dyKplSo6WC4fI7U6Ls3jk9rLb4+oP4dQ=;
        b=WOj422S5q5aVAV+RTHpeEn7KYBDwTgkvcEXv5oCDcJP7/07XLN5QA5wNANi8KCzI2V
         rgtYtYphK5ki6mW8o7BN2XJGjDkh5CJsUDP00qKjvX67uB1El76nc2DTbBX1s3Awde54
         ygNPpNU9J7ANefZzOwz9xrHhBCvMVqpuyrk1CYbr3xk5uk+T697fe+PLoDtA7ToU45hW
         eV0J8SMZimoyiOh5dCz1iIcS3fAMCxazagh6928FsVPI6k7So/UXQOvt/+Yj4CN0zABn
         +Iym4DiM0F12RouR8oOLDW4WzpHKquSFYh6L0xW6bDoBYkVCMVWE864DGLvk6ieWatGG
         nvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723720489; x=1724325289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPIOn7129p2dyKplSo6WC4fI7U6Ls3jk9rLb4+oP4dQ=;
        b=t8XqPt7N7LrlWe8XFxI7MvkM1IBiw63hmbJMPCvLAILBoNQLbspd6FYJXD9PKJhfIs
         sor87jIkipJCpIQlBM8FV+Gkc4EPsELjEX9rYzmx99W58u+cjcGQNjhflBnVhgifx7aB
         xzECA0mJn1x97nKT8hdNCNAZFpl7w6MwDXy3Gj0/my/R9D2zN3qeJlwzjoKKPi9iSqiN
         wkPiuxZ/NyxdQVFTmOh5Oi8rjPU5qgMqHKqDpo/DsTreENaanqCV1zmpKhP/ehSO1l4x
         g0bu+tOVSePEqDH2beE5qeABSiNu8QIDisrrMpwAAxQhdtQUtH6+NQh5xqLeR7x2Q8Oh
         KwNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6zNKdN2z4tlTUz/+7nNv14Oesj2bzDXCw7X4n+pfg71X4ioYXjsI7DZUQiaqrXJFEBs/Qweolhd6PtCwPRB1esKCG1LYVA13anThxsG43Xwxqlt8ZNA8G0Z6gxq5QN860g00k
X-Gm-Message-State: AOJu0YyWa0BbKmR5FBjeX3TQgPtq89rTYIaRRXZpnU68KICrb6RDQOo3
	gaK3Nrkw8/4T8pMjljXyWC23TJ4h4GiSmmUDt3BUTx5DB31005h6vA3Lr4+5tdhT64GUcE3R8xK
	+X60W/5HgMzbjswuKN4YulV7YIq0=
X-Google-Smtp-Source: AGHT+IEik4rI3kn6FSE1vHzjXlCzOg8h0UUb3T66oT/jPtVM2UzsUge3gyscSDqqpLt6pxlRvX22u3ofCsx7q7Y59ss=
X-Received: by 2002:a92:cd85:0:b0:39b:640e:c5fa with SMTP id
 e9e14a558f8ab-39d124bfc29mr77735875ab.19.1723720488814; Thu, 15 Aug 2024
 04:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815084907.167870-1-sunyiqixm@gmail.com>
In-Reply-To: <20240815084907.167870-1-sunyiqixm@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Aug 2024 19:14:12 +0800
Message-ID: <CAL+tcoBw1CKpPDkbiNGrrUFiqBEhHHx9vWhqfpfV1bbu3F1i5A@mail.gmail.com>
Subject: Re: [PATCH] net: do not release sk in sk_wait_event
To: sunyiqi <sunyiqixm@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:50=E2=80=AFPM sunyiqi <sunyiqixm@gmail.com> wrote=
:
>
> When investigating the kcm socket UAF which is also found by syzbot,
> I found that the root cause of this problem is actually in
> sk_wait_event.
>
> In sk_wait_event, sk is released and relocked and called by
> sk_stream_wait_memory. Protocols like tcp, kcm, etc., called it in some
> ops function like *sendmsg which will lock the sk at the beginning.
> But sk_stream_wait_memory releases sk unexpectedly and destroy
> the thread safety. Finally it causes the kcm sk UAF.
>
> If at the time when a thread(thread A) calls sk_stream_wait_memory
> and the other thread(thread B) is waiting for lock in lock_sock,
> thread B will successfully get the sk lock as thread A release sk lock
> in sk_wait_event.
>
> The thread B may change the sk which is not thread A expecting.
>
> As a result, it will lead kernel to the unexpected behavior. Just like
> the kcm sk UAF, which is actually cause by sk_wait_event in
> sk_stream_wait_memory.
>
> Previous commit d9dc8b0f8b4e ("net: fix sleeping for sk_wait_event()")
> in 2016 seems do not solved this problem. Is it necessary to release
> sock in sk_wait_event? Or just delete it to make the protocol ops
> thread-secure.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://syzkaller.appspot.com/bug?extid=3Db72d86aa5df17ce74c60
> Signed-off-by: sunyiqi <sunyiqixm@gmail.com>
> ---
>  include/net/sock.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index cce23ac4d514..08d3b204b019 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1145,7 +1145,6 @@ static inline void sock_rps_reset_rxhash(struct soc=
k *sk)
>
>  #define sk_wait_event(__sk, __timeo, __condition, __wait)              \
>         ({      int __rc, __dis =3D __sk->sk_disconnects;                =
 \
> -               release_sock(__sk);                                     \
>                 __rc =3D __condition;                                    =
 \
>                 if (!__rc) {                                            \
>                         *(__timeo) =3D wait_woken(__wait,                =
 \
> @@ -1153,7 +1152,6 @@ static inline void sock_rps_reset_rxhash(struct soc=
k *sk)
>                                                 *(__timeo));            \
>                 }                                                       \
>                 sched_annotate_sleep();                                 \
> -               lock_sock(__sk);                                        \

Are you sure that you want the socket lock to be held possibly for a
really long time even if it has to wait for the available memory,
which means, during this period, other threads trying to access the
lock will be blocked?

Thanks,
Jason

