Return-Path: <netdev+bounces-201268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E81EAE8B3B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BE818853E3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B82E336E;
	Wed, 25 Jun 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu0hILu7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEBA824A3
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870764; cv=none; b=ocqz3Ia808SJJj2ho+FygbiBASQ9/ByNFMYxXdM6CT2kN6ciw8wKYLehWGENloSSHhwAX9PUpPPzxvA3bnvb0L2nYUKPRIwIoyXqlcopMjUtV9y2Tn8QyEVZj/0yv2daz3eG+SDooS8gBpYxg68zO2zz2KZL3hXCo1785BJN8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870764; c=relaxed/simple;
	bh=pFRjNrpo+tIQ27BYNZPDws6vncXdAOAd1PFWb6VvhnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0t9DRn83KV1gsJUwHgZwRuvKbWtU23rRonR6NFMek5trimppF8IMl51Rj2ijNHadpWUd7CjW/6klG2/O3GijvtXc47fiagLl3NnOM31TOS4VDwBpPeVqfj6M8oV83TliEIio+1Kqm2JL+H8pZk6LYTwSX6iJRHB4JGabhvks7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu0hILu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC53C4CEEA;
	Wed, 25 Jun 2025 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750870764;
	bh=pFRjNrpo+tIQ27BYNZPDws6vncXdAOAd1PFWb6VvhnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iu0hILu7P9YQK0Xv6oZQbaFJ1CJLHfliEqk6Cw0PIh40VPeukslPzqqviP5nr5Rj3
	 GePI914lIrTE98C1B5NTpXGAoOH2wlGhseR0HmLtUam0nD6fqlSb9iABTGCp+i1e5C
	 pufw4a9QPtLMjTKNKokHZ2C6eocqVgk1E7jlehZp+otCSisHMEKO1KEm7fyYntTsaZ
	 T9Bph+V8xQkiKvRaRNeHfiRDNGbwN0PhxpACBm+BCDJf/Xje3RJOiW7JVwly54mO/e
	 URphqk/Zz8J/Yq3xvw5WI0wOx+rSHLSINZdcJroErzrt68fktAeu0gd8r4wCEpKkah
	 hbZpl82Kp++OA==
Date: Wed, 25 Jun 2025 17:59:20 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net] net: txgbe: fix the issue of TX failture
Message-ID: <20250625165920.GH1562@horms.kernel.org>
References: <9E4DB1BA09214DE5+20250624093021.273868-1-jiawenwu@trustnetic.com>
 <20250625093540.GK1562@horms.kernel.org>
 <031701dbe5b6$b3a2c880$1ae85980$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <031701dbe5b6$b3a2c880$1ae85980$@trustnetic.com>

On Wed, Jun 25, 2025 at 05:51:19PM +0800, Jiawen Wu wrote:
> On Wed, Jun 25, 2025 5:36 PM, Simon Horman wrote:
> > On Tue, Jun 24, 2025 at 05:30:21PM +0800, Jiawen Wu wrote:
> > > There is a occasional problem that ping is failed between AML devices.
> > > That is because the manual enablement of the security Tx path on the
> > > hardware is missing, no matter what its previous state was.
> > >
> > > Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
> > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > 
> > nit: failure is misspelt in the subject
> 
> Thanks. :)
> 
> > 
> > > ---
> > >  drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > > index 7dbcf41750c1..dc87ccad9652 100644
> > > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > > @@ -294,6 +294,7 @@ static void txgbe_mac_link_up_aml(struct phylink_config *config,
> > >  	wx_fc_enable(wx, tx_pause, rx_pause);
> > >
> > >  	txgbe_reconfig_mac(wx);
> > > +	txgbe_enable_sec_tx_path(wx);
> > >
> > >  	txcfg = rd32(wx, TXGBE_AML_MAC_TX_CFG);
> > >  	txcfg &= ~TXGBE_AML_MAC_TX_CFG_SPEED_MASK;
> > 
> > Hi Jiawen,
> > 
> > I am unsure if it is important, but I notice that:
> > 
> > * txgbe_mac_link_up_aml is the mac_link_up callback for txgbe_aml
> > 
> > * Whereas for txgbe_phy txgbe_enable_sec_tx_path() is called in
> >   txgbe_mac_finish(), which is the mac_finish callback
> > 
> > Could you comment on this asymmetry?
> 
> For txgbe_sp, the configuration of PCS is completed in the driver.
> Disable sec_tx_path -> configure PCS -> enable sec_tx_path, it is
> the necessary sequence. So these MAC operations were added in
> txgbe_mac_prepare() and txgbe_mac_finish().
> 
> For txgbe_aml, the configuration of PCS is completed in the firmware.
> So I didn't implement .mac_prepare and .mac_finish.

Thanks, that seems reasonable to me.

Reviewed-by: Simon Horman <horms@kernel.org>


