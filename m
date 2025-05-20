Return-Path: <netdev+bounces-191924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E6BABDE4F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB6D7ACEAD
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDC4252901;
	Tue, 20 May 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYkKFlz0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B37251798
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753585; cv=none; b=O09biTsorV/kOjRIowRmw21bp6OCyQkn3kXJuFRY+bgRvTZrFVnHwki8UO/Qgq7D0Xg0ej8gvlKPftrHd52EhyJs6A7AzxRRERJ+ZON+ioY/Ut89YsTcw+b4T91jP5iuvDEB0BMRK9oCcr09dj6TVale+ZZ9XOchMzkIzjfvY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753585; c=relaxed/simple;
	bh=QPww7qfnARV4leuhCvCGrKI8AvKvoSsWTFouBCCaPYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1hO6T/8p5XUlzuJIuOQDtz9UtfBCXk/+a546mfjb3MauLLx3P95RI12bCMuH7hDlECPlJ9HOsbVyT+3JJRB92qy5UmkH5jnYA32LrUZeiJ48oToGpPhxk8rISuMYEV91yD9b+hhtP61TUNET+bXoJlCql3/2dV0TKJ3AxB/01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYkKFlz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A8AC4CEE9;
	Tue, 20 May 2025 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747753584;
	bh=QPww7qfnARV4leuhCvCGrKI8AvKvoSsWTFouBCCaPYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYkKFlz05LorMAQjWfbGoFgphE5bSvssPZrHSMcxp2PLiv/LZ/55B8+bmbpDaaDgr
	 eXU9T0cov/p234n5pZ2gLpMnU1xzvhmwzacKffXLQJl7O9qg0kE1m3y5h9fHNZdiEE
	 N1xYctwNV3M2ikgaF/Q092IRUOZFmWiSILwmcfq954oBQwikabGUFOnzzoSNTTDTQd
	 jBPrIxaXR8tXdN7Li0Y/Z/Y35V6zrLbmpkyFLdk3mINMt5KCD9KiG342IAqM6De3eH
	 RrsE1S6e9oLGqKib8Hkego9d+NCW4Q0tXkIW+oPr+ePWfMN8MTQstQAZJzpkGd/cnM
	 sE1ySX6kiOeqw==
Date: Tue, 20 May 2025 16:06:19 +0100
From: Simon Horman <horms@kernel.org>
To: Krishna Kumar <krikku@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, edumazet@google.com,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com,
	ahmed.zaki@intel.com, krishna.ku@flipkart.com
Subject: Re: [PATCH] net: ice: Perform accurate aRFS flow match
Message-ID: <20250520150619.GZ365796@horms.kernel.org>
References: <20250520050205.2778391-1-krikku@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520050205.2778391-1-krikku@gmail.com>

On Tue, May 20, 2025 at 10:32:05AM +0530, Krishna Kumar wrote:
> This patch fixes an issue seen in a large-scale deployment under heavy
> incoming pkts where the aRFS flow wrongly matches a flow and reprograms the
> NIC with wrong settings. That mis-steering causes RX-path latency spikes
> and noisy neighbor effects when many connections collide on the same has
> (some of our production servers have 20-30K connections).

...

> 
> Signed-off-by: Krishna Kumar <krikku@gmail.com>

Hi Krishna,

As a fix if this should probably have a Fixes tag.

And it would be useful to denote the target tree in the subject.

E.g. [PATCH iwl-net] ...

> ---
>  drivers/net/ethernet/intel/ice/ice_arfs.c | 45 +++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
> index 2bc5c7f59844..b36bd189bd64 100644
> --- a/drivers/net/ethernet/intel/ice/ice_arfs.c
> +++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
> @@ -377,6 +377,47 @@ ice_arfs_is_perfect_flow_set(struct ice_hw *hw, __be16 l3_proto, u8 l4_proto)
>  	return false;
>  }
>  
> +/**
> + * ice_arfs_cmp - Check if aRFS filter matches this flow.
> + * @fltr_info: filter info of the saved ARFS entry.
> + * @fk: flow dissector keys.
> + * n_proto:  One of htons(IPv4) or htons(IPv6).
> + * ip_proto: One of IPPROTO_TCP or IPPROTO_UDP.

nit: A '@' is required to document function parameters.

 * @nproto: ...
 * @ip_proto: ...

> + *
> + * Since this function assumes limited values for n_proto and ip_proto, it
> + * is meant to be called only from ice_rx_flow_steer().

Please also document the return value using "Return: " or "Returns: ".

Flagged by ./scripts/kernel-doc -Wall -none

> + */

...

