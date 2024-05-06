Return-Path: <netdev+bounces-93621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CC78BC773
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 08:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108271C209CA
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 06:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37244AEF5;
	Mon,  6 May 2024 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w2TjSS2z"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969DF42ABD
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714976404; cv=none; b=LQM6i0WYot1SD5SBSz7nI7nRJ7iEsHyImfCCoYrtUd7hJfDOprllye3ClNvDpEFH/RqUd9FDqW9NVrAU2rnvnmR31Do6gVj7q+ozj30bqMIzL52ETyBqWEP45ep3gcW+TWwXbp5X08OKAkAbQzaRveWIbaX2xDKlb0kpyY47pKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714976404; c=relaxed/simple;
	bh=AVjbTUGpKRQ6U4ng9sm41977TejPRgiG9hUHDRveGsY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=D6fUVvxG9LWrAXqoK9LzQw9peUt7OCrNVUZROaqVufLAjAEMhbpJitg9lqkuDEKlp4E1RtbMpwUDvm3RKzvSLXswjaV8PiNra47fsOBG8vF4QIG/0OFTlN09XulHSuuEYsIbm8sPdP4NyKx0rgARb7CNqEm6TXBDSsFCqD9aaCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w2TjSS2z; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714976400; h=Message-ID:Subject:Date:From:To;
	bh=ykX1DBvAThRCu1cGX79eKGfjSaN3hhiA4FeO5nFGe9o=;
	b=w2TjSS2zWU1zSWAhWlfNx5+6WY5ImhTRuZCq/6DBSIW6HcPG83mL4XKlD+CeCEXKu3yueDVmPH7Yst3Tkd4IBXED6mqTPHHdy4LsoEEzuNuM3ZoXkWlQ7S5M1pa1DsBBLOEgMkrR5NMb4AbsKruCfRgSkHzDk9HnMhFyIbE87BY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5ufZZc_1714976398;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5ufZZc_1714976398)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 14:19:59 +0800
Message-ID: <1714976172.0470116-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 0/6] Remove RTNL lock protection of CVQ
Date: Mon, 6 May 2024 14:16:12 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <virtualization@lists.linux.dev>,
 <davem@davemloft.net>,
 <edumazet@google.com>,
 <kuba@kernel.org>,
 <pabeni@redhat.com>,
 <jiri@nvidia.com>,
 Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>
References: <20240503202445.1415560-1-danielj@nvidia.com>
In-Reply-To: <20240503202445.1415560-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 3 May 2024 23:24:39 +0300, Daniel Jurgens <danielj@nvidia.com> wrote:
> Currently the buffer used for control VQ commands is protected by the
> RTNL lock. Previously this wasn't a major concern because the control VQ
> was only used during device setup and user interaction. With the recent
> addition of dynamic interrupt moderation the control VQ may be used
> frequently during normal operation.
> 
> This series removes the RNTL lock dependency by introducing a mutex
> to protect the control buffer and writing SGs to the control VQ.
> 

For the series, keep tags:

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Tested-by: Heng Qi <hengqi@linux.alibaba.com>


> v6:
> 	- Rebased over new stats code.
> 	- Added comment to cvq_lock, init the mutex unconditionally,
> 	  and replaced some duplicate code with a goto.
> 	- Fixed minor grammer errors, checkpatch warnings, and clarified
> 	  a comment.
> v5:
> 	- Changed cvq_lock to a mutex.
> 	- Changed dim_lock to mutex, because it's held taking
> 	  the cvq_lock.
> 	- Use spin/mutex_lock/unlock vs guard macros.
> v4:
> 	- Protect dim_enabled with same lock as well intr_coal.
> 	- Rename intr_coal_lock to dim_lock.
> 	- Remove some scoped_guard where the error path doesn't
> 	  have to be in the lock.
> v3:
> 	- Changed type of _offloads to __virtio16 to fix static
> 	  analysis warning.
> 	- Moved a misplaced hunk to the correct patch.
> v2:
> 	- New patch to only process the provided queue in
> 	  virtnet_dim_work
> 	- New patch to lock per queue rx coalescing structure.
> 
> Daniel Jurgens (6):
>   virtio_net: Store RSS setting in virtnet_info
>   virtio_net: Remove command data from control_buf
>   virtio_net: Add a lock for the command VQ.
>   virtio_net: Do DIM update for specified queue only
>   virtio_net: Add a lock for per queue RX coalesce
>   virtio_net: Remove rtnl lock protection of command buffers
> 
>  drivers/net/virtio_net.c | 288 +++++++++++++++++++++++----------------
>  1 file changed, 173 insertions(+), 115 deletions(-)
> 
> -- 
> 2.44.0
> 
> 

