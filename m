Return-Path: <netdev+bounces-94384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CCD8BF4CE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 05:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F0DB22E36
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 03:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC98125C7;
	Wed,  8 May 2024 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4uMgHu+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E311C85;
	Wed,  8 May 2024 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715137264; cv=none; b=WyGRQLNK6BJ5QN7AifXtKsDrP+kug2H3nOe6/vWgYCCI25UqwfL/ikzzEUFsG7P/pVGl54JeGWa2LjwQoOxLdcJUv5Ap92XnOJ2nypsjjtdCMna3dzBAGCwBlYX6uZ2oladty2AhW+ctRCtIvaxqhu1BmJauUrmrsnhA2o2xDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715137264; c=relaxed/simple;
	bh=3XcmFQWPXKv5Kihd7gCtibMQ533I8P2tVJwuOcJHAEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZtyf8GwSZBavN/RU9p832GITiwhmpcepjXbd5JSvTRCr9GhvV0IO6dZhEjGssGJluiTXV9O0OlDn1hsT59+BqnlYc11erJI687w9J1OZx+e/JgpHYOFkiFQW8dF93OR7ptlSKN51XxcvGqmH/19YwVij2G0pw8L6XjB5QaC6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4uMgHu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86797C2BBFC;
	Wed,  8 May 2024 03:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715137263;
	bh=3XcmFQWPXKv5Kihd7gCtibMQ533I8P2tVJwuOcJHAEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4uMgHu+/1S96pk9T9TQN3M46ygaXr3NrI0h2pIoDWP8Yl1dmBeUTk9sxk+L6JTHE
	 urCDKGMDb/aoPF4LSBlTYzI+2l2dUi0PpNjIU/vAcy4s5CAkvwhQDksxJp2G8YwYlX
	 wAMX6MXaGxNFOgGcRm+LqBOK4z7n8BHZJ3uSoiMWtFJWpgbR2+rLt0DJCZ3KzX8BYT
	 SxLJL1OTwqntcyMoYP9BQoqhOVWgA5ejRvbYweI9kgdbS3XmRxLAhyexHWRvuRRA4X
	 gYfZryvy4KamvkYgK/fH+0fbdQ3LgMp9t48YXfyFDOysVDio0jYs1FtblLPJlKbqMq
	 31B+TnMEnImlg==
Date: Tue, 7 May 2024 20:01:01 -0700
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
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v12 0/4] ethtool: provide the dim profile
 fine-tuning channel
Message-ID: <20240507200101.21f82c9d@kernel.org>
In-Reply-To: <20240504064447.129622-1-hengqi@linux.alibaba.com>
References: <20240504064447.129622-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 May 2024 14:44:43 +0800 Heng Qi wrote:
> The NetDIM library provides excellent acceleration for many modern
> network cards. However, the default profiles of DIM limits its maximum
> capabilities for different NICs, so providing a way which the NIC can
> be custom configured is necessary.
> 
> Currently, the way is based on the commonly used "ethtool -C".
> 
> Please review, thank you very much!

Good progress! Please make sure to also update
Documentation/networking/net_dim.rst in the next version.

