Return-Path: <netdev+bounces-227728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34FBB63CA
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 10:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3544C344204
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 08:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399EC2417C5;
	Fri,  3 Oct 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ1PXroa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAC2BD03;
	Fri,  3 Oct 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759480397; cv=none; b=EP8ZAbFiMNeHeMgFRRFwqfB1+uhHxCM2ZbI/xEBvxCcN87VeTM/sr/iZmdviy/7uVPVWRii0/ebkVYO5OncDuYKTpxz/YyXed2E8jubGW0iwI6E9ZXFhH0rGzUWkldeCJMdTloFoOXH/u+qWulRAWzYN8dTh0K66ri+hE0hRmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759480397; c=relaxed/simple;
	bh=cORH82os7Z9vzzZCaQBVNa1x9LozJi7fooVgSs75mTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CScLOQF/uqiiTl1JQdR62Y22pgEISWfcncVX8KeQeoF70a8F3Hm+Fkby4OjcoJTgVcRSuk1/pAvwa2RwA9tR8gnCsC8EQwigEsTFA+HIXIQ7TRWRtkmjPcWpjmdbB5Bh91qvLXJMS2P34WZz0yu5E/rGulz9xI6hRL8Dql5lHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ1PXroa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FC3C4CEF9;
	Fri,  3 Oct 2025 08:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759480396;
	bh=cORH82os7Z9vzzZCaQBVNa1x9LozJi7fooVgSs75mTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQ1PXroaGgADmdHPvR6Bx0A+QiAGMragM1LfMaNVbMMkSFgjhxqTrZuHo54PcvGvI
	 lE63uBHlij11MK0Cmq+WhJ44EO8gVd4ztJogz4uy+jO+SH6mkAgaiL5g4Ft1OVZK51
	 I6qNHYVurwj1KEiAkKqtAJ9VUC77rLq0AVkO5t59DAhhOuli5hcFV53FgcbRZxzm7i
	 eTVVeSD7wYnJtYhTGB5LaQpNV++Ke7s+oGl1yRWUqHdOIhClz1DYo9SXu0ZKegBPlW
	 8phXvT6tdyFbUR/wSHlZkjRDlgh4JyK2O9psj2mSMYkt7UTHDnP4TT0O5DCK1Vwv86
	 DC2USA1jVuYwQ==
Date: Fri, 3 Oct 2025 09:33:12 +0100
From: Simon Horman <horms@kernel.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
Message-ID: <20251003083312.GC2878334@horms.kernel.org>
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>

On Thu, Oct 02, 2025 at 06:05:41PM +0000, Kriish Sharma wrote:
> Fixes warnings observed during compilation with -Wformat-overflow:
> 
> drivers/net/wan/hdlc_ppp.c: In function ‘ppp_cp_event’:
> drivers/net/wan/hdlc_ppp.c:353:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
>   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wan/hdlc_ppp.c:342:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
>   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Introduce local variable `pname` and fallback to "unknown" if proto_name(pid)
> returns NULL.
> 
> Fixes: 262858079afd ("Add linux-next specific files for 20250926")
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

Hi Kriish,

As it looks like there will be another revision of this patch,
I have a few minor points on process for your consideration.

As a fix for Networking code present in the net tree this should probably
be targeted at the net tree. That means it should apply cleanly to that
tree (I assume it does). And the target tree should be denoted in the
subject.  Like this:

Subject: [PATCh net] ...

This is as opposed to non-fix patches which, generally, are targeted
at the net-nex tree.

Specifying the target tree helps land patches in the right place
for CI. And helps the maintainers too.

Also, git history isn't consistent here, but I would suggest
that a more succinct prefix is appropriate for this patch.
Perhaps 'hdlc_ppp:'

I.e.: Subject: [PATCH net] hdlc_ppp: ...

For more in process for networking patches please see:
https://docs.kernel.org/process/maintainer-netdev.html

Thanks!

...

