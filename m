Return-Path: <netdev+bounces-133766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A86996FDF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715B9282597
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4251E0DA3;
	Wed,  9 Oct 2024 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+bsbYPZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB961E0B8F;
	Wed,  9 Oct 2024 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487719; cv=none; b=dSRVURydntuX4OI6pxu8XWZXrDfUbLajgOu0kS5RdpsssE+IktS9ImyL7VrDEvcbUfX312yag8WYKhdzytKGNMf855eR4mT2z6k5+sgUE5XkDiCKAPlVwzvDmgXD9GuJ9E7zujpXoAb3/svhb6l7/G9UgRPJqUf7n11qf3qlMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487719; c=relaxed/simple;
	bh=NZhPKkxiBqWOWXobZBa+zAtIejUJQqhd5KjHxmog/7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdyoL7FL8+CwYnixc2DE7Sm9CGdS+nmbccGV0QHN0si4FY+Pcj7R7dTKQyieJThp8M3CpzNvsdfSf7iWaGB6TI14Y3+1oiG2ApwOPndTJi6ytMbOn/nmI5oxi8Nps1kkKxzhfaF6atzpbFnNjQ96txqM+ll90oNXS4VW6DX9JAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+bsbYPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066CFC4CEC5;
	Wed,  9 Oct 2024 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728487719;
	bh=NZhPKkxiBqWOWXobZBa+zAtIejUJQqhd5KjHxmog/7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D+bsbYPZY+y1bchZ94DwJYleIOy7dxZajVy5YHh6VFsbOw9/GaprvzqnmWsvZ/zgN
	 tfkwCXmXBLPjQg1wGPuYeu9kktqKTcwwZlVFNTJEIUGyCVaJ2Huc0zdvbaO1ruFvEq
	 oIO5WtC6GebDxzZ4rZUgYYkzKunm65M0eaahclBUHmp92veiQ+8qRWlXQVRtbRny+2
	 ovlImXyMF/QdRk8RLErP89Jdf4MN8lAlxnS5hCeWk2AcMJ91PY48/UwzowsfJSyuLR
	 21tjmdmvRCUN1DP0bwxTP0+uiZZhSbxUg9sUws0utsSKVvS2TSGmYjIzNNoXOZupiw
	 NXcs4Or84gpTQ==
Date: Wed, 9 Oct 2024 08:28:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
 kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 2/7] bnxt_en: add support for tcp-data-split
 ethtool command
Message-ID: <20241009082837.2735cd97@kernel.org>
In-Reply-To: <CAMArcTU+r+Pj_y7rUvRwTrDWqg57xy4e-OacjWCfKRCUa8A-aw@mail.gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-3-ap420073@gmail.com>
	<20241008111926.7056cc93@kernel.org>
	<CAMArcTU+r+Pj_y7rUvRwTrDWqg57xy4e-OacjWCfKRCUa8A-aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 22:54:17 +0900 Taehee Yoo wrote:
> > This breaks previous behavior. The HDS reporting from get was
> > introduced to signal to user space whether the page flip based
> > TCP zero-copy (the one added some years ago not the recent one)
> > will be usable with this NIC.
> >
> > When HW-GRO is enabled HDS will be working.
> >
> > I think that the driver should only track if the user has set the value
> > to ENABLED (forced HDS), or to UKNOWN (driver default). Setting the HDS
> > to disabled is not useful, don't support it.  
> 
> Okay, I will remove the disable feature in a v4 patch.
> Before this patch, hds_threshold was rx-copybreak value.
> How do you think hds_threshold should still follow rx-copybreak value
> if it is UNKNOWN mode?

IIUC the rx_copybreak only applies to the header? Or does it apply 
to the entire frame?

If rx_copybreak applies to the entire frame and not just the first
buffer (headers or headers+payload if not split) - no preference.
If rx_copybreak only applies to the headers / first buffer then
I'd keep them separate as they operate on a different length.

> I think hds_threshold need to follow new tcp-data-split-thresh value in
> ENABLE/UNKNOWN and make rx-copybreak pure software feature.

Sounds good to me, but just to be clear:

If user sets the HDS enable to UNKNOWN (or doesn't set it):
 - GET returns (current behavior, AFAIU):
   - DISABLED (if HW-GRO is disabled and MTU is not Jumbo)
   - ENABLED (if HW-GRO is enabled of MTU is Jumbo)
If user sets the HDS enable to ENABLED (force HDS on):
 - GET returns ENABLED 

hds_threshold returns: some value, but it's only actually used if GET
returns ENABLED.

> But if so, it changes the default behavior.

How so? The configuration of neither of those two is exposed to 
the user. We can keep the same defaults, until user overrides them.

> How do you think about it?
> 
> >  
> > >       ering->tx_max_pending = BNXT_MAX_TX_DESC_CNT;
> > >
> > >       ering->rx_pending = bp->rx_ring_size;
> > > @@ -854,9 +858,25 @@ static int bnxt_set_ringparam(struct net_device *dev,
> > >           (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
> > >               return -EINVAL;
> > >
> > > +     if (kernel_ering->tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
> > > +         BNXT_RX_PAGE_MODE(bp)) {
> > > +             NL_SET_ERR_MSG_MOD(extack, "tcp-data-split can not be enabled with XDP");
> > > +             return -EINVAL;
> > > +     }  
> >
> > Technically just if the XDP does not support multi-buffer.
> > Any chance we could do this check in the core?  
> 
> I think we can access xdp_rxq_info with netdev_rx_queue structure.
> However, xdp_rxq_info is not sufficient to distinguish mb is supported
> by the driver or not. I think prog->aux->xdp_has_frags is required to
> distinguish it correctly.
> So, I think we need something more.
> Do you have any idea?

Take a look at dev_xdp_prog_count(), something like that but only
counting non-mb progs?

