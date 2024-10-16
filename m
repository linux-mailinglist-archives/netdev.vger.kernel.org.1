Return-Path: <netdev+bounces-136179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE939A0D0D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE991F24CC2
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A220C479;
	Wed, 16 Oct 2024 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nLLbeTEo"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCE20C012
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089767; cv=none; b=N31jJNt4yu5AUIpd8feRM9YzMAp3M0sG84vHnpBVir5qr1LG/cx2IwjoV28giNh3O5El1oqf8tkAogJ1VehKvT3fycYKoOR5t84AcAVNabGDh9hRgT1CPOFNOQPB6ZlSGJ3viZJEQANBjwDMe6SK6OAxx8BkwSeLKWIm1MOlaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089767; c=relaxed/simple;
	bh=Al9h12OtCBu1vzKOzKoZiDA8VpS9m5CLyV5OcS+kFK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0/ZU8mWFuVtN/Ho/fXAJ/LOLxsK2ErkUSYCfW+sN82Gx6G2AbyJR3pz2L5bolNb29x38wYBUwLEMLorcoMssP3N1Zn4TW3e6ue5rPBsNO/nkzd3wJdVbmlmhoZh/qoWEFSfDdQfa4OALJOTjSEaJ/D24iPV1d/S+q74QooBJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nLLbeTEo; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3143EE0002;
	Wed, 16 Oct 2024 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729089763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/UfNwheFb5/jasEHsbv0PrnWAtK6GMjrCHIMlkaVGY=;
	b=nLLbeTEo7gP+wYQ8UPvq1imU4YiTv3JgRNiQHuaHhkCsBO+iil/7NI1gFDKaeChr4+QHFk
	ZDu1Qt1UE1EUYTL88mI/tBlEedWlM1pQ4FbZtwXt9r0Vkc95Fc1/eZq/Z6ZV4EzSjvB7WS
	Dci/jrsHQ+DJVZRmbE4S+VtTNaLyPhBzzNgD7DJckxpRHPWt1W3M+4UvMw419ZCwHX0pgy
	XyxRA6Y19yTBGlbrYWl1B2GlfJU6nWLuJa7cW9ZtxQ2RLRTK/unLoebZkTsgNkJPeP2vH7
	PnaEeJ3HkjzL2w6pHCLThtt99GaoD6id9uDzLVuQYuqzLz/0j0izJxN88iZlhA==
Date: Wed, 16 Oct 2024 16:42:41 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub
 Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next v2 0/5] Removing more phylink cruft
Message-ID: <20241016164241.6c39ac9d@fedora.home>
In-Reply-To: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
References: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
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

Hi,

On Wed, 16 Oct 2024 10:57:29 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> Hi,
> 
> Continuing on with the cleanups, this patch series removes
> dsa_port_phylink_mac_select_pcs() which is no longer required. This
> will have no functional effect as phylink does this:
> 
>         bool using_mac_select_pcs = false;
> 
>         if (mac_ops->mac_select_pcs &&
>             mac_ops->mac_select_pcs(config, PHY_INTERFACE_MODE_NA) !=
>               ERR_PTR(-EOPNOTSUPP))
>                 using_mac_select_pcs = true;
> 
> and no mac_select_pcs() method is equivalent to a mac_select_pcs()
> that returns -EOPNOTSUPP.
> 
> We then make mv88e6xxx_mac_select_pcs() return NULL, as we don't want
> to invoke this old behaviour anymore - mv88e6xxx doesn't require it.
> 
> Then, allow phylink to remove PCS, which has been a long standing
> behavioural oddity.
> 
> Remove the use of pl->pcs when validating as this will never be
> non-NULL unless "using_mac_select_pcs" was set.
> 
> This then clears the way to removing using_mac_select_pcs from phylink
> and the check.

I don't have any setup with such a switch or that could trigger the
PCS removal, so I couldn't fully test it. However it does look good to
me :)

For the series,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

