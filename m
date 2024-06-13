Return-Path: <netdev+bounces-103079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC989062AE
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 05:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25589284198
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7152A12F382;
	Thu, 13 Jun 2024 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS/UsQ6C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1C2F34;
	Thu, 13 Jun 2024 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249676; cv=none; b=iJnacogH5mtKc6N53rftRpdQjLFUU9rr29GcNTnuOipkqXKkaf050Kgjl2XgT7GrbR5g+fa6U1I1Vic/muII/l39sSMZzE2zhKz5pkGPXo5rsVuLVwTj1sGJQWLruiN/0a+eNFaFFDftrPkNfMKPSv+BoJ2ZpZfQaUvFXq+MgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249676; c=relaxed/simple;
	bh=4Ve5J8xmQC5rrlMwUon1nb6lBnwrnLCTLGyBEta2HrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWFreRzTAVHvWnLNJF3wCWydjP9X6Q379uS1dfuCOrkmF4Q94UF8VphFdlUP6kQx8EWQbzG23znWpdGw7OcKmorqfwb9piY9VkXRPuhRNZZQOnLiwCYLffu05mwcJMBxJ0ZF//9p6bmDR0MtNWU1wubV2Q1lOhF6PWLtYVWpH8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS/UsQ6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87C2C2BBFC;
	Thu, 13 Jun 2024 03:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718249675;
	bh=4Ve5J8xmQC5rrlMwUon1nb6lBnwrnLCTLGyBEta2HrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OS/UsQ6CToml9KriUhf1wtmHOJUAlk7nphjjLHfTqvovoprnYjd67way2oo8VpsqM
	 mi84M2yATcZoEK1BGYnU+WO1U1j7KVTuuIRZZRhaoMAfsnH5srrjyz8BXIHtcNgTP+
	 OwJSb89JdaS0OznfrMUQShXYSwePTwngGlyz084onrco6P6T8BmaSSYiK3D3e4q8rI
	 MZITkkA/qT9g2KTFql6jVwOYUyKIabtvW8tAggHatS8kwqjHemOL05yV6txKHbPQxg
	 xMH1Z+wXmD7ba/VUJg/ejzum6pBQFl6J2mMysiCtENFT6Yxx6mLvH0WC/HHGzP7UN5
	 tXEUMNZvyn0ZA==
Date: Wed, 12 Jun 2024 20:34:35 -0700
From: Kees Cook <kees@kernel.org>
To: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"mw@semihalf.com" <mw@semihalf.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v1] net: mvpp2: use slab_build_skb for oversized frames
Message-ID: <202406122033.69D9ABFC24@keescook>
References: <20240611193318.5ed8003a@kernel.org>
 <20240613024900.3842238-1-aryan.srivastava@alliedtelesis.co.nz>
 <202406122003.E02C37ADD1@keescook>
 <6c2592c517878a69d37e1957d9624d83dbc982ab.camel@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c2592c517878a69d37e1957d9624d83dbc982ab.camel@alliedtelesis.co.nz>

On Thu, Jun 13, 2024 at 03:13:34AM +0000, Aryan Srivastava wrote:
> On Wed, 2024-06-12 at 20:05 -0700, Kees Cook wrote:
> > On Thu, Jun 13, 2024 at 02:49:00PM +1200, Aryan Srivastava wrote:
> > > Setting frag_size to 0 to indicate kmalloc has been deprecated,
> > > use slab_build_skb directly.
> > > 
> > > Fixes: ce098da1497c ("skbuff: Introduce slab_build_skb()")
> > > Signed-off-by: Aryan Srivastava
> > > <aryan.srivastava@alliedtelesis.co.nz>
> > > ---
> > > Changes in v1:
> > > - Added Fixes tag
> > 
> > This looks like similar updates like commit 99b415fe8986 ("tg3: Use
> > slab_build_skb() when needed")
> Yeah, I noticed that when I was looking for examples of other "Fixes"
> tags for the "skbuff: Introduce slab_build_skb()" commit. I suspect
> there are many drivers that will need this "fix".

Yeah, at the time the API changes was made it was clear it wasn't easy
to identify which needed it, so the WARN was added along with supporting
the old style via internal fall-back.

-Kees

> > 
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > 
> 

-- 
Kees Cook

