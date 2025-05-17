Return-Path: <netdev+bounces-191258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 193F5ABA79D
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B671BC0DE7
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB17261E;
	Sat, 17 May 2025 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K43Cg5J1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65D747F;
	Sat, 17 May 2025 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747446747; cv=none; b=HNI9QE5d4cPK1MDMs+ZDT30z4vmESxKQttnvHIUSm6wghwWT7+ZALZTJPbSspsOXY0J2Xt+EmQ7yJ0h7b/9pj1jpG7oKCHF50OMnNxud1kjMRGwSSzqya+IhE5csm4A/XIt8Jil3LEfT8iqsEGDe5hvKYy8UGD4XL/Rv2/WPWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747446747; c=relaxed/simple;
	bh=K+FlUYn7vRkIibQQqBWQlJdAWMBpKiDsBVkv1Au5ZZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWF0gndUoNVT6dOon8v+MXqnpxWZkMtVkVh+wfLKpeLThVoEmCg5lImjw4NcOB9uEl0nvwvf3YftyOOZgyan2PuuD0F2TQTRQv1L+jmWDZgYd8N62WhcuOZ4q/3pIchn0+uhcplTN0T2kP2Mz/pUYBWTBaYdggzruLygFeOiZYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K43Cg5J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEC2C4CEE4;
	Sat, 17 May 2025 01:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747446746;
	bh=K+FlUYn7vRkIibQQqBWQlJdAWMBpKiDsBVkv1Au5ZZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K43Cg5J1Q5o22zp8nAhkhWTOxlYdOLYw34RZybfTy1APBRgaBm1baExlxG+57+Yfz
	 AIbvq0ZAFMXVuD3jep4vsJhlQEZtxueQg5Eb6X5cDzBymarBRb6S0RjI30o8sYC7qf
	 9p3aOO7bbc5lwlHbVU/r9hQoSCX5GHiXVLAk9txWsD8rbh40/XknvmQp4iqa4szXO+
	 8NKpJ1V4JF3q2lQmnopIrJByi8Ignq55IWehXjkDetWg1bbVirOc3TadC4oxprWYi0
	 G5wK7WOgPQiIJOcKlSLqWuBg+E2SMxl5Pox8W02QPFw/sUKiBXWT8kFtl6m/y6/oDM
	 B68myD/zn8dGg==
Date: Fri, 16 May 2025 18:52:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jeroendb@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, ziweixiao@google.com, pkaligineedi@google.com,
 yyd@google.com, joshwash@google.com, shailend@google.com,
 linux@treblig.org, thostet@google.com, jfraker@google.com,
 richardcochran@gmail.com, jdamato@fastly.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/8] gve: Add support for SIOC[GS]HWTSTAMP
 IOCTLs
Message-ID: <20250516185225.137d0966@kernel.org>
In-Reply-To: <20250517001110.183077-8-hramamurthy@google.com>
References: <20250517001110.183077-1-hramamurthy@google.com>
	<20250517001110.183077-8-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 May 2025 00:11:09 +0000 Harshitha Ramamurthy wrote:
> Subject: [PATCH net-next v2 7/8] gve: Add support for SIOC[GS]HWTSTAMP IOCTLs

Sorry for the very shallow review, the subject jumped out at me.
You're not implementing the shouty ioctl, you're adding ndos.

> +	if (kernel_config->tx_type != HWTSTAMP_TX_OFF) {
> +		dev_err(&priv->pdev->dev, "TX timestamping is not supported\n");

please use extack

> +		return -ERANGE;
> +	}
> +
> +	if (kernel_config->rx_filter != HWTSTAMP_FILTER_NONE) {
> +		kernel_config->rx_filter = HWTSTAMP_FILTER_ALL;
> +		if (!priv->nic_ts_report) {
> +			err = gve_init_clock(priv);
> +			if (err) {
> +				dev_err(&priv->pdev->dev,
> +					"Failed to initialize GVE clock\n");

and here. Remember to remove the \n when converting.

