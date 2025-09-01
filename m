Return-Path: <netdev+bounces-218786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81633B3E80F
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C9E16D9A5
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DFA341AD6;
	Mon,  1 Sep 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJt0Yc4f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C960341ABF;
	Mon,  1 Sep 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738814; cv=none; b=ZPrs5dmVjGu2HLXe4AGPQ13fNxIlQTjyJ+ELpwzzVEp4z16iG6E+IdeVwemjRmgg2KHXdvmZsGsE5D0SgeZjc1KGnsU1IeooTPMr64HhV7+hoYVD07ZgkEyZriuKEuy+w+jdROGbnqAAPFZ15stN+xG88ltjUvzchS5+Ifiposs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738814; c=relaxed/simple;
	bh=ChMio+PFe0V2j5Cl+/b/ieVoWB4tULRvJtgDZNPdg/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do2WRZMjvvZp8oNNm1OtaUyaJ2HRvFO4+F0LH2DJm7CfCiGZl1//SX3ij11EychHz+tgiX9mEFrWNFtRsysFQ+XUMM3WQldgPu+bZ9m5+B9VXRnyF/43zn8I6Ql+Wf2R7PV6hBaPjyV2QiujFyzbdNx4QWUdOefE3CRC2X+NJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJt0Yc4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE837C4CEF1;
	Mon,  1 Sep 2025 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756738812;
	bh=ChMio+PFe0V2j5Cl+/b/ieVoWB4tULRvJtgDZNPdg/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJt0Yc4fi0gjqixAFsBRiIjR4Jl3VBfTRKr2BB0yHIWjglGoNURdNXXO1bhOckhuu
	 tOQSrwLTto6QEsEyy9f79WYDQsd4UCPnMUSZfMmA21KY4Q+WwKzRiAIaDB1e083Ayp
	 yoQB1mcg3wmyG9lJqMrR8TjJE2KKhEajJxytO9/V2x7nFbu51G1luuoiEmnmdna7l5
	 CkbyGxtVK07krLgV3jQdL/VpKQFBVtkdX8kCvCulrGVsOhtlCLXLiWqbuZhITqx8Jb
	 rQxeUCAXKTlTKja4lpLPV7+KtzXtV6KbSw74Q54Ko7R/9PcBTQk1XRJSPPyvbCqw0m
	 fOXQB57uRth3w==
Date: Mon, 1 Sep 2025 16:00:08 +0100
From: Simon Horman <horms@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mvpp2: Fix refcount leak in
 mvpp2_use_acpi_compat_mode
Message-ID: <20250901150008.GF15473@horms.kernel.org>
References: <20250830091854.2111062-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830091854.2111062-1-linmq006@gmail.com>

On Sat, Aug 30, 2025 at 05:18:54PM +0800, Miaoqian Lin wrote:
> The function calls fwnode_get_named_child_node()
> to check for a "fixed-link" child.
> It did not release the reference if present, causing a refcount leak.
> 
> Fixes: dfce1bab8fdc ("net: mvpp2: enable using phylink with ACPI")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Probably this should be targeted at the net tree, like this

Subject: [PATCH net] ...

But that notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

