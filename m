Return-Path: <netdev+bounces-157350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7EA0A059
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 03:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA097A44DB
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D531EB48;
	Sat, 11 Jan 2025 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mckAdPKV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2B12E7E
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736562789; cv=none; b=cUEndIwgPwMe5s5egRyo4N7z4CZE1eAS8L11K4eaoPX7MVa8W7xvFyoa8yJWUfhW1bCR+/Ho2VXY5JJ2yaw+n68XI20w/x+Y/JqJQV0lpdh9VIrGmoAfWmP/qffe48dWCpdwNLeWQb0ahEvQT9BoM9PwEnToD6ZMshYEtf1YfB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736562789; c=relaxed/simple;
	bh=Q1+7wgWC9ZRSkCdzhkOrtg88WpQOuJnVIdLv1GGGkVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blk14r0lbn4aAD55qK8fvf9eR3iPbmqPTdqy0pBX8gF9EC0ng6kAnEmRVUiXXoX+Nk/Uho7QxjdoQhyPLe6zyAFxOOKxS+kAaB4OUakRcpruTFj1/OaKctkdXNg8Se+HkE2MmS+rIlHDM6Srw+VIxvDYm5rkrZ0amglJfBJJYKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mckAdPKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95EEC4CED6;
	Sat, 11 Jan 2025 02:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736562789;
	bh=Q1+7wgWC9ZRSkCdzhkOrtg88WpQOuJnVIdLv1GGGkVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mckAdPKVpAW12tn2ig5hgLOjMQGJSoPUte5fWHFz5J19bfpD3zeg6uH6NBgnkl50W
	 hZ82kCnScX3/rT5i2r6sLLLtDvS6EClHM1QHZfqHXkAMfYrOJLnkJkKtv5ZGbe/a2j
	 h5Ram11xAVXfJgZ08YPUNDdK4V8ffAQh1dNHpE+TlFiLB2TmhX9qXNYTNabtBTHzLI
	 JYJDcLdVFLfwEY+0IACrJex12MDoMzfapduSBweIRQceFsudS/x8ccCvM/LIQkUfnp
	 EOAbVqFTkyGTkGwiKBoZXdZYVrE2yZRnZN+V1noYFMsPAyUqgMubnT+pzvNVxtzdwH
	 DOs3J+PvuZVHA==
Date: Fri, 10 Jan 2025 18:33:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, security@kernel.org,
 nnamrec@gmail.com
Subject: Re: [PATCH net 1/1 v2] net: sched: Disallow replacing of child
 qdisc from one parent to another
Message-ID: <20250110183307.4bfba412@kernel.org>
In-Reply-To: <CAM0EoMn7uADZkTQkg48VP7K7KD=ZVHPLfZheAwXSumqFWommNg@mail.gmail.com>
References: <20250109143319.26433-1-jhs@mojatatu.com>
	<20250109102902.3fd9b57d@kernel.org>
	<CAM0EoMn7uADZkTQkg48VP7K7KD=ZVHPLfZheAwXSumqFWommNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 09:48:02 -0500 Jamal Hadi Salim wrote:
> There are two possible intentions/meanings from reading that dump:
> a) the pfifo queue with handle 204: is intended to be shared by both
> parent 100:1 and 100:4 --> refcount of 2 takes care of that. But then
> you can question should the parent have stayed the same or should we
> use the new one? We could keep track of both parents but that is
> another surgery which seemed unnecessary.
> b) We intended "replace" to move the pfifo queue id 204: from 100:4 to
> 100:1. In which case we would need to do some other surgery which
> includes getting things pointed to the new parent only.
> 
> While #a may be practical it could be achieved by building the proper
> qdisc/class hierarchies. I am not sure of practical use #b. In both
> cases it seemed to me prevention is better than the cure.
> Question for you for that test: Which of these two were you intending?
>  It could be you just wanted to ensure some grafting happened, in
> which case we can adjust the test case.

Yes, adjusting the test sounds good. I was testing visibility after
supported operations. If the operation is no longer supported there's
nothing to test :)

> Like 99.99% of bugs being reported on tc, someone found a clever way
> to use netlink to put kernel state in an awkward position.  And like
> most fixes it just requires more checks against incoming control into
> the kernel.

