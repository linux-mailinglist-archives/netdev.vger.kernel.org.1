Return-Path: <netdev+bounces-91124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B18B1793
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 01:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB211F24E51
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 23:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845AB16F287;
	Wed, 24 Apr 2024 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8GZJvMM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6A16F27F;
	Wed, 24 Apr 2024 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003148; cv=none; b=TNgbEy9mmg9r3CYZRB1BSYQI8If2E+irNARQfyrJ9mqV4azVvpN/p08DUM5a11HahFBnp9kp4pjubZK0ZqZ3Za1mzZCT4imlvKEbb6EC0LBlu/asI8n2XPQDfEl+4/zP5kfBFFnzXVnNfhn9pnaotLU++MStWKxUwxlBNPFGp64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003148; c=relaxed/simple;
	bh=S1yZOjnuDdnjLcmEUPEYxqb4c/uKF1LFTpIO9ko8tUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIgpTt/dGA0YKoW3ihZo+3c0R09AP6q4geJo/TSu+0DMjgiTZmy9gM3JBt0vkpjYy/Y/pBfkDBcUkE1JNUGkyFfaHJyJQvaYuGKUr8lvH9ai2o83wgZybrZFLw2M+kLjeMoPImpSr7C/wPQ4YHmJrjTbBRyzq+7fgpOHVf+++zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8GZJvMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233C0C113CD;
	Wed, 24 Apr 2024 23:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714003147;
	bh=S1yZOjnuDdnjLcmEUPEYxqb4c/uKF1LFTpIO9ko8tUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g8GZJvMMt16It97bIa7O97lBJMpPlA+g2xXmBN4u/PT5uPZ1J9mkEN1D4egAm8eXE
	 W4ZBfndTc78tL7bKMd3ojHrPu3txt6R99WclcH38XZl/ckyBBZ9WIi27PjeuLa/wsh
	 5hVR8KXwEPLfGMABqTGUgln3bxSbAevYE+fm3XuyQEvCAaMgB406RlSDCnC6E2z/0h
	 /+t3neTJY0IXb0VpjRv0IOiQfVD/EYAqqesOwW1dusE5q0vubIuMb/mr/14Oy/IaEJ
	 RqH1GyY7NlHGfOlL81+mDalZ5+X5eYrqzk+Z298ensznBVrjbW7NcpOEtshiaN2b0E
	 ogyLlZGbffXYg==
Date: Wed, 24 Apr 2024 16:59:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Brett Creeley <bcreeley@amd.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Tal
 Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 "justinstitt@google.com" <justinstitt@google.com>
Subject: Re: [PATCH net-next v9 2/4] ethtool: provide customized dim profile
 management
Message-ID: <20240424165906.37c83c04@kernel.org>
In-Reply-To: <df6163de-d82c-458d-b298-1eaf406e6b3d@linux.alibaba.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
	<20240417155546.25691-3-hengqi@linux.alibaba.com>
	<20240418174843.492078d5@kernel.org>
	<96b59800-85e6-4a9e-ad9b-7ad3fa56fff4@linux.alibaba.com>
	<640292b7-5fcd-44c2-bdd1-03702b7e60a1@linux.alibaba.com>
	<20240424091823.4e9b008b@kernel.org>
	<df6163de-d82c-458d-b298-1eaf406e6b3d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 00:49:26 +0800 Heng Qi wrote:
> If I'm not wrong, you don't want an interface
> like .ndo_init_irq_moder, but instead provide a generic interface in
> dim.c (e.g. net_dim_init_irq_moder() with parameters dev and struct
> dim_irq_moder or separate flags,mode,work). Then this func is called
> by the driver in the probe phase?

That's right.

