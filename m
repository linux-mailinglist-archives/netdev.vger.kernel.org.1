Return-Path: <netdev+bounces-204245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C2AF9AC8
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 20:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA441C834FB
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CC1210F4A;
	Fri,  4 Jul 2025 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2piz3vO2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982EF6A8D2;
	Fri,  4 Jul 2025 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751654028; cv=none; b=sKSHICoKMXwF6QchZsjWq/R/kq9HexiHixNgQcQ5qhBKQ56nPMW7NE9OMWCluIaZ4Jfv5Cou2ARHccjPjmGuAvhZal53JRG/w9I+DRZhDp8X/XZx1H+laifUkZcNoMLqYZySZcRUjA0od0OKY0qcv8BEV1zvWa2+XGhwoZsmnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751654028; c=relaxed/simple;
	bh=vQhQdHr2NuWlF2W+dHvSx4F+3fByHijwc6wElC5GA44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB5sfSG0BCJ1mat6JV5la1yhcBY0rFOy/zOcWLCFx+IdP4MzFbIEtQwUQ12kHFdBZIzZG4M18GX7HLU1r6EDJokjsVFFFP7x/daQBgL7xF/fxx4x126J1itKtoHZDHyyAkNZTVRQz8lAq0ONXizm6CjoFq1lcJT38XOYSk16694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2piz3vO2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bycTEzS3KLjwL/YYFrn1fCzuXg0ug+wcTwmO/hQuwXY=; b=2piz3vO2IngY5GxzURTUkzmr81
	/hP0CWqCWTEKtU/OmNAv231Dm6ikse0SHXU4mkaO272CdaJ0HDX7SR1MDCcNOjzIv314N0SGheQE8
	xKHiG5Co3KZopd2qy3tHpP/VVtx3uTRRmLuYl9WQd43sGO0mObHEZK3NsXSsrQJRF8qA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXlDm-000Hc3-Bx; Fri, 04 Jul 2025 20:33:14 +0200
Date: Fri, 4 Jul 2025 20:33:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] net: rnpgbe: Add download firmware for n210 chip
Message-ID: <37ede55f-613b-481f-a8d9-43ee1414849a@lunn.ch>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-6-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703014859.210110-6-dong100@mucse.com>

>  static int init_firmware_for_n210(struct mucse_hw *hw)
>  {
> -	return 0;
> +	char *filename = "n210_driver_update.bin";
> +	const struct firmware *fw;
> +	struct pci_dev *pdev = hw->pdev;
> +	int rc = 0;
> +	int err = 0;
> +	struct mucse *mucse = (struct mucse *)hw->back;
> +
> +	rc = request_firmware(&fw, filename, &pdev->dev);
> +
> +	if (rc != 0) {
> +		dev_err(&pdev->dev, "requesting firmware file failed\n");
> +		return rc;
> +	}
> +
> +	if (rnpgbe_check_fw_from_flash(hw, fw->data)) {
> +		dev_info(&pdev->dev, "firmware type error\n");

Why dev_info()? If this is an error then you should use dev_err().

> +	dev_info(&pdev->dev, "init firmware successfully.");
> +	dev_info(&pdev->dev, "Please reboot.");

Don't spam the lock with status messages.

Reboot? Humm, maybe this should be devlink flash command.

request_firmware() is normally used for download into SRAM which is
then used immediately. If you need to reboot the machine, devlink is
more appropriate.

> +static inline void mucse_sfc_command(u8 __iomem *hw_addr, u32 cmd)
> +{
> +	iowrite32(cmd, (hw_addr + 0x8));
> +	iowrite32(1, (hw_addr + 0x0));
> +	while (ioread32(hw_addr) != 0)
> +		;


Never do endless loops waiting for hardware. It might never give what
you want, and there is no escape.

> +static int32_t mucse_sfc_flash_wait_idle(u8 __iomem *hw_addr)
> +{
> +	int time = 0;
> +	int ret = HAL_OK;
> +
> +	iowrite32(CMD_CYCLE(8), (hw_addr + 0x10));
> +	iowrite32(RD_DATA_CYCLE(8), (hw_addr + 0x14));
> +
> +	while (1) {
> +		mucse_sfc_command(hw_addr, CMD_READ_STATUS);
> +		if ((ioread32(hw_addr + 0x4) & 0x1) == 0)
> +			break;
> +		time++;
> +		if (time > 1000)
> +			ret = HAL_FAIL;
> +	}

iopoll.h 

> +static int mucse_sfc_flash_erase_sector(u8 __iomem *hw_addr,
> +					u32 address)
> +{
> +	int ret = HAL_OK;
> +
> +	if (address >= RSP_FLASH_HIGH_16M_OFFSET)
> +		return HAL_EINVAL;

Use linux error codes, EINVAL.

> +
> +	if (address % 4096)
> +		return HAL_EINVAL;

EINVAL

> +
> +	mucse_sfc_flash_write_enable(hw_addr);
> +
> +	iowrite32((CMD_CYCLE(8) | ADDR_CYCLE(24)), (hw_addr + 0x10));
> +	iowrite32((RD_DATA_CYCLE(0) | WR_DATA_CYCLE(0)), (hw_addr + 0x14));
> +	iowrite32(SFCADDR(address), (hw_addr + 0xc));
> +	mucse_sfc_command(hw_addr, CMD_SECTOR_ERASE);
> +	if (mucse_sfc_flash_wait_idle(hw_addr)) {
> +		ret = HAL_FAIL;
> +		goto failed;

mucse_sfc_flash_wait_idle() should return -ETIMEDOUT, so return that.

	Andrew

