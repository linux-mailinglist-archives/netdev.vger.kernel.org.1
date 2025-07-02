Return-Path: <netdev+bounces-203568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE5AF665C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2596A1C42496
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DCA24DCF7;
	Wed,  2 Jul 2025 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7mk1R2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E22248A4;
	Wed,  2 Jul 2025 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499678; cv=none; b=CLEriEb0S+zEDzVmrFtDl40NqUarD4jAi655ZhFkJ8LZrSkQYX9c5YBpsb7o3ToiMXMomj+MBjop84MJLuOclm6z028B5PnQyp5X6UTGvRu00nghcWymLQnkkf9uZvqt64Ipj5WQORKkK0r6WYItDwMbA5is7m+kMemAHdTXsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499678; c=relaxed/simple;
	bh=Mn7wUCsYDxdQWE8WI7pFn3DTP7xJ6Za7yAZ8h7veegw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaGtbD+oHNWb3OZhoz6XRu2ObRdMmoGvr5xwE801Cdw9I5K/GyIrTn72TeeSBfYFhKnlUy7eyFlH1UedCe+N1aeFNZTezKrz7q45aa6rIfeSbQTOHBNgl4NaqjJfhX2uwzM/5i6EKB8jBV0pM9gMJCtOD4L98DYVCdrruX1J8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7mk1R2Y; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3dda399db09so57118265ab.3;
        Wed, 02 Jul 2025 16:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751499676; x=1752104476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+Al7nLB/wYBRu7qjBW6LVu1tp5R3H9FLxsXRPdr4hc=;
        b=i7mk1R2Yc037J/SKzHfDlSWRpGwsowomv1oy4SwPk7KvvxZMoE75GwzuZz8wGq8WPc
         q6/f6ztZQ+uLTwEpy21GD9LLGe0N+l6oO/wWkDFwyXdWBAuSUSi77ZgLOzbpwB9G6u27
         kPYJMTf1Krep70QUXJxEIciRWiI0PTssNcidUbJaUzt0mId5asCJELm3QZRVml6LfV94
         ikU8E3h+yebEwqDoeFi8a3fWu0I4K6svs1v4x1FZCQSUg908dSKFmL/2I/UzyPgqWGXW
         dTRXsHrUkWRJLxHA8F/A14uAxHh3SEBFBbQgZMw9mEWPNUVv6S788zVFu/14jwvtAwrB
         wQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751499676; x=1752104476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+Al7nLB/wYBRu7qjBW6LVu1tp5R3H9FLxsXRPdr4hc=;
        b=GJ58EoNh31AwKao5W324JUQqJllKVlUYzwfW6r7i4k6jcHxmU77nb/1aqxmH1UrqNA
         sSRXFPVszwUMocR3pFNlgqIUOIbyjShy37HWCBc5hP7vNgTWyjjf6KIlpyi7jHrdiR9f
         +ScQId/jfnJE19quy2DJbzLy0lvmw6L8ArBmflnzGs1u4HMpo6MSLuF4nlmnFTWbSmNS
         xJ3fpGHj9PRt3teN3f/qCp3aFArcYh09iFvtAuNCaO2/wXcZ7s6NhC8c0MMsW7IF03Jx
         k2AarIOywLLEbxGd4wbYVVqt1Pmzn9EoVKNgU3Hp5Twl+t9zYn4ANKihTu+/qxE+2BeE
         eeLg==
X-Forwarded-Encrypted: i=1; AJvYcCV1akRjbHXV4YTOW6tKjS5rR9XYTVB/cI/LrdCgqO+wUvFASniCbNrhGEHiZVPNXdiDG/Dv0xZ7Ud/NPgWY29C6SMmgH/qcOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSqZ4zRT3hZtaQ5/qoC9nlhzScU+KAeT1DPApawPpDOMkSxiq
	lDL/IBy/NZ5Tiq2rGJCsPxxaP6rgxlWatcHC9YGB7u6EHI0OSQuCU08n6MJNTn2Pc5E6SU0bDI7
	hvjjAHiogE1jUK7R31bkdjrnhwPNIvvQ=
X-Gm-Gg: ASbGncsfOJv9Zb0/SvlXYTa29nNvV6hMZBLuOosXwXHpKaH7PvwUQo13FNQ91cT50oR
	S5pWjAX2aAYzQJDeA+ubhzaL9taYy2ag3YSJdWPX9b0ENlC08L2+Dnmr9mTl3Uepo7vMjo6iiCc
	bNZRRX46HpU3XqxZU4ptUs9q6OlOduijoc2WyLnnkIWg==
X-Google-Smtp-Source: AGHT+IE9ZTlwXOZ+cxxoWqcvsD+iliLX5D39RnLAm2ADipy7j3828GqvLH0zdFwvWwmRhgXVsXLqa4A3QKP4T3VLTXo=
X-Received: by 2002:a05:6e02:1c2b:b0:3df:3a4f:c884 with SMTP id
 e9e14a558f8ab-3e05496bd83mr66987465ab.8.1751499676429; Wed, 02 Jul 2025
 16:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701103149.4fe7aff3@kernel.org> <20250702080732.23442b9e@kernel.org>
In-Reply-To: <20250702080732.23442b9e@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 3 Jul 2025 07:40:35 +0800
X-Gm-Features: Ac12FXx2jNepn1PpDqvDgEJBSmtL17CYcOO5U5GhUvrot8X4D0l1TGf7Rbwo0lM
Message-ID: <CAL+tcoBJmxE5+f8vZ=DbPRO=Bi84kEU=yrmqnuri30duva=HYg@mail.gmail.com>
Subject: Re: [ANN] netdev foundation
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org, 
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, johannes@sipsolutions.net, kuni1840@gmail.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jakub,

On Wed, Jul 2, 2025 at 11:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 1 Jul 2025 10:31:49 -0700 Jakub Kicinski wrote:
> >  https://github.com/linux-netdev/foundation
> >
> > The README page provides more information about the scope, and
> > the process. We don't want to repeat all that information - please
> > refer to the README and feel free to comment or ask any questions here.
> >
> > And please feel free to suggest projects!
>
> I see a number of people opened the link (or maybe like most Internet
> traffic these days it's just AI scraping bots? :D) but no project
> proposals were added, yet.

I hope I didn't misunderstand what you said here. I keep thinking if
there are other projects related to kernel development. IIUC, yes,
there are some projects, something like xdp-project which heavily
relies on the kernel but is equipped with its own standalone
tests/benchmarks/documentations?

If you're referring to that kind of project, it would be easy to list
a few potential directions for people on the mailing list to take:
1. RDMA impl/test.
2. Various upper layer stacks with the help of AF_XDP, which I am
currently working on.
3. Useful debug tools/trace tools that are good to the real debug
process (like writing bpftrace)
    // a few side notes here, let me put BPF timestamping as an
example. For now the selftests only show how it works overall, but not
manifest how to write it is the best fit for the production load. I
have a local one and hope more people can use it and polish it but I
don't know where to put it except my personal github...
4. some other interesting kernel modules that are apparently not
suitable for landing on the kernel.
...

I wonder if I'm digressing a bit...

Thanks,
Jason

