Return-Path: <netdev+bounces-144947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5842E9C8D85
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4D128394C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8F9139CFF;
	Thu, 14 Nov 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOVs1XoT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F23C466;
	Thu, 14 Nov 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596556; cv=none; b=Q73jbEdNguIkkTspYd13/+sPB9xlpOli5GBlaGtrIcsIt7lZQNCjRrgpNFh2DJCKFIyL+bZsP6r35QtXu+Xh0AO5ZX8GxmkQ6casn22K2jHfZa97/PSZK/0TrRuDMC5XNBrygD+c4oB7KFyD15k/fLzI+9pM3aP0OVXqUMEIvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596556; c=relaxed/simple;
	bh=dN4tvL3q9pcjFqSpwP8uKkrWWNaEeL9R+qbXlxvJ5G8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ni4JPW9KBwbpQfZKSAHCt/+FJlgNTELhJ5cCfihUIrlVa4vwPQJramQ/zKEw6RffCnRhBGtm4LRbjkmR8brXssfrWB2jwNj4H26N+21iDdtzkVdhYHAeVKUbGAhpIkm60sNeUkuMD3NiROIlMNyF+Qyy//CBnWYTkCcOCOnyPc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOVs1XoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2D3C4CECD;
	Thu, 14 Nov 2024 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731596556;
	bh=dN4tvL3q9pcjFqSpwP8uKkrWWNaEeL9R+qbXlxvJ5G8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WOVs1XoTZNNbTwcON3ExJl0NUWwZHgdMAROCIprysZMcxVLF215tsGcnP13WdCHxx
	 +2f+9wr+kfk5dYY/V1gIGg7Db6voSlLXymnJ0YkUtFoo6OIOzph/hO4HNjHswqksBK
	 xYg88qZHfVFVxv758KXVCys0hIsRuq4Q18inblgZqFixbNx7hD4h+OOntrpvUvdnab
	 WJRYGmkcKrBbF/iTfd5XpEgrZJqFtvxR6t+nDg3KxTSTXEBJ/nCGhTwkhoMcKy+azo
	 Rpo/65vWkT2H3qpJD8krVr6LESHH3NTB+NkGYmlw5RojqOXtenhaPjQIVbjC2VACoX
	 o71rNQakFzwTg==
Date: Thu, 14 Nov 2024 07:02:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Jian Zhang
 <zhangjian.3032@bytedance.com>, netdev@vger.kernel.org,
 openbmc@lists.ozlabs.org, Matt Johnston <matt@codeconstruct.com.au>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] mctp i2c: notify user space on TX failure
Message-ID: <20241114070235.79f9a429@kernel.org>
In-Reply-To: <42761fa6276dcfc64f961d25ff7a46b764d35851.camel@codeconstruct.com.au>
References: <20241108094206.2808293-1-zhangjian.3032@bytedance.com>
	<20241113190920.0ceaddf2@kernel.org>
	<da9b94909dcda3f0f7e48865e63d118c3be09a8d.camel@codeconstruct.com.au>
	<20241113191909.10cf495e@kernel.org>
	<42761fa6276dcfc64f961d25ff7a46b764d35851.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 14:48:57 +0800 Jeremy Kerr wrote:
> > routing isn't really my forte, TBH, what eats the error so that it
> > doesn't come out of mctp_local_output() ? Do you use qdiscs on top
> > of the MCTP devices?  
> 
> There are no qdiscs involved at this stage, as we need to preserve
> packet ordering in most cases. The route output functions will end up
> in a dev_queue_xmit, so any tx error would have been decoupled from the
> route output at that stage.

Ah, it's the driver eating the errors, it puts the packet on a local
queue and returns OK no matter what. The I2C transfer happens from 
a thread.

I wonder if there is precedent, let's ask CAN experts.

Mark, MCTP would like to report errors from the drivers all the way 
to the socket. Do CAN drivers do something along these lines?

