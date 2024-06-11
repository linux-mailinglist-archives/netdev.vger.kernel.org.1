Return-Path: <netdev+bounces-102486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683DB9033D2
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AFB1C22858
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7363E171E76;
	Tue, 11 Jun 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G1dHZpSP"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D61E52F
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091348; cv=none; b=BoKlGfRn++nwAegZWXc7TLMonr4ki+Gba9lRMUHDHpU6W5ump8bwNn0RlFteucxlJCBYIywBOTO95y+aahm2rkjMBhLa8zyy5BYNFc57bN0YarNeZhSw6E3BLy0QAOFl8AtgDFIEqBM1QbFUGqy5qqrJpwE7JDejPmnEksNQTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091348; c=relaxed/simple;
	bh=nPeSBQIDAteF5zN9gCYEJfs6/cIqGRstE2W+DTXPaJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TixcBO1Es9hMIx61AlPXEH38Pn8oqtEnMcBqWz0Gdr+Jg/c4eZTAtzKQooAntKr8vcKmRy3TaK0YdWS0kYJjUNV93o+w17ooGp10TlQXyZ+d83RM7OdM7KZlbCoAPf1gIARlr7GY9w4wfa+AS0buo/By6BZESmgNwDUFRPaJEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G1dHZpSP; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01FE7FF809;
	Tue, 11 Jun 2024 07:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718091344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfBmIBfBFzgmDf9ez+C3sLKXREaPjawEgC3PAYhHrqA=;
	b=G1dHZpSPZiMZx6xplQlDZzeRp6StTvRQv1HEpmvQyVDcd2aJFAAK/JH4+M0lqgfzatidja
	JAjuIfNfY2MxV6kUzZ/QxPYq3AwjB6TmVlyrVrCJe7X2OzvE810KJmwBnicYekTlDHHwJs
	MEqATZ2+1icOGjraYCMRambWf3TQddcO0nsLtOjEBV3TKmmh/sHpn/fZJolbyQKWcsD4Oz
	zgp5MsoQSh969n8Ush2XO63WXl9uaPxH22Fu/PyjXm+ws+gfiZ9a8S4Sj0pBJMgc/yOmeh
	CnrWfNKfjw517ZrhYLv2FbBo4Y5OH7np1o51qJLleEHZnFRMt3RQPEiEPEyv8g==
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
 Re: [PATCH net-next 1/5] net: stmmac: add select_pcs() platform method
Date: Tue, 11 Jun 2024 09:36:26 +0200
Message-ID: <5509689.FacUkMOHz6@fw-rgant>
In-Reply-To: <E1sGgCH-00Facn-T6@rmk-PC.armlinux.org.uk>
References:
 <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
 <E1sGgCH-00Facn-T6@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

On lundi 10 juin 2024 16:40:33 UTC+2 Russell King (Oracle) wrote:
> Allow platform drivers to provide their logic to select an appropriate
> PCS.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Tested-by: Romain Gantois <romain.gantois@bootlin.com>
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




