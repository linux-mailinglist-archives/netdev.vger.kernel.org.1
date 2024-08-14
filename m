Return-Path: <netdev+bounces-118529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0356951DE5
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FAAAB268F9
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A51B3F19;
	Wed, 14 Aug 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI1WLonD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB41B375A
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647364; cv=none; b=RtMtwM8kHkj/YVhopFsqQSyL7EK8RRgD83z6ZfPVbRPjBCoreMMSxw0lpU8tDByVdxA62He9ifNBoxLEjvMz+f9jqcbI4tvsmO29e9RjZh/vgGYaRaUsHKqT23tpDnNg5YuLqL60MP6wn/HllmNig61O6RgWU6PUiBNB1ecGbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647364; c=relaxed/simple;
	bh=qT8n/Pny5uHvN1uA4MclRjbw3pglqGOThX7mh56zI6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8WPBK0pvB1DltcguuD6+5hja4xnfOfQIrfaA1+sEu08W5raNJTJaRf6cmTKvHHp1poC3E1wDuo7m7OVbOc9py/sW4OMzHtmD8Zt4xjHVJrOANAOXWYD2WpUS8Z9Hd9fGlLS/BDSW0smileMiXiRMZpnKaLBceUkhMl/PHBLC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI1WLonD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B1FC116B1;
	Wed, 14 Aug 2024 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723647364;
	bh=qT8n/Pny5uHvN1uA4MclRjbw3pglqGOThX7mh56zI6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QI1WLonDLeUY/xDZJHSztHWtSMdoDuoHjmsv3oP7wvMcgmmREsfWX8DgYXjGEjrzT
	 oXUf+rQiGOYT/lSPTLSsy2p3IlzcepBpNPrqMfaRX6P4VIfN47pGBEgToTtMdufESB
	 BtGZiXJy374FqNotHdFIejaxkPOEFriJVZ93+iOLqNbZTDtG7WMK2GkGEIzPlpefmn
	 FENWmqHqT40K0g7sFa6RG53DkqeKqrUtOok2pA1CA3zCj3YnG2fcCxhyPzFSGBjErI
	 179AQ7jyw7B6g5TTNV9tKc0CWRRjX60tpbA1IsdLSF5cn0iZwreWAbhECQDRCJmWef
	 9TlvLjpHZyoFw==
Date: Wed, 14 Aug 2024 07:56:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yonglong Liu <liuyonglong@huawei.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
Message-ID: <20240814075603.05f8b0f5@kernel.org>
In-Reply-To: <cec044dc-504c-47e6-8ffa-58e8c9b42713@huawei.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
	<523894ab-2d38-415f-8306-c0d1abd911ec@huawei.com>
	<20240807072908.1da91994@kernel.org>
	<977c3d82-e2f0-4466-9100-7ea781e91ce1@huawei.com>
	<20240808070511.0befbdde@kernel.org>
	<758b4d47-c980-4f66-b4a4-949c3fc4b040@huawei.com>
	<20240809205717.0c966bad@kernel.org>
	<cec044dc-504c-47e6-8ffa-58e8c9b42713@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 18:09:59 +0800 Yonglong Liu wrote:
> On 2024/8/10 11:57, Jakub Kicinski wrote:
> > On Fri, 9 Aug 2024 14:06:02 +0800 Yonglong Liu wrote:  
> >> [ 7724.272853] hns3 0000:7d:01.0: page_pool_release_retry(): eno1v0
> >> stalled pool shutdown: id 553, 82 inflight 6706 sec (hold netdev: 1855491)  
> > Alright :( You gotta look around for those 82 pages somehow with drgn.
> > bpftrace+kfunc the work that does the periodic print to get the address
> > of the page pool struct and then look around for pages from that pp.. :(  
> 
> I spent some time to learn how to use the drgn, and found those page, 
> but I think those page
> 
> is allocated by the hns3 driver, how to find out who own those page now?

Scan the entire system memory looking for the pointer to this page.
Dump the memory around location which hold that pointer. If you're
lucky the page will be held by an skb, and the memory around it will
look like struct skb_shared_info. If you're less lucky the page is used
by sk_buff for the head and address will not be exact. If you're less
lucky still the page will be directly leaked by the driver, and not
pointed to by anything...

I think the last case is most likely, FWIW.

