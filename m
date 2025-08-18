Return-Path: <netdev+bounces-214662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6FEB2AD06
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 17:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED2018A64BC
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDFD261B99;
	Mon, 18 Aug 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWF1Yp0A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3137325B301;
	Mon, 18 Aug 2025 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531623; cv=none; b=D/81O6zYvpbnhbLQcoGCRuWt0CecnBP+gJrPfZbd11ruYm9a0ibVYXcv+4DjZW18bb+4ZZdW9sI0lnYeOoXkLwZdCxh6HyvP2/wn4h2Gy+pXEsOa6n2DlFy8OIYXqa0ZVlvVolKN65TygHg4PJjBPOwDHDWzSYwWoJkEN8VdzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531623; c=relaxed/simple;
	bh=5SCABghAB354amELoyU9VXKcuc66Y0O8hBOvTypXRM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyDv4Dx1NjRVl5nbq3t9mPsvhLpc2YWxD1HUfSAbvehZcSNcNhYhGYgmEm2oEM3UKIni70X6P563ivOPB6i326Fmr3S6pI6t4+HMV5M7lhgM4zLQBdsVMnunO1d/qud12VkEdY8L+9LdOUkA2/eC8fP8MipUUe0Kv6biWUVeA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWF1Yp0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7B3C4CEEB;
	Mon, 18 Aug 2025 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755531622;
	bh=5SCABghAB354amELoyU9VXKcuc66Y0O8hBOvTypXRM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WWF1Yp0Ay+zqt8/poKCkMgmRjqP/VDzwXyhhUnVYTPbQdi9D88A0JbYuC1Qy065tu
	 cNu1KyJJFRIen1gkr9BfwJRO1WpHD75A2IlsjBf1xo0tXXXu4kD1cj7B2+sd2gpUdj
	 cWcGm7ZlPf0Y9JqLbXiKuVVjuNrA6QSRz1CbV0T6dfF7ampA0VEwFOPWn4kqVm0MFU
	 Va5Vi+tMHqNtJITQt1/tC7wbL14SFpKleF8JSwG6TPxCYJZSDTHTCBmnqkPPWmI2vf
	 C9GXDcLADEd0t25ToHVciyn/gC5cWJpED8fiIXe+07MfJyqmOH5H4s7n/D8b1Wr7gw
	 MeoKF5iWzk4wg==
Date: Mon, 18 Aug 2025 08:40:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>,
 andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
 edumazet <edumazet@google.com>, pabeni <pabeni@redhat.com>, robh
 <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, conor+dt
 <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, richardcochran
 <richardcochran@gmail.com>, m-malladi <m-malladi@ti.com>, s hauer
 <s.hauer@pengutronix.de>, afd <afd@ti.com>, jacob e keller
 <jacob.e.keller@intel.com>, horms <horms@kernel.org>, johan@kernel.org,
 m-karicheri2 <m-karicheri2@ti.com>, s-anna <s-anna@ti.com>, glaroque
 <glaroque@baylibre.com>, saikrishnag <saikrishnag@marvell.com>, kory
 maincent <kory.maincent@bootlin.com>, diogo ivo <diogo.ivo@siemens.com>,
 javier carrasco cruz <javier.carrasco.cruz@gmail.com>, basharath
 <basharath@couthit.com>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, netdev <netdev@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, pratheesh
 <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, praneeth <praneeth@ti.com>, srk <srk@ti.com>, rogerq
 <rogerq@ti.com>, krishna <krishna@couthit.com>, pmohan
 <pmohan@couthit.com>, mohan <mohan@couthit.com>
Subject: Re: [PATCH net-next v13 4/5] net: ti: prueth: Adds link detection,
 RX and TX support.
Message-ID: <20250818084020.378678a7@kernel.org>
In-Reply-To: <1969814282.190581.1755522577590.JavaMail.zimbra@couthit.local>
References: <20250812110723.4116929-1-parvathi@couthit.com>
	<20250812133534.4119053-5-parvathi@couthit.com>
	<20250815115956.0f36ae06@kernel.org>
	<1969814282.190581.1755522577590.JavaMail.zimbra@couthit.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 18:39:37 +0530 (IST) Parvathi Pudi wrote:
> +       if (num_rx_packets < budget && napi_complete_done(napi, num_rx_packets))
>                 enable_irq(emac->rx_irq);
> -       }
>  
>         return num_rx_packets;
>  }
> 
> We will address this in the next version.

Ideally:

	if (num_rx < budget && napi_complete_done()) {
		enable_irq();
		return num_rx;
	}

	return budget;

