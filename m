Return-Path: <netdev+bounces-151827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1495E9F11F5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4438281006
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F991E379B;
	Fri, 13 Dec 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7GQ/RaT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA951E0B75
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107074; cv=none; b=iQCu8aozJigdvzevfyATOdLArIzOsjJNS1oF+FeFKVxAjPT0m/1JshVePKakhwgwnviWb8x+ZDpSkNxpyd40sp1PxfVZ0t9R128N8VKi2xvantY9AKXChGTL6AtgH/LxfjsFwz51KIQomwct/MTFaPi91FSO1XR4Md0hn1WuHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107074; c=relaxed/simple;
	bh=QCXgdhkDERJ2rRLlRniVcEhN3FryhAuCxfd5vHsGE7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGDtHqW5JgDoFITTgTAZSQ32vmu3g4BnAWxTfs2C5zROxnTdGTd/K7HOLrtR8/tFsMAU143FQOe4Sbgwfrfg2PWzFdRcbQp2jXK8R8OgSd1Ust/QuE4UQrtaay2PPYAg5t9s0Dru79B9mXv+izsde4u+MHZJBKqUye4KKNDWsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7GQ/RaT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734107071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Q6uvET8CXBAXaVGA0hX8iMkV+39H9CqnaZqngLiQGk=;
	b=R7GQ/RaT87FN+ijSv4dvWLIE5PwGwFAHqnjX2xaDxadRS1gNXF9fk8agmnSfPdXi3kv0Jj
	RkJ/a9GZOxrksuP60esJ+2Km22sKKfKSXPUPad9zm4LMVZAYekmEcRiSm+Zi3kyvY0QB6U
	w0YZzGUo4Re9Qax4iz41AXluaZtuzrA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Ti-QuolgPXuHahtPldqH2Q-1; Fri, 13 Dec 2024 11:24:30 -0500
X-MC-Unique: Ti-QuolgPXuHahtPldqH2Q-1
X-Mimecast-MFC-AGG-ID: Ti-QuolgPXuHahtPldqH2Q
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6ef35527569so21104257b3.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 08:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734107069; x=1734711869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Q6uvET8CXBAXaVGA0hX8iMkV+39H9CqnaZqngLiQGk=;
        b=RqKhHK2YW6eErN7jc/8h186XGtfChY8FeueuUPm0Qy2FAyD2M1rYPSI/2DAGi81Uiv
         PKVuRQ7v4Ua6sf+RsTdCHDMAPX5iukq5i9jf6YhiMmL7NSMlTxOacQ+6w3JAIFGbpkBO
         1XBMfhJontsA70fpMQ8w4JDVS7eGFOVs2o1c4no4GsAPCzjXXuTSErbTwz3YFA8Uc+AZ
         L8N/mdEaUZMBYfmKCyhxo656LlIx68qcMpL4zfZuKOu86twzjSsjTnbw6LFJPBmOQUv8
         5tFglTXvJFP8dzHPIytI/jm4hv65z3XB+WDw1ZTVhmHXV1L0Y+0Fa0dduHhO4DUpkUvO
         mD2g==
X-Gm-Message-State: AOJu0Yz4WLfvoG9jzcNlWvz6GGGTI/RbYWPCSua7Uz4IAn7PwDaBVxmI
	EFu9etnciSUuA26Wcp+iWTKErWROhEOnkUyKJpUguTI04u9SZF6GzpYmu89CxAyAQsTko1uS7ku
	C8XP91TuNK0wJmT990UsmQ7An2QhE1qleilUSHWQvSPG+GZInqZLa0nR+0EygEGvGpHL2CZx70j
	sOnjZZg9sfG/JEe01nNbGCMQye3lL4SO0jeRmGCF4=
X-Gm-Gg: ASbGncsrIMI19oeG1K48CQ0e0iRUCUmIt5OyHfSw4TLWHPZM+yyKgTyA2mQ3IGlDjQJ
	9bN5SWpNqh4gRA9pmtneyScA74r8EnVPJ9Arv
X-Received: by 2002:a05:690c:61c2:b0:6ef:497f:65ae with SMTP id 00721157ae682-6f279b9deb2mr37286257b3.35.1734107069530;
        Fri, 13 Dec 2024 08:24:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTgJybroAPqTYKxvzvFv+qiHKb06ralLlcz/Cc/ZXzE6ZvZuOm4ystZuy5nnOXq47kM8clJ4tqO7DjonyBFEE=
X-Received: by 2002:a05:690c:61c2:b0:6ef:497f:65ae with SMTP id
 00721157ae682-6f279b9deb2mr37286027b3.35.1734107069168; Fri, 13 Dec 2024
 08:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-2-c31e8c875797@rbox.co> <uyzzicjukysdqzf5ls5s5qp26hfqgrwjz4ahbnb6jp36lzazck@67p3eejksk56>
 <a8fa27ad-b1f5-4565-a3db-672f5b8a119a@rbox.co> <jep457tawmephttltjbohtqx57z63auoshgeolzhacz7j7rwra@z2uqfegja6dm>
 <0bf61281-b82c-4699-9209-bf88ea9fdec5@rbox.co> <ghjvsagimzpok2ybcuo35t2bny3qsewl5xnbepur3b7f46ka6n@7horausgutui>
 <bff25039-1cba-4af9-9f6b-93bc0179fb92@rbox.co>
In-Reply-To: <bff25039-1cba-4af9-9f6b-93bc0179fb92@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 13 Dec 2024 17:24:17 +0100
Message-ID: <CAGxU2F5yvXMMwn0Zad8hE+jZC8PVdS+U0tpG7xQcSgEdKrwmyQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] vsock/test: Add test for accept_queue memory leak
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 5:15=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 12/13/24 15:47, Stefano Garzarella wrote:
> > On Fri, Dec 13, 2024 at 03:27:53PM +0100, Michal Luczaj wrote:
> >> On 12/13/24 12:55, Stefano Garzarella wrote:
> >>> On Thu, Dec 12, 2024 at 11:12:19PM +0100, Michal Luczaj wrote:
> >>>> On 12/10/24 17:18, Stefano Garzarella wrote:
> >>>>> [...]
> >>>>> What about using `vsock_stream_connect` so you can remove a lot of
> >>>>> code from this function (e.g. sockaddr_vm, socket(), etc.)
> >>>>>
> >>>>> We only need to add `control_expectln("LISTENING")` in the server w=
hich
> >>>>> should also fix my previous comment.
> >>>>
> >>>> Sure, I followed your suggestion with
> >>>>
> >>>>    tout =3D current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SE=
C;
> >>>>    do {
> >>>>            control_writeulong(RACE_CONTINUE);
> >>>>            fd =3D vsock_stream_connect(opts->peer_cid, opts->peer_po=
rt);
> >>>>            if (fd >=3D 0)
> >>>>                    close(fd);
> >>>
> >>> I'd do
> >>>             if (fd < 0) {
> >>>                     perror("connect");
> >>>                     exit(EXIT_FAILURE);
> >>>             }
> >>>             close(fd);
> >>
> >> I think that won't fly. We're racing here with close(listener), so a
> >> failing connect() is expected.
> >
> > Oh right!
> > If it doesn't matter, fine with your version, but please add a comment
> > there, otherwise we need another barrier with control messages.
> >
> > Or another option is to reuse the control message we already have to
> > close the previous listening socket, so something like this:
> >
> > static void test_stream_leak_acceptq_server(const struct test_opts *opt=
s)
> > {
> >       int fd =3D -1;
> >
> >       while (control_readulong() =3D=3D RACE_CONTINUE) {
> >               /* Close the previous listening socket after receiving
> >                * a control message, so we are sure the other side
> >                * already connected.
> >                */
> >               if (fd >=3D 0)
> >                       close(fd);
> >               fd =3D vsock_stream_listen(VMADDR_CID_ANY, opts->peer_por=
t);
> >               control_writeln("LISTENING");
> >       }
> >
> >       if (fd >=3D 0)
> >               close(fd);
> > }
>
> I'm afraid this won't work either. Just to be clear: the aim is to attemp=
t
> connect() in parallel with close(listener). It's not about establishing
> connection. In fact, if the connection has been established, it means we
> failed reaching the right condition.
>
> In other words, what I propose is:
>
> client loop             server loop
> -----------             -----------
> write(CONTINUE)
>                         expect(CONTINUE)
>                         listen()
>                         write(LISTENING)
> expect(LISTENING)
> connect()               close()                 // bang, maybe
>
> And, if I understand correctly, you are suggesting:
>
> client loop             server loop
> -----------             -----------
> write(CONTINUE)
>                         expect(CONTINUE)
>                         listen()
>                         write(LISTENING)
> expect(LISTENING)
> connect()                                       // no close() to race
> // 2nd iteration
> write(CONTINUE)
>                         // 2nd iteration
>                         expect(CONTINUE)
>                         close()                 // no connect() to race
>                         listen()
>                         write(LISTENING)
> expect(LISTENING)
> connect()                                       // no close() to race
>
> Hope it makes sense?
>

Sorry, it's Friday ;-P

Yep, now it makes sense, so please add a little comment that the goal
is to stress the race between connect() and close(listener).

Have a nice weekend,
Stefano


