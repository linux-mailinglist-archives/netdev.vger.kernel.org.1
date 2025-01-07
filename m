Return-Path: <netdev+bounces-156023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C8A04AE9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5D61605B8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7DF1E25EB;
	Tue,  7 Jan 2025 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gbwIQhv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127518628F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281350; cv=none; b=CGAb3AVunDs0jHjuR8R6nvE7ve2ExG2ZuKIxfMFDp3vagQPCEfF5Vmcmns/hYCvaGInq6paFjtXM+J0/MM0wVRFyyPcZE4/pux8x11TGi6P/F0xpCF6K2mtW0E3PumARCTLgGMzDm7JnH5AuI2Fi06BRr0EGhAzYz+HdDrOkt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281350; c=relaxed/simple;
	bh=KGu02c+mQgBu3ajsC6m3fSzipPGcXqvvaUCD0L1xCVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgaAPcRp5YDC0EuuesHEGdJ6J9pf//whGNMnsG8IIc7acYCzsZuso7OHob4fLmR+2ernUQVD8ayHjo2MifnE1CqKyq01bLxXVmi4UN8m0jWllVwjkHNrzfJcdSmvfU2qlBnGzvaqDGv+vt7+7I5kAKk6+4IavCP6tkG7xx+d0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gbwIQhv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso27023641a12.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736281347; x=1736886147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IL56hJw8P1lu/KVqEyo+6ZkA7teC8aZbzd30utmTfKM=;
        b=1gbwIQhvE7tUKiPZbsVWfG1HvSH8AVq9qY3ZUQkv0BDOBiYLvcER6roIQ5cOLKtAgX
         YZ35V+ITh4cT1IUkYpIaAQykhCDZWq7bLhwtJY0prH+AVBnRARjjiEjWkxvd1Eo5irQM
         iO5BoJRWuarlL8nhTYAQajcV9GsI5AsW3LokyxwsOoPq3FegyLsOGFzCtJJh5e+XlDtp
         NxjWFRRnKUOpZSox/dmYnRmafVj9PLOdUwYmDpeUfrp6gajDenE6Fz27apzMg5WGKtbe
         Te5Xwz+xF1DGNuBIFIsHheUbaBbRFRf9Mv+Dor2GE8lQ8myOV4PVL1kc7BDhEr0wzCKH
         f99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736281347; x=1736886147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IL56hJw8P1lu/KVqEyo+6ZkA7teC8aZbzd30utmTfKM=;
        b=goTkvnsswOQT/+Y7x9m0QyE8ujm8ONss0vY5Lw2BUJGSqKsEhN7KvtFtcEf1m+TN2g
         TVPzCJmloMQINklMYMjBqXWP1egTpevLq98xMUup5Vj9REOmai37MK/NQFVa/6m8kTE5
         zBxhzUrcCpYp50RKTwjk0qOX2w9mPYelLqDLincISabGLigaMYwFF0P8envWa6zJKzSb
         C/VlLrzLW1HTewPnOZ/fzoRelX6X5OGoBo+w9VzhYIc0Z2MXJgcTtscF7NM8IIs4JB7z
         tcBePgj3Yvn3RNfVz+zZaL81BcQDq2Wm7PqRIllPfRfe3mmo03DLFxJm9uXBhOZPE6mr
         xwig==
X-Forwarded-Encrypted: i=1; AJvYcCVvvnTnocz/FtEyyuugyQcHVEFA/IGSNJGnwZc/lplCGnUPDjGRQb/sl+8pm6E84WXGw8Q0P3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzzcUVHmcv3DLuHivNH3H1KvNjFMrBouUE1IsY/TAKGtxSceH
	hBDwOko6q4HjlRPLxlLxHGm7D6LSSGpfH2BfCRpwKY7YJCm7SPzbKIq1vuJK3NzGbdl1CSgrSS0
	PNA35Ri3aDju27zhII+nBvTMq5gvg7xXieKLP
X-Gm-Gg: ASbGnct7vkWnBtiPkzseuhwGV74BCGLaJukwVrxO0IaPIFNC/BkBhi4WIkrBmKVvwZa
	tQ//eLm0zF6bCQPfOAqicFgKH/Qb2/od2Jif37Q==
X-Google-Smtp-Source: AGHT+IFiVxmmShH+FgxoJ4ovUCsEaJvD3PBwQy4zUgCW3cyEEKMImFtbnBLyU2CBr94ucRLaEiY3CykUjpBFLuKfw54=
X-Received: by 2002:a05:6402:5194:b0:5d0:fb56:3f with SMTP id
 4fb4d7f45d1cf-5d972e0e341mr449209a12.12.1736281346732; Tue, 07 Jan 2025
 12:22:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107173838.1130187-1-edumazet@google.com> <20250107121148.7054518d@kernel.org>
In-Reply-To: <20250107121148.7054518d@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Jan 2025 21:22:15 +0100
X-Gm-Features: AbW1kvZmiyUXOzrSa_NMyCsvpI6FbMtpe1WgEa2d8U_njlNSTnvLM7Qhs7DeGDw
Message-ID: <CANn89iJkxX1d-SKN6WVJST=5X7KqXdJ+OKcCVDEFCedJ7ArSig@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] net: reduce RTNL pressure in unregister_netdevice()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 9:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  7 Jan 2025 17:38:34 +0000 Eric Dumazet wrote:
> > One major source of RTNL contention resides in unregister_netdevice()
> >
> > Due to RCU protection of various network structures, and
> > unregister_netdevice() being a synchronous function,
> > it is calling potentially slow functions while holding RTNL.
> >
> > I think we can release RTNL in two points, so that three
> > slow functions are called while RTNL can be used
> > by other threads.
>
> I think we'll need:
>
> diff --git a/net/devlink/port.c b/net/devlink/port.c
> index 939081a0e615..cdfa22453a55 100644
> --- a/net/devlink/port.c
> +++ b/net/devlink/port.c
> @@ -1311,6 +1311,7 @@ int devlink_port_netdevice_event(struct notifier_bl=
ock *nb,
>                 __devlink_port_type_set(devlink_port, devlink_port->type,
>                                         netdev);
>                 break;
> +       case NETDEV_UNREGISTERING:

Not sure I follow ?

>         case NETDEV_UNREGISTER:
>                 if (devlink_net(devlink) !=3D dev_net(netdev))
>                         return NOTIFY_OK;
>
>
> There is no other way to speed things up? Use RT prio for the work?
> Maybe WRITE_ONCE() a special handler into backlog.poll, and schedule it?
>
> I'm not gonna stand in your way but in general re-taking caller locks
> in a callee is a bit ugly :(

We might restrict this stuff to cleanup_net() caller only, we know the
netns are disappearing
and that no other thread can mess with them.

