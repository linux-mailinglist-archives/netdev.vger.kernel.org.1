Return-Path: <netdev+bounces-176733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0D6A6BBA2
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 14:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2EB4189C8B0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72D521D018;
	Fri, 21 Mar 2025 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5Eb89Ufj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5A1CAA81
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563146; cv=none; b=Ol7ssmdLKlkeOVC0w7D4lOyYL1XwvtxILAUR7iSwS9ea+FDh9Xk351s1o66ZS6wGOZEv1ee8JAS76dQgqy3kQBMUy1Aozons79L4VReg/YSeqmfot5kLnJ+COtLlKCcP24+AVTafxrbjq7D4yoJ+UByMYQ93NVmITXFPNpiuai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563146; c=relaxed/simple;
	bh=pcrmZe9/gRg6TM77YDiMNcIuJFQsFNtQifULH5Cfd18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiQXN8GfLR6l7d8TLYmPnXE2ZrnZ8JqjhNBOZhf3X0tmyTwmCb56W1yPdVska2d8rGfCllT0k05Oubl3aAewBH2E3MuX2MSYLPPlka4HF8ILcI5kudCTxjSWxUZlQfdkBcM11oD/eyjy9aXOJTNEa/TF7XCH/2WUnH8Q+HZgvX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5Eb89Ufj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ylp2ewKTO4Xpw5CgGsFkeUugyN1SmwInETdNUP3OlFo=; b=5Eb89Ufjc7O0i6603/gAlBwYK7
	3lrOjX9J5QY5AI5mXhs7i19wE+EFKElJAHlylikL4HbUKJirdxIlnQUNI+uI0F961lw2bNs9lPcLg
	dRXj1Zd9rj10Z5KXaLL3k0u+B9PChQtqbsIs7XtfEQz7WhZUi+m1zCSImJcJeYSClDqc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvcGz-006Zg0-N4; Fri, 21 Mar 2025 14:18:53 +0100
Date: Fri, 21 Mar 2025 14:18:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, maxime.chevallier@bootlin.com,
	marcin.s.wojtas@gmail.com, linux@armlinux.org.uk,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] net: mvpp2: Prevent parser TCAM memory corruption
Message-ID: <1eac57a5-eae6-4e2b-99d1-2b06c8628b1e@lunn.ch>
References: <20250321090510.2914252-1-tobias@waldekranz.com>
 <3f2f66ae-b1ac-4c87-9215-c1b6949d62c4@lunn.ch>
 <87pliaa73x.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pliaa73x.fsf@waldekranz.com>

On Fri, Mar 21, 2025 at 01:41:38PM +0100, Tobias Waldekranz wrote:
> On fre, mar 21, 2025 at 13:12, Andrew Lunn <andrew@lunn.ch> wrote:
> >> +static int mvpp2_prs_init_from_hw_unlocked(struct mvpp2 *priv,
> >> +					   struct mvpp2_prs_entry *pe, int tid)
> >>  {
> >>  	int i;
> >>  
> >
> > This is called from quite a few places, and the locking is not always
> > obvious. Maybe add
> 
> Agreed, that was why i chose the _unlocked suffix vs. just prefixing
> with _ or something. For sure I can add it, I just want to run something
> by you first:
> 
> Originally, my idea was to just protect mvpp2_prs_init_from_hw() and
> mvpp2_prs_hw_write(). Then I realized that the software shadow of the
> SRAM table must also be protected, which is why locking had to be
> hoisted up to the current scope.
> 
> > __must_hold(&priv->prs_spinlock)
> >
> > so sparse can verify the call paths ?
> 
> So if we add these asserts only to the hardware access leaf functions,
> do we risk inadvertently signaling to future readers that the lock is
> only there to protect the hardware tables?

You can scatter __must_hold() anywhere you want, to indicate the lock
must be held. It has no runtime overhead.

And you can expand the comment where the mutex is defined to say what
it is expected to cover.

FYI: i've never personally used __must_hold(), but i reviewed a patch
recently using it, which made me think it might be useful here. I
don't know if you need additional markup, __acquires() & __releases()
?? You might want to deliberately break the locking and see if sparse
reports it.

	Andrew

