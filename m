Return-Path: <netdev+bounces-45605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBEB7DE851
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 23:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E553281369
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50AF14F6E;
	Wed,  1 Nov 2023 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m3A9bjaI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33714AA5
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 22:49:52 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F17D65;
	Wed,  1 Nov 2023 15:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xo32g7hxYpv1bkgyx0yIq0WCh5UQYdpohhdrKedcg28=; b=m3A9bjaIsqcd/V0LsFFZuxeyo4
	Ua67vaTfb/bEA9+Ytrgn6Ycwb1mxw42ydBwMcKrxJITJXg7zUIf4iJrX5zzkMaQOkTgpdaEWeHkB+
	rOzKMkpEOBRxoWPpt2/xKXCFSN//yuKO43xb+CL5psrC0Umrh3Er0gauIQfpOIDaYHsW928LnxXbx
	DiOUbLcSlTlaYEfW1p2fHI9UrOI9Eur8M5u+HRC6dOknKaC440HUJB7qfZmSUN+B/9FgxTCb3ioLj
	SvzGq4yQEbIYnOCbiCTvN9bScQtiPmsxDqCF4RqNfq4TppRKbbsj9A75iGAxrA59iLAxORUCpBTXh
	yWW75LjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qyK19-009SsA-36;
	Wed, 01 Nov 2023 22:48:56 +0000
Date: Wed, 1 Nov 2023 22:48:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231101224855.GJ1957730@ZenIV>
References: <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
 <20231101202302.GB32034@redhat.com>
 <20231101205238.GI1957730@ZenIV>
 <20231101215214.GD32034@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101215214.GD32034@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 01, 2023 at 10:52:15PM +0100, Oleg Nesterov wrote:

> > Why would you want to force that "switch to locked on the second pass" policy
> > on every possible caller?
> 
> Because this is what (I think) read_seqbegin_or_lock() is supposed to do.
> It should take the lock for writing if the lockless access failed. At least
> according to the documentation.

Not really - it's literally seqbegin or lock, depending upon what the caller
tells it...  IMO the mistake in docs is the insistence on using do-while
loop for its users.

Take a look at d_walk() and try to shoehorn that into your variant.  Especially
the D_WALK_NORETRY handling...

