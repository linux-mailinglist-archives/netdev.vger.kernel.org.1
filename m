Return-Path: <netdev+bounces-88827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ADD8A8A0E
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6B4B20D87
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6517165E;
	Wed, 17 Apr 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOMiDYcD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6816FF50
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374154; cv=none; b=Zu/NvJQGSH9Y0gRabXW2LRcwNsJoGFb2xPlK11rpY1Ucuh+E8e+lSwkLEUTZhrMY8iYcwVTsLalrpE3MD+i0t3Abk7UhaD97p9sPchHZa+/qQSB4R0Ow6EhjwaDyMRenROm4EWpLQbzeQG9Bq6UTrzb0OcCzGh38xrODYVq2/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374154; c=relaxed/simple;
	bh=+r6hv0ai+i9fjOCVitO8OLVjS5ahtltC2KqmQdqrHW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDNoXOTXCBRGCeW8tQ802FimRNi90L53yepTGBZTfXLxH6ih5lV63k3SeGQz7qAWvXyaWNPy0sWSQmngBCC3TIVGGyCnwILD7dvJdesXpDsMzKduAjyvqki33zclcJqmRx5PNPoYwFxlJfRR4bwAj4Ck37gkDvSuVgOhOeAGphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOMiDYcD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so643a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713374151; x=1713978951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HUML3uBn48f91ePBCIxOf4lrIBe8UWSrsG1ru/oNj4=;
        b=aOMiDYcDVlDECMY+oo8RuYuGJaO30+iYg8aMApZ5DWN9kakrmfVS4rpD2GFj/sYiZz
         oNFt1qN1Bu/9TUTisd2NfZ+gJIX6dDK9oV6GAnEyUJSBvEjX7akCsu99KMt5X3mcOSm/
         bZXC3P2y4VBiUjMROPACGk7rtXSa4whjgOiCXkmcvfnEPMkHSgvm5aaURNsvYV3Bg9ah
         TREdFc4YD5CMCfSDxz3S6kltrdPdECHgYVMpTTYMsTnN683VCeSHHvQe6o/dr9GXEoV3
         MUiJ4V+0MYdDdgfsnqAjzeU8JSeyoR3WP/0Lw80SwSxgzU9cnJx8AUniqGOv6HtQEOE+
         Wc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374151; x=1713978951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HUML3uBn48f91ePBCIxOf4lrIBe8UWSrsG1ru/oNj4=;
        b=WkuCHLopDPwsdXvJkJyyY5OHsI787lovEeXzkbyTkeKRW33QYS9w2SbgAdP/CH4XoR
         Q0TTmRhfGNGWa0CGMj28SBbohANWcJiamTaFbQPA9W5EQwbWa7WfHFjbZNRCqcYZUcng
         5hAmj8dv3+mU3Tw4ukoni9iiI71+jhrxcivHam93/Cey69h9Byr5IJ6gijE0S77w0Esg
         h/86LD9lW2B3ZM4bLLNrfcivqlLHEzJ/QEi0f2zQ2mtGWujmPD5Bwz4W0nekGeftmDXd
         rJqGLKJBe7tH18jPoqCLauGYgbOQ3g8W2IQA8VxdT1raR57+UmP2Cfw32W+dkbc0lDcd
         Yjpg==
X-Forwarded-Encrypted: i=1; AJvYcCXdvrXTpPfL/xFbgNAhVlpOY/q5g7LiUhZC9/GwEGUrp8aTj7COjU7cZlXXENoOKP2I90q6VjJ3kQNt22JGYg1CYGMlzfZC
X-Gm-Message-State: AOJu0YxwGfYqWl9mxg/8FKw+IGWDrVXUl9YbT7mjrOcSW0c5AV0tn+J5
	XFa/BBMmwsC6tpycLeehdcxDmBYWNpTbq4aZV3+WpwpPeBYv2wXCykrySiaHSlql17QXXmEd9dt
	Hi3Hk/eosXNd8uziHqrPzaj3cVM87BAU6fo9z
X-Google-Smtp-Source: AGHT+IFqxZ/gFwRb39Z9WpPKQXeRMqsKHbe13fCuUgX+yEdqKiNgjXNp2GrKOOOMmgVjV49BqdAoihoJ93owzePmxlE=
X-Received: by 2002:a05:6402:1841:b0:570:44bf:ca11 with SMTP id
 v1-20020a056402184100b0057044bfca11mr307edy.0.1713374151191; Wed, 17 Apr 2024
 10:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com> <20240415132054.3822230-11-edumazet@google.com>
 <20240417171349.GF2320920@kernel.org>
In-Reply-To: <20240417171349.GF2320920@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 19:15:40 +0200
Message-ID: <CANn89iL7nZY61RJhkWXkfa8GdTPgWY6mJ__rWk-eU6wDierG2Q@mail.gmail.com>
Subject: Re: [PATCH net-next 10/14] net_sched: sch_fq_pie: implement lockless fq_pie_dump()
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 7:13=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Apr 15, 2024 at 01:20:50PM +0000, Eric Dumazet wrote:
> > Instead of relying on RTNL, fq_pie_dump() can use READ_ONCE()
> > annotations, paired with WRITE_ONCE() ones in fq_pie_change().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/sched/sch_fq_pie.c | 61 +++++++++++++++++++++++-------------------
> >  1 file changed, 34 insertions(+), 27 deletions(-)
> >
> > diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
>
> ...
>
> > @@ -471,22 +477,23 @@ static int fq_pie_dump(struct Qdisc *sch, struct =
sk_buff *skb)
> >               return -EMSGSIZE;
> >
> >       /* convert target from pschedtime to us */
> > -     if (nla_put_u32(skb, TCA_FQ_PIE_LIMIT, sch->limit) ||
> > -         nla_put_u32(skb, TCA_FQ_PIE_FLOWS, q->flows_cnt) ||
>
> Hi Eric,
>
> I think you missed the corresponding change for q->flows_cnt
> in fq_pie_change().
>

net/sched/sch_fq_pie.c copied the code I wrote in fq_codel,
q->flows_cnt is set once.

