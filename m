Return-Path: <netdev+bounces-53172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D18018EA
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 01:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36AE281BFD
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA8D193;
	Sat,  2 Dec 2023 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCO6gc5Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADB4180;
	Sat,  2 Dec 2023 00:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8B4C433C7;
	Sat,  2 Dec 2023 00:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701476925;
	bh=R0k0tXYJ+7iYYb4PuYlDXmyrZ419znNCZk78MJognfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XCO6gc5YMrsqvtUec95lwReeHXO5R8bI0Ex9DtHRiUJXNZ63Teeyhqo7Om3Sxt4WS
	 gc1qn1MvOYLzYbNKc4+psBCm5dnBIV/8qFazpLjIiTIGosJ1N5P0/bX+qilx2kZjUU
	 Ol1tD8AIHrhn/Y+0Xt6LELQSaw72nd/q8cmsudFfaCRtjV5cSpGBusIqYWYpIm5wmo
	 kW+Z2+jhOkmht4aR2adt32/IbIZO4gfx+YJP5oH/tE/gK7Cw3aVQwKmW6uGT9u9rOJ
	 jImLtnsURwka7Sdd2Tc1DybR0fHRb2WuZXRE6cQv7rZXaukjHzdsKls5tWADvHCTj5
	 VrGNFHVBRoRqw==
Date: Fri, 1 Dec 2023 16:28:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH wireless-next 0/3] netlink carrier race workaround
Message-ID: <20231201162844.14d1bbb0@kernel.org>
In-Reply-To: <20231201104329.25898-5-johannes@sipsolutions.net>
References: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
	<20231201104329.25898-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Dec 2023 11:41:14 +0100 Johannes Berg wrote:
> So I had put this aside for a while, but really got annoyed by all
> the test failures now ... thinking about this again I basically now
> arrived at a variant of solution #3 previously outlined, and I've
> kind of convinced myself that userspace should always get an event
> with a new carrier_up_count as it does today.

Would it work if we exposed "linkwatch is pending" / "link is
transitioning" bit to user space?
Even crazier, would it help if we had rtnl_getlink() run
linkwatch for the target link if linkwatch is pending?

