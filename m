Return-Path: <netdev+bounces-126005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0C596F8B8
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC6D282CFC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6631D3193;
	Fri,  6 Sep 2024 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IMwtKv+w"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4B1D221D;
	Fri,  6 Sep 2024 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638077; cv=none; b=jBcB6Lmaml7jh2P7hpVykurLqfgFGtx7nh+4ALZFVupDM6hH92cneE7bXsL+TnSeEnNhK2xtBkI/+sm0QDuHrbYkVrcQyxFJMzx0mKR0UD0dPd1KFqznw2pk0BEDAVi2swwGxcvhT/C9XfhpyoXjwT/7KqK0qhRdppedwp2TosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638077; c=relaxed/simple;
	bh=42bXK7NQZSPiWw2FT1A8XGhxas4qaxAIiVJAEXr6DEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHf+9y1lTgUG4+jH+0v2mb0br+hF5rmFLaDptiWwRVzMu8biukfiQSiMA/vGA33/wl8lNNZo/MSAm/04NqtocOufTY+NEI184NN5YN2fh9vpAs7IyZr9N+3AWAQ0Z67YrxixVKWHhwd8O6HJFKQ+L0W2SzkZRAjE7mkLV4ViMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IMwtKv+w; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D17CE0007;
	Fri,  6 Sep 2024 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725638072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPc8EhiDtuxj4iMuKBr2HQPu3+vOQqoaN03hxs8NmIA=;
	b=IMwtKv+wv5VTVjFEQh09bBuNdMqjnaGTHZSksUx5rS61+t1zFIyFKWV3htA+z5P4YWifRJ
	L5YbJKAX5gIpI/zUNwyE0dQ4Tpwgx2n/8I66Ltahi9A5sHYBay/CjUYZO756OyMWhqYel8
	ZVlZnRg5jo+6BulPIead4WBnq0i64o6UY5fj+S4Y8Yq1asr6ECxKRYMYuQQ0GDGhTgxzeq
	Wb4MOOd3vKpbJX2vbwXRmZVXGjJ/C1rPOHZXLTJdhZlnRR8Ktwsyw6JPsf5C8RJWk5HkB9
	O/TuOzVU8Qfajg52uT68ysXS5IUnW489OtvSW/OyA+W4yXDdZ9x3eDEyfJ8AFQ==
Date: Fri, 6 Sep 2024 17:54:30 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian
 Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: net: ethernet-phy: Add
 forced-master/slave properties for SPE PHYs
Message-ID: <20240906175430.389cf208@device-28.home>
In-Reply-To: <c08ac9b7-08e1-4cde-979c-ed66d4a252f1@lunn.ch>
References: <20240906144905.591508-1-o.rempel@pengutronix.de>
	<c08ac9b7-08e1-4cde-979c-ed66d4a252f1@lunn.ch>
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

On Fri, 6 Sep 2024 17:11:54 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

[...]

> 10Base-T1 often does not have autoneg, so preferred-master &
> preferred-slave make non sense in this context, but i wounder if
> somebody will want these later. An Ethernet switch is generally
> preferred-master for example, but the client is preferred-slave.
> 
> Maybe make the property a string with supported values 'forced-master'
> and 'forced-slave', leaving it open for the other two to be added
> later.

My two cents, don't take it as a nack or any strong disagreement, my
experience with SPE is still limited. I agree that for SPE, it's
required that PHYs get their role assigned as early as possible,
otherwise the link can't establish. I don't see any other place but DT
to put that info, as this would be required for say, booting over the
network. This to me falls under 'HW representation', as we could do the
same with straps.

However for preferred-master / preferred-slave, wouldn't we be crossing
the blurry line of "HW description => system configuration in the DT" ?

Maxime

