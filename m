Return-Path: <netdev+bounces-177751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD7A71958
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EEED188816B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433A1F3BB4;
	Wed, 26 Mar 2025 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8bo8WTs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F3E1C8638;
	Wed, 26 Mar 2025 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000234; cv=none; b=llY5esKZFNBIQMZQkJ00eFVH8HqkzWrqqlymGEbejlNazEIPM6/nBZCBVt9TiW3mJcItQZ+Bu6CI9CWJL8Lf5eyOxTVwOK3H6wpms6FsW3bFe59Evxmohycg6povo9q9qFGydfxHePOxZtGfE4M/YFTqbC1QIpskcAa3euzGIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000234; c=relaxed/simple;
	bh=zmNAXLfX6vVFsk7XoTaqoPPNY5mUL6YQzWOpahaYtoY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/ql2aNvzZZzTZlPLr1GYyamTEk5/XG+NJichM8VTuzmf5tLi4if3zeAerRowhI+UdaZNHYSri2XMRSBV8ZiXg+74BMkcDWSyUIa8+QfJRaoBnCSTalIVugxAcTQ8L97mp3hUNMwfnCvgP1Nzpc1frMsP3k3rdgYzUp/15NgrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8bo8WTs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso74057055e9.3;
        Wed, 26 Mar 2025 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743000230; x=1743605030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=USItuzRjyecBcYCWayksYYu+SxE+tLbi7zXzaoAOh/w=;
        b=Z8bo8WTsEub33HOgE9xIKdKqFfoz8BTrNBZ1gdWT2l0m2ZEFw2kzHLLj6cN4Chcwl5
         opF1SNJywjUI7BK7LXK0iDadv098s3hUK9AGGxGzKfj0FCFXG+NrIt69kNQRDII9GkCe
         ShhFO4wa41twryBp9/xpSX3i061fzdjtoiu408NLGBwk8wV20kNYzU+5aY+1tu1hgFik
         6oCrS8fvbF7RhZedxtl3w+mfg4A1HSpYhAZBRUgNTb+cQif3y7+0awpHEAks552FBzYB
         F7d/jMMlza2iiQAr3qEZI/Ga18Awnnc5MIkvzYd3UcCflLGQyNNRGFRWZFeQ+J/3TaMi
         MhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743000230; x=1743605030;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USItuzRjyecBcYCWayksYYu+SxE+tLbi7zXzaoAOh/w=;
        b=RCetNnNGL0awDcOq/Imc0XW5jqcLznPQgENhCJ0VyYS/RO6gZBTPfpV9Kv75NYw+Mi
         oVlSMaDw9hWAVugpehKf81BSwwEHMKXnA621H8Zhsi9NkH8YAcYQeU0OAxgycLkQXhND
         RlhOCha/j1HKlZJTr60ZvjNIfrNhYDmmkGnjjkmQUwi+Cu0/SIDVI4C5pzGfKHXHY+mC
         z+b1NK8NzQJVTBsm94DySl11TC9/VyJHl7LtjRXW3He1E4myeY612h6FZskbLChwSeOg
         ICwCUEqFyN3+nvgtNdSgGDArEqmciQo7prgkE99BKlB+DB1fjxpypN/XaSyMug4Jfubn
         MThA==
X-Forwarded-Encrypted: i=1; AJvYcCV7ZldHr2oEf5Bt6Dk+azC3Cm5pR7UphOmET4IGJ1ScUv+mUWuH7wlPdjlDry131vjjbc5JD6hjiKJD@vger.kernel.org, AJvYcCWWluzUl2dcFS/VgngTtnUbg6eDzjKGNXk2rldyJuDvgp+d4Jhw9KgrX9YU1G+pmf/2LMqOkCn3@vger.kernel.org, AJvYcCWb8rqBnFoOMesNwrcmVLyLDGLgBdSHErJdovbbMZJ1j3u0Wzot1TS0/+gVXfA3i5g/SlXWQ0RtAWuVk7wV@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBAFIkKNxW4y5+uFmLJuSwv3b9lZqKKIX9Mht5EFiDSvGNDre
	yK7JoexWOUhjcoPuEjpyLnwtk7XTCncyHGWsSaeh+r3TqdJznuXP
X-Gm-Gg: ASbGncsMAVgrBNlzBCd4Yars+yrLgQezsscPm/TIztfaxhYjxqOjM9zKX39pAGUQ93F
	pVHwH4Z3iDlSonXf3Ts7Lyw/AWgBEq8LZ6enuQEjyb56B8pevGWZ7wiaa1H4pu6w/m9CjEiWhxF
	WRZi0kMqcHOByY9LhiFrh/awdxVmEmGwmTdKjOXolEDAVUj53Q2x/MND3iwEbI3xGet1zl0WQAg
	Moj3XUqU03jkFJKBNLPnwZ8dsn8oh5l2xgN5eWv+DgTd6mLmMIwvhkUxO6g6geDeaxk1RHNdVph
	hw3v6VtHqP0uzUAYPAQuoGm3fxPqlYc8CeMEK8an3coB6V0wpF25tdkpo/wfMhQJhfmIqmsMeTh
	D
X-Google-Smtp-Source: AGHT+IGgQjiWwnslMbixM5W6CdmGHIHnGkcbMW6OXVIG50+MsdgfOlxgH8XfA0a7K/5sg5QteBR6BA==
X-Received: by 2002:a05:600c:b8d:b0:43b:ce08:c382 with SMTP id 5b1f17b1804b1-43d509f6797mr218781205e9.16.1743000229859;
        Wed, 26 Mar 2025 07:43:49 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e65casm17264289f8f.69.2025.03.26.07.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:43:49 -0700 (PDT)
Message-ID: <67e412a5.5d0a0220.28146a.e91b@mx.google.com>
X-Google-Original-Message-ID: <Z-QSo-xfudg0LPCE@Ansuel-XPS.>
Date: Wed, 26 Mar 2025 15:43:47 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-3-ansuelsmth@gmail.com>
 <Z-QG4w425UuYXZOX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-QG4w425UuYXZOX@shell.armlinux.org.uk>

On Wed, Mar 26, 2025 at 01:53:39PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 26, 2025 at 01:23:58AM +0100, Christian Marangi wrote:
> > +static int aeon_ipc_send_cmd(struct phy_device *phydev, u32 cmd,
> > +			     u16 *ret_sts)
> > +{
> > +	struct as21xxx_priv *priv = phydev->priv;
> > +	bool curr_parity;
> > +	int ret;
> > +
> > +	/* The IPC sync by using a single parity bit.
> > +	 * Each CMD have alternately this bit set or clear
> > +	 * to understand correct flow and packet order.
> > +	 */
> > +	curr_parity = priv->parity_status;
> > +	if (priv->parity_status)
> > +		cmd |= AEON_IPC_CMD_PARITY;
> > +
> > +	/* Always update parity for next packet */
> > +	priv->parity_status = !priv->parity_status;
> > +
> > +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_CMD, cmd);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Wait for packet to be processed */
> > +	usleep_range(AEON_IPC_DELAY, AEON_IPC_DELAY + 5000);
> > +
> > +	/* With no ret_sts, ignore waiting for packet completion
> > +	 * (ipc parity bit sync)
> > +	 */
> > +	if (!ret_sts)
> > +		return 0;
> > +
> > +	ret = aeon_ipcs_wait_cmd(phydev, curr_parity);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_STS);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*ret_sts = ret;
> > +	if ((*ret_sts & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_SUCCESS)
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int aeon_ipc_send_msg(struct phy_device *phydev, u16 opcode,
> > +			     u16 *data, unsigned int data_len, u16 *ret_sts)
> > +{
> > +	struct as21xxx_priv *priv = phydev->priv;
> > +	u32 cmd;
> > +	int ret;
> > +	int i;
> > +
> > +	/* IPC have a max of 8 register to transfer data,
> > +	 * make sure we never exceed this.
> > +	 */
> > +	if (data_len > AEON_IPC_DATA_MAX)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&priv->ipc_lock);
> > +
> > +	for (i = 0; i < data_len / sizeof(u16); i++)
> > +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i),
> > +			      data[i]);
> > +
> > +	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, data_len) |
> > +	      FIELD_PREP(AEON_IPC_CMD_OPCODE, opcode);
> > +	ret = aeon_ipc_send_cmd(phydev, cmd, ret_sts);
> > +	if (ret)
> > +		phydev_err(phydev, "failed to send ipc msg for %x: %d\n", opcode, ret);
> > +
> > +	mutex_unlock(&priv->ipc_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int aeon_ipc_rcv_msg(struct phy_device *phydev, u16 ret_sts,
> > +			    u16 *data)
> > +{
> > +	unsigned int size = FIELD_GET(AEON_IPC_STS_SIZE, ret_sts);
> > +	struct as21xxx_priv *priv = phydev->priv;
> > +	int ret;
> > +	int i;
> > +
> > +	if ((ret_sts & AEON_IPC_STS_STATUS) == AEON_IPC_STS_STATUS_ERROR)
> > +		return -EINVAL;
> > +
> > +	/* Prevent IPC from stack smashing the kernel */
> > +	if (size > AEON_IPC_DATA_MAX)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&priv->ipc_lock);
> > +
> > +	for (i = 0; i < DIV_ROUND_UP(size, sizeof(u16)); i++) {
> > +		ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_IPC_DATA(i));
> > +		if (ret < 0) {
> > +			size = ret;
> > +			goto out;
> > +		}
> > +
> > +		data[i] = ret;
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&priv->ipc_lock);
> > +
> > +	return size;
> > +}
> > +
> > +/* Logic to sync parity bit with IPC.
> > + * We send 2 NOP cmd with same partity and we wait for IPC
> > + * to handle the packet only for the second one. This way
> > + * we make sure we are sync for every next cmd.
> > + */
> > +static int aeon_ipc_sync_parity(struct phy_device *phydev)
> > +{
> > +	struct as21xxx_priv *priv = phydev->priv;
> > +	u16 ret_sts;
> > +	u32 cmd;
> > +	int ret;
> > +
> > +	mutex_lock(&priv->ipc_lock);
> > +
> > +	/* Send NOP with no parity */
> > +	cmd = FIELD_PREP(AEON_IPC_CMD_SIZE, 0) |
> > +	      FIELD_PREP(AEON_IPC_CMD_OPCODE, IPC_CMD_NOOP);
> > +	aeon_ipc_send_cmd(phydev, cmd, NULL);
> > +
> > +	/* Reset packet parity */
> > +	priv->parity_status = false;
> > +
> > +	/* Send second NOP with no parity */
> > +	ret = aeon_ipc_send_cmd(phydev, cmd, &ret_sts);
> > +
> > +	mutex_unlock(&priv->ipc_lock);
> > +
> > +	/* We expect to return -EFAULT */
> > +	if (ret != -EFAULT)
> > +		return ret;
> > +
> > +	if ((ret_sts & AEON_IPC_STS_STATUS) != AEON_IPC_STS_STATUS_READY)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int aeon_ipc_get_fw_version(struct phy_device *phydev)
> > +{
> > +	u16 ret_data[8], data[1];
> > +	u16 ret_sts;
> > +	int ret;
> > +
> > +	data[0] = IPC_INFO_VERSION;
> > +	ret = aeon_ipc_send_msg(phydev, IPC_CMD_INFO, data, sizeof(data),
> > +				&ret_sts);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = aeon_ipc_rcv_msg(phydev, ret_sts, ret_data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	phydev_info(phydev, "Firmware Version: %s\n", (char *)ret_data);
> > +
> > +	return 0;
> > +}
> > +
> > +static int aeon_dpc_ra_enable(struct phy_device *phydev)
> > +{
> > +	u16 data[2];
> > +	u16 ret_sts;
> > +
> > +	data[0] = IPC_CFG_PARAM_DIRECT;
> > +	data[1] = IPC_CFG_PARAM_DIRECT_DPC_RA;
> > +
> > +	return aeon_ipc_send_msg(phydev, IPC_CMD_CFG_PARAM, data,
> > +				 sizeof(data), &ret_sts);
> > +}
> > +
> > +static int as21xxx_probe(struct phy_device *phydev)
> > +{
> > +	struct as21xxx_priv *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(&phydev->mdio.dev,
> > +			    sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +	phydev->priv = priv;
> > +
> > +	ret = devm_mutex_init(&phydev->mdio.dev,
> > +			      &priv->ipc_lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = aeon_firmware_load(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = aeon_ipc_sync_parity(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
> > +			       VEND1_PTP_CLK_EN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = aeon_dpc_ra_enable(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = aeon_ipc_get_fw_version(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	phydev->needs_reregister = true;
> > +
> > +	return 0;
> > +}
> 
> This probe function allocates devres resources that wil lbe freed when
> it returns through the unbinding in patch 1. This is a recipe for
> confusion - struct as21xxx_priv must never be used from any of the
> "real" driver.
> 
> I would suggest:
> 
> 1. document that devres resources will not be preserved when
>    phydev->needs_reregister is set true.
> 
> 2. rename struct as21xxx_priv to struct as21xxx_fw_load_priv to make
>    it clear that it's for firmware loading.
> 
> 3. use a prefix that uniquely identifies those functions that can only
>    be called with this structure populated.
> 
> 4. set phydev->priv to NULL at the end of this probe function to ensure
>    no one dereferences the free'd pointer in a "real" driver, which
>    could lead to use-after-free errors.
> 
> In summary, I really don't like this approach - it feels too much of a
> hack, _and_ introduces the potential for drivers that makes use of this
> to get stuff really very wrong. In my opinion that's not a model that
> we should add to the kernel.
> 
> I'll say again - why can't the PHY firmware be loaded by board firmware.
> You've been silent on my feedback on this point. Given that you're
> ignoring me... for this patch series...
> 
> Hard NAK.
> 
> until you start responding to my review comments.
>

No I wasn't ignoring you, the description in v1 for this was very
generic and confusing so the idea was to post a real implementation so
we could discuss on the code in practice... My comments were done before
checking how phy_registration worked so they were only ideas (the
implementation changed a lot from what was my idea) Sorry if I gave this
impression while I was answering only to Andrew...

The problem of PHY firmware loaded by board firmware is that we
introduce lots of assumption on the table. Also doesn't that goes
against the idea that the kernel should not assume stuff set by the
bootloader (if they can be reset and are not part of the core system?)

From what I'm seeing on devices that have this, SPI is never mounted and
bootloader doesn't provide support for this and the thing is loaded only
by the OS in a crap way.

Also the PHY doesn't keep the FW with an hardware reset and permit the
kernel to load an updated (probably fixed) firmware is only beneficial.
(there is plan to upstream firmware to linux-firmware)

I agree that the approach of declaring a "generic" PHY entry and "abuse"
the probe function is an HACK, but I also feel using match_phy_device
doesn't solve the problem.

Correct me if I'm wrong but match_phy_device will only give true or
false, it won't solve the problem of the PHY changing after the FW is
loaded.

This current approach permit to provide to the user the exact new OPs of
the PHY detected after FW is loaded.

Is it really that bad to introduce the idea that a PHY family require
some initial tuneup before it can correctly identified?

-- 
	Ansuel

