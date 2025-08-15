Return-Path: <netdev+bounces-214089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3993DB28354
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7081BC7B4C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 15:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72A2308F1C;
	Fri, 15 Aug 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENNzS6KE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863E2FD7AB;
	Fri, 15 Aug 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273305; cv=none; b=PZjxHa+L0JUgcR1UNzVmn6VUp5TOlTSp7ZeBZuQmQUngCYrhVD5ynh+4B+pp1H6rAb3usfJq6nI60mXGKkSyb5/gXFdZxe2TVUNz92v91dQyuH9sWDKIzK/FnMDuWD85eJErFZChfF8s5lZ1pOUWZ2cklHgj5HiiUKcGLDhNA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273305; c=relaxed/simple;
	bh=x7aU1I8M6iwiC2l3589pCAl472y6tYetQV/dG/yANxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW0gDzz3aNXDbAHs5TKvd494Hob0xgFzAzaXcUuV9/Bo3Qx41pCDkDyLBODhb7sNS7JjE2UBFqZVih5VzbGh5yx2BR8GTZNDaPd5pjnOqiYDAfDLtdPa21lRlXm12BAmt03+vnd9tfjmeLY4Rdu+VXCHcAK0PhAXQj/QoFk5pA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENNzS6KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA65EC4CEEB;
	Fri, 15 Aug 2025 15:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755273305;
	bh=x7aU1I8M6iwiC2l3589pCAl472y6tYetQV/dG/yANxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ENNzS6KE3FnH3ZVtO/3/oxssNha5TXvty4iwSKqL+/YA5uilo92fJUK2dGovY1hBd
	 pQVQtvc1Q8L2BvRjn68+RiB/ZGS3H19n12a28UbeJRF328PqWz7CM3Z+xzb79iLqch
	 66R+10Dnjb0mcjQMnKsnr+NFB0XVgKCLmCW2xjGjidI4Y0Tk821wLEgp15yy2YeehM
	 7WpuUrPLxk9MxqHDN9tkwPaReIy6Rv05Z8GaRMB9BrzOnaZhxxXD+ts+KjhO/G1JX6
	 NhxqYxWkYou16mzCLzjdAP90DYumqrcFdMxeK6rGCRLIXCeukPl704D0DRzwXIz1bU
	 pc/f9MorQKd7g==
Date: Fri, 15 Aug 2025 08:55:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, eperezma@redhat.com, lei19.wang@samsung.com,
 linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
Message-ID: <20250815085503.3034e391@kernel.org>
In-Reply-To: <20250815060615.4162-1-junnan01.wu@samsung.com>
References: <CACGkMEtakEiHbrcAqF+TMU0jWgYOxTcDYpuELG+1p9d85MSN0w@mail.gmail.com>
	<CGME20250815060604epcas5p3a6856bcd64ee4ed80abb43b09aab8a42@epcas5p3.samsung.com>
	<20250815060615.4162-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 14:06:15 +0800 Junnan Wu wrote:
> On Fri, 15 Aug 2025 13:38:21 +0800 Jason Wang <jasowang@redhat.com> wrote
> > On Fri, Aug 15, 2025 at 10:24 AM Junnan Wu <junnan01.wu@samsung.com> wrote:  
> > > Sorry, I basically mean that the tx napi which caused by
> > > userspace will not be scheduled during suspend, others can not be
> > > guaranteed, such as unfinished packets already in tx vq etc.
> > >
> > > But after this patch, once `virtnet_close` completes,
> > > both tx and rq napi will be disabled which guarantee their napi
> > > will not be scheduled in future. And the tx state will be set to
> > > "__QUEUE_STATE_DRV_XOFF" correctly in `netif_device_detach`.  
> > 
> > Ok, so the commit mentioned by fix tag is incorrect.  
> 
> Yes, you are right. The commit of this fix tag is the first commit I
> found which add function `virtnet_poll_cleantx`. Actually, we are not
> sure whether this issue appears after this commit.
> 
> In our side, this issue is found by chance in version 5.15.
> 
> It's hard to find the key commit which cause this issue
> for reason that the reproduction of this scenario is too complex.

I think the problem needs to be more clearly understood, and then it
will be easier to find the fixes tag. At the face of it the patch
makes it look like close() doesn't reliably stop the device, which
is highly odd.

