Return-Path: <netdev+bounces-125364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FFC96CE78
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7C41F22267
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 05:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3A4188A0E;
	Thu,  5 Sep 2024 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TnLmjDpp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155279E1;
	Thu,  5 Sep 2024 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725514424; cv=none; b=oMhs3r/LXmkY28qTEbv9y5+ZD/xvpEsafm8N1964hA0mm0BHnaVPDZQApzCH4caMNTn2/Mlae0Wi1YG37oM3hQfmI/Izx0EFEnQi7RCSITiCc0O8T/fVBToiARMoEdszztF9bab0Kaln/Lm+0z77PD3aNqqScBO0HAi0Ap84bw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725514424; c=relaxed/simple;
	bh=CsWHcRdoYmg6aLV3Ma31jANgcplCQs4Q7lj5zKp/Rcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlyEhKFZhUWLc610LF89zEQvmEpRhmYWa98wBPWzYY+S5zKiW4zfv3roee410syOTCGiXlRLRKnXfJ8k5yg5pBYcGCPKJq0NjkGctD3t8JxvB1NI2UUkRWQyfYGgeAeLZeBPgjvRNvybnNIypB2imSmlN1CuhfeHsJKqv7piMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TnLmjDpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A01CC4CEC4;
	Thu,  5 Sep 2024 05:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725514424;
	bh=CsWHcRdoYmg6aLV3Ma31jANgcplCQs4Q7lj5zKp/Rcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnLmjDpp5o8PIdqKiUEkd3nxhkzswsmlv6EyhDnkR5R8t55yta2eiTCDMb82/lmwT
	 l0luclt5//WiiD48r4k9K43VXGMNxM8pqX92X4gKQrB2xJFNPruwF1Ma9hawDU0nSL
	 oILipcCCgH+08f5Iu3J2sNYzuPdCUOeRgT25N6jw=
Date: Thu, 5 Sep 2024 07:33:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Timur Tabi <timur@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v4 2/2] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
Message-ID: <2024090548-riverbank-resemble-6590@gregkh>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-2-4180e1d5a244@quicinc.com>
 <2024090521-finch-skinny-69bc@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024090521-finch-skinny-69bc@gregkh>

On Thu, Sep 05, 2024 at 07:29:10AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 05, 2024 at 08:36:10AM +0800, Zijun Hu wrote:
> > From: Zijun Hu <quic_zijuhu@quicinc.com>
> > 
> > To prepare for constifying the following old driver core API:
> > 
> > struct device *device_find_child(struct device *dev, void *data,
> > 		int (*match)(struct device *dev, void *data));
> > to new:
> > struct device *device_find_child(struct device *dev, const void *data,
> > 		int (*match)(struct device *dev, const void *data));
> > 
> > The new API does not allow its match function (*match)() to modify
> > caller's match data @*data, but emac_sgmii_acpi_match() as the old
> > API's match function indeed modifies relevant match data, so it is not
> > suitable for the new API any more, solved by using device_for_each_child()
> > to implement relevant finding sgmii_ops function.
> > 
> > By the way, this commit does not change any existing logic.
> > 
> > Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> > ---
> >  drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> > index e4bc18009d08..29392c63d115 100644
> > --- a/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> > +++ b/drivers/net/ethernet/qualcomm/emac/emac-sgmii.c
> > @@ -293,6 +293,11 @@ static struct sgmii_ops qdf2400_ops = {
> >  };
> >  #endif
> >  
> > +struct emac_match_data {
> > +	struct sgmii_ops **sgmii_ops;
> > +	struct device *target_device;
> > +};
> > +
> >  static int emac_sgmii_acpi_match(struct device *dev, void *data)
> >  {
> >  #ifdef CONFIG_ACPI
> > @@ -303,7 +308,7 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
> >  		{}
> >  	};
> >  	const struct acpi_device_id *id = acpi_match_device(match_table, dev);
> > -	struct sgmii_ops **ops = data;
> > +	struct emac_match_data *match_data = data;
> >  
> >  	if (id) {
> >  		acpi_handle handle = ACPI_HANDLE(dev);
> > @@ -324,10 +329,12 @@ static int emac_sgmii_acpi_match(struct device *dev, void *data)
> >  
> >  		switch (hrv) {
> >  		case 1:
> > -			*ops = &qdf2432_ops;
> > +			*match_data->sgmii_ops = &qdf2432_ops;
> > +			match_data->target_device = get_device(dev);
> >  			return 1;
> >  		case 2:
> > -			*ops = &qdf2400_ops;
> > +			*match_data->sgmii_ops = &qdf2400_ops;
> > +			match_data->target_device = get_device(dev);
> 
> Where is put_device() now called?

Nevermind, I see it now.

That being said, this feels wrong still, why not just do this "set up
the ops" logic _after_ you find the device and not here in the match
function?

thanks,

greg k-h

