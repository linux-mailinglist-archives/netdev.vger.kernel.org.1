Return-Path: <netdev+bounces-235181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F30C2D2BD
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9E91884FD4
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482D5318139;
	Mon,  3 Nov 2025 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIC5g0RX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD2E2882CD
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187790; cv=none; b=Q9iS2i6GIizZ1GYnRiw0Np6QlZ58SmskertwYOHzSBzCD1ImkJrApwKf1SZE31GjbVsl1I3Zo0zKld5KKesjpshcMH0esPMUzUesMqkH+frCYS7pfv1JZMONXLyHuyd+lQ/zNTSHM5DCbABtH5Yd6LktAlrFlOuSBg9M8V1ygr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187790; c=relaxed/simple;
	bh=FTbSdzcSfjDJWHrsY5GU1K2IiMzNNS7l/cCl68pOHd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlI0ViVfb4+gAjYlGCdP9q2HecN/OGo9OQpo31qnR6Hov8KBZ5YfT4Be/MjZtWFr7LMVMqrg/Pw9gNuqa418g1q5GZ49LWimd71XTUQm9L+UHOKCuFocpynp8ba6ra5N6htAWMILSXVQGL4KOOIIv9D8UcfzoMDZX43+Yj5ly/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIC5g0RX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92983C4CEE7;
	Mon,  3 Nov 2025 16:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762187789;
	bh=FTbSdzcSfjDJWHrsY5GU1K2IiMzNNS7l/cCl68pOHd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GIC5g0RXCXSEw7hsS2S+OoLSy92oGDK3YuCVyPZClm+41oeeHgdR83lBP+sMHvSPy
	 izhR+W0EBxbkITYrMKGVCt8f+8b2YrcSVkUh8JGUgqQO8EY/zV5pO22/lik6titcvb
	 jqqvUjNpFP9yYug5Cz941MIxB8iLXs+RLWuN2lPGSND7eBkehX2N2NnqJ6KcxMA8F4
	 Bn3d3uMH7Fu7+8ZHkKjoWaRHUBCrbQcHRHRZhu3WTleNdALKco3BiHXNgLsW5Dcf+e
	 9rNoO9nfswwr3EyiqFDEsupGxIsI+0rHPG0zAP1YR1k4+kSHcWKl9crSjKeogKyvVA
	 v+ZMp6mCygI9g==
Message-ID: <a0d03ce2-eccf-4818-ade7-5be737145aa3@kernel.org>
Date: Mon, 3 Nov 2025 09:36:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ip-xfrm: add pcpu-num support
Content-Language: en-US
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 Steffen Klassert <steffen.klassert@secunet.com>
References: <2623d62913de4f0e5e1d6a8b8cbcab4a9508c324.1761735750.git.sd@queasysnail.net>
 <20251030090615.28552eeb@phoenix> <aQP6Ev_21Z45JuG9@krikkit>
 <bfdd7558-31d8-4d83-8532-40f2371dfe34@kernel.org> <aQh6ed8g8CUjPG4o@krikkit>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <aQh6ed8g8CUjPG4o@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 2:48 AM, Sabrina Dubroca wrote:
> 2025-10-30, 19:32:10 -0600, David Ahern wrote:
>> On 10/30/25 5:51 PM, Sabrina Dubroca wrote:
>>> With the netlink specs project, it's also maybe less attractive?
>>> (netlink spec for ipsec is also on my todo list and I've given
>>> it a look, ipxfrm conversion is probably easier)
>>>
>>
>> That is an interesting question. I guess it depends on the long term
>> expectations for the tooling. There is a lot to like about the specs.
>> Does Red Hat include the commands in recent RHEL releases? ie., do we
>> know of it gaining traction in the more "popular" OS releases?
> 
> Yes, it's present in the latest RHEL release and recent Fedoras.
> (no idea what Debian and Ubuntu do)
> 

That's a start. From there we need to figure out adoption rate. The
legacy arp and ifconfig tools are still widely used despite requests to
move to ip meaning habits are to break.

I would give the netlink spec priority.

