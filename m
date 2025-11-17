Return-Path: <netdev+bounces-239207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8D0C6592D
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 72DCB2919E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C402B304975;
	Mon, 17 Nov 2025 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIuI/P6H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F626F46F;
	Mon, 17 Nov 2025 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401386; cv=none; b=ikVYwUOBybN3DWYSMZ+6jpLZxwIEvoDxfP9022PcpeG2FXvH2yiKAM0LxygmBv6vxle2x4L7kjn6jMQZ1z4jNWYRGSbO1r66T5ocW/F469DfxVTCDqwTskGwvxjlj0DehF6mYvjEjSP6iHVu+9dtJkajfa8cdLCeayaUitzA9FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401386; c=relaxed/simple;
	bh=oqwgOPTqxCy/oWz5+mJ/KKzTIJS8SjOCmEkfC64cjos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh3hTH5k0nTbvD4kduow1HWaPsPr8YZ/8LLh+jftVk0jmvJS5deV4Ri1kpmfvF+Ow7wYiJmlg56QhuTSxMkdH9p0zP8wEBAxiTVigpDEAX6dXwjPcrxKz4T9CP/BrGSZa/PP0YQReeZg4JcOJPIsf3bBs7RKE1SVJlF7WRGdiwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIuI/P6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A5AC19424;
	Mon, 17 Nov 2025 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763401386;
	bh=oqwgOPTqxCy/oWz5+mJ/KKzTIJS8SjOCmEkfC64cjos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LIuI/P6HBEuEGoUySaKa144UVzSdF8Bo+luHISUI++mVTYr9mAxrk+CCIetO/xENV
	 CZKRvkToL+DZBPlERWPZO6L3xdYH8Ty0b0Pm3kMFTP+E7kjsZV4cQh4GTthgNrECDU
	 /pn1JOwBGMYFvU9/hnNs2naTJJCUREtMI4KeDXxQHTHm1QTSQNXwG9fGcgJrUNhJou
	 JzHZeg9bOczl+yeBHx9rbD6jbpruTEy6vMHUt6ROWTYEhnJqhy89qHZFsfOXVEglf1
	 HD6WqFX0OhSUH3/Y/9+M//g7ph/cld05rPo+koLn3aCuh/VQrdPULiArHnSZ1HdkdD
	 xM4EgSMpe26Ow==
Date: Mon, 17 Nov 2025 17:43:00 +0000
From: Simon Horman <horms@kernel.org>
To: Anshumali Gaur <agaur@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [net PATCH] octeontx2-af: Skip TM tree print for disabled SQs
Message-ID: <aRtepJO3CiwlG5gO@horms.kernel.org>
References: <20251113093900.1180282-1-agaur@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113093900.1180282-1-agaur@marvell.com>

On Thu, Nov 13, 2025 at 03:09:00PM +0530, Anshumali Gaur wrote:
> Currently, the TM tree is printing all SQ topology including those
> which are not enabled, this results in redundant output for SQs
> which are not active. This patch adds a check in print_tm_tree()
> to skip printing the TM tree hierarchy if the SQ is not enabled.
> 
> Fixes: b907194a5d5b ("octeontx2-af: Add debugfs support to dump NIX TM topology")
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>

Thanks Anshumali,

I agree that this is a nice change.  But I'd lean towards this being
net-next material rather than a bugfix for net.

This is because my understanding is that the change enhances the
readability of debugfs output which, as the name implies, is for debugging.

...

