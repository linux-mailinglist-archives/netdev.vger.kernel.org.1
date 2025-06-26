Return-Path: <netdev+bounces-201509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52362AE99BB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833A917DDFC
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCAB298982;
	Thu, 26 Jun 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAEJpB6L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE71A8F94;
	Thu, 26 Jun 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929197; cv=none; b=HXAe01GoB+wUiRu+eIrRZvRFcCizGj/i467nrnlhoVLl1tvym60/qRXFxWhT/Nx77euYMQ7BF0nX9ZZozH++RhEAnXycIv06/5Kpfns02MWLhq6w+3mzEllF3Y0sl5fcI4DPDoa5hSyow30AnfiW7JTmC2MDxt6VTZ4mC3k0OEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929197; c=relaxed/simple;
	bh=n8Qtg/STa8Iaorrpz35yWhThK6cB8msGjX+6mEcy6VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob3Idi9zNHzj2Spg9h8OscAh5GK/9+SbXy9Y5Rr0Uc/4vifnrpQ2LYZliwUr+4xL7ZQdOKu4Ae4e1FUhVlmG6t0owYMxFL05EK8++L5TrTQQ2klIATGQ/cvd554ZLe6FPb0ebRmsj9KWNDLnVxFgVK+oywthniDm6GAr0elD1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAEJpB6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EE7C4CEEB;
	Thu, 26 Jun 2025 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750929197;
	bh=n8Qtg/STa8Iaorrpz35yWhThK6cB8msGjX+6mEcy6VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAEJpB6LvdtC6YbDC77EcG8mbymv7LJbjNKj/BbZnSKeQWCtCkKcoa/RXsby3ULje
	 bBdxpeijlycQfNzMPj7fG1rglxPWPhqTCqEwMZ6jPRiAJh2shbJ3cY+jfUr8Gu4GeD
	 23nyhD/N6pMGnpK2F430/FeG6QXxAKnE0+sZlmqJ3DcqbQ0zS9IjxWzi8VJSJkO9ON
	 laHwJNV7nhTyy4agHw76V5g1I0QnP2A+nDGFttEnMSdp9WLki1Fx1jvW47dGk/88PD
	 GcfVt8nXiH3YVKa5nDTbyYpd7Nx6VKljJdBtZUu9L06YKLVxZL+4BCab/nZ44oCh5M
	 YGxUzd+t3Hpbg==
Date: Thu, 26 Jun 2025 10:13:12 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Sai Krishna <saikrishnag@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] octeontx2-af: Fix error code in rvu_mbox_init()
Message-ID: <20250626091312.GV1562@horms.kernel.org>
References: <ee7944ae-7d7d-480d-af33-b77f2aa15500@sabinyo.mountain>
 <aFzp70LaPoO0ukw8@822c91e11a5c>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFzp70LaPoO0ukw8@822c91e11a5c>

On Thu, Jun 26, 2025 at 06:34:23AM +0000, Subbaraya Sundeep wrote:
> On 2025-06-25 at 15:23:05, Dan Carpenter (dan.carpenter@linaro.org) wrote:
> > The error code was intended to be -EINVAL here, but it was accidentally
> > changed to returning success.  Set the error code.
> > 
> > Fixes: e53ee4acb220 ("octeontx2-af: CN20k basic mbox operations and structures")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
>  Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
>  Thanks for the patch. This has been pointed by Simon earlier:
>  https://lore.kernel.org/all/20250618194301.GA1699@horms.kernel.org/

Thanks for the fix.

Reviewed-by: Simon Horman <horms@kernel.org>

