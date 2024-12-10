Return-Path: <netdev+bounces-150431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C913A9EA39B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 01:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C322A282D12
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA444524F;
	Tue, 10 Dec 2024 00:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGQuRtU2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A03C0C
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733790316; cv=none; b=o9Yy8tE1Zz1OaNbajjap7CNpX0M9JjSJIBtisw5fJfB7ZGKNUGDtBZpD8YiPlARg231q98Fl1qRzbJL2LB+tOS5Qemme6qTYGghJ96Ge6fMy0PH5nVVMHA5LFPMlLJoPEscUMqerWAj29ISH0JSHQvYs2t9PT5EAuyupNLQqmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733790316; c=relaxed/simple;
	bh=PHBIe9XcxtTRmJ127VTnq8OpK/QuQpYKvLTQn8rHVoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYA1c1YUUEfSO0Vj/fM+Tx9cxIhac/dmi3GtkPg3WxEKC+oLTU7uuEAd9/r5ecBXDM5CFJ7HHCBIGGCopffzNNo835OIeY20OnWo5GkJmdQJS0uKutXm2ildtopYDn/CGZiYEy4Apl3mn18EXMUVn/mNqEj9teOT0ZUfmxt+J/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGQuRtU2; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f2cab14463so164333eaf.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 16:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733790314; x=1734395114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxV+mAVeS0Tuzvt9QheWEZ7UQEwvL15JnzRI7m+7QSk=;
        b=jGQuRtU2BavjqBifqRkeW7ACE7lFUS16mEy+25e23yTO+Vdj4cxo67PAvbUfrzJp5y
         Ts3CsxOVjo9WanboSl/K/jhzEqUSnHi1NxDQwsXgZFCMIq8QXDZoJlShbiWzQ5/4o+bW
         ZXlkhDWZDftk0QutNGDM0EBZM0nHP3c2kPN8WMRNo2rPVF/iyvoODGivXyptNSuE+4lX
         6oa/Y1bBXvyRqBUo6XifgFOw3dqvennwFiP73JSTu7+Q5LGPtjHlCZKeubRwLfBx+XHp
         PvvHaYNSfbZ7dIbzNN3GFObSZqotSRnwQranYMZ0kJ726+UgFZXZDVwpp9jVFE4APd8T
         PHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733790314; x=1734395114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxV+mAVeS0Tuzvt9QheWEZ7UQEwvL15JnzRI7m+7QSk=;
        b=p82ZLbhGpOyAuEYj8+AtPNnznrzojWyd3N3zbs53S5ANBYxOx5OwpGKP4e+LMZ47wF
         c59KWTcqST9U08vZFvCMYOdGqF/XtH4H4JrVnZGSrKgI52GdRDO8DsnpETuhuHNOZg96
         MuSIR0c0fxxLQezN6Yga63ruzAwkSIYjwHfsE5aGyef5aXUjRvnpXo5eH/ijEkRjXS/t
         YeR64WDOwSw88mV2ozSS63/tUZ5sUItuDQ8R5S97XNxk+YllKDk1mBhf9G3TY/4drzhQ
         lb3BHSuHnWurvqC89661XVW/0lt8WlouaDm3Kq5U9YLmAkukZq5KcuFWce3Ds62seGIw
         OLZg==
X-Forwarded-Encrypted: i=1; AJvYcCUe28MJ7tbN7Yv9jVA1VlMqPMjV5ZTTaz9cwepKtf3FijhuZrhu79tfXInF27/0Ito7oX6Dpfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhvnWhdBU3WsWwh+ma97LdgbWEzBrF8zNMLFiPglbc9E9XYybh
	MlcaxjKXfoh7ywAGsM5q0geOGFQlmUzIZb1W2c7MAv8AIwNHTVLeLFHWDcR+7MbPVwSylk5lJaL
	12xdPo7pjTFTfASz9mg+FV1dXdT4=
X-Gm-Gg: ASbGncuyCz7tSQC5PVIFbfxs//LPW/CB6kkB4y+pztRj/AxOVyg+6X1HqRdDDAmfbnx
	GMIWSt7+vUCnUUXQDXNzHMjlaDyjr9CH24IRz/ktFM5x/+KZSULfuZumWmb/r4968TfktXQ==
X-Google-Smtp-Source: AGHT+IGptdCS2IgMtGirKWOIZXgbBA4mbJoBb81jtfTqrZAta/uP7HvPJDZWv8PjEFZFeHpM7y7wetAZkpFzAyI1KcA=
X-Received: by 2002:a05:6870:c10d:b0:29e:5df2:3e50 with SMTP id
 586e51a60fabf-29fee568a8fmr1565854fac.15.1733790314255; Mon, 09 Dec 2024
 16:25:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com> <20241209155157.6a817bc5@kernel.org>
In-Reply-To: <20241209155157.6a817bc5@kernel.org>
From: Dave Taht <dave.taht@gmail.com>
Date: Mon, 9 Dec 2024 16:25:01 -0800
Message-ID: <CAA93jw4chUsQ40LQStvJBeOEENydbv58gOWz8y7fFPJkATa9tA@mail.gmail.com>
Subject: Re: [Cake] [PATCH net-next] net_sched: sch_cake: Add drop reasons
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	Jamal Hadi Salim <jhs@mojatatu.com>, cake@lists.bufferbloat.net, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 3:52=E2=80=AFPM Jakub Kicinski via Cake
<cake@lists.bufferbloat.net> wrote:
>
> On Mon, 09 Dec 2024 13:02:18 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
> > Add three qdisc-specific drop reasons for sch_cake:
> >
> >  1) SKB_DROP_REASON_CAKE_CONGESTED
> >     Whenever a packet is dropped by the CAKE AQM algorithm because
> >     congestion is detected.
> >
> >  2) SKB_DROP_REASON_CAKE_FLOOD
> >     Whenever a packet is dropped by the flood protection part of the
> >     CAKE AQM algorithm (BLUE).
> >
> >  3) SKB_DROP_REASON_CAKE_OVERLIMIT
> >     Whenever the total queue limit for a CAKE instance is exceeded and =
a
> >     packet is dropped to make room.
>
> Eric's patch was adding fairly FQ-specific reasons, other than flood
> this seems like generic AQM stuff, no? From a very quick look the
> congestion looks like fairly standard AQM, overlimit is also typical
> for qdics?

While I initially agreed with making this generic, preserving the qdisc fro=
m
where the drop came lets you safely inspect the cb block (timestamp, etc),
format of which varies by qdisc. You also get insight as to which
qdisc was dropping.

Downside is we'll end up with SKB_DROP_REASON_XXX_OVERLIMIT for
each of the qdiscs. Etc.

> _______________________________________________
> Cake mailing list
> Cake@lists.bufferbloat.net
> https://lists.bufferbloat.net/listinfo/cake



--=20
Dave T=C3=A4ht CSO, LibreQos

