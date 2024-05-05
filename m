Return-Path: <netdev+bounces-93500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E518BC18C
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83341C20992
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 14:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8726F374DD;
	Sun,  5 May 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLuZsFhH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6328B2C69A
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920839; cv=none; b=p2fwvQZ66GiSCJGUBrwAg7GMKcJA5UuyFZd2BrMaIGoDGoewAox5WtwbYccMcu8W61q1ObbUu3KBaSDQpKBFd0lHQZrNOSup9lKGvrPdY7HwU+MCjIma5F469D5QxL29KAdEooahd3e9CoKGpn1kkcGWYtFYlI7b6gIot4gqDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920839; c=relaxed/simple;
	bh=4zHVP8b+FcDiazfkJwIeG/5t9maMVWDGI8kTo3gi+CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKX7TllqLHJ6s9WT13oViEE/uCewkbDZdXu8dOnKVLLMsNr/bbEMyV16ynfR9Z9CPMk7sybfynLHIIPcRIOmR8x+M31C1MLbr/jdIIJIWRoElbzS9lI7U0Ccd4/gk62S2affqnc1HQETTebHHxJyZuX99OPr1yS8ixEnYZC27P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLuZsFhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6934DC113CC;
	Sun,  5 May 2024 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714920839;
	bh=4zHVP8b+FcDiazfkJwIeG/5t9maMVWDGI8kTo3gi+CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLuZsFhHFUV9omQtN1UDdOlsO/7wjfe6PIjqvnsW7ANVcAyejKYoXhx2v/LkQHznt
	 dWU79Bv5Jd1utthG34fDCi2JYnDFNN7myqFBFKrASFbZmMhMuR2u4cHmEw2yLRcgUg
	 Fpa3niO1hLGG4mH06PYfYd6PZMMHu1Kzlv62avgTpuKXrh3qN0SEgS5Jz6JM0RJcAg
	 e5wGx4bquDQ5Io1IOWjZTDU19wVBXnvCbt6Wpxfd7FJq7VQoDCgy0hFrY7KJBtO+Pl
	 cVTtELpIlMsp0pn5lOLhj2pehG7MTdkV2ImAjmtATnn8deqQGdspfck+DOEfEdn4Q4
	 F5rvK6rvzTyqQ==
Date: Sun, 5 May 2024 15:53:54 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 7/8] rtnetlink: do not depend on RTNL in
 rtnl_xdp_prog_skb()
Message-ID: <20240505145354.GF67882@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
 <20240503192059.3884225-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503192059.3884225-8-edumazet@google.com>

On Fri, May 03, 2024 at 07:20:58PM +0000, Eric Dumazet wrote:
> dev->xdp_prog is protected by RCU, we can lift RTNL requirement
> from rtnl_xdp_prog_skb().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


