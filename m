Return-Path: <netdev+bounces-223776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA4B7D0C8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E54A327DE5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328DF27A92E;
	Tue, 16 Sep 2025 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGf1oWew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681136D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758064642; cv=none; b=fgCQximIaxWF7e8tylDMR6RnsUX7YlJPlqEJIWUx+yL1OqGVQ+70hzsIx7CB8GY8wPna6TEMCaq1v4OL7Hry+1y2pDQ2dvBWKSjFBmDCV0lwGXeNFkzXdGw1lKdh6IznkDzdI/HMEpdiJq90gPbpRKK1tE6Fo7QnkX5GM6xTiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758064642; c=relaxed/simple;
	bh=X5/MAOMUZ3YRBAJVhW4dSr6my1lQOqeEje+zZMKkuQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWeAf3ilxbYeZs7OLgpciBgptdZ58gAGqjoFeh/2U2ilux4ZeeCKrmJZThJaiQALbrHkeUXwwVwxQU+01j+6LgWBx50kvDyf63So9LX4SoYJz0vFwt3XWDTCD3E2sJ1sv1eniJLXeba1Yr/Kei5sO+ZoSjOMHlcgFh3uL6VytvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGf1oWew; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd505ae02so7411575e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758064638; x=1758669438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TN5VvG9eYXVwt1bhV4jbSWX8Y0jMtqdJbYqlK4S1fyM=;
        b=GGf1oWewFlurcyx8HGSx4l0O26TRHM5e6JS4auQeBYr2fypbdAFitMsWxJdAl1ZJz2
         PQihHKvBYxVtmoE6hbvo4fdOvkD/FzTouv2dtQUxxtVD0Datx5nULdcnRuDikX9dGLBs
         voSFRn4RsPICfAujGfQS6o7iF618VgQZ9vK9LcQrEfXNUnznwuHQSl2l7AhXNWVe+AMP
         /JiEMAyEwzFo9rXgIuzkggyIXgw8kgWS4gHa89ysjz2Jlx5EP/bquW2Z9buRojWYII1O
         39Ycilfqx0qbISx8GyWDWtOTrtT1SGyUJeNJDlC1qdJESfG+i4BEkIE1G/J5V0YfhS1K
         dRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758064638; x=1758669438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN5VvG9eYXVwt1bhV4jbSWX8Y0jMtqdJbYqlK4S1fyM=;
        b=drg/mFVHYQVBBT6rfFdMFRb5B2t3xX3wsNENWQTrv3ve3qr3Efs+BAil496Hc5qfKf
         RDIxdcjabFVJmXHA6CqAaRbGJqENufxP7kh6hzQYk9bO7BVZ8p7r4M5Uuk6LKQIecPQ/
         Uv6/PMejCCw5zwCzk4c+IbpLg1Ba7ud9Th6pPxVXFE2yEqgKqlTZMGSt6YODdfjqXbUH
         Q4/mC2OgU9ViU/VBZZ3DWpZtH4iG9+9U9Jh4D1+g2gKhLeF4fLXs28p9h8Lh9HNPJCpL
         ce1GTu52HSUF/KsXc/q7mRCmtx4AW1HgEgCmZ0XX2Fp9mYSO83+RFUnVXRO6PCB8Okm3
         XZDQ==
X-Gm-Message-State: AOJu0YwXLlxxGVo1Pqg//rrDED4fOiBUdR3YF63tyx9WGeIXPn/zyAp+
	hQRXMn5hmoeybpQYIPGwh4pfw9qMa01mU6s4ZHdCt2984Lkx19Bw+6bL
X-Gm-Gg: ASbGncvHDJZ5b9fJ9zStq7/4Z1ZYhXTdJ/qsbeeu5roqFmC5JWL3hOdb6GCNEbMX2Xs
	+DwTLXoPkKF5/QePe68PtQt5w1/ZI1VuyDjPkC91jubQBOQ1RKWWFHaTRPK65NGqWZ9fueEsH0A
	EW7jykBe8vQiqMow5eFJdtzkI7s+fU9mcsLZ0/g5C4K5ffNUrgNctbZii+SCiIOtzGN3BTmS5/6
	KcGIRwVbTxmdAkEk0G1HI6vu7jxhRrvvilSqDQBdIbo68VwoxdUTfAKY3ZFCLIH30mOA6hWbnZs
	GsYh2PmZMMZAGPir3PZdgsc8gfuVZToFNTkLHWHWnGPIH1g9NzFps6NurOsIDIqEXZ3w2+ytAAL
	XPXiMk7TaM3W+3Ts=
X-Google-Smtp-Source: AGHT+IELnfXH4cnONzq0phWcV8mAKO+mqNu5pFgfL9NCchPak8ynyq9Uk/wCZeyEgkvCFehm6HR/Cg==
X-Received: by 2002:a05:6000:220e:b0:3e2:ac0:8c3e with SMTP id ffacd0b85a97d-3ecdfa5ed2amr30913f8f.11.1758064637514;
        Tue, 16 Sep 2025 16:17:17 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775880sm23815857f8f.2.2025.09.16.16.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:17:16 -0700 (PDT)
Date: Wed, 17 Sep 2025 02:17:14 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <20250916231714.7cg5zgpnxj6qmg3d@skbuf>
References: <20250913044404.63641-1-mmyangfl@gmail.com>
 <20250913044404.63641-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913044404.63641-4-mmyangfl@gmail.com>

On Sat, Sep 13, 2025 at 12:44:01PM +0800, David Yang wrote:
> +static int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
> +{
> +	WARN_ON(!mutex_is_locked(&priv->reg_lock));
> +
> +	return priv->reg_ops->read(priv->reg_ctx, reg, valp);
> +}
> +
> +static int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val)
> +{
> +	WARN_ON(!mutex_is_locked(&priv->reg_lock));
> +
> +	return priv->reg_ops->write(priv->reg_ctx, reg, val);
> +}
> +
> +static int
> +yt921x_reg_wait(struct yt921x_priv *priv, u32 reg, u32 mask, u32 *valp)
> +{
> +	u32 val;
> +	int res;
> +
> +	res = read_poll_timeout(yt921x_reg_read, res,
> +				res || (val & mask) == *valp,
> +				YT921X_POLL_SLEEP_US, YT921X_POLL_TIMEOUT_US,
> +				false, priv, reg, &val);
> +	if (res)
> +		return res;
> +
> +	*valp = val;
> +	return 0;
> +}
> +
> +static void yt921x_reg_mdio_verify(u32 reg, u16 val, bool lo)
> +{
> +	const char *desc;
> +
> +	switch (val) {
> +	case 0xfade:
> +		desc = "which is likely from a non-existent register";
> +		break;
> +	case 0xdead:
> +		desc = "which is likely a data race condition";
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	/* Skip registers which are likely to have any valid values */
> +	switch (reg) {
> +	case YT921X_MAC_ADDR_HI2:
> +	case YT921X_MAC_ADDR_LO4:
> +	case YT921X_FDB_OUT0:
> +	case YT921X_FDB_OUT1:
> +		return;
> +	}
> +
> +	pr_warn("%s: Read 0x%x at 0x%x %s32, %s; "
> +		"consider reporting a bug if this happens again\n",
> +		__func__, val, reg, lo ? "lo" : "hi", desc);
> +}

Do you believe that having this mdio_verify() function here will help
anyone? Per your previous response to Andrew, these seem some personal
deductions during debugging, with no clear reasoning as to why these
values would be indicative of these causes.
https://lore.kernel.org/netdev/CAAXyoMPLRHfSUGboC4SO+gBD0TdHq19fNs7AK3W2ZQnHT48gyA@mail.gmail.com/

What about YT921X_FDB_IN0? It shouldn't be so hard for 0xfade or 0xdead
to appear in the upper or lower 16 bits of this register.

Rather than trying to find more examples where searching for bogus
values leads to false positives, I'm trying to convince you to drop the
function :)

> +
> +static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
> +{
> +	struct yt921x_reg_mdio *mdio = context;
> +	struct mii_bus *bus = mdio->bus;
> +	int addr = mdio->addr;
> +	u32 reg_addr;
> +	u32 reg_data;
> +	u32 val;
> +	int res;
> +
> +	/* Hold the mdio bus lock to avoid (un)locking for 4 times */
> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);

Andrew, are you satisfied with this lock? Perhaps I missed some part of
the conversation, but didn't you say "leave the mdio lock alone"?
https://lore.kernel.org/netdev/e17b65d2-5c66-4d80-84c2-26f2bc639962@lunn.ch/

We also have priv->reg_lock here, not sure what is supposed to cover what.

Also, I didn't get the chance to intervene in this discussion:
https://lore.kernel.org/netdev/4ef60411-a3f8-4bb6-b1d9-ab61576f0baf@lunn.ch/

David, I hope you won't get lost in apparently conflicting feedback, so
I'll just try to lay out some basic facts and it's up to you to choose
something that is consistent and makes sense for this driver. Sorry for
the long text, but this submission seems confused in terms of locking.

Generally you need a lock when:
- you make an operation which alters the global state (like reset) in
  such a way that it would impact concurrent execution threads trying to
  do something.
  But: if reset isn't concurrent with anything else going on, locking is
  pointless.
- you operate on a set of registers that must be accessed in an atomic
  sequence (SMI read/write, indirect access to a table, multi-word access)
- you operate on the same register or larger resource from multiple places
- you traverse a list at the same time as adding or removing an element
AND
there is no higher level lock to reliably serialize the different
calling threads.

The last part is important, because most DSA and phylink methods are
called with rtnl_lock() held - a mutex which is not going away any time
soon. I think only port_fdb_add() and port_fdb_del() are called unlocked,
and need driver author analysis in terms of concurrency.

It should be said that many consider mutex_init() followed in quick
succession by mutex_lock(), with nothing in between that would result in
concurrency (spawn a new thread, request an IRQ, register an object to
make it visible to user API, etc), to be an anti-pattern.
If you're the only one who can acquire the lock, you don't need it.

For example: you acquire priv->reg_lock during ds->ops->setup(), when
there is no concurrency. You are encouraged to look through net/dsa/ and
follow the code paths and locks that are used (and sprinkle a few
ASSERT_RTNL() calls for instrumenting the various dsa_switch_ops methods).

Or another case, I would be surprised if the internal PHYs shared any state
with the port forwarding isolation registers. So in principle, I don't
see why yt921x_mbus_int_read() and yt921x_bridge_join() would serialize
on the priv->reg_lock.

You do lock the bus->mdio_lock for the MDIO reg_ops, and a lock at that
level (although not the MDIO bus lock) seems perfectly adequate and
justifiable. That should be sufficient.

I think Andrew, when recommending the mv88e6xxx approach, was suggesting
to _replace_ the reg_ops lock with the top-level priv->reg_lock. Not to
have both.

> +
> +	reg_addr = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_ADDR |
> +		   YT921X_SMI_READ;
> +	res = __mdiobus_write(bus, addr, reg_addr, (u16)(reg >> 16));
> +	if (res)
> +		goto end;
> +	res = __mdiobus_write(bus, addr, reg_addr, (u16)reg);
> +	if (res)
> +		goto end;
> +
> +	reg_data = YT921X_SMI_SWITCHID(mdio->switchid) | YT921X_SMI_DATA |
> +		   YT921X_SMI_READ;
> +	res = __mdiobus_read(bus, addr, reg_data);
> +	if (res < 0)
> +		goto end;
> +	yt921x_reg_mdio_verify(reg, res, false);
> +	val = (u16)res;
> +	res = __mdiobus_read(bus, addr, reg_data);
> +	if (res < 0)
> +		goto end;
> +	yt921x_reg_mdio_verify(reg, res, true);
> +	val = (val << 16) | (u16)res;
> +
> +	*valp = val;
> +	res = 0;
> +
> +end:
> +	mutex_unlock(&bus->mdio_lock);
> +	return res;
> +}
> +
> +/* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed at start.
> + *
> + * Do not hold yt921x_priv::reg_lock or yt921x_port::stats_lock.
> + */
> +static int yt921x_read_mib(struct yt921x_priv *priv, int port)
> +{
> +	struct yt921x_port *pp = &priv->ports[port];
> +	struct device *dev = to_device(priv);
> +	struct yt921x_mib buf;

312 bytes for a variable on the kernel stack seems a bit excessive,
especially from the yt921x_dsa_get_ethtool_stats() call path.
You might get -Wframe-larger-than warnings on certain architectures.

You can allocate a bounce buffer somewhere in the port or switch
structure.

> +	u64 rx_frames;
> +	u64 tx_frames;
> +	int res = 0;
> +
> +	/* Don't read registers while holding stats_lock.
> +	 *
> +	 * Also, read out old values first to avoid false positives on overflow
> +	 * detection.
> +	 */
> +	spin_lock(&pp->stats_lock);
> +	buf = pp->mib;
> +	spin_unlock(&pp->stats_lock);

What is the point of copying pp->mib here? Doesn't the loop below
overwrite each buf element?

> +
> +	mutex_lock(&priv->reg_lock);
> +	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> +		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
> +		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
> +		u64 *valp = &((u64 *)&buf)[i];
> +		u32 val;
> +
> +		res = yt921x_reg_read(priv, reg, &val);
> +		if (res)
> +			break;
> +
> +		if (desc->size <= 1) {
> +			if (val < (u32)*valp)
> +				/* overflow */
> +				*valp += (u64)U32_MAX + 1;
> +			*valp &= ~U32_MAX;
> +			*valp |= val;
> +		} else {
> +			u32 val1;
> +
> +			res = yt921x_reg_read(priv, reg + 4, &val1);
> +			if (res)
> +				break;
> +
> +			*valp = ((u64)val << 32) | val1;
> +		}
> +	}
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res) {
> +		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
> +			port, res);
> +		return res;
> +	}
> +
> +	rx_frames = buf.rx_64byte + buf.rx_65_127byte +
> +		    buf.rx_128_255byte + buf.rx_256_511byte +
> +		    buf.rx_512_1023byte + buf.rx_1024_1518byte + buf.rx_jumbo;
> +	tx_frames = buf.tx_64byte + buf.tx_65_127byte +
> +		    buf.tx_128_255byte + buf.tx_256_511byte +
> +		    buf.tx_512_1023byte + buf.tx_1024_1518byte + buf.tx_jumbo;
> +
> +	spin_lock(&pp->stats_lock);
> +	pp->mib = buf;
> +	pp->rx_frames = rx_frames;
> +	pp->tx_frames = tx_frames;
> +	spin_unlock(&pp->stats_lock);
> +
> +	return 0;
> +}
> +
> +static const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
> +	{ 0, 64 },
> +	{ 65, 127 },
> +	{ 128, 255 },
> +	{ 256, 511 },
> +	{ 512, 1023 },
> +	{ 1024, 1518 },
> +	{ 1519, YT921X_FRAME_SIZE_MAX },
> +	{}
> +};
> +
> +static void
> +yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
> +			  struct ethtool_rmon_stats *rmon_stats,
> +			  const struct ethtool_rmon_hist_range **ranges)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct yt921x_port *pp = &priv->ports[port];
> +	struct yt921x_mib *mib = &pp->mib;
> +
> +	*ranges = yt921x_rmon_ranges;
> +
> +	spin_lock(&pp->stats_lock);
> +
> +	rmon_stats->undersize_pkts = mib->rx_undersize_errors;
> +	rmon_stats->oversize_pkts = mib->rx_oversize_errors;
> +	rmon_stats->fragments = mib->rx_alignment_errors;
> +	/* rmon_stats->jabbers */
> +
> +	rmon_stats->hist[0] = mib->rx_64byte;
> +	rmon_stats->hist[1] = mib->rx_65_127byte;
> +	rmon_stats->hist[2] = mib->rx_128_255byte;
> +	rmon_stats->hist[3] = mib->rx_256_511byte;
> +	rmon_stats->hist[4] = mib->rx_512_1023byte;
> +	rmon_stats->hist[5] = mib->rx_1024_1518byte;
> +	rmon_stats->hist[6] = mib->rx_jumbo;
> +
> +	rmon_stats->hist_tx[0] = mib->tx_64byte;
> +	rmon_stats->hist_tx[1] = mib->tx_65_127byte;
> +	rmon_stats->hist_tx[2] = mib->tx_128_255byte;
> +	rmon_stats->hist_tx[3] = mib->tx_256_511byte;
> +	rmon_stats->hist_tx[4] = mib->tx_512_1023byte;
> +	rmon_stats->hist_tx[5] = mib->tx_1024_1518byte;
> +	rmon_stats->hist_tx[6] = mib->tx_jumbo;
> +
> +	spin_unlock(&pp->stats_lock);
> +}

The stats methods with non-atomic contexts can sleep, so you can give
them updated counters at the time of call rather than up to 3 seconds
old.

You can look at ocelot_port_stats_run() - and I'm sure a lot other
implementations too - for some ideas.

> +static bool yt921x_dsa_support_eee(struct dsa_switch *ds, int port)
> +{
> +	return true;
> +}

Replace with dsa_supports_eee().

> +static int
> +yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
> +{
> +	struct dsa_switch *ds = &priv->ds;
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	u16 pvid;
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	mask = YT921X_PORT_VLAN_CTRL_CVID_M;
> +	if (!vlan_filtering || !dp->bridge) {

dsa_port_bridge_dev_get()... everywhere

> +		ctrl = YT921X_PORT_VLAN_CTRL_CVID(YT921X_VID_UNWARE);
> +	} else {
> +		br_vlan_get_pvid(dp->bridge->dev, &pvid);
> +		ctrl = YT921X_PORT_VLAN_CTRL_CVID(pvid);
> +	}
> +	res = yt921x_reg_update_bits(priv, YT921X_PORTn_VLAN_CTRL(port),
> +				     mask, ctrl);
> +	if (res)
> +		return res;
> +
> +	mask = YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGED |
> +	       YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
> +	ctrl = 0;
> +	if (vlan_filtering) {
> +		/* Do not drop tagged frames here; let VLAN_IGR_FILTER do it */
> +		if (!pvid)

if (vlan_filtering && !pvid)

> +			ctrl |= YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
> +	}
> +	res = yt921x_reg_update_bits(priv, YT921X_PORTn_VLAN_CTRL1(port),
> +				     mask, ctrl);
> +	if (res)
> +		return res;
> +
> +	res = yt921x_reg_toggle_bits(priv, YT921X_VLAN_IGR_FILTER,
> +				     YT921X_VLAN_IGR_FILTER_PORTn(port),
> +				     vlan_filtering);
> +	if (res)
> +		return res;
> +
> +	/* Turn on / off VLAN awareness */
> +	mask = YT921X_PORT_IGR_TPIDn_CTAG_M;
> +	if (!vlan_filtering)
> +		ctrl = 0;
> +	else
> +		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
> +	res = yt921x_reg_update_bits(priv, YT921X_PORTn_IGR_TPID(port),
> +				     mask, ctrl);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static int
> +yt921x_pvid_set(struct yt921x_priv *priv, int port, u16 vid)
> +{
> +	struct dsa_switch *ds = &priv->ds;
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	bool vlan_filtering;
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	vlan_filtering = dsa_port_is_vlan_filtering(dp);
> +
> +	if (vlan_filtering) {
> +		mask = YT921X_PORT_VLAN_CTRL_CVID_M;

YT921X_PORT_VLAN_CTRL_CVID_M is modified from 4 code paths, can you
condense things a little bit (call the same function, with authoritative
logic, from all required places)?

> +		ctrl = YT921X_PORT_VLAN_CTRL_CVID(vid);
> +		res = yt921x_reg_update_bits(priv, YT921X_PORTn_VLAN_CTRL(port),
> +					     mask, ctrl);
> +		if (res)
> +			return res;
> +	}
> +
> +	mask = YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
> +	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_VLAN_CTRL1(port), mask);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static int
> +yt921x_dsa_port_vlan_filtering(struct dsa_switch *ds, int port,
> +			       bool vlan_filtering,
> +			       struct netlink_ext_ack *extack)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	int res;
> +
> +	if ((priv->cpu_ports_mask & BIT(port)) != 0)
> +		return 0;

port_vlan_filtering() only gets called for user ports.

> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_vlan_filtering(priv, port, vlan_filtering);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}
> +
> +static int
> +yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
> +			 const struct switchdev_obj_port_vlan *vlan,
> +			 struct netlink_ext_ack *extack)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	u16 vid = vlan->vid;
> +	u16 pvid;
> +	int res;
> +
> +	if ((priv->cpu_ports_mask & BIT(port)) != 0)
> +		return 0;

The CPU port is VLAN-unaware by default and the driver leaves it that
way, correct?

> +
> +	mutex_lock(&priv->reg_lock);
> +	do {
> +		struct dsa_port *dp = dsa_to_port(ds, port);
> +
> +		res = yt921x_vlan_add(priv, port, vid,
> +				      (vlan->flags &
> +				       BRIDGE_VLAN_INFO_UNTAGGED) != 0);
> +		if (res)
> +			break;
> +
> +		if (dp->bridge) {
> +			if ((vlan->flags & BRIDGE_VLAN_INFO_PVID) != 0) {
> +				res = yt921x_pvid_set(priv, port, vid);
> +			} else {
> +				br_vlan_get_pvid(dp->bridge->dev, &pvid);
> +				if (pvid == vid)
> +					res = yt921x_pvid_clear(priv, port);
> +			}
> +		}
> +	} while (0);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}
> +
> +static int yt921x_userport_bridge(struct yt921x_priv *priv, int port)
> +{
> +	u32 mask;
> +	int res;
> +
> +	mask = YT921X_PORT_LEARN_DIS;
> +	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_LEARN(port), mask);
> +	if (res)
> +		return res;
> +
> +	res = yt921x_fdb_flush_port(priv, port, true);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}

See what the following code paths do:

dsa_port_bridge_join()
-> dsa_port_switchdev_sync_attrs()

dsa_port_bridge_leave()
-> dsa_port_switchdev_unsync_attrs()
   -> dsa_port_clear_brport_flags()
   -> dsa_port_set_state_now(BR_STATE_FORWARDING)
   -> dsa_port_reset_vlan_filtering()

del_nbp()
-> br_stp_disable_port()
   -> br_set_state(BR_STATE_DISABLED)
      -> ...
         -> dsa_user_port_attr_set(SWITCHDEV_ATTR_ID_PORT_STP_STATE)
            -> dsa_port_fast_age()

to get an impression of the operations you are doing twice on bridge
join/leave. You only need to manage the initial port state, then DSA
should move you from one operating mode to another.

> +static int yt921x_chip_setup(struct yt921x_priv *priv)
> +{
> +	struct dsa_switch *ds = &priv->ds;
> +	unsigned long cpu_ports_mask;
> +	u64 ctrl64;
> +	u32 ctrl;
> +	int port;
> +	int res;
> +
> +	/* Enable DSA */
> +	priv->cpu_ports_mask = dsa_cpu_ports(ds);
> +
> +	ctrl = YT921X_EXT_CPU_PORT_TAG_EN | YT921X_EXT_CPU_PORT_PORT_EN |
> +	       YT921X_EXT_CPU_PORT_PORT(__ffs(priv->cpu_ports_mask));
> +	res = yt921x_reg_write(priv, YT921X_EXT_CPU_PORT, ctrl);
> +	if (res)
> +		return res;
> +
> +	/* Enable and clear MIB */
> +	res = yt921x_reg_set_bits(priv, YT921X_FUNC, YT921X_FUNC_MIB);
> +	if (res)
> +		return res;
> +
> +	ctrl = YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
> +	res = yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);
> +	if (res)
> +		return res;
> +
> +	/* Setup software switch */
> +	ctrl = YT921X_CPU_COPY_TO_EXT_CPU;
> +	res = yt921x_reg_write(priv, YT921X_CPU_COPY, ctrl);
> +	if (res)
> +		return res;
> +
> +	ctrl = GENMASK(10, 0);
> +	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
> +	if (res)
> +		return res;
> +	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_MCAST, ctrl);
> +	if (res)
> +		return res;
> +
> +	/* YT921x does not support native DSA port bridging, so we use port
> +	 * isolation to emulate it. However, be especially careful that port
> +	 * isolation takes _after_ FDB lookups, i.e. if an FDB entry (from
> +	 * another bridge) is matched and the destination port (in another
> +	 * bridge) is blocked, the packet will be dropped instead of flooding to
> +	 * the "bridged" ports, thus we need to handle those packets by
> +	 * software.
> +	 *
> +	 * If there is no more than one bridge, we might be able to drop them
> +	 * directly given some conditions are met, but for now we trap them in
> +	 * all cases.
> +	 */
> +	ctrl = 0;
> +	for (int i = 0; i < YT921X_PORT_NUM; i++)
> +		ctrl |= YT921X_ACT_UNK_ACTn_TRAP(i);

YT921X_ACT_UNK_ACTn_TRAP traps packets with FDB misses to the CPU, correct?
How does that address the described problem, where an FDB entry is
found, but the destination port is isolated from the source?

> +	/* Except for CPU ports, if any packets are sent via CPU ports without
> +	 * tag, they should be dropped.
> +	 */
> +	cpu_ports_mask = priv->cpu_ports_mask;
> +	for_each_set_bit(port, &cpu_ports_mask, YT921X_PORT_NUM) {
> +		ctrl &= ~YT921X_ACT_UNK_ACTn_M(port);
> +		ctrl |= YT921X_ACT_UNK_ACTn_DROP(port);
> +	}
> +	res = yt921x_reg_write(priv, YT921X_ACT_UNK_UCAST, ctrl);
> +	if (res)
> +		return res;
> +	res = yt921x_reg_write(priv, YT921X_ACT_UNK_MCAST, ctrl);
> +	if (res)
> +		return res;
> +
> +	/* Tagged VID 0 should be treated as untagged, which confuses the
> +	 * hardware a lot
> +	 */
> +	ctrl64 = YT921X_VLAN_CTRL_LEARN_DIS | YT921X_VLAN_CTRL_PORTS_M;
> +	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrl64);
> +	if (res)
> +		return res;
> +
> +	/* Miscellaneous */
> +	res = yt921x_reg_set_bits(priv, YT921X_SENSOR, YT921X_SENSOR_TEMP);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static int yt921x_dsa_setup(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
> +	struct device_node *np = dev->of_node;
> +	struct device_node *child;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_chip_reset(priv);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res)
> +		return res;
> +
> +	/* Register the internal mdio bus. Nodes for internal ports should have
> +	 * proper phy-handle pointing to their PHYs. Not enabling the internal
> +	 * bus is possible, though pretty wired, if internal ports are not used.
> +	 */
> +	child = of_get_child_by_name(np, "mdio");
> +	if (!child) {
> +		priv->mbus_int = NULL;

You probably don't need this branch, priv is allocated with
devm_kzalloc() and thus, priv->mbus_int is NULL without any effort.

> +	} else {
> +		res = yt921x_mbus_int_init(priv, child);
> +		of_node_put(child);
> +		if (res)
> +			return res;
> +	}
> +
> +	/* External mdio bus is optional */
> +	child = of_get_child_by_name(np, "mdio-external");
> +	if (!child) {
> +		priv->mbus_ext = NULL;

Same.

> +	} else {
> +		res = yt921x_mbus_ext_init(priv, child);
> +		of_node_put(child);
> +		if (res)
> +			return res;
> +
> +		dev_err(dev, "Untested external mdio bus\n");
> +		return -ENODEV;
> +	}
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_chip_setup(priv);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static void yt921x_mdio_remove(struct mdio_device *mdiodev)
> +{
> +	struct yt921x_priv *priv = mdiodev_get_drvdata(mdiodev);
> +
> +	if (!priv)
> +		return;
> +
> +	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
> +		struct yt921x_port *pp = &priv->ports[i];
> +
> +		cancel_delayed_work_sync(&pp->mib_read);
> +	}
> +
> +	mutex_destroy(&priv->reg_lock);

This seems destroyed way too early, dsa_unregister_switch() triggers a
bunch of driver methods, so you need to destroy it after it finishes.

> +
> +	dsa_unregister_switch(&priv->ds);
> +}

