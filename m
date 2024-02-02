Return-Path: <netdev+bounces-68611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6923847650
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAB81F2681F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888F314AD2F;
	Fri,  2 Feb 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOUMOcHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167B1482E3;
	Fri,  2 Feb 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895524; cv=none; b=jRKT5VASU/ZTCwc87vqRxNYDLGotxcx7zNtMSO3RRvUXul6KfWha0oxk3s8iLGItyQ3x4oNqb54Cw8am5+P0h1+MgRqz2LJT7TKYN/M8F6pv7dUdwhB1ECxSfsk97eQ27aLcUTKDg/4RrYsV8PdTXDJUfIa8PCcXifHG8iUbJ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895524; c=relaxed/simple;
	bh=MtA9noOhhDHQujelAYh9x5KIExwAKOsv6PyJ3fv7OXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hg4djwl0Lae1hnXQKIVUKOnxgQmgAqPxP6fKi6kMw2mudA3EWtcflpe5ApU/ssk9Hr4OAkcQ4Wq2EiQqKyEFqdNM9clFEcjXp2OAgV3cis3I38RWfhWgi2TnNWeUWDK9/E3vOanNFSbsOl9Y0EzXI/SecO8Y0oABBJt17hcgcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOUMOcHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9074C433C7;
	Fri,  2 Feb 2024 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706895524;
	bh=MtA9noOhhDHQujelAYh9x5KIExwAKOsv6PyJ3fv7OXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tOUMOcHMkqKvW1YwGGKHj0cRCbyPtjwS7O044Li1EvDSAJG4+iwTOexhBBekUfqIL
	 JuJFsr5TDv9c/mvSEkSjirYXugW4DUcSHNr8dsgt563qpDgGHDw/Dgth/ViXW/duaD
	 +ziv8CuhukYeOBprBIEt12GLz7t1rzOQ6Nev7zOaJgo3OjmNb1gUsm5WaY88zr9NvR
	 xr8Hjhd3SD8G2dI9VtdKSZhmseEjukphr/ThLrQHSyAZ0RKAm4Ng4Ob5rTZHDyajUQ
	 9zzHwkkwQ6U/0qHzJ9S8rpGqaQB9tW6VBU5r6hUolzd1K//AP17TIJd8KABKVjy8/+
	 RFW4rS/Zg1ssA==
Date: Fri, 2 Feb 2024 09:38:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
 <xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240202093843.0e7c29d4@kernel.org>
In-Reply-To: <CH0PR12MB858044D0E5AB3AC651AE0987C9422@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240130142521.18593-1-danielj@nvidia.com>
	<20240130095645-mutt-send-email-mst@kernel.org>
	<CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240130104107-mutt-send-email-mst@kernel.org>
	<CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240130105246-mutt-send-email-mst@kernel.org>
	<CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
	<CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
	<20240201202106.25d6dc93@kernel.org>
	<CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
	<20240202080126.72598eef@kernel.org>
	<CH0PR12MB858044D0E5AB3AC651AE0987C9422@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 16:46:28 +0000 Daniel Jurgens wrote:
> > Daniel, I think this may be a good enough excuse to add per-queue stats to
> > the netdev genl family, if you're up for that. LMK if you want more info,
> > otherwise I guess ethtool -S is fine for now.  
> 
> For now, I would like to go with ethtool -S. But I can take on the
> netdev level as a background task. Are you suggesting adding them to
> rtnl_link_stats64?

More like page pool stats. See d49010adae7376384

