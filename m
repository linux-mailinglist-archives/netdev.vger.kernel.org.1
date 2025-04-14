Return-Path: <netdev+bounces-182380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37428A88992
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5761897361
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272CC284698;
	Mon, 14 Apr 2025 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dx/VuRjp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E7284685;
	Mon, 14 Apr 2025 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651066; cv=none; b=u93ZIC7WfErsmHVNShEN2JEpb4oj9cHLXbXRXpklJnxh3ijO0kuawaKCupf47QkhQHo8xd3R9fG7V7iVXnKsyF3wrqP1PmEwAakVM+x8XUG1yziiYaal6M3UzzckMbOT9WZCBBrirSxQQxyFwYmxBZmzS18kakoVh9Ttrs3IjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651066; c=relaxed/simple;
	bh=rzA20/pIdWBHMGU7xAsPsa+U0QCOSidUUd989Wkkeeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEWzRrB+1Byo7CWF1hkbc/xX/bh8yyykWLOa+rd5TIJvjY3voWsi2a+2crDHWN3Joa4Hg1KCtF/IUB/xmml4i7qymU4/0LebdfYCBcmNb2mOrkUpoB8gA75U96KfVFYZCQ1xtPVY80dwEwfQlGg4/HZmB8pzBQ/r3qmQYiQlx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dx/VuRjp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=IYRKGwR89Rpw68pdLeCst1myOZk4GqPsPOkkIazWR3w=; b=Dx
	/VuRjp0nFQKNbq1x3+XqZofv0ZRl6pr8c0elKq4L5tqkwKQSiOVIkavVio24lxk1k60DTPHSABwJ8
	mWgekEFQAkOwh3KxZqIcUmirU6CVu0e92MYFR/WHbtCvI27sadxWQC7gSaWj3rKB2Y/KmiKMCAeoL
	Jlaa3jt9wRrFnb0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4NRA-009EqC-1B; Mon, 14 Apr 2025 19:17:36 +0200
Date: Mon, 14 Apr 2025 19:17:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"nathan@kernel.org" <nathan@kernel.org>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	"morbo@google.com" <morbo@google.com>,
	"justinstitt@google.com" <justinstitt@google.com>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"horms@kernel.org" <horms@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH v3 1/2] octeontx2-af: correct __iomem
 annotations flagged by Sparse
Message-ID: <e80bd0f7-f38e-4882-aa48-ff98d0fd0101@lunn.ch>
References: <20250311182631.3224812-1-saikrishnag@marvell.com>
 <20250311182631.3224812-2-saikrishnag@marvell.com>
 <7009d4cc-a008-49ea-8f50-1e9aec63b592@lunn.ch>
 <BY3PR18MB4707C3348715B237C0A95C47A0B32@BY3PR18MB4707.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY3PR18MB4707C3348715B237C0A95C47A0B32@BY3PR18MB4707.namprd18.prod.outlook.com>

On Mon, Apr 14, 2025 at 04:38:53PM +0000, Sai Krishna Gajula wrote:
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Wednesday, March 12, 2025 2:52 AM
> > To: Sai Krishna Gajula <saikrishnag@marvell.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> > <gakula@marvell.com>; Linu Cherian <lcherian@marvell.com>; Jerin Jacob
> > <jerinj@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; Subbaraya
> > Sundeep Bhatta <sbhatta@marvell.com>; andrew+netdev@lunn.ch; Bharat
> > Bhushan <bbhushan2@marvell.com>; nathan@kernel.org;
> > ndesaulniers@google.com; morbo@google.com; justinstitt@google.com;
> > llvm@lists.linux.dev; horms@kernel.org; kernel test robot <lkp@intel.com>
> > Subject: Re: [net-next PATCH v3 1/2] octeontx2-af: correct
> > __iomem annotations flagged by Sparse
> > 
> > > if (mbox->mbox. hwbase) > - iounmap(mbox->mbox. hwbase); > +
> > > iounmap((void __iomem *)mbox->mbox. hwbase); This looks wrong. If you
> > > are unmapping it, you must of mapped it somewhere. And that mapping
> > > would of returned an __iomem
> > 
> > >  	if (mbox->mbox.hwbase)
> > > -		iounmap(mbox->mbox.hwbase);
> > > +		iounmap((void __iomem *)mbox->mbox.hwbase);
> > 
> > This looks wrong. If you are unmapping it, you must of mapped it
> > somewhere. And that mapping would of returned an __iomem value. So
> > mbox.hwbase should be an __iomem value and you would not need this
> > cast.

> Yes,  mbox->mbox.hwbase is ioremapped with cache (ioremap_wc), while initialization it is declared as __iomem. But this hwbase is actually a DRAM memory mapped to BAR for better accessibility across the system. Since we use large memcpy (64KB and more) to/from this hwbase, we forced it to use as "void */u64" before exiting with unmap. As this is DRAM memory, memory access will not have side effects. Infact the AI applications also recommended similar mechanism. Please suggest if you have any other view and this can be addressed in some other way.

Please configure your email client to correctly wrap emails.

Did you check the performance of memcpy_fromio()? That is the API you
are supposed to be using with an __iomem. I _think_ memcpy is only
going to work for some architectures and other architectures will give
you problems. That is the whole point of the __iomem, to make sure you
use the correct API which works across architectures.

> > 
> > >  	for (qidx = 0; qidx < pf->qset.cq_cnt; qidx++) {
> > > -		ptr = otx2_get_regaddr(pf, NIX_LF_CQ_OP_INT);
> > > +		ptr = (__force u64 *)otx2_get_regaddr(pf,
> > NIX_LF_CQ_OP_INT);
> > >  		val = otx2_atomic64_add((qidx << 44), ptr);
> > 
> > This also looks questionable. You should be removing casts, not adding them.
> > otx2_get_regaddr() returns an __iomem. So maybe
> > otx2_atomic64_add() is actually broken here?
> Similar to the above case, otx2_atomic64_add is a special case where it uses assembly code as part of definition, hence we had to use typecasting the "ptr". Please suggest if there is any better way.
> 
> static inline u64 otx2_atomic64_add(u64 incr, u64 *ptr)
> {
>         u64 result;
> 

Teach this function to accept an __iomem. Worst case, you remove the
cast here, before going into assembly.

>         __asm__ volatile(".cpu   generic+lse\n"
>                          "ldadd %x[i], %x[r], [%[b]]"
>                          : [r]"=r"(result), "+m"(*ptr)
>                          : [i]"r"(incr), [b]"r"(ptr)
>                          : "memory");

What actually happens if you keep the attribute? My guess is
nothing. These are sparse markups, and gcc/as never seems them.

	Andrew

