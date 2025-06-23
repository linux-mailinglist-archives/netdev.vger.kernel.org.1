Return-Path: <netdev+bounces-200296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4207CAE4732
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46BD173284
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E922620FC;
	Mon, 23 Jun 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlXuvVKW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E24261594
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689442; cv=none; b=X4cjKvVSbFfi+b4Le6TnzjrAb8fLXT3WSAvA1XKs2OuG8mpwUac4poQyMLh/8pV+2m7qai9ToC6cxhwEJRiWkn/mfHkfREG7wjRd+eLRA3+y5jcQW0Og+wxuGSuD1D6HBu3sR0vXGTo4mahuS9dNKdxTfqBmpf8nf+J1DfX/HFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689442; c=relaxed/simple;
	bh=0J9CxrWN5KmK+wEyvEdy2otLsJdAFRIvu78LwyS5NFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJ/1Jft/FbCc/te/zYRcDfp/OAAK8hFWUJv4zM0rbz0L7pinmA2fTqnUDljHadnyInpwhiNiDrmmk3bn62k1YT0MwUPKzpXJlF4ZvdCAAag27UfUGaVaBG0+rToP6GySPDHQlH+BKMyBYFIpihc1s5t0ZliSU9ZrDZ2ZxDHxA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlXuvVKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB48C4CEEA;
	Mon, 23 Jun 2025 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750689442;
	bh=0J9CxrWN5KmK+wEyvEdy2otLsJdAFRIvu78LwyS5NFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jlXuvVKWyVcecqO/q6mFOE6/Nlhs1glKJconvGxUqjaKhUfOqTU3f8SOnOttTRUWE
	 /kzc4cy0GsXjLevUT9bRACe4mN7j5tSU2xazVkJmDdVsy/Z/1iKnm/t+JdX/MmNEhQ
	 U9CmGE7uqCznRdU7rDozzOiBi/99QsbrA0YnnJQjFJoCvG5XydCYV/fEGypgMqg5Ri
	 L2g0Yd5RMP5f/uPvHUdjssXet3GIGru1e/ZNdt5DxKHhqW2xbQSwtmX3hG+1IkqAdw
	 xBi7xTQytUblKuIxBkhWdgmtnTD6RwUslbQY8+2AQLla3/Uaz7l6T4LtZ/CXhIaO37
	 potMXxax6dXEg==
Date: Mon, 23 Jun 2025 07:37:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, jdamato@fastly.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 5/9] net: ethtool: copy req_info from SET to
 NTF
Message-ID: <20250623073721.1315dd03@kernel.org>
In-Reply-To: <20250622140020.3dcc6814@fedora.home>
References: <20250621171944.2619249-1-kuba@kernel.org>
	<20250621171944.2619249-6-kuba@kernel.org>
	<20250622140020.3dcc6814@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 14:00:20 +0200 Maxime Chevallier wrote:
> > @@ -979,6 +979,9 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
> >  
> >  	req_info->dev = dev;
> >  	req_info->flags |= ETHTOOL_FLAG_COMPACT_BITSETS;
> > +	if (orig_req_info)
> > +		memcpy(&req_info[1], &orig_req_info[1],
> > +		       ops->req_info_size - sizeof(*req_info));  
> 
> Is there any chance we can also carry orig_req_info->phy_index into
> req_info ? That's a bit of sub-command context that is also useful for
> notifications, especially PLCA. As of today, the PLCA notif after a SET
> isn't generated at all as the phy_index isn't passed to the ethnl
> notification code.

Definitely a good idea, only question is whether it should be a
separate series. But the change is easy, I guess just:

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 1a8589693d91..91974d8e74d8 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -981,9 +981,11 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 
        req_info->dev = dev;
        req_info->flags |= ETHTOOL_FLAG_COMPACT_BITSETS;
-       if (orig_req_info)
+       if (orig_req_info) {
+               req_info->phy_index = orig_req_info->phy_index;
                memcpy(&req_info[1], &orig_req_info[1],
                       ops->req_info_size - sizeof(*req_info));
+       }
 
        netdev_ops_assert_locked(dev);
 
If you'd like me to squash it in -- would you be able to test this?

