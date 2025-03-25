Return-Path: <netdev+bounces-177474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2036AA7048E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB821666DD
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66825A338;
	Tue, 25 Mar 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lC6ctQGR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A701EB3E;
	Tue, 25 Mar 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915168; cv=none; b=GGwdpCKHZs0LcICNQYieian4FgbR5p+F07CVUO7jX0tLXXoIXvB6NW5/F/d2QOnTuqEg5yPoNSlabqt8AXNuFvgiA5HdzwwI6j4npunmrnOWjukSrHZXd+AB0GyhxJRadZtOHWMooIIvVifLeCVid+1uDPfwAcTSMYc8dbsi/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915168; c=relaxed/simple;
	bh=WwTs38cduZqd9qtuPegb9fIa68DDTyF9/BCKDH+jYZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzYbCIUDp3EN7Z+eCpSqwm4d8TUSEZuW/kU0MuA+M6sWyV/w8blPIPtAwOT+swYRPMdr7D1/ee72SVPXY/SzrpZpY0Wqg0RpFB9ThAuTfKjTiRKL2x2OZ/ro+UZJKebzZBONa2dPx+FlR1O/QC8F2EJwFk6M0hwPWdOvvm2j6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lC6ctQGR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RbNibk7vAHn+5HUmQKRDw9Q3Hr2VlQle5mTru3E9iuU=; b=lC6ctQGRJnnjgQd6d44kIc2Oxd
	euHpZqofQd0+GoZrKsUg66OIffTd+fV+6Q1cAJy7bWbUddYTJazUOuxiYgztJs9E9F/wS3Twu0yUu
	K/3Lyy5W2xEHlG6OUrJRDlrr0o15QJfGq54BUAuen3YFo3bKYQOXsc7hBvwD92tkc7X4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tx5qb-0074KB-TT; Tue, 25 Mar 2025 16:05:45 +0100
Date: Tue, 25 Mar 2025 16:05:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 2/5] dt-bindings: net: Add MTIP L2 switch description
 (fec,mtip-switch.yaml)
Message-ID: <2ccab52d-5ed1-4257-a8f1-328c76127ebe@lunn.ch>
References: <20250325115736.1732721-1-lukma@denx.de>
 <20250325115736.1732721-3-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325115736.1732721-3-lukma@denx.de>

> +  phy-reset-gpios:
> +    deprecated: true
> +    description:
> +      Should specify the gpio for phy reset.

It seem odd that a new binding has deprecated properties. Maybe add a
comment in the commit message as to why they are there. I assume this
is because you are re-using part of the FEC code as is, and it
implements them?

	   Andrew


