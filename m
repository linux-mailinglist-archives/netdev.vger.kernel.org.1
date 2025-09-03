Return-Path: <netdev+bounces-219729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0399B42CEC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4AE3AF986
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C492DCC13;
	Wed,  3 Sep 2025 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kgLW9QU8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57A19C560;
	Wed,  3 Sep 2025 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939581; cv=none; b=LaCqOOr02sNXdkyv83LT4KKOzOMmoybqdB4MoF+72q+adC4tHnOVJiWL/q1NJ4NdAqrI65TyYV1BI3TN+GN5yvWMyK9TM7tIfb/e69YzOij2VFJ6rXIq6YTal3eKJC3r7qztYIumqmJ13ipReo79EP4mc3vy8sX60DNtJ/9D5yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939581; c=relaxed/simple;
	bh=E14G7hz4s7ZeraM27XTKxEUx9yqEMxZn0gjMb5mg+Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+UMLYT4TGcqBa7R/nuzP10PaGv8y3GNnERZJfRj0uwedN7htwjtpGJzRry0llROQbyxL9orkIeHR9Foaea8qv+H1vU+HW2Vd5Okdq8QltfNDS/o6cYfgE57yQCihSwtur0KLYLwq/kMDitwNY2i3Pbxz4f482OUru0GVi8iYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kgLW9QU8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7bTvRnVvVrdfJ0JlVJfNw8ILrW2UjTWiVk6aSWpIF4o=; b=kgLW9QU8Ncl0JCWG9zxLcy6027
	qExkkYTYK9wyu3uwEhwlhSPDNvDcHvWKlmLqgRL4U8pKuvCnJNqWz80FBbnE5ZELuEpQT5ItwMExS
	jwHtmSlG2uSv1rDDN9JakBjTQvRVuc92CsF5dCUKVukVdYzchFDMDF5Tl8VNkm7EzBRc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utwEZ-0076SB-85; Thu, 04 Sep 2025 00:45:43 +0200
Date: Thu, 4 Sep 2025 00:45:43 +0200
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
Subject: Re: [PATCH net-next v10 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <19ca3e80-97f7-428a-bf09-f713706fd6ab@lunn.ch>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903025430.864836-5-dong100@mucse.com>

> +/**
> + * mucse_mbx_powerup - Echo fw to powerup
> + * @hw: pointer to the HW structure
> + * @is_powerup: true for powerup, false for powerdown
> + *
> + * mucse_mbx_powerup echo fw to change working frequency
> + * to normal after received true, and reduce working frequency
> + * if false.
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +int mucse_mbx_powerup(struct mucse_hw *hw, bool is_powerup)
> +{
> +	struct mbx_fw_cmd_req req = {};
> +	int len;
> +	int err;
> +
> +	build_powerup(&req, is_powerup);
> +	len = le16_to_cpu(req.datalen);
> +	mutex_lock(&hw->mbx.lock);
> +
> +	if (is_powerup) {
> +		err = mucse_write_posted_mbx(hw, (u32 *)&req,
> +					     len);
> +	} else {
> +		err = mucse_write_mbx_pf(hw, (u32 *)&req,
> +					 len);
> +	}

It looks odd that this is asymmetric. Why is a different low level
function used between power up and power down?

> +int mucse_mbx_reset_hw(struct mucse_hw *hw)
> +{
> +	struct mbx_fw_cmd_reply reply = {};
> +	struct mbx_fw_cmd_req req = {};
> +
> +	build_reset_hw_req(&req);
> +	return mucse_fw_send_cmd_wait(hw, &req, &reply);
> +}

And this uses a third low level API different to power up and power
down?

	Andrew

