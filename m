Return-Path: <netdev+bounces-119638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7F956705
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664691C21981
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F09158532;
	Mon, 19 Aug 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpWUk2oI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718EC143C63;
	Mon, 19 Aug 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059821; cv=none; b=qpr7tIEXn7tTF0ARYWKuk1h0Ko106arJo5T7gdwIbngpFEBgbatLiaWm+G1HhM1P04P+r2syN9rWtFLBGs+DYWfApaEf640tsglGOWqms3ShDXCumOyEgQMFzoGusHmCovYMDpSiEzFLxx5GxTHsa3t9aNEVFP0duPpSBfpzjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059821; c=relaxed/simple;
	bh=UPsNRKG9Zu2jfztwxlXBjO6UIO3owH6Aie6P2dQqTUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQRtBCkdz2Cq/cNASSHRTsF2u0HXN+l+IPbWcNyH4ucJ7tXxKR7zuFvItxXgFhKeADDzDUjOMeSc+6NZQC4e3wad9CLrw09Q2p9vARct/0AGwko209kBFA0poOTzQAgmqXU/lnKGHjfk9rqAMh1Ek3VWMJjnzYT6pebnyJ26chA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpWUk2oI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12958C32782;
	Mon, 19 Aug 2024 09:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724059821;
	bh=UPsNRKG9Zu2jfztwxlXBjO6UIO3owH6Aie6P2dQqTUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpWUk2oIsMLC+VEeRCCFjfKYRFNuJuROvNWAb+cJ6wESf0yxk8Cmcuqtwv+WdlHS/
	 sANOy85MEOZsBG2qPTZlMHkftb28TUruwlu9zqjXB0epzcZpdyKhigGshJqHxRGb99
	 Kj9ZkHv9AT6MiVG1DnzIA9u0b3zd9Lm880bewk983IIC4s0QbAG3yHAL6+Gy/6zAiq
	 ADxI5inbh9wZbvNxKxVvjMOQlOFvKjKKCsuXpB0WfkCf0E+dpMKt+MKbign9+6Cp6g
	 b3z1d5RDodCRW6d0XrGxy3ynj74InMki0POKQm4BIsfh+iujz7SDJspA2AroJfjRYN
	 5/uTRNOVbU3lA==
Date: Mon, 19 Aug 2024 10:30:16 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] dpaa2-switch: Fix error checking in
 dpaa2_switch_seed_bp()
Message-ID: <20240819093016.GB11472@kernel.org>
References: <eec27f30-b43f-42b6-b8ee-04a6f83423b6@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec27f30-b43f-42b6-b8ee-04a6f83423b6@stanley.mountain>

On Sat, Aug 17, 2024 at 09:52:46AM +0300, Dan Carpenter wrote:
> The dpaa2_switch_add_bufs() function returns the number of bufs that it
> was able to add.  It returns BUFS_PER_CMD (7) for complete success or a
> smaller number if there are not enough pages available.  However, the
> error checking is looking at the total number of bufs instead of the
> number which were added on this iteration.  Thus the error checking
> only works correctly for the first iteration through the loop and
> subsequent iterations are always counted as a success.
> 
> Fix this by checking only the bufs added in the current iteration.
> 
> Fixes: 0b1b71370458 ("staging: dpaa2-switch: handle Rx path on control interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> >From reviewing the code.  Not tested.

Reviewed-by: Simon Horman <horms@kernel.org>


