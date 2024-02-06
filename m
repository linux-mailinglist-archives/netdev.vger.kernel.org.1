Return-Path: <netdev+bounces-69429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B187A84B2BF
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 11:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40D21F22E68
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 10:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461E249ED;
	Tue,  6 Feb 2024 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBeXu5dg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63C1EB24
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216520; cv=none; b=nOqnoh/HSXDQ9TKobSa9iYC6TtFWtDUTQ1nt2Xt9eDwlHDBVJunUztCHnIh6gpEsIoASuIpVpx17H03cH/gKzWovi2foFHhd8GYUgSeE7S/fdGXacxtJHsWN3wfdyvBKJRuX/VFjcbFyk90CBjCQFxp4PaQlFE8iQcWMB6NvKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216520; c=relaxed/simple;
	bh=fGGDHXUha+2zTeF096dLaiq29M6Tm49oZoffiXDJtfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kbc0ozF10EG932TOO85cFrPpg840jVPKqDRXCEZ9xtzhpdB02IKpkziZ/HOPgfH907sF94Se5ueMHXl9H/0PguD/m9E34T10WYm46t6BLy0CKjVoROdEz5DDoSywyGFRXWNPkjDnfC8zZZWAOhUMoAd5DcErussNs9RqBC/Pis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gBeXu5dg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56012eeb755so13003a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 02:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707216517; x=1707821317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvUjtGOEcgOKfh7gW64HNwi1rSM39LFV7us7o5tDLhc=;
        b=gBeXu5dg156eOvT3YZOiWP/n2RpJ1hXUYUXpr70FOpkI9v3+ZsMvok3gPSISISYnGf
         Nb7xc43uUf+cpxJXtj3qLvVsKxsXZcSTO/DQWQNJO8Rflkj6J4hayUaySp9+c28Rpws+
         JtZzOVbvV4mxUAgi1O/rZlk7oU2bYkMcKzyX/jMTnxAO24iQSxPhe04WWOyGklKlIzNk
         Qnha43goED9rsBNJEOfRPdvyu7dNtRddntwyR6byujVQ+l3B+C9bS4G8ly7+ZlKKwU/4
         ByyPzSRzLbbzDQURBeyG4Pwqt83wUOCYSF3AHIud1fZLTj5b2/IRrx3Pt/lu++tbIUzP
         Fm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707216517; x=1707821317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvUjtGOEcgOKfh7gW64HNwi1rSM39LFV7us7o5tDLhc=;
        b=GP0EtMbwzx8ZPzkJwTQA8+9/fE+WBhlLsXFcTNTFcMbbE6Po1aFF3bpQYqwlYaO0SR
         xzUtqs47DGsTlvKPylIK+xYY6W3enOMGRZtgan1W11Nsdl5cE5WA2Aba8jO6uKRBckoA
         8LM2twfrQ5rKA0LFK/T5qOQfi0HumMppFy9SHHDlPS05vCGptvoAFKKQxacR9OD8RLjS
         XwYz2++5qdkp+vIoYry5UqLZBmeU3v+yrPtgt9DvAIGqRvWkYSF3+x4YvC0LDKLkdEAk
         pwd8zcUg7t6GJoE9Nt4Nr5o+oEuG1C31ej1RRYV5E7f1tHQ+k5gtsNQ+FnjtzUDMEt1Z
         EtzQ==
X-Gm-Message-State: AOJu0Yy9kRF895+FtwXfElP2NyKjHLsw2gKZBQ2wawqKIAqt1ic8PNrH
	tafNf7cA8v8/7Zn4iVzELETIWwWSMINs3CYAylfARKDzHTcrNTE3WSYEH6Hx/rV/BjlbuVkae/W
	QavwTZSOXIcuTFSJdMZkWaLGHvnG3f9XKA/13
X-Google-Smtp-Source: AGHT+IFo9yAIEbHhpMtWVlQSkwD6R0m3hyG4LELsOp8OvIC8iZevPoBu1I40t3Byt5h9R4th3dFoK1NTfGWjBH8pffM=
X-Received: by 2002:a50:d59d:0:b0:560:1b3:970 with SMTP id v29-20020a50d59d000000b0056001b30970mr109986edi.7.1707216516785;
 Tue, 06 Feb 2024 02:48:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com> <9ee7f0562ae3c646c4c362c5e1ed19f31e0f8dd4.camel@redhat.com>
In-Reply-To: <9ee7f0562ae3c646c4c362c5e1ed19f31e0f8dd4.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Feb 2024 11:48:23 +0100
Message-ID: <CANn89iLtwdkcfTdZqQo-=NPJEB38rKjy-zuoqn3GP+H4gHxCwg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 00/15] net: more factorization in
 cleanup_net() paths
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 10:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2024-02-05 at 12:47 +0000, Eric Dumazet wrote:
> > This series is inspired by recent syzbot reports hinting to RTNL and
> > workqueue abuses.
> >
> > rtnl_lock() is unfair to (single threaded) cleanup_net(), because
> > many threads can cause contention on it.
> >
> > This series adds a new (struct pernet_operations) method,
> > so that cleanup_net() can hold RTNL longer once it finally
> > acquires it.
> >
> > It also factorizes unregister_netdevice_many(), to further
> > reduce stalls in cleanup_net().
> >
> > v3: Dropped "net: convert default_device_exit_batch() to exit_batch_rtn=
l method"
> >     Jakub (and KASAN) reported issues with bridge, but the root cause w=
as with this patch.
> >     default_device_exit_batch() is the catch-all method, it includes "l=
o" device dismantle.
> >
>
> I *think* this still causes KASAN splat in the CI WRT vxlan devices,
> e.g.:
>
> https://netdev-3.bots.linux.dev/vmksft-net/results/453141/17-udpgro-fwd-s=
h/stdout
>
> (at least this series is the most eye catching thing that landed into
> the relevant batch)
>

Interesting... vxlan_destroy_tunnels() uses
unregister_netdevice_queue() instead of vxlan_dellink() :/

So vn->vxlan_list is not properly updated.

I think my patch exposes an old bug (vxlan depended on
default_device_exit_batch being called before vxlan_exit_batch())

I will fix it, thanks Paolo.

