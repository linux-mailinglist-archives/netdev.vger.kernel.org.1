Return-Path: <netdev+bounces-57978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6AB814A8E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3711C22E2E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB1ED2;
	Fri, 15 Dec 2023 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MHuHuFjC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1A651;
	Fri, 15 Dec 2023 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9O2SRFCsr+fHmC5dGHeu5hxIQaUwVlsgWHNa5PRaEtE=; b=MHuHuFjCfdc1VWzBD5Ao1wfsum
	tY3zw85layAXOXNDuyK+y+5w9wphKbSm7sfW49RZuk+a6vO/VfaKYkWQrpoUVuxeQI7XgsMLv9eRu
	If3Tj4MG5VlNX6HbFsK8fA1wlKLWn2gyZQqc7fVOmysE6l64gEH8ReKoahO3UJybiRmg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE9FX-00324X-QC; Fri, 15 Dec 2023 15:33:11 +0100
Date: Fri, 15 Dec 2023 15:33:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
	kabel@kernel.org, hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware
 loading on 88X3310
Message-ID: <cde8ad34-0114-4cf4-b757-12ea6763a44a@lunn.ch>
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

> +	for (i = 0, csum = 0; i < hdr->data.size; i++)
> +		csum += data[i];

> +	for (sect = fw->data; (sect + sizeof(hdr)) < (fw->data + fw->size);) {
> +		memcpy(&hdr, sect, sizeof(hdr));
> +		hdr.data.size = cpu_to_le32(hdr.data.size);

hdr.data.size is little endian. Doing a for loop using a little endian
test seems wrong. Should this actually be le32_to_cpu()?

       Andrew

