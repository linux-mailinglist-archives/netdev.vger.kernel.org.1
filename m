Return-Path: <netdev+bounces-251800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLjRH/GNcGkaYgAAu9opvQ
	(envelope-from <netdev+bounces-251800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:27:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD32538F9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B113E724DFD
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D7478840;
	Wed, 21 Jan 2026 08:21:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095C44A727
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983716; cv=none; b=flOPSiy2pV91Hp8JKDXAw3JnvSHta31KNz44hOXkftvpydtgce5jwNTEiHvJYFvp+AWPngRhGJTDRXTq0FaG1/9NW7nEFxg7i4fDwMBY+GqS79CzvA6WjPPAJqVmPNK5rKLRYXXmeRL19ByAqm7xMEbwzwJID024XQcJTXBTzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983716; c=relaxed/simple;
	bh=6VoSJVX3L1PH/is+uWV+PCC2WPyoHVpex22Lsinpsho=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hn9Ul+O67wO9/4gVTGlCbpJmzLar629L03uB9x54K8AkI1RXHCs0p43dNeUNmKOPUPMhrsMF2MLymzfGMJqI4Aug3FLeDtPTcv2Uukvk6XzYNLLrWgJC+d2r+UxmHkGL5uTGagW5Y5HqFV3x6MvyibO/acbVONJN/vm3E5vKiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E049133689;
	Wed, 21 Jan 2026 08:21:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B4903EA63;
	Wed, 21 Jan 2026 08:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8K9NDZmMcGm6dwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 21 Jan 2026 08:21:45 +0000
Date: Wed, 21 Jan 2026 09:21:44 +0100
Message-ID: <874iofs7dz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,	Michael Ellerman
 <mpe@ellerman.id.au>,	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,	Alex Deucher
 <alexander.deucher@amd.com>,	Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,	David Airlie <airlied@gmail.com>,	Simona Vetter
 <simona@ffwll.ch>,	"Creeley, Brett" <bcreeley@amd.com>,	Andrew Lunn
 <andrew+netdev@lunn.ch>,	"David S. Miller" <davem@davemloft.net>,	Eric
 Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,	Paolo
 Abeni <pabeni@redhat.com>,	Bjorn Helgaas <bhelgaas@google.com>,	Jaroslav
 Kysela <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Han Gao
 <gaohan@iscas.ac.cn>,	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,	linux-sound@vger.kernel.org,
	linux-riscv@lists.infradead.org,	sophgo@lists.linux.dev
Subject: Re: [PATCH v2 1/4] PCI/MSI: Conservatively generalize no_64bit_msi into msi_addr_mask
In-Reply-To: <20260121-pci-msi-addr-mask-v2-1-f42593168989@iscas.ac.cn>
References: <20260121-pci-msi-addr-mask-v2-0-f42593168989@iscas.ac.cn>
	<20260121-pci-msi-addr-mask-v2-1-f42593168989@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,amd.com,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,perex.cz,suse.com,iscas.ac.cn,lists.ozlabs.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-251800-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,iscas.ac.cn:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: DCD32538F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 04:49:37 +0100,
Vivian Wang wrote:
> 
> Some PCI devices have PCI_MSI_FLAGS_64BIT in the MSI capability, but
> implement less than 64 address bits. This breaks on platforms where such
> a device is assigned an MSI address higher than what's reachable.
> 
> Currently, we deal with this with a single no_64bit_msi flag, and
> (notably on powerpc) forces 32-bit MSI address for these devices.
> However, on some platforms the MSI doorbell address is above 32-bit but
> within device ability.
> 
> As a first step to enabling MSI on those combinations of devices and
> platforms, conservatively generalize the single-bit flag no_64bit_msi
> into msi_addr_mask. (The name msi_addr_mask is chosen to avoid confusion
> with msi_mask.)
> 
> The translation is essentially:
> 
> - no_64bit_msi = 1    ->    msi_addr_mask = DMA_BIT_MASK(32)
> - no_64bit_msi = 0    ->    msi_addr_mask = DMA_BIT_MASK(64)
> - if (no_64bit_msi)   ->    if (msi_addr_mask < DMA_BIT_MASK(64))
> 
> Since no values other than DMA_BIT_MASK(32) and DMA_BIT_MASK(64) is
> used, no functional change is intended. Future patches that make use of
> intermediate values of msi_addr_mask will follow, allowing devices that
> cannot use full 64-bit addresses for MSI to work on platforms with MSI
> doorbell above 32-bit address space.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

For the sound part:

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi


> 
> ---
> 
> v2: Minor rewording. No code changes.
> 
> checkpatch complains about the comment include/linux/pci.h, which I have
> formatted similarly with other comments in the vicinity.
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c           | 2 +-
>  arch/powerpc/platforms/pseries/msi.c                | 4 ++--
>  drivers/gpu/drm/radeon/radeon_irq_kms.c             | 2 +-
>  drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 2 +-
>  drivers/pci/msi/msi.c                               | 2 +-
>  drivers/pci/msi/pcidev_msi.c                        | 2 +-
>  drivers/pci/probe.c                                 | 7 +++++++
>  include/linux/pci.h                                 | 8 +++++++-
>  sound/hda/controllers/intel.c                       | 2 +-
>  9 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index b0c1d9d16fb5..1c78fdfb7b03 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1666,7 +1666,7 @@ static int __pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
>  		return -ENXIO;
>  
>  	/* Force 32-bit MSI on some broken devices */
> -	if (dev->no_64bit_msi)
> +	if (dev->msi_addr_mask < DMA_BIT_MASK(64))
>  		is_64 = 0;
>  
>  	/* Assign XIVE to PE */
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index a82aaa786e9e..7473c7ca1db0 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -383,7 +383,7 @@ static int rtas_prepare_msi_irqs(struct pci_dev *pdev, int nvec_in, int type,
>  	 */
>  again:
>  	if (type == PCI_CAP_ID_MSI) {
> -		if (pdev->no_64bit_msi) {
> +		if (pdev->msi_addr_mask < DMA_BIT_MASK(64)) {
>  			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
>  			if (rc < 0) {
>  				/*
> @@ -409,7 +409,7 @@ static int rtas_prepare_msi_irqs(struct pci_dev *pdev, int nvec_in, int type,
>  		if (use_32bit_msi_hack && rc > 0)
>  			rtas_hack_32bit_msi_gen2(pdev);
>  	} else {
> -		if (pdev->no_64bit_msi)
> +		if (pdev->msi_addr_mask < DMA_BIT_MASK(64))
>  			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSIX_FN, nvec);
>  		else
>  			rc = rtas_change_msi(pdn, RTAS_CHANGE_MSIX_FN, nvec);
> diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> index 9961251b44ba..d550554a6f3f 100644
> --- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> @@ -252,7 +252,7 @@ static bool radeon_msi_ok(struct radeon_device *rdev)
>  	 */
>  	if (rdev->family < CHIP_BONAIRE) {
>  		dev_info(rdev->dev, "radeon: MSI limited to 32-bit\n");
> -		rdev->pdev->no_64bit_msi = 1;
> +		rdev->pdev->msi_addr_mask = DMA_BIT_MASK(32);
>  	}
>  
>  	/* force MSI on */
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 70d86c5f52fb..0671deae9a28 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -331,7 +331,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  #ifdef CONFIG_PPC64
>  	/* Ensure MSI/MSI-X interrupts lie within addressable physical memory */
> -	pdev->no_64bit_msi = 1;
> +	pdev->msi_addr_mask = DMA_BIT_MASK(32);
>  #endif
>  
>  	err = ionic_setup_one(ionic);
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 34d664139f48..48f5f03d1479 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -322,7 +322,7 @@ static int msi_verify_entries(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  
> -	if (!dev->no_64bit_msi)
> +	if (dev->msi_addr_mask == DMA_BIT_MASK(64))
>  		return 0;
>  
>  	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
> diff --git a/drivers/pci/msi/pcidev_msi.c b/drivers/pci/msi/pcidev_msi.c
> index 5520aff53b56..0b0346813092 100644
> --- a/drivers/pci/msi/pcidev_msi.c
> +++ b/drivers/pci/msi/pcidev_msi.c
> @@ -24,7 +24,7 @@ void pci_msi_init(struct pci_dev *dev)
>  	}
>  
>  	if (!(ctrl & PCI_MSI_FLAGS_64BIT))
> -		dev->no_64bit_msi = 1;
> +		dev->msi_addr_mask = DMA_BIT_MASK(32);
>  }
>  
>  void pci_msix_init(struct pci_dev *dev)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 41183aed8f5d..a2bff57176a3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2047,6 +2047,13 @@ int pci_setup_device(struct pci_dev *dev)
>  	 */
>  	dev->dma_mask = 0xffffffff;
>  
> +	/*
> +	 * Assume 64-bit addresses for MSI initially. Will be changed to 32-bit
> +	 * if MSI (rather than MSI-X) capability does not have
> +	 * PCI_MSI_FLAGS_64BIT. Can also be overridden by driver.
> +	 */
> +	dev->msi_addr_mask = DMA_BIT_MASK(64);
> +
>  	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
>  		     dev->bus->number, PCI_SLOT(dev->devfn),
>  		     PCI_FUNC(dev->devfn));
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..0fe32fef0331 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -377,6 +377,13 @@ struct pci_dev {
>  					   0xffffffff.  You only need to change
>  					   this if your device has broken DMA
>  					   or supports 64-bit transfers.  */
> +	u64		msi_addr_mask;	/* Mask of the bits of bus address for
> +					   MSI that this device implements.
> +					   Normally set based on device
> +					   capabilities. You only need to
> +					   change this if your device claims
> +					   to support 64-bit MSI but implements
> +					   fewer than 64 address bits. */
>  
>  	struct device_dma_parameters dma_parms;
>  
> @@ -441,7 +448,6 @@ struct pci_dev {
>  
>  	unsigned int	is_busmaster:1;		/* Is busmaster */
>  	unsigned int	no_msi:1;		/* May not use MSI */
> -	unsigned int	no_64bit_msi:1;		/* May only use 32-bit MSIs */
>  	unsigned int	block_cfg_access:1;	/* Config space access blocked */
>  	unsigned int	broken_parity_status:1;	/* Generates false positive parity */
>  	unsigned int	irq_reroute_variant:2;	/* Needs IRQ rerouting variant */
> diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
> index 1e8e3d61291a..c9542ebdf7e2 100644
> --- a/sound/hda/controllers/intel.c
> +++ b/sound/hda/controllers/intel.c
> @@ -1905,7 +1905,7 @@ static int azx_first_init(struct azx *chip)
>  
>  	if (chip->msi && chip->driver_caps & AZX_DCAPS_NO_MSI64) {
>  		dev_dbg(card->dev, "Disabling 64bit MSI\n");
> -		pci->no_64bit_msi = true;
> +		pci->msi_addr_mask = DMA_BIT_MASK(32);
>  	}
>  
>  	pci_set_master(pci);
> 
> -- 
> 2.52.0
> 

