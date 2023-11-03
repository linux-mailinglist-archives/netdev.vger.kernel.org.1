Return-Path: <netdev+bounces-45955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F227E0831
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 19:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E361C21050
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51EB20314;
	Fri,  3 Nov 2023 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FyM320pe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C66224EF
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 18:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E749C433CA;
	Fri,  3 Nov 2023 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699036417;
	bh=GCcviAr0J+IVeM1/p5MQ4ex6AHZgCCmGit6AtH3K05k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyM320peA+QJM3iwPOVx6aexI+At1jmo+xGow9tXL1dH6z/biHMdoS+afNaGl1mSa
	 H559T8yRhyt/BtwSnyLPNC+nzAAPis18jy9AaJTiXUw12ij6GM5PApK80g7lY7mcT/
	 rxtzhYNEuT14oqiJl2oi5vH8irjBNVvM2kjqmum0=
Date: Fri, 3 Nov 2023 19:33:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: Yuran Pereira <yuran.pereira@hotmail.com>, davem@davemloft.net,
	netdev@vger.kernel.org, florian.fainelli@broadcom.com,
	linux-kernel@vger.kernel.org, edumazet@google.com,
	bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Prevent out-of-bounds read/write in bcmasp_netfilt_rd
 and bcmasp_netfilt_wr
Message-ID: <2023110318-utensil-figure-eb80@gregkh>
References: <DB3PR10MB6835E073F668AD24F57AE64AE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <2023110301-purist-reputable-fab7@gregkh>
 <e3ac58b2-bb78-4364-94c0-f18c376ac132@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ac58b2-bb78-4364-94c0-f18c376ac132@broadcom.com>

On Fri, Nov 03, 2023 at 11:23:16AM -0700, Justin Chen wrote:
> 
> 
> On 11/3/23 5:57 AM, Greg KH wrote:
> > On Fri, Nov 03, 2023 at 05:57:48PM +0530, Yuran Pereira wrote:
> > > The functions `bcmasp_netfilt_rd` and `bcmasp_netfilt_wr` both call
> > > `bcmasp_netfilt_get_reg_offset` which, when it fails, returns `-EINVAL`.
> > > This could lead to an out-of-bounds read or write when `rx_filter_core_rl`
> > > or `rx_filter_core_wl` is called.
> > > 
> > > This patch adds a check in both functions to return immediately if
> > > `bcmasp_netfilt_get_reg_offset` fails. This prevents potential out-of-bounds read
> > > or writes, and ensures that no undefined or buggy behavior would originate from
> > > the failure of `bcmasp_netfilt_get_reg_offset`.
> > > 
> > > Addresses-Coverity-IDs: 1544536 ("Out-of-bounds access")
> > > Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> > > ---
> > >   drivers/net/ethernet/broadcom/asp2/bcmasp.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> > > index 29b04a274d07..8b90b761bdec 100644
> > > --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> > > +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> > > @@ -227,6 +227,8 @@ static void bcmasp_netfilt_wr(struct bcmasp_priv *priv,
> > >   	reg_offset = bcmasp_netfilt_get_reg_offset(priv, nfilt, reg_type,
> > >   						   offset);
> > > +	if (reg_offset < 0)
> > > +		return;
> > >   	rx_filter_core_wl(priv, val, reg_offset);
> > >   }
> > > @@ -244,6 +246,8 @@ static u32 bcmasp_netfilt_rd(struct bcmasp_priv *priv,
> > >   	reg_offset = bcmasp_netfilt_get_reg_offset(priv, nfilt, reg_type,
> > >   						   offset);
> > > +	if (reg_offset < 0)
> > > +		return 0;
> > 
> > Shouldn't you return an error here?
> > 
> > thanks
> > 
> > greg k-h
> 
> As long as offset is less than MAX_WAKE_FILTER_SIZE we don't need to worry
> about error checking. This is already checked before we call
> netfilt_get_reg_offset() in both cases. Instead of returning -EINVAL in
> neffilt_get_reg_offset() lets return 0. This will silence the coverity
> check. In practice we will never hit this logic.

Then don't change it, coverity is incorrect here.

greg k-h

