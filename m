Return-Path: <netdev+bounces-208904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEB3B0D84A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8E73A9FA5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AAF2E0B45;
	Tue, 22 Jul 2025 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkNGrXyO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA9E1C32;
	Tue, 22 Jul 2025 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184149; cv=none; b=lsEx6frKVVStUELD6AmqViOAPlvr4j/d0ut4CwIy3ZOoxEMCmi/W9QBvH/Cez/sAzOwM56qwcSwYdt+dsV7YdAN69qgWfuw3oMYmuTn8KTeh1R9A+ODE6/ShrNxUr6Ckgt3ZeVPJmL76p2cgckM0t90HH3gVjuX46OjvqFCFIv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184149; c=relaxed/simple;
	bh=sMwVPTltHfO3qpFSttmFHlGGR/BCEXmL5/49LYpJ8XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZKLMYxlONpukWXkzeQquI6hbETCxfw4EEqJT/mcEP767hLTt7XwZ+nFek3BTKszsTlVCnYShcI8bLCzpMxHlT0X55ud/CPu3BqZFGLsozhFS0nYKYPswEH7znEAQKPJdrCPJWRT8X6UsQEtfjeucZnYjD+dt73tFkNMRAqZBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkNGrXyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A50C4CEEB;
	Tue, 22 Jul 2025 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753184148;
	bh=sMwVPTltHfO3qpFSttmFHlGGR/BCEXmL5/49LYpJ8XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkNGrXyOz7gYZ9G45raLdOnyB/1qKAZKWiu0evveWS5FL259QVDUdr5wf/hMt0vdL
	 ep8501P3fa5noxjlZl11z1uG6+7cxVttIxch42QnB/+ZkWdzUyGBFfJrKVuyRZQ7+C
	 pdqOTqz8NhNG5/LFvLozDNRFOoFoH41QGmw+oJpR1EVivyNYtX+Ao/MhgI6kID33kN
	 C0oR7RqzbqbHJ0C1tgvId+gQh0SS1eUnt2SZFbJoWnzXxvs7iyy/swjJRLmc12sv/v
	 28O+sUHw2rDZ9kcFr/4SLldWeWgHCvWGDD3zS9OYcegyKXUt1Xq97iXt9wUlmbY5IP
	 /DhGJAH9wX+3w==
Date: Tue, 22 Jul 2025 12:35:42 +0100
From: Simon Horman <horms@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <20250722113542.GG2459@horms.kernel.org>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721113238.18615-4-dong100@mucse.com>

On Mon, Jul 21, 2025 at 07:32:26PM +0800, Dong Yibo wrote:
> Initialize basic mbx function.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

...

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c

...

> +/**
> + * mucse_obtain_mbx_lock_pf - obtain mailbox lock
> + * @hw: pointer to the HW structure
> + * @mbx_id: Id of vf/fw to obtain
> + *
> + * This function maybe used in an irq handler.
> + *
> + * @return: 0 if we obtained the mailbox lock
> + **/
> +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	int try_cnt = 5000, ret;
> +	u32 reg;
> +
> +	reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> +				   PF2VF_MBOX_CTRL(mbx, mbx_id);
> +	while (try_cnt-- > 0) {
> +		/* Take ownership of the buffer */
> +		mbx_wr32(hw, reg, MBOX_PF_HOLD);
> +		/* force write back before check */
> +		wmb();
> +		if (mbx_rd32(hw, reg) & MBOX_PF_HOLD)
> +			return 0;
> +		udelay(100);
> +	}
> +	return ret;

ret is declared, and returned here.
But it is never initialised.

Perhaps it is appropriate to return an error value here,
and update the kernel doc for this function accordingly.

Flagged by W=1 builds with Clang 20.1.8, and Smatch.

> +}

...

