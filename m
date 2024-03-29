Return-Path: <netdev+bounces-83462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38678925C1
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 22:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB2828447B
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D81272C7;
	Fri, 29 Mar 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho+OjBNb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8954BCC
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746083; cv=none; b=UYQIxJbF0iMH3ZsdAKsR2WhSOeVLknz6XBqGSZdIqglT4g0x+m1+iQAJgbpeDx4K/GP6IKrlLH6vUPW6kiO0E+mH+NyxvPsUhWQ2SDOSQlNMqnuxKt6p8AImZ9ZLnPja0WglzYtRgaxLdCFXDb/++aF693jqKAp/aq43EgHoYI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746083; c=relaxed/simple;
	bh=1F336ycsZ/DeFmR3ip4gKdMLUxslUjLhibn8LWK2nsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqczGxbj+vc5Ex8+YOql2W5MFQyEyJDvs+VvKZxCZX/YbWFRDEeuR5cJnie4QDZZdUKkWF4hgxcR/Gn3m5DexMqEqSVK1Agq4Gr2DSCmglk4vO609sLx9zCF9KTbdIqb0rfTy0Qw8GBCP3KZDb0Qs3tYWRyoxcTbXU+z3FW17iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho+OjBNb; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2218a0f55e1so1281980fac.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711746080; x=1712350880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yf52Uh55Alu6R/Ag5oOPyX9j+A5vWytrrN0jiumVZ90=;
        b=ho+OjBNbnc3h384Al3xJv2eDnLkMbeh8PklqJBE+HkNQYmq+u3NA3WEUXY6ntS1oum
         BbDLftW/w1L3bnRUkzfKGFj6NOD91Ao5B7w8TbHmTTWygGGJMaI5oluhe6pXWRKlcwQE
         eal66+QsD61hUSz7DafBrrpV7r44uiME3jzCun3upnTJCiz+CzfvihUtTLxPyGFkXtzB
         2XpAMIxS+WY4coIS9d3qLyHgN1MUdr9S9ZepzVwPYxull2EILd3FX8/YV0IsDk1Olzh8
         4VhId5UWqiDJuZFox6GjK+EahBBbT5idHwBSumTfjPybPSAbMGWWeY+vfuxETCQO+JPu
         21+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711746080; x=1712350880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yf52Uh55Alu6R/Ag5oOPyX9j+A5vWytrrN0jiumVZ90=;
        b=mmXVo9v3DV+2/oxtG3OebzaU3GXy2AOrXBmmxq3it5M9egIWB6464eze8fJefK6BIP
         4pVPO0njIslLwBaciyjuicRAS0q5IO2vziESOt8OJMs7B+cupw3i+uzxiQ07vrsp/ok0
         KgXjIm7hYGtVo/vW2SYeLFBgtjr8wsYTLK30/iJ8DKvuIO07W4Vy215kpZfuDl1NGbWb
         zuTwYiVaKaQ1nwPZCV5BHV9cEVqsFYmN0p892Jpnt2Hrtpd8GRxNXMIWRGoy3UPYuE5P
         crdfjhOsuna/vY51d/Vdscks5gpZjbvLR3v/IZZ2W4enAtVGjnilS3Up6N69FPesoi6d
         9hFQ==
X-Gm-Message-State: AOJu0Yxy1Z1OQwgYOlgx6qQOrRpezxRv9fa1TVH11l25zaM22mXmBbSm
	AeQFFbIL2e6QZxC+BatQg1inIxrP8xE3ArNrMah7H0eVgXvXHFwIXqQ0/+4c6/0T85Bl/6xNwxN
	aa6cs7TpBTZPmb37LWn9+9ETHiq3WJK4j0cHKkg==
X-Google-Smtp-Source: AGHT+IFNOkfSs1BURB1rlpqe3TL2grutEAtJuWGFXQ3+Z6VLEkc3CSL1O9fqzu1ibdOxjluwMoca7IZvOR8xkQpFSqc=
X-Received: by 2002:a05:6870:6124:b0:229:eb17:3c19 with SMTP id
 s36-20020a056870612400b00229eb173c19mr3037666oae.35.1711746080466; Fri, 29
 Mar 2024 14:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327181700.77940-1-donald.hunter@gmail.com>
 <20240327181700.77940-3-donald.hunter@gmail.com> <20240328175729.15208f4a@kernel.org>
 <m234s9jh0k.fsf@gmail.com> <20240329084346.7a744d1e@kernel.org> <m2plvcj27b.fsf@gmail.com>
In-Reply-To: <m2plvcj27b.fsf@gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 29 Mar 2024 21:01:09 +0000
Message-ID: <CAD4GDZw0RW3B2n5vC-q-XLpQ_bCg0iP13qvOa=cjK37CPLJsKg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message support
 to ynl
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jacob Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 18:58, Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Jakub Kicinski <kuba@kernel.org> writes:
>
> > Looking at the code again, are you sure we'll process all the responses
> > not just the first one?
> >
> > Shouldn't this:
> >
> > +                    del reqs_by_seq[nl_msg.nl_seq]
> >                      done = True
> >
> > be something like:
> >
> >               del reqs_by_seq[nl_msg.nl_seq]
> >               done = len(reqs_by_seq) == 0
> >
>
> Hmm yes, that's a good catch. I need to check the DONE semantics for
> these nftables batch operations.

Well that's a problem:

./tools/net/ynl/cli.py \
     --spec Documentation/netlink/specs/nftables.yaml \
     --multi batch-begin '{"res-id": 10}' \
     --multi newtable '{"name": "test", "nfgen-family": 1}' \
     --multi newchain '{"name": "chain", "table": "test", "nfgen-family": 1}' \
     --multi batch-end '{"res-id": 10}'
Adding: 20778
Adding: 20779
Adding: 20780
Adding: 20781
Done: 20779
Done: 20780

There's no response for 'batch-begin' or 'batch-end'. We may need a
per op spec property to tell us if a request will be acknowledged.

> > Would be good to add an example of multi executing some get operations.
>
> I think this was a blind spot on my part because nftables doesn't
> support batch for get operations:
>
> https://elixir.bootlin.com/linux/latest/source/net/netfilter/nf_tables_api.c#L9092
>
> I'll need to try using multi for gets without any batch messages and see how
> everything behaves.

Okay, so it can be made to work. Will incorporate into the next revision:

./tools/net/ynl/cli.py \
     --spec Documentation/netlink/specs/nftables.yaml \
     --multi gettable '{"name": "test", "nfgen-family": 1}' \
     --multi getchain '{"name": "chain", "table": "test", "nfgen-family": 1}'
[{'flags': set(),
  'handle': 10,
  'name': 'test',
  'nfgen-family': 1,
  'res-id': 200,
  'use': 1,
  'version': 0},
 {'handle': 1,
  'name': 'chain',
  'nfgen-family': 1,
  'res-id': 200,
  'table': 'test',
  'use': 0,
  'version': 0}]

