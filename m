Return-Path: <netdev+bounces-40151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD2A7C5F88
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166AD28243E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 21:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BDC354F6;
	Wed, 11 Oct 2023 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAwNFrcl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0B1CF8E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 21:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87540C433C9;
	Wed, 11 Oct 2023 21:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697061209;
	bh=qY9Rp5zkRIt2DsQivgERNNESbVTGEul4kS5s7/dIoho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EAwNFrclnTWEuXdB+Z8mt3u3kuEAAoUwY82PbS8J18XDNC6E3OiHHHxAFbbd17IOO
	 T6KemaFOH4w9WVID23kFc5vCnMeXYebhs7yahyg9gnbxexaaSqR+KOEgoCrxijFWyG
	 dnCiAysL1ttbyJnzXZGaT8aqz/DwQbEhhDfWR38iscslUEL9bLiDHhVjMYSwKPoaYH
	 vE7EY6dncxhXQ4FluROOjHz7swY5mrWHaRm0x+YRj0w+mEnls2n/6+o4Mg69zLynhg
	 wf5HljSZ4OwbmmK2VZKj4KXyrtee/VgZ11v8Vna96PUYyaJ2T6vmKgYUE3ho/7KBKo
	 bDWaoqyCH5pFQ==
Date: Wed, 11 Oct 2023 16:53:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 05/13] PCI/ASPM: Add pci_enable_link_state()
Message-ID: <20231011215327.GA1043654@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918131103.24119-6-ilpo.jarvinen@linux.intel.com>

On Mon, Sep 18, 2023 at 04:10:55PM +0300, Ilpo Järvinen wrote:
> pci_disable_link_state() lacks a symmetric pair. Some drivers want to
> disable ASPM during certain phases of their operation but then
> re-enable it later on. If pci_disable_link_state() is made for the
> device, there is currently no way to re-enable the states that were
> disabled.

pci_disable_link_state() gives drivers a way to disable specified ASPM
states using a bitmask (PCIE_LINK_STATE_L0S, PCIE_LINK_STATE_L1,
PCIE_LINK_STATE_L1_1, etc), but IIUC the driver can't tell exactly
what changed and can't directly restore the original state, e.g.,

  - PCIE_LINK_STATE_L1 enabled initially
  - driver calls pci_disable_link_state(PCIE_LINK_STATE_L0S)
  - driver calls pci_enable_link_state(PCIE_LINK_STATE_L0S)
  - PCIE_LINK_STATE_L0S and PCIE_LINK_STATE_L1 are enabled now

Now PCIE_LINK_STATE_L0S is enabled even though it was not initially
enabled.  Maybe that's what we want; I dunno.

pci_disable_link_state() currently returns success/failure, but only
r8169 and mt76 even check, and only rtl_init_one() (r8169) has a
non-trivial reason, so it's conceivable that it could return a bitmask
instead.

> Add pci_enable_link_state() to remove ASPM states from the state
> disable mask.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h     |  2 ++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 91dc95aca90f..f45d18d47c20 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1117,6 +1117,48 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
>  }
>  EXPORT_SYMBOL(pci_disable_link_state);
>  
> +/**
> + * pci_enable_link_state - Re-enable device's link state
> + * @pdev: PCI device
> + * @state: ASPM link states to re-enable
> + *
> + * Enable device's link state that were previously disable so the link is

"state[s] that were previously disable[d]" alludes to the use case you
have in mind, but I don't think it describes how this function
actually works.  This function just makes it possible to enable the
specified states.  The @state parameter may have nothing to do with
any previously disabled states.

> + * allowed to enter the specific states. Note that if the BIOS didn't grant
> + * ASPM control to the OS, this does nothing because we can't touch the
> + * LNKCTL register.
> + *
> + * Return: 0 or a negative errno.
> + */
> +int pci_enable_link_state(struct pci_dev *pdev, int state)
> +{
> +	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> +
> +	if (!link)
> +		return -EINVAL;
> +	/*
> +	 * A driver requested that ASPM be enabled on this device, but
> +	 * if we don't have permission to manage ASPM (e.g., on ACPI
> +	 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
> +	 * the _OSC method), we can't honor that request.
> +	 */
> +	if (aspm_disabled) {
> +		pci_warn(pdev, "can't enable ASPM; OS doesn't have ASPM control\n");
> +		return -EPERM;
> +	}
> +
> +	mutex_lock(&aspm_lock);
> +	link->aspm_disable &= ~pci_link_state_mask(state);
> +	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> +
> +	if (state & PCIE_LINK_STATE_CLKPM)
> +		link->clkpm_disable = 0;
> +	pcie_set_clkpm(link, policy_to_clkpm_state(link));
> +	mutex_unlock(&aspm_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pci_enable_link_state);
> +
>  /**
>   * pci_set_default_link_state - Set the default device link state
>   * @pdev: PCI device
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3c24ca164104..844d09230264 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1776,11 +1776,13 @@ extern bool pcie_ports_native;
>  int pci_disable_link_state(struct pci_dev *pdev, int state);
>  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
>  #ifdef CONFIG_PCIEASPM
> +int pci_enable_link_state(struct pci_dev *pdev, int state);
>  int pci_set_default_link_state(struct pci_dev *pdev, int state);
>  void pcie_no_aspm(void);
>  bool pcie_aspm_support_enabled(void);
>  bool pcie_aspm_enabled(struct pci_dev *pdev);
>  #else
> +static inline int pci_enable_link_state(struct pci_dev *pdev, int state) { return -EOPNOTSUPP; }
>  static inline int pci_set_default_link_state(struct pci_dev *pdev, int state)
>  { return 0; }
>  static inline void pcie_no_aspm(void) { }
> -- 
> 2.30.2
> 
> 
> -- 
> ath12k mailing list
> ath12k@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/ath12k

