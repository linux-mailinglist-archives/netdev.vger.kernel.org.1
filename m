Return-Path: <netdev+bounces-235214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF2FC2D893
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607A63B712B
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF70921E0BB;
	Mon,  3 Nov 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eR/4NJOX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9992AE77
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192198; cv=none; b=GtPodpx3pIT+PsHPws9nzH5fzzuMX/viXK/FsuIu/vZwPXxf9YRBMxMKafY5YRHJAVr4vOuCqjHqALPaSCeKwtJTAzKGgd9juhaNha5g0g9w4J/lHDx7r9YEQ5oeG3nre4LrIFP+WeHfssvFoIizT2k4hBClulbAjndL94jQf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192198; c=relaxed/simple;
	bh=7zdcW5d9jh+4JO84/4GBUEUwOqkDMavOjBYDCrkf7u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONBRg8SgAxeztSv/ZLVIXZu/b9xAmuliTSube0BkIhwlRrwEdqQbDIEAqijYEww9jLdBCOB0etdF9WD7mb/e7Bu9OYd0i+w595/oVzNEsl8Y17UeK6t+BhTeBY5iloL9mAfFR7QWske8i5bm4zeh2Cyr95H2pMd7J28hhpH9XJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eR/4NJOX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CPznY0qMG3a4u78/p4m12GAOczwYD0bnZesNsrwD/RE=; b=eR/4NJOXz072d7yGBWqWBfSWM2
	NgkxmScbVm8fhRroH01uAMDHosGv9Nz0PfWpVJkZ8SgLEYEefZJFyctATs1FRmMVw7RvIPOpz1Nd4
	zjHNPeFhQDrFIQlpWpkARAb18G2RmNP18wvH60ipqJ7jkVOgRzSNSWUyTAiT3H78wFbumDWovIWB6
	CUhPzZr2OPHVczODhkLk+MmJ+KxmsMBgDxNnDlvymtskoG6O8nUqAs+mYmcU4yRr9/qb8+XFSbqf6
	s5ZwiQ8HVlOuuElmXNZlnOHm0HUTUaF88IrbPSiHWRZ/FPt3IPk7jHKM+khxAcpnTTQDTo1CgbYil
	dCPZ4BxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41272)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vFygk-000000001Ev-2Mwj;
	Mon, 03 Nov 2025 17:49:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vFygi-000000003zW-3zNo;
	Mon, 03 Nov 2025 17:49:52 +0000
Date: Mon, 3 Nov 2025 17:49:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [net-next PATCH v2 08/11] fbnic: Cleanup handling for link down
 event statistics
Message-ID: <aQjrQIl-Yo6G_kGv@shell.armlinux.org.uk>
References: <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
 <176218925451.2759873.6130399808139758934.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176218925451.2759873.6130399808139758934.stgit@ahduyck-xeon-server.home.arpa>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 03, 2025 at 09:00:54AM -0800, Alexander Duyck wrote:
> @@ -86,10 +86,10 @@ static int fbnic_stop(struct net_device *netdev)
>  {
>  	struct fbnic_net *fbn = netdev_priv(netdev);
>  
> +	fbnic_mac_free_irq(fbn->fbd);
>  	phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));
>  
>  	fbnic_down(fbn);
> -	fbnic_mac_free_irq(fbn->fbd);

This change makes no sense to me, and doesn't seem to be described in
the commit message.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

