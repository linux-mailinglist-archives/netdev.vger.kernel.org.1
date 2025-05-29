Return-Path: <netdev+bounces-194102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B88B5AC757B
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 03:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D3F1BA3F09
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 01:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5841DA617;
	Thu, 29 May 2025 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCRMWkYq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434515A864;
	Thu, 29 May 2025 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748483390; cv=none; b=TfHtf5Shg0odSbIW/Xg18P8guh6oxCC7KsSXJoQ7lEsLWCRBkpO3BQ8Ku2KgX2AOBuXI43GDVGS3GyyMU0wsPf13awByl5+O/j5jnd4plX14Ltd4635VyTWFXYd4pY6KWu1e/9q7aPk06CtPd/0ms23IegWXR3cDhdXERhJet9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748483390; c=relaxed/simple;
	bh=8UXi52Hu7/EOK2HSKr7C26i/8h14iAHN2ueX5MKbWdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ea6/vmRI3WszfRlx/NjnarCWVneciBj5tfBRkzb35rTY2/OiCKZYSipI9cHVxaLhS0evx6AOLTQABTmOzoo/+HyzMwi55kK3K5/Jw5vkGdc8J3RKe8bW4y6iobRb8YHECKARsFvV9rra35RS1dl54RcBn6rRHbonX0nffJL4bEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCRMWkYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58606C4CEE3;
	Thu, 29 May 2025 01:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748483389;
	bh=8UXi52Hu7/EOK2HSKr7C26i/8h14iAHN2ueX5MKbWdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pCRMWkYqu4o5fJZkfp5KjFhX6etlAcDhMk/3dm2acnyLm2IKvBFjAk1fW1vg9QwuY
	 DZE0yXRIrENiLzkiUcAEOd0sUPmgu0tQNK3l6CDnqEPRzOWDy2p2BhUIf56fJw7MGz
	 4RyuO3UNb+NTvlJk4XaCYqHc7j9AmiyblQnAJmXrBLPb13p9t9CjuydxAxZN1JtTKQ
	 QWegiVGD/73BFuWaGhQ1bt1rYVEAdvZ0MzWQPSbpaj+T49lmHYcTwNgdK60+/UVY4l
	 uv/q2NmxOZDLElTuUUxUD2iOOu3xEA1Gm7sjrYacNsD9G8kvVc0sUPipR2hbrPFPmJ
	 HiAHHHeBZ4KBw==
Date: Wed, 28 May 2025 18:49:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Simon
 Horman <horms@kernel.org>
Subject: Re: [net] Octeontx2-af: Skip overlap check for SPI field
Message-ID: <20250528184948.5d85f0cc@kernel.org>
In-Reply-To: <20250525095854.1612196-1-hkelam@marvell.com>
References: <20250525095854.1612196-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 May 2025 15:28:54 +0530 Hariprasad Kelam wrote:
> Currently, the AF driver scans the mkex profile to identify all
> supported features. This process also involves checking for any
> fields that might overlap with each other.
> 
> For example, NPC_TCP_SPORT field offset within the key should
> not overlap with NPC_DMAC/NPC_SIP_IPV4 or any other field.
> 
> However, there are situations where some overlap is unavoidable.
> For instance, when extracting the SPI field, the same key offset might
> be used by both the AH and ESP layers. This patch addresses this
> specific scenario by skipping the overlap check and instead, adds
> a warning message to the user.

The commit message doesn't really explain what the implications for
field overlap are. The warning is also very uninformative. The user
will see the warning, find the commit which added it, and should be
able to more or less figure out what the implications are.
-- 
pw-bot: cr

