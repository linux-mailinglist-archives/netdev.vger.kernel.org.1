Return-Path: <netdev+bounces-82691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEFC88F3BA
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 01:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0D21C29B14
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 00:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1285EF503;
	Thu, 28 Mar 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6/f5Q0R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2000E545
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585980; cv=none; b=POumATifYVI8WJBo/Q5T6mEP44WDJKKl8YANf0qCWWavmrBx1VTE7T9lV7Fi/CCaWTu8OADtFBaMId/1c7f5+ouOO39RsZhbA0vBhTGorTRKE/ceab7KfU7fqYm8sDb1u+NE+XFkx/Ag5y6qGWEnV9d9gMeGNZCsLw5GDJiegKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585980; c=relaxed/simple;
	bh=jUo3mt5rZFZ8Ro3YBvncx8daqPp5qhgOx6F6tc9We3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5/5CIOZRFAmlDiRvCJJX2qPNgnDmr799DvxatbrrEDRwK8CX8GUCPGUurBzOGVfjqeP7GzFWQqrKrgVrOdXsB4FlV4wyO5/nQTPG2rygUXK/+Tr7dCL96uvpihMMr3s1QDIpbecvfHEYtfwJRlb1bG+0X+yRTezX2VmrwQgyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6/f5Q0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CC1C43390;
	Thu, 28 Mar 2024 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711585979;
	bh=jUo3mt5rZFZ8Ro3YBvncx8daqPp5qhgOx6F6tc9We3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A6/f5Q0RGw3YMstaSwR826klCzbLwKRXPvPcTLRaYTfrozkKzdt8LoBsxtY41CU2i
	 ky3ACs+AMkzcBCH5mtVvil/MTM8u1p9H/1dntsgkul4KFK+jDbTmCmIRB2NOSEkN4s
	 TUMy9BgP58Bpjhl57sISlEP6PCyT3rD8XM/t8MZlIZsWQntZoAbYSf/VRS1vtSUnGK
	 NSl33KDaiifQE7IFYiN1hZsxeFLANbhqE0RPzhkeMTJK+x+XOSAP0n0qQkjHjBn9RM
	 +vm8AjMx2oytSIWhMgAM6jlInWFvMtQje+364+Klyk3fI1/r9czqPT2HaXyTxZ+oZQ
	 Kg7+ODgVl4eIA==
Date: Wed, 27 Mar 2024 17:32:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 "Jason Wang" <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v2 2/2] virtio-net: support dim profile
 fine-tuning
Message-ID: <20240327173258.21c031a8@kernel.org>
In-Reply-To: <556ec006-6157-458d-b9c8-86436cb3199d@intel.com>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
	<1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
	<556ec006-6157-458d-b9c8-86436cb3199d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 15:45:50 +0100 Alexander Lobakin wrote:
> > +/* This is copied from NET_DIM_RX_EQE_PROFILES in DIM library */
> > +#define VIRTNET_DIM_RX_PKTS 256
> > +static struct dim_cq_moder rx_eqe_conf[] = {
> > +	{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
> > +	{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
> > +	{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
> > +	{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
> > +	{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
> > +};  
> 
> This is wrong.
> This way you will have one global table for ALL the virtio devices in
> the system, while Ethtool performs configuration on a per-netdevice basis.
> What you need is to have 1 dim_cq_moder per each virtio netdevice,
> embedded somewhere into its netdev_priv(). Then
> virtio_dim_{rx,tx}_work() will take profiles from there, not the global
> struct. The global struct can stay here as const to initialize default
> per-netdevice params.

I've been wondering lately if adaptive IRQ moderation isn't exactly
the kind of heuristic we would be best off deferring to BPF.
I have done 0 experiments -- are the thresholds enough
or do more interesting algos come to mind for anyone?

