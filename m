Return-Path: <netdev+bounces-111523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF6D931709
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A789E1C2141A
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43014433B3;
	Mon, 15 Jul 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnkrExwg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94572191473
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054459; cv=none; b=fohjfGHtnjHS9Q3lMr5/9mYajddVIVF5ZSCGGBXHYtPNTx67JeITsDTUr+/BBkMX19AhSS2umEUOj14p/85cGe0eZjNVUdEyS9VD8rA6ri9EIjxro1tbVELhICHCxOnHZS38JIP7DevI3F949TAisWbMgtoGXQe8i4e5YegoKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054459; c=relaxed/simple;
	bh=D2XlUZelRmYkPah7UtL3C61JOrp2tCKSD2Wh/p31fcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fa86BEyxDOSWln504sKebqVab1J1v2o6PeQetrjQ1qbW5XdTEbAZeDLW4rL4gsmokCFGfNn66ap5yz+Nv0R5T5Ri/nbxSC+3+FgsJXIBHjqOmW/fyQhUlPFJrvMqLd8JCEslLlqnDyytHrcxHUODUMIQ2dgEoHr1Zdud81iHTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnkrExwg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58ce966a1d3so15935a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 07:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721054456; x=1721659256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2XlUZelRmYkPah7UtL3C61JOrp2tCKSD2Wh/p31fcc=;
        b=hnkrExwg3ipL9B2B8mkydHVJvUBmeLg8GWVQJjzBt9HINddxHQ87+OohFy01XWDHLM
         PUZ+/6LuuD4r/iaeQ1vEX6lVmAwvkM621fYGgmJF9pgmOpEziPTcesiZqZV2H4viQ78H
         cp9zTzbx4cI9FHKlIrKuRcK81lPO4GGItZnGAdldf6uKN9WshFWwk2Yyv5XWymLG4b7z
         tISBt8kJ+2ycgyVXpJ+LQGifDI1acEC35oneDBPglitta+SQNk7hxFJnfj7tgwdnPunb
         F4qOfHcIqXBRDYvnZvNhqFetDcTrEeQbsxRSOS8200ehszYHcoBX3YT6zP1r0A4aD45q
         sjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721054456; x=1721659256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2XlUZelRmYkPah7UtL3C61JOrp2tCKSD2Wh/p31fcc=;
        b=xHhNxezi9l0ZX6fPw7vXn/1UeWlFo5jrzhTKPBLUYa5z431YI52EDNkBQrUF7yF6GO
         CPTmY20eMxzEGCc+RLvqdXeq9woFZYNqYJV4KOS0uRg/lIhVscFdqhMsCx0BZzo6f5yH
         0MCvXLQ+yHT0uX5HXXJWv5Jhl/4pI6RFbXntvmgH2aj6ScNKsI0/KEGZpSsudRNlmLjz
         yX+W1B6jiV+igtf2WhMtOgKNql851C20MWmt3uhcgpvWl9it6Zo3V8HIe/WMdSRAF2js
         x6aMJR/dKpZLa4c86QAnHJHaUPefO3eze11lZAx3PAJNSJnsHIJwXRh7B20paWgtc5Jk
         Lvdw==
X-Forwarded-Encrypted: i=1; AJvYcCWbO+wN+6upMmW0EYHHXCEv6kIqBUJ7s7bue4hqa1JnV5UR3nRgJHqf5u8FxfpGiWD0DqFWIZ8GTYJ1dwqMzSUTZxe1iSQX
X-Gm-Message-State: AOJu0Yzg1Dby8H4zKd8IOEF3Ngeoyw38dls8+sUBzYiIMrc62okzvPZy
	cYNdKzATPs+x/5mQF9XcHtAEI6KAIrRqVM21pHbyW2yCAURoabGeiPsWMGyBT0DmwOz8kofoSJi
	TOm/B2XGF2AYZPVp6aVv3+fXhQIS+8355IDIq
X-Google-Smtp-Source: AGHT+IGvL76js+Za2RWfAMi0xSbdfjl8LswQxXthtptB13e9NK4v+VJbRwJepT0z87CtQnu1TeheoeHnaObVaIBcGKE=
X-Received: by 2002:a05:6402:3593:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-59acc6c8af3mr339494a12.4.1721054455610; Mon, 15 Jul 2024
 07:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715033118.32322-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240715033118.32322-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jul 2024 07:40:44 -0700
Message-ID: <CANn89iLXgGT2NL5kg7LQrzCFT_n7GJzb9FExdOD3fRNFEc1z0A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce rto_max_us sysctl knob
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, ncardwell@google.com, corbet@lwn.net, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 8:31=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> As we all know, the algorithm of rto is exponential backoff as RFC
> defined long time ago.

This is weak sentence. Please provide RFC numbers instead.

> After several rounds of repeatedly transmitting
> a lost skb, the expiry of rto timer could reach above 1 second within
> the upper bound (120s).

This is confusing. What do you mean exactly ?

>
> Waiting more than one second to retransmit for some latency-sensitive
> application is a little bit unacceptable nowadays, so I decided to
> introduce a sysctl knob to allow users to tune it. Still, the maximum
> value is 120 seconds.

I do not think this sysctl needs usec resolution.

Also storing this sysctl once, and converting it millions of times per
second to jiffies is not good.
I suggest you use proc_dointvec_jiffies() instead in the sysctl handler.

Minimal value of one jiffies makes also no sense. We can not predict
if some distros/users
might (ab)use this sysctl.

You forgot to update
Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
This means the location you chose for the new sysctl is pretty much
random and not reflcting
this is used in one fast path.

I suggest you wait for net-next being reopened, we are all busy
attending netdev 0x18 conference.

