Return-Path: <netdev+bounces-215331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CFEB2E220
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 18:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B43718889AF
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEFC322C6F;
	Wed, 20 Aug 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FW5zu6VO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECAB322DCB
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706545; cv=none; b=qugK/kmqoOcVzztyYdWN6PprlGNsyIo1s7+DdmF9XMibhlwo9wTJLA4+0va4THtSuFtdC/GQaueJ1F4hKLbhHogV/89wpi9LICKdCuIPxpJzLD8tgvbcXX4coqbVNKz4XzN1M/XP4o6Eveko/tAb/UfYWDzyJXX/+WSiIDM1vqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706545; c=relaxed/simple;
	bh=FmHOEf7MjwzLR9SFGycQnEmLXC7g7DnQT/alR2QVzT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/8E7/llpyZGAlC6TiG5c8zs0VSydhEgwWgFgh/PhxEvh8h3nG8FQiXut4CCUtFIF/XY0C/Xv+KoDaQNCMGSZCtO8X6KFgteE2VMPA4PtQ65cBDhqJmOBEu75W5X+845zcxrTO3L/WcWArvzawGr5sRf829KiksPAW+eZF/sUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FW5zu6VO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755706543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBhB09wHdMhtpKjiEXV4nMg7vjjK7vxey/Z1jurlktk=;
	b=FW5zu6VOg9Nm+fqp4jYWT93+9dq50vELeZL7xdlzg1Fyl/POKk+qvbWyThaJ1wH/lUzBf/
	E0l6hiyuaSN0OPo57GsE48sbHvf8zdSqhI1XOCkwlWTpRF/5d9AKZ/Bja9IwW9kY5aM6oC
	6FbJ1eq0XPyYqyKrJI6AohGVsbcb5sg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-pQwrOgHiNpuJUE7ltJuCGA-1; Wed, 20 Aug 2025 12:15:41 -0400
X-MC-Unique: pQwrOgHiNpuJUE7ltJuCGA-1
X-Mimecast-MFC-AGG-ID: pQwrOgHiNpuJUE7ltJuCGA_1755706540
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0015aaso242705e9.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 09:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755706540; x=1756311340;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBhB09wHdMhtpKjiEXV4nMg7vjjK7vxey/Z1jurlktk=;
        b=Yt/JXQZ46kDlpiu6/XpyvIs7EaOU/Cyge9gDM18MsmXLviKOKPvdpFcB1cidknb3H9
         jsOOfXZWZ/x5NyL+d55Ojxjr0/mnXRaB/V/74fuOvUb4w2aWXJNa6vsABGmDdN8V8Onu
         yDzutMr9xtKyUahI8zOZUtJIZX6Iz5ySrk5SziDF+hO7UuXwCtZ0emNDu+LhghGtSL9i
         n3UpXwVwaiN8iEHPdrOJ+fJBvnhpL5Spj4xJy1H8nV1mchgoSoB5ggJcdZ0TY3sZYBI0
         XeKXfKDI5E40L1cVaeWS75u1FjJGwbZNdpqZJLRhrb2cho8ZAoQYf9qkOYVoGBI/zbQ0
         siSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9+PKfZYKEOfuPJ/g7VolYqDRBgfhXT8hGl/YYVO5Zwet+FLchw/w5LH/STesRPQnXisu4NAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlD+E+UeMbF4MuL/fcK2pwe89awtpxhTFIvYGtnhWsWY7NOf/J
	CZElbuSF8IGH4DyuGGSlX57LTonbQn27VTtgaI4o3BRP4h+IvkHS0Hyt7X7CcR0aVNxPJusAPWB
	9PTeoMsU8M7BjkgvCDG88jeLimMcQaU+5OxkXK7pgjxpSps57v4F5xH8bfw==
X-Gm-Gg: ASbGncveLTJC/VBxrYfhAC8XcEuAIWGH1WhVAY2OtwrhLIiXbF6uFSu0iINawYyX9Pf
	CV9rvKm6RmDq6XcDELMsdVIQ+MhDuwLzfrPzm7vYTNJ84j/KOXuplCGaNpmIndUD3soEmVOy0+6
	CB787uY1b6FQOzQkPNqIuyI6BFTb/6t5uOQDLER/7skYYtaEwfljpIeuH4tdnzGJ35AJA+cxDwN
	nqunmz39fc+BCudiEeqJ+KFrpAn5r41+DVYmQVywWZYSr6cJatTPbv96xfQAMx6WNlCS5As2SPZ
	oRJPnTksKRRk9WOkSsiqkKQyfB0vrL7mJb1OkNC/E+ete8JJta8=
X-Received: by 2002:a05:600c:154b:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b479f79d6mr27255945e9.18.1755706540006;
        Wed, 20 Aug 2025 09:15:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPJDWrBumRyAQCy4kE8EcRfm7sgn0bAFrBm23+c10zozIdTM+CPPG52qle89ZD6znNmpKcKQ==
X-Received: by 2002:a05:600c:154b:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b479f79d6mr27255695e9.18.1755706539550;
        Wed, 20 Aug 2025 09:15:39 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c5bfdasm37188635e9.19.2025.08.20.09.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:15:39 -0700 (PDT)
Date: Wed, 20 Aug 2025 18:15:36 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [PATCH net-next 5/6] netfilter: nft_set_pipapo: Store real
 pointer, adjust later.
Message-ID: <20250820181536.02e50df6@elisabeth>
In-Reply-To: <20250820160114.LI90UJWx@linutronix.de>
References: <20250820144738.24250-1-fw@strlen.de>
	<20250820144738.24250-6-fw@strlen.de>
	<20250820174401.5addbfc1@elisabeth>
	<20250820160114.LI90UJWx@linutronix.de>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 18:01:14 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2025-08-20 17:44:01 [+0200], Stefano Brivio wrote:
> > On Wed, 20 Aug 2025 16:47:37 +0200
> > Florian Westphal <fw@strlen.de> wrote:
> >   
> > > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > 
> > > The struct nft_pipapo_scratch is allocated, then aligned to the required
> > > alignment and difference (in bytes) is then saved in align_off. The
> > > aligned pointer is used later.
> > > While this works, it gets complicated with all the extra checks if
> > > all member before map are larger than the required alignment.
> > > 
> > > Instead of saving the aligned pointer, just save the returned pointer
> > > and align the map pointer in nft_pipapo_lookup() before using it. The
> > > alignment later on shouldn't be that expensive.  
> > 
> > The cost of doing the alignment later was the very reason why I added
> > this whole dance in the first place though. Did you check packet
> > matching rates before and after this?  
> 
> how? There was something under selftest which I used to ensure it still
> works.

tools/testing/selftests/net/netfilter/nft_concat_range.sh, you should add
"performance" to $TESTS (or just do TESTS=perfomance), they are normally
skipped because they take a while.

> On x86 it should be two additional opcodes (and + lea) and that might be
> interleaved.

I think so too, but I wonder if that has a much bigger effect on
subsequent cache loads rather than just those two instructions.

> Do you remember a rule of thumb of your improvement?

I added this right away with the initial implementation of the
vectorised version, so I didn't really check the difference or record
it anywhere, but I vaguely remember having something similar to the
version with your current change in an earlier draft and it was
something like 20 cycles difference with the 'net,port' test with 1000
entries... maybe, I'm really not sure anymore.

I'm especially not sure if my old draft was equivalent to this change.
I reported the original figures (with the alignment done in advance) in
the commit message of 7400b063969b ("nft_set_pipapo: Introduce
AVX2-based lookup implementation").

> As far as I remember the alignment code expects that the "hole" at the
> begin does not exceed a certain size and the lock there exceeds it.

I think you're right. But again, the alignment itself should be fast,
that's not what I'm concerned about.

-- 
Stefano


