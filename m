Return-Path: <netdev+bounces-189066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D2BAB0348
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 21:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24501C21917
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26E8288C23;
	Thu,  8 May 2025 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnsYSgVY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF39F288C0F
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730808; cv=none; b=GAAO1Q70ivNqonvtVsMZAhhuCVMvrag30EMTNP0oOY7rW9nuBWOTWl41HkLHazIUi5k3xZqq3Z6iLmWbnc5DqGJQta36vK823fFNxrALfB3Ldt+19p53P2g+fmbLghh23bnuz/Wqwka2jOrXiBucoKIHqX4Ash7SBaJkMsANtZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730808; c=relaxed/simple;
	bh=upd4BA2+NUQKOAJi4k+ZVCYsV3o6gMhNujVJ1Cd2Www=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6Tqc28fzHuuqSgtw0iXmKh5EvsWbeG2Gfcb8NwtwoiYP/MGKLHiPCcrNCt7CVBMHoG+enRWxrzvMF6ciMabS2BTznS3/ZkY4lvULQYUiQssSRDQOm4YMrJE2IJygPd00tsVtSUbG/FqTYmBdXvrJFUi+1V+bnpnJUBH5jHoOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnsYSgVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2F7C4CEE7;
	Thu,  8 May 2025 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746730808;
	bh=upd4BA2+NUQKOAJi4k+ZVCYsV3o6gMhNujVJ1Cd2Www=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnsYSgVYjjVWSDA2rR1IKRGk54KZ/4mJCNdUojwMoB2rxXINt683EiGe1pju2X/uv
	 yyAUWhHu+zNDdL9UVC24WaUwJLxdDVOggX7sIfZQdr/eG0Rcmi7s4gqMXF+GL1nVEX
	 W6J3IJD5wpyMu/q9UKLeUecC3lA9Op+zsLQ/GsTMFZ1CmcGG/XPaC95tAhUWQCdk5l
	 /F9tSVgudNXUBELkEJ6PkRcTaMPl7ddnOkegQM2brG5QX1cJ4RyRxwzDb/pTRj0BL3
	 1ZTA+HVxIvLwSbz/zAONKYccnIF27F7eS9eY7hG5JMaLjOxNBtWR6dYaiMshhNeVr+
	 vPER/vIkGeoQg==
Date: Thu, 8 May 2025 20:00:03 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	gakula@marvell.com, hkelam@marvell.com, sgoutham@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH] octeontx2-pf: macsec: Fix incorrect MTU size in TX secy
 policy
Message-ID: <20250508190003.GP3339421@horms.kernel.org>
References: <1746638060-10419-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1746638060-10419-1-git-send-email-sbhatta@marvell.com>

On Wed, May 07, 2025 at 10:44:20PM +0530, Subbaraya Sundeep wrote:
> Underlying real device MTU plus the L2 header length has to
> be configured in TX secy policy because hardware expects the
> mtu to be programmed is outgoing maximum transmission unit from
> MCS block i.e, including L2 header, SecTag and ICV.

Hi Subbaraya,

I think it would be good to include an explanation of how
this bug manifests.

And please target fixes for bugs present in net at net.

Subject: [PATCH net] ...

> 
> Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

...

-- 
pw-bot: changes-requested

