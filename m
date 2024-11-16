Return-Path: <netdev+bounces-145529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D78249CFBCE
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 01:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596701F2468E
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A6D6FB0;
	Sat, 16 Nov 2024 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aONG1nuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C117F9;
	Sat, 16 Nov 2024 00:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731718110; cv=none; b=pvpDtwbKI6nPfzhRMmOnGGrw4QT3xUk+e9XDbAvvRfRf7j8pzKqLsO1CZ08lgEd3yjGPADlQ0isK5kEk5WIIrvComuxB8bVsiwzCPjhhlsxtpxpBIkGIuivJLJrCIxHvHDF6k9Qcuz+Vn5vHdfP/JwPcB3y8xeRbm15JyZ18D9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731718110; c=relaxed/simple;
	bh=49ueMG8rb3FQrZFTX8PW3sDknRQrkuE4tViA0W2+A28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rme+A8hP8oGEpJ2uSvHCcZFwL6T+PAfHi4OmgmMLY3QkfJStaBNdMRc9ajE4EQON7FUHY2UI5GESGlDVfTDsR9Ubk+NwCAb9Jw7SeBBXptivsRyS0BFHaZeipsZMHq80MVZF0OuWivpPgWOLY4ArENU1+vLR7xZQwmMy/BP7z4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aONG1nuZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so1882686b3a.1;
        Fri, 15 Nov 2024 16:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731718109; x=1732322909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mqC4e7dkIu4h/ZLwmpdE7OAWIL/wo4+luIERmBwFhs0=;
        b=aONG1nuZjS3DsKIPYgk0omO/oNWqoIusB9rLXOMUc6J9jn9iDHxqm+S2SvvatUDJ6K
         xvArAXz1MRXSfQ9GIZyu03uBB87CNKiQO5uCbwFe/6/ORwTJbKje0DpxiIMmsoAPSaWI
         ddO2Rg77XHYT9riwGU1k3VQqL3xfOXnc6RMiPSXnl8PHCRIwzYSWhqUqbdCPKBqf3tNr
         3HtAsC9suGKj03/NSNXidADrGoG/YgULSg1uHhPvIbWtlOKEJQhm5aLIyW6chRCa+CB2
         wxyaGGGQhwr1AvJ+o4SExNxtJdw5VBWz7Y4bDYDPOjG3Ypb5M5PEHqVZsl50Cj9WyIvi
         E0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731718109; x=1732322909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqC4e7dkIu4h/ZLwmpdE7OAWIL/wo4+luIERmBwFhs0=;
        b=Fffs4kCwOOXIVqV/V8+hLuYpfdBialiCbbcF5O9FvSqAkJTF8a65BUr6CHFULrGl1X
         Fh8hyKx2Rotf88cvZFHV+CVRadiUX88mlZ2r5yASfydUaKSJGcveJ8GKwy5V2mTuJ/uZ
         qqwXiKqrkIO/LSj9th6dN9Rys77DHqnTzxjlxK83sxYA5dFepRlAcmmtl/R0LQNcto4U
         6hJw5GiN+Ape+VDgWB7QTW24iBgT5hlnJNKcdrCLzuJuXqYM8+CE5W9Og6J/xBciDG6C
         Zp/fuF5exH4/I9O4e+KJyOd4mxUt770ehEphz1Cto6N1mcm5j/raWF4YPxqCBxuxFD6g
         fdaA==
X-Forwarded-Encrypted: i=1; AJvYcCW6zx7eoh5VE1cS/n1uLzxquimuZ6AKL83XH30WP/MgXtj/OJXqQJPqx5Til8KAtnNil/Fonbqq@vger.kernel.org, AJvYcCWU85Qcqg6XY74xjW0InuXzRoHwBKbvh8O1peVs40Nf+saEe2Eyoxz+iAU+x21qrx8MzVzDJRxG8uYY0dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEcOFhIfCqXXQpzYMXOMZLO6i6Es7+7HYidjq/lkjfOSY7b8E
	bsq3Yg3NFE1EkigGpSVvGX50BZz+Gjpn1/JSSzyrUxyme8oGEp9m6GUbSUS2+tMMKhsuaTxwjqv
	UNG+a9kIEWoTmLrEj+5awOkN1zxg=
X-Google-Smtp-Source: AGHT+IG84ghV9+JV7ewHS0YSEGU/ppxRXNzk/bghXs6+HQwfy3i2S60nzxYi/SLC6zCEZgcYl/tk4O4kNHRPzLBOw0k=
X-Received: by 2002:a17:90b:380e:b0:2ea:356f:51b3 with SMTP id
 98e67ed59e1d1-2ea356f5543mr1113553a91.9.1731718108672; Fri, 15 Nov 2024
 16:48:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com> <20241115160816.09df40eb@kernel.org>
In-Reply-To: <20241115160816.09df40eb@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 16 Nov 2024 00:48:17 +0000
Message-ID: <CAJwJo6ax-Ltpa2xY7J7VxjDkUq_5NJqYx_g+yNn9yfrNHfWeYA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ivan Delalande <colona@arista.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Sat, 16 Nov 2024 at 00:08, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 13 Nov 2024 18:46:39 +0000 Dmitry Safonov via B4 Relay wrote:
> > 2. Inet-diag allocates netlink message for sockets in
> >    inet_diag_dump_one_icsk(), which uses a TCP-diag callback
> >    .idiag_get_aux_size(), that pre-calculates the needed space for
> >    TCP-diag related information. But as neither socket lock nor
> >    rcu_readlock() are held between allocation and the actual TCP
> >    info filling, the TCP-related space requirement may change before
> >    reaching tcp_diag_put_md5sig(). I.e., the number of TCP-MD5 keys on
> >    a socket. Thankfully, TCP-MD5-diag won't overwrite the skb, but will
> >    return EMSGSIZE, triggering WARN_ON() in inet_diag_dump_one_icsk().
>
> Would it be too ugly if we simply retried with a 32kB skb if the initial
> dump failed with EMSGSIZE?

Yeah, I'm not sure. I thought of keeping it simple and just marking
the nlmsg "inconsistent". This is arguably a change of meaning for
NLM_F_DUMP_INTR because previously, it meant that the multi-message
dump became inconsistent between recvmsg() calls. And now, it is also
utilized in the "do" version if it raced with the socket setsockopts()
in another thread.

> Another option would be to automatically grow the skb. The size
> accounting is an endless source of bugs. We'd just need to scan
> the codebase to make sure there are no cases where someone does
>
>         ptr = __nla_reserve();
>         nla_put();
>         *ptr = 0;
>
> Which may be too much of a project and source of bugs in itself.

This seems quite more complex than just marking the dump inconsistent
and letting the userspace deal with the result or retry if it wants
precise key information.

> Or do both, retry as a fix, and auto-grow in net-next.
>
> > In order to remove the new limit from (4) solution, my plan is to
> > convert the dump of TCP-MD5 keys from an array to
> > NL_ATTR_TYPE_NESTED_ARRAY (or alike), which should also address (1).
> > And for (3), it's needed to teach tcp-diag how-to remember not only
> > socket on which previous recvmsg() stopped, but potentially TCP-MD5
> > key as well.
>
> Just putting the same attribute type multiple times is preferable
> to array types.

Cool. I didn't know that. I think I was confused by iproute way of
parsing [which I read very briefly, so might have misunderstood]:
: while (RTA_OK(rta, len)) {
:         type = rta->rta_type & ~flags;
:         if ((type <= max) && (!tb[type]))
:                 tb[type] = rta;
:         rta = RTA_NEXT(rta, len);
: }
https://github.com/iproute2/iproute2/blob/main/lib/libnetlink.c#L1526

which seems like it will just ignore duplicate attributes.

That doesn't mean iproute has to dictate new code in kernel, for sure.

Thanks,
             Dmitry

