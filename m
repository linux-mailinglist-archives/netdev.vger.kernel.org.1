Return-Path: <netdev+bounces-57977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAFA814A82
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470351C22C80
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC631747;
	Fri, 15 Dec 2023 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DYOxdjhR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4C31A60;
	Fri, 15 Dec 2023 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P3iLHttbrgUIWYcVkIFf5jAva/J51DmOVnlpZQQDo+k=; b=DYOxdjhRrUI6Emgjy6KKYO0u2G
	83r8usrhOHjsEw53n/T5X7ttj9KFKKNdK8V/nM96s5gW/GRjs3VA/eQNtphY0p5rPXewmTam5jmRH
	vJUA9wBTuDGyYsxtZCtGaamJCXnkP7yQOKkBnjYCCd6mKYSvRD0cJ95Hhtoso8dvh5ws=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE9Cb-00323Q-Ao; Fri, 15 Dec 2023 15:30:09 +0100
Date: Fri, 15 Dec 2023 15:30:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
	kabel@kernel.org, hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware
 loading on 88X3310
Message-ID: <627fbf7d-5992-4c4b-9e32-b34e363db928@lunn.ch>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214201442.660447-2-tobias@waldekranz.com>

On Thu, Dec 14, 2023 at 09:14:39PM +0100, Tobias Waldekranz wrote:
> When probing, if a device is waiting for firmware to be loaded into
> its RAM, ask userspace for the binary and load it over XMDIO.

Does a device without firmware have valid ID registers? Is the driver
going to probe via bus enumeration, or is it necessary to use a
compatible with ID values?

> +	for (sect = fw->data; (sect + sizeof(hdr)) < (fw->data + fw->size);) {

This validates that the firmware is big enough to hold the header...

> +		memcpy(&hdr, sect, sizeof(hdr));
> +		hdr.data.size = cpu_to_le32(hdr.data.size);
> +		hdr.data.addr = cpu_to_le32(hdr.data.addr);
> +		hdr.data.csum = cpu_to_le16(hdr.data.csum);
> +		hdr.next_hdr = cpu_to_le32(hdr.next_hdr);

I'm surprised sparse is not complaining about this. You have the same
source and destination, and sparse probably wants the destination to
be marked as little endian.

> +		hdr.csum = cpu_to_le16(hdr.csum);
> +
> +		for (i = 0, csum = 0; i < offsetof(struct mv3310_fw_hdr, csum); i++)
> +			csum += sect[i];
> +
> +		if ((u16)~csum != hdr.csum) {
> +			dev_err(&phydev->mdio.dev, "Corrupt section header\n");
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		err = mv3310_load_fw_sect(phydev, &hdr, sect + sizeof(hdr));

What i don't see is any validation that the firmware left at sect +
sizeof(hdr) big enough to contain hdr.data.size bytes.

	    Andrew

