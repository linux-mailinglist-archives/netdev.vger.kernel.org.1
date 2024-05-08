Return-Path: <netdev+bounces-94379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C78BF4B4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DD01C20AE0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A1B111BB;
	Wed,  8 May 2024 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVKQ+Pts"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241791119F;
	Wed,  8 May 2024 02:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715136430; cv=none; b=RZ8YO4SxocuxDmORZmEqpButDxGVA9VFvnKZEI4rH9ZxRqLT/sHaHXqlziNgpHUHz7HiCJfpk1GHm9dMzpiOIdD5Ofxwkj+k+FTezmw4bEhVc4HWHWL80jIi+y0H2AcZaCBVc23hqiom5V3gsaLv6Fj784Ytyfm9WXEWauAygLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715136430; c=relaxed/simple;
	bh=ZsjJClaoNI+y8T5MzT4iesu4zCJvs09uAbcD694+0iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGQgMjEIq+GLOJ+m0c6hxxf3a3nNQ3c/6JG1z9PaetkOUZbX3TWNJnnr06A+aM+pvqv7ykEk3xAKyEE7eWGV0hhdpA5YBH1Gkkvcqc2ltHfb2zwi5hh5EeK+frHIESes9PchJOlaogUSC+VY9cmOiimE4ZIud7JNof/DGkHC9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVKQ+Pts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE55C2BBFC;
	Wed,  8 May 2024 02:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715136429;
	bh=ZsjJClaoNI+y8T5MzT4iesu4zCJvs09uAbcD694+0iQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVKQ+PtsQLO5YhDIgqhY1leH7qRtlHZP8zpVT0C92phqeG/40TB1iV5aWkucuYEXr
	 vlsv2SRxsIWrejGFFtQn7kwp+kMHf+tiL5zYw8EcGqJeS4Qs+OS2uDtjBx3Gau1z7T
	 U1FT5BQXdCGyH4d7uPX49HTjJTeo1PrP/E7IH952Mxh+P2QZRDPMNv3sh6XYZATvuD
	 s1ml6kKYEUYLZSl47X667JXAyFFxTlodGvySnJbY/GcH1MMzwRJc4p0G0tDRgZARgt
	 o/bqS5R04tJp8dNOb2zLZ4rcs6Daq1SLE+Bt/Rmkr0Ft3zL5IXUNDOIbwP8rK3HPgv
	 oahbIe9ySxRAQ==
Date: Tue, 7 May 2024 19:47:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Jason Wang
 <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Brett
 Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com, Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v12 0/4] ethtool: provide the dim profile
 fine-tuning channel
Message-ID: <20240507194707.7c868654@kernel.org>
In-Reply-To: <1715134355.2261543-3-hengqi@linux.alibaba.com>
References: <20240504064447.129622-1-hengqi@linux.alibaba.com>
	<1715134355.2261543-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 10:12:35 +0800 Heng Qi wrote:
> I would like to confirm if there are still comments on the current version,
> since the current series and the just merged "Remove RTNL lock protection of
> CVQ" conflict with a line of code with the fourth patch, if I can collect
> other comments or ack/review tags, then release the new version seems better.

Looking now!

Please note that I merged a patch today which makes DIMLIB a tri-state
config, meaning it can be a module now. So please double check that
didn't break things, especially referring to dim symbols from the core
code.

