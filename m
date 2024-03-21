Return-Path: <netdev+bounces-81048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AA2885947
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 13:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FB21C21554
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92283CAA;
	Thu, 21 Mar 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugl2Z8fv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B28B83CB1;
	Thu, 21 Mar 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024946; cv=none; b=Ol1LihAwiIiF4cLhiJTWtzk05ePraJ3H2hgsHb+UvZtOM6U1yGkzRsFvdua0VfbSYDVLO0kARfICLA2f+Jl8Et3SBshUkIiQIPcCVU1SKoIlZeOXnpsM1LG077fKmp70mJlwegX1zOGGEEDBlNo4X7CE5l/qseh/nFjpYcrGAOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024946; c=relaxed/simple;
	bh=4L1mImHIJn/5ij9Hza2dN0P8w+LD4aIzTC2/Uq/6rl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQMypzjnbC077nQ0RZgyp1ScNqQWtpF9tgFWjXgo/TrqbQEAEHFMMLbgluUqHz39PdNhJFx9rvLvVnG1J3l4SyAl6R+Pod+IBvIox8LmY1oj4AaJrW5J+TAiY8N7Q53JN7SJl2XehyiTYCY4wrkgHtsBWMvxmVfQN1C9+kAnRlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugl2Z8fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20DCC433F1;
	Thu, 21 Mar 2024 12:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711024945;
	bh=4L1mImHIJn/5ij9Hza2dN0P8w+LD4aIzTC2/Uq/6rl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ugl2Z8fvJFURguYqJPEFzWEPyKrQ4TffJDxZ6C+d0U4czwvuXj0o+dnF82indBDtv
	 2aCFb9V826WNgqcSuWpf6DaKRahEOSAVlOkjjhueAjbak3IpjnLKgna/S9xWNWYnkC
	 XwiStrhg4CxWNwbwMMNc10Q2mi6v011fo+13hE+Esn2PW2cINblBLbylM/Jdt9Su2t
	 Jxp8R2gpI52OXTc6pWekXcCgZTEgk2ildWTmifzJQtLOadsOcEY8G5b1fZZqrVwZAN
	 G2y8nQ7AwTMUxXGVacIoAQRG8I6fFb7/h9rQMe7lPkX4ub5BSAGgUmBnR4SALzLTwL
	 gWhPl5MOxb1bg==
Date: Thu, 21 Mar 2024 12:42:19 +0000
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, "David S.  Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"Michael  S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Message-ID: <20240321124219.GC356367@kernel.org>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <Zfgq8k2Q-olYWiuw@nanopsycho>
 <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>
 <ZfgxSug4sekWGyNd@nanopsycho>
 <316ea06417279a45d2d54bf4cc4afd2d775b419a.camel@redhat.com>
 <1710921861.9268863-1-xuanzhuo@linux.alibaba.com>
 <20240320203801.5950fb1d@kernel.org>
 <1710993274.7038217-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710993274.7038217-1-xuanzhuo@linux.alibaba.com>

On Thu, Mar 21, 2024 at 11:54:34AM +0800, Xuan Zhuo wrote:
> On Wed, 20 Mar 2024 20:38:01 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Wed, 20 Mar 2024 16:04:21 +0800 Xuan Zhuo wrote:
> > > I have a question regarding the workflow for feature discussions. If we
> > > consistently engage in discussions about a particular feature, this may result
> > > in the submission of multiple patch sets. In light of this, should we modify the
> > > usage of "PATCH" or "RFC" in our submissions depending on whether the merge
> > > window is open or closed? This causes the title of our patch sets to keep
> > > changing.
> >
> > Is switching between RFC and PATCH causing issues?
> 
> You know someone may ignore the RFC patches.
> And for me, that the pathsets for the particular feture have differ
> prefix "PATCH" or "RFC" is odd.
> 
> > Should be a simple modification to the git format-patch argument.
> 
> That is ok.
> 
> 
> > But perhaps your workload is different than mine.
> >
> > The merge window is only 2 weeks every 10 weeks, it's not changing
> > often, I don't think.
> 
> YES. I'm ok, if that is a rule.

Hi,

Maybe this helps:

It is a long standing rule that for netdev, during the merge window,
net-next is closed. During this time bugfixes may be posted (for net),
and RFCs may be posted.

https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow

