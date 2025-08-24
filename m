Return-Path: <netdev+bounces-216314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF90B3314B
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 17:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F73440F00
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210372D660E;
	Sun, 24 Aug 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dFyRrMdh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151526AABE;
	Sun, 24 Aug 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756050707; cv=none; b=ivfkVWdSp/QR5+bfJLKP3E83uXASdN+1TZO0ZaPkoFH2e8nnrC2KD81iCznMSM1EKB0Iqo0EdMHQXBRN/HkkHTPFzZ2oIew99g3f63oi3wA2kAJ9MqQCIuymJY8RzSMAuAUykTC/8dLnmVGLzW5LNJk1vZ1ykyja5tySk9Y55mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756050707; c=relaxed/simple;
	bh=C0jpTVDrWDYIll7AWohPMa3s7doEJc5uOrojSmRqOpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3FpcYkiw24pl8EYiD3WQ/UUZWtaorcDHFK4lajVbZaecirRp0ERAzLE8SrvmIN/VlgwpBcpx5M2ErdulpZG1w1DsWBSvgXzoJVE/1IbH+fACjZEPhu6mPtXbAX/WsllrkO4qqUalMvDSnTVifcWNl+Ku+RKpSe6gWrbrOfrEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dFyRrMdh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CwqiQcB4xrvcvWNtg6LHRtzZ6d8tG73a+/pJL8A4ZFQ=; b=dFyRrMdhPkkZ4/WTH4BMk+ibml
	nEogUHkctkxbr+aIr6tZ0kuiILZRx4qExfRqhd4ixb1gkha95dokG38/uIdv9RU/icX+JxHRal+02
	HWGCwNTv7TfHmMeMTKp4+4X6VmUOCjpeZ6YVfQ25JH3ALYaQqyBu6TDYVneA1cw3Xyl4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqD0L-005qIz-1h; Sun, 24 Aug 2025 17:51:37 +0200
Date: Sun, 24 Aug 2025 17:51:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <ad61c240-eee3-4db4-b03e-de07f3efba12@lunn.ch>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824005116.2434998-4-mmyangfl@gmail.com>

> +static int
> +yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
> +{
> +	struct device *dev = to_device(priv);
> +	u32 mask;
> +	u32 ctrl;
> +	u32 val;
> +	int res;
> +
> +	res = yt921x_intif_wait(priv);
> +	if (res)
> +		return res;
> +
> +	mask = YT921X_MBUS_CTRL_PORT_M | YT921X_MBUS_CTRL_REG_M |
> +	       YT921X_MBUS_CTRL_OP_M;
> +	ctrl = YT921X_MBUS_CTRL_PORT(port) | YT921X_MBUS_CTRL_REG(reg) |
> +	       YT921X_MBUS_CTRL_READ;
> +	res = yt921x_smi_update_bits(priv, YT921X_INT_MBUS_CTRL, mask, ctrl);
> +	if (res)
> +		return res;
> +	res = yt921x_smi_write(priv, YT921X_INT_MBUS_OP, YT921X_MBUS_OP_START);
> +	if (res)
> +		return res;
> +
> +	res = yt921x_intif_wait(priv);
> +	if (res)
> +		return res;
> +	res = yt921x_smi_read(priv, YT921X_INT_MBUS_DIN, &val);
> +	if (res)
> +		return res;
> +
> +	if ((u16)val != val)
> +		dev_err(dev,
> +			"%s: port %d, reg 0x%x: Expected u16, got 0x%08x\n",
> +			__func__, port, reg, val);
> +	*valp = (u16)val;
> +	return 0;
> +}

...

> +static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
> +{
> +	struct yt921x_priv *priv = mbus->priv;
> +	u16 val;
> +	int res;
> +
> +	if (port >= YT921X_PORT_NUM)
> +		return 0xffff;
> +
> +	yt921x_smi_acquire(priv);
> +	res = yt921x_intif_read(priv, port, reg, &val);
> +	yt921x_smi_release(priv);
> +
> +	if (res)
> +		return res;
> +	return val;
> +}
> +
> +static int
> +yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
> +{
> +	struct yt921x_priv *priv = mbus->priv;
> +	int res;
> +
> +	if (port >= YT921X_PORT_NUM)
> +		return 0;
> +
> +	yt921x_smi_acquire(priv);
> +	res = yt921x_intif_write(priv, port, reg, data);
> +	yt921x_smi_release(priv);
> +
> +	return res;
> +}

Going back to comment from Russell in an older version:

> > I'm also concerned about the SMI locking, which looks to me like you
> > haven't realised that the MDIO bus layer has locking which guarantees
> > that all invocations of the MDIO bus read* and write* methods are
> > serialised.
> 
> The device takes two sequential u16 MDIO r/w into one op on its
> internal 32b regs, so we need to serialise SMI ops to avoid race
> conditions. Strictly speaking only locking the target phyaddr is
> needed, but I think it won't hurt to lock the MDIO bus as long as I
> don't perform busy wait while holding the bus lock.

You comment is partially correct, but also wrong. As you can see here,
you hold the lock for a number of read/writes, not just one u32 write
split into two MDIO bus transactions.

They way you currently do locking is error prone.

1) Are you sure you actually hold the lock on all paths?

2) Are you sure you hold the lock long enough for all code which
   requires multiple reads/writes?

The mv88e6xxx driver does things differently:

Every function assigned to struct dsa_switch_ops first takes the lock,
does what needs doing, and then releases the lock just before the
return.

The lowest level read/write function does a mutex_is_locked() to test
that the lock is held. If it is not, it prints an error message.

The first part makes it easy to see the lock is held, and it makes it
clear all operations the driver is doing is covered by the lock, there
is no need worry about two threads racing.

The second part makes bugs about missing locks obvious, an error
message is printed.

Please reconsider your locking. Also, please think about, do you need
a different lock for MDIO, I2C and SPI? Do you need the current
acquire/release abstract?

	Andrew

