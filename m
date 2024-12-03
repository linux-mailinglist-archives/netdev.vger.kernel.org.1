Return-Path: <netdev+bounces-148669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA99E2D33
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2757F160182
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A081E501B;
	Tue,  3 Dec 2024 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erfYuqSy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89BB1A01B9
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258111; cv=none; b=kbZBqvC0mMrD6mB2yPn3qPEPdsVrgP8EzQ2sCRBjQC9kcnJ4oll9/cVxvy9FQ/KlGTisdbu1PIIL/LxZ0o3RmOQ1WEmrVxqd+cQRPZL5rqCRFuWy47UlB6btktc22biB3DP2hPhZEBfHaI3mBmGaeMn5V3cNRwZZiuYS8pz2hZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258111; c=relaxed/simple;
	bh=5xpp5ZE5z0bk8ryEGi+u3xIb0pxyaQCKLxC8nFsMpJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+FzDdSMXTM+t5c4ce7SjLpl7E1N9Oi2lYd4RdAp4YmD8873G8ZVxnhSLAlDahgzOxjxD3QPofH61cGB+5LWWwFOmSWfHCFRO3hS+zhiFaN68ct0VzXW5zocH2jRDi2Wox0BIb4a8RPx6Mn7jNdZplMP8HfmZ/yuafHOCnl4ak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erfYuqSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCDDC4CECF;
	Tue,  3 Dec 2024 20:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733258110;
	bh=5xpp5ZE5z0bk8ryEGi+u3xIb0pxyaQCKLxC8nFsMpJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=erfYuqSyhTZ5FD3nR/dn2mCcwJ6LVEpxrsV66CQy6pOV1HJpo97b6WBvqt0ZTDIlc
	 ZsqX3aX/QeYQPPVX9zNae3lrdvot3gpx+uYc5znMgipUv9eKHQEjh+nCI+criBEtP8
	 BdVqIf6pERiIQtBNwtSaBSONs0cjYpNs0edtepNV8JJ2ARe/3Bs114s+PGkZHtq9ME
	 sdhBjCCSVn7XXo9nneqPIfjuQGdUXP1NXj1G6IeSBnBNb3N0sj8Rzr8aj+xKboOPHk
	 eZU7dZQ+GcQBPYp8JQgYWjBIaGRKiZq6kqQjST5ZGUct0eTFnNxsF482U5ZGLmPEc2
	 oh5gBe8UuHUzg==
Message-ID: <d686df42-3f31-4aaa-a9b3-f3fb85c7bf6a@kernel.org>
Date: Tue, 3 Dec 2024 13:35:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: wireguard: Allow binding to specific ifindex
To: greearb@candelatech.com, netdev@vger.kernel.org
Cc: Jason@zx2c4.com, wireguard@lists.zx2c4.com
References: <20241203193939.1953303-1-greearb@candelatech.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241203193939.1953303-1-greearb@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 12:39 PM, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Which allows us to bind to VRF.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
> 
> v2:  Fix bad use of comma, semicolon now used instead.
> 
>  drivers/net/wireguard/device.h  |  1 +
>  drivers/net/wireguard/netlink.c | 12 +++++++++++-
>  drivers/net/wireguard/socket.c  |  8 +++++++-
>  include/uapi/linux/wireguard.h  |  3 +++
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 

LGTM

Reviewed-by: David Ahern <dsahern@kernel.org>

be good to throw a test case under selftests

