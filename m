Return-Path: <netdev+bounces-113271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF4993D6CF
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 18:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3721C20FED
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 16:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4129C2E631;
	Fri, 26 Jul 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbI7viO4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178097494;
	Fri, 26 Jul 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010939; cv=none; b=CcpKOEJpA7pzhApTXbVGszYbXFbH1UxIqfZ4X0ooa5YQZ5QdKMu4H051wc09VBtiHfDSZQG37Q50RNKrtL5+w/0xhF0cIGX16CHsiTAO8lQrzwFNmieFDRO+H9gY4vkwDAC3HchL5SS0bmZvcUwYYuu9RHFEhzvg1r7TMO+gkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010939; c=relaxed/simple;
	bh=lblTvaDAdZWaoDjm4grsqYSeFcZn4C14e3juMU4I2nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1CV8y7fiWxtZCWj0nKNCFy8GqRdVuGL6UJeBaMU3H7Lu+R8BSkNmMDWi3WoY73ijELHCD+F790DmnIsOYKhDUWvdgM6zT53CMoG1bLHFpZu0kRWVBWsAhFk1Q0AhOq9SdBiy5+fsqE37N2pvmkOPQ2JmNCtiy5h70NCFrgLJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbI7viO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788AAC4AF07;
	Fri, 26 Jul 2024 16:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722010938;
	bh=lblTvaDAdZWaoDjm4grsqYSeFcZn4C14e3juMU4I2nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbI7viO4hWf6lBQHMjjdE2uCHiBRM7GdPE1YRujJ5Y5kZKTC1B5G/9SgMkhdS00Lk
	 vvNhg5bHGqS0v0/YZDlBh7icODIZ8tgRgEMWG0g5MTkTffjnhk6C7y8xH4EMgfg0/V
	 +GPfg0tzHfdcjnbfdZ1oU9GgHTFI6NgtygRD6WSZc6tNi3VohLE45GH13QDVLCv4ze
	 /YkVIBz1Fzy7d0f6aMgVMDcUxYsG/8HyY/PYfq3lmDoitzGgNwR3VPvIQVhmi/0Upe
	 r+TxYTLUjCqtew/bX4u6P5y8UGo0qGdVNmA0b6YaHiaFYj9zG/sUM9+K+7LP7iO1om
	 wJguVDg4WEZUw==
Date: Fri, 26 Jul 2024 17:22:14 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-net 3/3] idpf: fix UAFs when destroying the queues
Message-ID: <20240726162214.GQ97837@kernel.org>
References: <20240724134024.2182959-1-aleksander.lobakin@intel.com>
 <20240724134024.2182959-4-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724134024.2182959-4-aleksander.lobakin@intel.com>

On Wed, Jul 24, 2024 at 03:40:24PM +0200, Alexander Lobakin wrote:
> The second tagged commit started sometimes (very rarely, but possible)
> throwing WARNs from
> net/core/page_pool.c:page_pool_disable_direct_recycling().
> Turned out idpf frees interrupt vectors with embedded NAPIs *before*
> freeing the queues making page_pools' NAPI pointers lead to freed
> memory before these pools are destroyed by libeth.
> It's not clear whether there are other accesses to the freed vectors
> when destroying the queues, but anyway, we usually free queue/interrupt
> vectors only when the queues are destroyed and the NAPIs are guaranteed
> to not be referenced anywhere.
> 
> Invert the allocation and freeing logic making queue/interrupt vectors
> be allocated first and freed last. Vectors don't require queues to be
> present, so this is safe. Additionally, this change allows to remove
> that useless queue->q_vector pointer cleanup, as vectors are still
> valid when freeing the queues (+ both are freed within one function,
> so it's not clear why nullify the pointers at all).
> 
> Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
> Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")
> Reported-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


