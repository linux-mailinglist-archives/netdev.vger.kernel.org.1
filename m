Return-Path: <netdev+bounces-129376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A4097F17A
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 22:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67791F2290C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 20:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D54198830;
	Mon, 23 Sep 2024 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nzFkAjdt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640F17BD6
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727121699; cv=none; b=WQpNis8ErsOwiE594D9RIfQCUfJo3Vpa5Np6D3nAOUXlVQuMR6azBjbyLIOSBdP7K3lVuqwNpCfYale/XxXAiiMYURZle7retUeH+4620/6gJilv3K+oW5trPsSI4XVsIyiKTDnubWAYLEjCW6PAcdoCD4z6Sj1Pxix+KSpdSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727121699; c=relaxed/simple;
	bh=e8AEaHRUWjDDtJxQBgPmr6ywT6bNUkAc6A0luPqVMNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bo8QyqWzN98qlhQaYZSQ6OWQkqnlpTo8FwWaB89LEXwg1ErL97PjxNmQrdXYVLlmqfNAjJCO3rBVr1b8eCsN0Z+n2/6yrmcAWy3UeQdnVTm4U6ws+INSp52NlyeGrbjQ6xA98TewpnzFyMcAbx2HckYCXQSNyDaIjxh6TCUVV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nzFkAjdt; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 232B54060E
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 20:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727121689;
	bh=e8AEaHRUWjDDtJxQBgPmr6ywT6bNUkAc6A0luPqVMNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=nzFkAjdtA4+TdMlTbzNR5XAZDUQJHGXbs0e2KMGSNuX89ewEdD4MVVl9k/DQXOWVh
	 Kfi7J55cilXuYZkKHtdZW9hQuZ0ZZXeZS7ucv+q4TqHeH9aQzqoA6UFklGH4QgOdM7
	 IngvXoYppn5NpEmGOSXshdJVf1ybV3yv6Ti0qenXws7zmFR2rKvd5YNKhba6zm62bu
	 VYO82S7xh00RtPA03cy2SOAKAVidfdQ1Zc4O0RcF1dRM4z4+JOmxyFfpVVC/Xli87t
	 5Ei4xjVB1KrL+bCJQXYwL8OZ8mq1laEy/3p83cZgRpqV1loH8IbCKcRRc1K6PhKOaG
	 vXRpVXw+NjiVA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a87c7c719so206169266b.1
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 13:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727121686; x=1727726486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8AEaHRUWjDDtJxQBgPmr6ywT6bNUkAc6A0luPqVMNI=;
        b=LdHR/V6Y1PLBYhWuQIgt9QtXBBJCJM2UmZrxY0kDZaKBjGWSlVjGgAWn2vdlzWwqYI
         qb6ehsfPBjAa5fqiEoGEd8IkSLHMxwtzXB4cB/S1sudZyem8pctUBre1Y7wFYx51QDi+
         FUhZq1CBfChEuK7pcgRQf2tL+J9D4/qQqjujSFz2hnK3xr8fpK4CtNLPRiuo0rZ5QmEe
         wSIZvjrxapLhAtNhhkUSrn0eEFb4Nj5Oo2ENfZMy4xKwxxoaTY2CbcSFX5UNHYcPG8jU
         KcKFzZ+vUEJcnY6w5tNQ498YsTswKNN5DUq5ovsffg0KAt3Nyxr93NFHRQeL9sD0e/pE
         vlxA==
X-Forwarded-Encrypted: i=1; AJvYcCVMyzPtSWzg2bgnTHfNskFc8q9jFTO+B4LNHy6WbssWzfU6GAM0SdvWWKEcl988m6fQeCC0rcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ki2LXTBqGLT01lkExSJFi7oHPug1zSAEID1PNfkydcAS0BZL
	lDSbx6nwQcWr0EjR0axu7PqNon5Hnk6Z1PVxRnGLf9z21QE74/WZGhk+YJizK3Eipdvked1mziU
	BgEDnltRPWSUOM1JyCtDbhfZwdjEAqdyZQYwss3JavSwHFsez5H0BCpZkD0IpwHNLpYP8EjeA3a
	3ChK78ZHLh4yc+oIIF/okJ6g5QPTwmYWNfYXnS9yx9l577
X-Received: by 2002:a05:6402:5247:b0:5c5:b7fd:170a with SMTP id 4fb4d7f45d1cf-5c5b7fd1911mr16028633a12.28.1727121686598;
        Mon, 23 Sep 2024 13:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7hPlYWTr3YF2IQs/FriUA9QD11sFVJh74uDhDWqHLY2oq2X9GImQxIKTRR5zbTiC/ZBZQmONtqRxA7+tBCVk=
X-Received: by 2002:a05:6402:5247:b0:5c5:b7fd:170a with SMTP id
 4fb4d7f45d1cf-5c5b7fd1911mr16028601a12.28.1727121686251; Mon, 23 Sep 2024
 13:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
 <20240912191306.0cf81ce3@kernel.org> <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
 <20240913115124.2011ed88@kernel.org> <CAHTA-uYC2nw+BWq5f35yyfekZ6S8iRt=EYq4YaJSSPsTBbztzw@mail.gmail.com>
 <CAHTA-uYxSzp8apoZhh_W=TLFA451uc=Eb+_X4VEEVVZNGHaGjw@mail.gmail.com>
In-Reply-To: <CAHTA-uYxSzp8apoZhh_W=TLFA451uc=Eb+_X4VEEVVZNGHaGjw@mail.gmail.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Mon, 23 Sep 2024 15:01:15 -0500
Message-ID: <CAHTA-uarCi84OTPNJKG2M6daWi=YsWFgf_wd0gKMULeeOvBwXQ@mail.gmail.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Martin <jacob.martin@canonical.com>, dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I'm wondering if anyone has taken a look at my reproducer yet. I'd
love to know if it has helped any of you reproduce the bug more
easily.

Patch w/ reproducer:
https://lore.kernel.org/all/20240916191857.1082092-1-mitchell.augustin@cano=
nical.com/

Thanks,
Mitchell Augustin


On Mon, Sep 16, 2024 at 2:25=E2=80=AFPM Mitchell Augustin
<mitchell.augustin@canonical.com> wrote:
>
> Linking in this thread as well - I submitted a patch to net-next with
> a reproducer for just this bug. It works reliably on Grace/Grace on
> v6.11 (and prior kernels already known to be affected), but I have not
> had a chance to test it on other platforms yet. Let me know if I need
> to adjust anything and whether it reproduces the bug on your machines.
>
> Patch w/ reproducer:
> https://lore.kernel.org/all/20240916191857.1082092-1-mitchell.augustin@ca=
nonical.com/
>
> Thanks!
>
> On Fri, Sep 13, 2024 at 1:59=E2=80=AFPM Mitchell Augustin
> <mitchell.augustin@canonical.com> wrote:
> >
> > > Sorry, I missed that you identified the test case.
> >
> > All good!
> >
> > I will still plan to turn the reproducer for this bug into its own
> > regression test. I think there would still be value in having an
> > individual case that can more reliably trigger this specific issue.
> >
> > Thanks,
> >
> > On Fri, Sep 13, 2024 at 1:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Fri, 13 Sep 2024 08:45:22 -0500 Mitchell Augustin wrote:
> > > > Executing ./pmtu.sh pmtu_ipv6_ipv6_exception manually will only
> > > > trigger the pmtu_ipv6_ipv6_exception sub-case
> > >
> > > Sorry, I missed that you identified the test case.
> > > The split of the test is quite tangential, then.
> >
> >
> >
> > --
> > Mitchell Augustin
> > Software Engineer - Ubuntu Partner Engineering
> > Email:mitchell.augustin@canonical.com
> > Location:Illinois, United States of America
> >
> >
> > canonical.com
> > ubuntu.com
>
>
>
> --
> Mitchell Augustin
> Software Engineer - Ubuntu Partner Engineering



--
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

