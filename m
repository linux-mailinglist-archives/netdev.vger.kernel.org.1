Return-Path: <netdev+bounces-141253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D39BA370
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 02:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F576282FC8
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828681EB2F;
	Sun,  3 Nov 2024 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L13eXTFL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A227F33FE;
	Sun,  3 Nov 2024 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730597065; cv=none; b=TlfSvNYu+sizfwSwj13ZEUdC/9o7frhzW3HQZBDpigorNmi5wKSvXDGyZwB4N9ie1LpNjdySm8Hu5lAy6m65uFfDFICyWUcT75tD1uV1KW6Hfnf1w0b05Vvpg/xPXHMvZiJJemfLfIpAJyidKvnX7qoTYgpdzE+d7g+jlQL29qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730597065; c=relaxed/simple;
	bh=IrxR25PDD/o8ccdrWGoK5kOG76Uf+PHZOBqU7PmxfOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhD3LP4RYhTVXo5oFH054UB/ISTtZyPciZsS4iVI8F0YbT9c5OiI8DauvfRfrzXhgZP0346SkNnCNNVJ0bfip0YQQ2nFsNOOE7RNrX7YyQQrzIkNwW0tfzXyUp2JEKDXQ2C80BQQeyKW+ZPmkruR8mkUqDiD6AGeSX/PVUruCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L13eXTFL; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc0992560so1895324eaf.0;
        Sat, 02 Nov 2024 18:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730597063; x=1731201863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uxp0UfmCL60Fd3m2qKbpdlJKEAofjpqB2oYq88MXn/0=;
        b=L13eXTFLASC50Nhkvf22UcIhH+Yqpzszsak+zgjDJTizeMbzTyJHxDGtXqkndp7t/W
         UB5J/XIUqMn7RltIlFkrdZYpz37E1/Wm1asRxbBK+MDbUQGs5HRedoYhAmcj5mHM8Mq3
         x8Ov9Nd+k4TGdKnd+zC7UvIk8r96F6Jw7uRPcLWGd5GhQd5Iq5H49Ym95ww58TdVYhq1
         ujVY29FuM7sR2K7Lwnu7/jBt/LIQ7pHa/j1i/dwdeTVASg+O/MVxrlpPw4mHW/jl5+1t
         84jk3q2G6znxAu8hAH+ZNquhhOWGJfOMDr65564wu5CH/zv6U11rvhfU62xhtYaPWArW
         vZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730597063; x=1731201863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxp0UfmCL60Fd3m2qKbpdlJKEAofjpqB2oYq88MXn/0=;
        b=PrRUrWr7ZUCdmF6+rCNnzYJAyni9skQxjWWBuNrncWrtxHq6jKvdAQLdzPluBUQOOO
         iIyzeU1UJk5JAbc2xngZvngBIL7guXdGiZe+6RCmcl6aesROlY+xC3D+DtBgt1IrYJLy
         vua2z2J6Oi+kxgBsxTPscBMIJNZsMu/gBbGLskGj26bz1/8fGXXKLh1fDr9ti2S57F5N
         g7VpY0ToaPqEpmEewUFCSY67iHh3MVBJatDrdf7OtwpzRVAuHhNqeNqNy+sISE/blv7D
         XTDMBYjJCaN3ir6yYm7/anep/GNB+9exXb7WjaM+qSJAjDFmmjNJVV927KUNQ7UMHRex
         a8pw==
X-Forwarded-Encrypted: i=1; AJvYcCVjIGJjxW2yEK6v9VRIQjvqbeM/KzRbykq6TlF8MbLMS8PmZgpE3pfLJ6hkL5JBVC6lFn7inOKipSU=@vger.kernel.org, AJvYcCXoefT2WujP+dck2xiGgybF9RXIKPSeq18OP+jjh7oCqsV8JIgH7PB3dRLBA0/kmqIt9g+wxT45/zZVk5L8@vger.kernel.org, AJvYcCXtPmzKjz9ocDMi5j35C/Nvjb/5ZSHWrns7BiJ13asuyikChGIahFzqNH527UQQHP5ABB99K+JJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxhE8J6dudbgCM9b3VtQQ7Rg194qiFR7KI27VZipecjaYyctchV
	hDVtlXwJpvfxxHWWBai7Xvo31Xl5cpVCJMDCNi1xwwb1HVtUQBlJKhnq7axaZLgEWZmqlC189Pu
	3nyEpYUJMTXrGGveQrg21dGUZGSE=
X-Google-Smtp-Source: AGHT+IHkA/uqbEuZYTnMFlg/isXw5fHn6zLD8qPicsNST9YfPw0g6N91zDHGprQP9QF/ZJdy0tOlrdnkRHVEpJ5uXro=
X-Received: by 2002:a05:6820:1885:b0:5ee:bb2:bdd4 with SMTP id
 006d021491bc7-5ee0bb2c243mr292681eaf.1.1730597062621; Sat, 02 Nov 2024
 18:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031130930.5583-1-jinjian.song@fibocom.com> <20241031170428.GA1249507@bhelgaas>
In-Reply-To: <20241031170428.GA1249507@bhelgaas>
Reply-To: linasvepstas@gmail.com
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Sat, 2 Nov 2024 20:24:10 -0500
Message-ID: <CAHrUA36X2cMZ4WNtRO7NoLaupBNfecLLxDfSVZ4mZzbzHiDjRA@mail.gmail.com>
Subject: Re: [net-next v2] net: wwan: t7xx: reset device if suspend fails
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jinjian Song <jinjian.song@fibocom.com>, ryazanov.s.a@gmail.com, 
	chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com, 
	haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com, 
	ricardo.martinez@linux.intel.com, loic.poulain@linaro.org, 
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, angelogioacchino.delregno@collabora.com, 
	bhelgaas@google.com, corbet@lwn.net, danielwinkler@google.com, 
	korneld@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Top-post reply.

What Bjorn says is exactly right. Just one clarifying remark: When PCI
error recovery was designed, it was envisioned for high-end,
high-availability servers so that they could reset a failing device
without forcing a reboot of the OS.  Concepts like suspend/resume did
not perturb even the unconscious sleep of the engineers. Thus,
stepping through error recovery during suspend would be novel,
untested, and perhaps prone to confusion. The error recovery procedure
is trying to reset the device into a fully-powered-on,
fully-functional and connected state. This might be problematic if the
suspend has already walked half-way through power-down. The fact that
error recovery might run a very long fraction of a second after the
error is detected further complicates things. The fact that error
recovery  usually has the driver fully reinitializing the device,
including reloading the firmware, could be a problem if the firmware
is not in RAM or is sitting on a suspended block device. So it all
could be an adventure.

As to testing: I asked one of the guys in the lab how he did it, and
he said he would brush a metal wire against the PCI pins. I winced.
But I guess it's cleaner than pouring coffee on it. Later we developed
a software tool to artificially inject errors.

--linas

On Fri, Nov 1, 2024 at 8:52=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, Oct 31, 2024 at 09:09:30PM +0800, Jinjian Song wrote:
> > From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> > > On 29.10.2024 05:46, Jinjian Song wrote:
> > > > From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> > > > > On 22.10.2024 11:43, Jinjian Song wrote:
> > > > > > If driver fails to set the device to suspend, it means that the
> > > > > > device is abnormal. In this case, reset the device to recover
> > > > > > when PCIe device is offline.
> > > > >
> > > > > Is it a reproducible or a speculative issue? Does the fix
> > > > > recover modem from a problematic state?
> > > > >
> > > > > Anyway we need someone more familiar with this hardware (Intel
> > > > > or MediaTek engineer) to Ack the change to make sure we are not
> > > > > going to put a system in a more complicated state.
> > > >
> > > > This is a very difficult issue to replicate onece occured and fixed=
.
> > > >
> > > > The issue occured when driver and device lost the connection. I hav=
e
> > > > encountered this problem twice so far:
> > > > 1. During suspend/resume stress test, there was a probabilistic D3L=
2
> > > > time sequence issue with the BIOS, result in PCIe link down, driver
> > > > read and write the register of device invalid, so suspend failed.
> > > > This issue was eventually fixed in the BIOS and I was able to resto=
re
> > > > it through the reset module after reproducing the problem.
> > > >
> > > > 2. During idle test, the modem probabilistic hang up, result in PCI=
e
> > > > link down, driver read and write the register of device invalid, so
> > > > suspend failed. This issue was eventually fiex in device modem firm=
ware
> > > > by adjust a certain power supply voltage, and reset modem as a work=
round
> > > > to restore when the MBIM port command timeout in userspace applycat=
ions.
> > > >
> > > > Hardware reset modem to recover was discussed with MTK, and they sa=
id
> > > > that if we don't want to keep the on-site problem location in case =
of
> > > > suspend failure, we can use the recover solution.
> > > > Both the ocurred issues result in the PCIe link issue, driver can't
> > > > read and writer the register of WWAN device, so I want to add this
> > > > path
> > > > to restore, hardware reset modem can recover modem, but using the
> > > > pci_channle_offline() as the judgment is my inference.
> > >
> > > Thank you for the clarification. Let me summarize what I've understoo=
d
> > > from the explanation:
> > > a) there were hardware (firmware) issues,
> > > b) issues already were solved,
> > > c) issues were not directly related to the device suspension procedur=
e,
> > > d) you want to implement a backup plan to make the modem support robu=
st.
> > >
> > > If got it right, then I would like to recommend to implement a generi=
c
> > > error handling solution for the PCIe interface. You can check this
> > > document: Documentation/PCI/pci-error-recovery.rst
> >
> > Yes, got it right.
> > I want to identify the scenario and then recover by reset device,
> > otherwise suspend failure will aways prevent the system from suspending
> > if it occurs.
>
> If a PCIe link goes down here's my understanding of what happens:
>
>   - Writes to the device are silently dropped.
>
>   - Reads from the device return ~0 (PCI_POSSIBLE_ERROR()).
>
>   - If the device is in a slot and pciehp is enabled, a Data Link
>     Layer State Changed interrupt will cause pciehp_unconfigure_device()
>     to detach the driver and remove the pci_dev.
>
>   - If AER is enabled, a failed access to the device will cause an AER
>     interrupt.  If the driver has registered pci_error_handlers, the
>     driver callbacks will be called, and based on what the driver
>     returns, the PCI core may reset the device.
>
> The pciehp and AER interrupts are *asynchronous* to link down events
> and to any driver access to the device, so they may be delayed an
> arbitrary amount of time.
>
> Both interrupt paths may lead to the device being marked as "offline".
> Obviously this is asynchronous with respect to the driver.
>
> > > > > > +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
> > > > > > @@ -427,6 +427,10 @@ static int __t7xx_pci_pm_suspend(struct
> > > > > > pci_dev *pdev)
> > > > > >       iowrite32(T7XX_L1_BIT(0), IREG_BASE(t7xx_dev) +
> > > > > > ENABLE_ASPM_LOWPWR);
> > > > > >       atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
> > > > > >       t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
> > > > > > +    if (pci_channel_offline(pdev)) {
> > > > > > +        dev_err(&pdev->dev, "Device offline, reset to recover\=
n");
> > > > > > +        t7xx_reset_device(t7xx_dev, PLDR);
> > > > > > +    }
>
> This looks like an unreliable way to detect issues.  It only works if
> AER is enabled, and the device is only marked "offline" some arbitrary
> length of time *after* a driver access to the device has failed.
>
> You can't reliably detect errors on writes to the device.
>
> You can only reliably detect errors on reads from the device by
> looking for PCI_POSSIBLE_ERROR().  Obviously ~0 might be a valid value
> to read from some registers, so you need device-specific knowledge to
> know whether ~0 is valid or indicates an error.
>
> If AER or DPC are enabled, the driver can be *notified* about read
> errors and some write errors via pci_error_handlers, but the
> notification is long after the error.
>
> Bjorn



--=20
Patrick: Are they laughing at us?
Sponge Bob: No, Patrick, they are laughing next to us.

