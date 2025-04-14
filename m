Return-Path: <netdev+bounces-182154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FBBA880B8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C752174544
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778881A28D;
	Mon, 14 Apr 2025 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aEfTl/Yg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF1A32;
	Mon, 14 Apr 2025 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634822; cv=none; b=u/cj9kxNafIeP/27QmTFurGieU1tzrHvGdAcNxYhRqjBG39x+02uXBYD+Ztmg5H8YSDThrMP5WV1ZgAGMUUT5vQHSSRcYIPGoJLT+YW42LFvJ+I+mTubW25OYS7NtQNiL1JGlx/H4SwSarZhSji/ta5neRghbtpx+9RnNU6joNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634822; c=relaxed/simple;
	bh=tDsxr8IsprCMFWPEXiYJ7xbp/M0BQXqqIb3yprthJZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiE6jZ4gxXKkPehOuDfSggXzI/C1G7EW1lptYHOBCWil61Wxb5rioDC3flMd1GGfI2YJBhGpmQYmuA8KUoin2XRlqOGMEFSKWzTXz1C9KrWV5MRgGyaCNnZ+u4J5TWbmJF/BFg0u+GH2JehGbbU1S3SvN2/piQ6GLfeRxLz0w4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aEfTl/Yg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/JhgBoVQSujfjNBj5Wy635vowG04nxCTg2Y/COi9708=; b=aE
	fTl/YgEutgzKWOPNpfQMdtCdlE6H22hmd4AjfkxXa1f9h1iDbjiDhpGLSc+gcdXAoLBGwddg7YTdS
	TCOQGBqReDNSiuDQYgukAZLALj/9xFc9z2CWaVw++cvzeL3h6vwX7zP/zQwnJtV1XrPogHa2CF5HE
	Itl26xZ5+mkC1/8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4JDA-009BUk-HY; Mon, 14 Apr 2025 14:46:52 +0200
Date: Mon, 14 Apr 2025 14:46:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: add debugfs files for showing netns refcount
 tracking info
Message-ID: <1bc3164b-0e41-49e1-9ed2-cf37997ab53e@lunn.ch>
References: <20250408-netns-debugfs-v2-0-ca267f51461e@kernel.org>
 <20250408-netns-debugfs-v2-2-ca267f51461e@kernel.org>
 <1e717326-8551-419e-b185-5cfb20573b4f@lunn.ch>
 <91d6d3c60ef5d4ed90418f8a06228767be8a5b1b.camel@kernel.org>
 <ff2b7cfb7657a185469747d930b834dbdfdf6eac.camel@kernel.org>
 <f4722246-5694-4b1a-9b1b-d4352fa54ee7@lunn.ch>
 <23f93f84e000ebee28614bf85a4013648fa66a00.camel@kernel.org>
 <71adf369-a803-4d06-906c-97b5bf48bcf8@lunn.ch>
 <a34f5e6d34210bae0badfd08aec15bed0bdb306e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a34f5e6d34210bae0badfd08aec15bed0bdb306e.camel@kernel.org>

> > > We'll need some input from the i915 folks then.
> > 
> > That is why i think it would be better to add a warning, give the i915
> > folks a heads up, and leave them to fix it how they want. We want the
> > warning anyway to cover new refcount instances being added.
> > 
> 
> There will definitely be a pr_warn() if creation fails. I was hoping to
> send a suggested change alongside the patchset, but I may have to just
> leave it up to them.
> 
> I threw together a draft patchset that auto-registers a debugfs file
> for every call to ref_tracker_dir_init(). The problem I've hit now
> though is that at least in the networking cases, the kernel calls
> ref_tracker_dir_init() very early in the process of creating a new
> objects, so we're not getting good names here:
> 
> The "name" in alloc_netdev_mqs is actually a format string, so we end
> up with a name like "eth%d" here:
> 
> net/core/dev.c: ref_tracker_dir_init(&dev->refcnt_tracker, 128, name);
 
Oh, yes, never thought about that...

It also seems like it might be a common problem, the subsystem defined
name has not been given yet, although the core dev_name(dev) should
work. But in netdev drivers, alloc_netdev_mqs() does not have access
to that.

> At the point that we call these (preinit), net->ns.inum hasn't been
> assigned yet, so we can't incorporate it properly into the dentry name:
> 
> net/core/net_namespace.c:       ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
> net/core/net_namespace.c:       ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net notrefcnt");
> 
> We could do the ref_tracker_dir_init() calls later, but we may end up
> missing some references that way (or end up crashing because the "dir"
> isn't initialized.
> 
> My current thinking is to add a new ref_tracker_dir_finalize() function
> that we could use to finalize the name and register the debugfs files
> after we have the requisite info. It's an extra manual step, but I like
> that better than moving around the ref_tracker_dir_init() calls.

Agree. Although, bike shedding, i don't really like the _finalize in
ref_tracker_dir_finalize(). Ideally this should be optional and
populate debugfs.  _finalize does not sound particularly optional. So
maybe ref_tracker_dir_debugfs()?

This also has the advantage of we need to worry less about GPU
drivers. They see no change in behaviour, but we can give them a heads
up the new call exists if they want to use it to populate debugfs.

	Andrew

