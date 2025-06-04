Return-Path: <netdev+bounces-195118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93C8ACE1D7
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B3018990C3
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9091DDA34;
	Wed,  4 Jun 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNCkhmHp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5CD1D5AC6
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749052799; cv=none; b=OKGDXxiePdiYaFnuvjuMSAJ5aFKwu4ta57M/U7ZQT18NbxrsxxeNkz12sjqYiDp5TwO6uiJK3sJLlzl5KcL1/NHDp5BxL5faDZdVjv6qK1XU4OwdR5Mz2DwbsZRfJq+xt6gw+ZyoOlVIvpMxBdilioJpn6nD5jQ5/DUwj3I4qwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749052799; c=relaxed/simple;
	bh=WqKFJv1SYHO6yFnl3qXFauziCa37HPaucEDx/YKs/vc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=I5wWRM/IbzQoAFjVBxEHZuPUtqs/ipAR0K/1KIgw6B6EJKPaLCYLD52+DhnQEWfegvZg8FVbItXxk+ZjH7d5y3rAWe1mjqv6I9YFHmDm5OMkGOuK4Tyss2VcRsOqR3mHH3uQkcKypiUaXTuzojYUALxsZ2aOez6+AKLCTu8j0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNCkhmHp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749052796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mT2+8JawHf8ng4PjdszIvOlvJnF7IbRbXA1vmx0mRW4=;
	b=TNCkhmHpvkTC5IA3LItieeiqNA4mHI0jsD2Qg6gTZlMRkqVktX1pTjFnGYfCAiZtjZ8Axw
	YXp7HeewCiU3lv8vDSJPqi/6yvT1xgV+kT94GnTSuwV3Dz+F/9uK6kvHXprLumlV1d2cwM
	CIR1PprUlC7Xp7jr3+lWbIxY48bxkh4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-owy3DbuLP02dRlJaJjlY1w-1; Wed,
 04 Jun 2025 11:59:50 -0400
X-MC-Unique: owy3DbuLP02dRlJaJjlY1w-1
X-Mimecast-MFC-AGG-ID: owy3DbuLP02dRlJaJjlY1w_1749052789
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D15A318003FD;
	Wed,  4 Jun 2025 15:59:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DEC830002D0;
	Wed,  4 Jun 2025 15:59:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1098853.1749051265@warthog.procyon.org.uk>
References: <1098853.1749051265@warthog.procyon.org.uk> <CAHS8izMMU8QZrvXRiDjqwsBg_34s+dhvSyrU7XGMBuPF6eWyTA@mail.gmail.com> <770012.1748618092@warthog.procyon.org.uk>
To: Mina Almasry <almasrymina@google.com>
Cc: dhowells@redhat.com, willy@infradead.org, hch@infradead.org,
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
    netdev@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: Re: Device mem changes vs pinning/zerocopy changes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1099956.1749052763.1@warthog.procyon.org.uk>
Date: Wed, 04 Jun 2025 16:59:23 +0100
Message-ID: <1099957.1749052763@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

(Apologies, I accidentally sent the incomplete email)

> I think you need to modify the existing sk_buff. I think adding
> a new struct and migrating the entire net stack to use that is a bit
> too ambitious. But up to you. Just my 2 cents here.

It may come down to that, and if it does, we'll need to handle frags
differently.  Basically, for zerocopy, the following will all apply or come to
apply sometime in the future:

 (1) We're going to be getting arrays of {physaddr,len} from the higher
     layers.  I think Christoph's idea is that this makes DMA mapping easier.
     We will need to retain this.

 (2) There will be no page refcount.  We will obtain a pin (user zc) or there
     will be a destructor (kernel zc).  If the latter, it may have to be
     shared amongst multiple skbuffs.

 (3) We can't assume that a frag refers to a single page - or that there's
     even a necessarily a page struct.  And if there is a page struct, the
     metadata isn't going to be stored in it.  The page struct will contain a
     typed pointer to some other struct (e.g. folio).

 (4) We can't assume anything about the memory type of the frag (could be
     slab, for instance).

Obviously, if we copy the data into netmem buffers, we have full control of
that memory type.

David


