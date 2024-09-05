Return-Path: <netdev+bounces-125342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315DD96CC68
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D8A1C22338
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA3946F;
	Thu,  5 Sep 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUJifQjk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5BF2107
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725501057; cv=none; b=dVRkKgcAqkFs3+CXgdNJO3/77gbBSFE7V59+mlAmXcakNMC/n0sskwRNOa1SkPdzfMqqWhymrjLI66rTfGB4j8XLWPWrweTiAonnNzwXqxWdFUXYJT0eT+cPJkBA8srkKHkxm7gbnLZ9za/r9fIWPxxjS1hFda3CF+GiCMY3pkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725501057; c=relaxed/simple;
	bh=DmkxDL3Ob8eDhnMf65gFHtYkU//RrLDV71pjWy+c74U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkRQhjmcUpI661yAT5gr5ekljzzZgKl1AFH0MbkAI4FcSu5ul+DvKSQf53vLPhE9LG2zlkaPWhWTma08ftqrokAyemdQnzy8gK9SBhIU4t40uvRnbkiAP5KLOOU98IS2Yy6kzdTN0zopSgtbNi+Okp18BSEHDBefyBAY6G1+FCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUJifQjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB6DC4CEC2;
	Thu,  5 Sep 2024 01:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725501056;
	bh=DmkxDL3Ob8eDhnMf65gFHtYkU//RrLDV71pjWy+c74U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IUJifQjk7jLuYNq/qyOojPq+Xo0Q+xOprZjZgphaP6Ju2lyeWbdYOQKy9GGO022IY
	 vyVCbO8gnoIRTfC5YOhnq/zBUEpUeXZA55OSPrJgMoWq4T2js/b+oJRi0xJ30suGbn
	 o5ivfc3Gl6sI/9cB+t0JT9f1qR1Lvm8WWXrzcgRI/syrZit8mFJuWrJPrgVI9NqJIM
	 xStKmfGqMpDqhZe2MaCNGsXtQ3XfxZal43lBLwV2OHxDPP9pRd9yGsjVesDEQMAdGT
	 Bfoa4qSYZE1fD1v297njT691hRrmE1vU8cO+Y2ttv5ZOWEHZ9e4nVPAYWP3V9ghv8R
	 jR5h9bcTKsqsQ==
Message-ID: <3aaa7117-ded8-4d3d-acdc-82a1e9fb73b8@kernel.org>
Date: Wed, 4 Sep 2024 19:50:55 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
To: Guillaume Nault <gnault@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Martin Varghese <martin.varghese@nokia.com>,
 Willem de Bruijn <willemb@google.com>
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
 <20240903113402.41d19129@kernel.org> <ZthSuJWkCn+7na9k@debian>
 <20240904075732.697226a0@kernel.org> <Ztie4AoXc9PhLi5w@debian>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <Ztie4AoXc9PhLi5w@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 11:54 AM, Guillaume Nault wrote:
> [Adding David Ahern for the vrf/dstats discussion]
> 
> On Wed, Sep 04, 2024 at 07:57:32AM -0700, Jakub Kicinski wrote:
>> On Wed, 4 Sep 2024 14:29:44 +0200 Guillaume Nault wrote:
>>>> The driver already uses struct pcpu_sw_netstats, would it make sense to
>>>> bump it up to struct pcpu_dstats and have per CPU rx drops as well?
>>>
>>> Long term, I was considering moving bareudp to use dev->tstats for
>>> packets/bytes and dev->core_stats for drops. It looks like dev->dstats
>>> is only used for VRF, so I didn't consider it.
>>
>> Right, d stands for dummy so I guess they also were used by dummy
>> at some stage? Mostly I think it's a matter of the other stats being
>> less recent.
> 
> Looks like dummy had its own dstats, yes. But those dstats were really
> like the current lstats (packets and bytes counters, nothing for
> drops). Dummy was later converted to lstats by commit 4a43b1f96b1d
> ("net: dummy: use standard dev_lstats_add() and dev_lstats_read()").
> 
> The dstats we have now really come from vrf (different counters for tx
> and rx and counters for packet drops), which had its own implementation
> at that time.
> 
> My understanding is that vrf implemented its own dstats in order to
> have per-cpu counters for regular bytes/packets counters and also for
> packet drops.

VRF was following other per-cpu counters that existed in 2015-2016
timeframe.

I have no preference on the naming; just wanted per-cpu counters.

