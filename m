Return-Path: <netdev+bounces-104864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6513D90EB67
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D895FB254EE
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFC614388C;
	Wed, 19 Jun 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0DRCX+m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C1143877
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801194; cv=none; b=oYZb/CPfUFUGFgD983P5TwRBbrIcvuHYrNi7cHkjRxy0d8lNODn9gKvOlp0Oj9vuCYr/GDJtkQ8dNPjli1ogDoWSA6K0DGUsvBVrd2qRh9wwZvjK6Fsa3kKEzNxCKvNgZYC8x00Y+zlT1Dad/oMUIeUcNezIKtiq9NBsysIUzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801194; c=relaxed/simple;
	bh=UPPoYpXGlY2kXJLry7GqQFnMlG9RZLe0V0JUUszjexU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Wkm7NelEOwqgmqSE1GTZduPhfQ97JRppKBcHwsHIBMLdBWltTYFxACNCS1/+1VLGnKIy2dMAzi4syPzu5vu4z8nloMZo4FZDfRcylvY346Lfq2f9vfxTRxaUaI71f4N9TE7+2dvHCpPpLVr0+0+jkL4arWsfpeCHTFk6HCivK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0DRCX+m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718801192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwmL+fG/llTdp/vpJmGydCr3gMOtfghdGY3vAIggc0Q=;
	b=O0DRCX+mgfYO+j4mB0t0BX8RxSFeyqW/WpKl0dLqeTI8k59f8jXQNpgds8MXRvYryQk9/p
	FBuFw/ZBJeqa5BnH6K/DjSEYotOgmAiUa1CCDhdRUBHMA0Foig9Yjl/Ipwuv1iB9QqliTy
	WdljwIP00nJh6PrNlr9oBpExiYVl1bQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-yKcZtpzFMSihiqWnguMZrQ-1; Wed,
 19 Jun 2024 08:46:29 -0400
X-MC-Unique: yKcZtpzFMSihiqWnguMZrQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CF3819560BD;
	Wed, 19 Jun 2024 12:46:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 985133000218;
	Wed, 19 Jun 2024 12:46:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240617095852.66c96be9@kernel.org>
References: <20240617095852.66c96be9@kernel.org> <202406161539.b5ff7b20-oliver.sang@intel.com> <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me> <Zm9fju2J6vBvl-E0@casper.infradead.org> <033294ee-e6e6-4dca-b60c-019cb72a6857@grimberg.me>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, Sagi Grimberg <sagi@grimberg.me>,
    Matthew Wilcox <willy@infradead.org>,
    kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
    lkp@intel.com, netdev@vger.kernel.org,
    Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <407789.1718801177.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Jun 2024 13:46:17 +0100
Message-ID: <407790.1718801177@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 17 Jun 2024 09:29:53 +0300 Sagi Grimberg wrote:
> > > Probably because kmap() returns page_address() for non-highmem pages
> > > while kmap_local_page() actually returns a kmap address:
> > >
> > >          if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !Page=
HighMem(page))
> > >                  return page_address(page);
> > >          return __kmap_local_pfn_prot(page_to_pfn(page), prot);
> > >
> > > so if skb frags are always lowmem (are they?) this is a false positi=
ve.  =

> > =

> > AFAIR these buffers are coming from the RX ring, so they should be =

> > coming from a page_frag_cache,
> > so I want to say always low memory?
> > =

> > > if they can be highmem, then you've uncovered a bug that nobody's
> > > noticed because nobody's testing on 32-bit any more.  =

> > =

> > Not sure, Jakub? Eric?
> =

> My uneducated guess would be that until recent(ish) sendpage rework
> from David Howells all high mem pages would have been single pages.

Um.  I touched the Tx side, not the Rx side.

I also don't know whether all high mem pages would be single pages.  I'll =
have
to defer that one to the MM folks.

David


