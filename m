Return-Path: <netdev+bounces-51963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25527FCCCD
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B46D1F20FB4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0AB1FCA;
	Wed, 29 Nov 2023 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbmZ7Sby"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D61FB5
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 02:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8299FC433C8;
	Wed, 29 Nov 2023 02:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701224121;
	bh=m5+XuauN4+WBse3E8utJLcD9Y8p4oqe8ag6KFg+M488=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DbmZ7Sby6ukh8Omx4Sa3N5otPE0OvlXL8+hsq4kyqqevW0EG7HOrSKrbRvmCmYsYo
	 /UmPrOjWHIbi93gWiic0yTnEe3y75JvDUp0trx7OSGQ8OYPVLzvXARJf1S+dguQbuj
	 0gMrg4GNemjG5IDK9uKGvhZT0gzmWwIk+xw+JjA1QQgZmzJW46ruVM+A8SXwVp/RgB
	 EbfZOi4TnsGD6sEGBJQypXPzPfYR1gCXTiD6ghIckA7uddyJXeJ0g6YPpTAWZu+KW8
	 fA0dnY7bK6H207cSu3SOsYhL/afqDS6pcmMq13rT51L6XJEYrZ/CZ8h+GywBLZhK0E
	 JcTcADeDhIFjw==
Date: Tue, 28 Nov 2023 18:15:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: David Laight <David.Laight@ACULAB.COM>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>, Herbert Xu
 <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] rhashtable: Better error message on allocation failure
Message-ID: <20231128181520.6245fa88@kernel.org>
In-Reply-To: <20231129015705.54zmp3xpqxfmo2fx@moria.home.lan>
References: <20231123235949.421106-1-kent.overstreet@linux.dev>
	<36bcdab2dae7429d9c2162879d0a3f9a@AcuMS.aculab.com>
	<20231128173536.35ff7e9c@kernel.org>
	<20231129015705.54zmp3xpqxfmo2fx@moria.home.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 20:57:05 -0500 Kent Overstreet wrote:
> > Yes, that's problematic :(
> > Let's leave out the GFP_NOWARN and add a pr_warn() instead of
> > the WARN()?  
> 
> pr_warn() instead of WARN() is fine, but the stack trace from
> warn_alloc() will be entirely useless.
> 
> Perhaps if we had a GFP flag to just suppress the backtrace in
> warn_alloc() - we could even stash a backtrace in the rhashtable at
> rhashtable_init() time, if we want to print out a more useful one.

Interesting idea, up to you how far down the rabbit hole you're
willing to go, really :)

Stating the obvious but would be good to add to the commit message,
if you decide to implement this, how many rht instances there are
on a sample system, IOW how much memory we expect the stacks to burn.

