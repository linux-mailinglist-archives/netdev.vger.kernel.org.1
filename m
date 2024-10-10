Return-Path: <netdev+bounces-134272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93FC998A10
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE83AB315A3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834641CFEA1;
	Thu, 10 Oct 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D6y0SyxY"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A901A2643;
	Thu, 10 Oct 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569843; cv=none; b=mPG4/+PN3Ab2ebN77IUogIYAWpdGHiBWxc4mKU5QICGG0cGp6z7id5nH3r0MSYi6RkpLPHDDTmGYYido17aA7NlvvHget5mPSQWPy4LmdD0JaQioGdHfpa5xD1tXT8DU28bsnovnesUsaCxqB3hDMIkvOBbiraKiW7v5NRN4Mhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569843; c=relaxed/simple;
	bh=guCqFIJxLqNLcY6Y14ai2K/LRdX2l65W9MBudCd+gYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3MVHO10BDADfq3EoST6MmBBp5Xnh54rKX79Urkuucu6j7o1/JSYsuHf7azcZz76MCb038zMzQ58b92gDBY3dqspP23RBjGjRUtHVrE9VI3ppmSUurvSlS5JHmOf+dAksGa7E4MkHZ5svB6z0pNNnQkeXJts3kgAjYj26ky3RHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D6y0SyxY; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5783560005;
	Thu, 10 Oct 2024 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728569833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvDzmo6EKT1ReAMgCl1Bu8bTQ5PwamibsBtxtaF+4D0=;
	b=D6y0SyxY6JnYT8yHIye8YtKkPjiE6XaWRJY8obmm6XbgZNjR0YvawMKr75EG11At1gnXCg
	5bpAQyaYTTvuJRJftnumRr7//82YC35RkhbAaHjixZoNPgLOm4/uuoDPnSpVMkkC2NfHWn
	QL2hptevDecjg2gKWbGj5Bd0JeKlGh1wuEyJRVoJqSBjIfx7dbUXkbWajo5yaA+Q88Pyao
	m3d8WGBerPBsLDl/URfmIMB92NJhDBttP3dB3J5AbBu9uy5fxKSPr0UgzAo8jaHDbF6btm
	zllpzVuDn+kljkSG+jTdK9S/i4pAlh33cgZdAzMFCj5X7Ut5ETA0Cw3JVbAS+Q==
Date: Thu, 10 Oct 2024 16:17:11 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Jakub Kicinski <kuba@kernel.org>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, Russell King <linux@armlinux.org.uk>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v0] net: mvpp2: Add parser configuration for
 DSA tags
Message-ID: <20241010161711.114370ed@fedora.home>
In-Reply-To: <20241010015104.1888628-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20241010015104.1888628-1-aryan.srivastava@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Thu, 10 Oct 2024 14:51:04 +1300
Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz> wrote:

> Allow the header parser to consider DSA and EDSA tagging. Currently the
> parser is always configured to use the MH tag, but this results in poor
> traffic distribution across queues and sub-optimal performance (in the
> case where DSA or EDSA tags are in the header).
> 
> Add mechanism to check for tag type in use and then configure the
> parser correctly for this tag. This results in proper traffic
> distribution and hash calculation.
> 
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>

[...]

>  static int mvpp2_open(struct net_device *dev)
>  {
>  	struct mvpp2_port *port = netdev_priv(dev);
> @@ -4801,7 +4832,11 @@ static int mvpp2_open(struct net_device *dev)
>  		netdev_err(dev, "mvpp2_prs_mac_da_accept own addr failed\n");
>  		return err;
>  	}
> -	err = mvpp2_prs_tag_mode_set(port->priv, port->id, MVPP2_TAG_TYPE_MH);
> +
> +	if (netdev_uses_dsa(dev))
> +		err = mvpp2_prs_tag_mode_set(port->priv, port->id, mvpp2_get_tag(dev));
> +	else
> +		err = mvpp2_prs_tag_mode_set(port->priv, port->id, MVPP2_TAG_TYPE_MH);

This could unfortunately break VLAN filtering. If you look at the code
for mvpp2_prs_vid_entry_add() and mvpp2_prs_vid_enable_filtering(), the
value of the tag type set in MVPP2_MH_REG is used to compute the offset
at which the VLAN tag will be located.

It might be possible that users would :

 - Enable vlan filtering with :

ethtool -K ethX rx-vlan-filter on

 - Add vlan interfaces with :

ip link add link ethX name ethX.Y type vlan id Y

 - Set the interface up

ip link set ethX up => triggers a change in the DSA header size register

In that situation, the offset for the VLAN interface ethX.Y's header
will be incorrect, if the DSA tag type gets updated at .open() time.

So I think a solution would be to replace the read from the
MVPP2_MH_REG in the vlan filtering functions with a call your
newly-introduced mvpp2_get_tag, making sure that we use the correct tag
length for these parser entries as well.

Thanks,

Maxime

