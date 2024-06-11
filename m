Return-Path: <netdev+bounces-102491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E5A903418
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632AA28BE40
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A01172795;
	Tue, 11 Jun 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VEU/7Sh4"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8961E52F
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091879; cv=none; b=UW3KVXLyWl9fHZq+Tfqcus/ZZktik/n+nbAAe89F1282lLneyv06fqM8ij5X/NjAoT8QRlkahPlecr7d9SWgFLk0A+GOPqOX/ArAq4sEfbqlGKU8/3T/Ow+R+KCTOVAFbrhqQrr+r5qKMxcogdbJYa7JN4RRwEpZmb+qvL9Wzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091879; c=relaxed/simple;
	bh=MsZdtWa0bZ7tblUJn9IBtDZ8PdeilUUDrBEaLeL9GW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDlEs+dR9D3ZhcPWGsviQC+hCcnjZp0rLNwF8hGchxgfHPbZn3lwLWiz3CgJCN5XQ1oZJhPwFgJc9jjQX6+s3FaoMbFDmef/Jp7H86PsweTuUMeji8jsj+OoEdTiuBGSK+/6mL8NRYpE/0W4QObIX4t5vpRZY77SjTuyTEzaZjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VEU/7Sh4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CD961C0005;
	Tue, 11 Jun 2024 07:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718091875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihufCtlwErxwfHYl3EzgqZNtueA4taxOagrZb+gbUz4=;
	b=VEU/7Sh4FRVxuUs2eVCAOggJ9zOOYwYL6GD9MfybnrFYuOVmJzPiYoi70vHL1XW5yWZvAY
	bNpufuxhrmdmH//cR+nc9gAx7c6Qs3VdpjAc5hpeAzsvm37Sm7KnxeIIzpcnoFavPASiP1
	VSyQ79HaUD83pn5Ale6cG5EJ9txgjZH4Pt3BoUqPmruLmFCBBZKHdTuleRE8PXWtdSBGwO
	HQpa/8LS8kcXpFxABSWkbEp3nfEQCGHRr9VzSr+N14mUcNegL//9szYIu//GhZl6jOzKMB
	pJzVDNVk7Gcnw+EoMKfJYdcAAA/JX42Vnf7DX4xTN08XDRdbkyLfSU7+c5EbyQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Serge Semin <fancer.lancer@gmail.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Halaney <ahalaney@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Subject:
 Re: [PATCH net-next 4/5] net: stmmac: dwmac-socfpga: provide select_pcs()
 implementation
Date: Tue, 11 Jun 2024 09:45:15 +0200
Message-ID: <171812177.LLWfzqLr5J@fw-rgant>
In-Reply-To: <E1sGgCX-00Fad5-92@rmk-PC.armlinux.org.uk>
References:
 <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
 <E1sGgCX-00Fad5-92@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

On lundi 10 juin 2024 16:40:49 UTC+2 Russell King (Oracle) wrote:
> Provide a .select_pcs() implementation which returns the phylink PCS
> that was created in the .pcs_init() method.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




