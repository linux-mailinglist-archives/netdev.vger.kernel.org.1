Return-Path: <netdev+bounces-62343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E519A826B83
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 11:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0438B1C21FF1
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3D13AE2;
	Mon,  8 Jan 2024 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4KBiqmc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C6713AE0
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 10:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F491C433C8;
	Mon,  8 Jan 2024 10:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704709278;
	bh=MNj882t9CtCVJPGigAfOfZrh+C2WYSXQq8SiXPGt+TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4KBiqmcMfduU4JFQRs9a3nSWyBqP6WUQ71/45JYUgsV2/VDBx0Wk9H57twr2viGR
	 Z4iK8sikfedZE71N8Z1zINLUwgTV1zD7SBDQz9dHHHrYs99yOR3L4dIwBB+7hVl7jZ
	 0WeBtONAWoQNsHk9L031vkr94mOrmkwnvXhYfziCYkeGdVsm3/JoxaNQ2Z5edo9Tsg
	 wfnXBEs8Ep0EgbjD8cOX6Grkpc9M0Yze253/Ljm801Aqs9f9JeokWprvRBE3Tpcyah
	 /dUXq1A0eP833Mb65mCQbpxYsGkvx12cgAoMxkR+E62UQ3zVoPBJkrwja8RoiuJ2E5
	 GqQbuee53pk/w==
Date: Mon, 8 Jan 2024 10:21:13 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next 2/3] bnxt_en: Fix RCU locking for ntuple filters
 in bnxt_srxclsrldel()
Message-ID: <20240108102113.GD132648@kernel.org>
References: <20240105235439.28282-1-michael.chan@broadcom.com>
 <20240105235439.28282-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105235439.28282-3-michael.chan@broadcom.com>

On Fri, Jan 05, 2024 at 03:54:38PM -0800, Michael Chan wrote:
> After looking up an ntuple filter from a RCU hash list, the
> rcu_read_unlock() call should be made after reading the structure,
> or after determining that the filter cannot age out (by aRFS).
> The existing code was calling rcu_read_unlock() too early in
> bnxt_srxclsrldel().
> 
> As suggested by Simon Horman, change the code to handle the error
> case of fltr_base not found in the if condition.  The code looks
> cleaner this way.
> 
> Fixes: 8d7ba028aa9a ("bnxt_en: Add support for ntuple filter deletion by ethtool.")
> Suggested-by: Simon Horman <horms@kernel.org>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/20240104145955.5a6df702@kernel.org/
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Thanks Michael,

I agree that this addresses the issue flagged at the Link above.
That it is a bug-fix, and should have a Fixes tag.
And that as the cited commit has not propagated beyond net-next
it is appropriate to target this patch at net-next.

FWIIW, I might have separated the bug fix from the code re-arrangement that
I suggested. But perhaps that is over doing things as the patch is for
net-next anyway.

Reviewed-by: Simon Horman <horms@kernel.org>



