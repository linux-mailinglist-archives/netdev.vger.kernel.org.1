Return-Path: <netdev+bounces-211917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1988AB1C743
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 16:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E318518A2675
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F4028BABA;
	Wed,  6 Aug 2025 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="Xa8x6Zfq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040623D2BF
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489142; cv=none; b=nybDRzXYcyEXlGmACappxvC93fD/vsl6Jf+3ssm8nNAING796gKhFKy1v3ap8wx1UqmV9aHgPHaqvSuiiig1a7/YUwYts9hC+Vr6xjjCmvkecnmPKIiFQ73vZM3Nk//BFAviFnPHZFpl4d0JyM1oBzHnvqadUsYv1NWWtjhlv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489142; c=relaxed/simple;
	bh=3MndvVZ5AfJXQjZI8WkeTK110/JjguQVNARH2nxuW9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEtMdliVmSC0QsXDoIxbZWP3ZIHTV/o9v+uVdV58WpA/eX8Q02kRzHJABPierF1tdXc5mW3B1aJlyk9B8WPo11dsY6MHEXsznL5Oe14GYryQgARwWwVkrjKEaKmMXLAohbRLqOle07sEwDormyjR8LwWaJ2bzFawYoJHrIAfiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=Xa8x6Zfq; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8fe55d4facso4049105276.0
        for <netdev@vger.kernel.org>; Wed, 06 Aug 2025 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1754489139; x=1755093939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLZsXb9oE1NnqfB+ItaKjKPCtnDeFFK4GLsnGU0km5M=;
        b=Xa8x6ZfqxjoH2SaflUDSehCuAtdT5W35QlqmFHelEYizzWP2RmaRgsUlVn4iJqvL8A
         w08eUTVE/s1XClHLuXc6/3z6lfs5gJIi0WfIPszh8Fe6bBAdRUE30qrWMkCgTfToa73X
         UO1CmxdCQnQrpCT+WYxoe/g0M3BwQ4aVqLhX98wGSyvGoLaVXyycglO8xSSylY0ZLke0
         fF0n3y5fk2/hH3XfTrD3+VFCGfNi/BQAaMJDJM8zBBD77avtIEB53tFnOFLjpF1SpHb+
         CbJG+UpcaxHA5B86uuYGSbTNaAIZEFOwjgMuRMJ4VNYEXLvnoC7xiDIhiNd0Ckxqu/kR
         Xc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754489139; x=1755093939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLZsXb9oE1NnqfB+ItaKjKPCtnDeFFK4GLsnGU0km5M=;
        b=WR6py+Os94kS5DDzhrpi64DXgiqwlmY8WQJJFkfHoXMvvO0zaXdTjn2BzhW1h4YKCa
         YnoNv6hmiaXLi1FdnkIegL/QU8zm1+oXYOw/W7RWpnpot1avGDjcD4lGVA6p8tUArHAb
         Zv0a0smrRG6zqstKvNmipgiEormL16fGKVk2JUGREAD2h4N/Q2e2o0NwXE18CJcsV+Vs
         JfLYUzUzDmH/n2E5LrfMhUvbqemDYIW1yXbx5stp8K6zdgsHlME/fm5XKkp/KoG4sLiC
         uqDrh3S2be6V/AU/48P1cE+IlATIFP1LPcf7ErzuTZfkcOyZ9gjwG1B3czHR3y+PH7W0
         UoBA==
X-Forwarded-Encrypted: i=1; AJvYcCVLfuM27ckg877NJRFWjwb/ZefuGm/C5R2hG/4RPDOBdDlc/z9trRnP815Mn8Focs+dmKnnJDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXyRDxLepB9gNE5FeoC4AKJYHc2664Bm9yEZQG4FLs/jwEQyy3
	IY6svoTKIBk9suOFB4HsjUTFtZPchanxnOwa02XnPZ1CJH7Cw74Fyr1NxPMLtR7qqstX1fBONib
	WduUhv9hGQCA1u+hjAKKdbpUILTCRxrj4IwdMKmpz
X-Gm-Gg: ASbGncscnGCj9b5FjftW/4S5TnXyiA7/nijMxcjf+q/RaAE6fnELAGeDt7KIuvobXeH
	vAFrOzjsqNKrYJvcjNP7aWcFkpBF7hOWX2x+i5zJji7Pex2oT2vv0JVr94pvEG2XgV4jDB4Qp6K
	WsJAse9LIaOY4EXYoDQLL+0VWGCoI56lThLJLGy9RDzpc9FQ5cEsxeK3r21cuE5x8WWB9Y//s0C
	aVcRaBDBFi+A7Km1wAY4KsmLAhf
X-Google-Smtp-Source: AGHT+IGdtSvyewpQ2KfAuwoMi3XBQi4Deb1+xM/pcFA5WvHt1CgEWo682iQ6qTqjjn6VhnfzimeFuEZEjvxpibHF0H8=
X-Received: by 2002:a05:6902:18cb:b0:e90:1214:81f7 with SMTP id
 3f1490d57ef6-e902b83aeb3mr2887133276.36.1754489139479; Wed, 06 Aug 2025
 07:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805213356.3348348-1-dechen@redhat.com> <20250805155550.3ed93078@kernel.org>
In-Reply-To: <20250805155550.3ed93078@kernel.org>
From: Dennis Chen <dchen27@ncsu.edu>
Date: Wed, 6 Aug 2025 10:05:27 -0400
X-Gm-Features: Ac12FXyrMf0n8aJ4coNXQvC3g3D6HgGpIMPdTIORJ9vPnmDxgSc0LjYnTdKdgKs
Message-ID: <CALSBQO=Q5fPxAuAAdgN8eUgTGVzdRYhthLvb6052SzsDV0uZ3A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] netdevsim: Add support for ethtool stats and add
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dennis Chen <dechen@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 6:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  5 Aug 2025 17:33:53 -0400 Dennis Chen wrote:
> > This series adds support for querying standard interface stats and
> > driver-specific stats with ethtool -S. This allows hardware-independent
> > testing of ethtool stats reporting. Driver-specific stats are increment=
ed
> > every 100ms once enabled through a debugfs toggle.
> >
> > Also adds a selftest for ethtool -S for netdevsim.
> >
> > The implementation of mock stats is heavily based on the mock L3 stats
> > support added by commit 1a6d7ae7d63c45("netdevsim: Introduce support fo=
r
> > L3 offload xstats").
> >
> > Note: Further replies will come from my school email address,
> > dchen27@ncsu.edu, as I will soon lose access to my Red Hat email.
>
> The tests for netdevsim must test something meaningful in the kernel.
> This submission really looks like you need it to test some user space
> code.
> --
> pw-bot: reject
Hi Jakub,

This test would help verify that ethtool_ops correctly propagates stats to
userspace, would that not be significant enough for a test?

My thought was that it would be similar to the patches for ethtool
--show-phys here:
https://lore.kernel.org/netdev/20250710062248.378459-1-maxime.chevallier@bo=
otlin.com/

Thanks,

Dennis Chen

