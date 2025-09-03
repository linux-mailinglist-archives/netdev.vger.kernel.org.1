Return-Path: <netdev+bounces-219637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAA8B4272E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3668448095C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74383126B3;
	Wed,  3 Sep 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emx9N4el"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79952304971;
	Wed,  3 Sep 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917878; cv=none; b=pWBPrVV/ITo1+S7/1HKCq57xinTNE00p3VccDr+hifOuYCZtNvc+nVADwKmCGlVgecspmdVveyyxGo8zN5QZPykxTL45Xg5KLsCFWblVM9rZ8m4KtD6o5B+8R0GSAtAv4lcImveVugBI+km8q3BjR81mt/0k6KLt+fUCRKg5kzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917878; c=relaxed/simple;
	bh=i/Nlpyf6049cvEbac9097z7Dtvp2kNHFjvpzDfbTlhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFge0Xkk0fOYFusFidHJETtqcSYORv224Rh2Gkc9s/Y88UupolFimpvgQ9IqvueXATvJKSbfGaXW/V8efrxG5BPKLcMfyAnnw6p7qW8Sx6yr96HFruT3mPW5+5GXmcM3gy1nlwaJ5H9dGsX6QmvjTtfhLxcGbR3b8rgBxHOEVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emx9N4el; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B04DC4CEE7;
	Wed,  3 Sep 2025 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756917878;
	bh=i/Nlpyf6049cvEbac9097z7Dtvp2kNHFjvpzDfbTlhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Emx9N4elMpE1TUw9YeZsO399zAbTV/bxbFiYSQokruUc89e9oB8nrJh7Sh+dg+Qht
	 r5CfHYLOcf1ohP8dDx9r6HpV2nyS8kcCLpJthfFtfq1azbE7SaKiK844WVxC0FW41c
	 8TgId8zBbe+zZdnyfskvSU16TEo3Hp9GdThETGMyqyLvXeXnvIkHIZ0dOUeC9XFIl8
	 Orc31/q+fEPNlnulcN7nhFLVyIy+WViMxeybSlzDt9rM0havE/OXuuCTqCmYa/6yjs
	 DDp7Ct+EHA23QKZEKzm61gUM9gxgccgJX1mQjjjf47OzETK3L9GgJ/6xU4L92aH6N/
	 saetrm8P4i9hg==
Date: Wed, 3 Sep 2025 17:44:31 +0100
From: Simon Horman <horms@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <20250903164431.GD361157@horms.kernel.org>
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

On Wed, Sep 03, 2025 at 10:54:28AM +0800, Dong Yibo wrote:
> Initialize basic mbx function.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>

...

> +/**
> + * mucse_mbx_inc_pf_req - Increase req
> + * @hw: pointer to the HW structure
> + *
> + * mucse_mbx_inc_pf_req read pf_req from hw, then write
> + * new value back after increase
> + **/
> +static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	u16 req;
> +	u32 v;
> +
> +	v = mbx_data_rd32(mbx, MBX_PF2FW_COUNTER);
> +	req = (v & GENMASK_U32(15, 0));

nit1: Unnecessary parentheses
nit2: I would have used FIELD_GET here in conjunction with something like.

      #define MBX_PF2FW_COUNTER_MASK GENMASK_U32(15, 0)

> +	req++;
> +	v &= GENMASK_U32(31, 16);
> +	v |= req;

      And using FIELD_PREP is probably more succinct here.

      Likewise in the following function

> +	mbx_data_wr32(mbx, MBX_PF2FW_COUNTER, v);
> +	hw->mbx.stats.msgs_tx++;
> +}
> +
> +/**
> + * mucse_mbx_inc_pf_ack - Increase ack
> + * @hw: pointer to the HW structure
> + *
> + * mucse_mbx_inc_pf_ack read pf_ack from hw, then write
> + * new value back after increase
> + **/
> +static void mucse_mbx_inc_pf_ack(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	u16 ack;
> +	u32 v;
> +
> +	v = mbx_data_rd32(mbx, MBX_PF2FW_COUNTER);
> +	ack = (v >> 16) & GENMASK_U32(15, 0);
> +	ack++;
> +	v &= GENMASK_U32(15, 0);
> +	v |= (ack << 16);
> +	mbx_data_wr32(mbx, MBX_PF2FW_COUNTER, v);
> +	hw->mbx.stats.msgs_rx++;
> +}

...

> +/**
> + * mucse_mbx_reset - Reset mbx info, sync info from regs
> + * @hw: pointer to the HW structure
> + *
> + * This function reset all mbx variables to default.
> + **/
> +static void mucse_mbx_reset(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	u32 v;
> +
> +	v = mbx_data_rd32(mbx, MBX_FW2PF_COUNTER);
> +	hw->mbx.fw_req = v & GENMASK_U32(15, 0);
> +	hw->mbx.fw_ack = (v >> 16) & GENMASK_U32(15, 0);

I'd use FIELD_GET here too.

> +	mbx_ctrl_wr32(mbx, PF2FW_MBOX_CTRL(mbx), 0);
> +	mbx_ctrl_wr32(mbx, FW_PF_MBOX_MASK(mbx), GENMASK_U32(31, 16));
> +}

...

