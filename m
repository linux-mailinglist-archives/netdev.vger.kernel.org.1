Return-Path: <netdev+bounces-193769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEC6AC5DD3
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9A316B0FB
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 23:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85A52192F1;
	Tue, 27 May 2025 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m64dDdD7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C3DB667;
	Tue, 27 May 2025 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748389435; cv=none; b=kxc8eyggnyY/2yjE3vtDzaK4U4tz0MJ9bPGD9fkWJR6L0Y/PLJmGBP7Q64lPEAn6z0tCfOSEo+cPrW/5UX9W0AAlkaaHZJKZwHjOs/aYOYkhV4u1nS7cE13lNodD63xOl9MTtXh+GZusw0c5u2RsAWpIuPLZFekcpvEq+1//FSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748389435; c=relaxed/simple;
	bh=f08em9DA6QU6JbQhqbKs8TXBg5LZ+UoUHjXE6+ZDNPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZl4IHrFPFnM25XAtFJAf6AgukrthNYPhG1Ut2idCvufCVQqOjyepMUZm7j/Jl3bl+XmJStS+uJ2XG+EB9PVaBRrwCF5tkES0tVxQc+V0ompmO5QzOMWgXKQ83CUcxWm0R49NhUMWIIPydfGslzfoG5W+vbLR+40vZYuMdi939k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m64dDdD7; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3dd87b83302so2759315ab.0;
        Tue, 27 May 2025 16:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748389433; x=1748994233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f08em9DA6QU6JbQhqbKs8TXBg5LZ+UoUHjXE6+ZDNPI=;
        b=m64dDdD7AuhbOnPBfPDHbYHZNmDYloy4oSqRK55+IutZmL7y0zMOOPWs0fku7Wd2Ea
         uGmQMPSq3RhY4k0/+7mIff9O6dlCfxqb3P+RsM3mwNjRnZ022EhAZMPQz1GRGz6yJvGx
         dz4uHpT4QbSDKv2CiNTdMydO+Z0JL6i5kyVDdky0mM1qwiAY9y4V68GQgCZWbR7oEyD9
         ksWgdgAgwnP2Hhg4PtWesE5mc0d6GeYbWlY4gVfe77vIA049Z8qt2pVNle292Worr2kd
         +Kv3cmBWiMr7jQbhfDV07GubC7pCJOLquyb8xb8BPQZtVJA/6c/Ll93ydr4me0N5d/aD
         k7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748389433; x=1748994233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f08em9DA6QU6JbQhqbKs8TXBg5LZ+UoUHjXE6+ZDNPI=;
        b=SArzN1keURlwUqlm78ZxHCzne6KXAFOy/TnHBpEklh8IuzToXIMXxM0mTU1iyBoV/j
         1cqk8v2ImEUiz6jEDmFsResjWx8WjS8PXGuLtiJnOqVNGeYqoKTpMLlMUqi04Xzx2miq
         6cyiZlN7tpxsd5/8O9WnA559/2NDPfZ9mL8V8li7I+Ka+Bl0fU/m7i5WkeB0Tha0UjaP
         LOYfn38bzLeIB2PWh7+UHPDJpMb5sdzNvY1sUXkV1Pl2VSsF92jx8Udxkg01Kq5pfATW
         Kt5rWubqarC9MV3VJn/C8YE3n18XoQXWi69amkN9fsOS3FL3Rham3QYR3YE3ooaiEcGF
         MMOg==
X-Forwarded-Encrypted: i=1; AJvYcCU033EwOIp/WBCP4oVF055USjAUy2G0jBdh5KGjXxQ/LCgGOzHD0HzUtAqqmShI+biAPiBEwMUt@vger.kernel.org, AJvYcCVLc8enwhKzGJwkkEpohft71wDHgoY1zqPFokRaZ5U6shJHW9PIy8vBBkRFaj/pJYEaf1dPqC2vBuoKRfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jY5ivlzF7FIzyESUt7EOQEdVaCqJhPHviorh3kKq+9COc9/b
	47DnPqe9QEWlM8FbquBe/KVzGh2oflBrgvzYG8tkvPVHF5F04PGlD0ebhwkaH15e57tm5orQ3cM
	7PRchZGYW9D33jSJQ4RR9YSqyDOs5oZc=
X-Gm-Gg: ASbGncumYPZ4vHRpH4LhZYM4QoYl6YZ4tRkSk2aIttUY0tjNv4HLZahWlNetqg3knWf
	2HQPqPaZwyA+iXxJSDqjGSqA0Ja8S+z7sdJbIZKi0+JGhQrOEEgeei09MfgdUBU4sBc7eCvATRN
	UqsbcZwyqz2jz8J7nWimjleONZrUiV2f8=
X-Google-Smtp-Source: AGHT+IFNQN4+WL6glmxs8lAJDLu8MmuG4dogdioqikdxkZTzmQFS3OIBQSPDH+mrcAEyBGGegg4u6eiOYwHdcptWq+8=
X-Received: by 2002:a05:6e02:348f:b0:3dc:76ad:7990 with SMTP id
 e9e14a558f8ab-3dc9b706abbmr145701725ab.15.1748389433167; Tue, 27 May 2025
 16:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-7-tj@kernel.org>
 <CAL+tcoCKqs1m4bAWTWv9aoQKs7ZpC5PXtMS2ooi6xEB6CbxN1w@mail.gmail.com> <aDYKoA8lpX_Zxrhh@slm.duckdns.org>
In-Reply-To: <aDYKoA8lpX_Zxrhh@slm.duckdns.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 28 May 2025 07:43:16 +0800
X-Gm-Features: AX0GCFsb4ySh9tHeNVChD-RPYFuj3Sh8LOL_jgy3hcYZQuZgVtS4GposQzjOWkg
Message-ID: <CAL+tcoCjaq=CxXdFtCqF4LdwCfenrHi7Nu-XHm+u--phuoC+EA@mail.gmail.com>
Subject: Re: [PATCH 6/8] net: tcp: tsq: Convert from tasklet to BH workqueue
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, 
	netdev@vger.kernel.org, allen.lkml@gmail.com, kernel-team@meta.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 2:55=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Sun, May 25, 2025 at 11:51:55AM +0800, Jason Xing wrote:
> > Sorry to revive the old thread! I noticed this change because I've
> > been doing an investigation around TSQ recently. I'm very cautious
> > about the change in the core/sensitive part of the networking area
> > because it might affect some corner cases beyond our limited test,
> > even though I've tested many rounds and no regression results
> > (including the latency between tcp_wfree and tcp_tsq_handler) show up.
> > My main concern is what the exact benefit/improvement it could bring
> > with the change applied since your BH workqueue commit[1] says the
> > tasklet mechanism has some flaws. I'd like to see if I can
> > reproduce/verify it.
>
> There won't be any behavioral benefits. It's mostly that it'd be great to
> get rid of tasklets with something which is more generic, so if BH workqu=
eue
> doesn't regress, we want to keep moving users to BH workqueue until all
> tasklet users are gone and then remove tasklet.

I see. So far I haven't see any side effect especially with testing
bulk transfer/multi-thread transfer, so if you're willing to repost it
after the merge window, please feel free to add:

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

