Return-Path: <netdev+bounces-41754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA397CBD4D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DF0B20FE7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AAD3B282;
	Tue, 17 Oct 2023 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4i8S7Ql"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA3D3AC29;
	Tue, 17 Oct 2023 08:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC590C433C7;
	Tue, 17 Oct 2023 08:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697531072;
	bh=tom3LKzD4WPrxoOMlWcXOkaTJL2PCHAzD27eMGNLLx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4i8S7QlyOLUBlWGp+GiUJgclkY3/COY8qdGHgBtegTU+FIthCnqN1sks4Wchm3n+
	 ZvLhRotboqIec8IrsiX8StkvY4QJl3p4YXrPQVGfgaoHYG1bFBjhxJ+Ww/ONHwroue
	 0t75VJowGk0w74kGckXoH6NbFcXcxzh+HFcGYmJr0mLmxQE6j6rVQ5OrmeojfNONZH
	 T3iu192hCqs6kySjc+Uj40AIw5DsnzDb93EbLE5YY4/638MN7PB8cIMdmkLlZIVfqA
	 h6lrn+w3I8cJD9cTR8PM5mEbk2VFNLkfR60BwGxBHADfAA5y16nMXhRB0e4sv/bfcc
	 5aX79Mq2hXhnA==
Date: Tue, 17 Oct 2023 10:24:27 +0200
From: Simon Horman <horms@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, miquel.raynal@bootlin.com
Subject: Re: [PATCH net-next v6 3/3] mctp i3c: MCTP I3C driver
Message-ID: <20231017082427.GH1751252@kernel.org>
References: <20231013040628.354323-1-matt@codeconstruct.com.au>
 <20231013040628.354323-4-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013040628.354323-4-matt@codeconstruct.com.au>

On Fri, Oct 13, 2023 at 12:06:25PM +0800, Matt Johnston wrote:
> Provides MCTP network transport over an I3C bus, as specified in
> DMTF DSP0233.
> 
> Each I3C bus (with "mctp-controller" devicetree property) gets an
> "mctpi3cX" net device created. I3C devices are reachable as remote
> endpoints through that net device. Link layer addressing uses the
> I3C PID as a fixed hardware address for neighbour table entries.
> 
> The driver matches I3C devices that have the MIPI assigned DCR 0xCC for
> MCTP.
> 
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

Hi Matt,

one minor nit below, which you can take, leave, or leave for later
as far as I am concerned.

Overall the patch looks good to me and I see that Paolo's review of v5 has
has been addressed.

Reviewed-by: Simon Horman <horms@kernel.org>

> +/* List of mctp_i3c_busdev */
> +static LIST_HEAD(busdevs);
> +/* Protects busdevs, as well as mctp_i3c_bus.devs lists */
> +static DEFINE_MUTEX(busdevs_lock);
> +
> +struct mctp_i3c_bus {
> +	struct net_device *ndev;
> +
> +	struct task_struct *tx_thread;
> +	wait_queue_head_t tx_wq;
> +	/* tx_lock protects tx_skb and devs */
> +	spinlock_t tx_lock;
> +	/* Next skb to transmit */
> +	struct sk_buff *tx_skb;
> +	/* Scratch buffer for xmit */
> +	u8 tx_scratch[MCTP_I3C_MAXBUF];
> +
> +	/* Element of busdevs */
> +	struct list_head list;

I am unsure if it is important, but I observe that on x86_64
list spans a cacheline.

> +
> +	/* Provisioned ID of our controller */
> +	u64 pid;
> +
> +	struct i3c_bus *bus;
> +	/* Head of mctp_i3c_device.list. Protected by busdevs_lock */
> +	struct list_head devs;
> +};

...

