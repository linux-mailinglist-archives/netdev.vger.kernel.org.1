Return-Path: <netdev+bounces-215395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89566B2E687
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A415E572F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D825B2FA;
	Wed, 20 Aug 2025 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="urVzqRfe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09268296BD4;
	Wed, 20 Aug 2025 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721458; cv=none; b=KveZUKKShPVoYxOcDpwfQC7M8JVhFbRUZhw5Bn0/xisouNT7UhWGeZlHdNKPnONQQd/zlJ+T6aKjMwukN9ZyGTHw1s4Dx/8fzL6hLMm1ULTZ1B46bQred5Uqjz77WRw15DnNKXK6m0JLL4kjmabpsZbdoBl6+Q81GNbKCIctpCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721458; c=relaxed/simple;
	bh=LXRHQ55brtLcrhsy+1XNwSfC2tXC8DF/Ug1c1yfudag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgTGvv5XW2l3pVAkkWvFvpnuy39iXxnSxCuuLIhCHRZpib9oKjXzhhW6tiO3NCskeUay2rNZX7LdufAYXuy8Rltc7huyR6hoqbtpGxtXMYWphLS1riUyCxFeK314N+ykEpmtfnZSWDfW9r9V5xhLw1h7VNfX/fZYJssiPTmwHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=urVzqRfe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rAiyKOmcECi1Vq/23AujM+lyO0YeAmjuxCNHgLIPOyI=; b=urVzqRfeehJyq2ZrWm/jxS4VnO
	SVEY4PaDiGGAkmZzQ/mIwuft3n6bqYykmbiHSAV41w4c57oqGRqDgagLaY65Cb+jVK7acfmOHhyMw
	86z0MW8hQCUFNivznpz2eibMpuKIRB/BihBCVmUZXKMJuXZtUtj22nsGERxmgiPgdhh8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uopLU-005Mbv-2t; Wed, 20 Aug 2025 22:23:44 +0200
Date: Wed, 20 Aug 2025 22:23:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <5cced097-52db-41c9-93e4-927aab5ffb2e@lunn.ch>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-4-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818112856.1446278-4-dong100@mucse.com>

> +/**
> + * mucse_mbx_get_ack - Read ack from reg
> + * @mbx: pointer to the MBX structure
> + * @reg: register to read
> + *
> + * @return: the ack value
> + **/
> +static u16 mucse_mbx_get_ack(struct mucse_mbx_info *mbx, int reg)
> +{
> +	return (mbx_data_rd32(mbx, reg) >> 16);
> +}

> +static int mucse_check_for_ack_pf(struct mucse_hw *hw)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	u16 hw_fw_ack;
> +
> +	hw_fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);

> +int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	int size_inwords = size / 4;
> +	u32 ctrl_reg;
> +	int ret;
> +	int i;
> +
> +	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
> +	ret = mucse_obtain_mbx_lock_pf(hw);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < size_inwords; i++)
> +		mbx_data_wr32(mbx, MBX_FW_PF_SHM_DATA + i * 4, msg[i]);
> +
> +	/* flush msg and acks as we are overwriting the message buffer */
> +	hw->mbx.fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);

It seems like the ACK is always at MBX_FW2PF_COUNTER. So why pass it
to mucse_mbx_get_ack()? Please look at your other getters and setters.

> +/**
> + * mucse_write_mbx - Write a message to the mailbox
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> +{
> +	return mucse_write_mbx_pf(hw, msg, size);
> +}

This function does not do anything useful. Why not call
mucse_write_mbx_pf() directly?

> +/**
> + * mucse_check_for_msg - Check to see if fw sent us mail
> + * @hw: pointer to the HW structure
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_check_for_msg(struct mucse_hw *hw)
> +{
> +	return mucse_check_for_msg_pf(hw);
> +}
> +
> +/**
> + * mucse_check_for_ack - Check to see if fw sent us ACK
> + * @hw: pointer to the HW structure
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_check_for_ack(struct mucse_hw *hw)
> +{
> +	return mucse_check_for_ack_pf(hw);
> +}

These as well.

	Andrew

