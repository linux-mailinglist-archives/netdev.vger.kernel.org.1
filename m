Return-Path: <netdev+bounces-233651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E230FC16D2B
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04DCE4E22EC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D0725484D;
	Tue, 28 Oct 2025 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="REXKjKR4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81477194A65
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761684713; cv=none; b=tAVP0XM+ORhnQor8FDsG23Jsh9aqoelgeM1XiRe3i0ZtActkGa4cV91MzsKjIekzu7x5xh17+WOvJgKxbvwqll/MXCCra+yT/H4cgg4FKjO/0AgeA4WYMyECJr6GkyHhiNkrCI/HVksVWfqmjniKnDo2FPFj95Uf9M+EraYL2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761684713; c=relaxed/simple;
	bh=Anq6yU8fQAyxWkNPwr9hMF2cWcFWzhmTny0MoLakRjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmyapNlDMoRE6sn/e8NHmM6y5jC7Td2yDhj7wIMZuTo+jNZBApTJan2yn4qz8cvlxUUtgP89dpiISGyHqEGGQsI8VoGK/DQmhbQ444q1YJnZHsXTWPgQJ9mzr0mp7R9sx9S1FPJI/69GZbtDAkWGSkJR9X+Omi4qT+gqKN0p7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=REXKjKR4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rqoeB9SI63D4UdK84Py2fl0q0mrx15Kz+ONQpl3/bNg=; b=REXKjKR4njeNOkV/d1dZeP7PII
	Pmi3ln7MH6kg2cHnQdBXjNaSO+NyLQ5cTjhmxZvK6E/fSRjEQ0wQS7zVE//yycm8YhS4vP5U5fl7U
	bsAI/dR/OsUKtfjmoSwj9Za99IMwXY0VNx9LxM6a23LjYUW12HraBed/Skj/wnKUrnnY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDqfO-00CKZH-Jc; Tue, 28 Oct 2025 21:51:42 +0100
Date: Tue, 28 Oct 2025 21:51:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH 7/8] fbnic: Add SW shim for MII interface to
 PMA/PMD
Message-ID: <0d66967f-e75f-4723-99f4-164abfe8b9ff@lunn.ch>
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133848134.2245037.8819965842869649833.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176133848134.2245037.8819965842869649833.stgit@ahduyck-xeon-server.home.arpa>

> +static int
> +fbnic_swmii_read_pmapmd(struct fbnic_dev *fbd, int regnum)
> +{
> +	u16 ctrl1 = 0, ctrl2 = 0;
> +	struct fbnic_net *fbn;
> +	int ret = 0;
> +	u8 aui;
> +
> +	if (fbd->netdev) {

Is that even impossible? I don't remember the core code, but usually
the priv structure is appended to the end of the net_device structure.

> +		fbn = netdev_priv(fbd->netdev);
> +		aui = fbn->aui;
> +	}
> +
> +	switch (aui) {
> +	case FBNIC_AUI_25GAUI:
> +		ctrl1 = MDIO_CTRL1_SPEED25G;
> +		ctrl2 = MDIO_PMA_CTRL2_25GBCR;
> +		break;
> +	case FBNIC_AUI_LAUI2:
> +		ctrl1 = MDIO_CTRL1_SPEED50G;
> +		ctrl2 = MDIO_PMA_CTRL2_50GBCR2;
> +		break;
> +	case FBNIC_AUI_50GAUI1:
> +		ctrl1 = MDIO_CTRL1_SPEED50G;
> +		ctrl2 = MDIO_PMA_CTRL2_50GBCR;
> +		break;
> +	case FBNIC_AUI_100GAUI2:
> +		ctrl1 = MDIO_CTRL1_SPEED100G;
> +		ctrl2 = MDIO_PMA_CTRL2_100GBCR2;
> +		break;
> +	default:
> +		break;

If it is something else, is that a bug? Would it be better to return
-EINVAL?

> +	}
> +
> +	switch (regnum) {
> +	case MDIO_CTRL1:
> +		ret = ctrl1;
> +		break;
> +	case MDIO_STAT1:
> +		ret = fbd->pmd_state == FBNIC_PMD_SEND_DATA ?
> +		      MDIO_STAT1_LSTATUS : 0;
> +		break;
> +	case MDIO_DEVS1:
> +		ret = MDIO_DEVS_PMAPMD;
> +		break;
> +	case MDIO_CTRL2:
> +		ret = ctrl2;
> +		break;
> +	case MDIO_STAT2:
> +		ret = MDIO_STAT2_DEVPRST_VAL |
> +		      MDIO_PMA_STAT2_EXTABLE;
> +		break;
> +	case MDIO_PMA_EXTABLE:
> +		ret = MDIO_PMA_EXTABLE_40_100G |
> +		      MDIO_PMA_EXTABLE_25G;
> +		break;
> +	case MDIO_PMA_40G_EXTABLE:
> +		ret = MDIO_PMA_40G_EXTABLE_50GBCR2;
> +		break;
> +	case MDIO_PMA_25G_EXTABLE:
> +		ret = MDIO_PMA_25G_EXTABLE_25GBCR;
> +		break;
> +	case MDIO_PMA_50G_EXTABLE:
> +		ret = MDIO_PMA_50G_EXTABLE_50GBCR;
> +		break;
> +	case MDIO_PMA_EXTABLE2:
> +		ret = MDIO_PMA_EXTABLE2_50G;
> +		break;
> +	case MDIO_PMA_100G_EXTABLE:
> +		ret = MDIO_PMA_100G_EXTABLE_100GBCR2;
> +		break;
> +	default:
> +		break;

So the intention here is to return 0, meaning the register does not
exist, as defined by 802.3 for C45? Maybe add a comment?

I'm just wondering how robust this is. Maybe at a dev_dbg() printing
the regnum?

> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +fbnic_swmii_read_c45(struct mii_bus *bus, int addr, int devnum, int regnum)
> +{
> +	struct fbnic_dev *fbd = bus->priv;
> +
> +	if (addr != 0)
> +		return 0xffff;
> +
> +	if (devnum == MDIO_MMD_PMAPMD)
> +		return fbnic_swmii_read_pmapmd(fbd, regnum);
> +
> +	return 0xffff;

For C45 you are supposed to return 0 if the register does not exist. It says:

   45.2 MDIO Interface registers

   If a device supports the MDIO interface it shall respond to all
   possible register addresses for the device and return a value of
   zero for undefined and unsupported registers.

> +static int
> +fbnic_swmii_write_c45(struct mii_bus *bus, int addr, int devnum,
> +		      int regnum, u16 val)
> +{
> +	/* Currently PHY setup is meant to be read-only */
> +	return 0;

-EOPNOTSUPP? WARN_ON_ONCE()?

If it does happen, i assume that means your assumptions are wrong?
Don't you want to know?

	Andrew

