Return-Path: <netdev+bounces-205218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E45AFDD18
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB491BC82B0
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A8186E2D;
	Wed,  9 Jul 2025 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+6gog+H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5E483A14
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 01:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025975; cv=none; b=WhzJ9mNwFn7Fz9ust3kC8iMf11l3L1mppSpXNO4VsC3n1awL8T4Ochcc5QxEwEOKX/gxhbwZlZuJNSAbebpEc/0CUJ7QoqLJKY0GpP5G3UtNNrLmk1TPl6OdJThRTNmCbJZ24CAvHNhiIOx62u7LWnmUxPFmkwmkLr0cMTqYMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025975; c=relaxed/simple;
	bh=uXY75qkO85uGaJT0XbhRsvz6fBDs3XVrR8xxBxjc4h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBd4tF1YIf5zb0PwYRJOTKXltXnTEVB3Y6H0mfEMtXvwPMWSIO0neEs37iQ4HNqMO9Z002VE5c/xY1lpea8pkfmuNsm6C3xGWA1MsGgSVLpiHs3ZEu0QLIsWLk+Nd9UldZaG3iNrouanD5qZe/8O4iuOmUZS7AFWbBXuMn6qAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+6gog+H; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313f68bc519so3756055a91.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 18:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752025973; x=1752630773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bQ4wgx+2JWo2XTLa+CTTEapq/z5N+ZkXKfxyDQpFFY=;
        b=Y+6gog+HWVqLJKWHjbrjoG8rQnxKW4twyqFJpd95MtYyHxuBYKRu7kNx8E29fwnp5c
         FYIKAhtcHebbjwvbBlUU/G4eBXJRDx+A7EjTjCN84EJvAHnyy7toIBd+yTklDCtKwK3i
         BibuBRRNSH5iqE+YPPgX6hvKKLwo3XjBQLK+R+jXKmVFMFyycYf4GZjTAhD0rOMxXdXS
         DCeS+cHx5l8yOOMLD6ioB+L43RQbkwV4cLGVeI5wmvCGVqtudq+zrREiOy2RV9y8EAF3
         HNsY8qpw4/PMQHhxSybRv00XVw1w12NpqRXVIxXldkQu9Muz9ix4ghX10nXoF8KygZZL
         b6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025973; x=1752630773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bQ4wgx+2JWo2XTLa+CTTEapq/z5N+ZkXKfxyDQpFFY=;
        b=kWryrNs72BWifGWtMaOvethTApLSSYzR4W0yiZ/c5D9RM/ew1SHtcnm0Bw31uQKqsB
         pH+GExusDjos25rRFU7sY/UV77YnwH2qim25iW7jxI3YaD46o1h2CgXfJxXjmUbHW9Ai
         dkdOizrkUo58Kk116w6WmaC60uhjAM+qmTJwfeP9z28Phek7O+dc3ILd0VZyCUlx87ni
         /95uguZgqnz3ndHAh+Zyv+Ab2WrWXPIb01hV2i4JIrIRQ6P9LxXJjdGREqix5tohKLjZ
         UUqyBUnBAli5eq3yOc5NSgjmdBUMzxS4fT9ojk4T1FmSENNVR37RJtQj8A/Cg+JN1yvc
         mrzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8MNF70Wp79JneyV6xQYNUQ1khmfpUp667hF80TgTQ511ZMqMYUu4jftcfzn54QamxIOCRhec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvVBcQKwZVzZPnHoglZ+z63Yei8hmDYCBI52FeFevnWEJ4BwrI
	wrUaC/MWvmwrTacMcTuZuNlAj3nH92BK/TJk+GaNs5aYtbYmh1DLcuWuDLCI3FlPi3GlGavWTxW
	L2MCAEkcBf8qw7jw3m7/qSdOGb4UVKNv+1sCk4Toh
X-Gm-Gg: ASbGncsIApk5NL8ARQlalUjvWojUoOcGSabq8lNohmlGY/7WYBzY2yGlBgMldkwqhWL
	AWcLtFt2CbQSmkqlvrMRYdYXDqIOYgPyXpeGYQ4qbLb1/3Sk9wq+c2CeEROuk74aeueXAhTfKZB
	LYm+FsHpViXIJi/Zr+fTJkES7eNnwv1w6LxVWukeEfQ1wY/XUdjOZxsk10nC8oHsDnvP8MOOccd
	/sm
X-Google-Smtp-Source: AGHT+IF7VCWfbraD7E36V8klmNG9ZRUKFM3wUIkcKET6jyL8lezlzMtH/bmdIIDwb8T33gvhPcYy4wVuqGHp6HvD7Gw=
X-Received: by 2002:a17:90b:578f:b0:311:9c9a:58c5 with SMTP id
 98e67ed59e1d1-31c2fce6cfcmr1241576a91.12.1752025972935; Tue, 08 Jul 2025
 18:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702230210.3115355-1-kuni1840@gmail.com> <20250702230210.3115355-15-kuni1840@gmail.com>
 <20250708184053.102109f6@kernel.org>
In-Reply-To: <20250708184053.102109f6@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 8 Jul 2025 18:52:40 -0700
X-Gm-Features: Ac12FXzQkscnDQUx_UqDLL_0dL2P96mW2KCHGDZKJ-_xm2vv3mfDpvRzGcoPTBI
Message-ID: <CAAVpQUDNf_pwg+RvcTGCBVF047HX-BfaKa2ddiN_StLeJkNQFg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 14/15] ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  2 Jul 2025 16:01:31 -0700 Kuniyuki Iwashima wrote:
> > -struct net_device *__dev_get_by_flags(struct net *net, unsigned short =
if_flags,
> > -                                   unsigned short mask)
> > +struct net_device *dev_get_by_flags_rcu(struct net *net, unsigned shor=
t if_flags,
> > +                                     unsigned short mask)
>
> Could you follow up and toss a netdev tracker in here?
> Not sure how much it matters but looks trivial, and we shouldn't really
> add APIs that take a bare reference these days..

Fair enough, will post a followup :)

