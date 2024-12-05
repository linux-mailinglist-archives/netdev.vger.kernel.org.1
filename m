Return-Path: <netdev+bounces-149343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8969B9E52EE
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E5E16783B
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AC723918F;
	Thu,  5 Dec 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipEPUsaq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CAC1D63C1
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395829; cv=none; b=aMQgnGCBJa4WT9mP7MOMjodP3U2IQ/yWbxes9d/ofRsJ1eva3U62Pp0yW/CEdG9/Lp85jtbnF8jQPj92iLnxhooGp7nZ+7iHdh74h+wVnIpCePs6KcRILNwj7z1W1m++f64KHkHl2KqAD+Y7RctbI7GdHLM7y8/UJGHGqS7YUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395829; c=relaxed/simple;
	bh=GAoOlPofgMBqWfJujDwo+YFQ72CJ4IjJ0WUUmmHruTA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=EjXX8YuiTsIUHP/6qvBzKRTszlzVEJIvCJXoBNN+dVpknhXX1VotR6ANTGtt5wFqMB4Tn2cgJ78i6TddDKlKZXXvHKuMQjvulHm1uBVBe/EVgod0gQ9rv5DoyUmM/UGKPgViQ8ofLCmvv5xVJXIWzdtMeOe6Kr3x2XFRj21KN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipEPUsaq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733395827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycHOMnBh816FhbuXVET66ivDaiNe7YcgyDVzdCppbeA=;
	b=ipEPUsaqUjIHO2YasxsrubslGPluwQw3w6vIjH/yZnJ6NzVewF1zBup4SCAnH6+8Ii9oP0
	a17FqattlQQzhxDaX2JUaX2aHRT9txvdgDAMM+fOsQ/A9Qyvwb73e0+ewLX81NV7H3ugEQ
	Qo48sQNEXMZFUlxtbK3XkW31EblWE8M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-cgDIirxSN7KzzoulNzp7YA-1; Thu,
 05 Dec 2024 05:50:23 -0500
X-MC-Unique: cgDIirxSN7KzzoulNzp7YA-1
X-Mimecast-MFC-AGG-ID: cgDIirxSN7KzzoulNzp7YA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE7CC1955F68;
	Thu,  5 Dec 2024 10:50:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B9F71956052;
	Thu,  5 Dec 2024 10:50:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <35033e7d707b4c68ae125820230d3cd3@AcuMS.aculab.com>
References: <35033e7d707b4c68ae125820230d3cd3@AcuMS.aculab.com> <20241202143057.378147-1-dhowells@redhat.com> <20241202143057.378147-3-dhowells@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: dhowells@redhat.com,
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Yunsheng Lin <linyunsheng@huawei.com>,
    "David S. Miller" <davem@davemloft.net>,
    "Eric
 Dumazet" <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 02/37] rxrpc: Use umin() and umax() rather than min_t()/max_t() where possible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1760514.1733395814.1@warthog.procyon.org.uk>
Date: Thu, 05 Dec 2024 10:50:14 +0000
Message-ID: <1760515.1733395814@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

David Laight <David.Laight@ACULAB.COM> wrote:

> > Use umin() and umax() rather than min_t()/max_t() where the type specified
> > is an unsigned type.
> 
> You are also changing some max() to umax().

Good point.  If I have to respin my patches again, I'll update that.

> Presumably they have always passed the type check so max() is fine.
> And max(foo, 1) would have required that 'foo' be 'signed int' and could
> potentially be negative when max(-1, 1) will be 1 but umax(-1, 1) is
> undefined.

There have been cases like this:

	unsigned long timeout;
	...
	timeout = max(timeout, 1);

where the macro would complain because it thought "timeout" and "1" were
different sizes, so "1UL" had to be used.  Using umax() deals with that issue.

David


