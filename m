Return-Path: <netdev+bounces-131227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9213398D643
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB9728218A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0261D0782;
	Wed,  2 Oct 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3DIN3FN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ACB18DF60;
	Wed,  2 Oct 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876275; cv=none; b=NnzUDvB27E/CLVztIMNYh/GZroTcHxSbMvyhDhXZOKIKVejamEANJcMvZyI14FhR5qWgT+RFTZJqrbs86Zv3UZQBSfjiHh+cMceRqeATNes7QhAdXFphfbTPX6UqlpPR1B2fHlmfgB9RapwqVOxKtBRbDm6OrXLZVTizD2jZWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876275; c=relaxed/simple;
	bh=UIk+sKKgmTVaSNGGKPXcCN7REBOqYGzQC7fY6fzjaa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3EiTZGJUM47/+aKR3H0fI8Wb2XJw5AKG0bEClpGejwPaghsC4ouYhV60UWyJ/1xR0yzQMfLTH3NNaoT5dFsvSm0Q1JrccknRD72CRCmthCvmrHw5DjQVJ9fAnA5k1lTMIuLqoaM2AfPJSwVEqTjhkeaXoSAK7Nrri2xbw4/124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3DIN3FN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ADDC4CEC5;
	Wed,  2 Oct 2024 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876275;
	bh=UIk+sKKgmTVaSNGGKPXcCN7REBOqYGzQC7fY6fzjaa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3DIN3FNpTuWJU3x++2Z34+rkoaemP/WP6lF2T+2CfXLvbqCENBT1MTSza8KQs9T2
	 hPFCwsdHVOR5I+qPJVJ9rw/tR1rhbaBxUPLR74FpbtOuoMOjXIBg3HHS0LFjQKpbHc
	 MpofzZxN8rj30Ay4yIB/lsFLPP3GICMp13o1LwcoHP44iG8Wyu2ISJuowJMrauxdUT
	 62sdguOHySNU37VyzPC9UkPQ24s7awdDINL3jh3Y4tW5KPyHW09AODMP9KFsd3ER6Q
	 HSTNzYCH5u/68jTMEE4UWdfT/jCdUHyqhhLHU4fM0wKsAawp3NuvUBMo8wH8j9rZOd
	 26h5yjGhKJVtA==
Date: Wed, 2 Oct 2024 14:37:49 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 04/12] net: vxlan: add skb drop reasons to
 vxlan_rcv()
Message-ID: <20241002133749.GA1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-5-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-5-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:17PM +0800, Menglong Dong wrote:
> Introduce skb drop reasons to the function vxlan_rcv(). Following new
> drop reasons are added:
> 
>   SKB_DROP_REASON_VXLAN_INVALID_HDR
>   SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND
>   SKB_DROP_REASON_IP_TUNNEL_ECN
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


