Return-Path: <netdev+bounces-212175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B6AB1E904
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1823A394B
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD7727D776;
	Fri,  8 Aug 2025 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WysgOu8A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FE223DE8
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659012; cv=none; b=pIrgamaV59uS2aKHyVt+OHEoQMYvOzWLrMHbabWa8fCOli6OCs5YNLXGdCpsdTE/ssfYFmizd6q9vAng3FT7lo3DZaoyNN3sFZhj0DJOmHSUvzXpQWfgcJhXCPdiNP8i9ZdUG5LnQNmojSvruDTZSurYUrKr/xSkFtidyAXoaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659012; c=relaxed/simple;
	bh=MsyaVOKmVlTMhnWubeG9+D8aXsH7Nj2z+khagOmN9g4=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=ERxs7c7qf+PMmeKhbzED7k8h6PaCuN1W5jLgDVuOG9TOCX388j9hT5GJtL3hdWXb+L8oEYPsE6q0UchPmqSwHwhsG/zOlCnrsVAVl2rCNHrOysMxUf+Mo+8p/zVh4CmfYx3qQ7nvaI/rSayF/0W/DAl+opnVMjg00CCxomBTLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WysgOu8A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754659009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+4nRLUZyUNTfksn4kFj0u3mtM2LKCIPv2I+IwbAen+w=;
	b=WysgOu8A1M+gV2wPMyHaMvrswK3jggB+M1D1YYSTx4sO/zXLbjCk63kl0mxtoQ8R3AycGr
	Q4RnjAIA1mXELqpRlFYY1avAdrnJm5zcHjlQfyrkeMHlaq63Jyz0bfYzkqcDB9vqmAFUnU
	gSxWL1czSaCV4z/1gzb+aSbg2KQvsfs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-g6pVE89ZNq2vZa_PmYv4ZQ-1; Fri,
 08 Aug 2025 09:16:46 -0400
X-MC-Unique: g6pVE89ZNq2vZa_PmYv4ZQ-1
X-Mimecast-MFC-AGG-ID: g6pVE89ZNq2vZa_PmYv4ZQ_1754659005
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96A451956089;
	Fri,  8 Aug 2025 13:16:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5FE8B1800280;
	Fri,  8 Aug 2025 13:16:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Mina Almasry <almasrymina@google.com>
cc: dhowells@redhat.com, willy@infradead.org, hch@infradead.org,
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
    Byungchul Park <byungchul@sk.com>, netfs@lists.linux.dev,
    netdev@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: Network filesystems and netmem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2869547.1754658999.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Aug 2025 14:16:39 +0100
Message-ID: <2869548.1754658999@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Mina,

Apologies for not keeping up with the stuff I proposed, but I had to go an=
d do
a load of bugfixing.  Anyway, that gave me time to think about the netmem
allocator and how *that* may be something network filesystems can make use=
 of.
I particularly like the way it can do DMA/IOMMU mapping in bulk (at least,=
 if
I understand it aright).

So what I'm thinking of is changing the network filesystems - at least the
ones I can - from using kmalloc() to allocate memory for protocol fragment=
s to
using the netmem allocator.  However, I think this might need to be
parameterisable by:

 (1) The socket.  We might want to group allocations relating to the same
     socket or destined to route through the same NIC together.

 (2) The destination address.  Again, we might need to group by NIC.  For =
TCP
     sockets, this likely doesn't matter as a connected TCP socket already
     knows this, but for a UDP socket, you can set that in sendmsg() (and
     indeed AF_RXRPC does just that).

 (3) The lifetime.  On a crude level, I would provide a hint flag that
     indicates whether it may be retained for some time (e.g. rxrpc DATA
     packets or TCP data) or whether the data is something we aren't going=
 to
     retain (e.g. rxrpc ACK packets) as we might want to group these
     differently.

So what I'm thinking of is creating a net core API that looks something li=
ke:

	#define NETMEM_HINT_UNRETAINED 0x1
	void *netmem_alloc(struct socket *sock, size_t len, unsigned int hints);
	void *netmem_free(void *mem);

though I'm tempted to make it:

	int netmem_alloc(struct socket *sock, size_t len, unsigned int hints,
			 struct bio_vec *bv);
	void netmem_free(struct bio_vec *bv);

to accommodate Christoph's plans for the future of bio_vec.

I'm going to leave the pin vs ref for direct I/O and splice issues and the
zerocopy-completion issues for later.

I'm using cifs as a testcase for this idea and now have it able to do
MSG_SPLICE_PAGES, though at the moment it's just grabbing pages and copyin=
g
data into them in the transport layer rather than using a fragment allocat=
or
or netmem.  See:

https://lore.kernel.org/linux-fsdevel/20250806203705.2560493-4-dhowells@re=
dhat.com/T/#t
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dcifs-experimental

David


