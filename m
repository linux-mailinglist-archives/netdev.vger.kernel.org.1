Return-Path: <netdev+bounces-179083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D76CA7A858
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 19:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845FD3AE2F5
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1382512FA;
	Thu,  3 Apr 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OisHarl2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372A250C15;
	Thu,  3 Apr 2025 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699584; cv=none; b=i5+V7RIvssp1bpFN1lpdQoxwwUV33QyDDAnXPyZ1Qn8WXfhdEan0beXOM3ppqu8aluLNBO+kYF36KsSk1U3CxYI4504q/9Kjlcd5SJz7qY9LCrduLrFjAUNz7mshvsKLTD6Yji2x/B9sWpHY3tfvCfvWYgN9CkRJtloMB0acrF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699584; c=relaxed/simple;
	bh=lwCLOrKjqeBhvraMsNIzlF4vAoIOPP0pmmDtxveRJqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l68nO2gIRZsDDM4ZAq39js5urn5J5d8uegFXTypphiab+YbP+x7x5YP3Y8p4ojZ7q8rDdbQkXqzFWbtYb4QO1Cfcn5a0gPdCoZPt6nvBmWrFRC7OVZ2kdNgcPoWB8Ic2CfAl6LrIbpnDxt4qfBzAtsGKYhgnu4eVxCJPAcfphjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OisHarl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA35C4CEE3;
	Thu,  3 Apr 2025 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743699584;
	bh=lwCLOrKjqeBhvraMsNIzlF4vAoIOPP0pmmDtxveRJqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OisHarl2Us9CgvsWT11VflIIAJ0QwjMDmVoWz4CDXVhOGuxfeXWJp60H92QVPkP7S
	 Z/Ar2eg8aLxbxF5Xl5bniVmOvfrhJ80xpgphbJNPU4Xo63HromqJ3baeudaEJ7C7MV
	 tsVmk6clyNFwj4K3OKSqIxzy19yhVTLB4XDboAtVEDcY3TWh/FI95zpVpSTGbPPmbB
	 eB7h1JRHJE276B5g0fGUtu7Vpe61y6hL4NDyTEJDx3cpJ6t3v+QAz7UnTdzli+U5bL
	 6rktoftwaMyE5uOIOIH/sGow2JtP41V/obKNb5K4NvGesWVB37ukxmSVYIHgGDKC61
	 FYKQCpMYwUmgg==
Date: Thu, 3 Apr 2025 09:59:41 -0700
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	torvalds@linux-foundation.org, peterz@infradead.org,
	Jann Horn <jannh@google.com>, andriy.shevchenko@linux.intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Harry Yoo <harry.yoo@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Lameter <cl@gentwo.org>
Subject: Re: [RFC] slab: introduce auto_kfree macro
Message-ID: <202504030955.5C4B7D82@keescook>
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
 <3f387b13-5482-46ed-9f52-4a9ed7001e67@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f387b13-5482-46ed-9f52-4a9ed7001e67@suse.cz>

On Wed, Apr 02, 2025 at 12:44:50PM +0200, Vlastimil Babka wrote:
> Cc Kees and others from his related efforts:
> 
> https://lore.kernel.org/all/20250321202620.work.175-kees@kernel.org/

I think, unfortunately, the consensus is that "invisible side-effects"
are not going to be tolerated. After I finish with kmalloc_obj(), I'd
like to take another run at this for basically providing something like:

static inline __must_check
void *kfree(void *p) { __kfree(p); return NULL; }

And then switch all:

	kfree(s->ptr);

to

	s->ptr = kfree(s->ptr);

Where s->ptr isn't used again.

-Kees

> 
> On 4/1/25 15:44, Przemek Kitszel wrote:
> > Add auto_kfree macro that acts as a higher level wrapper for manual
> > __free(kfree) invocation, and sets the pointer to NULL - to have both
> > well defined behavior also for the case code would lack other assignement.
> > 
> > Consider the following code:
> > int my_foo(int arg)
> > {
> > 	struct my_dev_foo *foo __free(kfree); /* no assignement */
> > 
> > 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> > 	/* ... */
> > }
> > 
> > So far it is fine and even optimal in terms of not assigning when
> > not needed. But it is typical to don't touch (and sadly to don't
> > think about) code that is not related to the change, so let's consider
> > an extension to the above, namely an "early return" style to check
> > arg prior to allocation:
> > int my_foo(int arg)
> > {
> >         struct my_dev_foo *foo __free(kfree); /* no assignement */
> > +
> > +	if (!arg)
> > +		return -EINVAL;
> >         foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> >         /* ... */
> > }
> > Now we have uninitialized foo passed to kfree, what likely will crash.
> > One could argue that `= NULL` should be added to this patch, but it is
> > easy to forgot, especially when the foo declaration is outside of the
> > default git context.
> > 
> > With new auto_kfree, we simply will start with
> > 	struct my_dev_foo *foo auto_kfree;
> > and be safe against future extensions.
> > 
> > I believe this will open up way for broader adoption of Scope Based
> > Resource Management, say in networking.
> > I also believe that my proposed name is special enough that it will
> > be easy to know/spot that the assignement is hidden.
> > 
> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > ---
> >  include/linux/slab.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 98e07e9e9e58..b943be0ce626 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -471,6 +471,7 @@ void kfree_sensitive(const void *objp);
> >  size_t __ksize(const void *objp);
> >  
> >  DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
> > +#define auto_kfree __free(kfree) = NULL
> >  DEFINE_FREE(kfree_sensitive, void *, if (_T) kfree_sensitive(_T))
> >  
> >  /**
> 

-- 
Kees Cook

