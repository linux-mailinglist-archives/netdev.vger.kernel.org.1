Return-Path: <netdev+bounces-111666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F55493207D
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CDDEB216FF
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 06:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B971C694;
	Tue, 16 Jul 2024 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLWc/rr/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A785B182DB
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112119; cv=none; b=M+d1IODdZWd28JQA24yI0ZOp/YwqucMS01sLlYGwxPBhVAgZcrLd0UEreSf+jCp8W01QLGycpJKD43UGRoHwDEq9mqf8Tu5oF0MbSk6IrYBR1SUJES+WvFx3499Bo1MzPBFTP9PBsnlXiYVkvbZgj7g/TX1V5kdKaqy+mmb7AWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112119; c=relaxed/simple;
	bh=eTZEWSCcpDUhdmR8DVVFcGbgmgZpNp5inKDB5zqrh3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jske4edGaaW4MWBJYDqRor84oNumqCaeKnNt1p2GSl2B9Iy2yqmGaXuhmeQvcrMS9KzEMuYTWLTJDzuhFgS27jmXLMjUH2mr7ypfVJDb+SkRkOWWyml1RhKu5R061YfmjIC3rYrC9Av94crjQ8Xp9ImVCasyaEfJtaJCsJ6Oj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLWc/rr/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so1576043a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 23:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721112116; x=1721716916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTZEWSCcpDUhdmR8DVVFcGbgmgZpNp5inKDB5zqrh3M=;
        b=KLWc/rr/WDJgQvwN0u0EXhbmSORH7hScH5crHJPIiSzvL6rvaXxReHHo0np4gFdccP
         fkoYQReQB4esHkUDrJoFLC4QDCSRl5jP1moN67+4InY6/QDSsA3OrijvPMtRTlR6FrMw
         QdMImQaFNKpkhXk7kxbIYIwlOLVxpFEvxRSQ/TUpTGTo3n6iWjqPcBY2jrzZZW9tqiZz
         snW6oEEaZSQnNgeA3GhixOhofsx73zCRKkOJjNRJvcAitjPGmrQ0whVUCrgwSe5l8/lo
         iKMVKYQI18oUAnBtqQki1sSSqekL8DqgGZO8iKNF1IANNDzQW5KhqRB+kwQxg0UguYmm
         wsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721112116; x=1721716916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTZEWSCcpDUhdmR8DVVFcGbgmgZpNp5inKDB5zqrh3M=;
        b=rK23+ev8wvleiE0ajilfadgIWqvNoJmIGuUcyQ1MQWAvwoFnVtPRpfglrXElGHonHm
         E4zWeyM0r3iXpfKJyWtjd8Fyx+Pser7P54izw3mFBZRoyF+s19p3uWMUG7UXVN9dHIz9
         LahyHnex5XCwm4uy3LjaRIwHkUQBYnsqDoSZMOM6cPhiB5vclD/XQXxKJWqb5e3ZlEKY
         tUKTYDzMufkHz4Xk8ajmaEgOw2iwzV1CsWZoqj2H0OectnAqIKnpPpkU+ucJ8ZpyS5C3
         t0Mq8QXFnKjd/5CXp6W12kKknS4AuVr8JJxTexsev0mlMWCkQ3BSsFXoR69Jk+YkXBeY
         3nig==
X-Forwarded-Encrypted: i=1; AJvYcCWT9kcrEN5EWd/wbQ3EB0+YU8WkWDnnsElfRLr5Y+eqe1HgZy/rUMkMPgMQQlqTab0kKl80jVuEJrIRuLT/9J3kinfQ7o43
X-Gm-Message-State: AOJu0YzcEVsrVR+scgbrmh8PMoTS7S7QUG+xcWGKNZTtZFaPPzUys12c
	eDo3gAQmSWkzAL8M/QKajZ1YM8w8wX8c0T9WyWpzAL+VzqbXEHa7xJibnycbuo6mcBwJxDsCcjJ
	YnkdSYO9+S5O9LqzeXyhHs6JpbDE=
X-Google-Smtp-Source: AGHT+IFo9/7BLgYvgimlDgzfAAx/FMdh9AejHF16cUo/Hxvj0m0fd7qlz90ye8eWF3Dxa7AOncEStxs5VYNH8F0hjs8=
X-Received: by 2002:a50:cd41:0:b0:585:9e73:8ac6 with SMTP id
 4fb4d7f45d1cf-59f0ba0b70cmr504134a12.16.1721112115759; Mon, 15 Jul 2024
 23:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715033118.32322-1-kerneljasonxing@gmail.com> <CANn89iLXgGT2NL5kg7LQrzCFT_n7GJzb9FExdOD3fRNFEc1z0A@mail.gmail.com>
In-Reply-To: <CANn89iLXgGT2NL5kg7LQrzCFT_n7GJzb9FExdOD3fRNFEc1z0A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Jul 2024 14:41:17 +0800
Message-ID: <CAL+tcoA38fXgnJtdDz8NBm=F0-=oGp=oEySnWEhNB16dqzG9eQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce rto_max_us sysctl knob
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, ncardwell@google.com, corbet@lwn.net, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Mon, Jul 15, 2024 at 10:40=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sun, Jul 14, 2024 at 8:31=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > As we all know, the algorithm of rto is exponential backoff as RFC
> > defined long time ago.
>
> This is weak sentence. Please provide RFC numbers instead.

RFC 6298. I will update it.

>
> > After several rounds of repeatedly transmitting
> > a lost skb, the expiry of rto timer could reach above 1 second within
> > the upper bound (120s).
>
> This is confusing. What do you mean exactly ?

I will rewrite this part. What I was trying to say is that waiting
more than 1 second is not very friendly to some applications,
especially the expiry time can reach 120 seconds which is too long.

>
> >
> > Waiting more than one second to retransmit for some latency-sensitive
> > application is a little bit unacceptable nowadays, so I decided to
> > introduce a sysctl knob to allow users to tune it. Still, the maximum
> > value is 120 seconds.
>
> I do not think this sysctl needs usec resolution.

Are you suggesting using jiffies is enough? But I have two reasons:
1) Keep the consistency with rto_min_us
2) If rto_min_us can be set to a very small value, why not rto_max?

What do you think?

>
> Also storing this sysctl once, and converting it millions of times per
> second to jiffies is not good.
> I suggest you use proc_dointvec_jiffies() instead in the sysctl handler.
>
> Minimal value of one jiffies makes also no sense. We can not predict
> if some distros/users
> might (ab)use this sysctl.

Okay. If the final solution is using jiffies, I will accordingly adjust it.

>
> You forgot to update
> Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst

Oh sorry, I forgot.

> This means the location you chose for the new sysctl is pretty much
> random and not reflcting
> this is used in one fast path.

I will investigate its proper location...

>
> I suggest you wait for net-next being reopened, we are all busy
> attending netdev 0x18 conference.

Roger that. Thanks for your suggestions.

Thanks,
Jason

