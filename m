Return-Path: <netdev+bounces-101997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9599010A9
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 11:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D561C21327
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797F317836C;
	Sat,  8 Jun 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWLgm9tK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8417836D
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837286; cv=none; b=fAUKwwpR+oYqTtsBxGcl3NEZJAYiL1knIJvb7IYNNmZreVttdhT6GhQCo6/rXp10wuKO9OjUyo2V9OvbeHln/+2xpF/yGg7e9yDX3et1FdM7GxqbwJ1NKVvy7/J0ivgChlC1ynCe9nryQXTL4GNNW5rGpjMIbC65uEtngpSuT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837286; c=relaxed/simple;
	bh=4m2+/xWjTHXGW3kJYE4Tr2TVOKWT+/xFH6qrZ/ywwoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnF+iwRbFloLpHbSt/YCMSebdtGOGpt1jZPhDlt4G1x4S2HsTzRDhJHID1C0TdNsG7gOm3Vsj/j/Ocec/LKrjwlnmj4HYKA2VCFYME5vnWKIvOSKCbyCVC1tUmKxSRRBRY/qeI6dbGwX0XQN5ECM71LXvJInCFKnWgl+gnbeiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWLgm9tK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89E9C4AF08;
	Sat,  8 Jun 2024 09:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837286;
	bh=4m2+/xWjTHXGW3kJYE4Tr2TVOKWT+/xFH6qrZ/ywwoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWLgm9tKbWP4sqeXmkwsj1SDJshEeSTmCFKyWkpsRqf+rVFBEGC37QYt2zjqvSRGA
	 jU/eXL1otzfuPoZoVv6yt2eRIpFlKWgYPVW8hfga9wGYOw1LjNgFV5wQYZMkRrlBod
	 nF6f1tFvWYIvol7PiN2nItR1+HPDREFCsMBZHh2XJzrhmwaIdZOuvVQN4UqvtbOmM5
	 htABuFoeqFQkErD3cUYsV54HMYPG97Tbb8/v6PtsnJmX4UnHkSYF7iH3BpfPyCKGpf
	 DTLP1izrfWGHY14dDv+b0dH8Fnd13xv/hXlm5KqFnU3fKiFXWm2CkwZzvKW/Y+7oMr
	 UBArT8Kn+JCZQ==
Date: Sat, 8 Jun 2024 10:01:21 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Alexander Zubkov <green@qrator.net>, mlxsw@nvidia.com
Subject: Re: [PATCH net 6/6] mlxsw: spectrum_acl: Fix ACL scale regression
 and firmware errors
Message-ID: <20240608090121.GP27689@kernel.org>
References: <cover.1717684365.git.petrm@nvidia.com>
 <94b8fd1b4c4db16c7df0bb5ecdba731b1d45d4c5.1717684365.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94b8fd1b4c4db16c7df0bb5ecdba731b1d45d4c5.1717684365.git.petrm@nvidia.com>

On Thu, Jun 06, 2024 at 04:49:43PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> ACLs that reside in the algorithmic TCAM (A-TCAM) in Spectrum-2 and
> newer ASICs can share the same mask if their masks only differ in up to
> 8 consecutive bits. For example, consider the following filters:
> 
>  # tc filter add dev swp1 ingress pref 1 proto ip flower dst_ip 192.0.2.0/24 action drop
>  # tc filter add dev swp1 ingress pref 1 proto ip flower dst_ip 198.51.100.128/25 action drop
> 
> The second filter can use the same mask as the first (dst_ip/24) with a
> delta of 1 bit.
> 
> However, the above only works because the two filters have different
> values in the common unmasked part (dst_ip/24). When entries have the
> same value in the common unmasked part they create undesired collisions
> in the device since many entries now have the same key. This leads to
> firmware errors such as [1] and to a reduced scale.
> 
> Fix by adjusting the hash table key to only include the value in the
> common unmasked part. That is, without including the delta bits. That
> way the driver will detect the collision during filter insertion and
> spill the filter into the circuit TCAM (C-TCAM).
> 
> Add a test case that fails without the fix and adjust existing cases
> that check C-TCAM spillage according to the above limitation.
> 
> [1]
> mlxsw_spectrum2 0000:06:00.0: EMAD reg access failed (tid=3379b18a00003394,reg_id=3027(ptce3),type=write,status=8(resource not available))
> 
> Fixes: c22291f7cf45 ("mlxsw: spectrum: acl: Implement delta for ERP")
> Reported-by: Alexander Zubkov <green@qrator.net>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


