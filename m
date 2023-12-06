Return-Path: <netdev+bounces-54239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047A58065A8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3638C1C2096F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB85D27D;
	Wed,  6 Dec 2023 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWK7Oh2d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E98B6D39
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38B3C433C8;
	Wed,  6 Dec 2023 03:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701833608;
	bh=2xYPKij0V1STzfcMgh++J8tm6B8Ymjg4rX0SX0cFx3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NWK7Oh2dqYmYGVH89Q2tMPuzbV5S4ySPXoYcfiF6GySOhEGH9Sm23NEGpaPCexRio
	 calfAbIUGh3A5Vbq82Mwf9KwMRl3oxhYBikjXm6cWBsRdoscwqXsXNDW5+xqg7Gglb
	 UThWb+qc1oN9RNL4w1XBxfS/yOyv191I5pGLqUHzRuSSu/sWaXLfe0Jb61YEkcbujs
	 sRtGOy0dS8d73nxgPKuI5ra6BltOCOsRCvpvj/eNac0sYItAgRvhnZnUaJd3KR05uv
	 OE11e/7m+3zJT79+QJ4khFAcLz2Disi1kzSIxjSiXnM339h+1a4XXrWylJxT0wlGe+
	 tjXd5LlU30CrQ==
Date: Tue, 5 Dec 2023 19:33:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Igor Russkikh <irusskikh@marvell.com>
Cc: <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] net: atlantic: fixed double free when constrained
 memory conditions
Message-ID: <20231205193326.3fb93009@kernel.org>
In-Reply-To: <20231204162040.923-1-irusskikh@marvell.com>
References: <20231204162040.923-1-irusskikh@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 17:20:40 +0100 Igor Russkikh wrote:
> Driver has a logic leak in ring data allocation/free,
> where double free may happen in aq_ring_free if system is under
> stress and driver init/deinit is happening.
> 
> The probability is higher to get this during suspend/resume cycle.
> 
> Verification was done simulating same conditions with
> 
>     stress -m 2000 --vm-bytes 20M --vm-hang 10 --backoff 1000
>     while true; do sudo ifconfig enp1s0 down; sudo ifconfig enp1s0 up; done
> 
> Fixed by explicitly clearing pointers to NULL, also eliminate two
> levels of aq_ring_free invocation.

The change of the return type plays no functional role in the fix,
right?

I think it'd make the change far more readable if that was a separate
patch. And if it's a separate, non-functional patch, it should go
to net-next, rather than with the fix to net.

