Return-Path: <netdev+bounces-52121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8A7FD5D4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 12:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDEE2821C3
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 11:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA1D1CAB2;
	Wed, 29 Nov 2023 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vuzdJXag"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4715DA;
	Wed, 29 Nov 2023 03:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rqS+h/QhB+l3YOA1zOKZSiEXB38gEHQM7lW0MLULbqg=; b=vuzdJXagBK8d7m5cAmLL0Boojc
	QyyhacdZgGAZS2j6Hit5ht9BRy5aUqNw+7TaK/yQcKNNG4Gm5VsmU2C6r5zrPk/c/RODcxSIfcXY9
	t2CNXc8fL009N6jI30245Z1FtuxIezXE7Y6p60LWcBLeq4wP+NwYmJ7Hshxq4tJkyfufrqe0mCr5D
	3v1TfYbAfnmkZ8Q413fHNagFsWg0usjA/RDbJ23DsP0gt9j6dwHVt5sdiS/xpwfY+e+pSi48774LV
	HmanbcFoR+0rnLz7cQaWEEbQDX7fTJYYbgwCY+ru11YjTTU9idzi1TTVscPzF8L3jBz5lFphvE34g
	Gy9+ohPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48210)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r8IqR-0000Iz-2l;
	Wed, 29 Nov 2023 11:35:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r8IqS-0003xO-Ap; Wed, 29 Nov 2023 11:35:08 +0000
Date: Wed, 29 Nov 2023 11:35:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH net] net: stmmac: update Rx clk divider for 10M SGMII
Message-ID: <ZWch7LIqbMEaLRLW@shell.armlinux.org.uk>
References: <20231124050818.1221-1-quic_snehshah@quicinc.com>
 <ZWBo5EKjkffNOqkQ@shell.armlinux.org.uk>
 <47c9eb95-ff6a-4432-a7ef-1f3ebf6f593f@quicinc.com>
 <ZWRVz05Gb4oALDnf@shell.armlinux.org.uk>
 <3bf6f666-b58a-460f-88f5-ad8ec08bfbbc@quicinc.com>
 <ZWRp3pVv0DNsPMT7@shell.armlinux.org.uk>
 <474a8942-e22f-4899-acb9-f794d01fdfe9@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474a8942-e22f-4899-acb9-f794d01fdfe9@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 29, 2023 at 04:56:53PM +0530, Sneh Shah wrote:
> 
> 
> On 11/27/2023 3:35 PM, Russell King (Oracle) wrote:
> > On Mon, Nov 27, 2023 at 03:17:20PM +0530, Sneh Shah wrote:
> >> On 11/27/2023 2:09 PM, Russell King (Oracle) wrote:
> >>> On Mon, Nov 27, 2023 at 11:25:34AM +0530, Sneh Shah wrote:
> >>>> On 11/24/2023 2:42 PM, Russell King (Oracle) wrote:
> >>>>> The next concern I have is that you're only doing this for SPEED_10.
> >>>>> If it needs to be programmed for SPEED_10 to work, and not any of the
> >>>>> other speeds, isn't this something that can be done at initialisation
> >>>>> time? If it has to be done depending on the speed, then don't you need
> >>>>> to do this for each speed with an appropriate value?
> >>>>
> >>>> This field programming is required only for 10M speed in for SGMII mode. other speeds are agnostic to this field. Hence we are programming it always when SGMII link comes up in 10M mode. init driver data for ethqos is common for sgmii and rgmii. As this fix is specific to SGMII we can't add this to init driver data.
> >>>
> >>> I wasn't referring to adding it to driver data. I was asking whether it
> >>> could be done in the initialisation path.
> >>>
> >> No, IOMACRO block is configured post phylink up regardless of RGMII or SGMII mode. We are not updating them at driver initialization time itself.
> > 
> > What reason (in terms of the hardware) requires you to do this every
> > time you select 10M speed? Does the hardware change the value in the
> > register?
> > 
> Yes, the hardware changes the value in register every time the interface is toggled. That is the reason we have ethqos_configure_sgmii function to configure registers whenever there is link activity.

That is sufficient reason to write it each time - and it would be good
to mention this in a comment above the write in
ethqos_configure_sgmii().

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

