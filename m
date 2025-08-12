Return-Path: <netdev+bounces-213030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7791B22E3E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7CC3AB802
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152A2FABEB;
	Tue, 12 Aug 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kfhWBQqZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41CC2F6571
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016988; cv=none; b=p5/hmbm0hknK+j/8mPsYEauy2qKnUfVyzSNo+jLB07k9/CA2onaKALXbHSYHKZsLoWd/Vlcy6x7avyPA4L0cRndrtpZnXC2/TeygWPvoqz/uWyRvi/fdLcjZIistEBFt0biN7lMWs+utgXDXVOAXNffqPuDEbrm61UiUJTcSBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016988; c=relaxed/simple;
	bh=rNklaZMueT+v27Ov69dqYSVlLrIQvetOKvOQFwh8GeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbsD/fTOq7rBg96VPOG3BAElTLbpODNN4Gt5YnE19+u2kkbuOKArD848zcqyv86KCxdI2FOCEq3hfWB5kUDvCMQ10Ou/9dysjM9yuT4I/2E3dZxzlXFUblleiZ5Dh7pnGDikvIvlNM/g9V/jCo6Vqxf2BSORKZbR6uwMQWFgeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=kfhWBQqZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HaZjQbWUAKXEQCsbLdt9JaCOKOTTSoOuPgHhR/KNJDg=; b=kfhWBQqZvWMUTgbRT2unlRsmnh
	u33Pq7UXLgrkIAcdFuBzQld1InEEqy7O674wexX12wm8xa/HobelOuhvxtZ+1KqAIG/iUW6AFH8Jj
	0TZy0KN9ab2zLfIaPT6BVexYGan7zxdSgMCVSEetsPtGYbfR1gnfFZwAW3Wf0lZLnqoev1tMI1j4M
	82Vb8uFvOCRZFSce2TwDBezORxCP37DWoBj2c0i3ZRw/UQb2KzXRouwv1XHnz1fi9cJu9nWWOkb+5
	SfZ1ViwkrgasRyp92bAktxQTDwOJRS4Uld0hTJLcY6wbKIVPkjQdKLRMHen7S4xcuPrlVPYdxcrSH
	/K5+tSzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39140)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uls5W-0005H9-0H;
	Tue, 12 Aug 2025 17:43:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uls5T-0004rV-23;
	Tue, 12 Aug 2025 17:42:59 +0100
Date: Tue, 12 Aug 2025 17:42:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Mathew McBride <matt@traverse.com.au>, netdev@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] net: pcs-lynx: 10G SFP no longer links up
Message-ID: <aJtvE_yDGDyAfA5s@shell.armlinux.org.uk>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
 <025c0ebe-5537-4fa3-b05a-8b835e5ad317@app.fastmail.com>
 <aAe94Tkf-IYjswfP@shell.armlinux.org.uk>
 <f7eac1d6-34eb-4eba-937d-c6624f9a6826@app.fastmail.com>
 <2d709754-3d4a-4803-b86f-9efa2a6bf655@app.fastmail.com>
 <6455123a-6785-4173-b145-3a1a3eb48175@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6455123a-6785-4173-b145-3a1a3eb48175@leemhuis.info>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Aug 12, 2025 at 02:17:39PM +0200, Thorsten Leemhuis wrote:
> Lo!
> 
> On 10.07.25 07:29, Mathew McBride wrote:
> > Hi Russell,
> > 
> > On Wed, Apr 23, 2025, at 7:01 PM, Mathew McBride wrote:
> >>
> > [snip]
> > 
> > Just following up on this issue where directly connected SFP+ modules stopped linking up after the introduction of in-band capabilities.
> > 
> > The diff you provided below[1] resolved the issue. 
> > Were you planning on submitting it as a patch? If not, I'd be happy to send it in.
> 
> I might be missing something, but from here it looks like it fall
> through the cracks on Russell's side. This is nothing bad, this can
> happen, especially during summer and thus vacation time. I'd thus say:
> wait two or three days if this reminds him of the patch, otherwise go
> ahead and submit it yourself to get the regression fixed.

Yes, the reminder was sent during July when I wasn't looking at email,
and as you can imagine, if I spend three weeks on vacation, I am _not_
going to catch up with that pile of email - if I were, there'd be no
point taking vacation because the mental effort would be just the same
as having no vacation.

I have been debating whether we should actually do something like this,
especially given the issues with 2500base-X:

-       if (!phylink_validate_pcs_inband_autoneg(pl, interface,
-                                                config.advertising)) {
-               phylink_err(pl, "autoneg setting not compatible with PCS");
-               return -EINVAL;
+       while (!phylink_validate_pcs_inband_autoneg(pl, interface,
+                                                   config.advertising)) {
+               if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+                             config.advertising)) {
+                       phylink_err(pl, "autoneg setting is not compatible with PCS");
+                       return -EINVAL;
+               }
+
+               __clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, config.advertising);
        }

which turns it into something generic - but my problem with that is..
what if the module (e.g. a GPON module immitating a fibre module)
requires Autoneg but the PCS doesn't support Autoneg for the selected
interface mode.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

