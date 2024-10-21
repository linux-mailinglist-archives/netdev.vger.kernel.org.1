Return-Path: <netdev+bounces-137451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E8F9A6795
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C667283AF2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386EF1EBA1D;
	Mon, 21 Oct 2024 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRxIrMDl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B61EBA07;
	Mon, 21 Oct 2024 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512463; cv=none; b=o1khD54Ts3gXOLtradHRzKA2K1zqnQtKMqKM2hDQlRghtDNaqDmMZVIBL+K3BYgwFVEWVyjPRVNk2gWAeRqoHBhjzbxQd+avliiaqSH/pzTrw1F8mQXe9fkQMI90xG06KICfGl7mBM/G5mJjFLYO2rQ5bBUtdYnSAWIRboN1yL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512463; c=relaxed/simple;
	bh=PHEPMTwEG8K0yoY+ApGct91QOJs6BMRkynyynPeCVus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajVhyFejo6jJZ/ZmpEdzL0MCbHW9WvBiRfU3WxQ10NMSbTHkW9+pAhk/g8NWxgsY1KFHJcoUfh0xABzusVSIa+N9i2k9d5RJMhhPGV3PVYan5ODU6TwnZQDW31lrT9/4SgLvXoiPMLWYp+mjH8Sgp1raAGRF84+8lsdy8YF0bI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRxIrMDl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4dbb4a89so451895f8f.3;
        Mon, 21 Oct 2024 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729512459; x=1730117259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggnS5dJViY/ewx+1Ep5/8nYWDcCBjkP4ou0qwiymtpo=;
        b=hRxIrMDlR/ROUN9K0maTnTYhczDVVRcR/dldHs8YpOlwg3amW1ROX1JQMs1Yz6lB0w
         HNKLgXntOftcIk4uyHR+q4z/qUriffBWAqD8T4F+Pa+i+2wDUCR0zehNFNZ/E6fesTXO
         II7oxXvdBBURHwZvJOkhdTUXjxOwUUausny5E5JyMDaw9l5lY4f79EYqKcMCJ+xRt2I0
         nLsL9GgiH4WcbpPeZCGxwdO6bA36u9kDpSGlw+SdhWVVIapP+UrrSKn9pU6+D9OvJfys
         1TtLTWrFjbyUImde3WMACiOWunvEAFpJJ6L9oimwAcOWjk+qBZSwiEq/evhA3e9vs3Vf
         SKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729512459; x=1730117259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggnS5dJViY/ewx+1Ep5/8nYWDcCBjkP4ou0qwiymtpo=;
        b=lAv5nrCt9plFEOZr43JwNTh/GKUr5PsJcpJP1LLYKOeGMl83Sgdgfjb5JVISNkR0FN
         2+5pq9OkDcn3ms0GeZmiRw/l8sxa7ftqhip/7EAYEDhU1ErY/VKMwQMiF6uQdMlodOBH
         NFI5Sr3zE0rSSPR80PDWCKupUBmr4kQI050xi8O5eGMrZyJS2OUvqAwSVYTeD/DLQtIr
         6CDRtFkcMJjjAicmaBPcAlvRQcQrlIjzB3JNZgEhNtwVZLF2gaODgHugnJDcCaw6pO77
         cx6uUsZ/T0gLpXeZkotkc0XmCh2VMHpK5zQEdE37CpFcq22mDT3Iy6yRlK8wWtyualj9
         dRQg==
X-Forwarded-Encrypted: i=1; AJvYcCXe1PzJmjOk5UVM3xWiX4EKoZVcMs8x743pwbf9K7BAcj+CUg4DUVzNTaHF3VIw9uC9JJKWq9nhira/etc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8sGABffEN6wasv+5fSf3Ymbb6wbqmqOQGwOrL/0ii5FHksK3
	goNNsVEWJz3rIqgjcbdjxt5wiPmNF+HUblfiQCjnBjNnDW9sKYKT
X-Google-Smtp-Source: AGHT+IGiyvzyxdGmyXpYIwGz53akQzjbxPTQtNjzX3RpBkfN//5e+SEPo1D6yHvvzKeR8Zh1X89fTA==
X-Received: by 2002:a5d:5342:0:b0:37d:4aa2:5cfe with SMTP id ffacd0b85a97d-37eab4eba1cmr2748591f8f.6.1729512459001;
        Mon, 21 Oct 2024 05:07:39 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc401sm54371895e9.43.2024.10.21.05.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:07:38 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:07:35 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: vsc73xx: implement transmit via
 control interface
Message-ID: <20241021120735.xpriovox6tzof45l@skbuf>
References: <20241020205452.2660042-1-paweldembicki@gmail.com>
 <20241020205452.2660042-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020205452.2660042-1-paweldembicki@gmail.com>
 <20241020205452.2660042-1-paweldembicki@gmail.com>

On Sun, Oct 20, 2024 at 10:54:50PM +0200, Pawel Dembicki wrote:
> Some types of packets can be forwarded only to and from the PI/SI
> interface. For more information, see Chapter 2.7.1 (CPU Forwarding) in
> the datasheet.
> 
> This patch implements the routines required for link-local transmission.
> This kind of traffic can't be transferred through the RGMII interface in
> vsc73xx.
> 
> It uses a method similar to the sja1005 driver, where the DSA tagger
> checks if the packet is link-local and uses a special deferred transmit
> route for that kind of packet.
> 
> The vsc73xx uses an "Internal Frame Header" (IFH) in communication via the
> PI/SI interface. Every packet must be prefixed with an IFH. The hardware
> fixes the checksums, so there's no need to calculate the FCS in the
> driver.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 172 +++++++++++++++++++++++++
>  drivers/net/dsa/vitesse-vsc73xx.h      |   1 +
>  include/linux/dsa/vsc73xx.h            |  20 +++
>  net/dsa/tag_vsc73xx_8021q.c            |  73 +++++++++++
>  4 files changed, 266 insertions(+)
>  create mode 100644 include/linux/dsa/vsc73xx.h
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index f18aa321053d..21ab3f214490 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -73,6 +73,9 @@
>  #define VSC73XX_CAT_PR_USR_PRIO	0x75
>  #define VSC73XX_CAT_VLAN_MISC	0x79
>  #define VSC73XX_CAT_PORT_VLAN	0x7a
> +#define VSC73XX_CPUTXDAT	0xc0
> +#define VSC73XX_MISCFIFO	0xc4
> +#define VSC73XX_MISCSTAT	0xc8
>  #define VSC73XX_Q_MISC_CONF	0xdf
>  
>  /* MAC_CFG register bits */
> @@ -166,6 +169,14 @@
>  #define VSC73XX_CAT_PORT_VLAN_VLAN_USR_PRIO GENMASK(14, 12)
>  #define VSC73XX_CAT_PORT_VLAN_VLAN_VID GENMASK(11, 0)
>  
> +/* MISCFIFO Miscellaneous Control Register */
> +#define VSC73XX_MISCFIFO_REWIND_CPU_TX	BIT(1)
> +#define VSC73XX_MISCFIFO_CPU_TX		BIT(0)
> +
> +/* MISCSTAT Miscellaneous Status */
> +#define VSC73XX_MISCSTAT_CPU_TX_DATA_PENDING	BIT(8)
> +#define VSC73XX_MISCSTAT_CPU_TX_DATA_OVERFLOW	BIT(7)
> +
>  /* Frame analyzer block 2 registers */
>  #define VSC73XX_STORMLIMIT	0x02
>  #define VSC73XX_ADVLEARN	0x03
> @@ -363,6 +374,9 @@
>  #define VSC73XX_MDIO_POLL_SLEEP_US	5
>  #define VSC73XX_POLL_TIMEOUT_US		10000
>  
> +#define VSC73XX_IFH_MAGIC		0x52
> +#define VSC73XX_IFH_SIZE		8
> +
>  struct vsc73xx_counter {
>  	u8 counter;
>  	const char *name;
> @@ -375,6 +389,31 @@ struct vsc73xx_fdb {
>  	bool valid;
>  };
>  
> +/* Internal frame header structure */
> +struct vsc73xx_ifh {
> +	union {
> +		u32 datah;
> +		struct {
> +		u32 wt:1, /* Frame was tagged but tag has removed from frame */
> +		    : 1,
> +		    frame_length:14, /* Frame Length including CRC */
> +		    : 11,
> +		    port:5; /* SRC port of switch */

Please indent the struct field members.

> +		};
> +	};
> +	union {
> +		u32 datal;

Is the union with datah/datal actually useful in any way? Just a comment
about high word/low word should suffice?

Is there any field that crosses the word boundary? Or is the IFH nicely
arranged?

Does CPU endianness affect the correct bit layout?

> +		struct {
> +		u32 vid:16, /* VLAN ID */
> +		    : 3,
> +		    magic:9, /* IFH magic field */
> +		    lpa:1, /* SMAC is subject of learning */
> +		    : 1,
> +		    priority:2; /* Switch categorizer assigned priority */
> +		};
> +	};
> +};

__packed

> +
>  /* Counters are named according to the MIB standards where applicable.
>   * Some counters are custom, non-standard. The standard counters are
>   * named in accordance with RFC2819, RFC2021 and IEEE Std 802.3-2002 Annex
> @@ -683,6 +722,133 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
>  	return 0;
>  }
>  
> +static int vsc73xx_tx_fifo_busy_check(struct vsc73xx *vsc, int port)
> +{
> +	int ret, err;
> +	u32 val;
> +
> +	ret = read_poll_timeout(vsc73xx_read, err,
> +				err < 0 ||
> +				!(val & VSC73XX_MISCSTAT_CPU_TX_DATA_PENDING),
> +				VSC73XX_POLL_SLEEP_US,
> +				VSC73XX_POLL_TIMEOUT_US, false, vsc,
> +				VSC73XX_BLOCK_MAC, port, VSC73XX_MISCSTAT,
> +				&val);
> +	if (ret)
> +		return ret;
> +	return err;
> +}
> +
> +static int
> +vsc73xx_write_tx_fifo(struct vsc73xx *vsc, int port, u32 data0, u32 data1)
> +{
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CPUTXDAT, data0);
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CPUTXDAT, data1);
> +
> +	return vsc73xx_tx_fifo_busy_check(vsc, port);
> +}
> +
> +static int
> +vsc73xx_inject_frame(struct vsc73xx *vsc, int port, struct sk_buff *skb)
> +{
> +	struct vsc73xx_ifh *ifh;
> +	u32 length, i, count;
> +	u32 *buf;
> +	int ret;
> +
> +	if (skb->len + VSC73XX_IFH_SIZE < 64)
> +		length = 64;
> +	else
> +		length = skb->len + VSC73XX_IFH_SIZE;

length = min_t(u32, 64, skb->len + VSC73XX_IFH_SIZE)?
Also, what does 64 represent? ETH_ZLEN + ?

> +
> +	count = DIV_ROUND_UP(length, 8);
> +	buf = kzalloc(count * 8, GFP_KERNEL);

this can return NULL

> +	memset(buf, 0, sizeof(buf));
> +
> +	ifh = (struct vsc73xx_ifh *)buf;
> +	ifh->frame_length = skb->len;
> +	ifh->magic = VSC73XX_IFH_MAGIC;
> +
> +	skb_copy_and_csum_dev(skb, (u8 *)(buf + 2));

Do you really _have_ to allocate dynamically a buffer and copy the skb
to it? Can't you write_tx_fifo() based on a pointer from skb->data, and
allocate the IFH as a separate on-stack structure?

For the checksum calculation, you could add the same logic as ocelot_defer_xmit():

	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
		return NULL;

> +
> +	for (i = 0; i < count; i++) {
> +		ret = vsc73xx_write_tx_fifo(vsc, port, buf[2 * i],
> +					    buf[2 * i + 1]);
> +		if (ret) {
> +			/* Clear buffer after error */
> +			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +					    VSC73XX_MISCFIFO,
> +					    VSC73XX_MISCFIFO_REWIND_CPU_TX,
> +					    VSC73XX_MISCFIFO_REWIND_CPU_TX);
> +			goto err;
> +		}
> +	}
> +
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MISCFIFO,
> +		      VSC73XX_MISCFIFO_CPU_TX);
> +
> +	skb_tx_timestamp(skb);

When is the packet transmission actually started? At VSC73XX_MISCFIFO_CPU_TX
time? skb_tx_timestamp() should be done prior to that. PHY TX
timestamping is also hooked into this call, and will be completely
broken if it is racing with the packet transmission.

> +
> +	skb->dev->stats.tx_packets++;
> +	skb->dev->stats.tx_bytes += skb->len;
> +err:
> +	kfree(buf);
> +	return ret;
> +}
> +
> +#define work_to_xmit_work(w) \
> +		container_of((w), struct vsc73xx_deferred_xmit_work, work)
> +
> +static void vsc73xx_deferred_xmit(struct kthread_work *work)
> +{
> +	struct vsc73xx_deferred_xmit_work *xmit_work = work_to_xmit_work(work);
> +	struct dsa_switch *ds = xmit_work->dp->ds;
> +	struct sk_buff *skb = xmit_work->skb;
> +	int port = xmit_work->dp->index;
> +	struct vsc73xx *vsc = ds->priv;
> +	int ret;
> +
> +	if (vsc73xx_tx_fifo_busy_check(vsc, port)) {
> +		dev_err(vsc->dev, "port %d failed to inject skb\n",
> +			port);
> +
> +		/* Clear buffer after error */
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> +				    VSC73XX_MISCFIFO,
> +				    VSC73XX_MISCFIFO_REWIND_CPU_TX,
> +				    VSC73XX_MISCFIFO_REWIND_CPU_TX);
> +
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	ret = vsc73xx_inject_frame(vsc, port, skb);
> +

extraneous blank line

> +	if (ret) {
> +		dev_err(vsc->dev, "port %d failed to inject skb\n",

dev_err_ratelimited(... %pe, ERR_PTR(ret))?

> +			port);
> +		return;
> +	}

Is this hardware procedure completely reentrant (can it simultaneously
inject packets towards multiple ports) or should there be a spinlock
serializing the access?

> +
> +	consume_skb(skb);
> +	kfree(xmit_work);
> +}

