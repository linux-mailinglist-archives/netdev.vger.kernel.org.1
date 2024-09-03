Return-Path: <netdev+bounces-124758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F99396ACE3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 01:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E621C23D58
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 23:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77BD1B9827;
	Tue,  3 Sep 2024 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ98Tvc2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893C1EC01D
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725406179; cv=none; b=Ic28NreZV4rsgZDzYOrKp3lKMAAsqA/Mm5KyJXNWHcVSu261cleYJWjJSlwK8wKZvzheP//U2FYTVZHJfZ741zU6zDy0VF22T2/vfc8OevMxpHTFGncLca0ukwQDH+3S7fx7/Ed+Isfz+nHoUWJZc55Ou7e8aCWFFrtXwRU6hHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725406179; c=relaxed/simple;
	bh=7WBF7ldFwTNVzLbiRsOGb1N+RJjMyN8goPIWyf97VjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8EQfJZP2le4Sh2IRVXY4YjW1RgJbmbLfaSvdE+R9VmsTBsUcX7OnpSDv+P5R+G0yR4i+YeTDD+mHFrO98SnI2tyw5hXW+tL0hNUUqrzq451/uDyROZ78qX5AQ4NXycCybqzRc2zMjbEs0Nw7rAq8u3794zCNIWOdi0m5ncoDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ98Tvc2; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82a316f8ae1so169800839f.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725406177; x=1726010977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unCCoCdQji26uU+yTsJV5f+XBX+S+iwt7kB0HVOp4lE=;
        b=jZ98Tvc2/8t/JmPILDVMOPQJ4nClvJQgtBEY9k4onDAnlrOWVKb9Gzr16G5jBfaFwj
         vE5CUDTVzAZ3mHFnXlcCsz/paSuspXPYVK8UA+gVhT6uGImeYWAXagofSfXCFvNoH2o7
         ZX8lEFn4rn+DrTBULOPfZzUrs3K1teUzSF9mnHhBwd8MvO1CiXDx+BiTRRK15z/jx4RJ
         TCdNGoaiwhRDglI4ebW2t/Na6X3inNU03fEwTKJEo9Lmiz8Gll3jDngT0mNJzxnE8gvz
         tYLt+9fBdZ6oe/BxLcgkMW3IyHy1W1yX6KEENhv/3zUREdp5x7DFrzUixLmSzVE/dRYC
         gNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725406177; x=1726010977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unCCoCdQji26uU+yTsJV5f+XBX+S+iwt7kB0HVOp4lE=;
        b=M1vDFzTa0nkzA8KwVBHwyV4ik5hlOUYF3Qp/N4JHrj1w5yFanO7mpE4II4LmYPsCdv
         ygoZ6lhNLHjhk1KYlgSEHME2wuJWAWsDbRu7CXK1eEubnr+uhWCVVt7Jn9gc/U8+yTyn
         EJeL5aOf45aPA6Hby9qT7VIiyfFSKSk1IyM8dRVXqkVuBR3fFC5GR99cIgcHL1+9EyFr
         V0lJ0tJjCbxeAYBtd4DzOXmVQyxBmBq/78AaXramhlIWV/AIXo1i3jIuC955gjmHxJNk
         RhILPW3BJq3rpUfEIAlHg/KfkbRwok1R0L7zOWifNWqRfWsQUL/H/d1GSIfb5y23Hn0v
         e59Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGwvV9r1b+MYcuR4W9eXGIMEnhL7w7iVtlwK/agN7n13vUn3JAHUt7lJpeGZfk6s2/sMTUZok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPXm3XlBuKN3JSs6l9yWEsZa1I9IFKvSqxgrzfWbxTivM2Kcm
	P6oAAke8PRwXe6uxhmdMkqUPrsxIaHMmIuxX7ZW7wArlxwhqJiwZH6ePDsfsYMzNQxtyk2YnXWt
	Nf0Ubc+utKGXMgJgpcXh1PTVYcVI=
X-Google-Smtp-Source: AGHT+IHmPdr78AUTB3xnZGnLyz/SdxqfLdaJ2uzXS3gcV7kth3W1eLwFx8aefqkplR4L1h6QDGA3f5+rkpSSY2Ro/Mk=
X-Received: by 2002:a05:6e02:1fc2:b0:39d:25d8:43a9 with SMTP id
 e9e14a558f8ab-39f6a892175mr65828145ab.0.1725406177234; Tue, 03 Sep 2024
 16:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830153751.86895-1-kerneljasonxing@gmail.com>
 <20240830153751.86895-2-kerneljasonxing@gmail.com> <20240903121940.6390b958@kernel.org>
 <66d78a1e5e6ad_cefcf294f1@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d78a1e5e6ad_cefcf294f1@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 4 Sep 2024 07:29:01 +0800
Message-ID: <CAL+tcoC-6nAsNtKNkikLs+aFdoSWe-akNg2EgN1yv9Qu3TxH_w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net-timestamp: filter out report when
 setting SOF_TIMESTAMPING_SOFTWARE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, willemb@google.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 6:13=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jakub Kicinski wrote:
> > On Fri, 30 Aug 2024 23:37:50 +0800 Jason Xing wrote:
> > > +   if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
> > > +       val & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> > > +           return -EINVAL;
> >
> >
> > > -           if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE=
)
> > > +           if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > +               (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > +                !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)=
))
> > >                     has_timestamping =3D true;
> > >             else
> > >                     tss->ts[0] =3D (struct timespec64) {0};
> > >     }
> >
> > >     memset(&tss, 0, sizeof(tss));
> > >     tsflags =3D READ_ONCE(sk->sk_tsflags);
> > > -   if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> > > +   if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > > +        (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > > +        skb_is_err_queue(skb) ||
> > > +        !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER))) &&
> >
> > Willem, do you prefer to keep the:
> >
> >       tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> >       !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> >
> > conditions?IIUC we prevent both from being set at once. So
> >
> >       !(tsflags & SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER)
> >
> > is sufficient (and, subjectively, more intuitive).
>
> Good point. Yes, let's definitely simplify.

Will do it.

>
> > Question #2 -- why are we only doing this for SW stamps?
> > HW stamps for TCP are also all or nothing.
>
> Fair. Else we'll inevitably add a
> SOF_TIMESTAMPING_OPT_RX_HARDWARE_FILTER at some point.
>
> There probably is no real use to filter one, but not the other.
>
> So SOF_TIMESTAMPING_OPT_RX_FILTER then, and also apply
> to the branch below:
>
>         if (shhwtstamps &&
>             (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
>             !skb_is_swtx_tstamp(skb, false_tstamp)) {
>
> and same for tcp_recv_timestamp.

IIUC, I'm going to replace it with SOF_TIMESTAMPING_OPT_RX_FILTER and
update the test statements accordingly.

Thanks,
Jason

