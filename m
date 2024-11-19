Return-Path: <netdev+bounces-146054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CBE9D1D94
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4616D281C23
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D207A139566;
	Tue, 19 Nov 2024 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uzjToPKK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA013665A;
	Tue, 19 Nov 2024 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980917; cv=none; b=J9g6heE5q+vPIpADbGTIVn/bQFJMSX98253qVuASUvSPg07c9etrm3YGDbfj3KDPsJtlGlbn/xgq+qvioUEcWyDEjBVpuWVYyuCNGrcRvUVkaf3DJSeDes9Oxh1wCY6og3N/JkELqOM77kW2kSkAIqoCkDAstgsjTbiDN6djhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980917; c=relaxed/simple;
	bh=d5wR9tz08ve/15avuwqwuykFksaoFpcmxl/uzElJIoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcd2aWGrHm93+u90ol+0rWw/HGZFqE43d5WAHUrV9POcgKUoFI2g4ioXJGZZWrboWoFCK2QS8gyb54dOXc2BBn6Ioi4zU4JXZ368NeL90i5YFQaHDw4PEP96p61MMVg1ly5GwIB71FJcA3expS7rKOciSHBkSHHHtAu3DoxndzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uzjToPKK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8U8UwDGXeKDkqdmDQD2AJ6C8adRsvYsEsUh2q0q8beE=; b=uzjToPKKzfDbUOnMQ8BEFtGznv
	HP/d4wX3y4jUF9yLCoXy/fI+gFmjX6TMNsWTRweaxbcGNOgkr+7lVo8hrl226YdeZTsmqdthvjGYv
	sm3Qoh3WHHy4iU9zQbBTSZpJBdWC/qZuf8nkAJOg4iJhhhqH3twZ42e9mmHR3EOgLjyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDDLn-00DjVx-O7; Tue, 19 Nov 2024 02:48:19 +0100
Date: Tue, 19 Nov 2024 02:48:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
Message-ID: <4d44bc93-6a81-4dc8-9f22-a103882f25e1@lunn.ch>
References: <20241118082707.8504-1-a0987203069@gmail.com>
 <20241118082707.8504-4-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118082707.8504-4-a0987203069@gmail.com>

> +	if (of_property_read_u32(dev->of_node, "tx-internal-delay-ps", &arg)) {
> +		tx_delay = 0; /* Default value is 0 */
> +	} else {
> +		if (arg <= 2000) {
> +			tx_delay = (arg == 2000) ? 0xF : (arg / PATH_DELAY_DEC);
> +			dev_dbg(dev, "Set Tx path delay to 0x%x\n", tx_delay);

The device tree binding says:

+  tx-internal-delay-ps:
+    enum: [0, 2000]


So only two values are allowed. Yet the C code is

arg / PATH_DELAY_DEC

which seems to allow 16 values?

Please make this consistent.


    Andrew

---
pw-bot: cr

