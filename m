Return-Path: <netdev+bounces-137205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD629A4CA7
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 11:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728A52858E5
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 09:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753EF1DE4EE;
	Sat, 19 Oct 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/0wf9ED"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402318D64B;
	Sat, 19 Oct 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729330545; cv=none; b=l+5MtcJFZc8gngDcfTFxgcX/FSl6RJA3A/HmOCobt6GAT48YVXu5otiQGSP9CbBnREUKVcBkQup9BUXYiK376d/9nFjFLdWpqcLL0GqGzNNJpc2/xqYSZZ4S0WvDT/IkV9cx6mUs1kv0v5uAmNLxqanwM5JIGKpyzocV0NJefp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729330545; c=relaxed/simple;
	bh=omrmyMvs4J2wamb0uo/g9R8M2pRLvsLgIyu+q4hZwhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuO3mLDa3riClYJ+pqVLb6ZnHrvaqOWaqXBgs7Psj0jxPaJndYQYmSxBY+F6w8BIPfjZqk//i5iGcAOWhmM0DXz2uB5x6OpQean8GHN5KK7J+hgjmeGqDmKmvW1GPzaV8OOcAtz/LTMRqBbCS92Y4wRKoFPHILdroGaIUN0V1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/0wf9ED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0431C4CEC5;
	Sat, 19 Oct 2024 09:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729330544;
	bh=omrmyMvs4J2wamb0uo/g9R8M2pRLvsLgIyu+q4hZwhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/0wf9EDJAN1kYOqI0LnAm0pch20QJOLJm2hj8SrvYDSDBOAuvHxLXjoqFPKJiwOu
	 l/zlYBp0QIdEcXRc41P3F4D8G9Hlo9u/Ayhp/FEoj8zXqI2S/ASHF0PKBEgJvCXvAQ
	 ie92m01/VOOGH5qtHCG70l24WepjRcc97eYEB9CMCjbpCn3N9qVjQnAkBw/7AgNX5k
	 FYfYAqEx62h5l++T/+0pWeuex4nAkX6aInr5RbYVK7JvKOaX7C/Ni7MgjQQzup1KSP
	 k4XthNh9Twg6Fg7kIyqwJW+oHyyiKZCTRLcbTkwoCt8IGlrOIs7hLrAywL/99BDIB3
	 iqn2aiTx4NaDA==
Date: Sat, 19 Oct 2024 10:35:40 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Wang Hai <wanghai38@huawei.com>, justin.chen@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, zhangxiaoxu5@huawei.com,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: bcmasp: fix potential memory leak in
 bcmasp_xmit()
Message-ID: <20241019093540.GU1697@kernel.org>
References: <20241015143424.71543-1-wanghai38@huawei.com>
 <20241017135417.GM1697@kernel.org>
 <d496a4dd-14be-428d-853f-785cf6200360@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d496a4dd-14be-428d-853f-785cf6200360@broadcom.com>

On Fri, Oct 18, 2024 at 11:18:51AM -0700, Florian Fainelli wrote:
> 
> 
> On 10/17/2024 6:54 AM, Simon Horman wrote:
> > On Tue, Oct 15, 2024 at 10:34:24PM +0800, Wang Hai wrote:
> > > The bcmasp_xmit() returns NETDEV_TX_OK without freeing skb
> > > in case of mapping fails, add dev_consume_skb_any() to fix it.
> > > 
> > > Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> > > Signed-off-by: Wang Hai <wanghai38@huawei.com>
> > 
> > There seems to be some confusion over in the thread for v1 of this patchset.
> > Perhaps relating to several similar patches being in-flight at the same
> > time.
> > 
> > 1. Changes were requested by Florian
> > 2. Jakub confirmed this concern
> > 3. Florian Acked v1 patch
> > 4. The bot sent a notificaiton that v1 had been applied
> > 
> > But v1 is not in net-next.
> > And I assume that 3 was intended for v2.
> > 
> >  From my point of view v2 addresses the concerns raised by Florian wrt v1.
> > And, moreover, I agree this fix is correct.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > v2 is marked as Changes Requested in patchwork.
> > But I suspect that is due to confusion around v1 as summarised above.
> > So I am (hopefully) moving it back to Under Review.
> > 
> 
> v1 was applied already, which, per the discussion on the systemport driver
> appears to be the correct way to go about:
> 
> https://git.kernel.org/netdev/net/c/fed07d3eb8a8

Thanks, it seems that it is me who was confused.

-- 
pw-bot: not-applicable

