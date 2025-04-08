Return-Path: <netdev+bounces-180210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529C1A80927
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E582C8862F9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6E326FA69;
	Tue,  8 Apr 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dx5o+E67"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351326FA64;
	Tue,  8 Apr 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115886; cv=none; b=CroSnj4eJrWFhniEqSsHWJ4xK7yf2cMRlb4FEx3OpSctihBKN/J/+zF6+X3fv/mh/Gduo83F7ThBOLSBH5CBUqNKrWnYo9AkM6LlwgJmqu4EmVA049B5FBbCfMZrlE/rt7utgKGkw9z6zNvUrS6tj9Ws9zMd+I7N79suO9vRixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115886; c=relaxed/simple;
	bh=z/GKk3QTImBW6sMrjdB7W8fFwYBwuzCaGUKKAyo3me4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpUQ0awZlJ2q6ckTpjGT716kJb0mGGljHc5rr/1xm0Zu7GzXCujSvV2BNKAUKIT5VkYxQaVfAd6bslQpH9BEXBt0/WaZmMcMXgoM4/j11XUqnVKFC/yDj7cDEisU0z60Kp41eJ2nHLcJO6/8k/cjeDSJ8HYGE0taz9t2N5jhZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dx5o+E67; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DFWqLG2h2rLfbozj6p24/7qA3jpQNmqKa5Nb0/giNDs=; b=dx5o+E67vHR2d7gcrynb8pq6Pv
	5lr2iNRJaNnr0H2SfmHgSOi4ae6IhhYjJk7SzDOo01O/zs8BhvQbqYx+INPR4A/8+oCK0a0hYcn0Z
	mmNrwocvgW10CwHNJFibZQqaJrr6QAaXNwAYzOUb/a5scP6s4WHrnTdQijO/J/P/4h9M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u28DD-008O3K-7F; Tue, 08 Apr 2025 14:37:55 +0200
Date: Tue, 8 Apr 2025 14:37:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] net: dlink: add support for reporting stats
 via `ethtool -S` and `ip -s -s link show`
Message-ID: <dc15f02e-8411-4f22-b502-fad2cad1870f@lunn.ch>
References: <20250407134930.124307-1-yyyynoom@gmail.com>
 <86ac7c66-66da-458f-960a-3b27ba5e893f@lunn.ch>
 <Z_RYc2R_Qf0xCaLv@mythos-cloud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_RYc2R_Qf0xCaLv@mythos-cloud>

On Tue, Apr 08, 2025 at 07:57:55AM +0900, Moon Yeounsu wrote:
> On Mon, Apr 07, 2025 at 10:48:01PM +0200, Andrew Lunn wrote:
> > When i see a list like this, it makes me think this should be broken
> > up into multiple patches. Ideally you want lots of simple patches
> > which are obviously correct.
> 
> Would it be appropriate to split this into a patchset, then?
> To be honest, this is my first time creating a patchset, so
> I'm not entirely sure how to divide it properly.
> 
> For now, I'm thinking of splitting it as follows:
> 	1. stat definitions and declarations
> 	2. preprocessor directives (`#ifdef`)
> 	3. `spin_[un]lock_irq()` related changes
> 	4. `get_stats()` implementation
> 	5. `ethtool_ops` implementation
> 
> Is it okay to resend the v7 patchset split as above?

You trimmed too much context, you took away the list, so it is hard
for me to reply. Trimming is good, but thing about what is needed for
the conversation.

One obvious patch is to remove the #ifdef about MMIO. That is one
logical thing.

If the spin_[un]lock_irq() is about existing code, yes that could be a
patch. Does it make sense on its own?

1, 4, and 5 probably go together, since they are one logical thing.

Since you are new, it is worth spending some time reading other
patches on the mailing list and the review comments they get. You can
learn a lot that way.

	Andrew

