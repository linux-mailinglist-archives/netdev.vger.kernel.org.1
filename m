Return-Path: <netdev+bounces-202926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C727AAEFBAD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A034C4877A9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2D7275B0F;
	Tue,  1 Jul 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="lnX8I8KP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C62AE97
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378611; cv=none; b=QWzh1Fjkjy38L5dzqpjwixt10WDx5+BzTL811GDRtiXZa/LwzkcsSOzfywmwABqwGLVxcHFq6ZEnPTAqvJagnlFtErnM8hvatnNTuQy5x547LGw7A5cz81mC09ACKwjBAxUF7VSSS4P+/CzgkWVqegXKFFm7yY226TSu8IokE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378611; c=relaxed/simple;
	bh=18q9ddVc2apoIeKIdg1Gasxpw3iy5x5KPmKC0rZa1R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiS8QKGKUjpOj4SUUG7DcU3TIO86FqJMmABb6QfCZyhD7d6eRfkeyCdHUWKK3fX/02hFn7mOmrfwH/b1DYeGATsG+5CZNGqgtXuJlgtKPsHnDXvOazuszwKqJ8aFaGmaqpnybPFsiwA6LhA8D4rB+JqSrMdIONHO9t4ps0cv9+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=lnX8I8KP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7494999de5cso4409108b3a.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751378609; x=1751983409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vko+GCke9eWIPBGMzOyyvgm2Q41640vB1R7LBt93WHQ=;
        b=lnX8I8KPuZg+hmy5VsIrC3x7NZZDyhvoPcd+ySfDtPNpaVSwb5KLpcuN7BaXoLnI2r
         dL6yVsBr+l3MC79x0B0Bk4I9ozrhWkrwxmKLnY4sINMbBoWFzINmSvZa+Ps7Rnkefinx
         Jib0QLQoT6FOf/EW7BQ4DFglv9EGoq1Ar1EIKeK9m3DN24hSt0NPjoDmT/fcqOLQ1cU0
         USxBaydJ3FzgQNj7Of0iyalJjBmf1Kn20Zyr7gL90IE6QTZJdy6luZKSxyl8tkX4n6q4
         C+ok/muJqdtUWpCmUreikvEmEWnyzlhR2rata0qDMUwHC1Wm9xWm2pveif/5MLGUe1j3
         1OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751378609; x=1751983409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vko+GCke9eWIPBGMzOyyvgm2Q41640vB1R7LBt93WHQ=;
        b=PJGPl8vSWvdlb2Ovk7hvotp3LleBQWyc+UpEZEWpnmhsZCGYa9TBkXevZ3TFtf8R4E
         gOjeScpZbzbFjFInC5QcT//QPjOYk3PDta9ukFw5fJHbPDFJDcaQXTPObujlfzd1zGxa
         mv6gzNebbJ8WUoIRfD4ViRL24hlHViiYNxkJ1pjqsbA2ghk7cE0TjdRdETj/9/RF2kGU
         Uy/DlSx9CQa6IHZXrLrXwg/3Z0QYvAZHUlR73iI6oGtPnrfqLs/B/HgVduT0UkskmGP/
         xShwVf/9LgbNTFKLcNUYpJUiGkoCapmXFik2sxjj0dvMOk4assZPx6G890YOwZqj6R7u
         TDiA==
X-Forwarded-Encrypted: i=1; AJvYcCUmjw5tTXokIii1hU+a2Bw/nk6wdF/pd/o1ebL3ZaoQkFqBQMyjHBWiDedf1onW/4bdZPdetVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lWVw6/jV9Yq3pnP62ApETppk7pZe7x00M85g1Clu9LXUZD4M
	VBovMWDk5JxkyoyRBU06Dntv68jGMgw3FYiZRy6CPVI1WjHEaYPbo/Khzd+EiRT6nJWaclhdQtG
	PPbSplUaG/VAeARDR9vp2xmqJ/pnqmBeTHrx9x+JL
X-Gm-Gg: ASbGncsz2d1Fn05DObYzw1PtF0DWRLMfPohTsfTsoRxZv40AcCEBUmTOmx8kHkEZw30
	sgqAOF6a7s+ulcqeJPe2K1dRpVOAAdl7T3Z+vKBJh5BEK0xs6vsiSACbv/lOF3/LAeTrx5l6d9b
	oGFaP0T5Cu/WSiBO3TZU5QJCGNdStHuix+zmdOZ6lEPA==
X-Google-Smtp-Source: AGHT+IGsrEGSQcwkylkCHo72/OTt9ViOFDj5+hLXK5R5ylnpPW2C06cDkarnuCsOAayiapvRrTAI0umsJiZoFRG0Etk=
X-Received: by 2002:a05:6a00:1ac7:b0:748:e1e4:71ec with SMTP id
 d2e1a72fcca58-74af6f57628mr23774862b3a.12.1751378607121; Tue, 01 Jul 2025
 07:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain> <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com> <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com> <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <13f558f2-3c0d-4ec7-8a73-c36d8962fecc@mojatatu.com> <d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com>
 <aGMD1S0F9sTXexBo@pop-os.localdomain>
In-Reply-To: <aGMD1S0F9sTXexBo@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 1 Jul 2025 10:03:15 -0400
X-Gm-Features: Ac12FXywX2bMQ4uuktXSL0cxTczQWR2yYO8kF3SpeIglyqjL7mEt-RLimvV0LUM
Message-ID: <CAM0EoMngoh9hMr363XNiVxpKCu3Y+C4QkBmu0brYncx3YgPF=Q@mail.gmail.com>
Subject: Re: [PATCH] net/sched: Always pass notifications when child class
 becomes empty
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Lion Ackermann <nnamrec@gmail.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>, Mingi Cho <mincho@theori.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 5:38=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Mon, Jun 30, 2025 at 03:27:30PM +0200, Lion Ackermann wrote:
> > Certain classful qdiscs may invoke their classes' dequeue handler on an
> > enqueue operation. This may unexpectedly empty the child qdisc and thus
> > make an in-flight class passive via qlen_notify(). Most qdiscs do not
> > expect such behaviour at this point in time and may re-activate the
> > class eventually anyways which will lead to a use-after-free.
> >
> > The referenced fix commit attempted to fix this behavior for the HFSC
> > case by moving the backlog accounting around, though this turned out to
> > be incomplete since the parent's parent may run into the issue too.
> > The following reproducer demonstrates this use-after-free:
> >
> >     tc qdisc add dev lo root handle 1: drr
> >     tc filter add dev lo parent 1: basic classid 1:1
> >     tc class add dev lo parent 1: classid 1:1 drr
> >     tc qdisc add dev lo parent 1:1 handle 2: hfsc def 1
> >     tc class add dev lo parent 2: classid 2:1 hfsc rt m1 8 d 1 m2 0
> >     tc qdisc add dev lo parent 2:1 handle 3: netem
> >     tc qdisc add dev lo parent 3:1 handle 4: blackhole
> >
> >     echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888
> >     tc class delete dev lo classid 1:1
> >     echo 1 | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888
> >
> > Since backlog accounting issues leading to a use-after-frees on stale
> > class pointers is a recurring pattern at this point, this patch takes
> > a different approach. Instead of trying to fix the accounting, the patc=
h
> > ensures that qdisc_tree_reduce_backlog always calls qlen_notify when
> > the child qdisc is empty. This solves the problem because deletion of
> > qdiscs always involves a call to qdisc_reset() and / or
> > qdisc_purge_queue() which ultimately resets its qlen to 0 thus causing
> > the following qdisc_tree_reduce_backlog() to report to the parent. Note
> > that this may call qlen_notify on passive classes multiple times. This
> > is not a problem after the recent patch series that made all the
> > classful qdiscs qlen_notify() handlers idempotent.
> >
> > Fixes: 3f981138109f ("sch_hfsc: Fix qlen accounting bug when using peek=
 in hfsc_enqueue()")
> > Signed-off-by: Lion Ackermann <nnamrec@gmail.com>
>
> Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> > ---
> >  net/sched/sch_api.c | 19 +++++--------------
> >  1 file changed, 5 insertions(+), 14 deletions(-)
>
> I love to see fixing bugs by removing code. :)
>
> Thanks.

