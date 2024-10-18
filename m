Return-Path: <netdev+bounces-137025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056B29A40A5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B7C1C2542F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D718E37A;
	Fri, 18 Oct 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjSYKlv5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22540127E18
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260345; cv=none; b=u4qS4sNNtzRCqnCCvSAoHwH+gXGI1j4PvA99jR3VaeNGM2N2WFB/Gw7RR1kf79BpfAk69dseRp2Xap0mNlDW6G5pI/G4BX3UDP7z12fjYSwGrtC9A0p/KNBKeio2mLqR9DylaOR6ofSqzX0knHqqhDOsG4OwIiH8l+OjDYBJYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260345; c=relaxed/simple;
	bh=iXCl0oShyxfnIqy8Qwy6m/wFyVH1tT8rH/GuSX1mfpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWx0a2v2jBxMRRFHkKSao3NmKEIL424/9fn3yhBHA/PJrSRp/KOFF+ljR9dveWPWDtAW5EwHo79Mswv8fbWMAPU+3iCaT83ef+OGh8vLiMNnpiyVLVJGg3NqWj2s/puu8xPZ6jDh3iCakAuCyt1xtasr0aN2+oDX0O7k9RcsFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjSYKlv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86288C4CEC3;
	Fri, 18 Oct 2024 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260345;
	bh=iXCl0oShyxfnIqy8Qwy6m/wFyVH1tT8rH/GuSX1mfpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjSYKlv5coTbFbYPV+5OKFmoHzCspPX/Nh7AamJi2bamEm3Tcux4gzXoPMyU4VBxq
	 vW6swatAoT3vUfWWJVCqnO5mnJ3YE/Kbov98W4FbPxAGvXZGwhRNWnor9Y/rxOpRkZ
	 JNqFCeBO2DCyWcHokZnt+Fmi5O4n/YgowXW8LHg35pZCYItDUzAI9MiJmx1fAamTDo
	 R6BMcQ/OrnEejRceM+Is5QGPqWYK5l8QiOmHLSox5gQfps9HTApLUelsGA8pWuSpp+
	 OAVlai8tKnttq0W2t2pcQn8vtICWeti1Wd0y5vnNZcrCv3R+C8zZiUfX+Rx44lGwQW
	 RztbVwvQ6QDHA==
Date: Fri, 18 Oct 2024 15:05:41 +0100
From: Simon Horman <horms@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: sysctl: allow dump_cpumask to handle
 higher numbers of CPUs
Message-ID: <20241018140541.GN1697@kernel.org>
References: <20241017152422.487406-1-atenart@kernel.org>
 <20241017152422.487406-4-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017152422.487406-4-atenart@kernel.org>

On Thu, Oct 17, 2024 at 05:24:19PM +0200, Antoine Tenart wrote:
> This fixes the output of rps_default_mask and flow_limit_cpu_bitmap when
> the CPU count is > 448, as it was truncated.
> 
> The underlying values are actually stored correctly when writing to
> these sysctl but displaying them uses a fixed length temporary buffer in
> dump_cpumask. This buffer can be too small if the CPU count is > 448.
> 
> Fix this by dynamically allocating the buffer in dump_cpumask, using a
> guesstimate of what we need.
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


