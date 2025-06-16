Return-Path: <netdev+bounces-198156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB0FADB6ED
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D49D163555
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83CA2882C0;
	Mon, 16 Jun 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxBtrlgy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B73264A85;
	Mon, 16 Jun 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091450; cv=none; b=L9QqioAwcKtDnlm/9sEmrnxgurwLzm+FYxSWGHzQ8LcBUYuzbaJULAO5n8qeSezQJRlsUL1BD67LfgLGy3Lj4Sgmqrui4xj3n4qK2EWBaTka4QZjM+QN8Lj5/6c+JuJv03GM8GH+NfHzQ9YK7kWWHE+DdckRZcy9PNSQjmOD1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091450; c=relaxed/simple;
	bh=tEbrrBPamW7MT/SxnwKmIuHVJnO2tf+zHhE1P4jeIPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOx4O+Of5aCnttGjH//SmSZhlUYm9eAAG5CwGuh9DsrakdR/qWFnmWJZDqZ7MEGS6ZzLzp0MCTh1hxxayMQq4E0lMwOlR+i/43pZVXAgu9kod/ahZ+s+YrkQdQu8JweMBNZc2cj64uqIGHiN27sITUtS4yZCDUGxCeICdsefAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxBtrlgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1062AC4CEEA;
	Mon, 16 Jun 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750091449;
	bh=tEbrrBPamW7MT/SxnwKmIuHVJnO2tf+zHhE1P4jeIPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sxBtrlgyyZL34AwgxPokLe+cV1d1wV431iiNGfmbZsrAFv0M/1D4HSu1VHbXBTG0P
	 /jlRayOYfuGFPOLTZ/H6jQGdXM+wuGju6tvRMPX8I4cQOf26pAjD9bLnwbQ3yDZxBX
	 brhck7TnmBPASOpyX4bbaVn8MQlYbQuUXXixcpfaVQPIYgZV+uINpDauiBP1hHBBPO
	 AgCygjeVH35uL0caKZOWtpvAD3uzSAJ+bKOnFc693rFcxxCG4PHHtRyv+J56K8YiBJ
	 7CtRCx8zxX3f2qJgI0z0RSBEh8pMJQmdXz8tZLB6ZQC1Ro899ptCb9ykumJbOCU5p8
	 9dtkX/dYxJYfA==
Date: Mon, 16 Jun 2025 09:30:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 02/13] net: pse-pd: Add support for
 reporting events
Message-ID: <20250616093048.0a0ff1aa@kernel.org>
In-Reply-To: <20250616141012.31305f81@kmaincent-XPS-13-7390>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
	<20250610-feature_poe_port_prio-v13-2-c5edc16b9ee2@bootlin.com>
	<20250614121843.427cfc42@kernel.org>
	<20250616135722.2645177e@kmaincent-XPS-13-7390>
	<20250616141012.31305f81@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 14:10:12 +0200 Kory Maincent wrote:
> psec = pse_control_find_by_id(pcdev, i, &tracker);
> rtnl_lock();
> if (psec && psec->attached_phydev &&
>     psec->attached_phydev->attached_dev)
> 	ethnl_pse_send_ntf(psec->attached_phydev->attached_dev, notifs,
> 			   &extack);
> rtnl_unlock();
> pse_control_put(psec);

You can add another helper for clarity:

pse_control_get_netdev()
{
	ASSERT_RTNL();

	if (!psec || !psec->attached_phydev)
		return NULL
	return psec->attached_phydev->attached_dev;
}

psec = pse_control_find_by_id(pcdev, i, &tracker);
rtnl_lock();
netdev = pse_control_get_netdev(psec);
if (netdev)
	ethnl_pse_send_ntf(netdev, notifs, &extack);
rtnl_unlock();
pse_control_put(psec);

?

