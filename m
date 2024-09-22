Return-Path: <netdev+bounces-129189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAD597E283
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 18:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20925280F18
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8364F2BAF1;
	Sun, 22 Sep 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaV3z9sA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0CF2BAE5;
	Sun, 22 Sep 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727023290; cv=none; b=Ssxwzr1zM5z3J7LD8uJTqnqOKJHu2k0p4eP15p9pyPHcxHEXsv1NltoLNH7Uj9ENxDNfx/2XjRKjyW1MpUZRt3pryr6uFjlktiW+vHodMCI8QEqyGRwwe3RITLGhdQEPul/hx9L3OTO/VKUZ0pVxJ6sjiouyUUNdAL289xUSXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727023290; c=relaxed/simple;
	bh=2o1PO5xwp6BUFqZ3PWOi/5u+0WeXqkLXlUA+//QHjEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcQJGOKgILXq+/Q3h08W483+zSi1YQR3yQSqh6X633TLEBXbT2/taRvLBnwOzcpSZ2RbA0e7sCXERqY3oP6YnarwFF7aB//FwMxFu9RwGQc8kRzxfD+937FpFiWO0R72rY5RmmFoXh+BDw1xn9sDSI2Au9L6RjOjHqQOIn2a6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaV3z9sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E77C4CEC6;
	Sun, 22 Sep 2024 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727023289;
	bh=2o1PO5xwp6BUFqZ3PWOi/5u+0WeXqkLXlUA+//QHjEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SaV3z9sA/bVMDyq0QMXBqWCuIrgcXII0QH0Kw9ejoGU5EfamowQ4M9v+MBu68qUNF
	 jGZo9+cR+bsrOKq+ZaUi6m3oJPT+/9Fth/rAV/56q7H7iDstMdahnQASYRmZrXm+qI
	 VvrMgwhztlUZ/Feu9dJrPUCCER+PNL78RVMQDJP3j4CyKFm59cVIxFXGzgvRalPEFU
	 Nc/FiZ9KrHxG6PruvLChUWfLpixMf3cFqafR0y46pUdcDtdPb5dQdGi04jkRbjoXuI
	 ixuO0Yl9yAkxwhCOXLNSOhTUQI8EiwodPsLy1we/fSFIF7hpGpXXoSwsHx53Oj0GV5
	 tTvq3Rnv0id+A==
Date: Sun, 22 Sep 2024 17:41:25 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Igal Liberman <igal.liberman@freescale.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: fman: Use of_node_put(muram_node) call only once in
 read_dts_node()
Message-ID: <20240922164125.GA3426578@kernel.org>
References: <e7caae09-70fd-431a-9df2-4c3068851a35@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7caae09-70fd-431a-9df2-4c3068851a35@web.de>

On Thu, Sep 19, 2024 at 06:15:23PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 19 Sep 2024 18:05:28 +0200
> 
> A of_node_put(muram_node) call was immediately used after a return code
> check for a of_address_to_resource() call in this function implementation.
> Thus use such a function call only once instead directly before the check.
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Hi Markus,

I agree with Jacob Keller's comment elsewhere that this seems
to be a reasonable change.

However, I am assuming this is targeted at net-next.
And net-next is currently closed for the v6.12 merge window.
Please consider reposting this patch once net-next reopens.
That will occur after v6.12-rc1 has been released. Which
I expect to be about a week from now.

Also, for networking patches please tag non-bug fixes for
net-next (and bug fixes for net, being sure to include a Fixes tag).

	Subject: [PATCH net-next] ...

Please see https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: defer

