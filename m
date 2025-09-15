Return-Path: <netdev+bounces-223206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28266B584F5
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 20:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4D7165304
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0C827B33F;
	Mon, 15 Sep 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="delKi561"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D527AC4C
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962281; cv=none; b=W4zTbRDDk1+5zDSxL5XybOTu2fH2QtaNOiFpznkUooQJN2yFVxGQYeeXyEXwQQY3ZpQ2Zg2kexXnnUcATn3BJtwMNobGHQXmVCJm41pbBhdAXgtgWMtVGz0PnbORVXJu3cm7U9700q4NSEoPwLt9YcApvXHLbhoFG6DvUivKqwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962281; c=relaxed/simple;
	bh=EYfQqCrGPcjSgomT9rg3gXhdBKIcZst3rfabT7wp9qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfbnQyEMHDDZp3LKyECUuZgcVK14z88343aJb8j/qv8iOzdP/DJnwt3BMpqQS3MWwermAGJQFpd5tmEpny2XDV88OB6mXsbMiwHc+mfRqCZgPo8iF8p3DaxqANJ3RolmCyy8USR5ch02LQeMuCmxapmm20W/foZNRiGq4l2HTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=delKi561; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b794e9a850so24460381cf.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 11:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757962279; x=1758567079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WShWOhGY/skYh9+nV4tXElAGqsrOOQkQwBZirkxU5zM=;
        b=delKi561ZZrhueQuiWbJ5zgE8RDrFxEY5MTnfqnCG02YRzFRIXSu4rnD54NGkFffxw
         IVSlGRk0y+3+q3VRaqTW/VNeVLxf5YQtlMBaFfcCBnuSjh00uuzKaSVRDOJsK1KUvXkk
         Mmj3azu0L+P3fEIOumkKbd45at63idTmBY+Lz7l0oOifNesWePLQgZFmg8cxVcLultA8
         uui8yfDZZttYy+I2PUCj4tAhG3twImKQSO95v1m+Bo76xoxvXCZ24EdEU+59FB3m3fWG
         UOEDNpYZVJNKYCDVCPWspx3yvmDlK3WcWb+9pRYxVmjA8SbaGEB6Dpz/U2Vqf+jv90EC
         /U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757962279; x=1758567079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WShWOhGY/skYh9+nV4tXElAGqsrOOQkQwBZirkxU5zM=;
        b=TqT+uhoUJ/dK06v2vPwhpO4EKNcfAxaQbwhdYat8jbHRCQgVrcD87nXGkbxF5yn0BW
         w5IYyYdCPFVju/lRSbZTvCjzeGbnH77PBMg3Jz8aVxye9hLwl68USx+l44oalmaL5ImD
         jpqLJP1jkdeDWRyMI2TaYbM3bmiSXc13qOKxrIfFlSIKiBfgz5uCsdtgS7rF5Q7dyWhj
         udmRtMOOe5nEjSSLFdho+ZyXWqKW3mOEPfIhPm7oGsXchx768ZBEWWgQ2BO77vmWrAAq
         khXwoviGpRKVfbgvdriUUmi2GR5cWZYlhBiiQvKi4Iv+eI3fRI9Sv+35mHMthBGFXUff
         C1ug==
X-Forwarded-Encrypted: i=1; AJvYcCWVQZdpGYieeekA3ZnjinyeJ30YCNYNR+AxFDP6IBBfXENYGjboLNQsVuEVeA2dUl9I3FsoFo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzB2rFdLJHBun1fLugs7XgmAXHVKdo+rrscjYcAJzKP9cwwo8Y
	rbeQtg1oZPb4QcR8OJ5dF271bJDx+YRkJzsB3t9p7DDjmZgoCcjK/69S144vpw2GdIZhhOGAhJa
	/tATKeYwhLRmd5GbGm6q2pbT7Y5x1k730ZQom9uJy
X-Gm-Gg: ASbGncuoiiYVdJmU8l7G5WQBC0L6/zhjwE7uUKYcML2mEK8swaIH6GNv0RwQgNuUY7p
	zSQxqfrtiwzYtcdV045Z7xyPiIGtrM0G2eWirj1UJ5wIrbXnoiZwSDzUR/KBlgrKVC8DSc8v85+
	03hFLK7sdmzZv11qSLCuiGAL0CfCEJD2qfyUJtn8w4mKJCAAc+f23gBFJNcdYgvjgGB2TXALkY5
	/S8J4nNyqGHtRthp43tk0F8xQ==
X-Google-Smtp-Source: AGHT+IFjUCeEE0y/NFQXZIC55q7MH10C1akHJbFsr2uMonEEN/PfeMP/MIECIDR0lj1PvDZ0Fm+pC8xrHgT1TfV+geY=
X-Received: by 2002:a05:622a:428d:b0:4b6:2336:7005 with SMTP id
 d75a77b69052e-4b77d08c1dfmr136573251cf.19.1757962278219; Mon, 15 Sep 2025
 11:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902183603.740428-1-edumazet@google.com> <aMhX-VnXkYDpKd9V@google.com>
In-Reply-To: <aMhX-VnXkYDpKd9V@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Sep 2025 11:51:06 -0700
X-Gm-Features: Ac12FXzpLmWmVQTNknGIkZPBR5z4hsV9Oa7GnxjhFHJZhh1j3eL2S9eC_zeB7pk
Message-ID: <CANn89iJOHzk+Sj+3c2PRywQaOMrqpxyodeSbkZ4++5E9xvnTpA@mail.gmail.com>
Subject: Re: [PATCH net] net: lockless sock_i_ino()
To: Andrei Vagin <avagin@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 11:16=E2=80=AFAM Andrei Vagin <avagin@google.com> w=
rote:
>
> On Tue, Sep 02, 2025 at 06:36:03PM +0000, Eric Dumazet wrote:
> > @@ -2056,6 +2058,10 @@ static inline int sk_rx_queue_get(const struct s=
ock *sk)
> >  static inline void sk_set_socket(struct sock *sk, struct socket *sock)
> >  {
> >       sk->sk_socket =3D sock;
> > +     if (sock) {
> > +             WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
> > +             WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
> > +     }
>
> Hi Eric.
>
> This change breaks CRIU [1]. The issue is that socket_diag reports two
> sockets with the same inode number. It seems inet_csk_clone_lock copies
> sk->sk_ino to child sockets, but sk_set_socket doesn=E2=80=99t reset it t=
o zero
> when sock is NULL.

Hi Andrei, thanks for the report.

Could you test this patch ?

diff --git a/include/net/sock.h b/include/net/sock.h
index 0fd465935334160eeda7c1ea608f5d6161f02cb1..36e11b2afb223bf18ff0596d634=
e885cca549d0f
100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2063,6 +2063,9 @@ static inline void sk_set_socket(struct sock
*sk, struct socket *sock)
        if (sock) {
                WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
                WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
+       } else {
+               /* Note: sk_uid is unchanged. */
+               WRITE_ONCE(sk->sk_ino, 0);
        }
 }

@@ -2084,8 +2087,6 @@ static inline void sock_orphan(struct sock *sk)
        sock_set_flag(sk, SOCK_DEAD);
        sk_set_socket(sk, NULL);
        sk->sk_wq  =3D NULL;
-       /* Note: sk_uid is unchanged. */
-       WRITE_ONCE(sk->sk_ino, 0);
        write_unlock_bh(&sk->sk_callback_lock);
 }

