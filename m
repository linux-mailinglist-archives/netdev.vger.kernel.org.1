Return-Path: <netdev+bounces-153700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F73B9F93F7
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C74D1663B3
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4653F215F4F;
	Fri, 20 Dec 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ik3wnO5F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD021577A
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734703689; cv=none; b=uuIrbLrBfrM7dTLupoo57FJzPhri/Mv31D1+Oyqy1RyKc3++n6Ue/nhokiZYxVp3+lT3t20Rv3PFoc53rtNaxkKViHOdbGwXQQbW5WAy5u9fvy/SAv3D9+GV7UTbETnf9hkYXpgru8Dqkf4gJpIzkN/drlgIq/pMEyGUQmB7X3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734703689; c=relaxed/simple;
	bh=SDhfgB4HIh8km2eQpBDt2kgwI+b1BlQ3B9jjpn/qx9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXOZEwXRdkJNSgCVHKT0xApyBs9Nx0XVxJT0ZH+9bGuXAACGwjwgH6mLxHdkTevWda0WWxwdwMGs/gPIOwkBMCB087ovpP2azYkmWA8z8R5PjwiSy9Mp8YfHXwN2ltBkRQZxNQ6vCENKcWGBnLlFJN+Whc5uW4CKMMVqbGrU15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ik3wnO5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C16BC4CECD;
	Fri, 20 Dec 2024 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734703688;
	bh=SDhfgB4HIh8km2eQpBDt2kgwI+b1BlQ3B9jjpn/qx9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ik3wnO5FxNOJQ/CQ2BcLxOGrqdtFKgI3bp9igEyK6ZRipHsNN0bQBJQZuy7uDm0G4
	 +XKH/674dzMq5buFW+fhohj+GMdiJCyGW15Ys9puQJ5aXYN/usiVgOJzkr1FHgOu/j
	 dv6m2ThS8R2KCMA2tpspuu9xk0ZtZ31LfCIvdGZodRPc+YCvzoPzbwS4E5mhFEgfel
	 SaTLmqHXQpj1G14F4d0jAYsQZ635IQJc5UHSsK/l0wmrTa+0Hi8TZbmkZCAFTidbuD
	 OzfII4tMw+g/I0irWeslx24hJEL8EMobCAZiKz7dYb1ZILSE5S+6wKGF5TFstkX6iP
	 gZKZE+7pVaEOQ==
Date: Fri, 20 Dec 2024 06:08:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, <netdev@vger.kernel.org>,
 <edumazet@google.com>, <davem@davemloft.net>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 02/10] eth: fbnic: support querying RSS config
Message-ID: <20241220060807.6b5103a2@kernel.org>
In-Reply-To: <aa36e48f-a54d-43df-979c-bb81a90257f0@intel.com>
References: <20241220025241.1522781-1-kuba@kernel.org>
	<20241220025241.1522781-3-kuba@kernel.org>
	<aa36e48f-a54d-43df-979c-bb81a90257f0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 12:42:42 +0100 Przemek Kitszel wrote:
> > +static int
> > +fbnic_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
> > +{
> > +	struct fbnic_net *fbn = netdev_priv(netdev);
> > +	unsigned int i;  
> 
> AFAIK index type should be spelled as u32

Does it matter? I have a weak preference for not using explicitly sized
types unless the bit width is itself meaningful.

> And will be best declared in the first clause of the for()

I don't see woohaii.

> > +
> > +	rxfh->hfunc = ETH_RSS_HASH_TOP;
> > +
> > +	if (rxfh->key) {
> > +		for (i = 0; i < FBNIC_RPC_RSS_KEY_BYTE_LEN; i++) {
> > +			u32 rss_key = fbn->rss_key[i / 4] << ((i % 4) * 8);  
> 
> are you dropping 75% of entropy provided in fbn->rss_key?

Nope, it's shifting out the unused bits. And below we shift back
down to the lowest byte. 
We store the key as u32 (register width) while the uAPI is in u8.

> > +
> > +			rxfh->key[i] = rss_key >> 24;
> > +		}
> > +	}
> > +
> > +	if (rxfh->indir) {
> > +		for (i = 0; i < FBNIC_RPC_RSS_TBL_SIZE; i++)
> > +			rxfh->indir[i] = fbn->indir_tbl[0][i];
> > +	}
> > +
> > +	return 0;

