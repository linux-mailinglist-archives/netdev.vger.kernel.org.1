Return-Path: <netdev+bounces-48408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6517EE3EA
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC211C2085B
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556E330CE1;
	Thu, 16 Nov 2023 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdcOwazp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB14AD
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 07:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700147281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5wxMBvbthLauuE7a3pZ8/SsXV3V5MFqmp1hCTliRys=;
	b=JdcOwazpkqx0J5NmsbaQIedgrf206zQ7hIIE1Ae1ky3zjBlDDVlahPNGGbRgExitpsY6Ik
	yDNYaB1jSOIjI7fcFSFwNS3GdtwdfZCUpdAwFI6zJ+tSuC35/hFTw71UofdKI0WUKmnR3l
	WhO2n60WHVTW4nR5Z36LHlYVIJfcfgg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-zChOR5FXNHK8oL95YJQJSg-1; Thu, 16 Nov 2023 10:07:58 -0500
X-MC-Unique: zChOR5FXNHK8oL95YJQJSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43A278007B3;
	Thu, 16 Nov 2023 15:07:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.23])
	by smtp.corp.redhat.com (Postfix) with SMTP id AF40540C6EBB;
	Thu, 16 Nov 2023 15:07:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 16 Nov 2023 16:06:53 +0100 (CET)
Date: Thu, 16 Nov 2023 16:06:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231116150650.GF18748@redhat.com>
References: <20231116141951.GE18748@redhat.com>
 <20231116131849.GA27763@redhat.com>
 <20231027095842.GA30868@redhat.com>
 <104932.1700142106@warthog.procyon.org.uk>
 <112162.1700146930@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112162.1700146930@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 11/16, David Howells wrote:
>
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > > > 	- the usage of read_seqbegin_or_lock/need_seqretry in
> > > > 	  this code makes no sense because read_seqlock_excl()
> > > > 	  is not possible
> > >
> > > Not exactly.  I think it should take a lock on the second pass.
> >
> > OK, then how about the patch below?
>
> That seems to work.

OK, I'll send V2 tomorrow.

Should I change fs/afs the same way?

Oleg.


