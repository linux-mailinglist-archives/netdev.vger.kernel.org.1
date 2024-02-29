Return-Path: <netdev+bounces-76010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8271A86BFA5
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41941C2292B
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 03:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37536376E9;
	Thu, 29 Feb 2024 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ89az6w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143FF376E0
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178770; cv=none; b=B+znz6atQIHmSyD/630dROwXb4OXEBf6f/50rR+4hKArTfOhcITx/Ubo+hNxkXMqGVaG3Bl7PjsvRmDA2xPFRdm0bk/lbCj8k/+kP7EVWd2m/bBxLiMi7g2zyE59FmDl3Uv72hfwTzyV2azxwzKw5idps0z7Usgp6saNEQaoEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178770; c=relaxed/simple;
	bh=hTxZIbMI8Uqg+4KxRRy7oqmMMMTNhqvrUHbi7bZVK9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJblrcUral2J6gA6e5CmdosKTPlGuylY+5cDBSb9wEla8habjdS7E3dojDsabkpEirXRp0H8hjs/yCJh7JE2y995ajyKplu9knvH/xmN7nDlQnvUPrrsBpGOPSx1vvcb/JVwp+rktqtzR2dkh+Lxn7FVkvrToX76QfXa6dh1l04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ89az6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD89C433F1;
	Thu, 29 Feb 2024 03:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709178769;
	bh=hTxZIbMI8Uqg+4KxRRy7oqmMMMTNhqvrUHbi7bZVK9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DQ89az6w8Lbfa7QaSSL9NINYQ7JWMrEZOHoLNDiAj9DuSx3cZ0K4bzM23v3H0dQqX
	 Ck94uYP32qiVTEBJSSsQxEQt5L+APh49lhyVWcViRangtMcH5b0CJMA2M/vH/nvYCL
	 cjZITfNvI+cU8eHWU7FSY99D0tq9IRIXxeGpTJlkLb1qXsCdPa+SQE+jK/qavIkiVk
	 15Kw++WlkKZvFjA88uX5yJ7Hh6eXLkuFdAuZ6OTipDdW+5bVjrRGvdK4oohIPYaidn
	 9aVikyihsU290i3YL16m4slBFnU7+Coo68gC527W3wY7i/hgok782Cz6lvz/P9o8MV
	 m9O3yIznFb22A==
Date: Wed, 28 Feb 2024 19:52:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, amritha.nambiar@intel.com, danielj@nvidia.com,
 mst@redhat.com, sdf@google.com, vadim.fedorenko@linux.dev,
 przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next v2 3/3] eth: bnxt: support per-queue statistics
Message-ID: <20240228195248.3523513e@kernel.org>
In-Reply-To: <CACKFLin4dUL9eOrH_=sZpc26ep5iZe5mgOHAxyWEAHwVWuASTQ@mail.gmail.com>
References: <20240229010221.2408413-1-kuba@kernel.org>
	<20240229010221.2408413-4-kuba@kernel.org>
	<CACKFLin4dUL9eOrH_=sZpc26ep5iZe5mgOHAxyWEAHwVWuASTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 19:40:01 -0800 Michael Chan wrote:
> > +static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
> > +                                   struct netdev_queue_stats_tx *stats)
> > +{
> > +       struct bnxt *bp = netdev_priv(dev);
> > +       u64 *sw;
> > +
> > +       sw = bp->bnapi[i]->cp_ring.stats.sw_stats;  
> 
> Sorry I missed this earlier.  When we are in XDP mode, the first set
> of TX rings is generally hidden from the user.  The standard TX rings
> don't start from index 0.  They start from bp->tx_nr_rings_xdp.
> Should we adjust for that?

I feel like I made this mistake before already.. Will fix, thanks!

