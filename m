Return-Path: <netdev+bounces-157929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE960A0FD55
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BCF3A1480
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 00:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCE9F9C1;
	Tue, 14 Jan 2025 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3pAENvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412615695
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736814052; cv=none; b=Poi0kCM/sShpXCmYUD/x+lnATC1P7BjJNlgLYOfDkBee7pI9NqhrUBHoKt15qbI/akk/TrNjEUdm9gZTirg9mSZrMopOkUKozVdEB0vipYtno0Ar3wQbenA0BMpevXMNNku/pdtDqcwm/MOqtB7DFllGTnU/TVgIkN9sfnCAlag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736814052; c=relaxed/simple;
	bh=i9AuLtJMqZF9D9n0r0umZkbbJ+/h2JvNMDbbUFGXlvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXfAA/tz/Dy39haTG1v0bqWD4pNKeoRUBD9sHjVKM5jMPsX26HcbQZJcQEZEtnNYy28zrm5Z6ee9TgbFU+cQ4C37nvnS61FQ9cSzJQyftxmNT9Srsrm1qiz7WuV8deIO2qmwjLv2mJd/g38XBjtsgJlmen5wySH4/ZjCFOz23A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3pAENvZ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ce4b009465so18621885ab.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 16:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736814050; x=1737418850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMfKKOquvY6HOEZToorLOFGY/Zv6qMN+WRRzroLexa8=;
        b=I3pAENvZ9onk4yLc6jj78bdS5s2+o80iiY5LkRN46zWR9HWslh1jfqUcoNT4sTCQju
         DfZJN6eKhns834EZq1E2BrwBknbpjqtRFvcF68/JssiuoYF+FFGQU0TtxqCr84y8TZYO
         3ncUbLIkri/+Rahbu9vFn2hPxRJZnWuJidG+M9m8FNRHnc8PPBOIQDMKQUlajIkk73fR
         sQNgZRNszv2EhO0LbyQoBE3qEtd00heTvJQlScH8nkNBhM3BywGKnW7fMr4WsjXKsMG/
         boQOJkzh0uNzcq/2DoCL2Gv/u/K3PlcIGGSrXMFNvHwiwaHQRhCaecQYGQxy9Gxh51wQ
         pnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736814050; x=1737418850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMfKKOquvY6HOEZToorLOFGY/Zv6qMN+WRRzroLexa8=;
        b=cZI2FcbCg57ENuDs3itA+R4A++PV+3imaWcy9A577RkWXlStwuOZ1q2iuPVuU7bc7m
         GkzHLK70K831fzBq6HSwfE0R4tqNnP3yVXOniI3419wctYKc9Rqygc0QTJhJiot3MBK0
         qSfl8qvvKtz/9+8+5sSgwHfOUVa+upGh/BPcaPM6LBVvSmO3I2CvWyZzVeZNjmrtFr+F
         qV34rcY989IDzvIU0JaAmW8ZQcA+sG0REOnA7reb0nFWJqRW8Hy7Qv3b9ZXsi3GlM1a+
         jA6mMpq/KVCNu6xaR1U3Bk32UX53t8Qm4srco3qjxJjuDOBbzIqjPZl9lbt3ZmMrLrdr
         Vlrw==
X-Forwarded-Encrypted: i=1; AJvYcCVh8ohDRUJ43Rh0LBRLv/KXoUTN49nJ9UmQ7aE/RpTJem3M/N23T4v8igz8TgMtAEkheGGOanU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHhyUzkMTqvO1GBdDXNjIVpZtQulOPBj9cX/BCjFyTGRgMqi1
	HmyTHZuulI4W50jn6FncseV+HI6qN0tOsnilQPoWj+e3cIDXb4HvIXpOSXfP6jC0ahWKALSPv0G
	tPu3+85ruvFF+rRFtqgqVrZr9OeU=
X-Gm-Gg: ASbGncsZtMtbka16q8sePx72ancBkWOGUpentCtfgTGEezxejgdgVuOBeGeNWlDlHrP
	yf0xGsVrGKcIy4BKe43w44vM8wjJ+oFHf8J6T
X-Google-Smtp-Source: AGHT+IGzH7RVAki2c1xn+I079wY6RUsqHc418QWljueYPlLH2Ry1CDs04GOnuQTU85XuotSTbsb/l4LsEmAzS6voZ6Y=
X-Received: by 2002:a92:c9c6:0:b0:3ce:64a4:4c44 with SMTP id
 e9e14a558f8ab-3ce64a44e2cmr56566205ab.1.1736814050215; Mon, 13 Jan 2025
 16:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106181219.1075-1-ouster@cs.stanford.edu> <20250106181219.1075-8-ouster@cs.stanford.edu>
 <20250110092537.GA66547@j66a10360.sqa.eu95> <CAGXJAmyYmizvm350vSGmJqdOt8d+d0soP95FGhBUQ5nr8kNqnw@mail.gmail.com>
 <CAL+tcoCOSk2ezZ+OnsKBZc_JcO_U01X1q3KmTd6WhObuzbuzsA@mail.gmail.com> <CAGXJAmzCx6NJGeHrW+CB6+Uc0_DDBMJRMzfCbCs3FNGcdBtX3w@mail.gmail.com>
In-Reply-To: <CAGXJAmzCx6NJGeHrW+CB6+Uc0_DDBMJRMzfCbCs3FNGcdBtX3w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 14 Jan 2025 08:20:14 +0800
X-Gm-Features: AbW1kvahszfA7wbvyW7-2D8BwPT7ZiWjTzxu3ouqAEKpR3VZYgiSii1RXYrdUpk
Message-ID: <CAL+tcoAOwxqQVrj3P7AcaB0FOtJZNwSM9iwwpFtic_RGrU8B2A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/12] net: homa: create homa_sock.h and homa_sock.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, netdev@vger.kernel.org, pabeni@redhat.com, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 1:12=E2=80=AFAM John Ousterhout <ouster@cs.stanford=
.edu> wrote:
>
> On Sat, Jan 11, 2025 at 12:31=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Sat, Jan 11, 2025 at 8:20=E2=80=AFAM John Ousterhout <ouster@cs.stan=
ford.edu> wrote:
> > >
> > > On Fri, Jan 10, 2025 at 1:25=E2=80=AFAM D. Wythe <alibuda@linux.aliba=
ba.com> wrote:
> > > >
> > > > > +void homa_sock_unlink(struct homa_sock *hsk)
> > > > > +{
> > > > > +     struct homa_socktab *socktab =3D hsk->homa->port_map;
> > > > > +     struct homa_socktab_scan *scan;
> > > > > +
> > > > > +     /* If any scans refer to this socket, advance them to refer=
 to
> > > > > +      * the next socket instead.
> > > > > +      */
> > > > > +     spin_lock_bh(&socktab->write_lock);
> > > > > +     list_for_each_entry(scan, &socktab->active_scans, scan_link=
s) {
> > > > > +             if (!scan->next || scan->next->sock !=3D hsk)
> > > > > +                     continue;
> > > > > +             scan->next =3D (struct homa_socktab_links *)
> > > > > +                             rcu_dereference(hlist_next_rcu(&sca=
n->next->hash_links));
> > > > > +     }
> > > >
> > > > I can't get it.. Why not just mark this sock as unavailable and ski=
p it
> > > > when the iterator accesses it ?
> > > >
> > > > The iterator was used under rcu and given that your sock has the
> > > > SOCK_RCU_FREE flag set, it appears that there should be no concerns
> > > > regarding dangling pointers.
> > >
> > > The RCU lock needn't be held for the entire lifetime of an iterator,
> > > but rather only when certain functions are invoked, such as
> > > homa_socktab_next. Thus it's possible for a socket to be reclaimed an=
d
> > > freed while a scan is in progress. This is described in the comments
> > > for homa_socktab_start_scan. This behavior is necessary because of
> > > homa_timer, which needs to call schedule in the middle of a scan and
> > > that can't be done without releasing the RCU lock. I don't like this
> > > complexity but I haven't been able to find a better alternative.
> > >
> > > > > +     hsk->shutdown =3D true;
> > > >
> > > > From the actual usage of the shutdown member, I think you should us=
e
> > > > sock_set_flag(SOCK_DEAD), and to check it with sock_flag(SOCK_DEAD)=
.
> > >
> > > I wasn't aware of SOCK_DEAD until your email. After poking around a
> > > bit to learn more about SOCK_DEAD, I am nervous about following your
> > > advice. I'm still not certain exactly when SOCK_DEAD is set or who is
> > > allowed to set it. The best information I could find was from ChatGPT
> > > which says this:
> > >
> > > "The SOCK_DEAD flag indicates that the socket is no longer referenced
> > > by any user-space file descriptors or kernel entities. Essentially,
> > > the socket is considered "dead" and ready to be cleaned up."
> >
> > Well, I'm surprised that the GPT is becoming more and more intelligent.=
..
> >
> > The above is correct as you can see from this call trace
> > (__tcp_close()->sk_orphan()). Let me set TCP as an example, when the
> > user decides to close a socket or accidently kill/exit the process,
> > the socket would enter into __tcp_close(), which indicates that this
> > socket has no longer relationship with its owner (application).
> >
> > >
> > > If ChatGPT isn't hallucinating, this would suggest that Homa shouldn'=
t
> > > set SOCK_DEAD, since the conditions above might not yet be true when
> > > homa_sock_shutdown is invoked.
> >
> > Introducing a common usage about SOCK_DEAD might be a good choice. But
> > if it's not that easy to implement, I think we can use the internal
> > destruction mechanism instead like you did.
> >
> > >
> > > Moreover, I'm concerned that some other entity might set SOCK_DEAD
> > > before homa_sock_shutdown is invoked, in which case homa_sock_shutdow=
n
> > > would not cleanup the socket properly.
> >
> > No need to worry about that. If it happens, it usually means there is
> > a bug somewhere and then we will fix it.
>
> I'm not quite sure what you are recommending in your comments above
> (i.e. should Homa try to use SOCK_DEAD or stick with the current
> approach of having a separate Homa-specific flag indicating that the

I didn't suggest specifically as I still need some time to take a deep
look into the implementation, only having offered some information
that you may be interested in. I will get back to you on this point
later.

> socket has been shutdown). Based on what I've heard so far I still
> prefer having a separate flag because it eliminates any possibility of
> confusion between Homa's use of SOCK_DEAD and the rest of Linux's use
> of it.
>
> I see now that SOCK_DEAD gets set (indirectly) by Homa when homa_close
> calls sk_common_release. However, this only happens when the fd is
> closed; hsk->shutdown gets set by homa_sock_shutdown, which can happen
> before the fd is closed. This seems to argue for a separate state bit
> for Homa's shutdown.
>
> -John-

