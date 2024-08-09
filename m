Return-Path: <netdev+bounces-117229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6035F94D2C1
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDAA280E8E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A290195809;
	Fri,  9 Aug 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfVhjyED"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FAD1922CD
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215486; cv=none; b=g+DQC2pou24SAdAFulZpzKWaBvPtqwJV5U47T1fnSeT/LPMbX5WXN7IrO5rT+LZESAAG2L+rJ69wvWX4BMvmB0dDmNJ3rd6OB4bWiMWdEZc7YcdM2kQ6u0Rgl/d/UBimtKQY2aMfo6SuE4/wWqI7ZxGd/ziYZ/M5zXnd8xUtFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215486; c=relaxed/simple;
	bh=D5+tgFrJS5WL80xFEcHggbuk0m5jwSlZII1VQushVOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5qibSaqev0ZOoTDNFu93EZ7cCmO5eJqAMUVjr6NZEn/A7l+h+H54vtYz2cY5fAPXxjjIa+eo68qUz7wBvmdoCW6CQPOIEoYY3DpYA/N/mGUFpasRKkx6RP7vPzL2Es89VWsIUo2tWAeCFbfBypUpxuAwlk2h8R4SP4Jl28XLJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfVhjyED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF40C32782;
	Fri,  9 Aug 2024 14:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723215485;
	bh=D5+tgFrJS5WL80xFEcHggbuk0m5jwSlZII1VQushVOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfVhjyEDMDl8s0j263lYplhvDGKNb7CYxsPpVYbDKV09pqdlwskzpC6zTqUnsxGOX
	 gN0J3MfMI/QqbZECgytSUEH5bGUg7cGhjun9ezyAG0lNb+WkIhHtdM9b/urCKAujKS
	 ZL/d7KUPFedepCEahZK4o3mE+SwifRddI8jUlI4sXpV8UTaxdhfvVfdQ7wxRWiwJF9
	 4sZCd+N1175bcbR+y0ZEJM9MeJiypGO6lydlbYktKAnKg1Nqp5TCG+fjo4EebRdTQ1
	 brTB562u541HArxNKnURhczxlEcaNC+nyp4veY0BxMVjhfOJajtxovJ1GLx8i0SNy8
	 kvQ5C/xsEyMuw==
Date: Fri, 9 Aug 2024 15:56:29 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, michael.chan@broadcom.com, shuah@kernel.org,
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com, andrew@lunn.ch, willemb@google.com,
	pavan.chebbi@broadcom.com, petrm@nvidia.com, gal@nvidia.com,
	jdamato@fastly.com, donald.hunter@gmail.com,
	marcin.s.wojtas@gmail.com, linux@armlinux.org.uk
Subject: Re: [PATCH net-next v4 02/12] eth: mvpp2: implement new RSS context
 API
Message-ID: <20240809145629.GA1951@kernel.org>
References: <20240809031827.2373341-1-kuba@kernel.org>
 <20240809031827.2373341-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240809031827.2373341-3-kuba@kernel.org>

On Thu, Aug 08, 2024 at 08:18:17PM -0700, Jakub Kicinski wrote:
> Implement the separate create/modify/delete ops for RSS.
> 
> No problems with IDs - even tho RSS tables are per device
> the driver already seems to allocate IDs linearly per port.
> There's a translation table from per-port context ID
> to device context ID.
> 
> mvpp2 doesn't have a key for the hash, it defaults to
> an empty/previous indir table.
> 
> Note that there is no key at all, so we don't have to be
> concerned with reporting the wrong one (which is addressed
> by a patch later in the series).
> 
> Compile-tested only.
> 
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v4:
>  - adjust to meaning of max_context_id from net

Hi Jakub,

Should rxfh_max_num_contexts be used instead?

I'm seeing:

  CC [M]  .../mvpp2_main.o
.../mvpp2_main.c:5794:10: error: ‘const struct ethtool_ops’ has no member named ‘rxfh_max_context_id’; did you mean ‘rxfh_max_num_contexts’?
 5794 |         .rxfh_max_context_id    = MVPP22_N_RSS_TABLES,
      |          ^~~~~~~~~~~~~~~~~~~
      |          rxfh_max_num_contexts


Which seems to make sense in the context of:

- net: ethtool: fix off-by-one error in max RSS context IDs
  https://git.kernel.org/netdev/net-next/c/b54de55990b0

...

