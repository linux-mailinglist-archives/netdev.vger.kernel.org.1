Return-Path: <netdev+bounces-107355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E3C91AA50
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84A928913D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55D519882E;
	Thu, 27 Jun 2024 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JPVpgkuR"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825319883C
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500637; cv=none; b=I/o9KeN7U/N0oZPDLiaWhbKB/jyGhkEDNhjhT4ysQVpUMAECuzRlefPca7vzleAvUUP31E79FtE+VFWpQeciYPxxgjQM80JDrKkUwuOytWQR2lkXgAJfIWKz8rJ+MNjO4ii5hIZb/iauJa25hPwWg7w/PqlE2aeMip02jwSvhzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500637; c=relaxed/simple;
	bh=5dXNm5UxZomvdSv4Z6NsCFdXUFx70IYxH1E73sMYS04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiKpVPyGPEpBHBGsvlX5Bsxm8wcfaY+4Gqy9cHeA4lhzO8s11oGu1N9LrpRsvj+3VM0iDx61agGKJuwsxv8y4aspAt1o8InAJS0fL73dDsEUTzq7mT1yGuvq+tuEmFJcs4sLSLLZuAkfwXjlr+dImy75UIK1L2l/tO+S3VtqwbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JPVpgkuR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DJsAn0ipIljAGuvyYUYoWHANShVsvmtBcrXWIXKmfQI=; b=JPVpgkuRdNUZ+546K1YfV52LFq
	SePvr43SGtdAXdjb5SQBgfDbkZyFR3h7JSUse1RZmYc0gCosDThll0W6RQWG6a0rAvA4cMlWdJwNA
	llVIPf0QXAmGUNKtoIiFYVAtigI7bVDbPFcckXCBWlQvDKnGY4o1GQrVvnZOfvg7V4lpTzDZwLvRz
	7A1PLThPzFgwgRPdNyFi8s3z+A8o8+iFqqonmOEzi7vbB7w3Ds5Y3IwPv90tKiSPdcnzNJymxrGYL
	noUrj3qUuOgoRnfH1x40+xdsBYrdUnkhOzZzS81exgWK2YMhoYzKX/tQK/xDpkv71csTnRRZXpzpe
	0rMSGomw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMqfC-0000000Df3F-38R8;
	Thu, 27 Jun 2024 15:03:54 +0000
Date: Thu, 27 Jun 2024 16:03:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] net: allow skb_datagram_iter to be called from any
 context
Message-ID: <Zn1_WtRUW-XeZVoL@casper.infradead.org>
References: <20240623081248.170613-1-sagi@grimberg.me>
 <1c5f5650ba2ffe99b068266ceb6e69f59661563f.camel@redhat.com>
 <20240625071028.2324a9f5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625071028.2324a9f5@kernel.org>

On Tue, Jun 25, 2024 at 07:10:28AM -0700, Jakub Kicinski wrote:
> On Tue, 25 Jun 2024 15:27:41 +0200 Paolo Abeni wrote:
> > On Sun, 2024-06-23 at 11:12 +0300, Sagi Grimberg wrote:
> > > We only use the mapping in a single context, so kmap_local is sufficient
> > > and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
> > > contain highmem compound pages and we need to map page by page.
> > > 
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>  
> > 
> > V1 is already applied to net-next, you need to either send a revert
> > first or share an incremental patch (that would be a fix, and will need
> > a fixes tag).
> > 
> > On next revision, please include the target tree in the subj prefix.
> 
> I think the bug exists in net (it just requires an arch with HIGHMEM 
> to be hit). So send the fix based on net/master and we'll deal with 
> the net-next conflict? Or you can send a revert for net-next at the
> same time, but I think the fix should target net.

It does not require an arch with highmem.  I was quite clear about this
in my earlier email.

