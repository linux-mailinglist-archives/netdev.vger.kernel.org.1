Return-Path: <netdev+bounces-288454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DxKFvCIB2ol7gIAu9opvQ
	(envelope-from <netdev+bounces-288454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:58:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 550E655795B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4F103006093
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB63859D3;
	Fri, 15 May 2026 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbhlP000"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0B37FF4C
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778878698; cv=none; b=dJBoJJ41T7x8HlSnOWRP/yuwqfztXh8lt7BRKJEqU5OerGGAt0dxvY1iC5LlpQ1p4+oZ91KBGlwQAyR/HSwwTon2lBSxEmhSta4iSX6j9QiGqKXKSW8oviKIY0TX1biVBMBNR3eKc2n6uYXzI7gyMIGRk2wQHyEyrzsn6aCPIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778878698; c=relaxed/simple;
	bh=qoIdKi3EBZW/eOldO5hee96vIJOQaNLXmYonDVJE700=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=LaJxblnRxTgp5GFC8MqiYIjx8/NQfVCuD6tlKxVWcyz4NzNFRro4/5yTe7eQQfXXJQE8xeEhjO1wIkcAZL0HYtYQriZKqD3syECR2DA6BPb9VCU/mdn1EqogzbmC65AhYilqeE0PQg1i26p9CzKyEA8Sn83I0gAD3Lqsg594O5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbhlP000; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778878696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNN6VmRPbN6JATFiof7VWl17ex7Nku19+5A2NoErxNY=;
	b=hbhlP000s8bOLnk+h/qUlwhn6UXqwOb648Fxow6e3YiSJFJF2S85hkN1zAvPtmVQQZ6cos
	jqwKoCjPOtGHjcGlEH7x/u781irXxmSRWLqk5QNrHhZGIRThD2W+feI1LD5BFQbFw3L9Sx
	LvfDy9QIEiZln+Ws9MigdYkKv/O0Ve4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-KV87kLXOOwyAAvK4XRLgAQ-1; Fri,
 15 May 2026 16:58:12 -0400
X-MC-Unique: KV87kLXOOwyAAvK4XRLgAQ-1
X-Mimecast-MFC-AGG-ID: KV87kLXOOwyAAvK4XRLgAQ_1778878691
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BB991956060;
	Fri, 15 May 2026 20:58:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EE371956053;
	Fri, 15 May 2026 20:58:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260515201416.GA3484095@google.com>
References: <20260515201416.GA3484095@google.com> <20260508182318.GA4145640@google.com> <20260428024400.123337-3-ebiggers@kernel.org> <20260428024400.123337-1-ebiggers@kernel.org> <286248.1778263325@warthog.procyon.org.uk> <287476.1778266603@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    linux-afs@lists.infradead.org,
    Marc Dionne <marc.dionne@auristor.com>, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/5] net/rxrpc: Use local FCrypt-PCBC implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2658458.1778878685.1@warthog.procyon.org.uk>
Date: Fri, 15 May 2026 21:58:05 +0100
Message-ID: <2658459.1778878685@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 550E655795B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288454-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Eric Biggers <ebiggers@kernel.org> wrote:

> Seems that the latest is now
> https://lore.kernel.org/netdev/20260514155304.2249591-4-dhowells@redhat.com/
> which is back to just using a linear buffer unconditionally.  I'll
> resend this series after that goes in.

Sounds good.  It turned out to be a bit faster just extracting the data into a
flat buffer in recvmsg.

I wonder about modifying the crypto/krb5/ code to use lib/crypto/ instead, but
that might be a little trickier as Chuck has patches to make NFS use it.

David


