Return-Path: <netdev+bounces-102492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DBA903421
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220701F2216F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5FC16F8F6;
	Tue, 11 Jun 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vi4xEe5N"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED0170839
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091923; cv=none; b=YGJ5aGqlQPl120t9V749qVWbiwbA/WiBIaDD1qam3vo79O7WqAk1QElFP09PGOaGBX0ZrCoxZZll5fj0hr3tfF3FpcU093byi+/vPMGSk2ruV84wcLCq0KzO39g6839JHWW3jsZ4QecIJdoPwcOOmfAVCOAvNiVC5WYjRzT+kBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091923; c=relaxed/simple;
	bh=eD6c6EMnjLgnO0LfW4SXpTHotEbl/RXKpnpyhxdlD5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+ByJ5gpKBY1F8TkQJAwFM4xBbTGEyIelXYmg0nk5/gVgL4sZmqdsKCEOZOFuvchvOb2PbOnb7eJcgOue0FlbLUoxE8E9mN34o0N5TViVdtAsnsGQQtZ5IHXNaZ9nY2+LMiFWK7qPOyNQeVo4twOYEgBbaGrU/9OqFS7pCM99gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vi4xEe5N; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75534C0006;
	Tue, 11 Jun 2024 07:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718091919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VzysMo60EaW8PFa2ydA6Nv+HipQDazekB7E714o/3BA=;
	b=Vi4xEe5Nc1zu7cfZHWTgvg/9NEDOq6Z8U7uapmRA7xnZ+Z9h/noeiWOd0BNtHOPeZw7Vcl
	E9qFLmHyzHiOc1U0x7L7YiAf6T4i8rsXAe5D9zGaZAE7Dq01n0jOW6HWB35T4Ym46y4N1u
	LoC3+qspIJQctZ7o8mPDtCTMtWrC6XxgWpC94tqteki/KUmQTvFjwoXGHdwwZ1SRRbbD0v
	NGSeGZ/bEmgUpYdP7cwKxitNs042vZqt7tLLc7JQzqnpNkMJqf9cE7cki/DE1MUw+JIluz
	3mEmkfYvB/TgiQGKidezEoF8dJIWfLnonKrd3oMkB1W4iFdIjiPWjruXEOGxhA==
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
 Re: [PATCH net-next 5/5] net: stmmac: clean up stmmac_mac_select_pcs()
Date: Tue, 11 Jun 2024 09:46:01 +0200
Message-ID: <8905016.TWkq766n7R@fw-rgant>
In-Reply-To: <E1sGgCc-00FadB-Ch@rmk-PC.armlinux.org.uk>
References:
 <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
 <E1sGgCc-00FadB-Ch@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

On lundi 10 juin 2024 16:40:54 UTC+2 Russell King (Oracle) wrote:
> Since all platform providers of PCS now populate the select_pcs()
> method, there is no need for the common code to look at
> priv->hw->phylink_pcs, so remove it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




