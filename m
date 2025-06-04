Return-Path: <netdev+bounces-195111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45424ACE0D0
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C051890CC7
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29361290DB3;
	Wed,  4 Jun 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQj00Jkn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360CA28FFF6
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048977; cv=none; b=IDzZyp8mE6z3GEQXFw0acOgBXpd6mKK2UPdVTDR55gMyQgwusZmQqDU0DQoy4cq9hOC7yV7JU45lbJW1HNjpfvNFUmId7+9Si7fUFNVxNWqxwV7QNlYjfovcnDPIAJlI9T5mzCWHFYSnf7jxqQUc1HgAUE4bAs9kD0gsuL9k8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048977; c=relaxed/simple;
	bh=7QokJdcqmNVhOdBHvR2ZqEXOlnZq2JyXuqgX7+oE/ZY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Nd9N4bWkA8dxpFPXmPwTOKBtNfvJiyulslYHQ1E1AKtCIaSIMUM/vLgsNlMnwCRc/jaV+0jNpcgvo0JuJWhnNk9bPLx/AEPp6jf1ATJkwvY7VRnQtTHt4czYci3sbesuoN5vQyN1PHaLYUiJ9MI4Up93oIV8i8swT25W0BcNuos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQj00Jkn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749048974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2h/EO0JQWU8btMtwutjXCkhqTordcpnOBoYcUhw0Ow=;
	b=JQj00JknTHh2UtFxTIWQ2Xsq3V8VGNbfyAZ+6tzWL9T11SKmHsocn81jGt7uuTs+oDud3X
	cwxacpWRfutF32QHQnfbJ+fXfRGjEjrKsxYfOPqFmMtpZRNd5A6WzNHrXBoMm8sQiDZAFE
	/mDUcaqjyv/lSzLUo9wj0npH+hd9/xI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-KRYDtLh5ML2VEw7kggBwTQ-1; Wed,
 04 Jun 2025 10:56:09 -0400
X-MC-Unique: KRYDtLh5ML2VEw7kggBwTQ-1
X-Mimecast-MFC-AGG-ID: KRYDtLh5ML2VEw7kggBwTQ_1749048968
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09F181801BE9;
	Wed,  4 Jun 2025 14:56:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D591E180045C;
	Wed,  4 Jun 2025 14:56:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aDnTsvbyKCTkZbOR@mini-arch>
References: <aDnTsvbyKCTkZbOR@mini-arch> <770012.1748618092@warthog.procyon.org.uk>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: dhowells@redhat.com, Mina Almasry <almasrymina@google.com>,
    willy@infradead.org, hch@infradead.org,
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
    netdev@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: Re: Device mem changes vs pinning/zerocopy changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1097884.1749048961.1@warthog.procyon.org.uk>
Date: Wed, 04 Jun 2025 15:56:01 +0100
Message-ID: <1097885.1749048961@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Stanislav Fomichev <stfomichev@gmail.com> wrote:

> >  (1) Separate fragment lifetime management from sk_buff.  No more wangling
> >      of refcounts in the skbuff code.  If you clone an skb, you stick an
> >      extra ref on the lifetime management struct, not the page.
> 
> For device memory TCP we already have this: net_devmem_dmabuf_binding
> is the owner of the frags. And when we reference skb frag we reference
> only this owner, not individual chunks: __skb_frag_ref -> get_netmem ->
> net_devmem_get_net_iov (ref on the binding).
>
> Will it be possible to generalize this to cover MSG_ZEROCOPY and splice
> cases? From what I can tell, this is somewhat equivalent of your net_txbuf.

Yes and no.  The net_devmem stuff that's now upstream still manages refs on a
per-skb-frag basis.  What I'm looking to do is to move it out of the skb and
into a separate struct so that the ref on a chunk of memory can be shared
between several skb-frags, quite possibly spread between several skbs.

This is especially important for various types of zerocopy memory where we
won't actually be allowed to take refs.

David


