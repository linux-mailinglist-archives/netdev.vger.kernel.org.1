Return-Path: <netdev+bounces-42372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4A17CE7E7
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DE11C20A2A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C5045F6E;
	Wed, 18 Oct 2023 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXNtZvjS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FE34CED
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 19:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A266C433C8;
	Wed, 18 Oct 2023 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697658043;
	bh=AD3gKmA3hIb2CpgWMPjROlXy43PEK8I1C4nkD2KEPYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nXNtZvjSVJ0+N4K/wRvKKR32rNV4dUJoj3iX+UvQ+4bRlHwaBla5TvrVJIvbIkQb0
	 icTKuw1pmSqwVqyA/IFL4IZvFawPotYbF5NGKi3okW92Uhyk2KY4GsbIXN82yLyZ4F
	 5le9V2n8TTCJpMJBcSIGb6fXaH/pxga6Ofxz4zC1KJb7TZitsvWmLwMY5PrRgdNjnx
	 r7q+Vm2X2zZ/4KjFHRb7jEKPO7a/IaxBAYZnpbMoHNrVmUjW0Rdewq/krANyk2wg7M
	 I0WuRfcDRxp5qm/XXD7Eqyh5C+ErmRzr/UWV8YCzi87tJSaaLw+y4jD2yWYG1dnx1k
	 sWFgfiPVZM0AA==
Date: Wed, 18 Oct 2023 14:40:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	bhelgaas@google.com, alex.williamson@redhat.com, lukas@wunner.de,
	petrm@nvidia.com, jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 04/12] PCI: Add no PM reset quirk for NVIDIA
 Spectrum devices
Message-ID: <20231018194041.GA1370549@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017074257.3389177-5-idosch@nvidia.com>

On Tue, Oct 17, 2023 at 10:42:49AM +0300, Ido Schimmel wrote:
> Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a
> reset (i.e., they advertise NoSoftRst-). However, this transition seems
> to have no effect on the device: It continues to be operational and
> network ports remain up. Advertising this support makes it seem as if a
> PM reset is viable for these devices. Mark it as unavailable to skip it
> when testing reset methods.
> 
> Before:
> 
>  # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
>  pm bus
> 
> After:
> 
>  # cat /sys/bus/pci/devices/0000\:03\:00.0/reset_method
>  bus
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Hopefully since these are NVIDIA parts and you work at NVIDIA, this is
stronger than "this transition *seems* to have no effect" :)

The spec actually says NoSoftRst- means internal state is "undefined"
after a D3hot->D0 transition, so preserving it would not be a defect
per spec.  The kernel assumption that NoSoftRst- means the device will
do a reset is perhaps a little too aggressive.

> ---
>  drivers/pci/quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..23f6bd2184e2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3784,6 +3784,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
>  			       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
>  
> +/*
> + * Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a reset
> + * (i.e., they advertise NoSoftRst-). However, this transition seems to have no
> + * effect on the device: It continues to be operational and network ports
> + * remain up. Advertising this support makes it seem as if a PM reset is viable
> + * for these devices. Mark it as unavailable to skip it when testing reset
> + * methods.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcb84, quirk_no_pm_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf6c, quirk_no_pm_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf70, quirk_no_pm_reset);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf80, quirk_no_pm_reset);
> +
>  /*
>   * Thunderbolt controllers with broken MSI hotplug signaling:
>   * Entire 1st generation (Light Ridge, Eagle Ridge, Light Peak) and part
> -- 
> 2.40.1
> 

