Return-Path: <netdev+bounces-223706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A97B5A197
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F407A5920
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 19:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E592C1DED49;
	Tue, 16 Sep 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nAccP1lb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600841E98F3
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052011; cv=none; b=RZAQkoFcTV+bL9sxC4RsAOuhmfUCLJKO/Vl0tm0bPu3dHpr3UGALEOIdHfl04BWimFhFOqek42QG2wIbJqF55nBF2jJvUEkYqMdbQQgX0t2poyMCYqqZxLT5nCEp57fcudFOY0VYOiswH8VueKjoKvQswegggbwFBDaNOgZJsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052011; c=relaxed/simple;
	bh=hjlbGMnEdQXqboDffiNNcDlFplfeyLWIkEw8DiKHx9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyswCXsUQeQtAtJV9kpLDsQKsQ2Zzv7BgkmFTBfRH6WKRdv7aHHZ8SHCvFiZ+vy2LRe9Kkf7auLT/kwnffzQf7NPauCAmlouLILk6NFgtr68PPLvreTNhFALQqHmDHVb5Li9/ch78lvNE/J2+AvkDfDzl1zpuxmHx4zjuo+pMAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nAccP1lb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/27pgnXaxIMKYeUlTcrehHP6JdCeXAiWGCDPpMyW0lg=; b=nAccP1lb2LDc7Keqz0AMVRrvmF
	Q9OcEgQcmx9XZL6UEqiOpDZalAnS10VBojLI9MZyz74jOBacmy8uAtnYvUgb7F+ASiV6+XdIVSHkO
	sWEK3eMqWFIuAPhNwl3ZqvmWplVfQw4n3dRbCaRHzYYL6Q5trhMhPhy8Ljtckb2Zb0UkxzYyOP62g
	R5Dd0o/BWCPfci0MX4bT1+Cgx6ENnnXrf6t37W/P51SJPwuvT67d2gFJM68NqneUzgKv5XbCJUSiV
	0xOVX2/itEpKrIlRElcMDpk13vA5vbkM5X5c8K/IzL+cx5NcrCc5VsGvraYI7hJqfwK6edrXoiUae
	30vJ6DlA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58378)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uybdJ-000000005v5-3cqm;
	Tue, 16 Sep 2025 20:46:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uybdE-000000007uU-0aRN;
	Tue, 16 Sep 2025 20:46:28 +0100
Date: Tue, 16 Sep 2025 20:46:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Dumazet <edumazet@google.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
	Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH net-next 2/2] ptp: rework ptp_clock_unregister() to
 disable events
Message-ID: <aMm-k47VdNlGP84m@shell.armlinux.org.uk>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
 <E1uyAP7-00000005lGq-3FqI@rmk-PC.armlinux.org.uk>
 <9d197d92-3990-4e48-aa35-87a51eccb87a@linux.dev>
 <aMmGFQx5lWdXQq_j@shell.armlinux.org.uk>
 <b6e0d1e5-bd50-464a-9eae-05ecd11de4ee@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e0d1e5-bd50-464a-9eae-05ecd11de4ee@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 16, 2025 at 05:20:19PM +0100, Vadim Fedorenko wrote:
> On 16/09/2025 16:45, Russell King (Oracle) wrote:
> > On Tue, Sep 16, 2025 at 02:02:56PM +0100, Vadim Fedorenko wrote:
> > > On 15/09/2025 15:42, Russell King (Oracle) wrote:
> > > > the ordering of ptp_clock_unregister() is not ideal, as the chardev
> > > > remains published while state is being torn down. There is also no
> > > > cleanup of enabled pin settings, which means enabled events can
> > > > still forward into the core.
> > > > 
> > > > Rework the ordering of cleanup in ptp_clock_unregister() so that we
> > > > unpublish the posix clock (and user chardev), disable any pins that
> > > > have events enabled, and then clean up the aux work and PPS source.
> > > > 
> > > > This avoids potential use-after-free and races in PTP clock driver
> > > > teardown.
> > > > 
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > ---
> > > >    drivers/ptp/ptp_chardev.c | 13 +++++++++++++
> > > >    drivers/ptp/ptp_clock.c   | 17 ++++++++++++++++-
> > > >    drivers/ptp/ptp_private.h |  2 ++
> > > >    3 files changed, 31 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> > > > index eb4f6d1b1460..640a98f17739 100644
> > > > --- a/drivers/ptp/ptp_chardev.c
> > > > +++ b/drivers/ptp/ptp_chardev.c
> > > > @@ -47,6 +47,19 @@ static int ptp_disable_pinfunc(struct ptp_clock_info *ops,
> > > >    	return err;
> > > >    }
> > > > +void ptp_disable_all_pins(struct ptp_clock *ptp)
> > > > +{
> > > > +	struct ptp_clock_info *info = ptp->info;
> > > > +	unsigned int i;
> > > > +
> > > > +	mutex_lock(&ptp->pincfg_mux);
> > > > +	for (i = 0; i < info->n_pins; i++)
> > > > +		if (info->pin_config[i].func != PTP_PF_NONE)
> > > > +			ptp_disable_pinfunc(info, info->pin_config[i].func,
> > > > +					    info->pin_config[i].chan);
> > > > +	mutex_unlock(&ptp->pincfg_mux);
> > > > +}
> > > > +
> > > 
> > > This part is questionable. We do have devices which have PPS out enabled
> > > by default. The driver reads pins configuration from the HW during PTP
> > > init phase and sets up proper function for pin in ptp_info::pin_config.
> > > 
> > > With this patch applied these pins have PEROUT function disabled on
> > > shutdown and in case of kexec'ing into a new kernel the PPS out feature
> > > needs to be manually enabled, and it breaks expected behavior.
> > 
> > Does kexec go to the trouble of unregistering PTP clocks? I don't see
> > any driver in drivers/ptp/ that has the .shutdown method populated.
> > 
> > That doesn't mean there aren't - it isn't obvious where they are or
> > if it does happen.
> 
> That's part of mlx5 and at least Intel's igc and igb drivers.
> 
> > The question about whether one wants to leave the other features in
> > place when the driver is removed is questionable - without the driver
> > (or indeed without something discplining the clock) it's going to
> > drift, so the accuracy of e.g. the PPS signal is going to be as good
> > as the clock source clocking the TAI.
> 
> In our use-case we use PPS out as an input to the external monitoring
> and we would like to see the PPS signal to drift in case of any errors.
> 
> > Having used NTP with a PPS sourced from a GPS, I'd personally want
> > the PPS to stop if the GPS is no longer synchronised, so NTP knows
> > that a fault has occurred, rather than PPS continuing but being
> > undiscplined and thus of unknown accuracy.
> > 
> > I'd suggest that whether PPS continues to be generated should be a
> > matter of user policy. I would suggest that policy should include
> > whether or not userspace is discplining the clock - in other words,
> > whether the /dev/ptp* device is open or not.
> 
> The deduction based on the amount of references to ptp device is not
> quite correct. Another option is to introduce another flag and use it
> as a signal to remove the function in case of error/shutdown/etc.
> > Consider the case where the userspace daemons get OOM-killed and
> > that isn't realised. The PPS signal continues to be generated but
> > is now unsynchronised and drifts. Yet PPS users continue to
> > believe it's accurate.
> 
> And again, there is another use-case which actually needs thisunsynchronised
> signal

For my use case (Marvell platforms) we only support EXTTS there, so I'm
happy to restrict this behaviour to EXTTS. If drivers need e.g. timers
or workqueues to support the other pin functions, then this will need
to be revisited so they can safely tear down their software resources.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

