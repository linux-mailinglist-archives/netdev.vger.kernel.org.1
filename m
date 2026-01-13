Return-Path: <netdev+bounces-249444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E13D19174
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A29F8300F8B2
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08738BF6A;
	Tue, 13 Jan 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ0wuhy9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EED349B19
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768310814; cv=none; b=Fv809DowfKQniW/aW8tS3XpRNWjlMM6PLsU9AqqvALPGZaWCv5HeOjIQwVkLd7sUHLX8s9wB4LpP7NnzAvU/HU6g1AcIfTM3yPHdDFJg/XOK088yppaYc4uy3UYkdyXsJN/i1t/bbXRP69uZEzTTbA+PCnIVOo6wQK/c6B1cFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768310814; c=relaxed/simple;
	bh=5eSbp2YejVlQwsJ4Tq8iaUtRuMK3R0vtPTKJ4VgmURA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld2aVJcLC9vqIaYK8ScqvcW9+4UV66EflaBTTtBUbQjb8cspqhW8thdFm10T7U02Za29LPS7phzPVed6rWPau3KKYJJMIuOAwLTVSHWpW9PdN0JEYN3qvrv5TN9ajkcUbgy9aPH6ZD9/4756tG6uC6rgM/pjUVCvf6I6keoowzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ0wuhy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F45C116C6;
	Tue, 13 Jan 2026 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768310813;
	bh=5eSbp2YejVlQwsJ4Tq8iaUtRuMK3R0vtPTKJ4VgmURA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZ0wuhy9YZyNvVi22+zuJIOVkP0qOSxF3UNW2yaaxZbmn9qHW627aYg/NdHLqT+Kj
	 3qC6OdpuIVsYKkIlh/zuE9bQHG8LXIJ8sAvY8t8ll7TyjiWMIJHh3W8T9qtKAJlD9X
	 JMbnODszUYAWs0x0jwDD0GGhM8dGIj8iUf54gT8poFdNT9QKOSKW+XODF/tFQ95ZgM
	 826aWti8Ov0pCK1ZnQDPtL3tos/X9RVwDwkEjhCbrd+xBqCgJyd0R9T+evPrlD3ufw
	 Br7yo18JqRrnINxfdLvyNCvTX+JgGdmtLneogsJJAjc96TtI3zmxbcpTGK8T4frOxX
	 u9eusivCcfW9w==
Date: Tue, 13 Jan 2026 13:26:49 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: Fix schedule while atomic in
 airoha_ppe_deinit()
Message-ID: <aWZIGbwN1fdHCgnb@horms.kernel.org>
References: <20260105-airoha-fw-ethtool-v2-1-3b32b158cc31@kernel.org>
 <20260108132218.GG345651@kernel.org>
 <aWDLg6RzI4s2VgIH@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWDLg6RzI4s2VgIH@lore-desk>

On Fri, Jan 09, 2026 at 10:33:55AM +0100, Lorenzo Bianconi wrote:
> > On Mon, Jan 05, 2026 at 09:43:31AM +0100, Lorenzo Bianconi wrote:
> > > airoha_ppe_deinit() runs airoha_npu_ppe_deinit() in atomic context.
> > > airoha_npu_ppe_deinit routine allocates ppe_data buffer with GFP_KERNEL
> > > flag. Rely on rcu_replace_pointer in airoha_ppe_deinit routine in order
> > > to fix schedule while atomic issue in airoha_npu_ppe_deinit() since we
> > > do not need atomic context there.
> > 
> > Hi Lorenzo,
> 
> Hi Simon,
> 
> > 
> > If I understand things correctly the key problem here is that
> > an allocation with GFP_KERNEL implies GFP_RECLAIM and thus may sleep.
> > But RCU read-side critical sections are not allowed to sleep in non-RT
> > kernels.
> 
> yes, right, RCU section is atomic.
> 
> > 
> > If so, I think it would be clearer to describe the problem along those
> > lines. But maybe it is just me.
> 
> This patch is already in Linus's tree.

Yeah, sorry for missing that.



