Return-Path: <netdev+bounces-119061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57038953F40
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFD5283DAB
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BCB219E4;
	Fri, 16 Aug 2024 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2Rg2PO8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD03C6AC;
	Fri, 16 Aug 2024 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774011; cv=none; b=dWDX9igJx3heSoE95N1geAYmvIThanx4nsIfmm407mdlT7JXmn5304n40LfjyOfCIPmcW8OYbk/5RjrwLVcHW+Bbhhdy90+58OMxxBFdF8Szt0tWMYj6nPlL6VPNQOSIcgycr5qeW3Rx7/suxLiYxH+A1CTyLPoPe6LL2j72QoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774011; c=relaxed/simple;
	bh=MWP/CSg9pHqzRZAABq38Gs+E4Z2jS/bd6RT84P2ni+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvCQL5bIEB1vAHtOHMWUL4enfbxYie0QhDABz+Nv0zS30K8B1fXKdmbPf5hH7ot99eV4EbunByRvX3EXBb5sV2u14WRxjuQIpw4cvS6pr35wW+dgNKkO3NtUrY+aV1DF8B2H/C01c2ujbMgxy35nHakMqzxkGI7Vc0+Ix+Rot6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2Rg2PO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A191BC32786;
	Fri, 16 Aug 2024 02:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723774011;
	bh=MWP/CSg9pHqzRZAABq38Gs+E4Z2jS/bd6RT84P2ni+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F2Rg2PO8ktiBhlxaQzLAF499ZzLmgjnMspTiwNt4/xjfN6YV/rEoG/RR3jOwqQV+t
	 Cb9/PCd3p931AWFL4vrmbKQQ3m33yCERBMV6NB9FnevaTiygNhq7CSlb4PmkCJSWe6
	 elioT7MYNUomkr6rUJap5ZIAiWfbyPOe9FLbnM5hgrimXXO3a+FpeBjE9zProRqDjY
	 f0nevFYJuVAetuvCZKokIaeAZHoxEI4hHbJXeeb9Fiptl3NVHs9QYRYCyJrVc/eKuS
	 x1mbmIfcCMkVVK79IqBZ2In3sizXpJ/gWA7PkFrwi7Nn2lcUuekiivoyL9wOrBv3Y4
	 31/ViZisMaJuw==
Date: Thu, 15 Aug 2024 19:06:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1] pse-core: Conditionally set current limit during
 PI regulator registration
Message-ID: <20240815190649.5a9c41fb@kernel.org>
In-Reply-To: <20240813073719.2304633-1-o.rempel@pengutronix.de>
References: <20240813073719.2304633-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 09:37:19 +0200 Oleksij Rempel wrote:
> Fix an issue where `devm_regulator_register()` would fail for PSE
> controllers that do not support current limit control, such as simple
> GPIO-based controllers like the podl-pse-regulator. The
> `REGULATOR_CHANGE_CURRENT` flag and `max_uA` constraint are now
> conditionally set only if the `pi_set_current_limit` operation is
> supported. This change prevents the regulator registration routine from
> attempting to call `pse_pi_set_current_limit()`, which would return
> `-EOPNOTSUPP` and cause the registration to fail.
> 
> Fixes: 4a83abcef5f4f ("net: pse-pd: Add new power limit get and set c33 features")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

FTR looks like Paolo applied this, thanks!
-- 
pw-bot: accept

