Return-Path: <netdev+bounces-137435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B79A648E
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81FF280E60
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8C1F7062;
	Mon, 21 Oct 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHpCrYBm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4F1F1306;
	Mon, 21 Oct 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507349; cv=none; b=pu0IHQwtlcbq001JidDI9tJlNkWzRqBsPrjwhwBb15Ngw5gUyS5OtxMmjRd0bv686sPlzFDtFA3N1cLsoQSwHHLHPtHdKL86kNryMKiY+HWPKd7Hu/hoJy/1W5Dofm4uKPDsDjpIKxrrFQmsCLa3hpgfkMNPBFmKu44LfMZW+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507349; c=relaxed/simple;
	bh=kk5ERdXa6RnKmIBP1ElSg2khKqiXcvPAlSRRS7M+dbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipgh/x2AFIrVLhSZY0emJlqWngyfGPyGz1/8ujp023TK9G0zHbt8b5o9Kk7c6sl3yUB1wNNRH6KE9uJxeFzAaoMXnO7jgVs+RFxj5/N3zJgX6l4l+Xe2NQlH6Njsg6vUaUb0CK4eKTjGT/GtQfdh0DkL1eWmaGJe19s+t4871hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHpCrYBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1E6C4CEC3;
	Mon, 21 Oct 2024 10:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729507349;
	bh=kk5ERdXa6RnKmIBP1ElSg2khKqiXcvPAlSRRS7M+dbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHpCrYBmW9XdrWMffJCzDEHYWeBxvvY6s19dpu4KOjnV96nbJ9LEQA8iIaF3DMMdk
	 q69/7tTtoQ8v/Stf0ntrhyHtCTGWI/GYsE3T0bxYCdHaLi/+4MQ91glyLd+G0n+V0S
	 oqNG0VV3QlukjMnRR6UKjR0zsymqNZSMTzRargWvoIwXFCt5GZRGs+Rh5Cv9em95RI
	 1+aTLBal3slzWx8JlqXMh+5OLD2Dgr9+DAxDNoBpYi3bW3hOn0WxLh4vWP1PRHYT/f
	 PZvaLB7TTVS533qkxP0MSN+YzQDZUv65Njjm9B7WqkER8ewOUdweKLWSYDLr6lE7l6
	 Q+2gaOIyvUsIg==
Date: Mon, 21 Oct 2024 11:42:24 +0100
From: Simon Horman <horms@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: vsc73xx: implement packet
 reception via control interface
Message-ID: <20241021104224.GE402847@kernel.org>
References: <20241020205452.2660042-1-paweldembicki@gmail.com>
 <20241020205452.2660042-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020205452.2660042-2-paweldembicki@gmail.com>

On Sun, Oct 20, 2024 at 10:54:51PM +0200, Pawel Dembicki wrote:
> Some types of packets can be forwarded only to and from the PI/SI
> interface. For more information, see Chapter 2.7.1 (CPU Forwarding) in
> the datasheet.
> 
> This patch implements the routines required for link-local reception.
> This kind of traffic can't be transferred through the RGMII interface in
> vsc73xx.
> 
> The packet receiver poller uses a kthread worker, which checks if a packet
> has arrived in the CPU buffer. If the header is valid, the packet is
> transferred to the correct DSA conduit interface.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Hi Pawel,

This is not a full review, but I noticed a problem that I wanted to bring
to your attention. Please wait a day or so for others to provide a proper
review before posting a v2.

Thanks!

> ---
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 174 +++++++++++++++++++++++++
>  drivers/net/dsa/vitesse-vsc73xx.h      |   4 +
>  2 files changed, 178 insertions(+)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c

...

> @@ -373,6 +415,7 @@
>  #define VSC73XX_POLL_SLEEP_US		1000
>  #define VSC73XX_MDIO_POLL_SLEEP_US	5
>  #define VSC73XX_POLL_TIMEOUT_US		10000
> +#define VSC73XX_RCV_POLL_INTERVAL	100
>  
>  #define VSC73XX_IFH_MAGIC		0x52
>  #define VSC73XX_IFH_SIZE		8
> @@ -834,6 +877,115 @@ static void vsc73xx_deferred_xmit(struct kthread_work *work)
>  	kfree(xmit_work);
>  }
>  
> +static void vsc73xx_polled_rcv(struct kthread_work *work)
> +{
> +	struct vsc73xx *vsc = container_of(work, struct vsc73xx, dwork.work);
> +	u16 ptr = VSC73XX_CAPT_FRAME_DATA;
> +	struct dsa_switch *ds = vsc->ds;
> +	int ret, buf_len, len, part;
> +	struct vsc73xx_ifh ifh;
> +	struct net_device *dev;
> +	struct dsa_port *dp;
> +	struct sk_buff *skb;
> +	u32 val, *buf;
> +	u16 count;
> +
> +	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_CAPCTRL, &val);
> +	if (ret)
> +		goto queue;
> +
> +	if (!(val & VSC73XX_CAPCTRL_QUEUE0_READY))
> +		/* No frame to read */
> +		goto queue;
> +
> +	/* Initialise reading */
> +	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE, VSC73XX_BLOCK_CAPT_Q0,
> +			   VSC73XX_CAPT_CAPREADP, &val);
> +	if (ret)
> +		goto queue;
> +
> +	/* Get internal frame header */
> +	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
> +			   VSC73XX_BLOCK_CAPT_FRAME0, ptr++, &ifh.datah);
> +	if (ret)
> +		goto queue;
> +
> +	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
> +			   VSC73XX_BLOCK_CAPT_FRAME0, ptr++, &ifh.datal);
> +	if (ret)
> +		goto queue;
> +
> +	if (ifh.magic != VSC73XX_IFH_MAGIC) {
> +		/* Something goes wrong with buffer. Reset capture block */
> +		vsc73xx_write(vsc, VSC73XX_BLOCK_CAPTURE,
> +			      VSC73XX_BLOCK_CAPT_RST, VSC73XX_CAPT_CAPRST, 1);
> +		goto queue;
> +	}
> +
> +	if (!dsa_is_user_port(ds, ifh.port))
> +		goto release_frame;
> +
> +	dp = dsa_to_port(ds, ifh.port);
> +	dev = dp->user;
> +	if (!dev)
> +		goto release_frame;
> +
> +	count = (ifh.frame_length + 7 + VSC73XX_IFH_SIZE - ETH_FCS_LEN) >> 2;
> +
> +	skb = netdev_alloc_skb(dev, len);

len does not appear to be initialised here.

Flagged by W=1 builds.

> +	if (unlikely(!skb)) {
> +		netdev_err(dev, "Unable to allocate sk_buff\n");
> +		goto release_frame;
> +	}
> +
> +	buf_len = ifh.frame_length - ETH_FCS_LEN;
> +	buf = (u32 *)skb_put(skb, buf_len);
> +	len = 0;
> +	part = 0;
> +
> +	while (ptr < count) {
> +		ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
> +				   VSC73XX_BLOCK_CAPT_FRAME0 + part, ptr++,
> +				   buf + len);
> +		if (ret)
> +			goto free_skb;
> +		len++;
> +		if (ptr > VSC73XX_CAPT_FRAME_DATA_MAX &&
> +		    count != VSC73XX_CAPT_FRAME_DATA_MAX) {
> +			ptr = VSC73XX_CAPT_FRAME_DATA;
> +			part++;
> +			count -= VSC73XX_CAPT_FRAME_DATA_MAX;
> +		}
> +	}
> +
> +	/* Get FCS */
> +	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_CAPTURE,
> +			   VSC73XX_BLOCK_CAPT_FRAME0, ptr++, &val);
> +	if (ret)
> +		goto free_skb;
> +
> +	/* Everything we see on an interface that is in the HW bridge
> +	 * has already been forwarded.
> +	 */
> +	if (dp->bridge)
> +		skb->offload_fwd_mark = 1;
> +
> +	skb->protocol = eth_type_trans(skb, dev);
> +
> +	netif_rx(skb);
> +	goto release_frame;
> +
> +free_skb:
> +	kfree_skb(skb);
> +release_frame:
> +	/* Release the frame from internal buffer */
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_CAPTURE, VSC73XX_BLOCK_CAPT_Q0,
> +		      VSC73XX_CAPT_CAPREADP, 0);
> +queue:
> +	kthread_queue_delayed_work(vsc->rcv_worker, &vsc->dwork,
> +				   msecs_to_jiffies(VSC73XX_RCV_POLL_INTERVAL));
> +}

...

-- 
pw-bot: changes-requested

