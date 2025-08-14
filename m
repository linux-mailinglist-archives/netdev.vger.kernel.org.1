Return-Path: <netdev+bounces-213521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57EEB25803
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A768D5869FC
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185BB2FC891;
	Thu, 14 Aug 2025 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuaOCCfF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4772F60BD;
	Thu, 14 Aug 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129614; cv=none; b=kV3ma/9L7nY7kjx3vizE8ms+uYjOb1vjMfwrbdkd8EABfIVbg1FnpmNSWZIcMpZ8QMyNBMJhS6JympVpjRquKenllYwREw/RyslBhBjaV0BexqsAL/gQIwuIZ5qHRZKhWkHV60h6upAN3PmQB2cU8PYDoS1jnp1z+D0TYZD0SyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129614; c=relaxed/simple;
	bh=bn7IKQjMLN4JXVpZcb+CROTKitiJI2sWExFMMP7aG4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Po5uVhqtlCozVWEVlF5VUp5eSzjCtGJXI6s4gnlyoOsU39sCuLQCRjHElt+RCsHmK/zjcDYjuAenyNfvPABUSVt0mG993xO9fuKAMkEQx2AE/RINuxcan1GQwvU7n0KNQ/0gplR6WoIYO3netuZ/tp0nSiLIT+8Nae4AKnfsdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuaOCCfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C868C4CEEB;
	Thu, 14 Aug 2025 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755129613;
	bh=bn7IKQjMLN4JXVpZcb+CROTKitiJI2sWExFMMP7aG4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WuaOCCfFjQEKcpAQtI730rOQaisFWV5KdyNEXx040DnkSyyK9f/xH30znzqyYbMBg
	 ludRIbf/tzutH/dEDWwWUSUy5UuOB/uehd4715JrAYNhKJxw1asCSrrM1DIsICRFhb
	 LJw4IlOQSKlQ8u2BlNplbus2Iz6yb5vix0wcww3EzUjyBcVVLIinMttsaDBZpm0a2t
	 nrhtrhAEpBQWDKhFdqOJs+PG3Vfw9uP3jR+lvxUpWBBG/MP2oI5Wy2DCxv9fXNGOFO
	 JVbelYxdkDAL8LpzQZNXtWQqrUagiOPmt+srHWnkl0+3zFeging5IH+NPlNWZMOzcL
	 rWY32p0+qeZnA==
Date: Wed, 13 Aug 2025 17:00:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] amd-xgbe: Configure and retrieve 'tx-usecs'
 for Tx coalescing
Message-ID: <20250813170012.7436b6e6@kernel.org>
In-Reply-To: <20250812045035.3376179-1-Vishal.Badole@amd.com>
References: <20250812045035.3376179-1-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 10:20:35 +0530 Vishal Badole wrote:
> Ethtool has advanced with additional configurable options, but the
> current driver does not support tx-usecs configuration.

Not sure what you mean by this, perhaps:

  current driver does not even support tx-usecs configuration.

? tx-usecs is a very old tunable.

> Add support to configure and retrieve 'tx-usecs' using ethtool, which
> specifies the wait time before servicing an interrupt for Tx coalescing.
> 

> +	/* Check if both tx_usecs and tx_frames are set to 0 simultaneously */
> +	if (!tx_usecs && !tx_frames) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "tx_usecs and tx_frames must not be 0 together");
> +		return -EINVAL;
> +	}
> +
>  	/* Check the bounds of values for Tx */
> +	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "tx-usecs is limited to %d usec",
> +				       XGMAC_MAX_COAL_TX_TICK);
> +		return -EINVAL;
> +	}

Normal configuration granularity for this parameter is in 10s of usecs.
You seem to be using a timer, so I think you should either round the
value up / down to what the jiffy resolution will give you or
reject configuration that's not expressible in jiffies (not a multiple
of jiffies_to_usecs(1)). Otherwise users may waste time turning this
knob by 100usec which will have zero effect.
-- 
pw-bot: cr

