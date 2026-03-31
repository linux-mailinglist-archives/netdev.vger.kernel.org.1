Return-Path: <netdev+bounces-273715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHPhBAYHzGn+NQYAu9opvQ
	(envelope-from <netdev+bounces-273715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:40:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A316836F1B9
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F21CD305BFFD
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8D93D47D7;
	Tue, 31 Mar 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJNXQzHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3493A7F54;
	Tue, 31 Mar 2026 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978462; cv=none; b=ipqGDqR6V/HbyZ1O3Z9xvhWgrghDrm57+hofXKUXA+W7w7cB9h9Bn4ZyzwdzvucgvhwIzgHzjlkTNyVoe66TQcMvrwVMkqN800QEamxQugO1F9pTfRV3A4+qJWG7wDOEz1CwelgVXJq02beZVEeBsXGGFLR6N+F3p+SdOM9dnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978462; c=relaxed/simple;
	bh=O2ovCaGzulr+alJNfIBomcRjjrSaCQ5KJ336Qrdjy88=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DqgTDBwr+daOqUEWNwlN30FUfGmvv+QlzIuWzMr4vSzoCk4WcLW3McJggnMaqHjlqLXDncZhYXHf5JPfaRViod5X250J1c54EbIHTV80yXn2hhZKjZGjNWNLqKnlW7W2HVLo/7TU/Myl3NTKX5AD2/nOM6BOXQuncF1p8wNWr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJNXQzHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A7FC19423;
	Tue, 31 Mar 2026 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774978461;
	bh=O2ovCaGzulr+alJNfIBomcRjjrSaCQ5KJ336Qrdjy88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JJNXQzHM4/3ueMwYJPc+WIYhqdbz1jA81WIj6sie+vX4+x6Eu9D+QuKHAnF2IgCUh
	 CNG+fUs4pKJ/5+OWN5HbDCE6R1d9bUHUouGbLM33Ht+FPIuFxMg6Lo/UKhzheCGDVu
	 eAP06qq9zeQ0xdO+vSNzbL0IltKRoLo53c/5zIm2ptjnfNaxsRh/B3AjYYAyWKrnva
	 PpkgMBmUYVVd6Z0AQqOqrDNJEshtrR9ro9yzQ2a0i3SFJAKlHV9lPUzamFUeypnScg
	 k35H9CMGFikAHaBF3hi4NZZjJNJPTRX35vT2qt35iSWv556+gb2B7NpyvN/0vyFl/u
	 y6Z0SWzw/huJw==
Date: Tue, 31 Mar 2026 12:34:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com,
	dima.ruinskiy@intel.com, mbloch@nvidia.com, leon@kernel.org,
	linux-pci@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	lukas@wunner.de, bhelgaas@google.com, richardcochran@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: Re: [PATCH net-next 02/15] igc: Let the PCI core deal with the PM
 resume flow
Message-ID: <20260331173420.GA143778@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330230248.646900-3-anthony.l.nguyen@intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273715-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,intel.com,nvidia.com,wunner.de,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A316836F1B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 04:02:31PM -0700, Tony Nguyen wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Currently igc driver calls pci_set_power_state() and pci_restore_state()
> and the like to bring the device back from low power states. However,
> PCI core handles all this on behalf of the driver. Furthermore with PTM
> enabled the PCI core re-enables it on resume but the driver calls
> pci_restore_state() which ends up disabling it again.
> 
> For this reason let the PCI core handle the common PM resume flow.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

I love it, thanks a lot for doing this!

> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 98024b46789f..0e785af0a3a3 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7544,9 +7544,6 @@ static int __igc_resume(struct device *dev)
>  	struct igc_hw *hw = &adapter->hw;
>  	u32 err, val;
>  
> -	pci_set_power_state(pdev, PCI_D0);
> -	pci_restore_state(pdev);
> -
>  	if (!pci_device_is_present(pdev))
>  		return -ENODEV;
>  	err = pci_enable_device_mem(pdev);

__igc_shutdown() calls pci_disable_device() in the suspend paths,
which disables bus mastering.  There are only a relative handful of
drivers that do this, mostly for NICs, so I'm not sure if it's really
necessary or if it's been cargo-culted.

Here in the resume path we call pci_enable_device_mem(),
pci_set_master(), and conditionally call pci_disable_link_state().  I
suspect all those are unnecessary because pci_pm_resume() should have
called pci_restore_state() before we get here.

> @@ -7556,9 +7553,6 @@ static int __igc_resume(struct device *dev)
>  	}
>  	pci_set_master(pdev);
>  
> -	pci_enable_wake(pdev, PCI_D3hot, 0);
> -	pci_enable_wake(pdev, PCI_D3cold, 0);
> -
>  	if (igc_is_device_id_i226(hw))
>  		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
>  
> -- 
> 2.47.1
> 

