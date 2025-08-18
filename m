Return-Path: <netdev+bounces-214660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49CB2ACF3
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD2620810F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B37275AF5;
	Mon, 18 Aug 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5Gcr2Wa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB2274FDB;
	Mon, 18 Aug 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531559; cv=none; b=YX5+2iLmHFw7Jtb+e3exgqjYVv9SbcBdtmPY2sS2kXDAkj8RWXHCDL//WELs+DLSAhDYkujzROEBqHh57b73pttHhckatzW+pU+CcndaLBNWH7kAKqfkjzRObbYeR9GXjn7WGdkTNLI2Cr2jyLVSMpVJzL+8ET3VTkEphTG9kQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531559; c=relaxed/simple;
	bh=uo+eilYO4oF8TuPssFwLv6m+/cY9ysnICDRqi7G/yho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwyHrY/jVNK5W6YCtCaFiBmmQ+iL+w5Gbm+4DeOSJRar+PNmch8qvBcRsWRcajDz0zE+A/0biYFzpeE6+KJCf0Ok4KPSMwBWfUCnHwC4YUWOLwnS3UkbdJT1DTZkRJnL2+KjzYTZrZ6nvZkxVgKtadDdh3aDSVL2Emiq0rSpji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5Gcr2Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233F2C4CEEB;
	Mon, 18 Aug 2025 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755531558;
	bh=uo+eilYO4oF8TuPssFwLv6m+/cY9ysnICDRqi7G/yho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r5Gcr2WaCtdIunh9lUs1z3HPI5LuKTQNsOIok0BMFOaE4QoGK3kk4AemMmHu+vllA
	 2+y75tx3aD+iDbK3Op/fcdPe6viltoWZiJlxMOM5zJaYOSBBeKaz3qjTEiZTi0meRO
	 GnTO1O/boLTpSBwyOYM7vnwcAxlBToC1f4Q7C1eSD8sG6GeQA6/y2PehjHFZCxmdfp
	 VZb0O1EuvpwKmudxQCsEaYT8fYjS2R7U3+00vgOKRGTXvctJVFN/evZYeeAYzucbi5
	 G6eFNjKe2Cdd3aXEUKLDSrU7pkBEfXudFz54Pc8fGDwJKenIyQVKmTOocTY46gxJwA
	 qYTtaLkHcFj2Q==
Date: Mon, 18 Aug 2025 08:39:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 eperezma@redhat.com, jasowang@redhat.com, lei19.wang@samsung.com,
 linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
Message-ID: <20250818083917.435a4263@kernel.org>
In-Reply-To: <20250818011522.1334212-1-junnan01.wu@samsung.com>
References: <20250815085503.3034e391@kernel.org>
	<CGME20250818011515epcas5p21295745d0e831fd988706877d598f913@epcas5p2.samsung.com>
	<20250818011522.1334212-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 09:15:22 +0800 Junnan Wu wrote:
> > > Yes, you are right. The commit of this fix tag is the first commit I
> > > found which add function `virtnet_poll_cleantx`. Actually, we are not
> > > sure whether this issue appears after this commit.
> > > 
> > > In our side, this issue is found by chance in version 5.15.
> > > 
> > > It's hard to find the key commit which cause this issue
> > > for reason that the reproduction of this scenario is too complex.  
> > 
> > I think the problem needs to be more clearly understood, and then it
> > will be easier to find the fixes tag. At the face of it the patch
> > makes it look like close() doesn't reliably stop the device, which
> > is highly odd.  
> 
> Yes, you are right. It is really strange that `close()` acts like
> that, because current order has worked for long time. But panic call
> stack in our env shows that the function `virtnet_close` and
> `netif_device_detach` should have a correct execution order. And it
> needs more time to find the fixes tag. I wonder that is it must have
> fixes tag to merge?
> 
> By the way, you mentioned that "the problem need to be more clearly
> understood", did you mean the descriptions and sequences in commit
> message are not easy to understand? Do you have some suggestions
> about this?

Perhaps Jason gets your explanation and will correct me, but to me it
seems like the fix is based on trial and error rather than clear
understanding of the problem. If you understood the problem clearly
you should be able to find the Fixes tag without a problem..

