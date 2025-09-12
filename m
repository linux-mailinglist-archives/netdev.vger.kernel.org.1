Return-Path: <netdev+bounces-222631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CEFB551E2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B581CBA1D5A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2205C3126C8;
	Fri, 12 Sep 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5PCu91a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6149311C20;
	Fri, 12 Sep 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687724; cv=none; b=EuVeYU8UaiJNsYgFII+Qu6OHrpiNu0sDwUkfngAHSa073XctZVgouRtUtViQNb1MgS1jh3AnmrPkF15LsJsD7pCtY3xAdwLTHTpeksMY2QX4gay5G3sqX+UoYn/kCs+srV/jhBcdtW2dg7RZCuStd0Drgkz9lfGYex4HkKfb4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687724; c=relaxed/simple;
	bh=g8zBXWhLOQ8QclhPPIH4f4LSDxcnM1YQ42JzlNbk82w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZqoutOT5HgI4v8F7cYns36Xttmz2QxpjdrTMDzyBq5eHzXKAta9MAkB+jBZzZKw0yo9PDxKLPGZdVsz/irr3puMIpsEnAPD3FasO2k+MFijgK2GOHDcmyZPMLddx+zt6qjoL3mR4fh2Vh0Uu/PM1GEnKxkvnMxdWj3GawHcgA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5PCu91a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A75C4CEF5;
	Fri, 12 Sep 2025 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757687723;
	bh=g8zBXWhLOQ8QclhPPIH4f4LSDxcnM1YQ42JzlNbk82w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5PCu91aUshZBhMHeskmm/h12H3VgPmTEpTrvd/LQh5TG794fz36sYpls5TjfDQ65
	 kuanw3yQ5wFVMeYzURenOj0LH5MPg1nuSqAMzN+/I983P1xB19fHwxX+ODRa6EFrgB
	 gpV6ixRdBfCo/iHFOj/zDbNLOHmTq4MeaWscRFc53r30xzla9uVAUcXj7kgKiKmrUy
	 Z4upwfMkGpoJu+9zqOR0sJjtO8eJvP3iHl1YRMsUpd/OPEMZ7xtCavmwWsjeDdLf6B
	 M9rkFXtc8m04KFkL8/fNFc4QbwocWIDiA2o4911VWlWtG0+HGjRwBdANjHLJKifbNK
	 BB1Pai+/Dnb7g==
Date: Fri, 12 Sep 2025 07:35:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Yeounsu Moon" <yyyynoom@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dlink: count dropped packets on skb
 allocation failure
Message-ID: <20250912073522.26c1b04a@kernel.org>
In-Reply-To: <DCQQIQ5STYSJ.1X531TK8K9OTS@gmail.com>
References: <20250910054836.6599-2-yyyynoom@gmail.com>
	<20250911170815.006b3a31@kernel.org>
	<DCQQIQ5STYSJ.1X531TK8K9OTS@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 19:03:46 +0900 Yeounsu Moon wrote:
> > I'm not sure that failing to allocate a buffer results in dropping
> > one packet in this driver. The statistics have specific meaning, if
> > you're just trying to use dropped to mean "buffer allocation failures"
> > that's not allowed. If I'm misreading the code please explain in more
> > detail in the commit message and repost.
> 
> I think you understand the code better than I do.
> Your insights are always surprising to me.
> 
> I believed that when `netdev_alloc_skb()` fails, it leads to dropping packets.
> I also found many cases where `rx_dropped` was incremented when
> `netdev_alloc_skb()` failed.
> 
> However, I'm not entirely sure whether such a failure actually results
> in a misisng packet. I'll resend the patch after verifying whether the packet
> is really dropped.

There's a ring of outstanding Rx buffers. If the ring becomes
completely empty we'll start dropping. But that's not the same
as one allocation failure == one packet drop.

