Return-Path: <netdev+bounces-187464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1696AA7403
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 15:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942309A3F86
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326CC255251;
	Fri,  2 May 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKAhgC/e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3732550AE
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193319; cv=none; b=lpy2wi2EXcxgS2eqI6az90fRRMXU3ZweW8OTb6RgOrGMsXuB90/8Yrag3kdjJThCmvairbTET76pNIXpnC2RDh0UaG2tgijlibWy4b4CGqjgkCxhPib78xRj5WG8ikw9+kGdjrPYCfoVGVQWMMigqpwhrl1f0thMBzMsURYRLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193319; c=relaxed/simple;
	bh=TROPBMCbMyvDVv3WXZTM227JrnzJPNhF7H75SnRW21c=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=B/+s8yqztb5/g7qVgVzQYbbPs6xkYl9rpZc5NGcES8/TUjwRyOPNAplgoc6qq4xsvi4A61Vn/26XOyCsiMnPoW1HOllZoBHB8irYqjbSaQgvz0qtbztO/TCe5ITbHxFyetZ0sOPzqlt+WT4FToGUo8317xQazXoaV6r5pq68E5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKAhgC/e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746193316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ynGlkRsk+Imh41/5x5BheKOozxWwcZOycP4AjDpPpk=;
	b=fKAhgC/eXkMkrxm7LJAsqvLkhMcorNzpeYyuUyrHd8H/h6e76y7ml3AP1DQz9fcyTgekF2
	MjDasQYW/5oTh8okz4e1hS75AWnECOMrWDRFqrORybA2BQimszysmNiH59bRMQYyjUzK3A
	PEgI+DIR9vizSKpr/RrtnkXCaFaE+8c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-_WnTn2J_OhyhN6lXR5WLZA-1; Fri,
 02 May 2025 09:41:53 -0400
X-MC-Unique: _WnTn2J_OhyhN6lXR5WLZA-1
X-Mimecast-MFC-AGG-ID: _WnTn2J_OhyhN6lXR5WLZA_1746193311
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 338F61801A14;
	Fri,  2 May 2025 13:41:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6778180045B;
	Fri,  2 May 2025 13:41:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
References: <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch> <1015189.1746187621@warthog.procyon.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
    John Hubbard <jhubbard@nvidia.com>,
    "David S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, willy@infradead.org,
    netdev@vger.kernel.org, linux-mm@kvack.org
Subject: MSG_ZEROCOPY and the O_DIRECT vs fork() race
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1021351.1746193306.1@warthog.procyon.org.uk>
Date: Fri, 02 May 2025 14:41:46 +0100
Message-ID: <1021352.1746193306@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Andrew Lunn <andrew@lunn.ch> wrote:

> > I'm looking into making the sendmsg() code properly handle the 'DIO vs
> > fork' issue (where pages need pinning rather than refs taken) and also
> > getting rid of the taking of refs entirely as the page refcount is going
> > to go away in the relatively near future.
> 
> Sorry, new to this conversation, and i don't know what you mean by DIO
> vs fork.

As I understand it, there's a race between O_DIRECT I/O and fork whereby if
you, say, start a DIO read operation on a page and then fork, the target page
gets attached to child and a copy made for the parent (because the refcount is
elevated by the I/O) - and so only the child sees the result.  This is made
more interesting by such as AIO where the parent gets the completion
notification, but not the data.

Further, a DIO write is then alterable by the child if the DMA has not yet
happened.

One of the things mm/gup.c does is to work around this issue...  However, I
don't think that MSG_ZEROCOPY handles this - and so zerocopy sendmsg is, I
think, subject to the same race.

> Could you point me at a discussion.

I don't know of one, offhand, apart from in the logs for mm/gup.c.  I've added
a couple more mm guys and the mm list to the cc: field.

The information in the description of fc1d8e7cca2daa18d2fe56b94874848adf89d7f5
may be relevant.

David


