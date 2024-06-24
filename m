Return-Path: <netdev+bounces-106159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F82915042
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1DBB22F95
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D719AD9A;
	Mon, 24 Jun 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY8sAUV0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481A19AD93
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240206; cv=none; b=b5Dx1YXQkMkPLY5jbdaPY31XYGlO0prMphJhjC15zzlLBwUffLoyoqM9APuTD//yVHGevkV1QEMhLUfsUeYoBlJ/bdso2qydKyf7bvW7/wOsJIeOQiT2vNAAEeqCOecXD2DulD6jOIHH571p8jXsuFhTyRnIMfQB+abRyScdG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240206; c=relaxed/simple;
	bh=tZS4Xt9VA4rwnw26jxbqUQvk7td3UkUveI1eDvc/lzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5YkZbtpIgBs5z2kiZkmDewE+4eOP8QL6ypL6zCf1/2ON62bSqfUB7IpNc1rQLMv4uzhsACyOlxg6ZokBw4tZshNLLYSlVH4T3yBDxllHcnGh8Tajc5VBtGnQ/ErW4IR6Myfi7zljLvgVhnQVclH3VeMeFKMQRTbJw2r15mz+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY8sAUV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D3AC4AF10;
	Mon, 24 Jun 2024 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719240206;
	bh=tZS4Xt9VA4rwnw26jxbqUQvk7td3UkUveI1eDvc/lzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CY8sAUV07V0zM/bcDbOAq7SX33Von4EcKEfO0LgJk7QrZ2mjTphJkwDsg196ybFBG
	 Wp+nuiM6kk0eaX7Rzpwjn2hYqysh3qQ33ZDLb9h+qlGwyrTLlMHP1+w1pnAPo/CSA8
	 3zSUnNdjC3Tc+S+QZ0t5Em9idfKTaF0XrTqkcQoAtvdgZSh3nESg/IrryGq+zl8pcD
	 tigY5dN8Rz2jIsSvZ5Pq0x1IA8Vp/IqkgRBgR27EXeem9dOM243r4U6NbQpYxSU8R/
	 ssb48JgFSUMY3JTHV3Aiol6TV1U/jOCvgl2wW7wNRzcLo9AIXyaMUPBdQb18NqnaDS
	 tdFPkt0SyK3Pg==
Date: Mon, 24 Jun 2024 07:43:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add helper to wait for
 HW stats to sync
Message-ID: <20240624074325.39c7529e@kernel.org>
In-Reply-To: <6677d0af33d39_33363c294f8@willemb.c.googlers.com.notmuch>
References: <20240620232902.1343834-1-kuba@kernel.org>
	<20240620232902.1343834-3-kuba@kernel.org>
	<6677d0af33d39_33363c294f8@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jun 2024 03:37:19 -0400 Willem de Bruijn wrote:
> > +            else:
> > +                # Assume sync not required, we may use a small (50ms?) sleep
> > +                # regardless if we see flakiness
> > +                self._stats_settle_time = 0  
> 
> Intended to set _stats_settle_time to 0.05 here? Else I don't follow
> the comment

My intuition was that we will need a sleep, but I didn't see failures
in practice, so I removed it and added the comment. I'll just bring
back the sleep.

