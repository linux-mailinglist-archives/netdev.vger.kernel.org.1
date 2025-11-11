Return-Path: <netdev+bounces-237471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 459D2C4C419
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCAF3ABC86
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 08:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C628469A;
	Tue, 11 Nov 2025 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpqBmyyB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5E20297E
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848198; cv=none; b=KNlxdFFafRpiuDh+78TdgYE1+5ezY+qDLXEsWBBvcaUjKsIcJXJHZ6Iw1ZE4NWhOEGUn84J2HS7Pi3PVPP996G2y/tc+wwa5NE8Futms7w+mqbMi2KVQE+NFEy9edjgHyIN6M9h/vtkoMJIv0xAM/5bJLwjYPnjFCszVRVdbvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848198; c=relaxed/simple;
	bh=ThOitmR0pqJIaqOmdOvinYW0Io7CS1P5LLlQe5UDqLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hhe5do8Eh7gapDVb2MS5J4GtZSQpWUjjzNzd+McIOdWXjPfn/QSNQO1IMx7Gf4Y1bB27yIXtfUvL8U8Vk0iCCjw4py/8iqV98GBqlb+kKNFkxFPkTPEn/pAU5sFu7EaJ0OauV+siVflncKSiIXO6bjDX6xHrDp4TQxxpATBKPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpqBmyyB; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78802ac2296so9345337b3.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 00:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762848196; x=1763452996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZyrHQ2ZNrWsf8deWZQXT3ewHU4+uqpU/uLdHwVausY=;
        b=cpqBmyyBWMt1z9xyfQLvVg1q8h90DQZheaU5u2hSQS1PxJX739v/11ZcbPDt03LBFl
         FfF+EL2wfYqxUmDqA2RzXMSWUNsk8AHWb9OMttEx4ebpl7sEknh4PFvvZRhQogFTC5RN
         B6ocgdMfZ49c0MD1JddKWqe1vcoqOKCVRCHTvVh+g3G3et/Tgkh/R6FMJhoRdw0br14l
         mXKlwNiwC0T9LPsTx+ghqPMPrtaKGHpvxk8R7BMd4ZEGvi5rSCPFpo1J7izmuWlnwQvF
         7G98rfBnp83Mujpeg5dvck7y9n0BCfdmKlNyVoj+tDUdqX99Kq7hdsXD2yuooyN6GuB+
         kDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762848196; x=1763452996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZyrHQ2ZNrWsf8deWZQXT3ewHU4+uqpU/uLdHwVausY=;
        b=RvueoIVuJPiE+sS/zmY9tycBSPFF/LYC/6Ia5ojKJMnjVbwCRKumahs458cs6j2Ikn
         QG6LtPoneLc5ocXwVSlldxNunyhGdGwltFGmvUEyq7JvA3qBGb2wYUHXo6ap5gi1QlEH
         ZfmuewrhxLDjCb8yegEqDzDLzvhn7RN322EaKfDbY2skAEr/Z9IQ1meCbyUlFgQqRsav
         6pQCq8TxWTfLFQ/rj5+DnlBHEcihlE0fOvFkTsaM+DsmwcdkVO5nvAM99R0YYS9UbwhX
         O6AG9TjPo38LN6jCKUQP/xM+zQMpj+DiMtMY4Dm9JS2KzIYRG/NtI9WtLQcO+ys3mzoc
         OsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvULL6m94XMEGrmSv6nNB45PLCInVaBVpPBhlEmGQxqFsekPwiN09jo53Me1iWHOJCypJGdpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLvesl77z8l50O8N2zRYlgUfOZXaJST3xMAk/pDP3gEnBTX119
	FZCjztkOy4bbPcrFvSL9ROst1MtIOqr7d3OFvzOXWPYioZA3aHAAuL/CCF3gi5HlBMMbTyEx/kz
	JC9TQarhMZXXTr3AW5Bzhn0plhhev344=
X-Gm-Gg: ASbGnctQbMaB/they0HDhFngjtVS+mFP46noPYDT6t3/ULlPScWkTCBvI5HxpeF+QLO
	5fL1samSVZgCKuw3AA09M5c7w6WUh29jpr4UMnWyvm8mM5Je8aVkkIeh2KjSnqE/tzyfcyhQjft
	iiVBprNrqrt4/A6oDcnYg94KbK3gEm4CPXaOac5JM5oODNceg8088pn0TbNo1DVVhJ6WQBlrNsZ
	wp//FokdBsLQlzMG2V3KsAYFPxVZiyfyiIOFpbBJIQpl089pNhg7NMcANK+wWcAdeLYHK3QFCle
	PFEvDL8SbkyyTqkoMonco9aiHs62Jvo4BQtKVQ==
X-Google-Smtp-Source: AGHT+IFAhbvzkQ9NSKa3Q0SqSvzUgs7xGbWkTpZuApSHT4cWQ6HoS8R5Pc/WoeUwcDLZzMfWOkj1AgggKlOAJPopPo4=
X-Received: by 2002:a05:690c:4d09:b0:786:58c4:7a21 with SMTP id
 00721157ae682-787d5475313mr103408897b3.69.1762848195815; Tue, 11 Nov 2025
 00:03:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030064736.24061-1-dqfext@gmail.com> <2516ed5d-fed2-47a3-b1eb-656d79d242f3@samba.org>
 <10da0cb9-8c92-413d-b8df-049279100458@samba.org>
In-Reply-To: <10da0cb9-8c92-413d-b8df-049279100458@samba.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 11 Nov 2025 16:03:03 +0800
X-Gm-Features: AWmQ_bndi8ZMmxydevjeR7lvaNCCS_suACy4WTu-4G55naBoG07uf9BJv13cSCk
Message-ID: <CALW65jav2wiWzz6q6vdnjL88GJB1eWJtLVzH3M1CkOHbdgSDWw@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: server: avoid busy polling in accept loop
To: Stefan Metzmacher <metze@samba.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Tue, Nov 11, 2025 at 3:16=E2=80=AFPM Stefan Metzmacher <metze@samba.org>=
 wrote:
> >> Also remove:
> >>    - TCP_NODELAY, which has no effect on a listening socket.
> >>    - sk_rcvtimeo and sk_sndtimeo assignments, which only caused accept=
()
> >>      to return -EAGAIN prematurely.
> >
> > Aren't these inherited to the accepted sockets?
> > So we need to apply them to the accepted sockets now
> > instead of dropping them completely?

You're right, TCP_NODELAY of a new accepted socket is inherited from
the listen socket, so it should not be removed.

>
> Actually the timeouts are added to the client connection,
> but not the TCP_NODELAY.
>
> But looking at it more detailed I'm wondering if this might
> introduce a deadlock.
>
> We have this in the accepting thread:
>
>          while (!kthread_should_stop()) {
>                  mutex_lock(&iface->sock_release_lock);
>                  if (!iface->ksmbd_socket) {
>                          mutex_unlock(&iface->sock_release_lock);
>                          break;
>                  }
>                  ret =3D kernel_accept(iface->ksmbd_socket, &client_sk, 0=
);
>                  mutex_unlock(&iface->sock_release_lock);
>                  if (ret)
>                          continue;
>
>
> And in the stopping code this:
>
>          case NETDEV_DOWN:
>                  iface =3D ksmbd_find_netdev_name_iface_list(netdev->name=
);
>                  if (iface && iface->state =3D=3D IFACE_STATE_CONFIGURED)=
 {
>                          ksmbd_debug(CONN, "netdev-down event: netdev(%s)=
 is going down\n",
>                                          iface->name);
>                          tcp_stop_kthread(iface->ksmbd_kthread);
>                          iface->ksmbd_kthread =3D NULL;
>                          mutex_lock(&iface->sock_release_lock);
>                          tcp_destroy_socket(iface->ksmbd_socket);
>                          iface->ksmbd_socket =3D NULL;
>                          mutex_unlock(&iface->sock_release_lock);
>
>                          iface->state =3D IFACE_STATE_DOWN;
>                          break;
>                  }
>
>
>
> I guess that now kernel_accept() call waits forever holding iface->sock_r=
elease_lock
> and tcp_stop_kthread(iface->ksmbd_kthread); doesn't have any impact anymo=
re
> as we may never reach kthread_should_stop() anymore.
>
> We may want to do a kernel_sock_shutdown(ksmbd_socket, SHUT_RDWR) after
> tcp_stop_kthread(iface->ksmbd_kthread); but before mutex_lock(&iface->soc=
k_release_lock);
> so that kernel_accept() hopefully returns directly.
> And we only call sock_release(ksmbd_socket); under the iface->sock_releas=
e_lock mutex.

In kernel v6.1 or later, kthread_stop() in tcp_stop_kthread() will
send a signal to the ksmbd kthread so accept() will return -EINTR.
Before v6.1 it can actually get stuck, as accept() will block forever.

If you're fixing the issue when this patch was backported to versions
before v6.1, this will not work, because kthread_stop() blocks until
the target kthread returns, so shutdown() will never get called. The
sock_release_lock mutex seems redundant because of that.
Instead, shutdown() can be called _before_ kthread_stop() so accept()
will return -EINVAL.

Namjae, should I send a v2 with both issues addressed?

-- Qingfang

