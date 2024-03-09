Return-Path: <netdev+bounces-78896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC4876EFF
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 04:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456712823DD
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 03:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044122E851;
	Sat,  9 Mar 2024 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IARd+tSR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29301DFE8
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 03:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709955816; cv=none; b=ZSBoXgDQgKzbxwn09X2DwcdnBpLVWdpwRVY8UJxsPv38GdVkY7/Bc3YzMrE1ej+h0WUfgAF+HnRPGrcjyh44vr3bALrGc1hHmympopIZ+qpfk+hXy/Qdo3ZuOLimvX3mX+ekLlrJPQdVhKK4LlHq3B3bmXBQ49o+7xksQupgZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709955816; c=relaxed/simple;
	bh=Cy3Zo7p27wOQW/xMawb2c9DGZVH11rCB52Ur2eowbdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVuUdG4k467ehNdqhe4hV3SArYqhT7MSBxPhlzOTu9307mWlUuSG1Wn2bf5cEGQ+B3nu/xvhC1PZFNdd0NlWLSyzmWuSKILWxuTHzAl3eq7jFRRp4MVE1JoctYjcsLxt0rmgxcyujVveiJ97Y8VHuIrnyeAT5c0JkG4gBn/Bl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IARd+tSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0AEC433C7;
	Sat,  9 Mar 2024 03:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709955816;
	bh=Cy3Zo7p27wOQW/xMawb2c9DGZVH11rCB52Ur2eowbdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IARd+tSR0EQGzfut8Nte2CDbdB/A2vWgQEI1bkO7UrO8rOhjaG6xLsDQZcVePtYmB
	 OouzKoC5aVGW65FSqOOMRm7xGtEbhDcCI7o4kndqgCfH42uB7RB2xl4G9KxE4JhMBI
	 ppDA85sF4n3PFRG6+D3QWBt+1pEfcmF7+NkI2uJoW7BF6XVBNWpqFPhzWEtD8JETno
	 4Njbqg0KFy+bJ8WxPkkrYHQUDDYYuhMkFOn8nFMPb4hc20CwBIpouScu/r1b0S72Ls
	 LkSxGbg9NCTX9/ssbkUHLa0V0KjA9IEFuKnTMn8tG1l2QiXKZnqN64ct8bLtPsOdiX
	 ipFRXi7VZBuAQ==
Date: Fri, 8 Mar 2024 19:43:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@kernel.org>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 <mlxsw@nvidia.com>
Subject: Re: [PATCH iproute2-next 1/4] libnetlink: Add rta_getattr_uint()
Message-ID: <20240308194334.52236cef@kernel.org>
In-Reply-To: <20240308145859.6017bd7f@hermes.local>
References: <cover.1709934897.git.petrm@nvidia.com>
	<501f27b908eed65e94b569e88ee8a6396db71932.1709934897.git.petrm@nvidia.com>
	<20240308145859.6017bd7f@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 14:58:59 -0800 Stephen Hemminger wrote:
> > +static inline __u64 rta_getattr_uint(const struct rtattr *rta)
> > +{
> > +	if (RTA_PAYLOAD(rta) == sizeof(__u32))
> > +		return rta_getattr_u32(rta);
> > +	return rta_getattr_u64(rta);  
> 
> Don't understand the use case here.
> The kernel always sends the same payload size for the same attribute.

Please see commit 374d345d9b5e13380c in the kernel.

