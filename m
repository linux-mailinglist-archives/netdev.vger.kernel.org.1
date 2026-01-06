Return-Path: <netdev+bounces-247253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B2BCF64C8
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D1203014BEB
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE827FD74;
	Tue,  6 Jan 2026 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXgEKj7U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EDE26F293;
	Tue,  6 Jan 2026 01:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663224; cv=none; b=Qx7MeButYFRFTyUXw5f61sVPdyPbQPnKa/+/Cht+pSiOPCJrJZF46VfJlniTX90VmyE9MNnIGg0nOMoaGpt6Y2qDQkm5QVMJyrvV3x7btrl0fSfA4vcp4OKhhmMT19VWny3br/JTw5IfG+4nEp5vVfFQ4HQcU0Vo92tX4T5xMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663224; c=relaxed/simple;
	bh=VIA3uR/C3e8FYpm2QbYQDDm/OIJZjo/NgGqiYsue+ow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDeDXOaNRTXYuhoNnLhl1CKwm6v0gW/hwo/Hov1IotYPUBgNOGXbW7CCQzG99BT5Mg0zJTUAWegkWinTB10y5tpQEx+y3e6EibQEMewZ/TpvcBS/sX2Ob37+0T21uzbxNb5xYo7b9S8bW2WwRk3tuzWKlT+crow/82QhoVl1Lc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXgEKj7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E2AC116D0;
	Tue,  6 Jan 2026 01:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663223;
	bh=VIA3uR/C3e8FYpm2QbYQDDm/OIJZjo/NgGqiYsue+ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DXgEKj7UQkbpjpXlqpzMZ998qeNCB73jZxex5+eUwILATKJS1HbPx3xsDCEZ7dkNw
	 FjP4QfdkbI1/Doz4ZPZNfKd1ETZxHxA4069LgMqhMKsQS6hHv7yaaKP+VLtp4p1q/s
	 QyNxGP7+cYilCeLN9DG4DgVz0FTC9tbMWPO3irDJEpEev0DmEdWjvTGKQscDW4ndYr
	 sPUtoTz+DLEkEVIkktt4h066uPsPNTtS2l1PhWp7gEX1yPoT8sWTii4ijZAGOZdWYo
	 M8hnvFR1Ea6gENPufM5dSjuTQgsHuq+erCUGrI6EiS/qVzM0kGuNxXEEFhOxbv9tI+
	 Qr3nVkqRvfj9w==
Date: Mon, 5 Jan 2026 17:33:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: dsa: yt921x: Protect MIB stats
 with a lock
Message-ID: <20260105173342.65654f22@kernel.org>
In-Reply-To: <20260105020905.3522484-3-mmyangfl@gmail.com>
References: <20260105020905.3522484-1-mmyangfl@gmail.com>
	<20260105020905.3522484-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Jan 2026 10:09:01 +0800 David Yang wrote:
> -	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
> -			mib->rx_128_255byte + mib->rx_256_511byte +
> -			mib->rx_512_1023byte + mib->rx_1024_1518byte +
> -			mib->rx_jumbo;
> -	pp->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
> -			mib->tx_128_255byte + mib->tx_256_511byte +
> -			mib->tx_512_1023byte + mib->tx_1024_1518byte +
> -			mib->tx_jumbo;
> -
> -	if (res)
> +	if (res) {
>  		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
>  			port, res);
> -	return res;
> +		return res;
> +	}
> +
> +	rx_frames = mib->rx_64byte + mib->rx_65_127byte +
> +		    mib->rx_128_255byte + mib->rx_256_511byte +
> +		    mib->rx_512_1023byte + mib->rx_1024_1518byte +
> +		    mib->rx_jumbo;
> +	tx_frames = mib->tx_64byte + mib->tx_65_127byte +
> +		    mib->tx_128_255byte + mib->tx_256_511byte +
> +		    mib->tx_512_1023byte + mib->tx_1024_1518byte +
> +		    mib->tx_jumbo;

Should this not use mib_new now? (or live inside the spin lock after
copying over?)

> +	spin_lock(&pp->stats_lock);
> +	*mib = *mib_new;
> +	pp->rx_frames = rx_frames;
> +	pp->tx_frames = tx_frames;
> +	spin_unlock(&pp->stats_lock);

> diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
> index 61bb0ab3b09a..0c9d1b6cbc23 100644
> --- a/drivers/net/dsa/yt921x.h
> +++ b/drivers/net/dsa/yt921x.h
> @@ -533,9 +533,14 @@ struct yt921x_port {
>  	bool isolated;
>  
>  	struct delayed_work mib_read;
> +	/* protect the access to mib, rx_frames and tx_frames */
> +	spinlock_t stats_lock;

looks like spin_lock_init() is missing

