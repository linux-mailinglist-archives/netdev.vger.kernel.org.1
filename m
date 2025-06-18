Return-Path: <netdev+bounces-199211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BAAADF700
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE771BC0D4A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA4215F56;
	Wed, 18 Jun 2025 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVIIdxJo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2F19DF7A
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275786; cv=none; b=uSiUol29/pN7aQ+9YMyfEQ9xdmYFip/MZNY3Qt0DhWK3GYn8lCr4j+mRXF+dnMkt/90bcl5dyFnXvqTPLYZNXMlezvCkEK9am1KpR8qm3tX0zkDxFGVlvQLc+q2LWxZIalpNCl5eg4MJ8GlVWXipeovii4HUOYTBVkD4r3R+1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275786; c=relaxed/simple;
	bh=QcZdwFOYZpO4disS4Yq1KQ8y32Z765oafCXyytPe39c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp4hW+0sWMpV5CxNzVIXQJ3UMEDzPcvZYaxAnVhEKSyy9nPSVmcQnIX7j+X5P27wAuCVuZdO3H3M8Aegv3KaU9q7e63OdO79YPwunFN+yb0FHH1vgH251JOuV9dh8i1UIPq90GkBbNKFGaJfk5qnxrY1uVsB7PYYvI5ZOu3Q+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVIIdxJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7FDC4CEE7;
	Wed, 18 Jun 2025 19:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750275785;
	bh=QcZdwFOYZpO4disS4Yq1KQ8y32Z765oafCXyytPe39c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVIIdxJoZj1x2fWO6VF3T43BDp906eqJHqfFKiTKgmHHE0TgpioefI1fchAuhxyNa
	 r2SUz6tPu0UXwHf9eRYjm9+1Lb53YFOggIDeU7Z94/MSQSTTb6MSpPQB2pSCzk+hRL
	 plGqpb4lP+E62wsSWufqIx82Prb3lxxSvxA6HHyEWnYsOKfYb+K7TH6XpWxQqJ8iFb
	 sQySFeUEMhBhkhv7DM+ksDgd4e4Oth9YioNqSDQjtko0xFY+GijBnB2J334QY6Da+h
	 BNpFvWCo616T4/yPRGmB1j1WlBolNLvdhs5PDOx/swAfLCi6y0i2oxns3rrJiAc+ae
	 tmRRc4a3avoQw==
Date: Wed, 18 Jun 2025 20:43:01 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, saikrishnag@marvell.com, netdev@vger.kernel.org
Subject: Re: [net-next PATCH] octeontx2-af: Fix rvu_mbox_init return path
Message-ID: <20250618194301.GA1699@horms.kernel.org>
References: <1750255036-23802-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1750255036-23802-1-git-send-email-sbhatta@marvell.com>

On Wed, Jun 18, 2025 at 07:27:16PM +0530, Subbaraya Sundeep wrote:
> rvu_mbox_init function makes use of error path for
> freeing memory which are local to the function in
> both success and failure conditions. This is unusual hence
> fix it by returning zero on success. With new cn20k code this
> is freeing valid memory in success case also.
> 
> Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Although I don't think the problem is introduced by this patch
with it applied Smatch notices that the following code, around line 2528,
which jumps to free_regions does so with err uninitialised. This is a
problem because the jump will result in the function returning err.

	switch (type) {
	case TYPE_AFPF
	...
	default:

		goto free_regions;
	}

...

