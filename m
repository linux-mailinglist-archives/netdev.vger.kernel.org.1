Return-Path: <netdev+bounces-48705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A502D7EF516
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD0D1F24104
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836FF30FA0;
	Fri, 17 Nov 2023 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CImgoJob"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D551C692
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F375C433C8;
	Fri, 17 Nov 2023 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700234521;
	bh=0UKK8vTWjk/9aVzqK03YhqWQKTuR75Y8DkzQmVwxWoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CImgoJobDMWJ6+MtgLWIjxjvgnigKXjCQwc2Vfr0w1tvSdTSHBmx82IY7ZNu92nkS
	 ZwY4eOE80dzJ258usPi24YPFY/HfRJ/Aq8cbcR9qwA/ZEuJpJWwK9VHdrVBFpULTsu
	 yJR6P6iAZDx3kjjYnC8CmU6ycCD37Basr4FxqUkUg0Dh2/quOB+cYjYt/EWIGoRayU
	 gqhCy5d20JtyvL4DhMmgvPx9DXQEzXCQua0+S5TFAqPbYzS+PS0btDYw/QIfEzxqC8
	 LgNukoEGc/q3RiIzA1YBmWpKLzCdo2QUS3jNZC/GVw/l6JR7ajvxel9Iclbnf47SLC
	 vDLccIe/IHX4A==
Date: Fri, 17 Nov 2023 15:21:56 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 07/14] PCI: Add no PM reset quirk for NVIDIA
 Spectrum devices
Message-ID: <20231117152156.GB164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <fe4156c6b9d0f7e8478ae93137586ec88051013d.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4156c6b9d0f7e8478ae93137586ec88051013d.1700047319.git.petrm@nvidia.com>

+ linux-pci@vger.kernel.org

On Wed, Nov 15, 2023 at 01:17:16PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a
> reset (i.e., they advertise NoSoftRst-). However, this transition does
> not have any effect on the device: It continues to be operational and
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
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Thanks,

my understanding is that this matches the use-case for which
quirk_no_pm_reset was introduced.

> ---
>  drivers/pci/quirks.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ea476252280a..d208047d1b8f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3786,6 +3786,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
>  			       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
>  
> +/*
> + * Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a reset
> + * (i.e., they advertise NoSoftRst-). However, this transition does not have
> + * any effect on the device: It continues to be operational and network ports
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
> 2.41.0
> 

