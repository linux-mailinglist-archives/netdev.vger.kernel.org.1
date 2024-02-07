Return-Path: <netdev+bounces-70001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7A284D367
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997281C22083
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2538127B4E;
	Wed,  7 Feb 2024 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="A4wXsdTK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CE823C3
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339725; cv=none; b=QS5cdj7vjz5RXQwHB2P6JoOOb+KXZnHTCxwDHZnYbTGRgQuV6Sw2HuTAhEhYizAFdC4LPM0RxMyZsvp5YgWA6U9WMEUBX2xLRvcnFmpVe8ILzbKphlUWnJS4A1Z7jjKXBh4PICPx6CWMvP4JxgNNKAtBz6mR+J6Ur5FjoCvyL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339725; c=relaxed/simple;
	bh=i46sTbdDr8UdjMnH1rLSXtScrIqetfu9Ima9Qu9Pj74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdEIQZb43G5Ow02DPgdD9VgjLwwN9LcNf33+M+sgZm1mk/FZ64HgLzWYdiHqgbtdONwaYbxp3PrtQ+gPS/m9IzdVSyKA2BbVoBUEsmb8Txv5BwBPkkH+UQyaE2XIeCdE3Til6wLl9gISFLo6jhAlyHrHzkLfB3kOctJFva78XSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=A4wXsdTK; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6d2e82f72so1071739276.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 13:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707339722; x=1707944522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dcafiTmzHGJt+jHQEJxLA8lSwqg1A+ED2VnBp8P9VI=;
        b=A4wXsdTKuuIfH1Sg0HcI+vc1BfDfL1UjtXZksadh33OPEPj8BrVXk7JCzVOiEHsqW+
         YaIkd/f32vniWzTjpYPnBPSjz/yTuS43Ornv1I9RDXWsmglLbT9aG+6YGyG/JIPZVGv7
         DEeVx2k9/eRzV6IxJyQ8A136dmk9aQgi8bbMNhQnAoB49RhNSnDs39DGdJFgsrYJ6A5g
         p9gySvV1kq6g9i+IOqc9Z4tRYRcsIO3JsN9KDQO46OMg7hmqOALmyKAM21t0aIyrBxL4
         k0dAPSE++szFwakPErc7I1o91xp20agfx15Elcwl/mhHKz7Z6TnY6Kaj+O2bnmH/GiS5
         pD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339722; x=1707944522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dcafiTmzHGJt+jHQEJxLA8lSwqg1A+ED2VnBp8P9VI=;
        b=YByK2i9yikn4iWv5yDFtPqcCPTqOpDyu0xkYD5YXNjHfrD1Whpwg3QUyZ0F3pJ6Jn6
         wzX1hDrWBzNJhifAt+A3/U3WHuVluM4jhdN4XOOLf/t0g0s5u+pRX0PEsaByS5ONYpt5
         wfPG032w96ry39TBjlHfP212Mx0PhI4G26H5a5X2gg/5GnAqlG/sYC1aWlBTmCRb5UOl
         OSAbh6oSmogqD7vCbYV2KM6ec0DT3To9z6Cbvbl8RkCDxfaEbfAR+OqdWNm1DYZyj4Uz
         NCEI9uiSf6pAP7IQ06r0fk29wBcqdvx1iXYyySEROVkbN3uENB4u/4vmwiJnydNcXbUh
         X5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7+AfDLK9huo20RpQWAcjAKi7Hbae/7UrNDy0Q/KZIuUOT0qNxNkAlgSMDs8McoDk8o32agvqhanONaU8ITokvz1qaEwgM
X-Gm-Message-State: AOJu0YzoP57Kz4zPH96aHl5YutyMYtkhfo3ABle//CZZswkggODdo7iQ
	0EBZUf0+oZdZkiPpxc2NVFl7udRTmvl6taMW4/gfg/RKVEykAly+fApuE8ngsJcXBppg7I/9I+x
	uSPto3a3Sig7Mr+lJHC1tv6PqwmPNYzQzq9hn
X-Google-Smtp-Source: AGHT+IHWHwc+iImIuxdQEKCLhBoDAR3fswbF/BKBVg3vDaNMyYhrbfjOZ+ytql1yX9mEi/nLXKqPfN1bNXHb5kejG7Q=
X-Received: by 2002:a25:8212:0:b0:dc6:d574:9371 with SMTP id
 q18-20020a258212000000b00dc6d5749371mr5179044ybk.47.1707339720640; Wed, 07
 Feb 2024 13:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207101929.484681-1-leitao@debian.org> <20240207101929.484681-8-leitao@debian.org>
 <20240207073725.4e70235e@kernel.org>
In-Reply-To: <20240207073725.4e70235e@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 7 Feb 2024 16:01:49 -0500
Message-ID: <CAM0EoMmcsRqP9K8PPMe_3B2gn3yEvvSQu5NuAJCWA4gOOj-GhA@mail.gmail.com>
Subject: Re: [PATCH net v2 7/9] net: fill in MODULE_DESCRIPTION()s for net/sched
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, andrew@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  7 Feb 2024 02:19:26 -0800 Breno Leitao wrote:
> > --- a/net/sched/em_canid.c
> > +++ b/net/sched/em_canid.c
> > @@ -222,6 +222,7 @@ static void __exit exit_em_canid(void)
> >       tcf_em_unregister(&em_canid_ops);
> >  }
> >
> > +MODULE_DESCRIPTION("CAN Identifier comparison network helpers");
>
> That sounds like it as library for any code, but it's TC extended match.
> Jamal, any suggestion for a good name template for em_ ?

At minimal what Simon said. But let me go over it and do individual respons=
es.

cheers,
jamal

