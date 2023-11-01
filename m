Return-Path: <netdev+bounces-45585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D297DE6F5
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 21:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E5BB20E74
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D08214009;
	Wed,  1 Nov 2023 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R83lvkNs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF823BC
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 20:53:16 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A710C;
	Wed,  1 Nov 2023 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jr2IJpvzSamsXOQ8lXfBIM0+s8U3QePROmwmeYAD9Dw=; b=R83lvkNsHjCS4TcowK1Z86ucXU
	Es2gZG7fPpHuheWWpyon0W6eTYz92No6azsuQYBlel6aV+jF5sEu5LNO6xd3YGmzwypI5+ivIZc1i
	ZrINsBcOqffaqFC2fm8WMegcuIhciB/vhhp/sRF/zQjBDTljM7zfoDMMm2lhfwMq5nCrGTNx3aBav
	YS07/glanU8rebq7o/MwiegxK+pGs5LYWtNhfIO81GKl7V2sjRQZCvkIMaV0eRr/J19/4uxFxylQ3
	b0hl/+wBFJwAU3IXS0MbZ9UuoxOX0h44Qk5y9VL3nDbvpM1ShceZN6NNzkkxNrECzE7Rv9/O/3b3z
	zBDYF9PA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qyICc-009QIJ-0g;
	Wed, 01 Nov 2023 20:52:38 +0000
Date: Wed, 1 Nov 2023 20:52:38 +0000
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
Message-ID: <20231101205238.GI1957730@ZenIV>
References: <20231027095842.GA30868@redhat.com>
 <1952182.1698853516@warthog.procyon.org.uk>
 <20231101202302.GB32034@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101202302.GB32034@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 01, 2023 at 09:23:03PM +0100, Oleg Nesterov wrote:

> Yes this is confusing. Again, even the documentation is wrong! That is why
> I am trying to remove the misuse of read_seqbegin_or_lock(), then I am going
> to change the semantics of need_seqretry() to enforce the locking on the 2nd
> pass.

What for?  Sure, documentation needs to be fixed, but *not* in direction you
suggested in that patch.

Why would you want to force that "switch to locked on the second pass" policy
on every possible caller?

