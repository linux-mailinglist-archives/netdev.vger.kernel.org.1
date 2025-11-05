Return-Path: <netdev+bounces-235844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BC0C368B8
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ABFE4FE70C
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152A22FAFD;
	Wed,  5 Nov 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vo0qZWCG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CC7260A
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357817; cv=none; b=T81w68q8RLOCYcwmP7w03I6D0cQtdjf89RuKkZXOhvykxUavbiECHmwrR71sWPXCs8UaFhWDvG9MHRSpIFDYcli53S7gpOXjLoB7NRsm81+bilVLv2DCZZguBhdjDOgPuZgoqgd2Y4ZSw89WhLUoi66RQRnNumxuKDnKHGlP2yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357817; c=relaxed/simple;
	bh=hdq/GVI2SGoWK138x7X8PKK2wycYlsaIeDm/ZhRRxLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAtRNeeDHa4BahO/nXEEsXUvHbGXwGmfqxwrB4R7z2IvLcLk0YNXKrDfrr8TmWtIZtlPkjI9u0BzV4IcdylDbZgzOW0WboJzF7bfrKPLZ1qJ4I0e86I7hnPug79CO8fNRYLFrpcd2HJmk2EEcD9kVeBMAEcJDspkbNxRToSZd9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vo0qZWCG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed79ad2846so6938731cf.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 07:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762357815; x=1762962615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqiWytgC8JjSUZSjwiIgPuw7W0sj8LhImNjBhccChSg=;
        b=vo0qZWCGl/CRh/DKrpIwhUvL0V5/IBELS+92E1anvC3w4T3cJyeK01lfWRyQsZVzx1
         AC22gjUUY55Jxj6+DiKXjbpj6x3NXSpYvXUAaXgx2uNLS8euszhnbctAx72yZ7t8KhPd
         GygLmIVDmddAwHx1wKxgJCbm1ANnyHxUjVst/v3LQkG4pUFWY77RnHLSVZOBbB5otAiL
         jbb483loI4Vpknfhpza1irIqYhDCUUJG5dLG1wucGI2ojc3TAwRiJid9elc3ubE8ZOz+
         KG4ve1NZAGAxNHweQPInM7OKcMMsPrMRvoaaLjAIyUL4M6k8jbumEgDw2KIMfay7R++h
         yTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357815; x=1762962615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqiWytgC8JjSUZSjwiIgPuw7W0sj8LhImNjBhccChSg=;
        b=A7FtS2sQtriXkAJoPEDhiYzKNNtPnM8ZHGvSFEzWApGo7dLsXUbT1LgD4OVG/dkkoP
         gWYOJ7yk6hWEG/y8hlUkui18CcqsMlBHqn6jhlhyeTiU6QiD+F9L6RMJYDGta208m4s6
         PmvpBNkFKjsXIyCmTzC7uoRZgZEQI6uehsbeHYrjHdLlOta6H3cNkKD7LxVdl9Ch6HQw
         t4Yczr4um8iPZujgQmVguT3KWjUr5ei4MSQB+RGZMxTmrS+Hmu6XquN/ZRf4BcaxDkga
         XnLVEj+ba+3amBK45mO0j+zE75BxsAedTArkM4NpgV+F8nfWXgISjuIS0d2cGCIDrzTz
         t6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXejqm8qzHYtDw4HBIrgtL1lumLzyhy2ktrBOv6Bb2Fewqc8U/9OebfIFwALsyuJHwMSAdH5Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Y3BM6/9dwP0kxfEWVdchbVhhgVEYHo9/X7w6z5QfZtbpyA8e
	YIILfTglA9c939ygGbsxeocHxhaGGtcox97y78ZxzpfGDJlqsDwGw6r902ia8eKDUbFymkJv5D1
	8+4bQuOsP5VqjbMOr6EPph3XbSMNQiZ9C4REoaLnc
X-Gm-Gg: ASbGncs7XDxy6tzf+Enm02F5Ye8exO6j8O/1VhiT0XX2NNSNP0FvWSYA1uTPoNfQIVu
	ODCd/3Cc6exMWocrwOY/KfscOZw5RxlNxVH35+tvxTDKD6H7UYA/Sqm4z60Ze3hI5kyPNlBK+/1
	Ol78NVIdTIuFjFu6WEcwmB2pu9jlm2WWUgVGt+CQoYgHr0wUuuHHgrx1RK7AA8eNbPgKWWjmy82
	aftEuacejBgh4zn7DBiIBYegk60mMROnldgHGkr5fO0Ph2UAmUkDy4pk3xJtVfCxjCxb14=
X-Google-Smtp-Source: AGHT+IGL7epoV3JxPuVAZBmXv50n9ruWohYM79Cz/AFuK5389s6ymRdaTVuwUkUv8UHdtPghyl5+rpr7nFVp+k4bPA4=
X-Received: by 2002:a05:622a:50c:b0:4ed:608f:b085 with SMTP id
 d75a77b69052e-4ed72330116mr48188281cf.13.1762357814466; Wed, 05 Nov 2025
 07:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
 <CANn89iL9e9TZoOZ8KG66ea37bo=WztPqRPk8A9i0Ntx2KidYBw@mail.gmail.com> <aQtubP3V6tUOaEl5@shredder>
In-Reply-To: <aQtubP3V6tUOaEl5@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Nov 2025 07:50:03 -0800
X-Gm-Features: AWmQ_blOVSXRRuKdEbWUc_1BRTQAqNrcY5trU04c5gUTWWYtSlNRJ5P-YSXs5vg
Message-ID: <CANn89iKg2+HYCJgNBMCnEw+cmJY8JPk00VHkREc_jULuc6en5A@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
To: Ido Schimmel <idosch@idosch.org>
Cc: chuang <nashuiliang@gmail.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Networking <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 7:34=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wro=
te:
>
> On Wed, Nov 05, 2025 at 06:26:22AM -0800, Eric Dumazet wrote:
> > On Mon, Nov 3, 2025 at 7:09=E2=80=AFPM chuang <nashuiliang@gmail.com> w=
rote:
> > >
> > > From 35dbc9abd8da820007391b707bd2c1a9c99ee67d Mon Sep 17 00:00:00 200=
1
> > > From: Chuang Wang <nashuiliang@gmail.com>
> > > Date: Tue, 4 Nov 2025 02:52:11 +0000
> > > Subject: [PATCH net] ipv4: route: Prevent rt_bind_exception() from re=
binding
> > >  stale fnhe
> > >
> > > A race condition exists between fnhe_remove_oldest() and
> > > rt_bind_exception() where a fnhe that is scheduled for removal can be
> > > rebound to a new dst.
> > >
> > > The issue occurs when fnhe_remove_oldest() selects an fnhe (fnheX)
> > > for deletion, but before it can be flushed and freed via RCU,
> > > CPU 0 enters rt_bind_exception() and attempts to reuse the entry.
> > >
> > > CPU 0                             CPU 1
> > > __mkroute_output()
> > >   find_exception() [fnheX]
> > >                                   update_or_create_fnhe()
> > >                                     fnhe_remove_oldest() [fnheX]
> > >   rt_bind_exception() [bind dst]
> > >                                   RCU callback [fnheX freed, dst leak=
]
> > >
> > > If rt_bind_exception() successfully binds fnheX to a new dst, the
> > > newly bound dst will never be properly freed because fnheX will
> > > soon be released by the RCU callback, leading to a permanent
> > > reference count leak on the old dst and the device.
> > >
> > > This issue manifests as a device reference count leak and a
> > > warning in dmesg when unregistering the net device:
> > >
> > >   unregister_netdevice: waiting for ethX to become free. Usage count =
=3D N
> > >
> > > Fix this race by clearing 'oldest->fnhe_daddr' before calling
> > > fnhe_flush_routes(). Since rt_bind_exception() checks this field,
> > > setting it to zero prevents the stale fnhe from being reused and
> > > bound to a new dst just before it is freed.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")
> >
> > I do not see how this commit added the bug you are looking at ?
>
> Not the author, but my understanding is that the issue is that an
> exception entry which is queued for deletion allows a dst entry to be
> bound to it. As such, nobody will ever release the reference from the
> dst entry and the associated net device.
>
> Before 67d6d681e15b, exception entries were only queued for deletion by
> ip_del_fnhe() and it prevented dst entries from binding themselves to
> the deleted exception entry by clearing 'fnhe->fnhe_daddr' which is
> checked in rt_bind_exception(). See ee60ad219f5c7.
>
> 67d6d681e15b added another point in the code that queues exception
> entries for deletion, but without clearing 'fnhe->fnhe_daddr' first.
> Therefore, it added another instance of the bug that was fixed in
> ee60ad219f5c7.
>

Thanks for the clarification.

