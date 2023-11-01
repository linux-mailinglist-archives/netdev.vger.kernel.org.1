Return-Path: <netdev+bounces-45597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58397DE7F6
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 23:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EDCC1F2119D
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 22:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12914273;
	Wed,  1 Nov 2023 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEriGOSH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D846130
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 22:16:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E979E119
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698876971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mk6bwPrzaDg2FJugacWSMukVdQ2Mx/nmU75IHB2Mc8w=;
	b=SEriGOSHkKkk89XKS7gFnOvhWLaxkFyjLCg0mbR0wzM1/+pCOKPWmoq/Bm1Hbqwx+zc3a/
	VAe8gLM5WHbM8nJ5wsjmvYXdblR335lj/7a8jMDO18iz/1P6UteywspfXh/pZqaFLX5sTo
	evYGlj5GTJzdpvlKC6Tgb+vME33vHas=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-XZuOk2zqNd63bs2DQKNelA-1; Wed, 01 Nov 2023 18:16:08 -0400
X-MC-Unique: XZuOk2zqNd63bs2DQKNelA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1C4F185A781;
	Wed,  1 Nov 2023 22:16:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with SMTP id 142F12026D4C;
	Wed,  1 Nov 2023 22:16:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  1 Nov 2023 23:15:06 +0100 (CET)
Date: Wed, 1 Nov 2023 23:15:02 +0100
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
Message-ID: <20231101221502.GE32034@redhat.com>
References: <20231101202302.GB32034@redhat.com>
 <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
 <1959032.1698873608@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1959032.1698873608@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 11/01, David Howells wrote:
>
> However, I think just changing all of these to always-lockless isn't
> necessarily the most optimal way.

Yes, but so far I am trying to change the users which never take the
lock for writing, so this patch doesn't change the current behaviour.

> I wonder if struct seqlock would make more sense with an rwlock rather than a
> spinlock.  As it is, it does an exclusive spinlock for the readpath which is
> kind of overkill.

Heh. Please see

	[PATCH 4/5] seqlock: introduce read_seqcount_begin_or_lock() and friends
	https://lore.kernel.org/all/20230913155005.GA26252@redhat.com/

I am going to return to this later.

Oleg.


