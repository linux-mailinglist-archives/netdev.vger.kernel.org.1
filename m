Return-Path: <netdev+bounces-246774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A1CF11D4
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 17:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA8013008F89
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60D21A2C11;
	Sun,  4 Jan 2026 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiOFJVQx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9D1FD4;
	Sun,  4 Jan 2026 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767542735; cv=none; b=Rdpa6E0l/cjv5ebUY2FLKPs3InbRO6rU3Nx1GUQD+quNGHGqX+sn/W9nDtbOCFNM8ZINrksHNxhiqc9k9jjX8AZnQmwF/9wh/xaRvDqjEJLW2u2AwJK0duJPtw9sBbNiVLRlnRhIk5m7Or5bTo/Q3EiZdvM/CifdxizjHLINesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767542735; c=relaxed/simple;
	bh=ffJL5CR2yAuDbnHi+TMs/kcxGe7AOdLBUBGDuxzFhck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvm+Z3Ry1yOn1VNpfZBkEn3n+GyduGnYZYM6JzKk3BmlaoXZP3wwYLdl+nXu4nFvuLr4T2MHc56l1Ff6r8F8vnP2RENiv/RHKo9LI/leGEaeva0F4tTYuShkPHwrPOBtMHJVxlkl7Ym9AuKF2/R3yCPiySDq/Zv9v3pwWQzdQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiOFJVQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7673C4CEF7;
	Sun,  4 Jan 2026 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767542735;
	bh=ffJL5CR2yAuDbnHi+TMs/kcxGe7AOdLBUBGDuxzFhck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jiOFJVQxKENnNIuTGorF68CJXoSIecTdLsFG4XZLTv2fHyWskC4XcujMl0RX9euq/
	 OjKqbEUw/wgooa5n1UXyZw+CSExDHVoFXWpsEAczFkTDBjkEcAAgwvSp+ykqHt0EeE
	 xUgTeAdToeIZEeCQMQKmaCqhW3HjUXocXgiWXbf7haQVm/Gn0JCP+M8CQ0UZKka96r
	 tbSpi9aUF+xOlccP5Bzin0ko8LHyVxffJnl+lyh1SVr/++cvdazkbV3X6kADEkXACt
	 Djw6fyJ1JG1urV4FE8wpMF1Lh3BdZcGgf/olGXoCAScTuBgkZEne/WkN8ISrGtBIQU
	 mUn9CqCUh53hw==
Date: Sun, 4 Jan 2026 08:05:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH] net: sfp: add SMBus I2C block support
Message-ID: <20260104080534.769d4f87@kernel.org>
In-Reply-To: <20251228213331.472887-1-jelonek.jonas@gmail.com>
References: <20251228213331.472887-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Dec 2025 21:33:31 +0000 Jonas Jelonek wrote:
> +static int sfp_smbus_block_write(struct sfp *sfp, bool a2, u8 dev_addr,
> +				 void *buf, size_t len)
> +{
> +	size_t block_size = sfp->i2c_block_size;
> +	union i2c_smbus_data smbus_data;
> +	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	u8 *data = buf;
> +	u8 this_len;
> +	int ret;
> +
> +	while (len) {
> +		this_len = min(len, block_size);
> +
> +		smbus_data.block[0] = this_len;
> +		memcpy(&smbus_data.block[1], data, this_len);
> +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +				     I2C_SMBUS_WRITE, dev_addr,
> +				     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
> +		if (ret)
> +			return ret;
> +
> +		len -= this_len;
> +		data += this_len;
> +		dev_addr += this_len;
> +	}
> +
> +	return 0;
> +}

AI code review says:

 Should this return the number of bytes written instead of 0?

 The existing sfp_i2c_write() returns the byte count on success, and several
 callers depend on this return value:

 sfp_cotsworks_fixup_check() checks:
    err = sfp_write(sfp, false, SFP_PHYS_ID, &id->base, 3);
    if (err != 3) { ... error path ... }

 sfp_sm_mod_hpower() via sfp_modify_u8() checks:
    if (err != sizeof(u8)) { ... error path ... }

 With this function returning 0 on success, these checks will always fail,
 causing high-power SFP modules to fail initialization with "failed to enable
 high power" errors, and Cotsworks module EEPROM fixups to fail with "Failed
 to rewrite module EEPROM" errors.

Either way, you'll need to repost, net-next was closed when you posted.
-- 
pw-bot: cr

