Return-Path: <netdev+bounces-144087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F299C58AE
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1862813B0
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB66A13BAE2;
	Tue, 12 Nov 2024 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SvgtsjXx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855AB13C908;
	Tue, 12 Nov 2024 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417132; cv=none; b=P28vT0yEiGQzdyXsxdHyWqBy79tN6p9qUOw1+Pf3rX32Kys2jr3PMxY6WL9K7+KbSNkdzNzBzMlif19y6ljRwafznLnibwqZHZZXDOTdZxQ4IeUZtOxQqIjuuEU1ns0RZ26a35CK1MO/ubRS9K3i8uwh+v6X5NPM+aTONONWkUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417132; c=relaxed/simple;
	bh=3un5fi6v2wxb161CVIYaW2Xeqh2l+goOScHgKeCEAC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFp5biLijU1BPrvzMKuelWwm1id0rqAPsmgOLJj25wwza6BrH69cmZyFSJ0Qo4EbNMjv/+1+wRkwJVn6rtZWNUEoC8OA76w38fOS9W/7ktFvgmOYRj4A4Nau2oT1u8Q2d/F77uTv5mUzr5k8zimCli1RnXCrtnhar6R24ngzOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SvgtsjXx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cdHCJ1bsgNNQqqqlJwHS8voOrNnAGtURqaGTrBj4yjg=; b=SvgtsjXx5jORXW1sdpEmJPX842
	mpg+ibMiGzMjEQ5lCNrMKq1gHHVmekIpxx9pDrpW97Ewqn/X6Q3uyF9CIpw4Wvvgi5IhgFN+KEiNx
	eIN/p+DXRNtniMLPAJub+58yUn36m8feN0HXheZWM05pWcDpQaS9idBuGnNbeQmN3ukFlmf1960/J
	RuLcjbhdL/B8V3EchzIdaTQtQggD48BFQpJDYiotTRpe3A1BFWshi9IqwpoOwP93IvBcNirOBazgc
	jiGr5Wp/CyAqegYoZK+s6pyzsAtKu7qukeHVX1XBvDW6HeOtldd67AwO2tfqwBth9gA8S/pn2H+c3
	6syjI5BA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42332)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tAqgf-0004Ep-0W;
	Tue, 12 Nov 2024 13:12:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tAqgd-0007Uq-2W;
	Tue, 12 Nov 2024 13:12:03 +0000
Date: Tue, 12 Nov 2024 13:12:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alistair Francis <alistair@alistair23.me>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	hkallweit1@gmail.com, andrew@lunn.ch, alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/2] mdio: Remove mdio45_ethtool_gset_npage()
Message-ID: <ZzNUI6Hl9O9Fc5Li@shell.armlinux.org.uk>
References: <20241112105430.438491-1-alistair@alistair23.me>
 <20241112105430.438491-2-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112105430.438491-2-alistair@alistair23.me>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 12, 2024 at 08:54:30PM +1000, Alistair Francis wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The mdio45_ethtool_gset_npage() function isn't called, so let's remove
> it.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

IMHO, there is no reason this can't be rolled into patch 1. However,
if netdev maintainers are happy to apply as-is, that's also fine.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

