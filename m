Return-Path: <netdev+bounces-45600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A257DE821
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 23:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E09B20EA7
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 22:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82201C297;
	Wed,  1 Nov 2023 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIw3hfz9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D2D1B272
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 22:30:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC0127
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698877854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5nvpkcJTxTwAjz7TlVL9V1dJMiHLHY5CMgLyZWBf8QQ=;
	b=SIw3hfz9aKpOZzNYCodfPNGx6p6Q1IYDhVeRBdHkKcivq7GpgHifi89WgZcYBeIehcciL3
	cM7iAtEkMKzg/dR73bCQQRF4a01zjN5OXmAZIadS1ZtgxCESA2ZbI7FhzeaeXxe1IMtGtw
	joRFd7ZFmag2FX/dOOwTJOO1ZJ5MlYA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-SQ0vVLarOueN27W4youw-Q-1; Wed, 01 Nov 2023 18:30:52 -0400
X-MC-Unique: SQ0vVLarOueN27W4youw-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 169C880B638;
	Wed,  1 Nov 2023 22:30:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with SMTP id 323781121308;
	Wed,  1 Nov 2023 22:30:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  1 Nov 2023 23:29:50 +0100 (CET)
Date: Wed, 1 Nov 2023 23:29:46 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231101222946.GF32034@redhat.com>
References: <20231101202302.GB32034@redhat.com>
 <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
 <1959032.1698873608@warthog.procyon.org.uk>
 <20231101221502.GE32034@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101221502.GE32034@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

sorry for noise, but in case I wasn't clear...

On 11/01, Oleg Nesterov wrote:
>
> On 11/01, David Howells wrote:
> >
> > However, I think just changing all of these to always-lockless isn't
> > necessarily the most optimal way.
>
> Yes, but so far I am trying to change the users which never take the
> lock for writing, so this patch doesn't change the current behaviour.
>
> > I wonder if struct seqlock would make more sense with an rwlock rather than a
> > spinlock.  As it is, it does an exclusive spinlock for the readpath which is
> > kind of overkill.
>
> Heh. Please see
>
> 	[PATCH 4/5] seqlock: introduce read_seqcount_begin_or_lock() and friends
> 	https://lore.kernel.org/all/20230913155005.GA26252@redhat.com/
>

I meant, we already have seqcount_rwlock_t, but currently you can't do
something like read_seqbegin_or_lock(&seqcount_rwlock_t).

> I am going to return to this later.

Yes.

Oleg.


