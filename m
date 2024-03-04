Return-Path: <netdev+bounces-77074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566838700DC
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164621F22613
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADFB3C470;
	Mon,  4 Mar 2024 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2P1hJm7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558F3BB3D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553380; cv=none; b=dPN2ok/t0/y1vSeqNR7r/dgz1dsCEdmDTfTsf7j0kUDz3+XdDOtcqoLdF3scyGGbyfuWYC8X1I2uxDMEWcf+nfUd/5pRVYGI0j9tbrb4ENYoe8CeE5kuw3OQK1/vX0y+D/Y6j/Ey5jc23wZEIo2ACcT0n2dij8pj9XNL6N5QBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553380; c=relaxed/simple;
	bh=1pxGewzqlg410BVrMDyNZyMJwDst5u/9e4GvFoWghQ8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=GKZxj+DaIJZx8bpxHVaf5YKzIt/jGaqSDFX8zfYce7URAjvW7iHfFIR6QmEzdZOh2pIa/fQcAAbQBkhzc/cu9a36sAqCJAtJHw9gn9HAORYRQ/Krf4FpKIN6HysV8xlNAJ7ARODhGR/dFp9J9EOpp9XRLRj4wsDAlxtA134zRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2P1hJm7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709553377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GqekJtMmWl332KPa2AiO9KOFfmzHxStTJwB9RAe/2jE=;
	b=J2P1hJm7thmq5POfniVch255ASmvsjXiike+HIZXV2DF01CbxWRI/Om+rEU/7B5uR+w3GN
	rcjtMwNW7SuwZ257HwnZpZKHyuHMV5MBwilYCXl2fkCVHPNb5sUHpTXNlOiCatPA7GVhyH
	5SnEayR4ZuL7P7BIGvBBX61arI9vqH8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-08FLQKdmPZGagpUscxRpgQ-1; Mon,
 04 Mar 2024 06:56:12 -0500
X-MC-Unique: 08FLQKdmPZGagpUscxRpgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36E213816B4B;
	Mon,  4 Mar 2024 11:56:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A53AA40C6EBA;
	Mon,  4 Mar 2024 11:56:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com>
References: <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com> <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com> <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com> <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com> <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Tong Tiangen <tongtiangen@huawei.com>,
    Al Viro <viro@kernel.org>, Jens Axboe <axboe@kernel.dk>,
    Christoph Hellwig <hch@lst.de>,
    Christian Brauner <christian@brauner.io>,
    David Laight <David.Laight@aculab.com>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
    linux-block@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7 07/12] iov_iter: Convert iterate*() to inline funcs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <769020.1709553367.1@warthog.procyon.org.uk>
Date: Mon, 04 Mar 2024 11:56:07 +0000
Message-ID: <769021.1709553367@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Actually, I think the right model is to get rid of that horrendous
> .copy_mc field entirely.
> 
> We only have one single place that uses it - that nasty core dumping
> code. And that code is *not* performance critical.
> 
> And not only isn't it performance-critical, it already does all the
> core dumping one page at a time because it doesn't want to write pages
> that were never mapped into user space.
> 
> So what we can do is
> 
>  (a) make the core dumping code *copy* the page to a good location
> with copy_mc_to_kernel() first
> 
>  (b) remove this horrendous .copy_mc crap entirely from iov_iter
> 
> This is slightly complicated by the fact that copy_mc_to_kernel() may
> not even exist, and architectures that don't have it don't want the
> silly extra copy. So we need to abstract the "copy to temporary page"
> code a bit. But that's probably a good thing anyway in that it forces
> us to have nice interfaces.
> 
> End result: something like the attached.
> 
> AGAIN: THIS IS ENTIRELY UNTESTED.
> 
> But hey, so was clearly all the .copy_mc code too that this removes, so...

I like it:-)

I've tested it by SIGQUIT'ing a number of processes and using gdb to examine
the coredumps - which seems to work - at least without the production of any
MCEs.  I'm not sure how I could test it with MCEs.

Feel free to add:

Reviewed-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>

That said, I wonder if:

	#ifdef copy_mc_to_kernel

should be:

	#ifdef CONFIG_ARCH_HAS_COPY_MC

and whether it's possible to find out dynamically if MCEs can occur at all.

David


