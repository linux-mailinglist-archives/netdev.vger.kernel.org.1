Return-Path: <netdev+bounces-131738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2DE98F62F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21DC1F22482
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4430F1A3A9B;
	Thu,  3 Oct 2024 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pW2U/dLM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38211BA41;
	Thu,  3 Oct 2024 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980488; cv=none; b=nFzzmnNW142nCKdKZPo0j347yGtRLnErp8QfJCkd4ktKSG46xNVYPyDSi4ZITVEt3KdcdXmQPca3zf+Y/m510L3Ryp30IO/nA9H9iM6yvx1C7ZAMDY0jsGPVji155+5sVbcFKjc/0QXCPp6vayFAH7YXcVJGHH0rsZtNm9HT4/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980488; c=relaxed/simple;
	bh=J/f3wmOfhI5R7CuIroosv2kTyZP9RiZvX1hJ3rMGQw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTBB4zUcE214UKqr1d27G9BkTvHPBCic1PJwzsVTVkRo9RvAvFiwiV65XGBsWlcHBbsBudEJGmgZDD/NDzMW5sniQCFfqUI0kOOPptGEmF6AXZ4mgGcg9EP2iYWyaMEBVcipiihugpxW4JY1sWyTNygqM2mQ26nKB2eb7lCayTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pW2U/dLM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CtrP9NGhe0atPh2TLvSRDqVDIaATM9b7rzyGsGE/Ico=; b=pW2U/dLMK4dunIV2rYKPvhWK7T
	lRcZQA7/aH83gIUUKrOZA8oMEcx+2eYveiJWsrOOny/Fh3WlzDZhyiKlTvpQIuNFxrsjRXA4DkP4L
	ZEX58ncTR6C9lKQbRSm8uCpLdIY3BTVj3IGACzMKKEUs3HLUaxc4Y5PqFwVczT9WoOcE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1swQem-008yKW-RH; Thu, 03 Oct 2024 20:34:32 +0200
Date: Thu, 3 Oct 2024 20:34:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, almasrymina@google.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	donald.hunter@gmail.com, corbet@lwn.net, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, danieller@nvidia.com,
	hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com,
	ahmed.zaki@intel.com, paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com, idosch@nvidia.com, asml.silence@gmail.com,
	kaiyuanz@google.com, willemb@google.com,
	aleksander.lobakin@intel.com, dw@davidwei.uk,
	sridhar.samudrala@intel.com, bcreeley@amd.com
Subject: Re: [PATCH net-next v3 1/7] bnxt_en: add support for rx-copybreak
 ethtool command
Message-ID: <a3bd0038-60e0-4ffc-a925-9ac7bd5c30ae@lunn.ch>
References: <20241003160620.1521626-1-ap420073@gmail.com>
 <20241003160620.1521626-2-ap420073@gmail.com>
 <CACKFLi=1h=GBq5bN7L1pq9w8cSiHA16CZz0p8HJoGdO+_5OqFw@mail.gmail.com>
 <CAMArcTXUjb5XuzvKx03_xGrEcA4OEP6aXW2P0eCpjk9_WaUS8Q@mail.gmail.com>
 <CACKFLikCqgxTuV1wV4m-kdDvXhiFE7P=G_4Va_FmPsui9v2t4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACKFLikCqgxTuV1wV4m-kdDvXhiFE7P=G_4Va_FmPsui9v2t4g@mail.gmail.com>

> > I agree that we need to support disabling rx-copybreak.
> > What about 0 ~ 64 means to disable rx-copybreak?
> > Or should only 0 be allowed to disable rx-copybreak?
> >
> 
> I think a single value of 0 that means disable RX copybreak is more
> clear and intuitive.  Also, I think we can allow 64 to be a valid
> value.
> 
> So, 0 means to disable.  1 to 63 are -EINVAL and 64 to 1024 are valid.  Thanks.

Please spend a little time and see what other drivers do. Ideally we
want one consistent behaviour for all drivers that allow copybreak to
be disabled.

	Andrew

