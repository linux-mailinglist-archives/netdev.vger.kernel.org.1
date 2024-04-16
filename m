Return-Path: <netdev+bounces-88317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E208A6AC2
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51421F2193A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469FF12C485;
	Tue, 16 Apr 2024 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR9gTknF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2FF12C481
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269981; cv=none; b=D9mI+IbHbJlds8A/G0qVhCoEgF/RbSUazdXrVFHq0kh9cnTItlUoRUTdGRFEt3KhYmdIhyTF28qb/GjLLPZ5IFy9bWYM985/j0BEudn9F7e3PI+Tbcmjy3AYZsBxtmSoVcaxGDPK7ld0eFmZzvX+K9k+5zsbfLwZfBret5U988U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269981; c=relaxed/simple;
	bh=yekDoSMPIs7ET75V7Z52GKdQ8aYWEp+cGIOiKti/F6A=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Gz9JblDgbxWhtpu4V3MngS/TTC7ec1xzfkhnhSPckTKwCAbVeQ0fnQvC6HUtGXMGvs3c1EOWagRBLjle0PaE/JnzMKLo+esY4ZF6iZ7kDtUpWoAOJO629wy8GkaPu+ud40K+8IKkRvbWEFB3874ZHuqQGarzokWlXLZNxxpyqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR9gTknF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2be2361efso7348155ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713269979; x=1713874779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JX3ysg83DC7xVvgYObrnTkfp4//VheRNGQlTemkEcVQ=;
        b=WR9gTknF/M5b/G14PgOzx9v5vjmxxJz5QU1egFtCUDD4DgCLhPwJu/u7NMbON2OYMy
         mjLh2VCMx9OC8pUHPXGwFTYaOTNqToiWvHBOohwtCwc0lxX3YmEtyJDKMjVg5CQYPq48
         o6nqYORIUCn1pewEMY9WCJuEwhio5Qdb08d/kUWYUMxqb74sQhn7LZEzILlGDQLegyYd
         FljPQGTCIJPQq3nOSfHRVLyKXppFEd8tSFUJETJHqUnLwRRWCxmDSWIsn2IjMqWRQoCx
         ishRXPRtTnxlfQ4fQ9gQInEPYhJF7+KmvuJq6e7t3gYBl62Egxl+h6WSBdwLgk04Jrnh
         p2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269979; x=1713874779;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JX3ysg83DC7xVvgYObrnTkfp4//VheRNGQlTemkEcVQ=;
        b=Flx+93RPYIoqg6/0MiaV3xjhEukjT13vJk2Av83offgYkH/b+VOu3D8NjOC5QCFakj
         J5a3hHMtpY9lapusE6EPn/QautaB7qTqKaqQPKA1lP8MNmuTMNB+FBSdbPW98/JiZUjO
         AHA/6wstoh8PS6rB/4RDB+9PHmiOSxdrslTRcNtrzFmShA5lTc5Om3uL+6CfdeCJlmGa
         de/JjlWB2BIZkZvMs8SZcLEGDGr5nlwkdLs17yjQ1wfCloTtX+viiDP5b3KDHFJltoaT
         gxjKpDYHWSXU8BbTU7umS+EhcpNSaFzIpNT1R/DczCBQr2ZY5JqnnnYIO4gLnUujkgg8
         7BxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr8lvai3w4+EgUFk1snLlHMszl7q7Mar5ePeSoKxDWe6Y8Z/wuBxmuXteAREa4jCn0y3e5vg8KY3T4hLlkaE62gCjcLxlY
X-Gm-Message-State: AOJu0YxLxEYEgBg2Uzyh95/K2qUKPb70gVpnA1arnA2Ld9FuG83thFbw
	8heEhXSdDvyUX/kW7B2TNtXjCsS263IeqluIBaUDrrKef9An7OkQphiQFJK7
X-Google-Smtp-Source: AGHT+IGaHuwfeplw6/GsiZdCO9wIcCd1Y4Voq582KwVxjdWway/y5ZhGEQ/RlFVL+9xP8tzkrJebJw==
X-Received: by 2002:a17:902:f542:b0:1e2:b3d:8c67 with SMTP id h2-20020a170902f54200b001e20b3d8c67mr14787129plf.6.1713269979066;
        Tue, 16 Apr 2024 05:19:39 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id p18-20020a1709028a9200b001e2b4f513e1sm9618580plo.106.2024.04.16.05.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:19:38 -0700 (PDT)
Date: Tue, 16 Apr 2024 21:19:26 +0900 (JST)
Message-Id: <20240416.211926.560322866915632259.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 5/5] net: tn40xx: add PHYLIB support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <7c20aefa-d93b-41e2-9a23-97782926369d@lunn.ch>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
	<20240415104352.4685-6-fujita.tomonori@gmail.com>
	<7c20aefa-d93b-41e2-9a23-97782926369d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 15 Apr 2024 16:44:31 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Mon, Apr 15, 2024 at 07:43:52PM +0900, FUJITA Tomonori wrote:
>> This patch adds supports for multiple PHY hardware with PHYLIB. The
>> adapters with TN40xx chips use multiple PHY hardware; AMCC QT2025, TI
>> TLK10232, Aqrate AQR105, and Marvell 88X3120, 88X3310, and MV88E2010.
>> 
>> For now, the PCI ID table of this driver enables adapters using only
>> QT2025 PHY. I've tested this driver and the QT2025 PHY driver with
>> Edimax EN-9320 10G adapter.
> 
> Please split this up. Add the MDIO bus master in one patch. Then add
> support for phylib in a second patch. They are logically different
> things.

Understood, I'll split this in v2.


> Are there variants of this device using SFP? It might be you actually
> want to use phylink, not phylib. That is a bit messy for a PCI device,
> look at drivers/net/ethernet/wangxun.

phylink is necessary if PHY is hot-pluggable, right? if so, the driver
doesn't need it. The PHYs that adapters with TN40XX use are

AMCC QT2025 PHY (SFP+)
- Tehuti TN9310
- DLink DXE-810S
- Asus XG-C100F
- Edimax EN-9320

Marvell MV88x3120 (10GBase-T)
- Tehuti TN9210

Marvell MV88X3310 (10GBase-T)
- Tehuti TN9710
- Edimax EN-9320TX-E
- Buffalo LGY-PCIE-MG
- IOI GE10
- LR-Link LREC6860BT
- QNAP PCIe Expansion Card

Marvell MV88E2010 (5GBase-T)
- Tehuti TN9710Q

TI TLK10232 (SFP+)
- Tehuti TN9610
- LR-Link LREC6860AF

Aquantia AQR105 (10GBase-T)
- Tehuti TN9510
- DLink DXE-810T
- Edimax EN-9320TX-E


>> diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
>> index 4198fd59e42e..71f22471f9a0 100644
>> --- a/drivers/net/ethernet/tehuti/Kconfig
>> +++ b/drivers/net/ethernet/tehuti/Kconfig
>> @@ -27,6 +27,7 @@ config TEHUTI_TN40
>>  	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
>>  	depends on PCI
>>  	select FW_LOADER
>> +	select AMCC_QT2025_PHY
> 
> That is pretty unusual, especially when you say there are a few
> different choices.

I should not put any 'select *_PHY' here?


>> +static u32 bdx_mdio_get(struct bdx_priv *priv)
>> +{
>> +	void __iomem *regs = priv->regs;
>> +
>> +#define BDX_MAX_MDIO_BUSY_LOOPS 1024
>> +	int tries = 0;
>> +
>> +	while (++tries < BDX_MAX_MDIO_BUSY_LOOPS) {
>> +		u32 mdio_cmd_stat = readl(regs + REG_MDIO_CMD_STAT);
>> +
>> +		if (GET_MDIO_BUSY(mdio_cmd_stat) == 0)
>> +			return mdio_cmd_stat;
>> +	}
>> +	dev_err(&priv->pdev->dev, "MDIO busy!\n");
> 
> include/linux/iopoll.h
> 
>> +	return 0xFFFFFFFF;
> 
> It is always better to use standard error codes. In this case,
> -ETIMEDOUT.

I'll


>> +static u16 bdx_mdio_read(struct bdx_priv *priv, int device, int port, u16 addr)
>> +{
>> +	void __iomem *regs = priv->regs;
>> +	u32 tmp_reg, i;
>> +	/* wait until MDIO is not busy */
>> +	if (bdx_mdio_get(priv) == 0xFFFFFFFF)
>> +		return -1;
>> +
>> +	i = ((device & 0x1F) | ((port & 0x1F) << 5));
>> +	writel(i, regs + REG_MDIO_CMD);
>> +	writel((u32)addr, regs + REG_MDIO_ADDR);
>> +	tmp_reg = bdx_mdio_get(priv);
>> +	if (tmp_reg == 0xFFFFFFFF)
>> +		return -1;
> 
> This function has a return type of u16. So returning -1 makes no sense.

Yeah, I thought the same but left it alone. I'll change in v2.


>> +static int mdio_read_reg(struct mii_bus *mii_bus, int addr, int devnum, int regnum)
>> +{
>> +	return bdx_mdio_read(mii_bus->priv, devnum, addr, regnum);
> 
> I would probably change bdx_mdio_read() so that it takes the
> parameters in the same order as mdio_read_reg().

Sure, I'll.


> There is also a reasonably common convention that the functions
> performing C45 bus protocol operations have c45 in their name. It
> appears this hardware does not support C22 at all. That makes it
> unusual, and little hits like this are useful.

I'm not sure the adapters supports C22 or not (probably do, I
guess). But the original driver uses C45 bus protocol operations.

