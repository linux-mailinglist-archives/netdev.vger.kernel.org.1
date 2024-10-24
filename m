Return-Path: <netdev+bounces-138618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB599AE4AD
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEA51C21C8C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B641CACE1;
	Thu, 24 Oct 2024 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xCLqhIRu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079FE1D0171;
	Thu, 24 Oct 2024 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772546; cv=none; b=o6qM1fVQ4I0vprYZMUQfr+43DCi5JzXwBmdMrtrBHh+P5Y1dNv8hDtGxGqMkJsLR/XGdv0l7NJ0yxsWnZnBHZk3SsplUDbIFtjd6NrruO65TXYgFUgmSePTEGEgYLdnvCpJpK2dsWc7Ew+NV7BRY/ITXi3AADvWxeUb374U2NoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772546; c=relaxed/simple;
	bh=Hz7ooOoVpPkyIOchzBaEgBO5VCwgfbOpQHkmS7BlMgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIhqUxUT4XSnXKXu3yP6r/HhvO6Wdm+TJsubpH6pKcMfduiQWQKHF+rSnP6aeQmiye4VTj7zd3zSpv7u4EQZsms6PM61zclrdnnx3B52qpNaWh2TMeJN1oyUsYL/mDRVGft7YREDwVnudBHGgTTj93AQfXdn3uFdMa4G80C8yK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xCLqhIRu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iI3W5xQMXONpmwLfzLPwiSWolb/+65tdaIDfqYIaLdQ=; b=xCLqhIRuG4vLUz0bU7QAXR+nzJ
	y0dZUPELwxUWqk8jw8eoU/dWtxn8OfuweMNYLgtoVl0MBR6sG3T+vBfuFifNKHE88aA7VMtdcnZZY
	XCU2UAEZ0F70/EruMBaTqJ9bIuG1RheD86mEZ4x2sXoD4AuhSxycSXIfcodvvAsf4YcA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3wqz-00B7F9-CH; Thu, 24 Oct 2024 14:22:13 +0200
Date: Thu, 24 Oct 2024 14:22:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/7] net: hibmcge: Add register dump supported
 in this module
Message-ID: <e1827d48-7aeb-4f40-9332-8ce1efc5c960@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-5-shaojijie@huawei.com>
 <f34ba74e-f691-409f-b2f1-990ba9a6c5a9@lunn.ch>
 <3a9bf4e6-b764-49b3-af8b-b5fd71cc4e49@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9bf4e6-b764-49b3-af8b-b5fd71cc4e49@huawei.com>

> We have other considerations:
> 
> If the dump register changes in the future, we hope that
> only the kernel needs to be modified, and the ethtool does not need to be modified.
> In this case, We do not need to consider the mapping between the ethtool and driver versions.
> 
> So in ethtool, we only need to consider basic formatted printing.
> like this(not send yet):
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > 
> #define HBG_REG_NAEM_MAX_LEN 32
> struct hbg_reg_info {
> 	char name[HBG_REG_NAEM_MAX_LEN];
> 	u32 offset;
> 	u32 val;
> };
> static void hibmcge_dump_reg_info(struct hbg_reg_info *info)
> {
> 	fprintf(stdout, "%-*s[0x%04x]: 0x%08x\n",
> 		HBG_REG_NAEM_MAX_LEN, info->name, info->offset, info->val);
> }
> int hibmcge_dump_regs(struct ethtool_drvinfo *info __maybe_unused,
> 		      struct ethtool_regs *regs)
> {
> 	struct hbg_reg_info *reg_info;
> 	u32 name_max_len;
> 	u32 offset = 0;
> 	if (regs->len % sizeof(*reg_info) != 0)
> 		return -EINVAL;
> 	while (offset < regs->len) {
> 		reg_info = (struct hbg_reg_info *)(regs->data + offset);
> 		hibmcge_dump_reg_info(reg_info);
> 		offset += sizeof(*reg_info);
> 	}
> 	return 0;
> }
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > 
> 
> So, In this patch, pass back hbg_reg_info(name, offset, value)

So this is different to all other drivers doing registers dumps.

1) Please explain this in the commit message, with a justification why
your driver is different.

2) What is actually specific to your driver here? Why not make this
available to all drivers? Maybe check if ethtool_regs.version ==
MAX_U32 is used by any of the other drivers, and if not, make that a
magic value to indicate your special format.

3) Maybe consider that there does not appear to be a netlink version
of this ethtool ioctl. Could this be nicely integrated into a netlink
version, where you have more flexibility with attributes?


	Andrew

