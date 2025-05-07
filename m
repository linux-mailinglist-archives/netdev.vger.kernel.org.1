Return-Path: <netdev+bounces-188658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016ADAAE17F
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B57118825AD
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E328A72F;
	Wed,  7 May 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hum8pHbX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C26288CAB
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625799; cv=none; b=VKM3+otNBecgaWPMp3DthiboBjp3k0+8mIrT7rPugKlV3IWGjT5hBJoTsVs6Ne/dg3LLkigSq7IT/5z6mXOMuEd6DAMYOxpJ015X8OclXpm6DKTjgTVCAsyw/Fs0YiDwUK6aCrl5ebA8iS7z1DH3KJMHwVJ7kzxv+5/Xc6S+5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625799; c=relaxed/simple;
	bh=E+JiB+wCJoibyaEh9fxGv0fUPzEx8AZTi5D58AYwvGE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=r6GLkmPa1402AjDyH9RM+LtDFJRnDFu9bXQsmd/Bj7KffquiQGfn+KKqELx/slI6fsaUU2HudxvGfVJRbmD7ju+BS41yFPqp+etjsT8zqgAVHmzhpe3wnpsIB9SZTV7F9MjjK5ADfOjSpIT6E8MYmg4qInLp/jcSoepPop9VP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hum8pHbX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746625796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J4En6He341VYMLMQXImGbY4AQ8seOjvSVeRGWOh3Etk=;
	b=hum8pHbX5SLoN7j8Ok9GbLFgtyfs+nZZoYf6ghuTQ9LeHToeqtGixIrCxTsLvKaNHvgMZh
	3350naeZs1e9qGnRilusSm4M1L86NEDeOK5jqCtbf2qhKcjrRXWAdIJ/o1a1afbIh5YWBv
	Ofy20BRMFYptozmiQR++vd0wgi1vFwE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-3H6pWXltMgyzVAhQ5inEJg-1; Wed,
 07 May 2025 09:49:51 -0400
X-MC-Unique: 3H6pWXltMgyzVAhQ5inEJg-1
X-Mimecast-MFC-AGG-ID: 3H6pWXltMgyzVAhQ5inEJg_1746625789
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88542180035F;
	Wed,  7 May 2025 13:49:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73DF618001D8;
	Wed,  7 May 2025 13:49:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aBoVAd-XX_44RKbC@infradead.org>
References: <aBoVAd-XX_44RKbC@infradead.org> <20250505131446.7448e9bf@kernel.org> <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch> <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch> <1015189.1746187621@warthog.procyon.org.uk> <1021352.1746193306@warthog.procyon.org.uk> <1069540.1746202908@warthog.procyon.org.uk> <1216273.1746539449@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
    Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
    "David S. Miller" <davem@davemloft.net>,
    David Hildenbrand <david@redhat.com>,
    John Hubbard <jhubbard@nvidia.com>, willy@infradead.org,
    netdev@vger.kernel.org, linux-mm@kvack.org,
    Willem de Bruijn <willemb@google.com>
Subject: Re: Reorganising how the networking layer handles memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1352786.1746625783.1@warthog.procyon.org.uk>
Date: Wed, 07 May 2025 14:49:43 +0100
Message-ID: <1352787.1746625783@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Christoph Hellwig <hch@infradead.org> wrote:

> > Christoph Hellwig would like to make it such that the extractor gets
> > {phyaddr,len} rather than {page,off,len} - so all you, the network layer,
> > see is that you've got a span of memory to use as your buffer.  How that
> > span of memory is managed is the responsibility of whoever called
> > sendmsg() - and they need a callback to be able to handle that.
> 
> Not sure what the extractor is

Just a function that tries to get information out of the iov_iter.  In the
case of the networking layer, something like zerocopy_fill_skb_from_iter()
that calls iov_iter_get_pages2() currently.

David


