Return-Path: <netdev+bounces-195313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890D8ACF7FB
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 21:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC223A3265
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E5B27E7FB;
	Thu,  5 Jun 2025 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g8gtDFf9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52027E7DE
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151685; cv=none; b=FlDzD4DLmceb5HROYr6JYH89DaBTUwRkxvd229Ftt0g7F1HgzCxxKmtzkVO1h8ARpwiCPZY+eKQGrK+OPsGuim3ASKWpmfWn+bSxj7lCcLFrlqzdUPofJlhAdNKNcHos2p0vkQvZcjwIoT4YTv1cXGXCUHm1/ic2NgvC/7n/JXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151685; c=relaxed/simple;
	bh=dx802gucmxUSwuA6G9zpAVT4nNSZ6L0ITiOgaKUJeoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8AQDhcUn00c6DZWeQA0pnYAXzdm9GQP4KPLIKlyf3iW8JgPNf69AsxJ/f2xuyvJu4vqNCh5JTud8g++5K/p8l6AxUK42GpvobxODn4TYMLLTgKENZyMsBEvRLTyZPXAG9bXx87J0sJd1YycAyDHVZtcokrbGVX9WhfUJ3kW/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g8gtDFf9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2348ac8e0b4so2265ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749151683; x=1749756483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmU5jgwgBwNq/krxcY8pPMdH4Rz6BwK40x1VIx+RxWE=;
        b=g8gtDFf93KfcFZNv0BfZw2U7ZpYif8I4Iwk7GoVPvIVE/543FkkMObmTdfKUcosx8Z
         acse5slnM+r6/HEpsnVcjzyP4qRrb/pqcNxu7KLNow3EXOac7dOLwBrPHOoJEZHL+26y
         xpLwjdHTVd3QFedyXuTU0GG8WAdQhq+FZHuLSb6/jDEWiAidSji/kvvhhBpsl6QISnTV
         xrjfMZ5HQpORAgda1+oEEmG5KBvxa06CnVjXR8Y8qqvlLmVIZo0O+z/dAeQX3fkJcO9A
         0iGDTeze/Mto9+QAiibPjqXVCJ6DZJDqARFD6kCaeAlmrfamdyDU0c7We1PKxsLk/1je
         pmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749151683; x=1749756483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmU5jgwgBwNq/krxcY8pPMdH4Rz6BwK40x1VIx+RxWE=;
        b=BrYQDXYO9FKO6xpyfJebS3Obi/cCaxbnpoM/UelzQYZgEHVLucsTq6HTN31MuMQAge
         lFXsDbW1O/qUh1MssVu/fxXYjF5uZxNX/cV5gib6xL1PeiYlhik5PBpc/5XzuApTmtKr
         mPI/ZhJk0E12wFEdsTUB629yszNmhFiwj7FTyBPi9WCOyjCgv2gvraP/Cj2O5AW2sTbq
         gGPy8HoMi3Ej1CeT3A0d/NnqkDE7Fe3RS/XoTQzuzr3s8ejOoiWiWPAIiZEvA24dEofX
         0Mc/wkzz58idBgnpUXZppOYIWKutITQPOAk0uWrqMgVw+EuQe8Lzwt4o44ZFHLcOWQm8
         nNcA==
X-Forwarded-Encrypted: i=1; AJvYcCWbqCuASh6HG0F8K2xGhHk8pcuTfcJgsRoY11g9jbaJpOps8XhCYmYcS2/DRZMsKzmsvrUNAU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsinNlG0/wjD+d64e/WC2LPxOV1S3LvsWbuZhfh6tpmGQvaS3
	sRWwUAMw7GdQ1REZt3FD0ubw2vzcitqovCcDkCr0XSo7DZ1fWaoUCegcKZThFPNZis3pzU5i2i2
	HjG1PeV84JiNxWeTGBcgW+iAdn1EZuQsdnpGrTXdy
X-Gm-Gg: ASbGncv2pb6lkCtzgefSGhgJAmcrPWy5Ds76hoFwb4Lt8FMAftJftap4tbi6HZNZaAA
	wIOIOpl2CmMjP0lBixkrv5L+L1Aa05OCe8oPPph5YV73KEDR/LWRTbjybDrPlFH1cH8M+dX/6kU
	oi8pE17zUjG2jGIvVfSYw4OmhjVC778SGZRLKcIxGxdvsKoict0pkSQcc=
X-Google-Smtp-Source: AGHT+IFSB1k1iGfOurbGRkfNDqIiusOwckbHKMfilmFI2IBhAFHdiWOcxmpqiuagVNmXUXI0Db/8WyC397cn56HcfjE=
X-Received: by 2002:a17:902:cec2:b0:235:e1fa:1fbc with SMTP id
 d9443c01a7336-23602119b58mr618285ad.0.1749151682508; Thu, 05 Jun 2025
 12:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <770012.1748618092@warthog.procyon.org.uk> <CAHS8izMMU8QZrvXRiDjqwsBg_34s+dhvSyrU7XGMBuPF6eWyTA@mail.gmail.com>
 <1098853.1749051265@warthog.procyon.org.uk>
In-Reply-To: <1098853.1749051265@warthog.procyon.org.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Jun 2025 12:27:49 -0700
X-Gm-Features: AX0GCFuJhZKWoveVe84eQDh04RXfblHAGI46IIBQheHQs446JQ4neVlmb69Eroo
Message-ID: <CAHS8izNgJaj=S7HJ0Pjt2TaCA8_=vgmptzE2obmdLOuo8gby-w@mail.gmail.com>
Subject: Re: Device mem changes vs pinning/zerocopy changes
To: David Howells <dhowells@redhat.com>
Cc: willy@infradead.org, hch@infradead.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 8:34=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
> > FWIW, my initial gut feeling is that the work doesn't conflict that muc=
h.
> > The tcp devmem netmem/net_iov stuff is designed to follow the page stuf=
f,
> > and as the usage of struct page changes we're happy moving net_iovs and
> > netmems to do the same thing. My read is that it will take a small amou=
nt of
> > extra work, but there are no in-principle design conflicts, at least AF=
AICT
> > so far.
>
> The problem is more the code you changed in the current merge window I'm =
also
> wanting to change, so merge conflicts will arise.
>
> However, I'm also looking to move the points at which refs are taken/drop=
ped
> which will directly inpinge on the design of the code that's currently
> upstream.
>
> Would it help if I created some diagrams to show what I'm thinking of?
>

I think I understand what you want to do, but I'm happy looking at
diagrams or jumping on a call if needed.

[snip]

> > I think to accomplish what you're describing we need to modify
> > skb_frag_ref to do something else other than taking a reference on the
> > page or net_iov. I think maybe taking a reference on the skb itself
> > may be acceptable, and the skb can 'guarantee' that the individual
> > frags underneath it don't disappear while these functions are
> > executing.
>
> Maybe.  There is an issue with that, though it may not be insurmountable:=
 If a
> userspace process does, say, a MSG_ZEROCOPY send of a page worth of data =
over
> TCP, under a typicalish MTU, say, 1500, this will be split across at leas=
t
> three skbuffs.
>
> This would involve making a call into GUP to get a pin - but we'd need a
> separate pin for each skbuff and we might (in fact we currently do) end u=
p
> calling into GUP thrice to do the address translation and page pinning.
>
> What I want to do is to put this outside of the skbuff so that GUP pin ca=
n be
> shared - but if, instead, we attach a pin to each skbuff, we need to get =
that
> extra pin in some way.  Now, it may be reasonable to add a "get me an ext=
ra
> pin for such-and-such a range" thing and store the {physaddr,len} in the
> skbuff fragment, but we also have to be careful not to overrun the pin co=
unt -
> if there's even a pin count per se.
>

I think I understand. Currently the GUP is done in this call stack
(some helpers omitted), right?

tcp_send_message_locked
  skb_zerocopy_iter_stream
    zerocopy_fill_skb_from_iter
      iov_iter_get_pages2
        get_user_pages_fast

I think maybe the extra ref management you're referring to can be
tacked on to ubuf_info_msgzc? I still don't understand the need for a
completely new net_txbuf when the existing one seems to be almost what
you need, but I may be missing something.

I'm thinking, very roughly, I'm probably missing a lot of details:

1. Move the GUP call to msg_zerocopy_realloc, and save the pages array ther=
e.
2. Pass the ubuf_info_msgzc down to zerocopy_fill_skb_from_iter, and
have it fill the skb with pages from the GUP.
3. Modify skb_frag_ref such that if we want a reference on a frag that
belongs to a ubuf_info_msgzc, we grab a reference on the ubuf rather
than the frag.
4. Onces the ubuf_info_msgzc refcount hits 0, you can un-GUP the memory?

--=20
Thanks,
Mina

