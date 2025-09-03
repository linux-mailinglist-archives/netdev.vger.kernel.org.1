Return-Path: <netdev+bounces-219722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC82B42CBE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADC13B484A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9022EBB84;
	Wed,  3 Sep 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NuLDJx/V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90548155333;
	Wed,  3 Sep 2025 22:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938308; cv=none; b=BLZ7rdp+y0E3FFB3RMDzDoKCwUKkoY1Jpj2rGTvYPk0WHuOvsncjr6qIxXBBdQSjzIN5cdONL7TBRtsq56I/YlLwIqk0II5+GUavzHMHEoODAWi7jNpFnaJ/1vXlqN4mvLFEBuZ3fiUgpWdQtSM+3A+PJ/Bb5KAE/w001IWH1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938308; c=relaxed/simple;
	bh=PAqn5ll1w4WzA93V6UQALMVRNrs6OiC8TUzJboJnmk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewsye/mTYauq+E2xMSi5X4RVBf1WRsmqJYCqhCJzb2lg+B7nOo5LzlPCF3rj/ntdhpcW7KHohAo0tNpXM0gsJJW/1F5/7IkfuQT0qjD5z66pfN7SZnxo+XU9jZjeV0f7hNjTHtC9W0A72YdGuzC4LHK4x5P5m8Q2XdC7VzS269g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NuLDJx/V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hOnnk2noF78dfU4ZbGRpjhX2RXceifum6ah+cMOBfng=; b=NuLDJx/VtDjySh6kD/OJEVSaBC
	bzSz26/RcgKObjJWpskrD77FACyb/aVax19Hk6rFmi38QUqQ/k/WSPAc7Pvsv5X3465V247yIdM7M
	KN0BOZlB54aQf6O8CQmwW8aJv2TBN8dvkUg9Z/krfp9DUO0raBiYEP6OZN9FDTmXwdZQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utvtp-0076Ff-N1; Thu, 04 Sep 2025 00:24:17 +0200
Date: Thu, 4 Sep 2025 00:24:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <659df824-7509-4ffe-949b-187d7d44f69f@lunn.ch>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-4-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903025430.864836-4-dong100@mucse.com>

>  struct mucse_mbx_info {
> +	struct mucse_mbx_stats stats;
> +	u32 timeout;
> +	u32 usec_delay;
> +	u16 size;
> +	u16 fw_req;
> +	u16 fw_ack;
> +	/* lock for only one use mbx */
> +	struct mutex lock;
>  	/* fw <--> pf mbx */
>  	u32 fw_pf_shm_base;
>  	u32 pf2fw_mbox_ctrl;

> +/**
> + * mucse_obtain_mbx_lock_pf - Obtain mailbox lock
> + * @hw: pointer to the HW structure
> + *
> + * This function maybe used in an irq handler.
> + *
> + * Return: 0 if we obtained the mailbox lock or else -EIO
> + **/
> +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	int try_cnt = 5000;
> +	u32 reg;
> +
> +	reg = PF2FW_MBOX_CTRL(mbx);
> +	while (try_cnt-- > 0) {
> +		mbx_ctrl_wr32(mbx, reg, MBOX_PF_HOLD);
> +		/* force write back before check */
> +		wmb();
> +		if (mbx_ctrl_rd32(mbx, reg) & MBOX_PF_HOLD)
> +			return 0;
> +		udelay(100);
> +	}
> +	return -EIO;
> +}

If there is a function which obtains a lock, there is normally a
function which releases a lock. But i don't see it.

> +void mucse_init_mbx_params_pf(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +	mbx->usec_delay = 100;
> +	mbx->timeout = (4 * USEC_PER_SEC) / mbx->usec_delay;
> +	mbx->stats.msgs_tx = 0;
> +	mbx->stats.msgs_rx = 0;
> +	mbx->stats.reqs = 0;
> +	mbx->stats.acks = 0;
> +	mbx->size = MUCSE_MAILBOX_BYTES;
> +	mutex_init(&mbx->lock);

And this mutex never seems to be used anywhere. What is it supposed to
be protecting?

    Andrew

---
pw-bot: cr

