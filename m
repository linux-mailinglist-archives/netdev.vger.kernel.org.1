Return-Path: <netdev+bounces-107286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5836D91A773
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E381C243A6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4E818757F;
	Thu, 27 Jun 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MiYLuIVa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A54187541;
	Thu, 27 Jun 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493841; cv=none; b=BT+N/HxrhWL4VTTellXn7v1ozcldY6+8nUnKUD/328GSjQ4Q2NMOuIgI++bilLymw8qJ/JFhRp1BPi/wGVV7zvw141g6ouarjErFNBDlNuqCkB1Fq1cYk9Lq/y760EVbV8gWH31BO4jz2XkXi+dwjrnGMA6raaGTFmAiQrzTZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493841; c=relaxed/simple;
	bh=0yWDqT9cZHuQXEI72ujjcegfN2UGNSzTzu0vBUTEMI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REyNTKiJzRvuPLwl1/WRhYmfM/s1M2zJYoPnKapUe6ZHQH7iWtjYqasFRmewrGTrVueIz53Pwuc9zR7eoaI62WQ6dbJcJfuDfiqIVIkVY4Tg/Y0ODW7SgVUvqi4GPjmPV1/zG1zULBkz7d2AcqYQ3+lG7fPwifiKddCWFwlRE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MiYLuIVa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yopBcUIB6oeeZ7aRWdWnVXoVTZwVXNOBbL6N5h0D2C0=; b=MiYLuIVaMlVHAAiA6xJgBkahUU
	WmrTzQQMrXzDWzUcq0UHMzG1AiducsQjg5/vSreM6SPi3eNG+5BDVaMuMCesrlkXlzr5Gv8S8m+BV
	RC1625Zlhj8vBVeFp16d0CO35KXS3S6/Uw3jOZRZSl1MnZMfchjv5ZEJSL/RmG1fLjbA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMotG-001A7Y-JN; Thu, 27 Jun 2024 15:10:18 +0200
Date: Thu, 27 Jun 2024 15:10:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 03/10] net: pcs: xpcs: Convert xpcs_id to
 dw_xpcs_desc
Message-ID: <15754e63-be47-4847-8b61-af7f8a818a3c@lunn.ch>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627004142.8106-4-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627004142.8106-4-fancer.lancer@gmail.com>

> -	for (i = 0; i < ARRAY_SIZE(xpcs_id_list); i++) {
> -		const struct xpcs_id *entry = &xpcs_id_list[i];
> +	for (i = 0; i < ARRAY_SIZE(xpcs_desc_list); i++) {
> +		const struct dw_xpcs_desc *entry = &xpcs_desc_list[i];
>  
>  		if ((xpcs_id & entry->mask) != entry->id)
>  			continue;
>  
> -		xpcs->id = entry;
> +		xpcs->desc = entry;

Maybe rename entry to desc here?

Otherwise

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

