Return-Path: <netdev+bounces-162026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD31FA255F0
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689263A5C45
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABD81FF1D1;
	Mon,  3 Feb 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0zjtAcv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118891DD9D1
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575230; cv=none; b=SUTibcu4kJyCOXASbRnGjiy+EzrkR9RITBjXOOMgu7vyaBfzCSRCKB1nhe03URzC3HHsBmI1YJByRt3CNfsfqGplSDcMvZ0OtCHiDtpdjylsmsKUnLCvBN0aLQYosFyjV5EXGAel5mMAgrM2QsC4lepk+rwrCqGSwCKADfIb+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575230; c=relaxed/simple;
	bh=JLvuYPrh5EOB6QFTE302/yGMZiejUgcLTIYl6bklXMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3cQN9U3Mj3zQjEFapGfqR8uRlKYkInqIwgipXOM77iz98EERCYQxOAvreKrStF+dRk+YfnkYPDoO1aUpYCREkcubu/Fml74m3VLzI9WpgRz7dxFC6urOoMdt+iEFUxv1uxMjYgwbiojORDytrUBlDNRXgHMiWi458BR7knPiwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0zjtAcv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so8672675a12.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 01:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738575227; x=1739180027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YltISiHYM/SmOnP4M95rBXMWY+oifUt0r+dIxBU9/MI=;
        b=G0zjtAcvxwCG1Fyewan6nGkeTr41hFHhsRQJKb/A/eAVmLDTAs8dnxO6mEGgLYxBoB
         R5YVEKMg+LDmFU6NjGLabK6qV4PmTshCrrlDdA1euTeGIfYrkhRe1oWqn7iBPjFw9CzR
         VuAkht7KUbxQElFWQhANTtK1unhFcWij6v/nMmPYGLPn76fywdnrIb6xbuJr5mslAofZ
         8eFDLvmui6dGZPaGY6IPGJlkDLGjvgE1fYkSsm3CoQ0LbAj1lOFMbWZMMY9RGVGYtz2q
         Q/eZCcOpo6DYjv6yleag0U9X+8trUelpNp7IC0qSZnw+0G2lCdfrUU+HxJ1aDB2+WZV1
         13tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738575227; x=1739180027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YltISiHYM/SmOnP4M95rBXMWY+oifUt0r+dIxBU9/MI=;
        b=qxL0NY64HkBFIzc40Xzn6LY5YRyYGjuvzLECaS5TakFJwbQK8PMrJTnaGf45jFMLna
         +z9DODvmZW8PfaV5YlFzvMAuRbNqZ2lBnT1PFxXHmWZ5R/8bc8T2qr4QSLUvWk/Z+Bxz
         SNtvHXCzZjpafH7Izn7sVA3DgAm4drWpsxfcHCZZlylR8vY0x8oSU+IOjTWcRiV9VJxv
         2UqwIt9yFmvqKAChUu1q1fcIxFoyYR6miXeXOyK/nZ7NdXKN/w15oSFmlgs4nemdr5E8
         4wjzZPEOnExyNx3YkR5x0wX1WXXALF767dCu1EkXNmI/ScD1hGoCMEVF47nAsPF/XUwb
         Gokw==
X-Forwarded-Encrypted: i=1; AJvYcCXwndAXH3EnDOVTlQw4OY9SKSoJz8PZNa2aC9tXoXhij+hyUW1WMXylS2dpiBtKgrvnpDtITB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqbDw4XO9aWWD/FJPGRilHNiPrqeXvz5Ws+ZGLAmIK0sh6bVJJ
	6fN4EfLEpKmSmv1LeQ3sOojPYvUO91Mb3ngC94umEuN5mPASRYdu5d+jBRdGwxJfClMFHJnE4O0
	XRiSD6lG5a4mvA8evBseM6raaxtQBXX6oGV5+
X-Gm-Gg: ASbGncukRoeAzGtz/YFhIPrzs4zk9tqP8sMABG0LDzJuyGpKh4GGhOFnt7QWeZhzqOX
	5VVhut0LNSg5FtMnQahUddRm3O8I8rNy34frX7eJ1rKyCIN3jaP4Okd66JcryNJZ+EZaoZ/I3ug
	==
X-Google-Smtp-Source: AGHT+IG2NzOW7gmhMPR5bAakst4yKdwWcCMDGNS22U09LW51jnXMkgpnYxRlzobL0J+UCRK/99goUem3TPvyR5YUqJc=
X-Received: by 2002:a05:6402:2491:b0:5dc:a463:aafd with SMTP id
 4fb4d7f45d1cf-5dca463ab11mr4170635a12.4.1738575227202; Mon, 03 Feb 2025
 01:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131171334.1172661-9-edumazet@google.com> <20250131191004.95188-1-kuniyu@amazon.com>
In-Reply-To: <20250131191004.95188-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Feb 2025 10:33:36 +0100
X-Gm-Features: AWEUYZlaj1WWuBpuvWplrXUJwPQ00tkVtnlZRrX5v-usOwdP5kuZwFBKrY3b_gY
Message-ID: <CANn89iKKyT=j0us0LcYS_Avkz_qRLmWfW3kUxRPgDk0AWC2Pcw@mail.gmail.com>
Subject: Re: [PATCH net 08/16] udp: convert to dev_net_rcu()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 8:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Fri, 31 Jan 2025 17:13:26 +0000
> > TCP uses of dev_net() are safe, change them to dev_net_rcu()
>
> s/TCP/UDP/
>
> > to get LOCKDEP support.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
>
> [...]
> > @@ -1072,7 +1072,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct ud=
p_table *udptable,
> >  {
> >       enum skb_drop_reason reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
> >       const struct in6_addr *saddr, *daddr;
> > -     struct net *net =3D dev_net(skb->dev);
> > +     struct net *net =3D dev_net_rcu(skb->dev);
>
> if v2 is needed for chagelog, this line is longer than saddr/daddr one.

ACK, I will change this in v2.

