Return-Path: <netdev+bounces-207409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D58B070BA
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CE6188141F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2428D8F8;
	Wed, 16 Jul 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj7LRF1N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2D1B394F;
	Wed, 16 Jul 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655056; cv=none; b=iGs0V0hwtlLxI8h4VA4Cb/PfTVhkzrPVIaHEXhZ3HO1M6/dC8cwn1ocMaqB6ABTRGL5ZUtTurzMKInezx5xF3V7keFU69oPydvb8cSAvpbhAPDPQw4ZJ7CyBFsmmzoeIPuGVflqVhO9EDXXpdvmXhQfr+xkW3AOp5lqRg9tOc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655056; c=relaxed/simple;
	bh=E07Sh9EBdu7uG+nGMCmb5d3WNx5g0sRkwvY7QK9JAOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fl5HZxhGAtbp7DeGhkUjsayDIO/SbeSlDO2R7VaGrBDKap8yNWA6N4A97IwC3tUPjQKd0UvzHK8ZtIe/E0yXVPA59aF4uNgpJZm+c9SuXRBSJWMfW3MnUEgjyDRBjFHou5+WqE6tywKqiggrldV9hIr3ysNpWaXJCwWMT4OQZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj7LRF1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42051C4CEF0;
	Wed, 16 Jul 2025 08:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752655056;
	bh=E07Sh9EBdu7uG+nGMCmb5d3WNx5g0sRkwvY7QK9JAOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gj7LRF1Nj5FX87AbniuBrM1cQJxnIyrAPedd6U3+WI0V5xh3R/w/8qj0w4Kuf7oU8
	 4kJmNdVFrJJeDQEKZ8SfKy6LhdhggCo/7onjUUFOnzODRuA1gkjtfqO4AhvWxEyY0q
	 dROncgdW4qclGu58esEmMXl1+8UMffwtbkQ8H5llJRTMlxm7pej/ZD5idGTYVtMjLi
	 8dAGV9RY+fZTO4N7bdcy6/omEeU5T+RZBX/EdxUjEgmUBzJivBDBWlRXz+U+OdPC+C
	 CV2ctFeDpwEKb9BkI9ggWbOa8510lU4Zlw2r164eGFBEmqBI7omdML6DS5uj934tpE
	 xLhwKyDvvcWyw==
Date: Wed, 16 Jul 2025 09:37:31 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Wang Haoran <haoranwangsec@gmail.com>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: We found a bug in i40e_debugfs.c for the latest linux
Message-ID: <20250716083731.GI721198@horms.kernel.org>
References: <CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com>
 <20250714181032.GS721198@horms.kernel.org>
 <db65ea9a-7e23-48b9-a05a-cdd98c084598@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db65ea9a-7e23-48b9-a05a-cdd98c084598@intel.com>

On Tue, Jul 15, 2025 at 10:12:43AM -0700, Jacob Keller wrote:
> 
> 
> On 7/14/2025 11:10 AM, Simon Horman wrote:
> > On Thu, Jul 10, 2025 at 10:14:18AM +0800, Wang Haoran wrote:
> >> Hi, my name is Wang Haoran. We found a bug in the
> >> i40e_dbg_command_read function located in
> >> drivers/net/ethernet/intel/i40e/i40e_debugfs.c in the latest Linux
> >> kernel (version 6.15.5).
> >> The buffer "i40e_dbg_command_buf" has a size of 256. When formatted
> >> together with the network device name (name), a newline character, and
> >> a null terminator, the total formatted string length may exceed the
> >> buffer size of 256 bytes.
> >> Since "snprintf" returns the total number of bytes that would have
> >> been written (the length of  "%s: %s\n" ), this value may exceed the
> >> buffer length passed to copy_to_user(), this will ultimatly cause
> >> function "copy_to_user" report a buffer overflow error.
> >> Replacing snprintf with scnprintf ensures the return value never
> >> exceeds the specified buffer size, preventing such issues.
> > 
> > Thanks Wang Haoran.
> > 
> > I agree that using scnprintf() is a better choice here than snprintf().
> > 
> > But it is not clear to me that this is a bug.
> > 
> > I see that i40e_dbg_command_buf is initialised to be the
> > empty string. And I don't see it's contents being updated.
> > 
> > While ->name should be no longer than IFNAMSIZ - 1 (=15) bytes long,
> > excluding the trailing '\0'.
> > 
> > If so, the string formatted by the line below should always
> > comfortably fit within buf_size (256 bytes).
> > 
> 
> the string used to be "hello world" back in the day, but that got
> removed. I think it was supposed to be some sort of canary to indicate
> the driver interface was working. I really don't understand the logic of
> these buffers as they're *never* used. (I even checked some of our
> out-of-tree releases to see if there was a use there for some reason..
> nope.)

Thanks for looking into this.  FWIIW, I was also confused about the
intention of the code.

> We can probably just drop the i40e_dbg_command_buf (and similarly the
> i40e_netdev_command_buf) and save ~512K wasted space from the driver
> binary. I suppose we could use scnprintf here as well in the off chance
> that netdev->name is >256B somehow.

I think that using scnprintf() over snprintf() is a good practice.
Even if there is no bug.

I also think saving ~512K is a good idea.

> Or possibly we just drop the ability to read from these command files,
> since their entire purpose is to enable the debug interface and reading
> does nothing except return "<netdev name>: " right now. It doesn't ever
> return data, and there are other ways to get the netdev name than
> reading from this command file...

This seems best to me.  Because we can see that this code, which appears to
have minimal utility, does have some maintenance overhead (i.e. this
thread).

Less is more :)

...



