Return-Path: <netdev+bounces-150881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9AF9EBF11
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953A2161646
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45795211268;
	Tue, 10 Dec 2024 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bXFciefH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3E1F193F;
	Tue, 10 Dec 2024 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872287; cv=none; b=UZBm7GD6WPXB8U3WV4bCofEgvAMdJFLyRiKRSkPImRx8VwUb3QP/PeVK5BBN0GVupLm/MamaTJ3hUkRTVKVdGmGx65IygqNpqAqFIIV1hLENLP32VWBOzZOuzBawcXMb6Hd/B5bzs5Njut5BJ/jHnBrtKEQBgPykcpoJ/eJevGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872287; c=relaxed/simple;
	bh=cAdm8flCRnl+5J0rloVrH8CV7CVOB9f8Y6CqOIT1+z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POGQCHlCzyX4w3cQ4IUzxQ4vFWMTegsIkboZBjkL8bxzs9ni7DCzkATZgr3ydTXjysExLlp1JPn1pgSL8bMkjP7vXIjNjbVxiI5J1d3KGYxyJQtHU08FxHmjefT19eprdQiqT6VK2lBVNNX/UPGagQgHgMN/T1+hP0FAi1sTWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bXFciefH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GPgEgPHXiLBNETa+wEEXPVbWMGlgl8r/WmdmTJCw798=; b=bXFciefHRfvI9pD+nD5btga3zq
	33lWZ0ZlsOX1oWoBf0BDVmVBvZEh++pTU6vUfe5lbienCeYsXObF/9gaejpcOHthv2xA2Bjq2FJqy
	TM6O0hn6R3rmi6WCx4SQ6g+i7ue6QdL45PamUG8Ufu4iS7Lwd31Bj58wFhHp4yyLheeI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tL9Nm-0001My-61; Wed, 11 Dec 2024 00:11:10 +0100
Date: Wed, 11 Dec 2024 00:11:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <beb50a2b-1d3e-4c34-821c-e4f93767cb5d@lunn.ch>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241210211529.osgzd54flq646bcr@skbuf>
 <6758c174.050a0220.52a35.06bc@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6758c174.050a0220.52a35.06bc@mx.google.com>

> Doesn't regmap add lots of overhead tho?

Compared to what. MDIO operates over a 2.5MHz bus, assuming it is true
MDIO. The CPU overhead of regmap is probably negligible compared to
waiting for MDIO transactions to finish.

	Andrew

