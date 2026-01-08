Return-Path: <netdev+bounces-248119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8068AD03B1A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4B913064A83
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9222DECB1;
	Thu,  8 Jan 2026 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPdY47mD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E022DB795
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884703; cv=none; b=efMH8K7ycyPhv4uC3siLIXRLYRNgiL2N+cqVsvVcL2ZLeadlOETNl7NBXvV8B9AWWkbtz6qN8mtgRplC63C/9t5f7mMXY5DcOd8jD+4dHLMDn+idOBwQCUYy2FZEtrIMgc46npVLk5G1q25LVssv7uPaf/84jhLt6Ad8sBH5OK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884703; c=relaxed/simple;
	bh=RGmmRSOekZ9dSwMwSZLBkzhaCG4B3yB6Z3uObL3WdfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPNskkf9RNB8yx/cqO0CfbYysclPV0s2ikIKLqGYl1+YmOScM2ZJsZBNUzXplApy7i927fr2/q7QLBNpZAyN4pbqufvg5iEQabEHcFHtne6qrZ0wO86vxJRy14Xoxr9c3yd+5t1EztETYXN99hAq6uQFTqHCqEl7CHvd3yXohhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPdY47mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44BDC116C6;
	Thu,  8 Jan 2026 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767884702;
	bh=RGmmRSOekZ9dSwMwSZLBkzhaCG4B3yB6Z3uObL3WdfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPdY47mDYM/ZOdRmussvL0jQ5nswO4clI6ZQN71mcBr7JXT85xT+fBbNdwlIyPfIq
	 QbP43ELD7V+B/rrU5jWxBY5L88B9PQJQDUnPpWMuYBoIsCWSgqvlB64aTxf/nq4mei
	 F7t4YOeZ6mlPdNAExetVUXi6Ejf9hqIDL4Kmf2d5HEPqqrtY4C8gYPe6eKgmUEpKkG
	 v+fOcbdIXu0e2IOWQ7IL/RNjsucZtVENMLU6hsG4xnRpyGvgBUimnNItvD3PbDFBTy
	 HaYLS0geSops+1PXgaLCzoYmocS20i9eiXT2kHrHfidhqQF2gQEATrlxzwFP5XvlxP
	 qhpE2cNl6LVTg==
Date: Thu, 8 Jan 2026 15:04:57 +0000
From: Simon Horman <horms@kernel.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] net: ethernet: mtk_eth_soc: avoid writing to ESW
 registers on MT7628
Message-ID: <20260108150457.GI345651@kernel.org>
References: <20260106052845.1945352-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106052845.1945352-1-joey@tinyisr.com>

On Tue, Jan 06, 2026 at 07:18:28AM +0200, Joris Vaisvila wrote:
> The MT7628 does not expose MAC control registers. Writes to these
> registers corrupt the ESW VLAN configuration. Existing drivers
> never use the affected features, so this went unnoticed.
> 
> This patch skips MCR register reads and writes on MT7628, preventing
> invalid register access.
> 
> Fixes: 296c9120752b ("net: ethernet: mediatek: Add MT7628/88 SoC support")
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> ---
> v2:
> - Add missing Fixes tag

Hi Joris,

While I think a minimal patch along these lines is appropriate as a bug
fix. I am wondering if, as a follow-up, consideration could be given to
registering alternate phy ops for MT7628. This would push the conditional
handling to probe rather than calback execution time. And I suspect it
would lead to a cleaner implementation.

