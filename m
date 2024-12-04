Return-Path: <netdev+bounces-148986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C79E3B69
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEB7285AB7
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0D91DFE15;
	Wed,  4 Dec 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkfuKB2c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570511DF745
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319509; cv=none; b=pnGYHLcYrXPOamms/poPRnoIsqBSzQQrYQ73ZUkuY/o3hoCiw566siZZwFvX1aDXP7wnHwNIKdxdEUv35t3xNGwulegxXO5MhFWE8rxatTVjRs7OPpHe9V1sEXHOnPD1nsLlYzEO9N2dGkKPOX365A/ykVbBUw2ILynD4zBuIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319509; c=relaxed/simple;
	bh=QuFnu3L3Jd2ulTeMmHAFsUR7/FkSIt3YcvUlyBFhi3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yg4D4xb/hDQaDS3pz/21N41fXfj9JPVCF8n6B++y+KwWoJ2b7ykhIILVhHdb5+nWy2jyC+azLFI4PFiTYhulHVf3YiFekgkqib0mhhUwOxGcPWtWHJcqjyuIeyOrcfxdch6PIkF+9M1+tv7uYTJ2pPkdoYOYyDS5g3z4AZ8PelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkfuKB2c; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so481866466b.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 05:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733319505; x=1733924305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuFnu3L3Jd2ulTeMmHAFsUR7/FkSIt3YcvUlyBFhi3A=;
        b=wkfuKB2c/kTF5LMYcomYWTZ1lXLs+qmdy0uBQVeljiBBaXd6QlvfTVq2S7MRGEL97q
         o+O0RBjX5pD1NfKcO1PYd7nK2WENVtHwy2fm/RUysPb/VMFCueG7555pPl+VTi/V8Og3
         XtFgrClbwdyDGn8izAMFn5WR5B1GqM9nLqrpRabYQ+zPzecmomSwau2t9YvWTyNYRBCP
         H/cnPqbCmYx71CK7B/Jkp3mPEn95Lf+GFT5L6o+EZtEtCL889GS2nkRDFMsAtw/IEqfE
         BsaaTuU15GbecnolKLCgW1ypI7J4cG7tJBYsotPwKl16WCqwdOkCOcNCaaRBjTydFgqj
         Oi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319505; x=1733924305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuFnu3L3Jd2ulTeMmHAFsUR7/FkSIt3YcvUlyBFhi3A=;
        b=Morv5a8wOTp9g8EV/OZd/duaHtnZ3ovPvHYJrHgh8XWL4EaCRFDuAipWyAbFZoh5vs
         81XZfnQTp9j6MaW0Xf3bCvQvvNJHVChFQrVfyO33ZJclJ9NM4u2fwoZKcPCaNFwVkSWt
         LEtVrbyadHCkgGONkWMISdKLnbcl6SdVVeywDclg1VL13F7HzZJWzEoejTn60iv4naDB
         QKvyvflCBSStAm1F1FxKPaMMtYtiqPMhNg1x32fwNBGM5i3jzOaO/B4SHrVz80muLLHA
         IFBRKt9H6ZW6/+LJ2TduLjZj8G23I9wNmbUOxnBpb4OzfjtzSSeftNzAbm2S1Qp2Evsf
         j0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFG4jDfz2qyerSN5ZvVoMbBfLupNJRD+IeJLBVHWr9ZZaYz44zLQNjwGjnPmXO/zXPNlCILdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSgasKZKqCCVdV1ekYuil16ts3NqUJVQvaHOcGsIjvtyJn7x4J
	Ds016Fpy/x7zk7+h4QwVmHM4d5YVpQcNu1U+p82g1TNDxUkg0Ns9Z8TlSYjjkJki0zBgivnigmq
	xkL9j+930mrFnLaunDjwk3ErR9Z5Bosbks3Fy
X-Gm-Gg: ASbGncv9ZIbuePpRczW+XsFKY9Md0h6cO29BjNSx8AeciZpSad4tLePIMBeiVNsoVTe
	ioaJpsrYT3RE89YSOVnEe1hQT3O+/GpkA
X-Google-Smtp-Source: AGHT+IF7RwvxlZD2PQdHXCgeP4HVt2yLSK+7YDK1+JcTpVU7zRalcku3n3HDgBLco8/sDIP+L+e4aznX1Arbf5nGkjA=
X-Received: by 2002:a17:906:32ca:b0:aa5:3853:553e with SMTP id
 a640c23a62f3a-aa6018d89dcmr459108866b.47.1733319505410; Wed, 04 Dec 2024
 05:38:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203170933.2449307-1-edumazet@google.com> <20241203173718.owpsc6h2kmhdvhy4@skbuf>
 <CANn89iKpzA=5iam--u8A+GR8F+YZ5DNRdbVk=KniMwgdZWrnuQ@mail.gmail.com>
 <20241204114121.hzqtiscwfdyvicym@skbuf> <CANn89i+hjGLeGd-wFi+CS=HkrvcHtTso74qJVFLk44cVqid92g@mail.gmail.com>
 <20241204125717.6wxa4llwpdhv5hon@skbuf>
In-Reply-To: <20241204125717.6wxa4llwpdhv5hon@skbuf>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 14:38:14 +0100
Message-ID: <CANn89iL+2NeV59p57bN+hc+vWB61DWWjRKAoit-=QHXC0C=RBg@mail.gmail.com>
Subject: Re: [PATCH net] net: avoid potential UAF in default_operstate()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:57=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> On Wed, Dec 04, 2024 at 12:46:11PM +0100, Eric Dumazet wrote:
> > On Wed, Dec 4, 2024 at 12:41=C3=A2=E2=82=AC=C2=AFPM Vladimir Oltean <vl=
adimir.oltean@nxp.com> wrote:
> > >
> > > I meant: linkwatch runs periodically, via linkwatch_event(). Isn't th=
ere
> > > a chance that linkwatch_event() can run once, immediately after
> > > __rtnl_unlock() in netdev_run_todo(), while the netdev is in the
> > > NETREG_UNREGISTERING state? Won't that create problems for __dev_get_=
by_index()
> > > too? I guess it depends on when the netns is torn down, which I could=
n't find.
> >
> > I think lweventlist_lock and dev->link_watch_list are supposed to
> > synchronize things.
> >
> > linkwatch_sync_dev() only calls linkwatch_do_dev() if the device was
> > atomically unlinked from lweventlist
>
> No, I don't mean calls from linkwatch_sync_dev(). I mean other call
> paths towards linkwatch_do_dev(), like for example linkwatch_fire_event()=
 -
> carrier down, whatever. Can't these be pending on an unregistering
> net_device at the time we run __rtnl_unlock() in netdev_run_todo?
> Otherwise, why would netdev_wait_allrefs_any() have a linkwatch_run_queue=
()
> call just later?

I do not know, this predates git history.

All these questions seem orthogonal.
My patch fixes an issue added recently. not something added 10 years ago.
I suggest we fix proven issues first, step by step.
If you want to take over and send a series, just say so.

Thank you.

