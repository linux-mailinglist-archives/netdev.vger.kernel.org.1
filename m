Return-Path: <netdev+bounces-188656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 625B6AAE16C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035191C27606
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D56528980B;
	Wed,  7 May 2025 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8BU8KJs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE132874FE
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625576; cv=none; b=bEzqon+R+FH9WrFzfLaLbshOU26xj66HOzNMcmqtKenBMRS+q3EpLYKECmbM/ByVhaPHk9DTMUaEPdOOowdlYByDDWMPwXJueMTBOVgG+5cIJouy2Exxf1QdkhTc2UcznMRPx2B15fOqtMBdaVilOC8Faa8LCUQBpW8f0Kve8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625576; c=relaxed/simple;
	bh=uQKC6dtGtGKOkoBvjs8lqnwOX+h2c0EoCarFMLh5cO0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=uItYBtHd1vCqpiZoYTHfVj7uvyjZJ+Qx78VJ1IOENCAptYcsWP9nvTB0jzumreGd+V+kWLnToKwMXBY/FIGzGtoFp5yXFDVb2XDnZWBYTPg5HRS2qpu29Ekl/L5nh5O2YXJBPNsgX5+aNrIslpCvCj+vOopiyAx5G/0Lv5YfhHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8BU8KJs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746625573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoBfKW7DBVp6fse3P8uzY8pRsN3pHi/tyXtOsqhCvq0=;
	b=Z8BU8KJs0bBRObEjgdEjESDKqkmz5AGlMODFlZZ6j1wpD9J7wVi2GLUrXju990hbHBxS+P
	yeR5oV6CyCSP91QSsllHPwG5malA4f9zggfeEBrQ6Cmx6s8sHppHMLNrNiMP0FjKVh4ylo
	bxbESrqbn7EgOVX91jrxLlSTaEpgzhU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-qAmCHl7iMUuSMKoTGsiyZw-1; Wed,
 07 May 2025 09:46:07 -0400
X-MC-Unique: qAmCHl7iMUuSMKoTGsiyZw-1
X-Mimecast-MFC-AGG-ID: qAmCHl7iMUuSMKoTGsiyZw_1746625565
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEBC61800990;
	Wed,  7 May 2025 13:46:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99D6B19560A7;
	Wed,  7 May 2025 13:45:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250506112012.5779d652@kernel.org>
References: <20250506112012.5779d652@kernel.org> <20250505131446.7448e9bf@kernel.org> <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch> <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch> <1015189.1746187621@warthog.procyon.org.uk> <1021352.1746193306@warthog.procyon.org.uk> <1069540.1746202908@warthog.procyon.org.uk> <1216273.1746539449@warthog.procyon.org.uk>
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
Content-ID: <1352673.1746625556.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 May 2025 14:45:56 +0100
Message-ID: <1352674.1746625556@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 06 May 2025 14:50:49 +0100 David Howells wrote:
> > Jakub Kicinski <kuba@kernel.org> wrote:
> > > > (2) sendmsg(MSG_ZEROCOPY) suffers from the O_DIRECT vs fork() bug =
because
> > > >      it doesn't use page pinning.  It needs to use the GUP routine=
s.  =

> > > =

> > > We end up calling iov_iter_get_pages2(). Is it not setting
> > > FOLL_PIN is a conscious choice, or nobody cared until now?  =

> > =

> > iov_iter_get_pages*() predates GUP, I think.  There's now an
> > iov_iter_extract_pages() that does the pinning stuff, but you have to =
do a
> > different cleanup, which is why I created a new API call.
> > =

> > iov_iter_extract_pages() also does no pinning at all on pages extracte=
d from a
> > non-user iterator (e.g. ITER_BVEC).
> =

> FWIW it occurred to me after hitting send that we may not care. =

> We're talking about Tx, so the user pages are read only for the kernel.
> I don't think we have the "child gets the read data" problem?

Worse: if the child alters the data in the buffer to be transmitted after =
the
fork() (say it calls free() and malloc()), it can do so; if the parent tri=
es
that, there will be no effect.

> Likely all this will work well for ZC but not sure if we can "convert"
> the stack to phyaddr+len.

Me neither.  We also use bio_vec[] to hold lists of memory and then trawl =
them
to do cleanup, but a conversion to holding {phys,len} will mandate being a=
ble
to do some sort of reverse lookup.

> Okay, just keep in mind that we are working on 800Gbps NIC support these
> days, and MTU does not grow. So whatever we do - it must be fast fast.

Crazy:-)

One thing I've noticed in the uring stuff is that it doesn't seem to like =
the
idea of having an sk_buff pointing to more than one ubuf_info, presumably
because the sk_buff will point to the ubuf_info holding the zerocopyable d=
ata.
Is that actually necessary for SOCK_STREAM, though?

My thought for SOCK_STREAM is to have an ordered list of zerocopy source
records on the socket and a completion counter and not tag the skbuffs at =
all.
That way, an skbuff can carry data for multiple zerocopy send requests.

David


