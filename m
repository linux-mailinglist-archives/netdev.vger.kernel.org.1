Return-Path: <netdev+bounces-205126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC520AFD7B9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9DF1BC246B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1123C519;
	Tue,  8 Jul 2025 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPoIV2N1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085A23AB95
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004668; cv=none; b=pUAYzkLTEVNj6BtC0J++HwU/M+dq8sToMFhS/sGMVmTtJ6L4mXShDQcZqmEhWst0L6NRe3A8mk9GWtT0UEmCjEr3NPkTVOlw4qQG0e+AkjeZXK39ths2g5GjkFhP8yPT/DaOq4KvJto56bPei656qxyNBVOmVZEanXg6t5Txbag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004668; c=relaxed/simple;
	bh=3W01dS28+sBmQz557shX2kn/QrQq3Ky2Im+D6oEOqn0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bjUhlLO+AueCblLojbLU0jZQIBxmxV8BgTZPnVo3+JiFoXXPqhrUyz1V5jWvrPaDfLLL+m75nALQ07xw+JXdyQGedAQJBa9sOvOnjq9yaCVb26F74rguFyPVvVcEN3JfCNfLtL94gtWr04RnU4gmTkCn60j9kwUWo+lwvcX+Ifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPoIV2N1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752004666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HGjclnOAXK9019FQJQ+HU3FhyBNdDo7cnQ/RXk00nA=;
	b=jPoIV2N1UQTT3LiHX2zBCve2ICbcxNYWuMRXXD6KfwSTNks5/Trdwsy/oJGgeuJYck0Ojc
	cy4ELVw586qJxB6XJuo5rHbXUcfNjr9UVfT0MeG/kuPZbrLba3LePZ7pedFc1tUy+xolMi
	p7amcHWYfDSfQsGpQ1QxhSiWp20PQpo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-c2RbVfKTNfuw-4QkRLBgkA-1; Tue,
 08 Jul 2025 15:57:39 -0400
X-MC-Unique: c2RbVfKTNfuw-4QkRLBgkA-1
X-Mimecast-MFC-AGG-ID: c2RbVfKTNfuw-4QkRLBgkA_1752004657
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33F3219560AD;
	Tue,  8 Jul 2025 19:57:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCCB519560AB;
	Tue,  8 Jul 2025 19:57:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250708120336.03383758@kernel.org>
References: <20250708120336.03383758@kernel.org> <20250707102435.2381045-1-dhowells@redhat.com> <20250707102435.2381045-3-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    "Junvyyang,
                         Tencent Zhuque Lab" <zhuque@tencent.com>,
    Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net 2/2] rxrpc: Fix bug due to prealloc collision
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2687075.1752004650.1@warthog.procyon.org.uk>
Date: Tue, 08 Jul 2025 20:57:30 +0100
Message-ID: <2687076.1752004650@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon,  7 Jul 2025 11:24:34 +0100 David Howells wrote:
> > +	rxrpc_prefail_call(call, RXRPC_CALL_LOCAL_ERROR, -EBADSLT);
> > +	__set_bit(RXRPC_CALL_RELEASED, &call->flags);
> 
> is the __set_bit() needed / intentional here?
> Looks like rxrpc_prefail_call() does:
> 
> 	WARN_ON_ONCE(__test_and_set_bit(RXRPC_CALL_RELEASED, &call->flags));

Actually, it shouldn't be.  I added that first, then realised that wasn't
sufficient.

I also realised there should be a third patch I failed to restack onto the git
branch.

Can you take the first patch and I'll alter this and repost this patch and add
the lost one?  Or should I just repost all three?

David


