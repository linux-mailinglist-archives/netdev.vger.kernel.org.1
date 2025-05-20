Return-Path: <netdev+bounces-191757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A555ABD1AC
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDC03A6655
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBFC25F792;
	Tue, 20 May 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4rJiZxp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534E25E83D;
	Tue, 20 May 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729090; cv=none; b=aPhVFkmffvWwpG9lOSfE12r3L2eD5PrVPXNBujX0SFF5oD71ls3ZzRq4XNgybHiCqOX80/Fg/IAj6xp63w4ZWSmzR4QZA6132Eam3S2ryRBTs7BZG7Nd3DZd3t5cMdLxSQy9o44cpR/LXgi+T0Fdtvr97DPweVFBlQs2nZjG73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729090; c=relaxed/simple;
	bh=DxUlgsmpbHBG24D6cBXEt3QLKoVyinm5hyxvuANQBJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNdh1WG2EAZ6ZAX1vLcuZNPcTZ8I1T21U/o1puSB1A/RO9oEdPZEbgpJ0BIJLiHml/j9a5P9fCcT/LpDisFPbT6glwNc0yjfTKOUv7453u8bVpAhKiN7o8ebZEjbMzsXLbdGCFZAiOhSOQINoVB1VnZGy4LTiOSby+QuQQmcNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4rJiZxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E95EC4CEE9;
	Tue, 20 May 2025 08:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729089;
	bh=DxUlgsmpbHBG24D6cBXEt3QLKoVyinm5hyxvuANQBJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4rJiZxpyaAUKheOAiF5N9P6A+d4PF5BLYLxvu78HXSt/w+yUQE1ANBhp+xiVe5ek
	 bRX49Ev1BYl7Se75jUAuoyte6F8jKak55wVCwq7UqJmSz95Dolv+rpjg38YNxKWC6B
	 bvbGd0PV5t8CENWcSvz2LFiWsoMAN63MRcHALwg+b3cGZ31Iwj/rYzWMdkkejlddOD
	 JAI1cMN+WZkyqAGBbvd0/wwdUdz6gOOyGni1PgOr41VkjkiwEFSKf5uAzyu4Ao6hU0
	 KDifMpAQjC7O/Oqio2S8bngB7gTugyJvgTNhFi0aYYbnv4PeNYPiZp3hly7T+hBTzh
	 pRGSz+855cF8g==
Date: Tue, 20 May 2025 09:18:05 +0100
From: Simon Horman <horms@kernel.org>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: Re: [PATCH iwl-next v3 6/7] igc: add preemptible queue support in
 taprio
Message-ID: <20250520081805.GR365796@horms.kernel.org>
References: <20250519071911.2748406-1-faizal.abdul.rahim@intel.com>
 <20250519071911.2748406-7-faizal.abdul.rahim@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519071911.2748406-7-faizal.abdul.rahim@intel.com>

On Mon, May 19, 2025 at 03:19:10AM -0400, Abdul Rahim, Faizal wrote:
> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> Changes:
> 1. Introduce tx_enabled flag to control preemptible queue. tx_enabled
>    is set via mmsv module based on multiple factors, including link
>    up/down status, to determine if FPE is active or inactive.
> 2. Add priority field to TXDCTL for express queue to improve data
>    fetch performance.
> 3. Block preemptible queue setup in taprio unless reverse-tsn-txq-prio
>    private flag is set. Encourages adoption of standard queue priority
>    scheme for new features.
> 4. Hardware-padded frames from preemptible queues result in incorrect
>    mCRC values, as padding bytes are excluded from the computation. Pad
>    frames to at least 60 bytes using skb_padto() before transmission to
>    ensure the hardware includes padding in the mCRC calculation.
> 
> Tested preemption with taprio by:
> 1. Enable FPE:
>    ethtool --set-mm enp1s0 pmac-enabled on tx-enabled on verify-enabled on
> 2. Enable private flag to reverse TX queue priority:
>    ethtool --set-priv-flags enp1s0 reverse-txq-prio on
> 3. Enable preemptible queue in taprio:
>    taprio num_tc 4 map 0 1 2 3 0 0 0 0 0 0 0 0 0 0 0 0 \
>    queues 1@0 1@1 1@2 1@3 \
>    fp P P P E
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Co-developed-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


