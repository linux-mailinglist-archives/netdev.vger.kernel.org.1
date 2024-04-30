Return-Path: <netdev+bounces-92313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA88B6834
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 05:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D111C214B2
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FE5DDDF;
	Tue, 30 Apr 2024 03:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvRpVetV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A559DDA6;
	Tue, 30 Apr 2024 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446783; cv=none; b=B8sNToxWARW1tcA5X+pfj8s4KwXRD6wy4EJnj4FAFNa86wLM+u257QJJnpGJMhnvTomB1V5qX/b0wSTpIF8HWTQ2A+55n405nX4OwnqYB5x875N1lgBB4avN7uDJad3KFeHkB6q4jc5azlTtBsq04of8MhmL8SdwaO3i+ELz1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446783; c=relaxed/simple;
	bh=gVVnLpPWVK9UosOHYSAQpS6D2DcEHMe8dhidJZrY8rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzUX0i17rl5dKoRNVCgYQocoaqB4igitAbHVRVxSh8h7gKO53zwmNr1rlDlVauKYQOxGdl76Ii1G+3P0L7/4CrN77zHGnrtzC/0S2M8sRg8VolyjSLFYm/hiVwSsBdIBsr/mwGaef/jj4eUl2B3JR7HoTyyG9cNyCZC/VKs0Q/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvRpVetV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABF3C116B1;
	Tue, 30 Apr 2024 03:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714446782;
	bh=gVVnLpPWVK9UosOHYSAQpS6D2DcEHMe8dhidJZrY8rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvRpVetVnGKLc7ehmrflZ/u8Udny2jvVDN2xKnbLuN5eDU03EbJJ/EjGhfRJJLGxS
	 ZyOehS1yn6dDg/aBsx7xtBEY9D2YjhYU1Y51L76A6tE2Y92kAhyRen5fqFY9PxzF2L
	 8SGKZ0Ul9daWzXCbPKWrKTwQBGZX8G62W0nQAyAXi8atb9Rz2Rjz/SS68a8svQbjzf
	 danO6u+uknWl1ASRf6OzwDmMG7JdMQq9IPt4kMwfwvmnSRGPSbvFhPat0ZsOw7831Z
	 fMJG3JfVOBefV8MQd2bccGk1eKf03CugRqBfvISD7Yn5vOJnas+UXmd5SQzmonNGTt
	 rkA0m9ENV2+1A==
Date: Mon, 29 Apr 2024 20:13:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S . 
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric 
 Dumazet <edumazet@google.com>, Jason Wang <jasowang@redhat.com>, "Michael S
  . Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>, Ratheesh 
 Kannoth <rkannoth@marvell.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal
  Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul 
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, "justinstitt @ 
 google . com" <justinstitt@google.com>
Subject: Re: [PATCH net-next v10 2/4] ethtool: provide customized dim
 profile management
Message-ID: <20240429201300.0760b6d6@kernel.org>
In-Reply-To: <1714442379.4695537-1-hengqi@linux.alibaba.com>
References: <20240425165948.111269-1-hengqi@linux.alibaba.com>
	<20240425165948.111269-3-hengqi@linux.alibaba.com>
	<20240426183333.257ccae5@kernel.org>
	<98ea9d4d-1a90-45b9-a4e0-6941969295be@linux.alibaba.com>
	<20240429104741.3a628fe6@kernel.org>
	<1714442379.4695537-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 09:59:39 +0800 Heng Qi wrote:
> + if (moder[ETHTOOL_A_IRQ_MODERATION_USEC]) {
> + 	if (irq_moder->coal_flags & DIM_COALESCE_USEC)
> + 		new_profile[i].usec =
> + 			nla_get_u32(moder[ETHTOOL_A_IRQ_MODERATION_USEC]);
> + 	else
> + 		return -EOPNOTSUPP;
> + }

Almost, the extack should still be there on error:

+ if (moder[ETHTOOL_A_IRQ_MODERATION_USEC])
+ 	if (irq_moder->coal_flags & DIM_COALESCE_USEC) {
+ 		new_profile[i].usec =
+ 			nla_get_u32(moder[ETHTOOL_A_IRQ_MODERATION_USEC]);
+ 	} else {
+		NL_SET_BAD_ATTR(extack, moder[ETHTOOL_A_IRQ_MODERATION_USEC]);
+ 		return -EOPNOTSUPP;
+ 	}


