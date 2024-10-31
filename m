Return-Path: <netdev+bounces-140783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12EC9B80CC
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4D9281C23
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877501BD03C;
	Thu, 31 Oct 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9Jh5sKj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555771990AE;
	Thu, 31 Oct 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394270; cv=none; b=pyU5k149zjzDdcwMdIZphyqY0h4qtle4Jccyrd2cvBJXfJoOtfvebZH2LG16DMZ86h8kG2U5PW/rQtDzeCUrkdmwip/qE9DHPnWETb2UUZ5ze/uQ2Tp7X4AIxM+AKl1/0HpRmukw1nO346Bs2VzAcMwRAlDmM7SA6W6nsQ/jX24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394270; c=relaxed/simple;
	bh=76iIYi9r6xA6vX/KYVnYOqiJXABJE4PH5Kls9Mk0HhA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eZRvkFyD82XYSy3q97y9i3kBrqPkBQpj+eV5M+vOSzR72NRN8kSNRyv6+5U8OtJUC+pIoTDsa3hlR4Lsk1PxzWtpBTBW/ICTLjraA6Oq8e8Bdb6eHKGzqG1P2JGUuAnbx1FiEg6+yHsiozkIS16cdMApbom1CINB5GjwxFdTPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9Jh5sKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22B9C4CED0;
	Thu, 31 Oct 2024 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730394269;
	bh=76iIYi9r6xA6vX/KYVnYOqiJXABJE4PH5Kls9Mk0HhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U9Jh5sKjWEqDOVKayvj3wQwuDJJY8KF5B2A8ixi/Ps8E1ZDGak7rpwREw0Hb+frDS
	 9ErlaLmaNxrHr0/EEVzIcXx+jV/DePCv4pSxHHTKytCy15uxP7wX6XVwpxeqopCrUj
	 ngkwfhz44fe+2al5EplKqBqC++32wAzrr+McXt0gYqKkuJv92uZQ4tC2wQGEhGagb+
	 k8xASwiFxc4orbWOIuuOsS1wUwIziv7rSnBABK67Bm0GXmsnTSKCNJksCj708EctuW
	 +oWIBZSgtuMB1lraiAXVnN1COw6Uu3+fTDf4LEgJ37/HI5v1BVelKl25dR7iF6yaF/
	 vG940zFG7emDA==
Date: Thu, 31 Oct 2024 12:04:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: ryazanov.s.a@gmail.com, chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, angelogioacchino.delregno@collabora.com,
	bhelgaas@google.com, corbet@lwn.net, danielwinkler@google.com,
	korneld@google.com, linasvepstas@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com, netdev@vger.kernel.org
Subject: Re: [net-next v2] net: wwan: t7xx: reset device if suspend fails
Message-ID: <20241031170428.GA1249507@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031130930.5583-1-jinjian.song@fibocom.com>

On Thu, Oct 31, 2024 at 09:09:30PM +0800, Jinjian Song wrote:
> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> > On 29.10.2024 05:46, Jinjian Song wrote:
> > > From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> > > > On 22.10.2024 11:43, Jinjian Song wrote:
> > > > > If driver fails to set the device to suspend, it means that the
> > > > > device is abnormal. In this case, reset the device to recover
> > > > > when PCIe device is offline.
> > > > 
> > > > Is it a reproducible or a speculative issue? Does the fix
> > > > recover modem from a problematic state?
> > > > 
> > > > Anyway we need someone more familiar with this hardware (Intel
> > > > or MediaTek engineer) to Ack the change to make sure we are not
> > > > going to put a system in a more complicated state.
> > > 
> > > This is a very difficult issue to replicate onece occured and fixed.
> > > 
> > > The issue occured when driver and device lost the connection. I have
> > > encountered this problem twice so far:
> > > 1. During suspend/resume stress test, there was a probabilistic D3L2
> > > time sequence issue with the BIOS, result in PCIe link down, driver
> > > read and write the register of device invalid, so suspend failed.
> > > This issue was eventually fixed in the BIOS and I was able to restore
> > > it through the reset module after reproducing the problem.
> > > 
> > > 2. During idle test, the modem probabilistic hang up, result in PCIe
> > > link down, driver read and write the register of device invalid, so
> > > suspend failed. This issue was eventually fiex in device modem firmware
> > > by adjust a certain power supply voltage, and reset modem as a workround
> > > to restore when the MBIM port command timeout in userspace applycations.
> > > 
> > > Hardware reset modem to recover was discussed with MTK, and they said
> > > that if we don't want to keep the on-site problem location in case of
> > > suspend failure, we can use the recover solution.
> > > Both the ocurred issues result in the PCIe link issue, driver can't
> > > read and writer the register of WWAN device, so I want to add this
> > > path
> > > to restore, hardware reset modem can recover modem, but using the
> > > pci_channle_offline() as the judgment is my inference.
> > 
> > Thank you for the clarification. Let me summarize what I've understood
> > from the explanation:
> > a) there were hardware (firmware) issues,
> > b) issues already were solved,
> > c) issues were not directly related to the device suspension procedure,
> > d) you want to implement a backup plan to make the modem support robust.
> > 
> > If got it right, then I would like to recommend to implement a generic
> > error handling solution for the PCIe interface. You can check this
> > document: Documentation/PCI/pci-error-recovery.rst
> 
> Yes, got it right.
> I want to identify the scenario and then recover by reset device,
> otherwise suspend failure will aways prevent the system from suspending
> if it occurs.

If a PCIe link goes down here's my understanding of what happens:

  - Writes to the device are silently dropped.

  - Reads from the device return ~0 (PCI_POSSIBLE_ERROR()).

  - If the device is in a slot and pciehp is enabled, a Data Link
    Layer State Changed interrupt will cause pciehp_unconfigure_device()
    to detach the driver and remove the pci_dev.

  - If AER is enabled, a failed access to the device will cause an AER
    interrupt.  If the driver has registered pci_error_handlers, the
    driver callbacks will be called, and based on what the driver
    returns, the PCI core may reset the device.

The pciehp and AER interrupts are *asynchronous* to link down events
and to any driver access to the device, so they may be delayed an
arbitrary amount of time.

Both interrupt paths may lead to the device being marked as "offline".
Obviously this is asynchronous with respect to the driver.

> > > > > +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
> > > > > @@ -427,6 +427,10 @@ static int __t7xx_pci_pm_suspend(struct
> > > > > pci_dev *pdev)
> > > > >       iowrite32(T7XX_L1_BIT(0), IREG_BASE(t7xx_dev) +
> > > > > ENABLE_ASPM_LOWPWR);
> > > > >       atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
> > > > >       t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
> > > > > +    if (pci_channel_offline(pdev)) {
> > > > > +        dev_err(&pdev->dev, "Device offline, reset to recover\n");
> > > > > +        t7xx_reset_device(t7xx_dev, PLDR);
> > > > > +    }

This looks like an unreliable way to detect issues.  It only works if
AER is enabled, and the device is only marked "offline" some arbitrary
length of time *after* a driver access to the device has failed.

You can't reliably detect errors on writes to the device.

You can only reliably detect errors on reads from the device by
looking for PCI_POSSIBLE_ERROR().  Obviously ~0 might be a valid value
to read from some registers, so you need device-specific knowledge to
know whether ~0 is valid or indicates an error.

If AER or DPC are enabled, the driver can be *notified* about read
errors and some write errors via pci_error_handlers, but the
notification is long after the error.

Bjorn

