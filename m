Return-Path: <netdev+bounces-150676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CB9EB26B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399AF289C32
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61481AAA01;
	Tue, 10 Dec 2024 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vCOnIxrN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B81AA1F6
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839094; cv=none; b=N7Yj952PmvERBUtozozfF/O5MRaywpmskWN8N7nhGLRymwoboaXeQiI3ATq9JV/FTQtgyBaV/YAya7HhPy7hXAx71Iao4L/Njzw5j3MA+vhDR74w+x5ZOv12k6hXO6ausTQ25piWSN/kHumrRxWWFAD6tR/6ve6jXuvfYnl6jN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839094; c=relaxed/simple;
	bh=cziyjqvAA9o3oXBi5p7z+vGaXHqTP7LNbbDRk0jBess=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N63xBauIKdkFhJ40NN6Xma4vw/Ds2UGAsvssB+rnbwbzKr05BWpsu991yteO7aA9Ry49VUX5A+rS8JdPCyCYoLKxr917CPObZO5tYRyCTjbKp+qOuPv0Pqoj3MiCUolS6Hcf5540ILyKgwYbDigjV01sDN/pEkekMrdzX9gKBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vCOnIxrN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2wiUv+03o3fGTTmMTI/5La/r/wbwoY2yisW84MazzqM=; b=vCOnIxrNQ6XlHIQcY3udpZZ9W+
	wZ7RMDmRfs5KP6CC0TH4v/Ya6+a4jsz1h8ndLyGGiGFR1Y0R1Ab7k0GgieTYPxJqIVzPJ+YfIAoyU
	setZb60Rf8zSjDMpdeQbRXeNq9mY8IEZD0+YlRzDqnIP3BoBd1vL/GS3k1fXRatiKfbFs6jWIZm3p
	y1VJLKGQaLf2nv0qvA4250s7sI7nxmbd24oBSeaYmiL6hhDqgcw7K5TlojhqOlnmQM5H+ToJOn1JB
	ZX3Dh8HxxXEDKRTPk/zx7vonKhGxV9hvVGBxTxxD/Rn9C2v9nK4Rlk/eL7CBuHSMgHDr6btXs3x3A
	fyMs4EIg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42720)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tL0kW-0002Pp-1W;
	Tue, 10 Dec 2024 13:58:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tL0kT-00030T-1o;
	Tue, 10 Dec 2024 13:58:01 +0000
Date: Tue, 10 Dec 2024 13:58:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 06/10] net: phylink: allow MAC driver to
 validate eee params
Message-ID: <Z1hI6YvfdrIJkAbh@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefn-006SMv-Lg@rmk-PC.armlinux.org.uk>
 <a72db39a-ca78-43bc-a15b-5f1ab39af661@lunn.ch>
 <Z1gQ0O8dbUl26JTc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1gQ0O8dbUl26JTc@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 10, 2024 at 09:58:40AM +0000, Russell King (Oracle) wrote:
> That could make mac_validate_tx_lpi() redundant, but then I have a
> stack of DSA patches that could use this callback to indicate that
> EEE is not supported.

Scratch that idea - DSA also needs the ethtool get_eee() method to
return -EOPNOTSUPP, which mac_validate_tx_lpi() wouldn't cover.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

