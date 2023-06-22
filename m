Return-Path: <netdev+bounces-13077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF3773A189
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D641C20FE6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B36D1ED27;
	Thu, 22 Jun 2023 13:11:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51381E513
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4E6C433C8;
	Thu, 22 Jun 2023 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687439485;
	bh=au2zGNMRZ0p6Mkinx6tnYwtEJKZLBcTxo0gn++q2a74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IKOo+QuyPCVrVRWrMVroUNNmli8B0Wt3YXpe1QZ3uedC3/luxMurbAaq0eLb+o+PG
	 vdltEkhR33pKyyihbS25c+DIhJfzHwUoBwN3AtBz7IU5MkEgrDY0IJY/WRQw1IZpdA
	 9oDwFA3pWo7MtcEgNevN1dwxNqHZPLOhDmO7wPsRDnFkQW1qaIUCrAFOP21dpZRXUk
	 goPyvoxlkllSpD1g4QAMJmP8imAnEf5cGntoGsR1K70kZ0A6LVDDEorxleqf1VTZ1O
	 NDnn236BCfuTdah4A+Olf8kSsYZMb88VSNLQdD9BhBBQrh8l+ptiq18Iw8XLl0w6o/
	 hUM1lzKjjuSbg==
Date: Thu, 22 Jun 2023 08:11:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Neftin, Sasha" <sasha.neftin@intel.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>,
	Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
	linux-pci@vger.kernel.org,
	"Mushayev, Nikolay" <nikolay.mushayev@intel.com>,
	linux-kernel@vger.kernel.org, jesse.brandeburg@intel.com,
	"Edri, Michael" <michael.edri@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Eric Dumazet <edumazet@google.com>, anthony.l.nguyen@intel.com,
	linux-hardening@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Paolo Abeni <pabeni@redhat.com>,
	"Avivi, Amir" <amir.avivi@intel.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH] igc: Ignore AER reset when device is
 suspended
Message-ID: <20230622131123.GA137990@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16bcc313-a4e1-ab50-4487-c99ccf5ecdf9@intel.com>

On Thu, Jun 22, 2023 at 08:09:34AM +0300, Neftin, Sasha wrote:
> On 6/21/2023 23:43, Bjorn Helgaas wrote:
> > On Tue, Jun 20, 2023 at 08:36:36PM +0800, Kai-Heng Feng wrote:
> > > When a system that connects to a Thunderbolt dock equipped with I225,
> > > I225 stops working after S3 resume:

> > > The issue is that the PTM requests are sending before driver resumes the
> > > device. Since the issue can also be observed on Windows, it's quite
> > > likely a firmware/hardwar limitation.
> > 
> > I thought c01163dbd1b8 ("PCI/PM: Always disable PTM for all devices
> > during suspend") would turn off PTM.  Is that not working for this
> > path, or are we re-enabling PTM incorrectly, or something else?
> 
> I think we hit on the HW bug here. On some i225/6 parts, PTM requests are
> sent before SW takes ownership of the device. This patch could help.

Is there an erratum we can read?  If this is needed to work around a
hardware defect, there should be a comment in the code to that effect,
and we should have a better understanding because there may be other
scenarios (suspend/resume, hotplug, etc) that need similar changes.

(I know this patch is to work around a suspend/resume issue, but the
change is in the AER error recovery path, so it doesn't quite fit
together for me yet.)

Are you saying the NIC sends PTM requests when it doesn't have PTM
Enable set?

What exactly does it mean for "SW to take ownership of the device"?
What PCIe transaction would tell the device the SW has taken
ownership?

So far this feels kind of hand-wavey.

> > Checking pci_is_enable() in the .error_detected() callback looks like
> > a pattern that may need to be replicated in many other drivers, which
> > makes me think it may not be the best approach.
> > 
> > > So avoid resetting the device if it's not resumed. Once the device is
> > > fully resumed, the device can work normally.
> > > 
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216850
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >   drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > > index fa764190f270..6a46f886ff43 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > @@ -6962,6 +6962,9 @@ static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
> > >   	struct net_device *netdev = pci_get_drvdata(pdev);
> > >   	struct igc_adapter *adapter = netdev_priv(netdev);
> > > +	if (!pci_is_enabled(pdev))
> > > +		return 0;
> > > +
> > >   	netif_device_detach(netdev);
> > >   	if (state == pci_channel_io_perm_failure)

