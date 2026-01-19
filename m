Return-Path: <netdev+bounces-251326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE8ED3BB06
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 23:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5332430389AF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64671B808;
	Mon, 19 Jan 2026 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJlfgl9d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC06500972
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768862891; cv=none; b=FlXUbDQKz8KTix+KN8ZQDbjcMkRN/jSJMM37TmcQUCX2aUQtksv2hwnh9yr41OTFXPcQM/w7SbiH4zmCEgjLWFrnz/FLsj/MFNLX+la9HyQ9h8So7zOBeTd8oAP8KZqTbOwZbGEVm4Z3m3+OZk1OO4o0czmrTomOx41yF+DixsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768862891; c=relaxed/simple;
	bh=bD1z/PN+x3psCjnyC4I0t+mxoFCICQGXJanx1lcbVQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kofWEcrKJj/qJ2VGqwHt6WmGK7mCwyK7wpBl3d3LP1Yefc0yrDAtT6kbhx05kHnoVdZJ/w2CeQSDM5r2gYZ/pgveRheJODO3OCkqDBVtwtKml7khqWZQNMfpErF0uTx1KNjQ/3ms0XMKM5mhAX8/RVNVmXiFuhLkdO0kLRaBjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJlfgl9d; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4358f854840so678f8f.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768862888; x=1769467688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXT+K1cDDWllvWtcw5+dpqQq02cMP5fk/sy9EbjTNVU=;
        b=GJlfgl9d/fh/5DQ45vMCe03Hh9IgzrzXC/eL3GCQgBNUvDIlG+L5dyYCj2qgxGmZIk
         vzD7tXEBugNrnmPAINg7hg2VQLM6i6N/77aaPn0mai0XheiezRMuSbfUui+eK5RVv/aY
         1PHyGBlGgbf587/KwWYQ9P8syyPRjrBd9vl75Pq5rHkmqOkELrbNEnIFMhIhUmc6+pi9
         SoaAeAadDbrPm9pL4WkqsyRIGrX8rneDvdoYH3JdPbq+rcgkQl+iclsT6sjwOBNn+Wzx
         ZlG9ebPDb/NfsoTrBCwTedpC2PB300XLDKv+t6ASWeVhZY24sinbx3UyaFSmvdWkXoqR
         9QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768862888; x=1769467688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXT+K1cDDWllvWtcw5+dpqQq02cMP5fk/sy9EbjTNVU=;
        b=Gdjw4eVNrAhbK7p03S7tsS4KXFVyHYr12IU2m17q3Jp6F3gIP+SvWTg+u5mRhm+JlN
         zk0E8amYxSjxN6dnTAMbp4OdSwM+zLA/mq8PgoX/WZnEA3Az+Vru+TxuT/PWNxngy32w
         fZiK/FkXJSqE2Yj7cRjx+EqD7dLJOZuetwe4OTSaCSxi5DgjqSU2WhwXPlHI97fQIAvW
         9rhQjV3Br8fWfcuFC+Xm5DHiuLRosHH+Prsqm4ioAExk8e3Tsz6AR7dUVSh+QhyzMfOj
         7Im4xxV1Ci7znwUeNlkD/Tj6tnq/8vkWeeyC8DUxsT8mH2SXauan5BxQDESZgXvnERLe
         U73A==
X-Forwarded-Encrypted: i=1; AJvYcCWUMY6mlssXXJHzHWRP8ySbj7SUr9o0zm/aRHG8avqbnGVHHkj2VA3jcEnjDbQMAQSPoAJsQSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSm9Ce+ZERcz7Sx1zogf9vr2BW8U1iXqFB8COEwwXMsDcUz3vc
	CG8LZixQ/opG/5LmQTsyj5v0H92ANtoit25r7r2MYZlFk+u5SCrIoXFo
X-Gm-Gg: AZuq6aJ5e3pOvpPN54+2d8kVcmi7xuKbC/8M87/JWad8iKKCDchNOMqyAhDPOL0GFFM
	J2eOIvGN7wT79cYfyR0noKkD18/qYRpsOJ/w0R1o9Wd5i8ga/gk3KnqMVedMuNG7uESJTFWASKV
	aqWeopM8Y0BmRywsoAOxQDdVzqQf7Pix3qZXqaLGoFUbvWDuDyKw4yewKWYu+I1pvFZ4MYPtLBU
	Kg/ahaVmJCFLdzHdtFS/BKdj00N4WMP5Obky18hQKot96W48b9Y3j9xgu4gduB9phYZc4sZ6RkI
	jZzIgJNRiCkxr8OTpalSNsP0YCD4sxxbD7nbKyx6y+b9XNeJ/YZ6UCYM/qsvM82JJVhOY34BQgL
	kTbfTBAhEIvDdecJAtt4sMB4OMBJSeh+54h1dDiOvdwWKoXsxX66LHNXesob4Gn/KzNrxfo0g7d
	yde03d975bwdGsaw==
X-Received: by 2002:a05:6000:2309:b0:430:fa9a:769 with SMTP id ffacd0b85a97d-4358b9cb703mr806308f8f.8.1768862888046;
        Mon, 19 Jan 2026 14:48:08 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:619a:24df:1726:f869])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm25609148f8f.27.2026.01.19.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 14:48:07 -0800 (PST)
Date: Tue, 20 Jan 2026 00:48:05 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: dsa: ks8995: Implement port
 isolation
Message-ID: <20260119224805.hjvh5xdjfhd6c6kf@skbuf>
References: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
 <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
 <20260119-ks8995-fixups-v2-4-98bd034a0d12@kernel.org>
 <20260119-ks8995-fixups-v2-4-98bd034a0d12@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-ks8995-fixups-v2-4-98bd034a0d12@kernel.org>
 <20260119-ks8995-fixups-v2-4-98bd034a0d12@kernel.org>

On Mon, Jan 19, 2026 at 03:30:08PM +0100, Linus Walleij wrote:
> It is unsound to not have proper port isolation on a
> switch which supports it.
> 
> Set each port as isolated by default in the setup callback
> and de-isolate and isolate the ports in the bridge join/leave
> callbacks.
> 
> Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
> Reported-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/ks8995.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
> index 060bc8303a14..574e14743a36 100644
> --- a/drivers/net/dsa/ks8995.c
> +++ b/drivers/net/dsa/ks8995.c
> @@ -80,6 +80,11 @@
>  #define KS8995_PC0_TAG_REM	BIT(1)	/* Enable tag removal on port */
>  #define KS8995_PC0_PRIO_EN	BIT(0)	/* Enable priority handling */
>  
> +#define KS8995_PC1_SNIFF_PORT	BIT(7)	/* This port is a sniffer port */
> +#define KS8995_PC1_RCV_SNIFF	BIT(6)	/* Packets received goes to sniffer port(s) */
> +#define KS8995_PC1_XMIT_SNIFF	BIT(5)	/* Packets transmitted goes to sniffer port(s) */
> +#define KS8995_PC1_PORT_VLAN	GENMASK(4, 0)	/* Port isolation mask */
> +
>  #define KS8995_PC2_TXEN		BIT(2)	/* Enable TX on port */
>  #define KS8995_PC2_RXEN		BIT(1)	/* Enable RX on port */
>  #define KS8995_PC2_LEARN_DIS	BIT(0)	/* Disable learning on port */
> @@ -441,6 +446,44 @@ dsa_tag_protocol ks8995_get_tag_protocol(struct dsa_switch *ds,
>  
>  static int ks8995_setup(struct dsa_switch *ds)
>  {
> +	struct ks8995_switch *ks = ds->priv;
> +	int ret;
> +	u8 val;
> +	int i;
> +
> +	/* Isolate all user ports so they can only send packets to itself and the CPU port */

I would refrain from using "isolation" related terminology for user port
separation, because of the naming collision with the BR_ISOLATED bridge
port flag (from "man bridge", isolated bridge ports "will be able to
communicate with non-isolated ports only").

> +	for (i = 0; i < KS8995_CPU_PORT; i++) {
> +		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), &val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", i);
> +			return ret;
> +		}
> +
> +		val &= ~KS8995_PC1_PORT_VLAN;
> +		val |= (BIT(i) | BIT(KS8995_CPU_PORT));
> +
> +		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), val);

Do you actually need to perform a register read at probe time, or could
you just call ks8995_write_reg() with known good values for the sniff
port bits too?

> +		if (ret) {
> +			dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", i);
> +			return ret;
> +		}
> +	}
> +
> +	/* The CPU port should be able to talk to all ports */
> +	ret = ks8995_read_reg(ks, KS8995_REG_PC(KS8995_CPU_PORT, KS8995_REG_PC1), &val);
> +	if (ret) {
> +		dev_err(ks->dev, "failed to read KS8995_REG_PC1 on CPU port\n");
> +		return ret;
> +	}
> +
> +	val |= KS8995_PC1_PORT_VLAN;

Writing this value enables hairpinning (reflection of forwarded traffic)
on the CPU port, because KS8995_PC1_PORT_VLAN (GENMASK(4, 0)) includes
KS8995_CPU_PORT (4).

> +
> +	ret = ks8995_write_reg(ks, KS8995_REG_PC(KS8995_CPU_PORT, KS8995_REG_PC1), val);
> +	if (ret) {
> +		dev_err(ks->dev, "failed to write KS8995_REG_PC1 on CPU port\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -466,8 +509,44 @@ static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
>  				   bool *tx_fwd_offload,
>  				   struct netlink_ext_ack *extack)
>  {
> +	struct ks8995_switch *ks = ds->priv;
> +	u8 port_bitmap = 0;
> +	int ret;
> +	u8 val;
> +	int i;
> +
> +	/* De-isolate this port from any other port on the bridge */
> +	port_bitmap |= BIT(port);

A bit strange to unconditionally modify the initialization value of a
variable rather than just assign BIT(port) as its initializer.

> +	for (i = 0; i < KS8995_CPU_PORT; i++) {
> +		if (i == port)
> +			continue;
> +		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
> +			continue;

dsa_to_port() has an embedded loop over ports inside, so actually this
loop iterates ds->num_ports^2 times. It is recommended that you use the
dsa_switch_for_each_user_port() iterator and that gives you "dp"
directly (i becomes dp->index).

> +		port_bitmap |= BIT(i);
> +	}
> +
> +	/* Update all affected ports with the new bitmask */
> +	for (i = 0; i < KS8995_CPU_PORT; i++) {
> +		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
> +			continue;
> +
> +		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), &val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", i);
> +			return ret;
> +		}
> +
> +		val |= port_bitmap;

Same hairpinning problem. When a new port joins a bridge, the existing
ports start enabling forwarding to themselves as well (the port_bitmap
written to port i contains BIT(i) set).

> +
> +		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", i);
> +			return ret;
> +		}
> +	}
> +
>  	/* port_stp_state_set() will be called after to put the port in
> -	 * appropriate state so there is no need to do anything.
> +	 * appropriate state.
>  	 */
>  
>  	return 0;
> @@ -476,8 +555,56 @@ static int ks8995_port_bridge_join(struct dsa_switch *ds, int port,
>  static void ks8995_port_bridge_leave(struct dsa_switch *ds, int port,
>  				     struct dsa_bridge bridge)
>  {
> +	struct ks8995_switch *ks = ds->priv;
> +	u8 port_bitmap = 0;
> +	int ret;
> +	u8 val;
> +	int i;
> +
> +	/* Isolate this port from any other port on the bridge */
> +	for (i = 0; i < KS8995_CPU_PORT; i++) {
> +		/* Current port handled last */
> +		if (i == port)
> +			continue;
> +		/* Not on this bridge */
> +		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
> +			continue;
> +
> +		ret = ks8995_read_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), &val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", i);
> +			return;
> +		}
> +
> +		val &= ~BIT(port);
> +
> +		ret = ks8995_write_reg(ks, KS8995_REG_PC(i, KS8995_REG_PC1), val);
> +		if (ret) {
> +			dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", i);
> +			return;
> +		}
> +
> +		/* Accumulate this port for access by current */
> +		port_bitmap |= BIT(i);
> +	}
> +
> +	/* Isolate this port from all other ports formerly on the bridge */
> +	ret = ks8995_read_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC1), &val);
> +	if (ret) {
> +		dev_err(ks->dev, "failed to read KS8995_REG_PC1 on port %d\n", port);
> +		return;
> +	}
> +
> +	val &= ~port_bitmap;
> +
> +	ret = ks8995_write_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC1), val);
> +	if (ret) {
> +		dev_err(ks->dev, "failed to write KS8995_REG_PC1 on port %d\n", port);
> +		return;
> +	}
> +

The register layout seems identical with the one from ksz8_cfg_port_member(),
but that being said, I don't think I have a problem with the KS8995
driver continuing to be maintained separately (for now).

>  	/* port_stp_state_set() will be called after to put the port in
> -	 * forwarding state so there is no need to do anything.
> +	 * forwarding state.
>  	 */
>  }
>  
> 
> -- 
> 2.52.0
> 


