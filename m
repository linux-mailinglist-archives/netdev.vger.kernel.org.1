Return-Path: <netdev+bounces-240523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFD5C75D36
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id CDFB531073
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484A22FFFAA;
	Thu, 20 Nov 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xzaxSAsk"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC936923F
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661101; cv=none; b=SeBZqnBh2R0DCI9Wvp6KQOZ7CKOxJZggmGVaabFsqJKKZD/DS13LPAinBwEGshTYMM0dW2XwMTIyv+Vf3phRYNNjbW6HEO2gEfE8YHy+cjnN3v9Fo+beX+2buYqQN+akzUhUEsLmBmGYCIytEIP/SVClUjWd3Jlohl4JdBjQRgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661101; c=relaxed/simple;
	bh=uFFOEGLt9aKAJTVZxJzdeOHYx8gT2dpI664umDPAfts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+smfbQ4cV1/+SJ936zaQ0B1E23LV89l5ntkAHarwcswLUOpRPWUCUwKIE4j/DJw/FnjePUyj5PWEudGDkDXy8VA9IqzziWy5XwEMcgpMMXqCxFGjIfLucCB1u0l6hGi35nODFCfizhKh4YfA4kSzMgmKhm5sggu3pk8kiI0s0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xzaxSAsk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0EBC81A1C2F;
	Thu, 20 Nov 2025 17:51:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C4E20606F6;
	Thu, 20 Nov 2025 17:51:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00D3A10371736;
	Thu, 20 Nov 2025 18:51:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763661093; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7ABPrXxvBJZCgRLEzJyFpt3vx97Pq+jHZv+gV5c1gyw=;
	b=xzaxSAskebZChTucMCk1HgEjIWy4ShXaYv/VCYt9eQQSNWmgTF1PI02jAQibWiCzVdMJIO
	9I11gGboFtLhVyE7T4aeEq2tCJO1chwIiLIX0+5OqNB03xMt5KQ9IA/gVNEQ596wxT7COV
	eQ7xm2k5uiJbUFS0T9EeFifJPcN0STHBSrouq4UZgcV5bfj4syewUc3Q/UqE7x3yILSb2L
	aDLERAnLmqDupGeprFui+miW69o/sgV+7lgSxkcHSouH047sjbrbIJsPcXzH8yrvCR03Na
	iqGd9j5bmn7h8JtxFiKlkpnpWwgnqa7ii0ea280aNew+OhAPSM0vsdTIyk8KXQ==
Date: Thu, 20 Nov 2025 18:51:26 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrei Botila
 <andrei.botila@oss.nxp.com>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, "Russell
 King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH net-next v4 2/7] phy: add hwtstamp_get callback to phy
 drivers
Message-ID: <20251120185126.6e536058@kmaincent-XPS-13-7390>
In-Reply-To: <20251120174540.273859-3-vadim.fedorenko@linux.dev>
References: <20251120174540.273859-1-vadim.fedorenko@linux.dev>
	<20251120174540.273859-3-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 20 Nov 2025 17:45:35 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> PHY devices had lack of hwtstamp_get callback even though most of them
> are tracking configuration info. Introduce new call back to
> mii_timestamper.

It's a pity you didn't take my comment into account. :/

" It would be nice to update this kdoc note:
https://elixir.bootlin.com/linux/v6.18-rc6/source/net/core/dev_ioctl.c#L252=
 "

> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/phy/phy.c           | 3 +++
>  include/linux/mii_timestamper.h | 5 +++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 350bc23c1fdb..13dd1691886d 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -478,6 +478,9 @@ int __phy_hwtstamp_get(struct phy_device *phydev,
>  	if (!phydev)
>  		return -ENODEV;
> =20
> +	if (phydev->mii_ts && phydev->mii_ts->hwtstamp_get)
> +		return phydev->mii_ts->hwtstamp_get(phydev->mii_ts, config);
> +
>  	return -EOPNOTSUPP;
>  }
> =20
> diff --git a/include/linux/mii_timestamper.h b/include/linux/mii_timestam=
per.h
> index 08863c0e9ea3..3102c425c8e0 100644
> --- a/include/linux/mii_timestamper.h
> +++ b/include/linux/mii_timestamper.h
> @@ -29,6 +29,8 @@ struct phy_device;
>   *
>   * @hwtstamp_set: Handles SIOCSHWTSTAMP ioctl for hardware time stamping.
>   *
> + * @hwtstamp_get: Handles SIOCGHWTSTAMP ioctl for hardware time stamping.
> + *
>   * @link_state: Allows the device to respond to changes in the link
>   *		state.  The caller invokes this function while holding
>   *		the phy_device mutex.
> @@ -55,6 +57,9 @@ struct mii_timestamper {
>  			     struct kernel_hwtstamp_config *kernel_config,
>  			     struct netlink_ext_ack *extack);
> =20
> +	int  (*hwtstamp_get)(struct mii_timestamper *mii_ts,
> +			     struct kernel_hwtstamp_config *kernel_config);
> +
>  	void (*link_state)(struct mii_timestamper *mii_ts,
>  			   struct phy_device *phydev);
> =20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

