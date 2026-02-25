Return-Path: <netdev+bounces-260971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ+6LKcEn2mZYgQAu9opvQ
	(envelope-from <netdev+bounces-260971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:18:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB4198996
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33BA7302495B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0FB3B8BBE;
	Wed, 25 Feb 2026 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EI3tXeiz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB034E769;
	Wed, 25 Feb 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029079; cv=none; b=BVA9TMASFrj7iQGdqeviadcPEHGZvuppudA2sS1XbghRBiBWxV4qwWx8fg6xLqWXkmyWc3yF11lekFBtgoLbpUU05OE+wpztYWvyvMoIwINHDXfGwbyj6gQD6zEe0MaCGhAQpC9F83RMUQHGiTJhozxTgnw5+gSIC1RzVVAtOio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029079; c=relaxed/simple;
	bh=eDyZkfY11pD0yjDpAiiA3rpFMjKWDPLwHGsbIf4saMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAoC9DbajzwMhqm9qffRoSV+32FpA8DMiqTxX40DtF8ugKyCOIL5tZdryexP8oOrMnyvC2GH9dwKmqW1e6J0vMZyPFQ0wvhOloa0VlK7lI9yWc+BAZ5zl+8E9hN+OXYuNR4K1Ejh5c5Sy0u3L5MtHMd3tJGMUc6m8ENdaE/JIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EI3tXeiz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mN1mwYfUNFyvKdpX0LeKAtQe83coanUfjd//ZCoxGjM=; b=EI3tXeiz6mxxrLgS9r/au28ak6
	qDTtUMlVrmC6anMxmGd/q8RqlgTx9SlpxHZKYtogA+08r2sqMrrCByWhacxsSO8s98Q8Ubfqh0FSN
	lOU+6Ly5rvOgzuFTdlbasRe5fVeu0r+dHjYBYF3PZ0htljpYgWJ3WU0CqhpcMU7nOcr8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvFhq-008kqp-FQ; Wed, 25 Feb 2026 15:17:38 +0100
Date: Wed, 25 Feb 2026 15:17:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: dsa: yt921x: Add port police support
Message-ID: <8be7610c-c606-4c7d-8c8b-b2873bed082e@lunn.ch>
References: <20260225090853.2021140-1-mmyangfl@gmail.com>
 <20260225090853.2021140-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225090853.2021140-3-mmyangfl@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260971-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BDB4198996
X-Rspamd-Action: no action

> +static void u32a_update_u64(u32 *arr, u64 mask, u64 val)
> +{
> +	arr[0] &= ~((u32)mask);
> +	arr[1] &= ~((u32)(mask >> 32));
> +	arr[0] |= (u32)val;
> +	arr[1] |= (u32)(val >> 32);
> +}

The name of this function is not helping me understand what it
actually does.

> +/* v * 2^e */
> +#define ldexpi(v, e) ({ \
> +	__auto_type _v = (v); \
> +	__auto_type _e = (e); \
> +	_e >= 0 ? _v << _e : _v >> -_e; \
> +})
> +
> +/* slot (ns) * rate (/s) / 10^9 (ns/s) = 2^C * token * 4^unit */
> +#define rate2token(rate, unit, slot_ns, C) \
> +	((u32)(ldexpi((slot_ns) * (rate), \
> +		      -(2 * (unit) + (C) + YT921X_TOKEN_RATE_C)) / 1000000000))
> +#define token2rate(token, unit, slot_ns, C) \
> +	(ldexpi(1000000000 * (u64)(token), \
> +		2 * (unit) + (C) + YT921X_TOKEN_RATE_C) / (slot_ns))
> +
> +/* burst = 2^C * token * 4^unit */
> +#define burst2token(burst, unit, C) ((u32)ldexpi((burst), -(2 * (unit) + (C))))
> +#define token2burst(token, unit, C) ldexpi((u64)(token), 2 * (unit) + (C))

Please avoid macros like this. Write functions. The compiler will
inline them if that makes sense. But you gain type checking, etc.

> +static struct yt921x_meter
> +yt921x_meter_tfm(struct yt921x_priv *priv, int port, unsigned int slot_ns,
> +		 u64 rate, u64 burst, unsigned int flags,
> +		 u32 cir_max, u32 cbs_max, int unit_max)
> +{
> +	const int C = flags & YT921X_METER_PKT_MODE ? YT921X_TOKEN_PKT_C :
> +		      YT921X_TOKEN_BYTE_C;
> +	struct device *dev = to_device(priv);
> +	struct yt921x_meter meter;
> +	bool distorted;
> +	u64 burst_est;
> +	u64 burst_max;
> +	u64 rate_max;
> +
> +	meter.unit = unit_max;
> +	rate_max = token2rate(cir_max, meter.unit, slot_ns, C);
> +	burst_max = token2burst(cbs_max, meter.unit, C);
> +
> +	/* Clamp rate and burst */
> +	if (rate > rate_max || burst > burst_max) {
> +		dev_warn(dev,
> +			 "rate %llu, burst %llu too high, max is %llu, %llu, clamping...\n",
> +			 rate, burst, rate_max, burst_max);

I'm not sure clamping is the correct thing to do here. -ERANGE would
make it clearer that what the user requests is not possible.

> +
> +		if (rate > rate_max)
> +			rate = rate_max;
> +		if (burst > burst_max)
> +			burst = burst_max;
> +
> +		burst_est = slot_ns * rate / 1000000000;
> +	} else {
> +		u64 burst_sug;
> +
> +		burst_est = slot_ns * rate / 1000000000;
> +		burst_sug = burst_est;
> +		if (flags & YT921X_METER_PKT_MODE)
> +			burst_sug++;
> +		else
> +			burst_sug += ETH_HLEN + yt921x_mtu_fetch(priv, port) +
> +				     ETH_FCS_LEN;
> +		if (burst_sug > burst)
> +			dev_warn(dev,
> +				 "Consider burst at least %llu to match rate %llu\n",
> +				 burst_sug, rate);
> +
> +		/* Select unit */
> +		for (; meter.unit > 0; meter.unit--) {
> +			if (rate > (rate_max >> 2) || burst > (burst_max >> 2))
> +				break;
> +			rate_max >>= 2;
> +			burst_max >>= 2;
> +		}
> +	}
> +
> +	/* Calculate information rate and bucket size */
> +	distorted = false;
> +	meter.cir = rate2token(rate, meter.unit, slot_ns, C);
> +	if (!meter.cir) {
> +		distorted = true;
> +		meter.cir = 1;
> +	} else if (meter.cir > cir_max) {
> +		WARN_ON(1);
> +		meter.cir = cir_max;

What does this WARN_ON() indicate? If this fires, you want somebody
who is debugging it to be able to understand it.

> +	}
> +	meter.cbs = burst2token(burst, meter.unit, C);
> +	if (!meter.cbs) {
> +		distorted = true;
> +		meter.cbs = 1;
> +	} else if (meter.cbs > cbs_max) {
> +		WARN_ON(1);
> +		meter.cbs = cbs_max;
> +	}
> +	if (distorted)
> +		dev_warn(dev,
> +			 "Have to increase rate %llu, burst %llu to %llu, %llu\n",
> +			 rate, burst,
> +			 token2rate(meter.cir, meter.unit, slot_ns, C),
> +			 token2burst(meter.cbs, meter.unit, C));

I see a difference between clamping, and the granularity the hardware
can do. Clamping should be an error. However, rounding to what the
hardware can actually do is expected, so i would not spam the logs
with it.

> +static int
> +yt921x_dsa_port_policer_add(struct dsa_switch *ds, int port,
> +			    const struct flow_action_police *policer)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
> +	u32 ctrls[YT921X_METER_CTRL_S];
> +	struct yt921x_meter meter;
> +	bool pkt_mode;
> +	u64 burst;
> +	u64 rate;
> +	u32 ctrl;
> +	int res;
> +
> +	/* mtu defaults to unlimited but we got 2040 here, don't know why */
> +	if (policer->exceed.act_id != FLOW_ACTION_DROP ||
> +	    policer->notexceed.act_id != FLOW_ACTION_ACCEPT ||
> +	    policer->peakrate_bytes_ps || policer->avrate ||
> +	    policer->overhead) {
> +		dev_err(dev, "Unsupported options specified\n");

dev_dbg()

You might also want to extend .port_policer_add() to pass the extack
dsa_user_add_cls_matchall_police() has, so you can give a user
friendly error message.

	Andrew

