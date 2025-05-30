Return-Path: <netdev+bounces-194389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1EEAC92B6
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFE24A31A9
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD5C2356A6;
	Fri, 30 May 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6+fFgJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32A823535F;
	Fri, 30 May 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620214; cv=none; b=lTM6CK7BoTjrrMQcKBTAkT+GcdABcDypuLscGWwSObcf4fIMu2C86gsfmCva1p4SaqX8kQuS+jZ42WpAKoAzwPrz6yuyfqdH6QvTzATcGOaZJiYzPyzJ1pxEIquNw8uJ4T/wp44ubJMzk+HolH6F0cW+W0pGOBrEKJ0libKDnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620214; c=relaxed/simple;
	bh=2Iyf8mSDBshTRiz5PJrtVzWAqREIRdiqRPTLEcSEsVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3OQBUtKJNnCX2BTDbquSc0MXYLq5puKF8W0LRPplRegF6GDR1vqrqM9vboCacQhEXU63XFpYXPcNT/zDLfCf6b6u00meYXiVz5MTEa9aeVPrHxmqBcP3GhFYThUuKOqriqlp8b8d9W/RA5IeWnfA/1f4FU6w6SFtdHxEyLBp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6+fFgJG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234d366e5f2so28756645ad.1;
        Fri, 30 May 2025 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748620212; x=1749225012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WC9Rvi27HJY83cUSYYfRK4cDUnKxrvB3LaS3LNFAIls=;
        b=R6+fFgJGxFv8dwcM9EdYnqGECV3pVy9XpBas+P7jPtKTQxpBiowILqPpQLipGlSQ7H
         3VMGgi36jVBP/M4eBscB0L2tnNxzm8BlD3xJrk0JGhjrAd2Hj6bZxf0IzXGYsSDAYeOw
         WgVRt8ivAs/q/SEOXdX3dkRIvDYKe1qG/KCyR8B21A3o7dF54dsHUSTdZICCRqSzMdik
         Oo2lSr1v2T4oVa+rXw6hMmTT1hVWg+1h8JezSgKYwFELvLioDH7Cjyp/cK8g9AL7pGaE
         RdkzFFLaLBuFmRHwDvgqfkG7sqoG+435VQyd5m0xkA6EHCQsPMzZxdtOyVwHQghLJxvP
         4aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748620212; x=1749225012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WC9Rvi27HJY83cUSYYfRK4cDUnKxrvB3LaS3LNFAIls=;
        b=jOFN0Lu1RpFIVb3T3PvN+xyEIUY6ZZ72ZKsgvnBYOxSfRPdPG8gJFKXlLE9l2ws0QG
         ndBartJfG0BC4mpqGeY6yL+And+NJW7OFCisXybdcMJETi2Lk1CfI7lbGv8yFAZ4ly9G
         rKxG7+SGbxewAs30NtwuAAKsgxodzbgXcvNLs4AHjgbOComAz2iLqoFQSS+pG+9IOfnu
         BgkEZQzi3xVRnHjzumSb2BGLxFrcVFBxvsp0OdqsFNC6Uybrslt2CEmiWlHznqO29PDW
         9WD4qAa6Q1+GYN6lC3E6ZsK/27d+kpFECx9Ljpf2314btzN+d9bp4cORXHUVSuJ5BUqU
         NPsw==
X-Forwarded-Encrypted: i=1; AJvYcCUQeaa3/eiHVPcvLaZljllJrK5lfDt73ni1rT/q7Hgmt3tbcS+pHPUj4/uZA89q9Qs43mg4K/ranf0G42Y=@vger.kernel.org, AJvYcCUkOY/ZGdABDjTGFvUVtR4aTqHC81SjhPBMNAGuHUZfx5Ap4U/K41gdA04mCwrzheGxsEkwTtYG@vger.kernel.org
X-Gm-Message-State: AOJu0YwpgYicf1pgOL3UZwFTL416OQJoTrdJlzKRynGrfoXGRRGGOCwC
	uY7qtmx/yb+W3rMyvpbT6w1/n2R/YgtpZo5duj9pk7YAbzo/Tt6yjMc=
X-Gm-Gg: ASbGncvRuuFMjDL73jx6kjO/g6St0gyb6L7O0r83S1ZKRK6wCw5ZL21Kzf0ztseIhW8
	f38LldsJ/sC4l+BhIGR5hOjSYM1/y4iLR1sQ3xN8tFkrtxcbhMZ9cRHSa4atozZ0eD8gLQCTUSo
	TMHbujHmtb3wS7u2fzBQZmoHboUjfRCXLFaKDvPHf2BwtR1+yMfAZ6/QbrZYEHKMAdINaQ7MDRi
	7w4VSNAeQaP6WfE29jVOqP8Xhq4EHJRxmU7GdFk2yeLDTSrepoLYJh//ueF4JSVNQNxM5zPQmHN
	5l333Y1su7GsEfXtcpzz+cb9TwsK3yekQAADz+MjYFO4C3c6oG989NJis1OuU12OVDtnq4pWnCg
	1R6CUkJFqIGAh
X-Google-Smtp-Source: AGHT+IFrbrx24i3weLMMBMlTpJuBxqZhfTy54w5ALO6Ziv0LCz3ADHeaOpQzDCySI+pz5XafZmwcJg==
X-Received: by 2002:a17:903:4410:b0:235:129a:175f with SMTP id d9443c01a7336-23529a28fb8mr53071005ad.34.1748620211824;
        Fri, 30 May 2025 08:50:11 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506bc861dsm30122415ad.4.2025.05.30.08.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 08:50:11 -0700 (PDT)
Date: Fri, 30 May 2025 08:50:10 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, willy@infradead.org,
	hch@infradead.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Device mem changes vs pinning/zerocopy changes
Message-ID: <aDnTsvbyKCTkZbOR@mini-arch>
References: <770012.1748618092@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <770012.1748618092@warthog.procyon.org.uk>

On 05/30, David Howells wrote:
> Hi Mina,
> 
> I've seen your transmission-side TCP devicemem stuff has just gone in and it
> conflicts somewhat with what I'm trying to do.  I think you're working on the
> problem bottom up and I'm working on it top down, so if you're willing to
> collaborate on it...?
> 
> So, to summarise what we need to change (you may already know all of this):
> 
>  (*) The refcount in struct page is going to go away.  The sk_buff fragment
>      wrangling code, however, occasionally decides to override the zerocopy
>      mode and grab refs on the pages pointed to by those fragments.  sk_buffs
>      *really* want those page refs - and it does simplify memory handling.
>      But.
> 
>      Anyway, we need to stop taking refs where possible.  A fragment may in
>      future point to a sequence of pages and we would only be getting a ref on
>      one of them.
> 
>  (*) Further, the page struct is intended to be slimmed down to a single typed
>      pointer if possible, so all the metadata in the net_iov struct will have
>      to be separately allocated.
> 
>  (*) Currently, when performing MSG_ZEROCOPY, we just take refs on the user
>      pages specified by the iterator but we need to stop doing that.  We need
>      to call GUP to take a "pin" instead (and must not take any refs).  The
>      pages we get access to may be folio-type, anon-type, some sort of device
>      type.
> 
>  (*) It would be good to do a batch lookup of user buffers to cut down on the
>      number of page table trawls we do - but, on the other hand, that might
>      generate more page faults upfront.
> 
>  (*) Splice and vmsplice.  If only I could uninvent them...  Anyway, they give
>      us buffers from a pipe - but the buffers come with destructors and should
>      not have refs taken on the pages we might think they have, but use the
>      destructor instead.
> 
>  (*) The intention is to change struct bio_vec to be just physical address and
>      length, with no page pointer.  You'd then use, say, kmap_local_phys() or
>      kmap_local_bvec() to access the contents from the cpu.  We could then
>      revert the fragment pointers to being bio_vecs.
> 
>  (*) Kernel services, such as network filesystems, can't pass kmalloc()'d data
>      to sendmsg(MSG_SPLICE_PAGES) because slabs don't have refcounts and, in
>      any case, the object lifetime is not managed by refcount.  However, if we
>      had a destructor, this restriction could go away.
> 
> 
> So what I'd like to do is:

[..]

>  (1) Separate fragment lifetime management from sk_buff.  No more wangling of
>      refcounts in the skbuff code.  If you clone an skb, you stick an extra
>      ref on the lifetime management struct, not the page.

For device memory TCP we already have this: net_devmem_dmabuf_binding
is the owner of the frags. And when we reference skb frag we reference
only this owner, not individual chunks: __skb_frag_ref -> get_netmem ->
net_devmem_get_net_iov (ref on the binding).

Will it be possible to generalize this to cover MSG_ZEROCOPY and splice
cases? From what I can tell, this is somewhat equivalent of your net_txbuf.

