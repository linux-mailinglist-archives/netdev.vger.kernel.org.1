Return-Path: <netdev+bounces-136910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5F89A39A1
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A171C20D9A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBD71A255C;
	Fri, 18 Oct 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAny8PnY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB801922D7;
	Fri, 18 Oct 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242809; cv=none; b=H5Di43jZJ+u4n09DQ1eyOwXQtjm/QUe6ZyMYoccNc0iQxViuSAnUL8/ROcdTgexvgiBKBl+H1yVI62TsOfP0kn0qK3rhF+V2XAvYHk15VBo34ND6a8Cfat4033fLiEBAXjZRMMHecPl22DBANmJ8Vr/XoDWXo8cRyrwcF+FnreU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242809; c=relaxed/simple;
	bh=d8/uewxz1rX7hFNqb/Dbg4Fk7DVOYvvbbo+Pp/+kU+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWLuDzkDbCByNKU9p59GZ5fx4MQ86OUq9WYx66g51SEYnYj3dd55gDdXTqOwEE+skjCA8TARUSrLGAlnOzdZdXD5BnC4Ol/BPAHpF9lPWHVzXBHmMHlU2D9ory9m4BRENunJebaPxKIXGvPJDSyxKLg+JLz6M9jnxpCnhDI4BVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAny8PnY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314e64eba4so2449905e9.2;
        Fri, 18 Oct 2024 02:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729242805; x=1729847605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tIONkOU5igwAxCn5UCajWfFUel0FYfEBCQ6gdqF4Io=;
        b=EAny8PnYZ1fOdE7liG5TE4S/mAIcUgN43GRFbUfbK32erfoOF1kNnXcMRpR+8iayQj
         RT7AveUTmUNRfjqMKxcXCJnVNuiCzZsuGpENkaKiGRzWkoj5O9c+da/ujFQrIyLXBWZg
         0sbcypybT+MpMFjO+CksVz8/IEyn8VjLXQKKrV8Lxo8/t7iSQmqGnOcaJpy4NruTE/sS
         fPs424w1Q5o4qA4zG6M6O145XbnmMyoQa+JDHvNyPfMTk3psF0u8q0SaCNCe7FM8ksPV
         +JePB3s4NFCcw/f89yM4VyXybfUCeZjv1aKoPnqel/kQ7Jqh7FKVGpdDuCP1DKvRKIV8
         iBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242805; x=1729847605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tIONkOU5igwAxCn5UCajWfFUel0FYfEBCQ6gdqF4Io=;
        b=Cn313fcTBoMmDkI8P9ksSmA00wGnaKDpnZfJWUoB1pwQT93+wKMTP5HGwOjOAiH3cp
         Q4NMh9s30keo9BLw1pVJiY059Eo2eztZLRd2M4pEEBQYOnXSCzgiRgIgiHk+5dnaxluX
         ukBP+isV+aSaOXgJA5uXvLoytLl8Gpy18FafBF0p/eP6tBKerX+JH8YS2+v2xDLJGsx9
         /mKq7RPkO0E5e5KJ/FeVJedksGRikRlJ0Zg/52XD1YHtVcUvD3fl3N5yAWbJZStKYxxu
         /HVSsn7yFMnnPCR98tcMUWNyELQhaqdqUrnTCWcHV/t30flFZok61bYEtVC1LXfDBBW3
         4izg==
X-Forwarded-Encrypted: i=1; AJvYcCUrgax37G2fbK58AkLIeFQTPS53EXWT1GeeZXOf7alBrCaOcBTxRIePTJURZwl64c4wxwjLkbhJJUNz/dU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm1lEhAkMpFtTjWXtruqTHzhqmLnRn36uJJEY8YuysOo8VXdDA
	6wl23ElwofyuWjXdm/Bo3gZW4Y+5b20NL+mBXc7u/GfFjind7/3vVhbX9A==
X-Google-Smtp-Source: AGHT+IHs8ZRNnUB0mkW6u0KW5Jl1JQyFwugKrrmDLohyc9r6cBPtRmLmpi4K7SO+2fw+W3rbF75b2g==
X-Received: by 2002:a05:600c:3b9b:b0:42c:ba83:3f08 with SMTP id 5b1f17b1804b1-431616236d2mr5834455e9.2.1729242804722;
        Fri, 18 Oct 2024 02:13:24 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431606d622esm21740095e9.45.2024.10.18.02.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:13:24 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:13:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v2 7/8] net: stmmac: xgmac: Complete FPE support
Message-ID: <20241018091321.gfsdx7qzl4yoixgb@skbuf>
References: <cover.1729233020.git.0x1207@gmail.com>
 <1776606b2eda8430077551ca117b035f987b5b70.1729233020.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1776606b2eda8430077551ca117b035f987b5b70.1729233020.git.0x1207@gmail.com>

On Fri, Oct 18, 2024 at 02:39:13PM +0800, Furong Xu wrote:
> Implement the necessary stmmac_fpe_ops function callbacks for xgmac.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> index dfe911b3f486..c90ed7c1279d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> @@ -373,6 +373,78 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr,
>  			     &dwxgmac3_fpe_info);
>  }
>  
> +static int dwxgmac3_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> +{
> +	return common_fpe_irq_status(ioaddr + XGMAC_MAC_FPE_CTRL_STS, dev);
> +}
> +
> +static void dwxgmac3_fpe_send_mpacket(void __iomem *ioaddr,
> +				      struct stmmac_fpe_cfg *cfg,
> +				      enum stmmac_mpacket_type type)
> +{
> +	common_fpe_send_mpacket(ioaddr + XGMAC_MAC_FPE_CTRL_STS, cfg, type);
> +}
> +
> +static int dwxgmac3_fpe_get_add_frag_size(const void __iomem *ioaddr)
> +{
> +	return FIELD_GET(FPE_MTL_ADD_FRAG_SZ,
> +			 readl(ioaddr + XGMAC_MTL_FPE_CTRL_STS));
> +}
> +
> +static void dwxgmac3_fpe_set_add_frag_size(void __iomem *ioaddr,
> +					   u32 add_frag_size)
> +{
> +	u32 value;
> +
> +	value = readl(ioaddr + XGMAC_MTL_FPE_CTRL_STS);
> +	writel(u32_replace_bits(value, add_frag_size, FPE_MTL_ADD_FRAG_SZ),
> +	       ioaddr + XGMAC_MTL_FPE_CTRL_STS);
> +}
> +
> +static int dwxgmac3_fpe_map_preemption_class(struct net_device *ndev,
> +					     struct netlink_ext_ack *extack,
> +					     u32 pclass)
> +{
> +	u32 val, offset, count, preemptible_txqs = 0;
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	u32 num_tc = ndev->num_tc;
> +
> +	if (!num_tc) {
> +		/* Restore default TC:Queue mapping */
> +		for (u32 i = 0; i < priv->plat->tx_queues_to_use; i++) {
> +			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
> +			writel(u32_replace_bits(val, i, XGMAC_Q2TCMAP),
> +			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
> +		}
> +	}
> +
> +	/* Synopsys Databook:
> +	 * "All Queues within a traffic class are selected in a round robin
> +	 * fashion (when packets are available) when the traffic class is
> +	 * selected by the scheduler for packet transmission. This is true for
> +	 * any of the scheduling algorithms."
> +	 */
> +	for (u32 tc = 0; tc < num_tc; tc++) {
> +		count = ndev->tc_to_txq[tc].count;
> +		offset = ndev->tc_to_txq[tc].offset;
> +
> +		if (pclass & BIT(tc))
> +			preemptible_txqs |= GENMASK(offset + count - 1, offset);
> +
> +		for (u32 i = 0; i < count; i++) {
> +			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
> +			writel(u32_replace_bits(val, tc, XGMAC_Q2TCMAP),
> +			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
> +		}
> +	}
> +
> +	val = readl(priv->ioaddr + XGMAC_MTL_FPE_CTRL_STS);
> +	writel(u32_replace_bits(val, preemptible_txqs, FPE_MTL_PREEMPTION_CLASS),
> +	       priv->ioaddr + XGMAC_MTL_FPE_CTRL_STS);
> +
> +	return 0;
> +}
> +
>  const struct stmmac_fpe_ops dwmac5_fpe_ops = {
>  	.fpe_configure = dwmac5_fpe_configure,
>  	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
> @@ -384,4 +456,9 @@ const struct stmmac_fpe_ops dwmac5_fpe_ops = {
>  
>  const struct stmmac_fpe_ops dwxgmac_fpe_ops = {
>  	.fpe_configure = dwxgmac3_fpe_configure,
> +	.fpe_send_mpacket = dwxgmac3_fpe_send_mpacket,
> +	.fpe_irq_status = dwxgmac3_fpe_irq_status,
> +	.fpe_get_add_frag_size = dwxgmac3_fpe_get_add_frag_size,
> +	.fpe_set_add_frag_size = dwxgmac3_fpe_set_add_frag_size,
> +	.fpe_map_preemption_class = dwxgmac3_fpe_map_preemption_class,
>  };

This is much better in terms of visibility into the change.

Though I cannot stop thinking that this implementation design:

stmmac_fpe_configure()
-> stmmac_do_void_callback()
   -> fpe_ops->fpe_configure()
      /                    \
     /                      \
    v                        v
dwmac5_fpe_configure   dwxgmac3_fpe_configure
     \                      /
      \                    /
       v                  v
       common_fpe_configure()

is, pardon the expression, stuffy.

If you aren't very opposed to the idea of having struct stmmac_fpe_ops
contain a mix of function pointers and integer constants, I would
suggest removing:

	.fpe_configure()
	.fpe_send_mpacket()
	.fpe_irq_status()
	.fpe_get_add_frag_size()
	.fpe_set_add_frag_size()

and just keeping a single function pointer, .fpe_map_preemption_class(),
inside stmmac_fpe_ops. Only that is sufficiently different to warrant a
completely separate implementation. Then move all current struct
stmmac_fpe_configure_info to struct stmmac_fpe_ops, and reimplement
stmmac_fpe_configure() directly like common_fpe_configure(),
stmmac_fpe_send_mpacket() directly like common_fpe_send_mpacket(), etc etc.
This lets us avoid the antipattern of calling a function pointer (hidden
by an opaque macro) from common code, only to gather some parameters to
call again a common implementation.

I know this is a preposterous and heretic thing to suggest, but a person
who isn't knee-deep in stmmac has a very hard time locating himself in
space due to the unnecessarily complex layering. If that isn't something
that is important, feel free to ignore.

