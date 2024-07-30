Return-Path: <netdev+bounces-114232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73F941AFC
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A384B2B2D4
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5145C189502;
	Tue, 30 Jul 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+RR24Tj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284131A6192;
	Tue, 30 Jul 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357432; cv=none; b=H+Huf9nJd/8WZx6ZEN0XADZLFN1/ex/tTLiujWYSBa3D8i0DQ/tRgtlGt5SkeixRwuaEuqIIsjTrgFM8zgIMf0HK1OJCwraTaiCh04t2LQ+E9flUXxZAE2/UNBMzI/T8ak9qwuIlnmUpdSuKNa3X4y8h7bs3u3n0+qC0kG5zFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357432; c=relaxed/simple;
	bh=bxVr8C3E506uZB5bmiS2osb5teqHHgbwQEADek6Rytc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2hd3F+wgqxbdZU2aakk/uKM/xa5EC6N8K6hphfzZN2qEurtN2v6kq4+7/q/xpoWtAeHRFZqekradRk4cyWX/7P8bKKc6e9R1hPVU+EHwBDQcgkgOTfsbb6bbypGw8Ghe5BB9DmU56JI2AuhHHH/c5ja9+FC/W2c6wZ8TUYDqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+RR24Tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E281EC32782;
	Tue, 30 Jul 2024 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722357432;
	bh=bxVr8C3E506uZB5bmiS2osb5teqHHgbwQEADek6Rytc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+RR24TjS9AtJPeSYPZ7XMvdocqiT20L19VuYE1im6SipXXnAMTjpgyWBwtnSdeAl
	 pl1yWdD3uoSXbDLFwQZSUvW64duNcEf+S7c8I5/BoyyosARET1OcXy4gL7W7oD3GWC
	 w+8/TVNGxUl7f3OG+/duaHiz23SBUjeNNDiB/5xK14BD45u8FOHxOv0/IDVys5U9hc
	 QbYWQaYBXOfzXX+dp+zmxiKHU6jzoUvsTEZlcXKLcDWdvnDyZaMNu+B+WDWZmTw64P
	 H3Lp4cIX4hisEH+EEZT46I7k5pvTfFBH9+Xeb9rLFuNZhkmMbxs4vhbk2hpnVfbGSs
	 z8uCZrxep+eiw==
Date: Tue, 30 Jul 2024 17:37:07 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net 1/3] idpf: fix memory leaks and crashes while
 performing a soft reset
Message-ID: <20240730163707.GB1967603@kernel.org>
References: <20240724134024.2182959-1-aleksander.lobakin@intel.com>
 <20240724134024.2182959-2-aleksander.lobakin@intel.com>
 <20240726160954.GO97837@kernel.org>
 <870cd73e-0f87-41eb-95d1-c9fe27ed1230@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <870cd73e-0f87-41eb-95d1-c9fe27ed1230@intel.com>

On Mon, Jul 29, 2024 at 10:54:50AM +0200, Alexander Lobakin wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Fri, 26 Jul 2024 17:09:54 +0100
> 
> > On Wed, Jul 24, 2024 at 03:40:22PM +0200, Alexander Lobakin wrote:
> >> The second tagged commit introduced a UAF, as it removed restoring
> >> q_vector->vport pointers after reinitializating the structures.
> >> This is due to that all queue allocation functions are performed here
> >> with the new temporary vport structure and those functions rewrite
> >> the backpointers to the vport. Then, this new struct is freed and
> >> the pointers start leading to nowhere.
> 
> [...]
> 
> >>  err_reset:
> >> -	idpf_vport_queues_rel(new_vport);
> >> +	idpf_send_add_queues_msg(vport, vport->num_txq, vport->num_complq,
> >> +				 vport->num_rxq, vport->num_bufq);
> >> +
> >> +err_open:
> >> +	if (current_state == __IDPF_VPORT_UP)
> >> +		idpf_vport_open(vport);
> > 
> > Hi Alexander,
> > 
> > Can the system end up in an odd state if this call to idpf_vport_open(), or
> > the one above, fails. Likewise if the above call to
> > idpf_send_add_queues_msg() fails.
> 
> Adding the queues with the parameters that were before changing them
> almost can't fail. But if any of these two fails, it really will be in
> an odd state...

Thanks for the clarification, this is my concern.

> Perhaps we need to do a more powerful reset then? Can we somehow tell
> the kernel that in fact our iface is down, so that the user could try
> to enable it manually once again?
> Anyway, feels like a separate series or patch to -next, what do you think?

Yes, sure. I agree that this patch improves things, and more extreme
corner cases can be addressed separately.

With the above in mind, I'm happy with this patch.

Reviewed-by: Simon Horman <horms@kernel.org>


