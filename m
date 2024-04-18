Return-Path: <netdev+bounces-89295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3DB8A9F71
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799A31F22711
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51416F850;
	Thu, 18 Apr 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDYulA2Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774216F851;
	Thu, 18 Apr 2024 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456086; cv=none; b=LlUZHqgacouWsGUzhfM8IkWMVaZOfN1/AzApIp0GxU4lrCMsaEe+J+v9/JyJMTpI0ia3AV0wyRP09Bo8VVRXaT00vrpb24lxCEEmOecovt6urYMtfccE1HmjqoaAVMF+DHzWMSzRpwBZLMgc3VH/Cnvpjy7SeHZc3smP2q+QpOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456086; c=relaxed/simple;
	bh=GxZ0UkuWta5XXukPFexSn1kOrolC+Aw1Ja0CF7m9Z0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCYorq0fwuCqcWUDNuLfXDtjUyQunSEu6rV9z6gfbD/iVOVtalPeMPq3zhYf4yezoneEf/NCZo5k/Vi9+G2yUw83cDx8QICZsE3DP0FAiE4TMAY9U+XNj++RrrNjWHRTerLm2Cbh9EEs2l9hNGkSmy0tKBs9+Mn0zidziLkX/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDYulA2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EECC113CC;
	Thu, 18 Apr 2024 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713456086;
	bh=GxZ0UkuWta5XXukPFexSn1kOrolC+Aw1Ja0CF7m9Z0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pDYulA2ZS1zscGHLBq1orinGWH+j6edm3WuP7nT4Xe/1xOxcEg97MbEf436DClSlC
	 oRO/ZCO4s8dKx7jTi8n04MdQHbfzAWbNfSlyRoIM88govWHsjy8AWiFF+v952bjqb3
	 TAshu9qArXQ1LXtX3xqlyu1TKuOyRhPklz+05vkxLFMa2SHSq5XrrhV8/0MsFsC+7i
	 i67iCIyPxZdQ1MQjSdoVLsDqTCYljRtSwQObcNmrZqPQvCxAop+JeRF7Bh2VqTNTuo
	 tKNoqf+QxiC5XPZ+Xx4FeN+44NpjDRivPBVZYDADV2PDd3b4zfIWnkU+zlDc5M3+uj
	 frKEkxA0qeTqQ==
Date: Thu, 18 Apr 2024 09:01:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Dan Jurgens <danielj@nvidia.com>, Heng Qi <hengqi@linux.alibaba.com>,
 Jason Wang <jasowang@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command
 VQ.
Message-ID: <20240418090124.03be2187@kernel.org>
In-Reply-To: <72f6c8a55adac52ad17dfe11a579b5b3d5dc3cec.camel@redhat.com>
References: <20240416193039.272997-1-danielj@nvidia.com>
	<20240416193039.272997-4-danielj@nvidia.com>
	<CACGkMEsCm3=7FtnsTRx5QJo3ZM0Ko1OEvssWew_tfxm5V=MXvQ@mail.gmail.com>
	<28e45768-5091-484d-b09e-4a63bc72a549@linux.alibaba.com>
	<ad9f7b83e48cfd7f1463d8c728061c30a4509076.camel@redhat.com>
	<CH0PR12MB85802CBD3808B483876F8C77C90E2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<72f6c8a55adac52ad17dfe11a579b5b3d5dc3cec.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 17:48:57 +0200 Paolo Abeni wrote:
> > > Side note: the compiler apparently does not like guard() construct, leading to
> > > new warning, here and in later patches. I'm unsure if the code simplification
> > > is worthy.  
> > 
> > I didn't see any warnings with GCC or clang. This is used other places in the kernel as well.
> > gcc version 13.2.1 20230918 (Red Hat 13.2.1-3) (GCC)
> > clang version 17.0.6 (Fedora 17.0.6-2.fc39)
> >   
> 
> See:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20240416193039.272997-4-danielj@nvidia.com/
> https://netdev.bots.linux.dev/static/nipa/845178/13632442/build_32bit/stderr
> https://netdev.bots.linux.dev/static/nipa/845178/13632442/build_allmodconfig_warn/stderr

These are sparse errors, I think, but I agree that there's little gain
here and clearly a cost of wasted time, since the standard kernel
tooling has not caught with with this ugly invention.

