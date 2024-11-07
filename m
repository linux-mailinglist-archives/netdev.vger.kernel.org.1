Return-Path: <netdev+bounces-142982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1B49C0D70
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC079B20DB8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB9D216443;
	Thu,  7 Nov 2024 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KB4eO8qI"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB418C33B;
	Thu,  7 Nov 2024 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002649; cv=none; b=iS3qd/QTvPDgjypEfXlKF89NZ0aSilGHXQtBMmVSsMurs5FHaXrvICKzv6Dz0/o7CSMBrYMjQVWClYGcm7B3ygUjwzz0Llu+ZO60y/It5BV6wrPU1GzEE1YNxyuueMxLN+JEbWHv7fDLzNnS+v+4xQPGNmbe6mKl85Ghr3Os9H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002649; c=relaxed/simple;
	bh=wG4g3Q0DH0DR3NZMvh0Nb97FxUYCyS196E49cYH7+WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZLXO2aarZbYE27LlVnHQ1K3e47LZURk/Y/3YimZKeHepYm7WCjl9n45o/UxspTTdKy1KLdDL4P0zfgwjgtICKoAGL0vfCJ+GxTp6Dw77+Dt8EfGz6pXMBlNswVJ+AjFrBHzyEgLusrP7xEh0ioNInhghyA7My7Bl1vSzm2eHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KB4eO8qI; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06FB520007;
	Thu,  7 Nov 2024 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731002638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9XGExYP+FD5xVE83+PPloi9X/IUrzdreygul4BmLSg=;
	b=KB4eO8qIa2MRgT2At0Bdgd+UcoRM2YYL9KjNKlbF8yXXtpwRizS70pLAYRkcXi8dLVomi+
	3omDI4Zr3vVMcPvLVcYxQ8+dMMa5t10R8cBe9Yn9E7jBEFoH+5uLrgKqxowz/g08KGIVnq
	WG8rbEYxIS1P/nD20TGfDGuNX8ghZ4kEzMUuPhar1AIPyH5h0vEn9QTWhc5QGh3Tm+Y43M
	qTlgd9H7dMtGCTJIYWCpnh+zxOwoQNEUmgYqOP39Zs0ojXN3ofFZ2xvMsdQQEx1Buzpq7L
	vUrs/k/aXYhmd/k4PtLr3lhYTjmzCbSD6QJNoWPQySRXM4U1YzbaMq8WATpgeQ==
Date: Thu, 7 Nov 2024 19:03:55 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiner
 Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Herve Codina
 <herve.codina@bootlin.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next 2/7] net: freescale: ucc_geth: split
 adjust_link for phylink conversion
Message-ID: <20241107190355.7daafc3d@fedora.home>
In-Reply-To: <Zyz-CcO1inN06mtm@shell.armlinux.org.uk>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
	<20241107170255.1058124-3-maxime.chevallier@bootlin.com>
	<Zyz-CcO1inN06mtm@shell.armlinux.org.uk>
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

Hello Russell,

On Thu, 7 Nov 2024 17:51:05 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Nov 07, 2024 at 06:02:49PM +0100, Maxime Chevallier wrote:
> > Preparing the phylink conversion, split the adjust_link callbaclk, by
> > clearly separating the mac configuration, link_up and link_down phases.  
> 
> I'm not entirely sure what the point of this patch is, given that in
> patch 7, all this code gets deleted, or maybe moved?
> 
> If it's moved, it may be better in patch 7 to ensure that doesn't
> happen, and move it in a separate patch - right now patch 7 is horrible
> to review as there's no way to see what the changes are in these
> link_up()/link_down() functions.

I agree that it's hard to review indeed... I followed the documented
approach of splitting-up the adjust_link callback then performing the
conversion, but it's true that it doesn't really make patch 7 more
readable.

I can try to move things around and make patch 7 a bit more
straightforward.

Thanks,

Maxime


