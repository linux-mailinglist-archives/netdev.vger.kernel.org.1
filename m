Return-Path: <netdev+bounces-180011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8DA7F192
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001D916A0A6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE112A921;
	Tue,  8 Apr 2025 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdGDAG2h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4465184F;
	Tue,  8 Apr 2025 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744071302; cv=none; b=Y859hSGpr8HwY+sYITxMCQI/xQBxwPwPtJiXkA32rJBIXQd9mwTUemltuGMEdEMx+LyAsFjVxVPBko8zS4xHoxNTV2lBPY5/8MhHrIZLQeAfA/KbJbBuuBEV8Fh8jPRX5AXxhtSvk0klKDLxxU6pl2umsbGWKpP7PE+4dI34WE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744071302; c=relaxed/simple;
	bh=p6MZUSqU/sLAunm0i5UVvuGHuAIYSf5Oj5/EKR2DRKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVKGkE7h6W1fvfBtEvQ+QrTbws7iMZt4JmCVAk5RyRGrlawZc/XO6klcMxxQCGAOp3ZNRUrFz3zrbti1LJZmgBwlLMtVASdVPOJ21fXf4zqtxl2VNqxHATmHxzZ/XIFixLETRv3+SR9g5aBAXDxsm+JLPAuJIsy/jDYjdCQrKsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdGDAG2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A05AC4CEDD;
	Tue,  8 Apr 2025 00:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744071302;
	bh=p6MZUSqU/sLAunm0i5UVvuGHuAIYSf5Oj5/EKR2DRKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LdGDAG2hgb+NyDTKjmLOYhwyctZI8CG3KVx95SQMiC4tyXDVEOVReqD3wTUk84/MQ
	 7j3azr1DYeCpYDQFP1fy1l+jZ2cr+LMdDHh5OAJD7iR7qRv+B7YXpliggHVnsc4jaD
	 2uQI3qK8+T7KJmhI7/Iybfd7jAsUQXV5YH59g18waMkj7NSprj991TBx+SqusjJrwf
	 tDBzScRmYQjNogmZloPriZL3LjQc4qYCMMpzSohypLsjRAUtW+q+a5Dc3EhFLmN8sD
	 9Uj89CTBhPupTyhbRY5l/bYYD8aKx0ER+Kvo6Fxvp6gMq2qCwb+0Mqx76U2jGztFie
	 Kgy38iSJ+0kFQ==
Date: Mon, 7 Apr 2025 17:14:59 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Intel-wired-lan] objtool warning in ice_free_prof_mask
Message-ID: <6nzfoyak4cewjpmdflg5yi7jh2mqqdsfqgljoolx5lvdo2p65p@rwjfl7cqkfoo>
References: <4970551.GXAFRqVoOG@natalenko.name>
 <5874052.DvuYhMxLoT@natalenko.name>
 <ficwjo5aa6enekhu6nsmsi5vfp6ms7dgyc326yqknda22pthdn@puk4cdrmem23>
 <2983242.e9J7NaK4W3@natalenko.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2983242.e9J7NaK4W3@natalenko.name>

On Mon, Apr 07, 2025 at 11:49:35PM +0200, Oleksandr Natalenko wrote:
> $ make drivers/net/ethernet/intel/ice/ice.o
> …
>   LD [M]  drivers/net/ethernet/intel/ice/ice.o
> drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mask.isra.0() falls through to next function ice_free_flow_profs.cold()
> drivers/net/ethernet/intel/ice/ice.o: error: objtool: ice_free_prof_mask.isra.0.cold() is missing an ELF size annotation

Thanks, I was able to recreate.

This is the -O3 optimizer noticing that ice_write_prof_mask_reg() is
only called with ICE_BLK_RSS or ICE_BLK_FD.  So it optimizes out the
impossible 'default' case in this switch statement:

	switch (blk) {
	case ICE_BLK_RSS:
		offset = GLQF_HMASK(mask_idx);
		val = FIELD_PREP(GLQF_HMASK_MSK_INDEX_M, idx);
		val |= FIELD_PREP(GLQF_HMASK_MASK_M, mask);
		break;
	case ICE_BLK_FD:
		offset = GLQF_FDMASK(mask_idx);
		val = FIELD_PREP(GLQF_FDMASK_MSK_INDEX_M, idx);
		val |= FIELD_PREP(GLQF_FDMASK_MASK_M, mask);
		break;
	default:
		ice_debug(hw, ICE_DBG_PKG, "No profile masks for block %d\n",
			  blk);
		return;
	}

Unfortunately, instead of finishing the optimization, it inserts
undefined behavior for the 'default' case by branching off to some
random code.

So there doesn't seem to be any underlying bug, it's just that objtool
doesn't like undefined behavior.

So for building with -O3 I'd recommend just disabling
CONFIG_OBJTOOL_WERROR and ignoring any objtool warnings.

-- 
Josh

