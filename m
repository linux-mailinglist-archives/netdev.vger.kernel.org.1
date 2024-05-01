Return-Path: <netdev+bounces-92834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA378B9095
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 22:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018681F22065
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 20:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE2F1635C3;
	Wed,  1 May 2024 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pTon/o/q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D91635A1
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594900; cv=none; b=efdw71hGhbyr1KCGG8u8Re/vd+iTW8zyva2+8arVCAnJi4S0pOBhzzylhsdJU922dIL1Dghgtuxeei8NxUePgcNZR10cQkZFRwuuoWTR7swzuvVgUH4OFpm4CGS/Bc0grE+b2n1n6p2p2E51dbQe2gTSYZ7Hpp6FKVugLtYh218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594900; c=relaxed/simple;
	bh=nVm3MAs99h3LhfW2IB67GtdjkiBjwcIApKzdWffvAPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djjfk2UOKqAbz2R9qNQGoGxStfGJpvU0xFnjtUVzkIKRVzm2DUOPz0sdLiPZ7YH3fpsZT0Mamab7vjFnTk3LucpE1beG0FnQpY4LVfC/Z/wjygVBXBVOFyyeEDZZTYw7Jh1VMX97FBFFfEt/3uNvs6mNa4ZP8gZ2u1kkscYCVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pTon/o/q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ihICdidorLjGb+MMjADlFOgRqjj/MpogEBklpNil6Eo=; b=pTon/o/qUt8knMtpBgFanIR0Oj
	Q30xNe75oXMtb7fykWRJh3dqaAD7bQy9FYPzTFBLyqtuyFSxf1fCOGt5rJ9HJiXmUMZ/9FvrK4s4b
	3OVFSQ0fgVpUaa6zBytFyGQYp37zJWaA9sZ/13tfOSZMfEXx8XJsFU3J4h53BJ9mEbt8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s2GSI-00ES3f-1L; Wed, 01 May 2024 22:21:30 +0200
Date: Wed, 1 May 2024 22:21:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] octeontx2-pf: Treat truncation of IRQ name as
 an error
Message-ID: <aa0246ef-5696-42ea-9f00-4815d268abb7@lunn.ch>
References: <20240501-octeon2-pf-irq_name-truncation-v1-1-5fbd7f9bb305@kernel.org>
 <e2578f7a-7020-4ae4-94d7-69e828a523d5@lunn.ch>
 <20240501201146.GM516117@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501201146.GM516117@kernel.org>

On Wed, May 01, 2024 at 09:11:46PM +0100, Simon Horman wrote:
> On Wed, May 01, 2024 at 09:46:15PM +0200, Andrew Lunn wrote:
> > On Wed, May 01, 2024 at 07:27:09PM +0100, Simon Horman wrote:
> > > According to GCC, the constriction of irq_name in otx2_open()
> > > may, theoretically, be truncated.
> > > 
> > > This patch takes the approach of treating such a situation as an error
> > > which it detects by making use of the return value of snprintf, which is
> > > the total number of bytes, including the trailing '\0', that would have
> > > been written.
> > > +		name_len = snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d",
> > > +				    pf->netdev->name, qidx);
> > > +		if (name_len >= NAME_SIZE) {
> > 
> > You say name_len includes the trailing \0. So you should be able to
> > get NAME_SIZE bytes into an NAME_SIZE length array? So i think this
> > can be >, not >= ?
> 
> Sorry, I misspoke.
> name_len excludes the trailing \0.

The man page say:

       Upon successful return, these functions return the number of characters
       printed (excluding the null byte used to end output to strings).

       The  functions  snprintf()  and vsnprintf() do not write more than size
       bytes (including the terminating null byte ('\0')).  If the output  was
       truncated  due  to  this  limit, then the return value is the number of
       characters (excluding the terminating null byte) which would have  been
       written  to the final string if enough space had been available.  Thus,
       a return value of size or more means that  the  output  was  truncated.
       (See also below under NOTES.)

Assuming the kernel snprintf() follows this, your condition is
correct. So once the commit message is corrected, please add:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

