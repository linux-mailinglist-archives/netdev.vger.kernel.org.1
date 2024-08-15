Return-Path: <netdev+bounces-118920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF37953855
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554341F23971
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A7D1B4C4B;
	Thu, 15 Aug 2024 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="OyXy+w3b"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED81B4C31;
	Thu, 15 Aug 2024 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739740; cv=none; b=nYkdrBaLT2jpaPLvSh7G3YrBj+PIWFDtV2LcGTweNbEMXJZiUTLvXuFBT1S6eNqmziupysHd4Fr+XxCiGXTLuD/R15uuyy1cjFDfY5Akj6w28lBpFg0P+cJQDFwS8dNl+qt5GxT9vH0lFlX+gLsAjLrSdlrmOvFAiDafW5fOAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739740; c=relaxed/simple;
	bh=2YsIYBU4KdzLxYOq/DWZJaW8fsNmm7V/n/GVrhzx8fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayp68A9+00dtlEFra6rRbFKqrRptsgEuK8pT8MLB2GkUa+gqXGQSAliTTfXjjyJfdBS6HDwYV3ZavmfnQVy5W9kRZD5pjbk3f73gTRseoX2dSRuYT05VsoT9SvnHZaK02t4Go+Yz7fgLZdzwJsZBSMDGGeufH9Wc1xznqLBZHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=OyXy+w3b; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2YsIYBU4KdzLxYOq/DWZJaW8fsNmm7V/n/GVrhzx8fU=; b=OyXy+w3bleVZ7blXyZNiQ9LVCb
	bhzsyx0+QQMv/aBgZT9jtgM0Ws9Kkswdf6EMIbVOzYPIcIATpMTffVE98W5J2RC0NB/5JCK4UaHYa
	5Y+DqD5Y3IgQHovKo69Q0srhgBNUXKHJ2btWtuc1hlO2XJIHixiRm29zqDv+0sfPu44JFw1A1VRKC
	gHbNkBVlKal+PKZ8jl3HllTyWw9YIfVqGodkro07kCDtpNKPPH+55IDIr66B/N428V4pHw/faaZHQ
	K7cm8AeiJw2ogzoQ9WU25F/04tDZ5EvEYJqpsrHvvZ3goIJxny75LNbFDCXc2W1uWYyCOp+p707c4
	/igHZSFw==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sedRb-0005Qb-Gy; Thu, 15 Aug 2024 18:35:23 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 kernel@collabora.com
Subject:
 Re: [PATCH v2 2/2] ethernet: stmmac: dwmac-rk: Add GMAC support for RK3576
Date: Thu, 15 Aug 2024 18:35:22 +0200
Message-ID: <2148922.heUyiRONoq@diego>
In-Reply-To: <a73ff2ab-7e68-4d6b-b38d-37e7303af40d@rock-chips.com>
References:
 <20240808170113.82775-1-detlev.casanova@collabora.com>
 <3304458.aeNJFYEL58@trenzalore>
 <a73ff2ab-7e68-4d6b-b38d-37e7303af40d@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi David,

Am Montag, 12. August 2024, 04:21:27 CEST schrieb David Wu:
> Hi Detlev, Heiko:
>=20
> It's really a TRM error here, RMII PHY has been verified for this patch.

thanks for double checking.


Heiko

> =E5=9C=A8 2024/8/9 22:38, Detlev Casanova =E5=86=99=E9=81=93:
> > Can't be sure about that. An error in the TRM is not impossible either,=
 as for
> > rk3588, it is also bit[5]=3D0: DIV20 and bit[5]=3D1: DIV2. I can switch=
 them to
> > match the TRM though, we may never now.





