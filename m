Return-Path: <netdev+bounces-42384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DBB7CE885
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 22:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F78281C17
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16C21EB48;
	Wed, 18 Oct 2023 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMjCaMI9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB8F1EB2C
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 20:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45FDC433C8;
	Wed, 18 Oct 2023 20:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697659708;
	bh=lQXFa8GvRF5Gpf0BOOqxsbqcnxpTVfTyS8mWMgl0qe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FMjCaMI9Voxnjw2OYBhrYkuNwl5lBfiCXSUqSkldqAaIAksh/bQ7dbs1zVaOGI5Am
	 qF8n//4XA0ZfjgWCndMby2rGz+YY1mGSGGyMdGuBQ0hrqOjBb8mUzZkZipeSJ9lklL
	 Jg3Y3MgHStmTola7X+oLCWkn9ImUeCC4H4ffGBk4wcPFzZP96Flkyf6vr2gJEHOxGd
	 qJk4OOP/eLkV4/wz8cd+Uc50zdE2XUnie7DdxCkTFGhWDmPWBa35ur03cOyOj9YcC5
	 JWk/WRUahuM4w9PV0G57sfIKFhWeaotaQugXkPCcVrqAv/J2rzLgQyIqOEyoZ6ys/3
	 lC0q23Txk67hA==
Date: Wed, 18 Oct 2023 15:08:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	bhelgaas@google.com, alex.williamson@redhat.com, lukas@wunner.de,
	petrm@nvidia.com, jiri@nvidia.com, mlxsw@nvidia.com
Subject: Re: [RFC PATCH net-next 05/12] PCI: Add device-specific reset for
 NVIDIA Spectrum devices
Message-ID: <20231018200826.GA1371652@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017074257.3389177-6-idosch@nvidia.com>

On Tue, Oct 17, 2023 at 10:42:50AM +0300, Ido Schimmel wrote:
> The PCIe specification defines two methods to trigger a hot reset across
> a link: Bus reset and link disablement (r6.0.1, sec 7.1, sec 6.6.1). In
> the first method, the Secondary Bus Reset (SBR) bit in the Bridge
> Control Register of the Downstream Port is asserted for at least 1ms
> (r6.0.1, sec 7.5.1.3.13). In the second method, the Link Disable bit in
> the Link Control Register of the Downstream Port is asserted and then
> cleared to disable and enable the link (r6.0.1, sec 7.5.3.7).
> 
> While the two methods are identical from the perspective of the
> Downstream device, they are different as far as the host is concerned.
> In the first method, the Link Training and Status State Machine (LTSSM)
> of the Downstream Port is expected to be in the Hot Reset state as long
> as the SBR bit is asserted. In the second method, the LTSSM of the
> Downstream Port is expected to be in the Disabled state as long as the
> Link Disable bit is asserted.
> 
> This above difference is of importance because the specification
> requires the LTTSM to exit from the Hot Reset state to the Detect state
> within a 2ms timeout (r6.0.1, sec 4.2.7.11).

I don't read 4.2.7.11 quite that way.  Here's the text (from r6.0):

  • Lanes that were directed by a higher Layer to initiate Hot
    Reset:

    ◦ All Lanes in the configured Link transmit TS1 Ordered Sets
      with the Hot Reset bit asserted and the configured Link and
      Lane numbers.

    ◦ If two consecutive TS1 Ordered Sets are received on any
      Lane with the Hot Reset bit asserted and configured Link
      and Lane numbers, then:

      ▪ LinkUp = 0b (False)

      ▪ If no higher Layer is directing the Physical Layer to
        remain in Hot Reset, the next state is Detect

      ▪ Otherwise, all Lanes in the configured Link continue to
	transmit TS1 Ordered Sets with the Hot Reset bit asserted
	and the configured Link and Lane numbers.

    ◦ Otherwise, after a 2 ms timeout next state is Detect.

I assume that SBR being set constitutes a "higher Layer directing the
Physical Layer to remain in Hot Reset," so I would read this as saying
the LTSSM stays in Hot Reset as long as SBR is set.  Then, *after* a
2 ms timeout (not *within* 2 ms), the next state is Detect.

> NVIDIA Spectrum devices cannot guarantee it and a host enforcing
> such a behavior might fail to communicate with the device after
> issuing a Secondary Bus Reset.

I don't quite follow this.  What behavior is the host enforcing here?
I guess you're doing an SBR, and the Spectrum device doesn't respond
as expected afterwards?

It looks like pci_reset_secondary_bus() asserts SBR for at least
2 ms.  Then pci_bridge_wait_for_secondary_bus() should wait before
accessing the device, but maybe we don't wait long enough?

I guess this ends up back at d3cold_delay as suggested by Lukas.

> With the link disablement method, the host can leave the link
> disabled for enough time to allow the device to undergo a hot reset
> and reach the Detect state. After enabling the link, the host will
> exit from the Disabled state to Detect state (r6.0.1, sec 4.2.7.9)
> and observe that the device is already in the Detect state.
> 
> The PCI core only implements the first method, which might not work with
> NVIDIA Spectrum devices on certain hosts, as explained above. Therefore,
> implement the link disablement method as a device-specific method for
> NVIDIA Spectrum devices. Specifically, disable the link, wait for 500ms,
> enable the link and then wait for the device to become accessible.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/pci/quirks.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 23f6bd2184e2..a6e308bb934c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4182,6 +4182,31 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
>  	return 0;
>  }
>  
> +#define PCI_DEVICE_ID_MELLANOX_SPECTRUM		0xcb84
> +#define PCI_DEVICE_ID_MELLANOX_SPECTRUM2	0xcf6c
> +#define PCI_DEVICE_ID_MELLANOX_SPECTRUM3	0xcf70
> +#define PCI_DEVICE_ID_MELLANOX_SPECTRUM4	0xcf80
> +
> +static int reset_mlx(struct pci_dev *pdev, bool probe)
> +{
> +	struct pci_dev *bridge = pdev->bus->self;
> +
> +	if (probe)
> +		return 0;
> +
> +	/*
> +	 * Disable the link on the Downstream port in order to trigger a hot
> +	 * reset in the Downstream device. Wait for 500ms before enabling the
> +	 * link so that the firmware on the device will have enough time to
> +	 * transition the Upstream port to the Detect state.
> +	 */
> +	pcie_capability_set_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
> +	msleep(500);
> +	pcie_capability_clear_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
> +
> +	return pci_bridge_wait_for_secondary_bus(bridge, "link toggle");
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -4197,6 +4222,10 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +	{ PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM, reset_mlx },
> +	{ PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM2, reset_mlx },
> +	{ PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM3, reset_mlx },
> +	{ PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SPECTRUM4, reset_mlx },
>  	{ 0 }
>  };
>  
> -- 
> 2.40.1
> 

