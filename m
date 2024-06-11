Return-Path: <netdev+bounces-102417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D359902E09
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 03:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57FE1C219DC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763579475;
	Tue, 11 Jun 2024 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4F2vqYm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C631FA3
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718070307; cv=none; b=IzFrGpKy5CPO7BTN+BDzJjRoYEs8G4satgGOWDLpnQAtJMS+RXOvVq7VNU18JWQr80ZZtZqKfJv/z90Vd/ovX9xXBiNsC2fyXUMPRGs+EOwvkqsgTTeTXqOFM5hbb6wvBxymVn9qFAIU4C7977MbVDWMDV+p0Ufzlc8r1luX25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718070307; c=relaxed/simple;
	bh=PL8O30wqaDPXSI3sRz9e2nqLDQOVP9S8inAYSWqhKts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k06/L+ysBYgl60sN0nkXeK4adFHsM/xgWY+C6WxhwDbcJiv4J7E2aSZ7IHgwQ8cyeu4LRWVAXpHN4mug8lDF0ZvNcDPmRFxC+bJ5Lyc1O4A+NY2wPyym5zkRwPcRZO4zmLcfq1UD6vOjTs6Lqw9szmcKzSPMjLd8iHY2Lwn4Sq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4F2vqYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F866C2BBFC;
	Tue, 11 Jun 2024 01:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718070306;
	bh=PL8O30wqaDPXSI3sRz9e2nqLDQOVP9S8inAYSWqhKts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4F2vqYm36kvYzcng0MMpjSxgeU4nuS3SeoGfU4zfuFPHCa5nfWmzVq5ZgoOY754U
	 tdUpY/yr8dYPgOqYwpmtmCmnTJQ3rMFaj69whKs6FXzyWejHonkqW/4seKuScAuabh
	 +OFQG5tZYB0H2yoX81h7nCNTlhDn96lMtGsDGYdBD3vFJymgPiLs1bKDR1Nnd98vlo
	 kJ75DDEeaJCuq+sNYvIA2vkvPfTsSaxteIDl7QKvl0N6SkX2Ds8ggtsSQite7kf0FM
	 YwzXJITO1l/JNjBgI8kIWQI8lknsf/pCKLKc30I6wKb3JK/xrrqiLbsqaOdLH8aEO7
	 aCHjo1SsT0gCw==
Date: Mon, 10 Jun 2024 18:45:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, pabeni@redhat.com,
 davem@davemloft.net, dsahern@kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 leitao@debian.org, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] net: dqs: introduce NETIF_F_NO_BQL device
 feature
Message-ID: <20240610184505.35006364@kernel.org>
In-Reply-To: <CAL+tcoCGumdRKgd_1bQj1U_sNPsvYmsNOKwSWxazU0FwmeNTwA@mail.gmail.com>
References: <20240609131732.73156-1-kerneljasonxing@gmail.com>
	<CANn89iK+UWubgdKYd3g7Q+UjibDqUD+Lv5kfmEpB+Rc0SxKT6w@mail.gmail.com>
	<CAL+tcoCGumdRKgd_1bQj1U_sNPsvYmsNOKwSWxazU0FwmeNTwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 07:55:55 +0800 Jason Xing wrote:
> > (I think Vladimir was trying to make some room, this was a discussion
> > we had last year)  

s/Vladimir/Olek/ ?

> Thanks for your reminder. When I was trying to introduce one new bit,
> I noticed an overflow warning when compiling.
> 
> > I do not see the reason to report to ethtool the 'nobql bit' :
> > If a driver opts-out, then the bql sysfs files will not be there, user
> > space can see the absence of the files.  
> 
> The reason is that I just followed the comment to force myself to
> report to ethtool. Now I see.
> 
> It seems not that easy to consider all the non-BQL drivers. Let me
> think more about it.

All Eric was saying, AFAIU, is that you can for example add a bit 
in somewhere towards the end of struct nedevice, no need to pack
this info into feature bits.

BTW the Fixes tag is a bit of an exaggeration here. The heuristic in
netdev_uses_bql() is best effort, its fine to miss some devices.

