Return-Path: <netdev+bounces-227420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8863BAEE6A
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 02:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377E5192223B
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 00:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34051DF24F;
	Wed,  1 Oct 2025 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdu56fbS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C415E5D4;
	Wed,  1 Oct 2025 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279193; cv=none; b=Z1kgh8BzHzEk0wwbYW/aFkQU8VrGkZceilIqu512blCH5JQEj7UbYDbyo2SD4ny0nIINOy7OnHEGtn4cWlt/W2psavAg8wcWbLKr6f4fpb7AC3GMTdKaT9qLXVdt5MNLZkdMMpxDV2CxM17VSZqpfvqptMYE8HfcSF9Ci1RmERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279193; c=relaxed/simple;
	bh=xb4+cGTMvyksuif/IGkUC2xT0PGtZXT9vVR3DiP2M4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ki1r9uR8Feom9wvwaqIWkguJ8yD+RtyJJdhSWMqfwrKi5qbl6W4AKIILt1rlGGYibU3DuBtB3LloKAeFXAp+V469ZYGu/QSPVFXYNFrm//Po9PuJDYWx0SoQ+sJCAGm/rfh520Gg0WBpiA27Wj2j0/aF9HJiw224DHWu175PuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdu56fbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F0AC113D0;
	Wed,  1 Oct 2025 00:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759279192;
	bh=xb4+cGTMvyksuif/IGkUC2xT0PGtZXT9vVR3DiP2M4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mdu56fbSjWhwxAZTR5ia937fJnEh1rPMp6Ul5iWHFYEv45lU2WkVbf/cGmnOE1r85
	 paI72q6uCBh2dzGNiTnE9fnWx3qE+I+MdRJa8cGqbvPshArNvTRfTUe5I0q0p2nrP7
	 BBz1foipBh1Z1fdhvEGzy5203rMgCRagz3OsW1B4kEzZBT3pmCGLmwNUv0dS9W8D0M
	 +jOpghwV8yqFoj7Cwe94si8LgE4vjdWcc9C8cSYs/zXucqKz332D/s4KHjzuu/GxnH
	 gsKMOYe/VAvTaxerr7yAfIXTDopYXYj570YExLwpNhNsqXXNMuxROA+iRFk3TZpku8
	 Yo7G7PdgIpE2w==
Date: Tue, 30 Sep 2025 17:39:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, o.rempel@pengutronix.de,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout
 error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
Message-ID: <20250930173950.5d7636e2@kernel.org>
In-Reply-To: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
References: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 14:19:02 +0530 Bhanu Seshu Kumar Valluri wrote:
> +	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
> +		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
> +		/* If USB fails, there is nothing to do */
> +		if (rc < 0)
> +			return rc;
> +	}
> +	return ret;

I don't think you need to add and handle rc here separately?
rc can only be <= so save the answer to ret and "fall thru"?
-- 
pw-bot: cr

