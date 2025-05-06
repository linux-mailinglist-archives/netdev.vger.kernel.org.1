Return-Path: <netdev+bounces-188347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C34AAC6F3
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7F97A24B5
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510001F5849;
	Tue,  6 May 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBiWj3uq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073CB665
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539463; cv=none; b=NA5x2Urvsuz85/KHTX7X0P3csroK0GzjLJUYRbYbntBiYUgc7pZsn7ih0T3AN7zogMa8k4dTJCUameN+3ZbIWnuREY84uWL1ubF96rSfYKg3xrAQGfMc5y9HyAF9hyvzLOpMH53TSypgi8P3zqO5enLgFRjerfjsBxe/Mf5xOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539463; c=relaxed/simple;
	bh=xwDiM7vwR9941uDFI89avr47pUWGr0oXOZ6lkB8o9z4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=gcxvZ4dDCFriJL/occvDwOQS8E6SyyvVwY7EtIoiZpiiU7aR7g/1fKmit/Lq/GTAdQM5mn3/YicdOg+pGpz2nJw/BWGWWbMa7C2MVUryR/Ki5ohCAJfDRFPJiWbqiVvyTeeBqMLywq26eXT8E8PwFZxRDBoGIeYVPltbFKnkFbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBiWj3uq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746539460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=anEY3ujvZHPM5gqKoxq1z9X5UR9pcG63oQwy5E9oFtQ=;
	b=gBiWj3uqh/hh8OFf1E4KIwl5alkxCo1w4jCXWR1Sg5T+QFQlbtkQpg3hk6LMBuH8TU72rM
	7LBWXJ7Ia86pOfNNo1MpNESR8P6swaf/StbMK0dN8ieY7Lq7Ci+flhF2XftrL2roPTDekz
	OKGrDbdATweWp+qK1S0DYbMQi9HOaBc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-NlxD3tefNnmHZj9SuIFDYg-1; Tue,
 06 May 2025 09:50:56 -0400
X-MC-Unique: NlxD3tefNnmHZj9SuIFDYg-1
X-Mimecast-MFC-AGG-ID: NlxD3tefNnmHZj9SuIFDYg_1746539455
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65DA71801A30;
	Tue,  6 May 2025 13:50:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07EC61800876;
	Tue,  6 May 2025 13:50:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250505131446.7448e9bf@kernel.org>
References: <20250505131446.7448e9bf@kernel.org> <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch> <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch> <1015189.1746187621@warthog.procyon.org.uk> <1021352.1746193306@warthog.procyon.org.uk> <1069540.1746202908@warthog.procyon.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, Andrew Lunn <andrew@lunn.ch>,
    Eric Dumazet <edumazet@google.com>,
    "David
 S. Miller" <davem@davemloft.net>,
    David Hildenbrand <david@redhat.com>,
    John Hubbard <jhubbard@nvidia.com>,
    Christoph Hellwig <hch@infradead.org>, willy@infradead.org,
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
Content-ID: <1216272.1746539449.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 May 2025 14:50:49 +0100
Message-ID: <1216273.1746539449@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Jakub Kicinski <kuba@kernel.org> wrote:

> > (2) sendmsg(MSG_ZEROCOPY) suffers from the O_DIRECT vs fork() bug beca=
use
> >      it doesn't use page pinning.  It needs to use the GUP routines.
> =

> We end up calling iov_iter_get_pages2(). Is it not setting
> FOLL_PIN is a conscious choice, or nobody cared until now?

iov_iter_get_pages*() predates GUP, I think.  There's now an
iov_iter_extract_pages() that does the pinning stuff, but you have to do a
different cleanup, which is why I created a new API call.

iov_iter_extract_pages() also does no pinning at all on pages extracted fr=
om a
non-user iterator (e.g. ITER_BVEC).

> =

> >  (3) sendmsg(MSG_SPLICE_PAGES) isn't entirely satisfactory because it =
can't be
> >      used with certain memory types (e.g. slab).  It takes a ref on wh=
atever
> >      it is given - which is wrong if it should pin this instead.
> =

> s/takes a ref/requires a ref/ ? I mean - the caller implicitly grants =

> a ref  to the stack, right? But yes, the networking stack will try to
> release it.

I mean 'takes' as in skb_append_pagefrags() calls get_page() - something t=
hat
needs to be changed.

Christoph Hellwig would like to make it such that the extractor gets
{phyaddr,len} rather than {page,off,len} - so all you, the network layer, =
see
is that you've got a span of memory to use as your buffer.  How that span =
of
memory is managed is the responsibility of whoever called sendmsg() - and =
they
need a callback to be able to handle that.

> TAL at struct ubuf_info

I've looked at it, yes, however, I'm wondering if we can make it more gene=
ric
and usable by regular file DIO and splice also.

Further, we need a way to track pages we've pinned.  One way to do that is=
 to
simply rely on the sk_buff fragment array and keep track of which particul=
ar
bits need putting/unpinning/freeing/kfreeing/etc - but really that should =
be
handled by the caller unless it costs too much performance (which it might=
).

Once advantage of delegating it to the caller, though, and having the call=
er
keep track of which bits in still needs to hold on to by transmission
completion position is that we don't need to manage refs/pins across sk_bu=
ff
duplication - let alone what we should do with stuff that's kmalloc'd.

> >  (3) We also pass an optional 'refill' function to sendmsg.  As data i=
s
> >      sent, the code that extracts the data will call this to pin more =
user
> >      bufs (we don't necessarily want to pin everything up front).  The
> >      refill function is permitted to sleep to allow the amount of pinn=
ed
> >      memory to subside.
> =

> Why not feed the data as you get the notifications for completion?

Because there are multiple factors that govern the size of the chunks in w=
hich
the refilling is done:

 (1) We want to get user pages in batches to reduce the cost of the
     synchronisation MM has to do.  Further, the individual spans in the
     batches will be of variable size (folios can be of different sizes, f=
or
     example).  The idea of the 'refill' is that we go and refill as each
     batch is transcribed into skbuffs.

 (2) We don't want to run extraction too far ahead as that will delay the
     onset of transmission.

 (3) We don't want to pin too much at any one time as that builds memory
     pressure and in the worst case will cause OOM conditions.

So we need to balance things - particularly (1) and (2) - and accept that =
we
may get multiple refils in order to fill the socket transmission buffer.

> >  (5) The SO_EE_ORIGIN_ZEROCOPY completion notifications are then gener=
ated by
> >      the cleanup function.
> =

> Already the case? :)

This is more a note-to-self, but in what I'm thinking of doing would have =
the
sendmsg() handler inserting SO_EE_ORIGIN_ZEROCOPY into the socket receive
queue.

David


