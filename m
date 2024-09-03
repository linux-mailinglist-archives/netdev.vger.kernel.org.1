Return-Path: <netdev+bounces-124640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB8896A4D5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4171C1F214E9
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FC818BB9F;
	Tue,  3 Sep 2024 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6JoMw6av"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D921E492
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382193; cv=none; b=jWsu9DpKCHFMMu4sVVP2FRDOFS1zYclzpK+N+nDRt10nHhh4PHc0OkSzAJbO6+PfuWAFnt/siUsta6gjun88e6ELxzlxZ+kt+lyIrImUn7Q+X90Sno1TK85f9HFqzmOu1o2cJIxWS6DoTh/jUwbxf5E+hANKDPdvyw4zvYo8//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382193; c=relaxed/simple;
	bh=ozZqRnpridoQS306kfAzBljpL2+zfI0672SvequwEEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjMYKIK6FhuiPZT94luUBcp5Yugmj8l09q1lkuz2HspismG4lG6u2uB4YpbvN5HO5RywpfcVqZYATtumgPA0grzvFLAla9X1o/QgofhKT30aMQ2KxBY+W5dmpRIe+PBd32VJS1xrGGVdaw+nZnWThHn+YUBYgA+4pr2XG1+aUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6JoMw6av; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3KBdxxJGfDHT+ZsX7lsmaHFN11MUP0q9mNOzvT33q7A=; b=6JoMw6aviMYKU7HqXk8exNlZro
	nqw3+22UGi5Jerd2WeXvIhsEFdj2no72cAY06r0UnEVVv7nuzemysNEPkznlyv6igwVAjhE7FHEYM
	uTm/2wPwaMl1eyH5YRYyblPwBMOZOw9HBB1nJLhkNSgEO49L9HzdN9mWP98k2gvRYr2Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slWio-006S5l-Rz; Tue, 03 Sep 2024 18:49:38 +0200
Date: Tue, 3 Sep 2024 18:49:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v1 net-next] e1000e: Remove duplicated writel() in
 e1000_configure_tx/rx()
Message-ID: <3ef52bb5-3289-416a-81b6-4064c49960c8@lunn.ch>
References: <87af1b9e-21c3-4c22-861a-b917b5cd82c2@lunn.ch>
 <20240903104642.75303-1-takamitz@amazon.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903104642.75303-1-takamitz@amazon.co.jp>

On Tue, Sep 03, 2024 at 07:46:42PM +0900, Takamitsu Iwai wrote:
> > Did the same sequence of read/writes happen before 0845d45e900c? Or
> > did 0845d45e900c add additional writes, not just move them around?
> 
> The sequence of read/writes happened before 0845d45e900c because the similar
> writel() exists in ew32() above the writel() moved by 0845d45e900c.
> 
> The commit 0845d45e900c moved writel() in e1000_clean_tx/rx_ring() to
> e1000_configure_tx/rx() to avoid null pointer dereference. But since the same
> writel() exists in e1000_configure_tx/rx(), we just needed to remove writel()
> from e1000_clean_rx/tx_ring().

So you have confirmed with the datsheet that the write is not needed?

As i said, this is a hardware register, not memory. Writes are not
always idempotent. It might be necessary to write it twice.

	Andrew

