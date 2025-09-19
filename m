Return-Path: <netdev+bounces-224778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C02B89BBD
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 15:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E3D1BC53B6
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA80523C4F9;
	Fri, 19 Sep 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mU9Clp62"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A364235345
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289857; cv=none; b=gSEtC/g+G05KhnK1gVpnmQUZXRA76WvcW1+s3DLhajzO4NPDLUvYFaZby+RFQ+7thteRDr+XusmAHndvDhrphLxxAhOY4haQpmNgKy/CDmUwPmgcIJaN4+PYtNVDaUXsROkH3BwQfHCaXjKw+eyETinMBEChGFTockqiS6oBIYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289857; c=relaxed/simple;
	bh=LvHQgqqKI8uiyhvt8F7LfpVaQmq1038jLNJfI98LZJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEQ1jGf1K/u0V+4gi9iDAX9aAoVDnOMnFp6Sm3DZflHQtC+OTxe0Wwdq2M6iQ5XMEYUG7fB2sJu351Cbngnuw/DZevxek9EX8vzh7qmXPxEqQFLKq+6WvBBK++1GN1pquKrUiQ+REBlAZQ/0QZGFhNwkC1oGHhDsyUJ9w35mj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mU9Clp62; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=emOUmgGVDGYHOj6F1ohs53lJHvmaR+SDIU8VFMZnieE=; b=mU9Clp622aEgaDD5w1Adni9CKx
	Pmk59Qdeseqq91wbnDYGsHhPNo04GtFqhUZx3rcFsTOf3R1RspttKQ9IKR2peUMc+qKM4rBDkJ3t9
	QyBSybUPsMmpwxzq4tul5drxXi+WZAOcZmd5ZqXJ6hBe9yYrzZzK++UEpy5Qpzj4QTAXpOfLPdrYl
	2hOKzuj1Xs07ZdxKxvV7/wV7JZZclvaZY/S9LUYKUQ/0WT2LkThn+t9NazHwn0fOK6x1zkkjGVuWU
	QRVvnvSuE97HEtfgecAL+prcg0zVzSrjYOuL7vp92KI5uqcETM2YsIlaI9xUggVbSeQSyVPoRyitR
	eAA29s9g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33916)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uzbVi-0000000055U-2Ucf;
	Fri, 19 Sep 2025 14:50:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uzbVf-000000002Cv-37tf;
	Fri, 19 Sep 2025 14:50:47 +0100
Date: Fri, 19 Sep 2025 14:50:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 10/20] net: dsa: mv88e6xxx: only support
 EXTTS for pins
Message-ID: <aM1ft_SflOcWaCBq@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIbf-00000006n00-06XG@rmk-PC.armlinux.org.uk>
 <0a3c0715-73be-472c-8a6a-1940c75f9d53@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a3c0715-73be-472c-8a6a-1940c75f9d53@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Sep 19, 2025 at 12:29:43PM +0100, Vadim Fedorenko wrote:
> On 18/09/2025 18:39, Russell King (Oracle) wrote:
> > The sole implementation for the PTP verify/enable methods only supports
> > the EXTTS function. Move these checks into mv88e6xxx_ptp_verify() and
> > mv88e6xxx_ptp_enable(), renaming the ptp_enable() method to
> > ptp_enable_extts().
> 
> It would be great to add .supported_extts_flags as well to allow
> PTP_EXTTS_REQUEST2, take a look at changes in:
> https://lore.kernel.org/netdev/20250919103928.3ab57aa2@kmaincent-XPS-13-7390/T/#m579d718f36b2368e476eb400e235fe28f0bd03ff

Marvell DSA already supports .supported_extts_flags, and my changes
aim to do nothing to regress anything that was already supported. I
consider any such regression to be a bug when doing projects like
this.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

