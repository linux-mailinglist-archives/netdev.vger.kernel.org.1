Return-Path: <netdev+bounces-152592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD8D9F4BF3
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E51B1896A48
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672711F4717;
	Tue, 17 Dec 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oRbaBnyX"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED61EE026;
	Tue, 17 Dec 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440785; cv=none; b=WssN2KD9H5+Ud/CkMo7k2lU+Wyo4XAyGJTgU0nF0URbrPmJcS+ZfQyt0a603vESsHau141RTD6HaQWkE+uO9wfoNNj5rfT6vbDIBfaurQuvDYA4YkF4ZxMAQtOvLQ7iR8UbiXPBR7dbwCbGlnVrzXkVDROjjtPAfj9auzyp4Fbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440785; c=relaxed/simple;
	bh=6gDqkQAnY5OleHKMrbVdVfxJEa6EvvJlrlGNMq8lgZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gukN16Zs+3kgR7NcvNAVJXLA0jiVnPLLRDSXw2A6Wb1dXNQz5W2n2kGkkXE8s7q68OIQWuNQxNTHCEjOzieTqF1U1rooxVsOdI3Uf4JDLS6/JGOD/j0r5Rs9h2Ms2wxshMaR0Xp88SjNf0MyXm8dHrWNUqoXF37afPgbEiXu3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oRbaBnyX; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FC6C40009;
	Tue, 17 Dec 2024 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734440781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HD5+UGwPhPjBTRomgMW1WMHP3Ot9+Wi9ed4vzq6Oo4=;
	b=oRbaBnyXDJFZn1UBMCOUL8udFQoFdfQ/7OLxQ6Av1DNPffbCo2AS9KhCVm6RuJK2VKy57R
	pqSivEIciVVKEoGDz+rJaFC1c/DgDUqoPkhccB75V2bHN+Cz6ZNCGJgYrEH5MqdEQQMNGq
	bOUb1h/rlXCZF6q6JGvMm8Q6gbCP5IN3aIKU7I2XqNDBC2ixLOpR3bJRlnB8GCdAPNs5Eo
	cchPboxxjf9s5kcAk8gziPNqTJMltTjYcM46078lyB5ZfMVeR8vpodyQ5KoPMhIc2TJc9g
	lzulpSxwHX4RS/4eMQUXRL3p0OwvGXsmv+xCMy5+ir1PVHcIYzsKazRIQG4fMQ==
Date: Tue, 17 Dec 2024 14:06:18 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: phylink: add support for PCS
 supported_interfaces bitmap
Message-ID: <20241217140618.0debd644@fedora.home>
In-Reply-To: <E1tMBR5-006vaS-Ou@rmk-PC.armlinux.org.uk>
References: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
	<E1tMBR5-006vaS-Ou@rmk-PC.armlinux.org.uk>
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

Hi Russell,

On Fri, 13 Dec 2024 19:34:51 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Add support for the PCS to specify which interfaces it supports, which
> can be used by MAC drivers to build the main supported_interfaces
> bitmap. Phylink also validates that the PCS returned by the MAC driver
> supports the interface that the MAC was asked for.
> 
> An empty supported_interfaces bitmap from the PCS indicates that it
> does not provide this information, and we handle that appropriately.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

