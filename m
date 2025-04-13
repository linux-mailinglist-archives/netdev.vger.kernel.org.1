Return-Path: <netdev+bounces-181976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDE4A873C8
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD441888B36
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39231EDA08;
	Sun, 13 Apr 2025 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b9oELIEY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E31D79A0;
	Sun, 13 Apr 2025 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744575117; cv=none; b=VAV4OMiiUB2l7enQYFimzzEY/N3Jl4uLtftvKb6Y/O9tH+eWH3TODj4dO1NP34UYJCK5maHBD/0utnlVxhWxSgm6HFVMz277shgk8Dp94iyptCuAbm6Rf/+uboR7c4ORLFEAbENFdBwEQmUExiqBxGQ7fM5euBlnzuKzxX5+8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744575117; c=relaxed/simple;
	bh=9x7o8RXUYxWYhEhxCmMSzdBw7qLDQvaJ8Ex76tElrtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Art9KiOfy0LmeKUiVDJ3iK5ANabHuouyOuKdNPqfbMGjlKTNWuwp/wTO8OW+Nv/h/KiYmxOq1vZx5PEugYKBeI/Lws6v48Ho2uRN0VrzCa56gWMJbbudgsu5ZmAv8orxoyZ6j9ZBLC7wTA/Pkb6s75X24rHPBEUUQZzWgWbp590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b9oELIEY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=+q2d/+Zk9HpLHjwJMrhsQNs3m2rsa3hqIxAUCvnHito=; b=b9
	oELIEY/x5b3gZHr4CqPZYYp75nXKXswBnp4rmH2qXgLLpaY+XogGzhdx2/7hryNr+Y0k2lSklS+NH
	WWP+PoH+vrDwm32kcqAv/vF7PRNcRfmL2uFlDZvw+f8Ssa82R5sx0I7Yn8uuhAxp9aGDgdy/AUtZb
	r/m4diS+CYSBojI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u434J-0095IW-3S; Sun, 13 Apr 2025 21:32:39 +0200
Date: Sun, 13 Apr 2025 21:32:39 +0200
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
Message-ID: <71adf369-a803-4d06-906c-97b5bf48bcf8@lunn.ch>
References: <20250408-netns-debugfs-v2-0-ca267f51461e@kernel.org>
 <20250408-netns-debugfs-v2-2-ca267f51461e@kernel.org>
 <1e717326-8551-419e-b185-5cfb20573b4f@lunn.ch>
 <91d6d3c60ef5d4ed90418f8a06228767be8a5b1b.camel@kernel.org>
 <ff2b7cfb7657a185469747d930b834dbdfdf6eac.camel@kernel.org>
 <f4722246-5694-4b1a-9b1b-d4352fa54ee7@lunn.ch>
 <23f93f84e000ebee28614bf85a4013648fa66a00.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23f93f84e000ebee28614bf85a4013648fa66a00.camel@kernel.org>

On Sun, Apr 13, 2025 at 07:40:59AM -0400, Jeff Layton wrote:
> On Thu, 2025-04-10 at 16:12 +0200, Andrew Lunn wrote:
> > > Oh, ok. I guess you mean these names?
> > > 
> > >         ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
> > >         ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net notrefcnt");
> > > 
> > > Two problems there:
> > > 
> > > 1/ they have an embedded space in the name which is just painful. Maybe we can replace those with underscores?
> > > 2/ they aren't named in a per-net namespace way
> > 
> > So the first question is, are the names ABI? Are they exposed to
> > userspace anywhere? Can we change them?
> > 
> > If we can change them, space to _ is a simple change. Another option
> > is what hwmon does, hwmon_sanitize_name() which turns a name into
> > something which is legal in a filesystem. If all of this code can be
> > pushed into the core tracker, so all trackers appear in debugfs, such
> > a sanitiser is the way i would go.
> > 
> > And if we can change the name, putting the netns into the name would
> > also work. There is then no need for the directory, if they have
> > unique names.
> > 
> > Looking at other users of ref_tracker_dir_init():
> > 
> > ~/linux$ grep -r ref_tracker_dir_init
> > lib/test_ref_tracker.c:	ref_tracker_dir_init(&ref_dir, 100, "selftest");
> > 
> > Can only be loaded once, so is unique.
> >
> > drivers/gpu/drm/i915/intel_wakeref.c:	ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, name);
> > 
> > Looks like it is unique for one GPU, but if you have multiple GPUs
> > they are not unique.
> > 
> 
> We'll need some input from the i915 folks then.

That is why i think it would be better to add a warning, give the i915
folks a heads up, and leave them to fix it how they want. We want the
warning anyway to cover new refcount instances being added.

	Andrew

