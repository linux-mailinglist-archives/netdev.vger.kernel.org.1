Return-Path: <netdev+bounces-242810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2076AC95042
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 15:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10F124E0303
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5A221F11;
	Sun, 30 Nov 2025 14:36:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.blochl.de (mail.blochl.de [151.80.40.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC91373;
	Sun, 30 Nov 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.40.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764513388; cv=none; b=eV2qMXy2cmZ0ybsN8VrOe3X6k+QJPO2isdaN41LwDdC41uLVRFAFxg4kOAsx7FxkOVAFPuec0eXTvcuhFxhKS+Jvqmrfbyzz0AqxcXmII/t+p9fVWZKWvjXj8hMEWaepnuHyyyzw3+NzBgFnWn4N0U9213fMPp32XsN3ouUtIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764513388; c=relaxed/simple;
	bh=XmnQM8sZ9HzvhVQ5Q3tBbO/m5wUKCrvEKKj3bunjzJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVQ/6u7LyoXih7qoYGMIcelcNZY4zVejn4zvofSuziA1rRWC0lU6AQ7u8wqlSzj1o42uFrkAg/g9ch09sK4dnOxqAjtBkevbZb7abeHopwv3HCHDqV2T32K2y30DWT9ZhjaEgLr47g9ny7QKwluRtkHkz1p4s2uIDyVZXuclWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de; spf=pass smtp.mailfrom=blochl.de; arc=none smtp.client-ip=151.80.40.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blochl.de
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.blochl.de 446E14641E8A
Authentication-Results: mail.blochl.de; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: mail.blochl.de; spf=fail smtp.mailfrom=blochl.de
Received: from WorkKnecht (ppp-93-104-7-227.dynamic.mnet-online.de [93.104.7.227])
	by smtp.blochl.de (Postfix) with ESMTPSA id 446E14641E8A;
	Sun, 30 Nov 2025 14:28:39 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at 449b6f9d6baf
Date: Sun, 30 Nov 2025 15:28:35 +0100
From: Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Markus =?utf-8?Q?Bl=C3=B6chl?= <markus.bloechl@ipetronik.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i40e: fix ptp time increment while link is down
Message-ID: <zmw3whfzcipegeyxpydgctio62q3vlpktddhidu4lskffgr3uk@irzoprznarmd>
References: <20251119-i40e_ptp_link_down-v1-1-b351fed254b3@blochl.de>
 <5b824df7-205e-4356-a33b-9937a1367517@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b824df7-205e-4356-a33b-9937a1367517@intel.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (smtp.blochl.de [0.0.0.0]); Sun, 30 Nov 2025 14:28:39 +0000 (UTC)

On Tue, Nov 25, 2025 at 02:48:20PM -0800, Tony Nguyen wrote:
> 
> 
> On 11/19/2025 8:09 AM, Markus Blöchl wrote:
> > When an X710 ethernet port with an active ptp daemon (like the ptp4l and phc2sys combo)
> > suddenly loses its link and regains it after a while, the ptp daemon has a hard time
> > to recover synchronization and sometimes entirely fails to do so.
> > 
> > The issue seems to be related to a wrongly configured increment while the link is down.
> > This could not be observed with the Intel reference driver. We identified the fix to appear in
> > Intels official ethernet-linux-i40e release version 2.17.4.
> > 
> > Include the relevant changes in the kernel version of this driver.
> > 
> > Fixes: beb0dff1251d ("i40e: enable PTP")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Markus Blöchl <markus@blochl.de>
> > ---
> 
> ...
> 
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > @@ -847,6 +847,65 @@ void i40e_ptp_rx_hwtstamp(struct i40e_pf *pf, struct sk_buff *skb, u8 index)
> >   	i40e_ptp_convert_to_hwtstamp(skb_hwtstamps(skb), ns);
> >   }
> > +/**
> > + * i40e_ptp_get_link_speed_hw - get the link speed
> > + * @pf: Board private structure
> > + *
> > + * Calculate link speed depending on the link status.
> > + * Return the link speed.
> 
> Can you make this 'Return:' to conform with kdoc expectations?
> 
> > + **/
> > +static enum i40e_aq_link_speed i40e_ptp_get_link_speed_hw(struct i40e_pf *pf)
> > +{
> > +	bool link_up = pf->hw.phy.link_info.link_info & I40E_AQ_LINK_UP;
> > +	enum i40e_aq_link_speed link_speed = I40E_LINK_SPEED_UNKNOWN;
> > +	struct i40e_hw *hw = &pf->hw;
> > +
> > +	if (link_up) {
> > +		struct i40e_link_status *hw_link_info = &hw->phy.link_info;
> > +
> > +		i40e_aq_get_link_info(hw, true, NULL, NULL);
> > +		link_speed = hw_link_info->link_speed;
> > +	} else {
> > +		enum i40e_prt_mac_link_speed prtmac_linksta;
> > +		u64 prtmac_pcs_linksta;
> > +
> > +		prtmac_linksta = (rd32(hw, I40E_PRTMAC_LINKSTA(0))
> > +			& I40E_PRTMAC_LINKSTA_MAC_LINK_SPEED_MASK)
> > +			>> I40E_PRTMAC_LINKSTA_MAC_LINK_SPEED_SHIFT;
> 
> I believe operators are supposed to end the line rather than start a new
> one.
> 
> > +		if (prtmac_linksta == I40E_PRT_MAC_LINK_SPEED_40GB) {
> > +			link_speed = I40E_LINK_SPEED_40GB;
> > +		} else {
> > +			i40e_aq_debug_read_register(hw,
> > +						    I40E_PRTMAC_PCS_LINK_STATUS1(0),
> > +						    &prtmac_pcs_linksta,
> > +						    NULL);
> > +
> > +			prtmac_pcs_linksta = (prtmac_pcs_linksta
> > +			& I40E_PRTMAC_PCS_LINK_STATUS1_LINK_SPEED_MASK)
> > +			>> I40E_PRTMAC_PCS_LINK_STATUS1_LINK_SPEED_SHIFT;
> 
> Same operator comment. Also, indentation looks off here.
> 
> Thanks,
> Tony
> 

Thanks for the close look, Tony.
Will be fixed in v2.
I needed a reason to reroll anyway, since I forgot to base this on
net...

-- 

