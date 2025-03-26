Return-Path: <netdev+bounces-177736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B0A717D5
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A8C172687
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E991EEA29;
	Wed, 26 Mar 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l52CYGqi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0D189919;
	Wed, 26 Mar 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997237; cv=none; b=hO9A0ujndsZxzdyc7vz72UBT71R9NlDkhhLvgJq9CbbE88Z7XEJGQ9T6nDJKSiOpbmB9u9bp7TC6U3w/T6YcnkSHRhu8fTegDpxtuvbsh839e9m2til6cZDStciDFBEORHg0tY9SfQGG3qAQq/x33wRWcd6X+baKi/b2Ck0RhVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997237; c=relaxed/simple;
	bh=Qbao9YeXZxdgK01PyrVgIBjBv1VDrobFPWDfuEd9Egs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXqYkBB7OTyir/aypt5SRMR63nLLLc2oxhGRVdGQvMaW2MeLidee0J+1lNw7g8vhRu+5AYRFzptzOA+UkxPdQRSDJG+Sq/i6kYqN3MrmApGf5g2pftGq/mvYB0+HsWH2EGf1O87auXXRxJwSV+4tspoIjFErhYZCtD8Fg52VC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l52CYGqi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2kEtzjhjCfVdaJ2ri8dRDBHYx8JUUX5N2JgqZFWwsKA=; b=l52CYGqiaLnwsvnNWnn02MQg3r
	AifLm520J6XGDam490Bwmtir7Sd4YUtpGU/+U9BJONo+8oz5H83ykXcndZLdA89gtRbDSjq3vl+y3
	vi8+uPgI57q4+QEZGRm15REnq/lE37vNY2FfergrBIo5rm/83dmqeMhEAighVosn4WDvPyZPlH9aV
	abpwjvsVxWU79fDSjZgvyJC6RilQXTea5QWvTXQ2pginnrsCIGaAs4oZw56KaQj5VzZvH/EySe6Y1
	3B9geYI5Uf0MDAogssbdqJMzeH1XmwW5p8xphabFLxJXdL1I0seZz/yZw2dGA+fRAHz1TpOt6VvuQ
	GMldUXMg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39450)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1txRCR-00066l-24;
	Wed, 26 Mar 2025 13:53:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1txRCO-0004QQ-0W;
	Wed, 26 Mar 2025 13:53:40 +0000
Date: Wed, 26 Mar 2025 13:53:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 2/3] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <Z-QG4w425UuYXZOX@shell.armlinux.org.uk>
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326002404.25530-3-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 26, 2025 at 01:23:58AM +0100, Christian Marangi wrote:
> +static int aeon_ipc_send_cmd(struct phy_device *phydev, u32 cmd,
> +			     u16 *ret_sts)
> +{
> +	struct as21xxx_priv *priv = phydev->priv;
> +	bool curr_parity;
> +	int ret;
> +
> +	/* The IPC sync by using a single parity bit.
> +	 * Each CMD have alternately this bit set or clear
> +	 * to understand correct flow and packet order.
> +	 */
> +	curr_parity = priv->parity_status;
> +	if (priv->parity_status)
> +		cmd |= AEON_IPC_CMD_PARITY;
> +
> +	/* Always update parity for next packet */
> +	priv->parity_status = !priv->parity_status;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_CMD, cmd);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for packet to be processed */
> +	usleep_range(AEON_IPC_DELAY, AEON_IPC_DELAY + 5000);
> +
> +	/* With no ret_sts, ignore waiting for packet completion
> +	 * (ipc parity bit sync)
> +	 */
> +	if (!ret_sts)
> +		return 0;
> +
> +	ret = aeon_ipcs_wait_cmd(phydev, curr_parity);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS);
> +	if (ret < 0)
> +		return ret;
> +
> +	*ret_sts = ret;
> +	if ((*ret_sts & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_SUCCESS)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int aeon_ipc_send_msg(struct phy_device *phydev, u16 opcode,
> +			     u16 *data, unsigned int data_len, u16 *ret_sts)
> +{
> +	struct as21xxx_priv *priv = phydev->priv;
> +	u32 cmd;
> +	int ret;
> +	int i;
> +
> +	/* IPC have a max of 8 register to transfer data,
> +	 * make sure we never exceed this.
> +	 */
> +	if (data_len > AEON_IPC_DATA_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->ipc_lock);
> +
> +	for (i = 0; i < data_len / sizeof(u16); i++)
> +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i),
> +			      data[i]);
> +
> +	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, data_len) |
> +	      FIELD_PREP(AEON_IPC_CMD_OPCODE, opcode);
> +	ret = aeon_ipc_send_cmd(phydev, cmd, ret_sts);
> +	if (ret)
> +		phydev_err(phydev, "failed to send ipc msg for %x: %d\n", opcode, ret);
> +
> +	mutex_unlock(&priv->ipc_lock);
> +
> +	return ret;
> +}
> +
> +static int aeon_ipc_rcv_msg(struct phy_device *phydev, u16 ret_sts,
> +			    u16 *data)
> +{
> +	unsigned int size = FIELD_GET(AEON_IPC_STS_SIZE, ret_sts);
> +	struct as21xxx_priv *priv = phydev->priv;
> +	int ret;
> +	int i;
> +
> +	if ((ret_sts & AEON_IPC_STS_STATUS) == AEON_IPC_STS_STATUS_ERROR)
> +		return -EINVAL;
> +
> +	/* Prevent IPC from stack smashing the kernel */
> +	if (size > AEON_IPC_DATA_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->ipc_lock);
> +
> +	for (i = 0; i < DIV_ROUND_UP(size, sizeof(u16)); i++) {
> +		ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i));
> +		if (ret < 0) {
> +			size = ret;
> +			goto out;
> +		}
> +
> +		data[i] = ret;
> +	}
> +
> +out:
> +	mutex_unlock(&priv->ipc_lock);
> +
> +	return size;
> +}
> +
> +/* Logic to sync parity bit with IPC.
> + * We send 2 NOP cmd with same partity and we wait for IPC
> + * to handle the packet only for the second one. This way
> + * we make sure we are sync for every next cmd.
> + */
> +static int aeon_ipc_sync_parity(struct phy_device *phydev)
> +{
> +	struct as21xxx_priv *priv = phydev->priv;
> +	u16 ret_sts;
> +	u32 cmd;
> +	int ret;
> +
> +	mutex_lock(&priv->ipc_lock);
> +
> +	/* Send NOP with no parity */
> +	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, 0) |
> +	      FIELD_PREP(AEON_IPC_CMD_OPCODE, IPC_CMD_NOOP);
> +	aeon_ipc_send_cmd(phydev, cmd, NULL);
> +
> +	/* Reset packet parity */
> +	priv->parity_status = false;
> +
> +	/* Send second NOP with no parity */
> +	ret = aeon_ipc_send_cmd(phydev, cmd, &ret_sts);
> +
> +	mutex_unlock(&priv->ipc_lock);
> +
> +	/* We expect to return -EFAULT */
> +	if (ret != -EFAULT)
> +		return ret;
> +
> +	if ((ret_sts & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_READY)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int aeon_ipc_get_fw_version(struct phy_device *phydev)
> +{
> +	u16 ret_data[8], data[1];
> +	u16 ret_sts;
> +	int ret;
> +
> +	data[0] = IPC_INFO_VERSION;
> +	ret = aeon_ipc_send_msg(phydev, IPC_CMD_INFO, data, sizeof(data),
> +				&ret_sts);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_ipc_rcv_msg(phydev, ret_sts, ret_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	phydev_info(phydev, "Firmware Version: %s\n", (char *)ret_data);
> +
> +	return 0;
> +}
> +
> +static int aeon_dpc_ra_enable(struct phy_device *phydev)
> +{
> +	u16 data[2];
> +	u16 ret_sts;
> +
> +	data[0] = IPC_CFG_PARAM_DIRECT;
> +	data[1] = IPC_CFG_PARAM_DIRECT_DPC_RA;
> +
> +	return aeon_ipc_send_msg(phydev, IPC_CMD_CFG_PARAM, data,
> +				 sizeof(data), &ret_sts);
> +}
> +
> +static int as21xxx_probe(struct phy_device *phydev)
> +{
> +	struct as21xxx_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&phydev->mdio.dev,
> +			    sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	phydev->priv = priv;
> +
> +	ret = devm_mutex_init(&phydev->mdio.dev,
> +			      &priv->ipc_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_firmware_load(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_ipc_sync_parity(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
> +			       VEND1_PTP_CLK_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_dpc_ra_enable(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = aeon_ipc_get_fw_version(phydev);
> +	if (ret)
> +		return ret;
> +
> +	phydev->needs_reregister = true;
> +
> +	return 0;
> +}

This probe function allocates devres resources that wil lbe freed when
it returns through the unbinding in patch 1. This is a recipe for
confusion - struct as21xxx_priv must never be used from any of the
"real" driver.

I would suggest:

1. document that devres resources will not be preserved when
   phydev->needs_reregister is set true.

2. rename struct as21xxx_priv to struct as21xxx_fw_load_priv to make
   it clear that it's for firmware loading.

3. use a prefix that uniquely identifies those functions that can only
   be called with this structure populated.

4. set phydev->priv to NULL at the end of this probe function to ensure
   no one dereferences the free'd pointer in a "real" driver, which
   could lead to use-after-free errors.

In summary, I really don't like this approach - it feels too much of a
hack, _and_ introduces the potential for drivers that makes use of this
to get stuff really very wrong. In my opinion that's not a model that
we should add to the kernel.

I'll say again - why can't the PHY firmware be loaded by board firmware.
You've been silent on my feedback on this point. Given that you're
ignoring me... for this patch series...

Hard NAK.

until you start responding to my review comments.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

