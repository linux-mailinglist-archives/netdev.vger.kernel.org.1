Return-Path: <netdev+bounces-40820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5843C7C8B86
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 18:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F88B20B33
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268BC1B26A;
	Fri, 13 Oct 2023 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b86OTm7/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAF219F8
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 16:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C518C433C8;
	Fri, 13 Oct 2023 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697215350;
	bh=MqC3yrRRj3UMGOPti8ERknVNqGEUu0oFiV03E0Vidv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b86OTm7/vWPz1lXdWBiZn7RcGveX1aFsvL5jmXTq2YbcyNGIbGhWA6q1/AnMGbd1N
	 IFYYegR+vc8lMskeUk8lajThoc+bo1PlPWPhNqD2fwOG3AfKYpg90Eza/kNH0uSNPW
	 Jky7Vj9783vlIkTQS3O7jJucPYVzjXAq/DJZUjUVY+A/BEROWzFLMN0GpWgbN/I8Vu
	 ImQsRWZuesvRBHjxd0H3/8ZdxSWJjJnhbYb4F5CAQ1P15D5R2lTSA+hkWwJq0LpHAe
	 Bn/6fD9G+fr9mHm/5sCM1EEe3TdFQCGEcv6U3ysqKGhpLI6CBcvRuzJ9zOUE+g+0U1
	 YdquVEXDnza8g==
Date: Fri, 13 Oct 2023 11:42:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ath10k@lists.infradead.org,
	ath11k@lists.infradead.org, ath12k@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
	Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 03/13] PCI/ASPM: Disable ASPM when driver requests it
Message-ID: <20231013164228.GA1117889@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa3386a4-c22d-6d5d-112d-f36b22cda6d3@linux.intel.com>

On Thu, Oct 12, 2023 at 01:56:16PM +0300, Ilpo Järvinen wrote:
> On Wed, 11 Oct 2023, Bjorn Helgaas wrote:
> > On Mon, Sep 18, 2023 at 04:10:53PM +0300, Ilpo Järvinen wrote:
> > > PCI core/ASPM service driver allows controlling ASPM state through
> > > pci_disable_link_state() and pci_enable_link_state() API. It was
> > > decided earlier (see the Link below), to not allow ASPM changes when OS
> > > does not have control over it but only log a warning about the problem
> > > (commit 2add0ec14c25 ("PCI/ASPM: Warn when driver asks to disable ASPM,
> > > but we can't do it")). Similarly, if ASPM is not enabled through
> > > config, ASPM cannot be disabled.
> ...

> > This disables *all* ASPM states, unlike the version when
> > CONFIG_PCIEASPM is enabled.  I suppose there's a reason, and maybe a
> > comment could elaborate on it?
> >
> > When CONFIG_PCIEASPM is not enabled, I don't think we actively
> > *disable* ASPM in the hardware; we just leave it as-is, so firmware
> > might have left it enabled.
> 
> This whole trickery is intended for drivers that do not want to have ASPM 
> because the devices are broken with it. So leaving it as-is is not really 
> an option (as demonstrated by the custom workarounds).

Right.

> > Conceptually it seems like the LNKCTL updates here should be the same
> > whether CONFIG_PCIEASPM is enabled or not (subject to the question
> > above).
> > 
> > When CONFIG_PCIEASPM is enabled, we might need to do more stuff, but
> > it seems like the core should be the same.
> 
> So you think it's safer to partially disable ASPM (as per driver's 
> request) rather than disable it completely? I got the impression that the 
> latter might be safer from what Rafael said earlier but I suppose I might 
> have misinterpreted him since he didn't exactly say that it might be safer 
> to _completely_ disable it.

My question is whether the state of the device should depend on
CONFIG_PCIEASPM.  If the driver does this:

  pci_disable_link_state(PCIE_LINK_STATE_L0S)

do we want to leave L1 enabled when CONFIG_PCIEASPM=y but disable L1
when CONFIG_PCIEASPM is unset?

I can see arguments both ways.  My thought was that it would be nice
to end up with a single implementation of pci_disable_link_state()
with an #ifdef around the CONFIG_PCIEASPM-enabled stuff because it
makes the code easier to read.

Bjorn

