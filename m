Return-Path: <netdev+bounces-181308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532CDA845F6
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278793AD0CD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978428A404;
	Thu, 10 Apr 2025 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kFYSLZGn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AE285402;
	Thu, 10 Apr 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294341; cv=none; b=KyXg0FguiRuQPM4R7YWMDJuNrePOaMEA1zHEMS2gC6ni1gPmM4Nx3bG5uHit0OHkhgpksXI/I7AHogqVKokv6PYVWS0dxnHNbRej2mO1vdd3nfgswkDemPo4+DPAdi2XT1I8ZcEkw80WjkmVQBTBdiMeGntSBeOUjVnS8IiJNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294341; c=relaxed/simple;
	bh=cyEcl36ZMQ+7BYVhQwxTXtcjxL+uQlChfsTdqwYxBUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5+s+YdMsi5azk7lHyjdYFmFAeDdtWfky25NvpbyDwokP6kqx3IiwqXV965dm4f3b1Zn5QExs2GglAOCIRpwPvvjFNJu8gUIkVmd3V3eAtwertkx2JmDWpZO5/5/5AHvb1xQ/j2O7YsagB9NKJxm7Xd0/Sh3aOh3Y/2lD9GJpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kFYSLZGn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/62dN21h79tYKEiUugMiakrgOMqBRCXopLSb/2cAcC0=; b=kFYSLZGniClDHL+em4RSrwPVXr
	uFmmmKhYKYMK3nTEiQRcB49K0Rwq7gwfndYsV/056SSLcXX2jotRAL3IZBwbFoI/5wwIzVjrNmnUx
	NASlpDZu6M1qnI9C6VvfkMWlfurFMsIUgP5c+J9cYB7w8U1KNuTZT7j8Z3znkF+nICoA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2sdV-008gne-MY; Thu, 10 Apr 2025 16:12:09 +0200
Date: Thu, 10 Apr 2025 16:12:09 +0200
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
Message-ID: <f4722246-5694-4b1a-9b1b-d4352fa54ee7@lunn.ch>
References: <20250408-netns-debugfs-v2-0-ca267f51461e@kernel.org>
 <20250408-netns-debugfs-v2-2-ca267f51461e@kernel.org>
 <1e717326-8551-419e-b185-5cfb20573b4f@lunn.ch>
 <91d6d3c60ef5d4ed90418f8a06228767be8a5b1b.camel@kernel.org>
 <ff2b7cfb7657a185469747d930b834dbdfdf6eac.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff2b7cfb7657a185469747d930b834dbdfdf6eac.camel@kernel.org>

> Oh, ok. I guess you mean these names?
> 
>         ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
>         ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net notrefcnt");
> 
> Two problems there:
> 
> 1/ they have an embedded space in the name which is just painful. Maybe we can replace those with underscores?
> 2/ they aren't named in a per-net namespace way

So the first question is, are the names ABI? Are they exposed to
userspace anywhere? Can we change them?

If we can change them, space to _ is a simple change. Another option
is what hwmon does, hwmon_sanitize_name() which turns a name into
something which is legal in a filesystem. If all of this code can be
pushed into the core tracker, so all trackers appear in debugfs, such
a sanitiser is the way i would go.

And if we can change the name, putting the netns into the name would
also work. There is then no need for the directory, if they have
unique names.

Looking at other users of ref_tracker_dir_init():

~/linux$ grep -r ref_tracker_dir_init
lib/test_ref_tracker.c:	ref_tracker_dir_init(&ref_dir, 100, "selftest");

Can only be loaded once, so is unique.

drivers/gpu/drm/i915/intel_wakeref.c:	ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, name);

Looks like it is unique for one GPU, but if you have multiple GPUs
they are not unique.

drivers/gpu/drm/i915/intel_runtime_pm.c:	ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT, dev_name(rpm->kdev));

At a guess kdev is unique.

drivers/gpu/drm/display/drm_dp_tunnel.c:	ref_tracker_dir_init(&mgr->ref_tracker, 16, "dptun");

Probably not unique.

net/core/net_namespace.c:	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
net/core/net_namespace.c:	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net notrefcnt");

Not unique across name spaces, but ...

So could the tracker core check if the debugfs file already exists,
emit a warning if it does, and keep going? I think debugfs_lookup()
will tell you if a file already exists, or debugfs_create_file() will
return -EEXIST, which is probably safer, no race condition.

	Andrew

