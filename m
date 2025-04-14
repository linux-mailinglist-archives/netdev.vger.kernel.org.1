Return-Path: <netdev+bounces-182518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106F1A88FEE
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 01:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1803817961A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C81F4180;
	Mon, 14 Apr 2025 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pk1Pe09B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6861E1DE2;
	Mon, 14 Apr 2025 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672137; cv=none; b=amYbBjsKiKZ6NWvfgxKc31Z+DDPHIuOVTiALwVRl+ktMpUJnY1zWPz6nWZf3PNQnUBum3l0WCJrYmPXFhR8NyqFXXi0itIBfJBiLuM81zS8+xiXfkwNBAtZUTMFV64xoC/m5l7avP+LEJoSURs9G3VqjfQPKyjwUN3u8KzgsD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672137; c=relaxed/simple;
	bh=ZVpS49bQ4BvR+DujUjxAEvHyKAz8vHDD53m4RUH41pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0/gSYj0ZQc6KpUm+AHS+Crcyx/WswVbNwixWgpnnsLgR6q52A8qCh+gLrOlsMfCpCtDmTmfej5Jf+YJL/doj6C1G3T1v8VGQi6FI8lmyYfimrP0RqUbDGif7LyjqRE+6Ae2i4hgf6Vvir5K/RtTPnXkBR6QwzJekiEezC2fu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pk1Pe09B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2Rf/9AzJwwGXUcQuYwxw97asEq6b3Sz7YHXKHLk4RTQ=; b=pk1Pe09Bp4gLKVzNZeV/QEJ1kL
	+Ce1wz2mLCJHJJtHeKrQXny+ad2CeV9FtqmSckM2kHja1Sxdfw8TtXkH29mte2yAvLBltNryA9sy7
	dONJQtzPigcacFTGYN7G13EApv/XxYSDG/hp0/MY27UXQyoxktDfWE202qpc6eHfcSTQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4Sv2-009IQp-0W; Tue, 15 Apr 2025 01:08:48 +0200
Date: Tue, 15 Apr 2025 01:08:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Qasim Ijaz <qasdev00@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] ref_tracker: add ability to register a file in
 debugfs for a ref_tracker_dir
Message-ID: <a86aab21-c539-48f5-bad1-25db9b8f3ced@lunn.ch>
References: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
 <20250414-reftrack-dbgfs-v1-2-f03585832203@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414-reftrack-dbgfs-v1-2-f03585832203@kernel.org>

On Mon, Apr 14, 2025 at 10:45:47AM -0400, Jeff Layton wrote:
> Currently, there is no convenient way to see the info that the
> ref_tracking infrastructure collects. Add a new function that other
> subsystems can optionally call to update the name field in the
> ref_tracker_dir and register a corresponding seq_file for it in the
> top-level ref_tracker directory.
> 
> Also, alter the pr_ostream infrastructure to allow the caller to specify
> a seq_file to which the output should go instead of printing to an
> arbitrary buffer or the kernel's ring buffer.

When i see an Also, or And, or a list in a commit message, i always
think, should this be multiple patches?

>  struct ostream {
>  	char *buf;
> +	struct seq_file *seq;
>  	int size, used;
>  };
>  
> @@ -73,7 +83,9 @@ struct ostream {
>  ({ \
>  	struct ostream *_s = (stream); \
>  \
> -	if (!_s->buf) { \
> +	if (_s->seq) { \
> +		seq_printf(_s->seq, fmt, ##args); \
> +	} else if (!_s->buf) { \
>  		pr_err(fmt, ##args); \
>  	} else { \
>  		int ret, len = _s->size - _s->used; \

The pr_ostream() macro is getting pretty convoluted. It currently
supports two user cases:

struct ostream os = {}; which means just use pr_err().

And os.buf points to an allocated buffer and the output should be
dumped there.

You are about to add a third.

Is it about time this got split up into three helper functions, and
you pass one to __ref_tracker_dir_pr_ostream()? Your choice.

> +/**
> + * ref_tracker_dir_debugfs - create debugfs file for ref_tracker_dir
> + * @dir: ref_tracker_dir to finalize
> + * @name: updated name of the ref_tracker_dir
> + *
> + * In some cases, the name given to a ref_tracker_dir is based on incomplete information,
> + * and may not be unique. Call this to finalize the name of @dir, and create a debugfs
> + * file for it.

Maybe extend the documentation with a comment that is name is not
unique within debugfs directory, a warning will be emitted but it is
not fatal to the tracker.

> + */
> +void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir, const char *name)
> +{
> +	strscpy(dir->name, name, sizeof(dir->name));

I don't know about this. Should we really overwrite the name passed
earlier? Would it be better to treat the name here only as the debugfs
filename?

> +	if (ref_tracker_debug_dir) {

Not needed

> +		dir->dentry = debugfs_create_file(dir->name, S_IFREG | 0400,
> +						  ref_tracker_debug_dir, dir,
> +						  &ref_tracker_debugfs_fops);
> +		if (IS_ERR(dir->dentry)) {
> +			pr_warn("ref_tracker: unable to create debugfs file for %s: %pe\n",
> +				dir->name, dir->dentry);
> +			dir->dentry = NULL;

this last statement should also be unneeded.

	Andrew

