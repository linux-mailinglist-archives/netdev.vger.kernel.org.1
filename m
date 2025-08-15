Return-Path: <netdev+bounces-214028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F73EB27E1B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220237B29DA
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53C279DC4;
	Fri, 15 Aug 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QxMvlQ3f"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14851946A0
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253131; cv=none; b=K8QjmFxFd1YFOstI8qdPPQKErtLVemzfYCcCLsdOlOCr59S4hyGgJDQlRszCGxUssWL+jv7dUDCHkcDzzDCIg29xFBRf0oihdziYujU5eGCTScAbJ07Mo1Uv0CVweRtKTwrZH1btTFj/Lt+UO5PIAABhrHgvHln54+JqktYpK3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253131; c=relaxed/simple;
	bh=t89BDj+s6NTWdxfwmklWhPUBlzAY0DHwSTUE9wUWjIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0SUZUBKqRUAkpPXPekI+HPBkDwP+ihWH4j+u/ysAYeCX0ZDJ3CWZKPpJmkK6Rkh2vv9dC8hLXGcFMufYWevtPkliYkdi36a0ECBBmJgxOJxeW3h1s3JYBUHd3dzV4mvwo8JqlSsckG6mzxTRexR4DOmiiPCSYjRqKvnQMppGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QxMvlQ3f; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JZjx72MweuPnKMGhIqN2pESLyuEeXWe50emThtaqpd0=; b=QxMvlQ3fp6CRI9uFk5eQpYp4Et
	bEXhNVljLSvkaQXihAcsNd9+ChASTss69+qJOasWd94AlUSBmErnH5mvVZuzuteQP9boNgk5g5/5v
	19AIxoInU2tZEMEkGoPBH0jWtE3lKwqow3lPxjn3k403QKoNuVrNiPptsMIisfR1OVc6PsxmH06SH
	EOhuFunqQhf1AsUb1+/Y9VQejo3QfyrrqiyqOuaxNFjNi/79u+NKgw0S3m//GWIc6nwRsfmEuPrlJ
	4QAfmXtYTsbpM49YgoKGxO8syj9PUZYKj+9qMv9HYucii6qotC2N6BYeJGrBV7T96WVl8PGj0mhVw
	oe3Mr5ng==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40324)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1umrWA-0000ws-2s;
	Fri, 15 Aug 2025 11:18:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1umrW7-0007k7-37;
	Fri, 15 Aug 2025 11:18:35 +0100
Date: Fri, 15 Aug 2025 11:18:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Mathew McBride <matt@traverse.com.au>, netdev@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] net: pcs-lynx: 10G SFP no longer links up
Message-ID: <aJ8JezoKkgKLoRCR@shell.armlinux.org.uk>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
 <025c0ebe-5537-4fa3-b05a-8b835e5ad317@app.fastmail.com>
 <aAe94Tkf-IYjswfP@shell.armlinux.org.uk>
 <f7eac1d6-34eb-4eba-937d-c6624f9a6826@app.fastmail.com>
 <2d709754-3d4a-4803-b86f-9efa2a6bf655@app.fastmail.com>
 <6455123a-6785-4173-b145-3a1a3eb48175@leemhuis.info>
 <aJtvE_yDGDyAfA5s@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJtvE_yDGDyAfA5s@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Aug 12, 2025 at 05:42:59PM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 12, 2025 at 02:17:39PM +0200, Thorsten Leemhuis wrote:
> > Lo!
> > 
> > On 10.07.25 07:29, Mathew McBride wrote:
> > > Hi Russell,
> > > 
> > > On Wed, Apr 23, 2025, at 7:01 PM, Mathew McBride wrote:
> > >>
> > > [snip]
> > > 
> > > Just following up on this issue where directly connected SFP+ modules stopped linking up after the introduction of in-band capabilities.
> > > 
> > > The diff you provided below[1] resolved the issue. 
> > > Were you planning on submitting it as a patch? If not, I'd be happy to send it in.
> > 
> > I might be missing something, but from here it looks like it fall
> > through the cracks on Russell's side. This is nothing bad, this can
> > happen, especially during summer and thus vacation time. I'd thus say:
> > wait two or three days if this reminds him of the patch, otherwise go
> > ahead and submit it yourself to get the regression fixed.
> 
> Yes, the reminder was sent during July when I wasn't looking at email,
> and as you can imagine, if I spend three weeks on vacation, I am _not_
> going to catch up with that pile of email - if I were, there'd be no
> point taking vacation because the mental effort would be just the same
> as having no vacation.
> 
> I have been debating whether we should actually do something like this,
> especially given the issues with 2500base-X:
> 
> -       if (!phylink_validate_pcs_inband_autoneg(pl, interface,
> -                                                config.advertising)) {
> -               phylink_err(pl, "autoneg setting not compatible with PCS");
> -               return -EINVAL;
> +       while (!phylink_validate_pcs_inband_autoneg(pl, interface,
> +                                                   config.advertising)) {
> +               if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> +                             config.advertising)) {
> +                       phylink_err(pl, "autoneg setting is not compatible with PCS");
> +                       return -EINVAL;
> +               }
> +
> +               __clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, config.advertising);
>         }
> 
> which turns it into something generic - but my problem with that is..
> what if the module (e.g. a GPON module immitating a fibre module)
> requires Autoneg but the PCS doesn't support Autoneg for the selected
> interface mode.

Please note that I'm waiting for a response from those who have the
problem... and this thread is again getting buried, so likely I'll
forget about it soon.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

