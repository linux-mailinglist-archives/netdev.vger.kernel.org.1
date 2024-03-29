Return-Path: <netdev+bounces-83352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B35D089210C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBF1B2E5E1
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A313B599;
	Fri, 29 Mar 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP8gZviH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3013B597
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725486; cv=none; b=cusmNSreOKi7NHIqVNUpjYqidCCGLawmnCobEoSZPWAuTVmcQR4DS9SFVA/1V68l4kxbh8VvcS/rz8FKLXz9q4/0RAD5fU/H/3JxP9LO9a+YXnv6XJv04IhQ8HJOfAjIHnDRXWSl+ym3ZyzyTP8EpjbgY3Xb/Um8qqdUzXbx8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725486; c=relaxed/simple;
	bh=wzGZCQzwX1Ftqc63B40ztgOrHXwDHFU2pj0Tc+cfMPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIieVBZQopjZW+y78F2DKmeRtAQQ3Lm9yDjiRQjmWCivMNjEOH9uBmBJPEirWIBeQOuTb8e9evhPKp2LUW3xqvAEqCDNVvLgk0RzNGyYIKR/QE7gU3Nar86sjiQm3wJiaS1/9f3rFQt+4MKrZx3sA3hAp0RU4ihxpNpZnYyoJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP8gZviH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39104C433F1;
	Fri, 29 Mar 2024 15:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711725485;
	bh=wzGZCQzwX1Ftqc63B40ztgOrHXwDHFU2pj0Tc+cfMPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eP8gZviHRdV7xG+nfLy6hIiB9djNmkQBPMAnvVQR93lUuAMSILWA3+OBpruh+ZMQH
	 6hlcZ5JQBvldA6eU+00NAY4f1ixBr53vNYloNfrzRpgu157JQGrAhaOsF96JjMjXij
	 37V2CT06iCw3SrA6Cxq1FxsmNUZInPfOdudUDuDPGVDzhAstnPcoYevvm3KZefijHB
	 5jESVbLk8tXUccDdIEu5u7B+998Iy4AV/aePCd+PDTlRiTMvWZe/KEouOn44NPYeLU
	 P6QvH99Y8ndoiiTLxkt45iZJQG9yj0Oaz0sKtnROMvNG94o66ZG7v/MfGckDzUhiLk
	 y/hY+DNKr8qbA==
Date: Fri, 29 Mar 2024 08:18:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "David S.
 Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, vadim.fedorenko@linux.dev, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 2/2] virtio-net: support dim profile
 fine-tuning
Message-ID: <20240329081804.1b7de830@kernel.org>
In-Reply-To: <7e54d23c-caa6-4bbd-aef6-26ed6a9dd889@linux.alibaba.com>
References: <1711531146-91920-1-git-send-email-hengqi@linux.alibaba.com>
	<1711531146-91920-3-git-send-email-hengqi@linux.alibaba.com>
	<556ec006-6157-458d-b9c8-86436cb3199d@intel.com>
	<20240327173258.21c031a8@kernel.org>
	<1711591930.8288093-2-xuanzhuo@linux.alibaba.com>
	<20240328094847.1af51a8d@kernel.org>
	<7e54d23c-caa6-4bbd-aef6-26ed6a9dd889@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 16:56:12 +0800 Heng Qi wrote:
> > About the uAPI - please make sure you add the new stuff to
> > Documentation/netlink/specs/ethtool.yaml
> > see: https://docs.kernel.org/next/userspace-api/netlink/specs.html
> >
> > And break up the attributes, please, no raw C structs of this nature:
> >
> > +	return nla_put(skb, attr_type, sizeof(struct dim_cq_moder) *
> > +		       NET_DIM_PARAMS_NUM_PROFILES, profs);
> >
> > They are hard to extend.  
> 
> Sorry, I don't seem to get your point, why does this make extending hard?

It's not possible to make some fields optional later on.
It's also possible that user space will make assumptions about the size
of this struct so we won't be able to add fields.

So it's preferred to render the C struct members as individual netlink 
attributes. Look around ethtool netlink, you'll see there are no
structs dumped.

> Are you referring to specifying ETHTOOL_A_COALESCE_RX_EQE_PROFILE
> as a nested array, i.e. having each element explicitly have an attr 
> name? or passing the u16 pointer and length as arguments?


