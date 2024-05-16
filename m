Return-Path: <netdev+bounces-96736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7398C77E9
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 15:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E175E1C22386
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8155147C6E;
	Thu, 16 May 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1j/yxnd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAF1474DA
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867149; cv=none; b=drjKZTfUzz7EFhJpdiEoJk0d/h1/qN2KsKF5S/8KQNNtFWCztx9eaSGKtr2gC0xsOuJjyU6HfBO/2d3Hp78zv38EGn7AhVe/55lwHV/zAjuK4eRuSqj086J1yVnhBiZV2LMmDhLdJofwjuB38FRvOJp5dQkyn50h8QHXkQodN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867149; c=relaxed/simple;
	bh=cYo/nT8qQDC03xw+GHMsNdNJFVkts/EufyugSZPYN3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Np12LkqXpX+7jXqyFLOhedh6xIBnGoUAaKBJ+KB34m7o3Lsx5+Kg34ohxD4f8MW5616hFZUQH63hmpn1EXgPqygcsscb8wQUPBlv0J0Nv+7XOSncviJKrJvdUVGYBDWZA0G6RaWlwBTImY20eYiBF76BuMrfWdOCOi7sCbniHVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1j/yxnd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715867146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50YV4doU4hotrim85PHUofwG7EON94IM6vTruab4+zc=;
	b=d1j/yxndBtlnak7HQP+vesJoXn2rFFXFSp8UjuktUQZQq5crwXdFjYTBdf955PojpWHtCC
	R7WuAaWVZmD/cHs1sclI/WG7NhICNnY4K1g7QJaZ6XaleqdjROkKXpwt6/AcERCs7cY2vM
	uUmLAUdXquL7BhguVD6+C5oweE9nRjA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-jNw52OLENa2lV0iJbvG2Ow-1; Thu, 16 May 2024 09:45:44 -0400
X-MC-Unique: jNw52OLENa2lV0iJbvG2Ow-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2b2738ce656so6882007a91.0
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 06:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715867140; x=1716471940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50YV4doU4hotrim85PHUofwG7EON94IM6vTruab4+zc=;
        b=kTspK4S6gzLD7QdqQ7bs/x8DaAqIaq631M1+q+hYdBv3jhDEXTaXCBAVzCR168nY2Z
         2YbzLfYK6yNZ5WB3uR03DnSzv0JdvN0lmkPBePQojBnw2el8CX9wEE0ItGtVXKlnWW6D
         oMeWIbG38My64J6DHUi5CFZMjym0dKJ1ovIrsbNwccDbOL78v5dD1loisBm/nu3dAz4q
         eo6OB/YvfBqR1UUZImNWZcFSGQGNcjB8x4x2FSQyQ8HMvt75Q9TfRYt808I6Ad3xHT8Y
         Wkdziac9rO9/Y/lmkHcLaINnptjxld5W5jVQtp/XqnVhqA6sPuuUd46u0nA669taC1XX
         sCRw==
X-Gm-Message-State: AOJu0Yx2MMVGB/AFqPb093n8GmSsl8TDA9ED3LGawrVUOepm66b40HGi
	bZ/hHRNJYyuGPq8vhwn/ydITuTSRaLQwJCZtOMK5HhbluO9+KxcxzE5zfxg9cNDBXNE94djtESK
	LIjoRxuqE916FBzh6+GEldEOGRccg4jZKKboFzU95U4pkde6MA5M5lfgV8yvK1N4jcsYh6kCxoV
	7NytSoNwdtQZc0+VVJ6mK9Qxqro+r4
X-Received: by 2002:a17:90a:a10d:b0:2a5:badb:30ea with SMTP id 98e67ed59e1d1-2b6ccd76d85mr15980302a91.36.1715867139886;
        Thu, 16 May 2024 06:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZPNaeWcVsWqCiEobZXcjnuR4f6EwP5sGhEIOxK97tKsPzuoSWjvq9Z02ox1q+mfONfFWCNhfgXTPZnTJjNn4=
X-Received: by 2002:a17:90a:a10d:b0:2a5:badb:30ea with SMTP id
 98e67ed59e1d1-2b6ccd76d85mr15980262a91.36.1715867139289; Thu, 16 May 2024
 06:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516133035.1050113-1-houtao@huaweicloud.com> <dbb75bc2-cb09-79e9-2227-16adf957ae05@huaweicloud.com>
In-Reply-To: <dbb75bc2-cb09-79e9-2227-16adf957ae05@huaweicloud.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Thu, 16 May 2024 15:45:26 +0200
Message-ID: <CAKa-r6u=FiCxzQ0FF-XMdNjEA=LZZ+m-yMZ1KXT9wqMiX2gkPg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: unregister root_lock_key in the error path of qdisc_alloc()
To: Hou Tao <houtao@huaweicloud.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Hou Tao,

On Thu, May 16, 2024 at 3:33=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Oops. Forgot to add the target git tree for the patch. It is targeted
> for net- tree.
>
> >
> > diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> > index 31dfd6c7405b0..d3f6006b563cc 100644
> > --- a/net/sched/sch_generic.c
> > +++ b/net/sched/sch_generic.c
> > @@ -982,6 +982,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_=
queue,
> >
> >       return sch;
> >  errout1:
> > +     lockdep_unregister_key(&sch->root_lock_key);
> >       kfree(sch);
> >  errout:
> >       return ERR_PTR(err);
>

AFAIS this line is part of the fix that was merged a couple of weeks
ago, (see the 2nd hunk of [1]). That patch also protects the error
path of qdisc_create(), that proved to make kselftest fail with
similar splats. Can you check if this commit resolves that syzbot?

thanks a lot!
--=20
davide

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/com=
mit/?id=3D86735b57c905


