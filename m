Return-Path: <netdev+bounces-51944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F977FCC7E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98E61C20BA7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3553E1854;
	Wed, 29 Nov 2023 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oNSEPgwg"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Nov 2023 18:04:03 PST
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2967D10EB
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:04:03 -0800 (PST)
Date: Tue, 28 Nov 2023 20:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701223029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L1k8Lkrc0tW8sRi92F4IevvT750Mj+bOuq2dpV02eGU=;
	b=oNSEPgwgTMhVJ/vrT9AaMuwhG/Rqt35TOFVE+Swrc8Ne83mRctLdKLdnpiGaxzOsUZIAi4
	gCOP66vf9BHBuI4TEI4OATpebJTspkElBH72Y7AusmfZV7ofSrs8en0knpfl3GB9KTfbtZ
	/gLPD9jx1JraZ0Z0tiwGotT6L7kSkD4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] rhashtable: Better error message on allocation failure
Message-ID: <20231129015705.54zmp3xpqxfmo2fx@moria.home.lan>
References: <20231123235949.421106-1-kent.overstreet@linux.dev>
 <36bcdab2dae7429d9c2162879d0a3f9a@AcuMS.aculab.com>
 <20231128173536.35ff7e9c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128173536.35ff7e9c@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 28, 2023 at 05:35:36PM -0800, Jakub Kicinski wrote:
> On Sat, 25 Nov 2023 15:23:49 +0000 David Laight wrote:
> > > +	new_tbl = bucket_table_alloc(ht, size, GFP_KERNEL|__GFP_NOWARN);
> > > +	if (new_tbl == NULL) {
> > > +		WARN("rhashtable bucket table allocation failure for %ps",  
> > 
> > Won't WARN() be a panic on systems with PANICK_ON_WARN set?
> 
> Yes, that's problematic :(
> Let's leave out the GFP_NOWARN and add a pr_warn() instead of
> the WARN()?

pr_warn() instead of WARN() is fine, but the stack trace from
warn_alloc() will be entirely useless.

Perhaps if we had a GFP flag to just suppress the backtrace in
warn_alloc() - we could even stash a backtrace in the rhashtable at
rhashtable_init() time, if we want to print out a more useful one.

