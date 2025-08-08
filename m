Return-Path: <netdev+bounces-212291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C869B1EF50
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 22:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FB818C41E6
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE792222C8;
	Fri,  8 Aug 2025 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4dpJVXp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075E186E2D
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684200; cv=none; b=FTRyFRxmXtzYALyPSOkRxuVfBRixCVU6fCVF5HXrg37d+vAiOhBUhxIhoNLqMcWk6/eKyQCCKQcxjoolENiqticSL4MQfmRa+BU6X3BlcamY6gxsDTmVZ2Gx0OIDzgYM7ikO33XDNpM1btwsSY7jGht0dChW3HMmGV7fDNbPkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684200; c=relaxed/simple;
	bh=wGjTH6l2C41OFxKAr2ofoKLY1jqnvCm+zyZuz+u536Q=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rTpLbTXcdEWQNVW8oMxzFwDW7qXqPGoTl4jJnHxV3+xfDYgTWb3sGbHt4/+sY9jraxzgKEnJKQjX2fbTJTzrARNlUsUwM3XAnFGV64/RwPsxNJgkpT4NigGGQ+ONnGgQMY02PJzQkh4XB3Nte145An0L+LM/Za4060pJpBEZ498=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4dpJVXp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754684198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dODnAzex6kez236sAmX2/xLcfh/e67rE65nHZQ8pCLU=;
	b=E4dpJVXppDAA1ea/WphyoLBnd0flfJH9nFbhe9083RHOUdlG8IqJIvrvBsyohSbE/eAe8/
	6TXDDDLQSRtswaAubm83kwcj+CtrJxWOYEHLuvn1a5ilwQUUuSYChS+FQVzvOy2T/GBLon
	MKu4sQFauAyxtJNRizGL23gOdOmVSXo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-ypUQXZedOVqWhEjxpVEsVA-1; Fri,
 08 Aug 2025 16:16:34 -0400
X-MC-Unique: ypUQXZedOVqWhEjxpVEsVA-1
X-Mimecast-MFC-AGG-ID: ypUQXZedOVqWhEjxpVEsVA_1754684192
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EF831800446;
	Fri,  8 Aug 2025 20:16:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42D5F180029B;
	Fri,  8 Aug 2025 20:16:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHS8izN89j9deyODUjxQroKrLoiAq1kF+RVowuvVecmg4tNAUg@mail.gmail.com>
References: <CAHS8izN89j9deyODUjxQroKrLoiAq1kF+RVowuvVecmg4tNAUg@mail.gmail.com> <2869548.1754658999@warthog.procyon.org.uk>
To: Mina Almasry <almasrymina@google.com>
Cc: dhowells@redhat.com, Jesper Dangaard Brouer <hawk@kernel.org>,
    Ilias Apalodimas <ilias.apalodimas@linaro.org>, willy@infradead.org,
    hch@infradead.org, Jakub Kicinski <kuba@kernel.org>,
    Eric Dumazet <edumazet@google.com>,
    Byungchul Park <byungchul@sk.com>, netfs@lists.linux.dev,
    netdev@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: Re: Network filesystems and netmem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2941082.1754684186.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Aug 2025 21:16:26 +0100
Message-ID: <2941083.1754684186@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Mina Almasry <almasrymina@google.com> wrote:

> >  (1) The socket.  We might want to group allocations relating to the s=
ame
> >      socket or destined to route through the same NIC together.
> >
> >  (2) The destination address.  Again, we might need to group by NIC.  =
For TCP
> >      sockets, this likely doesn't matter as a connected TCP socket alr=
eady
> >      knows this, but for a UDP socket, you can set that in sendmsg() (=
and
> >      indeed AF_RXRPC does just that).
> >
> =

> the page_pool model groups memory by NIC (struct netdev), not socket
> or destination address. It may be feasible to extend it to be
> per-socket, but I don't immediately understand what that entails
> exactly. The page_pool uses the netdev for dma-mapping, i'm not sure
> what it would use the socket or destination address for (unless it's
> to grab the netdev :P).

Yeah - but the network filesystem doesn't necessarily know anything about =
what
NIC would be used... but a connected TCP socket surely does.  Likewise, a =
UDP
socket has to perform an address lookup to find the destination/route and =
thus
the NIC.

So, basically all three, the socket, the address and the flag would be hin=
ts,
possibly unused for now.

> Today the page_pool doesn't really care how long you hold onto the mem
> allocated from it.

It's not so much whether the page pool cares how long we hold on to the me=
m,
but for a fragment allocator we want to group things together of similar
lifetime as we don't get to reuse the page until all the things in it have
been released.

And if we're doing bulk DMA/IOMMU mapping, we also potentially have a seco=
nd
constraint: an IOMMU TLB entry may be keyed for a particular device.

> Honestly the subject of whether to extend the page_pool or implement a
> new allocator kinda comes up every once in a while.

Do we actually use the netmem page pools only for receiving?  If that's th=
e
case, then do I need to be managing this myself?  Providing my own fragmen=
t
allocator that handles bulk DMA mapping, that is.  I'd prefer to use an
existing one if I can.

David


