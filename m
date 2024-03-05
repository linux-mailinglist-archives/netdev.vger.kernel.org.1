Return-Path: <netdev+bounces-77524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF6D8721C3
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE90DB2565F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E71686AD0;
	Tue,  5 Mar 2024 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WIglimTB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E786127
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649725; cv=none; b=ad2NprrAx9P+Msg8zcW0GmwjMAciSkPf9D3+ddtC7viZV8TZ34pBAlDWvMyw1BMho9eOKpebpoZFZ9QAB1mvgASh23j/etinMieuZve6k252L+BlulK9bmBxw4Y36P4akpsHmDuQu7bAV/ZhX35P2NdSVqV7MYE8Z50kXdBF6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649725; c=relaxed/simple;
	bh=TrUAkYYu/9i8Kf1LPrNJKlhJU/lsVi4hnJ+0gc046z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgZnDYvYLIQLHjLDyt9vCllV59s9XvSuvUzFg3oTa+T6gLLe+Fj/oL6enbFFSTx7tcNu/9KYbhx/Jgepo53R2LP/hQUrHVV2hN5KJZg7SAR0pNhXCaPUN7mj17xCDJpSNAKMWnmbaQ4vMd+zS5Nxjpea4h51aB1Cmdz1tu74mpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WIglimTB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2o1S9zIpxqw4C0Qpcfs+frgZUNLvoqgPxIESVdPsfn8=; b=WIglimTBPYH6TXNq5M8ZLnLARe
	YXAFOc6Nw6lYymdezj7KVQWAYK2nkfWVIuvFHK7AwWZvHmlzzZ3LOnEK1/cs7nAu9Vc0Q5GOnzHEM
	Zg1ioIL7neSULht6+TmqZLf87njriDBAv6GqXvclDJAM4hXjRFyK9jVHvnKWPAPP9VqRdQBJX0RWE
	TgSSq6PI8xan+SSqFnlMLNbLP9AYc+tKtCnwg8hGu6P6zzGe8jSHa0+2pI8CqOzxF8N3mjyat9AZQ
	5ov0XMSTOd8h+tfCOqU4p66M+WJ4GeHfTLJienPm48uqhRh2D1TJ8ieBzAW8KACZSCXlLMj09VBJ5
	VgmrLvGA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44772)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rhVzK-0007GO-1V;
	Tue, 05 Mar 2024 14:41:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rhVzG-0005UU-IK; Tue, 05 Mar 2024 14:41:46 +0000
Date: Tue, 5 Mar 2024 14:41:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew@lunn.ch, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, jan.kiszka@siemens.com
Subject: Re: [PATCH net-next v4 05/10] net: ti: icssg-prueth: Add
 SR1.0-specific description bits
Message-ID: <ZecvKo1HDAXD0n7Q@shell.armlinux.org.uk>
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
 <20240305114045.388893-6-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305114045.388893-6-diogo.ivo@siemens.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 05, 2024 at 11:40:25AM +0000, Diogo Ivo wrote:
> +struct emac_tx_ts_response_sr1 {
> +	u32 lo_ts;
> +	u32 hi_ts;
> +	u32 reserved;
> +	u32 cookie;
> +};

In patch 10, this comes from skb->data, so seems to be a packet. Is the
data dependent on the host endian, or is it always little endian?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

