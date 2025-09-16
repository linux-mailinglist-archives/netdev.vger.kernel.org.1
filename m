Return-Path: <netdev+bounces-223635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA1FB59C65
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 17:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0201C0346A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B023B26F28C;
	Tue, 16 Sep 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="whFW2M2q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58323D298
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037543; cv=none; b=NSiLZv+OBNsGprRk3Ymu3xsz3eLpJ9lrqpqm2YqlixqYahYs6pkYqhtKKvbykhW5a5VT7iiieXqv+4cbJESaLTgUbA45a282X0r8W6r0UxY0ND060/oRHwLDwoIA+6qNV/32P/82EdKn0XlP//DL3raZiAdD4CFdCd/I0Gma1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037543; c=relaxed/simple;
	bh=25zoFGJ/KjvyeEziS9jblooXfqbAD14YJaRScn03eOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+PYZwGZnI2YFxfypwWUumbc3D/CAb+9oCd06lyXUxaSO8T1gUlQr0DGXRWfRPGHs7TRllnSGMBUX4wMzAx1QSK1LuiwdZK3BKiOLZlFBksi/GY6A4iM3JukgKoChyrFTg116p75IN/I+IUNXkvJnP0vcx4F0RXXoAl/eid06YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=whFW2M2q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B042PuqJi9NbQLV9an/BzFEM6v9ffo05PFd6mZQihTI=; b=whFW2M2qCLM+fu1xqI1ycBdOfG
	PfdYXb7FzHlP9a1croBa32/6j4TeDPmvqbS3PiszqaRsGQX4L3zQFuSpxbZxgiaf5cfm5ikBc+HGg
	M0PgiYDmXcx9hM/uKfdpkiHubwSDo2UV8t6F0YmBO6Xkzf5UpJdFFCVCAbuJzF00SlXzOJQzK8kEG
	CadUBlqXtI+dvXkvpB0FQRclsgJuifpoUERiOlsOXvN4OzWyFnVfm8H0iFDFdFVxwShlZLyX/qL6c
	YFBxN+EjvU4D3hpF2V6gND4ChJqdTYNPEnKelG1WmrwFR+0dlL8P1QIJnI6RUEFgb7fcE8CGykwLu
	WFl4sdtA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35864)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyXs1-0000000056B-0Hor;
	Tue, 16 Sep 2025 16:45:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyXrx-000000007lt-0tMu;
	Tue, 16 Sep 2025 16:45:25 +0100
Date: Tue, 16 Sep 2025 16:45:25 +0100
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
Message-ID: <aMmGFQx5lWdXQq_j@shell.armlinux.org.uk>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
 <E1uyAP7-00000005lGq-3FqI@rmk-PC.armlinux.org.uk>
 <9d197d92-3990-4e48-aa35-87a51eccb87a@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d197d92-3990-4e48-aa35-87a51eccb87a@linux.dev>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 16, 2025 at 02:02:56PM +0100, Vadim Fedorenko wrote:
> On 15/09/2025 15:42, Russell King (Oracle) wrote:
> > the ordering of ptp_clock_unregister() is not ideal, as the chardev
> > remains published while state is being torn down. There is also no
> > cleanup of enabled pin settings, which means enabled events can
> > still forward into the core.
> > 
> > Rework the ordering of cleanup in ptp_clock_unregister() so that we
> > unpublish the posix clock (and user chardev), disable any pins that
> > have events enabled, and then clean up the aux work and PPS source.
> > 
> > This avoids potential use-after-free and races in PTP clock driver
> > teardown.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >   drivers/ptp/ptp_chardev.c | 13 +++++++++++++
> >   drivers/ptp/ptp_clock.c   | 17 ++++++++++++++++-
> >   drivers/ptp/ptp_private.h |  2 ++
> >   3 files changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> > index eb4f6d1b1460..640a98f17739 100644
> > --- a/drivers/ptp/ptp_chardev.c
> > +++ b/drivers/ptp/ptp_chardev.c
> > @@ -47,6 +47,19 @@ static int ptp_disable_pinfunc(struct ptp_clock_info *ops,
> >   	return err;
> >   }
> > +void ptp_disable_all_pins(struct ptp_clock *ptp)
> > +{
> > +	struct ptp_clock_info *info = ptp->info;
> > +	unsigned int i;
> > +
> > +	mutex_lock(&ptp->pincfg_mux);
> > +	for (i = 0; i < info->n_pins; i++)
> > +		if (info->pin_config[i].func != PTP_PF_NONE)
> > +			ptp_disable_pinfunc(info, info->pin_config[i].func,
> > +					    info->pin_config[i].chan);
> > +	mutex_unlock(&ptp->pincfg_mux);
> > +}
> > +
> 
> This part is questionable. We do have devices which have PPS out enabled
> by default. The driver reads pins configuration from the HW during PTP
> init phase and sets up proper function for pin in ptp_info::pin_config.
> 
> With this patch applied these pins have PEROUT function disabled on
> shutdown and in case of kexec'ing into a new kernel the PPS out feature
> needs to be manually enabled, and it breaks expected behavior.

Does kexec go to the trouble of unregistering PTP clocks? I don't see
any driver in drivers/ptp/ that has the .shutdown method populated.

That doesn't mean there aren't - it isn't obvious where they are or
if it does happen.

The question about whether one wants to leave the other features in
place when the driver is removed is questionable - without the driver
(or indeed without something discplining the clock) it's going to
drift, so the accuracy of e.g. the PPS signal is going to be as good
as the clock source clocking the TAI.

Having used NTP with a PPS sourced from a GPS, I'd personally want
the PPS to stop if the GPS is no longer synchronised, so NTP knows
that a fault has occurred, rather than PPS continuing but being
undiscplined and thus of unknown accuracy.

I'd suggest that whether PPS continues to be generated should be a
matter of user policy. I would suggest that policy should include
whether or not userspace is discplining the clock - in other words,
whether the /dev/ptp* device is open or not.

Consider the case where the userspace daemons get OOM-killed and
that isn't realised. The PPS signal continues to be generated but
is now unsynchronised and drifts. Yet PPS users continue to
believe it's accurate.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

