Return-Path: <netdev+bounces-96125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F88C4656
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28FF1F24C89
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C7422331;
	Mon, 13 May 2024 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Pb2uO5Dg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6AC2E631;
	Mon, 13 May 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622110; cv=none; b=XmLDvcWeDLujTKIQ8gi+DkWNEweyYzHi1v1ojk/yLNv2lQGCB8a4a1CRMbDE2w+mjtSLAsypwogf8eMsyS4ih5ALlNp30X1BlCOugRZ38U9b6+LN6dckklLnajOCrHyVEcRcOy1YoIZLiVf177fld/4F5cI/YykiBTBGLFEBHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622110; c=relaxed/simple;
	bh=J95ZIj5DQY4xsPzzP3zbUWueHNVgzry7B1maNkLWf0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAEv+OGMObVcmhh6E4ZsOKcYy6Zmv3KK12XjrrfbT+ptLjBWNN3fHxYG1pqqKNb+wgOS4UmX5JtidKNF7dIM+SBEWdF/Mtsx1UxkNcKGbmWi9ObbcjgDmUUG23J265CE1lxgFUeQhYHw3FNFyGi792hjIGfSw/pOqPFZJQeXvSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Pb2uO5Dg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z0WT9I02yh5cFXXMMJOdCfqjrNnWp6CwWdTqqwOw/vY=; b=Pb2uO5DgiupsjtJj1PwMPpOgm5
	WZhPvQiyWo4uSZ7UtYyeh4O1y8ib7T0hXwGVGDlSdGwKWQnpE8JsM1unseo3YMCwKC+VlNyD4t/3N
	4Xht1YsPG2UnomW3i9UpBQL546OD8bsh0Xa6+auznj5rD4R6LZNtxltwo03Ia+OV1LmybTAcMEtgM
	24P/cSLTzADDxs3z8eYLruxYKBy8ZNK0AMS8lUxjdys44+XxBhujsFYIZUJvzqckRagbEjEhmMDDe
	1ffE1atNHrKH91hQxG2hmCIm9/1yihuWWs0ytfMF3KxPYnqRHXNPBVcxi9xdrv81gn4BXha+hfBrJ
	ZlST7+Uw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50092)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s6ZgA-00028n-20;
	Mon, 13 May 2024 18:41:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s6Zg8-0006I4-5m; Mon, 13 May 2024 18:41:36 +0100
Date: Mon, 13 May 2024 18:41:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X
 SoC
Message-ID: <ZkJQz9u8pQ9YmM5n@shell.armlinux.org.uk>
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com>
 <Zj/IPpub11OL3jBo@shell.armlinux.org.uk>
 <CAMdnO-KCC0qXEsE1iDGNZwdd0PAcsRinmxe8_-5Anp=e1c5WFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdnO-KCC0qXEsE1iDGNZwdd0PAcsRinmxe8_-5Anp=e1c5WFA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 13, 2024 at 10:38:46AM -0700, Jitendra Vegiraju wrote:
> Thanks for reviewing the patch.
> On Sat, May 11, 2024 at 12:34 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> > As pointed out in the other sub-thread, you don't need this. If you need
> > a fixed-link and you don't have a firmware description of it, you can
> > provide a swnode based description through plat->port_node that will be
> > passed to phylink. Through that, you can tell phylink to create a
> > fixed link.
> >
> Thank you for the pointers or software node support.
> Since the driver is initially targetted for X86/_64, we were not sure
> how to deal with lack of OF support.
> We will try out the software node facility.

You may wish to have a look at drivers/net/ethernet/wangxun/ which
also creates software nodes for phylink.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

