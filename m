Return-Path: <netdev+bounces-141926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989C9BCAAE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904881C22254
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E714C1D318F;
	Tue,  5 Nov 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yAOIQocg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4A2EB1F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803244; cv=none; b=VWkv5gTJ0mCzzts0X4jZndlS56NIn47zEfFg94CSwUSCu9XoH5nhU38lz8kksa6STvJNBrtSZaKdfnpSrSx3pLfyAkpw+qZQHD2pnhpd2sJ723RQnUwQbxI1JHH+BSz9TInhuYi3PoVcyPggSzS/FGXdFJE5XP4hPUO7VSRQung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803244; c=relaxed/simple;
	bh=UYq+/Xep68Yu0wD2CGvQWYqsE/YtBdpfi6L0yheoBws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2ZWwVn36dNo/QqGP/wHx1ifcSDpCHiDh480tokIWZPFq4D3LwyEJ3bSVUn9CREtsIo4wUNjkotZaNOvjHBgjRZjUNCa9IC84toDh0VO83AseXYrGUo3zucdfMadI8+asSyXJ1VCR6HaUTFIlQvkSuO83XdeUU8bYs6o9RxRxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yAOIQocg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso11090670a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730803241; x=1731408041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYq+/Xep68Yu0wD2CGvQWYqsE/YtBdpfi6L0yheoBws=;
        b=yAOIQocgzZvwWP/sFKMaFYEMCcMBZpkO+xsNbBOg6qn0IGWZHQV+LKTL5VVf7fbmRb
         hbBXWQqMpsshh0MWAt8LwgK7HLrdqoVnoBJwV/qvS7O4bJVqezgJDv11LFu+RqVpLaye
         aCFVY/1+fSu0mSeZ2SZUJa+WuqT92LAcVvbAiplbY7TYeamU+XDy7ntg/I7pWcmj5qoJ
         vvSI+xH/QdVMhdpkr4vzvMuMWbfs2y1bDMd223qA8JxqEGwjKo46xgM+CiICJHDQEOGX
         O1Iip6EwHvvdF1o60OS3i1jVkFiSr0rMAB0RheLVPOxk+toGxclhaGtjhepFvq0gGrgR
         pjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803241; x=1731408041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYq+/Xep68Yu0wD2CGvQWYqsE/YtBdpfi6L0yheoBws=;
        b=C0fky0rsuju2kwF9qBLXqjN0NQO5kQKxtqqxmtQyppbCl0+kI4d206ZXCXnXP5ands
         32ITW8KyBTVsU0lj5W2vj54GMe9ySn0ElSvcd0IQVonCjvFolu96uLG74CxHEiSZqzEm
         n9R5ceCaeWh+9sXQlQ13dHWpKvqsct8+fG/0SZFBZ1ShSDbCnFn6DaWuOOiRDqBKmIuU
         Af1aUUPgHaFAi/JN3lhsTPNN6CuhXKaz1Ylxo9YDYSi+rvB5ZFYX9S4tdtWYpYSlr/Cq
         E/alpSIJdjeKMG2r+D7dGj7qCNzo/HUFfNauCjNx0OVk79yXP6IziBKPCi1zM4cMrYeo
         S0JA==
X-Forwarded-Encrypted: i=1; AJvYcCX6KAlIRCwsBzdS7hlLcMBdiqt5P6cVWWZP3ToFcmnShG6P5OFc9LhpT0DAkWcZBPHbtFDTRXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXT2nKFdi2Pec549bQ05jn66gLaDg9tskO/uVJOE9BBMu9Lpu
	MSH2AzJwCiR0+MCYAz2/a1YjB0I0rVLZmMAi/1fvs+8bmaivKNPXBbqaDduCsnoXn43alAAF80/
	p/ED4IQEQc6uVUILHUQky+irrzr9HMrGvBrsN
X-Google-Smtp-Source: AGHT+IFEaGN/gCrfHG0fqHACFo9uED/Lexrzpb/Fjch1RmmGkROfeN56pMpizymmPVnchYTxCCZK4VmAHvbOWFWlJGw=
X-Received: by 2002:a05:6402:27c8:b0:5ce:deb2:6a8d with SMTP id
 4fb4d7f45d1cf-5cedeb26affmr5471976a12.0.1730803241241; Tue, 05 Nov 2024
 02:40:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105020514.41963-1-kuniyu@amazon.com> <20241105020514.41963-8-kuniyu@amazon.com>
In-Reply-To: <20241105020514.41963-8-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 11:40:29 +0100
Message-ID: <CANn89iJy7BQ=sxH4kNYw+Z6nBFQ3x8NMBwRE31suVVhj6PUGyQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 7/8] rtnetlink: Convert RTM_NEWLINK to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:07=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> Now, we are ready to convert rtnl_newlink() to per-netns RTNL;
> rtnl_link_ops is protected by SRCU and netns is prefetched in
> rtnl_newlink().
>
> Let's register rtnl_newlink() with RTNL_FLAG_DOIT_PERNET and
> push RTNL down as rtnl_nets_lock().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

 Reviewed-by: Eric Dumazet <edumazet@google.com>

