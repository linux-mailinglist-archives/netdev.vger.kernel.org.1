Return-Path: <netdev+bounces-138275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852589ACC03
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D7C1C216B8
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531371BE223;
	Wed, 23 Oct 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="prgEnpzQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9571BD039;
	Wed, 23 Oct 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692845; cv=none; b=FbiaylOCxPFJ9E+xB4TTMG5C0e6w45r3Ds8qYcNFYBpJuj+DynQ1Fj4K0orFXF905yWugcvpmVF4lCcMtmDwjWmVooGU5J5ueqSYNWp6fId4BCSZr45JyDHOamSEA1mrQDwIRc4suALRNXYE8SMes3gdIVd0yV67mGbUe2xwhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692845; c=relaxed/simple;
	bh=MnffneQdaKoB7y2GLhB3pwM+rR+g1egBsBX1gtGMdIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgypqA5Y1t03RAo8qxPn09hrTOcWPPG93l5T+4wDFsaSIJ0DvbnuVMXsXLdSSB0GLzgllRGBfd3OkB4vT62nTGZpzU59OgDbY+FOMc+iYqcQQG5wSfXHRnREU1lxl1JGiPW4l0Y9rzgfpAcjfHCwSkWO+yAWp/IeqDmpcsU3Yrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=prgEnpzQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XwdMFuRVyHLnUUuGmW9aG/vl1x/aQq4A6HGrqUDK2K4=; b=prgEnpzQA9qxNo2Pk9I332LfrN
	XDRJ2+46NkxnulJX9qoYRL2XjgThAh3Xk0fGr5js6vLjCsd5yKLqhpcXGUDLHbCnAMfONVpxgkK7q
	O6JE1SkRXbTdrweWBaKigTE6DDRN8RPyiIyn5N23NSEKIuUZEWDCsdUWLhwUABk7SmBw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3c7W-00AyNs-RL; Wed, 23 Oct 2024 16:13:54 +0200
Date: Wed, 23 Oct 2024 16:13:54 +0200
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
Message-ID: <f34ba74e-f691-409f-b2f1-990ba9a6c5a9@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023134213.3359092-5-shaojijie@huawei.com>

On Wed, Oct 23, 2024 at 09:42:10PM +0800, Jijie Shao wrote:
> With the ethtool of a specific version,
> the following effects are achieved:
> 
> [root@localhost sjj]# ./ethtool -d enp131s0f1
> [SPEC] VALID                    [0x0000]: 0x00000001
> [SPEC] EVENT_REQ                [0x0004]: 0x00000000
> [SPEC] MAC_ID                   [0x0008]: 0x00000002
> [SPEC] PHY_ADDR                 [0x000c]: 0x00000002
> [SPEC] MAC_ADDR_L               [0x0010]: 0x00000808
> [SPEC] MAC_ADDR_H               [0x0014]: 0x08080802
> [SPEC] UC_MAX_NUM               [0x0018]: 0x00000004
> [SPEC] MAX_MTU                  [0x0028]: 0x00000fc2
> [SPEC] MIN_MTU                  [0x002c]: 0x00000100

Seems like this makes your debugfs patches redundant?

> +static u32 hbg_get_reg_info(struct hbg_priv *priv,
> +			    const struct hbg_reg_type_info *type_info,
> +			    const struct hbg_reg_offset_name_map *reg_map,
> +			    struct hbg_reg_info *info)
> +{
> +	info->val = hbg_reg_read(priv, reg_map->reg_offset);
> +	info->offset = reg_map->reg_offset - type_info->offset_base;
> +	snprintf(info->name, sizeof(info->name),
> +		 "[%s] %s", type_info->name, reg_map->name);
> +
> +	return sizeof(*info);
> +}
> +
> +static void hbg_ethtool_get_regs(struct net_device *netdev,
> +				 struct ethtool_regs *regs, void *data)
> +{
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +	const struct hbg_reg_type_info *info;
> +	u32 i, j, offset = 0;
> +
> +	regs->version = 0;
> +	for (i = 0; i < ARRAY_SIZE(hbg_type_infos); i++) {
> +		info = &hbg_type_infos[i];
> +		for (j = 0; j < info->reg_num; j++)
> +			offset += hbg_get_reg_info(priv, info,
> +						   &info->reg_maps[j],
> +						   data + offset);
> +	}
> +}

data is supposed to be just raw values, dumped from registers in the
device. You appear to be passing back ASCII text. It is supposed to be
ethtool which does the pretty print, not the kernel driver.

    Andrew

---
pw-bot: cr

