Return-Path: <netdev+bounces-107661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7C91BD5E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22632832D1
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB561459EF;
	Fri, 28 Jun 2024 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SChJQmQU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A123D0
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719574114; cv=none; b=fSB/A6CiGwUMl1c8A2J06OVHdb59lK87WC8pysp0/aUH/lxFJBzGmeYcpIblbu2p/QT8QLz79AiFEJmY6d8OHkGZ/piBBQfMZpnxYahT1FttR0F3OAjAHWGGCAPolNZaJT4hkqXMtl2kMq+O5WFD6Qv5rCinMjg36uV2FFd9VNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719574114; c=relaxed/simple;
	bh=FvJONHYYKXqLdg85y7QxLGYf8vfsLv6kYLg5qSHu2I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYgHxaSoq64FqKVHLEqEah99X7CP/o2kM91tQoFFMqokLKbDLXx4W17BJj9AERtAI8XoydayTE5rFFZUXbnsWQXdYSXtNcTrZC35TtmC9L83kok3XK/KTELM51LW/fj7FX7r1bVZJ+wyfUxZn/2LnlFh6YaK5MyyfAekOfo/CF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SChJQmQU; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4ef75bc9a61so143389e0c.3
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 04:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719574111; x=1720178911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZFCkkOVbM7VFhl3+wu2DIlwZu4h9jM9WDNCeaa5+cU=;
        b=SChJQmQULz7x768bu5OoaM9GFU7f/Z/jvZseH6Pn50Ni3Wup5pfAKH6eA7tOY7yZv4
         p+Q8nQAMe9VCuLHFImJxh4nQqdCQLt4BJIgNgBfy00dtCDx5NFTRVupqro5i70rjN3JU
         k5xy6UAYyi3P/aJ6Vctidh6g45hxJO+NgWfYu3LZ8p4iytqHTaI+vilYXvySlB30lo11
         RyB6ITA4qnooqp42RTGQ9VZwiWPdzeHg7oJnrA2SNfTcY2Zx7ZwLRWu0aUCAFR/JEuIS
         XtzYI/jFhYNOrvblix84yAMZJyxDvrrUzKp9lEZ3ihYuJwHDlgtUKyYkghAI/FiMaCda
         +6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719574111; x=1720178911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZFCkkOVbM7VFhl3+wu2DIlwZu4h9jM9WDNCeaa5+cU=;
        b=d9z4tKNUh2taabQMxofkdfSEAzYMf6aEqYP+2JfurdnxbYSH8DKd3ubKZoCgOomIP+
         fzImpOh/IvPlfgLG/9wAw36F1QVsTtwz/7xhmfQ7CerKLIBShw0aTUWQPKkEI5n15KId
         8Uif4JegE5gsPJ11KG6x6Oe3eD1zrSxCx5VkVoqIk0Fpsn0Vmw95owbZ6hmeZ7En4P3e
         3L7ocZlqayKOkYlwbkeUIdHnS291jxkD6kyQwfdm9zh+k7FwqxBwT2O4+RGnqY4FI/sr
         HZMlI8lf883bicBmTl6QyxdYmPYJTeWMni9xEAk0cW6onTTkirsdm3snIQroEetYBRY2
         6N9w==
X-Gm-Message-State: AOJu0YwN6cm7FJJ2rtH6Yrrd6oI0UZaNE/nJmyXSCV78p+ZdIQNj40cF
	+dPr/RNKWKaWvL35h7O+HCgxPYipuBIYjXwiABNbS+fwbD0LXbHPJSxM0OdjquFBVQ1gqMPHaml
	WnJJxyqXlAgZYIR9B00GoY4EVLJg=
X-Google-Smtp-Source: AGHT+IGmIXbOFJWkoin8RyV+AhNWwwDOshxNAjaC9KbiJPtRG5EaSLkJlyfYuF5XxPQt04DArfo/t37cRFD03XwMvkY=
X-Received: by 2002:a05:6122:1d9e:b0:4eb:1264:c8e5 with SMTP id
 71dfb90a1353d-4ef6d8b52ccmr14197044e0c.15.1719574110729; Fri, 28 Jun 2024
 04:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZuGQGM+mNOtD+B=GQJjH3UaoqUkZkoeiKZ+ZD+7FR5ucQ@mail.gmail.com>
 <20240628105343.GA14296@breakpoint.cc> <CAA85sZvo54saR-wrVhQ=LLz7P28tzA-sO3Bg=YuBANZTcY0PpQ@mail.gmail.com>
In-Reply-To: <CAA85sZvo54saR-wrVhQ=LLz7P28tzA-sO3Bg=YuBANZTcY0PpQ@mail.gmail.com>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Fri, 28 Jun 2024 13:28:19 +0200
Message-ID: <CAA85sZt8V=vL3BUJM3b9KEkK9gNaZ=dU_YZPj6m-CJD4fVQvwg@mail.gmail.com>
Subject: Re: IP oversized ip oacket from - header size should be skipped?
To: Florian Westphal <fw@strlen.de>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 12:55=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com=
> wrote:
> On Fri, Jun 28, 2024 at 12:53=E2=80=AFPM Florian Westphal <fw@strlen.de> =
wrote:
> > Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > Hi,
> > >
> > > In net/ipv4/ip_fragment.c line 412:
> > > static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
> > >                          struct sk_buff *prev_tail, struct net_device=
 *dev)
> > > {
> > > ...
> > >         len =3D ip_hdrlen(skb) + qp->q.len;
> > >         err =3D -E2BIG;
> > >         if (len > 65535)
> > >                 goto out_oversize;
> > > ....
> > >
> > > We can expand the expression to:
> > > len =3D (ip_hdr(skb)->ihl * 4) + qp->q.len;
> > >
> > > But it's still weird since the definition of q->len is: "total length
> > > of the original datagram"
> >
> > AFAICS datagram =3D=3D l4 payload, so adding ihl is correct.
>
> But then it should be added and multiplied by the count of fragments?
> which doesn't make sense to me...
>
> I have a security scanner that generates big packets (looking for
> overflows using nmap nasl) that causes this to happen on send....

So my thinking is that the packet is 65535 or thereabouts which would
mean 44 segments, 43 would be 1500 bytes while the last one would be
1035

To me it seems extremely unlikely that we would hit the limit in the
case of all packets being l4 - but I'll do some more testing

