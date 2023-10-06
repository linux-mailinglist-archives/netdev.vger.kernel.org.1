Return-Path: <netdev+bounces-38685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB17BC21C
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8773028228C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 22:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A594450FF;
	Fri,  6 Oct 2023 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9ZWMCw6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2247450FC
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 22:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39882C433C7;
	Fri,  6 Oct 2023 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696630487;
	bh=VQscCT1FF5BIhomC2IAQhNeDuLDU8zvde1vv2WzmG5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S9ZWMCw6+Xe8MMCmPAJgBn2uDmjTHh2B4nVNB3a+lDa7FPahDhvLXq9yAX2Jk8ZWW
	 hfdDfrf0eNOu57QU8wOR8PlC2rESPPVEOFldHiw0RrNlrBsaHoY3yDY80PdhJtrs2Q
	 rdUfOvAc7DcR7T7bwcP+qBGBix+AcGnTZFzBMtZ42mhYGIWzIIKou4s01IPE02U3vt
	 Lqmr+SgJMjhciBbn8X2CioCJNUI45reyAELQVRFQhZ/qMEHE8+agGxXnkoU1lHz5Lj
	 sqBqNAk+yRpHGNcvDrQ6tBE8w9bsAvf12o6mkxcRzel2DkoTNVGIFtcSi6XO9KnFfD
	 7aHQw54R3JTDQ==
Date: Fri, 6 Oct 2023 15:14:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <20231006151446.491b5965@kernel.org>
In-Reply-To: <ZSA+1qA6gNVOKP67@nanopsycho>
References: <20231003074349.1435667-1-jiri@resnulli.us>
	<20231005183029.32987349@kernel.org>
	<ZR+1mc/BEDjNQy9A@nanopsycho>
	<20231006074842.4908ead4@kernel.org>
	<ZSA+1qA6gNVOKP67@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Oct 2023 19:07:34 +0200 Jiri Pirko wrote:
> >The user creates a port on an instance A, which spawns instance B.
> >Instance A links instance B to itself.
> >Instance A cannot disappear before instance B disappears.  
> 
> It can. mlx5 port sf removal is very nice example of that. It just tells
> the FW to remove the sf and returns. The actual SF removal is spawned
> after that when processing FW events.

Isn't the PF driver processing the "FW events"? A is PF here, and B 
is SF, are you saying that the PF devlink instance can be completely
removed (not just unregistered, freed) before the SF instance is
unregistered?

