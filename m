Return-Path: <netdev+bounces-137444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A29A66C1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB5AB21804
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDA61E5037;
	Mon, 21 Oct 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etV94ytk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB17194C62;
	Mon, 21 Oct 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510746; cv=none; b=myfq5a7rGbAR8Mcb2uqlwXSg+qMdvk0jMySKyLIprwCC05pkycK0e0C2gICHy908zJjfnXnFofuyiXoJi5lUUv9iP0eHA4Z5sQF+xn5fQzTXfG9CFrbaQQI6ZAwjLJPrZOhNdJ4YI7tHA6XWzd0wzcgDbQ68WsRvjgDaVCaRU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510746; c=relaxed/simple;
	bh=pRAr39udOixEtekfppP7DQQEortkQ5mxMDWZ65FeB/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnUxuLA6nVwmOUXSipx9IlVAUCVTydOMAAc93wpQSXCEPwNmTRHeGHhOYDi6Pz/5XjTfiQnOOakqi6tnhW2YRpdd7SK3/rGKCbc/HAGw6cPDuHIqypFcW2oZnhfJ0yMMnkr2tl2tk8O2PI/7nuGOXAPdyWI6FwFB70E2e9RAWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etV94ytk; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9404cef42so569347a12.0;
        Mon, 21 Oct 2024 04:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729510742; x=1730115542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUcsd2Wka+nMqbOub0wYkSaMF0Kpazo3FZ9ZuvO3RJI=;
        b=etV94ytk+kOIIriYi3EUj6D7AidYrJPlFht+h6WtEbawZSGPysMiWbFASD9MeEQEhi
         w4/pPM7a5GAu7+h6PnEKoKmQv1Clzt5hTdlIpClGv07NoUb2V5DXq5cJ1dCLtqQl2+cs
         X85LUponKWwUJe6rtq2lUNZLoT5CROhMMEJDxd5ZkW7pu4ZLLLB+TPM5gCjZWpO1VQIx
         t21xp6v4tojRW3XHAdLhMTvX8BZpZYtjY0mkoSHR0InP7UcU7g4UVGz+sOorzF0WMN2c
         fsvu1p8Iy/V7erbbehofz4W+GKM9QwfbMJaNUq1519q5N0kQe+u2a3JU3Qqoyfv2KzUC
         /rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729510742; x=1730115542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUcsd2Wka+nMqbOub0wYkSaMF0Kpazo3FZ9ZuvO3RJI=;
        b=G94TmSBuyxEoZhfRchCkjTpOb0AC7M3Zuv0jF40zsVCyGefIiICB9b9pe6blrAbd3k
         P7cZxuY8KQ+cLIiBLCX+GCC4gDeHNz9afp4TpTJgJ/wSCnOhwt+Bts6Nhg9nK5cC1TsU
         CTHXhHYrTbbhGGiX2uH+yWqNP9/PvuL8BlxhXEq7NvqIFWSawFgqYnKolzouXQN78NjE
         cGcGaY1tjVP5d7oBBXMLLIxvBloYns6T88o7Y+zPtYLimp0Grk/48K1ECnu20IvFrYp7
         +FsbMfVVb7UzQoO9S7ABSpuShBjcGXLU0UtfOp3wKUD4ELH9HMa/01Hxj7pbZWZPirr7
         6f3g==
X-Forwarded-Encrypted: i=1; AJvYcCUzamrcb3eO7NWbEgbTcLXKqXEPEdN+UXhkw+nRW6VyAIc86cNJa/IxMUMmCrGa9rVC7CoBCpTg/EcMajI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx+XIsbafS/QYEw5PxiLkVggCsqt42+uRr49mXbaZ3fnDKrd2S
	3LJU4i+c8bvWmzux8eXXA4ti3vrMZtjtgtecLFmlj363AT+oY8EI
X-Google-Smtp-Source: AGHT+IElxp0rHe38JY4vKtRNnydfC8gdIvo0O9gE52VoxJUduSj6EsEPz4nStnVsP/ldWlOMBswfLA==
X-Received: by 2002:a05:6402:4402:b0:5c9:2a46:b45c with SMTP id 4fb4d7f45d1cf-5ca0ac512famr4594491a12.3.1729510742031;
        Mon, 21 Oct 2024 04:39:02 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b500sm1837153a12.13.2024.10.21.04.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 04:39:01 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:38:57 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: vsc73xx: implement packet
 reception via control interface
Message-ID: <20241021113857.2csr3dd55fxorbab@skbuf>
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
> ---

Is there no way to use an IRQ for packet reception from the PI/SI interface?
And if not, is there no way to use any workaround to do event-based reception?
Like for example how felix has the quirk_no_xtr_irq mechanism through which
it replicates all traffic that would go to the PI/SI interface to also go
over Ethernet, and use the reception of the packet as the trigger for something
being available to read from PI/SI?

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

Log that?

> +		goto queue;
> +	}
> +
> +	if (!dsa_is_user_port(ds, ifh.port))
> +		goto release_frame;

First do the dsa_to_port(), and then convert this to dsa_port_is_user().

> +
> +	dp = dsa_to_port(ds, ifh.port);
> +	dev = dp->user;
> +	if (!dev)
> +		goto release_frame;
> +
> +	count = (ifh.frame_length + 7 + VSC73XX_IFH_SIZE - ETH_FCS_LEN) >> 2;

What's "(.. + 7) >> 2" doing? Some sort of DIV_ROUND_UP(..., 4)? But why 7?
Please don't be afraid to use the arithmetic macros that make the code
more readable. You can confirm with "make drivers/net/dsa/vitesse-vsc73xx-core.lst"
that they should end up generating code that is just as efficient as the
"optimized" bit shift.

> +
> +	skb = netdev_alloc_skb(dev, len);
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

Log errors with dev_err_ratelimited() maybe?

> +	kthread_queue_delayed_work(vsc->rcv_worker, &vsc->dwork,
> +				   msecs_to_jiffies(VSC73XX_RCV_POLL_INTERVAL));
> +}
> +
>  static int
>  vsc73xx_connect_tag_protocol(struct dsa_switch *ds, enum dsa_tag_protocol proto)
>  {
> @@ -1111,14 +1263,36 @@ static int vsc73xx_setup(struct dsa_switch *ds)
>  	ret = dsa_tag_8021q_register(ds, htons(ETH_P_8021Q));
>  	rtnl_unlock();
>  
> +	/* Reset capture block */
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_CAPTURE, VSC73XX_BLOCK_CAPT_RST,
> +		      VSC73XX_CAPT_CAPRST, 1);
> +
> +	/* Capture BPDU frames */
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_CAPENAB,
> +		      VSC73XX_CAPENAB_BPDU);
> +
> +	vsc->rcv_worker = kthread_create_worker(0, "vsc73xx_rcv");
> +	if (IS_ERR(vsc->rcv_worker))
> +		return PTR_ERR(vsc->rcv_worker);

There's teardown work to do on error here.

> +
> +	kthread_init_delayed_work(&vsc->dwork, vsc73xx_polled_rcv);
> +
> +	kthread_queue_delayed_work(vsc->rcv_worker, &vsc->dwork,
> +				   msecs_to_jiffies(VSC73XX_RCV_POLL_INTERVAL));
> +
>  	return ret;

This "return ret" is the error code of dsa_tag_8021q_register(). The new
code block is very badly placed.

>  }
>  
>  static void vsc73xx_teardown(struct dsa_switch *ds)
>  {
> +	struct vsc73xx *vsc = ds->priv;
> +
>  	rtnl_lock();
>  	dsa_tag_8021q_unregister(ds);
>  	rtnl_unlock();
> +
> +	kthread_cancel_delayed_work_sync(&vsc->dwork);
> +	kthread_destroy_worker(vsc->rcv_worker);

This needs to be the reverse process of vsc73xx_setup().

>  }
>  
>  static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index bf55a20f07f3..5dd458793741 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -47,6 +47,8 @@ struct vsc73xx_portinfo {
>   *	every vlan configured in port vlan operation. It doesn't cover tag_8021q
>   *	vlans.
>   * @fdb_lock: Mutex protects fdb access
> + * @rcv_worker: Kthread worker struct for packet reciver poller
> + * @dwork: Work struct for scheduling work to the packet reciver poller
>   */
>  struct vsc73xx {
>  	struct device			*dev;
> @@ -60,6 +62,8 @@ struct vsc73xx {
>  	struct vsc73xx_portinfo		portinfo[VSC73XX_MAX_NUM_PORTS];
>  	struct list_head		vlans;
>  	struct mutex			fdb_lock;
> +	struct kthread_worker		*rcv_worker;
> +	struct kthread_delayed_work	dwork;
>  };
>  
>  /**
> -- 
> 2.34.1
> 

