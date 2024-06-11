Return-Path: <netdev+bounces-102488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A2E9033EE
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B72DB2913A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53A172BD8;
	Tue, 11 Jun 2024 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W2pG7pe9"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63052172BC2
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091615; cv=none; b=o3Oa5RA/wjyjm8mLbq2XF01aaDZ1NKWzoL/a81fE82jNZpjpAxu6+3nRYMcsmrafgEQH3c59FLilrmQdA8iGMjf5ikumLiWr90A5ZgBrn4TZqX3mwx9CVRJCNSPRKx6Yc3b8jbz/Q7MExwvMMocceedO6r6C7FJxGCnOe4cFcCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091615; c=relaxed/simple;
	bh=vj03+hGKLemneKvyvURBGNwjO2j3h6ysiuk/8K42vNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNh3uiAl+1GjNELy67XMkgO3oBEHQLgquq3ieYBig46N7RwfA8osDJEunpk9aOuyJ4iOAcwGtYE+bNQXUDA9wdPblR93iG1c5hYlYlY+U+Ll7kIvNh27DfyBw/NBORdfqjgJfgWOyTpvZwgAdvRQl9VIzzyRAAaPSLQve9kBVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W2pG7pe9; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B15E24000E;
	Tue, 11 Jun 2024 07:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718091611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12jWhPIUnOw/RKwQiE4XQ7cBa4eoelBDbdF0jGh8WZg=;
	b=W2pG7pe9lyBpyZie7mu2wpgUjZVchYnYUM5Vxcl52qCiH1Yu7BNv5tE3F7fEsjssxijh0s
	v85gyRgwxsFD1oeh5fvChc89+50kx+di54loOYwi73ojCJ7CfPCEUqpMB2g4zdqqRH0OqV
	ZgD/uLbi0aI7g+2x6A+rJ+6bt53EWtDFWdunFOaVY8i3nwHAN/f4geiru2/ygoc1h/wwrh
	f4wo/X5wLfvXqV+b94InQ92kMx3+eKiPil7CYfMEtTbtF2MRcPrijjI+/Ij0maK2/q6Uoi
	jQZrE4ei2H20qLh150jB8qwcl6A1A78rmvrLLJ+CZucxCzyevMaGpeOGo6cOAA==
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
 Re: [PATCH net-next 2/5] net: stmmac: dwmac-intel: provide a select_pcs()
 implementation
Date: Tue, 11 Jun 2024 09:40:51 +0200
Message-ID: <572700203.5assNPOG8s@fw-rgant>
In-Reply-To: <E1sGgCN-00Fact-0x@rmk-PC.armlinux.org.uk>
References:
 <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
 <E1sGgCN-00Fact-0x@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

On lundi 10 juin 2024 16:40:39 UTC+2 Russell King (Oracle) wrote:
> Move the code returning the XPCS into dwmac-intel, which is the only
> user of XPCS. Fill in the select_pcs() implementation only when we are
> going to setup the XPCS, thus when it should be present.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




