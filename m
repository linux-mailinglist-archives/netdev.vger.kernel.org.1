Return-Path: <netdev+bounces-148646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2309E2C74
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831BE280D63
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41881FDE01;
	Tue,  3 Dec 2024 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZ7BoyxA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E52A1EE039
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255707; cv=none; b=ond57i5sv1HG8UMDoFoOgRwH+X/z/YGUnqWG1EZ81kBrr4q+YoxMvcPfh+oqO+HArheKRBO03SHTjV4QJ/I+ZNZ4R500Ltd+RavCHMnwoe0c6e3SrdrNCFg2eUd1yqdd4MR03ULpbWmzmDOYddYY2FWHiLmR2vScewRaBrg5D2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255707; c=relaxed/simple;
	bh=N5t+jpeo/Kd0Sj1FWBHjHrKzMTEommNT5RZDIB53iDc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ceiqw2KomYK3+iebR96uIml2+fKbt20qQkQdvQ1A7YrHstNrSrfLDAWJqeQKIFD88vzLNK6kuqAEkEdtr01KFHdGiZUUJOOBxpysZdb86pRqBSdz9l8VVJaCPJT6m/k3EiARTiihOS6uatm2OjdtAzsGbnjLDXeByx7Y1algTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZ7BoyxA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733255705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ij8FfaOcSnuZLJFev0ynSdcsTu+uvN40kQmxbAbwMnU=;
	b=SZ7BoyxABt74o2FXjNAs48AwES/9lADVMaz/KtD1YKPXX+Kw7COn9YzwLMMscsMUq4IzfC
	O1RPzdjC64R2rU07u5GCxtieoLjsGVvEffxdySmeIscG3ORm1EDt9KxEHWKAI234jSQf2a
	atpYxIvufBqgU3Fojp2mHutXQ2p9hkA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-k-VvebuwM727CyJ5S1BGkQ-1; Tue,
 03 Dec 2024 14:55:04 -0500
X-MC-Unique: k-VvebuwM727CyJ5S1BGkQ-1
X-Mimecast-MFC-AGG-ID: k-VvebuwM727CyJ5S1BGkQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF680190D5D3;
	Tue,  3 Dec 2024 19:54:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20980195606C;
	Tue,  3 Dec 2024 19:54:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241202194834.67982f7f@kernel.org>
References: <20241202194834.67982f7f@kernel.org> <20241202143057.378147-1-dhowells@redhat.com> <20241202143057.378147-38-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Yunsheng Lin <linyunsheng@huawei.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 37/37] rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <726992.1733255693.1@warthog.procyon.org.uk>
Date: Tue, 03 Dec 2024 19:54:53 +0000
Message-ID: <726993.1733255693@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon,  2 Dec 2024 14:30:55 +0000 David Howells wrote:
> > +static inline ktime_t us_to_ktime(u64 us)
> > +{
> > +	return us * NSEC_PER_USEC;
> > +}
> 
> Is there a reason this doesn't exist in include/linux/ktime.h ?
> Given ns_to_ktime and ms_to_ktime already exist there adding a local
> but very similarly named helper in a local file appears questionable.

Yeah - I'll move it there.  It's just that winding backwards and forwards
through the patchset sucks if one of the patches modifies a major header.

David


