Return-Path: <netdev+bounces-146532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DBD9D40A2
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03160B27B0D
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C10513AA31;
	Wed, 20 Nov 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGcZWD5O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716124B28;
	Wed, 20 Nov 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119236; cv=none; b=YUIFACCxnqWibqrNzkuyLcku+fuUgG9r3Gg7aJgEexiG+4ujluYJf4dh31hM235pmt0YTBAdu+FpVKnuAQYx3jDTadM/mf+zAYAsWTu/gqbNDnG2Kl2uVUndJj+tPeEAS7UNfrIOtNDMHCoztR7jxH59Za55I5FAzXwpSZYZDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119236; c=relaxed/simple;
	bh=6dquPXmcvzZwZ7UNLGSo/e4SmGcQLkWTt1lEOQ8mB38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/s5nuKoaghxdV5flRsYcGuiBga6fPLOOnm0itVtwMetr3lWhanCa9f/x9HmMEhgN3jgFcEO72TxIlh02MvEiNl2Q1mFIO7amBIYnWKO8KVK1Req3hk5BRhPRcKI+wzhykaXwGpAp7g/PlwbNmDmoPT0GG+HzctlpefCNb40P6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGcZWD5O; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ea39f39666so1746680a91.2;
        Wed, 20 Nov 2024 08:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732119234; x=1732724034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/HvFtGjqZ7DcsQBtPnZM2lJlY596mswDKkJjhdWmKo=;
        b=FGcZWD5O3hfsMyXxP0ozMB+yAgAt45yfS1FM0+7QcBcDeDxpQAPIcHK8XQc10L8AhS
         zSrOcAZRvurmpxk1PFret34fG+aV7uiLmQpSHozcFHSk0Pk74Uy+4wQOXyrHJyMMdX7O
         cP3BfU1U40Rz8oZsKyuUHvrT6C/KDaiMAELs5kcvh213wA5DHQk1AiSaonPxq0fUT5rG
         eBU626A/nUSmGTO8BgL/glm/R7MyLMJB0ZLz6ssnSad8QFpV3ROvaTwtVa5BObLYisrF
         yJlkoz7/khm67qYPCkqZizqeOJtDPFu7H1VWX7UO6hi8INsZFd29O4Mlb5q7GNr5413n
         spGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119234; x=1732724034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/HvFtGjqZ7DcsQBtPnZM2lJlY596mswDKkJjhdWmKo=;
        b=pokbJOWb07ySR2yXOa1RG+rWAHEAM3wzHFR5r5OO+6jvkFpcwS1yMsBXMryyPGCTI5
         UYKceO8UkT4QyXyVFD/cDE2kRe8/xCgsv7ZWol/T1jHLk934R3j3AaVmtepbKownKgN1
         dsn+vzSCA+9dJ7dqJ648Hd3Tc3Uo/y4NCXBFDF+X5VNAojovFIvP2+R/1M2fgw2uTO/D
         N/xcyIaLVVQQH0OgkxgtjKVEXV04GydSTbLas4EeXpjUUN3zWH16rDnnwOBSaS1m0sTA
         z33PSJKlUcDVJvO+sSVci33pnZkm+yqhzjTwUvFY+uCcEcTgKninCZUloLmodOL6Xq6z
         5gxw==
X-Forwarded-Encrypted: i=1; AJvYcCUzV/kMAfQOJsVLY0Q5yGDNs7In5kzQekbQNMMk86e4+YbbCVUFRIIJLBMvkc7JvyEldamQFY6rZ/sGVrU=@vger.kernel.org, AJvYcCVMWuDNkSiG0Uh4smB95zwsXF55V84Y8zDnM1MKzYXOKr0EGPxc1JXPswsSEckCPQFJJrpLnbuo@vger.kernel.org
X-Gm-Message-State: AOJu0YwpbcD7fcSZ+IEZZNRZMI6roEcZeQWQUICj6TagCOzJF+63PrRL
	mMFF1hPtWACw04LkllgjaDVPLwlteH/2bf5r9w348oPCYkB/4iX2PQEz4kWMBVc7I0XyRQ1Cz73
	KZtLlbGZmuJ0vuoFojNosdUTgagQ=
X-Gm-Gg: ASbGncvoknzbhPw2SgLlC2rE8XPVJJO5vepEW8khbx0dxavvF+zT4b0qPNNC43lEJbx
	i6BjJk+91UXHxHx7d/GBiK11V/sdsMDzKLDDXV/ESMIuoJRn2mO78/iun0b0T/Mz/6g==
X-Google-Smtp-Source: AGHT+IErlhHptHLWUZGmZIkis6XudrtzEe2+Y6fasY0LMn8WKG3iKlKQo1A0945v3nmksbHGL01UbUnKq6YQMAdMEdA=
X-Received: by 2002:a17:90b:5310:b0:2ea:819e:9126 with SMTP id
 98e67ed59e1d1-2eaca7cef44mr3317485a91.26.1732119234049; Wed, 20 Nov 2024
 08:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241115160816.09df40eb@kernel.org> <7fb38122abcbcf28f7af8b9891d0b0852c01f088.camel@sipsolutions.net>
In-Reply-To: <7fb38122abcbcf28f7af8b9891d0b0852c01f088.camel@sipsolutions.net>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 20 Nov 2024 16:13:42 +0000
Message-ID: <CAJwJo6ZTT28XZ1HFhC77KrPeFmwVWDkFzYsg7YU1MD0PESAWrw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ivan Delalande <colona@arista.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 08:44, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> (Sorry, late to the party)

Thanks for joining! :-)

> On Fri, 2024-11-15 at 16:08 -0800, Jakub Kicinski wrote:
> > Would it be too ugly if we simply retried with a 32kB skb if the initial
> > dump failed with EMSGSIZE?
>
> We have min_dump_alloc, which a number of places are setting much higher
> than the default, partially at least because there were similar issues,
> e.g. in nl80211. See e.g. nl80211_dump_wiphy() doing it dynamically.

Yeah, your example seems alike what netlink_dump() does with
min_dump_alloc and max_recvmsg_len. You have there
.doit = nl80211_get_wiphy,
.dumpit = nl80211_dump_wiphy,

So at this initial patch set, I'm trying to fix
inet_diag_handler::dump_one() callback, which is to my understanding
same as .doit() for generic netlink [should we just rename struct
inet_diag_handler callbacks to match the generics?]. See
inet_diag_handler_cmd() and NLM_F_DUMP in
Documentation/userspace-api/netlink/intro.rst
For TCP-MD5-diag even the single message reply may have a variable
number of keys on a socket's dump. For multi-messages dump, my plan is
to use netlink_callback::ctx[] and add an iterator type that will
allow to stop on N-th key between recvmsg() calls.

> Kind of ugly? Sure! And we shouldn't use it now with newer userspace
> that knows to request a more finely split dump. For older userspace it's
> the only way though.

Heh, the comment in nl80211_dump_wiphy() on sending an empty message
and retrying is ouch!

>
> Also, we don't even give all the data to older userspace (it must
> support split dumps to get information about the more modern features, 6
> GHz channels, etc.), but I gather that's not an option here.
>
> > Another option would be to automatically grow the skb. The size
> > accounting is an endless source of bugs. We'd just need to scan
> > the codebase to make sure there are no cases where someone does
> >
> >       ptr = __nla_reserve();
> >       nla_put();
> >       *ptr = 0;
> >
> > Which may be too much of a project and source of bugs in itself.
> >
> > Or do both, retry as a fix, and auto-grow in net-next.
>
> For auto-grow you'd also have to have information about the userspace
> buffer, I think? It still has to fit there, might as well fail anyway if
> that buffer is too small? I'm not sure we have that link back? But I'm
> not really sure right now, just remember this as an additional wrinkle
> from the above-mentioned nl80211 problem.

Yeah, netlink_recvmsg() attempts to track what the userspace is asking:

:        /* Record the max length of recvmsg() calls for future allocations */
:        max_recvmsg_len = max(READ_ONCE(nlk->max_recvmsg_len), len);
:        max_recvmsg_len = min_t(size_t, max_recvmsg_len,
:                                SKB_WITH_OVERHEAD(32768));
:        WRITE_ONCE(nlk->max_recvmsg_len, max_recvmsg_len);

Thanks,
             Dmitry

